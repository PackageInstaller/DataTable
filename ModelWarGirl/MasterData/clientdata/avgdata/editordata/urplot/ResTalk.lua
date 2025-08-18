-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\URplot\\ResTalk.lua

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
	[2] = 107,
	[3] = {
		3
	}
}
RTResTalkAction[2] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[3] = {
	1,
	107,
	nil,
	nil,
	2
}
RTResTalkAction[4] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[5] = {
	3,
	244,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[6] = {
	[1] = 3,
	[2] = 244
}
RTResTalkAction[7] = {
	2,
	107,
	{
		1
	},
	nil,
	5
}
RTResTalkAction[8] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[9] = {
	[1] = 0,
	[2] = 244
}
RTResTalkAction[10] = {
	1,
	107,
	nil,
	nil,
	3
}
RTResTalkAction[11] = {
	3,
	244,
	nil,
	nil,
	2
}
RTResTalkAction[12] = {
	3,
	244,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[13] = {
	1,
	107,
	nil,
	nil,
	4
}
RTResTalkAction[14] = {
	3,
	244,
	nil,
	nil,
	0
}
RTResTalkAction[15] = {
	2,
	107,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[16] = {
	[1] = 1,
	[2] = 1067
}
RTResTalkAction[17] = {
	[1] = 0,
	[2] = 1067
}
RTResTalkAction[18] = {
	[1] = 1,
	[2] = 1307,
	[3] = {
		1
	}
}
RTResTalkAction[19] = {
	[1] = 1,
	[2] = 1122
}
RTResTalkAction[20] = {
	[1] = 0,
	[2] = 1307
}
RTResTalkAction[21] = {
	[1] = 2,
	[2] = 1122
}
RTResTalkAction[22] = {
	[1] = 3,
	[2] = 1142
}
RTResTalkAction[23] = {
	[1] = 1,
	[2] = 1307,
	[3] = {
		2
	}
}
RTResTalkAction[24] = {
	[1] = 0,
	[2] = 1122
}
RTResTalkAction[25] = {
	[1] = 0,
	[2] = 1142
}
RTResTalkAction[26] = {
	2,
	1122,
	nil,
	nil,
	1
}
RTResTalkAction[27] = {
	1,
	1307,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[28] = {
	[1] = 2,
	[2] = 386,
	[3] = {
		1
	}
}
RTResTalkAction[29] = {
	[1] = 3,
	[2] = 1307
}
RTResTalkAction[30] = {
	[1] = 2,
	[2] = 386,
	[3] = {
		2
	}
}
RTResTalkAction[31] = {
	[1] = 0,
	[2] = 386
}
RTResTalkAction[32] = {
	[1] = 1,
	[2] = 1307
}
RTResTalkAction[33] = {
	[1] = 2,
	[2] = 1307
}
RTResTalkAction[34] = {
	[1] = 3,
	[2] = 1056
}
RTResTalkAction[35] = {
	[1] = 3,
	[2] = 1058
}
RTResTalkAction[36] = {
	[1] = 0,
	[2] = 1056
}
RTResTalkAction[37] = {
	[1] = 0,
	[2] = 1058
}
RTResTalkAction[38] = {
	[1] = 2,
	[2] = 1307,
	[3] = {
		3
	}
}
RTResTalkAction[39] = {
	[1] = 1,
	[2] = 292,
	[3] = {
		3
	}
}
RTResTalkAction[40] = {
	[1] = 2,
	[2] = 1307,
	[3] = {
		1
	}
}
RTResTalkAction[41] = {
	[1] = 3,
	[2] = 292
}
RTResTalkAction[42] = {
	[1] = 0,
	[2] = 292
}
RTResTalkAction[43] = {
	[1] = 1,
	[2] = 292
}
RTResTalkAction[44] = {
	[1] = 2,
	[2] = 292
}
RTResTalkAction[45] = {
	[1] = 2,
	[2] = 292,
	[3] = {
		2
	}
}
RTResTalkAction[46] = {
	[1] = 1,
	[2] = 1048,
	[3] = {
		2
	}
}
RTResTalkAction[47] = {
	[1] = 1,
	[2] = 1048
}
RTResTalkAction[48] = {
	[1] = 0,
	[2] = 1048
}
RTResTalkAction[49] = {
	2,
	1048,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[50] = {
	[1] = 4,
	[2] = 1048
}
RTResTalkAction[51] = {
	[1] = 5,
	[2] = 1307
}
RTResTalkAction[52] = {
	2,
	292,
	nil,
	nil,
	0
}
RTResTalkAction[53] = {
	[1] = 3,
	[2] = 1307,
	[3] = {
		2
	}
}
RTResTalkAction[54] = {
	3,
	1048,
	nil,
	nil,
	4
}
RTResTalkAction[55] = {
	[1] = 3,
	[2] = 1048
}
RTResTalkAction[56] = {
	3,
	1048,
	{
		3
	},
	nil,
	3
}
RTResTalkAction[57] = {
	2,
	292,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[58] = {
	2,
	1048,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[59] = {
	[1] = 2,
	[2] = 1048
}

local Data = {
	[43400001] = {
		43400001,
		3,
		Lang.get(118169),
		43400,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		43400,
		[19] = 43400,
		[22] = 1
	},
	[43400002] = {
		43400002,
		0,
		Lang.get(118170),
		43400,
		2,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[43400003] = {
		43400003,
		4,
		nil,
		43400,
		3,
		300,
		{
			RTResTalkAction[2]
		},
		[29] = {
			{
				id = 43400004,
				branch_content = Lang.get(64783)
			},
			{
				id = 43400004,
				branch_content = Lang.get(118171)
			}
		}
	},
	[43400004] = {
		43400004,
		0,
		Lang.get(118172),
		43400,
		4,
		107,
		{
			RTResTalkAction[3]
		}
	},
	[43400005] = {
		43400005,
		0,
		Lang.get(118173),
		43400,
		5,
		244,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[43400006] = {
		43400006,
		0,
		Lang.get(118174),
		43400,
		6,
		244,
		{
			RTResTalkAction[4],
			RTResTalkAction[6]
		}
	},
	[43400007] = {
		43400007,
		4,
		nil,
		43400,
		7,
		300,
		{
			RTResTalkAction[4],
			RTResTalkAction[6]
		},
		[29] = {
			{
				id = 43400008,
				branch_content = Lang.get(118175)
			},
			{
				id = 43400008,
				branch_content = Lang.get(118115)
			}
		}
	},
	[43400008] = {
		43400008,
		0,
		Lang.get(118176),
		43400,
		8,
		107,
		{
			RTResTalkAction[7],
			RTResTalkAction[6]
		}
	},
	[43400009] = {
		43400009,
		3,
		Lang.get(118177),
		43400,
		9,
		605,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		43401,
		nil,
		1,
		nil,
		1,
		nil,
		43401,
		nil,
		nil,
		1
	},
	[43400010] = {
		43400010,
		3,
		Lang.get(118178),
		43400,
		10,
		605,
		[22] = 1
	},
	[43400011] = {
		43400011,
		0,
		Lang.get(118179),
		43400,
		11,
		244,
		nil,
		1,
		0,
		nil,
		nil,
		63
	},
	[43400012] = {
		43400012,
		0,
		Lang.get(118180),
		43400,
		12,
		107,
		nil,
		1,
		3
	},
	[43400013] = {
		43400013,
		0,
		Lang.get(118181),
		43400,
		13,
		929,
		[22] = 1
	},
	[43400014] = {
		43400014,
		0,
		Lang.get(118182),
		43400,
		14,
		924,
		nil,
		1,
		0
	},
	[43400015] = {
		43400015,
		0,
		Lang.get(118183),
		43400,
		15,
		929
	},
	[43400016] = {
		43400016,
		0,
		Lang.get(118184),
		43400,
		16,
		924,
		nil,
		1,
		0
	},
	[43400017] = {
		43400017,
		0,
		Lang.get(118185),
		43400,
		17,
		930
	},
	[43400018] = {
		43400018,
		0,
		Lang.get(118186),
		43400,
		18,
		930
	},
	[43400019] = {
		43400019,
		0,
		Lang.get(118187),
		43400,
		19,
		929
	},
	[43400020] = {
		43400020,
		0,
		Lang.get(118188),
		43400,
		20,
		931,
		nil,
		1,
		0
	},
	[43400021] = {
		43400021,
		0,
		Lang.get(118189),
		43400,
		21,
		107,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		43402,
		[19] = 43402,
		[17] = 1
	},
	[43400022] = {
		43400022,
		0,
		Lang.get(118190),
		43400,
		22,
		244,
		{
			RTResTalkAction[4],
			RTResTalkAction[11]
		}
	},
	[43400023] = {
		43400023,
		4,
		nil,
		43400,
		23,
		300,
		{
			RTResTalkAction[4],
			RTResTalkAction[6]
		},
		[29] = {
			{
				id = 43400024,
				branch_content = Lang.get(118191)
			}
		}
	},
	[43400024] = {
		43400024,
		0,
		"|101|？",
		43400,
		24,
		244,
		{
			RTResTalkAction[4],
			RTResTalkAction[12]
		}
	},
	[43400025] = {
		43400025,
		0,
		Lang.get(118192),
		43400,
		25,
		928,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		},
		1,
		0,
		-1,
		nil,
		nil,
		43403,
		nil,
		nil,
		nil,
		1,
		nil,
		43403
	},
	[43400026] = {
		43400026,
		0,
		Lang.get(118193),
		43400,
		26,
		928,
		nil,
		1,
		0
	},
	[43400027] = {
		43400027,
		3,
		Lang.get(118194),
		43400,
		27,
		605,
		[22] = 1
	},
	[43400028] = {
		43400028,
		0,
		Lang.get(118195),
		43400,
		28,
		929
	},
	[43400029] = {
		43400029,
		0,
		Lang.get(118196),
		43400,
		29,
		930
	},
	[43400030] = {
		43400030,
		0,
		Lang.get(118197),
		43400,
		30,
		928,
		nil,
		1
	},
	[43400031] = {
		43400031,
		0,
		Lang.get(118198),
		43400,
		31,
		300
	},
	[43400032] = {
		43400032,
		0,
		Lang.get(118199),
		43400,
		32,
		300
	},
	[43400033] = {
		43400033,
		0,
		Lang.get(118200),
		43400,
		33,
		928,
		nil,
		1
	},
	[43400034] = {
		43400034,
		0,
		Lang.get(118201),
		43400,
		34,
		928,
		nil,
		1
	},
	[43400035] = {
		43400035,
		0,
		Lang.get(118202),
		43400,
		35,
		928,
		nil,
		1
	},
	[43400036] = {
		43400036,
		3,
		Lang.get(118203),
		43400,
		36,
		605,
		[22] = 1
	},
	[43400037] = {
		43400037,
		0,
		Lang.get(118204),
		43400,
		37,
		928,
		nil,
		1
	},
	[43400038] = {
		43400038,
		3,
		Lang.get(118205),
		43400,
		38,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		204,
		43404,
		nil,
		nil,
		nil,
		1,
		nil,
		43404,
		nil,
		nil,
		1
	},
	[43400039] = {
		43400039,
		0,
		Lang.get(118206),
		43400,
		39,
		107,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		3
	},
	[43400040] = {
		43400040,
		0,
		Lang.get(118207),
		43400,
		40,
		244,
		{
			RTResTalkAction[4],
			RTResTalkAction[14]
		}
	},
	[43400041] = {
		43400041,
		0,
		Lang.get(118208),
		43400,
		41,
		300,
		{
			RTResTalkAction[4],
			RTResTalkAction[6]
		}
	},
	[43400042] = {
		43400042,
		0,
		Lang.get(118209),
		43400,
		42,
		107,
		{
			RTResTalkAction[15],
			RTResTalkAction[6]
		}
	},
	[43400043] = {
		43400043,
		3,
		Lang.get(118210),
		43400,
		43,
		605,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		},
		nil,
		nil,
		-1,
		1225,
		[22] = 1
	},
	[43400044] = {
		43400044,
		0,
		Lang.get(118211),
		43400,
		44,
		300
	},
	[43400045] = {
		43400045,
		13,
		Lang.get(118212),
		43400,
		45,
		257,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		3,
		nil,
		122,
		[27] = 3
	},
	[43400046] = {
		43400046,
		0,
		Lang.get(118213),
		43400,
		46,
		300,
		{
			RTResTalkAction[17]
		}
	},
	[43400047] = {
		43400047,
		13,
		Lang.get(118214),
		43400,
		47,
		257,
		{
			RTResTalkAction[16]
		},
		[27] = 3
	},
	[43400048] = {
		43400048,
		0,
		Lang.get(118215),
		43400,
		48,
		300,
		{
			RTResTalkAction[17]
		}
	},
	[43400049] = {
		43400049,
		13,
		Lang.get(118216),
		43400,
		49,
		257,
		{
			RTResTalkAction[16]
		},
		[27] = 3
	},
	[43400050] = {
		43400050,
		13,
		Lang.get(118217),
		43400,
		50,
		257,
		{
			RTResTalkAction[16]
		},
		[27] = 3
	},
	[43400051] = {
		43400051,
		0,
		Lang.get(118218),
		43400,
		51,
		244,
		{
			RTResTalkAction[17]
		}
	},
	[43400052] = {
		43400052,
		13,
		Lang.get(118219),
		43400,
		52,
		257,
		{
			RTResTalkAction[16]
		},
		[27] = 3
	},
	[43400053] = {
		43400053,
		13,
		Lang.get(118220),
		43400,
		53,
		257,
		{
			RTResTalkAction[16]
		},
		[27] = 3
	},
	[43400054] = {
		43400054,
		13,
		Lang.get(118221),
		43400,
		54,
		257,
		{
			RTResTalkAction[16]
		},
		[27] = 3
	},
	[43400055] = {
		43400055,
		4,
		nil,
		43400,
		55,
		300,
		{
			RTResTalkAction[17]
		},
		[29] = {
			{
				id = 43400056,
				branch_content = Lang.get(118222)
			},
			{
				id = 43400056,
				branch_content = Lang.get(118223)
			}
		}
	},
	[43400056] = {
		43400056,
		13,
		Lang.get(118224),
		43400,
		56,
		257,
		{
			RTResTalkAction[16]
		},
		[27] = 3
	},
	[43400057] = {
		43400057,
		4,
		nil,
		43400,
		57,
		300,
		{
			RTResTalkAction[17]
		},
		[29] = {
			{
				id = 43400058,
				branch_content = Lang.get(118225)
			},
			{
				id = 43400058,
				branch_content = Lang.get(118226)
			}
		}
	},
	[43400058] = {
		43400058,
		13,
		Lang.get(118227),
		43400,
		58,
		257,
		{
			RTResTalkAction[16]
		},
		[27] = 3
	},
	[43400059] = {
		43400059,
		13,
		Lang.get(118228),
		43400,
		59,
		257,
		{
			RTResTalkAction[16]
		},
		[27] = 3
	},
	[43400060] = {
		43400060,
		13,
		Lang.get(118229),
		43400,
		60,
		257,
		{
			RTResTalkAction[16]
		},
		[27] = 3
	},
	[43400061] = {
		43400061,
		3,
		Lang.get(118230),
		43400,
		61,
		605,
		{
			RTResTalkAction[17]
		},
		[22] = 1
	},
	[43401001] = {
		43401001,
		0,
		Lang.get(118231),
		43401,
		1,
		1165,
		nil,
		nil,
		nil,
		nil,
		nil,
		213,
		43405,
		1,
		nil,
		nil,
		nil,
		nil,
		43405,
		255
	},
	[43401002] = {
		43401002,
		0,
		Lang.get(118232),
		43401,
		2,
		1307,
		nil,
		1,
		0
	},
	[43401003] = {
		43401003,
		0,
		Lang.get(118233),
		43401,
		3,
		1165
	},
	[43401004] = {
		43401004,
		3,
		Lang.get(87559),
		43401,
		4,
		605,
		[22] = 1,
		[20] = -1
	},
	[43401005] = {
		43401005,
		0,
		Lang.get(118234),
		43401,
		5,
		1307,
		{
			RTResTalkAction[18]
		},
		nil,
		nil,
		3,
		nil,
		62
	},
	[43401006] = {
		43401006,
		0,
		Lang.get(118235),
		43401,
		6,
		1122,
		{
			RTResTalkAction[19],
			RTResTalkAction[20]
		}
	},
	[43401007] = {
		43401007,
		0,
		Lang.get(118236),
		43401,
		7,
		1142,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[43401008] = {
		43401008,
		0,
		Lang.get(118237),
		43401,
		8,
		1307,
		{
			RTResTalkAction[23],
			RTResTalkAction[24],
			RTResTalkAction[25]
		}
	},
	[43401009] = {
		43401009,
		0,
		Lang.get(118238),
		43401,
		9,
		1122,
		{
			RTResTalkAction[26],
			RTResTalkAction[22],
			RTResTalkAction[20]
		}
	},
	[43401010] = {
		43401010,
		0,
		Lang.get(118239),
		43401,
		10,
		1142,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[43401011] = {
		43401011,
		0,
		Lang.get(118240),
		43401,
		11,
		1307,
		{
			RTResTalkAction[27],
			RTResTalkAction[24],
			RTResTalkAction[25]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		43406,
		1,
		1,
		nil,
		1,
		nil,
		43406
	},
	[43401012] = {
		43401012,
		0,
		Lang.get(118241),
		43401,
		12,
		386,
		{
			RTResTalkAction[28],
			RTResTalkAction[29]
		}
	},
	[43401013] = {
		43401013,
		0,
		Lang.get(118242),
		43401,
		13,
		386,
		{
			RTResTalkAction[30],
			RTResTalkAction[29]
		}
	},
	[43401014] = {
		43401014,
		3,
		Lang.get(47266),
		43401,
		14,
		605,
		{
			RTResTalkAction[31],
			RTResTalkAction[20]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		43407,
		[19] = 43407,
		[22] = 1
	},
	[43401015] = {
		43401015,
		0,
		Lang.get(118243),
		43401,
		15,
		1307,
		{
			RTResTalkAction[32]
		},
		nil,
		nil,
		3
	},
	[43401016] = {
		43401016,
		0,
		Lang.get(118244),
		43401,
		16,
		1056,
		{
			RTResTalkAction[33],
			RTResTalkAction[34]
		}
	},
	[43401017] = {
		43401017,
		0,
		Lang.get(118245),
		43401,
		17,
		1058,
		{
			RTResTalkAction[33],
			RTResTalkAction[35],
			RTResTalkAction[36]
		},
		nil,
		nil,
		nil,
		nil,
		60
	},
	[43401018] = {
		43401018,
		0,
		Lang.get(118246),
		43401,
		18,
		1056,
		{
			RTResTalkAction[33],
			RTResTalkAction[34],
			RTResTalkAction[37]
		}
	},
	[43401019] = {
		43401019,
		0,
		Lang.get(118247),
		43401,
		19,
		1307,
		{
			RTResTalkAction[38],
			RTResTalkAction[34]
		}
	},
	[43401020] = {
		43401020,
		0,
		Lang.get(118248),
		43401,
		20,
		1056,
		{
			RTResTalkAction[33],
			RTResTalkAction[34]
		}
	},
	[43401021] = {
		43401021,
		0,
		Lang.get(118249),
		43401,
		21,
		1056,
		{
			RTResTalkAction[33],
			RTResTalkAction[34]
		}
	},
	[43401022] = {
		43401022,
		5,
		Lang.get(118250),
		43401,
		22,
		292,
		{
			RTResTalkAction[39],
			RTResTalkAction[20],
			RTResTalkAction[36]
		}
	},
	[43401023] = {
		43401023,
		0,
		Lang.get(118251),
		43401,
		23,
		1307,
		{
			RTResTalkAction[40],
			RTResTalkAction[41]
		}
	},
	[43401024] = {
		43401024,
		3,
		Lang.get(118252),
		43401,
		24,
		605,
		{
			RTResTalkAction[20],
			RTResTalkAction[42]
		},
		[22] = 1
	},
	[43401025] = {
		43401025,
		0,
		Lang.get(118253),
		43401,
		25,
		292,
		{
			RTResTalkAction[43]
		}
	},
	[43401026] = {
		43401026,
		0,
		Lang.get(118254),
		43401,
		26,
		1307,
		{
			RTResTalkAction[44],
			RTResTalkAction[29]
		}
	},
	[43401027] = {
		43401027,
		0,
		Lang.get(118255),
		43401,
		27,
		292,
		{
			RTResTalkAction[45],
			RTResTalkAction[29]
		}
	},
	[43401028] = {
		43401028,
		0,
		Lang.get(118256),
		43401,
		28,
		1307,
		{
			RTResTalkAction[44],
			RTResTalkAction[29]
		}
	},
	[43401029] = {
		43401029,
		0,
		Lang.get(118257),
		43401,
		29,
		292,
		{
			RTResTalkAction[44],
			RTResTalkAction[29]
		}
	},
	[43401030] = {
		43401030,
		0,
		Lang.get(118258),
		43401,
		30,
		1307,
		{
			RTResTalkAction[44],
			RTResTalkAction[29]
		}
	},
	[43401031] = {
		43401031,
		0,
		Lang.get(118259),
		43401,
		31,
		292,
		{
			RTResTalkAction[44],
			RTResTalkAction[29]
		}
	},
	[43401032] = {
		43401032,
		0,
		Lang.get(118260),
		43401,
		32,
		1307,
		{
			RTResTalkAction[44],
			RTResTalkAction[29]
		}
	},
	[43401033] = {
		43401033,
		0,
		Lang.get(118261),
		43401,
		33,
		292,
		{
			RTResTalkAction[45],
			RTResTalkAction[29]
		}
	},
	[43401034] = {
		43401034,
		3,
		Lang.get(118262),
		43401,
		34,
		605,
		{
			RTResTalkAction[42],
			RTResTalkAction[20]
		},
		nil,
		nil,
		-1,
		nil,
		8,
		43408,
		1,
		1,
		nil,
		1,
		nil,
		43408,
		nil,
		nil,
		1
	},
	[43401035] = {
		43401035,
		0,
		Lang.get(118263),
		43401,
		35,
		1048,
		{
			RTResTalkAction[46]
		},
		nil,
		nil,
		3
	},
	[43401036] = {
		43401036,
		4,
		nil,
		43401,
		36,
		300,
		{
			RTResTalkAction[47]
		},
		[29] = {
			{
				id = 43401037,
				branch_content = Lang.get(118264)
			},
			{
				id = 43401037,
				branch_content = Lang.get(118265)
			}
		}
	},
	[43401037] = {
		43401037,
		0,
		Lang.get(118266),
		43401,
		37,
		1048,
		{
			RTResTalkAction[47]
		}
	},
	[43401038] = {
		43401038,
		3,
		Lang.get(23446),
		43401,
		38,
		605,
		{
			RTResTalkAction[47]
		},
		nil,
		nil,
		nil,
		2758,
		[22] = 1
	},
	[43401039] = {
		43401039,
		0,
		Lang.get(118267),
		43401,
		39,
		1048,
		{
			RTResTalkAction[47]
		}
	},
	[43401040] = {
		43401040,
		0,
		Lang.get(118268),
		43401,
		40,
		1307,
		{
			RTResTalkAction[32],
			RTResTalkAction[48]
		},
		nil,
		nil,
		3,
		nil,
		62,
		43409,
		1,
		1,
		nil,
		1,
		nil,
		43409
	},
	[43401041] = {
		43401041,
		7,
		"130",
		43401,
		41,
		nil,
		{
			RTResTalkAction[20]
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
	[43401042] = {
		43401042,
		4,
		nil,
		43401,
		42,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[29] = {
			{
				id = 43401043,
				branch_content = Lang.get(118269)
			},
			{
				id = 43401043,
				branch_content = Lang.get(118270)
			}
		}
	},
	[43401043] = {
		43401043,
		0,
		Lang.get(118271),
		43401,
		43,
		1048,
		{
			RTResTalkAction[49],
			RTResTalkAction[29]
		}
	},
	[43401044] = {
		43401044,
		0,
		Lang.get(118272),
		43401,
		44,
		292,
		{
			RTResTalkAction[50],
			RTResTalkAction[43],
			RTResTalkAction[51]
		}
	},
	[43401045] = {
		43401045,
		0,
		Lang.get(118273),
		43401,
		45,
		1307,
		{
			RTResTalkAction[27],
			RTResTalkAction[48],
			RTResTalkAction[42]
		}
	},
	[43401046] = {
		43401046,
		0,
		Lang.get(118274),
		43401,
		46,
		292,
		{
			RTResTalkAction[52],
			RTResTalkAction[29]
		}
	},
	[43401047] = {
		43401047,
		0,
		Lang.get(118275),
		43401,
		47,
		292,
		{
			RTResTalkAction[44],
			RTResTalkAction[29]
		}
	},
	[43401048] = {
		43401048,
		0,
		Lang.get(118276),
		43401,
		48,
		300,
		{
			RTResTalkAction[44],
			RTResTalkAction[29]
		}
	},
	[43401049] = {
		43401049,
		0,
		Lang.get(118277),
		43401,
		49,
		292,
		{
			RTResTalkAction[45],
			RTResTalkAction[29]
		}
	},
	[43401050] = {
		43401050,
		0,
		Lang.get(118278),
		43401,
		50,
		292,
		{
			RTResTalkAction[44],
			RTResTalkAction[29]
		}
	},
	[43401051] = {
		43401051,
		0,
		Lang.get(118279),
		43401,
		51,
		1307,
		{
			RTResTalkAction[44],
			RTResTalkAction[53]
		}
	},
	[43401052] = {
		43401052,
		4,
		nil,
		43401,
		52,
		300,
		{
			RTResTalkAction[44],
			RTResTalkAction[29]
		},
		[29] = {
			{
				id = 43401053,
				branch_content = Lang.get(118280)
			},
			{
				id = 43401053,
				branch_content = Lang.get(82708)
			}
		}
	},
	[43401053] = {
		43401053,
		0,
		Lang.get(118281),
		43401,
		53,
		292,
		{
			RTResTalkAction[43],
			RTResTalkAction[20]
		}
	},
	[43401054] = {
		43401054,
		0,
		Lang.get(118282),
		43401,
		54,
		1048,
		{
			RTResTalkAction[44],
			RTResTalkAction[54]
		},
		nil,
		nil,
		nil,
		nil,
		60
	},
	[43401055] = {
		43401055,
		0,
		Lang.get(118283),
		43401,
		55,
		292,
		{
			RTResTalkAction[44],
			RTResTalkAction[55]
		}
	},
	[43401056] = {
		43401056,
		0,
		Lang.get(118284),
		43401,
		56,
		1048,
		{
			RTResTalkAction[44],
			RTResTalkAction[56]
		}
	},
	[43401057] = {
		43401057,
		5,
		Lang.get(118285),
		43401,
		57,
		292,
		{
			RTResTalkAction[57],
			RTResTalkAction[55]
		}
	},
	[43401058] = {
		43401058,
		0,
		Lang.get(118286),
		43401,
		58,
		1307,
		{
			RTResTalkAction[32],
			RTResTalkAction[42],
			RTResTalkAction[48]
		},
		nil,
		nil,
		nil,
		nil,
		197
	},
	[43401059] = {
		43401059,
		0,
		Lang.get(118287),
		43401,
		59,
		1048,
		{
			RTResTalkAction[58],
			RTResTalkAction[29]
		}
	},
	[43401060] = {
		43401060,
		0,
		Lang.get(118288),
		43401,
		60,
		1048,
		{
			RTResTalkAction[59],
			RTResTalkAction[29]
		}
	},
	[43401061] = {
		43401061,
		0,
		Lang.get(118289),
		43401,
		61,
		1307,
		{
			RTResTalkAction[59],
			RTResTalkAction[29]
		}
	},
	[43401062] = {
		43401062,
		0,
		Lang.get(118290),
		43401,
		62,
		292,
		{
			RTResTalkAction[43],
			RTResTalkAction[48],
			RTResTalkAction[20]
		}
	},
	[43401063] = {
		43401063,
		4,
		nil,
		43401,
		63,
		300,
		{
			RTResTalkAction[42]
		},
		[29] = {
			{
				id = 43401064,
				branch_content = Lang.get(118291)
			}
		}
	},
	[43401064] = {
		43401064,
		3,
		Lang.get(118292),
		43401,
		64,
		605,
		[22] = 1
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
