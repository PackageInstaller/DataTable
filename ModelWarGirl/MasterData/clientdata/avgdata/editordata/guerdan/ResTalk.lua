-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\guerdan\\ResTalk.lua

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
	1,
	338,
	nil,
	nil,
	2
}
RTResTalkAction[2] = {
	[1] = 1,
	[2] = 638
}
RTResTalkAction[3] = {
	[1] = 0,
	[2] = 338
}
RTResTalkAction[4] = {
	1,
	338,
	nil,
	nil,
	3
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 638
}
RTResTalkAction[6] = {
	[1] = 1,
	[2] = 338
}
RTResTalkAction[7] = {
	1,
	338,
	nil,
	nil,
	0
}
RTResTalkAction[8] = {
	[1] = 1,
	[2] = 338,
	[3] = {
		1
	}
}
RTResTalkAction[9] = {
	[1] = 1,
	[2] = 338,
	[3] = {
		2
	}
}
RTResTalkAction[10] = {
	1,
	338,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[11] = {
	1,
	638,
	nil,
	nil,
	0
}
RTResTalkAction[12] = {
	1,
	338,
	{
		1,
		1002
	},
	nil,
	2
}
RTResTalkAction[13] = {
	1,
	338,
	{
		1002
	},
	nil,
	0
}
RTResTalkAction[14] = {
	1,
	338,
	nil,
	nil,
	4
}
RTResTalkAction[15] = {
	1,
	188,
	{
		1
	},
	nil,
	4
}
RTResTalkAction[16] = {
	[1] = 0,
	[2] = 188
}
RTResTalkAction[17] = {
	1,
	188,
	nil,
	nil,
	3
}
RTResTalkAction[18] = {
	1,
	191,
	nil,
	nil,
	1
}
RTResTalkAction[19] = {
	[1] = 0,
	[2] = 191
}
RTResTalkAction[20] = {
	1,
	191,
	nil,
	nil,
	0
}
RTResTalkAction[21] = {
	[1] = 1,
	[2] = 191
}
RTResTalkAction[22] = {
	1,
	188,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[23] = {
	1,
	188,
	nil,
	nil,
	1
}
RTResTalkAction[24] = {
	1,
	188,
	nil,
	nil,
	0
}
RTResTalkAction[25] = {
	[1] = 1,
	[2] = 188
}
RTResTalkAction[26] = {
	[1] = 1,
	[2] = 189
}
RTResTalkAction[27] = {
	[1] = 1,
	[2] = 189,
	[3] = {
		3
	}
}
RTResTalkAction[28] = {
	1,
	189,
	nil,
	nil,
	1
}
RTResTalkAction[29] = {
	1,
	190,
	nil,
	nil,
	1
}
RTResTalkAction[30] = {
	[1] = 0,
	[2] = 189
}
RTResTalkAction[31] = {
	[1] = 0,
	[2] = 190
}
RTResTalkAction[32] = {
	1,
	190,
	{
		1001
	},
	nil,
	0
}
RTResTalkAction[33] = {
	[1] = 1,
	[2] = 189,
	[3] = {
		1003
	}
}
RTResTalkAction[34] = {
	1,
	190,
	nil,
	nil,
	0
}
RTResTalkAction[35] = {
	[1] = 1,
	[2] = 189,
	[3] = {
		2
	}
}
RTResTalkAction[36] = {
	[1] = 1,
	[2] = 190,
	[3] = {
		1001
	}
}
RTResTalkAction[37] = {
	[1] = 1,
	[2] = 189,
	[3] = {
		1002
	}
}
RTResTalkAction[38] = {
	[1] = 1,
	[2] = 190
}
RTResTalkAction[39] = {
	[1] = 1,
	[2] = 189,
	[3] = {
		2,
		1003
	}
}
RTResTalkAction[40] = {
	1,
	190,
	{
		1002
	},
	nil,
	1
}
RTResTalkAction[41] = {
	1,
	189,
	{
		1004
	},
	nil,
	0
}
RTResTalkAction[42] = {
	[1] = 1,
	[2] = 189,
	[3] = {
		1001
	}
}
RTResTalkAction[43] = {
	[1] = 1,
	[2] = 181
}
RTResTalkAction[44] = {
	[1] = 0,
	[2] = 181
}
RTResTalkAction[45] = {
	[1] = 1,
	[2] = 181,
	[3] = {
		1002
	}
}
RTResTalkAction[46] = {
	1,
	181,
	nil,
	nil,
	4
}
RTResTalkAction[47] = {
	1,
	181,
	nil,
	nil,
	3
}
RTResTalkAction[48] = {
	1,
	190,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[49] = {
	[1] = 1,
	[2] = 189,
	[3] = {
		1004
	}
}
RTResTalkAction[50] = {
	[1] = 1,
	[2] = 189,
	[3] = {
		1
	}
}
RTResTalkAction[51] = {
	1,
	181,
	nil,
	nil,
	0
}
RTResTalkAction[52] = {
	1,
	190,
	{
		1005
	},
	nil,
	0
}
RTResTalkAction[53] = {
	[1] = 1,
	[2] = 189,
	[3] = {
		1005
	}
}
RTResTalkAction[54] = {
	[1] = 1,
	[2] = 189,
	[3] = {
		2,
		1005
	}
}
RTResTalkAction[55] = {
	1,
	338,
	nil,
	nil,
	1
}
RTResTalkAction[56] = {
	1,
	189,
	nil,
	nil,
	0
}
RTResTalkAction[57] = {
	[1] = 1,
	[2] = 338,
	[3] = {
		2,
		1003
	}
}
RTResTalkAction[58] = {
	1,
	188,
	{
		11002
	},
	nil,
	1
}
RTResTalkAction[59] = {
	1,
	188,
	{
		1004
	},
	nil,
	2
}
RTResTalkAction[60] = {
	1,
	188,
	{
		1,
		1002
	},
	nil,
	4
}
RTResTalkAction[61] = {
	1,
	188,
	nil,
	nil,
	4
}
RTResTalkAction[62] = {
	[1] = 1,
	[2] = 190,
	[3] = {
		1002
	}
}
RTResTalkAction[63] = {
	[1] = 1,
	[2] = 191,
	[3] = {
		1
	}
}
RTResTalkAction[64] = {
	1,
	188,
	{
		1005
	},
	nil,
	1
}
RTResTalkAction[65] = {
	[1] = 1,
	[2] = 336,
	[3] = {
		10071
	}
}
RTResTalkAction[66] = {
	[1] = 0,
	[2] = 336
}
RTResTalkAction[67] = {
	[1] = 1,
	[2] = 639
}
RTResTalkAction[68] = {
	[1] = 0,
	[2] = 639
}
RTResTalkAction[69] = {
	[1] = 1,
	[2] = 191,
	[3] = {
		1001
	}
}
RTResTalkAction[70] = {
	1,
	188,
	{
		1005
	},
	nil,
	3
}
RTResTalkAction[71] = {
	1,
	338,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[72] = {
	1,
	191,
	{
		1003
	},
	nil,
	1
}
RTResTalkAction[73] = {
	[1] = 1,
	[2] = 337,
	[3] = {
		3
	}
}
RTResTalkAction[74] = {
	[1] = 0,
	[2] = 337
}
RTResTalkAction[75] = {
	[1] = 1,
	[2] = 337
}
RTResTalkAction[76] = {
	[1] = 1,
	[2] = 337,
	[3] = {
		1
	}
}
RTResTalkAction[77] = {
	1,
	190,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[78] = {
	1,
	188,
	{
		2
	},
	nil,
	4
}
RTResTalkAction[79] = {
	1,
	338,
	{
		1
	},
	nil,
	3
}
RTResTalkAction[80] = {
	1,
	188,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[81] = {
	1,
	188,
	{
		1001
	},
	nil,
	2
}
RTResTalkAction[82] = {
	[1] = 1,
	[2] = 188,
	[3] = {
		1002
	}
}
RTResTalkAction[83] = {
	[1] = 1,
	[2] = 644
}
RTResTalkAction[84] = {
	[1] = 0,
	[2] = 644
}
RTResTalkAction[85] = {
	1,
	338,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[86] = {
	1,
	141,
	nil,
	nil,
	1
}
RTResTalkAction[87] = {
	1,
	107,
	{
		1,
		10031
	},
	nil,
	5
}
RTResTalkAction[88] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[89] = {
	1,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[90] = {
	1,
	107,
	nil,
	nil,
	7
}
RTResTalkAction[91] = {
	1,
	107,
	{
		2,
		10031
	},
	nil,
	5
}
RTResTalkAction[92] = {
	1,
	107,
	nil,
	nil,
	0
}
RTResTalkAction[93] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[94] = {
	1,
	141,
	{
		10012
	},
	nil,
	0
}
RTResTalkAction[95] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[96] = {
	1,
	107,
	{
		1,
		10021
	},
	nil,
	7
}
RTResTalkAction[97] = {
	[1] = 1,
	[2] = 141
}
RTResTalkAction[98] = {
	1,
	107,
	{
		1,
		10031
	},
	nil,
	0
}
RTResTalkAction[99] = {
	1,
	141,
	{
		1002
	},
	nil,
	1
}
RTResTalkAction[100] = {
	1,
	107,
	{
		1
	},
	nil,
	3
}
RTResTalkAction[101] = {
	1,
	107,
	nil,
	nil,
	5
}
RTResTalkAction[102] = {
	1,
	107,
	{
		10031
	},
	nil,
	5
}
RTResTalkAction[103] = {
	1,
	107,
	{
		10011
	},
	nil,
	3
}
RTResTalkAction[104] = {
	1,
	107,
	{
		1,
		10031
	},
	nil,
	7
}
RTResTalkAction[105] = {
	1,
	188,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[106] = {
	1,
	188,
	nil,
	nil,
	2
}
RTResTalkAction[107] = {
	[1] = 1,
	[2] = 337,
	[3] = {
		1002
	}
}
RTResTalkAction[108] = {
	1,
	337,
	{
		1001
	},
	nil,
	0
}
RTResTalkAction[109] = {
	[1] = 1,
	[2] = 191,
	[3] = {
		1003
	}
}
RTResTalkAction[110] = {
	[1] = 1,
	[2] = 191,
	[3] = {
		2
	}
}
RTResTalkAction[111] = {
	[1] = 1,
	[2] = 188,
	[3] = {
		2,
		1003
	}
}
RTResTalkAction[112] = {
	1,
	188,
	{
		2,
		1002
	},
	nil,
	1
}
RTResTalkAction[113] = {
	[1] = 1,
	[2] = 103
}
RTResTalkAction[114] = {
	[1] = 1,
	[2] = 135
}
RTResTalkAction[115] = {
	[1] = 0,
	[2] = 103
}
RTResTalkAction[116] = {
	[1] = 0,
	[2] = 135
}
RTResTalkAction[117] = {
	[1] = 1,
	[2] = 110
}
RTResTalkAction[118] = {
	[1] = 0,
	[2] = 110
}
RTResTalkAction[119] = {
	[1] = 2,
	[2] = 645
}
RTResTalkAction[120] = {
	[1] = 3,
	[2] = 646
}
RTResTalkAction[121] = {
	1,
	189,
	{
		1,
		1002
	},
	nil,
	1
}
RTResTalkAction[122] = {
	[1] = 0,
	[2] = 645
}
RTResTalkAction[123] = {
	[1] = 0,
	[2] = 646
}
RTResTalkAction[124] = {
	[1] = 1,
	[2] = 646
}
RTResTalkAction[125] = {
	[1] = 1,
	[2] = 645
}
RTResTalkAction[126] = {
	[1] = 2,
	[2] = 647
}
RTResTalkAction[127] = {
	[1] = 3,
	[2] = 648
}
RTResTalkAction[128] = {
	[1] = 2,
	[2] = 649
}
RTResTalkAction[129] = {
	[1] = 3,
	[2] = 650
}
RTResTalkAction[130] = {
	[1] = 0,
	[2] = 647
}
RTResTalkAction[131] = {
	[1] = 0,
	[2] = 648
}
RTResTalkAction[132] = {
	[1] = 0,
	[2] = 649
}
RTResTalkAction[133] = {
	[1] = 0,
	[2] = 650
}
RTResTalkAction[134] = {
	[1] = 1,
	[2] = 647
}
RTResTalkAction[135] = {
	1,
	191,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[136] = {
	1,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[137] = {
	[1] = 1,
	[2] = 300
}
RTResTalkAction[138] = {
	[1] = 0,
	[2] = 300
}
RTResTalkAction[139] = {
	[1] = 1,
	[2] = 187
}
RTResTalkAction[140] = {
	1,
	107,
	nil,
	nil,
	10
}
RTResTalkAction[141] = {
	[1] = 0,
	[2] = 187
}
RTResTalkAction[142] = {
	1,
	141,
	nil,
	nil,
	0
}
RTResTalkAction[143] = {
	1,
	187,
	nil,
	nil,
	1
}
RTResTalkAction[144] = {
	1,
	187,
	nil,
	nil,
	4
}
RTResTalkAction[145] = {
	1,
	187,
	nil,
	nil,
	0
}
RTResTalkAction[146] = {
	1,
	187,
	nil,
	nil,
	3
}
RTResTalkAction[147] = {
	1,
	107,
	nil,
	nil,
	3
}
RTResTalkAction[148] = {
	1,
	107,
	nil,
	nil,
	4
}
RTResTalkAction[149] = {
	1,
	107,
	nil,
	nil,
	2
}
RTResTalkAction[150] = {
	1,
	107,
	nil,
	nil,
	9
}
RTResTalkAction[151] = {
	1,
	187,
	nil,
	nil,
	2
}
RTResTalkAction[152] = {
	[1] = 1,
	[2] = 339
}
RTResTalkAction[153] = {
	[1] = 0,
	[2] = 339
}
RTResTalkAction[154] = {
	[1] = 1,
	[2] = 340
}
RTResTalkAction[155] = {
	1,
	107,
	nil,
	nil,
	1
}
RTResTalkAction[156] = {
	[1] = 0,
	[2] = 340
}
RTResTalkAction[157] = {
	[1] = 1,
	[2] = 341
}
RTResTalkAction[158] = {
	[1] = 0,
	[2] = 341
}
RTResTalkAction[159] = {
	1,
	187,
	{
		1
	},
	nil,
	0
}

local Data = {
	[16000001] = {
		16000001,
		9,
		Lang.get(24598),
		16000,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		44,
		[22] = 1,
		[20] = 255
	},
	[16000002] = {
		16000002,
		7,
		"41",
		16000,
		2,
		605,
		nil,
		nil,
		nil,
		5,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[16000003] = {
		16000003,
		9,
		Lang.get(24599),
		16000,
		3,
		605,
		nil,
		nil,
		nil,
		-1,
		[22] = 1
	},
	[16000004] = {
		16000004,
		9,
		Lang.get(24600),
		16000,
		4,
		605,
		[22] = 1
	},
	[16000005] = {
		16000005,
		9,
		Lang.get(24601),
		16000,
		5,
		605,
		[22] = 1
	},
	[16000006] = {
		16000006,
		9,
		Lang.get(24602),
		16000,
		6,
		605,
		[22] = 1
	},
	[16000007] = {
		16000007,
		9,
		Lang.get(24603),
		16000,
		7,
		605,
		[22] = 1
	},
	[16000008] = {
		16000008,
		9,
		Lang.get(24604),
		16000,
		8,
		605,
		[22] = 1
	},
	[16000009] = {
		16000009,
		5,
		Lang.get(24605),
		16000,
		9,
		638,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		16000,
		nil,
		nil,
		nil,
		1,
		nil,
		16000,
		-1
	},
	[16000010] = {
		16000010,
		0,
		Lang.get(24606),
		16000,
		10,
		338,
		nil,
		1
	},
	[16000011] = {
		16000011,
		0,
		Lang.get(24607),
		16000,
		11,
		638,
		nil,
		1
	},
	[16000012] = {
		16000012,
		0,
		Lang.get(24608),
		16000,
		12,
		338,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[16000013] = {
		16000013,
		0,
		Lang.get(24609),
		16000,
		13,
		638,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[16000014] = {
		16000014,
		0,
		Lang.get(24610),
		16000,
		14,
		338,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[16000015] = {
		16000015,
		0,
		Lang.get(24611),
		16000,
		15,
		338,
		{
			RTResTalkAction[6]
		}
	},
	[16000016] = {
		16000016,
		0,
		Lang.get(24612),
		16000,
		16,
		338,
		{
			RTResTalkAction[7]
		}
	},
	[16000017] = {
		16000017,
		0,
		Lang.get(61753),
		16000,
		17,
		638,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[16000018] = {
		16000018,
		0,
		Lang.get(24613),
		16000,
		18,
		338,
		{
			RTResTalkAction[6],
			RTResTalkAction[5]
		}
	},
	[16000019] = {
		16000019,
		0,
		Lang.get(24614),
		16000,
		19,
		338,
		{
			RTResTalkAction[6]
		}
	},
	[16000020] = {
		16000020,
		0,
		"……",
		16000,
		20,
		638,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[16000021] = {
		16000021,
		0,
		Lang.get(24615),
		16000,
		21,
		638,
		{
			RTResTalkAction[2]
		}
	},
	[16000022] = {
		16000022,
		0,
		Lang.get(24616),
		16000,
		22,
		638,
		{
			RTResTalkAction[2]
		}
	},
	[16000023] = {
		16000023,
		0,
		Lang.get(24617),
		16000,
		23,
		338,
		{
			RTResTalkAction[8],
			RTResTalkAction[5]
		}
	},
	[16000024] = {
		16000024,
		0,
		Lang.get(24618),
		16000,
		24,
		338,
		{
			RTResTalkAction[6]
		}
	},
	[16000025] = {
		16000025,
		0,
		Lang.get(24619),
		16000,
		25,
		638,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[16000026] = {
		16000026,
		0,
		Lang.get(24620),
		16000,
		26,
		638,
		{
			RTResTalkAction[2]
		}
	},
	[16000027] = {
		16000027,
		0,
		Lang.get(24621),
		16000,
		27,
		638,
		{
			RTResTalkAction[2]
		}
	},
	[16000028] = {
		16000028,
		0,
		Lang.get(24622),
		16000,
		28,
		638,
		{
			RTResTalkAction[2]
		}
	},
	[16000029] = {
		16000029,
		0,
		Lang.get(24623),
		16000,
		29,
		338,
		{
			RTResTalkAction[9],
			RTResTalkAction[5]
		}
	},
	[16039001] = {
		16039001,
		0,
		Lang.get(25907),
		16039,
		1,
		338,
		nil,
		1,
		nil,
		nil,
		nil,
		44,
		16080,
		nil,
		nil,
		nil,
		1,
		nil,
		16080
	},
	[16039002] = {
		16039002,
		0,
		Lang.get(25908),
		16039,
		2,
		638,
		nil,
		1
	},
	[16039003] = {
		16039003,
		0,
		Lang.get(25909),
		16039,
		3,
		338,
		{
			RTResTalkAction[6]
		},
		nil,
		nil,
		3
	},
	[16039004] = {
		16039004,
		0,
		Lang.get(25910),
		16039,
		4,
		638,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[16039005] = {
		16039005,
		0,
		Lang.get(25911),
		16039,
		5,
		638,
		{
			RTResTalkAction[2]
		}
	},
	[16039006] = {
		16039006,
		0,
		Lang.get(25912),
		16039,
		6,
		338,
		{
			RTResTalkAction[10],
			RTResTalkAction[5]
		}
	},
	[16039007] = {
		16039007,
		0,
		Lang.get(25913),
		16039,
		7,
		338,
		{
			RTResTalkAction[6]
		}
	},
	[16039008] = {
		16039008,
		0,
		Lang.get(25914),
		16039,
		8,
		638,
		{
			RTResTalkAction[11],
			RTResTalkAction[3]
		}
	},
	[16039009] = {
		16039009,
		0,
		Lang.get(25915),
		16039,
		9,
		338,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[16039010] = {
		16039010,
		0,
		Lang.get(25916),
		16039,
		10,
		638,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[16039011] = {
		16039011,
		0,
		Lang.get(25917),
		16039,
		11,
		338,
		{
			RTResTalkAction[7],
			RTResTalkAction[5]
		}
	},
	[16039012] = {
		16039012,
		0,
		Lang.get(25918),
		16039,
		12,
		338,
		{
			RTResTalkAction[12]
		}
	},
	[16039013] = {
		16039013,
		0,
		Lang.get(25919),
		16039,
		13,
		338,
		{
			RTResTalkAction[3]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		16082,
		nil,
		1,
		nil,
		1,
		nil,
		16082
	},
	[16039014] = {
		16039014,
		0,
		Lang.get(25920),
		16039,
		14,
		338,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		3
	},
	[16039015] = {
		16039015,
		0,
		Lang.get(25921),
		16039,
		15,
		338,
		{
			RTResTalkAction[6]
		}
	},
	[16039016] = {
		16039016,
		0,
		Lang.get(25922),
		16039,
		16,
		338,
		{
			RTResTalkAction[14]
		}
	},
	[16039017] = {
		16039017,
		9,
		Lang.get(70086),
		16039,
		17,
		605,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		nil,
		nil,
		115,
		nil,
		nil,
		1,
		nil,
		1,
		nil,
		16001,
		nil,
		nil,
		1
	},
	[16039018] = {
		16039018,
		0,
		Lang.get(25924),
		16039,
		18,
		188,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		16081,
		[19] = 16081,
		[17] = 1
	},
	[16039019] = {
		16039019,
		0,
		Lang.get(25925),
		16039,
		19,
		188,
		nil,
		1
	},
	[16039020] = {
		16039020,
		0,
		Lang.get(25926),
		16039,
		20,
		188,
		{
			RTResTalkAction[15]
		},
		nil,
		nil,
		3
	},
	[16039021] = {
		16039021,
		7,
		"43",
		16039,
		21,
		188,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		5,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[16039022] = {
		16039022,
		0,
		Lang.get(25927),
		16039,
		22,
		188,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[16039023] = {
		16039023,
		0,
		Lang.get(25928),
		16039,
		23,
		191,
		{
			RTResTalkAction[18],
			RTResTalkAction[16]
		}
	},
	[16039024] = {
		16039024,
		7,
		"42",
		16039,
		24,
		191,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		5,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[16039025] = {
		16039025,
		0,
		Lang.get(25929),
		16039,
		25,
		191,
		{
			RTResTalkAction[20]
		},
		nil,
		nil,
		3
	},
	[16039026] = {
		16039026,
		0,
		Lang.get(25930),
		16039,
		26,
		188,
		{
			RTResTalkAction[15],
			RTResTalkAction[19]
		}
	},
	[16039027] = {
		16039027,
		0,
		Lang.get(25931),
		16039,
		27,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[16]
		}
	},
	[16039028] = {
		16039028,
		0,
		Lang.get(25932),
		16039,
		28,
		188,
		{
			RTResTalkAction[22],
			RTResTalkAction[19]
		}
	},
	[16039029] = {
		16039029,
		0,
		Lang.get(25933),
		16039,
		29,
		188,
		{
			RTResTalkAction[23]
		}
	},
	[16039030] = {
		16039030,
		0,
		Lang.get(25934),
		16039,
		30,
		191,
		{
			RTResTalkAction[18],
			RTResTalkAction[16]
		}
	},
	[16039031] = {
		16039031,
		0,
		Lang.get(25935),
		16039,
		31,
		188,
		{
			RTResTalkAction[24],
			RTResTalkAction[19]
		}
	},
	[16039032] = {
		16039032,
		0,
		Lang.get(25936),
		16039,
		32,
		191,
		{
			RTResTalkAction[18],
			RTResTalkAction[16]
		}
	},
	[16039033] = {
		16039033,
		0,
		Lang.get(25937),
		16039,
		33,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[19]
		}
	},
	[16039034] = {
		16039034,
		0,
		Lang.get(25938),
		16039,
		34,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16039035] = {
		16039035,
		0,
		Lang.get(25939),
		16039,
		35,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[16]
		}
	},
	[16039036] = {
		16039036,
		0,
		Lang.get(25940),
		16039,
		36,
		188,
		{
			RTResTalkAction[24],
			RTResTalkAction[19]
		}
	},
	[16039037] = {
		16039037,
		0,
		Lang.get(25941),
		16039,
		37,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[16]
		}
	},
	[16001001] = {
		16001001,
		9,
		"JingleBells~♩JingleBells~♪Jinglealltheway~♫",
		16001,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		115,
		nil,
		nil,
		nil,
		nil,
		1,
		nil,
		16001,
		nil,
		nil,
		1
	},
	[16001002] = {
		16001002,
		9,
		Lang.get(24624),
		16001,
		2,
		[22] = 1
	},
	[16001003] = {
		16001003,
		9,
		Lang.get(24625),
		16001,
		3,
		[22] = 1
	},
	[16001004] = {
		16001004,
		9,
		Lang.get(24626),
		16001,
		4,
		[22] = 1
	},
	[16001005] = {
		16001005,
		9,
		Lang.get(24627),
		16001,
		5,
		[22] = 1
	},
	[16001006] = {
		16001006,
		9,
		Lang.get(24628),
		16001,
		6,
		[22] = 1
	},
	[16001007] = {
		16001007,
		9,
		Lang.get(24629),
		16001,
		7,
		[22] = 1
	},
	[16001008] = {
		16001008,
		0,
		Lang.get(24630),
		16001,
		8,
		190,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		16002,
		[19] = 16002,
		[17] = 1
	},
	[16001009] = {
		16001009,
		7,
		"44",
		16001,
		9,
		190,
		nil,
		nil,
		nil,
		5,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[16001010] = {
		16001010,
		0,
		Lang.get(24631),
		16001,
		10,
		189,
		nil,
		1,
		nil,
		-1
	},
	[16001011] = {
		16001011,
		7,
		"45",
		16001,
		11,
		189,
		nil,
		nil,
		nil,
		5,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[16001012] = {
		16001012,
		0,
		Lang.get(24632),
		16001,
		12,
		190,
		nil,
		1,
		nil,
		-1
	},
	[16001013] = {
		16001013,
		0,
		Lang.get(24633),
		16001,
		13,
		190,
		nil,
		1
	},
	[16001014] = {
		16001014,
		0,
		Lang.get(24634),
		16001,
		14,
		189,
		nil,
		1
	},
	[16001015] = {
		16001015,
		0,
		Lang.get(24635),
		16001,
		15,
		189,
		{
			RTResTalkAction[26]
		},
		nil,
		nil,
		3
	},
	[16001016] = {
		16001016,
		0,
		Lang.get(24636),
		16001,
		16,
		189,
		{
			RTResTalkAction[27]
		}
	},
	[16001017] = {
		16001017,
		0,
		Lang.get(24637),
		16001,
		17,
		189,
		{
			RTResTalkAction[28]
		}
	},
	[16001018] = {
		16001018,
		0,
		Lang.get(24638),
		16001,
		18,
		190,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		}
	},
	[16001019] = {
		16001019,
		0,
		Lang.get(24639),
		16001,
		19,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[31]
		}
	},
	[16001020] = {
		16001020,
		0,
		Lang.get(24640),
		16001,
		20,
		189,
		{
			RTResTalkAction[26]
		}
	},
	[16001021] = {
		16001021,
		0,
		Lang.get(61754),
		16001,
		21,
		190,
		{
			RTResTalkAction[32],
			RTResTalkAction[30]
		}
	},
	[16001022] = {
		16001022,
		0,
		Lang.get(24642),
		16001,
		22,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[31]
		}
	},
	[16001023] = {
		16001023,
		0,
		Lang.get(24643),
		16001,
		23,
		189,
		{
			RTResTalkAction[26]
		}
	},
	[16001024] = {
		16001024,
		0,
		Lang.get(24644),
		16001,
		24,
		190,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		}
	},
	[16001025] = {
		16001025,
		0,
		Lang.get(24645),
		16001,
		25,
		189,
		{
			RTResTalkAction[33],
			RTResTalkAction[31]
		}
	},
	[16001026] = {
		16001026,
		0,
		Lang.get(24646),
		16001,
		26,
		189,
		{
			RTResTalkAction[26]
		}
	},
	[16001027] = {
		16001027,
		0,
		Lang.get(24647),
		16001,
		27,
		190,
		{
			RTResTalkAction[34],
			RTResTalkAction[30]
		}
	},
	[16001028] = {
		16001028,
		0,
		Lang.get(24648),
		16001,
		28,
		189,
		{
			RTResTalkAction[35],
			RTResTalkAction[31]
		}
	},
	[16001029] = {
		16001029,
		0,
		Lang.get(24649),
		16001,
		29,
		189,
		{
			RTResTalkAction[26]
		}
	},
	[16001030] = {
		16001030,
		0,
		Lang.get(24650),
		16001,
		30,
		190,
		{
			RTResTalkAction[36],
			RTResTalkAction[30]
		}
	},
	[16001031] = {
		16001031,
		0,
		Lang.get(24651),
		16001,
		31,
		189,
		{
			RTResTalkAction[37],
			RTResTalkAction[31]
		}
	},
	[16001032] = {
		16001032,
		0,
		Lang.get(24652),
		16001,
		32,
		190,
		{
			RTResTalkAction[38],
			RTResTalkAction[30]
		}
	},
	[16001033] = {
		16001033,
		0,
		Lang.get(24653),
		16001,
		33,
		189,
		{
			RTResTalkAction[28],
			RTResTalkAction[31]
		}
	},
	[16001034] = {
		16001034,
		0,
		Lang.get(24654),
		16001,
		34,
		190,
		{
			RTResTalkAction[38],
			RTResTalkAction[30]
		}
	},
	[16001035] = {
		16001035,
		0,
		Lang.get(24655),
		16001,
		35,
		189,
		{
			RTResTalkAction[39],
			RTResTalkAction[31]
		}
	},
	[16001036] = {
		16001036,
		0,
		Lang.get(24656),
		16001,
		36,
		190,
		{
			RTResTalkAction[38],
			RTResTalkAction[30]
		}
	},
	[16001037] = {
		16001037,
		0,
		Lang.get(24657),
		16001,
		37,
		190,
		{
			RTResTalkAction[38]
		}
	},
	[16001038] = {
		16001038,
		0,
		Lang.get(24658),
		16001,
		38,
		190,
		{
			RTResTalkAction[40]
		}
	},
	[16001039] = {
		16001039,
		9,
		"—",
		16001,
		39,
		605,
		{
			RTResTalkAction[31]
		},
		[22] = 1
	},
	[16001040] = {
		16001040,
		9,
		"——",
		16001,
		40,
		605,
		[22] = 1
	},
	[16001041] = {
		16001041,
		9,
		Lang.get(24659),
		16001,
		41,
		605,
		[22] = 1
	},
	[16001042] = {
		16001042,
		0,
		Lang.get(24660),
		16001,
		42,
		189,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		16062,
		[19] = 16062,
		[17] = 1
	},
	[16001043] = {
		16001043,
		0,
		Lang.get(24661),
		16001,
		43,
		189,
		{
			RTResTalkAction[41]
		},
		nil,
		nil,
		3
	},
	[16001044] = {
		16001044,
		0,
		Lang.get(24662),
		16001,
		44,
		189,
		{
			RTResTalkAction[26]
		}
	},
	[16001045] = {
		16001045,
		0,
		Lang.get(24663),
		16001,
		45,
		189,
		{
			RTResTalkAction[42]
		}
	},
	[16001046] = {
		16001046,
		0,
		Lang.get(24664),
		16001,
		46,
		181,
		{
			RTResTalkAction[43],
			RTResTalkAction[30]
		}
	},
	[16001047] = {
		16001047,
		0,
		Lang.get(24665),
		16001,
		47,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[44]
		}
	},
	[16001048] = {
		16001048,
		0,
		Lang.get(24666),
		16001,
		48,
		181,
		{
			RTResTalkAction[45],
			RTResTalkAction[30]
		}
	},
	[16001049] = {
		16001049,
		0,
		Lang.get(24667),
		16001,
		49,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[44]
		}
	},
	[16001050] = {
		16001050,
		0,
		Lang.get(24668),
		16001,
		50,
		189,
		{
			RTResTalkAction[26]
		}
	},
	[16001051] = {
		16001051,
		0,
		Lang.get(61755),
		16001,
		51,
		181,
		{
			RTResTalkAction[46],
			RTResTalkAction[30]
		}
	},
	[16001052] = {
		16001052,
		0,
		Lang.get(24669),
		16001,
		52,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[44]
		}
	},
	[16001053] = {
		16001053,
		0,
		Lang.get(24670),
		16001,
		53,
		181,
		{
			RTResTalkAction[47],
			RTResTalkAction[30]
		}
	},
	[16001054] = {
		16001054,
		0,
		Lang.get(24671),
		16001,
		54,
		181,
		{
			RTResTalkAction[43]
		}
	},
	[16001055] = {
		16001055,
		0,
		Lang.get(24672),
		16001,
		55,
		190,
		{
			RTResTalkAction[48],
			RTResTalkAction[44]
		}
	},
	[16001056] = {
		16001056,
		0,
		Lang.get(24673),
		16001,
		56,
		189,
		{
			RTResTalkAction[49],
			RTResTalkAction[31]
		}
	},
	[16001057] = {
		16001057,
		0,
		Lang.get(24674),
		16001,
		57,
		189,
		{
			RTResTalkAction[26]
		}
	},
	[16001058] = {
		16001058,
		0,
		Lang.get(61756),
		16001,
		58,
		189,
		{
			RTResTalkAction[37]
		}
	},
	[16001059] = {
		16001059,
		0,
		Lang.get(24675),
		16001,
		59,
		190,
		{
			RTResTalkAction[38],
			RTResTalkAction[30]
		}
	},
	[16001060] = {
		16001060,
		0,
		Lang.get(61757),
		16001,
		60,
		181,
		{
			RTResTalkAction[43],
			RTResTalkAction[31]
		}
	},
	[16001061] = {
		16001061,
		0,
		Lang.get(24676),
		16001,
		61,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[44]
		}
	},
	[16001062] = {
		16001062,
		0,
		Lang.get(24677),
		16001,
		62,
		189,
		{
			RTResTalkAction[50]
		}
	},
	[16001063] = {
		16001063,
		0,
		Lang.get(24678),
		16001,
		63,
		181,
		{
			RTResTalkAction[51],
			RTResTalkAction[30]
		}
	},
	[16001064] = {
		16001064,
		0,
		Lang.get(24679),
		16001,
		64,
		190,
		{
			RTResTalkAction[29],
			RTResTalkAction[44]
		}
	},
	[16001065] = {
		16001065,
		0,
		Lang.get(24680),
		16001,
		65,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[31]
		}
	},
	[16001066] = {
		16001066,
		0,
		Lang.get(24681),
		16001,
		66,
		189,
		{
			RTResTalkAction[26]
		}
	},
	[16001067] = {
		16001067,
		0,
		Lang.get(24682),
		16001,
		67,
		189,
		{
			RTResTalkAction[27]
		}
	},
	[16001068] = {
		16001068,
		0,
		Lang.get(24683),
		16001,
		68,
		189,
		{
			RTResTalkAction[30]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		16003,
		nil,
		1,
		nil,
		1,
		nil,
		16003
	},
	[16001069] = {
		16001069,
		0,
		Lang.get(24684),
		16001,
		69,
		181,
		nil,
		1
	},
	[16001070] = {
		16001070,
		0,
		"……",
		16001,
		70,
		190,
		{
			RTResTalkAction[52]
		},
		nil,
		nil,
		3
	},
	[16001071] = {
		16001071,
		0,
		"……",
		16001,
		71,
		189,
		{
			RTResTalkAction[42],
			RTResTalkAction[31]
		}
	},
	[16001072] = {
		16001072,
		0,
		Lang.get(24685),
		16001,
		72,
		338,
		{
			RTResTalkAction[1],
			RTResTalkAction[30]
		}
	},
	[16001073] = {
		16001073,
		0,
		Lang.get(24686),
		16001,
		73,
		189,
		{
			RTResTalkAction[53],
			RTResTalkAction[3]
		}
	},
	[16001074] = {
		16001074,
		0,
		Lang.get(24687),
		16001,
		74,
		338,
		{
			RTResTalkAction[4],
			RTResTalkAction[30]
		}
	},
	[16001075] = {
		16001075,
		0,
		Lang.get(24688),
		16001,
		75,
		189,
		{
			RTResTalkAction[35],
			RTResTalkAction[3]
		}
	},
	[16040001] = {
		16040001,
		0,
		Lang.get(25942),
		16040,
		1,
		189,
		nil,
		1,
		nil,
		nil,
		nil,
		115,
		16004,
		nil,
		nil,
		nil,
		1,
		nil,
		16004
	},
	[16040002] = {
		16040002,
		0,
		Lang.get(25943),
		16040,
		2,
		338,
		nil,
		1
	},
	[16040003] = {
		16040003,
		0,
		Lang.get(25944),
		16040,
		3,
		338,
		nil,
		1
	},
	[16040004] = {
		16040004,
		0,
		Lang.get(25945),
		16040,
		4,
		189,
		nil,
		1
	},
	[16040005] = {
		16040005,
		0,
		Lang.get(25946),
		16040,
		5,
		189,
		{
			RTResTalkAction[54]
		},
		nil,
		nil,
		3
	},
	[16040006] = {
		16040006,
		0,
		Lang.get(25947),
		16040,
		6,
		189,
		{
			RTResTalkAction[26]
		}
	},
	[16040007] = {
		16040007,
		0,
		Lang.get(25948),
		16040,
		7,
		338,
		{
			RTResTalkAction[7],
			RTResTalkAction[30]
		}
	},
	[16040008] = {
		16040008,
		0,
		Lang.get(25949),
		16040,
		8,
		338,
		{
			RTResTalkAction[55]
		}
	},
	[16040009] = {
		16040009,
		0,
		Lang.get(25950),
		16040,
		9,
		338,
		{
			RTResTalkAction[7]
		}
	},
	[16040010] = {
		16040010,
		0,
		Lang.get(25951),
		16040,
		10,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[3]
		}
	},
	[16040011] = {
		16040011,
		0,
		Lang.get(25952),
		16040,
		11,
		190,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		}
	},
	[16040012] = {
		16040012,
		0,
		Lang.get(25953),
		16040,
		12,
		189,
		{
			RTResTalkAction[28],
			RTResTalkAction[31]
		}
	},
	[16040013] = {
		16040013,
		0,
		Lang.get(61758),
		16040,
		13,
		181,
		{
			RTResTalkAction[43],
			RTResTalkAction[30]
		}
	},
	[16040014] = {
		16040014,
		0,
		Lang.get(61759),
		16040,
		14,
		190,
		{
			RTResTalkAction[38],
			RTResTalkAction[44]
		}
	},
	[16040015] = {
		16040015,
		0,
		Lang.get(25954),
		16040,
		15,
		189,
		{
			RTResTalkAction[39],
			RTResTalkAction[31]
		}
	},
	[16040016] = {
		16040016,
		0,
		Lang.get(25955),
		16040,
		16,
		189,
		{
			RTResTalkAction[53]
		}
	},
	[16040017] = {
		16040017,
		0,
		Lang.get(25956),
		16040,
		17,
		189,
		{
			RTResTalkAction[26]
		}
	},
	[16040018] = {
		16040018,
		0,
		Lang.get(25957),
		16040,
		18,
		338,
		{
			RTResTalkAction[6],
			RTResTalkAction[30]
		}
	},
	[16040019] = {
		16040019,
		0,
		Lang.get(25958),
		16040,
		19,
		189,
		{
			RTResTalkAction[56],
			RTResTalkAction[3]
		}
	},
	[16040020] = {
		16040020,
		0,
		Lang.get(25959),
		16040,
		20,
		338,
		{
			RTResTalkAction[6],
			RTResTalkAction[30]
		}
	},
	[16040021] = {
		16040021,
		0,
		Lang.get(25960),
		16040,
		21,
		189,
		{
			RTResTalkAction[37],
			RTResTalkAction[3]
		}
	},
	[16040022] = {
		16040022,
		0,
		Lang.get(25961),
		16040,
		22,
		189,
		{
			RTResTalkAction[26]
		}
	},
	[16040023] = {
		16040023,
		0,
		Lang.get(25962),
		16040,
		23,
		338,
		{
			RTResTalkAction[57],
			RTResTalkAction[30]
		}
	},
	[16040024] = {
		16040024,
		0,
		Lang.get(25963),
		16040,
		24,
		188,
		{
			RTResTalkAction[3]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		16005,
		nil,
		1,
		nil,
		1,
		nil,
		16005
	},
	[16040025] = {
		16040025,
		0,
		Lang.get(25964),
		16040,
		25,
		191,
		nil,
		1
	},
	[16040026] = {
		16040026,
		0,
		Lang.get(25965),
		16040,
		26,
		188,
		{
			RTResTalkAction[58]
		},
		nil,
		nil,
		3
	},
	[16040027] = {
		16040027,
		0,
		Lang.get(25966),
		16040,
		27,
		191,
		{
			RTResTalkAction[20],
			RTResTalkAction[16]
		}
	},
	[16040028] = {
		16040028,
		0,
		Lang.get(25967),
		16040,
		28,
		188,
		{
			RTResTalkAction[17],
			RTResTalkAction[19]
		}
	},
	[16040029] = {
		16040029,
		0,
		Lang.get(25968),
		16040,
		29,
		188,
		{
			RTResTalkAction[59]
		}
	},
	[16040030] = {
		16040030,
		0,
		Lang.get(25969),
		16040,
		30,
		191,
		{
			RTResTalkAction[18],
			RTResTalkAction[16]
		}
	},
	[16040031] = {
		16040031,
		0,
		Lang.get(25970),
		16040,
		31,
		188,
		{
			RTResTalkAction[24],
			RTResTalkAction[19]
		}
	},
	[16040032] = {
		16040032,
		0,
		Lang.get(25971),
		16040,
		32,
		188,
		{
			RTResTalkAction[60]
		}
	},
	[16040033] = {
		16040033,
		0,
		Lang.get(25972),
		16040,
		33,
		188,
		{
			RTResTalkAction[23]
		}
	},
	[16040034] = {
		16040034,
		0,
		Lang.get(25973),
		16040,
		34,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16040035] = {
		16040035,
		0,
		Lang.get(25974),
		16040,
		35,
		191,
		{
			RTResTalkAction[18],
			RTResTalkAction[16]
		}
	},
	[16040036] = {
		16040036,
		0,
		Lang.get(25975),
		16040,
		36,
		188,
		{
			RTResTalkAction[61],
			RTResTalkAction[19]
		}
	},
	[16040037] = {
		16040037,
		0,
		Lang.get(25976),
		16040,
		37,
		191,
		{
			RTResTalkAction[20],
			RTResTalkAction[16]
		}
	},
	[16040038] = {
		16040038,
		0,
		Lang.get(25977),
		16040,
		38,
		188,
		{
			RTResTalkAction[24],
			RTResTalkAction[19]
		}
	},
	[16040039] = {
		16040039,
		0,
		Lang.get(61760),
		16040,
		39,
		191,
		{
			RTResTalkAction[20],
			RTResTalkAction[16]
		}
	},
	[16040040] = {
		16040040,
		0,
		Lang.get(25978),
		16040,
		40,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[19]
		}
	},
	[16040041] = {
		16040041,
		0,
		Lang.get(25979),
		16040,
		41,
		191,
		{
			RTResTalkAction[18],
			RTResTalkAction[16]
		}
	},
	[16040042] = {
		16040042,
		0,
		Lang.get(25980),
		16040,
		42,
		188,
		{
			RTResTalkAction[24],
			RTResTalkAction[19]
		}
	},
	[16040043] = {
		16040043,
		0,
		Lang.get(25981),
		16040,
		43,
		191,
		{
			RTResTalkAction[20],
			RTResTalkAction[16]
		}
	},
	[16040044] = {
		16040044,
		0,
		Lang.get(25982),
		16040,
		44,
		191,
		{
			RTResTalkAction[18]
		}
	},
	[16040045] = {
		16040045,
		0,
		Lang.get(25983),
		16040,
		45,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16002001] = {
		16002001,
		9,
		Lang.get(24689),
		16002,
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		115,
		16084,
		nil,
		nil,
		nil,
		1,
		nil,
		16084,
		nil,
		nil,
		1
	},
	[16002002] = {
		16002002,
		9,
		Lang.get(24690),
		16002,
		2,
		[22] = 1
	},
	[16002003] = {
		16002003,
		9,
		Lang.get(24691),
		16002,
		3,
		[22] = 1
	},
	[16002004] = {
		16002004,
		9,
		Lang.get(24692),
		16002,
		4,
		[22] = 1
	},
	[16002005] = {
		16002005,
		9,
		Lang.get(24693),
		16002,
		5,
		[22] = 1
	},
	[16002006] = {
		16002006,
		9,
		Lang.get(24694),
		16002,
		6,
		[22] = 1
	},
	[16002007] = {
		16002007,
		9,
		Lang.get(24695),
		16002,
		7,
		[22] = 1
	},
	[16002008] = {
		16002008,
		9,
		Lang.get(24696),
		16002,
		8,
		[22] = 1
	},
	[16002009] = {
		16002009,
		0,
		Lang.get(24697),
		16002,
		9,
		189,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		16006,
		[19] = 16006,
		[17] = 1
	},
	[16002010] = {
		16002010,
		0,
		Lang.get(24698),
		16002,
		10,
		189,
		{
			RTResTalkAction[26]
		},
		nil,
		nil,
		3
	},
	[16002011] = {
		16002011,
		0,
		Lang.get(24699),
		16002,
		11,
		190,
		{
			RTResTalkAction[38],
			RTResTalkAction[30]
		}
	},
	[16002012] = {
		16002012,
		0,
		Lang.get(24700),
		16002,
		12,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[31]
		}
	},
	[16002013] = {
		16002013,
		0,
		Lang.get(24701),
		16002,
		13,
		189,
		{
			RTResTalkAction[37]
		}
	},
	[16002014] = {
		16002014,
		0,
		Lang.get(24702),
		16002,
		14,
		338,
		{
			RTResTalkAction[55],
			RTResTalkAction[30]
		}
	},
	[16002015] = {
		16002015,
		0,
		Lang.get(24703),
		16002,
		15,
		338,
		{
			RTResTalkAction[1]
		}
	},
	[16002016] = {
		16002016,
		0,
		Lang.get(24704),
		16002,
		16,
		189,
		{
			RTResTalkAction[50],
			RTResTalkAction[3]
		}
	},
	[16002017] = {
		16002017,
		0,
		Lang.get(24705),
		16002,
		17,
		190,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		}
	},
	[16002018] = {
		16002018,
		0,
		Lang.get(24706),
		16002,
		18,
		338,
		{
			RTResTalkAction[7],
			RTResTalkAction[31]
		}
	},
	[16002019] = {
		16002019,
		0,
		Lang.get(24707),
		16002,
		19,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[3]
		}
	},
	[16002020] = {
		16002020,
		0,
		Lang.get(24708),
		16002,
		20,
		338,
		{
			RTResTalkAction[1],
			RTResTalkAction[30]
		}
	},
	[16002021] = {
		16002021,
		0,
		Lang.get(24709),
		16002,
		21,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[3]
		}
	},
	[16002022] = {
		16002022,
		0,
		Lang.get(24710),
		16002,
		22,
		338,
		{
			RTResTalkAction[7],
			RTResTalkAction[30]
		}
	},
	[16002023] = {
		16002023,
		0,
		Lang.get(24711),
		16002,
		23,
		338,
		{
			RTResTalkAction[6]
		}
	},
	[16002024] = {
		16002024,
		0,
		Lang.get(24712),
		16002,
		24,
		338,
		{
			RTResTalkAction[4]
		}
	},
	[16002025] = {
		16002025,
		0,
		Lang.get(24713),
		16002,
		25,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[3]
		}
	},
	[16002026] = {
		16002026,
		0,
		Lang.get(24714),
		16002,
		26,
		190,
		{
			RTResTalkAction[62],
			RTResTalkAction[30]
		}
	},
	[16002027] = {
		16002027,
		0,
		Lang.get(24715),
		16002,
		27,
		338,
		{
			RTResTalkAction[7],
			RTResTalkAction[31]
		}
	},
	[16002028] = {
		16002028,
		0,
		Lang.get(24716),
		16002,
		28,
		338,
		{
			RTResTalkAction[55]
		}
	},
	[16002029] = {
		16002029,
		0,
		Lang.get(24717),
		16002,
		29,
		188,
		{
			RTResTalkAction[3]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		16083,
		nil,
		1,
		nil,
		1,
		nil,
		16083
	},
	[16002030] = {
		16002030,
		0,
		Lang.get(24718),
		16002,
		30,
		191,
		{
			RTResTalkAction[20]
		},
		nil,
		nil,
		3
	},
	[16002031] = {
		16002031,
		0,
		Lang.get(24719),
		16002,
		31,
		188,
		{
			RTResTalkAction[23],
			RTResTalkAction[19]
		}
	},
	[16002032] = {
		16002032,
		0,
		Lang.get(24720),
		16002,
		32,
		188,
		{
			RTResTalkAction[24]
		}
	},
	[16002033] = {
		16002033,
		0,
		Lang.get(24721),
		16002,
		33,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[16]
		}
	},
	[16002034] = {
		16002034,
		0,
		Lang.get(24722),
		16002,
		34,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[19]
		}
	},
	[16002035] = {
		16002035,
		0,
		Lang.get(24723),
		16002,
		35,
		191,
		{
			RTResTalkAction[63],
			RTResTalkAction[16]
		}
	},
	[16002036] = {
		16002036,
		0,
		Lang.get(24724),
		16002,
		36,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16002037] = {
		16002037,
		0,
		Lang.get(24725),
		16002,
		37,
		188,
		{
			RTResTalkAction[23],
			RTResTalkAction[19]
		}
	},
	[16002038] = {
		16002038,
		0,
		Lang.get(24726),
		16002,
		38,
		191,
		{
			RTResTalkAction[18],
			RTResTalkAction[16]
		}
	},
	[16002039] = {
		16002039,
		0,
		Lang.get(24727),
		16002,
		39,
		191,
		{
			RTResTalkAction[20]
		}
	},
	[16002040] = {
		16002040,
		0,
		Lang.get(24728),
		16002,
		40,
		188,
		{
			RTResTalkAction[61],
			RTResTalkAction[19]
		}
	},
	[16002041] = {
		16002041,
		0,
		Lang.get(24729),
		16002,
		41,
		191,
		{
			RTResTalkAction[20],
			RTResTalkAction[16]
		}
	},
	[16002042] = {
		16002042,
		0,
		Lang.get(24730),
		16002,
		42,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16002043] = {
		16002043,
		0,
		Lang.get(24731),
		16002,
		43,
		188,
		{
			RTResTalkAction[64],
			RTResTalkAction[19]
		}
	},
	[16002044] = {
		16002044,
		0,
		Lang.get(24732),
		16002,
		44,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[16]
		}
	},
	[16002045] = {
		16002045,
		0,
		Lang.get(24733),
		16002,
		45,
		191,
		{
			RTResTalkAction[18]
		}
	},
	[16003001] = {
		16003001,
		0,
		Lang.get(24734),
		16003,
		1,
		336,
		nil,
		1,
		nil,
		nil,
		nil,
		57,
		16085,
		nil,
		nil,
		nil,
		1,
		nil,
		16116
	},
	[16003002] = {
		16003002,
		0,
		Lang.get(24735),
		16003,
		2,
		638,
		nil,
		1
	},
	[16003003] = {
		16003003,
		0,
		Lang.get(24736),
		16003,
		3,
		336,
		{
			RTResTalkAction[65]
		},
		nil,
		nil,
		3
	},
	[16003004] = {
		16003004,
		0,
		Lang.get(24737),
		16003,
		4,
		638,
		{
			RTResTalkAction[2],
			RTResTalkAction[66]
		}
	},
	[16003005] = {
		16003005,
		0,
		Lang.get(24738),
		16003,
		5,
		336,
		{
			RTResTalkAction[65],
			RTResTalkAction[5]
		}
	},
	[16003006] = {
		16003006,
		0,
		Lang.get(24734),
		16003,
		6,
		336,
		{
			RTResTalkAction[65]
		}
	},
	[16003007] = {
		16003007,
		0,
		Lang.get(24739),
		16003,
		7,
		638,
		{
			RTResTalkAction[2],
			RTResTalkAction[66]
		}
	},
	[16003008] = {
		16003008,
		0,
		"…………",
		16003,
		8,
		336,
		{
			RTResTalkAction[65],
			RTResTalkAction[5]
		}
	},
	[16003009] = {
		16003009,
		0,
		Lang.get(24740),
		16003,
		9,
		638,
		{
			RTResTalkAction[2],
			RTResTalkAction[66]
		}
	},
	[16003010] = {
		16003010,
		0,
		Lang.get(24741),
		16003,
		10,
		336,
		{
			RTResTalkAction[65],
			RTResTalkAction[5]
		}
	},
	[16003011] = {
		16003011,
		0,
		Lang.get(24742),
		16003,
		11,
		638,
		{
			RTResTalkAction[2],
			RTResTalkAction[66]
		}
	},
	[16003012] = {
		16003012,
		0,
		Lang.get(24743),
		16003,
		12,
		639,
		{
			RTResTalkAction[5]
		},
		1
	},
	[16003013] = {
		16003013,
		0,
		Lang.get(24744),
		16003,
		13,
		638,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[16003014] = {
		16003014,
		0,
		Lang.get(24745),
		16003,
		14,
		639,
		{
			RTResTalkAction[67],
			RTResTalkAction[5]
		}
	},
	[16003015] = {
		16003015,
		0,
		Lang.get(24746),
		16003,
		15,
		638,
		{
			RTResTalkAction[2],
			RTResTalkAction[68]
		}
	},
	[16003016] = {
		16003016,
		0,
		Lang.get(24747),
		16003,
		16,
		639,
		{
			RTResTalkAction[67],
			RTResTalkAction[5]
		}
	},
	[16003017] = {
		16003017,
		0,
		Lang.get(24748),
		16003,
		17,
		638,
		{
			RTResTalkAction[2],
			RTResTalkAction[68]
		}
	},
	[16003018] = {
		16003018,
		0,
		Lang.get(24749),
		16003,
		18,
		191,
		{
			RTResTalkAction[5]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[19] = 16085,
		[17] = 1
	},
	[16003019] = {
		16003019,
		0,
		Lang.get(24750),
		16003,
		19,
		638,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[16003020] = {
		16003020,
		0,
		Lang.get(24751),
		16003,
		20,
		191,
		{
			RTResTalkAction[18],
			RTResTalkAction[5]
		}
	},
	[16003021] = {
		16003021,
		0,
		Lang.get(24752),
		16003,
		21,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16003022] = {
		16003022,
		0,
		Lang.get(24753),
		16003,
		22,
		191,
		{
			RTResTalkAction[20]
		}
	},
	[16003023] = {
		16003023,
		0,
		Lang.get(24754),
		16003,
		23,
		638,
		{
			RTResTalkAction[2],
			RTResTalkAction[19]
		}
	},
	[16003024] = {
		16003024,
		0,
		Lang.get(24755),
		16003,
		24,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[5]
		}
	},
	[16003025] = {
		16003025,
		0,
		Lang.get(24734),
		16003,
		25,
		336,
		{
			RTResTalkAction[65],
			RTResTalkAction[19]
		}
	},
	[16003026] = {
		16003026,
		0,
		Lang.get(24756),
		16003,
		26,
		336,
		{
			RTResTalkAction[65]
		}
	},
	[16003027] = {
		16003027,
		0,
		Lang.get(24757),
		16003,
		27,
		191,
		{
			RTResTalkAction[69],
			RTResTalkAction[66]
		}
	},
	[16003028] = {
		16003028,
		0,
		"…………",
		16003,
		28,
		336,
		{
			RTResTalkAction[65],
			RTResTalkAction[19]
		}
	},
	[16003029] = {
		16003029,
		0,
		Lang.get(24758),
		16003,
		29,
		336,
		{
			RTResTalkAction[65]
		}
	},
	[16003030] = {
		16003030,
		0,
		Lang.get(24759),
		16003,
		30,
		191,
		{
			RTResTalkAction[18],
			RTResTalkAction[66]
		}
	},
	[16003031] = {
		16003031,
		0,
		Lang.get(24760),
		16003,
		31,
		336,
		{
			RTResTalkAction[65],
			RTResTalkAction[19]
		}
	},
	[16003032] = {
		16003032,
		0,
		Lang.get(24761),
		16003,
		32,
		191,
		{
			RTResTalkAction[20],
			RTResTalkAction[66]
		}
	},
	[16003033] = {
		16003033,
		0,
		Lang.get(24762),
		16003,
		33,
		336,
		{
			RTResTalkAction[65],
			RTResTalkAction[19]
		}
	},
	[16003034] = {
		16003034,
		0,
		Lang.get(24763),
		16003,
		34,
		191,
		{
			RTResTalkAction[18],
			RTResTalkAction[66]
		}
	},
	[16003035] = {
		16003035,
		0,
		Lang.get(24764),
		16003,
		35,
		336,
		{
			RTResTalkAction[65],
			RTResTalkAction[19]
		}
	},
	[16003036] = {
		16003036,
		0,
		Lang.get(24765),
		16003,
		36,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[66]
		}
	},
	[16003037] = {
		16003037,
		0,
		Lang.get(24766),
		16003,
		37,
		336,
		{
			RTResTalkAction[65],
			RTResTalkAction[19]
		}
	},
	[16004001] = {
		16004001,
		0,
		Lang.get(24767),
		16004,
		1,
		189,
		nil,
		1,
		nil,
		nil,
		nil,
		115,
		16086,
		nil,
		nil,
		nil,
		1,
		nil,
		16086
	},
	[16004002] = {
		16004002,
		0,
		Lang.get(24768),
		16004,
		2,
		338,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[16004003] = {
		16004003,
		0,
		Lang.get(24769),
		16004,
		3,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[3]
		}
	},
	[16004004] = {
		16004004,
		0,
		Lang.get(24770),
		16004,
		4,
		190,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		}
	},
	[16004005] = {
		16004005,
		0,
		Lang.get(24771),
		16004,
		5,
		189,
		{
			RTResTalkAction[53],
			RTResTalkAction[31]
		}
	},
	[16004006] = {
		16004006,
		0,
		Lang.get(24772),
		16004,
		6,
		190,
		{
			RTResTalkAction[34],
			RTResTalkAction[30]
		}
	},
	[16004007] = {
		16004007,
		0,
		Lang.get(24773),
		16004,
		7,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[31]
		}
	},
	[16004008] = {
		16004008,
		0,
		Lang.get(24774),
		16004,
		8,
		189,
		{
			RTResTalkAction[26]
		}
	},
	[16004009] = {
		16004009,
		0,
		Lang.get(24775),
		16004,
		9,
		189,
		{
			RTResTalkAction[37]
		}
	},
	[16004010] = {
		16004010,
		0,
		Lang.get(24776),
		16004,
		10,
		188,
		{
			RTResTalkAction[30]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		16117,
		nil,
		1,
		nil,
		1,
		nil,
		16117
	},
	[16004011] = {
		16004011,
		0,
		Lang.get(24777),
		16004,
		11,
		188,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[16004012] = {
		16004012,
		0,
		Lang.get(24778),
		16004,
		12,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[16]
		}
	},
	[16004013] = {
		16004013,
		0,
		Lang.get(24779),
		16004,
		13,
		188,
		{
			RTResTalkAction[70],
			RTResTalkAction[30]
		}
	},
	[16004014] = {
		16004014,
		0,
		Lang.get(24780),
		16004,
		14,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[16]
		}
	},
	[16004015] = {
		16004015,
		0,
		Lang.get(24781),
		16004,
		15,
		188,
		{
			RTResTalkAction[23],
			RTResTalkAction[30]
		}
	},
	[16004016] = {
		16004016,
		0,
		Lang.get(24782),
		16004,
		16,
		189,
		{
			RTResTalkAction[42],
			RTResTalkAction[16]
		}
	},
	[16004017] = {
		16004017,
		0,
		Lang.get(24783),
		16004,
		17,
		338,
		{
			RTResTalkAction[7],
			RTResTalkAction[30]
		}
	},
	[16004018] = {
		16004018,
		0,
		Lang.get(24784),
		16004,
		18,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[3]
		}
	},
	[16004019] = {
		16004019,
		0,
		Lang.get(24785),
		16004,
		19,
		189,
		{
			RTResTalkAction[30]
		},
		1
	},
	[16004020] = {
		16004020,
		0,
		Lang.get(24786),
		16004,
		20,
		189,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		16007,
		nil,
		1,
		nil,
		1,
		nil,
		16007
	},
	[16004021] = {
		16004021,
		0,
		Lang.get(24787),
		16004,
		21,
		190,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[16004022] = {
		16004022,
		0,
		Lang.get(24788),
		16004,
		22,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[31]
		}
	},
	[16004023] = {
		16004023,
		0,
		Lang.get(24789),
		16004,
		23,
		189,
		{
			RTResTalkAction[26]
		}
	},
	[16004024] = {
		16004024,
		0,
		Lang.get(24790),
		16004,
		24,
		190,
		{
			RTResTalkAction[34],
			RTResTalkAction[30]
		}
	},
	[16004025] = {
		16004025,
		0,
		Lang.get(24791),
		16004,
		25,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[31]
		}
	},
	[16004026] = {
		16004026,
		0,
		Lang.get(24792),
		16004,
		26,
		188,
		{
			RTResTalkAction[24],
			RTResTalkAction[30]
		}
	},
	[16004027] = {
		16004027,
		0,
		Lang.get(24793),
		16004,
		27,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[16]
		}
	},
	[16004028] = {
		16004028,
		0,
		Lang.get(24794),
		16004,
		28,
		189,
		{
			RTResTalkAction[26]
		}
	},
	[16004029] = {
		16004029,
		0,
		Lang.get(24795),
		16004,
		29,
		188,
		{
			RTResTalkAction[30]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		16087,
		nil,
		1,
		nil,
		1,
		nil,
		16087
	},
	[16004030] = {
		16004030,
		0,
		Lang.get(24796),
		16004,
		30,
		338,
		{
			RTResTalkAction[71]
		},
		nil,
		nil,
		3,
		nil,
		63
	},
	[16004031] = {
		16004031,
		0,
		"…………",
		16004,
		31,
		336,
		{
			RTResTalkAction[65],
			RTResTalkAction[3]
		}
	},
	[16004032] = {
		16004032,
		0,
		Lang.get(24797),
		16004,
		32,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[66]
		}
	},
	[16004033] = {
		16004033,
		0,
		Lang.get(24798),
		16004,
		33,
		338,
		{
			RTResTalkAction[4],
			RTResTalkAction[30]
		}
	},
	[16004034] = {
		16004034,
		0,
		"…………",
		16004,
		34,
		338,
		{
			RTResTalkAction[6]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		16089
	},
	[16004035] = {
		16004035,
		0,
		Lang.get(24799),
		16004,
		35,
		191,
		{
			RTResTalkAction[3]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		16118,
		nil,
		1,
		nil,
		1,
		nil,
		16118
	},
	[16004036] = {
		16004036,
		0,
		Lang.get(61761),
		16004,
		36,
		338,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3
	},
	[16004037] = {
		16004037,
		0,
		Lang.get(24801),
		16004,
		37,
		338,
		{
			RTResTalkAction[4]
		}
	},
	[16004038] = {
		16004038,
		0,
		Lang.get(24802),
		16004,
		38,
		191,
		{
			RTResTalkAction[18],
			RTResTalkAction[3]
		}
	},
	[16004039] = {
		16004039,
		0,
		Lang.get(24803),
		16004,
		39,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16004040] = {
		16004040,
		0,
		Lang.get(24804),
		16004,
		40,
		191,
		{
			RTResTalkAction[19]
		},
		1,
		1
	},
	[16004041] = {
		16004041,
		0,
		Lang.get(24805),
		16004,
		41,
		189,
		nil,
		1,
		nil,
		nil,
		nil,
		40,
		nil,
		0.2,
		1,
		nil,
		1,
		nil,
		16089,
		3
	},
	[16004042] = {
		16004042,
		0,
		Lang.get(61762),
		16004,
		42,
		148,
		nil,
		1
	},
	[16004043] = {
		16004043,
		0,
		Lang.get(24806),
		16004,
		43,
		190,
		nil,
		1
	},
	[16004044] = {
		16004044,
		0,
		Lang.get(24807),
		16004,
		44,
		189,
		nil,
		1
	},
	[16004045] = {
		16004045,
		0,
		Lang.get(24808),
		16004,
		45,
		189,
		nil,
		1
	},
	[16004046] = {
		16004046,
		0,
		Lang.get(24809),
		16004,
		46,
		189,
		nil,
		1
	},
	[16004047] = {
		16004047,
		0,
		Lang.get(24810),
		16004,
		47,
		190,
		nil,
		1
	},
	[16004048] = {
		16004048,
		0,
		Lang.get(24811),
		16004,
		48,
		190,
		nil,
		1
	},
	[16004049] = {
		16004049,
		0,
		Lang.get(24812),
		16004,
		49,
		148,
		nil,
		1
	},
	[16004050] = {
		16004050,
		0,
		Lang.get(24813),
		16004,
		50,
		189,
		nil,
		1
	},
	[16004051] = {
		16004051,
		0,
		Lang.get(61763),
		16004,
		51,
		148,
		nil,
		1
	},
	[16004052] = {
		16004052,
		0,
		Lang.get(24814),
		16004,
		52,
		148,
		nil,
		1
	},
	[16004053] = {
		16004053,
		0,
		Lang.get(24815),
		16004,
		53,
		189,
		nil,
		1
	},
	[16004054] = {
		16004054,
		0,
		Lang.get(24816),
		16004,
		54,
		189,
		nil,
		1
	},
	[16004055] = {
		16004055,
		0,
		Lang.get(24817),
		16004,
		55,
		191,
		nil,
		1
	},
	[16004056] = {
		16004056,
		0,
		Lang.get(24818),
		16004,
		56,
		189,
		nil,
		1
	},
	[16004057] = {
		16004057,
		0,
		Lang.get(24819),
		16004,
		57,
		191,
		nil,
		1
	},
	[16004058] = {
		16004058,
		0,
		Lang.get(24820),
		16004,
		58,
		191,
		nil,
		1
	},
	[16004059] = {
		16004059,
		0,
		Lang.get(24821),
		16004,
		59,
		191,
		nil,
		1
	},
	[16004060] = {
		16004060,
		0,
		Lang.get(24822),
		16004,
		60,
		191,
		nil,
		1
	},
	[16004061] = {
		16004061,
		0,
		Lang.get(24823),
		16004,
		61,
		189,
		nil,
		1
	},
	[16004062] = {
		16004062,
		0,
		Lang.get(24824),
		16004,
		62,
		189,
		nil,
		1
	},
	[16004063] = {
		16004063,
		0,
		Lang.get(24825),
		16004,
		63,
		189,
		nil,
		1
	},
	[16004064] = {
		16004064,
		0,
		Lang.get(24826),
		16004,
		64,
		190,
		nil,
		1
	},
	[16004065] = {
		16004065,
		0,
		Lang.get(24827),
		16004,
		65,
		189,
		nil,
		1
	},
	[16004066] = {
		16004066,
		0,
		Lang.get(24828),
		16004,
		66,
		190,
		nil,
		1
	},
	[16004067] = {
		16004067,
		0,
		Lang.get(24829),
		16004,
		67,
		181,
		nil,
		1
	},
	[16004068] = {
		16004068,
		0,
		Lang.get(24830),
		16004,
		68,
		181,
		nil,
		1
	},
	[16004069] = {
		16004069,
		0,
		Lang.get(24831),
		16004,
		69,
		181,
		nil,
		1
	},
	[16004070] = {
		16004070,
		0,
		Lang.get(24832),
		16004,
		70,
		148,
		nil,
		1
	},
	[16004071] = {
		16004071,
		2,
		Lang.get(24833),
		16004,
		71,
		181,
		nil,
		1
	},
	[16004072] = {
		16004072,
		2,
		Lang.get(24834),
		16004,
		72,
		181,
		nil,
		1
	},
	[16004073] = {
		16004073,
		2,
		Lang.get(24835),
		16004,
		73,
		181,
		nil,
		1
	},
	[16004074] = {
		16004074,
		2,
		Lang.get(24836),
		16004,
		74,
		181,
		nil,
		1
	},
	[16004075] = {
		16004075,
		0,
		Lang.get(24837),
		16004,
		75,
		191,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		16118,
		nil,
		1,
		nil,
		1,
		nil,
		16118,
		-1
	},
	[16004076] = {
		16004076,
		0,
		Lang.get(24838),
		16004,
		76,
		191,
		{
			RTResTalkAction[18]
		},
		nil,
		nil,
		3
	},
	[16004077] = {
		16004077,
		0,
		Lang.get(24839),
		16004,
		77,
		338,
		{
			RTResTalkAction[4],
			RTResTalkAction[19]
		}
	},
	[16004078] = {
		16004078,
		0,
		Lang.get(24840),
		16004,
		78,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[3]
		}
	},
	[16005001] = {
		16005001,
		0,
		Lang.get(24841),
		16005,
		1,
		191,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		16088,
		nil,
		nil,
		nil,
		1,
		nil,
		16088
	},
	[16005002] = {
		16005002,
		0,
		Lang.get(24842),
		16005,
		2,
		191,
		{
			RTResTalkAction[72]
		},
		nil,
		nil,
		3
	},
	[16005003] = {
		16005003,
		0,
		Lang.get(24843),
		16005,
		3,
		338,
		{
			RTResTalkAction[4],
			RTResTalkAction[19]
		}
	},
	[16005004] = {
		16005004,
		0,
		Lang.get(24844),
		16005,
		4,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[3]
		}
	},
	[16005005] = {
		16005005,
		0,
		Lang.get(24845),
		16005,
		5,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16005006] = {
		16005006,
		0,
		Lang.get(24846),
		16005,
		6,
		338,
		{
			RTResTalkAction[7],
			RTResTalkAction[19]
		}
	},
	[16005007] = {
		16005007,
		0,
		Lang.get(24847),
		16005,
		7,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[3]
		}
	},
	[16005008] = {
		16005008,
		0,
		Lang.get(24848),
		16005,
		8,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16005009] = {
		16005009,
		0,
		Lang.get(24849),
		16005,
		9,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16005010] = {
		16005010,
		0,
		Lang.get(24850),
		16005,
		10,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16005011] = {
		16005011,
		0,
		Lang.get(24851),
		16005,
		11,
		338,
		{
			RTResTalkAction[7],
			RTResTalkAction[19]
		}
	},
	[16005012] = {
		16005012,
		0,
		Lang.get(24852),
		16005,
		12,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[3]
		}
	},
	[16005013] = {
		16005013,
		0,
		Lang.get(24853),
		16005,
		13,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16005014] = {
		16005014,
		0,
		Lang.get(24854),
		16005,
		14,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16005015] = {
		16005015,
		0,
		Lang.get(24855),
		16005,
		15,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16005016] = {
		16005016,
		0,
		Lang.get(24856),
		16005,
		16,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16005017] = {
		16005017,
		0,
		Lang.get(61764),
		16005,
		17,
		338,
		{
			RTResTalkAction[6],
			RTResTalkAction[19]
		}
	},
	[16005018] = {
		16005018,
		0,
		Lang.get(24858),
		16005,
		18,
		188,
		{
			RTResTalkAction[61],
			RTResTalkAction[3]
		}
	},
	[16005019] = {
		16005019,
		0,
		Lang.get(24859),
		16005,
		19,
		338,
		{
			RTResTalkAction[7],
			RTResTalkAction[16]
		}
	},
	[16005020] = {
		16005020,
		0,
		Lang.get(24860),
		16005,
		20,
		191,
		{
			RTResTalkAction[20],
			RTResTalkAction[3]
		}
	},
	[16005021] = {
		16005021,
		9,
		Lang.get(24734),
		16005,
		21,
		605,
		{
			RTResTalkAction[19]
		},
		[22] = 1
	},
	[16005022] = {
		16005022,
		9,
		Lang.get(24861),
		16005,
		22,
		605,
		[22] = 1
	},
	[16005023] = {
		16005023,
		5,
		Lang.get(24862),
		16005,
		23,
		337,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		16090,
		nil,
		1,
		nil,
		1,
		nil,
		16090
	},
	[16005024] = {
		16005024,
		5,
		Lang.get(24863),
		16005,
		24,
		337,
		{
			RTResTalkAction[73]
		},
		nil,
		nil,
		3
	},
	[16005025] = {
		16005025,
		0,
		Lang.get(24864),
		16005,
		25,
		638,
		{
			RTResTalkAction[2],
			RTResTalkAction[74]
		}
	},
	[16005026] = {
		16005026,
		0,
		Lang.get(24865),
		16005,
		26,
		337,
		{
			RTResTalkAction[75],
			RTResTalkAction[5]
		}
	},
	[16005027] = {
		16005027,
		0,
		Lang.get(24866),
		16005,
		27,
		337,
		{
			RTResTalkAction[76]
		}
	},
	[16005028] = {
		16005028,
		0,
		Lang.get(24867),
		16005,
		28,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[74]
		}
	},
	[16005029] = {
		16005029,
		0,
		Lang.get(24868),
		16005,
		29,
		337,
		{
			RTResTalkAction[75],
			RTResTalkAction[19]
		}
	},
	[16005030] = {
		16005030,
		0,
		Lang.get(24869),
		16005,
		30,
		638,
		{
			RTResTalkAction[2],
			RTResTalkAction[74]
		}
	},
	[16005031] = {
		16005031,
		0,
		Lang.get(24870),
		16005,
		31,
		337,
		{
			RTResTalkAction[75],
			RTResTalkAction[5]
		}
	},
	[16005032] = {
		16005032,
		0,
		Lang.get(61765),
		16005,
		32,
		638,
		{
			RTResTalkAction[2],
			RTResTalkAction[74]
		}
	},
	[16005033] = {
		16005033,
		0,
		Lang.get(24871),
		16005,
		33,
		337,
		{
			RTResTalkAction[73],
			RTResTalkAction[5]
		}
	},
	[16005034] = {
		16005034,
		0,
		"……",
		16005,
		34,
		338,
		{
			RTResTalkAction[4],
			RTResTalkAction[74]
		}
	},
	[16005035] = {
		16005035,
		0,
		Lang.get(24872),
		16005,
		35,
		191,
		{
			RTResTalkAction[18],
			RTResTalkAction[3]
		}
	},
	[16005036] = {
		16005036,
		0,
		Lang.get(24873),
		16005,
		36,
		189,
		{
			RTResTalkAction[19]
		},
		1,
		nil,
		nil,
		nil,
		115,
		16010,
		nil,
		1,
		nil,
		1,
		nil,
		16010
	},
	[16005037] = {
		16005037,
		0,
		Lang.get(24874),
		16005,
		37,
		190,
		{
			RTResTalkAction[77]
		},
		nil,
		nil,
		3
	},
	[16005038] = {
		16005038,
		0,
		Lang.get(24875),
		16005,
		38,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[31]
		}
	},
	[16005039] = {
		16005039,
		0,
		Lang.get(24876),
		16005,
		39,
		189,
		{
			RTResTalkAction[26]
		}
	},
	[16005040] = {
		16005040,
		0,
		Lang.get(24877),
		16005,
		40,
		188,
		{
			RTResTalkAction[61],
			RTResTalkAction[30]
		}
	},
	[16005041] = {
		16005041,
		0,
		Lang.get(24878),
		16005,
		41,
		338,
		{
			RTResTalkAction[4],
			RTResTalkAction[16]
		}
	},
	[16005042] = {
		16005042,
		0,
		Lang.get(24879),
		16005,
		42,
		338,
		{
			RTResTalkAction[7]
		}
	},
	[16005043] = {
		16005043,
		0,
		Lang.get(24880),
		16005,
		43,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[3]
		}
	},
	[16005044] = {
		16005044,
		0,
		Lang.get(24881),
		16005,
		44,
		189,
		{
			RTResTalkAction[26]
		}
	},
	[16005045] = {
		16005045,
		0,
		Lang.get(24882),
		16005,
		45,
		188,
		{
			RTResTalkAction[30]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		16091,
		nil,
		1,
		nil,
		1,
		nil,
		16091
	},
	[16005046] = {
		16005046,
		0,
		Lang.get(24883),
		16005,
		46,
		188,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[16005047] = {
		16005047,
		0,
		Lang.get(24884),
		16005,
		47,
		338,
		{
			RTResTalkAction[6],
			RTResTalkAction[16]
		}
	},
	[16005048] = {
		16005048,
		0,
		Lang.get(24885),
		16005,
		48,
		338,
		{
			RTResTalkAction[4]
		}
	},
	[16005049] = {
		16005049,
		0,
		Lang.get(24886),
		16005,
		49,
		338,
		{
			RTResTalkAction[6]
		}
	},
	[16005050] = {
		16005050,
		0,
		Lang.get(24887),
		16005,
		50,
		188,
		{
			RTResTalkAction[78],
			RTResTalkAction[3]
		}
	},
	[16005051] = {
		16005051,
		0,
		Lang.get(24888),
		16005,
		51,
		338,
		{
			RTResTalkAction[4],
			RTResTalkAction[16]
		}
	},
	[16005052] = {
		16005052,
		0,
		Lang.get(24889),
		16005,
		52,
		338,
		{
			RTResTalkAction[6]
		}
	},
	[16006001] = {
		16006001,
		9,
		Lang.get(24890),
		16006,
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		115,
		16092,
		nil,
		nil,
		nil,
		1,
		nil,
		16092,
		nil,
		nil,
		1
	},
	[16006002] = {
		16006002,
		9,
		Lang.get(24891),
		16006,
		2,
		[22] = 1
	},
	[16006003] = {
		16006003,
		9,
		Lang.get(24892),
		16006,
		3,
		[22] = 1
	},
	[16006004] = {
		16006004,
		9,
		Lang.get(24893),
		16006,
		4,
		[22] = 1
	},
	[16006005] = {
		16006005,
		9,
		Lang.get(24894),
		16006,
		5,
		[22] = 1
	},
	[16006006] = {
		16006006,
		9,
		Lang.get(24895),
		16006,
		6,
		[22] = 1
	},
	[16006007] = {
		16006007,
		9,
		Lang.get(24896),
		16006,
		7,
		[22] = 1
	},
	[16006008] = {
		16006008,
		9,
		Lang.get(24897),
		16006,
		8,
		[22] = 1
	},
	[16006009] = {
		16006009,
		9,
		Lang.get(24898),
		16006,
		9,
		[22] = 1
	},
	[16006010] = {
		16006010,
		9,
		Lang.get(24899),
		16006,
		10,
		[22] = 1
	},
	[16006011] = {
		16006011,
		9,
		Lang.get(24900),
		16006,
		11,
		[22] = 1
	},
	[16006012] = {
		16006012,
		9,
		Lang.get(24901),
		16006,
		12,
		[22] = 1
	},
	[16006013] = {
		16006013,
		9,
		Lang.get(24902),
		16006,
		13,
		[22] = 1
	},
	[16006014] = {
		16006014,
		9,
		Lang.get(24903),
		16006,
		14,
		[22] = 1
	},
	[16006015] = {
		16006015,
		9,
		Lang.get(24904),
		16006,
		15,
		[22] = 1
	},
	[16006016] = {
		16006016,
		9,
		Lang.get(70087),
		16006,
		16,
		[22] = 1
	},
	[16006017] = {
		16006017,
		9,
		Lang.get(24906),
		16006,
		17,
		[22] = 1
	},
	[16006018] = {
		16006018,
		9,
		Lang.get(24907),
		16006,
		18,
		[22] = 1
	},
	[16006019] = {
		16006019,
		0,
		Lang.get(24908),
		16006,
		19,
		188,
		nil,
		1,
		nil,
		nil,
		nil,
		59,
		16011,
		nil,
		nil,
		nil,
		1,
		nil,
		16011
	},
	[16006020] = {
		16006020,
		0,
		Lang.get(24909),
		16006,
		20,
		188,
		{
			RTResTalkAction[25]
		},
		nil,
		nil,
		3
	},
	[16006021] = {
		16006021,
		0,
		Lang.get(24910),
		16006,
		21,
		188,
		{
			RTResTalkAction[23]
		}
	},
	[16006022] = {
		16006022,
		0,
		Lang.get(24911),
		16006,
		22,
		338,
		{
			RTResTalkAction[79],
			RTResTalkAction[16]
		}
	},
	[16006023] = {
		16006023,
		0,
		Lang.get(24912),
		16006,
		23,
		338,
		{
			RTResTalkAction[6]
		}
	},
	[16006024] = {
		16006024,
		0,
		Lang.get(24913),
		16006,
		24,
		338,
		{
			RTResTalkAction[6]
		}
	},
	[16006025] = {
		16006025,
		0,
		Lang.get(24914),
		16006,
		25,
		338,
		{
			RTResTalkAction[6]
		}
	},
	[16006026] = {
		16006026,
		0,
		Lang.get(24915),
		16006,
		26,
		338,
		{
			RTResTalkAction[6]
		}
	},
	[16006027] = {
		16006027,
		0,
		Lang.get(24916),
		16006,
		27,
		338,
		{
			RTResTalkAction[6]
		}
	},
	[16006028] = {
		16006028,
		0,
		Lang.get(24917),
		16006,
		28,
		188,
		{
			RTResTalkAction[80],
			RTResTalkAction[3]
		}
	},
	[16006029] = {
		16006029,
		0,
		Lang.get(24918),
		16006,
		29,
		338,
		{
			RTResTalkAction[55],
			RTResTalkAction[16]
		}
	},
	[16006030] = {
		16006030,
		0,
		Lang.get(24919),
		16006,
		30,
		188,
		{
			RTResTalkAction[61],
			RTResTalkAction[3]
		}
	},
	[16006031] = {
		16006031,
		0,
		Lang.get(24920),
		16006,
		31,
		338,
		{
			RTResTalkAction[4],
			RTResTalkAction[16]
		}
	},
	[16006032] = {
		16006032,
		0,
		Lang.get(61766),
		16006,
		32,
		188,
		{
			RTResTalkAction[81],
			RTResTalkAction[3]
		}
	},
	[16006033] = {
		16006033,
		0,
		Lang.get(24921),
		16006,
		33,
		338,
		{
			RTResTalkAction[1],
			RTResTalkAction[16]
		}
	},
	[16006034] = {
		16006034,
		0,
		Lang.get(24922),
		16006,
		34,
		188,
		{
			RTResTalkAction[24],
			RTResTalkAction[3]
		}
	},
	[16006035] = {
		16006035,
		0,
		Lang.get(24923),
		16006,
		35,
		338,
		{
			RTResTalkAction[4],
			RTResTalkAction[16]
		}
	},
	[16006036] = {
		16006036,
		0,
		Lang.get(24924),
		16006,
		36,
		188,
		{
			RTResTalkAction[82],
			RTResTalkAction[3]
		}
	},
	[16006037] = {
		16006037,
		0,
		Lang.get(24925),
		16006,
		37,
		338,
		{
			RTResTalkAction[4],
			RTResTalkAction[16]
		}
	},
	[16006038] = {
		16006038,
		0,
		Lang.get(24926),
		16006,
		38,
		338,
		{
			RTResTalkAction[6]
		}
	},
	[16006039] = {
		16006039,
		0,
		Lang.get(61767),
		16006,
		39,
		188,
		{
			RTResTalkAction[23],
			RTResTalkAction[3]
		}
	},
	[16006040] = {
		16006040,
		0,
		Lang.get(24927),
		16006,
		40,
		338,
		{
			RTResTalkAction[16]
		},
		1,
		nil,
		nil,
		nil,
		40,
		nil,
		nil,
		1,
		nil,
		1,
		nil,
		16093
	},
	[16006041] = {
		16006041,
		0,
		Lang.get(24928),
		16006,
		41,
		338,
		nil,
		1
	},
	[16006042] = {
		16006042,
		0,
		Lang.get(24929),
		16006,
		42,
		338,
		nil,
		1
	},
	[16006043] = {
		16006043,
		0,
		Lang.get(24930),
		16006,
		43,
		338,
		nil,
		1
	},
	[16006044] = {
		16006044,
		0,
		Lang.get(24931),
		16006,
		44,
		640,
		nil,
		1
	},
	[16006045] = {
		16006045,
		0,
		Lang.get(24932),
		16006,
		45,
		640,
		nil,
		1
	},
	[16006046] = {
		16006046,
		0,
		Lang.get(24933),
		16006,
		46,
		640,
		nil,
		1
	},
	[16006047] = {
		16006047,
		0,
		Lang.get(24934),
		16006,
		47,
		338,
		nil,
		1
	},
	[16006048] = {
		16006048,
		0,
		Lang.get(24935),
		16006,
		48,
		640,
		nil,
		1
	},
	[16006049] = {
		16006049,
		0,
		Lang.get(24936),
		16006,
		49,
		640,
		nil,
		1
	},
	[16006050] = {
		16006050,
		0,
		Lang.get(24937),
		16006,
		50,
		640,
		nil,
		1
	},
	[16006051] = {
		16006051,
		0,
		Lang.get(24938),
		16006,
		51,
		338,
		nil,
		1
	},
	[16006052] = {
		16006052,
		0,
		Lang.get(24939),
		16006,
		52,
		640,
		nil,
		1
	},
	[16006053] = {
		16006053,
		0,
		Lang.get(24940),
		16006,
		53,
		640,
		nil,
		1
	},
	[16006054] = {
		16006054,
		0,
		Lang.get(24941),
		16006,
		54,
		640,
		nil,
		1
	},
	[16006055] = {
		16006055,
		0,
		Lang.get(24942),
		16006,
		55,
		640,
		nil,
		1
	},
	[16006056] = {
		16006056,
		0,
		Lang.get(24943),
		16006,
		56,
		640,
		nil,
		1
	},
	[16006057] = {
		16006057,
		0,
		Lang.get(24944),
		16006,
		57,
		338,
		nil,
		1
	},
	[16006058] = {
		16006058,
		0,
		Lang.get(24945),
		16006,
		58,
		640,
		nil,
		1
	},
	[16006059] = {
		16006059,
		0,
		Lang.get(24946),
		16006,
		59,
		640,
		nil,
		1
	},
	[16006060] = {
		16006060,
		0,
		Lang.get(61768),
		16006,
		60,
		640,
		nil,
		1
	},
	[16006061] = {
		16006061,
		0,
		Lang.get(24948),
		16006,
		61,
		641,
		nil,
		1
	},
	[16006062] = {
		16006062,
		0,
		Lang.get(24949),
		16006,
		62,
		641,
		nil,
		1
	},
	[16006063] = {
		16006063,
		0,
		Lang.get(24950),
		16006,
		63,
		642,
		nil,
		1
	},
	[16006064] = {
		16006064,
		0,
		Lang.get(24951),
		16006,
		64,
		642,
		nil,
		1
	},
	[16006065] = {
		16006065,
		0,
		Lang.get(24952),
		16006,
		65,
		643,
		nil,
		1
	},
	[16006066] = {
		16006066,
		0,
		Lang.get(24953),
		16006,
		66,
		643,
		nil,
		1
	},
	[16006067] = {
		16006067,
		0,
		Lang.get(24954),
		16006,
		67,
		338,
		{
			RTResTalkAction[4]
		},
		nil,
		nil,
		3
	},
	[16006068] = {
		16006068,
		0,
		Lang.get(61769),
		16006,
		68,
		338,
		{
			RTResTalkAction[6]
		}
	},
	[16006069] = {
		16006069,
		0,
		Lang.get(24956),
		16006,
		69,
		338,
		{
			RTResTalkAction[6]
		}
	},
	[16006070] = {
		16006070,
		0,
		Lang.get(24957),
		16006,
		70,
		338,
		{
			RTResTalkAction[6]
		}
	},
	[16006071] = {
		16006071,
		0,
		Lang.get(24958),
		16006,
		71,
		338,
		{
			RTResTalkAction[8]
		}
	},
	[16006072] = {
		16006072,
		0,
		Lang.get(24959),
		16006,
		72,
		644,
		{
			RTResTalkAction[83],
			RTResTalkAction[3]
		}
	},
	[16006073] = {
		16006073,
		0,
		Lang.get(24960),
		16006,
		73,
		338,
		{
			RTResTalkAction[4],
			RTResTalkAction[84]
		}
	},
	[16006074] = {
		16006074,
		0,
		Lang.get(24961),
		16006,
		74,
		338,
		{
			RTResTalkAction[85]
		}
	},
	[16007001] = {
		16007001,
		0,
		Lang.get(24962),
		16007,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		30,
		16012,
		nil,
		nil,
		nil,
		1,
		nil,
		16012
	},
	[16007002] = {
		16007002,
		0,
		Lang.get(24963),
		16007,
		2,
		141,
		{
			RTResTalkAction[86]
		},
		nil,
		nil,
		3
	},
	[16007003] = {
		16007003,
		0,
		Lang.get(24964),
		16007,
		3,
		107,
		{
			RTResTalkAction[87],
			RTResTalkAction[88]
		}
	},
	[16007004] = {
		16007004,
		0,
		Lang.get(24965),
		16007,
		4,
		107,
		{
			RTResTalkAction[89]
		}
	},
	[16007005] = {
		16007005,
		0,
		Lang.get(24966),
		16007,
		5,
		107,
		{
			RTResTalkAction[90]
		}
	},
	[16007006] = {
		16007006,
		0,
		Lang.get(24967),
		16007,
		6,
		107,
		{
			RTResTalkAction[91]
		}
	},
	[16007007] = {
		16007007,
		0,
		Lang.get(24968),
		16007,
		7,
		107,
		{
			RTResTalkAction[92]
		}
	},
	[16007008] = {
		16007008,
		0,
		Lang.get(24969),
		16007,
		8,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16007009] = {
		16007009,
		0,
		"……",
		16007,
		9,
		141,
		{
			RTResTalkAction[94],
			RTResTalkAction[95]
		}
	},
	[16007010] = {
		16007010,
		0,
		Lang.get(24970),
		16007,
		10,
		107,
		{
			RTResTalkAction[96],
			RTResTalkAction[88]
		}
	},
	[16007011] = {
		16007011,
		0,
		Lang.get(24971),
		16007,
		11,
		141,
		{
			RTResTalkAction[97],
			RTResTalkAction[95]
		}
	},
	[16007012] = {
		16007012,
		0,
		Lang.get(24972),
		16007,
		12,
		141,
		{
			RTResTalkAction[97]
		}
	},
	[16007013] = {
		16007013,
		0,
		Lang.get(24973),
		16007,
		13,
		107,
		{
			RTResTalkAction[91],
			RTResTalkAction[88]
		}
	},
	[16007014] = {
		16007014,
		0,
		Lang.get(24974),
		16007,
		14,
		107,
		{
			RTResTalkAction[89]
		}
	},
	[16007015] = {
		16007015,
		0,
		Lang.get(61770),
		16007,
		15,
		300,
		{
			RTResTalkAction[95]
		}
	},
	[16007016] = {
		16007016,
		0,
		Lang.get(24976),
		16007,
		16,
		107,
		{
			RTResTalkAction[98]
		}
	},
	[16007017] = {
		16007017,
		0,
		Lang.get(24977),
		16007,
		17,
		141,
		{
			RTResTalkAction[86],
			RTResTalkAction[95]
		}
	},
	[16007018] = {
		16007018,
		0,
		Lang.get(24978),
		16007,
		18,
		300,
		{
			RTResTalkAction[88]
		}
	},
	[16007019] = {
		16007019,
		0,
		Lang.get(24979),
		16007,
		19,
		107,
		{
			RTResTalkAction[90]
		}
	},
	[16007020] = {
		16007020,
		0,
		Lang.get(24980),
		16007,
		20,
		300,
		{
			RTResTalkAction[95]
		}
	},
	[16007021] = {
		16007021,
		0,
		Lang.get(24981),
		16007,
		21,
		107,
		{
			RTResTalkAction[91]
		}
	},
	[16007022] = {
		16007022,
		0,
		Lang.get(24982),
		16007,
		22,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16007023] = {
		16007023,
		0,
		"……",
		16007,
		23,
		141,
		{
			RTResTalkAction[94],
			RTResTalkAction[95]
		}
	},
	[16007024] = {
		16007024,
		0,
		Lang.get(24983),
		16007,
		24,
		300,
		{
			RTResTalkAction[88]
		}
	},
	[16007025] = {
		16007025,
		0,
		Lang.get(24984),
		16007,
		25,
		141,
		{
			RTResTalkAction[97]
		}
	},
	[16007026] = {
		16007026,
		5,
		Lang.get(24985),
		16007,
		26,
		300,
		{
			RTResTalkAction[88]
		}
	},
	[16007027] = {
		16007027,
		0,
		Lang.get(24986),
		16007,
		27,
		141,
		{
			RTResTalkAction[99]
		}
	},
	[16007028] = {
		16007028,
		0,
		Lang.get(24987),
		16007,
		28,
		300,
		{
			RTResTalkAction[88]
		}
	},
	[16007029] = {
		16007029,
		5,
		Lang.get(24988),
		16007,
		29,
		107,
		{
			RTResTalkAction[100]
		}
	},
	[16007030] = {
		16007030,
		0,
		Lang.get(24989),
		16007,
		30,
		107,
		{
			RTResTalkAction[101]
		}
	},
	[16007031] = {
		16007031,
		0,
		Lang.get(24990),
		16007,
		31,
		300,
		{
			RTResTalkAction[95]
		}
	},
	[16007032] = {
		16007032,
		0,
		Lang.get(24991),
		16007,
		32,
		107,
		{
			RTResTalkAction[102]
		}
	},
	[16007033] = {
		16007033,
		0,
		Lang.get(24992),
		16007,
		33,
		107,
		{
			RTResTalkAction[90]
		}
	},
	[16007034] = {
		16007034,
		0,
		Lang.get(24993),
		16007,
		34,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16007035] = {
		16007035,
		0,
		Lang.get(24994),
		16007,
		35,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16007036] = {
		16007036,
		0,
		Lang.get(24995),
		16007,
		36,
		107,
		{
			RTResTalkAction[103]
		}
	},
	[16007037] = {
		16007037,
		0,
		Lang.get(24996),
		16007,
		37,
		300,
		{
			RTResTalkAction[95]
		}
	},
	[16007038] = {
		16007038,
		0,
		Lang.get(24997),
		16007,
		38,
		107,
		{
			RTResTalkAction[92]
		}
	},
	[16007039] = {
		16007039,
		0,
		Lang.get(24998),
		16007,
		39,
		300,
		{
			RTResTalkAction[95]
		}
	},
	[16007040] = {
		16007040,
		0,
		Lang.get(24999),
		16007,
		40,
		107,
		{
			RTResTalkAction[104]
		}
	},
	[16007041] = {
		16007041,
		9,
		Lang.get(25000),
		16007,
		41,
		300,
		{
			RTResTalkAction[95]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		nil,
		1,
		nil,
		16014,
		nil,
		nil,
		1
	},
	[16007042] = {
		16007042,
		9,
		Lang.get(25001),
		16007,
		42,
		300,
		[22] = 1
	},
	[16007043] = {
		16007043,
		9,
		Lang.get(25002),
		16007,
		43,
		300,
		[22] = 1
	},
	[16007044] = {
		16007044,
		9,
		Lang.get(25003),
		16007,
		44,
		300,
		[22] = 1
	},
	[16007045] = {
		16007045,
		9,
		Lang.get(25004),
		16007,
		45,
		300,
		[22] = 1
	},
	[16007046] = {
		16007046,
		9,
		Lang.get(25005),
		16007,
		46,
		300,
		[22] = 1
	},
	[16007047] = {
		16007047,
		0,
		Lang.get(25006),
		16007,
		47,
		641,
		nil,
		1,
		nil,
		nil,
		nil,
		40,
		16011,
		nil,
		nil,
		nil,
		1,
		nil,
		16011
	},
	[16007048] = {
		16007048,
		0,
		Lang.get(25007),
		16007,
		48,
		642,
		nil,
		1
	},
	[16007049] = {
		16007049,
		0,
		Lang.get(25008),
		16007,
		49,
		643,
		nil,
		1
	},
	[16007050] = {
		16007050,
		0,
		Lang.get(25009),
		16007,
		50,
		338,
		{
			RTResTalkAction[4]
		},
		nil,
		nil,
		3
	},
	[16007051] = {
		16007051,
		0,
		Lang.get(25010),
		16007,
		51,
		188,
		{
			RTResTalkAction[23],
			RTResTalkAction[3]
		}
	},
	[16007052] = {
		16007052,
		0,
		Lang.get(25011),
		16007,
		52,
		338,
		{
			RTResTalkAction[6],
			RTResTalkAction[16]
		}
	},
	[16007053] = {
		16007053,
		0,
		Lang.get(25012),
		16007,
		53,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[3]
		}
	},
	[16007054] = {
		16007054,
		0,
		Lang.get(25013),
		16007,
		54,
		338,
		{
			RTResTalkAction[79],
			RTResTalkAction[16]
		}
	},
	[16007055] = {
		16007055,
		0,
		Lang.get(25014),
		16007,
		55,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[3]
		}
	},
	[16007056] = {
		16007056,
		0,
		Lang.get(25015),
		16007,
		56,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16007057] = {
		16007057,
		0,
		Lang.get(25016),
		16007,
		57,
		188,
		{
			RTResTalkAction[61]
		}
	},
	[16007058] = {
		16007058,
		0,
		Lang.get(25017),
		16007,
		58,
		188,
		{
			RTResTalkAction[23]
		}
	},
	[16007059] = {
		16007059,
		0,
		Lang.get(25018),
		16007,
		59,
		188,
		{
			RTResTalkAction[17]
		}
	},
	[16007060] = {
		16007060,
		0,
		Lang.get(25019),
		16007,
		60,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16007061] = {
		16007061,
		0,
		Lang.get(25020),
		16007,
		61,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16007062] = {
		16007062,
		0,
		Lang.get(25021),
		16007,
		62,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16007063] = {
		16007063,
		0,
		Lang.get(25022),
		16007,
		63,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16007064] = {
		16007064,
		0,
		Lang.get(25023),
		16007,
		64,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16007065] = {
		16007065,
		0,
		"…………",
		16007,
		65,
		188,
		{
			RTResTalkAction[105]
		}
	},
	[16007066] = {
		16007066,
		0,
		Lang.get(25024),
		16007,
		66,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16007067] = {
		16007067,
		0,
		Lang.get(25025),
		16007,
		67,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16007068] = {
		16007068,
		0,
		"……",
		16007,
		68,
		338,
		{
			RTResTalkAction[16]
		},
		1,
		nil,
		nil,
		nil,
		48,
		16094,
		nil,
		1,
		nil,
		1,
		nil,
		16094
	},
	[16007069] = {
		16007069,
		0,
		Lang.get(25026),
		16007,
		69,
		338,
		nil,
		1,
		3
	},
	[16007070] = {
		16007070,
		0,
		Lang.get(25027),
		16007,
		70,
		338,
		nil,
		1,
		1
	},
	[16007071] = {
		16007071,
		0,
		Lang.get(25028),
		16007,
		71,
		338,
		nil,
		1,
		4
	},
	[16007072] = {
		16007072,
		0,
		Lang.get(61771),
		16007,
		72,
		300
	},
	[16007073] = {
		16007073,
		0,
		Lang.get(25029),
		16007,
		73,
		338,
		nil,
		1
	},
	[16007074] = {
		16007074,
		0,
		Lang.get(25030),
		16007,
		74,
		338,
		nil,
		1
	},
	[16007075] = {
		16007075,
		0,
		Lang.get(25031),
		16007,
		75,
		338,
		nil,
		1
	},
	[16007076] = {
		16007076,
		0,
		Lang.get(25032),
		16007,
		76,
		300
	},
	[16007077] = {
		16007077,
		0,
		Lang.get(25033),
		16007,
		77,
		338,
		nil,
		1
	},
	[16007078] = {
		16007078,
		0,
		Lang.get(25034),
		16007,
		78,
		300
	},
	[16007079] = {
		16007079,
		0,
		Lang.get(25035),
		16007,
		79,
		338,
		nil,
		1
	},
	[16007080] = {
		16007080,
		0,
		Lang.get(25036),
		16007,
		80,
		338,
		nil,
		1
	},
	[16007081] = {
		16007081,
		0,
		Lang.get(25037),
		16007,
		81,
		338,
		nil,
		1
	},
	[16007082] = {
		16007082,
		0,
		Lang.get(25038),
		16007,
		82,
		300
	},
	[16007083] = {
		16007083,
		0,
		Lang.get(25039),
		16007,
		83,
		338,
		nil,
		1
	},
	[16007084] = {
		16007084,
		0,
		Lang.get(61772),
		16007,
		84,
		338,
		nil,
		1
	},
	[16007085] = {
		16007085,
		0,
		Lang.get(25040),
		16007,
		85,
		338,
		nil,
		1,
		0
	},
	[16007086] = {
		16007086,
		0,
		Lang.get(25041),
		16007,
		86,
		188,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		16015,
		nil,
		1,
		nil,
		1,
		nil,
		16015
	},
	[16007087] = {
		16007087,
		0,
		Lang.get(25042),
		16007,
		87,
		188,
		{
			RTResTalkAction[24]
		},
		nil,
		nil,
		3
	},
	[16007088] = {
		16007088,
		0,
		Lang.get(25043),
		16007,
		88,
		338,
		{
			RTResTalkAction[55],
			RTResTalkAction[16]
		}
	},
	[16007089] = {
		16007089,
		0,
		Lang.get(25044),
		16007,
		89,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[3]
		}
	},
	[16007090] = {
		16007090,
		0,
		"……",
		16007,
		90,
		338,
		{
			RTResTalkAction[4],
			RTResTalkAction[16]
		}
	},
	[16007091] = {
		16007091,
		0,
		Lang.get(25045),
		16007,
		91,
		338,
		{
			RTResTalkAction[6]
		}
	},
	[16007092] = {
		16007092,
		0,
		Lang.get(25046),
		16007,
		92,
		188,
		{
			RTResTalkAction[17],
			RTResTalkAction[3]
		}
	},
	[16007093] = {
		16007093,
		0,
		Lang.get(25047),
		16007,
		93,
		188,
		{
			RTResTalkAction[106]
		}
	},
	[16007094] = {
		16007094,
		0,
		Lang.get(25048),
		16007,
		94,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16007095] = {
		16007095,
		0,
		Lang.get(25049),
		16007,
		95,
		188,
		{
			RTResTalkAction[61]
		}
	},
	[16007096] = {
		16007096,
		0,
		Lang.get(25050),
		16007,
		96,
		338,
		{
			RTResTalkAction[7],
			RTResTalkAction[16]
		}
	},
	[16007097] = {
		16007097,
		0,
		Lang.get(25051),
		16007,
		97,
		188,
		{
			RTResTalkAction[17],
			RTResTalkAction[3]
		}
	},
	[16007098] = {
		16007098,
		0,
		Lang.get(25052),
		16007,
		98,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16007099] = {
		16007099,
		0,
		Lang.get(25053),
		16007,
		99,
		188,
		{
			RTResTalkAction[106]
		}
	},
	[16007100] = {
		16007100,
		0,
		Lang.get(25054),
		16007,
		100,
		338,
		{
			RTResTalkAction[55],
			RTResTalkAction[16]
		}
	},
	[16007101] = {
		16007101,
		0,
		Lang.get(25055),
		16007,
		101,
		188,
		{
			RTResTalkAction[24],
			RTResTalkAction[3]
		}
	},
	[16007102] = {
		16007102,
		0,
		Lang.get(25056),
		16007,
		102,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16007103] = {
		16007103,
		0,
		Lang.get(25057),
		16007,
		103,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16007104] = {
		16007104,
		0,
		Lang.get(25058),
		16007,
		104,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16007105] = {
		16007105,
		0,
		Lang.get(25059),
		16007,
		105,
		337,
		{
			RTResTalkAction[16]
		},
		1,
		nil,
		nil,
		nil,
		57,
		16016,
		nil,
		1,
		nil,
		1,
		nil,
		16016
	},
	[16007106] = {
		16007106,
		0,
		Lang.get(25060),
		16007,
		106,
		191,
		{
			RTResTalkAction[18]
		},
		nil,
		nil,
		3
	},
	[16007107] = {
		16007107,
		0,
		Lang.get(25061),
		16007,
		107,
		337,
		{
			RTResTalkAction[107],
			RTResTalkAction[19]
		}
	},
	[16007108] = {
		16007108,
		0,
		Lang.get(25062),
		16007,
		108,
		191,
		{
			RTResTalkAction[20],
			RTResTalkAction[74]
		}
	},
	[16007109] = {
		16007109,
		0,
		Lang.get(25063),
		16007,
		109,
		191,
		{
			RTResTalkAction[18]
		}
	},
	[16007110] = {
		16007110,
		0,
		Lang.get(25064),
		16007,
		110,
		337,
		{
			RTResTalkAction[73],
			RTResTalkAction[19]
		}
	},
	[16007111] = {
		16007111,
		0,
		Lang.get(25065),
		16007,
		111,
		337,
		{
			RTResTalkAction[75]
		}
	},
	[16007112] = {
		16007112,
		0,
		Lang.get(25066),
		16007,
		112,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[74]
		}
	},
	[16007113] = {
		16007113,
		0,
		"…………",
		16007,
		113,
		337,
		{
			RTResTalkAction[108],
			RTResTalkAction[19]
		}
	},
	[16007114] = {
		16007114,
		0,
		Lang.get(25067),
		16007,
		114,
		337,
		{
			RTResTalkAction[75]
		}
	},
	[16007115] = {
		16007115,
		0,
		Lang.get(25068),
		16007,
		115,
		191,
		{
			RTResTalkAction[20],
			RTResTalkAction[74]
		}
	},
	[16007116] = {
		16007116,
		0,
		Lang.get(25069),
		16007,
		116,
		337,
		{
			RTResTalkAction[75],
			RTResTalkAction[19]
		}
	},
	[16007117] = {
		16007117,
		0,
		Lang.get(25070),
		16007,
		117,
		191,
		{
			RTResTalkAction[18],
			RTResTalkAction[74]
		}
	},
	[16007118] = {
		16007118,
		0,
		Lang.get(25071),
		16007,
		118,
		337,
		{
			RTResTalkAction[75],
			RTResTalkAction[19]
		}
	},
	[16007119] = {
		16007119,
		0,
		Lang.get(25072),
		16007,
		119,
		191,
		{
			RTResTalkAction[109],
			RTResTalkAction[74]
		}
	},
	[16007120] = {
		16007120,
		0,
		Lang.get(25073),
		16007,
		120,
		191,
		{
			RTResTalkAction[20]
		}
	},
	[16007121] = {
		16007121,
		0,
		Lang.get(25074),
		16007,
		121,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16007122] = {
		16007122,
		0,
		Lang.get(25075),
		16007,
		122,
		337,
		{
			RTResTalkAction[73],
			RTResTalkAction[19]
		}
	},
	[16007123] = {
		16007123,
		0,
		Lang.get(25076),
		16007,
		123,
		191,
		{
			RTResTalkAction[18],
			RTResTalkAction[74]
		}
	},
	[16007124] = {
		16007124,
		0,
		Lang.get(25077),
		16007,
		124,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16007125] = {
		16007125,
		0,
		Lang.get(25078),
		16007,
		125,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16007126] = {
		16007126,
		0,
		Lang.get(25079),
		16007,
		126,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16007127] = {
		16007127,
		0,
		Lang.get(25080),
		16007,
		127,
		191,
		{
			RTResTalkAction[110]
		}
	},
	[16007128] = {
		16007128,
		0,
		Lang.get(25081),
		16007,
		128,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16007129] = {
		16007129,
		0,
		Lang.get(25082),
		16007,
		129,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16010001] = {
		16010001,
		0,
		Lang.get(25083),
		16010,
		1,
		188,
		nil,
		1,
		nil,
		nil,
		nil,
		30,
		16017,
		nil,
		nil,
		nil,
		1,
		nil,
		16017
	},
	[16010002] = {
		16010002,
		0,
		Lang.get(25084),
		16010,
		2,
		338,
		nil,
		1
	},
	[16010003] = {
		16010003,
		0,
		Lang.get(25085),
		16010,
		3,
		338,
		nil,
		1
	},
	[16010004] = {
		16010004,
		0,
		Lang.get(25086),
		16010,
		4,
		188,
		nil,
		1
	},
	[16010005] = {
		16010005,
		0,
		Lang.get(25087),
		16010,
		5,
		338,
		{
			RTResTalkAction[4]
		},
		nil,
		nil,
		3
	},
	[16010006] = {
		16010006,
		0,
		Lang.get(25088),
		16010,
		6,
		188,
		{
			RTResTalkAction[17],
			RTResTalkAction[3]
		}
	},
	[16010007] = {
		16010007,
		0,
		Lang.get(25089),
		16010,
		7,
		338,
		{
			RTResTalkAction[7],
			RTResTalkAction[16]
		}
	},
	[16010008] = {
		16010008,
		0,
		Lang.get(25090),
		16010,
		8,
		188,
		{
			RTResTalkAction[24],
			RTResTalkAction[3]
		}
	},
	[16010009] = {
		16010009,
		0,
		Lang.get(25091),
		16010,
		9,
		338,
		{
			RTResTalkAction[6],
			RTResTalkAction[16]
		}
	},
	[16010010] = {
		16010010,
		0,
		Lang.get(25092),
		16010,
		10,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[3]
		}
	},
	[16010011] = {
		16010011,
		0,
		Lang.get(25093),
		16010,
		11,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16010012] = {
		16010012,
		0,
		Lang.get(25094),
		16010,
		12,
		338,
		{
			RTResTalkAction[14],
			RTResTalkAction[16]
		}
	},
	[16010013] = {
		16010013,
		0,
		Lang.get(25095),
		16010,
		13,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[3]
		}
	},
	[16010014] = {
		16010014,
		0,
		Lang.get(25096),
		16010,
		14,
		188,
		{
			RTResTalkAction[111]
		}
	},
	[16010015] = {
		16010015,
		0,
		Lang.get(25097),
		16010,
		15,
		338,
		{
			RTResTalkAction[6],
			RTResTalkAction[16]
		}
	},
	[16010016] = {
		16010016,
		0,
		Lang.get(25098),
		16010,
		16,
		338,
		{
			RTResTalkAction[7]
		}
	},
	[16010017] = {
		16010017,
		0,
		Lang.get(25099),
		16010,
		17,
		188,
		{
			RTResTalkAction[82],
			RTResTalkAction[3]
		}
	},
	[16010018] = {
		16010018,
		0,
		Lang.get(25100),
		16010,
		18,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16010019] = {
		16010019,
		0,
		Lang.get(25101),
		16010,
		19,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16010020] = {
		16010020,
		0,
		Lang.get(25102),
		16010,
		20,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16010021] = {
		16010021,
		0,
		Lang.get(25103),
		16010,
		21,
		338,
		{
			RTResTalkAction[6],
			RTResTalkAction[16]
		}
	},
	[16010022] = {
		16010022,
		0,
		Lang.get(25104),
		16010,
		22,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[3]
		}
	},
	[16010023] = {
		16010023,
		0,
		Lang.get(25105),
		16010,
		23,
		188,
		{
			RTResTalkAction[16]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[19] = 16217
	},
	[16010024] = {
		16010024,
		0,
		Lang.get(25106),
		16010,
		24,
		188,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[16010025] = {
		16010025,
		0,
		Lang.get(25107),
		16010,
		25,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16010026] = {
		16010026,
		0,
		Lang.get(25108),
		16010,
		26,
		638,
		{
			RTResTalkAction[16]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		16095,
		nil,
		1,
		nil,
		1,
		nil,
		16095
	},
	[16010027] = {
		16010027,
		0,
		Lang.get(25109),
		16010,
		27,
		639,
		{
			RTResTalkAction[67]
		},
		nil,
		nil,
		3
	},
	[16010028] = {
		16010028,
		0,
		Lang.get(25110),
		16010,
		28,
		338,
		{
			RTResTalkAction[9],
			RTResTalkAction[68]
		}
	},
	[16010029] = {
		16010029,
		0,
		Lang.get(25111),
		16010,
		29,
		188,
		{
			RTResTalkAction[17],
			RTResTalkAction[3]
		}
	},
	[16011001] = {
		16011001,
		0,
		Lang.get(25112),
		16011,
		1,
		188,
		{
			RTResTalkAction[24]
		},
		nil,
		nil,
		3,
		nil,
		63,
		16095,
		nil,
		nil,
		nil,
		1,
		nil,
		16095
	},
	[16011002] = {
		16011002,
		0,
		Lang.get(25113),
		16011,
		2,
		338,
		{
			RTResTalkAction[6],
			RTResTalkAction[16]
		}
	},
	[16011003] = {
		16011003,
		0,
		Lang.get(25114),
		16011,
		3,
		188,
		{
			RTResTalkAction[112],
			RTResTalkAction[3]
		}
	},
	[16011004] = {
		16011004,
		0,
		Lang.get(25115),
		16011,
		4,
		338,
		{
			RTResTalkAction[4],
			RTResTalkAction[16]
		}
	},
	[16011005] = {
		16011005,
		0,
		Lang.get(25116),
		16011,
		5,
		338,
		{
			RTResTalkAction[6]
		}
	},
	[16011006] = {
		16011006,
		0,
		Lang.get(25117),
		16011,
		6,
		188,
		{
			RTResTalkAction[61],
			RTResTalkAction[3]
		}
	},
	[16011007] = {
		16011007,
		0,
		Lang.get(25118),
		16011,
		7,
		188,
		{
			RTResTalkAction[24]
		}
	},
	[16011008] = {
		16011008,
		0,
		Lang.get(25119),
		16011,
		8,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16011009] = {
		16011009,
		0,
		Lang.get(25120),
		16011,
		9,
		338,
		{
			RTResTalkAction[7],
			RTResTalkAction[16]
		}
	},
	[16011010] = {
		16011010,
		0,
		Lang.get(25121),
		16011,
		10,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[3]
		}
	},
	[16011011] = {
		16011011,
		2,
		Lang.get(25122),
		16011,
		11,
		338,
		{
			RTResTalkAction[16]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		16096,
		nil,
		1,
		nil,
		1,
		nil,
		16096
	},
	[16011012] = {
		16011012,
		2,
		Lang.get(25123),
		16011,
		12,
		338,
		{
			RTResTalkAction[4]
		},
		nil,
		nil,
		3
	},
	[16011013] = {
		16011013,
		0,
		Lang.get(25124),
		16011,
		13,
		338,
		{
			RTResTalkAction[1]
		}
	},
	[16011014] = {
		16011014,
		0,
		Lang.get(25125),
		16011,
		14,
		188,
		{
			RTResTalkAction[61],
			RTResTalkAction[3]
		}
	},
	[16011015] = {
		16011015,
		0,
		Lang.get(25126),
		16011,
		15,
		338,
		{
			RTResTalkAction[4],
			RTResTalkAction[16]
		}
	},
	[16011016] = {
		16011016,
		0,
		Lang.get(25127),
		16011,
		16,
		338,
		{
			RTResTalkAction[6]
		}
	},
	[16011017] = {
		16011017,
		0,
		Lang.get(25128),
		16011,
		17,
		188,
		{
			RTResTalkAction[23],
			RTResTalkAction[3]
		}
	},
	[16011018] = {
		16011018,
		0,
		Lang.get(25129),
		16011,
		18,
		188,
		{
			RTResTalkAction[61]
		}
	},
	[16011019] = {
		16011019,
		0,
		Lang.get(25130),
		16011,
		19,
		338,
		{
			RTResTalkAction[6],
			RTResTalkAction[16]
		}
	},
	[16011020] = {
		16011020,
		0,
		Lang.get(25131),
		16011,
		20,
		338,
		{
			RTResTalkAction[1]
		}
	},
	[16011021] = {
		16011021,
		0,
		Lang.get(25132),
		16011,
		21,
		338,
		{
			RTResTalkAction[7]
		}
	},
	[16011022] = {
		16011022,
		0,
		Lang.get(25133),
		16011,
		22,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[3]
		}
	},
	[16011023] = {
		16011023,
		0,
		Lang.get(25134),
		16011,
		23,
		338,
		{
			RTResTalkAction[6],
			RTResTalkAction[16]
		}
	},
	[16012001] = {
		16012001,
		0,
		Lang.get(25135),
		16012,
		1,
		135,
		nil,
		1,
		nil,
		nil,
		nil,
		121,
		16018,
		nil,
		nil,
		nil,
		1,
		nil,
		16018
	},
	[16012002] = {
		16012002,
		0,
		Lang.get(25136),
		16012,
		2,
		135,
		nil,
		1
	},
	[16012003] = {
		16012003,
		0,
		Lang.get(25137),
		16012,
		3,
		103,
		{
			RTResTalkAction[113]
		},
		nil,
		nil,
		3
	},
	[16012004] = {
		16012004,
		0,
		Lang.get(25138),
		16012,
		4,
		135,
		{
			RTResTalkAction[114],
			RTResTalkAction[115]
		}
	},
	[16012005] = {
		16012005,
		0,
		Lang.get(25139),
		16012,
		5,
		135,
		{
			RTResTalkAction[114]
		}
	},
	[16012006] = {
		16012006,
		0,
		Lang.get(25140),
		16012,
		6,
		135,
		{
			RTResTalkAction[114]
		}
	},
	[16012007] = {
		16012007,
		0,
		Lang.get(25141),
		16012,
		7,
		103,
		{
			RTResTalkAction[113],
			RTResTalkAction[116]
		}
	},
	[16012008] = {
		16012008,
		0,
		Lang.get(25142),
		16012,
		8,
		135,
		{
			RTResTalkAction[114],
			RTResTalkAction[115]
		}
	},
	[16012009] = {
		16012009,
		0,
		Lang.get(25143),
		16012,
		9,
		103,
		{
			RTResTalkAction[113],
			RTResTalkAction[116]
		}
	},
	[16012010] = {
		16012010,
		0,
		"…………",
		16012,
		10,
		110,
		{
			RTResTalkAction[117],
			RTResTalkAction[115]
		}
	},
	[16012011] = {
		16012011,
		0,
		Lang.get(25144),
		16012,
		11,
		110,
		{
			RTResTalkAction[117]
		}
	},
	[16012012] = {
		16012012,
		0,
		Lang.get(25145),
		16012,
		12,
		135,
		{
			RTResTalkAction[114],
			RTResTalkAction[118]
		}
	},
	[16012013] = {
		16012013,
		0,
		Lang.get(25146),
		16012,
		13,
		103,
		{
			RTResTalkAction[113],
			RTResTalkAction[116]
		}
	},
	[16012014] = {
		16012014,
		0,
		Lang.get(25147),
		16012,
		14,
		135,
		{
			RTResTalkAction[114],
			RTResTalkAction[115]
		}
	},
	[16012015] = {
		16012015,
		0,
		Lang.get(25148),
		16012,
		15,
		110,
		{
			RTResTalkAction[117],
			RTResTalkAction[116]
		}
	},
	[16041001] = {
		16041001,
		0,
		Lang.get(25984),
		16041,
		1,
		135,
		nil,
		1,
		nil,
		nil,
		nil,
		30,
		16019,
		nil,
		1,
		nil,
		1,
		nil,
		16019
	},
	[16041002] = {
		16041002,
		0,
		Lang.get(25985),
		16041,
		2,
		135,
		nil,
		1
	},
	[16041003] = {
		16041003,
		0,
		Lang.get(25986),
		16041,
		3,
		135,
		{
			RTResTalkAction[114]
		},
		nil,
		nil,
		3
	},
	[16041004] = {
		16041004,
		0,
		Lang.get(25987),
		16041,
		4,
		135,
		{
			RTResTalkAction[114]
		}
	},
	[16041005] = {
		16041005,
		0,
		Lang.get(25988),
		16041,
		5,
		135,
		{
			RTResTalkAction[114]
		}
	},
	[16041006] = {
		16041006,
		0,
		Lang.get(25989),
		16041,
		6,
		103,
		{
			RTResTalkAction[113],
			RTResTalkAction[116]
		}
	},
	[16041007] = {
		16041007,
		0,
		Lang.get(25990),
		16041,
		7,
		103,
		{
			RTResTalkAction[113]
		}
	},
	[16041008] = {
		16041008,
		0,
		Lang.get(25991),
		16041,
		8,
		135,
		{
			RTResTalkAction[114],
			RTResTalkAction[115]
		}
	},
	[16041009] = {
		16041009,
		0,
		Lang.get(25992),
		16041,
		9,
		135,
		{
			RTResTalkAction[114]
		}
	},
	[16041010] = {
		16041010,
		0,
		Lang.get(25993),
		16041,
		10,
		135,
		{
			RTResTalkAction[114]
		}
	},
	[16041011] = {
		16041011,
		0,
		Lang.get(25994),
		16041,
		11,
		103,
		{
			RTResTalkAction[113],
			RTResTalkAction[116]
		}
	},
	[16041012] = {
		16041012,
		0,
		Lang.get(25995),
		16041,
		12,
		188,
		{
			RTResTalkAction[115]
		},
		1
	},
	[16041013] = {
		16041013,
		0,
		Lang.get(25996),
		16041,
		13,
		338,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		16020,
		nil,
		1,
		nil,
		1,
		nil,
		16020
	},
	[16041014] = {
		16041014,
		0,
		Lang.get(25997),
		16041,
		14,
		103,
		{
			RTResTalkAction[113]
		},
		nil,
		nil,
		3
	},
	[16041015] = {
		16041015,
		0,
		Lang.get(25998),
		16041,
		15,
		188,
		{
			RTResTalkAction[23],
			RTResTalkAction[115]
		}
	},
	[16013001] = {
		16013001,
		0,
		Lang.get(25149),
		16013,
		1,
		135,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		16022,
		nil,
		nil,
		nil,
		1,
		nil,
		16022
	},
	[16013002] = {
		16013002,
		0,
		Lang.get(25150),
		16013,
		2,
		103,
		{
			RTResTalkAction[113]
		},
		nil,
		nil,
		3
	},
	[16013003] = {
		16013003,
		0,
		Lang.get(25151),
		16013,
		3,
		135,
		{
			RTResTalkAction[114],
			RTResTalkAction[115]
		}
	},
	[16013004] = {
		16013004,
		0,
		Lang.get(25152),
		16013,
		4,
		103,
		{
			RTResTalkAction[113],
			RTResTalkAction[116]
		}
	},
	[16013005] = {
		16013005,
		0,
		Lang.get(25153),
		16013,
		5,
		188,
		{
			RTResTalkAction[17],
			RTResTalkAction[115]
		}
	},
	[16013006] = {
		16013006,
		0,
		Lang.get(25154),
		16013,
		6,
		188,
		{
			RTResTalkAction[106]
		}
	},
	[16013007] = {
		16013007,
		0,
		Lang.get(25155),
		16013,
		7,
		103,
		{
			RTResTalkAction[113],
			RTResTalkAction[16]
		}
	},
	[16013008] = {
		16013008,
		0,
		Lang.get(25156),
		16013,
		8,
		103,
		{
			RTResTalkAction[113]
		}
	},
	[16013009] = {
		16013009,
		0,
		Lang.get(25157),
		16013,
		9,
		188,
		{
			RTResTalkAction[106],
			RTResTalkAction[115]
		}
	},
	[16013010] = {
		16013010,
		0,
		Lang.get(25158),
		16013,
		10,
		103,
		{
			RTResTalkAction[113],
			RTResTalkAction[16]
		}
	},
	[16013011] = {
		16013011,
		0,
		Lang.get(25159),
		16013,
		11,
		188,
		{
			RTResTalkAction[17],
			RTResTalkAction[115]
		}
	},
	[16013012] = {
		16013012,
		0,
		Lang.get(25160),
		16013,
		12,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16013013] = {
		16013013,
		0,
		Lang.get(25161),
		16013,
		13,
		110,
		{
			RTResTalkAction[117],
			RTResTalkAction[16]
		}
	},
	[16013014] = {
		16013014,
		0,
		Lang.get(25162),
		16013,
		14,
		110,
		{
			RTResTalkAction[117]
		}
	},
	[16013015] = {
		16013015,
		0,
		Lang.get(25163),
		16013,
		15,
		103,
		{
			RTResTalkAction[113],
			RTResTalkAction[118]
		}
	},
	[16013016] = {
		16013016,
		0,
		Lang.get(25164),
		16013,
		16,
		103,
		{
			RTResTalkAction[113]
		}
	},
	[16013017] = {
		16013017,
		0,
		Lang.get(25165),
		16013,
		17,
		188,
		{
			RTResTalkAction[61],
			RTResTalkAction[115]
		}
	},
	[16013018] = {
		16013018,
		0,
		Lang.get(25166),
		16013,
		18,
		103,
		{
			RTResTalkAction[113],
			RTResTalkAction[16]
		}
	},
	[16013019] = {
		16013019,
		0,
		Lang.get(25167),
		16013,
		19,
		188,
		{
			RTResTalkAction[24],
			RTResTalkAction[115]
		}
	},
	[16013020] = {
		16013020,
		0,
		Lang.get(25168),
		16013,
		20,
		110,
		{
			RTResTalkAction[117],
			RTResTalkAction[16]
		}
	},
	[16013021] = {
		16013021,
		0,
		Lang.get(25169),
		16013,
		21,
		188,
		{
			RTResTalkAction[23],
			RTResTalkAction[118]
		}
	},
	[16013022] = {
		16013022,
		0,
		Lang.get(25170),
		16013,
		22,
		110,
		{
			RTResTalkAction[117],
			RTResTalkAction[16]
		}
	},
	[16013023] = {
		16013023,
		0,
		Lang.get(25171),
		16013,
		23,
		338,
		{
			RTResTalkAction[6],
			RTResTalkAction[118]
		}
	},
	[16013024] = {
		16013024,
		0,
		Lang.get(25172),
		16013,
		24,
		110,
		{
			RTResTalkAction[117],
			RTResTalkAction[3]
		}
	},
	[16013025] = {
		16013025,
		0,
		Lang.get(25173),
		16013,
		25,
		110,
		{
			RTResTalkAction[117]
		}
	},
	[16013026] = {
		16013026,
		0,
		Lang.get(25174),
		16013,
		26,
		110,
		{
			RTResTalkAction[117]
		}
	},
	[16013027] = {
		16013027,
		0,
		Lang.get(61773),
		16013,
		27,
		338,
		{
			RTResTalkAction[4],
			RTResTalkAction[118]
		}
	},
	[16013028] = {
		16013028,
		0,
		Lang.get(25176),
		16013,
		28,
		338,
		{
			RTResTalkAction[6]
		}
	},
	[16013029] = {
		16013029,
		0,
		Lang.get(25177),
		16013,
		29,
		338,
		{
			RTResTalkAction[7]
		}
	},
	[16013030] = {
		16013030,
		0,
		Lang.get(25178),
		16013,
		30,
		188,
		{
			RTResTalkAction[17],
			RTResTalkAction[3]
		}
	},
	[16013031] = {
		16013031,
		0,
		Lang.get(25179),
		16013,
		31,
		338,
		{
			RTResTalkAction[7],
			RTResTalkAction[16]
		}
	},
	[16013032] = {
		16013032,
		0,
		Lang.get(25180),
		16013,
		32,
		188,
		{
			RTResTalkAction[106],
			RTResTalkAction[3]
		}
	},
	[16013033] = {
		16013033,
		0,
		Lang.get(25181),
		16013,
		33,
		110,
		{
			RTResTalkAction[117],
			RTResTalkAction[16]
		}
	},
	[16013034] = {
		16013034,
		0,
		Lang.get(25182),
		16013,
		34,
		338,
		{
			RTResTalkAction[7],
			RTResTalkAction[118]
		}
	},
	[16013035] = {
		16013035,
		0,
		Lang.get(25183),
		16013,
		35,
		191,
		{
			RTResTalkAction[3]
		},
		1,
		nil,
		nil,
		nil,
		63,
		16097,
		nil,
		1,
		nil,
		1,
		nil,
		16097
	},
	[16013036] = {
		16013036,
		0,
		"…………",
		16013,
		36,
		188,
		nil,
		1
	},
	[16013037] = {
		16013037,
		0,
		Lang.get(25184),
		16013,
		37,
		188,
		{
			RTResTalkAction[61]
		},
		nil,
		nil,
		3
	},
	[16013038] = {
		16013038,
		0,
		Lang.get(25185),
		16013,
		38,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[16]
		}
	},
	[16013039] = {
		16013039,
		0,
		Lang.get(25186),
		16013,
		39,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16013040] = {
		16013040,
		0,
		Lang.get(25187),
		16013,
		40,
		188,
		{
			RTResTalkAction[23],
			RTResTalkAction[19]
		}
	},
	[16013041] = {
		16013041,
		0,
		Lang.get(25188),
		16013,
		41,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[16]
		}
	},
	[16013042] = {
		16013042,
		0,
		Lang.get(25189),
		16013,
		42,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[19]
		}
	},
	[16013043] = {
		16013043,
		0,
		Lang.get(25190),
		16013,
		43,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16013044] = {
		16013044,
		0,
		Lang.get(25191),
		16013,
		44,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16013045] = {
		16013045,
		0,
		Lang.get(25192),
		16013,
		45,
		191,
		{
			RTResTalkAction[18],
			RTResTalkAction[16]
		}
	},
	[16013046] = {
		16013046,
		0,
		Lang.get(25193),
		16013,
		46,
		191,
		{
			RTResTalkAction[20]
		}
	},
	[16013047] = {
		16013047,
		0,
		Lang.get(61774),
		16013,
		47,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[19]
		}
	},
	[16014001] = {
		16014001,
		9,
		Lang.get(25194),
		16014,
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		30,
		[19] = 16121,
		[22] = 1,
		[17] = 1
	},
	[16014002] = {
		16014002,
		9,
		Lang.get(25195),
		16014,
		2,
		[22] = 1
	},
	[16014003] = {
		16014003,
		9,
		Lang.get(25196),
		16014,
		3,
		[22] = 1
	},
	[16014004] = {
		16014004,
		9,
		Lang.get(25197),
		16014,
		4,
		[22] = 1
	},
	[16014005] = {
		16014005,
		9,
		Lang.get(25198),
		16014,
		5,
		[22] = 1
	},
	[16014006] = {
		16014006,
		9,
		Lang.get(25199),
		16014,
		6,
		[22] = 1
	},
	[16014007] = {
		16014007,
		9,
		Lang.get(25200),
		16014,
		7,
		[22] = 1
	},
	[16014008] = {
		16014008,
		0,
		Lang.get(25201),
		16014,
		8,
		645,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		16021,
		nil,
		nil,
		nil,
		1,
		nil,
		16021
	},
	[16014009] = {
		16014009,
		0,
		Lang.get(25202),
		16014,
		9,
		645,
		{
			RTResTalkAction[119],
			RTResTalkAction[120]
		},
		nil,
		nil,
		3
	},
	[16014010] = {
		16014010,
		0,
		Lang.get(25203),
		16014,
		10,
		646,
		{
			RTResTalkAction[119],
			RTResTalkAction[120]
		}
	},
	[16014011] = {
		16014011,
		0,
		Lang.get(25204),
		16014,
		11,
		645,
		{
			RTResTalkAction[119],
			RTResTalkAction[120]
		}
	},
	[16014012] = {
		16014012,
		0,
		Lang.get(25205),
		16014,
		12,
		646,
		{
			RTResTalkAction[119],
			RTResTalkAction[120]
		}
	},
	[16014013] = {
		16014013,
		0,
		Lang.get(25206),
		16014,
		13,
		645,
		{
			RTResTalkAction[119],
			RTResTalkAction[120]
		}
	},
	[16014014] = {
		16014014,
		0,
		Lang.get(25207),
		16014,
		14,
		645,
		{
			RTResTalkAction[119],
			RTResTalkAction[120]
		}
	},
	[16014015] = {
		16014015,
		0,
		Lang.get(25208),
		16014,
		15,
		646,
		{
			RTResTalkAction[119],
			RTResTalkAction[120]
		}
	},
	[16014016] = {
		16014016,
		0,
		Lang.get(25209),
		16014,
		16,
		645,
		{
			RTResTalkAction[119],
			RTResTalkAction[120]
		}
	},
	[16014017] = {
		16014017,
		0,
		Lang.get(25210),
		16014,
		17,
		645,
		{
			RTResTalkAction[119],
			RTResTalkAction[120]
		}
	},
	[16014018] = {
		16014018,
		0,
		Lang.get(25211),
		16014,
		18,
		646,
		{
			RTResTalkAction[119],
			RTResTalkAction[120]
		}
	},
	[16014019] = {
		16014019,
		0,
		Lang.get(25212),
		16014,
		19,
		645,
		{
			RTResTalkAction[119],
			RTResTalkAction[120]
		}
	},
	[16014020] = {
		16014020,
		0,
		Lang.get(25213),
		16014,
		20,
		646,
		{
			RTResTalkAction[119],
			RTResTalkAction[120]
		}
	},
	[16014021] = {
		16014021,
		0,
		Lang.get(25214),
		16014,
		21,
		189,
		{
			RTResTalkAction[121],
			RTResTalkAction[122],
			RTResTalkAction[123]
		}
	},
	[16014022] = {
		16014022,
		0,
		Lang.get(25215),
		16014,
		22,
		646,
		{
			RTResTalkAction[119],
			RTResTalkAction[120],
			RTResTalkAction[30]
		}
	},
	[16014023] = {
		16014023,
		0,
		Lang.get(25216),
		16014,
		23,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[122],
			RTResTalkAction[123]
		}
	},
	[16014024] = {
		16014024,
		0,
		Lang.get(25217),
		16014,
		24,
		645,
		{
			RTResTalkAction[119],
			RTResTalkAction[120],
			RTResTalkAction[30]
		}
	},
	[16014025] = {
		16014025,
		0,
		Lang.get(25218),
		16014,
		25,
		189,
		{
			RTResTalkAction[56],
			RTResTalkAction[122],
			RTResTalkAction[123]
		}
	},
	[16014026] = {
		16014026,
		0,
		Lang.get(25219),
		16014,
		26,
		188,
		{
			RTResTalkAction[30]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		16098,
		nil,
		1,
		nil,
		1,
		nil,
		16098
	},
	[16014027] = {
		16014027,
		0,
		Lang.get(25220),
		16014,
		27,
		338,
		{
			RTResTalkAction[55]
		},
		nil,
		nil,
		3
	},
	[16014028] = {
		16014028,
		5,
		Lang.get(25221),
		16014,
		28,
		189,
		{
			RTResTalkAction[3]
		},
		1
	},
	[16014029] = {
		16014029,
		0,
		Lang.get(25222),
		16014,
		29,
		188,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[16014030] = {
		16014030,
		0,
		Lang.get(25223),
		16014,
		30,
		338,
		{
			RTResTalkAction[7],
			RTResTalkAction[16]
		}
	},
	[16014031] = {
		16014031,
		0,
		Lang.get(25224),
		16014,
		31,
		188,
		{
			RTResTalkAction[24],
			RTResTalkAction[3]
		}
	},
	[16014032] = {
		16014032,
		5,
		Lang.get(25225),
		16014,
		32,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[16]
		}
	},
	[16014033] = {
		16014033,
		5,
		Lang.get(25226),
		16014,
		33,
		646,
		{
			RTResTalkAction[124],
			RTResTalkAction[30]
		}
	},
	[16014034] = {
		16014034,
		0,
		Lang.get(25227),
		16014,
		34,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[123]
		}
	},
	[16015001] = {
		16015001,
		0,
		Lang.get(25228),
		16015,
		1,
		189,
		nil,
		1,
		nil,
		nil,
		nil,
		30,
		16099,
		nil,
		nil,
		nil,
		1,
		nil,
		16099
	},
	[16015002] = {
		16015002,
		0,
		Lang.get(25229),
		16015,
		2,
		188,
		nil,
		1
	},
	[16015003] = {
		16015003,
		0,
		Lang.get(25230),
		16015,
		3,
		338,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[16015004] = {
		16015004,
		0,
		Lang.get(25231),
		16015,
		4,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[3]
		}
	},
	[16015005] = {
		16015005,
		0,
		Lang.get(25232),
		16015,
		5,
		189,
		{
			RTResTalkAction[26]
		}
	},
	[16015006] = {
		16015006,
		0,
		Lang.get(25233),
		16015,
		6,
		189,
		{
			RTResTalkAction[26]
		}
	},
	[16015007] = {
		16015007,
		0,
		Lang.get(25234),
		16015,
		7,
		338,
		{
			RTResTalkAction[7],
			RTResTalkAction[30]
		}
	},
	[16015008] = {
		16015008,
		0,
		Lang.get(25235),
		16015,
		8,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[3]
		}
	},
	[16015009] = {
		16015009,
		0,
		Lang.get(25236),
		16015,
		9,
		646,
		{
			RTResTalkAction[124],
			RTResTalkAction[30]
		}
	},
	[16015010] = {
		16015010,
		0,
		Lang.get(25237),
		16015,
		10,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[123]
		}
	},
	[16015011] = {
		16015011,
		0,
		Lang.get(25238),
		16015,
		11,
		189,
		{
			RTResTalkAction[26]
		}
	},
	[16015012] = {
		16015012,
		0,
		"……",
		16015,
		12,
		338,
		{
			RTResTalkAction[4],
			RTResTalkAction[30]
		}
	},
	[16015013] = {
		16015013,
		0,
		Lang.get(25239),
		16015,
		13,
		646,
		{
			RTResTalkAction[124],
			RTResTalkAction[3]
		}
	},
	[16015014] = {
		16015014,
		0,
		Lang.get(25240),
		16015,
		14,
		645,
		{
			RTResTalkAction[125],
			RTResTalkAction[123]
		}
	},
	[16015015] = {
		16015015,
		0,
		Lang.get(25241),
		16015,
		15,
		338,
		{
			RTResTalkAction[7],
			RTResTalkAction[122]
		}
	},
	[16015016] = {
		16015016,
		0,
		Lang.get(25242),
		16015,
		16,
		646,
		{
			RTResTalkAction[124],
			RTResTalkAction[3]
		}
	},
	[16015017] = {
		16015017,
		0,
		Lang.get(25243),
		16015,
		17,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[123]
		}
	},
	[16015018] = {
		16015018,
		0,
		Lang.get(25244),
		16015,
		18,
		338,
		{
			RTResTalkAction[4],
			RTResTalkAction[30]
		}
	},
	[16015019] = {
		16015019,
		0,
		Lang.get(25245),
		16015,
		19,
		646,
		{
			RTResTalkAction[124],
			RTResTalkAction[3]
		}
	},
	[16015020] = {
		16015020,
		0,
		Lang.get(25246),
		16015,
		20,
		645,
		{
			RTResTalkAction[125],
			RTResTalkAction[123]
		}
	},
	[16015021] = {
		16015021,
		0,
		Lang.get(25247),
		16015,
		21,
		338,
		{
			RTResTalkAction[6],
			RTResTalkAction[122]
		}
	},
	[16015022] = {
		16015022,
		0,
		Lang.get(25248),
		16015,
		22,
		646,
		{
			RTResTalkAction[124],
			RTResTalkAction[3]
		}
	},
	[16015023] = {
		16015023,
		0,
		Lang.get(25249),
		16015,
		23,
		338,
		{
			RTResTalkAction[6],
			RTResTalkAction[123]
		}
	},
	[16015024] = {
		16015024,
		0,
		Lang.get(25250),
		16015,
		24,
		338,
		{
			RTResTalkAction[6]
		}
	},
	[16015025] = {
		16015025,
		0,
		Lang.get(25251),
		16015,
		25,
		646,
		{
			RTResTalkAction[124],
			RTResTalkAction[3]
		}
	},
	[16015026] = {
		16015026,
		0,
		Lang.get(25252),
		16015,
		26,
		338,
		{
			RTResTalkAction[7],
			RTResTalkAction[123]
		}
	},
	[16015027] = {
		16015027,
		0,
		Lang.get(25253),
		16015,
		27,
		338,
		{
			RTResTalkAction[6]
		}
	},
	[16015028] = {
		16015028,
		0,
		Lang.get(25254),
		16015,
		28,
		188,
		{
			RTResTalkAction[61],
			RTResTalkAction[3]
		}
	},
	[16015029] = {
		16015029,
		0,
		Lang.get(25255),
		16015,
		29,
		646,
		{
			RTResTalkAction[124],
			RTResTalkAction[16]
		}
	},
	[16015030] = {
		16015030,
		0,
		Lang.get(25256),
		16015,
		30,
		338,
		{
			RTResTalkAction[7],
			RTResTalkAction[123]
		}
	},
	[16016001] = {
		16016001,
		0,
		Lang.get(25257),
		16016,
		1,
		189,
		nil,
		1,
		nil,
		nil,
		nil,
		30,
		16029,
		nil,
		nil,
		nil,
		1,
		nil,
		16029
	},
	[16016002] = {
		16016002,
		0,
		Lang.get(25258),
		16016,
		2,
		188,
		{
			RTResTalkAction[24]
		},
		nil,
		nil,
		3
	},
	[16016003] = {
		16016003,
		0,
		Lang.get(25259),
		16016,
		3,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16016004] = {
		16016004,
		0,
		Lang.get(25260),
		16016,
		4,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[16]
		}
	},
	[16016005] = {
		16016005,
		0,
		Lang.get(25261),
		16016,
		5,
		338,
		{
			RTResTalkAction[1],
			RTResTalkAction[30]
		}
	},
	[16016006] = {
		16016006,
		0,
		Lang.get(25262),
		16016,
		6,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[3]
		}
	},
	[16016007] = {
		16016007,
		0,
		Lang.get(25263),
		16016,
		7,
		188,
		{
			RTResTalkAction[61],
			RTResTalkAction[30]
		}
	},
	[16016008] = {
		16016008,
		0,
		Lang.get(25264),
		16016,
		8,
		338,
		{
			RTResTalkAction[6],
			RTResTalkAction[16]
		}
	},
	[16016009] = {
		16016009,
		0,
		Lang.get(25265),
		16016,
		9,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[3]
		}
	},
	[16016010] = {
		16016010,
		0,
		Lang.get(25266),
		16016,
		10,
		188,
		{
			RTResTalkAction[24],
			RTResTalkAction[30]
		}
	},
	[16016011] = {
		16016011,
		0,
		Lang.get(25267),
		16016,
		11,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[16]
		}
	},
	[16016012] = {
		16016012,
		0,
		Lang.get(25268),
		16016,
		12,
		189,
		{
			RTResTalkAction[26]
		}
	},
	[16016013] = {
		16016013,
		0,
		Lang.get(25269),
		16016,
		13,
		338,
		{
			RTResTalkAction[55],
			RTResTalkAction[30]
		}
	},
	[16016014] = {
		16016014,
		0,
		Lang.get(25270),
		16016,
		14,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[3]
		}
	},
	[16016015] = {
		16016015,
		0,
		Lang.get(25271),
		16016,
		15,
		189,
		{
			RTResTalkAction[26]
		}
	},
	[16016016] = {
		16016016,
		0,
		Lang.get(25272),
		16016,
		16,
		338,
		{
			RTResTalkAction[55],
			RTResTalkAction[30]
		}
	},
	[16016017] = {
		16016017,
		0,
		Lang.get(25273),
		16016,
		17,
		191,
		{
			RTResTalkAction[3]
		},
		1,
		nil,
		nil,
		nil,
		63,
		16100,
		nil,
		1,
		nil,
		1,
		nil,
		16100
	},
	[16016018] = {
		16016018,
		0,
		Lang.get(25274),
		16016,
		18,
		188,
		{
			RTResTalkAction[61]
		},
		nil,
		nil,
		3
	},
	[16016019] = {
		16016019,
		0,
		Lang.get(25275),
		16016,
		19,
		191,
		{
			RTResTalkAction[20],
			RTResTalkAction[16]
		}
	},
	[16016020] = {
		16016020,
		0,
		Lang.get(25276),
		16016,
		20,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16016021] = {
		16016021,
		0,
		Lang.get(61775),
		16016,
		21,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[19]
		}
	},
	[16016022] = {
		16016022,
		2,
		Lang.get(25277),
		16016,
		22,
		188,
		{
			RTResTalkAction[23]
		}
	},
	[16016023] = {
		16016023,
		2,
		Lang.get(25278),
		16016,
		23,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16016024] = {
		16016024,
		2,
		Lang.get(25279),
		16016,
		24,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16016025] = {
		16016025,
		0,
		Lang.get(25280),
		16016,
		25,
		191,
		{
			RTResTalkAction[18],
			RTResTalkAction[16]
		}
	},
	[16016026] = {
		16016026,
		0,
		Lang.get(25281),
		16016,
		26,
		188,
		{
			RTResTalkAction[24],
			RTResTalkAction[19]
		}
	},
	[16016027] = {
		16016027,
		0,
		Lang.get(25282),
		16016,
		27,
		191,
		{
			RTResTalkAction[20],
			RTResTalkAction[16]
		}
	},
	[16016028] = {
		16016028,
		0,
		Lang.get(25283),
		16016,
		28,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16017001] = {
		16017001,
		0,
		Lang.get(25284),
		16017,
		1,
		646,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		16101,
		nil,
		nil,
		nil,
		1,
		nil,
		16101
	},
	[16017002] = {
		16017002,
		0,
		Lang.get(25285),
		16017,
		2,
		646,
		{
			RTResTalkAction[119],
			RTResTalkAction[120]
		},
		nil,
		nil,
		3
	},
	[16017003] = {
		16017003,
		0,
		Lang.get(25286),
		16017,
		3,
		646,
		{
			RTResTalkAction[119],
			RTResTalkAction[120]
		}
	},
	[16017004] = {
		16017004,
		0,
		Lang.get(25287),
		16017,
		4,
		645,
		{
			RTResTalkAction[119],
			RTResTalkAction[120]
		}
	},
	[16017005] = {
		16017005,
		0,
		Lang.get(25288),
		16017,
		5,
		645,
		{
			RTResTalkAction[119],
			RTResTalkAction[120]
		}
	},
	[16017006] = {
		16017006,
		0,
		Lang.get(25289),
		16017,
		6,
		645,
		{
			RTResTalkAction[119],
			RTResTalkAction[120]
		}
	},
	[16017007] = {
		16017007,
		0,
		Lang.get(25290),
		16017,
		7,
		646,
		{
			RTResTalkAction[119],
			RTResTalkAction[120]
		}
	},
	[16017008] = {
		16017008,
		0,
		Lang.get(25291),
		16017,
		8,
		646,
		{
			RTResTalkAction[119],
			RTResTalkAction[120]
		}
	},
	[16017009] = {
		16017009,
		0,
		Lang.get(25292),
		16017,
		9,
		646,
		{
			RTResTalkAction[119],
			RTResTalkAction[120]
		}
	},
	[16017010] = {
		16017010,
		0,
		Lang.get(25293),
		16017,
		10,
		645,
		{
			RTResTalkAction[119],
			RTResTalkAction[120]
		}
	},
	[16017011] = {
		16017011,
		0,
		Lang.get(25294),
		16017,
		11,
		191,
		{
			RTResTalkAction[18],
			RTResTalkAction[122],
			RTResTalkAction[123]
		}
	},
	[16017012] = {
		16017012,
		0,
		Lang.get(25295),
		16017,
		12,
		646,
		{
			RTResTalkAction[119],
			RTResTalkAction[120],
			RTResTalkAction[19]
		}
	},
	[16017013] = {
		16017013,
		0,
		Lang.get(25296),
		16017,
		13,
		646,
		{
			RTResTalkAction[119],
			RTResTalkAction[120]
		}
	},
	[16017014] = {
		16017014,
		0,
		Lang.get(25297),
		16017,
		14,
		645,
		{
			RTResTalkAction[119],
			RTResTalkAction[120]
		}
	},
	[16017015] = {
		16017015,
		0,
		Lang.get(25298),
		16017,
		15,
		645,
		{
			RTResTalkAction[119],
			RTResTalkAction[120]
		}
	},
	[16017016] = {
		16017016,
		0,
		Lang.get(61776),
		16017,
		16,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[122],
			RTResTalkAction[123]
		}
	},
	[16017017] = {
		16017017,
		0,
		Lang.get(25299),
		16017,
		17,
		191,
		{
			RTResTalkAction[20]
		}
	},
	[16017018] = {
		16017018,
		0,
		Lang.get(25300),
		16017,
		18,
		646,
		{
			RTResTalkAction[119],
			RTResTalkAction[120],
			RTResTalkAction[19]
		}
	},
	[16017019] = {
		16017019,
		0,
		Lang.get(25301),
		16017,
		19,
		646,
		{
			RTResTalkAction[119],
			RTResTalkAction[120]
		}
	},
	[16017020] = {
		16017020,
		0,
		Lang.get(25302),
		16017,
		20,
		191,
		{
			RTResTalkAction[18],
			RTResTalkAction[122],
			RTResTalkAction[123]
		}
	},
	[16017021] = {
		16017021,
		0,
		Lang.get(25303),
		16017,
		21,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16017022] = {
		16017022,
		0,
		Lang.get(25304),
		16017,
		22,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16017023] = {
		16017023,
		0,
		Lang.get(25305),
		16017,
		23,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16017024] = {
		16017024,
		0,
		Lang.get(25306),
		16017,
		24,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16017025] = {
		16017025,
		0,
		Lang.get(25307),
		16017,
		25,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16017026] = {
		16017026,
		0,
		Lang.get(61777),
		16017,
		26,
		646,
		{
			RTResTalkAction[119],
			RTResTalkAction[120],
			RTResTalkAction[19]
		}
	},
	[16017027] = {
		16017027,
		0,
		Lang.get(25308),
		16017,
		27,
		645,
		{
			RTResTalkAction[119],
			RTResTalkAction[120]
		}
	},
	[16017028] = {
		16017028,
		0,
		Lang.get(25309),
		16017,
		28,
		645,
		{
			RTResTalkAction[119],
			RTResTalkAction[120]
		}
	},
	[16017029] = {
		16017029,
		0,
		Lang.get(25310),
		16017,
		29,
		645,
		{
			RTResTalkAction[119],
			RTResTalkAction[120]
		}
	},
	[16017030] = {
		16017030,
		0,
		Lang.get(25311),
		16017,
		30,
		191,
		{
			RTResTalkAction[20],
			RTResTalkAction[122],
			RTResTalkAction[123]
		}
	},
	[16017031] = {
		16017031,
		0,
		Lang.get(25312),
		16017,
		31,
		645,
		{
			RTResTalkAction[119],
			RTResTalkAction[120],
			RTResTalkAction[19]
		}
	},
	[16017032] = {
		16017032,
		0,
		Lang.get(25313),
		16017,
		32,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[122],
			RTResTalkAction[123]
		}
	},
	[16017033] = {
		16017033,
		0,
		Lang.get(25314),
		16017,
		33,
		191,
		{
			RTResTalkAction[18]
		}
	},
	[16017034] = {
		16017034,
		0,
		Lang.get(25315),
		16017,
		34,
		645,
		{
			RTResTalkAction[119],
			RTResTalkAction[120],
			RTResTalkAction[19]
		}
	},
	[16017035] = {
		16017035,
		0,
		Lang.get(25316),
		16017,
		35,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[122],
			RTResTalkAction[123]
		}
	},
	[16017036] = {
		16017036,
		0,
		Lang.get(25317),
		16017,
		36,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16017037] = {
		16017037,
		0,
		Lang.get(25318),
		16017,
		37,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16017038] = {
		16017038,
		0,
		Lang.get(25319),
		16017,
		38,
		646,
		{
			RTResTalkAction[119],
			RTResTalkAction[120],
			RTResTalkAction[19]
		}
	},
	[16017039] = {
		16017039,
		0,
		Lang.get(25320),
		16017,
		39,
		645,
		{
			RTResTalkAction[119],
			RTResTalkAction[120]
		}
	},
	[16017040] = {
		16017040,
		0,
		Lang.get(25321),
		16017,
		40,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[122],
			RTResTalkAction[123]
		}
	},
	[16017041] = {
		16017041,
		0,
		Lang.get(25322),
		16017,
		41,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16017042] = {
		16017042,
		0,
		Lang.get(25323),
		16017,
		42,
		646,
		{
			RTResTalkAction[119],
			RTResTalkAction[120],
			RTResTalkAction[19]
		}
	},
	[16017043] = {
		16017043,
		0,
		"…………",
		16017,
		43,
		188,
		{
			RTResTalkAction[23],
			RTResTalkAction[122],
			RTResTalkAction[123]
		}
	},
	[16017044] = {
		16017044,
		2,
		Lang.get(25324),
		16017,
		44,
		188,
		{
			RTResTalkAction[17]
		}
	},
	[16018001] = {
		16018001,
		0,
		Lang.get(25325),
		16018,
		1,
		191,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		16031,
		nil,
		nil,
		nil,
		1,
		nil,
		16031
	},
	[16018002] = {
		16018002,
		0,
		Lang.get(25326),
		16018,
		2,
		188,
		{
			RTResTalkAction[61]
		},
		nil,
		nil,
		3
	},
	[16018003] = {
		16018003,
		0,
		Lang.get(25327),
		16018,
		3,
		188,
		{
			RTResTalkAction[23]
		}
	},
	[16018004] = {
		16018004,
		0,
		Lang.get(25328),
		16018,
		4,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[16]
		}
	},
	[16018005] = {
		16018005,
		0,
		Lang.get(25329),
		16018,
		5,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16018006] = {
		16018006,
		0,
		"…………",
		16018,
		6,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[19]
		}
	},
	[16018007] = {
		16018007,
		0,
		Lang.get(25330),
		16018,
		7,
		191,
		{
			RTResTalkAction[16]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		16102,
		nil,
		1,
		nil,
		1,
		nil,
		16102
	},
	[16018008] = {
		16018008,
		5,
		Lang.get(25331),
		16018,
		8,
		188,
		{
			RTResTalkAction[15]
		},
		nil,
		nil,
		3
	},
	[16018009] = {
		16018009,
		0,
		Lang.get(25332),
		16018,
		9,
		647,
		{
			RTResTalkAction[126],
			RTResTalkAction[127],
			RTResTalkAction[16]
		}
	},
	[16018010] = {
		16018010,
		0,
		Lang.get(25333),
		16018,
		10,
		648,
		{
			RTResTalkAction[126],
			RTResTalkAction[127]
		}
	},
	[16018011] = {
		16018011,
		0,
		Lang.get(25334),
		16018,
		11,
		649,
		{
			RTResTalkAction[128],
			RTResTalkAction[129],
			RTResTalkAction[130],
			RTResTalkAction[131]
		}
	},
	[16018012] = {
		16018012,
		0,
		Lang.get(25335),
		16018,
		12,
		650,
		{
			RTResTalkAction[128],
			RTResTalkAction[129]
		}
	},
	[16018013] = {
		16018013,
		0,
		Lang.get(25336),
		16018,
		13,
		337,
		{
			RTResTalkAction[75],
			RTResTalkAction[132],
			RTResTalkAction[133]
		}
	},
	[16018014] = {
		16018014,
		0,
		Lang.get(25337),
		16018,
		14,
		188,
		{
			RTResTalkAction[17],
			RTResTalkAction[74]
		}
	},
	[16018015] = {
		16018015,
		0,
		Lang.get(25338),
		16018,
		15,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[16]
		}
	},
	[16018016] = {
		16018016,
		0,
		Lang.get(25339),
		16018,
		16,
		188,
		{
			RTResTalkAction[106],
			RTResTalkAction[19]
		}
	},
	[16018017] = {
		16018017,
		0,
		Lang.get(25340),
		16018,
		17,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[16]
		}
	},
	[16018018] = {
		16018018,
		0,
		Lang.get(25341),
		16018,
		18,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16018019] = {
		16018019,
		0,
		Lang.get(25342),
		16018,
		19,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16018020] = {
		16018020,
		0,
		Lang.get(25343),
		16018,
		20,
		188,
		{
			RTResTalkAction[23],
			RTResTalkAction[19]
		}
	},
	[16018021] = {
		16018021,
		0,
		Lang.get(25344),
		16018,
		21,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[16]
		}
	},
	[16018022] = {
		16018022,
		0,
		Lang.get(25345),
		16018,
		22,
		188,
		{
			RTResTalkAction[61],
			RTResTalkAction[19]
		}
	},
	[16018023] = {
		16018023,
		0,
		Lang.get(25346),
		16018,
		23,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[16]
		}
	},
	[16018024] = {
		16018024,
		0,
		Lang.get(25347),
		16018,
		24,
		188,
		{
			RTResTalkAction[23],
			RTResTalkAction[19]
		}
	},
	[16018025] = {
		16018025,
		0,
		Lang.get(25348),
		16018,
		25,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[16]
		}
	},
	[16018026] = {
		16018026,
		0,
		Lang.get(25349),
		16018,
		26,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16018027] = {
		16018027,
		0,
		Lang.get(25350),
		16018,
		27,
		191,
		{
			RTResTalkAction[18]
		}
	},
	[16018028] = {
		16018028,
		0,
		Lang.get(25351),
		16018,
		28,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[19]
		}
	},
	[16018029] = {
		16018029,
		0,
		Lang.get(25352),
		16018,
		29,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[16]
		}
	},
	[16018030] = {
		16018030,
		0,
		Lang.get(25353),
		16018,
		30,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16018031] = {
		16018031,
		0,
		Lang.get(25354),
		16018,
		31,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[19]
		}
	},
	[16018032] = {
		16018032,
		0,
		Lang.get(25355),
		16018,
		32,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[16]
		}
	},
	[16018033] = {
		16018033,
		0,
		"！！！",
		16018,
		33,
		188,
		{
			RTResTalkAction[17],
			RTResTalkAction[19]
		}
	},
	[16018034] = {
		16018034,
		0,
		Lang.get(25356),
		16018,
		34,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[16]
		}
	},
	[16018035] = {
		16018035,
		0,
		Lang.get(25357),
		16018,
		35,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16018036] = {
		16018036,
		0,
		"…………",
		16018,
		36,
		188,
		{
			RTResTalkAction[23],
			RTResTalkAction[19]
		}
	},
	[16018037] = {
		16018037,
		0,
		Lang.get(25358),
		16018,
		37,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[16]
		}
	},
	[16018038] = {
		16018038,
		0,
		Lang.get(25359),
		16018,
		38,
		647,
		{
			RTResTalkAction[134],
			RTResTalkAction[19]
		}
	},
	[16018039] = {
		16018039,
		0,
		Lang.get(25360),
		16018,
		39,
		188,
		{
			RTResTalkAction[130]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		16032,
		nil,
		1,
		nil,
		1,
		nil,
		16032
	},
	[16018040] = {
		16018040,
		0,
		Lang.get(25361),
		16018,
		40,
		188,
		{
			RTResTalkAction[25]
		},
		nil,
		nil,
		3
	},
	[16018041] = {
		16018041,
		2,
		Lang.get(25362),
		16018,
		41,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16018042] = {
		16018042,
		0,
		Lang.get(25363),
		16018,
		42,
		338,
		{
			RTResTalkAction[7],
			RTResTalkAction[16]
		}
	},
	[16018043] = {
		16018043,
		0,
		Lang.get(25364),
		16018,
		43,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[3]
		}
	},
	[16018044] = {
		16018044,
		0,
		Lang.get(25365),
		16018,
		44,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[30]
		}
	},
	[16018045] = {
		16018045,
		0,
		Lang.get(25366),
		16018,
		45,
		338,
		{
			RTResTalkAction[6],
			RTResTalkAction[16]
		}
	},
	[16018046] = {
		16018046,
		0,
		Lang.get(25367),
		16018,
		46,
		647,
		{
			RTResTalkAction[134],
			RTResTalkAction[3]
		}
	},
	[16019001] = {
		16019001,
		0,
		Lang.get(16770),
		16019,
		1,
		338,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		16033,
		nil,
		nil,
		nil,
		1,
		nil,
		16033
	},
	[16019002] = {
		16019002,
		0,
		Lang.get(25368),
		16019,
		2,
		189,
		{
			RTResTalkAction[26]
		},
		nil,
		nil,
		3
	},
	[16019003] = {
		16019003,
		0,
		Lang.get(25369),
		16019,
		3,
		188,
		{
			RTResTalkAction[23],
			RTResTalkAction[30]
		}
	},
	[16019004] = {
		16019004,
		0,
		Lang.get(25370),
		16019,
		4,
		191,
		{
			RTResTalkAction[18],
			RTResTalkAction[16]
		}
	},
	[16019005] = {
		16019005,
		0,
		Lang.get(25371),
		16019,
		5,
		338,
		{
			RTResTalkAction[7],
			RTResTalkAction[19]
		}
	},
	[16019006] = {
		16019006,
		0,
		Lang.get(25372),
		16019,
		6,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[3]
		}
	},
	[16019007] = {
		16019007,
		0,
		Lang.get(25373),
		16019,
		7,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16019008] = {
		16019008,
		0,
		Lang.get(61778),
		16019,
		8,
		188,
		{
			RTResTalkAction[17],
			RTResTalkAction[19]
		}
	},
	[16019009] = {
		16019009,
		0,
		Lang.get(25374),
		16019,
		9,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[16]
		}
	},
	[16019010] = {
		16019010,
		0,
		Lang.get(61779),
		16019,
		10,
		188,
		{
			RTResTalkAction[23],
			RTResTalkAction[30]
		}
	},
	[16019011] = {
		16019011,
		0,
		Lang.get(25375),
		16019,
		11,
		191,
		{
			RTResTalkAction[20],
			RTResTalkAction[16]
		}
	},
	[16019012] = {
		16019012,
		0,
		Lang.get(25376),
		16019,
		12,
		188,
		{
			RTResTalkAction[61],
			RTResTalkAction[19]
		}
	},
	[16019013] = {
		16019013,
		5,
		Lang.get(25377),
		16019,
		13,
		191,
		{
			RTResTalkAction[135],
			RTResTalkAction[16]
		}
	},
	[16019014] = {
		16019014,
		0,
		Lang.get(25378),
		16019,
		14,
		188,
		{
			RTResTalkAction[17],
			RTResTalkAction[19]
		}
	},
	[16019015] = {
		16019015,
		0,
		Lang.get(25379),
		16019,
		15,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[16]
		}
	},
	[16019016] = {
		16019016,
		0,
		Lang.get(25380),
		16019,
		16,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16019017] = {
		16019017,
		0,
		Lang.get(25381),
		16019,
		17,
		188,
		{
			RTResTalkAction[106],
			RTResTalkAction[19]
		}
	},
	[16019018] = {
		16019018,
		0,
		Lang.get(25382),
		16019,
		18,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[16]
		}
	},
	[16019019] = {
		16019019,
		0,
		Lang.get(25383),
		16019,
		19,
		338,
		{
			RTResTalkAction[4],
			RTResTalkAction[19]
		}
	},
	[16019020] = {
		16019020,
		0,
		Lang.get(25384),
		16019,
		20,
		188,
		{
			RTResTalkAction[23],
			RTResTalkAction[3]
		}
	},
	[16019021] = {
		16019021,
		0,
		Lang.get(25385),
		16019,
		21,
		338,
		{
			RTResTalkAction[6],
			RTResTalkAction[16]
		}
	},
	[16019022] = {
		16019022,
		0,
		Lang.get(25386),
		16019,
		22,
		647,
		{
			RTResTalkAction[134],
			RTResTalkAction[3]
		}
	},
	[16019023] = {
		16019023,
		5,
		Lang.get(25387),
		16019,
		23,
		189,
		{
			RTResTalkAction[50],
			RTResTalkAction[130]
		}
	},
	[16019024] = {
		16019024,
		5,
		Lang.get(25388),
		16019,
		24,
		337,
		{
			RTResTalkAction[75],
			RTResTalkAction[30]
		}
	},
	[16019025] = {
		16019025,
		0,
		Lang.get(25389),
		16019,
		25,
		188,
		{
			RTResTalkAction[61],
			RTResTalkAction[74]
		}
	},
	[16019026] = {
		16019026,
		5,
		Lang.get(25390),
		16019,
		26,
		337,
		{
			RTResTalkAction[75],
			RTResTalkAction[16]
		}
	},
	[16019027] = {
		16019027,
		5,
		Lang.get(25391),
		16019,
		27,
		337,
		{
			RTResTalkAction[75]
		}
	},
	[16019028] = {
		16019028,
		0,
		Lang.get(25392),
		16019,
		28,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[74]
		}
	},
	[16019029] = {
		16019029,
		0,
		Lang.get(25393),
		16019,
		29,
		338,
		{
			RTResTalkAction[7],
			RTResTalkAction[30]
		}
	},
	[16019030] = {
		16019030,
		2,
		Lang.get(25394),
		16019,
		30,
		337,
		{
			RTResTalkAction[75],
			RTResTalkAction[3]
		}
	},
	[16119001] = {
		16119001,
		0,
		Lang.get(61780),
		16119,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		30,
		16034,
		nil,
		1,
		nil,
		1,
		nil,
		16034
	},
	[16119002] = {
		16119002,
		0,
		Lang.get(25999),
		16119,
		2,
		107,
		{
			RTResTalkAction[89]
		},
		nil,
		nil,
		3
	},
	[16119003] = {
		16119003,
		0,
		Lang.get(26000),
		16119,
		3,
		107,
		{
			RTResTalkAction[101]
		}
	},
	[16119004] = {
		16119004,
		0,
		Lang.get(26001),
		16119,
		4,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16119005] = {
		16119005,
		0,
		Lang.get(26002),
		16119,
		5,
		107,
		{
			RTResTalkAction[92]
		}
	},
	[16119006] = {
		16119006,
		0,
		Lang.get(26003),
		16119,
		6,
		141,
		{
			RTResTalkAction[86],
			RTResTalkAction[95]
		}
	},
	[16119007] = {
		16119007,
		0,
		Lang.get(26004),
		16119,
		7,
		107,
		{
			RTResTalkAction[90],
			RTResTalkAction[88]
		}
	},
	[16119008] = {
		16119008,
		0,
		Lang.get(26005),
		16119,
		8,
		107,
		{
			RTResTalkAction[136]
		}
	},
	[16119009] = {
		16119009,
		0,
		Lang.get(26006),
		16119,
		9,
		107,
		{
			RTResTalkAction[90]
		}
	},
	[16119010] = {
		16119010,
		0,
		Lang.get(26007),
		16119,
		10,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16119011] = {
		16119011,
		0,
		Lang.get(26008),
		16119,
		11,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16119012] = {
		16119012,
		0,
		Lang.get(26009),
		16119,
		12,
		300,
		{
			RTResTalkAction[95]
		}
	},
	[16119013] = {
		16119013,
		0,
		Lang.get(26010),
		16119,
		13,
		107,
		{
			RTResTalkAction[89]
		}
	},
	[16119014] = {
		16119014,
		0,
		Lang.get(26011),
		16119,
		14,
		300,
		{
			RTResTalkAction[137],
			RTResTalkAction[95]
		}
	},
	[16119015] = {
		16119015,
		0,
		Lang.get(26012),
		16119,
		15,
		107,
		{
			RTResTalkAction[101],
			RTResTalkAction[138]
		}
	},
	[16119016] = {
		16119016,
		0,
		Lang.get(26013),
		16119,
		16,
		189,
		{
			RTResTalkAction[95]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		16071,
		nil,
		1,
		nil,
		1,
		nil,
		16071
	},
	[16119017] = {
		16119017,
		0,
		Lang.get(26014),
		16119,
		17,
		647,
		{
			RTResTalkAction[134]
		},
		nil,
		nil,
		3
	},
	[16119018] = {
		16119018,
		0,
		Lang.get(26015),
		16119,
		18,
		188,
		{
			RTResTalkAction[23],
			RTResTalkAction[130]
		}
	},
	[16119019] = {
		16119019,
		0,
		Lang.get(26016),
		16119,
		19,
		647,
		{
			RTResTalkAction[134],
			RTResTalkAction[16]
		}
	},
	[16119020] = {
		16119020,
		0,
		Lang.get(26017),
		16119,
		20,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[130]
		}
	},
	[16119021] = {
		16119021,
		0,
		Lang.get(26018),
		16119,
		21,
		107,
		{
			RTResTalkAction[140],
			RTResTalkAction[141]
		}
	},
	[16119022] = {
		16119022,
		0,
		Lang.get(26019),
		16119,
		22,
		300,
		{
			RTResTalkAction[95]
		}
	},
	[16119023] = {
		16119023,
		0,
		Lang.get(26020),
		16119,
		23,
		647,
		{
			RTResTalkAction[134]
		}
	},
	[16119024] = {
		16119024,
		0,
		Lang.get(26021),
		16119,
		24,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[130]
		}
	},
	[16119025] = {
		16119025,
		0,
		Lang.get(26022),
		16119,
		25,
		188,
		{
			RTResTalkAction[24],
			RTResTalkAction[30]
		}
	},
	[16119026] = {
		16119026,
		0,
		Lang.get(26023),
		16119,
		26,
		187,
		{
			RTResTalkAction[16]
		},
		1,
		4,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		nil,
		1,
		nil,
		16103
	},
	[16119027] = {
		16119027,
		0,
		Lang.get(26024),
		16119,
		27,
		187,
		nil,
		1,
		4
	},
	[16119028] = {
		16119028,
		0,
		Lang.get(26025),
		16119,
		28,
		300
	},
	[16119029] = {
		16119029,
		0,
		Lang.get(26026),
		16119,
		29,
		187,
		nil,
		1,
		4
	},
	[16020001] = {
		16020001,
		0,
		Lang.get(25395),
		16020,
		1,
		107,
		nil,
		nil,
		1,
		nil,
		nil,
		48,
		16035,
		nil,
		nil,
		nil,
		1,
		nil,
		16035
	},
	[16020002] = {
		16020002,
		0,
		Lang.get(25396),
		16020,
		2,
		141,
		{
			RTResTalkAction[86]
		},
		nil,
		nil,
		3
	},
	[16020003] = {
		16020003,
		0,
		Lang.get(25397),
		16020,
		3,
		107,
		{
			RTResTalkAction[89],
			RTResTalkAction[88]
		}
	},
	[16020004] = {
		16020004,
		0,
		Lang.get(25398),
		16020,
		4,
		141,
		{
			RTResTalkAction[142],
			RTResTalkAction[95]
		}
	},
	[16020005] = {
		16020005,
		0,
		Lang.get(25399),
		16020,
		5,
		107,
		{
			RTResTalkAction[101],
			RTResTalkAction[88]
		}
	},
	[16020006] = {
		16020006,
		0,
		Lang.get(25400),
		16020,
		6,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[95]
		}
	},
	[16020007] = {
		16020007,
		0,
		Lang.get(25401),
		16020,
		7,
		141,
		{
			RTResTalkAction[97],
			RTResTalkAction[30]
		}
	},
	[16020008] = {
		16020008,
		0,
		Lang.get(25402),
		16020,
		8,
		300,
		{
			RTResTalkAction[88]
		}
	},
	[16020009] = {
		16020009,
		0,
		Lang.get(25403),
		16020,
		9,
		107,
		{
			RTResTalkAction[92]
		}
	},
	[16020010] = {
		16020010,
		0,
		Lang.get(25404),
		16020,
		10,
		188,
		{
			RTResTalkAction[24],
			RTResTalkAction[95]
		}
	},
	[16020011] = {
		16020011,
		0,
		"……",
		16020,
		11,
		187,
		{
			RTResTalkAction[143],
			RTResTalkAction[16]
		}
	},
	[16020012] = {
		16020012,
		0,
		Lang.get(25405),
		16020,
		12,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[141]
		}
	},
	[16020013] = {
		16020013,
		0,
		"……",
		16020,
		13,
		187,
		{
			RTResTalkAction[144],
			RTResTalkAction[30]
		}
	},
	[16020014] = {
		16020014,
		0,
		Lang.get(25406),
		16020,
		14,
		300,
		{
			RTResTalkAction[141]
		}
	},
	[16020015] = {
		16020015,
		0,
		Lang.get(25407),
		16020,
		15,
		187,
		{
			RTResTalkAction[139]
		}
	},
	[16020016] = {
		16020016,
		0,
		Lang.get(25408),
		16020,
		16,
		187,
		{
			RTResTalkAction[139]
		}
	},
	[16020017] = {
		16020017,
		0,
		Lang.get(25409),
		16020,
		17,
		107,
		{
			RTResTalkAction[101],
			RTResTalkAction[141]
		}
	},
	[16020018] = {
		16020018,
		0,
		Lang.get(25410),
		16020,
		18,
		141,
		{
			RTResTalkAction[97],
			RTResTalkAction[95]
		}
	},
	[16020019] = {
		16020019,
		0,
		Lang.get(25411),
		16020,
		19,
		188,
		{
			RTResTalkAction[24],
			RTResTalkAction[88]
		}
	},
	[16020020] = {
		16020020,
		0,
		Lang.get(25412),
		16020,
		20,
		187,
		{
			RTResTalkAction[145],
			RTResTalkAction[16]
		}
	},
	[16020021] = {
		16020021,
		0,
		Lang.get(25413),
		16020,
		21,
		187,
		{
			RTResTalkAction[144]
		}
	},
	[16020022] = {
		16020022,
		0,
		Lang.get(25414),
		16020,
		22,
		107,
		{
			RTResTalkAction[90],
			RTResTalkAction[141]
		}
	},
	[16020023] = {
		16020023,
		0,
		Lang.get(25415),
		16020,
		23,
		188,
		{
			RTResTalkAction[23],
			RTResTalkAction[95]
		}
	},
	[16020024] = {
		16020024,
		0,
		Lang.get(25416),
		16020,
		24,
		187,
		{
			RTResTalkAction[146],
			RTResTalkAction[16]
		}
	},
	[16020025] = {
		16020025,
		0,
		Lang.get(25417),
		16020,
		25,
		141,
		{
			RTResTalkAction[97],
			RTResTalkAction[141]
		}
	},
	[16020026] = {
		16020026,
		0,
		Lang.get(25418),
		16020,
		26,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[88]
		}
	},
	[16020027] = {
		16020027,
		0,
		Lang.get(25419),
		16020,
		27,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[16]
		}
	},
	[16020028] = {
		16020028,
		0,
		Lang.get(25420),
		16020,
		28,
		189,
		{
			RTResTalkAction[26]
		}
	},
	[16020029] = {
		16020029,
		0,
		Lang.get(25421),
		16020,
		29,
		300,
		{
			RTResTalkAction[30]
		}
	},
	[16020030] = {
		16020030,
		0,
		Lang.get(25422),
		16020,
		30,
		107,
		{
			RTResTalkAction[147]
		}
	},
	[16020031] = {
		16020031,
		0,
		Lang.get(25423),
		16020,
		31,
		337,
		{
			RTResTalkAction[75],
			RTResTalkAction[95]
		}
	},
	[16020032] = {
		16020032,
		0,
		Lang.get(25424),
		16020,
		32,
		107,
		{
			RTResTalkAction[148],
			RTResTalkAction[74]
		}
	},
	[16020033] = {
		16020033,
		0,
		Lang.get(25425),
		16020,
		33,
		337,
		{
			RTResTalkAction[75],
			RTResTalkAction[95]
		}
	},
	[16020034] = {
		16020034,
		0,
		Lang.get(25426),
		16020,
		34,
		107,
		{
			RTResTalkAction[90],
			RTResTalkAction[74]
		}
	},
	[16020035] = {
		16020035,
		0,
		Lang.get(25427),
		16020,
		35,
		337,
		{
			RTResTalkAction[75],
			RTResTalkAction[95]
		}
	},
	[16020036] = {
		16020036,
		0,
		Lang.get(25428),
		16020,
		36,
		337,
		{
			RTResTalkAction[75]
		}
	},
	[16020037] = {
		16020037,
		0,
		Lang.get(25429),
		16020,
		37,
		187,
		{
			RTResTalkAction[145],
			RTResTalkAction[74]
		}
	},
	[16020038] = {
		16020038,
		0,
		Lang.get(25430),
		16020,
		38,
		337,
		{
			RTResTalkAction[75],
			RTResTalkAction[141]
		}
	},
	[16020039] = {
		16020039,
		0,
		Lang.get(25431),
		16020,
		39,
		107,
		{
			RTResTalkAction[101],
			RTResTalkAction[74]
		}
	},
	[16020040] = {
		16020040,
		0,
		Lang.get(25432),
		16020,
		40,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[95]
		}
	},
	[16020041] = {
		16020041,
		0,
		Lang.get(25433),
		16020,
		41,
		107,
		{
			RTResTalkAction[89],
			RTResTalkAction[141]
		}
	},
	[16020042] = {
		16020042,
		0,
		Lang.get(25434),
		16020,
		42,
		189,
		{
			RTResTalkAction[95]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		16104,
		nil,
		1,
		nil,
		1,
		nil,
		16104
	},
	[16020043] = {
		16020043,
		0,
		Lang.get(25435),
		16020,
		43,
		187,
		{
			RTResTalkAction[145]
		},
		nil,
		nil,
		3
	},
	[16020044] = {
		16020044,
		0,
		Lang.get(25436),
		16020,
		44,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[141]
		}
	},
	[16020045] = {
		16020045,
		0,
		Lang.get(25437),
		16020,
		45,
		187,
		{
			RTResTalkAction[145],
			RTResTalkAction[30]
		}
	},
	[16020046] = {
		16020046,
		0,
		Lang.get(25438),
		16020,
		46,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[141]
		}
	},
	[16020047] = {
		16020047,
		0,
		Lang.get(25439),
		16020,
		47,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[16]
		}
	},
	[16020048] = {
		16020048,
		0,
		Lang.get(25440),
		16020,
		48,
		187,
		{
			RTResTalkAction[146],
			RTResTalkAction[30]
		}
	},
	[16020049] = {
		16020049,
		0,
		Lang.get(25441),
		16020,
		49,
		647,
		{
			RTResTalkAction[134],
			RTResTalkAction[141]
		}
	},
	[16020050] = {
		16020050,
		5,
		Lang.get(25442),
		16020,
		50,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[130]
		}
	},
	[16021001] = {
		16021001,
		0,
		Lang.get(25443),
		16021,
		1,
		189,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		16105,
		nil,
		nil,
		nil,
		1,
		nil,
		16105
	},
	[16021002] = {
		16021002,
		0,
		"…………",
		16021,
		2,
		187,
		{
			RTResTalkAction[146]
		},
		nil,
		nil,
		3
	},
	[16021003] = {
		16021003,
		0,
		Lang.get(25444),
		16021,
		3,
		188,
		{
			RTResTalkAction[23],
			RTResTalkAction[141]
		}
	},
	[16021004] = {
		16021004,
		0,
		Lang.get(25445),
		16021,
		4,
		187,
		{
			RTResTalkAction[146],
			RTResTalkAction[16]
		}
	},
	[16021005] = {
		16021005,
		0,
		Lang.get(25446),
		16021,
		5,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[141]
		}
	},
	[16021006] = {
		16021006,
		0,
		Lang.get(25447),
		16021,
		6,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[16]
		}
	},
	[16021007] = {
		16021007,
		0,
		Lang.get(25448),
		16021,
		7,
		187,
		{
			RTResTalkAction[139]
		}
	},
	[16021008] = {
		16021008,
		0,
		Lang.get(61781),
		16021,
		8,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[141]
		}
	},
	[16021009] = {
		16021009,
		0,
		Lang.get(25450),
		16021,
		9,
		107,
		{
			RTResTalkAction[101],
			RTResTalkAction[30]
		}
	},
	[16021010] = {
		16021010,
		0,
		Lang.get(25451),
		16021,
		10,
		187,
		{
			RTResTalkAction[145],
			RTResTalkAction[95]
		}
	},
	[16021011] = {
		16021011,
		0,
		Lang.get(25452),
		16021,
		11,
		107,
		{
			RTResTalkAction[89],
			RTResTalkAction[141]
		}
	},
	[16021012] = {
		16021012,
		0,
		Lang.get(25453),
		16021,
		12,
		188,
		{
			RTResTalkAction[24],
			RTResTalkAction[95]
		}
	},
	[16021013] = {
		16021013,
		0,
		Lang.get(25454),
		16021,
		13,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[16]
		}
	},
	[16021014] = {
		16021014,
		0,
		Lang.get(25455),
		16021,
		14,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[30]
		}
	},
	[16021015] = {
		16021015,
		0,
		Lang.get(25456),
		16021,
		15,
		107,
		{
			RTResTalkAction[93],
			RTResTalkAction[141]
		}
	},
	[16021016] = {
		16021016,
		0,
		Lang.get(61782),
		16021,
		16,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[95]
		}
	},
	[16022001] = {
		16022001,
		0,
		Lang.get(25458),
		16022,
		1,
		141,
		nil,
		1,
		nil,
		nil,
		nil,
		30,
		16037,
		nil,
		nil,
		nil,
		1,
		nil,
		16037
	},
	[16022002] = {
		16022002,
		0,
		Lang.get(25459),
		16022,
		2,
		187,
		{
			RTResTalkAction[145]
		},
		nil,
		nil,
		3
	},
	[16022003] = {
		16022003,
		0,
		Lang.get(25460),
		16022,
		3,
		107,
		{
			RTResTalkAction[101],
			RTResTalkAction[141]
		}
	},
	[16022004] = {
		16022004,
		0,
		Lang.get(25461),
		16022,
		4,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16022005] = {
		16022005,
		0,
		Lang.get(25462),
		16022,
		5,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[95]
		}
	},
	[16022006] = {
		16022006,
		0,
		Lang.get(25463),
		16022,
		6,
		107,
		{
			RTResTalkAction[89],
			RTResTalkAction[16]
		}
	},
	[16022007] = {
		16022007,
		0,
		Lang.get(25464),
		16022,
		7,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16022008] = {
		16022008,
		0,
		Lang.get(25465),
		16022,
		8,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16022009] = {
		16022009,
		0,
		Lang.get(25466),
		16022,
		9,
		188,
		{
			RTResTalkAction[61],
			RTResTalkAction[95]
		}
	},
	[16022010] = {
		16022010,
		0,
		Lang.get(25467),
		16022,
		10,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16022011] = {
		16022011,
		0,
		Lang.get(25468),
		16022,
		11,
		107,
		{
			RTResTalkAction[93],
			RTResTalkAction[16]
		}
	},
	[16022012] = {
		16022012,
		0,
		Lang.get(25469),
		16022,
		12,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[95]
		}
	},
	[16022013] = {
		16022013,
		0,
		Lang.get(25470),
		16022,
		13,
		107,
		{
			RTResTalkAction[90],
			RTResTalkAction[141]
		}
	},
	[16022014] = {
		16022014,
		0,
		Lang.get(25471),
		16022,
		14,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16022015] = {
		16022015,
		0,
		Lang.get(25472),
		16022,
		15,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16022016] = {
		16022016,
		0,
		Lang.get(25473),
		16022,
		16,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16022017] = {
		16022017,
		0,
		Lang.get(25474),
		16022,
		17,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16022018] = {
		16022018,
		0,
		Lang.get(25475),
		16022,
		18,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16022019] = {
		16022019,
		0,
		"……",
		16022,
		19,
		141,
		{
			RTResTalkAction[97],
			RTResTalkAction[95]
		}
	},
	[16022020] = {
		16022020,
		0,
		Lang.get(25476),
		16022,
		20,
		107,
		{
			RTResTalkAction[92],
			RTResTalkAction[88]
		}
	},
	[16022021] = {
		16022021,
		0,
		Lang.get(25477),
		16022,
		21,
		141,
		{
			RTResTalkAction[97],
			RTResTalkAction[95]
		}
	},
	[16022022] = {
		16022022,
		0,
		Lang.get(25478),
		16022,
		22,
		107,
		{
			RTResTalkAction[93],
			RTResTalkAction[88]
		}
	},
	[16022023] = {
		16022023,
		0,
		Lang.get(25479),
		16022,
		23,
		141,
		{
			RTResTalkAction[97],
			RTResTalkAction[95]
		}
	},
	[16022024] = {
		16022024,
		0,
		Lang.get(25480),
		16022,
		24,
		107,
		{
			RTResTalkAction[149],
			RTResTalkAction[88]
		}
	},
	[16022025] = {
		16022025,
		0,
		Lang.get(25481),
		16022,
		25,
		300,
		{
			RTResTalkAction[95]
		}
	},
	[16022026] = {
		16022026,
		0,
		Lang.get(25482),
		16022,
		26,
		300
	},
	[16022027] = {
		16022027,
		0,
		Lang.get(25483),
		16022,
		27,
		107,
		{
			RTResTalkAction[92]
		}
	},
	[16022028] = {
		16022028,
		0,
		Lang.get(25484),
		16022,
		28,
		187,
		{
			RTResTalkAction[144],
			RTResTalkAction[95]
		}
	},
	[16022029] = {
		16022029,
		0,
		Lang.get(25485),
		16022,
		29,
		187,
		{
			RTResTalkAction[139]
		}
	},
	[16022030] = {
		16022030,
		0,
		Lang.get(25486),
		16022,
		30,
		107,
		{
			RTResTalkAction[148],
			RTResTalkAction[141]
		}
	},
	[16022031] = {
		16022031,
		0,
		Lang.get(25487),
		16022,
		31,
		141,
		{
			RTResTalkAction[97],
			RTResTalkAction[95]
		}
	},
	[16022032] = {
		16022032,
		0,
		Lang.get(25488),
		16022,
		32,
		107,
		{
			RTResTalkAction[92],
			RTResTalkAction[88]
		}
	},
	[16022033] = {
		16022033,
		0,
		Lang.get(25489),
		16022,
		33,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16022034] = {
		16022034,
		0,
		Lang.get(25490),
		16022,
		34,
		107,
		{
			RTResTalkAction[101]
		}
	},
	[16022035] = {
		16022035,
		0,
		Lang.get(25491),
		16022,
		35,
		141,
		{
			RTResTalkAction[97],
			RTResTalkAction[95]
		}
	},
	[16022036] = {
		16022036,
		0,
		Lang.get(25492),
		16022,
		36,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[88]
		}
	},
	[16022037] = {
		16022037,
		0,
		Lang.get(25493),
		16022,
		37,
		107,
		{
			RTResTalkAction[93],
			RTResTalkAction[141]
		}
	},
	[16022038] = {
		16022038,
		0,
		Lang.get(25494),
		16022,
		38,
		107,
		{
			RTResTalkAction[89]
		}
	},
	[16022039] = {
		16022039,
		0,
		Lang.get(25495),
		16022,
		39,
		107,
		{
			RTResTalkAction[92]
		}
	},
	[16022040] = {
		16022040,
		0,
		Lang.get(25496),
		16022,
		40,
		187,
		{
			RTResTalkAction[146],
			RTResTalkAction[95]
		}
	},
	[16022041] = {
		16022041,
		0,
		Lang.get(25497),
		16022,
		41,
		187,
		{
			RTResTalkAction[144]
		}
	},
	[16022042] = {
		16022042,
		0,
		Lang.get(25498),
		16022,
		42,
		107,
		{
			RTResTalkAction[149],
			RTResTalkAction[141]
		}
	},
	[16022043] = {
		16022043,
		0,
		Lang.get(25499),
		16022,
		43,
		107,
		{
			RTResTalkAction[147]
		}
	},
	[16022044] = {
		16022044,
		0,
		Lang.get(25500),
		16022,
		44,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16022045] = {
		16022045,
		0,
		Lang.get(25501),
		16022,
		45,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[95]
		}
	},
	[16022046] = {
		16022046,
		0,
		Lang.get(25502),
		16022,
		46,
		107,
		{
			RTResTalkAction[92],
			RTResTalkAction[141]
		}
	},
	[16022047] = {
		16022047,
		0,
		Lang.get(25503),
		16022,
		47,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[95]
		}
	},
	[16022048] = {
		16022048,
		0,
		Lang.get(25504),
		16022,
		48,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16022049] = {
		16022049,
		0,
		Lang.get(25505),
		16022,
		49,
		107,
		{
			RTResTalkAction[90],
			RTResTalkAction[16]
		}
	},
	[16022050] = {
		16022050,
		0,
		Lang.get(25506),
		16022,
		50,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16023001] = {
		16023001,
		0,
		Lang.get(25507),
		16023,
		1,
		647,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		16038,
		nil,
		nil,
		nil,
		1,
		nil,
		16038
	},
	[16023002] = {
		16023002,
		0,
		Lang.get(61783),
		16023,
		2,
		648,
		nil,
		1
	},
	[16023003] = {
		16023003,
		0,
		Lang.get(25508),
		16023,
		3,
		191,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3
	},
	[16023004] = {
		16023004,
		0,
		Lang.get(25509),
		16023,
		4,
		647,
		{
			RTResTalkAction[134],
			RTResTalkAction[19]
		}
	},
	[16023005] = {
		16023005,
		0,
		Lang.get(25510),
		16023,
		5,
		191,
		{
			RTResTalkAction[18],
			RTResTalkAction[130]
		}
	},
	[16023006] = {
		16023006,
		0,
		Lang.get(25511),
		16023,
		6,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16023007] = {
		16023007,
		0,
		Lang.get(25512),
		16023,
		7,
		191,
		{
			RTResTalkAction[20]
		}
	},
	[16023008] = {
		16023008,
		0,
		Lang.get(25513),
		16023,
		8,
		191,
		{
			RTResTalkAction[18]
		}
	},
	[16024001] = {
		16024001,
		0,
		Lang.get(25514),
		16024,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		115,
		16039,
		nil,
		nil,
		nil,
		1,
		nil,
		16039
	},
	[16024002] = {
		16024002,
		0,
		Lang.get(25515),
		16024,
		2,
		188,
		{
			RTResTalkAction[61]
		},
		nil,
		nil,
		3
	},
	[16024003] = {
		16024003,
		0,
		Lang.get(25516),
		16024,
		3,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16024004] = {
		16024004,
		0,
		Lang.get(25517),
		16024,
		4,
		107,
		{
			RTResTalkAction[101],
			RTResTalkAction[16]
		}
	},
	[16024005] = {
		16024005,
		0,
		Lang.get(61784),
		16024,
		5,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16024006] = {
		16024006,
		0,
		Lang.get(25518),
		16024,
		6,
		187,
		{
			RTResTalkAction[145],
			RTResTalkAction[95]
		}
	},
	[16024007] = {
		16024007,
		0,
		Lang.get(25519),
		16024,
		7,
		107,
		{
			RTResTalkAction[89],
			RTResTalkAction[141]
		}
	},
	[16024008] = {
		16024008,
		0,
		Lang.get(25520),
		16024,
		8,
		107,
		{
			RTResTalkAction[140]
		}
	},
	[16024009] = {
		16024009,
		0,
		Lang.get(25521),
		16024,
		9,
		141,
		{
			RTResTalkAction[97],
			RTResTalkAction[95]
		}
	},
	[16024010] = {
		16024010,
		0,
		Lang.get(25522),
		16024,
		10,
		107,
		{
			RTResTalkAction[150],
			RTResTalkAction[88]
		}
	},
	[16024011] = {
		16024011,
		0,
		Lang.get(25523),
		16024,
		11,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16024012] = {
		16024012,
		0,
		Lang.get(25524),
		16024,
		12,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16024013] = {
		16024013,
		0,
		Lang.get(25525),
		16024,
		13,
		141,
		{
			RTResTalkAction[86],
			RTResTalkAction[95]
		}
	},
	[16024014] = {
		16024014,
		0,
		Lang.get(25526),
		16024,
		14,
		107,
		{
			RTResTalkAction[90],
			RTResTalkAction[88]
		}
	},
	[16024015] = {
		16024015,
		0,
		Lang.get(25527),
		16024,
		15,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16024016] = {
		16024016,
		0,
		Lang.get(25528),
		16024,
		16,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[95]
		}
	},
	[16024017] = {
		16024017,
		0,
		Lang.get(25529),
		16024,
		17,
		107,
		{
			RTResTalkAction[92],
			RTResTalkAction[141]
		}
	},
	[16024018] = {
		16024018,
		0,
		Lang.get(25530),
		16024,
		18,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[95]
		}
	},
	[16024019] = {
		16024019,
		0,
		Lang.get(25531),
		16024,
		19,
		141,
		{
			RTResTalkAction[142],
			RTResTalkAction[141]
		}
	},
	[16024020] = {
		16024020,
		0,
		Lang.get(25532),
		16024,
		20,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[88]
		}
	},
	[16024021] = {
		16024021,
		0,
		Lang.get(25533),
		16024,
		21,
		107,
		{
			RTResTalkAction[90],
			RTResTalkAction[141]
		}
	},
	[16024022] = {
		16024022,
		0,
		Lang.get(25534),
		16024,
		22,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16024023] = {
		16024023,
		0,
		Lang.get(25535),
		16024,
		23,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16024024] = {
		16024024,
		0,
		Lang.get(25536),
		16024,
		24,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16024025] = {
		16024025,
		0,
		Lang.get(25537),
		16024,
		25,
		141,
		{
			RTResTalkAction[97],
			RTResTalkAction[95]
		}
	},
	[16024026] = {
		16024026,
		0,
		Lang.get(25538),
		16024,
		26,
		107,
		{
			RTResTalkAction[148],
			RTResTalkAction[88]
		}
	},
	[16024027] = {
		16024027,
		0,
		Lang.get(25539),
		16024,
		27,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[95]
		}
	},
	[16024028] = {
		16024028,
		0,
		Lang.get(25540),
		16024,
		28,
		107,
		{
			RTResTalkAction[90],
			RTResTalkAction[141]
		}
	},
	[16024029] = {
		16024029,
		0,
		Lang.get(25541),
		16024,
		29,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16024030] = {
		16024030,
		0,
		Lang.get(25542),
		16024,
		30,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[95]
		}
	},
	[16024031] = {
		16024031,
		0,
		Lang.get(25543),
		16024,
		31,
		107,
		{
			RTResTalkAction[92],
			RTResTalkAction[141]
		}
	},
	[16024032] = {
		16024032,
		0,
		Lang.get(25544),
		16024,
		32,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[95]
		}
	},
	[16024033] = {
		16024033,
		0,
		Lang.get(25545),
		16024,
		33,
		187,
		{
			RTResTalkAction[139]
		}
	},
	[16024034] = {
		16024034,
		0,
		Lang.get(25546),
		16024,
		34,
		187,
		{
			RTResTalkAction[139]
		}
	},
	[16024035] = {
		16024035,
		0,
		Lang.get(25547),
		16024,
		35,
		107,
		{
			RTResTalkAction[90],
			RTResTalkAction[141]
		}
	},
	[16024036] = {
		16024036,
		0,
		Lang.get(25548),
		16024,
		36,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16024037] = {
		16024037,
		0,
		Lang.get(25549),
		16024,
		37,
		107,
		{
			RTResTalkAction[89]
		}
	},
	[16025001] = {
		16025001,
		0,
		Lang.get(25550),
		16025,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		115,
		16106,
		nil,
		nil,
		nil,
		1,
		nil,
		16106
	},
	[16025002] = {
		16025002,
		0,
		Lang.get(25551),
		16025,
		2,
		187,
		{
			RTResTalkAction[139]
		},
		nil,
		nil,
		3
	},
	[16025003] = {
		16025003,
		0,
		Lang.get(25552),
		16025,
		3,
		187,
		{
			RTResTalkAction[139]
		}
	},
	[16025004] = {
		16025004,
		0,
		Lang.get(25553),
		16025,
		4,
		107,
		{
			RTResTalkAction[101],
			RTResTalkAction[141]
		}
	},
	[16025005] = {
		16025005,
		0,
		Lang.get(25554),
		16025,
		5,
		187,
		{
			RTResTalkAction[145],
			RTResTalkAction[95]
		}
	},
	[16025006] = {
		16025006,
		0,
		Lang.get(25555),
		16025,
		6,
		188,
		{
			RTResTalkAction[24],
			RTResTalkAction[141]
		}
	},
	[16025007] = {
		16025007,
		0,
		Lang.get(25556),
		16025,
		7,
		188,
		{
			RTResTalkAction[16]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		16107,
		nil,
		1,
		nil,
		1,
		nil,
		16107
	},
	[16025008] = {
		16025008,
		0,
		Lang.get(25557),
		16025,
		8,
		191,
		{
			RTResTalkAction[18]
		},
		nil,
		nil,
		3
	},
	[16025009] = {
		16025009,
		0,
		Lang.get(25558),
		16025,
		9,
		188,
		{
			RTResTalkAction[17],
			RTResTalkAction[19]
		}
	},
	[16025010] = {
		16025010,
		0,
		Lang.get(25559),
		16025,
		10,
		191,
		{
			RTResTalkAction[18],
			RTResTalkAction[16]
		}
	},
	[16025011] = {
		16025011,
		0,
		Lang.get(25560),
		16025,
		11,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[19]
		}
	},
	[16025012] = {
		16025012,
		0,
		Lang.get(25561),
		16025,
		12,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[16]
		}
	},
	[16025013] = {
		16025013,
		0,
		"……",
		16025,
		13,
		188,
		{
			RTResTalkAction[24],
			RTResTalkAction[19]
		}
	},
	[16025014] = {
		16025014,
		0,
		Lang.get(25562),
		16025,
		14,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[16]
		}
	},
	[16025015] = {
		16025015,
		0,
		Lang.get(25563),
		16025,
		15,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[19]
		}
	},
	[16025016] = {
		16025016,
		0,
		Lang.get(25564),
		16025,
		16,
		188,
		{
			RTResTalkAction[106]
		}
	},
	[16025017] = {
		16025017,
		0,
		Lang.get(25565),
		16025,
		17,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[16]
		}
	},
	[16025018] = {
		16025018,
		0,
		Lang.get(25566),
		16025,
		18,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16025019] = {
		16025019,
		0,
		Lang.get(25567),
		16025,
		19,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[19]
		}
	},
	[16025020] = {
		16025020,
		0,
		Lang.get(25568),
		16025,
		20,
		191,
		{
			RTResTalkAction[20],
			RTResTalkAction[16]
		}
	},
	[16025021] = {
		16025021,
		0,
		Lang.get(61785),
		16025,
		21,
		188,
		{
			RTResTalkAction[24],
			RTResTalkAction[19]
		}
	},
	[16025022] = {
		16025022,
		0,
		Lang.get(25570),
		16025,
		22,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[16]
		}
	},
	[16025023] = {
		16025023,
		0,
		Lang.get(25571),
		16025,
		23,
		188,
		{
			RTResTalkAction[23],
			RTResTalkAction[19]
		}
	},
	[16025024] = {
		16025024,
		0,
		Lang.get(25572),
		16025,
		24,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[16]
		}
	},
	[16025025] = {
		16025025,
		0,
		Lang.get(61786),
		16025,
		25,
		188,
		{
			RTResTalkAction[24],
			RTResTalkAction[19]
		}
	},
	[16026001] = {
		16026001,
		0,
		Lang.get(25573),
		16026,
		1,
		189,
		nil,
		1,
		nil,
		nil,
		nil,
		30,
		16060,
		nil,
		nil,
		nil,
		1,
		nil,
		16060
	},
	[16026002] = {
		16026002,
		0,
		Lang.get(25574),
		16026,
		2,
		187,
		{
			RTResTalkAction[145]
		},
		nil,
		nil,
		3
	},
	[16026003] = {
		16026003,
		0,
		Lang.get(25575),
		16026,
		3,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[141]
		}
	},
	[16026004] = {
		16026004,
		0,
		Lang.get(25576),
		16026,
		4,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[30]
		}
	},
	[16026005] = {
		16026005,
		0,
		Lang.get(25577),
		16026,
		5,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[141]
		}
	},
	[16026006] = {
		16026006,
		0,
		"……",
		16026,
		6,
		187,
		{
			RTResTalkAction[151],
			RTResTalkAction[30]
		}
	},
	[16026007] = {
		16026007,
		0,
		Lang.get(25578),
		16026,
		7,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[141]
		}
	},
	[16026008] = {
		16026008,
		0,
		Lang.get(25579),
		16026,
		8,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[30]
		}
	},
	[16026009] = {
		16026009,
		0,
		Lang.get(25580),
		16026,
		9,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[141]
		}
	},
	[16026010] = {
		16026010,
		0,
		Lang.get(25581),
		16026,
		10,
		189,
		{
			RTResTalkAction[26]
		}
	},
	[16026011] = {
		16026011,
		0,
		Lang.get(25582),
		16026,
		11,
		107,
		{
			RTResTalkAction[101],
			RTResTalkAction[30]
		}
	},
	[16026012] = {
		16026012,
		0,
		Lang.get(25583),
		16026,
		12,
		187,
		{
			RTResTalkAction[144],
			RTResTalkAction[95]
		}
	},
	[16026013] = {
		16026013,
		0,
		Lang.get(25584),
		16026,
		13,
		107,
		{
			RTResTalkAction[93],
			RTResTalkAction[141]
		}
	},
	[16026014] = {
		16026014,
		0,
		Lang.get(25585),
		16026,
		14,
		107,
		{
			RTResTalkAction[148]
		}
	},
	[16026015] = {
		16026015,
		0,
		Lang.get(25586),
		16026,
		15,
		141,
		{
			RTResTalkAction[97],
			RTResTalkAction[95]
		}
	},
	[16026016] = {
		16026016,
		0,
		Lang.get(25587),
		16026,
		16,
		141,
		{
			RTResTalkAction[97]
		}
	},
	[16026017] = {
		16026017,
		0,
		Lang.get(25588),
		16026,
		17,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[88]
		}
	},
	[16026018] = {
		16026018,
		0,
		Lang.get(25589),
		16026,
		18,
		187,
		{
			RTResTalkAction[145],
			RTResTalkAction[30]
		}
	},
	[16026019] = {
		16026019,
		0,
		Lang.get(25590),
		16026,
		19,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[141]
		}
	},
	[16026020] = {
		16026020,
		0,
		Lang.get(25591),
		16026,
		20,
		107,
		{
			RTResTalkAction[92],
			RTResTalkAction[30]
		}
	},
	[16027001] = {
		16027001,
		0,
		Lang.get(25592),
		16027,
		1,
		187,
		nil,
		1,
		nil,
		nil,
		nil,
		30,
		16040,
		nil,
		nil,
		nil,
		1,
		nil,
		16040
	},
	[16027002] = {
		16027002,
		0,
		"……",
		16027,
		2,
		187,
		{
			RTResTalkAction[139]
		},
		nil,
		nil,
		3
	},
	[16027003] = {
		16027003,
		0,
		Lang.get(25593),
		16027,
		3,
		187,
		{
			RTResTalkAction[151]
		}
	},
	[16027004] = {
		16027004,
		0,
		Lang.get(25594),
		16027,
		4,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[141]
		}
	},
	[16027005] = {
		16027005,
		0,
		Lang.get(25595),
		16027,
		5,
		107,
		{
			RTResTalkAction[92],
			RTResTalkAction[30]
		}
	},
	[16027006] = {
		16027006,
		0,
		Lang.get(25596),
		16027,
		6,
		107,
		{
			RTResTalkAction[90]
		}
	},
	[16027007] = {
		16027007,
		0,
		Lang.get(25597),
		16027,
		7,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16027008] = {
		16027008,
		0,
		Lang.get(25598),
		16027,
		8,
		141,
		{
			RTResTalkAction[97],
			RTResTalkAction[95]
		}
	},
	[16027009] = {
		16027009,
		0,
		Lang.get(25599),
		16027,
		9,
		107,
		{
			RTResTalkAction[93],
			RTResTalkAction[88]
		}
	},
	[16027010] = {
		16027010,
		0,
		Lang.get(25600),
		16027,
		10,
		141,
		{
			RTResTalkAction[97],
			RTResTalkAction[95]
		}
	},
	[16027011] = {
		16027011,
		0,
		Lang.get(25601),
		16027,
		11,
		107,
		{
			RTResTalkAction[89],
			RTResTalkAction[88]
		}
	},
	[16027012] = {
		16027012,
		0,
		Lang.get(25602),
		16027,
		12,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[95]
		}
	},
	[16027013] = {
		16027013,
		0,
		Lang.get(25603),
		16027,
		13,
		188,
		{
			RTResTalkAction[141]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		16041,
		nil,
		1,
		nil,
		1,
		nil,
		16041
	},
	[16027014] = {
		16027014,
		0,
		Lang.get(25604),
		16027,
		14,
		187,
		{
			RTResTalkAction[151]
		},
		nil,
		nil,
		3
	},
	[16027015] = {
		16027015,
		0,
		Lang.get(25605),
		16027,
		15,
		188,
		{
			RTResTalkAction[61],
			RTResTalkAction[141]
		}
	},
	[16027016] = {
		16027016,
		0,
		Lang.get(25606),
		16027,
		16,
		187,
		{
			RTResTalkAction[145],
			RTResTalkAction[16]
		}
	},
	[16027017] = {
		16027017,
		0,
		Lang.get(25607),
		16027,
		17,
		188,
		{
			RTResTalkAction[23],
			RTResTalkAction[141]
		}
	},
	[16027018] = {
		16027018,
		0,
		Lang.get(25608),
		16027,
		18,
		188,
		{
			RTResTalkAction[24]
		}
	},
	[16027019] = {
		16027019,
		0,
		"…………",
		16027,
		19,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[16]
		}
	},
	[16027020] = {
		16027020,
		0,
		Lang.get(25609),
		16027,
		20,
		187,
		{
			RTResTalkAction[139]
		}
	},
	[16027021] = {
		16027021,
		0,
		Lang.get(25610),
		16027,
		21,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[141]
		}
	},
	[16027022] = {
		16027022,
		0,
		Lang.get(25611),
		16027,
		22,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[16]
		}
	},
	[16027023] = {
		16027023,
		0,
		Lang.get(25612),
		16027,
		23,
		187,
		{
			RTResTalkAction[139]
		}
	},
	[16027024] = {
		16027024,
		0,
		Lang.get(61787),
		16027,
		24,
		188,
		{
			RTResTalkAction[61],
			RTResTalkAction[141]
		}
	},
	[16028001] = {
		16028001,
		0,
		Lang.get(25613),
		16028,
		1,
		187,
		nil,
		1,
		nil,
		nil,
		nil,
		115,
		16042,
		nil,
		nil,
		nil,
		1,
		nil,
		16042
	},
	[16028002] = {
		16028002,
		0,
		Lang.get(25614),
		16028,
		2,
		189,
		{
			RTResTalkAction[26]
		},
		nil,
		nil,
		5
	},
	[16028003] = {
		16028003,
		0,
		Lang.get(25615),
		16028,
		3,
		107,
		{
			RTResTalkAction[152],
			RTResTalkAction[30]
		},
		1,
		[21] = 339
	},
	[16028004] = {
		16028004,
		0,
		Lang.get(25616),
		16028,
		4,
		189,
		{
			RTResTalkAction[152]
		},
		1,
		[21] = 339
	},
	[16028005] = {
		16028005,
		0,
		Lang.get(25617),
		16028,
		5,
		189,
		{
			RTResTalkAction[152]
		},
		1,
		[21] = 339
	},
	[16028006] = {
		16028006,
		0,
		Lang.get(25618),
		16028,
		6,
		107,
		{
			RTResTalkAction[152]
		},
		1,
		[21] = 339
	},
	[16028007] = {
		16028007,
		0,
		Lang.get(25619),
		16028,
		7,
		141,
		{
			RTResTalkAction[152]
		},
		1,
		[21] = 339
	},
	[16028008] = {
		16028008,
		0,
		Lang.get(25620),
		16028,
		8,
		187,
		{
			RTResTalkAction[144],
			RTResTalkAction[153]
		}
	},
	[16028009] = {
		16028009,
		0,
		Lang.get(25621),
		16028,
		9,
		107,
		{
			RTResTalkAction[93],
			RTResTalkAction[141]
		}
	},
	[16028010] = {
		16028010,
		0,
		Lang.get(25622),
		16028,
		10,
		141,
		{
			RTResTalkAction[97],
			RTResTalkAction[95]
		}
	},
	[16028011] = {
		16028011,
		0,
		Lang.get(25623),
		16028,
		11,
		188,
		{
			RTResTalkAction[61],
			RTResTalkAction[88]
		}
	},
	[16028012] = {
		16028012,
		0,
		Lang.get(25624),
		16028,
		12,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16028013] = {
		16028013,
		0,
		Lang.get(25625),
		16028,
		13,
		141,
		{
			RTResTalkAction[97],
			RTResTalkAction[16]
		}
	},
	[16028014] = {
		16028014,
		0,
		Lang.get(25626),
		16028,
		14,
		141,
		{
			RTResTalkAction[97]
		}
	},
	[16028015] = {
		16028015,
		0,
		Lang.get(25627),
		16028,
		15,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[88]
		}
	},
	[16028016] = {
		16028016,
		0,
		Lang.get(25628),
		16028,
		16,
		189,
		{
			RTResTalkAction[26]
		}
	},
	[16028017] = {
		16028017,
		0,
		Lang.get(25629),
		16028,
		17,
		141,
		{
			RTResTalkAction[97],
			RTResTalkAction[30]
		}
	},
	[16028018] = {
		16028018,
		0,
		Lang.get(25630),
		16028,
		18,
		189,
		{
			RTResTalkAction[26],
			RTResTalkAction[88]
		}
	},
	[16029001] = {
		16029001,
		0,
		Lang.get(25631),
		16029,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		44,
		16108,
		nil,
		nil,
		nil,
		1,
		nil,
		16108
	},
	[16029002] = {
		16029002,
		0,
		Lang.get(25632),
		16029,
		2,
		141,
		{
			RTResTalkAction[97]
		},
		nil,
		nil,
		3
	},
	[16029003] = {
		16029003,
		0,
		Lang.get(25633),
		16029,
		3,
		107,
		{
			RTResTalkAction[89],
			RTResTalkAction[88]
		}
	},
	[16029004] = {
		16029004,
		0,
		Lang.get(25634),
		16029,
		4,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16029005] = {
		16029005,
		0,
		Lang.get(25635),
		16029,
		5,
		141,
		{
			RTResTalkAction[97],
			RTResTalkAction[95]
		}
	},
	[16029006] = {
		16029006,
		0,
		Lang.get(61788),
		16029,
		6,
		107,
		{
			RTResTalkAction[90],
			RTResTalkAction[88]
		}
	},
	[16029007] = {
		16029007,
		0,
		Lang.get(25636),
		16029,
		7,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16029008] = {
		16029008,
		0,
		Lang.get(25637),
		16029,
		8,
		141,
		{
			RTResTalkAction[97],
			RTResTalkAction[95]
		}
	},
	[16029009] = {
		16029009,
		0,
		Lang.get(25638),
		16029,
		9,
		107,
		{
			RTResTalkAction[101],
			RTResTalkAction[88]
		}
	},
	[16029010] = {
		16029010,
		0,
		Lang.get(25639),
		16029,
		10,
		107,
		{
			RTResTalkAction[95]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		16043,
		nil,
		1,
		nil,
		1,
		nil,
		16043
	},
	[16029011] = {
		16029011,
		0,
		Lang.get(25640),
		16029,
		11,
		107,
		nil,
		1
	},
	[16029012] = {
		16029012,
		0,
		Lang.get(25641),
		16029,
		12,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[19] = 16143,
		[17] = 1
	},
	[16029013] = {
		16029013,
		0,
		Lang.get(25642),
		16029,
		13,
		141,
		{
			RTResTalkAction[97]
		},
		nil,
		nil,
		3
	},
	[16029014] = {
		16029014,
		0,
		Lang.get(25643),
		16029,
		14,
		107,
		{
			RTResTalkAction[92],
			RTResTalkAction[88]
		}
	},
	[16029015] = {
		16029015,
		0,
		Lang.get(25644),
		16029,
		15,
		141,
		{
			RTResTalkAction[97],
			RTResTalkAction[95]
		}
	},
	[16029016] = {
		16029016,
		0,
		Lang.get(25645),
		16029,
		16,
		141,
		{
			RTResTalkAction[97]
		}
	},
	[16029017] = {
		16029017,
		0,
		Lang.get(25646),
		16029,
		17,
		188,
		{
			RTResTalkAction[23],
			RTResTalkAction[88]
		}
	},
	[16029018] = {
		16029018,
		0,
		Lang.get(25647),
		16029,
		18,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16029019] = {
		16029019,
		0,
		Lang.get(25648),
		16029,
		19,
		141,
		{
			RTResTalkAction[154],
			RTResTalkAction[16]
		},
		1,
		[21] = 340
	},
	[16029020] = {
		16029020,
		0,
		Lang.get(25649),
		16029,
		20,
		141,
		{
			RTResTalkAction[154]
		},
		1,
		[21] = 340
	},
	[16029021] = {
		16029021,
		0,
		Lang.get(25650),
		16029,
		21,
		107,
		{
			RTResTalkAction[154]
		},
		1,
		[21] = 340
	},
	[16029022] = {
		16029022,
		0,
		Lang.get(25651),
		16029,
		22,
		188,
		{
			RTResTalkAction[154]
		},
		1,
		[21] = 340
	},
	[16029023] = {
		16029023,
		0,
		Lang.get(25652),
		16029,
		23,
		107,
		{
			RTResTalkAction[155],
			RTResTalkAction[156]
		}
	},
	[16029024] = {
		16029024,
		0,
		Lang.get(25653),
		16029,
		24,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16029025] = {
		16029025,
		0,
		Lang.get(25654),
		16029,
		25,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16029026] = {
		16029026,
		0,
		Lang.get(25655),
		16029,
		26,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[95]
		}
	},
	[16029027] = {
		16029027,
		0,
		Lang.get(25656),
		16029,
		27,
		107,
		{
			RTResTalkAction[147],
			RTResTalkAction[16]
		}
	},
	[16029028] = {
		16029028,
		0,
		Lang.get(25657),
		16029,
		28,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16029029] = {
		16029029,
		0,
		"……",
		16029,
		29,
		188,
		{
			RTResTalkAction[61],
			RTResTalkAction[95]
		}
	},
	[16029030] = {
		16029030,
		0,
		Lang.get(25658),
		16029,
		30,
		187,
		{
			RTResTalkAction[146],
			RTResTalkAction[16]
		}
	},
	[16029031] = {
		16029031,
		0,
		Lang.get(25659),
		16029,
		31,
		187,
		{
			RTResTalkAction[141]
		},
		1,
		nil,
		nil,
		nil,
		59,
		16044,
		nil,
		1,
		nil,
		1,
		nil,
		16044
	},
	[16029032] = {
		16029032,
		0,
		Lang.get(25660),
		16029,
		32,
		188,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[16029033] = {
		16029033,
		0,
		Lang.get(25661),
		16029,
		33,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16029034] = {
		16029034,
		0,
		Lang.get(25662),
		16029,
		34,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16029035] = {
		16029035,
		0,
		Lang.get(25663),
		16029,
		35,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[16]
		}
	},
	[16029036] = {
		16029036,
		0,
		Lang.get(25664),
		16029,
		36,
		107,
		{
			RTResTalkAction[147],
			RTResTalkAction[141]
		}
	},
	[16029037] = {
		16029037,
		0,
		Lang.get(25665),
		16029,
		37,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16029038] = {
		16029038,
		0,
		Lang.get(25666),
		16029,
		38,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16029039] = {
		16029039,
		0,
		Lang.get(25667),
		16029,
		39,
		187,
		{
			RTResTalkAction[144],
			RTResTalkAction[95]
		}
	},
	[16029040] = {
		16029040,
		0,
		Lang.get(25668),
		16029,
		40,
		141,
		{
			RTResTalkAction[97],
			RTResTalkAction[141]
		}
	},
	[16029041] = {
		16029041,
		0,
		Lang.get(25669),
		16029,
		41,
		141,
		{
			RTResTalkAction[97]
		}
	},
	[16029042] = {
		16029042,
		0,
		Lang.get(25670),
		16029,
		42,
		141,
		{
			RTResTalkAction[97]
		}
	},
	[16029043] = {
		16029043,
		0,
		Lang.get(25671),
		16029,
		43,
		141,
		{
			RTResTalkAction[97]
		}
	},
	[16029044] = {
		16029044,
		0,
		Lang.get(25672),
		16029,
		44,
		107,
		{
			RTResTalkAction[93],
			RTResTalkAction[88]
		}
	},
	[16029045] = {
		16029045,
		0,
		Lang.get(25673),
		16029,
		45,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[95]
		}
	},
	[16029046] = {
		16029046,
		0,
		Lang.get(25674),
		16029,
		46,
		107,
		{
			RTResTalkAction[93],
			RTResTalkAction[141]
		}
	},
	[16029047] = {
		16029047,
		0,
		Lang.get(61789),
		16029,
		47,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[95]
		}
	},
	[16029048] = {
		16029048,
		0,
		Lang.get(25675),
		16029,
		48,
		107,
		{
			RTResTalkAction[147],
			RTResTalkAction[141]
		}
	},
	[16029049] = {
		16029049,
		0,
		Lang.get(25676),
		16029,
		49,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16029050] = {
		16029050,
		0,
		Lang.get(25677),
		16029,
		50,
		141,
		{
			RTResTalkAction[97],
			RTResTalkAction[95]
		}
	},
	[16029051] = {
		16029051,
		0,
		Lang.get(25678),
		16029,
		51,
		141,
		{
			RTResTalkAction[97]
		}
	},
	[16029052] = {
		16029052,
		0,
		"…………",
		16029,
		52,
		187,
		{
			RTResTalkAction[146],
			RTResTalkAction[88]
		}
	},
	[16029053] = {
		16029053,
		0,
		Lang.get(61790),
		16029,
		53,
		187,
		{
			RTResTalkAction[139]
		}
	},
	[16029054] = {
		16029054,
		0,
		Lang.get(25679),
		16029,
		54,
		188,
		{
			RTResTalkAction[23],
			RTResTalkAction[141]
		}
	},
	[16029055] = {
		16029055,
		0,
		Lang.get(25680),
		16029,
		55,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16029056] = {
		16029056,
		0,
		Lang.get(25681),
		16029,
		56,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[16]
		}
	},
	[16030001] = {
		16030001,
		0,
		Lang.get(25682),
		16030,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		59,
		16045,
		nil,
		nil,
		nil,
		1,
		nil,
		16045
	},
	[16030002] = {
		16030002,
		0,
		Lang.get(25683),
		16030,
		2,
		141,
		{
			RTResTalkAction[97]
		},
		nil,
		nil,
		3
	},
	[16030003] = {
		16030003,
		0,
		Lang.get(25684),
		16030,
		3,
		300,
		{
			RTResTalkAction[88]
		}
	},
	[16030004] = {
		16030004,
		0,
		Lang.get(25685),
		16030,
		4,
		300
	},
	[16030005] = {
		16030005,
		0,
		Lang.get(61791),
		16030,
		5,
		107,
		{
			RTResTalkAction[155]
		}
	},
	[16030006] = {
		16030006,
		0,
		Lang.get(25686),
		16030,
		6,
		300,
		{
			RTResTalkAction[95]
		}
	},
	[16030007] = {
		16030007,
		0,
		Lang.get(25687),
		16030,
		7,
		189,
		{
			RTResTalkAction[26]
		}
	},
	[16030008] = {
		16030008,
		0,
		Lang.get(25688),
		16030,
		8,
		300,
		{
			RTResTalkAction[30]
		}
	},
	[16030009] = {
		16030009,
		0,
		Lang.get(25689),
		16030,
		9,
		300
	},
	[16030010] = {
		16030010,
		0,
		Lang.get(25690),
		16030,
		10,
		107,
		{
			RTResTalkAction[150]
		}
	},
	[16030011] = {
		16030011,
		0,
		Lang.get(25691),
		16030,
		11,
		300,
		{
			RTResTalkAction[95]
		}
	},
	[16030012] = {
		16030012,
		0,
		Lang.get(61792),
		16030,
		12,
		141,
		{
			RTResTalkAction[97]
		}
	},
	[16030013] = {
		16030013,
		0,
		Lang.get(61793),
		16030,
		13,
		300,
		{
			RTResTalkAction[88]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		16109,
		nil,
		1,
		[19] = 16109,
		[17] = 1
	},
	[16030014] = {
		16030014,
		0,
		Lang.get(25692),
		16030,
		14,
		300
	},
	[16030015] = {
		16030015,
		0,
		Lang.get(25693),
		16030,
		15,
		300
	},
	[16030016] = {
		16030016,
		0,
		Lang.get(61794),
		16030,
		16,
		188,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		16046,
		nil,
		1,
		nil,
		1,
		nil,
		16046
	},
	[16030017] = {
		16030017,
		0,
		Lang.get(25694),
		16030,
		17,
		188,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[16030018] = {
		16030018,
		0,
		Lang.get(25695),
		16030,
		18,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16030019] = {
		16030019,
		0,
		Lang.get(25696),
		16030,
		19,
		187,
		{
			RTResTalkAction[144],
			RTResTalkAction[16]
		}
	},
	[16030020] = {
		16030020,
		0,
		Lang.get(25697),
		16030,
		20,
		187,
		{
			RTResTalkAction[146]
		}
	},
	[16030021] = {
		16030021,
		0,
		Lang.get(25698),
		16030,
		21,
		187,
		{
			RTResTalkAction[139]
		}
	},
	[16030022] = {
		16030022,
		0,
		Lang.get(25699),
		16030,
		22,
		187,
		{
			RTResTalkAction[145]
		}
	},
	[16030023] = {
		16030023,
		0,
		Lang.get(25700),
		16030,
		23,
		187,
		{
			RTResTalkAction[139]
		}
	},
	[16030024] = {
		16030024,
		0,
		Lang.get(25701),
		16030,
		24,
		187,
		{
			RTResTalkAction[139]
		}
	},
	[16030025] = {
		16030025,
		0,
		Lang.get(25702),
		16030,
		25,
		188,
		{
			RTResTalkAction[61],
			RTResTalkAction[141]
		}
	},
	[16030026] = {
		16030026,
		0,
		Lang.get(25703),
		16030,
		26,
		191,
		{
			RTResTalkAction[16]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		16047,
		nil,
		1,
		nil,
		1,
		nil,
		16047
	},
	[16030027] = {
		16030027,
		5,
		Lang.get(25704),
		16030,
		27,
		188,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[16030028] = {
		16030028,
		0,
		Lang.get(25705),
		16030,
		28,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[16]
		}
	},
	[16030029] = {
		16030029,
		0,
		Lang.get(25706),
		16030,
		29,
		191,
		{
			RTResTalkAction[18]
		}
	},
	[16031001] = {
		16031001,
		0,
		Lang.get(25707),
		16031,
		1,
		187,
		nil,
		1,
		nil,
		nil,
		nil,
		57,
		16048,
		nil,
		nil,
		nil,
		1,
		nil,
		16048
	},
	[16031002] = {
		16031002,
		0,
		Lang.get(25708),
		16031,
		2,
		188,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[16031003] = {
		16031003,
		0,
		Lang.get(25709),
		16031,
		3,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16031004] = {
		16031004,
		0,
		Lang.get(25710),
		16031,
		4,
		187,
		{
			RTResTalkAction[146],
			RTResTalkAction[16]
		}
	},
	[16031005] = {
		16031005,
		0,
		Lang.get(25711),
		16031,
		5,
		187,
		{
			RTResTalkAction[139]
		}
	},
	[16031006] = {
		16031006,
		0,
		Lang.get(25712),
		16031,
		6,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[141]
		}
	},
	[16031007] = {
		16031007,
		0,
		Lang.get(25713),
		16031,
		7,
		187,
		{
			RTResTalkAction[145],
			RTResTalkAction[16]
		}
	},
	[16031008] = {
		16031008,
		0,
		Lang.get(25714),
		16031,
		8,
		187,
		{
			RTResTalkAction[139]
		}
	},
	[16031009] = {
		16031009,
		0,
		Lang.get(25715),
		16031,
		9,
		187,
		{
			RTResTalkAction[139]
		}
	},
	[16031010] = {
		16031010,
		0,
		Lang.get(25716),
		16031,
		10,
		187,
		{
			RTResTalkAction[139]
		}
	},
	[16031011] = {
		16031011,
		0,
		Lang.get(25717),
		16031,
		11,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[141]
		}
	},
	[16031012] = {
		16031012,
		0,
		Lang.get(25718),
		16031,
		12,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[16]
		}
	},
	[16031013] = {
		16031013,
		0,
		Lang.get(25719),
		16031,
		13,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[141]
		}
	},
	[16032001] = {
		16032001,
		0,
		Lang.get(25720),
		16032,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		59,
		16110,
		nil,
		nil,
		nil,
		1,
		nil,
		16110
	},
	[16032002] = {
		16032002,
		0,
		Lang.get(25721),
		16032,
		2,
		300
	},
	[16032003] = {
		16032003,
		0,
		Lang.get(25722),
		16032,
		3,
		107,
		{
			RTResTalkAction[149]
		},
		nil,
		nil,
		3
	},
	[16032004] = {
		16032004,
		0,
		Lang.get(25723),
		16032,
		4,
		300,
		{
			RTResTalkAction[95]
		}
	},
	[16032005] = {
		16032005,
		0,
		Lang.get(25724),
		16032,
		5,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16032006] = {
		16032006,
		0,
		Lang.get(25725),
		16032,
		6,
		107,
		{
			RTResTalkAction[154],
			RTResTalkAction[95]
		},
		1,
		[21] = 340
	},
	[16032007] = {
		16032007,
		0,
		"……",
		16032,
		7,
		300,
		{
			RTResTalkAction[154]
		},
		1,
		[21] = 340
	},
	[16032008] = {
		16032008,
		0,
		Lang.get(25726),
		16032,
		8,
		300,
		{
			RTResTalkAction[154]
		},
		1,
		[21] = 340
	},
	[16032009] = {
		16032009,
		0,
		Lang.get(25727),
		16032,
		9,
		300,
		{
			RTResTalkAction[154]
		},
		1,
		[21] = 340
	},
	[16032010] = {
		16032010,
		0,
		Lang.get(25728),
		16032,
		10,
		141,
		{
			RTResTalkAction[86],
			RTResTalkAction[156]
		}
	},
	[16032011] = {
		16032011,
		0,
		Lang.get(25729),
		16032,
		11,
		300,
		{
			RTResTalkAction[88]
		}
	},
	[16032012] = {
		16032012,
		0,
		Lang.get(25730),
		16032,
		12,
		107,
		{
			RTResTalkAction[136]
		}
	},
	[16032013] = {
		16032013,
		0,
		Lang.get(25731),
		16032,
		13,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16032014] = {
		16032014,
		0,
		Lang.get(25732),
		16032,
		14,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16032015] = {
		16032015,
		0,
		Lang.get(25733),
		16032,
		15,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16032016] = {
		16032016,
		0,
		Lang.get(25734),
		16032,
		16,
		300,
		{
			RTResTalkAction[95]
		}
	},
	[16032017] = {
		16032017,
		0,
		Lang.get(25735),
		16032,
		17,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16032018] = {
		16032018,
		0,
		Lang.get(25736),
		16032,
		18,
		141,
		{
			RTResTalkAction[97],
			RTResTalkAction[95]
		}
	},
	[16032019] = {
		16032019,
		0,
		Lang.get(61795),
		16032,
		19,
		300,
		{
			RTResTalkAction[88]
		}
	},
	[16032020] = {
		16032020,
		0,
		Lang.get(25738),
		16032,
		20,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16032021] = {
		16032021,
		9,
		Lang.get(70088),
		16032,
		21,
		605,
		{
			RTResTalkAction[157],
			RTResTalkAction[95]
		},
		[21] = 341,
		[22] = 1
	},
	[16032022] = {
		16032022,
		0,
		Lang.get(25740),
		16032,
		22,
		107,
		{
			RTResTalkAction[157]
		},
		1,
		[21] = 341
	},
	[16032023] = {
		16032023,
		0,
		Lang.get(25741),
		16032,
		23,
		141,
		{
			RTResTalkAction[157]
		},
		1,
		[21] = 341
	},
	[16032024] = {
		16032024,
		0,
		Lang.get(25742),
		16032,
		24,
		300,
		{
			RTResTalkAction[157]
		},
		[21] = 341
	},
	[16032025] = {
		16032025,
		0,
		Lang.get(25743),
		16032,
		25,
		300,
		{
			RTResTalkAction[157]
		},
		[21] = 341
	},
	[16032026] = {
		16032026,
		0,
		Lang.get(25744),
		16032,
		26,
		141,
		{
			RTResTalkAction[97],
			RTResTalkAction[158]
		}
	},
	[16032027] = {
		16032027,
		0,
		Lang.get(25745),
		16032,
		27,
		107,
		{
			RTResTalkAction[92],
			RTResTalkAction[88]
		}
	},
	[16033001] = {
		16033001,
		0,
		Lang.get(25746),
		16033,
		1,
		191,
		nil,
		1,
		nil,
		nil,
		nil,
		57,
		16111,
		nil,
		nil,
		nil,
		1,
		nil,
		16111
	},
	[16033002] = {
		16033002,
		0,
		Lang.get(25747),
		16033,
		2,
		191,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3
	},
	[16033003] = {
		16033003,
		0,
		Lang.get(25748),
		16033,
		3,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16033004] = {
		16033004,
		0,
		Lang.get(25749),
		16033,
		4,
		187,
		{
			RTResTalkAction[146],
			RTResTalkAction[19]
		}
	},
	[16033005] = {
		16033005,
		0,
		Lang.get(25750),
		16033,
		5,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[141]
		}
	},
	[16033006] = {
		16033006,
		0,
		Lang.get(25751),
		16033,
		6,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16033007] = {
		16033007,
		0,
		Lang.get(25752),
		16033,
		7,
		191,
		{
			RTResTalkAction[18]
		}
	},
	[16033008] = {
		16033008,
		0,
		Lang.get(25753),
		16033,
		8,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[19]
		}
	},
	[16033009] = {
		16033009,
		0,
		Lang.get(61796),
		16033,
		9,
		188,
		{
			RTResTalkAction[23],
			RTResTalkAction[141]
		}
	},
	[16033010] = {
		16033010,
		5,
		Lang.get(25754),
		16033,
		10,
		187,
		{
			RTResTalkAction[159],
			RTResTalkAction[16]
		}
	},
	[16033011] = {
		16033011,
		0,
		Lang.get(25755),
		16033,
		11,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[141]
		}
	},
	[16033012] = {
		16033012,
		0,
		Lang.get(25756),
		16033,
		12,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[16]
		}
	},
	[16033013] = {
		16033013,
		0,
		Lang.get(25757),
		16033,
		13,
		187,
		{
			RTResTalkAction[139]
		}
	},
	[16033014] = {
		16033014,
		0,
		Lang.get(61797),
		16033,
		14,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[141]
		}
	},
	[16033015] = {
		16033015,
		0,
		Lang.get(25758),
		16033,
		15,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[16]
		}
	},
	[16033016] = {
		16033016,
		0,
		Lang.get(25759),
		16033,
		16,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[141]
		}
	},
	[16033017] = {
		16033017,
		0,
		Lang.get(25760),
		16033,
		17,
		191,
		{
			RTResTalkAction[16]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		16049,
		nil,
		1,
		nil,
		1,
		nil,
		16049
	},
	[16033018] = {
		16033018,
		0,
		Lang.get(25761),
		16033,
		18,
		191,
		{
			RTResTalkAction[20]
		},
		nil,
		nil,
		3
	},
	[16033019] = {
		16033019,
		0,
		Lang.get(25762),
		16033,
		19,
		191,
		{
			RTResTalkAction[18]
		}
	},
	[16033020] = {
		16033020,
		0,
		Lang.get(25763),
		16033,
		20,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16033021] = {
		16033021,
		0,
		Lang.get(25764),
		16033,
		21,
		187,
		{
			RTResTalkAction[145],
			RTResTalkAction[19]
		}
	},
	[16033022] = {
		16033022,
		0,
		Lang.get(25765),
		16033,
		22,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[141]
		}
	},
	[16033023] = {
		16033023,
		0,
		Lang.get(25766),
		16033,
		23,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16033024] = {
		16033024,
		0,
		Lang.get(25767),
		16033,
		24,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[19]
		}
	},
	[16033025] = {
		16033025,
		0,
		Lang.get(25768),
		16033,
		25,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[141]
		}
	},
	[16034001] = {
		16034001,
		0,
		Lang.get(25769),
		16034,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		59,
		16051,
		nil,
		nil,
		nil,
		1,
		nil,
		16051
	},
	[16034002] = {
		16034002,
		0,
		Lang.get(25770),
		16034,
		2,
		107,
		{
			RTResTalkAction[140]
		},
		nil,
		nil,
		3
	},
	[16034003] = {
		16034003,
		0,
		Lang.get(25771),
		16034,
		3,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16034004] = {
		16034004,
		0,
		Lang.get(25772),
		16034,
		4,
		141,
		{
			RTResTalkAction[97],
			RTResTalkAction[95]
		}
	},
	[16034005] = {
		16034005,
		0,
		Lang.get(25773),
		16034,
		5,
		141,
		{
			RTResTalkAction[97]
		}
	},
	[16034006] = {
		16034006,
		0,
		Lang.get(25774),
		16034,
		6,
		107,
		{
			RTResTalkAction[92],
			RTResTalkAction[88]
		}
	},
	[16034007] = {
		16034007,
		0,
		Lang.get(25775),
		16034,
		7,
		107,
		{
			RTResTalkAction[95]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		16112,
		nil,
		1,
		nil,
		1,
		nil,
		16112
	},
	[16034008] = {
		16034008,
		0,
		Lang.get(25776),
		16034,
		8,
		141,
		{
			RTResTalkAction[97]
		},
		nil,
		nil,
		3
	},
	[16034009] = {
		16034009,
		0,
		Lang.get(25777),
		16034,
		9,
		141,
		{
			RTResTalkAction[97]
		}
	},
	[16034010] = {
		16034010,
		0,
		Lang.get(25778),
		16034,
		10,
		107,
		{
			RTResTalkAction[136],
			RTResTalkAction[88]
		}
	},
	[16034011] = {
		16034011,
		0,
		Lang.get(25779),
		16034,
		11,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16034012] = {
		16034012,
		0,
		Lang.get(25780),
		16034,
		12,
		141,
		{
			RTResTalkAction[97],
			RTResTalkAction[95]
		}
	},
	[16034013] = {
		16034013,
		0,
		Lang.get(61798),
		16034,
		13,
		107,
		{
			RTResTalkAction[92],
			RTResTalkAction[88]
		}
	},
	[16034014] = {
		16034014,
		0,
		Lang.get(25781),
		16034,
		14,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16034015] = {
		16034015,
		0,
		Lang.get(25782),
		16034,
		15,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16035001] = {
		16035001,
		0,
		Lang.get(25783),
		16035,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		59,
		16113,
		nil,
		nil,
		nil,
		1,
		nil,
		16113
	},
	[16035002] = {
		16035002,
		0,
		Lang.get(25784),
		16035,
		2,
		107,
		{
			RTResTalkAction[93]
		},
		nil,
		nil,
		3
	},
	[16035003] = {
		16035003,
		0,
		Lang.get(25785),
		16035,
		3,
		141,
		{
			RTResTalkAction[97],
			RTResTalkAction[95]
		}
	},
	[16035004] = {
		16035004,
		0,
		Lang.get(25786),
		16035,
		4,
		107,
		{
			RTResTalkAction[93],
			RTResTalkAction[88]
		}
	},
	[16035005] = {
		16035005,
		0,
		Lang.get(25787),
		16035,
		5,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16035006] = {
		16035006,
		0,
		Lang.get(25788),
		16035,
		6,
		188,
		{
			RTResTalkAction[95]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		16052,
		nil,
		1,
		nil,
		1,
		nil,
		16052
	},
	[16035007] = {
		16035007,
		0,
		Lang.get(25789),
		16035,
		7,
		107,
		{
			RTResTalkAction[136]
		},
		nil,
		nil,
		3
	},
	[16035008] = {
		16035008,
		0,
		Lang.get(25790),
		16035,
		8,
		188,
		{
			RTResTalkAction[23],
			RTResTalkAction[95]
		}
	},
	[16035009] = {
		16035009,
		0,
		Lang.get(25791),
		16035,
		9,
		107,
		{
			RTResTalkAction[93],
			RTResTalkAction[16]
		}
	},
	[16035010] = {
		16035010,
		0,
		Lang.get(25792),
		16035,
		10,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[95]
		}
	},
	[16035011] = {
		16035011,
		0,
		Lang.get(61799),
		16035,
		11,
		107,
		{
			RTResTalkAction[92],
			RTResTalkAction[16]
		}
	},
	[16035012] = {
		16035012,
		0,
		Lang.get(25793),
		16035,
		12,
		141,
		{
			RTResTalkAction[97],
			RTResTalkAction[95]
		}
	},
	[16035013] = {
		16035013,
		0,
		"…………",
		16035,
		13,
		188,
		{
			RTResTalkAction[24],
			RTResTalkAction[88]
		}
	},
	[16035014] = {
		16035014,
		0,
		Lang.get(25794),
		16035,
		14,
		188,
		{
			RTResTalkAction[23]
		}
	},
	[16035015] = {
		16035015,
		0,
		Lang.get(25795),
		16035,
		15,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16035016] = {
		16035016,
		0,
		Lang.get(61800),
		16035,
		16,
		107,
		{
			RTResTalkAction[155],
			RTResTalkAction[16]
		}
	},
	[16036001] = {
		16036001,
		0,
		Lang.get(25796),
		16036,
		1,
		188,
		nil,
		1,
		nil,
		nil,
		nil,
		57,
		16053,
		nil,
		nil,
		nil,
		1,
		nil,
		16053
	},
	[16036002] = {
		16036002,
		0,
		Lang.get(25797),
		16036,
		2,
		188,
		{
			RTResTalkAction[25]
		},
		nil,
		nil,
		3
	},
	[16036003] = {
		16036003,
		0,
		Lang.get(25798),
		16036,
		3,
		107,
		{
			RTResTalkAction[90],
			RTResTalkAction[16]
		}
	},
	[16036004] = {
		16036004,
		0,
		Lang.get(25799),
		16036,
		4,
		647,
		{
			RTResTalkAction[134],
			RTResTalkAction[95]
		}
	},
	[16036005] = {
		16036005,
		0,
		Lang.get(25800),
		16036,
		5,
		647,
		{
			RTResTalkAction[134]
		}
	},
	[16036006] = {
		16036006,
		0,
		Lang.get(25801),
		16036,
		6,
		188,
		{
			RTResTalkAction[61],
			RTResTalkAction[130]
		}
	},
	[16036007] = {
		16036007,
		0,
		Lang.get(25802),
		16036,
		7,
		107,
		{
			RTResTalkAction[93],
			RTResTalkAction[16]
		}
	},
	[16036008] = {
		16036008,
		0,
		Lang.get(25803),
		16036,
		8,
		188,
		{
			RTResTalkAction[95]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		16054,
		nil,
		1,
		nil,
		1,
		nil,
		16054
	},
	[16036009] = {
		16036009,
		0,
		Lang.get(25804),
		16036,
		9,
		647,
		{
			RTResTalkAction[134]
		},
		nil,
		nil,
		3
	},
	[16036010] = {
		16036010,
		0,
		Lang.get(61801),
		16036,
		10,
		107,
		{
			RTResTalkAction[149],
			RTResTalkAction[130]
		}
	},
	[16036011] = {
		16036011,
		0,
		Lang.get(25805),
		16036,
		11,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16036012] = {
		16036012,
		0,
		Lang.get(25806),
		16036,
		12,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[95]
		}
	},
	[16036013] = {
		16036013,
		0,
		Lang.get(25807),
		16036,
		13,
		188,
		{
			RTResTalkAction[25]
		}
	},
	[16036014] = {
		16036014,
		0,
		Lang.get(25808),
		16036,
		14,
		141,
		{
			RTResTalkAction[97],
			RTResTalkAction[16]
		}
	},
	[16036015] = {
		16036015,
		0,
		Lang.get(25809),
		16036,
		15,
		191,
		{
			RTResTalkAction[88]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		16055,
		nil,
		1,
		nil,
		1,
		nil,
		16055
	},
	[16036016] = {
		16036016,
		0,
		Lang.get(25810),
		16036,
		16,
		187,
		{
			RTResTalkAction[145]
		},
		nil,
		nil,
		3
	},
	[16036017] = {
		16036017,
		0,
		"……",
		16036,
		17,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[141]
		}
	},
	[16036018] = {
		16036018,
		0,
		Lang.get(25811),
		16036,
		18,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16036019] = {
		16036019,
		0,
		Lang.get(25812),
		16036,
		19,
		191,
		{
			RTResTalkAction[18]
		}
	},
	[16036020] = {
		16036020,
		0,
		"……",
		16036,
		20,
		187,
		{
			RTResTalkAction[151],
			RTResTalkAction[19]
		}
	},
	[16036021] = {
		16036021,
		0,
		Lang.get(25813),
		16036,
		21,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[141]
		}
	},
	[16036022] = {
		16036022,
		0,
		Lang.get(25814),
		16036,
		22,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16036023] = {
		16036023,
		0,
		Lang.get(25815),
		16036,
		23,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16036024] = {
		16036024,
		0,
		Lang.get(61802),
		16036,
		24,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[19]
		}
	},
	[16036025] = {
		16036025,
		0,
		Lang.get(25816),
		16036,
		25,
		187,
		{
			RTResTalkAction[145]
		}
	},
	[16036026] = {
		16036026,
		0,
		Lang.get(25817),
		16036,
		26,
		191,
		{
			RTResTalkAction[18],
			RTResTalkAction[141]
		}
	},
	[16036027] = {
		16036027,
		0,
		Lang.get(25818),
		16036,
		27,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16036028] = {
		16036028,
		0,
		Lang.get(25819),
		16036,
		28,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16036029] = {
		16036029,
		0,
		"……",
		16036,
		29,
		187,
		{
			RTResTalkAction[146],
			RTResTalkAction[19]
		}
	},
	[16036030] = {
		16036030,
		0,
		Lang.get(25820),
		16036,
		30,
		187,
		{
			RTResTalkAction[143]
		}
	},
	[16036031] = {
		16036031,
		0,
		Lang.get(61803),
		16036,
		31,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[141]
		}
	},
	[16036032] = {
		16036032,
		0,
		Lang.get(25822),
		16036,
		32,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[19]
		}
	},
	[16036033] = {
		16036033,
		0,
		Lang.get(25823),
		16036,
		33,
		187,
		{
			RTResTalkAction[139]
		}
	},
	[16036034] = {
		16036034,
		0,
		Lang.get(25824),
		16036,
		34,
		187,
		{
			RTResTalkAction[143]
		}
	},
	[16036035] = {
		16036035,
		0,
		Lang.get(25825),
		16036,
		35,
		187,
		{
			RTResTalkAction[139]
		}
	},
	[16036036] = {
		16036036,
		0,
		Lang.get(25826),
		16036,
		36,
		191,
		{
			RTResTalkAction[20],
			RTResTalkAction[141]
		}
	},
	[16036037] = {
		16036037,
		0,
		Lang.get(25827),
		16036,
		37,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16036038] = {
		16036038,
		0,
		Lang.get(25828),
		16036,
		38,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16036039] = {
		16036039,
		0,
		Lang.get(25829),
		16036,
		39,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[19]
		}
	},
	[16036040] = {
		16036040,
		0,
		Lang.get(25830),
		16036,
		40,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[141]
		}
	},
	[16036041] = {
		16036041,
		0,
		Lang.get(25831),
		16036,
		41,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16036042] = {
		16036042,
		0,
		Lang.get(25832),
		16036,
		42,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16036043] = {
		16036043,
		0,
		Lang.get(25833),
		16036,
		43,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16036044] = {
		16036044,
		5,
		Lang.get(25834),
		16036,
		44,
		107,
		{
			RTResTalkAction[19]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		16056,
		nil,
		1,
		nil,
		1,
		nil,
		16056
	},
	[16037001] = {
		16037001,
		0,
		Lang.get(25835),
		16037,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		58,
		16057,
		nil,
		nil,
		nil,
		1,
		nil,
		16057
	},
	[16037002] = {
		16037002,
		0,
		Lang.get(25836),
		16037,
		2,
		187,
		{
			RTResTalkAction[145]
		},
		nil,
		nil,
		3
	},
	[16037003] = {
		16037003,
		0,
		Lang.get(25837),
		16037,
		3,
		188,
		{
			RTResTalkAction[23],
			RTResTalkAction[141]
		}
	},
	[16037004] = {
		16037004,
		0,
		Lang.get(25838),
		16037,
		4,
		187,
		{
			RTResTalkAction[144],
			RTResTalkAction[16]
		}
	},
	[16037005] = {
		16037005,
		0,
		Lang.get(25839),
		16037,
		5,
		107,
		{
			RTResTalkAction[92],
			RTResTalkAction[141]
		}
	},
	[16037006] = {
		16037006,
		0,
		Lang.get(25840),
		16037,
		6,
		187,
		{
			RTResTalkAction[145],
			RTResTalkAction[95]
		}
	},
	[16037007] = {
		16037007,
		0,
		Lang.get(25841),
		16037,
		7,
		107,
		{
			RTResTalkAction[90],
			RTResTalkAction[141]
		}
	},
	[16037008] = {
		16037008,
		0,
		Lang.get(25842),
		16037,
		8,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[95]
		}
	},
	[16037009] = {
		16037009,
		0,
		Lang.get(25843),
		16037,
		9,
		107,
		{
			RTResTalkAction[101],
			RTResTalkAction[141]
		}
	},
	[16037010] = {
		16037010,
		0,
		Lang.get(25844),
		16037,
		10,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16037011] = {
		16037011,
		0,
		Lang.get(25845),
		16037,
		11,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16037012] = {
		16037012,
		0,
		Lang.get(25846),
		16037,
		12,
		188,
		{
			RTResTalkAction[61],
			RTResTalkAction[95]
		}
	},
	[16037013] = {
		16037013,
		0,
		Lang.get(25847),
		16037,
		13,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[16]
		}
	},
	[16037014] = {
		16037014,
		0,
		Lang.get(25848),
		16037,
		14,
		188,
		{
			RTResTalkAction[24],
			RTResTalkAction[141]
		}
	},
	[16037015] = {
		16037015,
		0,
		Lang.get(25849),
		16037,
		15,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[16]
		}
	},
	[16037016] = {
		16037016,
		0,
		Lang.get(25850),
		16037,
		16,
		191,
		{
			RTResTalkAction[141]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		16114,
		nil,
		1,
		nil,
		1,
		nil,
		16114
	},
	[16037017] = {
		16037017,
		0,
		Lang.get(25851),
		16037,
		17,
		191,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3
	},
	[16037018] = {
		16037018,
		0,
		Lang.get(25852),
		16037,
		18,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16037019] = {
		16037019,
		0,
		Lang.get(25853),
		16037,
		19,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16037020] = {
		16037020,
		0,
		Lang.get(25854),
		16037,
		20,
		107,
		{
			RTResTalkAction[92],
			RTResTalkAction[19]
		}
	},
	[16037021] = {
		16037021,
		0,
		Lang.get(25855),
		16037,
		21,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[95]
		}
	},
	[16037022] = {
		16037022,
		0,
		Lang.get(25856),
		16037,
		22,
		188,
		{
			RTResTalkAction[17]
		}
	},
	[16037023] = {
		16037023,
		0,
		Lang.get(25857),
		16037,
		23,
		191,
		{
			RTResTalkAction[18],
			RTResTalkAction[16]
		}
	},
	[16037024] = {
		16037024,
		0,
		Lang.get(25858),
		16037,
		24,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16037025] = {
		16037025,
		0,
		Lang.get(25859),
		16037,
		25,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[19]
		}
	},
	[16037026] = {
		16037026,
		0,
		Lang.get(25860),
		16037,
		26,
		187,
		{
			RTResTalkAction[145],
			RTResTalkAction[16]
		}
	},
	[16037027] = {
		16037027,
		0,
		Lang.get(25861),
		16037,
		27,
		187,
		{
			RTResTalkAction[139]
		}
	},
	[16037028] = {
		16037028,
		0,
		Lang.get(25862),
		16037,
		28,
		187,
		{
			RTResTalkAction[139]
		}
	},
	[16037029] = {
		16037029,
		0,
		Lang.get(25863),
		16037,
		29,
		188,
		{
			RTResTalkAction[24],
			RTResTalkAction[141]
		}
	},
	[16038001] = {
		16038001,
		0,
		Lang.get(25864),
		16038,
		1,
		187,
		nil,
		1,
		4,
		nil,
		nil,
		115,
		16058,
		nil,
		nil,
		nil,
		1,
		nil,
		16058
	},
	[16038002] = {
		16038002,
		0,
		Lang.get(25865),
		16038,
		2,
		300
	},
	[16038003] = {
		16038003,
		0,
		Lang.get(25866),
		16038,
		3,
		187,
		{
			RTResTalkAction[144]
		},
		nil,
		nil,
		3
	},
	[16038004] = {
		16038004,
		0,
		Lang.get(61804),
		16038,
		4,
		187,
		{
			RTResTalkAction[139]
		}
	},
	[16038005] = {
		16038005,
		0,
		Lang.get(25867),
		16038,
		5,
		107,
		{
			RTResTalkAction[90],
			RTResTalkAction[141]
		}
	},
	[16038006] = {
		16038006,
		0,
		Lang.get(61805),
		16038,
		6,
		187,
		{
			RTResTalkAction[146],
			RTResTalkAction[95]
		}
	},
	[16038007] = {
		16038007,
		0,
		Lang.get(25868),
		16038,
		7,
		107,
		{
			RTResTalkAction[90],
			RTResTalkAction[141]
		}
	},
	[16038008] = {
		16038008,
		0,
		Lang.get(25869),
		16038,
		8,
		107,
		{
			RTResTalkAction[140]
		}
	},
	[16038009] = {
		16038009,
		0,
		Lang.get(25870),
		16038,
		9,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[95]
		}
	},
	[16038010] = {
		16038010,
		0,
		Lang.get(25871),
		16038,
		10,
		107,
		{
			RTResTalkAction[92],
			RTResTalkAction[141]
		}
	},
	[16038011] = {
		16038011,
		0,
		Lang.get(61806),
		16038,
		11,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16038012] = {
		16038012,
		0,
		Lang.get(25872),
		16038,
		12,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16038013] = {
		16038013,
		0,
		Lang.get(25873),
		16038,
		13,
		107,
		{
			RTResTalkAction[136]
		}
	},
	[16038014] = {
		16038014,
		0,
		Lang.get(25874),
		16038,
		14,
		300,
		{
			RTResTalkAction[95]
		}
	},
	[16038015] = {
		16038015,
		0,
		Lang.get(25875),
		16038,
		15,
		107,
		{
			RTResTalkAction[90]
		}
	},
	[16038016] = {
		16038016,
		0,
		Lang.get(25876),
		16038,
		16,
		107,
		{
			RTResTalkAction[93]
		}
	},
	[16038017] = {
		16038017,
		0,
		Lang.get(25877),
		16038,
		17,
		188,
		{
			RTResTalkAction[25],
			RTResTalkAction[95]
		}
	},
	[16038018] = {
		16038018,
		0,
		Lang.get(25878),
		16038,
		18,
		187,
		{
			RTResTalkAction[144],
			RTResTalkAction[16]
		}
	},
	[16038019] = {
		16038019,
		0,
		Lang.get(25879),
		16038,
		19,
		107,
		{
			RTResTalkAction[141]
		},
		1,
		0,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		nil,
		1,
		nil,
		16115
	},
	[16038020] = {
		16038020,
		0,
		Lang.get(25880),
		16038,
		20,
		107,
		nil,
		1
	},
	[16038021] = {
		16038021,
		0,
		Lang.get(25881),
		16038,
		21,
		107,
		nil,
		1
	},
	[16038022] = {
		16038022,
		0,
		Lang.get(25882),
		16038,
		22,
		107,
		nil,
		1
	},
	[16038023] = {
		16038023,
		0,
		Lang.get(25883),
		16038,
		23,
		300,
		nil,
		1
	},
	[16038024] = {
		16038024,
		0,
		Lang.get(25884),
		16038,
		24,
		107,
		nil,
		1
	},
	[16038025] = {
		16038025,
		0,
		Lang.get(25885),
		16038,
		25,
		300,
		nil,
		1
	},
	[16038026] = {
		16038026,
		0,
		Lang.get(25886),
		16038,
		26,
		188,
		nil,
		1
	},
	[16038027] = {
		16038027,
		0,
		Lang.get(25887),
		16038,
		27,
		187,
		nil,
		1,
		4
	},
	[16038028] = {
		16038028,
		0,
		Lang.get(25888),
		16038,
		28,
		300,
		nil,
		1
	},
	[16038029] = {
		16038029,
		0,
		Lang.get(25889),
		16038,
		29,
		107,
		nil,
		1,
		0
	},
	[16038030] = {
		16038030,
		0,
		Lang.get(25890),
		16038,
		30,
		107,
		nil,
		1
	},
	[16038031] = {
		16038031,
		0,
		Lang.get(25891),
		16038,
		31,
		107,
		nil,
		1
	},
	[16038032] = {
		16038032,
		0,
		Lang.get(25892),
		16038,
		32,
		188,
		nil,
		1
	},
	[16038033] = {
		16038033,
		0,
		Lang.get(25893),
		16038,
		33,
		188,
		nil,
		1
	},
	[16038034] = {
		16038034,
		0,
		Lang.get(25894),
		16038,
		34,
		191,
		nil,
		1,
		nil,
		nil,
		nil,
		116,
		16059,
		nil,
		1,
		nil,
		1,
		nil,
		16059
	},
	[16038035] = {
		16038035,
		0,
		Lang.get(25895),
		16038,
		35,
		187,
		{
			RTResTalkAction[145]
		},
		nil,
		nil,
		3
	},
	[16038036] = {
		16038036,
		0,
		Lang.get(25896),
		16038,
		36,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[141]
		}
	},
	[16038037] = {
		16038037,
		0,
		Lang.get(25897),
		16038,
		37,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16038038] = {
		16038038,
		0,
		Lang.get(25898),
		16038,
		38,
		187,
		{
			RTResTalkAction[144],
			RTResTalkAction[19]
		}
	},
	[16038039] = {
		16038039,
		0,
		Lang.get(25899),
		16038,
		39,
		187,
		{
			RTResTalkAction[139]
		}
	},
	[16038040] = {
		16038040,
		0,
		"…………",
		16038,
		40,
		191,
		{
			RTResTalkAction[21],
			RTResTalkAction[141]
		}
	},
	[16038041] = {
		16038041,
		0,
		Lang.get(25900),
		16038,
		41,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16038042] = {
		16038042,
		0,
		Lang.get(25901),
		16038,
		42,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16038043] = {
		16038043,
		0,
		Lang.get(25902),
		16038,
		43,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16038044] = {
		16038044,
		0,
		Lang.get(25903),
		16038,
		44,
		187,
		{
			RTResTalkAction[145],
			RTResTalkAction[19]
		}
	},
	[16038045] = {
		16038045,
		0,
		Lang.get(25904),
		16038,
		45,
		191,
		{
			RTResTalkAction[18],
			RTResTalkAction[141]
		}
	},
	[16038046] = {
		16038046,
		0,
		Lang.get(25905),
		16038,
		46,
		191,
		{
			RTResTalkAction[21]
		}
	},
	[16038047] = {
		16038047,
		0,
		Lang.get(25906),
		16038,
		47,
		191,
		{
			RTResTalkAction[20]
		}
	},
	[16038048] = {
		16038048,
		0,
		Lang.get(61807),
		16038,
		48,
		187,
		{
			RTResTalkAction[139],
			RTResTalkAction[19]
		}
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
