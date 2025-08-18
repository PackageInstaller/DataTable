-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\SDKAgent.lua

local UserData = require("Helper/UserData")
local DataAnalysis = require("SDK/Plugin/DataAnalysis")
local UrlConfig = require("Network/UrlConfig")
local SDKConst = require("SDK/SDKConst")
local SDKCore = require("SDK/SDKCore")
local SDKUtils = require("SDK/SDKUtils")
local SDKAppUtils = require("SDK/SDKAppUtils")
local RechargeConst = require("System/Recharge/RechargeConst")
local json = require("cjson")
local PluginManager = require("SDK/Plugin/PluginManager")
local NetService = require("Network/NetService")
local DeviceHelper = require("Helper/DeviceHelper")
local OpenServerConst = require("Network/OpenServerConst")
local ChannelUtil = require("SDK/ChannelUtil")
local Analytics = require("SDK/Analytics")
local ResRecharge = require("ClientData/ResRecharge")
local EventConst = require("EventConst")
local AccountManager = require("System/AccountManager")
local RechargeManager = require("System/Recharge/RechargeManager")
local RemoteDebug = require("SDK/Plugin/RemoteDebug")
local VersionUtils = require("System/VersionUtils")
local SocialShare = require("SDK/Plugin/SocialShare")
local PlayerInfoPanel = require("UI/MainMenu/PlayerInfoPanel")
local GameSettings = require("Helper/GameSettings")
local ClientUtils = ClientUtils
local HttpUtils = Framework.Network.HttpUtils
local IS_PUBLISH_VERSION = IS_PUBLISH_VERSION
local AttName = SDKConst.AttName
local EventType = SDKConst.EventType
local ResponseCode = SDKConst.ResponseCode
local AccountType = OpenServerConst.AccountType
local U3DOceanSDK = Framework.SDK.U3DOceanSDK
local log = log
local Const = Const
local utils = utils
local IS_FORCE_INTRANET = Framework.Tools.LuaToolkit.IsForceIntranet()
local SDKAgent = {}
local ChannelID = SDKConst.ChannelID
local eventCallback = {
	[EventType.EVENT_PAY_RESULT] = "_onPayResult",
	[EventType.EVENT_PAY_CANCEL] = "_onPayCancel",
	[EventType.EVENT_PRODUCTS_INFO] = "_onGetProductsInfo",
	[EventType.EVENT_RECEIVE_PUSH] = "_onActivatedByNotification",
	[EventType.EVENT_PUSH_TOKEN] = "_onGetPushToken",
	[EventType.EVENT_GET_OTHER_MSG] = "_onGetOtherMsg"
}

SDKAgent.forceLoginMode = nil
SDKAgent.instantModeInDebug = true
SDKAgent._bbsNumRequested = false

local CALLBACK_TYPE = {
	GET_PRODUCTS_INFO = 6,
	UPGRADE_GUEST = 3,
	LOGOUT_FINISH = 2,
	PICK_IMAGE = 7,
	LOGIN_FINISH = 1
}

function SDKAgent.onGameStart()
	Analytics.init()
	AccountManager.init()
	SDKAppUtils.init()
	SDKAgent.init()
	PluginManager.init()
	SDKCore.postInit()
end

function SDKAgent.init()
	for eventType, callbackName in pairs(eventCallback) do
		SDKCore.setEventCallback(eventType, SDKAgent[callbackName])
	end

	SDKAgent._userCallbackDict = {}
	SDKAgent._gameVoice = {}
	SDKAgent._loginDelayTimer = Timer.New(SDKAgent._onRoleLoginLater, 1, 1)

	Analytics._clearSendRoleInfoAttempts()

	SDKAgent._sdkImp = SDKAgent.getSDKImp()

	SDKAgent._sdkImp:init()
end

