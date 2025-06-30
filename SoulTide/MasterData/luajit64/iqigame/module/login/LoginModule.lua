-- chunkname: @IQIGame\\Module\\Login\\LoginModule.lua

local json = require("Util.json")
local LoginScene = require("IQIGame.Scene.Login.LoginScene")

LoginModule = {
	IsCheckExitGame = false,
	NeedReconnect = false,
	isShowWebNoticeByIOS = true,
	LoginTimeForLog = 0,
	IsLogining = false,
	RecordMsgLength = false,
	isOpenNotice = false,
	ReconnectFlag = false,
	AccountIsNotActive = false,
	LastSendMessageTimer = 0,
	ReadMsgLength = 0
}

function LoginModule.StartLogin()
	LoginModule.LoginScene = LoginScene.New()
	LoginModule.NeedReconnect = false
	LoginModule.ReconnectFlag = false
	LoginModule.ReconnectToken = nil
	LoginModule.Uid = nil
	LoginModule.ReadMsgLength = 0
	LoginModule.RecordMsgLength = false
	LoginModule.IsLogining = false
	LoginModule.IsCheckExitGame = false

	PlayerModule.StateLogOut()
	LoginModule.LoginScene:OnEnter()
end

function LoginModule.AddReadBytesLength(length)
	if LoginModule.RecordMsgLength then
		LoginModule.ReadMsgLength = LoginModule.ReadMsgLength + length
	end
end

function LoginModule.CreateLoginParam(data)
	local loginParam = LoginRequestParam.New()

	loginParam.common = LoginModule.CreateCommonData()
	loginParam.sign = "10086"

	if data ~= nil then
		LoginModule.FilterJsonStrInTable(data)

		loginParam.data = data
	end

	loginParam.time = os.time()

	return loginParam
end

function LoginModule.FilterJsonStrInTable(data)
	for key, value in pairs(data) do
		data[key] = LoginModule.FilterJsonStr(value)
	end
end

function LoginModule.FilterJsonStr(value)
	if type(value) == "string" then
		value = string.gsub(value, "\r\n", "")
		value = string.gsub(value, "\n", "")
	end

	return value
end

function LoginModule.CreateCommonData()
	local data = LuaCodeInterface.GetDeviceInfo()

	if SDKLoginModule.IsSDKMode() then
		data.channelNo = SDKLoginModule.GetChannelNo()
	end

	local o = CommonData.New()

	for k, v in pairs(data) do
		o[k] = v
	end

	o.testPack = GmListModule.EnableTestPack()
	o.submitPack = CfgDiscreteDataTable[6520061].Data[1] == 1

	LoginModule.FilterJsonStrInTable(o)

	return o
end

function LoginModule.GetGuestInfo()
	local loginParam = LoginModule.CreateLoginParam(nil)
	local jsonStr = json.encode(loginParam)
	local url = LoginModule.GetRequestUrl(Constant.LoginConst.GuestAccountUrl)

	HttpModule.RequestPost(url, jsonStr, LoginModule.OnGetGuestNamePwdSucceed, LoginModule.OnGetGuestNamePwdFailed)
end

function LoginModule.OnGetGuestNamePwdSucceed(serverResponse)
	local up = json.decode(serverResponse)

	EventDispatcher.Dispatch(EventID.GetGuestInfoSuceed, up.data.uName, up.data.pwd)
end

function LoginModule.OnGetGuestNamePwdFailed(serverResponse)
	EventDispatcher.Dispatch(EventID.GetGuestInfoFailed, serverResponse)
end

function LoginModule.Login(username, password)
	local version = LuaCodeInterface.GetDeviceInfo().version

	if version == "0.46.0" or version == "0.46.1" or version == "1.12.0" or version == "1.12.1" then
		NoticeModule.ShowNoticeByType(4, LoginUIApi:GetString("GameVersionTooLowNotice"), function()
			LuaCodeInterface.QuitGame()
		end)

		return
	end

	NetCommController.Sending()

	local data = LoginRequestData.New()

	data.uName = username
	data.pwd = password
	LoginModule.LoginRequestData = data

	local loginParam = LoginModule.CreateLoginParam(data)
	local jsonStr = json.encode(loginParam)
	local url = LoginModule.GetRequestUrl(Constant.LoginConst.LoginUrl)

	HttpModule.RequestPost(url, jsonStr, LoginModule.OnLoginResponded, LoginModule.OnLoginError)
