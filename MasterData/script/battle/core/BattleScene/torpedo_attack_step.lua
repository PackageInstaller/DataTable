local var_0_0 = {}
local var_0_1 = table.insert
local var_0_2 = gameenum.battle_type
local var_0_3 = gamecore.battle_util

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:enter_torpedo_attack()
		local var_2_0 = false

		if var_0_3:dict_length((self._battle_obj_mgr:get_sea_ships_by_side(var_0_2.obj_side.player))) == 0 and var_0_3:dict_length((self._battle_obj_mgr:get_sea_ships_by_side(var_0_2.obj_side.enemy))) == 0 then
			return false
		end

		for iter_2_0, iter_2_1 in pairs((self._battle_obj_mgr:get_all_ships())) do
			local var_2_1 = iter_2_1:is_lowhp()
			local var_2_2 = iter_2_1:get_ship_type()

			if iter_2_1:get_is_alive() and (not var_2_1 or iter_2_1._battle_scene:get_attack_state_by_hp(nil, iter_2_1) or iter_2_1:get_can_attack_in_broken()) and var_0_2:is_torpedo_attack_type(var_2_2) and iter_2_1:get_attribute().torpedo:get_final_value() > 0 then
				var_2_0 = true
			end

			if var_2_2 == var_0_2.ship_type_rule.battle_ship.value or var_2_2 == var_0_2.ship_type_rule.battle_cruiser.value or var_2_2 == var_0_2.ship_type_rule.aviation_battle_ship.value or var_2_2 == var_0_2.ship_type_rule.cbg.value or var_2_2 == var_0_2.ship_type_rule.bg.value then
				if iter_2_1:get_attribute().torpedo:get_final_value() > 0 then
					var_2_0 = true
				end
			end
		end

		return var_2_0
	end

	function arg_1_0:get_torpedo_ships()
		local var_3_0 = {}

		for iter_3_0, iter_3_1 in pairs((self._battle_obj_mgr:get_all_ships())) do
			local var_3_1 = iter_3_1:get_ship_type()
			local var_3_2 = iter_3_1:get_attribute()
			local var_3_3 = iter_3_1:get_is_alive()
			local var_3_4 = iter_3_1:get_attribute().torpedo:get_final_value()

			if var_0_2:is_torpedo_attack_type(var_3_1) and (not iter_3_1:is_lowhp() or iter_3_1._battle_scene:get_attack_state_by_hp(nil, iter_3_1) or iter_3_1:get_can_attack_in_broken()) and var_3_3 and var_3_2.torpedo:get_final_value() > 0 then
				var_0_1(var_3_0, iter_3_1)
			end

			if (var_3_1 == var_0_2.ship_type_rule.battle_ship.value or var_3_1 == var_0_2.ship_type_rule.battle_cruiser.value or var_3_1 == var_0_2.ship_type_rule.aviation_battle_ship.value or var_3_1 == var_0_2.ship_type_rule.cbg.value or var_3_1 == var_0_2.ship_type_rule.bg.value) and var_3_2.torpedo:get_final_value() > 0 then
				var_0_1(var_3_0, iter_3_1)
			end
		end

		table.sort(var_3_0, function(arg_4_0, arg_4_1)
			if arg_4_0:get_side() ~= arg_4_1:get_side() then
				return arg_4_0:get_side() > arg_4_1:get_side()
			else
				return arg_4_0:get_index() < arg_4_1:get_index()
			end
		end)

		return var_3_0
	end
end

function var_0_0.extend_obj(arg_5_0)
	return
end

return var_0_0
