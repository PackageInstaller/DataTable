-- chunkname: @IQIGame\\Module\\Login\\SDKLoginModule.lua

local m = {
	LoggedOutManually = false
}
local json = require("Util.json")

function m.IsSDKMode()
	return GameEntry.ProjectSetting:IsSDKMode()
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

function m.GetChannelId()
	if not m.IsSDKMode() then
		return
	end

	return IQIUSDK.Instance:getChannelId()
end

function m.GetImgId()
	if not m.IsSDKMode() then
		return
	end

	local imgId = IQIUSDK.Instance:getImgId()

	if imgId == 0 then
		return "P36711A"
	end

	if imgId == 1 or imgId == 21 then
		return "P36851A"
	end

	if imgId == 2 or imgId == 22 then
		return "P36852A"
	end

	return imgId
end

function m.IsChannelHasExitDialog()
	if not m.IsSDKMode() then
		return false
	end

	return IQIUSDK.Instance:isSupportExitDialog()
end

function m.StartLogin()
	if m.IsSDKMode() then
		if m.SwitchUserInfo == nil then
			m.LogSDKLogin(0)

			IQIUSDK.Instance.OnLoginSuccess = m.LoginSuccess
			IQIUSDK.Instance.OnLoginFailed = m.LoginFail
			IQIUSDK.Instance.OnLoginCancel = m.LoginCancel
			IQIUSDK.Instance.OnSwitchSuccess = m.SwitchSuccess
			IQIUSDK.Instance.OnSwitchFailed = m.SwitchFail
			IQIUSDK.Instance.OnSwitchCancel = m.SwitchCancel

			function IQIUSDK.Instance.OnExitSuccess()
				LoginModule.Logout(LuaCodeInterface.QuitGame)
			end

			function IQIUSDK.Instance.OnLogoutSuccess()
				LoginModule.Logout(ProcedureReset.ResetAndGoToLogin)
			end

			function IQIUSDK.Instance.OnPaySuccess(payResultData)
				EventDispatcher.Dispatch(EventID.PayOver, 0)
			end

			function IQIUSDK.Instance.OnPayFailed(payResultData)
				EventDispatcher.Dispatch(EventID.PayOver, 1)
				NoticeModule.ShowNoticeByType(1, payResultData.msg)
			end

			function IQIUSDK.Instance.OnPayCancel(payResultData)
				EventDispatcher.Dispatch(EventID.PayOver, 2)
			end

			IQIUSDK.Instance:login()

			m.LoggedOutManually = false
		else
			m.Login(m.SwitchUserInfo)

			m.SwitchUserInfo = nil
		end
	end
end

function m.LoginSuccess(userInfo)
	SDKLoginModule.SDKUser = userInfo

	m.Login(userInfo)
	m.LogSDKLogin(1)
end

function m.SwitchSuccess(userInfo)
	SDKLoginModule.SDKUser = userInfo
	m.SwitchUserInfo = userInfo

	LoginModule.Logout(ProcedureReset.ResetAndGoToLogin)
	m.LogSDKLogin(1)
end

function m.LoginFail(msg)
	logError("[SDK]login Error: " .. msg)
	NoticeModule.ShowNoticeByType(4, LoginUIApi:GetString("SDKLoginFailNotice"), function()
		SDKLoginModule.StartLogin()
	end)
	m.LogSDKLogin(2)
end

function m.SwitchFail(msg)
	logError("[SDK]switch Error: " .. msg)
	NoticeModule.ShowNoticeByType(4, LoginUIApi:GetString("SDKLoginFailNotice"), function()
		SDKLoginModule.StartLogin()
	end)
	m.LogSDKLogin(2)
end

function m.LoginCancel()
	m.LogSDKLogin(3)
end

function m.SwitchCancel()
	m.LogSDKLogin(3)
end

