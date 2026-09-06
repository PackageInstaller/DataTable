-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_project_ash.lua

module("logicconfig.config.t_project_ash", package.seeall)

local title = {
	stage2WorldPrizePlanId = 10,
	stage2BuffPlanId = 12,
	stage1ProgressPlanId = 3,
	dailyChallengeLimit = 6,
	stage1PrizePlanId = 4,
	stage2OpenTime = 5,
	stage2CreepMasterId = 13,
	stage2ProgressPlanId = 8,
	activityId = 1,
	stage2DamagePrizePlanId = 9,
	stage2CostPlanId = 7,
	stage1CostPlanId = 2,
	stage2FinalPrize = 14,
	rankScoreUnit = 15,
	selectBuffLimit = 11,
	taskRedPointId = 17,
	showCoin = 16
}
local dataList = {
	{
		265001,
		1,
		1,
		1,
		"2023-05-19T05:00:00",
		5,
		2,
		2,
		2,
		3,
		3,
		1,
		1001,
		"4:36:10",
		10000,
		"10:265001#10:265002#10:265003",
		447
	}
}
local t_project_ash = {
	[265001] = dataList[1]
}

t_project_ash.dataList = dataList

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

return t_project_ash
