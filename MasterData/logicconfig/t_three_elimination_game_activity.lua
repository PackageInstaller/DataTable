-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_three_elimination_game_activity.lua

module("logicconfig.config.t_three_elimination_game_activity", package.seeall)

local title = {
	attackMaxValue = 8,
	hangUpUnitSecd = 4,
	maxStepPerRound = 3,
	jumpTo = 12,
	ruleId = 11,
	skinId = 13,
	hangUpMaxValue = 5,
	maxGroupPerRound = 2,
	mapId = 10,
	redPointId = 9,
	hangUpMp = 6,
	attckUnitSecd = 7,
	activityId = 1
}
local dataList = {
	{
		339001,
		99,
		10,
		4,
		50000,
		"10:339001:1",
		1800,
		20,
		553,
		1,
		1,
		{
			"func#191#339#339001"
		},
		0
	},
	{
		339002,
		99,
		10,
		4,
		50000,
		"10:339004:1",
		1800,
		20,
		553,
		1,
		1,
		{
			"func#191#339#339002"
		},
		0
	},
	{
		339003,
		99,
		10,
		4,
		50000,
		"10:339006:1",
		1800,
		20,
		553,
		1,
		1,
		{
			"func#191#339#339003"
		},
		0
	},
	{
		339004,
		99,
		10,
		4,
		50000,
		"10:339008:1",
		1800,
		20,
		553,
		1,
		1,
		{
			"func#191#339#339004"
		},
		11036
	}
}
local t_three_elimination_game_activity = {
	[339001] = dataList[1],
	[339002] = dataList[2],
	[339003] = dataList[3],
	[339004] = dataList[4]
}

t_three_elimination_game_activity.dataList = dataList

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

return t_three_elimination_game_activity
