local var_0_0 = {}
local var_0_5 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_RecreationTeamSaveReq(arg_2_0, arg_2_1)
		var_0_5:sendMsg("user.RecreationTeamSaveReq", {
			member = arg_2_1
		})
	end

	function arg_1_0.req_RecreationEnterMapReq(arg_3_0, arg_3_1)
		var_0_5:sendMsg("user.RecreationEnterMapReq", {
			id = arg_3_1
		})
	end

	function arg_1_0.req_ConcertoEnterMapReq(arg_4_0, arg_4_1, arg_4_2)
		arg_4_0._enter_battle_id = arg_4_1

		var_0_5:sendMsg("user.ConcertoEnterMapReq", {
			id = arg_4_1,
			team_id = arg_4_2
		})
	end

	function arg_1_0.req_ConcertoMapMoveReq(arg_5_0, arg_5_1)
		var_0_5:sendMsg("user.ConcertoMapMoveReq", {
			point = arg_5_1
		})
	end

	function arg_1_0.req_RecreationMoveMapReq(arg_6_0, arg_6_1)
		var_0_5:sendMsg("user.RecreationMoveMapReq", {
			point = arg_6_1
		})
	end

	function arg_1_0.req_ConcertoStationReq(arg_7_0, arg_7_1, arg_7_2)
		arg_7_0._station_node = arg_7_1

		var_0_5:sendMsg("user.ConcertoStationReq", {
			id = arg_7_1,
			team = arg_7_2
		})
	end

	function arg_1_0.req_ConcertoStationExitReq(arg_8_0, arg_8_1)
		var_0_5:sendMsg("user.ConcertoStationExitReq", {
			team = arg_8_1
		})
	end

	function arg_1_0.req_ConcertoGetRewardReq(arg_9_0, arg_9_1)
		var_0_5:sendMsg("user.ConcertoGetRewardReq", {
			id = arg_9_1
		})
	end

	function arg_1_0.req_RecreationShopBuyReq(arg_10_0, arg_10_1)
		var_0_5:sendMsg("user.RecreationShopBuyReq", {
			id = arg_10_1
		})
	end

	function arg_1_0.req_ConcertoReadReq(arg_11_0, arg_11_1)
		var_0_5:sendMsg("user.ConcertoReadReq", {
			id = arg_11_1
		})
	end
end

function var_0_0.extend_obj(arg_12_0)
	return
end

return var_0_0
