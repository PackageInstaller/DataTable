-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\Mikage\\ResTalk.lua

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
	[2] = 1047
}
RTResTalkAction[2] = {
	[1] = 2,
	[2] = 119
}
RTResTalkAction[3] = {
	[1] = 3,
	[2] = 1047
}
RTResTalkAction[4] = {
	[1] = 0,
	[2] = 119
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 1047
}
RTResTalkAction[6] = {
	[1] = 1,
	[2] = 128
}
RTResTalkAction[7] = {
	[1] = 0,
	[2] = 128
}
RTResTalkAction[8] = {
	[1] = 1,
	[2] = 882
}
RTResTalkAction[9] = {
	[1] = 0,
	[2] = 882
}
RTResTalkAction[10] = {
	[1] = 1,
	[2] = 1296
}
RTResTalkAction[11] = {
	[1] = 0,
	[2] = 1296
}
RTResTalkAction[12] = {
	[1] = 1,
	[2] = 119
}
RTResTalkAction[13] = {
	[1] = 1,
	[2] = 435
}
RTResTalkAction[14] = {
	[1] = 0,
	[2] = 435
}
RTResTalkAction[15] = {
	[1] = 2,
	[2] = 128
}
RTResTalkAction[16] = {
	[1] = 1,
	[2] = 287
}
RTResTalkAction[17] = {
	[1] = 0,
	[2] = 287
}
RTResTalkAction[18] = {
	[1] = 1,
	[2] = 436
}
RTResTalkAction[19] = {
	[1] = 0,
	[2] = 436
}
RTResTalkAction[20] = {
	1,
	287,
	nil,
	nil,
	1
}
RTResTalkAction[21] = {
	1,
	887,
	nil,
	nil,
	2
}
RTResTalkAction[22] = {
	[1] = 0,
	[2] = 887
}
RTResTalkAction[23] = {
	[1] = 1,
	[2] = 225
}
RTResTalkAction[24] = {
	[1] = 0,
	[2] = 225
}
RTResTalkAction[25] = {
	[1] = 1,
	[2] = 278
}
RTResTalkAction[26] = {
	[1] = 0,
	[2] = 278
}
RTResTalkAction[27] = {
	[1] = 2,
	[2] = 278
}
RTResTalkAction[28] = {
	[1] = 3,
	[2] = 225
}
RTResTalkAction[29] = {
	[1] = 1,
	[2] = 890
}
RTResTalkAction[30] = {
	[1] = 2,
	[2] = 891
}
RTResTalkAction[31] = {
	[1] = 3,
	[2] = 890
}
RTResTalkAction[32] = {
	[1] = 0,
	[2] = 891
}
RTResTalkAction[33] = {
	[1] = 0,
	[2] = 890
}
RTResTalkAction[34] = {
	[1] = 1,
	[2] = 257
}
RTResTalkAction[35] = {
	[1] = 1,
	[2] = 376
}
RTResTalkAction[36] = {
	[1] = 0,
	[2] = 257
}
RTResTalkAction[37] = {
	[1] = 1,
	[2] = 364
}
RTResTalkAction[38] = {
	[1] = 0,
	[2] = 376
}
RTResTalkAction[39] = {
	[1] = 0,
	[2] = 364
}
RTResTalkAction[40] = {
	[1] = 1,
	[2] = 1269
}
RTResTalkAction[41] = {
	[1] = 0,
	[2] = 1269
}
RTResTalkAction[42] = {
	[1] = 1,
	[2] = 1237
}
RTResTalkAction[43] = {
	[1] = 1,
	[2] = 1142
}
RTResTalkAction[44] = {
	[1] = 0,
	[2] = 1237
}
RTResTalkAction[45] = {
	[1] = 0,
	[2] = 1142
}
RTResTalkAction[46] = {
	[1] = 1,
	[2] = 1118
}
RTResTalkAction[47] = {
	[1] = 0,
	[2] = 1118
}
RTResTalkAction[48] = {
	[1] = 2,
	[2] = 1237
}
RTResTalkAction[49] = {
	[1] = 3,
	[2] = 1142
}
RTResTalkAction[50] = {
	[1] = 1,
	[2] = 1233
}
RTResTalkAction[51] = {
	[1] = 0,
	[2] = 1233
}
RTResTalkAction[52] = {
	[1] = 1,
	[2] = 892
}
RTResTalkAction[53] = {
	[1] = 0,
	[2] = 892
}
RTResTalkAction[54] = {
	[1] = 1,
	[2] = 677
}
RTResTalkAction[55] = {
	[1] = 0,
	[2] = 677
}
RTResTalkAction[56] = {
	[1] = 2,
	[2] = 1118
}
RTResTalkAction[57] = {
	[1] = 2,
	[2] = 257
}
RTResTalkAction[58] = {
	[1] = 3,
	[2] = 1269
}
RTResTalkAction[59] = {
	[1] = 1,
	[2] = 112
}
RTResTalkAction[60] = {
	[1] = 0,
	[2] = 112
}
RTResTalkAction[61] = {
	[1] = 3,
	[2] = 112
}
RTResTalkAction[62] = {
	[1] = 3,
	[2] = 677
}
RTResTalkAction[63] = {
	[1] = 2,
	[2] = 677
}
RTResTalkAction[64] = {
	[1] = 3,
	[2] = 278
}
RTResTalkAction[65] = {
	[1] = 2,
	[2] = 1296
}
RTResTalkAction[66] = {
	[1] = 1,
	[2] = 893
}
RTResTalkAction[67] = {
	[1] = 0,
	[2] = 893
}
RTResTalkAction[68] = {
	[1] = 3,
	[2] = 1296
}

