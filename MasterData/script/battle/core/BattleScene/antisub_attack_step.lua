local var_0_0 = {}
local var_0_1 = table.insert
local var_0_2 = gameenum.battle_type
local var_0_3 = gamecore.battle_util

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:enter_antisub_attack()
		local var_2_0 = false
		local var_2_1 = false

		if var_0_3:dict_length((self._battle_obj_mgr:get_all_sea_ships())) == 0 or var_0_3:dict_length((self._battle_obj_mgr:get_all_undersea_ships())) == 0 then
			return false
		end

		if self._player_formation == var_0_2.formation_type.single_cross then
			var_2_0 = self:__can_attack_lac(var_0_2.obj_side.player) and #self._battle_obj_mgr:get_undersea_ships_by_side(var_0_2.obj_side.enemy) > 0
		end

		if self._enemy_formation == var_0_2.formation_type.single_cross then
			var_2_1 = self:__can_attack_lac(var_0_2.obj_side.enemy) and #self._battle_obj_mgr:get_undersea_ships_by_side(var_0_2.obj_side.player) > 0
		end

		return var_2_0 or var_2_1, var_2_0, var_2_1
	end

	function arg_1_0:have_sp_skill_enter_antisub_attack()
		local var_3_0 = false
		local var_3_1 = false
		local var_3_2 = false
		local var_3_3 = false

		if var_0_3:dict_length((self._battle_obj_mgr:get_all_sea_ships())) == 0 or var_0_3:dict_length((self._battle_obj_mgr:get_all_undersea_ships())) == 0 then
			return false
		end

		if self._player_formation ~= var_0_2.formation_type.single_cross then
			local var_3_4 = self._battle_obj_mgr:get_undersea_ships_by_side(var_0_2.obj_side.enemy)

			var_3_0 = self:__can_have_attack_skill(var_0_2.obj_side.player) and #var_3_4 > 0

			if #var_3_4 > 0 then
				var_3_3 = true
			end
		end

		if self._enemy_formation ~= var_0_2.formation_type.single_cross then
			local var_3_5 = self._battle_obj_mgr:get_undersea_ships_by_side(var_0_2.obj_side.player)

			var_3_1 = self:__can_have_attack_skill(var_0_2.obj_side.enemy) and #var_3_5 > 0

			if #var_3_5 > 0 then
				var_3_2 = true
			end
		end

		return var_3_0, var_3_1, var_3_2, var_3_3
	end

	function arg_1_0:get_open_antisub_attack_ships(arg_4_1, arg_4_2, arg_4_3)
		local var_4_0 = {}
		local var_4_1 = {}

		if arg_4_2 then
			var_4_1 = self._battle_obj_mgr:get_sea_ships_by_side(var_0_2.obj_side.player)
		end

		if arg_4_3 then
			var_4_1 = self._battle_obj_mgr:get_sea_ships_by_side(var_0_2.obj_side.enemy)
		end

		for iter_4_0, iter_4_1 in pairs((arg_4_2 and arg_4_3 or nil) and self._battle_obj_mgr:get_all_sea_ships()) do
			local var_4_2 = iter_4_1:get_ship_type()
			local var_4_3 = iter_4_1:have_bomber_or_torpedoplane()
			local var_4_4 = iter_4_1:hp_more_than_half()
			local var_4_5 = iter_4_1:get_is_alive()

			if var_0_2:is_open_antisub_attack_type(var_4_2) then
				if var_4_2 == var_0_2.ship_type_rule.light_aircraft_carrier.value then
					local var_4_6 = iter_4_1:get_attribute().skill_num

					if (var_4_4 or var_4_6 and var_4_6.antisub_ignore_broken_hp or iter_4_1:get_can_attack_in_broken()) and var_4_3 then
						var_0_1(var_4_0, iter_4_1)
					end
				elseif arg_4_1 ~= true then
					var_0_1(var_4_0, iter_4_1)
				end
			end
		end

		table.sort(var_4_0, function(arg_5_0, arg_5_1)
			if arg_5_0:get_side() ~= arg_5_1:get_side() then
				return arg_5_0:get_side() > arg_5_1:get_side()
			else
				return arg_5_0:get_index() < arg_5_1:get_index()
			end
		end)

		return var_4_0
	end

	function arg_1_0:get_sp_open_antisub_skill_ships(arg_6_1, arg_6_2)
		local var_6_0 = {}
		local var_6_1 = {}

		if arg_6_1 then
			var_6_1 = self._battle_obj_mgr:get_sea_ships_by_side(var_0_2.obj_side.player)
		end

		if arg_6_2 then
			var_6_1 = self._battle_obj_mgr:get_sea_ships_by_side(var_0_2.obj_side.enemy)
		end

		for iter_6_0, iter_6_1 in pairs((arg_6_1 and arg_6_2 or nil) and self._battle_obj_mgr:get_all_sea_ships()) do
			if var_0_2:is_open_antisub_attack_type((iter_6_1:get_ship_type())) then
				var_0_1(var_6_0, iter_6_1)
			end
		end

		return var_6_0
	end

	function arg_1_0:skill_antisub_lac_can_attack(arg_7_1, arg_7_2)
		local var_7_0 = {}
		local var_7_1 = {}

		if arg_7_1 then
			var_7_1 = self._battle_obj_mgr:get_sea_ships_by_side(var_0_2.obj_side.player)
		end

		if arg_7_2 then
			var_7_1 = self._battle_obj_mgr:get_sea_ships_by_side(var_0_2.obj_side.enemy)
		end

		for iter_7_0, iter_7_1 in pairs((arg_7_1 and arg_7_2 or nil) and self._battle_obj_mgr:get_all_sea_ships()) do
			local var_7_2 = iter_7_1:get_ship_type()
			local var_7_3 = iter_7_1:have_bomber_or_torpedoplane()
			local var_7_4 = iter_7_1:hp_more_than_half()
			local var_7_5 = iter_7_1:get_is_alive()

			if var_0_2:is_open_antisub_attack_type(var_7_2) and var_7_2 == var_0_2.ship_type_rule.light_aircraft_carrier.value then
				local var_7_6 = iter_7_1:get_attribute().skill_num

				if (var_7_4 or var_7_6 and var_7_6.antisub_ignore_broken_hp or iter_7_1:get_can_attack_in_broken()) and var_7_3 then
					var_0_1(var_7_0, iter_7_1)
				end
			end
		end

		return var_7_0
	end

	function arg_1_0:__can_attack_lac(arg_8_1)
		local var_8_0 = false

		for iter_8_0, iter_8_1 in pairs((self._battle_obj_mgr:get_ships_by_side(arg_8_1))) do
			local var_8_1 = iter_8_1:get_ship_type()
			local var_8_2 = iter_8_1:have_bomber_or_torpedoplane()
			local var_8_3 = iter_8_1:hp_more_than_half()
			local var_8_4 = iter_8_1:get_is_alive()

			if var_0_2:is_open_antisub_attack_type(var_8_1) then
				if var_8_1 == var_0_2.ship_type_rule.light_aircraft_carrier.value then
					local var_8_5 = iter_8_1:get_attribute().skill_num

					if (var_8_3 or var_8_5 and var_8_5.antisub_ignore_broken_hp or iter_8_1:get_can_attack_in_broken()) and var_8_2 then
						var_8_0 = true
					end
				else
					var_8_0 = true
				end
			end
		end

		return var_8_0
	end

	function arg_1_0:__can_have_attack_skill(arg_9_1)
		local var_9_0 = false

		for iter_9_0, iter_9_1 in pairs((self._battle_obj_mgr:get_ships_by_side(arg_9_1))) do
			local var_9_1 = iter_9_1:get_ship_type()
			local var_9_2 = iter_9_1:have_bomber_or_torpedoplane()
			local var_9_3 = iter_9_1:hp_more_than_half()
			local var_9_4 = iter_9_1:get_is_alive()

			if iter_9_1:get_attribute().skill_num.not_single_cross_can_antisub_gd then
				var_9_0 = true
			end
		end

		return var_9_0
	end
end

function var_0_0.extend_obj(arg_10_0)
	return
end

return var_0_0
