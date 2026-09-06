-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_armor_hero_stage.lua

module("logicconfig.config.t_armor_hero_stage", package.seeall)

local title = {
	progressPlan = 4,
	stageId = 2,
	skinId = 5,
	creepsMasterId = 3,
	activityId = 1,
	ruleKey = 6
}
local dataList = {
	{
		540001,
		1,
		1001,
		1,
		17014,
		"armor_hero_stage_rule1"
	},
	{
		540001,
		2,
		1002,
		2,
		12021,
		"armor_hero_stage_rule2"
	},
	{
		540002,
		1,
		1001,
		1,
		17014,
		"armor_hero_stage_rule1"
	},
	{
		540002,
		2,
		1002,
		2,
		12021,
		"armor_hero_stage_rule2"
	}
}
local t_armor_hero_stage = {
	[540001] = {
		dataList[1],
		dataList[2]
	},
	[540002] = {
		dataList[3],
		dataList[4]
	}
}

t_armor_hero_stage.dataList = dataList

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

return t_armor_hero_stage
