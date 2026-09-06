-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_three_matches_game_target.lua

module("logicconfig.config.t_three_matches_game_target", package.seeall)

local title = {
	score = 6,
	targetPlanId = 1,
	params = 4,
	type = 3,
	targetId = 2,
	desc = 5
}
local dataList = {
	{
		1,
		1,
		"Collect",
		"18#15",
		"收集道具",
		200
	},
	{
		1,
		2,
		"Collect",
		"19#15",
		"收集道具",
		200
	},
	{
		1,
		3,
		"Collect",
		"21#15",
		"收集道具",
		200
	},
	{
		2,
		1,
		"Collect",
		"18#10",
		"收集道具",
		200
	},
	{
		2,
		2,
		"Collect",
		"19#10",
		"收集道具",
		200
	},
	{
		2,
		3,
		"Collect",
		"21#10",
		"收集道具",
		200
	},
	{
		3,
		1,
		"Collect",
		"18#5",
		"收集道具",
		200
	},
	{
		3,
		2,
		"Collect",
		"19#5",
		"收集道具",
		200
	},
	{
		3,
		3,
		"Collect",
		"21#5",
		"收集道具",
		200
	}
}
local t_three_matches_game_target = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_three_matches_game_target.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_three_matches_game_target
