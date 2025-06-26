-- chunkname: @IQIGame\\Module\\Login\\LoginModule.lua

local json = require("Util.json")

LoginModule = {
	IsCheckExitGame = false,
	LoginTimeForLog = 0,
	NeedReconnect = false,
	FirstLogin = true,
	RecordMsgLength = false,
	IsLogining = false,
	IsFirstShowLoginNotice = true,
	isOpenNotice = false,
	LoginClickCount = 0,
	AccountIsNotActive = false,
	ReadMsgLength = 0,
	ReloadFlag = false,
	NoticeCacheList = {}
}

function LoginModule.StartLogin()
	LoginModule.NeedReconnect = false
	LoginModule.ReConnectChannelName = nil
	LoginModule.ReloadFlag = false
	LoginModule.Reloading = false
	LoginModule.ReconnectToken = nil
	LoginModule.ReadMsgLength = 0
	LoginModule.RecordMsgLength = false
	LoginModule.IsLogining = false
	LoginModule.IsCheckExitGame = false
	LoginModule.ReConnectCount = 0

	PlayerModule.StateLogOut()
	EventDispatcher.AddEventListener(EventID.UpdateConnectToken, LoginModule.OnUpdateConnectToken)
	UIModule.Open(Constant.UIControllerName.LoginUI, Constant.UILayer.UI)

	LoginModule.LoginClickCount = PlayerPrefsUtil.GetInt("", Constant.PlayerPrefsConst.LoginClickCount, 0)
end

function LoginModule.OnUpdateConnectToken(reconnectToken)
	EventDispatcher.RemoveEventListener(EventID.UpdateConnectToken, LoginModule.OnUpdateConnectToken)

	LoginModule.ReconnectToken = reconnectToken
	LoginModule.ReadMsgLength = 0
	LoginModule.RecordMsgLength = true
	LoginModule.Reloading = false
	LoginModule.ReConnectCount = 0

	NetCommController.Responded()
	log("重连接受数据完毕")
end

function LoginModule.AddReadBytesLength(length)
	if LoginModule.RecordMsgLength then
		LoginModule.ReadMsgLength = LoginModule.ReadMsgLength + length
	end
end

local httpEncryptKey = "e6b745f8-4bd4-4401-840b-96e6ffc1f565"

function LoginModule.CreateLoginParam(data, notEncrypt)
	notEncrypt = false

	local loginParam = LoginRequestParam.New()

	loginParam.common = LoginModule.CreateCommonData()
	loginParam.sign = "10086"

	if SDKLoginModule.IsSDKMode() then
		loginParam.common.channelNo = SDKLoginModule.GetChannelNo()
	end

	if data ~= nil then
		loginParam.data = data
	end

	loginParam.time = os.time()

	local jsonStr = json.encode(loginParam)

	log("[Log]LoginParam: " .. jsonStr)

	if notEncrypt then
		return jsonStr
	end

	local sojumpparm = StringSecurityUtils.EncodeBase64(jsonStr)
	local encryptJsonStr = StringSecurityUtils.SHA1Encrypt(sojumpparm .. httpEncryptKey)

	return sojumpparm .. "|" .. encryptJsonStr
end

function LoginModule.HttpDecrypt(responseData)
	local content = string.split(responseData, "|")
	local parmsign = StringSecurityUtils.SHA1Encrypt(content[1] .. httpEncryptKey)

	if string.find(parmsign, content[2]) == nil then
		logError("sign error :  json=" + responseData)
	end

	local source = StringSecurityUtils.DecodeBase64(content[1])

	return source
end

function LoginModule.CreateCommonData()
	local data = LuaCodeInterface.GetDeviceInfo()
	local o = CommonData.New()

	for k, v in pairs(data) do
		o[k] = v
	end

	return o
end

function LoginModule.GetGuestInfo()
	local jsonStr = LoginModule.CreateLoginParam(nil)
	local url = LoginModule.GetRequestUrl(Constant.LoginConst.GuestAccountUrl)

	HttpModule.RequestPost(url, jsonStr, LoginModule.OnGetGuestNamePwdSucceed, LoginModule.OnGetGuestNamePwdFailed)
end