local Data = {
	[41800001] = {
		41800001,
		0,
		Lang.get(111927),
		41800,
		1,
		1047,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		41800,
		nil,
		1,
		nil,
		nil,
		nil,
		41800
	},
	[41800002] = {
		41800002,
		0,
		Lang.get(111928),
		41800,
		2,
		1047,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[41800003] = {
		41800003,
		0,
		Lang.get(111929),
		41800,
		3,
		1047,
		{
			RTResTalkAction[1]
		}
	},
	[41800004] = {
		41800004,
		0,
		Lang.get(111930),
		41800,
		4,
		119,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[41800005] = {
		41800005,
		0,
		Lang.get(111931),
		41800,
		5,
		119,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[41800006] = {
		41800006,
		0,
		Lang.get(111932),
		41800,
		6,
		1047,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[41800007] = {
		41800007,
		0,
		Lang.get(111933),
		41800,
		7,
		1047,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[41800008] = {
		41800008,
		0,
		Lang.get(111934),
		41800,
		8,
		119,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[41800009] = {
		41800009,
		0,
		Lang.get(111935),
		41800,
		9,
		1047,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[41800010] = {
		41800010,
		0,
		Lang.get(111936),
		41800,
		10,
		119,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[41800011] = {
		41800011,
		0,
		Lang.get(111937),
		41800,
		11,
		1047,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[41800012] = {
		41800012,
		3,
		Lang.get(111938),
		41800,
		12,
		605,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		41801,
		nil,
		1,
		[19] = 41801,
		[22] = 1
	},
	[41800013] = {
		41800013,
		0,
		Lang.get(111939),
		41800,
		13,
		1047,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[41800014] = {
		41800014,
		0,
		Lang.get(111940),
		41800,
		14,
		119,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[41800015] = {
		41800015,
		0,
		Lang.get(111941),
		41800,
		15,
		1047,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[41800016] = {
		41800016,
		0,
		Lang.get(111942),
		41800,
		16,
		128,
		{
			RTResTalkAction[6],
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[41800017] = {
		41800017,
		0,
		Lang.get(111943),
		41800,
		17,
		1047,
		{
			RTResTalkAction[1],
			RTResTalkAction[7]
		}
	},
	[41800018] = {
		41800018,
		0,
		Lang.get(111944),
		41800,
		18,
		119,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[41800019] = {
		41800019,
		0,
		Lang.get(111945),
		41800,
		19,
		128,
		{
			RTResTalkAction[6],
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[41800020] = {
		41800020,
		0,
		Lang.get(111946),
		41800,
		20,
		882,
		{
			RTResTalkAction[8],
			RTResTalkAction[7]
		}
	},
	[41800021] = {
		41800021,
		0,
		Lang.get(111947),
		41800,
		21,
		1296,
		{
			RTResTalkAction[9]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		41802,
		nil,
		1,
		nil,
		nil,
		nil,
		41802
	},
	[41800022] = {
		41800022,
		7,
		"122",
		41800,
		22,
		1296,
		nil,
		nil,
		nil,
		5
	},
	[41800023] = {
		41800023,
		0,
		Lang.get(111948),
		41800,
		23,
		1296,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3
	},
	[41800024] = {
		41800024,
		0,
		Lang.get(111949),
		41800,
		24,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41800025] = {
		41800025,
		0,
		Lang.get(111950),
		41800,
		25,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41800026] = {
		41800026,
		0,
		Lang.get(111951),
		41800,
		26,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41800027] = {
		41800027,
		0,
		Lang.get(111952),
		41800,
		27,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41800028] = {
		41800028,
		0,
		Lang.get(111953),
		41800,
		28,
		1047,
		{
			RTResTalkAction[1],
			RTResTalkAction[11]
		}
	},
	[41800029] = {
		41800029,
		0,
		Lang.get(111954),
		41800,
		29,
		119,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[41800030] = {
		41800030,
		0,
		Lang.get(111955),
		41800,
		30,
		128,
		{
			RTResTalkAction[6],
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[41801001] = {
		41801001,
		3,
		Lang.get(111956),
		41801,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		41803,
		nil,
		1,
		nil,
		nil,
		nil,
		41803,
		nil,
		nil,
		1
	},
	[41801002] = {
		41801002,
		0,
		Lang.get(111957),
		41801,
		2,
		1047,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[41801003] = {
		41801003,
		0,
		Lang.get(111958),
		41801,
		3,
		119,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[41801004] = {
		41801004,
		0,
		Lang.get(111959),
		41801,
		4,
		128,
		{
			RTResTalkAction[6],
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[41801005] = {
		41801005,
		0,
		Lang.get(111960),
		41801,
		5,
		1047,
		{
			RTResTalkAction[1],
			RTResTalkAction[7]
		}
	},
	[41801006] = {
		41801006,
		4,
		nil,
		41801,
		6,
		1047,
		{
			RTResTalkAction[5]
		},
		[29] = {
			{
				id = 41801007,
				branch_content = Lang.get(111961)
			},
			{
				id = 41801007,
				branch_content = Lang.get(82278)
			}
		}
	},
	[41801007] = {
		41801007,
		0,
		Lang.get(111962),
		41801,
		7,
		119,
		{
			RTResTalkAction[12]
		}
	},
	[41801008] = {
		41801008,
		0,
		Lang.get(111963),
		41801,
		8,
		605,
		{
			RTResTalkAction[4]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		41889,
		nil,
		1,
		[19] = 41889
	},
	[41801009] = {
		41801009,
		0,
		Lang.get(111964),
		41801,
		9,
		1047,
		{
			RTResTalkAction[13]
		},
		1,
		nil,
		3,
		[21] = 435
	},
	[41801010] = {
		41801010,
		0,
		Lang.get(111965),
		41801,
		10,
		1047,
		{
			RTResTalkAction[13]
		},
		1,
		[21] = 435
	},
	[41801011] = {
		41801011,
		0,
		Lang.get(111966),
		41801,
		11,
		119,
		{
			RTResTalkAction[12],
			RTResTalkAction[14]
		}
	},
	[41801012] = {
		41801012,
		0,
		Lang.get(111967),
		41801,
		12,
		119,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[41801013] = {
		41801013,
		4,
		nil,
		41801,
		13,
		119,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		},
		[29] = {
			{
				id = 41801014,
				branch_content = Lang.get(111968)
			},
			{
				id = 41801014,
				branch_content = Lang.get(111969)
			}
		}
	},
	[41801014] = {
		41801014,
		0,
		Lang.get(111970),
		41801,
		14,
		128,
		{
			RTResTalkAction[6]
		}
	},
	[41801015] = {
		41801015,
		0,
		Lang.get(111971),
		41801,
		15,
		128,
		{
			RTResTalkAction[6]
		}
	},
	[41801016] = {
		41801016,
		0,
		Lang.get(111972),
		41801,
		16,
		1047,
		{
			RTResTalkAction[15],
			RTResTalkAction[3]
		}
	},
	[41801017] = {
		41801017,
		0,
		Lang.get(111973),
		41801,
		17,
		883,
		{
			RTResTalkAction[7],
			RTResTalkAction[5]
		},
		1
	},
	[41801018] = {
		41801018,
		0,
		Lang.get(111974),
		41801,
		18,
		884,
		nil,
		1
	},
	[41801019] = {
		41801019,
		0,
		Lang.get(111975),
		41801,
		19,
		883,
		nil,
		1
	},
	[41801020] = {
		41801020,
		0,
		Lang.get(111976),
		41801,
		20,
		1047,
		{
			RTResTalkAction[1]
		}
	},
	[41801021] = {
		41801021,
		0,
		Lang.get(111977),
		41801,
		21,
		119,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[41802001] = {
		41802001,
		0,
		Lang.get(111978),
		41802,
		1,
		119,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		41804,
		nil,
		1,
		nil,
		nil,
		nil,
		41804
	},
	[41802002] = {
		41802002,
		0,
		Lang.get(111979),
		41802,
		2,
		883,
		nil,
		1
	},
	[41802003] = {
		41802003,
		0,
		Lang.get(111980),
		41802,
		3,
		884,
		nil,
		1
	},
	[41802004] = {
		41802004,
		0,
		Lang.get(111981),
		41802,
		4,
		1047,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[41802005] = {
		41802005,
		0,
		Lang.get(111982),
		41802,
		5,
		119,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[41802006] = {
		41802006,
		0,
		Lang.get(111983),
		41802,
		6,
		885,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		},
		1
	},
	[41802007] = {
		41802007,
		0,
		Lang.get(111984),
		41802,
		7,
		886,
		nil,
		1
	},
	[41802008] = {
		41802008,
		0,
		Lang.get(111985),
		41802,
		8,
		1047,
		{
			RTResTalkAction[1]
		}
	},
	[41802009] = {
		41802009,
		0,
		Lang.get(111986),
		41802,
		9,
		883,
		{
			RTResTalkAction[5]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		41805,
		nil,
		1,
		nil,
		nil,
		nil,
		41805
	},
	[41802010] = {
		41802010,
		0,
		Lang.get(111987),
		41802,
		10,
		884,
		nil,
		1
	},
	[41802011] = {
		41802011,
		0,
		Lang.get(111988),
		41802,
		11,
		1047,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[41802012] = {
		41802012,
		0,
		Lang.get(111989),
		41802,
		12,
		119,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[41802013] = {
		41802013,
		0,
		Lang.get(111990),
		41802,
		13,
		883,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		},
		1
	},
	[41802014] = {
		41802014,
		0,
		Lang.get(111991),
		41802,
		14,
		287,
		{
			RTResTalkAction[16]
		}
	},
	[41802015] = {
		41802015,
		0,
		Lang.get(111992),
		41802,
		15,
		287,
		{
			RTResTalkAction[16]
		}
	},
	[41802016] = {
		41802016,
		0,
		Lang.get(111993),
		41802,
		16,
		1047,
		{
			RTResTalkAction[1],
			RTResTalkAction[17]
		}
	},
	[41802017] = {
		41802017,
		0,
		Lang.get(111994),
		41802,
		17,
		1047,
		{
			RTResTalkAction[1]
		}
	},
	[41802018] = {
		41802018,
		0,
		Lang.get(45728),
		41802,
		18,
		287,
		{
			RTResTalkAction[16],
			RTResTalkAction[5]
		}
	},
	[41802019] = {
		41802019,
		0,
		Lang.get(111995),
		41802,
		19,
		119,
		{
			RTResTalkAction[12],
			RTResTalkAction[17]
		}
	},
	[41802020] = {
		41802020,
		0,
		Lang.get(111996),
		41802,
		20,
		119,
		{
			RTResTalkAction[12]
		}
	},
	[41802021] = {
		41802021,
		0,
		Lang.get(111997),
		41802,
		21,
		883,
		{
			RTResTalkAction[4]
		},
		1
	},
	[41802022] = {
		41802022,
		0,
		Lang.get(67973),
		41802,
		22,
		287,
		{
			RTResTalkAction[16]
		}
	},
	[41802023] = {
		41802023,
		0,
		Lang.get(111998),
		41802,
		23,
		287,
		{
			RTResTalkAction[16]
		}
	},
	[41802024] = {
		41802024,
		0,
		Lang.get(111999),
		41802,
		24,
		287,
		{
			RTResTalkAction[16]
		}
	},
	[41802025] = {
		41802025,
		0,
		Lang.get(112000),
		41802,
		25,
		1047,
		{
			RTResTalkAction[1],
			RTResTalkAction[17]
		}
	},
	[41802026] = {
		41802026,
		0,
		Lang.get(112001),
		41802,
		26,
		119,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[41803001] = {
		41803001,
		0,
		Lang.get(112002),
		41803,
		1,
		1296,
		nil,
		1,
		nil,
		nil,
		nil,
		169,
		41806,
		nil,
		1,
		nil,
		nil,
		nil,
		41806
	},
	[41803002] = {
		41803002,
		0,
		Lang.get(112003),
		41803,
		2,
		1296,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3
	},
	[41803003] = {
		41803003,
		0,
		Lang.get(112004),
		41803,
		3,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41803004] = {
		41803004,
		0,
		Lang.get(112005),
		41803,
		4,
		287,
		{
			RTResTalkAction[16],
			RTResTalkAction[11]
		}
	},
	[41803005] = {
		41803005,
		0,
		Lang.get(112006),
		41803,
		5,
		1296,
		{
			RTResTalkAction[10],
			RTResTalkAction[17]
		}
	},
	[41803006] = {
		41803006,
		0,
		Lang.get(112007),
		41803,
		6,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41803007] = {
		41803007,
		0,
		Lang.get(112008),
		41803,
		7,
		287,
		{
			RTResTalkAction[16],
			RTResTalkAction[11]
		}
	},
	[41803008] = {
		41803008,
		4,
		nil,
		41803,
		8,
		287,
		{
			RTResTalkAction[17]
		},
		[29] = {
			{
				id = 41803009,
				branch_content = Lang.get(112009)
			},
			{
				id = 41803009,
				branch_content = Lang.get(112010)
			}
		}
	},
	[41803009] = {
		41803009,
		0,
		Lang.get(112011),
		41803,
		9,
		287,
		{
			RTResTalkAction[16]
		}
	},
	[41803010] = {
		41803010,
		0,
		Lang.get(112012),
		41803,
		10,
		1296,
		{
			RTResTalkAction[10],
			RTResTalkAction[17]
		}
	},
	[41803011] = {
		41803011,
		0,
		Lang.get(112013),
		41803,
		11,
		300,
		{
			RTResTalkAction[11]
		}
	},
	[41803012] = {
		41803012,
		0,
		Lang.get(112014),
		41803,
		12,
		300
	},
	[41803013] = {
		41803013,
		0,
		Lang.get(112015),
		41803,
		13,
		287,
		{
			RTResTalkAction[16]
		}
	},
	[41803014] = {
		41803014,
		0,
		Lang.get(112016),
		41803,
		14,
		287,
		{
			RTResTalkAction[16]
		}
	},
	[41803015] = {
		41803015,
		2,
		Lang.get(112017),
		41803,
		15,
		1296,
		{
			RTResTalkAction[10],
			RTResTalkAction[17]
		}
	},
	[41803016] = {
		41803016,
		3,
		Lang.get(26774),
		41803,
		16,
		605,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		41807,
		nil,
		1,
		[19] = 41807,
		[22] = 1
	},
	[41803017] = {
		41803017,
		0,
		Lang.get(112018),
		41803,
		17,
		1296,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3
	},
	[41803018] = {
		41803018,
		0,
		Lang.get(112019),
		41803,
		18,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41803019] = {
		41803019,
		0,
		Lang.get(112020),
		41803,
		19,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41803020] = {
		41803020,
		0,
		Lang.get(112021),
		41803,
		20,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41803021] = {
		41803021,
		0,
		Lang.get(112022),
		41803,
		21,
		1047,
		{
			RTResTalkAction[1],
			RTResTalkAction[11]
		}
	},
	[41803022] = {
		41803022,
		0,
		Lang.get(112023),
		41803,
		22,
		1047,
		{
			RTResTalkAction[1]
		}
	},
	[41803023] = {
		41803023,
		0,
		Lang.get(112024),
		41803,
		23,
		119,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[41803024] = {
		41803024,
		0,
		Lang.get(112025),
		41803,
		24,
		119,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[41803025] = {
		41803025,
		0,
		Lang.get(112026),
		41803,
		25,
		885,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		},
		1
	},
	[41803026] = {
		41803026,
		0,
		Lang.get(112027),
		41803,
		26,
		886,
		nil,
		1
	},
	[41803027] = {
		41803027,
		0,
		Lang.get(112028),
		41803,
		27,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41803028] = {
		41803028,
		0,
		Lang.get(112029),
		41803,
		28,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41803029] = {
		41803029,
		0,
		Lang.get(112030),
		41803,
		29,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41804001] = {
		41804001,
		3,
		Lang.get(112031),
		41804,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		194,
		41808,
		nil,
		1,
		nil,
		nil,
		nil,
		41808,
		nil,
		nil,
		1
	},
	[41804002] = {
		41804002,
		0,
		Lang.get(112032),
		41804,
		2,
		1296,
		{
			RTResTalkAction[18]
		},
		1,
		nil,
		3,
		[21] = 436
	},
	[41804003] = {
		41804003,
		0,
		Lang.get(112033),
		41804,
		3,
		1296,
		{
			RTResTalkAction[18]
		},
		1,
		[21] = 436
	},
	[41804004] = {
		41804004,
		0,
		Lang.get(112034),
		41804,
		4,
		1296,
		{
			RTResTalkAction[10],
			RTResTalkAction[19]
		}
	},
	[41804005] = {
		41804005,
		0,
		"………………",
		41804,
		5,
		287,
		{
			RTResTalkAction[20],
			RTResTalkAction[11]
		}
	},
	[41804006] = {
		41804006,
		0,
		Lang.get(112035),
		41804,
		6,
		1296,
		{
			RTResTalkAction[10],
			RTResTalkAction[17]
		}
	},
	[41804007] = {
		41804007,
		0,
		Lang.get(112036),
		41804,
		7,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41804008] = {
		41804008,
		0,
		Lang.get(112037),
		41804,
		8,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41804009] = {
		41804009,
		0,
		Lang.get(112038),
		41804,
		9,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41804010] = {
		41804010,
		3,
		Lang.get(112039),
		41804,
		10,
		605,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		nil,
		2756,
		63,
		nil,
		nil,
		1,
		nil,
		nil,
		nil,
		41809,
		255,
		nil,
		1
	},
	[41804011] = {
		41804011,
		0,
		Lang.get(112040),
		41804,
		11,
		287,
		{
			RTResTalkAction[20]
		},
		nil,
		nil,
		3
	},
	[41804012] = {
		41804012,
		0,
		Lang.get(112041),
		41804,
		12,
		287,
		{
			RTResTalkAction[20]
		}
	},
	[41804013] = {
		41804013,
		0,
		Lang.get(112042),
		41804,
		13,
		887,
		{
			RTResTalkAction[21],
			RTResTalkAction[17]
		}
	},
	[41804014] = {
		41804014,
		0,
		Lang.get(112043),
		41804,
		14,
		887,
		{
			RTResTalkAction[21]
		}
	},
	[41804015] = {
		41804015,
		0,
		Lang.get(112044),
		41804,
		15,
		887,
		{
			RTResTalkAction[21]
		}
	},
	[41804016] = {
		41804016,
		0,
		Lang.get(20587),
		41804,
		16,
		287,
		{
			RTResTalkAction[20],
			RTResTalkAction[22]
		}
	},
	[41804017] = {
		41804017,
		0,
		Lang.get(112045),
		41804,
		17,
		887,
		{
			RTResTalkAction[21],
			RTResTalkAction[17]
		}
	},
	[41804018] = {
		41804018,
		0,
		Lang.get(112046),
		41804,
		18,
		887,
		{
			RTResTalkAction[21]
		}
	},
	[41804019] = {
		41804019,
		3,
		Lang.get(106209),
		41804,
		19,
		605,
		{
			RTResTalkAction[22]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		41810,
		nil,
		1,
		nil,
		nil,
		nil,
		41810,
		-1,
		nil,
		1
	},
	[41804020] = {
		41804020,
		0,
		Lang.get(112047),
		41804,
		20,
		1296,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3
	},
	[41804021] = {
		41804021,
		4,
		nil,
		41804,
		21,
		1296,
		{
			RTResTalkAction[10]
		},
		[29] = {
			{
				id = 41804022,
				branch_content = Lang.get(112048)
			},
			{
				id = 41804022,
				branch_content = Lang.get(112049)
			}
		}
	},
	[41804022] = {
		41804022,
		0,
		Lang.get(112050),
		41804,
		22,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41804023] = {
		41804023,
		4,
		nil,
		41804,
		23,
		1296,
		{
			RTResTalkAction[10]
		},
		[29] = {
			{
				id = 41804024,
				branch_content = Lang.get(112051)
			},
			{
				id = 41804024,
				branch_content = Lang.get(112052)
			}
		}
	},
	[41804024] = {
		41804024,
		0,
		Lang.get(112053),
		41804,
		24,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41804025] = {
		41804025,
		0,
		Lang.get(112054),
		41804,
		25,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41804026] = {
		41804026,
		0,
		Lang.get(112055),
		41804,
		26,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41804027] = {
		41804027,
		4,
		nil,
		41804,
		27,
		1296,
		{
			RTResTalkAction[10]
		},
		[29] = {
			{
				id = 41804028,
				branch_content = Lang.get(112056)
			}
		}
	},
	[41804028] = {
		41804028,
		0,
		Lang.get(112057),
		41804,
		28,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41804029] = {
		41804029,
		0,
		Lang.get(112058),
		41804,
		29,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41804030] = {
		41804030,
		0,
		Lang.get(112059),
		41804,
		30,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41805001] = {
		41805001,
		3,
		Lang.get(112060),
		41805,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		41811,
		nil,
		1,
		nil,
		nil,
		nil,
		41811,
		nil,
		nil,
		1
	},
	[41805002] = {
		41805002,
		0,
		Lang.get(112061),
		41805,
		2,
		225,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[41805003] = {
		41805003,
		0,
		Lang.get(112062),
		41805,
		3,
		225,
		{
			RTResTalkAction[23]
		}
	},
	[41805004] = {
		41805004,
		0,
		Lang.get(112063),
		41805,
		4,
		605,
		{
			RTResTalkAction[24]
		}
	},
	[41805005] = {
		41805005,
		0,
		Lang.get(112064),
		41805,
		5,
		605
	},
	[41805006] = {
		41805006,
		0,
		Lang.get(112065),
		41805,
		6,
		605
	},
	[41805007] = {
		41805007,
		0,
		Lang.get(112066),
		41805,
		7,
		225,
		{
			RTResTalkAction[23]
		}
	},
	[41805008] = {
		41805008,
		0,
		Lang.get(112067),
		41805,
		8,
		225,
		{
			RTResTalkAction[23]
		}
	},
	[41805009] = {
		41805009,
		0,
		Lang.get(112068),
		41805,
		9,
		225,
		{
			RTResTalkAction[23]
		}
	},
	[41805010] = {
		41805010,
		3,
		Lang.get(112069),
		41805,
		10,
		605,
		{
			RTResTalkAction[24]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		41812,
		nil,
		1,
		[19] = 41812,
		[22] = 1
	},
	[41805011] = {
		41805011,
		0,
		Lang.get(112070),
		41805,
		11,
		278,
		{
			RTResTalkAction[25]
		},
		nil,
		nil,
		3
	},
	[41805012] = {
		41805012,
		0,
		Lang.get(112071),
		41805,
		12,
		278,
		{
			RTResTalkAction[25]
		}
	},
	[41805013] = {
		41805013,
		0,
		Lang.get(112072),
		41805,
		13,
		278,
		{
			RTResTalkAction[25]
		}
	},
	[41805014] = {
		41805014,
		0,
		Lang.get(112073),
		41805,
		14,
		278,
		{
			RTResTalkAction[25]
		}
	},
	[41805015] = {
		41805015,
		0,
		Lang.get(112074),
		41805,
		15,
		605,
		{
			RTResTalkAction[26]
		}
	},
	[41805016] = {
		41805016,
		0,
		Lang.get(112075),
		41805,
		16,
		605
	},
	[41805017] = {
		41805017,
		0,
		Lang.get(112076),
		41805,
		17,
		605
	},
	[41805018] = {
		41805018,
		0,
		Lang.get(112077),
		41805,
		18,
		278,
		{
			RTResTalkAction[25]
		}
	},
	[41805019] = {
		41805019,
		0,
		Lang.get(112078),
		41805,
		19,
		225,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41805020] = {
		41805020,
		0,
		Lang.get(112079),
		41805,
		20,
		225,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41805021] = {
		41805021,
		0,
		Lang.get(112080),
		41805,
		21,
		278,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41805022] = {
		41805022,
		0,
		Lang.get(112081),
		41805,
		22,
		278,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41805023] = {
		41805023,
		0,
		Lang.get(112082),
		41805,
		23,
		225,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41805024] = {
		41805024,
		0,
		Lang.get(112083),
		41805,
		24,
		278,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41805025] = {
		41805025,
		0,
		Lang.get(112084),
		41805,
		25,
		278,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41805026] = {
		41805026,
		0,
		Lang.get(112085),
		41805,
		26,
		225,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41806001] = {
		41806001,
		3,
		Lang.get(112086),
		41806,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		41813,
		nil,
		1,
		nil,
		nil,
		nil,
		41813,
		nil,
		nil,
		1
	},
	[41806002] = {
		41806002,
		0,
		Lang.get(112087),
		41806,
		2,
		225,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[41806003] = {
		41806003,
		0,
		Lang.get(112088),
		41806,
		3,
		225,
		{
			RTResTalkAction[23]
		}
	},
	[41806004] = {
		41806004,
		0,
		Lang.get(112089),
		41806,
		4,
		278,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41806005] = {
		41806005,
		0,
		Lang.get(112090),
		41806,
		5,
		278,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41806006] = {
		41806006,
		0,
		Lang.get(112091),
		41806,
		6,
		225,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41806007] = {
		41806007,
		0,
		Lang.get(112092),
		41806,
		7,
		278,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41806008] = {
		41806008,
		0,
		Lang.get(112093),
		41806,
		8,
		225,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41806009] = {
		41806009,
		0,
		Lang.get(112094),
		41806,
		9,
		278,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41806010] = {
		41806010,
		0,
		Lang.get(112095),
		41806,
		10,
		278,
		{
			RTResTalkAction[26],
			RTResTalkAction[24]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		41814,
		nil,
		1,
		nil,
		nil,
		nil,
		41814
	},
	[41806011] = {
		41806011,
		0,
		Lang.get(112096),
		41806,
		11,
		278,
		{
			RTResTalkAction[25]
		},
		nil,
		nil,
		3
	},
	[41806012] = {
		41806012,
		0,
		Lang.get(112097),
		41806,
		12,
		225,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41806013] = {
		41806013,
		0,
		Lang.get(112098),
		41806,
		13,
		225,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41806014] = {
		41806014,
		0,
		Lang.get(112099),
		41806,
		14,
		225,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41806015] = {
		41806015,
		0,
		Lang.get(112100),
		41806,
		15,
		278,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41806016] = {
		41806016,
		0,
		Lang.get(112101),
		41806,
		16,
		225,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41806017] = {
		41806017,
		0,
		Lang.get(112102),
		41806,
		17,
		225,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41806018] = {
		41806018,
		0,
		Lang.get(112103),
		41806,
		18,
		278,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41806019] = {
		41806019,
		0,
		Lang.get(112104),
		41806,
		19,
		225,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41806020] = {
		41806020,
		0,
		Lang.get(112105),
		41806,
		20,
		278,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41806021] = {
		41806021,
		0,
		Lang.get(112106),
		41806,
		21,
		605,
		{
			RTResTalkAction[26],
			RTResTalkAction[24]
		}
	},
	[41806022] = {
		41806022,
		0,
		Lang.get(112107),
		41806,
		22,
		225,
		{
			RTResTalkAction[23]
		}
	},
	[41806023] = {
		41806023,
		0,
		Lang.get(112108),
		41806,
		23,
		278,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41806024] = {
		41806024,
		0,
		Lang.get(112109),
		41806,
		24,
		278,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41807001] = {
		41807001,
		3,
		Lang.get(112110),
		41807,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		41815,
		nil,
		1,
		nil,
		nil,
		nil,
		41815,
		nil,
		nil,
		1
	},
	[41807002] = {
		41807002,
		0,
		Lang.get(112111),
		41807,
		2,
		1296,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3
	},
	[41807003] = {
		41807003,
		0,
		Lang.get(112112),
		41807,
		3,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41807004] = {
		41807004,
		0,
		Lang.get(112113),
		41807,
		4,
		888,
		{
			RTResTalkAction[11]
		},
		1
	},
	[41807005] = {
		41807005,
		0,
		Lang.get(112114),
		41807,
		5,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41807006] = {
		41807006,
		0,
		Lang.get(112115),
		41807,
		6,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41807007] = {
		41807007,
		0,
		Lang.get(112116),
		41807,
		7,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41807008] = {
		41807008,
		0,
		Lang.get(112117),
		41807,
		8,
		889,
		{
			RTResTalkAction[11]
		},
		1
	},
	[41807009] = {
		41807009,
		0,
		Lang.get(112118),
		41807,
		9,
		889,
		nil,
		1
	},
	[41807010] = {
		41807010,
		0,
		Lang.get(112119),
		41807,
		10,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41807011] = {
		41807011,
		0,
		Lang.get(112120),
		41807,
		11,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41807012] = {
		41807012,
		3,
		Lang.get(112121),
		41807,
		12,
		605,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		41816,
		nil,
		1,
		[19] = 41816,
		[22] = 1
	},
	[41807013] = {
		41807013,
		0,
		Lang.get(112122),
		41807,
		13,
		1296,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3
	},
	[41807014] = {
		41807014,
		0,
		Lang.get(112123),
		41807,
		14,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41807015] = {
		41807015,
		0,
		Lang.get(112124),
		41807,
		15,
		889,
		{
			RTResTalkAction[11]
		},
		1
	},
	[41807016] = {
		41807016,
		0,
		Lang.get(112125),
		41807,
		16,
		889,
		nil,
		1
	},
	[41807017] = {
		41807017,
		0,
		Lang.get(112126),
		41807,
		17,
		890,
		{
			RTResTalkAction[29]
		}
	},
	[41807018] = {
		41807018,
		0,
		Lang.get(112127),
		41807,
		18,
		891,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[41807019] = {
		41807019,
		0,
		Lang.get(112128),
		41807,
		19,
		1296,
		{
			RTResTalkAction[10],
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[41807020] = {
		41807020,
		0,
		Lang.get(112129),
		41807,
		20,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41807021] = {
		41807021,
		0,
		Lang.get(112130),
		41807,
		21,
		889,
		{
			RTResTalkAction[11]
		},
		1
	},
	[41807022] = {
		41807022,
		0,
		Lang.get(112131),
		41807,
		22,
		889,
		nil,
		1
	},
	[41807023] = {
		41807023,
		0,
		Lang.get(112132),
		41807,
		23,
		889,
		nil,
		1
	},
	[41807024] = {
		41807024,
		0,
		Lang.get(112133),
		41807,
		24,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41807025] = {
		41807025,
		0,
		Lang.get(112134),
		41807,
		25,
		890,
		{
			RTResTalkAction[29],
			RTResTalkAction[11]
		}
	},
	[41807026] = {
		41807026,
		0,
		Lang.get(112135),
		41807,
		26,
		891,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[41807027] = {
		41807027,
		2,
		Lang.get(112136),
		41807,
		27,
		1296,
		{
			RTResTalkAction[10],
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[41808001] = {
		41808001,
		3,
		Lang.get(112137),
		41808,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		41817,
		nil,
		1,
		nil,
		nil,
		nil,
		41817,
		nil,
		nil,
		1
	},
	[41808002] = {
		41808002,
		0,
		Lang.get(112138),
		41808,
		2,
		1296,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3
	},
	[41808003] = {
		41808003,
		0,
		Lang.get(112139),
		41808,
		3,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41808004] = {
		41808004,
		0,
		Lang.get(112140),
		41808,
		4,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41808005] = {
		41808005,
		0,
		Lang.get(112141),
		41808,
		5,
		889,
		{
			RTResTalkAction[11]
		},
		1
	},
	[41808006] = {
		41808006,
		0,
		Lang.get(112142),
		41808,
		6,
		1296,
		{
			RTResTalkAction[18]
		},
		1,
		[21] = 436
	},
	[41808007] = {
		41808007,
		0,
		Lang.get(112143),
		41808,
		7,
		1296,
		{
			RTResTalkAction[18]
		},
		1,
		[21] = 436
	},
	[41808008] = {
		41808008,
		0,
		Lang.get(112144),
		41808,
		8,
		890,
		{
			RTResTalkAction[29],
			RTResTalkAction[19]
		}
	},
	[41808009] = {
		41808009,
		0,
		Lang.get(112145),
		41808,
		9,
		891,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[41808010] = {
		41808010,
		0,
		Lang.get(112146),
		41808,
		10,
		1296,
		{
			RTResTalkAction[10],
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[41808011] = {
		41808011,
		0,
		Lang.get(112147),
		41808,
		11,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41808012] = {
		41808012,
		0,
		Lang.get(112148),
		41808,
		12,
		889,
		{
			RTResTalkAction[11]
		},
		1
	},
	[41808013] = {
		41808013,
		0,
		Lang.get(112149),
		41808,
		13,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41808014] = {
		41808014,
		3,
		Lang.get(112150),
		41808,
		14,
		605,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		41818,
		nil,
		1,
		[19] = 41818,
		[22] = 1
	},
	[41808015] = {
		41808015,
		0,
		Lang.get(112151),
		41808,
		15,
		1296,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3
	},
	[41808016] = {
		41808016,
		0,
		Lang.get(112152),
		41808,
		16,
		225,
		{
			RTResTalkAction[23],
			RTResTalkAction[11]
		}
	},
	[41808017] = {
		41808017,
		0,
		Lang.get(112153),
		41808,
		17,
		278,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41808018] = {
		41808018,
		0,
		Lang.get(112154),
		41808,
		18,
		278,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41808019] = {
		41808019,
		0,
		Lang.get(112155),
		41808,
		19,
		1296,
		{
			RTResTalkAction[10],
			RTResTalkAction[26],
			RTResTalkAction[24]
		}
	},
	[41808020] = {
		41808020,
		0,
		Lang.get(112156),
		41808,
		20,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41808021] = {
		41808021,
		0,
		Lang.get(112157),
		41808,
		21,
		225,
		{
			RTResTalkAction[23],
			RTResTalkAction[11]
		}
	},
	[41808022] = {
		41808022,
		0,
		Lang.get(112158),
		41808,
		22,
		225,
		{
			RTResTalkAction[23]
		}
	},
	[41808023] = {
		41808023,
		0,
		Lang.get(112159),
		41808,
		23,
		278,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41808024] = {
		41808024,
		0,
		Lang.get(112160),
		41808,
		24,
		278,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41808025] = {
		41808025,
		0,
		Lang.get(112161),
		41808,
		25,
		1296,
		{
			RTResTalkAction[10],
			RTResTalkAction[26],
			RTResTalkAction[24]
		}
	},
	[41808026] = {
		41808026,
		0,
		Lang.get(112162),
		41808,
		26,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41808027] = {
		41808027,
		0,
		Lang.get(112163),
		41808,
		27,
		278,
		{
			RTResTalkAction[25],
			RTResTalkAction[11]
		}
	},
	[41808028] = {
		41808028,
		0,
		Lang.get(112164),
		41808,
		28,
		1296,
		{
			RTResTalkAction[10],
			RTResTalkAction[26]
		}
	},
	[41808029] = {
		41808029,
		0,
		Lang.get(112165),
		41808,
		29,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41808030] = {
		41808030,
		0,
		Lang.get(112166),
		41808,
		30,
		278,
		{
			RTResTalkAction[25],
			RTResTalkAction[11]
		}
	},
	[41808031] = {
		41808031,
		0,
		Lang.get(112167),
		41808,
		31,
		1296,
		{
			RTResTalkAction[10],
			RTResTalkAction[26]
		}
	},
	[41809001] = {
		41809001,
		3,
		Lang.get(112168),
		41809,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		41819,
		nil,
		1,
		nil,
		nil,
		nil,
		41819,
		nil,
		nil,
		1
	},
	[41809002] = {
		41809002,
		0,
		Lang.get(112169),
		41809,
		2,
		257,
		{
			RTResTalkAction[34]
		},
		nil,
		nil,
		3
	},
	[41809003] = {
		41809003,
		0,
		Lang.get(112170),
		41809,
		3,
		257,
		{
			RTResTalkAction[35],
			RTResTalkAction[36]
		},
		1,
		[27] = 2
	},
	[41809004] = {
		41809004,
		0,
		Lang.get(112171),
		41809,
		4,
		364,
		{
			RTResTalkAction[37],
			RTResTalkAction[38]
		},
		[27] = 3
	},
	[41809005] = {
		41809005,
		0,
		Lang.get(112172),
		41809,
		5,
		257,
		{
			RTResTalkAction[37]
		},
		1,
		[27] = 3
	},
	[41809006] = {
		41809006,
		0,
		Lang.get(112173),
		41809,
		6,
		364,
		{
			RTResTalkAction[37]
		},
		[27] = 3
	},
	[41809007] = {
		41809007,
		0,
		Lang.get(112174),
		41809,
		7,
		257,
		{
			RTResTalkAction[37]
		},
		1,
		[27] = 3
	},
	[41809008] = {
		41809008,
		0,
		Lang.get(112175),
		41809,
		8,
		257,
		{
			RTResTalkAction[37]
		},
		1,
		[27] = 3
	},
	[41809009] = {
		41809009,
		0,
		Lang.get(112176),
		41809,
		9,
		257,
		{
			RTResTalkAction[37]
		},
		1,
		[27] = 3
	},
	[41809010] = {
		41809010,
		0,
		Lang.get(112177),
		41809,
		10,
		257,
		{
			RTResTalkAction[34],
			RTResTalkAction[39]
		}
	},
	[41809011] = {
		41809011,
		0,
		Lang.get(112178),
		41809,
		11,
		257,
		{
			RTResTalkAction[34]
		}
	},
	[41809012] = {
		41809012,
		0,
		Lang.get(112179),
		41809,
		12,
		257,
		{
			RTResTalkAction[34]
		}
	},
	[41809013] = {
		41809013,
		0,
		Lang.get(104900),
		41809,
		13,
		1269,
		{
			RTResTalkAction[40],
			RTResTalkAction[36]
		}
	},
	[41809014] = {
		41809014,
		3,
		Lang.get(87559),
		41809,
		14,
		605,
		{
			RTResTalkAction[41]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		41820,
		nil,
		1,
		[19] = 41820,
		[22] = 1
	},
	[41809015] = {
		41809015,
		0,
		Lang.get(112180),
		41809,
		15,
		1237,
		{
			RTResTalkAction[42]
		},
		nil,
		nil,
		3
	},
	[41809016] = {
		41809016,
		0,
		Lang.get(112181),
		41809,
		16,
		1237,
		{
			RTResTalkAction[42]
		}
	},
	[41809017] = {
		41809017,
		0,
		Lang.get(112182),
		41809,
		17,
		1142,
		{
			RTResTalkAction[43],
			RTResTalkAction[44]
		}
	},
	[41809018] = {
		41809018,
		0,
		Lang.get(112183),
		41809,
		18,
		1142,
		{
			RTResTalkAction[43]
		}
	},
	[41809019] = {
		41809019,
		0,
		Lang.get(112184),
		41809,
		19,
		1237,
		{
			RTResTalkAction[42],
			RTResTalkAction[45]
		}
	},
	[41809020] = {
		41809020,
		0,
		Lang.get(112185),
		41809,
		20,
		1142,
		{
			RTResTalkAction[43],
			RTResTalkAction[44]
		}
	},
	[41809021] = {
		41809021,
		0,
		Lang.get(112186),
		41809,
		21,
		1118,
		{
			RTResTalkAction[46],
			RTResTalkAction[45]
		}
	},
	[41809022] = {
		41809022,
		0,
		Lang.get(112187),
		41809,
		22,
		1142,
		{
			RTResTalkAction[43],
			RTResTalkAction[47]
		}
	},
	[41809023] = {
		41809023,
		0,
		Lang.get(112188),
		41809,
		23,
		1237,
		{
			RTResTalkAction[48],
			RTResTalkAction[49]
		}
	},
	[41809024] = {
		41809024,
		0,
		Lang.get(25437),
		41809,
		24,
		1118,
		{
			RTResTalkAction[46],
			RTResTalkAction[44],
			RTResTalkAction[45]
		}
	},
	[41809025] = {
		41809025,
		0,
		Lang.get(112189),
		41809,
		25,
		1118,
		{
			RTResTalkAction[46]
		}
	},
	[41809026] = {
		41809026,
		0,
		Lang.get(112190),
		41809,
		26,
		1233,
		{
			RTResTalkAction[50],
			RTResTalkAction[47]
		}
	},
	[41809027] = {
		41809027,
		0,
		Lang.get(112191),
		41809,
		27,
		1118,
		{
			RTResTalkAction[46],
			RTResTalkAction[51]
		}
	},
	[41810001] = {
		41810001,
		3,
		Lang.get(112192),
		41810,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		41821,
		nil,
		1,
		nil,
		nil,
		nil,
		41821,
		nil,
		nil,
		1
	},
	[41810002] = {
		41810002,
		0,
		Lang.get(112193),
		41810,
		2,
		885,
		nil,
		1
	},
	[41810003] = {
		41810003,
		0,
		Lang.get(112194),
		41810,
		3,
		886,
		nil,
		1
	},
	[41810004] = {
		41810004,
		0,
		Lang.get(112195),
		41810,
		4,
		892,
		{
			RTResTalkAction[52]
		},
		nil,
		nil,
		3
	},
	[41810005] = {
		41810005,
		0,
		Lang.get(112196),
		41810,
		5,
		892,
		{
			RTResTalkAction[52]
		}
	},
	[41810006] = {
		41810006,
		0,
		Lang.get(112197),
		41810,
		6,
		885,
		{
			RTResTalkAction[53]
		},
		1
	},
	[41810007] = {
		41810007,
		0,
		Lang.get(112198),
		41810,
		7,
		885,
		nil,
		1
	},
	[41810008] = {
		41810008,
		0,
		Lang.get(67973),
		41810,
		8,
		892,
		{
			RTResTalkAction[52]
		}
	},
	[41810009] = {
		41810009,
		0,
		Lang.get(112199),
		41810,
		9,
		892,
		{
			RTResTalkAction[52]
		}
	},
	[41810010] = {
		41810010,
		0,
		Lang.get(112200),
		41810,
		10,
		1233,
		{
			RTResTalkAction[50],
			RTResTalkAction[53]
		}
	},
	[41810011] = {
		41810011,
		0,
		Lang.get(112201),
		41810,
		11,
		892,
		{
			RTResTalkAction[52],
			RTResTalkAction[51]
		}
	},
	[41810012] = {
		41810012,
		0,
		Lang.get(112202),
		41810,
		12,
		1118,
		{
			RTResTalkAction[46],
			RTResTalkAction[53]
		}
	},
	[41810013] = {
		41810013,
		0,
		Lang.get(112203),
		41810,
		13,
		1118,
		{
			RTResTalkAction[46]
		}
	},
	[41810014] = {
		41810014,
		0,
		Lang.get(112204),
		41810,
		14,
		892,
		{
			RTResTalkAction[52],
			RTResTalkAction[47]
		}
	},
	[41810015] = {
		41810015,
		0,
		Lang.get(112205),
		41810,
		15,
		1118,
		{
			RTResTalkAction[46],
			RTResTalkAction[53]
		}
	},
	[41810016] = {
		41810016,
		0,
		Lang.get(112206),
		41810,
		16,
		1233,
		{
			RTResTalkAction[50],
			RTResTalkAction[47]
		}
	},
	[41810017] = {
		41810017,
		0,
		Lang.get(112207),
		41810,
		17,
		1233,
		{
			RTResTalkAction[50]
		}
	},
	[41810018] = {
		41810018,
		0,
		Lang.get(112208),
		41810,
		18,
		1118,
		{
			RTResTalkAction[46],
			RTResTalkAction[51]
		}
	},
	[41810019] = {
		41810019,
		3,
		Lang.get(26774),
		41810,
		19,
		605,
		{
			RTResTalkAction[47]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		41822,
		nil,
		1,
		[19] = 41822,
		[22] = 1
	},
	[41810020] = {
		41810020,
		0,
		Lang.get(112209),
		41810,
		20,
		225,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[41810021] = {
		41810021,
		0,
		Lang.get(112210),
		41810,
		21,
		225,
		{
			RTResTalkAction[23]
		}
	},
	[41810022] = {
		41810022,
		0,
		Lang.get(112211),
		41810,
		22,
		278,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41810023] = {
		41810023,
		0,
		Lang.get(112212),
		41810,
		23,
		278,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41810024] = {
		41810024,
		0,
		Lang.get(112213),
		41810,
		24,
		225,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41810025] = {
		41810025,
		0,
		Lang.get(112214),
		41810,
		25,
		278,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41810026] = {
		41810026,
		0,
		Lang.get(112215),
		41810,
		26,
		605,
		{
			RTResTalkAction[26],
			RTResTalkAction[24]
		}
	},
	[41810027] = {
		41810027,
		0,
		Lang.get(112216),
		41810,
		27,
		278,
		{
			RTResTalkAction[25]
		}
	},
	[41810028] = {
		41810028,
		0,
		Lang.get(112217),
		41810,
		28,
		225,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41810029] = {
		41810029,
		0,
		Lang.get(112218),
		41810,
		29,
		278,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41811001] = {
		41811001,
		3,
		Lang.get(87559),
		41811,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		41823,
		nil,
		1,
		nil,
		nil,
		nil,
		41823,
		nil,
		nil,
		1
	},
	[41811002] = {
		41811002,
		0,
		Lang.get(112219),
		41811,
		2,
		1118,
		{
			RTResTalkAction[46]
		},
		nil,
		nil,
		3
	},
	[41811003] = {
		41811003,
		0,
		Lang.get(112220),
		41811,
		3,
		1118,
		{
			RTResTalkAction[46]
		}
	},
	[41811004] = {
		41811004,
		0,
		Lang.get(112221),
		41811,
		4,
		1233,
		{
			RTResTalkAction[50],
			RTResTalkAction[47]
		}
	},
	[41811005] = {
		41811005,
		0,
		Lang.get(112222),
		41811,
		5,
		677,
		{
			RTResTalkAction[54],
			RTResTalkAction[51]
		}
	},
	[41811006] = {
		41811006,
		0,
		Lang.get(112223),
		41811,
		6,
		677,
		{
			RTResTalkAction[54]
		}
	},
	[41811007] = {
		41811007,
		0,
		Lang.get(112224),
		41811,
		7,
		1142,
		{
			RTResTalkAction[43],
			RTResTalkAction[55]
		}
	},
	[41811008] = {
		41811008,
		0,
		Lang.get(112225),
		41811,
		8,
		1118,
		{
			RTResTalkAction[56],
			RTResTalkAction[49]
		}
	},
	[41811009] = {
		41811009,
		0,
		Lang.get(112226),
		41811,
		9,
		1118,
		{
			RTResTalkAction[56],
			RTResTalkAction[49]
		}
	},
	[41811010] = {
		41811010,
		0,
		Lang.get(112227),
		41811,
		10,
		257,
		{
			RTResTalkAction[34],
			RTResTalkAction[47],
			RTResTalkAction[45]
		}
	},
	[41811011] = {
		41811011,
		0,
		Lang.get(112228),
		41811,
		11,
		257,
		{
			RTResTalkAction[34]
		}
	},
	[41811012] = {
		41811012,
		0,
		Lang.get(112229),
		41811,
		12,
		1269,
		{
			RTResTalkAction[57],
			RTResTalkAction[58]
		}
	},
	[41811013] = {
		41811013,
		0,
		Lang.get(112230),
		41811,
		13,
		1269,
		{
			RTResTalkAction[40],
			RTResTalkAction[36]
		}
	},
	[41811014] = {
		41811014,
		0,
		Lang.get(112231),
		41811,
		14,
		1269,
		{
			RTResTalkAction[40]
		}
	},
	[41811015] = {
		41811015,
		0,
		Lang.get(112232),
		41811,
		15,
		1269,
		{
			RTResTalkAction[40]
		}
	},
	[41811016] = {
		41811016,
		2,
		Lang.get(112233),
		41811,
		16,
		112,
		{
			RTResTalkAction[59],
			RTResTalkAction[41]
		}
	},
	[41811017] = {
		41811017,
		3,
		Lang.get(112234),
		41811,
		17,
		605,
		{
			RTResTalkAction[60]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		41824,
		nil,
		1,
		[19] = 41824,
		[22] = 1
	},
	[41811018] = {
		41811018,
		0,
		Lang.get(112235),
		41811,
		18,
		1296,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3
	},
	[41811019] = {
		41811019,
		0,
		Lang.get(112236),
		41811,
		19,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41811020] = {
		41811020,
		0,
		Lang.get(112237),
		41811,
		20,
		112,
		{
			RTResTalkAction[59],
			RTResTalkAction[11]
		}
	},
	[41811021] = {
		41811021,
		0,
		Lang.get(112238),
		41811,
		21,
		112,
		{
			RTResTalkAction[59]
		}
	},
	[41811022] = {
		41811022,
		0,
		Lang.get(112239),
		41811,
		22,
		112,
		{
			RTResTalkAction[59]
		}
	},
	[41811023] = {
		41811023,
		0,
		Lang.get(112240),
		41811,
		23,
		1296,
		{
			RTResTalkAction[10],
			RTResTalkAction[60]
		}
	},
	[41811024] = {
		41811024,
		0,
		Lang.get(112241),
		41811,
		24,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41811025] = {
		41811025,
		0,
		Lang.get(112242),
		41811,
		25,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41811026] = {
		41811026,
		0,
		Lang.get(112243),
		41811,
		26,
		112,
		{
			RTResTalkAction[59],
			RTResTalkAction[11]
		}
	},
	[41811027] = {
		41811027,
		0,
		Lang.get(112244),
		41811,
		27,
		1296,
		{
			RTResTalkAction[10],
			RTResTalkAction[60]
		}
	},
	[41811028] = {
		41811028,
		0,
		Lang.get(112245),
		41811,
		28,
		112,
		{
			RTResTalkAction[59],
			RTResTalkAction[11]
		}
	},
	[41811029] = {
		41811029,
		0,
		Lang.get(112246),
		41811,
		29,
		1296,
		{
			RTResTalkAction[10],
			RTResTalkAction[60]
		}
	},
	[41811030] = {
		41811030,
		0,
		Lang.get(112247),
		41811,
		30,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41811031] = {
		41811031,
		0,
		Lang.get(112248),
		41811,
		31,
		278,
		{
			RTResTalkAction[25],
			RTResTalkAction[11]
		}
	},
	[41811032] = {
		41811032,
		0,
		Lang.get(112249),
		41811,
		32,
		225,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41811033] = {
		41811033,
		0,
		Lang.get(112250),
		41811,
		33,
		112,
		{
			RTResTalkAction[59],
			RTResTalkAction[26],
			RTResTalkAction[24]
		}
	},
	[41812001] = {
		41812001,
		3,
		Lang.get(87559),
		41812,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		57,
		41825,
		nil,
		1,
		nil,
		nil,
		nil,
		41825,
		nil,
		nil,
		1
	},
	[41812002] = {
		41812002,
		0,
		Lang.get(112251),
		41812,
		2,
		257,
		{
			RTResTalkAction[34]
		},
		nil,
		nil,
		3
	},
	[41812003] = {
		41812003,
		0,
		Lang.get(112252),
		41812,
		3,
		112,
		{
			RTResTalkAction[57],
			RTResTalkAction[61]
		}
	},
	[41812004] = {
		41812004,
		0,
		Lang.get(112253),
		41812,
		4,
		112,
		{
			RTResTalkAction[57],
			RTResTalkAction[61]
		}
	},
	[41812005] = {
		41812005,
		0,
		Lang.get(112254),
		41812,
		5,
		257,
		{
			RTResTalkAction[34],
			RTResTalkAction[60]
		}
	},
	[41812006] = {
		41812006,
		0,
		Lang.get(112255),
		41812,
		6,
		677,
		{
			RTResTalkAction[57],
			RTResTalkAction[62]
		}
	},
	[41812007] = {
		41812007,
		0,
		Lang.get(112256),
		41812,
		7,
		257,
		{
			RTResTalkAction[34],
			RTResTalkAction[55]
		}
	},
	[41812008] = {
		41812008,
		0,
		Lang.get(112257),
		41812,
		8,
		1269,
		{
			RTResTalkAction[57],
			RTResTalkAction[58]
		}
	},
	[41812009] = {
		41812009,
		0,
		Lang.get(112258),
		41812,
		9,
		1269,
		{
			RTResTalkAction[40],
			RTResTalkAction[36]
		}
	},
	[41812010] = {
		41812010,
		0,
		Lang.get(112259),
		41812,
		10,
		1237,
		{
			RTResTalkAction[48],
			RTResTalkAction[58]
		}
	},
	[41812011] = {
		41812011,
		0,
		Lang.get(112260),
		41812,
		11,
		1269,
		{
			RTResTalkAction[40],
			RTResTalkAction[44]
		}
	},
	[41812012] = {
		41812012,
		0,
		Lang.get(112261),
		41812,
		12,
		1269,
		{
			RTResTalkAction[40]
		}
	},
	[41812013] = {
		41812013,
		0,
		Lang.get(112262),
		41812,
		13,
		1269,
		{
			RTResTalkAction[40]
		}
	},
	[41812014] = {
		41812014,
		0,
		Lang.get(112263),
		41812,
		14,
		257,
		{
			RTResTalkAction[34],
			RTResTalkAction[41]
		}
	},
	[41812015] = {
		41812015,
		0,
		Lang.get(112264),
		41812,
		15,
		1118,
		{
			RTResTalkAction[46],
			RTResTalkAction[36]
		}
	},
	[41812016] = {
		41812016,
		0,
		Lang.get(112265),
		41812,
		16,
		1118,
		{
			RTResTalkAction[46]
		}
	},
	[41812017] = {
		41812017,
		0,
		Lang.get(112266),
		41812,
		17,
		1233,
		{
			RTResTalkAction[50],
			RTResTalkAction[47]
		}
	},
	[41812018] = {
		41812018,
		3,
		Lang.get(112267),
		41812,
		18,
		605,
		{
			RTResTalkAction[51]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		41826,
		nil,
		1,
		[19] = 41826,
		[22] = 1
	},
	[41812019] = {
		41812019,
		0,
		Lang.get(112268),
		41812,
		19,
		257,
		{
			RTResTalkAction[34]
		},
		nil,
		nil,
		3
	},
	[41812020] = {
		41812020,
		0,
		Lang.get(112269),
		41812,
		20,
		257,
		{
			RTResTalkAction[34]
		}
	},
	[41812021] = {
		41812021,
		0,
		Lang.get(112270),
		41812,
		21,
		257,
		{
			RTResTalkAction[34]
		}
	},
	[41812022] = {
		41812022,
		0,
		Lang.get(20455),
		41812,
		22,
		1269,
		{
			RTResTalkAction[57],
			RTResTalkAction[58]
		}
	},
	[41813001] = {
		41813001,
		3,
		Lang.get(112271),
		41813,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		57,
		41827,
		nil,
		1,
		nil,
		nil,
		nil,
		41827,
		nil,
		nil,
		1
	},
	[41813002] = {
		41813002,
		0,
		Lang.get(112272),
		41813,
		2,
		287,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		3
	},
	[41813003] = {
		41813003,
		0,
		Lang.get(112273),
		41813,
		3,
		287,
		{
			RTResTalkAction[16]
		}
	},
	[41813004] = {
		41813004,
		0,
		Lang.get(112274),
		41813,
		4,
		287,
		{
			RTResTalkAction[16]
		}
	},
	[41813005] = {
		41813005,
		3,
		Lang.get(112275),
		41813,
		5,
		605,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		41828,
		nil,
		1,
		[19] = 41828,
		[22] = 1
	},
	[41813006] = {
		41813006,
		0,
		Lang.get(22477),
		41813,
		6,
		287,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		3
	},
	[41813007] = {
		41813007,
		0,
		Lang.get(112276),
		41813,
		7,
		287,
		{
			RTResTalkAction[16]
		}
	},
	[41813008] = {
		41813008,
		0,
		Lang.get(112277),
		41813,
		8,
		225,
		{
			RTResTalkAction[23],
			RTResTalkAction[17]
		}
	},
	[41813009] = {
		41813009,
		0,
		Lang.get(112278),
		41813,
		9,
		225,
		{
			RTResTalkAction[23]
		}
	},
	[41813010] = {
		41813010,
		0,
		Lang.get(112279),
		41813,
		10,
		278,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41813011] = {
		41813011,
		0,
		Lang.get(112280),
		41813,
		11,
		278,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41813012] = {
		41813012,
		0,
		Lang.get(112281),
		41813,
		12,
		287,
		{
			RTResTalkAction[16],
			RTResTalkAction[26],
			RTResTalkAction[24]
		}
	},
	[41813013] = {
		41813013,
		0,
		Lang.get(112282),
		41813,
		13,
		278,
		{
			RTResTalkAction[25],
			RTResTalkAction[17]
		}
	},
	[41813014] = {
		41813014,
		0,
		Lang.get(112283),
		41813,
		14,
		278,
		{
			RTResTalkAction[25]
		}
	},
	[41813015] = {
		41813015,
		0,
		Lang.get(112284),
		41813,
		15,
		278,
		{
			RTResTalkAction[25]
		}
	},
	[41813016] = {
		41813016,
		0,
		Lang.get(112285),
		41813,
		16,
		287,
		{
			RTResTalkAction[16],
			RTResTalkAction[26]
		}
	},
	[41813017] = {
		41813017,
		0,
		Lang.get(112286),
		41813,
		17,
		287,
		{
			RTResTalkAction[16]
		}
	},
	[41813018] = {
		41813018,
		0,
		Lang.get(112287),
		41813,
		18,
		287,
		{
			RTResTalkAction[16]
		}
	},
	[41813019] = {
		41813019,
		0,
		Lang.get(112288),
		41813,
		19,
		278,
		{
			RTResTalkAction[25],
			RTResTalkAction[17]
		}
	},
	[41813020] = {
		41813020,
		0,
		Lang.get(112289),
		41813,
		20,
		287,
		{
			RTResTalkAction[16],
			RTResTalkAction[26]
		}
	},
	[41813021] = {
		41813021,
		0,
		Lang.get(112290),
		41813,
		21,
		225,
		{
			RTResTalkAction[23],
			RTResTalkAction[17]
		}
	},
	[41813022] = {
		41813022,
		0,
		Lang.get(112291),
		41813,
		22,
		287,
		{
			RTResTalkAction[24]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		41829,
		nil,
		1,
		nil,
		nil,
		nil,
		41829
	},
	[41813023] = {
		41813023,
		0,
		Lang.get(112292),
		41813,
		23,
		287,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		3
	},
	[41813024] = {
		41813024,
		0,
		Lang.get(112293),
		41813,
		24,
		887,
		{
			RTResTalkAction[21],
			RTResTalkAction[17]
		}
	},
	[41813025] = {
		41813025,
		0,
		Lang.get(112294),
		41813,
		25,
		887,
		{
			RTResTalkAction[21]
		}
	},
	[41813026] = {
		41813026,
		0,
		Lang.get(112295),
		41813,
		26,
		887,
		{
			RTResTalkAction[21]
		}
	},
	[41814001] = {
		41814001,
		3,
		Lang.get(112296),
		41814,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		57,
		41830,
		nil,
		1,
		nil,
		nil,
		nil,
		41830,
		nil,
		nil,
		1
	},
	[41814002] = {
		41814002,
		0,
		Lang.get(112297),
		41814,
		2,
		887,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3
	},
	[41814003] = {
		41814003,
		0,
		Lang.get(112298),
		41814,
		3,
		887,
		{
			RTResTalkAction[21]
		}
	},
	[41814004] = {
		41814004,
		0,
		Lang.get(112299),
		41814,
		4,
		887,
		{
			RTResTalkAction[21]
		}
	},
	[41814005] = {
		41814005,
		3,
		Lang.get(112300),
		41814,
		5,
		605,
		{
			RTResTalkAction[22]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		41831,
		nil,
		1,
		[19] = 41831,
		[22] = 1
	},
	[41814006] = {
		41814006,
		0,
		Lang.get(112301),
		41814,
		6,
		1118,
		{
			RTResTalkAction[46]
		},
		nil,
		nil,
		3
	},
	[41814007] = {
		41814007,
		0,
		Lang.get(112302),
		41814,
		7,
		1233,
		{
			RTResTalkAction[50],
			RTResTalkAction[47]
		}
	},
	[41814008] = {
		41814008,
		0,
		Lang.get(112303),
		41814,
		8,
		677,
		{
			RTResTalkAction[54],
			RTResTalkAction[51]
		}
	},
	[41814009] = {
		41814009,
		0,
		Lang.get(112304),
		41814,
		9,
		677,
		{
			RTResTalkAction[54]
		}
	},
	[41814010] = {
		41814010,
		0,
		Lang.get(112305),
		41814,
		10,
		887,
		{
			RTResTalkAction[21],
			RTResTalkAction[55]
		}
	},
	[41814011] = {
		41814011,
		0,
		Lang.get(112306),
		41814,
		11,
		1118,
		{
			RTResTalkAction[46],
			RTResTalkAction[22]
		}
	},
	[41814012] = {
		41814012,
		0,
		Lang.get(88725),
		41814,
		12,
		1233,
		{
			RTResTalkAction[50],
			RTResTalkAction[47]
		}
	},
	[41814013] = {
		41814013,
		0,
		Lang.get(112307),
		41814,
		13,
		887,
		{
			RTResTalkAction[21],
			RTResTalkAction[51]
		}
	},
	[41814014] = {
		41814014,
		0,
		Lang.get(112308),
		41814,
		14,
		677,
		{
			RTResTalkAction[54],
			RTResTalkAction[22]
		}
	},
	[41814015] = {
		41814015,
		3,
		Lang.get(100843),
		41814,
		15,
		605,
		{
			RTResTalkAction[55]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		41832,
		nil,
		1,
		[19] = 41832,
		[22] = 1
	},
	[41814016] = {
		41814016,
		0,
		Lang.get(112309),
		41814,
		16,
		1118,
		{
			RTResTalkAction[46]
		},
		nil,
		nil,
		3
	},
	[41814017] = {
		41814017,
		0,
		Lang.get(112310),
		41814,
		17,
		1233,
		{
			RTResTalkAction[50],
			RTResTalkAction[47]
		}
	},
	[41814018] = {
		41814018,
		0,
		Lang.get(112311),
		41814,
		18,
		887,
		{
			RTResTalkAction[21],
			RTResTalkAction[51]
		}
	},
	[41814019] = {
		41814019,
		3,
		Lang.get(112312),
		41814,
		19,
		605,
		{
			RTResTalkAction[22]
		},
		[22] = 1
	},
	[41814020] = {
		41814020,
		0,
		Lang.get(112313),
		41814,
		20,
		1118,
		{
			RTResTalkAction[46]
		}
	},
	[41814021] = {
		41814021,
		0,
		Lang.get(112314),
		41814,
		21,
		887,
		{
			RTResTalkAction[21],
			RTResTalkAction[47]
		}
	},
	[41814022] = {
		41814022,
		0,
		Lang.get(112315),
		41814,
		22,
		887,
		{
			RTResTalkAction[22]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		41833,
		nil,
		1,
		nil,
		nil,
		nil,
		41833
	},
	[41814023] = {
		41814023,
		0,
		Lang.get(112316),
		41814,
		23,
		1118,
		{
			RTResTalkAction[46]
		},
		nil,
		nil,
		3
	},
	[41814024] = {
		41814024,
		0,
		Lang.get(112317),
		41814,
		24,
		677,
		{
			RTResTalkAction[56],
			RTResTalkAction[62]
		}
	},
	[41814025] = {
		41814025,
		3,
		Lang.get(112318),
		41814,
		25,
		605,
		{
			RTResTalkAction[47],
			RTResTalkAction[55]
		},
		[22] = 1
	},
	[41814026] = {
		41814026,
		0,
		Lang.get(112319),
		41814,
		26,
		1118,
		{
			RTResTalkAction[46]
		},
		nil,
		nil,
		3
	},
	[41814027] = {
		41814027,
		0,
		Lang.get(112320),
		41814,
		27,
		1233,
		{
			RTResTalkAction[50],
			RTResTalkAction[47]
		}
	},
	[41814028] = {
		41814028,
		0,
		Lang.get(112321),
		41814,
		28,
		1118,
		{
			RTResTalkAction[51]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		41834,
		nil,
		1,
		nil,
		nil,
		nil,
		41834
	},
	[41814029] = {
		41814029,
		0,
		Lang.get(112322),
		41814,
		29,
		1118,
		{
			RTResTalkAction[46]
		},
		nil,
		nil,
		3
	},
	[41814030] = {
		41814030,
		0,
		Lang.get(112323),
		41814,
		30,
		677,
		{
			RTResTalkAction[56],
			RTResTalkAction[62]
		}
	},
	[41815001] = {
		41815001,
		3,
		Lang.get(112324),
		41815,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		57,
		41835,
		nil,
		1,
		nil,
		nil,
		nil,
		41835,
		nil,
		nil,
		1
	},
	[41815002] = {
		41815002,
		0,
		Lang.get(112325),
		41815,
		2,
		1296,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3
	},
	[41815003] = {
		41815003,
		0,
		Lang.get(112326),
		41815,
		3,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41815004] = {
		41815004,
		0,
		Lang.get(112327),
		41815,
		4,
		887,
		{
			RTResTalkAction[21],
			RTResTalkAction[11]
		}
	},
	[41815005] = {
		41815005,
		0,
		Lang.get(112328),
		41815,
		5,
		887,
		{
			RTResTalkAction[21]
		}
	},
	[41815006] = {
		41815006,
		0,
		Lang.get(112329),
		41815,
		6,
		1296,
		{
			RTResTalkAction[10],
			RTResTalkAction[22]
		}
	},
	[41815007] = {
		41815007,
		0,
		Lang.get(112330),
		41815,
		7,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41815008] = {
		41815008,
		0,
		Lang.get(112331),
		41815,
		8,
		887,
		{
			RTResTalkAction[21],
			RTResTalkAction[11]
		}
	},
	[41815009] = {
		41815009,
		3,
		Lang.get(112332),
		41815,
		9,
		605,
		{
			RTResTalkAction[22]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		41890,
		nil,
		1,
		[19] = 41890,
		[22] = 1
	},
	[41815010] = {
		41815010,
		0,
		Lang.get(112333),
		41815,
		10,
		677,
		{
			RTResTalkAction[54]
		},
		nil,
		nil,
		3
	},
	[41815011] = {
		41815011,
		0,
		Lang.get(112334),
		41815,
		11,
		677,
		{
			RTResTalkAction[54]
		}
	},
	[41815012] = {
		41815012,
		0,
		Lang.get(112335),
		41815,
		12,
		1118,
		{
			RTResTalkAction[56],
			RTResTalkAction[62]
		}
	},
	[41815013] = {
		41815013,
		0,
		Lang.get(112336),
		41815,
		13,
		1233,
		{
			RTResTalkAction[50],
			RTResTalkAction[47],
			RTResTalkAction[55]
		}
	},
	[41815014] = {
		41815014,
		0,
		Lang.get(112337),
		41815,
		14,
		1233,
		{
			RTResTalkAction[50]
		}
	},
	[41815015] = {
		41815015,
		0,
		Lang.get(112338),
		41815,
		15,
		225,
		{
			RTResTalkAction[51]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		41891,
		nil,
		1,
		nil,
		nil,
		nil,
		41891
	},
	[41815016] = {
		41815016,
		0,
		Lang.get(112339),
		41815,
		16,
		225,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[41815017] = {
		41815017,
		0,
		Lang.get(112340),
		41815,
		17,
		278,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41815018] = {
		41815018,
		0,
		Lang.get(112341),
		41815,
		18,
		677,
		{
			RTResTalkAction[54],
			RTResTalkAction[26],
			RTResTalkAction[24]
		}
	},
	[41815019] = {
		41815019,
		0,
		Lang.get(112342),
		41815,
		19,
		278,
		{
			RTResTalkAction[63],
			RTResTalkAction[64]
		}
	},
	[41815020] = {
		41815020,
		0,
		Lang.get(112343),
		41815,
		20,
		1118,
		{
			RTResTalkAction[46],
			RTResTalkAction[55],
			RTResTalkAction[26]
		}
	},
	[41815021] = {
		41815021,
		0,
		Lang.get(112344),
		41815,
		21,
		677,
		{
			RTResTalkAction[56],
			RTResTalkAction[62]
		}
	},
	[41815022] = {
		41815022,
		0,
		Lang.get(112345),
		41815,
		22,
		225,
		{
			RTResTalkAction[23],
			RTResTalkAction[47],
			RTResTalkAction[55]
		}
	},
	[41816001] = {
		41816001,
		3,
		Lang.get(112346),
		41816,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		57,
		41836,
		nil,
		1,
		nil,
		nil,
		nil,
		41836,
		nil,
		nil,
		1
	},
	[41816002] = {
		41816002,
		0,
		Lang.get(112347),
		41816,
		2,
		225,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[41816003] = {
		41816003,
		0,
		Lang.get(112348),
		41816,
		3,
		225,
		{
			RTResTalkAction[23]
		}
	},
	[41816004] = {
		41816004,
		0,
		Lang.get(112349),
		41816,
		4,
		278,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41816005] = {
		41816005,
		0,
		Lang.get(112350),
		41816,
		5,
		225,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41816006] = {
		41816006,
		0,
		Lang.get(112351),
		41816,
		6,
		278,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41816007] = {
		41816007,
		0,
		Lang.get(112352),
		41816,
		7,
		1118,
		{
			RTResTalkAction[46],
			RTResTalkAction[26],
			RTResTalkAction[24]
		}
	},
	[41816008] = {
		41816008,
		0,
		Lang.get(112353),
		41816,
		8,
		677,
		{
			RTResTalkAction[56],
			RTResTalkAction[62]
		}
	},
	[41816009] = {
		41816009,
		0,
		Lang.get(112354),
		41816,
		9,
		278,
		{
			RTResTalkAction[25],
			RTResTalkAction[47],
			RTResTalkAction[55]
		}
	},
	[41816010] = {
		41816010,
		0,
		Lang.get(112355),
		41816,
		10,
		278,
		{
			RTResTalkAction[26]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		41837,
		nil,
		1,
		nil,
		nil,
		nil,
		41837
	},
	[41816011] = {
		41816011,
		0,
		Lang.get(112356),
		41816,
		11,
		278,
		{
			RTResTalkAction[25]
		},
		nil,
		nil,
		3
	},
	[41816012] = {
		41816012,
		0,
		Lang.get(112357),
		41816,
		12,
		225,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41816013] = {
		41816013,
		0,
		Lang.get(112358),
		41816,
		13,
		278,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41816014] = {
		41816014,
		0,
		Lang.get(112359),
		41816,
		14,
		278,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41816015] = {
		41816015,
		0,
		Lang.get(112360),
		41816,
		15,
		225,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41816016] = {
		41816016,
		0,
		Lang.get(112361),
		41816,
		16,
		278,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41816017] = {
		41816017,
		0,
		Lang.get(112362),
		41816,
		17,
		225,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41817001] = {
		41817001,
		3,
		Lang.get(100843),
		41817,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		41838,
		nil,
		1,
		nil,
		nil,
		nil,
		41838,
		nil,
		nil,
		1
	},
	[41817002] = {
		41817002,
		0,
		Lang.get(112363),
		41817,
		2,
		225,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[41817003] = {
		41817003,
		0,
		Lang.get(112364),
		41817,
		3,
		278,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41817004] = {
		41817004,
		0,
		Lang.get(112365),
		41817,
		4,
		278,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41817005] = {
		41817005,
		0,
		Lang.get(112366),
		41817,
		5,
		225,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41817006] = {
		41817006,
		0,
		Lang.get(112367),
		41817,
		6,
		1118,
		{
			RTResTalkAction[46],
			RTResTalkAction[26],
			RTResTalkAction[24]
		}
	},
	[41817007] = {
		41817007,
		0,
		Lang.get(112368),
		41817,
		7,
		278,
		{
			RTResTalkAction[25],
			RTResTalkAction[47]
		}
	},
	[41817008] = {
		41817008,
		0,
		Lang.get(112369),
		41817,
		8,
		225,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[41818001] = {
		41818001,
		3,
		Lang.get(112370),
		41818,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		57,
		41839,
		nil,
		1,
		nil,
		nil,
		nil,
		41839,
		nil,
		nil,
		1
	},
	[41818002] = {
		41818002,
		0,
		Lang.get(112371),
		41818,
		2,
		1296,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3
	},
	[41818003] = {
		41818003,
		0,
		Lang.get(112372),
		41818,
		3,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41818004] = {
		41818004,
		0,
		Lang.get(112373),
		41818,
		4,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41818005] = {
		41818005,
		0,
		Lang.get(112374),
		41818,
		5,
		887,
		{
			RTResTalkAction[21],
			RTResTalkAction[11]
		}
	},
	[41818006] = {
		41818006,
		0,
		Lang.get(112375),
		41818,
		6,
		887,
		{
			RTResTalkAction[21]
		}
	},
	[41818007] = {
		41818007,
		0,
		Lang.get(112376),
		41818,
		7,
		1296,
		{
			RTResTalkAction[10],
			RTResTalkAction[22]
		}
	},
	[41818008] = {
		41818008,
		0,
		Lang.get(112377),
		41818,
		8,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41818009] = {
		41818009,
		0,
		Lang.get(112378),
		41818,
		9,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41818010] = {
		41818010,
		0,
		Lang.get(112379),
		41818,
		10,
		887,
		{
			RTResTalkAction[21],
			RTResTalkAction[11]
		}
	},
	[41818011] = {
		41818011,
		3,
		Lang.get(112380),
		41818,
		11,
		605,
		{
			RTResTalkAction[22]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		41840,
		nil,
		1,
		[19] = 41840,
		[22] = 1
	},
	[41818012] = {
		41818012,
		0,
		Lang.get(112381),
		41818,
		12,
		1296,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3
	},
	[41818013] = {
		41818013,
		0,
		Lang.get(112382),
		41818,
		13,
		887,
		{
			RTResTalkAction[21],
			RTResTalkAction[11]
		}
	},
	[41818014] = {
		41818014,
		0,
		Lang.get(112383),
		41818,
		14,
		1296,
		{
			RTResTalkAction[10],
			RTResTalkAction[22]
		}
	},
	[41818015] = {
		41818015,
		3,
		Lang.get(112384),
		41818,
		15,
		605,
		{
			RTResTalkAction[11]
		},
		[22] = 1
	},
	[41818016] = {
		41818016,
		0,
		Lang.get(112385),
		41818,
		16,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41818017] = {
		41818017,
		3,
		Lang.get(112386),
		41818,
		17,
		605,
		{
			RTResTalkAction[11]
		},
		[22] = 1
	},
	[41818018] = {
		41818018,
		3,
		Lang.get(112387),
		41818,
		18,
		605,
		[22] = 1
	},
	[41818019] = {
		41818019,
		0,
		Lang.get(112388),
		41818,
		19,
		887,
		{
			RTResTalkAction[21]
		}
	},
	[41818020] = {
		41818020,
		0,
		Lang.get(112389),
		41818,
		20,
		1296,
		{
			RTResTalkAction[10],
			RTResTalkAction[22]
		}
	},
	[41818021] = {
		41818021,
		0,
		Lang.get(112390),
		41818,
		21,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41818022] = {
		41818022,
		0,
		Lang.get(112391),
		41818,
		22,
		887,
		{
			RTResTalkAction[21],
			RTResTalkAction[11]
		}
	},
	[41818023] = {
		41818023,
		0,
		Lang.get(112392),
		41818,
		23,
		887,
		{
			RTResTalkAction[21]
		}
	},
	[41818024] = {
		41818024,
		0,
		Lang.get(112393),
		41818,
		24,
		1296,
		{
			RTResTalkAction[10],
			RTResTalkAction[22]
		}
	},
	[41818025] = {
		41818025,
		0,
		Lang.get(112394),
		41818,
		25,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41818026] = {
		41818026,
		0,
		Lang.get(112395),
		41818,
		26,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41819001] = {
		41819001,
		3,
		Lang.get(112396),
		41819,
		1,
		1296,
		nil,
		1,
		nil,
		nil,
		nil,
		57,
		41841,
		nil,
		1,
		nil,
		nil,
		nil,
		41841,
		nil,
		nil,
		1
	},
	[41819002] = {
		41819002,
		0,
		Lang.get(112397),
		41819,
		2,
		1296,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3
	},
	[41819003] = {
		41819003,
		0,
		Lang.get(112398),
		41819,
		3,
		887,
		{
			RTResTalkAction[21],
			RTResTalkAction[11]
		}
	},
	[41819004] = {
		41819004,
		0,
		Lang.get(112399),
		41819,
		4,
		1296,
		{
			RTResTalkAction[10],
			RTResTalkAction[22]
		}
	},
	[41819005] = {
		41819005,
		0,
		Lang.get(112400),
		41819,
		5,
		887,
		{
			RTResTalkAction[21],
			RTResTalkAction[11]
		}
	},
	[41819006] = {
		41819006,
		0,
		Lang.get(112401),
		41819,
		6,
		1296,
		{
			RTResTalkAction[10],
			RTResTalkAction[22]
		}
	},
	[41819007] = {
		41819007,
		0,
		Lang.get(112402),
		41819,
		7,
		1269,
		{
			RTResTalkAction[11]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		41847,
		nil,
		1,
		nil,
		nil,
		nil,
		41847
	},
	[41819008] = {
		41819008,
		0,
		Lang.get(112403),
		41819,
		8,
		1269,
		{
			RTResTalkAction[40]
		},
		nil,
		nil,
		3
	},
	[41819009] = {
		41819009,
		0,
		Lang.get(112404),
		41819,
		9,
		1269,
		{
			RTResTalkAction[40]
		}
	},
	[41819010] = {
		41819010,
		0,
		Lang.get(112405),
		41819,
		10,
		1269,
		{
			RTResTalkAction[40]
		}
	},
	[41819011] = {
		41819011,
		0,
		Lang.get(112406),
		41819,
		11,
		1296,
		{
			RTResTalkAction[65],
			RTResTalkAction[58]
		}
	},
	[41819012] = {
		41819012,
		0,
		Lang.get(112407),
		41819,
		12,
		1269,
		{
			RTResTalkAction[65],
			RTResTalkAction[58]
		}
	},
	[41819013] = {
		41819013,
		0,
		Lang.get(112408),
		41819,
		13,
		1296,
		{
			RTResTalkAction[65],
			RTResTalkAction[58]
		}
	},
	[41820001] = {
		41820001,
		0,
		Lang.get(112409),
		41820,
		1,
		887,
		nil,
		1,
		nil,
		nil,
		nil,
		59,
		41842,
		nil,
		1,
		nil,
		nil,
		nil,
		41842
	},
	[41820002] = {
		41820002,
		0,
		Lang.get(112410),
		41820,
		2,
		887,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3
	},
	[41820003] = {
		41820003,
		0,
		Lang.get(112411),
		41820,
		3,
		1296,
		{
			RTResTalkAction[10],
			RTResTalkAction[22]
		}
	},
	[41820004] = {
		41820004,
		0,
		Lang.get(112412),
		41820,
		4,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41820005] = {
		41820005,
		0,
		Lang.get(112413),
		41820,
		5,
		887,
		{
			RTResTalkAction[21],
			RTResTalkAction[11]
		}
	},
	[41820006] = {
		41820006,
		0,
		Lang.get(112414),
		41820,
		6,
		893,
		{
			RTResTalkAction[35],
			RTResTalkAction[22]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		41848,
		nil,
		1,
		[19] = 41848,
		[27] = 2
	},
	[41820007] = {
		41820007,
		4,
		nil,
		41820,
		7,
		893,
		{
			RTResTalkAction[66],
			RTResTalkAction[38]
		},
		nil,
		nil,
		3,
		[27] = 3,
		[29] = {
			{
				id = 41820008,
				branch_content = Lang.get(112415)
			},
			{
				id = 41820008,
				branch_content = Lang.get(112416)
			}
		}
	},
	[41820008] = {
		41820008,
		0,
		Lang.get(112417),
		41820,
		8,
		893,
		{
			RTResTalkAction[66]
		},
		[27] = 3
	},
	[41820009] = {
		41820009,
		4,
		nil,
		41820,
		9,
		1296,
		{
			RTResTalkAction[66]
		},
		[27] = 3,
		[29] = {
			{
				id = 41820010,
				branch_content = Lang.get(112418)
			}
		}
	},
	[41820010] = {
		41820010,
		0,
		Lang.get(112419),
		41820,
		10,
		893,
		{
			RTResTalkAction[66]
		},
		[27] = 3
	},
	[41820011] = {
		41820011,
		0,
		Lang.get(112420),
		41820,
		11,
		887,
		{
			RTResTalkAction[67]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		41843,
		nil,
		1,
		nil,
		nil,
		nil,
		41843
	},
	[41820012] = {
		41820012,
		0,
		Lang.get(112421),
		41820,
		12,
		1296,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3
	},
	[41820013] = {
		41820013,
		0,
		Lang.get(112422),
		41820,
		13,
		887,
		{
			RTResTalkAction[21],
			RTResTalkAction[11]
		}
	},
	[41820014] = {
		41820014,
		0,
		Lang.get(112423),
		41820,
		14,
		287,
		{
			RTResTalkAction[16],
			RTResTalkAction[22]
		}
	},
	[41820015] = {
		41820015,
		0,
		Lang.get(112424),
		41820,
		15,
		1296,
		{
			RTResTalkAction[10],
			RTResTalkAction[17]
		}
	},
	[41820016] = {
		41820016,
		0,
		Lang.get(112425),
		41820,
		16,
		887,
		{
			RTResTalkAction[21],
			RTResTalkAction[11]
		}
	},
	[41820017] = {
		41820017,
		0,
		Lang.get(112426),
		41820,
		17,
		605,
		{
			RTResTalkAction[22]
		}
	},
	[41820018] = {
		41820018,
		0,
		Lang.get(112427),
		41820,
		18,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41820019] = {
		41820019,
		0,
		Lang.get(112428),
		41820,
		19,
		287,
		{
			RTResTalkAction[16],
			RTResTalkAction[11]
		}
	},
	[41820020] = {
		41820020,
		3,
		Lang.get(112429),
		41820,
		20,
		605,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		41844,
		nil,
		1,
		[19] = 41844,
		[22] = 1
	},
	[41820021] = {
		41820021,
		0,
		Lang.get(112430),
		41820,
		21,
		1296,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3
	},
	[41821001] = {
		41821001,
		3,
		Lang.get(112431),
		41821,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		41,
		nil,
		nil,
		1,
		[19] = 41845,
		[22] = 1
	},
	[41821002] = {
		41821002,
		0,
		Lang.get(112432),
		41821,
		2,
		1296,
		nil,
		1
	},
	[41821003] = {
		41821003,
		0,
		Lang.get(112433),
		41821,
		3,
		1296,
		nil,
		1
	},
	[41821004] = {
		41821004,
		0,
		Lang.get(112434),
		41821,
		4,
		1296,
		nil,
		1
	},
	[41821005] = {
		41821005,
		0,
		Lang.get(112435),
		41821,
		5,
		287,
		nil,
		1
	},
	[41821006] = {
		41821006,
		4,
		nil,
		41821,
		6,
		287,
		nil,
		1,
		[29] = {
			{
				id = 41821007,
				branch_content = Lang.get(112436)
			},
			{
				id = 41821007,
				branch_content = Lang.get(112437)
			}
		}
	},
	[41821007] = {
		41821007,
		0,
		Lang.get(112438),
		41821,
		7,
		287,
		nil,
		1
	},
	[41821008] = {
		41821008,
		0,
		Lang.get(112439),
		41821,
		8,
		1296,
		nil,
		1
	},
	[41821009] = {
		41821009,
		0,
		"……",
		41821,
		9,
		287,
		nil,
		1
	},
	[41821010] = {
		41821010,
		0,
		Lang.get(112440),
		41821,
		10,
		287,
		nil,
		1
	},
	[41821011] = {
		41821011,
		0,
		"…………",
		41821,
		11,
		1296,
		nil,
		1
	},
	[41821012] = {
		41821012,
		0,
		Lang.get(112441),
		41821,
		12,
		1296,
		nil,
		1
	},
	[41821013] = {
		41821013,
		0,
		Lang.get(112442),
		41821,
		13,
		1296,
		nil,
		1
	},
	[41821014] = {
		41821014,
		0,
		Lang.get(112443),
		41821,
		14,
		287,
		nil,
		1
	},
	[41821015] = {
		41821015,
		0,
		Lang.get(112444),
		41821,
		15,
		1296,
		nil,
		1
	},
	[41821016] = {
		41821016,
		0,
		Lang.get(112445),
		41821,
		16,
		1296,
		nil,
		1
	},
	[41821017] = {
		41821017,
		0,
		Lang.get(112446),
		41821,
		17,
		1296,
		nil,
		1
	},
	[41821018] = {
		41821018,
		0,
		Lang.get(112447),
		41821,
		18,
		1296,
		nil,
		1
	},
	[41821019] = {
		41821019,
		4,
		nil,
		41821,
		19,
		1296,
		nil,
		1,
		[29] = {
			{
				id = 41821020,
				branch_content = Lang.get(112448)
			},
			{
				id = 41821020,
				branch_content = Lang.get(112449)
			}
		}
	},
	[41821020] = {
		41821020,
		0,
		Lang.get(112450),
		41821,
		20,
		287,
		nil,
		1
	},
	[41821021] = {
		41821021,
		0,
		Lang.get(112451),
		41821,
		21,
		1296,
		nil,
		1
	},
	[41821022] = {
		41821022,
		3,
		Lang.get(112452),
		41821,
		22,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		194,
		41846,
		nil,
		1,
		nil,
		nil,
		nil,
		41846,
		nil,
		nil,
		1
	},
	[41821023] = {
		41821023,
		0,
		Lang.get(112453),
		41821,
		23,
		1296,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3
	},
	[41821024] = {
		41821024,
		0,
		Lang.get(112454),
		41821,
		24,
		1296,
		{
			RTResTalkAction[10]
		}
	},
	[41821025] = {
		41821025,
		0,
		Lang.get(112455),
		41821,
		25,
		257,
		{
			RTResTalkAction[57],
			RTResTalkAction[68]
		}
	},
	[41821026] = {
		41821026,
		0,
		Lang.get(112611),
		41821,
		26,
		257,
		{
			RTResTalkAction[57],
			RTResTalkAction[68]
		}
	},
	[41821027] = {
		41821027,
		0,
		Lang.get(112457),
		41821,
		27,
		257,
		{
			RTResTalkAction[57],
			RTResTalkAction[68]
		}
	},
	[41821028] = {
		41821028,
		0,
		Lang.get(112458),
		41821,
		28,
		257,
		{
			RTResTalkAction[57],
			RTResTalkAction[68]
		}
	},
	[41821029] = {
		41821029,
		0,
		Lang.get(112459),
		41821,
		29,
		1296,
		{
			RTResTalkAction[57],
			RTResTalkAction[68]
		}
	},
	[41821030] = {
		41821030,
		0,
		Lang.get(112460),
		41821,
		30,
		1296,
		{
			RTResTalkAction[57],
			RTResTalkAction[68]
		}
	},
	[41821031] = {
		41821031,
		0,
		Lang.get(112461),
		41821,
		31,
		1296,
		{
			RTResTalkAction[57],
			RTResTalkAction[68]
		}
	},
	[41821032] = {
		41821032,
		0,
		Lang.get(112462),
		41821,
		32,
		257,
		{
			RTResTalkAction[57],
			RTResTalkAction[68]
		}
	},
	[41821033] = {
		41821033,
		0,
		Lang.get(112463),
		41821,
		33,
		257,
		{
			RTResTalkAction[57],
			RTResTalkAction[68]
		}
	},
	[41821034] = {
		41821034,
		0,
		Lang.get(112464),
		41821,
		34,
		1296,
		{
			RTResTalkAction[57],
			RTResTalkAction[68]
		}
	},
	[41821035] = {
		41821035,
		0,
		Lang.get(112465),
		41821,
		35,
		257,
		{
			RTResTalkAction[57],
			RTResTalkAction[68]
		}
	},
	[41821036] = {
		41821036,
		3,
		Lang.get(112466),
		41821,
		36,
		605,
		{
			RTResTalkAction[36],
			RTResTalkAction[11]
		},
		nil,
		nil,
		nil,
		nil,
		57,
		nil,
		nil,
		1,
		nil,
		nil,
		nil,
		41888,
		255,
		nil,
		1
	},
	[41821037] = {
		41821037,
		0,
		Lang.get(112467),
		41821,
		37,
		287,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		3
	},
	[41821038] = {
		41821038,
		0,
		Lang.get(112468),
		41821,
		38,
		887,
		{
			RTResTalkAction[21],
			RTResTalkAction[17]
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
