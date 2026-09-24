local var_0_0 = {}
local var_0_2 = gameenum.common_type
local var_0_3 = gamecore.user
local var_0_8 = table.insert
local var_0_9 = gamecore.util_func
local var_0_12 = gameenum.battle_type.skil_attribute_type
local var_0_13 = gameconfig.ship_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onConditionFunc_ship_count_less_than_num_by_shiptype(arg_2_1, arg_2_2)
		local var_2_0 = self:__get_ship_counter_by_buff_data(arg_2_1, arg_2_2)

		if arg_2_2.num == 0 then
			return #var_2_0 <= arg_2_2.num, var_2_0
		else
			return #var_2_0 <= arg_2_2.num
		end
	end

	function arg_1_0:__on_func_ship_count_less_than_num_by_shiptype(arg_3_1, arg_3_2)
		local var_3_0 = self:__get_ship_counter_by_buff_data(arg_3_1, arg_3_2)

		if arg_3_2.num == 0 then
			return #var_3_0 <= arg_3_2.num, var_3_0
		else
			return #var_3_0 <= arg_3_2.num
		end
	end

	function arg_1_0:__onConditionFunc_ship_count_greater_than_num_by_shiptype(arg_4_1, arg_4_2)
		return #self:__get_ship_counter_by_buff_data(arg_4_1, arg_4_2) > arg_4_2.num
	end

	function arg_1_0:__on_func_ship_count_greater_than_num_by_shiptype(arg_5_1, arg_5_2)
		return #self:__get_ship_counter_by_buff_data(arg_5_1, arg_5_2) > arg_5_2.num
	end

	function arg_1_0:__onConditionFunc_ship_count_less_than_num_by_country(arg_6_1, arg_6_2)
		local var_6_0 = self:__get_ship_counter_by_buff_data(arg_6_1, arg_6_2)

		if arg_6_2.num == 0 then
			return #var_6_0 <= arg_6_2.num, var_6_0
		else
			return #var_6_0 <= arg_6_2.num
		end
	end

	function arg_1_0:__onConditionFunc_ship_count_greater_than_num_by_country(arg_7_1, arg_7_2)
		return #self:__get_ship_counter_by_buff_data(arg_7_1, arg_7_2) > arg_7_2.num
	end

	function arg_1_0:__onConditionFunc_ship_count_greater_attribute_less_than_num(arg_8_1, arg_8_2)
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in pairs(arg_8_1) do
			if self:get_skill_equip_add_prop(var_0_3:get_character_attribute_by_calculate(iter_8_1), var_0_3:find_character_by_id(iter_8_1), iter_8_1, iter_8_0, arg_8_1)[var_0_12[arg_8_2.num4]] > arg_8_2.num5 then
				var_0_8(var_8_0, iter_8_1)
			end
		end

		if arg_8_2.num == 0 then
			return #var_8_0 <= arg_8_2.num, var_8_0
		else
			return #var_8_0 <= arg_8_2.num
		end
	end

	function arg_1_0:__on_func_ship_count_greater_attribute_less_than_num(arg_9_1, arg_9_2)
		local var_9_0 = {}

		for iter_9_0, iter_9_1 in pairs(arg_9_1) do
			if self:get_skill_equip_add_prop(var_0_3:get_character_attribute_by_calculate(iter_9_1), var_0_3:find_character_by_id(iter_9_1), iter_9_1, iter_9_0, arg_9_1)[var_0_12[arg_9_2.num4]] > arg_9_2.num5 then
				var_0_8(var_9_0, iter_9_1)
			end
		end

		if arg_9_2.num == 0 then
			return #var_9_0 <= arg_9_2.num, var_9_0
		else
			return #var_9_0 <= arg_9_2.num
		end
	end

	function arg_1_0:__onConditionFunc_ship_count_greater_attribute_greater_than_num(arg_10_1, arg_10_2)
		local var_10_0 = {}

		for iter_10_0, iter_10_1 in pairs(arg_10_1) do
			local var_10_1 = self:get_skill_equip_add_prop(var_0_3:get_character_attribute_by_calculate(iter_10_1), var_0_3:find_character_by_id(iter_10_1), iter_10_1, iter_10_0, arg_10_1)

			if arg_10_2.num4 == 10 then
				if var_10_1[var_0_12[arg_10_2.num4]] + self:check_for_speed() > arg_10_2.num5 then
					var_0_8(var_10_0, iter_10_1)
				end
			elseif var_10_1[var_0_12[arg_10_2.num4]] > arg_10_2.num5 then
				var_0_8(var_10_0, iter_10_1)
			end
		end

		return #var_10_0 > arg_10_2.num
	end

	function arg_1_0:__on_func_ship_count_greater_attribute_greater_than_num(arg_11_1, arg_11_2)
		local var_11_0 = {}

		for iter_11_0, iter_11_1 in pairs(arg_11_1) do
			if self:get_skill_equip_add_prop(var_0_3:get_character_attribute_by_calculate(iter_11_1), var_0_3:find_character_by_id(iter_11_1), iter_11_1, iter_11_0, arg_11_1)[var_0_12[arg_11_2.num4]] > arg_11_2.num5 then
				var_0_8(var_11_0, iter_11_1)
			end
		end

		return #var_11_0 > arg_11_2.num
	end

	function arg_1_0:__onConditionFunc_all_ship_attribute_less_than_num(arg_12_1, arg_12_2)
		local var_12_0 = 0

		for iter_12_0, iter_12_1 in pairs(arg_12_1) do
			var_12_0 = var_12_0 + self:get_skill_equip_add_prop(var_0_3:get_character_attribute_by_calculate(iter_12_1), var_0_3:find_character_by_id(iter_12_1), iter_12_1, iter_12_0, arg_12_1)[var_0_12[arg_12_2.num4]]
		end

		return var_12_0 <= arg_12_2.num
	end

	function arg_1_0:__onConditionFunc_all_ship_attribute_greater_than_num(arg_13_1, arg_13_2)
		if arg_13_2.type == 12 and arg_13_2.num4 == 11 then
			return self:__calc_strike_team_radar_total() > arg_13_2.num
		elseif arg_13_2.type == 12 and arg_13_2.num4 == 10 then
			return self:__calc_strike_team_speed_total() > arg_13_2.num
		end

		local var_13_0 = 0

		for iter_13_0, iter_13_1 in pairs(arg_13_1) do
			var_13_0 = var_13_0 + self:get_skill_equip_add_prop(var_0_3:get_character_attribute_by_calculate(iter_13_1), var_0_3:find_character_by_id(iter_13_1), iter_13_1, iter_13_0, arg_13_1)[var_0_12[arg_13_2.num4]]
		end

		return var_13_0 > arg_13_2.num
	end

	function arg_1_0:__onConditionFunc_all_ship_average_attribute_less_than_num(arg_14_1, arg_14_2)
		if arg_14_2.type == 13 and arg_14_2.num4 == 10 then
			return self:__calc_strike_team_average_speed() <= arg_14_2.num
		end

		if arg_14_2.type == 13 and arg_14_2.num4 == 11 then
			local var_14_0 = #arg_14_1

			if #arg_14_1 == 0 then
				return false
			end

			return self:__calc_strike_team_radar_total() / var_14_0 <= arg_14_2.num
		end

		local var_14_1 = 0

		for iter_14_0, iter_14_1 in pairs(arg_14_1) do
			var_14_1 = var_14_1 + self:get_skill_equip_add_prop(var_0_3:get_character_attribute_by_calculate(iter_14_1), var_0_3:find_character_by_id(iter_14_1), iter_14_1, iter_14_0, arg_14_1)[var_0_12[arg_14_2.num4]]
		end

		return var_14_1 / #arg_14_1 <= arg_14_2.num
	end

	function arg_1_0:__onConditionFunc_all_ship_average_attribute_greater_than_num(arg_15_1, arg_15_2)
		if arg_15_2.type == 14 and arg_15_2.num4 == 10 then
			return self:__calc_strike_team_average_speed() > arg_15_2.num
		end

		if arg_15_2.type == 14 and arg_15_2.num4 == 11 then
			local var_15_0 = #arg_15_1

			if #arg_15_1 == 0 then
				return false
			end

			return self:__calc_strike_team_radar_total() / var_15_0 > arg_15_2.num
		end

		local var_15_1 = 0

		for iter_15_0, iter_15_1 in pairs(arg_15_1) do
			local var_15_2 = self:get_skill_equip_add_prop(var_0_3:get_character_attribute_by_calculate(iter_15_1), var_0_3:find_character_by_id(iter_15_1), iter_15_1, iter_15_0, arg_15_1)

			var_15_1 = arg_15_2.num4 == 10 and var_15_1 + (var_15_2[var_0_12[arg_15_2.num4]] + self:check_for_speed()) or var_15_1 + var_15_2[var_0_12[arg_15_2.num4]]
		end

		return var_15_1 / #arg_15_1 > arg_15_2.num
	end

	function arg_1_0:__onConditionFunc_flag_should_be_set_by_shiptype(arg_16_1, arg_16_2)
		local var_16_0 = {}

		var_0_8(var_16_0, arg_16_1[1])

		return #self:__get_ship_counter_by_buff_data(var_16_0, arg_16_2) == 1
	end

	function arg_1_0:__on_func_flag_should_be_set_by_shiptype(arg_17_1, arg_17_2)
		local var_17_0 = {}

		var_0_8(var_17_0, arg_17_1[1])

		return #self:__get_ship_counter_by_buff_data(var_17_0, arg_17_2) == 1
	end

	function arg_1_0:__onConditionFunc_flag_should_not_be_set_by_shiptype(arg_18_1, arg_18_2)
		local var_18_0 = {}

		var_0_8(var_18_0, arg_18_1[1])

		return #self:__get_ship_counter_by_buff_data(var_18_0, arg_18_2) == 0
	end

	function arg_1_0:__on_func_flag_should_not_be_set_by_shiptype(arg_19_1, arg_19_2)
		local var_19_0 = {}

		var_0_8(var_19_0, arg_19_1[1])

		return #self:__get_ship_counter_by_buff_data(var_19_0, arg_19_2) == 0
	end

	function arg_1_0:__onConditionFunc_flag_should_be_set_by_country(arg_20_1, arg_20_2)
		local var_20_0 = {}

		var_0_8(var_20_0, arg_20_1[1])

		return #self:__get_ship_counter_by_buff_data(var_20_0, arg_20_2) == 1
	end

	function arg_1_0:__onConditionFunc_flag_should_not_be_set_by_country(arg_21_1, arg_21_2)
		local var_21_0 = {}

		var_0_8(var_21_0, arg_21_1[1])

		return #self:__get_ship_counter_by_buff_data(var_21_0, arg_21_2) == 0
	end

	function arg_1_0:__onConditionFunc_ship_count_less_than_num_by_shiptype_and_country(arg_22_1, arg_22_2)
		return #self:__get_ship_counter_by_buff_data(arg_22_1, arg_22_2) <= arg_22_2.nums
	end

	function arg_1_0:__onConditionFunc_ship_count_greater_than_num_by_shiptype_and_country(arg_23_1, arg_23_2)
		return #self:__get_ship_counter_by_buff_data(arg_23_1, arg_23_2) > arg_23_2.num
	end

	function arg_1_0:__onConditionFunc_ship_count_less_attribute_less_than_num(arg_24_1, arg_24_2)
		local var_24_0 = {}

		for iter_24_0, iter_24_1 in pairs(arg_24_1) do
			local var_24_1 = self:get_skill_equip_add_prop(var_0_3:get_character_attribute_by_calculate(iter_24_1), var_0_3:find_character_by_id(iter_24_1), iter_24_1, iter_24_0, arg_24_1)

			if self._current_content_type == var_0_2.fight_prepare_right_panel_type.strike and arg_24_2.num4 == 10 then
				local var_24_2 = {}
				local var_24_3 = {}

				for iter_24_2, iter_24_3 in ipairs(self._team_detail_data) do
					var_24_1 = var_0_9:get_ship_attr(iter_24_3.data, iter_24_3.config)

					if var_24_1 then
						var_24_2[iter_24_2] = {
							add_by_skill = false,
							speed_num = var_24_1.speed
						}
						var_24_3[iter_24_2] = {
							radar_num = var_24_1.radar
						}
					end
				end

				for iter_24_4, iter_24_5 in pairs(self._team_detail_data) do
					self:__add_speed_by_buff_skill(self._team_detail_data, var_24_2, var_24_3, iter_24_4)
				end

				for iter_24_6, iter_24_7 in pairs(var_24_2) do
					if iter_24_7.speed_num + self:check_for_speed() <= arg_24_2.num5 then
						var_0_8(var_24_0, iter_24_7)
					end
				end
			elseif var_24_1[var_0_12[arg_24_2.num4]] <= arg_24_2.num5 then
				var_0_8(var_24_0, iter_24_1)
			end
		end

		return #var_24_0 <= arg_24_2.num
	end

	function arg_1_0:__onConditionFunc_ship_count_less_attribute_greater_than_num(arg_25_1, arg_25_2)
		local var_25_0 = {}

		for iter_25_0, iter_25_1 in pairs(arg_25_1) do
			if self:get_skill_equip_add_prop(var_0_3:get_character_attribute_by_calculate(iter_25_1), var_0_3:find_character_by_id(iter_25_1), iter_25_1, iter_25_0, arg_25_1)[var_0_12[arg_25_2.num4]] <= arg_25_2.num5 then
				var_0_8(var_25_0, iter_25_1)
			end
		end

		return #var_25_0 > arg_25_2.num
	end

	function arg_1_0.__onConditionFunc_ship_select_by_cid(arg_26_0, arg_26_1, arg_26_2)
		for iter_26_0, iter_26_1 in pairs(arg_26_1) do
			if not var_0_9.have_data(arg_26_2.shipCids, var_0_3:find_character_by_id(iter_26_1).cid) then
				return false
			end
		end

		return true
	end

	function arg_1_0:__onConditionFunc_ship_select_by_shiptype(arg_27_1, arg_27_2)
		local var_27_0 = self:__get_ship_counter_by_buff_data(arg_27_1, arg_27_2)

		return #var_27_0 == #arg_27_1, var_27_0
	end

	function arg_1_0:__onConditionFunc_ship_select_by_shiptype_in_num(arg_28_1, arg_28_2)
		return #self:__get_ship_counter_by_buff_data(arg_28_1, arg_28_2) == arg_28_2.num
	end

	function arg_1_0.__onConditionFunc_flag_select_by_cid(arg_29_0, arg_29_1, arg_29_2)
		local var_29_0 = var_0_3:find_character_by_id(arg_29_1[1])

		for iter_29_0, iter_29_1 in pairs(arg_29_2.shipCids) do
			if var_29_0.cid == iter_29_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__onConditionFunc_flag_select_for_shiptype_by_country(arg_30_1, arg_30_2)
		arg_30_2.country = nil

		for iter_30_0, iter_30_1 in pairs((self:__get_ship_counter_by_buff_data(arg_30_1, arg_30_2))) do
			if var_0_13.find_object_by_cid(var_0_3:find_character_by_id(iter_30_1).cid).country ~= arg_30_2.buff_effect then
				return false
			end
		end

		return true
	end

	function arg_1_0.__onConditionFunc_flag_select_by_level(arg_31_0, arg_31_1, arg_31_2)
		return var_0_3:find_character_by_id(arg_31_1[1]).level > arg_31_2.num
	end

	function arg_1_0.__onConditionFunc_ship_include_by_cid(arg_32_0, arg_32_1, arg_32_2)
		local var_32_0 = false

		for iter_32_0, iter_32_1 in ipairs(arg_32_1) do
			if var_0_9.have_data(arg_32_2.shipCids, var_0_3:find_character_by_id(iter_32_1).cid) then
				var_32_0 = true

				return true
			end
		end

		return var_32_0
	end

	function arg_1_0:__on_func_add_attr_for_all_ship(arg_33_1, arg_33_2)
		table.insert(self._attr_buff_list, arg_33_2)

		return self._attr_buff_list
	end

	function arg_1_0:__onConditionFunc_add_attr_for_all_ship(arg_34_1, arg_34_2)
		table.insert(self._attr_buff_list, arg_34_2)

		return self._attr_buff_list
	end

	function arg_1_0:__on_func_minus_attr_for_all_ship(arg_35_1, arg_35_2)
		table.insert(self._attr_buff_list, arg_35_2)

		return self._attr_buff_list
	end

	function arg_1_0:__onConditionFunc_minus_attr_for_all_ship(arg_36_1, arg_36_2)
		table.insert(self._attr_buff_list, arg_36_2)

		return self._attr_buff_list
	end

	function arg_1_0:__on_func_add_attr_by_shiptype(arg_37_1, arg_37_2)
		table.insert(self._attr_buff_list, arg_37_2)

		return self._attr_buff_list
	end

	function arg_1_0:__on_func_minus_attr_by_shiptype(arg_38_1, arg_38_2)
		table.insert(self._attr_buff_list, arg_38_2)

		return self._attr_buff_list
	end

	function arg_1_0:__on_func_add_attr_by_country(arg_39_1, arg_39_2)
		table.insert(self._attr_buff_list, arg_39_2)
	end

	function arg_1_0:__on_func_minus_attr_by_country(arg_40_1, arg_40_2)
		table.insert(self._attr_buff_list, arg_40_2)
	end

	function arg_1_0:__on_func_can_not_be_effect(arg_41_1, arg_41_2)
		table.insert(self._attr_buff_list, arg_41_2)
	end
end

function var_0_0.extend_obj(arg_42_0)
	return
end

return var_0_0
