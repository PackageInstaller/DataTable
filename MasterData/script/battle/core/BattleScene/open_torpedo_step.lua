local var_0_0 = {}
local var_0_1 = table.insert
local var_0_2 = gameenum.battle_type
local var_0_3 = gamecore.battle_util

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:enter_open_torpedo()
		local var_2_0 = false
		local var_2_1 = {}

		if var_0_3:dict_length((self._battle_obj_mgr:get_sea_ships_by_side(var_0_2.obj_side.player))) == 0 and var_0_3:dict_length((self._battle_obj_mgr:get_sea_ships_by_side(var_0_2.obj_side.enemy))) == 0 then
			return false, var_2_1
		end

		local var_2_2 = self._battle_obj_mgr:get_all_ships()

		self:__set_combination_skills(var_2_1, var_2_0, var_0_2.obj_side.player)
		self:__set_combination_skills(var_2_1, var_2_0, var_0_2.obj_side.enemy)

		if #var_2_1 ~= 0 then
			var_2_0 = true
		end

		for iter_2_0, iter_2_1 in pairs(var_2_2) do
			local var_2_3 = iter_2_1:get_is_alive()
			local var_2_4 = iter_2_1:get_level()
			local var_2_5 = iter_2_1:is_lowhp()
			local var_2_6 = var_0_2:is_open_torpedo_attack(iter_2_1:get_ship_type())
			local var_2_7 = false
			local var_2_8 = iter_2_1:get_can_open_torpedo_attack()

			if iter_2_1:get_unlock_open_torpedo_attack() then
				var_2_7 = true
			end

			if iter_2_1:get_ship_type() == 25 then
				if var_2_7 and (not var_2_5 or iter_2_1:get_can_attack_in_broken()) and var_2_3 then
					var_2_0 = true

					self:__set_ship_in_list(var_2_1, iter_2_1)
				end
			elseif (var_2_4 > 10 and var_2_6 or var_2_7) and var_2_3 and (not var_2_5 or iter_2_1:get_can_attack_in_broken()) then
				var_2_0 = true

				self:__set_ship_in_list(var_2_1, iter_2_1)
			elseif var_2_8 and var_2_3 and (not var_2_5 or iter_2_1:get_can_attack_in_broken()) then
				var_2_0 = true

				self:__set_ship_in_list(var_2_1, iter_2_1)
			end

			if var_2_5 and self:get_attack_state_by_hp(var_2_1, iter_2_1) then
				var_2_0 = true

				self:__set_ship_in_list(var_2_1, iter_2_1)
			end
		end

		table.sort(var_2_1, function(arg_3_0, arg_3_1)
			if arg_3_0:get_side() ~= arg_3_1:get_side() then
				return arg_3_0:get_side() > arg_3_1:get_side()
			else
				return arg_3_0:get_index() < arg_3_1:get_index()
			end
		end)

		self.open_torpedo_ships = var_2_1

		return var_2_0, var_2_1
	end

	function arg_1_0:save_open_torpedo_ships()
		local var_4_0 = 7

		for iter_4_0, iter_4_1 in pairs(self.open_torpedo_ships) do
			if var_4_0 > iter_4_1:get_index() and iter_4_1:get_side() == var_0_2.obj_side.player then
				var_4_0 = iter_4_1:get_index()
			end
		end

		return var_4_0
	end

	function arg_1_0:__set_fight_buff_effect(arg_5_1, arg_5_2)
		local var_5_0 = self:get_enemy_open_torpedo_info()

		if var_5_0 then
			for iter_5_0, iter_5_1 in pairs(var_5_0) do
				if arg_5_2:get_ship_type() == iter_5_1 and not var_0_3:get_exist_state(arg_5_1, arg_5_2) then
					return true
				end
			end
		end

		return false
	end

	function arg_1_0:__set_combination_skills(arg_6_1, arg_6_2, arg_6_3)
		local var_6_0 = false
		local var_6_1 = false
		local var_6_2

		for iter_6_0, iter_6_1 in pairs((self._battle_obj_mgr:get_ships_by_side(arg_6_3))) do
			if iter_6_1:get_attribute().couple_by_shipcid then
				for iter_6_2, iter_6_3 in pairs(iter_6_1:get_attribute().couple_by_shipcid.couple) do
					for iter_6_4, iter_6_5 in pairs(iter_6_3) do
						if iter_6_5 == iter_6_1:get_cid() and iter_6_1:get_is_alive() and not iter_6_1:is_lowhp() and iter_6_1:get_attribute().couple_by_shipcid then
							if not var_6_0 and iter_6_1:get_is_alive() and not iter_6_1:is_lowhp() then
								parter_index = iter_6_1:get_index()
								parter_id = iter_6_1:getID()
								parter_cid = iter_6_1:get_cid()
								var_6_0 = true
								var_6_2 = iter_6_1
							elseif iter_6_1:get_is_alive() and not iter_6_1:is_lowhp() then
								var_6_1 = true
							end
						end
					end
				end
			end
		end

		if var_6_0 == true and var_6_1 == true then
			self:__set_ship_in_list(arg_6_1, var_6_2)
			self:__set_ship_in_list(arg_6_1, nil)
		end
	end

	function arg_1_0.__set_ship_in_list(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = true

		for iter_7_0, iter_7_1 in pairs(arg_7_1) do
			if iter_7_1:getID() == arg_7_2:getID() then
				var_7_0 = false
			end
		end

		if var_7_0 then
			var_0_1(arg_7_1, arg_7_2)
		end
	end
end

function var_0_0.extend_obj(arg_8_0)
	return
end

return var_0_0
