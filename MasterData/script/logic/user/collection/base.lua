local var_0_0 = {}
local var_0_1 = table.insert
local var_0_2 = table.remove
local var_0_3 = table.sort
local var_0_4 = gamecore.user

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.reset_collection_data(arg_2_0)
		arg_2_0._desk_collection_data = {}
		arg_2_0._wall_collection_data = {}
		arg_2_0._medal_data = {}
		arg_2_0._show_medal_data = {}
		arg_2_0._show_room_style_data = {}
		arg_2_0._unlock_edal_data = {}
	end

	function arg_1_0:get_player_desk_collection_data()
		return self._desk_collection_data
	end

	function arg_1_0:get_player_wall_collection_data()
		return self._wall_collection_data
	end

	function arg_1_0:get_player_medal_data()
		return self._medal_data
	end

	function arg_1_0:get_player_unlock_medal_data()
		return self._unlock_edal_data
	end

	function arg_1_0:get_all_medal_by_id(arg_7_1)
		local var_7_0 = {}

		for iter_7_0, iter_7_1 in pairs(self._medal_data) do
			if iter_7_1.id == arg_7_1 then
				var_0_1(var_7_0, iter_7_1)
			end
		end

		var_0_3(var_7_0, function(arg_8_0, arg_8_1)
			return arg_8_0.level < arg_8_1.level
		end)

		return var_7_0
	end

	function arg_1_0:get_player_show_medal_data(arg_9_1)
		return self._show_medal_data
	end

	function arg_1_0:get_player_show_room_style_data()
		return self._show_room_style_data
	end

	function arg_1_0:add_player_desk_collection_data(arg_11_1)
		local var_11_0 = 0

		for iter_11_0, iter_11_1 in pairs(self._desk_collection_data) do
			if iter_11_1.index == arg_11_1.index then
				var_11_0 = iter_11_0
			end
		end

		if var_11_0 == 0 then
			var_0_1(self._desk_collection_data, #self._desk_collection_data + 1, arg_11_1)
		else
			self._desk_collection_data[var_11_0] = arg_11_1
		end
	end

	function arg_1_0:add_player_wall_collection_data(arg_12_1)
		local var_12_0 = 0

		for iter_12_0, iter_12_1 in pairs(self._wall_collection_data) do
			if iter_12_1.index == arg_12_1.index then
				var_12_0 = iter_12_0
			end
		end

		if var_12_0 == 0 then
			var_0_1(self._wall_collection_data, #self._wall_collection_data + 1, arg_12_1)
		else
			self._wall_collection_data[var_12_0] = arg_12_1
		end
	end

	function arg_1_0:add_player_unlock_medal_data(arg_13_1)
		local var_13_0 = 0

		for iter_13_0, iter_13_1 in pairs(self._unlock_edal_data) do
			if iter_13_1.id == arg_13_1.id and iter_13_1.level == arg_13_1.level then
				var_13_0 = iter_13_0
			end
		end

		if var_13_0 == 0 then
			var_0_1(self._unlock_edal_data, #self._unlock_edal_data + 1, arg_13_1)
		else
			self._unlock_edal_data[var_13_0] = arg_13_1
		end
	end

	function arg_1_0:add_player_medal_data(arg_14_1)
		var_0_1(self._medal_data, #self._medal_data + 1, arg_14_1)
	end

	function arg_1_0:add_player_show_medal_data(arg_15_1)
		var_0_1(self._show_medal_data, #self._show_medal_data + 1, arg_15_1)
	end

	function arg_1_0:add_player_show_room_style_data(arg_16_1)
		var_0_1(self._show_room_style_data, #self._show_room_style_data + 1, arg_16_1)
	end

	function arg_1_0:update_player_desk_collection_data(arg_17_1)
		local var_17_0 = 0

		for iter_17_0, iter_17_1 in pairs(self._desk_collection_data) do
			if iter_17_1.index == arg_17_1.index then
				var_17_0 = iter_17_0
			end
		end

		if var_17_0 == 0 then
			var_0_1(self._desk_collection_data, #self._desk_collection_data + 1, arg_17_1)
		else
			self._desk_collection_data[var_17_0] = arg_17_1
		end
	end

	function arg_1_0:update_player_wall_collection_data(arg_18_1)
		local var_18_0 = 0

		for iter_18_0, iter_18_1 in pairs(self._wall_collection_data) do
			if iter_18_1.index == arg_18_1.index then
				var_18_0 = iter_18_0
			end
		end

		if var_18_0 == 0 then
			var_0_1(self._wall_collection_data, #self._wall_collection_data + 1, arg_18_1)
		else
			self._wall_collection_data[var_18_0] = arg_18_1
		end
	end

	function arg_1_0:update_player_medal_data(arg_19_1)
		local var_19_0 = 0

		for iter_19_0, iter_19_1 in pairs(self._medal_data) do
			if iter_19_1.id == arg_19_1.id then
				var_19_0 = iter_19_0
			end
		end

		if var_19_0 == 0 then
			var_0_1(self._medal_data, #self._medal_data + 1, arg_19_1)
		else
			self._medal_data[var_19_0] = arg_19_1
		end
	end

	function arg_1_0:update_player_unlock_medal_data(arg_20_1)
		local var_20_0 = 0

		for iter_20_0, iter_20_1 in pairs(self._unlock_edal_data) do
			if iter_20_1.id == arg_20_1.id and iter_20_1.level == arg_20_1.level then
				var_20_0 = iter_20_0
			end
		end

		if var_20_0 == 0 then
			var_0_1(self._unlock_edal_data, #self._unlock_edal_data + 1, arg_20_1)
		else
			self._unlock_edal_data[var_20_0] = arg_20_1
		end
	end

	function arg_1_0.update_player_show_medal_data(arg_21_0, arg_21_1)
		arg_21_0._show_medal_data = arg_21_1
	end

	function arg_1_0:update_player_show_room_style_data(arg_22_1)
		local var_22_0 = 0

		for iter_22_0, iter_22_1 in pairs(self._show_room_style_data) do
			if iter_22_1.id == arg_22_1.id then
				var_22_0 = iter_22_0
			end
		end

		if var_22_0 == 0 then
			var_0_1(self._show_room_style_data, #self._show_room_style_data + 1, arg_22_1)
		else
			self._show_room_style_data[var_22_0] = arg_22_1
		end
	end

	function arg_1_0:remove_player_desk_collection_data(arg_23_1)
		local var_23_0 = 0

		for iter_23_0, iter_23_1 in pairs(self._desk_collection_data) do
			if iter_23_1.id == arg_23_1.id then
				var_23_0 = iter_23_0
			end
		end

		if var_23_0 > 0 then
			var_0_2(self._desk_collection_data, var_23_0)
		end
	end

	function arg_1_0:remove_player_wall_collection_data(arg_24_1)
		local var_24_0 = 0

		for iter_24_0, iter_24_1 in pairs(self._wall_collection_data) do
			if iter_24_1.id == arg_24_1.id then
				var_24_0 = iter_24_0
			end
		end

		if var_24_0 > 0 then
			var_0_2(self._wall_collection_data, var_24_0)
		end
	end

	function arg_1_0:remove_player_medal_data(arg_25_1)
		local var_25_0 = 0

		for iter_25_0, iter_25_1 in pairs(self._medal_data) do
			if iter_25_1.id == arg_25_1.id then
				var_25_0 = iter_25_0
			end
		end

		if var_25_0 > 0 then
			var_0_2(self._medal_data, var_25_0)
		end
	end

	function arg_1_0:remove_player_unlock_medal_data(arg_26_1)
		local var_26_0 = 0

		for iter_26_0, iter_26_1 in pairs(self._unlock_edal_data) do
			if iter_26_1.id == arg_26_1.id then
				var_26_0 = iter_26_0
			end
		end

		if var_26_0 > 0 then
			var_0_2(self._unlock_edal_data, var_26_0)
		end
	end

	function arg_1_0:remove_player_show_medal_data(arg_27_1)
		local var_27_0 = 0

		for iter_27_0, iter_27_1 in pairs(self._show_medal_data) do
			if iter_27_1 == arg_27_1 then
				var_27_0 = iter_27_0
			end
		end

		if var_27_0 > 0 then
			var_0_2(self._show_medal_data, var_27_0)
		end
	end

	function arg_1_0.set_collection_state(arg_28_0, arg_28_1)
		arg_28_0._user_state = arg_28_1
	end

	function arg_1_0:get_collection_state()
		return self._user_state
	end

	function arg_1_0:get_new_collection_flag()
		local var_30_0 = gameconfig.medal_config:get_sequence()

		for iter_30_0 = 1, #var_30_0 do
			local var_30_1 = self:get_all_medal_by_id(var_30_0[iter_30_0].id)
			local var_30_2 = 0

			if var_30_1[1] then
				var_30_2 = var_30_1[#var_30_1].level
			end

			local var_30_3 = {
				time = 0,
				id = var_30_0[iter_30_0].id,
				level = var_30_2
			}

			if var_30_3.level == 0 then
				var_30_2 = 1
			end

			local var_30_4 = gameconfig.medal_config.find_object_by_id(var_30_3.id)

			var_0_3(var_30_4.condition, function(arg_31_0, arg_31_1)
				return arg_31_0.id < arg_31_1.id
			end)

			local var_30_5 = self:get_medal_counter(var_30_4.unlock[var_30_2].type, var_30_4.unlock[var_30_2].value1, var_30_4.unlock[var_30_2].value2, var_30_3.level, var_30_4.unlock[var_30_2].value4, var_30_4.unlock[var_30_2].value3)

			if var_30_4.unlock[var_30_2].type == 3 then
				var_30_5 = 0

				for iter_30_1 = 1, #var_30_4.unlock do
					var_30_5 = self:get_medal_counter(3, var_30_4.unlock[iter_30_1].value1, var_30_4.unlock[iter_30_1].value2, iter_30_1, nil, var_30_4.unlock[iter_30_1].value3)
				end
			end

			if var_30_3.level == 0 and var_30_5 >= var_30_4.condition[var_30_2].value then
				return true
			end

			if var_30_3.level ~= 0 and var_30_3.level < var_30_4.rls_level and var_30_5 >= var_30_4.condition[var_30_2 + 1].value then
				return true
			end

			for iter_30_2, iter_30_3 in pairs((self:get_player_unlock_medal_data())) do
				if iter_30_3.level == var_30_3.level and iter_30_3.id == var_30_3.id then
					return true
				end
			end
		end

		return false
	end

	function arg_1_0.get_medal_counter(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4, arg_32_5, arg_32_6)
		local var_32_0 = 0

		if arg_32_1 == 1 then
			if arg_32_2 == 1 then
				var_32_0 = #var_0_4:get_cardbook_ship_list()
			elseif arg_32_2 == 2 then
				var_32_0 = var_0_4:get_player_statistics_data().map_total
			elseif arg_32_2 == 3 then
				var_32_0 = var_0_4:get_player_statistics_data_by_type(11) + var_0_4:get_player_statistics_data_by_type(12) + var_0_4:get_player_statistics_data_by_type(16) + var_0_4:get_player_statistics_data_by_type(23) + var_0_4:get_player_statistics_data_by_type(24)
			elseif arg_32_2 == 4 then
				var_32_0 = var_0_4:get_player_statistics_data_by_type(7) + var_0_4:get_player_statistics_data_by_type(8) + var_0_4:get_player_statistics_data_by_type(9) + var_0_4:get_player_statistics_data_by_type(10) + var_0_4:get_player_statistics_data_by_type(25)
			elseif arg_32_2 == 5 then
				var_32_0 = var_0_4:get_player_statistics_data_by_type(1) + var_0_4:get_player_statistics_data_by_type(3) + var_0_4:get_player_statistics_data_by_type(4) + var_0_4:get_player_statistics_data_by_type(5) + var_0_4:get_player_statistics_data_by_type(6) + var_0_4:get_player_statistics_data_by_type(23)
			elseif arg_32_2 == 6 then
				var_32_0 = var_0_4:get_player_statistics_data_by_type(14) + var_0_4:get_player_statistics_data_by_type(15)
			elseif arg_32_2 == 7 then
				var_32_0 = var_0_4:get_player_statistics_data_by_type(1) + var_0_4:get_player_statistics_data_by_type(2) + var_0_4:get_player_statistics_data_by_type(3)
			elseif arg_32_2 == 8 then
				var_32_0 = var_0_4:get_player_statistics_data().build_ship
			elseif arg_32_2 == 9 then
				var_32_0 = var_0_4:get_player_statistics_data().task_total
			elseif arg_32_2 == 10 then
				var_32_0 = var_0_4:get_player_statistics_data().maneuver_win
			elseif arg_32_2 == 11 then
				var_32_0 = var_0_4:get_player_statistics_data().quick_repair
			elseif arg_32_2 == 12 then
				var_32_0 = var_0_4:get_player_statistics_data().quick_build
			elseif arg_32_2 == 13 then
				var_32_0 = var_0_4:get_player_statistics_data().love_point_100
			elseif arg_32_2 == 14 then
				var_32_0 = var_0_4:get_player_statistics_data().map_not_boss_complete
			elseif arg_32_2 == 15 then
				var_32_0 = var_0_4:get_player_statistics_data().map_flag_supply_ship
			elseif arg_32_2 == 16 then
				var_32_0 = var_0_4:get_player_statistics_data().crop_count
			end
		end

		if arg_32_1 == 2 and var_0_4:find_task_state(arg_32_2) == 2 then
			var_32_0 = 1
		end

		if arg_32_1 == 3 then
			if arg_32_6 == 1 and var_0_4:is_map_pass(arg_32_2, arg_32_3) == true then
				var_32_0 = arg_32_4
			elseif arg_32_6 == 15 and var_0_4:seven_map_is_pass(arg_32_2) == true then
				var_32_0 = 1
			elseif arg_32_6 == 16 and var_0_4:score_map_is_pass(arg_32_2) == true then
				var_32_0 = 1
			elseif arg_32_6 == 17 and var_0_4:eighth_map_is_pass(arg_32_2) == true then
				var_32_0 = 1
			elseif arg_32_6 == 19 and var_0_4:ninth_map_is_pass(arg_32_2) == true then
				var_32_0 = 1
			end
		end

		if arg_32_1 == 4 and var_0_4:get_sixth_point_pass_by_grade(arg_32_2, arg_32_3, arg_32_5) then
			var_32_0 = 1
		end

		if arg_32_1 == 5 then
			if var_0_4:get_strike_map_point_pass_by_state_1(arg_32_2, arg_32_3, arg_32_5) then
				var_32_0 = 1
			end

			if var_0_4:get_strike_map_point_pass_by_state_2(arg_32_2, arg_32_3, arg_32_5) then
				var_32_0 = 1
			end
		end

		return var_32_0
	end
end

function var_0_0.extend_obj(arg_33_0)
	arg_33_0._desk_collection_data = {}
	arg_33_0._wall_collection_data = {}
	arg_33_0._medal_data = {}
	arg_33_0._show_medal_data = {}
	arg_33_0._show_room_style_data = {}
	arg_33_0._unlock_edal_data = {}
	arg_33_0._user_state = true
end

return var_0_0