function LoginModule.OnGetGuestNamePwdSucceed(serverResponse)
	local up = json.decode(LoginModule.HttpDecrypt(serverResponse))

	EventDispatcher.Dispatch(EventID.GetGuestInfoSuceed, up.data.uName, up.data.pwd)
end

function LoginModule.OnGetGuestNamePwdFailed(serverResponse)
	EventDispatcher.Dispatch(EventID.GetGuestInfoFailed, serverResponse)
end

function LoginModule.Login(username, password)
	NetCommController.Sending()

	local data = LoginRequestData.New()

	data.uName = username
	data.pwd = password
	LoginModule.LoginRequestData = data

	local jsonStr = LoginModule.CreateLoginParam(data)

	log(jsonStr)

	local url = LoginModule.GetRequestUrl(Constant.LoginConst.LoginUrl)

	HttpModule.RequestPost(url, jsonStr, LoginModule.OnLoginResponded, LoginModule.OnLoginError)
end

function LoginModule.Logout(callback)
	LoginModule.NeedReconnect = false

	if PlayerModule.InGame and NetManager.IsConnect then
		if PlayerModule.InGaming then
			SDKLoginModule.RoleExitGame()
		end

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
	serverResponse = LoginModule.HttpDecrypt(serverResponse)

	NetCommController.Responded()

	local function notifyCSharp(msg)
		local e = LoginFailedEventArgs()

		e.ResponseCode = -1
		e.errorText = msg

		GameEntry.LuaEvent:Fire(nil, e)
	end

	local function onLogFailed(msg)
		NoticeModule.ShowNotice(21040009)
		logError("登陆失败。" .. tostring(msg) .. "\nServer response: " .. serverResponse)
		notifyCSharp(msg)
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

				LoginModule.OnPlayerPrefsSaveAccount(uName, pwd)
				EventDispatcher.Dispatch(EventID.GetUserInfo, uName)
			else
				EventDispatcher.Dispatch(EventID.GetUserInfo, "")
			end

			PlayerModule.InGame = true
			LoginModule.AccountIsNotActive = response.data.activation

			if LoginModule.IsFirstShowLoginNotice then
				UIModule.Open(Constant.UIControllerName.NoticeUI, Constant.UILayer.UI, {
					1
				})

				LoginModule.IsFirstShowLoginNotice = false
			end

			EventDispatcher.Dispatch(EventID.GetServerList, response.data.districts, response.data.lastLoginServerId, response.data.uid)
		elseif response.code == 120005 then
			NoticeModule.ShowNoticeByType(4, "游戏资源版本过低，请重进游戏更新！", function()
				LuaCodeInterface.QuitGame()
			end)
		elseif response.code == 120001 then
			NoticeModule.ShowNotice(21051002)
			notifyCSharp("response.code: 120001")
		elseif response.code == 120002 then
			NoticeModule.ShowNotice(21051002)
			notifyCSharp("response.code: 120002")
		elseif response.code == 120006 then
			NoticeModule.ShowNotice(21051002)
			notifyCSharp("response.code: 120006")
		elseif response.code == 120003 then
			notifyCSharp("response.code: 120003")
		elseif response.code == 120014 then
			NoticeModule.ShowServerError(response.code)
			notifyCSharp("response.code: 120014")
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

	local jsonStr = LoginModule.CreateLoginParam(data)
	local url = ""

	url = LoginModule.GetRequestUrl(Constant.LoginConst.RegisterUrl)

	HttpModule.RequestPost(url, jsonStr, LoginModule.OnRegisterSucceed, LoginModule.OnRegisterFailed)
end

function LoginModule.OnRegisterSucceed(serverResponse)
	local response = json.decode(LoginModule.HttpDecrypt(serverResponse))

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
	log("注册失败, 原因 : ", serverResponse)
end

function LoginModule.OnLoginError(serverResponse)
	NetCommController.Responded()

	local e = LoginFailedEventArgs()

	e.ResponseCode = -1
	e.errorText = serverResponse

	GameEntry.LuaEvent:Fire(LoginModule, e)
	NoticeModule.ShowNoticeByType(1, "登录失败，请点击重新登录！")
end

function LoginModule.EnterGame(selectedServerInfo)
	if LoginModule.IsLogining then
		return
	end

	NetCommController.Sending()
	LoginModule.EnterGameLineServer(selectedServerInfo)
end

