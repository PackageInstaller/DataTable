-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_contest_card_step.lua

module("logicconfig.config.t_goddess_contest_card_step", package.seeall)

local title = {
	cardVotePlanId = 13,
	contestEndTime = 6,
	collectOpenTime = 3,
	collectEndTime = 4,
	stepId = 2,
	setCardStartTime = 8,
	collectCardPlanId = 11,
	publicationTime = 10,
	openCardTime = 7,
	autoShowCardTime = 9,
	contestOpenTime = 5,
	cardScorePlanId = 12,
	activityId = 1
}
local dataList = {
	{
		251002,
		1,
		"2024-03-01T05:00:00",
		"2024-03-08T05:00:00",
		"2024-03-22T05:00:00",
		"2024-03-22T18:00:00",
		"2024-03-22T05:00:00",
		"2024-03-22T05:00:00",
		"2024-03-22T17:00:00",
		"2024-03-22T18:00:00",
		1,
		1,
		1
	},
	{
		251002,
		2,
		"2024-03-08T05:00:00",
		"2024-03-15T05:00:00",
		"2024-03-23T05:00:00",
		"2024-03-23T18:00:00",
		"2024-03-23T05:00:00",
		"2024-03-23T05:00:00",
		"2024-03-23T17:00:00",
		"2024-03-23T18:00:00",
		1,
		1,
		1
	},
	{
		251002,
		3,
		"2024-03-15T05:00:00",
		"2024-03-22T05:00:00",
		"2024-03-24T05:00:00",
		"2024-03-24T18:00:00",
		"2024-03-24T05:00:00",
		"2024-03-24T05:00:00",
		"2024-03-24T17:00:00",
		"2024-03-24T18:00:00",
		1,
		1,
		1
	}
}
local t_goddess_contest_card_step = {
	[251002] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_goddess_contest_card_step.dataList = dataList

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

return t_goddess_contest_card_step
