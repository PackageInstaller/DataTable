-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\caiwenji\\ResTalk.lua

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
	[2] = 1117
}
RTResTalkAction[2] = {
	[1] = 1,
	[2] = 1104
}
RTResTalkAction[3] = {
	[1] = 0,
	[2] = 1117
}
RTResTalkAction[4] = {
	[1] = 1,
	[2] = 1104,
	[3] = {
		3
	}
}
RTResTalkAction[5] = {
	[1] = 1,
	[2] = 1094
}
RTResTalkAction[6] = {
	[1] = 0,
	[2] = 1104
}
RTResTalkAction[7] = {
	[1] = 0,
	[2] = 1094
}
RTResTalkAction[8] = {
	[1] = 2,
	[2] = 1117
}
RTResTalkAction[9] = {
	[1] = 3,
	[2] = 1104
}
RTResTalkAction[10] = {
	[1] = 3,
	[2] = 1104,
	[3] = {
		3
	}
}
RTResTalkAction[11] = {
	[1] = 1,
	[2] = 1104,
	[3] = {
		1
	}
}
RTResTalkAction[12] = {
	[1] = 1,
	[2] = 1097,
	[3] = {
		1
	}
}
RTResTalkAction[13] = {
	[1] = 1,
	[2] = 801
}
RTResTalkAction[14] = {
	[1] = 1,
	[2] = 1117,
	[3] = {
		1002
	}
}
RTResTalkAction[15] = {
	[1] = 0,
	[2] = 801
}
RTResTalkAction[16] = {
	[1] = 2,
	[2] = 1094
}
RTResTalkAction[17] = {
	[1] = 3,
	[2] = 1117
}
RTResTalkAction[18] = {
	[1] = 3,
	[2] = 1117,
	[3] = {
		3
	}
}
RTResTalkAction[19] = {
	[1] = 1,
	[2] = 1026
}
RTResTalkAction[20] = {
	[1] = 1,
	[2] = 1098,
	[3] = {
		1
	}
}
RTResTalkAction[21] = {
	[1] = 0,
	[2] = 1026
}
RTResTalkAction[22] = {
	[1] = 0,
	[2] = 1098
}
RTResTalkAction[23] = {
	[1] = 1,
	[2] = 804
}
RTResTalkAction[24] = {
	[1] = 0,
	[2] = 804
}
RTResTalkAction[25] = {
	[1] = 1,
	[2] = 1093,
	[3] = {
		1
	}
}
RTResTalkAction[26] = {
	[1] = 0,
	[2] = 1093
}
RTResTalkAction[27] = {
	[1] = 1,
	[2] = 387,
	[3] = {
		2
	}
}
RTResTalkAction[28] = {
	[1] = 2,
	[2] = 1093
}
RTResTalkAction[29] = {
	[1] = 3,
	[2] = 387
}
RTResTalkAction[30] = {
	[1] = 0,
	[2] = 387
}
RTResTalkAction[31] = {
	[1] = 1,
	[2] = 107,
	[3] = {
		1
	}
}
RTResTalkAction[32] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[33] = {
	[1] = 1,
	[2] = 1093
}
RTResTalkAction[34] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[35] = {
	[1] = 3,
	[2] = 107
}
RTResTalkAction[36] = {
	[1] = 1,
	[2] = 803
}
RTResTalkAction[37] = {
	[1] = 0,
	[2] = 803
}
RTResTalkAction[38] = {
	[1] = 1,
	[2] = 1117,
	[3] = {
		3
	}
}
RTResTalkAction[39] = {
	3,
	1094,
	nil,
	nil,
	1
}
RTResTalkAction[40] = {
	3,
	107,
	nil,
	nil,
	4
}
RTResTalkAction[41] = {
	3,
	107,
	nil,
	nil,
	0
}
RTResTalkAction[42] = {
	1,
	1093,
	{
		1001
	},
	nil,
	2
}
RTResTalkAction[43] = {
	1,
	1093,
	nil,
	nil,
	2
}
RTResTalkAction[44] = {
	1,
	803,
	nil,
	nil,
	0
}
RTResTalkAction[45] = {
	[1] = 1,
	[2] = 805
}
RTResTalkAction[46] = {
	[1] = 0,
	[2] = 805
}
RTResTalkAction[47] = {
	[1] = 1,
	[2] = 806
}
RTResTalkAction[48] = {
	[1] = 0,
	[2] = 806
}
RTResTalkAction[49] = {
	[1] = 1,
	[2] = 1094,
	[3] = {
		1003
	}
}
RTResTalkAction[50] = {
	[1] = 1,
	[2] = 807
}
RTResTalkAction[51] = {
	[1] = 0,
	[2] = 807
}
RTResTalkAction[52] = {
	[1] = 1,
	[2] = 1117,
	[3] = {
		1
	}
}
RTResTalkAction[53] = {
	[1] = 1,
	[2] = 1117,
	[3] = {
		1001
	}
}
RTResTalkAction[54] = {
	[1] = 1,
	[2] = 1095,
	[3] = {
		1
	}
}
RTResTalkAction[55] = {
	[1] = 0,
	[2] = 1095
}
RTResTalkAction[56] = {
	[1] = 1,
	[2] = 1094,
	[3] = {
		1001
	}
}
RTResTalkAction[57] = {
	[1] = 3,
	[2] = 1094
}
RTResTalkAction[58] = {
	[1] = 1,
	[2] = 1093,
	[3] = {
		2
	}
}
RTResTalkAction[59] = {
	[1] = 1,
	[2] = 141
}
RTResTalkAction[60] = {
	[1] = 3,
	[2] = 141
}
RTResTalkAction[61] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[62] = {
	[1] = 1,
	[2] = 225
}
RTResTalkAction[63] = {
	[1] = 1,
	[2] = 196
}
RTResTalkAction[64] = {
	[1] = 0,
	[2] = 225
}
RTResTalkAction[65] = {
	[1] = 1,
	[2] = 386
}
RTResTalkAction[66] = {
	[1] = 0,
	[2] = 196
}
RTResTalkAction[67] = {
	[1] = 1,
	[2] = 1095
}
RTResTalkAction[68] = {
	[1] = 0,
	[2] = 386
}
RTResTalkAction[69] = {
	[1] = 1,
	[2] = 386,
	[3] = {
		3
	}
}
RTResTalkAction[70] = {
	[1] = 1,
	[2] = 386,
	[3] = {
		1005
	}
}
RTResTalkAction[71] = {
	[1] = 1,
	[2] = 386,
	[3] = {
		1
	}
}
RTResTalkAction[72] = {
	[1] = 1,
	[2] = 107,
	[3] = {
		2
	}
}
RTResTalkAction[73] = {
	[1] = 1,
	[2] = 1117,
	[3] = {
		1004
	}
}
RTResTalkAction[74] = {
	[1] = 1,
	[2] = 802
}
RTResTalkAction[75] = {
	[1] = 1,
	[2] = 1094,
	[3] = {
		1002
	}
}
RTResTalkAction[76] = {
	[1] = 1,
	[2] = 1093,
	[3] = {
		1001
	}
}
RTResTalkAction[77] = {
	[1] = 1,
	[2] = 1117,
	[3] = {
		2
	}
}
RTResTalkAction[78] = {
	[1] = 1,
	[2] = 1098,
	[3] = {
		1002
	}
}
RTResTalkAction[79] = {
	[1] = 1,
	[2] = 1098,
	[3] = {
		1001
	}
}
RTResTalkAction[80] = {
	[1] = 1,
	[2] = 1109,
	[3] = {
		1
	}
}
RTResTalkAction[81] = {
	[1] = 3,
	[2] = 1109
}
RTResTalkAction[82] = {
	[1] = 0,
	[2] = 1109
}
RTResTalkAction[83] = {
	[1] = 1,
	[2] = 1110
}
RTResTalkAction[84] = {
	[1] = 2,
	[2] = 1110
}
RTResTalkAction[85] = {
	[1] = 3,
	[2] = 1111,
	[3] = {
		1
	}
}
RTResTalkAction[86] = {
	[1] = 3,
	[2] = 1111
}
RTResTalkAction[87] = {
	[1] = 2,
	[2] = 1110,
	[3] = {
		1004
	}
}
RTResTalkAction[88] = {
	[1] = 3,
	[2] = 1111,
	[3] = {
		1003
	}
}
RTResTalkAction[89] = {
	[1] = 0,
	[2] = 1110
}
RTResTalkAction[90] = {
	[1] = 0,
	[2] = 1111
}
RTResTalkAction[91] = {
	[1] = 1,
	[2] = 1109,
	[3] = {
		2
	}
}
RTResTalkAction[92] = {
	[1] = 1,
	[2] = 1105,
	[3] = {
		1
	}
}
RTResTalkAction[93] = {
	[1] = 2,
	[2] = 1112,
	[3] = {
		1004
	}
}
RTResTalkAction[94] = {
	[1] = 3,
	[2] = 1105
}
RTResTalkAction[95] = {
	[1] = 2,
	[2] = 1112
}
RTResTalkAction[96] = {
	[1] = 3,
	[2] = 1105,
	[3] = {
		2
	}
}
RTResTalkAction[97] = {
	[1] = 3,
	[2] = 1105,
	[3] = {
		3
	}
}
RTResTalkAction[98] = {
	[1] = 2,
	[2] = 1112,
	[3] = {
		1002
	}
}
RTResTalkAction[99] = {
	[1] = 0,
	[2] = 1112
}
RTResTalkAction[100] = {
	[1] = 0,
	[2] = 1105
}
RTResTalkAction[101] = {
	[1] = 1,
	[2] = 1098
}
RTResTalkAction[102] = {
	1,
	1093,
	{
		1002
	},
	nil,
	2
}
RTResTalkAction[103] = {
	1,
	1098,
	nil,
	nil,
	0
}
RTResTalkAction[104] = {
	[1] = 1,
	[2] = 1111,
	[3] = {
		3
	}
}
RTResTalkAction[105] = {
	[1] = 1,
	[2] = 1112,
	[3] = {
		1
	}
}
RTResTalkAction[106] = {
	[1] = 3,
	[2] = 1098
}
RTResTalkAction[107] = {
	1,
	1093,
	nil,
	nil,
	1
}

