local var_0_0 = {}
local var_0_5 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_sixthBuyTicketReq(arg_2_0, arg_2_1)
		var_0_5:sendMsg("user.SixthBuyTicketReq", {
			type = arg_2_1
		})
	end

	function arg_1_0.req_SixthChooseReq(arg_3_0, arg_3_1)
		var_0_5:sendMsg("user.SixthChooseReq", {
			idx_array = arg_3_1
		})
	end

	function arg_1_0.req_EnterSixthMapReq(arg_4_0, arg_4_1)
		var_0_5:sendMsg("user.EnterSixthMapReq", {
			id = arg_4_1
		})
	end

	function arg_1_0.req_SixthRefreshChooseReq(arg_5_0)
		var_0_5:sendMsg("user.SixthRefreshChooseReq", {})
	end

	function arg_1_0.req_SixthMoveReq(arg_6_0, arg_6_1)
		var_0_5:sendMsg("user.SixthMoveReq", {
			point_id = arg_6_1
		})
	end

	function arg_1_0.req_SixthEnterPointReq(arg_7_0)
		var_0_5:sendMsg("user.SixthEnterPointReq", {})
	end

	function arg_1_0.req_SixthTeamSaveReq(arg_8_0, arg_8_1)
		var_0_5:sendMsg("user.SixthTeamSaveReq", {
			members = arg_8_1
		})
	end

	function arg_1_0.req_SixthChangeAdjutantReq(arg_9_0, arg_9_1)
		var_0_5:sendMsg("user.SixthChangeAdjutantReq", {
			id = arg_9_1
		})
	end

	function arg_1_0.req_SixthBuyAdjutantExpReq(arg_10_0)
		var_0_5:sendMsg("user.SixthBuyAdjutantExpReq", {})
	end

	function arg_1_0.req_EnterSixthStoryReq(arg_11_0, arg_11_1, arg_11_2)
		var_0_5:sendMsg("user.EnterSixthStoryReq", {
			point_id = arg_11_1,
			grade = arg_11_2
		})
	end

	function arg_1_0.req_SixthCompleteMapReq(arg_12_0)
		var_0_5:sendMsg("user.SixthCompleteMapReq", {})
	end

	function arg_1_0.req_SixthQuitMapReq(arg_13_0)
		var_0_5:sendMsg("user.SixthQuitMapReq", {})
	end

	function arg_1_0.req_SixthUseAdjutantSkillReq(arg_14_0)
		var_0_5:sendMsg("user.SixthUseAdjutantSkillReq", {})
	end

	function arg_1_0.req_SixthShopBuyReq(arg_15_0, arg_15_1)
		var_0_5:sendMsg("user.SixthShopBuyReq", {
			id = arg_15_1
		})
	end

	function arg_1_0.req_MultiSixthShopBuyReq(arg_16_0, arg_16_1)
		var_0_5:sendMsg("user.MultiSixthShopBuyReq", {
			id = arg_16_1.id,
			num = arg_16_1.count
		})
	end

	function arg_1_0.req_SixthCompleteGuideReq(arg_17_0)
		var_0_5:sendMsg("user.SixthGuideReq", {})
	end

	function arg_1_0.req_SixthResetBigMapReq(arg_18_0, arg_18_1)
		var_0_5:sendMsg("user.SixthResetBigMapReq", {
			id = arg_18_1
		})
	end

	function arg_1_0.req_SixthDecisiveBattleBuffReq(arg_19_0, arg_19_1)
		var_0_5:sendMsg("user.SixthDecisiveBattleBuffReq", {
			chapter_buff_id = arg_19_1
		})
	end

	function arg_1_0.req_SixthQuitBigMapReq(arg_20_0, arg_20_1)
		var_0_5:sendMsg("user.SixthQuitBigMapReq", {})
	end
end

function var_0_0.extend_obj(arg_21_0)
	return
end

return var_0_0
