-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/controller/LoginReconnectHandler.lua

module("logic.extensions.login.controller.LoginReconnectHandler", package.seeall)

local M = class("LoginReconnectHandler", INetReconnectionListener)

function M:ctor(controller)
	self._controller = controller
end

function M:onInit()
	local config = NetReconnectionConfig.genConfig(ConnectionType.Logic)

	self._isGameRequestorTriggered = false
	self._reconnection = NetReconnection.New(config, self)

	GlobalDispatcher:addEventListener(EventType.LOGIN_CONNECT_SERVER_DONE_EVENT, self._connectServerDone, self)
	GlobalDispatcher:addEventListener(EventType.LOGIN_CONNECT_SERVER_EVENT, self.connect, self)
	GlobalDispatcher:addEventListener(EventType.ENTER_GAME_REQUEST_OVER_EVENT, self._dealEnterGameRequestOver, self)
end

function M:onReset()
	self._isGameRequestorTriggered = false
end

function M:connect()
	local ip, port = LoginModel.instance:getServerIPAndPort()
	local hostPorts = LoginModel.instance:getHostPorts()

	ip = Astral.NetworkManager.Instance:DNSToIp(ip)

	if string.nilorempty(ip) then
		if enableErrorLog then
			printError("dns to ip failed!")

			local dialog = Dialog.showNotifyMessage(lang("tip_login_fail"), lang("tip_login_connectwebfail"))

			dialog:setConfirmButtonText(lang("tip_common_sure"))
			dialog:setConfirmListener(self.connect, self)
		end

		return
	end

	LoginController.instance:clearReturnToLogin()
	self._reconnection:connect(ip, port, hostPorts)
end

function M:connectNewHost()
	if self._reconnection then
		LoginController.instance:clearReturnToLogin()

		return self._reconnection:connectNewHost()
	end

	return false
end

function M:hasNewHost()
	return self._reconnection and self._reconnection:hasNewHost()
end

function M:isConnected()
	return self._reconnection:isConnected()
end

function M:handleForceLogout()
	self._reconnection:clear()
	removetimer(self._onTick, self)
end

function M:onLoginFinished(isSuccess, isReconnecting, status)
	if isSuccess then
		if EditorDebugSetting.isEnableTick() then
			settimer(3, self._onTick, self, true)
		end

		local ip, port = LoginModel.instance:getServerIPAndPort()
		local gameId = SDKManager.getSDKInstacne():getGameId()

		Netkit.trackSocketData(100, Netkit.EventId.Socket[1], Netkit.EventId.Socket[2], gameId, tostring(PlayerModel.instance:getId()), tostring(ip), 100, 100)
	else
		self._reconnection:clear()

		local errorMsg = string.format("%s(login failed reason:%s)", lang("tip_ask_relogin"), status)

		self:_showReturnToLoginDialog(errorMsg)

		local ip, port = LoginModel.instance:getServerIPAndPort()
		local gameId = SDKManager.getSDKInstacne():getGameId()

		Netkit.trackSocketData(100, Netkit.EventId.SocketFail[1], Netkit.EventId.SocketFail[2], gameId, tostring(PlayerModel.instance:getId()), tostring(ip), 100, 100)
	end
end

function M:onBlockCountChanged(blockCount)
	if enableLog then
		printInfo("onBlockCountChanged", blockCount)
	end

	if blockCount > 0 then
		LoadingFacade.instance:showWaiting()
	else
		LoadingFacade.instance:hideWaiting()
	end
end

function M:onReconnectStarted()
	removetimer(self._onTick, self)
	LoadingFacade.instance:showWaiting(false, true)
end

function M:onReconnectSucceeded()
	local blockCount = self._reconnection:getBlockCount()

	self:onBlockCountChanged(blockCount)
end

