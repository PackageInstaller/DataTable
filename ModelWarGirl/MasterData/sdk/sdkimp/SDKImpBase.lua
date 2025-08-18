-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\SDKImp\\SDKImpBase.lua

local strClassName = "SDKImpBase"
local SDKImpBase = Class(strClassName)
local AccountManager = require("System/AccountManager")
local EventConst = require("EventConst")
local UrlConfig = require("Network/UrlConfig")
local OpenServerConst = require("Network/OpenServerConst")
local SDKCore = require("SDK/SDKCore")
local SDKConst = require("SDK/SDKConst")
local UserData = require("Helper/UserData")
local DeviceHelper = require("Helper/DeviceHelper")
local RetryHelper = require("Helper/RetryHelper")
local OpenServerHelper = require("Network/OpenServerHelper")
local SDKAppUtils = require("SDK/SDKAppUtils")
local ChannelID = SDKConst.ChannelID
local U3DOceanSDK = Framework.SDK.U3DOceanSDK
local EventCenter = EventCenter
local EventType = SDKConst.EventType
local AttName = SDKConst.AttName
local AccountType = OpenServerConst.AccountType
local HttpUtils = Framework.Network.HttpUtils
local ResponseCode = SDKConst.ResponseCode
local MsgManager = MsgManager
local LuaToolkit = Framework.Tools.LuaToolkit
local IS_FORCE_INTRANET = LuaToolkit.IsForceIntranet()
local CALLBACK_TYPE = {
	RECORD_MOBILE = 5,
	BIND_GUEST = 3,
	LOGOUT_FINISH = 2,
	DATA_CHANGED = 100,
	GEN_SMS_CODE = 4,
	LOGIN_FINISH = 1
}
local GET_TOKEN_TYPE = {
	BIND = 2,
	LOGIN = 1,
	SECTION = 3
}
local callbackDict = {
	[EventType.EVENT_LOGIN_SUCCESS] = "_onSDKLoginSucc",
	[EventType.EVENT_LOGIN_CANCEL] = "_onSDKLoginCancel",
	[EventType.EVENT_LOGIN_FAIL] = "_onSDKLoginFail",
	[EventType.EVENT_LOGOUT] = "_onSDKLogoutSuccess",
	[EventType.EVENT_UPGRADE_GUEST] = "_onSDKUpgradeGuestSucc"
}
local ACCTYPE_PLATFORM = {
	[ChannelID.PLAT] = {
		AccountType.PLATI,
		AccountType.PLATA
	}
}

SDKImpBase.CALLBACK_TYPE = CALLBACK_TYPE
SDKImpBase.GET_TOKEN_TYPE = GET_TOKEN_TYPE
SDKImpBase.LOGIN_LOCK_TIME = 5
SDKImpBase.REQ_TOKEN_RETRY_MAX_DURATION = 20
SDKImpBase.SECTION_RETRY_MAX_DURATION = 3

function SDKImpBase:ctor()
	self._isGuest = false
	self._isBindGuest = false
	self._slotLoginOpenServer = Functor(self._onGetToken, self, GET_TOKEN_TYPE.LOGIN)
	self._slotQuerySection = Functor(self._onGetToken, self, GET_TOKEN_TYPE.SECTION)
	self._slotOnBindOpenIDResp = Slot(self._onBindOpenIDResp, self)
	self._userCallbackDict = {}
	self._userID = nil
	self._refreshCallbacks = {}
	self._requestTokenStartTime = 0
	self._getTokenDelayTimer = Timer.New(Slot(self._doRequestTokenOnce, self), 2, 1)
end

function SDKImpBase:destroy()
	return
end

function SDKImpBase:init()
	for eventType, callbackName in pairs(callbackDict) do
		SDKCore.setEventCallback(eventType, Slot(self[callbackName], self))
	end
end

function SDKImpBase:login(callback)
	self:_setUserCallback(CALLBACK_TYPE.LOGIN_FINISH, callback)
	self:_doLogin()
end

function SDKImpBase:logout(callback)
	self:_setUserCallback(CALLBACK_TYPE.LOGOUT_FINISH, callback)
	self:_doLogout()
end

function SDKImpBase:pay(content)
	self:_doSDKPay(content)
end

