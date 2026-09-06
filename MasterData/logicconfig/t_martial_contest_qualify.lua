-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_martial_contest_qualify.lua

module("logicconfig.config.t_martial_contest_qualify", package.seeall)

local title = {
	quaLevelPlanId = 4,
	endEarly = 3,
	winPrize = 13,
	quaActiveScoreDesc = 15,
	stepId = 2,
	quaActiveScorePlanId = 10,
	failPrize = 14,
	baseScore = 9,
	matchRatio = 8,
	matchScorePlanId = 5,
	quaMatchingPlanId = 7,
	stepName = 11,
	rankScorePlanId = 6,
	activityId = 1,
	useSupportPet = 12
}
local dataList = {
	{
		583001,
		1,
		10,
		1,
		1,
		1,
		1,
		5,
		100,
		1,
		"战区积分赛",
		true,
		"9:1001455:100",
		"9:1001455:50",
		"存活3-5只精灵额外获得10分\n存活6只精灵额外获得30分"
	},
	{
		583001,
		2,
		10,
		1,
		1,
		1,
		1,
		5,
		100,
		1,
		"全服晋级赛",
		false,
		"10:583001:100",
		"10:583001:50",
		"存活3-5只精灵额外获得10分\n存活6只精灵额外获得30分"
	},
	{
		583001,
		9999999,
		0,
		1,
		1,
		1,
		1,
		5,
		100,
		1,
		"全服娱乐赛",
		false,
		"10:583001:100",
		"10:583001:50",
		"存活3-5只精灵额外获得10分\n存活6只精灵额外获得30分"
	}
}
local t_martial_contest_qualify = {
	[583001] = {
		dataList[1],
		dataList[2],
		[9999999] = dataList[3]
	}
}

t_martial_contest_qualify.dataList = dataList

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

return t_martial_contest_qualify
