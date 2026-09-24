local var_0_0 = {}
local var_0_5 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_EighthEnterMapReq(arg_2_0, arg_2_1, arg_2_2)
		var_0_5:sendMsg("user.EighthEnterMapReq", {
			id = arg_2_1,
			team_id = arg_2_2
		})
	end

	function arg_1_0.req_EighthQuitMapReq(arg_3_0, arg_3_1, arg_3_2)
		var_0_5:sendMsg("user.EighthQuitMapReq", {})
	end

	function arg_1_0.req_EighthMapMoveReq(arg_4_0, arg_4_1)
		var_0_5:sendMsg("user.EighthMapMoveReq", {
			point = arg_4_1
		})
	end

	function arg_1_0.req_EighthBigMapMoveReq(arg_5_0, arg_5_1, arg_5_2)
		var_0_5:sendMsg("user.EighthBigMapMoveReq", {
			id = arg_5_1,
			pos = arg_5_2
		})
	end

	function arg_1_0.req_EighthEnemyMoveReq(arg_6_0, arg_6_1, arg_6_2)
		var_0_5:sendMsg("user.EighthEnemyMoveReq", {
			id = arg_6_1,
			chase = arg_6_2
		})
	end

	function arg_1_0.req_EighthEnterEliteReq(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
		var_0_5:sendMsg("user.EighthEnterEliteReq", {
			id = arg_7_1,
			elite_id = arg_7_2,
			team_id = arg_7_3
		})
	end

	function arg_1_0.req_EighthEnterChaseReq(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		var_0_5:sendMsg("user.EighthEnterChaseReq", {
			id = arg_8_1,
			pos = arg_8_2,
			team_id = arg_8_3
		})
	end

	function arg_1_0.req_EighthUpgradeBuffReq(arg_9_0, arg_9_1)
		var_0_5:sendMsg("user.EighthUpgradeBuffReq", {
			buff_id = arg_9_1
		})
	end

	function arg_1_0.req_EighthResetBuffReq(arg_10_0)
		var_0_5:sendMsg("user.EighthResetBuffReq", {})
	end

	function arg_1_0.req_EighthGuideReq(arg_11_0)
		var_0_5:sendMsg("user.EighthGuideReq", {})
	end

	function arg_1_0.req_EighthSetSupPosReq(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
		var_0_5:sendMsg("user.EighthSetSupPosReq", {
			map_id = arg_12_1,
			sup_pos = arg_12_2,
			action = arg_12_3
		})
	end

	function arg_1_0.req_EighthEliteMoveReq(arg_13_0, arg_13_1, arg_13_2)
		var_0_5:sendMsg("user.EighthEliteMoveReq", {
			map_id = arg_13_1,
			info = arg_13_2
		})
	end
end

function var_0_0.extend_obj(arg_14_0)
	return
end

return var_0_0
