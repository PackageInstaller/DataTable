-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/controller/LoginController.lua

module("logic.extensions.login.controller.LoginController", package.seeall)

local LoginController = class("LoginController", BaseController)

BootstrapConstdef.EBootstrapEventId.ELoginCommonId = "501087"
BootstrapConstdef.ELoginCommonIdName = "LoadingActions"
LoginController._isInChecking = nil

function LoginController:onInit()
	self._isLogined = false
	self._isInfoPushed = false
	self._connectTime = 0
	self._connectMaxTime = 10
	self._connectMsTime = 0
	self._isInChecking = false
	self.loadAreaCallBack = nil

	LoginServerListModel.instance:onInit()
	SDKManager.registerLogoutListener(function()
		LoginModel.instance.sessionId = nil
		LoginModel.instance.platformId = nil
		LoginModel.instance.socketAccount = nil
		LoginModel.instance.gameAccount = nil
		LoginModel.instance.socketPassword = nil

		GlobalDispatcher:dispatch(GlobalNotify.onSDKLogout)
		LoginController.instance:disconnect(function()
			ReConnectionMgr.instance:returnToLogin()
		end)
	end)

	local versionCode = checknumber(BootstrapUtil.getGameVersionCode())

	if (Framework.OSDef.RunOS == Framework.OSDef.Android and versionCode >= 1100 or Framework.OSDef.RunOS == Framework.OSDef.IOS and versionCode >= 1100 or Framework.OSDef.isEditor or nil) and true or BootstrapLauncher.instance.__VERSION and BootstrapLauncher.instance.__VERSION >= 1 then
		usingnow("bootstrap.BootstrapOnlineResMgr", "BootstrapOnlineResMgr")

		if BootstrapOnlineResMgr.instance.regErrorCallBack then
			BootstrapOnlineResMgr.instance:regErrorCallBack(self._onErrCallBack, self)
		end
	end

	HardwareQuality.startFpsMonitor()
end

function LoginController:onReset()
	self.loadAreaCallBack = nil
	self._needForceUpdate = nil
	self._forceUpdateMsg = nil

	removetimer(self._doreconnect, self)
	removetimer(self._delayCheckForUpdate, self)
	LoginModel.instance:onReset()
	LoginServerListModel.instance:onReset()
	LoginServerUserInfoModel.instance:onReset()
	RoleFacade.instance:stopSyncTime()
	CommonPreloader.instance:setAdditionalCallback(nil, nil)

	self._isInChecking = false

	forcePrint("=================LoginController:onReset()===========")
end

function LoginController:_onErrCallBack(eBootstrapState, tips, val)
	TipsFacade.instance:openCommonTips(tips)
end

function LoginController:checkConfig(cfg)
	if not cfg and not Framework.OSDef.isEditor then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("tip_login_updateclient"), function()
			self:applicationQuit()
		end, "确定")

		return false
	end

	return true
end

function LoginController:checkForceDownloadPackage()
	local forceDownloadUrl = SDKManager.getForceDownloadPackageUrl()

	if forceDownloadUrl then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), BootstrapLanguage.a1, function()
			UnityEngine.Application.OpenURL(forceDownloadUrl)
		end, "确定")

		return true
	end
end

function LoginController:handleServerMsgNotifyRes(forceUpdate, customMsg)
	self._needForceUpdate = forceUpdate
	self._forceUpdateMsg = customMsg

	local time = math.random(1, 100)

	settimer(time, self._delayCheckForUpdate, self)
end

function LoginController:_delayCheckForUpdate()
	removetimer(self._delayCheckForUpdate, self)
	Framework.HotUpdate.GameUpdateMgr.Instance:RequestRemoteVersionCode(function()
		return
	end, function(gameHotUpdateVersion)
		if not gameHotUpdateVersion then
			return
		end

		if not gameHotUpdateVersion.version then
			local gameHotUpdateVersionCode = "0.0.0"

			if gameHotUpdateVersionCode ~= "0.0.0" and not self:checkAgainHotUpdateVersion(gameHotUpdateVersionCode) then
				local tips = self._forceUpdateMsg

				if not self._needForceUpdate then
					if string.nilorempty(tips) then
						tips = "检测到游戏资源有更新，是否重启游戏更新资源？"
					end

					TipsFacade.instance:openPopupWindow(lang("tip"), tips, function()
						self:applicationQuit()
					end, function()
						return
					end, "确定", "取消")
				else
					if string.nilorempty(tips) then
						tips = lang("tip_login_updateclient")
					end

					TipsFacade.instance:openTipWindowNoX(lang("tip"), tips, function()
						self:applicationQuit()
					end, "确定")
				end
			end
		end
	end)
