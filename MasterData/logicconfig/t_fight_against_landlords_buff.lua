-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fight_against_landlords_buff.lua

module("logicconfig.config.t_fight_against_landlords_buff", package.seeall)

local title = {
	buffType = 3,
	name = 4,
	buffId = 2,
	buffPlanId = 1,
	iconPath = 6,
	desc = 5
}
local dataList = {
	{
		1,
		1,
		1,
		"狙击眸",
		"己方所有精灵暴击率+40%",
		"icon/expevents/icon_expedition_baojilv1"
	},
	{
		1,
		2,
		1,
		"天雷罚",
		"敌方死亡后周围精灵受到最大生命值20%伤害（仅1次）",
		"icon/expevents/icon_expedition_numu"
	},
	{
		1,
		3,
		1,
		"穿盾刺",
		"己方精灵对带有护盾的精灵造成的伤害提升35%",
		"icon/expevents/icon_expedition_wushifangyu"
	},
	{
		1,
		4,
		1,
		"电屏障",
		"己方精灵每次出手获得最大生命值6%的护盾（3回合）",
		"icon/expevents/icon_expedition_guijia01"
	},
	{
		1,
		5,
		1,
		"自愈合",
		"己方精灵每回合结束时恢复8%最大生命值",
		"icon/expevents/icon_expedition_kaichanghuixue"
	},
	{
		1,
		6,
		1,
		"曲光屏",
		"己方精灵受到的群攻伤害减少30%",
		"icon/expevents/icon_expedition_guijia"
	},
	{
		1,
		7,
		1,
		"诅咒击",
		"己方精灵的技能会使目标精灵无法回血（1回合）",
		"icon/expevents/icon_expedition_shenqi_an"
	},
	{
		1,
		8,
		1,
		"回旋镖",
		"己方精灵的技能对目标造成额外伤害25%",
		"icon/expevents/icon_expedition_chaoshafanshi"
	},
	{
		1,
		9,
		1,
		"狂战怒",
		"己方每死亡一个精灵，其余精灵伤害+10%",
		"icon/expevents/icon_expedition_yadao01"
	},
	{
		1,
		10,
		1,
		"黄金盾",
		"己方精灵格挡率+30%",
		"icon/expevents/icon_expedition_chushouqianjianshang"
	},
	{
		1,
		11,
		2,
		"来搬腕子把",
		"己阵攻击吸血10%",
		""
	},
	{
		1,
		12,
		2,
		"生命梦境",
		"己阵治疗效果+20%",
		""
	},
	{
		1,
		13,
		2,
		"智慧利刃",
		"己阵每次攻击后直到大回合结束获得10%增伤效果（可叠加）",
		""
	},
	{
		1,
		14,
		2,
		"掌控时间",
		"己阵群攻伤害+20%",
		""
	},
	{
		1,
		15,
		2,
		"是非之花",
		"己阵攻击永久降低目标10%全属性（不可叠加）",
		""
	},
	{
		1,
		16,
		2,
		"铿锵玫瑰",
		"己阵女性精灵伤害+20%",
		""
	},
	{
		1,
		17,
		2,
		"金盾守护",
		"己阵每次攻击额外获得10点气势",
		""
	},
	{
		1,
		18,
		2,
		"光暗双生",
		"己阵无视防御+20%",
		""
	},
	{
		1,
		19,
		2,
		"雷鸣沙暴",
		"己阵群攻伤害+20%",
		""
	},
	{
		1,
		20,
		2,
		"光影相随",
		"己阵治疗效果+20%",
		""
	},
	{
		1,
		21,
		2,
		"启希之约",
		"己阵无视防御+20%",
		""
	},
	{
		2,
		22,
		1,
		"狙击眸",
		"己方所有精灵暴击率+40%",
		"icon/expevents/icon_expedition_baojilv1"
	},
	{
		2,
		23,
		1,
		"天雷罚",
		"敌方死亡后周围精灵受到最大生命值20%伤害（仅1次）",
		"icon/expevents/icon_expedition_numu"
	},
	{
		2,
		24,
		1,
		"穿盾刺",
		"己方精灵对带有护盾的精灵造成的伤害提升35%",
		"icon/expevents/icon_expedition_wushifangyu"
	},
	{
		2,
		25,
		1,
		"电屏障",
		"己方精灵每次出手获得最大生命值6%的护盾（3回合）",
		"icon/expevents/icon_expedition_guijia01"
	},
	{
		2,
		26,
		1,
		"自愈合",
		"己方精灵每回合结束时恢复8%最大生命值",
		"icon/expevents/icon_expedition_kaichanghuixue"
	},
	{
		2,
		27,
		1,
		"曲光屏",
		"己方精灵受到的群攻伤害减少30%",
		"icon/expevents/icon_expedition_guijia"
	},
	{
		2,
		28,
		1,
		"诅咒击",
		"己方精灵的技能会使目标精灵无法回血（1回合）",
		"icon/expevents/icon_expedition_shenqi_an"
	},
	{
		2,
		29,
		1,
		"回旋镖",
		"己方精灵的技能对目标造成额外伤害25%",
		"icon/expevents/icon_expedition_chaoshafanshi"
	},
	{
		2,
		30,
		1,
		"狂战怒",
		"己方每死亡一个精灵，其余精灵伤害+10%",
		"icon/expevents/icon_expedition_yadao01"
	},
	{
		2,
		31,
		1,
		"黄金盾",
		"己方精灵格挡率+30%",
		"icon/expevents/icon_expedition_chushouqianjianshang"
	},
	{
		2,
		32,
		2,
		"来搬腕子把",
		"己阵攻击吸血10%",
		""
	},
	{
		2,
		33,
		2,
		"生命梦境",
		"己阵治疗效果+20%",
		""
	},
	{
		2,
		34,
		2,
		"智慧利刃",
		"己阵每次攻击后直到大回合结束获得10%增伤效果（可叠加）",
		""
	},
	{
		2,
		35,
		2,
		"掌控时间",
		"己阵群攻伤害+20%",
		""
	},
	{
		2,
		36,
		2,
		"是非之花",
		"己阵攻击永久降低目标10%全属性（不可叠加）",
		""
	},
	{
		2,
		37,
		2,
		"麟炎饿道",
		"己阵无视防御+20%",
		""
	},
	{
		2,
		38,
		2,
		"苍穹寰宇",
		"己阵每次攻击额外获得10点气势",
		""
	},
	{
		2,
		39,
		2,
		"冥河锁链",
		"己阵无视防御+20%",
		""
	},
	{
		2,
		40,
		2,
		"咏叹魔踪",
		"己阵攻击永久降低目标10%全属性（不可叠加）",
		""
	},
	{
		2,
		41,
		2,
		"双生护萌",
		"己阵女性精灵伤害+20%",
		""
	},
	{
		2,
		42,
		2,
		"永世正义",
		"己阵攻击吸血10%",
		""
	},
	{
		3,
		43,
		1,
		"领主属性提升",
		"己方所有精灵全属性+30%,双方精灵-60%治疗量",
		"icon/expevents/icon_expedition_numu"
	}
}
local t_fight_against_landlords_buff = {
	{
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
	},
	{
		[22] = dataList[22],
		[23] = dataList[23],
		[24] = dataList[24],
		[25] = dataList[25],
		[26] = dataList[26],
		[27] = dataList[27],
		[28] = dataList[28],
		[29] = dataList[29],
		[30] = dataList[30],
		[31] = dataList[31],
		[32] = dataList[32],
		[33] = dataList[33],
		[34] = dataList[34],
		[35] = dataList[35],
		[36] = dataList[36],
		[37] = dataList[37],
		[38] = dataList[38],
		[39] = dataList[39],
		[40] = dataList[40],
		[41] = dataList[41],
		[42] = dataList[42]
	},
	{
		[43] = dataList[43]
	}
}

t_fight_against_landlords_buff.dataList = dataList

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

return t_fight_against_landlords_buff
