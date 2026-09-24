local var_0_0 = {}
local var_0_1 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_GetMail(arg_2_0, arg_2_1)
		var_0_1:sendMsg("user.GetMailReq", {
			id = arg_2_1.id
		})
	end

	function arg_1_0.req_GetAllMail(arg_3_0, arg_3_1)
		var_0_1:sendMsg("user.GetAllMailReq", {})
	end

	function arg_1_0.req_DeleteMail(arg_4_0, arg_4_1)
		var_0_1:sendMsg("user.DeleteMailReq", {
			id = arg_4_1.id
		})
	end

	function arg_1_0.req_DeleteAllMail(arg_5_0, arg_5_1)
		var_0_1:sendMsg("user.DeleteAllMailReq", {})
	end

	function arg_1_0.req_LockMail(arg_6_0, arg_6_1, arg_6_2)
		var_0_1:sendMsg("user.LockMailReq", {
			type = arg_6_2,
			id = arg_6_1
		})
	end
end

function var_0_0.extend_obj(arg_7_0)
	return
end

return var_0_0
