-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\zhounianqingqiandao\\ResTalk.lua

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
	119,
	{
		3,
		10015
	},
	nil,
	3
}
RTResTalkAction[2] = {
	1,
	133,
	{
		100114
	},
	nil,
	1
}
RTResTalkAction[3] = {
	[1] = 0,
	[2] = 119
}
RTResTalkAction[4] = {
	1,
	107,
	{
		1,
		10031
	},
	nil,
	6
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 133
}
RTResTalkAction[6] = {
	[1] = 1,
	[2] = 389
}
RTResTalkAction[7] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[8] = {
	1,
	119,
	{
		1,
		10025
	},
	nil,
	9
}
RTResTalkAction[9] = {
	[1] = 0,
	[2] = 389
}
RTResTalkAction[10] = {
	1,
	141,
	nil,
	nil,
	0
}
RTResTalkAction[11] = {
	1,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[12] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[13] = {
	1,
	134,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[14] = {
	[1] = 1,
	[2] = 240,
	[3] = {
		1
	}
}
RTResTalkAction[15] = {
	[1] = 1,
	[2] = 133,
	[3] = {
		1001
	}
}
RTResTalkAction[16] = {
	[1] = 0,
	[2] = 240
}
RTResTalkAction[17] = {
	1,
	119,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[18] = {
	1,
	239,
	{
		1002
	},
	nil,
	0
}
RTResTalkAction[19] = {
	1,
	107,
	nil,
	nil,
	1
}
RTResTalkAction[20] = {
	[1] = 0,
	[2] = 239
}
RTResTalkAction[21] = {
	[1] = 1,
	[2] = 239
}
RTResTalkAction[22] = {
	1,
	133,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[23] = {
	1,
	239,
	nil,
	nil,
	1
}
RTResTalkAction[24] = {
	1,
	239,
	nil,
	nil,
	0
}
RTResTalkAction[25] = {
	1,
	107,
	{
		2
	},
	nil,
	6
}
RTResTalkAction[26] = {
	1,
	133,
	nil,
	nil,
	0
}
RTResTalkAction[27] = {
	1,
	119,
	{
		1
	},
	nil,
	3
}
RTResTalkAction[28] = {
	1,
	134,
	nil,
	nil,
	2
}
RTResTalkAction[29] = {
	1,
	133,
	{
		100114
	},
	nil,
	2
}
RTResTalkAction[30] = {
	[1] = 0,
	[2] = 134
}
RTResTalkAction[31] = {
	1,
	107,
	{
		2
	},
	nil,
	5
}
RTResTalkAction[32] = {
	[1] = 1,
	[2] = 8,
	[3] = {
		1
	}
}
RTResTalkAction[33] = {
	[1] = 1,
	[2] = 664,
	[3] = {
		1004
	}
}
RTResTalkAction[34] = {
	[1] = 0,
	[2] = 8
}
RTResTalkAction[35] = {
	[1] = 1,
	[2] = 8,
	[3] = {
		2
	}
}
RTResTalkAction[36] = {
	[1] = 0,
	[2] = 664
}
RTResTalkAction[37] = {
	[1] = 1,
	[2] = 8
}
RTResTalkAction[38] = {
	[1] = 1,
	[2] = 664,
	[3] = {
		1003
	}
}
RTResTalkAction[39] = {
	[1] = 1,
	[2] = 664,
	[3] = {
		3
	}
}
RTResTalkAction[40] = {
	[1] = 1,
	[2] = 664
}
RTResTalkAction[41] = {
	[1] = 1,
	[2] = 242,
	[3] = {
		1
	}
}
RTResTalkAction[42] = {
	[1] = 1,
	[2] = 222,
	[3] = {
		2
	}
}
RTResTalkAction[43] = {
	[1] = 0,
	[2] = 242
}
RTResTalkAction[44] = {
	[1] = 1,
	[2] = 210,
	[3] = {
		1
	}
}
RTResTalkAction[45] = {
	[1] = 0,
	[2] = 222
}
RTResTalkAction[46] = {
	[1] = 1,
	[2] = 235,
	[3] = {
		2
	}
}
RTResTalkAction[47] = {
	[1] = 0,
	[2] = 210
}
RTResTalkAction[48] = {
	[1] = 1,
	[2] = 191,
	[3] = {
		1
	}
}
RTResTalkAction[49] = {
	[1] = 0,
	[2] = 235
}
RTResTalkAction[50] = {
	[1] = 0,
	[2] = 191
}
RTResTalkAction[51] = {
	1,
	239,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[52] = {
	[1] = 1,
	[2] = 239,
	[3] = {
		3
	}
}
RTResTalkAction[53] = {
	1,
	239,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[54] = {
	[1] = 1,
	[2] = 239,
	[3] = {
		2
	}
}
RTResTalkAction[55] = {
	[1] = 1,
	[2] = 239,
	[3] = {
		1
	}
}

local Data = {
	[22400001] = {
		22400001,
		10,
		"34",
		22400,
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		1222,
		134,
		22400,
		nil,
		nil,
		nil,
		1,
		nil,
		22400
	},
	[22400002] = {
		22400002,
		0,
		Lang.get(51957),
		22400,
		2,
		133,
		nil,
		1,
		1
	},
	[22400003] = {
		22400003,
		0,
		Lang.get(75735),
		22400,
		3,
		119,
		nil,
		1,
		2
	},
	[22400004] = {
		22400004,
		0,
		Lang.get(51959),
		22400,
		4,
		107,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		22401,
		nil,
		nil,
		nil,
		nil,
		nil,
		22401
	},
	[22400005] = {
		22400005,
		0,
		Lang.get(51960),
		22400,
		5,
		141,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22402,
		[19] = 22402
	},
	[22400006] = {
		22400006,
		0,
		Lang.get(51961),
		22400,
		6,
		119,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22403,
		[19] = 22403,
		[17] = 1
	},
	[22400007] = {
		22400007,
		0,
		Lang.get(51962),
		22400,
		7,
		133,
		nil,
		1,
		1
	},
	[22400008] = {
		22400008,
		0,
		Lang.get(51963),
		22400,
		8,
		119,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[22400009] = {
		22400009,
		0,
		Lang.get(51964),
		22400,
		9,
		133,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[22400010] = {
		22400010,
		0,
		Lang.get(51965),
		22400,
		10,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[22400011] = {
		22400011,
		0,
		Lang.get(51966),
		22400,
		11,
		107,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		},
		1,
		5,
		[21] = 389
	},
	[22400012] = {
		22400012,
		0,
		Lang.get(51967),
		22400,
		12,
		107,
		{
			RTResTalkAction[6]
		},
		1,
		6,
		[21] = 389
	},
	[22400013] = {
		22400013,
		0,
		Lang.get(51968),
		22400,
		13,
		119,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[22400014] = {
		22400014,
		0,
		Lang.get(51969),
		22400,
		14,
		141,
		{
			RTResTalkAction[10],
			RTResTalkAction[3]
		}
	},
	[22400015] = {
		22400015,
		0,
		Lang.get(51970),
		22400,
		15,
		107,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[22400016] = {
		22400016,
		0,
		Lang.get(51971),
		22400,
		16,
		134,
		{
			RTResTalkAction[13],
			RTResTalkAction[7]
		}
	},
	[22401001] = {
		22401001,
		10,
		"35",
		22401,
		1,
		134,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		22410,
		nil,
		nil,
		nil,
		1,
		nil,
		22410
	},
	[22401002] = {
		22401002,
		0,
		Lang.get(51972),
		22401,
		2,
		107,
		nil,
		1,
		1
	},
	[22401003] = {
		22401003,
		0,
		Lang.get(51973),
		22401,
		3,
		119,
		nil,
		1,
		3
	},
	[22401004] = {
		22401004,
		0,
		Lang.get(51974),
		22401,
		4,
		107,
		nil,
		1,
		11
	},
	[22401005] = {
		22401005,
		0,
		Lang.get(51975),
		22401,
		5,
		240,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[22401006] = {
		22401006,
		0,
		Lang.get(51976),
		22401,
		6,
		133,
		{
			RTResTalkAction[15],
			RTResTalkAction[16]
		}
	},
	[22401007] = {
		22401007,
		0,
		Lang.get(51977),
		22401,
		7,
		119,
		{
			RTResTalkAction[17],
			RTResTalkAction[5]
		}
	},
	[22401008] = {
		22401008,
		0,
		Lang.get(51978),
		22401,
		8,
		239,
		{
			RTResTalkAction[18],
			RTResTalkAction[3]
		}
	},
	[22401009] = {
		22401009,
		0,
		Lang.get(51979),
		22401,
		9,
		107,
		{
			RTResTalkAction[19],
			RTResTalkAction[20]
		}
	},
	[22401010] = {
		22401010,
		0,
		Lang.get(51980),
		22401,
		10,
		239,
		{
			RTResTalkAction[21],
			RTResTalkAction[7]
		}
	},
	[22401011] = {
		22401011,
		0,
		Lang.get(51981),
		22401,
		11,
		133,
		{
			RTResTalkAction[22],
			RTResTalkAction[20]
		}
	},
	[22401012] = {
		22401012,
		0,
		Lang.get(51982),
		22401,
		12,
		239,
		{
			RTResTalkAction[21],
			RTResTalkAction[5]
		}
	},
	[22401013] = {
		22401013,
		0,
		Lang.get(51983),
		22401,
		13,
		239,
		{
			RTResTalkAction[23]
		}
	},
	[22401014] = {
		22401014,
		0,
		Lang.get(51984),
		22401,
		14,
		239,
		{
			RTResTalkAction[24]
		}
	},
	[22402001] = {
		22402001,
		10,
		"36",
		22402,
		1,
		239,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		22420,
		nil,
		nil,
		nil,
		1,
		nil,
		22420
	},
	[22402002] = {
		22402002,
		0,
		Lang.get(51985),
		22402,
		2,
		107,
		nil,
		1,
		0
	},
	[22402003] = {
		22402003,
		0,
		Lang.get(51986),
		22402,
		3,
		134,
		nil,
		1,
		3,
		nil,
		nil,
		nil,
		22421,
		nil,
		nil,
		nil,
		nil,
		nil,
		22421
	},
	[22402004] = {
		22402004,
		0,
		Lang.get(51987),
		22402,
		4,
		119,
		nil,
		1,
		9,
		nil,
		nil,
		nil,
		22422,
		nil,
		nil,
		nil,
		nil,
		nil,
		22422
	},
	[22402005] = {
		22402005,
		0,
		Lang.get(51988),
		22402,
		5,
		107,
		nil,
		1,
		11,
		nil,
		nil,
		nil,
		22423,
		nil,
		nil,
		nil,
		1,
		nil,
		22423
	},
	[22402006] = {
		22402006,
		0,
		Lang.get(51989),
		22402,
		6,
		141,
		nil,
		1,
		0
	},
	[22402007] = {
		22402007,
		0,
		Lang.get(51990),
		22402,
		7,
		119,
		{
			RTResTalkAction[6]
		},
		1,
		6,
		[21] = 389
	},
	[22402008] = {
		22402008,
		0,
		Lang.get(51991),
		22402,
		8,
		119,
		{
			RTResTalkAction[6]
		},
		1,
		7,
		[21] = 389
	},
	[22402009] = {
		22402009,
		0,
		Lang.get(51992),
		22402,
		9,
		107,
		{
			RTResTalkAction[25],
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[22402010] = {
		22402010,
		0,
		Lang.get(51993),
		22402,
		10,
		133,
		{
			RTResTalkAction[26],
			RTResTalkAction[7]
		}
	},
	[22402011] = {
		22402011,
		0,
		Lang.get(51994),
		22402,
		11,
		119,
		{
			RTResTalkAction[27],
			RTResTalkAction[5]
		}
	},
	[22402012] = {
		22402012,
		0,
		Lang.get(51995),
		22402,
		12,
		134,
		{
			RTResTalkAction[28],
			RTResTalkAction[3]
		}
	},
	[22402013] = {
		22402013,
		0,
		Lang.get(51996),
		22402,
		13,
		133,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		}
	},
	[22402014] = {
		22402014,
		0,
		Lang.get(51997),
		22402,
		14,
		107,
		{
			RTResTalkAction[31],
			RTResTalkAction[5]
		}
	},
	[22403001] = {
		22403001,
		10,
		"37",
		22403,
		1,
		107,
		nil,
		nil,
		nil,
		nil,
		nil,
		156,
		22430,
		nil,
		nil,
		nil,
		1,
		nil,
		22430
	},
	[22403002] = {
		22403002,
		0,
		Lang.get(51998),
		22403,
		2,
		8,
		nil,
		1,
		0
	},
	[22403003] = {
		22403003,
		0,
		Lang.get(51999),
		22403,
		3,
		664,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22431
	},
	[22403004] = {
		22403004,
		0,
		Lang.get(52000),
		22403,
		4,
		8,
		{
			RTResTalkAction[32]
		},
		nil,
		nil,
		3
	},
	[22403005] = {
		22403005,
		0,
		Lang.get(52001),
		22403,
		5,
		664,
		{
			RTResTalkAction[33],
			RTResTalkAction[34]
		}
	},
	[22403006] = {
		22403006,
		0,
		Lang.get(52002),
		22403,
		6,
		8,
		{
			RTResTalkAction[35],
			RTResTalkAction[36]
		}
	},
	[22403007] = {
		22403007,
		0,
		Lang.get(52003),
		22403,
		7,
		8,
		{
			RTResTalkAction[37]
		}
	},
	[22403008] = {
		22403008,
		0,
		Lang.get(52004),
		22403,
		8,
		664,
		{
			RTResTalkAction[38],
			RTResTalkAction[34]
		}
	},
	[22403009] = {
		22403009,
		0,
		Lang.get(52005),
		22403,
		9,
		664,
		{
			RTResTalkAction[39]
		}
	},
	[22403010] = {
		22403010,
		0,
		Lang.get(52006),
		22403,
		10,
		8,
		{
			RTResTalkAction[32],
			RTResTalkAction[36]
		}
	},
	[22403011] = {
		22403011,
		0,
		Lang.get(52007),
		22403,
		11,
		664,
		{
			RTResTalkAction[40],
			RTResTalkAction[34]
		}
	},
	[22403012] = {
		22403012,
		0,
		Lang.get(52008),
		22403,
		12,
		8,
		{
			RTResTalkAction[37],
			RTResTalkAction[36]
		}
	},
	[22403013] = {
		22403013,
		0,
		Lang.get(52009),
		22403,
		13,
		664,
		{
			RTResTalkAction[40],
			RTResTalkAction[34]
		}
	},
	[22403014] = {
		22403014,
		0,
		Lang.get(52010),
		22403,
		14,
		8,
		{
			RTResTalkAction[37],
			RTResTalkAction[36]
		}
	},
	[22403015] = {
		22403015,
		3,
		Lang.get(51961),
		22403,
		15,
		239,
		{
			RTResTalkAction[34]
		},
		1,
		1,
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
		1
	},
	[22403016] = {
		22403016,
		0,
		Lang.get(52011),
		22403,
		16,
		664,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		22432,
		nil,
		nil,
		nil,
		1,
		nil,
		22431
	},
	[22403017] = {
		22403017,
		0,
		Lang.get(52012),
		22403,
		17,
		188,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22433,
		[19] = 22432
	},
	[22403018] = {
		22403018,
		0,
		Lang.get(52013),
		22403,
		18,
		188,
		nil,
		1
	},
	[22403019] = {
		22403019,
		0,
		Lang.get(52014),
		22403,
		19,
		8,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22434,
		[19] = 22434
	},
	[22403020] = {
		22403020,
		0,
		Lang.get(52015),
		22403,
		20,
		664,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22435,
		[19] = 22435
	},
	[22404001] = {
		22404001,
		10,
		"38",
		22404,
		1,
		664,
		nil,
		nil,
		nil,
		nil,
		nil,
		143,
		22440,
		nil,
		nil,
		nil,
		1,
		nil,
		22440
	},
	[22404002] = {
		22404002,
		0,
		Lang.get(52016),
		22404,
		2,
		158,
		nil,
		1,
		4
	},
	[22404003] = {
		22404003,
		0,
		Lang.get(52017),
		22404,
		3,
		159,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		22441,
		nil,
		nil,
		nil,
		nil,
		nil,
		22441
	},
	[22404004] = {
		22404004,
		0,
		Lang.get(52018),
		22404,
		4,
		158,
		nil,
		1,
		6,
		nil,
		nil,
		nil,
		22442,
		nil,
		nil,
		nil,
		nil,
		nil,
		22442
	},
	[22404005] = {
		22404005,
		0,
		Lang.get(52019),
		22404,
		5,
		159,
		nil,
		1,
		2
	},
	[22404006] = {
		22404006,
		0,
		Lang.get(52274),
		22404,
		6,
		386,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		22443,
		nil,
		nil,
		nil,
		nil,
		nil,
		22443
	},
	[22404007] = {
		22404007,
		0,
		Lang.get(52021),
		22404,
		7,
		158,
		nil,
		1,
		4,
		nil,
		nil,
		nil,
		22444,
		nil,
		nil,
		nil,
		1,
		nil,
		22444
	},
	[22404008] = {
		22404008,
		0,
		Lang.get(52022),
		22404,
		8,
		386,
		nil,
		1,
		0
	},
	[22404009] = {
		22404009,
		0,
		Lang.get(52023),
		22404,
		9,
		158,
		nil,
		1,
		2
	},
	[22404010] = {
		22404010,
		4,
		nil,
		22404,
		10,
		158,
		nil,
		1,
		[29] = {
			{
				id = 22404011,
				branch_content = Lang.get(52024)
			}
		}
	},
	[22404011] = {
		22404011,
		0,
		Lang.get(52025),
		22404,
		11,
		158,
		nil,
		1,
		0
	},
	[22404012] = {
		22404012,
		4,
		nil,
		22404,
		12,
		158,
		nil,
		1,
		[29] = {
			{
				id = 22404013,
				branch_content = Lang.get(52026)
			}
		}
	},
	[22404013] = {
		22404013,
		0,
		Lang.get(52027),
		22404,
		13,
		158,
		nil,
		1,
		2
	},
	[22404014] = {
		22404014,
		0,
		Lang.get(52028),
		22404,
		14,
		158,
		nil,
		1,
		0
	},
	[22404015] = {
		22404015,
		0,
		Lang.get(52029),
		22404,
		15,
		158,
		nil,
		1,
		1
	},
	[22404016] = {
		22404016,
		0,
		Lang.get(52030),
		22404,
		16,
		158,
		nil,
		1
	},
	[22404017] = {
		22404017,
		0,
		Lang.get(52031),
		22404,
		17,
		158,
		nil,
		1,
		4,
		nil,
		1236,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		22446
	},
	[22404018] = {
		22404018,
		0,
		Lang.get(52032),
		22404,
		18,
		159,
		nil,
		1,
		6,
		nil,
		nil,
		nil,
		22445,
		nil,
		nil,
		nil,
		1,
		nil,
		22445
	},
	[22404019] = {
		22404019,
		0,
		Lang.get(52033),
		22404,
		19,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22447
	},
	[22404020] = {
		22404020,
		0,
		Lang.get(52034),
		22404,
		20,
		159,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22448,
		[19] = 22448
	},
	[22405001] = {
		22405001,
		10,
		"39",
		22405,
		1,
		159,
		nil,
		nil,
		nil,
		nil,
		nil,
		141,
		22450,
		nil,
		nil,
		nil,
		1,
		nil,
		22450
	},
	[22405002] = {
		22405002,
		0,
		Lang.get(52035),
		22405,
		2,
		238,
		nil,
		1
	},
	[22405003] = {
		22405003,
		0,
		Lang.get(52036),
		22405,
		3,
		238,
		nil,
		1
	},
	[22405004] = {
		22405004,
		0,
		Lang.get(52037),
		22405,
		4,
		238,
		nil,
		1
	},
	[22405005] = {
		22405005,
		0,
		Lang.get(52038),
		22405,
		5,
		238,
		nil,
		1
	},
	[22405006] = {
		22405006,
		0,
		Lang.get(52039),
		22405,
		6,
		242,
		{
			RTResTalkAction[41]
		},
		nil,
		nil,
		3,
		1295
	},
	[22405007] = {
		22405007,
		0,
		Lang.get(52040),
		22405,
		7,
		222,
		{
			RTResTalkAction[42],
			RTResTalkAction[43]
		},
		nil,
		nil,
		nil,
		1460
	},
	[22405008] = {
		22405008,
		0,
		Lang.get(52041),
		22405,
		8,
		210,
		{
			RTResTalkAction[44],
			RTResTalkAction[45]
		},
		nil,
		nil,
		nil,
		1964
	},
	[22405009] = {
		22405009,
		0,
		Lang.get(52042),
		22405,
		9,
		235,
		{
			RTResTalkAction[46],
			RTResTalkAction[47]
		},
		nil,
		nil,
		nil,
		2179
	},
	[22405010] = {
		22405010,
		0,
		Lang.get(53090),
		22405,
		10,
		191,
		{
			RTResTalkAction[48],
			RTResTalkAction[49]
		},
		nil,
		nil,
		nil,
		1979
	},
	[22405011] = {
		22405011,
		3,
		Lang.get(52275),
		22405,
		11,
		191,
		{
			RTResTalkAction[50]
		},
		nil,
		nil,
		-1,
		1236,
		[19] = 22451,
		[22] = 1
	},
	[22405012] = {
		22405012,
		0,
		Lang.get(52044),
		22405,
		12,
		158,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		22452,
		nil,
		nil,
		nil,
		1,
		nil,
		22452
	},
	[22405013] = {
		22405013,
		0,
		Lang.get(52045),
		22405,
		13,
		238,
		nil,
		1,
		0
	},
	[22405014] = {
		22405014,
		0,
		Lang.get(52046),
		22405,
		14,
		158,
		nil,
		1,
		6
	},
	[22405015] = {
		22405015,
		0,
		Lang.get(52047),
		22405,
		15,
		238,
		nil,
		1,
		0
	},
	[22405016] = {
		22405016,
		0,
		Lang.get(52048),
		22405,
		16,
		158,
		nil,
		1,
		2
	},
	[22405017] = {
		22405017,
		0,
		Lang.get(52049),
		22405,
		17,
		159,
		nil,
		1,
		1
	},
	[22405018] = {
		22405018,
		0,
		Lang.get(52050),
		22405,
		18,
		238,
		nil,
		1,
		0
	},
	[22405019] = {
		22405019,
		0,
		Lang.get(52051),
		22405,
		19,
		158,
		nil,
		1,
		2
	},
	[22406001] = {
		22406001,
		10,
		"40",
		22406,
		1,
		158,
		{
			RTResTalkAction[51]
		},
		nil,
		nil,
		nil,
		nil,
		138,
		[19] = 22460,
		[17] = 1
	},
	[22406002] = {
		22406002,
		0,
		Lang.get(52052),
		22406,
		2,
		239,
		{
			RTResTalkAction[20]
		}
	},
	[22406003] = {
		22406003,
		0,
		Lang.get(52053),
		22406,
		3,
		239,
		{
			RTResTalkAction[24]
		}
	},
	[22406004] = {
		22406004,
		0,
		Lang.get(52054),
		22406,
		4,
		239,
		{
			RTResTalkAction[52]
		}
	},
	[22406005] = {
		22406005,
		0,
		Lang.get(52055),
		22406,
		5,
		239,
		{
			RTResTalkAction[23]
		}
	},
	[22406006] = {
		22406006,
		0,
		Lang.get(52056),
		22406,
		6,
		239,
		{
			RTResTalkAction[24]
		}
	},
	[22406007] = {
		22406007,
		0,
		Lang.get(52057),
		22406,
		7,
		239,
		{
			RTResTalkAction[53]
		}
	},
	[22406008] = {
		22406008,
		0,
		Lang.get(52058),
		22406,
		8,
		239,
		{
			RTResTalkAction[24]
		}
	},
	[22406009] = {
		22406009,
		0,
		Lang.get(52059),
		22406,
		9,
		239,
		{
			RTResTalkAction[21]
		}
	},
	[22406010] = {
		22406010,
		0,
		Lang.get(52060),
		22406,
		10,
		239,
		{
			RTResTalkAction[54]
		}
	},
	[22406011] = {
		22406011,
		0,
		Lang.get(52061),
		22406,
		11,
		239,
		{
			RTResTalkAction[55]
		}
	},
	[22406012] = {
		22406012,
		0,
		Lang.get(52062),
		22406,
		12,
		239,
		{
			RTResTalkAction[23]
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
