-- chunkname: @/tmp/or_script/lua_compile/sdk/DPSAnySdk-Android.lua

local cjson = require("cjson.safe")
local luaj = require("cocos.cocos2d.luaj")
local PlatformClassPath = "org/dpstrom/anysdk/DPSLuaHelper"

EVENT_TYPE = {
	SDK_ORDER_SUCCESS = 1009,
	LOGOUT_SUCCESS = 1006,
	PAY_INCOMPLETE_SUCCESS = 1015,
	PAY_CANCEL = 1011,
	PAY_INCOMPLETE_NO = 1014,
	LOGIN_CANCEL = 1002,
	LOGIN_SUCCESS = 1000,
	LOGOUT_CANCEL = 1008,
	SWITCH_ACCOUNT_CANCEL = 1005,
	LOGIN_FAILURE = 1001,
	SWITCH_ACCOUNT_SUCCESS = 1003,
	PAY_INCOMPLETE_FAILURE = 1016,
	PAY_SUCCESS = 1012,
	BIND_FAILURE = 1022,
	SWITCH_ACCOUNT_FAILURE = 1004,
	BIND_SUCCESS = 1021,
	PAY_FAILURE = 1010,
	LOGOUT_FAILURE = 1007
}
DPSAnySdk = class("DPSAnySdk", legs.Actor)

function DPSAnySdk:initialize()
	super.initialize(self)

	local function cb(_data)
		local params

		self:onSDKCallBack((_data and _data ~= "" or nil) and cjson.decode(_data))
	end

	self:regSDKCallback(cb)
end

function DPSAnySdk:onSDKCallBack(params)
	if params == nil then
		return
	end

	local cmd = params.cmd

	if cmd == nil then
		return
	end

	local cb = self["sdk_cb_" .. cmd]

	if cb then
		cb(self, params)
	end
end

function DPSAnySdk:regSDKCallback(cb)
	luaj.callStaticMethod(PlatformClassPath, "setLuaCallBack", {
		cb
	}, "(I)V")
end

function DPSAnySdk:callMethod(methodName, params)
	self:callSDKFunction(methodName, params or "")
end

function DPSAnySdk:callSDKFunction(cmd, params)
	if not cmd then
		return
	end

	local args = {}

	args[1] = cmd

	if params and type(params) == "table" then
		args[2] = table.nums(params) > 0 and cjson.encode(params) or ""
	elseif params and type(params) == "string" then
		args[2] = params
	end

	luaj.callStaticMethod(PlatformClassPath, "commandFunction", args, "(Ljava/lang/String;Ljava/lang/String;)V")
end

function DPSAnySdk:getSdkSource()
	local channel = ""
	local var_7_0, var_7_1 = luaj.callStaticMethod(PlatformClassPath, "getSdkSource", {}, "()Ljava/lang/String;")

	channel = var_7_1

	return (not var_7_0 or nil) and ""
end

function DPSAnySdk:getChannelID()
	if GameConfigs and GameConfigs.channel then
		return GameConfigs.channel
	end

	local success, channel = luaj.callStaticMethod(PlatformClassPath, "getChannelID", {}, "()Ljava/lang/String;")

	return (not success or nil) and "test"
end

function DPSAnySdk:getGameId()
	local gid = 0, 0
	local success = false
	local channelID = self:getChannelID()

	if channelID == "dpstorm_android" or channelID == "dpstorm_ios" then
		success, gid = luaj.callStaticMethod(PlatformClassPath, "getGameId", {}, "()I")
	end

	return (not success or nil) and 0
end

function DPSAnySdk:getPlayerId()
	local pid = 0, 0
	local success = false
	local channelID = self:getChannelID()

	if channelID == "dpstorm_android" or channelID == "dpstorm_ios" then
		success, pid = luaj.callStaticMethod(PlatformClassPath, "getPlayerId", {}, "()I")
	end

	return (not success or nil) and 0
end

function DPSAnySdk:payOff(data)
	if not data then
		self:dispatch(ShowTipEvent({
			tip = "function SDKHelper:payOff(data): data is nil"
		}))

		return
	end

	self:callMethod("pay", data)
end

function DPSAnySdk:sdk_cb_login(params)
	local errorCode = "loginFailure"

	if EVENT_TYPE.LOGIN_SUCCESS == params.eventType then
		errorCode = "loginSuccess"

		self:saveLoginInfo(params.playerInfo)
	end

	self:dispatch(Event:new(EVT_LOGIN, {
		errorCode = errorCode,
		message = params
	}))