function m.Login(userInfo)
	if userInfo.channelUid == nil then
		return
	end

	local version = LuaCodeInterface.GetDeviceInfo().version

	if version == "0.49.0" and SDKLoginModule.GetChannelId() == 18 then
		NoticeModule.ShowNoticeByType(4, "游戏版本过低，请到应用商店更新最新版本！", function()
			if IQIUSDK.Instance:getImgId() == 1 then
				Application.OpenURL("https://www.taptap.cn/app/171371")
			end

			if IQIUSDK.Instance:getImgId() == 2 then
				Application.OpenURL("https://www.3839.com/a/113882.htm")
			end
		end)

		return
	end

	LuaCodeInterface.SetBuglyUserId(userInfo.channelUid)
	NetCommController.Sending()

	local data = LoginRequestData.New()

	data.cUid = userInfo.channelUid
	data.cName = userInfo.username
	data.accessToken = userInfo.token
	data.channel_id = m.GetChannelId()
	data.login_channel_id = m.GetChannelId()
	data.channel_name = IQIUSDK.Instance:getChannelName()
	data.device_id = IQIUSDK.Instance:getUniqueId()
	data.client_os = LuaCodeInterface.GetOS()

	local otherAccountLogin = PlayerPrefsUtil.GetInt("", Constant.PlayerPrefsConst.ChangeAccountPlatform, 0)

	if otherAccountLogin == 1 then
		if data.channel_id == 18 then
			data.login_channel_id = 56
		elseif data.channel_id == 56 then
			data.login_channel_id = 18
		end
	end

	if data.login_channel_id == 18 then
		data.checkOtherAccount = "56_" .. data.cUid
	elseif data.login_channel_id == 56 then
		data.checkOtherAccount = "18_" .. data.cUid
	end

	local loginParam = LoginModule.CreateLoginParam(data)
	local jsonStr = json.encode(loginParam)
	local url = LoginModule.GetRequestUrl(Constant.LoginConst.LoginUrl)

	HttpModule.RequestPost(url, jsonStr, LoginModule.OnLoginResponded, LoginModule.OnLoginError)
end

function m.CreateNewRole(roleInfoPOD)
	if m.IsSDKMode() then
		IQIUSDK.Instance:createNewRole(m.CreateRoleInfoByRoleInfo(roleInfoPOD))
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

function m.Logout(callback)
	if m.IsSDKMode() then
		m.LoggedOutManually = true
		m.LogoutCallback = callback
		IQIUSDK.Instance.OnLogoutSuccess = m.LogoutSuccess
		IQIUSDK.Instance.OnLogoutFailed = m.LogoutFail

		IQIUSDK.Instance:logout()
	else
		callback()
	end
end

function m.Exit(callback)
	if m.IsSDKMode() then
		function IQIUSDK.Instance.OnExitSuccess()
			callback()
		end

		IQIUSDK.Instance:exit()
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

function m.CreateRechargeOrder(goodsId)
	local data = CreateRechargeOrderData.New()

	data.serverId = PlayerModule.PlayerInfo.baseInfo.serverId
	data.areaId = PlayerModule.PlayerInfo.baseInfo.areaId
	data.uid = PlayerModule.PlayerInfo.baseInfo.uid
	data.pid = PlayerModule.PlayerInfo.baseInfo.pid
	data.pname = PlayerModule.PlayerInfo.baseInfo.pName
	data.goodsId = goodsId

	local loginParam = LoginModule.CreateLoginParam(data)
	local jsonStr = json.encode(loginParam)
	local url = LoginModule.GetRequestUrl(Constant.LoginConst.CreateRechargeOrderUrl)

	HttpModule.RequestPost(url, jsonStr, m.OnCreateRechargeOrderSuccess, m.OnCreateRechargeOrderFailure)
end

function m.OnCreateRechargeOrderSuccess(serverResponse)
	local responseData = json.decode(serverResponse)

	m.Pay(responseData)
end

function m.OnCreateRechargeOrderFailure(serverResponse)
	EventDispatcher.Dispatch(EventID.PayOver, 1)
end

function m.Pay(responseData)
	if responseData.code ~= 0 then
		NoticeModule.ShowServerError(responseData.code)

		return
	end

	if m.IsSDKMode() then
		local roleInfo = m.CreateRoleInfoByPlayerInfo(PlayerModule.PlayerInfo)
		local payData = IQIGame.USDK.PaymentParameters()

		payData.productId = responseData.data.goodsId
		payData.cpExtras = responseData.data.extraParams
		payData.cpOrderId = responseData.data.orderId

		SDKLoginModule.LogCreateOrder(responseData.data.goodsId, responseData.data.goodsId, responseData.data.createTime, responseData.data.orderId)
		IQIUSDK.Instance:pay(payData, roleInfo)
	else
		EventDispatcher.Dispatch(EventID.PayOver, 1)
	end
end

function m.GetProtocolResultInfo()
	return nil