function SDKImpBase:switchAccount()
	if IS_EDITOR or AccountManager.accType == AccountType.NAME_PWD then
		UserData.saveCommonData("login_auto_debug", "")
	end

	if AccountManager.accType == AccountType.NAME_PWD then
		AccountManager.logoutGame()
	else
		self:_setUserCallback(CALLBACK_TYPE.LOGIN_FINISH, nil)
		self:_setUserCallback(CALLBACK_TYPE.LOGOUT_FINISH, nil)
		self:_doSwitchAccount()
	end
end

function SDKImpBase:accountCenter()
	self:_setUserCallback(CALLBACK_TYPE.LOGIN_FINISH, nil)
	self:_setUserCallback(CALLBACK_TYPE.LOGOUT_FINISH, nil)
	self:_doAccountCenter()
end

function SDKImpBase:bindGuest(callback)
	self:_setUserCallback(CALLBACK_TYPE.BIND_GUEST, callback)
	self:_doBindGuest()
end

function SDKImpBase:recordMobile(callback)
	self:_setUserCallback(CALLBACK_TYPE.RECORD_MOBILE, callback)
	self:_doRecordMobile()
end

function SDKImpBase:_setUserID(id)
	self._userID = id
end

function SDKImpBase:getSdkOpenID()
	return ""
end

function SDKImpBase:getUserID()
	return self._userID
end

function SDKImpBase:getToken()
	return self._token
end

function SDKImpBase:getAcctype(channelID)
	local accTypes = ACCTYPE_PLATFORM[channelID]

	if accTypes then
		return DeviceHelper.isIOS() and accTypes[1] or accTypes[2]
	else
		return channelID
	end
end

function SDKImpBase:getAppID()
	local platform = SDKCore.getPlatformData()

	return platform[AttName.APP_ID]
end

function SDKImpBase:setGuestFlag(isGuest)
	self._isGuest = isGuest
end

function SDKImpBase:isGuest()
	return self._isGuest
end

function SDKImpBase:setBindGuestFlag(isBindGuest)
	self._isBindGuest = isBindGuest
end

function SDKImpBase:isBindGuest()
	return self._isBindGuest
end

function SDKImpBase:isSupportAccountSwitch()
	return true
end

function SDKImpBase:isLoginLocked()
	local locked = false

	return locked
end

function SDKImpBase:showNotice()
	return
end

function SDKImpBase:isAgeLimit()
	return false
end

function SDKImpBase:debugLogin(username, password, callback)
	self:_setUserCallback(CALLBACK_TYPE.LOGIN_FINISH, callback)

	local data = {}

	data[OpenServerConst.ACCOUNT_TYPE] = AccountType.NAME_PWD
	data[OpenServerConst.ACCOUNT_ID] = username

	local channelID = password

	data[OpenServerConst.CHANNEL_ID] = channelID

	local splitted = utils.splitString(username, ",")

	if #splitted == 3 then
		ChannelUtil.setDebugChannel("multi", "wanfutengxun")
		U3DOceanSDK.DebugQQGameLogin(splitted[1], splitted[2], splitted[3])

		return
	end

	self:_requestToken(data)
end

function SDKImpBase:openIdLogin(openId, channelId, subChannelId)
	local data = {}

	data[OpenServerConst.ACCOUNT_TYPE] = AccountType.OPENID
	data[OpenServerConst.OPEN_ID] = tonumber(openId)
	data[OpenServerConst.CHANNEL_ID] = channelId
	data[OpenServerConst.SUB_CHANNEL_ID] = subChannelId

	self:_requestToken(data)
end

function SDKImpBase:setDataChangedCallback(callback)
	self:_setUserCallback(CALLBACK_TYPE.DATA_CHANGED, callback)
end

function SDKImpBase:onDataChanged()
	self:_callUserCallbackNoRemvoe(CALLBACK_TYPE.DATA_CHANGED)
end

function SDKImpBase:_doLogin()
	return
end

function SDKImpBase:_doLogout()
	return
end

function SDKImpBase:_doSwitchAccount()
	return
end

function SDKImpBase:_doAccountCenter()
	return
end

function SDKImpBase:_doSDKPay(content)
	return
end

function SDKImpBase:_doBindGuest()
	return
end

function SDKImpBase:_doRecordMobile()
	return
end

function SDKImpBase:customerService()
	return
end

function SDKImpBase:questionnaire(url, callback)
	return
end

function SDKImpBase:agreement()
	return
end

function SDKImpBase:_doSimpleLogout()
	SDKCore.onGetSDKEvent(EventType.EVENT_LOGOUT)
