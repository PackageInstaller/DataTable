local var_0_0 = {}
local var_0_1 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_GuideStepReq(arg_2_0, arg_2_1)
		var_0_1:sendMsg("user.SaveGuideReq", {
			id_array = arg_2_1
		})
	end
end

function var_0_0.extend_obj(arg_3_0)
	return
end

return var_0_0
