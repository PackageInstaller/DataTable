local var_0_0 = {}
local var_0_1 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_ChangeMusicReq(arg_2_0, arg_2_1)
		var_0_1:sendMsg("user.ChangeMusicReq", {
			id = arg_2_1
		})
	end

	function arg_1_0.req_LeaderboardReq(arg_3_0, arg_3_1, arg_3_2)
		var_0_1:sendMsg("user.LeaderboardReq", {
			type = arg_3_1
		})
	end

	function arg_1_0.req_ResetMusicReq(arg_4_0, arg_4_1)
		var_0_1:sendMsg("user.ResetMusicReq", {})
	end

	function arg_1_0:preload_Leaderboard()
		self:req_LeaderboardReq(1, true)
	end
end

function var_0_0.extend_obj(arg_6_0)
	return
end

return var_0_0
