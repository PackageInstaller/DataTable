local var_0_0 = {
	registerInitHandler = function(arg_1_0)
		JiuyouSDK.registerEventHandler(JiuyouSDK.EventType.INIT, arg_1_0)
	end,
	registerLoginHandler = function(arg_2_0)
		JiuyouSDK.registerEventHandler(JiuyouSDK.EventType.LOGIN, arg_2_0)
	end,
	registerPayHandler = function(arg_3_0)
		JiuyouSDK.registerEventHandler(JiuyouSDK.EventType.DOPAY, arg_3_0)
	end,
	registerLogoutHandler = function(arg_4_0)
		JiuyouSDK.registerEventHandler(JiuyouSDK.EventType.LOGOUT, arg_4_0)
	end,
	registerExitGameHandler = function(arg_5_0)
		JiuyouSDK.registerEventHandler(JiuyouSDK.EventType.EXIT, arg_5_0)
	end,
	registerSwitchaccountHandler = function(arg_6_0)
		JiuyouSDK.registerEventHandler(JiuyouSDK.EventType.SWITCHACCOUNT, arg_6_0)
	end,
	initSdk = function(arg_7_0)
		JiuyouSDK.initSDK()
	end,
	login = function()
		JiuyouSDK.login()
	end,
	logout = function()
		JiuyouSDK.logout()
	end,
	doPay = function(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
		JiuyouSDK.doPay(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	end,
	exit = function()
		JiuyouSDK.doExit()
	end,
	getplatform = function()
		return "android"
	end,
	getchannelid = function()
		return "270052"
	end
}
local var_0_1 = false

function var_0_0.canShare()
	return var_0_1
end

function var_0_0.setShare(arg_15_0)
	var_0_1 = arg_15_0 and arg_15_0 > 0
end

function var_0_0.initShare(arg_16_0)
	return false
end

return var_0_0
