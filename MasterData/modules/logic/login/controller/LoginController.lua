-- chunkname: @modules/logic/login/controller/LoginController.lua

module("modules.logic.login.controller.LoginController", package.seeall)

local LoginController = class("LoginController", BaseController)
local loginDomain, session, web, slist, start = GameUrlConfig.getLoginUrls(false)
local bak_loginDomain, bak_session, bak_web, bak_slist, bak_start = GameUrlConfig.getLoginUrls(true)

LoginController.HeartBeatInterval = 10
LoginController.MaxReconnectCount = 3

function LoginController:get_getSessionIdUrl(useBackupUrl)
	return (useBackupUrl or nil) and (bak_session or session)
end

function LoginController:get_httpWebLoginUrl(useBackupUrl)
	return (useBackupUrl or nil) and (bak_web or web)
end

function LoginController:get_getServerListUrl(useBackupUrl)
	return (useBackupUrl or nil) and (bak_slist or slist)
end

function LoginController:get_startGameUrl(useBackupUrl)
	return (useBackupUrl or nil) and (bak_start or start)
end

function LoginController:onInit()
	self.enteredGame = false
end

function LoginController:onInitFinish()
	self._moduleLoginFlow = FlowSequence.New()
	self._moduleLoginFlow.flowName = "moduleLoginFlow"

	self._moduleLoginFlow:addWork(LoginPreInfoWork.New())
	self._moduleLoginFlow:addWork(LoginPreLoadWork.New())
	self._moduleLoginFlow:addWork(LoginIngoreSomeCmdLog.New())
	self._moduleLoginFlow:addWork(LoginGetInfoWork.New())
	self._moduleLoginFlow:addWork(LoginParseFightConfigWork.New())
	self._moduleLoginFlow:addWork(LoginFirstGuideWork.New())
	self._moduleLoginFlow:addWork(LoginEnterMainSceneWork.New())
	self._moduleLoginFlow:registerDoneListener(self._onModuleLoginDone, self)

	self._moduleLogoutFlow = FlowSequence.New()
	self._moduleLogoutFlow.flowName = "moduleLogoutFlow"

	self._moduleLogoutFlow:addWork(LogoutSocketWork.New())
	self._moduleLogoutFlow:addWork(LogoutCleanWork.New())
	self._moduleLogoutFlow:addWork(LogoutOpenLoginWork.New())
	self._moduleLogoutFlow:registerDoneListener(self._onModuleLogoutDone, self)
end

function LoginController:addConstEvents()
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnLostConnect, self._onLostConnect, self)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnReconnectSucc, self._onReconnectSucc, self)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnReconnectFail, self._promptReconnectAgain, self)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnServerKickedOut, self._onServerKickedOut, self)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnLostMessage, self._onLostMessage, self)
	GameSceneMgr.instance:registerCallback(SceneEventName.StopLoading, self._stopModuleLogin, self)
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateDungeonInfo, self._onUpdateShowLoginVideoFlag, self)
end

function LoginController:dispose()
	ConnectAliveMgr.instance:unregisterCallback(ConnectEvent.OnLostConnect, self._onLostConnect, self)
	ConnectAliveMgr.instance:unregisterCallback(ConnectEvent.OnReconnectSucc, self._onReconnectSucc, self)
	ConnectAliveMgr.instance:unregisterCallback(ConnectEvent.OnReconnectFail, self._promptReconnectAgain, self)
	ConnectAliveMgr.instance:unregisterCallback(ConnectEvent.OnServerKickedOut, self._onServerKickedOut, self)
	ConnectAliveMgr.instance:unregisterCallback(ConnectEvent.OnLostMessage, self._onLostMessage, self)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.StopLoading, self._stopModuleLogin, self)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnUpdateDungeonInfo, self._onUpdateShowLoginVideoFlag, self)
	self._moduleLoginFlow:stop()
	self._moduleLogoutFlow:stop()
end

function LoginController:reInit()
	self.enteredGame = false

	LoginConfig.instance:getEpisodeIdList(true)
end

function LoginController:login(param)
	if canLogNormal then
		logNormal("LoginController:login" .. debug.traceback("", 2))
	end

	self.userManualLogout = param and param.userManualLogout

	ViewMgr.instance:openView(ViewName.LoginView, param, true)
end

function LoginController:logout(isVoicePackageDonwload)
	if canLogNormal then
		logNormal("LoginController:logout" .. debug.traceback("", 2))
	end

	TimeDispatcher.instance:stopTick()
	self:_moduleLogout(LuaSocketMgr.instance:isConnected(), false, isVoicePackageDonwload)
end

function LoginController:onSdkLogout()
	local userManualLogout = self.userManualLogout

	self.userManualLogout = nil

	LoginModel.instance:clearDatas()
	TimeDispatcher.instance:stopTick()

	if ViewMgr.instance:isOpen(ViewName.LoginView) then
		if userManualLogout ~= true or not SDKMgr.instance:getBoolMetaData("ssgame_dontShowLoginPanelAfterLogout") then
			SDKMgr.instance:login()
		end
	else
		self:_moduleLogout(LuaSocketMgr.instance:isConnected(), true)
	end
