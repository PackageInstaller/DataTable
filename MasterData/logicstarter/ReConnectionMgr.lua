-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicstarter/starter/reconnection/ReConnectionMgr.lua

module("logicstarter.starter.ReConnectionMgr", package.seeall)

local ReConnectionMgr = class("ReConnectionMgr")

function ReConnectionMgr:ctor()
	self._isReconnecting = false
	self._reconnectTryTime = 0
	self._reconnectInstantTime = 3
	self._reconnectInterval = 2
	self._isConnected = false
	self._lostTooLongTime = 30
	self._disconnectTime = 0
	self._downTag = 0
	self._backingToLogin = false
end

function ReConnectionMgr:init()
	NetConnMgr.instance:setConnectCallback(ConnectionType.Logic, self._onNetConnectDone, self)
	NetConnMgr.instance:setDisConnectCallback(ConnectionType.Logic, self._onNetDisconnect, self)
end

function ReConnectionMgr:isConnected()
	return self._isConnected
end

function ReConnectionMgr:isReconnecting()
	return self._isReconnecting
end

function ReConnectionMgr:isBackingToLogin()
	return self._backingToLogin
end

function ReConnectionMgr:addDisconnectCallback(onNetDisconnect, onNetDisconnectTgt)
	self._onNetDisconnectCallback = onNetDisconnect
	self._onNetDisconnectCallbackObj = onNetDisconnectTgt
end

function ReConnectionMgr:promptAndReturnToLogin(tipKey, tipValue)
	forcePrint("ReConnectionMgr:promptAndReturnToLogin,tipKey=", tipKey)
	WaitingView.instance:hideAll()
	GlobalModel.instance:resetUINodes()
	LoadingFacade.instance:closeLoading()
	GameUtil.resetClickEnabled()
	ViewMgr.instance:close(ViewName.NoticeView)

	self._reconnectTryTime = 0
	self._isReconnecting = false

	NetConnMgr.instance:disbale()
	ViewMgr.instance:setPermanent(ViewName.Popupwindow, true)
	TipsFacade.instance:openTipWindowNoX(lang(tipKey), lang(tipValue), function()
		ViewMgr.instance:setPermanent(ViewName.Popupwindow)
		self:_onComfirmReturn()
	end, lang("tip_login_relogin"))
end

function ReConnectionMgr:_onComfirmReturn()
	self:returnToLogin()
end

function ReConnectionMgr:returnToLogin()
	forcePrint("ReConnectionMgr:returnToLogin,returnToLogin")

	self._backingToLogin = true

	GlobalModel.instance.gameStart:SetActive(true)
	removetimer(self._doreconnect, self)

	if SceneMainPlayer.instance then
		SceneMainPlayer.instance:destroyMainPlayer()
	end

	SurveyController.instance:stopTick()
	PetDisplayModel.instance:ClearList()
	NewChatModel.instance:saveLocalStore()
	GMController.instance:showGM(false)
	ViewMgr.instance:closeAllViews()
	UIStateManager.instance:clear(false)
	ViewMgr.instance:destroy(ViewName.MainUI)
	SceneFacade.instance:forceExit()
	ExtensionMgr.instance:resetAllExtensions()
	RoleDataRequestor.instance:stop()
	NetConnMgrExt.markHeartBeatRespont()
	ResGcMgr.instance:gc()
	WaitingView.instance:hideAll()
	ViewBlockMgr.instance:cancelAll()
	LoadingFacade.instance:closeLoading()
	NetConnMgr.instance:enabled()
	ViewMgr.instance:open(ViewName.Login)
	MsgFlowMgr.instance:clearBlockMsg()

	self._backingToLogin = false
end

function ReConnectionMgr:_onNetConnectDone(socketType, isConnected, innerMode)
	if isConnected then
		MsgFlowMgr.instance:onNetConnected()

		self._isConnected = true
	end

	if not innerMode then
		GlobalDispatcher:dispatch(GlobalNotify.NetConnected, isConnected)
	end

	if self._isReconnecting then
		if isConnected then
			self._downTag = MsgFlowMgr.instance:getCurDownTag()

			GlobalDispatcher:addListener(GlobalNotify.RoleLogined, self._onRoleLogined, self)
			LoginAgent.instance:sendLoginRequest(LoginModel.instance.socketAccount, LoginModel.instance.socketPassword, false)
		else
			local now = os.time()

			if self._disconnectTime > 0 and now - self._disconnectTime > self._lostTooLongTime then
				forcePrint(LogTag.NETWORK, "don't try to reconnect,lost too long,disconnect time&now=", self._disconnectTime, now)
				self:promptAndReturnToLogin("tip", "tip_network_disconnect")
			else
				self:_reconnect()
			end
		end
	end
