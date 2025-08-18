-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\clara\\ResTalk.lua

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
	[2] = 1222
}
RTResTalkAction[2] = {
	[1] = 0,
	[2] = 1222
}
RTResTalkAction[3] = {
	[1] = 1,
	[2] = 1028,
	[3] = {
		1
	}
}
RTResTalkAction[4] = {
	[1] = 1,
	[2] = 1027
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 1028
}
RTResTalkAction[6] = {
	[1] = 0,
	[2] = 1027
}
RTResTalkAction[7] = {
	[1] = 1,
	[2] = 1028
}
RTResTalkAction[8] = {
	1,
	1047,
	nil,
	nil,
	1
}
RTResTalkAction[9] = {
	[1] = 0,
	[2] = 1047
}
RTResTalkAction[10] = {
	[1] = 1,
	[2] = 1118
}
RTResTalkAction[11] = {
	[1] = 0,
	[2] = 1118
}
RTResTalkAction[12] = {
	[1] = 1,
	[2] = 1122
}
RTResTalkAction[13] = {
	[1] = 0,
	[2] = 1122
}
RTResTalkAction[14] = {
	[1] = 1,
	[2] = 1027,
	[3] = {
		1
	}
}
RTResTalkAction[15] = {
	1,
	1047,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[16] = {
	1,
	1214,
	nil,
	nil,
	3
}
RTResTalkAction[17] = {
	[1] = 0,
	[2] = 1214
}
RTResTalkAction[18] = {
	[1] = 2,
	[2] = 1214
}
RTResTalkAction[19] = {
	3,
	1047,
	nil,
	nil,
	1
}
RTResTalkAction[20] = {
	[1] = 3,
	[2] = 1047
}
RTResTalkAction[21] = {
	2,
	1214,
	nil,
	nil,
	3
}
RTResTalkAction[22] = {
	[1] = 1,
	[2] = 1047
}
RTResTalkAction[23] = {
	1,
	1214,
	nil,
	nil,
	1
}
RTResTalkAction[24] = {
	[1] = 1,
	[2] = 1214
}
RTResTalkAction[25] = {
	2,
	1214,
	nil,
	nil,
	4
}
RTResTalkAction[26] = {
	2,
	1214,
	nil,
	nil,
	1
}
RTResTalkAction[27] = {
	1,
	1214,
	nil,
	nil,
	4
}
RTResTalkAction[28] = {
	[1] = 1,
	[2] = 208
}
RTResTalkAction[29] = {
	[1] = 0,
	[2] = 208
}
RTResTalkAction[30] = {
	[1] = 2,
	[2] = 1047
}
RTResTalkAction[31] = {
	3,
	1214,
	nil,
	nil,
	1
}
RTResTalkAction[32] = {
	[1] = 1,
	[2] = 182,
	[3] = {
		1
	}
}
RTResTalkAction[33] = {
	[1] = 0,
	[2] = 182
}
RTResTalkAction[34] = {
	2,
	1047,
	nil,
	nil,
	1
}
RTResTalkAction[35] = {
	[1] = 3,
	[2] = 1214
}
RTResTalkAction[36] = {
	3,
	1214,
	nil,
	nil,
	4
}
RTResTalkAction[37] = {
	[1] = 1,
	[2] = 225,
	[3] = {
		2
	}
}
RTResTalkAction[38] = {
	[1] = 1,
	[2] = 1047,
	[3] = {
		1
	}
}
RTResTalkAction[39] = {
	[1] = 0,
	[2] = 225
}
RTResTalkAction[40] = {
	[1] = 1,
	[2] = 1142
}
RTResTalkAction[41] = {
	[1] = 0,
	[2] = 1142
}
RTResTalkAction[42] = {
	[1] = 1,
	[2] = 215
}
RTResTalkAction[43] = {
	[1] = 1,
	[2] = 1219
}
RTResTalkAction[44] = {
	[1] = 0,
	[2] = 215
}
RTResTalkAction[45] = {
	[1] = 0,
	[2] = 1219
}
RTResTalkAction[46] = {
	[1] = 2,
	[2] = 1219
}
RTResTalkAction[47] = {
	[1] = 3,
	[2] = 1220
}
RTResTalkAction[48] = {
	[1] = 0,
	[2] = 1220
}
RTResTalkAction[49] = {
	1,
	1214,
	nil,
	nil,
	2
}
RTResTalkAction[50] = {
	[1] = 1,
	[2] = 1179
}
RTResTalkAction[51] = {
	[1] = 0,
	[2] = 1179
}
RTResTalkAction[52] = {
	[1] = 1,
	[2] = 1047,
	[3] = {
		3
	}
}
RTResTalkAction[53] = {
	1,
	1214,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[54] = {
	[1] = 1,
	[2] = 1217
}
RTResTalkAction[55] = {
	[1] = 0,
	[2] = 1217
}
RTResTalkAction[56] = {
	1,
	1047,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[57] = {
	[1] = 1,
	[2] = 1218,
	[3] = {
		3
	}
}
RTResTalkAction[58] = {
	[1] = 0,
	[2] = 1218
}
RTResTalkAction[59] = {
	1,
	1047,
	nil,
	nil,
	2
}
RTResTalkAction[60] = {
	1,
	1047,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[61] = {
	1,
	1214,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[62] = {
	[1] = 1,
	[2] = 1216
}
RTResTalkAction[63] = {
	[1] = 0,
	[2] = 1216
}
RTResTalkAction[64] = {
	[1] = 1,
	[2] = 1218,
	[3] = {
		1
	}
}
RTResTalkAction[65] = {
	[1] = 1,
	[2] = 1218
}
RTResTalkAction[66] = {
	[1] = 1,
	[2] = 1221
}
RTResTalkAction[67] = {
	[1] = 0,
	[2] = 1221
}
RTResTalkAction[68] = {
	1,
	1214,
	{
		3
	},
	nil,
	3
}
RTResTalkAction[69] = {
	1,
	1214,
	{
		1
	},
	nil,
	4
}
RTResTalkAction[70] = {
	3,
	1047,
	nil,
	nil,
	2
}
RTResTalkAction[71] = {
	[1] = 1,
	[2] = 1219,
	[3] = {
		3
	}
}
RTResTalkAction[72] = {
	1,
	215,
	nil,
	nil,
	2
}
RTResTalkAction[73] = {
	[1] = 3,
	[2] = 1219
}
RTResTalkAction[74] = {
	[1] = 1,
	[2] = 1226
}
RTResTalkAction[75] = {
	[1] = 1,
	[2] = 1227
}
RTResTalkAction[76] = {
	[1] = 0,
	[2] = 1226
}
RTResTalkAction[77] = {
	[1] = 1,
	[2] = 237,
	[3] = {
		3
	}
}
RTResTalkAction[78] = {
	[1] = 0,
	[2] = 1227
}
RTResTalkAction[79] = {
	[1] = 0,
	[2] = 237
}
RTResTalkAction[80] = {
	[1] = 1,
	[2] = 1228
}
RTResTalkAction[81] = {
	[1] = 0,
	[2] = 1228
}
RTResTalkAction[82] = {
	2,
	1214,
	nil,
	nil,
	2
}
RTResTalkAction[83] = {
	[1] = 2,
	[2] = 1227
}
RTResTalkAction[84] = {
	[1] = 3,
	[2] = 1226
}
RTResTalkAction[85] = {
	[1] = 1,
	[2] = 1228,
	[3] = {
		3
	}
}
RTResTalkAction[86] = {
	[1] = 1,
	[2] = 225
}
RTResTalkAction[87] = {
	1,
	1214,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[88] = {
	[1] = 1,
	[2] = 1060,
	[3] = {
		3
	}
}
RTResTalkAction[89] = {
	[1] = 0,
	[2] = 1060
}
RTResTalkAction[90] = {
	[1] = 1,
	[2] = 237
}
RTResTalkAction[91] = {
	1,
	215,
	nil,
	nil,
	1
}
RTResTalkAction[92] = {
	[1] = 1,
	[2] = 1057
}
RTResTalkAction[93] = {
	[1] = 1,
	[2] = 1056
}
RTResTalkAction[94] = {
	[1] = 0,
	[2] = 1057
}
RTResTalkAction[95] = {
	[1] = 1,
	[2] = 1060
}
RTResTalkAction[96] = {
	[1] = 0,
	[2] = 1056
}
RTResTalkAction[97] = {
	[1] = 3,
	[2] = 1210
}
RTResTalkAction[98] = {
	[1] = 0,
	[2] = 1210
}
RTResTalkAction[99] = {
	1,
	1047,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[100] = {
	1,
	1214,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[101] = {
	1,
	1132,
	nil,
	nil,
	2
}
RTResTalkAction[102] = {
	[1] = 0,
	[2] = 1132
}
RTResTalkAction[103] = {
	1,
	1132,
	nil,
	nil,
	1
}

local Data = {
	[36701001] = {
		36701001,
		5,
		Lang.get(98148),
		36701,
		1,
		1224,
		{
			RTResTalkAction[1]
		},
		1,
		nil,
		nil,
		nil,
		47,
		36701,
		nil,
		1,
		nil,
		nil,
		nil,
		36701,
		255
	},
	[36701002] = {
		36701002,
		0,
		Lang.get(98149),
		36701,
		2,
		1215,
		{
			RTResTalkAction[2]
		},
		[20] = 255
	},
	[36701003] = {
		36701003,
		0,
		Lang.get(98150),
		36701,
		3,
		1215,
		[20] = 255
	},
	[36701004] = {
		36701004,
		0,
		Lang.get(98151),
		36701,
		4,
		1028,
		nil,
		1,
		nil,
		nil,
		nil,
		168,
		36702,
		nil,
		1,
		nil,
		nil,
		nil,
		36702,
		-1
	},
	[36701005] = {
		36701005,
		0,
		Lang.get(98152),
		36701,
		5,
		1027,
		nil,
		1
	},
	[36701006] = {
		36701006,
		0,
		Lang.get(98153),
		36701,
		6,
		1028,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[36701007] = {
		36701007,
		0,
		Lang.get(98154),
		36701,
		7,
		1027,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[36701008] = {
		36701008,
		7,
		"109",
		36701,
		8,
		1027,
		{
			RTResTalkAction[6]
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
	[36701009] = {
		36701009,
		0,
		Lang.get(98155),
		36701,
		9,
		1028,
		{
			RTResTalkAction[7]
		}
	},
	[36701010] = {
		36701010,
		0,
		Lang.get(98156),
		36701,
		10,
		1047,
		{
			RTResTalkAction[8],
			RTResTalkAction[5]
		}
	},
	[36701011] = {
		36701011,
		0,
		Lang.get(98157),
		36701,
		11,
		1027,
		{
			RTResTalkAction[4],
			RTResTalkAction[9]
		}
	},
	[36701012] = {
		36701012,
		0,
		Lang.get(98158),
		36701,
		12,
		1233,
		{
			RTResTalkAction[6]
		},
		1,
		nil,
		-1,
		nil,
		50,
		36704,
		nil,
		1,
		nil,
		nil,
		nil,
		36704
	},
	[36701013] = {
		36701013,
		0,
		Lang.get(98159),
		36701,
		13,
		1118,
		nil,
		1,
		nil,
		3
	},
	[36701014] = {
		36701014,
		0,
		Lang.get(98160),
		36701,
		14,
		1027,
		{
			RTResTalkAction[4]
		}
	},
	[36701015] = {
		36701015,
		0,
		Lang.get(98161),
		36701,
		15,
		1047,
		{
			RTResTalkAction[8],
			RTResTalkAction[6]
		}
	},
	[36701016] = {
		36701016,
		0,
		Lang.get(98162),
		36701,
		16,
		1027,
		{
			RTResTalkAction[9]
		},
		1,
		nil,
		-1,
		nil,
		nil,
		36706,
		nil,
		1,
		nil,
		nil,
		nil,
		36706
	},
	[36701017] = {
		36701017,
		0,
		Lang.get(98163),
		36701,
		17,
		1118,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		36707,
		nil,
		1,
		nil,
		nil,
		nil,
		36707
	},
	[36701018] = {
		36701018,
		0,
		Lang.get(98164),
		36701,
		18,
		1233,
		nil,
		1
	},
	[36701019] = {
		36701019,
		0,
		Lang.get(98165),
		36701,
		19,
		1047,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3
	},
	[36701020] = {
		36701020,
		0,
		Lang.get(98166),
		36701,
		20,
		1118,
		{
			RTResTalkAction[10],
			RTResTalkAction[9]
		}
	},
	[36701021] = {
		36701021,
		0,
		Lang.get(98167),
		36701,
		21,
		1028,
		{
			RTResTalkAction[11]
		},
		1,
		nil,
		-1,
		nil,
		nil,
		36708,
		nil,
		1,
		nil,
		nil,
		nil,
		36708
	},
	[36701022] = {
		36701022,
		0,
		Lang.get(75264),
		36701,
		22,
		1118,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		36709,
		nil,
		1,
		nil,
		nil,
		nil,
		36709
	},
	[36701023] = {
		36701023,
		0,
		Lang.get(98168),
		36701,
		23,
		1027,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		36708,
		nil,
		1,
		nil,
		nil,
		nil,
		36708
	},
	[36701024] = {
		36701024,
		0,
		Lang.get(98169),
		36701,
		24,
		1028,
		nil,
		1,
		1
	},
	[36701025] = {
		36701025,
		0,
		Lang.get(87600),
		36701,
		25,
		1233,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		36710,
		nil,
		1,
		nil,
		nil,
		nil,
		36710
	},
	[36702001] = {
		36702001,
		0,
		Lang.get(98170),
		36702,
		1,
		1028,
		nil,
		1,
		nil,
		nil,
		2702,
		63,
		36711,
		nil,
		1,
		nil,
		nil,
		nil,
		36711
	},
	[36702002] = {
		36702002,
		0,
		Lang.get(98171),
		36702,
		2,
		1028,
		nil,
		1
	},
	[36702003] = {
		36702003,
		0,
		Lang.get(98172),
		36702,
		3,
		1122,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		3
	},
	[36702004] = {
		36702004,
		0,
		Lang.get(98173),
		36702,
		4,
		1027,
		{
			RTResTalkAction[4],
			RTResTalkAction[13]
		}
	},
	[36702005] = {
		36702005,
		0,
		Lang.get(98174),
		36702,
		5,
		1122,
		{
			RTResTalkAction[12],
			RTResTalkAction[6]
		}
	},
	[36702006] = {
		36702006,
		0,
		Lang.get(98175),
		36702,
		6,
		1027,
		{
			RTResTalkAction[14],
			RTResTalkAction[13]
		}
	},
	[36702007] = {
		36702007,
		0,
		Lang.get(98176),
		36702,
		7,
		1122,
		{
			RTResTalkAction[12],
			RTResTalkAction[6]
		}
	},
	[36702008] = {
		36702008,
		5,
		Lang.get(98177),
		36702,
		8,
		605,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		nil,
		1232,
		[22] = 1
	},
	[36702009] = {
		36702009,
		0,
		Lang.get(98178),
		36702,
		9,
		1233,
		nil,
		1
	},
	[36703001] = {
		36703001,
		0,
		Lang.get(98179),
		36703,
		1,
		1047,
		nil,
		1,
		1,
		nil,
		nil,
		190,
		36715,
		nil,
		1,
		nil,
		nil,
		nil,
		36715
	},
	[36703002] = {
		36703002,
		0,
		Lang.get(98180),
		36703,
		2,
		1047,
		nil,
		1,
		1
	},
	[36703003] = {
		36703003,
		5,
		Lang.get(98177),
		36703,
		3,
		605,
		nil,
		nil,
		nil,
		nil,
		1232,
		47,
		[22] = 1
	},
	[36703004] = {
		36703004,
		5,
		Lang.get(98181),
		36703,
		4,
		1047,
		{
			RTResTalkAction[15]
		},
		nil,
		nil,
		3
	},
	[36703005] = {
		36703005,
		0,
		Lang.get(98182),
		36703,
		5,
		1047,
		{
			RTResTalkAction[9]
		},
		1,
		1,
		-1,
		nil,
		nil,
		36716,
		nil,
		1,
		nil,
		1,
		nil,
		36716,
		255
	},
	[36703006] = {
		36703006,
		0,
		"………………………………",
		36703,
		6,
		1215,
		nil,
		1,
		[20] = -1
	},
	[36703007] = {
		36703007,
		0,
		Lang.get(98183),
		36703,
		7,
		1047,
		nil,
		1,
		1
	},
	[36703008] = {
		36703008,
		0,
		Lang.get(98184),
		36703,
		8,
		1047,
		nil,
		1,
		1
	},
	[36703009] = {
		36703009,
		0,
		Lang.get(98185),
		36703,
		9,
		1215,
		nil,
		1
	},
	[36703010] = {
		36703010,
		0,
		Lang.get(98186),
		36703,
		10,
		1047,
		nil,
		1,
		1,
		[20] = 255
	},
	[36703011] = {
		36703011,
		0,
		Lang.get(98187),
		36703,
		11,
		1047,
		nil,
		1,
		nil,
		nil,
		nil,
		190,
		36717,
		nil,
		1,
		nil,
		1,
		nil,
		36717,
		-1
	},
	[36703012] = {
		36703012,
		0,
		Lang.get(98188),
		36703,
		12,
		1214,
		nil,
		1,
		4
	},
	[36703013] = {
		36703013,
		0,
		Lang.get(98189),
		36703,
		13,
		1047,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3
	},
	[36703014] = {
		36703014,
		0,
		Lang.get(98190),
		36703,
		14,
		1214,
		{
			RTResTalkAction[16],
			RTResTalkAction[9]
		}
	},
	[36703015] = {
		36703015,
		7,
		"108",
		36703,
		15,
		1214,
		{
			RTResTalkAction[17]
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
	[36703016] = {
		36703016,
		0,
		Lang.get(98191),
		36703,
		16,
		1214,
		{
			RTResTalkAction[16]
		}
	},
	[36703017] = {
		36703017,
		0,
		Lang.get(98192),
		36703,
		17,
		1047,
		{
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[36703018] = {
		36703018,
		0,
		Lang.get(98193),
		36703,
		18,
		1214,
		{
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[36703019] = {
		36703019,
		0,
		Lang.get(21533),
		36703,
		19,
		1047,
		{
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[36703020] = {
		36703020,
		0,
		Lang.get(98194),
		36703,
		20,
		1214,
		{
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[36703021] = {
		36703021,
		0,
		Lang.get(98195),
		36703,
		21,
		1047,
		{
			RTResTalkAction[18],
			RTResTalkAction[20]
		}
	},
	[36703022] = {
		36703022,
		0,
		Lang.get(98196),
		36703,
		22,
		1214,
		{
			RTResTalkAction[21],
			RTResTalkAction[19]
		}
	},
	[36703023] = {
		36703023,
		0,
		Lang.get(18644),
		36703,
		23,
		1047,
		{
			RTResTalkAction[8],
			RTResTalkAction[17]
		}
	},
	[36703024] = {
		36703024,
		0,
		Lang.get(98197),
		36703,
		24,
		300,
		{
			RTResTalkAction[22]
		}
	},
	[36703025] = {
		36703025,
		0,
		Lang.get(98198),
		36703,
		25,
		1214,
		{
			RTResTalkAction[23],
			RTResTalkAction[9]
		}
	},
	[36703026] = {
		36703026,
		0,
		Lang.get(98199),
		36703,
		26,
		300,
		{
			RTResTalkAction[24]
		}
	},
	[36703027] = {
		36703027,
		0,
		Lang.get(98200),
		36703,
		27,
		1047,
		{
			RTResTalkAction[8],
			RTResTalkAction[17]
		}
	},
	[36703028] = {
		36703028,
		0,
		Lang.get(98201),
		36703,
		28,
		300,
		{
			RTResTalkAction[22]
		}
	},
	[36703029] = {
		36703029,
		0,
		Lang.get(98202),
		36703,
		29,
		1214,
		{
			RTResTalkAction[23],
			RTResTalkAction[9]
		}
	},
	[36703030] = {
		36703030,
		4,
		nil,
		36703,
		30,
		300,
		{
			RTResTalkAction[24]
		},
		[29] = {
			{
				id = 36703031,
				branch_content = Lang.get(98203)
			},
			{
				id = 36703031,
				branch_content = Lang.get(98204)
			}
		}
	},
	[36703031] = {
		36703031,
		0,
		Lang.get(98205),
		36703,
		31,
		1214,
		{
			RTResTalkAction[23]
		}
	},
	[36703032] = {
		36703032,
		0,
		Lang.get(98206),
		36703,
		32,
		300,
		{
			RTResTalkAction[24]
		}
	},
	[36704001] = {
		36704001,
		0,
		Lang.get(98207),
		36704,
		1,
		1047,
		nil,
		1,
		nil,
		-1,
		nil,
		177,
		36720,
		nil,
		1,
		nil,
		1,
		nil,
		36720
	},
	[36704002] = {
		36704002,
		0,
		Lang.get(98208),
		36704,
		2,
		1214,
		nil,
		1
	},
	[36704003] = {
		36704003,
		0,
		Lang.get(98209),
		36704,
		3,
		1047,
		{
			RTResTalkAction[22]
		},
		nil,
		nil,
		3
	},
	[36704004] = {
		36704004,
		0,
		Lang.get(98210),
		36704,
		4,
		1214,
		{
			RTResTalkAction[16],
			RTResTalkAction[9]
		}
	},
	[36704005] = {
		36704005,
		0,
		Lang.get(98211),
		36704,
		5,
		1047,
		{
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[36704006] = {
		36704006,
		0,
		Lang.get(98212),
		36704,
		6,
		1214,
		{
			RTResTalkAction[25],
			RTResTalkAction[19]
		}
	},
	[36704007] = {
		36704007,
		0,
		Lang.get(98213),
		36704,
		7,
		1047,
		{
			RTResTalkAction[26],
			RTResTalkAction[19]
		}
	},
	[36704008] = {
		36704008,
		0,
		Lang.get(98214),
		36704,
		8,
		1214,
		{
			RTResTalkAction[26],
			RTResTalkAction[19]
		}
	},
	[36704009] = {
		36704009,
		0,
		Lang.get(98215),
		36704,
		9,
		1047,
		{
			RTResTalkAction[26],
			RTResTalkAction[20]
		}
	},
	[36704010] = {
		36704010,
		0,
		Lang.get(98216),
		36704,
		10,
		1214,
		{
			RTResTalkAction[27],
			RTResTalkAction[9]
		}
	},
	[36704011] = {
		36704011,
		0,
		Lang.get(98217),
		36704,
		11,
		1047,
		{
			RTResTalkAction[22],
			RTResTalkAction[17]
		}
	},
	[36704012] = {
		36704012,
		0,
		Lang.get(98218),
		36704,
		12,
		1214,
		{
			RTResTalkAction[26],
			RTResTalkAction[20]
		}
	},
	[36704013] = {
		36704013,
		0,
		Lang.get(98219),
		36704,
		13,
		1047,
		{
			RTResTalkAction[26],
			RTResTalkAction[19]
		}
	},
	[36704014] = {
		36704014,
		0,
		Lang.get(98220),
		36704,
		14,
		1214,
		{
			RTResTalkAction[27],
			RTResTalkAction[9]
		}
	},
	[36704015] = {
		36704015,
		0,
		Lang.get(98221),
		36704,
		15,
		1214,
		{
			RTResTalkAction[27]
		}
	},
	[36704016] = {
		36704016,
		0,
		Lang.get(19105),
		36704,
		16,
		1047,
		{
			RTResTalkAction[22],
			RTResTalkAction[17]
		}
	},
	[36704017] = {
		36704017,
		0,
		Lang.get(98222),
		36704,
		17,
		1047,
		{
			RTResTalkAction[9]
		},
		1,
		nil,
		nil,
		nil,
		153,
		36721,
		nil,
		1,
		nil,
		1,
		nil,
		36721
	},
	[36704018] = {
		36704018,
		0,
		Lang.get(98223),
		36704,
		18,
		1047,
		nil,
		1
	},
	[36704019] = {
		36704019,
		0,
		Lang.get(98224),
		36704,
		19,
		1214,
		nil,
		1
	},
	[36704020] = {
		36704020,
		0,
		Lang.get(98225),
		36704,
		20,
		1047,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3
	},
	[36704021] = {
		36704021,
		0,
		Lang.get(98226),
		36704,
		21,
		1214,
		{
			RTResTalkAction[23],
			RTResTalkAction[9]
		}
	},
	[36704022] = {
		36704022,
		0,
		Lang.get(98227),
		36704,
		22,
		1047,
		{
			RTResTalkAction[8],
			RTResTalkAction[17]
		}
	},
	[36704023] = {
		36704023,
		0,
		Lang.get(98228),
		36704,
		23,
		1214,
		{
			RTResTalkAction[9]
		},
		1,
		4,
		-1,
		nil,
		60,
		36722,
		nil,
		1,
		nil,
		1,
		nil,
		36722
	},
	[36704024] = {
		36704024,
		0,
		Lang.get(98229),
		36704,
		24,
		1047,
		nil,
		1,
		1
	},
	[36704025] = {
		36704025,
		0,
		Lang.get(98230),
		36704,
		25,
		1214,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[36704026] = {
		36704026,
		0,
		Lang.get(98231),
		36704,
		26,
		1047,
		{
			RTResTalkAction[26],
			RTResTalkAction[19]
		}
	},
	[36704027] = {
		36704027,
		0,
		Lang.get(98232),
		36704,
		27,
		1214,
		{
			RTResTalkAction[26],
			RTResTalkAction[20]
		}
	},
	[36704028] = {
		36704028,
		0,
		Lang.get(98233),
		36704,
		28,
		1047,
		{
			RTResTalkAction[26],
			RTResTalkAction[20]
		}
	},
	[36704029] = {
		36704029,
		0,
		Lang.get(98234),
		36704,
		29,
		208,
		{
			RTResTalkAction[28],
			RTResTalkAction[17],
			RTResTalkAction[9]
		}
	},
	[36704030] = {
		36704030,
		0,
		Lang.get(98235),
		36704,
		30,
		1047,
		{
			RTResTalkAction[22],
			RTResTalkAction[29]
		}
	},
	[36705001] = {
		36705001,
		0,
		Lang.get(98236),
		36705,
		1,
		1214,
		nil,
		1,
		1,
		-1,
		nil,
		185,
		36723,
		nil,
		1,
		nil,
		1,
		nil,
		36723
	},
	[36705002] = {
		36705002,
		0,
		Lang.get(98237),
		36705,
		2,
		1047,
		nil,
		1
	},
	[36705003] = {
		36705003,
		0,
		Lang.get(98238),
		36705,
		3,
		208,
		{
			RTResTalkAction[28]
		},
		nil,
		nil,
		3
	},
	[36705004] = {
		36705004,
		0,
		Lang.get(98239),
		36705,
		4,
		1047,
		{
			RTResTalkAction[22],
			RTResTalkAction[29]
		}
	},
	[36705005] = {
		36705005,
		0,
		Lang.get(98240),
		36705,
		5,
		1214,
		{
			RTResTalkAction[23],
			RTResTalkAction[9]
		}
	},
	[36705006] = {
		36705006,
		0,
		Lang.get(98241),
		36705,
		6,
		1047,
		{
			RTResTalkAction[26],
			RTResTalkAction[19]
		}
	},
	[36705007] = {
		36705007,
		0,
		Lang.get(98242),
		36705,
		7,
		1214,
		{
			RTResTalkAction[25],
			RTResTalkAction[20]
		}
	},
	[36705008] = {
		36705008,
		0,
		Lang.get(98243),
		36705,
		8,
		1047,
		{
			RTResTalkAction[22],
			RTResTalkAction[17]
		}
	},
	[36705009] = {
		36705009,
		0,
		Lang.get(98244),
		36705,
		9,
		1214,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[36705010] = {
		36705010,
		0,
		Lang.get(98245),
		36705,
		10,
		1047,
		{
			RTResTalkAction[22],
			RTResTalkAction[17]
		}
	},
	[36730001] = {
		36730001,
		0,
		Lang.get(98246),
		36730,
		1,
		182,
		nil,
		1,
		nil,
		-1,
		nil,
		153,
		36724,
		nil,
		1,
		nil,
		nil,
		nil,
		36724
	},
	[36730002] = {
		36730002,
		3,
		Lang.get(98247),
		36730,
		2,
		605,
		nil,
		nil,
		nil,
		nil,
		1232,
		[22] = 1
	},
	[36730003] = {
		36730003,
		0,
		Lang.get(98248),
		36730,
		3,
		225,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		36725,
		[19] = 36725
	},
	[36730004] = {
		36730004,
		0,
		Lang.get(98249),
		36730,
		4,
		225,
		nil,
		1
	},
	[36730005] = {
		36730005,
		3,
		Lang.get(98250),
		36730,
		5,
		605,
		nil,
		nil,
		nil,
		nil,
		1232,
		[22] = 1
	},
	[36730006] = {
		36730006,
		0,
		Lang.get(98251),
		36730,
		6,
		182,
		{
			RTResTalkAction[32]
		},
		nil,
		nil,
		3
	},
	[36730007] = {
		36730007,
		0,
		Lang.get(98252),
		36730,
		7,
		1047,
		{
			RTResTalkAction[8],
			RTResTalkAction[33]
		}
	},
	[36730008] = {
		36730008,
		0,
		Lang.get(98253),
		36730,
		8,
		1214,
		{
			RTResTalkAction[16],
			RTResTalkAction[9]
		}
	},
	[36730009] = {
		36730009,
		5,
		Lang.get(98254),
		36730,
		9,
		605,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		nil,
		1232,
		[22] = 1
	},
	[36730010] = {
		36730010,
		0,
		Lang.get(98255),
		36730,
		10,
		1047,
		{
			RTResTalkAction[8]
		}
	},
	[36730011] = {
		36730011,
		0,
		Lang.get(98256),
		36730,
		11,
		1214,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[36730012] = {
		36730012,
		0,
		Lang.get(98257),
		36730,
		12,
		1047,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[36730013] = {
		36730013,
		0,
		Lang.get(98258),
		36730,
		13,
		1214,
		{
			RTResTalkAction[30],
			RTResTalkAction[36]
		}
	},
	[36730014] = {
		36730014,
		0,
		Lang.get(98259),
		36730,
		14,
		182,
		{
			RTResTalkAction[32],
			RTResTalkAction[9],
			RTResTalkAction[17]
		}
	},
	[36730015] = {
		36730015,
		0,
		Lang.get(98260),
		36730,
		15,
		225,
		{
			RTResTalkAction[37],
			RTResTalkAction[33]
		},
		nil,
		nil,
		nil,
		1914
	},
	[36730016] = {
		36730016,
		0,
		Lang.get(98261),
		36730,
		16,
		1047,
		{
			RTResTalkAction[38],
			RTResTalkAction[39]
		}
	},
	[36706001] = {
		36706001,
		0,
		Lang.get(98262),
		36706,
		1,
		1214,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		3,
		nil,
		60,
		36726,
		nil,
		1,
		nil,
		nil,
		nil,
		36726
	},
	[36706002] = {
		36706002,
		0,
		Lang.get(98263),
		36706,
		2,
		1047,
		{
			RTResTalkAction[21],
			RTResTalkAction[19]
		}
	},
	[36706003] = {
		36706003,
		0,
		Lang.get(98264),
		36706,
		3,
		1214,
		{
			RTResTalkAction[16],
			RTResTalkAction[9]
		}
	},
	[36706004] = {
		36706004,
		0,
		Lang.get(98265),
		36706,
		4,
		1138,
		{
			RTResTalkAction[17]
		}
	},
	[36707001] = {
		36707001,
		0,
		Lang.get(98266),
		36707,
		1,
		1047,
		nil,
		1,
		1,
		-1,
		nil,
		198,
		36730,
		nil,
		1,
		nil,
		nil,
		nil,
		36730
	},
	[36707002] = {
		36707002,
		0,
		Lang.get(98267),
		36707,
		2,
		1138,
		nil,
		1
	},
	[36707003] = {
		36707003,
		0,
		Lang.get(98268),
		36707,
		3,
		1047,
		nil,
		1
	},
	[36707004] = {
		36707004,
		0,
		Lang.get(98269),
		36707,
		4,
		1027,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		36731,
		nil,
		1,
		nil,
		nil,
		nil,
		36731
	},
	[36707005] = {
		36707005,
		0,
		Lang.get(98270),
		36707,
		5,
		1047,
		nil,
		1,
		1
	},
	[36707006] = {
		36707006,
		0,
		Lang.get(98271),
		36707,
		6,
		1028,
		nil,
		1
	},
	[36707007] = {
		36707007,
		0,
		Lang.get(98272),
		36707,
		7,
		1027,
		nil,
		1
	},
	[36707008] = {
		36707008,
		0,
		Lang.get(98273),
		36707,
		8,
		1214,
		nil,
		1,
		3
	},
	[36707009] = {
		36707009,
		0,
		Lang.get(98274),
		36707,
		9,
		1214,
		nil,
		1,
		4
	},
	[36707010] = {
		36707010,
		3,
		Lang.get(98275),
		36707,
		10,
		605,
		[22] = 1
	},
	[36707011] = {
		36707011,
		0,
		Lang.get(98276),
		36707,
		11,
		1047,
		nil,
		1
	},
	[36707012] = {
		36707012,
		0,
		Lang.get(98277),
		36707,
		12,
		1028,
		nil,
		1
	},
	[36707013] = {
		36707013,
		0,
		Lang.get(98278),
		36707,
		13,
		1214,
		nil,
		1,
		1
	},
	[36707014] = {
		36707014,
		0,
		Lang.get(98279),
		36707,
		14,
		1047,
		nil,
		1
	},
	[36707015] = {
		36707015,
		0,
		Lang.get(98280),
		36707,
		15,
		1214,
		nil,
		1,
		1
	},
	[36707016] = {
		36707016,
		0,
		Lang.get(98281),
		36707,
		16,
		1047,
		nil,
		1,
		1,
		nil,
		nil,
		49,
		36732,
		nil,
		1,
		nil,
		nil,
		nil,
		36732
	},
	[36707017] = {
		36707017,
		0,
		Lang.get(98282),
		36707,
		17,
		1047,
		nil,
		1,
		1
	},
	[36707018] = {
		36707018,
		0,
		Lang.get(98283),
		36707,
		18,
		1210,
		nil,
		1
	},
	[36707019] = {
		36707019,
		0,
		Lang.get(98284),
		36707,
		19,
		1047,
		nil,
		1,
		1
	},
	[36707020] = {
		36707020,
		0,
		Lang.get(98285),
		36707,
		20,
		1210,
		nil,
		1
	},
	[36707021] = {
		36707021,
		0,
		Lang.get(98286),
		36707,
		21,
		1047,
		nil,
		1
	},
	[36707022] = {
		36707022,
		0,
		Lang.get(98287),
		36707,
		22,
		1210,
		nil,
		1
	},
	[36707023] = {
		36707023,
		0,
		Lang.get(98288),
		36707,
		23,
		1210,
		nil,
		1
	},
	[36707024] = {
		36707024,
		0,
		Lang.get(98289),
		36707,
		24,
		1047,
		nil,
		1,
		1
	},
	[36707025] = {
		36707025,
		0,
		Lang.get(98290),
		36707,
		25,
		1210,
		nil,
		1
	},
	[36707026] = {
		36707026,
		0,
		Lang.get(98291),
		36707,
		26,
		1210,
		nil,
		1
	},
	[36707027] = {
		36707027,
		0,
		Lang.get(98292),
		36707,
		27,
		1047,
		nil,
		1,
		1
	},
	[36707028] = {
		36707028,
		0,
		Lang.get(98293),
		36707,
		28,
		150,
		nil,
		1,
		1
	},
	[36707029] = {
		36707029,
		0,
		Lang.get(98294),
		36707,
		29,
		1210,
		nil,
		1
	},
	[36707030] = {
		36707030,
		0,
		Lang.get(98295),
		36707,
		30,
		150,
		nil,
		1,
		2
	},
	[36707031] = {
		36707031,
		0,
		Lang.get(98296),
		36707,
		31,
		1210,
		nil,
		1
	},
	[36707032] = {
		36707032,
		0,
		Lang.get(98297),
		36707,
		32,
		1210,
		nil,
		1
	},
	[36707033] = {
		36707033,
		0,
		Lang.get(98298),
		36707,
		33,
		1047,
		nil,
		1,
		1
	},
	[36707034] = {
		36707034,
		3,
		Lang.get(23446),
		36707,
		34,
		605,
		nil,
		nil,
		nil,
		nil,
		1230,
		[22] = 1
	},
	[36707035] = {
		36707035,
		0,
		Lang.get(98299),
		36707,
		35,
		1214,
		nil,
		1,
		1
	},
	[36708001] = {
		36708001,
		13,
		Lang.get(98300),
		36708,
		1,
		1142,
		{
			RTResTalkAction[40]
		},
		nil,
		nil,
		nil,
		nil,
		50,
		36733,
		nil,
		1,
		nil,
		nil,
		nil,
		36733,
		255,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		3
	},
	[36708002] = {
		36708002,
		13,
		Lang.get(98301),
		36708,
		2,
		1142,
		{
			RTResTalkAction[40]
		},
		[27] = 3,
		[20] = 255
	},
	[36708003] = {
		36708003,
		13,
		Lang.get(98302),
		36708,
		3,
		1142,
		{
			RTResTalkAction[40]
		},
		[27] = 3,
		[20] = 255
	},
	[36708004] = {
		36708004,
		0,
		Lang.get(98303),
		36708,
		4,
		215,
		{
			RTResTalkAction[41]
		},
		1,
		nil,
		nil,
		nil,
		70,
		36734,
		nil,
		1,
		nil,
		1,
		nil,
		36734,
		-1
	},
	[36708005] = {
		36708005,
		0,
		Lang.get(98304),
		36708,
		5,
		1219,
		nil,
		1
	},
	[36708006] = {
		36708006,
		0,
		Lang.get(98305),
		36708,
		6,
		215,
		{
			RTResTalkAction[42]
		},
		nil,
		nil,
		3
	},
	[36708007] = {
		36708007,
		0,
		Lang.get(98306),
		36708,
		7,
		1219,
		{
			RTResTalkAction[43],
			RTResTalkAction[44]
		}
	},
	[36708008] = {
		36708008,
		7,
		"111",
		36708,
		8,
		1219,
		{
			RTResTalkAction[45]
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
	[36708009] = {
		36708009,
		0,
		Lang.get(98307),
		36708,
		9,
		215,
		{
			RTResTalkAction[42]
		}
	},
	[36708010] = {
		36708010,
		0,
		Lang.get(71573),
		36708,
		10,
		1219,
		{
			RTResTalkAction[43],
			RTResTalkAction[44]
		}
	},
	[36708011] = {
		36708011,
		0,
		Lang.get(98308),
		36708,
		11,
		215,
		{
			RTResTalkAction[42],
			RTResTalkAction[45]
		}
	},
	[36708012] = {
		36708012,
		0,
		Lang.get(98309),
		36708,
		12,
		1219,
		{
			RTResTalkAction[46],
			RTResTalkAction[47],
			RTResTalkAction[44]
		}
	},
	[36708013] = {
		36708013,
		0,
		Lang.get(98310),
		36708,
		13,
		215,
		{
			RTResTalkAction[42],
			RTResTalkAction[45],
			RTResTalkAction[48]
		}
	},
	[36708014] = {
		36708014,
		0,
		Lang.get(98311),
		36708,
		14,
		1219,
		{
			RTResTalkAction[43],
			RTResTalkAction[44]
		}
	},
	[36708015] = {
		36708015,
		0,
		Lang.get(98312),
		36708,
		15,
		215,
		{
			RTResTalkAction[42],
			RTResTalkAction[45]
		}
	},
	[36731001] = {
		36731001,
		5,
		Lang.get(98313),
		36731,
		1,
		605,
		nil,
		nil,
		nil,
		-1,
		nil,
		63,
		36735,
		nil,
		1,
		nil,
		1,
		nil,
		36735,
		nil,
		nil,
		1
	},
	[36731002] = {
		36731002,
		0,
		Lang.get(98314),
		36731,
		2,
		1047,
		nil,
		1,
		1
	},
	[36731003] = {
		36731003,
		0,
		Lang.get(98315),
		36731,
		3,
		1214,
		nil,
		1,
		1
	},
	[36731004] = {
		36731004,
		0,
		Lang.get(98316),
		36731,
		4,
		1047,
		{
			RTResTalkAction[22]
		},
		nil,
		nil,
		3
	},
	[36731005] = {
		36731005,
		0,
		Lang.get(98317),
		36731,
		5,
		1214,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[36731006] = {
		36731006,
		0,
		Lang.get(98318),
		36731,
		6,
		1047,
		{
			RTResTalkAction[30],
			RTResTalkAction[35]
		}
	},
	[36731007] = {
		36731007,
		0,
		Lang.get(98319),
		36731,
		7,
		1214,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[36731008] = {
		36731008,
		0,
		Lang.get(98320),
		36731,
		8,
		1214,
		{
			RTResTalkAction[23],
			RTResTalkAction[9]
		}
	},
	[36731009] = {
		36731009,
		0,
		Lang.get(98321),
		36731,
		9,
		1047,
		{
			RTResTalkAction[22],
			RTResTalkAction[17]
		}
	},
	[36731010] = {
		36731010,
		0,
		Lang.get(98322),
		36731,
		10,
		1214,
		{
			RTResTalkAction[23],
			RTResTalkAction[9]
		}
	},
	[36731011] = {
		36731011,
		0,
		Lang.get(98323),
		36731,
		11,
		1214,
		{
			RTResTalkAction[27]
		}
	},
	[36709001] = {
		36709001,
		3,
		Lang.get(98324),
		36709,
		1,
		605,
		nil,
		nil,
		nil,
		-1,
		nil,
		40,
		36740,
		nil,
		1,
		nil,
		1,
		nil,
		36740,
		255,
		nil,
		1
	},
	[36709002] = {
		36709002,
		3,
		Lang.get(98325),
		36709,
		2,
		605,
		[22] = 1,
		[20] = 255
	},
	[36709003] = {
		36709003,
		0,
		Lang.get(98326),
		36709,
		3,
		1047,
		nil,
		1,
		1,
		[20] = 255
	},
	[36709004] = {
		36709004,
		0,
		Lang.get(98327),
		36709,
		4,
		1047,
		nil,
		1,
		1,
		[20] = 255
	},
	[36709005] = {
		36709005,
		0,
		Lang.get(98328),
		36709,
		5,
		1215,
		nil,
		1,
		[20] = -1
	},
	[36709006] = {
		36709006,
		0,
		Lang.get(98329),
		36709,
		6,
		1047,
		{
			RTResTalkAction[15]
		},
		nil,
		nil,
		nil,
		2489,
		[20] = 3
	},
	[36710001] = {
		36710001,
		0,
		Lang.get(98330),
		36710,
		1,
		1214,
		nil,
		1,
		1,
		nil,
		nil,
		60,
		36741,
		nil,
		1,
		nil,
		1,
		nil,
		36741
	},
	[36710002] = {
		36710002,
		0,
		Lang.get(98331),
		36710,
		2,
		1047,
		nil,
		1,
		1
	},
	[36710003] = {
		36710003,
		0,
		Lang.get(98332),
		36710,
		3,
		1214,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[36710004] = {
		36710004,
		0,
		Lang.get(98333),
		36710,
		4,
		1047,
		{
			RTResTalkAction[8],
			RTResTalkAction[17]
		}
	},
	[36710005] = {
		36710005,
		0,
		Lang.get(98334),
		36710,
		5,
		1214,
		{
			RTResTalkAction[27],
			RTResTalkAction[9]
		},
		nil,
		nil,
		nil,
		2489
	},
	[36710006] = {
		36710006,
		0,
		Lang.get(98335),
		36710,
		6,
		1047,
		{
			RTResTalkAction[25],
			RTResTalkAction[19]
		}
	},
	[36710007] = {
		36710007,
		0,
		Lang.get(98336),
		36710,
		7,
		1214,
		{
			RTResTalkAction[25],
			RTResTalkAction[19]
		}
	},
	[36710008] = {
		36710008,
		0,
		Lang.get(98337),
		36710,
		8,
		1047,
		{
			RTResTalkAction[25],
			RTResTalkAction[19]
		}
	},
	[36710009] = {
		36710009,
		0,
		Lang.get(98338),
		36710,
		9,
		1214,
		{
			RTResTalkAction[49],
			RTResTalkAction[9]
		}
	},
	[36710010] = {
		36710010,
		3,
		Lang.get(98339),
		36710,
		10,
		605,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		-1,
		nil,
		63,
		36742,
		nil,
		1,
		nil,
		1,
		nil,
		36742,
		255,
		nil,
		1
	},
	[36710011] = {
		36710011,
		5,
		Lang.get(98340),
		36710,
		11,
		605,
		[22] = 1,
		[20] = 255
	},
	[36710012] = {
		36710012,
		0,
		Lang.get(98341),
		36710,
		12,
		1214,
		nil,
		1,
		3,
		[20] = -1
	},
	[36710013] = {
		36710013,
		0,
		Lang.get(98342),
		36710,
		13,
		1047,
		nil,
		1
	},
	[36710014] = {
		36710014,
		0,
		Lang.get(98343),
		36710,
		14,
		1214,
		{
			RTResTalkAction[27]
		},
		nil,
		nil,
		3
	},
	[36710015] = {
		36710015,
		0,
		Lang.get(98344),
		36710,
		15,
		1179,
		{
			RTResTalkAction[50],
			RTResTalkAction[17]
		}
	},
	[36710016] = {
		36710016,
		0,
		Lang.get(98345),
		36710,
		16,
		1047,
		{
			RTResTalkAction[15],
			RTResTalkAction[51]
		}
	},
	[36710017] = {
		36710017,
		0,
		Lang.get(98346),
		36710,
		17,
		1214,
		{
			RTResTalkAction[9]
		},
		1,
		3,
		-1,
		nil,
		50,
		36743,
		nil,
		1,
		nil,
		1,
		nil,
		36743
	},
	[36710018] = {
		36710018,
		0,
		Lang.get(98347),
		36710,
		18,
		1047,
		nil,
		1,
		1
	},
	[36710019] = {
		36710019,
		0,
		Lang.get(98348),
		36710,
		19,
		1214,
		{
			RTResTalkAction[27]
		},
		nil,
		nil,
		3
	},
	[36710020] = {
		36710020,
		0,
		Lang.get(98349),
		36710,
		20,
		1047,
		{
			RTResTalkAction[22],
			RTResTalkAction[17]
		}
	},
	[36710021] = {
		36710021,
		0,
		Lang.get(98350),
		36710,
		21,
		1214,
		{
			RTResTalkAction[23],
			RTResTalkAction[9]
		}
	},
	[36710022] = {
		36710022,
		0,
		Lang.get(98351),
		36710,
		22,
		1214,
		{
			RTResTalkAction[23]
		}
	},
	[36710023] = {
		36710023,
		5,
		Lang.get(98352),
		36710,
		23,
		605,
		{
			RTResTalkAction[17]
		},
		[22] = 1
	},
	[36710024] = {
		36710024,
		5,
		Lang.get(98353),
		36710,
		24,
		1047,
		{
			RTResTalkAction[52]
		}
	},
	[36711001] = {
		36711001,
		0,
		Lang.get(98354),
		36711,
		1,
		1214,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		-1,
		nil,
		40,
		36745,
		nil,
		1,
		nil,
		nil,
		nil,
		36745,
		255
	},
	[36711002] = {
		36711002,
		0,
		Lang.get(98355),
		36711,
		2,
		1047,
		{
			RTResTalkAction[8],
			RTResTalkAction[17]
		},
		[20] = 255
	},
	[36711003] = {
		36711003,
		0,
		Lang.get(98356),
		36711,
		3,
		1214,
		{
			RTResTalkAction[23],
			RTResTalkAction[9]
		},
		[20] = 255
	},
	[36711004] = {
		36711004,
		0,
		Lang.get(98357),
		36711,
		4,
		1047,
		{
			RTResTalkAction[8],
			RTResTalkAction[17]
		},
		[20] = 255
	},
	[36711005] = {
		36711005,
		0,
		Lang.get(98358),
		36711,
		5,
		1214,
		{
			RTResTalkAction[23],
			RTResTalkAction[9]
		},
		[20] = 255
	},
	[36711006] = {
		36711006,
		0,
		Lang.get(98359),
		36711,
		6,
		1047,
		{
			RTResTalkAction[8],
			RTResTalkAction[17]
		},
		[20] = 255
	},
	[36711007] = {
		36711007,
		0,
		Lang.get(98360),
		36711,
		7,
		1214,
		{
			RTResTalkAction[49],
			RTResTalkAction[9]
		},
		[20] = 255
	},
	[36711008] = {
		36711008,
		0,
		Lang.get(98361),
		36711,
		8,
		1047,
		{
			RTResTalkAction[8],
			RTResTalkAction[17]
		},
		[20] = 255
	},
	[36711009] = {
		36711009,
		0,
		Lang.get(98362),
		36711,
		9,
		1214,
		{
			RTResTalkAction[23],
			RTResTalkAction[9]
		},
		[20] = 255
	},
	[36711010] = {
		36711010,
		0,
		Lang.get(98363),
		36711,
		10,
		1047,
		{
			RTResTalkAction[8],
			RTResTalkAction[17]
		},
		[20] = 255
	},
	[36711011] = {
		36711011,
		0,
		Lang.get(98364),
		36711,
		11,
		1214,
		{
			RTResTalkAction[23],
			RTResTalkAction[9]
		},
		[20] = 255
	},
	[36711012] = {
		36711012,
		0,
		Lang.get(98365),
		36711,
		12,
		1047,
		{
			RTResTalkAction[8],
			RTResTalkAction[17]
		},
		[20] = 255
	},
	[36711013] = {
		36711013,
		0,
		Lang.get(98366),
		36711,
		13,
		1214,
		{
			RTResTalkAction[53],
			RTResTalkAction[9]
		},
		[20] = 255
	},
	[36711014] = {
		36711014,
		3,
		Lang.get(98367),
		36711,
		14,
		605,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		nil,
		nil,
		71,
		[22] = 1,
		[20] = -1
	},
	[36711015] = {
		36711015,
		0,
		Lang.get(98368),
		36711,
		15,
		1214,
		{
			RTResTalkAction[54]
		}
	},
	[36711016] = {
		36711016,
		0,
		Lang.get(98369),
		36711,
		16,
		1217,
		{
			RTResTalkAction[55]
		},
		1,
		nil,
		nil,
		nil,
		40,
		36750,
		nil,
		1,
		nil,
		1,
		nil,
		36750
	},
	[36711017] = {
		36711017,
		0,
		Lang.get(98370),
		36711,
		17,
		1047,
		nil,
		1,
		1
	},
	[36711018] = {
		36711018,
		0,
		Lang.get(98371),
		36711,
		18,
		1217,
		{
			RTResTalkAction[54]
		},
		nil,
		nil,
		3
	},
	[36711019] = {
		36711019,
		0,
		Lang.get(98372),
		36711,
		19,
		1214,
		{
			RTResTalkAction[16],
			RTResTalkAction[55]
		}
	},
	[36711020] = {
		36711020,
		0,
		Lang.get(98373),
		36711,
		20,
		1217,
		{
			RTResTalkAction[54],
			RTResTalkAction[17]
		}
	},
	[36711021] = {
		36711021,
		0,
		Lang.get(98374),
		36711,
		21,
		1047,
		{
			RTResTalkAction[56],
			RTResTalkAction[55]
		}
	},
	[36711022] = {
		36711022,
		0,
		Lang.get(98375),
		36711,
		22,
		1217,
		{
			RTResTalkAction[54],
			RTResTalkAction[9]
		}
	},
	[36711023] = {
		36711023,
		0,
		Lang.get(98376),
		36711,
		23,
		1214,
		{
			RTResTalkAction[49],
			RTResTalkAction[55]
		}
	},
	[36711024] = {
		36711024,
		0,
		Lang.get(98377),
		36711,
		24,
		1217,
		{
			RTResTalkAction[54],
			RTResTalkAction[17]
		}
	},
	[36711025] = {
		36711025,
		0,
		Lang.get(98378),
		36711,
		25,
		1214,
		{
			RTResTalkAction[49],
			RTResTalkAction[55]
		}
	},
	[36711026] = {
		36711026,
		0,
		Lang.get(98379),
		36711,
		26,
		1217,
		{
			RTResTalkAction[54],
			RTResTalkAction[17]
		}
	},
	[36711027] = {
		36711027,
		0,
		Lang.get(98380),
		36711,
		27,
		1217,
		{
			RTResTalkAction[57],
			RTResTalkAction[55]
		},
		1
	},
	[36711028] = {
		36711028,
		0,
		Lang.get(98381),
		36711,
		28,
		1217,
		{
			RTResTalkAction[54],
			RTResTalkAction[58]
		}
	},
	[36711029] = {
		36711029,
		0,
		Lang.get(98382),
		36711,
		29,
		1217,
		{
			RTResTalkAction[54]
		}
	},
	[36711030] = {
		36711030,
		0,
		Lang.get(98383),
		36711,
		30,
		1047,
		{
			RTResTalkAction[56],
			RTResTalkAction[55]
		}
	},
	[36711031] = {
		36711031,
		0,
		Lang.get(98384),
		36711,
		31,
		1217,
		{
			RTResTalkAction[54],
			RTResTalkAction[9]
		}
	},
	[36712001] = {
		36712001,
		0,
		Lang.get(98385),
		36712,
		1,
		1047,
		nil,
		1,
		1,
		-1,
		nil,
		50,
		36755,
		nil,
		1,
		nil,
		1,
		nil,
		36755
	},
	[36712002] = {
		36712002,
		0,
		Lang.get(98386),
		36712,
		2,
		1214,
		nil,
		1,
		3
	},
	[36712003] = {
		36712003,
		0,
		Lang.get(98387),
		36712,
		3,
		1047,
		{
			RTResTalkAction[56]
		},
		nil,
		nil,
		3
	},
	[36712004] = {
		36712004,
		0,
		Lang.get(98388),
		36712,
		4,
		1214,
		{
			RTResTalkAction[16],
			RTResTalkAction[9]
		}
	},
	[36712005] = {
		36712005,
		0,
		Lang.get(98389),
		36712,
		5,
		1047,
		{
			RTResTalkAction[59],
			RTResTalkAction[17]
		}
	},
	[36712006] = {
		36712006,
		0,
		Lang.get(98390),
		36712,
		6,
		1214,
		{
			RTResTalkAction[16],
			RTResTalkAction[9]
		}
	},
	[36712007] = {
		36712007,
		0,
		Lang.get(98391),
		36712,
		7,
		1047,
		{
			RTResTalkAction[59],
			RTResTalkAction[17]
		}
	},
	[36712008] = {
		36712008,
		0,
		Lang.get(98392),
		36712,
		8,
		1214,
		{
			RTResTalkAction[49],
			RTResTalkAction[9]
		}
	},
	[36712009] = {
		36712009,
		0,
		Lang.get(98393),
		36712,
		9,
		1047,
		{
			RTResTalkAction[8],
			RTResTalkAction[17]
		}
	},
	[36712010] = {
		36712010,
		0,
		Lang.get(98394),
		36712,
		10,
		1214,
		{
			RTResTalkAction[49],
			RTResTalkAction[9]
		}
	},
	[36712011] = {
		36712011,
		0,
		Lang.get(98395),
		36712,
		11,
		1047,
		{
			RTResTalkAction[8],
			RTResTalkAction[17]
		}
	},
	[36712012] = {
		36712012,
		0,
		Lang.get(98396),
		36712,
		12,
		1214,
		{
			RTResTalkAction[49],
			RTResTalkAction[9]
		}
	},
	[36712013] = {
		36712013,
		0,
		Lang.get(98397),
		36712,
		13,
		1214,
		{
			RTResTalkAction[49]
		}
	},
	[36712014] = {
		36712014,
		0,
		Lang.get(98398),
		36712,
		14,
		1214,
		{
			RTResTalkAction[16]
		}
	},
	[36712015] = {
		36712015,
		0,
		Lang.get(98399),
		36712,
		15,
		1047,
		{
			RTResTalkAction[59],
			RTResTalkAction[17]
		}
	},
	[36712016] = {
		36712016,
		0,
		Lang.get(98400),
		36712,
		16,
		1217,
		{
			RTResTalkAction[9]
		},
		1,
		nil,
		-1,
		nil,
		57,
		36760,
		nil,
		1,
		nil,
		1,
		nil,
		36760
	},
	[36712017] = {
		36712017,
		0,
		Lang.get(98401),
		36712,
		17,
		1217,
		nil,
		1
	},
	[36712018] = {
		36712018,
		0,
		Lang.get(98402),
		36712,
		18,
		1047,
		{
			RTResTalkAction[60]
		},
		nil,
		nil,
		3
	},
	[36712019] = {
		36712019,
		0,
		Lang.get(98403),
		36712,
		19,
		1214,
		{
			RTResTalkAction[61],
			RTResTalkAction[9]
		}
	},
	[36712020] = {
		36712020,
		0,
		Lang.get(98404),
		36712,
		20,
		1217,
		{
			RTResTalkAction[54],
			RTResTalkAction[17]
		}
	},
	[36712021] = {
		36712021,
		3,
		Lang.get(98405),
		36712,
		21,
		1233,
		{
			RTResTalkAction[55]
		},
		1,
		[22] = 1
	},
	[36712022] = {
		36712022,
		5,
		Lang.get(98177),
		36712,
		22,
		605,
		nil,
		nil,
		nil,
		nil,
		1232,
		[22] = 1
	},
	[36712023] = {
		36712023,
		0,
		Lang.get(98406),
		36712,
		23,
		1217,
		{
			RTResTalkAction[54]
		}
	},
	[36713001] = {
		36713001,
		0,
		Lang.get(98407),
		36713,
		1,
		1219,
		nil,
		1,
		nil,
		-1,
		nil,
		nil,
		36765,
		nil,
		1,
		nil,
		nil,
		nil,
		36765
	},
	[36713002] = {
		36713002,
		0,
		Lang.get(98408),
		36713,
		2,
		1216,
		nil,
		1,
		nil,
		nil,
		nil,
		60
	},
	[36713003] = {
		36713003,
		7,
		"110",
		36713,
		3,
		1216,
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
	[36713004] = {
		36713004,
		0,
		Lang.get(98409),
		36713,
		4,
		1047,
		{
			RTResTalkAction[15]
		}
	},
	[36714001] = {
		36714001,
		0,
		Lang.get(98410),
		36714,
		1,
		1047,
		nil,
		1,
		1,
		-1,
		nil,
		60,
		36770,
		nil,
		1,
		nil,
		nil,
		nil,
		36770
	},
	[36714002] = {
		36714002,
		0,
		Lang.get(98411),
		36714,
		2,
		1047,
		nil,
		1,
		1
	},
	[36714003] = {
		36714003,
		0,
		Lang.get(98412),
		36714,
		3,
		1216,
		{
			RTResTalkAction[62]
		},
		nil,
		nil,
		3
	},
	[36714004] = {
		36714004,
		0,
		Lang.get(98413),
		36714,
		4,
		1047,
		{
			RTResTalkAction[8],
			RTResTalkAction[63]
		}
	},
	[36714005] = {
		36714005,
		0,
		Lang.get(98414),
		36714,
		5,
		1027,
		{
			RTResTalkAction[57],
			RTResTalkAction[9]
		}
	},
	[36714006] = {
		36714006,
		0,
		Lang.get(98415),
		36714,
		6,
		1214,
		{
			RTResTalkAction[23],
			RTResTalkAction[58]
		}
	},
	[36714007] = {
		36714007,
		0,
		Lang.get(98416),
		36714,
		7,
		1216,
		{
			RTResTalkAction[62],
			RTResTalkAction[17]
		}
	},
	[36714008] = {
		36714008,
		0,
		Lang.get(98417),
		36714,
		8,
		1214,
		{
			RTResTalkAction[27],
			RTResTalkAction[63]
		}
	},
	[36714009] = {
		36714009,
		0,
		Lang.get(98418),
		36714,
		9,
		1027,
		{
			RTResTalkAction[64],
			RTResTalkAction[17]
		}
	},
	[36714010] = {
		36714010,
		0,
		Lang.get(98419),
		36714,
		10,
		1216,
		{
			RTResTalkAction[62],
			RTResTalkAction[58]
		}
	},
	[36714011] = {
		36714011,
		0,
		Lang.get(98420),
		36714,
		11,
		1047,
		{
			RTResTalkAction[8],
			RTResTalkAction[63]
		}
	},
	[36714012] = {
		36714012,
		0,
		Lang.get(98421),
		36714,
		12,
		1214,
		{
			RTResTalkAction[23],
			RTResTalkAction[9]
		}
	},
	[36714013] = {
		36714013,
		0,
		Lang.get(98422),
		36714,
		13,
		1214,
		{
			RTResTalkAction[27]
		}
	},
	[36714014] = {
		36714014,
		0,
		Lang.get(98423),
		36714,
		14,
		1047,
		{
			RTResTalkAction[25],
			RTResTalkAction[19]
		}
	},
	[36714015] = {
		36714015,
		0,
		Lang.get(98424),
		36714,
		15,
		1219,
		{
			RTResTalkAction[43],
			RTResTalkAction[17],
			RTResTalkAction[9]
		}
	},
	[36714016] = {
		36714016,
		0,
		Lang.get(98425),
		36714,
		16,
		1216,
		{
			RTResTalkAction[62],
			RTResTalkAction[45]
		}
	},
	[36714017] = {
		36714017,
		0,
		Lang.get(98426),
		36714,
		17,
		1027,
		{
			RTResTalkAction[65],
			RTResTalkAction[63]
		}
	},
	[36714018] = {
		36714018,
		0,
		Lang.get(98427),
		36714,
		18,
		1219,
		{
			RTResTalkAction[43],
			RTResTalkAction[58]
		}
	},
	[36714019] = {
		36714019,
		0,
		Lang.get(98428),
		36714,
		19,
		1214,
		{
			RTResTalkAction[24],
			RTResTalkAction[45]
		}
	},
	[36714020] = {
		36714020,
		0,
		Lang.get(98429),
		36714,
		20,
		1047,
		{
			RTResTalkAction[22],
			RTResTalkAction[17]
		}
	},
	[36714021] = {
		36714021,
		0,
		Lang.get(98430),
		36714,
		21,
		1027,
		{
			RTResTalkAction[65],
			RTResTalkAction[9]
		}
	},
	[36714022] = {
		36714022,
		0,
		Lang.get(98431),
		36714,
		22,
		1216,
		{
			RTResTalkAction[58]
		},
		1,
		nil,
		-1,
		nil,
		nil,
		36771,
		nil,
		1,
		nil,
		nil,
		nil,
		36771
	},
	[36714023] = {
		36714023,
		5,
		Lang.get(98432),
		36714,
		23,
		1219,
		nil,
		1,
		nil,
		nil,
		nil,
		50,
		36772,
		nil,
		nil,
		nil,
		nil,
		nil,
		36772
	},
	[36714024] = {
		36714024,
		0,
		Lang.get(98433),
		36714,
		24,
		1047,
		{
			RTResTalkAction[15]
		},
		nil,
		nil,
		3
	},
	[36714025] = {
		36714025,
		3,
		Lang.get(98434),
		36714,
		25,
		605,
		{
			RTResTalkAction[66],
			RTResTalkAction[9]
		},
		nil,
		nil,
		nil,
		1217,
		[22] = 1
	},
	[36714026] = {
		36714026,
		0,
		Lang.get(98435),
		36714,
		26,
		1047,
		{
			RTResTalkAction[8],
			RTResTalkAction[67]
		}
	},
	[36714027] = {
		36714027,
		5,
		Lang.get(98436),
		36714,
		27,
		1214,
		{
			RTResTalkAction[68],
			RTResTalkAction[9]
		}
	},
	[36715001] = {
		36715001,
		3,
		Lang.get(98434),
		36715,
		1,
		605,
		{
			RTResTalkAction[66]
		},
		nil,
		nil,
		255,
		1217,
		193,
		36780,
		nil,
		1,
		nil,
		nil,
		nil,
		36780,
		nil,
		nil,
		1
	},
	[36715002] = {
		36715002,
		0,
		Lang.get(98437),
		36715,
		2,
		1219,
		{
			RTResTalkAction[67]
		},
		1,
		nil,
		-1
	},
	[36715003] = {
		36715003,
		0,
		Lang.get(98438),
		36715,
		3,
		1047,
		nil,
		1,
		2
	},
	[36715004] = {
		36715004,
		0,
		Lang.get(98439),
		36715,
		4,
		1027,
		{
			RTResTalkAction[65]
		}
	},
	[36715005] = {
		36715005,
		0,
		Lang.get(98440),
		36715,
		5,
		1216,
		{
			RTResTalkAction[62],
			RTResTalkAction[58]
		}
	},
	[36715006] = {
		36715006,
		0,
		Lang.get(98441),
		36715,
		6,
		1214,
		{
			RTResTalkAction[16],
			RTResTalkAction[63]
		}
	},
	[36715007] = {
		36715007,
		0,
		Lang.get(98442),
		36715,
		7,
		1219,
		{
			RTResTalkAction[43],
			RTResTalkAction[17]
		}
	},
	[36715008] = {
		36715008,
		0,
		Lang.get(22381),
		36715,
		8,
		1047,
		{
			RTResTalkAction[8],
			RTResTalkAction[45]
		}
	},
	[36715009] = {
		36715009,
		3,
		Lang.get(98443),
		36715,
		9,
		1233,
		{
			RTResTalkAction[9]
		},
		1,
		[22] = 1
	},
	[36715010] = {
		36715010,
		0,
		Lang.get(98444),
		36715,
		10,
		1219,
		{
			RTResTalkAction[43]
		}
	},
	[36715011] = {
		36715011,
		0,
		Lang.get(98445),
		36715,
		11,
		1047,
		{
			RTResTalkAction[8],
			RTResTalkAction[45]
		}
	},
	[36715012] = {
		36715012,
		0,
		Lang.get(98446),
		36715,
		12,
		1214,
		{
			RTResTalkAction[16],
			RTResTalkAction[9]
		}
	},
	[36715013] = {
		36715013,
		0,
		Lang.get(98447),
		36715,
		13,
		1214,
		{
			RTResTalkAction[16]
		}
	},
	[36715014] = {
		36715014,
		0,
		Lang.get(98448),
		36715,
		14,
		1219,
		{
			RTResTalkAction[43],
			RTResTalkAction[17]
		}
	},
	[36715015] = {
		36715015,
		5,
		Lang.get(98449),
		36715,
		15,
		1047,
		{
			RTResTalkAction[56],
			RTResTalkAction[45]
		}
	},
	[36715016] = {
		36715016,
		0,
		Lang.get(98450),
		36715,
		16,
		1214,
		{
			RTResTalkAction[9]
		},
		1,
		3,
		-1,
		nil,
		176,
		36785,
		nil,
		1,
		nil,
		nil,
		nil,
		36785
	},
	[36715017] = {
		36715017,
		5,
		Lang.get(98451),
		36715,
		17,
		1219,
		nil,
		1
	},
	[36715018] = {
		36715018,
		0,
		Lang.get(98452),
		36715,
		18,
		1214,
		{
			RTResTalkAction[49]
		},
		nil,
		nil,
		3
	},
	[36715019] = {
		36715019,
		0,
		Lang.get(98453),
		36715,
		19,
		1047,
		{
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[36715020] = {
		36715020,
		5,
		Lang.get(98454),
		36715,
		20,
		1214,
		{
			RTResTalkAction[24],
			RTResTalkAction[9]
		}
	},
	[36715021] = {
		36715021,
		0,
		Lang.get(98455),
		36715,
		21,
		1214,
		{
			RTResTalkAction[23]
		}
	},
	[36715022] = {
		36715022,
		0,
		Lang.get(98456),
		36715,
		22,
		1214,
		{
			RTResTalkAction[69]
		}
	},
	[36715023] = {
		36715023,
		5,
		Lang.get(98457),
		36715,
		23,
		1047,
		{
			RTResTalkAction[56],
			RTResTalkAction[17]
		}
	},
	[36715024] = {
		36715024,
		0,
		Lang.get(98458),
		36715,
		24,
		1214,
		{
			RTResTalkAction[27],
			RTResTalkAction[9]
		}
	},
	[36715025] = {
		36715025,
		0,
		"…………",
		36715,
		25,
		1047,
		{
			RTResTalkAction[25],
			RTResTalkAction[70]
		}
	},
	[36715026] = {
		36715026,
		0,
		Lang.get(98459),
		36715,
		26,
		1214,
		{
			RTResTalkAction[27],
			RTResTalkAction[9]
		}
	},
	[36715027] = {
		36715027,
		0,
		"…………",
		36715,
		27,
		1047,
		{
			RTResTalkAction[25],
			RTResTalkAction[70]
		}
	},
	[36715028] = {
		36715028,
		0,
		Lang.get(98460),
		36715,
		28,
		1214,
		{
			RTResTalkAction[24],
			RTResTalkAction[9]
		}
	},
	[36715029] = {
		36715029,
		0,
		Lang.get(98461),
		36715,
		29,
		1047,
		{
			RTResTalkAction[56],
			RTResTalkAction[17]
		},
		nil,
		nil,
		nil,
		nil,
		50
	},
	[36715030] = {
		36715030,
		3,
		Lang.get(96988),
		36715,
		30,
		605,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		nil,
		nil,
		194,
		[22] = 1,
		[20] = 255
	},
	[36715031] = {
		36715031,
		0,
		Lang.get(98462),
		36715,
		31,
		1214,
		{
			RTResTalkAction[69]
		},
		nil,
		nil,
		nil,
		nil,
		201,
		[20] = -1
	},
	[36715032] = {
		36715032,
		0,
		Lang.get(98463),
		36715,
		32,
		1216,
		{
			RTResTalkAction[62],
			RTResTalkAction[17]
		}
	},
	[36715033] = {
		36715033,
		0,
		Lang.get(98464),
		36715,
		33,
		1219,
		{
			RTResTalkAction[43],
			RTResTalkAction[63]
		}
	},
	[36715034] = {
		36715034,
		0,
		Lang.get(98465),
		36715,
		34,
		1047,
		{
			RTResTalkAction[22],
			RTResTalkAction[45]
		}
	},
	[36715035] = {
		36715035,
		0,
		Lang.get(98466),
		36715,
		35,
		1214,
		{
			RTResTalkAction[27],
			RTResTalkAction[9]
		},
		nil,
		nil,
		nil,
		2695
	},
	[36716001] = {
		36716001,
		0,
		Lang.get(98467),
		36716,
		1,
		1047,
		nil,
		1,
		nil,
		-1,
		nil,
		176,
		36790,
		nil,
		1,
		nil,
		1,
		nil,
		36790
	},
	[36716002] = {
		36716002,
		0,
		Lang.get(98468),
		36716,
		2,
		1214,
		nil,
		1,
		4
	},
	[36716003] = {
		36716003,
		5,
		Lang.get(98469),
		36716,
		3,
		592,
		nil,
		1
	},
	[36716004] = {
		36716004,
		0,
		Lang.get(98470),
		36716,
		4,
		1060,
		nil,
		1
	},
	[36716005] = {
		36716005,
		0,
		Lang.get(98471),
		36716,
		5,
		1216,
		{
			RTResTalkAction[62]
		},
		nil,
		nil,
		3
	},
	[36716006] = {
		36716006,
		0,
		Lang.get(98472),
		36716,
		6,
		1214,
		{
			RTResTalkAction[24],
			RTResTalkAction[63]
		}
	},
	[36716007] = {
		36716007,
		0,
		Lang.get(98473),
		36716,
		7,
		1219,
		{
			RTResTalkAction[71],
			RTResTalkAction[17]
		}
	},
	[36716008] = {
		36716008,
		3,
		Lang.get(98474),
		36716,
		8,
		605,
		{
			RTResTalkAction[45]
		},
		[22] = 1
	},
	[36716009] = {
		36716009,
		0,
		Lang.get(98475),
		36716,
		9,
		215,
		nil,
		1,
		1,
		-1,
		nil,
		nil,
		36791,
		nil,
		1,
		nil,
		nil,
		nil,
		36791
	},
	[36716010] = {
		36716010,
		0,
		Lang.get(98476),
		36716,
		10,
		1219,
		nil,
		1
	},
	[36716011] = {
		36716011,
		0,
		Lang.get(98477),
		36716,
		11,
		215,
		nil,
		1,
		1
	},
	[36716012] = {
		36716012,
		0,
		Lang.get(98478),
		36716,
		12,
		1219,
		{
			RTResTalkAction[43]
		},
		nil,
		nil,
		3
	},
	[36716013] = {
		36716013,
		0,
		Lang.get(98479),
		36716,
		13,
		1219,
		{
			RTResTalkAction[43]
		}
	},
	[36716014] = {
		36716014,
		0,
		Lang.get(98480),
		36716,
		14,
		215,
		{
			RTResTalkAction[72],
			RTResTalkAction[45]
		}
	},
	[36716015] = {
		36716015,
		0,
		Lang.get(98481),
		36716,
		15,
		1219,
		{
			RTResTalkAction[43],
			RTResTalkAction[44]
		}
	},
	[36716016] = {
		36716016,
		0,
		Lang.get(98482),
		36716,
		16,
		1047,
		{
			RTResTalkAction[22],
			RTResTalkAction[45]
		}
	},
	[36716017] = {
		36716017,
		0,
		Lang.get(98483),
		36716,
		17,
		1216,
		{
			RTResTalkAction[62],
			RTResTalkAction[9]
		}
	},
	[36716018] = {
		36716018,
		0,
		Lang.get(98484),
		36716,
		18,
		1214,
		{
			RTResTalkAction[63]
		},
		1,
		2,
		-1,
		nil,
		70,
		36792,
		nil,
		1,
		nil,
		nil,
		nil,
		36792
	},
	[36716019] = {
		36716019,
		0,
		Lang.get(98485),
		36716,
		19,
		1219,
		nil,
		1
	},
	[36716020] = {
		36716020,
		0,
		Lang.get(98486),
		36716,
		20,
		1214,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[36716021] = {
		36716021,
		0,
		Lang.get(98487),
		36716,
		21,
		1219,
		{
			RTResTalkAction[26],
			RTResTalkAction[73]
		}
	},
	[36716022] = {
		36716022,
		0,
		Lang.get(98488),
		36716,
		22,
		1219,
		{
			RTResTalkAction[26],
			RTResTalkAction[73]
		}
	},
	[36716023] = {
		36716023,
		3,
		Lang.get(98489),
		36716,
		23,
		605,
		{
			RTResTalkAction[17],
			RTResTalkAction[45]
		},
		[22] = 1
	},
	[36716024] = {
		36716024,
		0,
		Lang.get(98490),
		36716,
		24,
		1214,
		{
			RTResTalkAction[23]
		}
	},
	[36716025] = {
		36716025,
		0,
		Lang.get(98491),
		36716,
		25,
		1219,
		{
			RTResTalkAction[43],
			RTResTalkAction[17]
		}
	},
	[36716026] = {
		36716026,
		0,
		Lang.get(98492),
		36716,
		26,
		1047,
		{
			RTResTalkAction[45]
		},
		1,
		1,
		-1,
		nil,
		nil,
		36793,
		nil,
		1,
		nil,
		nil,
		nil,
		36793
	},
	[36716027] = {
		36716027,
		0,
		Lang.get(98493),
		36716,
		27,
		1214,
		nil,
		1,
		4
	},
	[36717001] = {
		36717001,
		0,
		Lang.get(98494),
		36717,
		1,
		1047,
		nil,
		1,
		nil,
		-1,
		nil,
		50,
		36795,
		nil,
		1,
		nil,
		1,
		nil,
		36795
	},
	[36717002] = {
		36717002,
		0,
		Lang.get(98495),
		36717,
		2,
		1226,
		{
			RTResTalkAction[74]
		},
		nil,
		nil,
		3
	},
	[36717003] = {
		36717003,
		0,
		Lang.get(98496),
		36717,
		3,
		1227,
		{
			RTResTalkAction[75],
			RTResTalkAction[76]
		}
	},
	[36717004] = {
		36717004,
		0,
		Lang.get(98497),
		36717,
		4,
		237,
		{
			RTResTalkAction[77],
			RTResTalkAction[78]
		}
	},
	[36717005] = {
		36717005,
		0,
		Lang.get(98498),
		36717,
		5,
		1047,
		{
			RTResTalkAction[52],
			RTResTalkAction[79]
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
	[36718001] = {
		36718001,
		0,
		Lang.get(98499),
		36718,
		1,
		1228,
		nil,
		1,
		nil,
		-1,
		nil,
		50,
		36797,
		nil,
		1,
		nil,
		nil,
		nil,
		36797
	},
	[36718002] = {
		36718002,
		0,
		Lang.get(98500),
		36718,
		2,
		1047,
		nil,
		1
	},
	[36718003] = {
		36718003,
		0,
		Lang.get(98501),
		36718,
		3,
		1228,
		{
			RTResTalkAction[80]
		},
		nil,
		nil,
		3
	},
	[36718004] = {
		36718004,
		0,
		Lang.get(98502),
		36718,
		4,
		1047,
		{
			RTResTalkAction[22],
			RTResTalkAction[81]
		}
	},
	[36718005] = {
		36718005,
		0,
		"……",
		36718,
		5,
		1214,
		{
			RTResTalkAction[23],
			RTResTalkAction[9]
		}
	},
	[36718006] = {
		36718006,
		0,
		Lang.get(98503),
		36718,
		6,
		1047,
		{
			RTResTalkAction[21],
			RTResTalkAction[19]
		}
	},
	[36718007] = {
		36718007,
		0,
		Lang.get(98504),
		36718,
		7,
		1214,
		{
			RTResTalkAction[21],
			RTResTalkAction[19]
		}
	},
	[36718008] = {
		36718008,
		0,
		Lang.get(98505),
		36718,
		8,
		1047,
		{
			RTResTalkAction[21],
			RTResTalkAction[19]
		}
	},
	[36718009] = {
		36718009,
		0,
		Lang.get(98506),
		36718,
		9,
		1214,
		{
			RTResTalkAction[21],
			RTResTalkAction[19]
		}
	},
	[36718010] = {
		36718010,
		0,
		Lang.get(98507),
		36718,
		10,
		1047,
		{
			RTResTalkAction[21],
			RTResTalkAction[19]
		}
	},
	[36718011] = {
		36718011,
		0,
		Lang.get(98508),
		36718,
		11,
		1214,
		{
			RTResTalkAction[82],
			RTResTalkAction[19]
		}
	},
	[36718012] = {
		36718012,
		0,
		Lang.get(98509),
		36718,
		12,
		1228,
		{
			RTResTalkAction[80],
			RTResTalkAction[17],
			RTResTalkAction[9]
		}
	},
	[36718013] = {
		36718013,
		0,
		Lang.get(98510),
		36718,
		13,
		1047,
		{
			RTResTalkAction[83],
			RTResTalkAction[84],
			RTResTalkAction[81]
		}
	},
	[36718014] = {
		36718014,
		0,
		Lang.get(98511),
		36718,
		14,
		1214,
		{
			RTResTalkAction[82],
			RTResTalkAction[19],
			RTResTalkAction[78],
			RTResTalkAction[76]
		}
	},
	[36718015] = {
		36718015,
		0,
		Lang.get(98512),
		36718,
		15,
		1228,
		{
			RTResTalkAction[85],
			RTResTalkAction[17],
			RTResTalkAction[9]
		}
	},
	[36718016] = {
		36718016,
		0,
		Lang.get(98513),
		36718,
		16,
		1047,
		{
			RTResTalkAction[8],
			RTResTalkAction[81]
		}
	},
	[36718017] = {
		36718017,
		0,
		Lang.get(98514),
		36718,
		17,
		1214,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[36718018] = {
		36718018,
		0,
		Lang.get(98515),
		36718,
		18,
		1047,
		{
			RTResTalkAction[30],
			RTResTalkAction[35]
		}
	},
	[36718019] = {
		36718019,
		0,
		Lang.get(98516),
		36718,
		19,
		1214,
		{
			RTResTalkAction[30],
			RTResTalkAction[36]
		}
	},
	[36719001] = {
		36719001,
		0,
		Lang.get(98517),
		36719,
		1,
		1214,
		nil,
		1,
		2,
		-1,
		nil,
		201,
		36800,
		nil,
		1,
		nil,
		1,
		nil,
		36800
	},
	[36719002] = {
		36719002,
		0,
		Lang.get(98518),
		36719,
		2,
		182,
		nil,
		1
	},
	[36719003] = {
		36719003,
		0,
		Lang.get(98519),
		36719,
		3,
		1214,
		{
			RTResTalkAction[49]
		},
		nil,
		nil,
		3
	},
	[36719004] = {
		36719004,
		0,
		Lang.get(98520),
		36719,
		4,
		225,
		{
			RTResTalkAction[86],
			RTResTalkAction[17]
		}
	},
	[36719005] = {
		36719005,
		0,
		Lang.get(98521),
		36719,
		5,
		1214,
		{
			RTResTalkAction[49],
			RTResTalkAction[39]
		}
	},
	[36719006] = {
		36719006,
		0,
		Lang.get(98522),
		36719,
		6,
		1214,
		{
			RTResTalkAction[87]
		}
	},
	[36719007] = {
		36719007,
		0,
		Lang.get(98523),
		36719,
		7,
		1214,
		{
			RTResTalkAction[17]
		},
		1,
		1,
		1,
		nil,
		nil,
		36801,
		nil,
		1,
		nil,
		1,
		nil,
		36801
	},
	[36719008] = {
		36719008,
		0,
		Lang.get(98524),
		36719,
		8,
		1214,
		nil,
		1,
		2
	},
	[36719009] = {
		36719009,
		3,
		Lang.get(98525),
		36719,
		9,
		605,
		nil,
		nil,
		nil,
		3,
		[22] = 1
	},
	[36719010] = {
		36719010,
		0,
		Lang.get(98526),
		36719,
		10,
		1214,
		{
			RTResTalkAction[49]
		}
	},
	[36719011] = {
		36719011,
		0,
		Lang.get(98527),
		36719,
		11,
		1214,
		{
			RTResTalkAction[23]
		}
	},
	[36719012] = {
		36719012,
		3,
		Lang.get(98528),
		36719,
		12,
		605,
		{
			RTResTalkAction[66],
			RTResTalkAction[17]
		},
		nil,
		nil,
		-1,
		1217,
		194,
		36802,
		nil,
		1,
		nil,
		1,
		nil,
		36802,
		255,
		nil,
		1
	},
	[36719013] = {
		36719013,
		0,
		Lang.get(98529),
		36719,
		13,
		1047,
		{
			RTResTalkAction[67]
		},
		1,
		1,
		nil,
		nil,
		176,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		-1
	},
	[36719014] = {
		36719014,
		0,
		Lang.get(98530),
		36719,
		14,
		1047,
		nil,
		1,
		1
	},
	[36719015] = {
		36719015,
		0,
		Lang.get(98531),
		36719,
		15,
		1060,
		{
			RTResTalkAction[88]
		},
		nil,
		nil,
		3
	},
	[36719016] = {
		36719016,
		0,
		Lang.get(98532),
		36719,
		16,
		1047,
		{
			RTResTalkAction[8],
			RTResTalkAction[89]
		}
	},
	[36719017] = {
		36719017,
		0,
		Lang.get(98533),
		36719,
		17,
		237,
		{
			RTResTalkAction[90],
			RTResTalkAction[9]
		}
	},
	[36719018] = {
		36719018,
		0,
		Lang.get(98534),
		36719,
		18,
		215,
		{
			RTResTalkAction[91],
			RTResTalkAction[79]
		}
	},
	[36719019] = {
		36719019,
		0,
		Lang.get(98535),
		36719,
		19,
		215,
		{
			RTResTalkAction[91]
		}
	},
	[36719020] = {
		36719020,
		0,
		Lang.get(98536),
		36719,
		20,
		1057,
		{
			RTResTalkAction[92],
			RTResTalkAction[44]
		}
	},
	[36719021] = {
		36719021,
		0,
		Lang.get(98537),
		36719,
		21,
		1056,
		{
			RTResTalkAction[93],
			RTResTalkAction[94]
		}
	},
	[36719022] = {
		36719022,
		0,
		Lang.get(98538),
		36719,
		22,
		1060,
		{
			RTResTalkAction[95],
			RTResTalkAction[96]
		}
	},
	[36719023] = {
		36719023,
		3,
		Lang.get(98539),
		36719,
		23,
		605,
		{
			RTResTalkAction[89]
		},
		nil,
		nil,
		nil,
		nil,
		168,
		36805,
		nil,
		1,
		nil,
		nil,
		nil,
		36805,
		nil,
		nil,
		1
	},
	[36719024] = {
		36719024,
		0,
		Lang.get(98540),
		36719,
		24,
		1027,
		nil,
		1
	},
	[36719025] = {
		36719025,
		0,
		Lang.get(98541),
		36719,
		25,
		1028,
		nil,
		1
	},
	[36719026] = {
		36719026,
		0,
		Lang.get(98542),
		36719,
		26,
		1027,
		{
			RTResTalkAction[4]
		}
	},
	[36719027] = {
		36719027,
		0,
		Lang.get(98543),
		36719,
		27,
		1047,
		{
			RTResTalkAction[56],
			RTResTalkAction[6]
		}
	},
	[36720001] = {
		36720001,
		0,
		Lang.get(98544),
		36720,
		1,
		1230,
		nil,
		1,
		nil,
		-1,
		2699,
		201,
		36810,
		nil,
		1,
		nil,
		1,
		nil,
		36810
	},
	[36720002] = {
		36720002,
		0,
		Lang.get(98545),
		36720,
		2,
		1229,
		nil,
		1
	},
	[36720003] = {
		36720003,
		0,
		Lang.get(98546),
		36720,
		3,
		1232,
		nil,
		1,
		1,
		nil,
		2500
	},
	[36720004] = {
		36720004,
		0,
		Lang.get(98547),
		36720,
		4,
		1230,
		nil,
		1,
		nil,
		nil,
		2702
	},
	[36720005] = {
		36720005,
		0,
		Lang.get(98548),
		36720,
		5,
		1231,
		nil,
		1,
		1,
		nil,
		2550
	},
	[36720006] = {
		36720006,
		0,
		Lang.get(98549),
		36720,
		6,
		1232,
		nil,
		1
	},
	[36720007] = {
		36720007,
		0,
		Lang.get(98550),
		36720,
		7,
		1230,
		nil,
		1,
		1,
		nil,
		2710
	},
	[36720008] = {
		36720008,
		0,
		Lang.get(98551),
		36720,
		8,
		1231,
		nil,
		1,
		1,
		nil,
		2549
	},
	[36720009] = {
		36720009,
		0,
		Lang.get(98552),
		36720,
		9,
		1232,
		nil,
		1,
		2
	},
	[36720010] = {
		36720010,
		0,
		Lang.get(98553),
		36720,
		10,
		1214,
		nil,
		1,
		2,
		nil,
		2684,
		nil,
		36811,
		nil,
		1,
		nil,
		nil,
		nil,
		36811
	},
	[36720011] = {
		36720011,
		0,
		Lang.get(98554),
		36720,
		11,
		1214,
		nil,
		1,
		2
	},
	[36720012] = {
		36720012,
		0,
		Lang.get(98555),
		36720,
		12,
		1214,
		{
			RTResTalkAction[49]
		}
	},
	[36720013] = {
		36720013,
		0,
		Lang.get(98556),
		36720,
		13,
		1214,
		{
			RTResTalkAction[87]
		},
		nil,
		nil,
		nil,
		2698
	},
	[36720014] = {
		36720014,
		0,
		Lang.get(98557),
		36720,
		14,
		1214,
		{
			RTResTalkAction[49]
		}
	},
	[36720015] = {
		36720015,
		0,
		Lang.get(98558),
		36720,
		15,
		1232,
		{
			RTResTalkAction[17]
		},
		1,
		nil,
		nil,
		2490
	},
	[36720016] = {
		36720016,
		0,
		Lang.get(98559),
		36720,
		16,
		1214,
		{
			RTResTalkAction[49]
		}
	},
	[36720017] = {
		36720017,
		3,
		Lang.get(98560),
		36720,
		17,
		605,
		{
			RTResTalkAction[66],
			RTResTalkAction[17]
		},
		nil,
		nil,
		-1,
		1217,
		194,
		36815,
		nil,
		1,
		nil,
		1,
		nil,
		36815,
		255,
		nil,
		1
	},
	[36720018] = {
		36720018,
		0,
		Lang.get(98543),
		36720,
		18,
		1047,
		{
			RTResTalkAction[56],
			RTResTalkAction[67]
		},
		nil,
		nil,
		3,
		nil,
		185,
		[20] = -1
	},
	[36720019] = {
		36720019,
		5,
		Lang.get(98561),
		36720,
		19,
		605,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		nil,
		1232,
		[22] = 1
	},
	[36720020] = {
		36720020,
		0,
		Lang.get(98562),
		36720,
		20,
		1047,
		{
			RTResTalkAction[22]
		}
	},
	[36720021] = {
		36720021,
		0,
		Lang.get(98563),
		36720,
		21,
		1028,
		{
			RTResTalkAction[7],
			RTResTalkAction[9]
		}
	},
	[36720022] = {
		36720022,
		0,
		Lang.get(98564),
		36720,
		22,
		215,
		{
			RTResTalkAction[72],
			RTResTalkAction[5]
		}
	},
	[36720023] = {
		36720023,
		0,
		Lang.get(98565),
		36720,
		23,
		1028,
		{
			RTResTalkAction[7],
			RTResTalkAction[44]
		}
	},
	[36720024] = {
		36720024,
		0,
		Lang.get(98566),
		36720,
		24,
		1047,
		{
			RTResTalkAction[22],
			RTResTalkAction[5]
		}
	},
	[36720025] = {
		36720025,
		0,
		Lang.get(98567),
		36720,
		25,
		1047,
		{
			RTResTalkAction[22]
		}
	},
	[36720026] = {
		36720026,
		0,
		Lang.get(98568),
		36720,
		26,
		1027,
		{
			RTResTalkAction[4],
			RTResTalkAction[9]
		}
	},
	[36720027] = {
		36720027,
		0,
		Lang.get(98569),
		36720,
		27,
		215,
		{
			RTResTalkAction[6]
		},
		1,
		1,
		-1,
		nil,
		nil,
		36816,
		nil,
		1,
		nil,
		nil,
		nil,
		36816
	},
	[36720028] = {
		36720028,
		0,
		Lang.get(98570),
		36720,
		28,
		237,
		nil,
		1
	},
	[36720029] = {
		36720029,
		0,
		Lang.get(98571),
		36720,
		29,
		1047,
		nil,
		1,
		1
	},
	[36720030] = {
		36720030,
		0,
		Lang.get(98572),
		36720,
		30,
		1047,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3
	},
	[36720031] = {
		36720031,
		0,
		Lang.get(98573),
		36720,
		31,
		1227,
		{
			RTResTalkAction[75],
			RTResTalkAction[9]
		}
	},
	[36720032] = {
		36720032,
		0,
		Lang.get(98574),
		36720,
		32,
		1228,
		{
			RTResTalkAction[80],
			RTResTalkAction[78]
		}
	},
	[36720033] = {
		36720033,
		0,
		Lang.get(98575),
		36720,
		33,
		1047,
		{
			RTResTalkAction[8],
			RTResTalkAction[81]
		}
	},
	[36720034] = {
		36720034,
		0,
		Lang.get(98576),
		36720,
		34,
		1226,
		{
			RTResTalkAction[74],
			RTResTalkAction[9]
		}
	},
	[36721001] = {
		36721001,
		3,
		Lang.get(98577),
		36721,
		1,
		605,
		{
			RTResTalkAction[66]
		},
		nil,
		nil,
		nil,
		1217,
		194,
		36820,
		nil,
		1,
		nil,
		1,
		nil,
		36820,
		255,
		nil,
		1
	},
	[36721002] = {
		36721002,
		0,
		Lang.get(98578),
		36721,
		2,
		1047,
		{
			RTResTalkAction[67]
		},
		1,
		1,
		nil,
		nil,
		50,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		-1
	},
	[36721003] = {
		36721003,
		0,
		Lang.get(98579),
		36721,
		3,
		1210,
		nil,
		1
	},
	[36721004] = {
		36721004,
		0,
		Lang.get(98580),
		36721,
		4,
		1047,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3
	},
	[36721005] = {
		36721005,
		0,
		Lang.get(98581),
		36721,
		5,
		1210,
		{
			RTResTalkAction[30],
			RTResTalkAction[97]
		}
	},
	[36721006] = {
		36721006,
		0,
		Lang.get(98582),
		36721,
		6,
		1047,
		{
			RTResTalkAction[30],
			RTResTalkAction[97]
		}
	},
	[36721007] = {
		36721007,
		0,
		Lang.get(98583),
		36721,
		7,
		1210,
		{
			RTResTalkAction[30],
			RTResTalkAction[97]
		}
	},
	[36721008] = {
		36721008,
		0,
		Lang.get(98584),
		36721,
		8,
		1047,
		{
			RTResTalkAction[9],
			RTResTalkAction[98]
		},
		1,
		1,
		-1,
		nil,
		nil,
		36821,
		nil,
		1,
		nil,
		nil,
		nil,
		36821
	},
	[36721009] = {
		36721009,
		0,
		Lang.get(98585),
		36721,
		9,
		1047,
		nil,
		1,
		1
	},
	[36721010] = {
		36721010,
		3,
		Lang.get(98586),
		36721,
		10,
		605,
		{
			RTResTalkAction[66]
		},
		nil,
		nil,
		nil,
		1217,
		194,
		[22] = 1
	},
	[36721011] = {
		36721011,
		0,
		Lang.get(98587),
		36721,
		11,
		1047,
		{
			RTResTalkAction[67]
		},
		1,
		1,
		nil,
		nil,
		176
	},
	[36721012] = {
		36721012,
		0,
		Lang.get(98588),
		36721,
		12,
		1233,
		nil,
		1
	},
	[36721013] = {
		36721013,
		0,
		Lang.get(98589),
		36721,
		13,
		1047,
		{
			RTResTalkAction[99]
		},
		nil,
		nil,
		3
	},
	[36721014] = {
		36721014,
		0,
		Lang.get(98590),
		36721,
		14,
		1233,
		{
			RTResTalkAction[9]
		},
		1,
		nil,
		-1,
		nil,
		nil,
		36822,
		nil,
		1,
		nil,
		nil,
		nil,
		36822
	},
	[36721015] = {
		36721015,
		0,
		Lang.get(98591),
		36721,
		15,
		1047,
		nil,
		1,
		1
	},
	[36721016] = {
		36721016,
		0,
		Lang.get(98592),
		36721,
		16,
		1219,
		{
			RTResTalkAction[43]
		},
		nil,
		nil,
		3
	},
	[36721017] = {
		36721017,
		0,
		Lang.get(98593),
		36721,
		17,
		1047,
		{
			RTResTalkAction[46],
			RTResTalkAction[19]
		}
	},
	[36721018] = {
		36721018,
		0,
		Lang.get(98594),
		36721,
		18,
		1219,
		{
			RTResTalkAction[46],
			RTResTalkAction[19]
		}
	},
	[36721019] = {
		36721019,
		0,
		Lang.get(98595),
		36721,
		19,
		1047,
		{
			RTResTalkAction[46],
			RTResTalkAction[19]
		}
	},
	[36721020] = {
		36721020,
		0,
		Lang.get(98596),
		36721,
		20,
		1219,
		{
			RTResTalkAction[46],
			RTResTalkAction[19]
		}
	},
	[36721021] = {
		36721021,
		5,
		Lang.get(98476),
		36721,
		21,
		1047,
		{
			RTResTalkAction[15],
			RTResTalkAction[45]
		}
	},
	[36721022] = {
		36721022,
		0,
		Lang.get(98597),
		36721,
		22,
		1219,
		{
			RTResTalkAction[43],
			RTResTalkAction[9]
		}
	},
	[36721023] = {
		36721023,
		0,
		Lang.get(98598),
		36721,
		23,
		1047,
		{
			RTResTalkAction[8],
			RTResTalkAction[45]
		}
	},
	[36721024] = {
		36721024,
		5,
		Lang.get(98599),
		36721,
		24,
		1047,
		{
			RTResTalkAction[56]
		}
	},
	[36722001] = {
		36722001,
		0,
		Lang.get(98600),
		36722,
		1,
		537,
		nil,
		1,
		nil,
		-1,
		nil,
		156,
		36823,
		nil,
		1,
		nil,
		1,
		nil,
		36823
	},
	[36722002] = {
		36722002,
		0,
		Lang.get(98601),
		36722,
		2,
		1214,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		36824,
		nil,
		nil,
		nil,
		nil,
		nil,
		36824
	},
	[36722003] = {
		36722003,
		0,
		Lang.get(98602),
		36722,
		3,
		1214,
		nil,
		1,
		2
	},
	[36722004] = {
		36722004,
		0,
		Lang.get(98603),
		36722,
		4,
		1214,
		nil,
		1,
		2
	},
	[36722005] = {
		36722005,
		5,
		Lang.get(98604),
		36722,
		5,
		537,
		nil,
		1
	},
	[36722006] = {
		36722006,
		0,
		Lang.get(98605),
		36722,
		6,
		1214,
		{
			RTResTalkAction[49]
		},
		nil,
		nil,
		3
	},
	[36722007] = {
		36722007,
		0,
		Lang.get(98606),
		36722,
		7,
		537,
		{
			RTResTalkAction[17]
		},
		1
	},
	[36722008] = {
		36722008,
		0,
		Lang.get(98607),
		36722,
		8,
		1214,
		{
			RTResTalkAction[27]
		}
	},
	[36722009] = {
		36722009,
		0,
		Lang.get(98608),
		36722,
		9,
		1214,
		{
			RTResTalkAction[27]
		}
	},
	[36722010] = {
		36722010,
		0,
		Lang.get(98609),
		36722,
		10,
		537,
		{
			RTResTalkAction[17]
		},
		1
	},
	[36722011] = {
		36722011,
		0,
		Lang.get(98610),
		36722,
		11,
		1214,
		{
			RTResTalkAction[27]
		}
	},
	[36722012] = {
		36722012,
		0,
		Lang.get(98611),
		36722,
		12,
		537,
		{
			RTResTalkAction[17]
		},
		1
	},
	[36722013] = {
		36722013,
		0,
		Lang.get(98612),
		36722,
		13,
		537,
		nil,
		1
	},
	[36722014] = {
		36722014,
		0,
		Lang.get(98613),
		36722,
		14,
		1214,
		{
			RTResTalkAction[49]
		}
	},
	[36722015] = {
		36722015,
		0,
		Lang.get(98614),
		36722,
		15,
		537,
		{
			RTResTalkAction[17]
		},
		1
	},
	[36722016] = {
		36722016,
		0,
		Lang.get(98615),
		36722,
		16,
		1214,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		nil,
		nil,
		201
	},
	[36722017] = {
		36722017,
		0,
		Lang.get(98616),
		36722,
		17,
		537,
		{
			RTResTalkAction[17]
		},
		1
	},
	[36722018] = {
		36722018,
		0,
		Lang.get(98617),
		36722,
		18,
		1214,
		{
			RTResTalkAction[87]
		}
	},
	[36722019] = {
		36722019,
		5,
		Lang.get(98148),
		36722,
		19,
		537,
		{
			RTResTalkAction[17]
		},
		1
	},
	[36722020] = {
		36722020,
		0,
		Lang.get(98149),
		36722,
		20,
		1214,
		{
			RTResTalkAction[87]
		}
	},
	[36722021] = {
		36722021,
		0,
		Lang.get(98618),
		36722,
		21,
		1214,
		{
			RTResTalkAction[16]
		}
	},
	[36722022] = {
		36722022,
		3,
		Lang.get(98619),
		36722,
		22,
		605,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		-1,
		nil,
		176,
		36825,
		nil,
		1,
		nil,
		nil,
		nil,
		36825,
		nil,
		nil,
		1
	},
	[36722023] = {
		36722023,
		0,
		Lang.get(98620),
		36722,
		23,
		1214,
		nil,
		1,
		3
	},
	[36722024] = {
		36722024,
		0,
		Lang.get(98621),
		36722,
		24,
		1214,
		{
			RTResTalkAction[49]
		},
		nil,
		nil,
		3
	},
	[36722025] = {
		36722025,
		0,
		Lang.get(98622),
		36722,
		25,
		1214,
		{
			RTResTalkAction[49]
		}
	},
	[36722026] = {
		36722026,
		5,
		Lang.get(98623),
		36722,
		26,
		605,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		nil,
		1232,
		nil,
		36826,
		nil,
		1,
		nil,
		nil,
		nil,
		36826,
		nil,
		nil,
		1
	},
	[36722027] = {
		36722027,
		0,
		Lang.get(98182),
		36722,
		27,
		1047,
		{
			RTResTalkAction[8]
		},
		[20] = 255
	},
	[36722028] = {
		36722028,
		0,
		Lang.get(98624),
		36722,
		28,
		1219,
		{
			RTResTalkAction[43],
			RTResTalkAction[9]
		},
		nil,
		nil,
		3,
		nil,
		156,
		36830,
		nil,
		1,
		nil,
		1,
		nil,
		36830,
		-1
	},
	[36722029] = {
		36722029,
		0,
		Lang.get(98625),
		36722,
		29,
		1047,
		{
			RTResTalkAction[59],
			RTResTalkAction[45]
		}
	},
	[36722030] = {
		36722030,
		0,
		Lang.get(98626),
		36722,
		30,
		1219,
		{
			RTResTalkAction[43],
			RTResTalkAction[9]
		}
	},
	[36722031] = {
		36722031,
		0,
		Lang.get(98627),
		36722,
		31,
		1047,
		{
			RTResTalkAction[59],
			RTResTalkAction[45]
		}
	},
	[36722032] = {
		36722032,
		0,
		Lang.get(98628),
		36722,
		32,
		1219,
		{
			RTResTalkAction[43],
			RTResTalkAction[9]
		}
	},
	[36722033] = {
		36722033,
		0,
		Lang.get(98629),
		36722,
		33,
		1219,
		{
			RTResTalkAction[43]
		}
	},
	[36722034] = {
		36722034,
		0,
		Lang.get(98630),
		36722,
		34,
		1047,
		{
			RTResTalkAction[56],
			RTResTalkAction[45]
		}
	},
	[36722035] = {
		36722035,
		0,
		Lang.get(98631),
		36722,
		35,
		1219,
		{
			RTResTalkAction[43],
			RTResTalkAction[9]
		}
	},
	[36722036] = {
		36722036,
		0,
		Lang.get(98632),
		36722,
		36,
		1047,
		{
			RTResTalkAction[59],
			RTResTalkAction[45]
		}
	},
	[36722037] = {
		36722037,
		0,
		Lang.get(98633),
		36722,
		37,
		1219,
		{
			RTResTalkAction[43],
			RTResTalkAction[9]
		},
		nil,
		nil,
		nil,
		nil,
		186
	},
	[36723001] = {
		36723001,
		0,
		Lang.get(98634),
		36723,
		1,
		1219,
		nil,
		1,
		nil,
		-1,
		nil,
		193,
		36835,
		nil,
		1,
		nil,
		nil,
		nil,
		36835
	},
	[36723002] = {
		36723002,
		0,
		Lang.get(98635),
		36723,
		2,
		1219,
		nil,
		1
	},
	[36723003] = {
		36723003,
		0,
		Lang.get(98636),
		36723,
		3,
		1047,
		{
			RTResTalkAction[59]
		},
		nil,
		nil,
		3
	},
	[36723004] = {
		36723004,
		0,
		Lang.get(98637),
		36723,
		4,
		1219,
		{
			RTResTalkAction[43],
			RTResTalkAction[9]
		}
	},
	[36723005] = {
		36723005,
		0,
		Lang.get(98638),
		36723,
		5,
		1219,
		{
			RTResTalkAction[43]
		}
	},
	[36723006] = {
		36723006,
		0,
		Lang.get(98639),
		36723,
		6,
		1047,
		{
			RTResTalkAction[22],
			RTResTalkAction[45]
		}
	},
	[36723007] = {
		36723007,
		0,
		Lang.get(98640),
		36723,
		7,
		1219,
		{
			RTResTalkAction[43],
			RTResTalkAction[9]
		}
	},
	[36723008] = {
		36723008,
		0,
		Lang.get(98641),
		36723,
		8,
		1047,
		{
			RTResTalkAction[22],
			RTResTalkAction[45]
		}
	},
	[36723009] = {
		36723009,
		0,
		Lang.get(98642),
		36723,
		9,
		1233,
		{
			RTResTalkAction[9]
		},
		1,
		nil,
		-1,
		nil,
		185,
		36836,
		nil,
		1,
		nil,
		nil,
		nil,
		36836
	},
	[36723010] = {
		36723010,
		0,
		Lang.get(98643),
		36723,
		10,
		1047,
		nil,
		1
	},
	[36723011] = {
		36723011,
		0,
		Lang.get(98644),
		36723,
		11,
		1214,
		nil,
		1,
		2
	},
	[36723012] = {
		36723012,
		3,
		Lang.get(21922),
		36723,
		12,
		605,
		[22] = 1
	},
	[36724001] = {
		36724001,
		0,
		Lang.get(98645),
		36724,
		1,
		1214,
		nil,
		1,
		2,
		nil,
		nil,
		176,
		36840,
		nil,
		1,
		nil,
		1,
		nil,
		36840
	},
	[36724002] = {
		36724002,
		0,
		Lang.get(98646),
		36724,
		2,
		1047,
		nil,
		1,
		2
	},
	[36724003] = {
		36724003,
		0,
		Lang.get(98647),
		36724,
		3,
		1214,
		{
			RTResTalkAction[100]
		},
		nil,
		nil,
		3
	},
	[36724004] = {
		36724004,
		0,
		Lang.get(98648),
		36724,
		4,
		1047,
		{
			RTResTalkAction[59],
			RTResTalkAction[17]
		}
	},
	[36724005] = {
		36724005,
		0,
		Lang.get(98649),
		36724,
		5,
		1214,
		{
			RTResTalkAction[49],
			RTResTalkAction[9]
		}
	},
	[36724006] = {
		36724006,
		0,
		Lang.get(98650),
		36724,
		6,
		1047,
		{
			RTResTalkAction[59],
			RTResTalkAction[17]
		}
	},
	[36724007] = {
		36724007,
		0,
		Lang.get(98651),
		36724,
		7,
		1214,
		{
			RTResTalkAction[87],
			RTResTalkAction[9]
		},
		nil,
		nil,
		nil,
		nil,
		57
	},
	[36724008] = {
		36724008,
		0,
		Lang.get(98652),
		36724,
		8,
		1214,
		{
			RTResTalkAction[17]
		},
		1,
		2,
		-1,
		nil,
		nil,
		36841,
		nil,
		1,
		nil,
		nil,
		nil,
		36841
	},
	[36724009] = {
		36724009,
		0,
		Lang.get(98653),
		36724,
		9,
		1214,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		36842,
		nil,
		1,
		nil,
		nil,
		nil,
		36842
	},
	[36724010] = {
		36724010,
		0,
		Lang.get(98654),
		36724,
		10,
		1214,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		36843,
		nil,
		1,
		nil,
		nil,
		nil,
		36843
	},
	[36724011] = {
		36724011,
		0,
		Lang.get(98655),
		36724,
		11,
		1047,
		{
			RTResTalkAction[59]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		36844,
		nil,
		1,
		nil,
		nil,
		nil,
		36844
	},
	[36724012] = {
		36724012,
		0,
		Lang.get(98656),
		36724,
		12,
		1214,
		{
			RTResTalkAction[49],
			RTResTalkAction[9]
		}
	},
	[36724013] = {
		36724013,
		0,
		Lang.get(98657),
		36724,
		13,
		1214,
		{
			RTResTalkAction[49]
		}
	},
	[36724014] = {
		36724014,
		5,
		Lang.get(98658),
		36724,
		14,
		1047,
		{
			RTResTalkAction[56],
			RTResTalkAction[17]
		}
	},
	[36724015] = {
		36724015,
		3,
		Lang.get(98659),
		36724,
		15,
		605,
		{
			RTResTalkAction[66],
			RTResTalkAction[9]
		},
		nil,
		nil,
		-1,
		1217,
		194,
		36845,
		nil,
		1,
		nil,
		nil,
		nil,
		36845,
		nil,
		nil,
		1
	},
	[36724016] = {
		36724016,
		0,
		Lang.get(98660),
		36724,
		16,
		1214,
		{
			RTResTalkAction[67]
		},
		1,
		4,
		nil,
		nil,
		201
	},
	[36724017] = {
		36724017,
		0,
		Lang.get(98661),
		36724,
		17,
		1214,
		nil,
		1,
		4
	},
	[36725001] = {
		36725001,
		0,
		Lang.get(98662),
		36725,
		1,
		1214,
		nil,
		1,
		1,
		nil,
		nil,
		50,
		36846,
		1,
		1,
		nil,
		nil,
		nil,
		36846
	},
	[36725002] = {
		36725002,
		0,
		Lang.get(98663),
		36725,
		2,
		1214,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		36847,
		1,
		1,
		nil,
		nil,
		nil,
		36847
	},
	[36725003] = {
		36725003,
		0,
		Lang.get(98664),
		36725,
		3,
		1214,
		nil,
		1,
		4,
		nil,
		nil,
		nil,
		36848,
		1,
		nil,
		nil,
		nil,
		nil,
		36848
	},
	[36725004] = {
		36725004,
		0,
		Lang.get(98665),
		36725,
		4,
		1214,
		nil,
		1,
		3,
		nil,
		nil,
		nil,
		36849,
		1,
		nil,
		nil,
		nil,
		nil,
		36849
	},
	[36725005] = {
		36725005,
		0,
		Lang.get(98666),
		36725,
		5,
		1214,
		nil,
		1,
		4,
		nil,
		nil,
		nil,
		36850,
		1,
		nil,
		nil,
		nil,
		nil,
		36850
	},
	[36725006] = {
		36725006,
		0,
		Lang.get(98667),
		36725,
		6,
		1214,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		36851,
		1,
		[19] = 36851,
		[20] = 255
	},
	[36725007] = {
		36725007,
		3,
		Lang.get(98668),
		36725,
		7,
		605,
		{
			RTResTalkAction[66],
			RTResTalkAction[17]
		},
		nil,
		nil,
		nil,
		1217,
		194,
		36852,
		nil,
		nil,
		nil,
		nil,
		nil,
		36852,
		255,
		nil,
		1
	},
	[36725008] = {
		36725008,
		0,
		Lang.get(98669),
		36725,
		8,
		1214,
		{
			RTResTalkAction[67]
		},
		1,
		2,
		nil,
		nil,
		201,
		36853,
		nil,
		1,
		nil,
		nil,
		nil,
		36853,
		-1
	},
	[36725009] = {
		36725009,
		0,
		Lang.get(98670),
		36725,
		9,
		1047,
		nil,
		1,
		2
	},
	[36725010] = {
		36725010,
		3,
		Lang.get(98671),
		36725,
		10,
		605,
		{
			RTResTalkAction[1]
		},
		[22] = 1,
		[20] = 255
	},
	[36725011] = {
		36725011,
		0,
		Lang.get(98672),
		36725,
		11,
		1214,
		{
			RTResTalkAction[2]
		},
		1,
		2,
		[20] = -1
	},
	[36725012] = {
		36725012,
		0,
		Lang.get(98673),
		36725,
		12,
		1214,
		nil,
		1,
		2
	},
	[36725013] = {
		36725013,
		0,
		Lang.get(18451),
		36725,
		13,
		1047,
		{
			RTResTalkAction[59]
		}
	},
	[36725014] = {
		36725014,
		0,
		Lang.get(98674),
		36725,
		14,
		1214,
		{
			RTResTalkAction[16],
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[36725015] = {
		36725015,
		0,
		Lang.get(98675),
		36725,
		15,
		1047,
		{
			RTResTalkAction[59],
			RTResTalkAction[17]
		}
	},
	[36725016] = {
		36725016,
		0,
		Lang.get(20006),
		36725,
		16,
		1214,
		{
			RTResTalkAction[49],
			RTResTalkAction[9]
		}
	},
	[36725017] = {
		36725017,
		5,
		Lang.get(98676),
		36725,
		17,
		1047,
		{
			RTResTalkAction[56],
			RTResTalkAction[17]
		}
	},
	[36725018] = {
		36725018,
		0,
		Lang.get(98677),
		36725,
		18,
		1214,
		{
			RTResTalkAction[23],
			RTResTalkAction[9]
		}
	},
	[36725019] = {
		36725019,
		5,
		Lang.get(98678),
		36725,
		19,
		1047,
		{
			RTResTalkAction[56],
			RTResTalkAction[17]
		}
	},
	[36725020] = {
		36725020,
		0,
		Lang.get(98679),
		36725,
		20,
		1214,
		{
			RTResTalkAction[49],
			RTResTalkAction[9]
		}
	},
	[36725021] = {
		36725021,
		0,
		Lang.get(98680),
		36725,
		21,
		1214,
		{
			RTResTalkAction[49]
		}
	},
	[36725022] = {
		36725022,
		0,
		Lang.get(98681),
		36725,
		22,
		1047,
		{
			RTResTalkAction[99],
			RTResTalkAction[17]
		}
	},
	[36725023] = {
		36725023,
		0,
		Lang.get(98682),
		36725,
		23,
		1214,
		{
			RTResTalkAction[49],
			RTResTalkAction[9]
		}
	},
	[36725024] = {
		36725024,
		5,
		Lang.get(98683),
		36725,
		24,
		1214,
		{
			RTResTalkAction[69]
		}
	},
	[36725025] = {
		36725025,
		3,
		"9……8……7……",
		36725,
		25,
		605,
		{
			RTResTalkAction[66],
			RTResTalkAction[17]
		},
		nil,
		nil,
		-1,
		1217,
		nil,
		36854,
		nil,
		1,
		nil,
		nil,
		nil,
		36854,
		255,
		nil,
		1
	},
	[36725026] = {
		36725026,
		5,
		Lang.get(98684),
		36725,
		26,
		1047,
		{
			RTResTalkAction[56],
			RTResTalkAction[67]
		},
		nil,
		nil,
		3,
		[20] = -1
	},
	[36725027] = {
		36725027,
		0,
		Lang.get(98685),
		36725,
		27,
		1214,
		{
			RTResTalkAction[23],
			RTResTalkAction[9]
		}
	},
	[36725028] = {
		36725028,
		3,
		"4……3……2……",
		36725,
		28,
		605,
		{
			RTResTalkAction[66],
			RTResTalkAction[17]
		},
		nil,
		nil,
		nil,
		1217,
		[22] = 1
	},
	[36725029] = {
		36725029,
		3,
		Lang.get(98686),
		36725,
		29,
		605,
		{
			RTResTalkAction[67]
		},
		nil,
		nil,
		-1,
		1217,
		nil,
		36855,
		nil,
		1,
		nil,
		nil,
		nil,
		36855,
		nil,
		nil,
		1
	},
	[36725030] = {
		36725030,
		0,
		Lang.get(98687),
		36725,
		30,
		1047,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3
	},
	[36725031] = {
		36725031,
		0,
		Lang.get(98688),
		36725,
		31,
		1214,
		{
			RTResTalkAction[49],
			RTResTalkAction[9]
		}
	},
	[36726001] = {
		36726001,
		3,
		Lang.get(98689),
		36726,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		15,
		36860,
		nil,
		1,
		nil,
		1,
		nil,
		36860,
		nil,
		nil,
		1
	},
	[36726002] = {
		36726002,
		0,
		Lang.get(98690),
		36726,
		2,
		1047,
		nil,
		1,
		2
	},
	[36726003] = {
		36726003,
		0,
		Lang.get(98691),
		36726,
		3,
		1219,
		nil,
		1
	},
	[36726004] = {
		36726004,
		0,
		Lang.get(98692),
		36726,
		4,
		1047,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3
	},
	[36726005] = {
		36726005,
		0,
		Lang.get(98693),
		36726,
		5,
		1219,
		{
			RTResTalkAction[43],
			RTResTalkAction[9]
		}
	},
	[36726006] = {
		36726006,
		0,
		Lang.get(98694),
		36726,
		6,
		1047,
		{
			RTResTalkAction[8],
			RTResTalkAction[45]
		}
	},
	[36726007] = {
		36726007,
		0,
		Lang.get(98695),
		36726,
		7,
		1219,
		{
			RTResTalkAction[43],
			RTResTalkAction[9]
		}
	},
	[36726008] = {
		36726008,
		0,
		Lang.get(98696),
		36726,
		8,
		1047,
		{
			RTResTalkAction[22],
			RTResTalkAction[45]
		}
	},
	[36726009] = {
		36726009,
		0,
		Lang.get(98697),
		36726,
		9,
		1219,
		{
			RTResTalkAction[43],
			RTResTalkAction[9]
		}
	},
	[36726010] = {
		36726010,
		0,
		Lang.get(98698),
		36726,
		10,
		1219,
		{
			RTResTalkAction[43]
		}
	},
	[36726011] = {
		36726011,
		0,
		Lang.get(98699),
		36726,
		11,
		1219,
		{
			RTResTalkAction[43]
		}
	},
	[36726012] = {
		36726012,
		0,
		Lang.get(98700),
		36726,
		12,
		1047,
		{
			RTResTalkAction[45]
		},
		1,
		1,
		-1,
		nil,
		nil,
		36861,
		nil,
		1,
		nil,
		nil,
		nil,
		36861
	},
	[36726013] = {
		36726013,
		0,
		Lang.get(98701),
		36726,
		13,
		1133,
		nil,
		1,
		nil,
		-1,
		nil,
		201,
		36865,
		nil,
		1,
		nil,
		1,
		nil,
		36865
	},
	[36726014] = {
		36726014,
		0,
		Lang.get(98702),
		36726,
		14,
		1133,
		nil,
		1
	},
	[36726015] = {
		36726015,
		0,
		Lang.get(98703),
		36726,
		15,
		1132,
		{
			RTResTalkAction[101]
		},
		nil,
		nil,
		3
	},
	[36726016] = {
		36726016,
		0,
		Lang.get(98704),
		36726,
		16,
		1214,
		{
			RTResTalkAction[49],
			RTResTalkAction[102]
		}
	},
	[36726017] = {
		36726017,
		0,
		Lang.get(98705),
		36726,
		17,
		1132,
		{
			RTResTalkAction[101],
			RTResTalkAction[17]
		}
	},
	[36726018] = {
		36726018,
		0,
		Lang.get(98706),
		36726,
		18,
		1214,
		{
			RTResTalkAction[49],
			RTResTalkAction[102]
		}
	},
	[36726019] = {
		36726019,
		0,
		Lang.get(98707),
		36726,
		19,
		1214,
		{
			RTResTalkAction[49]
		}
	},
	[36726020] = {
		36726020,
		0,
		Lang.get(98708),
		36726,
		20,
		1132,
		{
			RTResTalkAction[103],
			RTResTalkAction[17]
		}
	},
	[36726021] = {
		36726021,
		0,
		Lang.get(98709),
		36726,
		21,
		1214,
		{
			RTResTalkAction[49],
			RTResTalkAction[102]
		}
	},
	[36726022] = {
		36726022,
		0,
		Lang.get(98710),
		36726,
		22,
		1132,
		{
			RTResTalkAction[103],
			RTResTalkAction[17]
		}
	},
	[36726023] = {
		36726023,
		0,
		Lang.get(98711),
		36726,
		23,
		1132,
		{
			RTResTalkAction[103]
		}
	},
	[36726024] = {
		36726024,
		0,
		Lang.get(98712),
		36726,
		24,
		1214,
		{
			RTResTalkAction[49],
			RTResTalkAction[102]
		}
	},
	[36726025] = {
		36726025,
		0,
		Lang.get(98713),
		36726,
		25,
		1132,
		{
			RTResTalkAction[103],
			RTResTalkAction[17]
		}
	},
	[36726026] = {
		36726026,
		0,
		Lang.get(98714),
		36726,
		26,
		1214,
		{
			RTResTalkAction[102]
		},
		1,
		2,
		nil,
		nil,
		nil,
		36870,
		nil,
		1,
		nil,
		nil,
		nil,
		36870
	},
	[36726027] = {
		36726027,
		0,
		Lang.get(98715),
		36726,
		27,
		1132,
		{
			RTResTalkAction[1]
		},
		1,
		1,
		nil,
		nil,
		nil,
		36871,
		nil,
		1,
		nil,
		nil,
		nil,
		36871
	},
	[36726028] = {
		36726028,
		3,
		Lang.get(96988),
		36726,
		28,
		605,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		nil,
		nil,
		194,
		[22] = 1,
		[20] = 255
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