function LoginModule.EnterGameLineServer(selectedServerInfo)
	local function func()
		LoginModule.IsLogining = true
		LoginModule.NeedReconnect = false
		LoginModule.selectedServerInfo = selectedServerInfo

		if NetManager.IsConnect then
			LoginModule.ValidateUUID()
		else
			log("-> 登录添加网络监听")

			LoginModule.ReConnectCount = 0

			EventDispatcher.AddEventListener(EventID.NetworkConnected, LoginModule.OnConnected)
			EventDispatcher.AddEventListener(EventID.NetworkError, LoginModule.OnConnectError)
			EventDispatcher.AddEventListener(EventID.NetworkClosed, LoginModule.OnConnectError)
			NetManager.ConnectToChannel(NetworkChannelName.Game, selectedServerInfo.serverIp, selectedServerInfo.port)
		end
	end

	if selectedServerInfo.state == 0 then
		NoticeModule.ShowNoticeByType(Constant.NoticeType.BoxSingleButton, selectedServerInfo.downTimeInfo, function()
			func()
		end)
		NetCommController.Responded()

		return
	end

	func()
end

function LoginModule.RequestSDKServerSucces(serverResponse)
	local decryptStr = LoginModule.HttpDecrypt(serverResponse)

	serverResponse = json.decode(decryptStr)

	log("服务器地址请求成功" .. tostring(decryptStr))

	local data = serverResponse

	if data.code == 0 then
		LoginModule.SelectedServer.areaId = data.data.district.areaId
		LoginModule.SelectedServer.serverId = data.data.district.serverId
		data.data.district.status = LoginModule.SelectedServer.status

		LoginModule.EnterGameLineServer(data.data.district)
	end
end

function LoginModule.RequestSDKServerFail(serverResponse)
	log("服务器地址请求失败" .. serverResponse)
	NoticeModule.ShowNoticeByType(4, "获取服务器列表失败,请重启客户端！", function()
		LoginModule.Logout(LuaCodeInterface.QuitGame)
	end)
end

function LoginModule.OnConnected()
	LoginModule.NeedReconnect = true

	log("-> 连接成功移除网络监听")
	EventDispatcher.RemoveEventListener(EventID.NetworkConnected, LoginModule.OnConnected)
	EventDispatcher.RemoveEventListener(EventID.NetworkError, LoginModule.OnConnectError)
	EventDispatcher.RemoveEventListener(EventID.NetworkClosed, LoginModule.OnConnectError)
	NetCommController.Responded()
end

function LoginModule.ValidateUUID()
	local loginResponse = LoginModule.LoginResponse

	net_user.validateUUID(loginResponse.data.uuid, LoginModule.selectedServerInfo.serverId, loginResponse.data.accountServerId)
end

function LoginModule.OnConnectError()
	LoginModule.IsLogining = false

	log("-> 连接错误移除网络监听")
	EventDispatcher.RemoveEventListener(EventID.NetworkConnected, LoginModule.OnConnected)
	EventDispatcher.RemoveEventListener(EventID.NetworkError, LoginModule.OnConnectError)
	EventDispatcher.RemoveEventListener(EventID.NetworkClosed, LoginModule.OnConnectError)
	NoticeModule.ShowNotice(21040009, nil, nil, nil)
	NetCommController.Responded()
end

function LoginModule.ReConnect(channelName)
	NetCommController.Sending()

	if LoginModule.ReConnectCount >= 3 then
		log(string.format("-> 重连已达%s次失败", LoginModule.ReConnectCount))
		LoginModule.OnReConnectError()
	else
		LoginModule.NeedReconnect = false
		LoginModule.ReConnectCount = LoginModule.ReConnectCount + 1
		LoginModule.ReloadFlag = true
		LoginModule.RecordMsgLength = false
		LoginModule.ReConnectChannelName = channelName

		log(string.format("-> 尝试第%s次重连", LoginModule.ReConnectCount))

		local selectedServerInfo = LoginModule.selectedServerInfo

		EventDispatcher.AddEventListener(EventID.NetworkConnected, LoginModule.OnReConnected)
		EventDispatcher.AddEventListener(EventID.NetworkError, LoginModule.OnReConnectError)
		EventDispatcher.AddEventListener(EventID.NetworkClosed, LoginModule.OnReConnectError)
		NetManager.ConnectToChannel(channelName, selectedServerInfo.serverIp, selectedServerInfo.port)
	end
