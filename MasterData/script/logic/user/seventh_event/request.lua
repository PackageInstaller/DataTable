local var_0_0 = {}
local var_0_5 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_SeventhEnterMapReq(arg_2_0, arg_2_1, arg_2_2)
		var_0_5:sendMsg("user.SeventhEnterMapReq", {
			id = arg_2_1,
			team_id = arg_2_2
		})
	end

	function arg_1_0.req_SeventhQuitMapReq(arg_3_0)
		var_0_5:sendMsg("user.SeventhQuitMapReq", {})
	end

	function arg_1_0.req_SeventhMapMoveReq(arg_4_0, arg_4_1)
		var_0_5:sendMsg("user.SeventhMapMoveReq", {
			point = arg_4_1
		})
	end

	function arg_1_0.req_SeventhBigMapMoveReq(arg_5_0, arg_5_1, arg_5_2)
		var_0_5:sendMsg("user.SeventhBigMapMoveReq", {
			id = arg_5_1,
			pos = arg_5_2
		})
	end

	function arg_1_0.req_SeventhEnterEliteReq(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		var_0_5:sendMsg("user.SeventhEnterEliteReq", {
			id = arg_6_1,
			pos = arg_6_2,
			team_id = arg_6_3
		})
	end

	function arg_1_0.req_SeventhEnterChaseReq(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
		var_0_5:sendMsg("user.SeventhEnterChaseReq", {
			id = arg_7_1,
			pos = arg_7_2,
			team_id = arg_7_3
		})
	end

	function arg_1_0.req_SeventhUpgradeBuffReq(arg_8_0, arg_8_1)
		var_0_5:sendMsg("user.SeventhUpgradeBuffReq", {
			buff_id = arg_8_1
		})
	end

	function arg_1_0.req_SeventhResetBuffReq(arg_9_0)
		var_0_5:sendMsg("user.SeventhResetBuffReq", {})
	end

	function arg_1_0.req_SeventhGuideReq(arg_10_0)
		var_0_5:sendMsg("user.SeventhGuideReq", {})
	end

	function arg_1_0.req_SeventhTreasureGetAwardReq(arg_11_0, arg_11_1)
		var_0_5:sendMsg("user.SeventhTreasureGetAwardReq", {
			id = arg_11_1
		})
	end
end

function var_0_0.extend_obj(arg_12_0)
	return
end

return var_0_0
