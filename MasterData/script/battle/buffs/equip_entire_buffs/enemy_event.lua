local var_0_0 = {}
local var_0_1 = gameenum.battle_type
local var_0_3 = table.insert
local var_0_5 = gamecore.battle_util

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.__on_func_enemy_equip_entire_buffs_air_down(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
		if arg_2_4 == "init_attr" then
			return
		end

		if arg_2_2:get_side() == var_0_1.obj_side.enemy then
			return
		end

		if not arg_2_3 then
			return
		end

		local var_2_0 = false

		if not arg_2_1.stage then
			var_2_0 = true
		else
			for iter_2_0, iter_2_1 in pairs(arg_2_1.stage) do
				if var_0_5:judge_stage(iter_2_1, arg_2_5) then
					var_2_0 = true
				end
			end
		end

		if not var_2_0 then
			return
		end

		local var_2_1 = arg_2_1.num / 100 or 0

		if arg_2_1.equip_cid then
			if not arg_2_3:get_attribute().down_air_by_enemy then
				arg_2_3:get_attribute().down_air_by_enemy = {
					num = -var_2_1,
					effect_type = var_0_1.equip_special_effect_type.reduce_enemy_aircraft_hit
				}
			else
				arg_2_3:get_attribute().down_air_by_enemy.num = arg_2_3:get_attribute().down_air_by_enemy.num - var_2_1
			end
		end
	end

	function arg_1_0:__get_ship_hit_state_by_effect(arg_3_1, arg_3_2)
		local var_3_0
		local var_3_1
		local var_3_2
		local var_3_3

		for iter_3_0, iter_3_1 in pairs(arg_3_1) do
			if iter_3_0 == "country" then
				var_3_0 = iter_3_1
			elseif iter_3_0 == "shipType" or iter_3_0 == "shipTypes" then
				var_3_1 = iter_3_1
			elseif iter_3_0 == "shipTon" or iter_3_0 == "shipTons" then
				var_3_2 = iter_3_1
			elseif iter_3_0 == "guardType" or iter_3_0 == "guardTypes" then
				var_3_3 = iter_3_1
			end
		end

		local var_3_4 = {}
		local var_3_5 = {}

		table.insert(var_3_5, arg_3_2)

		for iter_3_2, iter_3_3 in pairs(var_3_5) do
			if var_3_0 then
				if self:__get_ship_data_by_countrys(iter_3_3, var_3_0) and self:__get_ship_data_by_screen(iter_3_3, var_3_1, var_3_2, var_3_3) then
					var_0_3(var_3_4, iter_3_3:getID())
				end
			elseif self:__get_ship_data_by_screen(iter_3_3, var_3_1, var_3_2, var_3_3) then
				var_0_3(var_3_4, iter_3_3:getID())
			end
		end

		return var_3_4
	end

	function arg_1_0:__update_ship_attr_by_effect(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
		local var_4_0 = {}

		table.insert(var_4_0, arg_4_4)

		local var_4_1
		local var_4_2
		local var_4_3
		local var_4_4

		for iter_4_0, iter_4_1 in pairs(arg_4_1) do
			if iter_4_0 == "country" then
				var_4_1 = iter_4_1
			elseif iter_4_0 == "shipType" or iter_4_0 == "shipTypes" then
				var_4_2 = iter_4_1
			elseif iter_4_0 == "shipTon" or iter_4_0 == "shipTons" then
				var_4_3 = iter_4_1
			elseif iter_4_0 == "guardType" or iter_4_0 == "guardTypes" then
				var_4_4 = iter_4_1
			end
		end

		local var_4_5 = arg_4_1.num

		if arg_4_3 then
			var_4_5 = -var_4_5
		end

		for iter_4_2, iter_4_3 in pairs(var_4_0) do
			if var_4_1 then
				if self:__get_ship_data_by_countrys(iter_4_3, var_4_1) and self:__get_ship_data_by_screen(iter_4_3, var_4_2, var_4_3, var_4_4) then
					var_0_5:update_target_attr(iter_4_3, var_0_1.skil_attribute_type[arg_4_1.num4], var_4_5, arg_4_2)
				end
			elseif self:__get_ship_data_by_screen(iter_4_3, var_4_2, var_4_3, var_4_4) then
				var_0_5:update_target_attr(iter_4_3, var_0_1.skil_attribute_type[arg_4_1.num4], var_4_5, arg_4_2)
			end
		end
	end

	function arg_1_0.__number_to_table(arg_5_0, arg_5_1)
		local var_5_0 = {}

		if type(arg_5_1) == "number" then
			var_0_3(var_5_0, arg_5_1)

			return var_5_0
		end

		return arg_5_1
	end

	function arg_1_0:__get_ship_data_by_countrys(arg_6_1, arg_6_2)
		arg_6_2 = self:__number_to_table(arg_6_2)

		for iter_6_0, iter_6_1 in pairs(arg_6_2) do
			if arg_6_1:get_country() == iter_6_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_types(arg_7_1, arg_7_2)
		arg_7_2 = self:__number_to_table(arg_7_2)

		for iter_7_0, iter_7_1 in pairs(arg_7_2) do
			if arg_7_1:get_ship_type() == iter_7_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_tons(arg_8_1, arg_8_2)
		arg_8_2 = self:__number_to_table(arg_8_2)

		for iter_8_0, iter_8_1 in pairs(arg_8_2) do
			if arg_8_1:get_ship_ton() == iter_8_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_guards(arg_9_1, arg_9_2)
		arg_9_2 = self:__number_to_table(arg_9_2)

		for iter_9_0, iter_9_1 in pairs(arg_9_2) do
			if arg_9_1:get_ship_guard_type() == iter_9_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_screen(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
		if arg_10_2 then
			if self:__get_ship_data_by_types(arg_10_1, arg_10_2) then
				return self:__get_target_by_ship_ton(arg_10_1, arg_10_3, arg_10_4)
			end
		elseif arg_10_3 then
			return self:__get_target_by_ship_ton(arg_10_1, arg_10_3, arg_10_4)
		elseif arg_10_4 then
			return self:__get_ship_data_by_guards(arg_10_1, arg_10_4)
		else
			return true
		end
	end

	function arg_1_0:__get_target_by_ship_ton(arg_11_1, arg_11_2, arg_11_3)
		if arg_11_2 then
			if self:__get_ship_data_by_tons(arg_11_1, arg_11_2) then
				return self:__get_target_by_ship_guard(arg_11_1, arg_11_3)
			else
				return false
			end
		else
			return self:__get_target_by_ship_guard(arg_11_1, arg_11_3)
		end
	end

	function arg_1_0:__get_target_by_ship_guard(arg_12_1, arg_12_2)
		if arg_12_2 then
			if self:__get_ship_data_by_guards(arg_12_1, arg_12_2) then
				return true
			else
				return false
			end
		else
			return true
		end
	end
end

function var_0_0.extend_obj(arg_13_0)
	return
end

return var_0_0
