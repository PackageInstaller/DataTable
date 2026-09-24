local var_0_0 = {}
local var_0_5 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_SolidEnterMapReq(arg_2_0, arg_2_1, arg_2_2)
		var_0_5:sendMsg("user.SolidEnterMapReq", {
			id = arg_2_1,
			choose = arg_2_2
		})
	end

	function arg_1_0.req_SolidGetAwardReq(arg_3_0, arg_3_1)
		var_0_5:sendMsg("user.SolidGetAwardReq", {
			id = arg_3_1
		})
	end

	function arg_1_0.req_SolidEnterPointReq(arg_4_0, arg_4_1)
		var_0_5:sendMsg("user.SolidEnterPointReq", {
			buffs = arg_4_1
		})
	end

	function arg_1_0.req_SolidSaveTeamReq(arg_5_0, arg_5_1)
		var_0_5:sendMsg("user.SolidSaveTeamReq", {
			members = arg_5_1
		})
	end

	function arg_1_0.req_SolidQuitMapReq(arg_6_0)
		var_0_5:sendMsg("user.SolidQuitMapReq", {})
	end

	function arg_1_0.req_SoildChooseBuffReq(arg_7_0, arg_7_1)
		var_0_5:sendMsg("user.SoildChooseBuffReq", {
			buffs = arg_7_1
		})
	end

	function arg_1_0.req_SolidExtendBuffStatusReq(arg_8_0, arg_8_1)
		var_0_5:sendMsg("user.SolidExtendBuffStatusReq", {
			extend_buff = arg_8_1
		})
	end

	function arg_1_0.req_SolidExtendBuffNumReq(arg_9_0)
		var_0_5:sendMsg("user.SolidExtendBuffNumReq", {})
	end

	function arg_1_0.req_SolidInitBattleDataReq(arg_10_0)
		var_0_5:sendMsg("user.SolidInitBattleDataReq", {})
	end

	function arg_1_0.req_SolidMaxScoreLevelPassReq(arg_11_0)
		var_0_5:sendMsg("user.SolidMaxScoreLevelPassReq", {})
	end
end

function var_0_0.extend_obj(arg_12_0)
	return
end

return var_0_0
