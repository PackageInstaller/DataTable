local var_0_0 = {}
local var_0_5 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_MistBuyTicketReq(arg_2_0, arg_2_1)
		var_0_5:sendMsg("user.MistBuyTicketReq", {
			type = arg_2_1
		})
	end

	function arg_1_0.req_MistChooseReq(arg_3_0, arg_3_1)
		var_0_5:sendMsg("user.MistChooseReq", {
			idx_array = arg_3_1
		})
	end

	function arg_1_0.req_EnterMistBigMapReq(arg_4_0, arg_4_1, arg_4_2)
		var_0_5:sendMsg("user.EnterMistBigMapReq", {
			id = arg_4_1,
			members = arg_4_2
		})
	end

	function arg_1_0.req_EnterMistMapReq(arg_5_0, arg_5_1)
		var_0_5:sendMsg("user.EnterMistMapReq", {
			id = arg_5_1
		})
	end

	function arg_1_0.req_MistPointCompleteReq(arg_6_0, arg_6_1, arg_6_2)
		var_0_5:sendMsg("user.MistPointCompleteReq", {
			battle_result = arg_6_1,
			battle_point = arg_6_2
		})
	end

	function arg_1_0.req_MistRefreshChooseReq(arg_7_0)
		var_0_5:sendMsg("user.MistRefreshChooseReq", {})
	end

	function arg_1_0.req_MistMoveReq(arg_8_0, arg_8_1)
		var_0_5:sendMsg("user.MistMoveReq", {
			point_id = arg_8_1
		})
	end

	function arg_1_0.req_MistEnterPointReq(arg_9_0)
		var_0_5:sendMsg("user.MistEnterPointReq", {})
	end

	function arg_1_0.req_MistTeamSaveReq(arg_10_0, arg_10_1)
		var_0_5:sendMsg("user.MistTeamSaveReq", {
			members = arg_10_1
		})
	end

	function arg_1_0.req_MistChangeAdjutantReq(arg_11_0, arg_11_1)
		var_0_5:sendMsg("user.MistChangeAdjutantReq", {
			id = arg_11_1
		})
	end

	function arg_1_0.req_MistBuyAdjutantExpReq(arg_12_0)
		var_0_5:sendMsg("user.MistBuyAdjutantExpReq", {})
	end

	function arg_1_0.req_EnterMistStoryReq(arg_13_0, arg_13_1, arg_13_2)
		var_0_5:sendMsg("user.EnterMistStoryReq", {
			point_id = arg_13_1,
			grade = arg_13_2
		})
	end

	function arg_1_0.req_MistCompleteMapReq(arg_14_0, arg_14_1, arg_14_2)
		var_0_5:sendMsg("user.MistCompleteMapReq", {
			battle_result = arg_14_1,
			battle_confirm = arg_14_2
		})
	end

	function arg_1_0.req_MistQuitMapReq(arg_15_0)
		var_0_5:sendMsg("user.MistQuitMapReq", {})
	end

	function arg_1_0.req_MistUseAdjutantSkillReq(arg_16_0)
		var_0_5:sendMsg("user.MistUseAdjutantSkillReq", {})
	end

	function arg_1_0.req_MistGuideReq(arg_17_0)
		var_0_5:sendMsg("user.MistGuideReq", {})
	end

	function arg_1_0.req_MistResetBigMapReq(arg_18_0, arg_18_1)
		var_0_5:sendMsg("user.MistResetBigMapReq", {
			id = arg_18_1
		})
	end

	function arg_1_0.req_MistGetAwardReq(arg_19_0, arg_19_1)
		var_0_5:sendMsg("user.MistGetAwardReq", {
			id = arg_19_1
		})
	end
end

function var_0_0.extend_obj(arg_20_0)
	return
end

return var_0_0
