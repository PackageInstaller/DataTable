local var_0_0 = {}
local var_0_1 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_AbyssSaveTeamReq(arg_2_0, arg_2_1)
		var_0_1:sendMsg("user.AbyssSaveTeamReq", {
			members = arg_2_1
		})
	end

	function arg_1_0.req_AbyssAbyssSaveTeamReq(arg_3_0, arg_3_1)
		var_0_1:sendMsg("user.AbyssAbyssSaveTeamReq", {
			members = arg_3_1
		})
	end

	function arg_1_0.req_AbyssCombineReq(arg_4_0, arg_4_1)
		var_0_1:sendMsg("user.AbyssCombineReq", {
			id_1 = arg_4_1.id_1,
			id_2 = arg_4_1.id_2
		})
	end

	function arg_1_0.req_AbyssEvoReq(arg_5_0, arg_5_1)
		var_0_1:sendMsg("user.AbyssEvoReq", {
			id = arg_5_1.id
		})
	end

	function arg_1_0.req_AbyssChooseBuffReq(arg_6_0, arg_6_1)
		var_0_1:sendMsg("user.AbyssChooseBuffReq", {
			id = arg_6_1
		})
	end

	function arg_1_0.req_AbyssEnterMapReq(arg_7_0, arg_7_1)
		var_0_1:sendMsg("user.AbyssEnterMapReq", {
			id = arg_7_1.id
		})
	end

	function arg_1_0.req_AbyssMoveMapReq(arg_8_0, arg_8_1)
		var_0_1:sendMsg("user.AbyssMoveMapReq", {
			point = arg_8_1.point,
			team = arg_8_1.team
		})
	end

	function arg_1_0.req_AbyssQuitMapReq(arg_9_0)
		var_0_1:sendMsg("user.AbyssQuitMapReq", {})
	end

	function arg_1_0.req_AbyssGetAwardReq(arg_10_0, arg_10_1)
		var_0_1:sendMsg("user.AbyssGetAwardReq", {
			id = arg_10_1
		})
	end

	function arg_1_0.req_AbyssBossInfoReq(arg_11_0, arg_11_1)
		var_0_1:sendMsg("user.AbyssBossInfoReq", {
			id = arg_11_1
		})
	end

	function arg_1_0.req_AbyssGuideReq(arg_12_0)
		var_0_1:sendMsg("user.AbyssGuideReq", {})
	end

	function arg_1_0.req_AbyssAwardBoxReq(arg_13_0, arg_13_1)
		var_0_1:sendMsg("user.AbyssAwardBoxReq", {
			id = arg_13_1
		})
	end
end

function var_0_0.extend_obj(arg_14_0)
	return
end

return var_0_0
