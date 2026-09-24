local var_0_0 = {}
local var_0_1 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_ShopBuyReq(arg_2_0, arg_2_1)
		var_0_1:sendMsg("user.ShopBuyReq", {
			type = arg_2_1.type,
			id = arg_2_1.id
		})
	end

	function arg_1_0.req_MultiShopBuyReq(arg_3_0, arg_3_1)
		var_0_1:sendMsg("user.MultiShopBuyReq", {
			type = arg_3_1.type,
			id = arg_3_1.id,
			num = arg_3_1.count
		})
	end

	function arg_1_0.req_ShopBuyChangeNameCardReq(arg_4_0, arg_4_1)
		var_0_1:sendMsg("user.ShopBuyReq", {
			type = arg_4_1.type,
			id = arg_4_1.id,
			name = arg_4_1.name
		})
	end

	function arg_1_0.req_CreatePayOrderReq(arg_5_0, arg_5_1)
		var_0_1:sendMsg("user.CreatePayOrderReq", {
			goods_id = arg_5_1
		})
	end

	function arg_1_0.req_OrderPayDoneReq(arg_6_0, arg_6_1)
		var_0_1:sendMsg("user.OrderPayDoneReq", {
			order_id = arg_6_1.order_id,
			is_succeed = arg_6_1.is_succeed,
			platform_order_id = arg_6_1.platform_order_id,
			receipt = arg_6_1.receipt
		})
	end

	function arg_1_0.req_VoucherShopBuyReq(arg_7_0, arg_7_1)
		var_0_1:sendMsg("user.VoucherShopBuyReq", {
			shop_id = arg_7_1.shop_id,
			voucher_id = arg_7_1.voucher_id,
			skin_id = arg_7_1.skin_id
		})
	end
end

function var_0_0.extend_obj(arg_8_0)
	return
end

return var_0_0
