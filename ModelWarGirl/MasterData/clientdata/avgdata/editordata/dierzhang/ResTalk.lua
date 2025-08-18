-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\dierzhang\\ResTalk.lua

local indexMap = {
	npc_id = 6,
	scenery_id = 13,
	bg_blur = 10,
	play_delay = 14,
	mask_alpha = 19,
	section = 4,
	clear_role = 15,
	bgm = 12,
	vocal = 11,
	bg_voice = 17,
	terminal_type = 26,
	hide_name = 21,
	terminal_effect = 24,
	talk_in_ani = 23,
	terminal_bg = 25,
	page = 5,
	talk_type = 2,
	head_emoji = 9,
	action = 7,
	switch_show = 16,
	font_size = 22,
	extra_npc = 20,
	bg_id = 18,
	talk = 3,
	branch_info = 27,
	id = 1,
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
	107,
	{
		1,
		10031
	},
	nil,
	6
}
RTResTalkAction[2] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[3] = {
	[1] = 1,
	[2] = 376
}
RTResTalkAction[4] = {
	[1] = 1,
	[2] = 360
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 376
}
RTResTalkAction[6] = {
	1,
	360,
	nil,
	nil,
	0
}
RTResTalkAction[7] = {
	1,
	107,
	{
		10021
	},
	nil,
	2
}
RTResTalkAction[8] = {
	[1] = 0,
	[2] = 360
}
RTResTalkAction[9] = {
	1,
	133,
	nil,
	nil,
	0
}
RTResTalkAction[10] = {
	[1] = 0,
	[2] = 133
}
RTResTalkAction[11] = {
	[1] = 1,
	[2] = 141
}
RTResTalkAction[12] = {
	[1] = 1,
	[2] = 133
}
RTResTalkAction[13] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[14] = {
	[1] = 1,
	[2] = 676
}
RTResTalkAction[15] = {
	[1] = 0,
	[2] = 676
}
RTResTalkAction[16] = {
	1,
	119,
	nil,
	nil,
	3
}
RTResTalkAction[17] = {
	[1] = 2,
	[2] = 119
}
RTResTalkAction[18] = {
	[1] = 3,
	[2] = 676
}
RTResTalkAction[19] = {
	2,
	119,
	{
		2
	},
	nil,
	6
}
RTResTalkAction[20] = {
	2,
	119,
	{
		1
	},
	nil,
	7
}
RTResTalkAction[21] = {
	2,
	119,
	nil,
	nil,
	3
}
RTResTalkAction[22] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[23] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[24] = {
	[1] = 3,
	[2] = 141
}
RTResTalkAction[25] = {
	[1] = 1,
	[2] = 303
}
RTResTalkAction[26] = {
	[1] = 0,
	[2] = 303
}
RTResTalkAction[27] = {
	2,
	107,
	{
		10021
	},
	nil,
	8
}
RTResTalkAction[28] = {
	1,
	133,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[29] = {
	1,
	107,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[30] = {
	1,
	119,
	{
		10045
	},
	nil,
	1
}
RTResTalkAction[31] = {
	[1] = 1,
	[2] = 119
}
RTResTalkAction[32] = {
	[1] = 1,
	[2] = 673
}
RTResTalkAction[33] = {
	[1] = 0,
	[2] = 119
}
RTResTalkAction[34] = {
	[1] = 2,
	[2] = 673
}
RTResTalkAction[35] = {
	[1] = 3,
	[2] = 674
}
RTResTalkAction[36] = {
	[1] = 1,
	[2] = 678
}
RTResTalkAction[37] = {
	[1] = 0,
	[2] = 673
}
RTResTalkAction[38] = {
	[1] = 0,
	[2] = 674
}
RTResTalkAction[39] = {
	2,
	119,
	nil,
	nil,
	6
}
RTResTalkAction[40] = {
	[1] = 3,
	[2] = 678
}
RTResTalkAction[41] = {
	1,
	119,
	nil,
	nil,
	5
}
RTResTalkAction[42] = {
	[1] = 0,
	[2] = 678
}
RTResTalkAction[43] = {
	2,
	119,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[44] = {
	2,
	119,
	{
		10015
	},
	nil,
	3
}
RTResTalkAction[45] = {
	1,
	119,
	{
		10025,
		2
	},
	nil,
	5
}
RTResTalkAction[46] = {
	1,
	107,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[47] = {
	1,
	107,
	nil,
	nil,
	3
}
RTResTalkAction[48] = {
	1,
	107,
	{
		10021
	},
	nil,
	8
}
RTResTalkAction[49] = {
	[1] = 1,
	[2] = 674
}
RTResTalkAction[50] = {
	1,
	107,
	{
		2
	},
	nil,
	7
}
RTResTalkAction[51] = {
	[1] = 1,
	[2] = 678,
	[3] = {
		2
	}
}
RTResTalkAction[52] = {
	1,
	107,
	nil,
	nil,
	0
}
RTResTalkAction[53] = {
	1,
	119,
	{
		10015
	},
	nil,
	0
}
RTResTalkAction[54] = {
	1,
	107,
	{
		2
	},
	nil,
	8
}
RTResTalkAction[55] = {
	1,
	119,
	nil,
	nil,
	7
}
RTResTalkAction[56] = {
	1,
	119,
	{
		10025
	},
	nil,
	1
}
RTResTalkAction[57] = {
	1,
	119,
	nil,
	nil,
	0
}
RTResTalkAction[58] = {
	1,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[59] = {
	1,
	107,
	nil,
	nil,
	5
}
RTResTalkAction[60] = {
	1,
	107,
	nil,
	nil,
	7
}
RTResTalkAction[61] = {
	1,
	119,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[62] = {
	1,
	107,
	{
		10011
	},
	nil,
	4
}
RTResTalkAction[63] = {
	2,
	107,
	{
		1
	},
	nil,
	7
}
RTResTalkAction[64] = {
	2,
	107,
	nil,
	nil,
	5
}
RTResTalkAction[65] = {
	1,
	107,
	{
		2,
		10021
	},
	nil,
	7
}
RTResTalkAction[66] = {
	2,
	107,
	{
		10031,
		2
	},
	nil,
	5
}
RTResTalkAction[67] = {
	2,
	107,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[68] = {
	2,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[69] = {
	[1] = 3,
	[2] = 141,
	[3] = {
		10012
	}
}
RTResTalkAction[70] = {
	1,
	133,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[71] = {
	1,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[72] = {
	2,
	107,
	nil,
	nil,
	3
}
RTResTalkAction[73] = {
	[1] = 4,
	[2] = 107
}
RTResTalkAction[74] = {
	[1] = 5,
	[2] = 141
}
RTResTalkAction[75] = {
	2,
	107,
	{
		10021
	},
	nil,
	0
}
RTResTalkAction[76] = {
	[1] = 3,
	[2] = 679
}
RTResTalkAction[77] = {
	[1] = 0,
	[2] = 679
}
RTResTalkAction[78] = {
	[1] = 1,
	[2] = 679,
	[3] = {
		1
	}
}
RTResTalkAction[79] = {
	2,
	107,
	{
		2,
		10021
	},
	nil,
	8
}
RTResTalkAction[80] = {
	[1] = 1,
	[2] = 679
}
RTResTalkAction[81] = {
	2,
	107,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[82] = {
	1,
	119,
	nil,
	nil,
	6
}
RTResTalkAction[83] = {
	[1] = 3,
	[2] = 128
}
RTResTalkAction[84] = {
	[1] = 0,
	[2] = 128
}
RTResTalkAction[85] = {
	2,
	119,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[86] = {
	1,
	150,
	nil,
	nil,
	5
}
RTResTalkAction[87] = {
	1,
	150,
	nil,
	nil,
	3
}
RTResTalkAction[88] = {
	[1] = 1,
	[2] = 150
}
RTResTalkAction[89] = {
	1,
	150,
	nil,
	nil,
	0
}
RTResTalkAction[90] = {
	[1] = 0,
	[2] = 150
}
RTResTalkAction[91] = {
	1,
	150,
	nil,
	nil,
	1
}
RTResTalkAction[92] = {
	[1] = 2,
	[2] = 150
}
RTResTalkAction[93] = {
	[1] = 3,
	[2] = 119
}
RTResTalkAction[94] = {
	1,
	128,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[95] = {
	2,
	150,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[96] = {
	2,
	150,
	nil,
	nil,
	0
}
RTResTalkAction[97] = {
	2,
	150,
	nil,
	nil,
	1
}
RTResTalkAction[98] = {
	1,
	119,
	{
		3
	},
	nil,
	7
}
RTResTalkAction[99] = {
	2,
	107,
	nil,
	nil,
	7
}
RTResTalkAction[100] = {
	2,
	119,
	{
		10025
	},
	nil,
	5
}
RTResTalkAction[101] = {
	2,
	119,
	nil,
	nil,
	1
}
RTResTalkAction[102] = {
	1,
	119,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[103] = {
	2,
	119,
	{
		2
	},
	nil,
	5
}
RTResTalkAction[104] = {
	2,
	150,
	{
		100113
	},
	nil,
	2
}
RTResTalkAction[105] = {
	1,
	150,
	nil,
	nil,
	6
}
RTResTalkAction[106] = {
	[1] = 1,
	[2] = 119,
	[3] = {
		2
	}
}
RTResTalkAction[107] = {
	2,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[108] = {
	1,
	119,
	nil,
	nil,
	1
}
RTResTalkAction[109] = {
	1,
	107,
	nil,
	nil,
	2
}
RTResTalkAction[110] = {
	1,
	119,
	{
		2
	},
	nil,
	5
}
RTResTalkAction[111] = {
	[1] = 1,
	[2] = 128
}
RTResTalkAction[112] = {
	[1] = 1,
	[2] = 304
}
RTResTalkAction[113] = {
	[1] = 0,
	[2] = 304
}
RTResTalkAction[114] = {
	1,
	107,
	nil,
	nil,
	1
}
RTResTalkAction[115] = {
	[1] = 1,
	[2] = 679,
	[3] = {
		3
	}
}
RTResTalkAction[116] = {
	1,
	119,
	{
		1
	},
	nil,
	4
}
RTResTalkAction[117] = {
	[1] = 1,
	[2] = 627
}
RTResTalkAction[118] = {
	[1] = 2,
	[2] = 627
}
RTResTalkAction[119] = {
	[1] = 3,
	[2] = 548
}
RTResTalkAction[120] = {
	[1] = 0,
	[2] = 548
}

local Data = {
	[9840001] = {
		9840001,
		0,
		Lang.get(36074),
		9840,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		6,
		9710,
		2,
		nil,
		nil,
		nil,
		9710
	},
	[9840002] = {
		9840002,
		0,
		Lang.get(36075),
		9840,
		2,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[9840003] = {
		9840003,
		0,
		Lang.get(35619),
		9840,
		3,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[9840004] = {
		9840004,
		13,
		nil,
		9840,
		4,
		300,
		{
			RTResTalkAction[3]
		},
		[19] = 220,
		[26] = 2
	},
	[9840005] = {
		9840005,
		13,
		Lang.get(32506),
		9840,
		5,
		360,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		},
		[26] = 3
	},
	[9840006] = {
		9840006,
		0,
		Lang.get(36076),
		9840,
		6,
		361,
		{
			RTResTalkAction[4]
		},
		1,
		[26] = 3
	},
	[9840007] = {
		9840007,
		0,
		Lang.get(35621),
		9840,
		7,
		300,
		{
			RTResTalkAction[6]
		},
		[26] = 3
	},
	[9840008] = {
		9840008,
		4,
		nil,
		9840,
		8,
		300,
		{
			RTResTalkAction[4]
		},
		[26] = 3,
		[27] = {
			{
				id = 9840009,
				branch_content = Lang.get(42520)
			}
		}
	},
	[9840009] = {
		9840009,
		13,
		Lang.get(35623),
		9840,
		9,
		360,
		{
			RTResTalkAction[4]
		},
		[26] = 3
	},
	[9840010] = {
		9840010,
		0,
		Lang.get(35624),
		9840,
		10,
		300,
		{
			RTResTalkAction[4]
		},
		[26] = 3
	},
	[9840011] = {
		9840011,
		4,
		nil,
		9840,
		11,
		300,
		{
			RTResTalkAction[4]
		},
		[26] = 3,
		[27] = {
			{
				id = 9840012,
				branch_content = Lang.get(42504)
			}
		}
	},
	[9840012] = {
		9840012,
		13,
		Lang.get(35626),
		9840,
		12,
		360,
		{
			RTResTalkAction[4]
		},
		[26] = 4
	},
	[9840013] = {
		9840013,
		0,
		Lang.get(44396),
		9840,
		13,
		107,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		},
		[19] = -1
	},
	[9840014] = {
		9840014,
		0,
		Lang.get(44397),
		9840,
		14,
		133,
		{
			RTResTalkAction[9],
			RTResTalkAction[2]
		}
	},
	[9840015] = {
		9840015,
		0,
		Lang.get(44398),
		9840,
		15,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[9840016] = {
		9840016,
		0,
		Lang.get(35632),
		9840,
		16,
		107,
		{
			RTResTalkAction[1]
		}
	},
	[9840017] = {
		9840017,
		0,
		Lang.get(44399),
		9840,
		17,
		141,
		{
			RTResTalkAction[11],
			RTResTalkAction[2]
		}
	},
	[9840018] = {
		9840018,
		0,
		Lang.get(44400),
		9840,
		18,
		133,
		{
			RTResTalkAction[12],
			RTResTalkAction[13]
		}
	},
	[9840019] = {
		9840019,
		0,
		Lang.get(44401),
		9840,
		19,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[9710001] = {
		9710001,
		0,
		Lang.get(35633),
		9710,
		1,
		677,
		nil,
		1,
		0,
		nil,
		nil,
		63,
		9715,
		1,
		1,
		1,
		nil,
		9715
	},
	[9710002] = {
		9710002,
		0,
		Lang.get(35634),
		9710,
		2,
		188,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		9716,
		nil,
		nil,
		1,
		nil,
		9716
	},
	[9710003] = {
		9710003,
		0,
		Lang.get(35635),
		9710,
		3,
		677,
		nil,
		1,
		0
	},
	[9710004] = {
		9710004,
		0,
		Lang.get(35636),
		9710,
		4,
		350,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		9717,
		nil,
		nil,
		1,
		nil,
		9717
	},
	[9710005] = {
		9710005,
		0,
		Lang.get(35637),
		9710,
		5,
		188,
		nil,
		1,
		0
	},
	[9710006] = {
		9710006,
		0,
		Lang.get(36085),
		9710,
		6,
		350,
		nil,
		1,
		0
	},
	[9710007] = {
		9710007,
		0,
		Lang.get(44402),
		9710,
		7,
		112,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		9718,
		nil,
		nil,
		1,
		nil,
		9718
	},
	[9710008] = {
		9710008,
		0,
		Lang.get(46240),
		9710,
		8,
		148,
		nil,
		1,
		0
	},
	[9860001] = {
		9860001,
		0,
		Lang.get(35640),
		9860,
		1,
		119,
		nil,
		1,
		4,
		nil,
		nil,
		62,
		9713,
		1,
		1,
		1,
		nil,
		9713
	},
	[9860002] = {
		9860002,
		0,
		Lang.get(44403),
		9860,
		2,
		119,
		nil,
		1,
		3
	},
	[9860003] = {
		9860003,
		0,
		Lang.get(44404),
		9860,
		3,
		119,
		nil,
		1
	},
	[9860004] = {
		9860004,
		0,
		Lang.get(44405),
		9860,
		4,
		119,
		nil,
		1,
		0
	},
	[9860005] = {
		9860005,
		0,
		Lang.get(35645),
		9860,
		5,
		119,
		nil,
		1,
		0,
		nil,
		nil,
		40,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		255
	},
	[9860006] = {
		9860006,
		0,
		Lang.get(35650),
		9860,
		6,
		676,
		nil,
		1
	},
	[9860007] = {
		9860007,
		0,
		Lang.get(35651),
		9860,
		7,
		119,
		nil,
		1,
		0
	},
	[9860008] = {
		9860008,
		0,
		Lang.get(35652),
		9860,
		8,
		119,
		nil,
		1
	},
	[9860009] = {
		9860009,
		0,
		Lang.get(35653),
		9860,
		9,
		676,
		nil,
		1,
		0
	},
	[9860010] = {
		9860010,
		0,
		Lang.get(35654),
		9860,
		10,
		119,
		nil,
		1
	},
	[9860011] = {
		9860011,
		0,
		Lang.get(35655),
		9860,
		11,
		676,
		{
			RTResTalkAction[14]
		}
	},
	[9860012] = {
		9860012,
		0,
		Lang.get(35656),
		9860,
		12,
		119,
		{
			RTResTalkAction[15]
		},
		1,
		7,
		nil,
		nil,
		62,
		9714,
		1,
		1,
		1,
		nil,
		9714,
		-1
	},
	[9860013] = {
		9860013,
		0,
		Lang.get(35657),
		9860,
		13,
		119,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		3
	},
	[9860014] = {
		9860014,
		0,
		Lang.get(35658),
		9860,
		14,
		676,
		{
			RTResTalkAction[17],
			RTResTalkAction[18]
		}
	},
	[9860015] = {
		9860015,
		0,
		Lang.get(35659),
		9860,
		15,
		119,
		{
			RTResTalkAction[19],
			RTResTalkAction[18]
		}
	},
	[9860016] = {
		9860016,
		0,
		Lang.get(35660),
		9860,
		16,
		676,
		{
			RTResTalkAction[17],
			RTResTalkAction[18]
		}
	},
	[9860017] = {
		9860017,
		0,
		Lang.get(35661),
		9860,
		17,
		119,
		{
			RTResTalkAction[20],
			RTResTalkAction[18]
		}
	},
	[9860018] = {
		9860018,
		0,
		Lang.get(35662),
		9860,
		18,
		676,
		{
			RTResTalkAction[17],
			RTResTalkAction[18]
		}
	},
	[9860019] = {
		9860019,
		0,
		Lang.get(35663),
		9860,
		19,
		119,
		{
			RTResTalkAction[21],
			RTResTalkAction[18]
		}
	},
	[9860020] = {
		9860020,
		0,
		Lang.get(35664),
		9860,
		20,
		119,
		{
			RTResTalkAction[17],
			RTResTalkAction[18]
		}
	},
	[9860021] = {
		9860021,
		0,
		Lang.get(35665),
		9860,
		21,
		676,
		{
			RTResTalkAction[17],
			RTResTalkAction[18]
		}
	},
	[9870001] = {
		9870001,
		9,
		Lang.get(35666),
		9870,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		6,
		9711,
		nil,
		1,
		1,
		nil,
		9711,
		nil,
		nil,
		1
	},
	[9870002] = {
		9870002,
		0,
		Lang.get(35667),
		9870,
		2,
		107,
		{
			RTResTalkAction[22]
		},
		nil,
		nil,
		3
	},
	[9870003] = {
		9870003,
		0,
		Lang.get(35668),
		9870,
		3,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[9870004] = {
		9870004,
		0,
		Lang.get(35669),
		9870,
		4,
		141,
		{
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[9870005] = {
		9870005,
		9,
		Lang.get(35670),
		9870,
		5,
		605,
		{
			RTResTalkAction[25],
			RTResTalkAction[2],
			RTResTalkAction[13]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		0.3,
		1,
		[21] = 1,
		[20] = 303
	},
	[9870006] = {
		9870006,
		0,
		Lang.get(35671),
		9870,
		6,
		107,
		{
			RTResTalkAction[25]
		},
		1,
		0,
		[20] = 303
	},
	[9870007] = {
		9870007,
		9,
		Lang.get(35672),
		9870,
		7,
		107,
		{
			RTResTalkAction[25]
		},
		[21] = 1,
		[20] = 303
	},
	[9870008] = {
		9870008,
		9,
		Lang.get(36081),
		9870,
		8,
		107,
		{
			RTResTalkAction[25]
		},
		[21] = 1,
		[20] = 303
	},
	[9870009] = {
		9870009,
		9,
		Lang.get(36082),
		9870,
		9,
		107,
		{
			RTResTalkAction[25]
		},
		[21] = 1,
		[20] = 303
	},
	[9870010] = {
		9870010,
		9,
		Lang.get(36083),
		9870,
		10,
		107,
		{
			RTResTalkAction[25]
		},
		[21] = 1,
		[20] = 303
	},
	[9870011] = {
		9870011,
		0,
		Lang.get(35676),
		9870,
		11,
		300,
		{
			RTResTalkAction[26]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		9712,
		nil,
		1,
		[18] = 9712
	},
	[9870012] = {
		9870012,
		0,
		Lang.get(35677),
		9870,
		12,
		141,
		{
			RTResTalkAction[23],
			RTResTalkAction[24]
		},
		nil,
		nil,
		3
	},
	[9870013] = {
		9870013,
		0,
		Lang.get(35678),
		9870,
		13,
		107,
		{
			RTResTalkAction[27],
			RTResTalkAction[24]
		}
	},
	[9870014] = {
		9870014,
		0,
		Lang.get(35679),
		9870,
		14,
		133,
		{
			RTResTalkAction[28],
			RTResTalkAction[2],
			RTResTalkAction[13]
		}
	},
	[9870015] = {
		9870015,
		0,
		Lang.get(44406),
		9870,
		15,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[9870016] = {
		9870016,
		0,
		Lang.get(35682),
		9870,
		16,
		133,
		{
			RTResTalkAction[12]
		}
	},
	[9870017] = {
		9870017,
		0,
		Lang.get(35683),
		9870,
		17,
		133,
		{
			RTResTalkAction[12]
		}
	},
	[9870018] = {
		9870018,
		0,
		Lang.get(35684),
		9870,
		18,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[9870019] = {
		9870019,
		0,
		Lang.get(44407),
		9870,
		19,
		107,
		{
			RTResTalkAction[29]
		}
	},
	[9870020] = {
		9870020,
		0,
		Lang.get(44408),
		9870,
		20,
		133,
		{
			RTResTalkAction[12],
			RTResTalkAction[2]
		}
	},
	[9720001] = {
		9720001,
		0,
		Lang.get(35685),
		9720,
		1,
		107,
		nil,
		1,
		7,
		nil,
		nil,
		6,
		nil,
		1,
		1,
		1,
		nil,
		9720
	},
	[9720002] = {
		9720002,
		0,
		Lang.get(35686),
		9720,
		2,
		141,
		nil,
		1,
		1
	},
	[9720003] = {
		9720003,
		0,
		Lang.get(35687),
		9720,
		3,
		107,
		nil,
		1,
		5
	},
	[9720004] = {
		9720004,
		0,
		Lang.get(35688),
		9720,
		4,
		300
	},
	[9720005] = {
		9720005,
		0,
		Lang.get(44409),
		9720,
		5,
		107,
		nil,
		1,
		6
	},
	[9720006] = {
		9720006,
		0,
		Lang.get(35690),
		9720,
		6,
		300
	},
	[9720007] = {
		9720007,
		0,
		Lang.get(35691),
		9720,
		7,
		141,
		nil,
		1,
		1
	},
	[9720008] = {
		9720008,
		0,
		Lang.get(35692),
		9720,
		8,
		141,
		nil,
		1,
		0
	},
	[9720009] = {
		9720009,
		0,
		Lang.get(35693),
		9720,
		9,
		300
	},
	[9720010] = {
		9720010,
		0,
		Lang.get(35694),
		9720,
		10,
		107,
		nil,
		1,
		7
	},
	[9720011] = {
		9720011,
		0,
		Lang.get(44410),
		9720,
		11,
		141,
		nil,
		1,
		0
	},
	[9720012] = {
		9720012,
		5,
		Lang.get(35697),
		9720,
		12,
		119,
		nil,
		1,
		3
	},
	[9720013] = {
		9720013,
		0,
		Lang.get(35696),
		9720,
		13,
		107,
		nil,
		1,
		0
	},
	[9720014] = {
		9720014,
		0,
		Lang.get(44411),
		9720,
		14,
		133,
		nil,
		1,
		0
	},
	[9720015] = {
		9720015,
		0,
		Lang.get(44412),
		9720,
		15,
		107,
		nil,
		1,
		0
	},
	[9720016] = {
		9720016,
		5,
		Lang.get(35698),
		9720,
		16,
		119,
		nil,
		1,
		5,
		nil,
		nil,
		60,
		9721,
		1,
		1,
		1,
		nil,
		9721
	},
	[9720017] = {
		9720017,
		0,
		Lang.get(35699),
		9720,
		17,
		119,
		{
			RTResTalkAction[30]
		},
		nil,
		nil,
		3
	},
	[9720018] = {
		9720018,
		0,
		Lang.get(35700),
		9720,
		18,
		119,
		{
			RTResTalkAction[31]
		}
	},
	[9720019] = {
		9720019,
		0,
		Lang.get(35701),
		9720,
		19,
		673,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[9720020] = {
		9720020,
		0,
		Lang.get(35702),
		9720,
		20,
		674,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[9720021] = {
		9720021,
		0,
		Lang.get(35703),
		9720,
		21,
		678,
		{
			RTResTalkAction[36],
			RTResTalkAction[37],
			RTResTalkAction[38]
		}
	},
	[9720022] = {
		9720022,
		0,
		Lang.get(35704),
		9720,
		22,
		119,
		{
			RTResTalkAction[39],
			RTResTalkAction[40]
		}
	},
	[9720023] = {
		9720023,
		0,
		Lang.get(35705),
		9720,
		23,
		119,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[9720024] = {
		9720024,
		0,
		Lang.get(35706),
		9720,
		24,
		119,
		{
			RTResTalkAction[31]
		}
	},
	[9720025] = {
		9720025,
		0,
		Lang.get(36086),
		9720,
		25,
		119,
		{
			RTResTalkAction[16]
		}
	},
	[9720026] = {
		9720026,
		0,
		Lang.get(36087),
		9720,
		26,
		673,
		{
			RTResTalkAction[34],
			RTResTalkAction[35],
			RTResTalkAction[33]
		}
	},
	[9720027] = {
		9720027,
		0,
		Lang.get(36088),
		9720,
		27,
		673,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[9720028] = {
		9720028,
		0,
		Lang.get(36089),
		9720,
		28,
		674,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[9720029] = {
		9720029,
		0,
		Lang.get(35711),
		9720,
		29,
		678,
		{
			RTResTalkAction[17],
			RTResTalkAction[40],
			RTResTalkAction[37],
			RTResTalkAction[38]
		}
	},
	[9720030] = {
		9720030,
		0,
		Lang.get(35712),
		9720,
		30,
		119,
		{
			RTResTalkAction[43],
			RTResTalkAction[40]
		}
	},
	[9720031] = {
		9720031,
		0,
		Lang.get(44413),
		9720,
		31,
		673,
		{
			RTResTalkAction[34],
			RTResTalkAction[35],
			RTResTalkAction[33],
			RTResTalkAction[42]
		}
	},
	[9720032] = {
		9720032,
		0,
		Lang.get(35714),
		9720,
		32,
		674,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[9720033] = {
		9720033,
		0,
		Lang.get(35715),
		9720,
		33,
		678,
		{
			RTResTalkAction[17],
			RTResTalkAction[40],
			RTResTalkAction[37],
			RTResTalkAction[38]
		}
	},
	[9720034] = {
		9720034,
		0,
		"……",
		9720,
		34,
		119,
		{
			RTResTalkAction[44],
			RTResTalkAction[40]
		}
	},
	[9720035] = {
		9720035,
		0,
		Lang.get(35716),
		9720,
		35,
		119,
		{
			RTResTalkAction[45],
			RTResTalkAction[42]
		}
	},
	[9720036] = {
		9720036,
		0,
		Lang.get(36090),
		9720,
		36,
		673,
		{
			RTResTalkAction[34],
			RTResTalkAction[35],
			RTResTalkAction[33]
		}
	},
	[9720037] = {
		9720037,
		0,
		Lang.get(35718),
		9720,
		37,
		674,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[9720038] = {
		9720038,
		0,
		Lang.get(35719),
		9720,
		38,
		119,
		{
			RTResTalkAction[41],
			RTResTalkAction[37],
			RTResTalkAction[38]
		}
	},
	[9720039] = {
		9720039,
		0,
		Lang.get(35720),
		9720,
		39,
		107,
		{
			RTResTalkAction[46],
			RTResTalkAction[33]
		}
	},
	[9730001] = {
		9730001,
		0,
		Lang.get(44414),
		9730,
		1,
		107,
		nil,
		1,
		2,
		nil,
		nil,
		60,
		9730,
		2,
		1,
		1,
		nil,
		9730
	},
	[9730002] = {
		9730002,
		0,
		Lang.get(35723),
		9730,
		2,
		141,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		9731,
		nil,
		nil,
		nil,
		nil,
		9731
	},
	[9730003] = {
		9730003,
		0,
		Lang.get(35724),
		9730,
		3,
		119,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		3
	},
	[9730004] = {
		9730004,
		0,
		Lang.get(35725),
		9730,
		4,
		107,
		{
			RTResTalkAction[47],
			RTResTalkAction[33]
		}
	},
	[9730005] = {
		9730005,
		0,
		Lang.get(44415),
		9730,
		5,
		119,
		{
			RTResTalkAction[31],
			RTResTalkAction[2]
		}
	},
	[9730006] = {
		9730006,
		0,
		Lang.get(35728),
		9730,
		6,
		141,
		{
			RTResTalkAction[11],
			RTResTalkAction[33]
		}
	},
	[9730007] = {
		9730007,
		0,
		Lang.get(44416),
		9730,
		7,
		119,
		{
			RTResTalkAction[41],
			RTResTalkAction[13]
		}
	},
	[9730008] = {
		9730008,
		0,
		Lang.get(35731),
		9730,
		8,
		119,
		{
			RTResTalkAction[31]
		}
	},
	[9730009] = {
		9730009,
		0,
		Lang.get(35732),
		9730,
		9,
		107,
		{
			RTResTalkAction[48],
			RTResTalkAction[33]
		}
	},
	[9730010] = {
		9730010,
		0,
		Lang.get(35733),
		9730,
		10,
		673,
		{
			RTResTalkAction[32],
			RTResTalkAction[2]
		}
	},
	[9730011] = {
		9730011,
		0,
		Lang.get(36091),
		9730,
		11,
		674,
		{
			RTResTalkAction[49],
			RTResTalkAction[37]
		}
	},
	[9730012] = {
		9730012,
		0,
		Lang.get(36092),
		9730,
		12,
		107,
		{
			RTResTalkAction[50],
			RTResTalkAction[38]
		}
	},
	[9730013] = {
		9730013,
		0,
		Lang.get(35736),
		9730,
		13,
		119,
		{
			RTResTalkAction[16],
			RTResTalkAction[2]
		}
	},
	[9730014] = {
		9730014,
		0,
		Lang.get(36093),
		9730,
		14,
		678,
		{
			RTResTalkAction[51],
			RTResTalkAction[33]
		}
	},
	[9730015] = {
		9730015,
		0,
		Lang.get(35738),
		9730,
		15,
		107,
		{
			RTResTalkAction[52],
			RTResTalkAction[42]
		}
	},
	[9730016] = {
		9730016,
		0,
		Lang.get(35739),
		9730,
		16,
		673,
		{
			RTResTalkAction[32],
			RTResTalkAction[2]
		}
	},
	[9730017] = {
		9730017,
		0,
		Lang.get(35740),
		9730,
		17,
		119,
		{
			RTResTalkAction[41],
			RTResTalkAction[37]
		}
	},
	[9730018] = {
		9730018,
		0,
		Lang.get(44417),
		9730,
		18,
		107,
		{
			RTResTalkAction[33]
		},
		1,
		6,
		nil,
		nil,
		62,
		9732,
		1,
		1,
		1,
		nil,
		9732
	},
	[9730019] = {
		9730019,
		0,
		Lang.get(44418),
		9730,
		19,
		300
	},
	[9730020] = {
		9730020,
		0,
		Lang.get(44419),
		9730,
		20,
		107,
		nil,
		1
	},
	[9730021] = {
		9730021,
		0,
		Lang.get(35743),
		9730,
		21,
		119,
		{
			RTResTalkAction[53]
		},
		nil,
		nil,
		3
	},
	[9730022] = {
		9730022,
		0,
		Lang.get(35744),
		9730,
		22,
		107,
		{
			RTResTalkAction[54],
			RTResTalkAction[33]
		}
	},
	[9730023] = {
		9730023,
		0,
		Lang.get(35745),
		9730,
		23,
		119,
		{
			RTResTalkAction[31],
			RTResTalkAction[2]
		}
	},
	[9730024] = {
		9730024,
		0,
		Lang.get(44420),
		9730,
		24,
		119,
		{
			RTResTalkAction[55]
		}
	},
	[9730025] = {
		9730025,
		0,
		Lang.get(35748),
		9730,
		25,
		107,
		{
			RTResTalkAction[22],
			RTResTalkAction[33]
		}
	},
	[9730026] = {
		9730026,
		0,
		Lang.get(35749),
		9730,
		26,
		119,
		{
			RTResTalkAction[56],
			RTResTalkAction[2]
		}
	},
	[9730027] = {
		9730027,
		0,
		Lang.get(35750),
		9730,
		27,
		119,
		{
			RTResTalkAction[31]
		}
	},
	[9730028] = {
		9730028,
		0,
		Lang.get(35751),
		9730,
		28,
		107,
		{
			RTResTalkAction[22],
			RTResTalkAction[33]
		}
	},
	[9730029] = {
		9730029,
		0,
		Lang.get(35752),
		9730,
		29,
		141,
		{
			RTResTalkAction[11],
			RTResTalkAction[2]
		}
	},
	[9730030] = {
		9730030,
		0,
		Lang.get(44421),
		9730,
		30,
		119,
		{
			RTResTalkAction[31],
			RTResTalkAction[13]
		}
	},
	[9730031] = {
		9730031,
		0,
		Lang.get(44422),
		9730,
		31,
		119,
		{
			RTResTalkAction[31]
		}
	},
	[9730032] = {
		9730032,
		0,
		Lang.get(36095),
		9730,
		32,
		119,
		{
			RTResTalkAction[57]
		}
	},
	[9730033] = {
		9730033,
		0,
		Lang.get(35756),
		9730,
		33,
		107,
		{
			RTResTalkAction[22],
			RTResTalkAction[33]
		}
	},
	[9730034] = {
		9730034,
		0,
		Lang.get(36096),
		9730,
		34,
		119,
		{
			RTResTalkAction[31],
			RTResTalkAction[2]
		}
	},
	[9730035] = {
		9730035,
		0,
		Lang.get(35758),
		9730,
		35,
		107,
		{
			RTResTalkAction[58],
			RTResTalkAction[33]
		}
	},
	[9730036] = {
		9730036,
		0,
		Lang.get(35759),
		9730,
		36,
		300,
		{
			RTResTalkAction[22]
		}
	},
	[9730037] = {
		9730037,
		0,
		Lang.get(35760),
		9730,
		37,
		107,
		{
			RTResTalkAction[59]
		}
	},
	[9730038] = {
		9730038,
		0,
		Lang.get(35761),
		9730,
		38,
		107,
		{
			RTResTalkAction[60]
		}
	},
	[9730039] = {
		9730039,
		0,
		Lang.get(35762),
		9730,
		39,
		300,
		{
			RTResTalkAction[22]
		}
	},
	[9730040] = {
		9730040,
		0,
		Lang.get(36097),
		9730,
		40,
		119,
		{
			RTResTalkAction[61],
			RTResTalkAction[2]
		}
	},
	[9740001] = {
		9740001,
		0,
		Lang.get(35764),
		9740,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		9740,
		1,
		1,
		1,
		nil,
		9740
	},
	[9740002] = {
		9740002,
		0,
		Lang.get(36098),
		9740,
		2,
		300
	},
	[9740003] = {
		9740003,
		0,
		Lang.get(35766),
		9740,
		3,
		107,
		{
			RTResTalkAction[62]
		},
		nil,
		nil,
		3
	},
	[9740004] = {
		9740004,
		0,
		Lang.get(35767),
		9740,
		4,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[9740005] = {
		9740005,
		0,
		Lang.get(35768),
		9740,
		5,
		107,
		{
			RTResTalkAction[54]
		}
	},
	[9740006] = {
		9740006,
		0,
		Lang.get(35769),
		9740,
		6,
		141,
		{
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[9740007] = {
		9740007,
		0,
		Lang.get(44423),
		9740,
		7,
		107,
		{
			RTResTalkAction[63],
			RTResTalkAction[24]
		}
	},
	[9740008] = {
		9740008,
		0,
		Lang.get(44424),
		9740,
		8,
		300,
		{
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[9740009] = {
		9740009,
		0,
		Lang.get(44425),
		9740,
		9,
		107,
		{
			RTResTalkAction[64],
			RTResTalkAction[24]
		}
	},
	[9740010] = {
		9740010,
		0,
		Lang.get(35776),
		9740,
		10,
		300,
		{
			RTResTalkAction[2],
			RTResTalkAction[13]
		},
		nil,
		nil,
		nil,
		nil,
		9,
		nil,
		0.5,
		1,
		1,
		nil,
		9741
	},
	[9740011] = {
		9740011,
		0,
		Lang.get(44426),
		9740,
		11,
		107,
		nil,
		1
	},
	[9740012] = {
		9740012,
		0,
		Lang.get(35779),
		9740,
		12,
		141,
		nil,
		1
	},
	[9740013] = {
		9740013,
		0,
		Lang.get(35780),
		9740,
		13,
		141,
		nil,
		1
	},
	[9740014] = {
		9740014,
		0,
		Lang.get(35781),
		9740,
		14,
		141,
		nil,
		1
	},
	[9740015] = {
		9740015,
		0,
		Lang.get(35782),
		9740,
		15,
		107,
		nil,
		1,
		6
	},
	[9740016] = {
		9740016,
		0,
		Lang.get(35783),
		9740,
		16,
		141,
		nil,
		1,
		0
	},
	[9740017] = {
		9740017,
		0,
		Lang.get(35784),
		9740,
		17,
		107,
		nil,
		1,
		5
	},
	[9740018] = {
		9740018,
		0,
		Lang.get(35785),
		9740,
		18,
		133,
		nil,
		1,
		0
	},
	[9740019] = {
		9740019,
		0,
		Lang.get(44427),
		9740,
		19,
		107,
		nil,
		1
	},
	[9740020] = {
		9740020,
		0,
		Lang.get(35789),
		9740,
		20,
		141,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		9742,
		0.5,
		1,
		1,
		nil,
		9742
	},
	[9740021] = {
		9740021,
		0,
		Lang.get(35790),
		9740,
		21,
		107,
		{
			RTResTalkAction[65]
		},
		nil,
		nil,
		3
	},
	[9740022] = {
		9740022,
		0,
		Lang.get(35791),
		9740,
		22,
		141,
		{
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[9740023] = {
		9740023,
		0,
		Lang.get(35792),
		9740,
		23,
		107,
		{
			RTResTalkAction[66],
			RTResTalkAction[24]
		}
	},
	[9740024] = {
		9740024,
		0,
		Lang.get(35793),
		9740,
		24,
		141,
		{
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[9740025] = {
		9740025,
		0,
		Lang.get(35794),
		9740,
		25,
		107,
		{
			RTResTalkAction[64],
			RTResTalkAction[24]
		}
	},
	[9740026] = {
		9740026,
		0,
		Lang.get(35795),
		9740,
		26,
		133,
		{
			RTResTalkAction[12],
			RTResTalkAction[2],
			RTResTalkAction[13]
		}
	},
	[9740027] = {
		9740027,
		0,
		Lang.get(35796),
		9740,
		27,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[9740028] = {
		9740028,
		0,
		Lang.get(35797),
		9740,
		28,
		107,
		{
			RTResTalkAction[52]
		}
	},
	[9750001] = {
		9750001,
		0,
		Lang.get(44428),
		9750,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		9750,
		1.5,
		1,
		1,
		nil,
		9750
	},
	[9750002] = {
		9750002,
		0,
		Lang.get(35801),
		9750,
		2,
		141,
		nil,
		1
	},
	[9750003] = {
		9750003,
		0,
		Lang.get(35802),
		9750,
		3,
		133,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		3
	},
	[9750004] = {
		9750004,
		0,
		Lang.get(44429),
		9750,
		4,
		107,
		{
			RTResTalkAction[67],
			RTResTalkAction[24],
			RTResTalkAction[10]
		}
	},
	[9750005] = {
		9750005,
		0,
		Lang.get(36104),
		9750,
		5,
		141,
		{
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[9750006] = {
		9750006,
		0,
		Lang.get(36105),
		9750,
		6,
		107,
		{
			RTResTalkAction[68],
			RTResTalkAction[24]
		}
	},
	[9750007] = {
		9750007,
		0,
		Lang.get(35807),
		9750,
		7,
		141,
		{
			RTResTalkAction[23],
			RTResTalkAction[69]
		}
	},
	[9750008] = {
		9750008,
		0,
		Lang.get(44430),
		9750,
		8,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[13]
		},
		1,
		1,
		nil,
		nil,
		63,
		9751,
		1,
		1,
		1,
		nil,
		9751
	},
	[9750009] = {
		9750009,
		0,
		Lang.get(36107),
		9750,
		9,
		141,
		nil,
		1,
		3
	},
	[9750010] = {
		9750010,
		0,
		Lang.get(44431),
		9750,
		10,
		141,
		nil,
		1,
		0
	},
	[9750011] = {
		9750011,
		0,
		Lang.get(36109),
		9750,
		11,
		133,
		nil,
		1
	},
	[9750012] = {
		9750012,
		0,
		Lang.get(35814),
		9750,
		12,
		133,
		{
			RTResTalkAction[70]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		9752,
		0.5,
		1,
		1,
		nil,
		9752
	},
	[9750013] = {
		9750013,
		0,
		Lang.get(44432),
		9750,
		13,
		107,
		{
			RTResTalkAction[71],
			RTResTalkAction[10]
		}
	},
	[9750014] = {
		9750014,
		0,
		Lang.get(35817),
		9750,
		14,
		141,
		{
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[9750015] = {
		9750015,
		0,
		Lang.get(35818),
		9750,
		15,
		300,
		{
			RTResTalkAction[2],
			RTResTalkAction[13]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		9753,
		1,
		1,
		1,
		nil,
		9753
	},
	[9750016] = {
		9750016,
		0,
		Lang.get(35819),
		9750,
		16,
		107,
		{
			RTResTalkAction[71]
		},
		nil,
		nil,
		3
	},
	[9750017] = {
		9750017,
		0,
		Lang.get(44433),
		9750,
		17,
		300,
		{
			RTResTalkAction[22]
		}
	},
	[9750018] = {
		9750018,
		0,
		Lang.get(44434),
		9750,
		18,
		107,
		{
			RTResTalkAction[29]
		}
	},
	[9750019] = {
		9750019,
		0,
		Lang.get(35825),
		9750,
		19,
		300,
		{
			RTResTalkAction[22]
		}
	},
	[9750020] = {
		9750020,
		0,
		Lang.get(35826),
		9750,
		20,
		107,
		{
			RTResTalkAction[71]
		}
	},
	[9750021] = {
		9750021,
		11,
		"Videos/AVG_equiptower.mp4",
		9750,
		21,
		nil,
		{
			RTResTalkAction[2]
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
	[9760001] = {
		9760001,
		0,
		Lang.get(35827),
		9760,
		1,
		107,
		nil,
		1,
		8,
		nil,
		nil,
		63,
		9760,
		1,
		1,
		1,
		nil,
		9760
	},
	[9760002] = {
		9760002,
		0,
		Lang.get(35828),
		9760,
		2,
		141,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3
	},
	[9760003] = {
		9760003,
		0,
		Lang.get(35829),
		9760,
		3,
		107,
		{
			RTResTalkAction[27],
			RTResTalkAction[24]
		}
	},
	[9760004] = {
		9760004,
		0,
		Lang.get(36112),
		9760,
		4,
		107,
		{
			RTResTalkAction[72],
			RTResTalkAction[24]
		}
	},
	[9760005] = {
		9760005,
		0,
		Lang.get(35831),
		9760,
		5,
		141,
		{
			RTResTalkAction[11],
			RTResTalkAction[2]
		}
	},
	[9760006] = {
		9760006,
		0,
		Lang.get(35832),
		9760,
		6,
		133,
		{
			RTResTalkAction[12],
			RTResTalkAction[13]
		}
	},
	[9760007] = {
		9760007,
		0,
		Lang.get(35833),
		9760,
		7,
		300,
		{
			RTResTalkAction[73],
			RTResTalkAction[12],
			RTResTalkAction[74]
		}
	},
	[9760008] = {
		9760008,
		0,
		Lang.get(35834),
		9760,
		8,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[10],
			RTResTalkAction[13]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		9761,
		1,
		1,
		1,
		nil,
		9761
	},
	[9760009] = {
		9760009,
		0,
		Lang.get(35835),
		9760,
		9,
		141,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3
	},
	[9760010] = {
		9760010,
		0,
		Lang.get(35836),
		9760,
		10,
		107,
		{
			RTResTalkAction[75],
			RTResTalkAction[24]
		}
	},
	[9760011] = {
		9760011,
		0,
		Lang.get(35837),
		9760,
		11,
		141,
		{
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[9760012] = {
		9760012,
		0,
		Lang.get(44435),
		9760,
		12,
		300,
		{
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[9760013] = {
		9760013,
		0,
		Lang.get(44436),
		9760,
		13,
		133,
		{
			RTResTalkAction[12],
			RTResTalkAction[2],
			RTResTalkAction[13]
		}
	},
	[9760014] = {
		9760014,
		0,
		Lang.get(35839),
		9760,
		14,
		107,
		{
			RTResTalkAction[60],
			RTResTalkAction[10]
		}
	},
	[9760015] = {
		9760015,
		0,
		Lang.get(35840),
		9760,
		15,
		679,
		{
			RTResTalkAction[23],
			RTResTalkAction[76]
		}
	},
	[9760016] = {
		9760016,
		0,
		Lang.get(35841),
		9760,
		16,
		107,
		{
			RTResTalkAction[71],
			RTResTalkAction[77]
		}
	},
	[9760017] = {
		9760017,
		0,
		Lang.get(35842),
		9760,
		17,
		141,
		{
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[9760018] = {
		9760018,
		0,
		Lang.get(44437),
		9760,
		18,
		679,
		{
			RTResTalkAction[78],
			RTResTalkAction[2],
			RTResTalkAction[13]
		}
	},
	[9760019] = {
		9760019,
		0,
		Lang.get(35845),
		9760,
		19,
		107,
		{
			RTResTalkAction[52],
			RTResTalkAction[77]
		}
	},
	[9760020] = {
		9760020,
		0,
		Lang.get(35846),
		9760,
		20,
		679,
		{
			RTResTalkAction[23],
			RTResTalkAction[76]
		}
	},
	[9760021] = {
		9760021,
		0,
		Lang.get(35847),
		9760,
		21,
		107,
		{
			RTResTalkAction[79],
			RTResTalkAction[76]
		}
	},
	[9760022] = {
		9760022,
		0,
		Lang.get(35848),
		9760,
		22,
		679,
		{
			RTResTalkAction[23],
			RTResTalkAction[76]
		}
	},
	[9760023] = {
		9760023,
		0,
		Lang.get(35849),
		9760,
		23,
		679,
		{
			RTResTalkAction[23],
			RTResTalkAction[76]
		}
	},
	[9760024] = {
		9760024,
		0,
		Lang.get(35850),
		9760,
		24,
		141,
		{
			RTResTalkAction[11],
			RTResTalkAction[2],
			RTResTalkAction[77]
		}
	},
	[9760025] = {
		9760025,
		0,
		Lang.get(44438),
		9760,
		25,
		679,
		{
			RTResTalkAction[80],
			RTResTalkAction[13]
		}
	},
	[9760026] = {
		9760026,
		0,
		Lang.get(44439),
		9760,
		26,
		679,
		{
			RTResTalkAction[80]
		}
	},
	[9760027] = {
		9760027,
		0,
		Lang.get(35855),
		9760,
		27,
		107,
		{
			RTResTalkAction[47],
			RTResTalkAction[77]
		}
	},
	[9760028] = {
		9760028,
		0,
		Lang.get(35856),
		9760,
		28,
		679,
		{
			RTResTalkAction[23],
			RTResTalkAction[76]
		}
	},
	[9760029] = {
		9760029,
		0,
		Lang.get(35857),
		9760,
		29,
		107,
		{
			RTResTalkAction[29],
			RTResTalkAction[77]
		}
	},
	[9760030] = {
		9760030,
		0,
		Lang.get(35858),
		9760,
		30,
		141,
		{
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[9760031] = {
		9760031,
		0,
		Lang.get(35859),
		9760,
		31,
		133,
		{
			RTResTalkAction[12],
			RTResTalkAction[2],
			RTResTalkAction[13]
		}
	},
	[9760032] = {
		9760032,
		0,
		Lang.get(35860),
		9760,
		32,
		107,
		{
			RTResTalkAction[68],
			RTResTalkAction[24],
			RTResTalkAction[10]
		}
	},
	[9760033] = {
		9760033,
		0,
		Lang.get(35861),
		9760,
		33,
		141,
		{
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[9760034] = {
		9760034,
		0,
		Lang.get(35862),
		9760,
		34,
		107,
		{
			RTResTalkAction[81],
			RTResTalkAction[24]
		}
	},
	[9760035] = {
		9760035,
		0,
		Lang.get(35863),
		9760,
		35,
		141,
		{
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[9760036] = {
		9760036,
		0,
		Lang.get(35864),
		9760,
		36,
		133,
		{
			RTResTalkAction[12],
			RTResTalkAction[2],
			RTResTalkAction[13]
		}
	},
	[9760037] = {
		9760037,
		0,
		Lang.get(35865),
		9760,
		37,
		141,
		{
			RTResTalkAction[23],
			RTResTalkAction[24],
			RTResTalkAction[10]
		}
	},
	[9760038] = {
		9760038,
		0,
		Lang.get(35866),
		9760,
		38,
		107,
		{
			RTResTalkAction[58],
			RTResTalkAction[13]
		}
	},
	[9770001] = {
		9770001,
		0,
		Lang.get(35867),
		9770,
		1,
		107,
		nil,
		1,
		5,
		nil,
		nil,
		63,
		nil,
		1,
		nil,
		1,
		nil,
		9770
	},
	[9770002] = {
		9770002,
		0,
		Lang.get(35868),
		9770,
		2,
		141,
		nil,
		1,
		0
	},
	[9770003] = {
		9770003,
		0,
		Lang.get(35869),
		9770,
		3,
		107,
		nil,
		1,
		7
	},
	[9770004] = {
		9770004,
		0,
		Lang.get(35870),
		9770,
		4,
		133,
		nil,
		1,
		0
	},
	[9770005] = {
		9770005,
		0,
		Lang.get(35871),
		9770,
		5,
		107,
		nil,
		1,
		3
	},
	[9770006] = {
		9770006,
		5,
		Lang.get(35872),
		9770,
		6,
		119,
		nil,
		1,
		0
	},
	[9770007] = {
		9770007,
		0,
		Lang.get(35873),
		9770,
		7,
		107,
		nil,
		1,
		0
	},
	[9770008] = {
		9770008,
		0,
		Lang.get(35874),
		9770,
		8,
		119,
		{
			RTResTalkAction[82]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		nil,
		nil,
		1,
		1,
		nil,
		9771
	},
	[9770009] = {
		9770009,
		0,
		Lang.get(35875),
		9770,
		9,
		119,
		{
			RTResTalkAction[31]
		}
	},
	[9770010] = {
		9770010,
		0,
		Lang.get(35876),
		9770,
		10,
		119,
		{
			RTResTalkAction[41]
		}
	},
	[9770011] = {
		9770011,
		0,
		Lang.get(35877),
		9770,
		11,
		128,
		{
			RTResTalkAction[17],
			RTResTalkAction[83]
		}
	},
	[9770012] = {
		9770012,
		7,
		"8",
		9770,
		12,
		128,
		{
			RTResTalkAction[33],
			RTResTalkAction[84]
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
	[9770013] = {
		9770013,
		0,
		Lang.get(35878),
		9770,
		13,
		119,
		{
			RTResTalkAction[85],
			RTResTalkAction[83]
		},
		nil,
		nil,
		3
	},
	[9770014] = {
		9770014,
		0,
		Lang.get(35879),
		9770,
		14,
		673,
		{
			RTResTalkAction[34],
			RTResTalkAction[35],
			RTResTalkAction[33],
			RTResTalkAction[84]
		}
	},
	[9770015] = {
		9770015,
		0,
		Lang.get(35880),
		9770,
		15,
		674,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[9770016] = {
		9770016,
		0,
		Lang.get(35881),
		9770,
		16,
		150,
		{
			RTResTalkAction[37],
			RTResTalkAction[38]
		},
		1
	},
	[9770017] = {
		9770017,
		7,
		"5",
		9770,
		17,
		150,
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
	[9770018] = {
		9770018,
		0,
		Lang.get(35882),
		9770,
		18,
		673,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		},
		nil,
		nil,
		3
	},
	[9770019] = {
		9770019,
		0,
		Lang.get(35883),
		9770,
		19,
		674,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[9770020] = {
		9770020,
		0,
		Lang.get(35884),
		9770,
		20,
		673,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[9770021] = {
		9770021,
		0,
		Lang.get(44440),
		9770,
		21,
		150,
		{
			RTResTalkAction[86],
			RTResTalkAction[37],
			RTResTalkAction[38]
		}
	},
	[9770022] = {
		9770022,
		0,
		Lang.get(35887),
		9770,
		22,
		150,
		{
			RTResTalkAction[87]
		}
	},
	[9770023] = {
		9770023,
		0,
		Lang.get(35888),
		9770,
		23,
		150,
		{
			RTResTalkAction[88]
		}
	},
	[9770024] = {
		9770024,
		0,
		Lang.get(44441),
		9770,
		24,
		150,
		{
			RTResTalkAction[88]
		}
	},
	[9770025] = {
		9770025,
		0,
		Lang.get(35891),
		9770,
		25,
		150,
		{
			RTResTalkAction[88]
		}
	},
	[9770026] = {
		9770026,
		0,
		Lang.get(35892),
		9770,
		26,
		150,
		{
			RTResTalkAction[89]
		}
	},
	[9770027] = {
		9770027,
		0,
		Lang.get(35893),
		9770,
		27,
		673,
		{
			RTResTalkAction[34],
			RTResTalkAction[35],
			RTResTalkAction[90]
		}
	},
	[9770028] = {
		9770028,
		0,
		Lang.get(35894),
		9770,
		28,
		674,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[9770029] = {
		9770029,
		0,
		Lang.get(35895),
		9770,
		29,
		150,
		{
			RTResTalkAction[91],
			RTResTalkAction[37],
			RTResTalkAction[38]
		}
	},
	[9770030] = {
		9770030,
		0,
		Lang.get(35896),
		9770,
		30,
		150,
		{
			RTResTalkAction[88]
		}
	},
	[9770031] = {
		9770031,
		0,
		Lang.get(44442),
		9770,
		31,
		119,
		{
			RTResTalkAction[92],
			RTResTalkAction[93]
		}
	},
	[9770032] = {
		9770032,
		0,
		Lang.get(44443),
		9770,
		32,
		673,
		{
			RTResTalkAction[34],
			RTResTalkAction[35],
			RTResTalkAction[90],
			RTResTalkAction[33]
		}
	},
	[9770033] = {
		9770033,
		0,
		Lang.get(35901),
		9770,
		33,
		119,
		{
			RTResTalkAction[82],
			RTResTalkAction[37],
			RTResTalkAction[38]
		}
	},
	[9770034] = {
		9770034,
		0,
		Lang.get(35902),
		9770,
		34,
		674,
		{
			RTResTalkAction[34],
			RTResTalkAction[35],
			RTResTalkAction[33]
		}
	},
	[9770035] = {
		9770035,
		0,
		Lang.get(44444),
		9770,
		35,
		128,
		{
			RTResTalkAction[94],
			RTResTalkAction[37],
			RTResTalkAction[38]
		}
	},
	[9770036] = {
		9770036,
		0,
		Lang.get(35905),
		9770,
		36,
		119,
		{
			RTResTalkAction[21],
			RTResTalkAction[83]
		}
	},
	[9770037] = {
		9770037,
		0,
		Lang.get(35906),
		9770,
		37,
		150,
		{
			RTResTalkAction[88],
			RTResTalkAction[33],
			RTResTalkAction[84]
		}
	},
	[9770038] = {
		9770038,
		0,
		Lang.get(35907),
		9770,
		38,
		119,
		{
			RTResTalkAction[92],
			RTResTalkAction[93]
		}
	},
	[9770039] = {
		9770039,
		0,
		Lang.get(35908),
		9770,
		39,
		150,
		{
			RTResTalkAction[95],
			RTResTalkAction[93]
		}
	},
	[9770040] = {
		9770040,
		0,
		Lang.get(35909),
		9770,
		40,
		119,
		{
			RTResTalkAction[96],
			RTResTalkAction[93]
		}
	},
	[9770041] = {
		9770041,
		0,
		Lang.get(44445),
		9770,
		41,
		150,
		{
			RTResTalkAction[92],
			RTResTalkAction[93]
		}
	},
	[9770042] = {
		9770042,
		0,
		Lang.get(35912),
		9770,
		42,
		150,
		{
			RTResTalkAction[92],
			RTResTalkAction[93]
		}
	},
	[9770043] = {
		9770043,
		0,
		Lang.get(44446),
		9770,
		43,
		150,
		{
			RTResTalkAction[92],
			RTResTalkAction[93]
		}
	},
	[9770044] = {
		9770044,
		0,
		Lang.get(35915),
		9770,
		44,
		150,
		{
			RTResTalkAction[97],
			RTResTalkAction[93]
		}
	},
	[9770045] = {
		9770045,
		0,
		Lang.get(35916),
		9770,
		45,
		119,
		{
			RTResTalkAction[98],
			RTResTalkAction[90]
		}
	},
	[9770046] = {
		9770046,
		0,
		Lang.get(35917),
		9770,
		46,
		107,
		{
			RTResTalkAction[47],
			RTResTalkAction[33]
		}
	},
	[9780001] = {
		9780001,
		0,
		Lang.get(44447),
		9780,
		1,
		119,
		nil,
		1,
		3,
		nil,
		nil,
		59,
		9780,
		1,
		1,
		1,
		nil,
		9780
	},
	[9780002] = {
		9780002,
		0,
		Lang.get(35920),
		9780,
		2,
		119,
		{
			RTResTalkAction[31]
		},
		nil,
		nil,
		3
	},
	[9780003] = {
		9780003,
		0,
		Lang.get(44448),
		9780,
		3,
		107,
		{
			RTResTalkAction[22],
			RTResTalkAction[33]
		}
	},
	[9780004] = {
		9780004,
		0,
		Lang.get(35923),
		9780,
		4,
		133,
		{
			RTResTalkAction[12],
			RTResTalkAction[2]
		}
	},
	[9780005] = {
		9780005,
		0,
		Lang.get(35924),
		9780,
		5,
		119,
		{
			RTResTalkAction[16],
			RTResTalkAction[10]
		}
	},
	[9780006] = {
		9780006,
		0,
		Lang.get(35925),
		9780,
		6,
		141,
		{
			RTResTalkAction[11],
			RTResTalkAction[33]
		}
	},
	[9780007] = {
		9780007,
		0,
		Lang.get(44449),
		9780,
		7,
		107,
		{
			RTResTalkAction[99],
			RTResTalkAction[24]
		}
	},
	[9780008] = {
		9780008,
		0,
		Lang.get(35928),
		9780,
		8,
		119,
		{
			RTResTalkAction[57],
			RTResTalkAction[2],
			RTResTalkAction[13]
		}
	},
	[9780009] = {
		9780009,
		0,
		Lang.get(35929),
		9780,
		9,
		128,
		{
			RTResTalkAction[17],
			RTResTalkAction[83]
		}
	},
	[9780010] = {
		9780010,
		0,
		Lang.get(35930),
		9780,
		10,
		119,
		{
			RTResTalkAction[100],
			RTResTalkAction[83]
		}
	},
	[9780011] = {
		9780011,
		0,
		Lang.get(35931),
		9780,
		11,
		128,
		{
			RTResTalkAction[17],
			RTResTalkAction[83]
		}
	},
	[9780012] = {
		9780012,
		0,
		Lang.get(35932),
		9780,
		12,
		119,
		{
			RTResTalkAction[39],
			RTResTalkAction[83]
		}
	},
	[9780013] = {
		9780013,
		0,
		Lang.get(35933),
		9780,
		13,
		128,
		{
			RTResTalkAction[17],
			RTResTalkAction[83]
		}
	},
	[9780014] = {
		9780014,
		0,
		Lang.get(35934),
		9780,
		14,
		119,
		{
			RTResTalkAction[21],
			RTResTalkAction[83]
		}
	},
	[9780015] = {
		9780015,
		0,
		Lang.get(35935),
		9780,
		15,
		128,
		{
			RTResTalkAction[17],
			RTResTalkAction[83]
		}
	},
	[9780016] = {
		9780016,
		0,
		Lang.get(35936),
		9780,
		16,
		128,
		{
			RTResTalkAction[17],
			RTResTalkAction[83]
		}
	},
	[9780017] = {
		9780017,
		0,
		Lang.get(35937),
		9780,
		17,
		107,
		{
			RTResTalkAction[59],
			RTResTalkAction[33],
			RTResTalkAction[84]
		}
	},
	[9780018] = {
		9780018,
		0,
		Lang.get(44450),
		9780,
		18,
		119,
		{
			RTResTalkAction[17],
			RTResTalkAction[83],
			RTResTalkAction[2]
		}
	},
	[9780019] = {
		9780019,
		0,
		Lang.get(35940),
		9780,
		19,
		119,
		{
			RTResTalkAction[101],
			RTResTalkAction[83]
		}
	},
	[9780020] = {
		9780020,
		0,
		Lang.get(35941),
		9780,
		20,
		128,
		{
			RTResTalkAction[17],
			RTResTalkAction[83]
		}
	},
	[9780021] = {
		9780021,
		0,
		Lang.get(35942),
		9780,
		21,
		119,
		{
			RTResTalkAction[21],
			RTResTalkAction[83]
		}
	},
	[9780022] = {
		9780022,
		0,
		Lang.get(35943),
		9780,
		22,
		300,
		{
			RTResTalkAction[17],
			RTResTalkAction[83]
		}
	},
	[9780023] = {
		9780023,
		9,
		Lang.get(36114),
		9780,
		23,
		605,
		{
			RTResTalkAction[33],
			RTResTalkAction[84]
		},
		nil,
		nil,
		nil,
		nil,
		62,
		9781,
		1,
		1,
		1,
		nil,
		9781,
		nil,
		nil,
		1
	},
	[9780024] = {
		9780024,
		0,
		Lang.get(35945),
		9780,
		24,
		107,
		{
			RTResTalkAction[25]
		},
		1,
		0,
		3,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		303
	},
	[9780025] = {
		9780025,
		0,
		Lang.get(35946),
		9780,
		25,
		119,
		{
			RTResTalkAction[102],
			RTResTalkAction[26]
		}
	},
	[9780026] = {
		9780026,
		0,
		Lang.get(35947),
		9780,
		26,
		128,
		{
			RTResTalkAction[17],
			RTResTalkAction[83]
		}
	},
	[9780027] = {
		9780027,
		0,
		Lang.get(35948),
		9780,
		27,
		119,
		{
			RTResTalkAction[103],
			RTResTalkAction[83]
		}
	},
	[9780028] = {
		9780028,
		0,
		Lang.get(44451),
		9780,
		28,
		107,
		{
			RTResTalkAction[22],
			RTResTalkAction[33],
			RTResTalkAction[84]
		}
	},
	[9780029] = {
		9780029,
		0,
		Lang.get(35951),
		9780,
		29,
		119,
		{
			RTResTalkAction[31],
			RTResTalkAction[2]
		}
	},
	[9790001] = {
		9790001,
		9,
		Lang.get(35952),
		9790,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		9790,
		1,
		1,
		1,
		nil,
		9790,
		nil,
		nil,
		1
	},
	[9790002] = {
		9790002,
		0,
		Lang.get(44452),
		9790,
		2,
		150,
		{
			RTResTalkAction[91]
		},
		nil,
		nil,
		3
	},
	[9790003] = {
		9790003,
		0,
		Lang.get(35955),
		9790,
		3,
		150,
		{
			RTResTalkAction[88]
		}
	},
	[9790004] = {
		9790004,
		0,
		Lang.get(35956),
		9790,
		4,
		679,
		{
			RTResTalkAction[92],
			RTResTalkAction[76]
		}
	},
	[9790005] = {
		9790005,
		0,
		Lang.get(35957),
		9790,
		5,
		679,
		{
			RTResTalkAction[92],
			RTResTalkAction[76]
		}
	},
	[9790006] = {
		9790006,
		0,
		Lang.get(35958),
		9790,
		6,
		150,
		{
			RTResTalkAction[95],
			RTResTalkAction[76]
		}
	},
	[9790007] = {
		9790007,
		0,
		Lang.get(36115),
		9790,
		7,
		679,
		{
			RTResTalkAction[92],
			RTResTalkAction[76]
		}
	},
	[9790008] = {
		9790008,
		0,
		Lang.get(35960),
		9790,
		8,
		150,
		{
			RTResTalkAction[104],
			RTResTalkAction[76]
		}
	},
	[9790009] = {
		9790009,
		0,
		Lang.get(35961),
		9790,
		9,
		150,
		{
			RTResTalkAction[97],
			RTResTalkAction[76]
		}
	},
	[9790010] = {
		9790010,
		0,
		Lang.get(44453),
		9790,
		10,
		679,
		{
			RTResTalkAction[92],
			RTResTalkAction[76]
		}
	},
	[9790011] = {
		9790011,
		0,
		Lang.get(35964),
		9790,
		11,
		150,
		{
			RTResTalkAction[105],
			RTResTalkAction[77]
		}
	},
	[9800001] = {
		9800001,
		0,
		Lang.get(35965),
		9800,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		9800,
		1,
		1,
		1,
		nil,
		9800
	},
	[9800002] = {
		9800002,
		0,
		Lang.get(35966),
		9800,
		2,
		141,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3
	},
	[9800003] = {
		9800003,
		0,
		Lang.get(35967),
		9800,
		3,
		119,
		{
			RTResTalkAction[16],
			RTResTalkAction[13]
		}
	},
	[9800004] = {
		9800004,
		0,
		Lang.get(38007),
		9800,
		4,
		141,
		{
			RTResTalkAction[11],
			RTResTalkAction[33]
		}
	},
	[9800005] = {
		9800005,
		0,
		Lang.get(44454),
		9800,
		5,
		119,
		{
			RTResTalkAction[106],
			RTResTalkAction[13]
		}
	},
	[9800006] = {
		9800006,
		0,
		Lang.get(35971),
		9800,
		6,
		107,
		{
			RTResTalkAction[22],
			RTResTalkAction[33]
		}
	},
	[9800007] = {
		9800007,
		0,
		Lang.get(36117),
		9800,
		7,
		141,
		{
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[9800008] = {
		9800008,
		0,
		Lang.get(35973),
		9800,
		8,
		107,
		{
			RTResTalkAction[107],
			RTResTalkAction[24]
		}
	},
	[9800009] = {
		9800009,
		0,
		Lang.get(35974),
		9800,
		9,
		133,
		{
			RTResTalkAction[2],
			RTResTalkAction[13]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		9801,
		1,
		1,
		1,
		nil,
		9801
	},
	[9800010] = {
		9800010,
		0,
		Lang.get(36118),
		9800,
		10,
		119,
		{
			RTResTalkAction[41]
		},
		nil,
		nil,
		3
	},
	[9800011] = {
		9800011,
		0,
		Lang.get(44455),
		9800,
		11,
		107,
		{
			RTResTalkAction[33]
		},
		1,
		nil,
		nil,
		nil,
		63,
		9802,
		1,
		1,
		1,
		nil,
		9802
	},
	[9800012] = {
		9800012,
		5,
		Lang.get(35978),
		9800,
		12,
		119,
		nil,
		1,
		4
	},
	[9800013] = {
		9800013,
		0,
		Lang.get(35979),
		9800,
		13,
		679,
		nil,
		1,
		0
	},
	[9800014] = {
		9800014,
		0,
		Lang.get(46241),
		9800,
		14,
		141,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3
	},
	[9800015] = {
		9800015,
		0,
		Lang.get(46242),
		9800,
		15,
		119,
		{
			RTResTalkAction[13]
		},
		1,
		5,
		nil,
		nil,
		nil,
		9803,
		1,
		1,
		1,
		nil,
		9803
	},
	[9800016] = {
		9800016,
		0,
		Lang.get(35980),
		9800,
		16,
		119,
		{
			RTResTalkAction[82]
		},
		nil,
		nil,
		3
	},
	[9800017] = {
		9800017,
		0,
		Lang.get(44456),
		9800,
		17,
		679,
		{
			RTResTalkAction[17],
			RTResTalkAction[76]
		}
	},
	[9800018] = {
		9800018,
		0,
		Lang.get(35983),
		9800,
		18,
		679,
		{
			RTResTalkAction[17],
			RTResTalkAction[76]
		}
	},
	[9800019] = {
		9800019,
		0,
		Lang.get(44457),
		9800,
		19,
		119,
		{
			RTResTalkAction[21],
			RTResTalkAction[76]
		}
	},
	[9800020] = {
		9800020,
		0,
		Lang.get(35986),
		9800,
		20,
		679,
		{
			RTResTalkAction[17],
			RTResTalkAction[76]
		}
	},
	[9800021] = {
		9800021,
		0,
		Lang.get(46243),
		9800,
		21,
		119,
		{
			RTResTalkAction[31],
			RTResTalkAction[77]
		}
	},
	[9800022] = {
		9800022,
		0,
		Lang.get(35987),
		9800,
		22,
		107,
		{
			RTResTalkAction[58],
			RTResTalkAction[33]
		}
	},
	[9800023] = {
		9800023,
		0,
		Lang.get(35988),
		9800,
		23,
		679,
		{
			RTResTalkAction[80],
			RTResTalkAction[2]
		}
	},
	[9800024] = {
		9800024,
		0,
		Lang.get(44458),
		9800,
		24,
		119,
		{
			RTResTalkAction[31],
			RTResTalkAction[77]
		}
	},
	[9800025] = {
		9800025,
		0,
		Lang.get(35991),
		9800,
		25,
		119,
		{
			RTResTalkAction[57]
		}
	},
	[9800026] = {
		9800026,
		0,
		Lang.get(35992),
		9800,
		26,
		119,
		{
			RTResTalkAction[108]
		}
	},
	[9810001] = {
		9810001,
		0,
		Lang.get(35993),
		9810,
		1,
		679,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		9810,
		1,
		nil,
		nil,
		nil,
		9810
	},
	[9810002] = {
		9810002,
		0,
		Lang.get(35994),
		9810,
		2,
		119,
		{
			RTResTalkAction[108]
		},
		nil,
		nil,
		3
	},
	[9810003] = {
		9810003,
		0,
		Lang.get(35995),
		9810,
		3,
		119,
		{
			RTResTalkAction[106]
		}
	},
	[9810004] = {
		9810004,
		0,
		Lang.get(36120),
		9810,
		4,
		107,
		{
			RTResTalkAction[22],
			RTResTalkAction[33]
		}
	},
	[9810005] = {
		9810005,
		0,
		Lang.get(36121),
		9810,
		5,
		107,
		{
			RTResTalkAction[71]
		}
	},
	[9810006] = {
		9810006,
		0,
		Lang.get(35998),
		9810,
		6,
		679,
		{
			RTResTalkAction[80],
			RTResTalkAction[2]
		}
	},
	[9810007] = {
		9810007,
		0,
		Lang.get(36122),
		9810,
		7,
		679,
		{
			RTResTalkAction[80]
		}
	},
	[9810008] = {
		9810008,
		0,
		Lang.get(36123),
		9810,
		8,
		679,
		{
			RTResTalkAction[78]
		}
	},
	[9810009] = {
		9810009,
		0,
		Lang.get(36001),
		9810,
		9,
		119,
		{
			RTResTalkAction[108],
			RTResTalkAction[77]
		}
	},
	[9810010] = {
		9810010,
		0,
		Lang.get(44459),
		9810,
		10,
		107,
		{
			RTResTalkAction[22],
			RTResTalkAction[33]
		},
		nil,
		nil,
		3,
		nil,
		57,
		9811,
		0.2,
		1,
		1,
		nil,
		9811
	},
	[9810011] = {
		9810011,
		0,
		Lang.get(36004),
		9810,
		11,
		141,
		{
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[9810012] = {
		9810012,
		0,
		Lang.get(36005),
		9810,
		12,
		119,
		{
			RTResTalkAction[108],
			RTResTalkAction[2],
			RTResTalkAction[13]
		}
	},
	[9810013] = {
		9810013,
		0,
		Lang.get(44460),
		9810,
		13,
		679,
		{
			RTResTalkAction[80],
			RTResTalkAction[33]
		}
	},
	[9810014] = {
		9810014,
		0,
		Lang.get(36008),
		9810,
		14,
		107,
		{
			RTResTalkAction[109],
			RTResTalkAction[77]
		}
	},
	[9810015] = {
		9810015,
		0,
		Lang.get(36009),
		9810,
		15,
		119,
		{
			RTResTalkAction[110],
			RTResTalkAction[2]
		}
	},
	[9810016] = {
		9810016,
		0,
		Lang.get(36010),
		9810,
		16,
		679,
		{
			RTResTalkAction[80],
			RTResTalkAction[33]
		}
	},
	[9810017] = {
		9810017,
		0,
		Lang.get(36011),
		9810,
		17,
		150,
		{
			RTResTalkAction[77]
		},
		1,
		0
	},
	[9810018] = {
		9810018,
		0,
		Lang.get(36012),
		9810,
		18,
		150,
		nil,
		1,
		1
	},
	[9810019] = {
		9810019,
		0,
		Lang.get(36013),
		9810,
		19,
		119,
		{
			RTResTalkAction[31]
		}
	},
	[9810020] = {
		9810020,
		0,
		Lang.get(44461),
		9810,
		20,
		107,
		{
			RTResTalkAction[33]
		},
		1,
		0,
		nil,
		nil,
		nil,
		nil,
		0.2,
		1,
		1,
		nil,
		9812
	},
	[9810021] = {
		9810021,
		0,
		Lang.get(44462),
		9810,
		21,
		141,
		nil,
		1
	},
	[9810022] = {
		9810022,
		0,
		Lang.get(36018),
		9810,
		22,
		679,
		nil,
		1
	},
	[9810023] = {
		9810023,
		0,
		Lang.get(44463),
		9810,
		23,
		150,
		nil,
		1,
		1
	},
	[9810024] = {
		9810024,
		0,
		Lang.get(36124),
		9810,
		24,
		119,
		nil,
		1,
		3
	},
	[9810025] = {
		9810025,
		0,
		Lang.get(44464),
		9810,
		25,
		150,
		nil,
		1,
		0
	},
	[9810026] = {
		9810026,
		0,
		Lang.get(44465),
		9810,
		26,
		119,
		nil,
		1
	},
	[9810027] = {
		9810027,
		0,
		Lang.get(36025),
		9810,
		27,
		150,
		nil,
		1
	},
	[9810028] = {
		9810028,
		0,
		Lang.get(36026),
		9810,
		28,
		119,
		nil,
		1
	},
	[9820001] = {
		9820001,
		11,
		"Videos/AVG_lvzhifight.mp4",
		9820,
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		57,
		nil,
		nil,
		1,
		1
	},
	[9820002] = {
		9820002,
		0,
		Lang.get(36027),
		9820,
		2,
		150,
		nil,
		1,
		nil,
		nil,
		nil,
		57,
		nil,
		1,
		nil,
		1,
		nil,
		9820
	},
	[9820003] = {
		9820003,
		0,
		Lang.get(36028),
		9820,
		3,
		150,
		nil,
		1
	},
	[9820004] = {
		9820004,
		0,
		Lang.get(36029),
		9820,
		4,
		119,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		9821,
		nil,
		1,
		1,
		nil,
		9821
	},
	[9820005] = {
		9820005,
		0,
		Lang.get(44466),
		9820,
		5,
		119,
		{
			RTResTalkAction[31]
		},
		nil,
		nil,
		3
	},
	[9820006] = {
		9820006,
		0,
		Lang.get(36032),
		9820,
		6,
		107,
		{
			RTResTalkAction[22],
			RTResTalkAction[33]
		}
	},
	[9820007] = {
		9820007,
		0,
		Lang.get(36126),
		9820,
		7,
		107,
		{
			RTResTalkAction[59]
		}
	},
	[9820008] = {
		9820008,
		0,
		Lang.get(44467),
		9820,
		8,
		141,
		{
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[9820009] = {
		9820009,
		0,
		Lang.get(44468),
		9820,
		9,
		679,
		{
			RTResTalkAction[80],
			RTResTalkAction[2],
			RTResTalkAction[13]
		}
	},
	[9820010] = {
		9820010,
		0,
		Lang.get(36038),
		9820,
		10,
		119,
		{
			RTResTalkAction[16],
			RTResTalkAction[77]
		}
	},
	[9820011] = {
		9820011,
		0,
		Lang.get(36039),
		9820,
		11,
		679,
		{
			RTResTalkAction[80],
			RTResTalkAction[33]
		}
	},
	[9820012] = {
		9820012,
		0,
		Lang.get(36040),
		9820,
		12,
		128,
		{
			RTResTalkAction[111],
			RTResTalkAction[77]
		}
	},
	[9820013] = {
		9820013,
		0,
		Lang.get(36041),
		9820,
		13,
		679,
		{
			RTResTalkAction[80],
			RTResTalkAction[84]
		}
	},
	[9820014] = {
		9820014,
		0,
		Lang.get(44469),
		9820,
		14,
		128,
		{
			RTResTalkAction[111],
			RTResTalkAction[77]
		}
	},
	[9820015] = {
		9820015,
		0,
		Lang.get(44470),
		9820,
		15,
		679,
		{
			RTResTalkAction[80],
			RTResTalkAction[84]
		}
	},
	[9820016] = {
		9820016,
		0,
		Lang.get(36046),
		9820,
		16,
		679,
		{
			RTResTalkAction[80]
		}
	},
	[9820017] = {
		9820017,
		5,
		Lang.get(36047),
		9820,
		17,
		119,
		{
			RTResTalkAction[41],
			RTResTalkAction[77]
		}
	},
	[9820018] = {
		9820018,
		0,
		Lang.get(36048),
		9820,
		18,
		107,
		{
			RTResTalkAction[46],
			RTResTalkAction[33]
		}
	},
	[9820019] = {
		9820019,
		5,
		Lang.get(36128),
		9820,
		19,
		119,
		{
			RTResTalkAction[57],
			RTResTalkAction[2]
		}
	},
	[9830001] = {
		9830001,
		3,
		Lang.get(36050),
		9830,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		9830,
		2,
		nil,
		1,
		nil,
		9830,
		nil,
		nil,
		1
	},
	[9830002] = {
		9830002,
		9,
		Lang.get(36051),
		9830,
		2,
		351,
		{
			RTResTalkAction[112]
		},
		nil,
		nil,
		3,
		[21] = 1,
		[20] = 304
	},
	[9830003] = {
		9830003,
		9,
		Lang.get(36052),
		9830,
		3,
		351,
		{
			RTResTalkAction[112]
		},
		[21] = 1,
		[20] = 304
	},
	[9830004] = {
		9830004,
		9,
		Lang.get(36053),
		9830,
		4,
		351,
		{
			RTResTalkAction[112]
		},
		[21] = 1,
		[20] = 304
	},
	[9830005] = {
		9830005,
		0,
		Lang.get(36054),
		9830,
		5,
		107,
		{
			RTResTalkAction[22],
			RTResTalkAction[113]
		}
	},
	[9830006] = {
		9830006,
		0,
		Lang.get(36055),
		9830,
		6,
		107,
		{
			RTResTalkAction[114]
		}
	},
	[9830007] = {
		9830007,
		0,
		Lang.get(36056),
		9830,
		7,
		141,
		{
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[9830008] = {
		9830008,
		0,
		Lang.get(36057),
		9830,
		8,
		119,
		{
			RTResTalkAction[108],
			RTResTalkAction[2],
			RTResTalkAction[13]
		}
	},
	[9830009] = {
		9830009,
		0,
		Lang.get(44471),
		9830,
		9,
		119,
		{
			RTResTalkAction[31]
		}
	},
	[9830010] = {
		9830010,
		0,
		Lang.get(44472),
		9830,
		10,
		128,
		{
			RTResTalkAction[17],
			RTResTalkAction[83]
		}
	},
	[9830011] = {
		9830011,
		0,
		Lang.get(36063),
		9830,
		11,
		679,
		{
			RTResTalkAction[115],
			RTResTalkAction[33],
			RTResTalkAction[84]
		}
	},
	[9830012] = {
		9830012,
		0,
		Lang.get(36064),
		9830,
		12,
		679,
		{
			RTResTalkAction[80]
		}
	},
	[9830013] = {
		9830013,
		0,
		Lang.get(36065),
		9830,
		13,
		107,
		{
			RTResTalkAction[71],
			RTResTalkAction[77]
		}
	},
	[9830014] = {
		9830014,
		0,
		Lang.get(36066),
		9830,
		14,
		119,
		{
			RTResTalkAction[16],
			RTResTalkAction[2]
		}
	},
	[9830015] = {
		9830015,
		0,
		Lang.get(36067),
		9830,
		15,
		119,
		{
			RTResTalkAction[31]
		}
	},
	[9830016] = {
		9830016,
		0,
		Lang.get(36068),
		9830,
		16,
		119,
		{
			RTResTalkAction[116]
		}
	},
	[9850001] = {
		9850001,
		0,
		Lang.get(44473),
		9850,
		1,
		627,
		nil,
		1,
		0,
		nil,
		nil,
		63,
		9850,
		nil,
		nil,
		1,
		nil,
		9850
	},
	[9850002] = {
		9850002,
		0,
		Lang.get(44474),
		9850,
		2,
		548,
		nil,
		1,
		0
	},
	[9850003] = {
		9850003,
		0,
		Lang.get(44475),
		9850,
		3,
		627,
		{
			RTResTalkAction[117]
		},
		nil,
		nil,
		3
	},
	[9850004] = {
		9850004,
		0,
		Lang.get(44476),
		9850,
		4,
		548,
		{
			RTResTalkAction[118],
			RTResTalkAction[119]
		}
	},
	[9850005] = {
		9850005,
		0,
		Lang.get(44477),
		9850,
		5,
		627,
		{
			RTResTalkAction[117],
			RTResTalkAction[120]
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