function SDKAgent.getSDKImp()
	if ChannelUtil.isFlow then
		local SDKImpFlowNew = require("SDK/SDKImp/SDKImpFlowNew")

		return SDKImpFlowNew.GetInstance()
	elseif ChannelUtil.isByted then
		local SDKImpByted = require("SDK/SDKImp/SDKImpByted")

		return SDKImpByted.GetInstance()
	elseif ChannelUtil.isBilibili then
		local SDKImpBilibili = require("SDK/SDKImp/SDKImpBilibili")

		return SDKImpBilibili.GetInstance()
	elseif ChannelUtil.isMulti then
		local SDKImpMulti = require("SDK/SDKImp/SDKImpMulti")

		return SDKImpMulti.GetInstance()
	elseif ChannelUtil.isBiliKorea then
		local SDKImpBiliKorea = require("SDK/SDKImp/SDKImpBiliKorea")

		return SDKImpBiliKorea.GetInstance()
	elseif ChannelUtil.isBiliSea then
		local SDKImpBiliSea = require("SDK/SDKImp/SDKImpBiliSea")

		return SDKImpBiliSea.GetInstance()
	else
		local SDKImpCommon = require("SDK/SDKImp/SDKImpCommon")

		return SDKImpCommon.GetInstance()
	end
end

function SDKAgent.login(callback)
	if VersionUtils.getEngineVersion() < 80954 and DeviceHelper.isAndroid() and ChannelUtil.isPlat and SDKAgent._lastCallLoginTime and math.abs(os.time() - SDKAgent._lastCallLoginTime) < 5 then
		SDKAgent.logout()
	end

	if SDKAgent._sdkImp:isLoginLocked() then
		if callback then
			callback(false)
		end
	else
		SDKAgent._sdkImp:login(callback)
	end

	SDKAgent._lastCallLoginTime = os.time()
end

function SDKAgent.logout(callback)
	SDKAgent._sdkImp:logout(callback)
end

function SDKAgent.switchAccount()
	SDKAgent._sdkImp:switchAccount()
end

function SDKAgent.accountCenter()
	SDKAgent._sdkImp:accountCenter()
end

function SDKAgent.debugLogin(username, password, callback)
	SDKAgent._sdkImp:debugLogin(username, password, callback)
end

function SDKAgent.openIdLogin(openId, channelId, subChannelId)
	SDKAgent._sdkImp:openIdLogin(openId, channelId, subChannelId)
end

function SDKAgent.isLoginLocked()
	return SDKAgent._sdkImp.isLoginLocked()
end

function SDKAgent.getSdkOpenID()
	return SDKAgent._sdkImp:getSdkOpenID() or ""
end

function SDKAgent.getUserID()
	return SDKAgent._sdkImp:getUserID() or ""
end

function SDKAgent.getSDKUserID()
	if SDKAgent._sdkImp.getSDKUserID then
		return SDKAgent._sdkImp:getSDKUserID()
	else
		return ""
	end
end

function SDKAgent.getToken()
	return SDKAgent._sdkImp:getToken()
end

function SDKAgent.getAppID()
	return SDKAgent._sdkImp:getAppID()
end

function SDKAgent.getSDKDeviceID()
	return SDKAgent._sdkImp:getSDKDeviceID()
end

function SDKAgent.getMac()
	return SDKAgent._sdkImp:getMac()
end

function SDKAgent._setUserID(id)
	SDKAgent._sdkImp:_setUserID(id)
end

function SDKAgent.isGuest()
	return SDKAgent._sdkImp:isGuest()
end

function SDKAgent.bindGuest(tip, callback)
	if tip then
		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(29978), tip, function()
			SDKAgent._sdkImp:bindGuest(callback)
		end)
	else
		SDKAgent._sdkImp:bindGuest(callback)
	end
end

function SDKAgent.recordMobile(callback)
	local SDKImpFlow = require("SDK/SDKImp/SDKImpFlow")

	SDKImpFlow.GetInstance():recordMobile(callback)
end

