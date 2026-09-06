-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_preferentialview.lua

module("logicconfig.config.t_preferentialview", package.seeall)

local title = {
	leafId = 2,
	name = 3,
	showTag = 11,
	reportBehavior = 10,
	redpointId = 8,
	parameter = 9,
	hideBg = 12,
	noFold = 13,
	uniqueTag = 5,
	viewname = 4,
	funcId = 7,
	id = 1,
	sort = 6
}
local dataList = {
	{
		47,
		0,
		"充值返利",
		"singlerechargemainview",
		"47",
		1,
		941,
		"157",
		"78009",
		0,
		"返50%",
		false,
		false
	},
	{
		1,
		0,
		"累充好礼",
		"accumulatechargeprogressview",
		"1",
		2,
		727,
		"88",
		"",
		200955,
		"新战斗场景",
		false,
		false
	},
	{
		2,
		0,
		"累消神钻",
		"godgemconsumemainview",
		"2",
		3,
		621,
		"198",
		"",
		201193,
		"送黄金女皮",
		false,
		false
	},
	{
		3,
		0,
		"全额返钻",
		"hdzeropayview",
		"3",
		4,
		596,
		"",
		"34033",
		200957,
		"",
		false,
		false
	},
	{
		16,
		0,
		"通行证",
		"passportwpaddview",
		"16",
		4,
		659,
		"51",
		"",
		201196,
		"",
		false,
		false
	},
	{
		41,
		0,
		"幸运抽神宠",
		"saintknightcardmainview",
		"41",
		4,
		881,
		"301#o6",
		"178043",
		0,
		"推荐",
		false,
		false
	},
	{
		22,
		0,
		"购月卡领材料",
		"saintknightmoview",
		"22",
		5,
		1221,
		"306#-246",
		"179013",
		201227,
		"源起启",
		false,
		false
	},
	{
		25,
		0,
		"次元战令",
		"passportscrollerview",
		"25",
		5,
		738,
		"",
		"91016",
		0,
		"全额返钻",
		false,
		false
	},
	{
		9,
		0,
		"返利商城",
		"rebatemallview",
		"9",
		6,
		897,
		"155",
		"277002",
		0,
		"",
		false,
		false
	},
	{
		19,
		0,
		"弥梦离皮肤",
		"petskinsellchangeview",
		"19",
		11,
		695,
		"",
		"32",
		201225,
		"新",
		false,
		false
	},
	{
		20,
		0,
		"圣骑特惠",
		"petskinsellchangeview",
		"20",
		5,
		696,
		"",
		"28",
		201348,
		"神曜材料打包",
		false,
		false
	},
	{
		18,
		0,
		"龙尊圣主",
		"longgugiftview",
		"18",
		20,
		682,
		"",
		"120013",
		201224,
		"回归",
		false,
		false
	},
	{
		888,
		0,
		"暗末炎",
		"",
		"888",
		5,
		1025,
		"",
		"120023",
		0,
		"",
		false,
		true
	},
	{
		888,
		1,
		"特惠礼包",
		"godgemconsumepayshopview",
		"88",
		1,
		1379,
		"o87",
		"114019",
		0,
		"满红星+满神器",
		false,
		false
	},
	{
		888,
		2,
		"神钻打包",
		"petskinsellchangeview",
		"55",
		11,
		1379,
		"",
		"33",
		0,
		"",
		false,
		false
	},
	{
		52,
		0,
		"源起打包",
		"longgugiftview",
		"52",
		2,
		1025,
		"",
		"120023",
		0,
		"材料+红星",
		false,
		false
	},
	{
		66,
		0,
		"梦队打包",
		"giftpacksalegodgemview",
		"66",
		3,
		1347,
		"",
		"120022",
		0,
		"材料+红星",
		false,
		false
	},
	{
		57,
		0,
		"皮肤海报",
		"petskinsourcejumpview",
		"57",
		20,
		874,
		"",
		"1502805#1403403#1301603#1102201#1202502",
		0,
		"五女仆",
		false,
		false
	},
	{
		11,
		0,
		"奶龙套装",
		"discountdressshopmoorview",
		"11",
		98,
		874,
		"-227",
		"159008",
		201194,
		"服装",
		false,
		false
	},
	{
		5,
		0,
		"版本特惠",
		"versiongift",
		"5",
		99,
		647,
		"-263",
		"",
		201197,
		"",
		false,
		false
	},
	{
		999,
		0,
		"皮肤抽奖",
		"",
		"999",
		10,
		0,
		"",
		"",
		0,
		"",
		false,
		true
	},
	{
		999,
		1,
		"倾怀化芳",
		"xiaoxiaoleskinview",
		"44",
		8,
		864,
		"",
		"257057",
		0,
		"黑创",
		false,
		false
	},
	{
		999,
		2,
		"性转皮肤选一",
		"luckydrawnewskinview",
		"40",
		10,
		845,
		"o9",
		"215154",
		0,
		"双生女皮",
		false,
		false
	},
	{
		999,
		3,
		"圣品皮肤选一",
		"xiaoxiaoleskinview",
		"38",
		6,
		888,
		"",
		"257056",
		0,
		"黑创女皮",
		false,
		false
	},
	{
		999,
		4,
		"绝品皮肤选一",
		"luckydrawnewskinview",
		"58",
		7,
		850,
		"",
		"215155",
		0,
		"尘皮肤",
		false,
		false
	},
	{
		999,
		5,
		"性转皮肤选一",
		"luckydrawnewskinview",
		"35",
		8,
		722,
		"o9",
		"215156",
		0,
		"回归",
		false,
		false
	},
	{
		999,
		6,
		"臻品皮肤选一",
		"luckydrawtimestatemultipleview",
		"54",
		10,
		1157,
		"",
		"25067",
		0,
		"回归",
		false,
		false
	},
	{
		999,
		7,
		"臻品皮肤选一",
		"luckydrawtimestatemultipleview",
		"56",
		8,
		1172,
		"",
		"25065",
		0,
		"回归",
		false,
		false
	},
	{
		999,
		8,
		"绝品皮肤",
		"luckydrawnewskinview",
		"49",
		7,
		800,
		"",
		"215136",
		0,
		"帝皇侠",
		false,
		false
	},
	{
		999,
		9,
		"年费伴生皮",
		"xiaoxiaoleskinview",
		"99",
		6,
		1324,
		"",
		"257055",
		0,
		"回归",
		false,
		false
	},
	{
		998,
		0,
		"双十一商城",
		"",
		"998",
		9,
		737,
		"",
		"",
		0,
		"",
		false,
		true
	},
	{
		998,
		1,
		"免单抽奖",
		"luckydrawnewskinview",
		"60",
		2,
		852,
		"",
		"215124",
		0,
		"悼影圣龙女皮",
		false,
		false
	},
	{
		998,
		2,
		"免单商城",
		"freezone",
		"70",
		1,
		737,
		"",
		"",
		0,
		"返神钻",
		false,
		false
	},
	{
		15,
		0,
		"月卡打包",
		"monthcardpackview",
		"15",
		2,
		561,
		"-217",
		"",
		200956,
		"新",
		false,
		false
	},
	{
		29,
		0,
		"吞天皮肤",
		"petskinsellchangeview",
		"29",
		3,
		761,
		"",
		"18",
		201224,
		"减100",
		false,
		false
	},
	{
		31,
		0,
		"累充许愿",
		"topuplotteryview",
		"31",
		3,
		777,
		"",
		"236001",
		0,
		"新",
		false,
		false
	},
	{
		53,
		0,
		"累消钻石",
		"consumediamondgiftview",
		"53",
		3,
		248,
		"104",
		"40005",
		0,
		"红星",
		false,
		false
	},
	{
		26,
		0,
		"巅峰返钻",
		"peakdiamond",
		"26",
		4,
		753,
		"424",
		"",
		0,
		"新",
		false,
		false
	},
	{
		6,
		0,
		"皮肤四选一",
		"luckydrawtimestateaddview",
		"6",
		5,
		728,
		"-230",
		"25025",
		200965,
		"新",
		false,
		false
	},
	{
		7,
		0,
		"皮肤六选一",
		"luckydrawtimestateview",
		"7",
		5,
		670,
		"",
		"25022",
		200960,
		"新",
		false,
		false
	},
	{
		8,
		0,
		"无烬女皮",
		"luckydrawtimestatepreviewview",
		"8",
		5,
		666,
		"o2",
		"25024",
		200965,
		"新",
		false,
		false
	},
	{
		33,
		0,
		"王龙女皮",
		"luckydrawnewskinview",
		"33",
		5,
		752,
		"",
		"",
		201359,
		"性转",
		false,
		false
	},
	{
		37,
		0,
		"无序女皮",
		"luckydrawnewskinview",
		"37",
		5,
		827,
		"o9",
		"215013",
		0,
		"新",
		false,
		false
	},
	{
		45,
		0,
		"天天返利",
		"dayrechargeview",
		"45",
		5,
		892,
		"488",
		"79005",
		0,
		"新",
		false,
		false
	},
	{
		4,
		0,
		"通行证",
		"passportwpview",
		"4",
		10,
		113,
		"51",
		"",
		200964,
		"新",
		false,
		false
	},
	{
		10,
		0,
		"龙魂王者套装礼包",
		"discountdressshopview",
		"10",
		10,
		823,
		"-219",
		"154008",
		200959,
		"服装",
		true,
		false
	},
	{
		23,
		0,
		"巫师服装",
		"fashionshowskinsalegodgemview",
		"23",
		10,
		481,
		"",
		"120003",
		201349,
		"6.5折",
		false,
		false
	},
	{
		30,
		0,
		"龙主女皮",
		"luckydrawnewskinview",
		"30",
		11,
		791,
		"",
		"215052",
		0,
		"新",
		false,
		false
	},
	{
		42,
		0,
		"性转皮肤选一",
		"luckydrawnewskinview",
		"42",
		11,
		702,
		"o9",
		"215102",
		0,
		"新",
		false,
		false
	},
	{
		46,
		0,
		"超值套餐",
		"purchaselimitview",
		"46",
		12,
		938,
		"",
		"298001",
		0,
		"阿瑞斯",
		false,
		false
	},
	{
		39,
		0,
		"精美皮肤选一",
		"luckydrawnewskinview",
		"39",
		13,
		1080,
		"",
		"215101",
		0,
		"维蕾塔皮肤",
		false,
		false
	},
	{
		48,
		0,
		"精美皮肤",
		"luckydrawnewskinview",
		"48",
		15,
		801,
		"",
		"215094",
		0,
		"弥梦离皮肤",
		false,
		false
	},
	{
		12,
		0,
		"遛遛阿瑞",
		"pigskinsellview",
		"12",
		16,
		702,
		"",
		"",
		201195,
		"新",
		false,
		false
	},
	{
		51,
		0,
		"性转皮肤选一",
		"luckydrawnewskinview",
		"51",
		16,
		844,
		"",
		"215097",
		0,
		"女皮",
		false,
		false
	},
	{
		13,
		0,
		"商城上新",
		"preferentialgoto1view",
		"13",
		17,
		577,
		"-222",
		"mibao#shengqituandui7",
		200962,
		"新",
		false,
		false
	},
	{
		14,
		0,
		"精灵直升",
		"preferentialgoto2view",
		"14",
		18,
		578,
		"-223",
		"func#463",
		200963,
		"",
		false,
		false
	},
	{
		17,
		0,
		"月卡升级",
		"wholecardpublicityview",
		"17",
		20,
		649,
		"",
		"",
		201108,
		"新",
		false,
		false
	},
	{
		21,
		0,
		"消费返钻",
		"cashbackluckyview",
		"21",
		22,
		700,
		"341",
		"",
		201226,
		"抽奖",
		false,
		false
	},
	{
		27,
		0,
		"王者极皮肤",
		"luckydrawnewskinview",
		"27",
		40,
		752,
		"",
		"215034",
		0,
		"新",
		false,
		false
	},
	{
		28,
		0,
		"万圣皮肤",
		"luckydrawnewskinview",
		"28",
		40,
		754,
		"o9",
		"215037",
		0,
		"新",
		false,
		false
	},
	{
		32,
		0,
		"伏妖战令",
		"passportnewyearinvestview",
		"32",
		100,
		792,
		"442",
		"238002",
		0,
		"全额返",
		false,
		false
	},
	{
		50,
		0,
		"女神衣柜",
		"",
		"50",
		0,
		0,
		"",
		"",
		0,
		"",
		false,
		false
	}
}
local t_preferentialview = {
	[47] = {
		[0] = dataList[1]
	},
	{
		[0] = dataList[2]
	},
	{
		[0] = dataList[3]
	},
	{
		[0] = dataList[4]
	},
	[16] = {
		[0] = dataList[5]
	},
	[41] = {
		[0] = dataList[6]
	},
	[22] = {
		[0] = dataList[7]
	},
	[25] = {
		[0] = dataList[8]
	},
	[9] = {
		[0] = dataList[9]
	},
	[19] = {
		[0] = dataList[10]
	},
	[20] = {
		[0] = dataList[11]
	},
	[18] = {
		[0] = dataList[12]
	},
	[888] = {
		[0] = dataList[13],
		dataList[14],
		dataList[15]
	},
	[52] = {
		[0] = dataList[16]
	},
	[66] = {
		[0] = dataList[17]
	},
	[57] = {
		[0] = dataList[18]
	},
	[11] = {
		[0] = dataList[19]
	},
	[5] = {
		[0] = dataList[20]
	},
	[999] = {
		[0] = dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25],
		dataList[26],
		dataList[27],
		dataList[28],
		dataList[29],
		dataList[30]
	},
	[998] = {
		[0] = dataList[31],
		dataList[32],
		dataList[33]
	},
	[15] = {
		[0] = dataList[34]
	},
	[29] = {
		[0] = dataList[35]
	},
	[31] = {
		[0] = dataList[36]
	},
	[53] = {
		[0] = dataList[37]
	},
	[26] = {
		[0] = dataList[38]
	},
	[6] = {
		[0] = dataList[39]
	},
	[7] = {
		[0] = dataList[40]
	},
	[8] = {
		[0] = dataList[41]
	},
	[33] = {
		[0] = dataList[42]
	},
	[37] = {
		[0] = dataList[43]
	},
	[45] = {
		[0] = dataList[44]
	},
	{
		[0] = dataList[45]
	},
	[10] = {
		[0] = dataList[46]
	},
	[23] = {
		[0] = dataList[47]
	},
	[30] = {
		[0] = dataList[48]
	},
	[42] = {
		[0] = dataList[49]
	},
	[46] = {
		[0] = dataList[50]
	},
	[39] = {
		[0] = dataList[51]
	},
	[48] = {
		[0] = dataList[52]
	},
	[12] = {
		[0] = dataList[53]
	},
	[51] = {
		[0] = dataList[54]
	},
	[13] = {
		[0] = dataList[55]
	},
	[14] = {
		[0] = dataList[56]
	},
	[17] = {
		[0] = dataList[57]
	},
	[21] = {
		[0] = dataList[58]
	},
	[27] = {
		[0] = dataList[59]
	},
	[28] = {
		[0] = dataList[60]
	},
	[32] = {
		[0] = dataList[61]
	},
	[50] = {
		[0] = dataList[62]
	}
}

t_preferentialview.dataList = dataList

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

return t_preferentialview
