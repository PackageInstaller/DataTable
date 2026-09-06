-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_sword_storm_stage.lua

module("logicconfig.config.t_sword_storm_stage", package.seeall)

local title = {
	stageId = 3,
	ruleDesc = 6,
	phaseId = 2,
	conditionPlanId = 5,
	creepsMasterId = 4,
	activityId = 1,
	story = 7
}
local dataList = {
	{
		579001,
		1,
		1,
		1001,
		1,
		"免伤及非伤免伤提升20%",
		4920037
	},
	{
		579001,
		1,
		2,
		1002,
		2,
		"伤害提升50%",
		4920038
	},
	{
		579001,
		1,
		3,
		1003,
		3,
		"免伤及非伤免伤提升20%",
		4920039
	},
	{
		579001,
		2,
		1,
		1004,
		4,
		"免伤及非伤免伤提升20%",
		4920040
	},
	{
		579001,
		2,
		2,
		1005,
		5,
		"伤害提升50%",
		4920041
	},
	{
		579001,
		2,
		3,
		1006,
		6,
		"免伤及非伤免伤提升20%",
		4920042
	}
}
local t_sword_storm_stage = {
	[579001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
			dataList[4],
			dataList[5],
			dataList[6]
		}
	}
}

t_sword_storm_stage.dataList = dataList

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

return t_sword_storm_stage
