-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\qiluo\\ResTalk.lua

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
	[2] = 107
}
RTResTalkAction[2] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[3] = {
	1,
	107,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[4] = {
	1,
	107,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[5] = {
	1,
	107,
	nil,
	nil,
	4
}
RTResTalkAction[6] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[7] = {
	[1] = 3,
	[2] = 158
}
RTResTalkAction[8] = {
	1,
	107,
	nil,
	nil,
	5
}
RTResTalkAction[9] = {
	[1] = 0,
	[2] = 158
}
RTResTalkAction[10] = {
	1,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[11] = {
	1,
	107,
	{
		1
	},
	nil,
	10
}
RTResTalkAction[12] = {
	1,
	107,
	nil,
	nil,
	1
}
RTResTalkAction[13] = {
	[1] = 1,
	[2] = 158
}
RTResTalkAction[14] = {
	1,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[15] = {
	1,
	107,
	nil,
	nil,
	10
}
RTResTalkAction[16] = {
	[1] = 1,
	[2] = 158,
	[3] = {
		1
	}
}
RTResTalkAction[17] = {
	[1] = 3,
	[2] = 133
}
RTResTalkAction[18] = {
	[1] = 0,
	[2] = 133
}
RTResTalkAction[19] = {
	[1] = 1,
	[2] = 141
}
RTResTalkAction[20] = {
	2,
	141,
	nil,
	nil,
	2
}
RTResTalkAction[21] = {
	1,
	1069,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[22] = {
	[1] = 1,
	[2] = 133,
	[3] = {
		2
	}
}
RTResTalkAction[23] = {
	[1] = 0,
	[2] = 1069
}
RTResTalkAction[24] = {
	2,
	107,
	nil,
	nil,
	3
}
RTResTalkAction[25] = {
	[1] = 3,
	[2] = 141
}
RTResTalkAction[26] = {
	[1] = 1,
	[2] = 1074
}
RTResTalkAction[27] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[28] = {
	[1] = 0,
	[2] = 1074
}
RTResTalkAction[29] = {
	[1] = 1,
	[2] = 1069
}
RTResTalkAction[30] = {
	[1] = 1,
	[2] = 133
}
RTResTalkAction[31] = {
	[1] = 2,
	[2] = 133
}
RTResTalkAction[32] = {
	[1] = 3,
	[2] = 107
}
RTResTalkAction[33] = {
	1,
	387,
	nil,
	nil,
	1
}
RTResTalkAction[34] = {
	1,
	387,
	nil,
	nil,
	5
}
RTResTalkAction[35] = {
	1,
	133,
	nil,
	nil,
	1
}
RTResTalkAction[36] = {
	[1] = 0,
	[2] = 387
}
RTResTalkAction[37] = {
	1,
	1069,
	nil,
	nil,
	1
}
RTResTalkAction[38] = {
	[1] = 1,
	[2] = 387
}
RTResTalkAction[39] = {
	1,
	158,
	nil,
	nil,
	4
}
RTResTalkAction[40] = {
	1,
	158,
	nil,
	nil,
	1
}
RTResTalkAction[41] = {
	1,
	158,
	nil,
	nil,
	2
}
RTResTalkAction[42] = {
	1,
	141,
	nil,
	nil,
	3
}
RTResTalkAction[43] = {
	1,
	141,
	nil,
	nil,
	2
}
RTResTalkAction[44] = {
	1,
	158,
	nil,
	nil,
	5
}
RTResTalkAction[45] = {
	[1] = 1,
	[2] = 765
}
RTResTalkAction[46] = {
	[1] = 0,
	[2] = 765
}
RTResTalkAction[47] = {
	[1] = 1,
	[2] = 765,
	[3] = {
		1
	}
}
RTResTalkAction[48] = {
	1,
	159,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[49] = {
	[1] = 0,
	[2] = 159
}
RTResTalkAction[50] = {
	[1] = 1,
	[2] = 1023
}
RTResTalkAction[51] = {
	[1] = 1,
	[2] = 1047
}
RTResTalkAction[52] = {
	[1] = 0,
	[2] = 1023
}
RTResTalkAction[53] = {
	[1] = 2,
	[2] = 1023
}
RTResTalkAction[54] = {
	[1] = 3,
	[2] = 1047
}
RTResTalkAction[55] = {
	[1] = 2,
	[2] = 1047
}
RTResTalkAction[56] = {
	[1] = 3,
	[2] = 1023
}
RTResTalkAction[57] = {
	[1] = 1,
	[2] = 1047,
	[3] = {
		1
	}
}
RTResTalkAction[58] = {
	[1] = 1,
	[2] = 1015,
	[3] = {
		1
	}
}
RTResTalkAction[59] = {
	[1] = 1,
	[2] = 1015,
	[3] = {
		2
	}
}
RTResTalkAction[60] = {
	[1] = 1,
	[2] = 1069,
	[3] = {
		1
	}
}
RTResTalkAction[61] = {
	[1] = 0,
	[2] = 1015
}
RTResTalkAction[62] = {
	[1] = 1,
	[2] = 1009,
	[3] = {
		1
	}
}
RTResTalkAction[63] = {
	[1] = 0,
	[2] = 1009
}
RTResTalkAction[64] = {
	[1] = 1,
	[2] = 273
}
RTResTalkAction[65] = {
	[1] = 0,
	[2] = 273
}
RTResTalkAction[66] = {
	[1] = 1,
	[2] = 1009
}
RTResTalkAction[67] = {
	2,
	1069,
	nil,
	nil,
	2
}
RTResTalkAction[68] = {
	2,
	1069,
	nil,
	nil,
	1
}
RTResTalkAction[69] = {
	[1] = 1,
	[2] = 237
}
RTResTalkAction[70] = {
	[1] = 0,
	[2] = 237
}
RTResTalkAction[71] = {
	[1] = 1,
	[2] = 1010
}
RTResTalkAction[72] = {
	[1] = 0,
	[2] = 1010
}
RTResTalkAction[73] = {
	1,
	1069,
	nil,
	nil,
	2
}
RTResTalkAction[74] = {
	1,
	107,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[75] = {
	[1] = 2,
	[2] = 1069
}
RTResTalkAction[76] = {
	[1] = 3,
	[2] = 387
}
RTResTalkAction[77] = {
	[1] = 1,
	[2] = 284
}
RTResTalkAction[78] = {
	[1] = 1,
	[2] = 282
}
RTResTalkAction[79] = {
	[1] = 0,
	[2] = 284
}
RTResTalkAction[80] = {
	[1] = 0,
	[2] = 282
}
RTResTalkAction[81] = {
	[1] = 1,
	[2] = 387,
	[3] = {
		1
	}
}
RTResTalkAction[82] = {
	[1] = 1,
	[2] = 1069,
	[3] = {
		2
	}
}
RTResTalkAction[83] = {
	[1] = 1,
	[2] = 133,
	[3] = {
		1
	}
}
RTResTalkAction[84] = {
	[1] = 1,
	[2] = 278
}
RTResTalkAction[85] = {
	[1] = 0,
	[2] = 278
}
RTResTalkAction[86] = {
	[1] = 1,
	[2] = 278,
	[3] = {
		1
	}
}
RTResTalkAction[87] = {
	[1] = 2,
	[2] = 278,
	[3] = {
		2
	}
}
RTResTalkAction[88] = {
	[1] = 1,
	[2] = 278,
	[3] = {
		3
	}
}
RTResTalkAction[89] = {
	1,
	1069,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[90] = {
	2,
	141,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[91] = {
	4,
	141,
	nil,
	nil,
	2
}
RTResTalkAction[92] = {
	[1] = 5,
	[2] = 133
}
RTResTalkAction[93] = {
	1,
	133,
	nil,
	nil,
	2
}
RTResTalkAction[94] = {
	[1] = 1,
	[2] = 1071
}
RTResTalkAction[95] = {
	[1] = 2,
	[2] = 1071
}
RTResTalkAction[96] = {
	[1] = 3,
	[2] = 1069
}
RTResTalkAction[97] = {
	[1] = 0,
	[2] = 1071
}
RTResTalkAction[98] = {
	[1] = 1,
	[2] = 1071,
	[3] = {
		2
	}
}
RTResTalkAction[99] = {
	1,
	1071,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[100] = {
	1,
	1071,
	nil,
	nil,
	1
}
RTResTalkAction[101] = {
	[1] = 1,
	[2] = 1080
}
RTResTalkAction[102] = {
	[1] = 2,
	[2] = 1080
}
RTResTalkAction[103] = {
	[1] = 3,
	[2] = 1081
}
RTResTalkAction[104] = {
	[1] = 0,
	[2] = 1081
}
RTResTalkAction[105] = {
	[1] = 0,
	[2] = 1080
}
RTResTalkAction[106] = {
	1,
	188,
	nil,
	nil,
	3
}
RTResTalkAction[107] = {
	[1] = 0,
	[2] = 188
}
RTResTalkAction[108] = {
	[1] = 1,
	[2] = 152
}
RTResTalkAction[109] = {
	1,
	188,
	nil,
	nil,
	2
}
RTResTalkAction[110] = {
	[1] = 0,
	[2] = 152
}
RTResTalkAction[111] = {
	1,
	769,
	nil,
	nil,
	1
}
RTResTalkAction[112] = {
	[1] = 0,
	[2] = 769
}
RTResTalkAction[113] = {
	1,
	152,
	nil,
	nil,
	1
}
RTResTalkAction[114] = {
	1,
	769,
	nil,
	nil,
	2
}
RTResTalkAction[115] = {
	1,
	769,
	nil,
	nil,
	7
}
RTResTalkAction[116] = {
	[1] = 2,
	[2] = 152
}
RTResTalkAction[117] = {
	[1] = 3,
	[2] = 769
}
RTResTalkAction[118] = {
	1,
	769,
	nil,
	nil,
	4
}
RTResTalkAction[119] = {
	1,
	769,
	nil,
	nil,
	5
}
RTResTalkAction[120] = {
	1,
	133,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[121] = {
	1,
	387,
	nil,
	nil,
	3
}
RTResTalkAction[122] = {
	1,
	387,
	nil,
	nil,
	4
}
RTResTalkAction[123] = {
	1,
	107,
	nil,
	nil,
	7
}
RTResTalkAction[124] = {
	1,
	107,
	{
		1
	},
	nil,
	9
}
RTResTalkAction[125] = {
	3,
	1069,
	nil,
	nil,
	2
}
RTResTalkAction[126] = {
	[1] = 1,
	[2] = 769
}
RTResTalkAction[127] = {
	[1] = 1,
	[2] = 188
}
RTResTalkAction[128] = {
	1,
	188,
	{
		1
	},
	nil,
	3
}
RTResTalkAction[129] = {
	1,
	769,
	nil,
	nil,
	3
}
RTResTalkAction[130] = {
	1,
	188,
	nil,
	nil,
	4
}
RTResTalkAction[131] = {
	2,
	769,
	nil,
	nil,
	1
}
RTResTalkAction[132] = {
	3,
	188,
	nil,
	nil,
	3
}
RTResTalkAction[133] = {
	1,
	141,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[134] = {
	1,
	1069,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[135] = {
	2,
	107,
	nil,
	nil,
	10
}
RTResTalkAction[136] = {
	1,
	141,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[137] = {
	[1] = 2,
	[2] = 141
}
RTResTalkAction[138] = {
	1,
	188,
	{
		1
	},
	nil,
	4
}
RTResTalkAction[139] = {
	[1] = 1,
	[2] = 1078
}
RTResTalkAction[140] = {
	[1] = 1,
	[2] = 1082
}
RTResTalkAction[141] = {
	[1] = 0,
	[2] = 1078
}
RTResTalkAction[142] = {
	[1] = 0,
	[2] = 1082
}
RTResTalkAction[143] = {
	1,
	632,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[144] = {
	[1] = 0,
	[2] = 632
}
RTResTalkAction[145] = {
	[1] = 1,
	[2] = 1087
}
RTResTalkAction[146] = {
	[1] = 0,
	[2] = 1087
}
RTResTalkAction[147] = {
	[1] = 1,
	[2] = 1052
}
RTResTalkAction[148] = {
	[1] = 0,
	[2] = 1052
}
RTResTalkAction[149] = {
	1,
	237,
	{
		1
	},
	nil,
	3
}
RTResTalkAction[150] = {
	1,
	237,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[151] = {
	[1] = 1,
	[2] = 1077
}
RTResTalkAction[152] = {
	[1] = 2,
	[2] = 1077
}
RTResTalkAction[153] = {
	[1] = 3,
	[2] = 1078
}
RTResTalkAction[154] = {
	[1] = 0,
	[2] = 1077
}

local Data = {
	[33000001] = {
		33000001,
		0,
		Lang.get(83630),
		33000,
		1,
		107,
		nil,
		1,
		4,
		nil,
		nil,
		111,
		33003,
		nil,
		nil,
		nil,
		nil,
		nil,
		33003
	},
	[33000002] = {
		33000002,
		0,
		Lang.get(83631),
		33000,
		2,
		107,
		nil,
		1,
		5
	},
	[33000003] = {
		33000003,
		0,
		Lang.get(83632),
		33000,
		3,
		107,
		nil,
		1,
		5
	},
	[33000004] = {
		33000004,
		0,
		Lang.get(83633),
		33000,
		4,
		158,
		nil,
		1,
		2
	},
	[33000005] = {
		33000005,
		0,
		Lang.get(83634),
		33000,
		5,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[33000006] = {
		33000006,
		0,
		Lang.get(83635),
		33000,
		6,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[33000007] = {
		33000007,
		0,
		Lang.get(83636),
		33000,
		7,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[33000008] = {
		33000008,
		0,
		Lang.get(83637),
		33000,
		8,
		107,
		{
			RTResTalkAction[2]
		},
		1,
		5,
		nil,
		nil,
		104,
		33000,
		nil,
		1,
		nil,
		1,
		nil,
		33000
	},
	[33000009] = {
		33000009,
		0,
		Lang.get(83638),
		33000,
		9,
		105,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		33001,
		[19] = 33001
	},
	[33000010] = {
		33000010,
		5,
		Lang.get(83639),
		33000,
		10,
		773,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		33002,
		[19] = 33002
	},
	[33000011] = {
		33000011,
		0,
		Lang.get(83640),
		33000,
		11,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		33000,
		[19] = 33000
	},
	[33000012] = {
		33000012,
		0,
		Lang.get(83641),
		33000,
		12,
		107,
		{
			RTResTalkAction[2]
		},
		1,
		5,
		nil,
		nil,
		106,
		33004,
		nil,
		1,
		nil,
		1,
		nil,
		33004
	},
	[33000013] = {
		33000013,
		0,
		Lang.get(83642),
		33000,
		13,
		270,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		33005,
		[19] = 33005
	},
	[33000014] = {
		33000014,
		0,
		Lang.get(83643),
		33000,
		14,
		55,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		33006,
		[19] = 33006
	},
	[33000015] = {
		33000015,
		5,
		Lang.get(83644),
		33000,
		15,
		605
	},
	[33000016] = {
		33000016,
		0,
		Lang.get(83645),
		33000,
		16,
		107,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		33004,
		[19] = 33004
	},
	[33000017] = {
		33000017,
		5,
		Lang.get(83646),
		33000,
		17,
		107,
		{
			RTResTalkAction[4]
		},
		nil,
		nil,
		3
	},
	[33000018] = {
		33000018,
		0,
		Lang.get(83647),
		33000,
		18,
		158,
		{
			RTResTalkAction[2]
		},
		1,
		1,
		nil,
		nil,
		23,
		33007,
		nil,
		1,
		nil,
		1,
		nil,
		33007
	},
	[33000019] = {
		33000019,
		0,
		Lang.get(83648),
		33000,
		19,
		107,
		nil,
		1,
		6
	},
	[33000020] = {
		33000020,
		0,
		Lang.get(83649),
		33000,
		20,
		107,
		{
			RTResTalkAction[5]
		}
	},
	[33000021] = {
		33000021,
		0,
		Lang.get(83650),
		33000,
		21,
		158,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[33000022] = {
		33000022,
		0,
		Lang.get(83651),
		33000,
		22,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[33000023] = {
		33000023,
		0,
		Lang.get(83652),
		33000,
		23,
		107,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3
	},
	[33000024] = {
		33000024,
		0,
		Lang.get(83653),
		33000,
		24,
		107,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3
	},
	[33000025] = {
		33000025,
		0,
		Lang.get(83654),
		33000,
		25,
		107,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		3
	},
	[33000026] = {
		33000026,
		0,
		Lang.get(83655),
		33000,
		26,
		158,
		{
			RTResTalkAction[13],
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[33000027] = {
		33000027,
		0,
		Lang.get(83656),
		33000,
		27,
		158,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		3
	},
	[33000028] = {
		33000028,
		0,
		Lang.get(83657),
		33000,
		28,
		158,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		3
	},
	[33000029] = {
		33000029,
		0,
		Lang.get(83658),
		33000,
		29,
		107,
		{
			RTResTalkAction[9]
		},
		1,
		1,
		nil,
		nil,
		nil,
		33008,
		nil,
		1,
		nil,
		nil,
		nil,
		33008
	},
	[33000030] = {
		33000030,
		0,
		Lang.get(83659),
		33000,
		30,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		33009,
		nil,
		1,
		nil,
		nil,
		nil,
		33009
	},
	[33000031] = {
		33000031,
		0,
		Lang.get(83660),
		33000,
		31,
		107,
		nil,
		1,
		4,
		nil,
		nil,
		nil,
		33007,
		nil,
		1,
		nil,
		nil,
		nil,
		33007
	},
	[33000032] = {
		33000032,
		0,
		Lang.get(83661),
		33000,
		32,
		107,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[33000033] = {
		33000033,
		0,
		Lang.get(83662),
		33000,
		33,
		107,
		{
			RTResTalkAction[15]
		},
		nil,
		nil,
		3
	},
	[33000034] = {
		33000034,
		0,
		Lang.get(83663),
		33000,
		34,
		107,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3
	},
	[33000035] = {
		33000035,
		0,
		Lang.get(83664),
		33000,
		35,
		158,
		{
			RTResTalkAction[13],
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[33000036] = {
		33000036,
		0,
		Lang.get(83665),
		33000,
		36,
		158,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		3
	},
	[33000037] = {
		33000037,
		0,
		Lang.get(83666),
		33000,
		37,
		107,
		{
			RTResTalkAction[12],
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[33001001] = {
		33001001,
		0,
		Lang.get(83667),
		33001,
		1,
		141,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		33010,
		nil,
		1,
		nil,
		1,
		nil,
		33010
	},
	[33001002] = {
		33001002,
		0,
		Lang.get(83668),
		33001,
		2,
		141,
		nil,
		1
	},
	[33001003] = {
		33001003,
		0,
		Lang.get(83669),
		33001,
		3,
		107,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[33001004] = {
		33001004,
		0,
		Lang.get(83670),
		33001,
		4,
		107,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3
	},
	[33001005] = {
		33001005,
		0,
		Lang.get(83671),
		33001,
		5,
		133,
		{
			RTResTalkAction[6],
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[33001006] = {
		33001006,
		0,
		Lang.get(83672),
		33001,
		6,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[18]
		},
		nil,
		nil,
		3
	},
	[33001007] = {
		33001007,
		5,
		Lang.get(83673),
		33001,
		7,
		107,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[33001008] = {
		33001008,
		0,
		Lang.get(83674),
		33001,
		8,
		133,
		{
			RTResTalkAction[6],
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[33001009] = {
		33001009,
		0,
		Lang.get(83675),
		33001,
		9,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[18]
		},
		1,
		1,
		nil,
		nil,
		63,
		33011,
		nil,
		1,
		nil,
		nil,
		nil,
		33011
	},
	[33001010] = {
		33001010,
		5,
		Lang.get(83676),
		33001,
		10,
		1084,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		33012,
		nil,
		1,
		[19] = 33012
	},
	[33001011] = {
		33001011,
		0,
		Lang.get(83677),
		33001,
		11,
		141,
		{
			RTResTalkAction[19]
		}
	},
	[33001012] = {
		33001012,
		0,
		Lang.get(83678),
		33001,
		12,
		133,
		{
			RTResTalkAction[20],
			RTResTalkAction[17]
		}
	},
	[33002001] = {
		33002001,
		0,
		Lang.get(83679),
		33002,
		1,
		1070,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		33013,
		nil,
		1,
		nil,
		nil,
		nil,
		33013
	},
	[33002002] = {
		33002002,
		7,
		"95",
		33002,
		2,
		1069
	},
	[33002003] = {
		33002003,
		0,
		Lang.get(83680),
		33002,
		3,
		1069,
		nil,
		1,
		1
	},
	[33002004] = {
		33002004,
		0,
		Lang.get(83681),
		33002,
		4,
		1069,
		nil,
		1,
		1
	},
	[33002005] = {
		33002005,
		0,
		Lang.get(83682),
		33002,
		5,
		1069,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3
	},
	[33002006] = {
		33002006,
		0,
		Lang.get(83683),
		33002,
		6,
		133,
		{
			RTResTalkAction[22],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3,
		nil,
		60,
		33014,
		nil,
		1,
		nil,
		nil,
		nil,
		33014
	},
	[33002007] = {
		33002007,
		0,
		Lang.get(83684),
		33002,
		7,
		107,
		{
			RTResTalkAction[12],
			RTResTalkAction[18]
		},
		nil,
		nil,
		3
	},
	[33002008] = {
		33002008,
		0,
		Lang.get(83685),
		33002,
		8,
		141,
		{
			RTResTalkAction[24],
			RTResTalkAction[25]
		},
		nil,
		nil,
		3
	},
	[33002009] = {
		33002009,
		5,
		Lang.get(83676),
		33002,
		9,
		1074,
		{
			RTResTalkAction[26],
			RTResTalkAction[2],
			RTResTalkAction[27]
		},
		nil,
		nil,
		3
	},
	[33002010] = {
		33002010,
		0,
		Lang.get(83686),
		33002,
		10,
		133,
		{
			RTResTalkAction[28]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		33015,
		nil,
		1,
		nil,
		nil,
		nil,
		33015
	},
	[33002011] = {
		33002011,
		0,
		Lang.get(83687),
		33002,
		11,
		1069,
		nil,
		1,
		1
	},
	[33002012] = {
		33002012,
		0,
		Lang.get(83688),
		33002,
		12,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33002013] = {
		33002013,
		0,
		Lang.get(83689),
		33002,
		13,
		133,
		{
			RTResTalkAction[30],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33002014] = {
		33002014,
		0,
		Lang.get(83690),
		33002,
		14,
		133,
		{
			RTResTalkAction[30]
		},
		nil,
		nil,
		3
	},
	[33002015] = {
		33002015,
		0,
		Lang.get(83691),
		33002,
		15,
		107,
		{
			RTResTalkAction[31],
			RTResTalkAction[32]
		},
		nil,
		nil,
		3
	},
	[33002016] = {
		33002016,
		0,
		Lang.get(83692),
		33002,
		16,
		107,
		{
			RTResTalkAction[31],
			RTResTalkAction[32]
		},
		nil,
		nil,
		3
	},
	[33002017] = {
		33002017,
		0,
		Lang.get(83693),
		33002,
		17,
		387,
		{
			RTResTalkAction[18],
			RTResTalkAction[2]
		},
		1,
		1,
		nil,
		nil,
		63,
		33016,
		nil,
		1,
		nil,
		nil,
		nil,
		33016
	},
	[33002018] = {
		33002018,
		0,
		Lang.get(83694),
		33002,
		18,
		107,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		33017,
		nil,
		1,
		nil,
		nil,
		nil,
		33017
	},
	[33002019] = {
		33002019,
		0,
		Lang.get(83695),
		33002,
		19,
		387,
		{
			RTResTalkAction[33]
		},
		nil,
		nil,
		3
	},
	[33002020] = {
		33002020,
		0,
		Lang.get(83696),
		33002,
		20,
		387,
		{
			RTResTalkAction[34]
		},
		nil,
		nil,
		3
	},
	[33002021] = {
		33002021,
		0,
		Lang.get(83697),
		33002,
		21,
		133,
		{
			RTResTalkAction[35],
			RTResTalkAction[36]
		},
		nil,
		nil,
		3
	},
	[33002022] = {
		33002022,
		0,
		Lang.get(83698),
		33002,
		22,
		1069,
		{
			RTResTalkAction[29],
			RTResTalkAction[18]
		},
		nil,
		nil,
		3
	},
	[33002023] = {
		33002023,
		0,
		Lang.get(83699),
		33002,
		23,
		1069,
		{
			RTResTalkAction[37]
		},
		nil,
		nil,
		3
	},
	[33003001] = {
		33003001,
		3,
		Lang.get(83700),
		33003,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		33018,
		1,
		1,
		nil,
		1,
		nil,
		33018,
		nil,
		nil,
		1
	},
	[33003002] = {
		33003002,
		0,
		Lang.get(83701),
		33003,
		2,
		1069,
		nil,
		1,
		1
	},
	[33003003] = {
		33003003,
		4,
		nil,
		33003,
		3,
		300,
		[29] = {
			{
				id = 33003004,
				branch_content = Lang.get(83702)
			},
			{
				id = 33003004,
				branch_content = Lang.get(83703)
			}
		}
	},
	[33003004] = {
		33003004,
		0,
		Lang.get(83704),
		33003,
		4,
		387,
		nil,
		1,
		4
	},
	[33003005] = {
		33003005,
		0,
		Lang.get(83705),
		33003,
		5,
		387,
		nil,
		1,
		4
	},
	[33003006] = {
		33003006,
		0,
		Lang.get(83706),
		33003,
		6,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33003007] = {
		33003007,
		0,
		Lang.get(83707),
		33003,
		7,
		387,
		{
			RTResTalkAction[38],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33003008] = {
		33003008,
		0,
		Lang.get(83708),
		33003,
		8,
		158,
		{
			RTResTalkAction[39],
			RTResTalkAction[36]
		},
		nil,
		nil,
		3
	},
	[33003009] = {
		33003009,
		0,
		Lang.get(83709),
		33003,
		9,
		158,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		3
	},
	[33003010] = {
		33003010,
		0,
		Lang.get(83710),
		33003,
		10,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[33003011] = {
		33003011,
		4,
		nil,
		33003,
		11,
		300,
		{
			RTResTalkAction[2]
		},
		[29] = {
			{
				id = 33003012,
				branch_content = Lang.get(83711)
			}
		}
	},
	[33003012] = {
		33003012,
		3,
		Lang.get(83712),
		33003,
		12,
		605,
		[22] = 1,
		[20] = 100
	},
	[33003013] = {
		33003013,
		3,
		Lang.get(83713),
		33003,
		13,
		605,
		[22] = 1,
		[20] = 200
	},
	[33003014] = {
		33003014,
		3,
		Lang.get(83714),
		33003,
		14,
		605,
		[22] = 1,
		[20] = 255
	},
	[33003015] = {
		33003015,
		0,
		Lang.get(83715),
		33003,
		15,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		33019,
		nil,
		1,
		nil,
		1,
		nil,
		33019,
		-1
	},
	[33003016] = {
		33003016,
		0,
		Lang.get(83716),
		33003,
		16,
		158,
		nil,
		1
	},
	[33003017] = {
		33003017,
		0,
		Lang.get(83717),
		33003,
		17,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33003018] = {
		33003018,
		4,
		nil,
		33003,
		18,
		300,
		{
			RTResTalkAction[23]
		},
		[29] = {
			{
				id = 33003019,
				branch_content = Lang.get(83718)
			},
			{
				id = 33003019,
				branch_content = Lang.get(83719)
			}
		}
	},
	[33003019] = {
		33003019,
		0,
		Lang.get(83720),
		33003,
		19,
		1069,
		{
			RTResTalkAction[37]
		},
		nil,
		nil,
		3
	},
	[33003020] = {
		33003020,
		4,
		nil,
		33003,
		20,
		300,
		{
			RTResTalkAction[23]
		},
		[29] = {
			{
				id = 33003021,
				branch_content = Lang.get(83721)
			},
			{
				id = 33003021,
				branch_content = Lang.get(83722)
			}
		}
	},
	[33003021] = {
		33003021,
		0,
		Lang.get(83723),
		33003,
		21,
		158,
		{
			RTResTalkAction[40]
		},
		nil,
		nil,
		3
	},
	[33003022] = {
		33003022,
		0,
		Lang.get(83724),
		33003,
		22,
		158,
		{
			RTResTalkAction[41]
		},
		nil,
		nil,
		3
	},
	[33003023] = {
		33003023,
		0,
		Lang.get(83725),
		33003,
		23,
		1069,
		{
			RTResTalkAction[21],
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[33003024] = {
		33003024,
		4,
		nil,
		33003,
		24,
		300,
		{
			RTResTalkAction[23]
		},
		[29] = {
			{
				id = 33003025,
				branch_content = Lang.get(83726)
			}
		}
	},
	[33003025] = {
		33003025,
		0,
		Lang.get(83727),
		33003,
		25,
		107,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		3
	},
	[33003026] = {
		33003026,
		0,
		Lang.get(83728),
		33003,
		26,
		107,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3
	},
	[33003027] = {
		33003027,
		0,
		Lang.get(83729),
		33003,
		27,
		141,
		{
			RTResTalkAction[42],
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[33003028] = {
		33003028,
		0,
		Lang.get(83730),
		33003,
		28,
		141,
		{
			RTResTalkAction[43]
		},
		nil,
		nil,
		3
	},
	[33003029] = {
		33003029,
		0,
		Lang.get(83731),
		33003,
		29,
		141,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		3
	},
	[33003030] = {
		33003030,
		0,
		Lang.get(83732),
		33003,
		30,
		158,
		{
			RTResTalkAction[40],
			RTResTalkAction[27]
		},
		nil,
		nil,
		3
	},
	[33003031] = {
		33003031,
		0,
		Lang.get(83733),
		33003,
		31,
		158,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		3
	},
	[33003032] = {
		33003032,
		0,
		Lang.get(83734),
		33003,
		32,
		158,
		{
			RTResTalkAction[44]
		},
		nil,
		nil,
		3
	},
	[33004001] = {
		33004001,
		3,
		Lang.get(83735),
		33004,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		33025,
		nil,
		1,
		nil,
		1,
		nil,
		33025,
		255,
		nil,
		1
	},
	[33004002] = {
		33004002,
		3,
		Lang.get(83736),
		33004,
		2,
		605,
		[22] = 1,
		[20] = 255
	},
	[33004003] = {
		33004003,
		0,
		Lang.get(83737),
		33004,
		3,
		159,
		nil,
		1,
		1,
		[20] = -1
	},
	[33004004] = {
		33004004,
		0,
		Lang.get(83738),
		33004,
		4,
		158,
		nil,
		1,
		1
	},
	[33004005] = {
		33004005,
		0,
		Lang.get(83739),
		33004,
		5,
		765,
		{
			RTResTalkAction[45]
		},
		nil,
		nil,
		3
	},
	[33004006] = {
		33004006,
		0,
		Lang.get(83740),
		33004,
		6,
		158,
		{
			RTResTalkAction[41],
			RTResTalkAction[46]
		},
		nil,
		nil,
		3
	},
	[33004007] = {
		33004007,
		0,
		Lang.get(83741),
		33004,
		7,
		765,
		{
			RTResTalkAction[47],
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[33004008] = {
		33004008,
		0,
		Lang.get(83742),
		33004,
		8,
		159,
		{
			RTResTalkAction[46]
		},
		1,
		1,
		nil,
		nil,
		nil,
		33026,
		nil,
		1,
		nil,
		1,
		nil,
		33026
	},
	[33004009] = {
		33004009,
		5,
		Lang.get(83743),
		33004,
		9,
		336
	},
	[33004010] = {
		33004010,
		0,
		Lang.get(83744),
		33004,
		10,
		765,
		{
			RTResTalkAction[47]
		},
		nil,
		nil,
		3
	},
	[33004011] = {
		33004011,
		0,
		Lang.get(83745),
		33004,
		11,
		159,
		{
			RTResTalkAction[48],
			RTResTalkAction[46]
		},
		nil,
		nil,
		3
	},
	[33004012] = {
		33004012,
		0,
		Lang.get(83746),
		33004,
		12,
		765,
		{
			RTResTalkAction[45],
			RTResTalkAction[49]
		},
		nil,
		nil,
		3
	},
	[33004013] = {
		33004013,
		0,
		Lang.get(85404),
		33004,
		13,
		158,
		{
			RTResTalkAction[13],
			RTResTalkAction[46]
		},
		nil,
		nil,
		3
	},
	[33004014] = {
		33004014,
		0,
		Lang.get(83748),
		33004,
		14,
		336,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		nil,
		nil,
		21,
		33027,
		nil,
		1,
		nil,
		1,
		nil,
		33027
	},
	[33004015] = {
		33004015,
		3,
		Lang.get(83749),
		33004,
		15,
		605,
		[22] = 1
	},
	[33004016] = {
		33004016,
		0,
		Lang.get(83750),
		33004,
		16,
		1047,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		33028,
		nil,
		1,
		nil,
		nil,
		nil,
		33028
	},
	[33004017] = {
		33004017,
		0,
		Lang.get(83751),
		33004,
		17,
		1047,
		nil,
		1,
		1
	},
	[33004018] = {
		33004018,
		0,
		Lang.get(83752),
		33004,
		18,
		1023,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		33029,
		nil,
		1,
		nil,
		nil,
		nil,
		33029
	},
	[33004019] = {
		33004019,
		0,
		Lang.get(83753),
		33004,
		19,
		159,
		nil,
		1,
		2,
		nil,
		nil,
		60,
		33030,
		nil,
		1,
		nil,
		nil,
		nil,
		33030
	},
	[33004020] = {
		33004020,
		0,
		Lang.get(83754),
		33004,
		20,
		158,
		nil,
		1
	},
	[33004021] = {
		33004021,
		0,
		Lang.get(83755),
		33004,
		21,
		1023,
		{
			RTResTalkAction[50]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		33029,
		nil,
		1,
		nil,
		nil,
		nil,
		33029
	},
	[33004022] = {
		33004022,
		0,
		Lang.get(83756),
		33004,
		22,
		1023,
		{
			RTResTalkAction[50]
		},
		nil,
		nil,
		3
	},
	[33004023] = {
		33004023,
		0,
		Lang.get(83757),
		33004,
		23,
		1023,
		{
			RTResTalkAction[50]
		},
		nil,
		nil,
		3
	},
	[33004024] = {
		33004024,
		0,
		Lang.get(83758),
		33004,
		24,
		1023,
		{
			RTResTalkAction[50]
		},
		nil,
		nil,
		3
	},
	[33004025] = {
		33004025,
		0,
		Lang.get(83759),
		33004,
		25,
		1047,
		{
			RTResTalkAction[51],
			RTResTalkAction[52]
		},
		nil,
		nil,
		3
	},
	[33004026] = {
		33004026,
		0,
		Lang.get(83760),
		33004,
		26,
		1047,
		{
			RTResTalkAction[51]
		},
		nil,
		nil,
		3
	},
	[33004027] = {
		33004027,
		0,
		Lang.get(83761),
		33004,
		27,
		1023,
		{
			RTResTalkAction[53],
			RTResTalkAction[54]
		},
		nil,
		nil,
		3
	},
	[33004028] = {
		33004028,
		0,
		Lang.get(83762),
		33004,
		28,
		1047,
		{
			RTResTalkAction[51],
			RTResTalkAction[52]
		},
		nil,
		nil,
		3
	},
	[33004029] = {
		33004029,
		0,
		Lang.get(83763),
		33004,
		29,
		1047,
		{
			RTResTalkAction[51]
		},
		nil,
		nil,
		3
	},
	[33004030] = {
		33004030,
		0,
		Lang.get(83764),
		33004,
		30,
		1047,
		{
			RTResTalkAction[51]
		},
		nil,
		nil,
		3
	},
	[33004031] = {
		33004031,
		0,
		Lang.get(83765),
		33004,
		31,
		1023,
		{
			RTResTalkAction[55],
			RTResTalkAction[56]
		},
		nil,
		nil,
		3
	},
	[33004032] = {
		33004032,
		0,
		Lang.get(83766),
		33004,
		32,
		1047,
		{
			RTResTalkAction[57],
			RTResTalkAction[52]
		},
		nil,
		nil,
		3
	},
	[33005001] = {
		33005001,
		3,
		Lang.get(83767),
		33005,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		33031,
		nil,
		1,
		nil,
		1,
		nil,
		33031,
		255,
		nil,
		1
	},
	[33005002] = {
		33005002,
		3,
		Lang.get(83768),
		33005,
		2,
		605,
		[22] = 1,
		[20] = 255
	},
	[33005003] = {
		33005003,
		0,
		Lang.get(83769),
		33005,
		3,
		141,
		nil,
		1,
		[20] = -1
	},
	[33005004] = {
		33005004,
		0,
		Lang.get(83770),
		33005,
		4,
		1069,
		nil,
		1
	},
	[33005005] = {
		33005005,
		0,
		Lang.get(83771),
		33005,
		5,
		141,
		{
			RTResTalkAction[43]
		},
		nil,
		nil,
		3
	},
	[33005006] = {
		33005006,
		0,
		Lang.get(83772),
		33005,
		6,
		141,
		{
			RTResTalkAction[42]
		},
		nil,
		nil,
		3
	},
	[33005007] = {
		33005007,
		0,
		Lang.get(83773),
		33005,
		7,
		1069,
		{
			RTResTalkAction[37],
			RTResTalkAction[27]
		},
		nil,
		nil,
		3
	},
	[33005008] = {
		33005008,
		0,
		Lang.get(83774),
		33005,
		8,
		141,
		{
			RTResTalkAction[43],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33005009] = {
		33005009,
		0,
		Lang.get(83775),
		33005,
		9,
		1069,
		{
			RTResTalkAction[29],
			RTResTalkAction[27]
		},
		nil,
		nil,
		3
	},
	[33005010] = {
		33005010,
		0,
		Lang.get(83776),
		33005,
		10,
		141,
		{
			RTResTalkAction[23]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		33032,
		nil,
		1,
		nil,
		nil,
		nil,
		33032
	},
	[33005011] = {
		33005011,
		0,
		Lang.get(83777),
		33005,
		11,
		1015,
		{
			RTResTalkAction[58]
		},
		nil,
		nil,
		3
	},
	[33005012] = {
		33005012,
		0,
		Lang.get(83778),
		33005,
		12,
		1015,
		{
			RTResTalkAction[59]
		},
		nil,
		nil,
		3
	},
	[33005013] = {
		33005013,
		0,
		Lang.get(83779),
		33005,
		13,
		1069,
		{
			RTResTalkAction[60],
			RTResTalkAction[61]
		},
		nil,
		nil,
		3
	},
	[33005014] = {
		33005014,
		0,
		Lang.get(83780),
		33005,
		14,
		141,
		{
			RTResTalkAction[42],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33005015] = {
		33005015,
		3,
		Lang.get(83781),
		33005,
		15,
		605,
		{
			RTResTalkAction[27]
		},
		[22] = 1,
		[20] = 255
	},
	[33005016] = {
		33005016,
		0,
		Lang.get(83782),
		33005,
		16,
		1069,
		nil,
		1,
		[20] = 255
	},
	[33005017] = {
		33005017,
		0,
		Lang.get(83783),
		33005,
		17,
		141,
		nil,
		1,
		[20] = 255
	},
	[33005018] = {
		33005018,
		0,
		Lang.get(83784),
		33005,
		18,
		1069,
		nil,
		1,
		[20] = 255
	},
	[33005019] = {
		33005019,
		0,
		Lang.get(83785),
		33005,
		19,
		1015,
		nil,
		1,
		[20] = 255
	},
	[33005020] = {
		33005020,
		0,
		Lang.get(83786),
		33005,
		20,
		273,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		33034,
		nil,
		1,
		nil,
		nil,
		nil,
		33034,
		-1
	},
	[33005021] = {
		33005021,
		0,
		Lang.get(83787),
		33005,
		21,
		1009,
		{
			RTResTalkAction[62]
		},
		nil,
		nil,
		3
	},
	[33005022] = {
		33005022,
		0,
		Lang.get(83788),
		33005,
		22,
		141,
		{
			RTResTalkAction[19],
			RTResTalkAction[63]
		},
		nil,
		nil,
		3
	},
	[33005023] = {
		33005023,
		0,
		Lang.get(83789),
		33005,
		23,
		273,
		{
			RTResTalkAction[64],
			RTResTalkAction[27]
		},
		nil,
		nil,
		3
	},
	[33005024] = {
		33005024,
		0,
		Lang.get(83790),
		33005,
		24,
		273,
		{
			RTResTalkAction[64]
		},
		nil,
		nil,
		3
	},
	[33005025] = {
		33005025,
		0,
		Lang.get(83791),
		33005,
		25,
		141,
		{
			RTResTalkAction[65]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		33035,
		nil,
		1,
		nil,
		nil,
		nil,
		33035
	},
	[33005026] = {
		33005026,
		0,
		Lang.get(83792),
		33005,
		26,
		1069,
		nil,
		1
	},
	[33005027] = {
		33005027,
		0,
		Lang.get(83793),
		33005,
		27,
		1069,
		{
			RTResTalkAction[29]
		},
		1,
		nil,
		3
	},
	[33005028] = {
		33005028,
		0,
		Lang.get(83794),
		33005,
		28,
		1009,
		{
			RTResTalkAction[66],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33005029] = {
		33005029,
		0,
		Lang.get(83795),
		33005,
		29,
		1009,
		{
			RTResTalkAction[66]
		},
		nil,
		nil,
		3
	},
	[33005030] = {
		33005030,
		0,
		Lang.get(83796),
		33005,
		30,
		273,
		{
			RTResTalkAction[64],
			RTResTalkAction[63]
		},
		nil,
		nil,
		3
	},
	[33005031] = {
		33005031,
		0,
		Lang.get(83797),
		33005,
		31,
		1009,
		{
			RTResTalkAction[66],
			RTResTalkAction[65]
		},
		nil,
		nil,
		3
	},
	[33005032] = {
		33005032,
		0,
		Lang.get(83798),
		33005,
		32,
		273,
		{
			RTResTalkAction[64],
			RTResTalkAction[63]
		},
		nil,
		nil,
		3
	},
	[33006001] = {
		33006001,
		3,
		Lang.get(83799),
		33006,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		33040,
		nil,
		1,
		nil,
		nil,
		nil,
		33040,
		255,
		nil,
		1
	},
	[33006002] = {
		33006002,
		3,
		Lang.get(85405),
		33006,
		2,
		605,
		[22] = 1,
		[20] = 255
	},
	[33006003] = {
		33006003,
		0,
		Lang.get(83801),
		33006,
		3,
		1069,
		nil,
		1,
		[20] = -1
	},
	[33006004] = {
		33006004,
		0,
		Lang.get(83802),
		33006,
		4,
		1069,
		nil,
		1
	},
	[33006005] = {
		33006005,
		0,
		Lang.get(83803),
		33006,
		5,
		107,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[33006006] = {
		33006006,
		0,
		Lang.get(83804),
		33006,
		6,
		107,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[33006007] = {
		33006007,
		0,
		Lang.get(83805),
		33006,
		7,
		1069,
		{
			RTResTalkAction[29],
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[33006008] = {
		33006008,
		0,
		Lang.get(83806),
		33006,
		8,
		1085,
		{
			RTResTalkAction[23]
		},
		[20] = 100
	},
	[33006009] = {
		33006009,
		0,
		Lang.get(83807),
		33006,
		9,
		1085,
		[20] = 150
	},
	[33006010] = {
		33006010,
		0,
		Lang.get(83808),
		33006,
		10,
		107,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3,
		[20] = -1
	},
	[33006011] = {
		33006011,
		0,
		Lang.get(83809),
		33006,
		11,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[33006012] = {
		33006012,
		0,
		Lang.get(83810),
		33006,
		12,
		1069,
		{
			RTResTalkAction[29],
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[33006013] = {
		33006013,
		0,
		Lang.get(83811),
		33006,
		13,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33006014] = {
		33006014,
		0,
		Lang.get(83812),
		33006,
		14,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33006015] = {
		33006015,
		0,
		Lang.get(83813),
		33006,
		15,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33006016] = {
		33006016,
		0,
		Lang.get(83814),
		33006,
		16,
		107,
		{
			RTResTalkAction[67],
			RTResTalkAction[32]
		},
		nil,
		nil,
		3
	},
	[33006017] = {
		33006017,
		0,
		Lang.get(83815),
		33006,
		17,
		1069,
		{
			RTResTalkAction[68],
			RTResTalkAction[32]
		},
		nil,
		nil,
		3
	},
	[33006018] = {
		33006018,
		0,
		Lang.get(83816),
		33006,
		18,
		107,
		{
			RTResTalkAction[3],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33006019] = {
		33006019,
		0,
		Lang.get(83817),
		33006,
		19,
		1069,
		{
			RTResTalkAction[37],
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[33006020] = {
		33006020,
		0,
		Lang.get(83818),
		33006,
		20,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33006021] = {
		33006021,
		0,
		Lang.get(83819),
		33006,
		21,
		1069,
		{
			RTResTalkAction[37],
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[33006022] = {
		33006022,
		0,
		Lang.get(83820),
		33006,
		22,
		1010,
		{
			RTResTalkAction[23]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		33045,
		nil,
		1,
		nil,
		nil,
		nil,
		33045
	},
	[33006023] = {
		33006023,
		0,
		Lang.get(83821),
		33006,
		23,
		237,
		nil,
		1
	},
	[33006024] = {
		33006024,
		0,
		Lang.get(83822),
		33006,
		24,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		33046,
		nil,
		1,
		nil,
		nil,
		nil,
		33046
	},
	[33006025] = {
		33006025,
		0,
		Lang.get(83823),
		33006,
		25,
		237,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		33047,
		nil,
		1,
		nil,
		nil,
		nil,
		33047
	},
	[33006026] = {
		33006026,
		0,
		Lang.get(83824),
		33006,
		26,
		237,
		{
			RTResTalkAction[69]
		},
		nil,
		nil,
		3
	},
	[33006027] = {
		33006027,
		0,
		Lang.get(83825),
		33006,
		27,
		1069,
		{
			RTResTalkAction[70]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		33048,
		nil,
		1,
		nil,
		nil,
		nil,
		33048
	},
	[33006028] = {
		33006028,
		0,
		Lang.get(83826),
		33006,
		28,
		1010,
		{
			RTResTalkAction[71]
		},
		nil,
		nil,
		3
	},
	[33006029] = {
		33006029,
		0,
		Lang.get(83827),
		33006,
		29,
		107,
		{
			RTResTalkAction[1],
			RTResTalkAction[72]
		},
		nil,
		nil,
		3
	},
	[33006030] = {
		33006030,
		0,
		Lang.get(83828),
		33006,
		30,
		1069,
		{
			RTResTalkAction[37],
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[33006031] = {
		33006031,
		0,
		Lang.get(83829),
		33006,
		31,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33006032] = {
		33006032,
		0,
		Lang.get(83830),
		33006,
		32,
		237,
		{
			RTResTalkAction[69],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33006033] = {
		33006033,
		0,
		Lang.get(83831),
		33006,
		33,
		237,
		{
			RTResTalkAction[69]
		},
		nil,
		nil,
		3
	},
	[33006034] = {
		33006034,
		0,
		Lang.get(83832),
		33006,
		34,
		1069,
		{
			RTResTalkAction[73],
			RTResTalkAction[70]
		},
		nil,
		nil,
		3
	},
	[33006035] = {
		33006035,
		0,
		Lang.get(83833),
		33006,
		35,
		237,
		{
			RTResTalkAction[69],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33006036] = {
		33006036,
		0,
		Lang.get(83834),
		33006,
		36,
		237,
		{
			RTResTalkAction[69]
		},
		nil,
		nil,
		3
	},
	[33006037] = {
		33006037,
		0,
		Lang.get(83835),
		33006,
		37,
		107,
		{
			RTResTalkAction[74],
			RTResTalkAction[70]
		},
		nil,
		nil,
		3
	},
	[33007001] = {
		33007001,
		3,
		Lang.get(83836),
		33007,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		33050,
		nil,
		1,
		nil,
		nil,
		nil,
		33050,
		255,
		nil,
		1
	},
	[33007002] = {
		33007002,
		3,
		Lang.get(83837),
		33007,
		2,
		605,
		[22] = 1,
		[20] = 255
	},
	[33007003] = {
		33007003,
		0,
		Lang.get(83838),
		33007,
		3,
		387,
		nil,
		1,
		[20] = -1
	},
	[33007004] = {
		33007004,
		0,
		Lang.get(83839),
		33007,
		4,
		387,
		nil,
		1
	},
	[33007005] = {
		33007005,
		0,
		Lang.get(83840),
		33007,
		5,
		1069,
		{
			RTResTalkAction[29]
		}
	},
	[33007006] = {
		33007006,
		0,
		Lang.get(83841),
		33007,
		6,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33007007] = {
		33007007,
		0,
		Lang.get(83842),
		33007,
		7,
		387,
		{
			RTResTalkAction[38],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33007008] = {
		33007008,
		0,
		Lang.get(83843),
		33007,
		8,
		387,
		{
			RTResTalkAction[38]
		},
		nil,
		nil,
		3
	},
	[33007009] = {
		33007009,
		0,
		Lang.get(83844),
		33007,
		9,
		1069,
		{
			RTResTalkAction[29],
			RTResTalkAction[36]
		},
		nil,
		nil,
		3
	},
	[33007010] = {
		33007010,
		0,
		Lang.get(83845),
		33007,
		10,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33007011] = {
		33007011,
		0,
		Lang.get(83846),
		33007,
		11,
		387,
		{
			RTResTalkAction[75],
			RTResTalkAction[76]
		},
		nil,
		nil,
		3
	},
	[33007012] = {
		33007012,
		0,
		Lang.get(83847),
		33007,
		12,
		1069,
		{
			RTResTalkAction[29],
			RTResTalkAction[36]
		},
		nil,
		nil,
		3
	},
	[33007013] = {
		33007013,
		0,
		Lang.get(83848),
		33007,
		13,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33007014] = {
		33007014,
		0,
		Lang.get(83849),
		33007,
		14,
		387,
		{
			RTResTalkAction[75],
			RTResTalkAction[76]
		},
		nil,
		nil,
		3
	},
	[33007015] = {
		33007015,
		0,
		Lang.get(83850),
		33007,
		15,
		1069,
		{
			RTResTalkAction[29],
			RTResTalkAction[36]
		},
		nil,
		nil,
		3
	},
	[33007016] = {
		33007016,
		0,
		Lang.get(83851),
		33007,
		16,
		284,
		{
			RTResTalkAction[23]
		},
		1,
		nil,
		nil,
		nil,
		60,
		33055,
		nil,
		1,
		nil,
		nil,
		nil,
		33055
	},
	[33007017] = {
		33007017,
		0,
		Lang.get(83852),
		33007,
		17,
		284,
		nil,
		1
	},
	[33007018] = {
		33007018,
		0,
		Lang.get(83853),
		33007,
		18,
		284,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		33056,
		nil,
		1,
		nil,
		nil,
		nil,
		33056
	},
	[33007019] = {
		33007019,
		0,
		Lang.get(83854),
		33007,
		19,
		284,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		33057,
		nil,
		1,
		nil,
		nil,
		nil,
		33057
	},
	[33007020] = {
		33007020,
		0,
		Lang.get(83855),
		33007,
		20,
		284,
		nil,
		1
	},
	[33007021] = {
		33007021,
		0,
		Lang.get(83856),
		33007,
		21,
		565,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		33058,
		nil,
		1,
		[19] = 33058
	},
	[33007022] = {
		33007022,
		0,
		Lang.get(83857),
		33007,
		22,
		282,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		33059,
		nil,
		1,
		nil,
		nil,
		nil,
		33059
	},
	[33007023] = {
		33007023,
		0,
		Lang.get(83858),
		33007,
		23,
		284,
		{
			RTResTalkAction[77]
		},
		nil,
		nil,
		3
	},
	[33007024] = {
		33007024,
		0,
		Lang.get(83859),
		33007,
		24,
		282,
		{
			RTResTalkAction[78],
			RTResTalkAction[79]
		},
		nil,
		nil,
		3
	},
	[33007025] = {
		33007025,
		0,
		Lang.get(83860),
		33007,
		25,
		282,
		{
			RTResTalkAction[78]
		},
		nil,
		nil,
		3
	},
	[33007026] = {
		33007026,
		0,
		Lang.get(83861),
		33007,
		26,
		1086,
		{
			RTResTalkAction[80]
		}
	},
	[33007027] = {
		33007027,
		0,
		Lang.get(83862),
		33007,
		27,
		387,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		33060,
		nil,
		1,
		nil,
		nil,
		nil,
		33060
	},
	[33007028] = {
		33007028,
		0,
		Lang.get(83863),
		33007,
		28,
		387,
		{
			RTResTalkAction[81]
		},
		nil,
		nil,
		3
	},
	[33007029] = {
		33007029,
		0,
		Lang.get(83864),
		33007,
		29,
		387,
		{
			RTResTalkAction[33]
		},
		nil,
		nil,
		3
	},
	[33007030] = {
		33007030,
		0,
		Lang.get(83865),
		33007,
		30,
		1069,
		{
			RTResTalkAction[82],
			RTResTalkAction[36]
		},
		nil,
		nil,
		3
	},
	[33007031] = {
		33007031,
		0,
		Lang.get(83866),
		33007,
		31,
		1069,
		{
			RTResTalkAction[60]
		},
		nil,
		nil,
		3
	},
	[33007032] = {
		33007032,
		0,
		Lang.get(83867),
		33007,
		32,
		387,
		{
			RTResTalkAction[38],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33008001] = {
		33008001,
		3,
		Lang.get(83868),
		33008,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		33065,
		nil,
		1,
		nil,
		nil,
		nil,
		33065,
		255,
		nil,
		1
	},
	[33008002] = {
		33008002,
		3,
		Lang.get(83869),
		33008,
		2,
		605,
		[22] = 1,
		[20] = 255
	},
	[33008003] = {
		33008003,
		0,
		Lang.get(83870),
		33008,
		3,
		133,
		nil,
		1,
		[20] = -1
	},
	[33008004] = {
		33008004,
		0,
		Lang.get(83871),
		33008,
		4,
		133,
		nil,
		1
	},
	[33008005] = {
		33008005,
		0,
		Lang.get(83872),
		33008,
		5,
		1069,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		33066,
		nil,
		1,
		nil,
		nil,
		nil,
		33066
	},
	[33008006] = {
		33008006,
		0,
		Lang.get(83873),
		33008,
		6,
		1069,
		nil,
		1
	},
	[33008007] = {
		33008007,
		0,
		Lang.get(83874),
		33008,
		7,
		133,
		{
			RTResTalkAction[30]
		},
		nil,
		nil,
		3
	},
	[33008008] = {
		33008008,
		0,
		Lang.get(83875),
		33008,
		8,
		1069,
		{
			RTResTalkAction[60],
			RTResTalkAction[18]
		},
		nil,
		nil,
		3
	},
	[33008009] = {
		33008009,
		0,
		Lang.get(83876),
		33008,
		9,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33008010] = {
		33008010,
		0,
		Lang.get(83877),
		33008,
		10,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33008011] = {
		33008011,
		0,
		Lang.get(83878),
		33008,
		11,
		133,
		{
			RTResTalkAction[22],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33008012] = {
		33008012,
		0,
		Lang.get(83879),
		33008,
		12,
		1079,
		{
			RTResTalkAction[18]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		33065,
		nil,
		1,
		[19] = 33065,
		[20] = 100
	},
	[33008013] = {
		33008013,
		0,
		Lang.get(83880),
		33008,
		13,
		1079,
		[20] = 120
	},
	[33008014] = {
		33008014,
		0,
		Lang.get(83881),
		33008,
		14,
		133,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		33066,
		nil,
		1,
		nil,
		nil,
		nil,
		33066,
		-1
	},
	[33008015] = {
		33008015,
		5,
		Lang.get(83882),
		33008,
		15,
		1069,
		{
			RTResTalkAction[82]
		},
		nil,
		nil,
		3
	},
	[33008016] = {
		33008016,
		0,
		Lang.get(83883),
		33008,
		16,
		133,
		{
			RTResTalkAction[83],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33008017] = {
		33008017,
		3,
		Lang.get(83884),
		33008,
		17,
		605,
		{
			RTResTalkAction[18]
		},
		[22] = 1,
		[20] = 255
	},
	[33008018] = {
		33008018,
		0,
		Lang.get(83885),
		33008,
		18,
		278,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		33070,
		nil,
		1,
		nil,
		nil,
		nil,
		33070,
		-1
	},
	[33008019] = {
		33008019,
		0,
		Lang.get(83886),
		33008,
		19,
		1069,
		nil,
		1
	},
	[33008020] = {
		33008020,
		0,
		Lang.get(83887),
		33008,
		20,
		133,
		nil,
		1
	},
	[33008021] = {
		33008021,
		0,
		Lang.get(83888),
		33008,
		21,
		133,
		{
			RTResTalkAction[30]
		},
		nil,
		nil,
		3
	},
	[33008022] = {
		33008022,
		0,
		Lang.get(83889),
		33008,
		22,
		278,
		{
			RTResTalkAction[84],
			RTResTalkAction[18]
		},
		nil,
		nil,
		3
	},
	[33008023] = {
		33008023,
		0,
		Lang.get(83890),
		33008,
		23,
		1069,
		{
			RTResTalkAction[29],
			RTResTalkAction[85]
		},
		nil,
		nil,
		3
	},
	[33008024] = {
		33008024,
		0,
		Lang.get(83891),
		33008,
		24,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33008025] = {
		33008025,
		0,
		Lang.get(83892),
		33008,
		25,
		278,
		{
			RTResTalkAction[84],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33008026] = {
		33008026,
		0,
		Lang.get(83893),
		33008,
		26,
		278,
		{
			RTResTalkAction[84]
		},
		nil,
		nil,
		3
	},
	[33008027] = {
		33008027,
		0,
		Lang.get(83894),
		33008,
		27,
		278,
		{
			RTResTalkAction[86]
		},
		nil,
		nil,
		3
	},
	[33008028] = {
		33008028,
		0,
		Lang.get(83895),
		33008,
		28,
		278,
		{
			RTResTalkAction[84]
		},
		nil,
		nil,
		3
	},
	[33008029] = {
		33008029,
		0,
		Lang.get(83896),
		33008,
		29,
		133,
		{
			RTResTalkAction[87],
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[33008030] = {
		33008030,
		0,
		Lang.get(83897),
		33008,
		30,
		278,
		{
			RTResTalkAction[84],
			RTResTalkAction[18]
		},
		nil,
		nil,
		3
	},
	[33008031] = {
		33008031,
		0,
		Lang.get(83898),
		33008,
		31,
		278,
		{
			RTResTalkAction[84]
		},
		nil,
		nil,
		3
	},
	[33008032] = {
		33008032,
		0,
		Lang.get(83899),
		33008,
		32,
		133,
		{
			RTResTalkAction[83],
			RTResTalkAction[85]
		},
		nil,
		nil,
		3
	},
	[33008033] = {
		33008033,
		0,
		Lang.get(83900),
		33008,
		33,
		133,
		{
			RTResTalkAction[30]
		},
		nil,
		nil,
		3
	},
	[33008034] = {
		33008034,
		0,
		Lang.get(83901),
		33008,
		34,
		278,
		{
			RTResTalkAction[88],
			RTResTalkAction[18]
		},
		nil,
		nil,
		3
	},
	[33008035] = {
		33008035,
		0,
		Lang.get(83902),
		33008,
		35,
		278,
		{
			RTResTalkAction[84]
		},
		nil,
		nil,
		3
	},
	[33009001] = {
		33009001,
		0,
		Lang.get(83903),
		33009,
		1,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		33075,
		nil,
		1,
		nil,
		nil,
		nil,
		33075
	},
	[33009002] = {
		33009002,
		0,
		Lang.get(83904),
		33009,
		2,
		141,
		nil,
		1
	},
	[33009003] = {
		33009003,
		0,
		Lang.get(83905),
		33009,
		3,
		158,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		3
	},
	[33009004] = {
		33009004,
		0,
		Lang.get(83906),
		33009,
		4,
		1069,
		{
			RTResTalkAction[37],
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[33009005] = {
		33009005,
		0,
		Lang.get(83907),
		33009,
		5,
		1069,
		{
			RTResTalkAction[37]
		},
		nil,
		nil,
		3
	},
	[33009006] = {
		33009006,
		0,
		Lang.get(83908),
		33009,
		6,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33009007] = {
		33009007,
		0,
		Lang.get(83909),
		33009,
		7,
		158,
		{
			RTResTalkAction[13],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33009008] = {
		33009008,
		0,
		Lang.get(83910),
		33009,
		8,
		158,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		3
	},
	[33009009] = {
		33009009,
		0,
		Lang.get(83911),
		33009,
		9,
		107,
		{
			RTResTalkAction[1],
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[33009010] = {
		33009010,
		0,
		Lang.get(83912),
		33009,
		10,
		133,
		{
			RTResTalkAction[30],
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[33009011] = {
		33009011,
		0,
		Lang.get(83913),
		33009,
		11,
		1069,
		{
			RTResTalkAction[89],
			RTResTalkAction[18]
		},
		nil,
		nil,
		3
	},
	[33009012] = {
		33009012,
		0,
		Lang.get(83914),
		33009,
		12,
		141,
		{
			RTResTalkAction[19],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33009013] = {
		33009013,
		0,
		Lang.get(83915),
		33009,
		13,
		141,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		3
	},
	[33009014] = {
		33009014,
		0,
		Lang.get(83916),
		33009,
		14,
		141,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		3
	},
	[33009015] = {
		33009015,
		0,
		Lang.get(83917),
		33009,
		15,
		107,
		{
			RTResTalkAction[90],
			RTResTalkAction[32]
		},
		nil,
		nil,
		3
	},
	[33009016] = {
		33009016,
		0,
		Lang.get(83918),
		33009,
		16,
		133,
		{
			RTResTalkAction[91],
			RTResTalkAction[1],
			RTResTalkAction[92]
		},
		nil,
		nil,
		3
	},
	[33009017] = {
		33009017,
		0,
		Lang.get(83919),
		33009,
		17,
		133,
		{
			RTResTalkAction[93],
			RTResTalkAction[27],
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[33009018] = {
		33009018,
		0,
		Lang.get(83920),
		33009,
		18,
		1069,
		{
			RTResTalkAction[73],
			RTResTalkAction[18]
		},
		nil,
		nil,
		3
	},
	[33009019] = {
		33009019,
		0,
		Lang.get(83921),
		33009,
		19,
		1069,
		{
			RTResTalkAction[73]
		},
		nil,
		nil,
		3
	},
	[33009020] = {
		33009020,
		0,
		Lang.get(83922),
		33009,
		20,
		1069,
		{
			RTResTalkAction[89]
		},
		nil,
		nil,
		3
	},
	[33010001] = {
		33010001,
		3,
		Lang.get(83923),
		33010,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		33080,
		nil,
		1,
		nil,
		nil,
		nil,
		33080,
		255,
		nil,
		1
	},
	[33010002] = {
		33010002,
		3,
		Lang.get(83924),
		33010,
		2,
		605,
		[22] = 1,
		[20] = 255
	},
	[33010003] = {
		33010003,
		0,
		Lang.get(83925),
		33010,
		3,
		1072,
		[20] = -1
	},
	[33010004] = {
		33010004,
		0,
		Lang.get(83926),
		33010,
		4,
		1069,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		33081,
		nil,
		1,
		nil,
		nil,
		nil,
		33081
	},
	[33010005] = {
		33010005,
		0,
		Lang.get(83927),
		33010,
		5,
		1069,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3
	},
	[33010006] = {
		33010006,
		3,
		Lang.get(83928),
		33010,
		6,
		605,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		33080,
		nil,
		1,
		[19] = 33080,
		[22] = 1
	},
	[33010007] = {
		33010007,
		0,
		Lang.get(83929),
		33010,
		7,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		33081,
		nil,
		1,
		nil,
		nil,
		nil,
		33081
	},
	[33010008] = {
		33010008,
		0,
		Lang.get(83930),
		33010,
		8,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33010009] = {
		33010009,
		3,
		Lang.get(83931),
		33010,
		9,
		605,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		33080,
		nil,
		1,
		[19] = 33080,
		[22] = 1
	},
	[33010010] = {
		33010010,
		0,
		Lang.get(83932),
		33010,
		10,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		33081,
		nil,
		1,
		nil,
		nil,
		nil,
		33081
	},
	[33010011] = {
		33010011,
		0,
		Lang.get(83930),
		33010,
		11,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33010012] = {
		33010012,
		0,
		Lang.get(83933),
		33010,
		12,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33010013] = {
		33010013,
		0,
		Lang.get(83934),
		33010,
		13,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33010014] = {
		33010014,
		0,
		Lang.get(83935),
		33010,
		14,
		1069,
		{
			RTResTalkAction[37]
		},
		nil,
		nil,
		3
	},
	[33010015] = {
		33010015,
		3,
		Lang.get(23517),
		33010,
		15,
		605,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		33080,
		nil,
		1,
		[19] = 33080,
		[22] = 1
	},
	[33011001] = {
		33011001,
		0,
		Lang.get(83936),
		33011,
		1,
		1069,
		nil,
		1,
		nil,
		nil,
		nil,
		57,
		33085,
		nil,
		1,
		nil,
		nil,
		nil,
		33085
	},
	[33011002] = {
		33011002,
		0,
		Lang.get(83937),
		33011,
		2,
		1072
	},
	[33011003] = {
		33011003,
		7,
		"96",
		33011,
		3,
		1071
	},
	[33011004] = {
		33011004,
		0,
		Lang.get(83938),
		33011,
		4,
		1069,
		nil,
		1
	},
	[33011005] = {
		33011005,
		0,
		Lang.get(83939),
		33011,
		5,
		1071,
		{
			RTResTalkAction[94]
		},
		nil,
		nil,
		3
	},
	[33011006] = {
		33011006,
		0,
		Lang.get(83940),
		33011,
		6,
		1071,
		{
			RTResTalkAction[94]
		},
		nil,
		nil,
		3
	},
	[33011007] = {
		33011007,
		0,
		Lang.get(83941),
		33011,
		7,
		1069,
		{
			RTResTalkAction[95],
			RTResTalkAction[96]
		},
		nil,
		nil,
		3
	},
	[33011008] = {
		33011008,
		0,
		Lang.get(83942),
		33011,
		8,
		1071,
		{
			RTResTalkAction[94],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33011009] = {
		33011009,
		0,
		Lang.get(83943),
		33011,
		9,
		1069,
		{
			RTResTalkAction[29],
			RTResTalkAction[97]
		},
		nil,
		nil,
		3
	},
	[33011010] = {
		33011010,
		0,
		Lang.get(83944),
		33011,
		10,
		1069,
		{
			RTResTalkAction[89]
		},
		nil,
		nil,
		3
	},
	[33011011] = {
		33011011,
		0,
		Lang.get(83945),
		33011,
		11,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33011012] = {
		33011012,
		0,
		Lang.get(83946),
		33011,
		12,
		1071,
		{
			RTResTalkAction[94],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33011013] = {
		33011013,
		0,
		Lang.get(83947),
		33011,
		13,
		1071,
		{
			RTResTalkAction[94]
		},
		nil,
		nil,
		3
	},
	[33011014] = {
		33011014,
		0,
		Lang.get(83948),
		33011,
		14,
		1071,
		{
			RTResTalkAction[94]
		},
		nil,
		nil,
		3
	},
	[33011015] = {
		33011015,
		0,
		Lang.get(83949),
		33011,
		15,
		1071,
		{
			RTResTalkAction[94]
		},
		nil,
		nil,
		3
	},
	[33011016] = {
		33011016,
		0,
		Lang.get(83950),
		33011,
		16,
		1069,
		{
			RTResTalkAction[89],
			RTResTalkAction[97]
		},
		nil,
		nil,
		3
	},
	[33011017] = {
		33011017,
		0,
		Lang.get(83951),
		33011,
		17,
		1071,
		{
			RTResTalkAction[94],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33011018] = {
		33011018,
		0,
		Lang.get(83952),
		33011,
		18,
		1069,
		{
			RTResTalkAction[29],
			RTResTalkAction[97]
		},
		nil,
		nil,
		3
	},
	[33011019] = {
		33011019,
		0,
		Lang.get(83953),
		33011,
		19,
		1069,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3
	},
	[33011020] = {
		33011020,
		0,
		Lang.get(83954),
		33011,
		20,
		1071,
		{
			RTResTalkAction[98],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33012001] = {
		33012001,
		0,
		Lang.get(83955),
		33012,
		1,
		1069,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		33090,
		nil,
		1,
		nil,
		nil,
		nil,
		33090
	},
	[33012002] = {
		33012002,
		0,
		Lang.get(83956),
		33012,
		2,
		1071,
		nil,
		1
	},
	[33012003] = {
		33012003,
		0,
		Lang.get(83957),
		33012,
		3,
		1071,
		nil,
		1
	},
	[33012004] = {
		33012004,
		0,
		Lang.get(83958),
		33012,
		4,
		1069,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3
	},
	[33012005] = {
		33012005,
		0,
		Lang.get(83959),
		33012,
		5,
		1069,
		{
			RTResTalkAction[37]
		},
		nil,
		nil,
		3
	},
	[33012006] = {
		33012006,
		0,
		Lang.get(85406),
		33012,
		6,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33012007] = {
		33012007,
		0,
		Lang.get(83961),
		33012,
		7,
		1069,
		{
			RTResTalkAction[73]
		},
		nil,
		nil,
		3
	},
	[33012008] = {
		33012008,
		0,
		Lang.get(83962),
		33012,
		8,
		1071,
		{
			RTResTalkAction[94],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33012009] = {
		33012009,
		0,
		Lang.get(83963),
		33012,
		9,
		1069,
		{
			RTResTalkAction[73],
			RTResTalkAction[97]
		},
		nil,
		nil,
		3
	},
	[33012010] = {
		33012010,
		0,
		Lang.get(83964),
		33012,
		10,
		1069,
		{
			RTResTalkAction[23]
		},
		1,
		2,
		nil,
		nil,
		59,
		33091,
		nil,
		1,
		nil,
		nil,
		nil,
		33091
	},
	[33012011] = {
		33012011,
		0,
		Lang.get(83965),
		33012,
		11,
		1069,
		nil,
		1,
		1
	},
	[33012012] = {
		33012012,
		0,
		Lang.get(83966),
		33012,
		12,
		1071,
		{
			RTResTalkAction[99]
		},
		nil,
		nil,
		3
	},
	[33012013] = {
		33012013,
		0,
		Lang.get(83967),
		33012,
		13,
		1071,
		{
			RTResTalkAction[100]
		},
		nil,
		nil,
		3
	},
	[33012014] = {
		33012014,
		0,
		Lang.get(83968),
		33012,
		14,
		1071,
		{
			RTResTalkAction[94]
		},
		nil,
		nil,
		3
	},
	[33012015] = {
		33012015,
		0,
		Lang.get(83969),
		33012,
		15,
		1071,
		{
			RTResTalkAction[94]
		},
		nil,
		nil,
		3
	},
	[33012016] = {
		33012016,
		0,
		Lang.get(83970),
		33012,
		16,
		1071,
		{
			RTResTalkAction[94]
		},
		nil,
		nil,
		3
	},
	[33012017] = {
		33012017,
		0,
		Lang.get(83971),
		33012,
		17,
		1071,
		{
			RTResTalkAction[94]
		},
		nil,
		nil,
		3
	},
	[33012018] = {
		33012018,
		0,
		Lang.get(83972),
		33012,
		18,
		1069,
		{
			RTResTalkAction[97]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		33092,
		nil,
		1,
		nil,
		nil,
		nil,
		33092
	},
	[33012019] = {
		33012019,
		3,
		Lang.get(83973),
		33012,
		19,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		190,
		33093,
		1,
		1,
		nil,
		1,
		nil,
		33093,
		nil,
		nil,
		1
	},
	[33012020] = {
		33012020,
		0,
		Lang.get(83974),
		33012,
		20,
		1081,
		nil,
		1
	},
	[33012021] = {
		33012021,
		0,
		Lang.get(83975),
		33012,
		21,
		1080,
		{
			RTResTalkAction[101]
		},
		nil,
		nil,
		3
	},
	[33012022] = {
		33012022,
		0,
		Lang.get(83976),
		33012,
		22,
		1081,
		{
			RTResTalkAction[102],
			RTResTalkAction[103]
		},
		nil,
		nil,
		3
	},
	[33012023] = {
		33012023,
		0,
		Lang.get(83977),
		33012,
		23,
		1081,
		{
			RTResTalkAction[102],
			RTResTalkAction[103]
		},
		nil,
		nil,
		3
	},
	[33012024] = {
		33012024,
		0,
		Lang.get(83978),
		33012,
		24,
		1080,
		{
			RTResTalkAction[101],
			RTResTalkAction[104]
		},
		nil,
		nil,
		3
	},
	[33012025] = {
		33012025,
		0,
		Lang.get(83979),
		33012,
		25,
		1069,
		{
			RTResTalkAction[105]
		},
		[20] = 50
	},
	[33012026] = {
		33012026,
		0,
		Lang.get(83980),
		33012,
		26,
		1080,
		{
			RTResTalkAction[101]
		},
		nil,
		nil,
		3,
		[20] = 100
	},
	[33012027] = {
		33012027,
		0,
		Lang.get(83981),
		33012,
		27,
		1069,
		{
			RTResTalkAction[105]
		},
		[20] = 150
	},
	[33012028] = {
		33012028,
		0,
		Lang.get(83982),
		33012,
		28,
		1069,
		[20] = 255
	},
	[33012029] = {
		33012029,
		0,
		Lang.get(83983),
		33012,
		29,
		1071,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		33095,
		nil,
		1,
		nil,
		0,
		nil,
		33095,
		-1
	},
	[33012030] = {
		33012030,
		0,
		Lang.get(83984),
		33012,
		30,
		1069,
		nil,
		1
	},
	[33012031] = {
		33012031,
		0,
		Lang.get(83985),
		33012,
		31,
		1069,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3
	},
	[33012032] = {
		33012032,
		0,
		Lang.get(83986),
		33012,
		32,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33012033] = {
		33012033,
		0,
		Lang.get(83987),
		33012,
		33,
		1071,
		{
			RTResTalkAction[100],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33012034] = {
		33012034,
		0,
		Lang.get(83988),
		33012,
		34,
		1071,
		{
			RTResTalkAction[94]
		},
		nil,
		nil,
		3
	},
	[33012035] = {
		33012035,
		0,
		Lang.get(83989),
		33012,
		35,
		1069,
		{
			RTResTalkAction[21],
			RTResTalkAction[97]
		},
		nil,
		nil,
		3
	},
	[33012036] = {
		33012036,
		0,
		Lang.get(83990),
		33012,
		36,
		1069,
		{
			RTResTalkAction[37]
		},
		nil,
		nil,
		3
	},
	[33015001] = {
		33015001,
		0,
		Lang.get(83991),
		33015,
		1,
		188,
		nil,
		1,
		3,
		nil,
		nil,
		47,
		33096,
		nil,
		1,
		nil,
		1,
		nil,
		33096
	},
	[33015002] = {
		33015002,
		0,
		Lang.get(83992),
		33015,
		2,
		512,
		nil,
		1
	},
	[33015003] = {
		33015003,
		3,
		Lang.get(83993),
		33015,
		3,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		33097,
		nil,
		1,
		[19] = 33097,
		[22] = 1
	},
	[33015004] = {
		33015004,
		0,
		Lang.get(83994),
		33015,
		4,
		188,
		{
			RTResTalkAction[106]
		},
		nil,
		nil,
		3
	},
	[33015005] = {
		33015005,
		0,
		Lang.get(83995),
		33015,
		5,
		512,
		{
			RTResTalkAction[107]
		},
		1
	},
	[33015006] = {
		33015006,
		0,
		Lang.get(83996),
		33015,
		6,
		152,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		33098,
		nil,
		1,
		nil,
		1,
		nil,
		33098
	},
	[33015007] = {
		33015007,
		0,
		Lang.get(83997),
		33015,
		7,
		769,
		nil,
		1,
		1
	},
	[33015008] = {
		33015008,
		0,
		Lang.get(83998),
		33015,
		8,
		152,
		{
			RTResTalkAction[108]
		},
		nil,
		nil,
		3
	},
	[33015009] = {
		33015009,
		0,
		Lang.get(83999),
		33015,
		9,
		188,
		{
			RTResTalkAction[109],
			RTResTalkAction[110]
		},
		nil,
		nil,
		3
	},
	[33015010] = {
		33015010,
		0,
		Lang.get(84000),
		33015,
		10,
		188,
		{
			RTResTalkAction[106]
		},
		nil,
		nil,
		3
	},
	[33015011] = {
		33015011,
		0,
		Lang.get(84001),
		33015,
		11,
		152,
		{
			RTResTalkAction[108],
			RTResTalkAction[107]
		},
		nil,
		nil,
		3
	},
	[33015012] = {
		33015012,
		0,
		Lang.get(84002),
		33015,
		12,
		769,
		{
			RTResTalkAction[111],
			RTResTalkAction[110]
		},
		nil,
		nil,
		3
	},
	[33015013] = {
		33015013,
		0,
		Lang.get(26264),
		33015,
		13,
		152,
		{
			RTResTalkAction[108],
			RTResTalkAction[112]
		},
		nil,
		nil,
		3
	},
	[33015014] = {
		33015014,
		0,
		Lang.get(84003),
		33015,
		14,
		188,
		{
			RTResTalkAction[109],
			RTResTalkAction[110]
		},
		nil,
		nil,
		3
	},
	[33015015] = {
		33015015,
		0,
		Lang.get(84004),
		33015,
		15,
		152,
		{
			RTResTalkAction[108],
			RTResTalkAction[107]
		},
		nil,
		nil,
		3
	},
	[33015016] = {
		33015016,
		0,
		Lang.get(84005),
		33015,
		16,
		769,
		{
			RTResTalkAction[111],
			RTResTalkAction[110]
		},
		nil,
		nil,
		3
	},
	[33015017] = {
		33015017,
		0,
		Lang.get(84006),
		33015,
		17,
		152,
		{
			RTResTalkAction[113],
			RTResTalkAction[112]
		},
		nil,
		nil,
		3
	},
	[33015018] = {
		33015018,
		0,
		Lang.get(84007),
		33015,
		18,
		769,
		{
			RTResTalkAction[114],
			RTResTalkAction[110]
		},
		nil,
		nil,
		3
	},
	[33015019] = {
		33015019,
		0,
		Lang.get(84008),
		33015,
		19,
		769,
		{
			RTResTalkAction[115]
		},
		nil,
		nil,
		3
	},
	[33015020] = {
		33015020,
		0,
		Lang.get(84009),
		33015,
		20,
		152,
		{
			RTResTalkAction[116],
			RTResTalkAction[117]
		},
		nil,
		nil,
		3
	},
	[33015021] = {
		33015021,
		0,
		Lang.get(84010),
		33015,
		21,
		769,
		{
			RTResTalkAction[111],
			RTResTalkAction[110]
		},
		nil,
		nil,
		3
	},
	[33016001] = {
		33016001,
		3,
		Lang.get(84011),
		33016,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		33100,
		nil,
		1,
		nil,
		1,
		nil,
		33100,
		255,
		nil,
		1
	},
	[33016002] = {
		33016002,
		3,
		Lang.get(84012),
		33016,
		2,
		605,
		[22] = 1,
		[20] = 255
	},
	[33016003] = {
		33016003,
		3,
		Lang.get(84013),
		33016,
		3,
		605,
		[22] = 1,
		[20] = 255
	},
	[33016004] = {
		33016004,
		0,
		Lang.get(84014),
		33016,
		4,
		1069,
		nil,
		1,
		1,
		[20] = -1
	},
	[33016005] = {
		33016005,
		0,
		Lang.get(84015),
		33016,
		5,
		1069,
		nil,
		1,
		1
	},
	[33016006] = {
		33016006,
		0,
		Lang.get(84016),
		33016,
		6,
		1069,
		nil,
		1,
		2
	},
	[33016007] = {
		33016007,
		5,
		Lang.get(84017),
		33016,
		7,
		1069,
		[20] = 255
	},
	[33016008] = {
		33016008,
		5,
		Lang.get(84018),
		33016,
		8,
		1069,
		[20] = 255
	},
	[33017001] = {
		33017001,
		0,
		Lang.get(84019),
		33017,
		1,
		188,
		nil,
		1,
		3,
		nil,
		nil,
		47,
		33103,
		nil,
		1,
		nil,
		nil,
		nil,
		33103,
		-1
	},
	[33017002] = {
		33017002,
		0,
		Lang.get(84020),
		33017,
		2,
		769,
		nil,
		1,
		1
	},
	[33017003] = {
		33017003,
		0,
		Lang.get(84021),
		33017,
		3,
		769,
		{
			RTResTalkAction[118]
		},
		nil,
		nil,
		3
	},
	[33017004] = {
		33017004,
		0,
		Lang.get(84022),
		33017,
		4,
		1069,
		{
			RTResTalkAction[89],
			RTResTalkAction[112]
		},
		nil,
		nil,
		3
	},
	[33017005] = {
		33017005,
		0,
		Lang.get(84023),
		33017,
		5,
		769,
		{
			RTResTalkAction[118],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33017006] = {
		33017006,
		0,
		Lang.get(84024),
		33017,
		6,
		1069,
		{
			RTResTalkAction[82],
			RTResTalkAction[112]
		},
		nil,
		nil,
		3
	},
	[33017007] = {
		33017007,
		0,
		Lang.get(84025),
		33017,
		7,
		188,
		{
			RTResTalkAction[106],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33017008] = {
		33017008,
		0,
		Lang.get(84026),
		33017,
		8,
		188,
		{
			RTResTalkAction[107]
		},
		1,
		4,
		nil,
		nil,
		nil,
		33104,
		nil,
		1,
		nil,
		nil,
		nil,
		33104
	},
	[33017009] = {
		33017009,
		0,
		Lang.get(84027),
		33017,
		9,
		769,
		nil,
		1,
		3
	},
	[33017010] = {
		33017010,
		0,
		Lang.get(84028),
		33017,
		10,
		769,
		{
			RTResTalkAction[119]
		},
		nil,
		nil,
		3
	},
	[33017011] = {
		33017011,
		0,
		Lang.get(84029),
		33017,
		11,
		188,
		{
			RTResTalkAction[106],
			RTResTalkAction[112]
		},
		nil,
		nil,
		3
	},
	[33017012] = {
		33017012,
		0,
		Lang.get(84030),
		33017,
		12,
		1069,
		{
			RTResTalkAction[73],
			RTResTalkAction[107]
		},
		nil,
		nil,
		3
	},
	[33017013] = {
		33017013,
		0,
		Lang.get(84031),
		33017,
		13,
		188,
		{
			RTResTalkAction[106],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33018001] = {
		33018001,
		0,
		Lang.get(84032),
		33018,
		1,
		769,
		nil,
		1,
		1,
		nil,
		nil,
		57,
		33105,
		nil,
		1,
		nil,
		1,
		nil,
		33105
	},
	[33018002] = {
		33018002,
		0,
		Lang.get(84033),
		33018,
		2,
		188,
		nil,
		1,
		3
	},
	[33018003] = {
		33018003,
		0,
		Lang.get(84034),
		33018,
		3,
		769,
		{
			RTResTalkAction[111]
		},
		nil,
		nil,
		3
	},
	[33018004] = {
		33018004,
		0,
		Lang.get(84035),
		33018,
		4,
		769,
		{
			RTResTalkAction[118]
		},
		nil,
		nil,
		3
	},
	[33018005] = {
		33018005,
		0,
		Lang.get(84036),
		33018,
		5,
		769,
		{
			RTResTalkAction[111]
		},
		nil,
		nil,
		3
	},
	[33018006] = {
		33018006,
		0,
		Lang.get(84037),
		33018,
		6,
		1069,
		{
			RTResTalkAction[73],
			RTResTalkAction[112]
		},
		nil,
		nil,
		3
	},
	[33018007] = {
		33018007,
		0,
		Lang.get(84038),
		33018,
		7,
		769,
		{
			RTResTalkAction[111],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33018008] = {
		33018008,
		0,
		Lang.get(84039),
		33018,
		8,
		188,
		{
			RTResTalkAction[109],
			RTResTalkAction[112]
		},
		nil,
		nil,
		3
	},
	[33018009] = {
		33018009,
		0,
		Lang.get(84040),
		33018,
		9,
		1069,
		{
			RTResTalkAction[21],
			RTResTalkAction[107]
		},
		nil,
		nil,
		3
	},
	[33018010] = {
		33018010,
		0,
		Lang.get(84041),
		33018,
		10,
		1069,
		{
			RTResTalkAction[73]
		},
		nil,
		nil,
		3
	},
	[33018011] = {
		33018011,
		0,
		Lang.get(84042),
		33018,
		11,
		769,
		{
			RTResTalkAction[111],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33018012] = {
		33018012,
		0,
		Lang.get(84043),
		33018,
		12,
		769,
		{
			RTResTalkAction[114]
		},
		nil,
		nil,
		3
	},
	[33018013] = {
		33018013,
		0,
		Lang.get(84044),
		33018,
		13,
		1069,
		{
			RTResTalkAction[73],
			RTResTalkAction[112]
		},
		nil,
		nil,
		3
	},
	[33018014] = {
		33018014,
		0,
		Lang.get(84045),
		33018,
		14,
		188,
		{
			RTResTalkAction[106],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33018015] = {
		33018015,
		0,
		Lang.get(84046),
		33018,
		15,
		188,
		{
			RTResTalkAction[109]
		},
		nil,
		nil,
		3
	},
	[33018016] = {
		33018016,
		0,
		Lang.get(84047),
		33018,
		16,
		769,
		{
			RTResTalkAction[111],
			RTResTalkAction[107]
		},
		nil,
		nil,
		3
	},
	[33018017] = {
		33018017,
		0,
		Lang.get(84048),
		33018,
		17,
		769,
		{
			RTResTalkAction[119]
		},
		nil,
		nil,
		3
	},
	[33018018] = {
		33018018,
		0,
		Lang.get(84049),
		33018,
		18,
		1069,
		{
			RTResTalkAction[112]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		33106,
		nil,
		1,
		nil,
		nil,
		nil,
		33106
	},
	[33018019] = {
		33018019,
		0,
		Lang.get(84050),
		33018,
		19,
		188,
		{
			RTResTalkAction[109]
		},
		nil,
		nil,
		3
	},
	[33018020] = {
		33018020,
		0,
		Lang.get(84051),
		33018,
		20,
		1069,
		{
			RTResTalkAction[29],
			RTResTalkAction[107]
		},
		nil,
		nil,
		3
	},
	[33018021] = {
		33018021,
		0,
		Lang.get(84052),
		33018,
		21,
		769,
		{
			RTResTalkAction[23]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		33107,
		nil,
		1,
		nil,
		nil,
		nil,
		33107
	},
	[33018022] = {
		33018022,
		0,
		Lang.get(84053),
		33018,
		22,
		769,
		nil,
		1
	},
	[33018023] = {
		33018023,
		0,
		Lang.get(84054),
		33018,
		23,
		1069,
		{
			RTResTalkAction[37]
		},
		nil,
		nil,
		3
	},
	[33018024] = {
		33018024,
		0,
		Lang.get(84055),
		33018,
		24,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33018025] = {
		33018025,
		0,
		Lang.get(84056),
		33018,
		25,
		769,
		{
			RTResTalkAction[118],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33018026] = {
		33018026,
		0,
		Lang.get(84057),
		33018,
		26,
		188,
		{
			RTResTalkAction[112]
		},
		1,
		4,
		nil,
		nil,
		nil,
		33108,
		nil,
		1,
		nil,
		nil,
		nil,
		33108
	},
	[33018027] = {
		33018027,
		0,
		Lang.get(84058),
		33018,
		27,
		188,
		nil,
		1,
		2
	},
	[33018028] = {
		33018028,
		0,
		Lang.get(84059),
		33018,
		28,
		769,
		{
			RTResTalkAction[111]
		},
		nil,
		nil,
		3
	},
	[33018029] = {
		33018029,
		0,
		Lang.get(84060),
		33018,
		29,
		769,
		{
			RTResTalkAction[114]
		},
		nil,
		nil,
		3
	},
	[33018030] = {
		33018030,
		0,
		Lang.get(84061),
		33018,
		30,
		769,
		{
			RTResTalkAction[118]
		},
		nil,
		nil,
		3
	},
	[33019001] = {
		33019001,
		0,
		Lang.get(84062),
		33019,
		1,
		107,
		nil,
		1,
		1,
		nil,
		nil,
		44,
		33110,
		nil,
		1,
		nil,
		1,
		nil,
		33110
	},
	[33019002] = {
		33019002,
		0,
		Lang.get(84063),
		33019,
		2,
		133,
		{
			RTResTalkAction[35]
		},
		nil,
		nil,
		3
	},
	[33019003] = {
		33019003,
		0,
		Lang.get(84064),
		33019,
		3,
		133,
		{
			RTResTalkAction[83]
		},
		nil,
		nil,
		3
	},
	[33019004] = {
		33019004,
		0,
		Lang.get(84065),
		33019,
		4,
		141,
		{
			RTResTalkAction[31],
			RTResTalkAction[25]
		},
		nil,
		nil,
		3
	},
	[33019005] = {
		33019005,
		0,
		Lang.get(84066),
		33019,
		5,
		141,
		{
			RTResTalkAction[31],
			RTResTalkAction[25]
		},
		nil,
		nil,
		3
	},
	[33019006] = {
		33019006,
		0,
		Lang.get(84067),
		33019,
		6,
		133,
		{
			RTResTalkAction[120],
			RTResTalkAction[27]
		},
		nil,
		nil,
		3
	},
	[33019007] = {
		33019007,
		0,
		Lang.get(84068),
		33019,
		7,
		387,
		{
			RTResTalkAction[18]
		},
		1,
		4,
		nil,
		nil,
		nil,
		33111,
		nil,
		1,
		nil,
		nil,
		nil,
		33111
	},
	[33019008] = {
		33019008,
		0,
		Lang.get(84069),
		33019,
		8,
		141,
		nil,
		1
	},
	[33019009] = {
		33019009,
		0,
		Lang.get(84070),
		33019,
		9,
		387,
		{
			RTResTalkAction[121]
		},
		nil,
		nil,
		3
	},
	[33019010] = {
		33019010,
		0,
		Lang.get(84071),
		33019,
		10,
		387,
		{
			RTResTalkAction[122]
		},
		nil,
		nil,
		3
	},
	[33019011] = {
		33019011,
		0,
		Lang.get(84072),
		33019,
		11,
		133,
		{
			RTResTalkAction[35],
			RTResTalkAction[36]
		},
		nil,
		nil,
		3
	},
	[33019012] = {
		33019012,
		0,
		Lang.get(84073),
		33019,
		12,
		141,
		{
			RTResTalkAction[43],
			RTResTalkAction[18]
		},
		nil,
		nil,
		3
	},
	[33019013] = {
		33019013,
		0,
		Lang.get(84074),
		33019,
		13,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[27]
		},
		nil,
		nil,
		3
	},
	[33020001] = {
		33020001,
		0,
		Lang.get(84075),
		33020,
		1,
		107,
		nil,
		1,
		1,
		nil,
		nil,
		63,
		33112,
		nil,
		1,
		nil,
		1,
		nil,
		33112
	},
	[33020002] = {
		33020002,
		0,
		Lang.get(84076),
		33020,
		2,
		133,
		nil,
		1
	},
	[33020003] = {
		33020003,
		0,
		Lang.get(84077),
		33020,
		3,
		133,
		nil,
		1
	},
	[33020004] = {
		33020004,
		0,
		Lang.get(84078),
		33020,
		4,
		107,
		{
			RTResTalkAction[123]
		},
		nil,
		nil,
		3
	},
	[33020005] = {
		33020005,
		0,
		Lang.get(84079),
		33020,
		5,
		107,
		{
			RTResTalkAction[2]
		},
		1,
		6,
		nil,
		nil,
		nil,
		33113,
		nil,
		nil,
		nil,
		nil,
		nil,
		33113
	},
	[33020006] = {
		33020006,
		0,
		"......",
		33020,
		6,
		1078,
		nil,
		nil,
		nil,
		3
	},
	[33020007] = {
		33020007,
		5,
		Lang.get(84080),
		33020,
		7,
		107,
		[20] = 255
	},
	[33020008] = {
		33020008,
		0,
		Lang.get(84081),
		33020,
		8,
		141,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		33115,
		nil,
		1,
		nil,
		1,
		nil,
		33115,
		-1
	},
	[33020009] = {
		33020009,
		0,
		Lang.get(84082),
		33020,
		9,
		141,
		nil,
		1
	},
	[33020010] = {
		33020010,
		0,
		Lang.get(84083),
		33020,
		10,
		133,
		{
			RTResTalkAction[83]
		},
		nil,
		nil,
		3
	},
	[33020011] = {
		33020011,
		0,
		Lang.get(84084),
		33020,
		11,
		107,
		{
			RTResTalkAction[124],
			RTResTalkAction[18]
		},
		nil,
		nil,
		3
	},
	[33020012] = {
		33020012,
		0,
		Lang.get(84085),
		33020,
		12,
		141,
		{
			RTResTalkAction[43],
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[33020013] = {
		33020013,
		0,
		Lang.get(84086),
		33020,
		13,
		1069,
		{
			RTResTalkAction[27]
		},
		1,
		nil,
		nil,
		nil,
		63,
		33116,
		nil,
		1,
		nil,
		1,
		nil,
		33116
	},
	[33020014] = {
		33020014,
		0,
		Lang.get(84087),
		33020,
		14,
		1069,
		nil,
		1
	},
	[33020015] = {
		33020015,
		0,
		Lang.get(84088),
		33020,
		15,
		1069,
		{
			RTResTalkAction[73]
		},
		nil,
		nil,
		3
	},
	[33020016] = {
		33020016,
		0,
		Lang.get(84089),
		33020,
		16,
		1069,
		{
			RTResTalkAction[73]
		},
		nil,
		nil,
		3
	},
	[33020017] = {
		33020017,
		0,
		Lang.get(84090),
		33020,
		17,
		1069,
		{
			RTResTalkAction[37]
		},
		nil,
		nil,
		3
	},
	[33020018] = {
		33020018,
		0,
		Lang.get(84091),
		33020,
		18,
		1069,
		{
			RTResTalkAction[73]
		},
		nil,
		nil,
		3
	},
	[33020019] = {
		33020019,
		0,
		Lang.get(84092),
		33020,
		19,
		1069,
		{
			RTResTalkAction[73]
		},
		nil,
		nil,
		3
	},
	[33022001] = {
		33022001,
		0,
		Lang.get(84093),
		33022,
		1,
		1069,
		nil,
		1,
		nil,
		nil,
		nil,
		190,
		33120,
		nil,
		1,
		nil,
		1,
		nil,
		33120,
		255
	},
	[33022002] = {
		33022002,
		0,
		Lang.get(84094),
		33022,
		2,
		1069,
		nil,
		1,
		[20] = 255
	},
	[33022003] = {
		33022003,
		0,
		Lang.get(84095),
		33022,
		3,
		1071,
		nil,
		1,
		[20] = 255
	},
	[33022004] = {
		33022004,
		0,
		Lang.get(84096),
		33022,
		4,
		1069,
		{
			RTResTalkAction[37]
		},
		nil,
		nil,
		3,
		[20] = 255
	},
	[33022005] = {
		33022005,
		0,
		Lang.get(84097),
		33022,
		5,
		1069,
		{
			RTResTalkAction[37]
		},
		nil,
		nil,
		3,
		[20] = 255
	},
	[33022006] = {
		33022006,
		0,
		Lang.get(84098),
		33022,
		6,
		1069,
		{
			RTResTalkAction[60]
		},
		nil,
		nil,
		3,
		[20] = -1
	},
	[33022007] = {
		33022007,
		0,
		Lang.get(84099),
		33022,
		7,
		1071,
		{
			RTResTalkAction[23]
		},
		1,
		1,
		nil,
		nil,
		nil,
		33121,
		nil,
		1,
		nil,
		nil,
		nil,
		33121
	},
	[33022008] = {
		33022008,
		0,
		Lang.get(84100),
		33022,
		8,
		1071,
		nil,
		1
	},
	[33022009] = {
		33022009,
		0,
		Lang.get(84101),
		33022,
		9,
		1069,
		{
			RTResTalkAction[89]
		},
		nil,
		nil,
		3
	},
	[33022010] = {
		33022010,
		0,
		Lang.get(84102),
		33022,
		10,
		1071,
		{
			RTResTalkAction[94],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33022011] = {
		33022011,
		0,
		Lang.get(84103),
		33022,
		11,
		1071,
		{
			RTResTalkAction[94]
		},
		nil,
		nil,
		3
	},
	[33022012] = {
		33022012,
		0,
		Lang.get(84104),
		33022,
		12,
		1069,
		{
			RTResTalkAction[29],
			RTResTalkAction[97]
		},
		nil,
		nil,
		3
	},
	[33022013] = {
		33022013,
		0,
		Lang.get(84105),
		33022,
		13,
		1071,
		{
			RTResTalkAction[94],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33022014] = {
		33022014,
		0,
		Lang.get(84106),
		33022,
		14,
		1069,
		{
			RTResTalkAction[29],
			RTResTalkAction[97]
		},
		nil,
		nil,
		3
	},
	[33022015] = {
		33022015,
		0,
		Lang.get(84107),
		33022,
		15,
		1069,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3
	},
	[33022016] = {
		33022016,
		0,
		Lang.get(84108),
		33022,
		16,
		1071,
		{
			RTResTalkAction[100],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33022017] = {
		33022017,
		0,
		Lang.get(84109),
		33022,
		17,
		1069,
		{
			RTResTalkAction[37],
			RTResTalkAction[97]
		},
		nil,
		nil,
		3
	},
	[33022018] = {
		33022018,
		0,
		Lang.get(84110),
		33022,
		18,
		1069,
		{
			RTResTalkAction[89]
		},
		nil,
		nil,
		3
	},
	[33022019] = {
		33022019,
		3,
		Lang.get(84111),
		33022,
		19,
		605,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		33122,
		nil,
		1,
		[19] = 33122,
		[22] = 1
	},
	[33022020] = {
		33022020,
		5,
		Lang.get(84112),
		33022,
		20,
		1069,
		nil,
		1
	},
	[33022021] = {
		33022021,
		0,
		Lang.get(84113),
		33022,
		21,
		1071,
		nil,
		1,
		1
	},
	[33022022] = {
		33022022,
		5,
		Lang.get(84114),
		33022,
		22,
		1069,
		nil,
		1
	},
	[33022023] = {
		33022023,
		0,
		Lang.get(84115),
		33022,
		23,
		1071,
		{
			RTResTalkAction[94]
		},
		nil,
		nil,
		3
	},
	[33022024] = {
		33022024,
		0,
		Lang.get(84116),
		33022,
		24,
		1071,
		{
			RTResTalkAction[94]
		},
		nil,
		nil,
		3
	},
	[33022025] = {
		33022025,
		0,
		Lang.get(84117),
		33022,
		25,
		1071,
		{
			RTResTalkAction[100]
		},
		nil,
		nil,
		3
	},
	[33022026] = {
		33022026,
		0,
		Lang.get(84118),
		33022,
		26,
		1069,
		{
			RTResTalkAction[29],
			RTResTalkAction[97]
		},
		nil,
		nil,
		3
	},
	[33022027] = {
		33022027,
		0,
		Lang.get(84119),
		33022,
		27,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33025001] = {
		33025001,
		0,
		Lang.get(84120),
		33025,
		1,
		1071,
		nil,
		1,
		nil,
		nil,
		nil,
		47,
		33125,
		1,
		1,
		nil,
		1,
		nil,
		33125
	},
	[33025002] = {
		33025002,
		0,
		Lang.get(84121),
		33025,
		2,
		1071,
		nil,
		1
	},
	[33025003] = {
		33025003,
		0,
		Lang.get(84122),
		33025,
		3,
		1069,
		{
			RTResTalkAction[73]
		},
		nil,
		nil,
		3
	},
	[33025004] = {
		33025004,
		0,
		Lang.get(84123),
		33025,
		4,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33025005] = {
		33025005,
		0,
		Lang.get(84124),
		33025,
		5,
		1069,
		{
			RTResTalkAction[73]
		},
		nil,
		nil,
		3
	},
	[33025006] = {
		33025006,
		0,
		Lang.get(84125),
		33025,
		6,
		1071,
		{
			RTResTalkAction[94],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33025007] = {
		33025007,
		0,
		Lang.get(84126),
		33025,
		7,
		1069,
		{
			RTResTalkAction[29],
			RTResTalkAction[97]
		},
		nil,
		nil,
		3
	},
	[33025008] = {
		33025008,
		0,
		Lang.get(84127),
		33025,
		8,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33025009] = {
		33025009,
		0,
		Lang.get(84128),
		33025,
		9,
		1071,
		{
			RTResTalkAction[94],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33025010] = {
		33025010,
		0,
		Lang.get(84129),
		33025,
		10,
		1069,
		{
			RTResTalkAction[73],
			RTResTalkAction[97]
		},
		nil,
		nil,
		3
	},
	[33025011] = {
		33025011,
		0,
		Lang.get(84130),
		33025,
		11,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33025012] = {
		33025012,
		0,
		Lang.get(84131),
		33025,
		12,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33025013] = {
		33025013,
		0,
		Lang.get(84132),
		33025,
		13,
		1071,
		{
			RTResTalkAction[23]
		},
		1,
		1,
		nil,
		nil,
		190,
		33126,
		nil,
		1,
		nil,
		nil,
		nil,
		33126
	},
	[33025014] = {
		33025014,
		0,
		Lang.get(84133),
		33025,
		14,
		1071,
		nil,
		1
	},
	[33025015] = {
		33025015,
		0,
		Lang.get(84134),
		33025,
		15,
		1069,
		nil,
		1
	},
	[33025016] = {
		33025016,
		0,
		Lang.get(84135),
		33025,
		16,
		1071,
		{
			RTResTalkAction[94]
		},
		nil,
		nil,
		3
	},
	[33025017] = {
		33025017,
		0,
		Lang.get(84136),
		33025,
		17,
		1069,
		{
			RTResTalkAction[29],
			RTResTalkAction[97]
		},
		nil,
		nil,
		3
	},
	[33025018] = {
		33025018,
		0,
		Lang.get(84137),
		33025,
		18,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33025019] = {
		33025019,
		0,
		Lang.get(84138),
		33025,
		19,
		1071,
		{
			RTResTalkAction[94],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33025020] = {
		33025020,
		0,
		Lang.get(84139),
		33025,
		20,
		1071,
		{
			RTResTalkAction[94]
		},
		nil,
		nil,
		3
	},
	[33025021] = {
		33025021,
		0,
		Lang.get(84140),
		33025,
		21,
		1071,
		{
			RTResTalkAction[94]
		},
		nil,
		nil,
		3
	},
	[33025022] = {
		33025022,
		0,
		Lang.get(84141),
		33025,
		22,
		1069,
		{
			RTResTalkAction[95],
			RTResTalkAction[125]
		},
		nil,
		nil,
		3
	},
	[33025023] = {
		33025023,
		0,
		Lang.get(84142),
		33025,
		23,
		1071,
		{
			RTResTalkAction[100],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33025024] = {
		33025024,
		0,
		Lang.get(84143),
		33025,
		24,
		1071,
		{
			RTResTalkAction[100]
		},
		nil,
		nil,
		3
	},
	[33026001] = {
		33026001,
		0,
		Lang.get(84144),
		33026,
		1,
		188,
		nil,
		1,
		nil,
		nil,
		nil,
		57,
		33130,
		nil,
		1,
		nil,
		1,
		nil,
		33130
	},
	[33026002] = {
		33026002,
		0,
		Lang.get(84145),
		33026,
		2,
		769,
		nil,
		1
	},
	[33026003] = {
		33026003,
		0,
		Lang.get(84146),
		33026,
		3,
		769,
		{
			RTResTalkAction[126]
		},
		nil,
		nil,
		3
	},
	[33026004] = {
		33026004,
		0,
		Lang.get(84147),
		33026,
		4,
		188,
		{
			RTResTalkAction[127],
			RTResTalkAction[112]
		},
		nil,
		nil,
		3
	},
	[33026005] = {
		33026005,
		0,
		Lang.get(84148),
		33026,
		5,
		769,
		{
			RTResTalkAction[126],
			RTResTalkAction[107]
		},
		nil,
		nil,
		3
	},
	[33026006] = {
		33026006,
		3,
		Lang.get(77829),
		33026,
		6,
		605,
		{
			RTResTalkAction[112]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		33131,
		nil,
		1,
		nil,
		nil,
		nil,
		33131,
		255,
		nil,
		1
	},
	[33026007] = {
		33026007,
		0,
		Lang.get(84149),
		33026,
		7,
		769,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		33132,
		nil,
		1,
		nil,
		nil,
		nil,
		33132,
		-1
	},
	[33026008] = {
		33026008,
		0,
		Lang.get(84150),
		33026,
		8,
		1069,
		nil,
		1
	},
	[33026009] = {
		33026009,
		0,
		Lang.get(84151),
		33026,
		9,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33026010] = {
		33026010,
		0,
		Lang.get(84152),
		33026,
		10,
		188,
		{
			RTResTalkAction[128],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33026011] = {
		33026011,
		0,
		Lang.get(84153),
		33026,
		11,
		769,
		{
			RTResTalkAction[107]
		},
		1,
		1,
		nil,
		nil,
		nil,
		33133,
		nil,
		1,
		nil,
		nil,
		nil,
		33133
	},
	[33026012] = {
		33026012,
		0,
		Lang.get(84154),
		33026,
		12,
		1069,
		nil,
		1,
		1
	},
	[33026013] = {
		33026013,
		0,
		Lang.get(84155),
		33026,
		13,
		1069,
		{
			RTResTalkAction[37]
		},
		nil,
		nil,
		3
	},
	[33026014] = {
		33026014,
		0,
		Lang.get(84156),
		33026,
		14,
		769,
		{
			RTResTalkAction[129],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33026015] = {
		33026015,
		0,
		Lang.get(84157),
		33026,
		15,
		1078,
		{
			RTResTalkAction[112]
		}
	},
	[33026016] = {
		33026016,
		0,
		Lang.get(84158),
		33026,
		16,
		188,
		{
			RTResTalkAction[130]
		},
		nil,
		nil,
		3
	},
	[33026017] = {
		33026017,
		0,
		Lang.get(84159),
		33026,
		17,
		769,
		{
			RTResTalkAction[111],
			RTResTalkAction[107]
		},
		nil,
		nil,
		3
	},
	[33026018] = {
		33026018,
		0,
		Lang.get(84160),
		33026,
		18,
		769,
		{
			RTResTalkAction[129]
		},
		nil,
		nil,
		3
	},
	[33026019] = {
		33026019,
		0,
		Lang.get(84161),
		33026,
		19,
		188,
		{
			RTResTalkAction[109],
			RTResTalkAction[112]
		},
		nil,
		nil,
		3
	},
	[33026020] = {
		33026020,
		0,
		Lang.get(84162),
		33026,
		20,
		769,
		{
			RTResTalkAction[107]
		},
		1,
		5,
		nil,
		nil,
		47,
		33134,
		nil,
		1,
		nil,
		nil,
		nil,
		33134
	},
	[33026021] = {
		33026021,
		0,
		Lang.get(84163),
		33026,
		21,
		188,
		nil,
		1,
		3
	},
	[33026022] = {
		33026022,
		0,
		Lang.get(84164),
		33026,
		22,
		1069,
		{
			RTResTalkAction[73]
		},
		nil,
		nil,
		3
	},
	[33026023] = {
		33026023,
		0,
		Lang.get(84165),
		33026,
		23,
		769,
		{
			RTResTalkAction[114],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33026024] = {
		33026024,
		0,
		Lang.get(84166),
		33026,
		24,
		769,
		{
			RTResTalkAction[111]
		},
		nil,
		nil,
		3
	},
	[33026025] = {
		33026025,
		0,
		Lang.get(84167),
		33026,
		25,
		188,
		{
			RTResTalkAction[131],
			RTResTalkAction[132]
		},
		nil,
		nil,
		3
	},
	[33026026] = {
		33026026,
		0,
		Lang.get(84168),
		33026,
		26,
		188,
		{
			RTResTalkAction[106],
			RTResTalkAction[112]
		},
		nil,
		nil,
		3
	},
	[33026027] = {
		33026027,
		0,
		Lang.get(84169),
		33026,
		27,
		1069,
		{
			RTResTalkAction[37],
			RTResTalkAction[107]
		},
		nil,
		nil,
		3
	},
	[33026028] = {
		33026028,
		0,
		Lang.get(84170),
		33026,
		28,
		107,
		{
			RTResTalkAction[23]
		},
		1,
		4
	},
	[33026029] = {
		33026029,
		0,
		Lang.get(84171),
		33026,
		29,
		188,
		{
			RTResTalkAction[130]
		},
		nil,
		nil,
		3
	},
	[33028001] = {
		33028001,
		0,
		Lang.get(84172),
		33028,
		1,
		107,
		nil,
		1,
		5,
		nil,
		nil,
		57,
		33135,
		nil,
		1,
		nil,
		nil,
		nil,
		33135
	},
	[33028002] = {
		33028002,
		0,
		Lang.get(84173),
		33028,
		2,
		133,
		nil,
		1,
		1
	},
	[33028003] = {
		33028003,
		0,
		Lang.get(84174),
		33028,
		3,
		769,
		nil,
		1,
		5,
		nil,
		nil,
		nil,
		33136,
		nil,
		1,
		nil,
		nil,
		nil,
		33136
	},
	[33028004] = {
		33028004,
		0,
		Lang.get(84175),
		33028,
		4,
		188,
		nil,
		1,
		3
	},
	[33028005] = {
		33028005,
		5,
		Lang.get(84176),
		33028,
		5,
		1069,
		nil,
		1
	},
	[33028006] = {
		33028006,
		0,
		Lang.get(84177),
		33028,
		6,
		141,
		{
			RTResTalkAction[133]
		},
		nil,
		nil,
		3
	},
	[33028007] = {
		33028007,
		0,
		Lang.get(84178),
		33028,
		7,
		188,
		{
			RTResTalkAction[109],
			RTResTalkAction[27]
		},
		nil,
		nil,
		3
	},
	[33028008] = {
		33028008,
		0,
		Lang.get(84179),
		33028,
		8,
		188,
		{
			RTResTalkAction[130]
		},
		nil,
		nil,
		3
	},
	[33028009] = {
		33028009,
		0,
		Lang.get(84180),
		33028,
		9,
		769,
		{
			RTResTalkAction[119],
			RTResTalkAction[107]
		},
		nil,
		nil,
		3
	},
	[33028010] = {
		33028010,
		0,
		Lang.get(84181),
		33028,
		10,
		1069,
		{
			RTResTalkAction[60],
			RTResTalkAction[112]
		},
		nil,
		nil,
		3
	},
	[33028011] = {
		33028011,
		0,
		Lang.get(84182),
		33028,
		11,
		1069,
		{
			RTResTalkAction[134]
		},
		nil,
		nil,
		3
	},
	[33028012] = {
		33028012,
		0,
		Lang.get(84183),
		33028,
		12,
		188,
		{
			RTResTalkAction[130],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33028013] = {
		33028013,
		0,
		Lang.get(84184),
		33028,
		13,
		769,
		{
			RTResTalkAction[118],
			RTResTalkAction[107]
		},
		nil,
		nil,
		3
	},
	[33028014] = {
		33028014,
		0,
		Lang.get(84185),
		33028,
		14,
		107,
		{
			RTResTalkAction[112]
		},
		1,
		nil,
		nil,
		nil,
		47,
		33137,
		nil,
		1,
		nil,
		nil,
		nil,
		33137
	},
	[33028015] = {
		33028015,
		0,
		Lang.get(84186),
		33028,
		15,
		107,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[33028016] = {
		33028016,
		0,
		Lang.get(84187),
		33028,
		16,
		133,
		{
			RTResTalkAction[135],
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[33028017] = {
		33028017,
		0,
		Lang.get(84188),
		33028,
		17,
		1069,
		{
			RTResTalkAction[89],
			RTResTalkAction[2],
			RTResTalkAction[18]
		},
		nil,
		nil,
		3
	},
	[33028018] = {
		33028018,
		0,
		Lang.get(84189),
		33028,
		18,
		1069,
		{
			RTResTalkAction[73]
		},
		nil,
		nil,
		3
	},
	[33028019] = {
		33028019,
		0,
		Lang.get(84190),
		33028,
		19,
		1069,
		{
			RTResTalkAction[89]
		},
		nil,
		nil,
		3
	},
	[33028020] = {
		33028020,
		0,
		Lang.get(84191),
		33028,
		20,
		769,
		{
			RTResTalkAction[111],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33028021] = {
		33028021,
		0,
		Lang.get(84192),
		33028,
		21,
		141,
		{
			RTResTalkAction[136],
			RTResTalkAction[112]
		},
		nil,
		nil,
		3
	},
	[33028022] = {
		33028022,
		0,
		Lang.get(84193),
		33028,
		22,
		1069,
		{
			RTResTalkAction[27]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		33140,
		1,
		1,
		nil,
		1,
		nil,
		33140
	},
	[33028023] = {
		33028023,
		0,
		Lang.get(84194),
		33028,
		23,
		107,
		nil,
		1,
		7
	},
	[33028024] = {
		33028024,
		0,
		Lang.get(84195),
		33028,
		24,
		141,
		{
			RTResTalkAction[43]
		},
		nil,
		nil,
		3
	},
	[33028025] = {
		33028025,
		0,
		Lang.get(84196),
		33028,
		25,
		1069,
		{
			RTResTalkAction[29],
			RTResTalkAction[27]
		},
		nil,
		nil,
		3
	},
	[33028026] = {
		33028026,
		0,
		Lang.get(84197),
		33028,
		26,
		141,
		{
			RTResTalkAction[43],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33028027] = {
		33028027,
		0,
		Lang.get(84198),
		33028,
		27,
		133,
		{
			RTResTalkAction[137],
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[33028028] = {
		33028028,
		0,
		Lang.get(84199),
		33028,
		28,
		1069,
		{
			RTResTalkAction[73],
			RTResTalkAction[27],
			RTResTalkAction[18]
		},
		nil,
		nil,
		3
	},
	[33028029] = {
		33028029,
		0,
		Lang.get(84200),
		33028,
		29,
		1069,
		{
			RTResTalkAction[37]
		},
		nil,
		nil,
		3
	},
	[33030001] = {
		33030001,
		0,
		Lang.get(84201),
		33030,
		1,
		152,
		nil,
		1,
		1,
		nil,
		nil,
		57,
		33145,
		nil,
		1,
		nil,
		nil,
		nil,
		33145
	},
	[33030002] = {
		33030002,
		0,
		Lang.get(84202),
		33030,
		2,
		769,
		nil,
		1,
		1
	},
	[33030003] = {
		33030003,
		0,
		Lang.get(84203),
		33030,
		3,
		188,
		nil,
		1,
		3
	},
	[33030004] = {
		33030004,
		0,
		Lang.get(84204),
		33030,
		4,
		152,
		{
			RTResTalkAction[108]
		},
		nil,
		nil,
		3
	},
	[33030005] = {
		33030005,
		0,
		Lang.get(84205),
		33030,
		5,
		1078,
		{
			RTResTalkAction[110]
		}
	},
	[33030006] = {
		33030006,
		0,
		Lang.get(84206),
		33030,
		6,
		152,
		{
			RTResTalkAction[108]
		},
		nil,
		nil,
		3
	},
	[33030007] = {
		33030007,
		0,
		Lang.get(84207),
		33030,
		7,
		769,
		{
			RTResTalkAction[126],
			RTResTalkAction[110]
		},
		nil,
		nil,
		3
	},
	[33030008] = {
		33030008,
		0,
		Lang.get(84208),
		33030,
		8,
		188,
		{
			RTResTalkAction[138],
			RTResTalkAction[112]
		},
		nil,
		nil,
		3
	},
	[33030009] = {
		33030009,
		5,
		Lang.get(84209),
		33030,
		9,
		1078,
		{
			RTResTalkAction[107]
		}
	},
	[33030010] = {
		33030010,
		3,
		Lang.get(84210),
		33030,
		10,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		33146,
		nil,
		1,
		[19] = 33146,
		[22] = 1
	},
	[33030011] = {
		33030011,
		0,
		Lang.get(84211),
		33030,
		11,
		188,
		{
			RTResTalkAction[130]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		33147,
		nil,
		1,
		[19] = 33147,
		[20] = -1
	},
	[33030012] = {
		33030012,
		0,
		Lang.get(84212),
		33030,
		12,
		769,
		{
			RTResTalkAction[129],
			RTResTalkAction[107]
		}
	},
	[33030013] = {
		33030013,
		0,
		Lang.get(84213),
		33030,
		13,
		188,
		{
			RTResTalkAction[139],
			RTResTalkAction[112]
		},
		1,
		3,
		3
	},
	[33030014] = {
		33030014,
		0,
		Lang.get(84214),
		33030,
		14,
		188,
		{
			RTResTalkAction[139]
		},
		1,
		4,
		3
	},
	[33030015] = {
		33030015,
		0,
		Lang.get(84215),
		33030,
		15,
		1082,
		{
			RTResTalkAction[140],
			RTResTalkAction[141]
		},
		nil,
		nil,
		3
	},
	[33030016] = {
		33030016,
		0,
		Lang.get(84216),
		33030,
		16,
		188,
		{
			RTResTalkAction[128],
			RTResTalkAction[142]
		},
		nil,
		nil,
		3
	},
	[33030017] = {
		33030017,
		0,
		Lang.get(84217),
		33030,
		17,
		769,
		{
			RTResTalkAction[107]
		},
		1,
		1,
		nil,
		nil,
		47,
		33148,
		nil,
		1,
		nil,
		nil,
		nil,
		33148
	},
	[33030018] = {
		33030018,
		0,
		Lang.get(84218),
		33030,
		18,
		769,
		nil,
		1,
		1
	},
	[33030019] = {
		33030019,
		0,
		Lang.get(84219),
		33030,
		19,
		152,
		{
			RTResTalkAction[108]
		},
		nil,
		nil,
		3
	},
	[33030020] = {
		33030020,
		0,
		Lang.get(84220),
		33030,
		20,
		152,
		{
			RTResTalkAction[113]
		},
		nil,
		nil,
		3
	},
	[33031001] = {
		33031001,
		3,
		Lang.get(84221),
		33031,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		1222,
		nil,
		33150,
		nil,
		1,
		nil,
		1,
		nil,
		33150,
		nil,
		nil,
		1
	},
	[33031002] = {
		33031002,
		0,
		Lang.get(84222),
		33031,
		2,
		632,
		nil,
		1,
		2
	},
	[33031003] = {
		33031003,
		0,
		Lang.get(84223),
		33031,
		3,
		107,
		nil,
		1,
		6
	},
	[33031004] = {
		33031004,
		0,
		Lang.get(84224),
		33031,
		4,
		632,
		{
			RTResTalkAction[143]
		},
		nil,
		nil,
		3
	},
	[33031005] = {
		33031005,
		0,
		Lang.get(84225),
		33031,
		5,
		158,
		{
			RTResTalkAction[144]
		},
		1,
		nil,
		nil,
		nil,
		62,
		33151,
		nil,
		1,
		nil,
		nil,
		nil,
		33151
	},
	[33031006] = {
		33031006,
		4,
		nil,
		33031,
		6,
		300,
		[29] = {
			{
				id = 33031007,
				branch_content = Lang.get(84226)
			},
			{
				id = 33031008,
				branch_content = Lang.get(84227)
			}
		}
	},
	[33031007] = {
		33031007,
		0,
		Lang.get(84228),
		33031,
		7,
		158,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		3
	},
	[33031008] = {
		33031008,
		0,
		Lang.get(84229),
		33031,
		8,
		158,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		3
	},
	[33031009] = {
		33031009,
		0,
		Lang.get(84230),
		33031,
		9,
		1087,
		{
			RTResTalkAction[145],
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[33031010] = {
		33031010,
		0,
		Lang.get(84231),
		33031,
		10,
		1087,
		{
			RTResTalkAction[145]
		},
		nil,
		nil,
		3
	},
	[33031011] = {
		33031011,
		0,
		Lang.get(84232),
		33031,
		11,
		284,
		{
			RTResTalkAction[77],
			RTResTalkAction[146]
		},
		nil,
		nil,
		3
	},
	[33031012] = {
		33031012,
		0,
		Lang.get(84233),
		33031,
		12,
		107,
		{
			RTResTalkAction[1],
			RTResTalkAction[79]
		},
		nil,
		nil,
		3
	},
	[33031013] = {
		33031013,
		0,
		Lang.get(84234),
		33031,
		13,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[33031014] = {
		33031014,
		0,
		Lang.get(84235),
		33031,
		14,
		1073,
		nil,
		1
	},
	[33031015] = {
		33031015,
		0,
		Lang.get(84236),
		33031,
		15,
		1073,
		nil,
		1
	},
	[33031016] = {
		33031016,
		0,
		Lang.get(84237),
		33031,
		16,
		158,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		3
	},
	[33031017] = {
		33031017,
		0,
		Lang.get(84238),
		33031,
		17,
		1073,
		{
			RTResTalkAction[9]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		33152,
		nil,
		1,
		nil,
		nil,
		nil,
		33152
	},
	[33031018] = {
		33031018,
		0,
		Lang.get(85407),
		33031,
		18,
		1073,
		nil,
		1
	},
	[33031019] = {
		33031019,
		4,
		nil,
		33031,
		19,
		300,
		[29] = {
			{
				id = 33031020,
				branch_content = Lang.get(84241)
			},
			{
				id = 33031021,
				branch_content = Lang.get(84242)
			}
		}
	},
	[33031020] = {
		33031020,
		0,
		Lang.get(84243),
		33031,
		20,
		300
	},
	[33031021] = {
		33031021,
		2,
		Lang.get(84244),
		33031,
		21,
		300
	},
	[33031022] = {
		33031022,
		2,
		Lang.get(84245),
		33031,
		22,
		300
	},
	[33031023] = {
		33031023,
		0,
		Lang.get(84246),
		33031,
		23,
		300
	},
	[33032001] = {
		33032001,
		0,
		Lang.get(84247),
		33032,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		33155,
		nil,
		1,
		nil,
		1,
		nil,
		33155
	},
	[33032002] = {
		33032002,
		0,
		Lang.get(84248),
		33032,
		2,
		1052,
		nil,
		1
	},
	[33032003] = {
		33032003,
		0,
		Lang.get(84249),
		33032,
		3,
		237,
		{
			RTResTalkAction[69]
		},
		nil,
		nil,
		3
	},
	[33032004] = {
		33032004,
		0,
		Lang.get(84250),
		33032,
		4,
		300,
		{
			RTResTalkAction[70]
		}
	},
	[33032005] = {
		33032005,
		0,
		Lang.get(84251),
		33032,
		5,
		1052,
		{
			RTResTalkAction[147]
		},
		nil,
		nil,
		3
	},
	[33032006] = {
		33032006,
		0,
		Lang.get(84252),
		33032,
		6,
		107,
		{
			RTResTalkAction[123],
			RTResTalkAction[148]
		},
		nil,
		nil,
		3
	},
	[33032007] = {
		33032007,
		0,
		Lang.get(84253),
		33032,
		7,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[33032008] = {
		33032008,
		0,
		Lang.get(85408),
		33032,
		8,
		300
	},
	[33032009] = {
		33032009,
		0,
		Lang.get(84255),
		33032,
		9,
		1052,
		{
			RTResTalkAction[147]
		},
		nil,
		nil,
		3
	},
	[33032010] = {
		33032010,
		4,
		nil,
		33032,
		10,
		300,
		{
			RTResTalkAction[148]
		},
		[29] = {
			{
				id = 33032011,
				branch_content = Lang.get(84256)
			},
			{
				id = 33032011,
				branch_content = Lang.get(84257)
			}
		}
	},
	[33032011] = {
		33032011,
		0,
		Lang.get(84258),
		33032,
		11,
		1071,
		{
			RTResTalkAction[100]
		},
		nil,
		nil,
		3
	},
	[33032012] = {
		33032012,
		0,
		Lang.get(84259),
		33032,
		12,
		1071,
		{
			RTResTalkAction[100]
		},
		nil,
		nil,
		3
	},
	[33032013] = {
		33032013,
		0,
		Lang.get(84260),
		33032,
		13,
		300,
		{
			RTResTalkAction[97]
		}
	},
	[33032014] = {
		33032014,
		0,
		Lang.get(84261),
		33032,
		14,
		1052,
		{
			RTResTalkAction[147]
		},
		nil,
		nil,
		3
	},
	[33032015] = {
		33032015,
		3,
		Lang.get(84262),
		33032,
		15,
		1052,
		{
			RTResTalkAction[148]
		},
		[22] = 1
	},
	[33033001] = {
		33033001,
		0,
		Lang.get(84263),
		33033,
		1,
		1052,
		nil,
		1,
		nil,
		nil,
		nil,
		190,
		33160,
		nil,
		1,
		nil,
		nil,
		nil,
		33160,
		-1
	},
	[33033002] = {
		33033002,
		0,
		Lang.get(84264),
		33033,
		2,
		1071,
		nil,
		1
	},
	[33033003] = {
		33033003,
		0,
		Lang.get(84265),
		33033,
		3,
		1052,
		nil,
		1
	},
	[33033004] = {
		33033004,
		0,
		Lang.get(84266),
		33033,
		4,
		1069,
		nil,
		1
	},
	[33033005] = {
		33033005,
		5,
		Lang.get(85487),
		33033,
		5,
		1069,
		[22] = 1
	},
	[33033006] = {
		33033006,
		0,
		Lang.get(84268),
		33033,
		6,
		237,
		nil,
		1
	},
	[33033007] = {
		33033007,
		0,
		Lang.get(84269),
		33033,
		7,
		1052,
		nil,
		1
	},
	[33033008] = {
		33033008,
		0,
		Lang.get(84270),
		33033,
		8,
		237,
		nil,
		1
	},
	[33033009] = {
		33033009,
		0,
		Lang.get(84271),
		33033,
		9,
		1069,
		nil,
		1,
		1
	},
	[33033010] = {
		33033010,
		0,
		Lang.get(84272),
		33033,
		10,
		1069,
		nil,
		1,
		1
	},
	[33033011] = {
		33033011,
		0,
		Lang.get(84273),
		33033,
		11,
		1069,
		nil,
		1,
		1
	},
	[33033012] = {
		33033012,
		0,
		Lang.get(84274),
		33033,
		12,
		1069,
		nil,
		1,
		1
	},
	[33033013] = {
		33033013,
		0,
		Lang.get(84275),
		33033,
		13,
		237,
		nil,
		1
	},
	[33033014] = {
		33033014,
		0,
		Lang.get(84276),
		33033,
		14,
		300
	},
	[33033015] = {
		33033015,
		0,
		Lang.get(84277),
		33033,
		15,
		237,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		33162,
		nil,
		1,
		nil,
		nil,
		nil,
		33162
	},
	[33033016] = {
		33033016,
		0,
		Lang.get(84278),
		33033,
		16,
		1052,
		nil,
		1
	},
	[33033017] = {
		33033017,
		0,
		Lang.get(84279),
		33033,
		17,
		237,
		{
			RTResTalkAction[149]
		},
		nil,
		nil,
		3
	},
	[33033018] = {
		33033018,
		0,
		Lang.get(84280),
		33033,
		18,
		1069,
		{
			RTResTalkAction[37],
			RTResTalkAction[70]
		},
		nil,
		nil,
		3
	},
	[33033019] = {
		33033019,
		0,
		Lang.get(84281),
		33033,
		19,
		237,
		{
			RTResTalkAction[150],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33033020] = {
		33033020,
		0,
		Lang.get(84282),
		33033,
		20,
		1069,
		{
			RTResTalkAction[29],
			RTResTalkAction[70]
		},
		nil,
		nil,
		3
	},
	[33033021] = {
		33033021,
		2,
		Lang.get(84283),
		33033,
		21,
		1069,
		{
			RTResTalkAction[73]
		},
		nil,
		nil,
		3
	},
	[33033022] = {
		33033022,
		0,
		Lang.get(84284),
		33033,
		22,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33033023] = {
		33033023,
		2,
		Lang.get(84285),
		33033,
		23,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33033024] = {
		33033024,
		2,
		Lang.get(84286),
		33033,
		24,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33033025] = {
		33033025,
		0,
		Lang.get(84287),
		33033,
		25,
		1052,
		{
			RTResTalkAction[147],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33033026] = {
		33033026,
		0,
		Lang.get(84288),
		33033,
		26,
		1069,
		{
			RTResTalkAction[29],
			RTResTalkAction[148]
		},
		nil,
		nil,
		3
	},
	[33033027] = {
		33033027,
		2,
		Lang.get(84289),
		33033,
		27,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		33163,
		nil,
		1,
		nil,
		nil,
		nil,
		33163
	},
	[33035001] = {
		33035001,
		0,
		Lang.get(83925),
		33035,
		1,
		1071,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		33165,
		nil,
		1,
		nil,
		1,
		nil,
		33165,
		255
	},
	[33035002] = {
		33035002,
		0,
		Lang.get(84290),
		33035,
		2,
		1071,
		nil,
		1,
		[20] = 255
	},
	[33035003] = {
		33035003,
		0,
		Lang.get(84291),
		33035,
		3,
		1069,
		nil,
		1,
		[20] = -1
	},
	[33035004] = {
		33035004,
		0,
		Lang.get(84292),
		33035,
		4,
		1071,
		{
			RTResTalkAction[100]
		},
		nil,
		nil,
		3
	},
	[33035005] = {
		33035005,
		0,
		Lang.get(84293),
		33035,
		5,
		1069,
		{
			RTResTalkAction[29],
			RTResTalkAction[97]
		},
		nil,
		nil,
		3
	},
	[33035006] = {
		33035006,
		0,
		Lang.get(84294),
		33035,
		6,
		1071,
		{
			RTResTalkAction[100],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33035007] = {
		33035007,
		0,
		Lang.get(84295),
		33035,
		7,
		1071,
		{
			RTResTalkAction[94]
		},
		nil,
		nil,
		3
	},
	[33035008] = {
		33035008,
		0,
		Lang.get(84296),
		33035,
		8,
		1069,
		{
			RTResTalkAction[73],
			RTResTalkAction[97]
		},
		nil,
		nil,
		3
	},
	[33035009] = {
		33035009,
		0,
		Lang.get(84297),
		33035,
		9,
		1071,
		{
			RTResTalkAction[94],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33035010] = {
		33035010,
		0,
		Lang.get(84298),
		33035,
		10,
		1071,
		{
			RTResTalkAction[94]
		},
		nil,
		nil,
		3
	},
	[33035011] = {
		33035011,
		0,
		Lang.get(84299),
		33035,
		11,
		1071,
		{
			RTResTalkAction[94]
		},
		nil,
		nil,
		3
	},
	[33035012] = {
		33035012,
		0,
		Lang.get(84300),
		33035,
		12,
		1071,
		{
			RTResTalkAction[94]
		},
		nil,
		nil,
		3
	},
	[33035013] = {
		33035013,
		0,
		Lang.get(84301),
		33035,
		13,
		1069,
		{
			RTResTalkAction[73],
			RTResTalkAction[97]
		},
		nil,
		nil,
		3
	},
	[33035014] = {
		33035014,
		0,
		Lang.get(84302),
		33035,
		14,
		1071,
		{
			RTResTalkAction[94],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33035015] = {
		33035015,
		0,
		Lang.get(84303),
		33035,
		15,
		1069,
		{
			RTResTalkAction[97]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		33170,
		nil,
		1,
		nil,
		1,
		nil,
		33170
	},
	[33035016] = {
		33035016,
		3,
		Lang.get(84304),
		33035,
		16,
		605,
		[22] = 1
	},
	[33035017] = {
		33035017,
		0,
		Lang.get(84305),
		33035,
		17,
		1069,
		nil,
		nil,
		nil,
		nil,
		nil,
		47,
		33171,
		nil,
		1,
		nil,
		nil,
		nil,
		33171
	},
	[33035018] = {
		33035018,
		0,
		Lang.get(84306),
		33035,
		18,
		1077,
		{
			RTResTalkAction[151]
		},
		nil,
		nil,
		3
	},
	[33035019] = {
		33035019,
		0,
		Lang.get(84307),
		33035,
		19,
		1077,
		{
			RTResTalkAction[151]
		},
		nil,
		nil,
		3
	},
	[33035020] = {
		33035020,
		0,
		Lang.get(84308),
		33035,
		20,
		1078,
		{
			RTResTalkAction[152],
			RTResTalkAction[153]
		},
		nil,
		nil,
		3
	},
	[33035021] = {
		33035021,
		5,
		Lang.get(84309),
		33035,
		21,
		1069,
		{
			RTResTalkAction[60],
			RTResTalkAction[154],
			RTResTalkAction[141]
		},
		nil,
		nil,
		3
	},
	[33036001] = {
		33036001,
		0,
		Lang.get(84310),
		33036,
		1,
		1069,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		33172,
		nil,
		1,
		nil,
		nil,
		nil,
		33172
	},
	[33036002] = {
		33036002,
		0,
		Lang.get(84311),
		33036,
		2,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33038001] = {
		33038001,
		0,
		Lang.get(84312),
		33038,
		1,
		1069,
		nil,
		1,
		nil,
		nil,
		nil,
		58,
		33173,
		nil,
		1,
		nil,
		nil,
		nil,
		33173
	},
	[33038002] = {
		33038002,
		0,
		Lang.get(84313),
		33038,
		2,
		1069,
		nil,
		1
	},
	[33038003] = {
		33038003,
		0,
		Lang.get(84314),
		33038,
		3,
		1069,
		nil,
		1
	},
	[33038004] = {
		33038004,
		0,
		Lang.get(84315),
		33038,
		4,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33038005] = {
		33038005,
		0,
		Lang.get(84316),
		33038,
		5,
		1069,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33038006] = {
		33038006,
		0,
		Lang.get(84317),
		33038,
		6,
		107,
		{
			RTResTalkAction[23]
		},
		1,
		5,
		nil,
		nil,
		62,
		33174,
		nil,
		1,
		nil,
		nil,
		nil,
		33174
	},
	[33038007] = {
		33038007,
		0,
		Lang.get(84318),
		33038,
		7,
		133,
		nil,
		1,
		2
	},
	[33038008] = {
		33038008,
		0,
		Lang.get(85409),
		33038,
		8,
		133,
		nil,
		1,
		2
	},
	[33038009] = {
		33038009,
		0,
		Lang.get(84320),
		33038,
		9,
		133,
		{
			RTResTalkAction[93]
		},
		nil,
		nil,
		3
	},
	[33038010] = {
		33038010,
		0,
		Lang.get(84321),
		33038,
		10,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[18]
		},
		nil,
		nil,
		3
	},
	[33038011] = {
		33038011,
		0,
		Lang.get(84322),
		33038,
		11,
		1069,
		{
			RTResTalkAction[73],
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[33038012] = {
		33038012,
		0,
		Lang.get(84323),
		33038,
		12,
		141,
		{
			RTResTalkAction[43],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33038013] = {
		33038013,
		0,
		Lang.get(84324),
		33038,
		13,
		141,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		3
	},
	[33038014] = {
		33038014,
		0,
		Lang.get(84325),
		33038,
		14,
		1069,
		{
			RTResTalkAction[29],
			RTResTalkAction[27]
		},
		nil,
		nil,
		3
	},
	[33038015] = {
		33038015,
		0,
		Lang.get(84326),
		33038,
		15,
		1069,
		{
			RTResTalkAction[60]
		},
		nil,
		nil,
		3
	},
	[33038016] = {
		33038016,
		0,
		Lang.get(84327),
		33038,
		16,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33038017] = {
		33038017,
		0,
		Lang.get(84328),
		33038,
		17,
		141,
		{
			RTResTalkAction[43],
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[33038018] = {
		33038018,
		0,
		Lang.get(84329),
		33038,
		18,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[27]
		},
		nil,
		nil,
		3
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
