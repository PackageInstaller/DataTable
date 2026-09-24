local var_0_0 = {}
local var_0_5 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_OceanSaveTeamReq(arg_2_0, arg_2_1)
		var_0_5:sendMsg("user.OceanSaveTeamReq", {
			members = arg_2_1
		})
	end

	function arg_1_0.req_OceanBuyReq(arg_3_0, arg_3_1)
		var_0_5:sendMsg("user.OceanBuyReq", {
			id = arg_3_1
		})
	end

	function arg_1_0.req_OceanResetBuyReq(arg_4_0, arg_4_1)
		var_0_5:sendMsg("user.OceanResetBuyReq", {
			bool = arg_4_1
		})
	end

	function arg_1_0.req_OceanEnterMapReq(arg_5_0, arg_5_1, arg_5_2)
		var_0_5:sendMsg("user.OceanEnterMapReq", {
			id = arg_5_1,
			start_point = arg_5_2
		})
	end

	function arg_1_0.req_OceanMoveMapReq(arg_6_0, arg_6_1)
		var_0_5:sendMsg("user.OceanMoveMapReq", {
			point = arg_6_1
		})
	end

	function arg_1_0.req_OceanQuitMapReq(arg_7_0)
		var_0_5:sendMsg("user.OceanQuitMapReq", {})
	end
end

function var_0_0.extend_obj(arg_8_0)
	return
end

return var_0_0
