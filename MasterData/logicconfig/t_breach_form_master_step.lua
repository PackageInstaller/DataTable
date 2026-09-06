-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_breach_form_master_step.lua

module("logicconfig.config.t_breach_form_master_step", package.seeall)

local title = {
	defenseZdlWanPercent = 14,
	attackPetActiveScore = 5,
	attackBreachFormScore = 6,
	defensePetActiveScore = 12,
	stepId = 2,
	attackRaceScorePlanId = 7,
	attackIncRatio = 10,
	attackScoreRatio = 9,
	defenseCirclePlanId = 13,
	attackCirclePlanId = 8,
	endTime = 4,
	defenseScore = 11,
	activityId = 1,
	startTime = 3
}
local dataList = {
	{
		593001,
		1,
		"2026-04-30T05:00:00",
		"2026-05-08T05:00:00",
		100,
		400,
		1,
		1,
		100,
		30000,
		80,
		40,
		2,
		0
	},
	{
		593001,
		2,
		"2026-05-08T05:00:00",
		"2026-05-15T05:00:00",
		100,
		400,
		2,
		1,
		80,
		2000,
		80,
		40,
		2,
		0
	},
	{
		593001,
		3,
		"2026-05-15T05:00:00",
		"2026-05-22T05:00:00",
		100,
		400,
		3,
		1,
		80,
		2000,
		80,
		40,
		2,
		0
	},
	{
		593001,
		4,
		"2026-05-22T05:00:00",
		"2026-05-29T05:00:00",
		100,
		400,
		3,
		1,
		80,
		2000,
		80,
		40,
		2,
		0
	}
}
local t_breach_form_master_step = {
	[593001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_breach_form_master_step.dataList = dataList

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

return t_breach_form_master_step
