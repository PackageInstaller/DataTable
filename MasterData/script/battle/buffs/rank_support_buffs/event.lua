local var_0_0 = {}
local var_0_2 = table.insert
local var_0_3 = gameenum.battle_type
local var_0_4 = gamecore.battle_util

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.__on_func_rank_attr_one(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		if arg_2_4 ~= "init_attr" then
			return
		end

		if arg_2_2:get_side() == var_0_3.obj_side.enemy then
			return
		end

		if arg_2_3 then
			return
		end
	end

	function arg_1_0.__on_func_rank_attr_two(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
		if arg_3_4 ~= "init_attr" then
			return
		end

		if arg_3_2:get_side() == var_0_3.obj_side.player then
			return
		end

		if arg_3_3 then
			return
		end
	end

	function arg_1_0.__on_func_rank_attack_three(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
		if arg_4_4 ~= "init_attr" then
			return
		end

		if arg_4_2:get_side() == var_0_3.obj_side.enemy then
			return
		end

		if arg_4_3 then
			return
		end
	end

	function arg_1_0.__on_func_rank_attack_three(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
		if arg_5_4 ~= "init_attr" then
			return
		end

		if arg_5_2:get_side() == var_0_3.obj_side.enemy then
			return
		end

		if arg_5_3 then
			return
		end
	end

	function arg_1_0.__on_func_rank_attacked_four(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
		if arg_6_4 ~= "init_attr" then
			return
		end

		if arg_6_2:get_side() == var_0_3.obj_side.enemy then
			return
		end

		if arg_6_3 then
			return
		end
	end

	function arg_1_0.__on_func_rank_attack_fire(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
		if arg_7_4 ~= "init_attr" then
			return
		end

		if arg_7_2:get_side() == var_0_3.obj_side.enemy then
			return
		end

		if arg_7_3 then
			return
		end
	end

	function arg_1_0.__on_func_rank_attack_add_damage(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
		if arg_8_4 == "init_attr" then
			return
		end

		if arg_8_2:get_side() == var_0_3.obj_side.enemy then
			return
		end

		if not arg_8_3 then
			return
		end

		arg_8_2:get_attribute().rank_add_final_damage = arg_8_2:get_attribute().rank_add_final_damage or 0

		if arg_8_1.num then
			arg_8_2:get_attribute().rank_add_final_damage = arg_8_1.num
		end
	end

	function arg_1_0.__on_func_rank_attack_seven(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
		if arg_9_4 ~= "init_attr" then
			return
		end

		if arg_9_2:get_side() == var_0_3.obj_side.enemy then
			return
		end

		if arg_9_3 then
			return
		end
	end

	function arg_1_0.__on_func_rank_attakc_open(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
		if arg_10_4 ~= "init_attr" then
			return
		end

		if arg_10_2:get_side() == var_0_3.obj_side.enemy then
			return
		end

		if arg_10_3 then
			return
		end
	end

	function arg_1_0:__get_ship_hit_state_by_effect(arg_11_1, arg_11_2)
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

		local var_11_4 = {}
		local var_11_5 = {}

		table.insert(var_11_5, arg_11_2)

		for iter_11_2, iter_11_3 in pairs(var_11_5) do
			if var_11_0 then
				if self:__get_ship_data_by_countrys(iter_11_3, var_11_0) and self:__get_ship_data_by_screen(iter_11_3, var_11_1, var_11_2, var_11_3) then
					var_0_2(var_11_4, iter_11_3:getID())
				end
			elseif self:__get_ship_data_by_screen(iter_11_3, var_11_1, var_11_2, var_11_3) then
				var_0_2(var_11_4, iter_11_3:getID())
			end
		end

		return var_11_4
	end

	function arg_1_0:__update_ship_attr_by_effect(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
		local var_12_0 = {}

		table.insert(var_12_0, arg_12_4)

		local var_12_1
		local var_12_2
		local var_12_3
		local var_12_4

		for iter_12_0, iter_12_1 in pairs(arg_12_1) do
			if iter_12_0 == "country" then
				var_12_1 = iter_12_1
			elseif iter_12_0 == "shipType" or iter_12_0 == "shipTypes" then
				var_12_2 = iter_12_1
			elseif iter_12_0 == "shipTon" or iter_12_0 == "shipTons" then
				var_12_3 = iter_12_1
			elseif iter_12_0 == "guardType" or iter_12_0 == "guardTypes" then
				var_12_4 = iter_12_1
			end
		end

		local var_12_5 = arg_12_1.num

		if arg_12_3 then
			var_12_5 = -var_12_5
		end

		for iter_12_2, iter_12_3 in pairs(var_12_0) do
			if var_12_1 then
				if self:__get_ship_data_by_countrys(iter_12_3, var_12_1) and self:__get_ship_data_by_screen(iter_12_3, var_12_2, var_12_3, var_12_4) then
					var_0_4:update_target_attr(iter_12_3, var_0_3.skil_attribute_type[arg_12_1.num4], var_12_5, arg_12_2)
				end
			elseif self:__get_ship_data_by_screen(iter_12_3, var_12_2, var_12_3, var_12_4) then
				var_0_4:update_target_attr(iter_12_3, var_0_3.skil_attribute_type[arg_12_1.num4], var_12_5, arg_12_2)
			end
		end
	end

	function arg_1_0.__number_to_table(arg_13_0, arg_13_1)
		local var_13_0 = {}

		if type(arg_13_1) == "number" then
			var_0_2(var_13_0, arg_13_1)

			return var_13_0
		end

		return arg_13_1
	end

	function arg_1_0:__get_ship_data_by_countrys(arg_14_1, arg_14_2)
		arg_14_2 = self:__number_to_table(arg_14_2)

		for iter_14_0, iter_14_1 in pairs(arg_14_2) do
			if arg_14_1:get_country() == iter_14_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_types(arg_15_1, arg_15_2)
		arg_15_2 = self:__number_to_table(arg_15_2)

		for iter_15_0, iter_15_1 in pairs(arg_15_2) do
			if arg_15_1:get_ship_type() == iter_15_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_tons(arg_16_1, arg_16_2)
		arg_16_2 = self:__number_to_table(arg_16_2)

		for iter_16_0, iter_16_1 in pairs(arg_16_2) do
			if arg_16_1:get_ship_ton() == iter_16_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_guards(arg_17_1, arg_17_2)
		arg_17_2 = self:__number_to_table(arg_17_2)

		for iter_17_0, iter_17_1 in pairs(arg_17_2) do
			if arg_17_1:get_ship_guard_type() == iter_17_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_screen(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
		if arg_18_2 then
			if self:__get_ship_data_by_types(arg_18_1, arg_18_2) then
				return self:__get_target_by_ship_ton(arg_18_1, arg_18_3, arg_18_4)
			end
		elseif arg_18_3 then
			return self:__get_target_by_ship_ton(arg_18_1, arg_18_3, arg_18_4)
		elseif arg_18_4 then
			return self:__get_ship_data_by_guards(arg_18_1, arg_18_4)
		else
			return true
		end
	end

	function arg_1_0:__get_target_by_ship_ton(arg_19_1, arg_19_2, arg_19_3)
		if arg_19_2 then
			if self:__get_ship_data_by_tons(arg_19_1, arg_19_2) then
				return self:__get_target_by_ship_guard(arg_19_1, arg_19_3)
			else
				return false
			end
		else
			return self:__get_target_by_ship_guard(arg_19_1, arg_19_3)
		end
	end

	function arg_1_0:__get_target_by_ship_guard(arg_20_1, arg_20_2)
		if arg_20_2 then
			if self:__get_ship_data_by_guards(arg_20_1, arg_20_2) then
				return true
			else
				return false
			end
		else
			return true
		end
	end
end

function var_0_0.extend_obj(arg_21_0)
	return
end

return var_0_0
