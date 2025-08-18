-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\SweetHome\\ResTalk.lua

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
	290,
	nil,
	nil,
	2
}
RTResTalkAction[2] = {
	[1] = 1,
	[2] = 777
}
RTResTalkAction[3] = {
	[1] = 0,
	[2] = 290
}
RTResTalkAction[4] = {
	[1] = 1,
	[2] = 290
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 777
}
RTResTalkAction[6] = {
	[1] = 1,
	[2] = 290,
	[3] = {
		3
	}
}
RTResTalkAction[7] = {
	1,
	290,
	nil,
	nil,
	0
}
RTResTalkAction[8] = {
	[1] = 1,
	[2] = 417
}
RTResTalkAction[9] = {
	[1] = 0,
	[2] = 417
}
RTResTalkAction[10] = {
	[1] = 2,
	[2] = 290
}
RTResTalkAction[11] = {
	[1] = 3,
	[2] = 777
}
RTResTalkAction[12] = {
	2,
	290,
	nil,
	nil,
	2
}
RTResTalkAction[13] = {
	2,
	290,
	nil,
	nil,
	1
}
RTResTalkAction[14] = {
	2,
	290,
	nil,
	nil,
	0
}
RTResTalkAction[15] = {
	[1] = 1,
	[2] = 268
}
RTResTalkAction[16] = {
	[1] = 0,
	[2] = 268
}
RTResTalkAction[17] = {
	[1] = 1,
	[2] = 782
}
RTResTalkAction[18] = {
	[1] = 2,
	[2] = 268
}
RTResTalkAction[19] = {
	[1] = 3,
	[2] = 782
}
RTResTalkAction[20] = {
	[1] = 0,
	[2] = 782
}
RTResTalkAction[21] = {
	[1] = 3,
	[2] = 777,
	[3] = {
		2
	}
}
RTResTalkAction[22] = {
	[1] = 1,
	[2] = 782,
	[3] = {
		1
	}
}
RTResTalkAction[23] = {
	[1] = 1,
	[2] = 777,
	[3] = {
		3
	}
}
RTResTalkAction[24] = {
	[1] = 2,
	[2] = 777
}
RTResTalkAction[25] = {
	[1] = 1,
	[2] = 777,
	[3] = {
		1
	}
}
RTResTalkAction[26] = {
	[1] = 2,
	[2] = 782
}
RTResTalkAction[27] = {
	[1] = 3,
	[2] = 785
}
RTResTalkAction[28] = {
	[1] = 0,
	[2] = 785
}
RTResTalkAction[29] = {
	[1] = 1,
	[2] = 794
}
RTResTalkAction[30] = {
	[1] = 2,
	[2] = 794
}
RTResTalkAction[31] = {
	[1] = 3,
	[2] = 777,
	[3] = {
		1
	}
}
RTResTalkAction[32] = {
	[1] = 0,
	[2] = 794
}
RTResTalkAction[33] = {
	1,
	134,
	nil,
	nil,
	2
}
RTResTalkAction[34] = {
	1,
	134,
	{
		1
	},
	nil,
	4
}
RTResTalkAction[35] = {
	[1] = 0,
	[2] = 134
}
RTResTalkAction[36] = {
	1,
	134,
	nil,
	nil,
	5
}
RTResTalkAction[37] = {
	1,
	134,
	nil,
	nil,
	1
}
RTResTalkAction[38] = {
	[1] = 1,
	[2] = 418
}
RTResTalkAction[39] = {
	[1] = 1,
	[2] = 133
}
RTResTalkAction[40] = {
	[1] = 0,
	[2] = 418
}
RTResTalkAction[41] = {
	1,
	133,
	nil,
	nil,
	2
}
RTResTalkAction[42] = {
	[1] = 0,
	[2] = 133
}
RTResTalkAction[43] = {
	[1] = 2,
	[2] = 133
}
RTResTalkAction[44] = {
	3,
	134,
	nil,
	nil,
	1
}
RTResTalkAction[45] = {
	3,
	134,
	nil,
	nil,
	2
}
RTResTalkAction[46] = {
	1,
	133,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[47] = {
	[1] = 3,
	[2] = 12
}
RTResTalkAction[48] = {
	[1] = 0,
	[2] = 12
}
RTResTalkAction[49] = {
	[1] = 1,
	[2] = 790
}
RTResTalkAction[50] = {
	[1] = 1,
	[2] = 12
}
RTResTalkAction[51] = {
	[1] = 0,
	[2] = 790
}
RTResTalkAction[52] = {
	[1] = 1,
	[2] = 12,
	[3] = {
		3
	}
}
RTResTalkAction[53] = {
	[1] = 1,
	[2] = 794,
	[3] = {
		1
	}
}
RTResTalkAction[54] = {
	[1] = 1,
	[2] = 792
}
RTResTalkAction[55] = {
	[1] = 0,
	[2] = 792
}
RTResTalkAction[56] = {
	[1] = 2,
	[2] = 790
}
RTResTalkAction[57] = {
	[1] = 3,
	[2] = 792
}
RTResTalkAction[58] = {
	[1] = 2,
	[2] = 134
}
RTResTalkAction[59] = {
	3,
	133,
	nil,
	nil,
	1
}
RTResTalkAction[60] = {
	2,
	134,
	nil,
	nil,
	1
}
RTResTalkAction[61] = {
	[1] = 3,
	[2] = 133
}
RTResTalkAction[62] = {
	[1] = 3,
	[2] = 790
}
RTResTalkAction[63] = {
	2,
	134,
	nil,
	nil,
	2
}
RTResTalkAction[64] = {
	1,
	133,
	nil,
	nil,
	1
}
RTResTalkAction[65] = {
	[1] = 1,
	[2] = 133,
	[3] = {
		1
	}
}
RTResTalkAction[66] = {
	1,
	133,
	nil,
	nil,
	0
}
RTResTalkAction[67] = {
	2,
	134,
	nil,
	nil,
	3
}
RTResTalkAction[68] = {
	[1] = 1,
	[2] = 788
}
RTResTalkAction[69] = {
	[1] = 3,
	[2] = 788
}
RTResTalkAction[70] = {
	[1] = 0,
	[2] = 788
}
RTResTalkAction[71] = {
	3,
	133,
	nil,
	nil,
	2
}
RTResTalkAction[72] = {
	1,
	134,
	nil,
	nil,
	3
}
RTResTalkAction[73] = {
	[1] = 3,
	[2] = 133,
	[3] = {
		1
	}
}
RTResTalkAction[74] = {
	2,
	134,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[75] = {
	1,
	134,
	nil,
	nil,
	4
}
RTResTalkAction[76] = {
	[1] = 1,
	[2] = 795
}
RTResTalkAction[77] = {
	[1] = 0,
	[2] = 795
}
RTResTalkAction[78] = {
	1,
	769,
	nil,
	nil,
	4
}
RTResTalkAction[79] = {
	1,
	769,
	nil,
	nil,
	6
}
RTResTalkAction[80] = {
	[1] = 2,
	[2] = 795
}
RTResTalkAction[81] = {
	[1] = 3,
	[2] = 769
}
RTResTalkAction[82] = {
	3,
	769,
	nil,
	nil,
	5
}
RTResTalkAction[83] = {
	[1] = 0,
	[2] = 769
}
RTResTalkAction[84] = {
	1,
	769,
	nil,
	nil,
	3
}
RTResTalkAction[85] = {
	1,
	769,
	{
		1
	},
	nil,
	4
}
RTResTalkAction[86] = {
	1,
	769,
	nil,
	nil,
	2
}
RTResTalkAction[87] = {
	1,
	769,
	nil,
	nil,
	1
}
RTResTalkAction[88] = {
	[1] = 1,
	[2] = 795,
	[3] = {
		3
	}
}
RTResTalkAction[89] = {
	[1] = 1,
	[2] = 793
}
RTResTalkAction[90] = {
	[1] = 2,
	[2] = 793
}
RTResTalkAction[91] = {
	2,
	134,
	nil,
	nil,
	5
}
RTResTalkAction[92] = {
	[1] = 1,
	[2] = 291,
	[3] = {
		2
	}
}
RTResTalkAction[93] = {
	[1] = 2,
	[2] = 291
}
RTResTalkAction[94] = {
	3,
	769,
	nil,
	nil,
	6
}
RTResTalkAction[95] = {
	3,
	769,
	nil,
	nil,
	4
}
RTResTalkAction[96] = {
	[1] = 0,
	[2] = 291
}
RTResTalkAction[97] = {
	3,
	769,
	nil,
	nil,
	1
}
RTResTalkAction[98] = {
	3,
	769,
	nil,
	nil,
	7
}
RTResTalkAction[99] = {
	[1] = 1,
	[2] = 291,
	[3] = {
		3
	}
}
RTResTalkAction[100] = {
	[1] = 2,
	[2] = 769
}
RTResTalkAction[101] = {
	1,
	769,
	nil,
	nil,
	5
}
RTResTalkAction[102] = {
	1,
	769,
	nil,
	nil,
	7
}
RTResTalkAction[103] = {
	[1] = 1,
	[2] = 291
}
RTResTalkAction[104] = {
	3,
	133,
	nil,
	nil,
	0
}
RTResTalkAction[105] = {
	1,
	290,
	nil,
	nil,
	3
}
RTResTalkAction[106] = {
	2,
	290,
	nil,
	nil,
	3
}

local Data = {
	[30000001] = {
		30000001,
		0,
		Lang.get(71591),
		30000,
		1,
		775,
		nil,
		1,
		nil,
		nil,
		nil,
		31,
		30000,
		nil,
		1,
		nil,
		1,
		nil,
		30000
	},
	[30000002] = {
		30000002,
		3,
		"……",
		30000,
		2,
		776,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		30001,
		nil,
		1,
		nil,
		1,
		nil,
		30001,
		255,
		nil,
		1
	},
	[30000003] = {
		30000003,
		0,
		Lang.get(71592),
		30000,
		3,
		776,
		nil,
		1
	},
	[30000004] = {
		30000004,
		0,
		"…………",
		30000,
		4,
		290,
		nil,
		1
	},
	[30000005] = {
		30000005,
		0,
		Lang.get(71593),
		30000,
		5,
		776,
		nil,
		1
	},
	[30000006] = {
		30000006,
		3,
		Lang.get(71594),
		30000,
		6,
		605,
		[22] = 1
	},
	[30000007] = {
		30000007,
		7,
		"83",
		30000,
		7,
		605,
		nil,
		nil,
		nil,
		5
	},
	[30000008] = {
		30000008,
		0,
		Lang.get(71595),
		30000,
		8,
		290,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3,
		[20] = -1
	},
	[30000009] = {
		30000009,
		0,
		Lang.get(71596),
		30000,
		9,
		777,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[30000010] = {
		30000010,
		0,
		Lang.get(71597),
		30000,
		10,
		290,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[30000011] = {
		30000011,
		0,
		Lang.get(71598),
		30000,
		11,
		290,
		{
			RTResTalkAction[4]
		}
	},
	[30000012] = {
		30000012,
		0,
		Lang.get(71599),
		30000,
		12,
		290,
		{
			RTResTalkAction[4]
		}
	},
	[30000013] = {
		30000013,
		0,
		Lang.get(71600),
		30000,
		13,
		290,
		{
			RTResTalkAction[4]
		}
	},
	[30000014] = {
		30000014,
		0,
		Lang.get(28329),
		30000,
		14,
		290,
		{
			RTResTalkAction[4]
		}
	},
	[30000015] = {
		30000015,
		0,
		Lang.get(71601),
		30000,
		15,
		290,
		{
			RTResTalkAction[4]
		}
	},
	[30000016] = {
		30000016,
		0,
		Lang.get(71602),
		30000,
		16,
		290,
		{
			RTResTalkAction[4]
		}
	},
	[30000017] = {
		30000017,
		0,
		Lang.get(71603),
		30000,
		17,
		777,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[30000018] = {
		30000018,
		0,
		Lang.get(71604),
		30000,
		18,
		290,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[30000019] = {
		30000019,
		0,
		Lang.get(71605),
		30000,
		19,
		778,
		{
			RTResTalkAction[3]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		30002,
		nil,
		1,
		nil,
		1,
		nil,
		30002
	},
	[30000020] = {
		30000020,
		3,
		Lang.get(71606),
		30000,
		20,
		605,
		[22] = 1
	},
	[30000021] = {
		30000021,
		0,
		Lang.get(71607),
		30000,
		21,
		775,
		nil,
		1
	},
	[30000022] = {
		30000022,
		5,
		Lang.get(71608),
		30000,
		22,
		775,
		nil,
		1
	},
	[30000023] = {
		30000023,
		0,
		Lang.get(71609),
		30000,
		23,
		605
	},
	[30000024] = {
		30000024,
		0,
		Lang.get(71610),
		30000,
		24,
		290,
		{
			RTResTalkAction[6]
		},
		nil,
		nil,
		3
	},
	[30000025] = {
		30000025,
		0,
		Lang.get(71611),
		30000,
		25,
		290,
		{
			RTResTalkAction[4]
		}
	},
	[30000026] = {
		30000026,
		0,
		Lang.get(71612),
		30000,
		26,
		290,
		{
			RTResTalkAction[4]
		}
	},
	[30000027] = {
		30000027,
		2,
		Lang.get(71613),
		30000,
		27,
		290,
		{
			RTResTalkAction[7]
		}
	},
	[30000028] = {
		30000028,
		0,
		Lang.get(71614),
		30000,
		28,
		290,
		{
			RTResTalkAction[3]
		},
		1,
		2,
		nil,
		nil,
		nil,
		30003,
		nil,
		1,
		nil,
		1,
		nil,
		30003
	},
	[30000029] = {
		30000029,
		0,
		Lang.get(71615),
		30000,
		29,
		290,
		{
			RTResTalkAction[1]
		},
		nil,
		0,
		3
	},
	[30000030] = {
		30000030,
		0,
		Lang.get(71616),
		30000,
		30,
		290,
		{
			RTResTalkAction[4]
		}
	},
	[30000031] = {
		30000031,
		3,
		Lang.get(71617),
		30000,
		31,
		605,
		{
			RTResTalkAction[3]
		},
		[22] = 1
	},
	[30000032] = {
		30000032,
		0,
		Lang.get(71618),
		30000,
		32,
		417,
		{
			RTResTalkAction[8]
		}
	},
	[30000033] = {
		30000033,
		0,
		Lang.get(71619),
		30000,
		33,
		290,
		{
			RTResTalkAction[8]
		},
		1,
		2,
		[21] = 417
	},
	[30000034] = {
		30000034,
		5,
		Lang.get(71620),
		30000,
		34,
		777,
		{
			RTResTalkAction[8]
		},
		1,
		0,
		[21] = 417
	},
	[30000035] = {
		30000035,
		0,
		Lang.get(71621),
		30000,
		35,
		290,
		{
			RTResTalkAction[7],
			RTResTalkAction[9]
		}
	},
	[30000036] = {
		30000036,
		0,
		Lang.get(71622),
		30000,
		36,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30000037] = {
		30000037,
		0,
		Lang.get(71623),
		30000,
		37,
		290,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30000038] = {
		30000038,
		0,
		Lang.get(71624),
		30000,
		38,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30000039] = {
		30000039,
		0,
		Lang.get(71625),
		30000,
		39,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30001001] = {
		30001001,
		0,
		Lang.get(71626),
		30001,
		1,
		290,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		30004,
		nil,
		1,
		nil,
		1,
		nil,
		30004
	},
	[30001002] = {
		30001002,
		0,
		Lang.get(71627),
		30001,
		2,
		777,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[30001003] = {
		30001003,
		0,
		Lang.get(71628),
		30001,
		3,
		290,
		{
			RTResTalkAction[12],
			RTResTalkAction[11]
		}
	},
	[30001004] = {
		30001004,
		0,
		Lang.get(71629),
		30001,
		4,
		290,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30001005] = {
		30001005,
		0,
		Lang.get(71630),
		30001,
		5,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30001006] = {
		30001006,
		0,
		Lang.get(71631),
		30001,
		6,
		290,
		{
			RTResTalkAction[13],
			RTResTalkAction[11]
		}
	},
	[30001007] = {
		30001007,
		0,
		Lang.get(71632),
		30001,
		7,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30001008] = {
		30001008,
		0,
		Lang.get(71633),
		30001,
		8,
		290,
		{
			RTResTalkAction[14],
			RTResTalkAction[11]
		}
	},
	[30001009] = {
		30001009,
		0,
		Lang.get(71634),
		30001,
		9,
		290,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30001010] = {
		30001010,
		0,
		Lang.get(71635),
		30001,
		10,
		605,
		{
			RTResTalkAction[3],
			RTResTalkAction[5]
		}
	},
	[30001011] = {
		30001011,
		0,
		Lang.get(71636),
		30001,
		11,
		777,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		30005,
		nil,
		1,
		nil,
		1,
		nil,
		30005
	},
	[30001012] = {
		30001012,
		0,
		Lang.get(71637),
		30001,
		12,
		777,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[30001013] = {
		30001013,
		0,
		Lang.get(71638),
		30001,
		13,
		290,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30001014] = {
		30001014,
		0,
		Lang.get(71639),
		30001,
		14,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30001015] = {
		30001015,
		0,
		Lang.get(71640),
		30001,
		15,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30001016] = {
		30001016,
		0,
		Lang.get(71641),
		30001,
		16,
		605,
		{
			RTResTalkAction[3],
			RTResTalkAction[5]
		}
	},
	[30001017] = {
		30001017,
		0,
		Lang.get(71642),
		30001,
		17,
		290,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30001018] = {
		30001018,
		0,
		Lang.get(71643),
		30001,
		18,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30001019] = {
		30001019,
		0,
		Lang.get(71644),
		30001,
		19,
		290,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30001020] = {
		30001020,
		0,
		Lang.get(71645),
		30001,
		20,
		268,
		{
			RTResTalkAction[3],
			RTResTalkAction[5]
		},
		1,
		nil,
		nil,
		nil,
		31,
		30006,
		nil,
		1,
		nil,
		1,
		nil,
		30006
	},
	[30001021] = {
		30001021,
		0,
		Lang.get(71646),
		30001,
		21,
		268,
		{
			RTResTalkAction[15]
		},
		nil,
		nil,
		3
	},
	[30001022] = {
		30001022,
		0,
		Lang.get(71647),
		30001,
		22,
		268,
		{
			RTResTalkAction[15]
		}
	},
	[30001023] = {
		30001023,
		0,
		Lang.get(71648),
		30001,
		23,
		290,
		{
			RTResTalkAction[16]
		},
		1,
		1
	},
	[30001024] = {
		30001024,
		0,
		Lang.get(71649),
		30001,
		24,
		290,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		30007,
		nil,
		1,
		nil,
		1,
		nil,
		30007
	},
	[30001025] = {
		30001025,
		0,
		Lang.get(71650),
		30001,
		25,
		777,
		{
			RTResTalkAction[2]
		},
		nil,
		0,
		3
	},
	[30001026] = {
		30001026,
		0,
		Lang.get(71651),
		30001,
		26,
		268,
		{
			RTResTalkAction[5]
		},
		1
	},
	[30001027] = {
		30001027,
		0,
		Lang.get(71652),
		30001,
		27,
		782,
		nil,
		1
	},
	[30001028] = {
		30001028,
		0,
		Lang.get(71653),
		30001,
		28,
		777,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		30008,
		nil,
		1,
		nil,
		1,
		nil,
		30008
	},
	[30001029] = {
		30001029,
		3,
		Lang.get(71654),
		30001,
		29,
		605,
		[22] = 1
	},
	[30001030] = {
		30001030,
		0,
		Lang.get(71655),
		30001,
		30,
		782,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[30001031] = {
		30001031,
		0,
		Lang.get(71656),
		30001,
		31,
		268,
		{
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[30001032] = {
		30001032,
		0,
		Lang.get(71657),
		30001,
		32,
		782,
		{
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[30001033] = {
		30001033,
		0,
		Lang.get(71658),
		30001,
		33,
		268,
		{
			RTResTalkAction[15],
			RTResTalkAction[20]
		}
	},
	[30001034] = {
		30001034,
		0,
		Lang.get(71659),
		30001,
		34,
		777,
		{
			RTResTalkAction[16]
		},
		1
	},
	[30001035] = {
		30001035,
		0,
		Lang.get(71660),
		30001,
		35,
		777,
		nil,
		1
	},
	[30001036] = {
		30001036,
		0,
		Lang.get(71661),
		30001,
		36,
		290,
		nil,
		1
	},
	[30001037] = {
		30001037,
		3,
		Lang.get(71662),
		30001,
		37,
		605,
		[22] = 1
	},
	[30001038] = {
		30001038,
		5,
		Lang.get(71663),
		30001,
		38,
		781,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		30009,
		nil,
		1,
		[19] = 30009,
		[17] = 1
	},
	[30002001] = {
		30002001,
		3,
		Lang.get(71664),
		30002,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		30010,
		nil,
		1,
		nil,
		1,
		nil,
		30010,
		nil,
		nil,
		1
	},
	[30002002] = {
		30002002,
		0,
		Lang.get(71665),
		30002,
		2,
		779
	},
	[30002003] = {
		30002003,
		0,
		Lang.get(71666),
		30002,
		3,
		777,
		nil,
		1,
		nil,
		3
	},
	[30002004] = {
		30002004,
		0,
		Lang.get(71667),
		30002,
		4,
		290,
		nil,
		1
	},
	[30002005] = {
		30002005,
		0,
		Lang.get(71668),
		30002,
		5,
		777,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		30011,
		nil,
		1,
		nil,
		1,
		nil,
		30011
	},
	[30002006] = {
		30002006,
		0,
		Lang.get(71669),
		30002,
		6,
		290,
		{
			RTResTalkAction[4]
		},
		nil,
		nil,
		3
	},
	[30002007] = {
		30002007,
		0,
		Lang.get(71670),
		30002,
		7,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30002008] = {
		30002008,
		0,
		Lang.get(71671),
		30002,
		8,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30002009] = {
		30002009,
		0,
		Lang.get(71672),
		30002,
		9,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30002010] = {
		30002010,
		0,
		Lang.get(71673),
		30002,
		10,
		290,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30002011] = {
		30002011,
		0,
		Lang.get(71674),
		30002,
		11,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30002012] = {
		30002012,
		0,
		Lang.get(71675),
		30002,
		12,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30002013] = {
		30002013,
		0,
		Lang.get(71676),
		30002,
		13,
		290,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30002014] = {
		30002014,
		0,
		Lang.get(71677),
		30002,
		14,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30002015] = {
		30002015,
		0,
		Lang.get(71678),
		30002,
		15,
		290,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30002016] = {
		30002016,
		0,
		Lang.get(71679),
		30002,
		16,
		290,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30002017] = {
		30002017,
		3,
		Lang.get(71680),
		30002,
		17,
		605,
		{
			RTResTalkAction[3],
			RTResTalkAction[5]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		30012,
		nil,
		1,
		nil,
		1,
		nil,
		30012,
		nil,
		nil,
		1
	},
	[30002018] = {
		30002018,
		0,
		Lang.get(71681),
		30002,
		18,
		777,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[30002019] = {
		30002019,
		5,
		Lang.get(71682),
		30002,
		19,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[21]
		}
	},
	[30002020] = {
		30002020,
		0,
		Lang.get(71683),
		30002,
		20,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30002021] = {
		30002021,
		0,
		Lang.get(71684),
		30002,
		21,
		290,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30002022] = {
		30002022,
		0,
		Lang.get(71685),
		30002,
		22,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30002023] = {
		30002023,
		0,
		Lang.get(71686),
		30002,
		23,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30002024] = {
		30002024,
		0,
		Lang.get(71687),
		30002,
		24,
		290,
		{
			RTResTalkAction[12],
			RTResTalkAction[11]
		}
	},
	[30002025] = {
		30002025,
		0,
		Lang.get(71688),
		30002,
		25,
		290,
		{
			RTResTalkAction[3],
			RTResTalkAction[5]
		},
		1,
		2,
		nil,
		nil,
		nil,
		30013,
		nil,
		1,
		nil,
		1,
		nil,
		30013
	},
	[30002026] = {
		30002026,
		0,
		Lang.get(71689),
		30002,
		26,
		777,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[30002027] = {
		30002027,
		0,
		Lang.get(71690),
		30002,
		27,
		290,
		{
			RTResTalkAction[14],
			RTResTalkAction[11]
		}
	},
	[30002028] = {
		30002028,
		0,
		Lang.get(71691),
		30002,
		28,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30002029] = {
		30002029,
		0,
		Lang.get(71692),
		30002,
		29,
		290,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30002030] = {
		30002030,
		0,
		Lang.get(71693),
		30002,
		30,
		290,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30002031] = {
		30002031,
		0,
		Lang.get(71694),
		30002,
		31,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30002032] = {
		30002032,
		0,
		Lang.get(71695),
		30002,
		32,
		290,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30002033] = {
		30002033,
		0,
		Lang.get(71696),
		30002,
		33,
		290,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30002034] = {
		30002034,
		0,
		Lang.get(71697),
		30002,
		34,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30003001] = {
		30003001,
		0,
		Lang.get(71698),
		30003,
		1,
		777,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		30014,
		nil,
		1,
		nil,
		1,
		nil,
		30014
	},
	[30003002] = {
		30003002,
		0,
		Lang.get(71699),
		30003,
		2,
		290,
		{
			RTResTalkAction[4]
		},
		nil,
		nil,
		3
	},
	[30003003] = {
		30003003,
		0,
		Lang.get(71700),
		30003,
		3,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30003004] = {
		30003004,
		0,
		Lang.get(71701),
		30003,
		4,
		290,
		{
			RTResTalkAction[12],
			RTResTalkAction[11]
		}
	},
	[30003005] = {
		30003005,
		0,
		Lang.get(71702),
		30003,
		5,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30003006] = {
		30003006,
		0,
		Lang.get(71703),
		30003,
		6,
		290,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30003007] = {
		30003007,
		0,
		Lang.get(71704),
		30003,
		7,
		290,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30003008] = {
		30003008,
		0,
		Lang.get(71705),
		30003,
		8,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30003009] = {
		30003009,
		0,
		Lang.get(71706),
		30003,
		9,
		290,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30003010] = {
		30003010,
		0,
		Lang.get(71707),
		30003,
		10,
		777,
		{
			RTResTalkAction[3],
			RTResTalkAction[5]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		30015,
		nil,
		1,
		nil,
		1,
		nil,
		30015
	},
	[30003011] = {
		30003011,
		0,
		Lang.get(71708),
		30003,
		11,
		777,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[30003012] = {
		30003012,
		0,
		Lang.get(71709),
		30003,
		12,
		290,
		{
			RTResTalkAction[14],
			RTResTalkAction[11]
		}
	},
	[30003013] = {
		30003013,
		0,
		Lang.get(71710),
		30003,
		13,
		290,
		{
			RTResTalkAction[13],
			RTResTalkAction[11]
		}
	},
	[30003014] = {
		30003014,
		0,
		Lang.get(71711),
		30003,
		14,
		782,
		{
			RTResTalkAction[22],
			RTResTalkAction[3],
			RTResTalkAction[5]
		}
	},
	[30003015] = {
		30003015,
		5,
		Lang.get(71712),
		30003,
		15,
		777,
		{
			RTResTalkAction[23],
			RTResTalkAction[20]
		}
	},
	[30004001] = {
		30004001,
		0,
		Lang.get(71713),
		30004,
		1,
		782,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		30016,
		nil,
		1,
		nil,
		1,
		nil,
		30016
	},
	[30004002] = {
		30004002,
		0,
		Lang.get(71714),
		30004,
		2,
		777,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[30004003] = {
		30004003,
		0,
		Lang.get(71715),
		30004,
		3,
		782,
		{
			RTResTalkAction[24],
			RTResTalkAction[19]
		}
	},
	[30004004] = {
		30004004,
		0,
		Lang.get(71716),
		30004,
		4,
		777,
		{
			RTResTalkAction[25],
			RTResTalkAction[20]
		}
	},
	[30004005] = {
		30004005,
		0,
		Lang.get(71717),
		30004,
		5,
		290,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30004006] = {
		30004006,
		0,
		Lang.get(71718),
		30004,
		6,
		782,
		{
			RTResTalkAction[17],
			RTResTalkAction[3],
			RTResTalkAction[5]
		}
	},
	[30004007] = {
		30004007,
		0,
		Lang.get(71719),
		30004,
		7,
		290,
		{
			RTResTalkAction[13],
			RTResTalkAction[11],
			RTResTalkAction[20]
		}
	},
	[30004008] = {
		30004008,
		0,
		Lang.get(71720),
		30004,
		8,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30004009] = {
		30004009,
		0,
		Lang.get(71721),
		30004,
		9,
		782,
		{
			RTResTalkAction[17],
			RTResTalkAction[3],
			RTResTalkAction[5]
		}
	},
	[30004010] = {
		30004010,
		0,
		Lang.get(71722),
		30004,
		10,
		785,
		{
			RTResTalkAction[26],
			RTResTalkAction[27]
		}
	},
	[30004011] = {
		30004011,
		0,
		Lang.get(71723),
		30004,
		11,
		782,
		{
			RTResTalkAction[26],
			RTResTalkAction[27]
		}
	},
	[30004012] = {
		30004012,
		0,
		Lang.get(71724),
		30004,
		12,
		782,
		{
			RTResTalkAction[26],
			RTResTalkAction[27]
		}
	},
	[30004013] = {
		30004013,
		5,
		Lang.get(71725),
		30004,
		13,
		777,
		{
			RTResTalkAction[2],
			RTResTalkAction[20],
			RTResTalkAction[28]
		}
	},
	[30004014] = {
		30004014,
		0,
		Lang.get(71726),
		30004,
		14,
		290,
		{
			RTResTalkAction[14],
			RTResTalkAction[11]
		}
	},
	[30004015] = {
		30004015,
		0,
		Lang.get(71727),
		30004,
		15,
		782,
		{
			RTResTalkAction[17],
			RTResTalkAction[3],
			RTResTalkAction[5]
		}
	},
	[30004016] = {
		30004016,
		0,
		Lang.get(71728),
		30004,
		16,
		290,
		{
			RTResTalkAction[4],
			RTResTalkAction[20]
		}
	},
	[30004017] = {
		30004017,
		0,
		Lang.get(71729),
		30004,
		17,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30004018] = {
		30004018,
		0,
		Lang.get(71730),
		30004,
		18,
		779,
		{
			RTResTalkAction[3],
			RTResTalkAction[5]
		}
	},
	[30004019] = {
		30004019,
		0,
		Lang.get(71731),
		30004,
		19,
		290,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30004020] = {
		30004020,
		0,
		Lang.get(71732),
		30004,
		20,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30004021] = {
		30004021,
		2,
		Lang.get(71733),
		30004,
		21,
		290,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[30005001] = {
		30005001,
		0,
		Lang.get(71734),
		30005,
		1,
		777,
		nil,
		1,
		nil,
		nil,
		nil,
		31,
		30017,
		nil,
		1,
		nil,
		1,
		nil,
		30017
	},
	[30005002] = {
		30005002,
		0,
		Lang.get(71735),
		30005,
		2,
		290,
		{
			RTResTalkAction[4]
		},
		nil,
		nil,
		3
	},
	[30005003] = {
		30005003,
		0,
		Lang.get(71736),
		30005,
		3,
		290,
		{
			RTResTalkAction[4]
		}
	},
	[30005004] = {
		30005004,
		0,
		Lang.get(71737),
		30005,
		4,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30005005] = {
		30005005,
		2,
		Lang.get(71738),
		30005,
		5,
		290,
		{
			RTResTalkAction[1],
			RTResTalkAction[5]
		}
	},
	[30005006] = {
		30005006,
		2,
		Lang.get(71739),
		30005,
		6,
		794,
		{
			RTResTalkAction[29],
			RTResTalkAction[3]
		}
	},
	[30005007] = {
		30005007,
		0,
		Lang.get(71740),
		30005,
		7,
		777,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[30005008] = {
		30005008,
		5,
		Lang.get(71741),
		30005,
		8,
		794,
		{
			RTResTalkAction[32],
			RTResTalkAction[5]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		30018,
		nil,
		1,
		nil,
		1,
		nil,
		30018
	},
	[30005009] = {
		30005009,
		5,
		Lang.get(71742),
		30005,
		9,
		782,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[30005010] = {
		30005010,
		5,
		Lang.get(71743),
		30005,
		10,
		785,
		{
			RTResTalkAction[26],
			RTResTalkAction[27]
		}
	},
	[30005011] = {
		30005011,
		5,
		Lang.get(71744),
		30005,
		11,
		782,
		{
			RTResTalkAction[26],
			RTResTalkAction[27]
		}
	},
	[30005012] = {
		30005012,
		0,
		Lang.get(71745),
		30005,
		12,
		777,
		{
			RTResTalkAction[2],
			RTResTalkAction[20],
			RTResTalkAction[28]
		}
	},
	[30005013] = {
		30005013,
		0,
		Lang.get(71746),
		30005,
		13,
		778,
		{
			RTResTalkAction[5]
		},
		1
	},
	[30005014] = {
		30005014,
		0,
		Lang.get(71747),
		30005,
		14,
		784,
		nil,
		1,
		0,
		nil,
		nil,
		62,
		30019,
		nil,
		1,
		nil,
		1,
		nil,
		30019
	},
	[30005015] = {
		30005015,
		0,
		Lang.get(71748),
		30005,
		15,
		784,
		nil,
		1
	},
	[30005016] = {
		30005016,
		0,
		Lang.get(71749),
		30005,
		16,
		791,
		nil,
		1
	},
	[30005017] = {
		30005017,
		0,
		Lang.get(71750),
		30005,
		17,
		791,
		nil,
		1
	},
	[30005018] = {
		30005018,
		0,
		Lang.get(71751),
		30005,
		18,
		791,
		nil,
		1
	},
	[30005019] = {
		30005019,
		0,
		Lang.get(71752),
		30005,
		19,
		791,
		nil,
		1
	},
	[30005020] = {
		30005020,
		0,
		Lang.get(71753),
		30005,
		20,
		134,
		{
			RTResTalkAction[33]
		},
		nil,
		nil,
		3
	},
	[30005021] = {
		30005021,
		0,
		Lang.get(71754),
		30005,
		21,
		134,
		{
			RTResTalkAction[34]
		}
	},
	[30005022] = {
		30005022,
		0,
		Lang.get(71755),
		30005,
		22,
		300,
		{
			RTResTalkAction[35]
		}
	},
	[30005023] = {
		30005023,
		0,
		Lang.get(71756),
		30005,
		23,
		134,
		{
			RTResTalkAction[33]
		}
	},
	[30005024] = {
		30005024,
		0,
		Lang.get(71757),
		30005,
		24,
		300,
		{
			RTResTalkAction[35]
		}
	},
	[30005025] = {
		30005025,
		0,
		Lang.get(71758),
		30005,
		25,
		134,
		{
			RTResTalkAction[36]
		}
	},
	[30005026] = {
		30005026,
		0,
		Lang.get(71759),
		30005,
		26,
		134,
		{
			RTResTalkAction[37]
		}
	},
	[30005027] = {
		30005027,
		0,
		Lang.get(71760),
		30005,
		27,
		300,
		{
			RTResTalkAction[35]
		}
	},
	[30005028] = {
		30005028,
		0,
		Lang.get(71761),
		30005,
		28,
		134,
		{
			RTResTalkAction[37]
		}
	},
	[30005029] = {
		30005029,
		3,
		Lang.get(71762),
		30005,
		29,
		605,
		{
			RTResTalkAction[35]
		},
		nil,
		nil,
		nil,
		nil,
		31,
		30020,
		nil,
		1,
		nil,
		1,
		nil,
		30020,
		nil,
		nil,
		1
	},
	[30005030] = {
		30005030,
		0,
		Lang.get(71763),
		30005,
		30,
		418,
		{
			RTResTalkAction[38]
		},
		nil,
		nil,
		3
	},
	[30005031] = {
		30005031,
		0,
		Lang.get(71764),
		30005,
		31,
		133,
		{
			RTResTalkAction[38]
		},
		1,
		1,
		[21] = 418
	},
	[30005032] = {
		30005032,
		0,
		Lang.get(71765),
		30005,
		32,
		300,
		{
			RTResTalkAction[38]
		},
		nil,
		0,
		[21] = 418
	},
	[30005033] = {
		30005033,
		0,
		Lang.get(71766),
		30005,
		33,
		133,
		{
			RTResTalkAction[38]
		},
		1,
		1,
		[21] = 418
	},
	[30005034] = {
		30005034,
		0,
		Lang.get(71767),
		30005,
		34,
		300,
		{
			RTResTalkAction[38]
		},
		nil,
		0,
		[21] = 418
	},
	[30005035] = {
		30005035,
		0,
		Lang.get(71768),
		30005,
		35,
		133,
		{
			RTResTalkAction[38]
		},
		1,
		0,
		[21] = 418
	},
	[30005036] = {
		30005036,
		0,
		Lang.get(71769),
		30005,
		36,
		133,
		{
			RTResTalkAction[39],
			RTResTalkAction[40]
		}
	},
	[30005037] = {
		30005037,
		0,
		Lang.get(71770),
		30005,
		37,
		133,
		{
			RTResTalkAction[41]
		}
	},
	[30005038] = {
		30005038,
		0,
		Lang.get(71771),
		30005,
		38,
		300,
		{
			RTResTalkAction[42]
		}
	},
	[30005039] = {
		30005039,
		0,
		Lang.get(72287),
		30005,
		39,
		134,
		{
			RTResTalkAction[43],
			RTResTalkAction[44]
		}
	},
	[30005040] = {
		30005040,
		0,
		Lang.get(71773),
		30005,
		40,
		300,
		{
			RTResTalkAction[42],
			RTResTalkAction[35]
		}
	},
	[30005041] = {
		30005041,
		0,
		Lang.get(71774),
		30005,
		41,
		134,
		{
			RTResTalkAction[43],
			RTResTalkAction[45]
		}
	},
	[30005042] = {
		30005042,
		0,
		Lang.get(71775),
		30005,
		42,
		134,
		{
			RTResTalkAction[43],
			RTResTalkAction[44]
		}
	},
	[30005043] = {
		30005043,
		0,
		Lang.get(71776),
		30005,
		43,
		300,
		{
			RTResTalkAction[42],
			RTResTalkAction[35]
		}
	},
	[30005044] = {
		30005044,
		0,
		Lang.get(71777),
		30005,
		44,
		133,
		{
			RTResTalkAction[46]
		}
	},
	[30006001] = {
		30006001,
		0,
		Lang.get(71778),
		30006,
		1,
		777,
		nil,
		1,
		nil,
		nil,
		nil,
		31,
		30021,
		nil,
		1,
		nil,
		1,
		nil,
		30021
	},
	[30006002] = {
		30006002,
		0,
		Lang.get(71779),
		30006,
		2,
		794,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[30006003] = {
		30006003,
		0,
		Lang.get(71780),
		30006,
		3,
		777,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30006004] = {
		30006004,
		0,
		Lang.get(71781),
		30006,
		4,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30006005] = {
		30006005,
		0,
		Lang.get(71782),
		30006,
		5,
		782,
		{
			RTResTalkAction[17],
			RTResTalkAction[32],
			RTResTalkAction[5]
		}
	},
	[30006006] = {
		30006006,
		0,
		Lang.get(71783),
		30006,
		6,
		785,
		{
			RTResTalkAction[26],
			RTResTalkAction[27]
		}
	},
	[30006007] = {
		30006007,
		0,
		Lang.get(71784),
		30006,
		7,
		782,
		{
			RTResTalkAction[26],
			RTResTalkAction[27]
		}
	},
	[30006008] = {
		30006008,
		0,
		Lang.get(71785),
		30006,
		8,
		785,
		{
			RTResTalkAction[26],
			RTResTalkAction[27]
		}
	},
	[30006009] = {
		30006009,
		0,
		Lang.get(71786),
		30006,
		9,
		777,
		{
			RTResTalkAction[2],
			RTResTalkAction[20],
			RTResTalkAction[28]
		}
	},
	[30006010] = {
		30006010,
		0,
		Lang.get(71787),
		30006,
		10,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30006011] = {
		30006011,
		0,
		Lang.get(71788),
		30006,
		11,
		777,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30006012] = {
		30006012,
		0,
		Lang.get(71789),
		30006,
		12,
		777,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30006013] = {
		30006013,
		0,
		Lang.get(71790),
		30006,
		13,
		794,
		{
			RTResTalkAction[32],
			RTResTalkAction[5]
		},
		1,
		nil,
		nil,
		nil,
		58,
		30022,
		nil,
		1,
		nil,
		1,
		nil,
		30022
	},
	[30006014] = {
		30006014,
		0,
		Lang.get(71791),
		30006,
		14,
		794,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[30006015] = {
		30006015,
		0,
		Lang.get(71792),
		30006,
		15,
		777,
		{
			RTResTalkAction[29]
		}
	},
	[30006016] = {
		30006016,
		0,
		Lang.get(71793),
		30006,
		16,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30006017] = {
		30006017,
		0,
		Lang.get(71794),
		30006,
		17,
		777,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30006018] = {
		30006018,
		0,
		Lang.get(71795),
		30006,
		18,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30006019] = {
		30006019,
		0,
		Lang.get(71796),
		30006,
		19,
		777,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30006020] = {
		30006020,
		0,
		Lang.get(71797),
		30006,
		20,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30006021] = {
		30006021,
		0,
		Lang.get(71798),
		30006,
		21,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30006022] = {
		30006022,
		0,
		Lang.get(71799),
		30006,
		22,
		777,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30006023] = {
		30006023,
		0,
		Lang.get(71800),
		30006,
		23,
		777,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30006024] = {
		30006024,
		0,
		Lang.get(71801),
		30006,
		24,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30006025] = {
		30006025,
		0,
		Lang.get(71802),
		30006,
		25,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30006026] = {
		30006026,
		0,
		Lang.get(71803),
		30006,
		26,
		777,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30006027] = {
		30006027,
		0,
		Lang.get(71804),
		30006,
		27,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30006028] = {
		30006028,
		0,
		Lang.get(71805),
		30006,
		28,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30006029] = {
		30006029,
		0,
		Lang.get(71806),
		30006,
		29,
		777,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30006030] = {
		30006030,
		0,
		Lang.get(71807),
		30006,
		30,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30006031] = {
		30006031,
		0,
		Lang.get(71808),
		30006,
		31,
		777,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30006032] = {
		30006032,
		0,
		Lang.get(71809),
		30006,
		32,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30006033] = {
		30006033,
		0,
		Lang.get(71810),
		30006,
		33,
		777,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30006034] = {
		30006034,
		0,
		Lang.get(71811),
		30006,
		34,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30006035] = {
		30006035,
		0,
		Lang.get(71812),
		30006,
		35,
		777,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30006036] = {
		30006036,
		0,
		Lang.get(71813),
		30006,
		36,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30006037] = {
		30006037,
		0,
		Lang.get(71814),
		30006,
		37,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30006038] = {
		30006038,
		0,
		Lang.get(71815),
		30006,
		38,
		777,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30007001] = {
		30007001,
		3,
		Lang.get(71816),
		30007,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		25,
		30023,
		nil,
		1,
		nil,
		1,
		nil,
		30023,
		nil,
		nil,
		1
	},
	[30007002] = {
		30007002,
		0,
		Lang.get(71817),
		30007,
		2,
		794,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[30007003] = {
		30007003,
		0,
		Lang.get(71818),
		30007,
		3,
		12,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30007004] = {
		30007004,
		0,
		Lang.get(71819),
		30007,
		4,
		12,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30007005] = {
		30007005,
		0,
		Lang.get(71820),
		30007,
		5,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30007006] = {
		30007006,
		0,
		Lang.get(71821),
		30007,
		6,
		12,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30007007] = {
		30007007,
		0,
		Lang.get(71822),
		30007,
		7,
		12,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30007008] = {
		30007008,
		0,
		Lang.get(71823),
		30007,
		8,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30007009] = {
		30007009,
		0,
		Lang.get(71824),
		30007,
		9,
		12,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30007010] = {
		30007010,
		0,
		Lang.get(71825),
		30007,
		10,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30007011] = {
		30007011,
		0,
		Lang.get(71826),
		30007,
		11,
		12,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30007012] = {
		30007012,
		0,
		Lang.get(71827),
		30007,
		12,
		12,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30007013] = {
		30007013,
		0,
		Lang.get(71828),
		30007,
		13,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30007014] = {
		30007014,
		0,
		Lang.get(71829),
		30007,
		14,
		790,
		{
			RTResTalkAction[32],
			RTResTalkAction[48]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		30024,
		nil,
		1,
		nil,
		1,
		nil,
		30024
	},
	[30007015] = {
		30007015,
		0,
		Lang.get(71830),
		30007,
		15,
		794,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[30007016] = {
		30007016,
		0,
		Lang.get(71831),
		30007,
		16,
		12,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30008001] = {
		30008001,
		0,
		Lang.get(71832),
		30008,
		1,
		12,
		nil,
		1,
		nil,
		nil,
		nil,
		25,
		30025,
		nil,
		1,
		nil,
		1,
		nil,
		30025
	},
	[30008002] = {
		30008002,
		0,
		Lang.get(71833),
		30008,
		2,
		794,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[30008003] = {
		30008003,
		0,
		Lang.get(71834),
		30008,
		3,
		790,
		{
			RTResTalkAction[49],
			RTResTalkAction[32]
		}
	},
	[30008004] = {
		30008004,
		0,
		Lang.get(71835),
		30008,
		4,
		12,
		{
			RTResTalkAction[50],
			RTResTalkAction[51]
		}
	},
	[30008005] = {
		30008005,
		0,
		Lang.get(71836),
		30008,
		5,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30008006] = {
		30008006,
		0,
		Lang.get(71837),
		30008,
		6,
		12,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30008007] = {
		30008007,
		0,
		Lang.get(71838),
		30008,
		7,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30008008] = {
		30008008,
		0,
		Lang.get(71839),
		30008,
		8,
		790,
		{
			RTResTalkAction[49],
			RTResTalkAction[32],
			RTResTalkAction[48]
		}
	},
	[30008009] = {
		30008009,
		0,
		Lang.get(71840),
		30008,
		9,
		794,
		{
			RTResTalkAction[29],
			RTResTalkAction[51]
		}
	},
	[30008010] = {
		30008010,
		0,
		Lang.get(71841),
		30008,
		10,
		12,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30008011] = {
		30008011,
		0,
		Lang.get(71842),
		30008,
		11,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30008012] = {
		30008012,
		0,
		Lang.get(71843),
		30008,
		12,
		12,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30008013] = {
		30008013,
		0,
		Lang.get(71844),
		30008,
		13,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30008014] = {
		30008014,
		0,
		Lang.get(71845),
		30008,
		14,
		12,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30008015] = {
		30008015,
		0,
		Lang.get(71846),
		30008,
		15,
		12,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30009001] = {
		30009001,
		0,
		Lang.get(71847),
		30009,
		1,
		794,
		nil,
		1,
		nil,
		nil,
		nil,
		31,
		30026,
		nil,
		1,
		nil,
		1,
		nil,
		30026
	},
	[30009002] = {
		30009002,
		0,
		Lang.get(71848),
		30009,
		2,
		12,
		{
			RTResTalkAction[50]
		},
		nil,
		nil,
		3
	},
	[30009003] = {
		30009003,
		0,
		Lang.get(71849),
		30009,
		3,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30009004] = {
		30009004,
		0,
		Lang.get(71850),
		30009,
		4,
		12,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30009005] = {
		30009005,
		0,
		Lang.get(71851),
		30009,
		5,
		12,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30009006] = {
		30009006,
		0,
		Lang.get(71852),
		30009,
		6,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30009007] = {
		30009007,
		0,
		Lang.get(71853),
		30009,
		7,
		12,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30009008] = {
		30009008,
		0,
		Lang.get(71854),
		30009,
		8,
		12,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30009009] = {
		30009009,
		0,
		Lang.get(71855),
		30009,
		9,
		12,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30009010] = {
		30009010,
		0,
		Lang.get(71856),
		30009,
		10,
		12,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30009011] = {
		30009011,
		0,
		Lang.get(71857),
		30009,
		11,
		12,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30009012] = {
		30009012,
		0,
		Lang.get(71858),
		30009,
		12,
		12,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30009013] = {
		30009013,
		0,
		Lang.get(71859),
		30009,
		13,
		12,
		{
			RTResTalkAction[32],
			RTResTalkAction[48]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		30027,
		nil,
		1,
		nil,
		1,
		nil,
		30027
	},
	[30009014] = {
		30009014,
		0,
		Lang.get(71860),
		30009,
		14,
		794,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[30009015] = {
		30009015,
		0,
		Lang.get(71861),
		30009,
		15,
		12,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30009016] = {
		30009016,
		0,
		Lang.get(71862),
		30009,
		16,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30009017] = {
		30009017,
		0,
		Lang.get(71863),
		30009,
		17,
		12,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30009018] = {
		30009018,
		0,
		Lang.get(71864),
		30009,
		18,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30009019] = {
		30009019,
		0,
		Lang.get(71865),
		30009,
		19,
		12,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30009020] = {
		30009020,
		0,
		Lang.get(71866),
		30009,
		20,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30009021] = {
		30009021,
		0,
		Lang.get(71867),
		30009,
		21,
		12,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30009022] = {
		30009022,
		0,
		Lang.get(71868),
		30009,
		22,
		12,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30009023] = {
		30009023,
		0,
		Lang.get(71869),
		30009,
		23,
		794,
		{
			RTResTalkAction[32],
			RTResTalkAction[48]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		30028,
		nil,
		1,
		nil,
		1,
		nil,
		30028
	},
	[30009024] = {
		30009024,
		0,
		Lang.get(71870),
		30009,
		24,
		794,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[30009025] = {
		30009025,
		0,
		Lang.get(71871),
		30009,
		25,
		794,
		{
			RTResTalkAction[29]
		}
	},
	[30009026] = {
		30009026,
		0,
		Lang.get(71872),
		30009,
		26,
		12,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30009027] = {
		30009027,
		0,
		Lang.get(71873),
		30009,
		27,
		12,
		{
			RTResTalkAction[30],
			RTResTalkAction[47]
		}
	},
	[30009028] = {
		30009028,
		3,
		Lang.get(75773),
		30009,
		28,
		605,
		{
			RTResTalkAction[32],
			RTResTalkAction[48]
		},
		[22] = 1
	},
	[30009029] = {
		30009029,
		5,
		Lang.get(71741),
		30009,
		29,
		12,
		{
			RTResTalkAction[52]
		}
	},
	[30009030] = {
		30009030,
		5,
		Lang.get(71875),
		30009,
		30,
		790,
		{
			RTResTalkAction[49],
			RTResTalkAction[48]
		}
	},
	[30009031] = {
		30009031,
		0,
		Lang.get(71876),
		30009,
		31,
		794,
		{
			RTResTalkAction[29],
			RTResTalkAction[51]
		}
	},
	[30009032] = {
		30009032,
		3,
		Lang.get(71877),
		30009,
		32,
		605,
		{
			RTResTalkAction[32]
		},
		[22] = 1
	},
	[30009033] = {
		30009033,
		0,
		Lang.get(71878),
		30009,
		33,
		794,
		{
			RTResTalkAction[53]
		}
	},
	[30010001] = {
		30010001,
		0,
		Lang.get(71879),
		30010,
		1,
		790,
		nil,
		1,
		nil,
		nil,
		nil,
		31,
		30029,
		nil,
		1,
		nil,
		1,
		nil,
		30029
	},
	[30010002] = {
		30010002,
		0,
		Lang.get(71880),
		30010,
		2,
		792,
		{
			RTResTalkAction[54]
		},
		nil,
		nil,
		3
	},
	[30010003] = {
		30010003,
		0,
		Lang.get(71881),
		30010,
		3,
		300,
		{
			RTResTalkAction[55]
		}
	},
	[30010004] = {
		30010004,
		0,
		Lang.get(71882),
		30010,
		4,
		133,
		{
			RTResTalkAction[39]
		}
	},
	[30010005] = {
		30010005,
		5,
		Lang.get(71883),
		30010,
		5,
		790,
		{
			RTResTalkAction[49],
			RTResTalkAction[42]
		}
	},
	[30010006] = {
		30010006,
		5,
		Lang.get(71884),
		30010,
		6,
		792,
		{
			RTResTalkAction[56],
			RTResTalkAction[57]
		}
	},
	[30010007] = {
		30010007,
		5,
		Lang.get(71885),
		30010,
		7,
		790,
		{
			RTResTalkAction[56],
			RTResTalkAction[57]
		}
	},
	[30010008] = {
		30010008,
		3,
		Lang.get(71886),
		30010,
		8,
		133,
		{
			RTResTalkAction[51],
			RTResTalkAction[55]
		},
		1,
		1,
		nil,
		nil,
		nil,
		30030,
		nil,
		1,
		nil,
		1,
		nil,
		30030,
		nil,
		nil,
		1
	},
	[30010009] = {
		30010009,
		0,
		Lang.get(71887),
		30010,
		9,
		134,
		{
			RTResTalkAction[36]
		},
		nil,
		nil,
		3
	},
	[30010010] = {
		30010010,
		0,
		Lang.get(71888),
		30010,
		10,
		300,
		{
			RTResTalkAction[35]
		}
	},
	[30010011] = {
		30010011,
		0,
		Lang.get(71889),
		30010,
		11,
		133,
		{
			RTResTalkAction[58],
			RTResTalkAction[59]
		}
	},
	[30010012] = {
		30010012,
		0,
		Lang.get(71890),
		30010,
		12,
		134,
		{
			RTResTalkAction[60],
			RTResTalkAction[61]
		}
	},
	[30010013] = {
		30010013,
		0,
		Lang.get(71891),
		30010,
		13,
		300,
		{
			RTResTalkAction[35],
			RTResTalkAction[42]
		}
	},
	[30010014] = {
		30010014,
		0,
		Lang.get(71892),
		30010,
		14,
		134,
		{
			RTResTalkAction[33]
		}
	},
	[30010015] = {
		30010015,
		5,
		Lang.get(71893),
		30010,
		15,
		790,
		{
			RTResTalkAction[58],
			RTResTalkAction[62]
		}
	},
	[30010016] = {
		30010016,
		0,
		Lang.get(71894),
		30010,
		16,
		134,
		{
			RTResTalkAction[63],
			RTResTalkAction[62]
		}
	},
	[30010017] = {
		30010017,
		0,
		Lang.get(71895),
		30010,
		17,
		790,
		{
			RTResTalkAction[35],
			RTResTalkAction[51]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		30031,
		nil,
		1,
		nil,
		1,
		nil,
		30031
	},
	[30010018] = {
		30010018,
		0,
		Lang.get(71896),
		30010,
		18,
		300
	},
	[30010019] = {
		30010019,
		0,
		Lang.get(71897),
		30010,
		19,
		300
	},
	[30010020] = {
		30010020,
		5,
		Lang.get(71898),
		30010,
		20,
		792,
		{
			RTResTalkAction[54]
		},
		nil,
		nil,
		3
	},
	[30010021] = {
		30010021,
		0,
		Lang.get(71899),
		30010,
		21,
		133,
		{
			RTResTalkAction[64],
			RTResTalkAction[55]
		}
	},
	[30010022] = {
		30010022,
		5,
		Lang.get(71900),
		30010,
		22,
		790,
		{
			RTResTalkAction[56],
			RTResTalkAction[57],
			RTResTalkAction[42]
		}
	},
	[30010023] = {
		30010023,
		0,
		Lang.get(71901),
		30010,
		23,
		133,
		{
			RTResTalkAction[65],
			RTResTalkAction[51],
			RTResTalkAction[55]
		}
	},
	[30010024] = {
		30010024,
		0,
		Lang.get(71902),
		30010,
		24,
		133,
		{
			RTResTalkAction[39]
		}
	},
	[30010025] = {
		30010025,
		0,
		Lang.get(71903),
		30010,
		25,
		300,
		{
			RTResTalkAction[42]
		}
	},
	[30010026] = {
		30010026,
		0,
		Lang.get(71904),
		30010,
		26,
		133,
		{
			RTResTalkAction[66]
		}
	},
	[30010027] = {
		30010027,
		0,
		Lang.get(71905),
		30010,
		27,
		792,
		{
			RTResTalkAction[56],
			RTResTalkAction[57],
			RTResTalkAction[42]
		}
	},
	[30010028] = {
		30010028,
		0,
		Lang.get(71906),
		30010,
		28,
		133,
		{
			RTResTalkAction[39],
			RTResTalkAction[51],
			RTResTalkAction[55]
		}
	},
	[30010029] = {
		30010029,
		0,
		Lang.get(71907),
		30010,
		29,
		790,
		{
			RTResTalkAction[56],
			RTResTalkAction[57],
			RTResTalkAction[42]
		}
	},
	[30010030] = {
		30010030,
		0,
		Lang.get(71908),
		30010,
		30,
		134,
		{
			RTResTalkAction[33],
			RTResTalkAction[51],
			RTResTalkAction[55]
		}
	},
	[30010031] = {
		30010031,
		0,
		Lang.get(71909),
		30010,
		31,
		134,
		{
			RTResTalkAction[37]
		}
	},
	[30010032] = {
		30010032,
		0,
		Lang.get(71910),
		30010,
		32,
		792,
		{
			RTResTalkAction[56],
			RTResTalkAction[57],
			RTResTalkAction[35]
		}
	},
	[30010033] = {
		30010033,
		0,
		Lang.get(71911),
		30010,
		33,
		133,
		{
			RTResTalkAction[64],
			RTResTalkAction[51],
			RTResTalkAction[55]
		}
	},
	[30010034] = {
		30010034,
		0,
		Lang.get(71912),
		30010,
		34,
		790,
		{
			RTResTalkAction[56],
			RTResTalkAction[57],
			RTResTalkAction[42]
		}
	},
	[30010035] = {
		30010035,
		0,
		Lang.get(71913),
		30010,
		35,
		133,
		{
			RTResTalkAction[39],
			RTResTalkAction[51],
			RTResTalkAction[55]
		}
	},
	[30010036] = {
		30010036,
		0,
		Lang.get(71914),
		30010,
		36,
		300,
		{
			RTResTalkAction[42]
		}
	},
	[30010037] = {
		30010037,
		0,
		Lang.get(71915),
		30010,
		37,
		792,
		{
			RTResTalkAction[56],
			RTResTalkAction[57]
		}
	},
	[30010038] = {
		30010038,
		0,
		Lang.get(71916),
		30010,
		38,
		133,
		{
			RTResTalkAction[66],
			RTResTalkAction[51],
			RTResTalkAction[55]
		}
	},
	[30010039] = {
		30010039,
		0,
		Lang.get(71917),
		30010,
		39,
		134,
		{
			RTResTalkAction[67],
			RTResTalkAction[61]
		}
	},
	[30010040] = {
		30010040,
		0,
		Lang.get(71918),
		30010,
		40,
		790,
		{
			RTResTalkAction[49],
			RTResTalkAction[35],
			RTResTalkAction[42]
		}
	},
	[30010041] = {
		30010041,
		0,
		Lang.get(71919),
		30010,
		41,
		134,
		{
			RTResTalkAction[33],
			RTResTalkAction[51]
		}
	},
	[30010042] = {
		30010042,
		0,
		Lang.get(71920),
		30010,
		42,
		133,
		{
			RTResTalkAction[58],
			RTResTalkAction[61]
		}
	},
	[30011001] = {
		30011001,
		0,
		Lang.get(71921),
		30011,
		1,
		794,
		nil,
		1,
		nil,
		nil,
		nil,
		31,
		30032,
		nil,
		1,
		nil,
		1,
		nil,
		30032
	},
	[30011002] = {
		30011002,
		0,
		Lang.get(71922),
		30011,
		2,
		788,
		{
			RTResTalkAction[68]
		},
		nil,
		nil,
		3
	},
	[30011003] = {
		30011003,
		0,
		Lang.get(71923),
		30011,
		3,
		788,
		{
			RTResTalkAction[68]
		}
	},
	[30011004] = {
		30011004,
		0,
		Lang.get(71924),
		30011,
		4,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[69]
		}
	},
	[30011005] = {
		30011005,
		0,
		Lang.get(71925),
		30011,
		5,
		788,
		{
			RTResTalkAction[30],
			RTResTalkAction[69]
		}
	},
	[30011006] = {
		30011006,
		0,
		Lang.get(71926),
		30011,
		6,
		794,
		{
			RTResTalkAction[32],
			RTResTalkAction[70]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		30033,
		nil,
		1,
		nil,
		1,
		nil,
		30033
	},
	[30011007] = {
		30011007,
		0,
		Lang.get(71927),
		30011,
		7,
		788,
		{
			RTResTalkAction[68]
		},
		nil,
		nil,
		3
	},
	[30011008] = {
		30011008,
		0,
		Lang.get(71928),
		30011,
		8,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[69]
		}
	},
	[30011009] = {
		30011009,
		0,
		Lang.get(71929),
		30011,
		9,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[69]
		}
	},
	[30011010] = {
		30011010,
		0,
		Lang.get(71930),
		30011,
		10,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[69]
		}
	},
	[30011011] = {
		30011011,
		0,
		Lang.get(71931),
		30011,
		11,
		788,
		{
			RTResTalkAction[68],
			RTResTalkAction[32]
		}
	},
	[30012001] = {
		30012001,
		0,
		Lang.get(71932),
		30012,
		1,
		794,
		nil,
		1,
		nil,
		nil,
		nil,
		31,
		30034,
		nil,
		1,
		nil,
		1,
		nil,
		30034
	},
	[30012002] = {
		30012002,
		0,
		Lang.get(71933),
		30012,
		2,
		788,
		{
			RTResTalkAction[68]
		},
		nil,
		nil,
		3
	},
	[30012003] = {
		30012003,
		0,
		Lang.get(75774),
		30012,
		3,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[69]
		}
	},
	[30012004] = {
		30012004,
		0,
		Lang.get(71935),
		30012,
		4,
		788,
		{
			RTResTalkAction[30],
			RTResTalkAction[69]
		}
	},
	[30012005] = {
		30012005,
		0,
		Lang.get(71936),
		30012,
		5,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[69]
		}
	},
	[30012006] = {
		30012006,
		0,
		Lang.get(71937),
		30012,
		6,
		788,
		{
			RTResTalkAction[30],
			RTResTalkAction[69]
		}
	},
	[30012007] = {
		30012007,
		0,
		Lang.get(71938),
		30012,
		7,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[69]
		}
	},
	[30012008] = {
		30012008,
		3,
		Lang.get(71939),
		30012,
		8,
		605,
		{
			RTResTalkAction[32],
			RTResTalkAction[70]
		},
		[22] = 1
	},
	[30012009] = {
		30012009,
		2,
		Lang.get(71940),
		30012,
		9,
		794,
		{
			RTResTalkAction[29]
		}
	},
	[30012010] = {
		30012010,
		2,
		Lang.get(71941),
		30012,
		10,
		794,
		{
			RTResTalkAction[29]
		}
	},
	[30013001] = {
		30013001,
		3,
		Lang.get(71942),
		30013,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		31,
		30035,
		nil,
		1,
		nil,
		1,
		nil,
		30035,
		nil,
		nil,
		1
	},
	[30013002] = {
		30013002,
		0,
		Lang.get(71943),
		30013,
		2,
		789,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		30036,
		nil,
		1,
		nil,
		1,
		nil,
		30036,
		255
	},
	[30013003] = {
		30013003,
		0,
		Lang.get(71944),
		30013,
		3,
		789
	},
	[30013004] = {
		30013004,
		0,
		Lang.get(71945),
		30013,
		4,
		789
	},
	[30013005] = {
		30013005,
		0,
		Lang.get(71946),
		30013,
		5,
		789
	},
	[30013006] = {
		30013006,
		0,
		Lang.get(71947),
		30013,
		6,
		789
	},
	[30013007] = {
		30013007,
		0,
		Lang.get(71948),
		30013,
		7,
		794,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3,
		[20] = -1
	},
	[30013008] = {
		30013008,
		0,
		Lang.get(71949),
		30013,
		8,
		777,
		{
			RTResTalkAction[32]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		30037,
		nil,
		1,
		nil,
		1,
		nil,
		30037
	},
	[30013009] = {
		30013009,
		5,
		Lang.get(71950),
		30013,
		9,
		794,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[30013010] = {
		30013010,
		0,
		Lang.get(71951),
		30013,
		10,
		777,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30013011] = {
		30013011,
		0,
		Lang.get(71952),
		30013,
		11,
		794,
		{
			RTResTalkAction[32],
			RTResTalkAction[5]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		30038,
		nil,
		1,
		nil,
		1,
		nil,
		30038
	},
	[30013012] = {
		30013012,
		0,
		Lang.get(71953),
		30013,
		12,
		777,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[30013013] = {
		30013013,
		0,
		Lang.get(71954),
		30013,
		13,
		777,
		{
			RTResTalkAction[2]
		}
	},
	[30013014] = {
		30013014,
		0,
		Lang.get(71955),
		30013,
		14,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30013015] = {
		30013015,
		0,
		Lang.get(71956),
		30013,
		15,
		777,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30013016] = {
		30013016,
		0,
		Lang.get(71957),
		30013,
		16,
		777,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30013017] = {
		30013017,
		0,
		Lang.get(71958),
		30013,
		17,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30013018] = {
		30013018,
		0,
		Lang.get(71959),
		30013,
		18,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30013019] = {
		30013019,
		0,
		Lang.get(71960),
		30013,
		19,
		777,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30013020] = {
		30013020,
		0,
		Lang.get(71961),
		30013,
		20,
		777,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30013021] = {
		30013021,
		0,
		Lang.get(71962),
		30013,
		21,
		777,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30013022] = {
		30013022,
		0,
		Lang.get(71963),
		30013,
		22,
		777,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30013023] = {
		30013023,
		0,
		Lang.get(71964),
		30013,
		23,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30013024] = {
		30013024,
		0,
		Lang.get(71965),
		30013,
		24,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30013025] = {
		30013025,
		0,
		Lang.get(71966),
		30013,
		25,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30013026] = {
		30013026,
		0,
		Lang.get(71967),
		30013,
		26,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30013027] = {
		30013027,
		0,
		Lang.get(71968),
		30013,
		27,
		777,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30013028] = {
		30013028,
		0,
		Lang.get(71969),
		30013,
		28,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30013029] = {
		30013029,
		0,
		Lang.get(71970),
		30013,
		29,
		777,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30013030] = {
		30013030,
		0,
		Lang.get(71971),
		30013,
		30,
		777,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30013031] = {
		30013031,
		0,
		Lang.get(71972),
		30013,
		31,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30013032] = {
		30013032,
		0,
		Lang.get(71973),
		30013,
		32,
		777,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30013033] = {
		30013033,
		0,
		Lang.get(71974),
		30013,
		33,
		777,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30013034] = {
		30013034,
		0,
		Lang.get(71975),
		30013,
		34,
		777,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30013035] = {
		30013035,
		0,
		Lang.get(71976),
		30013,
		35,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30013036] = {
		30013036,
		0,
		Lang.get(71977),
		30013,
		36,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30013037] = {
		30013037,
		0,
		Lang.get(71978),
		30013,
		37,
		794,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30013038] = {
		30013038,
		0,
		Lang.get(71979),
		30013,
		38,
		777,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[30014001] = {
		30014001,
		0,
		Lang.get(71980),
		30014,
		1,
		133,
		nil,
		1,
		nil,
		nil,
		nil,
		31,
		30039,
		nil,
		1,
		nil,
		1,
		nil,
		30039
	},
	[30014002] = {
		30014002,
		5,
		Lang.get(71981),
		30014,
		2,
		782,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[30014003] = {
		30014003,
		5,
		Lang.get(71982),
		30014,
		3,
		785,
		{
			RTResTalkAction[26],
			RTResTalkAction[27]
		}
	},
	[30014004] = {
		30014004,
		0,
		Lang.get(71983),
		30014,
		4,
		133,
		{
			RTResTalkAction[65],
			RTResTalkAction[20],
			RTResTalkAction[28]
		}
	},
	[30014005] = {
		30014005,
		0,
		Lang.get(71984),
		30014,
		5,
		300,
		{
			RTResTalkAction[42]
		}
	},
	[30014006] = {
		30014006,
		0,
		Lang.get(71985),
		30014,
		6,
		133,
		{
			RTResTalkAction[39]
		}
	},
	[30014007] = {
		30014007,
		0,
		Lang.get(71986),
		30014,
		7,
		134,
		{
			RTResTalkAction[60],
			RTResTalkAction[61]
		}
	},
	[30014008] = {
		30014008,
		0,
		Lang.get(71987),
		30014,
		8,
		133,
		{
			RTResTalkAction[58],
			RTResTalkAction[71]
		}
	},
	[30014009] = {
		30014009,
		0,
		Lang.get(71988),
		30014,
		9,
		300,
		{
			RTResTalkAction[35],
			RTResTalkAction[42]
		}
	},
	[30014010] = {
		30014010,
		0,
		Lang.get(71989),
		30014,
		10,
		134,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		30040,
		nil,
		1,
		nil,
		1,
		nil,
		30040
	},
	[30014011] = {
		30014011,
		0,
		Lang.get(71990),
		30014,
		11,
		133,
		{
			RTResTalkAction[39]
		},
		nil,
		nil,
		3
	},
	[30014012] = {
		30014012,
		0,
		Lang.get(71991),
		30014,
		12,
		133,
		{
			RTResTalkAction[66]
		}
	},
	[30014013] = {
		30014013,
		0,
		Lang.get(71992),
		30014,
		13,
		300,
		{
			RTResTalkAction[42]
		}
	},
	[30014014] = {
		30014014,
		0,
		Lang.get(71993),
		30014,
		14,
		133,
		{
			RTResTalkAction[39]
		}
	},
	[30014015] = {
		30014015,
		0,
		Lang.get(71994),
		30014,
		15,
		133,
		{
			RTResTalkAction[65]
		}
	},
	[30014016] = {
		30014016,
		0,
		Lang.get(71995),
		30014,
		16,
		134,
		{
			RTResTalkAction[60],
			RTResTalkAction[61]
		}
	},
	[30014017] = {
		30014017,
		0,
		Lang.get(71996),
		30014,
		17,
		300,
		{
			RTResTalkAction[35],
			RTResTalkAction[42]
		}
	},
	[30014018] = {
		30014018,
		0,
		Lang.get(71997),
		30014,
		18,
		133,
		{
			RTResTalkAction[41]
		}
	},
	[30014019] = {
		30014019,
		0,
		Lang.get(71998),
		30014,
		19,
		300,
		{
			RTResTalkAction[42]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		30041,
		nil,
		1,
		[19] = 30041,
		[17] = 1
	},
	[30014020] = {
		30014020,
		0,
		Lang.get(71999),
		30014,
		20,
		134,
		{
			RTResTalkAction[72]
		},
		nil,
		nil,
		3
	},
	[30014021] = {
		30014021,
		0,
		Lang.get(72000),
		30014,
		21,
		300,
		{
			RTResTalkAction[35]
		}
	},
	[30014022] = {
		30014022,
		0,
		Lang.get(72001),
		30014,
		22,
		133,
		{
			RTResTalkAction[58],
			RTResTalkAction[59]
		}
	},
	[30014023] = {
		30014023,
		0,
		Lang.get(72002),
		30014,
		23,
		134,
		{
			RTResTalkAction[60],
			RTResTalkAction[61]
		}
	},
	[30014024] = {
		30014024,
		0,
		Lang.get(72003),
		30014,
		24,
		300,
		{
			RTResTalkAction[35],
			RTResTalkAction[42]
		}
	},
	[30014025] = {
		30014025,
		0,
		Lang.get(72004),
		30014,
		25,
		134,
		{
			RTResTalkAction[33]
		}
	},
	[30014026] = {
		30014026,
		0,
		Lang.get(72005),
		30014,
		26,
		788,
		{
			RTResTalkAction[35]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		30042,
		nil,
		1,
		nil,
		1,
		nil,
		30042
	},
	[30014027] = {
		30014027,
		0,
		Lang.get(72006),
		30014,
		27,
		300
	},
	[30014028] = {
		30014028,
		0,
		Lang.get(72007),
		30014,
		28,
		134,
		{
			RTResTalkAction[37]
		},
		nil,
		nil,
		3
	},
	[30014029] = {
		30014029,
		0,
		Lang.get(72008),
		30014,
		29,
		133,
		{
			RTResTalkAction[58],
			RTResTalkAction[61]
		}
	},
	[30014030] = {
		30014030,
		0,
		Lang.get(72009),
		30014,
		30,
		133,
		{
			RTResTalkAction[58],
			RTResTalkAction[61]
		}
	},
	[30014031] = {
		30014031,
		0,
		Lang.get(72010),
		30014,
		31,
		133,
		{
			RTResTalkAction[58],
			RTResTalkAction[59]
		}
	},
	[30014032] = {
		30014032,
		0,
		Lang.get(72011),
		30014,
		32,
		133,
		{
			RTResTalkAction[58],
			RTResTalkAction[73]
		}
	},
	[30014033] = {
		30014033,
		0,
		Lang.get(72012),
		30014,
		33,
		134,
		{
			RTResTalkAction[74],
			RTResTalkAction[61]
		}
	},
	[30014034] = {
		30014034,
		0,
		Lang.get(72013),
		30014,
		34,
		777,
		{
			RTResTalkAction[35],
			RTResTalkAction[42]
		},
		1
	},
	[30015001] = {
		30015001,
		3,
		Lang.get(72014),
		30015,
		1,
		134,
		nil,
		1,
		3,
		nil,
		nil,
		31,
		30043,
		nil,
		1,
		nil,
		1,
		nil,
		30043,
		nil,
		nil,
		1
	},
	[30015002] = {
		30015002,
		0,
		Lang.get(72015),
		30015,
		2,
		777,
		{
			RTResTalkAction[2]
		},
		nil,
		0,
		3
	},
	[30015003] = {
		30015003,
		0,
		Lang.get(75775),
		30015,
		3,
		300,
		{
			RTResTalkAction[5]
		}
	},
	[30015004] = {
		30015004,
		0,
		Lang.get(72017),
		30015,
		4,
		134,
		{
			RTResTalkAction[72]
		}
	},
	[30015005] = {
		30015005,
		0,
		Lang.get(72018),
		30015,
		5,
		133,
		{
			RTResTalkAction[58],
			RTResTalkAction[61]
		}
	},
	[30015006] = {
		30015006,
		0,
		Lang.get(72019),
		30015,
		6,
		777,
		{
			RTResTalkAction[25],
			RTResTalkAction[35],
			RTResTalkAction[42]
		}
	},
	[30015007] = {
		30015007,
		0,
		Lang.get(72020),
		30015,
		7,
		777,
		{
			RTResTalkAction[2]
		}
	},
	[30015008] = {
		30015008,
		0,
		Lang.get(72021),
		30015,
		8,
		133,
		{
			RTResTalkAction[24],
			RTResTalkAction[61]
		}
	},
	[30015009] = {
		30015009,
		0,
		Lang.get(72022),
		30015,
		9,
		777,
		{
			RTResTalkAction[24],
			RTResTalkAction[61]
		}
	},
	[30015010] = {
		30015010,
		0,
		Lang.get(72023),
		30015,
		10,
		133,
		{
			RTResTalkAction[24],
			RTResTalkAction[61]
		}
	},
	[30015011] = {
		30015011,
		0,
		Lang.get(72024),
		30015,
		11,
		300,
		{
			RTResTalkAction[5],
			RTResTalkAction[42]
		}
	},
	[30015012] = {
		30015012,
		0,
		Lang.get(72025),
		30015,
		12,
		300
	},
	[30015013] = {
		30015013,
		0,
		Lang.get(72026),
		30015,
		13,
		777,
		{
			RTResTalkAction[2]
		}
	},
	[30015014] = {
		30015014,
		0,
		Lang.get(72027),
		30015,
		14,
		777,
		{
			RTResTalkAction[2]
		}
	},
	[30015015] = {
		30015015,
		0,
		Lang.get(72028),
		30015,
		15,
		300,
		{
			RTResTalkAction[5]
		}
	},
	[30015016] = {
		30015016,
		0,
		Lang.get(72029),
		30015,
		16,
		777,
		{
			RTResTalkAction[2]
		}
	},
	[30015017] = {
		30015017,
		0,
		Lang.get(72030),
		30015,
		17,
		777,
		{
			RTResTalkAction[2]
		}
	},
	[30015018] = {
		30015018,
		0,
		Lang.get(72031),
		30015,
		18,
		300,
		{
			RTResTalkAction[5]
		}
	},
	[30015019] = {
		30015019,
		0,
		Lang.get(72032),
		30015,
		19,
		134,
		{
			RTResTalkAction[75]
		}
	},
	[30015020] = {
		30015020,
		0,
		Lang.get(72033),
		30015,
		20,
		777,
		{
			RTResTalkAction[58],
			RTResTalkAction[11]
		}
	},
	[30015021] = {
		30015021,
		0,
		Lang.get(72034),
		30015,
		21,
		777,
		{
			RTResTalkAction[58],
			RTResTalkAction[11]
		}
	},
	[30015022] = {
		30015022,
		0,
		Lang.get(72035),
		30015,
		22,
		133,
		{
			RTResTalkAction[24],
			RTResTalkAction[61],
			RTResTalkAction[35]
		}
	},
	[30015023] = {
		30015023,
		0,
		Lang.get(72036),
		30015,
		23,
		133,
		{
			RTResTalkAction[24],
			RTResTalkAction[61]
		}
	},
	[30015024] = {
		30015024,
		0,
		Lang.get(72037),
		30015,
		24,
		777,
		{
			RTResTalkAction[24],
			RTResTalkAction[61]
		}
	},
	[30015025] = {
		30015025,
		0,
		Lang.get(72038),
		30015,
		25,
		133,
		{
			RTResTalkAction[24],
			RTResTalkAction[61]
		}
	},
	[30015026] = {
		30015026,
		0,
		Lang.get(72039),
		30015,
		26,
		133,
		{
			RTResTalkAction[24],
			RTResTalkAction[61]
		}
	},
	[30015027] = {
		30015027,
		0,
		Lang.get(72040),
		30015,
		27,
		300,
		{
			RTResTalkAction[5],
			RTResTalkAction[42]
		}
	},
	[30015028] = {
		30015028,
		0,
		Lang.get(72041),
		30015,
		28,
		777,
		{
			RTResTalkAction[2]
		}
	},
	[30015029] = {
		30015029,
		0,
		Lang.get(72042),
		30015,
		29,
		300,
		{
			RTResTalkAction[5]
		}
	},
	[30015030] = {
		30015030,
		0,
		Lang.get(72043),
		30015,
		30,
		133,
		{
			RTResTalkAction[24],
			RTResTalkAction[61]
		}
	},
	[30015031] = {
		30015031,
		0,
		Lang.get(72044),
		30015,
		31,
		300,
		{
			RTResTalkAction[5],
			RTResTalkAction[42]
		}
	},
	[30015032] = {
		30015032,
		0,
		Lang.get(72045),
		30015,
		32,
		777,
		{
			RTResTalkAction[2]
		}
	},
	[30015033] = {
		30015033,
		0,
		Lang.get(72046),
		30015,
		33,
		777,
		{
			RTResTalkAction[2]
		}
	},
	[30015034] = {
		30015034,
		0,
		Lang.get(72047),
		30015,
		34,
		777,
		{
			RTResTalkAction[2]
		}
	},
	[30015035] = {
		30015035,
		0,
		Lang.get(72048),
		30015,
		35,
		777,
		{
			RTResTalkAction[2]
		}
	},
	[30015036] = {
		30015036,
		0,
		Lang.get(72049),
		30015,
		36,
		777,
		{
			RTResTalkAction[2]
		}
	},
	[30015037] = {
		30015037,
		0,
		Lang.get(72050),
		30015,
		37,
		300,
		{
			RTResTalkAction[5]
		}
	},
	[30015038] = {
		30015038,
		0,
		Lang.get(72051),
		30015,
		38,
		134,
		{
			RTResTalkAction[37]
		}
	},
	[30015039] = {
		30015039,
		0,
		Lang.get(72052),
		30015,
		39,
		133,
		{
			RTResTalkAction[58],
			RTResTalkAction[59]
		}
	},
	[30015040] = {
		30015040,
		0,
		Lang.get(72053),
		30015,
		40,
		300,
		{
			RTResTalkAction[35],
			RTResTalkAction[42]
		}
	},
	[30015041] = {
		30015041,
		0,
		Lang.get(72054),
		30015,
		41,
		777,
		{
			RTResTalkAction[2]
		}
	},
	[30015042] = {
		30015042,
		0,
		Lang.get(72055),
		30015,
		42,
		777,
		{
			RTResTalkAction[2]
		}
	},
	[30015043] = {
		30015043,
		0,
		Lang.get(72056),
		30015,
		43,
		300,
		{
			RTResTalkAction[5]
		}
	},
	[30016001] = {
		30016001,
		0,
		Lang.get(72057),
		30016,
		1,
		795,
		nil,
		1,
		nil,
		nil,
		nil,
		57,
		30044,
		nil,
		1,
		nil,
		1,
		nil,
		30044
	},
	[30016002] = {
		30016002,
		0,
		Lang.get(72058),
		30016,
		2,
		769,
		nil,
		1,
		1,
		3
	},
	[30016003] = {
		30016003,
		0,
		Lang.get(72059),
		30016,
		3,
		769,
		nil,
		1,
		2
	},
	[30016004] = {
		30016004,
		0,
		Lang.get(72060),
		30016,
		4,
		795,
		{
			RTResTalkAction[76]
		},
		nil,
		0
	},
	[30016005] = {
		30016005,
		0,
		Lang.get(72061),
		30016,
		5,
		769,
		{
			RTResTalkAction[77]
		},
		1,
		3,
		nil,
		nil,
		nil,
		30045,
		nil,
		1,
		nil,
		1,
		nil,
		30045
	},
	[30016006] = {
		30016006,
		0,
		Lang.get(72062),
		30016,
		6,
		769,
		{
			RTResTalkAction[78]
		},
		nil,
		nil,
		3
	},
	[30016007] = {
		30016007,
		0,
		Lang.get(72063),
		30016,
		7,
		769,
		{
			RTResTalkAction[79]
		}
	},
	[30016008] = {
		30016008,
		0,
		Lang.get(72064),
		30016,
		8,
		795,
		{
			RTResTalkAction[80],
			RTResTalkAction[81]
		}
	},
	[30016009] = {
		30016009,
		0,
		Lang.get(74313),
		30016,
		9,
		769,
		{
			RTResTalkAction[80],
			RTResTalkAction[82]
		}
	},
	[30016010] = {
		30016010,
		0,
		Lang.get(72066),
		30016,
		10,
		795,
		{
			RTResTalkAction[77],
			RTResTalkAction[83]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		30046,
		nil,
		1,
		nil,
		1,
		nil,
		30046
	},
	[30016011] = {
		30016011,
		0,
		Lang.get(72067),
		30016,
		11,
		769,
		{
			RTResTalkAction[84]
		},
		nil,
		nil,
		3
	},
	[30016012] = {
		30016012,
		0,
		Lang.get(72068),
		30016,
		12,
		795,
		{
			RTResTalkAction[80],
			RTResTalkAction[81]
		}
	},
	[30016013] = {
		30016013,
		0,
		Lang.get(72069),
		30016,
		13,
		769,
		{
			RTResTalkAction[80],
			RTResTalkAction[82]
		}
	},
	[30017001] = {
		30017001,
		0,
		Lang.get(16770),
		30017,
		1,
		795,
		nil,
		1,
		nil,
		nil,
		nil,
		57,
		30047,
		nil,
		1,
		nil,
		1,
		nil,
		30047
	},
	[30017002] = {
		30017002,
		0,
		Lang.get(72070),
		30017,
		2,
		769,
		{
			RTResTalkAction[85]
		},
		nil,
		nil,
		3
	},
	[30017003] = {
		30017003,
		0,
		Lang.get(72071),
		30017,
		3,
		777,
		{
			RTResTalkAction[83]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		30048,
		nil,
		1,
		nil,
		1,
		nil,
		30048
	},
	[30017004] = {
		30017004,
		0,
		Lang.get(72072),
		30017,
		4,
		769,
		{
			RTResTalkAction[84]
		},
		nil,
		nil,
		3
	},
	[30017005] = {
		30017005,
		0,
		Lang.get(72073),
		30017,
		5,
		769,
		{
			RTResTalkAction[86]
		}
	},
	[30017006] = {
		30017006,
		0,
		Lang.get(72074),
		30017,
		6,
		769,
		{
			RTResTalkAction[87]
		}
	},
	[30018001] = {
		30018001,
		0,
		Lang.get(72075),
		30018,
		1,
		777,
		nil,
		1,
		nil,
		nil,
		nil,
		57,
		30049,
		nil,
		1,
		nil,
		1,
		nil,
		30049
	},
	[30018002] = {
		30018002,
		0,
		Lang.get(72076),
		30018,
		2,
		300
	},
	[30018003] = {
		30018003,
		0,
		Lang.get(72077),
		30018,
		3,
		134,
		{
			RTResTalkAction[72]
		},
		nil,
		nil,
		3
	},
	[30018004] = {
		30018004,
		0,
		Lang.get(72078),
		30018,
		4,
		133,
		{
			RTResTalkAction[58],
			RTResTalkAction[61]
		}
	},
	[30018005] = {
		30018005,
		0,
		Lang.get(72079),
		30018,
		5,
		300,
		{
			RTResTalkAction[35],
			RTResTalkAction[42]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		30050,
		nil,
		1,
		[19] = 30050,
		[17] = 1
	},
	[30018006] = {
		30018006,
		0,
		Lang.get(72080),
		30018,
		6,
		134,
		{
			RTResTalkAction[75]
		},
		nil,
		nil,
		3
	},
	[30018007] = {
		30018007,
		5,
		Lang.get(72081),
		30018,
		7,
		795,
		{
			RTResTalkAction[88],
			RTResTalkAction[35]
		}
	},
	[30019001] = {
		30019001,
		0,
		Lang.get(72082),
		30019,
		1,
		133,
		nil,
		1,
		1,
		nil,
		nil,
		57,
		30051,
		nil,
		1,
		nil,
		1,
		nil,
		30051
	},
	[30019002] = {
		30019002,
		0,
		Lang.get(72083),
		30019,
		2,
		134,
		{
			RTResTalkAction[36]
		},
		nil,
		0,
		3
	},
	[30019003] = {
		30019003,
		5,
		Lang.get(72084),
		30019,
		3,
		795,
		{
			RTResTalkAction[35]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		30052,
		nil,
		1,
		nil,
		1,
		nil,
		30052
	},
	[30019004] = {
		30019004,
		0,
		Lang.get(72085),
		30019,
		4,
		134,
		{
			RTResTalkAction[75]
		},
		nil,
		nil,
		3
	},
	[30019005] = {
		30019005,
		0,
		Lang.get(72086),
		30019,
		5,
		133,
		{
			RTResTalkAction[58],
			RTResTalkAction[59]
		}
	},
	[30019006] = {
		30019006,
		0,
		Lang.get(72087),
		30019,
		6,
		777,
		{
			RTResTalkAction[2],
			RTResTalkAction[35],
			RTResTalkAction[42]
		}
	},
	[30019007] = {
		30019007,
		0,
		Lang.get(72088),
		30019,
		7,
		300,
		{
			RTResTalkAction[5]
		}
	},
	[30020001] = {
		30020001,
		0,
		Lang.get(72089),
		30020,
		1,
		134,
		nil,
		1,
		4,
		nil,
		nil,
		57,
		30053,
		nil,
		1,
		nil,
		1,
		nil,
		30053
	},
	[30020002] = {
		30020002,
		0,
		Lang.get(72090),
		30020,
		2,
		133,
		{
			RTResTalkAction[64]
		},
		nil,
		0,
		3
	},
	[30020003] = {
		30020003,
		0,
		Lang.get(72091),
		30020,
		3,
		300,
		{
			RTResTalkAction[42]
		}
	},
	[30020004] = {
		30020004,
		0,
		Lang.get(72092),
		30020,
		4,
		134,
		{
			RTResTalkAction[37]
		}
	},
	[30020005] = {
		30020005,
		0,
		Lang.get(72093),
		30020,
		5,
		300,
		{
			RTResTalkAction[35]
		}
	},
	[30020006] = {
		30020006,
		0,
		Lang.get(72094),
		30020,
		6,
		133,
		{
			RTResTalkAction[66]
		}
	},
	[30020007] = {
		30020007,
		0,
		Lang.get(72095),
		30020,
		7,
		300,
		{
			RTResTalkAction[42]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		30054,
		nil,
		1,
		[19] = 30054,
		[17] = 1
	},
	[30020008] = {
		30020008,
		0,
		Lang.get(72096),
		30020,
		8,
		777,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[30020009] = {
		30020009,
		5,
		Lang.get(72084),
		30020,
		9,
		795,
		{
			RTResTalkAction[5]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		30055,
		nil,
		1,
		nil,
		1,
		nil,
		30055
	},
	[30020010] = {
		30020010,
		0,
		Lang.get(72097),
		30020,
		10,
		777,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[30020011] = {
		30020011,
		5,
		Lang.get(72098),
		30020,
		11,
		777,
		{
			RTResTalkAction[2]
		}
	},
	[30020012] = {
		30020012,
		0,
		Lang.get(72099),
		30020,
		12,
		795,
		{
			RTResTalkAction[80],
			RTResTalkAction[11]
		}
	},
	[30020013] = {
		30020013,
		0,
		Lang.get(72100),
		30020,
		13,
		300,
		{
			RTResTalkAction[77],
			RTResTalkAction[5]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		30056,
		nil,
		1,
		[19] = 30056,
		[17] = 1
	},
	[30020014] = {
		30020014,
		0,
		Lang.get(72101),
		30020,
		14,
		793,
		{
			RTResTalkAction[89]
		},
		nil,
		nil,
		3
	},
	[30020015] = {
		30020015,
		0,
		Lang.get(72102),
		30020,
		15,
		777,
		{
			RTResTalkAction[90],
			RTResTalkAction[11]
		}
	},
	[30020016] = {
		30020016,
		5,
		Lang.get(72103),
		30020,
		16,
		782,
		{
			RTResTalkAction[90],
			RTResTalkAction[11]
		}
	},
	[30021001] = {
		30021001,
		0,
		Lang.get(72104),
		30021,
		1,
		777,
		nil,
		1,
		nil,
		nil,
		nil,
		59,
		30057,
		nil,
		1,
		nil,
		1,
		nil,
		30057
	},
	[30021002] = {
		30021002,
		0,
		Lang.get(72105),
		30021,
		2,
		777,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[30022001] = {
		30022001,
		0,
		Lang.get(72106),
		30022,
		1,
		133,
		nil,
		1,
		nil,
		nil,
		nil,
		57,
		30058,
		nil,
		1,
		nil,
		1,
		nil,
		30058
	},
	[30022002] = {
		30022002,
		0,
		Lang.get(72107),
		30022,
		2,
		134,
		{
			RTResTalkAction[37]
		},
		nil,
		nil,
		3
	},
	[30022003] = {
		30022003,
		0,
		Lang.get(72108),
		30022,
		3,
		133,
		{
			RTResTalkAction[58],
			RTResTalkAction[61]
		}
	},
	[30022004] = {
		30022004,
		0,
		Lang.get(72109),
		30022,
		4,
		782,
		{
			RTResTalkAction[17],
			RTResTalkAction[35],
			RTResTalkAction[42]
		}
	},
	[30022005] = {
		30022005,
		0,
		Lang.get(72110),
		30022,
		5,
		134,
		{
			RTResTalkAction[33],
			RTResTalkAction[20]
		}
	},
	[30022006] = {
		30022006,
		0,
		Lang.get(72111),
		30022,
		6,
		133,
		{
			RTResTalkAction[58],
			RTResTalkAction[61]
		}
	},
	[30022007] = {
		30022007,
		0,
		Lang.get(72112),
		30022,
		7,
		134,
		{
			RTResTalkAction[60],
			RTResTalkAction[61]
		}
	},
	[30022008] = {
		30022008,
		0,
		Lang.get(72113),
		30022,
		8,
		134,
		{
			RTResTalkAction[67],
			RTResTalkAction[61]
		}
	},
	[30022009] = {
		30022009,
		0,
		Lang.get(72114),
		30022,
		9,
		133,
		{
			RTResTalkAction[58],
			RTResTalkAction[59]
		}
	},
	[30022010] = {
		30022010,
		0,
		Lang.get(72115),
		30022,
		10,
		134,
		{
			RTResTalkAction[91],
			RTResTalkAction[61]
		}
	},
	[30022011] = {
		30022011,
		0,
		Lang.get(72116),
		30022,
		11,
		133,
		{
			RTResTalkAction[35],
			RTResTalkAction[42]
		},
		1,
		1,
		nil,
		nil,
		nil,
		30059,
		nil,
		1,
		nil,
		1,
		nil,
		30059
	},
	[30022012] = {
		30022012,
		0,
		Lang.get(72117),
		30022,
		12,
		133,
		{
			RTResTalkAction[64]
		},
		nil,
		0,
		3
	},
	[30022013] = {
		30022013,
		5,
		Lang.get(72118),
		30022,
		13,
		291,
		{
			RTResTalkAction[92],
			RTResTalkAction[42]
		}
	},
	[30022014] = {
		30022014,
		0,
		Lang.get(72119),
		30022,
		14,
		769,
		{
			RTResTalkAction[93],
			RTResTalkAction[94]
		}
	},
	[30022015] = {
		30022015,
		0,
		Lang.get(72120),
		30022,
		15,
		769,
		{
			RTResTalkAction[93],
			RTResTalkAction[95]
		}
	},
	[30022016] = {
		30022016,
		3,
		Lang.get(72121),
		30022,
		16,
		605,
		{
			RTResTalkAction[96],
			RTResTalkAction[83]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		30060,
		nil,
		1,
		nil,
		1,
		nil,
		30060,
		nil,
		nil,
		1
	},
	[30022017] = {
		30022017,
		0,
		Lang.get(72122),
		30022,
		17,
		769,
		{
			RTResTalkAction[84]
		},
		nil,
		nil,
		3
	},
	[30022018] = {
		30022018,
		0,
		Lang.get(72123),
		30022,
		18,
		769,
		{
			RTResTalkAction[83]
		},
		1,
		3,
		nil,
		nil,
		nil,
		30061,
		nil,
		1,
		nil,
		1,
		nil,
		30061
	},
	[30022019] = {
		30022019,
		0,
		Lang.get(72124),
		30022,
		19,
		134,
		{
			RTResTalkAction[75]
		},
		nil,
		0,
		3
	},
	[30022020] = {
		30022020,
		0,
		Lang.get(72125),
		30022,
		20,
		769,
		{
			RTResTalkAction[58],
			RTResTalkAction[97]
		}
	},
	[30022021] = {
		30022021,
		0,
		Lang.get(72126),
		30022,
		21,
		134,
		{
			RTResTalkAction[91],
			RTResTalkAction[81]
		}
	},
	[30022022] = {
		30022022,
		0,
		Lang.get(72127),
		30022,
		22,
		769,
		{
			RTResTalkAction[58],
			RTResTalkAction[98]
		}
	},
	[30022023] = {
		30022023,
		0,
		Lang.get(72128),
		30022,
		23,
		300,
		{
			RTResTalkAction[35],
			RTResTalkAction[83]
		}
	},
	[30022024] = {
		30022024,
		5,
		Lang.get(72129),
		30022,
		24,
		291,
		nil,
		1
	},
	[30022025] = {
		30022025,
		0,
		Lang.get(72130),
		30022,
		25,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		30062,
		nil,
		1,
		[19] = 30062,
		[17] = 1
	},
	[30022026] = {
		30022026,
		0,
		Lang.get(72131),
		30022,
		26,
		134,
		{
			RTResTalkAction[75]
		},
		nil,
		nil,
		3
	},
	[30022027] = {
		30022027,
		5,
		Lang.get(72132),
		30022,
		27,
		777,
		{
			RTResTalkAction[25],
			RTResTalkAction[35]
		}
	},
	[30022028] = {
		30022028,
		0,
		Lang.get(72133),
		30022,
		28,
		300,
		{
			RTResTalkAction[5]
		}
	},
	[30022029] = {
		30022029,
		0,
		Lang.get(72134),
		30022,
		29,
		134,
		{
			RTResTalkAction[36]
		}
	},
	[30022030] = {
		30022030,
		0,
		Lang.get(72135),
		30022,
		30,
		133,
		{
			RTResTalkAction[58],
			RTResTalkAction[59]
		}
	},
	[30022031] = {
		30022031,
		0,
		Lang.get(72136),
		30022,
		31,
		769,
		{
			RTResTalkAction[87],
			RTResTalkAction[35],
			RTResTalkAction[42]
		}
	},
	[30022032] = {
		30022032,
		0,
		Lang.get(72137),
		30022,
		32,
		300,
		{
			RTResTalkAction[83]
		}
	},
	[30022033] = {
		30022033,
		0,
		Lang.get(72138),
		30022,
		33,
		300
	},
	[30022034] = {
		30022034,
		5,
		Lang.get(72139),
		30022,
		34,
		291,
		{
			RTResTalkAction[99]
		}
	},
	[30023001] = {
		30023001,
		0,
		Lang.get(72140),
		30023,
		1,
		133,
		nil,
		1,
		nil,
		nil,
		nil,
		57,
		30063,
		nil,
		1,
		nil,
		1,
		nil,
		30063
	},
	[30023002] = {
		30023002,
		0,
		Lang.get(72141),
		30023,
		2,
		300
	},
	[30023003] = {
		30023003,
		0,
		Lang.get(72142),
		30023,
		3,
		777,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[30023004] = {
		30023004,
		0,
		Lang.get(72143),
		30023,
		4,
		300,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		30064,
		nil,
		1,
		[19] = 30064,
		[17] = 1
	},
	[30023005] = {
		30023005,
		0,
		Lang.get(72144),
		30023,
		5,
		769,
		{
			RTResTalkAction[84]
		},
		nil,
		nil,
		3
	},
	[30023006] = {
		30023006,
		0,
		Lang.get(72145),
		30023,
		6,
		777,
		{
			RTResTalkAction[100],
			RTResTalkAction[11]
		}
	},
	[30023007] = {
		30023007,
		0,
		Lang.get(72146),
		30023,
		7,
		769,
		{
			RTResTalkAction[83],
			RTResTalkAction[5]
		},
		1,
		1,
		nil,
		nil,
		nil,
		30065,
		nil,
		1,
		nil,
		1,
		nil,
		30065
	},
	[30023008] = {
		30023008,
		5,
		Lang.get(72147),
		30023,
		8,
		291,
		{
			RTResTalkAction[99]
		},
		nil,
		0,
		3
	},
	[30023009] = {
		30023009,
		0,
		Lang.get(72148),
		30023,
		9,
		769,
		{
			RTResTalkAction[101],
			RTResTalkAction[96]
		}
	},
	[30024001] = {
		30024001,
		0,
		Lang.get(72149),
		30024,
		1,
		769,
		nil,
		1,
		5,
		nil,
		nil,
		57,
		30066,
		nil,
		1,
		nil,
		1,
		nil,
		30066
	},
	[30024002] = {
		30024002,
		0,
		Lang.get(72150),
		30024,
		2,
		769,
		{
			RTResTalkAction[78]
		},
		nil,
		0,
		3
	},
	[30024003] = {
		30024003,
		0,
		Lang.get(72151),
		30024,
		3,
		769,
		{
			RTResTalkAction[86]
		}
	},
	[30024004] = {
		30024004,
		0,
		Lang.get(72152),
		30024,
		4,
		777,
		{
			RTResTalkAction[100],
			RTResTalkAction[11]
		}
	},
	[30024005] = {
		30024005,
		0,
		Lang.get(72153),
		30024,
		5,
		769,
		{
			RTResTalkAction[102],
			RTResTalkAction[5]
		}
	},
	[30024006] = {
		30024006,
		0,
		Lang.get(72154),
		30024,
		6,
		769,
		{
			RTResTalkAction[79]
		}
	},
	[30024007] = {
		30024007,
		0,
		Lang.get(72155),
		30024,
		7,
		300,
		{
			RTResTalkAction[83]
		}
	},
	[30024008] = {
		30024008,
		0,
		Lang.get(72156),
		30024,
		8,
		134,
		{
			RTResTalkAction[75]
		}
	},
	[30024009] = {
		30024009,
		0,
		Lang.get(72157),
		30024,
		9,
		133,
		{
			RTResTalkAction[35]
		},
		1,
		1,
		nil,
		nil,
		59,
		30067,
		nil,
		1,
		nil,
		1,
		nil,
		30067
	},
	[30024010] = {
		30024010,
		0,
		Lang.get(72158),
		30024,
		10,
		133,
		{
			RTResTalkAction[39]
		},
		nil,
		0,
		3
	},
	[30024011] = {
		30024011,
		0,
		Lang.get(72159),
		30024,
		11,
		134,
		{
			RTResTalkAction[67],
			RTResTalkAction[61]
		}
	},
	[30024012] = {
		30024012,
		0,
		Lang.get(72160),
		30024,
		12,
		300,
		{
			RTResTalkAction[35],
			RTResTalkAction[42]
		}
	},
	[30024013] = {
		30024013,
		0,
		Lang.get(72161),
		30024,
		13,
		300
	},
	[30024014] = {
		30024014,
		0,
		Lang.get(72162),
		30024,
		14,
		134,
		{
			RTResTalkAction[72]
		}
	},
	[30024015] = {
		30024015,
		0,
		Lang.get(72163),
		30024,
		15,
		300,
		{
			RTResTalkAction[35]
		}
	},
	[30024016] = {
		30024016,
		0,
		Lang.get(72164),
		30024,
		16,
		300
	},
	[30024017] = {
		30024017,
		0,
		Lang.get(72165),
		30024,
		17,
		777,
		{
			RTResTalkAction[2]
		}
	},
	[30024018] = {
		30024018,
		0,
		Lang.get(72166),
		30024,
		18,
		777,
		{
			RTResTalkAction[2]
		}
	},
	[30024019] = {
		30024019,
		0,
		Lang.get(72167),
		30024,
		19,
		133,
		{
			RTResTalkAction[64],
			RTResTalkAction[5]
		}
	},
	[30024020] = {
		30024020,
		0,
		Lang.get(72168),
		30024,
		20,
		300,
		{
			RTResTalkAction[42]
		}
	},
	[30024021] = {
		30024021,
		0,
		Lang.get(74314),
		30024,
		21,
		300
	},
	[30024022] = {
		30024022,
		3,
		Lang.get(72170),
		30024,
		22,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		30068,
		nil,
		1,
		nil,
		1,
		nil,
		30068,
		nil,
		nil,
		1
	},
	[30024023] = {
		30024023,
		5,
		Lang.get(72171),
		30024,
		23,
		300
	},
	[30024024] = {
		30024024,
		5,
		Lang.get(20546),
		30024,
		24,
		133,
		{
			RTResTalkAction[64]
		},
		nil,
		nil,
		3
	},
	[30024025] = {
		30024025,
		0,
		Lang.get(72172),
		30024,
		25,
		777,
		{
			RTResTalkAction[2],
			RTResTalkAction[42]
		}
	},
	[30024026] = {
		30024026,
		0,
		Lang.get(72173),
		30024,
		26,
		777,
		{
			RTResTalkAction[2]
		}
	},
	[30024027] = {
		30024027,
		0,
		Lang.get(72174),
		30024,
		27,
		777,
		{
			RTResTalkAction[2]
		}
	},
	[30024028] = {
		30024028,
		0,
		Lang.get(72175),
		30024,
		28,
		777,
		{
			RTResTalkAction[2]
		}
	},
	[30024029] = {
		30024029,
		0,
		Lang.get(72176),
		30024,
		29,
		777,
		{
			RTResTalkAction[2]
		}
	},
	[30024030] = {
		30024030,
		0,
		Lang.get(72177),
		30024,
		30,
		291,
		{
			RTResTalkAction[5]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		30069,
		nil,
		1,
		nil,
		1,
		nil,
		30069
	},
	[30024031] = {
		30024031,
		0,
		Lang.get(72178),
		30024,
		31,
		291,
		{
			RTResTalkAction[103]
		},
		nil,
		nil,
		3
	},
	[30024032] = {
		30024032,
		0,
		Lang.get(72179),
		30024,
		32,
		291,
		{
			RTResTalkAction[103]
		}
	},
	[30024033] = {
		30024033,
		0,
		Lang.get(72180),
		30024,
		33,
		291,
		{
			RTResTalkAction[103]
		}
	},
	[30024034] = {
		30024034,
		0,
		Lang.get(72181),
		30024,
		34,
		134,
		{
			RTResTalkAction[75],
			RTResTalkAction[96]
		}
	},
	[30024035] = {
		30024035,
		0,
		Lang.get(72182),
		30024,
		35,
		133,
		{
			RTResTalkAction[58],
			RTResTalkAction[59]
		}
	},
	[30024036] = {
		30024036,
		0,
		Lang.get(72183),
		30024,
		36,
		300,
		{
			RTResTalkAction[35],
			RTResTalkAction[42]
		}
	},
	[30024037] = {
		30024037,
		0,
		Lang.get(72184),
		30024,
		37,
		300
	},
	[30024038] = {
		30024038,
		0,
		Lang.get(72185),
		30024,
		38,
		300
	},
	[30024039] = {
		30024039,
		0,
		Lang.get(72186),
		30024,
		39,
		133,
		{
			RTResTalkAction[66]
		}
	},
	[30024040] = {
		30024040,
		0,
		Lang.get(72187),
		30024,
		40,
		300,
		{
			RTResTalkAction[42]
		}
	},
	[30024041] = {
		30024041,
		0,
		Lang.get(72188),
		30024,
		41,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		30070,
		nil,
		1,
		[19] = 30070,
		[17] = 1
	},
	[30024042] = {
		30024042,
		0,
		Lang.get(72189),
		30024,
		42,
		291,
		{
			RTResTalkAction[103]
		},
		nil,
		nil,
		3
	},
	[30024043] = {
		30024043,
		0,
		Lang.get(72190),
		30024,
		43,
		777,
		{
			RTResTalkAction[93],
			RTResTalkAction[11]
		}
	},
	[30024044] = {
		30024044,
		0,
		Lang.get(72191),
		30024,
		44,
		291,
		{
			RTResTalkAction[93],
			RTResTalkAction[11]
		}
	},
	[30024045] = {
		30024045,
		0,
		Lang.get(72192),
		30024,
		45,
		134,
		{
			RTResTalkAction[33],
			RTResTalkAction[96],
			RTResTalkAction[5]
		}
	},
	[30024046] = {
		30024046,
		0,
		Lang.get(72193),
		30024,
		46,
		133,
		{
			RTResTalkAction[58],
			RTResTalkAction[104]
		}
	},
	[30024047] = {
		30024047,
		0,
		Lang.get(72194),
		30024,
		47,
		777,
		{
			RTResTalkAction[93],
			RTResTalkAction[11],
			RTResTalkAction[35],
			RTResTalkAction[42]
		}
	},
	[30024048] = {
		30024048,
		0,
		Lang.get(72195),
		30024,
		48,
		291,
		{
			RTResTalkAction[93],
			RTResTalkAction[11]
		}
	},
	[30024049] = {
		30024049,
		0,
		Lang.get(72196),
		30024,
		49,
		300,
		{
			RTResTalkAction[96],
			RTResTalkAction[5]
		}
	},
	[30025001] = {
		30025001,
		0,
		Lang.get(72197),
		30025,
		1,
		133,
		nil,
		1,
		nil,
		nil,
		nil,
		58,
		30071,
		nil,
		1,
		nil,
		1,
		nil,
		30071
	},
	[30025002] = {
		30025002,
		0,
		Lang.get(72198),
		30025,
		2,
		133,
		{
			RTResTalkAction[39]
		},
		nil,
		nil,
		3
	},
	[30025003] = {
		30025003,
		0,
		Lang.get(72199),
		30025,
		3,
		134,
		{
			RTResTalkAction[60],
			RTResTalkAction[61]
		}
	},
	[30025004] = {
		30025004,
		0,
		Lang.get(72200),
		30025,
		4,
		782,
		{
			RTResTalkAction[17],
			RTResTalkAction[35],
			RTResTalkAction[42]
		}
	},
	[30025005] = {
		30025005,
		0,
		Lang.get(72201),
		30025,
		5,
		133,
		{
			RTResTalkAction[58],
			RTResTalkAction[59],
			RTResTalkAction[20]
		}
	},
	[30025006] = {
		30025006,
		0,
		Lang.get(72202),
		30025,
		6,
		300,
		{
			RTResTalkAction[35],
			RTResTalkAction[42]
		}
	},
	[30025007] = {
		30025007,
		0,
		Lang.get(72203),
		30025,
		7,
		133,
		{
			RTResTalkAction[66]
		}
	},
	[30025008] = {
		30025008,
		0,
		Lang.get(72204),
		30025,
		8,
		133,
		{
			RTResTalkAction[41]
		}
	},
	[30025009] = {
		30025009,
		0,
		Lang.get(72205),
		30025,
		9,
		300,
		{
			RTResTalkAction[42]
		}
	},
	[30025010] = {
		30025010,
		0,
		Lang.get(72206),
		30025,
		10,
		777,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		30072,
		nil,
		1,
		nil,
		1,
		nil,
		30072
	},
	[30025011] = {
		30025011,
		0,
		Lang.get(72207),
		30025,
		11,
		300
	},
	[30025012] = {
		30025012,
		0,
		Lang.get(72208),
		30025,
		12,
		290,
		{
			RTResTalkAction[105]
		},
		nil,
		nil,
		3
	},
	[30025013] = {
		30025013,
		0,
		Lang.get(72209),
		30025,
		13,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30025014] = {
		30025014,
		0,
		Lang.get(72210),
		30025,
		14,
		290,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30025015] = {
		30025015,
		0,
		Lang.get(72211),
		30025,
		15,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30025016] = {
		30025016,
		0,
		Lang.get(72212),
		30025,
		16,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30025017] = {
		30025017,
		0,
		Lang.get(72213),
		30025,
		17,
		300,
		{
			RTResTalkAction[3],
			RTResTalkAction[5]
		}
	},
	[30025018] = {
		30025018,
		0,
		Lang.get(72214),
		30025,
		18,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30025019] = {
		30025019,
		0,
		Lang.get(72215),
		30025,
		19,
		290,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30025020] = {
		30025020,
		0,
		Lang.get(72216),
		30025,
		20,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30025021] = {
		30025021,
		0,
		Lang.get(72217),
		30025,
		21,
		290,
		{
			RTResTalkAction[12],
			RTResTalkAction[11]
		}
	},
	[30025022] = {
		30025022,
		0,
		Lang.get(72218),
		30025,
		22,
		777,
		{
			RTResTalkAction[3],
			RTResTalkAction[5]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		30073,
		nil,
		1,
		nil,
		1,
		nil,
		30073
	},
	[30025023] = {
		30025023,
		0,
		Lang.get(72219),
		30025,
		23,
		290,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[30025024] = {
		30025024,
		0,
		Lang.get(72220),
		30025,
		24,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30025025] = {
		30025025,
		0,
		Lang.get(72221),
		30025,
		25,
		290,
		{
			RTResTalkAction[106],
			RTResTalkAction[11]
		}
	},
	[30025026] = {
		30025026,
		0,
		Lang.get(72222),
		30025,
		26,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30025027] = {
		30025027,
		0,
		Lang.get(72223),
		30025,
		27,
		300,
		{
			RTResTalkAction[3],
			RTResTalkAction[5]
		}
	},
	[30025028] = {
		30025028,
		0,
		Lang.get(72224),
		30025,
		28,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30025029] = {
		30025029,
		0,
		Lang.get(72225),
		30025,
		29,
		290,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30025030] = {
		30025030,
		0,
		Lang.get(72226),
		30025,
		30,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30025031] = {
		30025031,
		0,
		Lang.get(20265),
		30025,
		31,
		290,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30025032] = {
		30025032,
		0,
		Lang.get(72227),
		30025,
		32,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30025033] = {
		30025033,
		0,
		Lang.get(72228),
		30025,
		33,
		777,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30025034] = {
		30025034,
		0,
		Lang.get(72229),
		30025,
		34,
		290,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[30025035] = {
		30025035,
		0,
		Lang.get(72230),
		30025,
		35,
		133,
		{
			RTResTalkAction[3],
			RTResTalkAction[5]
		},
		1,
		2
	},
	[30025036] = {
		30025036,
		0,
		Lang.get(72231),
		30025,
		36,
		134,
		nil,
		1,
		1
	},
	[30025037] = {
		30025037,
		0,
		Lang.get(72232),
		30025,
		37,
		133,
		nil,
		1,
		0
	},
	[30025038] = {
		30025038,
		0,
		Lang.get(72233),
		30025,
		38,
		290,
		{
			RTResTalkAction[7]
		}
	},
	[30025039] = {
		30025039,
		0,
		Lang.get(72234),
		30025,
		39,
		290,
		{
			RTResTalkAction[105]
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
