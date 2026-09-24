local var_0_0 = {}
local var_0_1 = gameenum.battle_type
local var_0_2 = gamecore.battle_util
local var_0_3 = gameconfig.map_node_config
local var_0_4 = gameconfig.abyss_map_node_config
local var_0_5 = gameconfig.pve_active_map_node_config
local var_0_6 = gameconfig.ocean_map_node_config
local var_0_7 = gameconfig.fifth_map_node_config
local var_0_8 = gameconfig.map_config
local var_0_9 = gameconfig.pve_active_map_config
local var_0_10 = gameconfig.pve_mix_level_node_config
local var_0_11 = gameconfig.score_map_node_config
local var_0_12 = gameconfig.pve_ninth_level_node_config
local var_0_13 = table.insert
local var_0_14 = gameconfig.ship_config
local var_0_15 = gameconfig.skill_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onConditionFunc_take_attack(arg_2_1, arg_2_2)
		local var_2_0 = true

		for iter_2_0, iter_2_1 in pairs(arg_2_2.cond) do
			local var_2_1 = string.format("__onConditionFunc_%s", (var_0_1:get_condition_type(iter_2_1.type)))

			if self[var_2_1] and not self[var_2_1](self, arg_2_1, iter_2_1) then
				var_2_0 = false
			end
		end

		return var_2_0
	end

	function arg_1_0.__onConditionFunc_take_damage(arg_3_0, arg_3_1, arg_3_2)
		return true
	end

	function arg_1_0.__onConditionFunc_more_than_hp_damage(arg_4_0, arg_4_1, arg_4_2)
		return true
	end

	function arg_1_0.__onConditionFunc_after_take_attack(arg_5_0, arg_5_1, arg_5_2)
		return true
	end

	function arg_1_0.__onConditionFunc_take_attack_not_less_than_some_attribute(arg_6_0, arg_6_1, arg_6_2)
		return true
	end

	function arg_1_0.__onConditionFunc_attack(arg_7_0, arg_7_1, arg_7_2)
		return true
	end

	function arg_1_0.__onConditionFunc_after_attack(arg_8_0, arg_8_1, arg_8_2)
		return true
	end

	function arg_1_0.__onConditionFunc_attack_crit(arg_9_0, arg_9_1, arg_9_2)
		return true
	end

	function arg_1_0.__onConditionFunc_attack_not_crit(arg_10_0, arg_10_1, arg_10_2)
		return true
	end

	function arg_1_0.__onConditionFunc_attack_not_more_than_some_attribute(arg_11_0, arg_11_1, arg_11_2)
		return true
	end

	function arg_1_0.__onConditionFunc_attack_more_than_some_attribute(arg_12_0, arg_12_1, arg_12_2)
		return true
	end

	function arg_1_0.__onConditionFunc_attack_some_ship(arg_13_0, arg_13_1, arg_13_2)
		return true
	end

	function arg_1_0.__onConditionFunc_attack_some_attribute_more_then_num(arg_14_0, arg_14_1, arg_14_2)
		return true
	end

	function arg_1_0.__onConditionFunc_attack_some_attribute_less_then_num(arg_15_0, arg_15_1, arg_15_2)
		return true
	end

	function arg_1_0.__onConditionFunc_attack_not_full_hp(arg_16_0, arg_16_1, arg_16_2)
		return true
	end

	function arg_1_0.__onConditionFunc_attack_opposite_same_pos(arg_17_0, arg_17_1, arg_17_2)
		return true
	end

	function arg_1_0.__onConditionFunc_attack_flag(arg_18_0, arg_18_1, arg_18_2)
		return true
	end

	function arg_1_0.__onConditionFunc_attack_not_flag(arg_19_0, arg_19_1, arg_19_2)
		return true
	end

	function arg_1_0.__onConditionFunc_open_torpedo(arg_20_0, arg_20_1)
		return true
	end

	function arg_1_0.__onConditionFunc_no_harm(arg_21_0, arg_21_1)
		return arg_21_1:get_attribute().hp:get_final_value() == arg_21_1:get_attribute().now_hp:get_final_value()
	end

	function arg_1_0.__onConditionFunc_middle_break(arg_22_0, arg_22_1)
		if arg_22_1:is_medhp() then
			return true
		end

		return false
	end

	function arg_1_0.__onConditionFunc_not_big_break(arg_23_0, arg_23_1)
		return not arg_23_1:is_lowhp()
	end

	function arg_1_0.__onConditionFunc_not_middle_break(arg_24_0, arg_24_1)
		return not arg_24_1:is_medhp()
	end

	function arg_1_0.__onConditionFunc_not_middle_big_break(arg_25_0, arg_25_1)
		if not arg_25_1:is_medhp() and not arg_25_1:is_lowhp() then
			return true
		end

		return false
	end

	function arg_1_0.__onConditionFunc_hp_more_then_nun(arg_26_0, arg_26_1, arg_26_2)
		if arg_26_1:get_attribute().now_hp:get_final_value() >= arg_26_1:get_attribute().hp:get_final_value() * arg_26_2.num then
			return true
		end

		return false
	end

	function arg_1_0.__onConditionFunc_flag(arg_27_0, arg_27_1)
		return arg_27_1:is_flag()
	end

	function arg_1_0.__onConditionFunc_not_flag(arg_28_0, arg_28_1)
		return not arg_28_1:is_flag()
	end

	function arg_1_0:__onConditionFunc_some_ship_type_is_flag(arg_29_1, arg_29_2)
		local var_29_0 = self._battle_obj_mgr:get_flag_ship(arg_29_1:get_side())

		for iter_29_0, iter_29_1 in pairs(arg_29_2.shipTypes) do
			if var_29_0:get_ship_type() == iter_29_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__onConditionFunc_some_ship_type_is_not_flag(arg_30_1, arg_30_2)
		local var_30_0 = self._battle_obj_mgr:get_flag_ship(arg_30_1:get_side())

		for iter_30_0, iter_30_1 in pairs(arg_30_2.shipTypes) do
			if var_30_0:get_ship_type() == iter_30_1 then
				return false
			end
		end

		return true
	end

	function arg_1_0:__onConditionFunc_chapter_six_of_the_war(arg_31_1)
		if not self._battle_scene:get_battle_point() then
			return false
		end

		local var_31_0 = var_0_3.find_object_by_id(self._battle_scene:get_battle_point())

		if not var_31_0 then
			return false
		end

		local var_31_1 = var_31_0.pve_level_id
		local var_31_2 = var_31_0.pve_level_id < 1000 and var_0_8.find_object_by_id(var_31_1).pve_id or var_0_9.find_object_by_id(var_31_1).pve_id

		if not var_31_2 then
			return false
		end

		return var_31_2 == 6
	end

	function arg_1_0:__onConditionFunc_t_advantage(arg_32_1)
		if self._battle_scene:get_player_course() == var_0_1.course_type_rule.t_advantage.value and arg_32_1:get_side() == var_0_1.obj_side.player then
			return true
		end

		if self._battle_scene:get_enemy_course() == var_0_1.course_type_rule.t_advantage.value and arg_32_1:get_side() == var_0_1.obj_side.enemy then
			return true
		end

		return false
	end

	function arg_1_0:__onConditionFunc_reversal_aviation_battle_ship(arg_33_1)
		if self._battle_scene:get_player_course() == var_0_1.course_type_rule.reversal.value and arg_33_1:get_side() == var_0_1.obj_side.player then
			return true
		end

		if self._battle_scene:get_enemy_course() == var_0_1.course_type_rule.reversal.value and arg_33_1:get_side() == var_0_1.obj_side.enemy then
			return true
		end

		return false
	end

	function arg_1_0:__onConditionFunc_same_aviation_battle_ship(arg_34_1)
		if self._battle_scene:get_player_course() == var_0_1.course_type_rule.same.value and arg_34_1:get_side() == var_0_1.obj_side.player then
			return true
		end

		if self._battle_scene:get_enemy_course() == var_0_1.course_type_rule.same.value and arg_34_1:get_side() == var_0_1.obj_side.enemy then
			return true
		end

		return false
	end

	function arg_1_0:__onConditionFunc_t_disadvantage(arg_35_1)
		if self._battle_scene:get_player_course() == var_0_1.course_type_rule.t_disadvantage.value and arg_35_1:get_side() == var_0_1.obj_side.player then
			return true
		end

		if self._battle_scene:get_enemy_course() == var_0_1.course_type_rule.t_disadvantage.value and arg_35_1:get_side() == var_0_1.obj_side.enemy then
			return true
		end

		return false
	end

	function arg_1_0:__onConditionFunc_radar_success_and_falg(arg_36_1)
		if self._battle_scene:get_radar_state() and arg_36_1:is_flag() and arg_36_1:get_side() == var_0_1.obj_side.player then
			return true
		end

		return false
	end

	function arg_1_0.__onConditionFunc_rate_trigger(arg_37_0, arg_37_1)
		return arg_37_1:is_lowhp()
	end

	function arg_1_0:__onConditionFunc_ship_count_nlt_num(arg_38_1, arg_38_2)
		return #self._battle_obj_mgr:get_ships_by_side(arg_38_1:get_side()) >= arg_38_2.num
	end

	function arg_1_0:__onConditionFunc_ship_type_nlt_num_in_config(arg_39_1, arg_39_2)
		return #self:__get_meet_shipTypes_data(self._battle_obj_mgr:get_ships_by_side(arg_39_1:get_side()), arg_39_2.shipTypes) >= arg_39_2.num
	end

	function arg_1_0:__onConditionFunc_ship_type_lt_num_in_config(arg_40_1, arg_40_2)
		return #self:__get_meet_shipTypes_data(self._battle_obj_mgr:get_ships_by_side(arg_40_1:get_side()), arg_40_2.shipTypes) < arg_40_2.num
	end

	function arg_1_0:__onConditionFunc_ship_count_nlt_num_in_config(arg_41_1, arg_41_2)
		return #self:__get_meet_cardCids_data(self._battle_obj_mgr:get_ships_by_side(arg_41_1:get_side()), arg_41_2.shipCids) >= arg_41_2.num
	end

	function arg_1_0:__onConditionFunc_ship_type_nmt_enemy(arg_42_1, arg_42_2)
		return #self:__get_meet_shipTypes_data(self._battle_obj_mgr:get_ships_by_side((var_0_1.obj_side.opposite(arg_42_1:get_side()))), arg_42_2.shipTypes) >= #self:__get_meet_shipTypes_data(self._battle_obj_mgr:get_ships_by_side(arg_42_1:get_side()), arg_42_2.shipTypes)
	end

	function arg_1_0:__onConditionFunc_ship_type_more_than_enemy(arg_43_1, arg_43_2)
		return #self:__get_meet_shipTypes_data(self._battle_obj_mgr:get_ships_by_side((var_0_1.obj_side.opposite(arg_43_1:get_side()))), arg_43_2.shipTypes) < #self:__get_meet_shipTypes_data(self._battle_obj_mgr:get_ships_by_side(arg_43_1:get_side()), arg_43_2.shipTypes)
	end

	function arg_1_0:__onConditionFunc_no_ship_type_in_config_without_self(arg_44_1, arg_44_2)
		return #self:__get_meet_shipTypes_data(self._battle_obj_mgr:get_ships_by_side(arg_44_1:get_side()), arg_44_2.shipTypes) <= #self:__get_meet_shipTypes_data({
			arg_44_1
		}, arg_44_2.shipTypes)
	end

	function arg_1_0:__onConditionFunc_nlt_num2_ship_count_of_some_attribute_nlt_num(arg_45_1, arg_45_2)
		local var_45_0 = 0

		for iter_45_0, iter_45_1 in pairs((self._battle_obj_mgr:get_ships_by_side(arg_45_1:get_side()))) do
			if var_0_2:get_attribute_by_index(iter_45_1, arg_45_2.attribute) >= arg_45_2.num then
				var_45_0 = var_45_0 + 1
			end
		end

		return var_45_0 >= arg_45_2.num2
	end

	function arg_1_0:__onConditionFunc_more_effect_more_death(arg_46_1)
		local var_46_0 = 0

		for iter_46_0, iter_46_1 in pairs((self._battle_obj_mgr:get_ships_by_side(self._owner:get_side()))) do
			if not iter_46_1:get_is_alive() then
				var_46_0 = var_46_0 + 1
			end
		end

		arg_46_1:set_skill_effect_count(var_46_0)

		return true
	end

	function arg_1_0:__onConditionFunc_more_effect_more_count_in_config(arg_47_1, arg_47_2)
		arg_47_1:set_skill_effect_count(#self:__get_meet_cardCids_data(self._battle_obj_mgr:get_ships_by_side(self._owner:get_side()), arg_47_2.shipCids))

		return true
	end

	function arg_1_0:__onConditionFunc_some_type_ship_count_mul_effect_in_config(arg_48_1, arg_48_2)
		local var_48_0 = self._battle_obj_mgr:get_ships_by_side(self._owner:get_side())
		local var_48_1 = 0
		local var_48_2 = 0

		for iter_48_0, iter_48_1 in ipairs({
			"shipTypes",
			"shipTons",
			"guardTypes",
			"shipCids"
		}) do
			if arg_48_2[iter_48_1] then
				var_48_2 = iter_48_0

				break
			end
		end

		if var_48_2 == 0 then
			-- block empty
		elseif var_48_2 == 1 then
			var_48_1 = #self:__get_meet_shipTypes_data(var_48_0, arg_48_2.shipTypes)
		elseif var_48_2 == 2 then
			var_48_1 = #self:__get_meet_shipTons_data(var_48_0, arg_48_2.shipTons)
		elseif var_48_2 == 3 then
			var_48_1 = #self:__get_meet_guardTypes_data(var_48_0, arg_48_2.guardTypes)
		elseif var_48_2 == 4 then
			var_48_1 = #self:__get_meet_cardCids_data(var_48_0, arg_48_2.shipCids)
		end

		arg_48_1:set_multiple_attr_value(var_48_1)

		return true
	end

	function arg_1_0:__onConditionFunc_some_country_ship_count_mul_effect_in_config(arg_49_1, arg_49_2)
		local var_49_0 = self._battle_obj_mgr:get_ships_by_side(self._owner:get_side())
		local var_49_1 = 0
		local var_49_2 = 0

		for iter_49_0, iter_49_1 in ipairs({
			"shipTypes",
			"shipTons",
			"guardTypes"
		}) do
			if arg_49_2[iter_49_1] then
				var_49_2 = iter_49_0

				break
			end
		end

		if var_49_2 == 0 then
			-- block empty
		elseif var_49_2 == 1 then
			var_49_1 = #self:__get_meet_shipTypes_data(var_49_0, arg_49_2.shipTypes, arg_49_2.country)
		elseif var_49_2 == 2 then
			var_49_1 = #self:__get_meet_shipTons_data(var_49_0, arg_49_2.shipTons, arg_49_2.country)
		elseif var_49_2 == 3 then
			var_49_1 = #self:__get_meet_guardTypes_data(var_49_0, arg_49_2.guardTypes, arg_49_2.country)
		end

		if var_49_1 == 0 then
			return false
		else
			arg_49_1:set_multiple_attr_value(var_49_1)

			return true
		end
	end

	function arg_1_0:__onConditionFunc_not_some_country_ship_count_mul_effect(arg_50_1, arg_50_2)
		local var_50_0 = 0

		for iter_50_0, iter_50_1 in pairs((self._battle_obj_mgr:get_ships_by_side(self._owner:get_side()))) do
			if iter_50_1:get_country() ~= arg_50_2.country then
				var_50_0 = var_50_0 + 1
			end
		end

		self._owner:set_multiple_attr_value(var_50_0)

		return true
	end

	function arg_1_0:__onConditionFunc_some_speed_nlt_num_ship_count_mul_effect_in_config(arg_51_1, arg_51_2)
		local var_51_0 = 0
		local var_51_1 = 0

		for iter_51_0, iter_51_1 in pairs((self._battle_obj_mgr:get_ships_by_side(self._owner:get_side()))) do
			for iter_51_2, iter_51_3 in pairs(arg_51_2.shipTypes) do
				if iter_51_1:get_ship_type() == iter_51_3 then
					var_51_1 = var_51_1 + 1
					var_51_0 = var_51_0 + var_0_2:get_attribute_by_index(iter_51_1, 10)
				end
			end
		end

		if var_51_1 > 0 and var_51_0 / var_51_1 >= arg_51_2.num then
			self._owner:set_multiple_attr_value(var_51_1)

			return true
		end
	end

	function arg_1_0:__onConditionFunc_some_attribute_nlt_num_nul_effect(arg_52_1, arg_52_2)
		local var_52_0 = 0

		for iter_52_0, iter_52_1 in pairs((self._battle_obj_mgr:get_ships_by_side(self._owner:get_side()))) do
			if var_0_2:get_attribute_by_index(iter_52_1, arg_52_2.attribute) >= arg_52_2.num then
				var_52_0 = var_52_0 + 1
			end
		end

		self._owner:set_multiple_attr_value(var_52_0)

		return true
	end

	function arg_1_0:__onConditionFunc_some_attribute_sum_of_other_ships_div_num_mul_effect(arg_53_1, arg_53_2)
		local var_53_0 = 0

		for iter_53_0, iter_53_1 in pairs((self._battle_obj_mgr:get_ships_by_side(self._owner:get_side()))) do
			if iter_53_1:getID() ~= arg_53_1:getID() then
				var_53_0 = var_53_0 + var_0_2:get_attribute_by_index(iter_53_1, arg_53_2.attribute)
			end
		end

		self._owner:set_multiple_attr_value(var_53_0 / arg_53_2.num)

		return true
	end

	function arg_1_0:__onConditionFunc_some_attribute_sum_of_ships_div_num_mul_effect(arg_54_1, arg_54_2)
		local var_54_0 = 0

		for iter_54_0, iter_54_1 in pairs((self._battle_obj_mgr:get_ships_by_side(self._owner:get_side()))) do
			var_54_0 = var_54_0 + var_0_2:get_attribute_by_index(iter_54_1, arg_54_2.attribute)
		end

		self._owner:set_multiple_attr_value((math.floor(var_54_0 / arg_54_2.num)))

		return true
	end

	function arg_1_0:__onConditionFunc_distance_of_combat_to_start_mul_effect(arg_55_1)
		self._owner:set_multiple_attr_value(self._battle_scene:get_battle_point() and var_0_3.find_object_by_id(self._battle_scene:get_battle_point()) and var_0_3.find_object_by_id(self._battle_scene:get_battle_point()).node_step or var_0_4 and self._battle_scene:get_battle_point() and var_0_4.find_object_by_id(self._battle_scene:get_battle_point()) and var_0_4.find_object_by_id(self._battle_scene:get_battle_point()).node_step or var_0_5 and self._battle_scene:get_battle_point() and var_0_5.find_object_by_id(self._battle_scene:get_battle_point()) and var_0_5.find_object_by_id(self._battle_scene:get_battle_point()).node_step or var_0_6 and self._battle_scene:get_battle_point() and self._battle_scene:set_battle_start_point() and var_0_6.find_object_by_id_start_node_id(self._battle_scene:get_battle_point(), self._battle_scene:set_battle_start_point()) and var_0_6.find_object_by_id_start_node_id(self._battle_scene:get_battle_point(), self._battle_scene:set_battle_start_point()).node_step or var_0_7 and self._battle_scene:get_battle_point() and var_0_7.find_object_by_id(self._battle_scene:get_battle_point()) and var_0_7.find_object_by_id(self._battle_scene:get_battle_point()).node_step or var_0_10 and self._battle_scene:get_battle_point() and var_0_10.find_object_by_id(self._battle_scene:get_battle_point()) and var_0_10.find_object_by_id(self._battle_scene:get_battle_point()).node_step or var_0_11 and self._battle_scene:get_battle_point() and self._battle_scene:get_battle_start_point() and var_0_11.find_object_by_id_start_node_id(self._battle_scene:get_battle_point(), self._battle_scene:get_battle_start_point()) and var_0_11.find_object_by_id_start_node_id(self._battle_scene:get_battle_point(), self._battle_scene:get_battle_start_point()).node_step or var_0_12 and self._battle_scene:get_battle_point() and self._battle_scene:get_battle_start_point() and var_0_12.find_object_by_id_start_node_id(self._battle_scene:get_battle_point(), self._battle_scene:get_battle_start_point()) and var_0_12.find_object_by_id_start_node_id(self._battle_scene:get_battle_point(), self._battle_scene:get_battle_start_point()).node_step or 5)

		return true
	end

	function arg_1_0:__onConditionFunc_distance_of_combat_to_end_mul_effect(arg_56_1)
		self._owner:set_multiple_attr_value(self._battle_scene:get_battle_point() and var_0_3.find_object_by_id(self._battle_scene:get_battle_point()) and 6 - var_0_3.find_object_by_id(self._battle_scene:get_battle_point()).node_step or self._battle_scene:get_battle_point() and var_0_4.find_object_by_id(self._battle_scene:get_battle_point()) and 6 - var_0_4.find_object_by_id(self._battle_scene:get_battle_point()).node_step or var_0_5 and self._battle_scene:get_battle_point() and var_0_5.find_object_by_id(self._battle_scene:get_battle_point()) and 6 - var_0_5.find_object_by_id(self._battle_scene:get_battle_point()).node_step or var_0_6 and self._battle_scene:get_battle_point() and self._battle_scene:set_battle_start_point() and var_0_6.find_object_by_id_start_node_id(self._battle_scene:get_battle_point(), self._battle_scene:set_battle_start_point()) and 6 - var_0_6.find_object_by_id_start_node_id(self._battle_scene:get_battle_point(), self._battle_scene:set_battle_start_point()).node_step or var_0_7 and self._battle_scene:get_battle_point() and var_0_7.find_object_by_id(self._battle_scene:get_battle_point()) and 6 - var_0_7.find_object_by_id(self._battle_scene:get_battle_point()).node_step or var_0_10 and self._battle_scene:get_battle_point() and var_0_10.find_object_by_id(self._battle_scene:get_battle_point()) and 6 - var_0_10.find_object_by_id(self._battle_scene:get_battle_point()).node_step or var_0_11 and self._battle_scene:get_battle_point() and self._battle_scene:get_battle_start_point() and var_0_11.find_object_by_id_start_node_id(self._battle_scene:get_battle_point(), self._battle_scene:get_battle_start_point()) and 6 - var_0_11.find_object_by_id_start_node_id(self._battle_scene:get_battle_point(), self._battle_scene:get_battle_start_point()).node_step or var_0_12 and self._battle_scene:get_battle_point() and self._battle_scene:get_battle_start_point() and var_0_12.find_object_by_id_start_node_id(self._battle_scene:get_battle_point(), self._battle_scene:get_battle_start_point()) and 6 - var_0_12.find_object_by_id_start_node_id(self._battle_scene:get_battle_point(), self._battle_scene:get_battle_start_point()).node_step or 5)

		return true
	end

	function arg_1_0:__onConditionFunc_severity_of_injury_nul_effect(arg_57_1)
		self._owner:set_multiple_attr_value((arg_57_1:lost_hp_perent()))

		return true
	end

	function arg_1_0:__onConditionFunc_speed_div_num_mul_effect(arg_58_1, arg_58_2)
		local var_58_0 = self._owner:get_ship_speed() / arg_58_2.num

		if var_58_0 >= 1 and var_58_0 <= 2 then
			self._owner:set_multiple_attr_value(var_58_0)
		end

		return true
	end

	function arg_1_0:__onConditionFunc_some_type_ship_count_mul_effect_in_config_when_U_submarine_flag(arg_59_1, arg_59_2)
		local var_59_0 = self._battle_obj_mgr:get_flag_ship((self._owner:get_side()))

		if var_59_0:get_country() == var_0_1.country_type.germany and var_59_0:get_ship_type() == var_0_1.ship_type_rule.submarine.value then
			local var_59_1 = 0

			for iter_59_0, iter_59_1 in pairs((self._battle_obj_mgr:get_ships_by_side(self._owner:get_side()))) do
				for iter_59_2, iter_59_3 in pairs(arg_59_2.shipTypes) do
					if iter_59_1:get_ship_type() == iter_59_3 then
						var_59_1 = var_59_1 + 1
					end
				end
			end

			self._owner:set_multiple_attr_value(var_59_1)

			return true
		end

		return false
	end

	function arg_1_0:__onConditionFunc_ships_count_of_map_mul_effect(arg_60_1, arg_60_2)
		local var_60_0 = 0
		local var_60_1 = self._battle_scene:get_map_ship_data()

		if var_60_1 then
			for iter_60_0, iter_60_1 in pairs(var_60_1) do
				for iter_60_2, iter_60_3 in pairs(arg_60_2.shipCids) do
					if iter_60_1 == iter_60_3 then
						var_60_0 = var_60_0 + 1
					end
				end
			end
		end

		self._owner:set_multiple_attr_value(var_60_0)

		return true
	end

	function arg_1_0:__onConditionFunc_gofight_count_div_num_mul_effect(arg_61_1, arg_61_2)
		local var_61_0 = self._battle_scene:get_map_total_num()

		if var_61_0 and arg_61_2 then
			local var_61_1 = var_61_0 / arg_61_2.num

			var_61_1 = var_61_0 / arg_61_2.num > 1 and 1 or var_61_1

			self._owner:set_multiple_attr_value(var_61_1)
		end

		return true
	end

	function arg_1_0:__onConditionFunc_add_attribute_by_enemy_loss_hp_percent(arg_62_1, arg_62_2)
		local var_62_0 = 0

		for iter_62_0, iter_62_1 in pairs((self._battle_obj_mgr:get_ships_by_side((var_0_1.obj_side.opposite(self._owner:get_side()))))) do
			var_62_0 = var_62_0 + iter_62_1:lost_hp_perent()
		end

		self._owner:set_multiple_attr_value(1 + var_62_0 * arg_62_2.num)

		return true
	end

	function arg_1_0:__onConditionFunc_self_loss_hp_div_num_mul_effect(arg_63_1, arg_63_2)
		local var_63_0 = math.floor((arg_63_1._attribute.hp:get_final_value() - arg_63_1._attribute.now_hp:get_final_value()) / arg_63_2.num)

		if var_63_0 >= 0 and var_63_0 <= 10 then
			self._owner:set_multiple_attr_value(var_63_0)
		elseif var_63_0 > 10 then
			self._owner:set_multiple_attr_value(10)
		end

		return true
	end

	function arg_1_0:__onConditionFunc_take_attack_count_nul_effect(arg_64_1)
		self._owner:set_multiple_attr_value((arg_64_1:get_total_attack()))

		return true
	end

	function arg_1_0:__onConditionFunc_hit_count_mul_effect(arg_65_1, arg_65_2)
		local var_65_0 = 0

		for iter_65_0, iter_65_1 in pairs((self._battle_obj_mgr:get_ships_by_side(arg_65_1:get_side()))) do
			local var_65_1 = iter_65_1:get_total_hit_count()

			for iter_65_2, iter_65_3 in pairs(arg_65_2.stage) do
				for iter_65_4, iter_65_5 in pairs(var_65_1) do
					if var_0_2:judge_stage(iter_65_3, iter_65_4) then
						var_65_0 = var_65_0 + iter_65_5
					end
				end
			end
		end

		arg_65_1:set_multiple_attr_value(var_65_0)

		return true
	end

	function arg_1_0.__onConditionFunc_level_div_num_mul_effect(arg_66_0, arg_66_1, arg_66_2)
		arg_66_1:set_multiple_attr_value((math.floor(arg_66_1:get_level() / arg_66_2.num)))

		return true
	end

	function arg_1_0.__onConditionFunc_torpedo_plane_count_more_than_bomber(arg_67_0, arg_67_1)
		local var_67_0 = 0
		local var_67_1 = 0

		for iter_67_0, iter_67_1 in pairs((arg_67_1:get_equip_list())) do
			if iter_67_1:get_equip_type() == var_0_1.equip_type.torpedo_plane then
				var_67_0 = var_67_0 + 1
			elseif iter_67_1:get_equip_type() == var_0_1.equip_type.bomber then
				var_67_1 = var_67_1 + 1
			end
		end

		if var_67_1 < var_67_0 then
			return true
		end

		return false
	end

	function arg_1_0.__onConditionFunc_bomber_count_more_than_torpedo_plane(arg_68_0, arg_68_1)
		local var_68_0 = 0
		local var_68_1 = 0

		for iter_68_0, iter_68_1 in pairs((arg_68_1:get_equip_list())) do
			if iter_68_1:get_equip_type() == var_0_1.equip_type.torpedo_plane then
				var_68_0 = var_68_0 + 1
			elseif iter_68_1:get_equip_type() == var_0_1.equip_type.bomber then
				var_68_1 = var_68_1 + 1
			end
		end

		if var_68_0 < var_68_1 then
			return true
		end

		return false
	end

	function arg_1_0:__onConditionFunc_our_single(arg_69_1)
		if self._battle_scene:get_player_formation() == var_0_1.formation_type_rule.single.value and arg_69_1:get_side() == var_0_1.obj_side.player then
			return true
		end

		if self._battle_scene:get_enemy_formation() == var_0_1.formation_type_rule.single.value and arg_69_1:get_side() == var_0_1.obj_side.enemy then
			return true
		end

		return false
	end

	function arg_1_0:__onConditionFunc_our_trapezoidal(arg_70_1)
		if self._battle_scene:get_player_formation() == var_0_1.formation_type_rule.trapezoidal.value and arg_70_1:get_side() == var_0_1.obj_side.player then
			return true
		end

		if self._battle_scene:get_enemy_formation() == var_0_1.formation_type_rule.trapezoidal.value and arg_70_1:get_side() == var_0_1.obj_side.enemy then
			return true
		end

		return false
	end

	function arg_1_0:__onConditionFunc_have_some_ship_of_enemy(arg_71_1, arg_71_2)
		local var_71_0 = self._battle_obj_mgr:get_ships_by_side(arg_71_1:get_side())
		local var_71_1 = {}
		local var_71_4 = 0

		for iter_71_0, iter_71_1 in ipairs({
			"shipTypes",
			"shipTons",
			"guardTypes",
			"shipCids"
		}) do
			if arg_71_2[iter_71_1] then
				var_71_4 = iter_71_0

				break
			end
		end

		if var_71_4 == 0 then
			var_71_1 = var_71_0
		elseif var_71_4 == 1 then
			var_71_1 = self:__get_meet_shipTypes_data(var_71_0, arg_71_2.shipTypes)
		elseif var_71_4 == 2 then
			var_71_1 = self:__get_meet_shipTons_data(var_71_0, arg_71_2.shipTons)
		elseif var_71_4 == 3 then
			var_71_1 = self:__get_meet_guardTypes_data(var_71_0, arg_71_2.guardTypes)
		elseif var_71_4 == 4 then
			var_71_1 = self:__get_meet_cardCids_data(var_71_0, arg_71_2.shipCids)
		end

		return #var_71_1 == arg_71_2.num
	end

	function arg_1_0:__onConditionFunc_some_average_attribute_of_enemy_lt_self(arg_72_1, arg_72_2)
		local var_72_0 = self._battle_obj_mgr:get_ships_by_side((var_0_1.obj_side.opposite(arg_72_1:get_side())))
		local var_72_1 = var_0_2:dict_length(var_72_0)
		local var_72_2 = 0
		local var_72_3 = var_0_1.skil_attribute_type[arg_72_2.attribute] or ""

		if var_72_3 ~= "" and var_72_1 > 0 then
			for iter_72_0, iter_72_1 in pairs(var_72_0) do
				var_72_2 = var_72_2 + iter_72_1:get_character_attribute()[var_72_3]:get_final_value()
			end

			return arg_72_1:get_character_attribute()[var_72_3]:get_final_value() > var_72_2 / var_72_1
		end

		return false
	end

	function arg_1_0:__onConditionFunc_some_average_attribute_of_enemy_mt_self(arg_73_1, arg_73_2)
		local var_73_0 = self._battle_obj_mgr:get_ships_by_side((var_0_1.obj_side.opposite(arg_73_1:get_side())))
		local var_73_1 = var_0_2:dict_length(var_73_0)
		local var_73_2 = 0
		local var_73_3 = var_0_1.skil_attribute_type[arg_73_2.attribute] or ""

		if var_73_3 ~= "" and var_73_1 > 0 then
			for iter_73_0, iter_73_1 in pairs(var_73_0) do
				var_73_2 = var_73_2 + iter_73_1:get_character_attribute()[var_73_3]:get_final_value()
			end

			return arg_73_1:get_character_attribute()[var_73_3]:get_final_value() < var_73_2 / var_73_1
		end

		return false
	end

	function arg_1_0.__onConditionFunc_after_loss_hp_percent(arg_74_0, arg_74_1, arg_74_2)
		return arg_74_1:lost_hp_perent() >= arg_74_2.num / 100
	end

	function arg_1_0:__onConditionFunc_air_control_type_equi(arg_75_1)
		if self._battle_scene:get_player_air_control_type() == 3 then
			return true
		end

		return false
	end

	function arg_1_0:__onConditionFunc_air_control_type_advantage(arg_76_1)
		if self._battle_scene:get_player_air_control_type() == 2 then
			return true
		end

		return false
	end

	function arg_1_0:__onConditionFunc_air_control_type_supremancy(arg_77_1)
		if self._battle_scene:get_player_air_control_type() == 1 then
			return true
		end

		return false
	end

	function arg_1_0.__onConditionFunc_hp_less_than_num_by_percent(arg_78_0, arg_78_1, arg_78_2)
		if arg_78_1:get_attribute().now_hp:get_final_value() / arg_78_1:get_attribute().hp:get_final_value() < arg_78_2.num then
			return true
		end

		return false
	end

	function arg_1_0:__onConditionFunc_shiptype_by_num(arg_79_1, arg_79_2)
		local var_79_0 = 0

		for iter_79_0, iter_79_1 in pairs((self._battle_obj_mgr:get_ships_by_side((var_0_1.obj_side.opposite(arg_79_1:get_side()))))) do
			local var_79_1 = iter_79_1:get_ship_type()

			for iter_79_2, iter_79_3 in pairs(arg_79_2.shipTypes) do
				if var_79_1 == iter_79_3 then
					var_79_0 = var_79_0 + 1
				end
			end
		end

		if var_79_0 > 0 then
			self._owner:set_multiple_attr_value(var_79_0)

			return true
		end

		return false
	end

	function arg_1_0:__onConditionFunc_greater_than_average_attr(arg_80_1, arg_80_2)
		local var_80_0 = self._battle_obj_mgr:get_ships_by_side((var_0_1.obj_side.opposite(arg_80_1:get_side())))
		local var_80_1 = self._battle_obj_mgr:get_ships_by_side(arg_80_1:get_side())
		local var_80_2 = var_0_1.skil_attribute_type[arg_80_2.attribute] or ""
		local var_80_3 = #var_80_0
		local var_80_4 = 0
		local var_80_5 = 0

		if var_80_2 ~= "" and var_80_3 > 0 then
			for iter_80_0, iter_80_1 in pairs(var_80_0) do
				var_80_4 = var_80_4 + iter_80_1:get_character_attribute()[var_80_2]:get_final_value()
			end

			for iter_80_2, iter_80_3 in pairs(var_80_1) do
				var_80_5 = var_80_5 + iter_80_3:get_character_attribute()[var_80_2]:get_final_value()
			end

			return var_80_4 / var_80_3 < var_80_5 / #var_80_1
		end

		return false
	end

	function arg_1_0:__onConditionFunc_less_than_average_attr(arg_81_1, arg_81_2)
		local var_81_0 = self._battle_obj_mgr:get_ships_by_side((var_0_1.obj_side.opposite(arg_81_1:get_side())))
		local var_81_1 = self._battle_obj_mgr:get_ships_by_side(arg_81_1:get_side())
		local var_81_2 = var_0_1.skil_attribute_type[arg_81_2.attribute] or ""
		local var_81_3 = #var_81_0
		local var_81_4 = 0
		local var_81_5 = 0

		if var_81_2 ~= "" and var_81_3 > 0 then
			for iter_81_0, iter_81_1 in pairs(var_81_0) do
				var_81_4 = var_81_4 + iter_81_1:get_character_attribute()[var_81_2]:get_final_value()
			end

			for iter_81_2, iter_81_3 in pairs(var_81_1) do
				var_81_5 = var_81_5 + iter_81_3:get_character_attribute()[var_81_2]:get_final_value()
			end

			return var_81_4 / var_81_3 > var_81_5 / #var_81_1
		end

		return false
	end

	function arg_1_0:__onConditionFunc_less_than_num_by_cid(arg_82_1, arg_82_2)
		return #self:__get_meet_cardCids_data(self._battle_obj_mgr:get_ships_by_side(arg_82_1:get_side()), arg_82_2.shipCids) <= arg_82_2.num
	end

	function arg_1_0:__onConditionFunc_greater_than_num_and_greater_than_attr(arg_83_1, arg_83_2)
		local var_83_0 = self._battle_obj_mgr:get_ships_by_side(arg_83_1:get_side())
		local var_83_1 = var_0_2:dict_length(var_83_0)
		local var_83_2 = 0
		local var_83_3 = var_0_1.skil_attribute_type[arg_83_2.attribute] or ""
		local var_83_4

		if var_83_3 ~= "" and var_83_1 > 0 then
			for iter_83_0, iter_83_1 in pairs(var_83_0) do
				var_83_2 = var_83_2 + iter_83_1:get_character_attribute()[var_83_3]:get_final_value()
			end

			var_83_4 = arg_83_1:get_character_attribute()[var_83_3]:get_final_value()
		end

		return var_83_1 >= arg_83_2.num and var_83_4 < var_83_2 / var_83_1
	end

	function arg_1_0:__onConditionFunc_greater_than_num_and_less_than_attr(arg_84_1, arg_84_2)
		local var_84_0 = self._battle_obj_mgr:get_ships_by_side(arg_84_1:get_side())
		local var_84_1 = var_0_2:dict_length(var_84_0)
		local var_84_2 = 0
		local var_84_3 = var_0_1.skil_attribute_type[arg_84_2.attribute] or ""
		local var_84_4

		if var_84_3 ~= "" and var_84_1 > 0 then
			for iter_84_0, iter_84_1 in pairs(var_84_0) do
				var_84_2 = var_84_2 + iter_84_1:get_character_attribute()[var_84_3]:get_final_value()
			end

			var_84_4 = arg_84_1:get_character_attribute()[var_84_3]:get_final_value()
		end

		return var_84_1 >= arg_84_2.num and var_84_4 > var_84_2 / var_84_1
	end

	function arg_1_0:__onConditionFunc_greater_than_num_and_equal_to_attr(arg_85_1, arg_85_2)
		local var_85_0 = self._battle_obj_mgr:get_ships_by_side(arg_85_1:get_side())
		local var_85_1 = var_0_2:dict_length(var_85_0)
		local var_85_2 = 0
		local var_85_3 = var_0_1.skil_attribute_type[arg_85_2.attribute] or ""
		local var_85_4

		if var_85_3 ~= "" and var_85_1 > 0 then
			for iter_85_0, iter_85_1 in pairs(var_85_0) do
				var_85_2 = var_85_2 + iter_85_1:get_character_attribute()[var_85_3]:get_final_value()
			end

			var_85_4 = arg_85_1:get_character_attribute()[var_85_3]:get_final_value()
		end

		return var_85_1 >= arg_85_2.num and var_85_2 / var_85_1 == var_85_4
	end

	function arg_1_0:__onConditionFunc_our_double(arg_86_1, arg_86_2)
		if self._battle_scene:get_player_formation() == var_0_1.formation_type_rule.double.value then
			return true
		end

		return false
	end

	function arg_1_0:__onConditionFunc_have_not_ship_by_cid(arg_87_1, arg_87_2)
		return #self:__get_meet_cardCids_data(self._battle_obj_mgr:get_ships_by_side(-arg_87_1:get_side()), arg_87_2.shipCids) == 0
	end

	function arg_1_0:__onConditionFunc_is_flag_by_cid(arg_88_1, arg_88_2)
		local var_88_0 = self._battle_obj_mgr:get_flag_ship(arg_88_1:get_side())

		for iter_88_0, iter_88_1 in pairs(arg_88_2.shipCids) do
			if var_88_0:get_cid() == iter_88_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__onConditionFunc_self_flag_opposite_no_flag(arg_89_1)
		local var_89_0 = self._battle_obj_mgr:get_ships_by_side(var_0_1.obj_side.opposite((arg_89_1:get_side())))

		if not var_89_0[1] then
			return false
		end

		if var_89_0[1]:get_is_alive() and not var_89_0[1]:is_submarine() then
			return (arg_89_1:is_flag())
		end

		return false
	end

	function arg_1_0:__onConditionFunc_except_self_ship_count_mul_effect_in_config(arg_90_1, arg_90_2)
		local var_90_0 = self._battle_obj_mgr:get_ships_by_side(arg_90_1:get_side())
		local var_90_1
		local var_90_2
		local var_90_3 = 0

		for iter_90_0, iter_90_1 in ipairs({
			"shipTypes",
			"shipTons",
			"guardTypes",
			"shipCids"
		}) do
			if arg_90_2[iter_90_1] then
				var_90_3 = iter_90_0

				break
			end
		end

		if var_90_3 == 0 then
			log.errorlog("配置错误, 效果缺少相应参数")
		elseif var_90_3 == 1 then
			var_90_1 = #self:__get_meet_shipTypes_data(var_90_0, arg_90_2.shipTypes)
			var_90_2 = #self:__get_meet_shipTypes_data({
				arg_90_1
			}, arg_90_2.shipTypes)
		elseif var_90_3 == 2 then
			var_90_1 = #self:__get_meet_shipTons_data(var_90_0, arg_90_2.shipTons)
			var_90_2 = #self:__get_meet_shipTons_data({
				arg_90_1
			}, arg_90_2.shipTons)
		elseif var_90_3 == 3 then
			var_90_1 = #self:__get_meet_guardTypes_data(var_90_0, arg_90_2.guardTypes)
			var_90_2 = #self:__get_meet_guardTypes_data({
				arg_90_1
			}, arg_90_2.guardTypes)
		elseif var_90_3 == 4 then
			var_90_1 = #self:__get_meet_cardCids_data(var_90_0, arg_90_2.shipCids)
			var_90_2 = #self:__get_meet_cardCids_data({
				arg_90_1
			}, arg_90_2.shipCids)
		end

		arg_90_1:set_multiple_attr_value(var_90_1 - var_90_2)

		return true
	end

	function arg_1_0:__onConditionFunc_t_disadvantage_self_flag(arg_91_1)
		if self._battle_scene:get_player_course() == var_0_1.course_type_rule.t_disadvantage.value and arg_91_1:get_side() == var_0_1.obj_side.player and arg_91_1:is_flag() then
			return true
		end

		if self._battle_scene:get_enemy_course() == var_0_1.course_type_rule.t_disadvantage.value and arg_91_1:get_side() == var_0_1.obj_side.enemy and arg_91_1:is_flag() then
			return true
		end

		return false
	end

	function arg_1_0:__onConditionFunc_hight_speed_ship_by_shiptype_by_num(arg_92_1, arg_92_2)
		local var_92_0 = self._battle_obj_mgr:get_ships_by_side(self._owner:get_side())
		local var_92_1 = {}
		local var_92_2 = {}
		local var_92_4 = 0

		for iter_92_0, iter_92_1 in ipairs({
			"shipTypes",
			"shipTons",
			"guardTypes",
			"shipCids"
		}) do
			if arg_92_2[iter_92_1] then
				var_92_4 = iter_92_0

				break
			end
		end

		if var_92_4 == 0 then
			log.errorlog("配置错误, 效果缺少相应参数")
		elseif var_92_4 == 1 then
			var_92_1 = self:__get_meet_shipTypes_data(var_92_0, arg_92_2.shipTypes)
		elseif var_92_4 == 2 then
			var_92_1 = self:__get_meet_shipTons_data(var_92_0, arg_92_2.shipTons)
		elseif var_92_4 == 3 then
			var_92_1 = self:__get_meet_guardTypes_data(var_92_0, arg_92_2.guardTypes)
		elseif var_92_4 == 4 then
			var_92_1 = self:__get_meet_cardCids_data(var_92_0, arg_92_2.shipCids)
		end

		for iter_92_2, iter_92_3 in pairs(var_92_1) do
			if var_0_2:get_attribute_by_index(iter_92_3, 10) >= 27 then
				table.insert(var_92_2, iter_92_3)
			end
		end

		arg_92_1:set_multiple_attr_value(#var_92_2 > arg_92_2.num and arg_92_2.num or #var_92_2)

		return true
	end

	function arg_1_0:__onConditionFunc_ememy_num_greater_than_num(arg_93_1, arg_93_2)
		local var_93_0 = self._battle_obj_mgr:get_ships_by_side(-arg_93_1:get_side())
		local var_93_1 = {}
		local var_93_4 = 0

		for iter_93_0, iter_93_1 in ipairs({
			"shipTypes",
			"shipTons",
			"guardTypes",
			"shipCids"
		}) do
			if arg_93_2[iter_93_1] then
				var_93_4 = iter_93_0

				break
			end
		end

		if var_93_4 == 0 then
			var_93_1 = var_93_0
		elseif var_93_4 == 1 then
			var_93_1 = self:__get_meet_shipTypes_data(var_93_0, arg_93_2.shipTypes)
		elseif var_93_4 == 2 then
			var_93_1 = self:__get_meet_shipTons_data(var_93_0, arg_93_2.shipTons)
		elseif var_93_4 == 3 then
			var_93_1 = self:__get_meet_guardTypes_data(var_93_0, arg_93_2.guardTypes)
		elseif var_93_4 == 4 then
			var_93_1 = self:__get_meet_cardCids_data(var_93_0, arg_93_2.shipCids)
		end

		return #var_93_1 >= arg_93_2.num
	end

	function arg_1_0:__onConditionFunc_ememy_num_less_than_num(arg_94_1, arg_94_2)
		local var_94_0 = self._battle_obj_mgr:get_ships_by_side(-arg_94_1:get_side())
		local var_94_1 = {}
		local var_94_4 = 0

		for iter_94_0, iter_94_1 in ipairs({
			"shipTypes",
			"shipTons",
			"guardTypes",
			"shipCids"
		}) do
			if arg_94_2[iter_94_1] then
				var_94_4 = iter_94_0

				break
			end
		end

		if var_94_4 == 0 then
			var_94_1 = var_94_0
		elseif var_94_4 == 1 then
			var_94_1 = self:__get_meet_shipTypes_data(var_94_0, arg_94_2.shipTypes)
		elseif var_94_4 == 2 then
			var_94_1 = self:__get_meet_shipTons_data(var_94_0, arg_94_2.shipTons)
		elseif var_94_4 == 3 then
			var_94_1 = self:__get_meet_guardTypes_data(var_94_0, arg_94_2.guardTypes)
		elseif var_94_4 == 4 then
			var_94_1 = self:__get_meet_cardCids_data(var_94_0, arg_94_2.shipCids)
		end

		return #var_94_1 < arg_94_2.num
	end

	function arg_1_0:__onConditionFunc_num_by_ship_type(arg_95_1, arg_95_2)
		local var_95_0 = {}

		for iter_95_0, iter_95_1 in pairs((self._battle_obj_mgr:get_ships_by_side(arg_95_1:get_side()))) do
			local var_95_1 = true

			for iter_95_2, iter_95_3 in pairs(var_95_0) do
				if iter_95_1:get_ship_type() == iter_95_3 then
					var_95_1 = false
				end
			end

			if var_95_1 then
				table.insert(var_95_0, iter_95_1:get_ship_type())
			end
		end

		local var_95_2 = #var_95_0

		var_95_2 = #var_95_0 > arg_95_2.num and arg_95_2.num or var_95_2

		arg_95_1:set_multiple_attr_value(var_95_2)

		return true
	end

	function arg_1_0:__onConditionFunc_num_by_flag_ship(arg_96_1, arg_96_2)
		local var_96_0 = 0

		for iter_96_0, iter_96_1 in pairs((self._battle_obj_mgr:get_ships_by_side(arg_96_1:get_side()))) do
			local var_96_1 = var_0_14.find_object_by_cid(arg_96_1:get_cid())

			if var_96_1 and var_96_1.boss == 1 then
				var_96_0 = var_96_0 + 1
			end
		end

		arg_96_1:set_multiple_attr_value(var_96_0)

		return true
	end

	function arg_1_0:__onConditionFunc_opposite_no_flag(arg_97_1)
		local var_97_0 = self._battle_obj_mgr:get_ships_by_side(var_0_1.obj_side.opposite((arg_97_1:get_side())))

		if not var_97_0[1] then
			return false
		end

		if var_97_0[1]:get_is_alive() and not var_97_0[1]:is_submarine() then
			return true
		end

		return false
	end

	function arg_1_0:__onConditionFunc_opposite_has_alive_submarine(arg_98_1)
		for iter_98_0, iter_98_1 in pairs((self._battle_obj_mgr:get_ships_by_side(var_0_1.obj_side.opposite((arg_98_1:get_side()))))) do
			if iter_98_1:get_is_alive() and not iter_98_1:is_submarine() then
				return true
			end
		end

		return false
	end

	function arg_1_0:__onConditionFunc_radar_success(arg_99_1)
		if self._battle_scene:get_radar_state() and arg_99_1:get_side() == var_0_1.obj_side.player then
			return true
		end

		return false
	end

	function arg_1_0:__onConditionFunc_country_shipnum_greater_or_equal(arg_100_1, arg_100_2)
		return #self:__get_meet_country_data(self._battle_obj_mgr:get_ships_by_side(arg_100_1:get_side()), arg_100_2.country) >= arg_100_2.num
	end

	function arg_1_0:__onConditionFunc_country_shipnum_less(arg_101_1, arg_101_2)
		return #self:__get_meet_country_data(self._battle_obj_mgr:get_ships_by_side(arg_101_1:get_side()), arg_101_2.country) < arg_101_2.num
	end

	function arg_1_0:__onConditionFunc_no_ship_type_in_config_country_without_self(arg_102_1, arg_102_2)
		return #self:__get_meet_country_data(self._battle_obj_mgr:get_ships_by_side(arg_102_1:get_side()), arg_102_2.country) <= #self:__get_meet_country_data({
			arg_102_1
		}, arg_102_2.country)
	end

	function arg_1_0:__onConditionFunc_no_ship_type_in_config_shipCids_without_self(arg_103_1, arg_103_2)
		return #self:__get_meet_cardCids_data(self._battle_obj_mgr:get_ships_by_side(arg_103_1:get_side()), arg_103_2.shipCids) <= #self:__get_meet_cardCids_data({
			arg_103_1
		}, arg_103_2.shipCids)
	end

	function arg_1_0:__onConditionFunc_country_shipTypes_greater_or_equal(arg_104_1, arg_104_2)
		return #self:__get_meet_shipTypes_data(self._battle_obj_mgr:get_ships_by_side(arg_104_1:get_side()), arg_104_2.shipTypes, arg_104_2.country) >= arg_104_2.num
	end

	function arg_1_0:__onConditionFunc_country_shipTypes_less(arg_105_1, arg_105_2)
		return #self:__get_meet_shipTypes_data(self._battle_obj_mgr:get_ships_by_side(arg_105_1:get_side()), arg_105_2.shipTypes, arg_105_2.country) < arg_105_2.num
	end

	function arg_1_0:__onConditionFunc_more_effect_more_country_count_in_config(arg_106_1, arg_106_2)
		arg_106_1:set_skill_effect_count(#self:__get_meet_country_data(self._battle_obj_mgr:get_ships_by_side(self._owner:get_side()), arg_106_2.country))

		return true
	end

	function arg_1_0:__onConditionFunc_some_ship_country_is_flag(arg_107_1, arg_107_2)
		local var_107_0 = self._battle_obj_mgr:get_flag_ship(arg_107_1:get_side())

		for iter_107_0, iter_107_1 in pairs(arg_107_2.country) do
			if var_107_0:get_country() == iter_107_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__onConditionFunc_self_loss_hp_div_num_mul_effect_no_max(arg_108_1, arg_108_2)
		self._owner:set_multiple_attr_value((math.floor((arg_108_1._attribute.hp:get_final_value() - arg_108_1._attribute.now_hp:get_final_value()) / arg_108_2.num)))

		return true
	end

	function arg_1_0:__onConditionFunc_only_country_in_config(arg_109_1, arg_109_2)
		local var_109_0 = self._battle_obj_mgr:get_ships_by_side(arg_109_1:get_side())

		return #self:__get_meet_country_data(var_109_0, arg_109_2.country) == #var_109_0
	end

	function arg_1_0:__onConditionFunc_skill_type_nlt_num_in_config(arg_110_1, arg_110_2)
		return #self:__get_meet_skillTypes_data(self._battle_obj_mgr:get_ships_by_side(arg_110_1:get_side()), arg_110_2.skillTypes) >= arg_110_2.num
	end

	function arg_1_0.__number_to_table(arg_111_0, arg_111_1)
		local var_111_0 = {}

		if type(arg_111_1) == "number" then
			var_0_13(var_111_0, arg_111_1)

			return var_111_0
		end

		return arg_111_1
	end

	function arg_1_0:__get_meet_shipTypes_data(arg_112_1, arg_112_2, arg_112_3)
		arg_112_2 = self:__number_to_table(arg_112_2)
		arg_112_1 = self:__number_to_table(arg_112_1)

		local var_112_0 = {}

		if arg_112_3 then
			for iter_112_0, iter_112_1 in pairs(arg_112_1) do
				for iter_112_2, iter_112_3 in pairs(arg_112_2) do
					if iter_112_1:get_ship_type() == iter_112_3 and iter_112_1:get_country() == arg_112_3 then
						var_0_13(var_112_0, iter_112_1)

						break
					end
				end
			end
		else
			for iter_112_4, iter_112_5 in pairs(arg_112_1) do
				for iter_112_6, iter_112_7 in pairs(arg_112_2) do
					if iter_112_5:get_ship_type() == iter_112_7 then
						var_0_13(var_112_0, iter_112_5)

						break
					end
				end
			end
		end

		return var_112_0
	end

	function arg_1_0:__get_meet_skillTypes_data(arg_113_1, arg_113_2)
		arg_113_2 = self:__number_to_table(arg_113_2)

		local var_113_0 = {}

		for iter_113_0, iter_113_1 in pairs(arg_113_1) do
			local var_113_1 = var_0_15.find_object_by_skill_id(iter_113_1:get_skill())

			for iter_113_2, iter_113_3 in pairs(arg_113_2) do
				if var_113_1 and var_113_1.skill_type == iter_113_3 then
					var_0_13(var_113_0, iter_113_1)

					break
				end
			end
		end

		return var_113_0
	end

	function arg_1_0.__get_meet_cardCids_data(arg_114_0, arg_114_1, arg_114_2)
		local var_114_0 = {}

		for iter_114_0, iter_114_1 in pairs(arg_114_1) do
			for iter_114_2, iter_114_3 in pairs(arg_114_2) do
				if iter_114_1:get_cid() == iter_114_3 then
					var_0_13(var_114_0, iter_114_1)

					break
				end
			end
		end

		return var_114_0
	end

	function arg_1_0.__get_meet_shipTons_data(arg_115_0, arg_115_1, arg_115_2, arg_115_3)
		local var_115_0 = {}

		if arg_115_3 then
			for iter_115_0, iter_115_1 in pairs(arg_115_1) do
				for iter_115_2, iter_115_3 in pairs(arg_115_2) do
					if iter_115_1:get_ship_ton() == iter_115_3 and iter_115_1:get_country() == arg_115_3 then
						var_0_13(var_115_0, iter_115_1)

						break
					end
				end
			end
		else
			for iter_115_4, iter_115_5 in pairs(arg_115_1) do
				for iter_115_6, iter_115_7 in pairs(arg_115_2) do
					if iter_115_5:get_ship_ton() == iter_115_7 then
						var_0_13(var_115_0, iter_115_5)

						break
					end
				end
			end
		end

		return var_115_0
	end

	function arg_1_0.__get_meet_guardTypes_data(arg_116_0, arg_116_1, arg_116_2, arg_116_3)
		local var_116_0 = {}

		if arg_116_3 then
			for iter_116_0, iter_116_1 in pairs(arg_116_1) do
				for iter_116_2, iter_116_3 in pairs(arg_116_2) do
					if iter_116_1:get_ship_guard_type() == iter_116_3 and iter_116_1:get_country() == arg_116_3 then
						var_0_13(var_116_0, iter_116_1)

						break
					end
				end
			end
		else
			for iter_116_4, iter_116_5 in pairs(arg_116_1) do
				for iter_116_6, iter_116_7 in pairs(arg_116_2) do
					if iter_116_5:get_ship_guard_type() == iter_116_7 then
						var_0_13(var_116_0, iter_116_5)

						break
					end
				end
			end
		end

		return var_116_0
	end

	function arg_1_0.__get_meet_country_data(arg_117_0, arg_117_1, arg_117_2)
		local var_117_0 = {}
		local var_117_1 = {}

		if arg_117_2 then
			for iter_117_0, iter_117_1 in pairs(arg_117_1) do
				var_0_13(var_117_1, iter_117_1:get_country())
			end

			for iter_117_2, iter_117_3 in pairs(var_117_1) do
				for iter_117_4, iter_117_5 in pairs(arg_117_2) do
					if iter_117_3 == iter_117_5 then
						var_0_13(var_117_0, iter_117_3)
					end
				end
			end
		end

		return var_117_0
	end
end

function var_0_0.extend_obj(arg_118_0)
	return
end

return var_0_0
