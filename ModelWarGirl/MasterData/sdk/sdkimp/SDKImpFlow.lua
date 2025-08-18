-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\SDKImp\\SDKImpFlow.lua

local U3DOceanSDK = Framework.SDK.U3DOceanSDK
local SDKImpBase = require("SDK/SDKImp/SDKImpBase")
local SDKConst = require("SDK/SDKConst")
local OpenServerConst = require("Network/OpenServerConst")
local UserData = require("Helper/UserData")
local SDKAppUtils = require("SDK/SDKAppUtils")
local DeviceHelper = require("Helper/DeviceHelper")
local UrlConfig = require("Network/UrlConfig")
local WebView = require("SDK/Plugin/WebView")
local NetService = require("Network/NetService")
local HttpUtils = Framework.Network.HttpUtils
local ResponseCode = SDKConst.ResponseCode
local AccountType = OpenServerConst.AccountType
local ErrorCode = OpenServerConst.ErrorCode
local EventType = SDKConst.EventType
local MsgManager = MsgManager
local Const = Const
local SDKImpFlow = Class("SDKImpFlow", SDKImpBase, true)
local CALLBACK_TYPE = SDKImpBase.CALLBACK_TYPE
local GET_TOKEN_TYPE = SDKImpBase.GET_TOKEN_TYPE
local SAVED_ACCOUNT_LIST = "KEY_SAVED_ACCOUNT_LIST"
local LAST_LOGIN_ACCOUNT = "KEY_LAST_LOGIN_ACCOUNT"

SDKImpFlow._firstTimeLogin = true

function SDKImpFlow:ctor()
	self._slotGenSmsCodeFinish = Slot(self._onGenSmsCodeFinish, self)
	self._slotOnRecordMobileResp = Slot(self._onRecordMobile, self)
end

function SDKImpFlow:init()
	self:_loadAccountList()
	SDKImpFlow.super.init(self)

	self._callbackGenSmsCode = nil
end

function SDKImpFlow:_doLogin()
	if not self:tryAutoLogin() then
		UIManager.getUI("flowLogin", true)
	end
end

function SDKImpFlow:_doLogout()
	SDKImpFlow.super._doSimpleLogout(self)
end

function SDKImpFlow:_doBindGuest()
	local ui = UIManager.getUI("flowAccountCenter", true)

	if ui then
		ui:setSmsPurpose(self:_getBindPurpose())
	end
end

function SDKImpFlow:_doRecordMobile()
	local ui = UIManager.getUI("flowAccountCenter", true)

	if ui then
		ui:setSmsPurpose(OpenServerConst.SMS_CODE_PURPOSE_RECORD)
	end
end

function SDKImpFlow:_doSwitchAccount()
	self:login()
end

function SDKImpFlow:_doAccountCenter()
	self:switchAccount()
end

function SDKImpFlow:_doSDKPay(content)
	U3DOceanSDK.SdkPay(content)
end

function SDKImpFlow:questionnaire(url, callback)
	WebView.openWebView(url, callback)
end

function SDKImpFlow:_onGetToken(eventType, succ, data, reqTokenData)
	local accType = data and data[OpenServerConst.ACCOUNT_TYPE]

	if AccountType.NAME_PWD ~= accType then
		if succ then
			local isBind = eventType == GET_TOKEN_TYPE.BIND

			self:_updateAccountListOnLogin(isBind, data)

			local accountInfo = self:getAccount()
			local newGuestFlag = not accountInfo.isMobile

			self:setGuestFlag(newGuestFlag)

			if isBind and CurAvatar then
				CurAvatar.isMobileRecorded = true
			end

			self:_showNotice()
		else
			local code, msg = AccountManager.parseServerError(data)

			if eventType == GET_TOKEN_TYPE.LOGIN and (code == ErrorCode.INVALID_TOKEN or code == ErrorCode.TOKEN_OPENID_MISMATCH or code == ErrorCode.TOKEN_EXPIRE) then
				self:_shiftAccount()
				self:saveAccountList()
			end
		end
	end

	SDKImpFlow.super._onGetToken(self, eventType, succ, data, reqTokenData)
end

