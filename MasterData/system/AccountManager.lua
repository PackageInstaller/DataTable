-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\AccountManager.lua

local UserData = require("Helper/UserData")
local UrlConfig = require("Network/UrlConfig")
local SDKConst = require("SDK/SDKConst")
local DeviceHelper = require("Helper/DeviceHelper")
local PluginManager = require("SDK/Plugin/PluginManager")
local NetService = require("Network/NetService")
local OpenServerConst = require("Network/OpenServerConst")
local Analytics = require("SDK/Analytics")
local EventConst = require("EventConst")
local OpenServerHelper = require("Network/OpenServerHelper")
local RetryHelper = require("Helper/RetryHelper")
local ClientUtils = ClientUtils
local HttpUtils = Framework.Network.HttpUtils
local IS_PUBLISH_VERSION = IS_PUBLISH_VERSION
local LoginState = SDKConst.LoginState
local AccountType = OpenServerConst.AccountType
local AccountTypeId = OpenServerConst.AccountTypeId
local ErrorText = OpenServerConst.ErrorText
local ResponseCode = SDKConst.ResponseCode
local AccountManager = {}
local self = AccountManager
local log = log
local Const = Const
local utils = utils
local IS_FORCE_INTRANET = Framework.Tools.LuaToolkit.IsForceIntranet()

if not IsGLDeclared("AccountManager") or not AccountManager then
	GLDeclare("AccountManager", AccountManager)
end

self._loginState = LoginState.UNLOGIN
self._callbackLoginStateChange = nil
self._isReconnectLogin = false
self.CONNECT_GAME_SERVER_CD = 5

local CALLBACK_TYPE = {
	GET_TOKEN_FINISH = 1,
	BIND_PHONE = 4,
	UPGRADE_GUEST = 5
}

function AccountManager.init()
	self._lastConnectServerTime = 0
	self._userCallbackDict = {}
	self._isReconnect = false
end

function AccountManager.setLoginStateCallback(callback)
	self._callbackLoginStateChange = callback
end

function AccountManager.setLoginState(newState)
	local oldState = self._loginState

	self._loginState = newState

	local callback = self._callbackLoginStateChange

	if callback then
		callback(oldState, newState)
	end
end

function AccountManager.getLoginState()
	return self._loginState
end

function AccountManager.cleanReqTokenData()
	self._jpReqTokenData = nil
end

function AccountManager.loginOpenServer(data, callback, sectionMode)
	PluginManager.initBeforeLogin()
	self._onLoginStart(callback)

	self._jpReqTokenData = data
	self._reqTokenData = data
	data[OpenServerConst.SPMARK] = UrlConfig.spMark

	if VersionUtils.isSectionEnabled() then
		ServerSection.setData(data)
	end

	if sectionMode then
		ServerSection.request(self._onSectionResp)
	else
		local url = UrlConfig.AccountUrl

		OpenServerHelper.httpPost(url, data, Slot(self._onGetToken, data), 3)
	end
end

function AccountManager.loginOpenServerAgain_JP()
	local data = self._jpReqTokenData

	if not data then
		return
	end

	data[OpenServerConst.SERVER_ID] = tostring(SvrListManager.getSelectedSvrID())

	local url = UrlConfig.AccountUrl

	OpenServerHelper.httpPost(url, data, Slot(self.cleanReqTokenData), 1)
end

function AccountManager.clearLoginOpenServerRequest()
	self._reqTokenData = nil
end

function AccountManager.bindOpenID(data, callback)
	self._setUserCallback(CALLBACK_TYPE.GET_TOKEN_FINISH, callback)
end

function AccountManager._onLoginStart(callback)
	self._setUserCallback(CALLBACK_TYPE.GET_TOKEN_FINISH, callback)
	self.setLoginState(LoginState.IN_PROCESS)
	self._resetLoginFlags()
end

function AccountManager.setReconnectFlag(isReconnect)
	self._isReconnectLogin = isReconnect
end

function AccountManager.isReconnect()
	return self._isReconnectLogin
end

function AccountManager.getCurAccountChannelId()
	return AccountTypeId[self.accType] or 0
end

function AccountManager.logoutGame()
	self.clearLoginOpenServerRequest()
	self.setLoginState(LoginState.UNLOGIN)
	SDKAgent.onRoleLogout()
	GameFsm.reset()
end

function AccountManager.getOpenID()
	return self._openID
end

function AccountManager.setOpenID(openID)
	self._openID = openID
end

function AccountManager.getToken()
	return self._openToken
end

function AccountManager.setToken(token)
	self._openToken = token
end

function AccountManager.isLoggedIn()
	return self.getLoginState() == LoginState.LOGIN
end

function AccountManager.parseServerError(data)
	local code, msg
	local errorMsg = data and data.error

	if errorMsg then
		code = errorMsg.code
		msg = ErrorText[code]

		if msg == nil or msg == "" then
			msg = errorMsg.message
		end
	end

	if msg == nil then
		msg = Lang.get(30013)
	end

	return code, msg
end

