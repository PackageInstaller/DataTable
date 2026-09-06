-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ultimate_war_step.lua

module("logicconfig.config.t_ultimate_war_step", package.seeall)

local title = {
	supportPetPlanId = 8,
	openTime = 3,
	buffDesc = 7,
	endTime = 4,
	stepId = 2,
	bossCreepsMasterId = 6,
	activityId = 1,
	desc = 5
}
local dataList = {
	{
		434001,
		1,
		"2024-12-20T05:00:00",
		"2025-01-24T05:00:00",
		"一阶段-部署防线",
		0,
		"",
		0
	},
	{
		434001,
		2,
		"2024-12-27T05:00:00",
		"2025-01-24T05:00:00",
		"二阶段-危机来临",
		6001,
		"1.boss会令与自身相同属性的攻击伤害降为0\r\n2.boss每个大回合结束后，会变为该大回合对自身造成最多伤害精灵的属性",
		6
	},
	{
		434001,
		3,
		"2025-01-03T05:00:00",
		"2025-01-24T05:00:00",
		"三阶段-最终决战",
		0,
		"",
		0
	}
}
local t_ultimate_war_step = {
	[434001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_ultimate_war_step.dataList = dataList

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

return t_ultimate_war_step
