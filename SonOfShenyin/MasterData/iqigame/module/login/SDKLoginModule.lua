-- chunkname: @IQIGame\\Module\\Login\\SDKLoginModule.lua

local m = {
	LoggedOutManually = false
}

m.ExtraFuncTypeEnum = {
	USER_CENTER = 10
}
m.MoneyTypeEnum = {
	[1] = "CNY"
}

local json = require("Util.json")

function m.IsSDKMode()
	return GameEntry.ProjectSetting:IsSDKMode()
end

function m.Init()
	m.AddSDKListener()
	m.StartLogin()
end

function m.AddSDKListener()
	IQIUSDK.Instance.OnLoginSuccess = m.LoginSuccess
	IQIUSDK.Instance.OnLoginFailed = m.LoginFail
	IQIUSDK.Instance.OnLoginCancel = m.LoginCancel
	IQIUSDK.Instance.OnSwitchSuccess = m.SwitchSuccess
	IQIUSDK.Instance.OnSwitchFailed = m.SwitchFail
	IQIUSDK.Instance.OnSwitchCancel = m.SwitchCancel

	function IQIUSDK.Instance.OnLogoutSuccess()
		LoginModule.Logout(SceneTransferModule.ReturnLogin)
	end

	IQIUSDK.Instance.OnLogoutFailed = m.LogoutFail

	function IQIUSDK.Instance.OnExitSuccess()
		LoginModule.Logout(LuaCodeInterface.QuitGame)
	end

	function IQIUSDK.Instance.OnExitCancel()
		PlayerModule.IsFirstQuit = false
	end

	function IQIUSDK.Instance.OnPaySuccess(payResultData)
		log("支付成功")
	end

	function IQIUSDK.Instance.OnPayFailed(payResultData)
		if payResultData.msg == "pay fail msg = PAY_CANCEL" then
			log("支付取消")

			return
		end

		log("支付失败")
		NoticeModule.ShowNoticeByType(Constant.NoticeType.BoxSingleButton, payResultData.msg)
	end

	function IQIUSDK.Instance.OnPayCancel(payResultData)
		log("支付取消")
	end
end

function m.StartLogin()
	if m.IsSDKMode() then
		if m.SwitchUserInfo == nil then
			IQIUSDK.Instance:login()

			m.LoggedOutManually = false
		else
			m.Login(m.SwitchUserInfo)

			m.SwitchUserInfo = nil
		end
	end
end

function m.LoginSuccess(userInfo)
	m.SDKUser = userInfo

	m.Login(userInfo)
end

function m.LoginFail(msg)
	NoticeModule.ShowNoticeByType(4, msg, function()
		m.StartLogin()
	end)
end

function m.LoginCancel()
	return
end

function m.SwitchAccount()
	if SDKLoginModule.IsSDKMode() then
		IQIGame.USDK.switchAccount()
	end
end

function m.SwitchSuccess(userInfo)
	m.SDKUser = userInfo
	m.SwitchUserInfo = userInfo

	LoginModule.Logout(ProcedureReset.ResetAndGoToLogin)
end

function m.SwitchFail(msg)
	NoticeModule.ShowNoticeByType(4, msg, function()
		m.StartLogin()
	end)
end

function m.SwitchCancel()
	return
end

function m.Login(userInfo)
	if userInfo.channelUid == nil then
		return
	end

	local version = LuaCodeInterface.GetDeviceInfo().version

	if version == "1.2.2" and SDKLoginModule.GetChannelId() == 18 then
		NoticeModule.ShowNoticeByType(4, "游戏版本过低，请到应用商店更新最新版本！", function()
			if IQIUSDK.Instance:getImgId() == 1 then
				Application.OpenURL("https://www.taptap.cn/app/235316")
			end

			if IQIUSDK.Instance:getImgId() == 2 then
				Application.OpenURL("https://www.3839.com/a/144043.htm")
			end
		end)

		return
	end

	NetCommController.Sending()

	local data = LoginRequestData.New()

	data.game_id = userInfo.channelUid
	data.uName = userInfo.username
	data.game_token = userInfo.token
	data.channel = m.GetChannelNo()
	data.packagechannel = ""
	data.deviceId = IQIUSDK.Instance:getUniqueId()
	data.app_id = m.GetAppId()
	data.traceId = IQIUSDK.Instance:getTraceID()

	local jsonStr = LoginModule.CreateLoginParam(data)
	local url = LoginModule.GetRequestUrl(Constant.LoginConst.LoginUrl)

	HttpModule.RequestPost(url, jsonStr, LoginModule.OnLoginResponded, LoginModule.OnLoginError)