function M:onReconnectTimeout()
	local dialog = Dialog.showMessage(lang("tip_reconnect_fail"), lang("tip_ask_reconnect"))

	dialog:setConfirmListener(self._onClickReconnect, self)
	dialog:setCancelListener(self._onClickReturnToLogin, self)
	dialog:setCloseListener(self._onClickReturnToLogin, self)
end

function M:onReconnectCanceled(status)
	removetimer(self._onTick, self)
	self._reconnection:clear()

	local errorMsg = string.format("%s(canceled reason:%s)", lang("tip_ask_relogin"), status or "reconnect disabled")

	self:_showReturnToLoginDialog(errorMsg)
end

function M:_onTick()
	UserAgent.instance:sendGetServerTimeRequest()
end

function M:_onClickReconnect()
	self._reconnection:forceReconnect()
end

function M:_onClickReturnToLogin()
	self._controller:_onClickReturnToLogin()
end

function M:clear()
	self._reconnection:clear()
end

function M:_showReturnToLoginDialog(contentText)
	self._controller:showReturnToLoginDialog(contentText)
end

function M:_connectServerDone(e, isSuccess)
	if isSuccess and not self._isGameRequestorTriggered then
		self._isGameRequestorTriggered = true

		StartGameRequestor.instance:start()
	end
end

function M:onNetConnected(isSuccess, isReconnecting)
	if isSuccess then
		LoginAgent.instance:sendLoginRequest(isReconnecting)
	end
end

function M:onNetDisconnected(isReconnecting)
	return
end

function M:setIsInEnterGame(isEnter)
	self._isEnteringGame = isEnter
end

function M:_dealEnterGameRequestOver(e, isSuccess)
	if isSuccess and self._isEnteringGame then
		self._isEnteringGame = false

		SceneFace.instance:onInit()

		local isFinish = PlayerModel.instance:getPrologueFinished()

		print("当前序章是否完成", isFinish)

		if isFinish then
			ViewMgr.instance:preCreate(ViewName.ScenePicker)
			ViewMgr.instance:preCreate(ViewName.MainUIView)
			StoryMgr.instance:verifyEP4HasFinish(function()
				GuideController.instance:tryEnterFirstScene()
			end, self)
		else
			ViewMgr.instance:close(ViewName.Login)
			PrefaceController.instance:startPreface()
		end

		local zoneId = BootstrapGameConfigMgr.getZoneId()
		local roleId = PlayerModel.instance:getId()
		local roleName = PlayerModel.instance:getNickName()
		local roleLevel = PlayerModel.instance:getLevel()
		local serverName = LoginModel.instance:getServerName()
		local roleCTime = PlayerModel.instance:getRegisterTime()
		local loginTime = PlayerModel.instance:getLoginTimeDataStr()
		local lastLogoutTimeStr = PlayerModel.instance:getLastLogoutTimeDataStr()
		local lastLogoutTime = PlayerModel.instance:getLastLogoutTime()

		SDKGameRoleInfo.roleId = roleId
		SDKGameRoleInfo.roleName = roleName
		SDKGameRoleInfo.roleLevel = roleLevel
		SDKGameRoleInfo.serverId = tostring(zoneId)
		SDKGameRoleInfo.serverName = serverName
		SDKGameRoleInfo.roleCTime = roleCTime
		SDKGameRoleInfo.loginTime = loginTime
		SDKGameRoleInfo.lastLogoutTime = lastLogoutTimeStr
		SDKGameRoleInfo.registerTime = roleCTime

		printWarn("lzr..lastLogoutTime", lastLogoutTime)

		if not lastLogoutTime or tonumber(lastLogoutTime) == 0 then
			SDKGameRoleInfo.type = 1

			SDKManager.getSDKInstacne():createRole(SDKGameRoleInfo)
		end

		SDKGameRoleInfo.type = 2

		SDKManager.getSDKInstacne():enterGame(SDKGameRoleInfo)
		UserAgent.instance:sendSendDeviceInfoRequest()
	end
end

return M