end

function LoginController:sdkLogout(userManualLogout)
	self.userManualLogout = userManualLogout

	LoginModel.instance:clearDatas()
	SDKMgr.instance:logout()
end

function LoginController:startLogin()
	self:_startLogin()
end

function LoginController:_startLogin()
	if LoginModel.instance:isNotLogin() then
		self:_startBlock()
		LoginModel.instance:doingLogin()

		self._enableModuleLogin = true

		self:_socketConnectAndLogin()
	elseif LoginModel.instance:isDoingLogin() then
		logError("正在登录游戏，无法重复登录")
	elseif LoginModel.instance:isDoneLogin() then
		logError("已经登录游戏，无法重复登录")
	end
end

function LoginController:_socketConnectAndLogin()
	logNormal(string.format("login %s:%d  userName = %s  sessionId = %s", LoginModel.instance.serverIp, LoginModel.instance.serverPort, LoginModel.instance.userName, LoginModel.instance.sessionId))

	self._callbackId = SystemLoginRpc.instance:addCallback(1, self._onSystemLoginCallback, self)

	local ip = LoginModel.instance.serverIp
	local port = LoginModel.instance.serverPort

	if self._useBak then
		ip = LoginModel.instance.serverBakIp
		port = LoginModel.instance.serverBakPort
	end

	self._systemLoginStatus = nil

	ConnectAliveMgr.instance:login(ip, port, LoginModel.instance.userName, LoginModel.instance.sessionId, self._onLogin, self)
end

function LoginController:_startBlock()
	UIBlockMgr.instance:startBlock(UIBlockKey.Login)
end

function LoginController:_endBlock()
	UIBlockMgr.instance:endBlock(UIBlockKey.Login)
end

function LoginController:_onSystemLoginCallback(cmd, status, msg)
	self._systemLoginStatus = status

	self:_removeSystemLoginCallback()
end

function LoginController:_removeSystemLoginCallback()
	if self._callbackId then
		SystemLoginRpc.instance:removeCallbackById(self._callbackId)

		self._callbackId = nil
	end
end

function LoginController:_onLogin(isSuccess, resultTable)
	if not isSuccess and not self._useBak and not string.nilorempty(LoginModel.instance.serverBakIp) then
		local socketFail = resultTable and resultTable.socketFail

		if socketFail and not self._systemLoginStatus then
			self._useBak = true

			LoginModel.instance:notLogin()
			logNormal("业务层 登录失败，切换备用节点")
			TaskDispatcher.runDelay(self._socketConnectAndLogin, self, 0.5)

			return
		end
	end

	self:_removeSystemLoginCallback()
	self:_endBlock()

	if isSuccess then
		LoginModel.instance:doneLogin()

		self._reconectTimes = 0
		self._enableModuleLogin = true

		logNormal("<color=#00FF00>业务层 登录成功，可以开始做逻辑了</color>")
		self:_startHeartBeat()
		self:_moduleLogin()
	elseif not self._systemLoginStatus then
		LoginModel.instance:notLogin()
		logNormal("<color=#FFA500>业务层 socket连接失败，请选择重连or取消</color>")
		LoginController.instance:dispatchEvent(LoginEvent.SystemLoginFail)
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.LoginFail, MsgBoxEnum.BoxType.Yes_No, function()
			self:_socketConnectAndLogin()
		end, function()
			self:logout()
		end)

		if self._useBak then
			logError("业务层 登录失败，备用节点都不行")
		end
	elseif self._systemLoginStatus ~= 0 then
		LoginModel.instance:notLogin()
		logNormal("<color=#FFA500>业务层 系统登录失败</color>")
		LoginController.instance:dispatchEvent(LoginEvent.SystemLoginFail)

		if resultTable then
			if not resultTable.msg then
				local msg = "resultCode:" .. self._systemLoginStatus

				MessageBoxController.instance:showSystemMsgBoxByStr(msg, MsgBoxEnum.BoxType.Yes, function()
					self:logout()
				end)
			end
		end
	else
		LoginModel.instance:notLogin()
		logNormal("系统登录失败，不能重连了，可能是黑号/write back now")
		LoginController.instance:dispatchEvent(LoginEvent.SystemLoginFail)
		self:logout()
	end

	self._useBak = nil
end

function LoginController:_onLostMessage()
	logNormal("<color=red>丢包了</color>")
	self:_stopHeartBeat()

	self._reconectTimes = 3

	self:_promptReconnectAgain()
end

function LoginController:_onLostConnect(dontReconnect, msg)
	self:_stopHeartBeat()
	self:_promptReconnectAgain(dontReconnect, msg)
end

function LoginController:_delayReConnect()
	ConnectAliveMgr.instance:reconnect()
end

