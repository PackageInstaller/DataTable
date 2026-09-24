local var_0_0 = {}
local var_0_1 = gameenum.common_type
local var_0_2 = lx.ServerTime
local var_0_3 = table.remove
local var_0_4 = gameconfig.map_node_config
local var_0_5 = string.sub
local var_0_6 = table.insert
local var_0_7 = gameconfig.map_config
local var_0_8 = gameconfig.pve_active_map_config
local var_0_9 = gameconfig.pve_active_map_node_config
local var_0_10 = gamecore.UILoader
local var_0_11 = gamecore.user

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:reset_map_data()
		self._map_data.map = {}
		self._maneuver_resp_info = {}
		self._map_data.maneuver = {}
		self._pve_condition = nil
		self._main_line_max_map = nil
	end

	function arg_1_0:reset_map_expedition()
		self._map_data.expedition = {}
	end

	function arg_1_0:get_map_list()
		return self._map_data.map
	end

	function arg_1_0:get_pve_condition()
		return self._pve_condition
	end

	function arg_1_0:get_expedition_info(arg_6_1)
		return self._map_data.expedition[arg_6_1]
	end

	function arg_1_0:is_map_pass(arg_7_1)
		local var_7_0 = self._map_data.map[tonumber(arg_7_1)]

		return var_7_0 ~= nil and var_7_0.state == 2
	end

	function arg_1_0:is_quickly_map_pass(arg_8_1)
		local var_8_1 = 0
		local var_8_2 = false
		local var_8_3

		if self:is_map_pass(arg_8_1) then
			if var_0_8.find_object_by_id(arg_8_1).next_pve_level_id[1] ~= 0 then
				var_8_1 = var_0_8.find_object_by_id(arg_8_1).next_pve_level_id[1]
			else
				var_8_2 = true
			end

			var_8_3 = true
		else
			var_8_3 = false
		end

		return var_8_3, var_8_1, var_8_2
	end

	function arg_1_0:is_map_node_pass(arg_9_1, arg_9_2)
		local var_9_0 = false

		if self._map_data.map[arg_9_1] and self._map_data.map[arg_9_1].pass_point then
			for iter_9_0, iter_9_1 in ipairs(self._map_data.map[arg_9_1].pass_point) do
				if arg_9_2 == iter_9_1.id then
					var_9_0 = true
				end
			end
		end

		return var_9_0
	end

	function arg_1_0:is_map_node_pass_b_and_b_up(arg_10_1, arg_10_2)
		local var_10_0 = false

		if self._map_data.map[arg_10_1] and self._map_data.map[arg_10_1].pass_point then
			for iter_10_0, iter_10_1 in ipairs(self._map_data.map[arg_10_1].pass_point) do
				if arg_10_2 == iter_10_1.id then
					for iter_10_2, iter_10_3 in pairs(iter_10_1.info) do
						if iter_10_3.grade <= 4 then
							var_10_0 = true
						end
					end
				end
			end
		end

		return var_10_0
	end

	function arg_1_0:is_map_node_s_pass(arg_11_1, arg_11_2)
		local var_11_0 = false
		local var_11_1 = true

		if self._map_data.map[arg_11_1] and self._map_data.map[arg_11_1].pass_point then
			local var_11_2 = 0

			for iter_11_0, iter_11_1 in ipairs(self._map_data.map[arg_11_1].pass_point) do
				if arg_11_2 == iter_11_1.id then
					for iter_11_2, iter_11_3 in pairs(iter_11_1.info) do
						if iter_11_3.grade <= 2 then
							var_11_0 = true
							var_11_2 = var_11_2 + 1
						end
					end
				end
			end

			if var_11_2 > 1 then
				var_11_1 = false
			end
		end

		return var_11_0, (not var_11_0 or nil) and false
	end

	function arg_1_0:get_map_node_pass_count(arg_12_1, arg_12_2)
		local var_12_0 = false
		local var_12_1 = 0

		if self._map_data.map[arg_12_1] and self._map_data.map[arg_12_1].pass_point then
			for iter_12_0, iter_12_1 in ipairs(self._map_data.map[arg_12_1].pass_point) do
				if arg_12_2 == iter_12_1.id then
					for iter_12_2, iter_12_3 in pairs(iter_12_1.info) do
						if iter_12_3.grade <= 4 then
							var_12_1 = var_12_1 + iter_12_3.count
						end
					end

					var_12_0 = true
				end
			end
		end

		if var_12_0 then
			return var_12_1
		else
			return 0
		end
	end

	function arg_1_0.set_can_show(arg_13_0, arg_13_1)
		arg_13_0._can_show = arg_13_1
	end

	function arg_1_0.set_pve_condition(arg_14_0, arg_14_1)
		arg_14_0._pve_condition = arg_14_1
	end

	function arg_1_0.set_clear_map_id(arg_15_0, arg_15_1)
		arg_15_0._last_clear_map_id = arg_15_1
	end

	function arg_1_0:get_clear_map_id()
		return self._last_clear_map_id
	end

	function arg_1_0.set_clear_map_reward(arg_17_0, arg_17_1)
		arg_17_0._last_clear_map_reward = arg_17_1
	end

	function arg_1_0:get_clear_map_reward()
		return self._last_clear_map_reward
	end

	function arg_1_0.set_exercise_enemy_config_list(arg_19_0, arg_19_1)
		arg_19_0._exercise_enemy_config_list = arg_19_1
	end

	function arg_1_0:get_exercise_enemy_config_list()
		return self._exercise_enemy_config_list
	end

	function arg_1_0:is_campaijn_pass(arg_21_1)
		local var_21_0 = self:get_campaign_data(arg_21_1)

		if var_21_0 then
			return var_21_0.info.state == 2
		end

		return false
	end

	function arg_1_0:check_expedition_state(arg_22_1)
		local var_22_0 = var_0_1.expedition_state.prepare
		local var_22_1 = 0

		for iter_22_0, iter_22_1 in pairs(self._map_data.expedition) do
			if arg_22_1 == iter_22_0 and iter_22_1 then
				if iter_22_1.end_time > var_0_2:getUtcTime() then
					var_22_0 = var_0_1.expedition_state.ongoing
					var_22_1 = iter_22_1.end_time
				else
					var_22_0 = var_0_1.expedition_state.done
				end
			end
		end

		return var_22_0, var_22_1
	end

	function arg_1_0:get_maneuver_data()
		return self._map_data.maneuver
	end

	function arg_1_0:get_maneuver_data_byid(arg_24_1)
		for iter_24_0, iter_24_1 in ipairs(self._map_data.maneuver) do
			if iter_24_1.id == arg_24_1 then
				return iter_24_1
			end
		end
	end

	function arg_1_0:set_battle_info_whithout_server(arg_25_1)
		self._map_data.battle_info = arg_25_1
	end

	function arg_1_0:get_battle_info()
		return self._map_data.battle_info
	end

	function arg_1_0:get_strong_buff_list()
		return self._strong_buff_list
	end

	function arg_1_0.set_strong_buff_list(arg_28_0, arg_28_1)
		arg_28_0._strong_buff_list = arg_28_1
	end

	function arg_1_0:get_cur_butter_list(arg_29_1)
		if arg_29_1 then
			return self._cur_butter_list[arg_29_1]
		else
			return self._cur_butter_list
		end
	end

	function arg_1_0:get_map_move_info()
		return self._map_data.map_move
	end

	function arg_1_0:get_maneuver_resp_info()
		return self._maneuver_resp_info
	end

	function arg_1_0.set_maneuver_target_info(arg_32_0, arg_32_1)
		arg_32_0._maneuver_target_info = arg_32_1
	end

	function arg_1_0:get_maneuver_target_info()
		return self._maneuver_target_info
	end

	function arg_1_0:get_ship_data_by_id_in_maneuver_target_info(arg_34_1)
		local var_34_0 = {}
		local var_34_1 = lx.clone_table(self._maneuver_target_info.garrison)

		if var_34_1 then
			for iter_34_0, iter_34_1 in pairs(var_34_1) do
				iter_34_1.id = iter_34_1.id or iter_34_1.cid

				if iter_34_1.id == arg_34_1 then
					var_34_0 = iter_34_1

					break
				end
			end
		end

		return var_34_0
	end

	function arg_1_0:get_friend_ship_data_by_id_in_maneuver_target_info(arg_35_1)
		local var_35_0 = {}

		if self._maneuver_target_info.garrison then
			for iter_35_0, iter_35_1 in pairs((lx.clone_table(self._maneuver_target_info.mansion.garrison))) do
				iter_35_1.id = iter_35_1.id or iter_35_1.cid

				if iter_35_1.id == arg_35_1 then
					var_35_0 = iter_35_1

					break
				end
			end
		end

		return var_35_0
	end

	function arg_1_0:get_refresh_count()
		return self._refresh_count
	end

	function arg_1_0:get_can_show()
		return self._can_show
	end

	function arg_1_0:get_maneuver_friend_rival()
		return self._maneuver_friend_rival
	end

	function arg_1_0.set_special_node_count(arg_39_0, arg_39_1)
		arg_39_0._special_node_count = arg_39_1
	end

	function arg_1_0:get_special_node_count()
		return self._special_node_count
	end

	function arg_1_0:get_main_line_max_chapter()
		return self._main_line_max_map or 101
	end

	function arg_1_0.__set_main_line_max_chapter(arg_42_0, arg_42_1)
		arg_42_0._main_line_max_map = arg_42_1
	end

	function arg_1_0:__map__update_map_info(arg_43_1, arg_43_2)
		if arg_43_1 == var_0_1.update_modify then
			self._map_data.map[arg_43_2.id] = arg_43_2
		elseif arg_43_1 == var_0_1.update_add then
			if arg_43_2.id < var_0_1.normal_map_max_id and arg_43_2.state == var_0_1.level_state.complete then
				local var_43_0 = var_0_7.find_object_by_id(arg_43_2.id).next_pve_level_id

				if var_43_0 and var_43_0[1] > self:get_main_line_max_chapter() then
					self:__set_main_line_max_chapter(var_43_0[1])
				end
			end

			self._map_data.map[arg_43_2.id] = arg_43_2
		elseif arg_43_1 == var_0_1.update_remove then
			self._map_data.map[arg_43_2.id] = nil
		end
	end

	function arg_1_0:__map__update_expedition_info(arg_44_1)
		self._map_data.expedition[arg_44_1.id] = arg_44_1
	end

	function arg_1_0:__map__add_expedition_info(arg_45_1)
		self._map_data.expedition[arg_45_1.id] = arg_45_1
	end

	function arg_1_0:__map__remove_expedition_info(arg_46_1)
		self._map_data.expedition[arg_46_1.id] = nil
	end

	function arg_1_0:__map__update_maneuver_info(arg_47_1)
		local var_47_0

		for iter_47_0, iter_47_1 in ipairs(self._map_data.maneuver) do
			if iter_47_1.id == arg_47_1.id then
				var_47_0 = iter_47_0

				break
			end
		end

		if var_47_0 and self._map_data.maneuver[var_47_0] then
			self._map_data.maneuver[var_47_0] = arg_47_1
		else
			local var_47_1 = var_0_10:getInstance("home")

			if var_47_1 then
				var_47_1:__onScaleButtonClick_bottom_btn_out()
			else
				var_0_10:createInstance("home"):__onScaleButtonClick_bottom_btn_out()
			end
		end
	end

	function arg_1_0:__map__add_maneuver_info(arg_48_1)
		local var_48_0 = false

		for iter_48_0, iter_48_1 in ipairs(self._map_data.maneuver) do
			if iter_48_1.id == arg_48_1.id then
				var_48_0 = true
			end
		end

		if not var_48_0 then
			table.insert(self._map_data.maneuver, arg_48_1)
		end

		table.sort(self._map_data.maneuver, function(arg_49_0, arg_49_1)
			return arg_49_0.id < arg_49_1.id
		end)
	end

	function arg_1_0:__map__remove_maneuver_info(arg_50_1)
		local var_50_0

		for iter_50_0, iter_50_1 in ipairs(self._map_data.maneuver) do
			if iter_50_1.id == arg_50_1.id then
				var_50_0 = iter_50_0

				break
			end
		end

		var_0_3(self._map_data.maneuver, var_50_0)
	end

	function arg_1_0:__map__update_battle_info(arg_51_1)
		self._map_data.battle_info = arg_51_1

		local var_51_0 = var_0_4.find_object_by_id(arg_51_1.point)

		if arg_51_1.type == gameenum.battle_type.fight_type.push then
			var_51_0 = var_0_9.find_object_by_id(arg_51_1.point)
		end

		if var_51_0 then
			if var_51_0.pve_level_id < var_0_1.normal_map_max_id then
				if var_51_0.pve_level_id < 1000 then
					self:set_last_map_node({
						chapter_index = tonumber(var_0_5(var_51_0.pve_level_id, 1, 1)),
						small_mapindex = tonumber(var_0_5(var_51_0.pve_level_id, 3, 3))
					})
				else
					self:set_last_map_node({
						chapter_index = tonumber(var_0_5(var_51_0.pve_level_id, 1, 2)),
						small_mapindex = tonumber(var_0_5(var_51_0.pve_level_id, 4, 4))
					})
				end
			end
		end

		if self._cur_butter_list[arg_51_1.id] then
			local var_51_1 = false

			for iter_51_0, iter_51_1 in pairs(self._cur_butter_list[arg_51_1.id]) do
				if iter_51_1 == arg_51_1.point then
					var_51_1 = true
				end
			end

			if not var_51_1 then
				var_0_6(self._cur_butter_list[arg_51_1.id], arg_51_1.point, true)
			else
				self._cur_butter_list = {}
				self._cur_butter_list[arg_51_1.id] = {}

				var_0_6(self._cur_butter_list[arg_51_1.id], arg_51_1.point, true)
			end
		else
			self._cur_butter_list = {}
			self._cur_butter_list[arg_51_1.id] = {}

			var_0_6(self._cur_butter_list[arg_51_1.id], arg_51_1.point, true)
		end
	end

	function arg_1_0:add_cur_buttle_list(arg_52_1)
		if self._cur_butter_list[arg_52_1.id] then
			local var_52_0 = false

			for iter_52_0, iter_52_1 in pairs(self._cur_butter_list[arg_52_1.id]) do
				if iter_52_1 == arg_52_1.point then
					var_52_0 = true
				end
			end

			if not var_52_0 then
				var_0_6(self._cur_butter_list[arg_52_1.id], arg_52_1.point, true)
			end
		else
			self._cur_butter_list[arg_52_1.id] = {}

			var_0_6(self._cur_butter_list[arg_52_1.id], arg_52_1.point, true)
		end
	end

	function arg_1_0.clear_cur_butter_list(arg_53_0)
		arg_53_0._cur_butter_list = {}
	end

	function arg_1_0.set_is_first_open_fearlessness_hard(arg_54_0, arg_54_1)
		arg_54_0._is_first_open_fearlessness_hard = arg_54_1
	end

	function arg_1_0:get_is_first_open_fearlessness_hard(arg_55_1)
		return self._is_first_open_fearlessness_hard
	end

	function arg_1_0:__maneuver_friend_rival_update(arg_56_1)
		self._maneuver_friend_rival[arg_56_1.id] = arg_56_1
	end

	function arg_1_0:__maneuver_friend_rival_add(arg_57_1)
		self._maneuver_friend_rival[arg_57_1.id] = arg_57_1
	end

	function arg_1_0:__maneuver_friend_rival_remove(arg_58_1)
		self._maneuver_friend_rival[arg_58_1.id] = nil
	end

	function arg_1_0:is_point_stationed(arg_59_1)
		local var_59_0 = false
		local var_59_1 = 0

		for iter_59_0, iter_59_1 in pairs(self:get_team_group(var_0_1.team_type.normal)) do
			if iter_59_1.station and iter_59_1.station_point == arg_59_1 then
				var_59_0 = true
				var_59_1 = iter_59_1.id

				break
			end
		end

		return var_59_0, var_59_1
	end

	function arg_1_0.seven_map_is_pass(arg_60_0, arg_60_1)
		local var_60_0 = var_0_11:get_seventh_map_info()[arg_60_1]

		return not not (var_60_0 and next(var_60_0) and var_60_0.state == 2)
	end

	function arg_1_0.eighth_map_is_pass(arg_61_0, arg_61_1)
		local var_61_0 = var_0_11:get_eighth_map_info()[arg_61_1]

		return not not (var_61_0 and next(var_61_0) and var_61_0.state == 2)
	end

	function arg_1_0.score_map_is_pass(arg_62_0, arg_62_1)
		local var_62_0 = var_0_11:get_score_map_data()[arg_62_1]

		return not not (var_62_0 and next(var_62_0) and var_62_0.state == 2)
	end

	function arg_1_0.ninth_map_is_pass(arg_63_0, arg_63_1)
		local var_63_0 = var_0_11:get_ninth_map_data()[arg_63_1]

		return not not (var_63_0 and next(var_63_0) and var_63_0.state == 2)
	end

	function arg_1_0.set_campaign_map_id(arg_64_0, arg_64_1)
		arg_64_0._campaign_map_id = arg_64_1
	end

	function arg_1_0:get_campaign_map_id()
		return self._campaign_map_id
	end
end

function var_0_0.extend_obj(arg_66_0)
	arg_66_0._map_data = {
		map = {},
		expedition = {},
		maneuver = {},
		battle_info = {}
	}
	arg_66_0._maneuver_resp_info = {}
	arg_66_0._maneuver_target_info = {}
	arg_66_0._cur_butter_list = {}
	arg_66_0._strong_buff_list = nil
	arg_66_0._refresh_count = 0
	arg_66_0._can_show = true
	arg_66_0._maneuver_friend_rival = {}
	arg_66_0._pve_condition = nil
	arg_66_0._last_clear_map_id = 0
	arg_66_0._last_clear_map_reward = nil
	arg_66_0._is_first_open_fearlessness_hard = false
	arg_66_0._exercise_enemy_config_list = {}
	arg_66_0._special_push_random_data = {}
	arg_66_0._campaign_map_id = nil
end

return var_0_0