end

function SDKImpBase:_requestToken(data, userID)
	self._reqTokenData = data
	self._reqTokenUserID = userID or data[OpenServerConst.ACCOUNT_ID]
	self._requestTokenStartTime = os.time()

	self:_doRequestTokenOnce()
end

function SDKImpBase:_doRequestTokenOnce()
	local reqTokenData = self._reqTokenData

	self:_setSpinnerVisible(true)

	if VersionUtils.isSectionEnabled() and ServerSection.getSection() == nil then
		AccountManager.loginOpenServer(reqTokenData, self._slotQuerySection, true)
	else
		AccountManager.loginOpenServer(reqTokenData, self._slotLoginOpenServer)
	end

	return true
end

function SDKImpBase:_setUserCallback(event, callback)
	self._userCallbackDict[event] = callback
end

function SDKImpBase:_callUserCallback(event, ...)
	local callback = self._userCallbackDict[event]

	if callback ~= nil then
		callback(...)

		self._userCallbackDict[event] = nil
	end
end

function SDKImpBase:_callUserCallbackNoRemvoe(event, ...)
	local callback = self._userCallbackDict[event]

	if callback ~= nil then
		callback(...)
	end
end

function SDKImpBase:getSDKDeviceID()
	return SDKCore.getUserValue(AttName.SDK_DEVICE_ID)
end

function SDKImpBase:getMac()
	local platform = SDKCore.getPlatformData()

	return platform[AttName.MAC_ADDRESS]
end

function SDKImpBase:_onSDKLoginSucc(data)
	local requestData = {}
	local accountChannel = data[AttName.CHANNEL_ID]
	local id, token = data[AttName.USER_ID], data[AttName.USER_TOKEN]

	self._token = token
	requestData[OpenServerConst.ACCOUNT_TYPE] = self:getAcctype(accountChannel)
	requestData[OpenServerConst.ACCOUNT_ID] = id
	requestData[OpenServerConst.ACCOUNT_SESSION] = token

	self:_requestToken(requestData)
end

function SDKImpBase:_onSDKLoginCancel()
	self:_callUserCallback(CALLBACK_TYPE.LOGIN_FINISH, false)
end

function SDKImpBase:_onSDKLoginFail(data)
	if not RegionUtils.isCN() or string.find(data, Lang.get(88734)) then
		-- block empty
	elseif data == Lang.get(50621) then
		-- block empty
	else
		MsgManager.notice(data)
	end

	self:_callUserCallback(CALLBACK_TYPE.LOGIN_FINISH, false)
end

function SDKImpBase:_onSDKLogoutSuccess()
	self:_callUserCallback(CALLBACK_TYPE.LOGOUT_FINISH, true)
	EventCenter.sendEvent(EventConst.ACCOUNT_LOGOUT_FINISH, true)
	AccountManager.logoutGame()
	self:_setSpinnerVisible(false)
end

function SDKImpBase:_onSDKUpgradeGuestSucc()
	self:_callUserCallback(CALLBACK_TYPE.BIND_GUEST, true)
end

function SDKImpBase:_onGetToken(eventType, succ, data, reqTokenData)
	self:_setSpinnerVisible(false)

	if succ then
		local userID = data and data[OpenServerConst.ACCOUNT_ID]

		if userID and string.len(userID) > 0 then
			self:_setUserID(userID)
		else
			self:_setUserID(self._reqTokenUserID)
		end

		local deviceId = data and data.device_id

		if IS_FORCE_INTRANET then
			MsgManager.notice(data.device_id)
		end

		if deviceId then
			local userData = {}

			userData.device_id = deviceId

			SDKCore.addUserData(userData)
		end

		if RegionUtils.isJP() then
			local token = data.token
			local acctype = data.acctype

			UserData.saveCommonData("jp_login_token", token)
			UserData.saveCommonData("jp_login_acctype", acctype)
			UserData.saveCommonData("jp_sdk_token", self._token)
		end
	end

	if eventType == GET_TOKEN_TYPE.LOGIN or eventType == GET_TOKEN_TYPE.SECTION then
		self:_callUserCallback(CALLBACK_TYPE.LOGIN_FINISH, succ, eventType == GET_TOKEN_TYPE.SECTION)
	elseif eventType == GET_TOKEN_TYPE.BIND then
		MsgManager.notice(succ and Lang.get(30003) or Lang.get(30004))
		self:_callUserCallback(CALLBACK_TYPE.BIND_GUEST, succ)
	end

	local maxDuration = SDKImpBase.REQ_TOKEN_RETRY_MAX_DURATION

	if eventType == GET_TOKEN_TYPE.SECTION then
		maxDuration = SDKImpBase.SECTION_RETRY_MAX_DURATION
	end

	local hasRetry = not succ and maxDuration > math.abs(os.time() - self._requestTokenStartTime)

	EventCenter.sendEvent(EventConst.ACCOUNT_LOGIN_FINISH, succ, data, hasRetry, eventType == GET_TOKEN_TYPE.SECTION)

	if succ then
		self._getTokenDelayTimer:Stop()
	elseif hasRetry then
		self:_setSpinnerVisible(true, Lang.get(30005))
		self._getTokenDelayTimer:Restart()
	else
		self:_setSpinnerVisible(false)
	end
