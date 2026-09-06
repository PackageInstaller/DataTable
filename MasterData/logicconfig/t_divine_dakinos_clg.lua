-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_dakinos_clg.lua

module("logicconfig.config.t_divine_dakinos_clg", package.seeall)

local title = {
	jumpStrOne = 2,
	skinId = 7,
	jumpStrThree = 4,
	jumpStrTwo = 3,
	stageRule = 8,
	jumpStrFour = 5,
	ruleKeyMain = 6,
	activityId = 1,
	lockDesc = 9
}
local dataList = {
	{
		400001,
		"func#618#17021",
		"mibao#shenyaomiya3",
		"func#545#3",
		"",
		"divineDaknosmainview_rule",
		17021,
		"阵容效果：\r\n我方特定站位精灵会被蛊惑成为“狂热信徒”，“狂热信徒”获得20%伤害加深并且被击败后会对己阵造成自身攻击力250%的伤害；\r\n敌方所有攻击均会传导至受击目标身后的一个精灵，一次攻击只传导一次。\r\n通关条件：\r\n击败敌阵，且满足存活信徒，即可获得通关奖励。",
		"信徒"
	},
	{
		400002,
		"func#618#14040",
		"mibao#jinglingyangcheng",
		"ui#lottery",
		"func#545#52",
		"originnuoyaclgmainview_rule",
		14040,
		"阵容效果：\r\n我方特定站位精灵会将获得“暗隙之蚀”，“暗隙之蚀”获得40%伤害加深，受到超杀伤害时，将对己阵全阵造成自身攻击力*120%的伤害；\r\n敌阵精灵受到单体伤害有40%的减伤；\r\n通关条件：\r\n击败敌阵，且获得“暗隙之蚀”的精灵存活数量达标，即可获得通关奖励。",
		"暗隙之蚀"
	}
}
local t_divine_dakinos_clg = {
	[400001] = dataList[1],
	[400002] = dataList[2]
}

t_divine_dakinos_clg.dataList = dataList

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

return t_divine_dakinos_clg
