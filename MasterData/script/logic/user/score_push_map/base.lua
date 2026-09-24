local var_0_0 = {}
local var_0_1 = table.insert
local var_0_4 = gameconfig.score_map_node_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.reset_answer_data(arg_2_0)
		arg_2_0._score_question_team = {}
		arg_2_0._boss_hp_info = {}
		arg_2_0._score_map_data = {}
		arg_2_0._score_map_node_data = {}
		arg_2_0._score_map_buff_data = {}
		arg_2_0._score_map_buff_list = {}
		arg_2_0._score_buff_node_data = {}
		arg_2_0._score_team_data = {}
		arg_2_0._team_detail_data = {}
		arg_2_0._score_cia_info = {}
		arg_2_0._tmp_icon_list = {}
		arg_2_0._current_node_config = {}
		arg_2_0._unlocked_score_map_list = {}
		arg_2_0._score_map_box_list = {}
		arg_2_0._score_map_point_list = {}
		arg_2_0._all_buff_for_fight_list = {}
		arg_2_0._answer_task_data = {}
	end

	function arg_1_0:get_score_map_data()
		return self._score_map_data
	end

	function arg_1_0:get_current_score_map_data(arg_4_1)
		local var_4_0 = tonumber(string.sub(tostring(arg_4_1), 1, 5))

		if not self._score_map_data[var_4_0] then
			return
		end

		for iter_4_0, iter_4_1 in pairs(self._score_map_data[var_4_0].start_point) do
			if iter_4_1 == arg_4_1 then
				return self._score_map_data[var_4_0]
			end
		end

		return nil
	end

	function arg_1_0:__score_map_update_task_info(arg_5_1, arg_5_2)
		self._score_map_data[arg_5_1] = arg_5_2

		for iter_5_0, iter_5_1 in pairs(arg_5_2.pass_point) do
			local var_5_0 = var_0_4.find_object_by_id_start_node_id(iter_5_1.id, (var_0_4.get_start_node_id_by_id(iter_5_1.id)))

			if next(var_5_0.treasure_box) then
				for iter_5_2, iter_5_3 in pairs(iter_5_1.info) do
					if iter_5_3.grade == 1 or iter_5_3.grade == 2 then
						self:set_score_map_box_list(var_5_0.map_id)

						break
					end
				end
			end

			if var_5_0.score ~= 0 then
				self:set_score_map_point_list(arg_5_1, var_5_0.score)
			end
		end
	end

	function arg_1_0:__score_map_add_task_info(arg_6_1, arg_6_2)
		self._score_map_data[arg_6_1] = arg_6_2

		for iter_6_0, iter_6_1 in pairs(arg_6_2.pass_point) do
			local var_6_0 = var_0_4.find_object_by_id_start_node_id(iter_6_1.id, (var_0_4.get_start_node_id_by_id(iter_6_1.id)))

			if next(var_6_0.treasure_box) then
				for iter_6_2, iter_6_3 in pairs(iter_6_1.info) do
					if iter_6_3.grade == 1 or iter_6_3.grade == 2 then
						self:set_score_map_box_list(var_6_0.map_id)

						break
					end
				end
			end

			if var_6_0.score ~= 0 then
				self:set_score_map_point_list(arg_6_1, var_6_0.score)
			end
		end
	end

	function arg_1_0:set_score_map_point_list(arg_7_1, arg_7_2)
		local var_7_0 = false

		for iter_7_0, iter_7_1 in pairs(self._score_map_point_list) do
			if iter_7_0 == arg_7_1 then
				var_7_0 = true
			end
		end

		self._score_map_point_list[arg_7_1] = not var_7_0 and arg_7_2 or self._score_map_point_list[arg_7_1] + arg_7_2
	end

	function arg_1_0:get_score_map_point_list()
		return self._score_map_point_list
	end

	function arg_1_0:set_score_map_box_list(arg_9_1)
		self._score_map_box_list[arg_9_1] = 1
	end

	function arg_1_0:get_score_map_box_list()
		return self._score_map_box_list
	end

	function arg_1_0:__score_answer_question_update_task_info(arg_11_1)
		for iter_11_0, iter_11_1 in pairs(self._score_question_team) do
			if iter_11_1.id == arg_11_1.id then
				iter_11_1.answer = arg_11_1.answer
				iter_11_1.state = arg_11_1.state
			end
		end
	end

	function arg_1_0:__score_answer_question_add_task_info(arg_12_1)
		var_0_1(self._score_question_team, arg_12_1)
	end

	function arg_1_0.__score_answer_question_remove_task_info(arg_13_0, arg_13_1)
		return
	end

	function arg_1_0:get_score_question_team()
		return self._score_question_team
	end

	function arg_1_0.set_current_score_map_start_point(arg_15_0, arg_15_1)
		arg_15_0._current_score_map_start_point = arg_15_1
	end

	function arg_1_0:get_current_score_map_start_point()
		return tonumber(self._current_score_map_start_point)
	end

	function arg_1_0.set_current_node_config(arg_17_0, arg_17_1)
		arg_17_0._current_node_config = arg_17_1
	end

	function arg_1_0:get_current_node_config()
		return self._current_node_config
	end

	function arg_1_0:is_score_map_node_pass(arg_19_1, arg_19_2)
		local var_19_0 = false
		local var_19_1 = {}
		local var_19_2 = self:get_current_score_map_data(arg_19_1)

		if not var_19_2 then
			return var_19_0
		end

		for iter_19_0, iter_19_1 in ipairs(var_19_2.pass_point) do
			if iter_19_1.id == arg_19_2 then
				var_19_1 = iter_19_1
			end
		end

		if var_19_1.info ~= nil and var_19_1.info ~= {} then
			var_19_0 = true
		end

		return var_19_0
	end

	function arg_1_0:is_score_map_node_b_and_b_up_pass(arg_20_1, arg_20_2)
		local var_20_0 = false
		local var_20_2 = self:get_current_score_map_data(arg_20_1)

		if not var_20_2 then
			return var_20_0
		end

		local var_20_3 = var_20_2.pass_point

		if var_20_2.pass_point and next(var_20_3) then
			for iter_20_0, iter_20_1 in pairs(var_20_3) do
				if iter_20_1.id == arg_20_2 then
					for iter_20_2, iter_20_3 in pairs(iter_20_1.info) do
						if iter_20_3.grade <= 4 then
							var_20_0 = true
						end
					end
				end
			end
		end

		return var_20_0
	end

	function arg_1_0:is_score_map_node_s_up_pass(arg_21_1, arg_21_2)
		local var_21_0 = false
		local var_21_2 = self:get_current_score_map_data(arg_21_1)

		if not var_21_2 then
			return var_21_0
		end

		for iter_21_0, iter_21_1 in ipairs(var_21_2.pass_point) do
			if iter_21_1.id == arg_21_2 then
				for iter_21_2, iter_21_3 in pairs(iter_21_1.info) do
					if iter_21_3.grade <= 2 then
						var_21_0 = true

						return true
					end
				end
			end
		end

		return var_21_0
	end

	function arg_1_0:get_score_map_node_pass_count(arg_22_1, arg_22_2)
		local var_22_0 = false
		local var_22_1 = 0
		local var_22_2 = self:get_current_score_map_data(arg_22_1)

		if not var_22_2 then
			return
		end

		for iter_22_0, iter_22_1 in ipairs(var_22_2.pass_point) do
			if tonumber(arg_22_2) == iter_22_1.id then
				for iter_22_2, iter_22_3 in pairs(iter_22_1.info) do
					if iter_22_3.grade <= 4 then
						var_22_1 = var_22_1 + iter_22_3.count
					end
				end

				var_22_0 = true
			end
		end

		if var_22_0 then
			return var_22_1
		else
			return 0
		end
	end

	function arg_1_0:set_score_map_tmp_icon_list(arg_23_1, arg_23_2)
		self._tmp_icon_list[arg_23_1] = arg_23_2 ~= nil and arg_23_2 or {}
	end

	function arg_1_0:score_map_node_pass_boss(arg_24_1, arg_24_2)
		local var_24_0 = false

		for iter_24_0, iter_24_1 in pairs(self._score_map_data) do
			if iter_24_1.boss_hp[1].id == arg_24_2 and iter_24_1.boss_hp[1].hp == 0 then
				var_24_0 = true
			end

			if #iter_24_1.boss_hp > 1 and iter_24_1.boss_hp[2].id == arg_24_2 and iter_24_1.boss_hp[2].hp == 0 then
				var_24_0 = true
			end
		end

		return var_24_0
	end

	function arg_1_0:get_score_map_tmp_icon_list()
		return self._tmp_icon_list
	end

	function arg_1_0:get_score_team_detail_data()
		return self._team_detail_data
	end

	function arg_1_0.set_score_team_detail_data(arg_27_0, arg_27_1)
		arg_27_0._team_detail_data = arg_27_1
	end

	function arg_1_0:is_score_map_pass(arg_28_1)
		return self._score_map_data[arg_28_1] ~= nil and self._score_map_data[arg_28_1].state == 2
	end

	function arg_1_0:get_score_map_buff_list()
		return self._score_map_buff_list
	end

	function arg_1_0:get_answer_award_info()
		return self._answer_award_info
	end

	function arg_1_0:get_answer_task_info()
		return self._answer_task_data
	end

	function arg_1_0:_get_now_task_data()
		return self._now_answer_task_id
	end

	function arg_1_0._clear_now_task_data(arg_33_0, arg_33_1)
		arg_33_0._now_answer_task_id = arg_33_1
	end

	function arg_1_0.set_come_in_info(arg_34_0, arg_34_1)
		arg_34_0._come_in_score_info = arg_34_1
	end

	function arg_1_0:get_common_in_info()
		return self._come_in_score_info
	end

	function arg_1_0:get_add_task_state()
		return self.add_task_state
	end

	function arg_1_0.set_add_task_state(arg_37_0, arg_37_1)
		arg_37_0.add_task_state = arg_37_1
	end

	function arg_1_0:get_is_cur_score_difficulty_mode()
		return self._now_state ~= 1
	end

	function arg_1_0.set_now_level_state(arg_39_0, arg_39_1)
		arg_39_0._now_state = arg_39_1
	end

	function arg_1_0:record_score_push_info_pass(arg_40_1, arg_40_2)
		self._score_push_info_pass_objs = self._score_push_info_pass_objs or {}
		self._score_push_info_pass_objs[arg_40_1] = arg_40_2
	end

	function arg_1_0.reset_score_push_info_pass(arg_41_0)
		arg_41_0._score_push_info_pass_objs = {}
	end

	function arg_1_0:is_score_push_info_pass(arg_42_1)
		return self._score_push_info_pass_objs[arg_42_1]
	end

	function arg_1_0.set_come_in_score_panel_id(arg_43_0, arg_43_1)
		arg_43_0._come_in_score_panel_id = arg_43_1
	end

	function arg_1_0:get_come_in_score_panel_id()
		return self._come_in_score_panel_id
	end

	function arg_1_0.set_score_map_pass(arg_45_0, arg_45_1)
		arg_45_0._score_pass_already_pass = arg_45_1
	end

	function arg_1_0:get_score_map_pass()
		return self._score_pass_already_pass
	end

	function arg_1_0:get_first_answer_task_id()
		return self._first_answer_task_id
	end

	function arg_1_0.set_first_answer_task_id(arg_48_0)
		arg_48_0._first_answer_task_id = nil
	end

	function arg_1_0:set_answer_server_honor_list(arg_49_1)
		if arg_49_1 and arg_49_1.info and next(arg_49_1.info) then
			self.answer_server_honor_list = {}

			for iter_49_0, iter_49_1 in pairs(arg_49_1.info) do
				table.insert(self.answer_server_honor_list, iter_49_1)
			end
		end
	end

	function arg_1_0:get_answer_server_honor_list()
		if self.answer_server_honor_list and next(self.answer_server_honor_list) then
			return self.answer_server_honor_list
		else
			return {}
		end
	end