function SDKAgent.getProductInfo(callback)
	SDKAgent._setUserCallback(CALLBACK_TYPE.GET_PRODUCTS_INFO, callback)

	local provided = false
	local rechargeIDChannel = ChannelUtil.getRechargeIDChannel()
	local rechargeChannel = ChannelUtil.getRechargeChannel()
	local productInfoMethod = ChannelUtil.getRechargeProductMethod()
	local isEditor = IS_EDITOR

	if productInfoMethod and not isEditor then
		local input = {}

		if RechargeConst.PRODUCT_METHOD_INPUT == productInfoMethod then
			for _, info in pairs(ResRecharge) do
				if info.channel == rechargeIDChannel then
					table.insert(input, info.product_id)
				end
			end
		elseif RechargeConst.PRODUCT_METHOD_DEFAULT == productInfoMethod then
			-- block empty
		end

		U3DOceanSDK.GetProductsInfo(ClientUtils.table2String(input))

		provided = true
	end

	if not provided or not IS_PUBLISH_VERSION and rechargeChannel == RechargeConst.RECHARGE_CAHNNEL_ID_EDITOR then
		local dataTable = {}

		for id, info in pairs(ResRecharge) do
			local platform = DeviceHelper.isIOS() and 1 or 2
			local item = {
				[AttName.PRODUCT_ID] = info.product_id,
				[AttName.ITEM_PLATFORM] = platform,
				[AttName.REAL_PRICE] = info.cost_money / 100,
				[AttName.ITEM_NAME] = info.product_name
			}

			table.insert(dataTable, item)
		end

		local data = ClientUtils.table2String(dataTable)

		data = {
			[AttName.ITEM_INFO] = data,
			[AttName.RESULT] = "1"
		}

		SDKAgent._onGetProductsInfo(data)
	end
end

function SDKAgent.sdkPay(content)
	SDKAgent._sdkImp:pay(content)
end

function SDKAgent.finishTransaction(data)
	local dataString = ClientUtils.table2String(data)

	U3DOceanSDK.FinishTransaction(dataString)
end

function SDKAgent.sendRoleInfo(eventName, ignoreReadyState)
	if RegionUtils.isJP() and DeviceHelper.isIOS() then
		SDKAgent.querySuccessionCode()

		if VersionUtils.isOldVersionSDK_jp() then
			local platformData = SDKCore.getPlatformData()

			if platformData then
				if platformData[AttName.SYSTEM_VERSION] then
					if tonumber(platformData[AttName.SYSTEM_VERSION]) >= 14.6 then
						return
					end
				else
					return
				end
			end
		end
	end

	Analytics.sendRoleInfo(eventName, ignoreReadyState)
end

function SDKAgent.sendPurchaseInfo(price, currencyCode, productId)
	return
end

function SDKAgent.getDeviceInfoForOpenSvr()
	return Analytics.getDeviceInfoForOpenSvr()
end

function SDKAgent.customerService()
	SDKAgent._sdkImp:customerService()
end

function SDKAgent.openAgreement(protocol)
	SDKAgent._sdkImp:agreement(protocol)
end

function SDKAgent.questionnaire(url, callback)
	SDKAgent._sdkImp:questionnaire(url, callback)
end

function SDKAgent.isSupportAccountSwitch()
	return SDKAgent._sdkImp:isSupportAccountSwitch()
end

function SDKAgent.openForum()
	if DeviceHelper.isIOS() then
		GameSettings.closeAllVoice(true)
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_SDK_BBS_MSG, false)
	PluginManager.tryInitShare()
	ChannelUtil.doAnyFunction("openForum", {})

	local ca = CurAvatar

	if ca and ca.isAvatar and ca:getAchieveProcessByType(Const.ACHIEVE_TYPE_FORUM) == 0 then
		ca:updateClientAchieveProgress(Const.ACHIEVE_TYPE_FORUM, 1)
	end
end

function SDKAgent.getBBSNum()
	ChannelUtil.doAnyFunction("getBBSNum", {})
end

function SDKAgent.showNotice()
	SDKAgent._sdkImp:showNotice()
end

function SDKAgent.isAgeLimit()
	return SDKAgent._sdkImp:isAgeLimit()
end

function SDKAgent.authBind(authType)
	ChannelUtil.doAnyFunction("authBind", authType)
end

function SDKAgent.authLogin(authType)
	local loginData = {}

	loginData[AttName.LOGIN_AUTH] = authType

	ChannelUtil.doAnyFunction("showLogin", loginData)
end