end

function LoginModule.Logout(callback)
	LoginModule.NeedReconnect = false

	if PlayerModule.InGame and NetManager.IsConnect[NetworkChannelName.Game] then
		LoginModule.LogoutCallBack = callback

		net_user.logout()
	else
		callback()
	end
end

function LoginModule.GetRequestUrl(urlformat)
	return string.gsub(urlformat, "{0}", GameEntry.ProjectSetting.BuildInfo.LoginUrl)
end

function LoginModule.OnLoginResponded(serverResponse)
	NetCommController.Responded()

	local function notifyFailedToCSharp(msg)
		local e = LoginFailedEventArgs()

		e.ResponseCode = -1
		e.errorText = msg

		GameEntry.LuaEvent:Fire(nil, e)
	end

	local function onLogFailed(msg)
		NoticeModule.ShowNotice(21040009)
		logError("登陆失败。" .. tostring(msg) .. "\nServer response: " .. serverResponse)
		notifyFailedToCSharp(msg)
	end

	xpcall(function()
		local response = json.decode(serverResponse)

		if response.code == 0 then
			if response.data == nil then
				onLogFailed("response.data is nil.")

				return
			else
				if response.data.districts == nil or type(response.data.districts) ~= "table" or #response.data.districts == 0 then
					onLogFailed("服务器列表信息错误。")

					return
				end

				if response.data.uid == nil then
					onLogFailed("uid is nil.")

					return
				end
			end

			LoginModule.LoginResponse = response

			if not SDKLoginModule.IsSDKMode() then
				local uName = LoginModule.LoginRequestData.uName
				local pwd = LoginModule.LoginRequestData.pwd

				PlayerPrefsUtil.SetString("", Constant.PlayerPrefsConst.UserName, uName)
				PlayerPrefsUtil.SetString("", Constant.PlayerPrefsConst.Password, pwd)
			end

			LoginModule.AccountIsNotActive = not response.data.activation

			local checkOtherAccount = response.data.checkOtherAccountResult or false

			EventDispatcher.Dispatch(EventID.GetServerList, response.data.districts, response.data.lastLoginServerId, response.data.uid, checkOtherAccount)
			SDKLoginModule.LogFirstPageAfterLogin()
		elseif response.code == 120016 then
			NoticeModule.ShowNoticeByType(4, LoginUIApi:GetString("GameVersionTooLowNotice"), function()
				LuaCodeInterface.QuitGame()
			end)
		elseif response.code == 120005 then
			NoticeModule.ShowNoticeByType(4, LoginUIApi:GetString("VersionTooLowNotice"), function()
				LuaCodeInterface.QuitGame()
			end)
		elseif response.code == 120001 then
			NoticeModule.ShowNotice(21051002)
			notifyFailedToCSharp("response.code: 120001")
		elseif response.code == 120002 then
			NoticeModule.ShowNotice(21051003)
			notifyFailedToCSharp("response.code: 120002")
		elseif response.code == 120006 then
			NoticeModule.ShowNotice(21051004)
			notifyFailedToCSharp("response.code: 120006")
		elseif response.code == 120003 then
			-- block empty
		elseif response.code ~= nil then
			onLogFailed("error code: " .. response.code)
		else
			onLogFailed("json解析错误：response.code is nil.")
		end
	end, function(msg)
		onLogFailed(msg)
	end)
end

