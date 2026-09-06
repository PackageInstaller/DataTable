-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_contest_activity.lua

module("logicconfig.config.t_goddess_contest_activity", package.seeall)

local title = {
	actId = 1,
	cardGridNum = 9,
	progressSldPlanId = 10,
	goddessVoteItemId = 6,
	popularityFrenzyPlanId = 4,
	winnerTabsPlanId = 11,
	directorVoteItemId = 7,
	groupTabsPlanId = 12,
	hudPlanId = 13,
	timePlanId = 2,
	settlementPrizePlanId = 5,
	fansGroupPlanId = 3,
	refundItemId = 8
}
local dataList = {
	{
		251001,
		1,
		1,
		1,
		1,
		"10:251001",
		"10:251002",
		"10:251003",
		4,
		1,
		1,
		1,
		1
	},
	{
		251002,
		2,
		2,
		2,
		2,
		"10:251004",
		"10:251005",
		"10:251006",
		4,
		2,
		1,
		1,
		1
	}
}
local t_goddess_contest_activity = {
	[251001] = dataList[1],
	[251002] = dataList[2]
}

t_goddess_contest_activity.dataList = dataList

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

return t_goddess_contest_activity