end

function DPSAnySdk:sdk_cb_logout(params)
	local errorCode = "logoutFailure"

	if EVENT_TYPE.LOGOUT_SUCCESS == params.eventType then
		errorCode = "logoutSuccess"
	end

	self:dispatch(Event:new(EVT_LOG_OUT, {
		errorCode = errorCode,
		message = params
	}))

	if errorCode == "logoutSuccess" then
		REBOOT("REBOOT_NOUPDATE")
	end
end

function DPSAnySdk:sdk_cb_switchAccount(params)
	local errorCode = "switchAccountFailure"

	if EVENT_TYPE.SWITCH_ACCOUNT_SUCCESS == params.eventType then
		errorCode = "switchAccountSuccess"

		self:saveLoginInfo(params.playerInfo)

		local scene = self:getInjector():getInstance("BaseSceneMediator", "activeScene")
		local topViewName = scene:getTopViewName()

		if topViewName ~= "LoginView" then
			REBOOT("REBOOT_NOUPDATE")
		end
	end

	self:dispatch(Event:new(EVT_SWITCH_ACCOUNT, {
		errorCode = errorCode,
		message = params
	}))
end

function DPSAnySdk:sdk_cb_payInit(params)
	local errorCode = "payInitSuccess"

	self:dispatch(Event:new(EVT_PAY_OFF, {
		errorCode = errorCode,
		message = params
	}))
end

function DPSAnySdk:sdk_cb_pay(params)
	self:dispatch(Event:new(EVT_PAY_OFF, {
		errorCode = (EVENT_TYPE.PAY_SUCCESS == params.eventType or nil) and "paySuccess",
		message = params
	}))
end

function DPSAnySdk:sdk_cb_showBindPhone(params)
	local errorCode = "bindFailure"

	if EVENT_TYPE.BIND_SUCCESS == params.eventType then
		errorCode = "bindSuccess"

		self:saveCacheValue("loginType", 2)
	end

	self:dispatch(Event:new(EVT_BIND_ACCOUNT, {
		errorCode = errorCode,
		message = params
	}))
end

function DPSAnySdk:sdk_cb_payIncomplete(params)
	local errorCode = "payIncFailure"

	if EVENT_TYPE.PAY_INCOMPLETE_NO == params.eventType then
		errorCode = "payNoIncomplete"
	elseif EVENT_TYPE.PAY_INCOMPLETE_SUCCESS == params.eventType then
		errorCode = "payIncComplete"
	end

	self:dispatch(Event:new(EVT_PAY_OFF, {
		errorCode = errorCode,
		message = params
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

	self:callMethod("reportData", params)
end

function DPSAnySdk:openAIHelpElva(roleId, roleName, serverId)
	self:callMethod("openAIHelpElva", {
		roleId = roleId,
		roleName = roleName,
		serverId = serverId
	})
end

function DPSAnySdk:reportByAD(event)
	self:callMethod(SDK_FUN.REPORT_DATA_AD, cjson.encode({
		eventName = event
	}))
end

function DPSAnySdk:reportByWM(event)
	self:callMethod(SDK_FUN.REPORT_DATA_WM, cjson.encode({
		eventName = event
	}))
end

function DPSAnySdk:reportByServerList(event, url)
	if event == "gameGetServerListSuccess" then
		event = "success"
	end

	if event == "gameGetServerListError" then
		event = "error"
	end

	if event == "gameGetServerListBegin" then
		event = "begin"
	end

	self:callMethod(SDK_FUN.REPORT_DATA_WM_SL, cjson.encode({
		state = event,
		url = url
	}))
end

function DPSAnySdk:setLanguage(language)
	self:callMethod(SDK_FUN.SET_LANGUAGE, cjson.encode({
		language = language
	}))
end

function DPSAnySdk:requestReviewInApp(data)
	local channelID = SDKHelper:getChannelID()

	if channelID == "wanmeiGlobal_android_amazon" or channelID == "wanmeiGlobal_android_samsungapps" or channelID == "wanmeiGlobal_android_huaweiappgallery" or channelID == "wanmeiGlobal_android_apt" then
		return
	end

	self:callMethod(SDK_FUN.REQUEST_REVIEW_IN_APP)
end
