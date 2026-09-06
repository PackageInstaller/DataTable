-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ashe_challenge_select_buff.lua

module("logicconfig.config.t_ashe_challenge_select_buff", package.seeall)

local title = {
	buffDesc = 6,
	buffType = 3,
	buffId = 2,
	buffName = 4,
	selectBuffPlanId = 1,
	iconName = 5
}
local dataList = {
	{
		1,
		101,
		1,
		"伤害反弹",
		"icon_expedition_yadao01",
		"己方精灵反弹10%的伤害给攻击者"
	},
	{
		1,
		102,
		1,
		"魔伤减免",
		"icon_expedition_guijia01",
		"己方精灵魔伤减免+10%"
	},
	{
		1,
		103,
		1,
		"提升格挡",
		"icon_expedition_zengshang",
		"己方精灵格挡率+20%"
	},
	{
		1,
		104,
		1,
		"提升闪避",
		"icon_expedition_zhansha",
		"己方精灵闪避率+15%"
	},
	{
		1,
		105,
		1,
		"攻击吸血",
		"icon_expedition_xueliang",
		"己方精灵攻击吸血+10%"
	},
	{
		1,
		106,
		1,
		"防御加成",
		"icon_expedition_baotou",
		"己方精灵防御加成+15%"
	},
	{
		1,
		201,
		2,
		"余烬焱火",
		"icon_expedition_chaoshazhuiji",
		"离阳龙脉·敖九出手时25%概率额外出手"
	},
	{
		1,
		202,
		2,
		"命运轮转",
		"icon_expedition_huishou",
		"王者次元龙暴击率+30%"
	},
	{
		1,
		203,
		2,
		"传说见闻",
		"icon_expedition_changsheng",
		"轮回之神·正理每回合回复20%血量"
	},
	{
		1,
		204,
		2,
		"复苏之光",
		"icon_expedition_chixue01",
		"神启修尔全属性加成+25%"
	},
	{
		1,
		205,
		2,
		"糖果炸弹",
		"icon_expedition_mogongtisheng",
		"殛魔之主·安伤害加成+40%"
	},
	{
		1,
		206,
		2,
		"余烬焱火",
		"icon_expedition_chaoshazhuiji",
		"洛塔伤害加成+30%"
	},
	{
		1,
		207,
		2,
		"命运轮转",
		"icon_expedition_huishou",
		"神王·星洛出手时25%概率额外出手"
	},
	{
		1,
		208,
		2,
		"传说见闻",
		"icon_expedition_changsheng",
		"暗祭·达克诺斯全属性加成+25%"
	},
	{
		1,
		209,
		2,
		"复苏之光",
		"icon_expedition_chixue01",
		"赫魔莉·青骨超杀伤害加成+30%"
	},
	{
		2,
		101,
		1,
		"伤害反弹",
		"icon_expedition_yadao01",
		"己方精灵反弹10%的伤害给攻击者"
	},
	{
		2,
		102,
		1,
		"魔伤减免",
		"icon_expedition_guijia01",
		"己方精灵魔伤减免+10%"
	},
	{
		2,
		103,
		1,
		"提升格挡",
		"icon_expedition_zengshang",
		"己方精灵格挡率+20%"
	},
	{
		2,
		104,
		1,
		"提升闪避",
		"icon_expedition_zhansha",
		"己方精灵闪避率+15%"
	},
	{
		2,
		105,
		1,
		"攻击吸血",
		"icon_expedition_xueliang",
		"己方精灵攻击吸血+10%"
	},
	{
		2,
		106,
		1,
		"防御加成",
		"icon_expedition_baotou",
		"己方精灵防御加成+15%"
	},
	{
		2,
		201,
		2,
		"余烬焱火",
		"icon_expedition_chaoshazhuiji",
		"旧日行者·悟空出手时25%概率额外出手"
	},
	{
		2,
		202,
		2,
		"命运轮转",
		"icon_expedition_huishou",
		"力量神祇·龙炎暴击率+30%"
	},
	{
		2,
		203,
		2,
		"传说见闻",
		"icon_expedition_changsheng",
		"圣骑·炎神每回合回复20%血量"
	},
	{
		2,
		204,
		2,
		"复苏之光",
		"icon_expedition_chixue01",
		"神曜莲火·末炎全属性加成+25%"
	},
	{
		2,
		205,
		2,
		"糖果炸弹",
		"icon_expedition_mogongtisheng",
		"烈焰·无烬圣龙伤害加成+40%"
	},
	{
		2,
		206,
		2,
		"余烬焱火",
		"icon_expedition_chaoshazhuiji",
		"无间魔焰·瞳伤害加成+30%"
	},
	{
		2,
		207,
		2,
		"命运轮转",
		"icon_expedition_huishou",
		"记忆之神·弥梦离出手时25%概率额外出手"
	},
	{
		2,
		208,
		2,
		"传说见闻",
		"icon_expedition_changsheng",
		"赤龙银甲·火次元全属性加成+25%"
	},
	{
		2,
		209,
		2,
		"复苏之光",
		"icon_expedition_chixue01",
		"迷魇之主·维蕾塔超杀伤害加成+30%"
	},
	{
		3,
		101,
		1,
		"伤害反弹",
		"icon_expedition_yadao01",
		"己方精灵反弹10%的伤害给攻击者"
	},
	{
		3,
		102,
		1,
		"魔伤减免",
		"icon_expedition_guijia01",
		"己方精灵魔伤减免+10%"
	},
	{
		3,
		103,
		1,
		"提升格挡",
		"icon_expedition_zengshang",
		"己方精灵格挡率+20%"
	},
	{
		3,
		104,
		1,
		"提升闪避",
		"icon_expedition_zhansha",
		"己方精灵闪避率+15%"
	},
	{
		3,
		105,
		1,
		"攻击吸血",
		"icon_expedition_xueliang",
		"己方精灵攻击吸血+10%"
	},
	{
		3,
		106,
		1,
		"防御加成",
		"icon_expedition_baotou",
		"己方精灵防御加成+15%"
	},
	{
		3,
		201,
		2,
		"余烬焱火",
		"icon_expedition_chaoshazhuiji",
		"神曜时隙·诺亚出手时25%概率额外出手"
	},
	{
		3,
		202,
		2,
		"命运轮转",
		"icon_expedition_huishou",
		"昼夜王者·诺雅暴击率+30%"
	},
	{
		3,
		203,
		2,
		"传说见闻",
		"icon_expedition_changsheng",
		"神曜寰宇·黄金圣龙每回合回复20%血量"
	},
	{
		3,
		204,
		2,
		"复苏之光",
		"icon_expedition_chixue01",
		"神曜烈阳·光明王全属性加成+25%"
	},
	{
		3,
		205,
		2,
		"糖果炸弹",
		"icon_expedition_mogongtisheng",
		"无上战主·无敌伤害加成+40%"
	},
	{
		3,
		206,
		2,
		"余烬焱火",
		"icon_expedition_chaoshazhuiji",
		"神曜苍穹·圣光飞龙伤害加成+30%"
	},
	{
		3,
		207,
		2,
		"命运轮转",
		"icon_expedition_huishou",
		"神曜万象·次元龙尊出手时25%概率额外出手"
	},
	{
		3,
		208,
		2,
		"传说见闻",
		"icon_expedition_changsheng",
		"神崇王者·次元元全属性加成+25%"
	},
	{
		3,
		209,
		2,
		"复苏之光",
		"icon_expedition_chixue01",
		"育龙使·梅瑟超杀伤害加成+30%"
	},
	{
		4,
		101,
		1,
		"伤害反弹",
		"icon_expedition_yadao01",
		"己方精灵反弹10%的伤害给攻击者"
	},
	{
		4,
		102,
		1,
		"魔伤减免",
		"icon_expedition_guijia01",
		"己方精灵魔伤减免+10%"
	},
	{
		4,
		103,
		1,
		"提升格挡",
		"icon_expedition_zengshang",
		"己方精灵格挡率+20%"
	},
	{
		4,
		104,
		1,
		"提升闪避",
		"icon_expedition_zhansha",
		"己方精灵闪避率+15%"
	},
	{
		4,
		105,
		1,
		"攻击吸血",
		"icon_expedition_xueliang",
		"己方精灵攻击吸血+10%"
	},
	{
		4,
		106,
		1,
		"防御加成",
		"icon_expedition_baotou",
		"己方精灵防御加成+15%"
	},
	{
		4,
		201,
		2,
		"余烬焱火",
		"icon_expedition_chaoshazhuiji",
		"神曜殛主·安出手时25%概率额外出手"
	},
	{
		4,
		202,
		2,
		"命运轮转",
		"icon_expedition_huishou",
		"神曜时空·龙尊暴击率+30%"
	},
	{
		4,
		203,
		2,
		"传说见闻",
		"icon_expedition_changsheng",
		"殛魔之主·安每回合回复20%血量"
	},
	{
		4,
		204,
		2,
		"复苏之光",
		"icon_expedition_chixue01",
		"花语·伊丽莎白全属性加成+25%"
	},
	{
		4,
		205,
		2,
		"糖果炸弹",
		"icon_expedition_mogongtisheng",
		"无限时空·龙尊伤害加成+40%"
	}
}
local t_ashe_challenge_select_buff = {
	{
		[101] = dataList[1],
		[102] = dataList[2],
		[103] = dataList[3],
		[104] = dataList[4],
		[105] = dataList[5],
		[106] = dataList[6],
		[201] = dataList[7],
		[202] = dataList[8],
		[203] = dataList[9],
		[204] = dataList[10],
		[205] = dataList[11],
		[206] = dataList[12],
		[207] = dataList[13],
		[208] = dataList[14],
		[209] = dataList[15]
	},
	{
		[101] = dataList[16],
		[102] = dataList[17],
		[103] = dataList[18],
		[104] = dataList[19],
		[105] = dataList[20],
		[106] = dataList[21],
		[201] = dataList[22],
		[202] = dataList[23],
		[203] = dataList[24],
		[204] = dataList[25],
		[205] = dataList[26],
		[206] = dataList[27],
		[207] = dataList[28],
		[208] = dataList[29],
		[209] = dataList[30]
	},
	{
		[101] = dataList[31],
		[102] = dataList[32],
		[103] = dataList[33],
		[104] = dataList[34],
		[105] = dataList[35],
		[106] = dataList[36],
		[201] = dataList[37],
		[202] = dataList[38],
		[203] = dataList[39],
		[204] = dataList[40],
		[205] = dataList[41],
		[206] = dataList[42],
		[207] = dataList[43],
		[208] = dataList[44],
		[209] = dataList[45]
	},
	{
		[101] = dataList[46],
		[102] = dataList[47],
		[103] = dataList[48],
		[104] = dataList[49],
		[105] = dataList[50],
		[106] = dataList[51],
		[201] = dataList[52],
		[202] = dataList[53],
		[203] = dataList[54],
		[204] = dataList[55],
		[205] = dataList[56]
	}
}

t_ashe_challenge_select_buff.dataList = dataList

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

return t_ashe_challenge_select_buff
