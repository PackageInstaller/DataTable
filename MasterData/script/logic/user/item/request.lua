local var_0_0 = {}
local var_0_5 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_ConsumeItemReq(arg_2_0, arg_2_1, arg_2_2)
		var_0_5:sendMsg("user.ConsumeItemReq", {
			id = arg_2_1,
			count = arg_2_2
		})
	end
end

function var_0_0.extend_obj(arg_3_0)
	return
end

return var_0_0
