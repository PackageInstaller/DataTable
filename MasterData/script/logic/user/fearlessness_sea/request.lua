local var_0_0 = {}
local var_0_5 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_PushEnterMapReq(arg_2_0, arg_2_1)
		var_0_5:sendMsg("user.PushEnterMapReq", {
			id = arg_2_1.id,
			team_id = arg_2_1.team_id
		})
	end

	function arg_1_0.req_PushQuitMapReq(arg_3_0)
		var_0_5:sendMsg("user.PushQuitMapReq", {})
	end

	function arg_1_0.req_PushMapMoveReq(arg_4_0, arg_4_1)
		var_0_5:sendMsg("user.PushMapMoveReq", {
			point = arg_4_1
		})
	end

	function arg_1_0.req_PushChooseBuffReq(arg_5_0, arg_5_1)
		var_0_5:sendMsg("user.PushChooseBuffReq", {
			point_id = arg_5_1.point_id,
			buff_id = arg_5_1.buff_id
		})
	end

	function arg_1_0.req_PushBuyBuffReq(arg_6_0, arg_6_1)
		var_0_5:sendMsg("user.PushBuyBuffReq", {
			buff_id = arg_6_1
		})
	end

	function arg_1_0.req_PushRemoveBuffReq(arg_7_0, arg_7_1)
		var_0_5:sendMsg("user.PushRemoveBuffReq", {
			buff_id = arg_7_1.buff_id,
			hard = arg_7_1.hard
		})
	end

	function arg_1_0.req_PushAddBuffReq(arg_8_0, arg_8_1)
		var_0_5:sendMsg("user.PushAddBuffReq", {
			buff_id = arg_8_1.buff_id,
			hard = arg_8_1.hard
		})
	end

	function arg_1_0.req_PushActivityGetInReq(arg_9_0)
		var_0_5:sendMsg("user.PushActivityGetInReq", {})
	end

	function arg_1_0.req_PushActivityRefreshReq(arg_10_0)
		var_0_5:sendMsg("user.PushActivityRefreshReq", {})
	end

	function arg_1_0.req_PushGuideReq(arg_11_0)
		var_0_5:sendMsg("user.PushGuideReq", {})
	end

	function arg_1_0.req_PushResetBuffReq(arg_12_0)
		var_0_5:sendMsg("user.PushResetBuffReq", {})
	end
end

function var_0_0.extend_obj(arg_13_0)
	return
end

return var_0_0
