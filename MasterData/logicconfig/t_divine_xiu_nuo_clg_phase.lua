-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_xiu_nuo_clg_phase.lua

module("logicconfig.config.t_divine_xiu_nuo_clg_phase", package.seeall)

local title = {
	activityId = 1,
	openTime = 3,
	phaseId = 2,
	prize = 4,
	desc = 5
}
local dataList = {
	{
		395001,
		1,
		"2024-08-23T05:00:00",
		"4:510334:20",
		"1、神曜修尔（系统精灵）必须作为助战上阵，且站位固定。\r\n2、敌阵精灵获得诅咒效果，治疗效果减少50%。\r\n3、成功破阵，且修尔存活则视为通关。\r\n4、本层所有关卡通关后即可获得奖励。"
	},
	{
		395001,
		2,
		"2024-08-24T05:00:00",
		"4:510334:30",
		"1、神曜诺亚（系统精灵）必须作为助战上阵，且站位固定。\r\n2、己阵精灵释放【群攻】标签的技能时，己阵其他存活精灵获得30气势。\r\n3、成功破阵，且诺亚存活则视为通关。\r\n4、本层所有关卡通关后即可获得奖励。"
	},
	{
		395001,
		3,
		"2024-08-25T05:00:00",
		"4:510334:50",
		"1、敌阵攻击目标时打上对应的光暗标记，标记可叠加，同时存在时，光暗标记可一比一相互抵消。\r\n★光效果：每层令自身造成的伤害降低30%\r\n★暗效果：每层令自身受到的伤害增加30%\r\n★光暗抵消时效果：对自身造成30%最大生命值的伤害并令自身全属性永久降低30%\r\n★无标记时效果：造成的伤害降低50%\r\n2、通关时，分别封印己阵中光、暗标记层数最多的精灵。"
	}
}
local t_divine_xiu_nuo_clg_phase = {
	[395001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_divine_xiu_nuo_clg_phase.dataList = dataList

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

return t_divine_xiu_nuo_clg_phase