end

function LoginController:checkAgainHotUpdateVersion(gameHotUpdateVersionCode)
	local remoteVersion = string.split(gameHotUpdateVersionCode, ".")
	local bigVersion = checknumber(remoteVersion[1])
	local smallVerion = checknumber(remoteVersion[3])
	local localVersion = string.split(BootstrapUtil.getGameHotUpdateVersionCode(), ".")
	local localbigVersion = checknumber(localVersion[1])
	local localsmallVersion = checknumber(localVersion[3])

	if localbigVersion < bigVersion then
		forcePrint("服务器资源版本号 大包版本号 大于 本地，需要整包")

		return false
	elseif bigVersion == localbigVersion and localsmallVersion < smallVerion then
		forcePrint("服务器资源版本号 小包版本号 大于 本地，需要热更新")

		return false
	end

	return true
end

function LoginController:applicationQuit()
	forcePrint("_applicationQuit===========,come here ...")
	BootstrapUtil.sdkDestroy()
	UnityEngine.Application.Quit()
end

function LoginController:setFirstEntered()
	self._hasEnterFirst = true
end

function LoginController:isFirstEnter()
	return not self._hasEnterFirst
end

function LoginController:login(serverIp, serverPort)
	if self._isInChecking then
		return
	end

	WaitingView.instance:setTips("tip_login_connecting")
	WaitingView.instance:show()

	self._isLogined = false
	self._isInfoPushed = false
	self._isInChecking = true

	RoleController.instance:onReset()
	GlobalDispatcher:addListener(GlobalNotify.NetConnected, self._onNetConnectDone, self)
	forcePrint("=================LoginModel.instance.serverIp=" .. serverIp .. "  serverPort=" .. serverPort)

	self._connectTime = os.time()
	self._connectMsTime = tolua.gettime() * 1000

	local bRet = NetConnMgr.instance:connect(serverIp, serverPort, ConnectionType.Logic)

	if not bRet then
		settimer(0.5, self._doreconnect, self, false)
	end
end

function LoginController:safeLogin(serverIp, serverPort)
	ReConnectionMgr.instance:addDisconnectCallback()
	NetConnMgr.instance:enabled()

	if NetConnMgr.instance:isConnected(ConnectionType.Logic) then
		printInfo("LoginController:safeLogin  isConnected  ip=" .. serverIp .. "  port=" .. serverPort)
		LoginController.instance:disconnect(function()
			LoginController.instance:setServerData(serverIp, serverPort)
			LoginController.instance:login(serverIp, serverPort)
		end)
	else
		printInfo("LoginController:safeLogin is not Connected  ip=" .. serverIp .. "  port=" .. serverPort)
		LoginController.instance:setServerData(serverIp, serverPort)
		LoginController.instance:login(serverIp, serverPort)
	end
end

function LoginController:isLogin()
	return self._isLogined
end

function LoginController:setLogin(isLogined)
	self._isLogined = isLogined
end

function LoginController:disconnect(callback, callbackObj)
	CommonPreloader.instance:setAdditionalCallback(nil, nil)
	removetimer(self._doreconnect, self)

	self._isLogined = false
	self._isInfoPushed = false
	self._isInChecking = false

	if NetConnMgr.instance:isConnected(ConnectionType.Logic) then
		ReConnectionMgr.instance:addDisconnectCallback(callback, callbackObj)

		LoginModel.instance.disconnectFlag = GameEnum.DisconnectFlag_SkipHandler

		NetConnMgr.instance:disconnect(ConnectionType.Logic)

		LoginModel.instance.disconnectFlag = GameEnum.DisconnectFlag_Net

		WaitingView.instance:hide()
	else
		ReConnectionMgr.instance:addDisconnectCallback()

		if callback then
			if callbackObj then
				callback(callbackObj)
			else
				callback()
			end
		end
	end
