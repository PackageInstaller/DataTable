local var_0_0 = {}
local var_0_1 = gameenum.battle_type
local var_0_2 = gamecore.battle_util
local var_0_3 = table.insert

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__on_func_strike_score_attr_add_num(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
		if arg_2_4 ~= "init_attr" then
			return
		end

		if arg_2_2:get_side() == var_0_1.obj_side.enemy then
			return
		end

		if arg_2_3 then
			return
		end

		self:__update_ship_attr_by_effect(arg_2_1, false, false, arg_2_2)
	end

	function arg_1_0:__on_func_strike_score_attr_add_percent(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
		if arg_3_4 ~= "init_attr" then
			return
		end

		if arg_3_3 then
			return
		end

		if arg_3_2:get_side() == var_0_1.obj_side.enemy then
			return
		end

		self:__update_ship_attr_by_effect(arg_3_1, true, false, arg_3_2)
	end

	function arg_1_0:__on_func_strike_score_attack_stage_add_damage(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
		if arg_4_4 == "init_attr" then
			return
		end

		if arg_4_2:get_side() == var_0_1.obj_side.enemy then
			return
		end

		local var_4_0 = false

		if not arg_4_1.stage then
			var_4_0 = true
		else
			for iter_4_0, iter_4_1 in pairs(arg_4_1.stage) do
				if var_0_2:judge_stage(iter_4_1, arg_4_5) then
					var_4_0 = true
				end
			end
		end

		if not var_4_0 then
			return
		end

		for iter_4_2, iter_4_3 in pairs((self:__get_ship_hit_state_by_effect(arg_4_1, arg_4_2))) do
			local var_4_1 = self._battle_obj_mgr:findObject(iter_4_3)

			if not var_4_1:get_attribute().is_increase_this_side_ship_power then
				var_4_1:get_attribute().change_final_damage = var_4_1:get_attribute().change_final_damage or 0
				var_4_1:get_attribute().change_final_damage = (1 + var_4_1:get_attribute().change_final_damage) * (1 + arg_4_1.num / 100) - 1
			end

			var_4_1:get_attribute().is_increase_this_side_ship_power = true
		end
	end

	function arg_1_0:__on_func_strike_score_attacked_stage_reduce_damage_percent(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
		if arg_5_4 == "init_attr" then
			return
		end

		if arg_5_2:get_side() ~= var_0_1.obj_side.enemy then
			return
		end

		if not arg_5_3 then
			return
		end

		local var_5_0 = false

		if not arg_5_1.stage then
			var_5_0 = true
		else
			for iter_5_0, iter_5_1 in pairs(arg_5_1.stage) do
				if var_0_2:judge_stage(iter_5_1, arg_5_5) then
					var_5_0 = true
				end
			end
		end

		if not var_5_0 then
			return
		end

		for iter_5_2, iter_5_3 in pairs((self:__get_ship_hit_state_by_effect(arg_5_1, arg_5_3, arg_5_5))) do
			local var_5_1 = self._battle_obj_mgr:findObject(iter_5_3)

			if not var_5_1:get_attribute().is_reduce_this_ship_damage then
				var_5_1:get_attribute().change_final_be_damage = var_5_1:get_attribute().change_final_be_damage or 0
				var_5_1:get_attribute().change_final_be_damage = (1 + var_5_1:get_attribute().change_final_be_damage) * (1 - arg_5_1.num / 100) - 1
			end

			var_5_1:get_attribute().is_increase_this_side_ship_power = true
		end
	end

	function arg_1_0:__on_func_strike_score_attack_stage_wihtout_hurt(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
		if arg_6_4 == "init_attr" then
			return
		end

		if arg_6_2:get_side() == var_0_1.obj_side.enemy then
			return
		end

		if not arg_6_3 then
			return
		end

		local var_6_0 = false

		if not arg_6_1.stage then
			var_6_0 = true
		else
			for iter_6_0, iter_6_1 in pairs(arg_6_1.stage) do
				if var_0_2:judge_stage(iter_6_1, arg_6_5) then
					var_6_0 = true
				end
			end
		end

		if not var_6_0 then
			return
		end

		for iter_6_2, iter_6_3 in pairs((self:__get_ship_hit_state_by_effect(arg_6_1, arg_6_2))) do
			self._battle_obj_mgr:findObject(iter_6_3):set_battle_damage_state(true)
		end
	end

	function arg_1_0:__on_func_strike_score_attack_stage_wihtout_bullet(arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
		if arg_7_4 == "init_attr" then
			return
		end

		if arg_7_2:get_side() == var_0_1.obj_side.enemy then
			return
		end

		if not arg_7_3 then
			return
		end

		local var_7_0 = false

		if not arg_7_1.stage then
			var_7_0 = true
		else
			for iter_7_0, iter_7_1 in pairs(arg_7_1.stage) do
				if var_0_2:judge_stage(iter_7_1, arg_7_5) then
					var_7_0 = true
				end
			end
		end

		if not var_7_0 then
			return
		end

		for iter_7_2, iter_7_3 in pairs((self:__get_ship_hit_state_by_effect(arg_7_1, arg_7_2))) do
			self._battle_obj_mgr:findObject(iter_7_3):get_attribute().without_bullet_correct = 1
		end
	end

	function arg_1_0:__on_func_strike_score_attack_infallible(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
		if arg_8_4 == "init_attr" then
			return
		end

		if arg_8_2:get_side() == var_0_1.obj_side.enemy then
			return
		end

		if not arg_8_3 then
			return
		end

		local var_8_0 = false

		if not arg_8_1.stage then
			var_8_0 = true
		else
			for iter_8_0, iter_8_1 in pairs(arg_8_1.stage) do
				if var_0_2:judge_stage(iter_8_1, arg_8_5) then
					var_8_0 = true
				end
			end
		end

		if not var_8_0 then
			return
		end

		for iter_8_2, iter_8_3 in pairs((self:__get_ship_hit_state_by_effect(arg_8_1, arg_8_2))) do
			self._battle_obj_mgr:findObject(iter_8_3):set_ignore_miss(true)
		end
	end

	function arg_1_0:__on_func_strike_score_open_torpedo(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
		if arg_9_4 ~= "init_attr" then
			return
		end

		if arg_9_2:get_side() == var_0_1.obj_side.enemy then
			return
		end

		for iter_9_0, iter_9_1 in pairs((self:__get_ship_hit_state_by_effect(arg_9_1, arg_9_2))) do
			self._battle_obj_mgr:findObject(iter_9_1):set_unlock_open_torpedo_attack(true)
		end
	end

	function arg_1_0:__get_ship_hit_state_by_effect(arg_10_1, arg_10_2)
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
		local var_10_5 = {}

		table.insert(var_10_5, arg_10_2)

		for iter_10_2, iter_10_3 in pairs(var_10_5) do
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

	function arg_1_0:__update_ship_attr_by_effect(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
		local var_11_0 = {}

		table.insert(var_11_0, arg_11_4)

		local var_11_1
		local var_11_2
		local var_11_3
		local var_11_4

		for iter_11_0, iter_11_1 in pairs(arg_11_1) do
			if iter_11_0 == "country" then
				var_11_1 = iter_11_1
			elseif iter_11_0 == "shipType" or iter_11_0 == "shipTypes" then
				var_11_2 = iter_11_1
			elseif iter_11_0 == "shipTon" or iter_11_0 == "shipTons" then
				var_11_3 = iter_11_1
			elseif iter_11_0 == "guardType" or iter_11_0 == "guardTypes" then
				var_11_4 = iter_11_1
			end
		end

		local var_11_5 = arg_11_1.num

		if arg_11_3 then
			var_11_5 = -var_11_5
		end

		for iter_11_2, iter_11_3 in pairs(var_11_0) do
			if var_11_1 then
				if self:__get_ship_data_by_countrys(iter_11_3, var_11_1) and self:__get_ship_data_by_screen(iter_11_3, var_11_2, var_11_3, var_11_4) then
					var_0_2:update_target_attr(iter_11_3, var_0_1.skil_attribute_type[arg_11_1.num4], var_11_5, arg_11_2)
				end
			elseif self:__get_ship_data_by_screen(iter_11_3, var_11_2, var_11_3, var_11_4) then
				var_0_2:update_target_attr(iter_11_3, var_0_1.skil_attribute_type[arg_11_1.num4], var_11_5, arg_11_2)
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
