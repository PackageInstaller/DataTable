local var_0_0 = {}
local var_0_1 = gameenum.battle_type
local var_0_2 = gamecore.battle_util
local var_0_3 = table.insert
local var_0_5 = gameconfig.ship_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__on_func_all_ship_add_attr(arg_2_1, arg_2_2, arg_2_3)
		if arg_2_3 then
			return
		end

		self:__update_ship_attr_by_effect(arg_2_1, false, false, arg_2_2)
	end

	function arg_1_0:__on_func_all_ship_del_attr(arg_3_1, arg_3_2, arg_3_3)
		if arg_3_3 then
			return
		end

		self:__update_ship_attr_by_effect(arg_3_1, false, true, arg_3_2)
	end

	function arg_1_0:__on_func_add_attr_by_ship_type(arg_4_1, arg_4_2, arg_4_3)
		if arg_4_3 then
			return
		end

		self:__update_ship_attr_by_effect(arg_4_1, false, false, arg_4_2)
	end

	function arg_1_0:__on_func_del_attr_by_ship_type(arg_5_1, arg_5_2, arg_5_3)
		if arg_5_3 then
			return
		end

		self:__update_ship_attr_by_effect(arg_5_1, false, true, arg_5_2)
	end

	function arg_1_0:__on_func_add_attr_by_country(arg_6_1, arg_6_2, arg_6_3)
		if arg_6_3 then
			return
		end

		self:__update_ship_attr_by_effect(arg_6_1, false, false, arg_6_2)
	end

	function arg_1_0:__on_func_del_attr_by_country(arg_7_1, arg_7_2, arg_7_3)
		if arg_7_3 then
			return
		end

		self:__update_ship_attr_by_effect(arg_7_1, false, true, arg_7_2)
	end

	function arg_1_0:__on_func_add_attr_by_have_ship_type(arg_8_1, arg_8_2, arg_8_3)
		if not arg_8_3 then
			return
		end

		if #self:__get_ship_hit_state_by_effect(arg_8_1) > 0 then
			if not arg_8_2:get_attribute().is_add_attr_by_have_ship_type then
				var_0_2:modify_attr_value(arg_8_2, var_0_1.skil_attribute_type[arg_8_1.num4], arg_8_1.num, false)
			end

			arg_8_2:get_attribute().is_add_attr_by_have_ship_type = true
		end
	end

	function arg_1_0:__on_func_can_be_open_torpedo(arg_9_1, arg_9_2, arg_9_3)
		if arg_9_3 then
			return
		end

		for iter_9_0, iter_9_1 in pairs((self:__get_ship_hit_state_by_effect(arg_9_1, arg_9_2))) do
			self._battle_obj_mgr:findObject(iter_9_1):set_unlock_open_torpedo_attack(true)
		end
	end

	function arg_1_0:__on_func_sure_to_crit_by_ship_type(arg_10_1, arg_10_2, arg_10_3)
		if arg_10_3 then
			return
		end

		for iter_10_0, iter_10_1 in pairs((self:__get_ship_hit_state_by_effect(arg_10_1, arg_10_2))) do
			self._battle_obj_mgr:findObject(iter_10_1):get_attribute().sure_to_crit_by_stage = arg_10_1.num4
		end
	end

	function arg_1_0:__on_func_one_more_attack_in_kill_ship(arg_11_1, arg_11_2, arg_11_3)
		if arg_11_3 then
			return
		end

		for iter_11_0, iter_11_1 in pairs((self:__get_ship_hit_state_by_effect(arg_11_1, arg_11_2))) do
			self._battle_obj_mgr:findObject(iter_11_1):get_attribute().one_more_attack_in_kill_ship = true
		end
	end

	function arg_1_0:__on_func_back_attack(arg_12_1, arg_12_2, arg_12_3)
		if arg_12_3 then
			return
		end

		for iter_12_0, iter_12_1 in pairs((self:__get_ship_hit_state_by_effect(arg_12_1, arg_12_2))) do
			self._battle_obj_mgr:findObject(iter_12_1):set_num_of_beat_back(99)
		end
	end

	function arg_1_0:__on_func_back_attack_wihtout_hurt(arg_13_1, arg_13_2, arg_13_3)
		if arg_13_3 then
			return
		end

		for iter_13_0, iter_13_1 in pairs((self:__get_ship_hit_state_by_effect(arg_13_1, arg_13_2))) do
			self._battle_obj_mgr:findObject(iter_13_1):set_num_of_beat_back_wihtout_hp_state()
		end
	end

	function arg_1_0:__on_func_can_attack_in_borken(arg_14_1, arg_14_2, arg_14_3)
		local var_14_0

		if arg_14_3 then
			do return end

			var_14_0 = {}
		end

		var_14_0.ship_list = self:__get_ship_hit_state_by_effect(arg_14_1)

		self._battle_scene:set_attend_fight_by_broken(var_14_0)
	end

	function arg_1_0:__on_func_any_formation_can_antisub(arg_15_1, arg_15_2, arg_15_3)
		local var_15_0

		if arg_15_3 then
			do return end

			var_15_0 = {}
		end

		var_15_0.ship_list = self:__get_ship_hit_state_by_effect(arg_15_1)

		self._battle_scene:set_open_antisub(var_15_0)
	end

	function arg_1_0:__on_func_change_range_by_ship_type(arg_16_1, arg_16_2, arg_16_3)
		if arg_16_3 then
			return
		end

		for iter_16_0, iter_16_1 in pairs((self:__get_ship_hit_state_by_effect(arg_16_1, arg_16_2))) do
			var_0_2:modify_attr_value(self._battle_obj_mgr:findObject(iter_16_1), "range", arg_16_1.num, true)
		end
	end

	function arg_1_0:__on_func_can_night_fight_by_ship_type(arg_17_1, arg_17_2, arg_17_3)
		local var_17_0

		if arg_17_3 then
			do return end

			var_17_0 = {}
		end

		var_17_0.ship_list = self:__get_ship_hit_state_by_effect(arg_17_1)

		self._battle_scene:set_attend_night_fight_ship(var_17_0)
	end

	function arg_1_0:__on_func_seckill_by_not_flage(arg_18_1, arg_18_2, arg_18_3)
		local var_18_0

		if arg_18_3 then
			do return end

			var_18_0 = {}
		end

		var_18_0.ship_list = self:__get_ship_hit_state_by_effect(arg_18_1)
		var_18_0.rate = arg_18_1.num / 100

		self._battle_scene:set_kill_not_flag_target_immediate_data(var_18_0)
	end

	function arg_1_0:__on_func_open_airattack_damage_up(arg_19_1, arg_19_2, arg_19_3)
		if arg_19_3 then
			return
		end

		arg_19_1.shipTypes = {
			1
		}

		self._battle_scene:set_open_airattack_damage_up_data({
			ship_list = self:__get_ship_hit_state_by_effect(arg_19_1),
			stage = var_0_1.trigger_type.air_attack,
			rate = arg_19_1.num / 100,
			airplane_type = arg_19_1.num5
		})
	end

	function arg_1_0:__on_func_limited_attack_by_flag(arg_20_1, arg_20_2, arg_20_3)
		if arg_20_3 then
			return
		end

		for iter_20_0, iter_20_1 in pairs((self:__get_ship_hit_state_by_effect(arg_20_1, arg_20_2))) do
			self._battle_obj_mgr:findObject(iter_20_1):get_attribute().limited_attack_by_flag = true
		end
	end

	function arg_1_0:__on_func_limited_attack_by_not_flag(arg_21_1, arg_21_2, arg_21_3)
		if arg_21_3 then
			return
		end

		for iter_21_0, iter_21_1 in pairs((self:__get_ship_hit_state_by_effect(arg_21_1, arg_21_2))) do
			self._battle_obj_mgr:findObject(iter_21_1):get_attribute().limited_attack_by_not_flag = true
		end
	end

	function arg_1_0:__on_func_miss_attack_by_ship_type(arg_22_1, arg_22_2, arg_22_3)
		local var_22_0

		if arg_22_3 then
			do return end

			var_22_0 = {}
		end

		var_22_0.ship_list = self:__get_ship_hit_state_by_effect(arg_22_1)
		var_22_0.num = arg_22_1.num / 100

		self._battle_scene:set_evade_hit_data(var_22_0)
	end

	function arg_1_0:__on_func_del_damage_by_stage(arg_23_1, arg_23_2, arg_23_3)
		if arg_23_3 then
			return
		end

		self._battle_scene:set_team_reduce_hit_data({
			stage_list = arg_23_1.num4,
			hit_rate = -arg_23_1.num / 100
		})
	end

	function arg_1_0:__on_func_del_damage_by_num(arg_24_1, arg_24_2, arg_24_3)
		if arg_24_3 then
			return
		end

		self._battle_scene:set_team_all_reduce_hit_data({
			hit_rate = -arg_24_1.num
		})
	end

	function arg_1_0:__on_func_immune_damage_in_first_hit(arg_25_1, arg_25_2, arg_25_3)
		if arg_25_3 then
			return
		end

		for iter_25_0, iter_25_1 in pairs((self:__get_ship_hit_state_by_effect(arg_25_1, arg_25_2))) do
			local var_25_0 = self._battle_obj_mgr:findObject(iter_25_1)

			var_25_0:get_attribute().skill_num = var_25_0:get_attribute().skill_num or {}
			var_25_0:get_attribute()._is_immune_to_first_damage = true
			var_25_0:get_attribute().skill_num._is_immune_to_first_damage = 2
		end
	end

	function arg_1_0:__on_func_can_be_hurt_by_range(arg_26_1, arg_26_2, arg_26_3)
		local var_26_0

		if arg_26_3 then
			do return end

			var_26_0 = {
				stage_list = 5
			}
		end

		var_26_0.ship_list = self:__get_ship_hit_state_by_effect(arg_26_1)
		var_26_0.num = arg_26_1.num

		self._battle_scene:set_ship_range_limit_data(var_26_0)
	end

	function arg_1_0:__on_func_del_attack_weight_in_flage(arg_27_1, arg_27_2, arg_27_3)
		if arg_27_3 then
			return
		end

		for iter_27_0, iter_27_1 in pairs((self:__get_ship_hit_state_by_effect(arg_27_1, arg_27_2))) do
			local var_27_0 = self._battle_obj_mgr:findObject(iter_27_1)

			if var_27_0:is_flag() then
				var_27_0:get_attribute().atked_weight = -arg_27_1.num / 100
			end
		end
	end

	function arg_1_0.__on_func_can_support_in_boss_point(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
		return
	end

	function arg_1_0:__on_func_can_be_hurt_by_range_by_is_boss(arg_29_1, arg_29_2, arg_29_3)
		if arg_29_3 then
			return
		end

		local var_29_0 = {}

		for iter_29_0, iter_29_1 in pairs((self:__get_ship_hit_state_by_effect(arg_29_1))) do
			local var_29_1 = var_0_5.find_object_by_cid(self._battle_obj_mgr:findObject(iter_29_1):get_cid())

			if var_29_1 and var_29_1.boss == arg_29_1.num5 then
				table.insert(var_29_0, iter_29_1)
			end
		end

		self._battle_scene:set_ship_range_limit_data({
			stage_list = 5,
			ship_list = var_29_0,
			num = arg_29_1.num
		})
	end

	function arg_1_0.__on_func_add_auxiliary_calculus_value(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
		if arg_30_3 then
			return
		end
	end

	function arg_1_0:__on_func_add_attr_by_is_boss(arg_31_1, arg_31_2, arg_31_3)
		if arg_31_3 then
			return
		end

		for iter_31_0, iter_31_1 in pairs((self:__get_ship_hit_state_by_effect(arg_31_1, arg_31_2))) do
			local var_31_0 = self._battle_obj_mgr:findObject(iter_31_1)
			local var_31_1 = var_0_5.find_object_by_cid(var_31_0:get_cid())

			if var_31_1 and var_31_1.boss == arg_31_1.num5 then
				self:__update_ship_attr_by_effect(arg_31_1, false, false, var_31_0)
			end
		end
	end

	function arg_1_0:__on_func_del_attr_by_is_boss(arg_32_1, arg_32_2, arg_32_3)
		if arg_32_3 then
			return
		end

		for iter_32_0, iter_32_1 in pairs((self:__get_ship_hit_state_by_effect(arg_32_1, arg_32_2))) do
			local var_32_0 = self._battle_obj_mgr:findObject(iter_32_1)
			local var_32_1 = var_0_5.find_object_by_cid(var_32_0:get_cid())

			if var_32_1 and var_32_1.boss == arg_32_1.num5 then
				self:__update_ship_attr_by_effect(arg_32_1, false, true, var_32_0)
			end
		end
	end

	function arg_1_0:__on_func_add_damage_by_flag(arg_33_1, arg_33_2, arg_33_3)
		local var_33_0

		if arg_33_3 then
			do return end

			var_33_0 = {
				is_flag = true
			}
		end

		var_33_0.ship_list = self:__get_ship_hit_state_by_effect(arg_33_1, ship)
		var_33_0.num = arg_33_1.num / 100

		self._battle_scene:set_abyss_add_damage_by_flag_data(var_33_0)
	end

	function arg_1_0:__on_func_del_damage_by_not_flag(arg_34_1, arg_34_2, arg_34_3)
		local var_34_0

		if arg_34_3 then
			do return end

			var_34_0 = {
				is_flag = false
			}
		end

		var_34_0.ship_list = self:__get_ship_hit_state_by_effect(arg_34_1, ship)
		var_34_0.num = arg_34_1.num / 100

		self._battle_scene:set_abyss_add_damage_by_flag_data(var_34_0)
	end

	function arg_1_0:__get_ship_hit_state_by_effect(arg_35_1, arg_35_2)
		local var_35_0
		local var_35_1
		local var_35_2
		local var_35_3

		for iter_35_0, iter_35_1 in pairs(arg_35_1) do
			if iter_35_0 == "country" then
				var_35_0 = iter_35_1
			elseif iter_35_0 == "shipType" or iter_35_0 == "shipTypes" then
				var_35_1 = iter_35_1
			elseif iter_35_0 == "shipTon" or iter_35_0 == "shipTons" then
				var_35_2 = iter_35_1
			elseif iter_35_0 == "guardType" or iter_35_0 == "guardTypes" then
				var_35_3 = iter_35_1
			end
		end

		local var_35_4 = {}
		local var_35_5 = {}

		if not arg_35_2 then
			var_35_5 = self._battle_obj_mgr:get_ships_by_side(var_0_1.obj_side.player)
		else
			table.insert(var_35_5, arg_35_2)
		end

		for iter_35_2, iter_35_3 in pairs(var_35_5) do
			if var_35_0 then
				if self:__get_ship_data_by_countrys(iter_35_3, var_35_0) and self:__get_ship_data_by_screen(iter_35_3, var_35_1, var_35_2, var_35_3) then
					var_0_3(var_35_4, iter_35_3:getID())
				end
			elseif self:__get_ship_data_by_screen(iter_35_3, var_35_1, var_35_2, var_35_3) then
				var_0_3(var_35_4, iter_35_3:getID())
			end
		end

		return var_35_4
	end

	function arg_1_0:__update_ship_attr_by_effect(arg_36_1, arg_36_2, arg_36_3, arg_36_4)
		local var_36_0 = {}

		table.insert(var_36_0, arg_36_4)

		local var_36_1
		local var_36_2
		local var_36_3
		local var_36_4

		for iter_36_0, iter_36_1 in pairs(arg_36_1) do
			if iter_36_0 == "country" then
				var_36_1 = iter_36_1
			elseif iter_36_0 == "shipType" or iter_36_0 == "shipTypes" then
				var_36_2 = iter_36_1
			elseif iter_36_0 == "shipTon" or iter_36_0 == "shipTons" then
				var_36_3 = iter_36_1
			elseif iter_36_0 == "guardType" or iter_36_0 == "guardTypes" then
				var_36_4 = iter_36_1
			end
		end

		local var_36_5 = var_0_1.skil_attribute_type[arg_36_1.num4]
		local var_36_6 = arg_36_1.num

		if arg_36_3 then
			var_36_6 = -var_36_6
		end

		for iter_36_2, iter_36_3 in pairs(var_36_0) do
			if var_36_1 then
				if self:__get_ship_data_by_countrys(iter_36_3, var_36_1) and self:__get_ship_data_by_screen(iter_36_3, var_36_2, var_36_3, var_36_4) then
					var_0_2:update_target_attr(iter_36_3, var_36_5, var_36_6, arg_36_2)

					if var_36_5 == "air_def" then
						var_0_2:update_target_attr(iter_36_3, "ship_air_def", var_36_6, arg_36_2)
					end

					if var_36_5 == "atk" then
						var_0_2:update_target_attr(iter_36_3, "ship_atk", var_36_6, arg_36_2)
					end
				end
			elseif self:__get_ship_data_by_screen(iter_36_3, var_36_2, var_36_3, var_36_4) then
				var_0_2:update_target_attr(iter_36_3, var_36_5, var_36_6, arg_36_2)

				if var_36_5 == "air_def" then
					var_0_2:update_target_attr(iter_36_3, "ship_air_def", var_36_6, arg_36_2)
				end

				if var_36_5 == "atk" then
					var_0_2:update_target_attr(iter_36_3, "ship_atk", var_36_6, arg_36_2)
				end
			end

			if var_36_5 == "hp" then
				iter_36_3.now_hp:modify_to_value(iter_36_3.hp:get_final_value())
			end
		end
	end

	function arg_1_0.__number_to_table(arg_37_0, arg_37_1)
		local var_37_0 = {}

		if type(arg_37_1) == "number" then
			var_0_3(var_37_0, arg_37_1)

			return var_37_0
		end

		return arg_37_1
	end

	function arg_1_0:__get_ship_data_by_countrys(arg_38_1, arg_38_2)
		arg_38_2 = self:__number_to_table(arg_38_2)

		for iter_38_0, iter_38_1 in pairs(arg_38_2) do
			if arg_38_1:get_country() == iter_38_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_types(arg_39_1, arg_39_2)
		arg_39_2 = self:__number_to_table(arg_39_2)

		for iter_39_0, iter_39_1 in pairs(arg_39_2) do
			if arg_39_1:get_ship_type() == iter_39_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_tons(arg_40_1, arg_40_2)
		arg_40_2 = self:__number_to_table(arg_40_2)

		for iter_40_0, iter_40_1 in pairs(arg_40_2) do
			if arg_40_1:get_ship_ton() == iter_40_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_guards(arg_41_1, arg_41_2)
		arg_41_2 = self:__number_to_table(arg_41_2)

		for iter_41_0, iter_41_1 in pairs(arg_41_2) do
			if arg_41_1:get_ship_guard_type() == iter_41_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_screen(arg_42_1, arg_42_2, arg_42_3, arg_42_4)
		if arg_42_2 then
			if self:__get_ship_data_by_types(arg_42_1, arg_42_2) then
				return self:__get_target_by_ship_ton(arg_42_1, arg_42_3, arg_42_4)
			end
		elseif arg_42_3 then
			return self:__get_target_by_ship_ton(arg_42_1, arg_42_3, arg_42_4)
		elseif arg_42_4 then
			return self:__get_ship_data_by_guards(arg_42_1, arg_42_4)
		else
			return true
		end
	end

	function arg_1_0:__get_target_by_ship_ton(arg_43_1, arg_43_2, arg_43_3)
		if arg_43_2 then
			if self:__get_ship_data_by_tons(arg_43_1, arg_43_2) then
				return self:__get_target_by_ship_guard(arg_43_1, arg_43_3)
			else
				return false
			end
		else
			return self:__get_target_by_ship_guard(arg_43_1, arg_43_3)
		end
	end

	function arg_1_0:__get_target_by_ship_guard(arg_44_1, arg_44_2)
		if arg_44_2 then
			if self:__get_ship_data_by_guards(arg_44_1, arg_44_2) then
				return true
			else
				return false
			end
		else
			return true
		end
	end
end

function var_0_0.extend_obj(arg_45_0)
	return
end

return var_0_0
