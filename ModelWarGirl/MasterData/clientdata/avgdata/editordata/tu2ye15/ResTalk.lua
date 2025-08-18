-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\tu2ye15\\ResTalk.lua

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
	[2] = 1071
}
RTResTalkAction[2] = {
	[1] = 2,
	[2] = 1071
}
RTResTalkAction[3] = {
	[1] = 3,
	[2] = 196
}
RTResTalkAction[4] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 1071
}
RTResTalkAction[6] = {
	[1] = 0,
	[2] = 196
}
RTResTalkAction[7] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[8] = {
	[1] = 3,
	[2] = 1169
}
RTResTalkAction[9] = {
	[1] = 2,
	[2] = 1169
}
RTResTalkAction[10] = {
	[1] = 3,
	[2] = 1172
}
RTResTalkAction[11] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[12] = {
	[1] = 0,
	[2] = 1169
}
RTResTalkAction[13] = {
	[1] = 0,
	[2] = 1172
}
RTResTalkAction[14] = {
	1,
	107,
	nil,
	nil,
	5
}
RTResTalkAction[15] = {
	[1] = 3,
	[2] = 1071
}
RTResTalkAction[16] = {
	1,
	196,
	{
		2
	},
	nil,
	4
}
RTResTalkAction[17] = {
	[1] = 2,
	[2] = 196
}
RTResTalkAction[18] = {
	[1] = 1,
	[2] = 1169
}
RTResTalkAction[19] = {
	[1] = 1,
	[2] = 424
}
RTResTalkAction[20] = {
	[1] = 0,
	[2] = 424
}
RTResTalkAction[21] = {
	[1] = 1,
	[2] = 1172
}
RTResTalkAction[22] = {
	[1] = 2,
	[2] = 1172
}
RTResTalkAction[23] = {
	1,
	107,
	nil,
	nil,
	1
}
RTResTalkAction[24] = {
	1,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[25] = {
	1,
	1071,
	nil,
	nil,
	0
}
RTResTalkAction[26] = {
	[1] = 1,
	[2] = 196
}
RTResTalkAction[27] = {
	3,
	196,
	nil,
	nil,
	2
}
RTResTalkAction[28] = {
	1,
	196,
	nil,
	nil,
	0
}
RTResTalkAction[29] = {
	1,
	196,
	nil,
	nil,
	1
}
RTResTalkAction[30] = {
	1,
	196,
	nil,
	nil,
	4
}
RTResTalkAction[31] = {
	[1] = 1,
	[2] = 196,
	[3] = {
		2
	}
}
RTResTalkAction[32] = {
	[1] = 2,
	[2] = 1172,
	[3] = {
		2
	}
}

local Data = {
	[35006001] = {
		35006001,
		10,
		"69",
		35006,
		1,
		nil,
		nil,
		nil,
		nil,
		5,
		nil,
		171,
		nil,
		nil,
		1
	},
	[35006002] = {
		35006002,
		0,
		Lang.get(90873),
		35006,
		2,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		35006,
		[19] = 35006,
		[17] = 1
	},
	[35006003] = {
		35006003,
		0,
		Lang.get(90874),
		35006,
		3,
		1071,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[35006004] = {
		35006004,
		0,
		Lang.get(90875),
		35006,
		4,
		196,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[35006005] = {
		35006005,
		0,
		Lang.get(90876),
		35006,
		5,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[5],
			RTResTalkAction[6]
		}
	},
	[35006006] = {
		35006006,
		0,
		Lang.get(90877),
		35006,
		6,
		1169,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[35006007] = {
		35006007,
		0,
		Lang.get(90878),
		35006,
		7,
		1172,
		{
			RTResTalkAction[9],
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[35006008] = {
		35006008,
		0,
		Lang.get(90879),
		35006,
		8,
		1169,
		{
			RTResTalkAction[9],
			RTResTalkAction[10]
		}
	},
	[35006009] = {
		35006009,
		0,
		Lang.get(90880),
		35006,
		9,
		1172,
		{
			RTResTalkAction[9],
			RTResTalkAction[10]
		}
	},
	[35006010] = {
		35006010,
		0,
		Lang.get(90881),
		35006,
		10,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[12],
			RTResTalkAction[13]
		}
	},
	[35006011] = {
		35006011,
		0,
		Lang.get(90882),
		35006,
		11,
		107,
		{
			RTResTalkAction[14]
		}
	},
	[35007001] = {
		35007001,
		10,
		"70",
		35007,
		1,
		107,
		nil,
		nil,
		nil,
		5,
		nil,
		171,
		nil,
		nil,
		1
	},
	[35007002] = {
		35007002,
		0,
		Lang.get(90883),
		35007,
		2,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		35007,
		[19] = 35007,
		[17] = 1
	},
	[35007003] = {
		35007003,
		0,
		Lang.get(90884),
		35007,
		3,
		1071,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[35007004] = {
		35007004,
		0,
		Lang.get(90885),
		35007,
		4,
		107,
		{
			RTResTalkAction[7],
			RTResTalkAction[15]
		}
	},
	[35007005] = {
		35007005,
		0,
		Lang.get(90886),
		35007,
		5,
		196,
		{
			RTResTalkAction[16],
			RTResTalkAction[11],
			RTResTalkAction[5]
		}
	},
	[35007006] = {
		35007006,
		0,
		Lang.get(90887),
		35007,
		6,
		1169,
		{
			RTResTalkAction[17],
			RTResTalkAction[8]
		}
	},
	[35007007] = {
		35007007,
		0,
		Lang.get(90888),
		35007,
		7,
		196,
		{
			RTResTalkAction[17],
			RTResTalkAction[8]
		}
	},
	[35007008] = {
		35007008,
		0,
		Lang.get(90889),
		35007,
		8,
		1071,
		{
			RTResTalkAction[1],
			RTResTalkAction[6],
			RTResTalkAction[12]
		}
	},
	[35007009] = {
		35007009,
		0,
		Lang.get(90890),
		35007,
		9,
		196,
		{
			RTResTalkAction[17],
			RTResTalkAction[15]
		}
	},
	[35007010] = {
		35007010,
		0,
		Lang.get(90891),
		35007,
		10,
		1169,
		{
			RTResTalkAction[18],
			RTResTalkAction[6],
			RTResTalkAction[5]
		}
	},
	[35007011] = {
		35007011,
		0,
		Lang.get(90892),
		35007,
		11,
		196,
		{
			RTResTalkAction[17],
			RTResTalkAction[8]
		}
	},
	[35007012] = {
		35007012,
		0,
		Lang.get(90893),
		35007,
		12,
		424,
		{
			RTResTalkAction[19],
			RTResTalkAction[6],
			RTResTalkAction[12]
		}
	},
	[35007013] = {
		35007013,
		0,
		Lang.get(90894),
		35007,
		13,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[20]
		}
	},
	[35008001] = {
		35008001,
		10,
		"71",
		35008,
		1,
		107,
		nil,
		nil,
		nil,
		5,
		nil,
		171,
		nil,
		nil,
		1
	},
	[35008002] = {
		35008002,
		0,
		Lang.get(90895),
		35008,
		2,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		35008,
		[19] = 35008,
		[17] = 1
	},
	[35008003] = {
		35008003,
		0,
		Lang.get(90896),
		35008,
		3,
		424,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		3
	},
	[35008004] = {
		35008004,
		0,
		Lang.get(90897),
		35008,
		4,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[20]
		}
	},
	[35008005] = {
		35008005,
		0,
		Lang.get(90898),
		35008,
		5,
		1169,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[35008006] = {
		35008006,
		0,
		Lang.get(90899),
		35008,
		6,
		107,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[35008007] = {
		35008007,
		0,
		Lang.get(90900),
		35008,
		7,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[12]
		}
	},
	[35008008] = {
		35008008,
		0,
		Lang.get(90901),
		35008,
		8,
		1172,
		{
			RTResTalkAction[7],
			RTResTalkAction[10]
		}
	},
	[35008009] = {
		35008009,
		0,
		Lang.get(90902),
		35008,
		9,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[13]
		}
	},
	[35008010] = {
		35008010,
		0,
		Lang.get(90903),
		35008,
		10,
		196,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[35008011] = {
		35008011,
		0,
		Lang.get(90904),
		35008,
		11,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[6]
		}
	},
	[35008012] = {
		35008012,
		0,
		Lang.get(90905),
		35008,
		12,
		107,
		{
			RTResTalkAction[4]
		}
	},
	[35009001] = {
		35009001,
		10,
		"72",
		35009,
		1,
		107,
		nil,
		nil,
		nil,
		5,
		nil,
		171,
		nil,
		nil,
		1
	},
	[35009002] = {
		35009002,
		0,
		Lang.get(90906),
		35009,
		2,
		424,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		35009,
		[19] = 35009,
		[17] = 1
	},
	[35009003] = {
		35009003,
		0,
		Lang.get(90907),
		35009,
		3,
		107,
		{
			RTResTalkAction[4]
		},
		nil,
		nil,
		3
	},
	[35009004] = {
		35009004,
		0,
		Lang.get(90908),
		35009,
		4,
		196,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[35009005] = {
		35009005,
		0,
		Lang.get(90909),
		35009,
		5,
		107,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[35009006] = {
		35009006,
		0,
		Lang.get(90910),
		35009,
		6,
		1071,
		{
			RTResTalkAction[1],
			RTResTalkAction[11],
			RTResTalkAction[6]
		}
	},
	[35009007] = {
		35009007,
		0,
		Lang.get(90911),
		35009,
		7,
		107,
		{
			RTResTalkAction[7],
			RTResTalkAction[15]
		}
	},
	[35009008] = {
		35009008,
		0,
		Lang.get(90912),
		35009,
		8,
		1172,
		{
			RTResTalkAction[21],
			RTResTalkAction[11],
			RTResTalkAction[5]
		}
	},
	[35009009] = {
		35009009,
		5,
		Lang.get(90913),
		35009,
		9,
		1169,
		{
			RTResTalkAction[22],
			RTResTalkAction[8]
		}
	},
	[35009010] = {
		35009010,
		0,
		Lang.get(90914),
		35009,
		10,
		1172,
		{
			RTResTalkAction[22],
			RTResTalkAction[8]
		}
	},
	[35009011] = {
		35009011,
		0,
		Lang.get(90915),
		35009,
		11,
		1169,
		{
			RTResTalkAction[22],
			RTResTalkAction[8]
		}
	},
	[35009012] = {
		35009012,
		0,
		Lang.get(90916),
		35009,
		12,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[13],
			RTResTalkAction[12]
		}
	},
	[35009013] = {
		35009013,
		0,
		Lang.get(90917),
		35009,
		13,
		1169,
		{
			RTResTalkAction[18],
			RTResTalkAction[11]
		}
	},
	[35010001] = {
		35010001,
		10,
		"73",
		35010,
		1,
		1169,
		nil,
		nil,
		nil,
		5,
		nil,
		171,
		nil,
		nil,
		1
	},
	[35010002] = {
		35010002,
		0,
		Lang.get(90918),
		35010,
		2,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		35010,
		[19] = 35010,
		[17] = 1
	},
	[35010003] = {
		35010003,
		0,
		Lang.get(90919),
		35010,
		3,
		1071,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[35010004] = {
		35010004,
		0,
		Lang.get(90920),
		35010,
		4,
		107,
		{
			RTResTalkAction[7],
			RTResTalkAction[15]
		}
	},
	[35010005] = {
		35010005,
		0,
		Lang.get(90921),
		35010,
		5,
		1071,
		{
			RTResTalkAction[7],
			RTResTalkAction[15]
		}
	},
	[35010006] = {
		35010006,
		0,
		Lang.get(90922),
		35010,
		6,
		107,
		{
			RTResTalkAction[7],
			RTResTalkAction[15]
		}
	},
	[35010007] = {
		35010007,
		0,
		Lang.get(90923),
		35010,
		7,
		424,
		{
			RTResTalkAction[19],
			RTResTalkAction[11],
			RTResTalkAction[5]
		}
	},
	[35010008] = {
		35010008,
		0,
		Lang.get(90924),
		35010,
		8,
		107,
		{
			RTResTalkAction[23],
			RTResTalkAction[20]
		}
	},
	[35010009] = {
		35010009,
		0,
		Lang.get(90925),
		35010,
		9,
		1172,
		{
			RTResTalkAction[7],
			RTResTalkAction[10]
		}
	},
	[35010010] = {
		35010010,
		0,
		Lang.get(90926),
		35010,
		10,
		1169,
		{
			RTResTalkAction[22],
			RTResTalkAction[8],
			RTResTalkAction[11]
		}
	},
	[35010011] = {
		35010011,
		0,
		Lang.get(90927),
		35010,
		11,
		107,
		{
			RTResTalkAction[24],
			RTResTalkAction[13],
			RTResTalkAction[12]
		}
	},
	[35010012] = {
		35010012,
		0,
		Lang.get(90928),
		35010,
		12,
		1071,
		{
			RTResTalkAction[25],
			RTResTalkAction[11]
		}
	},
	[35011001] = {
		35011001,
		10,
		"74",
		35011,
		1,
		1071,
		nil,
		nil,
		nil,
		5,
		nil,
		171,
		nil,
		nil,
		1
	},
	[35011002] = {
		35011002,
		0,
		Lang.get(90929),
		35011,
		2,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		35011,
		[19] = 35011,
		[17] = 1
	},
	[35011003] = {
		35011003,
		0,
		Lang.get(90930),
		35011,
		3,
		1071,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[35011004] = {
		35011004,
		0,
		Lang.get(90931),
		35011,
		4,
		1169,
		{
			RTResTalkAction[2],
			RTResTalkAction[8]
		}
	},
	[35011005] = {
		35011005,
		0,
		Lang.get(90932),
		35011,
		5,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[5],
			RTResTalkAction[12]
		}
	},
	[35011006] = {
		35011006,
		0,
		Lang.get(90933),
		35011,
		6,
		196,
		{
			RTResTalkAction[26],
			RTResTalkAction[11]
		}
	},
	[35011007] = {
		35011007,
		0,
		Lang.get(90934),
		35011,
		7,
		107,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[35011008] = {
		35011008,
		0,
		Lang.get(90935),
		35011,
		8,
		196,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[35011009] = {
		35011009,
		0,
		Lang.get(90936),
		35011,
		9,
		1071,
		{
			RTResTalkAction[1],
			RTResTalkAction[11],
			RTResTalkAction[6]
		}
	},
	[35011010] = {
		35011010,
		0,
		Lang.get(90937),
		35011,
		10,
		196,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[35011011] = {
		35011011,
		0,
		Lang.get(90938),
		35011,
		11,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[5],
			RTResTalkAction[6]
		}
	},
	[35011012] = {
		35011012,
		0,
		Lang.get(90939),
		35011,
		12,
		196,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[35011013] = {
		35011013,
		0,
		Lang.get(90940),
		35011,
		13,
		107,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[35012001] = {
		35012001,
		10,
		"75",
		35012,
		1,
		107,
		nil,
		nil,
		nil,
		5,
		nil,
		171,
		nil,
		nil,
		1
	},
	[35012002] = {
		35012002,
		0,
		Lang.get(90941),
		35012,
		2,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		35012,
		[19] = 35012,
		[17] = 1
	},
	[35012003] = {
		35012003,
		0,
		Lang.get(90942),
		35012,
		3,
		196,
		{
			RTResTalkAction[26]
		},
		nil,
		nil,
		3
	},
	[35012004] = {
		35012004,
		0,
		Lang.get(90943),
		35012,
		4,
		107,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[35012005] = {
		35012005,
		0,
		Lang.get(90944),
		35012,
		5,
		196,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[35012006] = {
		35012006,
		0,
		Lang.get(90945),
		35012,
		6,
		107,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[35012007] = {
		35012007,
		0,
		Lang.get(90946),
		35012,
		7,
		196,
		{
			RTResTalkAction[7],
			RTResTalkAction[27]
		}
	},
	[35012008] = {
		35012008,
		0,
		Lang.get(90947),
		35012,
		8,
		424,
		{
			RTResTalkAction[19],
			RTResTalkAction[11],
			RTResTalkAction[6]
		}
	},
	[35012009] = {
		35012009,
		0,
		Lang.get(90948),
		35012,
		9,
		1071,
		{
			RTResTalkAction[1],
			RTResTalkAction[20]
		}
	},
	[35012010] = {
		35012010,
		0,
		Lang.get(90949),
		35012,
		10,
		196,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[35012011] = {
		35012011,
		0,
		Lang.get(90950),
		35012,
		11,
		107,
		{
			RTResTalkAction[7],
			RTResTalkAction[3],
			RTResTalkAction[5]
		}
	},
	[35012012] = {
		35012012,
		0,
		Lang.get(90951),
		35012,
		12,
		196,
		{
			RTResTalkAction[28],
			RTResTalkAction[11]
		}
	},
	[35012013] = {
		35012013,
		0,
		Lang.get(90952),
		35012,
		13,
		1071,
		{
			RTResTalkAction[1],
			RTResTalkAction[6]
		}
	},
	[35013001] = {
		35013001,
		10,
		"76",
		35013,
		1,
		1071,
		nil,
		nil,
		nil,
		5,
		nil,
		171,
		nil,
		nil,
		1
	},
	[35013002] = {
		35013002,
		0,
		Lang.get(90953),
		35013,
		2,
		196,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		35013,
		[19] = 35013,
		[17] = 1
	},
	[35013003] = {
		35013003,
		0,
		Lang.get(90954),
		35013,
		3,
		1071,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[35013004] = {
		35013004,
		0,
		Lang.get(90955),
		35013,
		4,
		1172,
		{
			RTResTalkAction[21],
			RTResTalkAction[5]
		}
	},
	[35013005] = {
		35013005,
		0,
		Lang.get(90956),
		35013,
		5,
		1172,
		{
			RTResTalkAction[21]
		}
	},
	[35013006] = {
		35013006,
		0,
		Lang.get(90957),
		35013,
		6,
		1169,
		{
			RTResTalkAction[22],
			RTResTalkAction[8]
		}
	},
	[35013007] = {
		35013007,
		0,
		Lang.get(90958),
		35013,
		7,
		1172,
		{
			RTResTalkAction[22],
			RTResTalkAction[8]
		}
	},
	[35013008] = {
		35013008,
		0,
		Lang.get(90959),
		35013,
		8,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[13],
			RTResTalkAction[12]
		}
	},
	[35013009] = {
		35013009,
		0,
		Lang.get(90960),
		35013,
		9,
		1169,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[35013010] = {
		35013010,
		0,
		Lang.get(90961),
		35013,
		10,
		107,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[35014001] = {
		35014001,
		10,
		"77",
		35014,
		1,
		107,
		nil,
		nil,
		nil,
		5,
		nil,
		171,
		nil,
		nil,
		1
	},
	[35014002] = {
		35014002,
		0,
		Lang.get(90962),
		35014,
		2,
		196,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		35014,
		[19] = 35014,
		[17] = 1
	},
	[35014003] = {
		35014003,
		0,
		Lang.get(90963),
		35014,
		3,
		196,
		{
			RTResTalkAction[26]
		},
		nil,
		nil,
		3
	},
	[35014004] = {
		35014004,
		0,
		Lang.get(90964),
		35014,
		4,
		107,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[35014005] = {
		35014005,
		0,
		Lang.get(90965),
		35014,
		5,
		1071,
		{
			RTResTalkAction[1],
			RTResTalkAction[11],
			RTResTalkAction[6]
		}
	},
	[35014006] = {
		35014006,
		0,
		Lang.get(90966),
		35014,
		6,
		107,
		{
			RTResTalkAction[7],
			RTResTalkAction[15]
		}
	},
	[35014007] = {
		35014007,
		0,
		Lang.get(90967),
		35014,
		7,
		107,
		{
			RTResTalkAction[7],
			RTResTalkAction[15]
		}
	},
	[35014008] = {
		35014008,
		0,
		Lang.get(90968),
		35014,
		8,
		196,
		{
			RTResTalkAction[29],
			RTResTalkAction[11],
			RTResTalkAction[5]
		}
	},
	[35014009] = {
		35014009,
		0,
		Lang.get(90969),
		35014,
		9,
		107,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[35014010] = {
		35014010,
		0,
		Lang.get(90970),
		35014,
		10,
		1071,
		{
			RTResTalkAction[7],
			RTResTalkAction[15],
			RTResTalkAction[6]
		}
	},
	[35014011] = {
		35014011,
		0,
		Lang.get(90971),
		35014,
		11,
		196,
		{
			RTResTalkAction[7],
			RTResTalkAction[3],
			RTResTalkAction[5]
		}
	},
	[35014012] = {
		35014012,
		0,
		Lang.get(90972),
		35014,
		12,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[6]
		}
	},
	[35014013] = {
		35014013,
		0,
		Lang.get(90973),
		35014,
		13,
		1169,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[35014014] = {
		35014014,
		0,
		Lang.get(90974),
		35014,
		14,
		107,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[35015001] = {
		35015001,
		10,
		"78",
		35015,
		1,
		107,
		nil,
		nil,
		nil,
		5,
		nil,
		171,
		nil,
		nil,
		1
	},
	[35015002] = {
		35015002,
		0,
		Lang.get(90975),
		35015,
		2,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		35015,
		[19] = 35015,
		[17] = 1
	},
	[35015003] = {
		35015003,
		0,
		Lang.get(90976),
		35015,
		3,
		1071,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[35015004] = {
		35015004,
		0,
		Lang.get(90977),
		35015,
		4,
		107,
		{
			RTResTalkAction[7],
			RTResTalkAction[15]
		}
	},
	[35015005] = {
		35015005,
		0,
		Lang.get(90978),
		35015,
		5,
		196,
		{
			RTResTalkAction[26],
			RTResTalkAction[11],
			RTResTalkAction[5]
		}
	},
	[35015006] = {
		35015006,
		0,
		Lang.get(90979),
		35015,
		6,
		196,
		{
			RTResTalkAction[30]
		}
	},
	[35015007] = {
		35015007,
		0,
		Lang.get(90980),
		35015,
		7,
		107,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[35015008] = {
		35015008,
		0,
		Lang.get(90981),
		35015,
		8,
		1071,
		{
			RTResTalkAction[1],
			RTResTalkAction[11],
			RTResTalkAction[6]
		}
	},
	[35015009] = {
		35015009,
		0,
		Lang.get(90982),
		35015,
		9,
		196,
		{
			RTResTalkAction[28],
			RTResTalkAction[5]
		}
	},
	[35015010] = {
		35015010,
		0,
		Lang.get(90983),
		35015,
		10,
		1169,
		{
			RTResTalkAction[18],
			RTResTalkAction[6]
		}
	},
	[35015011] = {
		35015011,
		0,
		Lang.get(90984),
		35015,
		11,
		1172,
		{
			RTResTalkAction[22],
			RTResTalkAction[8]
		}
	},
	[35015012] = {
		35015012,
		0,
		Lang.get(90985),
		35015,
		12,
		196,
		{
			RTResTalkAction[26],
			RTResTalkAction[13],
			RTResTalkAction[12]
		}
	},
	[35015013] = {
		35015013,
		0,
		Lang.get(90986),
		35015,
		13,
		196,
		{
			RTResTalkAction[26]
		}
	},
	[35016001] = {
		35016001,
		10,
		"79",
		35016,
		1,
		196,
		nil,
		nil,
		nil,
		5,
		nil,
		171,
		nil,
		nil,
		1
	},
	[35016002] = {
		35016002,
		0,
		Lang.get(90987),
		35016,
		2,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		35016,
		[19] = 35016,
		[17] = 1
	},
	[35016003] = {
		35016003,
		0,
		Lang.get(90988),
		35016,
		3,
		1169,
		{
			RTResTalkAction[18]
		},
		nil,
		nil,
		3
	},
	[35016004] = {
		35016004,
		0,
		Lang.get(90989),
		35016,
		4,
		1071,
		{
			RTResTalkAction[2],
			RTResTalkAction[8]
		}
	},
	[35016005] = {
		35016005,
		0,
		Lang.get(90990),
		35016,
		5,
		1169,
		{
			RTResTalkAction[2],
			RTResTalkAction[8]
		}
	},
	[35016006] = {
		35016006,
		0,
		Lang.get(90991),
		35016,
		6,
		1172,
		{
			RTResTalkAction[21],
			RTResTalkAction[5],
			RTResTalkAction[12]
		}
	},
	[35016007] = {
		35016007,
		0,
		Lang.get(90992),
		35016,
		7,
		1169,
		{
			RTResTalkAction[22],
			RTResTalkAction[8]
		}
	},
	[35016008] = {
		35016008,
		0,
		Lang.get(90993),
		35016,
		8,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[13],
			RTResTalkAction[12]
		}
	},
	[35016009] = {
		35016009,
		0,
		Lang.get(90994),
		35016,
		9,
		424,
		{
			RTResTalkAction[19],
			RTResTalkAction[11]
		}
	},
	[35017001] = {
		35017001,
		10,
		"80",
		35017,
		1,
		424,
		nil,
		nil,
		nil,
		5,
		nil,
		171,
		nil,
		nil,
		1
	},
	[35017002] = {
		35017002,
		0,
		Lang.get(90995),
		35017,
		2,
		1169,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		35017,
		[19] = 35017,
		[17] = 1
	},
	[35017003] = {
		35017003,
		0,
		Lang.get(90996),
		35017,
		3,
		1071,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[35017004] = {
		35017004,
		0,
		Lang.get(90997),
		35017,
		4,
		107,
		{
			RTResTalkAction[7],
			RTResTalkAction[15]
		}
	},
	[35017005] = {
		35017005,
		0,
		Lang.get(90998),
		35017,
		5,
		1071,
		{
			RTResTalkAction[7],
			RTResTalkAction[15]
		}
	},
	[35017006] = {
		35017006,
		0,
		Lang.get(90999),
		35017,
		6,
		107,
		{
			RTResTalkAction[7],
			RTResTalkAction[15]
		}
	},
	[35017007] = {
		35017007,
		0,
		Lang.get(91000),
		35017,
		7,
		424,
		{
			RTResTalkAction[19],
			RTResTalkAction[11],
			RTResTalkAction[5]
		}
	},
	[35017008] = {
		35017008,
		0,
		Lang.get(91001),
		35017,
		8,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[20]
		}
	},
	[35017009] = {
		35017009,
		0,
		Lang.get(91002),
		35017,
		9,
		196,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[35017010] = {
		35017010,
		0,
		Lang.get(91003),
		35017,
		10,
		107,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[35017011] = {
		35017011,
		0,
		Lang.get(91004),
		35017,
		11,
		196,
		{
			RTResTalkAction[31],
			RTResTalkAction[11]
		}
	},
	[35017012] = {
		35017012,
		0,
		Lang.get(91005),
		35017,
		12,
		196,
		{
			RTResTalkAction[26]
		}
	},
	[35018001] = {
		35018001,
		10,
		"81",
		35018,
		1,
		196,
		nil,
		nil,
		nil,
		5,
		nil,
		171,
		nil,
		nil,
		1
	},
	[35018002] = {
		35018002,
		0,
		Lang.get(91006),
		35018,
		2,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		35018,
		[19] = 35018,
		[17] = 1
	},
	[35018003] = {
		35018003,
		0,
		Lang.get(91007),
		35018,
		3,
		1071,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[35018004] = {
		35018004,
		0,
		Lang.get(91008),
		35018,
		4,
		107,
		{
			RTResTalkAction[7],
			RTResTalkAction[15]
		}
	},
	[35018005] = {
		35018005,
		0,
		Lang.get(91009),
		35018,
		5,
		1169,
		{
			RTResTalkAction[18],
			RTResTalkAction[11],
			RTResTalkAction[5]
		}
	},
	[35018006] = {
		35018006,
		0,
		Lang.get(91010),
		35018,
		6,
		1172,
		{
			RTResTalkAction[22],
			RTResTalkAction[8]
		}
	},
	[35018007] = {
		35018007,
		0,
		Lang.get(91011),
		35018,
		7,
		1169,
		{
			RTResTalkAction[22],
			RTResTalkAction[8]
		}
	},
	[35018008] = {
		35018008,
		0,
		Lang.get(91012),
		35018,
		8,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[13],
			RTResTalkAction[12]
		}
	},
	[35018009] = {
		35018009,
		0,
		Lang.get(91013),
		35018,
		9,
		1172,
		{
			RTResTalkAction[32],
			RTResTalkAction[8],
			RTResTalkAction[11]
		}
	},
	[35018010] = {
		35018010,
		0,
		Lang.get(91014),
		35018,
		10,
		1169,
		{
			RTResTalkAction[22],
			RTResTalkAction[8]
		}
	},
	[35018011] = {
		35018011,
		0,
		Lang.get(91015),
		35018,
		11,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[13],
			RTResTalkAction[12]
		}
	},
	[35019001] = {
		35019001,
		10,
		"82",
		35019,
		1,
		107,
		nil,
		nil,
		nil,
		5,
		nil,
		171,
		nil,
		nil,
		1
	},
	[35019002] = {
		35019002,
		0,
		Lang.get(91016),
		35019,
		2,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		35019,
		[19] = 35019,
		[17] = 1
	},
	[35019003] = {
		35019003,
		0,
		Lang.get(91017),
		35019,
		3,
		1071,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[35019004] = {
		35019004,
		0,
		Lang.get(91018),
		35019,
		4,
		196,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[35019005] = {
		35019005,
		0,
		Lang.get(91019),
		35019,
		5,
		1169,
		{
			RTResTalkAction[18],
			RTResTalkAction[5],
			RTResTalkAction[6]
		}
	},
	[35019006] = {
		35019006,
		0,
		Lang.get(91020),
		35019,
		6,
		107,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[35019007] = {
		35019007,
		0,
		Lang.get(91021),
		35019,
		7,
		1169,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[35019008] = {
		35019008,
		0,
		Lang.get(91022),
		35019,
		8,
		107,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[35020001] = {
		35020001,
		10,
		"83",
		35020,
		1,
		107,
		nil,
		nil,
		nil,
		5,
		nil,
		171,
		nil,
		nil,
		1
	},
	[35020002] = {
		35020002,
		0,
		Lang.get(91023),
		35020,
		2,
		1169,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		35020,
		[19] = 35020,
		[17] = 1
	},
	[35020003] = {
		35020003,
		0,
		Lang.get(91024),
		35020,
		3,
		1172,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3
	},
	[35020004] = {
		35020004,
		0,
		Lang.get(91025),
		35020,
		4,
		1169,
		{
			RTResTalkAction[22],
			RTResTalkAction[8]
		}
	},
	[35020005] = {
		35020005,
		0,
		Lang.get(91026),
		35020,
		5,
		1172,
		{
			RTResTalkAction[22],
			RTResTalkAction[8]
		}
	},
	[35020006] = {
		35020006,
		0,
		Lang.get(91027),
		35020,
		6,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[13],
			RTResTalkAction[12]
		}
	},
	[35020007] = {
		35020007,
		0,
		Lang.get(91028),
		35020,
		7,
		1169,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[35020008] = {
		35020008,
		0,
		Lang.get(91029),
		35020,
		8,
		1169,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[35020009] = {
		35020009,
		0,
		Lang.get(91030),
		35020,
		9,
		424,
		{
			RTResTalkAction[19],
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[35020010] = {
		35020010,
		0,
		Lang.get(91031),
		35020,
		10,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[20]
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
