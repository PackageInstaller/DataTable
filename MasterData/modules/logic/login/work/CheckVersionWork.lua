-- chunkname: @modules/logic/login/work/CheckVersionWork.lua

module("modules.logic.login.work.CheckVersionWork", package.seeall)

local CheckVersionWork = class("CheckVersionWork", BaseWork)
local Interval = 5
local lastRequestTime

function CheckVersionWork:ctor(tryCallBack, tryCallBackObj)
	self._tryCallBack = tryCallBack
	self._tryCallBackObj = tryCallBackObj
end

function CheckVersionWork:onStart(context)
	if GameResMgr.IsFromEditorDir or not GameConfig.CanHotUpdate then
		self:onDone(true)
	elseif lastRequestTime and Time.time - lastRequestTime < Interval then
		self:onDone(true)
	else
		lastRequestTime = Time.time
		self._maxRetryCount = 2
		self._curRetryCount = 0
		self._failCount = 0

		self._start(self, self._onCheckVersion, self)
	end
end

function CheckVersionWork:_onCheckVersion(latestVersion, inReviewing, loginServerUrl, envType)
	UIBlockMgr.instance:endBlock("LoginCheckVersion")

	if BootNativeUtil.isIOS() and inReviewing or SLFramework.GameUpdate.HotUpdateInfoMgr.IsLatestVersion then
		self:onDone(true)
	else
		self:onDone(false)
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.NewGameVersion, MsgBoxEnum.BoxType.Yes, function()
			if BootNativeUtil.isAndroid() then
				if SDKMgr.restartGame ~= nil then
					SDKMgr.instance:restartGame()
				else
					ProjBooter.instance:quitGame()
				end
			else
				ProjBooter.instance:quitGame()
			end
		end)
	end
end

function CheckVersionWork:_start(finishCb, finishObj)
	UIBlockMgr.instance:startBlock("LoginCheckVersion")

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

function CheckVersionWork:_onRetryCountOver(errorInfo)
	UIBlockMgr.instance:endBlock("LoginCheckVersion")
	MessageBoxController.instance:showSystemMsgBoxAndSetBtn(MessageBoxIdDefine.CheckVersionFail, MsgBoxEnum.BoxType.Yes_No, booterLang("retry"), "retry", booterLang("exit"), "exit", self._retry, self._quitGame, nil, self, self, nil, errorInfo)
end

function CheckVersionWork:_quitGame()
	logNormal("重试超过了 " .. self._maxRetryCount .. " 次，点击了退出按钮！")
	ProjBooter.instance:quitGame()
end

function CheckVersionWork:_retry()
	logNormal("重试超过了 " .. self._maxRetryCount .. " 次，点击了重试按钮！")

	if self._tryCallBack then
		self._tryCallBack(self._tryCallBackObj)
	else
		self:_start()
	end
end

function CheckVersionWork:_onGetRemoteVersionSuccess(version, inReview, loginUrl, envType, requestUrl)
	if self._failCount > 0 then
		local formalDomain, backupDomain = GameUrlConfig.getHotUpdateUrl()
		local domain = LoginModel.instance:getUseBackup() and backupDomain or formalDomain

		StatController.instance:track(StatEnum.EventName.EventHostSwitch, {
			[StatEnum.EventProperties.GameScene] = "scene_hotupdate_versioncheck",
			[StatEnum.EventProperties.CurrentHost] = domain,
			[StatEnum.EventProperties.SwitchCount] = self._failCount
		})

		self._failCount = 0
	end

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

function CheckVersionWork:_onGetRemoteVersionFail(errorInfo, responseCode, requestUrl)
	logNormal("版本检查 _onGetRemoteVersionFail errorInfo = " .. errorInfo)
	SDKDataTrackMgr.instance:trackGetRemoteVersionEvent(SDKDataTrackMgr.RequestResult.fail, requestUrl, responseCode, errorInfo)
	LoginModel.instance:inverseUseBackup()

	if self._failCount then
		self._failCount = self._failCount + 1 or 1
	end

	if self._curRetryCount >= self._maxRetryCount then
		self._curRetryCount = 0

		self:_onRetryCountOver(errorInfo)
		UIBlockMgrExtend.instance:setTips()
	else
		self._curRetryCount = self._curRetryCount + 1

		self:_start()
		UIBlockMgrExtend.instance:setTips(LoginModel.instance:getFailCountBlockStr(self._curRetryCount))
	end
end

function CheckVersionWork:clearWork()
	if self._eventMgrInst then
		self._eventMgrInst:ClearLuaListener()
	end

	UIBlockMgr.instance:endBlock("LoginCheckVersion")
end

return CheckVersionWork
