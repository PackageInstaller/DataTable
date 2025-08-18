-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\Yolanda\\ResTalk.lua

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
	108,
	{
		3
	},
	nil,
	3
}
RTResTalkAction[2] = {
	[1] = 0,
	[2] = 108
}
RTResTalkAction[3] = {
	1,
	108,
	{
		1
	},
	nil,
	3
}
RTResTalkAction[4] = {
	[1] = 1,
	[2] = 228
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 228
}
RTResTalkAction[6] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[7] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[8] = {
	2,
	108,
	nil,
	nil,
	3
}
RTResTalkAction[9] = {
	[1] = 3,
	[2] = 119
}
RTResTalkAction[10] = {
	[1] = 0,
	[2] = 119
}
RTResTalkAction[11] = {
	1,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[12] = {
	[1] = 2,
	[2] = 108
}
RTResTalkAction[13] = {
	2,
	108,
	{
		3
	},
	nil,
	3
}
RTResTalkAction[14] = {
	3,
	119,
	nil,
	nil,
	3
}
RTResTalkAction[15] = {
	3,
	119,
	nil,
	nil,
	10
}
RTResTalkAction[16] = {
	[1] = 1,
	[2] = 119
}
RTResTalkAction[17] = {
	[1] = 1,
	[2] = 141
}
RTResTalkAction[18] = {
	[1] = 1,
	[2] = 119,
	[3] = {
		1
	}
}
RTResTalkAction[19] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[20] = {
	1,
	107,
	nil,
	nil,
	7
}
RTResTalkAction[21] = {
	1,
	119,
	{
		3
	},
	nil,
	7
}
RTResTalkAction[22] = {
	1,
	107,
	nil,
	nil,
	3
}
RTResTalkAction[23] = {
	[1] = 1,
	[2] = 381
}
RTResTalkAction[24] = {
	1,
	119,
	nil,
	nil,
	10
}
RTResTalkAction[25] = {
	[1] = 0,
	[2] = 381
}
RTResTalkAction[26] = {
	2,
	107,
	{
		1
	},
	nil,
	4
}
RTResTalkAction[27] = {
	[1] = 3,
	[2] = 108
}
RTResTalkAction[28] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[29] = {
	1,
	108,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[30] = {
	1,
	119,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[31] = {
	1,
	107,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[32] = {
	1,
	108,
	{
		1
	},
	nil,
	4
}
RTResTalkAction[33] = {
	1,
	134,
	nil,
	nil,
	5
}
RTResTalkAction[34] = {
	[1] = 1,
	[2] = 42
}
RTResTalkAction[35] = {
	[1] = 0,
	[2] = 134
}
RTResTalkAction[36] = {
	[1] = 0,
	[2] = 42
}
RTResTalkAction[37] = {
	[1] = 1,
	[2] = 43
}
RTResTalkAction[38] = {
	[1] = 0,
	[2] = 43
}
RTResTalkAction[39] = {
	1,
	134,
	nil,
	nil,
	4
}
RTResTalkAction[40] = {
	1,
	134,
	nil,
	nil,
	1
}
RTResTalkAction[41] = {
	1,
	134,
	{
		3
	},
	nil,
	4
}
RTResTalkAction[42] = {
	1,
	134,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[43] = {
	[1] = 1,
	[2] = 108,
	[3] = {
		1
	}
}
RTResTalkAction[44] = {
	1,
	119,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[45] = {
	[1] = 1,
	[2] = 223
}
RTResTalkAction[46] = {
	[1] = 1,
	[2] = 379
}
RTResTalkAction[47] = {
	[1] = 0,
	[2] = 223
}
RTResTalkAction[48] = {
	1,
	229,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[49] = {
	[1] = 1,
	[2] = 627,
	[3] = {
		1
	}
}
RTResTalkAction[50] = {
	[1] = 0,
	[2] = 229
}
RTResTalkAction[51] = {
	[1] = 1,
	[2] = 382
}
RTResTalkAction[52] = {
	[1] = 0,
	[2] = 627
}
RTResTalkAction[53] = {
	[1] = 0,
	[2] = 382
}
RTResTalkAction[54] = {
	[1] = 1,
	[2] = 229
}
RTResTalkAction[55] = {
	[1] = 1,
	[2] = 627
}
RTResTalkAction[56] = {
	[1] = 1,
	[2] = 229,
	[3] = {
		1
	}
}
RTResTalkAction[57] = {
	1,
	229,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[58] = {
	[1] = 1,
	[2] = 627,
	[3] = {
		2
	}
}
RTResTalkAction[59] = {
	[1] = 1,
	[2] = 627,
	[3] = {
		3
	}
}
RTResTalkAction[60] = {
	[1] = 1,
	[2] = 301
}
RTResTalkAction[61] = {
	[1] = 0,
	[2] = 301
}
RTResTalkAction[62] = {
	[1] = 1,
	[2] = 108
}
RTResTalkAction[63] = {
	[1] = 3,
	[2] = 301
}
RTResTalkAction[64] = {
	2,
	108,
	nil,
	nil,
	4
}
RTResTalkAction[65] = {
	[1] = 2,
	[2] = 119
}
RTResTalkAction[66] = {
	[1] = 2,
	[2] = 119,
	[3] = {
		1
	}
}
RTResTalkAction[67] = {
	1,
	119,
	{
		2
	},
	nil,
	7
}
RTResTalkAction[68] = {
	1,
	107,
	{
		1
	},
	nil,
	8
}
RTResTalkAction[69] = {
	1,
	108,
	nil,
	nil,
	4
}
RTResTalkAction[70] = {
	1,
	107,
	{
		1
	},
	nil,
	5
}
RTResTalkAction[71] = {
	1,
	134,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[72] = {
	1,
	227,
	nil,
	nil,
	1
}
RTResTalkAction[73] = {
	[1] = 0,
	[2] = 227
}
RTResTalkAction[74] = {
	[1] = 1,
	[2] = 227
}
RTResTalkAction[75] = {
	1,
	108,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[76] = {
	1,
	119,
	nil,
	nil,
	5
}
RTResTalkAction[77] = {
	1,
	119,
	nil,
	nil,
	3
}
RTResTalkAction[78] = {
	[1] = 1,
	[2] = 134
}
RTResTalkAction[79] = {
	1,
	134,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[80] = {
	1,
	108,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[81] = {
	1,
	223,
	nil,
	nil,
	1
}
RTResTalkAction[82] = {
	1,
	119,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[83] = {
	1,
	119,
	{
		3
	},
	nil,
	10
}
RTResTalkAction[84] = {
	1,
	229,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[85] = {
	1,
	229,
	nil,
	nil,
	1
}
RTResTalkAction[86] = {
	[1] = 1,
	[2] = 228,
	[3] = {
		1
	}
}
RTResTalkAction[87] = {
	[1] = 3,
	[2] = 227
}
RTResTalkAction[88] = {
	3,
	227,
	nil,
	nil,
	1
}
RTResTalkAction[89] = {
	2,
	108,
	nil,
	nil,
	1
}
RTResTalkAction[90] = {
	[1] = 1,
	[2] = 121
}
RTResTalkAction[91] = {
	[1] = 2,
	[2] = 121
}
RTResTalkAction[92] = {
	3,
	108,
	nil,
	nil,
	3
}
RTResTalkAction[93] = {
	[1] = 0,
	[2] = 121
}
RTResTalkAction[94] = {
	1,
	108,
	nil,
	nil,
	3
}
RTResTalkAction[95] = {
	[1] = 1,
	[2] = 127
}
RTResTalkAction[96] = {
	[1] = 2,
	[2] = 301
}
RTResTalkAction[97] = {
	[1] = 3,
	[2] = 127
}
RTResTalkAction[98] = {
	3,
	127,
	nil,
	nil,
	1
}
RTResTalkAction[99] = {
	[1] = 0,
	[2] = 127
}
RTResTalkAction[100] = {
	[1] = 1,
	[2] = 380
}
RTResTalkAction[101] = {
	1,
	119,
	{
		1
	},
	nil,
	10
}
RTResTalkAction[102] = {
	1,
	107,
	nil,
	nil,
	1
}
RTResTalkAction[103] = {
	3,
	108,
	nil,
	nil,
	2
}
RTResTalkAction[104] = {
	1,
	107,
	{
		1
	},
	nil,
	7
}
RTResTalkAction[105] = {
	[1] = 2,
	[2] = 223
}
RTResTalkAction[106] = {
	3,
	108,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[107] = {
	1,
	108,
	nil,
	nil,
	2
}
RTResTalkAction[108] = {
	[1] = 3,
	[2] = 223
}
RTResTalkAction[109] = {
	1,
	119,
	{
		3
	},
	nil,
	5
}
RTResTalkAction[110] = {
	1,
	119,
	{
		1
	},
	nil,
	5
}
RTResTalkAction[111] = {
	1,
	226,
	nil,
	nil,
	1
}
RTResTalkAction[112] = {
	[1] = 0,
	[2] = 226
}
RTResTalkAction[113] = {
	[1] = 1,
	[2] = 226
}
RTResTalkAction[114] = {
	1,
	108,
	nil,
	nil,
	1
}
RTResTalkAction[115] = {
	1,
	226,
	nil,
	nil,
	2
}
RTResTalkAction[116] = {
	2,
	226,
	nil,
	nil,
	2
}
RTResTalkAction[117] = {
	3,
	108,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[118] = {
	[1] = 2,
	[2] = 226
}
RTResTalkAction[119] = {
	[1] = 3,
	[2] = 226
}

local Data = {
	[21301001] = {
		21301001,
		5,
		Lang.get(44486),
		21301,
		1,
		108,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		nil,
		nil,
		62,
		21301,
		[18] = 21301
	},
	[21301002] = {
		21301002,
		5,
		Lang.get(44487),
		21301,
		2,
		108,
		{
			RTResTalkAction[1]
		}
	},
	[21301003] = {
		21301003,
		4,
		nil,
		21301,
		3,
		300,
		{
			RTResTalkAction[2]
		},
		[27] = {
			{
				id = 21301004,
				branch_content = Lang.get(44488)
			}
		}
	},
	[21301004] = {
		21301004,
		0,
		Lang.get(44489),
		21301,
		4,
		108,
		{
			RTResTalkAction[3]
		}
	},
	[21301005] = {
		21301005,
		4,
		nil,
		21301,
		5,
		300,
		{
			RTResTalkAction[2]
		},
		[27] = {
			{
				id = 21301006,
				branch_content = Lang.get(44490)
			}
		}
	},
	[21301006] = {
		21301006,
		0,
		Lang.get(44491),
		21301,
		6,
		228,
		{
			RTResTalkAction[4]
		}
	},
	[21301007] = {
		21301007,
		7,
		"59",
		21301,
		7,
		228,
		{
			RTResTalkAction[5]
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
	[21301008] = {
		21301008,
		5,
		Lang.get(44492),
		21301,
		8,
		108,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		-1
	},
	[21301009] = {
		21301009,
		5,
		Lang.get(44493),
		21301,
		9,
		108,
		{
			RTResTalkAction[1]
		}
	},
	[21301010] = {
		21301010,
		0,
		Lang.get(44494),
		21301,
		10,
		107,
		{
			RTResTalkAction[6],
			RTResTalkAction[2]
		}
	},
	[21301011] = {
		21301011,
		0,
		Lang.get(44495),
		21301,
		11,
		228,
		{
			RTResTalkAction[4],
			RTResTalkAction[7]
		}
	},
	[21301012] = {
		21301012,
		4,
		nil,
		21301,
		12,
		300,
		{
			RTResTalkAction[5]
		},
		[27] = {
			{
				id = 21301013,
				branch_content = Lang.get(44496)
			}
		}
	},
	[21301013] = {
		21301013,
		0,
		Lang.get(44497),
		21301,
		13,
		228,
		{
			RTResTalkAction[4]
		}
	},
	[21301014] = {
		21301014,
		5,
		Lang.get(44498),
		21301,
		14,
		108,
		{
			RTResTalkAction[1],
			RTResTalkAction[5]
		}
	},
	[21302001] = {
		21302001,
		0,
		Lang.get(44499),
		21302,
		1,
		108,
		nil,
		1,
		3,
		nil,
		nil,
		60,
		21302,
		nil,
		nil,
		nil,
		nil,
		21302
	},
	[21302002] = {
		21302002,
		0,
		Lang.get(44500),
		21302,
		2,
		107,
		nil,
		1,
		8
	},
	[21302003] = {
		21302003,
		0,
		Lang.get(44501),
		21302,
		3,
		108,
		nil,
		1,
		3
	},
	[21302004] = {
		21302004,
		0,
		Lang.get(44502),
		21302,
		4,
		119,
		nil,
		1,
		0
	},
	[21302005] = {
		21302005,
		0,
		Lang.get(44503),
		21302,
		5,
		108,
		nil,
		1,
		3,
		nil,
		nil,
		nil,
		21303
	},
	[21302006] = {
		21302006,
		0,
		Lang.get(44504),
		21302,
		6,
		119,
		nil,
		1,
		0
	},
	[21302007] = {
		21302007,
		5,
		Lang.get(44505),
		21302,
		7,
		108,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[21302008] = {
		21302008,
		0,
		Lang.get(44506),
		21302,
		8,
		119,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[21302009] = {
		21302009,
		5,
		Lang.get(44507),
		21302,
		9,
		108,
		{
			RTResTalkAction[1],
			RTResTalkAction[10]
		}
	},
	[21302010] = {
		21302010,
		0,
		Lang.get(44508),
		21302,
		10,
		107,
		{
			RTResTalkAction[11],
			RTResTalkAction[2]
		}
	},
	[21305001] = {
		21305001,
		0,
		Lang.get(44509),
		21305,
		1,
		108,
		nil,
		1,
		3,
		nil,
		nil,
		60,
		21305,
		nil,
		nil,
		nil,
		nil,
		21305
	},
	[21305002] = {
		21305002,
		0,
		Lang.get(44510),
		21305,
		2,
		119,
		nil,
		1,
		0
	},
	[21305003] = {
		21305003,
		0,
		Lang.get(44511),
		21305,
		3,
		108,
		nil,
		1,
		3,
		nil,
		nil,
		nil,
		21308
	},
	[21305004] = {
		21305004,
		0,
		Lang.get(44512),
		21305,
		4,
		119,
		nil,
		1,
		0
	},
	[21305005] = {
		21305005,
		0,
		Lang.get(44513),
		21305,
		5,
		107,
		nil,
		1,
		3
	},
	[21305006] = {
		21305006,
		0,
		Lang.get(44514),
		21305,
		6,
		119,
		nil,
		1,
		10
	},
	[21305007] = {
		21305007,
		0,
		Lang.get(44515),
		21305,
		7,
		107,
		nil,
		1,
		7
	},
	[21305008] = {
		21305008,
		5,
		Lang.get(44516),
		21305,
		8,
		108,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		21306
	},
	[21305009] = {
		21305009,
		0,
		Lang.get(44517),
		21305,
		9,
		119,
		{
			RTResTalkAction[12],
			RTResTalkAction[9]
		}
	},
	[21305010] = {
		21305010,
		5,
		Lang.get(44518),
		21305,
		10,
		108,
		{
			RTResTalkAction[13],
			RTResTalkAction[9]
		}
	},
	[21305011] = {
		21305011,
		0,
		Lang.get(44519),
		21305,
		11,
		119,
		{
			RTResTalkAction[12],
			RTResTalkAction[9]
		}
	},
	[21305012] = {
		21305012,
		5,
		Lang.get(44520),
		21305,
		12,
		108,
		{
			RTResTalkAction[13],
			RTResTalkAction[9]
		}
	},
	[21305013] = {
		21305013,
		0,
		Lang.get(44521),
		21305,
		13,
		228,
		{
			RTResTalkAction[4],
			RTResTalkAction[2],
			RTResTalkAction[10]
		}
	},
	[21305014] = {
		21305014,
		5,
		Lang.get(44522),
		21305,
		14,
		108,
		{
			RTResTalkAction[1],
			RTResTalkAction[5]
		}
	},
	[21305015] = {
		21305015,
		0,
		Lang.get(44523),
		21305,
		15,
		119,
		{
			RTResTalkAction[8],
			RTResTalkAction[14]
		}
	},
	[21305016] = {
		21305016,
		5,
		Lang.get(44524),
		21305,
		16,
		108,
		{
			RTResTalkAction[13],
			RTResTalkAction[15]
		}
	},
	[21305017] = {
		21305017,
		0,
		Lang.get(45323),
		21305,
		17,
		119,
		{
			RTResTalkAction[12],
			RTResTalkAction[9]
		}
	},
	[21305018] = {
		21305018,
		5,
		Lang.get(44526),
		21305,
		18,
		108,
		{
			RTResTalkAction[1],
			RTResTalkAction[10]
		}
	},
	[21305019] = {
		21305019,
		0,
		Lang.get(44527),
		21305,
		19,
		119,
		{
			RTResTalkAction[16],
			RTResTalkAction[2]
		}
	},
	[21305020] = {
		21305020,
		0,
		Lang.get(44528),
		21305,
		20,
		108,
		{
			RTResTalkAction[10]
		},
		1,
		2,
		-1,
		nil,
		nil,
		21307
	},
	[21305021] = {
		21305021,
		0,
		Lang.get(44529),
		21305,
		21,
		107,
		nil,
		1,
		8
	},
	[21305022] = {
		21305022,
		0,
		Lang.get(44530),
		21305,
		22,
		119,
		nil,
		1,
		3
	},
	[21305023] = {
		21305023,
		0,
		Lang.get(44531),
		21305,
		23,
		141,
		nil,
		1,
		0
	},
	[21311001] = {
		21311001,
		0,
		Lang.get(44532),
		21311,
		1,
		141,
		nil,
		1,
		nil,
		nil,
		nil,
		3,
		21311,
		nil,
		nil,
		nil,
		nil,
		21311
	},
	[21311002] = {
		21311002,
		0,
		Lang.get(44533),
		21311,
		2,
		108,
		nil,
		1,
		3
	},
	[21311003] = {
		21311003,
		0,
		Lang.get(44534),
		21311,
		3,
		107,
		nil,
		1,
		0
	},
	[21311004] = {
		21311004,
		0,
		Lang.get(44535),
		21311,
		4,
		228,
		{
			RTResTalkAction[4]
		},
		nil,
		nil,
		3
	},
	[21311005] = {
		21311005,
		0,
		Lang.get(44536),
		21311,
		5,
		108,
		{
			RTResTalkAction[5]
		},
		1,
		3,
		nil,
		nil,
		nil,
		21312
	},
	[21311006] = {
		21311006,
		0,
		Lang.get(44537),
		21311,
		6,
		141,
		{
			RTResTalkAction[17]
		},
		nil,
		0,
		3
	},
	[21311007] = {
		21311007,
		0,
		Lang.get(44538),
		21311,
		7,
		119,
		{
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[21311008] = {
		21311008,
		5,
		Lang.get(44539),
		21311,
		8,
		108,
		{
			RTResTalkAction[1],
			RTResTalkAction[10]
		}
	},
	[21311009] = {
		21311009,
		0,
		Lang.get(44540),
		21311,
		9,
		107,
		{
			RTResTalkAction[6],
			RTResTalkAction[2]
		}
	},
	[21311010] = {
		21311010,
		0,
		Lang.get(44541),
		21311,
		10,
		228,
		{
			RTResTalkAction[4],
			RTResTalkAction[7]
		}
	},
	[21311011] = {
		21311011,
		5,
		Lang.get(44542),
		21311,
		11,
		108,
		{
			RTResTalkAction[1],
			RTResTalkAction[5]
		}
	},
	[21311012] = {
		21311012,
		0,
		Lang.get(44543),
		21311,
		12,
		107,
		{
			RTResTalkAction[20],
			RTResTalkAction[2]
		}
	},
	[21311013] = {
		21311013,
		0,
		Lang.get(44544),
		21311,
		13,
		228,
		{
			RTResTalkAction[4],
			RTResTalkAction[7]
		}
	},
	[21311014] = {
		21311014,
		5,
		Lang.get(44545),
		21311,
		14,
		108,
		{
			RTResTalkAction[1],
			RTResTalkAction[5]
		}
	},
	[21311015] = {
		21311015,
		0,
		Lang.get(44546),
		21311,
		15,
		107,
		{
			RTResTalkAction[6],
			RTResTalkAction[2]
		}
	},
	[21311016] = {
		21311016,
		0,
		Lang.get(44547),
		21311,
		16,
		228,
		{
			RTResTalkAction[4],
			RTResTalkAction[7]
		}
	},
	[21311017] = {
		21311017,
		0,
		Lang.get(44548),
		21311,
		17,
		107,
		{
			RTResTalkAction[6],
			RTResTalkAction[5]
		}
	},
	[21311018] = {
		21311018,
		0,
		Lang.get(44549),
		21311,
		18,
		228,
		{
			RTResTalkAction[4],
			RTResTalkAction[7]
		}
	},
	[21311019] = {
		21311019,
		5,
		Lang.get(44550),
		21311,
		19,
		108,
		{
			RTResTalkAction[1],
			RTResTalkAction[5]
		}
	},
	[21311020] = {
		21311020,
		5,
		Lang.get(44551),
		21311,
		20,
		119,
		{
			RTResTalkAction[21],
			RTResTalkAction[2]
		}
	},
	[21311021] = {
		21311021,
		5,
		Lang.get(44552),
		21311,
		21,
		108,
		{
			RTResTalkAction[1],
			RTResTalkAction[10]
		}
	},
	[21311022] = {
		21311022,
		0,
		Lang.get(44553),
		21311,
		22,
		108,
		{
			RTResTalkAction[2]
		},
		1,
		3,
		-1,
		nil,
		nil,
		21313
	},
	[21311023] = {
		21311023,
		0,
		Lang.get(44554),
		21311,
		23,
		119,
		nil,
		1,
		0
	},
	[21311024] = {
		21311024,
		0,
		Lang.get(19271),
		21311,
		24,
		141,
		nil,
		1
	},
	[21311025] = {
		21311025,
		0,
		Lang.get(44555),
		21311,
		25,
		107,
		nil,
		1,
		3
	},
	[21311026] = {
		21311026,
		3,
		Lang.get(23446),
		21311,
		26,
		605,
		[21] = 1
	},
	[21311027] = {
		21311027,
		0,
		Lang.get(44556),
		21311,
		27,
		107,
		{
			RTResTalkAction[22]
		},
		nil,
		nil,
		3
	},
	[21315001] = {
		21315001,
		0,
		Lang.get(44557),
		21315,
		1,
		107,
		{
			RTResTalkAction[22]
		},
		nil,
		nil,
		3,
		nil,
		122,
		21315,
		nil,
		nil,
		nil,
		nil,
		21315
	},
	[21315002] = {
		21315002,
		4,
		nil,
		21315,
		2,
		300,
		{
			RTResTalkAction[7]
		},
		[27] = {
			{
				id = 21315003,
				branch_content = Lang.get(44558)
			}
		}
	},
	[21315003] = {
		21315003,
		0,
		Lang.get(44559),
		21315,
		3,
		107,
		{
			RTResTalkAction[6]
		}
	},
	[21315004] = {
		21315004,
		0,
		Lang.get(44560),
		21315,
		4,
		381,
		{
			RTResTalkAction[23],
			RTResTalkAction[7]
		}
	},
	[21315005] = {
		21315005,
		0,
		Lang.get(44561),
		21315,
		5,
		119,
		{
			RTResTalkAction[24],
			RTResTalkAction[25]
		}
	},
	[21315006] = {
		21315006,
		0,
		Lang.get(44562),
		21315,
		6,
		141,
		{
			RTResTalkAction[17],
			RTResTalkAction[10]
		}
	},
	[21315007] = {
		21315007,
		0,
		Lang.get(44563),
		21315,
		7,
		107,
		{
			RTResTalkAction[22],
			RTResTalkAction[19]
		}
	},
	[21315008] = {
		21315008,
		0,
		Lang.get(44564),
		21315,
		8,
		108,
		{
			RTResTalkAction[26],
			RTResTalkAction[27]
		}
	},
	[21315009] = {
		21315009,
		0,
		Lang.get(44565),
		21315,
		9,
		107,
		{
			RTResTalkAction[28],
			RTResTalkAction[27]
		}
	},
	[21315010] = {
		21315010,
		5,
		Lang.get(44566),
		21315,
		10,
		108,
		{
			RTResTalkAction[29],
			RTResTalkAction[7]
		}
	},
	[21315011] = {
		21315011,
		0,
		Lang.get(44567),
		21315,
		11,
		119,
		{
			RTResTalkAction[2]
		},
		1,
		10,
		-1,
		nil,
		nil,
		21316
	},
	[21315012] = {
		21315012,
		0,
		Lang.get(44568),
		21315,
		12,
		108,
		nil,
		1,
		4
	},
	[21315013] = {
		21315013,
		0,
		Lang.get(44569),
		21315,
		13,
		107,
		nil,
		1,
		3
	},
	[21315014] = {
		21315014,
		0,
		Lang.get(44570),
		21315,
		14,
		141,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		21317
	},
	[21315015] = {
		21315015,
		0,
		Lang.get(44571),
		21315,
		15,
		107,
		nil,
		1
	},
	[21315016] = {
		21315016,
		0,
		Lang.get(44572),
		21315,
		16,
		119,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		21318
	},
	[21315017] = {
		21315017,
		0,
		Lang.get(44573),
		21315,
		17,
		107,
		nil,
		1
	},
	[21315018] = {
		21315018,
		5,
		Lang.get(44574),
		21315,
		18,
		108,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[21315019] = {
		21315019,
		0,
		Lang.get(44575),
		21315,
		19,
		141,
		{
			RTResTalkAction[17],
			RTResTalkAction[2]
		}
	},
	[21315020] = {
		21315020,
		0,
		Lang.get(44576),
		21315,
		20,
		107,
		{
			RTResTalkAction[22],
			RTResTalkAction[19]
		}
	},
	[21315021] = {
		21315021,
		3,
		Lang.get(44577),
		21315,
		21,
		605,
		{
			RTResTalkAction[7]
		},
		[21] = 1
	},
	[21315022] = {
		21315022,
		5,
		Lang.get(44578),
		21315,
		22,
		119,
		{
			RTResTalkAction[30]
		}
	},
	[21321001] = {
		21321001,
		0,
		Lang.get(44579),
		21321,
		1,
		134,
		nil,
		1,
		5,
		nil,
		nil,
		61,
		21321,
		0.5,
		nil,
		nil,
		nil,
		21321
	},
	[21321002] = {
		21321002,
		0,
		Lang.get(44580),
		21321,
		2,
		107,
		{
			RTResTalkAction[31]
		},
		nil,
		nil,
		3
	},
	[21321003] = {
		21321003,
		0,
		Lang.get(44581),
		21321,
		3,
		108,
		{
			RTResTalkAction[32],
			RTResTalkAction[7]
		}
	},
	[21321004] = {
		21321004,
		0,
		Lang.get(44582),
		21321,
		4,
		134,
		{
			RTResTalkAction[33],
			RTResTalkAction[2]
		}
	},
	[21321005] = {
		21321005,
		0,
		Lang.get(44583),
		21321,
		5,
		42,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[21321006] = {
		21321006,
		0,
		Lang.get(44584),
		21321,
		6,
		134,
		{
			RTResTalkAction[33],
			RTResTalkAction[36]
		}
	},
	[21321007] = {
		21321007,
		0,
		Lang.get(44585),
		21321,
		7,
		107,
		{
			RTResTalkAction[22],
			RTResTalkAction[35]
		}
	},
	[21321008] = {
		21321008,
		0,
		Lang.get(44586),
		21321,
		8,
		43,
		{
			RTResTalkAction[37],
			RTResTalkAction[7]
		}
	},
	[21321009] = {
		21321009,
		0,
		Lang.get(44587),
		21321,
		9,
		134,
		{
			RTResTalkAction[38]
		},
		1,
		5,
		-1,
		nil,
		nil,
		21322
	},
	[21321010] = {
		21321010,
		0,
		Lang.get(44588),
		21321,
		10,
		134,
		nil,
		1,
		5
	},
	[21321011] = {
		21321011,
		0,
		Lang.get(19557),
		21321,
		11,
		134,
		{
			RTResTalkAction[39]
		},
		nil,
		nil,
		3
	},
	[21321012] = {
		21321012,
		0,
		Lang.get(44589),
		21321,
		12,
		119,
		{
			RTResTalkAction[16],
			RTResTalkAction[35]
		}
	},
	[21321013] = {
		21321013,
		0,
		Lang.get(44590),
		21321,
		13,
		134,
		{
			RTResTalkAction[40],
			RTResTalkAction[10]
		}
	},
	[21321014] = {
		21321014,
		0,
		Lang.get(44591),
		21321,
		14,
		228,
		{
			RTResTalkAction[4],
			RTResTalkAction[35]
		}
	},
	[21321015] = {
		21321015,
		5,
		Lang.get(44592),
		21321,
		15,
		108,
		{
			RTResTalkAction[29],
			RTResTalkAction[5]
		}
	},
	[21321016] = {
		21321016,
		0,
		Lang.get(44593),
		21321,
		16,
		134,
		{
			RTResTalkAction[2]
		},
		1,
		1,
		-1,
		nil,
		nil,
		21323
	},
	[21321017] = {
		21321017,
		0,
		Lang.get(21624),
		21321,
		17,
		107,
		nil,
		1,
		3
	},
	[21321018] = {
		21321018,
		5,
		Lang.get(44594),
		21321,
		18,
		134,
		{
			RTResTalkAction[41]
		},
		nil,
		nil,
		3
	},
	[21321019] = {
		21321019,
		5,
		Lang.get(44595),
		21321,
		19,
		134,
		{
			RTResTalkAction[42]
		}
	},
	[21325001] = {
		21325001,
		0,
		Lang.get(44596),
		21325,
		1,
		108,
		nil,
		1,
		2,
		nil,
		nil,
		103,
		21325,
		nil,
		nil,
		nil,
		nil,
		21325
	},
	[21325002] = {
		21325002,
		0,
		Lang.get(44597),
		21325,
		2,
		141,
		nil,
		1,
		0
	},
	[21325003] = {
		21325003,
		0,
		Lang.get(26501),
		21325,
		3,
		134,
		{
			RTResTalkAction[33]
		},
		nil,
		nil,
		3
	},
	[21325004] = {
		21325004,
		0,
		Lang.get(44598),
		21325,
		4,
		43,
		{
			RTResTalkAction[37],
			RTResTalkAction[35]
		}
	},
	[21325005] = {
		21325005,
		0,
		Lang.get(44599),
		21325,
		5,
		119,
		{
			RTResTalkAction[16],
			RTResTalkAction[38]
		}
	},
	[21325006] = {
		21325006,
		0,
		Lang.get(44600),
		21325,
		6,
		42,
		{
			RTResTalkAction[34],
			RTResTalkAction[10]
		}
	},
	[21325007] = {
		21325007,
		0,
		Lang.get(44601),
		21325,
		7,
		141,
		{
			RTResTalkAction[17],
			RTResTalkAction[36]
		}
	},
	[21325008] = {
		21325008,
		0,
		Lang.get(44602),
		21325,
		8,
		108,
		{
			RTResTalkAction[43],
			RTResTalkAction[19]
		}
	},
	[21325009] = {
		21325009,
		0,
		Lang.get(44603),
		21325,
		9,
		107,
		{
			RTResTalkAction[11],
			RTResTalkAction[2]
		}
	},
	[21325010] = {
		21325010,
		0,
		Lang.get(44604),
		21325,
		10,
		108,
		{
			RTResTalkAction[43],
			RTResTalkAction[7]
		}
	},
	[21325011] = {
		21325011,
		0,
		Lang.get(44605),
		21325,
		11,
		141,
		{
			RTResTalkAction[17],
			RTResTalkAction[2]
		}
	},
	[21325012] = {
		21325012,
		0,
		Lang.get(45324),
		21325,
		12,
		119,
		{
			RTResTalkAction[44],
			RTResTalkAction[19]
		}
	},
	[21327001] = {
		21327001,
		0,
		Lang.get(44607),
		21327,
		1,
		379,
		nil,
		1,
		nil,
		nil,
		nil,
		122,
		21327,
		nil,
		nil,
		nil,
		nil,
		21327
	},
	[21327002] = {
		21327002,
		0,
		Lang.get(44608),
		21327,
		2,
		379,
		nil,
		1
	},
	[21327003] = {
		21327003,
		0,
		Lang.get(44609),
		21327,
		3,
		223,
		nil,
		1
	},
	[21327004] = {
		21327004,
		0,
		Lang.get(44610),
		21327,
		4,
		223,
		{
			RTResTalkAction[45]
		}
	},
	[21327005] = {
		21327005,
		0,
		Lang.get(44611),
		21327,
		5,
		379,
		{
			RTResTalkAction[46],
			RTResTalkAction[47]
		}
	},
	[21328001] = {
		21328001,
		0,
		Lang.get(44612),
		21328,
		1,
		229,
		nil,
		1,
		1,
		nil,
		nil,
		103,
		21328,
		nil,
		nil,
		nil,
		nil,
		21328
	},
	[21328002] = {
		21328002,
		0,
		Lang.get(44613),
		21328,
		2,
		627,
		nil,
		1,
		0
	},
	[21328003] = {
		21328003,
		0,
		Lang.get(44614),
		21328,
		3,
		229,
		nil,
		1,
		1
	},
	[21328004] = {
		21328004,
		0,
		Lang.get(44615),
		21328,
		4,
		627,
		nil,
		1,
		0
	},
	[21328005] = {
		21328005,
		0,
		Lang.get(44616),
		21328,
		5,
		229,
		nil,
		1,
		1
	},
	[21328006] = {
		21328006,
		0,
		Lang.get(44617),
		21328,
		6,
		627,
		nil,
		1,
		0
	},
	[21328007] = {
		21328007,
		0,
		Lang.get(44618),
		21328,
		7,
		229,
		{
			RTResTalkAction[48]
		},
		nil,
		nil,
		3
	},
	[21328008] = {
		21328008,
		0,
		Lang.get(44619),
		21328,
		8,
		627,
		{
			RTResTalkAction[49],
			RTResTalkAction[50]
		}
	},
	[21328009] = {
		21328009,
		0,
		Lang.get(44620),
		21328,
		9,
		382,
		{
			RTResTalkAction[51],
			RTResTalkAction[52]
		}
	},
	[21328010] = {
		21328010,
		0,
		Lang.get(44621),
		21328,
		10,
		382,
		{
			RTResTalkAction[53]
		},
		1,
		nil,
		-1
	},
	[21328011] = {
		21328011,
		0,
		Lang.get(44622),
		21328,
		11,
		229,
		nil,
		1,
		1
	},
	[21328012] = {
		21328012,
		0,
		Lang.get(44623),
		21328,
		12,
		627,
		nil,
		1,
		0
	},
	[21328013] = {
		21328013,
		0,
		Lang.get(44624),
		21328,
		13,
		229,
		{
			RTResTalkAction[54]
		},
		nil,
		nil,
		3
	},
	[21328014] = {
		21328014,
		0,
		Lang.get(44625),
		21328,
		14,
		627,
		{
			RTResTalkAction[55],
			RTResTalkAction[50]
		}
	},
	[21328015] = {
		21328015,
		0,
		Lang.get(44626),
		21328,
		15,
		229,
		{
			RTResTalkAction[56],
			RTResTalkAction[52]
		}
	},
	[21328016] = {
		21328016,
		0,
		Lang.get(44627),
		21328,
		16,
		627,
		{
			RTResTalkAction[55],
			RTResTalkAction[50]
		}
	},
	[21328017] = {
		21328017,
		0,
		Lang.get(44628),
		21328,
		17,
		382,
		{
			RTResTalkAction[51],
			RTResTalkAction[52]
		}
	},
	[21328018] = {
		21328018,
		0,
		Lang.get(44629),
		21328,
		18,
		229,
		{
			RTResTalkAction[57],
			RTResTalkAction[53]
		}
	},
	[21328019] = {
		21328019,
		0,
		Lang.get(44630),
		21328,
		19,
		229,
		{
			RTResTalkAction[54]
		}
	},
	[21328020] = {
		21328020,
		0,
		Lang.get(44631),
		21328,
		20,
		627,
		{
			RTResTalkAction[58],
			RTResTalkAction[50]
		}
	},
	[21328021] = {
		21328021,
		0,
		Lang.get(44632),
		21328,
		21,
		627,
		{
			RTResTalkAction[49]
		}
	},
	[21328022] = {
		21328022,
		0,
		Lang.get(44633),
		21328,
		22,
		627,
		{
			RTResTalkAction[59]
		}
	},
	[21328023] = {
		21328023,
		0,
		Lang.get(44634),
		21328,
		23,
		108,
		{
			RTResTalkAction[52]
		},
		1,
		4,
		-1
	},
	[21328024] = {
		21328024,
		0,
		Lang.get(44635),
		21328,
		24,
		119,
		nil,
		1,
		10
	},
	[21328025] = {
		21328025,
		0,
		Lang.get(44636),
		21328,
		25,
		108,
		nil,
		1,
		0
	},
	[21328026] = {
		21328026,
		0,
		Lang.get(44637),
		21328,
		26,
		229,
		{
			RTResTalkAction[48]
		},
		nil,
		nil,
		3
	},
	[21328027] = {
		21328027,
		0,
		Lang.get(44638),
		21328,
		27,
		627,
		{
			RTResTalkAction[49],
			RTResTalkAction[50]
		}
	},
	[21328028] = {
		21328028,
		0,
		Lang.get(44639),
		21328,
		28,
		108,
		{
			RTResTalkAction[52]
		},
		1,
		nil,
		-1
	},
	[21331001] = {
		21331001,
		0,
		Lang.get(44640),
		21331,
		1,
		108,
		nil,
		1,
		nil,
		nil,
		nil,
		105,
		21331,
		nil,
		nil,
		nil,
		nil,
		21331
	},
	[21331002] = {
		21331002,
		0,
		Lang.get(44641),
		21331,
		2,
		119,
		nil,
		1,
		7
	},
	[21331003] = {
		21331003,
		0,
		Lang.get(44642),
		21331,
		3,
		301,
		nil,
		1,
		0
	},
	[21331004] = {
		21331004,
		5,
		Lang.get(44643),
		21331,
		4,
		108,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[21331005] = {
		21331005,
		0,
		Lang.get(37906),
		21331,
		5,
		229,
		{
			RTResTalkAction[2]
		},
		1,
		1,
		-1
	},
	[21331006] = {
		21331006,
		0,
		Lang.get(44644),
		21331,
		6,
		301,
		nil,
		1,
		0
	},
	[21331007] = {
		21331007,
		3,
		Lang.get(44645),
		21331,
		7,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		21332,
		[18] = 21332,
		[21] = 1
	},
	[21331008] = {
		21331008,
		5,
		Lang.get(44646),
		21331,
		8,
		627,
		{
			RTResTalkAction[59]
		},
		nil,
		nil,
		3
	},
	[21331009] = {
		21331009,
		0,
		Lang.get(44647),
		21331,
		9,
		301,
		{
			RTResTalkAction[60],
			RTResTalkAction[52]
		}
	},
	[21331010] = {
		21331010,
		0,
		Lang.get(44648),
		21331,
		10,
		627,
		{
			RTResTalkAction[58],
			RTResTalkAction[61]
		}
	},
	[21331011] = {
		21331011,
		0,
		Lang.get(44649),
		21331,
		11,
		229,
		{
			RTResTalkAction[54],
			RTResTalkAction[52]
		}
	},
	[21331012] = {
		21331012,
		7,
		"60",
		21331,
		12,
		229,
		{
			RTResTalkAction[50]
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
	[21331013] = {
		21331013,
		0,
		Lang.get(44650),
		21331,
		13,
		301,
		{
			RTResTalkAction[60]
		},
		nil,
		nil,
		3
	},
	[21331014] = {
		21331014,
		0,
		Lang.get(44651),
		21331,
		14,
		229,
		{
			RTResTalkAction[56],
			RTResTalkAction[61]
		}
	},
	[21331015] = {
		21331015,
		0,
		Lang.get(44652),
		21331,
		15,
		301,
		{
			RTResTalkAction[60],
			RTResTalkAction[50]
		}
	},
	[21331016] = {
		21331016,
		5,
		Lang.get(44653),
		21331,
		16,
		627,
		{
			RTResTalkAction[59],
			RTResTalkAction[61]
		}
	},
	[21331017] = {
		21331017,
		5,
		Lang.get(44654),
		21331,
		17,
		119,
		{
			RTResTalkAction[44],
			RTResTalkAction[52]
		}
	},
	[21331018] = {
		21331018,
		5,
		Lang.get(44655),
		21331,
		18,
		108,
		{
			RTResTalkAction[29],
			RTResTalkAction[10]
		}
	},
	[21335001] = {
		21335001,
		0,
		Lang.get(44656),
		21335,
		1,
		301,
		nil,
		1,
		nil,
		nil,
		nil,
		11,
		21335,
		nil,
		nil,
		nil,
		nil,
		21335
	},
	[21335002] = {
		21335002,
		0,
		Lang.get(44657),
		21335,
		2,
		119,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		21336
	},
	[21335003] = {
		21335003,
		0,
		Lang.get(44658),
		21335,
		3,
		108,
		nil,
		1
	},
	[21335004] = {
		21335004,
		0,
		Lang.get(44659),
		21335,
		4,
		229,
		nil,
		1,
		1
	},
	[21335005] = {
		21335005,
		0,
		Lang.get(44660),
		21335,
		5,
		627,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		21337
	},
	[21335006] = {
		21335006,
		0,
		Lang.get(44661),
		21335,
		6,
		108,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		21338
	},
	[21335007] = {
		21335007,
		0,
		Lang.get(44662),
		21335,
		7,
		119,
		nil,
		1,
		7
	},
	[21335008] = {
		21335008,
		0,
		Lang.get(44663),
		21335,
		8,
		301,
		{
			RTResTalkAction[60]
		},
		nil,
		nil,
		3
	},
	[21335009] = {
		21335009,
		5,
		Lang.get(44664),
		21335,
		9,
		108,
		{
			RTResTalkAction[29],
			RTResTalkAction[61]
		}
	},
	[21335010] = {
		21335010,
		0,
		Lang.get(44665),
		21335,
		10,
		119,
		{
			RTResTalkAction[16],
			RTResTalkAction[2]
		}
	},
	[21339001] = {
		21339001,
		0,
		Lang.get(44666),
		21339,
		1,
		301,
		nil,
		1,
		nil,
		nil,
		nil,
		16,
		21339,
		nil,
		nil,
		nil,
		nil,
		21339
	},
	[21339002] = {
		21339002,
		0,
		Lang.get(44667),
		21339,
		2,
		108,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		21340
	},
	[21339003] = {
		21339003,
		0,
		Lang.get(44668),
		21339,
		3,
		301,
		nil,
		1,
		0
	},
	[21339004] = {
		21339004,
		5,
		Lang.get(44669),
		21339,
		4,
		108,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[21339005] = {
		21339005,
		0,
		Lang.get(44670),
		21339,
		5,
		301,
		{
			RTResTalkAction[60],
			RTResTalkAction[2]
		}
	},
	[21339006] = {
		21339006,
		0,
		Lang.get(44671),
		21339,
		6,
		108,
		{
			RTResTalkAction[62],
			RTResTalkAction[61]
		}
	},
	[21339007] = {
		21339007,
		0,
		Lang.get(44672),
		21339,
		7,
		301,
		{
			RTResTalkAction[12],
			RTResTalkAction[63]
		}
	},
	[21339008] = {
		21339008,
		0,
		Lang.get(44673),
		21339,
		8,
		108,
		{
			RTResTalkAction[64],
			RTResTalkAction[63]
		}
	},
	[21339009] = {
		21339009,
		0,
		Lang.get(44674),
		21339,
		9,
		119,
		{
			RTResTalkAction[16],
			RTResTalkAction[2],
			RTResTalkAction[61]
		}
	},
	[21339010] = {
		21339010,
		0,
		Lang.get(44675),
		21339,
		10,
		301,
		{
			RTResTalkAction[65],
			RTResTalkAction[63]
		}
	},
	[21339011] = {
		21339011,
		0,
		Lang.get(44676),
		21339,
		11,
		119,
		{
			RTResTalkAction[66],
			RTResTalkAction[63]
		}
	},
	[21339012] = {
		21339012,
		0,
		Lang.get(44677),
		21339,
		12,
		108,
		{
			RTResTalkAction[43],
			RTResTalkAction[10],
			RTResTalkAction[61]
		}
	},
	[21341001] = {
		21341001,
		0,
		Lang.get(44678),
		21341,
		1,
		119,
		nil,
		1,
		nil,
		nil,
		nil,
		61,
		21341,
		nil,
		nil,
		nil,
		nil,
		21341
	},
	[21341002] = {
		21341002,
		0,
		Lang.get(44679),
		21341,
		2,
		134,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		21342
	},
	[21341003] = {
		21341003,
		0,
		Lang.get(44680),
		21341,
		3,
		301,
		nil,
		1,
		0
	},
	[21341004] = {
		21341004,
		5,
		Lang.get(44681),
		21341,
		4,
		108,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[21341005] = {
		21341005,
		0,
		Lang.get(44682),
		21341,
		5,
		107,
		{
			RTResTalkAction[22],
			RTResTalkAction[2]
		}
	},
	[21341006] = {
		21341006,
		0,
		Lang.get(44683),
		21341,
		6,
		141,
		{
			RTResTalkAction[17],
			RTResTalkAction[7]
		}
	},
	[21341007] = {
		21341007,
		0,
		Lang.get(44684),
		21341,
		7,
		301,
		{
			RTResTalkAction[60],
			RTResTalkAction[19]
		}
	},
	[21341008] = {
		21341008,
		0,
		Lang.get(44685),
		21341,
		8,
		119,
		{
			RTResTalkAction[24],
			RTResTalkAction[61]
		}
	},
	[21341009] = {
		21341009,
		5,
		Lang.get(44686),
		21341,
		9,
		108,
		{
			RTResTalkAction[29],
			RTResTalkAction[10]
		}
	},
	[21341010] = {
		21341010,
		0,
		Lang.get(44687),
		21341,
		10,
		141,
		{
			RTResTalkAction[17],
			RTResTalkAction[2]
		}
	},
	[21341011] = {
		21341011,
		3,
		Lang.get(23446),
		21341,
		11,
		605,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		21343,
		[21] = 1
	},
	[21341012] = {
		21341012,
		0,
		Lang.get(44688),
		21341,
		12,
		107,
		nil,
		1,
		3
	},
	[21341013] = {
		21341013,
		0,
		Lang.get(44689),
		21341,
		13,
		141,
		nil,
		1,
		0
	},
	[21345001] = {
		21345001,
		0,
		Lang.get(44690),
		21345,
		1,
		107,
		nil,
		1,
		3,
		nil,
		nil,
		122,
		21345,
		nil,
		nil,
		nil,
		nil,
		21345
	},
	[21345002] = {
		21345002,
		0,
		Lang.get(44691),
		21345,
		2,
		108,
		nil,
		1,
		0
	},
	[21345003] = {
		21345003,
		0,
		Lang.get(44692),
		21345,
		3,
		381,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[21345004] = {
		21345004,
		0,
		Lang.get(44693),
		21345,
		4,
		119,
		{
			RTResTalkAction[67],
			RTResTalkAction[25]
		}
	},
	[21345005] = {
		21345005,
		0,
		Lang.get(44694),
		21345,
		5,
		141,
		{
			RTResTalkAction[17],
			RTResTalkAction[10]
		}
	},
	[21345006] = {
		21345006,
		0,
		Lang.get(44695),
		21345,
		6,
		107,
		{
			RTResTalkAction[68],
			RTResTalkAction[19]
		}
	},
	[21345007] = {
		21345007,
		0,
		Lang.get(44696),
		21345,
		7,
		108,
		{
			RTResTalkAction[69],
			RTResTalkAction[7]
		}
	},
	[21345008] = {
		21345008,
		0,
		Lang.get(44697),
		21345,
		8,
		141,
		{
			RTResTalkAction[2]
		},
		1,
		nil,
		-1,
		nil,
		nil,
		21346
	},
	[21345009] = {
		21345009,
		0,
		Lang.get(44698),
		21345,
		9,
		301,
		nil,
		1
	},
	[21345010] = {
		21345010,
		0,
		Lang.get(44699),
		21345,
		10,
		108,
		nil,
		1,
		4
	},
	[21345011] = {
		21345011,
		0,
		Lang.get(44700),
		21345,
		11,
		301,
		nil,
		1,
		0
	},
	[21345012] = {
		21345012,
		0,
		Lang.get(44701),
		21345,
		12,
		107,
		nil,
		1,
		3
	},
	[21345013] = {
		21345013,
		0,
		Lang.get(44702),
		21345,
		13,
		301,
		nil,
		1,
		0
	},
	[21345014] = {
		21345014,
		5,
		Lang.get(44703),
		21345,
		14,
		108,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[21345015] = {
		21345015,
		0,
		Lang.get(44704),
		21345,
		15,
		141,
		{
			RTResTalkAction[17],
			RTResTalkAction[2]
		}
	},
	[21345016] = {
		21345016,
		0,
		Lang.get(44705),
		21345,
		16,
		107,
		{
			RTResTalkAction[70],
			RTResTalkAction[19]
		}
	},
	[21345017] = {
		21345017,
		0,
		Lang.get(44706),
		21345,
		17,
		301,
		{
			RTResTalkAction[60],
			RTResTalkAction[7]
		}
	},
	[21345018] = {
		21345018,
		0,
		Lang.get(44707),
		21345,
		18,
		119,
		{
			RTResTalkAction[24],
			RTResTalkAction[61]
		}
	},
	[21345019] = {
		21345019,
		0,
		Lang.get(45484),
		21345,
		19,
		107,
		{
			RTResTalkAction[10]
		},
		1,
		nil,
		-1,
		nil,
		nil,
		21347
	},
	[21345020] = {
		21345020,
		0,
		Lang.get(44709),
		21345,
		20,
		119,
		nil,
		1,
		1
	},
	[21345021] = {
		21345021,
		0,
		Lang.get(44710),
		21345,
		21,
		108,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		21348
	},
	[21345022] = {
		21345022,
		0,
		Lang.get(44711),
		21345,
		22,
		141,
		nil,
		1
	},
	[21345023] = {
		21345023,
		0,
		Lang.get(44712),
		21345,
		23,
		141,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		21349
	},
	[21345024] = {
		21345024,
		0,
		Lang.get(44713),
		21345,
		24,
		107,
		{
			RTResTalkAction[6]
		},
		nil,
		nil,
		3
	},
	[21345025] = {
		21345025,
		0,
		Lang.get(44714),
		21345,
		25,
		108,
		{
			RTResTalkAction[43],
			RTResTalkAction[7]
		}
	},
	[21345026] = {
		21345026,
		0,
		Lang.get(44715),
		21345,
		26,
		134,
		{
			RTResTalkAction[71],
			RTResTalkAction[2]
		}
	},
	[21345027] = {
		21345027,
		0,
		Lang.get(44716),
		21345,
		27,
		107,
		{
			RTResTalkAction[22],
			RTResTalkAction[35]
		}
	},
	[21345028] = {
		21345028,
		0,
		Lang.get(44717),
		21345,
		28,
		119,
		{
			RTResTalkAction[18],
			RTResTalkAction[7]
		}
	},
	[21350001] = {
		21350001,
		0,
		Lang.get(44718),
		21350,
		1,
		227,
		nil,
		1,
		nil,
		nil,
		nil,
		134,
		nil,
		1,
		nil,
		nil,
		nil,
		21350
	},
	[21350002] = {
		21350002,
		0,
		Lang.get(44719),
		21350,
		2,
		223,
		nil,
		1
	},
	[21350003] = {
		21350003,
		0,
		Lang.get(44720),
		21350,
		3,
		227,
		nil,
		1
	},
	[21350004] = {
		21350004,
		0,
		Lang.get(44721),
		21350,
		4,
		223,
		{
			RTResTalkAction[45]
		},
		nil,
		nil,
		3
	},
	[21350005] = {
		21350005,
		0,
		Lang.get(44722),
		21350,
		5,
		227,
		{
			RTResTalkAction[72],
			RTResTalkAction[47]
		}
	},
	[21350006] = {
		21350006,
		0,
		Lang.get(44723),
		21350,
		6,
		223,
		{
			RTResTalkAction[45],
			RTResTalkAction[73]
		}
	},
	[21350007] = {
		21350007,
		0,
		Lang.get(44724),
		21350,
		7,
		227,
		{
			RTResTalkAction[74],
			RTResTalkAction[47]
		}
	},
	[21350008] = {
		21350008,
		0,
		Lang.get(44725),
		21350,
		8,
		223,
		{
			RTResTalkAction[45],
			RTResTalkAction[73]
		}
	},
	[21350009] = {
		21350009,
		0,
		Lang.get(44726),
		21350,
		9,
		227,
		{
			RTResTalkAction[72],
			RTResTalkAction[47]
		}
	},
	[21351001] = {
		21351001,
		0,
		Lang.get(44727),
		21351,
		1,
		108,
		{
			RTResTalkAction[75]
		},
		nil,
		nil,
		3,
		nil,
		103,
		nil,
		1,
		nil,
		nil,
		nil,
		21351
	},
	[21351002] = {
		21351002,
		5,
		Lang.get(44728),
		21351,
		2,
		134,
		{
			RTResTalkAction[42],
			RTResTalkAction[2]
		}
	},
	[21351003] = {
		21351003,
		0,
		Lang.get(44729),
		21351,
		3,
		119,
		{
			RTResTalkAction[76],
			RTResTalkAction[35]
		}
	},
	[21351004] = {
		21351004,
		5,
		Lang.get(44730),
		21351,
		4,
		108,
		{
			RTResTalkAction[29],
			RTResTalkAction[10]
		}
	},
	[21351005] = {
		21351005,
		0,
		Lang.get(44731),
		21351,
		5,
		223,
		{
			RTResTalkAction[45],
			RTResTalkAction[2]
		}
	},
	[21351006] = {
		21351006,
		0,
		Lang.get(44732),
		21351,
		6,
		119,
		{
			RTResTalkAction[77],
			RTResTalkAction[47]
		}
	},
	[21351007] = {
		21351007,
		0,
		Lang.get(44733),
		21351,
		7,
		134,
		{
			RTResTalkAction[78],
			RTResTalkAction[10]
		}
	},
	[21351008] = {
		21351008,
		0,
		Lang.get(44734),
		21351,
		8,
		223,
		{
			RTResTalkAction[45],
			RTResTalkAction[35]
		}
	},
	[21351009] = {
		21351009,
		0,
		Lang.get(44735),
		21351,
		9,
		119,
		{
			RTResTalkAction[18],
			RTResTalkAction[47]
		}
	},
	[21351010] = {
		21351010,
		0,
		Lang.get(44736),
		21351,
		10,
		223,
		{
			RTResTalkAction[45],
			RTResTalkAction[10]
		}
	},
	[21351011] = {
		21351011,
		5,
		Lang.get(44737),
		21351,
		11,
		108,
		{
			RTResTalkAction[75],
			RTResTalkAction[47]
		}
	},
	[21351012] = {
		21351012,
		0,
		Lang.get(44738),
		21351,
		12,
		119,
		{
			RTResTalkAction[24],
			RTResTalkAction[2]
		}
	},
	[21351013] = {
		21351013,
		0,
		Lang.get(44739),
		21351,
		13,
		223,
		{
			RTResTalkAction[45],
			RTResTalkAction[10]
		}
	},
	[21351014] = {
		21351014,
		0,
		Lang.get(44740),
		21351,
		14,
		119,
		{
			RTResTalkAction[24],
			RTResTalkAction[47]
		}
	},
	[21351015] = {
		21351015,
		5,
		Lang.get(44741),
		21351,
		15,
		134,
		{
			RTResTalkAction[79],
			RTResTalkAction[10]
		}
	},
	[21351016] = {
		21351016,
		0,
		Lang.get(44742),
		21351,
		16,
		223,
		{
			RTResTalkAction[45],
			RTResTalkAction[35]
		}
	},
	[21351017] = {
		21351017,
		0,
		Lang.get(44743),
		21351,
		17,
		108,
		{
			RTResTalkAction[80],
			RTResTalkAction[47]
		}
	},
	[21351018] = {
		21351018,
		0,
		Lang.get(44744),
		21351,
		18,
		223,
		{
			RTResTalkAction[45],
			RTResTalkAction[2]
		}
	},
	[21351019] = {
		21351019,
		0,
		Lang.get(44745),
		21351,
		19,
		108,
		{
			RTResTalkAction[32],
			RTResTalkAction[47]
		}
	},
	[21351020] = {
		21351020,
		0,
		Lang.get(44746),
		21351,
		20,
		223,
		{
			RTResTalkAction[81],
			RTResTalkAction[2]
		}
	},
	[21351021] = {
		21351021,
		5,
		Lang.get(44747),
		21351,
		21,
		108,
		{
			RTResTalkAction[75],
			RTResTalkAction[47]
		}
	},
	[21351022] = {
		21351022,
		0,
		Lang.get(44748),
		21351,
		22,
		223,
		{
			RTResTalkAction[81],
			RTResTalkAction[2]
		}
	},
	[21351023] = {
		21351023,
		0,
		Lang.get(44749),
		21351,
		23,
		119,
		{
			RTResTalkAction[76],
			RTResTalkAction[47]
		}
	},
	[21351024] = {
		21351024,
		0,
		Lang.get(44750),
		21351,
		24,
		134,
		{
			RTResTalkAction[79],
			RTResTalkAction[10]
		}
	},
	[21351025] = {
		21351025,
		0,
		Lang.get(44751),
		21351,
		25,
		223,
		{
			RTResTalkAction[45],
			RTResTalkAction[35]
		}
	},
	[21351026] = {
		21351026,
		0,
		Lang.get(44752),
		21351,
		26,
		119,
		{
			RTResTalkAction[82],
			RTResTalkAction[47]
		}
	},
	[21352001] = {
		21352001,
		0,
		Lang.get(44753),
		21352,
		1,
		301,
		nil,
		1,
		nil,
		nil,
		nil,
		122,
		21352,
		nil,
		nil,
		nil,
		nil,
		21352
	},
	[21352002] = {
		21352002,
		0,
		Lang.get(44754),
		21352,
		2,
		141,
		nil,
		1
	},
	[21352003] = {
		21352003,
		0,
		Lang.get(44755),
		21352,
		3,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		21353
	},
	[21352004] = {
		21352004,
		0,
		Lang.get(44756),
		21352,
		4,
		107,
		nil,
		1
	},
	[21352005] = {
		21352005,
		0,
		Lang.get(44757),
		21352,
		5,
		301,
		nil,
		1
	},
	[21352006] = {
		21352006,
		0,
		Lang.get(44758),
		21352,
		6,
		108,
		{
			RTResTalkAction[43]
		},
		nil,
		nil,
		3
	},
	[21352007] = {
		21352007,
		0,
		Lang.get(44759),
		21352,
		7,
		119,
		{
			RTResTalkAction[16],
			RTResTalkAction[2]
		}
	},
	[21352008] = {
		21352008,
		0,
		Lang.get(44760),
		21352,
		8,
		381,
		{
			RTResTalkAction[23],
			RTResTalkAction[10]
		}
	},
	[21352009] = {
		21352009,
		0,
		Lang.get(44761),
		21352,
		9,
		107,
		{
			RTResTalkAction[22],
			RTResTalkAction[25]
		}
	},
	[21352010] = {
		21352010,
		0,
		Lang.get(44762),
		21352,
		10,
		141,
		{
			RTResTalkAction[17],
			RTResTalkAction[7]
		}
	},
	[21352011] = {
		21352011,
		0,
		Lang.get(44763),
		21352,
		11,
		119,
		{
			RTResTalkAction[24],
			RTResTalkAction[19]
		}
	},
	[21352012] = {
		21352012,
		0,
		Lang.get(44764),
		21352,
		12,
		107,
		{
			RTResTalkAction[22],
			RTResTalkAction[10]
		}
	},
	[21352013] = {
		21352013,
		0,
		Lang.get(44765),
		21352,
		13,
		141,
		{
			RTResTalkAction[17],
			RTResTalkAction[7]
		}
	},
	[21352014] = {
		21352014,
		0,
		Lang.get(44766),
		21352,
		14,
		108,
		{
			RTResTalkAction[69],
			RTResTalkAction[19]
		}
	},
	[21352015] = {
		21352015,
		0,
		Lang.get(44767),
		21352,
		15,
		119,
		{
			RTResTalkAction[83],
			RTResTalkAction[2]
		}
	},
	[21352016] = {
		21352016,
		0,
		Lang.get(44768),
		21352,
		16,
		141,
		{
			RTResTalkAction[17],
			RTResTalkAction[10]
		}
	},
	[21352017] = {
		21352017,
		4,
		nil,
		21352,
		17,
		300,
		{
			RTResTalkAction[19]
		},
		[27] = {
			{
				id = 21352018,
				branch_content = Lang.get(44769)
			}
		}
	},
	[21352018] = {
		21352018,
		0,
		Lang.get(44770),
		21352,
		18,
		107,
		{
			RTResTalkAction[22]
		}
	},
	[21352019] = {
		21352019,
		4,
		nil,
		21352,
		19,
		300,
		{
			RTResTalkAction[7]
		},
		[27] = {
			{
				id = 21352020,
				branch_content = Lang.get(44771)
			}
		}
	},
	[21352020] = {
		21352020,
		0,
		Lang.get(19271),
		21352,
		20,
		141,
		{
			RTResTalkAction[17]
		}
	},
	[21352021] = {
		21352021,
		0,
		Lang.get(44772),
		21352,
		21,
		141,
		{
			RTResTalkAction[19]
		},
		1,
		nil,
		-1
	},
	[21352022] = {
		21352022,
		0,
		Lang.get(44773),
		21352,
		22,
		141,
		nil,
		1
	},
	[21352023] = {
		21352023,
		0,
		Lang.get(44774),
		21352,
		23,
		141,
		nil,
		1
	},
	[21352024] = {
		21352024,
		0,
		Lang.get(44775),
		21352,
		24,
		107,
		nil,
		1
	},
	[21352025] = {
		21352025,
		0,
		Lang.get(44776),
		21352,
		25,
		108,
		{
			RTResTalkAction[43]
		},
		nil,
		nil,
		3
	},
	[21352026] = {
		21352026,
		0,
		Lang.get(44777),
		21352,
		26,
		301,
		{
			RTResTalkAction[60],
			RTResTalkAction[2]
		}
	},
	[21352027] = {
		21352027,
		0,
		Lang.get(44778),
		21352,
		27,
		301,
		{
			RTResTalkAction[60]
		}
	},
	[21352028] = {
		21352028,
		0,
		Lang.get(44779),
		21352,
		28,
		134,
		{
			RTResTalkAction[79],
			RTResTalkAction[61]
		}
	},
	[21352029] = {
		21352029,
		0,
		Lang.get(44780),
		21352,
		29,
		301,
		{
			RTResTalkAction[60],
			RTResTalkAction[35]
		}
	},
	[21352030] = {
		21352030,
		0,
		Lang.get(44781),
		21352,
		30,
		119,
		{
			RTResTalkAction[24],
			RTResTalkAction[61]
		}
	},
	[21352031] = {
		21352031,
		0,
		Lang.get(44782),
		21352,
		31,
		301,
		{
			RTResTalkAction[60],
			RTResTalkAction[10]
		}
	},
	[21352032] = {
		21352032,
		0,
		Lang.get(44783),
		21352,
		32,
		108,
		{
			RTResTalkAction[43],
			RTResTalkAction[61]
		}
	},
	[21352033] = {
		21352033,
		0,
		Lang.get(44784),
		21352,
		33,
		301,
		{
			RTResTalkAction[60],
			RTResTalkAction[2]
		}
	},
	[21352034] = {
		21352034,
		4,
		nil,
		21352,
		34,
		300,
		{
			RTResTalkAction[61]
		},
		[27] = {
			{
				id = 21352035,
				branch_content = Lang.get(44785)
			}
		}
	},
	[21352035] = {
		21352035,
		0,
		Lang.get(44786),
		21352,
		35,
		301,
		{
			RTResTalkAction[60]
		}
	},
	[21355001] = {
		21355001,
		0,
		Lang.get(44787),
		21355,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		[18] = 21355,
		[19] = 255
	},
	[21355002] = {
		21355002,
		0,
		Lang.get(44788),
		21355,
		2,
		228,
		{
			RTResTalkAction[4]
		}
	},
	[21355003] = {
		21355003,
		4,
		nil,
		21355,
		3,
		300,
		{
			RTResTalkAction[5]
		},
		[27] = {
			{
				id = 21355004,
				branch_content = Lang.get(44789)
			}
		}
	},
	[21355004] = {
		21355004,
		0,
		Lang.get(44790),
		21355,
		4,
		228,
		{
			RTResTalkAction[4]
		}
	},
	[21355005] = {
		21355005,
		5,
		Lang.get(44791),
		21355,
		5,
		229,
		{
			RTResTalkAction[84],
			RTResTalkAction[5]
		}
	},
	[21355006] = {
		21355006,
		0,
		Lang.get(44792),
		21355,
		6,
		301,
		{
			RTResTalkAction[60],
			RTResTalkAction[50]
		}
	},
	[21355007] = {
		21355007,
		0,
		Lang.get(44793),
		21355,
		7,
		229,
		{
			RTResTalkAction[84],
			RTResTalkAction[61]
		}
	},
	[21355008] = {
		21355008,
		0,
		Lang.get(44794),
		21355,
		8,
		301,
		{
			RTResTalkAction[60],
			RTResTalkAction[50]
		}
	},
	[21355009] = {
		21355009,
		0,
		Lang.get(44795),
		21355,
		9,
		229,
		{
			RTResTalkAction[85],
			RTResTalkAction[61]
		}
	},
	[21355010] = {
		21355010,
		4,
		nil,
		21355,
		10,
		300,
		{
			RTResTalkAction[50]
		},
		[27] = {
			{
				id = 21355011,
				branch_content = Lang.get(44796)
			}
		}
	},
	[21355011] = {
		21355011,
		5,
		Lang.get(44797),
		21355,
		11,
		229,
		{
			RTResTalkAction[84]
		}
	},
	[21355012] = {
		21355012,
		0,
		Lang.get(44798),
		21355,
		12,
		228,
		{
			RTResTalkAction[86],
			RTResTalkAction[50]
		}
	},
	[21355013] = {
		21355013,
		0,
		Lang.get(44799),
		21355,
		13,
		229,
		{
			RTResTalkAction[85],
			RTResTalkAction[5]
		}
	},
	[21355014] = {
		21355014,
		4,
		nil,
		21355,
		14,
		300,
		{
			RTResTalkAction[50]
		},
		[27] = {
			{
				id = 21355015,
				branch_content = Lang.get(44800)
			}
		}
	},
	[21355015] = {
		21355015,
		0,
		Lang.get(44801),
		21355,
		15,
		228,
		{
			RTResTalkAction[4]
		}
	},
	[21355016] = {
		21355016,
		0,
		Lang.get(44802),
		21355,
		16,
		229,
		{
			RTResTalkAction[54],
			RTResTalkAction[5]
		}
	},
	[21355017] = {
		21355017,
		0,
		Lang.get(44803),
		21355,
		17,
		229,
		{
			RTResTalkAction[54]
		}
	},
	[21355018] = {
		21355018,
		0,
		Lang.get(44804),
		21355,
		18,
		229,
		{
			RTResTalkAction[54]
		}
	},
	[21355019] = {
		21355019,
		3,
		Lang.get(44805),
		21355,
		19,
		605,
		{
			RTResTalkAction[50]
		},
		nil,
		nil,
		nil,
		1227,
		[21] = 1
	},
	[21355020] = {
		21355020,
		3,
		Lang.get(44806),
		21355,
		20,
		605,
		nil,
		nil,
		nil,
		nil,
		1067,
		[21] = 1
	},
	[21360001] = {
		21360001,
		3,
		Lang.get(44807),
		21360,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		138,
		[18] = 21360,
		[21] = 1
	},
	[21360002] = {
		21360002,
		0,
		Lang.get(44808),
		21360,
		2,
		228,
		nil,
		1
	},
	[21360003] = {
		21360003,
		0,
		Lang.get(44809),
		21360,
		3,
		229,
		nil,
		1
	},
	[21360004] = {
		21360004,
		0,
		Lang.get(44810),
		21360,
		4,
		227,
		{
			RTResTalkAction[74]
		},
		nil,
		nil,
		3
	},
	[21360005] = {
		21360005,
		4,
		nil,
		21360,
		5,
		300,
		{
			RTResTalkAction[73]
		},
		[27] = {
			{
				id = 21360006,
				branch_content = Lang.get(44811)
			}
		}
	},
	[21360006] = {
		21360006,
		0,
		Lang.get(44812),
		21360,
		6,
		227,
		{
			RTResTalkAction[74]
		}
	},
	[21360007] = {
		21360007,
		0,
		Lang.get(44813),
		21360,
		7,
		227,
		{
			RTResTalkAction[74]
		}
	},
	[21361001] = {
		21361001,
		0,
		Lang.get(44814),
		21361,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		138,
		[18] = 21361
	},
	[21361002] = {
		21361002,
		0,
		Lang.get(44815),
		21361,
		2,
		227,
		nil,
		1
	},
	[21361003] = {
		21361003,
		4,
		nil,
		21361,
		3,
		300,
		[27] = {
			{
				id = 21361004,
				branch_content = Lang.get(44816)
			}
		}
	},
	[21361004] = {
		21361004,
		0,
		Lang.get(44817),
		21361,
		4,
		227,
		nil,
		1
	},
	[21361005] = {
		21361005,
		4,
		nil,
		21361,
		5,
		300,
		[27] = {
			{
				id = 21361006,
				branch_content = Lang.get(22568)
			}
		}
	},
	[21361006] = {
		21361006,
		0,
		Lang.get(44818),
		21361,
		6,
		227,
		nil,
		1,
		1
	},
	[21361007] = {
		21361007,
		4,
		nil,
		21361,
		7,
		300,
		[27] = {
			{
				id = 21361008,
				branch_content = Lang.get(44819)
			}
		}
	},
	[21361008] = {
		21361008,
		0,
		Lang.get(44820),
		21361,
		8,
		227,
		{
			RTResTalkAction[72]
		},
		nil,
		nil,
		3
	},
	[21361009] = {
		21361009,
		0,
		Lang.get(44821),
		21361,
		9,
		300,
		{
			RTResTalkAction[73]
		}
	},
	[21361010] = {
		21361010,
		0,
		Lang.get(44822),
		21361,
		10,
		227,
		{
			RTResTalkAction[72]
		}
	},
	[21361011] = {
		21361011,
		0,
		Lang.get(44823),
		21361,
		11,
		227,
		{
			RTResTalkAction[72]
		}
	},
	[21361012] = {
		21361012,
		5,
		Lang.get(44824),
		21361,
		12,
		108,
		{
			RTResTalkAction[29],
			RTResTalkAction[73]
		}
	},
	[21361013] = {
		21361013,
		0,
		Lang.get(44825),
		21361,
		13,
		301,
		{
			RTResTalkAction[60],
			RTResTalkAction[2]
		}
	},
	[21361014] = {
		21361014,
		0,
		Lang.get(44826),
		21361,
		14,
		227,
		{
			RTResTalkAction[74],
			RTResTalkAction[61]
		}
	},
	[21361015] = {
		21361015,
		0,
		Lang.get(44827),
		21361,
		15,
		108,
		{
			RTResTalkAction[75],
			RTResTalkAction[73]
		}
	},
	[21361016] = {
		21361016,
		0,
		Lang.get(44828),
		21361,
		16,
		227,
		{
			RTResTalkAction[74],
			RTResTalkAction[2]
		}
	},
	[21361017] = {
		21361017,
		0,
		Lang.get(44829),
		21361,
		17,
		227,
		{
			RTResTalkAction[72]
		}
	},
	[21361018] = {
		21361018,
		5,
		Lang.get(44830),
		21361,
		18,
		108,
		{
			RTResTalkAction[29],
			RTResTalkAction[73]
		}
	},
	[21365001] = {
		21365001,
		0,
		Lang.get(44831),
		21365,
		1,
		108,
		nil,
		1,
		nil,
		nil,
		nil,
		10,
		21365,
		nil,
		nil,
		nil,
		nil,
		21365
	},
	[21365002] = {
		21365002,
		0,
		Lang.get(44832),
		21365,
		2,
		227,
		nil,
		1
	},
	[21365003] = {
		21365003,
		0,
		Lang.get(44833),
		21365,
		3,
		301,
		nil,
		1
	},
	[21365004] = {
		21365004,
		0,
		Lang.get(44834),
		21365,
		4,
		227,
		nil,
		1
	},
	[21365005] = {
		21365005,
		4,
		nil,
		21365,
		5,
		300,
		[27] = {
			{
				id = 21365006,
				branch_content = Lang.get(44835)
			}
		}
	},
	[21365006] = {
		21365006,
		0,
		Lang.get(44836),
		21365,
		6,
		227,
		nil,
		1,
		1
	},
	[21365007] = {
		21365007,
		4,
		nil,
		21365,
		7,
		300,
		[27] = {
			{
				id = 21365008,
				branch_content = Lang.get(44837)
			}
		}
	},
	[21365008] = {
		21365008,
		0,
		Lang.get(44838),
		21365,
		8,
		227,
		nil,
		1,
		1
	},
	[21365009] = {
		21365009,
		0,
		Lang.get(44839),
		21365,
		9,
		227,
		nil,
		1,
		1
	},
	[21365010] = {
		21365010,
		0,
		Lang.get(44840),
		21365,
		10,
		108,
		{
			RTResTalkAction[75]
		},
		nil,
		nil,
		3
	},
	[21365011] = {
		21365011,
		0,
		Lang.get(44841),
		21365,
		11,
		227,
		{
			RTResTalkAction[74],
			RTResTalkAction[2]
		}
	},
	[21365012] = {
		21365012,
		0,
		Lang.get(44842),
		21365,
		12,
		108,
		{
			RTResTalkAction[69],
			RTResTalkAction[73]
		}
	},
	[21365013] = {
		21365013,
		0,
		Lang.get(44843),
		21365,
		13,
		227,
		{
			RTResTalkAction[12],
			RTResTalkAction[87]
		}
	},
	[21365014] = {
		21365014,
		0,
		Lang.get(44844),
		21365,
		14,
		108,
		{
			RTResTalkAction[64],
			RTResTalkAction[87]
		}
	},
	[21365015] = {
		21365015,
		0,
		Lang.get(44845),
		21365,
		15,
		227,
		{
			RTResTalkAction[12],
			RTResTalkAction[88]
		}
	},
	[21365016] = {
		21365016,
		0,
		Lang.get(44846),
		21365,
		16,
		227,
		{
			RTResTalkAction[12],
			RTResTalkAction[88]
		}
	},
	[21365017] = {
		21365017,
		0,
		Lang.get(44847),
		21365,
		17,
		227,
		{
			RTResTalkAction[12],
			RTResTalkAction[88]
		}
	},
	[21365018] = {
		21365018,
		0,
		Lang.get(44848),
		21365,
		18,
		108,
		{
			RTResTalkAction[89],
			RTResTalkAction[87]
		}
	},
	[21365019] = {
		21365019,
		0,
		Lang.get(44849),
		21365,
		19,
		227,
		{
			RTResTalkAction[74],
			RTResTalkAction[2]
		}
	},
	[21365020] = {
		21365020,
		0,
		Lang.get(44850),
		21365,
		20,
		227,
		{
			RTResTalkAction[72]
		}
	},
	[21365021] = {
		21365021,
		0,
		Lang.get(44851),
		21365,
		21,
		301,
		{
			RTResTalkAction[60],
			RTResTalkAction[73]
		}
	},
	[21365022] = {
		21365022,
		0,
		Lang.get(44852),
		21365,
		22,
		227,
		{
			RTResTalkAction[74],
			RTResTalkAction[61]
		}
	},
	[21365023] = {
		21365023,
		0,
		Lang.get(44853),
		21365,
		23,
		227,
		{
			RTResTalkAction[74]
		}
	},
	[21365024] = {
		21365024,
		3,
		Lang.get(44854),
		21365,
		24,
		605,
		{
			RTResTalkAction[73]
		},
		[21] = 1
	},
	[21365025] = {
		21365025,
		0,
		Lang.get(44855),
		21365,
		25,
		227,
		{
			RTResTalkAction[72]
		}
	},
	[21365026] = {
		21365026,
		0,
		Lang.get(44856),
		21365,
		26,
		227,
		{
			RTResTalkAction[74]
		}
	},
	[21370001] = {
		21370001,
		0,
		Lang.get(44857),
		21370,
		1,
		108,
		nil,
		1,
		4,
		nil,
		1067,
		58,
		21370,
		nil,
		nil,
		nil,
		nil,
		21370
	},
	[21370002] = {
		21370002,
		0,
		Lang.get(32735),
		21370,
		2,
		121,
		nil,
		1,
		0
	},
	[21370003] = {
		21370003,
		0,
		Lang.get(44858),
		21370,
		3,
		108,
		nil,
		1,
		1
	},
	[21370004] = {
		21370004,
		0,
		"……",
		21370,
		4,
		121,
		nil,
		1,
		0
	},
	[21370005] = {
		21370005,
		0,
		Lang.get(44859),
		21370,
		5,
		108,
		nil,
		1,
		1
	},
	[21370006] = {
		21370006,
		0,
		"……",
		21370,
		6,
		121,
		nil,
		1,
		0
	},
	[21370007] = {
		21370007,
		0,
		Lang.get(44860),
		21370,
		7,
		108,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		21371
	},
	[21370008] = {
		21370008,
		0,
		Lang.get(18191),
		21370,
		8,
		121,
		nil,
		1
	},
	[21370009] = {
		21370009,
		4,
		nil,
		21370,
		9,
		300,
		[27] = {
			{
				id = 21370010,
				branch_content = Lang.get(44861)
			}
		}
	},
	[21370010] = {
		21370010,
		5,
		Lang.get(44862),
		21370,
		10,
		108,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[21370011] = {
		21370011,
		0,
		Lang.get(44863),
		21370,
		11,
		121,
		{
			RTResTalkAction[90],
			RTResTalkAction[2]
		}
	},
	[21370012] = {
		21370012,
		0,
		Lang.get(44864),
		21370,
		12,
		121,
		{
			RTResTalkAction[90]
		}
	},
	[21370013] = {
		21370013,
		0,
		Lang.get(44865),
		21370,
		13,
		108,
		{
			RTResTalkAction[91],
			RTResTalkAction[92]
		}
	},
	[21370014] = {
		21370014,
		0,
		Lang.get(44866),
		21370,
		14,
		121,
		{
			RTResTalkAction[91],
			RTResTalkAction[27]
		}
	},
	[21370015] = {
		21370015,
		0,
		Lang.get(44867),
		21370,
		15,
		121,
		{
			RTResTalkAction[90],
			RTResTalkAction[2]
		}
	},
	[21370016] = {
		21370016,
		0,
		Lang.get(26456),
		21370,
		16,
		227,
		{
			RTResTalkAction[74],
			RTResTalkAction[93]
		}
	},
	[21370017] = {
		21370017,
		0,
		Lang.get(44868),
		21370,
		17,
		108,
		{
			RTResTalkAction[94],
			RTResTalkAction[73]
		}
	},
	[21370018] = {
		21370018,
		0,
		Lang.get(44869),
		21370,
		18,
		301,
		{
			RTResTalkAction[2]
		},
		1
	},
	[21370019] = {
		21370019,
		0,
		Lang.get(44870),
		21370,
		19,
		127,
		nil,
		1,
		nil,
		-1,
		nil,
		nil,
		21372
	},
	[21370020] = {
		21370020,
		0,
		Lang.get(44871),
		21370,
		20,
		301,
		nil,
		1
	},
	[21370021] = {
		21370021,
		0,
		Lang.get(44872),
		21370,
		21,
		127,
		{
			RTResTalkAction[95]
		},
		nil,
		nil,
		3
	},
	[21370022] = {
		21370022,
		0,
		Lang.get(44873),
		21370,
		22,
		301,
		{
			RTResTalkAction[96],
			RTResTalkAction[97]
		}
	},
	[21370023] = {
		21370023,
		0,
		Lang.get(44874),
		21370,
		23,
		127,
		{
			RTResTalkAction[96],
			RTResTalkAction[98]
		}
	},
	[21370024] = {
		21370024,
		0,
		Lang.get(44875),
		21370,
		24,
		301,
		{
			RTResTalkAction[96],
			RTResTalkAction[97]
		}
	},
	[21370025] = {
		21370025,
		0,
		Lang.get(44876),
		21370,
		25,
		127,
		{
			RTResTalkAction[96],
			RTResTalkAction[98]
		}
	},
	[21370026] = {
		21370026,
		0,
		Lang.get(44877),
		21370,
		26,
		301,
		{
			RTResTalkAction[96],
			RTResTalkAction[97]
		}
	},
	[21370027] = {
		21370027,
		0,
		Lang.get(44878),
		21370,
		27,
		108,
		{
			RTResTalkAction[61],
			RTResTalkAction[99]
		},
		1,
		3,
		-1,
		nil,
		nil,
		21373
	},
	[21370028] = {
		21370028,
		4,
		nil,
		21370,
		28,
		300,
		[27] = {
			{
				id = 21370029,
				branch_content = Lang.get(44879)
			}
		}
	},
	[21370029] = {
		21370029,
		0,
		Lang.get(44880),
		21370,
		29,
		301,
		nil,
		1,
		0
	},
	[21370030] = {
		21370030,
		0,
		Lang.get(44881),
		21370,
		30,
		127,
		nil,
		1
	},
	[21370031] = {
		21370031,
		0,
		Lang.get(44882),
		21370,
		31,
		121,
		nil,
		1
	},
	[21370032] = {
		21370032,
		0,
		Lang.get(44883),
		21370,
		32,
		108,
		{
			RTResTalkAction[100]
		},
		1,
		nil,
		3,
		[20] = 380
	},
	[21375001] = {
		21375001,
		3,
		Lang.get(44884),
		21375,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		21375,
		[18] = 21375,
		[21] = 1
	},
	[21375002] = {
		21375002,
		0,
		Lang.get(44885),
		21375,
		2,
		300
	},
	[21375003] = {
		21375003,
		0,
		Lang.get(44886),
		21375,
		3,
		300
	},
	[21375004] = {
		21375004,
		0,
		Lang.get(44887),
		21375,
		4,
		119,
		{
			RTResTalkAction[101]
		},
		nil,
		nil,
		3
	},
	[21375005] = {
		21375005,
		0,
		Lang.get(44888),
		21375,
		5,
		107,
		{
			RTResTalkAction[68],
			RTResTalkAction[10]
		}
	},
	[21375006] = {
		21375006,
		0,
		Lang.get(44889),
		21375,
		6,
		119,
		{
			RTResTalkAction[21],
			RTResTalkAction[7]
		}
	},
	[21375007] = {
		21375007,
		5,
		Lang.get(44890),
		21375,
		7,
		108,
		{
			RTResTalkAction[75],
			RTResTalkAction[10]
		}
	},
	[21375008] = {
		21375008,
		0,
		Lang.get(44891),
		21375,
		8,
		107,
		{
			RTResTalkAction[102],
			RTResTalkAction[2]
		}
	},
	[21375009] = {
		21375009,
		0,
		Lang.get(44892),
		21375,
		9,
		121,
		{
			RTResTalkAction[90],
			RTResTalkAction[7]
		}
	},
	[21375010] = {
		21375010,
		0,
		Lang.get(44893),
		21375,
		10,
		108,
		{
			RTResTalkAction[93]
		},
		1,
		2,
		-1,
		nil,
		6,
		21376,
		nil,
		nil,
		nil,
		nil,
		21376
	},
	[21375011] = {
		21375011,
		0,
		Lang.get(44894),
		21375,
		11,
		141,
		nil,
		1,
		0
	},
	[21375012] = {
		21375012,
		0,
		Lang.get(44895),
		21375,
		12,
		119,
		nil,
		1,
		10
	},
	[21375013] = {
		21375013,
		0,
		Lang.get(44896),
		21375,
		13,
		141,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		21377
	},
	[21375014] = {
		21375014,
		0,
		Lang.get(44897),
		21375,
		14,
		107,
		nil,
		1,
		3
	},
	[21375015] = {
		21375015,
		0,
		Lang.get(19747),
		21375,
		15,
		141,
		nil,
		1,
		0
	},
	[21375016] = {
		21375016,
		0,
		Lang.get(44898),
		21375,
		16,
		107,
		{
			RTResTalkAction[22]
		},
		nil,
		nil,
		3
	},
	[21375017] = {
		21375017,
		0,
		Lang.get(44899),
		21375,
		17,
		107,
		{
			RTResTalkAction[22]
		}
	},
	[21375018] = {
		21375018,
		0,
		Lang.get(44900),
		21375,
		18,
		108,
		{
			RTResTalkAction[75],
			RTResTalkAction[7]
		}
	},
	[21375019] = {
		21375019,
		0,
		Lang.get(44901),
		21375,
		19,
		119,
		{
			RTResTalkAction[65],
			RTResTalkAction[27]
		}
	},
	[21375020] = {
		21375020,
		0,
		Lang.get(44902),
		21375,
		20,
		108,
		{
			RTResTalkAction[65],
			RTResTalkAction[103]
		}
	},
	[21375021] = {
		21375021,
		0,
		Lang.get(44903),
		21375,
		21,
		107,
		{
			RTResTalkAction[104],
			RTResTalkAction[10],
			RTResTalkAction[2]
		}
	},
	[21375022] = {
		21375022,
		0,
		Lang.get(44904),
		21375,
		22,
		134,
		{
			RTResTalkAction[7]
		},
		1,
		1,
		-1,
		nil,
		nil,
		21378
	},
	[21375023] = {
		21375023,
		0,
		Lang.get(44905),
		21375,
		23,
		119,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		21379
	},
	[21375024] = {
		21375024,
		0,
		Lang.get(44906),
		21375,
		24,
		107,
		nil,
		1
	},
	[21375025] = {
		21375025,
		0,
		Lang.get(44907),
		21375,
		25,
		108,
		nil,
		1,
		2
	},
	[21380001] = {
		21380001,
		0,
		Lang.get(44908),
		21380,
		1,
		223,
		{
			RTResTalkAction[45]
		},
		nil,
		nil,
		3,
		nil,
		134,
		[18] = 21380
	},
	[21380002] = {
		21380002,
		5,
		Lang.get(44909),
		21380,
		2,
		108,
		{
			RTResTalkAction[29],
			RTResTalkAction[47]
		}
	},
	[21380003] = {
		21380003,
		5,
		Lang.get(44910),
		21380,
		3,
		134,
		{
			RTResTalkAction[42],
			RTResTalkAction[2]
		}
	},
	[21380004] = {
		21380004,
		0,
		Lang.get(44911),
		21380,
		4,
		223,
		{
			RTResTalkAction[45],
			RTResTalkAction[35]
		}
	},
	[21380005] = {
		21380005,
		0,
		Lang.get(44912),
		21380,
		5,
		119,
		{
			RTResTalkAction[16],
			RTResTalkAction[47]
		}
	},
	[21380006] = {
		21380006,
		0,
		Lang.get(44913),
		21380,
		6,
		223,
		{
			RTResTalkAction[45],
			RTResTalkAction[10]
		}
	},
	[21380007] = {
		21380007,
		0,
		Lang.get(44914),
		21380,
		7,
		223,
		{
			RTResTalkAction[45]
		}
	},
	[21380008] = {
		21380008,
		0,
		Lang.get(44915),
		21380,
		8,
		108,
		{
			RTResTalkAction[105],
			RTResTalkAction[106]
		}
	},
	[21380009] = {
		21380009,
		0,
		Lang.get(44916),
		21380,
		9,
		223,
		{
			RTResTalkAction[105],
			RTResTalkAction[27]
		}
	},
	[21380010] = {
		21380010,
		0,
		Lang.get(44917),
		21380,
		10,
		119,
		{
			RTResTalkAction[18],
			RTResTalkAction[47],
			RTResTalkAction[2]
		}
	},
	[21380011] = {
		21380011,
		0,
		Lang.get(44918),
		21380,
		11,
		223,
		{
			RTResTalkAction[45],
			RTResTalkAction[10]
		}
	},
	[21380012] = {
		21380012,
		5,
		Lang.get(44919),
		21380,
		12,
		108,
		{
			RTResTalkAction[29],
			RTResTalkAction[47]
		}
	},
	[21380013] = {
		21380013,
		0,
		Lang.get(44920),
		21380,
		13,
		223,
		{
			RTResTalkAction[45],
			RTResTalkAction[2]
		}
	},
	[21380014] = {
		21380014,
		0,
		Lang.get(44921),
		21380,
		14,
		119,
		{
			RTResTalkAction[24],
			RTResTalkAction[47]
		}
	},
	[21380015] = {
		21380015,
		0,
		Lang.get(44922),
		21380,
		15,
		108,
		{
			RTResTalkAction[3],
			RTResTalkAction[10]
		}
	},
	[21380016] = {
		21380016,
		0,
		Lang.get(44923),
		21380,
		16,
		108,
		{
			RTResTalkAction[107]
		}
	},
	[21380017] = {
		21380017,
		0,
		Lang.get(44924),
		21380,
		17,
		223,
		{
			RTResTalkAction[12],
			RTResTalkAction[108]
		}
	},
	[21380018] = {
		21380018,
		0,
		Lang.get(44925),
		21380,
		18,
		119,
		{
			RTResTalkAction[16],
			RTResTalkAction[2],
			RTResTalkAction[47]
		}
	},
	[21380019] = {
		21380019,
		0,
		Lang.get(44926),
		21380,
		19,
		134,
		{
			RTResTalkAction[79],
			RTResTalkAction[10]
		}
	},
	[21380020] = {
		21380020,
		5,
		Lang.get(44927),
		21380,
		20,
		108,
		{
			RTResTalkAction[29],
			RTResTalkAction[35]
		}
	},
	[21380021] = {
		21380021,
		5,
		Lang.get(44928),
		21380,
		21,
		119,
		{
			RTResTalkAction[21],
			RTResTalkAction[2]
		}
	},
	[21380022] = {
		21380022,
		5,
		Lang.get(44929),
		21380,
		22,
		134,
		{
			RTResTalkAction[41],
			RTResTalkAction[10]
		}
	},
	[21380023] = {
		21380023,
		3,
		Lang.get(44930),
		21380,
		23,
		605,
		{
			RTResTalkAction[35]
		},
		[21] = 1
	},
	[21380024] = {
		21380024,
		0,
		Lang.get(44931),
		21380,
		24,
		119,
		{
			RTResTalkAction[109]
		}
	},
	[21380025] = {
		21380025,
		0,
		Lang.get(44932),
		21380,
		25,
		223,
		{
			RTResTalkAction[45],
			RTResTalkAction[10]
		}
	},
	[21385001] = {
		21385001,
		0,
		Lang.get(44933),
		21385,
		1,
		226,
		nil,
		1,
		nil,
		nil,
		nil,
		138,
		21385,
		nil,
		nil,
		nil,
		nil,
		21385
	},
	[21385002] = {
		21385002,
		0,
		Lang.get(44934),
		21385,
		2,
		226,
		nil,
		1
	},
	[21385003] = {
		21385003,
		0,
		Lang.get(44935),
		21385,
		3,
		226,
		nil,
		1
	},
	[21385004] = {
		21385004,
		0,
		Lang.get(44936),
		21385,
		4,
		226,
		nil,
		1
	},
	[21385005] = {
		21385005,
		3,
		Lang.get(44930),
		21385,
		5,
		605,
		[21] = 1
	},
	[21385006] = {
		21385006,
		0,
		Lang.get(19557),
		21385,
		6,
		226,
		nil,
		1,
		2
	},
	[21385007] = {
		21385007,
		0,
		Lang.get(44937),
		21385,
		7,
		119,
		{
			RTResTalkAction[110]
		},
		nil,
		nil,
		3
	},
	[21385008] = {
		21385008,
		0,
		Lang.get(44938),
		21385,
		8,
		134,
		{
			RTResTalkAction[79],
			RTResTalkAction[10]
		}
	},
	[21385009] = {
		21385009,
		5,
		Lang.get(44939),
		21385,
		9,
		108,
		{
			RTResTalkAction[1],
			RTResTalkAction[35]
		}
	},
	[21387001] = {
		21387001,
		0,
		Lang.get(44940),
		21387,
		1,
		108,
		nil,
		1,
		2,
		nil,
		nil,
		10,
		21387,
		nil,
		nil,
		nil,
		nil,
		21387
	},
	[21387002] = {
		21387002,
		0,
		Lang.get(44941),
		21387,
		2,
		119,
		nil,
		1,
		10
	},
	[21387003] = {
		21387003,
		0,
		Lang.get(44942),
		21387,
		3,
		108,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		21387
	},
	[21387004] = {
		21387004,
		0,
		Lang.get(44943),
		21387,
		4,
		108,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		21388
	},
	[21387005] = {
		21387005,
		0,
		Lang.get(44944),
		21387,
		5,
		107,
		{
			RTResTalkAction[22]
		},
		nil,
		nil,
		3
	},
	[21387006] = {
		21387006,
		0,
		Lang.get(44945),
		21387,
		6,
		301,
		{
			RTResTalkAction[60],
			RTResTalkAction[7]
		}
	},
	[21387007] = {
		21387007,
		5,
		Lang.get(44946),
		21387,
		7,
		108,
		{
			RTResTalkAction[29],
			RTResTalkAction[61]
		}
	},
	[21387008] = {
		21387008,
		0,
		Lang.get(44947),
		21387,
		8,
		107,
		{
			RTResTalkAction[2]
		},
		1,
		3,
		-1
	},
	[21387009] = {
		21387009,
		0,
		Lang.get(44948),
		21387,
		9,
		121,
		nil,
		1,
		0
	},
	[21387010] = {
		21387010,
		0,
		Lang.get(44949),
		21387,
		10,
		121,
		nil,
		1
	},
	[21387011] = {
		21387011,
		0,
		Lang.get(44950),
		21387,
		11,
		226,
		nil,
		1,
		2
	},
	[21387012] = {
		21387012,
		0,
		Lang.get(44951),
		21387,
		12,
		108,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		21389
	},
	[21387013] = {
		21387013,
		0,
		Lang.get(44952),
		21387,
		13,
		141,
		nil,
		1
	},
	[21387014] = {
		21387014,
		0,
		Lang.get(44953),
		21387,
		14,
		226,
		{
			RTResTalkAction[111]
		},
		nil,
		nil,
		3
	},
	[21387015] = {
		21387015,
		4,
		nil,
		21387,
		15,
		300,
		{
			RTResTalkAction[112]
		},
		[27] = {
			{
				id = 21387016,
				branch_content = Lang.get(44954)
			}
		}
	},
	[21387016] = {
		21387016,
		0,
		Lang.get(44955),
		21387,
		16,
		226,
		{
			RTResTalkAction[113]
		}
	},
	[21387017] = {
		21387017,
		7,
		"61",
		21387,
		17,
		226,
		{
			RTResTalkAction[112]
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
	[21387018] = {
		21387018,
		0,
		Lang.get(44956),
		21387,
		18,
		226,
		{
			RTResTalkAction[113]
		},
		nil,
		nil,
		3
	},
	[21387019] = {
		21387019,
		0,
		Lang.get(44957),
		21387,
		19,
		226,
		{
			RTResTalkAction[111]
		}
	},
	[21387020] = {
		21387020,
		0,
		Lang.get(44958),
		21387,
		20,
		107,
		{
			RTResTalkAction[6],
			RTResTalkAction[112]
		}
	},
	[21387021] = {
		21387021,
		5,
		Lang.get(44959),
		21387,
		21,
		108,
		{
			RTResTalkAction[29],
			RTResTalkAction[7]
		}
	},
	[21387022] = {
		21387022,
		0,
		Lang.get(44960),
		21387,
		22,
		119,
		{
			RTResTalkAction[16],
			RTResTalkAction[2]
		}
	},
	[21387023] = {
		21387023,
		5,
		Lang.get(44961),
		21387,
		23,
		108,
		{
			RTResTalkAction[1],
			RTResTalkAction[10]
		}
	},
	[21390001] = {
		21390001,
		0,
		Lang.get(44962),
		21390,
		1,
		134,
		nil,
		1,
		1,
		nil,
		nil,
		122,
		21390,
		nil,
		nil,
		nil,
		nil,
		21390
	},
	[21390002] = {
		21390002,
		0,
		Lang.get(44963),
		21390,
		2,
		107,
		nil,
		1,
		3
	},
	[21390003] = {
		21390003,
		0,
		Lang.get(44964),
		21390,
		3,
		134,
		nil,
		1,
		1
	},
	[21390004] = {
		21390004,
		0,
		Lang.get(44965),
		21390,
		4,
		226,
		nil,
		1,
		1
	},
	[21390005] = {
		21390005,
		0,
		Lang.get(44966),
		21390,
		5,
		108,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		21391
	},
	[21390006] = {
		21390006,
		0,
		Lang.get(44863),
		21390,
		6,
		121,
		nil,
		1,
		0
	},
	[21390007] = {
		21390007,
		0,
		Lang.get(44967),
		21390,
		7,
		127,
		nil,
		1
	},
	[21390008] = {
		21390008,
		0,
		Lang.get(44968),
		21390,
		8,
		108,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		21392
	},
	[21390009] = {
		21390009,
		0,
		Lang.get(44969),
		21390,
		9,
		226,
		nil,
		1,
		2
	},
	[21390010] = {
		21390010,
		0,
		Lang.get(44970),
		21390,
		10,
		107,
		nil,
		1,
		7
	},
	[21390011] = {
		21390011,
		5,
		Lang.get(44971),
		21390,
		11,
		108,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[21390012] = {
		21390012,
		0,
		Lang.get(19770),
		21390,
		12,
		121,
		{
			RTResTalkAction[90],
			RTResTalkAction[2]
		}
	},
	[21390013] = {
		21390013,
		0,
		Lang.get(44972),
		21390,
		13,
		127,
		{
			RTResTalkAction[95],
			RTResTalkAction[93]
		}
	},
	[21390014] = {
		21390014,
		0,
		Lang.get(44973),
		21390,
		14,
		107,
		{
			RTResTalkAction[6],
			RTResTalkAction[99]
		}
	},
	[21390015] = {
		21390015,
		5,
		Lang.get(44974),
		21390,
		15,
		108,
		{
			RTResTalkAction[29],
			RTResTalkAction[7]
		}
	},
	[21390016] = {
		21390016,
		0,
		Lang.get(44975),
		21390,
		16,
		119,
		{
			RTResTalkAction[24],
			RTResTalkAction[2]
		}
	},
	[21390017] = {
		21390017,
		0,
		Lang.get(44976),
		21390,
		17,
		108,
		{
			RTResTalkAction[114],
			RTResTalkAction[10]
		}
	},
	[21390018] = {
		21390018,
		4,
		nil,
		21390,
		18,
		300,
		{
			RTResTalkAction[2]
		},
		[27] = {
			{
				id = 21390019,
				branch_content = Lang.get(44977)
			}
		}
	},
	[21390019] = {
		21390019,
		0,
		Lang.get(27595),
		21390,
		19,
		226,
		{
			RTResTalkAction[111]
		}
	},
	[21390020] = {
		21390020,
		0,
		Lang.get(45325),
		21390,
		20,
		226,
		{
			RTResTalkAction[113]
		}
	},
	[21390021] = {
		21390021,
		4,
		nil,
		21390,
		21,
		300,
		{
			RTResTalkAction[112]
		},
		[27] = {
			{
				id = 21390022,
				branch_content = Lang.get(44979)
			}
		}
	},
	[21390022] = {
		21390022,
		0,
		Lang.get(44980),
		21390,
		22,
		226,
		{
			RTResTalkAction[111]
		}
	},
	[21390023] = {
		21390023,
		0,
		Lang.get(44981),
		21390,
		23,
		226,
		{
			RTResTalkAction[113]
		}
	},
	[21393001] = {
		21393001,
		0,
		Lang.get(44982),
		21393,
		1,
		141,
		nil,
		1,
		nil,
		nil,
		nil,
		61,
		21393,
		nil,
		nil,
		nil,
		nil,
		21393
	},
	[21393002] = {
		21393002,
		0,
		Lang.get(44983),
		21393,
		2,
		226,
		nil,
		1
	},
	[21393003] = {
		21393003,
		0,
		Lang.get(44984),
		21393,
		3,
		226,
		nil,
		1
	},
	[21393004] = {
		21393004,
		0,
		Lang.get(44985),
		21393,
		4,
		108,
		nil,
		1,
		2
	},
	[21393005] = {
		21393005,
		0,
		Lang.get(44986),
		21393,
		5,
		226,
		{
			RTResTalkAction[115]
		}
	},
	[21393006] = {
		21393006,
		4,
		nil,
		21393,
		6,
		300,
		{
			RTResTalkAction[112]
		},
		[27] = {
			{
				id = 21393007,
				branch_content = Lang.get(26636)
			}
		}
	},
	[21393007] = {
		21393007,
		0,
		Lang.get(44987),
		21393,
		7,
		226,
		{
			RTResTalkAction[115]
		}
	},
	[21393008] = {
		21393008,
		0,
		Lang.get(44988),
		21393,
		8,
		108,
		{
			RTResTalkAction[116],
			RTResTalkAction[117]
		}
	},
	[21393009] = {
		21393009,
		0,
		Lang.get(44989),
		21393,
		9,
		226,
		{
			RTResTalkAction[118],
			RTResTalkAction[27]
		}
	},
	[21393010] = {
		21393010,
		0,
		Lang.get(44990),
		21393,
		10,
		108,
		{
			RTResTalkAction[118],
			RTResTalkAction[106]
		}
	},
	[21393011] = {
		21393011,
		0,
		Lang.get(44991),
		21393,
		11,
		226,
		{
			RTResTalkAction[113],
			RTResTalkAction[2]
		}
	},
	[21393012] = {
		21393012,
		4,
		nil,
		21393,
		12,
		300,
		{
			RTResTalkAction[112]
		},
		[27] = {
			{
				id = 21393013,
				branch_content = Lang.get(44992)
			}
		}
	},
	[21393013] = {
		21393013,
		0,
		Lang.get(44993),
		21393,
		13,
		226,
		{
			RTResTalkAction[111]
		}
	},
	[21393014] = {
		21393014,
		0,
		Lang.get(44994),
		21393,
		14,
		107,
		{
			RTResTalkAction[112]
		},
		1,
		3,
		nil,
		nil,
		nil,
		21394,
		nil,
		nil,
		nil,
		nil,
		21394
	},
	[21393015] = {
		21393015,
		0,
		Lang.get(44995),
		21393,
		15,
		226,
		nil,
		1,
		2
	},
	[21393016] = {
		21393016,
		0,
		Lang.get(44996),
		21393,
		16,
		141,
		nil,
		1,
		0
	},
	[21393017] = {
		21393017,
		0,
		Lang.get(44997),
		21393,
		17,
		226,
		nil,
		1
	},
	[21393018] = {
		21393018,
		0,
		Lang.get(44998),
		21393,
		18,
		107,
		nil,
		1
	},
	[21393019] = {
		21393019,
		0,
		Lang.get(44999),
		21393,
		19,
		226,
		nil,
		1
	},
	[21393020] = {
		21393020,
		0,
		Lang.get(45000),
		21393,
		20,
		107,
		nil,
		1,
		6,
		nil,
		nil,
		nil,
		21395
	},
	[21393021] = {
		21393021,
		0,
		Lang.get(45001),
		21393,
		21,
		108,
		{
			RTResTalkAction[75]
		},
		nil,
		nil,
		3
	},
	[21393022] = {
		21393022,
		0,
		Lang.get(45002),
		21393,
		22,
		141,
		{
			RTResTalkAction[17],
			RTResTalkAction[2]
		}
	},
	[21393023] = {
		21393023,
		0,
		Lang.get(45003),
		21393,
		23,
		226,
		{
			RTResTalkAction[111],
			RTResTalkAction[19]
		}
	},
	[21393024] = {
		21393024,
		0,
		Lang.get(45004),
		21393,
		24,
		107,
		{
			RTResTalkAction[28],
			RTResTalkAction[119]
		}
	},
	[21393025] = {
		21393025,
		0,
		Lang.get(45005),
		21393,
		25,
		226,
		{
			RTResTalkAction[28],
			RTResTalkAction[119]
		}
	},
	[21393026] = {
		21393026,
		0,
		Lang.get(45006),
		21393,
		26,
		121,
		{
			RTResTalkAction[90],
			RTResTalkAction[7],
			RTResTalkAction[112]
		}
	},
	[21393027] = {
		21393027,
		0,
		Lang.get(45007),
		21393,
		27,
		127,
		{
			RTResTalkAction[95],
			RTResTalkAction[93]
		}
	},
	[21393028] = {
		21393028,
		0,
		Lang.get(45008),
		21393,
		28,
		226,
		{
			RTResTalkAction[113],
			RTResTalkAction[99]
		}
	},
	[21393029] = {
		21393029,
		4,
		nil,
		21393,
		29,
		300,
		{
			RTResTalkAction[112]
		},
		[27] = {
			{
				id = 21393030,
				branch_content = Lang.get(45009)
			}
		}
	},
	[21393030] = {
		21393030,
		0,
		Lang.get(45010),
		21393,
		30,
		226,
		{
			RTResTalkAction[111]
		}
	},
	[21397001] = {
		21397001,
		3,
		Lang.get(45011),
		21397,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		138,
		[18] = 21397,
		[21] = 1
	},
	[21397002] = {
		21397002,
		3,
		Lang.get(45012),
		21397,
		2,
		605,
		[21] = 1
	},
	[21397003] = {
		21397003,
		0,
		Lang.get(44590),
		21397,
		3,
		108,
		{
			RTResTalkAction[69]
		},
		nil,
		nil,
		3
	},
	[21397004] = {
		21397004,
		0,
		Lang.get(45013),
		21397,
		4,
		108,
		{
			RTResTalkAction[94]
		}
	},
	[21397005] = {
		21397005,
		0,
		Lang.get(45014),
		21397,
		5,
		223,
		{
			RTResTalkAction[45],
			RTResTalkAction[2]
		}
	},
	[21397006] = {
		21397006,
		0,
		Lang.get(45015),
		21397,
		6,
		226,
		{
			RTResTalkAction[105],
			RTResTalkAction[119]
		}
	},
	[21397007] = {
		21397007,
		0,
		Lang.get(45016),
		21397,
		7,
		223,
		{
			RTResTalkAction[105],
			RTResTalkAction[119]
		}
	},
	[21397008] = {
		21397008,
		0,
		Lang.get(45017),
		21397,
		8,
		226,
		{
			RTResTalkAction[105],
			RTResTalkAction[119]
		}
	},
	[21397009] = {
		21397009,
		0,
		Lang.get(45018),
		21397,
		9,
		223,
		{
			RTResTalkAction[105],
			RTResTalkAction[119]
		}
	},
	[21397010] = {
		21397010,
		0,
		Lang.get(45019),
		21397,
		10,
		226,
		{
			RTResTalkAction[115],
			RTResTalkAction[47]
		}
	},
	[21397011] = {
		21397011,
		0,
		Lang.get(45020),
		21397,
		11,
		223,
		{
			RTResTalkAction[45],
			RTResTalkAction[112]
		}
	},
	[21397012] = {
		21397012,
		0,
		Lang.get(45021),
		21397,
		12,
		226,
		{
			RTResTalkAction[113],
			RTResTalkAction[47]
		}
	},
	[21397013] = {
		21397013,
		5,
		Lang.get(45022),
		21397,
		13,
		108,
		{
			RTResTalkAction[1],
			RTResTalkAction[112]
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
