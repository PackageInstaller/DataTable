local var_0_0 = {}

local function var_0_1(arg_1_0)
	if arg_1_0 == 0 then
		var_0_0.payRequestingHandler(arg_1_0)
	end
end

function var_0_0.init(arg_2_0)
	SDKManager.registerPayHandler(var_0_1)
end

function var_0_0.doPayment(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)
	local var_3_0 = require("data.recharge_data")[arg_3_1]

	function arg_3_0.payRequestingHandler(arg_4_0)
		TrackingManager.pay(arg_3_2, DeviceManager.platform, "CNY", var_3_0.rmb)
		addWaitingLayer()
	end

	TrackingManager.order(arg_3_2, "CNY", var_3_0.rmb)
	print("PayInfo: ", arg_3_1, var_3_0.name, var_3_0.des, var_3_0.rmb * 100, json.encode({
		productid = var_3_0.productid,
		playerid = require("model.playermodel").playerid
	}))
	SDKManager.doPay(arg_3_6, arg_3_5)
end

function var_0_0.getExtra(arg_5_0)
	local var_5_0 = {
		login_type = SDKManager:getLoginType(),
		open_key = SDKManager:getOpenKey(),
		pfkey = SDKManager:getPfkey(),
		platform = SDKManager:getyingyongbaoplatform(),
		open_id = SDKManager:getOpenid(),
		pf = SDKManager:getPf()
	}

	print("pay_yingyongbao:getExtra")
	print(dump(var_5_0))

	return json.encode(var_5_0)
end

return var_0_0
