local var_0_0 = {
	registerInitHandler = function(arg_1_0)
		XiaoqiSDK.registerEventHandler(XiaoqiSDK.EventType.INIT, arg_1_0)
	end,
	registerLoginHandler = function(arg_2_0)
		XiaoqiSDK.registerEventHandler(XiaoqiSDK.EventType.LOGIN, arg_2_0)
	end,
	registerLogoutHandler = function(arg_3_0)
		XiaoqiSDK.registerEventHandler(XiaoqiSDK.EventType.LOGOUT, arg_3_0)
	end,
	registerPayHandler = function(arg_4_0)
		XiaoqiSDK.registerEventHandler(XiaoqiSDK.EventType.PAY, arg_4_0)
	end,
	registerExitGameHandler = function(arg_5_0)
		return
	end,
	initSdk = function(arg_6_0)
		XiaoqiSDK.initSdk()
	end,
	login = function()
		XiaoqiSDK.login()
	end,
	exit = function()
		XiaoqiSDK.exit()
	end,
	doPay = function(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6, arg_9_7, arg_9_8, arg_9_9, arg_9_10)
		XiaoqiSDK.pay(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6, arg_9_7, arg_9_8, arg_9_9, arg_9_10)
	end,
	pushUserInfo = function(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
		XiaoqiSDK.pushUserInfo(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	end,
	getplatform = function()
		return "android"
	end,
	getchannelid = function()
		return "32"
	end
}
local var_0_1 = false

function var_0_0.canShare()
	return var_0_1
end

function var_0_0.setShare(arg_14_0)
	var_0_1 = arg_14_0 and arg_14_0 > 0
end

function var_0_0.initShare(arg_15_0)
	return false
end

return var_0_0
