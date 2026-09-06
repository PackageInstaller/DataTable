-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_abyss_gold_rush_streak_score.lua

module("logicconfig.config.t_abyss_gold_rush_streak_score", package.seeall)

local title = {
	id = 2,
	addScore = 4,
	activityId = 1,
	streak = 3
}
local dataList = {
	{
		612001,
		1,
		1,
		0
	},
	{
		612001,
		2,
		2,
		0
	},
	{
		612001,
		3,
		3,
		2
	},
	{
		612001,
		4,
		4,
		3
	},
	{
		612001,
		5,
		5,
		5
	},
	{
		612001,
		6,
		6,
		5
	},
	{
		612001,
		7,
		7,
		5
	},
	{
		612001,
		8,
		8,
		10
	},
	{
		612001,
		9,
		9,
		10
	},
	{
		612001,
		10,
		10,
		10
	},
	{
		612001,
		11,
		11,
		20
	}
}
local t_abyss_gold_rush_streak_score = {
	[612001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11]
	}
}

t_abyss_gold_rush_streak_score.dataList = dataList

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

return t_abyss_gold_rush_streak_score
