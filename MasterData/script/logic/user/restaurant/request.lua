local var_0_0 = {}
local var_0_1 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_SetCookStyleReq(arg_2_0, arg_2_1)
		var_0_1:sendMsg("user.SetCookStyleReq", {
			id = arg_2_1
		})
	end

	function arg_1_0.req_SetCookBookReq(arg_3_0, arg_3_1)
		var_0_1:sendMsg("user.SetCookBookReq", {
			id = arg_3_1
		})
	end

	function arg_1_0.req_RemoveCookBookReq(arg_4_0, arg_4_1)
		var_0_1:sendMsg("user.RemoveCookBookReq", {
			id = arg_4_1
		})
	end

	function arg_1_0.req_SetChefReq(arg_5_0, arg_5_1)
		var_0_1:sendMsg("user.SetChefReq", {
			id = arg_5_1
		})
	end

	function arg_1_0.req_UseCookBookReq(arg_6_0, arg_6_1)
		var_0_1:sendMsg("user.UseCookBookReq", {
			id = arg_6_1
		})
	end

	function arg_1_0.req_UseFriendCookBookReq(arg_7_0, arg_7_1)
		var_0_1:sendMsg("user.UseFriendCookBookReq", {
			id = arg_7_1.id,
			account_id = arg_7_1.account_id
		})
	end
end

function var_0_0.extend_obj(arg_8_0)
	return
end

return var_0_0
