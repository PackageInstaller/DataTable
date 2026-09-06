-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mahjong_battle_summon_buff.lua

module("logicconfig.config.t_mahjong_battle_summon_buff", package.seeall)

local title = {
	activityId = 1,
	buffs = 4,
	buffId = 2,
	buffName = 5,
	buffDesc = 6,
	buffIcon = 7,
	buffPlan = 3
}
local dataList = {
	{
		571001,
		1,
		1,
		"20061301:99",
		"双刃剑",
		"技能命中目标后，额外造成攻击20%的伤害",
		"expevents/icon_expedition_jingzhun01"
	},
	{
		571001,
		2,
		1,
		"20061303:99",
		"无视防御",
		"无视目标35%防御",
		"expevents/icon_expedition_yisun01"
	},
	{
		571001,
		3,
		1,
		"20061304:99",
		"超杀伤害",
		"超杀伤害+20%",
		"expevents/icon_expedition_shanghaitisheng"
	},
	{
		571001,
		4,
		1,
		"20061305:99",
		"恢复生命",
		"每回合结束时，恢复12%的生命",
		"expevents/icon_expedition_kaichanghuixue"
	},
	{
		571001,
		5,
		2,
		"20061306:99",
		"死亡加气",
		"己方每死亡一个精灵，所有精灵+15点气势",
		"expevents/icon_expedition_liaoxiaojiangdi"
	},
	{
		571001,
		6,
		2,
		"20061308:99",
		"残血收割",
		"攻击50%以下生命的目标时，伤害+25%",
		"expevents/icon_expedition_ganran"
	},
	{
		571001,
		7,
		2,
		"20061309:99",
		"死亡加暴",
		"己方每死亡一个精灵，所有精灵暴击率+10%",
		"expevents/icon_expedition_chushouqianjianshang"
	},
	{
		571001,
		8,
		2,
		"20061311:99",
		"克制增伤",
		"攻击目标时，若对方被自己克制，伤害+40%",
		"expevents/icon_expedition_buqu"
	},
	{
		571001,
		9,
		3,
		"20061312:99",
		"吸收气势",
		"攻击命中目标后，吸收目标25点气势",
		"expevents/icon_expedition_bianyi01"
	},
	{
		571001,
		10,
		3,
		"20061313:99",
		"超杀降伤",
		"释放超杀后，降低40%下次受到的伤害",
		"expevents/icon_expedition_chaoshahoumianyi"
	},
	{
		571001,
		11,
		3,
		"20061315:99",
		"额外出手",
		"攻击后有100%的概率额外出手一次（每轮最多额外出手1次）",
		"expevents/icon_expedition_zhuiji"
	},
	{
		571001,
		12,
		3,
		"20065402:1",
		"免疫伤害",
		"免疫一次伤害",
		"expevents/icon_expedition_wufangqishi"
	},
	{
		571001,
		13,
		4,
		"20061318:99",
		"穿透护盾",
		"对带有护盾的目标伤害+50%",
		"expevents/icon_expedition_wushifangyu"
	},
	{
		571001,
		14,
		4,
		"20065401:99",
		"肉盾专精",
		"进入战斗时，己方肉盾精灵给自己及相邻所有的精灵添加一层免疫效果",
		"expevents/icon_expedition_jingzhun01"
	},
	{
		571001,
		15,
		4,
		"20065403:99",
		"跟你爆了",
		"己方首次受到致命伤害时，给敌阵造成自身攻击力*80%的绝毁伤害",
		"expevents/icon_expedition_yisun01"
	},
	{
		571001,
		16,
		4,
		"20065405:99",
		"闪避专精",
		"闪避时，给敌方攻击力最高的精灵造成自身攻击力*80%的伤害",
		"expevents/icon_expedition_shanghaitisheng"
	},
	{
		571001,
		17,
		5,
		"20065407:99",
		"平衡闪避",
		"己方平衡精灵受到超杀攻击时，永久给自身+8%闪避率（最多5层）",
		"expevents/icon_expedition_kaichanghuixue"
	},
	{
		571001,
		18,
		5,
		"20065415:99",
		"伤害减免",
		"进入战斗时，给己阵每种属性站位最靠前的存活精灵+15%免伤和+15%非伤免伤",
		"expevents/icon_expedition_liaoxiaojiangdi"
	},
	{
		571001,
		19,
		5,
		"20065411:99",
		"魔法专精",
		"己阵魔法精灵每次超杀时，给敌方受击者所在的一横排精灵+20%受伤加深（1回合，不可叠加）",
		"expevents/icon_expedition_ganran"
	},
	{
		571001,
		20,
		5,
		"20065413:99",
		"利爪专精",
		"己阵利爪精灵每次普攻时，使目标-25%防暴率，-25%闪避率，-25%格挡率",
		"expevents/icon_expedition_chushouqianjianshang"
	},
	{
		571001,
		21,
		5,
		"20065409:99",
		"疾速专精",
		"己方疾速精灵受到普通攻击时，永久给自身+5%闪避率（最多4层）",
		"expevents/icon_expedition_buqu"
	}
}
local t_mahjong_battle_summon_buff = {
	[571001] = {
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
		dataList[21]
	}
}

t_mahjong_battle_summon_buff.dataList = dataList

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

return t_mahjong_battle_summon_buff
