-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xiu_nuo_brotherhood_buff.lua

module("logicconfig.config.t_xiu_nuo_brotherhood_buff", package.seeall)

local title = {
	name = 2,
	buffId = 1,
	des = 3
}
local dataList = {
	{
		101,
		"巫毒",
		"出手后，使目标精灵生命恢复效果降低<color=#c54949>20%</color>（1回合）"
	},
	{
		102,
		"巫毒",
		"出手后，使目标精灵生命恢复效果降低<color=#c54949>40%</color>（1回合）"
	},
	{
		103,
		"巫毒",
		"出手后，使目标精灵生命恢复效果降低<color=#c54949>60%</color>（1回合）"
	},
	{
		104,
		"巫毒",
		"出手后，使目标精灵生命恢复效果降低<color=#c54949>80%</color>（1回合）"
	},
	{
		105,
		"巫毒",
		"出手后，使目标精灵生命恢复效果降低<color=#c54949>100%</color>（1回合）"
	},
	{
		111,
		"医疗专家",
		"进入战斗时，永久提升己阵精灵生命恢复效果<color=#c54949>20%</color>"
	},
	{
		112,
		"医疗专家",
		"进入战斗时，永久提升己阵精灵生命恢复效果<color=#c54949>40%</color>"
	},
	{
		113,
		"医疗专家",
		"进入战斗时，永久提升己阵精灵生命恢复效果<color=#c54949>60%</color>"
	},
	{
		114,
		"医疗专家",
		"进入战斗时，永久提升己阵精灵生命恢复效果<color=#c54949>80%</color>"
	},
	{
		115,
		"医疗专家",
		"进入战斗时，永久提升己阵精灵生命恢复效果<color=#c54949>100%</color>"
	},
	{
		201,
		"凝神一击",
		"超杀伤害增加<color=#c54949>10%</color>"
	},
	{
		202,
		"凝神一击",
		"超杀伤害增加<color=#c54949>20%</color>"
	},
	{
		203,
		"凝神一击",
		"超杀伤害增加<color=#c54949>30%</color>"
	},
	{
		204,
		"凝神一击",
		"超杀伤害增加<color=#c54949>40%</color>"
	},
	{
		205,
		"凝神一击",
		"超杀伤害增加<color=#c54949>50%</color>"
	},
	{
		211,
		"普通一击",
		"普攻伤害增加<color=#c54949>15%</color>"
	},
	{
		212,
		"普通一击",
		"普攻伤害增加<color=#c54949>30%</color>"
	},
	{
		213,
		"普通一击",
		"普攻伤害增加<color=#c54949>45%</color>"
	},
	{
		214,
		"普通一击",
		"普攻伤害增加<color=#c54949>60%</color>"
	},
	{
		215,
		"普通一击",
		"普攻伤害增加<color=#c54949>75%</color>"
	},
	{
		301,
		"附伤",
		"攻击后，对目标精灵额外造成攻击伤害*<color=#c54949>6%</color>的伤害"
	},
	{
		302,
		"附伤",
		"攻击后，对目标精灵额外造成攻击伤害*<color=#c54949>12%</color>的伤害"
	},
	{
		303,
		"附伤",
		"攻击后，对目标精灵额外造成攻击伤害*<color=#c54949>18%</color>的伤害"
	},
	{
		304,
		"附伤",
		"攻击后，对目标精灵额外造成攻击伤害*<color=#c54949>24%</color>的伤害"
	},
	{
		305,
		"附伤",
		"攻击后，对目标精灵额外造成攻击伤害*<color=#c54949>30%</color>的伤害"
	},
	{
		311,
		"吸血",
		"攻击时吸血<color=#c54949>6%</color>"
	},
	{
		312,
		"吸血",
		"攻击时吸血<color=#c54949>12%</color>"
	},
	{
		313,
		"吸血",
		"攻击时吸血<color=#c54949>18%</color>"
	},
	{
		314,
		"吸血",
		"攻击时吸血<color=#c54949>24%</color>"
	},
	{
		315,
		"吸血",
		"攻击时吸血<color=#c54949>30%</color>"
	},
	{
		401,
		"齐射",
		"群攻伤害增加<color=#c54949>10%</color>"
	},
	{
		402,
		"齐射",
		"群攻伤害增加<color=#c54949>20%</color>"
	},
	{
		403,
		"齐射",
		"群攻伤害增加<color=#c54949>30%</color>"
	},
	{
		404,
		"齐射",
		"群攻伤害增加<color=#c54949>40%</color>"
	},
	{
		405,
		"齐射",
		"群攻伤害增加<color=#c54949>50%</color>"
	},
	{
		411,
		"暴伤",
		"暴击伤害增加<color=#c54949>10%</color>"
	},
	{
		412,
		"暴伤",
		"暴击伤害增加<color=#c54949>20%</color>"
	},
	{
		413,
		"暴伤",
		"暴击伤害增加<color=#c54949>30%</color>"
	},
	{
		414,
		"暴伤",
		"暴击伤害增加<color=#c54949>40%</color>"
	},
	{
		415,
		"暴伤",
		"暴击伤害增加<color=#c54949>50%</color>"
	},
	{
		501,
		"攻击降气",
		"攻击后，降低目标精灵<color=#c54949>10</color>点气势"
	},
	{
		502,
		"攻击降气",
		"攻击后，降低目标精灵<color=#c54949>20</color>点气势"
	},
	{
		503,
		"攻击降气",
		"攻击后，降低目标精灵<color=#c54949>30</color>点气势"
	},
	{
		504,
		"攻击降气",
		"攻击后，降低目标精灵<color=#c54949>40</color>点气势"
	},
	{
		505,
		"攻击降气",
		"攻击后，降低目标精灵<color=#c54949>50</color>点气势"
	},
	{
		511,
		"受击降气",
		"受击时，降低目标精灵<color=#c54949>4</color>点气势"
	},
	{
		512,
		"受击降气",
		"受击时，降低目标精灵<color=#c54949>8</color>点气势"
	},
	{
		513,
		"受击降气",
		"受击时，降低目标精灵<color=#c54949>12</color>点气势"
	},
	{
		514,
		"受击降气",
		"受击时，降低目标精灵<color=#c54949>16</color>点气势"
	},
	{
		515,
		"受击降气",
		"受击时，降低目标精灵<color=#c54949>20</color>点气势"
	},
	{
		601,
		"巫毒",
		"出手后，使目标精灵生命恢复效果降低<color=#c54949>20%</color>（1回合）"
	},
	{
		602,
		"巫毒",
		"出手后，使目标精灵生命恢复效果降低<color=#c54949>40%</color>（1回合）"
	},
	{
		603,
		"巫毒",
		"出手后，使目标精灵生命恢复效果降低<color=#c54949>60%</color>（1回合）"
	},
	{
		604,
		"巫毒",
		"出手后，使目标精灵生命恢复效果降低<color=#c54949>80%</color>（1回合）"
	},
	{
		605,
		"巫毒",
		"出手后，使目标精灵生命恢复效果降低<color=#c54949>100%</color>（1回合）"
	},
	{
		611,
		"医疗专家",
		"进入战斗时，永久提升己阵精灵生命恢复效果<color=#c54949>60%</color>"
	},
	{
		612,
		"医疗专家",
		"进入战斗时，永久提升己阵精灵生命恢复效果<color=#c54949>120%</color>"
	},
	{
		613,
		"医疗专家",
		"进入战斗时，永久提升己阵精灵生命恢复效果<color=#c54949>180%</color>"
	},
	{
		614,
		"医疗专家",
		"进入战斗时，永久提升己阵精灵生命恢复效果<color=#c54949>240%</color>"
	},
	{
		615,
		"医疗专家",
		"进入战斗时，永久提升己阵精灵生命恢复效果<color=#c54949>300%</color>"
	},
	{
		701,
		"凝神一击",
		"超杀伤害增加<color=#c54949>30%</color>"
	},
	{
		702,
		"凝神一击",
		"超杀伤害增加<color=#c54949>60%</color>"
	},
	{
		703,
		"凝神一击",
		"超杀伤害增加<color=#c54949>90%</color>"
	},
	{
		704,
		"凝神一击",
		"超杀伤害增加<color=#c54949>120%</color>"
	},
	{
		705,
		"凝神一击",
		"超杀伤害增加<color=#c54949>150%</color>"
	},
	{
		711,
		"普通一击",
		"普攻伤害增加<color=#c54949>50%</color>"
	},
	{
		712,
		"普通一击",
		"普攻伤害增加<color=#c54949>100%</color>"
	},
	{
		713,
		"普通一击",
		"普攻伤害增加<color=#c54949>150%</color>"
	},
	{
		714,
		"普通一击",
		"普攻伤害增加<color=#c54949>200%</color>"
	},
	{
		715,
		"普通一击",
		"普攻伤害增加<color=#c54949>250%</color>"
	},
	{
		801,
		"附伤",
		"攻击后，对目标精灵额外造成攻击伤害*<color=#c54949>15%</color>的伤害"
	},
	{
		802,
		"附伤",
		"攻击后，对目标精灵额外造成攻击伤害*<color=#c54949>30%</color>的伤害"
	},
	{
		803,
		"附伤",
		"攻击后，对目标精灵额外造成攻击伤害*<color=#c54949>45%</color>的伤害"
	},
	{
		804,
		"附伤",
		"攻击后，对目标精灵额外造成攻击伤害*<color=#c54949>60%</color>的伤害"
	},
	{
		805,
		"附伤",
		"攻击后，对目标精灵额外造成攻击伤害*<color=#c54949>75%</color>的伤害"
	},
	{
		811,
		"吸血",
		"攻击时吸血<color=#c54949>15%</color>"
	},
	{
		812,
		"吸血",
		"攻击时吸血<color=#c54949>30%</color>"
	},
	{
		813,
		"吸血",
		"攻击时吸血<color=#c54949>45%</color>"
	},
	{
		814,
		"吸血",
		"攻击时吸血<color=#c54949>60%</color>"
	},
	{
		815,
		"吸血",
		"攻击时吸血<color=#c54949>75%</color>"
	},
	{
		901,
		"齐射",
		"群攻伤害增加<color=#c54949>30%</color>"
	},
	{
		902,
		"齐射",
		"群攻伤害增加<color=#c54949>60%</color>"
	},
	{
		903,
		"齐射",
		"群攻伤害增加<color=#c54949>90%</color>"
	},
	{
		904,
		"齐射",
		"群攻伤害增加<color=#c54949>120%</color>"
	},
	{
		905,
		"齐射",
		"群攻伤害增加<color=#c54949>150%</color>"
	},
	{
		911,
		"暴伤",
		"暴击伤害增加<color=#c54949>30%</color>"
	},
	{
		912,
		"暴伤",
		"暴击伤害增加<color=#c54949>60%</color>"
	},
	{
		913,
		"暴伤",
		"暴击伤害增加<color=#c54949>90%</color>"
	},
	{
		914,
		"暴伤",
		"暴击伤害增加<color=#c54949>120%</color>"
	},
	{
		915,
		"暴伤",
		"暴击伤害增加<color=#c54949>150%</color>"
	},
	{
		1001,
		"攻击降气",
		"攻击后，降低目标精灵<color=#c54949>30</color>点气势"
	},
	{
		1002,
		"攻击降气",
		"攻击后，降低目标精灵<color=#c54949>60</color>点气势"
	},
	{
		1003,
		"攻击降气",
		"攻击后，降低目标精灵<color=#c54949>90</color>点气势"
	},
	{
		1004,
		"攻击降气",
		"攻击后，降低目标精灵<color=#c54949>120</color>点气势"
	},
	{
		1005,
		"攻击降气",
		"攻击后，降低目标精灵<color=#c54949>150</color>点气势"
	},
	{
		1011,
		"受击降气",
		"受击时，降低目标精灵<color=#c54949>15</color>点气势"
	},
	{
		1012,
		"受击降气",
		"受击时，降低目标精灵<color=#c54949>30</color>点气势"
	},
	{
		1013,
		"受击降气",
		"受击时，降低目标精灵<color=#c54949>45</color>点气势"
	},
	{
		1014,
		"受击降气",
		"受击时，降低目标精灵<color=#c54949>60</color>点气势"
	},
	{
		1015,
		"受击降气",
		"受击时，降低目标精灵<color=#c54949>75</color>点气势"
	}
}
local t_xiu_nuo_brotherhood_buff = {
	[101] = dataList[1],
	[102] = dataList[2],
	[103] = dataList[3],
	[104] = dataList[4],
	[105] = dataList[5],
	[111] = dataList[6],
	[112] = dataList[7],
	[113] = dataList[8],
	[114] = dataList[9],
	[115] = dataList[10],
	[201] = dataList[11],
	[202] = dataList[12],
	[203] = dataList[13],
	[204] = dataList[14],
	[205] = dataList[15],
	[211] = dataList[16],
	[212] = dataList[17],
	[213] = dataList[18],
	[214] = dataList[19],
	[215] = dataList[20],
	[301] = dataList[21],
	[302] = dataList[22],
	[303] = dataList[23],
	[304] = dataList[24],
	[305] = dataList[25],
	[311] = dataList[26],
	[312] = dataList[27],
	[313] = dataList[28],
	[314] = dataList[29],
	[315] = dataList[30],
	[401] = dataList[31],
	[402] = dataList[32],
	[403] = dataList[33],
	[404] = dataList[34],
	[405] = dataList[35],
	[411] = dataList[36],
	[412] = dataList[37],
	[413] = dataList[38],
	[414] = dataList[39],
	[415] = dataList[40],
	[501] = dataList[41],
	[502] = dataList[42],
	[503] = dataList[43],
	[504] = dataList[44],
	[505] = dataList[45],
	[511] = dataList[46],
	[512] = dataList[47],
	[513] = dataList[48],
	[514] = dataList[49],
	[515] = dataList[50],
	[601] = dataList[51],
	[602] = dataList[52],
	[603] = dataList[53],
	[604] = dataList[54],
	[605] = dataList[55],
	[611] = dataList[56],
	[612] = dataList[57],
	[613] = dataList[58],
	[614] = dataList[59],
	[615] = dataList[60],
	[701] = dataList[61],
	[702] = dataList[62],
	[703] = dataList[63],
	[704] = dataList[64],
	[705] = dataList[65],
	[711] = dataList[66],
	[712] = dataList[67],
	[713] = dataList[68],
	[714] = dataList[69],
	[715] = dataList[70],
	[801] = dataList[71],
	[802] = dataList[72],
	[803] = dataList[73],
	[804] = dataList[74],
	[805] = dataList[75],
	[811] = dataList[76],
	[812] = dataList[77],
	[813] = dataList[78],
	[814] = dataList[79],
	[815] = dataList[80],
	[901] = dataList[81],
	[902] = dataList[82],
	[903] = dataList[83],
	[904] = dataList[84],
	[905] = dataList[85],
	[911] = dataList[86],
	[912] = dataList[87],
	[913] = dataList[88],
	[914] = dataList[89],
	[915] = dataList[90],
	[1001] = dataList[91],
	[1002] = dataList[92],
	[1003] = dataList[93],
	[1004] = dataList[94],
	[1005] = dataList[95],
	[1011] = dataList[96],
	[1012] = dataList[97],
	[1013] = dataList[98],
	[1014] = dataList[99],
	[1015] = dataList[100]
}

t_xiu_nuo_brotherhood_buff.dataList = dataList

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

return t_xiu_nuo_brotherhood_buff