end

function m.Log(data)
	if m.IsSDKMode() then
		local bdcData = {}

		bdcData.user_id = "0"

		if LoginModule.selectedServerInfo ~= nil then
			bdcData.server_id = LoginModule.selectedServerInfo.areaId
		else
			bdcData.server_id = "0"
		end

		bdcData.role_id = "0"
		bdcData.role_key = "0"

		if PlayerModule.InGame then
			bdcData.role_id = tostring(PlayerModule.PlayerInfo.baseInfo.guid)
			bdcData.role_key = PlayerModule.PlayerInfo.baseInfo.pid
		end

		bdcData.event_name = SDKLogEventIDName[data.event_id]

		for k, v in pairs(data) do
			bdcData[k] = v
		end

		LuaCodeInterface.LogForSDK(SDKLogEventIDName[data.event_id], bdcData)
	end
end

function m.LogSDKLogin(state)
	m.Log({
		event_id = SDKLogEventID.sdk_login,
		login_state = tostring(state)
	})
end

function m.LogFirstPageAfterLogin()
	m.Log({
		event_id = SDKLogEventID.after_sdk_login_page
	})
end

function m.LogRequestServerState(state)
	m.Log({
		event_id = SDKLogEventID.service_state,
		sl_server_id = LoginModule.selectedServerInfo.areaId,
		service_state = tostring(state)
	})
end

function m.LogLogin(state, failReason)
	local data = {
		role_login_reason = "0",
		event_id = SDKLogEventID.role_login,
		role_login_state = tostring(state)
	}

	if state == 2 then
		data.role_login_reason = failReason
	end

	m.Log(data)
end

function m.LogCreateRole(state, guid, pid, failReason)
	if guid == nil then
		guid = 0
	end

	if pid == nil then
		pid = "0"
	end

	local data = {
		creat_fail_reason = "0",
		event_id = SDKLogEventID.create_role,
		creat_role_state = tostring(state),
		role_id = tostring(guid),
		role_key = pid
	}

	if state == 3 then
		data.creat_fail_reason = failReason
	end

	m.Log(data)
end

function m.LogGetUserInfoAfterLogin()
	m.Log({
		event_id = SDKLogEventID.userInfo,
		role_name = PlayerModule.PlayerInfo.baseInfo.pName,
		role_level = tostring(PlayerModule.PlayerInfo.baseInfo.pLv),
		vip_level = tostring(PlayerModule.PlayerInfo.baseInfo.vip),
		phy_balance = tostring(WarehouseModule.GetItemNumByCfgID(Constant.ItemID.ENERGY)),
		currency_info = json.encode(WarehouseModule.GetCurrencyTable())
	})
end

function m.LogEnterHall(elapseTimeFromLogin)
	m.Log({
		event_id = SDKLogEventID.into_game,
		duration_time = tostring(math.floor(elapseTimeFromLogin))
	})
end

function m.LogGetTaskReward(taskCid, state)
	m.Log({
		event_id = SDKLogEventID.award_button_click,
		taskid = tostring(taskCid),
		get_award_state = tostring(state)
	})
end

function m.UserGuide(guide_id, guide_num)
	m.Log({
		event_id = SDKLogEventID.user_guide,
		guide_id = tostring(guide_id),
		guide_num = tostring(guide_num)
	})
end

function m.LogCreateOrder(product_id, product_type, order_create_time, game_order_id)
	m.Log({
		event_id = SDKLogEventID.create_order,
		product_id = tostring(product_id),
		product_type = tostring(product_type),
		order_create_time = tostring(math.floor(order_create_time)),
		game_order_id = tostring(game_order_id)
	})
end

function m.LogChargeInfo(open_id, order_id, game_order_id, product_id, product_type, amount, unit, pay_time, role_name)
	m.Log({
		get_time = "0",
		extra_get2 = "0",
		payment_method = "0",
		extra_get1 = "0",
		total_charge = "0",
		role_level = "0",
		money_type = "0",
		vip_level = "0",
		event_id = SDKLogEventID.ChargeInfo,
		open_id = tostring(open_id),
		order_id = tostring(order_id),
		game_order_id = tostring(game_order_id),
		product_id = tostring(product_id),
		product_type = tostring(product_type),
		amount = tostring(amount),
		unit = tostring(unit),
		pay_time = tostring(pay_time),
		role_name = tostring(role_name)
	})
