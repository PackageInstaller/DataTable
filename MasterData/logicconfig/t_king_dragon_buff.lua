-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_dragon_buff.lua

module("logicconfig.config.t_king_dragon_buff", package.seeall)

local title = {
	icon = 3,
	buffId = 1,
	des = 2
}
local dataList = {
	{
		1,
		"出手后，全体精灵提升<color=#F5C701FF>10</color>点气势",
		""
	},
	{
		2,
		"首次受击必定闪避",
		""
	},
	{
		3,
		"反弹50%技能魔法伤害",
		""
	},
	{
		4,
		"免疫非直接伤害，出手前清除所有减益效果",
		""
	},
	{
		5,
		"攻击附带撕裂效果（2个大回合，不可叠加）",
		""
	},
	{
		6,
		"受到超杀伤害加深<color=#F5C701FF>20%</color>",
		""
	},
	{
		7,
		"受到水系精灵伤害加深<color=#F5C701FF>20%</color>",
		""
	},
	{
		8,
		"受到暴击伤害加深<color=#F5C701FF>20%</color>",
		""
	},
	{
		9,
		"受到火系精灵伤害加深<color=#F5C701FF>20%</color>",
		""
	},
	{
		10,
		"受到草系精灵伤害加深<color=#F5C701FF>20%</color>",
		""
	},
	{
		11,
		"对生命值大于自身的目标造成的伤害增加30%",
		""
	},
	{
		12,
		"群攻伤害增加30%",
		""
	},
	{
		13,
		"攻击前降低目标防御50%",
		""
	},
	{
		14,
		"每次被复活时获得50气势",
		""
	},
	{
		15,
		"首次死亡时，若击杀目标，则复活并恢复1点生命值（全阵最多触发3次）",
		""
	},
	{
		16,
		"受到暴击伤害增加20%",
		""
	},
	{
		17,
		"受到创系伤害增加20%",
		""
	},
	{
		18,
		"受到群攻伤害增加20%",
		""
	},
	{
		19,
		"受到超杀伤害增加20%",
		""
	},
	{
		20,
		"受到光系伤害增加20%",
		""
	},
	{
		21,
		"己阵全属性+20%",
		""
	},
	{
		22,
		"敌阵受到的光系伤害+20%",
		""
	},
	{
		23,
		"敌阵受到的暗系伤害+20%",
		""
	},
	{
		24,
		"每回合结束时气势+30",
		""
	},
	{
		25,
		"己阵暴击率+40%",
		""
	},
	{
		26,
		"敌阵受到暴击伤害增加100%",
		""
	},
	{
		27,
		"己阵首次受击时必定闪避",
		""
	}
}
local t_king_dragon_buff = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11],
	dataList[12],
	dataList[13],
	dataList[14],
	dataList[15],
	dataList[16],
	dataList[17],
	dataList[18],
	dataList[19],
	dataList[20],
	dataList[21],
	dataList[22],
	dataList[23],
	dataList[24],
	dataList[25],
	dataList[26],
	dataList[27]
}

t_king_dragon_buff.dataList = dataList

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

return t_king_dragon_buff
