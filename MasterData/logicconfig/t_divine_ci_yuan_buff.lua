-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_ci_yuan_buff.lua

module("logicconfig.config.t_divine_ci_yuan_buff", package.seeall)

local title = {
	buffPlanId = 2,
	name = 4,
	buffId = 1,
	unLockStageId = 3,
	icon = 6,
	desc = 5
}
local dataList = {
	{
		1,
		1,
		0,
		"超杀降伤",
		"释放超杀后，降低下次受到的伤害20%",
		"icon_expedition_chaoshahoumianyi"
	},
	{
		2,
		1,
		0,
		"意志坚强",
		"受到非直接伤害减少50%",
		"icon_expedition_shoujibingdong"
	},
	{
		3,
		1,
		0,
		"格挡",
		"格挡率+20%",
		"icon_expedition_wufangqishi"
	},
	{
		4,
		1,
		0,
		"双刃剑",
		"技能命中目标后，额外造成攻击20%的伤害",
		"icon_expedition_jingzhun01"
	},
	{
		5,
		1,
		0,
		"超杀增幅",
		"超杀伤害+20%",
		"icon_expedition_shanghaitisheng"
	},
	{
		6,
		1,
		0,
		"复苏之风",
		"每回合结束时，恢复8%的生命",
		"icon_expedition_chixue01"
	},
	{
		7,
		1,
		0,
		"残血收割",
		"攻击50%以下生命的目标时，伤害+25%",
		"icon_expedition_ganran"
	},
	{
		8,
		1,
		0,
		"穿透护盾",
		"对带有护盾的目标伤害+25%",
		"icon_expedition_wushifangyu"
	},
	{
		9,
		2,
		0,
		"超杀降伤",
		"己阵受到的群攻伤害降低20%",
		"icon_expedition_chaoshahoumianyi"
	},
	{
		10,
		3,
		0,
		"意志坚强",
		"己阵造成的群攻伤害增加20%",
		"icon_expedition_shoujibingdong"
	},
	{
		11,
		3,
		0,
		"格挡",
		"己阵超杀后免疫1次攻击",
		"icon_expedition_wufangqishi"
	},
	{
		12,
		3,
		0,
		"双刃剑",
		"己阵超杀后眩晕敌阵气势最高的目标",
		"icon_expedition_jingzhun01"
	},
	{
		13,
		3,
		0,
		"超杀增幅",
		"敌阵命中率+20%",
		"icon_expedition_shanghaitisheng"
	},
	{
		14,
		4,
		0,
		"复苏之风",
		"敌阵暴击率+20%",
		"icon_expedition_chixue01"
	},
	{
		15,
		4,
		0,
		"残血收割",
		"敌阵闪避率+20%",
		"icon_expedition_ganran"
	},
	{
		16,
		4,
		0,
		"穿透护盾",
		"敌阵对受伤精灵伤害加深20%",
		"icon_expedition_wushifangyu"
	},
	{
		17,
		4,
		0,
		"超杀降伤",
		"敌阵攻击时降低目标20点气势",
		"icon_expedition_chaoshahoumianyi"
	},
	{
		18,
		4,
		0,
		"意志坚强",
		"敌阵受到的群攻伤害降低20%",
		"icon_expedition_shoujibingdong"
	},
	{
		19,
		4,
		0,
		"格挡",
		"敌阵造成的群攻伤害增加20%",
		"icon_expedition_wufangqishi"
	},
	{
		20,
		4,
		0,
		"双刃剑",
		"敌阵超杀后免疫1次攻击",
		"icon_expedition_jingzhun01"
	},
	{
		21,
		4,
		0,
		"超杀增幅",
		"敌阵超杀后眩晕己阵气势最高的目标",
		"icon_expedition_shanghaitisheng"
	},
	{
		22,
		4,
		0,
		"复苏之风",
		"本层关卡无转移效果",
		"icon_expedition_chixue01"
	},
	{
		23,
		5,
		0,
		"全属性增幅",
		"生命+10% 全属性+10%",
		"icon_expedition_shanghaitisheng"
	},
	{
		24,
		5,
		0,
		"全属性增幅",
		"生命+30% 全属性+30%",
		"icon_expedition_shanghaitisheng"
	},
	{
		25,
		5,
		0,
		"全属性增幅",
		"生命+50% 全属性+50%",
		"icon_expedition_shanghaitisheng"
	},
	{
		26,
		5,
		0,
		"全属性增幅",
		"生命+150% 全属性+150%",
		"icon_expedition_shanghaitisheng"
	},
	{
		27,
		5,
		0,
		"全属性增幅",
		"生命+300% 全属性+300%",
		"icon_expedition_shanghaitisheng"
	},
	{
		28,
		5,
		0,
		"全属性增幅",
		"生命+500% 全属性+500%",
		"icon_expedition_shanghaitisheng"
	},
	{
		29,
		5,
		0,
		"全属性增幅",
		"生命+800% 全属性+800%",
		"icon_expedition_shanghaitisheng"
	}
}
local t_divine_ci_yuan_buff = {
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
	dataList[27],
	dataList[28],
	dataList[29]
}

t_divine_ci_yuan_buff.dataList = dataList

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

return t_divine_ci_yuan_buff