function LoginModule.Register(uName, pwd, code)
	local data = RegisterData.New()

	data.uName = uName
	data.pwd = pwd
	data.code = code
	LoginModule.LoginRequestData = data

	local loginParam = LoginModule.CreateLoginParam(data)
	local jsonStr = json.encode(loginParam)
	local url = ""

	if CfgDiscreteDataTable[6507099].Data[1] == 0 then
		url = LoginModule.GetRequestUrl(Constant.LoginConst.RegisterUrl)
	else
		url = LoginModule.GetRequestUrl(Constant.LoginConst.CodeRegisterUrl)
	end

	HttpModule.RequestPost(url, jsonStr, LoginModule.OnRegisterSucceed, LoginModule.OnRegisterFailed)
end

function LoginModule.OnRegisterSucceed(serverResponse)
	local response = json.decode(serverResponse)

	if response.code == 0 then
		LoginModule.Login(LoginModule.LoginRequestData.uName, LoginModule.LoginRequestData.pwd)
	else
		local e = LoginFailedEventArgs()

		e.ResponseCode = response.code
		e.errorText = getErrorMsg(response.code)

		NoticeModule.ShowNoticeByType(1, e.errorText)
		GameEntry.LuaEvent:Fire(LoginModule, e)
		EventDispatcher.Dispatch(EventID.RegisterFailed, response.code, e.errorText)
	end
end

function LoginModule.OnRegisterFailed(serverResponse)
	logError("注册失败, 原因 : ", serverResponse)
end

function LoginModule.OnLoginError(serverResponse)
	NetCommController.Responded()

	local e = LoginFailedEventArgs()

	e.ResponseCode = -1
	e.errorText = serverResponse

	GameEntry.LuaEvent:Fire(LoginModule, e)

	if SDKLoginModule.IsSDKMode() then
		NoticeModule.ShowNoticeByType(4, LoginUIApi:GetString("LoginFailNotice"), function()
			SDKLoginModule.StartLogin()
		end)
	else
		NoticeModule.ShowNoticeByType(1, LoginUIApi:GetString("LoginFailNotice"))
	end
end

function LoginModule.EnterGame(selectedServerInfo)
	if LoginModule.IsLogining then
		return
	end

	LoginModule.IsLogining = true
	LoginModule.NeedReconnect = false
	LoginModule.selectedServerInfo = selectedServerInfo

	SDKLoginModule.SelectServer()

	if NetManager.IsConnect[NetworkChannelName.Game] then
		LoginModule.ValidateUUID()
	else
		EventDispatcher.AddEventListener(EventID.NetworkConnected, LoginModule.OnConnected)
		EventDispatcher.AddEventListener(EventID.NetworkError, LoginModule.OnConnectError)
		EventDispatcher.AddEventListener(EventID.NetworkClosed, LoginModule.OnConnectError)
		NetManager.ConnectToChannel(NetworkChannelName.Game, selectedServerInfo.serverIp, selectedServerInfo.port)
	end
end

function LoginModule.ValidateUUID()
	local loginResponse = LoginModule.LoginResponse

	net_user.validateUUID(loginResponse.data.uuid, LoginModule.selectedServerInfo.serverId, loginResponse.data.accountServerId)
end

function LoginModule.OnConnected(channelName)
	if channelName ~= NetworkChannelName.Game then
		return
	end

	LoginModule.NeedReconnect = true

	EventDispatcher.RemoveEventListener(EventID.NetworkConnected, LoginModule.OnConnected)
	EventDispatcher.RemoveEventListener(EventID.NetworkError, LoginModule.OnConnectError)
	EventDispatcher.RemoveEventListener(EventID.NetworkClosed, LoginModule.OnConnectError)
	EventDispatcher.AddEventListener(EventID.NotifyNetOffLine, LoginModule.OnOffLine)
end

function LoginModule.OnConnectError(channelName)
	if channelName ~= NetworkChannelName.Game then
		return
	end

	LoginModule.IsLogining = false

	EventDispatcher.RemoveEventListener(EventID.NetworkConnected, LoginModule.OnConnected)
	EventDispatcher.RemoveEventListener(EventID.NetworkError, LoginModule.OnConnectError)
	EventDispatcher.RemoveEventListener(EventID.NetworkClosed, LoginModule.OnConnectError)
	NoticeModule.ShowNotice(21040009, nil, nil, nil)
