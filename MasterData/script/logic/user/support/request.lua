local var_0_0 = {}
local var_0_5 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_changeranksupportreq(arg_2_0, arg_2_1)
		var_0_5:sendMsg("user.ChangeRankSupportReq", {
			id = arg_2_1
		})
	end

	function arg_1_0.req_supportLevelUpReq(arg_3_0, arg_3_1)
		var_0_5:sendMsg("user.SupportLevelUpReq", {
			id = arg_3_1
		})
	end

	function arg_1_0.req_ReadRankSupportReq(arg_4_0, arg_4_1)
		var_0_5:sendMsg("user.ReadRankSupportReq", {
			id = arg_4_1
		})
	end

	function arg_1_0.req_ActiveRankSupportReq(arg_5_0)
		var_0_5:sendMsg("user.ActiveRankSupportReq", {})
	end

	function arg_1_0.req_SupportSupplyReq(arg_6_0, arg_6_1)
		var_0_5:sendMsg("user.SupportSupplyReq", {
			id = arg_6_1
		})
	end
end

function var_0_0.extend_obj(arg_7_0)
	return
end

return var_0_0
