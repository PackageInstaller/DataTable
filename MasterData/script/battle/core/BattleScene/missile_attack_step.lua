local var_0_0 = {}
local var_0_1 = gameenum.battle_type
local var_0_2 = table.insert

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:enter_missile_attack()
		local var_2_0 = false
		local var_2_1 = {}
		local var_2_2 = self._battle_obj_mgr:get_all_sea_ships()

		for iter_2_0, iter_2_1 in pairs((self._battle_obj_mgr:get_sea_ships_by_side(var_0_1.obj_side.player))) do
			if var_0_1:is_open_missile_attack_type((iter_2_1:get_ship_type())) and (not iter_2_1:is_lowhp() or iter_2_1:get_can_attack_in_broken()) and iter_2_1:can_launch_missile() then
				var_2_0 = true

				var_0_2(var_2_1, iter_2_1)
			end
		end

		for iter_2_2, iter_2_3 in pairs((self._battle_obj_mgr:get_sea_ships_by_side(var_0_1.obj_side.enemy))) do
			if var_0_1:is_open_missile_attack_type((iter_2_3:get_ship_type())) and (not iter_2_3:is_lowhp() or iter_2_3:get_can_attack_in_broken()) and iter_2_3:can_launch_missile() then
				var_2_0 = true

				var_0_2(var_2_1, iter_2_3)
			end
		end

		table.sort(var_2_1, function(arg_3_0, arg_3_1)
			if arg_3_0:get_side() ~= arg_3_1:get_side() then
				return arg_3_0:get_side() > arg_3_1:get_side()
			else
				return arg_3_0:get_index() < arg_3_1:get_index()
			end
		end)

		return var_2_0, var_2_1
	end

	function arg_1_0:enter_close_missile_attack()
		local var_4_0 = false
		local var_4_1 = {}

		for iter_4_0, iter_4_1 in ipairs({
			self._battle_obj_mgr:get_sea_ships_by_side(var_0_1.obj_side.player),
			self._battle_obj_mgr:get_sea_ships_by_side(var_0_1.obj_side.enemy)
		}) do
			for iter_4_2, iter_4_3 in pairs(iter_4_1) do
				if var_0_1:is_close_missile_attack_type((iter_4_3:get_ship_type())) and (not iter_4_3:is_lowhp() or iter_4_3:get_can_attack_in_broken()) and iter_4_3:can_launch_missile("tmd") then
					var_4_0 = true

					var_0_2(var_4_1, iter_4_3)
				end
			end
		end

		table.sort(var_4_1, function(arg_5_0, arg_5_1)
			if arg_5_0:get_side() ~= arg_5_1:get_side() then
				return arg_5_0:get_side() > arg_5_1:get_side()
			else
				return arg_5_0:get_index() < arg_5_1:get_index()
			end
		end)

		return var_4_0, var_4_1
	end
end

function var_0_0.extend_obj(arg_6_0)
	return
end

return var_0_0
