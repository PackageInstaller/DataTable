local var_0_0 = {}
local var_0_1 = gameenum.common_type
local var_0_2 = gamecore.util_func

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:ActivityTaskUpdate(arg_2_1)
		for iter_2_0, iter_2_1 in pairs(arg_2_1.updates) do
			self:__special_task_action(iter_2_1.action, iter_2_1.info)
		end
	end

	function arg_1_0:__special_task_action(arg_3_1, arg_3_2)
		if arg_3_1 == var_0_1.update_modify then
			self:__special_task_update_task_info(arg_3_2)
		elseif arg_3_1 == var_0_1.update_add then
			self:__special_task_update_task_info(arg_3_2)
		elseif arg_3_1 == var_0_1.update_remove then
			self:__special_task_remove_task_info(arg_3_2)
		end
	end

	function arg_1_0.PushInfoUpdate(arg_4_0, arg_4_1)
		local var_4_0 = var_0_2.little_clone(arg_4_1.info)

		if var_4_0 and next(var_4_0) then
			arg_4_0._push_guide = var_4_0.guide
			arg_4_0._push_info_coin = var_4_0.coin
			arg_4_0._push_buff_ids = var_4_0.using_buff
		end
	end

	function arg_1_0.PushBuffInfoUpdate(arg_5_0, arg_5_1)
		if arg_5_1 and next(arg_5_1) and arg_5_1 and arg_5_1.using_buff and next(arg_5_1.using_buff) then
			arg_5_0._push_buff_ids = arg_5_1.using_buff
		end
	end

	function arg_1_0:__push_buff_action(arg_6_1, arg_6_2)
		if arg_6_1 == var_0_1.update_modify then
			self:__push_buff_update_buff_info(arg_6_2)
		elseif arg_6_1 == var_0_1.update_add then
			self:__push_buff_add_buff_info(arg_6_2)
		elseif arg_6_1 == var_0_1.update_remove then
			self:__push_buff_remove_buff_info(arg_6_2)
		end
	end

	function arg_1_0:PushPointBuffUpdate(arg_7_1)
		for iter_7_0, iter_7_1 in pairs(arg_7_1.updates) do
			self:__special_push_random_buff_action(iter_7_1.action, iter_7_1.info)
		end
	end

	function arg_1_0:__special_push_random_buff_action(arg_8_1, arg_8_2)
		if arg_8_1 == var_0_1.update_modify then
			self:__special_push_update_random_buff_info(arg_8_2)
		elseif arg_8_1 == var_0_1.update_add then
			self:__special_push_add_random_buff_info(arg_8_2)
		elseif arg_8_1 == var_0_1.update_remove then
			self:__special_push_remove_random_buff_info(arg_8_2)
		end
	end

	function arg_1_0:PushTimeNotify(arg_9_1)
		self:set_random_buff_time(arg_9_1.refresh_last_time)
	end
end

function var_0_0.extend_obj(arg_10_0)
	return
end

return var_0_0
