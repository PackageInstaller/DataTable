-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_jieshen_clg_extreme_tower.lua

module("logicconfig.config.t_divine_jieshen_clg_extreme_tower", package.seeall)

local title = {
	lockRace = 5,
	openTime = 3,
	towerRule = 6,
	towerName = 4,
	activityId = 1,
	towerId = 2
}
local dataList = {
	{
		387001,
		1,
		"2024-07-26T05:00:00",
		"神龙试炼",
		false,
		"1.击败敌阵时，存活精灵数量达到指定条件后即可过关"
	},
	{
		387001,
		2,
		"2024-07-27T05:00:00",
		"赤之试炼",
		false,
		"1.击败敌阵时，存活精灵数量达到指定条件后即可过关\r\n2.进入战斗时，己阵站位靠后的2只精灵会无法行动1回合"
	},
	{
		387001,
		3,
		"2024-07-28T05:00:00",
		"亦之试炼",
		true,
		"1.击败敌阵时，存活精灵数量达到指定条件后即可过关\r\n2.进入战斗时，己阵站位最靠前的2位精灵将与敌阵站位靠前的2位精灵将对应进入领域，不能攻击对方以外精灵，敌方精灵吸收20%全属性，初始气势+50，任意一方被击败领域消失\r\n 3.同一层关卡内，上阵精灵不可重复上阵"
	}
}
local t_divine_jieshen_clg_extreme_tower = {
	[387001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_divine_jieshen_clg_extreme_tower.dataList = dataList

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

return t_divine_jieshen_clg_extreme_tower