end

function LoginController:_doreconnect()
	forcePrint("===========_doreconnect =============== ")

	local bRet = NetConnMgr.instance:connect(LoginModel.instance.serverIp, LoginModel.instance.serverPort, ConnectionType.Logic)

	forcePrint(bRet)

	if not bRet then
		local now = os.time()

		if now - self._connectTime > self._connectMaxTime then
			self:_onNetConnectDone(false)
		else
			settimer(0.5, self._doreconnect, self, false)
		end
	end
end

function LoginController:_onNetConnectDone(isConnected)
	GlobalDispatcher:removeListener(GlobalNotify.NetConnected, self._onNetConnectDone, self)
	printInfo("_onNetConnectDone" .. tostring(isConnected))

	if not LoginModel.instance.socketAccount or not LoginModel.instance.socketPassword then
		self:disconnect()

		return
	end

	local data_length = 0
	local eventId = isConnected and "701" or "702"
	local eventName = isConnected and "Socket" or "SocketFail"
	local gameId = SDKManager.getGameId()
	local host_ip = LoginModel.instance.serverIp
	local spend_time = math.floor(tolua.gettime() * 1000 - self._connectMsTime)
	local start_timestamp = math.floor(self._connectMsTime)

	Netkit.trackSocketData(data_length, eventId, eventName, gameId, host_ip, spend_time, start_timestamp)

	if isConnected then
		WaitingView.instance:setTips("tip_login_logining")
		GlobalDispatcher:addListener(GlobalNotify.RoleInfoPushed, self._onRoleInfoPushed, self)
		GlobalDispatcher:addListener(GlobalNotify.NeedCreateRole, self._onRoleNeedCreate, self)
		GlobalDispatcher:addListener(GlobalNotify.RoleLogined, self._onRoleLogined, self, NotifyPriority.High)
		NetConnMgr.instance:enabled()
		forcePrint("===========socketAccount = " .. LoginModel.instance.socketAccount .. " socketPassword = " .. LoginModel.instance.socketPassword)
		LoginAgent.instance:sendLoginRequest(LoginModel.instance.socketAccount, LoginModel.instance.socketPassword, true)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnServerConnectedFail)
		forcePrint("===========_onNetConnectDone, isConnected = false ==========")

		self._isInChecking = false

		WaitingView.instance:hide()
		TipsFacade.instance:openTipWindow(lang("登陆失败"), BootstrapLanguage.a36, nil, "确定")
	end
end

function LoginController:_onRoleLogined(isSucc)
	forcePrint("===========LoginController._onRoleLogined isSucc:")
	forcePrint(isSucc)

	if isSucc then
		GlobalDispatcher:removeListener(GlobalNotify.RoleLogined, self._onRoleLogined, self)

		self._isLogined = true

		self:_checkAllLogined()
	else
		self._isInChecking = false
	end
end

function LoginController:_onRoleNeedCreate()
	WaitingView.instance:hide()
	GlobalDispatcher:addListener(GlobalNotify.SceneLoaded, self._onStartBattleSceneLoaded, self)

	if CommonPreloader.instance:isAllAdditionalLoaded() then
		self:_onAllAdditionalLoaded()
	else
		CommonPreloader.instance:setAdditionalCallback(self._onAllAdditionalLoaded, self)
	end
end

function LoginController:_onAllAdditionalLoaded()
	SceneMgr.instance:enter(SceneType.CreateRole, sceneId, 0, 0)
end

function LoginController:_onStartBattleSceneLoaded()
	ViewMgr.instance:close(ViewName.Login)
	GlobalDispatcher:removeListener(GlobalNotify.SceneLoaded, self._onStartBattleSceneLoaded, self)
	GlobalModel.instance.gameStart:SetActive(false)
end