local Data = {
	[34000001] = {
		34000001,
		0,
		Lang.get(86081),
		34000,
		1,
		1096,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		34000,
		nil,
		nil,
		nil,
		nil,
		nil,
		34000,
		255
	},
	[34000002] = {
		34000002,
		0,
		Lang.get(86082),
		34000,
		2,
		1096,
		nil,
		1,
		[20] = 255
	},
	[34000003] = {
		34000003,
		0,
		Lang.get(86083),
		34000,
		3,
		1096,
		nil,
		1,
		[20] = 255
	},
	[34000004] = {
		34000004,
		3,
		Lang.get(86084),
		34000,
		4,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		34001,
		nil,
		nil,
		nil,
		nil,
		nil,
		34001,
		-1,
		nil,
		1
	},
	[34000005] = {
		34000005,
		0,
		Lang.get(86085),
		34000,
		5,
		1094,
		nil,
		1
	},
	[34000006] = {
		34000006,
		0,
		Lang.get(86086),
		34000,
		6,
		1117,
		nil,
		1
	},
	[34000007] = {
		34000007,
		0,
		Lang.get(86087),
		34000,
		7,
		1096,
		nil,
		1
	},
	[34000008] = {
		34000008,
		0,
		Lang.get(86088),
		34000,
		8,
		1096,
		nil,
		1
	},
	[34000009] = {
		34000009,
		0,
		Lang.get(86089),
		34000,
		9,
		1104,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		34002,
		[19] = 34002
	},
	[34000010] = {
		34000010,
		0,
		Lang.get(86090),
		34000,
		10,
		1117,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[34000011] = {
		34000011,
		0,
		Lang.get(86091),
		34000,
		11,
		1104,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[34000012] = {
		34000012,
		0,
		Lang.get(86092),
		34000,
		12,
		1104,
		{
			RTResTalkAction[4]
		}
	},
	[34000013] = {
		34000013,
		0,
		Lang.get(86093),
		34000,
		13,
		1094,
		{
			RTResTalkAction[5],
			RTResTalkAction[6]
		}
	},
	[34000014] = {
		34000014,
		0,
		Lang.get(86094),
		34000,
		14,
		1094,
		{
			RTResTalkAction[5]
		}
	},
	[34000015] = {
		34000015,
		0,
		Lang.get(86551),
		34000,
		15,
		1104,
		{
			RTResTalkAction[2],
			RTResTalkAction[7]
		}
	},
	[34000016] = {
		34000016,
		0,
		Lang.get(86096),
		34000,
		16,
		1117,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[34000017] = {
		34000017,
		0,
		Lang.get(86552),
		34000,
		17,
		1104,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[34000018] = {
		34000018,
		0,
		Lang.get(86553),
		34000,
		18,
		1104,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[34000019] = {
		34000019,
		0,
		Lang.get(86554),
		34000,
		19,
		1104,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[34000020] = {
		34000020,
		0,
		Lang.get(86100),
		34000,
		20,
		1117,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[34000021] = {
		34000021,
		0,
		Lang.get(86555),
		34000,
		21,
		1104,
		{
			RTResTalkAction[8],
			RTResTalkAction[10]
		}
	},
	[34000022] = {
		34000022,
		0,
		Lang.get(86102),
		34000,
		22,
		1117,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		34003,
		[19] = 34003
	},
	[34000023] = {
		34000023,
		0,
		Lang.get(86103),
		34000,
		23,
		1097,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[34000024] = {
		34000024,
		0,
		Lang.get(86104),
		34000,
		24,
		1104,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3
	},
	[34000025] = {
		34000025,
		0,
		Lang.get(86105),
		34000,
		25,
		1097,
		{
			RTResTalkAction[12],
			RTResTalkAction[6]
		}
	},
	[34001001] = {
		34001001,
		0,
		Lang.get(86106),
		34001,
		1,
		1117,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		34010,
		nil,
		nil,
		nil,
		nil,
		nil,
		34010
	},
	[34001002] = {
		34001002,
		3,
		Lang.get(86107),
		34001,
		2,
		605,
		[22] = 1
	},
	[34001003] = {
		34001003,
		0,
		Lang.get(86108),
		34001,
		3,
		1117,
		{
			RTResTalkAction[13]
		},
		1,
		nil,
		3,
		[21] = 801
	},
	[34001004] = {
		34001004,
		0,
		Lang.get(86109),
		34001,
		4,
		1117,
		{
			RTResTalkAction[13]
		},
		1,
		[21] = 801
	},
	[34001005] = {
		34001005,
		0,
		Lang.get(86556),
		34001,
		5,
		1094,
		{
			RTResTalkAction[13]
		},
		1,
		[21] = 801
	},
	[34001006] = {
		34001006,
		0,
		Lang.get(86557),
		34001,
		6,
		1094,
		{
			RTResTalkAction[13]
		},
		1,
		[21] = 801
	},
	[34001007] = {
		34001007,
		0,
		Lang.get(86112),
		34001,
		7,
		1117,
		{
			RTResTalkAction[14],
			RTResTalkAction[15]
		}
	},
	[34001008] = {
		34001008,
		0,
		Lang.get(86558),
		34001,
		8,
		1094,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[34001009] = {
		34001009,
		0,
		Lang.get(86559),
		34001,
		9,
		1117,
		{
			RTResTalkAction[16],
			RTResTalkAction[18]
		}
	},
	[34001010] = {
		34001010,
		0,
		Lang.get(86560),
		34001,
		10,
		1094,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		34011,
		nil,
		1,
		nil,
		nil,
		nil,
		34011
	},
	[34001011] = {
		34001011,
		0,
		Lang.get(86561),
		34001,
		11,
		1026,
		nil,
		1
	},
	[34001012] = {
		34001012,
		0,
		Lang.get(86562),
		34001,
		12,
		1026,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		3
	},
	[34001013] = {
		34001013,
		0,
		Lang.get(86563),
		34001,
		13,
		1026,
		{
			RTResTalkAction[19]
		}
	},
	[34001014] = {
		34001014,
		0,
		Lang.get(86564),
		34001,
		14,
		1098,
		{
			RTResTalkAction[20],
			RTResTalkAction[21]
		}
	},
	[34001015] = {
		34001015,
		0,
		Lang.get(86120),
		34001,
		15,
		1094,
		{
			RTResTalkAction[22]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		34012,
		nil,
		1,
		nil,
		nil,
		nil,
		34012
	},
	[34001016] = {
		34001016,
		0,
		Lang.get(86121),
		34001,
		16,
		1094,
		nil,
		1
	},
	[34001017] = {
		34001017,
		0,
		Lang.get(86122),
		34001,
		17,
		1117,
		nil,
		1
	},
	[34002001] = {
		34002001,
		0,
		Lang.get(86565),
		34002,
		1,
		1099,
		{
			RTResTalkAction[23]
		},
		1,
		3,
		3,
		nil,
		60,
		34020,
		nil,
		nil,
		nil,
		nil,
		nil,
		34020,
		nil,
		804
	},
	[34002002] = {
		34002002,
		0,
		Lang.get(86566),
		34002,
		2,
		1099,
		{
			RTResTalkAction[23]
		},
		1,
		3,
		[21] = 804
	},
	[34002003] = {
		34002003,
		0,
		Lang.get(86567),
		34002,
		3,
		1099,
		{
			RTResTalkAction[23]
		},
		1,
		3,
		[21] = 804
	},
	[34002004] = {
		34002004,
		0,
		Lang.get(86568),
		34002,
		4,
		1099,
		{
			RTResTalkAction[23]
		},
		1,
		3,
		[21] = 804
	},
	[34002005] = {
		34002005,
		0,
		Lang.get(86569),
		34002,
		5,
		1099,
		{
			RTResTalkAction[23]
		},
		1,
		3,
		[21] = 804
	},
	[34002006] = {
		34002006,
		0,
		Lang.get(86570),
		34002,
		6,
		107,
		{
			RTResTalkAction[24]
		},
		1,
		0,
		nil,
		nil,
		nil,
		34021,
		nil,
		1,
		nil,
		nil,
		nil,
		34021
	},
	[34002007] = {
		34002007,
		0,
		Lang.get(86571),
		34002,
		7,
		387,
		nil,
		1
	},
	[34002008] = {
		34002008,
		0,
		Lang.get(86572),
		34002,
		8,
		1093,
		{
			RTResTalkAction[25]
		},
		nil,
		nil,
		3
	},
	[34002009] = {
		34002009,
		7,
		"97",
		34002,
		9,
		1093,
		{
			RTResTalkAction[26]
		}
	},
	[34002010] = {
		34002010,
		0,
		Lang.get(86573),
		34002,
		10,
		387,
		{
			RTResTalkAction[27]
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
	[34002011] = {
		34002011,
		0,
		Lang.get(86574),
		34002,
		11,
		1093,
		{
			RTResTalkAction[28],
			RTResTalkAction[29]
		}
	},
	[34002012] = {
		34002012,
		3,
		Lang.get(47266),
		34002,
		12,
		605,
		{
			RTResTalkAction[26],
			RTResTalkAction[30]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		34022,
		nil,
		1,
		[19] = 34022,
		[22] = 1
	},
	[34002013] = {
		34002013,
		0,
		Lang.get(86575),
		34002,
		13,
		387,
		nil,
		1
	},
	[34002014] = {
		34002014,
		0,
		Lang.get(86576),
		34002,
		14,
		1093,
		nil,
		1
	},
	[34002015] = {
		34002015,
		0,
		Lang.get(86577),
		34002,
		15,
		1093,
		{
			RTResTalkAction[25]
		},
		nil,
		nil,
		3
	},
	[34002016] = {
		34002016,
		0,
		Lang.get(86136),
		34002,
		16,
		387,
		{
			RTResTalkAction[28],
			RTResTalkAction[29]
		}
	},
	[34002017] = {
		34002017,
		0,
		Lang.get(86137),
		34002,
		17,
		1093,
		{
			RTResTalkAction[28],
			RTResTalkAction[29]
		}
	},
	[34002018] = {
		34002018,
		3,
		Lang.get(86138),
		34002,
		18,
		605,
		{
			RTResTalkAction[26],
			RTResTalkAction[30]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		34023,
		nil,
		1,
		[19] = 34023,
		[22] = 1
	},
	[34002019] = {
		34002019,
		0,
		Lang.get(86578),
		34002,
		19,
		1093,
		nil,
		1
	},
	[34002020] = {
		34002020,
		0,
		Lang.get(86579),
		34002,
		20,
		387,
		nil,
		1
	},
	[34002021] = {
		34002021,
		0,
		Lang.get(86141),
		34002,
		21,
		107,
		{
			RTResTalkAction[31]
		},
		nil,
		nil,
		3
	},
	[34002022] = {
		34002022,
		0,
		Lang.get(86142),
		34002,
		22,
		107,
		{
			RTResTalkAction[32]
		}
	},
	[34002023] = {
		34002023,
		0,
		Lang.get(86580),
		34002,
		23,
		1093,
		{
			RTResTalkAction[33],
			RTResTalkAction[34]
		}
	},
	[34002024] = {
		34002024,
		0,
		Lang.get(86144),
		34002,
		24,
		107,
		{
			RTResTalkAction[28],
			RTResTalkAction[35]
		}
	},
	[34002025] = {
		34002025,
		0,
		Lang.get(86581),
		34002,
		25,
		1093,
		{
			RTResTalkAction[28],
			RTResTalkAction[35]
		}
	},
	[34002026] = {
		34002026,
		0,
		Lang.get(86146),
		34002,
		26,
		387,
		{
			RTResTalkAction[28],
			RTResTalkAction[29],
			RTResTalkAction[34]
		}
	},
	[34003001] = {
		34003001,
		0,
		Lang.get(86147),
		34003,
		1,
		1094,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		34030,
		nil,
		nil,
		nil,
		nil,
		nil,
		34030
	},
	[34003002] = {
		34003002,
		3,
		Lang.get(85710),
		34003,
		2,
		605,
		[22] = 1
	},
	[34003003] = {
		34003003,
		0,
		Lang.get(86148),
		34003,
		3,
		1094,
		nil,
		1,
		[21] = 803
	},
	[34003004] = {
		34003004,
		0,
		Lang.get(86149),
		34003,
		4,
		1100,
		{
			RTResTalkAction[36]
		},
		1,
		nil,
		3,
		[21] = 803
	},
	[34003005] = {
		34003005,
		0,
		Lang.get(86582),
		34003,
		5,
		1093,
		{
			RTResTalkAction[36]
		},
		1,
		[21] = 803
	},
	[34003006] = {
		34003006,
		0,
		Lang.get(86151),
		34003,
		6,
		1100,
		{
			RTResTalkAction[36]
		},
		1,
		[21] = 803
	},
	[34003007] = {
		34003007,
		0,
		Lang.get(86583),
		34003,
		7,
		1093,
		{
			RTResTalkAction[36]
		},
		1,
		[21] = 803
	},
	[34003008] = {
		34003008,
		0,
		Lang.get(86153),
		34003,
		8,
		1100,
		{
			RTResTalkAction[36]
		},
		1,
		[21] = 803
	},
	[34003009] = {
		34003009,
		0,
		Lang.get(86584),
		34003,
		9,
		1093,
		{
			RTResTalkAction[36]
		},
		1,
		[21] = 803
	},
	[34003010] = {
		34003010,
		0,
		Lang.get(86155),
		34003,
		10,
		1094,
		{
			RTResTalkAction[37]
		},
		1
	},
	[34003011] = {
		34003011,
		3,
		Lang.get(86156),
		34003,
		11,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		34031,
		nil,
		nil,
		nil,
		1,
		nil,
		34031,
		nil,
		nil,
		1
	},
	[34003012] = {
		34003012,
		0,
		Lang.get(86585),
		34003,
		12,
		1094,
		nil,
		1
	},
	[34003013] = {
		34003013,
		0,
		Lang.get(86586),
		34003,
		13,
		1093,
		nil,
		1
	},
	[34003014] = {
		34003014,
		0,
		Lang.get(86159),
		34003,
		14,
		1117,
		{
			RTResTalkAction[38]
		},
		nil,
		nil,
		3
	},
	[34003015] = {
		34003015,
		0,
		Lang.get(86587),
		34003,
		15,
		1093,
		{
			RTResTalkAction[28],
			RTResTalkAction[17]
		}
	},
	[34003016] = {
		34003016,
		0,
		Lang.get(86588),
		34003,
		16,
		1094,
		{
			RTResTalkAction[28],
			RTResTalkAction[39],
			RTResTalkAction[3]
		}
	},
	[34003017] = {
		34003017,
		0,
		Lang.get(86589),
		34003,
		17,
		1093,
		{
			RTResTalkAction[33],
			RTResTalkAction[7]
		}
	},
	[34003018] = {
		34003018,
		0,
		Lang.get(86590),
		34003,
		18,
		1113,
		{
			RTResTalkAction[36],
			RTResTalkAction[26]
		},
		nil,
		nil,
		3,
		[21] = 803
	},
	[34003019] = {
		34003019,
		0,
		Lang.get(86164),
		34003,
		19,
		1113,
		{
			RTResTalkAction[36]
		},
		[21] = 803
	},
	[34003020] = {
		34003020,
		0,
		Lang.get(86591),
		34003,
		20,
		1117,
		{
			RTResTalkAction[1],
			RTResTalkAction[37]
		}
	},
	[34201001] = {
		34201001,
		0,
		Lang.get(86166),
		34201,
		1,
		1093,
		nil,
		nil,
		nil,
		nil,
		nil,
		59,
		34201,
		[19] = 34201
	},
	[34004001] = {
		34004001,
		0,
		Lang.get(86167),
		34004,
		1,
		1117,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		34040,
		nil,
		nil,
		nil,
		nil,
		nil,
		34040
	},
	[34004002] = {
		34004002,
		0,
		Lang.get(86168),
		34004,
		2,
		1117,
		nil,
		1
	},
	[34004003] = {
		34004003,
		0,
		Lang.get(86169),
		34004,
		3,
		107,
		nil,
		1,
		8
	},
	[34004004] = {
		34004004,
		0,
		Lang.get(86170),
		34004,
		4,
		1094,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		3
	},
	[34004005] = {
		34004005,
		0,
		Lang.get(86171),
		34004,
		5,
		107,
		{
			RTResTalkAction[16],
			RTResTalkAction[40]
		}
	},
	[34004006] = {
		34004006,
		0,
		Lang.get(86592),
		34004,
		6,
		107,
		{
			RTResTalkAction[16],
			RTResTalkAction[40]
		}
	},
	[34004007] = {
		34004007,
		0,
		Lang.get(86173),
		34004,
		7,
		1094,
		{
			RTResTalkAction[16],
			RTResTalkAction[41]
		}
	},
	[34004008] = {
		34004008,
		0,
		Lang.get(86174),
		34004,
		8,
		1117,
		{
			RTResTalkAction[16],
			RTResTalkAction[17],
			RTResTalkAction[34]
		}
	},
	[34004009] = {
		34004009,
		0,
		Lang.get(86175),
		34004,
		9,
		1117,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[34004010] = {
		34004010,
		2,
		Lang.get(86176),
		34004,
		10,
		1094,
		{
			RTResTalkAction[5],
			RTResTalkAction[3]
		}
	},
	[34004011] = {
		34004011,
		2,
		Lang.get(86177),
		34004,
		11,
		1117,
		{
			RTResTalkAction[1],
			RTResTalkAction[7]
		}
	},
	[34004012] = {
		34004012,
		0,
		Lang.get(86178),
		34004,
		12,
		1104,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[34004013] = {
		34004013,
		2,
		Lang.get(86593),
		34004,
		13,
		1117,
		{
			RTResTalkAction[1],
			RTResTalkAction[6]
		}
	},
	[34004014] = {
		34004014,
		2,
		Lang.get(86594),
		34004,
		14,
		1094,
		{
			RTResTalkAction[5],
			RTResTalkAction[3]
		}
	},
	[34004015] = {
		34004015,
		2,
		Lang.get(86181),
		34004,
		15,
		1094,
		{
			RTResTalkAction[5]
		}
	},
	[34005001] = {
		34005001,
		0,
		Lang.get(86182),
		34005,
		1,
		1099,
		{
			RTResTalkAction[23]
		},
		1,
		3,
		nil,
		nil,
		159,
		34050,
		nil,
		nil,
		nil,
		nil,
		nil,
		34050,
		nil,
		804
	},
	[34005002] = {
		34005002,
		0,
		Lang.get(86183),
		34005,
		2,
		1099,
		{
			RTResTalkAction[23]
		},
		1,
		3,
		[21] = 804
	},
	[34005003] = {
		34005003,
		0,
		Lang.get(86184),
		34005,
		3,
		1099,
		{
			RTResTalkAction[23]
		},
		1,
		3,
		[21] = 804
	},
	[34005004] = {
		34005004,
		0,
		Lang.get(86185),
		34005,
		4,
		1099,
		{
			RTResTalkAction[23]
		},
		1,
		3,
		[21] = 804
	},
	[34005005] = {
		34005005,
		0,
		Lang.get(86186),
		34005,
		5,
		1093,
		{
			RTResTalkAction[42],
			RTResTalkAction[24]
		},
		nil,
		0,
		3
	},
	[34005006] = {
		34005006,
		0,
		Lang.get(86187),
		34005,
		6,
		1093,
		{
			RTResTalkAction[43]
		}
	},
	[34005007] = {
		34005007,
		0,
		Lang.get(86188),
		34005,
		7,
		1093,
		{
			RTResTalkAction[43]
		}
	},
	[34005008] = {
		34005008,
		2,
		Lang.get(86189),
		34005,
		8,
		1093,
		{
			RTResTalkAction[44],
			RTResTalkAction[26]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		34051,
		[19] = 34051,
		[21] = 803
	},
	[34005009] = {
		34005009,
		0,
		Lang.get(86190),
		34005,
		9,
		1101,
		{
			RTResTalkAction[45],
			RTResTalkAction[37]
		},
		1,
		2,
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
		805
	},
	[34005010] = {
		34005010,
		0,
		Lang.get(86191),
		34005,
		10,
		1101,
		{
			RTResTalkAction[45]
		},
		1,
		2,
		[21] = 805
	},
	[34005011] = {
		34005011,
		0,
		Lang.get(86192),
		34005,
		11,
		1101,
		{
			RTResTalkAction[45]
		},
		1,
		2,
		[21] = 805
	},
	[34005012] = {
		34005012,
		0,
		Lang.get(86595),
		34005,
		12,
		1117,
		{
			RTResTalkAction[46]
		},
		1,
		0,
		nil,
		nil,
		nil,
		34051,
		nil,
		1,
		nil,
		nil,
		nil,
		34051
	},
	[34005013] = {
		34005013,
		0,
		Lang.get(86596),
		34005,
		13,
		1117,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[34005014] = {
		34005014,
		0,
		Lang.get(86195),
		34005,
		14,
		1117,
		{
			RTResTalkAction[1]
		}
	},
	[34005015] = {
		34005015,
		0,
		Lang.get(86196),
		34005,
		15,
		1102,
		{
			RTResTalkAction[47],
			RTResTalkAction[3]
		},
		1,
		2,
		[21] = 806
	},
	[34005016] = {
		34005016,
		0,
		Lang.get(86197),
		34005,
		16,
		1102,
		{
			RTResTalkAction[47]
		},
		1,
		2,
		[21] = 806
	},
	[34005017] = {
		34005017,
		0,
		Lang.get(86198),
		34005,
		17,
		1117,
		{
			RTResTalkAction[1],
			RTResTalkAction[48]
		},
		nil,
		0
	},
	[34005018] = {
		34005018,
		0,
		Lang.get(86199),
		34005,
		18,
		1094,
		{
			RTResTalkAction[3]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		34052,
		nil,
		1,
		nil,
		nil,
		nil,
		34052
	},
	[34005019] = {
		34005019,
		0,
		Lang.get(86200),
		34005,
		19,
		1094,
		{
			RTResTalkAction[49]
		},
		nil,
		nil,
		3
	},
	[34005020] = {
		34005020,
		0,
		Lang.get(86597),
		34005,
		20,
		1094,
		{
			RTResTalkAction[5]
		}
	},
	[34005021] = {
		34005021,
		0,
		Lang.get(86598),
		34005,
		21,
		1099,
		{
			RTResTalkAction[47],
			RTResTalkAction[7]
		},
		1,
		3,
		[21] = 806
	},
	[34005022] = {
		34005022,
		0,
		Lang.get(86203),
		34005,
		22,
		1102,
		{
			RTResTalkAction[47]
		},
		1,
		2,
		[21] = 806
	},
	[34005023] = {
		34005023,
		0,
		Lang.get(86599),
		34005,
		23,
		1099,
		{
			RTResTalkAction[47]
		},
		1,
		3,
		[21] = 806
	},
	[34005024] = {
		34005024,
		0,
		Lang.get(86205),
		34005,
		24,
		1102,
		{
			RTResTalkAction[47]
		},
		1,
		2,
		[21] = 806
	},
	[34005025] = {
		34005025,
		0,
		Lang.get(86206),
		34005,
		25,
		1099,
		{
			RTResTalkAction[47]
		},
		1,
		3,
		[21] = 806
	},
	[34005026] = {
		34005026,
		0,
		Lang.get(86207),
		34005,
		26,
		1102,
		{
			RTResTalkAction[47]
		},
		1,
		2,
		[21] = 806
	},
	[34005027] = {
		34005027,
		0,
		Lang.get(86208),
		34005,
		27,
		1102,
		{
			RTResTalkAction[47]
		},
		1,
		2,
		[21] = 806
	},
	[34006001] = {
		34006001,
		0,
		Lang.get(86209),
		34006,
		1,
		1117,
		nil,
		1,
		0,
		nil,
		nil,
		177,
		34060,
		nil,
		nil,
		nil,
		nil,
		nil,
		34060
	},
	[34006002] = {
		34006002,
		0,
		Lang.get(86210),
		34006,
		2,
		1101,
		{
			RTResTalkAction[50]
		},
		1,
		2,
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
		807
	},
	[34006003] = {
		34006003,
		0,
		Lang.get(86211),
		34006,
		3,
		1099,
		{
			RTResTalkAction[50]
		},
		1,
		3,
		[21] = 807
	},
	[34006004] = {
		34006004,
		0,
		Lang.get(86212),
		34006,
		4,
		1102,
		{
			RTResTalkAction[50]
		},
		1,
		2,
		[21] = 807
	},
	[34006005] = {
		34006005,
		0,
		Lang.get(86213),
		34006,
		5,
		1101,
		{
			RTResTalkAction[50]
		},
		1,
		2,
		[21] = 807
	},
	[34006006] = {
		34006006,
		0,
		Lang.get(86214),
		34006,
		6,
		1102,
		{
			RTResTalkAction[50]
		},
		1,
		2,
		[21] = 807
	},
	[34006007] = {
		34006007,
		0,
		Lang.get(86215),
		34006,
		7,
		1101,
		{
			RTResTalkAction[50]
		},
		1,
		2,
		[21] = 807
	},
	[34006008] = {
		34006008,
		0,
		Lang.get(86216),
		34006,
		8,
		1099,
		{
			RTResTalkAction[50]
		},
		1,
		3,
		[21] = 807
	},
	[34006009] = {
		34006009,
		0,
		Lang.get(86217),
		34006,
		9,
		1101,
		{
			RTResTalkAction[50]
		},
		1,
		2,
		[21] = 807
	},
	[34006010] = {
		34006010,
		0,
		Lang.get(86218),
		34006,
		10,
		1099,
		{
			RTResTalkAction[50]
		},
		1,
		3,
		[21] = 807
	},
	[34006011] = {
		34006011,
		0,
		Lang.get(86219),
		34006,
		11,
		1101,
		{
			RTResTalkAction[50]
		},
		1,
		2,
		[21] = 807
	},
	[34006012] = {
		34006012,
		0,
		Lang.get(86220),
		34006,
		12,
		1099,
		{
			RTResTalkAction[50]
		},
		1,
		3,
		[21] = 807
	},
	[34006013] = {
		34006013,
		0,
		Lang.get(86221),
		34006,
		13,
		1102,
		{
			RTResTalkAction[50]
		},
		1,
		2,
		[21] = 807
	},
	[34006014] = {
		34006014,
		0,
		Lang.get(86222),
		34006,
		14,
		1102,
		{
			RTResTalkAction[50]
		},
		1,
		2,
		[21] = 807
	},
	[34006015] = {
		34006015,
		0,
		Lang.get(86223),
		34006,
		15,
		1099,
		{
			RTResTalkAction[50]
		},
		1,
		3,
		[21] = 807
	},
	[34006016] = {
		34006016,
		0,
		Lang.get(86224),
		34006,
		16,
		1101,
		{
			RTResTalkAction[50]
		},
		1,
		2,
		[21] = 807
	},
	[34006017] = {
		34006017,
		0,
		Lang.get(86225),
		34006,
		17,
		1102,
		{
			RTResTalkAction[50]
		},
		1,
		2,
		[21] = 807
	},
	[34006018] = {
		34006018,
		0,
		Lang.get(86226),
		34006,
		18,
		1102,
		{
			RTResTalkAction[50]
		},
		1,
		2,
		[21] = 807
	},
	[34006019] = {
		34006019,
		0,
		Lang.get(86227),
		34006,
		19,
		1101,
		{
			RTResTalkAction[50]
		},
		1,
		2,
		[21] = 807
	},
	[34006020] = {
		34006020,
		0,
		Lang.get(86228),
		34006,
		20,
		1101,
		{
			RTResTalkAction[50]
		},
		1,
		2,
		[21] = 807
	},
	[34006021] = {
		34006021,
		0,
		Lang.get(86229),
		34006,
		21,
		1102,
		{
			RTResTalkAction[50]
		},
		1,
		2,
		[21] = 807
	},
	[34006022] = {
		34006022,
		0,
		Lang.get(25821),
		34006,
		22,
		1101,
		{
			RTResTalkAction[50]
		},
		1,
		2,
		[21] = 807
	},
	[34006023] = {
		34006023,
		0,
		Lang.get(86230),
		34006,
		23,
		1102,
		{
			RTResTalkAction[50]
		},
		1,
		2,
		[21] = 807
	},
	[34006024] = {
		34006024,
		0,
		Lang.get(86231),
		34006,
		24,
		1102,
		{
			RTResTalkAction[50]
		},
		1,
		2,
		[21] = 807
	},
	[34006025] = {
		34006025,
		0,
		Lang.get(86232),
		34006,
		25,
		1101,
		{
			RTResTalkAction[50]
		},
		1,
		2,
		[21] = 807
	},
	[34006026] = {
		34006026,
		0,
		Lang.get(86233),
		34006,
		26,
		1099,
		{
			RTResTalkAction[50]
		},
		1,
		3,
		[21] = 807
	},
	[34006027] = {
		34006027,
		0,
		Lang.get(86234),
		34006,
		27,
		1094,
		{
			RTResTalkAction[51]
		},
		1,
		0,
		nil,
		nil,
		nil,
		34061,
		nil,
		1,
		nil,
		nil,
		nil,
		34061
	},
	[34007001] = {
		34007001,
		0,
		Lang.get(86235),
		34007,
		1,
		1099,
		{
			RTResTalkAction[50]
		},
		1,
		3,
		nil,
		nil,
		177,
		34070,
		nil,
		nil,
		nil,
		nil,
		nil,
		34070,
		nil,
		807
	},
	[34007002] = {
		34007002,
		0,
		Lang.get(86236),
		34007,
		2,
		1099,
		{
			RTResTalkAction[50]
		},
		1,
		3,
		[21] = 807
	},
	[34007003] = {
		34007003,
		2,
		Lang.get(86237),
		34007,
		3,
		1117,
		{
			RTResTalkAction[51]
		},
		1,
		0,
		nil,
		nil,
		nil,
		34071,
		nil,
		1,
		nil,
		nil,
		nil,
		34071
	},
	[34007004] = {
		34007004,
		0,
		Lang.get(86238),
		34007,
		4,
		1101,
		{
			RTResTalkAction[50]
		},
		1,
		2,
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
		807
	},
	[34007005] = {
		34007005,
		0,
		Lang.get(86239),
		34007,
		5,
		1102,
		{
			RTResTalkAction[50]
		},
		1,
		2,
		[21] = 807
	},
	[34007006] = {
		34007006,
		0,
		Lang.get(86240),
		34007,
		6,
		1099,
		{
			RTResTalkAction[50]
		},
		1,
		3,
		[21] = 807
	},
	[34007007] = {
		34007007,
		2,
		Lang.get(86241),
		34007,
		7,
		1094,
		{
			RTResTalkAction[51]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		34072,
		nil,
		1,
		nil,
		nil,
		nil,
		34072
	},
	[34007008] = {
		34007008,
		0,
		Lang.get(86242),
		34007,
		8,
		1101,
		{
			RTResTalkAction[50]
		},
		1,
		2,
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
		807
	},
	[34007009] = {
		34007009,
		0,
		Lang.get(86243),
		34007,
		9,
		1102,
		{
			RTResTalkAction[50]
		},
		1,
		2,
		[21] = 807
	},
	[34007010] = {
		34007010,
		0,
		Lang.get(86244),
		34007,
		10,
		1099,
		{
			RTResTalkAction[50]
		},
		1,
		3,
		[21] = 807
	},
	[34007011] = {
		34007011,
		2,
		Lang.get(86245),
		34007,
		11,
		1117,
		{
			RTResTalkAction[50]
		},
		1,
		0,
		nil,
		nil,
		nil,
		34073,
		nil,
		nil,
		nil,
		nil,
		nil,
		34073,
		nil,
		807
	},
	[34007012] = {
		34007012,
		0,
		Lang.get(86246),
		34007,
		12,
		1101,
		{
			RTResTalkAction[50]
		},
		1,
		2,
		[21] = 807
	},
	[34007013] = {
		34007013,
		0,
		Lang.get(86247),
		34007,
		13,
		1102,
		{
			RTResTalkAction[50]
		},
		1,
		2,
		[21] = 807
	},
	[34007014] = {
		34007014,
		0,
		Lang.get(86248),
		34007,
		14,
		1099,
		{
			RTResTalkAction[50]
		},
		1,
		3,
		nil,
		nil,
		nil,
		34074,
		nil,
		nil,
		nil,
		nil,
		nil,
		34074,
		nil,
		807
	},
	[34007015] = {
		34007015,
		0,
		Lang.get(86249),
		34007,
		15,
		1099,
		{
			RTResTalkAction[50]
		},
		1,
		3,
		[21] = 807
	},
	[34007016] = {
		34007016,
		2,
		Lang.get(86250),
		34007,
		16,
		1093,
		{
			RTResTalkAction[36],
			RTResTalkAction[51]
		},
		1,
		0,
		[21] = 803
	},
	[34007017] = {
		34007017,
		0,
		Lang.get(86251),
		34007,
		17,
		1114,
		{
			RTResTalkAction[36]
		},
		[21] = 803
	},
	[34007018] = {
		34007018,
		2,
		Lang.get(20606),
		34007,
		18,
		1093,
		{
			RTResTalkAction[36]
		},
		1,
		[21] = 803
	},
	[34007019] = {
		34007019,
		0,
		Lang.get(86252),
		34007,
		19,
		1117,
		{
			RTResTalkAction[37]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		34075,
		nil,
		1,
		nil,
		nil,
		nil,
		34075
	},
	[34007020] = {
		34007020,
		0,
		Lang.get(86253),
		34007,
		20,
		1117,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[34008001] = {
		34008001,
		0,
		Lang.get(86254),
		34008,
		1,
		1095,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		34080,
		nil,
		nil,
		nil,
		nil,
		nil,
		34080
	},
	[34008002] = {
		34008002,
		0,
		Lang.get(86255),
		34008,
		2,
		1094,
		nil,
		1
	},
	[34008003] = {
		34008003,
		0,
		Lang.get(86256),
		34008,
		3,
		1117,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		34081,
		[19] = 34081
	},
	[34008004] = {
		34008004,
		0,
		Lang.get(86257),
		34008,
		4,
		1094,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		3
	},
	[34008005] = {
		34008005,
		2,
		Lang.get(86258),
		34008,
		5,
		1117,
		{
			RTResTalkAction[14],
			RTResTalkAction[7]
		}
	},
	[34008006] = {
		34008006,
		0,
		Lang.get(86259),
		34008,
		6,
		1094,
		{
			RTResTalkAction[5],
			RTResTalkAction[3]
		}
	},
	[34008007] = {
		34008007,
		0,
		Lang.get(86260),
		34008,
		7,
		1094,
		{
			RTResTalkAction[5]
		}
	},
	[34008008] = {
		34008008,
		2,
		Lang.get(86261),
		34008,
		8,
		1117,
		{
			RTResTalkAction[52],
			RTResTalkAction[7]
		}
	},
	[34008009] = {
		34008009,
		0,
		Lang.get(86262),
		34008,
		9,
		1094,
		{
			RTResTalkAction[3]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		34082,
		nil,
		1,
		nil,
		nil,
		nil,
		34082
	},
	[34008010] = {
		34008010,
		2,
		Lang.get(86263),
		34008,
		10,
		1117,
		{
			RTResTalkAction[53]
		},
		nil,
		nil,
		3
	},
	[34008011] = {
		34008011,
		2,
		Lang.get(86264),
		34008,
		11,
		1117,
		{
			RTResTalkAction[1]
		}
	},
	[34008012] = {
		34008012,
		0,
		Lang.get(86265),
		34008,
		12,
		1117,
		{
			RTResTalkAction[1]
		}
	},
	[34008013] = {
		34008013,
		0,
		Lang.get(86266),
		34008,
		13,
		1117,
		{
			RTResTalkAction[1]
		}
	},
	[34008014] = {
		34008014,
		0,
		Lang.get(86267),
		34008,
		14,
		1095,
		{
			RTResTalkAction[54],
			RTResTalkAction[3]
		}
	},
	[34008015] = {
		34008015,
		0,
		Lang.get(86268),
		34008,
		15,
		1094,
		{
			RTResTalkAction[5],
			RTResTalkAction[55]
		}
	},
	[34008016] = {
		34008016,
		0,
		Lang.get(86269),
		34008,
		16,
		1094,
		{
			RTResTalkAction[5]
		}
	},
	[34008017] = {
		34008017,
		2,
		Lang.get(86270),
		34008,
		17,
		1094,
		{
			RTResTalkAction[56]
		}
	},
	[34008018] = {
		34008018,
		2,
		Lang.get(86271),
		34008,
		18,
		1094,
		{
			RTResTalkAction[5]
		}
	},
	[34008019] = {
		34008019,
		0,
		Lang.get(86272),
		34008,
		19,
		1095,
		{
			RTResTalkAction[54],
			RTResTalkAction[7]
		}
	},
	[34008020] = {
		34008020,
		0,
		Lang.get(86273),
		34008,
		20,
		1117,
		{
			RTResTalkAction[55]
		}
	},
	[34008021] = {
		34008021,
		0,
		Lang.get(86274),
		34008,
		21,
		1117
	},
	[34008022] = {
		34008022,
		0,
		Lang.get(86275),
		34008,
		22,
		1117,
		{
			RTResTalkAction[1]
		}
	},
	[34008023] = {
		34008023,
		0,
		"………………",
		34008,
		23,
		1094,
		{
			RTResTalkAction[5],
			RTResTalkAction[3]
		}
	},
	[34008024] = {
		34008024,
		0,
		Lang.get(86276),
		34008,
		24,
		1094,
		{
			RTResTalkAction[5]
		}
	},
	[34008025] = {
		34008025,
		0,
		Lang.get(86277),
		34008,
		25,
		1117,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[34008026] = {
		34008026,
		0,
		Lang.get(86278),
		34008,
		26,
		1094,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[34008027] = {
		34008027,
		0,
		Lang.get(86279),
		34008,
		27,
		1117,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[34009001] = {
		34009001,
		0,
		Lang.get(86280),
		34009,
		1,
		1117,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		34090,
		nil,
		nil,
		nil,
		nil,
		nil,
		34090
	},
	[34009002] = {
		34009002,
		0,
		Lang.get(86281),
		34009,
		2,
		1117,
		nil,
		1
	},
	[34009003] = {
		34009003,
		0,
		Lang.get(86282),
		34009,
		3,
		1117,
		nil,
		1
	},
	[34009004] = {
		34009004,
		0,
		Lang.get(86283),
		34009,
		4,
		1117,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		34091,
		[19] = 34091,
		[17] = 1
	},
	[34009005] = {
		34009005,
		0,
		Lang.get(86284),
		34009,
		5,
		1117,
		nil,
		1
	},
	[34009006] = {
		34009006,
		3,
		Lang.get(86285),
		34009,
		6,
		605,
		[22] = 1
	},
	[34009007] = {
		34009007,
		0,
		Lang.get(86286),
		34009,
		7,
		1117,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[34202001] = {
		34202001,
		0,
		Lang.get(86287),
		34202,
		1,
		1117,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		34202,
		nil,
		nil,
		nil,
		nil,
		nil,
		34202
	},
	[34202002] = {
		34202002,
		0,
		Lang.get(86288),
		34202,
		2,
		1094,
		nil,
		1
	},
	[34202003] = {
		34202003,
		0,
		Lang.get(86289),
		34202,
		3,
		1094,
		nil,
		1
	},
	[34202004] = {
		34202004,
		0,
		Lang.get(86290),
		34202,
		4,
		1117,
		nil,
		1
	},
	[34202005] = {
		34202005,
		0,
		Lang.get(86291),
		34202,
		5,
		1094,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		3
	},
	[34202006] = {
		34202006,
		0,
		Lang.get(86292),
		34202,
		6,
		1094,
		{
			RTResTalkAction[5]
		}
	},
	[34202007] = {
		34202007,
		0,
		Lang.get(86293),
		34202,
		7,
		1117,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[34202008] = {
		34202008,
		0,
		Lang.get(86294),
		34202,
		8,
		1094,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[34202009] = {
		34202009,
		0,
		Lang.get(86295),
		34202,
		9,
		1117,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[34202010] = {
		34202010,
		0,
		Lang.get(86296),
		34202,
		10,
		1094,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[34202011] = {
		34202011,
		0,
		Lang.get(86297),
		34202,
		11,
		1117,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[34202012] = {
		34202012,
		0,
		Lang.get(86298),
		34202,
		12,
		1094,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[34202013] = {
		34202013,
		0,
		Lang.get(86299),
		34202,
		13,
		1117,
		{
			RTResTalkAction[16],
			RTResTalkAction[18]
		}
	},
	[34010001] = {
		34010001,
		0,
		Lang.get(86300),
		34010,
		1,
		1093,
		nil,
		1,
		nil,
		nil,
		nil,
		113,
		34100,
		nil,
		nil,
		nil,
		nil,
		nil,
		34100
	},
	[34010002] = {
		34010002,
		0,
		Lang.get(86301),
		34010,
		2,
		1093,
		nil,
		1
	},
	[34010003] = {
		34010003,
		0,
		Lang.get(86302),
		34010,
		3,
		1094,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		34101,
		[19] = 34101
	},
	[34010004] = {
		34010004,
		0,
		Lang.get(86303),
		34010,
		4,
		1117,
		nil,
		1
	},
	[34010005] = {
		34010005,
		0,
		Lang.get(86304),
		34010,
		5,
		1093,
		{
			RTResTalkAction[25]
		},
		nil,
		nil,
		3
	},
	[34010006] = {
		34010006,
		0,
		Lang.get(86305),
		34010,
		6,
		1117,
		{
			RTResTalkAction[28],
			RTResTalkAction[17]
		}
	},
	[34010007] = {
		34010007,
		0,
		Lang.get(86306),
		34010,
		7,
		1094,
		{
			RTResTalkAction[28],
			RTResTalkAction[57],
			RTResTalkAction[3]
		}
	},
	[34010008] = {
		34010008,
		0,
		Lang.get(86307),
		34010,
		8,
		1093,
		{
			RTResTalkAction[33],
			RTResTalkAction[7]
		}
	},
	[34010009] = {
		34010009,
		0,
		Lang.get(86308),
		34010,
		9,
		1093,
		{
			RTResTalkAction[58]
		}
	},
	[34010010] = {
		34010010,
		0,
		Lang.get(86309),
		34010,
		10,
		1117,
		{
			RTResTalkAction[26]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		34102,
		[19] = 34102
	},
	[34010011] = {
		34010011,
		0,
		Lang.get(86310),
		34010,
		11,
		1094,
		nil,
		1
	},
	[34010012] = {
		34010012,
		0,
		Lang.get(86311),
		34010,
		12,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		34103,
		[19] = 34103
	},
	[34010013] = {
		34010013,
		0,
		Lang.get(86312),
		34010,
		13,
		300
	},
	[34010014] = {
		34010014,
		0,
		Lang.get(86313),
		34010,
		14,
		1093,
		{
			RTResTalkAction[33]
		},
		nil,
		nil,
		3
	},
	[34010015] = {
		34010015,
		4,
		nil,
		34010,
		15,
		1093,
		{
			RTResTalkAction[33]
		},
		[29] = {
			{
				id = 34010016,
				branch_content = Lang.get(86314)
			},
			{
				id = 34010016,
				branch_content = Lang.get(86315)
			}
		}
	},
	[34010016] = {
		34010016,
		0,
		Lang.get(86316),
		34010,
		16,
		1093,
		{
			RTResTalkAction[33]
		}
	},
	[34010017] = {
		34010017,
		3,
		Lang.get(86317),
		34010,
		17,
		605,
		{
			RTResTalkAction[33]
		},
		[22] = 1
	},
	[34010018] = {
		34010018,
		0,
		Lang.get(86318),
		34010,
		18,
		300,
		{
			RTResTalkAction[33]
		}
	},
	[34010019] = {
		34010019,
		0,
		Lang.get(86319),
		34010,
		19,
		300,
		{
			RTResTalkAction[33]
		}
	},
	[34010020] = {
		34010020,
		0,
		Lang.get(86320),
		34010,
		20,
		1093,
		{
			RTResTalkAction[33]
		}
	},
	[34011001] = {
		34011001,
		0,
		Lang.get(86321),
		34011,
		1,
		1094,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		34110,
		nil,
		nil,
		nil,
		nil,
		nil,
		34110
	},
	[34011002] = {
		34011002,
		0,
		Lang.get(86322),
		34011,
		2,
		1095,
		nil,
		1
	},
	[34011003] = {
		34011003,
		0,
		Lang.get(86323),
		34011,
		3,
		1095,
		nil,
		1
	},
	[34011004] = {
		34011004,
		0,
		Lang.get(86324),
		34011,
		4,
		141,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		34111,
		[19] = 34111
	},
	[34011005] = {
		34011005,
		0,
		Lang.get(86325),
		34011,
		5,
		141,
		nil,
		1
	},
	[34011006] = {
		34011006,
		0,
		Lang.get(21323),
		34011,
		6,
		1094,
		{
			RTResTalkAction[5]
		}
	},
	[34011007] = {
		34011007,
		0,
		Lang.get(86326),
		34011,
		7,
		141,
		{
			RTResTalkAction[59],
			RTResTalkAction[7]
		}
	},
	[34011008] = {
		34011008,
		0,
		Lang.get(86327),
		34011,
		8,
		141,
		{
			RTResTalkAction[59]
		}
	},
	[34011009] = {
		34011009,
		0,
		Lang.get(86328),
		34011,
		9,
		141,
		{
			RTResTalkAction[59]
		}
	},
	[34011010] = {
		34011010,
		0,
		Lang.get(86329),
		34011,
		10,
		1094,
		{
			RTResTalkAction[16],
			RTResTalkAction[60]
		}
	},
	[34011011] = {
		34011011,
		3,
		Lang.get(85710),
		34011,
		11,
		605,
		{
			RTResTalkAction[7],
			RTResTalkAction[61]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		34112,
		nil,
		1,
		[19] = 34112,
		[22] = 1
	},
	[34011012] = {
		34011012,
		0,
		Lang.get(86330),
		34011,
		12,
		107,
		nil,
		1
	},
	[34011013] = {
		34011013,
		0,
		Lang.get(86331),
		34011,
		13,
		225,
		{
			RTResTalkAction[62]
		},
		nil,
		nil,
		3
	},
	[34011014] = {
		34011014,
		0,
		Lang.get(86332),
		34011,
		14,
		196,
		{
			RTResTalkAction[63],
			RTResTalkAction[64]
		}
	},
	[34011015] = {
		34011015,
		0,
		Lang.get(86333),
		34011,
		15,
		386,
		{
			RTResTalkAction[65],
			RTResTalkAction[66]
		}
	},
	[34011016] = {
		34011016,
		0,
		Lang.get(86334),
		34011,
		16,
		1095,
		{
			RTResTalkAction[67],
			RTResTalkAction[68]
		}
	},
	[34012001] = {
		34012001,
		0,
		Lang.get(86335),
		34012,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		172,
		34120,
		nil,
		nil,
		nil,
		nil,
		nil,
		34120
	},
	[34012002] = {
		34012002,
		0,
		Lang.get(86336),
		34012,
		2,
		196,
		nil,
		1
	},
	[34012003] = {
		34012003,
		0,
		Lang.get(86337),
		34012,
		3,
		196,
		nil,
		1
	},
	[34012004] = {
		34012004,
		0,
		Lang.get(86338),
		34012,
		4,
		196,
		nil,
		1
	},
	[34012005] = {
		34012005,
		0,
		Lang.get(86339),
		34012,
		5,
		1093,
		nil,
		1
	},
	[34012006] = {
		34012006,
		0,
		Lang.get(86340),
		34012,
		6,
		1093,
		nil,
		1
	},
	[34012007] = {
		34012007,
		0,
		Lang.get(86341),
		34012,
		7,
		196,
		nil,
		1
	},
	[34012008] = {
		34012008,
		0,
		Lang.get(86342),
		34012,
		8,
		1095,
		nil,
		1
	},
	[34012009] = {
		34012009,
		0,
		Lang.get(86343),
		34012,
		9,
		107,
		nil,
		1
	},
	[34012010] = {
		34012010,
		0,
		Lang.get(86344),
		34012,
		10,
		225,
		nil,
		1
	},
	[34012011] = {
		34012011,
		0,
		Lang.get(86345),
		34012,
		11,
		1093,
		nil,
		1
	},
	[34012012] = {
		34012012,
		0,
		Lang.get(86346),
		34012,
		12,
		225,
		nil,
		1
	},
	[34012013] = {
		34012013,
		0,
		Lang.get(86347),
		34012,
		13,
		386,
		nil,
		1
	},
	[34012014] = {
		34012014,
		0,
		Lang.get(86348),
		34012,
		14,
		1093,
		nil,
		1
	},
	[34012015] = {
		34012015,
		0,
		Lang.get(86349),
		34012,
		15,
		225,
		nil,
		1
	},
	[34012016] = {
		34012016,
		3,
		Lang.get(85710),
		34012,
		16,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		34121,
		[19] = 34121,
		[22] = 1
	},
	[34012017] = {
		34012017,
		0,
		Lang.get(86350),
		34012,
		17,
		107,
		nil,
		1
	},
	[34012018] = {
		34012018,
		0,
		Lang.get(86351),
		34012,
		18,
		386,
		{
			RTResTalkAction[65]
		},
		nil,
		nil,
		3
	},
	[34012019] = {
		34012019,
		0,
		Lang.get(86352),
		34012,
		19,
		386,
		{
			RTResTalkAction[69]
		}
	},
	[34012020] = {
		34012020,
		0,
		Lang.get(86353),
		34012,
		20,
		107,
		{
			RTResTalkAction[32],
			RTResTalkAction[68]
		}
	},
	[34012021] = {
		34012021,
		0,
		Lang.get(86354),
		34012,
		21,
		386,
		{
			RTResTalkAction[65],
			RTResTalkAction[34]
		}
	},
	[34013001] = {
		34013001,
		0,
		Lang.get(86355),
		34013,
		1,
		225,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		34130,
		nil,
		nil,
		nil,
		nil,
		nil,
		34130
	},
	[34013002] = {
		34013002,
		0,
		Lang.get(86356),
		34013,
		2,
		1103,
		nil,
		1
	},
	[34013003] = {
		34013003,
		0,
		Lang.get(86357),
		34013,
		3,
		196,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		34131,
		[19] = 34131
	},
	[34013004] = {
		34013004,
		0,
		Lang.get(86358),
		34013,
		4,
		1106,
		nil,
		1
	},
	[34013005] = {
		34013005,
		0,
		Lang.get(86359),
		34013,
		5,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		34132,
		[19] = 34132
	},
	[34013006] = {
		34013006,
		0,
		Lang.get(86360),
		34013,
		6,
		1107,
		nil,
		1
	},
	[34013007] = {
		34013007,
		0,
		Lang.get(86361),
		34013,
		7,
		1108,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		34133,
		[19] = 34133
	},
	[34013008] = {
		34013008,
		0,
		Lang.get(86362),
		34013,
		8,
		1108,
		nil,
		1
	},
	[34203001] = {
		34203001,
		0,
		Lang.get(86363),
		34203,
		1,
		1108,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		34203,
		nil,
		nil,
		nil,
		nil,
		nil,
		34203
	},
	[34203002] = {
		34203002,
		0,
		Lang.get(86364),
		34203,
		2,
		225,
		nil,
		1
	},
	[34203003] = {
		34203003,
		0,
		Lang.get(86365),
		34203,
		3,
		386,
		{
			RTResTalkAction[70]
		},
		nil,
		nil,
		3
	},
	[34203004] = {
		34203004,
		0,
		Lang.get(86366),
		34203,
		4,
		1094,
		{
			RTResTalkAction[68]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		34134,
		nil,
		1,
		nil,
		nil,
		nil,
		34134
	},
	[34203005] = {
		34203005,
		0,
		Lang.get(86367),
		34203,
		5,
		386,
		{
			RTResTalkAction[71]
		},
		nil,
		nil,
		3
	},
	[34203006] = {
		34203006,
		0,
		Lang.get(86368),
		34203,
		6,
		1094,
		{
			RTResTalkAction[5],
			RTResTalkAction[68]
		}
	},
	[34203007] = {
		34203007,
		0,
		Lang.get(86369),
		34203,
		7,
		386,
		{
			RTResTalkAction[69],
			RTResTalkAction[7]
		}
	},
	[34203008] = {
		34203008,
		0,
		Lang.get(86370),
		34203,
		8,
		386,
		{
			RTResTalkAction[65]
		}
	},
	[34203009] = {
		34203009,
		0,
		Lang.get(86371),
		34203,
		9,
		107,
		{
			RTResTalkAction[72],
			RTResTalkAction[68]
		}
	},
	[34203010] = {
		34203010,
		0,
		Lang.get(86372),
		34203,
		10,
		196,
		{
			RTResTalkAction[63],
			RTResTalkAction[34]
		}
	},
	[34203011] = {
		34203011,
		0,
		Lang.get(86373),
		34203,
		11,
		225,
		{
			RTResTalkAction[62],
			RTResTalkAction[66]
		}
	},
	[34203012] = {
		34203012,
		0,
		Lang.get(86374),
		34203,
		12,
		1095,
		{
			RTResTalkAction[67],
			RTResTalkAction[64]
		}
	},
	[34203013] = {
		34203013,
		0,
		Lang.get(86375),
		34203,
		13,
		1094,
		{
			RTResTalkAction[5],
			RTResTalkAction[55]
		}
	},
	[34203014] = {
		34203014,
		0,
		Lang.get(86376),
		34203,
		14,
		1117,
		{
			RTResTalkAction[73],
			RTResTalkAction[7]
		}
	},
	[34203015] = {
		34203015,
		0,
		Lang.get(86377),
		34203,
		15,
		386,
		{
			RTResTalkAction[69],
			RTResTalkAction[3]
		}
	},
	[34203016] = {
		34203016,
		0,
		Lang.get(86378),
		34203,
		16,
		1108,
		{
			RTResTalkAction[74],
			RTResTalkAction[68]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		34136,
		nil,
		1,
		nil,
		nil,
		nil,
		34136,
		nil,
		802
	},
	[34203017] = {
		34203017,
		0,
		Lang.get(86379),
		34203,
		17,
		1026,
		{
			RTResTalkAction[74]
		},
		1,
		nil,
		3,
		[21] = 802
	},
	[34203018] = {
		34203018,
		0,
		Lang.get(86380),
		34203,
		18,
		1093,
		{
			RTResTalkAction[74]
		},
		1,
		[21] = 802
	},
	[34014001] = {
		34014001,
		0,
		Lang.get(86381),
		34014,
		1,
		1094,
		nil,
		1,
		nil,
		nil,
		nil,
		58,
		34140,
		nil,
		nil,
		nil,
		nil,
		nil,
		34140
	},
	[34014002] = {
		34014002,
		0,
		Lang.get(86382),
		34014,
		2,
		1093,
		nil,
		1
	},
	[34014003] = {
		34014003,
		0,
		Lang.get(86383),
		34014,
		3,
		1094,
		{
			RTResTalkAction[75]
		},
		nil,
		nil,
		3
	},
	[34014004] = {
		34014004,
		0,
		Lang.get(86384),
		34014,
		4,
		1117,
		{
			RTResTalkAction[1],
			RTResTalkAction[7]
		}
	},
	[34014005] = {
		34014005,
		0,
		Lang.get(86385),
		34014,
		5,
		1117,
		{
			RTResTalkAction[1]
		}
	},
	[34014006] = {
		34014006,
		0,
		Lang.get(86386),
		34014,
		6,
		1093,
		{
			RTResTalkAction[76],
			RTResTalkAction[3]
		}
	},
	[34014007] = {
		34014007,
		0,
		Lang.get(86387),
		34014,
		7,
		1093,
		{
			RTResTalkAction[33]
		}
	},
	[34014008] = {
		34014008,
		0,
		Lang.get(86388),
		34014,
		8,
		1093,
		{
			RTResTalkAction[33]
		}
	},
	[34014009] = {
		34014009,
		0,
		Lang.get(86389),
		34014,
		9,
		1093,
		{
			RTResTalkAction[25]
		}
	},
	[34014010] = {
		34014010,
		0,
		Lang.get(86390),
		34014,
		10,
		1093,
		{
			RTResTalkAction[33]
		}
	},
	[34014011] = {
		34014011,
		0,
		Lang.get(86391),
		34014,
		11,
		1094,
		{
			RTResTalkAction[5],
			RTResTalkAction[26]
		}
	},
	[34014012] = {
		34014012,
		0,
		Lang.get(86392),
		34014,
		12,
		1094,
		{
			RTResTalkAction[5]
		}
	},
	[34014013] = {
		34014013,
		0,
		Lang.get(86393),
		34014,
		13,
		1117,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[34014014] = {
		34014014,
		0,
		Lang.get(86394),
		34014,
		14,
		1093,
		{
			RTResTalkAction[28],
			RTResTalkAction[17],
			RTResTalkAction[7]
		}
	},
	[34014015] = {
		34014015,
		0,
		Lang.get(86395),
		34014,
		15,
		1117,
		{
			RTResTalkAction[77],
			RTResTalkAction[26]
		}
	},
	[34014016] = {
		34014016,
		3,
		Lang.get(86396),
		34014,
		16,
		605,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		34141,
		nil,
		1,
		[19] = 34141,
		[22] = 1
	},
	[34014017] = {
		34014017,
		0,
		Lang.get(86397),
		34014,
		17,
		1026,
		nil,
		1
	},
	[34014018] = {
		34014018,
		0,
		Lang.get(86398),
		34014,
		18,
		1026,
		nil,
		1
	},
	[34014019] = {
		34014019,
		0,
		Lang.get(86399),
		34014,
		19,
		1026,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		3
	},
	[34014020] = {
		34014020,
		0,
		Lang.get(86400),
		34014,
		20,
		300,
		{
			RTResTalkAction[21]
		}
	},
	[34014021] = {
		34014021,
		0,
		Lang.get(86401),
		34014,
		21,
		300
	},
	[34014022] = {
		34014022,
		0,
		Lang.get(86402),
		34014,
		22,
		300
	},
	[34015001] = {
		34015001,
		0,
		Lang.get(86403),
		34015,
		1,
		1093,
		nil,
		1,
		nil,
		nil,
		nil,
		159,
		34150,
		nil,
		nil,
		nil,
		nil,
		nil,
		34150
	},
	[34015002] = {
		34015002,
		0,
		Lang.get(86404),
		34015,
		2,
		1093,
		nil,
		1
	},
	[34015003] = {
		34015003,
		0,
		Lang.get(86405),
		34015,
		3,
		1099,
		{
			RTResTalkAction[23]
		},
		1,
		3,
		5,
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
		804
	},
	[34015004] = {
		34015004,
		0,
		Lang.get(86406),
		34015,
		4,
		1099,
		{
			RTResTalkAction[23]
		},
		1,
		3,
		[21] = 804
	},
	[34015005] = {
		34015005,
		0,
		Lang.get(86407),
		34015,
		5,
		1099,
		{
			RTResTalkAction[23]
		},
		1,
		3,
		[21] = 804
	},
	[34015006] = {
		34015006,
		0,
		Lang.get(86408),
		34015,
		6,
		1115,
		{
			RTResTalkAction[24]
		},
		1,
		0,
		nil,
		nil,
		nil,
		34151,
		nil,
		nil,
		nil,
		nil,
		nil,
		34151
	},
	[34015007] = {
		34015007,
		0,
		Lang.get(86409),
		34015,
		7,
		1115,
		nil,
		1
	},
	[34015008] = {
		34015008,
		0,
		Lang.get(86410),
		34015,
		8,
		1093,
		{
			RTResTalkAction[33]
		}
	},
	[34015009] = {
		34015009,
		0,
		Lang.get(86411),
		34015,
		9,
		1098,
		{
			RTResTalkAction[78],
			RTResTalkAction[26]
		}
	},
	[34015010] = {
		34015010,
		0,
		Lang.get(86412),
		34015,
		10,
		1098,
		{
			RTResTalkAction[79]
		}
	},
	[34016001] = {
		34016001,
		0,
		Lang.get(86413),
		34016,
		1,
		1093,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		34160,
		nil,
		nil,
		nil,
		nil,
		nil,
		34160
	},
	[34016002] = {
		34016002,
		0,
		Lang.get(86414),
		34016,
		2,
		1109,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		34161,
		[19] = 34161
	},
	[34016003] = {
		34016003,
		0,
		Lang.get(86415),
		34016,
		3,
		1093,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		34162,
		[19] = 34162
	},
	[34016004] = {
		34016004,
		0,
		Lang.get(86416),
		34016,
		4,
		1109,
		{
			RTResTalkAction[80]
		},
		nil,
		nil,
		3
	},
	[34016005] = {
		34016005,
		0,
		Lang.get(86417),
		34016,
		5,
		1093,
		{
			RTResTalkAction[28],
			RTResTalkAction[81]
		}
	},
	[34016006] = {
		34016006,
		0,
		Lang.get(86418),
		34016,
		6,
		1109,
		{
			RTResTalkAction[28],
			RTResTalkAction[81]
		}
	},
	[34016007] = {
		34016007,
		3,
		Lang.get(86419),
		34016,
		7,
		605,
		{
			RTResTalkAction[26],
			RTResTalkAction[82]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		34163,
		nil,
		1,
		[19] = 34163,
		[22] = 1
	},
	[34016008] = {
		34016008,
		0,
		Lang.get(86420),
		34016,
		8,
		1109,
		nil,
		1
	},
	[34016009] = {
		34016009,
		0,
		Lang.get(86421),
		34016,
		9,
		1111,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		34164,
		[19] = 34164
	},
	[34016010] = {
		34016010,
		0,
		Lang.get(86422),
		34016,
		10,
		1110,
		{
			RTResTalkAction[83]
		},
		nil,
		nil,
		3
	},
	[34016011] = {
		34016011,
		0,
		Lang.get(86423),
		34016,
		11,
		1111,
		{
			RTResTalkAction[84],
			RTResTalkAction[85]
		}
	},
	[34016012] = {
		34016012,
		0,
		Lang.get(86424),
		34016,
		12,
		1111,
		{
			RTResTalkAction[84],
			RTResTalkAction[86]
		}
	},
	[34016013] = {
		34016013,
		0,
		Lang.get(86425),
		34016,
		13,
		1110,
		{
			RTResTalkAction[87],
			RTResTalkAction[86]
		}
	},
	[34016014] = {
		34016014,
		0,
		Lang.get(86426),
		34016,
		14,
		1111,
		{
			RTResTalkAction[84],
			RTResTalkAction[88]
		}
	},
	[34016015] = {
		34016015,
		0,
		Lang.get(86427),
		34016,
		15,
		1111,
		{
			RTResTalkAction[89],
			RTResTalkAction[90]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		34165,
		[19] = 34165
	},
	[34016016] = {
		34016016,
		0,
		Lang.get(86428),
		34016,
		16,
		1109,
		{
			RTResTalkAction[91]
		},
		nil,
		nil,
		3
	},
	[34016017] = {
		34016017,
		0,
		Lang.get(86429),
		34016,
		17,
		1093,
		{
			RTResTalkAction[43],
			RTResTalkAction[82]
		}
	},
	[34017001] = {
		34017001,
		3,
		Lang.get(86430),
		34017,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		59,
		34170,
		[19] = 34170,
		[22] = 1
	},
	[34017002] = {
		34017002,
		0,
		Lang.get(86431),
		34017,
		2,
		1093,
		nil,
		1
	},
	[34017003] = {
		34017003,
		0,
		Lang.get(86432),
		34017,
		3,
		1112,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		34171,
		[19] = 34171
	},
	[34017004] = {
		34017004,
		0,
		Lang.get(86433),
		34017,
		4,
		1112,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		34172,
		[19] = 34172,
		[17] = 0
	},
	[34017005] = {
		34017005,
		0,
		Lang.get(86434),
		34017,
		5,
		1105,
		{
			RTResTalkAction[92]
		}
	},
	[34017006] = {
		34017006,
		0,
		Lang.get(86435),
		34017,
		6,
		1112,
		{
			RTResTalkAction[93],
			RTResTalkAction[94]
		}
	},
	[34017007] = {
		34017007,
		0,
		Lang.get(86436),
		34017,
		7,
		1105,
		{
			RTResTalkAction[95],
			RTResTalkAction[96]
		}
	},
	[34017008] = {
		34017008,
		0,
		Lang.get(86437),
		34017,
		8,
		1112,
		{
			RTResTalkAction[95],
			RTResTalkAction[94]
		}
	},
	[34017009] = {
		34017009,
		0,
		Lang.get(86438),
		34017,
		9,
		1105,
		{
			RTResTalkAction[95],
			RTResTalkAction[97]
		}
	},
	[34017010] = {
		34017010,
		0,
		Lang.get(86439),
		34017,
		10,
		1112,
		{
			RTResTalkAction[98],
			RTResTalkAction[94]
		}
	},
	[34017011] = {
		34017011,
		0,
		Lang.get(86440),
		34017,
		11,
		1093,
		{
			RTResTalkAction[99],
			RTResTalkAction[100]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		34173,
		[19] = 34173
	},
	[34017012] = {
		34017012,
		0,
		Lang.get(86441),
		34017,
		12,
		1105,
		{
			RTResTalkAction[92]
		},
		nil,
		nil,
		3
	},
	[34204001] = {
		34204001,
		0,
		Lang.get(86442),
		34204,
		1,
		1112,
		nil,
		1,
		nil,
		nil,
		nil,
		59,
		34204,
		nil,
		nil,
		nil,
		nil,
		nil,
		34204
	},
	[34204002] = {
		34204002,
		0,
		Lang.get(86443),
		34204,
		2,
		1105,
		nil,
		1
	},
	[34204003] = {
		34204003,
		0,
		Lang.get(86444),
		34204,
		3,
		1093,
		nil,
		1
	},
	[34204004] = {
		34204004,
		0,
		Lang.get(86445),
		34204,
		4,
		1116,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		34174,
		[19] = 34174,
		[17] = 0
	},
	[34204005] = {
		34204005,
		2,
		Lang.get(86446),
		34204,
		5,
		1105,
		nil,
		1
	},
	[34018001] = {
		34018001,
		0,
		Lang.get(86447),
		34018,
		1,
		1093,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		34180,
		nil,
		nil,
		nil,
		nil,
		nil,
		34180
	},
	[34018002] = {
		34018002,
		0,
		Lang.get(86448),
		34018,
		2,
		1098,
		nil,
		1
	},
	[34018003] = {
		34018003,
		0,
		Lang.get(86449),
		34018,
		3,
		1093,
		{
			RTResTalkAction[33]
		},
		nil,
		nil,
		3
	},
	[34018004] = {
		34018004,
		0,
		Lang.get(86450),
		34018,
		4,
		1098,
		{
			RTResTalkAction[101],
			RTResTalkAction[26]
		}
	},
	[34018005] = {
		34018005,
		3,
		Lang.get(85710),
		34018,
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
		34181,
		nil,
		1,
		[19] = 34181,
		[22] = 1
	},
	[34018006] = {
		34018006,
		0,
		Lang.get(86451),
		34018,
		6,
		1098,
		nil,
		1
	},
	[34018007] = {
		34018007,
		0,
		Lang.get(86452),
		34018,
		7,
		1093,
		nil,
		1
	},
	[34018008] = {
		34018008,
		0,
		Lang.get(86600),
		34018,
		8,
		1098,
		{
			RTResTalkAction[79]
		}
	},
	[34018009] = {
		34018009,
		0,
		Lang.get(86454),
		34018,
		9,
		1093,
		{
			RTResTalkAction[102],
			RTResTalkAction[22]
		}
	},
	[34018010] = {
		34018010,
		0,
		Lang.get(86455),
		34018,
		10,
		1098,
		{
			RTResTalkAction[103],
			RTResTalkAction[26]
		}
	},
	[34018011] = {
		34018011,
		0,
		Lang.get(86456),
		34018,
		11,
		1098,
		{
			RTResTalkAction[20]
		}
	},
	[34018012] = {
		34018012,
		0,
		Lang.get(86457),
		34018,
		12,
		1098,
		{
			RTResTalkAction[101]
		}
	},
	[34018013] = {
		34018013,
		0,
		Lang.get(86458),
		34018,
		13,
		1098,
		{
			RTResTalkAction[101]
		}
	},
	[34018014] = {
		34018014,
		0,
		Lang.get(86459),
		34018,
		14,
		1111,
		{
			RTResTalkAction[104],
			RTResTalkAction[22]
		}
	},
	[34018015] = {
		34018015,
		0,
		Lang.get(86460),
		34018,
		15,
		1098,
		{
			RTResTalkAction[90]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		34182,
		nil,
		1,
		nil,
		nil,
		nil,
		34182
	},
	[34018016] = {
		34018016,
		0,
		Lang.get(86461),
		34018,
		16,
		1112,
		{
			RTResTalkAction[105]
		},
		nil,
		nil,
		3
	},
	[34018017] = {
		34018017,
		0,
		Lang.get(86462),
		34018,
		17,
		1098,
		{
			RTResTalkAction[93],
			RTResTalkAction[106]
		}
	},
	[34018018] = {
		34018018,
		0,
		Lang.get(86463),
		34018,
		18,
		1110,
		{
			RTResTalkAction[84],
			RTResTalkAction[106],
			RTResTalkAction[99]
		}
	},
	[34019001] = {
		34019001,
		3,
		Lang.get(86464),
		34019,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		192,
		34190,
		[19] = 34190,
		[22] = 1
	},
	[34019002] = {
		34019002,
		0,
		Lang.get(86465),
		34019,
		2,
		1117,
		nil,
		1
	},
	[34019003] = {
		34019003,
		0,
		Lang.get(86466),
		34019,
		3,
		1094,
		nil,
		1
	},
	[34019004] = {
		34019004,
		0,
		Lang.get(86467),
		34019,
		4,
		1093,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		34191,
		[19] = 34191
	},
	[34019005] = {
		34019005,
		0,
		Lang.get(86468),
		34019,
		5,
		300
	},
	[34019006] = {
		34019006,
		0,
		Lang.get(86469),
		34019,
		6,
		1093,
		{
			RTResTalkAction[33]
		},
		nil,
		nil,
		3
	},
	[34019007] = {
		34019007,
		0,
		Lang.get(86470),
		34019,
		7,
		300,
		{
			RTResTalkAction[33]
		}
	},
	[34019008] = {
		34019008,
		0,
		Lang.get(86471),
		34019,
		8,
		1093,
		{
			RTResTalkAction[33]
		}
	},
	[34019009] = {
		34019009,
		0,
		Lang.get(86472),
		34019,
		9,
		1093,
		{
			RTResTalkAction[33]
		}
	},
	[34019010] = {
		34019010,
		0,
		Lang.get(86473),
		34019,
		10,
		1093,
		{
			RTResTalkAction[33]
		}
	},
	[34019011] = {
		34019011,
		0,
		Lang.get(86474),
		34019,
		11,
		300,
		{
			RTResTalkAction[33]
		}
	},
	[34019012] = {
		34019012,
		0,
		Lang.get(86475),
		34019,
		12,
		300,
		{
			RTResTalkAction[33]
		}
	},
	[34019013] = {
		34019013,
		0,
		"……",
		34019,
		13,
		1093,
		{
			RTResTalkAction[33]
		}
	},
	[34019014] = {
		34019014,
		0,
		Lang.get(86476),
		34019,
		14,
		300,
		{
			RTResTalkAction[33]
		}
	},
	[34019015] = {
		34019015,
		0,
		Lang.get(86477),
		34019,
		15,
		1093,
		{
			RTResTalkAction[33]
		}
	},
	[34019016] = {
		34019016,
		0,
		Lang.get(86478),
		34019,
		16,
		1093,
		{
			RTResTalkAction[33]
		}
	},
	[34019017] = {
		34019017,
		0,
		Lang.get(86479),
		34019,
		17,
		300,
		{
			RTResTalkAction[33]
		}
	},
	[34019018] = {
		34019018,
		0,
		Lang.get(86480),
		34019,
		18,
		300,
		{
			RTResTalkAction[33]
		}
	},
	[34019019] = {
		34019019,
		0,
		Lang.get(86481),
		34019,
		19,
		1093,
		{
			RTResTalkAction[33]
		}
	},
	[34019020] = {
		34019020,
		4,
		nil,
		34019,
		20,
		1093,
		{
			RTResTalkAction[33]
		},
		[29] = {
			{
				id = 34019021,
				branch_content = Lang.get(86482)
			},
			{
				id = 34019021,
				branch_content = Lang.get(86483)
			}
		}
	},
	[34019021] = {
		34019021,
		0,
		Lang.get(86484),
		34019,
		21,
		1093,
		{
			RTResTalkAction[26]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		34192,
		nil,
		1,
		nil,
		nil,
		nil,
		34192
	},
	[34019022] = {
		34019022,
		0,
		Lang.get(86485),
		34019,
		22,
		1093,
		{
			RTResTalkAction[33]
		},
		nil,
		nil,
		3
	},
	[34019023] = {
		34019023,
		0,
		Lang.get(86486),
		34019,
		23,
		1093,
		{
			RTResTalkAction[33]
		}
	},
	[34019024] = {
		34019024,
		0,
		Lang.get(86487),
		34019,
		24,
		1093,
		{
			RTResTalkAction[33]
		}
	},
	[34019025] = {
		34019025,
		0,
		Lang.get(86488),
		34019,
		25,
		1093,
		{
			RTResTalkAction[33]
		}
	},
	[34019026] = {
		34019026,
		4,
		nil,
		34019,
		26,
		1093,
		{
			RTResTalkAction[33]
		},
		[29] = {
			{
				id = 34019027,
				branch_content = Lang.get(86489)
			},
			{
				id = 34019027,
				branch_content = Lang.get(86490)
			}
		}
	},
	[34019027] = {
		34019027,
		0,
		Lang.get(86491),
		34019,
		27,
		1093,
		{
			RTResTalkAction[33]
		}
	},
	[34019028] = {
		34019028,
		0,
		Lang.get(86492),
		34019,
		28,
		1093,
		{
			RTResTalkAction[33]
		}
	},
	[34019029] = {
		34019029,
		0,
		Lang.get(86493),
		34019,
		29,
		1093,
		{
			RTResTalkAction[107]
		}
	},
	[34019030] = {
		34019030,
		0,
		Lang.get(86494),
		34019,
		30,
		1093,
		{
			RTResTalkAction[107]
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
