local var_0_0 = {}
local var_0_1 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_EnterMapReq(arg_2_0, arg_2_1)
		var_0_1:sendMsg("user.EnterMapReq", {
			id = arg_2_1.id,
			team_id = arg_2_1.team_id,
			start_point = arg_2_1.start_point
		})
	end

	function arg_1_0.req_MapMoveReq(arg_3_0, arg_3_1)
		var_0_1:sendMsg("user.MapMoveReq", {
			point = arg_3_1
		})
	end

	function arg_1_0.req_RoundAboutReq(arg_4_0, arg_4_1)
		var_0_1:sendMsg("user.RoundAboutReq", {
			result = arg_4_1
		})
	end

	function arg_1_0.req_ExpeditionStartReq(arg_5_0, arg_5_1)
		var_0_1:sendMsg("user.ExpeditionStartReq", {
			team_id = arg_5_1.team_id,
			id = arg_5_1.id
		})
	end

	function arg_1_0.req_ExpeditionStopReq(arg_6_0, arg_6_1)
		var_0_1:sendMsg("user.ExpeditionStopReq", {
			id = arg_6_1
		})
	end

	function arg_1_0.req_ExpeditionFinishReq(arg_7_0, arg_7_1)
		var_0_1:sendMsg("user.ExpeditionFinishReq", {
			id = arg_7_1
		})
	end

	function arg_1_0.req_ActiveShellingReq(arg_8_0, arg_8_1)
		var_0_1:sendMsg("user.ActiveShellingReq", {
			id = arg_8_1
		})
	end

	function arg_1_0.req_EnterManeuverReq(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
		var_0_1:sendMsg("user.EnterManeuverReq", {
			id = arg_9_1,
			team_id = arg_9_2,
			is_friend = arg_9_3
		})
	end

	function arg_1_0.req_RefreshRivalReq(arg_10_0, arg_10_1)
		var_0_1:sendMsg("user.RefreshRivalReq", {
			id = arg_10_1
		})
	end

	function arg_1_0.req_CompleteNodeHideReq(arg_11_0, arg_11_1)
		var_0_1:sendMsg("user.CompleteNodeHideReq", {
			info = arg_11_1
		})
	end

	function arg_1_0.req_CompleteNodeMissReq(arg_12_0, arg_12_1)
		var_0_1:sendMsg("user.CompleteNodeMissReq", {
			info = arg_12_1
		})
	end

	function arg_1_0.req_StationPointReq(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
		var_0_1:sendMsg("user.StationPointReq", {
			id = arg_13_1,
			team_id = arg_13_2,
			battle_type = arg_13_3
		})
	end

	function arg_1_0.req_StationPointExitReq(arg_14_0, arg_14_1)
		var_0_1:sendMsg("user.StationPointExitReq", {
			id = arg_14_1
		})
	end
end

function var_0_0.extend_obj(arg_15_0)
	return
end

return var_0_0
