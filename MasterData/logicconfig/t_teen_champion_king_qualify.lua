-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_teen_champion_king_qualify.lua

module("logicconfig.config.t_teen_champion_king_qualify", package.seeall)

local title = {
	stepName = 9,
	endEarly = 3,
	stepId = 2,
	baseScore = 8,
	matchRatio = 7,
	matchScorePlanId = 4,
	quaMatchingPlanId = 6,
	rankScorePlanId = 5,
	activityId = 1
}
local dataList = {
	{
		501001,
		1,
		10,
		1,
		1,
		1,
		5,
		100,
		"战区预选赛"
	},
	{
		501001,
		2,
		10,
		1,
		1,
		1,
		5,
		100,
		"战区积分赛"
	},
	{
		501001,
		9999999,
		0,
		1,
		1,
		1,
		5,
		100,
		"娱乐赛"
	}
}
local t_teen_champion_king_qualify = {
	[501001] = {
		dataList[1],
		dataList[2],
		[9999999] = dataList[3]
	}
}

t_teen_champion_king_qualify.dataList = dataList

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

return t_teen_champion_king_qualify