end

function LoginModule.OnReConnected()
	log("-> 重连成功移除网络监听")

	LoginModule.NeedReconnect = true

	EventDispatcher.RemoveEventListener(EventID.NetworkConnected, LoginModule.OnReConnected)
	EventDispatcher.RemoveEventListener(EventID.NetworkError, LoginModule.OnReConnectError)
	EventDispatcher.RemoveEventListener(EventID.NetworkClosed, LoginModule.OnReConnectError)
	EventDispatcher.AddEventListener(EventID.UpdateConnectToken, LoginModule.OnUpdateConnectToken)
end

function LoginModule.Reload()
	log("------------------LoginModule.Reload")

	LoginModule.ReloadFlag = false
	LoginModule.Reloading = true

	net_player.reloadPlayer(LoginModule.ReconnectToken, LoginModule.ReadMsgLength, PlayerModule.PlayerInfo.baseInfo.pid, LoginModule.SelectedServer.serverId)
	log(string.format("%s  %s  %s %s", LoginModule.ReconnectToken, LoginModule.ReadMsgLength, PlayerModule.PlayerInfo.baseInfo.pid, LoginModule.SelectedServer.serverId))
end

function LoginModule.OnReConnectError()
	log("-> 重连失败移除网络监听")
	NetCommController.Responded()
	EventDispatcher.RemoveEventListener(EventID.NetworkConnected, LoginModule.OnReConnected)
	EventDispatcher.RemoveEventListener(EventID.NetworkError, LoginModule.OnReConnectError)
	EventDispatcher.RemoveEventListener(EventID.NetworkClosed, LoginModule.OnReConnectError)

	LoginModule.NeedReconnect = false

	NoticeModule.ShowNotice(21040010, LoginModule.ConfirmReconnect, LoginModule.AbandonReconnect, nil)
end

function LoginModule.ConfirmReconnect()
	LoginModule.ReConnectCount = 0

	LoginModule.ReConnect(LoginModule.ReConnectChannelName)
end

function LoginModule.AbandonReconnect()
	LoginModule.Logout(SceneTransferModule.ReturnLogin)
end

function LoginModule.OnPlayerExitGame()
	if SDKLoginModule.IsSDKMode() then
		if SDKLoginModule.IsChannelHasExitDialog() then
			SDKLoginModule.Exit()
		else
			NoticeModule.ShowNoticeByType(5, "是否退出游戏？", function()
				SDKLoginModule.Exit()
			end, function()
				PlayerModule.IsFirstQuit = false
			end)
		end

		return
	end

	NoticeModule.ShowNoticeByType(5, "是否退出游戏？", function()
		LoginModule.Logout(LuaCodeInterface.QuitGame)
	end, function()
		PlayerModule.IsFirstQuit = false
	end)
end

function LoginModule.ActiveAccount(uid, code)
	NetCommController.Sending()

	local data = {}

	data.uid = uid
	data.code = code
	LoginModule.AccountActiveCode = code

	local jsonStr = LoginModule.CreateLoginParam(data)
	local url = LoginModule.GetRequestUrl(Constant.LoginConst.ActiveAccountUrl)

	HttpModule.RequestPost(url, jsonStr, LoginModule.OnActiveAccountResponded, LoginModule.OnActiveAccountError)
end

function LoginModule.OnActiveAccountResponded(serverResponse)
	serverResponse = LoginModule.HttpDecrypt(serverResponse)

	NetCommController.Responded()
	xpcall(function()
		local response = json.decode(serverResponse)

		if response.code == 0 then
			LoginModule.AccountIsNotActive = false

			EventDispatcher.Dispatch(EventID.ActiveAccountSuccess)

			return
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
	NoticeModule.ShowNoticeByType(1, "由于网络原因，账号激活失败！")
end

function LoginModule.OnPlayerPrefsSaveAccount(username, userpwd)
	LoginModule.PlayerAccount = {}

	PlayerPrefsUtil.SetString("", Constant.PlayerPrefsConst.UserName, username)
	PlayerPrefsUtil.SetString("", Constant.PlayerPrefsConst.Password, userpwd)
end

function LoginModule.GetChannelName()
	return "iqigame"
end
