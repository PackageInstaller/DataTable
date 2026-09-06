-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_auto_chess_fetters_buff.lua

module("logicconfig.config.t_auto_chess_fetters_buff", package.seeall)

local title = {
	fettersId = 1,
	name = 3,
	buffDesc = 5,
	num = 2,
	iconPath = 4
}
local dataList = {
	{
		1,
		2,
		"连击Ⅰ",
		"com_icon_tuteng_jineng04",
		"每次攻击后会提高自己伤害6%，效果可以堆叠，每个大回合结束时清空层数"
	},
	{
		1,
		4,
		"连击Ⅱ",
		"com_icon_tuteng_jineng05",
		"每次攻击后会提高自己伤害18%，效果可以堆叠，每个大回合结束时清空层数"
	},
	{
		1,
		6,
		"连击Ⅲ",
		"com_icon_tuteng_jineng06",
		"每次攻击后会提高自己伤害30%，效果可以堆叠，每个大回合结束时清空层数"
	},
	{
		2,
		2,
		"穿云箭Ⅰ",
		"com_icon_tuteng_jineng01",
		"每次攻击附带该次攻击*3%的伤害"
	},
	{
		2,
		4,
		"穿云箭Ⅱ",
		"com_icon_tuteng_jineng02",
		"每次攻击附带该次攻击*9%的伤害"
	},
	{
		2,
		6,
		"穿云箭Ⅲ",
		"com_icon_tuteng_jineng03",
		"每次攻击附带该次攻击*15%的伤害"
	},
	{
		3,
		2,
		"医疗专家Ⅰ",
		"com_icon_tuteng_jineng07",
		"回血效果提升6%"
	},
	{
		3,
		4,
		"医疗专家Ⅱ",
		"com_icon_tuteng_jineng08",
		"回血效果提升18%"
	},
	{
		3,
		6,
		"医疗专家Ⅲ",
		"com_icon_tuteng_jineng09",
		"回血效果提升30%"
	},
	{
		4,
		2,
		"齐射Ⅰ",
		"com_icon_tuteng_jineng10",
		"群攻伤害提升6%"
	},
	{
		4,
		4,
		"齐射Ⅱ",
		"com_icon_tuteng_jineng11",
		"群攻伤害提升18%"
	},
	{
		4,
		6,
		"齐射Ⅲ",
		"com_icon_tuteng_jineng12",
		"群攻伤害提升30%"
	},
	{
		5,
		2,
		"巫毒Ⅰ",
		"com_icon_tuteng_jineng13",
		"每次攻击降低目标6点气势"
	},
	{
		5,
		4,
		"巫毒Ⅱ",
		"com_icon_tuteng_jineng14",
		"每次攻击降低目标18点气势"
	},
	{
		5,
		6,
		"巫毒Ⅲ",
		"com_icon_tuteng_jineng15",
		"每次攻击降低目标30点气势"
	},
	{
		6,
		2,
		"振奋Ⅰ",
		"com_icon_tuteng_jineng16",
		"起始气势增加9点"
	},
	{
		6,
		4,
		"振奋Ⅱ",
		"com_icon_tuteng_jineng17",
		"起始气势增加27点"
	},
	{
		6,
		6,
		"振奋Ⅲ",
		"com_icon_tuteng_jineng18",
		"起始气势增加45点"
	}
}
local t_auto_chess_fetters_buff = {
	{
		[2] = dataList[1],
		[4] = dataList[2],
		[6] = dataList[3]
	},
	{
		[2] = dataList[4],
		[4] = dataList[5],
		[6] = dataList[6]
	},
	{
		[2] = dataList[7],
		[4] = dataList[8],
		[6] = dataList[9]
	},
	{
		[2] = dataList[10],
		[4] = dataList[11],
		[6] = dataList[12]
	},
	{
		[2] = dataList[13],
		[4] = dataList[14],
		[6] = dataList[15]
	},
	{
		[2] = dataList[16],
		[4] = dataList[17],
		[6] = dataList[18]
	}
}

t_auto_chess_fetters_buff.dataList = dataList

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

return t_auto_chess_fetters_buff
