local var_0_0 = {}
local var_0_1 = gameenum.battle_type
local var_0_2 = gamecore.battle_util
local var_0_3 = table.insert

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__on_func_add_attr_by_ship_type(arg_2_1, arg_2_2, arg_2_3)
		if arg_2_3 then
			return
		end

		self:__update_ship_attr_by_effect(arg_2_1, false, false, arg_2_2)
	end

	function arg_1_0:__on_func_change_range_by_ship_type(arg_3_1, arg_3_2, arg_3_3)
		if arg_3_3 then
			return
		end

		for iter_3_0, iter_3_1 in pairs((self:__get_ship_hit_state_by_effect(arg_3_1, arg_3_2))) do
			var_0_2:modify_attr_value(self._battle_obj_mgr:findObject(iter_3_1), "range", arg_3_1.num, true)
		end
	end

	function arg_1_0:__on_func_add_damage_by_ship_type(arg_4_1, arg_4_2, arg_4_3)
		if not arg_4_3 then
			return
		end

		local var_4_0 = self:__get_ship_hit_state_by_effect(arg_4_1, arg_4_2)

		if #self:__get_ship_hit_state_by_effect(arg_4_1, arg_4_3) > 0 then
			arg_4_2:get_attribute().change_final_damage = arg_4_1.num / 100
		end
	end

	function arg_1_0:__on_func_minus_be_damage_by_ship_type(arg_5_1, arg_5_2, arg_5_3)
		if not arg_5_3 then
			return
		end

		local var_5_0 = self:__get_ship_hit_state_by_effect(arg_5_1, arg_5_2)

		if #self:__get_ship_hit_state_by_effect(arg_5_1, arg_5_3) > 0 then
			arg_5_2:get_attribute().change_final_damage = -arg_5_1.num / 100
		end
	end

	function arg_1_0:__on_func_add_damage_by_stage(arg_6_1, arg_6_2, arg_6_3)
		if arg_6_3 then
			return
		end

		local var_6_0 = self:__get_ship_hit_state_by_effect(arg_6_1, arg_6_2)
		local var_6_1 = {}

		var_0_3(var_6_1, arg_6_1.num5)
		self._battle_scene:set_hit_rate_enhance_data({
			ship_list = var_6_0,
			stage_list = var_6_1,
			hit_rate = arg_6_1.num / 100
		})
	end

	function arg_1_0:__on_func_minus_be_damage_by_stage(arg_7_1, arg_7_2, arg_7_3)
		if arg_7_3 then
			return
		end

		local var_7_0 = self:__get_ship_hit_state_by_effect(arg_7_1, arg_7_2)
		local var_7_1 = {}

		var_0_3(var_7_1, arg_7_1.num5)
		self._battle_scene:set_hit_rate_reduce_data({
			ship_list = var_7_0,
			stage_list = var_7_1,
			hit_rate = -arg_7_1.num / 100
		})
	end

	function arg_1_0:__on_func_can_fight_in_night_by_shiptypes(arg_8_1, arg_8_2, arg_8_3)
		if arg_8_3 then
			return
		end

		arg_8_1.shipTypes = {
			1,
			2,
			3
		}

		self._battle_scene:set_attend_night_fight_ship({
			ship_list = self:__get_ship_hit_state_by_effect(arg_8_1, arg_8_2)
		})
	end

	function arg_1_0:__on_func_can_fight_in_broke_by_shiptypes(arg_9_1, arg_9_2, arg_9_3)
		if arg_9_3 then
			return
		end

		arg_9_1.shipTypes = {
			1,
			2,
			3,
			18
		}

		self._battle_scene:set_attend_fight_by_broken({
			ship_list = self:__get_ship_hit_state_by_effect(arg_9_1, arg_9_2)
		})
	end

	function arg_1_0:__on_func_can_excute_open_torpedo(arg_10_1, arg_10_2, arg_10_3)
		if arg_10_3 then
			return
		end

		for iter_10_0, iter_10_1 in pairs((self:__get_ship_hit_state_by_effect(arg_10_1, arg_10_2))) do
			self._battle_obj_mgr:findObject(iter_10_1):set_unlock_open_torpedo_attack(true)
		end
	end

	function arg_1_0:__on_func_sure_to_hit_by_shiptype(arg_11_1, arg_11_2, arg_11_3)
		if arg_11_3 then
			return
		end

		for iter_11_0, iter_11_1 in pairs((self:__get_ship_hit_state_by_effect(arg_11_1, arg_11_2))) do
			self._battle_obj_mgr:findObject(iter_11_1):get_attribute().sure_to_hit = true
		end
	end

	function arg_1_0:__get_ship_hit_state_by_effect(arg_12_1, arg_12_2)
		local var_12_0
		local var_12_1
		local var_12_2
		local var_12_3

		for iter_12_0, iter_12_1 in pairs(arg_12_1) do
			if iter_12_0 == "country" then
				var_12_0 = iter_12_1
			elseif iter_12_0 == "shipType" or iter_12_0 == "shipTypes" then
				var_12_1 = iter_12_1
			elseif iter_12_0 == "shipTon" or iter_12_0 == "shipTons" then
				var_12_2 = iter_12_1
			elseif iter_12_0 == "guardType" or iter_12_0 == "guardTypes" then
				var_12_3 = iter_12_1
			end
		end

		local var_12_4 = {}
		local var_12_5 = {}

		table.insert(var_12_5, arg_12_2)

		for iter_12_2, iter_12_3 in pairs(var_12_5) do
			if var_12_0 then
				if self:__get_ship_data_by_countrys(iter_12_3, var_12_0) and self:__get_ship_data_by_screen(iter_12_3, var_12_1, var_12_2, var_12_3) then
					var_0_3(var_12_4, iter_12_3:getID())
				end
			elseif self:__get_ship_data_by_screen(iter_12_3, var_12_1, var_12_2, var_12_3) then
				var_0_3(var_12_4, iter_12_3:getID())
			end
		end

		return var_12_4
	end

	function arg_1_0:__update_ship_attr_by_effect(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
		local var_13_0 = {}

		table.insert(var_13_0, arg_13_4)

		local var_13_1
		local var_13_2
		local var_13_3
		local var_13_4

		for iter_13_0, iter_13_1 in pairs(arg_13_1) do
			if iter_13_0 == "country" then
				var_13_1 = iter_13_1
			elseif iter_13_0 == "shipType" or iter_13_0 == "shipTypes" then
				var_13_2 = iter_13_1
			elseif iter_13_0 == "shipTon" or iter_13_0 == "shipTons" then
				var_13_3 = iter_13_1
			elseif iter_13_0 == "guardType" or iter_13_0 == "guardTypes" then
				var_13_4 = iter_13_1
			end
		end

		local var_13_5 = var_0_1.skil_attribute_type[arg_13_1.num4]
		local var_13_6 = arg_13_1.num

		if arg_13_3 then
			var_13_6 = -var_13_6
		end

		for iter_13_2, iter_13_3 in pairs(var_13_0) do
			if var_13_1 then
				if self:__get_ship_data_by_countrys(iter_13_3, var_13_1) and self:__get_ship_data_by_screen(iter_13_3, var_13_2, var_13_3, var_13_4) then
					var_0_2:update_target_attr(iter_13_3, var_13_5, var_13_6, arg_13_2)
				end
			elseif self:__get_ship_data_by_screen(iter_13_3, var_13_2, var_13_3, var_13_4) then
				var_0_2:update_target_attr(iter_13_3, var_13_5, var_13_6, arg_13_2)
			end

			if var_13_5 == "hp" then
				iter_13_3.now_hp:modify_to_value(iter_13_3.hp:get_final_value())
			end
		end
	end

	function arg_1_0.__number_to_table(arg_14_0, arg_14_1)
		local var_14_0 = {}

		if type(arg_14_1) == "number" then
			var_0_3(var_14_0, arg_14_1)

			return var_14_0
		end

		return arg_14_1
	end

	function arg_1_0:__get_ship_data_by_countrys(arg_15_1, arg_15_2)
		arg_15_2 = self:__number_to_table(arg_15_2)

		for iter_15_0, iter_15_1 in pairs(arg_15_2) do
			if arg_15_1:get_country() == iter_15_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_types(arg_16_1, arg_16_2)
		arg_16_2 = self:__number_to_table(arg_16_2)

		for iter_16_0, iter_16_1 in pairs(arg_16_2) do
			if arg_16_1:get_ship_type() == iter_16_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_tons(arg_17_1, arg_17_2)
		arg_17_2 = self:__number_to_table(arg_17_2)

		for iter_17_0, iter_17_1 in pairs(arg_17_2) do
			if arg_17_1:get_ship_ton() == iter_17_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_guards(arg_18_1, arg_18_2)
		arg_18_2 = self:__number_to_table(arg_18_2)

		for iter_18_0, iter_18_1 in pairs(arg_18_2) do
			if arg_18_1:get_ship_guard_type() == iter_18_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_screen(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
		if arg_19_2 then
			if self:__get_ship_data_by_types(arg_19_1, arg_19_2) then
				return self:__get_target_by_ship_ton(arg_19_1, arg_19_3, arg_19_4)
			end
		elseif arg_19_3 then
			return self:__get_target_by_ship_ton(arg_19_1, arg_19_3, arg_19_4)
		elseif arg_19_4 then
			return self:__get_ship_data_by_guards(arg_19_1, arg_19_4)
		else
			return true
		end
	end

	function arg_1_0:__get_target_by_ship_ton(arg_20_1, arg_20_2, arg_20_3)
		if arg_20_2 then
			if self:__get_ship_data_by_tons(arg_20_1, arg_20_2) then
				return self:__get_target_by_ship_guard(arg_20_1, arg_20_3)
			else
				return false
			end
		else
			return self:__get_target_by_ship_guard(arg_20_1, arg_20_3)
		end
	end

	function arg_1_0:__get_target_by_ship_guard(arg_21_1, arg_21_2)
		if arg_21_2 then
			if self:__get_ship_data_by_guards(arg_21_1, arg_21_2) then
				return true
			else
				return false
			end
		else
			return true
		end
	end
end

function var_0_0.extend_obj(arg_22_0)
	return
end

return var_0_0
