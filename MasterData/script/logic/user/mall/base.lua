local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = table.insert
local var_0_3 = table.remove
local var_0_5 = gamecore.util_func
local var_0_7 = gameenum.config_data

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.reset_shop_data(arg_2_0)
		arg_2_0._mall_data = {}
		arg_2_0._bathroom_buy_type = 0
		arg_2_0._order_data = {}
	end

	function arg_1_0:get_mall_total_info(arg_3_1)
		return self._mall_data
	end

	function arg_1_0.get_furniture_warehouse_capacity(arg_4_0)
		return var_0_7.init_furniture_limit + var_0_1:get_use_info_data().furniture_extend_limit
	end

	function arg_1_0:add_mall_shop_buy_data(arg_5_1)
		if not var_0_5.get_curr_data_state_by_id(self._mall_data, arg_5_1) then
			var_0_2(self._mall_data, arg_5_1)
		end
	end

	function arg_1_0:update_mall_shop_buy_data(arg_6_1)
		local var_6_0 = 0

		for iter_6_0, iter_6_1 in pairs(self._mall_data) do
			if iter_6_1.id == arg_6_1.id then
				var_6_0 = iter_6_0
			end
		end

		if var_6_0 == 0 then
			var_0_2(self._mall_data, arg_6_1)
		else
			self._mall_data[var_6_0] = arg_6_1
		end
	end

	function arg_1_0:remove_mall_shop_buy_data(arg_7_1)
		local var_7_0 = 0

		for iter_7_0, iter_7_1 in pairs(self._mall_data) do
			if iter_7_1.id == arg_7_1.id then
				var_7_0 = iter_7_0
			end
		end

		if var_7_0 > 0 then
			var_0_3(self._mall_data, var_7_0)
		end
	end

	function arg_1_0.set_bathroom_buy_type(arg_8_0, arg_8_1)
		arg_8_0._bathroom_buy_type = arg_8_1
	end

	function arg_1_0:get_order_data()
		return self._order_data
	end
end

function var_0_0.extend_obj(arg_10_0)
	arg_10_0._mall_data = {}
	arg_10_0._bathroom_buy_type = 0
	arg_10_0._order_data = {}
end

return var_0_0
