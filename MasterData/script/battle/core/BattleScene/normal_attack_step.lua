local var_0_0 = {}
local var_0_1 = table.sort
local var_0_2 = table.insert
local var_0_3 = table.remove
local var_0_4 = gameenum.battle_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:enter_normal_attack()
		self:__have_ship_type(self._battle_obj_mgr:get_ships_by_side(var_0_4.obj_side.player), false, false)
		self:__have_ship_type(self._battle_obj_mgr:get_ships_by_side(var_0_4.obj_side.enemy), false, false)

		return (false and false and not false and not false or nil) and false
	end

	function arg_1_0:enter_normal_attack2()
		local var_3_0 = false

		for iter_3_0, iter_3_1 in pairs((self._battle_obj_mgr:get_all_ships())) do
			var_3_0 = (iter_3_1:get_range() >= var_0_4.range_type.long or iter_3_1:get_can_enter_normal_attack()) and true
		end

		return var_3_0
	end

	function arg_1_0:get_all_attack_ships(arg_4_1)
		local var_4_0 = self:__fliter_normal_attack_ships((self._battle_obj_mgr:get_ships_by_side(var_0_4.obj_side.player)))
		local var_4_1 = self:__fliter_normal_attack_ships((self._battle_obj_mgr:get_ships_by_side(var_0_4.obj_side.enemy)))

		var_0_1(var_4_0, function(arg_5_0, arg_5_1)
			if arg_4_1 == "normal_attack2" then
				return arg_5_0:get_index() < arg_5_1:get_index()
			end

			local var_5_1 = arg_5_0:get_attribute().range:get_final_value()
			local var_5_2 = arg_5_1:get_attribute().range:get_final_value()

			if var_5_1 == var_5_2 then
				return arg_5_1:get_normal_attack_order() < arg_5_0:get_normal_attack_order()
			end

			return var_5_2 < var_5_1
		end)
		var_0_1(var_4_1, function(arg_6_0, arg_6_1)
			if arg_4_1 == "normal_attack2" then
				return arg_6_0:get_index() < arg_6_1:get_index()
			end

			local var_6_1 = arg_6_0:get_attribute().range:get_final_value()
			local var_6_2 = arg_6_1:get_attribute().range:get_final_value()

			if var_6_1 == var_6_2 then
				return arg_6_1:get_normal_attack_order() < arg_6_0:get_normal_attack_order()
			end

			return var_6_2 < var_6_1
		end)

		local var_4_2 = self:__set_hit_num_by_skill(var_4_0)
		local var_4_3 = self:__set_hit_num_by_skill(var_4_1)
		local var_4_4 = {}
		local var_4_5 = 1

		if #var_4_2 > #var_4_3 then
			for iter_4_0 = 1, #var_4_2 + #var_4_3 do
				if iter_4_0 % 2 == 0 then
					if var_4_3[var_4_5] then
						var_4_4[iter_4_0] = var_4_3[var_4_5]
						var_4_5 = var_4_5 + 1
					else
						var_4_5 = var_4_5 + 1
						var_4_4[iter_4_0] = var_4_2[var_4_5]
						var_4_5 = var_4_5 + 1
					end
				else
					var_4_4[iter_4_0] = var_4_2[var_4_5]
				end
			end
		else
			for iter_4_1 = 1, #var_4_2 + #var_4_3 do
				if iter_4_1 % 2 == 0 then
					if not var_4_3[var_4_5] then
						var_4_5 = var_4_5 + 1
						var_4_4[iter_4_1] = var_4_2[var_4_5]
					else
						var_4_4[iter_4_1] = var_4_3[var_4_5]
						var_4_5 = var_4_5 + 1
					end
				elseif not var_4_2[var_4_5] then
					var_4_4[iter_4_1] = var_4_3[var_4_5]
					var_4_5 = var_4_5 + 1
				else
					if not var_4_3[var_4_5] then
						var_4_5 = var_4_5 + 1
					end

					var_4_4[iter_4_1] = var_4_2[var_4_5]
				end
			end
		end

		local var_4_6 = {}

		for iter_4_2, iter_4_3 in pairs(var_4_4) do
			local var_4_7 = iter_4_3:is_lowhp()
			local var_4_8 = iter_4_3:is_medhp()

			if var_0_4:is_normal_attack_type((iter_4_3:get_ship_type())) or iter_4_3:get_can_enter_normal_attack() then
				var_4_6[1] = iter_4_3
			end
		end

		local var_4_10 = {}

		if arg_4_1 == "normal_attack2" then
			for iter_4_4, iter_4_5 in pairs(var_4_6) do
				if iter_4_5:get_range() >= var_0_4.range_type.long or iter_4_5:get_can_enter_normal_attack() then
					var_0_2(var_4_10, iter_4_5)
				end
			end

			return var_4_10
		end

		return var_4_6
	end

	function arg_1_0.__set_hit_num_by_skill(arg_7_0, arg_7_1)
		for iter_7_0, iter_7_1 in pairs(arg_7_1) do
			if iter_7_1:get_attribute().set_hit_num_in_normal_atk then
				local var_7_0 = iter_7_1:get_attribute().set_hit_num_in_normal_atk

				if arg_7_1 and var_7_0 > #arg_7_1 then
					var_0_2(arg_7_1, iter_7_1)
					var_0_3(arg_7_1, iter_7_0)
				else
					var_0_3(arg_7_1, iter_7_0)
					var_0_2(arg_7_1, var_7_0, iter_7_1)
				end
			end
		end

		return arg_7_1
	end

	function arg_1_0.__have_ship_type(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		for iter_8_0, iter_8_1 in pairs(arg_8_1) do
			if iter_8_1:get_ship_type() == var_0_4.ship_type.submarine then
				arg_8_2 = true
			end

			if iter_8_1:get_ship_type() == var_0_4.ship_type.light_cruiser or iter_8_1:get_ship_type() == var_0_4.ship_type.destroyer then
				arg_8_3 = true
			end
		end
	end

	function arg_1_0.__fliter_normal_attack_ships(arg_9_0, arg_9_1)
		local var_9_0 = {}

		for iter_9_0, iter_9_1 in pairs(arg_9_1) do
			if var_0_4:is_normal_attack_type((iter_9_1:get_ship_type())) and iter_9_1:get_init_hp() ~= 0 then
				var_9_0[1] = iter_9_1
			end
		end

		return var_9_0
	end
end

function var_0_0.extend_obj(arg_10_0)
	return
end

return var_0_0
