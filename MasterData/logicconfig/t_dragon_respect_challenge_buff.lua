-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_respect_challenge_buff.lua

module("logicconfig.config.t_dragon_respect_challenge_buff", package.seeall)

local title = {
	name = 3,
	buffId = 2,
	icon = 5,
	planId = 1,
	desc = 4
}
local dataList = {
	{
		1101,
		1,
		"治疗之风",
		"每个大回合结束恢复10%生命值",
		"icon_expedition_chixue01"
	},
	{
		1101,
		2,
		"无视防御",
		"无视目标20%防御",
		"icon_expedition_wushifangyu"
	},
	{
		1101,
		3,
		"元素克制",
		"克制伤害+15%",
		"icon_expedition_kezhizengqiang"
	},
	{
		1101,
		4,
		"护盾穿击",
		"对带有护盾的目标伤害+20%",
		"icon_expedition_yisun"
	},
	{
		1101,
		5,
		"群攻",
		"群攻伤害+15%",
		"icon_expedition_qungongtisheng"
	},
	{
		1101,
		6,
		"致命攻击",
		"对半血以下的目标伤害+15%",
		"icon_expedition_shayi01"
	},
	{
		1101,
		7,
		"举盾",
		"格挡率+15%",
		"icon_expedition_chushouqianjianshang"
	},
	{
		1101,
		8,
		"引爆",
		"敌方精灵死亡时，对相邻精灵造成20%最大生命值伤害",
		"icon_expedition_chaoshazhuiji"
	},
	{
		1102,
		9,
		"治疗之风",
		"每个大回合结束恢复10%生命值",
		"icon_expedition_chixue01"
	},
	{
		1102,
		10,
		"无视防御",
		"无视目标20%防御",
		"icon_expedition_wushifangyu"
	},
	{
		1102,
		11,
		"元素克制",
		"克制伤害+15%",
		"icon_expedition_kezhizengqiang"
	},
	{
		1102,
		12,
		"护盾穿击",
		"对带有护盾的目标伤害+20%",
		"icon_expedition_yisun"
	},
	{
		1102,
		13,
		"群攻",
		"群攻伤害+15%",
		"icon_expedition_qungongtisheng"
	},
	{
		1102,
		14,
		"致命攻击",
		"对半血以下的目标伤害+15%",
		"icon_expedition_shayi01"
	},
	{
		1102,
		15,
		"引爆",
		"敌方精灵死亡时，对相邻精灵造成20%最大生命值伤害",
		"icon_expedition_chaoshazhuiji"
	},
	{
		1102,
		16,
		"摧毁",
		"无烬圣龙的攻击摧毁目标60%防御",
		"icon_expedition_yisun01"
	},
	{
		1103,
		17,
		"治疗之风",
		"每个大回合结束恢复10%生命值",
		"icon_expedition_chixue01"
	},
	{
		1103,
		18,
		"无视防御",
		"无视目标20%防御",
		"icon_expedition_wushifangyu"
	},
	{
		1103,
		19,
		"元素克制",
		"克制伤害+15%",
		"icon_expedition_kezhizengqiang"
	},
	{
		1103,
		20,
		"护盾穿击",
		"对带有护盾的目标伤害+20%",
		"icon_expedition_yisun"
	},
	{
		1103,
		21,
		"群攻",
		"群攻伤害+15%",
		"icon_expedition_qungongtisheng"
	},
	{
		1103,
		22,
		"致命攻击",
		"对半血以下的目标伤害+15%",
		"icon_expedition_shayi01"
	},
	{
		1103,
		23,
		"引爆",
		"敌方精灵死亡时，对相邻精灵造成20%最大生命值伤害",
		"icon_expedition_chaoshazhuiji"
	},
	{
		1103,
		24,
		"无烬之火",
		"无烬圣龙爆炸附带强力灼烧效果（2回合）",
		"icon_expedition_zengshang"
	},
	{
		1201,
		25,
		"治疗之风",
		"每个大回合结束恢复10%生命值",
		"icon_expedition_chixue01"
	},
	{
		1201,
		26,
		"无视防御",
		"无视目标20%防御",
		"icon_expedition_wushifangyu"
	},
	{
		1201,
		27,
		"元素克制",
		"克制伤害+15%",
		"icon_expedition_kezhizengqiang"
	},
	{
		1201,
		28,
		"护盾穿击",
		"对带有护盾的目标伤害+20%",
		"icon_expedition_yisun"
	},
	{
		1201,
		29,
		"群攻",
		"群攻伤害+15%",
		"icon_expedition_qungongtisheng"
	},
	{
		1201,
		30,
		"致命攻击",
		"对半血以下的目标伤害+15%",
		"icon_expedition_shayi01"
	},
	{
		1201,
		31,
		"举盾",
		"格挡率+15%",
		"icon_expedition_chushouqianjianshang"
	},
	{
		1201,
		32,
		"引爆",
		"敌方精灵死亡时，对相邻精灵造成20%最大生命值伤害",
		"icon_expedition_chaoshazhuiji"
	},
	{
		1202,
		33,
		"治疗之风",
		"每个大回合结束恢复10%生命值",
		"icon_expedition_chixue01"
	},
	{
		1202,
		34,
		"无视防御",
		"无视目标20%防御",
		"icon_expedition_wushifangyu"
	},
	{
		1202,
		35,
		"元素克制",
		"克制伤害+15%",
		"icon_expedition_kezhizengqiang"
	},
	{
		1202,
		36,
		"护盾穿击",
		"对带有护盾的目标伤害+20%",
		"icon_expedition_yisun"
	},
	{
		1202,
		37,
		"群攻",
		"群攻伤害+15%",
		"icon_expedition_qungongtisheng"
	},
	{
		1202,
		38,
		"致命攻击",
		"对半血以下的目标伤害+15%",
		"icon_expedition_shayi01"
	},
	{
		1202,
		39,
		"引爆",
		"敌方精灵死亡时，对相邻精灵造成20%最大生命值伤害",
		"icon_expedition_chaoshazhuiji"
	},
	{
		1202,
		40,
		"能量吸收",
		"超神圣龙的攻击将吸收目标25点气势",
		"icon_expedition_bianyi01"
	},
	{
		1203,
		41,
		"治疗之风",
		"每个大回合结束恢复10%生命值",
		"icon_expedition_chixue01"
	},
	{
		1203,
		42,
		"无视防御",
		"无视目标20%防御",
		"icon_expedition_wushifangyu"
	},
	{
		1203,
		43,
		"元素克制",
		"克制伤害+15%",
		"icon_expedition_kezhizengqiang"
	},
	{
		1203,
		44,
		"护盾穿击",
		"对带有护盾的目标伤害+20%",
		"icon_expedition_yisun"
	},
	{
		1203,
		45,
		"群攻",
		"群攻伤害+15%",
		"icon_expedition_qungongtisheng"
	},
	{
		1203,
		46,
		"致命攻击",
		"对半血以下的目标伤害+15%",
		"icon_expedition_shayi01"
	},
	{
		1203,
		47,
		"引爆",
		"敌方精灵死亡时，对相邻精灵造成20%最大生命值伤害",
		"icon_expedition_chaoshazhuiji"
	},
	{
		1203,
		48,
		"终极时刻",
		"超神圣龙超杀伤害+40%",
		"icon_expedition_zhansha"
	},
	{
		1301,
		49,
		"治疗之风",
		"每个大回合结束恢复10%生命值",
		"icon_expedition_chixue01"
	},
	{
		1301,
		50,
		"无视防御",
		"无视目标20%防御",
		"icon_expedition_wushifangyu"
	},
	{
		1301,
		51,
		"元素克制",
		"克制伤害+15%",
		"icon_expedition_kezhizengqiang"
	},
	{
		1301,
		52,
		"战意锋芒",
		"每次出手后，伤害+4%",
		"icon_expedition_meicigongjizengshang"
	},
	{
		1301,
		53,
		"屏障",
		"每次出手后，获得最大生命值6%护盾，持续3回合",
		"icon_expedition_guijia01"
	},
	{
		1301,
		54,
		"致命攻击",
		"对半血以下的目标伤害+15%",
		"icon_expedition_shayi01"
	},
	{
		1301,
		55,
		"举盾",
		"格挡率+15%",
		"icon_expedition_chushouqianjianshang"
	},
	{
		1301,
		56,
		"引爆",
		"敌方精灵死亡时，对相邻精灵造成20%最大生命值伤害",
		"icon_expedition_chaoshazhuiji"
	},
	{
		1302,
		57,
		"治疗之风",
		"每个大回合结束恢复10%生命值",
		"icon_expedition_chixue01"
	},
	{
		1302,
		58,
		"无视防御",
		"无视目标20%防御",
		"icon_expedition_wushifangyu"
	},
	{
		1302,
		59,
		"元素克制",
		"克制伤害+15%",
		"icon_expedition_kezhizengqiang"
	},
	{
		1302,
		60,
		"战意锋芒",
		"每次出手后，伤害+4%",
		"icon_expedition_meicigongjizengshang"
	},
	{
		1302,
		61,
		"屏障",
		"每次出手后，获得最大生命值6%护盾，持续3回合",
		"icon_expedition_guijia01"
	},
	{
		1302,
		62,
		"致命攻击",
		"对半血以下的目标伤害+15%",
		"icon_expedition_shayi01"
	},
	{
		1302,
		63,
		"引爆",
		"敌方精灵死亡时，对相邻精灵造成20%最大生命值伤害",
		"icon_expedition_chaoshazhuiji"
	},
	{
		1302,
		64,
		"消除意志",
		"秩序圣龙的攻击减少目标30点气势",
		"icon_expedition_shenqi_shui"
	},
	{
		1303,
		65,
		"治疗之风",
		"每个大回合结束恢复10%生命值",
		"icon_expedition_chixue01"
	},
	{
		1303,
		66,
		"无视防御",
		"无视目标20%防御",
		"icon_expedition_wushifangyu"
	},
	{
		1303,
		67,
		"元素克制",
		"克制伤害+15%",
		"icon_expedition_kezhizengqiang"
	},
	{
		1303,
		68,
		"战意锋芒",
		"每次出手后，伤害+4%",
		"icon_expedition_meicigongjizengshang"
	},
	{
		1303,
		69,
		"屏障",
		"每次出手后，获得最大生命值6%护盾，持续3回合",
		"icon_expedition_guijia01"
	},
	{
		1303,
		70,
		"致命攻击",
		"对半血以下的目标伤害+15%",
		"icon_expedition_shayi01"
	},
	{
		1303,
		71,
		"引爆",
		"敌方精灵死亡时，对相邻精灵造成20%最大生命值伤害",
		"icon_expedition_chaoshazhuiji"
	},
	{
		1303,
		72,
		"自我愈合",
		"秩序圣龙每次出手时，恢复自身10%生命值",
		"icon_expedition_kaichanghuixue"
	}
}
local t_dragon_respect_challenge_buff = {
	[1101] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	[1102] = {
		[9] = dataList[9],
		[10] = dataList[10],
		[11] = dataList[11],
		[12] = dataList[12],
		[13] = dataList[13],
		[14] = dataList[14],
		[15] = dataList[15],
		[16] = dataList[16]
	},
	[1103] = {
		[17] = dataList[17],
		[18] = dataList[18],
		[19] = dataList[19],
		[20] = dataList[20],
		[21] = dataList[21],
		[22] = dataList[22],
		[23] = dataList[23],
		[24] = dataList[24]
	},
	[1201] = {
		[25] = dataList[25],
		[26] = dataList[26],
		[27] = dataList[27],
		[28] = dataList[28],
		[29] = dataList[29],
		[30] = dataList[30],
		[31] = dataList[31],
		[32] = dataList[32]
	},
	[1202] = {
		[33] = dataList[33],
		[34] = dataList[34],
		[35] = dataList[35],
		[36] = dataList[36],
		[37] = dataList[37],
		[38] = dataList[38],
		[39] = dataList[39],
		[40] = dataList[40]
	},
	[1203] = {
		[41] = dataList[41],
		[42] = dataList[42],
		[43] = dataList[43],
		[44] = dataList[44],
		[45] = dataList[45],
		[46] = dataList[46],
		[47] = dataList[47],
		[48] = dataList[48]
	},
	[1301] = {
		[49] = dataList[49],
		[50] = dataList[50],
		[51] = dataList[51],
		[52] = dataList[52],
		[53] = dataList[53],
		[54] = dataList[54],
		[55] = dataList[55],
		[56] = dataList[56]
	},
	[1302] = {
		[57] = dataList[57],
		[58] = dataList[58],
		[59] = dataList[59],
		[60] = dataList[60],
		[61] = dataList[61],
		[62] = dataList[62],
		[63] = dataList[63],
		[64] = dataList[64]
	},
	[1303] = {
		[65] = dataList[65],
		[66] = dataList[66],
		[67] = dataList[67],
		[68] = dataList[68],
		[69] = dataList[69],
		[70] = dataList[70],
		[71] = dataList[71],
		[72] = dataList[72]
	}
}

t_dragon_respect_challenge_buff.dataList = dataList

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

return t_dragon_respect_challenge_buff
