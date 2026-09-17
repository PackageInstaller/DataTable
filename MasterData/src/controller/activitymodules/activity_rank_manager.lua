local activity_base_manager = require("controller.activitymodules.activity_base_manager")
local playermodel = require("model.playermodel")
local chapter_data = require("data.chapter_data")
local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local network = require("network.network")

function activity_base_manager.get_servant_rank_data(arg_1_0, arg_1_1, arg_1_2)
	network:rpc("get_valentine_chapter_rank_data", {
		start = 0,
		stop = 29,
		activityid = arg_1_1
	}, function(arg_2_0)
		if arg_2_0.result == 1 then
			if arg_1_2 then
				arg_1_2((arg_1_0:genServantData(arg_2_0.data)))
			end
		end
	end)
end

function activity_base_manager.get_valentine_rank_data(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0, var_3_1 = playermodel.curLevel:match("(%d+)-(%d+)")

	network:rpc("get_valentine_rank_data", {
		start = 0,
		type = 1,
		stop = 99,
		activityid = arg_3_1,
		chapter = playermodel.curMode .. "-" .. var_3_0
	}, function(arg_4_0)
		if arg_4_0.result == 1 and arg_3_2 then
			arg_3_2(arg_4_0.data)
		end
	end)
end

function activity_base_manager.get_valentine_player_rank(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0, var_5_1 = playermodel.curLevel:match("(%d+)-(%d+)")

	network:rpc("get_valentine_player_rank", {
		type = 1,
		activityid = arg_5_1,
		chapter = playermodel.curMode .. "-" .. var_5_0
	}, function(arg_6_0)
		if arg_6_0.result == 1 and arg_5_2 then
			arg_5_2(arg_6_0)
		end
	end)
end

function activity_base_manager.genServantData(arg_7_0, arg_7_1)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		local var_7_1, var_7_2 = iter_7_1.chapter:match("(%d+)-(%d+)")
		local var_7_3 = model_data[require("data.leveldata.monster_data" .. var_7_1)[require("data.leveldata.monster_team_data" .. var_7_1)[chapter_data[iter_7_1.chapter].bigboss].boss].modelid].major

		var_7_0[iter_7_0] = iter_7_1
		var_7_0[iter_7_0].name = major_factor_data[var_7_3].name
		var_7_0[iter_7_0].head_sculpture = model_data[major_factor_data[var_7_3].model].head_image
	end

	return var_7_0
end
