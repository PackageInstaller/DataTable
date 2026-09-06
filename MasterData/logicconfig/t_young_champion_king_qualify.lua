-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_young_champion_king_qualify.lua

module("logicconfig.config.t_young_champion_king_qualify", package.seeall)

local title = {
	quaLevelPlanId = 4,
	endEarly = 3,
	stepName = 10,
	stepId = 2,
	baseScore = 9,
	matchRatio = 8,
	matchScorePlanId = 5,
	quaMatchingPlanId = 7,
	rankScorePlanId = 6,
	activityId = 1
}
local dataList = {
	{
		391001,
		1,
		10,
		1,
		1,
		1,
		1,
		5,
		100,
		"战区预选赛"
	},
	{
		391001,
		2,
		10,
		1,
		1,
		1,
		1,
		5,
		100,
		"战区积分赛"
	},
	{
		391001,
		9999999,
		0,
		1,
		1,
		1,
		1,
		5,
		100,
		"娱乐赛"
	}
}
local t_young_champion_king_qualify = {
	[391001] = {
		dataList[1],
		dataList[2],
		[9999999] = dataList[3]
	}
}

t_young_champion_king_qualify.dataList = dataList

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

return t_young_champion_king_qualify
