-- chunkname: @/tmp/or_script/lua_compile/sdk/DPSAnySdk-iOS.lua

local cjson = require("cjson.safe")

require("sdk.IDPSAnySdk")
require("sdk.DPSAnySdkUtils")

DPSAnySdk = class("DPSAnySdk", legs.Actor)

DPSAnySdk:implements(IDPSAnySdk)
DPSAnySdk:has("_gameContext", {
	is = "r"
})
DPSAnySdk:has("_payOffHandler", {
	is = "rw"
})
DPSAnySdk:has("_loginHandler", {
	is = "rw"
})
DPSAnySdk:has("_logOutHandler", {
	is = "rw"
})
DPSAnySdk:has("_shareHandler", {
	is = "rw"
})
DPSAnySdk:has("_switchAccountHandler", {
	is = "rw"
})

function DPSAnySdk:initialize()
	super.initialize(self)

	if dpsAnySdk then
		dpsAnySdk.startup("")

		dpsAnySdk.listener = self
	end
end

function DPSAnySdk:setGameContext(gameContext)
	self._gameContext = gameContext
end

function DPSAnySdk:callMethod(methodName, ...)
	if dpsAnySdk then
		return dpsAnySdk.callMethod(methodName, ...)
	end
end

function DPSAnySdk:setOpenId(openId)
	if dpsAnySdk then
		return dpsAnySdk.setOpenId(tostring(openId))
	end
end

function DPSAnySdk:getOpenId()
	if dpsAnySdk then
		return dpsAnySdk.getOpenId()
	end

	return ""
end

function DPSAnySdk:getVendor()
	if dpsAnySdk then
		return dpsAnySdk.getVendor()
	end

	return ""
end

function DPSAnySdk:getSdkSource(default)
	if dpsAnySdk then
		if dpsAnySdk.getSdkSource() == "" then
			return default or ""
		else
			return dpsAnySdk.getSdkSource()
		end
	end

	return default or ""
end

function DPSAnySdk:getChannelID()
	if dpsAnySdk then
		if dpsAnySdk.getSdkChannel() == "" then
			return ""
		else
			return dpsAnySdk.getSdkChannel()
		end
	end

	return ""
end

function DPSAnySdk:getStatisticsBaseInfo()
	return DPSAnySdkUtils.getStatisticsBaseInfo(self:getOpenId(), self:getSdkSource())
end

function DPSAnySdk:switchAccount(data)
	self:callMethod("switchAccount")
end

function DPSAnySdk:logOut(data)
	super.logOut(self, data)
	self:callMethod("logOut")
end

function DPSAnySdk:payOff(data)
	if not data then
		self:dispatch(ShowTipEvent({
			tip = "function Sdk:payOff(data): data is nil"
		}))

		return
	end

	self:callMethod("payOff", cjson.encode(data))
end

function DPSAnySdk:getVerifyData()
	if self:getSdkSource() == "any_sdk_ios" then
		self:callMethod("getPid")

		return dpsAnySdk.getUserValue("pid")
	end

	return ""
end

function DPSAnySdk:getGameId()
	return dpsAnySdk.getUserValue("gid")
end

function DPSAnySdk:getPlayerId()
	return dpsAnySdk.getUserValue("pid")
end

function DPSAnySdk:onPayInit(errorCode, message)
	self:dispatch(Event:new(EVT_PAY_OFF, {
		errorCode = tostring(errorCode),
		message = cjson.decode(message)
	}))
end

function DPSAnySdk:onLogin(errorCode, message)
	print("errorCode:", errorCode)
	print("message", message)

	local params = cjson.decode(message)

	if errorCode == "loginSuccess" then
		self:saveLoginInfo(params)
		self:dispatch(Event:new(EVT_LOGIN, {
			errorCode = tostring(errorCode),
			message = cjson.decode(message)
		}))
	elseif errorCode == "loginFailure" then
		self:dispatch(ShowTipEvent({
			tip = tostring(errorCode)
		}))
	end
end

function DPSAnySdk:onLogOut(errorCode, message)
	self:dispatch(Event:new(EVT_LOG_OUT, {
		errorCode = tostring(errorCode),
		message = cjson.decode(message)
	}))

	if errorCode == "logoutSuccess" then
		REBOOT("REBOOT_NOUPDATE")
	end
end

function DPSAnySdk:onPayOff(errorCode, message)
	self:dispatch(Event:new(EVT_PAY_OFF, {
		errorCode = tostring(errorCode),
		message = cjson.decode(message)
	}))
end

function DPSAnySdk:onSwitchAccount(errorCode, message)
	if errorCode == "switchAccountSuccess" then
		local scene = self:getInjector():getInstance("BaseSceneMediator", "activeScene")
		local topViewName = scene:getTopViewName()

		if topViewName ~= "LoginView" then
			REBOOT("REBOOT_NOUPDATE")
		end
	end

	self:dispatch(Event:new(EVT_SWITCH_ACCOUNT, {
		errorCode = tostring(errorCode),
		message = cjson.decode(message)
	}))
end

function DPSAnySdk:report(reportType, data)
	if not data then
		self:dispatch(ShowTipEvent({
			tip = "SDKHelper:report(data): data is nil"
		}))

		return
	end

	local params = self._repotParams

	params.reportType = reportType

	for key, value in pairs(data) do
		params[key] = value
	end

	self:callMethod("reportData", cjson.encode(params))
end

function DPSAnySdk:openAIHelpElva(roleId, roleName, serverId)
	self:callMethod("openAIHelpElva", roleId, roleName, serverId)
end

function DPSAnySdk:reportByAD(event)
	self:callMethod(SDK_FUN.REPORT_DATA_AD, cjson.encode({
		eventName = event
	}))
end

function DPSAnySdk:reportByWM(event)
	self:callMethod(SDK_FUN.REPORT_DATA_WM, event)
end

function DPSAnySdk:reportByServerList(event, url)
	self:callMethod(SDK_FUN.REPORT_DATA_WM_SL, event, url)
end

function DPSAnySdk:setLanguage(language)
	self:callMethod(SDK_FUN.SET_LANGUAGE, language)
end

function DPSAnySdk:requestReviewInApp(data)
	self:callMethod(SDK_FUN.REQUEST_REVIEW_IN_APP)
end