function LoginController:_onRoleInfoPushed()
	forcePrint("===========_onRoleInfoPushed  in loginView==============")
	GlobalDispatcher:removeListener(GlobalNotify.RoleInfoPushed, self._onRoleInfoPushed, self)
	GlobalDispatcher:removeListener(GlobalNotify.NeedCreateRole, self._onRoleNeedCreate, self)
	RoleFacade.instance:startSyncTime()

	LoginModel.instance.loginTime = ServerTime.now()
	self._isInfoPushed = true

	self:_checkAllLogined()
end

function LoginController:_checkAllLogined()
	if self._isLogined and self._isInfoPushed then
		forcePrint("===========_checkAllLogined  in loginView==============")
		AntiAddictionController.instance:sendGetRoleInfo(self.startPreload, self)
	end
end

function LoginController:startPreload()
	forcePrint("风控请求结束，登录流程继续往下走===")
	GlobalDispatcher:addListener(GlobalNotify.TaskDataReady, self._startPreloaded, self)
	PasswordLockController.instance:sendGetBaseInfo()
	DiamondTaskAgent.instance:sendGetDiamondTaskInfosReq()
	PlotCopyController.instance:loadCopyInfo()
	LegendController.instance:loadLegendChallengeInfo()
	ChallengeFacade.instance:loadSmallGameInfo()
	MaterialChallengeController.instance:loadInfoOnEnterGame()
	MaterialFacade.instance:loadMaterialInfos()
	AnswerSceneController.instance:getAnswerSceneInfo()
	ChuangkongunionController.instance:getTaskInfo()
	ExpeditionController.instance:sendGetWeekCanPlayInfo()
	MakeCakeController.instance:loadMakeCakeInfo()
	TaskFacade.instance:loadUserTasks()
	DivineEvolveController.instance:loadInfoOnLogin()
	BattleStartAnimController.instance:loadInfoOnLogin()
end

function LoginController:_startPreloaded()
	GlobalDispatcher:removeListener(GlobalNotify.TaskDataReady, self._startPreloaded, self)
	RoleDataRequestor.instance:start()
	SurveyController.instance:startTick()
	WaitingView.instance:hide()

	if CommonPreloader.instance:isAllAdditionalLoaded() then
		self:_onPreloadDone()
	else
		CommonPreloader.instance:setAdditionalCallback(self._onPreloadDone, self)
	end
end

function LoginController:_onPreloadDone()
	SceneMainPlayer.instance:createMainPlayer()
	self:_enterGame()
end

function LoginController:_enterGame()
	forcePrint("===========_enterGame  in loginView==============")
	GlobalDispatcher:addListener(GlobalNotify.SceneLoaded, self._onSceneLogined, self)
	ReConnectionMgr.instance:addDisconnectCallback()
	RoleActionsModel.instance:loadNewActionsConfig()
	GlobalDispatcher:dispatch(GlobalNotify.StartEnterGame)
	NetConnMgrExt.setInGame()
	SDKGameRoleInfoController.instance:enterGame()
	SceneFacade.instance:firstEnter()
end

function LoginController:_onSceneLogined()
	forcePrint("===========_onSceneLogined in loginView==============")

	self._isInChecking = false

	GlobalModel.instance.gameStart:SetActive(false)

	LoginModel.instance.isSceneLoaded = true

	GlobalDispatcher:removeListener(GlobalNotify.SceneLoaded, self._onSceneLogined, self)
	CommonPreloader.instance:clearResPathData()

	local versionCode = checknumber(BootstrapUtil.getGameVersionCode())

	if not Framework.OSDef.isEditor and Framework.OSDef.RunOS == Framework.OSDef.Android and (versionCode == 220 or versionCode == 221) then
		local versionFile = Framework.FileUtils.LocalResRootPath .. "version"

		Framework.FileUtils.Instance:DeleteFile(versionFile)
		Framework.FileUtils.Instance:DeleteFile("file://" .. versionFile)

		local btplatformId = checknumber(BootstrapUtil.getPlatformId())
		local channelId = checknumber(BootstrapUtil.getChannelId())

		if btplatformId == 8 then
			TipsFacade.instance:openTipWindowNoX(lang("tip"), "当前客户端异常，请卸载后，重新下载", function()
				return
			end, BootstrapLanguage.sure)
		else
			if (btplatformId == 2 or btplatformId == 10) and (channelId == 140004 or channelId == 710005) then
				TipsFacade.instance:openTipWindowNoX(lang("tip"), "当前客户端异常，请卸载后，重新下载", function()
					return
				end, BootstrapLanguage.sure)

				return
			end

			TipsFacade.instance:openTipWindowNoX(lang("tip"), "威胁奥奇世界的黑暗力量已被击退，请放心在奥奇世界畅游~", function()
				return
			end, BootstrapLanguage.sure)
		end
	end
