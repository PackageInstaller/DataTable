-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\FatigueManager.lua

local UrlConfig = require("Network/UrlConfig")
local SDKConst = require("SDK/SDKConst")
local OpenServerConst = require("Network/OpenServerConst")
local EventConst = require("EventConst")
local ResponseCode = SDKConst.ResponseCode
local ClientUtils = ClientUtils
local HttpUtils = Framework.Network.HttpUtils
local FatigueManager = {}
local self = FatigueManager

FatigueManager.MIN_KICK_OFF_SEC = 2

local KICK_OFF_REASON = {
	CURFEW = 1,
	TIME_LIMIT = 2,
	UNKNOWN = 0
}
local SVR_ERROR_CODE = {
	INVALID_ID_CARD = 101
}

function FatigueManager._initOnce()
	self._channelSwitch = ChannelUtil.isFatigueEnabled()
	self._overallSwitch = true
	self._limitLoaded = false
	self._slotKickOff = Slot(self._onKickOff, KICK_OFF_REASON.TIME_LIMIT)
	self._kickOffTimer = Timer.New(self._slotKickOff, 3600, 1, false)
	self._retryTimer = Timer.New(self.start, 60, 3, false)
	self._curfewTimer = Timer.New(self._onCheckCurfew, 60, -1, false)

	self.clearOnExit()

	self._initedOnce = true
end

function FatigueManager.init()
	if not self._initedOnce then
		self._initOnce()
	end

	self._clearLimit()
end

function FatigueManager.clearOnExit()
	self._userInfoProvidedBySDK = false
	self._sdkAge = nil

	if self._kickOffTimer then
		self._kickOffTimer:Stop()
		self._retryTimer:Stop()
		self._curfewTimer:Stop()
	end

	EventCenter.removeEventListener(EventConst.NEW_DAY, self._onNewDay)
end

function FatigueManager.start()
	if self._channelSwitch then
		self._requestFatigueLimit()
	end
end

function FatigueManager.isSwitchOn()
	return self._overallSwitch and self._channelSwitch
end

function FatigueManager.isRegistered()
	return self._age ~= nil
end

function FatigueManager.isUnderage()
	return self._age ~= nil and self._age < 18
end

function FatigueManager.isUnlimited()
	return self.isRegistered() and not self.isUnderage()
end

function FatigueManager._requestFatigueLimit()
	local data = {}

	data[OpenServerConst.OPEN_TOKEN] = AccountManager.getToken()

	local url = ClientUtils.composeGetUrl(UrlConfig.LimitOnline, data)

	HttpHelper.get(url, self._onFatigueRequestLimitResp)
end

function FatigueManager._onFatigueRequestLimitResp(respCode, dataStr)
	if not AccountManager.isLoggedIn() then
		return
	end

	local age, secLimit, secPassed

	if ResponseCode.SUCC == respCode then
		local data = ClientUtils.string2Table(dataStr)

		age, secLimit, secPassed = self._parseLimit(data)

		if secLimit and secPassed then
			self._setLimit(age, secLimit, secPassed)
		end

		if not self.isRegistered() then
			self._onNotRegistered()
		end
	end

	if secLimit == nil then
		self._retryTimer:Start()
	end
end

function FatigueManager._parseLimit(data)
	local secLimit, secPassed, age

	if data then
		secLimit = data.online_limit
		secPassed = data.online_today
		age = data.age

		if age and age <= 0 then
			age = nil
		end
	end

	return age, secLimit, secPassed
end

function FatigueManager._parseSubmitError(data)
	local code, msg

	if data then
		local errorData = data.error

		if errorData then
			code = errorData.code
			msg = errorData.message
		end
	end

	return code, msg
end

function FatigueManager._setLimit(age, secLimit, secPassed)
	self._age = age
	self._secLimit = secLimit
	self._secPassed = secPassed
	self._limitLoaded = true

	self._retryTimer:Stop()

	if self.isUnlimited() then
		self._setKickOffTimer(false)
		self._curfewTimer:Stop()
		EventCenter.removeEventListener(EventConst.NEW_DAY, self._onNewDay)
	else
		local duration = secLimit - secPassed

		duration = math.max(FatigueManager.MIN_KICK_OFF_SEC, duration)

		self._setKickOffTimer(true, duration)
		self._curfewTimer:Restart()
		EventCenter.addEventListener(EventConst.NEW_DAY, self._onNewDay)
	end
