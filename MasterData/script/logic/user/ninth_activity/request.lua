local var_0_0 = {}
local var_0_5 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_NinthBuyReq(arg_2_0, arg_2_1)
		var_0_5:sendMsg("user.NinthBuyReq", {
			id = arg_2_1
		})
	end

	function arg_1_0.req_NinthResetBuyReq(arg_3_0)
		var_0_5:sendMsg("user.NinthResetBuyReq", {})
	end

	function arg_1_0.req_NinthGetAwardReq(arg_4_0, arg_4_1)
		var_0_5:sendMsg("user.NinthGetAwardReq", {
			id = arg_4_1
		})
	end

	function arg_1_0.req_NinthRemindReq(arg_5_0)
		return
	end

	function arg_1_0.req_NinthGuideReq(arg_6_0)
		var_0_5:sendMsg("user.NinthGuideReq", {})
	end

	function arg_1_0.req_NinthEnterMapReq(arg_7_0, arg_7_1)
		var_0_5:sendMsg("user.NinthEnterMapReq", {
			id = arg_7_1.id,
			team_id = arg_7_1.team_id,
			start_point = arg_7_1.start_point
		})
	end

	function arg_1_0.req_NinthMapMoveReq(arg_8_0, arg_8_1)
		var_0_5:sendMsg("user.NinthMapMoveReq", {
			point = arg_8_1
		})
	end

	function arg_1_0.req_NinthQuitMapReq(arg_9_0)
		var_0_5:sendMsg("user.NinthQuitMapReq", {})
	end

	function arg_1_0.req_NinthMaxScoreLevelPassReq(arg_10_0)
		var_0_5:sendMsg("user.NinthMaxScoreLevelPassReq", {})
	end
end

function var_0_0.extend_obj(arg_11_0)
	return
end

return var_0_0
