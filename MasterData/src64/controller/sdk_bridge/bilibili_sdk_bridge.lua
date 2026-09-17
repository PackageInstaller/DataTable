local var_0_0 = {
	registerInitHandler = function(arg_1_0)
		BiliSDK.registerEventHandler(BiliSDK.EventType.INITBILI, arg_1_0)
	end,
	registerLoginHandler = function(arg_2_0)
		BiliSDK.registerEventHandler(BiliSDK.EventType.LOGIN, arg_2_0)
	end,
	registerPayHandler = function(arg_3_0)
		BiliSDK.registerEventHandler(BiliSDK.EventType.PAY, arg_3_0)
	end,
	registerLogoutHandler = function(arg_4_0)
		BiliSDK.registerEventHandler(BiliSDK.EventType.LOGOUT, arg_4_0)
	end,
	initSdk = function()
		BiliSDK.initBili()
	end,
	login = function()
		BiliSDK.login()
	end,
	logout = function()
		BiliSDK.logout()
	end,
	checkIsLogin = function()
		BiliSDK.checkIsLogin()
	end,
	getUserInfo = function()
		BiliSDK.getUserInfo()
	end,
	isRealNameAuth = function()
		BiliSDK.isRealNameAuth()
	end,
	createRole = function()
		BiliSDK.createRole()
	end,
	pay = function(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6, arg_12_7, arg_12_8)
		BiliSDK.pay(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6, arg_12_7, arg_12_8)
	end,
	getplatform = function()
		return "android"
	end,
	getchannelid = function()
		return "270048"
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