end

function FatigueManager._clearLimit()
	self._age = nil
	self._secLimit = nil
	self._secPassed = nil
	self._limitLoaded = false
end

function FatigueManager._onNotRegistered()
	local token = AccountManager.getToken()

	if token == nil then
		return
	end

	local data = {}

	data[OpenServerConst.OPEN_TOKEN] = token

	if not ChannelUtil.isFlowFatigueUserInfo() then
		if self._userInfoProvidedBySDK then
			data.age = self._sdkAge

			self.submitUserInfo(data)
		end
	elseif self.isSwitchOn() then
		self.showRegisterDlg(data)
	end
end

function FatigueManager.submitUserInfo(data, callback)
	if not data then
		return
	end

	self._submitCallback = callback

	local stringData = ClientUtils.table2String(data)
	local url = UrlConfig.LimitUserInfo

	HttpHelper.post(url, stringData, self._onSubmitResp)
end

function FatigueManager.showRegisterDlg(data)
	self._dlgDataCache = data

	UIManager.getUI("flowAccountCenterDlg", true):setRealName()
end

function FatigueManager.onRegisterDlgSubmit(confirm, name, idCard)
	if not confirm then
		return
	end

	local data = self._dlgDataCache

	data.name = name
	data.idcard = idCard

	self.submitUserInfo(data)
end

function FatigueManager.setUserInfoBySDK(age)
	self._sdkAge = age
	self._userInfoProvidedBySDK = true
end

function FatigueManager._onSubmitResp(respCode, dataStr)
	if not AccountManager.isLoggedIn() then
		return
	end

	local succ = false
	local errorCode, errorMsg = nil, Lang.get(30039)

	if ResponseCode.SUCC == respCode then
		local data = ClientUtils.string2Table(dataStr)

		errorCode, errorMsg = self._parseSubmitError(data)

		if errorCode then
			if errorCode == SVR_ERROR_CODE.INVALID_ID_CARD then
				errorMsg = Lang.get(30040)
			end
		else
			local age, secLimit, secPassed = self._parseLimit(data)

			if secLimit and secPassed then
				succ = true

				self._setLimit(age, secLimit, secPassed)
			end
		end
	end

	if not succ then
		MsgManager.notice(errorMsg)
		UIManager.getUI("flowAccountCenterDlg", true):setRealName()
	end

	if self._submitCallback then
		self._submitCallback(succ)

		self._submitCallback = nil
	end
end

function FatigueManager._setKickOffTimer(isOn, duration)
	if isOn then
		self._kickOffTimer:Setting(self._slotKickOff, duration, 1, false)
		self._kickOffTimer:Restart()
	else
		self._kickOffTimer:Stop()
	end
end

function FatigueManager._onKickOff(reason)
	if not self.isSwitchOn() then
		return
	end

	AccountManager.logoutGame()

	if KICK_OFF_REASON.TIME_LIMIT == reason then
		if not self.isRegistered() and ChannelUtil.isFlowFatigueUserInfo() then
			local msgContent = Lang.get(30041)

			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msgContent, self._onNotRegistered, nil, -1, Lang.get(30042))
		else
			local msgContent = Lang.get(30043)

			UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(5), msgContent)
		end
	elseif KICK_OFF_REASON.CURFEW == reason then
		local msgContent = Lang.get(30044)

		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(5), msgContent)
	end
end

function FatigueManager._onCheckCurfew()
	local serverTime = os.date("*t", ClientUtils.getServerTime())
	local hour = serverTime.hour

	if hour > 22 or hour < 8 then
		self._onKickOff(KICK_OFF_REASON.CURFEW)
	end
end

function FatigueManager.setOverallSwitch(isOn)
	self._overallSwitch = isOn
end

function FatigueManager._onNewDay()
	if not AccountManager.isLoggedIn() then
		return
	end
end

function FatigueManager.onGenOrderFatigue()
	if not self.isRegistered() then
		local msgContent = Lang.get(30045)

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msgContent, self._onNotRegistered, nil, -1, Lang.get(30042))
	else
		local msgContent = Lang.get(30046)

		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(5), msgContent)
	end
end

return FatigueManager
