local var_0_0 = {}
local var_0_1 = gameenum.battle_type
local var_0_2 = gamecore.battle_util
local var_0_3 = table.insert

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__on_func_add_attr_for_all_ship(arg_2_1, arg_2_2, arg_2_3)
		self:__update_ship_attr_by_effect(arg_2_1, arg_2_2, false, false)

		for iter_2_0, iter_2_1 in pairs((self:__get_ship_hit_state_by_effect(arg_2_1, arg_2_2))) do
			self._battle_obj_mgr:findObject(iter_2_1).change_attr_by_solld_strike_buff = {
				[var_0_1.skil_attribute_type[arg_2_1.num4]] = arg_2_1.num
			}
		end
	end

	function arg_1_0:__on_func_minus_attr_for_all_ship(arg_3_1, arg_3_2, arg_3_3)
		self:__update_ship_attr_by_effect(arg_3_1, arg_3_2, false, true)

		for iter_3_0, iter_3_1 in pairs((self:__get_ship_hit_state_by_effect(arg_3_1, arg_3_2))) do
			self._battle_obj_mgr:findObject(iter_3_1).change_attr_by_solld_strike_buff = {
				[var_0_1.skil_attribute_type[arg_3_1.num4]] = -arg_3_1.num
			}
		end
	end

	function arg_1_0:__on_func_add_attr_by_shiptype(arg_4_1, arg_4_2, arg_4_3)
		self:__update_ship_attr_by_effect(arg_4_1, arg_4_2, false, false)
	end

	function arg_1_0:__on_func_minus_attr_by_shiptype(arg_5_1, arg_5_2, arg_5_3)
		self:__update_ship_attr_by_effect(arg_5_1, arg_5_2, false, true)
	end

	function arg_1_0:__on_func_add_attr_by_country(arg_6_1, arg_6_2, arg_6_3)
		self:__update_ship_attr_by_effect(arg_6_1, arg_6_2, false, false)
	end

	function arg_1_0:__on_func_minus_attr_by_country(arg_7_1, arg_7_2, arg_7_3)
		self:__update_ship_attr_by_effect(arg_7_1, arg_7_2, false, true)
	end

	function arg_1_0:__on_func_can_not_be_effect(arg_8_1, arg_8_2, arg_8_3)
		for iter_8_0, iter_8_1 in pairs((self:__get_ship_hit_state_by_effect(arg_8_1, arg_8_2))) do
			local var_8_0 = self._battle_obj_mgr:findObject(iter_8_1)

			if var_8_0.change_attr_by_solld_strike_buff then
				for iter_8_2, iter_8_3 in pairs(var_8_0.change_attr_by_solld_strike_buff) do
					var_8_0:get_attribute()[iter_8_2]:modify_to_value(var_8_0:get_attribute()[iter_8_2]:get_final_value() - iter_8_3)
				end
			end
		end
	end

	function arg_1_0:__get_ship_hit_state_by_effect(arg_9_1, arg_9_2)
		local var_9_0
		local var_9_1
		local var_9_2
		local var_9_3

		for iter_9_0, iter_9_1 in pairs(arg_9_1) do
			if iter_9_0 == "country" then
				var_9_0 = iter_9_1
			elseif iter_9_0 == "shipType" or iter_9_0 == "shipTypes" then
				var_9_1 = iter_9_1
			elseif iter_9_0 == "shipTon" or iter_9_0 == "shipTons" then
				var_9_2 = iter_9_1
			elseif iter_9_0 == "guardType" or iter_9_0 == "guardTypes" then
				var_9_3 = iter_9_1
			end
		end

		local var_9_4 = {}
		local var_9_5 = {}

		table.insert(var_9_5, arg_9_2)

		for iter_9_2, iter_9_3 in pairs(var_9_5) do
			if var_9_0 then
				if self:__get_ship_data_by_countrys(iter_9_3, var_9_0) and self:__get_ship_data_by_screen(iter_9_3, var_9_1, var_9_2, var_9_3) then
					var_0_3(var_9_4, iter_9_3:getID())
				end
			elseif self:__get_ship_data_by_screen(iter_9_3, var_9_1, var_9_2, var_9_3) then
				var_0_3(var_9_4, iter_9_3:getID())
			end
		end

		return var_9_4
	end

	function arg_1_0:__update_ship_attr_by_effect(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
		local var_10_0 = {}

		table.insert(var_10_0, arg_10_2)

		local var_10_1
		local var_10_2
		local var_10_3
		local var_10_4

		for iter_10_0, iter_10_1 in pairs(arg_10_1) do
			if iter_10_0 == "country" then
				var_10_1 = iter_10_1
			elseif iter_10_0 == "shipType" or iter_10_0 == "shipTypes" then
				var_10_2 = iter_10_1
			elseif iter_10_0 == "shipTon" or iter_10_0 == "shipTons" then
				var_10_3 = iter_10_1
			elseif iter_10_0 == "guardType" or iter_10_0 == "guardTypes" then
				var_10_4 = iter_10_1
			end
		end

		local var_10_5 = arg_10_1.num

		if arg_10_4 then
			var_10_5 = -var_10_5
		end

		for iter_10_2, iter_10_3 in pairs(var_10_0) do
			if var_10_1 then
				if self:__get_ship_data_by_countrys(iter_10_3, var_10_1) and self:__get_ship_data_by_screen(iter_10_3, var_10_2, var_10_3, var_10_4) then
					var_0_2:update_target_attr(iter_10_3, var_0_1.skil_attribute_type[arg_10_1.num4], var_10_5, arg_10_3)
				end
			elseif self:__get_ship_data_by_screen(iter_10_3, var_10_2, var_10_3, var_10_4) then
				var_0_2:update_target_attr(iter_10_3, var_0_1.skil_attribute_type[arg_10_1.num4], var_10_5, arg_10_3)
			end
		end
	end

	function arg_1_0.__number_to_table(arg_11_0, arg_11_1)
		local var_11_0 = {}

		if type(arg_11_1) == "number" then
			var_0_3(var_11_0, arg_11_1)

			return var_11_0
		end

		return arg_11_1
	end

	function arg_1_0:__get_ship_data_by_countrys(arg_12_1, arg_12_2)
		arg_12_2 = self:__number_to_table(arg_12_2)

		for iter_12_0, iter_12_1 in pairs(arg_12_2) do
			if arg_12_1:get_country() == iter_12_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_types(arg_13_1, arg_13_2)
		arg_13_2 = self:__number_to_table(arg_13_2)

		for iter_13_0, iter_13_1 in pairs(arg_13_2) do
			if arg_13_1:get_ship_type() == iter_13_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_tons(arg_14_1, arg_14_2)
		arg_14_2 = self:__number_to_table(arg_14_2)

		for iter_14_0, iter_14_1 in pairs(arg_14_2) do
			if arg_14_1:get_ship_ton() == iter_14_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_guards(arg_15_1, arg_15_2)
		arg_15_2 = self:__number_to_table(arg_15_2)

		for iter_15_0, iter_15_1 in pairs(arg_15_2) do
			if arg_15_1:get_ship_guard_type() == iter_15_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_screen(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
		if arg_16_2 then
			if self:__get_ship_data_by_types(arg_16_1, arg_16_2) then
				return self:__get_target_by_ship_ton(arg_16_1, arg_16_3, arg_16_4)
			end
		elseif arg_16_3 then
			return self:__get_target_by_ship_ton(arg_16_1, arg_16_3, arg_16_4)
		elseif arg_16_4 then
			return self:__get_ship_data_by_guards(arg_16_1, arg_16_4)
		else
			return true
		end
	end

	function arg_1_0:__get_target_by_ship_ton(arg_17_1, arg_17_2, arg_17_3)
		if arg_17_2 then
			if self:__get_ship_data_by_tons(arg_17_1, arg_17_2) then
				return self:__get_target_by_ship_guard(arg_17_1, arg_17_3)
			else
				return false
			end
		else
			return self:__get_target_by_ship_guard(arg_17_1, arg_17_3)
		end
	end

	function arg_1_0:__get_target_by_ship_guard(arg_18_1, arg_18_2)
		if arg_18_2 then
			if self:__get_ship_data_by_guards(arg_18_1, arg_18_2) then
				return true
			else
				return false
			end
		else
			return true
		end
	end
end

function var_0_0.extend_obj(arg_19_0)
	return
end

return var_0_0
