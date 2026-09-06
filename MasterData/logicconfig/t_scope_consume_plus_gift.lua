-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_scope_consume_plus_gift.lua

module("logicconfig.config.t_scope_consume_plus_gift", package.seeall)

local title = {
	iconJumpTo1 = 16,
	jumpTo1 = 15,
	goodsId2 = 13,
	prizeId = 2,
	petId = 9,
	posSkill = 10,
	iconJumpTo2 = 20,
	gift = 4,
	showEff = 6,
	goodsId = 11,
	activityId = 1,
	descLevel = 8,
	nameGoods2 = 14,
	jumpTo2 = 19,
	nameGoods = 12,
	posJumpTo1 = 17,
	tipJumpTo2 = 21,
	consumeMoney = 3,
	tipJumpTo1 = 18,
	BG = 5,
	iconLevel = 7
}
local dataList = {
	{
		324001,
		1,
		600,
		"",
		"board_sc_01",
		"fx_ui_leichong06_shouchong",
		"icon_xixi",
		"茜茜/火系传说之魂",
		10309,
		{
			50,
			30
		},
		0,
		"",
		0,
		"",
		"",
		"",
		nil,
		"",
		"mibao#GoldenDiamondCard",
		"icon_jz_jinzuan",
		"金钻特权"
	},
	{
		324001,
		2,
		3000,
		"4:90206:4#4:36:20#4:510132:1#4:30003:640#8:1:5000000",
		"board_sc_11",
		"fx_ui_leichong30_shouchong",
		"icon_lb_shouchong",
		"神唤橙装豪礼",
		0,
		nil,
		0,
		"",
		0,
		"",
		"",
		"",
		nil,
		"",
		"mibao#MonthCard2022",
		"icon_tqyueka",
		"月卡"
	},
	{
		324001,
		3,
		6000,
		"4:90269:1#4:36:30#4:510133:1#4:503:1000#8:1:5000000",
		"board_sc_12",
		"fx_ui_leichong68_shouchong",
		"icon_jisuxingshen",
		"神唤星神豪礼",
		0,
		nil,
		0,
		"",
		0,
		"",
		"",
		"",
		nil,
		"",
		"mibao#ResMonthCard2022",
		"icon_tqyueka",
		"资源月卡"
	},
	{
		324001,
		4,
		9800,
		"4:90127:1#4:84420:6#4:90335:1#4:36:40#4:510134:1#60:1:120",
		"board_sc_13",
		"fx_ui_leichong98_shouchong",
		"icon_5nvpuhun01",
		"4女仆/传说之魂",
		0,
		nil,
		0,
		"",
		0,
		"",
		"mibao#WholeLifeCard",
		"icon_tequan",
		{
			366,
			145
		},
		"终身卡",
		"",
		"",
		""
	},
	{
		324002,
		1,
		600,
		"",
		"board_sc_01",
		"fx_ui_leichong06_shouchong",
		"icon_xixi",
		"茜茜/火系传说之魂",
		10309,
		{
			50,
			30
		},
		0,
		"",
		0,
		"",
		"",
		"",
		nil,
		"",
		"mibao#GoldenDiamondCard",
		"icon_jz_jinzuan",
		"金钻特权"
	},
	{
		324002,
		2,
		3000,
		"4:510402:100#4:90206:4#4:36:20#4:31:10",
		"board_sc_14",
		"fx_ui_leichong30_fw",
		"icon_lb_shouchong",
		"茜茜神曜材料",
		0,
		nil,
		0,
		"",
		0,
		"",
		"",
		"",
		nil,
		"",
		"mibao#MonthCard2024",
		"icon_tqyueka",
		"月卡"
	},
	{
		324002,
		3,
		6000,
		"4:90269:1#4:90127:1#4:36:20#4:90111:1",
		"board_sc_15",
		"fx_ui_leichong60_fw",
		"icon_5nvpuhun01",
		"4女仆/传说之魂",
		0,
		nil,
		0,
		"",
		0,
		"",
		"",
		"",
		nil,
		"",
		"mibao#ResMonthCard2024",
		"icon_tqyueka",
		"资源月卡"
	},
	{
		324002,
		4,
		9800,
		"4:510426:1#4:510403:1#4:36:30#4:510418:2",
		"board_sc_16",
		"fx_ui_leichong98_fw",
		"icon_zuoji_xiaohuoche",
		"茜茜满觉&坐骑自选",
		0,
		nil,
		0,
		"",
		0,
		"",
		"mibao#WholeLifeCard",
		"icon_tequan",
		{
			366,
			145
		},
		"终身卡",
		"",
		"",
		""
	},
	{
		324003,
		1,
		600,
		"",
		"board_sc_17",
		"fx_ui_30yuanshouchong_fenwei",
		"icon_xixi",
		"茜茜/诺亚/火系传说魂",
		0,
		nil,
		0,
		"",
		0,
		"",
		"",
		"",
		nil,
		"",
		"mibao#GoldenDiamondCard",
		"icon_jz_jinzuan",
		"金钻特权"
	},
	{
		324003,
		2,
		3000,
		"4:211:100#4:510402:100#4:90113:4#4:36:10",
		"board_sc_19",
		"fx_ui_30yuanshouchong_fenwei",
		"icon_lb_syxxny",
		"茜茜&诺亚神曜材料",
		0,
		nil,
		0,
		"",
		0,
		"",
		"",
		"",
		nil,
		"",
		"mibao#MonthCard2024",
		"icon_tqyueka",
		"月卡"
	},
	{
		324003,
		3,
		6000,
		"4:90269:1#4:510638:100#4:36:20#4:90111:1",
		"board_sc_18",
		"fx_ui_30yuanshouchong_fenwei",
		"icon_yqny_01",
		"诺亚源起材料&金星",
		0,
		nil,
		0,
		"",
		0,
		"",
		"",
		"",
		nil,
		"",
		"mibao#ResMonthCard2024",
		"icon_tqyueka",
		"资源月卡"
	},
	{
		324003,
		4,
		9800,
		"4:510666:1#4:510667:1#4:91044:2#4:36:30",
		"board_sc_20",
		"fx_ui_30yuanshouchong_fenwei",
		"icon_zuoji_xiaohuoche",
		"诺亚/茜茜满觉&坐骑",
		0,
		nil,
		0,
		"",
		0,
		"",
		"mibao#WholeLifeCard",
		"icon_tequan",
		{
			366,
			145
		},
		"终身卡",
		"",
		"",
		""
	}
}
local t_scope_consume_plus_gift = {
	[324001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	[324002] = {
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	[324003] = {
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_scope_consume_plus_gift.dataList = dataList

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

return t_scope_consume_plus_gift
