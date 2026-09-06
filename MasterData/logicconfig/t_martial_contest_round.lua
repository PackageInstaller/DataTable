-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_martial_contest_round.lua

module("logicconfig.config.t_martial_contest_round", package.seeall)

local title = {
	roundType = 3,
	activityId = 1,
	roundId = 2,
	roundName = 4
}
local dataList = {
	{
		583001,
		1,
		"QUALIFY",
		"战区积分赛"
	},
	{
		583001,
		2,
		"SCORE_MATCH",
		"全服晋级赛"
	},
	{
		583001,
		3,
		"FINALS_COMMON",
		"决赛第一日"
	},
	{
		583001,
		4,
		"FINALS_3V3",
		"决赛第二日"
	},
	{
		583001,
		5,
		"FINALS_BUFF",
		"决赛第三日"
	},
	{
		583001,
		6,
		"DISPLAY",
		"展示"
	}
}
local t_martial_contest_round = {
	[583001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_martial_contest_round.dataList = dataList

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

return t_martial_contest_round
