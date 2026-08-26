-- chunkname: @modules/logic/hotfix/work/RuntimeCheckVersionWork.lua

module("modules.logic.hotfix.work.RuntimeCheckVersionWork", package.seeall)

local RuntimeCheckVersionWork = class("RuntimeCheckVersionWork", BaseWork)

function RuntimeCheckVersionWork:ctor(tryCallBack, tryCallBackObj)
	self._tryCallBack = tryCallBack
	self._tryCallBackObj = tryCallBackObj
end

function RuntimeCheckVersionWork:onStart(context)
	if GameResMgr.IsFromEditorDir or not GameConfig.CanHotUpdate then
		self:onDone(true)
	else
		self._start(self, self._onCheckVersion, self)
	end
end

RuntimeCheckVersionWork.UIBLOCK_KEY = "RuntimeCheckVersionWork"

function RuntimeCheckVersionWork:_onCheckVersion(latestVersion, inReviewing, loginServerUrl, envType, forceUpdate)
	UIBlockMgr.instance:endBlock(RuntimeCheckVersionWork.UIBLOCK_KEY)

	if BootNativeUtil.isIOS() and inReviewing or SLFramework.GameUpdate.HotUpdateInfoMgr.IsLatestVersion or not forceUpdate then
		self:onDone(true)
	else
		self:onDone(false)
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.RuntimeCheckVersionHotfix, MsgBoxEnum.BoxType.Yes, self.restartGame, nil, nil, self)
	end
end

function RuntimeCheckVersionWork:restartGame()
	if BootNativeUtil.isAndroid() then
		if SDKMgr.restartGame ~= nil then
			SDKMgr.instance:restartGame()
		else
			ProjBooter.instance:quitGame()
		end
	else
		ProjBooter.instance:quitGame()
	end
end

function RuntimeCheckVersionWork:_start(finishCb, finishObj)
	UIBlockMgr.instance:startBlock(RuntimeCheckVersionWork.UIBLOCK_KEY)

	self._eventMgr = SLFramework.GameUpdate.HotUpdateEvent
	self._eventMgrInst = SLFramework.GameUpdate.HotUpdateEvent.Instance

	if finishCb then
		self._finishCb = finishCb
		self._finishObj = finishObj

		self._eventMgrInst:AddLuaLisenter(self._eventMgr.GetRemoteVersionFail, self._onGetRemoteVersionFail, self)
		self._eventMgrInst:AddLuaLisenter(self._eventMgr.GetRemoteVersionSuccess, self._onGetRemoteVersionSuccess, self)
	end

	local formalDomain, backupDomain = GameUrlConfig.getHotUpdateUrl()
	local domain = LoginModel.instance:getUseBackup() and backupDomain or formalDomain
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

function RuntimeCheckVersionWork:_onRetryCountOver(errorInfo)
	UIBlockMgr.instance:endBlock(RuntimeCheckVersionWork.UIBLOCK_KEY)
	self:onDone(false)
end

function RuntimeCheckVersionWork:_onGetRemoteVersionSuccess(version, inReview, loginUrl, envType, requestUrl, forceUpdate)
	LoginModel.instance:resetFailCount()
	logNormal("版本检查 _onGetRemoteVersionSuccess version = " .. version .. " inReview = " .. tostring(inReview) .. " loginUrl = " .. loginUrl .. " envType = " .. envType .. ", forceUpdate = " .. tostring(forceUpdate))

	self._isInReview = inReview

	if self._finishCb then
		self._eventMgrInst:ClearLuaListener()
		self._finishCb(self._finishObj, version, inReview, loginUrl, envType, forceUpdate)

		self._finishCb = nil
		self._finishObj = nil
	end
end

function RuntimeCheckVersionWork:_onGetRemoteVersionFail(errorInfo, responseCode, requestUrl)
	logNormal("版本检查 _onGetRemoteVersionFail errorInfo = " .. errorInfo)
	LoginModel.instance:inverseUseBackup()
	LoginModel.instance:incFailCount()

	if LoginModel.instance:isFailNeedAlert() then
		LoginModel.instance:resetFailAlertCount()
		self:_onRetryCountOver(errorInfo)
	else
		self:_start()
	end
end

function RuntimeCheckVersionWork:clearWork()
	if self._eventMgrInst then
		self._eventMgrInst:ClearLuaListener()
	end

	UIBlockMgr.instance:endBlock(RuntimeCheckVersionWork.UIBLOCK_KEY)
end

return RuntimeCheckVersionWork