end

function LoginModule.OnOffLine(channelName, passivity)
	if channelName == NetworkChannelName.Game and (not passivity or LoginModule.NeedReconnect) then
		EventDispatcher.RemoveEventListener(EventID.NotifyNetOffLine, LoginModule.OnOffLine)
		LoginModule.ReConnect()
	end
end

function LoginModule.ReConnect()
	LoginModule.NeedReconnect = false
	LoginModule.ReconnectFlag = true
	LoginModule.RecordMsgLength = false

	local selectedServerInfo = LoginModule.selectedServerInfo

	EventDispatcher.AddEventListener(EventID.NetworkConnected, LoginModule.OnReConnected)
	EventDispatcher.AddEventListener(EventID.NetworkError, LoginModule.OnReConnectError)
	EventDispatcher.AddEventListener(EventID.NetworkClosed, LoginModule.OnReConnectError)
	NetManager.ConnectToChannel(NetworkChannelName.Game, selectedServerInfo.serverIp, selectedServerInfo.port)
end

function LoginModule.OnReConnected(channelName)
	if channelName ~= NetworkChannelName.Game then
		return
	end

	LoginModule.NeedReconnect = true

	EventDispatcher.RemoveEventListener(EventID.NetworkConnected, LoginModule.OnReConnected)
	EventDispatcher.RemoveEventListener(EventID.NetworkError, LoginModule.OnReConnectError)
	EventDispatcher.RemoveEventListener(EventID.NetworkClosed, LoginModule.OnReConnectError)
	EventDispatcher.AddEventListener(EventID.NotifyNetOffLine, LoginModule.OnOffLine)
end

function LoginModule.OnReConnectError(channelName)
	if channelName ~= NetworkChannelName.Game then
		return
	end

	EventDispatcher.RemoveEventListener(EventID.NetworkConnected, LoginModule.OnReConnected)
	EventDispatcher.RemoveEventListener(EventID.NetworkError, LoginModule.OnReConnectError)
	EventDispatcher.RemoveEventListener(EventID.NetworkClosed, LoginModule.OnReConnectError)

	LoginModule.NeedReconnect = false

	if UIModule.canPopTopConfirm then
		UIModule.Open(Constant.UIControllerName.TopConfirmationUI, Constant.UILayer.AboveAll, {
			cid = 21040010,
			confirm = LoginModule.ConfirmReconnect,
			cancel = LoginModule.AbandonReconnect
		}, true)
	end
end

function LoginModule.Reconnect()
	LoginModule.ReconnectFlag = false

	net_user.reconnect(LoginModule.ReconnectToken, LoginModule.ReadMsgLength, LoginModule.Uid)
end

function LoginModule.ConfirmReconnect()
	LoginModule.ReConnect()
end

function LoginModule.AbandonReconnect()
	LoginModule.isShowWebNoticeByIOS = true

	LoginModule.Logout(ProcedureReset.ResetAndGoToLogin)
end

function LoginModule.OnPlayerExitGame()
	if SDKLoginModule.IsChannelHasExitDialog() then
		SDKLoginModule.Exit(function()
			LoginModule.Logout(LuaCodeInterface.QuitGame)
		end)
	elseif not LoginModule.IsCheckExitGame and UIModule.canPopTopConfirm then
		LoginModule.IsCheckExitGame = true

		UIModule.Open(Constant.UIControllerName.TopConfirmationUI, Constant.UILayer.AboveAll, {
			cid = 21040132,
			confirm = function()
				LoginModule.IsCheckExitGame = false

				LoginModule.Logout(LuaCodeInterface.QuitGame)
			end,
			cancel = function()
				LoginModule.IsCheckExitGame = false
			end
		}, true)
	end
end