end

function ReConnectionMgr:_onRoleLogined(isSucc)
	forcePrint(LogTag.NETWORK, "ReConnectionMgr:_onRoleLogined", isSucc)

	if isSucc then
		GlobalDispatcher:removeListener(GlobalNotify.RoleLogined, self._onRoleLogined, self)
		RoleFacade.instance:startSyncTime(false)
		RoleDataRequestor.instance:resume()
		SurveyController.instance:startTick()
		GlobalDispatcher:addListener(GlobalNotify.GetLostCmdStart, self._onGetLostCmdStart, self)
		GlobalDispatcher:addListener(GlobalNotify.GetLostCmdEnd, self._onGetLostCmdEnd, self)
		LoginAgent.instance:sendGetLostCmdRespRequest(self._downTag)
		GlobalDispatcher:dispatch(GlobalNotify.ReconnectLogined)
	else
		GlobalDispatcher:removeListener(GlobalNotify.RoleLogined, self._onRoleLogined, self)

		LoginModel.instance.disconnectFlag = GameEnum.DisconnectFlag_ReLoginFail

		NetConnMgr.instance:disconnect(ConnectionType.Logic)
	end
end

function ReConnectionMgr:_onGetLostCmdStart(msg)
	forcePrint(LogTag.NETWORK, "ReConnectionMgr:_onGetLostCmdStart")
	GlobalDispatcher:removeListener(GlobalNotify.GetLostCmdStart, self._onGetLostCmdStart, self)
	MsgFlowMgr.instance:startListenLostMsg()
	WaitingView.instance:setTips("tip_waiting_getlost")
end

function ReConnectionMgr:_onGetLostCmdEnd(msg)
	forcePrint(LogTag.NETWORK, "ReConnectionMgr:_onGetLostCmdEnd,msg.canGet=", msg.canGet)
	GlobalDispatcher:removeListener(GlobalNotify.GetLostCmdEnd, self._onGetLostCmdEnd, self)

	if not msg.canGet then
		LoginModel.instance.disconnectFlag = GameEnum.DisconnectFlag_GetLostFail

		NetConnMgr.instance:disconnect(ConnectionType.Logic)
	else
		WaitingView.instance:hide(WaitingView.Flag_BlockMsg)

		self._isReconnecting = false
		self._reconnectTryTime = 0

		MsgFlowMgr.instance:stopListenLostMsg()
		MsgFlowMgr.instance:onReconnectSucc()
		GlobalDispatcher:dispatch(GlobalNotify.ReconnectSucc)
	end
end

