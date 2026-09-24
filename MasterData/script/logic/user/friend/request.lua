local var_0_0 = {}
local var_0_5 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_addfriendreq(arg_2_0, arg_2_1)
		var_0_5:sendMsg("user.RequestAddFriendReq", {
			account_id = arg_2_1
		})
	end

	function arg_1_0.req_agreefriendreq(arg_3_0, arg_3_1)
		var_0_5:sendMsg("user.AddFriendReq", {
			account_id = arg_3_1
		})
	end

	function arg_1_0.req_removefriendreq(arg_4_0, arg_4_1)
		var_0_5:sendMsg("user.RemoveFriendRequestReq", {
			account_id = arg_4_1
		})
	end

	function arg_1_0.req_removeallfriendreq(arg_5_0, arg_5_1)
		var_0_5:sendMsg("user.RemoveAllFriendRequestReq", {})
	end

	function arg_1_0.req_removeallfriend(arg_6_0, arg_6_1)
		var_0_5:sendMsg("user.RemoveFriendReq", {
			account_id = arg_6_1
		})
	end

	function arg_1_0.req_getrecommendlist(arg_7_0, arg_7_1)
		var_0_5:sendMsg("user.GetRecommendListReq", {})
	end

	function arg_1_0.req_getrecommendreq(arg_8_0, arg_8_1)
		var_0_5:sendMsg("user.RecommendReq", {})
	end

	function arg_1_0.req_getneworoldfriendreq(arg_9_0, arg_9_1)
		var_0_5:sendMsg("user.CancelFriendStateReq", {})
	end

	function arg_1_0.req_topfriendstatereq(arg_10_0, arg_10_1)
		var_0_5:sendMsg("user.TopFriendStateReq", {
			account_id = arg_10_1
		})
	end
end

function var_0_0.extend_obj(arg_11_0)
	return
end

return var_0_0
