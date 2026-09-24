local var_0_0 = {}
local var_0_1 = table.insert
local var_0_2 = gameenum.common_type
local var_0_5 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:AnswerMapInfoUpdate(arg_2_1)
		if arg_2_1 and next(arg_2_1) then
			for iter_2_0, iter_2_1 in pairs(arg_2_1.updates) do
				self:__score_map_action(iter_2_1.info.id, iter_2_1.action, iter_2_1.info)
			end
		end
	end

	function arg_1_0:__score_map_action(arg_3_1, arg_3_2, arg_3_3)
		if arg_3_2 == var_0_2.update_modify then
			self:__score_map_update_task_info(arg_3_1, arg_3_3)
		elseif arg_3_2 == var_0_2.update_add then
			self:__score_map_add_task_info(arg_3_1, arg_3_3)
		elseif arg_3_2 == var_0_2.update_remove then
			self:__score_map_remove_task_info(arg_3_1, arg_3_3)
		end
	end

	function arg_1_0.AnswerInfoUpdate(arg_4_0, arg_4_1)
		if arg_4_1 then
			arg_4_0._player_answer_num = arg_4_1.info
		end
	end

	function arg_1_0:get_score_cia_num()
		return self._player_answer_num
	end

	function arg_1_0:get_player_answer_num()
		return self._player_answer_num
	end

	function arg_1_0:AnswerQuestionUpdate(arg_7_1)
		if arg_7_1 and next(arg_7_1) then
			for iter_7_0, iter_7_1 in pairs(arg_7_1.updates) do
				self:__score_answer_action(iter_7_1.action, iter_7_1.info)
			end
		end
	end

	function arg_1_0:__score_answer_action(arg_8_1, arg_8_2)
		if arg_8_1 == var_0_2.update_modify then
			self:__score_answer_question_update_task_info(arg_8_2)
		elseif arg_8_1 == var_0_2.update_add then
			self:__score_answer_question_add_task_info(arg_8_2)
		elseif arg_8_1 == var_0_2.update_remove then
			self:__score_answer_question_remove_task_info(arg_8_2)
		end
	end

	function arg_1_0.AnswerBuffInfoNotify(arg_9_0, arg_9_1)
		arg_9_0._score_map_buff_list = arg_9_1 and next(arg_9_1) and arg_9_1 or {
			ids = {}
		}
	end

	function arg_1_0:AnswerAwardInfoNotify(arg_10_1)
		if arg_10_1 and next(arg_10_1) then
			if arg_10_1.ids then
				self._answer_award_info.reward = arg_10_1.ids
			end
		else
			self._answer_award_info.reward = {}
		end
	end

	function arg_1_0:AnswerTaskInfoNotify(arg_11_1)
		local var_11_0 = self:get_answer_task_info()

		if var_11_0 and var_11_0[1] then
			self._now_answer_task_id = arg_11_1.ids[1]

			var_0_1(self._answer_task_data, arg_11_1.ids[1])
		elseif arg_11_1 and next(arg_11_1) and arg_11_1.ids then
			self._answer_task_data = arg_11_1.ids

			if var_0_5:getInstance("combat_result") then
				self._first_answer_task_id = arg_11_1.ids
			end

			if var_0_5:getInstance("battle") then
				self._first_answer_task_id = arg_11_1.ids
			end
		end
	end

	function arg_1_0:AnswerMaxScoreUpdate(arg_12_1)
		if arg_12_1 then
			self:set_answer_server_honor_list(arg_12_1)
		end
	end
end

function var_0_0.extend_obj(arg_13_0)
	arg_13_0._score_question_team = {}
end

return var_0_0
