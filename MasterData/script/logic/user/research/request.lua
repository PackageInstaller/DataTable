local var_0_0 = {}
local var_0_2 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_ResearchTaskSubmitReq(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		var_0_2:sendMsg("user.ResearchTaskSubmitReq", {
			research_id = arg_2_1,
			task_id = arg_2_2,
			task_info = arg_2_3
		})
	end

	function arg_1_0.req_GetResearchShipRewardReq(arg_3_0, arg_3_1)
		var_0_2:sendMsg("user.GetResearchShipRewardReq", {
			ship_id = arg_3_1
		})
	end

	function arg_1_0.req_ResearchEquipSubmitReq(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		var_0_2:sendMsg("user.ResearchEquipSubmitReq", {
			research_id = arg_4_1,
			task_id = arg_4_2,
			task_info = arg_4_3
		})
	end

	function arg_1_0.req_GetResearchEquipRewardReq(arg_5_0, arg_5_1)
		var_0_2:sendMsg("user.GetResearchEquipRewardReq", {
			equip_id = arg_5_1
		})
	end

	function arg_1_0.req_ResearchBoatIdReq(arg_6_0, arg_6_1)
		var_0_2:sendMsg("user.ResearchBoatIdReq", {
			research_id = arg_6_1
		})
	end
end

function var_0_0.extend_obj(arg_7_0)
	return
end

return var_0_0