end

LoginController.strKeyUesrName = "username"
LoginController.strKeyUserProtocal = "userprotocal"
LoginController.strKeyPrivateProtocal = "privateprotocal"
LoginController.strKeyHasShowUserProtocal = "hasShowUserProtocal"
LoginController.strKeyHasShowPrivateProtocal = "hasShowPrivateProtocal"

function LoginController:setServerListToModel(areaId, serverListData)
	if serverListData then
		local list = {}
		local mo, serverData

		for i = 1, #serverListData do
			mo = ServerListMO.New()
			mo.id = serverListData[i].id
			mo.name = serverListData[i].name
			mo.ip = serverListData[i].ip
			mo.port = serverListData[i].port
			mo.state = serverListData[i].state

			table.insert(list, mo)
		end

		LoginServerListModel.instance:setMoList(areaId, list)
	else
		printError("服务器列表为nil。")
	end
end

function LoginController:setServerData(serverIp, serverPort)
	LoginModel.instance.serverIp = serverIp
	LoginModel.instance.serverPort = serverPort
end

function LoginController:openServerListView(reverseIndex)
	LoginAgent.instance:sendHttpWebLoadAreaRequest(LoginModel.instance.gameAccount, LoginModel.instance.socketPassword, reverseIndex, function(data)
		if data and data.areaList then
			LoginServerListModel.instance:onReset()
			LoginServerUserInfoModel.instance:onReset()

			for i = 1, #data.areaList do
				if LoginModel.instance.curAreaStatus and LoginModel.instance.curAreaStatus.id == data.areaList[i].id then
					LoginModel.instance.curAreaStatus.modeId = data.areaList[i].modeId
				end

				self:setServerListToModel(data.areaList[i].id, data.areaList[i].socketAddresses)
			end
		end

		ViewMgr.instance:open(ViewName.ServerlistView, data)
	end)
end

function LoginController:_createUiMask(_call_back)
	if self._uimaskRes then
		if _call_back then
			local var_47_0 = self._uimaskRes

			if self._uimaskRes then
				var_47_0 = self._uimaskRes[1]

				if self._uimaskRes[1] then
					local _asset = self._uimaskRes[1]:GetMainAsset()

					_call_back(_asset)
				end
			end
		end

		return
	end

	self._uimaskResLoader = MultiResLoader.New()
	self._uimaskResList = {}

	table.insert(self._uimaskResList, "ui/views/login/uimask.prefab")
	self._uimaskResLoader:setResPaths(self._uimaskResList)
	self._uimaskResLoader:load(function()
		self._uimaskRes = {}

		for i = 1, #self._uimaskResList do
			self._uimaskRes[i] = self._uimaskResLoader:getResource(self._uimaskResList[i])
		end

		if _call_back then
			local var_48_0 = self._uimaskRes

			if self._uimaskRes then
				var_48_0 = self._uimaskRes[1]

				if self._uimaskRes[1] then
					local _asset = self._uimaskRes[1]:GetMainAsset()

					_call_back(_asset)
				end
			end
		end
	end, nil, self)
end

function LoginController:_clearUiMaskRes()
	if self._uimaskResLoader then
		GameUtil.unloadMultiResLoaderResource(self._uimaskResLoader)

		self._uimaskResLoader = nil
	end

	if self._uimaskRes then
		for i = 1, #self._uimaskRes do
			if self._uimaskRes[i] ~= nil then
				self._uimaskRes[i] = nil
			end
		end

		self._uimaskRes = nil
	end
end

LoginController.instance = LoginController.New()

return LoginController
