-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_water_tian_yan_clg_tab.lua

module("logicconfig.config.t_divine_water_tian_yan_clg_tab", package.seeall)

local title = {
	ruleDesc = 4,
	stageType = 2,
	activityId = 1,
	tabName = 3
}
local dataList = {
	{
		513001,
		1,
		"火领域",
		"1、我方精灵在火领域中会持续受到灼烧效果：敌阵特定精灵存活时，每个大回合结束时会对己方所有精灵造成当前最大生命值*10%的伤害,破阵即可通关，支持重复挑战\r\n2、每关挑战中，己阵精灵每变身 1 次得 1 层余焰，通关后可领取；重复挑战仅获超出历史最高记录的余焰"
	},
	{
		513001,
		2,
		"水领域",
		"1、水领域每个敌阵都会有一只拥有永久嘲讽和自身最大生命值*100%护盾的精灵，并且敌阵在阵亡时会无限复活，需要在限定回合数内<color=#C54949>达成破盾次数目标</color>才可通关，通关获得一定数量的神曜材料。\r\n2、可使用<color=#C54949>余焰（在火领域中产出）</color>解锁破盾协议，提升破盾效率。"
	}
}
local t_divine_water_tian_yan_clg_tab = {
	[513001] = {
		dataList[1],
		dataList[2]
	}
}

t_divine_water_tian_yan_clg_tab.dataList = dataList

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

return t_divine_water_tian_yan_clg_tab
