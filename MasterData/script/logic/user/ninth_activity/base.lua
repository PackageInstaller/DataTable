local var_0_0 = {}

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:get_all_node_info()
		return self.all_node_info
	end

	function arg_1_0:__ninth_map_info_update_info(arg_3_1, arg_3_2)
		self._ninth_map_data[arg_3_1] = arg_3_2
	end

	function arg_1_0:__ninth_map_info_add_info(arg_4_1, arg_4_2)
		self._ninth_map_data[arg_4_1] = arg_4_2
	end

	function arg_1_0:set_server_honor_list(arg_5_1)
		if arg_5_1 and arg_5_1.info and next(arg_5_1.info) then
			for iter_5_0, iter_5_1 in pairs(arg_5_1.info) do
				local var_5_0 = tostring(iter_5_1.account_id) .. "_" .. tostring(iter_5_1.channel)

				if not gamecore.util_func.have_data(self.server_check_list, var_5_0) then
					table.insert(self.server_check_list, var_5_0)
					table.insert(self.server_honor_list, iter_5_1)
				end
			end
		end
	end

	function arg_1_0.set_server_honor_list_extra(arg_6_0, arg_6_1)
		arg_6_0.server_honor_list_ex = arg_6_1
	end

	function arg_1_0:get_server_honor_list()
		if self.server_honor_list and next(self.server_honor_list) then
			return self.server_honor_list
		else
			return {}
		end
	end

	function arg_1_0:get_server_honor_list_extra()
		if self.server_honor_list_ex and next(self.server_honor_list_ex) then
			return self.server_honor_list_ex.info
		else
			return {}
		end
	end

	function arg_1_0.set_ninth_level_pass_num(arg_9_0, arg_9_1)
		arg_9_0._ninth_level_pass_num = arg_9_1
	end

	function arg_1_0.set_ninth_level_pass_num_extra(arg_10_0, arg_10_1)
		arg_10_0._ninth_level_pass_num_ex = arg_10_1
	end

	function arg_1_0:get_ninth_level_pass_num(arg_11_1)
		if not self._ninth_level_pass_num or not next(self._ninth_level_pass_num) then
			return 0
		end

		for iter_11_0, iter_11_1 in pairs(self._ninth_level_pass_num) do
			if iter_11_1.level_id == arg_11_1 then
				return iter_11_1.num
			end
		end

		return 0
	end

	function arg_1_0:get_ninth_level_pass_num_extra(arg_12_1)
		if not self._ninth_level_pass_num_ex or not next(self._ninth_level_pass_num_ex) then
			return 0
		end

		for iter_12_0, iter_12_1 in pairs(self._ninth_level_pass_num_ex) do
			if iter_12_1.level_id == arg_12_1 then
				return iter_12_1.num
			end
		end

		return 0
	end

	function arg_1_0:is_ninth_map_node_pass(arg_13_1, arg_13_2)
		local var_13_0 = false
		local var_13_1 = {}
		local var_13_2 = self:get_ninth_active_map_data(arg_13_1)

		if not var_13_2 then
			return var_13_0
		end

		for iter_13_0, iter_13_1 in ipairs(var_13_2.pass_point) do
			if iter_13_1.id == arg_13_2 then
				var_13_1 = iter_13_1
			end
		end

		if var_13_1.info ~= nil and var_13_1.info ~= {} then
			var_13_0 = true
		end

		return var_13_0
	end

	function arg_1_0:get_ninth_active_map_data(arg_14_1)
		local var_14_0 = tonumber(string.sub(tostring(arg_14_1), 1, 5))

		if not self._ninth_map_data then
			return
		end

		if not self._ninth_map_data[var_14_0] then
			return
		end

		for iter_14_0, iter_14_1 in pairs(self._ninth_map_data[var_14_0].pass_point) do
			return self._ninth_map_data[var_14_0]
		end

		return nil
	end

	function arg_1_0:get_ninth_award_data()
		return self._ninth_award_data
	end

	function arg_1_0.set_get_award_info(arg_16_0, arg_16_1)
		arg_16_0._ninth_award_data = arg_16_1
	end

	function arg_1_0.set_ninth_map_start_point(arg_17_0, arg_17_1)
		arg_17_0._ninth_map_start_point = arg_17_1
	end

	function arg_1_0:get_ninth_map_start_point()
		return self._ninth_map_start_point
	end

	function arg_1_0:get_ninth_score_info()
		return self._ninth_award_score
	end

	function arg_1_0:get_ninth_guide_state()
		return self._ninth_guide_state
	end

	function arg_1_0:get_ninth_team_detail_data()
		return self._team_detail_data
	end

	function arg_1_0.set_ninth_team_detail_data(arg_22_0, arg_22_1)
		arg_22_0._team_detail_data = arg_22_1
	end

	function arg_1_0:record_ninth_info_pass(arg_23_1, arg_23_2)
		self._ninth_push_info_pass_objs = self._ninth_push_info_pass_objs or {}
		self._ninth_push_info_pass_objs[arg_23_1] = arg_23_2
	end

	function arg_1_0.reset_ninth_push_info_pass(arg_24_0)
		arg_24_0._ninth_push_info_pass_objs = {}
	end

	function arg_1_0:is_ninth_push_info_pass(arg_25_1)
		return self._ninth_push_info_pass_objs[arg_25_1]
	end

	function arg_1_0:get_ninth_map_tmp_icon_list()
		return self._tmp_icon_list
	end

	function arg_1_0:set_ninth_map_tmp_icon_list(arg_27_1, arg_27_2)
		self._tmp_icon_list[arg_27_1] = arg_27_2 ~= nil and arg_27_2 or {}
	end

	function arg_1_0:get_ninth_map_data()
		return self._ninth_map_data
	end

	function arg_1_0:get_is_cur_ninth_difficulty_mode()
		return self._now_state
	end

	function arg_1_0.set_now_level_state(arg_30_0, arg_30_1)
		arg_30_0._now_state = arg_30_1
	end

	function arg_1_0:is_ninth_map_node_b_and_b_up_pass(arg_31_1, arg_31_2)
		if not self:get_ninth_map_data() then
			return false
		end

		return false
	end

	function arg_1_0:get_ninth_map_node_pass_count(arg_32_1, arg_32_2)
		local var_32_0 = false
		local var_32_1 = 0
		local var_32_2 = tonumber(string.sub(tostring(arg_32_1), 1, 5))

		if not self._ninth_map_data[var_32_2] then
			return
		end

		for iter_32_0, iter_32_1 in ipairs(self._ninth_map_data[var_32_2].pass_point) do
			if tonumber(arg_32_2) == iter_32_1.id then
				for iter_32_2, iter_32_3 in pairs(iter_32_1.info) do
					if iter_32_3.grade <= 4 then
						var_32_1 = var_32_1 + iter_32_3.count
					end
				end

				var_32_0 = true
			end
		end

		if var_32_0 then
			return var_32_1
		else
			return 0
		end
	end

	function arg_1_0:get_ninth_task_info_list()
		return self._ninth_task_info
	end

	function arg_1_0:get_ninth_server_task_info_list()
		return self._ninth_server_task_info
	end

	function arg_1_0.set_ninth_cia_buff_info(arg_35_0, arg_35_1)
		arg_35_0._ninth_buff_ids = arg_35_1
	end

	function arg_1_0:get_ninth_cia_buff_info()
		if self._ninth_buff_ids and next(self._ninth_buff_ids) then
			return self._ninth_buff_ids
		else
			return {}
		end
	end

	function arg_1_0:get_ninth_cia_buff_point()
		return self._ninth_buff_point or 0
	end

	function arg_1_0:get_ninth_pass_award_score()
		return self._ninth_award_score or 0
	end

	function arg_1_0.set_ninth_map_pass(arg_39_0, arg_39_1)
		arg_39_0._ninth_pass_already_pass = arg_39_1
	end

	function arg_1_0:get_ninth_map_pass()
		return self._ninth_pass_already_pass
	end

	function arg_1_0.set_ninth_boss_hp_info(arg_41_0, arg_41_1)
		arg_41_0._ninth_boss_hp_info = arg_41_1
	end

	function arg_1_0:get_ninth_boss_hp_info()
		return self._ninth_boss_hp_info
	end

	function arg_1_0.set_is_ninth_boss(arg_43_0, arg_43_1)
		arg_43_0._is_boss = arg_43_1
	end

	function arg_1_0:get_is_ninth_boss(arg_44_1)
		return self._is_boss
	end

	function arg_1_0.set_ninth_active_common_num(arg_45_0, arg_45_1)
		arg_45_0._common_info = arg_45_1
	end

	function arg_1_0:get_ninth_active_common_num()
		return self._common_info
	end

	function arg_1_0:set_ninth_fight_cam(arg_47_1, arg_47_2, arg_47_3)
		if not arg_47_1 or not self._ninth_fight_cam_pos or not self._ninth_fight_ship_pos then
			self._ninth_fight_cam_pos = {}
			self._ninth_fight_ship_pos = {}
		end

		if arg_47_1 then
			self._ninth_fight_cam_pos[arg_47_1] = arg_47_2
			self._ninth_fight_ship_pos[arg_47_1] = arg_47_3
		end
	end

	function arg_1_0:get_ninth_fight_cam(arg_48_1)
		if not self._ninth_fight_cam_pos or not self._ninth_fight_ship_pos then
			self._ninth_fight_cam_pos = {}
			self._ninth_fight_ship_pos = {}
		end

		return self._ninth_fight_cam_pos[arg_48_1], self._ninth_fight_ship_pos[arg_48_1]
	end
end

function var_0_0.extend_obj(arg_49_0)
	arg_49_0._ninth_map_data = {}
	arg_49_0.all_node_info = {}
	arg_49_0._ninth_award_data = nil
	arg_49_0._ninth_map_start_point = nil
	arg_49_0._ninth_award_score = 0
	arg_49_0._ninth_guide_state = nil
	arg_49_0._now_state = false
	arg_49_0._tmp_icon_list = {}
	arg_49_0._ninth_level_pass_num = {}
	arg_49_0._ninth_level_pass_num_ex = {}
	arg_49_0._ninth_task_info = {}
	arg_49_0._ninth_server_task_info = {}
	arg_49_0._ninth_buff_ids = {}
	arg_49_0._is_boss = false
	arg_49_0.server_honor_list = {}
	arg_49_0.server_check_list = {}
	arg_49_0.server_honor_list_ex = {}
	arg_49_0._ninth_pass_already_pass = nil
	arg_49_0._ninth_boss_hp_info = nil
	arg_49_0._common_info = {}
	arg_49_0._station_point_next_info = false
end

return var_0_0
