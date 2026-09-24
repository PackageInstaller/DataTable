local var_0_0 = {}
local var_0_5 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_spoilsbuyReq(arg_2_0, arg_2_1)
		var_0_5:sendMsg("user.SpoilsBuyReq", {
			id = arg_2_1
		})
	end

	function arg_1_0.req_MultiSpoilsBuyReq(arg_3_0, arg_3_1, arg_3_2)
		var_0_5:sendMsg("user.MultiSpoilsBuyReq", {
			id = arg_3_1,
			num = arg_3_2
		})
	end
end

function var_0_0.extend_obj(arg_4_0)
	return
end

return var_0_0
