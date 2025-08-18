-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\diyizhang\\ResTalk.lua

local indexMap = {
	id = 1,
	npc_id = 6,
	bg_blur = 10,
	play_delay = 14,
	scenery_id = 13,
	section = 4,
	clear_role = 15,
	bgm = 12,
	vocal = 11,
	bg_voice = 18,
	terminal_type = 27,
	extra_npc = 21,
	hide_name = 22,
	talk_in_ani = 24,
	terminal_effect = 25,
	page = 5,
	talk_type = 2,
	head_emoji = 9,
	action = 7,
	switch_show = 17,
	font_size = 23,
	terminal_bg = 26,
	bg_id = 19,
	mask_alpha = 20,
	special_effect = 28,
	talk = 3,
	branch_info = 29,
	switch_effect = 16,
	show_head = 8
}
local indexMapResTalkAction = {
	emoji = 5,
	pos = 1,
	action = 3,
	npc_id = 2,
	show = 4
}
local RTResTalkAction = {}

RTResTalkAction[1] = {
	[1] = 1,
	[2] = 141
}
RTResTalkAction[2] = {
	[1] = 2,
	[2] = 141
}
RTResTalkAction[3] = {
	[1] = 3,
	[2] = 107
}
RTResTalkAction[4] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[6] = {
	[1] = 1,
	[2] = 151,
	[3] = {
		1
	}
}
RTResTalkAction[7] = {
	[1] = 0,
	[2] = 151
}
RTResTalkAction[8] = {
	1,
	107,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[9] = {
	1,
	141,
	{
		1
	},
	nil,
	3
}
RTResTalkAction[10] = {
	[1] = 1,
	[2] = 662,
	[3] = {
		2
	}
}
RTResTalkAction[11] = {
	[1] = 1,
	[2] = 133,
	[3] = {
		1
	}
}
RTResTalkAction[12] = {
	[1] = 0,
	[2] = 662
}
RTResTalkAction[13] = {
	[1] = 0,
	[2] = 133
}
RTResTalkAction[14] = {
	[1] = 1,
	[2] = 133
}
RTResTalkAction[15] = {
	[1] = 1,
	[2] = 667
}
RTResTalkAction[16] = {
	[1] = 0,
	[2] = 667
}
RTResTalkAction[17] = {
	[1] = 1,
	[2] = 133,
	[3] = {
		3
	}
}
RTResTalkAction[18] = {
	[1] = 1,
	[2] = 664
}
RTResTalkAction[19] = {
	[1] = 1,
	[2] = 664,
	[3] = {
		3
	}
}
RTResTalkAction[20] = {
	[1] = 0,
	[2] = 664
}
RTResTalkAction[21] = {
	[1] = 1,
	[2] = 662,
	[3] = {
		1
	}
}
RTResTalkAction[22] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[23] = {
	[1] = 1,
	[2] = 151
}
RTResTalkAction[24] = {
	1,
	107,
	{
		2
	},
	nil,
	8
}
RTResTalkAction[25] = {
	[1] = 1,
	[2] = 151,
	[3] = {
		1,
		10043
	}
}
RTResTalkAction[26] = {
	[1] = 1,
	[2] = 34
}
RTResTalkAction[27] = {
	[1] = 0,
	[2] = 34
}
RTResTalkAction[28] = {
	1,
	133,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[29] = {
	[1] = 2,
	[2] = 133
}
RTResTalkAction[30] = {
	3,
	119,
	{
		3
	},
	nil,
	5
}
RTResTalkAction[31] = {
	2,
	133,
	nil,
	nil,
	1
}
RTResTalkAction[32] = {
	[1] = 3,
	[2] = 119
}
RTResTalkAction[33] = {
	3,
	119,
	nil,
	nil,
	3
}
RTResTalkAction[34] = {
	[1] = 1,
	[2] = 119
}
RTResTalkAction[35] = {
	1,
	107,
	{
		2
	},
	nil,
	7
}
RTResTalkAction[36] = {
	[1] = 0,
	[2] = 119
}
RTResTalkAction[37] = {
	[1] = 1,
	[2] = 151,
	[3] = {
		2
	}
}
RTResTalkAction[38] = {
	[1] = 1,
	[2] = 151,
	[3] = {
		1,
		10023
	}
}
RTResTalkAction[39] = {
	[1] = 1,
	[2] = 151,
	[3] = {
		10023
	}
}
RTResTalkAction[40] = {
	[1] = 1,
	[2] = 151,
	[3] = {
		10013
	}
}
RTResTalkAction[41] = {
	1,
	119,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[42] = {
	[1] = 1,
	[2] = 133,
	[3] = {
		2
	}
}
RTResTalkAction[43] = {
	1,
	112,
	nil,
	nil,
	2
}
RTResTalkAction[44] = {
	[1] = 2,
	[2] = 112
}
RTResTalkAction[45] = {
	[1] = 3,
	[2] = 52,
	[3] = {
		1
	}
}
RTResTalkAction[46] = {
	2,
	112,
	nil,
	nil,
	3
}
RTResTalkAction[47] = {
	[1] = 3,
	[2] = 52
}
RTResTalkAction[48] = {
	2,
	112,
	nil,
	nil,
	1
}
RTResTalkAction[49] = {
	2,
	112,
	nil,
	nil,
	2
}
RTResTalkAction[50] = {
	[1] = 0,
	[2] = 112
}
RTResTalkAction[51] = {
	[1] = 0,
	[2] = 52
}
RTResTalkAction[52] = {
	1,
	112,
	nil,
	nil,
	1
}
RTResTalkAction[53] = {
	[1] = 1,
	[2] = 112
}
RTResTalkAction[54] = {
	1,
	112,
	nil,
	nil,
	3
}
RTResTalkAction[55] = {
	1,
	113,
	nil,
	nil,
	1
}
RTResTalkAction[56] = {
	[1] = 1,
	[2] = 113
}
RTResTalkAction[57] = {
	1,
	113,
	nil,
	nil,
	0
}
RTResTalkAction[58] = {
	1,
	113,
	nil,
	nil,
	3
}
RTResTalkAction[59] = {
	[1] = 0,
	[2] = 113
}
RTResTalkAction[60] = {
	[1] = 1,
	[2] = 113,
	[3] = {
		3
	}
}
RTResTalkAction[61] = {
	[1] = 1,
	[2] = 113,
	[3] = {
		1
	}
}
RTResTalkAction[62] = {
	[1] = 2,
	[2] = 664
}
RTResTalkAction[63] = {
	3,
	107,
	nil,
	nil,
	3
}
RTResTalkAction[64] = {
	[1] = 1,
	[2] = 664,
	[3] = {
		2
	}
}
RTResTalkAction[65] = {
	[1] = 3,
	[2] = 151
}
RTResTalkAction[66] = {
	1,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[67] = {
	1,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[68] = {
	1,
	107,
	{
		1,
		10021
	},
	nil,
	8
}
RTResTalkAction[69] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[70] = {
	[1] = 3,
	[2] = 133
}
RTResTalkAction[71] = {
	[1] = 4,
	[2] = 107
}
RTResTalkAction[72] = {
	[1] = 5,
	[2] = 141
}
RTResTalkAction[73] = {
	2,
	362,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[74] = {
	[1] = 3,
	[2] = 361
}
RTResTalkAction[75] = {
	[1] = 2,
	[2] = 362
}
RTResTalkAction[76] = {
	[1] = 1,
	[2] = 376
}
RTResTalkAction[77] = {
	[1] = 0,
	[2] = 362
}
RTResTalkAction[78] = {
	[1] = 0,
	[2] = 361
}
RTResTalkAction[79] = {
	[1] = 1,
	[2] = 360
}
RTResTalkAction[80] = {
	[1] = 0,
	[2] = 376
}
RTResTalkAction[81] = {
	[1] = 0,
	[2] = 360
}
RTResTalkAction[82] = {
	1,
	141,
	{
		3
	},
	nil,
	3
}
RTResTalkAction[83] = {
	[1] = 1,
	[2] = 349
}
RTResTalkAction[84] = {
	[1] = 0,
	[2] = 349
}
RTResTalkAction[85] = {
	1,
	143,
	{
		3
	},
	nil,
	5
}
RTResTalkAction[86] = {
	1,
	119,
	nil,
	nil,
	7
}
RTResTalkAction[87] = {
	[1] = 0,
	[2] = 143
}
RTResTalkAction[88] = {
	1,
	119,
	{
		2
	},
	nil,
	5
}
RTResTalkAction[89] = {
	1,
	119,
	nil,
	nil,
	2
}
RTResTalkAction[90] = {
	1,
	143,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[91] = {
	[1] = 2,
	[2] = 143
}
RTResTalkAction[92] = {
	3,
	119,
	{
		2
	},
	nil,
	5
}
RTResTalkAction[93] = {
	2,
	143,
	nil,
	nil,
	2
}
RTResTalkAction[94] = {
	3,
	119,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[95] = {
	[1] = 1,
	[2] = 138
}
RTResTalkAction[96] = {
	[1] = 0,
	[2] = 138
}
RTResTalkAction[97] = {
	[1] = 1,
	[2] = 300
}
RTResTalkAction[98] = {
	[1] = 0,
	[2] = 300
}
RTResTalkAction[99] = {
	1,
	107,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[100] = {
	[1] = 1,
	[2] = 143
}
RTResTalkAction[101] = {
	[1] = 1,
	[2] = 670,
	[3] = {
		1
	}
}
RTResTalkAction[102] = {
	[1] = 0,
	[2] = 670
}
RTResTalkAction[103] = {
	[1] = 2,
	[2] = 138
}
RTResTalkAction[104] = {
	3,
	133,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[105] = {
	[1] = 1,
	[2] = 670
}
RTResTalkAction[106] = {
	[1] = 4,
	[2] = 151
}
RTResTalkAction[107] = {
	[1] = 5,
	[2] = 133
}
RTResTalkAction[108] = {
	[1] = 1,
	[2] = 151,
	[3] = {
		3
	}
}
RTResTalkAction[109] = {
	1,
	133,
	nil,
	nil,
	1
}
RTResTalkAction[110] = {
	1,
	133,
	nil,
	nil,
	0
}
RTResTalkAction[111] = {
	1,
	133,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[112] = {
	1,
	141,
	nil,
	nil,
	1
}
RTResTalkAction[113] = {
	1,
	107,
	{
		2
	},
	nil,
	6
}
RTResTalkAction[114] = {
	[1] = 3,
	[2] = 663
}
RTResTalkAction[115] = {
	[1] = 0,
	[2] = 663
}
RTResTalkAction[116] = {
	1,
	107,
	{
		1,
		10031
	},
	nil,
	5
}
RTResTalkAction[117] = {
	1,
	107,
	{
		2,
		10031
	},
	nil,
	6
}
RTResTalkAction[118] = {
	[1] = 1,
	[2] = 662
}
RTResTalkAction[119] = {
	1,
	107,
	nil,
	nil,
	7
}
RTResTalkAction[120] = {
	[1] = 1,
	[2] = 144
}
RTResTalkAction[121] = {
	[1] = 0,
	[2] = 144
}
RTResTalkAction[122] = {
	[1] = 2,
	[2] = 151
}
RTResTalkAction[123] = {
	[1] = 3,
	[2] = 663,
	[3] = {
		2
	}
}
RTResTalkAction[124] = {
	[1] = 3,
	[2] = 663,
	[3] = {
		1
	}
}
RTResTalkAction[125] = {
	[1] = 2,
	[2] = 151,
	[3] = {
		3
	}
}
RTResTalkAction[126] = {
	1,
	107,
	{
		2
	},
	nil,
	5
}

local Data = {
	[8010001] = {
		8010001,
		0,
		Lang.get(44478),
		8010,
		1,
		107,
		nil,
		1,
		5,
		nil,
		nil,
		nil,
		8601,
		nil,
		nil,
		nil,
		1,
		nil,
		8601
	},
	[8010002] = {
		8010002,
		0,
		Lang.get(43851),
		8010,
		2,
		151,
		nil,
		1,
		0
	},
	[8010003] = {
		8010003,
		0,
		Lang.get(43852),
		8010,
		3,
		300
	},
	[8010004] = {
		8010004,
		0,
		Lang.get(32169),
		8010,
		4,
		151,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		8602,
		1,
		1,
		nil,
		1,
		nil,
		8602
	},
	[8010005] = {
		8010005,
		0,
		Lang.get(32170),
		8010,
		5,
		300
	},
	[8010006] = {
		8010006,
		0,
		Lang.get(43853),
		8010,
		6,
		151,
		nil,
		1
	},
	[8010007] = {
		8010007,
		0,
		Lang.get(32960),
		8010,
		7,
		151,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		8603,
		nil,
		1,
		nil,
		1,
		nil,
		8603
	},
	[8010008] = {
		8010008,
		0,
		Lang.get(32176),
		8010,
		8,
		300
	},
	[8010009] = {
		8010009,
		0,
		Lang.get(32177),
		8010,
		9,
		300
	},
	[8010010] = {
		8010010,
		0,
		Lang.get(32178),
		8010,
		10,
		300
	},
	[8010011] = {
		8010011,
		5,
		Lang.get(43854),
		8010,
		11,
		151,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		8605,
		nil,
		1,
		nil,
		1,
		nil,
		8605
	},
	[8010012] = {
		8010012,
		0,
		Lang.get(32181),
		8010,
		12,
		107,
		nil,
		1,
		6
	},
	[8010013] = {
		8010013,
		0,
		Lang.get(32961),
		8010,
		13,
		151,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		8501
	},
	[8010014] = {
		8010014,
		0,
		Lang.get(32183),
		8010,
		14,
		107,
		nil,
		1,
		6
	},
	[8010015] = {
		8010015,
		0,
		Lang.get(32184),
		8010,
		15,
		141,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		8606,
		1,
		1,
		nil,
		1,
		nil,
		8606
	},
	[8010016] = {
		8010016,
		5,
		Lang.get(43855),
		8010,
		16,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[8010017] = {
		8010017,
		0,
		Lang.get(43856),
		8010,
		17,
		141,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[8010018] = {
		8010018,
		4,
		nil,
		8010,
		18,
		300,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		},
		[29] = {
			{
				id = 8010019,
				branch_content = Lang.get(42679)
			}
		}
	},
	[8010019] = {
		8010019,
		5,
		Lang.get(43857),
		8010,
		19,
		300
	},
	[8021001] = {
		8021001,
		0,
		Lang.get(43858),
		8021,
		1,
		701,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		8607,
		nil,
		1,
		nil,
		1,
		nil,
		8609
	},
	[8021002] = {
		8021002,
		0,
		Lang.get(43859),
		8021,
		2,
		141,
		nil,
		1
	},
	[8021003] = {
		8021003,
		7,
		"3",
		8021,
		3,
		141,
		nil,
		nil,
		nil,
		4,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[8021004] = {
		8021004,
		0,
		Lang.get(43860),
		8021,
		4,
		300,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		nil,
		0.8
	},
	[8021005] = {
		8021005,
		5,
		Lang.get(36158),
		8021,
		5,
		151,
		{
			RTResTalkAction[6],
			RTResTalkAction[4]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		1,
		[19] = 8799,
		[17] = 1
	},
	[8021006] = {
		8021006,
		0,
		Lang.get(36160),
		8021,
		6,
		300,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		8608,
		nil,
		1,
		nil,
		1,
		nil,
		8608
	},
	[8021007] = {
		8021007,
		0,
		Lang.get(32199),
		8021,
		7,
		141,
		nil,
		1
	},
	[8030001] = {
		8030001,
		0,
		Lang.get(32203),
		8030,
		1,
		667,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		8006,
		1,
		nil,
		nil,
		1,
		nil,
		8006
	},
	[8030002] = {
		8030002,
		0,
		Lang.get(32204),
		8030,
		2,
		663,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		8112
	},
	[8030003] = {
		8030003,
		0,
		Lang.get(43861),
		8030,
		3,
		662,
		nil,
		1
	},
	[8030004] = {
		8030004,
		5,
		Lang.get(43862),
		8030,
		4,
		701,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		8113
	},
	[8030005] = {
		8030005,
		5,
		Lang.get(36162),
		8030,
		5,
		667,
		nil,
		1
	},
	[8030006] = {
		8030006,
		0,
		Lang.get(32211),
		8030,
		6,
		151,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		8102,
		[19] = 8102,
		[17] = 1
	},
	[8030007] = {
		8030007,
		0,
		Lang.get(43863),
		8030,
		7,
		107,
		nil,
		1,
		3
	},
	[8030008] = {
		8030008,
		0,
		Lang.get(43864),
		8030,
		8,
		141,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		8103,
		nil,
		nil,
		nil,
		nil,
		nil,
		8103
	},
	[8030009] = {
		8030009,
		0,
		Lang.get(43865),
		8030,
		9,
		151,
		nil,
		1
	},
	[8030010] = {
		8030010,
		0,
		Lang.get(43866),
		8030,
		10,
		141,
		nil,
		1
	},
	[8030011] = {
		8030011,
		0,
		Lang.get(36163),
		8030,
		11,
		667,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		8104,
		nil,
		1,
		nil,
		1,
		nil,
		8104
	},
	[8030012] = {
		8030012,
		0,
		Lang.get(43867),
		8030,
		12,
		151,
		nil,
		1
	},
	[8030013] = {
		8030013,
		0,
		Lang.get(43868),
		8030,
		13,
		662,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		8105,
		nil,
		1,
		nil,
		1,
		nil,
		8105
	},
	[8030014] = {
		8030014,
		0,
		Lang.get(36166),
		8030,
		14,
		664,
		nil,
		1
	},
	[8030015] = {
		8030015,
		0,
		Lang.get(43869),
		8030,
		15,
		667,
		nil,
		1
	},
	[8030016] = {
		8030016,
		0,
		Lang.get(32227),
		8030,
		16,
		663,
		nil,
		1
	},
	[8030017] = {
		8030017,
		0,
		Lang.get(32228),
		8030,
		17,
		151,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		8502
	},
	[8030018] = {
		8030018,
		0,
		Lang.get(43870),
		8030,
		18,
		151,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		8008,
		nil,
		1,
		nil,
		1,
		nil,
		8008
	},
	[8030019] = {
		8030019,
		0,
		Lang.get(43871),
		8030,
		19,
		664,
		nil,
		1
	},
	[8040001] = {
		8040001,
		0,
		Lang.get(43872),
		8040,
		1,
		151,
		{
			RTResTalkAction[6]
		},
		nil,
		nil,
		3,
		nil,
		60,
		8009,
		0.6,
		nil,
		nil,
		1,
		nil,
		8009
	},
	[8040002] = {
		8040002,
		5,
		Lang.get(46262),
		8040,
		2,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[7]
		}
	},
	[8040003] = {
		8040003,
		0,
		Lang.get(43874),
		8040,
		3,
		141,
		{
			RTResTalkAction[9],
			RTResTalkAction[5]
		}
	},
	[8050001] = {
		8050001,
		11,
		"Videos/AVG_Story1_ShaiYou.mp4",
		8050,
		1,
		141,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[17] = 1
	},
	[8050002] = {
		8050002,
		0,
		Lang.get(43875),
		8050,
		2,
		119,
		nil,
		1,
		nil,
		nil,
		nil,
		30,
		8032,
		1,
		nil,
		nil,
		1,
		nil,
		8032
	},
	[8050003] = {
		8050003,
		0,
		Lang.get(43876),
		8050,
		3,
		143,
		nil,
		1
	},
	[8050004] = {
		8050004,
		3,
		Lang.get(32241),
		8050,
		4,
		143,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		8011,
		0.5,
		1,
		nil,
		1,
		nil,
		8011,
		nil,
		nil,
		1
	},
	[8050005] = {
		8050005,
		0,
		Lang.get(43877),
		8050,
		5,
		663,
		nil,
		1
	},
	[8050006] = {
		8050006,
		0,
		Lang.get(43878),
		8050,
		6,
		662,
		nil,
		1
	},
	[8050007] = {
		8050007,
		0,
		Lang.get(43879),
		8050,
		7,
		662,
		nil,
		1
	},
	[8050008] = {
		8050008,
		0,
		Lang.get(43880),
		8050,
		8,
		662,
		nil,
		1
	},
	[8050009] = {
		8050009,
		0,
		Lang.get(43881),
		8050,
		9,
		133,
		nil,
		1
	},
	[8050010] = {
		8050010,
		0,
		Lang.get(43882),
		8050,
		10,
		133,
		nil,
		1
	},
	[8050011] = {
		8050011,
		0,
		Lang.get(43883),
		8050,
		11,
		662,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3
	},
	[8050012] = {
		8050012,
		0,
		Lang.get(36178),
		8050,
		12,
		133,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[8050013] = {
		8050013,
		7,
		"4",
		8050,
		13,
		133,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		4,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[8050014] = {
		8050014,
		0,
		Lang.get(43884),
		8050,
		14,
		133,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[8050015] = {
		8050015,
		0,
		Lang.get(36188),
		8050,
		15,
		667,
		{
			RTResTalkAction[15],
			RTResTalkAction[13]
		}
	},
	[8050016] = {
		8050016,
		0,
		Lang.get(43885),
		8050,
		16,
		133,
		{
			RTResTalkAction[14],
			RTResTalkAction[16]
		}
	},
	[8050017] = {
		8050017,
		0,
		Lang.get(32280),
		8050,
		17,
		151,
		{
			RTResTalkAction[13]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		8010,
		nil,
		1,
		nil,
		1,
		nil,
		8010
	},
	[8050018] = {
		8050018,
		0,
		Lang.get(32281),
		8050,
		18,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[8050019] = {
		8050019,
		0,
		Lang.get(43886),
		8050,
		19,
		151,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		0.3
	},
	[8050020] = {
		8050020,
		0,
		Lang.get(32999),
		8050,
		20,
		300,
		nil,
		1
	},
	[8050021] = {
		8050021,
		0,
		Lang.get(43887),
		8050,
		21,
		151,
		nil,
		1
	},
	[8050022] = {
		8050022,
		0,
		Lang.get(43888),
		8050,
		22,
		664,
		nil,
		1
	},
	[8060001] = {
		8060001,
		5,
		Lang.get(43889),
		8060,
		1,
		151,
		nil,
		1,
		0,
		nil,
		nil,
		60,
		8290,
		1,
		nil,
		nil,
		1,
		nil,
		8012
	},
	[8060002] = {
		8060002,
		0,
		Lang.get(43890),
		8060,
		2,
		133,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		8291,
		nil,
		nil,
		nil,
		1,
		nil,
		8291
	},
	[8060003] = {
		8060003,
		0,
		Lang.get(43891),
		8060,
		3,
		662,
		nil,
		1
	},
	[8060004] = {
		8060004,
		0,
		Lang.get(43892),
		8060,
		4,
		300
	},
	[8060005] = {
		8060005,
		4,
		nil,
		8060,
		5,
		300,
		[29] = {
			{
				id = 8060006,
				branch_content = Lang.get(42681)
			},
			{
				id = 8060006,
				branch_content = Lang.get(42682)
			}
		}
	},
	[8060006] = {
		8060006,
		0,
		Lang.get(36185),
		8060,
		6,
		133,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[8060007] = {
		8060007,
		0,
		Lang.get(43893),
		8060,
		7,
		300,
		{
			RTResTalkAction[14]
		}
	},
	[8060008] = {
		8060008,
		2,
		Lang.get(43894),
		8060,
		8,
		664,
		{
			RTResTalkAction[18],
			RTResTalkAction[13]
		}
	},
	[8060009] = {
		8060009,
		0,
		"……",
		8060,
		9,
		664,
		{
			RTResTalkAction[18]
		}
	},
	[8060010] = {
		8060010,
		0,
		Lang.get(43895),
		8060,
		10,
		664,
		{
			RTResTalkAction[19]
		}
	},
	[8060011] = {
		8060011,
		0,
		Lang.get(43896),
		8060,
		11,
		667,
		{
			RTResTalkAction[15],
			RTResTalkAction[20]
		}
	},
	[8060012] = {
		8060012,
		0,
		Lang.get(43897),
		8060,
		12,
		662,
		{
			RTResTalkAction[21],
			RTResTalkAction[16]
		}
	},
	[8060013] = {
		8060013,
		0,
		Lang.get(36191),
		8060,
		13,
		133,
		{
			RTResTalkAction[14],
			RTResTalkAction[12]
		}
	},
	[8060014] = {
		8060014,
		0,
		Lang.get(32295),
		8060,
		14,
		300,
		{
			RTResTalkAction[14]
		}
	},
	[8060015] = {
		8060015,
		0,
		Lang.get(43898),
		8060,
		15,
		107,
		{
			RTResTalkAction[22],
			RTResTalkAction[13]
		}
	},
	[8060016] = {
		8060016,
		5,
		Lang.get(32298),
		8060,
		16,
		151,
		{
			RTResTalkAction[23],
			RTResTalkAction[5]
		}
	},
	[8060017] = {
		8060017,
		0,
		Lang.get(32299),
		8060,
		17,
		107,
		{
			RTResTalkAction[24],
			RTResTalkAction[7]
		}
	},
	[8060018] = {
		8060018,
		0,
		Lang.get(32300),
		8060,
		18,
		141,
		{
			RTResTalkAction[1],
			RTResTalkAction[5]
		}
	},
	[8060019] = {
		8060019,
		5,
		Lang.get(32301),
		8060,
		19,
		151,
		{
			RTResTalkAction[25],
			RTResTalkAction[4]
		}
	},
	[8070001] = {
		8070001,
		0,
		Lang.get(43899),
		8070,
		1,
		34,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		8639,
		nil,
		1,
		nil,
		1,
		nil,
		8639
	},
	[8070002] = {
		8070002,
		5,
		Lang.get(43900),
		8070,
		2,
		19,
		nil,
		1
	},
	[8070003] = {
		8070003,
		0,
		Lang.get(43901),
		8070,
		3,
		34,
		{
			RTResTalkAction[26]
		},
		nil,
		nil,
		3
	},
	[8070004] = {
		8070004,
		5,
		Lang.get(43902),
		8070,
		4,
		107,
		{
			RTResTalkAction[27]
		},
		1,
		8,
		nil,
		nil,
		nil,
		8014,
		1,
		1,
		nil,
		nil,
		nil,
		8014
	},
	[8070005] = {
		8070005,
		0,
		Lang.get(43903),
		8070,
		5,
		141,
		nil,
		1,
		0
	},
	[8070006] = {
		8070006,
		0,
		Lang.get(43904),
		8070,
		6,
		662,
		nil,
		1
	},
	[8070007] = {
		8070007,
		0,
		Lang.get(32318),
		8070,
		7,
		34,
		nil,
		1
	},
	[8090001] = {
		8090001,
		0,
		Lang.get(56715),
		8090,
		1,
		119,
		nil,
		1,
		3,
		nil,
		nil,
		60,
		8017,
		1,
		1,
		nil,
		1,
		nil,
		8017
	},
	[8090002] = {
		8090002,
		7,
		"7",
		8090,
		2,
		119,
		nil,
		nil,
		nil,
		3,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[8090003] = {
		8090003,
		0,
		Lang.get(43906),
		8090,
		3,
		133,
		{
			RTResTalkAction[28]
		},
		nil,
		nil,
		3
	},
	[8090004] = {
		8090004,
		5,
		Lang.get(43907),
		8090,
		4,
		119,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		}
	},
	[8090005] = {
		8090005,
		4,
		nil,
		8090,
		5,
		300,
		{
			RTResTalkAction[31],
			RTResTalkAction[32]
		},
		[29] = {
			{
				id = 8090006,
				branch_content = Lang.get(42683)
			}
		}
	},
	[8090006] = {
		8090006,
		0,
		Lang.get(40178),
		8090,
		6,
		133,
		{
			RTResTalkAction[29],
			RTResTalkAction[33]
		}
	},
	[8090007] = {
		8090007,
		0,
		Lang.get(44481),
		8090,
		7,
		119,
		{
			RTResTalkAction[34],
			RTResTalkAction[13]
		}
	},
	[8090008] = {
		8090008,
		0,
		Lang.get(32337),
		8090,
		8,
		107,
		{
			RTResTalkAction[35],
			RTResTalkAction[36]
		}
	},
	[8090009] = {
		8090009,
		0,
		Lang.get(32338),
		8090,
		9,
		119,
		{
			RTResTalkAction[5]
		},
		1,
		3,
		-1,
		nil,
		nil,
		8791
	},
	[8090010] = {
		8090010,
		0,
		Lang.get(43908),
		8090,
		10,
		107,
		nil,
		1,
		10
	},
	[8090011] = {
		8090011,
		0,
		Lang.get(32340),
		8090,
		11,
		141,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[8090012] = {
		8090012,
		0,
		Lang.get(46263),
		8090,
		12,
		107,
		{
			RTResTalkAction[22],
			RTResTalkAction[4]
		}
	},
	[8090013] = {
		8090013,
		0,
		Lang.get(32342),
		8090,
		13,
		300,
		{
			RTResTalkAction[22]
		}
	},
	[8090014] = {
		8090014,
		0,
		Lang.get(33011),
		8090,
		14,
		151,
		{
			RTResTalkAction[5]
		},
		1,
		0,
		nil,
		nil,
		nil,
		8630,
		1,
		1,
		nil,
		1,
		nil,
		8630
	},
	[8090015] = {
		8090015,
		0,
		Lang.get(22255),
		8090,
		15,
		3,
		nil,
		1,
		nil,
		nil,
		1070
	},
	[8090016] = {
		8090016,
		0,
		Lang.get(43909),
		8090,
		16,
		151,
		nil,
		1
	},
	[8090017] = {
		8090017,
		0,
		Lang.get(22255),
		8090,
		17,
		3,
		nil,
		1,
		nil,
		nil,
		1070
	},
	[8090018] = {
		8090018,
		0,
		Lang.get(36199),
		8090,
		18,
		151,
		nil,
		1
	},
	[8090019] = {
		8090019,
		5,
		Lang.get(32348),
		8090,
		19,
		52,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		8631,
		1,
		nil,
		nil,
		1,
		nil,
		8631
	},
	[8090020] = {
		8090020,
		0,
		Lang.get(32350),
		8090,
		20,
		107,
		nil,
		1,
		8
	},
	[8090021] = {
		8090021,
		5,
		Lang.get(32352),
		8090,
		21,
		133,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		8790
	},
	[8090022] = {
		8090022,
		0,
		Lang.get(32354),
		8090,
		22,
		151,
		{
			RTResTalkAction[37],
			RTResTalkAction[13]
		}
	},
	[8100001] = {
		8100001,
		0,
		Lang.get(43910),
		8100,
		1,
		151,
		nil,
		1,
		0,
		nil,
		nil,
		3,
		8019,
		1,
		1,
		nil,
		nil,
		nil,
		8019
	},
	[8100002] = {
		8100002,
		0,
		Lang.get(36202),
		8100,
		2,
		107,
		nil,
		1,
		7
	},
	[8100003] = {
		8100003,
		0,
		Lang.get(43911),
		8100,
		3,
		151,
		{
			RTResTalkAction[38]
		},
		nil,
		nil,
		3
	},
	[8100004] = {
		8100004,
		0,
		Lang.get(56716),
		8100,
		4,
		119,
		{
			RTResTalkAction[34],
			RTResTalkAction[7]
		}
	},
	[8100005] = {
		8100005,
		0,
		Lang.get(32365),
		8100,
		5,
		151,
		{
			RTResTalkAction[39],
			RTResTalkAction[36]
		}
	},
	[8100006] = {
		8100006,
		5,
		Lang.get(43913),
		8100,
		6,
		107,
		{
			RTResTalkAction[7]
		},
		1,
		7,
		-1,
		nil,
		nil,
		8632,
		nil,
		nil,
		nil,
		1,
		nil,
		8019
	},
	[8100007] = {
		8100007,
		0,
		Lang.get(33014),
		8100,
		7,
		151,
		nil,
		1,
		0
	},
	[8100008] = {
		8100008,
		0,
		Lang.get(32369),
		8100,
		8,
		151,
		{
			RTResTalkAction[40]
		},
		nil,
		nil,
		3
	},
	[8100009] = {
		8100009,
		5,
		Lang.get(32370),
		8100,
		9,
		119,
		{
			RTResTalkAction[41],
			RTResTalkAction[7]
		}
	},
	[8100010] = {
		8100010,
		5,
		Lang.get(32371),
		8100,
		10,
		107,
		{
			RTResTalkAction[36]
		},
		1,
		6,
		-1,
		nil,
		nil,
		8633
	},
	[8100011] = {
		8100011,
		0,
		Lang.get(32372),
		8100,
		11,
		151,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		8634,
		nil,
		nil,
		nil,
		1,
		nil,
		8019
	},
	[8100012] = {
		8100012,
		0,
		Lang.get(43914),
		8100,
		12,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		8635
	},
	[8100013] = {
		8100013,
		0,
		Lang.get(43915),
		8100,
		13,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		8504
	},
	[8100014] = {
		8100014,
		0,
		Lang.get(32381),
		8100,
		14,
		151,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[8100015] = {
		8100015,
		0,
		Lang.get(32382),
		8100,
		15,
		300,
		{
			RTResTalkAction[23]
		}
	},
	[8100016] = {
		8100016,
		0,
		Lang.get(32383),
		8100,
		16,
		151,
		{
			RTResTalkAction[37]
		}
	},
	[8110001] = {
		8110001,
		3,
		Lang.get(32388),
		8110,
		1,
		151,
		nil,
		nil,
		nil,
		nil,
		nil,
		23,
		nil,
		nil,
		nil,
		nil,
		1,
		nil,
		8632,
		nil,
		nil,
		1
	},
	[8110002] = {
		8110002,
		0,
		Lang.get(32389),
		8110,
		2,
		107,
		nil,
		1,
		8,
		[19] = 8021,
		[17] = 1
	},
	[8110003] = {
		8110003,
		0,
		Lang.get(43916),
		8110,
		3,
		133,
		nil,
		1,
		0
	},
	[8110004] = {
		8110004,
		0,
		Lang.get(43917),
		8110,
		4,
		133,
		nil,
		1,
		0
	},
	[8110005] = {
		8110005,
		0,
		Lang.get(43918),
		8110,
		5,
		133,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[8110006] = {
		8110006,
		0,
		Lang.get(43919),
		8110,
		6,
		133,
		{
			RTResTalkAction[42]
		}
	},
	[8110007] = {
		8110007,
		0,
		Lang.get(32399),
		8110,
		7,
		112,
		{
			RTResTalkAction[13]
		},
		1,
		1,
		nil,
		nil,
		nil,
		nil,
		3,
		1,
		nil,
		1,
		nil,
		8022,
		nil,
		nil,
		nil,
		nil,
		nil,
		"57"
	},
	[8110008] = {
		8110008,
		0,
		Lang.get(32400),
		8110,
		8,
		52,
		nil,
		1,
		0
	},
	[8110009] = {
		8110009,
		0,
		Lang.get(43920),
		8110,
		9,
		112,
		{
			RTResTalkAction[43]
		},
		nil,
		nil,
		3
	},
	[8110010] = {
		8110010,
		0,
		"？？？",
		8110,
		10,
		52,
		{
			RTResTalkAction[44],
			RTResTalkAction[45]
		}
	},
	[8110011] = {
		8110011,
		0,
		Lang.get(32402),
		8110,
		11,
		112,
		{
			RTResTalkAction[46],
			RTResTalkAction[47]
		}
	},
	[8110012] = {
		8110012,
		0,
		Lang.get(32403),
		8110,
		12,
		52,
		{
			RTResTalkAction[44],
			RTResTalkAction[47]
		}
	},
	[8110013] = {
		8110013,
		5,
		Lang.get(32404),
		8110,
		13,
		112,
		{
			RTResTalkAction[48],
			RTResTalkAction[47]
		}
	},
	[8110014] = {
		8110014,
		5,
		Lang.get(32405),
		8110,
		14,
		52,
		{
			RTResTalkAction[44],
			RTResTalkAction[47]
		}
	},
	[8110015] = {
		8110015,
		0,
		Lang.get(32406),
		8110,
		15,
		112,
		{
			RTResTalkAction[49],
			RTResTalkAction[47]
		}
	},
	[8110016] = {
		8110016,
		0,
		Lang.get(32407),
		8110,
		16,
		52,
		{
			RTResTalkAction[44],
			RTResTalkAction[47]
		}
	},
	[8110017] = {
		8110017,
		3,
		Lang.get(32408),
		8110,
		17,
		52,
		{
			RTResTalkAction[50],
			RTResTalkAction[51]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1.5,
		1,
		nil,
		1,
		nil,
		8023,
		nil,
		nil,
		1
	},
	[8110018] = {
		8110018,
		0,
		Lang.get(32409),
		8110,
		18,
		300,
		[19] = 8600,
		[17] = 1
	},
	[8110019] = {
		8110019,
		3,
		Lang.get(43921),
		8110,
		19,
		300,
		[22] = 1
	},
	[8110020] = {
		8110020,
		5,
		Lang.get(32415),
		8110,
		20,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		8024,
		[19] = 8024,
		[17] = 1
	},
	[8110021] = {
		8110021,
		0,
		Lang.get(36208),
		8110,
		21,
		112,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		8636
	},
	[8110022] = {
		8110022,
		4,
		nil,
		8110,
		22,
		300,
		[29] = {
			{
				id = 8110023,
				branch_content = Lang.get(43922)
			}
		}
	},
	[8110023] = {
		8110023,
		0,
		Lang.get(32419),
		8110,
		23,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		8025,
		1,
		[19] = 8025,
		[17] = 1
	},
	[8110024] = {
		8110024,
		0,
		Lang.get(32421),
		8110,
		24,
		112,
		nil,
		1,
		2
	},
	[8120001] = {
		8120001,
		0,
		Lang.get(32422),
		8120,
		1,
		133,
		nil,
		1,
		0,
		nil,
		nil,
		60,
		8026,
		1,
		nil,
		nil,
		1,
		nil,
		8026
	},
	[8120002] = {
		8120002,
		0,
		Lang.get(43923),
		8120,
		2,
		300
	},
	[8120003] = {
		8120003,
		0,
		Lang.get(43924),
		8120,
		3,
		112,
		{
			RTResTalkAction[52]
		},
		nil,
		nil,
		3
	},
	[8120004] = {
		8120004,
		0,
		Lang.get(32446),
		8120,
		4,
		112,
		{
			RTResTalkAction[53]
		}
	},
	[8120005] = {
		8120005,
		0,
		Lang.get(43925),
		8120,
		5,
		300,
		{
			RTResTalkAction[53]
		}
	},
	[8120006] = {
		8120006,
		0,
		Lang.get(32429),
		8120,
		6,
		112,
		{
			RTResTalkAction[50]
		},
		1,
		3,
		nil,
		nil,
		nil,
		8637,
		nil,
		1,
		nil,
		1,
		nil,
		8637
	},
	[8120007] = {
		8120007,
		0,
		Lang.get(43926),
		8120,
		7,
		112,
		nil,
		1,
		0
	},
	[8120008] = {
		8120008,
		0,
		Lang.get(43927),
		8120,
		8,
		112,
		{
			RTResTalkAction[54]
		},
		nil,
		nil,
		3
	},
	[8120009] = {
		8120009,
		0,
		Lang.get(46264),
		8120,
		9,
		300,
		{
			RTResTalkAction[53]
		}
	},
	[8120010] = {
		8120010,
		0,
		Lang.get(36210),
		8120,
		10,
		112,
		{
			RTResTalkAction[52]
		}
	},
	[8130001] = {
		8130001,
		0,
		Lang.get(36211),
		8130,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		57,
		8130,
		[19] = 8130,
		[17] = 1
	},
	[8130002] = {
		8130002,
		0,
		Lang.get(43928),
		8130,
		2,
		300
	},
	[8130003] = {
		8130003,
		0,
		Lang.get(32438),
		8130,
		3,
		112,
		{
			RTResTalkAction[54]
		},
		nil,
		nil,
		3
	},
	[8130004] = {
		8130004,
		4,
		nil,
		8130,
		4,
		112,
		{
			RTResTalkAction[53]
		},
		[29] = {
			{
				id = 8130005,
				branch_content = Lang.get(42688)
			},
			{
				id = 8130007,
				branch_content = Lang.get(42689)
			},
			{
				id = 8130011,
				branch_content = Lang.get(42690)
			}
		}
	},
	[8130005] = {
		8130005,
		0,
		Lang.get(43929),
		8130,
		5,
		112,
		{
			RTResTalkAction[53]
		}
	},
	[8130006] = {
		8130006,
		4,
		nil,
		8130,
		6,
		112,
		{
			RTResTalkAction[53]
		},
		[29] = {
			{
				id = 8130004,
				branch_content = Lang.get(42569)
			}
		}
	},
	[8130007] = {
		8130007,
		0,
		Lang.get(43930),
		8130,
		7,
		112,
		{
			RTResTalkAction[53]
		}
	},
	[8130008] = {
		8130008,
		0,
		Lang.get(44482),
		8130,
		8,
		112,
		{
			RTResTalkAction[53]
		}
	},
	[8130009] = {
		8130009,
		0,
		Lang.get(43932),
		8130,
		9,
		112,
		{
			RTResTalkAction[53]
		}
	},
	[8130010] = {
		8130010,
		4,
		nil,
		8130,
		10,
		112,
		{
			RTResTalkAction[50]
		},
		[29] = {
			{
				id = 8130004,
				branch_content = Lang.get(42569)
			}
		}
	},
	[8130011] = {
		8130011,
		0,
		Lang.get(43933),
		8130,
		11,
		112,
		{
			RTResTalkAction[53]
		}
	},
	[8130012] = {
		8130012,
		11,
		"HeroUltra/12004/video_12004_ultra_short.mp4",
		8130,
		12,
		112,
		{
			RTResTalkAction[50]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[8130013] = {
		8130013,
		0,
		Lang.get(32450),
		8130,
		13,
		300,
		nil,
		nil,
		nil,
		-1,
		nil,
		nil,
		8130,
		[19] = 8130,
		[17] = 1
	},
	[8130014] = {
		8130014,
		5,
		Lang.get(32451),
		8130,
		14,
		113,
		{
			RTResTalkAction[55]
		},
		nil,
		nil,
		3
	},
	[8130015] = {
		8130015,
		4,
		nil,
		8130,
		15,
		300,
		{
			RTResTalkAction[56]
		},
		[29] = {
			{
				id = 8130016,
				branch_content = Lang.get(43934)
			},
			{
				id = 8130016,
				branch_content = Lang.get(42691)
			}
		}
	},
	[8130016] = {
		8130016,
		0,
		Lang.get(43935),
		8130,
		16,
		300,
		{
			RTResTalkAction[56]
		}
	},
	[8130017] = {
		8130017,
		0,
		Lang.get(43936),
		8130,
		17,
		300,
		{
			RTResTalkAction[57]
		}
	},
	[8130018] = {
		8130018,
		0,
		Lang.get(36222),
		8130,
		18,
		113,
		{
			RTResTalkAction[56]
		}
	},
	[8130019] = {
		8130019,
		0,
		Lang.get(36224),
		8130,
		19,
		300,
		{
			RTResTalkAction[56]
		}
	},
	[8130020] = {
		8130020,
		0,
		Lang.get(36225),
		8130,
		20,
		113,
		{
			RTResTalkAction[56]
		}
	},
	[8130021] = {
		8130021,
		0,
		Lang.get(43937),
		8130,
		21,
		300,
		{
			RTResTalkAction[56]
		}
	},
	[8130022] = {
		8130022,
		2,
		Lang.get(32460),
		8130,
		22,
		300,
		{
			RTResTalkAction[56]
		}
	},
	[8130023] = {
		8130023,
		4,
		nil,
		8130,
		23,
		300,
		{
			RTResTalkAction[56]
		},
		[29] = {
			{
				id = 8130024,
				branch_content = Lang.get(42692)
			},
			{
				id = 8130024,
				branch_content = Lang.get(42693)
			}
		}
	},
	[8130024] = {
		8130024,
		0,
		Lang.get(43938),
		8130,
		24,
		300,
		{
			RTResTalkAction[56]
		}
	},
	[8130025] = {
		8130025,
		0,
		Lang.get(36228),
		8130,
		25,
		113,
		{
			RTResTalkAction[58]
		}
	},
	[8130026] = {
		8130026,
		0,
		Lang.get(43939),
		8130,
		26,
		113,
		{
			RTResTalkAction[56]
		}
	},
	[8130027] = {
		8130027,
		0,
		Lang.get(43940),
		8130,
		27,
		664,
		{
			RTResTalkAction[59]
		},
		1,
		0,
		nil,
		nil,
		24,
		8131,
		nil,
		1,
		nil,
		1,
		nil,
		8131
	},
	[8130028] = {
		8130028,
		0,
		Lang.get(32470),
		8130,
		28,
		112,
		nil,
		1,
		1
	},
	[8140001] = {
		8140001,
		0,
		Lang.get(43941),
		8140,
		1,
		107,
		nil,
		1,
		1,
		nil,
		nil,
		60,
		8140,
		1,
		1,
		nil,
		1,
		nil,
		8140
	},
	[8140002] = {
		8140002,
		0,
		Lang.get(43942),
		8140,
		2,
		151,
		nil,
		1,
		1
	},
	[8140003] = {
		8140003,
		0,
		Lang.get(32477),
		8140,
		3,
		133,
		nil,
		1,
		0
	},
	[8140004] = {
		8140004,
		2,
		Lang.get(43943),
		8140,
		4,
		664,
		nil,
		1,
		0
	},
	[8140005] = {
		8140005,
		0,
		Lang.get(43944),
		8140,
		5,
		141,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[8140006] = {
		8140006,
		5,
		Lang.get(43945),
		8140,
		6,
		113,
		{
			RTResTalkAction[60],
			RTResTalkAction[4]
		}
	},
	[8140007] = {
		8140007,
		0,
		Lang.get(43946),
		8140,
		7,
		113,
		{
			RTResTalkAction[55]
		}
	},
	[8140008] = {
		8140008,
		5,
		Lang.get(43947),
		8140,
		8,
		113,
		{
			RTResTalkAction[61]
		}
	},
	[8140009] = {
		8140009,
		0,
		Lang.get(43948),
		8140,
		9,
		113,
		{
			RTResTalkAction[58]
		}
	},
	[8140010] = {
		8140010,
		5,
		Lang.get(32483),
		8140,
		10,
		664,
		{
			RTResTalkAction[18],
			RTResTalkAction[59]
		}
	},
	[8140011] = {
		8140011,
		5,
		Lang.get(32484),
		8140,
		11,
		107,
		{
			RTResTalkAction[62],
			RTResTalkAction[63]
		}
	},
	[8140012] = {
		8140012,
		0,
		Lang.get(32485),
		8140,
		12,
		664,
		{
			RTResTalkAction[64],
			RTResTalkAction[5]
		}
	},
	[8140013] = {
		8140013,
		5,
		Lang.get(32487),
		8140,
		13,
		151,
		{
			RTResTalkAction[62],
			RTResTalkAction[65]
		}
	},
	[8140014] = {
		8140014,
		0,
		"……",
		8140,
		14,
		664,
		{
			RTResTalkAction[18],
			RTResTalkAction[7]
		}
	},
	[8140015] = {
		8140015,
		0,
		Lang.get(32490),
		8140,
		15,
		107,
		{
			RTResTalkAction[66],
			RTResTalkAction[20]
		}
	},
	[8140016] = {
		8140016,
		4,
		nil,
		8140,
		16,
		300,
		{
			RTResTalkAction[22]
		},
		[29] = {
			{
				id = 8140017,
				branch_content = Lang.get(42695)
			}
		}
	},
	[8140017] = {
		8140017,
		0,
		Lang.get(33046),
		8140,
		17,
		107,
		{
			RTResTalkAction[67]
		}
	},
	[8150001] = {
		8150001,
		0,
		Lang.get(32493),
		8150,
		1,
		664,
		{
			RTResTalkAction[18]
		},
		nil,
		nil,
		3,
		nil,
		60,
		8141,
		1,
		1,
		nil,
		1,
		nil,
		8140
	},
	[8150002] = {
		8150002,
		0,
		Lang.get(32494),
		8150,
		2,
		113,
		{
			RTResTalkAction[56],
			RTResTalkAction[20]
		}
	},
	[8150003] = {
		8150003,
		11,
		"HeroUltra/12004/video_12004_ultra_short.mp4",
		8150,
		3,
		113,
		{
			RTResTalkAction[59]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[8150004] = {
		8150004,
		5,
		Lang.get(33047),
		8150,
		4,
		151,
		{
			RTResTalkAction[23]
		}
	},
	[8150005] = {
		8150005,
		0,
		Lang.get(36238),
		8150,
		5,
		141,
		{
			RTResTalkAction[7]
		},
		1,
		0,
		nil,
		nil,
		nil,
		8142,
		1,
		1,
		nil,
		1,
		nil,
		8142
	},
	[8150006] = {
		8150006,
		0,
		Lang.get(32498),
		8150,
		6,
		300
	},
	[8150007] = {
		8150007,
		0,
		Lang.get(32499),
		8150,
		7,
		300
	},
	[8150008] = {
		8150008,
		0,
		Lang.get(36239),
		8150,
		8,
		107,
		{
			RTResTalkAction[68]
		},
		nil,
		nil,
		3
	},
	[8150009] = {
		8150009,
		0,
		Lang.get(43949),
		8150,
		9,
		133,
		{
			RTResTalkAction[69],
			RTResTalkAction[70]
		}
	},
	[8150010] = {
		8150010,
		0,
		Lang.get(32502),
		8150,
		10,
		141,
		{
			RTResTalkAction[71],
			RTResTalkAction[14],
			RTResTalkAction[72]
		}
	},
	[8150011] = {
		8150011,
		0,
		Lang.get(36241),
		8150,
		11,
		133,
		{
			RTResTalkAction[71],
			RTResTalkAction[14],
			RTResTalkAction[72]
		}
	},
	[8150012] = {
		8150012,
		0,
		Lang.get(36242),
		8150,
		12,
		362,
		{
			RTResTalkAction[73],
			RTResTalkAction[74],
			RTResTalkAction[5],
			RTResTalkAction[13],
			RTResTalkAction[4]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		nil,
		nil,
		1,
		[27] = 5,
		[20] = 220
	},
	[8150013] = {
		8150013,
		0,
		Lang.get(36243),
		8150,
		13,
		361,
		{
			RTResTalkAction[75],
			RTResTalkAction[74]
		},
		[27] = 3
	},
	[8150014] = {
		8150014,
		13,
		nil,
		8150,
		14,
		361,
		{
			RTResTalkAction[76],
			RTResTalkAction[77],
			RTResTalkAction[78]
		},
		[27] = 2
	},
	[8150015] = {
		8150015,
		13,
		Lang.get(41686),
		8150,
		15,
		360,
		{
			RTResTalkAction[79],
			RTResTalkAction[80]
		},
		[27] = 3
	},
	[8150016] = {
		8150016,
		13,
		Lang.get(36244),
		8150,
		16,
		360,
		{
			RTResTalkAction[79]
		},
		[27] = 3
	},
	[8150017] = {
		8150017,
		4,
		nil,
		8150,
		17,
		360,
		{
			RTResTalkAction[79]
		},
		[27] = 3,
		[29] = {
			{
				id = 8150018,
				branch_content = Lang.get(42696)
			}
		}
	},
	[8150018] = {
		8150018,
		13,
		Lang.get(40569),
		8150,
		18,
		360,
		{
			RTResTalkAction[79]
		},
		[27] = 4
	},
	[8150019] = {
		8150019,
		0,
		Lang.get(43951),
		8150,
		19,
		300,
		{
			RTResTalkAction[81]
		},
		[20] = -1
	},
	[8160001] = {
		8160001,
		11,
		"Videos/AVG_Story1_Kuihuazi.mp4",
		8160,
		1,
		300
	},
	[8160002] = {
		8160002,
		0,
		Lang.get(32514),
		8160,
		2,
		119,
		nil,
		1,
		3,
		nil,
		nil,
		62,
		8032,
		1,
		nil,
		nil,
		1,
		nil,
		8032
	},
	[8160003] = {
		8160003,
		0,
		Lang.get(32515),
		8160,
		3,
		143,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		8503
	},
	[8160004] = {
		8160004,
		0,
		Lang.get(32516),
		8160,
		4,
		119,
		nil,
		1,
		2
	},
	[8160005] = {
		8160005,
		0,
		Lang.get(32517),
		8160,
		5,
		143,
		nil,
		1,
		5
	},
	[8160006] = {
		8160006,
		5,
		Lang.get(32519),
		8160,
		6,
		119,
		nil,
		1,
		7
	},
	[8160007] = {
		8160007,
		0,
		Lang.get(43952),
		8160,
		7,
		107,
		nil,
		1,
		3,
		nil,
		nil,
		nil,
		8638,
		nil,
		nil,
		nil,
		1,
		nil,
		8638
	},
	[8160008] = {
		8160008,
		0,
		Lang.get(43953),
		8160,
		8,
		141,
		nil,
		1,
		0
	},
	[8160009] = {
		8160009,
		4,
		nil,
		8160,
		9,
		300,
		[29] = {
			{
				id = 8160010,
				branch_content = Lang.get(43954)
			}
		}
	},
	[8160010] = {
		8160010,
		5,
		Lang.get(36251),
		8160,
		10,
		138,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		8033,
		nil,
		1,
		nil,
		1,
		nil,
		8033
	},
	[8160011] = {
		8160011,
		5,
		Lang.get(32524),
		8160,
		11,
		141,
		{
			RTResTalkAction[82]
		},
		nil,
		nil,
		3
	},
	[8170001] = {
		8170001,
		0,
		Lang.get(32525),
		8170,
		1,
		151,
		nil,
		1,
		nil,
		nil,
		nil,
		24,
		8640,
		nil,
		nil,
		nil,
		1,
		nil,
		8640
	},
	[8170002] = {
		8170002,
		0,
		Lang.get(36252),
		8170,
		2,
		300,
		{
			RTResTalkAction[83]
		},
		nil,
		nil,
		3,
		[21] = 349
	},
	[8170003] = {
		8170003,
		4,
		nil,
		8170,
		3,
		300,
		{
			RTResTalkAction[83]
		},
		[21] = 349,
		[29] = {
			{
				id = 8170004,
				branch_content = Lang.get(43955)
			}
		}
	},
	[8170004] = {
		8170004,
		0,
		Lang.get(32528),
		8170,
		4,
		133,
		{
			RTResTalkAction[84]
		},
		1,
		1,
		nil,
		nil,
		nil,
		8034,
		nil,
		1,
		nil,
		1,
		nil,
		8034
	},
	[8170005] = {
		8170005,
		0,
		Lang.get(32529),
		8170,
		5,
		143,
		{
			RTResTalkAction[85]
		},
		nil,
		nil,
		3
	},
	[8170006] = {
		8170006,
		5,
		Lang.get(44484),
		8170,
		6,
		119,
		{
			RTResTalkAction[86],
			RTResTalkAction[87]
		}
	},
	[8170007] = {
		8170007,
		0,
		Lang.get(36255),
		8170,
		7,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[8170008] = {
		8170008,
		0,
		Lang.get(32533),
		8170,
		8,
		143,
		nil,
		1,
		5,
		nil,
		nil,
		nil,
		8642,
		nil,
		nil,
		nil,
		1,
		nil,
		8642
	},
	[8170009] = {
		8170009,
		0,
		Lang.get(32534),
		8170,
		9,
		119,
		nil,
		1,
		6
	},
	[8170010] = {
		8170010,
		0,
		Lang.get(43957),
		8170,
		10,
		300
	},
	[8170011] = {
		8170011,
		0,
		Lang.get(32536),
		8170,
		11,
		133,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		8645
	},
	[8170012] = {
		8170012,
		0,
		Lang.get(36258),
		8170,
		12,
		300
	},
	[8170013] = {
		8170013,
		4,
		nil,
		8170,
		13,
		300,
		[29] = {
			{
				id = 8170014,
				branch_content = Lang.get(42700)
			}
		}
	},
	[8170014] = {
		8170014,
		0,
		Lang.get(32539),
		8170,
		14,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[8170015] = {
		8170015,
		0,
		Lang.get(43958),
		8170,
		15,
		119,
		{
			RTResTalkAction[88]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[8170016] = {
		8170016,
		0,
		Lang.get(32541),
		8170,
		16,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[8170017] = {
		8170017,
		0,
		Lang.get(36261),
		8170,
		17,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[8170018] = {
		8170018,
		4,
		nil,
		8170,
		18,
		300,
		{
			RTResTalkAction[34]
		},
		[29] = {
			{
				id = 8170019,
				branch_content = Lang.get(42702)
			}
		}
	},
	[8170019] = {
		8170019,
		0,
		Lang.get(32546),
		8170,
		19,
		143,
		{
			RTResTalkAction[36]
		},
		1,
		2,
		-1,
		nil,
		nil,
		8643,
		nil,
		1,
		nil,
		1,
		nil,
		8643
	},
	[8170020] = {
		8170020,
		7,
		"14",
		8170,
		20,
		143,
		nil,
		nil,
		nil,
		3,
		nil,
		nil,
		8644,
		1,
		1,
		nil,
		1,
		nil,
		8642
	},
	[8170021] = {
		8170021,
		0,
		Lang.get(33061),
		8170,
		21,
		119,
		{
			RTResTalkAction[89]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		nil,
		1,
		1
	},
	[8170022] = {
		8170022,
		0,
		Lang.get(33062),
		8170,
		22,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[8170023] = {
		8170023,
		0,
		Lang.get(32549),
		8170,
		23,
		143,
		{
			RTResTalkAction[90],
			RTResTalkAction[36]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[8170024] = {
		8170024,
		12,
		"2",
		8170,
		24,
		143,
		{
			RTResTalkAction[87]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		nil,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		120
	},
	[8170025] = {
		8170025,
		5,
		Lang.get(56717),
		8170,
		25,
		119,
		{
			RTResTalkAction[91],
			RTResTalkAction[92]
		},
		nil,
		nil,
		-1
	},
	[8170026] = {
		8170026,
		12,
		"3",
		8170,
		26,
		119,
		{
			RTResTalkAction[87],
			RTResTalkAction[36]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		nil,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		120
	},
	[8170027] = {
		8170027,
		0,
		Lang.get(32551),
		8170,
		27,
		143,
		{
			RTResTalkAction[93],
			RTResTalkAction[32]
		}
	},
	[8170028] = {
		8170028,
		0,
		Lang.get(32552),
		8170,
		28,
		119,
		{
			RTResTalkAction[91],
			RTResTalkAction[94]
		}
	},
	[8170029] = {
		8170029,
		13,
		nil,
		8170,
		29,
		119,
		{
			RTResTalkAction[76],
			RTResTalkAction[87],
			RTResTalkAction[36]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		8142,
		1,
		1,
		nil,
		1,
		nil,
		8142,
		220,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		2
	},
	[8170030] = {
		8170030,
		13,
		Lang.get(43959),
		8170,
		30,
		360,
		{
			RTResTalkAction[79],
			RTResTalkAction[80]
		},
		[27] = 3
	},
	[8170031] = {
		8170031,
		13,
		Lang.get(36262),
		8170,
		31,
		360,
		{
			RTResTalkAction[79]
		},
		[27] = 3
	},
	[8180001] = {
		8180001,
		3,
		Lang.get(33067),
		8180,
		1,
		360,
		{
			RTResTalkAction[83]
		},
		nil,
		nil,
		nil,
		nil,
		24,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		255,
		349,
		1
	},
	[8180002] = {
		8180002,
		0,
		Lang.get(32556),
		8180,
		2,
		300,
		{
			RTResTalkAction[83]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		8180,
		[21] = 349
	},
	[8180003] = {
		8180003,
		4,
		nil,
		8180,
		3,
		300,
		{
			RTResTalkAction[83]
		},
		[21] = 349,
		[29] = {
			{
				id = 8180004,
				branch_content = Lang.get(42703)
			}
		}
	},
	[8180004] = {
		8180004,
		5,
		Lang.get(43960),
		8180,
		4,
		138,
		{
			RTResTalkAction[84]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		8037,
		3,
		1,
		nil,
		1,
		nil,
		8037,
		-1
	},
	[8180005] = {
		8180005,
		0,
		Lang.get(32559),
		8180,
		5,
		107,
		nil,
		1,
		10,
		nil,
		nil,
		nil,
		8109
	},
	[8180006] = {
		8180006,
		2,
		Lang.get(43961),
		8180,
		6,
		138,
		nil,
		1,
		0
	},
	[8180007] = {
		8180007,
		5,
		Lang.get(32561),
		8180,
		7,
		151,
		nil,
		1
	},
	[8180008] = {
		8180008,
		0,
		Lang.get(32562),
		8180,
		8,
		107,
		nil,
		1,
		8
	},
	[8180009] = {
		8180009,
		0,
		Lang.get(32563),
		8180,
		9,
		133,
		nil,
		1,
		0
	},
	[8180010] = {
		8180010,
		0,
		Lang.get(43962),
		8180,
		10,
		138,
		nil,
		1
	},
	[8180011] = {
		8180011,
		5,
		Lang.get(43963),
		8180,
		11,
		138,
		nil,
		1
	},
	[8180012] = {
		8180012,
		7,
		"10",
		8180,
		12,
		138,
		nil,
		nil,
		nil,
		4,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[8180013] = {
		8180013,
		0,
		Lang.get(36263),
		8180,
		13,
		138,
		nil,
		1,
		0,
		-1,
		nil,
		nil,
		8110,
		0.8
	},
	[8180014] = {
		8180014,
		5,
		Lang.get(32567),
		8180,
		14,
		151,
		nil,
		1
	},
	[8180015] = {
		8180015,
		0,
		Lang.get(32568),
		8180,
		15,
		138,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		8111
	},
	[8180016] = {
		8180016,
		4,
		nil,
		8180,
		16,
		138,
		nil,
		1,
		[29] = {
			{
				id = 8180017,
				branch_content = Lang.get(42704)
			}
		}
	},
	[8180017] = {
		8180017,
		0,
		nil,
		8180,
		17,
		138,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		8071,
		2,
		1,
		nil,
		1,
		nil,
		8071
	},
	[8190001] = {
		8190001,
		5,
		Lang.get(43964),
		8190,
		1,
		138,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		8072,
		1,
		1,
		nil,
		1,
		nil,
		8180
	},
	[8190002] = {
		8190002,
		0,
		Lang.get(43965),
		8190,
		2,
		138,
		nil,
		1
	},
	[8190003] = {
		8190003,
		0,
		Lang.get(43966),
		8190,
		3,
		107,
		nil,
		1,
		0
	},
	[8190004] = {
		8190004,
		0,
		Lang.get(43967),
		8190,
		4,
		141,
		nil,
		1
	},
	[8190005] = {
		8190005,
		0,
		Lang.get(36266),
		8190,
		5,
		151,
		nil,
		1,
		0
	},
	[8190006] = {
		8190006,
		0,
		Lang.get(36267),
		8190,
		6,
		113,
		{
			RTResTalkAction[56]
		},
		[20] = 255
	},
	[8190007] = {
		8190007,
		0,
		Lang.get(33074),
		8190,
		7,
		151,
		{
			RTResTalkAction[23],
			RTResTalkAction[59]
		},
		nil,
		nil,
		3,
		[20] = -1
	},
	[8190008] = {
		8190008,
		0,
		Lang.get(36268),
		8190,
		8,
		138,
		{
			RTResTalkAction[95],
			RTResTalkAction[7]
		}
	},
	[8190009] = {
		8190009,
		0,
		Lang.get(36269),
		8190,
		9,
		133,
		{
			RTResTalkAction[14],
			RTResTalkAction[96]
		}
	},
	[8190010] = {
		8190010,
		0,
		Lang.get(43968),
		8190,
		10,
		300,
		{
			RTResTalkAction[14]
		}
	},
	[8190011] = {
		8190011,
		4,
		nil,
		8190,
		11,
		300,
		{
			RTResTalkAction[97],
			RTResTalkAction[13]
		},
		[29] = {
			{
				id = 8190012,
				branch_content = Lang.get(42705)
			},
			{
				id = 8190012,
				branch_content = Lang.get(42706)
			}
		}
	},
	[8190012] = {
		8190012,
		0,
		Lang.get(32582),
		8190,
		12,
		141,
		{
			RTResTalkAction[1],
			RTResTalkAction[98]
		}
	},
	[8200001] = {
		8200001,
		0,
		Lang.get(43969),
		8200,
		1,
		133,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		8041,
		0.5,
		1,
		nil,
		nil,
		nil,
		8142
	},
	[8200002] = {
		8200002,
		0,
		Lang.get(43970),
		8200,
		2,
		133,
		nil,
		1
	},
	[8200003] = {
		8200003,
		0,
		Lang.get(32584),
		8200,
		3,
		151,
		nil,
		1
	},
	[8200004] = {
		8200004,
		0,
		Lang.get(32585),
		8200,
		4,
		141,
		nil,
		1
	},
	[8200005] = {
		8200005,
		4,
		nil,
		8200,
		5,
		300,
		nil,
		1,
		[29] = {
			{
				id = 8200006,
				branch_content = Lang.get(42707)
			}
		}
	},
	[8200006] = {
		8200006,
		0,
		Lang.get(32587),
		8200,
		6,
		141,
		nil,
		1
	},
	[8200007] = {
		8200007,
		0,
		Lang.get(32588),
		8200,
		7,
		138,
		nil,
		1
	},
	[8200008] = {
		8200008,
		0,
		Lang.get(33081),
		8200,
		8,
		151,
		nil,
		1
	},
	[8201001] = {
		8201001,
		2,
		Lang.get(33082),
		8201,
		1,
		138,
		nil,
		1,
		0,
		nil,
		nil,
		62,
		8143,
		nil,
		1,
		nil,
		1,
		nil,
		8143
	},
	[8201002] = {
		8201002,
		0,
		Lang.get(32593),
		8201,
		2,
		133,
		nil,
		1,
		0
	},
	[8201003] = {
		8201003,
		0,
		Lang.get(33083),
		8201,
		3,
		151,
		nil,
		1,
		0
	},
	[8201004] = {
		8201004,
		0,
		Lang.get(43971),
		8201,
		4,
		143,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		8070,
		nil,
		1,
		nil,
		1,
		nil,
		8070
	},
	[8201005] = {
		8201005,
		0,
		Lang.get(43972),
		8201,
		5,
		143,
		nil,
		1,
		0
	},
	[8201006] = {
		8201006,
		0,
		Lang.get(33085),
		8201,
		6,
		143,
		nil,
		1,
		0
	},
	[8201007] = {
		8201007,
		0,
		Lang.get(32598),
		8201,
		7,
		107,
		{
			RTResTalkAction[99]
		},
		nil,
		nil,
		3
	},
	[8201008] = {
		8201008,
		0,
		Lang.get(32599),
		8201,
		8,
		300,
		{
			RTResTalkAction[22]
		}
	},
	[8201009] = {
		8201009,
		0,
		Lang.get(36272),
		8201,
		9,
		670,
		{
			RTResTalkAction[5]
		},
		1,
		0,
		-1,
		nil,
		nil,
		8044,
		nil,
		1,
		nil,
		1,
		nil,
		8048
	},
	[8201010] = {
		8201010,
		0,
		Lang.get(32601),
		8201,
		10,
		143,
		{
			RTResTalkAction[100]
		},
		nil,
		nil,
		3
	},
	[8210001] = {
		8210001,
		0,
		Lang.get(32602),
		8210,
		1,
		670,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		8045,
		0.8,
		1,
		nil,
		1,
		nil,
		8044
	},
	[8210002] = {
		8210002,
		0,
		Lang.get(33087),
		8210,
		2,
		151,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[8210003] = {
		8210003,
		0,
		Lang.get(43973),
		8210,
		3,
		670,
		{
			RTResTalkAction[101],
			RTResTalkAction[7]
		}
	},
	[8210004] = {
		8210004,
		0,
		Lang.get(36273),
		8210,
		4,
		138,
		{
			RTResTalkAction[102]
		},
		1,
		nil,
		-1,
		nil,
		nil,
		8073,
		1,
		1,
		nil,
		1,
		nil,
		8645
	},
	[8210005] = {
		8210005,
		0,
		Lang.get(33091),
		8210,
		5,
		133,
		nil,
		1
	},
	[8210006] = {
		8210006,
		0,
		Lang.get(33092),
		8210,
		6,
		138,
		{
			RTResTalkAction[103],
			RTResTalkAction[70]
		},
		nil,
		nil,
		3
	},
	[8210007] = {
		8210007,
		0,
		Lang.get(43974),
		8210,
		7,
		138,
		{
			RTResTalkAction[103],
			RTResTalkAction[70]
		}
	},
	[8210008] = {
		8210008,
		5,
		Lang.get(43975),
		8210,
		8,
		107,
		{
			RTResTalkAction[103],
			RTResTalkAction[70]
		},
		1,
		5
	},
	[8210009] = {
		8210009,
		0,
		Lang.get(32611),
		8210,
		9,
		133,
		{
			RTResTalkAction[103],
			RTResTalkAction[104]
		}
	},
	[8210010] = {
		8210010,
		0,
		Lang.get(32612),
		8210,
		10,
		138,
		{
			RTResTalkAction[103],
			RTResTalkAction[70]
		}
	},
	[8210011] = {
		8210011,
		0,
		Lang.get(32613),
		8210,
		11,
		107,
		{
			RTResTalkAction[96],
			RTResTalkAction[13]
		},
		1,
		0,
		-1,
		nil,
		nil,
		8046,
		nil,
		1,
		nil,
		1,
		nil,
		8045
	},
	[8210012] = {
		8210012,
		0,
		Lang.get(32614),
		8210,
		12,
		53,
		nil,
		1,
		0
	},
	[8210013] = {
		8210013,
		0,
		Lang.get(32615),
		8210,
		13,
		300
	},
	[8210014] = {
		8210014,
		0,
		Lang.get(43976),
		8210,
		14,
		141,
		nil,
		1,
		0
	},
	[8210015] = {
		8210015,
		0,
		Lang.get(32617),
		8210,
		15,
		151,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[8210016] = {
		8210016,
		0,
		Lang.get(43977),
		8210,
		16,
		670,
		{
			RTResTalkAction[105],
			RTResTalkAction[7]
		}
	},
	[8210017] = {
		8210017,
		3,
		Lang.get(32619),
		8210,
		17,
		670,
		{
			RTResTalkAction[106],
			RTResTalkAction[22],
			RTResTalkAction[107],
			RTResTalkAction[102]
		},
		[22] = 1
	},
	[8210018] = {
		8210018,
		0,
		Lang.get(32620),
		8210,
		18,
		138,
		{
			RTResTalkAction[106],
			RTResTalkAction[22],
			RTResTalkAction[107]
		},
		1
	},
	[8210019] = {
		8210019,
		0,
		Lang.get(43978),
		8210,
		19,
		107,
		{
			RTResTalkAction[7],
			RTResTalkAction[5],
			RTResTalkAction[13]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		8701,
		nil,
		1,
		nil,
		1,
		nil,
		8701
	},
	[8210020] = {
		8210020,
		0,
		Lang.get(22255),
		8210,
		20,
		3,
		nil,
		1,
		nil,
		nil,
		nil,
		24,
		8702,
		nil,
		nil,
		nil,
		1,
		1070,
		8702
	},
	[8210021] = {
		8210021,
		2,
		Lang.get(33097),
		8210,
		21,
		138,
		nil,
		1,
		[19] = 8798,
		[17] = 1
	},
	[8210022] = {
		8210022,
		2,
		Lang.get(33098),
		8210,
		22,
		138,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[8210023] = {
		8210023,
		2,
		Lang.get(33099),
		8210,
		23,
		138,
		nil,
		1,
		1
	},
	[8210024] = {
		8210024,
		5,
		Lang.get(32627),
		8210,
		24,
		138,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		8705,
		[19] = 8705,
		[17] = 1
	},
	[8210025] = {
		8210025,
		3,
		Lang.get(32628),
		8210,
		25,
		138,
		[18] = 1070,
		[22] = 1
	},
	[8210026] = {
		8210026,
		5,
		Lang.get(43979),
		8210,
		26,
		151,
		{
			RTResTalkAction[108]
		},
		nil,
		nil,
		3
	},
	[8220001] = {
		8220001,
		0,
		Lang.get(32630),
		8220,
		1,
		107,
		nil,
		1,
		3,
		nil,
		nil,
		62,
		8063,
		1,
		1,
		nil,
		1,
		nil,
		8063
	},
	[8220002] = {
		8220002,
		0,
		Lang.get(32631),
		8220,
		2,
		151,
		nil,
		1,
		0
	},
	[8220003] = {
		8220003,
		0,
		Lang.get(32632),
		8220,
		3,
		107,
		nil,
		1,
		3
	},
	[8220004] = {
		8220004,
		0,
		Lang.get(32633),
		8220,
		4,
		151,
		nil,
		1,
		0
	},
	[8220005] = {
		8220005,
		0,
		Lang.get(32635),
		8220,
		5,
		107,
		nil,
		1,
		6,
		nil,
		nil,
		nil,
		8064,
		1,
		1,
		nil,
		1,
		nil,
		8064
	},
	[8230001] = {
		8230001,
		3,
		Lang.get(33101),
		8230,
		1,
		107,
		nil,
		nil,
		nil,
		nil,
		nil,
		23,
		nil,
		nil,
		nil,
		nil,
		1,
		nil,
		8632,
		nil,
		nil,
		1
	},
	[8230002] = {
		8230002,
		0,
		Lang.get(36275),
		8230,
		2,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		2,
		1,
		[19] = 8023,
		[17] = 1
	},
	[8230003] = {
		8230003,
		4,
		nil,
		8230,
		3,
		300,
		[29] = {
			{
				id = 8230004,
				branch_content = Lang.get(42708)
			},
			{
				id = 8230006,
				branch_content = Lang.get(42709)
			},
			{
				id = 8230009,
				branch_content = Lang.get(42710)
			}
		}
	},
	[8230004] = {
		8230004,
		0,
		Lang.get(43980),
		8230,
		4,
		300
	},
	[8230005] = {
		8230005,
		4,
		nil,
		8230,
		5,
		300,
		[29] = {
			{
				id = 8230003,
				branch_content = Lang.get(42570)
			}
		}
	},
	[8230006] = {
		8230006,
		3,
		Lang.get(32640),
		8230,
		6,
		300,
		[22] = 1
	},
	[8230007] = {
		8230007,
		3,
		Lang.get(33106),
		8230,
		7,
		300,
		[22] = 1
	},
	[8230008] = {
		8230008,
		4,
		nil,
		8230,
		8,
		300,
		[29] = {
			{
				id = 8230003,
				branch_content = Lang.get(42570)
			}
		}
	},
	[8230009] = {
		8230009,
		0,
		Lang.get(33108),
		8230,
		9,
		300
	},
	[8230010] = {
		8230010,
		0,
		Lang.get(32643),
		8230,
		10,
		133,
		nil,
		1,
		nil,
		nil,
		nil,
		32,
		8646,
		1,
		1,
		nil,
		1,
		nil,
		8644
	},
	[8230011] = {
		8230011,
		0,
		Lang.get(32644),
		8230,
		11,
		300
	},
	[8230012] = {
		8230012,
		0,
		Lang.get(43981),
		8230,
		12,
		133,
		nil,
		1
	},
	[8230013] = {
		8230013,
		0,
		Lang.get(43982),
		8230,
		13,
		300,
		{
			RTResTalkAction[109]
		},
		nil,
		nil,
		3
	},
	[8230014] = {
		8230014,
		0,
		Lang.get(32648),
		8230,
		14,
		133,
		{
			RTResTalkAction[14]
		}
	},
	[8230015] = {
		8230015,
		0,
		Lang.get(43983),
		8230,
		15,
		300,
		{
			RTResTalkAction[110]
		}
	},
	[8230016] = {
		8230016,
		0,
		Lang.get(36278),
		8230,
		16,
		300,
		{
			RTResTalkAction[14]
		}
	},
	[8230017] = {
		8230017,
		0,
		Lang.get(32652),
		8230,
		17,
		300,
		{
			RTResTalkAction[14]
		}
	},
	[8230018] = {
		8230018,
		4,
		nil,
		8230,
		18,
		300,
		{
			RTResTalkAction[14]
		},
		[29] = {
			{
				id = 8230019,
				branch_content = Lang.get(42712)
			},
			{
				id = 8230019,
				branch_content = Lang.get(42713)
			},
			{
				id = 8230021,
				branch_content = Lang.get(42714)
			}
		}
	},
	[8230019] = {
		8230019,
		0,
		Lang.get(33115),
		8230,
		19,
		300,
		{
			RTResTalkAction[14]
		}
	},
	[8230020] = {
		8230020,
		4,
		nil,
		8230,
		20,
		300,
		{
			RTResTalkAction[14]
		},
		[29] = {
			{
				id = 8230018,
				branch_content = Lang.get(42715)
			}
		}
	},
	[8230021] = {
		8230021,
		0,
		Lang.get(32655),
		8230,
		21,
		300,
		{
			RTResTalkAction[14]
		}
	},
	[8230022] = {
		8230022,
		0,
		Lang.get(33117),
		8230,
		22,
		133,
		{
			RTResTalkAction[28]
		}
	},
	[8230023] = {
		8230023,
		0,
		Lang.get(33118),
		8230,
		23,
		300,
		{
			RTResTalkAction[14]
		}
	},
	[8230024] = {
		8230024,
		0,
		Lang.get(32658),
		8230,
		24,
		133,
		{
			RTResTalkAction[111]
		}
	},
	[8230025] = {
		8230025,
		0,
		Lang.get(33119),
		8230,
		25,
		300,
		{
			RTResTalkAction[14]
		}
	},
	[8230026] = {
		8230026,
		0,
		Lang.get(43984),
		8230,
		26,
		300,
		{
			RTResTalkAction[14]
		}
	},
	[8230027] = {
		8230027,
		0,
		Lang.get(33120),
		8230,
		27,
		133,
		{
			RTResTalkAction[42]
		}
	},
	[8230028] = {
		8230028,
		0,
		Lang.get(32663),
		8230,
		28,
		300,
		{
			RTResTalkAction[14]
		}
	},
	[8230029] = {
		8230029,
		0,
		Lang.get(46265),
		8230,
		29,
		133,
		{
			RTResTalkAction[42]
		}
	},
	[8230030] = {
		8230030,
		3,
		Lang.get(33121),
		8230,
		30,
		133,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		8142,
		0.5,
		1,
		nil,
		1,
		nil,
		8142,
		nil,
		nil,
		1
	},
	[8230031] = {
		8230031,
		0,
		Lang.get(32664),
		8230,
		31,
		107,
		nil,
		1,
		0
	},
	[8230032] = {
		8230032,
		0,
		Lang.get(32665),
		8230,
		32,
		300
	},
	[8240001] = {
		8240001,
		0,
		Lang.get(33122),
		8240,
		1,
		107,
		nil,
		1,
		5,
		nil,
		nil,
		62,
		8240,
		0.5,
		1,
		nil,
		1,
		nil,
		8240
	},
	[8240002] = {
		8240002,
		0,
		Lang.get(33123),
		8240,
		2,
		133,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		8241,
		0.5,
		1,
		nil,
		1,
		nil,
		8241
	},
	[8240003] = {
		8240003,
		0,
		Lang.get(33124),
		8240,
		3,
		107,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		8242,
		0.5,
		1,
		nil,
		1,
		nil,
		8242
	},
	[8240004] = {
		8240004,
		0,
		Lang.get(44485),
		8240,
		4,
		668,
		nil,
		1,
		0
	},
	[8240005] = {
		8240005,
		0,
		Lang.get(33126),
		8240,
		5,
		107,
		nil,
		1,
		0
	},
	[8240006] = {
		8240006,
		0,
		Lang.get(32673),
		8240,
		6,
		347,
		nil,
		1,
		nil,
		nil,
		nil,
		57,
		8108,
		1,
		1,
		nil,
		1,
		nil,
		8108
	},
	[8240007] = {
		8240007,
		0,
		Lang.get(32674),
		8240,
		7,
		113,
		{
			RTResTalkAction[58]
		},
		nil,
		nil,
		3
	},
	[8240008] = {
		8240008,
		0,
		Lang.get(33127),
		8240,
		8,
		347,
		{
			RTResTalkAction[56]
		},
		1
	},
	[8240009] = {
		8240009,
		0,
		Lang.get(32676),
		8240,
		9,
		113,
		{
			RTResTalkAction[56]
		}
	},
	[8240010] = {
		8240010,
		0,
		Lang.get(32677),
		8240,
		10,
		347,
		{
			RTResTalkAction[56]
		},
		1
	},
	[8240011] = {
		8240011,
		5,
		Lang.get(33128),
		8240,
		11,
		113,
		{
			RTResTalkAction[56]
		}
	},
	[8240012] = {
		8240012,
		0,
		Lang.get(32679),
		8240,
		12,
		347,
		{
			RTResTalkAction[58]
		},
		1
	},
	[8240013] = {
		8240013,
		0,
		Lang.get(32680),
		8240,
		13,
		664,
		{
			RTResTalkAction[18],
			RTResTalkAction[59]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		0.5,
		1,
		[20] = 255,
		[17] = 1
	},
	[8240014] = {
		8240014,
		0,
		Lang.get(32377),
		8240,
		14,
		664,
		{
			RTResTalkAction[18]
		}
	},
	[8240015] = {
		8240015,
		5,
		Lang.get(32681),
		8240,
		15,
		664,
		{
			RTResTalkAction[19]
		}
	},
	[8250001] = {
		8250001,
		0,
		Lang.get(32686),
		8250,
		1,
		141,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		8058,
		1,
		1,
		nil,
		1,
		nil,
		8058,
		-1
	},
	[8250002] = {
		8250002,
		0,
		Lang.get(32687),
		8250,
		2,
		300
	},
	[8250003] = {
		8250003,
		0,
		Lang.get(32688),
		8250,
		3,
		141,
		{
			RTResTalkAction[112]
		},
		nil,
		nil,
		3
	},
	[8250004] = {
		8250004,
		0,
		Lang.get(32689),
		8250,
		4,
		107,
		{
			RTResTalkAction[113],
			RTResTalkAction[4]
		}
	},
	[8250005] = {
		8250005,
		5,
		Lang.get(32690),
		8250,
		5,
		663,
		{
			RTResTalkAction[69],
			RTResTalkAction[114]
		}
	},
	[8250006] = {
		8250006,
		0,
		Lang.get(32691),
		8250,
		6,
		107,
		{
			RTResTalkAction[22],
			RTResTalkAction[115]
		}
	},
	[8250007] = {
		8250007,
		0,
		Lang.get(32692),
		8250,
		7,
		107,
		{
			RTResTalkAction[22]
		}
	},
	[8250008] = {
		8250008,
		0,
		Lang.get(43985),
		8250,
		8,
		107,
		{
			RTResTalkAction[116]
		},
		nil,
		nil,
		3
	},
	[8250009] = {
		8250009,
		0,
		Lang.get(43986),
		8250,
		9,
		663,
		{
			RTResTalkAction[69],
			RTResTalkAction[114]
		}
	},
	[8250010] = {
		8250010,
		0,
		Lang.get(32697),
		8250,
		10,
		667,
		{
			RTResTalkAction[15],
			RTResTalkAction[5],
			RTResTalkAction[115]
		}
	},
	[8250011] = {
		8250011,
		0,
		Lang.get(32698),
		8250,
		11,
		107,
		{
			RTResTalkAction[117],
			RTResTalkAction[16]
		}
	},
	[8250012] = {
		8250012,
		4,
		nil,
		8250,
		12,
		300,
		{
			RTResTalkAction[22]
		},
		[29] = {
			{
				id = 8250013,
				branch_content = Lang.get(42716)
			}
		}
	},
	[8250013] = {
		8250013,
		0,
		Lang.get(32701),
		8250,
		13,
		667,
		{
			RTResTalkAction[5]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		8059,
		1,
		1,
		nil,
		1,
		nil,
		8059
	},
	[8250014] = {
		8250014,
		0,
		Lang.get(32702),
		8250,
		14,
		663,
		nil,
		1
	},
	[8250015] = {
		8250015,
		0,
		Lang.get(43987),
		8250,
		15,
		662,
		nil,
		1,
		0
	},
	[8250016] = {
		8250016,
		0,
		Lang.get(43988),
		8250,
		16,
		662,
		{
			RTResTalkAction[118]
		},
		nil,
		nil,
		3
	},
	[8250017] = {
		8250017,
		0,
		Lang.get(32704),
		8250,
		17,
		300,
		{
			RTResTalkAction[118]
		}
	},
	[8250018] = {
		8250018,
		0,
		Lang.get(32707),
		8250,
		18,
		107,
		{
			RTResTalkAction[66],
			RTResTalkAction[12]
		}
	},
	[8250019] = {
		8250019,
		0,
		Lang.get(43989),
		8250,
		19,
		300,
		{
			RTResTalkAction[119]
		},
		1,
		0
	},
	[8270001] = {
		8270001,
		11,
		"Videos/AVG_Story1_Qichuang.mp4",
		8270,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		1
	},
	[8270002] = {
		8270002,
		0,
		Lang.get(33138),
		8270,
		2,
		107,
		nil,
		1,
		6,
		nil,
		nil,
		60,
		8300,
		1,
		1,
		nil,
		1,
		nil,
		8300
	},
	[8270003] = {
		8270003,
		0,
		Lang.get(32720),
		8270,
		3,
		300,
		{
			RTResTalkAction[120]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		8301,
		1,
		1,
		nil,
		nil,
		nil,
		8301,
		nil,
		144
	},
	[8270004] = {
		8270004,
		0,
		Lang.get(32724),
		8270,
		4,
		151,
		{
			RTResTalkAction[23],
			RTResTalkAction[121]
		},
		nil,
		nil,
		3
	},
	[8270005] = {
		8270005,
		0,
		Lang.get(32725),
		8270,
		5,
		663,
		{
			RTResTalkAction[122],
			RTResTalkAction[123]
		}
	},
	[8270006] = {
		8270006,
		0,
		Lang.get(32726),
		8270,
		6,
		151,
		{
			RTResTalkAction[122],
			RTResTalkAction[114]
		}
	},
	[8270007] = {
		8270007,
		0,
		Lang.get(32727),
		8270,
		7,
		663,
		{
			RTResTalkAction[122],
			RTResTalkAction[124]
		}
	},
	[8270008] = {
		8270008,
		5,
		Lang.get(33140),
		8270,
		8,
		151,
		{
			RTResTalkAction[125],
			RTResTalkAction[114]
		}
	},
	[8270009] = {
		8270009,
		0,
		Lang.get(33141),
		8270,
		9,
		107,
		{
			RTResTalkAction[126],
			RTResTalkAction[7],
			RTResTalkAction[115]
		}
	},
	[8270010] = {
		8270010,
		5,
		Lang.get(33143),
		8270,
		10,
		669,
		{
			RTResTalkAction[22]
		}
	},
	[8270011] = {
		8270011,
		4,
		nil,
		8270,
		11,
		300,
		{
			RTResTalkAction[22]
		},
		[29] = {
			{
				id = 8270012,
				branch_content = Lang.get(42718)
			}
		}
	},
	[8270012] = {
		8270012,
		0,
		Lang.get(32730),
		8270,
		12,
		119,
		{
			RTResTalkAction[5]
		},
		1,
		3,
		nil,
		nil,
		nil,
		8302,
		0.8,
		1,
		nil,
		1,
		nil,
		8302
	},
	[8270013] = {
		8270013,
		0,
		Lang.get(32732),
		8270,
		13,
		662,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		8303,
		nil,
		nil,
		nil,
		nil,
		nil,
		8303
	},
	[8270014] = {
		8270014,
		0,
		Lang.get(32733),
		8270,
		14,
		141,
		nil,
		1
	},
	[8270015] = {
		8270015,
		0,
		Lang.get(33145),
		8270,
		15,
		662,
		nil,
		1
	},
	[8270016] = {
		8270016,
		0,
		Lang.get(32736),
		8270,
		16,
		119,
		nil,
		1,
		3,
		nil,
		nil,
		nil,
		8304,
		nil,
		nil,
		nil,
		1,
		nil,
		8304
	},
	[8270017] = {
		8270017,
		0,
		Lang.get(32737),
		8270,
		17,
		133,
		nil,
		1,
		0
	},
	[8270018] = {
		8270018,
		0,
		Lang.get(32738),
		8270,
		18,
		143,
		nil,
		1,
		0
	},
	[8270019] = {
		8270019,
		0,
		Lang.get(32739),
		8270,
		19,
		119,
		nil,
		1,
		5,
		nil,
		nil,
		nil,
		8275
	},
	[8270020] = {
		8270020,
		0,
		Lang.get(32740),
		8270,
		20,
		107,
		nil,
		1,
		5
	},
	[8270021] = {
		8270021,
		0,
		Lang.get(33146),
		8270,
		21,
		119,
		nil,
		1,
		5,
		nil,
		nil,
		nil,
		8275
	},
	[8270022] = {
		8270022,
		0,
		Lang.get(33147),
		8270,
		22,
		107,
		nil,
		1,
		5
	},
	[8270023] = {
		8270023,
		0,
		Lang.get(43990),
		8270,
		23,
		133,
		nil,
		1,
		0
	},
	[8270024] = {
		8270024,
		0,
		Lang.get(43991),
		8270,
		24,
		151,
		nil,
		1,
		0,
		-1,
		nil,
		nil,
		8142,
		1,
		1,
		nil,
		1,
		nil,
		8142,
		220
	},
	[8270025] = {
		8270025,
		13,
		nil,
		8270,
		25,
		151,
		{
			RTResTalkAction[76]
		},
		nil,
		nil,
		nil,
		nil,
		62,
		[27] = 2
	},
	[8270026] = {
		8270026,
		13,
		Lang.get(33152),
		8270,
		26,
		360,
		{
			RTResTalkAction[79],
			RTResTalkAction[80]
		},
		[27] = 3
	},
	[8270027] = {
		8270027,
		13,
		Lang.get(32750),
		8270,
		27,
		360,
		{
			RTResTalkAction[79]
		},
		[27] = 3
	},
	[8270028] = {
		8270028,
		0,
		Lang.get(32751),
		8270,
		28,
		133,
		{
			RTResTalkAction[81]
		},
		1,
		1,
		[20] = -1
	},
	[8270029] = {
		8270029,
		0,
		Lang.get(36280),
		8270,
		29,
		300
	},
	[8270030] = {
		8270030,
		0,
		Lang.get(32753),
		8270,
		30,
		133,
		nil,
		1,
		0
	},
	[8270031] = {
		8270031,
		0,
		Lang.get(32754),
		8270,
		31,
		107,
		nil,
		1,
		5
	},
	[8270032] = {
		8270032,
		3,
		Lang.get(32755),
		8270,
		32,
		107,
		nil,
		nil,
		nil,
		3,
		[22] = 1
	},
	[8270033] = {
		8270033,
		3,
		Lang.get(36281),
		8270,
		33,
		107,
		[22] = 1
	}
}
local metaTableResTalkAction = {
	__index = function(table, key)
		local keyIndexRT = indexMapResTalkAction[key]

		if not keyIndexRT then
			return nil
		end

		return table[keyIndexRT]
	end
}

for k, v in pairs(RTResTalkAction) do
	setmetatable(v, metaTableResTalkAction)
end

local metaTable = {
	__index = function(table, key)
		local keyIndex = indexMap[key]

		if not keyIndex then
			return nil
		end

		return table[keyIndex]
	end
}

for k, v in pairs(Data) do
	setmetatable(v, metaTable)
end

return Data