function SDKAgent.successionCodeLogin(str)
	ChannelUtil.doAnyFunction("loginWithSuccessionCode", str)
end

function SDKAgent.createSuccessionCode(code)
	ChannelUtil.doAnyFunction("createSuccessionCode", code)
end

function SDKAgent.changeSuccessionCode(code)
	ChannelUtil.doAnyFunction("changeSuccessionCode", code)
end

function SDKAgent.querySuccessionCode()
	ChannelUtil.doAnyFunction("querySuccessionCode", {})
end

function SDKAgent.share(shareData)
	ChannelUtil.doAnyFunction("socialShare", shareData)
end

function SDKAgent.setLuaPatchVersion(authType)
	ChannelUtil.doAnyFunction("setLuaPatchVersion", authType)
end

function SDKAgent.setUserPayInfo(authType)
	ChannelUtil.doAnyFunction("setUserPayInfo", authType)
end

function SDKAgent.getUserPayInfo(authType)
	ChannelUtil.doAnyFunction("getUserPayInfo", authType)
end

function SDKAgent.onRoleLogin()
	Analytics.onRoleLogin()
	PluginManager.onRoleLogin()
	RechargeManager.onRoleLogin()
	SDKAgent._registerPush()
	SDKAgent._loginDelayTimer:Restart()
	Framework.Download.SubpackageUtils.SetRecordOrder(CurAvatar:getLevel())
end

function SDKAgent.onRoleCreate()
	PluginManager.onRoleCreate()
	SDKAgent.sendRoleInfo(SDKConst.RoleInfoType.CREATE_ROLE)
end

function SDKAgent._onRoleLoginLater()
	Analytics.updateSDKUserData({
		AttName.FRIEND_LIST,
		AttName.PARTY_ID,
		AttName.PARTY_NAME,
		AttName.PARTY_ROLE_ID
	})
	Analytics._setRoleInfoReadyState(true)

	if not AccountManager.isReconnect() then
		SDKAgent.sendRoleInfo(SDKConst.RoleInfoType.ENTER_GAME)

		if RegionUtils.isKR() then
			SDKAgent.doDayLoginCountKR()
		elseif RegionUtils.isSEA() then
			local data = Analytics.getBiliSeaSendLogPubParameter()

			data.payamount = CurAvatar:getMoneyByType(Const.MONEY_TYPE_VIP)

			ChannelUtil.doAnyFunction("appsflyerTrackEventKey", {
				eventName = "af_login",
				eventValue = ClientUtils.table2String(data)
			})
			ChannelUtil.doAnyFunction("firebaseTrackEventKey", {
				eventName = "G_login",
				eventValue = ClientUtils.table2String(data)
			})
		elseif RegionUtils.isJP() then
			SDKAgent._getJpOldRoleList()
		end
	end

	Analytics.updateDeviceInfoToOpenSvr()
	PluginManager.onRoleLoginLater()

	if SDKAgent._loginDelayTimer then
		SDKAgent._loginDelayTimer:Stop()
	end
end

local tryIndex = 0
local tempRoleList

function SDKAgent._getJpOldRoleList()
	if tryIndex > 2 then
		Framework.Tools.LuaToolkit.LogEx("--flow role list try get 3 times, give up")

		return
	end

	local email = SDKCore.getUserValue("flow_email")

	if string.len(email) > 1 then
		local url = "https://web-api-global.flowgame.com/api/v1/enroll/rolelist?email=" .. email

		HttpHelper.get(url, SDKAgent._onRequestCallback, 3)

		tryIndex = tryIndex + 1
	else
		Framework.Tools.LuaToolkit.LogEx("--flow email is null")
	end
end

function SDKAgent._onRequestCallback(code, msg)
	Framework.Tools.LuaToolkit.LogEx("--flow bind role list reponse:" .. code)

	tempRoleList = msg

	if code == 0 then
		local successionCodeBindDlg = UIManager.getUI("successionCodeBindDlg")

		if successionCodeBindDlg then
			successionCodeBindDlg:tryShow(msg)
		end
	else
		SDKAgent._getJpOldRoleList()
	end
end

