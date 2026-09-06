-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_awaken_item_ext.lua

module("logicconfig.config.t_awaken_item_ext", package.seeall)

local title = {
	race = 5,
	pieceId = 7,
	initRares = 6,
	attr = 4,
	id = 1,
	isSameRace = 2,
	level = 3
}
local dataList = {
	{
		70002,
		true,
		0,
		"",
		0,
		{
			3
		},
		71002
	},
	{
		70003,
		true,
		0,
		"",
		0,
		{
			4
		},
		71003
	},
	{
		70018,
		true,
		0,
		"暗",
		0,
		{
			4
		},
		71018
	},
	{
		70019,
		true,
		0,
		"水",
		0,
		{
			4
		},
		71019
	},
	{
		70020,
		true,
		0,
		"草",
		0,
		{
			4
		},
		71020
	},
	{
		70021,
		true,
		0,
		"火",
		0,
		{
			4
		},
		71021
	},
	{
		70022,
		true,
		0,
		"光",
		0,
		{
			4
		},
		71022
	},
	{
		70023,
		true,
		0,
		"空",
		0,
		{
			4
		},
		71023
	},
	{
		70024,
		true,
		0,
		"创",
		0,
		{
			4
		},
		71024
	},
	{
		80001,
		true,
		0,
		"",
		10027,
		nil,
		81001
	},
	{
		80002,
		true,
		0,
		"",
		10147,
		nil,
		81002
	},
	{
		80005,
		true,
		0,
		"",
		10338,
		nil,
		81005
	},
	{
		80006,
		true,
		0,
		"",
		10339,
		nil,
		81006
	},
	{
		80007,
		true,
		0,
		"",
		10341,
		nil,
		81007
	},
	{
		80008,
		true,
		0,
		"",
		10342,
		nil,
		81008
	},
	{
		80009,
		true,
		0,
		"",
		10343,
		nil,
		81009
	},
	{
		80100,
		true,
		0,
		"",
		10100,
		nil,
		81100
	},
	{
		80146,
		true,
		0,
		"",
		10146,
		nil,
		81146
	},
	{
		80165,
		true,
		0,
		"",
		10165,
		nil,
		81165
	},
	{
		80318,
		true,
		0,
		"",
		10318,
		nil,
		81318
	},
	{
		80325,
		true,
		0,
		"",
		10325,
		nil,
		81325
	},
	{
		80381,
		true,
		0,
		"",
		10381,
		nil,
		81381
	},
	{
		80179,
		true,
		0,
		"",
		10179,
		nil,
		81179
	},
	{
		80332,
		true,
		0,
		"",
		10332,
		nil,
		81332
	},
	{
		80333,
		true,
		0,
		"",
		10333,
		nil,
		81333
	},
	{
		80999,
		true,
		0,
		"",
		10345,
		nil,
		81333
	},
	{
		84000,
		true,
		0,
		"",
		14000,
		nil,
		0
	},
	{
		80370,
		true,
		0,
		"",
		10370,
		nil,
		81370
	},
	{
		81000,
		true,
		0,
		"",
		11000,
		nil,
		0
	},
	{
		84005,
		true,
		0,
		"",
		14005,
		nil,
		0
	},
	{
		84006,
		true,
		0,
		"",
		16001,
		nil,
		0
	},
	{
		84007,
		true,
		0,
		"",
		16000,
		nil,
		0
	},
	{
		84008,
		true,
		0,
		"",
		16002,
		nil,
		0
	},
	{
		96002,
		true,
		0,
		"",
		10324,
		nil,
		0
	},
	{
		84009,
		true,
		0,
		"",
		16005,
		nil,
		0
	},
	{
		84010,
		true,
		0,
		"",
		16006,
		nil,
		0
	},
	{
		84011,
		true,
		0,
		"",
		16007,
		nil,
		0
	},
	{
		84012,
		true,
		0,
		"",
		11003,
		nil,
		0
	},
	{
		84013,
		true,
		0,
		"",
		10314,
		nil,
		0
	},
	{
		84014,
		true,
		0,
		"",
		16008,
		nil,
		0
	},
	{
		84015,
		true,
		0,
		"",
		16009,
		nil,
		0
	},
	{
		84016,
		true,
		0,
		"",
		10099,
		nil,
		0
	},
	{
		84017,
		true,
		0,
		"",
		10101,
		nil,
		0
	},
	{
		84018,
		true,
		0,
		"",
		12003,
		nil,
		0
	},
	{
		84019,
		true,
		0,
		"",
		12004,
		nil,
		0
	},
	{
		84020,
		true,
		0,
		"",
		12005,
		nil,
		0
	},
	{
		84021,
		true,
		0,
		"",
		10097,
		nil,
		0
	},
	{
		84022,
		true,
		0,
		"",
		11001,
		nil,
		0
	},
	{
		84023,
		true,
		0,
		"",
		10098,
		nil,
		0
	},
	{
		80326,
		true,
		0,
		"",
		10326,
		nil,
		0
	},
	{
		80327,
		true,
		0,
		"",
		10070,
		nil,
		0
	},
	{
		80328,
		true,
		0,
		"",
		10130,
		nil,
		0
	},
	{
		80329,
		true,
		0,
		"",
		10131,
		nil,
		0
	},
	{
		80330,
		true,
		0,
		"",
		10320,
		nil,
		0
	},
	{
		80331,
		true,
		0,
		"",
		11005,
		nil,
		0
	},
	{
		80334,
		true,
		0,
		"",
		17001,
		nil,
		0
	},
	{
		80335,
		true,
		0,
		"",
		10142,
		nil,
		0
	},
	{
		80336,
		true,
		0,
		"",
		11007,
		nil,
		0
	},
	{
		80337,
		true,
		0,
		"",
		12007,
		nil,
		0
	},
	{
		80338,
		true,
		0,
		"",
		12008,
		nil,
		0
	},
	{
		80339,
		true,
		0,
		"",
		13001,
		nil,
		0
	},
	{
		80340,
		true,
		0,
		"",
		14008,
		nil,
		0
	},
	{
		80341,
		true,
		0,
		"",
		15011,
		nil,
		0
	},
	{
		80342,
		true,
		0,
		"",
		13004,
		nil,
		0
	},
	{
		80343,
		true,
		0,
		"",
		13002,
		nil,
		0
	},
	{
		80344,
		true,
		0,
		"",
		10144,
		nil,
		0
	},
	{
		80345,
		true,
		0,
		"",
		17003,
		nil,
		0
	},
	{
		80346,
		true,
		0,
		"",
		13006,
		nil,
		0
	},
	{
		80347,
		true,
		0,
		"",
		10167,
		nil,
		0
	},
	{
		80348,
		true,
		0,
		"",
		13005,
		nil,
		0
	},
	{
		80349,
		true,
		0,
		"",
		17002,
		nil,
		0
	},
	{
		80350,
		true,
		0,
		"",
		17005,
		nil,
		0
	},
	{
		80351,
		true,
		0,
		"",
		17004,
		nil,
		0
	},
	{
		80352,
		true,
		0,
		"",
		17006,
		nil,
		0
	},
	{
		80353,
		true,
		0,
		"",
		15007,
		nil,
		0
	},
	{
		80354,
		true,
		0,
		"",
		17008,
		nil,
		0
	},
	{
		80355,
		true,
		0,
		"",
		17007,
		nil,
		0
	},
	{
		80356,
		true,
		0,
		"",
		17009,
		nil,
		0
	},
	{
		80357,
		true,
		0,
		"",
		16010,
		nil,
		0
	},
	{
		80358,
		true,
		0,
		"",
		15012,
		nil,
		0
	},
	{
		80359,
		true,
		0,
		"",
		14009,
		nil,
		0
	},
	{
		80360,
		true,
		0,
		"",
		14011,
		nil,
		0
	},
	{
		80361,
		true,
		0,
		"",
		15013,
		nil,
		0
	},
	{
		80362,
		true,
		0,
		"",
		15014,
		nil,
		0
	},
	{
		80363,
		true,
		0,
		"",
		16003,
		nil,
		0
	},
	{
		80364,
		true,
		0,
		"",
		14010,
		nil,
		0
	},
	{
		80365,
		true,
		0,
		"",
		10330,
		nil,
		0
	},
	{
		80366,
		true,
		0,
		"",
		14012,
		nil,
		0
	},
	{
		80367,
		true,
		0,
		"",
		16013,
		nil,
		0
	},
	{
		80368,
		true,
		0,
		"",
		16012,
		nil,
		0
	},
	{
		80369,
		true,
		0,
		"",
		16011,
		nil,
		0
	},
	{
		84370,
		true,
		0,
		"",
		16017,
		nil,
		0
	},
	{
		84371,
		true,
		0,
		"",
		16014,
		nil,
		0
	},
	{
		84372,
		true,
		0,
		"",
		16016,
		nil,
		0
	},
	{
		84373,
		true,
		0,
		"",
		16015,
		nil,
		0
	},
	{
		84374,
		true,
		0,
		"",
		14013,
		nil,
		0
	},
	{
		84375,
		true,
		0,
		"",
		14014,
		nil,
		0
	},
	{
		84376,
		true,
		0,
		"",
		12012,
		nil,
		0
	},
	{
		84377,
		true,
		0,
		"",
		12011,
		nil,
		0
	},
	{
		84378,
		true,
		0,
		"",
		12010,
		nil,
		0
	},
	{
		84379,
		true,
		0,
		"",
		12009,
		nil,
		0
	},
	{
		84380,
		true,
		0,
		"",
		12013,
		nil,
		0
	},
	{
		84381,
		true,
		0,
		"",
		12015,
		nil,
		0
	},
	{
		84382,
		true,
		0,
		"",
		12014,
		nil,
		0
	},
	{
		84383,
		true,
		0,
		"",
		12016,
		nil,
		0
	},
	{
		84384,
		true,
		0,
		"",
		11008,
		nil,
		0
	},
	{
		84385,
		true,
		0,
		"",
		11009,
		nil,
		0
	},
	{
		84386,
		true,
		0,
		"",
		11010,
		nil,
		0
	},
	{
		84387,
		true,
		0,
		"",
		12017,
		nil,
		0
	},
	{
		84388,
		true,
		0,
		"",
		13007,
		nil,
		0
	},
	{
		84389,
		true,
		0,
		"",
		14015,
		nil,
		0
	},
	{
		84390,
		true,
		0,
		"",
		15016,
		nil,
		0
	},
	{
		84391,
		true,
		0,
		"",
		11015,
		nil,
		0
	},
	{
		84392,
		true,
		0,
		"",
		11011,
		nil,
		0
	},
	{
		84393,
		true,
		0,
		"",
		11012,
		nil,
		0
	},
	{
		84394,
		true,
		0,
		"",
		11013,
		nil,
		0
	},
	{
		84395,
		true,
		0,
		"",
		11014,
		nil,
		0
	},
	{
		84396,
		true,
		0,
		"",
		13011,
		nil,
		0
	},
	{
		84397,
		true,
		0,
		"",
		13008,
		nil,
		0
	},
	{
		84398,
		true,
		0,
		"",
		13009,
		nil,
		0
	},
	{
		84399,
		true,
		0,
		"",
		13010,
		nil,
		0
	},
	{
		84400,
		true,
		0,
		"",
		13012,
		nil,
		0
	},
	{
		84401,
		true,
		0,
		"",
		10313,
		nil,
		0
	},
	{
		84402,
		true,
		0,
		"",
		14016,
		nil,
		0
	},
	{
		84403,
		true,
		0,
		"",
		17010,
		nil,
		0
	},
	{
		84404,
		true,
		0,
		"",
		13013,
		nil,
		0
	},
	{
		84405,
		true,
		0,
		"",
		11018,
		nil,
		0
	},
	{
		84406,
		true,
		0,
		"",
		11017,
		nil,
		0
	},
	{
		84407,
		true,
		0,
		"",
		10127,
		nil,
		0
	},
	{
		84408,
		true,
		0,
		"",
		17011,
		nil,
		0
	},
	{
		84409,
		true,
		0,
		"",
		17012,
		nil,
		0
	},
	{
		84410,
		true,
		0,
		"",
		17013,
		nil,
		0
	},
	{
		84411,
		true,
		0,
		"",
		17014,
		nil,
		0
	},
	{
		84412,
		true,
		0,
		"",
		14017,
		nil,
		0
	},
	{
		84413,
		true,
		0,
		"",
		14018,
		nil,
		0
	},
	{
		84414,
		true,
		0,
		"",
		14019,
		nil,
		0
	},
	{
		84415,
		true,
		0,
		"",
		14020,
		nil,
		0
	},
	{
		84416,
		true,
		0,
		"",
		14021,
		nil,
		0
	},
	{
		84418,
		true,
		0,
		"",
		14022,
		nil,
		0
	},
	{
		84419,
		true,
		0,
		"",
		18001,
		nil,
		0
	},
	{
		84420,
		true,
		0,
		"",
		10309,
		nil,
		0
	},
	{
		84421,
		true,
		0,
		"",
		15018,
		nil,
		0
	},
	{
		84422,
		true,
		0,
		"",
		15017,
		nil,
		0
	},
	{
		84423,
		true,
		0,
		"",
		15019,
		nil,
		0
	},
	{
		84417,
		true,
		0,
		"",
		10145,
		nil,
		0
	},
	{
		84424,
		true,
		0,
		"",
		15020,
		nil,
		0
	},
	{
		84425,
		true,
		0,
		"",
		15021,
		nil,
		0
	},
	{
		84426,
		true,
		0,
		"",
		15022,
		nil,
		0
	},
	{
		84427,
		true,
		0,
		"",
		15023,
		nil,
		0
	},
	{
		84428,
		true,
		0,
		"",
		16018,
		nil,
		0
	},
	{
		84429,
		true,
		0,
		"",
		14023,
		nil,
		0
	},
	{
		84430,
		true,
		0,
		"",
		15024,
		nil,
		0
	},
	{
		84431,
		true,
		0,
		"",
		17015,
		nil,
		0
	},
	{
		84432,
		true,
		0,
		"",
		16019,
		nil,
		0
	},
	{
		84433,
		true,
		0,
		"",
		16020,
		nil,
		0
	},
	{
		84434,
		true,
		0,
		"",
		16021,
		nil,
		0
	},
	{
		84435,
		true,
		0,
		"",
		16022,
		nil,
		0
	},
	{
		84436,
		true,
		0,
		"",
		16023,
		nil,
		0
	},
	{
		84437,
		true,
		0,
		"",
		14024,
		nil,
		0
	},
	{
		84438,
		true,
		0,
		"",
		12018,
		nil,
		0
	},
	{
		84439,
		true,
		0,
		"",
		12019,
		nil,
		0
	},
	{
		84440,
		true,
		0,
		"",
		16024,
		nil,
		0
	},
	{
		84441,
		true,
		0,
		"",
		12020,
		nil,
		0
	},
	{
		84442,
		true,
		0,
		"",
		12021,
		nil,
		0
	},
	{
		84443,
		true,
		0,
		"",
		11023,
		nil,
		0
	},
	{
		84444,
		true,
		0,
		"",
		11019,
		nil,
		0
	},
	{
		84445,
		true,
		0,
		"",
		11020,
		nil,
		0
	},
	{
		84446,
		true,
		0,
		"",
		11021,
		nil,
		0
	},
	{
		84447,
		true,
		0,
		"",
		11022,
		nil,
		0
	},
	{
		84448,
		true,
		0,
		"",
		13014,
		nil,
		0
	},
	{
		84449,
		true,
		0,
		"",
		13015,
		nil,
		0
	},
	{
		84450,
		true,
		0,
		"",
		13016,
		nil,
		0
	},
	{
		84451,
		true,
		0,
		"",
		13017,
		nil,
		0
	},
	{
		84452,
		true,
		0,
		"",
		13018,
		nil,
		0
	},
	{
		84453,
		true,
		0,
		"",
		11024,
		nil,
		0
	},
	{
		84454,
		true,
		0,
		"",
		13019,
		nil,
		0
	},
	{
		84455,
		true,
		0,
		"",
		12022,
		nil,
		0
	},
	{
		84456,
		true,
		0,
		"",
		15025,
		nil,
		0
	},
	{
		84457,
		true,
		0,
		"",
		14025,
		nil,
		0
	},
	{
		84458,
		true,
		0,
		"",
		16025,
		nil,
		0
	},
	{
		84459,
		true,
		0,
		"",
		16026,
		nil,
		0
	},
	{
		84460,
		true,
		0,
		"",
		17016,
		nil,
		0
	},
	{
		84461,
		true,
		0,
		"",
		17017,
		nil,
		0
	},
	{
		84462,
		true,
		0,
		"",
		17018,
		nil,
		0
	},
	{
		84463,
		true,
		0,
		"",
		17022,
		nil,
		0
	},
	{
		84464,
		true,
		0,
		"",
		17021,
		nil,
		0
	},
	{
		84465,
		true,
		0,
		"",
		17019,
		nil,
		0
	},
	{
		84466,
		true,
		0,
		"",
		17020,
		nil,
		0
	},
	{
		84467,
		true,
		0,
		"",
		17023,
		nil,
		0
	},
	{
		84468,
		true,
		0,
		"",
		18011,
		nil,
		0
	},
	{
		84469,
		true,
		0,
		"",
		14026,
		nil,
		0
	},
	{
		84470,
		true,
		0,
		"",
		14027,
		nil,
		0
	},
	{
		84471,
		true,
		0,
		"",
		14028,
		nil,
		0
	},
	{
		84472,
		true,
		0,
		"",
		14029,
		nil,
		0
	},
	{
		84473,
		true,
		0,
		"",
		14030,
		nil,
		0
	},
	{
		84474,
		true,
		0,
		"",
		15028,
		nil,
		0
	},
	{
		84475,
		true,
		0,
		"",
		15026,
		nil,
		0
	},
	{
		84476,
		true,
		0,
		"",
		15027,
		nil,
		0
	},
	{
		84477,
		true,
		0,
		"",
		15030,
		nil,
		0
	},
	{
		84478,
		true,
		0,
		"",
		15029,
		nil,
		0
	},
	{
		84479,
		true,
		0,
		"",
		16027,
		nil,
		0
	},
	{
		84480,
		true,
		0,
		"",
		16028,
		nil,
		0
	},
	{
		84481,
		true,
		0,
		"",
		16029,
		nil,
		0
	},
	{
		84482,
		true,
		0,
		"",
		16030,
		nil,
		0
	},
	{
		84483,
		true,
		0,
		"",
		13020,
		nil,
		0
	},
	{
		84484,
		true,
		0,
		"",
		11025,
		nil,
		0
	},
	{
		84485,
		true,
		0,
		"",
		12023,
		nil,
		0
	},
	{
		84486,
		true,
		0,
		"",
		12024,
		nil,
		0
	},
	{
		84487,
		true,
		0,
		"",
		12025,
		nil,
		0
	},
	{
		84488,
		true,
		0,
		"",
		12026,
		nil,
		0
	},
	{
		84489,
		true,
		0,
		"",
		18021,
		nil,
		0
	},
	{
		84490,
		true,
		0,
		"",
		13021,
		nil,
		0
	},
	{
		84491,
		true,
		0,
		"",
		12027,
		nil,
		0
	},
	{
		84492,
		true,
		0,
		"",
		12028,
		nil,
		0
	},
	{
		84493,
		true,
		0,
		"",
		13022,
		nil,
		0
	},
	{
		84494,
		true,
		0,
		"",
		11026,
		nil,
		0
	},
	{
		84495,
		true,
		0,
		"",
		11027,
		nil,
		0
	},
	{
		84496,
		true,
		0,
		"",
		12029,
		nil,
		0
	},
	{
		84497,
		true,
		0,
		"",
		14031,
		nil,
		0
	},
	{
		84498,
		true,
		0,
		"",
		16031,
		nil,
		0
	},
	{
		84499,
		true,
		0,
		"",
		15031,
		nil,
		0
	},
	{
		84500,
		true,
		0,
		"",
		16032,
		nil,
		0
	},
	{
		84501,
		true,
		0,
		"",
		13023,
		nil,
		0
	},
	{
		84502,
		true,
		0,
		"",
		12030,
		nil,
		0
	},
	{
		84503,
		true,
		0,
		"",
		15032,
		nil,
		0
	},
	{
		84504,
		true,
		0,
		"",
		15033,
		nil,
		0
	},
	{
		84505,
		true,
		0,
		"",
		16033,
		nil,
		0
	},
	{
		84506,
		true,
		0,
		"",
		11028,
		nil,
		0
	},
	{
		84507,
		true,
		0,
		"",
		10143,
		nil,
		0
	},
	{
		84508,
		true,
		0,
		"",
		14033,
		nil,
		0
	},
	{
		84509,
		true,
		0,
		"",
		14034,
		nil,
		0
	},
	{
		84510,
		true,
		0,
		"",
		14032,
		nil,
		0
	},
	{
		84511,
		true,
		0,
		"",
		15034,
		nil,
		0
	},
	{
		84512,
		true,
		0,
		"",
		16034,
		nil,
		0
	},
	{
		84513,
		true,
		0,
		"",
		14035,
		nil,
		0
	},
	{
		84514,
		true,
		0,
		"",
		11029,
		nil,
		0
	},
	{
		84515,
		true,
		0,
		"",
		12031,
		nil,
		0
	},
	{
		84516,
		true,
		0,
		"",
		13024,
		nil,
		0
	},
	{
		84517,
		true,
		0,
		"",
		12032,
		nil,
		0
	},
	{
		84518,
		true,
		0,
		"",
		15035,
		nil,
		0
	},
	{
		84519,
		true,
		0,
		"",
		16035,
		nil,
		0
	},
	{
		84520,
		true,
		0,
		"",
		16036,
		nil,
		0
	},
	{
		84521,
		true,
		0,
		"",
		16037,
		nil,
		0
	},
	{
		84522,
		true,
		0,
		"",
		16038,
		nil,
		0
	},
	{
		84523,
		true,
		0,
		"",
		16039,
		nil,
		0
	},
	{
		84524,
		true,
		0,
		"",
		12033,
		nil,
		0
	},
	{
		84525,
		true,
		0,
		"",
		12034,
		nil,
		0
	},
	{
		84526,
		true,
		0,
		"",
		12036,
		nil,
		0
	},
	{
		84527,
		true,
		0,
		"",
		12035,
		nil,
		0
	},
	{
		84528,
		true,
		0,
		"",
		12037,
		nil,
		0
	},
	{
		84529,
		true,
		0,
		"",
		11030,
		nil,
		0
	},
	{
		84530,
		true,
		0,
		"",
		11032,
		nil,
		0
	},
	{
		84531,
		true,
		0,
		"",
		16040,
		nil,
		0
	},
	{
		84532,
		true,
		0,
		"",
		11033,
		nil,
		0
	},
	{
		84533,
		true,
		0,
		"",
		14036,
		nil,
		0
	},
	{
		84534,
		true,
		0,
		"",
		11034,
		nil,
		0
	},
	{
		84535,
		true,
		0,
		"",
		12038,
		nil,
		0
	},
	{
		84536,
		true,
		0,
		"",
		15036,
		nil,
		0
	},
	{
		84537,
		true,
		0,
		"",
		14037,
		nil,
		0
	},
	{
		84538,
		true,
		0,
		"",
		14038,
		nil,
		0
	},
	{
		84539,
		true,
		0,
		"",
		11035,
		nil,
		0
	},
	{
		84540,
		true,
		0,
		"",
		17024,
		nil,
		0
	},
	{
		84541,
		true,
		0,
		"",
		15037,
		nil,
		0
	},
	{
		84542,
		true,
		0,
		"",
		15038,
		nil,
		0
	},
	{
		84543,
		true,
		0,
		"",
		15039,
		nil,
		0
	},
	{
		84544,
		true,
		0,
		"",
		15040,
		nil,
		0
	},
	{
		84545,
		true,
		0,
		"",
		15041,
		nil,
		0
	},
	{
		84546,
		true,
		0,
		"",
		14039,
		nil,
		0
	},
	{
		84547,
		true,
		0,
		"",
		14040,
		nil,
		0
	},
	{
		84548,
		true,
		0,
		"",
		15042,
		nil,
		0
	},
	{
		84549,
		true,
		0,
		"",
		14041,
		nil,
		0
	},
	{
		84550,
		true,
		0,
		"",
		15043,
		nil,
		0
	},
	{
		84551,
		true,
		0,
		"",
		14042,
		nil,
		0
	},
	{
		84552,
		true,
		0,
		"",
		18031,
		nil,
		0
	},
	{
		84553,
		true,
		0,
		"",
		16041,
		nil,
		0
	},
	{
		84554,
		true,
		0,
		"",
		16042,
		nil,
		0
	},
	{
		84555,
		true,
		0,
		"",
		16043,
		nil,
		0
	},
	{
		84556,
		true,
		0,
		"",
		16044,
		nil,
		0
	},
	{
		84557,
		true,
		0,
		"",
		16045,
		nil,
		0
	},
	{
		84558,
		true,
		0,
		"",
		18031,
		nil,
		0
	},
	{
		84559,
		true,
		0,
		"",
		13025,
		nil,
		0
	},
	{
		84560,
		true,
		0,
		"",
		13026,
		nil,
		0
	},
	{
		84561,
		true,
		0,
		"",
		12039,
		nil,
		0
	},
	{
		84562,
		true,
		0,
		"",
		13027,
		nil,
		0
	},
	{
		84563,
		true,
		0,
		"",
		14043,
		nil,
		0
	},
	{
		84564,
		true,
		0,
		"",
		13028,
		nil,
		0
	},
	{
		84565,
		true,
		0,
		"",
		13029,
		nil,
		0
	},
	{
		84566,
		true,
		0,
		"",
		12040,
		nil,
		0
	},
	{
		84567,
		true,
		0,
		"",
		12042,
		nil,
		0
	},
	{
		84568,
		true,
		0,
		"",
		12041,
		nil,
		0
	},
	{
		84569,
		true,
		0,
		"",
		12043,
		nil,
		0
	},
	{
		84570,
		true,
		0,
		"",
		12044,
		nil,
		0
	},
	{
		84571,
		true,
		0,
		"",
		12045,
		nil,
		0
	},
	{
		84572,
		true,
		0,
		"",
		11040,
		nil,
		0
	},
	{
		84573,
		true,
		0,
		"",
		11039,
		nil,
		0
	},
	{
		84574,
		true,
		0,
		"",
		11038,
		nil,
		0
	},
	{
		84575,
		true,
		0,
		"",
		11037,
		nil,
		0
	},
	{
		84576,
		true,
		0,
		"",
		11036,
		nil,
		0
	},
	{
		84577,
		true,
		0,
		"",
		17025,
		nil,
		0
	},
	{
		84578,
		true,
		0,
		"",
		17026,
		nil,
		0
	},
	{
		84579,
		true,
		0,
		"",
		17027,
		nil,
		0
	},
	{
		84580,
		true,
		0,
		"",
		17028,
		nil,
		0
	},
	{
		84581,
		true,
		0,
		"",
		13030,
		nil,
		0
	},
	{
		84582,
		true,
		0,
		"",
		17029,
		nil,
		0
	},
	{
		84583,
		true,
		0,
		"",
		15045,
		nil,
		0
	},
	{
		84584,
		true,
		0,
		"",
		15044,
		nil,
		0
	},
	{
		84585,
		true,
		0,
		"",
		15046,
		nil,
		0
	},
	{
		84586,
		true,
		0,
		"",
		15047,
		nil,
		0
	},
	{
		84587,
		true,
		0,
		"",
		15048,
		nil,
		0
	},
	{
		84588,
		true,
		0,
		"",
		15049,
		nil,
		0
	},
	{
		84589,
		true,
		0,
		"",
		14044,
		nil,
		0
	},
	{
		84590,
		true,
		0,
		"",
		12046,
		nil,
		0
	},
	{
		84591,
		true,
		0,
		"",
		15050,
		nil,
		0
	},
	{
		84592,
		true,
		0,
		"",
		13031,
		nil,
		0
	},
	{
		84593,
		true,
		0,
		"",
		11041,
		nil,
		0
	},
	{
		84594,
		true,
		0,
		"",
		11042,
		nil,
		0
	},
	{
		84595,
		true,
		0,
		"",
		14045,
		nil,
		0
	},
	{
		84596,
		true,
		0,
		"",
		14046,
		nil,
		0
	},
	{
		84597,
		true,
		0,
		"",
		14047,
		nil,
		0
	},
	{
		84598,
		true,
		0,
		"",
		14048,
		nil,
		0
	},
	{
		84599,
		true,
		0,
		"",
		14049,
		nil,
		0
	},
	{
		84600,
		true,
		0,
		"",
		16046,
		nil,
		0
	},
	{
		84601,
		true,
		0,
		"",
		15051,
		nil,
		0
	},
	{
		84602,
		true,
		0,
		"",
		16047,
		nil,
		0
	},
	{
		84603,
		true,
		0,
		"",
		12047,
		nil,
		0
	},
	{
		84604,
		true,
		0,
		"",
		16048,
		nil,
		0
	}
}
local t_awaken_item_ext = {
	[70002] = dataList[1],
	[70003] = dataList[2],
	[70018] = dataList[3],
	[70019] = dataList[4],
	[70020] = dataList[5],
	[70021] = dataList[6],
	[70022] = dataList[7],
	[70023] = dataList[8],
	[70024] = dataList[9],
	[80001] = dataList[10],
	[80002] = dataList[11],
	[80005] = dataList[12],
	[80006] = dataList[13],
	[80007] = dataList[14],
	[80008] = dataList[15],
	[80009] = dataList[16],
	[80100] = dataList[17],
	[80146] = dataList[18],
	[80165] = dataList[19],
	[80318] = dataList[20],
	[80325] = dataList[21],
	[80381] = dataList[22],
	[80179] = dataList[23],
	[80332] = dataList[24],
	[80333] = dataList[25],
	[80999] = dataList[26],
	[84000] = dataList[27],
	[80370] = dataList[28],
	[81000] = dataList[29],
	[84005] = dataList[30],
	[84006] = dataList[31],
	[84007] = dataList[32],
	[84008] = dataList[33],
	[96002] = dataList[34],
	[84009] = dataList[35],
	[84010] = dataList[36],
	[84011] = dataList[37],
	[84012] = dataList[38],
	[84013] = dataList[39],
	[84014] = dataList[40],
	[84015] = dataList[41],
	[84016] = dataList[42],
	[84017] = dataList[43],
	[84018] = dataList[44],
	[84019] = dataList[45],
	[84020] = dataList[46],
	[84021] = dataList[47],
	[84022] = dataList[48],
	[84023] = dataList[49],
	[80326] = dataList[50],
	[80327] = dataList[51],
	[80328] = dataList[52],
	[80329] = dataList[53],
	[80330] = dataList[54],
	[80331] = dataList[55],
	[80334] = dataList[56],
	[80335] = dataList[57],
	[80336] = dataList[58],
	[80337] = dataList[59],
	[80338] = dataList[60],
	[80339] = dataList[61],
	[80340] = dataList[62],
	[80341] = dataList[63],
	[80342] = dataList[64],
	[80343] = dataList[65],
	[80344] = dataList[66],
	[80345] = dataList[67],
	[80346] = dataList[68],
	[80347] = dataList[69],
	[80348] = dataList[70],
	[80349] = dataList[71],
	[80350] = dataList[72],
	[80351] = dataList[73],
	[80352] = dataList[74],
	[80353] = dataList[75],
	[80354] = dataList[76],
	[80355] = dataList[77],
	[80356] = dataList[78],
	[80357] = dataList[79],
	[80358] = dataList[80],
	[80359] = dataList[81],
	[80360] = dataList[82],
	[80361] = dataList[83],
	[80362] = dataList[84],
	[80363] = dataList[85],
	[80364] = dataList[86],
	[80365] = dataList[87],
	[80366] = dataList[88],
	[80367] = dataList[89],
	[80368] = dataList[90],
	[80369] = dataList[91],
	[84370] = dataList[92],
	[84371] = dataList[93],
	[84372] = dataList[94],
	[84373] = dataList[95],
	[84374] = dataList[96],
	[84375] = dataList[97],
	[84376] = dataList[98],
	[84377] = dataList[99],
	[84378] = dataList[100],
	[84379] = dataList[101],
	[84380] = dataList[102],
	[84381] = dataList[103],
	[84382] = dataList[104],
	[84383] = dataList[105],
	[84384] = dataList[106],
	[84385] = dataList[107],
	[84386] = dataList[108],
	[84387] = dataList[109],
	[84388] = dataList[110],
	[84389] = dataList[111],
	[84390] = dataList[112],
	[84391] = dataList[113],
	[84392] = dataList[114],
	[84393] = dataList[115],
	[84394] = dataList[116],
	[84395] = dataList[117],
	[84396] = dataList[118],
	[84397] = dataList[119],
	[84398] = dataList[120],
	[84399] = dataList[121],
	[84400] = dataList[122],
	[84401] = dataList[123],
	[84402] = dataList[124],
	[84403] = dataList[125],
	[84404] = dataList[126],
	[84405] = dataList[127],
	[84406] = dataList[128],
	[84407] = dataList[129],
	[84408] = dataList[130],
	[84409] = dataList[131],
	[84410] = dataList[132],
	[84411] = dataList[133],
	[84412] = dataList[134],
	[84413] = dataList[135],
	[84414] = dataList[136],
	[84415] = dataList[137],
	[84416] = dataList[138],
	[84418] = dataList[139],
	[84419] = dataList[140],
	[84420] = dataList[141],
	[84421] = dataList[142],
	[84422] = dataList[143],
	[84423] = dataList[144],
	[84417] = dataList[145],
	[84424] = dataList[146],
	[84425] = dataList[147],
	[84426] = dataList[148],
	[84427] = dataList[149],
	[84428] = dataList[150],
	[84429] = dataList[151],
	[84430] = dataList[152],
	[84431] = dataList[153],
	[84432] = dataList[154],
	[84433] = dataList[155],
	[84434] = dataList[156],
	[84435] = dataList[157],
	[84436] = dataList[158],
	[84437] = dataList[159],
	[84438] = dataList[160],
	[84439] = dataList[161],
	[84440] = dataList[162],
	[84441] = dataList[163],
	[84442] = dataList[164],
	[84443] = dataList[165],
	[84444] = dataList[166],
	[84445] = dataList[167],
	[84446] = dataList[168],
	[84447] = dataList[169],
	[84448] = dataList[170],
	[84449] = dataList[171],
	[84450] = dataList[172],
	[84451] = dataList[173],
	[84452] = dataList[174],
	[84453] = dataList[175],
	[84454] = dataList[176],
	[84455] = dataList[177],
	[84456] = dataList[178],
	[84457] = dataList[179],
	[84458] = dataList[180],
	[84459] = dataList[181],
	[84460] = dataList[182],
	[84461] = dataList[183],
	[84462] = dataList[184],
	[84463] = dataList[185],
	[84464] = dataList[186],
	[84465] = dataList[187],
	[84466] = dataList[188],
	[84467] = dataList[189],
	[84468] = dataList[190],
	[84469] = dataList[191],
	[84470] = dataList[192],
	[84471] = dataList[193],
	[84472] = dataList[194],
	[84473] = dataList[195],
	[84474] = dataList[196],
	[84475] = dataList[197],
	[84476] = dataList[198],
	[84477] = dataList[199],
	[84478] = dataList[200],
	[84479] = dataList[201],
	[84480] = dataList[202],
	[84481] = dataList[203],
	[84482] = dataList[204],
	[84483] = dataList[205],
	[84484] = dataList[206],
	[84485] = dataList[207],
	[84486] = dataList[208],
	[84487] = dataList[209],
	[84488] = dataList[210],
	[84489] = dataList[211],
	[84490] = dataList[212],
	[84491] = dataList[213],
	[84492] = dataList[214],
	[84493] = dataList[215],
	[84494] = dataList[216],
	[84495] = dataList[217],
	[84496] = dataList[218],
	[84497] = dataList[219],
	[84498] = dataList[220],
	[84499] = dataList[221],
	[84500] = dataList[222],
	[84501] = dataList[223],
	[84502] = dataList[224],
	[84503] = dataList[225],
	[84504] = dataList[226],
	[84505] = dataList[227],
	[84506] = dataList[228],
	[84507] = dataList[229],
	[84508] = dataList[230],
	[84509] = dataList[231],
	[84510] = dataList[232],
	[84511] = dataList[233],
	[84512] = dataList[234],
	[84513] = dataList[235],
	[84514] = dataList[236],
	[84515] = dataList[237],
	[84516] = dataList[238],
	[84517] = dataList[239],
	[84518] = dataList[240],
	[84519] = dataList[241],
	[84520] = dataList[242],
	[84521] = dataList[243],
	[84522] = dataList[244],
	[84523] = dataList[245],
	[84524] = dataList[246],
	[84525] = dataList[247],
	[84526] = dataList[248],
	[84527] = dataList[249],
	[84528] = dataList[250],
	[84529] = dataList[251],
	[84530] = dataList[252],
	[84531] = dataList[253],
	[84532] = dataList[254],
	[84533] = dataList[255],
	[84534] = dataList[256],
	[84535] = dataList[257],
	[84536] = dataList[258],
	[84537] = dataList[259],
	[84538] = dataList[260],
	[84539] = dataList[261],
	[84540] = dataList[262],
	[84541] = dataList[263],
	[84542] = dataList[264],
	[84543] = dataList[265],
	[84544] = dataList[266],
	[84545] = dataList[267],
	[84546] = dataList[268],
	[84547] = dataList[269],
	[84548] = dataList[270],
	[84549] = dataList[271],
	[84550] = dataList[272],
	[84551] = dataList[273],
	[84552] = dataList[274],
	[84553] = dataList[275],
	[84554] = dataList[276],
	[84555] = dataList[277],
	[84556] = dataList[278],
	[84557] = dataList[279],
	[84558] = dataList[280],
	[84559] = dataList[281],
	[84560] = dataList[282],
	[84561] = dataList[283],
	[84562] = dataList[284],
	[84563] = dataList[285],
	[84564] = dataList[286],
	[84565] = dataList[287],
	[84566] = dataList[288],
	[84567] = dataList[289],
	[84568] = dataList[290],
	[84569] = dataList[291],
	[84570] = dataList[292],
	[84571] = dataList[293],
	[84572] = dataList[294],
	[84573] = dataList[295],
	[84574] = dataList[296],
	[84575] = dataList[297],
	[84576] = dataList[298],
	[84577] = dataList[299],
	[84578] = dataList[300],
	[84579] = dataList[301],
	[84580] = dataList[302],
	[84581] = dataList[303],
	[84582] = dataList[304],
	[84583] = dataList[305],
	[84584] = dataList[306],
	[84585] = dataList[307],
	[84586] = dataList[308],
	[84587] = dataList[309],
	[84588] = dataList[310],
	[84589] = dataList[311],
	[84590] = dataList[312],
	[84591] = dataList[313],
	[84592] = dataList[314],
	[84593] = dataList[315],
	[84594] = dataList[316],
	[84595] = dataList[317],
	[84596] = dataList[318],
	[84597] = dataList[319],
	[84598] = dataList[320],
	[84599] = dataList[321],
	[84600] = dataList[322],
	[84601] = dataList[323],
	[84602] = dataList[324],
	[84603] = dataList[325],
	[84604] = dataList[326]
}

t_awaken_item_ext.dataList = dataList

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

return t_awaken_item_ext
