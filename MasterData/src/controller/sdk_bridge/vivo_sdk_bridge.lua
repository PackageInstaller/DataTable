local var_0_0 = {
	registerLoginHandler = function(arg_1_0)
		VivoSDK.registerEventHandler(VivoSDK.EventType.LOGIN, arg_1_0)
	end,
	registerPayHandler = function(arg_2_0)
		VivoSDK.registerEventHandler(VivoSDK.EventType.PAY, arg_2_0)
	end,
	registerLogoutHandler = function(arg_3_0)
		VivoSDK.registerEventHandler(VivoSDK.EventType.LOGOUT, arg_3_0)
	end,
	registerExitGameHandler = function(arg_4_0)
		VivoSDK.registerEventHandler(VivoSDK.EventType.EXIT, arg_4_0)
	end,
	initSdk = function(arg_5_0)
		VivoSDK.initSdk()

		if arg_5_0 then
			arg_5_0(0)
		end
	end,
	exit = function()
		VivoSDK.exit()
	end,
	login = function()
		VivoSDK.login()
	end,
	reportLoginResult = function(arg_8_0, arg_8_1)
		VivoSDK.reportLoginResult(arg_8_0, arg_8_1)
	end,
	reportRoleInfo = function(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
		VivoSDK.reportRoleInfo(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	end,
	reportOrderComplete = function(arg_10_0)
		VivoSDK.reportOrderComplete(arg_10_0)
	end,
	queryMissOrderResult = function(arg_11_0)
		VivoSDK.registerEventHandler(VivoSDK.EventType.MISS_ORDER, arg_11_0)
		VivoSDK.queryMissOrderResult()
	end,
	pay = function(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6)
		VivoSDK.pay(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6)
	end,
	getplatform = function()
		return "android"
	end,
	getchannelid = function()
		return "270056"
	end
}
local var_0_1 = false

function var_0_0.canShare()
	return var_0_1
end

function var_0_0.setShare(arg_16_0)
	var_0_1 = arg_16_0 and arg_16_0 > 0
end

function var_0_0.initShare(arg_17_0)
	return false
end

return var_0_0