end

function SDKImpBase:_checkJPLogoffStatus(acctype, sdk_open_id, token)
	Framework.Tools.LuaToolkit.LogEx("cwtjp logoff status:" .. acctype .. "|" .. sdk_open_id .. "|" .. token)
	self:_setSpinnerVisible(true, Lang.get(30402))

	local dataLogoff = {}

	dataLogoff.acctype = acctype
	dataLogoff.sdk_open_id = sdk_open_id
	dataLogoff.token = token

	local url = UrlConfig.CancellationCheck

	OpenServerHelper.httpPost(url, dataLogoff, Slot(self._logoffStatusCallback, self), 3)
end

function SDKImpBase:_logoffStatusCallback(succ, data)
	Framework.Tools.LuaToolkit.LogEx("cwtjp _logoffStatusCallback:" .. succ .. "|" .. data)

	if succ then
		local data = ClientUtils.string2Table(data)
		local status_code = data.cancel_status

		if tonumber(status_code) == 1 then
			self:_setSpinnerVisible(false)
		elseif tonumber(status_code) == 2 or tonumber(status_code) == 3 then
			local message = Lang.get(76926)

			local function yesFunc()
				local access_token = UserData.loadCommonData("jp_sdk_token")
				local token = UserData.loadCommonData("jp_login_token")
				local acctype = UserData.loadCommonData("jp_login_acctype")
				local dataCancel = {}

				dataCancel.access_token = access_token
				dataCancel.token = token
				dataCancel.acctype = acctype

				local url = UrlConfig.CancellationCancel

				OpenServerHelper.httpPost(url, dataCancel, Slot(self._logoffCancelCallback, self), 3)
			end

			local function noFunc()
				SDKAppUtils.exitApp()
			end

			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), message, yesFunc, noFunc, nil, Lang.get(76927), Lang.get(76928))
			self:_setSpinnerVisible(false)
		else
			self:_setSpinnerVisible(false)
		end
	end
end

function SDKImpBase:_logoffCancelCallback(succ, data)
	Framework.Tools.LuaToolkit.LogEx("cwtjp _logoffCancelCallback:" .. succ .. "|" .. data)
end

function SDKImpBase:_bindOpenID(data)
	local url = UrlConfig.AccountBindUrl

	data[OpenServerConst.OPEN_ID] = AccountManager.getOpenID()
	data[OpenServerConst.OPEN_TOKEN] = AccountManager.getToken()

	HttpHelper.post(url, ClientUtils.table2String(data), self._slotOnBindOpenIDResp, 1)
end

function SDKImpBase:_onBindOpenIDResp(responseCode, dataString)
	local data, openID, token, accType, succ

	if responseCode == ResponseCode.SUCC then
		data = ClientUtils.string2Table(dataString)
		openID = data[OpenServerConst.OPEN_ID]
		token = data[OpenServerConst.OPEN_TOKEN]
		accType = data[OpenServerConst.ACCOUNT_TYPE]
	end

	succ = openID and token and true or false

	self:_onGetToken(GET_TOKEN_TYPE.BIND, succ, data)
end

function SDKImpBase:_setSpinnerVisible(visible, content)
	if GameFsm.isInState(Const.STATE_LOGIN) then
		RetryHelper.setSpinnerVisible(Const.RETRY_NAME_OPEN_TOKEN, visible)
	end
end

function SDKImpBase:testSDKLogin(strNotify)
	local data = ClientUtils.string2Table(strNotify)

	self:_onSDKLoginSucc(data)
end

return SDKImpBase
