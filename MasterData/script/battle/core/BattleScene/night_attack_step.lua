local var_0_0 = {}
local var_0_1 = table.insert
local var_0_2 = gameenum.battle_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:get_night_attack_ships()
		local var_2_0 = {}
		local var_2_1 = self._battle_obj_mgr:get_ships_by_side(var_0_2.obj_side.player)
		local var_2_2 = self._battle_obj_mgr:get_ships_by_side(var_0_2.obj_side.enemy)
		local var_2_3 = {}
		local var_2_4 = 1

		if #var_2_1 > #var_2_2 then
			for iter_2_0 = 1, #var_2_1 + #var_2_2 do
				if iter_2_0 % 2 == 0 then
					if var_2_2[var_2_4] then
						var_2_3[iter_2_0] = var_2_2[var_2_4]
						var_2_4 = var_2_4 + 1
					else
						var_2_4 = var_2_4 + 1
						var_2_3[iter_2_0] = var_2_1[var_2_4]
						var_2_4 = var_2_4 + 1
					end
				else
					var_2_3[iter_2_0] = var_2_1[var_2_4]
				end
			end
		else
			for iter_2_1 = 1, #var_2_1 + #var_2_2 do
				if iter_2_1 % 2 == 0 then
					if not var_2_2[var_2_4] then
						var_2_4 = var_2_4 + 1
						var_2_3[iter_2_1] = var_2_1[var_2_4]
					else
						var_2_3[iter_2_1] = var_2_2[var_2_4]
						var_2_4 = var_2_4 + 1
					end
				elseif not var_2_1[var_2_4] then
					var_2_3[iter_2_1] = var_2_2[var_2_4]
					var_2_4 = var_2_4 + 1
				else
					if not var_2_2[var_2_4] then
						var_2_4 = var_2_4 + 1
					end

					var_2_3[iter_2_1] = var_2_1[var_2_4]
				end
			end
		end

		for iter_2_2, iter_2_3 in pairs(var_2_3) do
			local var_2_5 = iter_2_3:is_lowhp()
			local var_2_6 = var_0_2:can_night_attack((iter_2_3:get_ship_type()))

			if iter_2_3:get_night_attack_type() ~= 0 and iter_2_3:get_is_alive() and (not var_2_5 or iter_2_3._battle_scene:get_attack_state_by_hp(nil, iter_2_3) or iter_2_3:get_can_attack_in_broken() or iter_2_3:get_recover_life_state()) then
				if (self:__set_night_fight_tower_buff_effect(var_2_0, iter_2_3) or nil) and true then
					var_0_1(var_2_0, iter_2_3)
				elseif iter_2_3:get_can_night_attack() then
					var_0_1(var_2_0, iter_2_3)
				end
			end
		end

		return var_2_0
	end

	function arg_1_0:__set_night_fight_tower_buff_effect(arg_3_1, arg_3_2)
		if not self:get_attend_night_fight_ship() then
			return false
		end

		local var_3_0 = self:get_attend_night_fight_ship()

		if var_3_0.ship_list then
			for iter_3_0, iter_3_1 in pairs(var_3_0.ship_list) do
				if arg_3_2:getID() == iter_3_1 then
					return true
				end
			end
		end

		return false
	end
end

function var_0_0.extend_obj(arg_4_0)
	return
end

return var_0_0
