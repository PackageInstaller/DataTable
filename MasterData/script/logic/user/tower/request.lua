local var_0_0 = {}
local var_0_5 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_TowerGetChipReq(arg_2_0, arg_2_1)
		var_0_5:sendMsg("user.TowerGetChipReq", {
			type = arg_2_1
		})
	end

	function arg_1_0.req_TowerGetRewardReq(arg_3_0, arg_3_1)
		var_0_5:sendMsg("user.TowerGetRewardReq", {
			level = arg_3_1
		})
	end

	function arg_1_0.req_TowerResetLevelReq(arg_4_0, arg_4_1)
		var_0_5:sendMsg("user.TowerResetLevelReq", {
			level = arg_4_1
		})
	end

	function arg_1_0.req_TowerEquipChipReq(arg_5_0, arg_5_1)
		var_0_5:sendMsg("user.TowerEquipChipReq", {
			pos = arg_5_1
		})
	end

	function arg_1_0.req_TowerDecomposeChipReq(arg_6_0, arg_6_1)
		var_0_5:sendMsg("user.TowerDecomposeChipReq", {
			pos = arg_6_1
		})
	end

	function arg_1_0.req_TowerTransientEquipReq(arg_7_0, arg_7_1, arg_7_2)
		var_0_5:sendMsg("user.TowerTransientEquipReq", {
			transient_pos = arg_7_1,
			pos = arg_7_2
		})
	end

	function arg_1_0.req_TowerChipAbandonReq(arg_8_0)
		var_0_5:sendMsg("user.TowerChipAbandonReq", {})
	end

	function arg_1_0.req_TowerChipInTransientReq(arg_9_0, arg_9_1)
		var_0_5:sendMsg("user.TowerChipInTransientReq", {
			pos = arg_9_1
		})
	end

	function arg_1_0.req_TowerBuyChipReq(arg_10_0, arg_10_1)
		var_0_5:sendMsg("user.TowerBuyChipReq", {
			id = arg_10_1
		})
	end

	function arg_1_0.req_EnterTowerReq(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
		var_0_5:sendMsg("user.EnterTowerReq", {
			team_id = arg_11_1,
			monster = arg_11_2,
			level = arg_11_3
		})
	end

	function arg_1_0.req_TowerGetNewReq(arg_12_0)
		var_0_5:sendMsg("user.TowerGetNewReq", {})
	end

	function arg_1_0.req_AnnouncementRefreshReq(arg_13_0)
		var_0_5:sendMsg("user.AnnouncementRefreshReq", {})
	end
end

function var_0_0.extend_obj(arg_14_0)
	return
end

return var_0_0
