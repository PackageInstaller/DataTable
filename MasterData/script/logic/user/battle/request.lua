local var_0_0 = {}
local var_0_1 = gamecore.NetworkManager
local var_0_2 = gamecore.user

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_StartBattleReq(arg_2_0, arg_2_1, arg_2_2)
		var_0_2:set_cur_formation(arg_2_1)
		var_0_2:set_night_battle(false)
		var_0_1:sendMsg("user.StartBattleReq", {
			formation = arg_2_1,
			buff_id = arg_2_2
		})
	end

	function arg_1_0.req_StartNightBattleReq(arg_3_0)
		var_0_2:set_night_battle(true)
		var_0_1:sendMsg("user.StartNightBattleReq", {})
	end

	function arg_1_0.req_QuitNightBattleReq(arg_4_0)
		var_0_1:sendMsg("user.QuitNightBattleReq", {})
	end

	function arg_1_0.req_BattleFinishReq(arg_5_0)
		var_0_1:sendMsg("user.BattleFinishReq", {})
	end

	function arg_1_0.req_BattleLogReq(arg_6_0, arg_6_1)
		var_0_1:sendMsg("user.BattleLogReq", {
			battle_log = arg_6_1
		})
	end
end

function var_0_0.extend_obj(arg_7_0)
	return
end

return var_0_0
