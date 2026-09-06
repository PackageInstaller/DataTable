-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_sword_storm_monster.lua

module("logicconfig.config.t_sword_storm_monster", package.seeall)

local title = {
	winId = 4,
	name = 2,
	selfBuffProviderId = 5,
	skipTime = 3,
	creepsMasterId = 1,
	heroSkillId = 7,
	formCondition = 6,
	ruleDesc = 8
}
local dataList = {
	{
		1001,
		"通灵秘源·究",
		5,
		0,
		593,
		0,
		"",
		"免伤及非伤免伤提升20%"
	},
	{
		1002,
		"万刃殁锋·殒劫圣龙",
		5,
		0,
		593,
		0,
		"",
		"伤害提升50%"
	},
	{
		1003,
		"神曜权御·龙尊圣主",
		5,
		0,
		593,
		0,
		"",
		"免伤及非伤免伤提升20%"
	},
	{
		1004,
		"虚骸噬灭·薄伽丘",
		5,
		0,
		593,
		0,
		"",
		"免伤及非伤免伤提升20%"
	},
	{
		1005,
		"苍青圣骑·阿特拉斯",
		5,
		0,
		593,
		0,
		"",
		"伤害提升50%"
	},
	{
		1006,
		"万相同观·权天使",
		5,
		0,
		593,
		0,
		"",
		"免伤及非伤免伤提升20%"
	}
}
local t_sword_storm_monster = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6]
}

t_sword_storm_monster.dataList = dataList

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

return t_sword_storm_monster
