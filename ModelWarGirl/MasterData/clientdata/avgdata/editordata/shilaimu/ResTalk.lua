-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\shilaimu\\ResTalk.lua

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
	[2] = 73
}
RTResTalkAction[2] = {
	[1] = 0,
	[2] = 73
}
RTResTalkAction[3] = {
	1,
	253,
	nil,
	nil,
	3
}
RTResTalkAction[4] = {
	[1] = 1,
	[2] = 69
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 253
}
RTResTalkAction[6] = {
	1,
	253,
	nil,
	nil,
	2
}
RTResTalkAction[7] = {
	[1] = 0,
	[2] = 69
}
RTResTalkAction[8] = {
	1,
	253,
	nil,
	nil,
	1
}
RTResTalkAction[9] = {
	[1] = 1,
	[2] = 72
}
RTResTalkAction[10] = {
	1,
	253,
	nil,
	nil,
	4
}
RTResTalkAction[11] = {
	[1] = 0,
	[2] = 72
}
RTResTalkAction[12] = {
	[1] = 1,
	[2] = 253
}
RTResTalkAction[13] = {
	[1] = 2,
	[2] = 253
}
RTResTalkAction[14] = {
	3,
	249,
	nil,
	nil,
	3
}
RTResTalkAction[15] = {
	2,
	253,
	{
		1
	},
	nil,
	3
}
RTResTalkAction[16] = {
	[1] = 3,
	[2] = 249
}
RTResTalkAction[17] = {
	[1] = 0,
	[2] = 249
}
RTResTalkAction[18] = {
	3,
	249,
	nil,
	nil,
	5
}
RTResTalkAction[19] = {
	2,
	253,
	nil,
	nil,
	1
}
RTResTalkAction[20] = {
	2,
	253,
	nil,
	nil,
	4
}
RTResTalkAction[21] = {
	1,
	107,
	nil,
	nil,
	3
}
RTResTalkAction[22] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[23] = {
	3,
	141,
	nil,
	nil,
	0
}
RTResTalkAction[24] = {
	[1] = 3,
	[2] = 141
}
RTResTalkAction[25] = {
	1,
	249,
	nil,
	nil,
	2
}
RTResTalkAction[26] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[27] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[28] = {
	2,
	253,
	{
		1
	},
	nil,
	4
}
RTResTalkAction[29] = {
	3,
	249,
	nil,
	nil,
	4
}
RTResTalkAction[30] = {
	2,
	253,
	nil,
	nil,
	2
}
RTResTalkAction[31] = {
	2,
	253,
	nil,
	nil,
	5
}
RTResTalkAction[32] = {
	[1] = 1,
	[2] = 249
}
RTResTalkAction[33] = {
	1,
	249,
	nil,
	nil,
	3
}
RTResTalkAction[34] = {
	[1] = 1,
	[2] = 141
}
RTResTalkAction[35] = {
	2,
	107,
	nil,
	nil,
	3
}
RTResTalkAction[36] = {
	2,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[37] = {
	1,
	253,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[38] = {
	[1] = 3,
	[2] = 131,
	[3] = {
		1
	}
}
RTResTalkAction[39] = {
	1,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[40] = {
	[1] = 0,
	[2] = 131
}
RTResTalkAction[41] = {
	3,
	134,
	nil,
	nil,
	1
}
RTResTalkAction[42] = {
	[1] = 1,
	[2] = 131
}
RTResTalkAction[43] = {
	[1] = 0,
	[2] = 134
}
RTResTalkAction[44] = {
	1,
	141,
	nil,
	nil,
	3
}
RTResTalkAction[45] = {
	2,
	107,
	nil,
	nil,
	2
}
RTResTalkAction[46] = {
	3,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[47] = {
	3,
	107,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[48] = {
	1,
	249,
	nil,
	nil,
	5
}
RTResTalkAction[49] = {
	[1] = 2,
	[2] = 131
}
RTResTalkAction[50] = {
	1,
	134,
	nil,
	nil,
	1
}
RTResTalkAction[51] = {
	[1] = 3,
	[2] = 131
}
RTResTalkAction[52] = {
	[1] = 2,
	[2] = 131,
	[3] = {
		1
	}
}
RTResTalkAction[53] = {
	1,
	249,
	nil,
	nil,
	1
}
RTResTalkAction[54] = {
	3,
	253,
	nil,
	nil,
	2
}
RTResTalkAction[55] = {
	2,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[56] = {
	[1] = 3,
	[2] = 253
}
RTResTalkAction[57] = {
	3,
	141,
	nil,
	nil,
	3
}
RTResTalkAction[58] = {
	3,
	249,
	nil,
	nil,
	1
}
RTResTalkAction[59] = {
	[1] = 1,
	[2] = 46
}
RTResTalkAction[60] = {
	[1] = 2,
	[2] = 46
}
RTResTalkAction[61] = {
	[1] = 0,
	[2] = 46
}
RTResTalkAction[62] = {
	1,
	107,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[63] = {
	3,
	141,
	nil,
	nil,
	2
}
RTResTalkAction[64] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[65] = {
	1,
	107,
	nil,
	nil,
	2
}
RTResTalkAction[66] = {
	2,
	107,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[67] = {
	[1] = 3,
	[2] = 134
}
RTResTalkAction[68] = {
	[1] = 1,
	[2] = 134
}
RTResTalkAction[69] = {
	1,
	141,
	nil,
	nil,
	0
}
RTResTalkAction[70] = {
	[1] = 2,
	[2] = 141
}
RTResTalkAction[71] = {
	3,
	107,
	nil,
	nil,
	3
}
RTResTalkAction[72] = {
	[1] = 1,
	[2] = 251
}
RTResTalkAction[73] = {
	[1] = 3,
	[2] = 251
}
RTResTalkAction[74] = {
	[1] = 0,
	[2] = 251
}
RTResTalkAction[75] = {
	3,
	107,
	nil,
	nil,
	10
}
RTResTalkAction[76] = {
	2,
	134,
	nil,
	nil,
	5
}
RTResTalkAction[77] = {
	[1] = 3,
	[2] = 107
}
RTResTalkAction[78] = {
	3,
	134,
	nil,
	nil,
	4
}
RTResTalkAction[79] = {
	1,
	107,
	nil,
	nil,
	11
}
RTResTalkAction[80] = {
	[1] = 1,
	[2] = 16
}
RTResTalkAction[81] = {
	[1] = 1,
	[2] = 71
}
RTResTalkAction[82] = {
	[1] = 0,
	[2] = 16
}
RTResTalkAction[83] = {
	[1] = 0,
	[2] = 71
}
RTResTalkAction[84] = {
	[1] = 1,
	[2] = 16,
	[3] = {
		1
	}
}
RTResTalkAction[85] = {
	[1] = 2,
	[2] = 16
}
RTResTalkAction[86] = {
	[1] = 3,
	[2] = 63,
	[3] = {
		1
	}
}
RTResTalkAction[87] = {
	[1] = 3,
	[2] = 63
}
RTResTalkAction[88] = {
	[1] = 0,
	[2] = 63
}
RTResTalkAction[89] = {
	[1] = 3,
	[2] = 673
}
RTResTalkAction[90] = {
	[1] = 1,
	[2] = 673,
	[3] = {
		1
	}
}
RTResTalkAction[91] = {
	[1] = 2,
	[2] = 249
}
RTResTalkAction[92] = {
	3,
	253,
	nil,
	nil,
	3
}
RTResTalkAction[93] = {
	2,
	249,
	nil,
	nil,
	4
}
RTResTalkAction[94] = {
	[1] = 1,
	[2] = 673
}
RTResTalkAction[95] = {
	[1] = 0,
	[2] = 673
}
RTResTalkAction[96] = {
	[1] = 1,
	[2] = 107,
	[3] = {
		1
	}
}
RTResTalkAction[97] = {
	2,
	249,
	nil,
	nil,
	5
}
RTResTalkAction[98] = {
	3,
	253,
	nil,
	nil,
	5
}
RTResTalkAction[99] = {
	3,
	141,
	nil,
	nil,
	1
}
RTResTalkAction[100] = {
	3,
	107,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[101] = {
	[1] = 1,
	[2] = 252
}
RTResTalkAction[102] = {
	[1] = 0,
	[2] = 252
}
RTResTalkAction[103] = {
	[1] = 1,
	[2] = 255,
	[3] = {
		3
	}
}
RTResTalkAction[104] = {
	[1] = 0,
	[2] = 255
}
RTResTalkAction[105] = {
	[1] = 1,
	[2] = 250
}
RTResTalkAction[106] = {
	1,
	107,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[107] = {
	[1] = 0,
	[2] = 250
}
RTResTalkAction[108] = {
	3,
	107,
	{
		2
	},
	nil,
	6
}
RTResTalkAction[109] = {
	3,
	107,
	nil,
	nil,
	5
}
RTResTalkAction[110] = {
	1,
	134,
	nil,
	nil,
	0
}
RTResTalkAction[111] = {
	[1] = 2,
	[2] = 134
}
RTResTalkAction[112] = {
	3,
	107,
	{
		1
	},
	nil,
	7
}
RTResTalkAction[113] = {
	[1] = 2,
	[2] = 250
}
RTResTalkAction[114] = {
	[1] = 3,
	[2] = 252
}
RTResTalkAction[115] = {
	1,
	107,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[116] = {
	1,
	249,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[117] = {
	3,
	253,
	nil,
	nil,
	4
}
RTResTalkAction[118] = {
	1,
	249,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[119] = {
	1,
	249,
	nil,
	nil,
	4
}
RTResTalkAction[120] = {
	2,
	253,
	{
		3
	},
	nil,
	4
}
RTResTalkAction[121] = {
	[1] = 1,
	[2] = 256,
	[3] = {
		1
	}
}
RTResTalkAction[122] = {
	[1] = 1,
	[2] = 256
}

local Data = {
	[23000001] = {
		23000001,
		0,
		Lang.get(54803),
		23000,
		1,
		605,
		nil,
		nil,
		nil,
		3,
		nil,
		132,
		23000,
		nil,
		1,
		nil,
		1,
		nil,
		23000,
		255
	},
	[23000002] = {
		23000002,
		0,
		Lang.get(54804),
		23000,
		2,
		605
	},
	[23000003] = {
		23000003,
		0,
		Lang.get(55654),
		23000,
		3,
		718,
		nil,
		1,
		0
	},
	[23000004] = {
		23000004,
		0,
		Lang.get(56952),
		23000,
		4,
		249,
		nil,
		1,
		4,
		-1,
		nil,
		nil,
		23001,
		nil,
		1,
		nil,
		4,
		nil,
		23001,
		-1
	},
	[23000005] = {
		23000005,
		0,
		Lang.get(56953),
		23000,
		5,
		253,
		nil,
		1,
		3,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[23000006] = {
		23000006,
		7,
		"72",
		23000,
		6,
		253,
		nil,
		nil,
		nil,
		5
	},
	[23000007] = {
		23000007,
		0,
		Lang.get(55655),
		23000,
		7,
		73,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		23002,
		nil,
		1,
		nil,
		nil,
		nil,
		23002
	},
	[23000008] = {
		23000008,
		7,
		"71",
		23000,
		8,
		73,
		{
			RTResTalkAction[2]
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
	[23000009] = {
		23000009,
		0,
		Lang.get(54809),
		23000,
		9,
		253,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[23000010] = {
		23000010,
		0,
		Lang.get(55656),
		23000,
		10,
		69,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[23000011] = {
		23000011,
		0,
		Lang.get(55657),
		23000,
		11,
		69,
		{
			RTResTalkAction[4]
		}
	},
	[23000012] = {
		23000012,
		0,
		Lang.get(54811),
		23000,
		12,
		69,
		{
			RTResTalkAction[4]
		}
	},
	[23000013] = {
		23000013,
		0,
		Lang.get(54812),
		23000,
		13,
		253,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[23000014] = {
		23000014,
		0,
		Lang.get(55658),
		23000,
		14,
		69,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[23000015] = {
		23000015,
		0,
		Lang.get(54814),
		23000,
		15,
		253,
		{
			RTResTalkAction[3],
			RTResTalkAction[7]
		}
	},
	[23000016] = {
		23000016,
		0,
		Lang.get(54815),
		23000,
		16,
		69,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[23000017] = {
		23000017,
		0,
		Lang.get(55659),
		23000,
		17,
		253,
		{
			RTResTalkAction[8],
			RTResTalkAction[7]
		}
	},
	[23000018] = {
		23000018,
		0,
		Lang.get(55660),
		23000,
		18,
		69,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[23000019] = {
		23000019,
		0,
		Lang.get(55661),
		23000,
		19,
		253,
		{
			RTResTalkAction[3],
			RTResTalkAction[7]
		}
	},
	[23000020] = {
		23000020,
		0,
		Lang.get(55662),
		23000,
		20,
		69,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[23000021] = {
		23000021,
		0,
		Lang.get(55663),
		23000,
		21,
		253,
		{
			RTResTalkAction[8],
			RTResTalkAction[7]
		}
	},
	[23000022] = {
		23000022,
		0,
		"……",
		23000,
		22,
		72,
		{
			RTResTalkAction[9],
			RTResTalkAction[5]
		}
	},
	[23000023] = {
		23000023,
		0,
		Lang.get(55664),
		23000,
		23,
		253,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[23001001] = {
		23001001,
		0,
		Lang.get(54825),
		23001,
		1,
		253,
		nil,
		1,
		3,
		nil,
		nil,
		133,
		23003,
		nil,
		1,
		nil,
		nil,
		nil,
		23003
	},
	[23001002] = {
		23001002,
		0,
		Lang.get(54826),
		23001,
		2,
		253,
		nil,
		1,
		2
	},
	[23001003] = {
		23001003,
		0,
		Lang.get(54827),
		23001,
		3,
		249,
		nil,
		1,
		3
	},
	[23001004] = {
		23001004,
		0,
		Lang.get(54828),
		23001,
		4,
		253,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		3
	},
	[23001005] = {
		23001005,
		0,
		Lang.get(54829),
		23001,
		5,
		253,
		{
			RTResTalkAction[12]
		}
	},
	[23001006] = {
		23001006,
		0,
		Lang.get(54830),
		23001,
		6,
		249,
		{
			RTResTalkAction[13],
			RTResTalkAction[14]
		}
	},
	[23001007] = {
		23001007,
		0,
		Lang.get(54831),
		23001,
		7,
		253,
		{
			RTResTalkAction[15],
			RTResTalkAction[16]
		}
	},
	[23001008] = {
		23001008,
		0,
		Lang.get(54832),
		23001,
		8,
		249,
		{
			RTResTalkAction[5],
			RTResTalkAction[17]
		},
		1,
		3,
		nil,
		nil,
		57,
		23004,
		nil,
		1,
		nil,
		nil,
		nil,
		23004
	},
	[23001009] = {
		23001009,
		0,
		Lang.get(54833),
		23001,
		9,
		253,
		nil,
		1,
		0
	},
	[23001010] = {
		23001010,
		0,
		Lang.get(54834),
		23001,
		10,
		249,
		nil,
		1,
		3
	},
	[23001011] = {
		23001011,
		0,
		Lang.get(55665),
		23001,
		11,
		253,
		nil,
		1,
		4
	},
	[23001012] = {
		23001012,
		0,
		Lang.get(54836),
		23001,
		12,
		253,
		nil,
		1,
		1
	},
	[23001013] = {
		23001013,
		0,
		Lang.get(54837),
		23001,
		13,
		249,
		nil,
		1,
		4
	},
	[23001014] = {
		23001014,
		0,
		Lang.get(54838),
		23001,
		14,
		253,
		nil,
		1,
		4
	},
	[23001015] = {
		23001015,
		0,
		Lang.get(54839),
		23001,
		15,
		253,
		nil,
		1,
		3,
		nil,
		nil,
		133,
		23005,
		nil,
		1,
		nil,
		nil,
		nil,
		23005
	},
	[23001016] = {
		23001016,
		0,
		Lang.get(54840),
		23001,
		16,
		253,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3
	},
	[23001017] = {
		23001017,
		0,
		Lang.get(54841),
		23001,
		17,
		249,
		{
			RTResTalkAction[13],
			RTResTalkAction[14]
		}
	},
	[23001018] = {
		23001018,
		0,
		Lang.get(54842),
		23001,
		18,
		249,
		{
			RTResTalkAction[13],
			RTResTalkAction[18]
		}
	},
	[23001019] = {
		23001019,
		0,
		Lang.get(54843),
		23001,
		19,
		253,
		{
			RTResTalkAction[19],
			RTResTalkAction[16]
		}
	},
	[23001020] = {
		23001020,
		0,
		Lang.get(54844),
		23001,
		20,
		253,
		{
			RTResTalkAction[20],
			RTResTalkAction[16]
		}
	},
	[23001021] = {
		23001021,
		0,
		Lang.get(54845),
		23001,
		21,
		253,
		{
			RTResTalkAction[13],
			RTResTalkAction[16]
		}
	},
	[23002001] = {
		23002001,
		0,
		Lang.get(54846),
		23002,
		1,
		249,
		nil,
		1,
		3,
		nil,
		nil,
		62,
		23006,
		nil,
		1,
		nil,
		nil,
		nil,
		23006
	},
	[23002002] = {
		23002002,
		0,
		Lang.get(54847),
		23002,
		2,
		253,
		nil,
		1,
		2
	},
	[23002003] = {
		23002003,
		0,
		Lang.get(54848),
		23002,
		3,
		249,
		nil,
		1,
		4
	},
	[23002004] = {
		23002004,
		0,
		Lang.get(55666),
		23002,
		4,
		253,
		nil,
		1,
		0
	},
	[23002005] = {
		23002005,
		0,
		Lang.get(54849),
		23002,
		5,
		253,
		nil,
		1,
		2
	},
	[23002006] = {
		23002006,
		0,
		Lang.get(54850),
		23002,
		6,
		107,
		nil,
		1,
		2
	},
	[23002007] = {
		23002007,
		0,
		Lang.get(54851),
		23002,
		7,
		134,
		nil,
		1,
		2
	},
	[23002008] = {
		23002008,
		0,
		Lang.get(54852),
		23002,
		8,
		141,
		nil,
		1,
		0
	},
	[23002009] = {
		23002009,
		0,
		Lang.get(54853),
		23002,
		9,
		107,
		nil,
		1,
		3
	},
	[23002010] = {
		23002010,
		0,
		Lang.get(54854),
		23002,
		10,
		134,
		nil,
		1,
		1,
		nil,
		nil,
		119
	},
	[23002011] = {
		23002011,
		0,
		Lang.get(54855),
		23002,
		11,
		107,
		nil,
		1,
		10
	},
	[23002012] = {
		23002012,
		0,
		Lang.get(54856),
		23002,
		12,
		249,
		nil,
		1,
		4
	},
	[23002013] = {
		23002013,
		0,
		Lang.get(54857),
		23002,
		13,
		253,
		nil,
		1,
		4
	},
	[23002014] = {
		23002014,
		0,
		Lang.get(54858),
		23002,
		14,
		107,
		nil,
		1,
		2
	},
	[23002015] = {
		23002015,
		0,
		Lang.get(54859),
		23002,
		15,
		253,
		nil,
		1,
		4
	},
	[23002016] = {
		23002016,
		0,
		Lang.get(55667),
		23002,
		16,
		253,
		nil,
		1,
		4
	},
	[23002017] = {
		23002017,
		0,
		Lang.get(54861),
		23002,
		17,
		249,
		nil,
		1,
		4
	},
	[23002018] = {
		23002018,
		0,
		Lang.get(55668),
		23002,
		18,
		253,
		nil,
		1,
		5
	},
	[23002019] = {
		23002019,
		0,
		Lang.get(54863),
		23002,
		19,
		134,
		nil,
		1,
		4
	},
	[23002020] = {
		23002020,
		0,
		Lang.get(54864),
		23002,
		20,
		141,
		nil,
		1,
		0
	},
	[23002021] = {
		23002021,
		9,
		Lang.get(54865),
		23002,
		21,
		605,
		[22] = 1
	},
	[23003001] = {
		23003001,
		0,
		Lang.get(54866),
		23003,
		1,
		107,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		23070,
		nil,
		1,
		nil,
		nil,
		nil,
		23070
	},
	[23003002] = {
		23003002,
		0,
		Lang.get(54867),
		23003,
		2,
		253,
		nil,
		1,
		3
	},
	[23003003] = {
		23003003,
		0,
		Lang.get(55669),
		23003,
		3,
		253,
		nil,
		1,
		3
	},
	[23004001] = {
		23004001,
		0,
		Lang.get(28429),
		23004,
		1,
		134,
		nil,
		1,
		5,
		nil,
		nil,
		133,
		23007,
		nil,
		1,
		nil,
		nil,
		nil,
		23007
	},
	[23004002] = {
		23004002,
		0,
		Lang.get(54869),
		23004,
		2,
		141,
		nil,
		1,
		0
	},
	[23004003] = {
		23004003,
		0,
		Lang.get(54870),
		23004,
		3,
		107,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3
	},
	[23004004] = {
		23004004,
		0,
		Lang.get(54871),
		23004,
		4,
		141,
		{
			RTResTalkAction[22],
			RTResTalkAction[23]
		}
	},
	[23004005] = {
		23004005,
		0,
		Lang.get(54872),
		23004,
		5,
		141,
		{
			RTResTalkAction[22],
			RTResTalkAction[24]
		}
	},
	[23004006] = {
		23004006,
		0,
		Lang.get(54873),
		23004,
		6,
		249,
		{
			RTResTalkAction[25],
			RTResTalkAction[26],
			RTResTalkAction[27]
		}
	},
	[23004007] = {
		23004007,
		0,
		Lang.get(54874),
		23004,
		7,
		253,
		{
			RTResTalkAction[20],
			RTResTalkAction[16]
		}
	},
	[23004008] = {
		23004008,
		0,
		Lang.get(54875),
		23004,
		8,
		253,
		{
			RTResTalkAction[28],
			RTResTalkAction[16]
		}
	},
	[23004009] = {
		23004009,
		5,
		Lang.get(54876),
		23004,
		9,
		249,
		{
			RTResTalkAction[13],
			RTResTalkAction[29]
		}
	},
	[23004010] = {
		23004010,
		0,
		Lang.get(37821),
		23004,
		10,
		107,
		{
			RTResTalkAction[5],
			RTResTalkAction[17]
		},
		1,
		6,
		nil,
		nil,
		nil,
		23008,
		nil,
		1,
		nil,
		nil,
		nil,
		23008
	},
	[23004011] = {
		23004011,
		0,
		Lang.get(11617),
		23004,
		11,
		300
	},
	[23004012] = {
		23004012,
		0,
		Lang.get(54877),
		23004,
		12,
		141,
		nil,
		1,
		0
	},
	[23004013] = {
		23004013,
		0,
		Lang.get(34583),
		23004,
		13,
		300
	},
	[23004014] = {
		23004014,
		0,
		Lang.get(54878),
		23004,
		14,
		300
	},
	[23004015] = {
		23004015,
		0,
		Lang.get(54879),
		23004,
		15,
		253,
		nil,
		1,
		1
	},
	[23004016] = {
		23004016,
		0,
		Lang.get(54880),
		23004,
		16,
		249,
		nil,
		1,
		3
	},
	[23004017] = {
		23004017,
		0,
		Lang.get(55371),
		23004,
		17,
		300
	},
	[23004018] = {
		23004018,
		0,
		Lang.get(54882),
		23004,
		18,
		300
	},
	[23004019] = {
		23004019,
		0,
		Lang.get(54883),
		23004,
		19,
		300
	},
	[23004020] = {
		23004020,
		0,
		Lang.get(54884),
		23004,
		20,
		300
	},
	[23004021] = {
		23004021,
		0,
		Lang.get(54885),
		23004,
		21,
		253,
		nil,
		1,
		4
	},
	[23005001] = {
		23005001,
		0,
		Lang.get(54886),
		23005,
		1,
		249,
		nil,
		1,
		5,
		nil,
		nil,
		136,
		23009,
		nil,
		1,
		nil,
		nil,
		nil,
		23009
	},
	[23005002] = {
		23005002,
		0,
		Lang.get(54887),
		23005,
		2,
		300
	},
	[23005003] = {
		23005003,
		0,
		Lang.get(54888),
		23005,
		3,
		249,
		nil,
		1,
		4
	},
	[23005004] = {
		23005004,
		0,
		Lang.get(54889),
		23005,
		4,
		300
	},
	[23005005] = {
		23005005,
		0,
		Lang.get(34801),
		23005,
		5,
		253,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3
	},
	[23005006] = {
		23005006,
		0,
		Lang.get(56148),
		23005,
		6,
		249,
		{
			RTResTalkAction[13],
			RTResTalkAction[29]
		}
	},
	[23005007] = {
		23005007,
		0,
		Lang.get(56149),
		23005,
		7,
		253,
		{
			RTResTalkAction[20],
			RTResTalkAction[16]
		}
	},
	[23005008] = {
		23005008,
		0,
		Lang.get(56520),
		23005,
		8,
		300,
		{
			RTResTalkAction[5],
			RTResTalkAction[17]
		}
	},
	[23005009] = {
		23005009,
		0,
		Lang.get(54893),
		23005,
		9,
		249,
		{
			RTResTalkAction[13],
			RTResTalkAction[29]
		}
	},
	[23005010] = {
		23005010,
		0,
		Lang.get(54894),
		23005,
		10,
		249,
		{
			RTResTalkAction[13],
			RTResTalkAction[14]
		}
	},
	[23005011] = {
		23005011,
		0,
		Lang.get(54895),
		23005,
		11,
		253,
		{
			RTResTalkAction[30],
			RTResTalkAction[16]
		}
	},
	[23005012] = {
		23005012,
		0,
		Lang.get(54823),
		23005,
		12,
		249,
		{
			RTResTalkAction[13],
			RTResTalkAction[29]
		}
	},
	[23005013] = {
		23005013,
		0,
		Lang.get(54896),
		23005,
		13,
		253,
		{
			RTResTalkAction[31],
			RTResTalkAction[16]
		}
	},
	[23005014] = {
		23005014,
		0,
		Lang.get(54897),
		23005,
		14,
		249,
		{
			RTResTalkAction[13],
			RTResTalkAction[18]
		}
	},
	[23005015] = {
		23005015,
		0,
		Lang.get(54898),
		23005,
		15,
		300,
		{
			RTResTalkAction[5],
			RTResTalkAction[17]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		23010,
		nil,
		1,
		[19] = 23010
	},
	[23005016] = {
		23005016,
		0,
		Lang.get(54899),
		23005,
		16,
		249,
		nil,
		1,
		0
	},
	[23005017] = {
		23005017,
		0,
		Lang.get(54900),
		23005,
		17,
		300
	},
	[23005018] = {
		23005018,
		0,
		Lang.get(56521),
		23005,
		18,
		249,
		{
			RTResTalkAction[32]
		},
		nil,
		nil,
		3
	},
	[23005019] = {
		23005019,
		0,
		Lang.get(54902),
		23005,
		19,
		300,
		{
			RTResTalkAction[17]
		}
	},
	[23005020] = {
		23005020,
		0,
		Lang.get(54903),
		23005,
		20,
		300
	},
	[23005021] = {
		23005021,
		0,
		Lang.get(54904),
		23005,
		21,
		249,
		{
			RTResTalkAction[33]
		}
	},
	[23005022] = {
		23005022,
		0,
		Lang.get(54905),
		23005,
		22,
		253,
		{
			RTResTalkAction[13],
			RTResTalkAction[16]
		}
	},
	[23005023] = {
		23005023,
		0,
		Lang.get(54906),
		23005,
		23,
		300,
		{
			RTResTalkAction[5],
			RTResTalkAction[17]
		}
	},
	[23005024] = {
		23005024,
		0,
		Lang.get(73540),
		23005,
		24,
		141,
		{
			RTResTalkAction[34]
		}
	},
	[23005025] = {
		23005025,
		0,
		Lang.get(54908),
		23005,
		25,
		107,
		{
			RTResTalkAction[35],
			RTResTalkAction[24]
		}
	},
	[23005026] = {
		23005026,
		0,
		Lang.get(54909),
		23005,
		26,
		107,
		{
			RTResTalkAction[36],
			RTResTalkAction[24]
		}
	},
	[23005027] = {
		23005027,
		0,
		Lang.get(54910),
		23005,
		27,
		253,
		{
			RTResTalkAction[6],
			RTResTalkAction[26],
			RTResTalkAction[27]
		}
	},
	[23005028] = {
		23005028,
		0,
		Lang.get(54911),
		23005,
		28,
		253,
		{
			RTResTalkAction[12]
		}
	},
	[23005029] = {
		23005029,
		0,
		Lang.get(54912),
		23005,
		29,
		253,
		{
			RTResTalkAction[37]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		23011,
		nil,
		1,
		nil,
		nil,
		nil,
		23011
	},
	[23006001] = {
		23006001,
		0,
		Lang.get(54913),
		23006,
		1,
		131,
		nil,
		1,
		0,
		nil,
		nil,
		133,
		23012,
		nil,
		1,
		nil,
		nil,
		nil,
		23012
	},
	[23006002] = {
		23006002,
		0,
		Lang.get(54914),
		23006,
		2,
		253,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3
	},
	[23006003] = {
		23006003,
		0,
		Lang.get(54915),
		23006,
		3,
		131,
		{
			RTResTalkAction[13],
			RTResTalkAction[38]
		}
	},
	[23006004] = {
		23006004,
		0,
		Lang.get(54916),
		23006,
		4,
		107,
		{
			RTResTalkAction[39],
			RTResTalkAction[5],
			RTResTalkAction[40]
		}
	},
	[23006005] = {
		23006005,
		0,
		Lang.get(54917),
		23006,
		5,
		134,
		{
			RTResTalkAction[22],
			RTResTalkAction[41]
		}
	},
	[23006006] = {
		23006006,
		0,
		Lang.get(54918),
		23006,
		6,
		131,
		{
			RTResTalkAction[42],
			RTResTalkAction[26],
			RTResTalkAction[43]
		}
	},
	[23006007] = {
		23006007,
		0,
		Lang.get(54919),
		23006,
		7,
		131,
		{
			RTResTalkAction[42]
		}
	},
	[23006008] = {
		23006008,
		0,
		Lang.get(54920),
		23006,
		8,
		141,
		{
			RTResTalkAction[44],
			RTResTalkAction[40]
		}
	},
	[23006009] = {
		23006009,
		0,
		Lang.get(54921),
		23006,
		9,
		107,
		{
			RTResTalkAction[45],
			RTResTalkAction[24]
		}
	},
	[23006010] = {
		23006010,
		0,
		Lang.get(54922),
		23006,
		10,
		134,
		{
			RTResTalkAction[26],
			RTResTalkAction[27]
		},
		1,
		3,
		nil,
		nil,
		nil,
		23013,
		nil,
		1,
		nil,
		nil,
		nil,
		23013
	},
	[23006011] = {
		23006011,
		0,
		Lang.get(54923),
		23006,
		11,
		141,
		{
			RTResTalkAction[44]
		},
		nil,
		nil,
		3
	},
	[23006012] = {
		23006012,
		0,
		Lang.get(54924),
		23006,
		12,
		131,
		{
			RTResTalkAction[42],
			RTResTalkAction[27]
		}
	},
	[23006013] = {
		23006013,
		0,
		Lang.get(54925),
		23006,
		13,
		131,
		{
			RTResTalkAction[40]
		},
		1,
		0,
		nil,
		nil,
		nil,
		23014,
		nil,
		1,
		nil,
		nil,
		nil,
		23014
	},
	[23006014] = {
		23006014,
		0,
		Lang.get(54926),
		23006,
		14,
		249,
		nil,
		1,
		0
	},
	[23007001] = {
		23007001,
		0,
		Lang.get(54927),
		23007,
		1,
		131,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		23071,
		nil,
		1,
		nil,
		nil,
		nil,
		23071
	},
	[23007002] = {
		23007002,
		0,
		Lang.get(54928),
		23007,
		2,
		249,
		nil,
		1,
		5
	},
	[23007003] = {
		23007003,
		0,
		Lang.get(54929),
		23007,
		3,
		253,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3
	},
	[23007004] = {
		23007004,
		0,
		Lang.get(54930),
		23007,
		4,
		107,
		{
			RTResTalkAction[13],
			RTResTalkAction[46]
		}
	},
	[23007005] = {
		23007005,
		0,
		Lang.get(54931),
		23007,
		5,
		107,
		{
			RTResTalkAction[13],
			RTResTalkAction[47]
		}
	},
	[23007006] = {
		23007006,
		0,
		Lang.get(54932),
		23007,
		6,
		300,
		{
			RTResTalkAction[5],
			RTResTalkAction[26]
		}
	},
	[23007007] = {
		23007007,
		0,
		Lang.get(54933),
		23007,
		7,
		249,
		{
			RTResTalkAction[48]
		}
	},
	[23007008] = {
		23007008,
		0,
		Lang.get(54934),
		23007,
		8,
		131,
		{
			RTResTalkAction[42],
			RTResTalkAction[17]
		}
	},
	[23007009] = {
		23007009,
		0,
		Lang.get(55372),
		23007,
		9,
		249,
		{
			RTResTalkAction[49],
			RTResTalkAction[29]
		}
	},
	[23008001] = {
		23008001,
		0,
		Lang.get(54936),
		23008,
		1,
		131,
		nil,
		1,
		0,
		nil,
		nil,
		62,
		23015,
		nil,
		1,
		nil,
		nil,
		nil,
		23015
	},
	[23008002] = {
		23008002,
		0,
		Lang.get(54937),
		23008,
		2,
		300
	},
	[23008003] = {
		23008003,
		0,
		Lang.get(54939),
		23008,
		3,
		107,
		{
			RTResTalkAction[45],
			RTResTalkAction[16]
		},
		nil,
		nil,
		3
	},
	[23008004] = {
		23008004,
		0,
		Lang.get(54940),
		23008,
		4,
		131,
		{
			RTResTalkAction[42],
			RTResTalkAction[26],
			RTResTalkAction[17]
		}
	},
	[23008005] = {
		23008005,
		0,
		Lang.get(55670),
		23008,
		5,
		134,
		{
			RTResTalkAction[50],
			RTResTalkAction[40]
		}
	},
	[23008006] = {
		23008006,
		0,
		Lang.get(54943),
		23008,
		6,
		131,
		{
			RTResTalkAction[13],
			RTResTalkAction[51],
			RTResTalkAction[43]
		}
	},
	[23008007] = {
		23008007,
		0,
		Lang.get(54944),
		23008,
		7,
		131,
		{
			RTResTalkAction[13],
			RTResTalkAction[51]
		}
	},
	[23008008] = {
		23008008,
		0,
		Lang.get(54945),
		23008,
		8,
		131,
		{
			RTResTalkAction[13],
			RTResTalkAction[51]
		}
	},
	[23008009] = {
		23008009,
		0,
		Lang.get(54946),
		23008,
		9,
		107,
		{
			RTResTalkAction[21],
			RTResTalkAction[5],
			RTResTalkAction[40]
		}
	},
	[23008010] = {
		23008010,
		0,
		Lang.get(54947),
		23008,
		10,
		141,
		{
			RTResTalkAction[22],
			RTResTalkAction[23]
		}
	},
	[23008011] = {
		23008011,
		0,
		Lang.get(54948),
		23008,
		11,
		131,
		{
			RTResTalkAction[42],
			RTResTalkAction[26],
			RTResTalkAction[27]
		}
	},
	[23008012] = {
		23008012,
		0,
		Lang.get(54949),
		23008,
		12,
		131,
		{
			RTResTalkAction[42]
		}
	},
	[23008013] = {
		23008013,
		0,
		Lang.get(55671),
		23008,
		13,
		131,
		{
			RTResTalkAction[42]
		}
	},
	[23008014] = {
		23008014,
		0,
		Lang.get(54951),
		23008,
		14,
		131,
		{
			RTResTalkAction[42]
		}
	},
	[23008015] = {
		23008015,
		0,
		Lang.get(54952),
		23008,
		15,
		131,
		{
			RTResTalkAction[42]
		}
	},
	[23008016] = {
		23008016,
		0,
		Lang.get(54953),
		23008,
		16,
		141,
		{
			RTResTalkAction[40]
		},
		1,
		0,
		nil,
		nil,
		nil,
		23016,
		nil,
		1,
		nil,
		nil,
		nil,
		23016
	},
	[23008017] = {
		23008017,
		0,
		Lang.get(54954),
		23008,
		17,
		141,
		{
			RTResTalkAction[44]
		},
		nil,
		nil,
		3
	},
	[23008018] = {
		23008018,
		0,
		Lang.get(54955),
		23008,
		18,
		131,
		{
			RTResTalkAction[49],
			RTResTalkAction[24]
		}
	},
	[23008019] = {
		23008019,
		0,
		Lang.get(54956),
		23008,
		19,
		300,
		{
			RTResTalkAction[40],
			RTResTalkAction[27]
		}
	},
	[23008020] = {
		23008020,
		0,
		Lang.get(54957),
		23008,
		20,
		131,
		{
			RTResTalkAction[42]
		}
	},
	[23008021] = {
		23008021,
		0,
		Lang.get(54958),
		23008,
		21,
		131,
		{
			RTResTalkAction[49],
			RTResTalkAction[16]
		}
	},
	[23008022] = {
		23008022,
		0,
		Lang.get(54959),
		23008,
		22,
		300,
		{
			RTResTalkAction[40],
			RTResTalkAction[17]
		}
	},
	[23008023] = {
		23008023,
		0,
		Lang.get(54960),
		23008,
		23,
		131,
		{
			RTResTalkAction[52],
			RTResTalkAction[16]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		23017,
		nil,
		1,
		[19] = 23017
	},
	[23008024] = {
		23008024,
		0,
		Lang.get(21987),
		23008,
		24,
		300,
		{
			RTResTalkAction[49],
			RTResTalkAction[16]
		}
	},
	[23008025] = {
		23008025,
		0,
		Lang.get(54961),
		23008,
		25,
		131,
		{
			RTResTalkAction[49],
			RTResTalkAction[16]
		},
		nil,
		nil,
		3,
		nil,
		63
	},
	[23008026] = {
		23008026,
		0,
		Lang.get(54962),
		23008,
		26,
		300,
		{
			RTResTalkAction[49],
			RTResTalkAction[16]
		}
	},
	[23008027] = {
		23008027,
		0,
		Lang.get(54963),
		23008,
		27,
		131,
		{
			RTResTalkAction[49],
			RTResTalkAction[16]
		}
	},
	[23008028] = {
		23008028,
		0,
		Lang.get(54964),
		23008,
		28,
		249,
		{
			RTResTalkAction[49],
			RTResTalkAction[29]
		}
	},
	[23008029] = {
		23008029,
		0,
		Lang.get(54965),
		23008,
		29,
		249,
		{
			RTResTalkAction[48],
			RTResTalkAction[40]
		}
	},
	[23008030] = {
		23008030,
		0,
		Lang.get(54966),
		23008,
		30,
		249,
		{
			RTResTalkAction[33]
		}
	},
	[23008031] = {
		23008031,
		0,
		Lang.get(55672),
		23008,
		31,
		249,
		{
			RTResTalkAction[13],
			RTResTalkAction[14]
		}
	},
	[23009001] = {
		23009001,
		0,
		Lang.get(54971),
		23009,
		1,
		253,
		nil,
		1,
		4,
		nil,
		nil,
		57,
		23018,
		nil,
		1,
		nil,
		nil,
		nil,
		23018
	},
	[23009002] = {
		23009002,
		0,
		Lang.get(54972),
		23009,
		2,
		131,
		nil,
		1,
		0
	},
	[23009003] = {
		23009003,
		0,
		Lang.get(54973),
		23009,
		3,
		249,
		{
			RTResTalkAction[53]
		},
		nil,
		nil,
		3
	},
	[23009004] = {
		23009004,
		0,
		Lang.get(54974),
		23009,
		4,
		249,
		{
			RTResTalkAction[48]
		}
	},
	[23009005] = {
		23009005,
		0,
		Lang.get(54975),
		23009,
		5,
		131,
		{
			RTResTalkAction[49],
			RTResTalkAction[16]
		}
	},
	[23009006] = {
		23009006,
		0,
		Lang.get(54976),
		23009,
		6,
		131,
		{
			RTResTalkAction[42],
			RTResTalkAction[17]
		}
	},
	[23009007] = {
		23009007,
		0,
		Lang.get(54977),
		23009,
		7,
		131,
		{
			RTResTalkAction[42]
		}
	},
	[23009008] = {
		23009008,
		0,
		Lang.get(54978),
		23009,
		8,
		131,
		{
			RTResTalkAction[42]
		}
	},
	[23009009] = {
		23009009,
		0,
		Lang.get(54979),
		23009,
		9,
		134,
		{
			RTResTalkAction[40]
		},
		1,
		1,
		nil,
		nil,
		nil,
		23019,
		nil,
		1,
		nil,
		nil,
		nil,
		23019
	},
	[23009010] = {
		23009010,
		0,
		Lang.get(54980),
		23009,
		10,
		131,
		{
			RTResTalkAction[42]
		},
		nil,
		nil,
		3
	},
	[23009011] = {
		23009011,
		0,
		Lang.get(54981),
		23009,
		11,
		131,
		{
			RTResTalkAction[42]
		}
	},
	[23009012] = {
		23009012,
		0,
		Lang.get(54982),
		23009,
		12,
		141,
		{
			RTResTalkAction[49],
			RTResTalkAction[24]
		}
	},
	[23009013] = {
		23009013,
		0,
		Lang.get(54983),
		23009,
		13,
		249,
		{
			RTResTalkAction[32],
			RTResTalkAction[40],
			RTResTalkAction[27]
		}
	},
	[23009014] = {
		23009014,
		0,
		Lang.get(54984),
		23009,
		14,
		107,
		{
			RTResTalkAction[35],
			RTResTalkAction[16]
		}
	},
	[23009015] = {
		23009015,
		0,
		Lang.get(54985),
		23009,
		15,
		253,
		{
			RTResTalkAction[22],
			RTResTalkAction[54],
			RTResTalkAction[17]
		}
	},
	[23009016] = {
		23009016,
		0,
		Lang.get(54986),
		23009,
		16,
		107,
		{
			RTResTalkAction[55],
			RTResTalkAction[56]
		}
	},
	[23009017] = {
		23009017,
		0,
		Lang.get(54987),
		23009,
		17,
		131,
		{
			RTResTalkAction[42],
			RTResTalkAction[26],
			RTResTalkAction[5]
		}
	},
	[23009018] = {
		23009018,
		0,
		Lang.get(54988),
		23009,
		18,
		131,
		{
			RTResTalkAction[42]
		}
	},
	[23009019] = {
		23009019,
		0,
		Lang.get(54989),
		23009,
		19,
		131,
		{
			RTResTalkAction[42]
		}
	},
	[23009020] = {
		23009020,
		0,
		Lang.get(54990),
		23009,
		20,
		131,
		{
			RTResTalkAction[42]
		}
	},
	[23009021] = {
		23009021,
		0,
		Lang.get(54991),
		23009,
		21,
		141,
		{
			RTResTalkAction[49],
			RTResTalkAction[57]
		}
	},
	[23009022] = {
		23009022,
		0,
		Lang.get(54992),
		23009,
		22,
		141,
		{
			RTResTalkAction[49],
			RTResTalkAction[23]
		}
	},
	[23009023] = {
		23009023,
		0,
		Lang.get(54993),
		23009,
		23,
		300,
		{
			RTResTalkAction[40],
			RTResTalkAction[27]
		}
	},
	[23009024] = {
		23009024,
		0,
		Lang.get(54994),
		23009,
		24,
		249,
		{
			RTResTalkAction[33]
		}
	},
	[23009025] = {
		23009025,
		0,
		Lang.get(54995),
		23009,
		25,
		249,
		{
			RTResTalkAction[48]
		}
	},
	[23010001] = {
		23010001,
		0,
		Lang.get(54996),
		23010,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		132,
		23072,
		nil,
		1,
		nil,
		nil,
		nil,
		23072
	},
	[23010002] = {
		23010002,
		0,
		Lang.get(54997),
		23010,
		2,
		253,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3
	},
	[23010003] = {
		23010003,
		0,
		Lang.get(54998),
		23010,
		3,
		249,
		{
			RTResTalkAction[13],
			RTResTalkAction[14]
		}
	},
	[23010004] = {
		23010004,
		0,
		Lang.get(54999),
		23010,
		4,
		249,
		{
			RTResTalkAction[13],
			RTResTalkAction[14]
		}
	},
	[23010005] = {
		23010005,
		0,
		Lang.get(55000),
		23010,
		5,
		249,
		{
			RTResTalkAction[13],
			RTResTalkAction[29]
		}
	},
	[23010006] = {
		23010006,
		0,
		Lang.get(55001),
		23010,
		6,
		249,
		{
			RTResTalkAction[13],
			RTResTalkAction[58]
		}
	},
	[23010007] = {
		23010007,
		0,
		Lang.get(55002),
		23010,
		7,
		249,
		{
			RTResTalkAction[13],
			RTResTalkAction[18]
		}
	},
	[23010008] = {
		23010008,
		0,
		Lang.get(55003),
		23010,
		8,
		107,
		{
			RTResTalkAction[5],
			RTResTalkAction[17]
		},
		1,
		6,
		nil,
		nil,
		nil,
		23020,
		nil,
		1,
		nil,
		nil,
		nil,
		23020
	},
	[23010009] = {
		23010009,
		0,
		Lang.get(55004),
		23010,
		9,
		300
	},
	[23010010] = {
		23010010,
		0,
		Lang.get(55005),
		23010,
		10,
		249,
		nil,
		1,
		1
	},
	[23010011] = {
		23010011,
		0,
		Lang.get(55006),
		23010,
		11,
		249,
		nil,
		1,
		2
	},
	[23010012] = {
		23010012,
		0,
		Lang.get(56954),
		23010,
		12,
		249,
		nil,
		1,
		5
	},
	[23010013] = {
		23010013,
		0,
		Lang.get(55008),
		23010,
		13,
		253,
		nil,
		1,
		1
	},
	[23010014] = {
		23010014,
		0,
		Lang.get(55673),
		23010,
		14,
		253,
		nil,
		1,
		3
	},
	[23010015] = {
		23010015,
		0,
		Lang.get(55010),
		23010,
		15,
		253,
		nil,
		1,
		2
	},
	[23010016] = {
		23010016,
		0,
		Lang.get(55011),
		23010,
		16,
		249,
		nil,
		1,
		1
	},
	[23010017] = {
		23010017,
		0,
		Lang.get(56955),
		23010,
		17,
		249,
		nil,
		1,
		4
	},
	[23010018] = {
		23010018,
		0,
		Lang.get(55013),
		23010,
		18,
		249,
		nil,
		1,
		5
	},
	[23010019] = {
		23010019,
		0,
		Lang.get(55014),
		23010,
		19,
		253,
		nil,
		1,
		3
	},
	[23010020] = {
		23010020,
		0,
		Lang.get(55015),
		23010,
		20,
		253,
		nil,
		1,
		5
	},
	[23010021] = {
		23010021,
		0,
		Lang.get(55016),
		23010,
		21,
		249,
		nil,
		1,
		4
	},
	[23010022] = {
		23010022,
		0,
		Lang.get(55017),
		23010,
		22,
		300
	},
	[23010023] = {
		23010023,
		0,
		Lang.get(55018),
		23010,
		23,
		249,
		nil,
		1,
		3
	},
	[23010024] = {
		23010024,
		0,
		Lang.get(55019),
		23010,
		24,
		249,
		nil,
		1,
		2
	},
	[23011001] = {
		23011001,
		0,
		Lang.get(55020),
		23011,
		1,
		46,
		nil,
		1,
		0,
		nil,
		nil,
		59,
		23021,
		nil,
		1,
		nil,
		nil,
		nil,
		23021
	},
	[23011002] = {
		23011002,
		0,
		Lang.get(55021),
		23011,
		2,
		131,
		nil,
		1,
		0
	},
	[23011003] = {
		23011003,
		0,
		Lang.get(24800),
		23011,
		3,
		46,
		{
			RTResTalkAction[59]
		},
		nil,
		nil,
		3
	},
	[23011004] = {
		23011004,
		0,
		Lang.get(23071),
		23011,
		4,
		131,
		{
			RTResTalkAction[60],
			RTResTalkAction[51]
		}
	},
	[23011005] = {
		23011005,
		0,
		Lang.get(55022),
		23011,
		5,
		46,
		{
			RTResTalkAction[60],
			RTResTalkAction[51]
		}
	},
	[23011006] = {
		23011006,
		0,
		Lang.get(55023),
		23011,
		6,
		131,
		{
			RTResTalkAction[60],
			RTResTalkAction[51]
		}
	},
	[23011007] = {
		23011007,
		0,
		Lang.get(55024),
		23011,
		7,
		46,
		{
			RTResTalkAction[60],
			RTResTalkAction[51]
		}
	},
	[23011008] = {
		23011008,
		0,
		Lang.get(55025),
		23011,
		8,
		46,
		{
			RTResTalkAction[60],
			RTResTalkAction[51]
		}
	},
	[23011009] = {
		23011009,
		0,
		Lang.get(55026),
		23011,
		9,
		131,
		{
			RTResTalkAction[60],
			RTResTalkAction[51]
		}
	},
	[23011010] = {
		23011010,
		0,
		Lang.get(55027),
		23011,
		10,
		46,
		{
			RTResTalkAction[60],
			RTResTalkAction[51]
		}
	},
	[23011011] = {
		23011011,
		0,
		Lang.get(55028),
		23011,
		11,
		131,
		{
			RTResTalkAction[60],
			RTResTalkAction[51]
		}
	},
	[23011012] = {
		23011012,
		0,
		Lang.get(55029),
		23011,
		12,
		107,
		{
			RTResTalkAction[61],
			RTResTalkAction[40]
		},
		1,
		3,
		nil,
		nil,
		nil,
		23022,
		nil,
		1,
		nil,
		nil,
		nil,
		23022
	},
	[23011013] = {
		23011013,
		0,
		Lang.get(55030),
		23011,
		13,
		141,
		nil,
		1,
		0
	},
	[23011014] = {
		23011014,
		0,
		Lang.get(55031),
		23011,
		14,
		134,
		nil,
		1,
		3
	},
	[23011015] = {
		23011015,
		0,
		Lang.get(55032),
		23011,
		15,
		300
	},
	[23011016] = {
		23011016,
		0,
		Lang.get(55033),
		23011,
		16,
		107,
		nil,
		1,
		10,
		nil,
		nil,
		nil,
		23023,
		nil,
		1,
		nil,
		nil,
		nil,
		23023
	},
	[23011017] = {
		23011017,
		0,
		Lang.get(55034),
		23011,
		17,
		300
	},
	[23011018] = {
		23011018,
		0,
		Lang.get(55035),
		23011,
		18,
		300
	},
	[23011019] = {
		23011019,
		0,
		Lang.get(55036),
		23011,
		19,
		249,
		nil,
		1,
		1,
		nil,
		nil,
		63,
		23024,
		nil,
		1,
		nil,
		1,
		nil,
		23024
	},
	[23011020] = {
		23011020,
		0,
		Lang.get(55037),
		23011,
		20,
		249,
		nil,
		1,
		2
	},
	[23011021] = {
		23011021,
		0,
		Lang.get(55038),
		23011,
		21,
		249,
		nil,
		1,
		3
	},
	[23011022] = {
		23011022,
		0,
		Lang.get(55039),
		23011,
		22,
		249,
		nil,
		1,
		0
	},
	[23012001] = {
		23012001,
		0,
		Lang.get(55040),
		23012,
		1,
		107,
		nil,
		1,
		1,
		nil,
		nil,
		160,
		23057,
		nil,
		nil,
		nil,
		nil,
		nil,
		23057
	},
	[23012002] = {
		23012002,
		0,
		Lang.get(55041),
		23012,
		2,
		107,
		nil,
		1,
		2
	},
	[23012003] = {
		23012003,
		0,
		Lang.get(55042),
		23012,
		3,
		134,
		nil,
		1,
		4
	},
	[23012004] = {
		23012004,
		0,
		Lang.get(55043),
		23012,
		4,
		300
	},
	[23012005] = {
		23012005,
		0,
		Lang.get(55044),
		23012,
		5,
		107,
		{
			RTResTalkAction[62]
		},
		nil,
		nil,
		3
	},
	[23012006] = {
		23012006,
		0,
		Lang.get(55045),
		23012,
		6,
		141,
		{
			RTResTalkAction[22],
			RTResTalkAction[63]
		}
	},
	[23012007] = {
		23012007,
		0,
		Lang.get(55046),
		23012,
		7,
		107,
		{
			RTResTalkAction[64],
			RTResTalkAction[27]
		}
	},
	[23012008] = {
		23012008,
		0,
		Lang.get(55047),
		23012,
		8,
		107,
		{
			RTResTalkAction[21]
		}
	},
	[23012009] = {
		23012009,
		0,
		Lang.get(55048),
		23012,
		9,
		107,
		{
			RTResTalkAction[65]
		}
	},
	[23012010] = {
		23012010,
		0,
		Lang.get(55049),
		23012,
		10,
		134,
		{
			RTResTalkAction[22],
			RTResTalkAction[41]
		}
	},
	[23012011] = {
		23012011,
		0,
		Lang.get(55050),
		23012,
		11,
		107,
		{
			RTResTalkAction[66],
			RTResTalkAction[67]
		}
	},
	[23012012] = {
		23012012,
		0,
		Lang.get(55051),
		23012,
		12,
		134,
		{
			RTResTalkAction[22],
			RTResTalkAction[67]
		}
	},
	[23012013] = {
		23012013,
		0,
		Lang.get(55052),
		23012,
		13,
		300,
		{
			RTResTalkAction[26],
			RTResTalkAction[43]
		}
	},
	[23012014] = {
		23012014,
		0,
		Lang.get(55053),
		23012,
		14,
		141,
		{
			RTResTalkAction[34]
		}
	},
	[23012015] = {
		23012015,
		0,
		Lang.get(55054),
		23012,
		15,
		300,
		{
			RTResTalkAction[27]
		}
	},
	[23012016] = {
		23012016,
		0,
		Lang.get(34842),
		23012,
		16,
		134,
		{
			RTResTalkAction[68]
		}
	},
	[23012017] = {
		23012017,
		0,
		Lang.get(55055),
		23012,
		17,
		141,
		{
			RTResTalkAction[69],
			RTResTalkAction[43]
		}
	},
	[23012018] = {
		23012018,
		0,
		Lang.get(55056),
		23012,
		18,
		107,
		{
			RTResTalkAction[70],
			RTResTalkAction[71]
		}
	},
	[23012019] = {
		23012019,
		0,
		Lang.get(55057),
		23012,
		19,
		630,
		{
			RTResTalkAction[27],
			RTResTalkAction[26]
		},
		1,
		0,
		nil,
		nil,
		57,
		23025,
		nil,
		nil,
		nil,
		nil,
		nil,
		23025
	},
	[23012020] = {
		23012020,
		0,
		Lang.get(55058),
		23012,
		20,
		251,
		{
			RTResTalkAction[72]
		},
		nil,
		nil,
		3
	},
	[23012021] = {
		23012021,
		0,
		Lang.get(55059),
		23012,
		21,
		251,
		{
			RTResTalkAction[49],
			RTResTalkAction[73]
		}
	},
	[23012022] = {
		23012022,
		0,
		Lang.get(55060),
		23012,
		22,
		630,
		{
			RTResTalkAction[49],
			RTResTalkAction[73]
		}
	},
	[23012023] = {
		23012023,
		0,
		Lang.get(55061),
		23012,
		23,
		251,
		{
			RTResTalkAction[49],
			RTResTalkAction[73]
		}
	},
	[23012024] = {
		23012024,
		0,
		Lang.get(55062),
		23012,
		24,
		630,
		{
			RTResTalkAction[40],
			RTResTalkAction[74]
		},
		1,
		0,
		nil,
		nil,
		nil,
		23058,
		nil,
		nil,
		nil,
		nil,
		nil,
		23058
	},
	[23012025] = {
		23012025,
		0,
		Lang.get(55063),
		23012,
		25,
		251,
		{
			RTResTalkAction[72]
		},
		nil,
		nil,
		3
	},
	[23013001] = {
		23013001,
		0,
		Lang.get(55064),
		23013,
		1,
		107,
		nil,
		1,
		0,
		nil,
		nil,
		60,
		23026,
		nil,
		nil,
		nil,
		nil,
		nil,
		23026
	},
	[23013002] = {
		23013002,
		0,
		Lang.get(55065),
		23013,
		2,
		134,
		nil,
		1,
		0
	},
	[23013003] = {
		23013003,
		0,
		Lang.get(55066),
		23013,
		3,
		141,
		{
			RTResTalkAction[34]
		},
		nil,
		nil,
		3
	},
	[23013004] = {
		23013004,
		0,
		Lang.get(55067),
		23013,
		4,
		141,
		{
			RTResTalkAction[34]
		}
	},
	[23013005] = {
		23013005,
		0,
		Lang.get(55068),
		23013,
		5,
		141,
		{
			RTResTalkAction[34]
		}
	},
	[23013006] = {
		23013006,
		0,
		Lang.get(55069),
		23013,
		6,
		141,
		{
			RTResTalkAction[34]
		}
	},
	[23013007] = {
		23013007,
		0,
		Lang.get(55070),
		23013,
		7,
		107,
		{
			RTResTalkAction[70],
			RTResTalkAction[75]
		}
	},
	[23013008] = {
		23013008,
		0,
		Lang.get(55071),
		23013,
		8,
		134,
		{
			RTResTalkAction[76],
			RTResTalkAction[77],
			RTResTalkAction[27]
		}
	},
	[23013009] = {
		23013009,
		0,
		Lang.get(55072),
		23013,
		9,
		141,
		{
			RTResTalkAction[34],
			RTResTalkAction[43],
			RTResTalkAction[26]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		23027,
		[19] = 23027
	},
	[23013010] = {
		23013010,
		0,
		Lang.get(55073),
		23013,
		10,
		107,
		{
			RTResTalkAction[70],
			RTResTalkAction[77]
		}
	},
	[23013011] = {
		23013011,
		0,
		Lang.get(55074),
		23013,
		11,
		141,
		{
			RTResTalkAction[27],
			RTResTalkAction[26]
		},
		1,
		0
	},
	[23013012] = {
		23013012,
		0,
		Lang.get(55075),
		23013,
		12,
		107,
		{
			RTResTalkAction[62]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		23028,
		[19] = 23028
	},
	[23013013] = {
		23013013,
		0,
		Lang.get(55076),
		23013,
		13,
		107,
		{
			RTResTalkAction[64]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		23059,
		[19] = 23059
	},
	[23013014] = {
		23013014,
		0,
		Lang.get(55077),
		23013,
		14,
		134,
		{
			RTResTalkAction[22],
			RTResTalkAction[78]
		},
		nil,
		nil,
		3
	},
	[23013015] = {
		23013015,
		0,
		Lang.get(55078),
		23013,
		15,
		107,
		{
			RTResTalkAction[79],
			RTResTalkAction[43]
		}
	},
	[23013016] = {
		23013016,
		0,
		Lang.get(55079),
		23013,
		16,
		107,
		{
			RTResTalkAction[64]
		}
	},
	[23013017] = {
		23013017,
		0,
		Lang.get(56522),
		23013,
		17,
		141,
		{
			RTResTalkAction[22],
			RTResTalkAction[24]
		}
	},
	[23013018] = {
		23013018,
		0,
		Lang.get(55081),
		23013,
		18,
		141,
		{
			RTResTalkAction[22],
			RTResTalkAction[24]
		}
	},
	[23013019] = {
		23013019,
		0,
		Lang.get(56523),
		23013,
		19,
		141,
		{
			RTResTalkAction[22],
			RTResTalkAction[24]
		}
	},
	[23014001] = {
		23014001,
		0,
		Lang.get(55083),
		23014,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		23029,
		[19] = 23029
	},
	[23014002] = {
		23014002,
		0,
		Lang.get(55674),
		23014,
		2,
		69,
		{
			RTResTalkAction[4]
		}
	},
	[23014003] = {
		23014003,
		0,
		Lang.get(55085),
		23014,
		3,
		69,
		{
			RTResTalkAction[4]
		},
		nil,
		nil,
		3
	},
	[23014004] = {
		23014004,
		0,
		Lang.get(37474),
		23014,
		4,
		69,
		{
			RTResTalkAction[4]
		}
	},
	[23014005] = {
		23014005,
		0,
		Lang.get(37906),
		23014,
		5,
		16,
		{
			RTResTalkAction[80],
			RTResTalkAction[7]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		23030,
		[19] = 23030
	},
	[23014006] = {
		23014006,
		0,
		Lang.get(55086),
		23014,
		6,
		249,
		{
			RTResTalkAction[81],
			RTResTalkAction[82]
		}
	},
	[23014007] = {
		23014007,
		0,
		Lang.get(55087),
		23014,
		7,
		249,
		{
			RTResTalkAction[83]
		},
		1,
		3
	},
	[23014008] = {
		23014008,
		0,
		Lang.get(55088),
		23014,
		8,
		16,
		{
			RTResTalkAction[84]
		},
		1,
		0,
		nil,
		nil,
		nil,
		23080,
		nil,
		nil,
		nil,
		nil,
		nil,
		23080
	},
	[23014009] = {
		23014009,
		0,
		Lang.get(55089),
		23014,
		9,
		249,
		{
			RTResTalkAction[82]
		},
		1,
		5,
		nil,
		nil,
		nil,
		23031,
		nil,
		nil,
		nil,
		nil,
		nil,
		23031
	},
	[23014010] = {
		23014010,
		0,
		Lang.get(55090),
		23014,
		10,
		249,
		nil,
		1,
		5
	},
	[23014011] = {
		23014011,
		0,
		Lang.get(54135),
		23014,
		11,
		63,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		23032,
		nil,
		nil,
		nil,
		nil,
		nil,
		23032
	},
	[23014012] = {
		23014012,
		0,
		Lang.get(55675),
		23014,
		12,
		63,
		nil,
		1,
		0
	},
	[23014013] = {
		23014013,
		0,
		Lang.get(55676),
		23014,
		13,
		63,
		nil,
		1,
		0
	},
	[23014014] = {
		23014014,
		0,
		Lang.get(55677),
		23014,
		14,
		249,
		{
			RTResTalkAction[80]
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
		16
	},
	[23014015] = {
		23014015,
		0,
		Lang.get(55678),
		23014,
		15,
		63,
		{
			RTResTalkAction[85],
			RTResTalkAction[86]
		},
		1,
		0
	},
	[23014016] = {
		23014016,
		0,
		Lang.get(55679),
		23014,
		16,
		249,
		{
			RTResTalkAction[85],
			RTResTalkAction[87]
		},
		1,
		0,
		[21] = 16
	},
	[23014017] = {
		23014017,
		0,
		Lang.get(55680),
		23014,
		17,
		63,
		{
			RTResTalkAction[85],
			RTResTalkAction[87]
		},
		1,
		0
	},
	[23014018] = {
		23014018,
		0,
		Lang.get(55681),
		23014,
		18,
		63,
		{
			RTResTalkAction[82],
			RTResTalkAction[88]
		},
		1,
		0
	},
	[23014019] = {
		23014019,
		0,
		Lang.get(55682),
		23014,
		19,
		63,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		23081,
		nil,
		nil,
		nil,
		nil,
		nil,
		23081
	},
	[23014020] = {
		23014020,
		0,
		Lang.get(55683),
		23014,
		20,
		249,
		nil,
		1,
		4,
		[21] = 16
	},
	[23014021] = {
		23014021,
		0,
		Lang.get(55684),
		23014,
		21,
		249,
		nil,
		1,
		4,
		[21] = 16
	},
	[23014022] = {
		23014022,
		0,
		Lang.get(55685),
		23014,
		22,
		249,
		nil,
		1,
		4,
		[21] = 16
	},
	[23014023] = {
		23014023,
		0,
		Lang.get(55686),
		23014,
		23,
		249,
		nil,
		1,
		4,
		[21] = 16
	},
	[23015001] = {
		23015001,
		0,
		Lang.get(55687),
		23015,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		23034,
		[19] = 23034
	},
	[23015002] = {
		23015002,
		0,
		Lang.get(55109),
		23015,
		2,
		249,
		nil,
		1,
		3
	},
	[23015003] = {
		23015003,
		0,
		Lang.get(55110),
		23015,
		3,
		249,
		nil,
		1,
		3
	},
	[23015004] = {
		23015004,
		0,
		Lang.get(55111),
		23015,
		4,
		249,
		nil,
		1,
		3
	},
	[23016001] = {
		23016001,
		0,
		Lang.get(55112),
		23016,
		1,
		249,
		nil,
		1,
		0,
		nil,
		nil,
		63,
		23035,
		nil,
		nil,
		nil,
		nil,
		nil,
		23035
	},
	[23016002] = {
		23016002,
		0,
		Lang.get(55113),
		23016,
		2,
		673,
		{
			RTResTalkAction[85],
			RTResTalkAction[89]
		},
		nil,
		nil,
		3
	},
	[23016003] = {
		23016003,
		0,
		Lang.get(55688),
		23016,
		3,
		249,
		{
			RTResTalkAction[85],
			RTResTalkAction[89]
		},
		1,
		1,
		[21] = 16
	},
	[23016004] = {
		23016004,
		0,
		Lang.get(55689),
		23016,
		4,
		673,
		{
			RTResTalkAction[90],
			RTResTalkAction[82]
		}
	},
	[23017001] = {
		23017001,
		0,
		Lang.get(55690),
		23017,
		1,
		249,
		nil,
		1,
		4,
		nil,
		nil,
		60,
		23036,
		nil,
		nil,
		nil,
		nil,
		nil,
		23036
	},
	[23017002] = {
		23017002,
		0,
		Lang.get(55691),
		23017,
		2,
		253,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3
	},
	[23017003] = {
		23017003,
		0,
		Lang.get(55118),
		23017,
		3,
		249,
		{
			RTResTalkAction[91],
			RTResTalkAction[56]
		}
	},
	[23017004] = {
		23017004,
		0,
		Lang.get(55119),
		23017,
		4,
		249,
		{
			RTResTalkAction[91],
			RTResTalkAction[56]
		}
	},
	[23017005] = {
		23017005,
		0,
		Lang.get(55120),
		23017,
		5,
		253,
		{
			RTResTalkAction[91],
			RTResTalkAction[92]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		23082,
		[19] = 23082
	},
	[23017006] = {
		23017006,
		0,
		Lang.get(55121),
		23017,
		6,
		249,
		{
			RTResTalkAction[93],
			RTResTalkAction[56]
		}
	},
	[23017007] = {
		23017007,
		0,
		Lang.get(55122),
		23017,
		7,
		253,
		{
			RTResTalkAction[91],
			RTResTalkAction[92]
		}
	},
	[23017008] = {
		23017008,
		0,
		Lang.get(55123),
		23017,
		8,
		249,
		{
			RTResTalkAction[91],
			RTResTalkAction[56]
		}
	},
	[23017009] = {
		23017009,
		0,
		Lang.get(55124),
		23017,
		9,
		253,
		{
			RTResTalkAction[91],
			RTResTalkAction[56]
		}
	},
	[23017010] = {
		23017010,
		0,
		Lang.get(55125),
		23017,
		10,
		673,
		{
			RTResTalkAction[17],
			RTResTalkAction[5]
		},
		1,
		0,
		nil,
		nil,
		57,
		23037,
		nil,
		nil,
		nil,
		nil,
		nil,
		23037
	},
	[23017011] = {
		23017011,
		0,
		Lang.get(55126),
		23017,
		11,
		673,
		{
			RTResTalkAction[94]
		},
		nil,
		nil,
		3
	},
	[23017012] = {
		23017012,
		0,
		Lang.get(55127),
		23017,
		12,
		673,
		{
			RTResTalkAction[94]
		}
	},
	[23017013] = {
		23017013,
		0,
		Lang.get(55128),
		23017,
		13,
		249,
		{
			RTResTalkAction[33],
			RTResTalkAction[95]
		}
	},
	[23017014] = {
		23017014,
		0,
		Lang.get(55129),
		23017,
		14,
		249,
		{
			RTResTalkAction[33]
		}
	},
	[23017015] = {
		23017015,
		0,
		Lang.get(55130),
		23017,
		15,
		673,
		{
			RTResTalkAction[94],
			RTResTalkAction[17]
		}
	},
	[23017016] = {
		23017016,
		0,
		Lang.get(55131),
		23017,
		16,
		673,
		{
			RTResTalkAction[94]
		}
	},
	[23018001] = {
		23018001,
		0,
		Lang.get(55132),
		23018,
		1,
		673,
		nil,
		1,
		0,
		nil,
		nil,
		57,
		23038,
		nil,
		nil,
		nil,
		nil,
		nil,
		23038
	},
	[23018002] = {
		23018002,
		0,
		"……",
		23018,
		2,
		253,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		23083,
		nil,
		nil,
		nil,
		nil,
		nil,
		23083
	},
	[23018003] = {
		23018003,
		0,
		Lang.get(55133),
		23018,
		3,
		249,
		nil,
		1,
		0
	},
	[23018004] = {
		23018004,
		0,
		Lang.get(55134),
		23018,
		4,
		673,
		{
			RTResTalkAction[94]
		},
		nil,
		nil,
		3
	},
	[23018005] = {
		23018005,
		0,
		Lang.get(55135),
		23018,
		5,
		673,
		{
			RTResTalkAction[94]
		}
	},
	[23018006] = {
		23018006,
		0,
		Lang.get(55136),
		23018,
		6,
		673,
		{
			RTResTalkAction[94]
		}
	},
	[23018007] = {
		23018007,
		0,
		Lang.get(55137),
		23018,
		7,
		673,
		{
			RTResTalkAction[94]
		}
	},
	[23018008] = {
		23018008,
		0,
		Lang.get(55138),
		23018,
		8,
		249,
		{
			RTResTalkAction[95]
		},
		1,
		0,
		-1
	},
	[23018009] = {
		23018009,
		0,
		Lang.get(55139),
		23018,
		9,
		253,
		nil,
		1,
		4,
		nil,
		nil,
		nil,
		23090,
		nil,
		nil,
		nil,
		nil,
		nil,
		23090
	},
	[23019001] = {
		23019001,
		0,
		Lang.get(55140),
		23019,
		1,
		673,
		nil,
		1,
		0,
		3,
		nil,
		62,
		23039,
		nil,
		nil,
		nil,
		nil,
		nil,
		23039
	},
	[23019002] = {
		23019002,
		0,
		Lang.get(55141),
		23019,
		2,
		673,
		nil,
		1,
		0
	},
	[23019003] = {
		23019003,
		0,
		Lang.get(55142),
		23019,
		3,
		107,
		{
			RTResTalkAction[96]
		}
	},
	[23019004] = {
		23019004,
		0,
		Lang.get(55143),
		23019,
		4,
		673,
		{
			RTResTalkAction[94],
			RTResTalkAction[26]
		}
	},
	[23019005] = {
		23019005,
		0,
		Lang.get(55144),
		23019,
		5,
		249,
		{
			RTResTalkAction[32],
			RTResTalkAction[95]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		23040,
		[19] = 23040
	},
	[23019006] = {
		23019006,
		0,
		Lang.get(55145),
		23019,
		6,
		249,
		{
			RTResTalkAction[32]
		},
		nil,
		nil,
		3
	},
	[23019007] = {
		23019007,
		0,
		Lang.get(55146),
		23019,
		7,
		141,
		{
			RTResTalkAction[91],
			RTResTalkAction[24]
		}
	},
	[23019008] = {
		23019008,
		0,
		Lang.get(55147),
		23019,
		8,
		141,
		{
			RTResTalkAction[91],
			RTResTalkAction[24]
		}
	},
	[23019009] = {
		23019009,
		0,
		Lang.get(55148),
		23019,
		9,
		249,
		{
			RTResTalkAction[97],
			RTResTalkAction[56],
			RTResTalkAction[27]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		23041,
		[19] = 23041
	},
	[23019010] = {
		23019010,
		0,
		Lang.get(55149),
		23019,
		10,
		253,
		{
			RTResTalkAction[91],
			RTResTalkAction[98]
		}
	},
	[23019011] = {
		23019011,
		0,
		Lang.get(55150),
		23019,
		11,
		673,
		{
			RTResTalkAction[90],
			RTResTalkAction[17],
			RTResTalkAction[5]
		}
	},
	[23019012] = {
		23019012,
		0,
		Lang.get(55151),
		23019,
		12,
		253,
		{
			RTResTalkAction[3],
			RTResTalkAction[95]
		}
	},
	[23019013] = {
		23019013,
		0,
		Lang.get(55152),
		23019,
		13,
		253,
		{
			RTResTalkAction[3]
		}
	},
	[23019014] = {
		23019014,
		0,
		Lang.get(55153),
		23019,
		14,
		249,
		{
			RTResTalkAction[32],
			RTResTalkAction[5]
		}
	},
	[23019015] = {
		23019015,
		0,
		Lang.get(55154),
		23019,
		15,
		249,
		{
			RTResTalkAction[32]
		}
	},
	[23019016] = {
		23019016,
		0,
		"……",
		23019,
		16,
		141,
		{
			RTResTalkAction[34],
			RTResTalkAction[17]
		}
	},
	[23019017] = {
		23019017,
		0,
		Lang.get(55155),
		23019,
		17,
		107,
		{
			RTResTalkAction[64],
			RTResTalkAction[27]
		}
	},
	[23019018] = {
		23019018,
		0,
		Lang.get(55156),
		23019,
		18,
		249,
		{
			RTResTalkAction[48],
			RTResTalkAction[26]
		}
	},
	[23019019] = {
		23019019,
		0,
		Lang.get(55157),
		23019,
		19,
		249,
		{
			RTResTalkAction[48]
		}
	},
	[23019020] = {
		23019020,
		0,
		Lang.get(55158),
		23019,
		20,
		251,
		{
			RTResTalkAction[72],
			RTResTalkAction[17]
		},
		nil,
		nil,
		3,
		nil,
		63,
		23091,
		nil,
		nil,
		nil,
		1,
		nil,
		23091
	},
	[23019021] = {
		23019021,
		0,
		"……！",
		23019,
		21,
		249,
		{
			RTResTalkAction[32],
			RTResTalkAction[74]
		}
	},
	[23020001] = {
		23020001,
		0,
		Lang.get(55159),
		23020,
		1,
		673,
		nil,
		1,
		nil,
		3,
		nil,
		46,
		23042,
		nil,
		nil,
		nil,
		1,
		nil,
		23042
	},
	[23020002] = {
		23020002,
		0,
		Lang.get(55160),
		23020,
		2,
		107,
		nil,
		1,
		3
	},
	[23020003] = {
		23020003,
		0,
		Lang.get(55161),
		23020,
		3,
		251,
		nil,
		1,
		0
	},
	[23020004] = {
		23020004,
		0,
		Lang.get(55162),
		23020,
		4,
		673,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		23043,
		[19] = 23043,
		[17] = 1
	},
	[23020005] = {
		23020005,
		0,
		Lang.get(55163),
		23020,
		5,
		107,
		{
			RTResTalkAction[62]
		},
		nil,
		nil,
		3
	},
	[23020006] = {
		23020006,
		0,
		Lang.get(55164),
		23020,
		6,
		251,
		{
			RTResTalkAction[72],
			RTResTalkAction[26]
		}
	},
	[23020007] = {
		23020007,
		0,
		Lang.get(55165),
		23020,
		7,
		251,
		{
			RTResTalkAction[72]
		}
	},
	[23020008] = {
		23020008,
		0,
		Lang.get(55166),
		23020,
		8,
		141,
		{
			RTResTalkAction[44],
			RTResTalkAction[74]
		}
	},
	[23020009] = {
		23020009,
		0,
		Lang.get(55167),
		23020,
		9,
		251,
		{
			RTResTalkAction[72],
			RTResTalkAction[27]
		}
	},
	[23020010] = {
		23020010,
		0,
		Lang.get(55168),
		23020,
		10,
		107,
		{
			RTResTalkAction[21],
			RTResTalkAction[74]
		}
	},
	[23020011] = {
		23020011,
		0,
		Lang.get(55169),
		23020,
		11,
		141,
		{
			RTResTalkAction[22],
			RTResTalkAction[99]
		}
	},
	[23020012] = {
		23020012,
		0,
		Lang.get(55170),
		23020,
		12,
		251,
		{
			RTResTalkAction[72],
			RTResTalkAction[26],
			RTResTalkAction[27]
		}
	},
	[23020013] = {
		23020013,
		0,
		Lang.get(55171),
		23020,
		13,
		251,
		{
			RTResTalkAction[72]
		}
	},
	[23020014] = {
		23020014,
		0,
		Lang.get(55172),
		23020,
		14,
		251,
		{
			RTResTalkAction[72]
		}
	},
	[23020015] = {
		23020015,
		0,
		Lang.get(55173),
		23020,
		15,
		249,
		{
			RTResTalkAction[33],
			RTResTalkAction[74]
		}
	},
	[23020016] = {
		23020016,
		0,
		Lang.get(55174),
		23020,
		16,
		251,
		{
			RTResTalkAction[72],
			RTResTalkAction[17]
		}
	},
	[23020017] = {
		23020017,
		0,
		Lang.get(55175),
		23020,
		17,
		251,
		{
			RTResTalkAction[72]
		}
	},
	[23020018] = {
		23020018,
		0,
		Lang.get(55176),
		23020,
		18,
		251,
		{
			RTResTalkAction[72]
		}
	},
	[23020019] = {
		23020019,
		0,
		Lang.get(55177),
		23020,
		19,
		249,
		{
			RTResTalkAction[32],
			RTResTalkAction[74]
		}
	},
	[23020020] = {
		23020020,
		0,
		Lang.get(55178),
		23020,
		20,
		107,
		{
			RTResTalkAction[91],
			RTResTalkAction[71]
		}
	},
	[23020021] = {
		23020021,
		0,
		Lang.get(55179),
		23020,
		21,
		107,
		{
			RTResTalkAction[91],
			RTResTalkAction[100]
		}
	},
	[23020022] = {
		23020022,
		0,
		Lang.get(55180),
		23020,
		22,
		251,
		{
			RTResTalkAction[72],
			RTResTalkAction[17],
			RTResTalkAction[26]
		}
	},
	[23020023] = {
		23020023,
		0,
		Lang.get(55181),
		23020,
		23,
		249,
		{
			RTResTalkAction[32],
			RTResTalkAction[74]
		}
	},
	[23020024] = {
		23020024,
		0,
		Lang.get(55182),
		23020,
		24,
		251,
		{
			RTResTalkAction[72],
			RTResTalkAction[17]
		}
	},
	[23020025] = {
		23020025,
		0,
		Lang.get(55183),
		23020,
		25,
		251,
		{
			RTResTalkAction[72]
		}
	},
	[23020026] = {
		23020026,
		0,
		Lang.get(55184),
		23020,
		26,
		251,
		{
			RTResTalkAction[72]
		}
	},
	[23020027] = {
		23020027,
		0,
		Lang.get(55185),
		23020,
		27,
		251,
		{
			RTResTalkAction[72]
		}
	},
	[23020028] = {
		23020028,
		0,
		Lang.get(55186),
		23020,
		28,
		251,
		{
			RTResTalkAction[72]
		}
	},
	[23020029] = {
		23020029,
		3,
		Lang.get(55187),
		23020,
		29,
		251,
		{
			RTResTalkAction[74]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		23044,
		nil,
		1,
		nil,
		1,
		nil,
		23044,
		nil,
		nil,
		1
	},
	[23020030] = {
		23020030,
		0,
		Lang.get(55188),
		23020,
		30,
		141,
		nil,
		1,
		3
	},
	[23021001] = {
		23021001,
		0,
		Lang.get(55189),
		23021,
		1,
		107,
		nil,
		1,
		3,
		nil,
		nil,
		28,
		23045,
		nil,
		nil,
		nil,
		1,
		nil,
		23045
	},
	[23021002] = {
		23021002,
		0,
		Lang.get(55190),
		23021,
		2,
		134,
		nil,
		1,
		3
	},
	[23021003] = {
		23021003,
		0,
		Lang.get(55191),
		23021,
		3,
		253,
		nil,
		1,
		1,
		nil,
		nil,
		24,
		23046,
		nil,
		nil,
		nil,
		1,
		nil,
		23046
	},
	[23021004] = {
		23021004,
		0,
		Lang.get(55192),
		23021,
		4,
		249,
		nil,
		1,
		5
	},
	[23021005] = {
		23021005,
		0,
		Lang.get(55193),
		23021,
		5,
		141,
		nil,
		1,
		0
	},
	[23021006] = {
		23021006,
		0,
		Lang.get(55194),
		23021,
		6,
		249,
		nil,
		1,
		4
	},
	[23021007] = {
		23021007,
		0,
		Lang.get(55692),
		23021,
		7,
		253,
		nil,
		1,
		2,
		nil,
		nil,
		28,
		23047,
		nil,
		nil,
		nil,
		1,
		nil,
		23047
	},
	[23021008] = {
		23021008,
		5,
		Lang.get(23649),
		23021,
		8,
		255,
		nil,
		1,
		0
	},
	[23021009] = {
		23021009,
		0,
		Lang.get(55196),
		23021,
		9,
		107,
		nil,
		1,
		1
	},
	[23021010] = {
		23021010,
		0,
		Lang.get(55197),
		23021,
		10,
		249,
		nil,
		1,
		2
	},
	[23021011] = {
		23021011,
		0,
		Lang.get(55198),
		23021,
		11,
		107,
		nil,
		1,
		1
	},
	[23021012] = {
		23021012,
		0,
		Lang.get(55199),
		23021,
		12,
		141,
		nil,
		1,
		0
	},
	[23021013] = {
		23021013,
		0,
		Lang.get(55200),
		23021,
		13,
		251,
		{
			RTResTalkAction[72]
		},
		nil,
		nil,
		3
	},
	[23021014] = {
		23021014,
		0,
		Lang.get(55201),
		23021,
		14,
		251,
		{
			RTResTalkAction[72]
		}
	},
	[23021015] = {
		23021015,
		0,
		Lang.get(55202),
		23021,
		15,
		107,
		{
			RTResTalkAction[74]
		},
		1,
		8,
		-1,
		nil,
		nil,
		23048,
		nil,
		1,
		nil,
		1,
		nil,
		23048
	},
	[23021016] = {
		23021016,
		0,
		Lang.get(55203),
		23021,
		16,
		134,
		nil,
		1,
		2
	},
	[23021017] = {
		23021017,
		0,
		Lang.get(55204),
		23021,
		17,
		107,
		nil,
		1,
		5
	},
	[23021018] = {
		23021018,
		0,
		Lang.get(55205),
		23021,
		18,
		134,
		nil,
		1,
		2
	},
	[23021019] = {
		23021019,
		0,
		Lang.get(55206),
		23021,
		19,
		107,
		nil,
		1,
		8
	},
	[23021020] = {
		23021020,
		0,
		Lang.get(55207),
		23021,
		20,
		107,
		nil,
		1,
		8
	},
	[23021021] = {
		23021021,
		0,
		Lang.get(55208),
		23021,
		21,
		141,
		nil,
		1,
		0
	},
	[23022001] = {
		23022001,
		0,
		Lang.get(55693),
		23022,
		1,
		253,
		nil,
		1,
		3,
		nil,
		nil,
		66,
		23049,
		nil,
		nil,
		nil,
		1,
		nil,
		23049
	},
	[23022002] = {
		23022002,
		0,
		"……！",
		23022,
		2,
		107,
		nil,
		1,
		8
	},
	[23022003] = {
		23022003,
		0,
		Lang.get(55694),
		23022,
		3,
		253,
		nil,
		1,
		0
	},
	[23022004] = {
		23022004,
		0,
		Lang.get(55212),
		23022,
		4,
		249,
		nil,
		1,
		1
	},
	[23022005] = {
		23022005,
		0,
		Lang.get(56524),
		23022,
		5,
		141,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		23200,
		nil,
		nil,
		nil,
		1,
		nil,
		23200
	},
	[23022006] = {
		23022006,
		0,
		Lang.get(55213),
		23022,
		6,
		107,
		nil,
		1,
		10
	},
	[23022007] = {
		23022007,
		0,
		Lang.get(55214),
		23022,
		7,
		134,
		nil,
		1,
		2
	},
	[23022008] = {
		23022008,
		0,
		Lang.get(55215),
		23022,
		8,
		107,
		nil,
		1,
		10
	},
	[23022009] = {
		23022009,
		0,
		Lang.get(55216),
		23022,
		9,
		107,
		nil,
		1,
		10
	},
	[23022010] = {
		23022010,
		0,
		Lang.get(55217),
		23022,
		10,
		252,
		nil,
		1,
		0
	},
	[23022011] = {
		23022011,
		0,
		Lang.get(55218),
		23022,
		11,
		250,
		nil,
		1,
		0
	},
	[23023001] = {
		23023001,
		0,
		Lang.get(55219),
		23023,
		1,
		251,
		{
			RTResTalkAction[72]
		},
		nil,
		nil,
		3,
		nil,
		66,
		23201,
		nil,
		nil,
		nil,
		1,
		nil,
		23201
	},
	[23023002] = {
		23023002,
		0,
		Lang.get(55220),
		23023,
		2,
		252,
		{
			RTResTalkAction[101],
			RTResTalkAction[74]
		}
	},
	[23023003] = {
		23023003,
		0,
		Lang.get(55221),
		23023,
		3,
		252,
		{
			RTResTalkAction[101]
		}
	},
	[23023004] = {
		23023004,
		0,
		Lang.get(55222),
		23023,
		4,
		251,
		{
			RTResTalkAction[72],
			RTResTalkAction[102]
		}
	},
	[23023005] = {
		23023005,
		0,
		Lang.get(55223),
		23023,
		5,
		251,
		{
			RTResTalkAction[72]
		}
	},
	[23023006] = {
		23023006,
		5,
		Lang.get(55224),
		23023,
		6,
		255,
		{
			RTResTalkAction[103],
			RTResTalkAction[74]
		}
	},
	[23023007] = {
		23023007,
		0,
		Lang.get(55225),
		23023,
		7,
		107,
		{
			RTResTalkAction[62],
			RTResTalkAction[104]
		}
	},
	[23023008] = {
		23023008,
		0,
		Lang.get(55226),
		23023,
		8,
		250,
		{
			RTResTalkAction[105],
			RTResTalkAction[26]
		}
	},
	[23023009] = {
		23023009,
		0,
		Lang.get(55227),
		23023,
		9,
		300,
		{
			RTResTalkAction[105]
		}
	},
	[23023010] = {
		23023010,
		0,
		Lang.get(55228),
		23023,
		10,
		107,
		{
			RTResTalkAction[106],
			RTResTalkAction[107]
		}
	},
	[23024001] = {
		23024001,
		0,
		Lang.get(55229),
		23024,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		66,
		23050,
		[19] = 23050,
		[17] = 1
	},
	[23024002] = {
		23024002,
		0,
		Lang.get(55230),
		23024,
		2,
		251,
		{
			RTResTalkAction[72]
		},
		nil,
		nil,
		3
	},
	[23024003] = {
		23024003,
		0,
		Lang.get(55231),
		23024,
		3,
		141,
		{
			RTResTalkAction[34],
			RTResTalkAction[74]
		}
	},
	[23024004] = {
		23024004,
		0,
		Lang.get(55232),
		23024,
		4,
		107,
		{
			RTResTalkAction[70],
			RTResTalkAction[108]
		}
	},
	[23024005] = {
		23024005,
		0,
		Lang.get(55233),
		23024,
		5,
		107,
		{
			RTResTalkAction[70],
			RTResTalkAction[109]
		}
	},
	[23024006] = {
		23024006,
		0,
		Lang.get(55234),
		23024,
		6,
		134,
		{
			RTResTalkAction[110],
			RTResTalkAction[27],
			RTResTalkAction[26]
		}
	},
	[23024007] = {
		23024007,
		0,
		Lang.get(55235),
		23024,
		7,
		107,
		{
			RTResTalkAction[111],
			RTResTalkAction[112]
		}
	},
	[23024008] = {
		23024008,
		0,
		Lang.get(55695),
		23024,
		8,
		107,
		{
			RTResTalkAction[111],
			RTResTalkAction[112]
		}
	},
	[23024009] = {
		23024009,
		0,
		Lang.get(55696),
		23024,
		9,
		250,
		{
			RTResTalkAction[105],
			RTResTalkAction[43],
			RTResTalkAction[26]
		}
	},
	[23024010] = {
		23024010,
		5,
		Lang.get(55697),
		23024,
		10,
		250,
		{
			RTResTalkAction[105]
		}
	},
	[23025001] = {
		23025001,
		0,
		Lang.get(55239),
		23025,
		1,
		251,
		{
			RTResTalkAction[72]
		},
		nil,
		nil,
		3,
		nil,
		46,
		23051,
		nil,
		nil,
		nil,
		1,
		nil,
		23051
	},
	[23025002] = {
		23025002,
		0,
		Lang.get(55240),
		23025,
		2,
		251,
		{
			RTResTalkAction[72]
		}
	},
	[23025003] = {
		23025003,
		0,
		Lang.get(55241),
		23025,
		3,
		252,
		{
			RTResTalkAction[101],
			RTResTalkAction[74]
		}
	},
	[23025004] = {
		23025004,
		0,
		Lang.get(55242),
		23025,
		4,
		252,
		{
			RTResTalkAction[101]
		}
	},
	[23025005] = {
		23025005,
		0,
		Lang.get(55243),
		23025,
		5,
		251,
		{
			RTResTalkAction[72],
			RTResTalkAction[102]
		}
	},
	[23025006] = {
		23025006,
		0,
		Lang.get(55244),
		23025,
		6,
		251,
		{
			RTResTalkAction[72]
		}
	},
	[23025007] = {
		23025007,
		0,
		Lang.get(55245),
		23025,
		7,
		251,
		{
			RTResTalkAction[72]
		}
	},
	[23025008] = {
		23025008,
		0,
		Lang.get(55698),
		23025,
		8,
		251,
		{
			RTResTalkAction[72]
		}
	},
	[23025009] = {
		23025009,
		0,
		Lang.get(55699),
		23025,
		9,
		250,
		{
			RTResTalkAction[105],
			RTResTalkAction[74]
		}
	},
	[23025010] = {
		23025010,
		0,
		Lang.get(55247),
		23025,
		10,
		252,
		{
			RTResTalkAction[113],
			RTResTalkAction[114]
		}
	},
	[23025011] = {
		23025011,
		0,
		Lang.get(55248),
		23025,
		11,
		250,
		{
			RTResTalkAction[107],
			RTResTalkAction[102]
		},
		1,
		nil,
		-1,
		nil,
		nil,
		23052,
		nil,
		1,
		nil,
		1,
		nil,
		23052
	},
	[23025012] = {
		23025012,
		0,
		Lang.get(55249),
		23025,
		12,
		63,
		nil,
		1
	},
	[23025013] = {
		23025013,
		0,
		Lang.get(55250),
		23025,
		13,
		141,
		nil,
		1
	},
	[23025014] = {
		23025014,
		0,
		Lang.get(55251),
		23025,
		14,
		141,
		nil,
		1,
		3
	},
	[23025015] = {
		23025015,
		3,
		Lang.get(55252),
		23025,
		15,
		141,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		23202,
		nil,
		nil,
		nil,
		1,
		nil,
		23202,
		nil,
		nil,
		1
	},
	[23025016] = {
		23025016,
		0,
		Lang.get(55253),
		23025,
		16,
		107,
		{
			RTResTalkAction[115]
		}
	},
	[23026001] = {
		23026001,
		0,
		Lang.get(55254),
		23026,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		134,
		23053,
		[19] = 23053,
		[17] = 1
	},
	[23026002] = {
		23026002,
		0,
		Lang.get(55255),
		23026,
		2,
		107,
		nil,
		1
	},
	[23026003] = {
		23026003,
		0,
		Lang.get(55256),
		23026,
		3,
		141,
		nil,
		1
	},
	[23026004] = {
		23026004,
		0,
		Lang.get(55257),
		23026,
		4,
		134,
		nil,
		1,
		2
	},
	[23026005] = {
		23026005,
		0,
		Lang.get(55258),
		23026,
		5,
		107,
		nil,
		1,
		5
	},
	[23026006] = {
		23026006,
		0,
		Lang.get(56525),
		23026,
		6,
		249,
		{
			RTResTalkAction[116]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		23054,
		[19] = 23054,
		[17] = 1
	},
	[23026007] = {
		23026007,
		0,
		Lang.get(55260),
		23026,
		7,
		253,
		{
			RTResTalkAction[91],
			RTResTalkAction[117]
		}
	},
	[23026008] = {
		23026008,
		0,
		Lang.get(55262),
		23026,
		8,
		300,
		{
			RTResTalkAction[91],
			RTResTalkAction[56]
		}
	},
	[23026009] = {
		23026009,
		0,
		Lang.get(55263),
		23026,
		9,
		300,
		{
			RTResTalkAction[91],
			RTResTalkAction[56]
		}
	},
	[23026010] = {
		23026010,
		0,
		Lang.get(55264),
		23026,
		10,
		300,
		{
			RTResTalkAction[91],
			RTResTalkAction[56]
		}
	},
	[23026011] = {
		23026011,
		0,
		Lang.get(55265),
		23026,
		11,
		300,
		{
			RTResTalkAction[91],
			RTResTalkAction[56]
		}
	},
	[23026012] = {
		23026012,
		0,
		Lang.get(55266),
		23026,
		12,
		300,
		{
			RTResTalkAction[91],
			RTResTalkAction[56]
		}
	},
	[23026013] = {
		23026013,
		0,
		"……",
		23026,
		13,
		253,
		{
			RTResTalkAction[17],
			RTResTalkAction[5]
		},
		1,
		2,
		-1,
		nil,
		nil,
		23055,
		nil,
		1,
		nil,
		1,
		nil,
		23055
	},
	[23026014] = {
		23026014,
		0,
		Lang.get(55700),
		23026,
		14,
		253,
		nil,
		1,
		2
	},
	[23026015] = {
		23026015,
		0,
		Lang.get(37925),
		23026,
		15,
		249,
		{
			RTResTalkAction[118]
		},
		nil,
		nil,
		3
	},
	[23026016] = {
		23026016,
		0,
		Lang.get(55701),
		23026,
		16,
		300,
		{
			RTResTalkAction[32]
		}
	},
	[23026017] = {
		23026017,
		0,
		Lang.get(55702),
		23026,
		17,
		249,
		{
			RTResTalkAction[32]
		}
	},
	[23026018] = {
		23026018,
		0,
		Lang.get(55272),
		23026,
		18,
		249,
		{
			RTResTalkAction[119]
		}
	},
	[23026019] = {
		23026019,
		0,
		Lang.get(55273),
		23026,
		19,
		300,
		{
			RTResTalkAction[32]
		}
	},
	[23026020] = {
		23026020,
		5,
		Lang.get(55703),
		23026,
		20,
		253,
		{
			RTResTalkAction[10],
			RTResTalkAction[17]
		}
	},
	[23026021] = {
		23026021,
		0,
		Lang.get(55704),
		23026,
		21,
		300,
		{
			RTResTalkAction[12]
		}
	},
	[23026022] = {
		23026022,
		0,
		Lang.get(55279),
		23026,
		22,
		300,
		{
			RTResTalkAction[12]
		}
	},
	[23026023] = {
		23026023,
		0,
		Lang.get(55280),
		23026,
		23,
		253,
		{
			RTResTalkAction[8]
		}
	},
	[23026024] = {
		23026024,
		0,
		Lang.get(55281),
		23026,
		24,
		249,
		{
			RTResTalkAction[13],
			RTResTalkAction[29]
		}
	},
	[23026025] = {
		23026025,
		0,
		Lang.get(55282),
		23026,
		25,
		253,
		{
			RTResTalkAction[120],
			RTResTalkAction[16]
		}
	},
	[23026026] = {
		23026026,
		3,
		Lang.get(55283),
		23026,
		26,
		253,
		{
			RTResTalkAction[5],
			RTResTalkAction[17]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		23203,
		nil,
		1,
		nil,
		1,
		nil,
		23203,
		nil,
		nil,
		1
	},
	[23026027] = {
		23026027,
		0,
		Lang.get(55284),
		23026,
		27,
		256,
		{
			RTResTalkAction[121]
		},
		nil,
		nil,
		3,
		nil,
		46,
		23056,
		nil,
		nil,
		nil,
		1,
		nil,
		23056
	},
	[23026028] = {
		23026028,
		0,
		Lang.get(55285),
		23026,
		28,
		256,
		{
			RTResTalkAction[122]
		},
		nil,
		nil,
		3
	},
	[23026029] = {
		23026029,
		0,
		Lang.get(55286),
		23026,
		29,
		256,
		{
			RTResTalkAction[122]
		},
		nil,
		nil,
		3
	},
	[23026030] = {
		23026030,
		0,
		Lang.get(55287),
		23026,
		30,
		256,
		{
			RTResTalkAction[122]
		},
		nil,
		nil,
		3
	},
	[23026031] = {
		23026031,
		0,
		Lang.get(55288),
		23026,
		31,
		256,
		{
			RTResTalkAction[122]
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
