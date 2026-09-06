-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_competition_step.lua

module("logicconfig.config.t_goddess_competition_step", package.seeall)

local title = {
	stepType = 5,
	openTime = 3,
	rankPrizePlanId = 9,
	goddessCounter = 6,
	stepId = 2,
	hudDesc = 10,
	promotedCount = 7,
	desc = 8,
	endTime = 4,
	activityId = 1
}
local dataList = {
	{
		453001,
		1,
		"2025-02-28T05:00:00",
		"2025-03-07T05:00:00",
		"KNOCKOUT",
		30,
		6,
		"淘汰赛",
		1,
		"30进6"
	},
	{
		453001,
		2,
		"2025-03-07T05:00:00",
		"2025-03-14T05:00:00",
		"REVIVE_MATCH",
		24,
		2,
		"复活赛",
		1,
		"24进2"
	},
	{
		453001,
		3,
		"2025-03-14T05:00:00",
		"2025-03-21T05:00:00",
		"EIGHT_PLACE_MATCH",
		8,
		4,
		"八强赛",
		1,
		"8进4"
	},
	{
		453001,
		4,
		"2025-03-21T05:00:00",
		"2025-03-28T05:00:00",
		"FOUR_PLACE_MATCH",
		4,
		1,
		"四强赛",
		0,
		"决赛"
	},
	{
		453002,
		1,
		"2026-03-13T05:00:00",
		"2026-03-20T05:00:00",
		"KNOCKOUT",
		21,
		8,
		"淘汰赛",
		0,
		"21进8"
	},
	{
		453002,
		2,
		"2026-03-20T05:00:00",
		"2026-03-27T05:00:00",
		"EIGHT_PLACE_MATCH",
		8,
		4,
		"八强赛",
		0,
		"8进4"
	},
	{
		453002,
		3,
		"2026-03-27T05:00:00",
		"2026-04-03T05:00:00",
		"FOUR_PLACE_MATCH",
		4,
		1,
		"四强赛",
		0,
		"决赛"
	}
}
local t_goddess_competition_step = {
	[453001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	[453002] = {
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_goddess_competition_step.dataList = dataList

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

return t_goddess_competition_step
