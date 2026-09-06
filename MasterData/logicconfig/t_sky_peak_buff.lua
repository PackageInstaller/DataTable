-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_sky_peak_buff.lua

module("logicconfig.config.t_sky_peak_buff", package.seeall)

local title = {
	parentNodeId = 3,
	nodeId = 2,
	buffDesc = 6,
	costBuffScore = 5,
	unlockStageId = 4,
	buffIcon = 7,
	activityId = 1,
	buffName = 8
}
local dataList = {
	{
		592001,
		11,
		0,
		1,
		3,
		"己阵时空龙尊每个大回合开始时获得50气势",
		"expevents/icon_expedition_jingzhun01",
		"加气"
	},
	{
		592001,
		12,
		11,
		1,
		6,
		"己阵精灵起始气势+30",
		"expevents/icon_expedition_jingzhun01",
		"加气"
	},
	{
		592001,
		13,
		12,
		1,
		6,
		"每个大回合开始时，令气势最高的精灵获得一次立即出手",
		"expevents/icon_expedition_jingzhun01",
		"出手"
	},
	{
		592001,
		14,
		12,
		1,
		6,
		"每个大回合开始时，令己阵攻击力最高的精灵获得一次立即出手",
		"expevents/icon_expedition_jingzhun01",
		"出手"
	},
	{
		592001,
		15,
		13,
		1,
		6,
		"增伤+10%",
		"expevents/icon_expedition_jingzhun01",
		"增伤+10%"
	},
	{
		592001,
		16,
		14,
		1,
		6,
		"增伤+10%",
		"expevents/icon_expedition_jingzhun01",
		"增伤+10%"
	},
	{
		592001,
		17,
		15,
		1,
		9,
		"全属性+100%",
		"expevents/icon_expedition_jingzhun01",
		"全属性+100%"
	},
	{
		592001,
		18,
		16,
		1,
		9,
		"全属性+100%",
		"expevents/icon_expedition_jingzhun01",
		"全属性+100%"
	},
	{
		592001,
		21,
		0,
		1,
		3,
		"己阵时空龙尊进入战斗时额外获得自身生命值*40%的护盾",
		"expevents/icon_expedition_jingzhun01",
		"护盾"
	},
	{
		592001,
		22,
		21,
		1,
		6,
		"己阵精灵进入战斗时获得自身生命值*40%的护盾",
		"expevents/icon_expedition_jingzhun01",
		"护盾"
	},
	{
		592001,
		23,
		22,
		1,
		6,
		"己阵精灵超杀后，令己阵攻击力最高的精灵获得自身生命值*30%的护盾（2回合）",
		"expevents/icon_expedition_jingzhun01",
		"护盾"
	},
	{
		592001,
		24,
		22,
		1,
		6,
		"己阵精灵超杀后，令自己获得自身生命值*30%的护盾（2回合）",
		"expevents/icon_expedition_jingzhun01",
		"护盾"
	},
	{
		592001,
		25,
		23,
		1,
		6,
		"免伤+10%",
		"expevents/icon_expedition_jingzhun01",
		"免伤+10%"
	},
	{
		592001,
		26,
		24,
		1,
		6,
		"免伤+10%",
		"expevents/icon_expedition_jingzhun01",
		"免伤+10%"
	},
	{
		592001,
		27,
		25,
		1,
		9,
		"全属性+100%",
		"expevents/icon_expedition_jingzhun01",
		"全属性+100%"
	},
	{
		592001,
		28,
		26,
		1,
		9,
		"全属性+100%",
		"expevents/icon_expedition_jingzhun01",
		"全属性+100%"
	},
	{
		592001,
		31,
		0,
		1,
		3,
		"己阵时空龙尊每个大回合免疫第一次伤害",
		"expevents/icon_expedition_jingzhun01",
		"免疫"
	},
	{
		592001,
		32,
		31,
		1,
		6,
		"进入战斗时，敌阵精灵获得禁疗（2回合）",
		"expevents/icon_expedition_jingzhun01",
		"禁疗"
	},
	{
		592001,
		33,
		32,
		1,
		6,
		"每个大回合己阵首个出手的精灵给目标施加无法行动（1回合）",
		"expevents/icon_expedition_jingzhun01",
		"无法行动"
	},
	{
		592001,
		34,
		32,
		1,
		6,
		"每个大回合开始时，敌阵随机一个精灵获得无法行动（1回合）",
		"expevents/icon_expedition_jingzhun01",
		"无法行动"
	},
	{
		592001,
		35,
		33,
		1,
		6,
		"增伤+10%",
		"expevents/icon_expedition_jingzhun01",
		"增伤+10%"
	},
	{
		592001,
		36,
		34,
		1,
		6,
		"增伤+10%",
		"expevents/icon_expedition_jingzhun01",
		"增伤+10%"
	},
	{
		592001,
		37,
		35,
		1,
		9,
		"全属性+100%",
		"expevents/icon_expedition_jingzhun01",
		"全属性+100%"
	},
	{
		592001,
		38,
		36,
		1,
		9,
		"全属性+100%",
		"expevents/icon_expedition_jingzhun01",
		"全属性+100%"
	},
	{
		592001,
		41,
		0,
		10,
		10,
		"己阵时空龙尊攻击若击杀目标，则获得一次立即出手且此次出手暴击伤害+50%",
		"expevents/icon_expedition_jingzhun01",
		"出手"
	},
	{
		592001,
		42,
		41,
		10,
		20,
		"己阵精灵攻击对目标造成自身攻击力*80%的附加伤害",
		"expevents/icon_expedition_jingzhun01",
		"附加伤害"
	},
	{
		592001,
		43,
		42,
		10,
		20,
		"己阵精灵攻击无视目标25%防御",
		"expevents/icon_expedition_jingzhun01",
		"无视防御"
	},
	{
		592001,
		44,
		42,
		10,
		20,
		"己阵精灵由此技能造成的附加伤害增加到160%",
		"expevents/icon_expedition_jingzhun01",
		"附加伤害"
	},
	{
		592001,
		45,
		43,
		10,
		20,
		"增伤+15%",
		"expevents/icon_expedition_jingzhun01",
		"增伤+15%"
	},
	{
		592001,
		46,
		44,
		10,
		20,
		"增伤+15%",
		"expevents/icon_expedition_jingzhun01",
		"增伤+15%"
	},
	{
		592001,
		47,
		45,
		10,
		30,
		"全属性+250%",
		"expevents/icon_expedition_jingzhun01",
		"全属性+250%"
	},
	{
		592001,
		48,
		46,
		10,
		30,
		"全属性+250%",
		"expevents/icon_expedition_jingzhun01",
		"全属性+250%"
	},
	{
		592001,
		51,
		0,
		10,
		10,
		"己阵时空龙尊受到致命伤害时为自身移除所有无法回血状态",
		"expevents/icon_expedition_jingzhun01",
		"移除禁疗"
	},
	{
		592001,
		52,
		51,
		10,
		20,
		"己阵攻击力最高及战力最高的精灵首次阵亡后满血复活",
		"expevents/icon_expedition_jingzhun01",
		"复活"
	},
	{
		592001,
		53,
		52,
		10,
		20,
		"此技能效果改为解除无法回血状态后满血复活",
		"expevents/icon_expedition_jingzhun01",
		"复活"
	},
	{
		592001,
		54,
		52,
		10,
		20,
		"此技能效果复活效果增加一次",
		"expevents/icon_expedition_jingzhun01",
		"复活"
	},
	{
		592001,
		55,
		53,
		10,
		20,
		"免伤+15%",
		"expevents/icon_expedition_jingzhun01",
		"免伤+15%"
	},
	{
		592001,
		56,
		54,
		10,
		20,
		"免伤+15%",
		"expevents/icon_expedition_jingzhun01",
		"免伤+15%"
	},
	{
		592001,
		57,
		55,
		10,
		30,
		"全属性+250%",
		"expevents/icon_expedition_jingzhun01",
		"全属性+250%"
	},
	{
		592001,
		58,
		56,
		10,
		30,
		"全属性+250%",
		"expevents/icon_expedition_jingzhun01",
		"全属性+250%"
	},
	{
		592002,
		11,
		0,
		1,
		8,
		"己阵站位最靠前的源起梦之队精灵每个大回合开始时获得50气势",
		"expevents/icon_expedition_zhuiji",
		"加气"
	},
	{
		592002,
		12,
		11,
		1,
		16,
		"己阵精灵起始气势+30",
		"expevents/icon_expedition_zhuiji",
		"加气"
	},
	{
		592002,
		13,
		12,
		1,
		16,
		"每个大回合开始时，令气势最高的精灵获得一次立即出手",
		"expevents/icon_expedition_zhuiji",
		"出手"
	},
	{
		592002,
		14,
		12,
		1,
		16,
		"每个大回合开始时，令己阵攻击力最高的精灵获得一次立即出手",
		"expevents/icon_expedition_zhuiji",
		"出手"
	},
	{
		592002,
		15,
		13,
		1,
		16,
		"增伤+10%",
		"expevents/icon_expedition_wushang",
		"增伤+10%"
	},
	{
		592002,
		16,
		14,
		1,
		16,
		"增伤+10%",
		"expevents/icon_expedition_wushang",
		"增伤+10%"
	},
	{
		592002,
		17,
		15,
		1,
		24,
		"全属性+150%",
		"expevents/icon_expedition_chixue",
		"全属性+150%"
	},
	{
		592002,
		18,
		16,
		1,
		24,
		"全属性+150%",
		"expevents/icon_expedition_chixue",
		"全属性+150%"
	},
	{
		592002,
		21,
		0,
		1,
		8,
		"己阵攻击力最高的源起梦之队精灵进入战斗时额外获得自身生命值*40%的护盾",
		"expevents/icon_expedition_chushouqianjianshang",
		"护盾"
	},
	{
		592002,
		22,
		21,
		1,
		16,
		"己阵精灵进入战斗时获得自身生命值*40%的护盾",
		"expevents/icon_expedition_chushouqianjianshang",
		"护盾"
	},
	{
		592002,
		23,
		22,
		1,
		16,
		"己阵精灵超杀后，令己阵攻击力最高的精灵获得自身生命值*30%的护盾（2回合）",
		"expevents/icon_expedition_chushouqianjianshang",
		"护盾"
	},
	{
		592002,
		24,
		22,
		1,
		16,
		"己阵精灵超杀后，令自己获得自身生命值*30%的护盾（2回合）",
		"expevents/icon_expedition_chushouqianjianshang",
		"护盾"
	},
	{
		592002,
		25,
		23,
		1,
		16,
		"免伤+10%",
		"expevents/icon_expedition_chixue01",
		"免伤+10%"
	},
	{
		592002,
		26,
		24,
		1,
		16,
		"免伤+10%",
		"expevents/icon_expedition_chixue01",
		"免伤+10%"
	},
	{
		592002,
		27,
		25,
		1,
		24,
		"全属性+150%",
		"expevents/icon_expedition_chixue",
		"全属性+150%"
	},
	{
		592002,
		28,
		26,
		1,
		24,
		"全属性+150%",
		"expevents/icon_expedition_chixue",
		"全属性+150%"
	},
	{
		592002,
		31,
		0,
		1,
		8,
		"己阵攻击力最高的源起梦之队精灵每个大回合免疫第一次伤害",
		"expevents/icon_expedition_6huihezhongjie",
		"免疫"
	},
	{
		592002,
		32,
		31,
		1,
		16,
		"进入战斗时，敌阵精灵获得禁疗（2回合）",
		"expevents/icon_expedition_baotou",
		"禁疗"
	},
	{
		592002,
		33,
		32,
		1,
		16,
		"每个大回合己阵首个出手的精灵给目标施加无法行动（1回合）",
		"expevents/icon_expedition_baotou",
		"无法行动"
	},
	{
		592002,
		34,
		32,
		1,
		16,
		"每个大回合开始时，敌阵随机一个精灵获得无法行动（1回合）",
		"expevents/icon_expedition_baotou",
		"无法行动"
	},
	{
		592002,
		35,
		33,
		1,
		16,
		"增伤+10%",
		"expevents/icon_expedition_wushang",
		"增伤+10%"
	},
	{
		592002,
		36,
		34,
		1,
		16,
		"增伤+10%",
		"expevents/icon_expedition_wushang",
		"增伤+10%"
	},
	{
		592002,
		37,
		35,
		1,
		24,
		"全属性+150%",
		"expevents/icon_expedition_chixue",
		"全属性+150%"
	},
	{
		592002,
		38,
		36,
		1,
		24,
		"全属性+150%",
		"expevents/icon_expedition_chixue",
		"全属性+150%"
	},
	{
		592002,
		41,
		0,
		10,
		18,
		"己阵攻击力最高的源起梦之队精灵攻击若击杀目标，则获得一次立即出手且此次出手暴击伤害+50%",
		"expevents/icon_expedition_zhuiji",
		"出手"
	},
	{
		592002,
		42,
		41,
		10,
		36,
		"己阵精灵攻击对目标造成自身攻击力*80%的附加伤害",
		"expevents/icon_expedition_zhansha",
		"附加伤害"
	},
	{
		592002,
		43,
		42,
		10,
		36,
		"己阵精灵攻击无视目标25%防御",
		"expevents/icon_expedition_zhansha",
		"无视防御"
	},
	{
		592002,
		44,
		42,
		10,
		36,
		"己阵精灵由此技能造成的附加伤害增加到160%",
		"expevents/icon_expedition_zhansha",
		"附加伤害"
	},
	{
		592002,
		45,
		43,
		10,
		36,
		"增伤+15%",
		"expevents/icon_expedition_wushang",
		"增伤+15%"
	},
	{
		592002,
		46,
		44,
		10,
		36,
		"增伤+15%",
		"expevents/icon_expedition_wushang",
		"增伤+15%"
	},
	{
		592002,
		47,
		45,
		10,
		54,
		"全属性+300%",
		"expevents/icon_expedition_chixue",
		"全属性+300%"
	},
	{
		592002,
		48,
		46,
		10,
		54,
		"全属性+300%",
		"expevents/icon_expedition_chixue",
		"全属性+300%"
	},
	{
		592002,
		51,
		0,
		10,
		18,
		"己阵站位最靠前的源起梦之队精灵受到致命伤害时为自身移除所有无法回血状态",
		"expevents/icon_expedition_shengmingqishi",
		"移除禁疗"
	},
	{
		592002,
		52,
		51,
		10,
		36,
		"己阵攻击力最高及战力最高的精灵首次阵亡后满血复活",
		"expevents/icon_expedition_shengmingqishi",
		"复活"
	},
	{
		592002,
		53,
		52,
		10,
		36,
		"此技能效果改为解除无法回血状态后满血复活",
		"expevents/icon_expedition_shengmingqishi",
		"复活"
	},
	{
		592002,
		54,
		52,
		10,
		36,
		"此技能效果复活效果增加一次",
		"expevents/icon_expedition_shengmingqishi",
		"复活"
	},
	{
		592002,
		55,
		53,
		10,
		36,
		"免伤+15%",
		"expevents/icon_expedition_chixue01",
		"免伤+15%"
	},
	{
		592002,
		56,
		54,
		10,
		36,
		"免伤+15%",
		"expevents/icon_expedition_chixue01",
		"免伤+15%"
	},
	{
		592002,
		57,
		55,
		10,
		54,
		"全属性+300%",
		"expevents/icon_expedition_chixue",
		"全属性+300%"
	},
	{
		592002,
		58,
		56,
		10,
		54,
		"全属性+300%",
		"expevents/icon_expedition_chixue",
		"全属性+300%"
	}
}
local t_sky_peak_buff = {
	[592001] = {
		[11] = dataList[1],
		[12] = dataList[2],
		[13] = dataList[3],
		[14] = dataList[4],
		[15] = dataList[5],
		[16] = dataList[6],
		[17] = dataList[7],
		[18] = dataList[8],
		[21] = dataList[9],
		[22] = dataList[10],
		[23] = dataList[11],
		[24] = dataList[12],
		[25] = dataList[13],
		[26] = dataList[14],
		[27] = dataList[15],
		[28] = dataList[16],
		[31] = dataList[17],
		[32] = dataList[18],
		[33] = dataList[19],
		[34] = dataList[20],
		[35] = dataList[21],
		[36] = dataList[22],
		[37] = dataList[23],
		[38] = dataList[24],
		[41] = dataList[25],
		[42] = dataList[26],
		[43] = dataList[27],
		[44] = dataList[28],
		[45] = dataList[29],
		[46] = dataList[30],
		[47] = dataList[31],
		[48] = dataList[32],
		[51] = dataList[33],
		[52] = dataList[34],
		[53] = dataList[35],
		[54] = dataList[36],
		[55] = dataList[37],
		[56] = dataList[38],
		[57] = dataList[39],
		[58] = dataList[40]
	},
	[592002] = {
		[11] = dataList[41],
		[12] = dataList[42],
		[13] = dataList[43],
		[14] = dataList[44],
		[15] = dataList[45],
		[16] = dataList[46],
		[17] = dataList[47],
		[18] = dataList[48],
		[21] = dataList[49],
		[22] = dataList[50],
		[23] = dataList[51],
		[24] = dataList[52],
		[25] = dataList[53],
		[26] = dataList[54],
		[27] = dataList[55],
		[28] = dataList[56],
		[31] = dataList[57],
		[32] = dataList[58],
		[33] = dataList[59],
		[34] = dataList[60],
		[35] = dataList[61],
		[36] = dataList[62],
		[37] = dataList[63],
		[38] = dataList[64],
		[41] = dataList[65],
		[42] = dataList[66],
		[43] = dataList[67],
		[44] = dataList[68],
		[45] = dataList[69],
		[46] = dataList[70],
		[47] = dataList[71],
		[48] = dataList[72],
		[51] = dataList[73],
		[52] = dataList[74],
		[53] = dataList[75],
		[54] = dataList[76],
		[55] = dataList[77],
		[56] = dataList[78],
		[57] = dataList[79],
		[58] = dataList[80]
	}
}

t_sky_peak_buff.dataList = dataList

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

return t_sky_peak_buff
