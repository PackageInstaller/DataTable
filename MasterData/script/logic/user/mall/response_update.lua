local var_0_0 = {}
local var_0_1 = gamecore.prompt
local var_0_4 = gamecore.UILoader
local var_0_5 = gameenum.common_type
local var_0_6 = gamecore.Language
local var_0_7 = lx.json_decode

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:ShopInfoUpdate(arg_2_1)
		for iter_2_0, iter_2_1 in pairs(arg_2_1.updates) do
			self:__mall__action(iter_2_1.info, iter_2_1.action)
		end
	end

	function arg_1_0:NewPayOrderNotify(arg_3_1)
		self._order_data = arg_3_1.order_data

		if self._order_data and self._order_data.extra_info then
			if type(self._order_data.extra_info) == "string" then
				local var_3_0 = var_0_7(self._order_data.extra_info)
			end
		end
	end

	function arg_1_0.PaySucceedNotify(arg_4_0, arg_4_1)
		var_0_4:createInstance("loading"):show(false)

		if arg_4_1.result == 0 then
			var_0_1:show(var_0_6:getNowLang("shopbuysuccess"))

			local var_4_0 = var_0_4:getInstance("mall_shop")

			if var_4_0 then
				var_4_0:update_user_res_data()
				var_4_0:update_data()
			end
		elseif arg_4_1.result ~= 153 then
			var_0_1:show(var_0_6:getNowLang("errorcode_192"))
		end
	end

	function arg_1_0:__mall__action(arg_5_1, arg_5_2)
		if arg_5_2 == var_0_5.update_modify then
			self:update_mall_shop_buy_data(arg_5_1)
		elseif arg_5_2 == var_0_5.update_add then
			self:add_mall_shop_buy_data(arg_5_1)
		elseif arg_5_2 == var_0_5.update_remove then
			self:remove_mall_shop_buy_data(arg_5_1)
		end
	end
end

function var_0_0.extend_obj(arg_6_0)
	return
end

return var_0_0
