local var_0_0 = {}
local var_0_1 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_AnswerBuyReq(arg_2_0, arg_2_1)
		var_0_1:sendMsg("user.AnswerBuyReq", {
			id = arg_2_1
		})
	end

	function arg_1_0.req_AnswerResetBuyReq(arg_3_0)
		var_0_1:sendMsg("user.AnswerResetBuyReq", {})
	end

	function arg_1_0.req_AnswerQuestionReq(arg_4_0, arg_4_1, arg_4_2)
		var_0_1:sendMsg("user.AnswerQuestionReq", {
			pos = arg_4_1,
			answer = arg_4_2
		})
	end

	function arg_1_0.req_AnswerEnterMapReq(arg_5_0, arg_5_1)
		var_0_1:sendMsg("user.AnswerEnterMapReq", {
			id = arg_5_1.id,
			start_point = arg_5_1.start_point,
			team_id = arg_5_1.team_id
		})
	end

	function arg_1_0.req_AnswerMoveMapReq(arg_6_0, arg_6_1)
		var_0_1:sendMsg("user.AnswerMoveMapReq", {
			point = arg_6_1
		})
	end

	function arg_1_0.req_AnswerGetAwardReq(arg_7_0, arg_7_1)
		var_0_1:sendMsg("user.AnswerGetAwardReq", {
			id = arg_7_1
		})
	end

	function arg_1_0.req_AnswerQuitMapReq(arg_8_0)
		var_0_1:sendMsg("user.AnswerQuitMapReq", {})
	end

	function arg_1_0.req_AnswerRemindReq(arg_9_0)
		var_0_1:sendMsg("user.AnswerRemindReq", {})
	end

	function arg_1_0.req_AnswerGuideReq(arg_10_0)
		var_0_1:sendMsg("user.AnswerGuideReq", {})
	end

	function arg_1_0.req_AnswerMaxScoreLevelPassReq(arg_11_0)
		var_0_1:sendMsg("user.AnswerMaxScoreLevelPassReq", {})
	end
end

function var_0_0.extend_obj(arg_12_0)
	return
end

return var_0_0