function LoginModule.GetNotice(userClick)
	local noticeParam = LoginModule.CreateLoginParam(nil)
	local jsonStr = json.encode(noticeParam)
	local url = LoginModule.GetRequestUrl(Constant.LoginConst.NoticeUrl)

	if userClick then
		HttpModule.RequestPost(url, jsonStr, LoginModule.OnClickNoticeSucceed, LoginModule.OnClickNoticeFailed)
	else
		HttpModule.RequestPost(url, jsonStr, LoginModule.OnSendNoticeSucceed, LoginModule.OnSendNoticeFailed)
	end
end

function LoginModule.OnClickNoticeSucceed(serverResponse)
	local response = json.decode(serverResponse)

	if response.code ~= 0 then
		warning("Send Notice error : " .. getErrorMsg(response.code))
	elseif #response.data.notices > 0 then
		UIModule.Open(Constant.UIControllerName.WebNoticeUI, Constant.UILayer.UI, {
			notices = response.data.notices
		})
	end
end

function LoginModule.OnClickNoticeFailed(serverResponse)
	warning("Send Notice error : " .. serverResponse)
end

function LoginModule.OnSendNoticeSucceed(serverResponse)
	local response = json.decode(serverResponse)

	if response.code ~= 0 then
		warning("Send Notice error : " .. getErrorMsg(response.code))
		SDKLoginModule.StartLogin()
	elseif #response.data.notices > 0 then
		UIModule.Open(Constant.UIControllerName.WebNoticeUI, Constant.UILayer.UI, {
			notices = response.data.notices,
			OnCloseCallback = SDKLoginModule.StartLogin
		})
	else
		SDKLoginModule.StartLogin()
	end
end

function LoginModule.OnSendNoticeFailed(serverResponse)
	warning("Send Notice error : " .. serverResponse)
	SDKLoginModule.StartLogin()
end

function LoginModule.CreatePlayerResult(roleInfoPOD)
	SDKLoginModule.CreateNewRole(roleInfoPOD)
end

function LoginModule.UpdateRoleLevelUpToSDK(value)
	SDKLoginModule.RoleLevelUp(value)
end

function LoginModule.ActiveAccount(uid, code)
	NetCommController.Sending()

	local data = {}

	data.uid = uid
	data.code = code

	local param = LoginModule.CreateLoginParam(data)
	local jsonStr = json.encode(param)
	local url = LoginModule.GetRequestUrl(Constant.LoginConst.ActiveAccountUrl)

	HttpModule.RequestPost(url, jsonStr, LoginModule.OnActiveAccountResponded, LoginModule.OnActiveAccountError)
end

function LoginModule.OnActiveAccountResponded(serverResponse)
	NetCommController.Responded()
	xpcall(function()
		local response = json.decode(serverResponse)

		if response.code == 0 then
			LoginModule.AccountIsNotActive = false

			EventDispatcher.Dispatch(EventID.ActiveAccountSuccess)
		elseif response.code == 100001 then
			NoticeModule.ShowNotice(21040122)
		else
			NoticeModule.ShowNoticeNoCallback(21040121, getErrorMsg(response.code))
		end
	end, function(msg)
		logError("serverResponse " .. tostring(serverResponse) .. "\n message: " .. tostring(msg))
	end)
end

function LoginModule.OnActiveAccountError(serverResponse)
	NetCommController.Responded()
	NoticeModule.ShowNoticeByType(1, LoginUIApi:GetString("AccountActiveFail"))
end

function LoginModule.LoginComplete(playerPOD)
	LoginModule.LoginScene:OnLeave()

	LoginModule.LoginScene = nil

	local e = LoginSucceedEventArgs()

	GameEntry.LuaEvent:Fire(nil, e)
	SDKLoginModule.EnterGame(playerPOD)

	LoginModule.LoginTimeForLog = PlayerModule.GetServerTime()

	if PlayerModule.InitSceneID == SceneID.MainCity then
		SceneManager.ChangeScene(SceneID.MainCity)
	elseif PlayerModule.InitSceneID == SceneID.Home then
		HomeLandLuaModule.EnterHome()
	elseif PlayerModule.InitSceneID == SceneID.Girl then
		net_girl.getGirls()
	end