function ReConnectionMgr:_onNetDisconnect(socketType)
	RoleDataRequestor.instance:stop()
	SurveyController.instance:stopTick()
	RoleFacade.instance:stopSyncTime()

	self._isConnected = false

	MsgFlowMgr.instance:onNetDisConnected()
	GlobalDispatcher:dispatch(GlobalNotify.NetDisconnected)
	forcePrint(LogTag.NETWORK, "ReConnectionMgr:_onNetDisconnect,disconnectFlag=", LoginModel.instance.disconnectFlag)

	if LoginModel.instance.disconnectFlag == GameEnum.DisconnectFlag_GetLostFail then
		self:promptAndReturnToLogin("tip", "tip_network_disconnect")
	elseif LoginModel.instance.disconnectFlag == GameEnum.DisconnectFlag_ReLoginFail then
		self:promptAndReturnToLogin("tip", "tip_login_fail")
	elseif LoginModel.instance.disconnectFlag == GameEnum.DisconnectFlag_RepeatLogin then
		self:promptAndReturnToLogin("tip", "tip_login_otherdevice")
	elseif LoginModel.instance.disconnectFlag == GameEnum.DisconnectFlag_IdleTimeout then
		self:promptAndReturnToLogin("tip", "tip_login_fail")
	elseif LoginModel.instance.disconnectFlag == GameEnum.DisconnectFlag_ServerShutdown then
		self:promptAndReturnToLogin("tip", "tip_login_servershutdown")
	elseif LoginModel.instance.disconnectFlag == GameEnum.DisconnectFlag_ServerMaintain then
		self:promptAndReturnToLogin("tip", "tip_login_servershutdown")
	elseif LoginModel.instance.disconnectFlag == GameEnum.DisconnectFlag_Kickout then
		forcePrint("ReConnectionMgr:promptAndReturnToLogin,tipKey=", tipKey)
		WaitingView.instance:hideAll()
		LoadingFacade.instance:closeLoading()

		self._reconnectTryTime = 0
		self._isReconnecting = false

		NetConnMgr.instance:disbale()

		local content = "账号可能涉嫌违规操作或者存在数据问题，您将被强制下线，如有疑问请联系官方客服"

		TipsFacade.instance:openTipWindowNoX(lang("tip"), content, function()
			self:_onComfirmReturn()
		end, lang("tip_login_relogin"))
	elseif LoginModel.instance.disconnectFlag == GameEnum.DisconnectFlag_LogoutSuccess then
		WaitingView.instance:hideAll()
		LoadingFacade.instance:closeLoading()

		self._reconnectTryTime = 0
		self._isReconnecting = false

		SDKManager.logout()

		if Framework.OSDef.isEditor or SDKManager.isMuMu() then
			LoginController.instance:disconnect(function()
				self:returnToLogin()
			end)
		end
	elseif LoginModel.instance.disconnectFlag == GameEnum.DisconnectFlag_LoginRateLimit then
		self:promptAndReturnToLogin("tip", "tip_login_servershutdown")
	elseif LoginModel.instance.disconnectFlag == GameEnum.DisconnectFlag_ServerFull then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), BootstrapLanguage.a40, nil, lang("tip_login_relogin"))
	elseif LoginModel.instance.disconnectFlag == GameEnum.DisconnectFlag_ServerNotInService then
		self:promptAndReturnToLogin("tip", "tip_login_servershutdown")
	elseif LoginModel.instance.disconnectFlag == GameEnum.DisconnectFlag_Anti_Error then
		local antiMsg = LoginModel.instance.antiReason

		if antiMsg then
			self:promptAndReturnToLogin(antiMsg.title, antiMsg.msg)
		else
			self:promptAndReturnToLogin("tip", "tip_login_sdkloginfail")
		end
	elseif LoginModel.instance.disconnectFlag == GameEnum.DisconnectFlag_Qudao_Del_Role then
		self:promptAndReturnToLogin("tip", "zhuxiao_popup_6")
	elseif self._onNetDisconnectCallback then
		local callback = self._onNetDisconnectCallback
		local callbackObj = self._onNetDisconnectCallbackObj

		self:addDisconnectCallback()

		if callbackObj then
			self._onNetDisconnectCallback(callbackObj)
		else
			callback()
		end
	elseif LoginModel.instance.sessionId and LoginFacade.instance:isSceneLoaded() then
		self:_reconnect()
	else
		self:promptAndReturnToLogin("tip", "tip_network_disconnect")
	end

	LoginModel.instance.disconnectFlag = GameEnum.DisconnectFlag_Net
end

function ReConnectionMgr:_reconnect()
	if not self._isReconnecting then
		self._isReconnecting = true
		self._reconnectTryTime = 0
		self._disconnectTime = os.time()

		MsgFlowMgr.instance:onReconnectStart()
		WaitingView.instance:show("tip_waiting_reconnect", WaitingView.Flag_BlockMsg)
	end

	self._reconnectTryTime = self._reconnectTryTime + 1

	forcePrint(LogTag.NETWORK, "ReConnectionMgr:_reconnect(),reconnectTryTime=", self._reconnectTryTime)

	if self._reconnectTryTime > self._reconnectInstantTime then
		settimer(self._reconnectInterval, self._doreconnect, self, false)
	else
		settimer(0.5, self._doreconnect, self, false)
	end
end

function ReConnectionMgr:_doreconnect()
	local bRet = NetConnMgr.instance:connect(LoginModel.instance.serverIp, LoginModel.instance.serverPort, ConnectionType.Logic)

	if not bRet then
		self:_onNetConnectDone(ConnectionType.Logic, false, true)
	end
end

ReConnectionMgr.instance = ReConnectionMgr.New()

return ReConnectionMgr
