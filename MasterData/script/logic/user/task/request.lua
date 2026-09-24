local var_0_0 = {}
local var_0_5 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_committaskreq(arg_2_0, arg_2_1)
		var_0_5:sendMsg("user.CommitTaskReq", {
			task_id = arg_2_1
		})
	end

	function arg_1_0.req_commitTaskAllReq(arg_3_0)
		var_0_5:sendMsg("user.CommitTaskAllReq", {})
	end
end

function var_0_0.extend_obj(arg_4_0)
	return
end

return var_0_0
