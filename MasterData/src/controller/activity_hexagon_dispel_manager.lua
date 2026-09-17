local var_0_0 = {}
local network = require("network.network")
local playermodel = require("model.playermodel")

function var_0_0.getPlayerData(arg_1_0, arg_1_1, arg_1_2)
	network:rpc("load_hexagon_player_data", {
		activityid = arg_1_1
	}, function(arg_2_0)
		if arg_2_0.result == 1 and arg_1_2 then
			arg_1_2(arg_2_0)
		end
	end)
end

function var_0_0.savePlayerData(arg_3_0, arg_3_1, arg_3_2)
	network:rpc("save_hexagon_player_data", arg_3_1, function(arg_4_0)
		if arg_4_0.result == 1 and arg_3_2 then
			arg_3_2(arg_4_0)
		end
	end)
end

function var_0_0.buySelectChance(arg_5_0, arg_5_1, arg_5_2)
	network:rpc("buy_hexagon_select_chance", arg_5_1, function(arg_6_0)
		if arg_6_0.result == 1 then
			if arg_6_0.cost_diamond then
				playermodel.diamond = playermodel.diamond - arg_6_0.cost_diamond

				global_update_gold_stone_diamond(nil, nil, arg_6_0.cost_diamond)
			end

			if arg_5_2 then
				arg_5_2(arg_6_0)
			end
		elseif arg_6_0.result == 2 then
			global_ShowBlockWords("购买次数已达上限！！")
		elseif arg_6_0.result == 3 then
			global_ShowBlockWords("魂晶数量不足！！")
		elseif arg_6_0.result == 4 then
			global_ShowBlockWords("换一换次数已满~")
		end
	end)
end

function var_0_0.gameFailed(arg_7_0, arg_7_1, arg_7_2)
	network:rpc("hexagon_game_failed", arg_7_1, function(arg_8_0)
		if arg_8_0.result == 1 then
			global_ShowBlockWords("游戏结束~")

			if arg_7_2 then
				arg_7_2(arg_8_0)
			end
		end
	end)
end

function var_0_0.get_hexagon_score_rank_list(arg_9_0, arg_9_1, arg_9_2)
	network:rpc("get_hexagon_score_rank_list", {
		activityid = arg_9_1
	}, function(arg_10_0)
		if arg_9_2 then
			arg_9_2(arg_10_0.data, arg_10_0.player_data)
		end
	end)
end

return var_0_0
