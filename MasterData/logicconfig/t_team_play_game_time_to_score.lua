-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_team_play_game_time_to_score.lua

module("logicconfig.config.t_team_play_game_time_to_score", package.seeall)

local title = {
	value = 2,
	typeId = 1,
	score = 3
}
local dataList = {
	{
		1,
		0,
		10
	},
	{
		1,
		30,
		50
	},
	{
		1,
		60,
		100
	},
	{
		1,
		90,
		150
	},
	{
		1,
		120,
		200
	},
	{
		2,
		1,
		5
	},
	{
		3,
		1,
		8
	},
	{
		3,
		2,
		12
	},
	{
		3,
		3,
		16
	}
}
local t_team_play_game_time_to_score = {
	{
		[0] = dataList[1],
		[30] = dataList[2],
		[60] = dataList[3],
		[90] = dataList[4],
		[120] = dataList[5]
	},
	{
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_team_play_game_time_to_score.dataList = dataList

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

return t_team_play_game_time_to_score
