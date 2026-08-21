local title = {
	id = 0,
	command = "",
	label = 0,
	param1 = 0,
	param2 = 0,
	param3 = 0,
	desc = 0,
	showLimit = {},
	unlockIds = {},
	unlockIdsAtLastOne = {},
	icon = ""
}

local value = {
[1] =
{
 		id=1,
 		command="OpenMainScene",
 		label=691,
 	icon=""
},
[2] =
{
 		id=2,
 		command="OpenBag",
 		label=695,
 		param1=1,
 		desc=40002,
 	icon=""
},
[3] =
{
 		id=3,
 		command="OpenLottery",
 		label=127,
 		desc=40003,
 		unlockIds={1002},
 	icon=""
},
[4] =
{
 		id=4,
 		command="OpenLottery",
 		label=692,
 		param1=4,
 		desc=40004,
 		unlockIds={1002},
 	icon=""
},
[5] =
{
 		id=5,
 		command="OpenOtakuMain",
 		label=125,
 		desc=40005,
 		unlockIds={3103},
 	icon=""
},
[6] =
{
 		id=6,
 		command="OpenDormitorySelectPopup",
 		label=268,
 		desc=40006,
 	icon=""
},
[7] =
{
 		id=7,
 		command="OpenTeamConfigUI",
 		label=128,
 	icon=""
},
[8] =
{
 		id=8,
 		command="OpenCurrencyExchangeUI",
 		desc=40008,
 	icon=""
},
[9] =
{
 		id=9,
 		command="OpenEnergyUI",
 		desc=40009,
 	icon=""
},
[10] =
{
 		id=10,
 		command="OpenDormActivityUI",
 	icon=""
},
[11] =
{
 		id=11,
 		command="OpenBridgeCmdSkill",
 		desc=40011,
 		unlockIds={1102},
 	icon=""
},
[12] =
{
 		id=12,
 		command="OpenPassUI",
 		desc=40012,
 	icon=""
},
[13] =
{
 		id=13,
 		command="OpenAchievement",
 		desc=40013,
 	icon=""
},
[14] =
{
 		id=14,
 		command="OpenPersonalCopy",
 	icon=""
},
[15] =
{
 		id=15,
 		command="OpenFriend",
 	icon=""
},
[16] =
{
 		id=16,
 		command="OpenMailUI",
 		unlockIds={3005},
 	icon=""
},
[41] =
{
 		id=41,
 		command="OpenChapterSelection",
 		label=4304,
 		param1=-1,
 		desc=40041,
 		unlockIds={101},
 	icon=""
},
[42] =
{
 		id=42,
 		command="OpenChapterSelection",
 		param1=2,
 		desc=40042,
 		unlockIds={1107},
 	icon=""
},
[43] =
{
 		id=43,
 		command="OpenChapterSelection",
 		param1=4,
 		desc=40043,
 		unlockIds={1313},
 	icon=""
},
[44] =
{
 		id=44,
 		command="OpenChapterSelection",
 		param1=5,
 		desc=40044,
 		unlockIds={1213},
 	icon=""
},
[45] =
{
 		id=45,
 		command="OpenChapterSelection",
 		param1=3,
 		desc=40045,
 		unlockIds={1101},
 	icon=""
},
[46] =
{
 		id=46,
 		command="OpenBossWarMainUI",
 		desc=40046,
 		unlockIds={1113},
 	icon=""
},
[51] =
{
 		id=51,
 		command="OpenShopUI",
 		label=693,
 		param1=1,
 		param2=101,
 		desc=40051,
 	icon=""
},
[52] =
{
 		id=52,
 		command="OpenShopUI",
 		param1=1,
 		param2=102,
 		desc=40052,
 	icon=""
},
[53] =
{
 		id=53,
 		command="OpenShopUI",
 		param1=1,
 		param2=103,
 		desc=40053,
 	icon=""
},
[54] =
{
 		id=54,
 		command="OpenShopUI",
 		param1=1,
 		param2=104,
 		desc=40054,
 	icon=""
},
[55] =
{
 		id=55,
 		command="OpenShopUI",
 		param1=2,
 		desc=40055,
 	icon=""
},
[56] =
{
 		id=56,
 		command="OpenShopUI",
 		param1=3,
 		desc=40056,
 	icon=""
},
[57] =
{
 		id=57,
 		command="OpenShopUI",
 		label=693,
 		param1=4,
 		desc=40057,
 	icon=""
},
[58] =
{
 		id=58,
 		command="OpenShopUI",
 		label=693,
 		param1=5,
 		desc=40057,
 	icon=""
},
[61] =
{
 		id=61,
 		command="OpenTrainingHero",
 		label=129,
 		param2=1,
 		desc=40061,
 	icon=""
},
[62] =
{
 		id=62,
 		command="OpenTrainingHero",
 		label=129,
 		param2=5,
 		desc=40062,
 	icon=""
},
[63] =
{
 		id=63,
 		command="OpenTrainingHero",
 		label=129,
 		param2=2,
 		desc=40063,
 	icon=""
},
[64] =
{
 		id=64,
 		command="OpenTrainingHero",
 		label=129,
 		param2=3,
 		desc=40064,
 	icon=""
},
[65] =
{
 		id=65,
 		command="OpenTrainingHero",
 		label=129,
 		param2=4,
 		desc=40065,
 	icon=""
},
[66] =
{
 		id=66,
 		command="OpenTrainingHero",
 		label=129,
 		param2=6,
 		desc=40066,
 	icon=""
},
[67] =
{
 		id=67,
 		command="OpenTrainingHero",
 		label=129,
 		param2=7,
 		desc=40067,
 	icon=""
},
[68] =
{
 		id=68,
 		command="OpenTrainingHero",
 		label=129,
 		desc=40068,
 	icon=""
},
[69] =
{
 		id=69,
 		command="OpenTrainingHero",
 		label=129,
 		param2=8,
 		desc=40067,
 	icon=""
},
[71] =
{
 		id=71,
 		command="OpenOtakuBridge",
 		desc=40071,
 		unlockIds={3103},
 	icon=""
},
[72] =
{
 		id=72,
 		command="OpenOtakuManufacturingCabin",
 		param1=1,
 		desc=40072,
 		unlockIds={3103},
 	icon=""
},
[73] =
{
 		id=73,
 		command="OpenOtakuTraning",
 		desc=40073,
 	icon=""
},
[74] =
{
 		id=74,
 		command="OpenRestaurant",
 		param1=1,
 		desc=40074,
 		unlockIds={3103,9202,9209},
 	icon=""
},
[75] =
{
 		id=75,
 		command="OpenOtakuSynthesis",
 		desc=40075,
 		unlockIds={1208,9205,9208},
 	icon=""
},
[76] =
{
 		id=76,
 		command="OpenOtakuExpedition",
 		desc=40076,
 		unlockIds={1204,9207,9211},
 	icon=""
},
[77] =
{
 		id=77,
 		command="OpenComRoomUI",
 		label=10907,
 		desc=40077,
 	icon=""
},
[78] =
{
 		id=78,
 		command="OpenOtakuManufacturingCabin",
 		param1=2,
 		desc=40072,
 		unlockIds={1204,9207,9205},
 	icon=""
},
[79] =
{
 		id=79,
 		command="OpenOtakuManufacturingCabin",
 		param1=3,
 		desc=40072,
 		unlockIds={1213,9208,9201},
 	icon=""
},
[80] =
{
 		id=80,
 		command="OpenRestaurant",
 		param1=2,
 		desc=40074,
 		unlockIds={1208,9205},
 	icon=""
},
[81] =
{
 		id=81,
 		command="OpenTaskUI",
 		label=126,
 		param1=1,
 		desc=40081,
 		unlockIds={1003},
 	icon=""
},
[82] =
{
 		id=82,
 		command="OpenTaskUI",
 		label=126,
 		param1=2,
 		desc=40082,
 		unlockIds={1007},
 	icon=""
},
[83] =
{
 		id=83,
 		command="OpenTaskUI",
 		label=126,
 		param1=3,
 		desc=40083,
 		unlockIds={1007},
 	icon=""
},
[84] =
{
 		id=84,
 		command="OpenTaskUI",
 		label=126,
 		param1=4,
 		desc=40084,
 		unlockIds={1007},
 	icon=""
},
[91] =
{
 		id=91,
 		command="OpenPassUI",
 		desc=40091,
 	icon=""
},
[92] =
{
 		id=92,
 		command="OpenPassUI",
 		param1=1,
 		desc=40092,
 	icon=""
},
[93] =
{
 		id=93,
 		command="OpenPassUI",
 		param1=2,
 		desc=40093,
 	icon=""
},
[94] =
{
 		id=94,
 		command="OpeKitChen",
 		desc=40094,
 		unlockIds={1204,9203,9206},
 	icon=""
},
[95] =
{
 		id=95,
 		command="OpenTrainingHero",
 		label=129,
 		param1=110003,
 		param2=1,
 		desc=40061,
 	icon=""
},
[96] =
{
 		id=96,
 		command="OpenTrainingHero",
 		label=129,
 		param1=120001,
 		param2=1,
 		desc=40061,
 	icon=""
},
[97] =
{
 		id=97,
 		command="OpenPlotReviewList",
 		param1=8,
 	icon=""
},
[98] =
{
 		id=98,
 		command="OpenLimiteChallgeStage",
 		desc=40098,
 		unlockIds={1410},
 	icon=""
},
[100] =
{
 		id=100,
 		command="OpenStage",
 		param1=10101,
 		desc=40100,
 	icon=""
},
[101] =
{
 		id=101,
 		command="OpenStage",
 		param1=20101,
 		desc=40101,
 		unlockIds={1010},
 	icon=""
},
[102] =
{
 		id=102,
 		command="OpenStage",
 		param1=30101,
 		desc=40102,
 		unlockIds={1113},
 	icon=""
},
[103] =
{
 		id=103,
 		command="OpenStage",
 		param1=40101,
 		desc=40103,
 		unlockIds={1213},
 	icon=""
},
[104] =
{
 		id=104,
 		command="OpenStage",
 		param1=50101,
 		desc=40104,
 		unlockIds={1313},
 	icon=""
},
[105] =
{
 		id=105,
 		command="OpenStage",
 		param1=50101,
 		desc=40105,
 		unlockIds={4416},
 	icon=""
},
[110] =
{
 		id=110,
 		command="OpenStage",
 		param1=10201,
 		desc=40110,
 		unlockIds={1107},
 	icon=""
},
[111] =
{
 		id=111,
 		command="OpenStage",
 		param1=20201,
 		desc=40111,
 		unlockIds={2010,1113},
 	icon=""
},
[112] =
{
 		id=112,
 		command="OpenStage",
 		param1=30201,
 		desc=40112,
 		unlockIds={2113,1213},
 	icon=""
},
[113] =
{
 		id=113,
 		command="OpenStage",
 		param1=40201,
 		desc=40113,
 		unlockIds={2213,1313},
 	icon=""
},
[114] =
{
 		id=114,
 		command="OpenStage",
 		param1=50201,
 		desc=40114,
 		unlockIds={2313,1415},
 	icon=""
},
[115] =
{
 		id=115,
 		command="OpenStage",
 		param1=50201,
 		desc=40115,
 		unlockIds={2415,1515},
 	icon=""
},
[211] =
{
 		id=211,
 		command="OpenStage",
 		param1=1404,
 		desc=40211,
 		unlockIds={1203},
 		unlockIdsAtLastOne={1,402,31,32,33,34,35,36,37},
 	icon=""
},
[212] =
{
 		id=212,
 		command="OpenStage",
 		param1=1401,
 		desc=40212,
 		unlockIds={211},
 		unlockIdsAtLastOne={1,402,31,32,33,34,35,36,37},
 	icon=""
},
[213] =
{
 		id=213,
 		command="OpenStage",
 		param1=1402,
 		desc=40213,
 		unlockIds={212},
 		unlockIdsAtLastOne={1,402,31,32,33,34,35,36,37},
 	icon=""
},
[214] =
{
 		id=214,
 		command="OpenStage",
 		param1=1403,
 		desc=40214,
 		unlockIds={213},
 		unlockIdsAtLastOne={1,402,31,32,33,34,35,36,37},
 	icon=""
},
[221] =
{
 		id=221,
 		command="OpenStage",
 		param1=1104,
 		desc=40221,
 		unlockIds={1101},
 		unlockIdsAtLastOne={1,402,31,32,33,34,35,36,37},
 	icon=""
},
[222] =
{
 		id=222,
 		command="OpenStage",
 		param1=1101,
 		desc=40222,
 		unlockIds={221},
 		unlockIdsAtLastOne={1,402,31,32,33,34,35,36,37},
 	icon=""
},
[223] =
{
 		id=223,
 		command="OpenStage",
 		param1=1102,
 		desc=40223,
 		unlockIds={222},
 		unlockIdsAtLastOne={1,402,31,32,33,34,35,36,37},
 	icon=""
},
[224] =
{
 		id=224,
 		command="OpenStage",
 		param1=1103,
 		desc=40224,
 		unlockIds={222},
 		unlockIdsAtLastOne={1,402,31,32,33,34,35,36,37},
 	icon=""
},
[231] =
{
 		id=231,
 		command="OpenStage",
 		param1=1201,
 		desc=40231,
 		unlockIds={1109},
 		unlockIdsAtLastOne={1,402,31,32,33,34,35,36,37},
 	icon=""
},
[232] =
{
 		id=232,
 		command="OpenStage",
 		param1=1202,
 		desc=40232,
 		unlockIds={231},
 		unlockIdsAtLastOne={1,402,31,32,33,34,35,36,37},
 	icon=""
},
[233] =
{
 		id=233,
 		command="OpenStage",
 		param1=1203,
 		desc=40233,
 		unlockIds={232},
 		unlockIdsAtLastOne={1,402,31,32,33,34,35,36,37},
 	icon=""
},
[240] =
{
 		id=240,
 		command="OpenStage",
 		param1=1300,
 		desc=40240,
 		unlockIds={1105},
 		unlockIdsAtLastOne={1,402,31,32,33,34,35,36,37},
 	icon=""
},
[241] =
{
 		id=241,
 		command="OpenStage",
 		param1=1301,
 		desc=40241,
 		unlockIds={240},
 		unlockIdsAtLastOne={1,402,31,32,33,34,35,36,37},
 	icon=""
},
[242] =
{
 		id=242,
 		command="OpenStage",
 		param1=1302,
 		desc=40242,
 		unlockIds={241},
 		unlockIdsAtLastOne={1,402,31,32,33,34,35,36,37},
 	icon=""
},
[243] =
{
 		id=243,
 		command="OpenStage",
 		param1=1303,
 		desc=40243,
 		unlockIds={242},
 		unlockIdsAtLastOne={1,402,31,32,33,34,35,36,37},
 	icon=""
},
[251] =
{
 		id=251,
 		command="OpenStage",
 		param1=1004,
 		desc=40251,
 		unlockIds={1101},
 		unlockIdsAtLastOne={1,402,31,32,33,34,35,36,37},
 	icon=""
},
[252] =
{
 		id=252,
 		command="OpenStage",
 		param1=1001,
 		desc=40252,
 		unlockIds={251},
 		unlockIdsAtLastOne={1,402,31,32,33,34,35,36,37},
 	icon=""
},
[253] =
{
 		id=253,
 		command="OpenStage",
 		param1=1002,
 		desc=40253,
 		unlockIds={252},
 		unlockIdsAtLastOne={1,402,31,32,33,34,35,36,37},
 	icon=""
},
[254] =
{
 		id=254,
 		command="OpenStage",
 		param1=1003,
 		desc=40254,
 		unlockIds={253},
 		unlockIdsAtLastOne={1,402,31,32,33,34,35,36,37},
 	icon=""
},
[261] =
{
 		id=261,
 		command="OpenStage",
 		param1=1501,
 		desc=40261,
 		unlockIds={1303},
 		unlockIdsAtLastOne={1,402,31,32,33,34,35,36,37},
 	icon=""
},
[262] =
{
 		id=262,
 		command="OpenStage",
 		param1=1502,
 		desc=40262,
 		unlockIds={261},
 		unlockIdsAtLastOne={1,402,31,32,33,34,35,36,37},
 	icon=""
},
[301] =
{
 		id=301,
 		command="OpenDailyGoals",
 		param1=1024,
 		desc=40301,
 	icon=""
},
[302] =
{
 		id=302,
 		command="OpenUIVoting",
 		param1=1073,
 		desc=40302,
 	icon=""
},
[303] =
{
 		id=303,
 		command="OpenFirstRecharge",
 		desc=40303,
 	icon=""
},
[304] =
{
 		id=304,
 		command="OpenMasqueradeUI",
 	icon=""
},
[305] =
{
 		id=305,
 		command="OpenMasqueradeUI",
 		param1=2000,
 		desc=40305,
 		showLimit={9102},
 	icon=""
},
[306] =
{
 		id=306,
 		command="OpenMainFirstRecharge",
 		desc=40303,
 	icon=""
},
[307] =
{
 		id=307,
 		command="OpenActivityUI",
 		param1=8001,
 	icon=""
},
[308] =
{
 		id=308,
 		command="OpenActivityUI",
 		param1=-4,
 		desc=40307,
 	icon=""
},
[309] =
{
 		id=309,
 		command="OpenMonthSignUI",
 		desc=40308,
 	icon=""
},
[401] =
{
 		id=401,
 		command="OpenChapterSelection",
 		param1=-1,
 		desc=40401,
 		unlockIds={101},
 	icon=""
},
[402] =
{
 		id=402,
 		command="OpenChapterSelection",
 		param1=2,
 		desc=40402,
 		unlockIds={1113},
 	icon=""
},
[411] =
{
 		id=411,
 		command="OpenChapterSelection",
 		param1=-1,
 		desc=40411,
 		unlockIds={101},
 	icon=""
},
[412] =
{
 		id=412,
 		command="OpenChapterSelection",
 		param1=-1,
 		desc=40412,
 		unlockIds={1113},
 	icon=""
},
[421] =
{
 		id=421,
 		command="OpenBag",
 		label=695,
 		param1=1,
 		desc=40421,
 	icon=""
},
[422] =
{
 		id=422,
 		command="OpenBag",
 		label=695,
 		param1=1,
 		desc=40422,
 	icon=""
},
[431] =
{
 		id=431,
 		command="OpenChapterSelection",
 		label=4304,
 		param1=-1,
 		desc=40431,
 		unlockIds={101},
 	icon=""
},
[432] =
{
 		id=432,
 		command="OpenChapterSelection",
 		param1=2,
 		desc=40432,
 		unlockIds={1113},
 	icon=""
},
[501] =
{
 		id=501,
 		command="OpenLottery",
 		label=127,
 		param1=6,
 		desc=40003,
 		unlockIds={1002},
 	icon=""
},
[502] =
{
 		id=502,
 		command="OpenLottery",
 		label=127,
 		param1=7,
 		desc=40003,
 		unlockIds={1002},
 	icon=""
},
[503] =
{
 		id=503,
 		command="OpenLottery",
 		label=127,
 		param1=10,
 		desc=40003,
 		unlockIds={1002},
 	icon=""
},
[504] =
{
 		id=504,
 		command="OpenLottery",
 		label=127,
 		param1=11,
 		desc=40003,
 		unlockIds={1002},
 	icon=""
},
[505] =
{
 		id=505,
 		command="OpenLottery",
 		label=127,
 		param1=2,
 		desc=40003,
 		unlockIds={1002},
 	icon=""
},
[506] =
{
 		id=506,
 		command="OpenLottery",
 		label=127,
 		param1=12,
 		desc=40003,
 		unlockIds={1002},
 	icon=""
},
[507] =
{
 		id=507,
 		command="OpenLottery",
 		label=127,
 		param1=13,
 		desc=40003,
 		unlockIds={1002},
 	icon=""
},
[508] =
{
 		id=508,
 		command="OpenLottery",
 		label=127,
 		param1=3,
 		desc=40003,
 		unlockIds={1002},
 	icon=""
},
[509] =
{
 		id=509,
 		command="OpenLottery",
 		label=127,
 		param1=9,
 		desc=40003,
 		unlockIds={1002},
 	icon=""
},
[510] =
{
 		id=510,
 		command="OpenLottery",
 		label=127,
 		param1=14,
 		desc=40003,
 		unlockIds={1002},
 	icon=""
},
[511] =
{
 		id=511,
 		command="OpenLottery",
 		label=127,
 		param1=16,
 		desc=40003,
 		unlockIds={1002},
 	icon=""
},
[512] =
{
 		id=512,
 		command="OpenLottery",
 		label=127,
 		param1=15,
 		desc=40003,
 		unlockIds={1002},
 	icon=""
},
[513] =
{
 		id=513,
 		command="OpenLottery",
 		label=127,
 		param1=8,
 		desc=40003,
 		unlockIds={1002},
 	icon=""
},
[514] =
{
 		id=514,
 		command="OpenLottery",
 		label=127,
 		param1=5,
 		desc=40003,
 		unlockIds={1002},
 	icon=""
},
[515] =
{
 		id=515,
 		command="OpenLottery",
 		label=127,
 		param1=6,
 		desc=40003,
 		unlockIds={1002},
 	icon=""
},
[516] =
{
 		id=516,
 		command="OpenLottery",
 		label=127,
 		param1=7,
 		desc=40003,
 		unlockIds={1002},
 	icon=""
},
[517] =
{
 		id=517,
 		command="OpenLottery",
 		label=127,
 		param1=10,
 		desc=40003,
 		unlockIds={1002},
 	icon=""
},
[518] =
{
 		id=518,
 		command="OpenLottery",
 		label=127,
 		param1=11,
 		desc=40003,
 		unlockIds={1002},
 	icon=""
},
[519] =
{
 		id=519,
 		command="OpenLottery",
 		label=127,
 		param1=12,
 		desc=40003,
 		unlockIds={1002},
 	icon=""
},
[520] =
{
 		id=520,
 		command="OpenLottery",
 		label=127,
 		param1=13,
 		desc=40003,
 		unlockIds={1002},
 	icon=""
},
[521] =
{
 		id=521,
 		command="OpenLottery",
 		label=127,
 		param1=3,
 		desc=40003,
 		unlockIds={1002},
 	icon=""
},
[522] =
{
 		id=522,
 		command="OpenLottery",
 		label=127,
 		param1=9,
 		desc=40003,
 		unlockIds={1002},
 	icon=""
},
[523] =
{
 		id=523,
 		command="OpenLottery",
 		label=127,
 		param1=15,
 		desc=40003,
 		unlockIds={1002},
 	icon=""
},
[524] =
{
 		id=524,
 		command="OpenLottery",
 		label=127,
 		param1=14,
 		desc=40003,
 		unlockIds={1002},
 	icon=""
},
[525] =
{
 		id=525,
 		command="OpenLottery",
 		label=127,
 		param1=8,
 		desc=40003,
 		unlockIds={1002},
 	icon=""
},
[526] =
{
 		id=526,
 		command="OpenLottery",
 		label=127,
 		param1=5,
 		desc=40003,
 		unlockIds={1002},
 	icon=""
},
[527] =
{
 		id=527,
 		command="OpenLottery",
 		label=127,
 		param1=16,
 		desc=40003,
 		unlockIds={1002},
 	icon=""
},
[601] =
{
 		id=601,
 		command="UseItem",
 		param1=8506,
 		desc=40601,
 		showLimit={501},
 	icon=""
},
[602] =
{
 		id=602,
 		command="UseItem",
 		param1=8507,
 		desc=40602,
 		showLimit={502},
 	icon=""
},
[603] =
{
 		id=603,
 		command="UseItem",
 		param1=8508,
 		desc=40603,
 		showLimit={503},
 	icon=""
},
[604] =
{
 		id=604,
 		command="UseItem",
 		param1=8511,
 		desc=40604,
 		showLimit={504},
 	icon=""
},
[605] =
{
 		id=605,
 		command="UseItem",
 		param1=8512,
 		desc=40605,
 		showLimit={505},
 	icon=""
},
[701] =
{
 		id=701,
 		command="OpenShopUI",
 		param1=3,
 		param2=2,
 		param3=3202,
 	icon=""
},
[702] =
{
 		id=702,
 		command="OpenShopUI",
 		param1=3,
 		param2=2,
 		param3=3305,
 	icon=""
},
[1001] =
{
 		id=1001,
 		command="OpenStage",
 		param1=10101,
 		desc=41001,
 		unlockIds={101},
 	icon=""
},
[1002] =
{
 		id=1002,
 		command="OpenStage",
 		param1=10102,
 		desc=41002,
 		unlockIds={1001},
 	icon=""
},
[1003] =
{
 		id=1003,
 		command="OpenStage",
 		param1=10103,
 		desc=41003,
 		unlockIds={1002},
 	icon=""
},
[1004] =
{
 		id=1004,
 		command="OpenStage",
 		param1=10104,
 		desc=41004,
 		unlockIds={1003},
 	icon=""
},
[1005] =
{
 		id=1005,
 		command="OpenStage",
 		param1=10105,
 		desc=41005,
 		unlockIds={1004},
 	icon=""
},
[1006] =
{
 		id=1006,
 		command="OpenStage",
 		param1=10107,
 		desc=41006,
 		unlockIds={1005},
 	icon=""
},
[1007] =
{
 		id=1007,
 		command="OpenStage",
 		param1=10108,
 		desc=41007,
 		unlockIds={1006},
 	icon=""
},
[1008] =
{
 		id=1008,
 		command="OpenStage",
 		param1=10109,
 		desc=41008,
 		unlockIds={1007},
 	icon=""
},
[1009] =
{
 		id=1009,
 		command="OpenStage",
 		param1=10111,
 		desc=41009,
 		unlockIds={1008},
 	icon=""
},
[1010] =
{
 		id=1010,
 		command="OpenStage",
 		param1=10112,
 		desc=41010,
 		unlockIds={1009},
 	icon=""
},
[1101] =
{
 		id=1101,
 		command="OpenStage",
 		param1=20101,
 		desc=41101,
 		unlockIds={1010},
 	icon=""
},
[1102] =
{
 		id=1102,
 		command="OpenStage",
 		param1=20102,
 		desc=41102,
 		unlockIds={1101},
 	icon=""
},
[1103] =
{
 		id=1103,
 		command="OpenStage",
 		param1=20104,
 		desc=41103,
 		unlockIds={1102},
 	icon=""
},
[1104] =
{
 		id=1104,
 		command="OpenStage",
 		param1=20108,
 		desc=41104,
 		unlockIds={1103},
 	icon=""
},
[1105] =
{
 		id=1105,
 		command="OpenStage",
 		param1=20114,
 		desc=41105,
 		unlockIds={1104},
 	icon=""
},
[1106] =
{
 		id=1106,
 		command="OpenStage",
 		param1=20109,
 		desc=41106,
 		unlockIds={1105},
 	icon=""
},
[1107] =
{
 		id=1107,
 		command="OpenStage",
 		param1=20115,
 		desc=41107,
 		unlockIds={1106},
 	icon=""
},
[1108] =
{
 		id=1108,
 		command="OpenStage",
 		param1=20107,
 		desc=41108,
 		unlockIds={1107},
 	icon=""
},
[1109] =
{
 		id=1109,
 		command="OpenStage",
 		param1=20113,
 		desc=41109,
 		unlockIds={1108},
 	icon=""
},
[1110] =
{
 		id=1110,
 		command="OpenStage",
 		param1=20103,
 		desc=41110,
 		unlockIds={1109},
 	icon=""
},
[1111] =
{
 		id=1111,
 		command="OpenStage",
 		param1=20110,
 		desc=41111,
 		unlockIds={1110},
 	icon=""
},
[1112] =
{
 		id=1112,
 		command="OpenStage",
 		param1=20105,
 		desc=41112,
 		unlockIds={1111},
 	icon=""
},
[1113] =
{
 		id=1113,
 		command="OpenStage",
 		param1=20111,
 		desc=41113,
 		unlockIds={1112},
 	icon=""
},
[1201] =
{
 		id=1201,
 		command="OpenStage",
 		param1=30101,
 		desc=41201,
 		unlockIds={1113},
 	icon=""
},
[1202] =
{
 		id=1202,
 		command="OpenStage",
 		param1=30102,
 		desc=41202,
 		unlockIds={1201},
 	icon=""
},
[1203] =
{
 		id=1203,
 		command="OpenStage",
 		param1=30113,
 		desc=41203,
 		unlockIds={1202},
 	icon=""
},
[1204] =
{
 		id=1204,
 		command="OpenStage",
 		param1=30103,
 		desc=41204,
 		unlockIds={1203},
 	icon=""
},
[1205] =
{
 		id=1205,
 		command="OpenStage",
 		param1=30104,
 		desc=41205,
 		unlockIds={1204},
 	icon=""
},
[1206] =
{
 		id=1206,
 		command="OpenStage",
 		param1=30105,
 		desc=41206,
 		unlockIds={1205},
 	icon=""
},
[1207] =
{
 		id=1207,
 		command="OpenStage",
 		param1=30114,
 		desc=41207,
 		unlockIds={1206},
 	icon=""
},
[1208] =
{
 		id=1208,
 		command="OpenStage",
 		param1=30107,
 		desc=41208,
 		unlockIds={1207},
 	icon=""
},
[1209] =
{
 		id=1209,
 		command="OpenStage",
 		param1=30108,
 		desc=41209,
 		unlockIds={1208},
 	icon=""
},
[1210] =
{
 		id=1210,
 		command="OpenStage",
 		param1=30109,
 		desc=41210,
 		unlockIds={1209},
 	icon=""
},
[1211] =
{
 		id=1211,
 		command="OpenStage",
 		param1=30110,
 		desc=41211,
 		unlockIds={1210},
 	icon=""
},
[1212] =
{
 		id=1212,
 		command="OpenStage",
 		param1=30115,
 		desc=41212,
 		unlockIds={1211},
 	icon=""
},
[1213] =
{
 		id=1213,
 		command="OpenStage",
 		param1=30111,
 		desc=41213,
 		unlockIds={1212},
 	icon=""
},
[1301] =
{
 		id=1301,
 		command="OpenStage",
 		param1=40101,
 		desc=41301,
 		unlockIds={1213},
 	icon=""
},
[1302] =
{
 		id=1302,
 		command="OpenStage",
 		param1=40102,
 		desc=41302,
 		unlockIds={1301},
 	icon=""
},
[1303] =
{
 		id=1303,
 		command="OpenStage",
 		param1=40103,
 		desc=41303,
 		unlockIds={1302},
 	icon=""
},
[1304] =
{
 		id=1304,
 		command="OpenStage",
 		param1=40104,
 		desc=41304,
 		unlockIds={1303},
 	icon=""
},
[1305] =
{
 		id=1305,
 		command="OpenStage",
 		param1=40105,
 		desc=41305,
 		unlockIds={1304},
 	icon=""
},
[1306] =
{
 		id=1306,
 		command="OpenStage",
 		param1=40107,
 		desc=41306,
 		unlockIds={1305},
 	icon=""
},
[1307] =
{
 		id=1307,
 		command="OpenStage",
 		param1=40108,
 		desc=41307,
 		unlockIds={1306},
 	icon=""
},
[1308] =
{
 		id=1308,
 		command="OpenStage",
 		param1=40113,
 		desc=41308,
 		unlockIds={1307},
 	icon=""
},
[1309] =
{
 		id=1309,
 		command="OpenStage",
 		param1=40114,
 		desc=41309,
 		unlockIds={1308},
 	icon=""
},
[1310] =
{
 		id=1310,
 		command="OpenStage",
 		param1=40115,
 		desc=41310,
 		unlockIds={1309},
 	icon=""
},
[1311] =
{
 		id=1311,
 		command="OpenStage",
 		param1=40109,
 		desc=41311,
 		unlockIds={1310},
 	icon=""
},
[1312] =
{
 		id=1312,
 		command="OpenStage",
 		param1=40110,
 		desc=41312,
 		unlockIds={1311},
 	icon=""
},
[1313] =
{
 		id=1313,
 		command="OpenStage",
 		param1=40111,
 		desc=41313,
 		unlockIds={1312},
 	icon=""
},
[1401] =
{
 		id=1401,
 		command="OpenStage",
 		param1=50101,
 		desc=41401,
 		unlockIds={1313},
 	icon=""
},
[1402] =
{
 		id=1402,
 		command="OpenStage",
 		param1=50102,
 		desc=41402,
 		unlockIds={1401},
 	icon=""
},
[1403] =
{
 		id=1403,
 		command="OpenStage",
 		param1=50103,
 		desc=41403,
 		unlockIds={1402},
 	icon=""
},
[1404] =
{
 		id=1404,
 		command="OpenStage",
 		param1=50104,
 		desc=41404,
 		unlockIds={1403},
 	icon=""
},
[1405] =
{
 		id=1405,
 		command="OpenStage",
 		param1=50105,
 		desc=41405,
 		unlockIds={1404},
 	icon=""
},
[1406] =
{
 		id=1406,
 		command="OpenStage",
 		param1=50106,
 		desc=41406,
 		unlockIds={1405},
 	icon=""
},
[1407] =
{
 		id=1407,
 		command="OpenStage",
 		param1=50108,
 		desc=41407,
 		unlockIds={1406},
 	icon=""
},
[1408] =
{
 		id=1408,
 		command="OpenStage",
 		param1=50107,
 		desc=41408,
 		unlockIds={1407},
 	icon=""
},
[1409] =
{
 		id=1409,
 		command="OpenStage",
 		param1=50109,
 		desc=41409,
 		unlockIds={1408},
 	icon=""
},
[1410] =
{
 		id=1410,
 		command="OpenStage",
 		param1=50110,
 		desc=41410,
 		unlockIds={1409},
 	icon=""
},
[1411] =
{
 		id=1411,
 		command="OpenStage",
 		param1=50111,
 		desc=41411,
 		unlockIds={1410},
 	icon=""
},
[1412] =
{
 		id=1412,
 		command="OpenStage",
 		param1=50112,
 		desc=41412,
 		unlockIds={1411},
 	icon=""
},
[1413] =
{
 		id=1413,
 		command="OpenStage",
 		param1=50113,
 		desc=41413,
 		unlockIds={1412},
 	icon=""
},
[1414] =
{
 		id=1414,
 		command="OpenStage",
 		param1=50114,
 		desc=41414,
 		unlockIds={1413},
 	icon=""
},
[1415] =
{
 		id=1415,
 		command="OpenStage",
 		param1=50115,
 		desc=41415,
 		unlockIds={1414},
 	icon=""
},
[1501] =
{
 		id=1501,
 		command="OpenStage",
 		param1=60101,
 		desc=41501,
 		unlockIds={1415},
 	icon=""
},
[1502] =
{
 		id=1502,
 		command="OpenStage",
 		param1=60102,
 		desc=41502,
 		unlockIds={1501},
 	icon=""
},
[1503] =
{
 		id=1503,
 		command="OpenStage",
 		param1=60103,
 		desc=41503,
 		unlockIds={1502},
 	icon=""
},
[1504] =
{
 		id=1504,
 		command="OpenStage",
 		param1=60104,
 		desc=41504,
 		unlockIds={1503},
 	icon=""
},
[1505] =
{
 		id=1505,
 		command="OpenStage",
 		param1=60105,
 		desc=41505,
 		unlockIds={1504},
 	icon=""
},
[1506] =
{
 		id=1506,
 		command="OpenStage",
 		param1=60106,
 		desc=41506,
 		unlockIds={1505},
 	icon=""
},
[1507] =
{
 		id=1507,
 		command="OpenStage",
 		param1=60107,
 		desc=41507,
 		unlockIds={1506},
 	icon=""
},
[1508] =
{
 		id=1508,
 		command="OpenStage",
 		param1=60108,
 		desc=41508,
 		unlockIds={1507},
 	icon=""
},
[1509] =
{
 		id=1509,
 		command="OpenStage",
 		param1=60109,
 		desc=41509,
 		unlockIds={1508},
 	icon=""
},
[1510] =
{
 		id=1510,
 		command="OpenStage",
 		param1=60110,
 		desc=41510,
 		unlockIds={1509},
 	icon=""
},
[1511] =
{
 		id=1511,
 		command="OpenStage",
 		param1=60111,
 		desc=41511,
 		unlockIds={1510},
 	icon=""
},
[1512] =
{
 		id=1512,
 		command="OpenStage",
 		param1=60112,
 		desc=41512,
 		unlockIds={1511},
 	icon=""
},
[1513] =
{
 		id=1513,
 		command="OpenStage",
 		param1=60113,
 		desc=41513,
 		unlockIds={1512},
 	icon=""
},
[1514] =
{
 		id=1514,
 		command="OpenStage",
 		param1=60114,
 		desc=41514,
 		unlockIds={1513},
 	icon=""
},
[1515] =
{
 		id=1515,
 		command="OpenStage",
 		param1=60115,
 		desc=41515,
 		unlockIds={1514},
 	icon=""
},
[2001] =
{
 		id=2001,
 		command="OpenStage",
 		param1=10201,
 		desc=42001,
 		unlockIds={1113},
 	icon=""
},
[2002] =
{
 		id=2002,
 		command="OpenStage",
 		param1=10202,
 		desc=42002,
 		unlockIds={2001},
 	icon=""
},
[2003] =
{
 		id=2003,
 		command="OpenStage",
 		param1=10203,
 		desc=42003,
 		unlockIds={2002},
 	icon=""
},
[2004] =
{
 		id=2004,
 		command="OpenStage",
 		param1=10204,
 		desc=42004,
 		unlockIds={2003},
 	icon=""
},
[2005] =
{
 		id=2005,
 		command="OpenStage",
 		param1=10205,
 		desc=42005,
 		unlockIds={2004},
 	icon=""
},
[2006] =
{
 		id=2006,
 		command="OpenStage",
 		param1=10207,
 		desc=42006,
 		unlockIds={2005},
 	icon=""
},
[2007] =
{
 		id=2007,
 		command="OpenStage",
 		param1=10208,
 		desc=42007,
 		unlockIds={2006},
 	icon=""
},
[2008] =
{
 		id=2008,
 		command="OpenStage",
 		param1=10209,
 		desc=42008,
 		unlockIds={2007},
 	icon=""
},
[2009] =
{
 		id=2009,
 		command="OpenStage",
 		param1=10210,
 		desc=42009,
 		unlockIds={2008},
 	icon=""
},
[2010] =
{
 		id=2010,
 		command="OpenStage",
 		param1=10211,
 		desc=42010,
 		unlockIds={2009},
 	icon=""
},
[2101] =
{
 		id=2101,
 		command="OpenStage",
 		param1=20201,
 		desc=42101,
 		unlockIds={2010},
 	icon=""
},
[2102] =
{
 		id=2102,
 		command="OpenStage",
 		param1=20202,
 		desc=42102,
 		unlockIds={2101},
 	icon=""
},
[2103] =
{
 		id=2103,
 		command="OpenStage",
 		param1=20204,
 		desc=42103,
 		unlockIds={2102},
 	icon=""
},
[2104] =
{
 		id=2104,
 		command="OpenStage",
 		param1=20208,
 		desc=42104,
 		unlockIds={2103},
 	icon=""
},
[2105] =
{
 		id=2105,
 		command="OpenStage",
 		param1=20214,
 		desc=42105,
 		unlockIds={2104},
 	icon=""
},
[2106] =
{
 		id=2106,
 		command="OpenStage",
 		param1=20209,
 		desc=42106,
 		unlockIds={2105},
 	icon=""
},
[2107] =
{
 		id=2107,
 		command="OpenStage",
 		param1=20215,
 		desc=42107,
 		unlockIds={2106},
 	icon=""
},
[2108] =
{
 		id=2108,
 		command="OpenStage",
 		param1=20207,
 		desc=42108,
 		unlockIds={2107},
 	icon=""
},
[2109] =
{
 		id=2109,
 		command="OpenStage",
 		param1=20213,
 		desc=42109,
 		unlockIds={2108},
 	icon=""
},
[2110] =
{
 		id=2110,
 		command="OpenStage",
 		param1=20203,
 		desc=42110,
 		unlockIds={2109},
 	icon=""
},
[2111] =
{
 		id=2111,
 		command="OpenStage",
 		param1=20205,
 		desc=42111,
 		unlockIds={2110},
 	icon=""
},
[2112] =
{
 		id=2112,
 		command="OpenStage",
 		param1=20210,
 		desc=42112,
 		unlockIds={2111},
 	icon=""
},
[2113] =
{
 		id=2113,
 		command="OpenStage",
 		param1=20211,
 		desc=42113,
 		unlockIds={2112},
 	icon=""
},
[2201] =
{
 		id=2201,
 		command="OpenStage",
 		param1=30201,
 		desc=42201,
 		unlockIds={2113},
 	icon=""
},
[2202] =
{
 		id=2202,
 		command="OpenStage",
 		param1=30202,
 		desc=42202,
 		unlockIds={2201},
 	icon=""
},
[2203] =
{
 		id=2203,
 		command="OpenStage",
 		param1=30213,
 		desc=42203,
 		unlockIds={2202},
 	icon=""
},
[2204] =
{
 		id=2204,
 		command="OpenStage",
 		param1=30203,
 		desc=42204,
 		unlockIds={2203},
 	icon=""
},
[2205] =
{
 		id=2205,
 		command="OpenStage",
 		param1=30204,
 		desc=42205,
 		unlockIds={2204},
 	icon=""
},
[2206] =
{
 		id=2206,
 		command="OpenStage",
 		param1=30205,
 		desc=42206,
 		unlockIds={2205},
 	icon=""
},
[2207] =
{
 		id=2207,
 		command="OpenStage",
 		param1=30214,
 		desc=42207,
 		unlockIds={2206},
 	icon=""
},
[2208] =
{
 		id=2208,
 		command="OpenStage",
 		param1=30207,
 		desc=42208,
 		unlockIds={2207},
 	icon=""
},
[2209] =
{
 		id=2209,
 		command="OpenStage",
 		param1=30208,
 		desc=42209,
 		unlockIds={2208},
 	icon=""
},
[2210] =
{
 		id=2210,
 		command="OpenStage",
 		param1=30209,
 		desc=42210,
 		unlockIds={2209},
 	icon=""
},
[2211] =
{
 		id=2211,
 		command="OpenStage",
 		param1=30210,
 		desc=42211,
 		unlockIds={2210},
 	icon=""
},
[2212] =
{
 		id=2212,
 		command="OpenStage",
 		param1=30215,
 		desc=42212,
 		unlockIds={2211},
 	icon=""
},
[2213] =
{
 		id=2213,
 		command="OpenStage",
 		param1=30211,
 		desc=42213,
 		unlockIds={2212},
 	icon=""
},
[2301] =
{
 		id=2301,
 		command="OpenStage",
 		param1=40201,
 		desc=42301,
 		unlockIds={2213},
 	icon=""
},
[2302] =
{
 		id=2302,
 		command="OpenStage",
 		param1=40202,
 		desc=42302,
 		unlockIds={2301},
 	icon=""
},
[2303] =
{
 		id=2303,
 		command="OpenStage",
 		param1=40203,
 		desc=42303,
 		unlockIds={2302},
 	icon=""
},
[2304] =
{
 		id=2304,
 		command="OpenStage",
 		param1=40204,
 		desc=42304,
 		unlockIds={2303},
 	icon=""
},
[2305] =
{
 		id=2305,
 		command="OpenStage",
 		param1=40205,
 		desc=42305,
 		unlockIds={2304},
 	icon=""
},
[2306] =
{
 		id=2306,
 		command="OpenStage",
 		param1=40207,
 		desc=42306,
 		unlockIds={2305},
 	icon=""
},
[2307] =
{
 		id=2307,
 		command="OpenStage",
 		param1=40208,
 		desc=42307,
 		unlockIds={2306},
 	icon=""
},
[2308] =
{
 		id=2308,
 		command="OpenStage",
 		param1=40213,
 		desc=42308,
 		unlockIds={2307},
 	icon=""
},
[2309] =
{
 		id=2309,
 		command="OpenStage",
 		param1=40214,
 		desc=42309,
 		unlockIds={2308},
 	icon=""
},
[2310] =
{
 		id=2310,
 		command="OpenStage",
 		param1=40215,
 		desc=42310,
 		unlockIds={2309},
 	icon=""
},
[2311] =
{
 		id=2311,
 		command="OpenStage",
 		param1=40209,
 		desc=42311,
 		unlockIds={2310},
 	icon=""
},
[2312] =
{
 		id=2312,
 		command="OpenStage",
 		param1=40210,
 		desc=42312,
 		unlockIds={2311},
 	icon=""
},
[2313] =
{
 		id=2313,
 		command="OpenStage",
 		param1=40211,
 		desc=42313,
 		unlockIds={2312},
 	icon=""
},
[2401] =
{
 		id=2401,
 		command="OpenStage",
 		param1=50201,
 		desc=42401,
 		unlockIds={2313},
 	icon=""
},
[2402] =
{
 		id=2402,
 		command="OpenStage",
 		param1=50202,
 		desc=42402,
 		unlockIds={2401},
 	icon=""
},
[2403] =
{
 		id=2403,
 		command="OpenStage",
 		param1=50203,
 		desc=42403,
 		unlockIds={2402},
 	icon=""
},
[2404] =
{
 		id=2404,
 		command="OpenStage",
 		param1=50204,
 		desc=42404,
 		unlockIds={2403},
 	icon=""
},
[2405] =
{
 		id=2405,
 		command="OpenStage",
 		param1=50205,
 		desc=42405,
 		unlockIds={2404},
 	icon=""
},
[2406] =
{
 		id=2406,
 		command="OpenStage",
 		param1=50206,
 		desc=42406,
 		unlockIds={2405},
 	icon=""
},
[2407] =
{
 		id=2407,
 		command="OpenStage",
 		param1=50208,
 		desc=42407,
 		unlockIds={2406},
 	icon=""
},
[2408] =
{
 		id=2408,
 		command="OpenStage",
 		param1=50207,
 		desc=42408,
 		unlockIds={2407},
 	icon=""
},
[2409] =
{
 		id=2409,
 		command="OpenStage",
 		param1=50209,
 		desc=42409,
 		unlockIds={2408},
 	icon=""
},
[2410] =
{
 		id=2410,
 		command="OpenStage",
 		param1=50210,
 		desc=42410,
 		unlockIds={2409},
 	icon=""
},
[2411] =
{
 		id=2411,
 		command="OpenStage",
 		param1=50211,
 		desc=42411,
 		unlockIds={2410},
 	icon=""
},
[2412] =
{
 		id=2412,
 		command="OpenStage",
 		param1=50212,
 		desc=42412,
 		unlockIds={2411},
 	icon=""
},
[2413] =
{
 		id=2413,
 		command="OpenStage",
 		param1=50213,
 		desc=42413,
 		unlockIds={2412},
 	icon=""
},
[2414] =
{
 		id=2414,
 		command="OpenStage",
 		param1=50214,
 		desc=42414,
 		unlockIds={2413},
 	icon=""
},
[2415] =
{
 		id=2415,
 		command="OpenStage",
 		param1=50215,
 		desc=42415,
 		unlockIds={2414},
 	icon=""
},
[2501] =
{
 		id=2501,
 		command="OpenStage",
 		param1=60201,
 		desc=42501,
 		unlockIds={2415},
 	icon=""
},
[2502] =
{
 		id=2502,
 		command="OpenStage",
 		param1=60202,
 		desc=42502,
 		unlockIds={2501},
 	icon=""
},
[2503] =
{
 		id=2503,
 		command="OpenStage",
 		param1=60203,
 		desc=42503,
 		unlockIds={2502},
 	icon=""
},
[2504] =
{
 		id=2504,
 		command="OpenStage",
 		param1=60204,
 		desc=42504,
 		unlockIds={2503},
 	icon=""
},
[2505] =
{
 		id=2505,
 		command="OpenStage",
 		param1=60205,
 		desc=42505,
 		unlockIds={2504},
 	icon=""
},
[2506] =
{
 		id=2506,
 		command="OpenStage",
 		param1=60206,
 		desc=42506,
 		unlockIds={2505},
 	icon=""
},
[2507] =
{
 		id=2507,
 		command="OpenStage",
 		param1=60207,
 		desc=42507,
 		unlockIds={2506},
 	icon=""
},
[2508] =
{
 		id=2508,
 		command="OpenStage",
 		param1=60208,
 		desc=42508,
 		unlockIds={2507},
 	icon=""
},
[2509] =
{
 		id=2509,
 		command="OpenStage",
 		param1=60209,
 		desc=42509,
 		unlockIds={2508},
 	icon=""
},
[2510] =
{
 		id=2510,
 		command="OpenStage",
 		param1=60210,
 		desc=42510,
 		unlockIds={2509},
 	icon=""
},
[2511] =
{
 		id=2511,
 		command="OpenStage",
 		param1=60211,
 		desc=42511,
 		unlockIds={2510},
 	icon=""
},
[2512] =
{
 		id=2512,
 		command="OpenStage",
 		param1=60212,
 		desc=42512,
 		unlockIds={2511},
 	icon=""
},
[2513] =
{
 		id=2513,
 		command="OpenStage",
 		param1=60213,
 		desc=42513,
 		unlockIds={2512},
 	icon=""
},
[2514] =
{
 		id=2514,
 		command="OpenStage",
 		param1=60214,
 		desc=42514,
 		unlockIds={2513},
 	icon=""
},
[2515] =
{
 		id=2515,
 		command="OpenStage",
 		param1=60215,
 		desc=42515,
 		unlockIds={2514},
 	icon=""
},
[3004] =
{
 		id=3004,
 		command="OpenStage",
 		param1=10404,
 		desc=43004,
 		unlockIds={1003},
 	icon=""
},
[3005] =
{
 		id=3005,
 		command="OpenStage",
 		param1=10405,
 		desc=43005,
 		unlockIds={1004},
 	icon=""
},
[3006] =
{
 		id=3006,
 		command="OpenStage",
 		param1=10406,
 		desc=43006,
 		unlockIds={1005},
 	icon=""
},
[3009] =
{
 		id=3009,
 		command="OpenStage",
 		param1=10409,
 		desc=43009,
 		unlockIds={1008},
 	icon=""
},
[3102] =
{
 		id=3102,
 		command="OpenStage",
 		param1=20402,
 		desc=43101,
 		unlockIds={1101},
 	icon=""
},
[3103] =
{
 		id=3103,
 		command="OpenStage",
 		param1=20404,
 		desc=43103,
 		unlockIds={1102},
 	icon=""
},
[3110] =
{
 		id=3110,
 		command="OpenStage",
 		param1=20403,
 		desc=43110,
 		unlockIds={1109},
 	icon=""
},
[3112] =
{
 		id=3112,
 		command="OpenStage",
 		param1=20405,
 		desc=43110,
 		unlockIds={1111},
 	icon=""
},
[3201] =
{
 		id=3201,
 		command="OpenStage",
 		param1=30401,
 		desc=43201,
 		unlockIds={1113},
 	icon=""
},
[3202] =
{
 		id=3202,
 		command="OpenStage",
 		param1=30402,
 		desc=43202,
 		unlockIds={1201},
 	icon=""
},
[3204] =
{
 		id=3204,
 		command="OpenStage",
 		param1=30403,
 		desc=43204,
 		unlockIds={1203},
 	icon=""
},
[3301] =
{
 		id=3301,
 		command="OpenStage",
 		param1=40401,
 		desc=43301,
 		unlockIds={1213},
 	icon=""
},
[3302] =
{
 		id=3302,
 		command="OpenStage",
 		param1=40402,
 		desc=43302,
 		unlockIds={1301},
 	icon=""
},
[3306] =
{
 		id=3306,
 		command="OpenStage",
 		param1=40407,
 		desc=43306,
 		unlockIds={1305},
 	icon=""
},
[3401] =
{
 		id=3401,
 		command="OpenStage",
 		param1=50401,
 		desc=43401,
 		unlockIds={1400},
 	icon=""
},
[3404] =
{
 		id=3404,
 		command="OpenStage",
 		param1=50404,
 		desc=43404,
 		unlockIds={1403},
 	icon=""
},
[3406] =
{
 		id=3406,
 		command="OpenStage",
 		param1=50406,
 		desc=43406,
 		unlockIds={1405},
 	icon=""
},
[3407] =
{
 		id=3407,
 		command="OpenStage",
 		param1=50408,
 		desc=43407,
 		unlockIds={1406},
 	icon=""
},
[3502] =
{
 		id=3502,
 		command="OpenStage",
 		param1=60402,
 		desc=43502,
 		unlockIds={1501},
 	icon=""
},
[3505] =
{
 		id=3505,
 		command="OpenStage",
 		param1=60405,
 		desc=43505,
 		unlockIds={1504},
 	icon=""
},
[3507] =
{
 		id=3507,
 		command="OpenStage",
 		param1=60407,
 		desc=43507,
 		unlockIds={1506},
 	icon=""
},
[3508] =
{
 		id=3508,
 		command="OpenStage",
 		param1=60408,
 		desc=43508,
 		unlockIds={1507},
 	icon=""
},
[4205] =
{
 		id=4205,
 		command="OpenStage",
 		param1=30504,
 		desc=44205,
 		unlockIds={1205},
 	icon=""
},
[4208] =
{
 		id=4208,
 		command="OpenStage",
 		param1=30507,
 		desc=44208,
 		unlockIds={1208},
 	icon=""
},
[4210] =
{
 		id=4210,
 		command="OpenStage",
 		param1=30509,
 		desc=44210,
 		unlockIds={1210},
 	icon=""
},
[4306] =
{
 		id=4306,
 		command="OpenStage",
 		param1=40504,
 		desc=44306,
 		unlockIds={1306},
 	icon=""
},
[4309] =
{
 		id=4309,
 		command="OpenStage",
 		param1=40514,
 		desc=44309,
 		unlockIds={1309},
 	icon=""
},
[4402] =
{
 		id=4402,
 		command="OpenStage",
 		param1=50502,
 		desc=44402,
 		unlockIds={1402},
 	icon=""
},
[4406] =
{
 		id=4406,
 		command="OpenStage",
 		param1=50506,
 		desc=44406,
 		unlockIds={1406},
 	icon=""
},
[4410] =
{
 		id=4410,
 		command="OpenStage",
 		param1=50510,
 		desc=44410,
 		unlockIds={1410},
 	icon=""
},
[4503] =
{
 		id=4503,
 		command="OpenStage",
 		param1=60503,
 		desc=44503,
 		unlockIds={1503},
 	icon=""
},
[4508] =
{
 		id=4508,
 		command="OpenStage",
 		param1=60508,
 		desc=44508,
 		unlockIds={1508},
 	icon=""
},
[5101] =
{
 		id=5101,
 		command="OpenStage",
 		param1=802101,
 		param2=2000,
 		desc=45101,
 		showLimit={9102},
 	icon=""
},
[5102] =
{
 		id=5102,
 		command="OpenStage",
 		param1=802102,
 		param2=2000,
 		desc=45102,
 		showLimit={9102},
 		unlockIds={5101},
 	icon=""
},
[5103] =
{
 		id=5103,
 		command="OpenStage",
 		param1=802103,
 		param2=2000,
 		desc=45103,
 		showLimit={9102},
 		unlockIds={5102},
 	icon=""
},
[5104] =
{
 		id=5104,
 		command="OpenStage",
 		param1=802104,
 		param2=2000,
 		desc=45104,
 		showLimit={9102},
 		unlockIds={5103},
 	icon=""
},
[5105] =
{
 		id=5105,
 		command="OpenStage",
 		param1=802105,
 		param2=2000,
 		desc=45105,
 		showLimit={9102},
 		unlockIds={5104},
 	icon=""
},
[5106] =
{
 		id=5106,
 		command="OpenStage",
 		param1=802106,
 		param2=2000,
 		desc=45106,
 		showLimit={9102},
 		unlockIds={5105},
 	icon=""
},
[5107] =
{
 		id=5107,
 		command="OpenStage",
 		param1=802107,
 		param2=2000,
 		desc=45107,
 		showLimit={9102},
 		unlockIds={5106},
 	icon=""
},
[5108] =
{
 		id=5108,
 		command="OpenStage",
 		param1=802108,
 		param2=2000,
 		desc=45108,
 		showLimit={9102},
 		unlockIds={5107},
 	icon=""
},
[5109] =
{
 		id=5109,
 		command="OpenStage",
 		param1=802109,
 		param2=2000,
 		desc=45109,
 		showLimit={9102},
 		unlockIds={5108},
 	icon=""
},
[5110] =
{
 		id=5110,
 		command="OpenStage",
 		param1=802110,
 		param2=2000,
 		desc=45110,
 		showLimit={9102},
 		unlockIds={5109},
 	icon=""
},
[5111] =
{
 		id=5111,
 		command="OpenStage",
 		param1=802111,
 		param2=2000,
 		desc=45111,
 		showLimit={9102},
 		unlockIds={5110},
 	icon=""
},
[5112] =
{
 		id=5112,
 		command="OpenStage",
 		param1=802112,
 		param2=2000,
 		desc=45112,
 		showLimit={9102},
 		unlockIds={5111},
 	icon=""
},
[5201] =
{
 		id=5201,
 		command="OpenStage",
 		param1=802201,
 		param2=2000,
 		desc=45201,
 		showLimit={9102},
 		unlockIds={5112},
 	icon=""
},
[5202] =
{
 		id=5202,
 		command="OpenStage",
 		param1=802202,
 		param2=2000,
 		desc=45202,
 		showLimit={9102},
 		unlockIds={5201},
 	icon=""
},
[5203] =
{
 		id=5203,
 		command="OpenStage",
 		param1=802203,
 		param2=2000,
 		desc=45203,
 		showLimit={9102},
 		unlockIds={5202},
 	icon=""
},
[5204] =
{
 		id=5204,
 		command="OpenStage",
 		param1=802204,
 		param2=2000,
 		desc=45204,
 		showLimit={9102},
 		unlockIds={5203},
 	icon=""
},
[5205] =
{
 		id=5205,
 		command="OpenStage",
 		param1=802205,
 		param2=2000,
 		desc=45205,
 		showLimit={9102},
 		unlockIds={5204},
 	icon=""
},
[5206] =
{
 		id=5206,
 		command="OpenStage",
 		param1=802206,
 		param2=2000,
 		desc=45206,
 		showLimit={9102},
 		unlockIds={5205},
 	icon=""
},
[5207] =
{
 		id=5207,
 		command="OpenStage",
 		param1=802207,
 		param2=2000,
 		desc=45207,
 		showLimit={9102},
 		unlockIds={5206},
 	icon=""
},
[5208] =
{
 		id=5208,
 		command="OpenStage",
 		param1=802208,
 		param2=2000,
 		desc=45208,
 		showLimit={9102},
 		unlockIds={5207},
 	icon=""
},
[5209] =
{
 		id=5209,
 		command="OpenStage",
 		param1=802209,
 		param2=2000,
 		desc=45209,
 		showLimit={9102},
 		unlockIds={5208},
 	icon=""
},
[5210] =
{
 		id=5210,
 		command="OpenStage",
 		param1=802210,
 		param2=2000,
 		desc=45210,
 		showLimit={9102},
 		unlockIds={5209},
 	icon=""
},
[5211] =
{
 		id=5211,
 		command="OpenStage",
 		param1=802211,
 		param2=2000,
 		desc=45211,
 		showLimit={9102},
 		unlockIds={5210},
 	icon=""
},
[5212] =
{
 		id=5212,
 		command="OpenStage",
 		param1=802212,
 		param2=2000,
 		desc=45212,
 		showLimit={9102},
 		unlockIds={5211},
 	icon=""
},
[5301] =
{
 		id=5301,
 		command="OpenStage",
 		param1=801102,
 		param2=3001,
 		desc=45301,
 		showLimit={9103},
 		unlockIds={1206},
 	icon=""
},
[5302] =
{
 		id=5302,
 		command="OpenStage",
 		param1=801103,
 		param2=3001,
 		desc=45302,
 		showLimit={9103},
 		unlockIds={5301},
 	icon=""
},
[5303] =
{
 		id=5303,
 		command="OpenStage",
 		param1=801105,
 		param2=3001,
 		desc=45303,
 		showLimit={9103},
 		unlockIds={5302},
 	icon=""
},
[5304] =
{
 		id=5304,
 		command="OpenStage",
 		param1=801106,
 		param2=3001,
 		desc=45304,
 		showLimit={9103},
 		unlockIds={5303},
 	icon=""
},
[5305] =
{
 		id=5305,
 		command="OpenStage",
 		param1=801107,
 		param2=3001,
 		desc=45305,
 		showLimit={9103},
 		unlockIds={5304},
 	icon=""
},
[5306] =
{
 		id=5306,
 		command="OpenStage",
 		param1=801108,
 		param2=3001,
 		desc=45306,
 		showLimit={9103},
 		unlockIds={5305},
 	icon=""
},
[5307] =
{
 		id=5307,
 		command="OpenStage",
 		param1=801109,
 		param2=3001,
 		desc=45307,
 		showLimit={9103},
 		unlockIds={5306},
 	icon=""
},
[5308] =
{
 		id=5308,
 		command="OpenStage",
 		param1=801110,
 		param2=3001,
 		desc=45308,
 		showLimit={9103},
 		unlockIds={5307},
 	icon=""
},
[5311] =
{
 		id=5311,
 		command="OpenStage",
 		param1=801201,
 		param2=3001,
 		desc=45311,
 		showLimit={9103},
 		unlockIds={5309},
 	icon=""
},
[5312] =
{
 		id=5312,
 		command="OpenStage",
 		param1=801202,
 		param2=3001,
 		desc=45312,
 		showLimit={9103},
 		unlockIds={5311},
 	icon=""
},
[5313] =
{
 		id=5313,
 		command="OpenStage",
 		param1=801203,
 		param2=3001,
 		desc=45313,
 		showLimit={9103},
 		unlockIds={5312},
 	icon=""
},
[5314] =
{
 		id=5314,
 		command="OpenStage",
 		param1=801204,
 		param2=3001,
 		desc=45314,
 		showLimit={9103},
 		unlockIds={5313},
 	icon=""
},
[5315] =
{
 		id=5315,
 		command="OpenStage",
 		param1=801205,
 		param2=3001,
 		desc=45315,
 		showLimit={9103},
 		unlockIds={5314},
 	icon=""
},
[5316] =
{
 		id=5316,
 		command="OpenStage",
 		param1=801206,
 		param2=3001,
 		desc=45316,
 		showLimit={9103},
 		unlockIds={5315},
 	icon=""
},
[5317] =
{
 		id=5317,
 		command="OpenStage",
 		param1=801207,
 		param2=3001,
 		desc=45317,
 		showLimit={9103},
 		unlockIds={5316},
 	icon=""
},
[5318] =
{
 		id=5318,
 		command="OpenStage",
 		param1=801208,
 		param2=3001,
 		desc=45318,
 		showLimit={9103},
 		unlockIds={5317},
 	icon=""
}
}

return {title=title, value=value}