local var_0_0 = {}

local function var_0_1(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if arg_1_0 == 0 then
		var_0_0.payRequestingHandler(arg_1_0, arg_1_1)
	end
end

function var_0_0.init(arg_2_0)
	SDKManager.registerPayHandler(var_0_1)
end

function var_0_0.doPayment(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = require("data.recharge_data")[arg_3_1]
	local playermodel = require("model.playermodel")

	function arg_3_0.payRequestingHandler(arg_4_0, arg_4_1)
		TrackingManager.pay(arg_4_1, DeviceManager.platform, "CNY", var_3_0.rmb)
		addWaitingLayer()
	end

	local var_3_2 = {
		productid = var_3_0.productid,
		playerid = playermodel.playerid
	}

	TrackingManager.order(arg_3_2, "CNY", var_3_0.rmb)
	print("PayInfo: ", tostring(var_3_0.rmb * 100), var_3_0.diamond or 1, arg_3_2, var_3_0.name, var_3_0.des, json.encode(var_3_2), arg_3_3, arg_3_4)
	BiliSDK.pay(playermodel.nickname, tostring(var_3_0.rmb * 100), var_3_0.diamond or 1, arg_3_2, var_3_0.name, var_3_0.des, json.encode(var_3_2), arg_3_3, arg_3_4)
end

return var_0_0
