-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_mi_rui_ke_clg_phase.lua

module("logicconfig.config.t_divine_mi_rui_ke_clg_phase", package.seeall)

local title = {
	name = 3,
	ruleDesc = 4,
	phaseId = 2,
	prize = 5,
	activityId = 1
}
local dataList = {
	{
		381001,
		1,
		"第一层",
		"本关说明规则：\n\r\n1、敌方神曜蜜蕊可攻击时会令攻击目标变为纸飞机（1回合）\n\r\n2、击败敌方所有敌人视为通关",
		"4:238:20"
	},
	{
		381001,
		2,
		"第二层",
		"本关说明规则：\n\r\n1、敌方神曜蜜蕊可受击时会令敌阵随机一只存活精灵变为纸飞机（1回合）\n\r\n2、击败敌方所有敌人视为通关",
		"4:238:30"
	},
	{
		381001,
		3,
		"第三层",
		"本关说明规则：\n\r\n1、我方必须上阵蜜蕊可，蜜蕊可不能阵亡，蜜蕊可每个回合结束时会令己阵战力最低的2只其他存活精灵变为纸飞机（1回合）\n\r\n2、击败敌方所有敌人视为通关",
		"4:238:50"
	}
}
local t_divine_mi_rui_ke_clg_phase = {
	[381001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_divine_mi_rui_ke_clg_phase.dataList = dataList

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

return t_divine_mi_rui_ke_clg_phase
