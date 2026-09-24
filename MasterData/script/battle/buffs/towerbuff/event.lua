local var_0_0 = {}
local var_0_2 = table.insert
local var_0_3 = gameenum.battle_type
local var_0_4 = gamecore.battle_util

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.__on_func_player_user_cost(arg_2_0, arg_2_1)
		return
	end

	function arg_1_0:__on_func_excute_open_torpedo(arg_3_1, arg_3_2)
		for iter_3_0, iter_3_1 in pairs((self:__get_ship_hit_state_by_effect(arg_3_1, arg_3_2))) do
			self._battle_obj_mgr:findObject(iter_3_1):set_unlock_open_torpedo_attack(true)
		end
	end

	function arg_1_0:__on_func_kill_target_immediate(arg_4_1, arg_4_2)
		local var_4_0 = {}

		for iter_4_0, iter_4_1 in pairs((self._battle_obj_mgr:get_ships_by_side(var_0_3.obj_side.player))) do
			table.insert(var_4_0, self:__get_ship_hit_state_by_effect(arg_4_1, iter_4_1)[1])
		end

		self._battle_scene:set_kill_target_immediate_data({
			ship_list = var_4_0,
			rate = arg_4_1.num
		})
	end

	function arg_1_0:__on_func_priority_attack(arg_5_1, arg_5_2)
		for iter_5_0, iter_5_1 in pairs((self:__get_ship_hit_state_by_effect(arg_5_1, arg_5_2))) do
			self._battle_obj_mgr:findObject(iter_5_1):get_attribute().first_hit_by_type = {
				shit_type = "shipTypes",
				num = arg_5_1.shipType1s
			}
		end
	end

	function arg_1_0:__on_func_attack_infallible(arg_6_1, arg_6_2)
		local var_6_0 = {}

		for iter_6_0, iter_6_1 in pairs((self._battle_obj_mgr:get_ships_by_side(var_0_3.obj_side.player))) do
			table.insert(var_6_0, self:__get_ship_hit_state_by_effect(arg_6_1, iter_6_1)[1])
		end

		self._battle_scene:set_attack_infallible_data({
			ship_list = var_6_0,
			crit_hurt = arg_6_1.num
		})
	end

	function arg_1_0:__on_func_aircraft_attr_enhance(arg_7_1, arg_7_2)
		for iter_7_0, iter_7_1 in pairs((self:__get_ship_hit_state_by_effect(arg_7_1, arg_7_2))) do
			local var_7_0 = self._battle_obj_mgr:findObject(iter_7_1)
			local var_7_1 = var_7_0:get_attribute().air_def
			local var_7_2 = var_7_1:get_final_value() * arg_7_1.num
			local var_7_3 = var_7_0:get_attribute().atk
			local var_7_4 = var_7_0:get_attribute().miss.get_final_value(var_7_1)

			var_7_0:get_attribute().atk:modify_to_value(var_7_3:get_final_value() + var_7_2)
			var_7_0:get_attribute().miss:modify_to_value(var_7_4 + var_7_2)
		end
	end

	function arg_1_0:__on_func_hit_reset_zero(arg_8_1, arg_8_2)
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in pairs((self._battle_obj_mgr:get_ships_by_side(var_0_3.obj_side.player))) do
			table.insert(var_8_0, self:__get_ship_hit_state_by_effect(arg_8_1, iter_8_1)[1])
		end

		self._battle_scene:set_hit_reset_zero_data({
			ship_list = var_8_0,
			num = arg_8_1.num
		})
	end

	function arg_1_0:__on_func_evade_hit(arg_9_1, arg_9_2)
		local var_9_0 = {}

		for iter_9_0, iter_9_1 in pairs((self._battle_obj_mgr:get_ships_by_side(var_0_3.obj_side.player))) do
			table.insert(var_9_0, self:__get_ship_hit_state_by_effect(arg_9_1, iter_9_1)[1])
		end

		self._battle_scene:set_evade_hit_data(arg_9_1)
	end

	function arg_1_0:__on_func_ship_range_limit(arg_10_1, arg_10_2)
		local var_10_0 = {}

		for iter_10_0, iter_10_1 in pairs((self._battle_obj_mgr:get_ships_by_side(var_0_3.obj_side.player))) do
			table.insert(var_10_0, self:__get_ship_hit_state_by_effect(arg_10_1, iter_10_1)[1])
		end

		self._battle_scene:set_ship_range_limit_data({
			stage_list = 5,
			ship_list = var_10_0,
			num = arg_10_1.num
		})
	end

	function arg_1_0:__on_func_first_hit_to_miss(arg_11_1, arg_11_2)
		for iter_11_0, iter_11_1 in pairs((self:__get_ship_hit_state_by_effect(arg_11_1, arg_11_2))) do
			self._battle_obj_mgr:findObject(iter_11_1):set_immune_to_first_damage_state(true)
		end
	end

	function arg_1_0:__on_func_any_formation_can_antisub(arg_12_1, arg_12_2)
		local var_12_0 = {}

		for iter_12_0, iter_12_1 in pairs((self._battle_obj_mgr:get_ships_by_side(var_0_3.obj_side.player))) do
			table.insert(var_12_0, self:__get_ship_hit_state_by_effect(arg_12_1, iter_12_1)[1])
		end

		for iter_12_2, iter_12_3 in pairs((self:__get_ship_hit_state_by_effect(arg_12_1, arg_12_2))) do
			var_0_4:update_target_attr(self._battle_obj_mgr:findObject(iter_12_3), var_0_3.tower_attribute_type[arg_12_1.num4], arg_12_1.num)
		end

		self._battle_scene:set_open_antisub({
			ship_list = var_12_0
		})
	end

	function arg_1_0:__on_func_ignore_armor_in_normal_attack(arg_13_1, arg_13_2)
		self._battle_scene:set_ignore_armor(arg_13_1)
	end

	function arg_1_0:__on_func_our_add_atk(arg_14_1, arg_14_2)
		local var_14_0 = false

		for iter_14_0, iter_14_1 in pairs((self._battle_obj_mgr:get_ships_by_side(var_0_3.obj_side.player))) do
			if var_0_4:judge_ship(iter_14_1, arg_14_1) then
				var_14_0 = true

				break
			end
		end

		if var_14_0 and arg_14_2:get_ship_speed() <= arg_14_1.num then
			var_0_4:modify_attr_value(arg_14_2, "atk", arg_14_1.num4)
		end
	end

	function arg_1_0:__on_func_special_atk_as_zero(arg_15_1)
		self._battle_scene:set_special_atk_as_zero(arg_15_1)
	end

	function arg_1_0:__on_func_rate_of_ignore_armor(arg_16_1)
		self._battle_scene:set_rate_of_ignore_armor(arg_16_1)
	end

	function arg_1_0:__on_func_add_extra_damage(arg_17_1)
		self._battle_scene:set_add_extra_damage(arg_17_1)
	end

	function arg_1_0:__on_func_change_formation(arg_18_1, arg_18_2)
		local var_18_0 = false

		for iter_18_0, iter_18_1 in pairs((self._battle_obj_mgr:get_ships_by_side(var_0_3.obj_side.player))) do
			if var_0_4:judge_ship(iter_18_1, arg_18_1) then
				var_18_0 = true

				break
			end
		end

		if var_18_0 then
			self._battle_scene:set_fix_player_course(true)
		end
	end

	function arg_1_0:__on_func_ignore_armor_in_open_torpedo_attack(arg_19_1, arg_19_2)
		self._battle_scene:set_ignore_armor_in_open_torpedo_attack(arg_19_1)
	end

	function arg_1_0:__on_func_reduce_damage(arg_20_1, arg_20_2)
		self._battle_scene:set_reduce_damage_with_special_enemy(arg_20_1)
	end

	function arg_1_0.__on_func_change_range(arg_21_0, arg_21_1, arg_21_2)
		if var_0_4:judge_ship(arg_21_2, arg_21_1) then
			var_0_4:modify_attr_value(arg_21_2, "range", arg_21_1.num, true)
		end
	end

	function arg_1_0:__on_func_hit_rate_enhance(arg_22_1, arg_22_2)
		local var_22_0 = {}

		for iter_22_0, iter_22_1 in pairs((self._battle_obj_mgr:get_ships_by_side(var_0_3.obj_side.player))) do
			table.insert(var_22_0, self:__get_ship_hit_state_by_effect(arg_22_1, iter_22_1)[1])
		end

		self._battle_scene:set_hit_rate_enhance_data({
			ship_list = var_22_0,
			stage_list = arg_22_1.num4,
			hit_rate = arg_22_1.num
		})
	end

	function arg_1_0:__on_func_attend_night_fight(arg_23_1, arg_23_2)
		local var_23_0 = {}

		for iter_23_0, iter_23_1 in pairs((self._battle_obj_mgr:get_ships_by_side(var_0_3.obj_side.player))) do
			table.insert(var_23_0, self:__get_ship_hit_state_by_effect(arg_23_1, iter_23_1)[1])
		end

		self._battle_scene:set_attend_night_fight_ship({
			ship_list = var_23_0
		})
	end

	function arg_1_0:__on_func_attend_fight_by_broken(arg_24_1, arg_24_2)
		local var_24_0 = {}

		for iter_24_0, iter_24_1 in pairs((self._battle_obj_mgr:get_ships_by_side(var_0_3.obj_side.player))) do
			table.insert(var_24_0, self:__get_ship_hit_state_by_effect(arg_24_1, iter_24_1)[1])
		end

		self._battle_scene:set_attend_fight_by_broken({
			ship_list = var_24_0
		})
	end

	function arg_1_0:__on_func_ship_other_attr_enhance(arg_25_1, arg_25_2)
		self:__update_ship_attr_by_effect(arg_25_1, false, false, arg_25_2)
	end

	function arg_1_0:__on_func_hit_rate_reduce(arg_26_1, arg_26_2)
		local var_26_0 = {}

		for iter_26_0, iter_26_1 in pairs((self._battle_obj_mgr:get_ships_by_side(var_0_3.obj_side.player))) do
			table.insert(var_26_0, self:__get_ship_hit_state_by_effect(arg_26_1, iter_26_1)[1])
		end

		self._battle_scene:set_hit_rate_reduce_data({
			ship_list = var_26_0,
			stage_list = arg_26_1.num4,
			hit_rate = -arg_26_1.num
		})
	end

	function arg_1_0:__on_func_ship_attr_enhance(arg_27_1, arg_27_2)
		self:__update_ship_attr_by_effect(arg_27_1, false, false, arg_27_2)
	end

	function arg_1_0:__on_func_enemy_hit_reduce(arg_28_1)
		local var_28_0 = {}

		for iter_28_0, iter_28_1 in pairs((self._battle_obj_mgr:get_ships_by_side(var_0_3.obj_side.player))) do
			table.insert(var_28_0, self:__get_ship_hit_state_by_effect(arg_28_1, iter_28_1)[1])
		end

		self._battle_scene:set_enemy_attack_hit_reduce_data({
			ship_list = var_28_0,
			enemy_ship_type = arg_28_1.shipType1s,
			hit_rate = -arg_28_1.num
		})
	end

	function arg_1_0.__on_func_all_ship_attr_enhance(arg_29_0, arg_29_1, arg_29_2)
		var_0_4:update_target_attr(arg_29_2, var_0_3.skil_attribute_type[arg_29_1.num4], arg_29_1.num, false)
	end

	function arg_1_0:__on_func_all_ship_hit_rate_reduce(arg_30_1, arg_30_2)
		self._battle_scene:set_team_reduce_hit_data({
			stage_list = arg_30_1.num4,
			hit_rate = -arg_30_1.num
		})
	end

	function arg_1_0:__on_func_team_hit_rate_reduce(arg_31_1, arg_31_2)
		self._battle_scene:set_team_all_reduce_hit_data({
			hit_rate = -arg_31_1.num
		})
	end

	function arg_1_0:__on_func_add_attr_by_ship_number(arg_32_1, arg_32_2)
		local var_32_0 = 0
		local var_32_1 = {}

		for iter_32_0, iter_32_1 in pairs((self._battle_obj_mgr:get_ships_by_side(var_0_3.obj_side.player))) do
			for iter_32_2, iter_32_3 in pairs(arg_32_1.shipType) do
				if iter_32_1:get_ship_type() == iter_32_3 then
					var_32_0 = var_32_0 + 1
				end
			end

			for iter_32_4, iter_32_5 in pairs(arg_32_1.shipType1s) do
				if iter_32_1:get_ship_type() == iter_32_5 then
					table.insert(var_32_1, iter_32_1:getID())
				end
			end
		end

		self._battle_scene:set_add_attr_by_ship_number_data({
			attr_type = var_0_3.skil_attribute_type[arg_32_1.num4],
			num = arg_32_1.num * var_32_0,
			ship_list = var_32_1
		})
	end

	function arg_1_0:__on_func_sure_to_crit_by_ship_type_by_stage(arg_33_1, arg_33_2)
		for iter_33_0, iter_33_1 in pairs((self:__get_ship_hit_state_by_effect(arg_33_1, arg_33_2))) do
			self._battle_obj_mgr:findObject(iter_33_1):get_attribute().sure_to_crit_by_stage = arg_33_1.num4
		end
	end

	function arg_1_0:__on_func_hit_rate_reduce_by_ship_type(arg_34_1, arg_34_2)
		self._battle_scene:set_reduce_damage_by_ship_type(arg_34_1)
	end

	function arg_1_0:__on_func_one_more_attack_in_kill_ship(arg_35_1, arg_35_2)
		for iter_35_0, iter_35_1 in pairs((self:__get_ship_hit_state_by_effect(arg_35_1, arg_35_2))) do
			self._battle_obj_mgr:findObject(iter_35_1):get_attribute().one_more_attack_in_kill_ship = true
		end
	end

	function arg_1_0:__on_func_back_attack(arg_36_1, arg_36_2)
		for iter_36_0, iter_36_1 in pairs((self:__get_ship_hit_state_by_effect(arg_36_1, arg_36_2))) do
			self._battle_obj_mgr:findObject(iter_36_1):set_num_of_beat_back(99, arg_36_1.hurt_rate or 0)
		end
	end

	function arg_1_0:__on_func_back_attack_wihtout_hurt(arg_37_1, arg_37_2)
		for iter_37_0, iter_37_1 in pairs((self:__get_ship_hit_state_by_effect(arg_37_1, arg_37_2))) do
			self._battle_obj_mgr:findObject(iter_37_1):set_num_of_beat_back_wihtout_hp_state()
		end
	end

	function arg_1_0:__on_func_add_attr_by_have_ship_type(arg_38_1, arg_38_2)
		local var_38_0 = false

		for iter_38_0, iter_38_1 in pairs((self._battle_obj_mgr:get_ships_by_side(var_0_3.obj_side.player))) do
			if var_0_4:judge_ship(iter_38_1, arg_38_1) then
				var_38_0 = true

				break
			end
		end

		if var_38_0 then
			var_0_4:modify_attr_value(arg_38_2, "atk", arg_38_1.num)
		end
	end

	function arg_1_0:__on_func_minus_attr_for_all_ship(arg_39_1, arg_39_2)
		self:__update_ship_attr_by_effect(arg_39_1, false, true, arg_39_2)
	end

	function arg_1_0:__on_func_minus_attr_by_country(arg_40_1, arg_40_2)
		self:__update_ship_attr_by_effect(arg_40_1, false, true, arg_40_2)
	end

	function arg_1_0:__on_func_minus_attr_by_shiptype(arg_41_1, arg_41_2)
		self:__update_ship_attr_by_effect(arg_41_1, false, true, arg_41_2)
	end

	function arg_1_0.__on_func_minus_attr_by_flag(arg_42_0, arg_42_1, arg_42_2)
		if arg_42_2:is_flag() then
			var_0_4:update_target_attr(arg_42_2, var_0_3.skil_attribute_type[arg_42_1.num4], -arg_42_1.num, false)
		end
	end

	function arg_1_0:__on_func_add_attr_for_all_ship(arg_43_1, arg_43_2)
		self:__update_ship_attr_by_effect(arg_43_1, false, false, arg_43_2)
	end

	function arg_1_0:__on_func_add_attr_by_country(arg_44_1, arg_44_2)
		self:__update_ship_attr_by_effect(arg_44_1, false, false, arg_44_2)
	end

	function arg_1_0:__on_func_add_attr_by_shiptype(arg_45_1, arg_45_2)
		self:__update_ship_attr_by_effect(arg_45_1, false, false, arg_45_2)
	end

	function arg_1_0.__on_func_add_attr_by_flag(arg_46_0, arg_46_1, arg_46_2)
		if arg_46_2:is_flag() then
			var_0_4:update_target_attr(arg_46_2, var_0_3.skil_attribute_type[arg_46_1.num4], arg_46_1.num, false)
		end
	end

	function arg_1_0:__get_ship_hit_state_by_effect(arg_47_1, arg_47_2)
		local var_47_0
		local var_47_1
		local var_47_2
		local var_47_3

		for iter_47_0, iter_47_1 in pairs(arg_47_1) do
			if iter_47_0 == "country" then
				var_47_0 = iter_47_1
			elseif iter_47_0 == "shipType" or iter_47_0 == "shipTypes" then
				var_47_1 = iter_47_1
			elseif iter_47_0 == "shipTon" or iter_47_0 == "shipTons" then
				var_47_2 = iter_47_1
			elseif iter_47_0 == "guardType" or iter_47_0 == "guardTypes" then
				var_47_3 = iter_47_1
			end
		end

		local var_47_4 = {}
		local var_47_5 = {}

		table.insert(var_47_5, arg_47_2)

		for iter_47_2, iter_47_3 in pairs(var_47_5) do
			if var_47_0 then
				if self:__get_ship_data_by_countrys(iter_47_3, var_47_0) and self:__get_ship_data_by_screen(iter_47_3, var_47_1, var_47_2, var_47_3) then
					var_0_2(var_47_4, iter_47_3:getID())
				end
			elseif self:__get_ship_data_by_screen(iter_47_3, var_47_1, var_47_2, var_47_3) then
				var_0_2(var_47_4, iter_47_3:getID())
			end
		end

		return var_47_4
	end

	function arg_1_0:__update_ship_attr_by_effect(arg_48_1, arg_48_2, arg_48_3, arg_48_4)
		local var_48_0 = {}

		table.insert(var_48_0, arg_48_4)

		local var_48_1
		local var_48_2
		local var_48_3
		local var_48_4

		for iter_48_0, iter_48_1 in pairs(arg_48_1) do
			if iter_48_0 == "country" then
				var_48_1 = iter_48_1
			elseif iter_48_0 == "shipType" or iter_48_0 == "shipTypes" then
				var_48_2 = iter_48_1
			elseif iter_48_0 == "shipTon" or iter_48_0 == "shipTons" then
				var_48_3 = iter_48_1
			elseif iter_48_0 == "guardType" or iter_48_0 == "guardTypes" then
				var_48_4 = iter_48_1
			end
		end

		local var_48_5 = arg_48_1.num

		if arg_48_3 then
			var_48_5 = -var_48_5
		end

		for iter_48_2, iter_48_3 in pairs(var_48_0) do
			if var_48_1 then
				if self:__get_ship_data_by_countrys(iter_48_3, var_48_1) and self:__get_ship_data_by_screen(iter_48_3, var_48_2, var_48_3, var_48_4) then
					var_0_4:update_target_attr(iter_48_3, var_0_3.skil_attribute_type[arg_48_1.num4], var_48_5, arg_48_2)
				end
			elseif self:__get_ship_data_by_screen(iter_48_3, var_48_2, var_48_3, var_48_4) then
				var_0_4:update_target_attr(iter_48_3, var_0_3.skil_attribute_type[arg_48_1.num4], var_48_5, arg_48_2)
			end
		end
	end

	function arg_1_0.__number_to_table(arg_49_0, arg_49_1)
		local var_49_0 = {}

		if type(arg_49_1) == "number" then
			var_0_2(var_49_0, arg_49_1)

			return var_49_0
		end

		return arg_49_1
	end

	function arg_1_0:__get_ship_data_by_countrys(arg_50_1, arg_50_2)
		arg_50_2 = self:__number_to_table(arg_50_2)

		for iter_50_0, iter_50_1 in pairs(arg_50_2) do
			if arg_50_1:get_country() == iter_50_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_types(arg_51_1, arg_51_2)
		arg_51_2 = self:__number_to_table(arg_51_2)

		for iter_51_0, iter_51_1 in pairs(arg_51_2) do
			if arg_51_1:get_ship_type() == iter_51_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_tons(arg_52_1, arg_52_2)
		arg_52_2 = self:__number_to_table(arg_52_2)

		for iter_52_0, iter_52_1 in pairs(arg_52_2) do
			if arg_52_1:get_ship_ton() == iter_52_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_guards(arg_53_1, arg_53_2)
		arg_53_2 = self:__number_to_table(arg_53_2)

		for iter_53_0, iter_53_1 in pairs(arg_53_2) do
			if arg_53_1:get_ship_guard_type() == iter_53_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_screen(arg_54_1, arg_54_2, arg_54_3, arg_54_4)
		if arg_54_2 then
			if self:__get_ship_data_by_types(arg_54_1, arg_54_2) then
				return self:__get_target_by_ship_ton(arg_54_1, arg_54_3, arg_54_4)
			end
		elseif arg_54_3 then
			return self:__get_target_by_ship_ton(arg_54_1, arg_54_3, arg_54_4)
		elseif arg_54_4 then
			return self:__get_ship_data_by_guards(arg_54_1, arg_54_4)
		else
			return true
		end
	end

	function arg_1_0:__get_target_by_ship_ton(arg_55_1, arg_55_2, arg_55_3)
		if arg_55_2 then
			if self:__get_ship_data_by_tons(arg_55_1, arg_55_2) then
				return self:__get_target_by_ship_guard(arg_55_1, arg_55_3)
			else
				return false
			end
		else
			return self:__get_target_by_ship_guard(arg_55_1, arg_55_3)
		end
	end

	function arg_1_0:__get_target_by_ship_guard(arg_56_1, arg_56_2)
		if arg_56_2 then
			if self:__get_ship_data_by_guards(arg_56_1, arg_56_2) then
				return true
			else
				return false
			end
		else
			return true
		end
	end
end

function var_0_0.extend_obj(arg_57_0)
	return
end

return var_0_0
