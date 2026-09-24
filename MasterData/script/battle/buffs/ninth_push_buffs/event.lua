local var_0_0 = {}
local var_0_1 = table.insert
local var_0_2 = gameenum.battle_type
local var_0_3 = gamecore.battle_util

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__on_func_ninth_attr_add_num(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
		if arg_2_4 ~= "init_attr" then
			return
		end

		if arg_2_2:get_side() == var_0_2.obj_side.enemy then
			return
		end

		if arg_2_3 then
			return
		end

		self:__update_ship_attr_by_effect(arg_2_1, false, false, arg_2_2)
	end

	function arg_1_0:__on_func_ninth_attr_add_percent(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
		if arg_3_4 ~= "init_attr" then
			return
		end

		if arg_3_3 then
			return
		end

		if arg_3_2:get_side() == var_0_2.obj_side.enemy then
			return
		end

		self:__update_ship_attr_by_effect(arg_3_1, true, false, arg_3_2)
	end

	function arg_1_0:__on_func_ninth_attack_stage_add_damage(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
		if arg_4_4 == "init_attr" then
			return
		end

		if arg_4_2:get_side() == var_0_2.obj_side.enemy then
			return
		end

		local var_4_0 = false

		if not arg_4_1.stage then
			var_4_0 = true
		else
			for iter_4_0, iter_4_1 in pairs(arg_4_1.stage) do
				if var_0_3:judge_stage(iter_4_1, arg_4_5) then
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

	function arg_1_0:__on_func_ninth_attacked_stage_reduce_damage_percent(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
		if arg_5_4 == "init_attr" then
			return
		end

		if arg_5_2:get_side() ~= var_0_2.obj_side.enemy then
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
				if var_0_3:judge_stage(iter_5_1, arg_5_5) then
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

	function arg_1_0:__on_func_ninth_attack_stage_wihtout_hurt(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
		if arg_6_4 == "init_attr" then
			return
		end

		if arg_6_2:get_side() == var_0_2.obj_side.enemy then
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
				if var_0_3:judge_stage(iter_6_1, arg_6_5) then
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

	function arg_1_0:__on_func_ninth_attack_stage_wihtout_bullet(arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
		if arg_7_4 == "init_attr" then
			return
		end

		if arg_7_2:get_side() == var_0_2.obj_side.enemy then
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
				if var_0_3:judge_stage(iter_7_1, arg_7_5) then
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

	function arg_1_0:__on_func_ninth_attack_infallible(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
		if arg_8_4 == "init_attr" then
			return
		end

		if arg_8_2:get_side() == var_0_2.obj_side.enemy then
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
				if var_0_3:judge_stage(iter_8_1, arg_8_5) then
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

	function arg_1_0:__on_func_ninth_open_torpedo(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
		if arg_9_4 ~= "init_attr" then
			return
		end

		if arg_9_2:get_side() == var_0_2.obj_side.enemy then
			return
		end

		for iter_9_0, iter_9_1 in pairs((self:__get_ship_hit_state_by_effect(arg_9_1, arg_9_2))) do
			self._battle_obj_mgr:findObject(iter_9_1):set_unlock_open_torpedo_attack(true)
		end
	end

	function arg_1_0:__on_func_ninth_open_antisub_attack(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
		if arg_10_4 ~= "init_attr" then
			return
		end

		if arg_10_2:get_side() == var_0_2.obj_side.enemy then
			return
		end

		local var_10_0 = self:__get_ship_hit_state_by_effect(arg_10_1, arg_10_2)

		self._can_open_antisub_list = self._can_open_antisub_list or {}

		if next(var_10_0) then
			for iter_10_0, iter_10_1 in pairs(var_10_0) do
				var_0_1(self._can_open_antisub_list, iter_10_1)
			end
		end

		self._battle_scene:set_open_antisub({
			ship_list = self._can_open_antisub_list
		})
	end

	function arg_1_0:__on_func_ninth_get_ships_num_add_attr(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
		if arg_11_4 ~= "init_attr" then
			return
		end

		if arg_11_2:get_side() == var_0_2.obj_side.enemy then
			return
		end

		local var_11_0 = var_0_2.skil_attribute_type[arg_11_1.num4]
		local var_11_1, var_11_2 = self:__update_allship_attr_by_effect(arg_11_1, false, false, arg_11_2)

		self._save_canot_ships = self._save_canot_ships or {}

		if var_11_1 then
			for iter_11_0 = #self._save_canot_ships, 1, -1 do
				if var_11_2 then
					if self:__get_ship_data_by_countrys(self._save_canot_ships[iter_11_0], var_11_2) then
						var_0_3:update_target_attr(self._save_canot_ships[iter_11_0], var_11_0, arg_11_1.num, false)
					end
				else
					var_0_3:update_target_attr(self._save_canot_ships[iter_11_0], var_11_0, arg_11_1.num, false)
				end

				table.remove(self._save_canot_ships, iter_11_0)
			end

			var_0_3:update_target_attr(arg_11_2, var_11_0, arg_11_1.num, false)
		else
			var_0_1(self._save_canot_ships, arg_11_2)
		end
	end

	function arg_1_0:__on_func_ninth_get_support_attack(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
		if arg_12_4 ~= "init_attr" then
			return
		end

		if arg_12_2:get_side() == var_0_2.obj_side.enemy then
			return
		end

		if arg_12_1.node_id then
			for iter_12_0, iter_12_1 in pairs(arg_12_1.node_id) do
				if self._battle_scene:get_battle_point() == iter_12_1 then
					self._battle_scene:set_support_id(arg_12_1.support_id)
				end
			end
		end
	end

	function arg_1_0:__get_ship_hit_state_by_effect(arg_13_1, arg_13_2)
		local var_13_0
		local var_13_1
		local var_13_2
		local var_13_3

		for iter_13_0, iter_13_1 in pairs(arg_13_1) do
			if iter_13_0 == "country" then
				var_13_0 = iter_13_1
			elseif iter_13_0 == "shipType" or iter_13_0 == "shipTypes" then
				var_13_1 = iter_13_1
			elseif iter_13_0 == "shipTon" or iter_13_0 == "shipTons" then
				var_13_2 = iter_13_1
			elseif iter_13_0 == "guardType" or iter_13_0 == "guardTypes" then
				var_13_3 = iter_13_1
			end
		end

		local var_13_4 = {}
		local var_13_5 = {}

		table.insert(var_13_5, arg_13_2)

		for iter_13_2, iter_13_3 in pairs(var_13_5) do
			if var_13_0 then
				if self:__get_ship_data_by_countrys(iter_13_3, var_13_0) and self:__get_ship_data_by_screen(iter_13_3, var_13_1, var_13_2, var_13_3) then
					var_0_1(var_13_4, iter_13_3:getID())
				end
			elseif self:__get_ship_data_by_screen(iter_13_3, var_13_1, var_13_2, var_13_3) then
				var_0_1(var_13_4, iter_13_3:getID())
			end
		end

		return var_13_4
	end

	function arg_1_0:__update_ship_attr_by_effect(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
		local var_14_0 = {}

		table.insert(var_14_0, arg_14_4)

		local var_14_1
		local var_14_2
		local var_14_3
		local var_14_4

		for iter_14_0, iter_14_1 in pairs(arg_14_1) do
			if iter_14_0 == "country" then
				var_14_1 = iter_14_1
			elseif iter_14_0 == "shipType" or iter_14_0 == "shipTypes" then
				var_14_2 = iter_14_1
			elseif iter_14_0 == "shipTon" or iter_14_0 == "shipTons" then
				var_14_3 = iter_14_1
			elseif iter_14_0 == "guardType" or iter_14_0 == "guardTypes" then
				var_14_4 = iter_14_1
			end
		end

		local var_14_5 = arg_14_1.num

		if arg_14_3 then
			var_14_5 = -var_14_5
		end

		for iter_14_2, iter_14_3 in pairs(var_14_0) do
			if var_14_1 then
				if self:__get_ship_data_by_countrys(iter_14_3, var_14_1) and self:__get_ship_data_by_screen(iter_14_3, var_14_2, var_14_3, var_14_4) then
					var_0_3:update_target_attr(iter_14_3, var_0_2.skil_attribute_type[arg_14_1.num4], var_14_5, arg_14_2)
				end
			elseif self:__get_ship_data_by_screen(iter_14_3, var_14_2, var_14_3, var_14_4) then
				var_0_3:update_target_attr(iter_14_3, var_0_2.skil_attribute_type[arg_14_1.num4], var_14_5, arg_14_2)
			end
		end
	end

	function arg_1_0:__update_allship_attr_by_effect(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
		var_0_1({}, arg_15_4)

		local var_15_0
		local var_15_1
		local var_15_2
		local var_15_3

		for iter_15_0, iter_15_1 in pairs(arg_15_1) do
			if iter_15_0 == "country" then
				var_15_0 = iter_15_1
			elseif iter_15_0 == "shipType" or iter_15_0 == "shipTypes" then
				var_15_1 = iter_15_1
			elseif iter_15_0 == "shipTon" or iter_15_0 == "shipTons" then
				var_15_2 = iter_15_1
			elseif iter_15_0 == "guardType" or iter_15_0 == "guardTypes" then
				var_15_3 = iter_15_1
			end
		end

		local var_15_6 = {}

		for iter_15_2, iter_15_3 in pairs((self._battle_obj_mgr:get_ships_by_side(var_0_2.obj_side.player))) do
			if var_15_1 then
				for iter_15_4, iter_15_5 in pairs(var_15_1) do
					if iter_15_3:get_ship_type() == iter_15_5 then
						var_0_1(var_15_6, iter_15_3)
					end
				end
			elseif var_15_2 then
				for iter_15_6, iter_15_7 in pairs(var_15_2) do
					if iter_15_3:get_ship_ton() == iter_15_7 then
						var_0_1(var_15_6, iter_15_3)
					end
				end
			else
				for iter_15_8, iter_15_9 in pairs(var_15_3) do
					if iter_15_3:get_ship_guard_type() == iter_15_9 then
						var_0_1(var_15_6, iter_15_3)
					end
				end
			end
		end

		if arg_15_1.num2 <= #var_15_6 then
			return true, var_15_0
		else
			return false
		end
	end

	function arg_1_0.__number_to_table(arg_16_0, arg_16_1)
		local var_16_0 = {}

		if type(arg_16_1) == "number" then
			var_0_1(var_16_0, arg_16_1)

			return var_16_0
		end

		return arg_16_1
	end

	function arg_1_0:__get_ship_data_by_countrys(arg_17_1, arg_17_2)
		arg_17_2 = self:__number_to_table(arg_17_2)

		for iter_17_0, iter_17_1 in pairs(arg_17_2) do
			if arg_17_1:get_country() == iter_17_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_types(arg_18_1, arg_18_2)
		arg_18_2 = self:__number_to_table(arg_18_2)

		for iter_18_0, iter_18_1 in pairs(arg_18_2) do
			if arg_18_1:get_ship_type() == iter_18_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_tons(arg_19_1, arg_19_2)
		arg_19_2 = self:__number_to_table(arg_19_2)

		for iter_19_0, iter_19_1 in pairs(arg_19_2) do
			if arg_19_1:get_ship_ton() == iter_19_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_guards(arg_20_1, arg_20_2)
		arg_20_2 = self:__number_to_table(arg_20_2)

		for iter_20_0, iter_20_1 in pairs(arg_20_2) do
			if arg_20_1:get_ship_guard_type() == iter_20_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_screen(arg_21_1, arg_21_2, arg_21_3, arg_21_4)
		if arg_21_2 then
			if self:__get_ship_data_by_types(arg_21_1, arg_21_2) then
				return self:__get_target_by_ship_ton(arg_21_1, arg_21_3, arg_21_4)
			end
		elseif arg_21_3 then
			return self:__get_target_by_ship_ton(arg_21_1, arg_21_3, arg_21_4)
		elseif arg_21_4 then
			return self:__get_ship_data_by_guards(arg_21_1, arg_21_4)
		else
			return true
		end
	end

	function arg_1_0:__get_target_by_ship_ton(arg_22_1, arg_22_2, arg_22_3)
		if arg_22_2 then
			if self:__get_ship_data_by_tons(arg_22_1, arg_22_2) then
				return self:__get_target_by_ship_guard(arg_22_1, arg_22_3)
			else
				return false
			end
		else
			return self:__get_target_by_ship_guard(arg_22_1, arg_22_3)
		end
	end

	function arg_1_0:__get_target_by_ship_guard(arg_23_1, arg_23_2)
		if arg_23_2 then
			if self:__get_ship_data_by_guards(arg_23_1, arg_23_2) then
				return true
			else
				return false
			end
		else
			return true
		end
	end
end

function var_0_0.extend_obj(arg_24_0)
	return
end

return var_0_0
