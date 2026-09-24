local var_0_0 = {}
local var_0_1 = gameenum.battle_type
local var_0_2 = table.insert
local var_0_4 = table.sort

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.sort_rule(arg_2_0, arg_2_1)
		var_0_4(arg_2_1, function(arg_3_0, arg_3_1)
			return arg_3_0:get_index() > arg_3_1:get_index()
		end)

		return arg_2_1
	end

	function arg_1_0:__getTarget_adjacent_pos(arg_4_1)
		local var_4_0 = {}
		local var_4_1
		local var_4_2
		local var_4_3 = self._owner:get_index()

		for iter_4_0, iter_4_1 in pairs((self._battle_obj_mgr:get_alive_ships_by_side((self._owner:get_side())))) do
			if iter_4_1:get_index() == var_4_3 + 1 then
				var_4_1 = iter_4_1
			end

			if iter_4_1:get_index() == var_4_3 - 1 then
				var_4_2 = iter_4_1
			end
		end

		if var_4_1 then
			var_0_2(var_4_0, var_4_1)
		end

		if var_4_2 then
			var_0_2(var_4_0, var_4_2)
		end

		return var_4_0
	end

	function arg_1_0:__getTarget_adjacent_ship(arg_5_1)
		local var_5_0 = {}

		for iter_5_0, iter_5_1 in pairs((self:__getTarget_adjacent_pos())) do
			local var_5_1 = true

			if arg_5_1.shipTypes then
				var_5_1 = false

				for iter_5_2, iter_5_3 in pairs(arg_5_1.shipTypes) do
					if iter_5_1:get_ship_type() == iter_5_3 then
						var_5_1 = true

						break
					end
				end
			end

			local var_5_2 = true

			if arg_5_1.country then
				var_5_2 = false

				for iter_5_4, iter_5_5 in pairs(arg_5_1.country) do
					if iter_5_1:get_country() == iter_5_5 then
						var_5_2 = true

						break
					end
				end
			end

			if var_5_1 and var_5_2 then
				var_0_2(var_5_0, iter_5_1)
			end
		end

		return var_5_0
	end

	function arg_1_0:__getTarget_before_by_ship_type_by_num(arg_6_1)
		local var_6_0 = {}
		local var_6_1 = {}
		local var_6_2 = self._owner:get_side()
		local var_6_3 = self._owner:get_index()
		local var_6_4 = self:__getTarget_all_this_side()
		local var_6_5 = {}
		local var_6_6 = 0

		for iter_6_0, iter_6_1 in ipairs({
			"shipTypes",
			"shipTons",
			"guardTypes",
			"shipCids"
		}) do
			if arg_6_1[iter_6_1] then
				var_6_6 = iter_6_0

				break
			end
		end

		for iter_6_2 = 1, arg_6_1.num do
			if var_6_4[var_6_3 - iter_6_2] then
				var_0_2(var_6_1, var_6_4[var_6_3 - iter_6_2])
			end
		end

		if var_6_6 == 0 then
			var_6_5 = self:__get_target_meet_noneed_data(var_6_1)
		elseif var_6_6 == 1 then
			var_6_5 = self:__get_target_meet_shipTypes_data(var_6_1, arg_6_1.shipTypes)
		elseif var_6_6 == 2 then
			var_6_5 = self:__get_target_meet_shipTons_data(var_6_1, arg_6_1.shipTons)
		elseif var_6_6 == 3 then
			var_6_5 = self:__get_target_meet_guardTypes_data(var_6_1, arg_6_1.guardTypes)
		elseif var_6_6 == 4 then
			var_6_5 = self:__get_target_meet_cardCids_data(var_6_1, arg_6_1.shipCids)
		end

		self:sort_rule(var_6_1)

		for iter_6_3, iter_6_4 in pairs(var_6_5) do
			for iter_6_5, iter_6_6 in pairs(arg_6_1) do
				if arg_6_1.country then
					for iter_6_7, iter_6_8 in pairs(arg_6_1.country) do
						if iter_6_4:get_country() == iter_6_8 then
							var_0_2(var_6_0, iter_6_4)
						end
					end
				else
					var_0_2(var_6_0, iter_6_4)
				end
			end
		end

		return var_6_0
	end

	function arg_1_0:__getTarget_before_some_pos(arg_7_1)
		local var_7_0 = {}
		local var_7_1 = {}
		local var_7_2 = self._owner:get_index()

		for iter_7_0, iter_7_1 in pairs((self._battle_obj_mgr:get_alive_ships_by_side((self._owner:get_side())))) do
			if var_7_2 > iter_7_1:get_index() then
				var_0_2(var_7_1, iter_7_1)
			end
		end

		self:sort_rule(var_7_1)

		for iter_7_2, iter_7_3 in pairs(var_7_1) do
			if 0 < arg_7_1.num then
				var_0_2(var_7_0, iter_7_3)
			end
		end

		return var_7_0
	end

	function arg_1_0:__getTarget_after_three_pos(arg_8_1)
		local var_8_0 = {}
		local var_8_1 = self._owner:get_index()

		for iter_8_0, iter_8_1 in pairs((self._battle_obj_mgr:get_alive_ships_by_side((self._owner:get_side())))) do
			if iter_8_1:get_index() == var_8_1 + 1 then
				var_0_2(var_8_0, iter_8_1)
			end

			if iter_8_1:get_index() == var_8_1 + 2 then
				var_0_2(var_8_0, iter_8_1)
			end

			if iter_8_1:get_index() == var_8_1 + 3 then
				var_0_2(var_8_0, iter_8_1)
			end
		end

		return var_8_0
	end

	function arg_1_0:__getTarget_after_all(arg_9_1)
		local var_9_0 = {}
		local var_9_1 = self._owner:get_index()

		for iter_9_0, iter_9_1 in pairs((self._battle_obj_mgr:get_alive_ships_by_side((self._owner:get_side())))) do
			if var_9_1 < iter_9_1:get_index() then
				var_0_2(var_9_0, iter_9_1)
			end
		end

		return var_9_0
	end

	function arg_1_0:__getTarget_before_all(arg_10_1)
		local var_10_0 = {}
		local var_10_1 = self._owner:get_index()

		for iter_10_0, iter_10_1 in pairs((self._battle_obj_mgr:get_alive_ships_by_side((self._owner:get_side())))) do
			if var_10_1 > iter_10_1:get_index() then
				var_0_2(var_10_0, iter_10_1)
			end
		end

		return var_10_0
	end

	function arg_1_0:__getTarget_self(arg_11_1)
		local var_11_0 = {}

		var_0_2(var_11_0, self._owner)

		return var_11_0
	end

	function arg_1_0:__getTarget_all_this_side(arg_12_1)
		return (self._battle_obj_mgr:get_alive_ships_by_side((self._owner:get_side())))
	end

	function arg_1_0:__getTarget_some_ship(arg_13_1)
		local var_13_0 = {}

		for iter_13_0, iter_13_1 in pairs((self:__getTarget_all_this_side())) do
			for iter_13_2, iter_13_3 in pairs(arg_13_1.shipCids) do
				if iter_13_1:get_cid() == iter_13_3 then
					var_0_2(var_13_0, iter_13_1)
				end
			end
		end

		return var_13_0
	end

	function arg_1_0:__getTarget_some_country(arg_14_1)
		local var_14_0 = {}

		for iter_14_0, iter_14_1 in pairs((self:__getTarget_all_this_side())) do
			for iter_14_2, iter_14_3 in pairs(arg_14_1.country) do
				if iter_14_1:get_country() == iter_14_3 then
					var_0_2(var_14_0, iter_14_1)
				end
			end
		end

		return var_14_0
	end

	function arg_1_0:__getTarget_some_type(arg_15_1)
		local var_15_0 = {}

		for iter_15_0, iter_15_1 in pairs((self:__getTarget_all_this_side())) do
			for iter_15_2, iter_15_3 in pairs(arg_15_1) do
				if iter_15_2 ~= "type" then
					for iter_15_4, iter_15_5 in pairs(iter_15_3) do
						if iter_15_2 == "shipTypes" then
							if iter_15_1:get_ship_type() == iter_15_5 then
								var_0_2(var_15_0, iter_15_1)
							end
						elseif iter_15_2 == "shipTons" then
							if iter_15_1:get_ship_ton() == iter_15_5 then
								var_0_2(var_15_0, iter_15_1)
							end
						elseif iter_15_2 == "guardTypes" and iter_15_1:get_ship_guard_type() == iter_15_5 then
							var_0_2(var_15_0, iter_15_1)
						end
					end
				end
			end
		end

		return var_15_0
	end

	function arg_1_0:__getTarget_some_type_by_country(arg_16_1)
		local var_16_0 = {}
		local var_16_1 = {}

		for iter_16_0, iter_16_1 in pairs((self:__getTarget_all_this_side())) do
			for iter_16_2, iter_16_3 in pairs(arg_16_1) do
				if iter_16_2 ~= "type" and iter_16_2 ~= "country" then
					for iter_16_4, iter_16_5 in pairs(iter_16_3) do
						if iter_16_2 == "shipTypes" then
							if iter_16_1:get_ship_type() == iter_16_5 then
								var_0_2(var_16_0, iter_16_1)
							end
						elseif iter_16_2 == "shipTons" then
							if iter_16_1:get_ship_ton() == iter_16_5 then
								var_0_2(var_16_0, iter_16_1)
							end
						elseif iter_16_2 == "guardTypes" and iter_16_1:get_ship_guard_type() == iter_16_5 then
							var_0_2(var_16_0, iter_16_1)
						end
					end
				end
			end
		end

		for iter_16_6, iter_16_7 in pairs(var_16_0) do
			for iter_16_8, iter_16_9 in pairs(arg_16_1.country) do
				if iter_16_7:get_country() == iter_16_9 then
					var_0_2(var_16_1, iter_16_7)
				end
			end
		end

		return var_16_1
	end

	function arg_1_0:__getTarget_after_by_ship_type_by_num(arg_17_1)
		local var_17_0 = {}
		local var_17_1 = {}
		local var_17_2 = self._owner:get_side()
		local var_17_3 = self:__getTarget_all_this_side()
		local var_17_4 = self._owner:get_index()
		local var_17_5 = {}
		local var_17_6 = 0

		for iter_17_0, iter_17_1 in ipairs({
			"shipTypes",
			"shipTons",
			"guardTypes",
			"shipCids"
		}) do
			if arg_17_1[iter_17_1] then
				var_17_6 = iter_17_0

				break
			end
		end

		for iter_17_2 = var_17_4 + 1, (var_17_4 + arg_17_1.num > 6 or nil) and 6 do
			var_0_2(var_17_1, var_17_3[iter_17_2])
		end

		if var_17_6 == 0 then
			var_17_5 = self:__get_target_meet_noneed_data(var_17_1)
		elseif var_17_6 == 1 then
			var_17_5 = self:__get_target_meet_shipTypes_data(var_17_1, arg_17_1.shipTypes)
		elseif var_17_6 == 2 then
			var_17_5 = self:__get_target_meet_shipTons_data(var_17_1, arg_17_1.shipTons)
		elseif var_17_6 == 3 then
			var_17_5 = self:__get_target_meet_guardTypes_data(var_17_1, arg_17_1.guardTypes)
		elseif var_17_6 == 4 then
			var_17_5 = self:__get_target_meet_cardCids_data(var_17_1, arg_17_1.shipCids)
		end

		for iter_17_3, iter_17_4 in pairs(var_17_5) do
			if arg_17_1.country then
				for iter_17_5, iter_17_6 in pairs(arg_17_1.country) do
					if iter_17_4:get_country() == iter_17_6 then
						var_0_2(var_17_0, iter_17_4)
					end
				end
			else
				var_0_2(var_17_0, iter_17_4)
			end
		end

		return var_17_0
	end

	function arg_1_0:__getTarget_after_some_pos(arg_18_1)
		local var_18_0 = {}
		local var_18_1 = {}
		local var_18_2 = self._owner:get_index()

		for iter_18_0, iter_18_1 in pairs((self._battle_obj_mgr:get_alive_ships_by_side((self._owner:get_side())))) do
			if var_18_2 < iter_18_1:get_index() then
				var_0_2(var_18_1, iter_18_1)
			end
		end

		for iter_18_2, iter_18_3 in pairs(var_18_1) do
			if 0 < arg_18_1.num then
				var_0_2(var_18_0, iter_18_3)
			end
		end

		return var_18_0
	end

	function arg_1_0:__getTarget_some_speed_ship(arg_19_1)
		local var_19_0 = {}
		local var_19_1 = {}
		local var_19_2 = 0

		for iter_19_0, iter_19_1 in ipairs({
			"shipTypes",
			"shipTons",
			"guardTypes",
			"shipCids"
		}) do
			if arg_19_1[iter_19_1] then
				var_19_2 = iter_19_0

				break
			end
		end

		local var_19_3 = self:__getTarget_all_this_side()

		if var_19_2 == 0 then
			var_19_1 = self:__get_target_meet_noneed_data(var_19_3)
		elseif var_19_2 == 1 then
			var_19_1 = self:__get_target_meet_shipTypes_data(var_19_3, arg_19_1.shipTypes)
		elseif var_19_2 == 2 then
			var_19_1 = self:__get_target_meet_shipTons_data(var_19_3, arg_19_1.shipTons)
		elseif var_19_2 == 3 then
			var_19_1 = self:__get_target_meet_guardTypes_data(var_19_3, arg_19_1.guardTypes)
		elseif var_19_2 == 4 then
			var_19_1 = self:__get_target_meet_cardCids_data(var_19_3, arg_19_1.shipCids)
		end

		for iter_19_2, iter_19_3 in pairs(var_19_1) do
			local var_19_4 = iter_19_3:get_ship_type()

			if iter_19_3:get_attribute().speed:get_final_value() < 27 then
				var_0_2(var_19_0, iter_19_3)
			end
		end

		return var_19_0
	end

	function arg_1_0:__getTarget_some_shiptype_except_self(arg_20_1)
		local var_20_0 = {}
		local var_20_1 = {}
		local var_20_2 = self:__getTarget_all_this_side()

		if arg_20_1.country then
			for iter_20_0, iter_20_1 in pairs(arg_20_1.country) do
				for iter_20_2, iter_20_3 in pairs(var_20_2) do
					if iter_20_3:get_country() == iter_20_1 then
						var_0_2(var_20_1, iter_20_3)
					end
				end
			end

			var_20_2 = var_20_1
		end

		for iter_20_4, iter_20_5 in pairs(var_20_2) do
			for iter_20_6, iter_20_7 in pairs(arg_20_1.shipTypes) do
				if iter_20_5:get_ship_type() == iter_20_7 and self._owner:getID() ~= iter_20_5:getID() then
					var_0_2(var_20_0, iter_20_5)
				end
			end
		end

		return var_20_0
	end

	function arg_1_0:__getTarget_flag_ship(arg_21_1)
		local var_21_0 = {}

		var_0_2(var_21_0, (self._battle_obj_mgr:get_flag_ship((self._owner:get_side()))))

		return var_21_0
	end

	function arg_1_0:__getTarget_adjacent_upsea_ships(arg_22_1)
		local var_22_0 = {}

		for iter_22_0, iter_22_1 in pairs((self:__getTarget_adjacent_pos())) do
			if iter_22_1:is_submarine() == false then
				var_0_2(var_22_0, iter_22_1)
			end
		end

		return var_22_0
	end

	function arg_1_0:__getTarget_all_this_side_without_self(arg_23_1)
		local var_23_0 = {}

		for iter_23_0, iter_23_1 in pairs((self:__getTarget_all_this_side())) do
			if iter_23_1:get_index() ~= self._owner:get_index() then
				var_0_2(var_23_0, iter_23_1)
			end
		end

		return var_23_0
	end

	function arg_1_0:__getTarget_all_this_side__by_ship_type_by_num(arg_24_1, arg_24_2)
		local var_24_0 = {}
		local var_24_1 = {}
		local var_24_2 = self:__getTarget_all_this_side()

		if arg_24_2 then
			var_24_2 = self:__getTarget_all_this_side_without_self()
		end

		local var_24_5 = {}

		if self._battle_random:get_target(self._owner:getID()) and not arg_24_2 and arg_24_1.nofixed ~= 1 then
			var_24_1 = self._battle_random:get_target(self._owner:getID())
		else
			for iter_24_0, iter_24_1 in pairs(var_24_2) do
				for iter_24_2, iter_24_3 in pairs(arg_24_1) do
					if iter_24_2 ~= "type" and iter_24_2 ~= "num" and iter_24_2 ~= "nofixed" then
						for iter_24_4, iter_24_5 in pairs(iter_24_3) do
							if iter_24_2 == "shipTypes" then
								if iter_24_1:get_ship_type() == iter_24_5 then
									var_0_2(var_24_0, iter_24_1)
								end
							elseif iter_24_2 == "shipTons" then
								if iter_24_1:get_ship_ton() == iter_24_5 then
									var_0_2(var_24_0, iter_24_1)
								end
							elseif iter_24_2 == "guardTypes" and iter_24_1:get_ship_guard_type() == iter_24_5 then
								var_0_2(var_24_0, iter_24_1)
							end

							if iter_24_2 == "country" and iter_24_1:get_country() == iter_24_5 then
								var_0_2(var_24_0, iter_24_1)
							end
						end
					end
				end
			end

			if #var_24_0 <= arg_24_1.num then
				return var_24_0
			end

			while #var_24_5 ~= arg_24_1.num do
				local var_24_6 = self._battle_random:randRange(1, #var_24_0)
				local var_24_7 = false

				for iter_24_6, iter_24_7 in pairs(var_24_5) do
					if var_24_6 == iter_24_7 then
						var_24_7 = true
					end
				end

				if var_24_7 == false then
					var_0_2(var_24_5, var_24_6)
				end
			end

			for iter_24_8, iter_24_9 in pairs(var_24_5) do
				var_0_2(var_24_1, var_24_0[iter_24_9])
			end

			if not arg_24_2 and arg_24_1.nofixed ~= 1 then
				self._battle_random:set_target(var_24_1, self._owner:getID())
			end
		end

		return var_24_1
	end

	function arg_1_0:__getTarget_speed_greater_than_27(arg_25_1)
		local var_25_0 = {}

		for iter_25_0, iter_25_1 in pairs((self:__getTarget_all_this_side())) do
			if iter_25_1:get_attribute().speed:get_final_value() >= 27 then
				var_0_2(var_25_0, iter_25_1)
			end
		end

		return var_25_0
	end

	function arg_1_0:__getTarget_all_type_but_target_type(arg_26_1)
		local var_26_0 = {}

		if arg_26_1.shipTypes then
			for iter_26_0, iter_26_1 in pairs((self:__getTarget_all_this_side())) do
				local var_26_1 = true

				for iter_26_2, iter_26_3 in pairs(arg_26_1.shipTypes) do
					if iter_26_1:get_ship_type() == iter_26_3 then
						var_26_1 = false
					end
				end

				if var_26_1 then
					var_0_2(var_26_0, iter_26_1)
				end
			end
		end

		return var_26_0
	end

	function arg_1_0:__getTarget_low_speed_ship_but_self(arg_27_1)
		local var_27_0 = {}

		for iter_27_0, iter_27_1 in pairs((self:__getTarget_some_type(arg_27_1))) do
			if iter_27_1:get_attribute().speed:get_final_value() < 27 and self._owner:getID() ~= iter_27_1:getID() then
				var_0_2(var_27_0, iter_27_1)
			end
		end

		return var_27_0
	end

	function arg_1_0:__getTarget_high_speed_ship_but_self(arg_28_1)
		local var_28_0 = {}

		for iter_28_0, iter_28_1 in pairs((self:__getTarget_some_type(arg_28_1))) do
			if iter_28_1:get_attribute().speed:get_final_value() >= 27 and self._owner:getID() ~= iter_28_1:getID() then
				var_0_2(var_28_0, iter_28_1)
			end
		end

		return var_28_0
	end

	function arg_1_0:__getTarget_some_pos_ships(arg_29_1)
		local var_29_0 = {}

		if not arg_29_1.position then
			return var_29_0
		end

		local var_29_1 = self:__getTarget_all_this_side()

		for iter_29_0, iter_29_1 in pairs(arg_29_1.position) do
			for iter_29_2, iter_29_3 in pairs(var_29_1) do
				if iter_29_3:get_index() == iter_29_1 then
					var_0_2(var_29_0, iter_29_3)

					break
				end
			end
		end

		return var_29_0
	end

	function arg_1_0:__getTarget_all_opposite_side(arg_30_1)
		return (self._battle_obj_mgr:get_alive_ships_by_side((var_0_1.obj_side.opposite(self._owner:get_side()))))
	end

	function arg_1_0:__getTarget_opposite_some_ships(arg_31_1)
		local var_31_0 = {}

		for iter_31_0, iter_31_1 in pairs((self:__getTarget_all_opposite_side())) do
			for iter_31_2, iter_31_3 in pairs(arg_31_1) do
				if iter_31_2 ~= "type" and iter_31_2 ~= "num" then
					for iter_31_4, iter_31_5 in pairs(iter_31_3) do
						if iter_31_2 == "shipTypes" then
							if iter_31_1:get_ship_type() == iter_31_5 then
								var_0_2(var_31_0, iter_31_1)
							end
						elseif iter_31_2 == "shipTons" then
							if iter_31_1:get_ship_ton() == iter_31_5 then
								var_0_2(var_31_0, iter_31_1)
							end
						elseif iter_31_2 == "guardTypes" and iter_31_1:get_ship_guard_type() == iter_31_5 then
							var_0_2(var_31_0, iter_31_1)
						end
					end
				end
			end
		end

		return var_31_0
	end

	function arg_1_0:__getTarget_opposite_same_pos_upsea(arg_32_1)
		local var_32_0 = {}

		for iter_32_0, iter_32_1 in pairs((self:__getTarget_all_opposite_side())) do
			if not iter_32_1:is_submarine() and iter_32_1:get_index() == self._owner:get_index() then
				var_0_2(var_32_0, iter_32_1)
			end
		end

		return var_32_0
	end

	function arg_1_0:__getTarget_opposite_speed_ship(arg_33_1)
		local var_33_0 = {}

		for iter_33_0, iter_33_1 in pairs((self:__getTarget_all_opposite_side())) do
			if iter_33_1:get_attribute().speed:get_final_value() >= 27 then
				var_0_2(var_33_0, iter_33_1)
			end
		end

		return var_33_0
	end

	function arg_1_0:__getTarget_random_opposite_some_ships(arg_34_1)
		local var_34_0 = {}
		local var_34_2 = self:__getTarget_opposite_some_ships(arg_34_1)

		if #var_34_2 == 0 then
			return
		end

		if self._battle_random:get_target(self._owner:getID()) then
			var_34_0 = self._battle_random:get_target(self._owner:getID())
		else
			for iter_34_0 = 1, arg_34_1.num do
				if #var_34_2 > 0 then
					local var_34_3 = self._battle_random:randRange(1, #var_34_2)

					var_0_2(var_34_0, var_34_2[var_34_3])
					table.remove(var_34_2, var_34_3)
				end
			end

			self._battle_random:set_target(var_34_0, self._owner:getID())
		end

		return var_34_0
	end

	function arg_1_0:__getTarget_opposite_some_ships_except_flag(arg_35_1)
		local var_35_0 = {}

		for iter_35_0, iter_35_1 in pairs((self:__getTarget_all_opposite_side())) do
			if not iter_35_1:is_flag() then
				for iter_35_2, iter_35_3 in pairs(arg_35_1) do
					if iter_35_2 ~= "type" then
						for iter_35_4, iter_35_5 in pairs(iter_35_3) do
							if iter_35_2 == "shipTypes" then
								if iter_35_1:get_ship_type() == iter_35_5 and iter_35_1:is_flag() == false then
									var_0_2(var_35_0, iter_35_1)
								end
							elseif iter_35_2 == "shipTons" then
								if iter_35_1:get_ship_ton() == iter_35_5 and iter_35_1:is_flag() == false then
									var_0_2(var_35_0, iter_35_1)
								end
							elseif iter_35_2 == "guardTypes" and iter_35_1:get_ship_guard_type() == iter_35_5 and iter_35_1:is_flag() == false then
								var_0_2(var_35_0, iter_35_1)
							end
						end
					end
				end
			end
		end

		return var_35_0
	end

	function arg_1_0:__getTarget_opposite_ship_by_flag(arg_36_1)
		local var_36_0 = {}

		for iter_36_0, iter_36_1 in pairs((self:__getTarget_all_opposite_side())) do
			if iter_36_1:is_flag() then
				var_0_2(var_36_0, iter_36_1)
			end
		end

		return var_36_0
	end

	function arg_1_0:__getTarget_random_opposite_some_ships_repeat(arg_37_1)
		local var_37_0 = {}
		local var_37_2 = self:__getTarget_opposite_some_ships(arg_37_1)

		if #var_37_2 == 0 then
			return
		end

		for iter_37_0 = 1, arg_37_1.num do
			if #var_37_2 > 0 and #var_37_2 > 0 then
				local var_37_4 = self._battle_random:randRange(1, #var_37_2)

				var_0_2(var_37_0, var_37_2[var_37_4])
				table.remove(var_37_2, var_37_4)
			end
		end

		return var_37_0
	end

	function arg_1_0:__getTarget_not_higher_27_speed_ship(arg_38_1)
		local var_38_0 = {}

		for iter_38_0, iter_38_1 in pairs((self:__getTarget_all_opposite_side())) do
			if iter_38_1:get_attribute().speed:get_final_value() <= 27 then
				var_0_2(var_38_0, iter_38_1)
			end
		end

		return var_38_0
	end

	function arg_1_0.__get_target_meet_noneed_data(arg_39_0, arg_39_1, arg_39_2)
		local var_39_0 = {}

		if arg_39_2 then
			for iter_39_0, iter_39_1 in pairs(arg_39_1) do
				if iter_39_1:get_country() == arg_39_2 then
					var_0_2(var_39_0, iter_39_1)
				end
			end
		else
			for iter_39_2, iter_39_3 in pairs(arg_39_1) do
				var_0_2(var_39_0, iter_39_3)
			end
		end

		return var_39_0
	end

	function arg_1_0.__get_target_meet_shipTypes_data(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
		local var_40_0 = {}

		if arg_40_3 then
			for iter_40_0, iter_40_1 in pairs(arg_40_1) do
				for iter_40_2, iter_40_3 in pairs(arg_40_2) do
					if iter_40_1:get_ship_type() == iter_40_3 and iter_40_1:get_country() == arg_40_3 then
						var_0_2(var_40_0, iter_40_1)

						break
					end
				end
			end
		else
			for iter_40_4, iter_40_5 in pairs(arg_40_1) do
				for iter_40_6, iter_40_7 in pairs(arg_40_2) do
					if iter_40_5:get_ship_type() == iter_40_7 then
						var_0_2(var_40_0, iter_40_5)

						break
					end
				end
			end
		end

		return var_40_0
	end

	function arg_1_0.__get_target_meet_shipTons_data(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
		local var_41_0 = {}

		if arg_41_3 then
			for iter_41_0, iter_41_1 in pairs(arg_41_1) do
				for iter_41_2, iter_41_3 in pairs(arg_41_2) do
					if iter_41_1:get_ship_ton() == iter_41_3 and iter_41_1:get_country() == arg_41_3 then
						var_0_2(var_41_0, iter_41_1)

						break
					end
				end
			end
		else
			for iter_41_4, iter_41_5 in pairs(arg_41_1) do
				for iter_41_6, iter_41_7 in pairs(arg_41_2) do
					if iter_41_5:get_ship_ton() == iter_41_7 then
						var_0_2(var_41_0, iter_41_5)

						break
					end
				end
			end
		end

		return var_41_0
	end

	function arg_1_0.__get_target_meet_guardTypes_data(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
		local var_42_0 = {}

		if arg_42_3 then
			for iter_42_0, iter_42_1 in pairs(arg_42_1) do
				for iter_42_2, iter_42_3 in pairs(arg_42_2) do
					if iter_42_1:get_ship_guard_type() == iter_42_3 and iter_42_1:get_country() == arg_42_3 then
						var_0_2(var_42_0, iter_42_1)

						break
					end
				end
			end
		else
			for iter_42_4, iter_42_5 in pairs(arg_42_1) do
				for iter_42_6, iter_42_7 in pairs(arg_42_2) do
					if iter_42_5:get_ship_guard_type() == iter_42_7 then
						var_0_2(var_42_0, iter_42_5)

						break
					end
				end
			end
		end

		return var_42_0
	end

	function arg_1_0.__get_target_meet_cardCids_data(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
		local var_43_0 = {}

		if arg_43_3 then
			for iter_43_0, iter_43_1 in pairs(arg_43_1) do
				for iter_43_2, iter_43_3 in pairs(arg_43_2) do
					if iter_43_1:get_cid() == iter_43_3 and iter_43_1:get_country() == arg_43_3 then
						var_0_2(var_43_0, iter_43_1)

						break
					end
				end
			end
		else
			for iter_43_4, iter_43_5 in pairs(arg_43_1) do
				for iter_43_6, iter_43_7 in pairs(arg_43_2) do
					if iter_43_5:get_cid() == iter_43_7 then
						var_0_2(var_43_0, iter_43_5)

						break
					end
				end
			end
		end

		return var_43_0
	end
end

function var_0_0.extend_obj(arg_44_0)
	return
end

return var_0_0
