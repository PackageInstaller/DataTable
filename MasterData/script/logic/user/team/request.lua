local var_0_0 = {}
local var_0_1 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_TeamSave(arg_2_0, arg_2_1)
		var_0_1:sendMsg("user.TeamSaveReq", arg_2_1)
	end

	function arg_1_0.req_TeamRename(arg_3_0, arg_3_1)
		var_0_1:sendMsg("user.TeamRenameReq", arg_3_1)
	end

	function arg_1_0.req_CampaignTeamSaveReq(arg_4_0, arg_4_1)
		var_0_1:sendMsg("user.CampaignTeamSaveReq", arg_4_1)
	end

	function arg_1_0.req_EnterCampaignReq(arg_5_0, arg_5_1)
		var_0_1:sendMsg("user.EnterCampaignReq", arg_5_1)
	end

	function arg_1_0.req_RefreshCampaignReq(arg_6_0, arg_6_1)
		var_0_1:sendMsg("user.RefreshCampaignReq", {})
	end

	function arg_1_0.req_EnterSixthBigMapReq(arg_7_0, arg_7_1, arg_7_2)
		var_0_1:sendMsg("user.EnterSixthBigMapReq", {
			id = arg_7_1,
			members = arg_7_2
		})
	end

	function arg_1_0.req_SixthQuitMapReq(arg_8_0)
		var_0_1:sendMsg("user.SixthQuitMapReq", {})
	end

	function arg_1_0.req_TeamExchangeReq(arg_9_0, arg_9_1, arg_9_2)
		var_0_1:sendMsg("user.TeamExchangeReq", {
			id1 = arg_9_1,
			id2 = arg_9_2
		})
	end

	function arg_1_0.req_BVRAttackChangeReq(arg_10_0, arg_10_1)
		var_0_1:sendMsg("user.BVRAttackChangeReq", {
			state = arg_10_1
		})
	end
end

function var_0_0.extend_obj(arg_11_0)
	return
end

return var_0_0
