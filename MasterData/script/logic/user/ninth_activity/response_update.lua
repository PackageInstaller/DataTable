local var_0_0 = {}
local var_0_2 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:NinthMaxScoreUpdate(arg_2_1)
		if arg_2_1 then
			self:set_server_honor_list(arg_2_1)
		end
	end

	function arg_1_0:NinthMaxScoreExtraUpdate(arg_3_1)
		if arg_3_1 then
			self:set_server_honor_list_extra(arg_3_1)
		end
	end

	function arg_1_0:NinthLevelPassUpdate(arg_4_1)
		if arg_4_1 and next(arg_4_1) then
			self:set_ninth_level_pass_num(arg_4_1.info)
		end
	end

	function arg_1_0:NinthLevelPassExtraUpdate(arg_5_1)
		if arg_5_1 and next(arg_5_1) then
			self:set_ninth_level_pass_num_extra(arg_5_1.info)
		end
	end

	function arg_1_0:NinthMapInfoUpdate(arg_6_1)
		if arg_6_1 and next(arg_6_1) then
			for iter_6_0, iter_6_1 in pairs(arg_6_1.updates) do
				self:__ninth_map_info_action(iter_6_1.info.id, iter_6_1.action, iter_6_1.info)
			end
		end
	end

	function arg_1_0:__ninth_map_info_action(arg_7_1, arg_7_2, arg_7_3)
		if arg_7_2 == var_0_2.update_modify then
			self:__ninth_map_info_update_info(arg_7_1, arg_7_3)
		elseif arg_7_2 == var_0_2.update_add then
			self:__ninth_map_info_add_info(arg_7_1, arg_7_3)
		elseif arg_7_2 == var_0_2.update_remove then
			self:__ninth_map_info_remove_info(arg_7_1, arg_7_3)
		end
	end

	function arg_1_0.NinthInfoUpdate(arg_8_0, arg_8_1)
		if arg_8_1 and next(arg_8_1) then
			arg_8_0._ninth_award_score = arg_8_1.info.score_point
			arg_8_0._ninth_buff_point = arg_8_1.info.buff_point
			arg_8_0._ninth_guide_state = arg_8_1.info.guide
		end
	end

	function arg_1_0:NinthBuffInfoNotify(arg_9_1)
		self:set_ninth_cia_buff_info(arg_9_1)
	end

	function arg_1_0.NinthTaskInfoUpdate(arg_10_0, arg_10_1)
		if arg_10_1 and next(arg_10_1) then
			arg_10_0._ninth_task_info = arg_10_1.ids
		end
	end

	function arg_1_0:NinthAwardInfoNotify(arg_11_1)
		if arg_11_1 and next(arg_11_1) then
			self:set_get_award_info(arg_11_1.ids)
		end
	end

	function arg_1_0.NinthServerTaskInfoUpdate(arg_12_0, arg_12_1)
		if arg_12_1 and next(arg_12_1) then
			arg_12_0._ninth_server_task_info = arg_12_1.ids
		end
	end
end

function var_0_0.extend_obj(arg_13_0)
	return
end

return var_0_0
