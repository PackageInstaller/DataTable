-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_red_point_ex_once.lua

module("logicconfig.config.t_red_point_ex_once", package.seeall)

local title = {
	viewName = 2,
	startUnlockTime = 5,
	isForceLock = 3,
	isStatic = 4,
	endUnlockTime = 6,
	onceRedId = 1
}
local dataList = {
	{
		"yuekagaiban",
		"wholecardpublicityview",
		false,
		false,
		"2022-08-05T05:00:00",
		"2022-08-12T05:00:00"
	},
	{
		"o2",
		"luckydrawtimestatepreviewview",
		false,
		false,
		"2022-10-07T05:00:00",
		"2022-10-21T05:00:00"
	},
	{
		"o3",
		"",
		false,
		false,
		"2022-09-02T05:00:00",
		"2022-09-30T05:00:00"
	},
	{
		"o4",
		"linkageintroductionview",
		false,
		false,
		"2022-09-02T05:00:00",
		"2022-09-30T05:00:00"
	},
	{
		"o5",
		"linkagelanternsview",
		false,
		false,
		"2022-09-17T05:00:00",
		"2022-09-30T05:00:00"
	},
	{
		"o6",
		"",
		false,
		false,
		"2025-04-30T05:00:00",
		"2025-05-30T05:00:00"
	},
	{
		"o7",
		"linkagetvshowview",
		false,
		false,
		"2022-09-02T05:00:00",
		"2022-09-30T05:00:00"
	},
	{
		"o8",
		"",
		false,
		false,
		"2022-10-28T05:00:00",
		"2022-11-11T05:00:00"
	},
	{
		"o9",
		"luckydrawnewskinview",
		false,
		false,
		"2023-08-25T05:00:00",
		"2023-09-28T05:00:00"
	},
	{
		"o10",
		"linkagedocumentaryview",
		false,
		false,
		"2023-01-20T05:00:00",
		"2023-02-10T05:00:00"
	},
	{
		"o11",
		"xiaoxiaoleskinview",
		false,
		false,
		"2023-08-18T05:00:00",
		"2023-09-08T05:00:00"
	},
	{
		"o12",
		"xiaoxiaoleskinview",
		false,
		false,
		"2023-07-28T05:00:00",
		"2023-08-25T05:00:00"
	},
	{
		"o13",
		"petskinsellchangeview",
		false,
		false,
		"2023-09-08T05:00:00",
		"2023-09-28T05:00:00"
	},
	{
		"o14",
		"luckydrawnewskinview",
		false,
		false,
		"2023-08-25T05:00:00",
		"2023-09-08T05:00:00"
	},
	{
		"o15",
		"luckydrawnewskinview",
		false,
		false,
		"2023-08-25T05:00:00",
		"2023-09-28T05:00:00"
	},
	{
		"o16",
		"luckydrawnewskinview",
		false,
		false,
		"2023-07-14T05:00:00",
		"2023-07-28T05:00:00"
	},
	{
		"o17",
		"tuntianhelpsummaryview",
		false,
		false,
		"2023-07-28T05:00:00",
		"2023-08-25T05:00:00"
	},
	{
		"o18",
		"storysummarychapterview",
		false,
		false,
		"2023-11-24T05:00:00",
		"2023-12-22T05:00:00"
	},
	{
		"o19",
		"eternalfarmshopview",
		false,
		false,
		"2023-08-25T05:00:00",
		"2023-09-08T05:00:00"
	},
	{
		"o20",
		"purchaselimitview",
		false,
		false,
		"2023-08-25T05:00:00",
		"2023-09-08T05:00:00"
	},
	{
		"o21",
		"divineciyuanextremeview",
		false,
		false,
		"2023-08-25T05:00:00",
		"2023-10-20T05:00:00"
	},
	{
		"o22",
		"divineciyuanbuffview",
		false,
		false,
		"2023-08-25T05:00:00",
		"2023-10-20T05:00:00"
	},
	{
		"o23",
		"pingamelevelview",
		false,
		false,
		"2023-12-22T05:00:00",
		"2024-01-05T05:00:00"
	},
	{
		"o24",
		"aolaishistrategyview",
		false,
		false,
		"2024-01-02T05:00:00",
		"2024-01-30T05:00:00"
	},
	{
		"o25",
		"elementsparkstageview",
		false,
		false,
		"2024-01-05T05:00:00",
		"2024-01-14T23:59:59"
	},
	{
		"o26",
		"sktdreamteamview",
		false,
		false,
		"2024-03-01T05:00:00",
		"2024-04-03T23:59:59"
	},
	{
		"o27",
		"kindergartemanageview",
		false,
		false,
		"2024-04-03T05:00:00",
		"2024-04-30T05:00:00"
	},
	{
		"o28",
		"kindergarteenlistview",
		false,
		false,
		"2024-04-03T05:00:00",
		"2024-04-30T05:00:00"
	},
	{
		"o29",
		"divinekingordermainview",
		false,
		false,
		"2024-04-30T05:00:00",
		"2024-05-17T05:00:00"
	},
	{
		"o30",
		"scriptkillmainview",
		false,
		false,
		"2024-04-30T05:00:00",
		"2024-05-03T05:00:00"
	},
	{
		"o31",
		"scriptkillmainview",
		false,
		false,
		"2024-05-03T05:00:00",
		"2024-05-10T05:00:00"
	},
	{
		"o32",
		"scriptkillmainview",
		false,
		false,
		"2024-05-10T05:00:00",
		"2024-05-17T05:00:00"
	},
	{
		"o33",
		"divinegasirimainview",
		false,
		false,
		"2024-05-31T05:00:00",
		"2024-06-14T05:00:00"
	},
	{
		"o34",
		"lingshenconvenemainview",
		false,
		false,
		"2024-05-31T05:00:00",
		"2024-06-28T05:00:00"
	},
	{
		"o35",
		"musicgamemainview",
		false,
		false,
		"2024-06-07T05:00:00",
		"2024-06-28T05:00:00"
	},
	{
		"o36",
		"doushouqimainview",
		false,
		false,
		"2024-10-25T05:00:00",
		"2024-11-22T05:00:00"
	},
	{
		"o37",
		"aceteammainview",
		false,
		false,
		"2024-10-25T05:00:00",
		"2024-11-22T05:00:00"
	},
	{
		"o38",
		"psychicedtowerlevelview",
		false,
		false,
		"2024-10-25T05:00:00",
		"2024-11-22T05:00:00"
	},
	{
		"o39",
		"lingshenchallengemainview",
		false,
		false,
		"2024-10-25T05:00:00",
		"2024-11-22T05:00:00"
	},
	{
		"o40",
		"numberpuzzlegamesupermainview",
		false,
		false,
		"2024-11-22T05:00:00",
		"2024-12-20T05:00:00"
	},
	{
		"o41",
		"dragonsoulvotemainview",
		false,
		false,
		"2024-11-22T05:00:00",
		"2024-12-20T05:00:00"
	},
	{
		"o42",
		"dragonawakenpetview",
		false,
		false,
		"2024-11-22T05:00:00",
		"2024-12-20T05:00:00"
	},
	{
		"o43",
		"newyearwordview",
		false,
		false,
		"2026-01-01T00:00:00",
		"2026-01-09T05:00:00"
	},
	{
		"o44",
		"sixartdaoguanmainview",
		true,
		false
	},
	{
		"o45",
		"nailonglotterymainview",
		false,
		false,
		"2025-02-14T00:00:00",
		"2025-03-21T00:00:00"
	},
	{
		"o46",
		"bricksxgamemainview",
		false,
		false,
		"2025-02-28T00:00:00",
		"2025-03-28T00:00:00"
	},
	{
		"o47",
		"anmoyanmainview",
		false,
		false,
		"2025-03-14T00:00:00",
		"2025-03-28T00:00:00"
	},
	{
		"o48",
		"popularitylistmainview",
		false,
		false,
		"2025-03-07T00:00:00",
		"2025-03-28T00:00:00"
	},
	{
		"o49",
		"luyngardechapter2view",
		false,
		false,
		"2025-04-09T05:00:00",
		"2025-04-30T05:00:00"
	},
	{
		"o50",
		"dreampaintermainview",
		false,
		false,
		"2026-04-03T05:00:00",
		"2026-04-30T05:00:00"
	},
	{
		"o51",
		"anniversarymarketmainview",
		false,
		false,
		"2026-07-24T05:00:00",
		"2026-08-21T05:00:00"
	},
	{
		"o52",
		"luyngardechapter4view",
		false,
		false,
		"2025-04-18T05:00:00",
		"2025-04-30T05:00:00"
	},
	{
		"o53",
		"eternalfarmview",
		false,
		false,
		"2025-12-19T05:00:00",
		"2026-01-16T05:00:00"
	},
	{
		"o54",
		"fruitninjamainview",
		false,
		false,
		"2025-04-30T05:00:00",
		"2025-05-30T05:00:00"
	},
	{
		"o55",
		"eventpreviewunlockview",
		false,
		false,
		"2025-05-23T05:00:00",
		"2025-05-30T05:00:00"
	},
	{
		"o56",
		"saintknightregressmainview",
		false,
		false,
		"2025-05-30T05:00:00",
		"2025-07-25T05:00:00"
	},
	{
		"o57",
		"companionmallboardview",
		false,
		false,
		"2025-06-27T05:00:00",
		"2025-07-25T05:00:00"
	},
	{
		"o58",
		"companionmallpreviewview",
		false,
		false,
		"2025-06-27T05:00:00",
		"2025-07-25T05:00:00"
	},
	{
		"o59",
		"bonedragondungeonmainview",
		false,
		false,
		"2025-07-11T05:00:00",
		"2025-07-25T05:00:00"
	},
	{
		"o60",
		"immortalmovemainview",
		false,
		false,
		"2025-07-11T05:00:00",
		"2025-07-25T05:00:00"
	},
	{
		"o61",
		"musicgamemainview",
		false,
		false,
		"2025-07-11T05:00:00",
		"2025-07-25T05:00:00"
	},
	{
		"o62",
		"iceqibugamemainview",
		false,
		false,
		"2025-08-29T05:00:00",
		"2038-09-26T05:00:00"
	},
	{
		"o63",
		"tianyanmatchmainview",
		false,
		false,
		"2025-09-12T05:00:00",
		"2025-09-26T05:00:00"
	},
	{
		"o64",
		"liyangkingmainview",
		false,
		false,
		"2025-08-29T05:00:00",
		"2025-09-26T05:00:00"
	},
	{
		"o65",
		"",
		false,
		true
	},
	{
		"o66",
		"originagemainview",
		false,
		false,
		"2025-11-07T05:00:00",
		"2025-12-12T05:00:00"
	},
	{
		"o67",
		"originagehudlistview",
		false,
		false,
		"2025-11-07T05:00:00",
		"2025-11-21T05:00:00"
	},
	{
		"o68",
		"bindmobileview",
		false,
		false,
		"2025-12-19T05:00:00",
		"2038-09-26T05:00:00"
	},
	{
		"o69",
		"popularitylistmainview",
		false,
		false,
		"2025-12-26T05:00:00",
		"2026-01-09T05:00:00"
	},
	{
		"o70",
		"idiomchainhomeview",
		false,
		false,
		"2025-12-19T05:00:00",
		"2026-01-09T05:00:00"
	},
	{
		"o71",
		"buddyluckybagmainview",
		false,
		false,
		"2026-02-13T05:00:00",
		"2026-03-13T05:00:00"
	},
	{
		"o72",
		"numberpuzzlegamesupermainview",
		false,
		false,
		"2026-01-09T05:00:00",
		"2026-01-23T05:00:00"
	},
	{
		"o73",
		"triplemacthesstartview",
		false,
		false,
		"2026-01-09T05:00:00",
		"2026-01-23T05:00:00"
	},
	{
		"o74",
		"armorheroclg2view",
		false,
		false,
		"2026-01-09T05:00:00",
		"2026-01-23T05:00:00"
	},
	{
		"o75",
		"armorheroclgview",
		false,
		false,
		"2026-01-09T05:00:00",
		"2026-01-23T05:00:00"
	},
	{
		"o76",
		"eternalcitymainview",
		false,
		false,
		"2026-01-30T05:00:00",
		"2026-02-13T05:00:00"
	},
	{
		"o77",
		"plantgodtreeview",
		false,
		false,
		"2026-01-16T05:00:00",
		"2026-02-13T05:00:00"
	},
	{
		"o78",
		"pinballmainview",
		false,
		false,
		"2026-01-16T05:00:00",
		"2026-02-13T05:00:00"
	},
	{
		"o79",
		"endlessdarkclgmainview",
		false,
		false,
		"2026-01-16T05:00:00",
		"2026-02-13T05:00:00"
	},
	{
		"o80",
		"armorherolotterymainview",
		false,
		false,
		"2026-04-30T05:00:00",
		"2026-05-29T05:00:00"
	},
	{
		"o81",
		"upholdjusticemainview",
		false,
		false,
		"2026-04-03T05:00:00",
		"2026-04-30T05:00:00"
	},
	{
		"o82",
		"uniqueworldmainview",
		false,
		false,
		"2026-04-03T05:00:00",
		"2026-04-30T05:00:00"
	},
	{
		"o84",
		"swordstormmainview",
		false,
		false,
		"2026-04-03T05:00:00",
		"2026-04-30T05:00:00"
	},
	{
		"o85",
		"swordstormmainview",
		false,
		false,
		"2026-04-10T05:00:00",
		"2026-04-30T05:00:00"
	},
	{
		"o83",
		"fiveyearrecapmainview",
		false,
		false,
		"2026-04-03T05:00:00",
		"2026-04-30T05:00:00"
	},
	{
		"o86",
		"mmdrinkshopmainview",
		false,
		false,
		"2026-06-19T05:00:00",
		"2026-06-26T05:00:00"
	},
	{
		"o87",
		"godgemconsumepayshopview",
		false,
		false,
		"2026-07-24T05:00:00",
		"2026-08-21T05:00:00"
	},
	{
		"o88",
		"activitysmallsummarysixview",
		false,
		false,
		"2026-07-24T05:00:00",
		"2026-08-21T05:00:00"
	},
	{
		"o89",
		"newjobintroduceview",
		false,
		false,
		"2026-07-24T05:00:00",
		"2026-08-21T05:00:00"
	}
}
local t_red_point_ex_once = {
	yuekagaiban = dataList[1],
	o2 = dataList[2],
	o3 = dataList[3],
	o4 = dataList[4],
	o5 = dataList[5],
	o6 = dataList[6],
	o7 = dataList[7],
	o8 = dataList[8],
	o9 = dataList[9],
	o10 = dataList[10],
	o11 = dataList[11],
	o12 = dataList[12],
	o13 = dataList[13],
	o14 = dataList[14],
	o15 = dataList[15],
	o16 = dataList[16],
	o17 = dataList[17],
	o18 = dataList[18],
	o19 = dataList[19],
	o20 = dataList[20],
	o21 = dataList[21],
	o22 = dataList[22],
	o23 = dataList[23],
	o24 = dataList[24],
	o25 = dataList[25],
	o26 = dataList[26],
	o27 = dataList[27],
	o28 = dataList[28],
	o29 = dataList[29],
	o30 = dataList[30],
	o31 = dataList[31],
	o32 = dataList[32],
	o33 = dataList[33],
	o34 = dataList[34],
	o35 = dataList[35],
	o36 = dataList[36],
	o37 = dataList[37],
	o38 = dataList[38],
	o39 = dataList[39],
	o40 = dataList[40],
	o41 = dataList[41],
	o42 = dataList[42],
	o43 = dataList[43],
	o44 = dataList[44],
	o45 = dataList[45],
	o46 = dataList[46],
	o47 = dataList[47],
	o48 = dataList[48],
	o49 = dataList[49],
	o50 = dataList[50],
	o51 = dataList[51],
	o52 = dataList[52],
	o53 = dataList[53],
	o54 = dataList[54],
	o55 = dataList[55],
	o56 = dataList[56],
	o57 = dataList[57],
	o58 = dataList[58],
	o59 = dataList[59],
	o60 = dataList[60],
	o61 = dataList[61],
	o62 = dataList[62],
	o63 = dataList[63],
	o64 = dataList[64],
	o65 = dataList[65],
	o66 = dataList[66],
	o67 = dataList[67],
	o68 = dataList[68],
	o69 = dataList[69],
	o70 = dataList[70],
	o71 = dataList[71],
	o72 = dataList[72],
	o73 = dataList[73],
	o74 = dataList[74],
	o75 = dataList[75],
	o76 = dataList[76],
	o77 = dataList[77],
	o78 = dataList[78],
	o79 = dataList[79],
	o80 = dataList[80],
	o81 = dataList[81],
	o82 = dataList[82],
	o84 = dataList[83],
	o85 = dataList[84],
	o83 = dataList[85],
	o86 = dataList[86],
	o87 = dataList[87],
	o88 = dataList[88],
	o89 = dataList[89]
}

t_red_point_ex_once.dataList = dataList

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

return t_red_point_ex_once
