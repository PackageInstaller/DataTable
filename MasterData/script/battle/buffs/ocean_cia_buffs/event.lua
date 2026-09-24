local var_0_0 = {}
local var_0_1 = gameenum.battle_type
local var_0_2 = gamecore.battle_util
local var_0_3 = table.insert

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__on_func_minus_attr_for_all_ship(arg_2_1)
		self:__update_ship_attr_by_effect(arg_2_1, false, true)
	end

	function arg_1_0:__on_func_minus_attr_by_country(arg_3_1)
		self:__update_ship_attr_by_effect(arg_3_1, false, true)
	end

	function arg_1_0:__on_func_minus_attr_by_shiptype(arg_4_1)
		self:__update_ship_attr_by_effect(arg_4_1, false, true)
	end

	function arg_1_0:__on_func_minus_attr_by_flag(arg_5_1)
		var_0_2:update_target_attr(self._battle_obj_mgr:get_flag_ship(var_0_1.obj_side.player), var_0_1.skil_attribute_type[arg_5_1.num4], -arg_5_1.num, false)
	end

	function arg_1_0:__on_func_add_attr_for_all_ship(arg_6_1)
		self:__update_ship_attr_by_effect(arg_6_1, false, false)
	end

	function arg_1_0:__on_func_add_attr_by_country(arg_7_1)
		self:__update_ship_attr_by_effect(arg_7_1, false, false)
	end

	function arg_1_0:__on_func_add_attr_by_shiptype(arg_8_1)
		self:__update_ship_attr_by_effect(arg_8_1, false, false)
	end

	function arg_1_0:__on_func_add_attr_by_flag(arg_9_1)
		var_0_2:update_target_attr(self._battle_obj_mgr:get_flag_ship(var_0_1.obj_side.player), var_0_1.skil_attribute_type[arg_9_1.num4], arg_9_1.num, false)
	end

	function arg_1_0:__get_ship_hit_state_by_effect(arg_10_1)
		local var_10_0
		local var_10_1
		local var_10_2
		local var_10_3

		for iter_10_0, iter_10_1 in pairs(arg_10_1) do
			if iter_10_0 == "country" then
				var_10_0 = iter_10_1
			elseif iter_10_0 == "shipType" or iter_10_0 == "shipTypes" then
				var_10_1 = iter_10_1
			elseif iter_10_0 == "shipTon" or iter_10_0 == "shipTons" then
				var_10_2 = iter_10_1
			elseif iter_10_0 == "guardType" or iter_10_0 == "guardTypes" then
				var_10_3 = iter_10_1
			end
		end

		local var_10_4 = {}

		for iter_10_2, iter_10_3 in pairs((self._battle_obj_mgr:get_ships_by_side(var_0_1.obj_side.player))) do
			if var_10_0 then
				if self:__get_ship_data_by_countrys(iter_10_3, var_10_0) and self:__get_ship_data_by_screen(iter_10_3, var_10_1, var_10_2, var_10_3) then
					var_0_3(var_10_4, iter_10_3:getID())
				end
			elseif self:__get_ship_data_by_screen(iter_10_3, var_10_1, var_10_2, var_10_3) then
				var_0_3(var_10_4, iter_10_3:getID())
			end
		end

		return var_10_4
	end

	function arg_1_0:__update_ship_attr_by_effect(arg_11_1, arg_11_2, arg_11_3)
		local var_11_0
		local var_11_1
		local var_11_2
		local var_11_3

		for iter_11_0, iter_11_1 in pairs(arg_11_1) do
			if iter_11_0 == "country" then
				var_11_0 = iter_11_1
			elseif iter_11_0 == "shipType" or iter_11_0 == "shipTypes" then
				var_11_1 = iter_11_1
			elseif iter_11_0 == "shipTon" or iter_11_0 == "shipTons" then
				var_11_2 = iter_11_1
			elseif iter_11_0 == "guardType" or iter_11_0 == "guardTypes" then
				var_11_3 = iter_11_1
			end
		end

		local var_11_4 = arg_11_1.num

		if arg_11_3 then
			var_11_4 = -var_11_4
		end

		for iter_11_2, iter_11_3 in pairs((self._battle_obj_mgr:get_ships_by_side(var_0_1.obj_side.player))) do
			if var_11_0 then
				if self:__get_ship_data_by_countrys(iter_11_3, var_11_0) and self:__get_ship_data_by_screen(iter_11_3, var_11_1, var_11_2, var_11_3) then
					var_0_2:update_target_attr(iter_11_3, var_0_1.skil_attribute_type[arg_11_1.num4], var_11_4, arg_11_2)
				end
			elseif self:__get_ship_data_by_screen(iter_11_3, var_11_1, var_11_2, var_11_3) then
				var_0_2:update_target_attr(iter_11_3, var_0_1.skil_attribute_type[arg_11_1.num4], var_11_4, arg_11_2)
			end
		end
	end

	function arg_1_0.__number_to_table(arg_12_0, arg_12_1)
		local var_12_0 = {}

		if type(arg_12_1) == "number" then
			var_0_3(var_12_0, arg_12_1)

			return var_12_0
		end

		return arg_12_1
	end

	function arg_1_0:__get_ship_data_by_countrys(arg_13_1, arg_13_2)
		arg_13_2 = self:__number_to_table(arg_13_2)

		for iter_13_0, iter_13_1 in pairs(arg_13_2) do
			if arg_13_1:get_country() == iter_13_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_types(arg_14_1, arg_14_2)
		arg_14_2 = self:__number_to_table(arg_14_2)

		for iter_14_0, iter_14_1 in pairs(arg_14_2) do
			if arg_14_1:get_ship_type() == iter_14_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_tons(arg_15_1, arg_15_2)
		arg_15_2 = self:__number_to_table(arg_15_2)

		for iter_15_0, iter_15_1 in pairs(arg_15_2) do
			if arg_15_1:get_ship_ton() == iter_15_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_guards(arg_16_1, arg_16_2)
		arg_16_2 = self:__number_to_table(arg_16_2)

		for iter_16_0, iter_16_1 in pairs(arg_16_2) do
			if arg_16_1:get_ship_guard_type() == iter_16_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_screen(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
		if arg_17_2 then
			if self:__get_ship_data_by_types(arg_17_1, arg_17_2) then
				return self:__get_target_by_ship_ton(arg_17_1, arg_17_3, arg_17_4)
			end
		elseif arg_17_3 then
			return self:__get_target_by_ship_ton(arg_17_1, arg_17_3, arg_17_4)
		elseif arg_17_4 then
			return self:__get_ship_data_by_guards(arg_17_1, arg_17_4)
		else
			return true
		end
	end

	function arg_1_0:__get_target_by_ship_ton(arg_18_1, arg_18_2, arg_18_3)
		if arg_18_2 then
			if self:__get_ship_data_by_tons(arg_18_1, arg_18_2) then
				return self:__get_target_by_ship_guard(arg_18_1, arg_18_3)
			else
				return false
			end
		else
			return self:__get_target_by_ship_guard(arg_18_1, arg_18_3)
		end
	end

	function arg_1_0:__get_target_by_ship_guard(arg_19_1, arg_19_2)
		if arg_19_2 then
			if self:__get_ship_data_by_guards(arg_19_1, arg_19_2) then
				return true
			else
				return false
			end
		else
			return true
		end
	end
end

function var_0_0.extend_obj(arg_20_0)
	return
end

return var_0_0