function SDKAgent.reopenBindUI()
	if tempRoleList ~= nil then
		local successionCodeBindDlg = UIManager.getUI("successionCodeBindDlg")

		if successionCodeBindDlg then
			successionCodeBindDlg:tryShow(tempRoleList)
		end
	end
end

function SDKAgent.onRoleLogout()
	RemoteDebug.logOut()
	Analytics._clearSendRoleInfoAttempts()
end

function SDKAgent.onRoleLevelUp()
	Analytics.onRoleLevelUp()
	PluginManager.onRoleLevelUp()
	Framework.Download.SubpackageUtils.SetRecordOrder(CurAvatar:getLevel())
end

function SDKAgent.onBuyProductSucc(transId, paymentType, currencyType, currencyAmount)
	PluginManager.onBuyProductSucc(transId, paymentType, currencyType, currencyAmount)
end

function SDKAgent.onPurchaseSucc(transId, paymentType, currencyType, currencyAmount)
	PluginManager.onPurchaseSucc(transId, paymentType, currencyType, currencyAmount)
end

function SDKAgent._onPayResult(data)
	RechargeManager.onRechargeFinish(data[AttName.PAY_RESULT] == "1", data)
end

function SDKAgent._onPayCancel(data)
	return
end

function SDKAgent._onGetProductsInfo(data)
	local isSucc = data[AttName.RESULT] ~= "0"
	local products = {}

	if isSucc then
		products = ClientUtils.string2Table(data[AttName.ITEM_INFO])
	end

	SDKAgent._callUserCallback(CALLBACK_TYPE.GET_PRODUCTS_INFO, isSucc, products)
end

function SDKAgent._onActivatedByNotification(data)
	local userInfo = data
end

local ttypeDict = {
	[AttName.PUSH_TYPE_GGP] = OpenServerConst.PUSH_TYPE_GGP,
	[AttName.PUSH_TYPE_APNS] = OpenServerConst.PUSH_TYPE_APNS
}

function SDKAgent._onGetPushToken(data)
	if data then
		local token = data[AttName.PUSH_ID]
		local pushType = data[AttName.PUSH_TYPE]
		local ttype = ttypeDict[pushType]
		local dataToSend = {}

		if token and token ~= "" and ChannelUtil.isPlaywith then
			if NetService.isConnected() then
				local ca = CurAvatar
				local uid = ca and ca.uid

				dataToSend.appid = Const.PUSH_APPID
				dataToSend.uid = uid
				dataToSend.ttype = ttype
				dataToSend.token = token
			else
				SDKAgent._cachedNotificationToken = {
					ttype,
					token
				}
			end
		end

		if dataToSend.uid and dataToSend.token then
			HttpHelper.post(UrlConfig.PushUrl, ClientUtils.table2String(dataToSend), SDKAgent.onSentPushToken, 1)
		end
	end
end