end

function LoginModule.GetSimpleInfo()
	local data = LoginRequestData.New()

	data.uid = LoginModule.LoginResponse.data.uid
	data.serverId = LoginModule.LoginResponse.data.lastLoginServerId

	local loginParam = LoginModule.CreateLoginParam(data)
	local jsonStr = json.encode(loginParam)
	local url = LoginModule.GetRequestUrl(Constant.LoginConst.GetSimpleInfo)

	HttpModule.RequestPost(url, jsonStr, LoginModule.OnGetSimpleInfo, LoginModule.OnGetSimpleInfoError)
end

function LoginModule.OnGetSimpleInfo(serverResponse)
	local response = json.decode(serverResponse)

	if response.code ~= 0 then
		NoticeModule.ShowServerError(response.code)
	elseif response.data and response.data.Id then
		LoginModule.AccountInformation = response

		EventDispatcher.Dispatch(EventID.AccountTransferSimpleInfoEvent, response.data)
	else
		NoticeModule.ShowNotice(21042057)
	end
end

function LoginModule.OnGetSimpleInfoError(serverResponse)
	local response = json.decode(serverResponse)

	if response.code ~= 0 then
		NoticeModule.ShowServerError(response.code)
	end
end

function LoginModule.Send(phone)
	local data = LoginRequestData.New()

	data.phone = phone
	data.uid = LoginModule.LoginResponse.data.uid

	local loginParam = LoginModule.CreateLoginParam(data)
	local jsonStr = json.encode(loginParam)
	local url = LoginModule.GetRequestUrl(Constant.LoginConst.Send)

	HttpModule.RequestPost(url, jsonStr, LoginModule.OnSendMessageResponded, LoginModule.OnSendMessageError)

	LoginModule.LastSendMessageTimer = PlayerModule.GetServerTime()
end

function LoginModule.OnSendMessageResponded(serverResponse)
	local response = json.decode(serverResponse)

	if response.code ~= 0 then
		if response.code == 120017 then
			NoticeModule.ShowNotice(21042054)
		elseif response.code == 120018 then
			NoticeModule.ShowNotice(21042052)
		elseif response.code == 120020 then
			NoticeModule.ShowNotice(21042055)
		else
			NoticeModule.ShowServerError(response.code)
		end
	else
		NoticeModule.ShowNotice(21042054)
		log("短信验证码已发出,请注意查收")
	end
end

function LoginModule.OnSendMessageError(serverResponse)
	local response = json.decode(serverResponse)

	if response.code ~= 0 then
		NoticeModule.ShowServerError(response.code)
	end
end

function LoginModule.Verify(phone, code)
	local data = LoginRequestData.New()

	data.phone = phone
	data.code = code
	data.uid = LoginModule.LoginResponse.data.uid
	data.serverId = LoginModule.LoginResponse.data.lastLoginServerId

	local loginParam = LoginModule.CreateLoginParam(data)
	local jsonStr = json.encode(loginParam)
	local url = LoginModule.GetRequestUrl(Constant.LoginConst.Verify)

	HttpModule.RequestPost(url, jsonStr, LoginModule.OnVerify, LoginModule.OnVerifyError)
end

function LoginModule.OnVerify(serverResponse)
	local response = json.decode(serverResponse)

	if response.code ~= 0 then
		if response.code == 120018 then
			NoticeModule.ShowNotice(21042052)
		elseif response.code == 120019 then
			NoticeModule.ShowNotice(21042053)
		else
			NoticeModule.ShowServerError(response.code)
		end
	else
		LoginModule.LoginResponse.data.phone = response.data.phone

		UIModule.Close(Constant.UIControllerName.AccountTransferUI)
		EventDispatcher.Dispatch(EventID.AccountTransferSuccess)
		NoticeModule.ShowNotice(21042056)
	end
end

function LoginModule.OnVerifyError(serverResponse)
	local response = json.decode(serverResponse)

	if response.code ~= 0 then
		NoticeModule.ShowServerError(response.code)
	end
end
