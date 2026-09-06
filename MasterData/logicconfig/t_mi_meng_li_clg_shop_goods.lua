-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mi_meng_li_clg_shop_goods.lua

module("logicconfig.config.t_mi_meng_li_clg_shop_goods", package.seeall)

local title = {
	goodsUsedClazz = 4,
	iconPath = 9,
	goodsUsedClazzParams = 5,
	desc = 8,
	shopId = 2,
	discountCostScore = 7,
	costScore = 6,
	goodsId = 3,
	activityId = 1
}
local dataList = {
	{
		417001,
		1,
		1,
		"DeadPetFullHp",
		"",
		40,
		32,
		"复活一只死亡的精灵",
		"icon/expevents/icon_expedition_chixue"
	},
	{
		417001,
		1,
		2,
		"PetFullHp",
		"",
		20,
		16,
		"单只残血精灵回满状态",
		"icon/expevents/icon_expedition_chixue01"
	},
	{
		417001,
		1,
		3,
		"GainBossBuff",
		"",
		300,
		240,
		"挑战最终关卡时：伤害+15%，暴击率、最大生命值+30%",
		"icon/expevents/icon_expedition_debuffzengshang"
	},
	{
		417001,
		1,
		4,
		"ImmunityTagBuff",
		"1",
		100,
		80,
		"获得免疫财富印记负面效果（立即生效）",
		"icon/challenge/board_anmimengli_01"
	},
	{
		417001,
		1,
		5,
		"ImmunityTagBuff",
		"2",
		100,
		80,
		"获得免疫生命印记负面效果（立即生效）",
		"icon/challenge/board_anmimengli_02"
	},
	{
		417001,
		1,
		6,
		"ImmunityTagBuff",
		"3",
		100,
		80,
		"获得免疫力量印记负面效果（立即生效）",
		"icon/challenge/board_anmimengli_03"
	},
	{
		417001,
		1,
		7,
		"ImmunityTagBuff",
		"4",
		100,
		80,
		"获得免疫勇气印记负面效果（立即生效）",
		"icon/challenge/board_anmimengli_04"
	},
	{
		417001,
		1,
		8,
		"ChangeTagNum",
		"",
		80,
		64,
		"更换一个当前的印记类型",
		"icon/expevents/icon_expedition_zhenying_03"
	},
	{
		417001,
		2,
		1,
		"DeadPetFullHp",
		"",
		40,
		32,
		"复活一只死亡的精灵",
		"icon/expevents/icon_expedition_zhenying_01"
	},
	{
		417001,
		2,
		2,
		"PetFullHp",
		"",
		20,
		16,
		"单只残血精灵回满状态",
		"icon/expevents/icon_expedition_chixue"
	},
	{
		417001,
		2,
		3,
		"ImmunityTagBuff",
		"1",
		100,
		80,
		"获得免疫财富印记负面效果（立即生效）",
		"icon/expevents/icon_expedition_chixue01"
	},
	{
		417001,
		2,
		4,
		"ImmunityTagBuff",
		"2",
		100,
		80,
		"获得免疫生命印记负面效果（立即生效）",
		"icon/challenge/board_anmimengli_01"
	},
	{
		417001,
		2,
		5,
		"ImmunityTagBuff",
		"3",
		100,
		80,
		"获得免疫力量印记负面效果（立即生效）",
		"icon/challenge/board_anmimengli_02"
	},
	{
		417001,
		2,
		6,
		"ImmunityTagBuff",
		"4",
		100,
		80,
		"获得免疫勇气印记负面效果（立即生效）",
		"icon/challenge/board_anmimengli_03"
	},
	{
		417001,
		2,
		7,
		"ChangeTagNum",
		"",
		100,
		80,
		"更换一个当前的印记类型",
		"icon/challenge/board_anmimengli_04"
	},
	{
		417001,
		2,
		8,
		"GainShopDiscount",
		"",
		150,
		120,
		"下个商店商品打八折",
		"icon/expevents/icon_expedition_zhenying_01"
	}
}
local t_mi_meng_li_clg_shop_goods = {
	[417001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5],
			dataList[6],
			dataList[7],
			dataList[8]
		},
		{
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12],
			dataList[13],
			dataList[14],
			dataList[15],
			dataList[16]
		}
	}
}

t_mi_meng_li_clg_shop_goods.dataList = dataList

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

return t_mi_meng_li_clg_shop_goods
