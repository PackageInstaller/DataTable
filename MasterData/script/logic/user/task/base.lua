local var_0_0 = {}
local var_0_1 = table.insert
local var_0_2 = gameconfig.task_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.reset_task_data(arg_2_0)
		arg_2_0._task_data = {}
	end

	function arg_1_0:find_task_by_id(arg_3_1)
		return self:__task__find_by_id(arg_3_1)
	end

	function arg_1_0:get_task_list()
		return self._task_data
	end

	function arg_1_0:get_task_reward_num()
		local var_5_0 = 0

		for iter_5_0, iter_5_1 in pairs(self._task_data) do
			if iter_5_1.state ~= 2 and iter_5_1.progresses[1].counter * 100 / var_0_2.find_object_by_cid(iter_5_1.id).condition[2] >= 100 then
				var_5_0 = var_5_0 + 1
			end
		end

		return var_5_0
	end

	function arg_1_0:find_task_state_info(arg_6_1)
		self.__task_state_info(arg_6_1)
	end

	function arg_1_0:find_task_progresses_list(arg_7_1)
		return self.__task_progresses_list[arg_7_1.id]
	end

	function arg_1_0:find_task_state(arg_8_1)
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in pairs(self._task_data) do
			var_0_1(var_8_0, iter_8_1)
		end

		for iter_8_2 = 1, #var_8_0 do
			if arg_8_1 == var_8_0[iter_8_2].id then
				return var_8_0[iter_8_2].state
			end
		end
	end

	function arg_1_0:find_task_node_id(arg_9_1)
		return self.__task_node_id(arg_9_1)
	end

	function arg_1_0:__task__add_task_info(arg_10_1)
		self._task_data[arg_10_1.id] = arg_10_1
	end

	function arg_1_0:__task__update_task_info(arg_11_1)
		self._task_data[arg_11_1.id] = arg_11_1
	end

	function arg_1_0:__task__remove_task_info(arg_12_1)
		self._task_data[arg_12_1.id] = nil
	end

	function arg_1_0:__task__find_by_id(arg_13_1)
		return self._task_data[arg_13_1]
	end

	function arg_1_0:__get_limit_time()
		local var_14_0 = {}

		for iter_14_0, iter_14_1 in pairs(self._task_data) do
			local var_14_1 = var_0_2.find_object_by_cid(iter_14_1.id)
			local var_14_2 = lx.ServerTime:getUtcTime()

			if var_14_1 and var_14_1.type == 4 and iter_14_1.state == 1 and var_14_2 > var_14_1.start_utc_time and var_14_2 < var_14_1.end_utc_time then
				table.insert(var_14_0, var_14_1.end_utc_time)
			end
		end

		table.sort(var_14_0, function(arg_15_0, arg_15_1)
			return arg_15_0 < arg_15_1
		end)

		return var_14_0[1] or 0
	end
end

function var_0_0.extend_obj(arg_16_0)
	arg_16_0._task_data = {}
end

return var_0_0