function SDKImpFlow:_updateAccountListOnLogin(isBind, data)
	local accType = data[OpenServerConst.ACCOUNT_TYPE]
	local openID = data[OpenServerConst.OPEN_ID]
	local token = data[OpenServerConst.OPEN_TOKEN]
	local entryID = data[OpenServerConst.ACCOUNT_ID]

	if accType == AccountType.PHONE_NUMBER_I or accType == AccountType.PHONE_NUMBER_A or isBind then
		if isBind then
			self:_extractAccount(openID, "openID")
		end

		self:_unshiftAccountDetail(entryID, true, openID, token)
	elseif accType == AccountType.DEVICE_ID then
		self:_unshiftAccountDetail(entryID, false, openID, token)
	else
		local accountInfo = self:_extractAccount(openID, "openID")

		self:_unshiftAccount(accountInfo)
	end

	self:saveAccountList()
end

function SDKImpFlow:genSmsCode(mobile, purpose, callback)
	local data = {}

	data[OpenServerConst.MOBILE] = mobile
	data[OpenServerConst.SMS_CODE_PURPOSE] = purpose

	self:_setUserCallback(CALLBACK_TYPE.GEN_SMS_CODE, callback)
	HttpHelper.post(UrlConfig.GenSmsCode, ClientUtils.table2String(data), self._slotGenSmsCodeFinish)
end

function SDKImpFlow:loginSavedToken(entryID)
	local curInfo = self:getAccount(entryID)

	if curInfo then
		local data = {}

		data[OpenServerConst.ACCOUNT_TYPE] = AccountType.OPEN_TOKEN
		data[OpenServerConst.ACCOUNT_ID] = curInfo[OpenServerConst.OPEN_ID]
		data[OpenServerConst.OPEN_TOKEN] = curInfo[OpenServerConst.OPEN_TOKEN]

		self:_requestToken(data, entryID)
	end
end

function SDKImpFlow:loginSmsCode(entryID, code)
	local data = {}

	data[OpenServerConst.ACCOUNT_TYPE] = DeviceHelper.isIOS() and AccountType.PHONE_NUMBER_I or AccountType.PHONE_NUMBER_A
	data[OpenServerConst.ACCOUNT_ID] = entryID
	data[OpenServerConst.SMS_CODE] = code

	self:_requestToken(data)
end

function SDKImpFlow:loginDeviceID()
	local deviceID = SDKAppUtils.getNativeDeviceID()
	local data = {}

	data[OpenServerConst.ACCOUNT_TYPE] = AccountType.DEVICE_ID
	data[OpenServerConst.ACCOUNT_ID] = deviceID

	self:_requestToken(data)
end

function SDKImpFlow:bindGuestWithMobile(mobile, code)
	local data = {}

	data[OpenServerConst.ACCOUNT_TYPE] = DeviceHelper.isIOS() and AccountType.PHONE_NUMBER_I or AccountType.PHONE_NUMBER_A
	data[OpenServerConst.MOBILE] = mobile
	data[OpenServerConst.SMS_CODE] = code

	self:_bindOpenID(data)
end

function SDKImpFlow:requestRecordMobile(mobile, code)
	local data = {}

	data[OpenServerConst.OPEN_ID] = AccountManager.getOpenID()
	data[OpenServerConst.MOBILE] = mobile
	data[OpenServerConst.SMS_CODE] = code
	data[OpenServerConst.OPEN_TOKEN] = AccountManager.getToken()

	HttpHelper.post(UrlConfig.AccountRecordMobileUrl, ClientUtils.table2String(data), self._slotOnRecordMobileResp)
end

function SDKImpFlow:removeEntry(entryID)
	self:_extractAccount(entryID)
	self:saveAccountList()
end

function SDKImpFlow:selectEntry(entryID)
	local accountInfo = self:_extractAccount(entryID)

	self:_unshiftAccount(accountInfo)
end

function SDKImpFlow:_createAccountInfo(id, isMobile, openID, token)
	local accountInfo = {}

	accountInfo.entryID = id
	accountInfo.isMobile = isMobile
	accountInfo.openID = openID
	accountInfo.token = token

	if isMobile then
		accountInfo.entryName = id
	else
		accountInfo.entryName = self:_getEntryNameByDeviceID(id)
	end

	return accountInfo
end

function SDKImpFlow:getAccountList()
	return self._accountList
end

function SDKImpFlow:_loadAccountList()
	local savedListStr = UserData.loadCommonData(SAVED_ACCOUNT_LIST)

	if savedListStr ~= nil then
		self._accountList = ClientUtils.string2Table(savedListStr)
	end

	if type(self._accountList) ~= "table" then
		self._accountList = {}
	end

	for i, accountInfo in ipairs(self._accountList) do
		if accountInfo[OpenServerConst.MOBILE] ~= nil then
			accountInfo.entryID = accountInfo[OpenServerConst.MOBILE]
			accountInfo.isMobile = true
			accountInfo.openID = accountInfo[OpenServerConst.OPEN_ID]
			accountInfo.token = accountInfo[OpenServerConst.OPEN_TOKEN]
			accountInfo[OpenServerConst.MOBILE] = nil
			accountInfo[OpenServerConst.OPEN_ID] = nil
			accountInfo[OpenServerConst.OPEN_TOKEN] = nil
		end
	end
