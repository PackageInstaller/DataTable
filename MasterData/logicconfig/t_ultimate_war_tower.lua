-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ultimate_war_tower.lua

module("logicconfig.config.t_ultimate_war_tower", package.seeall)

local title = {
	supportPetPlanId = 4,
	stagePlanId = 3,
	pos = 6,
	buffDesc = 7,
	skinId = 8,
	icon = 5,
	activityId = 1,
	towerId = 2
}
local dataList = {
	{
		434001,
		1,
		1,
		1,
		"familynesttower/bg_llzz_05",
		{
			-359,
			216
		},
		"敌阵精灵受到的非水属性伤害降低50%",
		17004
	},
	{
		434001,
		2,
		2,
		2,
		"familynesttower/bg_llzz_02",
		{
			-39,
			-176
		},
		"敌阵精灵受到的非火属性伤害降低50%",
		12012
	},
	{
		434001,
		3,
		3,
		3,
		"familynesttower/bg_llzz_06",
		{
			-417,
			-72
		},
		"敌阵精灵受到的非草属性伤害降低50%",
		17016
	},
	{
		434001,
		4,
		4,
		4,
		"familynesttower/bg_llzz_03",
		{
			326,
			192
		},
		"敌阵精灵受到的非光属性伤害降低50%",
		17001
	},
	{
		434001,
		5,
		5,
		5,
		"familynesttower/bg_llzz_04",
		{
			430,
			-123
		},
		"敌阵精灵受到的非暗属性伤害降低50%",
		11012
	}
}
local t_ultimate_war_tower = {
	[434001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_ultimate_war_tower.dataList = dataList

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

return t_ultimate_war_tower
