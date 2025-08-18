-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\meishumei\\ResTalk.lua

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
	716,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[2] = {
	1,
	107,
	{
		10011
	},
	nil,
	2
}
RTResTalkAction[3] = {
	[1] = 0,
	[2] = 716
}
RTResTalkAction[4] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[5] = {
	[1] = 1,
	[2] = 18
}
RTResTalkAction[6] = {
	[1] = 1,
	[2] = 29
}
RTResTalkAction[7] = {
	[1] = 0,
	[2] = 18
}
RTResTalkAction[8] = {
	[1] = 1,
	[2] = 387
}
RTResTalkAction[9] = {
	[1] = 0,
	[2] = 29
}
RTResTalkAction[10] = {
	1,
	107,
	{
		1,
		10021
	},
	nil,
	8
}
RTResTalkAction[11] = {
	1,
	107,
	nil,
	nil,
	0
}
RTResTalkAction[12] = {
	[1] = 0,
	[2] = 387
}
RTResTalkAction[13] = {
	1,
	134,
	{
		1
	},
	nil,
	3
}
RTResTalkAction[14] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[15] = {
	[1] = 0,
	[2] = 134
}
RTResTalkAction[16] = {
	1,
	107,
	{
		10021
	},
	nil,
	8
}
RTResTalkAction[17] = {
	1,
	29,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[18] = {
	[1] = 2,
	[2] = 29
}
RTResTalkAction[19] = {
	[1] = 3,
	[2] = 18
}
RTResTalkAction[20] = {
	[1] = 1,
	[2] = 18,
	[3] = {
		2
	}
}
RTResTalkAction[21] = {
	[1] = 1,
	[2] = 18,
	[3] = {
		3
	}
}
RTResTalkAction[22] = {
	1,
	107,
	{
		1,
		10021
	},
	nil,
	1
}
RTResTalkAction[23] = {
	1,
	107,
	nil,
	nil,
	3
}
RTResTalkAction[24] = {
	1,
	134,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[25] = {
	1,
	29,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[26] = {
	[1] = 1,
	[2] = 141
}
RTResTalkAction[27] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[28] = {
	1,
	387,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[29] = {
	1,
	141,
	nil,
	nil,
	1
}
RTResTalkAction[30] = {
	1,
	141,
	nil,
	nil,
	0
}
RTResTalkAction[31] = {
	1,
	387,
	{
		2
	},
	nil,
	5
}
RTResTalkAction[32] = {
	1,
	107,
	{
		3
	},
	nil,
	10
}
RTResTalkAction[33] = {
	1,
	134,
	nil,
	nil,
	3
}
RTResTalkAction[34] = {
	1,
	387,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[35] = {
	1,
	387,
	nil,
	nil,
	5
}
RTResTalkAction[36] = {
	[1] = 1,
	[2] = 141,
	[3] = {
		2,
		10022
	}
}
RTResTalkAction[37] = {
	[1] = 1,
	[2] = 387,
	[3] = {
		1
	}
}
RTResTalkAction[38] = {
	1,
	134,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[39] = {
	1,
	107,
	{
		1
	},
	nil,
	5
}
RTResTalkAction[40] = {
	1,
	107,
	nil,
	nil,
	9
}
RTResTalkAction[41] = {
	1,
	107,
	{
		2
	},
	nil,
	7
}
RTResTalkAction[42] = {
	1,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[43] = {
	1,
	107,
	{
		1,
		10021
	},
	nil,
	5
}
RTResTalkAction[44] = {
	1,
	141,
	{
		2,
		10022
	},
	nil,
	0
}
RTResTalkAction[45] = {
	1,
	141,
	{
		10022
	},
	nil,
	1
}
RTResTalkAction[46] = {
	1,
	141,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[47] = {
	1,
	141,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[48] = {
	1,
	141,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[49] = {
	1,
	134,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[50] = {
	1,
	387,
	nil,
	nil,
	1
}
RTResTalkAction[51] = {
	1,
	387,
	{
		1
	},
	nil,
	3
}
RTResTalkAction[52] = {
	1,
	107,
	{
		2
	},
	nil,
	8
}
RTResTalkAction[53] = {
	1,
	107,
	nil,
	nil,
	10
}
RTResTalkAction[54] = {
	1,
	387,
	nil,
	nil,
	3
}
RTResTalkAction[55] = {
	1,
	107,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[56] = {
	1,
	387,
	nil,
	nil,
	0
}
RTResTalkAction[57] = {
	[1] = 1,
	[2] = 141,
	[3] = {
		2
	}
}
RTResTalkAction[58] = {
	1,
	107,
	{
		3
	},
	nil,
	3
}
RTResTalkAction[59] = {
	1,
	107,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[60] = {
	1,
	107,
	nil,
	nil,
	5
}
RTResTalkAction[61] = {
	[1] = 1,
	[2] = 3
}
RTResTalkAction[62] = {
	[1] = 0,
	[2] = 3
}
RTResTalkAction[63] = {
	1,
	141,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[64] = {
	[1] = 2,
	[2] = 107,
	[3] = {
		1
	}
}
RTResTalkAction[65] = {
	[1] = 3,
	[2] = 141
}
RTResTalkAction[66] = {
	1,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[67] = {
	[1] = 1,
	[2] = 107,
	[3] = {
		1,
		10021
	}
}
RTResTalkAction[68] = {
	1,
	134,
	nil,
	nil,
	2
}
RTResTalkAction[69] = {
	1,
	107,
	{
		2
	},
	nil,
	6
}
RTResTalkAction[70] = {
	1,
	141,
	{
		1,
		10022
	},
	nil,
	0
}
RTResTalkAction[71] = {
	1,
	141,
	nil,
	nil,
	2
}
RTResTalkAction[72] = {
	1,
	107,
	nil,
	nil,
	7
}
RTResTalkAction[73] = {
	1,
	141,
	{
		10013
	},
	nil,
	0
}
RTResTalkAction[74] = {
	1,
	134,
	nil,
	nil,
	1
}
RTResTalkAction[75] = {
	1,
	134,
	nil,
	nil,
	0
}
RTResTalkAction[76] = {
	[1] = 1,
	[2] = 388
}
RTResTalkAction[77] = {
	1,
	388,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[78] = {
	1,
	388,
	{
		1002
	},
	nil,
	3
}
RTResTalkAction[79] = {
	1,
	388,
	nil,
	nil,
	1
}
RTResTalkAction[80] = {
	[1] = 1,
	[2] = 388,
	[3] = {
		2,
		1002
	}
}
RTResTalkAction[81] = {
	1,
	388,
	nil,
	nil,
	2
}
RTResTalkAction[82] = {
	1,
	388,
	{
		1
	},
	nil,
	3
}
RTResTalkAction[83] = {
	[1] = 0,
	[2] = 388
}
RTResTalkAction[84] = {
	[1] = 1,
	[2] = 366
}
RTResTalkAction[85] = {
	1,
	366,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[86] = {
	1,
	366,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[87] = {
	[1] = 1,
	[2] = 366,
	[3] = {
		1002
	}
}
RTResTalkAction[88] = {
	1,
	366,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[89] = {
	1,
	366,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[90] = {
	1,
	366,
	nil,
	nil,
	0
}
RTResTalkAction[91] = {
	[1] = 0,
	[2] = 366
}
RTResTalkAction[92] = {
	1,
	388,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[93] = {
	1,
	107,
	{
		1
	},
	nil,
	6
}
RTResTalkAction[94] = {
	1,
	134,
	nil,
	nil,
	4
}
RTResTalkAction[95] = {
	1,
	387,
	nil,
	nil,
	2
}
RTResTalkAction[96] = {
	[1] = 1,
	[2] = 107,
	[3] = {
		2
	}
}
RTResTalkAction[97] = {
	1,
	107,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[98] = {
	1,
	107,
	{
		10021
	},
	nil,
	0
}
RTResTalkAction[99] = {
	1,
	107,
	{
		10011
	},
	nil,
	10
}
RTResTalkAction[100] = {
	1,
	107,
	{
		10011
	},
	nil,
	8
}
RTResTalkAction[101] = {
	1,
	141,
	{
		10022
	},
	nil,
	0
}
RTResTalkAction[102] = {
	1,
	107,
	{
		2
	},
	nil,
	4
}
RTResTalkAction[103] = {
	1,
	216,
	nil,
	nil,
	0
}
RTResTalkAction[104] = {
	[1] = 0,
	[2] = 216
}
RTResTalkAction[105] = {
	1,
	216,
	{
		1
	},
	nil,
	3
}
RTResTalkAction[106] = {
	[1] = 1,
	[2] = 141,
	[3] = {
		1
	}
}
RTResTalkAction[107] = {
	1,
	107,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[108] = {
	1,
	107,
	{
		3
	},
	nil,
	6
}
RTResTalkAction[109] = {
	[1] = 1,
	[2] = 107,
	[3] = {
		1
	}
}
RTResTalkAction[110] = {
	1,
	387,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[111] = {
	1,
	134,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[112] = {
	1,
	107,
	nil,
	nil,
	1
}
RTResTalkAction[113] = {
	1,
	387,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[114] = {
	1,
	216,
	nil,
	nil,
	3
}
RTResTalkAction[115] = {
	[1] = 1,
	[2] = 29,
	[3] = {
		2
	}
}
RTResTalkAction[116] = {
	[1] = 1,
	[2] = 10
}
RTResTalkAction[117] = {
	[1] = 0,
	[2] = 10
}
RTResTalkAction[118] = {
	[1] = 1,
	[2] = 32,
	[3] = {
		3
	}
}
RTResTalkAction[119] = {
	[1] = 1,
	[2] = 32
}
RTResTalkAction[120] = {
	[1] = 1,
	[2] = 27,
	[3] = {
		1
	}
}
RTResTalkAction[121] = {
	[1] = 0,
	[2] = 32
}
RTResTalkAction[122] = {
	[1] = 1,
	[2] = 27
}
RTResTalkAction[123] = {
	[1] = 0,
	[2] = 27
}
RTResTalkAction[124] = {
	1,
	18,
	nil,
	nil,
	0
}
RTResTalkAction[125] = {
	1,
	387,
	nil,
	nil,
	4
}
RTResTalkAction[126] = {
	1,
	141,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[127] = {
	1,
	107,
	{
		1,
		10021
	},
	nil,
	10
}
RTResTalkAction[128] = {
	1,
	387,
	nil,
	nil,
	6
}
RTResTalkAction[129] = {
	1,
	107,
	{
		1,
		10031
	},
	nil,
	6
}
RTResTalkAction[130] = {
	1,
	216,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[131] = {
	1,
	107,
	{
		1,
		10031
	},
	nil,
	5
}

local Data = {
	[22000001] = {
		22000001,
		0,
		Lang.get(49097),
		22000,
		1,
		141,
		nil,
		1,
		1,
		nil,
		nil,
		57,
		22000,
		2,
		nil,
		nil,
		1,
		nil,
		22000
	},
	[22000002] = {
		22000002,
		0,
		Lang.get(49098),
		22000,
		2,
		107,
		nil,
		1,
		8
	},
	[22000003] = {
		22000003,
		0,
		Lang.get(49099),
		22000,
		3,
		107,
		nil,
		1,
		[19] = 22123
	},
	[22000004] = {
		22000004,
		0,
		Lang.get(49100),
		22000,
		4,
		141,
		nil,
		1,
		0
	},
	[22000005] = {
		22000005,
		0,
		Lang.get(49101),
		22000,
		5,
		107,
		nil,
		1,
		6
	},
	[22000006] = {
		22000006,
		0,
		Lang.get(49102),
		22000,
		6,
		134,
		nil,
		1,
		3,
		nil,
		nil,
		nil,
		22100,
		nil,
		nil,
		nil,
		nil,
		nil,
		22100
	},
	[22000007] = {
		22000007,
		0,
		Lang.get(49103),
		22000,
		7,
		716,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[22000008] = {
		22000008,
		0,
		Lang.get(49104),
		22000,
		8,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[22000009] = {
		22000009,
		0,
		Lang.get(49105),
		22000,
		9,
		107,
		{
			RTResTalkAction[4]
		},
		1,
		1,
		nil,
		1070,
		nil,
		22001,
		nil,
		1,
		nil,
		nil,
		nil,
		22001
	},
	[22000010] = {
		22000010,
		0,
		Lang.get(49106),
		22000,
		10,
		18,
		nil,
		1,
		0,
		nil,
		nil,
		57,
		22002,
		nil,
		nil,
		nil,
		0,
		nil,
		22002
	},
	[22000011] = {
		22000011,
		0,
		Lang.get(49107),
		22000,
		11,
		29,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22007,
		[19] = 22007
	},
	[22000012] = {
		22000012,
		0,
		Lang.get(49108),
		22000,
		12,
		10,
		nil,
		1
	},
	[22000013] = {
		22000013,
		0,
		Lang.get(49109),
		22000,
		13,
		387,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22008,
		[19] = 22008
	},
	[22000014] = {
		22000014,
		0,
		Lang.get(49110),
		22000,
		14,
		387,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22009,
		[19] = 22009
	},
	[22000015] = {
		22000015,
		0,
		Lang.get(49111),
		22000,
		15,
		18,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		3
	},
	[22000016] = {
		22000016,
		0,
		Lang.get(49112),
		22000,
		16,
		18,
		{
			RTResTalkAction[5]
		}
	},
	[22000017] = {
		22000017,
		0,
		Lang.get(49113),
		22000,
		17,
		29,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[22000018] = {
		22000018,
		0,
		Lang.get(49114),
		22000,
		18,
		387,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[22001001] = {
		22001001,
		0,
		Lang.get(49115),
		22001,
		1,
		107,
		nil,
		1,
		3,
		-1,
		nil,
		57,
		22120,
		nil,
		1,
		nil,
		1,
		nil,
		22120
	},
	[22001002] = {
		22001002,
		0,
		Lang.get(49116),
		22001,
		2,
		134,
		nil,
		1,
		2
	},
	[22001003] = {
		22001003,
		0,
		Lang.get(49117),
		22001,
		3,
		107,
		nil,
		1,
		3
	},
	[22001004] = {
		22001004,
		5,
		Lang.get(49118),
		22001,
		4,
		3,
		nil,
		1,
		0,
		nil,
		1070,
		nil,
		22103,
		nil,
		nil,
		nil,
		nil,
		nil,
		22103
	},
	[22001005] = {
		22001005,
		0,
		Lang.get(49119),
		22001,
		5,
		107,
		nil,
		1,
		3,
		nil,
		nil,
		nil,
		22004,
		nil,
		nil,
		nil,
		nil,
		nil,
		22004
	},
	[22002001] = {
		22002001,
		0,
		Lang.get(49120),
		22002,
		1,
		18,
		nil,
		1,
		0,
		nil,
		nil,
		57,
		22005,
		nil,
		nil,
		nil,
		nil,
		nil,
		22005
	},
	[22002002] = {
		22002002,
		0,
		Lang.get(49121),
		22002,
		2,
		107,
		nil,
		1,
		5,
		nil,
		nil,
		nil,
		22101,
		nil,
		nil,
		nil,
		nil,
		nil,
		22101
	},
	[22002003] = {
		22002003,
		0,
		Lang.get(49122),
		22002,
		3,
		29,
		nil,
		1,
		0
	},
	[22002004] = {
		22002004,
		0,
		Lang.get(49123),
		22002,
		4,
		107,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3,
		nil,
		62
	},
	[22002005] = {
		22002005,
		0,
		Lang.get(49124),
		22002,
		5,
		387,
		{
			RTResTalkAction[8],
			RTResTalkAction[4]
		}
	},
	[22002006] = {
		22002006,
		0,
		Lang.get(49125),
		22002,
		6,
		107,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[22002007] = {
		22002007,
		0,
		Lang.get(49126),
		22002,
		7,
		18,
		{
			RTResTalkAction[4]
		},
		1,
		0,
		-1,
		nil,
		nil,
		22104,
		nil,
		1,
		nil,
		nil,
		nil,
		22104
	},
	[22002008] = {
		22002008,
		0,
		Lang.get(49127),
		22002,
		8,
		387,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22105
	},
	[22002009] = {
		22002009,
		0,
		Lang.get(49128),
		22002,
		9,
		29,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		22101,
		nil,
		nil,
		nil,
		nil,
		nil,
		22007
	},
	[22002010] = {
		22002010,
		0,
		Lang.get(49129),
		22002,
		10,
		29,
		nil,
		1
	},
	[22002011] = {
		22002011,
		0,
		Lang.get(49130),
		22002,
		11,
		387,
		nil,
		1,
		1,
		[19] = 22101
	},
	[22002012] = {
		22002012,
		0,
		Lang.get(49131),
		22002,
		12,
		134,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		3
	},
	[22002013] = {
		22002013,
		0,
		Lang.get(49132),
		22002,
		13,
		107,
		{
			RTResTalkAction[14],
			RTResTalkAction[15]
		}
	},
	[22002014] = {
		22002014,
		0,
		Lang.get(49133),
		22002,
		14,
		107,
		{
			RTResTalkAction[16]
		}
	},
	[22002015] = {
		22002015,
		0,
		Lang.get(49134),
		22002,
		15,
		29,
		{
			RTResTalkAction[17],
			RTResTalkAction[4]
		}
	},
	[22002016] = {
		22002016,
		0,
		Lang.get(49135),
		22002,
		16,
		18,
		{
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[22002017] = {
		22002017,
		0,
		Lang.get(49136),
		22002,
		17,
		141,
		{
			RTResTalkAction[9],
			RTResTalkAction[7]
		},
		1,
		2,
		-1,
		nil,
		nil,
		22006,
		nil,
		1,
		nil,
		1,
		nil,
		22006
	},
	[22002018] = {
		22002018,
		0,
		Lang.get(49137),
		22002,
		18,
		18,
		nil,
		1,
		0
	},
	[22002019] = {
		22002019,
		0,
		Lang.get(49138),
		22002,
		19,
		18,
		{
			RTResTalkAction[20]
		},
		nil,
		nil,
		3
	},
	[22002020] = {
		22002020,
		0,
		Lang.get(49139),
		22002,
		20,
		18,
		{
			RTResTalkAction[5]
		}
	},
	[22002021] = {
		22002021,
		0,
		Lang.get(49140),
		22002,
		21,
		18,
		{
			RTResTalkAction[21]
		}
	},
	[22002022] = {
		22002022,
		0,
		Lang.get(49141),
		22002,
		22,
		107,
		{
			RTResTalkAction[22],
			RTResTalkAction[7]
		}
	},
	[22002023] = {
		22002023,
		0,
		Lang.get(49142),
		22002,
		23,
		107,
		{
			RTResTalkAction[23]
		}
	},
	[22002024] = {
		22002024,
		0,
		Lang.get(49143),
		22002,
		24,
		134,
		{
			RTResTalkAction[24],
			RTResTalkAction[4]
		}
	},
	[22002025] = {
		22002025,
		0,
		Lang.get(49144),
		22002,
		25,
		29,
		{
			RTResTalkAction[25],
			RTResTalkAction[15]
		}
	},
	[22002026] = {
		22002026,
		0,
		Lang.get(49145),
		22002,
		26,
		29,
		{
			RTResTalkAction[6]
		}
	},
	[22002027] = {
		22002027,
		0,
		Lang.get(49146),
		22002,
		27,
		29,
		{
			RTResTalkAction[9]
		},
		1,
		nil,
		-1,
		nil,
		nil,
		22107,
		nil,
		1,
		nil,
		nil,
		nil,
		22107
	},
	[22003001] = {
		22003001,
		0,
		Lang.get(49147),
		22003,
		1,
		107,
		nil,
		1,
		3,
		nil,
		nil,
		63,
		22010,
		nil,
		nil,
		nil,
		1,
		nil,
		22010
	},
	[22003002] = {
		22003002,
		0,
		Lang.get(49148),
		22003,
		2,
		141,
		nil,
		1,
		1
	},
	[22003003] = {
		22003003,
		0,
		Lang.get(49149),
		22003,
		3,
		141,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		22011,
		1.1,
		nil,
		nil,
		nil,
		nil,
		22011
	},
	[22003004] = {
		22003004,
		0,
		Lang.get(49150),
		22003,
		4,
		387,
		nil,
		1
	},
	[22003005] = {
		22003005,
		7,
		"65",
		22003,
		5,
		387,
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
	[22003006] = {
		22003006,
		0,
		Lang.get(49151),
		22003,
		6,
		141,
		{
			RTResTalkAction[26]
		},
		nil,
		nil,
		3
	},
	[22003007] = {
		22003007,
		0,
		Lang.get(49152),
		22003,
		7,
		387,
		{
			RTResTalkAction[8],
			RTResTalkAction[27]
		}
	},
	[22003008] = {
		22003008,
		0,
		Lang.get(49153),
		22003,
		8,
		107,
		{
			RTResTalkAction[12]
		},
		1,
		8,
		-1,
		nil,
		nil,
		22013,
		nil,
		1,
		nil,
		1,
		nil,
		22013
	},
	[22003009] = {
		22003009,
		0,
		Lang.get(49154),
		22003,
		9,
		107,
		nil,
		1,
		0
	},
	[22003010] = {
		22003010,
		0,
		Lang.get(49155),
		22003,
		10,
		387,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		nil,
		1.2,
		nil,
		nil,
		nil,
		nil,
		22126
	},
	[22003011] = {
		22003011,
		0,
		Lang.get(49156),
		22003,
		11,
		107,
		nil,
		1,
		8
	},
	[22003012] = {
		22003012,
		0,
		Lang.get(49157),
		22003,
		12,
		387,
		nil,
		1,
		5,
		nil,
		nil,
		nil,
		22108,
		nil,
		1,
		nil,
		1,
		nil,
		22108
	},
	[22003013] = {
		22003013,
		0,
		Lang.get(49158),
		22003,
		13,
		387,
		nil,
		1
	},
	[22003014] = {
		22003014,
		0,
		Lang.get(49159),
		22003,
		14,
		387,
		nil,
		1
	},
	[22003015] = {
		22003015,
		0,
		Lang.get(49160),
		22003,
		15,
		134,
		nil,
		1,
		3,
		nil,
		nil,
		nil,
		22011,
		1.1,
		nil,
		nil,
		0,
		nil,
		22011
	},
	[22003016] = {
		22003016,
		0,
		Lang.get(49161),
		22003,
		16,
		387,
		{
			RTResTalkAction[28]
		},
		nil,
		nil,
		3
	},
	[22003017] = {
		22003017,
		0,
		Lang.get(49162),
		22003,
		17,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[12]
		}
	},
	[22003018] = {
		22003018,
		0,
		Lang.get(49163),
		22003,
		18,
		141,
		{
			RTResTalkAction[30]
		}
	},
	[22003019] = {
		22003019,
		0,
		Lang.get(49164),
		22003,
		19,
		387,
		{
			RTResTalkAction[31],
			RTResTalkAction[27]
		}
	},
	[22003020] = {
		22003020,
		0,
		Lang.get(49165),
		22003,
		20,
		387,
		{
			RTResTalkAction[8]
		}
	},
	[22004001] = {
		22004001,
		0,
		Lang.get(49166),
		22004,
		1,
		141,
		nil,
		1,
		1,
		nil,
		nil,
		59,
		22014,
		nil,
		1,
		nil,
		nil,
		nil,
		22014
	},
	[22004002] = {
		22004002,
		0,
		Lang.get(49167),
		22004,
		2,
		387,
		nil,
		1,
		0,
		[19] = 22015
	},
	[22004003] = {
		22004003,
		0,
		Lang.get(49168),
		22004,
		3,
		387,
		nil,
		1,
		5
	},
	[22004004] = {
		22004004,
		0,
		Lang.get(49169),
		22004,
		4,
		107,
		nil,
		1,
		8,
		nil,
		nil,
		nil,
		22016,
		nil,
		nil,
		nil,
		0,
		nil,
		22016
	},
	[22004005] = {
		22004005,
		0,
		Lang.get(49170),
		22004,
		5,
		107,
		nil,
		1,
		10
	},
	[22004006] = {
		22004006,
		0,
		Lang.get(49171),
		22004,
		6,
		387,
		nil,
		1,
		0,
		nil,
		nil,
		154,
		22017,
		1,
		nil,
		nil,
		nil,
		nil,
		22017
	},
	[22004007] = {
		22004007,
		0,
		nil,
		22004,
		7,
		387,
		[19] = 22128
	},
	[22004008] = {
		22004008,
		0,
		Lang.get(49172),
		22004,
		8,
		387,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		22109,
		2,
		nil,
		nil,
		1,
		nil,
		22109
	},
	[22004009] = {
		22004009,
		0,
		Lang.get(49173),
		22004,
		9,
		387,
		nil,
		1,
		5
	},
	[22004010] = {
		22004010,
		0,
		Lang.get(49174),
		22004,
		10,
		387,
		nil,
		1,
		6,
		nil,
		nil,
		nil,
		22110,
		nil,
		nil,
		nil,
		1,
		nil,
		22110
	},
	[22004011] = {
		22004011,
		0,
		Lang.get(49175),
		22004,
		11,
		387,
		nil,
		1,
		1
	},
	[22004012] = {
		22004012,
		0,
		Lang.get(49176),
		22004,
		12,
		387,
		nil,
		1,
		5
	},
	[22004013] = {
		22004013,
		0,
		Lang.get(49176),
		22004,
		13,
		387,
		nil,
		1,
		5,
		nil,
		nil,
		nil,
		22122,
		nil,
		nil,
		nil,
		0,
		nil,
		22127
	},
	[22004014] = {
		22004014,
		0,
		Lang.get(49177),
		22004,
		14,
		107,
		nil,
		1,
		10,
		nil,
		nil,
		nil,
		22122,
		2.2,
		nil,
		nil,
		nil,
		nil,
		22122
	},
	[22004015] = {
		22004015,
		0,
		Lang.get(49178),
		22004,
		15,
		387,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		22019,
		nil,
		nil,
		nil,
		nil,
		nil,
		22019
	},
	[22004016] = {
		22004016,
		0,
		Lang.get(49179),
		22004,
		16,
		141,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22014,
		[19] = 22014
	},
	[22004017] = {
		22004017,
		0,
		Lang.get(49180),
		22004,
		17,
		107,
		{
			RTResTalkAction[32]
		},
		nil,
		nil,
		3
	},
	[22004018] = {
		22004018,
		0,
		Lang.get(49181),
		22004,
		18,
		134,
		{
			RTResTalkAction[33],
			RTResTalkAction[4]
		}
	},
	[22004019] = {
		22004019,
		0,
		Lang.get(49182),
		22004,
		19,
		387,
		{
			RTResTalkAction[34],
			RTResTalkAction[15]
		}
	},
	[22004020] = {
		22004020,
		0,
		Lang.get(49183),
		22004,
		20,
		141,
		{
			RTResTalkAction[12]
		},
		1,
		nil,
		-1,
		nil,
		nil,
		nil,
		nil,
		1,
		nil,
		1,
		nil,
		22015
	},
	[22004021] = {
		22004021,
		0,
		Lang.get(49184),
		22004,
		21,
		141,
		nil,
		1
	},
	[22004022] = {
		22004022,
		0,
		Lang.get(49185),
		22004,
		22,
		387,
		{
			RTResTalkAction[35]
		},
		nil,
		nil,
		3
	},
	[22004023] = {
		22004023,
		0,
		Lang.get(50260),
		22004,
		23,
		141,
		{
			RTResTalkAction[36],
			RTResTalkAction[12]
		}
	},
	[22004024] = {
		22004024,
		0,
		Lang.get(49187),
		22004,
		24,
		387,
		{
			RTResTalkAction[28],
			RTResTalkAction[27]
		}
	},
	[22004025] = {
		22004025,
		0,
		Lang.get(49188),
		22004,
		25,
		141,
		{
			RTResTalkAction[26],
			RTResTalkAction[12]
		}
	},
	[22004026] = {
		22004026,
		0,
		Lang.get(49189),
		22004,
		26,
		141,
		{
			RTResTalkAction[26]
		}
	},
	[22004027] = {
		22004027,
		0,
		Lang.get(49190),
		22004,
		27,
		141,
		{
			RTResTalkAction[26]
		}
	},
	[22004028] = {
		22004028,
		0,
		Lang.get(49191),
		22004,
		28,
		141,
		{
			RTResTalkAction[26]
		}
	},
	[22004029] = {
		22004029,
		0,
		Lang.get(49192),
		22004,
		29,
		387,
		{
			RTResTalkAction[8],
			RTResTalkAction[27]
		}
	},
	[22004030] = {
		22004030,
		0,
		Lang.get(49193),
		22004,
		30,
		387,
		{
			RTResTalkAction[37]
		}
	},
	[22005001] = {
		22005001,
		0,
		Lang.get(49194),
		22005,
		1,
		107,
		nil,
		1,
		5,
		nil,
		nil,
		62,
		22020,
		nil,
		1,
		nil,
		1,
		nil,
		22020
	},
	[22005002] = {
		22005002,
		0,
		Lang.get(49195),
		22005,
		2,
		387,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		22021,
		nil,
		nil,
		nil,
		nil,
		nil,
		22021
	},
	[22005003] = {
		22005003,
		0,
		Lang.get(49196),
		22005,
		3,
		107,
		nil,
		1,
		7,
		nil,
		nil,
		nil,
		22020,
		nil,
		nil,
		nil,
		nil,
		nil,
		22020
	},
	[22005004] = {
		22005004,
		0,
		Lang.get(49197),
		22005,
		4,
		134,
		{
			RTResTalkAction[38]
		},
		nil,
		nil,
		3
	},
	[22005005] = {
		22005005,
		0,
		Lang.get(50261),
		22005,
		5,
		107,
		{
			RTResTalkAction[11],
			RTResTalkAction[15]
		}
	},
	[22005006] = {
		22005006,
		0,
		Lang.get(49199),
		22005,
		6,
		387,
		{
			RTResTalkAction[8],
			RTResTalkAction[4]
		}
	},
	[22005007] = {
		22005007,
		0,
		Lang.get(49200),
		22005,
		7,
		387,
		{
			RTResTalkAction[8]
		}
	},
	[22005008] = {
		22005008,
		0,
		Lang.get(49201),
		22005,
		8,
		107,
		{
			RTResTalkAction[12]
		},
		1,
		8,
		-1,
		nil,
		nil,
		22022,
		nil,
		1,
		nil,
		nil,
		nil,
		22022
	},
	[22005009] = {
		22005009,
		0,
		Lang.get(49202),
		22005,
		9,
		141,
		nil,
		1,
		0
	},
	[22005010] = {
		22005010,
		0,
		Lang.get(49203),
		22005,
		10,
		141,
		{
			RTResTalkAction[26]
		},
		nil,
		nil,
		3
	},
	[22005011] = {
		22005011,
		0,
		Lang.get(49204),
		22005,
		11,
		107,
		{
			RTResTalkAction[39],
			RTResTalkAction[27]
		}
	},
	[22005012] = {
		22005012,
		0,
		Lang.get(49205),
		22005,
		12,
		387,
		{
			RTResTalkAction[4]
		},
		1,
		4,
		-1,
		nil,
		nil,
		22020,
		nil,
		1,
		nil,
		nil,
		nil,
		22020
	},
	[22005013] = {
		22005013,
		0,
		Lang.get(49206),
		22005,
		13,
		107,
		nil,
		1,
		5
	},
	[22005014] = {
		22005014,
		0,
		Lang.get(49207),
		22005,
		14,
		107,
		nil,
		1,
		6
	},
	[22005015] = {
		22005015,
		0,
		Lang.get(49208),
		22005,
		15,
		107,
		{
			RTResTalkAction[40]
		},
		nil,
		nil,
		3
	},
	[22005016] = {
		22005016,
		0,
		Lang.get(49209),
		22005,
		16,
		107,
		{
			RTResTalkAction[41]
		}
	},
	[22005017] = {
		22005017,
		0,
		Lang.get(49210),
		22005,
		17,
		107,
		{
			RTResTalkAction[23]
		}
	},
	[22005018] = {
		22005018,
		0,
		Lang.get(49211),
		22005,
		18,
		107,
		{
			RTResTalkAction[42]
		}
	},
	[22005019] = {
		22005019,
		0,
		Lang.get(49212),
		22005,
		19,
		107,
		{
			RTResTalkAction[43]
		}
	},
	[22006001] = {
		22006001,
		0,
		Lang.get(49213),
		22006,
		1,
		141,
		nil,
		1,
		0,
		nil,
		nil,
		60,
		22023,
		nil,
		1,
		nil,
		1,
		nil,
		22023
	},
	[22006002] = {
		22006002,
		0,
		Lang.get(49214),
		22006,
		2,
		141,
		{
			RTResTalkAction[44]
		},
		nil,
		nil,
		3
	},
	[22006003] = {
		22006003,
		0,
		Lang.get(49215),
		22006,
		3,
		141,
		{
			RTResTalkAction[45]
		}
	},
	[22006004] = {
		22006004,
		0,
		Lang.get(49216),
		22006,
		4,
		387,
		{
			RTResTalkAction[8],
			RTResTalkAction[27]
		}
	},
	[22006005] = {
		22006005,
		0,
		Lang.get(49217),
		22006,
		5,
		141,
		{
			RTResTalkAction[46],
			RTResTalkAction[12]
		}
	},
	[22006006] = {
		22006006,
		0,
		Lang.get(49218),
		22006,
		6,
		387,
		{
			RTResTalkAction[27]
		},
		1,
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		nil,
		1,
		nil,
		22026
	},
	[22006007] = {
		22006007,
		0,
		Lang.get(49219),
		22006,
		7,
		387,
		nil,
		1,
		0
	},
	[22006008] = {
		22006008,
		0,
		Lang.get(49220),
		22006,
		8,
		387,
		nil,
		1,
		3,
		-1,
		nil,
		44,
		22024,
		nil,
		nil,
		nil,
		1,
		nil,
		22024
	},
	[22006009] = {
		22006009,
		0,
		Lang.get(49221),
		22006,
		9,
		387,
		nil,
		1,
		4
	},
	[22006010] = {
		22006010,
		0,
		Lang.get(49222),
		22006,
		10,
		387,
		nil,
		1,
		5
	},
	[22006011] = {
		22006011,
		0,
		Lang.get(49223),
		22006,
		11,
		387,
		nil,
		1
	},
	[22006012] = {
		22006012,
		0,
		Lang.get(49224),
		22006,
		12,
		141,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		22023,
		nil,
		nil,
		nil,
		1,
		nil,
		22023
	},
	[22006013] = {
		22006013,
		0,
		Lang.get(49225),
		22006,
		13,
		141,
		nil,
		1
	},
	[22006014] = {
		22006014,
		0,
		Lang.get(49226),
		22006,
		14,
		141,
		{
			RTResTalkAction[47]
		},
		nil,
		nil,
		3
	},
	[22006015] = {
		22006015,
		0,
		Lang.get(49227),
		22006,
		15,
		141,
		{
			RTResTalkAction[26]
		}
	},
	[22006016] = {
		22006016,
		0,
		Lang.get(49228),
		22006,
		16,
		141,
		{
			RTResTalkAction[48]
		}
	},
	[22006017] = {
		22006017,
		0,
		Lang.get(49229),
		22006,
		17,
		141,
		{
			RTResTalkAction[26]
		}
	},
	[22006018] = {
		22006018,
		0,
		Lang.get(49230),
		22006,
		18,
		134,
		{
			RTResTalkAction[49],
			RTResTalkAction[27]
		}
	},
	[22006019] = {
		22006019,
		0,
		Lang.get(49231),
		22006,
		19,
		141,
		{
			RTResTalkAction[26],
			RTResTalkAction[15]
		}
	},
	[22006020] = {
		22006020,
		0,
		Lang.get(49232),
		22006,
		20,
		387,
		{
			RTResTalkAction[50],
			RTResTalkAction[27]
		}
	},
	[22006021] = {
		22006021,
		0,
		Lang.get(49233),
		22006,
		21,
		387,
		{
			RTResTalkAction[51]
		}
	},
	[22007001] = {
		22007001,
		0,
		Lang.get(49234),
		22007,
		1,
		134,
		nil,
		1,
		2,
		nil,
		nil,
		62,
		22028,
		1.2,
		nil,
		nil,
		1,
		nil,
		22028
	},
	[22007002] = {
		22007002,
		0,
		Lang.get(49235),
		22007,
		2,
		141,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		22025,
		nil,
		nil,
		nil,
		1,
		nil,
		22025
	},
	[22007003] = {
		22007003,
		0,
		Lang.get(20129),
		22007,
		3,
		387,
		nil,
		1,
		3
	},
	[22007004] = {
		22007004,
		0,
		Lang.get(49236),
		22007,
		4,
		107,
		nil,
		1,
		8,
		nil,
		nil,
		nil,
		22111,
		nil,
		nil,
		nil,
		nil,
		nil,
		22111
	},
	[22007005] = {
		22007005,
		0,
		Lang.get(49237),
		22007,
		5,
		107,
		nil,
		1,
		1
	},
	[22007006] = {
		22007006,
		0,
		Lang.get(49238),
		22007,
		6,
		134,
		nil,
		1,
		3,
		nil,
		nil,
		nil,
		22027,
		nil,
		nil,
		nil,
		1,
		nil,
		22027
	},
	[22007007] = {
		22007007,
		5,
		Lang.get(49239),
		22007,
		7,
		107,
		nil,
		1,
		3,
		nil,
		nil,
		nil,
		22112,
		nil,
		nil,
		nil,
		nil,
		nil,
		22112
	},
	[22007008] = {
		22007008,
		0,
		Lang.get(49240),
		22007,
		8,
		134,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22027,
		[19] = 22027
	},
	[22007009] = {
		22007009,
		0,
		Lang.get(49241),
		22007,
		9,
		134,
		nil,
		1,
		3
	},
	[22007010] = {
		22007010,
		0,
		Lang.get(49242),
		22007,
		10,
		107,
		nil,
		1,
		3,
		nil,
		nil,
		nil,
		22112,
		nil,
		nil,
		nil,
		nil,
		nil,
		22112
	},
	[22008001] = {
		22008001,
		5,
		Lang.get(49243),
		22008,
		1,
		134,
		nil,
		1,
		3,
		nil,
		nil,
		51,
		22032,
		nil,
		nil,
		nil,
		1,
		nil,
		22032
	},
	[22008002] = {
		22008002,
		0,
		Lang.get(49244),
		22008,
		2,
		387,
		nil,
		1,
		1
	},
	[22008003] = {
		22008003,
		0,
		Lang.get(49245),
		22008,
		3,
		107,
		nil,
		1,
		1,
		[19] = 22029,
		[17] = 1
	},
	[22008004] = {
		22008004,
		0,
		Lang.get(49246),
		22008,
		4,
		134,
		nil,
		1,
		3
	},
	[22008005] = {
		22008005,
		0,
		Lang.get(49247),
		22008,
		5,
		134,
		nil,
		1,
		4
	},
	[22008006] = {
		22008006,
		0,
		Lang.get(49248),
		22008,
		6,
		134,
		nil,
		1,
		2
	},
	[22008007] = {
		22008007,
		0,
		Lang.get(49249),
		22008,
		7,
		387,
		nil,
		1,
		3
	},
	[22008008] = {
		22008008,
		0,
		Lang.get(49250),
		22008,
		8,
		387,
		nil,
		1,
		0
	},
	[22008009] = {
		22008009,
		0,
		Lang.get(49251),
		22008,
		9,
		107,
		nil,
		1,
		8,
		nil,
		nil,
		nil,
		22012,
		nil,
		nil,
		nil,
		1,
		nil,
		22012
	},
	[22008010] = {
		22008010,
		0,
		Lang.get(49252),
		22008,
		10,
		141,
		nil,
		1,
		0
	},
	[22008011] = {
		22008011,
		0,
		Lang.get(49253),
		22008,
		11,
		141,
		nil,
		1
	},
	[22009001] = {
		22009001,
		0,
		Lang.get(49254),
		22009,
		1,
		134,
		nil,
		1,
		3,
		nil,
		nil,
		57,
		22030,
		nil,
		nil,
		nil,
		1,
		nil,
		22030
	},
	[22009002] = {
		22009002,
		0,
		Lang.get(49255),
		22009,
		2,
		134,
		nil,
		1,
		0
	},
	[22009003] = {
		22009003,
		0,
		Lang.get(49256),
		22009,
		3,
		107,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		22031,
		nil,
		nil,
		nil,
		nil,
		nil,
		22031
	},
	[22009004] = {
		22009004,
		0,
		Lang.get(49257),
		22009,
		4,
		387,
		nil,
		1,
		1
	},
	[22009005] = {
		22009005,
		5,
		Lang.get(49258),
		22009,
		5,
		107,
		{
			RTResTalkAction[52]
		},
		nil,
		nil,
		3
	},
	[22009006] = {
		22009006,
		0,
		Lang.get(49259),
		22009,
		6,
		107,
		{
			RTResTalkAction[53]
		}
	},
	[22009007] = {
		22009007,
		0,
		Lang.get(49260),
		22009,
		7,
		387,
		{
			RTResTalkAction[54],
			RTResTalkAction[4]
		}
	},
	[22009008] = {
		22009008,
		0,
		Lang.get(49261),
		22009,
		8,
		107,
		{
			RTResTalkAction[55],
			RTResTalkAction[12]
		}
	},
	[22009009] = {
		22009009,
		0,
		Lang.get(49262),
		22009,
		9,
		387,
		{
			RTResTalkAction[50],
			RTResTalkAction[4]
		}
	},
	[22009010] = {
		22009010,
		0,
		Lang.get(49263),
		22009,
		10,
		387,
		{
			RTResTalkAction[56]
		}
	},
	[22009011] = {
		22009011,
		0,
		Lang.get(49264),
		22009,
		11,
		141,
		{
			RTResTalkAction[26],
			RTResTalkAction[12]
		}
	},
	[22009012] = {
		22009012,
		0,
		Lang.get(49265),
		22009,
		12,
		107,
		{
			RTResTalkAction[43],
			RTResTalkAction[27]
		}
	},
	[22009013] = {
		22009013,
		0,
		Lang.get(49266),
		22009,
		13,
		141,
		{
			RTResTalkAction[26],
			RTResTalkAction[4]
		}
	},
	[22009014] = {
		22009014,
		0,
		Lang.get(49267),
		22009,
		14,
		141,
		{
			RTResTalkAction[26]
		}
	},
	[22009015] = {
		22009015,
		0,
		Lang.get(49268),
		22009,
		15,
		141,
		{
			RTResTalkAction[57]
		}
	},
	[22009016] = {
		22009016,
		0,
		Lang.get(49269),
		22009,
		16,
		134,
		{
			RTResTalkAction[38],
			RTResTalkAction[27]
		}
	},
	[22010001] = {
		22010001,
		0,
		Lang.get(49270),
		22010,
		1,
		134,
		nil,
		1,
		1,
		nil,
		nil,
		69,
		22033,
		1,
		2,
		nil,
		nil,
		nil,
		22033
	},
	[22010002] = {
		22010002,
		0,
		Lang.get(49271),
		22010,
		2,
		134,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		22034,
		nil,
		nil,
		nil,
		1,
		nil,
		22034
	},
	[22010003] = {
		22010003,
		0,
		Lang.get(49272),
		22010,
		3,
		107,
		nil,
		1,
		3,
		nil,
		nil,
		nil,
		22035,
		nil,
		nil,
		nil,
		nil,
		nil,
		22035
	},
	[22010004] = {
		22010004,
		0,
		Lang.get(49273),
		22010,
		4,
		387,
		nil,
		1,
		4,
		nil,
		nil,
		nil,
		22036,
		nil,
		nil,
		nil,
		nil,
		nil,
		22036
	},
	[22010005] = {
		22010005,
		0,
		Lang.get(49274),
		22010,
		5,
		107,
		{
			RTResTalkAction[58]
		},
		nil,
		nil,
		3
	},
	[22010006] = {
		22010006,
		0,
		Lang.get(49275),
		22010,
		6,
		141,
		{
			RTResTalkAction[30],
			RTResTalkAction[4]
		}
	},
	[22010007] = {
		22010007,
		0,
		Lang.get(20200),
		22010,
		7,
		387,
		{
			RTResTalkAction[34],
			RTResTalkAction[27]
		}
	},
	[22010008] = {
		22010008,
		0,
		Lang.get(49276),
		22010,
		8,
		107,
		{
			RTResTalkAction[39],
			RTResTalkAction[12]
		}
	},
	[22011001] = {
		22011001,
		0,
		Lang.get(49277),
		22011,
		1,
		107,
		nil,
		1,
		3,
		nil,
		nil,
		69,
		22037,
		nil,
		nil,
		nil,
		1,
		nil,
		22037
	},
	[22011002] = {
		22011002,
		0,
		Lang.get(49278),
		22011,
		2,
		3,
		nil,
		1,
		0,
		nil,
		1231,
		nil,
		22038,
		nil,
		nil,
		nil,
		nil,
		nil,
		22038
	},
	[22011003] = {
		22011003,
		0,
		Lang.get(49279),
		22011,
		3,
		107,
		nil,
		1,
		3,
		nil,
		nil,
		nil,
		22039,
		nil,
		nil,
		nil,
		nil,
		nil,
		22039
	},
	[22011004] = {
		22011004,
		0,
		Lang.get(42598),
		22011,
		4,
		3,
		nil,
		1,
		0,
		nil,
		1070,
		nil,
		22040
	},
	[22011005] = {
		22011005,
		0,
		Lang.get(49280),
		22011,
		5,
		107,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		22124,
		nil,
		nil,
		nil,
		nil,
		nil,
		22124
	},
	[22011006] = {
		22011006,
		0,
		Lang.get(49281),
		22011,
		6,
		107,
		nil,
		1,
		8,
		[19] = 22125
	},
	[22011007] = {
		22011007,
		0,
		Lang.get(49282),
		22011,
		7,
		141,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		22041,
		1,
		nil,
		nil,
		0,
		nil,
		22041
	},
	[22011008] = {
		22011008,
		5,
		Lang.get(49283),
		22011,
		8,
		107,
		{
			RTResTalkAction[59]
		},
		nil,
		nil,
		3
	},
	[22011009] = {
		22011009,
		0,
		Lang.get(49284),
		22011,
		9,
		141,
		{
			RTResTalkAction[46],
			RTResTalkAction[4]
		}
	},
	[22011010] = {
		22011010,
		0,
		Lang.get(49285),
		22011,
		10,
		141,
		{
			RTResTalkAction[26]
		}
	},
	[22011011] = {
		22011011,
		0,
		Lang.get(49286),
		22011,
		11,
		107,
		{
			RTResTalkAction[60],
			RTResTalkAction[27]
		}
	},
	[22011012] = {
		22011012,
		0,
		Lang.get(49287),
		22011,
		12,
		387,
		{
			RTResTalkAction[56],
			RTResTalkAction[4]
		}
	},
	[22011013] = {
		22011013,
		5,
		Lang.get(49118),
		22011,
		13,
		3,
		{
			RTResTalkAction[61],
			RTResTalkAction[12]
		},
		nil,
		nil,
		nil,
		1070
	},
	[22011014] = {
		22011014,
		0,
		Lang.get(49288),
		22011,
		14,
		107,
		{
			RTResTalkAction[62]
		},
		1,
		5,
		nil,
		nil,
		nil,
		22042,
		1,
		1,
		nil,
		1,
		nil,
		22042
	},
	[22011015] = {
		22011015,
		0,
		Lang.get(49289),
		22011,
		15,
		134,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		22043,
		nil,
		nil,
		nil,
		nil,
		nil,
		22043
	},
	[22011016] = {
		22011016,
		0,
		Lang.get(49290),
		22011,
		16,
		141,
		nil,
		1,
		1
	},
	[22011017] = {
		22011017,
		0,
		Lang.get(49291),
		22011,
		17,
		107,
		nil,
		1,
		7,
		[19] = 22044
	},
	[22011018] = {
		22011018,
		0,
		Lang.get(42598),
		22011,
		18,
		3,
		nil,
		1,
		0,
		nil,
		1070
	},
	[22011019] = {
		22011019,
		3,
		Lang.get(49292),
		22011,
		19,
		3,
		nil,
		nil,
		nil,
		nil,
		1230,
		nil,
		22045,
		nil,
		nil,
		nil,
		1,
		nil,
		22045,
		nil,
		nil,
		1
	},
	[22011020] = {
		22011020,
		0,
		Lang.get(49293),
		22011,
		20,
		107,
		nil,
		1,
		8,
		nil,
		nil,
		nil,
		22046,
		nil,
		nil,
		nil,
		nil,
		nil,
		22046
	},
	[22011021] = {
		22011021,
		0,
		Lang.get(49294),
		22011,
		21,
		134,
		nil,
		1,
		3
	},
	[22011022] = {
		22011022,
		0,
		Lang.get(49295),
		22011,
		22,
		134,
		nil,
		1
	},
	[22011023] = {
		22011023,
		0,
		Lang.get(49296),
		22011,
		23,
		134,
		nil,
		1,
		4
	},
	[22011024] = {
		22011024,
		0,
		Lang.get(49118),
		22011,
		24,
		3,
		nil,
		1,
		0,
		nil,
		1070
	},
	[22011025] = {
		22011025,
		0,
		Lang.get(49297),
		22011,
		25,
		134,
		nil,
		1,
		3,
		nil,
		nil,
		nil,
		22125
	},
	[22012001] = {
		22012001,
		0,
		Lang.get(49298),
		22012,
		1,
		107,
		nil,
		1,
		1,
		nil,
		nil,
		138,
		22047,
		nil,
		nil,
		nil,
		1,
		nil,
		22047
	},
	[22012002] = {
		22012002,
		0,
		Lang.get(49299),
		22012,
		2,
		141,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		22048,
		nil,
		nil,
		nil,
		nil,
		nil,
		22048
	},
	[22012003] = {
		22012003,
		0,
		Lang.get(49300),
		22012,
		3,
		107,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		22049,
		nil,
		nil,
		nil,
		0,
		nil,
		22049
	},
	[22012004] = {
		22012004,
		0,
		Lang.get(49301),
		22012,
		4,
		107,
		nil,
		1,
		3
	},
	[22012005] = {
		22012005,
		0,
		Lang.get(49302),
		22012,
		5,
		387,
		nil,
		1,
		5,
		nil,
		nil,
		nil,
		22050,
		nil,
		nil,
		nil,
		1,
		nil,
		22050
	},
	[22012006] = {
		22012006,
		0,
		Lang.get(49303),
		22012,
		6,
		387,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		22051,
		nil,
		nil,
		nil,
		nil,
		nil,
		22051
	},
	[22012007] = {
		22012007,
		0,
		Lang.get(49304),
		22012,
		7,
		387,
		nil,
		1,
		0
	},
	[22012008] = {
		22012008,
		0,
		Lang.get(49305),
		22012,
		8,
		107,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		22052,
		nil,
		nil,
		nil,
		nil,
		nil,
		22052
	},
	[22012009] = {
		22012009,
		0,
		Lang.get(49306),
		22012,
		9,
		387,
		nil,
		1,
		0
	},
	[22012010] = {
		22012010,
		0,
		Lang.get(49118),
		22012,
		10,
		3,
		nil,
		1,
		nil,
		nil,
		1070,
		nil,
		22053,
		nil,
		nil,
		nil,
		nil,
		nil,
		22053
	},
	[22012011] = {
		22012011,
		0,
		Lang.get(49307),
		22012,
		11,
		107,
		nil,
		1,
		1
	},
	[22012012] = {
		22012012,
		0,
		Lang.get(49308),
		22012,
		12,
		107,
		nil,
		1,
		3,
		nil,
		nil,
		nil,
		22054,
		nil,
		nil,
		nil,
		nil,
		nil,
		22054
	},
	[22012013] = {
		22012013,
		3,
		Lang.get(49309),
		22012,
		13,
		107,
		nil,
		nil,
		nil,
		nil,
		1220,
		nil,
		22055,
		1,
		nil,
		nil,
		nil,
		nil,
		22055,
		nil,
		nil,
		1
	},
	[22012014] = {
		22012014,
		0,
		Lang.get(49310),
		22012,
		14,
		387,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		22056,
		nil,
		nil,
		nil,
		nil,
		nil,
		22056
	},
	[22012015] = {
		22012015,
		0,
		Lang.get(49311),
		22012,
		15,
		141,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		22057,
		nil,
		nil,
		nil,
		nil,
		nil,
		22057
	},
	[22012016] = {
		22012016,
		0,
		Lang.get(49312),
		22012,
		16,
		134,
		nil,
		1,
		3,
		nil,
		nil,
		nil,
		22058,
		nil,
		nil,
		nil,
		nil,
		nil,
		22058
	},
	[22012017] = {
		22012017,
		0,
		Lang.get(49313),
		22012,
		17,
		107,
		nil,
		1,
		5,
		nil,
		nil,
		nil,
		22059,
		2,
		nil,
		nil,
		1,
		nil,
		22059
	},
	[22012018] = {
		22012018,
		0,
		Lang.get(49314),
		22012,
		18,
		107,
		nil,
		1,
		6
	},
	[22012019] = {
		22012019,
		0,
		Lang.get(49315),
		22012,
		19,
		141,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		22060,
		nil,
		nil,
		nil,
		nil,
		nil,
		22060
	},
	[22012020] = {
		22012020,
		0,
		Lang.get(49316),
		22012,
		20,
		107,
		nil,
		1,
		5
	},
	[22012021] = {
		22012021,
		0,
		Lang.get(49317),
		22012,
		21,
		107,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		22061,
		nil,
		nil,
		nil,
		nil,
		nil,
		22061
	},
	[22012022] = {
		22012022,
		0,
		Lang.get(49318),
		22012,
		22,
		387,
		nil,
		1,
		3,
		nil,
		nil,
		nil,
		22062,
		nil,
		nil,
		nil,
		nil,
		nil,
		22062
	},
	[22012023] = {
		22012023,
		0,
		Lang.get(49319),
		22012,
		23,
		107,
		nil,
		1,
		1
	},
	[22012024] = {
		22012024,
		0,
		Lang.get(49320),
		22012,
		24,
		387,
		nil,
		1,
		4
	},
	[22012025] = {
		22012025,
		0,
		Lang.get(49321),
		22012,
		25,
		107,
		nil,
		1,
		5
	},
	[22013001] = {
		22013001,
		0,
		Lang.get(49322),
		22013,
		1,
		141,
		nil,
		1,
		0,
		nil,
		nil,
		63,
		22063,
		nil,
		nil,
		nil,
		nil,
		nil,
		22063
	},
	[22013002] = {
		22013002,
		0,
		Lang.get(49323),
		22013,
		2,
		107,
		nil,
		1
	},
	[22013003] = {
		22013003,
		0,
		Lang.get(16985),
		22013,
		3,
		141,
		{
			RTResTalkAction[63]
		},
		nil,
		nil,
		3
	},
	[22013004] = {
		22013004,
		0,
		Lang.get(49324),
		22013,
		4,
		107,
		{
			RTResTalkAction[64],
			RTResTalkAction[65]
		}
	},
	[22013005] = {
		22013005,
		0,
		Lang.get(49325),
		22013,
		5,
		141,
		{
			RTResTalkAction[26],
			RTResTalkAction[4]
		}
	},
	[22013006] = {
		22013006,
		0,
		Lang.get(49326),
		22013,
		6,
		387,
		{
			RTResTalkAction[34],
			RTResTalkAction[27]
		}
	},
	[22013007] = {
		22013007,
		0,
		Lang.get(49327),
		22013,
		7,
		141,
		{
			RTResTalkAction[26],
			RTResTalkAction[12]
		}
	},
	[22013008] = {
		22013008,
		0,
		Lang.get(49328),
		22013,
		8,
		107,
		{
			RTResTalkAction[27]
		},
		1,
		5,
		-1,
		nil,
		nil,
		22064,
		nil,
		1,
		nil,
		1,
		nil,
		22064
	},
	[22013009] = {
		22013009,
		0,
		Lang.get(22255),
		22013,
		9,
		3,
		nil,
		1,
		0,
		nil,
		1231
	},
	[22013010] = {
		22013010,
		0,
		Lang.get(49329),
		22013,
		10,
		107,
		nil,
		1,
		6
	},
	[22013011] = {
		22013011,
		0,
		Lang.get(49330),
		22013,
		11,
		107,
		nil,
		1,
		5
	},
	[22013012] = {
		22013012,
		0,
		Lang.get(49331),
		22013,
		12,
		387,
		{
			RTResTalkAction[54]
		},
		nil,
		nil,
		3
	},
	[22013013] = {
		22013013,
		0,
		Lang.get(49332),
		22013,
		13,
		107,
		{
			RTResTalkAction[66],
			RTResTalkAction[12]
		}
	},
	[22013014] = {
		22013014,
		0,
		Lang.get(49333),
		22013,
		14,
		387,
		{
			RTResTalkAction[56],
			RTResTalkAction[4]
		}
	},
	[22013015] = {
		22013015,
		0,
		Lang.get(49334),
		22013,
		15,
		107,
		{
			RTResTalkAction[67],
			RTResTalkAction[12]
		}
	},
	[22013016] = {
		22013016,
		0,
		Lang.get(49335),
		22013,
		16,
		134,
		{
			RTResTalkAction[68],
			RTResTalkAction[4]
		}
	},
	[22013017] = {
		22013017,
		0,
		Lang.get(49336),
		22013,
		17,
		134,
		{
			RTResTalkAction[33]
		}
	},
	[22013018] = {
		22013018,
		0,
		Lang.get(49337),
		22013,
		18,
		107,
		{
			RTResTalkAction[69],
			RTResTalkAction[15]
		}
	},
	[22013019] = {
		22013019,
		0,
		Lang.get(49338),
		22013,
		19,
		107,
		{
			RTResTalkAction[66]
		}
	},
	[22013020] = {
		22013020,
		0,
		Lang.get(49339),
		22013,
		20,
		141,
		{
			RTResTalkAction[70],
			RTResTalkAction[4]
		}
	},
	[22013021] = {
		22013021,
		0,
		Lang.get(49340),
		22013,
		21,
		141,
		{
			RTResTalkAction[71]
		}
	},
	[22013022] = {
		22013022,
		0,
		Lang.get(49341),
		22013,
		22,
		141,
		{
			RTResTalkAction[30]
		}
	},
	[22013023] = {
		22013023,
		0,
		Lang.get(49342),
		22013,
		23,
		141,
		{
			RTResTalkAction[29]
		}
	},
	[22013024] = {
		22013024,
		0,
		Lang.get(49343),
		22013,
		24,
		141,
		{
			RTResTalkAction[30]
		}
	},
	[22013025] = {
		22013025,
		0,
		Lang.get(49344),
		22013,
		25,
		107,
		{
			RTResTalkAction[39],
			RTResTalkAction[27]
		}
	},
	[22013026] = {
		22013026,
		0,
		Lang.get(49345),
		22013,
		26,
		107,
		{
			RTResTalkAction[42]
		}
	},
	[22013027] = {
		22013027,
		0,
		Lang.get(49346),
		22013,
		27,
		107,
		{
			RTResTalkAction[72]
		}
	},
	[22013028] = {
		22013028,
		0,
		Lang.get(18644),
		22013,
		28,
		141,
		{
			RTResTalkAction[73],
			RTResTalkAction[4]
		}
	},
	[22013029] = {
		22013029,
		0,
		Lang.get(49347),
		22013,
		29,
		107,
		{
			RTResTalkAction[23],
			RTResTalkAction[27]
		}
	},
	[22013030] = {
		22013030,
		0,
		Lang.get(49348),
		22013,
		30,
		134,
		{
			RTResTalkAction[68],
			RTResTalkAction[4]
		}
	},
	[22013031] = {
		22013031,
		0,
		Lang.get(49349),
		22013,
		31,
		134,
		{
			RTResTalkAction[74]
		}
	},
	[22013032] = {
		22013032,
		0,
		Lang.get(49350),
		22013,
		32,
		134,
		{
			RTResTalkAction[38]
		}
	},
	[22013033] = {
		22013033,
		0,
		Lang.get(49351),
		22013,
		33,
		134,
		{
			RTResTalkAction[75]
		}
	},
	[22013034] = {
		22013034,
		0,
		Lang.get(49352),
		22013,
		34,
		107,
		{
			RTResTalkAction[55],
			RTResTalkAction[15]
		}
	},
	[22013035] = {
		22013035,
		0,
		Lang.get(49353),
		22013,
		35,
		134,
		{
			RTResTalkAction[74],
			RTResTalkAction[4]
		}
	},
	[22014001] = {
		22014001,
		13,
		nil,
		22014,
		1,
		134,
		{
			RTResTalkAction[76]
		},
		nil,
		nil,
		nil,
		nil,
		62,
		22065,
		nil,
		1,
		nil,
		1,
		nil,
		22065,
		220,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[22014002] = {
		22014002,
		13,
		Lang.get(49354),
		22014,
		2,
		134,
		{
			RTResTalkAction[76]
		},
		1,
		2,
		[27] = 3
	},
	[22014003] = {
		22014003,
		13,
		Lang.get(49355),
		22014,
		3,
		388,
		{
			RTResTalkAction[77]
		},
		[27] = 3
	},
	[22014004] = {
		22014004,
		13,
		Lang.get(49356),
		22014,
		4,
		388,
		{
			RTResTalkAction[78]
		},
		[27] = 3
	},
	[22014005] = {
		22014005,
		13,
		Lang.get(49357),
		22014,
		5,
		134,
		{
			RTResTalkAction[76]
		},
		1,
		0,
		[27] = 3
	},
	[22014006] = {
		22014006,
		13,
		Lang.get(49358),
		22014,
		6,
		388,
		{
			RTResTalkAction[79]
		},
		[27] = 3
	},
	[22014007] = {
		22014007,
		13,
		Lang.get(49359),
		22014,
		7,
		134,
		{
			RTResTalkAction[76]
		},
		1,
		2,
		[27] = 3
	},
	[22014008] = {
		22014008,
		13,
		Lang.get(49360),
		22014,
		8,
		388,
		{
			RTResTalkAction[80]
		},
		[27] = 3
	},
	[22014009] = {
		22014009,
		13,
		Lang.get(49361),
		22014,
		9,
		388,
		{
			RTResTalkAction[81]
		},
		[27] = 3
	},
	[22014010] = {
		22014010,
		13,
		Lang.get(49362),
		22014,
		10,
		388,
		{
			RTResTalkAction[82]
		},
		[27] = 3
	},
	[22014011] = {
		22014011,
		13,
		Lang.get(49363),
		22014,
		11,
		134,
		{
			RTResTalkAction[76]
		},
		1,
		4,
		[27] = 3
	},
	[22014012] = {
		22014012,
		3,
		Lang.get(49364),
		22014,
		12,
		134,
		{
			RTResTalkAction[83]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		22066,
		nil,
		1,
		nil,
		1,
		nil,
		22066,
		-1,
		nil,
		1
	},
	[22014013] = {
		22014013,
		13,
		Lang.get(51856),
		22014,
		13,
		216,
		{
			RTResTalkAction[84]
		},
		1,
		1,
		[27] = 3,
		[20] = 220
	},
	[22014014] = {
		22014014,
		13,
		Lang.get(49366),
		22014,
		14,
		366,
		{
			RTResTalkAction[85]
		},
		[27] = 3
	},
	[22014015] = {
		22014015,
		13,
		Lang.get(49367),
		22014,
		15,
		216,
		{
			RTResTalkAction[84]
		},
		1,
		3,
		[27] = 3
	},
	[22014016] = {
		22014016,
		13,
		Lang.get(49368),
		22014,
		16,
		366,
		{
			RTResTalkAction[86]
		},
		[27] = 3
	},
	[22014017] = {
		22014017,
		13,
		Lang.get(49369),
		22014,
		17,
		366,
		{
			RTResTalkAction[87]
		},
		[27] = 3
	},
	[22014018] = {
		22014018,
		13,
		Lang.get(49370),
		22014,
		18,
		216,
		{
			RTResTalkAction[84]
		},
		1,
		1,
		[27] = 3
	},
	[22014019] = {
		22014019,
		13,
		Lang.get(49371),
		22014,
		19,
		366,
		{
			RTResTalkAction[84]
		},
		[27] = 3
	},
	[22014020] = {
		22014020,
		13,
		Lang.get(49372),
		22014,
		20,
		366,
		{
			RTResTalkAction[88]
		},
		[27] = 3
	},
	[22014021] = {
		22014021,
		13,
		Lang.get(49373),
		22014,
		21,
		216,
		{
			RTResTalkAction[84]
		},
		1,
		0,
		[27] = 3
	},
	[22014022] = {
		22014022,
		13,
		Lang.get(49374),
		22014,
		22,
		216,
		{
			RTResTalkAction[84]
		},
		1,
		1,
		[27] = 3
	},
	[22014023] = {
		22014023,
		13,
		Lang.get(49375),
		22014,
		23,
		216,
		{
			RTResTalkAction[84]
		},
		1,
		3,
		[27] = 3
	},
	[22014024] = {
		22014024,
		13,
		Lang.get(49376),
		22014,
		24,
		366,
		{
			RTResTalkAction[89]
		},
		[27] = 3
	},
	[22014025] = {
		22014025,
		13,
		Lang.get(49377),
		22014,
		25,
		366,
		{
			RTResTalkAction[90]
		},
		[27] = 3
	},
	[22014026] = {
		22014026,
		13,
		Lang.get(49378),
		22014,
		26,
		216,
		{
			RTResTalkAction[84]
		},
		1,
		3,
		[27] = 3
	},
	[22014027] = {
		22014027,
		13,
		Lang.get(49379),
		22014,
		27,
		134,
		{
			RTResTalkAction[76],
			RTResTalkAction[91]
		},
		1,
		2,
		nil,
		nil,
		nil,
		22065,
		nil,
		1,
		nil,
		1,
		nil,
		22065,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		3
	},
	[22014028] = {
		22014028,
		13,
		Lang.get(49380),
		22014,
		28,
		388,
		{
			RTResTalkAction[92]
		},
		[27] = 3
	},
	[22014029] = {
		22014029,
		13,
		Lang.get(49381),
		22014,
		29,
		134,
		{
			RTResTalkAction[76]
		},
		1,
		1,
		[27] = 4
	},
	[22015001] = {
		22015001,
		0,
		Lang.get(49382),
		22015,
		1,
		107,
		nil,
		1,
		5,
		nil,
		nil,
		48,
		22067,
		nil,
		nil,
		nil,
		1,
		nil,
		22067
	},
	[22015002] = {
		22015002,
		0,
		Lang.get(49383),
		22015,
		2,
		134,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		22068,
		nil,
		nil,
		nil,
		nil,
		nil,
		22068
	},
	[22015003] = {
		22015003,
		0,
		Lang.get(49384),
		22015,
		3,
		107,
		{
			RTResTalkAction[93]
		},
		nil,
		nil,
		3
	},
	[22015004] = {
		22015004,
		0,
		Lang.get(49385),
		22015,
		4,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[4]
		}
	},
	[22015005] = {
		22015005,
		0,
		Lang.get(49386),
		22015,
		5,
		387,
		{
			RTResTalkAction[50],
			RTResTalkAction[27]
		}
	},
	[22015006] = {
		22015006,
		0,
		Lang.get(49387),
		22015,
		6,
		107,
		{
			RTResTalkAction[23],
			RTResTalkAction[12]
		}
	},
	[22015007] = {
		22015007,
		0,
		Lang.get(49388),
		22015,
		7,
		141,
		{
			RTResTalkAction[44],
			RTResTalkAction[4]
		}
	},
	[22015008] = {
		22015008,
		5,
		Lang.get(49389),
		22015,
		8,
		134,
		{
			RTResTalkAction[94],
			RTResTalkAction[27]
		}
	},
	[22015009] = {
		22015009,
		2,
		Lang.get(49390),
		22015,
		9,
		134,
		{
			RTResTalkAction[33]
		}
	},
	[22015010] = {
		22015010,
		0,
		Lang.get(49391),
		22015,
		10,
		134,
		{
			RTResTalkAction[38]
		}
	},
	[22015011] = {
		22015011,
		0,
		Lang.get(49392),
		22015,
		11,
		134,
		{
			RTResTalkAction[15]
		},
		1,
		2,
		nil,
		nil,
		nil,
		22069,
		nil,
		1,
		nil,
		1,
		nil,
		22069
	},
	[22015012] = {
		22015012,
		0,
		Lang.get(49393),
		22015,
		12,
		134,
		nil,
		1,
		0
	},
	[22015013] = {
		22015013,
		0,
		Lang.get(49394),
		22015,
		13,
		107,
		{
			RTResTalkAction[43]
		},
		nil,
		nil,
		3
	},
	[22015014] = {
		22015014,
		0,
		Lang.get(49395),
		22015,
		14,
		387,
		{
			RTResTalkAction[95],
			RTResTalkAction[4]
		}
	},
	[22015015] = {
		22015015,
		0,
		Lang.get(49396),
		22015,
		15,
		134,
		{
			RTResTalkAction[75],
			RTResTalkAction[12]
		}
	},
	[22015016] = {
		22015016,
		0,
		Lang.get(49397),
		22015,
		16,
		107,
		{
			RTResTalkAction[96],
			RTResTalkAction[15]
		}
	},
	[22015017] = {
		22015017,
		0,
		Lang.get(49398),
		22015,
		17,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[4]
		}
	},
	[22015018] = {
		22015018,
		0,
		Lang.get(49399),
		22015,
		18,
		141,
		{
			RTResTalkAction[26]
		}
	},
	[22015019] = {
		22015019,
		0,
		Lang.get(49400),
		22015,
		19,
		107,
		{
			RTResTalkAction[93],
			RTResTalkAction[27]
		}
	},
	[22015020] = {
		22015020,
		0,
		Lang.get(24226),
		22015,
		20,
		387,
		{
			RTResTalkAction[50],
			RTResTalkAction[4]
		}
	},
	[22015021] = {
		22015021,
		0,
		Lang.get(49401),
		22015,
		21,
		107,
		{
			RTResTalkAction[12]
		},
		1,
		1,
		-1,
		nil,
		nil,
		22070,
		nil,
		1,
		nil,
		0,
		nil,
		22070
	},
	[22015022] = {
		22015022,
		0,
		Lang.get(49402),
		22015,
		22,
		107,
		nil,
		1,
		8
	},
	[22015023] = {
		22015023,
		0,
		Lang.get(49403),
		22015,
		23,
		107,
		nil,
		1,
		3,
		nil,
		nil,
		nil,
		22071,
		nil,
		nil,
		nil,
		1,
		nil,
		22071
	},
	[22015024] = {
		22015024,
		0,
		Lang.get(49404),
		22015,
		24,
		387,
		nil,
		1,
		1
	},
	[22015025] = {
		22015025,
		0,
		Lang.get(49405),
		22015,
		25,
		134,
		{
			RTResTalkAction[75]
		},
		nil,
		nil,
		3
	},
	[22015026] = {
		22015026,
		0,
		Lang.get(49406),
		22015,
		26,
		107,
		{
			RTResTalkAction[97],
			RTResTalkAction[15]
		}
	},
	[22015027] = {
		22015027,
		0,
		Lang.get(49407),
		22015,
		27,
		107,
		{
			RTResTalkAction[98]
		}
	},
	[22015028] = {
		22015028,
		0,
		Lang.get(49408),
		22015,
		28,
		134,
		{
			RTResTalkAction[68],
			RTResTalkAction[4]
		}
	},
	[22015029] = {
		22015029,
		5,
		Lang.get(49409),
		22015,
		29,
		107,
		{
			RTResTalkAction[23],
			RTResTalkAction[15]
		}
	},
	[22016001] = {
		22016001,
		0,
		Lang.get(49410),
		22016,
		1,
		107,
		nil,
		1,
		8,
		nil,
		nil,
		60,
		22072,
		1,
		nil,
		nil,
		1,
		nil,
		22072
	},
	[22016002] = {
		22016002,
		0,
		Lang.get(49411),
		22016,
		2,
		134,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		22073,
		nil,
		nil,
		nil,
		nil,
		nil,
		22073
	},
	[22016003] = {
		22016003,
		0,
		Lang.get(49412),
		22016,
		3,
		107,
		{
			RTResTalkAction[55]
		},
		nil,
		nil,
		3
	},
	[22016004] = {
		22016004,
		0,
		Lang.get(49413),
		22016,
		4,
		134,
		{
			RTResTalkAction[94],
			RTResTalkAction[4]
		}
	},
	[22016005] = {
		22016005,
		0,
		Lang.get(49414),
		22016,
		5,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[15]
		}
	},
	[22016006] = {
		22016006,
		0,
		Lang.get(49415),
		22016,
		6,
		141,
		{
			RTResTalkAction[30],
			RTResTalkAction[4]
		}
	},
	[22016007] = {
		22016007,
		0,
		Lang.get(49416),
		22016,
		7,
		107,
		{
			RTResTalkAction[59],
			RTResTalkAction[27]
		}
	},
	[22016008] = {
		22016008,
		0,
		Lang.get(49417),
		22016,
		8,
		107,
		{
			RTResTalkAction[42]
		}
	},
	[22016009] = {
		22016009,
		0,
		Lang.get(49418),
		22016,
		9,
		387,
		{
			RTResTalkAction[50],
			RTResTalkAction[4]
		}
	},
	[22016010] = {
		22016010,
		0,
		Lang.get(49419),
		22016,
		10,
		107,
		{
			RTResTalkAction[12]
		},
		1,
		1,
		nil,
		nil,
		nil,
		22074,
		nil,
		1,
		nil,
		1,
		nil,
		22074
	},
	[22016011] = {
		22016011,
		5,
		Lang.get(49420),
		22016,
		11,
		107,
		nil,
		1,
		3
	},
	[22016012] = {
		22016012,
		0,
		Lang.get(49421),
		22016,
		12,
		107,
		nil,
		1,
		1
	},
	[22016013] = {
		22016013,
		0,
		Lang.get(49422),
		22016,
		13,
		107,
		nil,
		1,
		0
	},
	[22016014] = {
		22016014,
		0,
		Lang.get(49423),
		22016,
		14,
		107,
		nil,
		1,
		3
	},
	[22016015] = {
		22016015,
		0,
		Lang.get(49424),
		22016,
		15,
		107,
		nil,
		1,
		5
	},
	[22016016] = {
		22016016,
		0,
		Lang.get(49425),
		22016,
		16,
		387,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		22075,
		nil,
		nil,
		nil,
		nil,
		nil,
		22075
	},
	[22016017] = {
		22016017,
		0,
		Lang.get(49426),
		22016,
		17,
		107,
		nil,
		1,
		0
	},
	[22016018] = {
		22016018,
		2,
		Lang.get(49427),
		22016,
		18,
		107,
		{
			RTResTalkAction[99]
		},
		nil,
		nil,
		3
	},
	[22016019] = {
		22016019,
		0,
		Lang.get(49428),
		22016,
		19,
		134,
		{
			RTResTalkAction[38],
			RTResTalkAction[4]
		}
	},
	[22016020] = {
		22016020,
		2,
		Lang.get(49429),
		22016,
		20,
		107,
		{
			RTResTalkAction[40],
			RTResTalkAction[15]
		}
	},
	[22016021] = {
		22016021,
		2,
		Lang.get(49430),
		22016,
		21,
		107,
		{
			RTResTalkAction[60]
		}
	},
	[22016022] = {
		22016022,
		2,
		Lang.get(49431),
		22016,
		22,
		107,
		{
			RTResTalkAction[100]
		}
	},
	[22016023] = {
		22016023,
		5,
		Lang.get(49432),
		22016,
		23,
		387,
		{
			RTResTalkAction[34],
			RTResTalkAction[4]
		}
	},
	[22016024] = {
		22016024,
		0,
		Lang.get(49433),
		22016,
		24,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[12]
		}
	},
	[22016025] = {
		22016025,
		0,
		Lang.get(49434),
		22016,
		25,
		107,
		{
			RTResTalkAction[55]
		},
		[19] = 22076
	},
	[22017001] = {
		22017001,
		0,
		Lang.get(49435),
		22017,
		1,
		107,
		nil,
		1,
		3,
		nil,
		nil,
		60,
		22077,
		nil,
		nil,
		nil,
		1,
		nil,
		22077
	},
	[22017002] = {
		22017002,
		0,
		Lang.get(49436),
		22017,
		2,
		387,
		nil,
		1,
		3
	},
	[22017003] = {
		22017003,
		0,
		Lang.get(49437),
		22017,
		3,
		107,
		nil,
		1,
		8
	},
	[22017004] = {
		22017004,
		0,
		Lang.get(49438),
		22017,
		4,
		387,
		nil,
		1,
		1
	},
	[22017005] = {
		22017005,
		0,
		Lang.get(49439),
		22017,
		5,
		107,
		nil,
		1,
		10
	},
	[22017006] = {
		22017006,
		0,
		Lang.get(49440),
		22017,
		6,
		387,
		nil,
		1,
		5
	},
	[22017007] = {
		22017007,
		0,
		Lang.get(49441),
		22017,
		7,
		107,
		nil,
		1,
		0
	},
	[22017008] = {
		22017008,
		0,
		Lang.get(49442),
		22017,
		8,
		141,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		22078,
		nil,
		nil,
		nil,
		1,
		nil,
		22078
	},
	[22017009] = {
		22017009,
		0,
		Lang.get(49443),
		22017,
		9,
		141,
		nil,
		1,
		0
	},
	[22017010] = {
		22017010,
		0,
		Lang.get(49444),
		22017,
		10,
		107,
		{
			RTResTalkAction[59]
		},
		nil,
		nil,
		3
	},
	[22017011] = {
		22017011,
		0,
		Lang.get(49445),
		22017,
		11,
		141,
		{
			RTResTalkAction[101],
			RTResTalkAction[4]
		}
	},
	[22017012] = {
		22017012,
		0,
		Lang.get(49446),
		22017,
		12,
		134,
		{
			RTResTalkAction[68],
			RTResTalkAction[27]
		}
	},
	[22017013] = {
		22017013,
		0,
		Lang.get(49447),
		22017,
		13,
		107,
		{
			RTResTalkAction[53],
			RTResTalkAction[15]
		}
	},
	[22017014] = {
		22017014,
		0,
		Lang.get(49448),
		22017,
		14,
		107,
		{
			RTResTalkAction[58]
		}
	},
	[22017015] = {
		22017015,
		0,
		Lang.get(49449),
		22017,
		15,
		134,
		{
			RTResTalkAction[75],
			RTResTalkAction[4]
		}
	},
	[22017016] = {
		22017016,
		0,
		Lang.get(49450),
		22017,
		16,
		107,
		{
			RTResTalkAction[15]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		22079,
		nil,
		1,
		nil,
		nil,
		nil,
		22079
	},
	[22017017] = {
		22017017,
		0,
		Lang.get(49451),
		22017,
		17,
		216,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		22080,
		nil,
		nil,
		nil,
		nil,
		nil,
		22080
	},
	[22017018] = {
		22017018,
		0,
		Lang.get(49452),
		22017,
		18,
		216,
		nil,
		1,
		2
	},
	[22017019] = {
		22017019,
		0,
		Lang.get(49453),
		22017,
		19,
		107,
		{
			RTResTalkAction[102]
		},
		nil,
		nil,
		3
	},
	[22017020] = {
		22017020,
		0,
		Lang.get(49454),
		22017,
		20,
		216,
		{
			RTResTalkAction[103],
			RTResTalkAction[4]
		}
	},
	[22017021] = {
		22017021,
		5,
		Lang.get(49455),
		22017,
		21,
		107,
		{
			RTResTalkAction[23],
			RTResTalkAction[104]
		}
	},
	[22017022] = {
		22017022,
		0,
		Lang.get(34907),
		22017,
		22,
		216,
		{
			RTResTalkAction[105],
			RTResTalkAction[4]
		}
	},
	[22017023] = {
		22017023,
		0,
		Lang.get(49456),
		22017,
		23,
		141,
		{
			RTResTalkAction[104]
		},
		1,
		0,
		-1,
		nil,
		nil,
		22081,
		nil,
		1,
		nil,
		nil,
		nil,
		22081
	},
	[22017024] = {
		22017024,
		0,
		Lang.get(51857),
		22017,
		24,
		141,
		nil,
		1
	},
	[22017025] = {
		22017025,
		0,
		Lang.get(49458),
		22017,
		25,
		141,
		{
			RTResTalkAction[106]
		},
		nil,
		nil,
		3
	},
	[22017026] = {
		22017026,
		0,
		Lang.get(49459),
		22017,
		26,
		141,
		{
			RTResTalkAction[26]
		}
	},
	[22017027] = {
		22017027,
		0,
		Lang.get(49460),
		22017,
		27,
		141,
		{
			RTResTalkAction[26]
		}
	},
	[22017028] = {
		22017028,
		0,
		Lang.get(49461),
		22017,
		28,
		107,
		{
			RTResTalkAction[107],
			RTResTalkAction[27]
		}
	},
	[22017029] = {
		22017029,
		0,
		Lang.get(49462),
		22017,
		29,
		141,
		{
			RTResTalkAction[71],
			RTResTalkAction[4]
		}
	},
	[22017030] = {
		22017030,
		0,
		Lang.get(49463),
		22017,
		30,
		141,
		{
			RTResTalkAction[29]
		}
	},
	[22017031] = {
		22017031,
		0,
		Lang.get(49464),
		22017,
		31,
		141,
		{
			RTResTalkAction[30]
		}
	},
	[22017032] = {
		22017032,
		0,
		Lang.get(49465),
		22017,
		32,
		107,
		{
			RTResTalkAction[108],
			RTResTalkAction[27]
		}
	},
	[22017033] = {
		22017033,
		0,
		Lang.get(49466),
		22017,
		33,
		134,
		{
			RTResTalkAction[68],
			RTResTalkAction[4]
		}
	},
	[22017034] = {
		22017034,
		0,
		Lang.get(49467),
		22017,
		34,
		387,
		{
			RTResTalkAction[95],
			RTResTalkAction[15]
		}
	},
	[22017035] = {
		22017035,
		0,
		Lang.get(49468),
		22017,
		35,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[12]
		}
	},
	[22018001] = {
		22018001,
		0,
		Lang.get(49469),
		22018,
		1,
		387,
		nil,
		1,
		3,
		nil,
		nil,
		154,
		22082,
		nil,
		1,
		nil,
		1,
		nil,
		22082
	},
	[22018002] = {
		22018002,
		0,
		Lang.get(49470),
		22018,
		2,
		387,
		nil,
		1,
		1
	},
	[22018003] = {
		22018003,
		0,
		Lang.get(49471),
		22018,
		3,
		387,
		nil,
		1,
		0
	},
	[22018004] = {
		22018004,
		0,
		Lang.get(49472),
		22018,
		4,
		141,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22083,
		[19] = 22083
	},
	[22018005] = {
		22018005,
		0,
		Lang.get(49473),
		22018,
		5,
		107,
		nil,
		1,
		8
	},
	[22018006] = {
		22018006,
		0,
		Lang.get(49474),
		22018,
		6,
		107,
		nil,
		1,
		5
	},
	[22018007] = {
		22018007,
		0,
		Lang.get(49475),
		22018,
		7,
		107,
		{
			RTResTalkAction[109]
		},
		nil,
		nil,
		3
	},
	[22018008] = {
		22018008,
		0,
		Lang.get(49476),
		22018,
		8,
		141,
		{
			RTResTalkAction[26],
			RTResTalkAction[4]
		}
	},
	[22018009] = {
		22018009,
		0,
		Lang.get(49477),
		22018,
		9,
		141,
		{
			RTResTalkAction[26]
		}
	},
	[22018010] = {
		22018010,
		0,
		Lang.get(49478),
		22018,
		10,
		387,
		{
			RTResTalkAction[110],
			RTResTalkAction[27]
		}
	},
	[22018011] = {
		22018011,
		0,
		Lang.get(49479),
		22018,
		11,
		387,
		{
			RTResTalkAction[12]
		},
		1,
		3,
		-1,
		nil,
		nil,
		22082,
		nil,
		1,
		nil,
		nil,
		nil,
		22082
	},
	[22018012] = {
		22018012,
		0,
		Lang.get(49480),
		22018,
		12,
		107,
		nil,
		1,
		8
	},
	[22018013] = {
		22018013,
		0,
		Lang.get(49481),
		22018,
		13,
		387,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		22109,
		nil,
		nil,
		nil,
		0,
		nil,
		22109
	},
	[22018014] = {
		22018014,
		0,
		Lang.get(49482),
		22018,
		14,
		107,
		nil,
		1,
		10,
		nil,
		nil,
		nil,
		22083,
		nil,
		nil,
		nil,
		1,
		nil,
		22083
	},
	[22018015] = {
		22018015,
		0,
		Lang.get(49483),
		22018,
		15,
		387,
		nil,
		1,
		1
	},
	[22018016] = {
		22018016,
		0,
		Lang.get(49484),
		22018,
		16,
		107,
		nil,
		1,
		8
	},
	[22018017] = {
		22018017,
		0,
		Lang.get(49485),
		22018,
		17,
		387,
		nil,
		1,
		1
	},
	[22018018] = {
		22018018,
		0,
		Lang.get(49486),
		22018,
		18,
		107,
		nil,
		1,
		5
	},
	[22018019] = {
		22018019,
		0,
		Lang.get(19613),
		22018,
		19,
		387,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		22084,
		nil,
		nil,
		nil,
		nil,
		nil,
		22084
	},
	[22018020] = {
		22018020,
		0,
		Lang.get(20129),
		22018,
		20,
		387,
		nil,
		1,
		1
	},
	[22018021] = {
		22018021,
		0,
		Lang.get(49487),
		22018,
		21,
		107,
		nil,
		1,
		8
	},
	[22019001] = {
		22019001,
		0,
		Lang.get(49488),
		22019,
		1,
		387,
		nil,
		1,
		0,
		nil,
		nil,
		57,
		22085,
		nil,
		nil,
		nil,
		nil,
		nil,
		22085
	},
	[22019002] = {
		22019002,
		0,
		Lang.get(49489),
		22019,
		2,
		141,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22086,
		[19] = 22086
	},
	[22019003] = {
		22019003,
		0,
		Lang.get(49490),
		22019,
		3,
		134,
		nil,
		1,
		3,
		nil,
		nil,
		nil,
		22087,
		nil,
		nil,
		nil,
		nil,
		nil,
		22087
	},
	[22019004] = {
		22019004,
		0,
		Lang.get(49491),
		22019,
		4,
		216,
		nil,
		1,
		1
	},
	[22019005] = {
		22019005,
		0,
		Lang.get(49492),
		22019,
		5,
		107,
		nil,
		1,
		1
	},
	[22019006] = {
		22019006,
		0,
		Lang.get(49493),
		22019,
		6,
		387,
		nil,
		1,
		2
	},
	[22019007] = {
		22019007,
		0,
		Lang.get(49494),
		22019,
		7,
		18,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		22088,
		nil,
		nil,
		nil,
		1,
		nil,
		22088
	},
	[22019008] = {
		22019008,
		0,
		Lang.get(49495),
		22019,
		8,
		29,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22089,
		[19] = 22089
	},
	[22019009] = {
		22019009,
		0,
		Lang.get(49496),
		22019,
		9,
		10,
		nil,
		1
	},
	[22019010] = {
		22019010,
		0,
		Lang.get(49497),
		22019,
		10,
		10,
		nil,
		1
	},
	[22019011] = {
		22019011,
		0,
		Lang.get(49498),
		22019,
		11,
		18,
		nil,
		1
	},
	[22019012] = {
		22019012,
		0,
		Lang.get(49499),
		22019,
		12,
		29,
		nil,
		1
	},
	[22019013] = {
		22019013,
		0,
		Lang.get(49500),
		22019,
		13,
		29,
		nil,
		1
	},
	[22019014] = {
		22019014,
		0,
		Lang.get(49501),
		22019,
		14,
		32,
		nil,
		1
	},
	[22019015] = {
		22019015,
		0,
		Lang.get(49502),
		22019,
		15,
		18,
		nil,
		1
	},
	[22019016] = {
		22019016,
		0,
		Lang.get(49503),
		22019,
		16,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22090,
		[19] = 22090
	},
	[22019017] = {
		22019017,
		0,
		Lang.get(49504),
		22019,
		17,
		134,
		nil,
		1
	},
	[22019018] = {
		22019018,
		0,
		Lang.get(49505),
		22019,
		18,
		216,
		nil,
		1
	},
	[22019019] = {
		22019019,
		0,
		Lang.get(49506),
		22019,
		19,
		134,
		nil,
		1
	},
	[22019020] = {
		22019020,
		0,
		Lang.get(49507),
		22019,
		20,
		107,
		nil,
		1
	},
	[22019021] = {
		22019021,
		0,
		Lang.get(49508),
		22019,
		21,
		387,
		nil,
		1
	},
	[22019022] = {
		22019022,
		0,
		Lang.get(49509),
		22019,
		22,
		107,
		nil,
		1
	},
	[22019023] = {
		22019023,
		0,
		Lang.get(49510),
		22019,
		23,
		387,
		nil,
		1
	},
	[22019024] = {
		22019024,
		0,
		Lang.get(49511),
		22019,
		24,
		107,
		nil,
		1
	},
	[22019025] = {
		22019025,
		0,
		Lang.get(49512),
		22019,
		25,
		387,
		nil,
		1
	},
	[22019026] = {
		22019026,
		0,
		Lang.get(49513),
		22019,
		26,
		387,
		nil,
		1
	},
	[22019027] = {
		22019027,
		0,
		Lang.get(49514),
		22019,
		27,
		107,
		nil,
		1
	},
	[22019028] = {
		22019028,
		0,
		Lang.get(49515),
		22019,
		28,
		107,
		nil,
		1
	},
	[22020001] = {
		22020001,
		0,
		Lang.get(49516),
		22020,
		1,
		107,
		nil,
		1,
		8,
		nil,
		nil,
		57,
		22091,
		nil,
		nil,
		nil,
		1,
		nil,
		22091
	},
	[22020002] = {
		22020002,
		0,
		Lang.get(49517),
		22020,
		2,
		107,
		nil,
		1,
		0,
		[19] = 22092
	},
	[22020003] = {
		22020003,
		0,
		Lang.get(49518),
		22020,
		3,
		134,
		{
			RTResTalkAction[111]
		},
		nil,
		nil,
		3
	},
	[22020004] = {
		22020004,
		0,
		Lang.get(49519),
		22020,
		4,
		141,
		{
			RTResTalkAction[30],
			RTResTalkAction[15]
		}
	},
	[22020005] = {
		22020005,
		0,
		Lang.get(49520),
		22020,
		5,
		107,
		{
			RTResTalkAction[112],
			RTResTalkAction[27]
		}
	},
	[22020006] = {
		22020006,
		0,
		Lang.get(49521),
		22020,
		6,
		107,
		{
			RTResTalkAction[10]
		}
	},
	[22020007] = {
		22020007,
		0,
		Lang.get(49522),
		22020,
		7,
		141,
		{
			RTResTalkAction[30],
			RTResTalkAction[4]
		}
	},
	[22020008] = {
		22020008,
		0,
		Lang.get(49523),
		22020,
		8,
		107,
		{
			RTResTalkAction[60],
			RTResTalkAction[27]
		}
	},
	[22020009] = {
		22020009,
		0,
		Lang.get(49524),
		22020,
		9,
		387,
		{
			RTResTalkAction[56],
			RTResTalkAction[4]
		}
	},
	[22020010] = {
		22020010,
		0,
		Lang.get(49525),
		22020,
		10,
		387,
		{
			RTResTalkAction[113]
		}
	},
	[22020011] = {
		22020011,
		0,
		Lang.get(49526),
		22020,
		11,
		387,
		{
			RTResTalkAction[35]
		}
	},
	[22020012] = {
		22020012,
		0,
		Lang.get(49527),
		22020,
		12,
		216,
		{
			RTResTalkAction[114],
			RTResTalkAction[12]
		}
	},
	[22020013] = {
		22020013,
		0,
		Lang.get(49528),
		22020,
		13,
		141,
		{
			RTResTalkAction[26],
			RTResTalkAction[104]
		}
	},
	[22020014] = {
		22020014,
		0,
		Lang.get(49529),
		22020,
		14,
		387,
		{
			RTResTalkAction[56],
			RTResTalkAction[27]
		}
	},
	[22020015] = {
		22020015,
		0,
		Lang.get(49530),
		22020,
		15,
		387,
		{
			RTResTalkAction[12]
		},
		1,
		1,
		-1,
		nil,
		nil,
		nil,
		nil,
		1,
		nil,
		0,
		nil,
		22093
	},
	[22020016] = {
		22020016,
		0,
		Lang.get(50262),
		22020,
		16,
		216,
		nil,
		1,
		1
	},
	[22020017] = {
		22020017,
		0,
		Lang.get(49532),
		22020,
		17,
		107,
		nil,
		1,
		8
	},
	[22020018] = {
		22020018,
		0,
		Lang.get(49533),
		22020,
		18,
		107,
		nil,
		1,
		3
	},
	[22020019] = {
		22020019,
		0,
		Lang.get(49534),
		22020,
		19,
		387,
		nil,
		1,
		1
	},
	[22020020] = {
		22020020,
		0,
		Lang.get(49535),
		22020,
		20,
		107,
		nil,
		1,
		1
	},
	[22020021] = {
		22020021,
		0,
		Lang.get(49536),
		22020,
		21,
		107,
		nil,
		1,
		3
	},
	[22020022] = {
		22020022,
		0,
		Lang.get(49537),
		22020,
		22,
		387,
		nil,
		1,
		0
	},
	[22020023] = {
		22020023,
		0,
		Lang.get(49538),
		22020,
		23,
		107,
		nil,
		1,
		8
	},
	[22020024] = {
		22020024,
		0,
		Lang.get(49539),
		22020,
		24,
		107,
		nil,
		1,
		0
	},
	[22020025] = {
		22020025,
		0,
		Lang.get(49540),
		22020,
		25,
		141,
		nil,
		1
	},
	[22020026] = {
		22020026,
		0,
		Lang.get(49541),
		22020,
		26,
		141,
		nil,
		1
	},
	[22020027] = {
		22020027,
		0,
		Lang.get(51858),
		22020,
		27,
		141,
		nil,
		1
	},
	[22021001] = {
		22021001,
		0,
		Lang.get(49543),
		22021,
		1,
		18,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		22096,
		nil,
		nil,
		nil,
		1,
		nil,
		22096
	},
	[22021002] = {
		22021002,
		0,
		Lang.get(49544),
		22021,
		2,
		18,
		nil,
		1
	},
	[22021003] = {
		22021003,
		0,
		Lang.get(49545),
		22021,
		3,
		29,
		{
			RTResTalkAction[115]
		},
		nil,
		nil,
		3
	},
	[22021004] = {
		22021004,
		0,
		Lang.get(49546),
		22021,
		4,
		10,
		{
			RTResTalkAction[116],
			RTResTalkAction[9]
		}
	},
	[22021005] = {
		22021005,
		0,
		Lang.get(49547),
		22021,
		5,
		10,
		{
			RTResTalkAction[116]
		}
	},
	[22021006] = {
		22021006,
		0,
		Lang.get(49548),
		22021,
		6,
		18,
		{
			RTResTalkAction[5],
			RTResTalkAction[117]
		}
	},
	[22021007] = {
		22021007,
		0,
		Lang.get(49549),
		22021,
		7,
		32,
		{
			RTResTalkAction[118],
			RTResTalkAction[7]
		}
	},
	[22021008] = {
		22021008,
		0,
		Lang.get(49550),
		22021,
		8,
		32,
		{
			RTResTalkAction[119]
		}
	},
	[22021009] = {
		22021009,
		0,
		Lang.get(49551),
		22021,
		9,
		27,
		{
			RTResTalkAction[120],
			RTResTalkAction[121]
		}
	},
	[22021010] = {
		22021010,
		0,
		Lang.get(49552),
		22021,
		10,
		27,
		{
			RTResTalkAction[122]
		}
	},
	[22021011] = {
		22021011,
		0,
		Lang.get(49553),
		22021,
		11,
		3,
		{
			RTResTalkAction[123]
		},
		1,
		nil,
		-1,
		1070,
		nil,
		22097,
		nil,
		1,
		nil,
		1,
		nil,
		22097
	},
	[22021012] = {
		22021012,
		0,
		Lang.get(49554),
		22021,
		12,
		27,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22098,
		[19] = 22098
	},
	[22021013] = {
		22021013,
		0,
		Lang.get(49555),
		22021,
		13,
		32,
		nil,
		1
	},
	[22021014] = {
		22021014,
		0,
		Lang.get(49556),
		22021,
		14,
		27,
		nil,
		1
	},
	[22021015] = {
		22021015,
		0,
		Lang.get(49557),
		22021,
		15,
		32,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22118,
		[19] = 22118
	},
	[22021016] = {
		22021016,
		0,
		Lang.get(49558),
		22021,
		16,
		18,
		nil,
		1
	},
	[22021017] = {
		22021017,
		0,
		Lang.get(51859),
		22021,
		17,
		29,
		nil,
		1
	},
	[22021018] = {
		22021018,
		0,
		Lang.get(49560),
		22021,
		18,
		10,
		nil,
		1
	},
	[22022001] = {
		22022001,
		0,
		Lang.get(49561),
		22022,
		1,
		107,
		nil,
		1,
		0,
		nil,
		nil,
		62,
		22099,
		nil,
		nil,
		nil,
		1,
		nil,
		22099
	},
	[22022002] = {
		22022002,
		0,
		Lang.get(49562),
		22022,
		2,
		18,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22121,
		[19] = 22121
	},
	[22022003] = {
		22022003,
		0,
		Lang.get(49563),
		22022,
		3,
		29,
		nil,
		1
	},
	[22022004] = {
		22022004,
		0,
		Lang.get(49564),
		22022,
		4,
		107,
		nil,
		1
	},
	[22022005] = {
		22022005,
		0,
		Lang.get(49565),
		22022,
		5,
		18,
		nil,
		1
	},
	[22022006] = {
		22022006,
		0,
		Lang.get(49566),
		22022,
		6,
		29,
		nil,
		1
	},
	[22022007] = {
		22022007,
		0,
		Lang.get(49567),
		22022,
		7,
		107,
		nil,
		1
	},
	[22022008] = {
		22022008,
		0,
		Lang.get(49118),
		22022,
		8,
		3,
		nil,
		1,
		nil,
		nil,
		1070,
		nil,
		22097,
		nil,
		nil,
		nil,
		1,
		nil,
		22097
	},
	[22022009] = {
		22022009,
		0,
		Lang.get(49568),
		22022,
		9,
		29,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22114,
		[19] = 22114
	},
	[22022010] = {
		22022010,
		0,
		Lang.get(49569),
		22022,
		10,
		387,
		nil,
		1,
		4,
		nil,
		nil,
		nil,
		22099,
		nil,
		nil,
		nil,
		nil,
		nil,
		22099
	},
	[22022011] = {
		22022011,
		0,
		Lang.get(49570),
		22022,
		11,
		107,
		{
			RTResTalkAction[22]
		},
		nil,
		nil,
		3
	},
	[22022012] = {
		22022012,
		0,
		Lang.get(49571),
		22022,
		12,
		387,
		{
			RTResTalkAction[95],
			RTResTalkAction[4]
		}
	},
	[22022013] = {
		22022013,
		0,
		Lang.get(49572),
		22022,
		13,
		387,
		{
			RTResTalkAction[8]
		}
	},
	[22022014] = {
		22022014,
		0,
		Lang.get(49573),
		22022,
		14,
		107,
		{
			RTResTalkAction[60],
			RTResTalkAction[12]
		}
	},
	[22022015] = {
		22022015,
		0,
		Lang.get(49574),
		22022,
		15,
		387,
		{
			RTResTalkAction[50],
			RTResTalkAction[4]
		}
	},
	[22022016] = {
		22022016,
		0,
		Lang.get(49575),
		22022,
		16,
		387,
		{
			RTResTalkAction[54]
		}
	},
	[22022017] = {
		22022017,
		0,
		Lang.get(49576),
		22022,
		17,
		18,
		{
			RTResTalkAction[124],
			RTResTalkAction[12]
		}
	},
	[22022018] = {
		22022018,
		0,
		Lang.get(22255),
		22022,
		18,
		3,
		{
			RTResTalkAction[61],
			RTResTalkAction[7]
		},
		nil,
		nil,
		nil,
		1070
	},
	[22022019] = {
		22022019,
		0,
		Lang.get(49577),
		22022,
		19,
		387,
		{
			RTResTalkAction[125],
			RTResTalkAction[62]
		}
	},
	[22022020] = {
		22022020,
		0,
		Lang.get(49578),
		22022,
		20,
		107,
		{
			RTResTalkAction[42],
			RTResTalkAction[12]
		}
	},
	[22022021] = {
		22022021,
		0,
		Lang.get(49579),
		22022,
		21,
		107,
		{
			RTResTalkAction[60]
		}
	},
	[22023001] = {
		22023001,
		0,
		Lang.get(49580),
		22023,
		1,
		107,
		nil,
		1,
		5,
		nil,
		nil,
		141,
		22115,
		1,
		nil,
		nil,
		1,
		nil,
		22115
	},
	[22023002] = {
		22023002,
		0,
		Lang.get(49581),
		22023,
		2,
		141,
		nil,
		1,
		0
	},
	[22023003] = {
		22023003,
		0,
		Lang.get(49582),
		22023,
		3,
		107,
		nil,
		1
	},
	[22023004] = {
		22023004,
		0,
		Lang.get(49583),
		22023,
		4,
		134,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		22116,
		nil,
		nil,
		nil,
		nil,
		nil,
		22116
	},
	[22023005] = {
		22023005,
		0,
		Lang.get(49584),
		22023,
		5,
		216,
		nil,
		1,
		1
	},
	[22023006] = {
		22023006,
		0,
		Lang.get(49585),
		22023,
		6,
		107,
		{
			RTResTalkAction[39]
		},
		nil,
		nil,
		3
	},
	[22023007] = {
		22023007,
		0,
		Lang.get(49586),
		22023,
		7,
		107,
		{
			RTResTalkAction[42]
		}
	},
	[22023008] = {
		22023008,
		0,
		Lang.get(49587),
		22023,
		8,
		141,
		{
			RTResTalkAction[126],
			RTResTalkAction[4]
		}
	},
	[22023009] = {
		22023009,
		0,
		Lang.get(49588),
		22023,
		9,
		387,
		{
			RTResTalkAction[54],
			RTResTalkAction[27]
		}
	},
	[22023010] = {
		22023010,
		0,
		Lang.get(49589),
		22023,
		10,
		107,
		{
			RTResTalkAction[66],
			RTResTalkAction[12]
		}
	},
	[22023011] = {
		22023011,
		0,
		Lang.get(49590),
		22023,
		11,
		107,
		{
			RTResTalkAction[108]
		}
	},
	[22023012] = {
		22023012,
		0,
		Lang.get(49591),
		22023,
		12,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[4]
		}
	},
	[22023013] = {
		22023013,
		0,
		Lang.get(49592),
		22023,
		13,
		107,
		{
			RTResTalkAction[60],
			RTResTalkAction[27]
		}
	},
	[22023014] = {
		22023014,
		0,
		Lang.get(49593),
		22023,
		14,
		107,
		{
			RTResTalkAction[11]
		}
	},
	[22023015] = {
		22023015,
		0,
		Lang.get(49594),
		22023,
		15,
		107,
		{
			RTResTalkAction[127]
		}
	},
	[22023016] = {
		22023016,
		0,
		Lang.get(49595),
		22023,
		16,
		387,
		{
			RTResTalkAction[128],
			RTResTalkAction[4]
		}
	},
	[22023017] = {
		22023017,
		0,
		Lang.get(49596),
		22023,
		17,
		387,
		{
			RTResTalkAction[50]
		}
	},
	[22023018] = {
		22023018,
		0,
		Lang.get(49597),
		22023,
		18,
		387,
		{
			RTResTalkAction[54]
		}
	},
	[22023019] = {
		22023019,
		0,
		Lang.get(49598),
		22023,
		19,
		387,
		{
			RTResTalkAction[125]
		}
	},
	[22023020] = {
		22023020,
		0,
		Lang.get(49599),
		22023,
		20,
		107,
		{
			RTResTalkAction[129],
			RTResTalkAction[12]
		}
	},
	[22023021] = {
		22023021,
		0,
		Lang.get(49600),
		22023,
		21,
		107,
		{
			RTResTalkAction[60]
		}
	},
	[22023022] = {
		22023022,
		0,
		Lang.get(49601),
		22023,
		22,
		107,
		{
			RTResTalkAction[11]
		}
	},
	[22023023] = {
		22023023,
		0,
		Lang.get(49602),
		22023,
		23,
		216,
		{
			RTResTalkAction[130],
			RTResTalkAction[4]
		}
	},
	[22023024] = {
		22023024,
		0,
		Lang.get(49603),
		22023,
		24,
		107,
		{
			RTResTalkAction[14],
			RTResTalkAction[104]
		}
	},
	[22023025] = {
		22023025,
		0,
		Lang.get(49604),
		22023,
		25,
		387,
		{
			RTResTalkAction[8],
			RTResTalkAction[4]
		}
	},
	[22023026] = {
		22023026,
		0,
		Lang.get(49605),
		22023,
		26,
		107,
		{
			RTResTalkAction[131],
			RTResTalkAction[12]
		}
	},
	[22023027] = {
		22023027,
		0,
		Lang.get(49606),
		22023,
		27,
		107,
		{
			RTResTalkAction[11]
		}
	},
	[22023028] = {
		22023028,
		0,
		Lang.get(49607),
		22023,
		28,
		107,
		{
			RTResTalkAction[42]
		}
	},
	[22023029] = {
		22023029,
		0,
		Lang.get(49608),
		22023,
		29,
		134,
		{
			RTResTalkAction[4]
		},
		1,
		2,
		-1,
		nil,
		nil,
		22117,
		nil,
		1,
		nil,
		1,
		nil,
		22117
	},
	[22023030] = {
		22023030,
		0,
		Lang.get(49609),
		22023,
		30,
		216,
		nil,
		1,
		1
	},
	[22023031] = {
		22023031,
		0,
		Lang.get(49610),
		22023,
		31,
		107,
		nil,
		1,
		5,
		nil,
		nil,
		nil,
		22119,
		nil,
		nil,
		nil,
		nil,
		nil,
		22119
	},
	[22023032] = {
		22023032,
		0,
		Lang.get(49611),
		22023,
		32,
		134,
		nil,
		1
	},
	[22023033] = {
		22023033,
		0,
		Lang.get(49612),
		22023,
		33,
		107,
		nil,
		1,
		1
	},
	[22023034] = {
		22023034,
		0,
		Lang.get(49613),
		22023,
		34,
		141,
		nil,
		1,
		0
	},
	[22023035] = {
		22023035,
		0,
		Lang.get(49614),
		22023,
		35,
		141,
		nil,
		1
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