end

function var_0_0.extend_obj(arg_51_0)
	arg_51_0._boss_hp_info = {}
	arg_51_0._score_map_data = {}
	arg_51_0._score_map_node_data = {}
	arg_51_0._score_map_buff_data = {}
	arg_51_0._score_map_buff_list = {}
	arg_51_0._score_buff_node_data = {}
	arg_51_0._score_team_data = {}
	arg_51_0._score_cia_info = {}
	arg_51_0._team_detail_data = {}
	arg_51_0._current_score_map_start_point = 961301
	arg_51_0._tmp_icon_list = {}
	arg_51_0._current_node_config = {}
	arg_51_0._unlocked_score_map_list = {}
	arg_51_0._score_map_box_list = {}
	arg_51_0._score_map_point_list = {}
	arg_51_0._all_buff_for_fight_list = {}
	arg_51_0._score_question_team = {}
	arg_51_0._answer_task_data = {}
	arg_51_0._now_task_data = nil
	arg_51_0._come_in_score_info = 1
	arg_51_0.add_task_state = false
	arg_51_0._come_in_score_panel_id = nil
	arg_51_0._now_answer_task_id = nil
	arg_51_0._first_answer_task_id = nil
	arg_51_0._answer_award_info = {}
	arg_51_0.answer_server_honor_list = {}
end

return var_0_0
