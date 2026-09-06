-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dual_dragon_buff.lua

module("logicconfig.config.t_dual_dragon_buff", package.seeall)

local title = {
	buffId = 1,
	des = 2
}
local dataList = {
	{
		1,
		"己阵击杀目标时令目标全属性降低<color=#4eff00>10%</color>"
	},
	{
		2,
		"敌阵超杀后令自身立即<color=#ff4747>出手一次</color>（全阵最多触发2次）"
	},
	{
		3,
		"己阵命中率提高<color=#4eff00>20%</color>"
	},
	{
		4,
		"敌阵超杀后会获得<color=#ff4747>30%</color>生命值上限的护盾"
	},
	{
		5,
		"己阵超杀后，令己阵精灵受伤永久降低<color=#4eff00>5%</color>（全阵最多触发3次）"
	},
	{
		6,
		"敌阵无视无法回血效果"
	},
	{
		7,
		"己阵受到的超杀伤害减少<color=#4eff00>10%</color>"
	},
	{
		8,
		"敌阵攻击后会获得<color=#ff4747>50%</color>闪避率（1回合）"
	},
	{
		9,
		"己阵受到的暴击伤害减少<color=#4eff00>10%</color>"
	},
	{
		10,
		"敌阵死亡时复活并恢复满血满气势（全阵最多触发2次）"
	},
	{
		11,
		"己阵击杀目标时令自身全属性提高<color=#4eff00>10%</color>"
	},
	{
		12,
		"敌阵攻击力最高的精灵进入战斗时会获得<color=#ff4747>50</color>气势并立即出手1次"
	},
	{
		13,
		"己阵格挡率提高<color=#4eff00>20%</color>"
	},
	{
		14,
		"敌阵超杀对己阵气势最高的存活精灵造成攻击*<color=#ff4747>150%</color>的毁灭伤害"
	},
	{
		15,
		"己阵超杀后，令敌阵精灵全属性永久降低<color=#4eff00>5%</color>（全阵最多触发3次）"
	},
	{
		16,
		"己阵永久无法回血"
	},
	{
		17,
		"己阵造成的超杀伤害增加<color=#4eff00>10%</color>"
	},
	{
		18,
		"敌阵命中率提高<color=#ff4747>50%</color>"
	},
	{
		19,
		"己阵造成的暴击伤害增加<color=#4eff00>10%</color>"
	},
	{
		20,
		"己阵起始气势降低<color=#ff4747>30</color>点"
	},
	{
		21,
		"上阵下列任一精灵获得效果：战斗开始时，玩家精灵气势<color=#4eff00>+150</color>"
	},
	{
		22,
		"上阵下列任一精灵获得效果：己方每次第<color=#4eff00>1</color>个阵亡的精灵，将强制保留<color=#4eff00>1</color>点血量"
	},
	{
		23,
		"上阵下列任一精灵获得效果：超杀技能的伤害提升<color=#4eff00>20%</color>"
	},
	{
		24,
		"上阵下列任一精灵获得效果：魔法伤害提升<color=#4eff00>25%</color>"
	},
	{
		25,
		"上阵下列任一精灵获得效果：物理伤害提升<color=#4eff00>25%</color>"
	},
	{
		26,
		"上阵下列任一精灵获得效果：每次攻击时，属性克制效果提升<color=#4eff00>50%</color>"
	},
	{
		27,
		"上阵下列任一精灵获得效果：每次攻击会造成攻击<color=#4eff00>12%</color>的额外伤害"
	}
}
local t_dual_dragon_buff = {
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

t_dual_dragon_buff.dataList = dataList

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

return t_dual_dragon_buff
