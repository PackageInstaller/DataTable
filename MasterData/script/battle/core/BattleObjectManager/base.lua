local var_0_0 = {}
local var_0_1 = gameenum.battle_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:get_ships_by_side(arg_2_1)
		local var_2_0 = {}

		for iter_2_0, iter_2_1 in pairs(self._object_set) do
			if iter_2_1:get_side() == arg_2_1 then
				var_2_0[1] = iter_2_1
			end
		end

		return var_2_0
	end

	function arg_1_0:get_alive_ships_by_side(arg_3_1)
		local var_3_0 = {}

		for iter_3_0, iter_3_1 in pairs(self._object_set) do
			if iter_3_1:get_side() == arg_3_1 and iter_3_1:get_is_alive() then
				var_3_0[1] = iter_3_1
			end
		end

		return var_3_0
	end

	function arg_1_0:get_all_ships()
		local var_4_0 = {}

		for iter_4_0, iter_4_1 in pairs(self._object_set) do
			if iter_4_1:get_side() ~= 0 then
				var_4_0[iter_4_0] = iter_4_1
			end
		end

		return var_4_0
	end

	function arg_1_0:get_all_sea_ships()
		local var_5_0 = {}

		for iter_5_0, iter_5_1 in pairs(self._object_set) do
			if iter_5_1:get_side() ~= 0 and not iter_5_1:is_submarine() and iter_5_1:get_is_alive() then
				var_5_0[1] = iter_5_1
			end
		end

		return var_5_0
	end

	function arg_1_0:get_all_undersea_ships()
		local var_6_0 = {}

		for iter_6_0, iter_6_1 in pairs(self._object_set) do
			if iter_6_1:get_side() ~= 0 and iter_6_1:is_submarine() and iter_6_1:get_is_alive() then
				var_6_0[1] = iter_6_1
			end
		end

		return var_6_0
	end

	function arg_1_0:get_sea_ships_by_side(arg_7_1)
		local var_7_0 = {}

		for iter_7_0, iter_7_1 in pairs(self._object_set) do
			if iter_7_1:get_side() == arg_7_1 and not iter_7_1:is_submarine() and iter_7_1:get_is_alive() then
				var_7_0[1] = iter_7_1
			end
		end

		return var_7_0
	end

	function arg_1_0:get_undersea_ships_by_side(arg_8_1)
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in pairs(self._object_set) do
			if iter_8_1:get_side() == arg_8_1 and iter_8_1:is_submarine() and iter_8_1:get_is_alive() then
				var_8_0[1] = iter_8_1
			end
		end

		return var_8_0
	end

	function arg_1_0:get_flag_ship(arg_9_1)
		local var_9_0

		for iter_9_0, iter_9_1 in pairs(self._object_set) do
			if iter_9_1:get_side() == arg_9_1 then
				var_9_0 = iter_9_1

				break
			end
		end

		return var_9_0
	end

	function arg_1_0:get_tmd_ships(arg_10_1)
		local var_10_0 = {}

		for iter_10_0, iter_10_1 in pairs(self._object_set) do
			if iter_10_1:get_side() == arg_10_1 and (iter_10_1:get_ship_type() == var_0_1.ship_type_rule.aadg.value or iter_10_1:get_ship_type() == var_0_1.ship_type_rule.cbg.value or iter_10_1:get_ship_type() == var_0_1.ship_type_rule.bg.value or iter_10_1:get_ship_type() == var_0_1.ship_type_rule.cg.value or iter_10_1:get_ship_type() == var_0_1.ship_type_rule.bbg.value) and iter_10_1:get_is_alive() then
				var_10_0[1] = iter_10_1
			end
		end

		return var_10_0
	end

	function arg_1_0:get_not_facilities_ships(arg_11_1)
		local var_11_0 = {}

		for iter_11_0, iter_11_1 in pairs(self._object_set) do
			if iter_11_1:get_side() == arg_11_1 and not iter_11_1:is_facilities() and not iter_11_1:is_submarine() and iter_11_1:get_is_alive() then
				var_11_0[1] = iter_11_1
			end
		end

		return var_11_0
	end
end

function var_0_0.extend_obj(arg_12_0)
	return
end

return var_0_0
