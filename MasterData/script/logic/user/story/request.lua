local var_0_0 = {}
local var_0_1 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_UnlockShipStoryReq(arg_2_0, arg_2_1)
		var_0_1:sendMsg("user.UnlockShipStoryReq", {
			id = arg_2_1.id
		})
	end

	function arg_1_0.req_ReadStoryReq(arg_3_0, arg_3_1)
		var_0_1:sendMsg("user.ReadStoryReq", {
			id = arg_3_1.id
		})
	end

	function arg_1_0.req_UnlockStoryReq(arg_4_0, arg_4_1)
		var_0_1:sendMsg("user.UnlockStoryReq", {
			id = arg_4_1
		})
	end

	function arg_1_0.req_SaveCustomCoverReq(arg_5_0, arg_5_1)
		var_0_1:sendMsg("user.SaveCustomCoverReq", {
			ids = arg_5_1
		})
	end

	function arg_1_0.req_TokenUnlockStoryReq(arg_6_0, arg_6_1)
		var_0_1:sendMsg("user.TokenUnlockStoryReq", {
			id = arg_6_1
		})
	end
end

function var_0_0.extend_obj(arg_7_0)
	return
end

return var_0_0