end

function m.Logout(callback)
	if m.IsSDKMode() then
		m.LoggedOutManually = true
		m.LogoutCallback = callback

		IQIUSDK.Instance:logout()
	else
		callback()
	end
end

function m.LogoutSuccess()
	SDKLoginModule.SDKUser = nil

	if m.LogoutCallback ~= nil then
		m.LogoutCallback()
	end
end

function m.LogoutFail(msg)
	logError("[SDK]logout Error: " .. msg)

	if m.LogoutCallback ~= nil then
		m.LogoutCallback()
	end
end

function m.Exit()
	if m.IsSDKMode() then
		IQIUSDK.Instance:exit()
	end
end

function m.OpenUserCenter()
	if m.IsSDKMode() then
		local jsonData = "{}"

		IQIUSDK.Instance:extraFunc(m.ExtraFuncTypeEnum.USER_CENTER, jsonData)
	end
end

function m.GetPaySign(goodsId)
	local data = PaySignData.New()

	data.role_id = PlayerModule.PlayerInfo.baseInfo.guid
	data.role_name = PlayerModule.PlayerInfo.baseInfo.pName
	data.server_id = PlayerModule.PlayerInfo.baseInfo.serverId
	data.product_id = goodsId
	data.money = CfgCommodityTable[goodsId].Price[1][2]
	data.currency_type = "CNY"
	data.extension = ""
	data.areaId = LoginModule.SelectedServer.areaId
	data.sdkName = PlayerModule.PlayerInfo.baseInfo.sdkName
	data.pid = PlayerModule.PlayerInfo.baseInfo.pid
	data.uid = PlayerModule.PlayerInfo.baseInfo.uid

	local jsonStr = LoginModule.CreateLoginParam(data)
	local url = LoginModule.GetRequestUrl(Constant.LoginConst.PaySignUrl)

	log("Request url=>" .. url)
	HttpModule.RequestPost(url, jsonStr, m.OnCreateRechargeOrderSuccess, m.OnCreateRechargeOrderFailure)
end

function m.OnCreateRechargeOrderSuccess(serverResponse)
	log("创建订单成功")
	m.Pay(serverResponse)
end

function m.OnCreateRechargeOrderFailure(serverResponse)
	log("创建订单失败")
end

function m.Pay(responseData)
	responseData = LoginModule.HttpDecrypt(responseData)

	log("Request Pay Order Success=>" .. tostring(responseData))

	local data = json.decode(responseData)

	if data.code ~= 0 then
		NoticeModule.ShowNoticeByType(1, getErrorMsg(data.code))

		return
	end

	local roleInfo = m.CreateRoleInfoByPlayerInfo(PlayerModule.PlayerInfo)
	local payData = IQIGame.USDK.PaymentParameters()

	payData.productId = data.data.product_id
	payData.cpExtras = data.data.extraParams
	payData.cpOrderId = data.data.orderId
	payData.notifyUrl = data.data.notify_url

	IQIUSDK.Instance:pay(payData, roleInfo)
end

function m.GetAppId()
	return tostring(1002)
end

function m.GetProtocolResultInfo()
	return nil
end

function m.GetImgId()
	if not m.IsSDKMode() then
		return
	end

	local imgId = IQIUSDK.Instance:getImgId()

	if imgId == 1 or imgId == 11 then
		return 1
	end

	if imgId == 2 or imgId == 12 then
		return 2
	end

	return imgId
end

function m.IsChannelHasExitDialog()
	if not m.IsSDKMode() then
		return false
	end

	return IQIUSDK.Instance:isSupportExitDialog()
end

function m.GetChannelId()
	if not m.IsSDKMode() then
		return
	end

	return IQIUSDK.Instance:getChannelId()
end

