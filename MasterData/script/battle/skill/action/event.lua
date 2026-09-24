local var_0_0 = {}
local var_0_1 = gameenum.battle_type
local var_0_2 = table.insert
local var_0_3 = gamecore.battle_util

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.__onActionFunc_no_crit(arg_2_0, arg_2_1, arg_2_2)
		arg_2_2:get_attribute().not_crit = true
	end

	function arg_1_0:__onActionFunc_replace_target_damage(arg_3_1, arg_3_2)
		self._owner:get_attribute().skill_num = self._owner:get_attribute().skill_num or {}
		self._owner:get_attribute().skill_num.guardian = self._owner:get_attribute().skill_num.guardian or {}
		self._owner:get_attribute().skill_num.guardian.rate = arg_3_1.rate
		self._owner:get_attribute().skill_num.guardian.crited = arg_3_1.crited
		self._owner:get_attribute().skill_num.guardian.num = self._owner:get_attribute().skill_num.guardian.num or arg_3_1.num

		if self._owner:getID() ~= arg_3_2:getID() then
			arg_3_2:get_attribute().replace_target_damage = arg_3_2:get_attribute().replace_target_damage or {}
			arg_3_2:get_attribute().replace_target_damage[self._owner:get_index()] = self._owner:getID()
		end
	end

	function arg_1_0:__onActionFunc_modify_attribute(arg_4_1, arg_4_2)
		arg_4_2:get_attribute().change_attr = arg_4_2:get_attribute().change_attr or {}

		for iter_4_0, iter_4_1 in pairs(arg_4_1) do
			if iter_4_0 ~= "type" and iter_4_0 ~= "skill_type" then
				local var_4_0 = arg_4_2:get_attribute()[iter_4_0]:get_final_value()

				if iter_4_0 ~= "hp" then
					var_0_3:multiple_attr_value(arg_4_2, iter_4_0, iter_4_1, self._owner)
				end

				if iter_4_0 == "air_def" then
					var_0_3:multiple_attr_value(arg_4_2, "ship_air_def", iter_4_1, self._owner)
				end

				if iter_4_0 == "atk" then
					var_0_3:multiple_attr_value(arg_4_2, "ship_atk", iter_4_1, self._owner)
				end

				if arg_4_1.skill_type then
					arg_4_2:get_attribute().modify_attribute_change_value = arg_4_2:get_attribute().modify_attribute_change_value or {}

					local var_4_2 = {
						level = arg_4_1.skill_type[2],
						attr_type = iter_4_0,
						attr_num = iter_4_1 * self._owner._multiple_attr_value
					}

					for iter_4_2, iter_4_3 in pairs(arg_4_2:get_attribute().modify_attribute_change_value) do
						if iter_4_2 == arg_4_1.skill_type[1] and iter_4_3.level < arg_4_1.skill_type[2] then
							arg_4_2:get_attribute()[iter_4_3.attr_type]:modify_to_value(arg_4_2:get_attribute()[iter_4_3.attr_type]:get_final_value() - iter_4_3.attr_num + iter_4_1 * self._owner._multiple_attr_value)

							arg_4_2:get_attribute().modify_attribute_change_value[arg_4_1.skill_type[1]] = var_4_2
						end
					end
				end

				if arg_4_2:get_attribute()[iter_4_0]:get_final_value() < 0 then
					arg_4_2:get_attribute()[iter_4_0]:modify_to_value(0)
				end

				local var_4_4 = {
					desc = iter_4_0 .. "变化固定值" .. iter_4_1 * self._owner._multiple_attr_value,
					before = var_4_0
				}

				var_4_4.after = arg_4_2:get_attribute()[iter_4_0]:get_final_value()
				var_4_4.attr_type = iter_4_0

				table.insert(arg_4_2:get_attribute().change_attr, var_4_4)
			end
		end
	end

	function arg_1_0:__onActionFunc_modify_attribute_percent(arg_5_1, arg_5_2)
		arg_5_2:get_attribute().change_attr = arg_5_2:get_attribute().change_attr or {}

		for iter_5_0, iter_5_1 in pairs(arg_5_1) do
			if iter_5_0 ~= "type" then
				local var_5_0 = arg_5_2:get_attribute()[iter_5_0]:get_final_value()
				local var_5_1 = math.ceil(arg_5_2:get_attribute()[iter_5_0]:get_final_value() * iter_5_1)

				if iter_5_0 == "torpedo" then
					var_5_1 = math.ceil(var_5_1)
				end

				if iter_5_0 == "crit_repair" then
					var_5_1 = arg_5_2:get_attribute()[iter_5_0]:get_final_value() + iter_5_1 * 100 * self._owner._multiple_attr_value

					arg_5_2:get_attribute()[iter_5_0]:modify_to_value(var_5_1)
				elseif iter_5_0 == "air_def" then
					var_0_3:multiple_attr_value(arg_5_2, "ship_air_def", var_5_1, self._owner)
				elseif iter_5_0 == "atk" then
					var_0_3:multiple_attr_value(arg_5_2, "ship_atk", var_5_1, self._owner)
				end

				if iter_5_0 ~= "crit_repair" then
					var_0_3:multiple_attr_value(arg_5_2, iter_5_0, var_5_1, self._owner)
				end

				local var_5_2 = {
					desc = iter_5_0 .. "变化百分之" .. iter_5_1 * 100 * self._owner._multiple_attr_value .. "（暴击百分比按加法算)",
					before = var_5_0
				}

				var_5_2.after = arg_5_2:get_attribute()[iter_5_0]:get_final_value()
				var_5_2.attr_type = iter_5_0

				table.insert(arg_5_2:get_attribute().change_attr, var_5_2)

				if iter_5_0 == "torpedo" then
					local var_5_3 = {
						attr_type = "pre_torpedo",
						desc = "裸装鱼雷变化百分之" .. iter_5_1 * 100 * self._owner._multiple_attr_value .. "（暴击百分比按加法算)",
						before = var_5_0
					}

					var_5_3.after = arg_5_2:get_attribute().pre_torpedo:get_final_value()

					table.insert(arg_5_2:get_attribute().change_attr, var_5_3)
				elseif iter_5_0 == "air_def" then
					local var_5_4 = {
						attr_type = "ship_air_def",
						desc = "裸装对空变化百分之" .. iter_5_1 * 100 * self._owner._multiple_attr_value .. "（暴击百分比按加法算)",
						before = var_5_0
					}

					var_5_4.after = arg_5_2:get_attribute().ship_air_def:get_final_value()

					table.insert(arg_5_2:get_attribute().change_attr, var_5_4)
				end
			end
		end
	end

	function arg_1_0.__onActionFunc_modify_other_attribute_percent(arg_6_0, arg_6_1, arg_6_2)
		arg_6_2:get_attribute().change_attr = arg_6_2:get_attribute().change_attr or {}

		local var_6_0 = arg_6_2:get_attribute()[var_0_1.skil_attribute_type[arg_6_1.attribute]]:get_final_value() * arg_6_1.rate

		if var_0_1.skil_attribute_type[arg_6_1.attribute2] ~= "crit_repair" and var_0_1.skil_attribute_type[arg_6_1.attribute2] ~= "hit_repair" and var_0_1.skil_attribute_type[arg_6_1.attribute2] ~= "miss_repair" then
			var_6_0 = math.ceil(var_6_0)
		end

		arg_6_2:get_attribute()[var_0_1.skil_attribute_type[arg_6_1.attribute2]]:modify_to_value(arg_6_2:get_attribute()[var_0_1.skil_attribute_type[arg_6_1.attribute2]]:get_final_value() + var_6_0)

		local var_6_1 = {
			desc = var_0_1.skil_attribute_type[arg_6_1.attribute2] .. "变化" .. var_0_1.skil_attribute_type[arg_6_1.attribute] .. "的百分之" .. arg_6_1.rate * 100,
			before = arg_6_2:get_attribute()[var_0_1.skil_attribute_type[arg_6_1.attribute2]]:get_final_value()
		}

		var_6_1.after = arg_6_2:get_attribute()[var_0_1.skil_attribute_type[arg_6_1.attribute2]]:get_final_value()
		var_6_1.attr_type = var_0_1.skil_attribute_type[arg_6_1.attribute2]

		table.insert(arg_6_2:get_attribute().change_attr, var_6_1)
	end

	function arg_1_0.__onActionFunc_modify_attribute_to_zero(arg_7_0, arg_7_1, arg_7_2)
		arg_7_2:get_attribute().change_attr = arg_7_2:get_attribute().change_attr or {}

		arg_7_2:get_attribute()[var_0_1.skil_attribute_type[arg_7_1.attribute]]:modify_to_value(0)

		local var_7_0 = {
			desc = var_0_1.skil_attribute_type[arg_7_1.attribute] .. "被归零了",
			before = arg_7_2:get_attribute()[var_0_1.skil_attribute_type[arg_7_1.attribute]]:get_final_value()
		}

		var_7_0.after = arg_7_2:get_attribute()[var_0_1.skil_attribute_type[arg_7_1.attribute]]:get_final_value()
		var_7_0.attr_type = var_0_1.skil_attribute_type[arg_7_1.attribute]

		table.insert(arg_7_2:get_attribute().change_attr, var_7_0)
	end

	function arg_1_0.__onActionFunc_modify_by_loss_hp_to_attribute_percent(arg_8_0, arg_8_1, arg_8_2)
		arg_8_2:get_attribute().change_attr = arg_8_2:get_attribute().change_attr or {}

		local var_8_0 = arg_8_2:get_attribute().hp

		arg_8_2:get_attribute()[var_0_1.skil_attribute_type[arg_8_1.attribute]]:modify_to_value(arg_8_2:get_attribute()[var_0_1.skil_attribute_type[arg_8_1.attribute]].get_final_value(var_8_0) + math.ceil((var_8_0:get_final_value() - arg_8_2:get_attribute().now_hp:get_final_value()) * arg_8_1.rate))

		local var_8_1 = {
			desc = var_0_1.skil_attribute_type[arg_8_1.attribute] .. "提升了已损失血量的百分之" .. arg_8_1.rate * 100,
			before = arg_8_2:get_attribute()[var_0_1.skil_attribute_type[arg_8_1.attribute]]:get_final_value()
		}

		var_8_1.after = arg_8_2:get_attribute()[var_0_1.skil_attribute_type[arg_8_1.attribute]]:get_final_value()
		var_8_1.attr_type = var_0_1.skil_attribute_type[arg_8_1.attribute]

		table.insert(arg_8_2:get_attribute().change_attr, var_8_1)
	end

	function arg_1_0.__onActionFunc_ridicule_by_ship_type(arg_9_0, arg_9_1, arg_9_2)
		arg_9_2:get_attribute().ridicule = {}
		arg_9_2:get_attribute().ridicule.shipTypes = arg_9_1.shipTypes
		arg_9_2:get_attribute().ridicule.atked_weight = arg_9_1.atked_weight / 100
	end

	function arg_1_0:__onActionFunc_sure_to_hit(arg_10_1, arg_10_2)
		self._owner:get_attribute().skill_num = self._owner:get_attribute().skill_num or {}
		self._owner:get_attribute().sure_to_hit = true
		self._owner:get_attribute().skill_num.sure_to_hit = self._owner:get_attribute().skill_num.sure_to_hit or arg_10_1.num
	end

	function arg_1_0:__onActionFunc_sure_to_crit(arg_11_1, arg_11_2)
		self._owner:get_attribute().sure_to_crit = true
	end

	function arg_1_0.__onActionFunc_hit_by_hp_percent(arg_12_0, arg_12_1, arg_12_2)
		arg_12_2:get_attribute().hit_by_hp_percent = {
			rate = arg_12_1.rate,
			max_damage = arg_12_1.max_damage
		}
	end

	function arg_1_0.__onActionFunc_hit_by_other_demage(arg_13_0, arg_13_1, arg_13_2)
		arg_13_2:get_attribute().hit_by_other_demage = {
			rate = arg_13_1.rate,
			attribute = var_0_1.skil_attribute_type[arg_13_1.attribute]
		}
	end

	function arg_1_0.__onActionFunc_hit_by_fixed_demage(arg_14_0, arg_14_1, arg_14_2)
		arg_14_2:get_attribute().hit_by_fixed_demage = {
			rate = arg_14_1.rate,
			attribute = var_0_1.skil_attribute_type[arg_14_1.attribute]
		}
	end

	function arg_1_0.__onActionFunc_dec_target_attribute(arg_15_0, arg_15_1, arg_15_2)
		local var_15_0
		local var_15_1

		for iter_15_0, iter_15_1 in pairs(arg_15_1) do
			for iter_15_2, iter_15_3 in pairs(var_0_1.skil_attribute_type) do
				if iter_15_0 == iter_15_3 then
					var_15_0 = iter_15_0
					var_15_1 = iter_15_1

					break
				end
			end
		end

		if arg_15_2:get_attribute().dec_target_attribute then
			arg_15_2:get_attribute().dec_target_attribute[#arg_15_2:get_attribute().dec_target_attribute + 1] = {
				shipTypes = arg_15_1.shipTypes,
				shipTons = arg_15_1.shipTons,
				attr_type = var_15_0,
				attr_num = var_15_1,
				effect_stage = arg_15_1.effect_stage,
				unique = arg_15_1.unique
			}
		else
			arg_15_2:get_attribute().dec_target_attribute = {}
			arg_15_2:get_attribute().dec_target_attribute[1] = {
				shipTypes = arg_15_1.shipTypes,
				shipTons = arg_15_1.shipTons,
				attr_type = var_15_0,
				attr_num = var_15_1,
				effect_stage = arg_15_1.effect_stage,
				unique = arg_15_1.unique
			}
		end
	end

	function arg_1_0.__onActionFunc_dec_target_attribute_percent(arg_16_0, arg_16_1, arg_16_2)
		local var_16_0
		local var_16_1

		for iter_16_0, iter_16_1 in pairs(arg_16_1) do
			for iter_16_2, iter_16_3 in pairs(var_0_1.skil_attribute_type) do
				if iter_16_0 == iter_16_3 then
					var_16_0 = iter_16_0
					var_16_1 = iter_16_1

					break
				end
			end
		end

		if arg_16_2:get_attribute().dec_target_attribute then
			arg_16_2:get_attribute().dec_target_attribute[#arg_16_2:get_attribute().dec_target_attribute + 1] = {
				percent = true,
				shipTypes = arg_16_1.shipTypes,
				shipTons = arg_16_1.shipTons,
				attr_type = var_16_0,
				attr_num = var_16_1,
				effect_stage = arg_16_1.effect_stage,
				unique = arg_16_1.unique
			}
		else
			arg_16_2:get_attribute().dec_target_attribute = {}
			arg_16_2:get_attribute().dec_target_attribute[1] = {
				percent = true,
				shipTypes = arg_16_1.shipTypes,
				shipTons = arg_16_1.shipTons,
				attr_type = var_16_0,
				attr_num = var_16_1,
				effect_stage = arg_16_1.effect_stage,
				unique = arg_16_1.unique
			}
		end
	end

	function arg_1_0.__onActionFunc_hit_complex_target(arg_17_0, arg_17_1, arg_17_2)
		arg_17_2:get_attribute().hit_complex_target = {
			num = arg_17_1.num,
			num2 = arg_17_1.num2,
			hurt_rates = arg_17_1.hurt_rates
		}
		arg_17_2:get_attribute().skill_num = arg_17_2:get_attribute().skill_num or {}
		arg_17_2:get_attribute().skill_num.save_hit_complex_sub_target = arg_17_2:get_attribute().skill_num.save_hit_complex_sub_target or {}

		if not arg_17_2:get_attribute().skill_num.save_hit_complex_sub_target or not next(arg_17_2:get_attribute().skill_num.save_hit_complex_sub_target) then
			arg_17_2:get_attribute().skill_num.save_hit_complex_sub_target = {
				use_attack = false,
				mixattack = false
			}
		end
	end

	function arg_1_0.__onActionFunc_hit_adjacent_complex_target(arg_18_0, arg_18_1, arg_18_2)
		arg_18_2:get_attribute().hit_adjacent_complex_target = {
			num = arg_18_1.num,
			hurt_rates = arg_18_1.hurt_rates
		}
	end

	function arg_1_0.__onActionFunc_double_hit(arg_19_0, arg_19_1, arg_19_2)
		arg_19_2:get_attribute().double_hit = {
			hurt_rates = arg_19_1.hurt_rates
		}
	end

	function arg_1_0.__onActionFunc_dec_hit_by_type(arg_20_0, arg_20_1, arg_20_2)
		arg_20_2:get_attribute().dec_hit_by_type = {
			atkType = arg_20_1.atkType,
			hurt_rate = arg_20_1.hurt_rate
		}
	end

	function arg_1_0.__onActionFunc_first_hit_by_type(arg_21_0, arg_21_1, arg_21_2)
		for iter_21_0, iter_21_1 in pairs(arg_21_1) do
			if iter_21_0 ~= "type" then
				arg_21_2:get_attribute().first_hit_by_type = {
					ship_type = iter_21_0,
					num = iter_21_1
				}
			end
		end
	end

	function arg_1_0:__onActionFunc_action_23(arg_22_1, arg_22_2)
		local var_22_0 = self._battle_obj_mgr:get_ships_by_side((var_0_1.obj_side.opposite(self._owner:get_side())))
		local var_22_1 = {}

		for iter_22_0, iter_22_1 in pairs(arg_22_1.shipCids) do
			for iter_22_2, iter_22_3 in pairs(var_22_0) do
				if iter_22_3:get_cid() == iter_22_1 then
					var_0_2(var_22_1, iter_22_3)
				end
			end
		end

		if not next(var_22_1) then
			return
		end

		self._owner:set_skill_target(var_22_1[self._battle_random:randRange(1, #var_22_1)])
	end

	function arg_1_0:__onActionFunc_action_24(arg_23_1, arg_23_2)
		local var_23_0

		for iter_23_0, iter_23_1 in pairs((self._battle_obj_mgr:get_ships_by_side((var_0_1.obj_side.opposite(self._owner:get_side()))))) do
			if iter_23_1:is_flag() then
				var_23_0 = iter_23_1

				break
			end
		end

		if not var_23_0 then
			return
		end

		self._owner:set_skill_target(var_23_0)
	end

	function arg_1_0:__onActionFunc_action_25(arg_24_1, arg_24_2)
		local var_24_0 = self._owner:get_index()
		local var_24_1

		for iter_24_0, iter_24_1 in pairs((self._battle_obj_mgr:get_ships_by_side((var_0_1.obj_side.opposite(self._owner:get_side()))))) do
			if iter_24_1:get_index() == var_24_0 then
				var_24_1 = iter_24_1

				break
			end
		end

		local var_24_2
		local var_24_4

		if not var_24_1 then
			do return end

			var_24_2 = 0
			var_24_4 = {}
		end

		for iter_24_2, iter_24_3 in ipairs({
			"shipTypes",
			"shipTons",
			"guardTypes"
		}) do
			if arg_24_1[iter_24_3] then
				var_24_2 = iter_24_2
				var_24_4 = arg_24_1[iter_24_3]

				break
			end
		end

		local var_24_5 = true

		if var_24_2 == 1 then
			var_24_5 = false

			for iter_24_4, iter_24_5 in pairs(var_24_4) do
				if var_24_1:get_ship_type() == iter_24_5 then
					var_24_5 = true
				end
			end
		elseif var_24_2 == 2 then
			var_24_5 = false

			for iter_24_6, iter_24_7 in pairs(var_24_4) do
				if var_24_1:get_ship_ton() == iter_24_7 then
					var_24_5 = true
				end
			end
		elseif var_24_2 == 3 then
			var_24_5 = false

			for iter_24_8, iter_24_9 in pairs(var_24_4) do
				if var_24_1:get_ship_guard_type() == iter_24_9 then
					var_24_5 = true
				end
			end
		end

		if not var_24_1 or not var_24_5 then
			return
		end

		self._owner:get_attribute().attack_scoure_index_target = {
			attack_index = var_24_0
		}

		self._owner:set_skill_target(var_24_1)
	end

	function arg_1_0.__onActionFunc_action_26(arg_25_0, arg_25_1, arg_25_2)
		arg_25_2:get_attribute().first_hit_by_max_attr = {
			attr = arg_25_1.attribute
		}
	end

	function arg_1_0.__onActionFunc_first_hit_min_attr(arg_26_0, arg_26_1, arg_26_2)
		arg_26_2:get_attribute().first_hit_by_min_attr = {
			attr = arg_26_1.attribute
		}
	end

	function arg_1_0:__onActionFunc_action_27(arg_27_1, arg_27_2)
		local var_27_0 = {}

		for iter_27_0, iter_27_1 in pairs((self._battle_obj_mgr:get_ships_by_side((var_0_1.obj_side.opposite(self._owner:get_side()))))) do
			if not iter_27_1:is_submarine() then
				var_0_2(var_27_0, iter_27_1)
			end
		end

		if not next(var_27_0) then
			return
		end

		self._owner:set_skill_target(var_27_0[self._battle_random:randRange(1, #var_27_0)])
	end

	function arg_1_0.__onActionFunc_action_28(arg_28_0, arg_28_1, arg_28_2)
		arg_28_2:set_battle_damage_state(true)
	end

	function arg_1_0:__onActionFunc_action_29(arg_29_1, arg_29_2)
		self._owner:set_reduce_damage(arg_29_1.rate)
	end

	function arg_1_0.__onActionFunc_action_30(arg_30_0, arg_30_1, arg_30_2)
		arg_30_2:get_attribute().skill_num = arg_30_2:get_attribute().skill_num or {}

		if arg_30_2:get_attribute().skill_num.immune_to_once_fatal_injury then
			return
		end

		arg_30_2:get_attribute().skill_num.immune_to_once_fatal_injury = {
			num = arg_30_1.num
		}
	end

	function arg_1_0:__onActionFunc_action_31(arg_31_1, arg_31_2)
		self._owner:get_attribute().skill_num = self._owner:get_attribute().skill_num or {}
		self._owner:get_attribute()._is_immune_to_first_damage = true

		if self._owner:get_attribute().skill_num._is_immune_to_first_damage then
			return
		end

		self._owner:get_attribute().skill_num._is_immune_to_first_damage = 2
	end

	function arg_1_0:__onActionFunc_action_32(arg_32_1, arg_32_2)
		self._owner.skill_num = self._owner.skill_num or {}

		self._owner:set_immune_num_of_special_atk(arg_32_1.atkType, arg_32_1.num)
	end

	function arg_1_0:__onActionFunc_action_33(arg_33_1, arg_33_2)
		self._owner.skill_num = self._owner.skill_num or {}

		if self._owner.skill_num._reduce_percentage_of_damage then
			return
		end

		self._owner:set_reduce_percentage_of_damage(arg_33_1.hurt_rate, arg_33_1.num)
	end

	function arg_1_0:__onActionFunc_action_34(arg_34_1, arg_34_2)
		self._owner:set_reduce_damage_to_value(arg_34_1.num, arg_34_1.num2)
	end

	function arg_1_0:__onActionFunc_action_36(arg_35_1, arg_35_2)
		local var_35_0 = self._battle_obj_mgr:get_ships_by_side(self._owner:get_side())
		local var_35_1 = 0
		local var_35_2 = ""
		local var_35_3 = 0

		for iter_35_0, iter_35_1 in ipairs({
			"shipTypes",
			"shipTons",
			"guardTypes"
		}) do
			if arg_35_1[iter_35_1] then
				var_35_1 = iter_35_0

				break
			end
		end

		for iter_35_2, iter_35_3 in pairs(arg_35_1) do
			for iter_35_4, iter_35_5 in pairs(var_0_1.skil_attribute_type) do
				if iter_35_2 == iter_35_5 then
					var_35_2 = iter_35_2
					var_35_3 = iter_35_3

					break
				end
			end
		end

		if var_35_1 == 1 then
			self._owner:set_special_type_ship_add_attr(arg_35_1.shipTypes, var_35_2, var_35_3)
		elseif var_35_1 == 2 then
			self._owner:set_special_tons_ship_add_attr(arg_35_1.shipTons, var_35_2, var_35_3)
		elseif var_35_1 == 3 then
			self._owner:set_special_guard_ship_add_attr(arg_35_1.guardTypes, var_35_2, var_35_3)
		end
	end

	function arg_1_0:__onActionFunc_action_37(arg_36_1, arg_36_2)
		local var_36_0

		for iter_36_0, iter_36_1 in pairs(arg_36_1) do
			for iter_36_2, iter_36_3 in pairs(var_0_1.skil_attribute_type) do
				if iter_36_0 == iter_36_3 then
					var_36_0 = iter_36_0

					break
				end
			end
		end

		self._owner:set_add_attr_contrast_target(arg_36_1.attribute, var_36_0, nil)
	end

	function arg_1_0:__onActionFunc_action_38(arg_37_1, arg_37_2)
		local var_37_0

		for iter_37_0, iter_37_1 in pairs(arg_37_1) do
			for iter_37_2, iter_37_3 in pairs(var_0_1.skil_attribute_type) do
				if iter_37_0 == iter_37_3 then
					var_37_0 = iter_37_0

					break
				end
			end
		end

		self._owner:set_add_attr_with_attacked_1(arg_37_1.atkType, var_37_0, nil)
	end

	function arg_1_0:__onActionFunc_action_39(arg_38_1, arg_38_2)
		local var_38_0 = self._battle_obj_mgr:get_ships_by_side(self._owner:get_side())
		local var_38_1 = 0

		for iter_38_0, iter_38_1 in ipairs({
			"shipTypes",
			"shipTons"
		}) do
			if arg_38_1[iter_38_1] then
				var_38_1 = iter_38_0

				break
			end
		end

		if var_38_1 == 1 then
			local var_38_2
			local var_38_3

			for iter_38_2, iter_38_3 in pairs(arg_38_1) do
				for iter_38_4, iter_38_5 in pairs(var_0_1.skil_attribute_type) do
					if iter_38_2 == iter_38_5 then
						var_38_2 = iter_38_2
						var_38_3 = iter_38_3

						break
					end
				end
			end

			self._owner:set_add_attr_with_attacked_2(arg_38_1.shipTypes, var_38_2, var_38_3)
		elseif var_38_1 == 2 then
			local var_38_4
			local var_38_5

			for iter_38_6, iter_38_7 in pairs(arg_38_1) do
				for iter_38_8, iter_38_9 in pairs(var_0_1.skil_attribute_type) do
					if iter_38_6 == iter_38_9 then
						var_38_4 = iter_38_6
						var_38_5 = iter_38_7

						break
					end
				end
			end

			self._owner:set_add_attr_with_attacked_3(arg_38_1.shipTons, var_38_4, var_38_5)
		end
	end

	function arg_1_0:__onActionFunc_action_40(arg_39_1, arg_39_2)
		local var_39_0 = self._battle_obj_mgr:get_ships_by_side(self._owner:get_side())
		local var_39_1 = 0

		for iter_39_0, iter_39_1 in ipairs({
			"shipTypes",
			"shipTons"
		}) do
			if arg_39_1[iter_39_1] then
				var_39_1 = iter_39_0

				break
			end
		end

		if var_39_1 == 1 then
			self._owner:set_damage_with_ship_type(arg_39_1.shipTypes, arg_39_1.rate)
		elseif var_39_1 == 2 then
			self._owner:set_damage_with_ship_ton(arg_39_1.shipTons, arg_39_1.rate)
		end
	end

	function arg_1_0.__onActionFunc_action_41(arg_40_0, arg_40_1, arg_40_2)
		arg_40_2:set_can_enter_normal_attack(true)
	end

	function arg_1_0:__onActionFunc_action_42(arg_41_1, arg_41_2)
		self._owner:set_normal_turn_to_torpedo(arg_41_1.stage)
	end

	function arg_1_0.__onActionFunc_action_43(arg_42_0, arg_42_1, arg_42_2)
		arg_42_2:set_is_not_attack_for_type({
			var_0_1.trigger_type.close_torpedo_attack
		})
	end

	function arg_1_0:__onActionFunc_action_44(arg_43_1, arg_43_2)
		self._owner:set_can_attack_if_middle_or_big_break(true)
	end

	function arg_1_0.__onActionFunc_action_45(arg_44_0, arg_44_1, arg_44_2)
		arg_44_2:set_unlock_open_torpedo_attack(true)
	end

	function arg_1_0.__onActionFunc_action_47(arg_45_0, arg_45_1, arg_45_2)
		arg_45_2.skill_num = arg_45_2.skill_num or {}

		if arg_45_2.skill_num._num_of_beat_back_data then
			return
		end

		arg_45_2:set_num_of_beat_back(arg_45_1.num, arg_45_1.hurt_rate)
	end

	function arg_1_0:__onActionFunc_action_48(arg_46_1, arg_46_2)
		self._owner.skill_num = self._owner.skill_num or {}

		if self._owner.skill_num._is_immune_to_once_damage then
			return
		end

		self._owner:set_immune_to_once_damage_state(true)
	end

	function arg_1_0:__onActionFunc_carry_equip_add_attr(arg_47_1, arg_47_2)
		for iter_47_0, iter_47_1 in pairs((self._owner:get_equip_list())) do
			for iter_47_2, iter_47_3 in pairs(var_0_1.equip_attribute_type) do
				iter_47_1:add_equip_attribute(iter_47_3, arg_47_1.rate)
			end
		end
	end

	function arg_1_0:__onActionFunc_equip_attribute_add_attr(arg_48_1, arg_48_2)
		for iter_48_0, iter_48_1 in pairs((self._owner:get_equip_list())) do
			local var_48_0 = iter_48_1:get_equip_attribute(var_0_1.equip_attribute_type[arg_48_1.attribute])

			if var_48_0 then
				iter_48_1:add_equip_attribute(var_0_1.equip_attribute_type[arg_48_1.attribute2], var_48_0 * arg_48_1.rate)
			end
		end
	end

	function arg_1_0:__onActionFunc_equip_carry_attribute_add_attr(arg_49_1, arg_49_2)
		local var_49_0, var_49_1 = self:__get_config_equip_attr_data(arg_49_1)

		for iter_49_0, iter_49_1 in pairs((self._owner:get_equip_list())) do
			if iter_49_1:get_equip_type() == arg_49_1.equipment_type then
				iter_49_1:add_equip_attribute(var_49_0, var_49_1)
			end
		end
	end

	function arg_1_0:__onActionFunc_equip_carry_type_attribute_add_attr(arg_50_1, arg_50_2)
		local var_50_0, var_50_1 = self:__get_config_equip_attr_data(arg_50_1)

		for iter_50_0, iter_50_1 in pairs((self._owner:get_equip_list())) do
			if iter_50_1:get_equip_type() == arg_50_1.equipment_type then
				iter_50_1:add_equip_attribute(var_50_0, iter_50_1:get_equip_attribute(var_50_0) * (1 + var_50_1))
			end
		end
	end

	function arg_1_0:__onActionFunc_carry_equip_toghter_other_equip(arg_51_1, arg_51_2)
		for iter_51_0, iter_51_1 in pairs((self._owner:get_equip_list())) do
			if iter_51_1:get_equip_type() == arg_51_1.equipment_type then
				iter_51_1:set_equip_carry_other_attribute(arg_51_1.equipment_type2)
			end
		end
	end

	function arg_1_0:__onActionFunc_carry_equip_toghter_other_attribute(arg_52_1, arg_52_2)
		for iter_52_0, iter_52_1 in pairs((self._owner:get_equip_list())) do
			if iter_52_1:get_equip_type() == arg_52_1.equipment_type then
				local var_52_0 = iter_52_1:get_equip_attribute(var_0_1.equip_attribute_type[arg_52_1.attribute])

				if var_52_0 then
					iter_52_1:set_equip_attribute(var_0_1.equip_attribute_type[arg_52_1.attribute2], var_52_0 * arg_52_1.rate)
				end
			end
		end
	end

	function arg_1_0:__onActionFunc_reduce_loss_by_fight(arg_53_1, arg_53_2)
		self._owner:set_ship_aircraft_loss(arg_53_1.rate)
	end

	function arg_1_0:__onActionFunc_damage_of_float(arg_54_1, arg_54_2)
		self._owner:get_attribute().change_attack_rate = {
			hurt_rate = arg_54_1.hurt_rate,
			hurt_rate2 = arg_54_1.hurt_rate2
		}
	end

	function arg_1_0:__onActionFunc_team_average_speed_large_owner_speed(arg_55_1, arg_55_2)
		local var_55_0, var_55_1 = self:__get_config_attr_data(arg_55_1)

		if self._battle_scene:get_player_speed() > self._owner:get_ship_speed() then
			var_0_3:multiple_attr_value(arg_55_2, var_55_0, var_55_1, self._owner)
		end
	end

	function arg_1_0:__onActionFunc_team_average_speed_small_owner_speed(arg_56_1, arg_56_2)
		local var_56_0, var_56_1 = self:__get_config_attr_data(arg_56_1)

		if self._battle_scene:get_player_speed() < self._owner:get_ship_speed() then
			var_0_3:multiple_attr_value(arg_56_2, var_56_0, var_56_1, self._owner)
		end
	end

	function arg_1_0:__onActionFunc_team_average_speed_equal_owner_speed(arg_57_1, arg_57_2)
		local var_57_0, var_57_1 = self:__get_config_attr_data(arg_57_1)

		if self._battle_scene:get_player_speed() == self._owner:get_ship_speed() then
			var_0_3:multiple_attr_value(arg_57_2, var_57_0, var_57_1, self._owner)
		end
	end

	function arg_1_0:__onActionFunc_air_disadvantage_set_aircraft_damage(arg_58_1, arg_58_2)
		self._owner:set_ship_aircraft_hurt_state(false)
	end

	function arg_1_0.__onActionFunc_air_disadvantage_set_aircraft_add_damage(arg_59_0, arg_59_1, arg_59_2)
		if not arg_59_2 then
			return
		end

		arg_59_2:set_ship_aircraft_add_hurt_info(arg_59_1.hurt_rate)
	end

	function arg_1_0:__onActionFunc_damage_recover_life(arg_60_1, arg_60_2)
		self._owner.skill_num = self._owner.skill_num or {}

		if self._owner.skill_num._is_recover_life_once_damage ~= nil and self._owner.skill_num._is_recover_life_once_damage == false then
			return
		end

		self._owner:set_recover_life_state(true, arg_60_1.num, 1)
	end

	function arg_1_0:__onActionFunc_armor_penetration(arg_61_1, arg_61_2)
		local var_61_0, var_61_1 = self._owner:have_ap_equip()

		if var_61_0 and arg_61_1.sort == 1 then
			if var_61_1 < arg_61_1.defNum then
				local var_61_2 = self._owner:get_attribute()

				if var_61_2.ap then
					var_61_2.ap:modify_to_value(arg_61_1.defNum)
				end
			end
		else
			arg_61_2:get_attribute().skill_num = arg_61_2:get_attribute().skill_num or {}
			arg_61_2:get_attribute().skill_num.armor_penetrations = arg_61_2:get_attribute().skill_num.armor_penetrations or {}

			var_0_2(arg_61_2:get_attribute().skill_num.armor_penetrations, {
				num1 = arg_61_1.defNum,
				ship_cid = self._owner:get_cid(),
				ship_name = self._owner:get_ship_name()
			})

			local var_61_4 = arg_61_2:get_attribute().skill_num.armor_penetrations
			local var_61_5 = {}
			local var_61_6 = {}
			local var_61_7 = 0

			if next(var_61_4) then
				for iter_61_0, iter_61_1 in pairs(var_61_4) do
					if not var_61_5[iter_61_1.num1 .. "_" .. iter_61_1.ship_cid] then
						var_61_5[iter_61_1.num1 .. "_" .. iter_61_1.ship_cid] = true

						table.insert(var_61_6, iter_61_1)
					end
				end
			end

			for iter_61_2, iter_61_3 in pairs(var_61_6) do
				var_61_7 = var_61_7 + iter_61_3.num1
			end

			arg_61_2:get_attribute().skill_num.armor_penetrations = var_61_4
			arg_61_2:get_attribute().armor_penetration = var_61_7
		end
	end

	function arg_1_0:__onActionFunc_is_hit_unit_never_attack(arg_62_1, arg_62_2)
		self._owner:set_some_target_attack_state(false)
	end

	function arg_1_0:__onActionFunc_owner_attribute_change_buff_target_attr(arg_63_1, arg_63_2)
		local var_63_0 = self._attr_snapshot and self._attr_snapshot[var_0_1.skil_attribute_type[arg_63_1.attribute]]

		if var_63_0 == nil then
			var_63_0 = self._owner:get_attribute()[var_0_1.skil_attribute_type[arg_63_1.attribute]]:get_final_value()
		end

		arg_63_2:get_attribute()[var_0_1.skil_attribute_type[arg_63_1.attribute2]]:modify_to_value(arg_63_2:get_attribute()[var_0_1.skil_attribute_type[arg_63_1.attribute2]]:get_final_value() + math.ceil(var_63_0 * arg_63_1.rate))
	end

	function arg_1_0:__onActionFunc_immune_damage(arg_64_1, arg_64_2)
		self._owner:get_attribute().skill_num = self._owner:get_attribute().skill_num or {}

		if self._owner:get_attribute().skill_num._total_immune_value then
			return
		end

		self._owner:get_attribute().skill_num._total_immune_value = arg_64_1.num
	end

	function arg_1_0:__onActionFunc_immune_damage_by_buff(arg_65_1, arg_65_2)
		if not arg_65_1.num then
			return
		end

		local var_65_0 = arg_65_2:get_attribute().skill_num

		if not var_65_0 then
			var_65_0 = {}
			arg_65_2:get_attribute().skill_num = var_65_0
		end

		var_65_0._buff_immune_value_save = var_65_0._buff_immune_value_save or {}

		local var_65_1 = self._owner:getID() .. "_" .. tostring(arg_65_1.num)

		if var_65_0._buff_immune_value_save[var_65_1] then
			return
		end

		var_65_0._buff_immune_value_save[var_65_1] = true
		var_65_0._buff_immune_value = (var_65_0._buff_immune_value or 0) + arg_65_1.num
	end

	function arg_1_0:__onActionFunc_attack_cause_damage(arg_66_1, arg_66_2)
		self._owner:get_attribute()._attack_cause_damage = {
			num = arg_66_1.num,
			ship_tons = arg_66_1.shipTons,
			hurt_rate = arg_66_1.hurt_rate
		}
	end

	function arg_1_0:__onActionFunc_damage_of_beat_back(arg_67_1, arg_67_2)
		self._owner.skill_num = self._owner.skill_num or {}

		self._owner:set_damage_of_beat_back(arg_67_1.num)
	end

	function arg_1_0:__onActionFunc_change_final_damage(arg_68_1, arg_68_2)
		if not arg_68_2 then
			return
		end

		arg_68_1.fix_hurt_rate = arg_68_1.fix_hurt_rate or 0
		arg_68_2:get_attribute().change_final_damage = arg_68_2:get_attribute().change_final_damage and (1 + arg_68_1.hurt_rate * self._owner._multiple_attr_value + arg_68_1.fix_hurt_rate) * (1 + arg_68_2:get_attribute().change_final_damage) - 1 or arg_68_1.hurt_rate * self._owner._multiple_attr_value + arg_68_1.fix_hurt_rate
	end

	function arg_1_0:__onActionFunc_up_crit_hurt(arg_69_1, arg_69_2)
		arg_69_2:get_attribute().up_crit_hurt = arg_69_2:get_attribute().up_crit_hurt or 0
		arg_69_2:get_attribute().up_crit_hurt = arg_69_2:get_attribute().up_crit_hurt + arg_69_1.crit_hurt * self._owner._multiple_attr_value
	end

	function arg_1_0:__onActionFunc_add_attr_contrast_target_by_percent(arg_70_1, arg_70_2)
		local var_70_0

		for iter_70_0, iter_70_1 in pairs(arg_70_1) do
			for iter_70_2, iter_70_3 in pairs(var_0_1.skil_attribute_type) do
				if iter_70_0 == iter_70_3 then
					var_70_0 = iter_70_0

					break
				end
			end
		end

		self._owner:set_add_attr_contrast_target(arg_70_1.attribute, var_70_0, nil, true)
	end

	function arg_1_0:__onActionFunc_add_attr_with_attr(arg_71_1, arg_71_2)
		local var_71_0

		for iter_71_0, iter_71_1 in pairs(arg_71_1) do
			for iter_71_2, iter_71_3 in pairs(var_0_1.skil_attribute_type) do
				if iter_71_0 == iter_71_3 then
					var_71_0 = iter_71_0

					break
				end
			end
		end

		self._owner:set_add_attr_with_attr(arg_71_1.attribute, var_71_0, nil, false)
	end

	function arg_1_0.__onActionFunc_change_attr_by_atk_type_by_percent(arg_72_0, arg_72_1, arg_72_2)
		local var_72_0
		local var_72_1

		for iter_72_0, iter_72_1 in pairs(arg_72_1) do
			for iter_72_2, iter_72_3 in pairs(var_0_1.skil_attribute_type) do
				if iter_72_0 == iter_72_3 then
					var_72_0 = iter_72_0
					var_72_1 = iter_72_1

					break
				end
			end
		end

		arg_72_2:get_attribute().change_attr_by_atk_type = arg_72_2:get_attribute().change_attr_by_atk_type or {}

		local var_72_2 = {
			percent = true,
			atktype = arg_72_1.atkType,
			attr_type = var_72_0,
			attr_num = var_72_1
		}

		if var_72_0 == "crit_repair" then
			var_72_2.attr_num = var_72_1 * 100
			var_72_2.percent = false
		elseif var_72_0 == "hit_repair" then
			var_72_2.attr_num = var_72_1
			var_72_2.percent = false
		end

		table.insert(arg_72_2:get_attribute().change_attr_by_atk_type, var_72_2)
	end

	function arg_1_0:__onActionFunc_add_attr_by_special_ship_by_percent(arg_73_1, arg_73_2)
		local var_73_0 = self._battle_obj_mgr:get_ships_by_side(self._owner:get_side())
		local var_73_1 = 0
		local var_73_2 = ""
		local var_73_3 = 0

		for iter_73_0, iter_73_1 in ipairs({
			"shipTypes",
			"shipTons",
			"guardTypes"
		}) do
			if arg_73_1[iter_73_1] then
				var_73_1 = iter_73_0

				break
			end
		end

		for iter_73_2, iter_73_3 in pairs(arg_73_1) do
			for iter_73_4, iter_73_5 in pairs(var_0_1.skil_attribute_type) do
				if iter_73_2 == iter_73_5 then
					var_73_2 = iter_73_2
					var_73_3 = iter_73_3

					break
				end
			end
		end

		if var_73_1 == 1 then
			self._owner:set_special_type_ship_add_attr(arg_73_1.shipTypes, var_73_2, var_73_3, true)
		elseif var_73_1 == 2 then
			self._owner:set_special_tons_ship_add_attr(arg_73_1.shipTons, var_73_2, var_73_3, true)
		elseif var_73_1 == 3 then
			self._owner:set_special_guard_ship_add_attr(arg_73_1.guardTypes, var_73_2, var_73_3, true)
		end
	end

	function arg_1_0.__onActionFunc_change_attr_by_atk_type(arg_74_0, arg_74_1, arg_74_2)
		local var_74_0

		for iter_74_0, iter_74_1 in pairs(arg_74_1) do
			for iter_74_2, iter_74_3 in pairs(var_0_1.skil_attribute_type) do
				if iter_74_0 == iter_74_3 then
					var_74_0 = iter_74_0

					break
				end
			end
		end

		arg_74_2:get_attribute().change_attr_by_atk_type = arg_74_2:get_attribute().change_attr_by_atk_type or {}

		table.insert(arg_74_2:get_attribute().change_attr_by_atk_type, {
			atktype = arg_74_1.atkType,
			attr_type = var_74_0,
			attr_num = nil
		})
	end

	function arg_1_0:__onActionFunc_can_not_crit(arg_75_1, arg_75_2)
		self._owner:get_attribute().can_not_crit = true
	end

	function arg_1_0:__onActionFunc_ignore_battle_damage_in_crit(arg_76_1, arg_76_2)
		self._owner:get_attribute().ignore_battle_damage_in_crit = true
	end

	function arg_1_0:__onActionFunc_ignore_rate_by_armor_in_special_ship(arg_77_1, arg_77_2)
		local var_77_0 = 0

		for iter_77_0, iter_77_1 in ipairs({
			"shipTypes",
			"shipTons",
			"guardTypes"
		}) do
			if arg_77_1[iter_77_1] then
				var_77_0 = iter_77_1

				break
			end
		end

		self._owner:get_attribute().ignore_rate_by_armor_in_special_ship = {
			type = var_77_0,
			type_num = arg_77_1[var_77_0],
			rate = arg_77_1.rate
		}
	end

	function arg_1_0:__onActionFunc_change_crit_hurt_greater_than_attr(arg_78_1, arg_78_2)
		self._owner:get_attribute().change_crit_hurt_greater_than_targer_attr = {
			attr_type = var_0_1.skil_attribute_type[arg_78_1.attribute],
			crit_hurt = arg_78_1.crit_hurt
		}
	end

	function arg_1_0:__onActionFunc_change_damage_less_than_attr(arg_79_1, arg_79_2)
		self._owner:get_attribute().change_damage_less_than_attr = {
			attr_type = var_0_1.skil_attribute_type[arg_79_1.attribute],
			hurt_rate = arg_79_1.hurt_rate
		}
	end

	function arg_1_0:__onActionFunc_change_damage_by_index(arg_80_1, arg_80_2)
		self._owner:get_attribute().change_damage_by_index = arg_80_1.hurt_rate
	end

	function arg_1_0:__onActionFunc_change_damage_by_hp_not_full(arg_81_1, arg_81_2)
		self._owner:get_attribute().change_damage_by_hp_not_full = arg_81_1.hurt_rate
	end

	function arg_1_0:__onActionFunc_change_damage_by_is_flag_with_num(arg_82_1, arg_82_2)
		self._owner:get_attribute().change_damage_by_is_flag_with_num = arg_82_1.num
	end

	function arg_1_0.__onActionFunc_change_be_crit_rate(arg_83_0, arg_83_1, arg_83_2)
		arg_83_2:get_attribute().change_be_crit_rate = arg_83_2:get_attribute().change_be_crit_rate or 0
		arg_83_2:get_attribute().change_be_crit_rate = arg_83_2:get_attribute().change_be_crit_rate + arg_83_1.rate
	end

	function arg_1_0:__onActionFunc_creat_shield_in_hurt(arg_84_1, arg_84_2)
		self._owner:get_attribute().skill_num = self._owner:get_attribute().skill_num or {}
		self._owner:get_attribute().creat_shield_in_hurt = arg_84_1.effect_stage
	end

	function arg_1_0:__onActionFunc_change_damage_greater_than_num(arg_85_1, arg_85_2)
		local var_85_0

		for iter_85_0, iter_85_1 in pairs(arg_85_1) do
			for iter_85_2, iter_85_3 in pairs(var_0_1.skil_attribute_type) do
				if iter_85_0 == iter_85_3 then
					var_85_0 = iter_85_0

					break
				end
			end
		end

		self._owner:get_attribute().change_damage_greater_than_num = {
			attr_type = var_85_0,
			attr_num = nil,
			hurt_rate = arg_85_1.hurt_rate
		}
	end

	function arg_1_0:__onActionFunc_change_damage_less_than_num(arg_86_1, arg_86_2)
		local var_86_0

		for iter_86_0, iter_86_1 in pairs(arg_86_1) do
			for iter_86_2, iter_86_3 in pairs(var_0_1.skil_attribute_type) do
				if iter_86_0 == iter_86_3 then
					var_86_0 = iter_86_0

					break
				end
			end
		end

		self._owner:get_attribute().change_damage_less_than_num = {
			attr_type = var_86_0,
			attr_num = nil,
			hurt_rate = arg_86_1.hurt_rate
		}
	end

	function arg_1_0:__onActionFunc_ignore_rate_by_armor_in_is_flag(arg_87_1, arg_87_2)
		self._owner:get_attribute().ignore_rate_by_armor_in_is_flag = arg_87_1.rate
	end

	function arg_1_0.__onActionFunc_change_atked_weight(arg_88_0, arg_88_1, arg_88_2)
		arg_88_2:get_attribute().atked_weight = arg_88_2:get_attribute().atked_weight and arg_88_1.rate + arg_88_2:get_attribute().atked_weight or arg_88_1.rate
	end

	function arg_1_0.__onActionFunc_change_final_be_damage(arg_89_0, arg_89_1, arg_89_2)
		arg_89_2:get_attribute().change_final_be_damage = arg_89_1.rate
		arg_89_2:get_attribute().more_change_final_be_damage_save = arg_89_2:get_attribute().more_change_final_be_damage_save or {}

		table.insert(arg_89_2:get_attribute().more_change_final_be_damage_save, arg_89_1.rate)
	end

	function arg_1_0:__onActionFunc_change_damage_by_special_ship(arg_90_1, arg_90_2)
		local var_90_0 = 0

		for iter_90_0, iter_90_1 in ipairs({
			"shipTypes",
			"shipTons",
			"guardTypes"
		}) do
			if arg_90_1[iter_90_1] then
				var_90_0 = iter_90_1

				break
			end
		end

		arg_90_2:get_attribute().change_damage_by_special_ship = {
			type = var_90_0,
			type_num = arg_90_1[var_90_0],
			hurt_rate = arg_90_1.hurt_rate
		}
		self._owner:get_attribute().change_damage_by_special_ship = {
			type = var_90_0,
			type_num = arg_90_1[var_90_0],
			hurt_rate = arg_90_1.hurt_rate
		}
	end

	function arg_1_0:__onActionFunc_make_other_demage_by_num(arg_91_1, arg_91_2)
		self._owner._multiple_attr_value = self._owner._multiple_attr_value > 10 and 10 or self._owner._multiple_attr_value
		arg_91_2:get_attribute().make_other_demage_by_num = arg_91_1.num * self._owner._multiple_attr_value
	end

	function arg_1_0:__onActionFunc_change_range(arg_92_1, arg_92_2)
		self._owner:get_attribute().range:modify_to_value(arg_92_1.range)
	end

	function arg_1_0:__onActionFunc_make_other_demage_by_special_ship_by_num(arg_93_1, arg_93_2)
		local var_93_0 = 0

		for iter_93_0, iter_93_1 in ipairs({
			"shipTypes",
			"shipTons",
			"guardTypes"
		}) do
			if arg_93_1[iter_93_1] then
				var_93_0 = iter_93_1

				break
			end
		end

		self._owner:get_attribute().make_other_demage_by_special_ship_by_num = {
			type = var_93_0,
			type_num = arg_93_1[var_93_0],
			num = arg_93_1.num
		}
	end

	function arg_1_0:__onActionFunc_change_air_control(arg_94_1, arg_94_2)
		self._owner:get_attribute().change_air_control = arg_94_1.num * self._owner._multiple_attr_value
	end

	function arg_1_0.__onActionFunc_change_attr_by_be_atk_type(arg_95_0, arg_95_1, arg_95_2)
		local var_95_0

		for iter_95_0, iter_95_1 in pairs(arg_95_1) do
			for iter_95_2, iter_95_3 in pairs(var_0_1.skil_attribute_type) do
				if iter_95_0 == iter_95_3 then
					var_95_0 = iter_95_0

					break
				end
			end
		end

		arg_95_2:get_attribute().change_attr_by_be_atk_type = arg_95_2:get_attribute().change_attr_by_be_atk_type or {}

		table.insert(arg_95_2:get_attribute().change_attr_by_be_atk_type, {
			percent = false,
			atktype = arg_95_1.atkType,
			attr_type = var_95_0,
			attr_num = nil
		})
	end

	function arg_1_0.__onActionFunc_can_not_shout_by_stage_before_shout(arg_96_0, arg_96_1, arg_96_2)
		arg_96_2:set_is_not_attack_for_type(arg_96_1.effect_stage)

		for iter_96_0, iter_96_1 in pairs(arg_96_1.effect_stage) do
			if iter_96_1 == var_0_1.trigger_type.all_step or iter_96_1 == var_0_1.trigger_type.air_attack then
				arg_96_2:get_attribute().ban_aircraft_attack = true
			end
		end
	end

	function arg_1_0:__onActionFunc_probability_triggering(arg_97_1, arg_97_2)
		arg_97_2:get_attribute().probability = {
			determine = false,
			rate = arg_97_1.effect_rate,
			num = arg_97_1.effect_num,
			guardianer_pos = self._owner:get_pos()
		}
		arg_97_2:get_attribute().save_guardianer = self._owner:get_pos()
		arg_97_2:get_attribute().more_probability_save = arg_97_2:get_attribute().more_probability_save or {}

		table.insert(arg_97_2:get_attribute().more_probability_save, arg_97_2:get_attribute().probability)
	end

	function arg_1_0:__onActionFunc_hited_effect(arg_98_1, arg_98_2)
		self._owner:get_attribute().hited_effect = arg_98_1.effect_type
	end

	function arg_1_0:__onActionFunc_ignore_rate_by_armor_in_crit(arg_99_1, arg_99_2)
		self._owner:get_attribute().ignore_rate_by_armor_in_crit = arg_99_1.rate
	end

	function arg_1_0.__onActionFunc_add_attr_by_special_ship(arg_100_0, arg_100_1, arg_100_2)
		local var_100_0
		local var_100_1

		for iter_100_0, iter_100_1 in pairs(arg_100_1) do
			for iter_100_2, iter_100_3 in pairs(var_0_1.skil_attribute_type) do
				if iter_100_0 == iter_100_3 then
					var_100_0 = iter_100_0
					var_100_1 = iter_100_1

					break
				end
			end
		end

		if arg_100_2:get_attribute().dec_target_attribute_by_this_atk then
			arg_100_2:get_attribute().dec_target_attribute_by_this_atk[#arg_100_2:get_attribute().dec_target_attribute_by_this_atk + 1] = {
				shipTypes = arg_100_1.shipTypes,
				shipTons = arg_100_1.shipTons,
				attr_type = var_100_0,
				attr_num = var_100_1,
				effect_stage = arg_100_1.effect_stage,
				unique = arg_100_1.unique
			}
		else
			arg_100_2:get_attribute().dec_target_attribute_by_this_atk = {}
			arg_100_2:get_attribute().dec_target_attribute_by_this_atk[1] = {
				shipTypes = arg_100_1.shipTypes,
				shipTons = arg_100_1.shipTons,
				attr_type = var_100_0,
				attr_num = var_100_1,
				effect_stage = arg_100_1.effect_stage,
				unique = arg_100_1.unique
			}
		end
	end

	function arg_1_0:__onActionFunc_change_plane_damage(arg_101_1, arg_101_2)
		if not arg_101_2:get_attribute().change_plane_damage then
			arg_101_2:get_attribute().change_plane_damage = {
				boom = arg_101_1.boom * self._owner._multiple_attr_value,
				torpedo = arg_101_1.torpedo * self._owner._multiple_attr_value
			}
		else
			arg_101_2:get_attribute().change_plane_damage.boom = (1 + arg_101_2:get_attribute().change_plane_damage.boom) * (1 + arg_101_1.boom * self._owner._multiple_attr_value) - 1
			arg_101_2:get_attribute().change_plane_damage.torpedo = (1 + arg_101_2:get_attribute().change_plane_damage.torpedo) * (1 + arg_101_1.torpedo * self._owner._multiple_attr_value) - 1
		end
	end

	function arg_1_0:__onActionFunc_change_be_damage_by_num(arg_102_1, arg_102_2)
		self._owner:get_attribute().change_be_damage_by_num = arg_102_1.num
	end

	function arg_1_0:__onActionFunc_change_damage_greater_than_num_by_num(arg_103_1, arg_103_2)
		local var_103_0

		for iter_103_0, iter_103_1 in pairs(arg_103_1) do
			for iter_103_2, iter_103_3 in pairs(var_0_1.skil_attribute_type) do
				if iter_103_0 == iter_103_3 then
					var_103_0 = iter_103_0

					break
				end
			end
		end

		self._owner:get_attribute().change_damage_greater_than_num_by_num = {
			attr_type = var_103_0,
			attr_num = nil,
			num = arg_103_1.num * self._owner._multiple_attr_value
		}
	end

	function arg_1_0:__onActionFunc_change_damage_by_is_flag_with_percnet(arg_104_1, arg_104_2)
		self._owner:get_attribute().change_damage_by_is_flag_with_percnet = arg_104_1.hurt_rate
	end

	function arg_1_0:__onActionFunc_lock_hp_by_num(arg_105_1, arg_105_2)
		self._owner:get_attribute().lock_hp_by_num = arg_105_1.num
	end

	function arg_1_0:__onActionFunc_sure_to_crit_by_num(arg_106_1, arg_106_2)
		self._owner:get_attribute().sure_to_crit_by_num = {
			atk_num = 0,
			num = arg_106_1.num
		}
	end

	function arg_1_0:__onActionFunc_show_special_cutin_and_animation(arg_107_1, arg_107_2)
		self._owner:get_attribute().animation_type = arg_107_1.effect_type
		self._owner:get_attribute().is_show_cutin = true
	end

	function arg_1_0:__onActionFunc_set_atk_by_attr(arg_108_1, arg_108_2)
		self._owner:get_attribute().set_atk_by_attr = {
			attr_type = var_0_1.skil_attribute_type[arg_108_1.attribute],
			rate = arg_108_1.rate
		}
	end

	function arg_1_0:__onActionFunc_hit_target_hp_to_broke(arg_109_1, arg_109_2)
		self._owner:get_attribute().hit_target_hp_to_broke = arg_109_1.num
	end

	function arg_1_0:__onActionFunc_back_hit_to_random_target_by_attr(arg_110_1, arg_110_2)
		self._owner:set_num_of_beat_back(arg_110_1.attribute, arg_110_1.rate)
	end

	function arg_1_0:__onActionFunc_can_not_hit_or_be_hit(arg_111_1, arg_111_2)
		self._owner:get_attribute().can_not_hit_or_be_hit = true

		self._owner:set_is_not_attack_for_type(arg_111_1.effect_stage)
	end

	function arg_1_0:__onActionFunc_set_hit_num_in_normal_atk(arg_112_1, arg_112_2)
		self._owner:get_attribute().set_hit_num_in_normal_atk = arg_112_1.num
	end

	function arg_1_0:__onActionFunc_can_not_hit_in_this_stage_by_be_hit(arg_113_1, arg_113_2)
		self._owner:get_attribute().can_not_hit_in_this_stage_by_be_hit = arg_113_1.effect_stage
	end

	function arg_1_0:__onActionFunc_can_not_hit_in_this_stage_by_not_flag(arg_114_1, arg_114_2)
		self._owner:get_attribute().can_not_hit_in_this_stage_by_not_flag = arg_114_1.effect_stage
	end

	function arg_1_0.__onActionFunc_set_atk_by_percent(arg_115_0, arg_115_1, arg_115_2)
		if not arg_115_2:get_attribute().set_atk_by_percent then
			arg_115_2:get_attribute().set_atk_by_percent = {
				rate = 1 + arg_115_1.rate
			}
		else
			arg_115_2:get_attribute().set_atk_by_percent.rate = arg_115_2:get_attribute().set_atk_by_percent.rate * (1 + arg_115_1.rate)
		end
	end

	function arg_1_0:__onActionFunc_change_crit_hurt_by_ship_type(arg_116_1, arg_116_2)
		local var_116_0 = {
			"shipTypes",
			"shipTons",
			"guardTypes"
		}
		local var_116_1

		for iter_116_0, iter_116_1 in pairs(arg_116_1) do
			for iter_116_2, iter_116_3 in pairs(var_116_0) do
				if iter_116_0 == iter_116_3 then
					var_116_1 = iter_116_0
				end
			end
		end

		self._owner:get_attribute().change_crit_hurt_by_ship_type = {
			data_type = var_116_1,
			data_num = nil,
			hurt_rate = arg_116_1.hurt_rate
		}
	end

	function arg_1_0.__onActionFunc_hit_by_fixed_demage_by_ship_type(arg_117_0, arg_117_1, arg_117_2)
		local var_117_0 = {
			"shipTypes",
			"shipTons",
			"guardTypes"
		}
		local var_117_1

		for iter_117_0, iter_117_1 in pairs(arg_117_1) do
			for iter_117_2, iter_117_3 in pairs(var_117_0) do
				if iter_117_0 == iter_117_3 then
					var_117_1 = iter_117_0
				end
			end
		end

		arg_117_2:get_attribute().hit_by_fixed_demage_by_ship_type = arg_117_2:get_attribute().hit_by_fixed_demage_by_ship_type or {}

		table.insert(arg_117_2:get_attribute().hit_by_fixed_demage_by_ship_type, {
			data_type = var_117_1,
			data_num = nil,
			num = arg_117_1.num
		})
	end

	function arg_1_0.__onActionFunc_hit_by_fixed_demage_attr_by_percent(arg_118_0, arg_118_1, arg_118_2)
		arg_118_2:get_attribute().hit_by_fixed_demage_attr_by_percent = arg_118_2:get_attribute().hit_by_fixed_demage_attr_by_percent or {}

		table.insert(arg_118_2:get_attribute().hit_by_fixed_demage_attr_by_percent, {
			attribute_type = var_0_1.skil_attribute_type[arg_118_1.attribute],
			rate = arg_118_1.rate
		})
	end

	function arg_1_0.__onActionFunc_change_be_crit_rate_by_be_hit(arg_119_0, arg_119_1, arg_119_2)
		arg_119_2:get_attribute().change_be_crit_rate_by_be_hit = {
			rate = arg_119_1.rate,
			stage = arg_119_1.effect_stage,
			unique = arg_119_1.unique
		}
	end

	function arg_1_0.__onActionFunc_change_final_be_damage_by_be_hit(arg_120_0, arg_120_1, arg_120_2)
		arg_120_2:get_attribute().change_final_be_damage_by_be_hit = {
			rate = arg_120_1.rate,
			stage = arg_120_1.effect_stage,
			unique = arg_120_1.unique
		}
	end

	function arg_1_0:__onActionFunc_change_atk_by_radom_by_attr(arg_121_1, arg_121_2)
		arg_121_2:get_attribute().skill_num = arg_121_2:get_attribute().skill_num or {}
		arg_121_2:get_attribute().skill_num.change_atk_by_radom_by_attr = arg_121_2:get_attribute().skill_num.change_atk_by_radom_by_attr or {}

		var_0_2(arg_121_2:get_attribute().skill_num.change_atk_by_radom_by_attr, {
			num1 = arg_121_1.num1,
			num2 = arg_121_1.num2,
			attr_type = var_0_1.skil_attribute_type[arg_121_1.attribute],
			add_attr_type = var_0_1.skil_attribute_type[arg_121_1.attribute2],
			ship_cid = arg_121_2:get_cid(),
			ship_name = arg_121_2:get_ship_name(),
			owner_cid = self._owner:get_cid(),
			owner_name = self._owner:get_ship_name()
		})

		local var_121_0 = arg_121_2:get_attribute().skill_num.change_atk_by_radom_by_attr
		local var_121_1 = {}
		local var_121_2 = {}

		if next(var_121_0) then
			for iter_121_0, iter_121_1 in pairs(var_121_0) do
				if not var_121_1[iter_121_1.ship_cid .. "_" .. iter_121_1.attr_type .. "_" .. iter_121_1.owner_cid] then
					var_121_1[iter_121_1.ship_cid .. "_" .. iter_121_1.attr_type .. "_" .. iter_121_1.owner_cid] = true

					table.insert(var_121_2, iter_121_1)
				end
			end
		end

		arg_121_2:get_attribute().skill_num.change_atk_by_radom_by_attr = var_121_2
	end

	function arg_1_0.__onActionFunc_change_attr_by_radom_by_attr(arg_122_0, arg_122_1, arg_122_2)
		arg_122_2:get_attribute().change_attr_by_radom_by_attr = arg_122_2:get_attribute().change_attr_by_radom_by_attr or {}

		table.insert(arg_122_2:get_attribute().change_attr_by_radom_by_attr, {
			num1 = arg_122_1.num1,
			num2 = arg_122_1.num2,
			attr_type1 = var_0_1.skil_attribute_type[arg_122_1.attribute1],
			attr_type2 = var_0_1.skil_attribute_type[arg_122_1.attribute2]
		})
	end

	function arg_1_0.__onActionFunc_change_damage_by_attr_by_num(arg_123_0, arg_123_1, arg_123_2)
		arg_123_2:get_attribute().skill_num = arg_123_2:get_attribute().skill_num or {}
		arg_123_2:get_attribute().skill_num.change_damage_by_attr_by_num = arg_123_2:get_attribute().skill_num.change_damage_by_attr_by_num or {
			attr_type = var_0_1.skil_attribute_type[arg_123_1.attribute],
			attr_rate = arg_123_1.rate1,
			damage_rate = arg_123_1.rate2,
			num = arg_123_1.num
		}
	end

	function arg_1_0.__onActionFunc_target_change_attr_by_shiptype_by_stage(arg_124_0, arg_124_1, arg_124_2)
		local var_124_0
		local var_124_1

		for iter_124_0, iter_124_1 in pairs(arg_124_1) do
			for iter_124_2, iter_124_3 in pairs(var_0_1.skil_attribute_type) do
				if iter_124_0 == iter_124_3 then
					var_124_0 = iter_124_0
					var_124_1 = iter_124_1

					break
				end
			end
		end

		if arg_124_2:get_attribute().target_change_attr_by_shiptype_by_stage then
			arg_124_2:get_attribute().target_change_attr_by_shiptype_by_stage[#arg_124_2:get_attribute().target_change_attr_by_shiptype_by_stage + 1] = {
				shipTypes = arg_124_1.shipTypes,
				shipTons = arg_124_1.shipTons,
				attr_type = var_124_0,
				attr_num = var_124_1,
				effect_stage = arg_124_1.effect_stage,
				unique = arg_124_1.unique
			}
		else
			arg_124_2:get_attribute().target_change_attr_by_shiptype_by_stage = {}
			arg_124_2:get_attribute().target_change_attr_by_shiptype_by_stage[1] = {
				shipTypes = arg_124_1.shipTypes,
				shipTons = arg_124_1.shipTons,
				attr_type = var_124_0,
				attr_num = var_124_1,
				effect_stage = arg_124_1.effect_stage,
				unique = arg_124_1.unique
			}
		end
	end

	function arg_1_0.__onActionFunc_target_change_attr_by_shiptype_by_stage_by_percent(arg_125_0, arg_125_1, arg_125_2)
		local var_125_0
		local var_125_1

		for iter_125_0, iter_125_1 in pairs(arg_125_1) do
			for iter_125_2, iter_125_3 in pairs(var_0_1.skil_attribute_type) do
				if iter_125_0 == iter_125_3 then
					var_125_0 = iter_125_0
					var_125_1 = iter_125_1

					break
				end
			end
		end

		if arg_125_2:get_attribute().target_change_attr_by_shiptype_by_stage then
			arg_125_2:get_attribute().target_change_attr_by_shiptype_by_stage[#arg_125_2:get_attribute().target_change_attr_by_shiptype_by_stage + 1] = {
				percent = true,
				shipTypes = arg_125_1.shipTypes,
				shipTons = arg_125_1.shipTons,
				attr_type = var_125_0,
				attr_num = var_125_1,
				effect_stage = arg_125_1.effect_stage,
				unique = arg_125_1.unique
			}
		else
			arg_125_2:get_attribute().target_change_attr_by_shiptype_by_stage = {}
			arg_125_2:get_attribute().target_change_attr_by_shiptype_by_stage[1] = {
				percent = true,
				shipTypes = arg_125_1.shipTypes,
				shipTons = arg_125_1.shipTons,
				attr_type = var_125_0,
				attr_num = var_125_1,
				effect_stage = arg_125_1.effect_stage,
				unique = arg_125_1.unique
			}
		end
	end

	function arg_1_0:__onActionFunc_target_change_attr_by_shiptype_by_percent_in_now_hit(arg_126_1, arg_126_2)
		local var_126_0 = self._battle_obj_mgr:get_ships_by_side(self._owner:get_side())
		local var_126_1 = 0
		local var_126_2 = ""
		local var_126_3 = 0

		for iter_126_0, iter_126_1 in ipairs({
			"shipTypes",
			"shipTons",
			"guardTypes"
		}) do
			if arg_126_1[iter_126_1] then
				var_126_1 = iter_126_0

				break
			end
		end

		for iter_126_2, iter_126_3 in pairs(arg_126_1) do
			for iter_126_4, iter_126_5 in pairs(var_0_1.skil_attribute_type) do
				if iter_126_2 == iter_126_5 then
					var_126_2 = iter_126_2
					var_126_3 = iter_126_3

					break
				end
			end
		end

		if var_126_1 == 1 then
			arg_126_2:set_special_type_ship_target_add_attr(arg_126_1.shipTypes, var_126_2, var_126_3, true)
		elseif var_126_1 == 2 then
			arg_126_2:set_special_tons_ship_target_add_attr(arg_126_1.shipTons, var_126_2, var_126_3, true)
		elseif var_126_1 == 3 then
			arg_126_2:set_special_guard_ship_target_add_attr(arg_126_1.guardTypes, var_126_2, var_126_3, true)
		end
	end

	function arg_1_0.__onActionFunc_change_plane_damage_by_level(arg_127_0, arg_127_1, arg_127_2)
		if not arg_127_2:get_attribute().change_plane_damage_cant_superposition then
			if not arg_127_2:get_attribute().change_plane_damage then
				arg_127_2:get_attribute().change_plane_damage = {
					boom = arg_127_1.boom,
					torpedo = arg_127_1.torpedo
				}
			else
				arg_127_2:get_attribute().change_plane_damage.boom = (1 + arg_127_2:get_attribute().change_plane_damage.boom) * (1 + arg_127_1.boom) - 1
				arg_127_2:get_attribute().change_plane_damage.torpedo = (1 + arg_127_2:get_attribute().change_plane_damage.torpedo) * (1 + arg_127_1.torpedo) - 1
			end

			arg_127_2:get_attribute().change_plane_damage_cant_superposition = {
				boom = arg_127_1.boom,
				torpedo = arg_127_1.torpedo
			}
		elseif arg_127_1.boom > arg_127_2:get_attribute().change_plane_damage_cant_superposition.boom then
			arg_127_2:get_attribute().change_plane_damage.boom = (1 + arg_127_2:get_attribute().change_plane_damage.boom) * (1 + arg_127_1.boom) / (1 + arg_127_2:get_attribute().change_plane_damage_cant_superposition.boom) - 1
			arg_127_2:get_attribute().change_plane_damage.torpedo = (1 + arg_127_2:get_attribute().change_plane_damage.torpedo) * (1 + arg_127_1.torpedo) / (1 + arg_127_2:get_attribute().change_plane_damage_cant_superposition.torpedo) - 1
			arg_127_2:get_attribute().change_plane_damage_cant_superposition = {
				boom = arg_127_1.boom,
				torpedo = arg_127_1.torpedo
			}
		end
	end

	function arg_1_0:__onActionFunc_ignore_middile_break(arg_128_1, arg_128_2)
		self._owner:set_affect_power_by_state(true)
	end

	function arg_1_0:__onActionFunc_self_change_attr_by_shiptype_by_stage_by_percent(arg_129_1, arg_129_2)
		local var_129_0
		local var_129_1

		for iter_129_0, iter_129_1 in pairs(arg_129_1) do
			for iter_129_2, iter_129_3 in pairs(var_0_1.skil_attribute_type) do
				if iter_129_0 == iter_129_3 then
					var_129_0 = iter_129_0
					var_129_1 = iter_129_1

					break
				end
			end
		end

		if self._owner:get_attribute().self_change_attr_by_shiptype_by_stage then
			local var_129_3 = #self._owner:get_attribute().self_change_attr_by_shiptype_by_stage + 1

			if arg_129_1.shipTypes then
				self._owner:get_attribute().self_change_attr_by_shiptype_by_stage[var_129_3] = {
					percent = true,
					shipTypes = arg_129_1.shipTypes,
					attr_type = var_129_0,
					attr_num = var_129_1,
					effect_stage = arg_129_1.effect_stage
				}
			elseif arg_129_1.shipTons then
				self._owner:get_attribute().self_change_attr_by_shiptype_by_stage[var_129_3] = {
					percent = true,
					shipTons = arg_129_1.shipTons,
					attr_type = var_129_0,
					attr_num = var_129_1,
					effect_stage = arg_129_1.effect_stage
				}
			end
		else
			self._owner:get_attribute().self_change_attr_by_shiptype_by_stage = {}

			if arg_129_1.shipTypes then
				self._owner:get_attribute().self_change_attr_by_shiptype_by_stage[1] = {
					percent = true,
					shipTypes = arg_129_1.shipTypes,
					attr_type = var_129_0,
					attr_num = var_129_1,
					effect_stage = arg_129_1.effect_stage
				}
			elseif arg_129_1.shipTons then
				self._owner:get_attribute().self_change_attr_by_shiptype_by_stage[1] = {
					percent = true,
					shipTons = arg_129_1.shipTons,
					attr_type = var_129_0,
					attr_num = var_129_1,
					effect_stage = arg_129_1.effect_stage
				}
			end
		end
	end

	function arg_1_0:__onActionFunc_self_change_attr_by_shiptype_by_stage(arg_130_1, arg_130_2)
		local var_130_0
		local var_130_1

		for iter_130_0, iter_130_1 in pairs(arg_130_1) do
			for iter_130_2, iter_130_3 in pairs(var_0_1.skil_attribute_type) do
				if iter_130_0 == iter_130_3 then
					var_130_0 = iter_130_0
					var_130_1 = iter_130_1

					break
				end
			end
		end

		if self._owner:get_attribute().self_change_attr_by_shiptype_by_stage then
			local var_130_3 = #self._owner:get_attribute().self_change_attr_by_shiptype_by_stage + 1

			if arg_130_1.shipTypes then
				self._owner:get_attribute().self_change_attr_by_shiptype_by_stage[var_130_3] = {
					percent = false,
					shipTypes = arg_130_1.shipTypes,
					attr_type = var_130_0,
					attr_num = var_130_1,
					effect_stage = arg_130_1.effect_stage
				}
			elseif arg_130_1.shipTons then
				self._owner:get_attribute().self_change_attr_by_shiptype_by_stage[var_130_3] = {
					percent = false,
					shipTons = arg_130_1.shipTons,
					attr_type = var_130_0,
					attr_num = var_130_1,
					effect_stage = arg_130_1.effect_stage
				}
			end
		else
			self._owner:get_attribute().self_change_attr_by_shiptype_by_stage = {}

			if arg_130_1.shipTypes then
				self._owner:get_attribute().self_change_attr_by_shiptype_by_stage[1] = {
					percent = false,
					shipTypes = arg_130_1.shipTypes,
					attr_type = var_130_0,
					attr_num = var_130_1,
					effect_stage = arg_130_1.effect_stage
				}
			elseif arg_130_1.shipTons then
				self._owner:get_attribute().self_change_attr_by_shiptype_by_stage[1] = {
					percent = false,
					shipTons = arg_130_1.shipTons,
					attr_type = var_130_0,
					attr_num = var_130_1,
					effect_stage = arg_130_1.effect_stage
				}
			end
		end
	end

	function arg_1_0.__onActionFunc_self_change_attr_by_shiptype_by_stage_by_attack(arg_131_0, arg_131_1, arg_131_2)
		local var_131_0
		local var_131_1

		for iter_131_0, iter_131_1 in pairs(arg_131_1) do
			for iter_131_2, iter_131_3 in pairs(var_0_1.skil_attribute_type) do
				if iter_131_0 == iter_131_3 then
					var_131_0 = iter_131_0
					var_131_1 = iter_131_1

					break
				end
			end
		end

		arg_131_2:get_attribute().self_change_attr_by_shiptype_by_stage_by_attack = arg_131_2:get_attribute().self_change_attr_by_shiptype_by_stage_by_attack or {}

		local var_131_3 = #arg_131_2:get_attribute().self_change_attr_by_shiptype_by_stage_by_attack + 1

		if arg_131_1.shipTypes then
			arg_131_2:get_attribute().self_change_attr_by_shiptype_by_stage_by_attack[var_131_3] = {
				shipTypes = arg_131_1.shipTypes,
				attr_type = var_131_0,
				attr_num = var_131_1,
				effect_stage = arg_131_1.effect_stage,
				unique = arg_131_1.unique
			}
		elseif arg_131_1.shipTons then
			arg_131_2:get_attribute().self_change_attr_by_shiptype_by_stage_by_attack[var_131_3] = {
				shipTons = arg_131_1.shipTons,
				attr_type = var_131_0,
				attr_num = var_131_1,
				effect_stage = arg_131_1.effect_stage,
				unique = arg_131_1.unique
			}
		end
	end

	function arg_1_0.__onActionFunc_first_hit_by_type_by_num(arg_132_0, arg_132_1, arg_132_2)
		for iter_132_0, iter_132_1 in pairs(arg_132_1) do
			if iter_132_0 ~= "type" then
				arg_132_2:get_attribute().first_hit_by_type_by_num = {
					ship_type = iter_132_0,
					num = iter_132_1
				}
			end
		end
	end

	function arg_1_0.__onActionFunc_can_not_effect_by_course(arg_133_0, arg_133_1, arg_133_2)
		arg_133_2:get_attribute().can_not_effect_by_course = arg_133_1.num
	end

	function arg_1_0.__onActionFunc_add_damage_by_now_hp_less_than_num(arg_134_0, arg_134_1, arg_134_2)
		arg_134_2:get_attribute().add_damage_by_now_hp_less_than_num = {
			max_damage = arg_134_1.hurt_rate,
			target_hp = arg_134_1.hp
		}
	end

	function arg_1_0.__onActionFunc_add_damage_by_now_hp_greater_than_num(arg_135_0, arg_135_1, arg_135_2)
		arg_135_2:get_attribute().add_damage_by_now_hp_greater_than_num = {
			max_damage = arg_135_1.hurt_rate,
			target_hp = arg_135_1.hp
		}
	end

	function arg_1_0.__onActionFunc_can_not_shout_and_shout_with_teammate(arg_136_0, arg_136_1, arg_136_2)
		arg_136_2:get_attribute().skill_num = arg_136_2:get_attribute().skill_num or {}
		arg_136_2:get_attribute().skill_num.can_not_shout_and_shout_with_teammate = arg_136_2:get_attribute().skill_num.can_not_shout_and_shout_with_teammate or {
			can_shout = false
		}
		arg_136_2:get_attribute().skill_num.can_not_shout_and_shout_with_teammate_save_list = arg_136_2:get_attribute().skill_num.can_not_shout_and_shout_with_teammate_save_list or {
			ship_list = {}
		}
	end

	function arg_1_0.__onActionFunc_can_not_shout_in_crit_by_stage(arg_137_0, arg_137_1, arg_137_2)
		arg_137_2:get_attribute().can_not_shout_in_crit_by_stage = arg_137_1.effect_stage
	end

	function arg_1_0:__onActionFunc_num_of_beat_back_wihtout_hp_state(arg_138_1, arg_138_2)
		self._owner.skill_num = self._owner.skill_num or {}

		self._owner:set_num_of_beat_back_wihtout_hp_state()
	end

	function arg_1_0.__onActionFunc_change_atked_weight_can_overly(arg_139_0, arg_139_1, arg_139_2)
		arg_139_2:get_attribute().atked_weight = arg_139_2:get_attribute().atked_weight and arg_139_2:get_attribute().atked_weight + arg_139_1.rate or arg_139_1.rate
	end

	function arg_1_0.__onActionFunc_change_final_be_damage_can_overly(arg_140_0, arg_140_1, arg_140_2)
		arg_140_2:get_attribute().change_final_be_damage = arg_140_2:get_attribute().change_final_be_damage and (1 + arg_140_2:get_attribute().change_final_be_damage) * (1 + arg_140_1.hurt_rate) - 1 or arg_140_1.hurt_rate
	end

	function arg_1_0.__onActionFunc_change_crit_hurt_by_hp(arg_141_0, arg_141_1, arg_141_2)
		arg_141_2:get_attribute().change_crit_hurt_by_hp = {
			crit_hurt = arg_141_1.crit_hurt,
			num = arg_141_1.num
		}
	end

	function arg_1_0.__onActionFunc_change_attr_by_hp(arg_142_0, arg_142_1, arg_142_2)
		local var_142_0

		for iter_142_0, iter_142_1 in pairs(arg_142_1) do
			for iter_142_2, iter_142_3 in pairs(var_0_1.skil_attribute_type) do
				if iter_142_0 == iter_142_3 then
					var_142_0 = iter_142_0

					break
				end
			end
		end

		arg_142_2:get_attribute().change_attr_by_hp = {
			attr_type = var_142_0,
			attr_num = nil,
			num = arg_142_1.num
		}
	end

	function arg_1_0.__onActionFunc_num_of_beat_back_with_fix_damage(arg_143_0, arg_143_1, arg_143_2)
		local var_143_0

		for iter_143_0, iter_143_1 in pairs(arg_143_1) do
			for iter_143_2, iter_143_3 in pairs(var_0_1.skil_attribute_type) do
				if iter_143_0 == iter_143_3 then
					var_143_0 = iter_143_0

					break
				end
			end
		end

		arg_143_2:get_attribute().num_of_beat_back_with_fix_damage = {
			attr_type = var_143_0,
			attr_num = nil,
			num = arg_143_1.num
		}
	end

	function arg_1_0.__onActionFunc_phase_no_damage_by_phase_attack(arg_144_0, arg_144_1, arg_144_2)
		log.print_r(arg_144_1, "action_data")

		arg_144_2:get_attribute().phase_no_damage_by_phase_attack = {
			action_stage = arg_144_1.condition_stage,
			buff_stage = arg_144_1.effect_stage,
			attack_add = arg_144_1.num
		}
	end

	function arg_1_0.__onActionFunc_double_hit_by_crit(arg_145_0, arg_145_1, arg_145_2)
		arg_145_2:get_attribute().double_hit_by_crit = {
			hurt_rates = arg_145_1.hurt_rates
		}
	end

	function arg_1_0.__onActionFunc_couple_by_shipcid(arg_146_0, arg_146_1, arg_146_2)
		local var_146_0

		for iter_146_0, iter_146_1 in pairs(arg_146_1) do
			for iter_146_2, iter_146_3 in pairs(var_0_1.skil_attribute_type) do
				if iter_146_0 == iter_146_3 then
					var_146_0 = iter_146_0

					break
				end
			end
		end

		arg_146_2:get_attribute().couple_by_shipcid = {
			couple = arg_146_1.couple,
			hurt_rate = arg_146_1.hurt_rate,
			attr_type = var_146_0,
			attr_num = nil,
			effect_stage = arg_146_1.effect_stage
		}
	end

	function arg_1_0.__onActionFunc_add_attr_by_target_alive(arg_147_0, arg_147_1, arg_147_2)
		local var_147_0

		for iter_147_0, iter_147_1 in pairs(arg_147_1) do
			for iter_147_2, iter_147_3 in pairs(var_0_1.skil_attribute_type) do
				if iter_147_0 == iter_147_3 then
					var_147_0 = iter_147_0

					break
				end
			end
		end

		arg_147_2:get_attribute().add_attr_by_target_alive = arg_147_2:get_attribute().add_attr_by_target_alive or {}
		arg_147_2:get_attribute().add_attr_by_target_alive[var_147_0] = {
			attr_num = nil,
			num = arg_147_1.num
		}
	end

	function arg_1_0.__onActionFunc_add_fix_damage_by_index(arg_148_0, arg_148_1, arg_148_2)
		arg_148_2:get_attribute().add_fix_damage_by_index = {
			num = arg_148_1.num
		}
	end

	function arg_1_0.__onActionFunc_sure_to_hit_by_index(arg_149_0, arg_149_1, arg_149_2)
		arg_149_2:get_attribute().sure_to_hit_by_index = true
	end

	function arg_1_0.__onActionFunc_one_more_attack_and_not_shout_by_stage(arg_150_0, arg_150_1, arg_150_2)
		arg_150_2:get_attribute().one_more_attack_and_not_shout_by_stage = arg_150_1.effect_stage
	end

	function arg_1_0.__onActionFunc_add_attr_by_num_bu_lost_hp(arg_151_0, arg_151_1, arg_151_2)
		local var_151_0

		for iter_151_0, iter_151_1 in pairs(arg_151_1) do
			for iter_151_2, iter_151_3 in pairs(var_0_1.skil_attribute_type) do
				if iter_151_0 == iter_151_3 then
					var_151_0 = iter_151_0

					break
				end
			end
		end

		arg_151_2:get_attribute().add_attr_by_num_bu_lost_hp = arg_151_2:get_attribute().add_attr_by_num_bu_lost_hp or {}

		table.insert(arg_151_2:get_attribute().add_attr_by_num_bu_lost_hp, {
			attr_min = (nil)[1],
			attr_max = (nil)[2],
			attr_type = var_151_0
		})
	end

	function arg_1_0.__onActionFunc_after_lost_hp_by_percent_immune_by_num(arg_152_0, arg_152_1, arg_152_2)
		arg_152_2:get_attribute().after_lost_hp_by_percent_immune_by_num = {
			hp = arg_152_1.hp,
			num = arg_152_1.num
		}
	end

	function arg_1_0:__onActionFunc_add_attr_without_equip(arg_153_1, arg_153_2)
		local var_153_0

		for iter_153_0, iter_153_1 in pairs(arg_153_1) do
			for iter_153_2, iter_153_3 in pairs(var_0_1.skil_attribute_type) do
				if iter_153_0 == iter_153_3 then
					var_153_0 = iter_153_0

					break
				end
			end
		end

		arg_153_2:get_attribute()[var_153_0]:modify_to_value(arg_153_2:get_attribute()[var_153_0]:get_final_value() + math.ceil((arg_153_2:get_attribute()[var_153_0]:get_final_value() - arg_153_2:get_all_equip_attr_by_name(var_153_0)) * nil * self._owner._multiple_attr_value))
	end

	function arg_1_0.__onActionFunc_immune_num_of_speed_and_shipTons_atk(arg_154_0, arg_154_1, arg_154_2)
		local var_154_0
		local var_154_1

		for iter_154_0, iter_154_1 in pairs(arg_154_1) do
			for iter_154_2, iter_154_3 in pairs(var_0_1.skil_attribute_type) do
				if iter_154_0 == iter_154_3 then
					var_154_0 = iter_154_0
					var_154_1 = iter_154_1

					break
				end
			end
		end

		arg_154_2.skill_num = arg_154_2.skill_num or {}
		arg_154_2:get_attribute().skill_num = arg_154_2:get_attribute().skill_num or {}
		arg_154_2:get_attribute().immune_num_of_speed_and_shipTons_atk = {
			attr_type = var_154_0,
			attr_num = var_154_1,
			shipTypes = arg_154_1.shipTypes,
			shipTons = arg_154_1.shipTons,
			guardTypes = arg_154_1.guardTypes,
			flag = arg_154_1.flag
		}

		if arg_154_2:get_attribute().skill_num.immune_num_of_speed_and_shipTons_atk then
			return
		end

		arg_154_2:get_attribute().skill_num.immune_num_of_speed_and_shipTons_atk = {
			num = arg_154_1.num
		}
	end

	function arg_1_0.__onActionFunc_add_damage_with_lose_hp(arg_155_0, arg_155_1, arg_155_2)
		local var_155_0 = arg_155_2:get_attribute().hp
		local var_155_1 = var_155_0:get_final_value()
		local var_155_2 = var_155_1 - arg_155_2:get_attribute().now_hp:get_final_value()

		arg_155_2:get_attribute().set_atk_by_percent_by_lose_hp = {
			rate = var_155_0 / (var_155_1 - 1) * arg_155_1.rate + 1
		}
	end

	function arg_1_0.__onActionFunc_copy_target_skill(arg_156_0, arg_156_1, arg_156_2)
		return
	end

	function arg_1_0:__onActionFunc_set_immune_in_atk_by_shiptype(arg_157_1, arg_157_2)
		self._owner:get_attribute().set_immune_in_atk_by_shiptype = self._owner:get_attribute().set_immune_in_atk_by_shiptype or {}

		local var_157_0 = 0

		for iter_157_0, iter_157_1 in ipairs({
			"shipTypes",
			"shipTons",
			"guardTypes"
		}) do
			if arg_157_1[iter_157_1] then
				var_157_0 = iter_157_1

				break
			end
		end

		self._owner:get_attribute().set_immune_in_atk_by_shiptype.type = var_157_0
		self._owner:get_attribute().set_immune_in_atk_by_shiptype.type_num = arg_157_1[var_157_0]
		self._owner:get_attribute().set_immune_in_atk_by_shiptype.effect_stage = arg_157_1.effect_stage
		self._owner:get_attribute().set_immune_in_atk_by_shiptype.target_list = self._owner:get_attribute().set_immune_in_atk_by_shiptype.target_list or {}

		table.insert(self._owner:get_attribute().set_immune_in_atk_by_shiptype.target_list, arg_157_2)
	end

	function arg_1_0:__onActionFunc_add_target_crit_in_be_atk_by_shiptype(arg_158_1, arg_158_2)
		self._owner:get_attribute().add_target_crit_in_be_atk_by_shiptype = self._owner:get_attribute().add_target_crit_in_be_atk_by_shiptype or {}

		local var_158_0 = 0

		for iter_158_0, iter_158_1 in ipairs({
			"shipTypes",
			"shipTons",
			"guardTypes"
		}) do
			if arg_158_1[iter_158_1] then
				var_158_0 = iter_158_1

				break
			end
		end

		self._owner:get_attribute().add_target_crit_in_be_atk_by_shiptype.type = var_158_0
		self._owner:get_attribute().add_target_crit_in_be_atk_by_shiptype.type_num = arg_158_1[var_158_0]
		self._owner:get_attribute().add_target_crit_in_be_atk_by_shiptype.crit_hurt = arg_158_1.crit_hurt
		self._owner:get_attribute().add_target_crit_in_be_atk_by_shiptype.effect_stage = arg_158_1.effect_stage
		self._owner:get_attribute().add_target_crit_in_be_atk_by_shiptype.target_list = self._owner:get_attribute().add_target_crit_in_be_atk_by_shiptype.target_list or {}

		table.insert(self._owner:get_attribute().add_target_crit_in_be_atk_by_shiptype.target_list, arg_158_2)
	end

	function arg_1_0.__onActionFunc_change_drop_air_def_by_shiptype(arg_159_0, arg_159_1, arg_159_2)
		arg_159_2:get_attribute().change_drop_air_def_by_shiptype = arg_159_2:get_attribute().change_drop_air_def_by_shiptype or {}

		local var_159_0 = 0

		for iter_159_0, iter_159_1 in ipairs({
			"shipTypes",
			"shipTons",
			"guardTypes"
		}) do
			if arg_159_1[iter_159_1] then
				var_159_0 = iter_159_1

				break
			end
		end

		arg_159_2:get_attribute().change_drop_air_def_by_shiptype.type = var_159_0
		arg_159_2:get_attribute().change_drop_air_def_by_shiptype.type_num = arg_159_1[var_159_0]
		arg_159_2:get_attribute().change_drop_air_def_by_shiptype.rate = arg_159_1.rate
	end

	function arg_1_0:__onActionFunc_ship_henshin_skill(arg_160_1, arg_160_2)
		self._owner:get_attribute().skill_num = self._owner:get_attribute().skill_num or {}
		self._owner:get_attribute().skill_num.ship_henshin = self._owner:get_attribute().skill_num.ship_henshin or {
			now_henshin_cid = arg_160_1.shipCids,
			now_animation_id = arg_160_1.animation_num,
			now_animation_num2 = arg_160_1.animation_num2,
			now_stage = arg_160_1.henshin_stage,
			now_is_skin = arg_160_1.is_skin,
			now_animation_num3 = arg_160_1.animation_num3,
			now_skin_id = arg_160_2:get_skin_id()
		}
	end

	function arg_1_0:__onActionFunc_ship_henshin_cutin_skill(arg_161_1, arg_161_2)
		self._owner:get_attribute().skill_num = self._owner:get_attribute().skill_num or {}
		self._owner:get_attribute().skill_num.ship_henshin_cutin = self._owner:get_attribute().skill_num.ship_henshin_cutin or {
			now_henshin_cid = arg_161_1.shipCids,
			now_animation_id = arg_161_1.animation_num,
			now_stage = arg_161_1.henshin_stage,
			now_is_skin = arg_161_1.is_skin,
			now_animation_num3 = arg_161_1.animation_num3,
			now_skin_id = arg_161_2:get_skin_id(),
			now_animation_num2 = arg_161_1.animation_num2
		}
	end

	function arg_1_0:__onActionFunc_ship_attack_type_ignore_damaged(arg_162_1, arg_162_2)
		local var_162_0 = {
			"shipTypes",
			"shipTons",
			"guardTypes"
		}
		local var_162_1
		local var_162_2 = 0

		for iter_162_0, iter_162_1 in pairs(arg_162_1) do
			for iter_162_2, iter_162_3 in pairs(var_162_0) do
				if iter_162_0 == iter_162_3 then
					var_162_1 = iter_162_0
				end
			end
		end

		for iter_162_4, iter_162_5 in ipairs(var_162_0) do
			if iter_162_5 == var_162_1 then
				var_162_2 = iter_162_4

				break
			end
		end

		self._owner:set_alltypes_ignore_damaged(arg_162_1[var_162_1], var_162_2)
	end

	function arg_1_0:__onActionFunc_ship_can_no_antisub_submarine(arg_163_1, arg_163_2)
		self._owner:get_attribute().skill_num = self._owner:get_attribute().skill_num or {}
		self._owner:get_attribute().skill_num.not_single_cross_can_antisub_gd = self._owner:get_attribute().skill_num.not_single_cross_can_antisub_gd or true
		self._owner:get_attribute().skill_num.not_single_cross_can_antisub_gd_type = self._owner:get_attribute().skill_num.not_single_cross_can_antisub_gd_type or arg_163_1.shipTypes

		local var_163_0 = {}
		local var_163_1 = self._battle_obj_mgr:get_ships_by_side(self._owner:get_side())

		if self._owner:get_side() == var_0_1.obj_side.player then
			for iter_163_0, iter_163_1 in pairs(arg_163_1.shipTypes) do
				for iter_163_2, iter_163_3 in pairs(var_163_1) do
					if iter_163_3:get_ship_type() == iter_163_1 then
						var_0_2(var_163_0, iter_163_3:getID())
					end
				end
			end
		end

		local var_163_2 = {}
		local var_163_4 = {}

		if self._battle_scene:get_open_antisubb() and self._battle_scene:get_open_antisubb().ship_list then
			local var_163_5 = self._battle_scene:get_open_antisubb().ship_list

			if next(var_163_5) then
				for iter_163_4, iter_163_5 in pairs(var_163_5) do
					var_0_2(var_163_0, iter_163_5)
				end
			end

			for iter_163_6, iter_163_7 in pairs(var_163_0) do
				var_163_2[iter_163_7] = 1
			end

			for iter_163_8, iter_163_9 in pairs(var_163_2) do
				var_0_2(var_163_4, iter_163_8)
			end
		else
			var_163_4 = var_163_0
		end

		self._battle_scene:set_open_antisub({
			ship_list = var_163_4
		})
	end

	function arg_1_0.__onActionFunc_skill_attack_stage_wihtout_bullet(arg_164_0, arg_164_1, arg_164_2)
		arg_164_2:get_attribute().without_bullet_correct = 1
	end

	function arg_1_0:__onActionFunc_ship_antisub_ignore_broken_hp(arg_165_1, arg_165_2)
		self._owner:get_attribute().skill_num = self._owner:get_attribute().skill_num or {}
		self._owner:get_attribute().skill_num.antisub_ignore_broken_hp = true
	end

	function arg_1_0:__onActionFunc_sure_to_hit_by_shiptype(arg_166_1, arg_166_2)
		local var_166_0 = 0

		for iter_166_0, iter_166_1 in ipairs({
			"shipTypes",
			"shipTons",
			"guardTypes"
		}) do
			if arg_166_1[iter_166_1] then
				var_166_0 = iter_166_1

				break
			end
		end

		self._owner:get_attribute().sure_to_hit_by_shiptype = {
			type = var_166_0,
			type_num = arg_166_1[var_166_0]
		}
	end

	function arg_1_0.__onActionFunc_can_night_attack(arg_167_0, arg_167_1, arg_167_2)
		if arg_167_2 and not var_0_1:can_night_attack(arg_167_2:get_ship_type()) then
			arg_167_2:set_can_night_attack(true)
		end
	end

	function arg_1_0.__onActionFunc_can_attack_in_broken(arg_168_0, arg_168_1, arg_168_2)
		arg_168_2:set_can_attack_in_broken(true)
	end

	function arg_1_0.__onActionFunc_couple_attack_by_shipcid(arg_169_0, arg_169_1, arg_169_2)
		arg_169_2:get_attribute().couple_attack_by_shipcid = {
			shipCids = arg_169_1.shipCids,
			num = arg_169_1.num,
			hurt_rate = arg_169_1.hurt_rate,
			hit = arg_169_1.hit,
			crit = arg_169_1.crit
		}
	end

	function arg_1_0:__special_type_ship_add_attr(arg_170_1, arg_170_2)
		local var_170_0
		local var_170_1

		for iter_170_0, iter_170_1 in pairs(arg_170_2) do
			for iter_170_2, iter_170_3 in pairs(var_0_1.skil_attribute_type) do
				if iter_170_0 == iter_170_3 then
					var_170_0 = iter_170_0
					var_170_1 = iter_170_1

					break
				end
			end
		end

		for iter_170_4, iter_170_5 in pairs(arg_170_1) do
			local var_170_2 = iter_170_5:get_attribute()

			for iter_170_6, iter_170_7 in pairs(arg_170_2.shipTypes) do
				if iter_170_5:get_ship_type() == iter_170_7 then
					var_0_3:multiple_attr_value(iter_170_5, var_170_0, var_170_1, self._owner)

					break
				end
			end
		end
	end

	function arg_1_0:__special_tons_ship_add_attr(arg_171_1, arg_171_2)
		local var_171_0
		local var_171_1

		for iter_171_0, iter_171_1 in pairs(arg_171_2) do
			for iter_171_2, iter_171_3 in pairs(var_0_1.skil_attribute_type) do
				if iter_171_0 == iter_171_3 then
					var_171_0 = iter_171_0
					var_171_1 = iter_171_1

					break
				end
			end
		end

		for iter_171_4, iter_171_5 in pairs(arg_171_1) do
			local var_171_2 = iter_171_5:get_attribute()

			for iter_171_6, iter_171_7 in pairs(arg_171_2.shipTons) do
				if iter_171_5:get_ship_ton() == iter_171_7 then
					var_0_3:multiple_attr_value(iter_171_5, var_171_0, var_171_1, self._owner)

					break
				end
			end
		end
	end

	function arg_1_0:__special_guard_ship_add_attr(arg_172_1, arg_172_2)
		local var_172_0
		local var_172_1

		for iter_172_0, iter_172_1 in pairs(arg_172_2) do
			for iter_172_2, iter_172_3 in pairs(var_0_1.skil_attribute_type) do
				if iter_172_0 == iter_172_3 then
					var_172_0 = iter_172_0
					var_172_1 = iter_172_1

					break
				end
			end
		end

		for iter_172_4, iter_172_5 in pairs(arg_172_1) do
			local var_172_2 = iter_172_5:get_attribute()

			for iter_172_6, iter_172_7 in pairs(arg_172_2.guardTypes) do
				if iter_172_5:set_ship_guard_type() == iter_172_7 then
					var_0_3:multiple_attr_value(iter_172_5, var_172_0, var_172_1, self._owner)

					break
				end
			end
		end
	end

	function arg_1_0.__get_config_attr_data(arg_173_0, arg_173_1)
		local var_173_0

		for iter_173_0, iter_173_1 in pairs(arg_173_1) do
			if iter_173_0 ~= "type" then
				var_173_0 = iter_173_0
			end
		end

		return var_173_0, nil
	end

	function arg_1_0.__get_config_equip_attr_data(arg_174_0, arg_174_1)
		local var_174_0

		for iter_174_0, iter_174_1 in pairs(arg_174_1) do
			if iter_174_0 ~= "type" and iter_174_0 ~= "equipment_type" then
				var_174_0 = iter_174_0
			end
		end

		return var_174_0, nil
	end
end

function var_0_0.extend_obj(arg_175_0)
	return
end

return var_0_0
