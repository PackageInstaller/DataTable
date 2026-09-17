local network = require("network.network")
local activity_conf_data = require("data.activity_conf_data")

function ACTIVITY_OBJ_NEW:getActivityTaskList(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	if not activity_conf_data[self._id].task then
		print("表里的task字段没配")

		if arg_1_2 then
			arg_1_2(0)
		end

		return
	end

	if self._status ~= ACTIVITY_ACTIVING then
		if arg_1_2 then
			arg_1_2(2)
		end

		return
	end

	network:rpc("get_activity_tasklist", {
		id = self._id,
		stage = arg_1_1,
		isautoget = arg_1_3,
		statkey = arg_1_4,
		dailyStat = arg_1_6,
		usemodule = arg_1_5
	}, function(arg_2_0)
		if arg_2_0.result == 1 then
			if arg_1_2 then
				arg_1_2(arg_2_0.result, arg_2_0)
			end
		elseif arg_1_2 then
			arg_1_2(arg_2_0.result)
		end
	end)
end

function ACTIVITY_OBJ_NEW:getTaskReward(arg_3_1, arg_3_2, arg_3_3)
	if not activity_conf_data[self._id].task then
		if arg_3_2 then
			arg_3_2(0)
		end

		return
	end

	if self._status ~= ACTIVITY_ACTIVING then
		if arg_3_2 then
			arg_3_2(2)
		end

		return
	end

	network:rpc("get_activity_task_award", {
		id = self._id,
		taskid = arg_3_1,
		show_type = arg_3_3
	}, function(arg_4_0)
		if arg_4_0.result == 1 then
			AnalyticManager.get_activity_task_award({
				activityid = self._id,
				taskid = arg_3_1
			})

			if arg_3_2 then
				arg_3_2(1, arg_4_0)
			end
		elseif arg_3_2 then
			arg_3_2(arg_4_0.result)
		end
	end)
end