end

function SDKImpFlow:saveAccountList()
	UserData.saveCommonData(SAVED_ACCOUNT_LIST, ClientUtils.table2String(self._accountList))
	self:onDataChanged()
end

function SDKImpFlow:getAccount(entryID)
	local accountList = self._accountList

	if entryID == nil then
		if #self._accountList > 0 then
			return accountList[1]
		end
	else
		for i, accountInfo in ipairs(accountList) do
			if accountInfo.entryID == entryID then
				return accountInfo
			end
		end
	end

	return nil
end

function SDKImpFlow:_extractAccount(targetValue, key)
	if key == nil then
		key = "entryID"
	end

	local ret
	local accountList = self._accountList

	for i, accountInfo in ipairs(accountList) do
		if accountInfo[key] == targetValue then
			ret = accountList[i]

			table.remove(accountList, i)

			break
		end
	end

	return ret
end

function SDKImpFlow:_shiftAccount()
	table.remove(self._accountList, 1)
end

function SDKImpFlow:_unshiftAccount(accountInfo)
	if accountInfo then
		self:_extractAccount(accountInfo.entryID)
		table.insert(self._accountList, 1, accountInfo)
	end
end

function SDKImpFlow:_unshiftAccountDetail(entryID, isMobile, openID, token)
	if entryID ~= nil and openID ~= nil and token ~= nil then
		local newAccount = self:_createAccountInfo(entryID, isMobile, openID, token)

		self:_unshiftAccount(newAccount)
	end
end

function SDKImpFlow:tryAutoLogin()
	if SDKImpFlow._firstTimeLogin then
		SDKImpFlow._firstTimeLogin = false
	else
		return false
	end

	local accountInfo = self:getAccount()

	if accountInfo ~= nil then
		local entryID = accountInfo.entryID

		self:loginSavedToken(entryID)

		return true
	end

	return false
end

function SDKImpFlow:_showNotice()
	local accountInfo = self:getAccount()

	if accountInfo ~= nil then
		local notice = UIManager.getUI("flowLoginNotice", true, true)

		if notice then
			notice:setData(accountInfo.isMobile, accountInfo.entryName)
		end
	end
end

function SDKImpFlow:_getEntryNameByDeviceID(deviceID)
	return string.format(Lang.get(30008), string.sub(deviceID, -8))
end

function SDKImpFlow:_getBindPurpose()
	return DeviceHelper.isIOS() and OpenServerConst.SMS_CODE_PURPOSE_BIND_I or OpenServerConst.SMS_CODE_PURPOSE_BIND_A
end

function SDKImpFlow:_onGenSmsCodeFinish(responseCode, content)
	local data, code, succ, msg

	if ResponseCode.SUCC == responseCode then
		data = ClientUtils.string2Table(content)
		code = data.code
	end

	if code == 0 then
		MsgManager.notice(Lang.get(30009))

		succ = true
	else
		code, msg = AccountManager.parseServerError(data)

		MsgManager.notice(msg or Lang.get(30010))

		succ = false
	end

	self:_callUserCallback(CALLBACK_TYPE.GEN_SMS_CODE, succ, code)
end

function SDKImpFlow:_onRecordMobile(responseCode, content)
	local data, code, succ, msg

	if ResponseCode.SUCC == responseCode then
		data = ClientUtils.string2Table(content)
		code = data.code
	end

	if code == 0 then
		MsgManager.notice(Lang.get(30011))

		succ = true
		CurAvatar.isMobileRecorded = true
	else
		code, msg = AccountManager.parseServerError(data)

		if code == 1 then
			MsgManager.notice(Lang.get(30011))

			succ = true
			CurAvatar.isMobileRecorded = true
		else
			MsgManager.notice(msg or Lang.get(30012))

			succ = false
		end
	end

	if succ then
		local ui = UIManager.getUI("flowAccountCenter", nil, false)

		if ui then
			ui:setVisible(false)
		end
	end

	self:_callUserCallback(CALLBACK_TYPE.RECORD_MOBILE, succ, code)
end

return SDKImpFlow
