-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_aoqi_hero_pvp_win_score.lua

module("logicconfig.config.t_aoqi_hero_pvp_win_score", package.seeall)

local title = {
	addScore = 3,
	activityId = 1,
	winStreak = 2
}
local dataList = {
	{
		450001,
		1,
		20
	},
	{
		450001,
		2,
		20
	},
	{
		450001,
		3,
		20
	},
	{
		450001,
		4,
		30
	},
	{
		450001,
		5,
		30
	},
	{
		450001,
		6,
		30
	}
}
local t_aoqi_hero_pvp_win_score = {
	[450001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_aoqi_hero_pvp_win_score.dataList = dataList

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

return t_aoqi_hero_pvp_win_score