end

function m.LogChangeShowGirl(point, soul_cid, dress2d_cid, dress3d_cid)
	m.Log({
		event_id = SDKLogEventID.change_show_girl,
		point = point,
		soul_cid = soul_cid,
		dress2d_cid = dress2d_cid,
		dress3d_cid = dress3d_cid
	})
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
	roleInfo.roleName = "-1"
	roleInfo.rolePower = "-1"
	roleInfo.roleId = "-1"

	return roleInfo
end

function m.CreateRoleInfoByRoleInfo(roleInfoPOD)
	local roleInfo = m.CreateRoleInfo()

	roleInfo.roleId = roleInfoPOD.pid
	roleInfo.roleName = roleInfoPOD.pname
	roleInfo.roleLevel = tostring(roleInfoPOD.lv)
	roleInfo.vipLevel = "0"
	roleInfo.rolePower = "-1"
	roleInfo.roleBalance = ""
	roleInfo.roleCreateTime = tostring(roleInfoPOD.createTime * 1000)
	roleInfo.partyName = ""
	roleInfo.partyId = "0"
	roleInfo.roleGender = ""
	roleInfo.partyRoleName = ""
	roleInfo.professionId = tostring(roleInfoPOD.leaderCid)
	roleInfo.professionName = CfgRoleTable[roleInfoPOD.leaderCid].Name
	roleInfo.friendList = ""

	return roleInfo
end

function m.CreateRoleInfoByPlayerInfo(playerPOD)
	local roleInfo = m.CreateRoleInfo()

	roleInfo.roleId = playerPOD.baseInfo.pid
	roleInfo.roleName = playerPOD.baseInfo.pName
	roleInfo.roleLevel = tostring(playerPOD.baseInfo.pLv)
	roleInfo.vipLevel = tostring(playerPOD.baseInfo.vip)
	roleInfo.rolePower = "-1"
	roleInfo.roleBalance = tostring(playerPOD.numAttrs[Constant.ItemID.MONEY])
	roleInfo.roleCreateTime = tostring(playerPOD.baseInfo.createTime * 1000)
	roleInfo.partyName = playerPOD.guildName
	roleInfo.partyId = tostring(playerPOD.guildId)
	roleInfo.roleGender = "0"
	roleInfo.partyRoleName = playerPOD.baseInfo.pName
	roleInfo.professionId = tostring(playerPOD.baseInfo.leaderCid)
	roleInfo.professionName = CfgRoleTable[playerPOD.baseInfo.leaderCid].Name
	roleInfo.friendList = ""

	return roleInfo
end

function m.contactCustomer()
	IQIUSDK.Instance:extraFunc(IQIGame.USDK.ExtraFuncType.CONTACT_CUSTOMER)
end

function m.accountHelp()
	IQIUSDK.Instance:extraFunc(IQIGame.USDK.ExtraFuncType.USER_CENTER)
end

function m.openWiki()
	return
end

function m.isShowWiki()
	return false
end

function m.isShowH5()
	if not m.IsSDKMode() then
		return true
	end

	if CfgDiscreteDataTable[6520061].Data[1] == 1 then
		return false
	end

	return true
end

function m.isShowAccountHelp()
	if not m.IsSDKMode() then
		return true
	end

	if m.GetChannelId() == 18 or m.GetChannelId() == 0 or m.GetChannelId() == 6 or m.GetChannelId() == 56 then
		return true
	end

	return false
end

function m.isShowCustomer()
	if not m.IsSDKMode() then
		return true
	end

	if m.GetChannelId() == 18 or m.GetChannelId() == 0 or m.GetChannelId() == 6 or m.GetChannelId() == 56 then
		return true
	end

	return false
end

function m.checkDirtyWords(content, callback)
	callback(false, nil)
end

function m.Share(platform, imagePath, onShareSucceed, onShareField, onShareCancel)
	onShareField("SDK is not Available.")
end

function m.IsHuaweiChannel()
	if not m.IsSDKMode() then
		return false
	end

	return m.GetChannelId() == 11
end

function m.IsHeroChannel()
	if not m.IsSDKMode() then
		return false
	end

	if GameEntry.ProjectSetting.BuildInfo.SDKName ~= "HeroUSDK" then
		return false
	end

	local channelID = m.GetChannelId()

	return false
end

SDKLoginModule = m