function AccountManager._onGetToken(reqData, responseCode, dataString)
	if self._reqTokenData ~= reqData then
		return
	end

	local data, openID, token, accType, isNewAccount
	local needReset = true

	if responseCode == ResponseCode.SUCC then
		data = ClientUtils.string2Table(dataString)
		openID = data[OpenServerConst.OPEN_ID]
		token = data[OpenServerConst.OPEN_TOKEN]
		accType = data[OpenServerConst.ACCOUNT_TYPE]
		isNewAccount = data[OpenServerConst.IS_FIRST] == 1
	end

	if openID and token then
		local oldOpenID = self.getOpenID()
		local openIDChanged = oldOpenID ~= openID

		needReset = openIDChanged

		if openIDChanged then
			self.logoutGame()
			PluginManager.initAfterLogin()
		end

		self.setAccount(accType, openID, token)

		if openIDChanged then
			Analytics.onAccountLogin()
		end

		if not IS_PUBLISH_VERSION then
			UserData.saveCommonData(Const.UD_KEY_DEBUG_TOKEN, token)
			UserData.saveCommonData(Const.UD_KEY_DEBUG_OPENID, openID)
		end

		if isNewAccount then
			Analytics.onNewAccountCreate()
		end

		self._callUserCallback(CALLBACK_TYPE.GET_TOKEN_FINISH, true, data)
	else
		local code, msg

		if responseCode == ResponseCode.FAIL then
			msg = Lang.get(30014)

			if dataString then
				msg = msg .. ":" .. dataString
			end
		else
			code, msg = self.parseServerError(data)
		end

		msg = msg or Lang.get(30015)

		MsgManager.notice(msg)

		if self.getLoginState() == LoginState.IN_PROCESS then
			self.setLoginState(LoginState.UNLOGIN)
		end

		self._callUserCallback(CALLBACK_TYPE.GET_TOKEN_FINISH, false, data, reqData)
		Analytics.logClientError("open_token_error", tostring(responseCode), dataString)
	end

	SDKAgent._lastCallLoginTime = nil
end

function AccountManager._onSectionResp()
	local defaultSection = ServerSection.getDefaultSection()
	local tokenData

	if defaultSection then
		ServerSection.setSection(defaultSection)

		tokenData = ServerSection.getTokenData(defaultSection)

		local reqDataID = self._reqTokenData and self._reqTokenData[OpenServerConst.ACCOUNT_ID]
		local tokenDataID = tokenData and tokenData[OpenServerConst.ACCOUNT_ID]

		if reqDataID ~= tokenDataID then
			tokenData = nil
		end
	end

	if tokenData then
		self._onGetToken(self._reqTokenData, ResponseCode.SUCC, ClientUtils.table2String(tokenData))
	else
		self._onGetToken(self._reqTokenData, ResponseCode.FAIL, nil)
	end
end

function AccountManager.setAccount(accType, openID, token)
	self.accType = accType

	self.setOpenID(openID)
	self.setToken(token)
	self.setLoginState(LoginState.LOGIN)
	NetService.recordInfo(openID, token)
end

function AccountManager.connectGameServer(callbackSucc, callbackFail, force)
	if not force then
		local timeNow = os.time()

		if timeNow - self._lastConnectServerTime < self.CONNECT_GAME_SERVER_CD then
			return false
		end
	end

	local SvrListManager = SvrListManager
	local serverInfo = SvrListManager.getSelectedSvrInfo()

	if serverInfo and serverInfo.isValid then
		self._callbackConnectGameSucc = callbackSucc
		self._callbackConnectGameFail = callbackFail
		self._lastConnectServerTime = os.time()

		NetService.disconnect()
		NetService.init()
		NetService.setServiceInfo(serverInfo.id, serverInfo.ip, serverInfo.port)
		NetService.connect(self._onConnectGameSucc, self._onConnectGameFail)

		return true
	else
		return false
	end
end

function AccountManager._onConnectGameLater()
	RetryHelper.setSpinnerVisible(Const.RETRY_NAME_GAME_SERVER, false)
end

function AccountManager._onConnectGameSucc()
	local callback = self._callbackConnectGameSucc

	self._callbackConnectGameSucc = nil

	if callback then
		callback()
	end
end

function AccountManager._onConnectGameFail()
	local callback = self._callbackConnectGameFail

	self._callbackConnectGameFail = nil

	if callback then
		callback()
	end
end

function AccountManager.onRoleLogin()
	self._isReconnect = self._isReconnectLogin
	self._isReconnectLogin = false

	if RegionUtils.isSEA() and not VersionUtils.isSectionEnabled() then
		ServerSection.setSection(ServerSection.getSection())
	end
end

function AccountManager.onRoleCreate()
	SDKAgent.onRoleCreate()
end

function AccountManager._setUserCallback(event, callback)
	self._userCallbackDict[event] = callback
end

function AccountManager._callUserCallback(event, ...)
	local callback = self._userCallbackDict[event]

	if callback ~= nil then
		self._userCallbackDict[event] = nil

		callback(...)
	end
end

function AccountManager._resetLoginFlags()
	self._isReconnectLogin = false
end

return AccountManager
