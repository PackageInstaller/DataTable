local activity_conf_data = require("data.activity_conf_data")
local network = require("network.network")

function ACTIVITY_OBJ_NEW:get_activity_question_list(arg_1_1)
	network:rpc("get_activity_question_list", {
		activityid = self._id,
		arrayid = arg_1_1
	}, function(arg_2_0)
		if arg_2_0.result == 0 then
			global_ShowBlockWords(L_ACTIVITY_CLOSE)
		elseif arg_2_0.result == 2 then
			global_ShowBlockWords(L_ACTIVITY_OUT_OF_TIME)
		elseif arg_2_0.result == 3 then
			global_ShowBlockWords(L_ACTIVITY_NO_QUESTION)
		else
			local var_2_1 = require("data." .. activity_conf_data[self._id][(arg_1_1 ~= 1 or nil) and "questionfile" .. arg_1_1])

			if arg_2_0.questions then
				for iter_2_0, iter_2_1 in pairs(arg_2_0.questions) do
					arg_2_0.questions[iter_2_0].data = var_2_1[iter_2_1.id]
				end
			end

			local activity_manager = require("controller.activity_manager")

			activity_manager:fireEvent(activity_manager.activityEventId.QUSETION_LIST_UPDATE, arg_2_0)
		end
	end)
end

function ACTIVITY_OBJ_NEW:activity_answer_question(arg_3_1, arg_3_2)
	network:rpc("activity_answer_question", {
		activityid = self._id,
		questionid = arg_3_1,
		answerid = arg_3_2
	}, function(arg_4_0)
		if arg_4_0.result == 0 then
			global_ShowBlockWords(L_ACTIVITY_CLOSE)
		elseif arg_4_0.result == 2 then
			global_ShowBlockWords(L_ACTIVITY_OUT_OF_TIME)
		elseif arg_4_0.result == 3 then
			global_ShowBlockWords(L_ACTIVITY_NO_QUESTION)
		elseif arg_4_0.result == 4 then
			global_ShowBlockWords(L_ACTIVITY_QUESTION_TIME_OUT)
		elseif arg_4_0.result == 5 then
			global_ShowBlockWords(L_ACTIVITY_HAD_ANSWER)
		else
			global_gain(arg_4_0)

			local activity_manager = require("controller.activity_manager")

			activity_manager:fireEvent(activity_manager.activityEventId.ANSWER_QUSTION_SUCCESS, {
				para = arg_4_0
			})
		end
	end)
end