function m.GetChannelNo()
	if not m.IsSDKMode() then
		return
	end

	local channelId = SDKLoginModule.GetChannelId()

	if channelId == 18 then
		channelId = channelId .. "_" .. SDKLoginModule.GetImgId()
	end

	return tostring(channelId)
end

function m.GetIsOfficialChannel()
	if not m.IsSDKMode() then
		return true
	end

	local channelId = SDKLoginModule.GetChannelId()

	return channelId == 18 or channelId == 56
end

function m.CreateNewRole(roleInfoPOD)
	if m.IsSDKMode() then
		IQIUSDK.Instance:createNewRole(m.CreateRoleInfoByPlayerInfo(PlayerModule.PlayerInfo))
	end
end

function m.SelectServer()
	if m.IsSDKMode() then
		IQIUSDK.Instance:roleSelectServer(m.CreateRoleInfo())
	end
end

function m.EnterGame(playerPOD)
	if m.IsSDKMode() then
		IQIUSDK.Instance:enterGame(m.CreateRoleInfoByPlayerInfo(playerPOD))
	end
end

function m.RoleLevelUp(value)
	if m.IsSDKMode() then
		IQIUSDK.Instance:roleLevelUp(m.CreateRoleInfoByPlayerInfo(PlayerModule.PlayerInfo))
	end
end

function m.RoleSelectServer(roleInfoPOD)
	if m.IsSDKMode() then
		IQIUSDK.Instance:roleSelectServer(m.CreateRoleInfoByRoleInfo(roleInfoPOD))
	end
end

function m.RoleExitGame()
	if m.IsSDKMode() then
		IQIUSDK.Instance:roleExitGame(m.CreateRoleInfoByPlayerInfo(PlayerModule.PlayerInfo))
	end
end

function m.CreateRoleInfo()
	local roleInfo = IQIGame.USDK.RoleInfo()

	if PlayerModule._ServerTime ~= 0 then
		roleInfo.timestamp = PlayerModule.GetServerTime() * 1000
	else
		roleInfo.timestamp = os.time() * 1000
	end

	roleInfo.serverId = LoginModule.selectedServerInfo.areaId
	roleInfo.serverName = LoginModule.selectedServerInfo.serverName

	return roleInfo
end

function m.CreateRoleInfoByRoleInfo(roleInfoPOD)
	local roleInfo = m.CreateRoleInfo()

	roleInfo.roleId = roleInfoPOD.pid
	roleInfo.roleName = roleInfoPOD.pname
	roleInfo.roleLevel = tostring(roleInfoPOD.lv)
	roleInfo.vipLevel = "0"
	roleInfo.rolePower = "0"
	roleInfo.roleBalance = ""
	roleInfo.roleCreateTime = tostring(roleInfoPOD.createTime * 1000)
	roleInfo.partyName = ""
	roleInfo.partyId = "0"
	roleInfo.roleGender = ""
	roleInfo.partyRoleName = ""
	roleInfo.professionId = ""
	roleInfo.professionName = ""
	roleInfo.friendList = ""

	return roleInfo
end

function m.CreateRoleInfoByPlayerInfo(playerPOD)
	local roleInfo = m.CreateRoleInfo()

	roleInfo.roleId = playerPOD.baseInfo.pid
	roleInfo.roleName = playerPOD.baseInfo.pName
	roleInfo.roleLevel = tostring(playerPOD.baseInfo.pLv)
	roleInfo.vipLevel = "0"
	roleInfo.rolePower = "0"
	roleInfo.roleBalance = ""
	roleInfo.roleCreateTime = tostring(playerPOD.baseInfo.createTime * 1000)
	roleInfo.partyName = playerPOD.guildName
	roleInfo.partyId = "0"
	roleInfo.roleGender = "0"
	roleInfo.partyRoleName = playerPOD.baseInfo.pName
	roleInfo.professionId = ""
	roleInfo.professionName = ""
	roleInfo.friendList = ""

	return roleInfo
end

function m.SensitiveWordFilter(input, callBack)
	if WarnStrFunc:isWarningInPutStr(input) then
		callBack(WarnStrFunc:warningStrGsub(input), true)
	else
		callBack(input, false)
	end
end

function m.Dispose()
	return
end

SDKLoginModule = m