function SDKAgent._onGetOtherMsg(data)
	local otherMsgType = data[AttName.OTHER_MSG_TYPE]

	if otherMsgType == "BBSNum" then
		SDKAgent.onShowBBSRedDot(data)
	elseif otherMsgType == "BBSShare" then
		local url = data.url
		local imgurl = data.imgUrl
		local text = data.content
		local title = data.title
		local channel = tonumber(data.share_channel)
		local platform = channel == 1 and 22 or 24

		SocialShare.shareWebpageJson(platform, 4, title, text, nil, url, imgurl, nil, false)
	elseif otherMsgType == "BBSWards" then
		-- block empty
	elseif otherMsgType == "BBSClose" then
		GameSettings.revertVoiceSetting()
	elseif otherMsgType == "Login" then
		SDKAgent._sdkImp:LoginResult(data)
	elseif otherMsgType == "getSuccessionCode" then
		SDKAgent._sdkImp:getSuccessionCodeResult(data)
	elseif otherMsgType == "getUserPayInfo" then
		SDKAgent._sdkImp:getUserPayInfo(data)
	elseif otherMsgType == "querySdkOpenId" then
		if SDKAgent._sdkImp.setSdkOpenID then
			SDKAgent._sdkImp:setSdkOpenID(data)
		end
	elseif otherMsgType == "socialShareResult" then
		SocialShare.onShareFinish(nil, data)
	elseif otherMsgType == "saveImageResult" then
		if DeviceHelper.isIOS() then
			local captureDlg = UIManager.tryGetUI("captureDlg", true)

			if captureDlg then
				captureDlg:saveResult(data.pay_result == "1")
			end
		end
	elseif otherMsgType == "questionnaireResult" then
		if SDKAgent._sdkImp.onQuestionnaireFinish then
			SDKAgent._sdkImp:onQuestionnaireFinish(data)
		end
	elseif otherMsgType == "giftpack" then
		if SDKAgent._sdkImp.giftPack then
			SDKAgent._sdkImp:giftPack(data)
		end
	elseif otherMsgType == "notificationStatus" then
		local PushSettingPanel = require("UI/MainMenu/PushSettingPanel")

		if PushSettingPanel then
			PushSettingPanel:tryRefreshAllPushBtn()
		end
	elseif otherMsgType == "showLogFromNative" then
		local code = data.code

		if code then
			local f = loadstring(code)

			f()
		end
	elseif otherMsgType == "androidPermissionResult" then
		SDKAgent._onAndroidPermissionResult(data)
	elseif otherMsgType == "jp_emluator" then
		if SDKAgent._sdkImp.onEmulatorResult then
			SDKAgent._sdkImp:onEmulatorResult(data)
		end
	elseif otherMsgType == "pauseIfInBattle" then
		if ClientUtils.isInBeginner() then
			return
		end

		local confirmui = UIManager.tryGetUI("confirmui")

		if confirmui and confirmui:isInShow() then
			return
		end

		local ui1 = UIManager.tryGetUI("battleMainDlg")
		local ui2 = UIManager.tryGetUI("battleZombieMainDlg")
		local ui3 = UIManager.tryGetUI("battleMoreHeroMainDlg")
		local ui4 = UIManager.tryGetUI("battleReplayMainDlg")

		if ui1 or ui2 or ui3 or ui4 then
			local BattleMainDlg = require("UI/Battle/BattleMainDlg")

			BattleMainDlg:onClickQuit()
		end
	elseif otherMsgType == "unReadMsg" then
		local unReadMsg = data.unReadMsg

		if tonumber(unReadMsg) > 0 then
			RedDotManager.setKeyState(UIConst.RD_HINT_CUSTOMER, true)
		else
			RedDotManager.setKeyState(UIConst.RD_HINT_CUSTOMER, false)
		end
	elseif otherMsgType == "qqgame_pay" then
		local result = data.result

		if result == "1" then
			local WebView = require("SDK/Plugin/WebView")

			WebView.unityOpenUrl(data.url_param)
		else
			MsgManager.notice(data.msg)
		end
	elseif otherMsgType == "keyCodeEsc" then
		if ChannelUtil.isSteam() then
			U3DOceanSDK.QuitApplication()
		end
	elseif not IS_PUBLISH_VERSION then
		MsgManager.notice("Invalid otherMsgType:" .. tostring(otherMsgType))
	end
end

function SDKAgent._onAndroidPermissionResult(data)
	local permissions = data[AttName.EXTRA_FUNCTION_KEY]
	local granteds = data[AttName.EXTRA_FUNCTION_VALUE]

	if permissions and granteds then
		local permissionList = utils.splitString(permissions, "|")
		local grantedList = utils.splitString(granteds, "|")
		local NativeHelper = require("Helper/NativeHelper")

		NativeHelper.onAndroidPermissionResult(permissionList, grantedList)
	end
end

function SDKAgent.failNotice(data)
	if SDKAgent._sdkImp.failNotice then
		SDKAgent._sdkImp:failNotice(data)
	end
end

function SDKAgent.onShowBBSRedDot(data)
	local total = data.total
	local upvote = data.upvote_num
	local follow = data.follow_num
	local notice = data.notice_num
	local token = data.token
	local showRedDot = false

	showRedDot = (tonumber(total) > 0 or tonumber(upvote) > 0 or tonumber(follow) > 0 or tonumber(notice) > 0) and true or false
	SDKAgent._bbsNumRequested = true

	RedDotManager.setKeyState(UIConst.RD_HINT_SDK_BBS_MSG, showRedDot)
