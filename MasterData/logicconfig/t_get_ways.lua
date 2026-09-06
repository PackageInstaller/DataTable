-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_get_ways.lua

module("logicconfig.config.t_get_ways", package.seeall)

local title = {
	openCondition = 4,
	name = 2,
	openTime = 5,
	jumpTo = 3,
	id = 1,
	res = 7,
	lockedTips = 6,
	isopen = 8
}
local dataList = {
	{
		1,
		"孵蛋",
		"ui#petegg",
		nil,
		"",
		"",
		"",
		true
	},
	{
		2,
		"领取麒麟",
		"ui#bonus#guideQilinView",
		nil,
		"",
		"",
		"",
		true
	},
	{
		3,
		"九宫八阵",
		"ch_npc#1031001",
		nil,
		"",
		"",
		"",
		true
	},
	{
		11,
		"挑战天炎朱雀",
		"ch_npc#1041001",
		nil,
		"",
		"",
		"",
		true
	},
	{
		12,
		"挑战玄武",
		"ch_npc#1041002",
		nil,
		"",
		"",
		"",
		true
	},
	{
		13,
		"挑战白虎",
		"ch_npc#1041003",
		nil,
		"",
		"",
		"",
		true
	},
	{
		14,
		"挑战青龙",
		"ch_npc#1041004",
		nil,
		"",
		"",
		"",
		true
	},
	{
		101,
		"捕捉三叶兽",
		"catch#2",
		nil,
		"",
		"",
		"",
		true
	},
	{
		102,
		"捕捉海布蓝",
		"catch#3",
		nil,
		"",
		"",
		"",
		true
	},
	{
		103,
		"捕捉咕噜牦牛",
		"catch#4",
		nil,
		"",
		"",
		"",
		true
	},
	{
		104,
		"捕捉怒火蜘蛛",
		"catch#5",
		nil,
		"",
		"",
		"",
		true
	},
	{
		105,
		"捕捉刺锥蝎",
		"catch#6",
		nil,
		"",
		"",
		"",
		true
	},
	{
		111,
		"捕捉水怪怪",
		"catch#7",
		nil,
		"",
		"",
		"",
		true
	},
	{
		112,
		"捕捉火怪怪",
		"catch#8",
		nil,
		"",
		"",
		"",
		true
	},
	{
		113,
		"捕捉草怪怪",
		"catch#9",
		nil,
		"",
		"",
		"",
		true
	},
	{
		114,
		"捕捉暗怪怪",
		"catch#10",
		nil,
		"",
		"",
		"",
		true
	},
	{
		115,
		"捕捉光怪怪",
		"catch#11",
		nil,
		"",
		"",
		"",
		true
	},
	{
		201,
		"挑战撒古特",
		"ch_npc#1021001",
		nil,
		"",
		"",
		"",
		true
	},
	{
		202,
		"挑战寒冰骑士",
		"ch_npc#1101001",
		nil,
		"",
		"",
		"",
		true
	},
	{
		203,
		"挑战卡雅公主",
		"ch_npc#1071001",
		nil,
		"",
		"",
		"",
		true
	},
	{
		204,
		"挑战怨毒灵宝",
		"ch_npc#1111001",
		nil,
		"",
		"",
		"",
		true
	},
	{
		205,
		"挑战爆甲吉斯",
		"ch_npc#1091001",
		nil,
		"",
		"",
		"",
		true
	},
	{
		206,
		"挑战暗影所罗",
		"ch_npc#1111002",
		nil,
		"",
		"",
		"",
		true
	},
	{
		207,
		"挑战末炎",
		"ui#guideQilinView",
		nil,
		"",
		"",
		"",
		true
	},
	{
		208,
		"挑战千鸟丸",
		"ch_npc#1051001",
		nil,
		"",
		"",
		"",
		true
	},
	{
		209,
		"挑战千机",
		"ch_npc#1101003",
		nil,
		"",
		"",
		"",
		true
	},
	{
		210,
		"挑战圣光飞龙",
		"ch_npc#1081001",
		nil,
		"",
		"",
		"",
		true
	},
	{
		211,
		"挑战星蓝龙",
		"ch_npc#1031002",
		nil,
		"",
		"",
		"",
		true
	},
	{
		212,
		"挑战冰灵王",
		"ch_npc#1121001",
		nil,
		"",
		"",
		"",
		true
	},
	{
		213,
		"挑战空无流",
		"ch_npc#1121002",
		nil,
		"",
		"",
		"",
		true
	},
	{
		214,
		"挑战苍零式",
		"ch_npc#1081002",
		nil,
		"",
		"",
		"",
		true
	},
	{
		215,
		"挑战天蛮王",
		"ch_npc#1081003",
		nil,
		"",
		"",
		"",
		true
	},
	{
		216,
		"挑战龙君焰",
		"ch_npc#1091002",
		nil,
		"",
		"",
		"",
		true
	},
	{
		217,
		"挑战诺亚",
		"ch_npc#1051003",
		nil,
		"",
		"",
		"",
		true
	},
	{
		218,
		"挑战芒",
		"ch_npc#1121007",
		nil,
		"",
		"",
		"",
		true
	},
	{
		219,
		"挑战修尔",
		"ch_npc#1121006",
		nil,
		"",
		"",
		"",
		true
	},
	{
		220,
		"挑战功夫熊猫",
		"ch_npc#1051002",
		nil,
		"",
		"",
		"",
		true
	},
	{
		221,
		"挑战水圣主银",
		"ch_npc#1101002",
		nil,
		"",
		"",
		"",
		true
	},
	{
		222,
		"挑战火圣主旭",
		"ch_npc#1091003",
		nil,
		"",
		"",
		"",
		true
	},
	{
		223,
		"挑战明镜",
		"ch_npc#1101004",
		nil,
		"",
		"",
		"",
		true
	},
	{
		224,
		"小蓝",
		"ui#threepet#threepetget",
		nil,
		"",
		"",
		"",
		false
	},
	{
		225,
		"小爆",
		"ui#threepet#threepetget",
		nil,
		"",
		"",
		"",
		false
	},
	{
		226,
		"小酷",
		"ui#threepet#threepetget",
		nil,
		"",
		"",
		"",
		false
	},
	{
		227,
		"蓝蓝露",
		"ui#threepet#threepetevolve",
		nil,
		"",
		"",
		"",
		true
	},
	{
		228,
		"爆爆龙",
		"ui#threepet#threepetevolve",
		nil,
		"",
		"",
		"",
		true
	},
	{
		229,
		"酷拉兽",
		"ui#threepet#threepetevolve",
		nil,
		"",
		"",
		"",
		true
	},
	{
		230,
		"绯樱",
		"ch_npc#1062008",
		nil,
		"",
		"",
		"",
		true
	},
	{
		231,
		"主线剧情",
		"ui#plotcopyview#0",
		nil,
		"",
		"",
		"",
		true
	},
	{
		232,
		"冒险幻境",
		"ui#plotcopyview#1",
		nil,
		"",
		"",
		"",
		true
	},
	{
		233,
		"精英挑战",
		"ui#plotcopyview#2",
		nil,
		"",
		"",
		"",
		true
	},
	{
		234,
		"精灵召唤",
		"ui#lottery",
		{
			1,
			1,
			5
		},
		"",
		"",
		"",
		true
	},
	{
		235,
		"商城 - 热卖精灵页签",
		"ui#shop#shopmess2",
		{
			2,
			10
		},
		"",
		"",
		"",
		true
	},
	{
		236,
		"兑换 - 失落遗迹",
		"ui#exchange#7",
		{
			1,
			53,
			3
		},
		"",
		"",
		"",
		true
	},
	{
		237,
		"圣麒麟精英挑战",
		"chapter#3001",
		nil,
		"",
		"",
		"",
		true
	},
	{
		238,
		"茜茜精英挑战",
		"chapter#3002",
		nil,
		"",
		"",
		"",
		true
	},
	{
		239,
		"龙炎精英挑战",
		"chapter#3003",
		nil,
		"",
		"",
		"",
		true
	},
	{
		240,
		"阿米尔精英挑战",
		"chapter#3004",
		nil,
		"",
		"",
		"",
		true
	},
	{
		241,
		"暗天使精英挑战",
		"chapter#3005",
		nil,
		"",
		"",
		"",
		true
	},
	{
		242,
		"龙君焰精英挑战",
		"chapter#3006",
		nil,
		"",
		"",
		"",
		true
	},
	{
		243,
		"苍零式精英挑战",
		"chapter#3007",
		nil,
		"",
		"",
		"",
		true
	},
	{
		244,
		"空无流精英挑战",
		"chapter#3008",
		nil,
		"",
		"",
		"",
		true
	},
	{
		245,
		"麒麟传说挑战",
		"ch_npc#1141011",
		{
			1,
			154,
			1
		},
		"",
		"",
		"",
		true
	},
	{
		246,
		"星格传说挑战",
		"ch_npc#1061002",
		{
			2,
			31
		},
		"",
		"",
		"",
		true
	},
	{
		247,
		"龙君焰传说挑战",
		"ch_npc#1121001",
		{
			2,
			34
		},
		"",
		"",
		"",
		true
	},
	{
		248,
		"洛萨传说挑战",
		"ch_npc#1111001",
		{
			2,
			33
		},
		"",
		"",
		"",
		true
	},
	{
		249,
		"龙炎传说挑战",
		"ch_npc#1181002",
		{
			2,
			38
		},
		"",
		"",
		"",
		true
	},
	{
		250,
		"苍零式 传说挑战",
		"ch_npc#1131002",
		{
			2,
			38
		},
		"",
		"",
		"",
		true
	},
	{
		251,
		"阿米尔传说挑战",
		"ch_npc#1181001",
		{
			2,
			38
		},
		"",
		"",
		"",
		true
	},
	{
		252,
		"阿瑞斯传说挑战",
		"ch_npc#1161001",
		{
			2,
			38
		},
		"",
		"",
		"",
		true
	},
	{
		253,
		"空无流传说挑战",
		"ch_npc#1101001",
		{
			2,
			38
		},
		"",
		"",
		"",
		true
	},
	{
		254,
		"尤烈传说挑战",
		"ch_npc#1151001",
		{
			2,
			39
		},
		"",
		"",
		"",
		true
	},
	{
		255,
		"帝释天传说挑战",
		"ch_npc#1151002",
		{
			2,
			39
		},
		"",
		"",
		"",
		true
	},
	{
		256,
		"夜无忧传说挑战",
		"ch_npc#1131001",
		{
			2,
			39
		},
		"",
		"",
		"",
		true
	},
	{
		257,
		"修尔传说挑战",
		"ch_npc#1061001",
		{
			2,
			40
		},
		"",
		"",
		"",
		true
	},
	{
		258,
		"炽辰光传说挑战",
		"ch_npc#1161002",
		{
			2,
			40
		},
		"",
		"",
		"",
		true
	},
	{
		259,
		"诺亚传说挑战",
		"ch_npc#1081001",
		{
			2,
			40
		},
		"",
		"",
		"",
		true
	},
	{
		260,
		"米淇淋传说挑战",
		"ch_npc#1161003",
		{
			2,
			1
		},
		"",
		"",
		"",
		true
	},
	{
		261,
		"王者之路",
		"func#67",
		{
			1,
			1,
			5
		},
		"",
		"",
		"",
		true
	},
	{
		262,
		"兑换-家族",
		"func#46#1",
		{
			1,
			43,
			5
		},
		"",
		"",
		"",
		true
	},
	{
		263,
		"兑换-竞技场",
		"func#46#2",
		{
			1,
			33,
			1
		},
		"",
		"",
		"",
		true
	},
	{
		264,
		"兑换-排位赛",
		"func#46#3",
		{
			2,
			35
		},
		"",
		"",
		"",
		true
	},
	{
		265,
		"兑换-精灵之尘",
		"func#46#4",
		{
			1,
			21,
			2
		},
		"",
		"",
		"",
		true
	},
	{
		266,
		"兑换-休闲玩法",
		"func#46#5",
		{
			1,
			28,
			2
		},
		"",
		"",
		"",
		true
	},
	{
		267,
		"兑换-传说挑战",
		"func#46#6",
		{
			1,
			154,
			1
		},
		"",
		"",
		"",
		true
	},
	{
		268,
		"首充获得",
		"",
		nil,
		"",
		"",
		"",
		true
	}
}
local t_get_ways = {
	dataList[1],
	dataList[2],
	dataList[3],
	[11] = dataList[4],
	[12] = dataList[5],
	[13] = dataList[6],
	[14] = dataList[7],
	[101] = dataList[8],
	[102] = dataList[9],
	[103] = dataList[10],
	[104] = dataList[11],
	[105] = dataList[12],
	[111] = dataList[13],
	[112] = dataList[14],
	[113] = dataList[15],
	[114] = dataList[16],
	[115] = dataList[17],
	[201] = dataList[18],
	[202] = dataList[19],
	[203] = dataList[20],
	[204] = dataList[21],
	[205] = dataList[22],
	[206] = dataList[23],
	[207] = dataList[24],
	[208] = dataList[25],
	[209] = dataList[26],
	[210] = dataList[27],
	[211] = dataList[28],
	[212] = dataList[29],
	[213] = dataList[30],
	[214] = dataList[31],
	[215] = dataList[32],
	[216] = dataList[33],
	[217] = dataList[34],
	[218] = dataList[35],
	[219] = dataList[36],
	[220] = dataList[37],
	[221] = dataList[38],
	[222] = dataList[39],
	[223] = dataList[40],
	[224] = dataList[41],
	[225] = dataList[42],
	[226] = dataList[43],
	[227] = dataList[44],
	[228] = dataList[45],
	[229] = dataList[46],
	[230] = dataList[47],
	[231] = dataList[48],
	[232] = dataList[49],
	[233] = dataList[50],
	[234] = dataList[51],
	[235] = dataList[52],
	[236] = dataList[53],
	[237] = dataList[54],
	[238] = dataList[55],
	[239] = dataList[56],
	[240] = dataList[57],
	[241] = dataList[58],
	[242] = dataList[59],
	[243] = dataList[60],
	[244] = dataList[61],
	[245] = dataList[62],
	[246] = dataList[63],
	[247] = dataList[64],
	[248] = dataList[65],
	[249] = dataList[66],
	[250] = dataList[67],
	[251] = dataList[68],
	[252] = dataList[69],
	[253] = dataList[70],
	[254] = dataList[71],
	[255] = dataList[72],
	[256] = dataList[73],
	[257] = dataList[74],
	[258] = dataList[75],
	[259] = dataList[76],
	[260] = dataList[77],
	[261] = dataList[78],
	[262] = dataList[79],
	[263] = dataList[80],
	[264] = dataList[81],
	[265] = dataList[82],
	[266] = dataList[83],
	[267] = dataList[84],
	[268] = dataList[85]
}

t_get_ways.dataList = dataList

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

return t_get_ways
