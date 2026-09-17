local var_0_0 = {
	registerInitHandler = function(arg_1_0)
		if arg_1_0 then
			arg_1_0()
		end
	end,
	registerLoginHandler = function(arg_2_0)
		OppoSDK.registerEventHandler(OppoSDK.EventType.LOGIN, arg_2_0)
	end,
	registerPayHandler = function(arg_3_0)
		OppoSDK.registerEventHandler(OppoSDK.EventType.DOPAY, arg_3_0)
	end,
	registerLogoutHandler = function(arg_4_0)
		OppoSDK.registerEventHandler(OppoSDK.EventType.ISREALNAME, arg_4_0)
	end,
	registerExitGameHandler = function(arg_5_0)
		return
	end,
	initSdk = function(arg_6_0)
		if arg_6_0 then
			arg_6_0(0)
		end
	end,
	login = function()
		OppoSDK.login()
	end,
	isRealNameAuth = function()
		OppoSDK.isRealNameAuth()
	end,
	exit = function()
		OppoSDK.exitGame()
	end,
	doPay = function(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
		OppoSDK.doPay(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	end,
	getplatform = function()
		return "android"
	end,
	getchannelid = function()
		return "270055"
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
