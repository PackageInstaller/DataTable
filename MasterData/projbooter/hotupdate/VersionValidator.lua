-- chunkname: @projbooter/hotupdate/VersionValidator.lua

module("projbooter.hotupdate.VersionValidator", package.seeall)

local VersionValidator = class("VersionValidator")

function VersionValidator:ctor()
	self._isInReview = false
	self._eventMgr = SLFramework.GameUpdate.HotUpdateEvent
	self._eventMgrInst = SLFramework.GameUpdate.HotUpdateEvent.Instance
end

function VersionValidator:isInReviewing()
	return self._isInReview
end

function VersionValidator:start(finishCb, finishObj)
	if GameResMgr.IsFromEditorDir then
		if finishCb then
			if finishObj then
				finishCb(finishObj)
			else
				finishCb()
			end
		end

		return
	end

	if finishCb then
		self._finishCb = finishCb
		self._finishObj = finishObj

		self._eventMgrInst:AddLuaLisenter(self._eventMgr.GetRemoteVersionFail, self._onGetRemoteVersionFail, self)
		self._eventMgrInst:AddLuaLisenter(self._eventMgr.GetRemoteVersionSuccess, self._onGetRemoteVersionSuccess, self)
	end

	local formalDomain, backupDomain = GameUrlConfig.getHotUpdateUrl()
	local domain = HotUpdateMgr.instance:getUseBackup() and backupDomain or formalDomain
	local gameId = SDKMgr.instance:getGameId()
	local osType = SLFramework.FrameworkSettings.CurPlatform

	if SLFramework.FrameworkSettings.IsEditor then
		osType = 0
	end

	if GameConfig.Instance.IsMuMu then
		osType = 5
	end

	local channelId = SDKMgr.instance:getChannelId()
	local resVersion = SLFramework.GameUpdate.HotUpdateInfoMgr.LocalResVersionStr
	local appVersion = tonumber(BootNativeUtil.getAppVersion())
	local packageName = BootNativeUtil.getPackageName()
	local subChannelId = SDKMgr.instance:getSubChannelId()

	logNormal("subChannelId = " .. subChannelId)
	logNormal("domain = " .. domain .. " gameId = " .. gameId .. " osType = " .. osType .. " channelId = " .. channelId .. " resVersion = " .. resVersion .. " appVersion = " .. appVersion .. " packageName = " .. packageName .. " subChannelId = " .. subChannelId)

	local serverType = GameChannelConfig.getServerType()

	self._eventMgrInst:CheckVersion(domain, gameId, osType, channelId, serverType, resVersion, appVersion, packageName, subChannelId)
end

function VersionValidator:_onRetryCountOver(errorInfo)
	local args = {}

	args.title = booterLang("version_validate")
	args.content = booterLang("version_validate_fail") .. errorInfo
	args.leftMsg = booterLang("exit")
	args.leftCb = self._quitGame
	args.leftCbObj = self
	args.rightMsg = booterLang("retry")
	args.rightCb = self._retry
	args.rightCbObj = self

	BootMsgBox.instance:show(args)
end

function VersionValidator:_quitGame()
	logNormal("重试超过了 " .. HotUpdateMgr.FailAlertCount .. " 次，点击了退出按钮！")
	ProjBooter.instance:quitGame()
end

function VersionValidator:_retry()
	logNormal("重试超过了 " .. HotUpdateMgr.FailAlertCount .. " 次，点击了重试按钮！")
	self:start()
	HotUpdateMgr.instance:showConnectTips()
end

function VersionValidator:_onGetRemoteVersionSuccess(version, inReview, loginUrl, envType, requestUrl)
	local domain = HotUpdateMgr.instance:getDomainUrl()

	SDKDataTrackMgr.instance:trackDomainFailCount("scene_hotupdate_versioncheck", domain, HotUpdateMgr.instance:getFailCount())
	HotUpdateMgr.instance:resetFailCount()
	logNormal("版本检查 _onGetRemoteVersionSuccess version = " .. version .. " inReview = " .. tostring(inReview) .. " loginUrl = " .. loginUrl .. " envType = " .. envType)
	SDKDataTrackMgr.instance:trackGetRemoteVersionEvent(SDKDataTrackMgr.RequestResult.success, requestUrl)

	self._isInReview = inReview

	if self._finishCb then
		self._eventMgrInst:ClearLuaListener()
		self._finishCb(self._finishObj, version, inReview, loginUrl, envType)

		self._finishCb = nil
		self._finishObj = nil
	end
end

function VersionValidator:_onGetRemoteVersionFail(errorInfo, responseCode, requestUrl)
	logNormal("版本检查 _onGetRemoteVersionFail errorInfo = " .. errorInfo)
	SDKDataTrackMgr.instance:trackGetRemoteVersionEvent(SDKDataTrackMgr.RequestResult.fail, requestUrl, responseCode, errorInfo)
	HotUpdateMgr.instance:inverseUseBackup()
	HotUpdateMgr.instance:incFailCount()

	if HotUpdateMgr.instance:isFailNeedAlert() then
		HotUpdateMgr.instance:resetFailAlertCount()
		self:_onRetryCountOver(errorInfo)
		BootLoadingView.instance:setProgressMsg("")

		return
	end

	self:start()
	HotUpdateMgr.instance:showConnectTips()
end

VersionValidator.instance = VersionValidator.New()

return VersionValidator