end

function SDKAgent.requestBBSNum()
	if not SDKAgent._bbsNumRequested then
		SDKAgent.getBBSNum()
	end
end

function SDKAgent.onSentPushToken()
	return
end

function SDKAgent._setUserCallback(event, callback)
	SDKAgent._userCallbackDict[event] = callback
end

function SDKAgent._callUserCallback(event, ...)
	local callback = SDKAgent._userCallbackDict[event]

	if callback ~= nil then
		callback(...)

		SDKAgent._userCallbackDict[event] = nil
	end
end

function SDKAgent._registerPush()
	if ChannelUtil.isPlaywith and SDKAgent._cachedNotificationToken then
		local dataToSend = {}
		local ca = CurAvatar
		local uid = ca and ca.uid

		dataToSend.appid = Const.PUSH_APPID
		dataToSend.uid = uid
		dataToSend.ttype = SDKAgent._cachedNotificationToken[1]
		dataToSend.token = SDKAgent._cachedNotificationToken[2]

		if dataToSend.uid and dataToSend.token then
			HttpHelper.post(UrlConfig.PushUrl, ClientUtils.table2String(dataToSend), SDKAgent.onSentPushToken, 1)
		end

		SDKAgent._cachedNotificationToken = nil
	end
end

function SDKAgent.testSDKLogin(strNotify)
	SDKAgent._sdkImp:testSDKLogin(strNotify)
end

function SDKAgent._getForceLoginMode()
	local loginMode

	if IS_FORCE_INTRANET then
		loginMode = 0
	end

	if SP_MARK and string.find(SP_MARK, "uwa") then
		loginMode = 0
	end

	if RegionUtils.isCN() and SP_MARK and string.find(SP_MARK, "business") then
		loginMode = 0
	end

	return loginMode
end

function SDKAgent.doDayLoginCountKR()
	local nextLoginDayKR = UserData.loadCommonData("nextLoginDayKR")
	local loginDayCountKR = UserData.loadCommonData("loginDayCountKR")
	local nowTime = ClientUtils.getServerTime()
	local nextDayTime = ClientUtils.getServerTimeNextDay()

	if nextLoginDayKR ~= nil and nextLoginDayKR ~= "" then
		if nowTime > tonumber(nextLoginDayKR) then
			UserData.saveCommonData("nextLoginDayKR", nextDayTime)

			local index = tonumber(loginDayCountKR) + 1

			UserData.saveCommonData("loginDayCountKR", index)

			if index == 1 then
				SDKAgent.reportBuriedPoint("af_retention_1", "Fire_retention_1")
			elseif index == 2 then
				SDKAgent.reportBuriedPoint("af_retention_2", "Fire_retention_2")
			elseif index == 6 then
				SDKAgent.reportBuriedPoint("af_retention_6", "Fire_retention_6")
			elseif index == 13 then
				SDKAgent.reportBuriedPoint("af_retention_13", "Fire_retention_13")
			elseif index == 30 then
				SDKAgent.reportBuriedPoint("af_retention_30", "Fire_retention_30")
			end
		end
	else
		UserData.saveCommonData("nextLoginDayKR", nextDayTime)
		UserData.saveCommonData("loginDayCountKR", 0)
	end
end

function SDKAgent.reportBuriedPoint(afEventName, fbEventName)
	if RegionUtils.isKR() then
		local tab = {
			eventName = afEventName,
			eventValue = {
				uid = SDKCore.getUserValue(AttName.ROLE_ID),
				username = SDKCore.getUserValue(AttName.ROLE_NAME)
			}
		}

		ChannelUtil.doAnyFunction("appsflyerTrackEventKey", ClientUtils.table2String(tab))

		tab.eventName = fbEventName

		ChannelUtil.doAnyFunction("firebaseTrackEventKey", ClientUtils.table2String(tab))
	end
end

SDKAgent.forceLoginMode = SDKAgent._getForceLoginMode()

return SDKAgent