function LoginController:_onReconnectSucc()
	self._reconectTimes = 0

	logNormal("<color=#00FF00>业务层 收到 断线重连成功</color>")
	self:_startHeartBeat()
end

function LoginController:stopReconnect()
	ConnectAliveMgr.instance:reconnect()
end

function LoginController:_startHeartBeat()
	TaskDispatcher.runRepeat(self._sendHeartBeat, self, LoginController.HeartBeatInterval)
end

function LoginController:stopHeartBeat()
	TaskDispatcher.cancelTask(self._sendHeartBeat, self)
end

function LoginController:_stopHeartBeat()
	TaskDispatcher.cancelTask(self._sendHeartBeat, self)
end

function LoginController:_sendHeartBeat()
	CommonRpc.instance:sendGetServerTimeRequest()
end

function LoginController:_promptReconnectAgain(dontReconnect, msg)
	self._reconectTimes = self._reconectTimes + 1

	if dontReconnect then
		MessageBoxController.instance:showMsgBoxByStr(msg, MsgBoxEnum.BoxType.Yes, function()
			self._moduleLoginFlow:stop()
			LoginController.instance:logout()
		end, nil)
	elseif self._reconectTimes > LoginController.MaxReconnectCount then
		logNormal("<color=#FFA500>断线重连次数过多，确认网络已断开，返回登陆界面</color>")
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.LoginLostConnect1, MsgBoxEnum.BoxType.Yes, function()
			self._moduleLoginFlow:stop()
			LoginController.instance:logout()
		end, nil)
	else
		UIBlockMgr.instance:endAll()
		logNormal("<color=#FFA500>业务层 收到 断线重连失败，需要用户操作</color>")
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.LoginLostConnect2, MsgBoxEnum.BoxType.Yes_No, function()
			ConnectAliveMgr.instance:reconnect()
		end, function()
			self._moduleLoginFlow:stop()
			LoginController.instance:logout()
		end)
	end
end

function LoginController:_tryReconnect()
	ConnectAliveMgr.instance:reconnect()
end

function LoginController:_stopModuleLogin()
	self._enableModuleLogin = false
end

function LoginController:_onServerKickedOut(reason, resultCode)
	ConnectAliveMgr.instance:logout()

	if resultCode == -10 then
		logNormal("设备解绑，退出sdk")
		self:sdkLogout()
	end

	self:_stopHeartBeat()

	local langIdCfg = lua_language_coder.configDict[reason]

	langIdCfg = langIdCfg or lua_language_prefab.configDict[reason]

	MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.LoginReturn, MsgBoxEnum.BoxType.Yes, function()
		LoginController.instance:logout()
	end, nil, nil, nil, nil, nil, (langIdCfg or nil) and luaLang(reason))
end

function LoginController:_moduleLogin()
	if not self._enableModuleLogin then
		return
	end

	self._moduleLoginFlow:start({})
end

function LoginController:_onModuleLoginDone(isSuccess)
	if isSuccess then
		logNormal("游戏登入流程结束，已进入主场景")
		TimeDispatcher.instance:startTick()
		LoginController.instance:dispatchEvent(LoginEvent.OnLoginEnterMainScene)

		self.enteredGame = true
	else
		logWarn("游戏登入流程失败！")
	end
end

function LoginController:_moduleLogout(isConnected, isSdkLogout, isVoicePackageDonwload)
	self.enteredGame = false

	TaskDispatcher.cancelTask(self._socketConnectAndLogin, self)
	TaskDispatcher.cancelTask(self._delayReConnect, self)
	TaskDispatcher.cancelTask(self._tryReconnect, self)
	self:_stopHeartBeat()
	PopupController.instance:clear()
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	LoginController.instance:dispatchEvent(LoginEvent.OnBeginLogout)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.OpenLoading, SceneType.Main)
	self._moduleLogoutFlow:start({
		isConnected = isConnected,
		isSdkLogout = isSdkLogout,
		isVoicePackageDonwload = isVoicePackageDonwload
	})
end

function LoginController:_onModuleLogoutDone(isSuccess)
	if isSuccess then
		logNormal("返回登陆界面")
	else
		logWarn("返回登陆失败！")
	end

	LoginController.instance:dispatchEvent(LoginEvent.OnLogout)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.CloseLoading)
end

function LoginController:isEnteredGame()
	return self.enteredGame
end

function LoginController:_onUpdateShowLoginVideoFlag()
	local episodeIdList = LoginConfig.instance:getEpisodeIdList()

	for _, episodeId in ipairs(episodeIdList) do
		local isPass = DungeonModel.instance:hasPassLevel(episodeId)

		PlayerPrefsHelper.setNumber(PlayerPrefsKey.GameEpisodeIdPassKey .. episodeId, isPass and 1 or 0)
	end
end

function LoginController:isPassDungeonById(episodeId)
	return PlayerPrefsHelper.getNumber(PlayerPrefsKey.GameEpisodeIdPassKey .. episodeId, 0) ~= 0
end

LoginController.instance = LoginController.New()

return LoginController
