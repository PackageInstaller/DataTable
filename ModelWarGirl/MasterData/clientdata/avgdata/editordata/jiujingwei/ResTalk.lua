-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\jiujingwei\\ResTalk.lua

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
	134,
	nil,
	nil,
	1
}
RTResTalkAction[2] = {
	1,
	107,
	nil,
	nil,
	11
}
RTResTalkAction[3] = {
	[1] = 0,
	[2] = 134
}
RTResTalkAction[4] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[5] = {
	1,
	107,
	nil,
	nil,
	3
}
RTResTalkAction[6] = {
	2,
	141,
	nil,
	nil,
	2
}
RTResTalkAction[7] = {
	[1] = 3,
	[2] = 107
}
RTResTalkAction[8] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[9] = {
	1,
	108,
	nil,
	nil,
	2
}
RTResTalkAction[10] = {
	[1] = 2,
	[2] = 108
}
RTResTalkAction[11] = {
	3,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[12] = {
	[1] = 2,
	[2] = 141
}
RTResTalkAction[13] = {
	[1] = 3,
	[2] = 108
}
RTResTalkAction[14] = {
	[1] = 1,
	[2] = 121
}
RTResTalkAction[15] = {
	[1] = 0,
	[2] = 108
}
RTResTalkAction[16] = {
	[1] = 1,
	[2] = 396
}
RTResTalkAction[17] = {
	[1] = 0,
	[2] = 121
}
RTResTalkAction[18] = {
	1,
	134,
	nil,
	nil,
	2
}
RTResTalkAction[19] = {
	[1] = 0,
	[2] = 396
}
RTResTalkAction[20] = {
	[1] = 2,
	[2] = 134
}
RTResTalkAction[21] = {
	2,
	134,
	nil,
	nil,
	2
}
RTResTalkAction[22] = {
	[1] = 2,
	[2] = 121
}
RTResTalkAction[23] = {
	[1] = 2,
	[2] = 101
}
RTResTalkAction[24] = {
	1,
	107,
	nil,
	nil,
	10
}
RTResTalkAction[25] = {
	[1] = 0,
	[2] = 101
}
RTResTalkAction[26] = {
	[1] = 1,
	[2] = 134
}
RTResTalkAction[27] = {
	2,
	108,
	nil,
	nil,
	3
}
RTResTalkAction[28] = {
	[1] = 3,
	[2] = 121
}
RTResTalkAction[29] = {
	[1] = 1,
	[2] = 101
}
RTResTalkAction[30] = {
	2,
	108,
	nil,
	nil,
	4
}
RTResTalkAction[31] = {
	[1] = 1,
	[2] = 42
}
RTResTalkAction[32] = {
	[1] = 1,
	[2] = 43
}
RTResTalkAction[33] = {
	[1] = 0,
	[2] = 42
}
RTResTalkAction[34] = {
	[1] = 0,
	[2] = 43
}
RTResTalkAction[35] = {
	[1] = 2,
	[2] = 273
}
RTResTalkAction[36] = {
	[1] = 3,
	[2] = 134
}
RTResTalkAction[37] = {
	[1] = 1,
	[2] = 112
}
RTResTalkAction[38] = {
	[1] = 0,
	[2] = 273
}
RTResTalkAction[39] = {
	1,
	107,
	nil,
	nil,
	2
}
RTResTalkAction[40] = {
	[1] = 0,
	[2] = 112
}
RTResTalkAction[41] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[42] = {
	3,
	134,
	nil,
	nil,
	4
}
RTResTalkAction[43] = {
	[1] = 1,
	[2] = 141
}
RTResTalkAction[44] = {
	1,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[45] = {
	[1] = 1,
	[2] = 275
}
RTResTalkAction[46] = {
	[1] = 2,
	[2] = 275
}
RTResTalkAction[47] = {
	[1] = 3,
	[2] = 101
}
RTResTalkAction[48] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[49] = {
	[1] = 0,
	[2] = 275
}
RTResTalkAction[50] = {
	[1] = 1,
	[2] = 273
}
RTResTalkAction[51] = {
	[1] = 2,
	[2] = 226
}
RTResTalkAction[52] = {
	[1] = 3,
	[2] = 141
}
RTResTalkAction[53] = {
	[1] = 0,
	[2] = 226
}
RTResTalkAction[54] = {
	[1] = 1,
	[2] = 226
}
RTResTalkAction[55] = {
	1,
	107,
	nil,
	nil,
	5
}
RTResTalkAction[56] = {
	3,
	107,
	nil,
	nil,
	2
}
RTResTalkAction[57] = {
	[1] = 2,
	[2] = 279
}
RTResTalkAction[58] = {
	[1] = 3,
	[2] = 273
}
RTResTalkAction[59] = {
	[1] = 3,
	[2] = 276
}
RTResTalkAction[60] = {
	[1] = 0,
	[2] = 279
}
RTResTalkAction[61] = {
	1,
	101,
	nil,
	nil,
	2
}
RTResTalkAction[62] = {
	[1] = 0,
	[2] = 276
}
RTResTalkAction[63] = {
	1,
	101,
	nil,
	nil,
	3
}
RTResTalkAction[64] = {
	1,
	101,
	nil,
	nil,
	1
}
RTResTalkAction[65] = {
	[1] = 2,
	[2] = 276
}
RTResTalkAction[66] = {
	[1] = 1,
	[2] = 279
}
RTResTalkAction[67] = {
	[1] = 3,
	[2] = 275
}
RTResTalkAction[68] = {
	[1] = 1,
	[2] = 276
}
RTResTalkAction[69] = {
	[1] = 4,
	[2] = 276
}
RTResTalkAction[70] = {
	[1] = 5,
	[2] = 279
}
RTResTalkAction[71] = {
	[1] = 5,
	[2] = 141
}
RTResTalkAction[72] = {
	[1] = 5,
	[2] = 107
}
RTResTalkAction[73] = {
	[1] = 5,
	[2] = 273
}
RTResTalkAction[74] = {
	[1] = 1,
	[2] = 395
}
RTResTalkAction[75] = {
	[1] = 0,
	[2] = 395
}
RTResTalkAction[76] = {
	[1] = 4,
	[2] = 273
}
RTResTalkAction[77] = {
	[1] = 5,
	[2] = 108
}
RTResTalkAction[78] = {
	2,
	107,
	nil,
	nil,
	3
}
RTResTalkAction[79] = {
	[1] = 4,
	[2] = 226
}
RTResTalkAction[80] = {
	[1] = 5,
	[2] = 275
}
RTResTalkAction[81] = {
	[1] = 3,
	[2] = 226
}
RTResTalkAction[82] = {
	[1] = 5,
	[2] = 226
}
RTResTalkAction[83] = {
	[1] = 1,
	[2] = 274
}
RTResTalkAction[84] = {
	[1] = 0,
	[2] = 274
}
RTResTalkAction[85] = {
	[1] = 1,
	[2] = 280
}
RTResTalkAction[86] = {
	[1] = 0,
	[2] = 280
}
RTResTalkAction[87] = {
	[1] = 1,
	[2] = 281
}
RTResTalkAction[88] = {
	[1] = 0,
	[2] = 281
}
RTResTalkAction[89] = {
	[1] = 3,
	[2] = 122
}
RTResTalkAction[90] = {
	[1] = 0,
	[2] = 122
}
RTResTalkAction[91] = {
	[1] = 4,
	[2] = 101
}
RTResTalkAction[92] = {
	[1] = 5,
	[2] = 122
}
RTResTalkAction[93] = {
	[1] = 1,
	[2] = 122
}
RTResTalkAction[94] = {
	[1] = 2,
	[2] = 42
}
RTResTalkAction[95] = {
	[1] = 3,
	[2] = 632
}
RTResTalkAction[96] = {
	[1] = 0,
	[2] = 632
}
RTResTalkAction[97] = {
	[1] = 1,
	[2] = 278
}
RTResTalkAction[98] = {
	[1] = 0,
	[2] = 278
}
RTResTalkAction[99] = {
	[1] = 1,
	[2] = 198
}
RTResTalkAction[100] = {
	[1] = 1,
	[2] = 140
}
RTResTalkAction[101] = {
	[1] = 0,
	[2] = 198
}
RTResTalkAction[102] = {
	[1] = 0,
	[2] = 140
}
RTResTalkAction[103] = {
	[1] = 1,
	[2] = 277
}
RTResTalkAction[104] = {
	[1] = 0,
	[2] = 277
}
RTResTalkAction[105] = {
	[1] = 1,
	[2] = 394
}
RTResTalkAction[106] = {
	[1] = 0,
	[2] = 394
}
RTResTalkAction[107] = {
	[1] = 1,
	[2] = 128
}
RTResTalkAction[108] = {
	[1] = 1,
	[2] = 119
}
RTResTalkAction[109] = {
	[1] = 0,
	[2] = 128
}
RTResTalkAction[110] = {
	[1] = 0,
	[2] = 119
}
RTResTalkAction[111] = {
	[1] = 1,
	[2] = 150
}
RTResTalkAction[112] = {
	[1] = 0,
	[2] = 150
}

local Data = {
	[24000001] = {
		24000001,
		0,
		Lang.get(60118),
		24000,
		1,
		141,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		24010,
		nil,
		1,
		nil,
		nil,
		nil,
		24010
	},
	[24000002] = {
		24000002,
		0,
		Lang.get(60119),
		24000,
		2,
		141,
		nil,
		1
	},
	[24000003] = {
		24000003,
		0,
		Lang.get(60120),
		24000,
		3,
		134,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[24000004] = {
		24000004,
		0,
		Lang.get(60121),
		24000,
		4,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[24000005] = {
		24000005,
		0,
		Lang.get(60122),
		24000,
		5,
		141,
		{
			RTResTalkAction[4]
		},
		1,
		0,
		-1
	},
	[24000006] = {
		24000006,
		0,
		Lang.get(60123),
		24000,
		6,
		134,
		nil,
		1,
		2
	},
	[24000007] = {
		24000007,
		0,
		Lang.get(60124),
		24000,
		7,
		300
	},
	[24000008] = {
		24000008,
		0,
		Lang.get(60125),
		24000,
		8,
		141,
		nil,
		1,
		3
	},
	[24000009] = {
		24000009,
		3,
		Lang.get(60126),
		24000,
		9,
		[22] = 1
	},
	[24000010] = {
		24000010,
		0,
		Lang.get(60127),
		24000,
		10,
		107,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		3
	},
	[24000011] = {
		24000011,
		0,
		Lang.get(60128),
		24000,
		11,
		141,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[24000012] = {
		24000012,
		4,
		nil,
		24000,
		12,
		141,
		{
			RTResTalkAction[8],
			RTResTalkAction[4]
		},
		[29] = {
			{
				id = 24000013,
				branch_content = Lang.get(60129)
			}
		}
	},
	[24000013] = {
		24000013,
		0,
		Lang.get(60130),
		24000,
		13,
		101,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		24011,
		nil,
		nil,
		nil,
		nil,
		nil,
		24011
	},
	[24000014] = {
		24000014,
		0,
		Lang.get(60131),
		24000,
		14,
		108,
		nil,
		1,
		2
	},
	[24000015] = {
		24000015,
		0,
		Lang.get(60132),
		24000,
		15,
		121,
		nil,
		1,
		0
	},
	[24000016] = {
		24000016,
		0,
		Lang.get(62784),
		24000,
		16,
		101,
		nil,
		1,
		0
	},
	[24000017] = {
		24000017,
		4,
		nil,
		24000,
		17,
		101,
		nil,
		2,
		0,
		[29] = {
			{
				id = 24000018,
				branch_content = Lang.get(44488)
			}
		}
	},
	[24000018] = {
		24000018,
		0,
		Lang.get(60135),
		24000,
		18,
		108,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[24000019] = {
		24000019,
		0,
		Lang.get(60136),
		24000,
		19,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[24000020] = {
		24000020,
		0,
		Lang.get(60137),
		24000,
		20,
		141,
		{
			RTResTalkAction[12],
			RTResTalkAction[13],
			RTResTalkAction[4]
		}
	},
	[24000021] = {
		24000021,
		0,
		Lang.get(60138),
		24000,
		21,
		108,
		{
			RTResTalkAction[12],
			RTResTalkAction[13]
		}
	},
	[24000022] = {
		24000022,
		0,
		Lang.get(60139),
		24000,
		22,
		121,
		{
			RTResTalkAction[14],
			RTResTalkAction[8],
			RTResTalkAction[15]
		}
	},
	[24000023] = {
		24000023,
		0,
		Lang.get(60140),
		24000,
		23,
		108,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		},
		1,
		2,
		[21] = 396
	},
	[24000024] = {
		24000024,
		0,
		Lang.get(62785),
		24000,
		24,
		101,
		{
			RTResTalkAction[16]
		},
		1,
		0,
		[21] = 396
	},
	[24000025] = {
		24000025,
		0,
		Lang.get(60142),
		24000,
		25,
		300,
		{
			RTResTalkAction[16]
		},
		[21] = 396
	},
	[24000026] = {
		24000026,
		0,
		Lang.get(60143),
		24000,
		26,
		134,
		{
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[24000027] = {
		24000027,
		0,
		Lang.get(60144),
		24000,
		27,
		107,
		{
			RTResTalkAction[20],
			RTResTalkAction[7]
		}
	},
	[24000028] = {
		24000028,
		0,
		Lang.get(60145),
		24000,
		28,
		134,
		{
			RTResTalkAction[21],
			RTResTalkAction[7]
		}
	},
	[24001001] = {
		24001001,
		0,
		Lang.get(60146),
		24001,
		1,
		107,
		nil,
		1,
		2,
		nil,
		nil,
		63,
		24011,
		nil,
		1,
		nil,
		nil,
		nil,
		24011
	},
	[24001002] = {
		24001002,
		0,
		Lang.get(60147),
		24001,
		2,
		300
	},
	[24001003] = {
		24001003,
		0,
		Lang.get(60148),
		24001,
		3,
		108,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[24001004] = {
		24001004,
		0,
		Lang.get(60149),
		24001,
		4,
		121,
		{
			RTResTalkAction[22],
			RTResTalkAction[13]
		}
	},
	[24001005] = {
		24001005,
		0,
		Lang.get(60150),
		24001,
		5,
		108,
		{
			RTResTalkAction[22],
			RTResTalkAction[13]
		}
	},
	[24001006] = {
		24001006,
		0,
		Lang.get(60151),
		24001,
		6,
		101,
		{
			RTResTalkAction[23],
			RTResTalkAction[13],
			RTResTalkAction[17]
		}
	},
	[24001007] = {
		24001007,
		0,
		Lang.get(60152),
		24001,
		7,
		107,
		{
			RTResTalkAction[24],
			RTResTalkAction[25],
			RTResTalkAction[15]
		}
	},
	[24001008] = {
		24001008,
		0,
		Lang.get(60153),
		24001,
		8,
		141,
		{
			RTResTalkAction[12],
			RTResTalkAction[7]
		}
	},
	[24001009] = {
		24001009,
		0,
		Lang.get(60154),
		24001,
		9,
		107,
		{
			RTResTalkAction[12],
			RTResTalkAction[7]
		}
	},
	[24001010] = {
		24001010,
		0,
		Lang.get(60155),
		24001,
		10,
		300,
		{
			RTResTalkAction[12],
			RTResTalkAction[7]
		}
	},
	[24001011] = {
		24001011,
		0,
		Lang.get(60156),
		24001,
		11,
		141,
		{
			RTResTalkAction[12],
			RTResTalkAction[7]
		}
	},
	[24001012] = {
		24001012,
		0,
		Lang.get(60157),
		24001,
		12,
		134,
		{
			RTResTalkAction[26],
			RTResTalkAction[8],
			RTResTalkAction[4]
		}
	},
	[24002001] = {
		24002001,
		0,
		Lang.get(60158),
		24002,
		1,
		108,
		nil,
		1,
		2,
		nil,
		nil,
		63,
		24014,
		nil,
		1,
		nil,
		nil,
		nil,
		24014
	},
	[24002002] = {
		24002002,
		0,
		Lang.get(60159),
		24002,
		2,
		121,
		nil,
		1,
		0
	},
	[24002003] = {
		24002003,
		0,
		Lang.get(60160),
		24002,
		3,
		275,
		nil,
		1,
		0
	},
	[24002004] = {
		24002004,
		0,
		Lang.get(60161),
		24002,
		4,
		101,
		nil,
		1,
		0
	},
	[24002005] = {
		24002005,
		0,
		Lang.get(60162),
		24002,
		5,
		108,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[24002006] = {
		24002006,
		0,
		Lang.get(60163),
		24002,
		6,
		121,
		{
			RTResTalkAction[14],
			RTResTalkAction[15]
		}
	},
	[24002007] = {
		24002007,
		0,
		Lang.get(60164),
		24002,
		7,
		273,
		{
			RTResTalkAction[17]
		},
		1,
		nil,
		-1,
		nil,
		nil,
		24015,
		nil,
		nil,
		nil,
		nil,
		nil,
		24015
	},
	[24002008] = {
		24002008,
		0,
		Lang.get(60165),
		24002,
		8,
		108,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		},
		nil,
		nil,
		3
	},
	[24002009] = {
		24002009,
		0,
		Lang.get(60166),
		24002,
		9,
		121,
		{
			RTResTalkAction[10],
			RTResTalkAction[28]
		}
	},
	[24002010] = {
		24002010,
		3,
		Lang.get(60167),
		24002,
		10,
		605,
		{
			RTResTalkAction[15],
			RTResTalkAction[17]
		},
		nil,
		nil,
		-1,
		[22] = 1
	},
	[24002011] = {
		24002011,
		0,
		Lang.get(60168),
		24002,
		11,
		101,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[24002012] = {
		24002012,
		0,
		Lang.get(60169),
		24002,
		12,
		108,
		{
			RTResTalkAction[30],
			RTResTalkAction[28],
			RTResTalkAction[25]
		}
	},
	[24002013] = {
		24002013,
		0,
		Lang.get(60170),
		24002,
		13,
		121,
		{
			RTResTalkAction[14],
			RTResTalkAction[15]
		}
	},
	[24003001] = {
		24003001,
		0,
		Lang.get(60171),
		24003,
		1,
		134,
		nil,
		1,
		2,
		nil,
		nil,
		63,
		24016,
		nil,
		1,
		nil,
		nil,
		nil,
		24014
	},
	[24003002] = {
		24003002,
		0,
		Lang.get(60172),
		24003,
		2,
		141,
		nil,
		1,
		0
	},
	[24003003] = {
		24003003,
		0,
		Lang.get(60173),
		24003,
		3,
		273,
		nil,
		1,
		0
	},
	[24003004] = {
		24003004,
		7,
		"74",
		24003,
		4,
		273
	},
	[24003005] = {
		24003005,
		0,
		Lang.get(60174),
		24003,
		5,
		107,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		3
	},
	[24004001] = {
		24004001,
		0,
		Lang.get(60175),
		24004,
		1,
		42,
		{
			RTResTalkAction[31]
		},
		1,
		0,
		nil,
		nil,
		62,
		24017,
		nil,
		nil,
		nil,
		nil,
		nil,
		24015
	},
	[24004002] = {
		24004002,
		0,
		Lang.get(60176),
		24004,
		2,
		43,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		},
		1,
		0
	},
	[24004003] = {
		24004003,
		0,
		Lang.get(60177),
		24004,
		3,
		134,
		{
			RTResTalkAction[26],
			RTResTalkAction[34]
		},
		nil,
		nil,
		3
	},
	[24004004] = {
		24004004,
		0,
		Lang.get(60178),
		24004,
		4,
		273,
		{
			RTResTalkAction[35],
			RTResTalkAction[36]
		}
	},
	[24004005] = {
		24004005,
		0,
		Lang.get(60179),
		24004,
		5,
		134,
		{
			RTResTalkAction[35],
			RTResTalkAction[36]
		}
	},
	[24004006] = {
		24004006,
		0,
		Lang.get(63150),
		24004,
		6,
		112,
		{
			RTResTalkAction[37],
			RTResTalkAction[38],
			RTResTalkAction[3]
		}
	},
	[24004007] = {
		24004007,
		0,
		Lang.get(60181),
		24004,
		7,
		107,
		{
			RTResTalkAction[39],
			RTResTalkAction[40]
		}
	},
	[24004008] = {
		24004008,
		0,
		Lang.get(60182),
		24004,
		8,
		134,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[24004009] = {
		24004009,
		0,
		Lang.get(60183),
		24004,
		9,
		141,
		{
			RTResTalkAction[43],
			RTResTalkAction[4],
			RTResTalkAction[3]
		}
	},
	[24004010] = {
		24004010,
		3,
		Lang.get(60184),
		24004,
		10,
		141,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		-1,
		[22] = 1
	},
	[24004011] = {
		24004011,
		0,
		Lang.get(60185),
		24004,
		11,
		107,
		{
			RTResTalkAction[44]
		},
		nil,
		nil,
		3
	},
	[24004012] = {
		24004012,
		0,
		Lang.get(62786),
		24004,
		12,
		108,
		{
			RTResTalkAction[4]
		},
		1,
		3,
		nil,
		nil,
		nil,
		24018,
		nil,
		nil,
		nil,
		nil,
		nil,
		24018
	},
	[24004013] = {
		24004013,
		0,
		Lang.get(60187),
		24004,
		13,
		121,
		nil,
		1,
		0
	},
	[24004014] = {
		24004014,
		0,
		Lang.get(60188),
		24004,
		14,
		275,
		{
			RTResTalkAction[45]
		},
		nil,
		nil,
		3
	},
	[24004015] = {
		24004015,
		0,
		Lang.get(60189),
		24004,
		15,
		101,
		{
			RTResTalkAction[46],
			RTResTalkAction[47]
		}
	},
	[24004016] = {
		24004016,
		0,
		Lang.get(60190),
		24004,
		16,
		275,
		{
			RTResTalkAction[46],
			RTResTalkAction[47]
		}
	},
	[24004017] = {
		24004017,
		0,
		Lang.get(60191),
		24004,
		17,
		107,
		{
			RTResTalkAction[48],
			RTResTalkAction[49],
			RTResTalkAction[25]
		}
	},
	[24004018] = {
		24004018,
		0,
		Lang.get(60192),
		24004,
		18,
		273,
		{
			RTResTalkAction[50],
			RTResTalkAction[4]
		}
	},
	[24004019] = {
		24004019,
		0,
		Lang.get(60193),
		24004,
		19,
		275,
		{
			RTResTalkAction[45],
			RTResTalkAction[38]
		}
	},
	[24004020] = {
		24004020,
		0,
		Lang.get(60194),
		24004,
		20,
		101,
		{
			RTResTalkAction[29],
			RTResTalkAction[49]
		}
	},
	[24005001] = {
		24005001,
		0,
		Lang.get(60195),
		24005,
		1,
		101,
		nil,
		1,
		0,
		nil,
		nil,
		62,
		24018,
		nil,
		1,
		nil,
		nil,
		nil,
		24018
	},
	[24005002] = {
		24005002,
		0,
		Lang.get(62787),
		24005,
		2,
		273,
		nil,
		1,
		0
	},
	[24005003] = {
		24005003,
		0,
		Lang.get(60197),
		24005,
		3,
		101,
		nil,
		1,
		0
	},
	[24005004] = {
		24005004,
		0,
		Lang.get(60198),
		24005,
		4,
		134,
		{
			RTResTalkAction[23],
			RTResTalkAction[36]
		},
		nil,
		nil,
		3
	},
	[24005005] = {
		24005005,
		0,
		Lang.get(60199),
		24005,
		5,
		107,
		{
			RTResTalkAction[44],
			RTResTalkAction[25],
			RTResTalkAction[3]
		}
	},
	[24005006] = {
		24005006,
		0,
		Lang.get(60200),
		24005,
		6,
		101,
		{
			RTResTalkAction[35],
			RTResTalkAction[47],
			RTResTalkAction[4]
		}
	},
	[24005007] = {
		24005007,
		0,
		Lang.get(62788),
		24005,
		7,
		273,
		{
			RTResTalkAction[35],
			RTResTalkAction[47]
		}
	},
	[24005008] = {
		24005008,
		0,
		Lang.get(60202),
		24005,
		8,
		101,
		{
			RTResTalkAction[35],
			RTResTalkAction[47]
		}
	},
	[24005009] = {
		24005009,
		0,
		Lang.get(60203),
		24005,
		9,
		273,
		{
			RTResTalkAction[35],
			RTResTalkAction[47]
		}
	},
	[24005010] = {
		24005010,
		0,
		Lang.get(60204),
		24005,
		10,
		226,
		{
			RTResTalkAction[38],
			RTResTalkAction[25]
		},
		1,
		0,
		nil,
		nil,
		nil,
		24019,
		nil,
		nil,
		nil,
		nil,
		nil,
		24019
	},
	[24005011] = {
		24005011,
		0,
		Lang.get(60205),
		24005,
		11,
		112,
		nil,
		1,
		0
	},
	[24005012] = {
		24005012,
		0,
		Lang.get(60206),
		24005,
		12,
		226,
		nil,
		1,
		0
	},
	[24005013] = {
		24005013,
		0,
		Lang.get(60207),
		24005,
		13,
		141,
		{
			RTResTalkAction[43]
		},
		nil,
		nil,
		3
	},
	[24005014] = {
		24005014,
		0,
		Lang.get(62789),
		24005,
		14,
		226,
		{
			RTResTalkAction[51],
			RTResTalkAction[52]
		}
	},
	[24005015] = {
		24005015,
		0,
		Lang.get(60209),
		24005,
		15,
		107,
		{
			RTResTalkAction[48],
			RTResTalkAction[53],
			RTResTalkAction[8]
		}
	},
	[24005016] = {
		24005016,
		0,
		Lang.get(60210),
		24005,
		16,
		141,
		{
			RTResTalkAction[43],
			RTResTalkAction[4]
		}
	},
	[24005017] = {
		24005017,
		0,
		Lang.get(60211),
		24005,
		17,
		134,
		{
			RTResTalkAction[26],
			RTResTalkAction[8]
		}
	},
	[24005018] = {
		24005018,
		0,
		Lang.get(60212),
		24005,
		18,
		226,
		{
			RTResTalkAction[54],
			RTResTalkAction[3]
		}
	},
	[24005019] = {
		24005019,
		0,
		Lang.get(62790),
		24005,
		19,
		107,
		{
			RTResTalkAction[53]
		},
		1,
		0,
		-1,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		2
	},
	[24005020] = {
		24005020,
		13,
		Lang.get(60214),
		24005,
		20,
		300,
		[27] = 3
	},
	[24005021] = {
		24005021,
		0,
		Lang.get(60215),
		24005,
		21,
		107,
		nil,
		1,
		0
	},
	[24005022] = {
		24005022,
		0,
		Lang.get(60216),
		24005,
		22,
		226,
		nil,
		1,
		0
	},
	[24005023] = {
		24005023,
		13,
		Lang.get(62791),
		24005,
		23,
		300,
		[27] = 3
	},
	[24005024] = {
		24005024,
		0,
		Lang.get(60218),
		24005,
		24,
		226,
		{
			RTResTalkAction[54]
		},
		nil,
		nil,
		3
	},
	[24005025] = {
		24005025,
		0,
		Lang.get(60219),
		24005,
		25,
		107,
		{
			RTResTalkAction[55],
			RTResTalkAction[53]
		}
	},
	[24005026] = {
		24005026,
		0,
		Lang.get(62792),
		24005,
		26,
		141,
		{
			RTResTalkAction[12],
			RTResTalkAction[7]
		}
	},
	[24005027] = {
		24005027,
		0,
		Lang.get(60221),
		24005,
		27,
		226,
		{
			RTResTalkAction[54],
			RTResTalkAction[8],
			RTResTalkAction[4]
		}
	},
	[24005028] = {
		24005028,
		0,
		Lang.get(60222),
		24005,
		28,
		134,
		{
			RTResTalkAction[18],
			RTResTalkAction[53]
		}
	},
	[24005029] = {
		24005029,
		0,
		Lang.get(62793),
		24005,
		29,
		107,
		{
			RTResTalkAction[20],
			RTResTalkAction[56]
		}
	},
	[24005030] = {
		24005030,
		0,
		Lang.get(60224),
		24005,
		30,
		134,
		{
			RTResTalkAction[20],
			RTResTalkAction[7]
		}
	},
	[24005031] = {
		24005031,
		0,
		Lang.get(62794),
		24005,
		31,
		134,
		{
			RTResTalkAction[20],
			RTResTalkAction[7]
		}
	},
	[24005032] = {
		24005032,
		0,
		Lang.get(60226),
		24005,
		32,
		107,
		{
			RTResTalkAction[20],
			RTResTalkAction[11]
		}
	},
	[24006001] = {
		24006001,
		0,
		Lang.get(60227),
		24006,
		1,
		279,
		nil,
		1,
		0,
		nil,
		nil,
		62,
		24026,
		nil,
		1,
		nil,
		nil,
		nil,
		24026
	},
	[24006002] = {
		24006002,
		0,
		Lang.get(60228),
		24006,
		2,
		276,
		nil,
		1,
		0
	},
	[24006003] = {
		24006003,
		0,
		Lang.get(60229),
		24006,
		3,
		273,
		{
			RTResTalkAction[50]
		},
		nil,
		nil,
		3
	},
	[24006004] = {
		24006004,
		0,
		Lang.get(60230),
		24006,
		4,
		279,
		{
			RTResTalkAction[57],
			RTResTalkAction[58]
		}
	},
	[24006005] = {
		24006005,
		0,
		Lang.get(60231),
		24006,
		5,
		273,
		{
			RTResTalkAction[57],
			RTResTalkAction[58]
		}
	},
	[24006006] = {
		24006006,
		0,
		Lang.get(60232),
		24006,
		6,
		276,
		{
			RTResTalkAction[35],
			RTResTalkAction[59],
			RTResTalkAction[60]
		}
	},
	[24006007] = {
		24006007,
		0,
		Lang.get(60233),
		24006,
		7,
		101,
		{
			RTResTalkAction[61],
			RTResTalkAction[38],
			RTResTalkAction[62]
		}
	},
	[24006008] = {
		24006008,
		0,
		Lang.get(60234),
		24006,
		8,
		101,
		{
			RTResTalkAction[25]
		},
		1,
		1,
		nil,
		nil,
		nil,
		24021,
		nil,
		nil,
		nil,
		nil,
		nil,
		24021
	},
	[24006009] = {
		24006009,
		0,
		Lang.get(60235),
		24006,
		9,
		275,
		nil,
		1,
		0
	},
	[24006010] = {
		24006010,
		0,
		Lang.get(60236),
		24006,
		10,
		101,
		nil,
		1,
		1
	},
	[24006011] = {
		24006011,
		0,
		Lang.get(60237),
		24006,
		11,
		101,
		nil,
		1,
		1
	},
	[24006012] = {
		24006012,
		0,
		Lang.get(60238),
		24006,
		12,
		273,
		{
			RTResTalkAction[50]
		},
		nil,
		0,
		3
	},
	[24006013] = {
		24006013,
		0,
		Lang.get(60239),
		24006,
		13,
		101,
		{
			RTResTalkAction[63],
			RTResTalkAction[38]
		}
	},
	[24006014] = {
		24006014,
		0,
		Lang.get(60240),
		24006,
		14,
		273,
		{
			RTResTalkAction[50],
			RTResTalkAction[25]
		}
	},
	[24006015] = {
		24006015,
		0,
		Lang.get(60241),
		24006,
		15,
		273,
		{
			RTResTalkAction[50]
		}
	},
	[24006016] = {
		24006016,
		0,
		Lang.get(60242),
		24006,
		16,
		101,
		{
			RTResTalkAction[64],
			RTResTalkAction[38]
		}
	},
	[24006017] = {
		24006017,
		0,
		Lang.get(60243),
		24006,
		17,
		273,
		{
			RTResTalkAction[50],
			RTResTalkAction[25]
		}
	},
	[24006018] = {
		24006018,
		0,
		Lang.get(60244),
		24006,
		18,
		101,
		{
			RTResTalkAction[35],
			RTResTalkAction[47]
		}
	},
	[24006019] = {
		24006019,
		0,
		Lang.get(60245),
		24006,
		19,
		273,
		{
			RTResTalkAction[35],
			RTResTalkAction[47]
		}
	},
	[24006020] = {
		24006020,
		0,
		Lang.get(60246),
		24006,
		20,
		101,
		{
			RTResTalkAction[38],
			RTResTalkAction[25]
		},
		1,
		1,
		nil,
		nil,
		nil,
		24022,
		nil,
		nil,
		nil,
		nil,
		nil,
		24022
	},
	[24006021] = {
		24006021,
		0,
		Lang.get(60247),
		24006,
		21,
		134,
		nil,
		1,
		0
	},
	[24006022] = {
		24006022,
		0,
		Lang.get(60248),
		24006,
		22,
		101,
		nil,
		1,
		1
	},
	[24006023] = {
		24006023,
		0,
		Lang.get(60249),
		24006,
		23,
		134,
		nil,
		1,
		1
	},
	[24007001] = {
		24007001,
		0,
		Lang.get(60250),
		24007,
		1,
		273,
		nil,
		1,
		0,
		nil,
		nil,
		60,
		24023,
		nil,
		1,
		nil,
		nil,
		nil,
		24023
	},
	[24007002] = {
		24007002,
		0,
		Lang.get(60251),
		24007,
		2,
		276,
		nil,
		1,
		0
	},
	[24007003] = {
		24007003,
		0,
		Lang.get(60252),
		24007,
		3,
		273,
		{
			RTResTalkAction[65],
			RTResTalkAction[58]
		},
		nil,
		nil,
		3
	},
	[24007004] = {
		24007004,
		0,
		Lang.get(60253),
		24007,
		4,
		276,
		{
			RTResTalkAction[65],
			RTResTalkAction[58]
		}
	},
	[24007005] = {
		24007005,
		0,
		Lang.get(60254),
		24007,
		5,
		273,
		{
			RTResTalkAction[57],
			RTResTalkAction[58],
			RTResTalkAction[62]
		}
	},
	[24007006] = {
		24007006,
		0,
		Lang.get(60255),
		24007,
		6,
		279,
		{
			RTResTalkAction[57],
			RTResTalkAction[58]
		}
	},
	[24007007] = {
		24007007,
		0,
		Lang.get(60256),
		24007,
		7,
		273,
		{
			RTResTalkAction[57],
			RTResTalkAction[58]
		}
	},
	[24007008] = {
		24007008,
		0,
		Lang.get(60257),
		24007,
		8,
		279,
		{
			RTResTalkAction[57],
			RTResTalkAction[58]
		}
	},
	[24007009] = {
		24007009,
		0,
		Lang.get(60258),
		24007,
		9,
		273,
		{
			RTResTalkAction[46],
			RTResTalkAction[58],
			RTResTalkAction[60]
		}
	},
	[24007010] = {
		24007010,
		0,
		Lang.get(60259),
		24007,
		10,
		275,
		{
			RTResTalkAction[46],
			RTResTalkAction[58]
		}
	},
	[24007011] = {
		24007011,
		0,
		Lang.get(60260),
		24007,
		11,
		273,
		{
			RTResTalkAction[20],
			RTResTalkAction[58],
			RTResTalkAction[49]
		}
	},
	[24007012] = {
		24007012,
		0,
		Lang.get(60261),
		24007,
		12,
		134,
		{
			RTResTalkAction[20],
			RTResTalkAction[58]
		}
	},
	[24007013] = {
		24007013,
		0,
		Lang.get(60262),
		24007,
		13,
		107,
		{
			RTResTalkAction[48],
			RTResTalkAction[3],
			RTResTalkAction[38]
		}
	},
	[24007014] = {
		24007014,
		0,
		Lang.get(60263),
		24007,
		14,
		273,
		{
			RTResTalkAction[50],
			RTResTalkAction[4]
		}
	},
	[24007015] = {
		24007015,
		0,
		Lang.get(60264),
		24007,
		15,
		273,
		{
			RTResTalkAction[50]
		}
	},
	[24007016] = {
		24007016,
		0,
		Lang.get(60265),
		24007,
		16,
		101,
		{
			RTResTalkAction[29],
			RTResTalkAction[38]
		}
	},
	[24007017] = {
		24007017,
		0,
		Lang.get(60266),
		24007,
		17,
		273,
		{
			RTResTalkAction[25]
		},
		1,
		0,
		nil,
		nil,
		nil,
		24024,
		nil,
		nil,
		nil,
		nil,
		nil,
		24024
	},
	[24007018] = {
		24007018,
		0,
		Lang.get(60267),
		24007,
		18,
		101,
		nil,
		1,
		0,
		-1
	},
	[24007019] = {
		24007019,
		0,
		Lang.get(60268),
		24007,
		19,
		273,
		nil,
		1
	},
	[24007020] = {
		24007020,
		0,
		Lang.get(60269),
		24007,
		20,
		101,
		nil,
		1
	},
	[24007021] = {
		24007021,
		0,
		Lang.get(60270),
		24007,
		21,
		273,
		nil,
		1
	},
	[24007022] = {
		24007022,
		0,
		Lang.get(60271),
		24007,
		22,
		101,
		nil,
		1
	},
	[24007023] = {
		24007023,
		0,
		Lang.get(60272),
		24007,
		23,
		273,
		nil,
		1
	},
	[24008001] = {
		24008001,
		0,
		Lang.get(60273),
		24008,
		1,
		101,
		nil,
		1,
		2,
		nil,
		nil,
		62,
		24025,
		nil,
		1,
		nil,
		nil,
		nil,
		24025
	},
	[24008002] = {
		24008002,
		0,
		Lang.get(60274),
		24008,
		2,
		101,
		nil,
		1,
		1
	},
	[24008003] = {
		24008003,
		3,
		Lang.get(60275),
		24008,
		3,
		605,
		nil,
		nil,
		0,
		-1,
		[22] = 1
	},
	[24008004] = {
		24008004,
		0,
		Lang.get(60276),
		24008,
		4,
		101,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[24008005] = {
		24008005,
		0,
		Lang.get(62795),
		24008,
		5,
		273,
		{
			RTResTalkAction[50],
			RTResTalkAction[25]
		}
	},
	[24008006] = {
		24008006,
		0,
		Lang.get(60278),
		24008,
		6,
		101,
		{
			RTResTalkAction[29],
			RTResTalkAction[38]
		}
	},
	[24008007] = {
		24008007,
		0,
		Lang.get(60279),
		24008,
		7,
		273,
		{
			RTResTalkAction[25]
		},
		1,
		0,
		nil,
		nil,
		nil,
		24026,
		nil,
		nil,
		nil,
		nil,
		nil,
		24026
	},
	[24008008] = {
		24008008,
		0,
		Lang.get(60280),
		24008,
		8,
		107,
		nil,
		1,
		8
	},
	[24008009] = {
		24008009,
		0,
		Lang.get(60281),
		24008,
		9,
		141,
		nil,
		1,
		0
	},
	[24008010] = {
		24008010,
		0,
		Lang.get(60282),
		24008,
		10,
		279,
		{
			RTResTalkAction[66]
		},
		nil,
		nil,
		3
	},
	[24008011] = {
		24008011,
		0,
		Lang.get(60283),
		24008,
		11,
		275,
		{
			RTResTalkAction[57],
			RTResTalkAction[67]
		}
	},
	[24008012] = {
		24008012,
		0,
		Lang.get(60284),
		24008,
		12,
		276,
		{
			RTResTalkAction[68],
			RTResTalkAction[60],
			RTResTalkAction[49]
		}
	},
	[24008013] = {
		24008013,
		0,
		Lang.get(60285),
		24008,
		13,
		101,
		{
			RTResTalkAction[29],
			RTResTalkAction[62]
		}
	},
	[24008014] = {
		24008014,
		0,
		Lang.get(60286),
		24008,
		14,
		107,
		{
			RTResTalkAction[44],
			RTResTalkAction[25]
		}
	},
	[24008015] = {
		24008015,
		0,
		Lang.get(60287),
		24008,
		15,
		134,
		{
			RTResTalkAction[4]
		},
		1,
		2,
		-1
	},
	[24008016] = {
		24008016,
		0,
		Lang.get(60288),
		24008,
		16,
		279,
		{
			RTResTalkAction[66]
		},
		nil,
		nil,
		3
	},
	[24008017] = {
		24008017,
		0,
		Lang.get(60289),
		24008,
		17,
		134,
		{
			RTResTalkAction[60]
		},
		1,
		2,
		-1
	},
	[24008018] = {
		24008018,
		0,
		Lang.get(60290),
		24008,
		18,
		275,
		{
			RTResTalkAction[45]
		},
		nil,
		nil,
		3
	},
	[24008019] = {
		24008019,
		0,
		Lang.get(62796),
		24008,
		19,
		101,
		{
			RTResTalkAction[29],
			RTResTalkAction[49]
		}
	},
	[24008020] = {
		24008020,
		0,
		Lang.get(62797),
		24008,
		20,
		276,
		{
			RTResTalkAction[65],
			RTResTalkAction[47]
		}
	},
	[24008021] = {
		24008021,
		0,
		Lang.get(60293),
		24008,
		21,
		279,
		{
			RTResTalkAction[69],
			RTResTalkAction[29],
			RTResTalkAction[70]
		}
	},
	[24008022] = {
		24008022,
		0,
		Lang.get(60294),
		24008,
		22,
		107,
		{
			RTResTalkAction[44],
			RTResTalkAction[62],
			RTResTalkAction[25],
			RTResTalkAction[60]
		}
	},
	[24008023] = {
		24008023,
		0,
		Lang.get(60295),
		24008,
		23,
		141,
		{
			RTResTalkAction[41],
			RTResTalkAction[52]
		}
	},
	[24008024] = {
		24008024,
		0,
		Lang.get(60296),
		24008,
		24,
		275,
		{
			RTResTalkAction[45],
			RTResTalkAction[4],
			RTResTalkAction[8]
		}
	},
	[24008025] = {
		24008025,
		0,
		Lang.get(60297),
		24008,
		25,
		279,
		{
			RTResTalkAction[66],
			RTResTalkAction[49]
		}
	},
	[24008026] = {
		24008026,
		0,
		Lang.get(60298),
		24008,
		26,
		276,
		{
			RTResTalkAction[68],
			RTResTalkAction[60]
		}
	},
	[24008027] = {
		24008027,
		0,
		Lang.get(60299),
		24008,
		27,
		101,
		{
			RTResTalkAction[65],
			RTResTalkAction[47]
		}
	},
	[24008028] = {
		24008028,
		0,
		Lang.get(60300),
		24008,
		28,
		273,
		{
			RTResTalkAction[23],
			RTResTalkAction[58],
			RTResTalkAction[62]
		}
	},
	[24008029] = {
		24008029,
		0,
		Lang.get(60301),
		24008,
		29,
		101,
		{
			RTResTalkAction[23],
			RTResTalkAction[58]
		}
	},
	[24008030] = {
		24008030,
		0,
		Lang.get(60302),
		24008,
		30,
		273,
		{
			RTResTalkAction[23],
			RTResTalkAction[58]
		}
	},
	[24008031] = {
		24008031,
		0,
		Lang.get(60303),
		24008,
		31,
		101,
		{
			RTResTalkAction[23],
			RTResTalkAction[58]
		}
	},
	[24009001] = {
		24009001,
		0,
		Lang.get(60304),
		24009,
		1,
		101,
		nil,
		1,
		0,
		nil,
		nil,
		62,
		24027,
		nil,
		1,
		nil,
		nil,
		nil,
		24027
	},
	[24009002] = {
		24009002,
		0,
		Lang.get(60305),
		24009,
		2,
		275,
		nil,
		1,
		0
	},
	[24009003] = {
		24009003,
		0,
		Lang.get(60306),
		24009,
		3,
		101,
		nil,
		1,
		0
	},
	[24009004] = {
		24009004,
		0,
		Lang.get(60307),
		24009,
		4,
		275,
		nil,
		1,
		0
	},
	[24009005] = {
		24009005,
		0,
		Lang.get(60308),
		24009,
		5,
		101,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[24009006] = {
		24009006,
		0,
		Lang.get(60309),
		24009,
		6,
		273,
		{
			RTResTalkAction[50],
			RTResTalkAction[25]
		}
	},
	[24009007] = {
		24009007,
		0,
		Lang.get(60310),
		24009,
		7,
		101,
		{
			RTResTalkAction[23],
			RTResTalkAction[58]
		}
	},
	[24009008] = {
		24009008,
		0,
		Lang.get(60311),
		24009,
		8,
		273,
		{
			RTResTalkAction[23],
			RTResTalkAction[58]
		}
	},
	[24009009] = {
		24009009,
		0,
		Lang.get(60312),
		24009,
		9,
		276,
		{
			RTResTalkAction[25],
			RTResTalkAction[38]
		},
		1,
		0,
		nil,
		nil,
		nil,
		24028,
		nil,
		nil,
		nil,
		nil,
		nil,
		24028
	},
	[24009010] = {
		24009010,
		0,
		Lang.get(60313),
		24009,
		10,
		107,
		nil,
		1,
		0
	},
	[24009011] = {
		24009011,
		0,
		Lang.get(60314),
		24009,
		11,
		141,
		nil,
		1,
		0
	},
	[24009012] = {
		24009012,
		0,
		Lang.get(60315),
		24009,
		12,
		276,
		{
			RTResTalkAction[68]
		},
		nil,
		nil,
		3
	},
	[24009013] = {
		24009013,
		0,
		Lang.get(60316),
		24009,
		13,
		107,
		{
			RTResTalkAction[69],
			RTResTalkAction[48],
			RTResTalkAction[71]
		}
	},
	[24009014] = {
		24009014,
		0,
		Lang.get(60317),
		24009,
		14,
		276,
		{
			RTResTalkAction[69],
			RTResTalkAction[48],
			RTResTalkAction[71]
		}
	},
	[24009015] = {
		24009015,
		0,
		Lang.get(60318),
		24009,
		15,
		141,
		{
			RTResTalkAction[69],
			RTResTalkAction[48],
			RTResTalkAction[71]
		}
	},
	[24009016] = {
		24009016,
		0,
		Lang.get(60319),
		24009,
		16,
		273,
		{
			RTResTalkAction[50],
			RTResTalkAction[62],
			RTResTalkAction[4],
			RTResTalkAction[8]
		}
	},
	[24009017] = {
		24009017,
		0,
		Lang.get(60320),
		24009,
		17,
		273,
		{
			RTResTalkAction[50]
		}
	},
	[24009018] = {
		24009018,
		0,
		Lang.get(60321),
		24009,
		18,
		141,
		{
			RTResTalkAction[69],
			RTResTalkAction[43],
			RTResTalkAction[72],
			RTResTalkAction[38]
		}
	},
	[24009019] = {
		24009019,
		0,
		Lang.get(60322),
		24009,
		19,
		107,
		{
			RTResTalkAction[69],
			RTResTalkAction[43],
			RTResTalkAction[72]
		}
	},
	[24009020] = {
		24009020,
		0,
		Lang.get(60323),
		24009,
		20,
		276,
		{
			RTResTalkAction[69],
			RTResTalkAction[43],
			RTResTalkAction[72]
		}
	},
	[24009021] = {
		24009021,
		0,
		Lang.get(60324),
		24009,
		21,
		273,
		{
			RTResTalkAction[69],
			RTResTalkAction[43],
			RTResTalkAction[73],
			RTResTalkAction[4]
		}
	},
	[24009022] = {
		24009022,
		0,
		Lang.get(60325),
		24009,
		22,
		276,
		{
			RTResTalkAction[69],
			RTResTalkAction[43],
			RTResTalkAction[73]
		}
	},
	[24009023] = {
		24009023,
		0,
		Lang.get(60326),
		24009,
		23,
		273,
		{
			RTResTalkAction[50],
			RTResTalkAction[62],
			RTResTalkAction[8]
		}
	},
	[24009024] = {
		24009024,
		0,
		Lang.get(60327),
		24009,
		24,
		101,
		{
			RTResTalkAction[38]
		},
		1,
		0,
		nil,
		nil,
		nil,
		24024,
		nil,
		nil,
		nil,
		nil,
		nil,
		24024
	},
	[24009025] = {
		24009025,
		0,
		Lang.get(60328),
		24009,
		25,
		273,
		nil,
		1,
		0
	},
	[24009026] = {
		24009026,
		0,
		Lang.get(60329),
		24009,
		26,
		101,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		24032,
		nil,
		1,
		nil,
		nil,
		nil,
		24032
	},
	[24009027] = {
		24009027,
		0,
		Lang.get(60330),
		24009,
		27,
		107,
		nil,
		1,
		8
	},
	[24009028] = {
		24009028,
		0,
		Lang.get(60331),
		24009,
		28,
		275,
		{
			RTResTalkAction[45]
		},
		nil,
		0,
		3
	},
	[24009029] = {
		24009029,
		0,
		Lang.get(60332),
		24009,
		29,
		276,
		{
			RTResTalkAction[68],
			RTResTalkAction[49]
		}
	},
	[24009030] = {
		24009030,
		0,
		Lang.get(60333),
		24009,
		30,
		141,
		{
			RTResTalkAction[65],
			RTResTalkAction[52]
		}
	},
	[24009031] = {
		24009031,
		0,
		Lang.get(60334),
		24009,
		31,
		276,
		{
			RTResTalkAction[65],
			RTResTalkAction[52]
		}
	},
	[24009032] = {
		24009032,
		0,
		Lang.get(60335),
		24009,
		32,
		107,
		{
			RTResTalkAction[65],
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[24009033] = {
		24009033,
		0,
		Lang.get(60336),
		24009,
		33,
		276,
		{
			RTResTalkAction[65],
			RTResTalkAction[7]
		}
	},
	[24009034] = {
		24009034,
		0,
		Lang.get(60337),
		24009,
		34,
		141,
		{
			RTResTalkAction[43],
			RTResTalkAction[62],
			RTResTalkAction[4]
		}
	},
	[24009035] = {
		24009035,
		0,
		Lang.get(60338),
		24009,
		35,
		275,
		{
			RTResTalkAction[74],
			RTResTalkAction[8]
		},
		1,
		0,
		[21] = 395
	},
	[24009036] = {
		24009036,
		0,
		Lang.get(60339),
		24009,
		36,
		101,
		{
			RTResTalkAction[29],
			RTResTalkAction[75]
		}
	},
	[24009037] = {
		24009037,
		0,
		Lang.get(60340),
		24009,
		37,
		275,
		{
			RTResTalkAction[45],
			RTResTalkAction[25]
		}
	},
	[24010001] = {
		24010001,
		0,
		Lang.get(60341),
		24010,
		1,
		101,
		nil,
		1,
		0,
		nil,
		nil,
		62,
		24032,
		nil,
		nil,
		nil,
		nil,
		nil,
		24032
	},
	[24010002] = {
		24010002,
		0,
		Lang.get(60342),
		24010,
		2,
		276,
		nil,
		1,
		0
	},
	[24010003] = {
		24010003,
		0,
		Lang.get(60343),
		24010,
		3,
		107,
		nil,
		1,
		0
	},
	[24010004] = {
		24010004,
		3,
		Lang.get(60344),
		24010,
		4,
		605,
		[22] = 1
	},
	[24010005] = {
		24010005,
		0,
		Lang.get(60345),
		24010,
		5,
		121,
		nil,
		1,
		0
	},
	[24010006] = {
		24010006,
		0,
		Lang.get(60346),
		24010,
		6,
		273,
		nil,
		1,
		0
	},
	[24010007] = {
		24010007,
		0,
		Lang.get(60347),
		24010,
		7,
		121,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		24034,
		nil,
		nil,
		nil,
		nil,
		nil,
		24034
	},
	[24010008] = {
		24010008,
		0,
		Lang.get(60348),
		24010,
		8,
		273,
		{
			RTResTalkAction[50]
		},
		nil,
		nil,
		3
	},
	[24010009] = {
		24010009,
		0,
		Lang.get(60349),
		24010,
		9,
		108,
		{
			RTResTalkAction[35],
			RTResTalkAction[13]
		}
	},
	[24010010] = {
		24010010,
		0,
		Lang.get(60350),
		24010,
		10,
		108,
		{
			RTResTalkAction[35],
			RTResTalkAction[13]
		}
	},
	[24010011] = {
		24010011,
		2,
		Lang.get(60351),
		24010,
		11,
		121,
		{
			RTResTalkAction[76],
			RTResTalkAction[14],
			RTResTalkAction[77]
		}
	},
	[24010012] = {
		24010012,
		2,
		Lang.get(60352),
		24010,
		12,
		121,
		{
			RTResTalkAction[76],
			RTResTalkAction[14],
			RTResTalkAction[77]
		}
	},
	[24010013] = {
		24010013,
		0,
		Lang.get(60353),
		24010,
		13,
		273,
		{
			RTResTalkAction[76],
			RTResTalkAction[14],
			RTResTalkAction[77]
		}
	},
	[24010014] = {
		24010014,
		0,
		Lang.get(60354),
		24010,
		14,
		108,
		{
			RTResTalkAction[76],
			RTResTalkAction[14],
			RTResTalkAction[77]
		}
	},
	[24010015] = {
		24010015,
		0,
		Lang.get(60355),
		24010,
		15,
		273,
		{
			RTResTalkAction[50],
			RTResTalkAction[17],
			RTResTalkAction[15]
		}
	},
	[24010016] = {
		24010016,
		2,
		Lang.get(60356),
		24010,
		16,
		121,
		{
			RTResTalkAction[14],
			RTResTalkAction[38]
		}
	},
	[24010017] = {
		24010017,
		0,
		Lang.get(60357),
		24010,
		17,
		273,
		{
			RTResTalkAction[50],
			RTResTalkAction[17]
		}
	},
	[24011001] = {
		24011001,
		0,
		Lang.get(60358),
		24011,
		1,
		276,
		nil,
		1,
		0,
		nil,
		nil,
		62,
		24053,
		nil,
		1,
		nil,
		nil,
		nil,
		24053
	},
	[24011002] = {
		24011002,
		0,
		Lang.get(60359),
		24011,
		2,
		101,
		nil,
		1,
		0
	},
	[24011003] = {
		24011003,
		0,
		Lang.get(60360),
		24011,
		3,
		107,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		3
	},
	[24011004] = {
		24011004,
		0,
		Lang.get(60361),
		24011,
		4,
		141,
		{
			RTResTalkAction[41],
			RTResTalkAction[52]
		}
	},
	[24011005] = {
		24011005,
		0,
		Lang.get(60362),
		24011,
		5,
		276,
		{
			RTResTalkAction[69],
			RTResTalkAction[48],
			RTResTalkAction[71]
		}
	},
	[24011006] = {
		24011006,
		0,
		Lang.get(60363),
		24011,
		6,
		141,
		{
			RTResTalkAction[43],
			RTResTalkAction[62],
			RTResTalkAction[4]
		}
	},
	[24011007] = {
		24011007,
		0,
		Lang.get(62798),
		24011,
		7,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[8]
		}
	},
	[24011008] = {
		24011008,
		0,
		Lang.get(60365),
		24011,
		8,
		141,
		{
			RTResTalkAction[43],
			RTResTalkAction[4]
		}
	},
	[24011009] = {
		24011009,
		0,
		Lang.get(60366),
		24011,
		9,
		107,
		{
			RTResTalkAction[78],
			RTResTalkAction[52]
		}
	},
	[24011010] = {
		24011010,
		0,
		Lang.get(60367),
		24011,
		10,
		276,
		{
			RTResTalkAction[68],
			RTResTalkAction[4],
			RTResTalkAction[8]
		}
	},
	[24011011] = {
		24011011,
		0,
		Lang.get(60368),
		24011,
		11,
		276,
		{
			RTResTalkAction[62]
		},
		1,
		0,
		nil,
		nil,
		nil,
		24064,
		nil,
		nil,
		nil,
		nil,
		nil,
		24034
	},
	[24011012] = {
		24011012,
		0,
		Lang.get(60369),
		24011,
		12,
		134,
		{
			RTResTalkAction[26]
		},
		nil,
		nil,
		3
	},
	[24011013] = {
		24011013,
		0,
		Lang.get(60370),
		24011,
		13,
		276,
		{
			RTResTalkAction[68],
			RTResTalkAction[3]
		}
	},
	[24011014] = {
		24011014,
		0,
		Lang.get(60371),
		24011,
		14,
		276,
		{
			RTResTalkAction[62]
		},
		1,
		0,
		nil,
		nil,
		nil,
		24023,
		nil,
		nil,
		nil,
		nil,
		nil,
		24023
	},
	[24011015] = {
		24011015,
		0,
		Lang.get(60372),
		24011,
		15,
		273,
		nil,
		1,
		0
	},
	[24011016] = {
		24011016,
		0,
		Lang.get(60373),
		24011,
		16,
		273,
		nil,
		1,
		0
	},
	[24011017] = {
		24011017,
		0,
		Lang.get(60374),
		24011,
		17,
		107,
		nil,
		1,
		11
	},
	[24012001] = {
		24012001,
		0,
		Lang.get(60375),
		24012,
		1,
		101,
		nil,
		1,
		0,
		nil,
		nil,
		62,
		24032,
		nil,
		1,
		nil,
		nil,
		nil,
		24032
	},
	[24012002] = {
		24012002,
		0,
		Lang.get(60376),
		24012,
		2,
		101,
		nil,
		1,
		0
	},
	[24012003] = {
		24012003,
		0,
		Lang.get(60377),
		24012,
		3,
		141,
		{
			RTResTalkAction[43]
		},
		nil,
		nil,
		3
	},
	[24012004] = {
		24012004,
		0,
		Lang.get(60378),
		24012,
		4,
		101,
		{
			RTResTalkAction[12],
			RTResTalkAction[47]
		}
	},
	[24012005] = {
		24012005,
		0,
		Lang.get(60379),
		24012,
		5,
		141,
		{
			RTResTalkAction[43],
			RTResTalkAction[25]
		}
	},
	[24012006] = {
		24012006,
		0,
		Lang.get(60380),
		24012,
		6,
		141,
		{
			RTResTalkAction[43]
		}
	},
	[24012007] = {
		24012007,
		0,
		Lang.get(60381),
		24012,
		7,
		107,
		{
			RTResTalkAction[12],
			RTResTalkAction[7]
		}
	},
	[24012008] = {
		24012008,
		0,
		Lang.get(60382),
		24012,
		8,
		101,
		{
			RTResTalkAction[29],
			RTResTalkAction[8],
			RTResTalkAction[4]
		}
	},
	[24012009] = {
		24012009,
		0,
		Lang.get(60383),
		24012,
		9,
		276,
		{
			RTResTalkAction[23],
			RTResTalkAction[59]
		}
	},
	[24012010] = {
		24012010,
		0,
		Lang.get(60384),
		24012,
		10,
		101,
		{
			RTResTalkAction[29],
			RTResTalkAction[62]
		}
	},
	[24012011] = {
		24012011,
		0,
		Lang.get(60385),
		24012,
		11,
		275,
		{
			RTResTalkAction[45],
			RTResTalkAction[25]
		}
	},
	[24013001] = {
		24013001,
		0,
		Lang.get(60386),
		24013,
		1,
		273,
		nil,
		1,
		0,
		nil,
		nil,
		62,
		24038,
		nil,
		1,
		nil,
		nil,
		nil,
		24022
	},
	[24013002] = {
		24013002,
		0,
		Lang.get(60387),
		24013,
		2,
		226,
		nil,
		1,
		0
	},
	[24013003] = {
		24013003,
		2,
		Lang.get(60388),
		24013,
		3,
		101,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[24013004] = {
		24013004,
		0,
		Lang.get(60389),
		24013,
		4,
		273,
		{
			RTResTalkAction[50],
			RTResTalkAction[25]
		}
	},
	[24013005] = {
		24013005,
		0,
		Lang.get(62799),
		24013,
		5,
		226,
		{
			RTResTalkAction[54],
			RTResTalkAction[38]
		}
	},
	[24013006] = {
		24013006,
		0,
		Lang.get(62800),
		24013,
		6,
		226,
		{
			RTResTalkAction[54]
		}
	},
	[24013007] = {
		24013007,
		0,
		Lang.get(62801),
		24013,
		7,
		101,
		{
			RTResTalkAction[51],
			RTResTalkAction[47]
		}
	},
	[24013008] = {
		24013008,
		0,
		Lang.get(60392),
		24013,
		8,
		275,
		{
			RTResTalkAction[79],
			RTResTalkAction[29],
			RTResTalkAction[80]
		}
	},
	[24013009] = {
		24013009,
		0,
		Lang.get(62802),
		24013,
		9,
		101,
		{
			RTResTalkAction[79],
			RTResTalkAction[29],
			RTResTalkAction[80]
		}
	},
	[24013010] = {
		24013010,
		0,
		Lang.get(62803),
		24013,
		10,
		226,
		{
			RTResTalkAction[54],
			RTResTalkAction[25],
			RTResTalkAction[49]
		}
	},
	[24013011] = {
		24013011,
		0,
		Lang.get(60395),
		24013,
		11,
		275,
		{
			RTResTalkAction[51],
			RTResTalkAction[67]
		}
	},
	[24013012] = {
		24013012,
		0,
		Lang.get(60396),
		24013,
		12,
		226,
		{
			RTResTalkAction[51],
			RTResTalkAction[67]
		}
	},
	[24013013] = {
		24013013,
		0,
		Lang.get(60397),
		24013,
		13,
		101,
		{
			RTResTalkAction[51],
			RTResTalkAction[47],
			RTResTalkAction[49]
		}
	},
	[24013014] = {
		24013014,
		0,
		Lang.get(62804),
		24013,
		14,
		226,
		{
			RTResTalkAction[51],
			RTResTalkAction[47]
		}
	},
	[24013015] = {
		24013015,
		0,
		Lang.get(60399),
		24013,
		15,
		275,
		{
			RTResTalkAction[51],
			RTResTalkAction[67],
			RTResTalkAction[25]
		}
	},
	[24013016] = {
		24013016,
		0,
		Lang.get(60400),
		24013,
		16,
		101,
		{
			RTResTalkAction[51],
			RTResTalkAction[47],
			RTResTalkAction[49]
		}
	},
	[24013017] = {
		24013017,
		0,
		Lang.get(60401),
		24013,
		17,
		273,
		{
			RTResTalkAction[53],
			RTResTalkAction[25]
		},
		1,
		0,
		nil,
		nil,
		nil,
		24040,
		nil,
		1,
		nil,
		nil,
		nil,
		24024
	},
	[24013018] = {
		24013018,
		0,
		Lang.get(60402),
		24013,
		18,
		226,
		nil,
		1,
		0
	},
	[24013019] = {
		24013019,
		0,
		Lang.get(60403),
		24013,
		19,
		273,
		{
			RTResTalkAction[35],
			RTResTalkAction[81]
		},
		nil,
		nil,
		3
	},
	[24013020] = {
		24013020,
		0,
		Lang.get(60404),
		24013,
		20,
		101,
		{
			RTResTalkAction[76],
			RTResTalkAction[29],
			RTResTalkAction[82]
		}
	},
	[24013021] = {
		24013021,
		0,
		Lang.get(60405),
		24013,
		21,
		273,
		{
			RTResTalkAction[76],
			RTResTalkAction[29],
			RTResTalkAction[82]
		}
	},
	[24013022] = {
		24013022,
		0,
		Lang.get(60406),
		24013,
		22,
		226,
		{
			RTResTalkAction[35],
			RTResTalkAction[81],
			RTResTalkAction[25]
		}
	},
	[24013023] = {
		24013023,
		0,
		Lang.get(60407),
		24013,
		23,
		273,
		{
			RTResTalkAction[35],
			RTResTalkAction[81]
		}
	},
	[24013024] = {
		24013024,
		0,
		Lang.get(60408),
		24013,
		24,
		226,
		{
			RTResTalkAction[35],
			RTResTalkAction[81]
		}
	},
	[24014001] = {
		24014001,
		0,
		Lang.get(60409),
		24014,
		1,
		278,
		nil,
		1,
		0,
		nil,
		nil,
		62,
		24026,
		nil,
		1,
		nil,
		nil,
		nil,
		24026
	},
	[24014002] = {
		24014002,
		0,
		Lang.get(60410),
		24014,
		2,
		101,
		nil,
		1,
		0
	},
	[24014003] = {
		24014003,
		0,
		Lang.get(60411),
		24014,
		3,
		278,
		nil,
		1,
		0
	},
	[24014004] = {
		24014004,
		0,
		Lang.get(60412),
		24014,
		4,
		101,
		nil,
		1,
		0
	},
	[24014005] = {
		24014005,
		0,
		Lang.get(62805),
		24014,
		5,
		226,
		{
			RTResTalkAction[51],
			RTResTalkAction[58]
		},
		nil,
		nil,
		3
	},
	[24014006] = {
		24014006,
		0,
		Lang.get(60414),
		24014,
		6,
		273,
		{
			RTResTalkAction[51],
			RTResTalkAction[58]
		}
	},
	[24014007] = {
		24014007,
		0,
		Lang.get(60415),
		24014,
		7,
		101,
		{
			RTResTalkAction[23],
			RTResTalkAction[58],
			RTResTalkAction[53]
		}
	},
	[24014008] = {
		24014008,
		0,
		Lang.get(60416),
		24014,
		8,
		273,
		{
			RTResTalkAction[23],
			RTResTalkAction[58]
		}
	},
	[24014009] = {
		24014009,
		2,
		Lang.get(62806),
		24014,
		9,
		101,
		{
			RTResTalkAction[23],
			RTResTalkAction[58]
		}
	},
	[24014010] = {
		24014010,
		0,
		Lang.get(60418),
		24014,
		10,
		226,
		{
			RTResTalkAction[54],
			RTResTalkAction[25],
			RTResTalkAction[38]
		}
	},
	[24014011] = {
		24014011,
		0,
		Lang.get(60419),
		24014,
		11,
		226,
		{
			RTResTalkAction[54]
		}
	},
	[24014012] = {
		24014012,
		0,
		Lang.get(62807),
		24014,
		12,
		101,
		{
			RTResTalkAction[29],
			RTResTalkAction[53]
		}
	},
	[24014013] = {
		24014013,
		0,
		Lang.get(60421),
		24014,
		13,
		226,
		{
			RTResTalkAction[54],
			RTResTalkAction[25]
		}
	},
	[24014014] = {
		24014014,
		0,
		Lang.get(60422),
		24014,
		14,
		280,
		{
			RTResTalkAction[53]
		},
		1,
		0,
		nil,
		nil,
		nil,
		24025,
		nil,
		nil,
		nil,
		nil,
		nil,
		24025
	},
	[24014015] = {
		24014015,
		0,
		Lang.get(60423),
		24014,
		15,
		281,
		nil,
		1,
		0
	},
	[24014016] = {
		24014016,
		0,
		Lang.get(60424),
		24014,
		16,
		101,
		nil,
		1,
		0
	},
	[24014017] = {
		24014017,
		0,
		Lang.get(60425),
		24014,
		17,
		280,
		nil,
		1,
		0
	},
	[24014018] = {
		24014018,
		0,
		Lang.get(60426),
		24014,
		18,
		101,
		nil,
		1,
		3
	},
	[24014019] = {
		24014019,
		0,
		Lang.get(60427),
		24014,
		19,
		281,
		nil,
		1,
		0
	},
	[24014020] = {
		24014020,
		0,
		Lang.get(60428),
		24014,
		20,
		101,
		nil,
		1,
		3
	},
	[24014021] = {
		24014021,
		0,
		Lang.get(60429),
		24014,
		21,
		101,
		nil,
		1,
		3
	},
	[24015001] = {
		24015001,
		0,
		Lang.get(60430),
		24015,
		1,
		226,
		nil,
		1,
		0,
		nil,
		nil,
		62,
		24037,
		nil,
		nil,
		nil,
		nil,
		nil,
		24020
	},
	[24015002] = {
		24015002,
		0,
		Lang.get(60431),
		24015,
		2,
		274,
		nil,
		1,
		0
	},
	[24015003] = {
		24015003,
		0,
		Lang.get(62808),
		24015,
		3,
		134,
		nil,
		1,
		3
	},
	[24015004] = {
		24015004,
		0,
		Lang.get(60433),
		24015,
		4,
		141,
		nil,
		1,
		0
	},
	[24015005] = {
		24015005,
		0,
		Lang.get(60434),
		24015,
		5,
		107,
		nil,
		1
	},
	[24015006] = {
		24015006,
		2,
		Lang.get(60435),
		24015,
		6,
		276,
		nil,
		1
	},
	[24015007] = {
		24015007,
		0,
		Lang.get(62809),
		24015,
		7,
		274,
		nil,
		1
	},
	[24015008] = {
		24015008,
		0,
		Lang.get(60437),
		24015,
		8,
		134,
		nil,
		1,
		3
	},
	[24015009] = {
		24015009,
		0,
		Lang.get(60438),
		24015,
		9,
		226,
		{
			RTResTalkAction[54]
		},
		nil,
		nil,
		3
	},
	[24015010] = {
		24015010,
		0,
		Lang.get(60439),
		24015,
		10,
		226,
		{
			RTResTalkAction[54]
		}
	},
	[24015011] = {
		24015011,
		0,
		Lang.get(60440),
		24015,
		11,
		101,
		{
			RTResTalkAction[53]
		},
		1,
		0,
		-1
	},
	[24015012] = {
		24015012,
		0,
		Lang.get(60441),
		24015,
		12,
		278,
		nil,
		1,
		0
	},
	[24015013] = {
		24015013,
		0,
		Lang.get(60442),
		24015,
		13,
		101,
		nil,
		1,
		0
	},
	[24015014] = {
		24015014,
		0,
		Lang.get(60443),
		24015,
		14,
		274,
		{
			RTResTalkAction[83]
		},
		nil,
		nil,
		3
	},
	[24015015] = {
		24015015,
		0,
		Lang.get(60444),
		24015,
		15,
		101,
		{
			RTResTalkAction[84]
		},
		1,
		0,
		-1
	},
	[24015016] = {
		24015016,
		0,
		Lang.get(60445),
		24015,
		16,
		275,
		nil,
		1,
		0
	},
	[24015017] = {
		24015017,
		0,
		Lang.get(60446),
		24015,
		17,
		274,
		{
			RTResTalkAction[83]
		},
		nil,
		nil,
		3
	},
	[24015018] = {
		24015018,
		2,
		Lang.get(62810),
		24015,
		18,
		101,
		{
			RTResTalkAction[84]
		},
		1,
		0,
		-1
	},
	[24015019] = {
		24015019,
		0,
		Lang.get(60448),
		24015,
		19,
		276,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		24044,
		nil,
		1,
		nil,
		nil,
		nil,
		24044
	},
	[24015020] = {
		24015020,
		0,
		Lang.get(60449),
		24015,
		20,
		101,
		{
			RTResTalkAction[65],
			RTResTalkAction[47]
		},
		1,
		0,
		3
	},
	[24015021] = {
		24015021,
		0,
		Lang.get(60450),
		24015,
		21,
		276,
		{
			RTResTalkAction[65],
			RTResTalkAction[47]
		}
	},
	[24015022] = {
		24015022,
		0,
		Lang.get(60451),
		24015,
		22,
		101,
		{
			RTResTalkAction[65],
			RTResTalkAction[47]
		}
	},
	[24016001] = {
		24016001,
		0,
		Lang.get(60452),
		24016,
		1,
		280,
		nil,
		1,
		0,
		nil,
		nil,
		62,
		24045,
		nil,
		1,
		nil,
		nil,
		nil,
		24045
	},
	[24016002] = {
		24016002,
		0,
		Lang.get(60453),
		24016,
		2,
		101,
		nil,
		1,
		0
	},
	[24016003] = {
		24016003,
		0,
		Lang.get(60454),
		24016,
		3,
		281,
		nil,
		1,
		0
	},
	[24016004] = {
		24016004,
		0,
		Lang.get(60455),
		24016,
		4,
		101,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[24016005] = {
		24016005,
		0,
		Lang.get(60456),
		24016,
		5,
		280,
		{
			RTResTalkAction[85],
			RTResTalkAction[25]
		}
	},
	[24016006] = {
		24016006,
		0,
		Lang.get(60457),
		24016,
		6,
		101,
		{
			RTResTalkAction[29],
			RTResTalkAction[86]
		}
	},
	[24016007] = {
		24016007,
		0,
		Lang.get(60458),
		24016,
		7,
		281,
		{
			RTResTalkAction[87],
			RTResTalkAction[25]
		}
	},
	[24016008] = {
		24016008,
		0,
		Lang.get(60459),
		24016,
		8,
		101,
		{
			RTResTalkAction[29],
			RTResTalkAction[88]
		}
	},
	[24016009] = {
		24016009,
		3,
		Lang.get(60460),
		24016,
		9,
		605,
		{
			RTResTalkAction[25]
		},
		nil,
		nil,
		-1,
		[22] = 1
	},
	[24017001] = {
		24017001,
		0,
		Lang.get(60461),
		24017,
		1,
		273,
		nil,
		1,
		0,
		nil,
		nil,
		62,
		24046,
		nil,
		nil,
		nil,
		nil,
		nil,
		24046
	},
	[24017002] = {
		24017002,
		0,
		Lang.get(60462),
		24017,
		2,
		122,
		nil,
		1,
		0
	},
	[24017003] = {
		24017003,
		0,
		Lang.get(60463),
		24017,
		3,
		122,
		{
			RTResTalkAction[35],
			RTResTalkAction[89]
		},
		nil,
		nil,
		3
	},
	[24017004] = {
		24017004,
		0,
		Lang.get(60464),
		24017,
		4,
		273,
		{
			RTResTalkAction[35],
			RTResTalkAction[89]
		}
	},
	[24017005] = {
		24017005,
		0,
		Lang.get(60465),
		24017,
		5,
		122,
		{
			RTResTalkAction[35],
			RTResTalkAction[89]
		}
	},
	[24017006] = {
		24017006,
		0,
		Lang.get(60466),
		24017,
		6,
		273,
		{
			RTResTalkAction[35],
			RTResTalkAction[89]
		}
	},
	[24017007] = {
		24017007,
		0,
		Lang.get(60467),
		24017,
		7,
		122,
		{
			RTResTalkAction[35],
			RTResTalkAction[89]
		},
		1,
		0,
		-1
	},
	[24017008] = {
		24017008,
		0,
		Lang.get(60468),
		24017,
		8,
		273,
		{
			RTResTalkAction[38],
			RTResTalkAction[90]
		},
		1,
		0,
		nil,
		nil,
		nil,
		24047,
		nil,
		nil,
		nil,
		nil,
		nil,
		24047
	},
	[24017009] = {
		24017009,
		0,
		Lang.get(60469),
		24017,
		9,
		122,
		nil,
		1,
		1
	},
	[24017010] = {
		24017010,
		0,
		Lang.get(60470),
		24017,
		10,
		273,
		nil,
		1,
		0
	},
	[24017011] = {
		24017011,
		0,
		Lang.get(60471),
		24017,
		11,
		122,
		nil,
		1,
		1
	},
	[24017012] = {
		24017012,
		0,
		Lang.get(60472),
		24017,
		12,
		273,
		nil,
		1,
		0
	},
	[24017013] = {
		24017013,
		3,
		Lang.get(35478),
		24017,
		13,
		605,
		[22] = 1
	},
	[24017014] = {
		24017014,
		0,
		Lang.get(60473),
		24017,
		14,
		280,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		24045,
		nil,
		nil,
		nil,
		nil,
		nil,
		24045
	},
	[24017015] = {
		24017015,
		0,
		Lang.get(60474),
		24017,
		15,
		101,
		nil,
		1,
		0
	},
	[24017016] = {
		24017016,
		0,
		Lang.get(60475),
		24017,
		16,
		281,
		nil,
		1,
		0
	},
	[24017017] = {
		24017017,
		0,
		Lang.get(60476),
		24017,
		17,
		273,
		{
			RTResTalkAction[91],
			RTResTalkAction[50],
			RTResTalkAction[92]
		},
		nil,
		nil,
		3
	},
	[24017018] = {
		24017018,
		0,
		Lang.get(60477),
		24017,
		18,
		101,
		{
			RTResTalkAction[91],
			RTResTalkAction[50],
			RTResTalkAction[92]
		}
	},
	[24017019] = {
		24017019,
		0,
		Lang.get(60478),
		24017,
		19,
		101,
		{
			RTResTalkAction[91],
			RTResTalkAction[50],
			RTResTalkAction[92]
		}
	},
	[24017020] = {
		24017020,
		0,
		Lang.get(60479),
		24017,
		20,
		122,
		{
			RTResTalkAction[93],
			RTResTalkAction[25],
			RTResTalkAction[38]
		}
	},
	[24018001] = {
		24018001,
		0,
		Lang.get(60480),
		24018,
		1,
		101,
		nil,
		1,
		0,
		nil,
		nil,
		59,
		24049,
		nil,
		nil,
		nil,
		nil,
		nil,
		24045
	},
	[24018002] = {
		24018002,
		0,
		Lang.get(60481),
		24018,
		2,
		122,
		nil,
		1,
		0
	},
	[24018003] = {
		24018003,
		0,
		Lang.get(60482),
		24018,
		3,
		107,
		{
			RTResTalkAction[24]
		},
		nil,
		nil,
		3
	},
	[24018004] = {
		24018004,
		0,
		Lang.get(60483),
		24018,
		4,
		122,
		{
			RTResTalkAction[93],
			RTResTalkAction[4]
		}
	},
	[24018005] = {
		24018005,
		0,
		Lang.get(62811),
		24018,
		5,
		141,
		{
			RTResTalkAction[41],
			RTResTalkAction[52],
			RTResTalkAction[90]
		}
	},
	[24018006] = {
		24018006,
		0,
		Lang.get(62812),
		24018,
		6,
		107,
		{
			RTResTalkAction[41],
			RTResTalkAction[52]
		}
	},
	[24018007] = {
		24018007,
		0,
		Lang.get(60486),
		24018,
		7,
		101,
		{
			RTResTalkAction[29],
			RTResTalkAction[4],
			RTResTalkAction[8]
		}
	},
	[24018008] = {
		24018008,
		0,
		Lang.get(62813),
		24018,
		8,
		273,
		{
			RTResTalkAction[50],
			RTResTalkAction[25]
		}
	},
	[24018009] = {
		24018009,
		0,
		Lang.get(60488),
		24018,
		9,
		107,
		{
			RTResTalkAction[41],
			RTResTalkAction[52],
			RTResTalkAction[38]
		}
	},
	[24018010] = {
		24018010,
		0,
		Lang.get(60489),
		24018,
		10,
		141,
		{
			RTResTalkAction[41],
			RTResTalkAction[52]
		}
	},
	[24018011] = {
		24018011,
		0,
		Lang.get(60490),
		24018,
		11,
		273,
		{
			RTResTalkAction[50],
			RTResTalkAction[4],
			RTResTalkAction[8]
		}
	},
	[24018012] = {
		24018012,
		0,
		Lang.get(60491),
		24018,
		12,
		107,
		{
			RTResTalkAction[76],
			RTResTalkAction[48],
			RTResTalkAction[71]
		}
	},
	[24018013] = {
		24018013,
		0,
		Lang.get(60492),
		24018,
		13,
		273,
		{
			RTResTalkAction[76],
			RTResTalkAction[48],
			RTResTalkAction[71]
		}
	},
	[24018014] = {
		24018014,
		0,
		Lang.get(62814),
		24018,
		14,
		141,
		{
			RTResTalkAction[76],
			RTResTalkAction[48],
			RTResTalkAction[71]
		}
	},
	[24018015] = {
		24018015,
		0,
		Lang.get(60494),
		24018,
		15,
		273,
		{
			RTResTalkAction[50],
			RTResTalkAction[4],
			RTResTalkAction[8]
		}
	},
	[24018016] = {
		24018016,
		0,
		Lang.get(60495),
		24018,
		16,
		101,
		{
			RTResTalkAction[29],
			RTResTalkAction[38]
		}
	},
	[24018017] = {
		24018017,
		0,
		Lang.get(60496),
		24018,
		17,
		101,
		{
			RTResTalkAction[29]
		}
	},
	[24018018] = {
		24018018,
		0,
		Lang.get(60497),
		24018,
		18,
		107,
		{
			RTResTalkAction[25]
		},
		1,
		0,
		nil,
		nil,
		nil,
		24050,
		nil,
		nil,
		nil,
		nil,
		nil,
		24010
	},
	[24018019] = {
		24018019,
		0,
		Lang.get(60498),
		24018,
		19,
		273,
		nil,
		1,
		0
	},
	[24018020] = {
		24018020,
		0,
		Lang.get(60499),
		24018,
		20,
		273,
		nil,
		1,
		0
	},
	[24018021] = {
		24018021,
		0,
		Lang.get(60500),
		24018,
		21,
		134,
		{
			RTResTalkAction[26]
		},
		nil,
		nil,
		3
	},
	[24018022] = {
		24018022,
		0,
		Lang.get(60501),
		24018,
		22,
		273,
		{
			RTResTalkAction[20],
			RTResTalkAction[58]
		}
	},
	[24018023] = {
		24018023,
		0,
		Lang.get(60502),
		24018,
		23,
		300,
		{
			RTResTalkAction[3],
			RTResTalkAction[38]
		}
	},
	[24018024] = {
		24018024,
		0,
		Lang.get(60503),
		24018,
		24,
		273,
		{
			RTResTalkAction[50]
		}
	},
	[24018025] = {
		24018025,
		0,
		Lang.get(60504),
		24018,
		25,
		300,
		{
			RTResTalkAction[38]
		}
	},
	[24018026] = {
		24018026,
		0,
		Lang.get(62815),
		24018,
		26,
		101,
		{
			RTResTalkAction[29]
		}
	},
	[24019001] = {
		24019001,
		0,
		Lang.get(60506),
		24019,
		1,
		107,
		nil,
		1,
		4,
		nil,
		nil,
		62,
		24052,
		nil,
		nil,
		nil,
		nil,
		nil,
		24011
	},
	[24019002] = {
		24019002,
		0,
		Lang.get(60507),
		24019,
		2,
		275,
		nil,
		1,
		0
	},
	[24019003] = {
		24019003,
		0,
		Lang.get(60508),
		24019,
		3,
		107,
		nil,
		1,
		4
	},
	[24019004] = {
		24019004,
		0,
		Lang.get(60509),
		24019,
		4,
		101,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[24019005] = {
		24019005,
		0,
		Lang.get(60510),
		24019,
		5,
		273,
		{
			RTResTalkAction[23],
			RTResTalkAction[58]
		}
	},
	[24019006] = {
		24019006,
		0,
		Lang.get(60511),
		24019,
		6,
		101,
		{
			RTResTalkAction[23],
			RTResTalkAction[58]
		}
	},
	[24019007] = {
		24019007,
		0,
		Lang.get(62816),
		24019,
		7,
		101,
		{
			RTResTalkAction[23],
			RTResTalkAction[58]
		}
	},
	[24019008] = {
		24019008,
		0,
		Lang.get(60513),
		24019,
		8,
		273,
		{
			RTResTalkAction[25],
			RTResTalkAction[38]
		},
		1,
		0,
		nil,
		nil,
		nil,
		24059,
		nil,
		1,
		nil,
		nil,
		nil,
		24010
	},
	[24019009] = {
		24019009,
		0,
		Lang.get(60514),
		24019,
		9,
		134,
		nil,
		1,
		2
	},
	[24019010] = {
		24019010,
		0,
		Lang.get(60515),
		24019,
		10,
		273,
		nil,
		1,
		0
	},
	[24019011] = {
		24019011,
		0,
		Lang.get(60516),
		24019,
		11,
		134,
		{
			RTResTalkAction[20],
			RTResTalkAction[58]
		},
		nil,
		nil,
		3
	},
	[24019012] = {
		24019012,
		0,
		Lang.get(60517),
		24019,
		12,
		273,
		{
			RTResTalkAction[20],
			RTResTalkAction[58]
		}
	},
	[24019013] = {
		24019013,
		0,
		Lang.get(60518),
		24019,
		13,
		42,
		{
			RTResTalkAction[94],
			RTResTalkAction[58],
			RTResTalkAction[3]
		}
	},
	[24019014] = {
		24019014,
		0,
		Lang.get(60519),
		24019,
		14,
		273,
		{
			RTResTalkAction[35],
			RTResTalkAction[95],
			RTResTalkAction[33]
		}
	},
	[24019015] = {
		24019015,
		0,
		Lang.get(60520),
		24019,
		15,
		134,
		{
			RTResTalkAction[26],
			RTResTalkAction[38],
			RTResTalkAction[96]
		}
	},
	[24019016] = {
		24019016,
		0,
		Lang.get(60521),
		24019,
		16,
		300,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		-1
	},
	[24019017] = {
		24019017,
		0,
		Lang.get(60522),
		24019,
		17,
		300
	},
	[24019018] = {
		24019018,
		0,
		Lang.get(60523),
		24019,
		18,
		273,
		{
			RTResTalkAction[50]
		},
		nil,
		nil,
		3
	},
	[24019019] = {
		24019019,
		2,
		Lang.get(60524),
		24019,
		19,
		300,
		{
			RTResTalkAction[38]
		},
		nil,
		nil,
		-1
	},
	[24019020] = {
		24019020,
		0,
		Lang.get(60525),
		24019,
		20,
		300
	},
	[24019021] = {
		24019021,
		3,
		Lang.get(60526),
		24019,
		21,
		605,
		[22] = 1
	},
	[24019022] = {
		24019022,
		0,
		Lang.get(60527),
		24019,
		22,
		300
	},
	[24019023] = {
		24019023,
		0,
		Lang.get(62817),
		24019,
		23,
		273,
		{
			RTResTalkAction[50]
		},
		nil,
		nil,
		3
	},
	[24019024] = {
		24019024,
		0,
		Lang.get(60529),
		24019,
		24,
		134,
		{
			RTResTalkAction[26],
			RTResTalkAction[38]
		}
	},
	[24019025] = {
		24019025,
		0,
		Lang.get(62818),
		24019,
		25,
		273,
		{
			RTResTalkAction[50],
			RTResTalkAction[3]
		}
	},
	[24019026] = {
		24019026,
		0,
		Lang.get(62819),
		24019,
		26,
		273,
		{
			RTResTalkAction[50]
		}
	},
	[24019027] = {
		24019027,
		0,
		Lang.get(62820),
		24019,
		27,
		134,
		{
			RTResTalkAction[26],
			RTResTalkAction[38]
		}
	},
	[24019028] = {
		24019028,
		0,
		Lang.get(60532),
		24019,
		28,
		300,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		-1
	},
	[24019029] = {
		24019029,
		0,
		Lang.get(60533),
		24019,
		29,
		134,
		{
			RTResTalkAction[26]
		}
	},
	[24019030] = {
		24019030,
		0,
		Lang.get(62821),
		24019,
		30,
		273,
		{
			RTResTalkAction[50],
			RTResTalkAction[3]
		}
	},
	[24019031] = {
		24019031,
		0,
		Lang.get(62822),
		24019,
		31,
		273,
		{
			RTResTalkAction[50]
		}
	},
	[24020001] = {
		24020001,
		3,
		Lang.get(60536),
		24020,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		24053,
		nil,
		1,
		nil,
		nil,
		nil,
		24053,
		nil,
		nil,
		1
	},
	[24020002] = {
		24020002,
		0,
		Lang.get(60537),
		24020,
		2,
		274,
		{
			RTResTalkAction[83]
		},
		nil,
		nil,
		3
	},
	[24020003] = {
		24020003,
		2,
		Lang.get(60538),
		24020,
		3,
		300,
		{
			RTResTalkAction[84]
		},
		nil,
		nil,
		-1
	},
	[24020004] = {
		24020004,
		0,
		Lang.get(60539),
		24020,
		4,
		278,
		{
			RTResTalkAction[97]
		},
		nil,
		nil,
		3
	},
	[24020005] = {
		24020005,
		0,
		Lang.get(60540),
		24020,
		5,
		278,
		{
			RTResTalkAction[97]
		}
	},
	[24020006] = {
		24020006,
		0,
		Lang.get(62823),
		24020,
		6,
		300,
		{
			RTResTalkAction[98]
		},
		nil,
		nil,
		-1
	},
	[24020007] = {
		24020007,
		0,
		Lang.get(60542),
		24020,
		7,
		278,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		24054,
		nil,
		nil,
		nil,
		nil,
		nil,
		24054
	},
	[24020008] = {
		24020008,
		0,
		Lang.get(60543),
		24020,
		8,
		278,
		nil,
		1,
		0
	},
	[24020009] = {
		24020009,
		0,
		Lang.get(60544),
		24020,
		9,
		198,
		{
			RTResTalkAction[99]
		},
		nil,
		nil,
		3
	},
	[24020010] = {
		24020010,
		0,
		Lang.get(60545),
		24020,
		10,
		140,
		{
			RTResTalkAction[100],
			RTResTalkAction[101]
		}
	},
	[24020011] = {
		24020011,
		0,
		Lang.get(60546),
		24020,
		11,
		279,
		{
			RTResTalkAction[66],
			RTResTalkAction[102]
		}
	},
	[24020012] = {
		24020012,
		0,
		Lang.get(60547),
		24020,
		12,
		198,
		{
			RTResTalkAction[60]
		},
		1,
		0,
		-1
	},
	[24020013] = {
		24020013,
		0,
		Lang.get(60548),
		24020,
		13,
		279,
		{
			RTResTalkAction[66]
		},
		nil,
		nil,
		3
	},
	[24020014] = {
		24020014,
		0,
		Lang.get(60549),
		24020,
		14,
		279,
		{
			RTResTalkAction[66]
		}
	},
	[24020015] = {
		24020015,
		0,
		Lang.get(60550),
		24020,
		15,
		140,
		{
			RTResTalkAction[60]
		},
		1,
		0,
		-1,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[24020016] = {
		24020016,
		0,
		Lang.get(60551),
		24020,
		16,
		101,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[24020017] = {
		24020017,
		0,
		Lang.get(62824),
		24020,
		17,
		101,
		{
			RTResTalkAction[29]
		}
	},
	[24020018] = {
		24020018,
		0,
		Lang.get(60553),
		24020,
		18,
		279,
		{
			RTResTalkAction[66],
			RTResTalkAction[25]
		}
	},
	[24020019] = {
		24020019,
		0,
		Lang.get(60554),
		24020,
		19,
		198,
		{
			RTResTalkAction[60]
		},
		1,
		2,
		-1
	},
	[24020020] = {
		24020020,
		0,
		Lang.get(60555),
		24020,
		20,
		140,
		nil,
		1,
		0
	},
	[24020021] = {
		24020021,
		0,
		Lang.get(62825),
		24020,
		21,
		119,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		24055,
		nil,
		1,
		nil,
		nil,
		nil,
		24055
	},
	[24020022] = {
		24020022,
		0,
		Lang.get(60557),
		24020,
		22,
		276,
		nil,
		1,
		0
	},
	[24020023] = {
		24020023,
		0,
		Lang.get(60558),
		24020,
		23,
		128,
		nil,
		1,
		0
	},
	[24020024] = {
		24020024,
		0,
		Lang.get(62826),
		24020,
		24,
		276,
		{
			RTResTalkAction[68]
		},
		nil,
		nil,
		3
	},
	[24020025] = {
		24020025,
		0,
		Lang.get(60560),
		24020,
		25,
		119,
		{
			RTResTalkAction[68]
		},
		1,
		1,
		-1
	},
	[24020026] = {
		24020026,
		0,
		Lang.get(60561),
		24020,
		26,
		276,
		{
			RTResTalkAction[68]
		},
		nil,
		nil,
		3
	},
	[24020027] = {
		24020027,
		0,
		Lang.get(60562),
		24020,
		27,
		276,
		{
			RTResTalkAction[68]
		}
	},
	[24021001] = {
		24021001,
		0,
		Lang.get(60563),
		24021,
		1,
		277,
		nil,
		1,
		0,
		nil,
		nil,
		62,
		24063,
		nil,
		1,
		nil,
		nil,
		nil,
		24022
	},
	[24021002] = {
		24021002,
		0,
		Lang.get(60564),
		24021,
		2,
		108,
		nil,
		1,
		0
	},
	[24021003] = {
		24021003,
		0,
		Lang.get(60565),
		24021,
		3,
		277,
		nil,
		1,
		0,
		[21] = 394
	},
	[24021004] = {
		24021004,
		0,
		Lang.get(60566),
		24021,
		4,
		121,
		nil,
		1,
		0
	},
	[24021005] = {
		24021005,
		0,
		Lang.get(60567),
		24021,
		5,
		277,
		{
			RTResTalkAction[103]
		},
		nil,
		nil,
		3
	},
	[24021006] = {
		24021006,
		0,
		Lang.get(60568),
		24021,
		6,
		108,
		{
			RTResTalkAction[104]
		},
		1,
		0,
		-1
	},
	[24021007] = {
		24021007,
		0,
		Lang.get(60569),
		24021,
		7,
		277,
		{
			RTResTalkAction[103]
		},
		nil,
		nil,
		3
	},
	[24021008] = {
		24021008,
		0,
		Lang.get(60570),
		24021,
		8,
		108,
		{
			RTResTalkAction[104]
		},
		1,
		2,
		-1
	},
	[24021009] = {
		24021009,
		0,
		Lang.get(62827),
		24021,
		9,
		121,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		24057,
		nil,
		nil,
		nil,
		nil,
		nil,
		24057
	},
	[24021010] = {
		24021010,
		0,
		Lang.get(60572),
		24021,
		10,
		274,
		nil,
		1,
		0
	},
	[24021011] = {
		24021011,
		0,
		Lang.get(60573),
		24021,
		11,
		121,
		nil,
		1,
		0
	},
	[24021012] = {
		24021012,
		0,
		Lang.get(63505),
		24021,
		12,
		276,
		nil,
		1,
		0
	},
	[24021013] = {
		24021013,
		0,
		Lang.get(62828),
		24021,
		13,
		108,
		{
			RTResTalkAction[105]
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
		nil,
		394
	},
	[24021014] = {
		24021014,
		0,
		Lang.get(60576),
		24021,
		14,
		274,
		{
			RTResTalkAction[83],
			RTResTalkAction[106]
		}
	},
	[24021015] = {
		24021015,
		0,
		Lang.get(60577),
		24021,
		15,
		276,
		{
			RTResTalkAction[68],
			RTResTalkAction[84]
		}
	},
	[24021016] = {
		24021016,
		0,
		Lang.get(60578),
		24021,
		16,
		275,
		{
			RTResTalkAction[45],
			RTResTalkAction[62]
		}
	},
	[24021017] = {
		24021017,
		0,
		Lang.get(60579),
		24021,
		17,
		279,
		{
			RTResTalkAction[66],
			RTResTalkAction[49]
		}
	},
	[24021018] = {
		24021018,
		2,
		Lang.get(60580),
		24021,
		18,
		300,
		{
			RTResTalkAction[60]
		}
	},
	[24021019] = {
		24021019,
		0,
		Lang.get(60581),
		24021,
		19,
		300
	},
	[24021020] = {
		24021020,
		0,
		Lang.get(60582),
		24021,
		20,
		300
	},
	[24021021] = {
		24021021,
		0,
		Lang.get(60583),
		24021,
		21,
		279,
		{
			RTResTalkAction[66]
		}
	},
	[24021022] = {
		24021022,
		0,
		Lang.get(60584),
		24021,
		22,
		101,
		{
			RTResTalkAction[29],
			RTResTalkAction[60]
		}
	},
	[24021023] = {
		24021023,
		0,
		Lang.get(60585),
		24021,
		23,
		119,
		{
			RTResTalkAction[25]
		},
		1,
		1,
		-1
	},
	[24022001] = {
		24022001,
		0,
		Lang.get(62829),
		24022,
		1,
		101,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		24025,
		nil,
		nil,
		nil,
		nil,
		nil,
		24025
	},
	[24022002] = {
		24022002,
		0,
		Lang.get(62830),
		24022,
		2,
		101,
		nil,
		1,
		0
	},
	[24022003] = {
		24022003,
		0,
		Lang.get(60588),
		24022,
		3,
		280,
		nil,
		1,
		0
	},
	[24023001] = {
		24023001,
		0,
		Lang.get(60589),
		24023,
		1,
		276,
		nil,
		1,
		0,
		nil,
		nil,
		63,
		24066,
		nil,
		nil,
		nil,
		nil,
		nil,
		24057
	},
	[24023002] = {
		24023002,
		0,
		Lang.get(60590),
		24023,
		2,
		274,
		{
			RTResTalkAction[83]
		},
		nil,
		nil,
		3
	},
	[24023003] = {
		24023003,
		0,
		Lang.get(60591),
		24023,
		3,
		101,
		{
			RTResTalkAction[29],
			RTResTalkAction[84]
		}
	},
	[24023004] = {
		24023004,
		0,
		Lang.get(60592),
		24023,
		4,
		280,
		{
			RTResTalkAction[25]
		},
		1,
		0,
		-1
	},
	[24023005] = {
		24023005,
		0,
		Lang.get(62831),
		24023,
		5,
		281,
		nil,
		1,
		0
	},
	[24023006] = {
		24023006,
		3,
		Lang.get(60594),
		24023,
		6,
		605,
		[22] = 1
	},
	[24024001] = {
		24024001,
		0,
		Lang.get(60595),
		24024,
		1,
		121,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		24056,
		nil,
		nil,
		nil,
		nil,
		nil,
		24056
	},
	[24024002] = {
		24024002,
		0,
		Lang.get(60596),
		24024,
		2,
		275,
		nil,
		1,
		0
	},
	[24024003] = {
		24024003,
		2,
		Lang.get(60597),
		24024,
		3,
		274,
		{
			RTResTalkAction[83]
		},
		nil,
		nil,
		3
	},
	[24024004] = {
		24024004,
		0,
		Lang.get(60598),
		24024,
		4,
		279,
		{
			RTResTalkAction[66],
			RTResTalkAction[84]
		}
	},
	[24024005] = {
		24024005,
		2,
		Lang.get(60599),
		24024,
		5,
		274,
		{
			RTResTalkAction[83],
			RTResTalkAction[60]
		}
	},
	[24024006] = {
		24024006,
		0,
		Lang.get(60600),
		24024,
		6,
		122,
		{
			RTResTalkAction[84]
		},
		1,
		0,
		-1
	},
	[24024007] = {
		24024007,
		0,
		Lang.get(60601),
		24024,
		7,
		101,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		24061,
		nil,
		nil,
		nil,
		nil,
		nil,
		24061
	},
	[24024008] = {
		24024008,
		0,
		Lang.get(60602),
		24024,
		8,
		274,
		nil,
		1,
		0
	},
	[24024009] = {
		24024009,
		0,
		Lang.get(60603),
		24024,
		9,
		101,
		nil,
		1,
		0
	},
	[24024010] = {
		24024010,
		0,
		Lang.get(60604),
		24024,
		10,
		276,
		nil,
		1,
		0
	},
	[24024011] = {
		24024011,
		0,
		Lang.get(60605),
		24024,
		11,
		274,
		nil,
		1,
		0
	},
	[24024012] = {
		24024012,
		0,
		Lang.get(62832),
		24024,
		12,
		101,
		nil,
		1,
		0
	},
	[24024013] = {
		24024013,
		0,
		Lang.get(60607),
		24024,
		13,
		274,
		nil,
		1,
		0
	},
	[24024014] = {
		24024014,
		0,
		Lang.get(60608),
		24024,
		14,
		279,
		nil,
		1,
		0
	},
	[24024015] = {
		24024015,
		5,
		Lang.get(60609),
		24024,
		15,
		274,
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
	[24024016] = {
		24024016,
		0,
		Lang.get(60610),
		24024,
		16,
		122,
		nil,
		1,
		0
	},
	[24024017] = {
		24024017,
		0,
		Lang.get(60611),
		24024,
		17,
		276,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		24068,
		nil,
		1,
		nil,
		nil,
		nil,
		24068
	},
	[24024018] = {
		24024018,
		0,
		Lang.get(60612),
		24024,
		18,
		274,
		nil,
		1,
		0
	},
	[24024019] = {
		24024019,
		0,
		Lang.get(60613),
		24024,
		19,
		119,
		{
			RTResTalkAction[105]
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
		nil,
		394
	},
	[24024020] = {
		24024020,
		0,
		Lang.get(60614),
		24024,
		20,
		128,
		{
			RTResTalkAction[107],
			RTResTalkAction[106]
		}
	},
	[24024021] = {
		24024021,
		0,
		Lang.get(60615),
		24024,
		21,
		119,
		{
			RTResTalkAction[108],
			RTResTalkAction[109]
		}
	},
	[24024022] = {
		24024022,
		0,
		Lang.get(60616),
		24024,
		22,
		128,
		{
			RTResTalkAction[107],
			RTResTalkAction[110]
		}
	},
	[24024023] = {
		24024023,
		0,
		Lang.get(63151),
		24024,
		23,
		119,
		{
			RTResTalkAction[108],
			RTResTalkAction[109]
		}
	},
	[24025001] = {
		24025001,
		0,
		Lang.get(60618),
		24025,
		1,
		119,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		24058,
		nil,
		1,
		nil,
		nil,
		nil,
		24058
	},
	[24025002] = {
		24025002,
		0,
		Lang.get(60619),
		24025,
		2,
		150,
		nil,
		1
	},
	[24025003] = {
		24025003,
		0,
		Lang.get(60620),
		24025,
		3,
		277,
		{
			RTResTalkAction[103]
		},
		nil,
		nil,
		3
	},
	[24025004] = {
		24025004,
		0,
		Lang.get(60621),
		24025,
		4,
		150,
		{
			RTResTalkAction[111],
			RTResTalkAction[104]
		}
	},
	[24025005] = {
		24025005,
		0,
		Lang.get(60622),
		24025,
		5,
		277,
		{
			RTResTalkAction[103],
			RTResTalkAction[112]
		}
	},
	[24025006] = {
		24025006,
		0,
		Lang.get(60623),
		24025,
		6,
		119,
		{
			RTResTalkAction[108],
			RTResTalkAction[104]
		}
	},
	[24025007] = {
		24025007,
		0,
		Lang.get(62833),
		24025,
		7,
		101,
		{
			RTResTalkAction[29],
			RTResTalkAction[110]
		}
	},
	[24025008] = {
		24025008,
		0,
		Lang.get(60625),
		24025,
		8,
		119,
		{
			RTResTalkAction[108],
			RTResTalkAction[25]
		}
	},
	[24025009] = {
		24025009,
		0,
		Lang.get(60626),
		24025,
		9,
		277,
		{
			RTResTalkAction[103],
			RTResTalkAction[110]
		}
	},
	[24025010] = {
		24025010,
		0,
		Lang.get(60627),
		24025,
		10,
		277,
		{
			RTResTalkAction[103]
		}
	},
	[24025011] = {
		24025011,
		0,
		Lang.get(60628),
		24025,
		11,
		119,
		{
			RTResTalkAction[108],
			RTResTalkAction[104]
		}
	},
	[24025012] = {
		24025012,
		0,
		Lang.get(60629),
		24025,
		12,
		150,
		{
			RTResTalkAction[111],
			RTResTalkAction[110]
		}
	},
	[24025013] = {
		24025013,
		0,
		Lang.get(60630),
		24025,
		13,
		277,
		{
			RTResTalkAction[103],
			RTResTalkAction[112]
		}
	},
	[24025014] = {
		24025014,
		0,
		Lang.get(60631),
		24025,
		14,
		101,
		{
			RTResTalkAction[29],
			RTResTalkAction[104]
		}
	},
	[24025015] = {
		24025015,
		0,
		Lang.get(60632),
		24025,
		15,
		119,
		{
			RTResTalkAction[108],
			RTResTalkAction[25]
		}
	},
	[24025016] = {
		24025016,
		0,
		Lang.get(60633),
		24025,
		16,
		150,
		{
			RTResTalkAction[111],
			RTResTalkAction[110]
		}
	},
	[24025017] = {
		24025017,
		0,
		Lang.get(60634),
		24025,
		17,
		107,
		{
			RTResTalkAction[112]
		},
		1,
		0,
		nil,
		nil,
		58,
		24059,
		nil,
		1,
		nil,
		nil,
		nil,
		24010
	},
	[24025018] = {
		24025018,
		0,
		Lang.get(60635),
		24025,
		18,
		141,
		nil,
		1,
		0
	},
	[24025019] = {
		24025019,
		0,
		Lang.get(60636),
		24025,
		19,
		107,
		nil,
		1,
		4
	},
	[24025020] = {
		24025020,
		0,
		Lang.get(60637),
		24025,
		20,
		141,
		nil,
		1,
		0
	},
	[24025021] = {
		24025021,
		4,
		nil,
		24025,
		21,
		141,
		nil,
		1,
		0,
		[29] = {
			{
				id = 24025022,
				branch_content = Lang.get(60638)
			}
		}
	},
	[24025022] = {
		24025022,
		0,
		Lang.get(60639),
		24025,
		22,
		273,
		{
			RTResTalkAction[50]
		},
		nil,
		nil,
		3
	},
	[24025023] = {
		24025023,
		0,
		Lang.get(60640),
		24025,
		23,
		134,
		{
			RTResTalkAction[26],
			RTResTalkAction[38]
		}
	},
	[24025024] = {
		24025024,
		0,
		Lang.get(60641),
		24025,
		24,
		300,
		{
			RTResTalkAction[3]
		}
	},
	[24025025] = {
		24025025,
		0,
		Lang.get(60642),
		24025,
		25,
		273,
		{
			RTResTalkAction[50]
		}
	},
	[24025026] = {
		24025026,
		0,
		Lang.get(60643),
		24025,
		26,
		300,
		{
			RTResTalkAction[38]
		}
	},
	[24025027] = {
		24025027,
		0,
		Lang.get(60644),
		24025,
		27,
		273,
		{
			RTResTalkAction[50]
		}
	},
	[24025028] = {
		24025028,
		0,
		Lang.get(60645),
		24025,
		28,
		300,
		{
			RTResTalkAction[38]
		}
	},
	[24025029] = {
		24025029,
		0,
		Lang.get(60646),
		24025,
		29,
		134,
		{
			RTResTalkAction[26]
		}
	},
	[24025030] = {
		24025030,
		0,
		Lang.get(60647),
		24025,
		30,
		273,
		{
			RTResTalkAction[50],
			RTResTalkAction[3]
		}
	},
	[24025031] = {
		24025031,
		0,
		Lang.get(60648),
		24025,
		31,
		300,
		{
			RTResTalkAction[38]
		}
	},
	[24025032] = {
		24025032,
		4,
		nil,
		24025,
		32,
		300,
		[29] = {
			{
				id = 24025033,
				branch_content = Lang.get(60649)
			}
		}
	},
	[24025033] = {
		24025033,
		0,
		Lang.get(60650),
		24025,
		33,
		273,
		{
			RTResTalkAction[50]
		}
	},
	[24025034] = {
		24025034,
		0,
		Lang.get(60651),
		24025,
		34,
		273,
		{
			RTResTalkAction[50]
		}
	},
	[24025035] = {
		24025035,
		0,
		Lang.get(62834),
		24025,
		35,
		300,
		{
			RTResTalkAction[38]
		}
	},
	[24025036] = {
		24025036,
		0,
		Lang.get(60653),
		24025,
		36,
		134,
		{
			RTResTalkAction[26]
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
