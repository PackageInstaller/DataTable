local var_0_0 = {
	registerInitHandler = function(arg_1_0)
		m4399SDK.registerInitCallback(function()
			if arg_1_0 then
				arg_1_0(0)
			end
		end)
	end,
	registerLogoutHandler = function(arg_3_0)
		m4399SDK.registerLogoutHandler(arg_3_0)
	end,
	registerSwitchUserAccountHandler = function(arg_4_0)
		m4399SDK.registerSwitchUserAccountHandler(arg_4_0)
	end,
	registerLoginHandler = function(arg_5_0)
		m4399SDK.registerLoginHandler(arg_5_0)
	end,
	registerPayHandler = function(arg_6_0)
		m4399SDK.registerPayHandler(arg_6_0)
	end,
	initSdk = function()
		m4399SDK.initSDK()
	end,
	login = function()
		m4399SDK.login()
	end,
	doPay = function(arg_9_0, arg_9_1, arg_9_2)
		m4399SDK.pay(arg_9_0, arg_9_1, arg_9_2)
	end,
	getplatform = function()
		return "android"
	end,
	getchannelid = function()
		return "270053"
	end
}
local var_0_1 = false

function var_0_0.canShare()
	return var_0_1
end

function var_0_0.setShare(arg_13_0)
	var_0_1 = arg_13_0 and arg_13_0 > 0
end

function var_0_0.initShare(arg_14_0)
	return false
end

return var_0_0
