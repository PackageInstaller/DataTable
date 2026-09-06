-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_tian_shan_clg_extreme_stage_desc.lua

module("logicconfig.config.t_divine_tian_shan_clg_extreme_stage_desc", package.seeall)

local title = {
	stagePlanId = 1,
	stageDesc = 3,
	phaseId = 2
}
local dataList = {
	{
		1,
		1,
		"1、暴风领域中，对敌阵小天造成暴击，可获得1点能量，圣骑精灵额外获得1点。\r\n2、能量满时，即可开启领域技能，持续1个大回合，期间不获得能量，敌阵精灵攻击后会减少我方精灵20%暴击率（不叠加）。\r\n3、受到领域庇护，敌阵伤害减免20%且小天在9个大回合后会离开领域。\r\n4、全部关卡破阵，四个区域的领域技能次数＞0且达到平衡即可通关并获得奖励。"
	},
	{
		1,
		2,
		"1、闪电领域中，普攻命中敌阵小天，可获得1点能量，圣骑精灵额外获得1点。\r\n2、能量满时，即可开启领域技能，持续1个大回合，期间不获得能量，敌阵精灵攻击后会减少我方精灵20%命中率（不叠加）。\r\n3、受到领域庇护，敌阵伤害减免20%且小天在9个大回合后会离开领域。\r\n4、全部关卡破阵，四个区域的领域技能次数＞0且达到平衡即可通关并获得奖励。"
	},
	{
		1,
		3,
		"1、骤雨领域中，超杀命中敌阵小天，可获得1点能量，圣骑精灵额外获得1点。\r\n2、能量满时，即可开启领域技能，持续1个大回合，期间不获得能量，敌阵精灵攻击后会减少我方精灵25气势。\r\n3、受到领域庇护，敌阵伤害减免20%且小天在9个大回合后会离开领域。\r\n4、全部关卡破阵，四个区域的领域技能次数＞0且达到平衡即可通关并获得奖励。"
	},
	{
		1,
		4,
		"1、冰雹领域中，群攻命中敌阵小天，可获得1点能量，圣骑精灵额外获得1点。\r\n2、能量满时，即可开启领域技能，持续1个大回合，期间不获得能量，敌阵精灵攻击后会减少我方精灵15%防御（最多3层），并对受击目标相邻的精灵造成攻击者攻击力40%的伤害。\r\n3、受到领域庇护，敌阵伤害减免20%且小天在9个大回合后会离开领域。\r\n4、全部关卡破阵，四个区域的领域技能次数＞0且达到平衡即可通关并获得奖励。"
	}
}
local t_divine_tian_shan_clg_extreme_stage_desc = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_divine_tian_shan_clg_extreme_stage_desc.dataList = dataList

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

return t_divine_tian_shan_clg_extreme_stage_desc
