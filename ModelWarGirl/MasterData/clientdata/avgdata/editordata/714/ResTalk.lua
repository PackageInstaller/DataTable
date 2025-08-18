-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\714\\ResTalk.lua

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
	[1] = 1,
	[2] = 376
}
RTResTalkAction[2] = {
	[1] = 1,
	[2] = 365
}
RTResTalkAction[3] = {
	[1] = 0,
	[2] = 376
}
RTResTalkAction[4] = {
	1,
	365,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[5] = {
	1,
	365,
	nil,
	nil,
	3
}
RTResTalkAction[6] = {
	[1] = 0,
	[2] = 365
}
RTResTalkAction[7] = {
	[1] = 1,
	[2] = 151
}
RTResTalkAction[8] = {
	[1] = 1,
	[2] = 141
}
RTResTalkAction[9] = {
	[1] = 0,
	[2] = 151
}
RTResTalkAction[10] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[11] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[12] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[13] = {
	[1] = 1,
	[2] = 133
}
RTResTalkAction[14] = {
	[1] = 0,
	[2] = 133
}
RTResTalkAction[15] = {
	1,
	107,
	nil,
	nil,
	1
}
RTResTalkAction[16] = {
	1,
	141,
	nil,
	nil,
	0
}
RTResTalkAction[17] = {
	1,
	107,
	nil,
	nil,
	7
}
RTResTalkAction[18] = {
	[1] = 1,
	[2] = 538
}
RTResTalkAction[19] = {
	[1] = 1,
	[2] = 537
}
RTResTalkAction[20] = {
	[1] = 0,
	[2] = 538
}
RTResTalkAction[21] = {
	[1] = 0,
	[2] = 537
}
RTResTalkAction[22] = {
	[1] = 1,
	[2] = 147
}
RTResTalkAction[23] = {
	[1] = 0,
	[2] = 147
}
RTResTalkAction[24] = {
	[1] = 1,
	[2] = 148
}
RTResTalkAction[25] = {
	[1] = 2,
	[2] = 148
}
RTResTalkAction[26] = {
	3,
	112,
	nil,
	nil,
	1
}
RTResTalkAction[27] = {
	[1] = 3,
	[2] = 112
}
RTResTalkAction[28] = {
	3,
	112,
	nil,
	nil,
	3
}
RTResTalkAction[29] = {
	[1] = 1,
	[2] = 107,
	[3] = {
		10031
	}
}
RTResTalkAction[30] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[31] = {
	[1] = 3,
	[2] = 147,
	[3] = {
		1
	}
}
RTResTalkAction[32] = {
	1,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[33] = {
	1,
	107,
	{
		1
	},
	nil,
	5
}
RTResTalkAction[34] = {
	2,
	147,
	nil,
	nil,
	2
}
RTResTalkAction[35] = {
	[1] = 3,
	[2] = 141
}
RTResTalkAction[36] = {
	[1] = 2,
	[2] = 147
}
RTResTalkAction[37] = {
	[1] = 3,
	[2] = 141,
	[3] = {
		10012
	}
}
RTResTalkAction[38] = {
	[1] = 1,
	[2] = 164
}
RTResTalkAction[39] = {
	[1] = 2,
	[2] = 164
}
RTResTalkAction[40] = {
	[1] = 3,
	[2] = 123
}
RTResTalkAction[41] = {
	[1] = 3,
	[2] = 125
}
RTResTalkAction[42] = {
	[1] = 0,
	[2] = 123
}
RTResTalkAction[43] = {
	[1] = 0,
	[2] = 125
}
RTResTalkAction[44] = {
	[1] = 1,
	[2] = 125
}
RTResTalkAction[45] = {
	[1] = 0,
	[2] = 164
}
RTResTalkAction[46] = {
	1,
	107,
	{
		10011
	},
	nil,
	2
}
RTResTalkAction[47] = {
	1,
	107,
	nil,
	nil,
	3
}
RTResTalkAction[48] = {
	1,
	107,
	{
		10041
	},
	nil,
	4
}
RTResTalkAction[49] = {
	3,
	147,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[50] = {
	1,
	104,
	nil,
	nil,
	3
}
RTResTalkAction[51] = {
	[1] = 1,
	[2] = 104
}
RTResTalkAction[52] = {
	[1] = 0,
	[2] = 104
}
RTResTalkAction[53] = {
	[1] = 1,
	[2] = 542
}
RTResTalkAction[54] = {
	[1] = 1,
	[2] = 123
}
RTResTalkAction[55] = {
	[1] = 0,
	[2] = 542
}
RTResTalkAction[56] = {
	1,
	107,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[57] = {
	1,
	112,
	nil,
	nil,
	1
}
RTResTalkAction[58] = {
	[1] = 0,
	[2] = 112
}
RTResTalkAction[59] = {
	[1] = 1,
	[2] = 112
}
RTResTalkAction[60] = {
	[1] = 1,
	[2] = 302
}
RTResTalkAction[61] = {
	[1] = 0,
	[2] = 302
}
RTResTalkAction[62] = {
	[1] = 1,
	[2] = 117
}
RTResTalkAction[63] = {
	[1] = 0,
	[2] = 117
}
RTResTalkAction[64] = {
	1,
	302,
	nil,
	nil,
	0
}
RTResTalkAction[65] = {
	[1] = 1,
	[2] = 135
}
RTResTalkAction[66] = {
	[1] = 1,
	[2] = 110
}
RTResTalkAction[67] = {
	[1] = 0,
	[2] = 135
}
RTResTalkAction[68] = {
	[1] = 1,
	[2] = 103
}
RTResTalkAction[69] = {
	[1] = 0,
	[2] = 110
}
RTResTalkAction[70] = {
	[1] = 0,
	[2] = 103
}
RTResTalkAction[71] = {
	[1] = 1,
	[2] = 348
}
RTResTalkAction[72] = {
	[1] = 0,
	[2] = 348
}
RTResTalkAction[73] = {
	[1] = 1,
	[2] = 300
}
RTResTalkAction[74] = {
	1,
	107,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[75] = {
	[1] = 0,
	[2] = 300
}
RTResTalkAction[76] = {
	1,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[77] = {
	[1] = 1,
	[2] = 364
}
RTResTalkAction[78] = {
	[1] = 2,
	[2] = 364
}
RTResTalkAction[79] = {
	[1] = 3,
	[2] = 365
}
RTResTalkAction[80] = {
	[1] = 0,
	[2] = 364
}
RTResTalkAction[81] = {
	[1] = 1,
	[2] = 681
}
RTResTalkAction[82] = {
	[1] = 0,
	[2] = 681
}
RTResTalkAction[83] = {
	[1] = 1,
	[2] = 355
}
RTResTalkAction[84] = {
	[1] = 0,
	[2] = 355
}
RTResTalkAction[85] = {
	1,
	219,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[86] = {
	[1] = 1,
	[2] = 219
}
RTResTalkAction[87] = {
	[1] = 0,
	[2] = 219
}
RTResTalkAction[88] = {
	1,
	141,
	nil,
	nil,
	1
}
RTResTalkAction[89] = {
	1,
	219,
	nil,
	nil,
	8
}
RTResTalkAction[90] = {
	[1] = 1,
	[2] = 141,
	[3] = {
		1
	}
}
RTResTalkAction[91] = {
	[1] = 1,
	[2] = 12
}
RTResTalkAction[92] = {
	[1] = 2,
	[2] = 12
}
RTResTalkAction[93] = {
	[1] = 3,
	[2] = 16
}
RTResTalkAction[94] = {
	[1] = 4,
	[2] = 12
}
RTResTalkAction[95] = {
	[1] = 1,
	[2] = 123,
	[3] = {
		3
	}
}
RTResTalkAction[96] = {
	[1] = 5,
	[2] = 16
}
RTResTalkAction[97] = {
	[1] = 1,
	[2] = 188
}
RTResTalkAction[98] = {
	[1] = 0,
	[2] = 188
}

local Data = {
	[2200001] = {
		2200001,
		0,
		Lang.get(37686),
		2200,
		1,
		107,
		nil,
		1,
		6,
		nil,
		nil,
		62,
		2200,
		0.2,
		1,
		1,
		nil,
		2200
	},
	[2200002] = {
		2200002,
		0,
		Lang.get(37687),
		2200,
		2,
		141,
		nil,
		1,
		0
	},
	[2200003] = {
		2200003,
		0,
		Lang.get(42507),
		2200,
		3,
		141,
		nil,
		1
	},
	[2200004] = {
		2200004,
		0,
		Lang.get(18314),
		2200,
		4,
		141,
		nil,
		1
	},
	[2200005] = {
		2200005,
		0,
		Lang.get(37689),
		2200,
		5,
		151,
		nil,
		1
	},
	[2200006] = {
		2200006,
		0,
		Lang.get(42508),
		2200,
		6,
		133,
		nil,
		1
	},
	[2200007] = {
		2200007,
		13,
		nil,
		2200,
		7,
		376,
		{
			RTResTalkAction[1]
		},
		[19] = 220,
		[26] = 1
	},
	[2200008] = {
		2200008,
		13,
		Lang.get(37691),
		2200,
		8,
		365,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		},
		[26] = 3
	},
	[2200009] = {
		2200009,
		0,
		Lang.get(37692),
		2200,
		9,
		133,
		{
			RTResTalkAction[2]
		},
		1,
		[26] = 3
	},
	[2200010] = {
		2200010,
		13,
		Lang.get(51067),
		2200,
		10,
		365,
		{
			RTResTalkAction[4]
		},
		[26] = 3
	},
	[2200011] = {
		2200011,
		13,
		Lang.get(51068),
		2200,
		11,
		365,
		{
			RTResTalkAction[5]
		},
		[26] = 3
	},
	[2200012] = {
		2200012,
		13,
		Lang.get(42509),
		2200,
		12,
		365,
		{
			RTResTalkAction[2]
		},
		[26] = 3
	},
	[2200013] = {
		2200013,
		0,
		Lang.get(37695),
		2200,
		13,
		151,
		{
			RTResTalkAction[6]
		},
		1,
		[19] = -1
	},
	[2200014] = {
		2200014,
		0,
		Lang.get(37696),
		2200,
		14,
		3,
		nil,
		1,
		nil,
		nil,
		1070,
		nil,
		2250,
		0.2,
		1,
		1,
		nil,
		2250
	},
	[2200015] = {
		2200015,
		0,
		Lang.get(37697),
		2200,
		15,
		664,
		nil,
		1
	},
	[2200016] = {
		2200016,
		0,
		Lang.get(37698),
		2200,
		16,
		151,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3
	},
	[2200017] = {
		2200017,
		0,
		Lang.get(37699),
		2200,
		17,
		141,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[2200018] = {
		2200018,
		0,
		Lang.get(37700),
		2200,
		18,
		151,
		{
			RTResTalkAction[7],
			RTResTalkAction[10]
		}
	},
	[2200019] = {
		2200019,
		0,
		Lang.get(37701),
		2200,
		19,
		107,
		{
			RTResTalkAction[11],
			RTResTalkAction[9]
		}
	},
	[2200020] = {
		2200020,
		0,
		Lang.get(37702),
		2200,
		20,
		151,
		{
			RTResTalkAction[7],
			RTResTalkAction[12]
		}
	},
	[2200021] = {
		2200021,
		0,
		Lang.get(37703),
		2200,
		21,
		141,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[2200022] = {
		2200022,
		0,
		Lang.get(37704),
		2200,
		22,
		107,
		{
			RTResTalkAction[11],
			RTResTalkAction[10]
		}
	},
	[2200023] = {
		2200023,
		0,
		Lang.get(37705),
		2200,
		23,
		151,
		{
			RTResTalkAction[7],
			RTResTalkAction[12]
		}
	},
	[2200024] = {
		2200024,
		0,
		Lang.get(37706),
		2200,
		24,
		133,
		{
			RTResTalkAction[13],
			RTResTalkAction[9]
		}
	},
	[2200025] = {
		2200025,
		0,
		Lang.get(37707),
		2200,
		25,
		141,
		{
			RTResTalkAction[8],
			RTResTalkAction[14]
		}
	},
	[2200026] = {
		2200026,
		0,
		Lang.get(18322),
		2200,
		26,
		107,
		{
			RTResTalkAction[10]
		},
		1,
		nil,
		-1,
		nil,
		105,
		2201,
		0.2,
		1,
		1,
		nil,
		2201
	},
	[2200027] = {
		2200027,
		0,
		Lang.get(18323),
		2200,
		27,
		141,
		nil,
		1
	},
	[2200028] = {
		2200028,
		0,
		Lang.get(37708),
		2200,
		28,
		141,
		nil,
		1
	},
	[2200029] = {
		2200029,
		0,
		Lang.get(18325),
		2200,
		29,
		141,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3
	},
	[2200030] = {
		2200030,
		0,
		Lang.get(18327),
		2200,
		30,
		107,
		{
			RTResTalkAction[15],
			RTResTalkAction[10]
		}
	},
	[2200031] = {
		2200031,
		0,
		Lang.get(18328),
		2200,
		31,
		141,
		{
			RTResTalkAction[16],
			RTResTalkAction[12]
		}
	},
	[2200032] = {
		2200032,
		0,
		Lang.get(18329),
		2200,
		32,
		107,
		{
			RTResTalkAction[17],
			RTResTalkAction[10]
		}
	},
	[2200033] = {
		2200033,
		0,
		Lang.get(18330),
		2200,
		33,
		537,
		{
			RTResTalkAction[12]
		},
		1,
		nil,
		-1,
		nil,
		nil,
		2202,
		0.2,
		1,
		1,
		nil,
		2202
	},
	[2200034] = {
		2200034,
		0,
		Lang.get(18332),
		2200,
		34,
		147,
		nil,
		1
	},
	[2200035] = {
		2200035,
		7,
		"18",
		2200,
		35,
		147,
		nil,
		nil,
		nil,
		4,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[2200036] = {
		2200036,
		0,
		Lang.get(18334),
		2200,
		36,
		538,
		{
			RTResTalkAction[18]
		},
		nil,
		nil,
		3
	},
	[2200037] = {
		2200037,
		0,
		Lang.get(37709),
		2200,
		37,
		538,
		{
			RTResTalkAction[18]
		}
	},
	[2200038] = {
		2200038,
		0,
		Lang.get(37710),
		2200,
		38,
		537,
		{
			RTResTalkAction[19],
			RTResTalkAction[20]
		}
	},
	[2200039] = {
		2200039,
		0,
		Lang.get(37711),
		2200,
		39,
		538,
		{
			RTResTalkAction[18],
			RTResTalkAction[21]
		}
	},
	[2200040] = {
		2200040,
		5,
		Lang.get(18345),
		2200,
		40,
		537,
		{
			RTResTalkAction[20]
		},
		1,
		nil,
		-1,
		nil,
		nil,
		2203,
		nil,
		1,
		1,
		nil,
		2203
	},
	[2200041] = {
		2200041,
		5,
		Lang.get(18346),
		2200,
		41,
		538,
		nil,
		1
	},
	[2200042] = {
		2200042,
		0,
		"……",
		2200,
		42,
		147,
		nil,
		1
	},
	[2200043] = {
		2200043,
		5,
		"！！！",
		2200,
		43,
		537,
		nil,
		1
	},
	[2200044] = {
		2200044,
		5,
		Lang.get(18347),
		2200,
		44,
		538,
		{
			RTResTalkAction[18]
		},
		nil,
		nil,
		3
	},
	[2200045] = {
		2200045,
		0,
		Lang.get(18348),
		2200,
		45,
		537,
		{
			RTResTalkAction[19],
			RTResTalkAction[20]
		}
	},
	[2200046] = {
		2200046,
		0,
		Lang.get(18349),
		2200,
		46,
		538,
		{
			RTResTalkAction[18],
			RTResTalkAction[21]
		}
	},
	[2200047] = {
		2200047,
		0,
		Lang.get(18350),
		2200,
		47,
		537,
		{
			RTResTalkAction[19],
			RTResTalkAction[20]
		}
	},
	[2200048] = {
		2200048,
		0,
		Lang.get(37712),
		2200,
		48,
		538,
		{
			RTResTalkAction[18],
			RTResTalkAction[21]
		}
	},
	[2200049] = {
		2200049,
		0,
		Lang.get(18352),
		2200,
		49,
		538,
		{
			RTResTalkAction[18]
		}
	},
	[2200050] = {
		2200050,
		0,
		Lang.get(18353),
		2200,
		50,
		107,
		{
			RTResTalkAction[20]
		},
		1,
		nil,
		-1,
		nil,
		nil,
		2204,
		0.2,
		1,
		1,
		nil,
		2204
	},
	[2200051] = {
		2200051,
		0,
		Lang.get(18354),
		2200,
		51,
		141,
		nil,
		1
	},
	[2200052] = {
		2200052,
		0,
		Lang.get(18356),
		2200,
		52,
		107,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3
	},
	[2200053] = {
		2200053,
		0,
		Lang.get(18357),
		2200,
		53,
		147,
		{
			RTResTalkAction[12]
		},
		1,
		nil,
		-1,
		nil,
		nil,
		2205,
		0.2,
		1,
		1,
		nil,
		2205
	},
	[2200054] = {
		2200054,
		0,
		Lang.get(18358),
		2200,
		54,
		107,
		nil,
		1,
		nil,
		3
	},
	[2200055] = {
		2200055,
		0,
		Lang.get(18359),
		2200,
		55,
		147,
		{
			RTResTalkAction[22]
		}
	},
	[2200056] = {
		2200056,
		0,
		Lang.get(18360),
		2200,
		56,
		147,
		{
			RTResTalkAction[22]
		}
	},
	[2200057] = {
		2200057,
		0,
		Lang.get(18361),
		2200,
		57,
		107,
		{
			RTResTalkAction[11],
			RTResTalkAction[23]
		}
	},
	[2201001] = {
		2201001,
		0,
		Lang.get(37713),
		2201,
		1,
		350,
		nil,
		1,
		0,
		nil,
		nil,
		63,
		2206,
		0.2,
		1,
		1,
		nil,
		2206
	},
	[2201002] = {
		2201002,
		0,
		Lang.get(37714),
		2201,
		2,
		188,
		nil,
		1,
		4
	},
	[2201003] = {
		2201003,
		0,
		Lang.get(37715),
		2201,
		3,
		350,
		nil,
		1
	},
	[2201004] = {
		2201004,
		0,
		Lang.get(37716),
		2201,
		4,
		188,
		nil,
		1,
		0
	},
	[2201005] = {
		2201005,
		0,
		Lang.get(37717),
		2201,
		5,
		350,
		nil,
		1
	},
	[2201006] = {
		2201006,
		0,
		Lang.get(37718),
		2201,
		6,
		188,
		nil,
		1
	},
	[2201007] = {
		2201007,
		0,
		Lang.get(37719),
		2201,
		7,
		350,
		nil,
		1
	},
	[2201008] = {
		2201008,
		0,
		Lang.get(37720),
		2201,
		8,
		188,
		nil,
		1,
		4
	},
	[2201009] = {
		2201009,
		0,
		Lang.get(37721),
		2201,
		9,
		350,
		nil,
		1
	},
	[2201010] = {
		2201010,
		0,
		Lang.get(37722),
		2201,
		10,
		112,
		nil,
		1,
		1,
		nil,
		nil,
		57,
		2207,
		nil,
		nil,
		1,
		nil,
		2207
	},
	[2201011] = {
		2201011,
		0,
		Lang.get(37723),
		2201,
		11,
		112,
		nil,
		1,
		0
	},
	[2201012] = {
		2201012,
		0,
		Lang.get(37724),
		2201,
		12,
		148,
		{
			RTResTalkAction[24]
		},
		nil,
		nil,
		3
	},
	[2201013] = {
		2201013,
		0,
		Lang.get(37725),
		2201,
		13,
		112,
		{
			RTResTalkAction[25],
			RTResTalkAction[26]
		}
	},
	[2201014] = {
		2201014,
		0,
		Lang.get(37726),
		2201,
		14,
		148,
		{
			RTResTalkAction[25],
			RTResTalkAction[27]
		}
	},
	[2201015] = {
		2201015,
		0,
		Lang.get(37727),
		2201,
		15,
		112,
		{
			RTResTalkAction[25],
			RTResTalkAction[28]
		}
	},
	[2201016] = {
		2201016,
		0,
		Lang.get(37728),
		2201,
		16,
		148,
		{
			RTResTalkAction[25],
			RTResTalkAction[27]
		}
	},
	[2201017] = {
		2201017,
		0,
		Lang.get(37729),
		2201,
		17,
		148,
		{
			RTResTalkAction[25],
			RTResTalkAction[27]
		}
	},
	[2201018] = {
		2201018,
		0,
		Lang.get(37730),
		2201,
		18,
		112,
		{
			RTResTalkAction[25],
			RTResTalkAction[27]
		}
	},
	[2201019] = {
		2201019,
		0,
		Lang.get(37731),
		2201,
		19,
		112,
		{
			RTResTalkAction[25],
			RTResTalkAction[27]
		}
	},
	[2201020] = {
		2201020,
		0,
		Lang.get(37732),
		2201,
		20,
		112,
		{
			RTResTalkAction[25],
			RTResTalkAction[27]
		}
	},
	[2201021] = {
		2201021,
		0,
		Lang.get(37733),
		2201,
		21,
		148,
		{
			RTResTalkAction[25],
			RTResTalkAction[27]
		}
	},
	[2201022] = {
		2201022,
		0,
		Lang.get(37734),
		2201,
		22,
		112,
		{
			RTResTalkAction[25],
			RTResTalkAction[27]
		}
	},
	[2203001] = {
		2203001,
		0,
		Lang.get(18581),
		2203,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		2231,
		0.2,
		1,
		1,
		nil,
		2231
	},
	[2203002] = {
		2203002,
		0,
		Lang.get(18582),
		2203,
		2,
		141,
		nil,
		1
	},
	[2203003] = {
		2203003,
		0,
		Lang.get(18583),
		2203,
		3,
		147,
		nil,
		1
	},
	[2203004] = {
		2203004,
		0,
		Lang.get(18584),
		2203,
		4,
		107,
		nil,
		1
	},
	[2203005] = {
		2203005,
		0,
		Lang.get(18585),
		2203,
		5,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		2232,
		nil,
		nil,
		1,
		nil,
		2232
	},
	[2203006] = {
		2203006,
		0,
		Lang.get(18586),
		2203,
		6,
		147,
		nil,
		1
	},
	[2203007] = {
		2203007,
		0,
		Lang.get(37735),
		2203,
		7,
		107,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[2203008] = {
		2203008,
		0,
		Lang.get(18588),
		2203,
		8,
		147,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[2203009] = {
		2203009,
		0,
		Lang.get(50258),
		2203,
		9,
		107,
		{
			RTResTalkAction[11],
			RTResTalkAction[23]
		}
	},
	[2203010] = {
		2203010,
		4,
		nil,
		2203,
		10,
		107,
		{
			RTResTalkAction[11]
		},
		[27] = {
			{
				id = 2203011,
				branch_content = Lang.get(42510)
			}
		}
	},
	[2203011] = {
		2203011,
		0,
		Lang.get(50259),
		2203,
		11,
		107,
		{
			RTResTalkAction[32]
		}
	},
	[2203012] = {
		2203012,
		4,
		nil,
		2203,
		12,
		107,
		{
			RTResTalkAction[29]
		},
		[27] = {
			{
				id = 2203013,
				branch_content = Lang.get(42511)
			}
		}
	},
	[2203013] = {
		2203013,
		0,
		Lang.get(18591),
		2203,
		13,
		107,
		{
			RTResTalkAction[33]
		}
	},
	[2203014] = {
		2203014,
		0,
		Lang.get(18592),
		2203,
		14,
		147,
		{
			RTResTalkAction[34],
			RTResTalkAction[35],
			RTResTalkAction[12]
		}
	},
	[2203015] = {
		2203015,
		0,
		"…………",
		2203,
		15,
		141,
		{
			RTResTalkAction[36],
			RTResTalkAction[37]
		}
	},
	[2203016] = {
		2203016,
		0,
		Lang.get(18593),
		2203,
		16,
		141,
		{
			RTResTalkAction[36],
			RTResTalkAction[35]
		}
	},
	[2203017] = {
		2203017,
		0,
		Lang.get(18594),
		2203,
		17,
		147,
		{
			RTResTalkAction[36],
			RTResTalkAction[35]
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
	[2203018] = {
		2203018,
		0,
		Lang.get(37738),
		2203,
		18,
		350,
		{
			RTResTalkAction[23],
			RTResTalkAction[10]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		2209,
		nil,
		1,
		1,
		nil,
		2209
	},
	[2203019] = {
		2203019,
		0,
		Lang.get(37739),
		2203,
		19,
		188,
		nil,
		1
	},
	[2203020] = {
		2203020,
		0,
		Lang.get(37740),
		2203,
		20,
		350,
		nil,
		1
	},
	[2203021] = {
		2203021,
		0,
		Lang.get(37741),
		2203,
		21,
		350,
		nil,
		1
	},
	[2203022] = {
		2203022,
		0,
		Lang.get(46218),
		2203,
		22,
		188,
		nil,
		1
	},
	[2203023] = {
		2203023,
		0,
		Lang.get(37742),
		2203,
		23,
		164,
		nil,
		1,
		0
	},
	[2203024] = {
		2203024,
		0,
		Lang.get(37743),
		2203,
		24,
		188,
		nil,
		1
	},
	[2203025] = {
		2203025,
		0,
		Lang.get(37744),
		2203,
		25,
		164,
		nil,
		1
	},
	[2203026] = {
		2203026,
		0,
		Lang.get(37745),
		2203,
		26,
		350,
		nil,
		1
	},
	[2203027] = {
		2203027,
		0,
		Lang.get(37746),
		2203,
		27,
		350,
		nil,
		1
	},
	[2203028] = {
		2203028,
		0,
		"……",
		2203,
		28,
		164,
		nil,
		1
	},
	[2203029] = {
		2203029,
		0,
		Lang.get(37747),
		2203,
		29,
		164,
		{
			RTResTalkAction[38]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		2244,
		nil,
		1,
		nil,
		nil,
		2244
	},
	[2203030] = {
		2203030,
		0,
		Lang.get(42512),
		2203,
		30,
		123,
		{
			RTResTalkAction[39],
			RTResTalkAction[40]
		}
	},
	[2203031] = {
		2203031,
		0,
		Lang.get(42513),
		2203,
		31,
		123,
		{
			RTResTalkAction[39],
			RTResTalkAction[40]
		}
	},
	[2203032] = {
		2203032,
		0,
		Lang.get(42514),
		2203,
		32,
		164,
		{
			RTResTalkAction[39],
			RTResTalkAction[40]
		}
	},
	[2203033] = {
		2203033,
		0,
		Lang.get(37751),
		2203,
		33,
		125,
		{
			RTResTalkAction[39],
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[2203034] = {
		2203034,
		0,
		Lang.get(37752),
		2203,
		34,
		123,
		{
			RTResTalkAction[39],
			RTResTalkAction[40],
			RTResTalkAction[43]
		}
	},
	[2203035] = {
		2203035,
		0,
		Lang.get(37753),
		2203,
		35,
		164,
		{
			RTResTalkAction[39],
			RTResTalkAction[40]
		}
	},
	[2203036] = {
		2203036,
		0,
		Lang.get(37754),
		2203,
		36,
		164,
		{
			RTResTalkAction[39],
			RTResTalkAction[40]
		}
	},
	[2203037] = {
		2203037,
		0,
		Lang.get(37755),
		2203,
		37,
		125,
		{
			RTResTalkAction[44],
			RTResTalkAction[45],
			RTResTalkAction[42]
		}
	},
	[2203038] = {
		2203038,
		2,
		Lang.get(37756),
		2203,
		38,
		123,
		{
			RTResTalkAction[39],
			RTResTalkAction[40],
			RTResTalkAction[43]
		}
	},
	[2203039] = {
		2203039,
		0,
		Lang.get(37757),
		2203,
		39,
		164,
		{
			RTResTalkAction[39],
			RTResTalkAction[40]
		}
	},
	[2204001] = {
		2204001,
		0,
		Lang.get(18735),
		2204,
		1,
		147,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		2210,
		nil,
		nil,
		1,
		nil,
		2210
	},
	[2204002] = {
		2204002,
		0,
		Lang.get(18736),
		2204,
		2,
		107,
		{
			RTResTalkAction[46]
		},
		nil,
		nil,
		3
	},
	[2204003] = {
		2204003,
		0,
		Lang.get(18737),
		2204,
		3,
		107,
		{
			RTResTalkAction[47]
		}
	},
	[2204004] = {
		2204004,
		0,
		Lang.get(18738),
		2204,
		4,
		107,
		{
			RTResTalkAction[48]
		}
	},
	[2204005] = {
		2204005,
		0,
		Lang.get(18739),
		2204,
		5,
		147,
		{
			RTResTalkAction[30],
			RTResTalkAction[49]
		}
	},
	[2204006] = {
		2204006,
		0,
		Lang.get(18740),
		2204,
		6,
		104,
		{
			RTResTalkAction[12],
			RTResTalkAction[23]
		},
		1,
		nil,
		-1,
		nil,
		nil,
		2233,
		0.8,
		1,
		1,
		nil,
		2233
	},
	[2204007] = {
		2204007,
		0,
		Lang.get(18741),
		2204,
		7,
		104,
		nil,
		1
	},
	[2204008] = {
		2204008,
		0,
		Lang.get(18742),
		2204,
		8,
		104,
		nil,
		1
	},
	[2204009] = {
		2204009,
		0,
		Lang.get(18743),
		2204,
		9,
		104,
		{
			RTResTalkAction[50]
		},
		nil,
		nil,
		3
	},
	[2204010] = {
		2204010,
		0,
		Lang.get(18744),
		2204,
		10,
		104,
		{
			RTResTalkAction[51]
		}
	},
	[2204011] = {
		2204011,
		0,
		Lang.get(18745),
		2204,
		11,
		104,
		{
			RTResTalkAction[51]
		}
	},
	[2204012] = {
		2204012,
		5,
		Lang.get(37758),
		2204,
		12,
		147,
		{
			RTResTalkAction[52]
		},
		1,
		2,
		-1,
		nil,
		57,
		2211,
		0.8,
		1,
		1,
		nil,
		2211
	},
	[2204013] = {
		2204013,
		5,
		Lang.get(37759),
		2204,
		13,
		681,
		nil,
		1,
		0
	},
	[2204014] = {
		2204014,
		0,
		Lang.get(37760),
		2204,
		14,
		104,
		{
			RTResTalkAction[51]
		},
		nil,
		nil,
		3
	},
	[2204015] = {
		2204015,
		0,
		Lang.get(37761),
		2204,
		15,
		147,
		{
			RTResTalkAction[22],
			RTResTalkAction[52]
		}
	},
	[2204016] = {
		2204016,
		0,
		Lang.get(37762),
		2204,
		16,
		125,
		{
			RTResTalkAction[44],
			RTResTalkAction[23]
		}
	},
	[2204017] = {
		2204017,
		0,
		Lang.get(37763),
		2204,
		17,
		125,
		{
			RTResTalkAction[44]
		}
	},
	[2204018] = {
		2204018,
		0,
		Lang.get(37764),
		2204,
		18,
		125,
		{
			RTResTalkAction[44]
		}
	},
	[2205001] = {
		2205001,
		0,
		Lang.get(18785),
		2205,
		1,
		542,
		nil,
		1,
		nil,
		nil,
		nil,
		57,
		2214,
		0.5,
		1,
		1,
		nil,
		2214
	},
	[2205002] = {
		2205002,
		0,
		Lang.get(37765),
		2205,
		2,
		123,
		nil,
		1
	},
	[2205003] = {
		2205003,
		0,
		Lang.get(18788),
		2205,
		3,
		542,
		nil,
		1
	},
	[2205004] = {
		2205004,
		0,
		Lang.get(18789),
		2205,
		4,
		123,
		nil,
		1
	},
	[2205005] = {
		2205005,
		0,
		Lang.get(37766),
		2205,
		5,
		123,
		nil,
		1
	},
	[2205006] = {
		2205006,
		0,
		Lang.get(18791),
		2205,
		6,
		542,
		{
			RTResTalkAction[53]
		},
		nil,
		nil,
		3
	},
	[2205007] = {
		2205007,
		0,
		Lang.get(37767),
		2205,
		7,
		123,
		{
			RTResTalkAction[54],
			RTResTalkAction[55]
		}
	},
	[2205008] = {
		2205008,
		0,
		Lang.get(37768),
		2205,
		8,
		123,
		{
			RTResTalkAction[54]
		}
	},
	[2205009] = {
		2205009,
		0,
		Lang.get(18792),
		2205,
		9,
		123,
		{
			RTResTalkAction[54]
		}
	},
	[2205010] = {
		2205010,
		0,
		Lang.get(37769),
		2205,
		10,
		123,
		{
			RTResTalkAction[54]
		}
	},
	[2205011] = {
		2205011,
		0,
		Lang.get(46219),
		2205,
		11,
		542,
		{
			RTResTalkAction[53],
			RTResTalkAction[42]
		}
	},
	[2205012] = {
		2205012,
		0,
		Lang.get(18795),
		2205,
		12,
		107,
		{
			RTResTalkAction[56],
			RTResTalkAction[55]
		},
		nil,
		nil,
		3,
		nil,
		60,
		2234,
		0.5,
		1,
		1,
		nil,
		2234
	},
	[2205013] = {
		2205013,
		0,
		Lang.get(18796),
		2205,
		13,
		141,
		{
			RTResTalkAction[8],
			RTResTalkAction[12]
		}
	},
	[2205014] = {
		2205014,
		0,
		Lang.get(18797),
		2205,
		14,
		107,
		{
			RTResTalkAction[47],
			RTResTalkAction[10]
		}
	},
	[2205015] = {
		2205015,
		0,
		Lang.get(18798),
		2205,
		15,
		141,
		{
			RTResTalkAction[8],
			RTResTalkAction[12]
		}
	},
	[2205016] = {
		2205016,
		0,
		Lang.get(18799),
		2205,
		16,
		107,
		{
			RTResTalkAction[33],
			RTResTalkAction[10]
		}
	},
	[2206001] = {
		2206001,
		0,
		Lang.get(37770),
		2206,
		1,
		112,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		2212,
		0.5,
		1,
		1,
		nil,
		2212
	},
	[2206002] = {
		2206002,
		3,
		Lang.get(37771),
		2206,
		2,
		[21] = 1
	},
	[2206003] = {
		2206003,
		3,
		Lang.get(37772),
		2206,
		3,
		[21] = 1
	},
	[2206004] = {
		2206004,
		0,
		Lang.get(37773),
		2206,
		4,
		112,
		nil,
		1,
		1
	},
	[2206005] = {
		2206005,
		0,
		Lang.get(37774),
		2206,
		5,
		112,
		nil,
		1,
		4
	},
	[2206006] = {
		2206006,
		0,
		Lang.get(37775),
		2206,
		6,
		112,
		{
			RTResTalkAction[57]
		},
		nil,
		nil,
		3
	},
	[2206007] = {
		2206007,
		0,
		Lang.get(37776),
		2206,
		7,
		112,
		{
			RTResTalkAction[57]
		}
	},
	[2206008] = {
		2206008,
		0,
		Lang.get(37777),
		2206,
		8,
		112,
		{
			RTResTalkAction[58]
		},
		1,
		0
	},
	[2206009] = {
		2206009,
		0,
		Lang.get(37778),
		2206,
		9,
		112,
		nil,
		1,
		0
	},
	[2206010] = {
		2206010,
		0,
		Lang.get(37779),
		2206,
		10,
		302,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		2213,
		0.2,
		1,
		1,
		nil,
		2213
	},
	[2206011] = {
		2206011,
		0,
		Lang.get(37780),
		2206,
		11,
		117,
		nil,
		1,
		0
	},
	[2206012] = {
		2206012,
		0,
		Lang.get(37781),
		2206,
		12,
		112,
		{
			RTResTalkAction[59]
		},
		nil,
		nil,
		3
	},
	[2206013] = {
		2206013,
		0,
		Lang.get(37782),
		2206,
		13,
		302,
		{
			RTResTalkAction[60],
			RTResTalkAction[58]
		}
	},
	[2206014] = {
		2206014,
		0,
		Lang.get(37783),
		2206,
		14,
		112,
		{
			RTResTalkAction[59],
			RTResTalkAction[61]
		}
	},
	[2206015] = {
		2206015,
		0,
		Lang.get(37784),
		2206,
		15,
		117,
		{
			RTResTalkAction[62],
			RTResTalkAction[58]
		}
	},
	[2206016] = {
		2206016,
		0,
		Lang.get(37785),
		2206,
		16,
		112,
		{
			RTResTalkAction[57],
			RTResTalkAction[63]
		}
	},
	[2206017] = {
		2206017,
		0,
		Lang.get(37786),
		2206,
		17,
		302,
		{
			RTResTalkAction[64],
			RTResTalkAction[58]
		}
	},
	[2202001] = {
		2202001,
		0,
		Lang.get(46220),
		2202,
		1,
		188,
		nil,
		1,
		4,
		nil,
		nil,
		60,
		2238,
		0.2,
		1,
		1,
		nil,
		2238
	},
	[2202002] = {
		2202002,
		0,
		Lang.get(37787),
		2202,
		2,
		350,
		nil,
		1,
		0
	},
	[2202003] = {
		2202003,
		0,
		Lang.get(37788),
		2202,
		3,
		188,
		nil,
		1,
		2
	},
	[2202004] = {
		2202004,
		0,
		Lang.get(37789),
		2202,
		4,
		350,
		nil,
		1,
		0
	},
	[2202005] = {
		2202005,
		3,
		Lang.get(37790),
		2202,
		5,
		[21] = 1
	},
	[2202006] = {
		2202006,
		0,
		Lang.get(37791),
		2202,
		6,
		117,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		2239,
		0.2,
		1,
		1,
		nil,
		2239
	},
	[2202007] = {
		2202007,
		0,
		Lang.get(37792),
		2202,
		7,
		302,
		nil,
		1
	},
	[2202008] = {
		2202008,
		0,
		Lang.get(37793),
		2202,
		8,
		117,
		{
			RTResTalkAction[62]
		},
		nil,
		nil,
		3
	},
	[2202009] = {
		2202009,
		0,
		Lang.get(37794),
		2202,
		9,
		302,
		{
			RTResTalkAction[60],
			RTResTalkAction[63]
		}
	},
	[2219001] = {
		2219001,
		0,
		Lang.get(19082),
		2219,
		1,
		110,
		nil,
		1,
		0,
		nil,
		nil,
		57,
		2240,
		0.2,
		1,
		1,
		nil,
		2240
	},
	[2219002] = {
		2219002,
		0,
		Lang.get(19083),
		2219,
		2,
		141,
		nil,
		1,
		0
	},
	[2219003] = {
		2219003,
		0,
		Lang.get(19084),
		2219,
		3,
		107,
		nil,
		1,
		0,
		3
	},
	[2219004] = {
		2219004,
		0,
		Lang.get(19085),
		2219,
		4,
		141,
		nil,
		1,
		0
	},
	[2219005] = {
		2219005,
		0,
		Lang.get(37795),
		2219,
		5,
		125,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		2241,
		nil,
		nil,
		1,
		nil,
		2241
	},
	[2219006] = {
		2219006,
		0,
		Lang.get(37796),
		2219,
		6,
		141,
		nil,
		1,
		0
	},
	[2219007] = {
		2219007,
		0,
		Lang.get(37797),
		2219,
		7,
		135,
		{
			RTResTalkAction[65]
		},
		nil,
		nil,
		3
	},
	[2219008] = {
		2219008,
		0,
		Lang.get(37798),
		2219,
		8,
		110,
		{
			RTResTalkAction[66],
			RTResTalkAction[67]
		}
	},
	[2219009] = {
		2219009,
		0,
		Lang.get(37799),
		2219,
		9,
		103,
		{
			RTResTalkAction[68],
			RTResTalkAction[69]
		}
	},
	[2219010] = {
		2219010,
		0,
		Lang.get(37800),
		2219,
		10,
		125,
		{
			RTResTalkAction[44],
			RTResTalkAction[70]
		}
	},
	[2219011] = {
		2219011,
		0,
		Lang.get(37801),
		2219,
		11,
		123,
		{
			RTResTalkAction[54],
			RTResTalkAction[43]
		},
		nil,
		nil,
		3
	},
	[2219012] = {
		2219012,
		0,
		Lang.get(37802),
		2219,
		12,
		123,
		{
			RTResTalkAction[54]
		}
	},
	[2219013] = {
		2219013,
		0,
		Lang.get(37803),
		2219,
		13,
		135,
		{
			RTResTalkAction[65],
			RTResTalkAction[42]
		}
	},
	[2219014] = {
		2219014,
		0,
		Lang.get(37804),
		2219,
		14,
		103,
		{
			RTResTalkAction[68],
			RTResTalkAction[67]
		}
	},
	[2219015] = {
		2219015,
		0,
		Lang.get(37805),
		2219,
		15,
		123,
		{
			RTResTalkAction[54],
			RTResTalkAction[70]
		}
	},
	[2219016] = {
		2219016,
		0,
		Lang.get(37806),
		2219,
		16,
		103,
		{
			RTResTalkAction[68],
			RTResTalkAction[42]
		}
	},
	[2219017] = {
		2219017,
		0,
		Lang.get(37807),
		2219,
		17,
		141,
		{
			RTResTalkAction[70]
		},
		1,
		nil,
		nil,
		nil,
		67,
		2242,
		0.5,
		1,
		nil,
		nil,
		2242
	},
	[2219018] = {
		2219018,
		0,
		Lang.get(37808),
		2219,
		18,
		107,
		nil,
		1
	},
	[2219019] = {
		2219019,
		0,
		Lang.get(37809),
		2219,
		19,
		110,
		{
			RTResTalkAction[66]
		},
		nil,
		nil,
		3
	},
	[2219020] = {
		2219020,
		0,
		Lang.get(37810),
		2219,
		20,
		141,
		{
			RTResTalkAction[8],
			RTResTalkAction[69]
		}
	},
	[2219021] = {
		2219021,
		0,
		Lang.get(37811),
		2219,
		21,
		125,
		{
			RTResTalkAction[44],
			RTResTalkAction[10]
		}
	},
	[2219022] = {
		2219022,
		0,
		Lang.get(37812),
		2219,
		22,
		123,
		{
			RTResTalkAction[54],
			RTResTalkAction[43]
		}
	},
	[2219023] = {
		2219023,
		0,
		Lang.get(46221),
		2219,
		23,
		125,
		{
			RTResTalkAction[44],
			RTResTalkAction[42]
		}
	},
	[2219024] = {
		2219024,
		0,
		Lang.get(37814),
		2219,
		24,
		110,
		{
			RTResTalkAction[66],
			RTResTalkAction[43]
		}
	},
	[2219025] = {
		2219025,
		0,
		Lang.get(37815),
		2219,
		25,
		141,
		{
			RTResTalkAction[8],
			RTResTalkAction[69]
		}
	},
	[2219026] = {
		2219026,
		0,
		Lang.get(37816),
		2219,
		26,
		110,
		{
			RTResTalkAction[66],
			RTResTalkAction[10]
		}
	},
	[2219027] = {
		2219027,
		0,
		Lang.get(37817),
		2219,
		27,
		141,
		{
			RTResTalkAction[8],
			RTResTalkAction[69]
		}
	},
	[2219028] = {
		2219028,
		0,
		Lang.get(37818),
		2219,
		28,
		107,
		{
			RTResTalkAction[11],
			RTResTalkAction[10]
		}
	},
	[2219029] = {
		2219029,
		0,
		Lang.get(37819),
		2219,
		29,
		107,
		{
			RTResTalkAction[11]
		}
	},
	[2219030] = {
		2219030,
		0,
		Lang.get(37820),
		2219,
		30,
		348,
		{
			RTResTalkAction[71],
			RTResTalkAction[12]
		}
	},
	[2219031] = {
		2219031,
		0,
		Lang.get(37821),
		2219,
		31,
		107,
		{
			RTResTalkAction[11],
			RTResTalkAction[72]
		}
	},
	[2219032] = {
		2219032,
		0,
		Lang.get(37822),
		2219,
		32,
		133,
		{
			RTResTalkAction[13],
			RTResTalkAction[12]
		}
	},
	[2219033] = {
		2219033,
		0,
		Lang.get(37823),
		2219,
		33,
		348,
		{
			RTResTalkAction[71],
			RTResTalkAction[14]
		}
	},
	[2219034] = {
		2219034,
		0,
		Lang.get(46222),
		2219,
		34,
		107,
		{
			RTResTalkAction[11],
			RTResTalkAction[72]
		}
	},
	[2207001] = {
		2207001,
		0,
		Lang.get(37824),
		2207,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		2215,
		0.5,
		1,
		1,
		nil,
		2215
	},
	[2207002] = {
		2207002,
		0,
		Lang.get(37825),
		2207,
		2,
		107,
		nil,
		1,
		1
	},
	[2207003] = {
		2207003,
		0,
		Lang.get(37826),
		2207,
		3,
		300,
		{
			RTResTalkAction[73]
		},
		nil,
		nil,
		3
	},
	[2207004] = {
		2207004,
		0,
		Lang.get(37827),
		2207,
		4,
		107,
		{
			RTResTalkAction[74],
			RTResTalkAction[75]
		}
	},
	[2207005] = {
		2207005,
		0,
		Lang.get(37828),
		2207,
		5,
		300,
		{
			RTResTalkAction[11]
		}
	},
	[2207006] = {
		2207006,
		0,
		Lang.get(37829),
		2207,
		6,
		107,
		{
			RTResTalkAction[11]
		}
	},
	[2207007] = {
		2207007,
		4,
		nil,
		2207,
		7,
		300,
		{
			RTResTalkAction[76]
		},
		[27] = {
			{
				id = 2207008,
				branch_content = Lang.get(42515)
			}
		}
	},
	[2207008] = {
		2207008,
		0,
		Lang.get(37831),
		2207,
		8,
		107,
		{
			RTResTalkAction[11]
		}
	},
	[2207009] = {
		2207009,
		13,
		nil,
		2207,
		9,
		376,
		{
			RTResTalkAction[1],
			RTResTalkAction[12]
		},
		[19] = 220,
		[26] = 1
	},
	[2207010] = {
		2207010,
		13,
		Lang.get(37832),
		2207,
		10,
		365,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		},
		[26] = 3
	},
	[2207011] = {
		2207011,
		0,
		Lang.get(37833),
		2207,
		11,
		107,
		{
			RTResTalkAction[2]
		},
		1,
		[26] = 3
	},
	[2207012] = {
		2207012,
		0,
		Lang.get(37834),
		2207,
		12,
		141,
		{
			RTResTalkAction[2]
		},
		1,
		0,
		[26] = 3
	},
	[2207013] = {
		2207013,
		0,
		"……",
		2207,
		13,
		300,
		{
			RTResTalkAction[2]
		},
		[26] = 3
	},
	[2207014] = {
		2207014,
		0,
		Lang.get(46223),
		2207,
		14,
		107,
		{
			RTResTalkAction[2]
		},
		1,
		[26] = 3
	},
	[2207015] = {
		2207015,
		13,
		Lang.get(37835),
		2207,
		15,
		365,
		{
			RTResTalkAction[2]
		},
		[26] = 3
	},
	[2207016] = {
		2207016,
		0,
		Lang.get(37836),
		2207,
		16,
		107,
		{
			RTResTalkAction[2]
		},
		1,
		[26] = 3
	},
	[2207017] = {
		2207017,
		0,
		Lang.get(37837),
		2207,
		17,
		107,
		{
			RTResTalkAction[2]
		},
		1,
		[26] = 3
	},
	[2207018] = {
		2207018,
		13,
		Lang.get(37838),
		2207,
		18,
		365,
		{
			RTResTalkAction[2]
		},
		[26] = 3
	},
	[2207019] = {
		2207019,
		0,
		Lang.get(37839),
		2207,
		19,
		300,
		{
			RTResTalkAction[2]
		},
		[26] = 3
	},
	[2207020] = {
		2207020,
		13,
		Lang.get(37840),
		2207,
		20,
		365,
		{
			RTResTalkAction[2]
		},
		[26] = 3
	},
	[2207021] = {
		2207021,
		13,
		Lang.get(37841),
		2207,
		21,
		365,
		{
			RTResTalkAction[2]
		},
		[26] = 3
	},
	[2207022] = {
		2207022,
		13,
		Lang.get(37842),
		2207,
		22,
		365,
		{
			RTResTalkAction[2]
		},
		[26] = 3
	},
	[2207023] = {
		2207023,
		13,
		Lang.get(37843),
		2207,
		23,
		365,
		{
			RTResTalkAction[2]
		},
		[26] = 3
	},
	[2207024] = {
		2207024,
		0,
		Lang.get(37844),
		2207,
		24,
		107,
		{
			RTResTalkAction[2]
		},
		1,
		[26] = 3
	},
	[2207025] = {
		2207025,
		13,
		Lang.get(37845),
		2207,
		25,
		364,
		{
			RTResTalkAction[77],
			RTResTalkAction[6]
		},
		[26] = 3
	},
	[2207026] = {
		2207026,
		13,
		Lang.get(37846),
		2207,
		26,
		365,
		{
			RTResTalkAction[78],
			RTResTalkAction[79]
		},
		[26] = 3
	},
	[2207027] = {
		2207027,
		0,
		Lang.get(37847),
		2207,
		27,
		110,
		{
			RTResTalkAction[66],
			RTResTalkAction[80],
			RTResTalkAction[6]
		},
		nil,
		nil,
		-1
	},
	[2207028] = {
		2207028,
		0,
		Lang.get(37848),
		2207,
		28,
		133,
		{
			RTResTalkAction[13],
			RTResTalkAction[69]
		}
	},
	[2207029] = {
		2207029,
		0,
		Lang.get(37849),
		2207,
		29,
		300,
		{
			RTResTalkAction[13]
		}
	},
	[2207030] = {
		2207030,
		0,
		Lang.get(46224),
		2207,
		30,
		107,
		{
			RTResTalkAction[11],
			RTResTalkAction[14]
		}
	},
	[2208001] = {
		2208001,
		0,
		Lang.get(37850),
		2208,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		61,
		2216,
		0.5,
		1,
		1,
		nil,
		2216
	},
	[2208002] = {
		2208002,
		0,
		Lang.get(37851),
		2208,
		2,
		219,
		nil,
		1
	},
	[2208003] = {
		2208003,
		0,
		Lang.get(37852),
		2208,
		3,
		107,
		nil,
		1,
		1
	},
	[2208004] = {
		2208004,
		0,
		Lang.get(37853),
		2208,
		4,
		219,
		nil,
		1,
		0
	},
	[2208005] = {
		2208005,
		4,
		nil,
		2208,
		5,
		219,
		nil,
		1,
		[27] = {
			{
				id = 2208006,
				branch_content = Lang.get(42516)
			}
		}
	},
	[2208006] = {
		2208006,
		0,
		Lang.get(37855),
		2208,
		6,
		219,
		nil,
		1
	},
	[2208007] = {
		2208007,
		0,
		Lang.get(37856),
		2208,
		7,
		107,
		nil,
		1,
		8
	},
	[2208008] = {
		2208008,
		0,
		Lang.get(37857),
		2208,
		8,
		219,
		nil,
		1,
		0
	},
	[2208009] = {
		2208009,
		0,
		Lang.get(37858),
		2208,
		9,
		107,
		nil,
		1
	},
	[2208010] = {
		2208010,
		0,
		Lang.get(37859),
		2208,
		10,
		219,
		nil,
		1
	},
	[2208011] = {
		2208011,
		0,
		Lang.get(37860),
		2208,
		11,
		219,
		nil,
		1
	},
	[2208012] = {
		2208012,
		3,
		Lang.get(37861),
		2208,
		12,
		[19] = 255,
		[21] = 1
	},
	[2209001] = {
		2209001,
		0,
		Lang.get(37862),
		2209,
		1,
		107,
		nil,
		1,
		5,
		nil,
		nil,
		67,
		2217,
		0.5,
		1,
		1,
		nil,
		2217
	},
	[2209002] = {
		2209002,
		0,
		Lang.get(37863),
		2209,
		2,
		300
	},
	[2209003] = {
		2209003,
		0,
		Lang.get(37864),
		2209,
		3,
		219,
		nil,
		1,
		0
	},
	[2209004] = {
		2209004,
		4,
		nil,
		2209,
		4,
		219,
		nil,
		1,
		[27] = {
			{
				id = 2209005,
				branch_content = Lang.get(42517)
			}
		}
	},
	[2209005] = {
		2209005,
		0,
		Lang.get(37866),
		2209,
		5,
		219,
		nil,
		1
	},
	[2209006] = {
		2209006,
		3,
		Lang.get(37861),
		2209,
		6,
		219,
		[19] = 255,
		[21] = 1
	},
	[2209007] = {
		2209007,
		0,
		Lang.get(37867),
		2209,
		7,
		107,
		nil,
		1,
		3,
		nil,
		nil,
		60,
		2218,
		0.5,
		1,
		1,
		nil,
		2218,
		-1
	},
	[2209008] = {
		2209008,
		0,
		Lang.get(37868),
		2209,
		8,
		355,
		nil,
		1,
		0
	},
	[2209009] = {
		2209009,
		0,
		Lang.get(37869),
		2209,
		9,
		107,
		nil,
		1
	},
	[2209010] = {
		2209010,
		0,
		Lang.get(46225),
		2209,
		10,
		355,
		nil,
		1
	},
	[2209011] = {
		2209011,
		0,
		Lang.get(37870),
		2209,
		11,
		107,
		nil,
		1
	},
	[2209012] = {
		2209012,
		0,
		Lang.get(37871),
		2209,
		12,
		355,
		nil,
		1
	},
	[2209013] = {
		2209013,
		0,
		Lang.get(37872),
		2209,
		13,
		107,
		nil,
		1
	},
	[2209014] = {
		2209014,
		0,
		Lang.get(37873),
		2209,
		14,
		355,
		nil,
		1
	},
	[2209015] = {
		2209015,
		0,
		Lang.get(37874),
		2209,
		15,
		107,
		nil,
		1,
		7
	},
	[2210001] = {
		2210001,
		0,
		Lang.get(37875),
		2210,
		1,
		107,
		nil,
		1,
		1,
		nil,
		nil,
		59,
		2219,
		0.5,
		1,
		1,
		nil,
		2219
	},
	[2210002] = {
		2210002,
		0,
		Lang.get(37876),
		2210,
		2,
		355,
		nil,
		1,
		0
	},
	[2210003] = {
		2210003,
		0,
		Lang.get(37877),
		2210,
		3,
		355,
		nil,
		1
	},
	[2210004] = {
		2210004,
		0,
		Lang.get(37878),
		2210,
		4,
		125,
		{
			RTResTalkAction[44]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		2245,
		0.5,
		1,
		nil,
		nil,
		2245
	},
	[2210005] = {
		2210005,
		0,
		Lang.get(37879),
		2210,
		5,
		141,
		{
			RTResTalkAction[8],
			RTResTalkAction[43]
		}
	},
	[2210006] = {
		2210006,
		0,
		Lang.get(37880),
		2210,
		6,
		125,
		{
			RTResTalkAction[44],
			RTResTalkAction[10]
		}
	},
	[2210007] = {
		2210007,
		5,
		Lang.get(37881),
		2210,
		7,
		681,
		{
			RTResTalkAction[81],
			RTResTalkAction[43]
		}
	},
	[2210008] = {
		2210008,
		0,
		Lang.get(37882),
		2210,
		8,
		300,
		{
			RTResTalkAction[73],
			RTResTalkAction[82]
		}
	},
	[2210009] = {
		2210009,
		0,
		Lang.get(37883),
		2210,
		9,
		125,
		{
			RTResTalkAction[44],
			RTResTalkAction[75]
		}
	},
	[2210010] = {
		2210010,
		0,
		Lang.get(37884),
		2210,
		10,
		300,
		{
			RTResTalkAction[44]
		}
	},
	[2210011] = {
		2210011,
		0,
		Lang.get(46226),
		2210,
		11,
		125,
		{
			RTResTalkAction[44]
		}
	},
	[2210012] = {
		2210012,
		0,
		Lang.get(37885),
		2210,
		12,
		107,
		{
			RTResTalkAction[11],
			RTResTalkAction[43]
		}
	},
	[2210013] = {
		2210013,
		0,
		Lang.get(37886),
		2210,
		13,
		300,
		{
			RTResTalkAction[11]
		}
	},
	[2210014] = {
		2210014,
		0,
		Lang.get(37887),
		2210,
		14,
		300,
		{
			RTResTalkAction[11]
		}
	},
	[2210015] = {
		2210015,
		0,
		Lang.get(37888),
		2210,
		15,
		355,
		{
			RTResTalkAction[83],
			RTResTalkAction[12]
		}
	},
	[2210016] = {
		2210016,
		0,
		Lang.get(37889),
		2210,
		16,
		300,
		{
			RTResTalkAction[83]
		}
	},
	[2210017] = {
		2210017,
		0,
		Lang.get(37890),
		2210,
		17,
		355,
		{
			RTResTalkAction[83]
		}
	},
	[2210018] = {
		2210018,
		0,
		Lang.get(37891),
		2210,
		18,
		355,
		{
			RTResTalkAction[83]
		}
	},
	[2210019] = {
		2210019,
		0,
		Lang.get(37892),
		2210,
		19,
		107,
		{
			RTResTalkAction[11],
			RTResTalkAction[84]
		}
	},
	[2210020] = {
		2210020,
		5,
		Lang.get(37893),
		2210,
		20,
		355,
		{
			RTResTalkAction[83],
			RTResTalkAction[12]
		}
	},
	[2210021] = {
		2210021,
		0,
		Lang.get(37894),
		2210,
		21,
		107,
		{
			RTResTalkAction[11],
			RTResTalkAction[84]
		}
	},
	[2210022] = {
		2210022,
		0,
		Lang.get(37895),
		2210,
		22,
		300,
		{
			RTResTalkAction[73],
			RTResTalkAction[12]
		}
	},
	[2210023] = {
		2210023,
		0,
		Lang.get(37896),
		2210,
		23,
		107,
		{
			RTResTalkAction[11],
			RTResTalkAction[75]
		}
	},
	[2211001] = {
		2211001,
		0,
		Lang.get(37897),
		2211,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		57,
		2220,
		nil,
		1,
		1,
		nil,
		2220
	},
	[2211002] = {
		2211002,
		0,
		Lang.get(37898),
		2211,
		2,
		219,
		nil,
		1
	},
	[2211003] = {
		2211003,
		2,
		Lang.get(37899),
		2211,
		3,
		219,
		{
			RTResTalkAction[85]
		},
		nil,
		nil,
		3
	},
	[2211004] = {
		2211004,
		2,
		Lang.get(37900),
		2211,
		4,
		219,
		{
			RTResTalkAction[86]
		}
	},
	[2211005] = {
		2211005,
		2,
		Lang.get(37901),
		2211,
		5,
		219,
		{
			RTResTalkAction[86]
		}
	},
	[2211006] = {
		2211006,
		0,
		Lang.get(46227),
		2211,
		6,
		141,
		{
			RTResTalkAction[8],
			RTResTalkAction[87]
		}
	},
	[2211007] = {
		2211007,
		0,
		Lang.get(37902),
		2211,
		7,
		141,
		{
			RTResTalkAction[8]
		}
	},
	[2211008] = {
		2211008,
		0,
		Lang.get(46228),
		2211,
		8,
		355,
		{
			RTResTalkAction[83],
			RTResTalkAction[10]
		}
	},
	[2211009] = {
		2211009,
		0,
		Lang.get(37904),
		2211,
		9,
		107,
		{
			RTResTalkAction[11],
			RTResTalkAction[84]
		}
	},
	[2211010] = {
		2211010,
		0,
		Lang.get(46229),
		2211,
		10,
		355,
		{
			RTResTalkAction[83],
			RTResTalkAction[12]
		}
	},
	[2211011] = {
		2211011,
		0,
		Lang.get(37905),
		2211,
		11,
		125,
		{
			RTResTalkAction[44],
			RTResTalkAction[84]
		}
	},
	[2211012] = {
		2211012,
		3,
		Lang.get(46230),
		2211,
		12,
		125,
		{
			RTResTalkAction[43]
		},
		[21] = 1
	},
	[2211013] = {
		2211013,
		0,
		Lang.get(46231),
		2211,
		13,
		125,
		{
			RTResTalkAction[44]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		2221,
		nil,
		1,
		1,
		nil,
		2221
	},
	[2211014] = {
		2211014,
		0,
		Lang.get(37907),
		2211,
		14,
		219,
		{
			RTResTalkAction[86],
			RTResTalkAction[43]
		}
	},
	[2211015] = {
		2211015,
		0,
		Lang.get(37908),
		2211,
		15,
		125,
		{
			RTResTalkAction[44],
			RTResTalkAction[87]
		}
	},
	[2211016] = {
		2211016,
		0,
		Lang.get(37909),
		2211,
		16,
		681,
		{
			RTResTalkAction[81],
			RTResTalkAction[43]
		}
	},
	[2211017] = {
		2211017,
		0,
		Lang.get(37910),
		2211,
		17,
		219,
		{
			RTResTalkAction[86],
			RTResTalkAction[82]
		}
	},
	[2211018] = {
		2211018,
		0,
		Lang.get(37911),
		2211,
		18,
		681,
		{
			RTResTalkAction[81],
			RTResTalkAction[87]
		}
	},
	[2211019] = {
		2211019,
		0,
		Lang.get(37912),
		2211,
		19,
		125,
		{
			RTResTalkAction[44],
			RTResTalkAction[82]
		}
	},
	[2211020] = {
		2211020,
		0,
		Lang.get(37913),
		2211,
		20,
		219,
		{
			RTResTalkAction[86],
			RTResTalkAction[43]
		}
	},
	[2211021] = {
		2211021,
		0,
		Lang.get(37914),
		2211,
		21,
		107,
		{
			RTResTalkAction[11],
			RTResTalkAction[87]
		}
	},
	[2211022] = {
		2211022,
		0,
		Lang.get(46232),
		2211,
		22,
		355,
		{
			RTResTalkAction[83],
			RTResTalkAction[12]
		}
	},
	[2211023] = {
		2211023,
		0,
		Lang.get(37915),
		2211,
		23,
		141,
		{
			RTResTalkAction[8],
			RTResTalkAction[84]
		}
	},
	[2211024] = {
		2211024,
		0,
		Lang.get(37916),
		2211,
		24,
		125,
		{
			RTResTalkAction[44],
			RTResTalkAction[10]
		}
	},
	[2212001] = {
		2212001,
		0,
		Lang.get(37917),
		2212,
		1,
		107,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		nil,
		nil,
		60,
		2248,
		0.5,
		1,
		1,
		nil,
		2248
	},
	[2212002] = {
		2212002,
		0,
		Lang.get(37918),
		2212,
		2,
		219,
		{
			RTResTalkAction[86],
			RTResTalkAction[12]
		},
		nil,
		nil,
		3
	},
	[2212003] = {
		2212003,
		4,
		nil,
		2212,
		3,
		219,
		{
			RTResTalkAction[86]
		},
		[27] = {
			{
				id = 2212004,
				branch_content = Lang.get(19725)
			}
		}
	},
	[2212004] = {
		2212004,
		0,
		Lang.get(37920),
		2212,
		4,
		219,
		{
			RTResTalkAction[86]
		}
	},
	[2212005] = {
		2212005,
		0,
		Lang.get(37921),
		2212,
		5,
		219,
		{
			RTResTalkAction[86]
		}
	},
	[2212006] = {
		2212006,
		0,
		Lang.get(37922),
		2212,
		6,
		355,
		{
			RTResTalkAction[87]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		2222,
		nil,
		1,
		1,
		nil,
		2222
	},
	[2212007] = {
		2212007,
		0,
		Lang.get(37923),
		2212,
		7,
		107,
		nil,
		1,
		nil,
		3
	},
	[2212008] = {
		2212008,
		0,
		Lang.get(37924),
		2212,
		8,
		355,
		{
			RTResTalkAction[83]
		}
	},
	[2212009] = {
		2212009,
		0,
		Lang.get(37925),
		2212,
		9,
		300,
		{
			RTResTalkAction[83]
		}
	},
	[2212010] = {
		2212010,
		0,
		Lang.get(42518),
		2212,
		10,
		107,
		{
			RTResTalkAction[11],
			RTResTalkAction[84]
		}
	},
	[2212011] = {
		2212011,
		0,
		Lang.get(98964),
		2212,
		11,
		107,
		{
			RTResTalkAction[11]
		}
	},
	[2212012] = {
		2212012,
		0,
		Lang.get(37928),
		2212,
		12,
		107,
		{
			RTResTalkAction[11]
		}
	},
	[2212013] = {
		2212013,
		0,
		Lang.get(37929),
		2212,
		13,
		141,
		{
			RTResTalkAction[88],
			RTResTalkAction[12]
		}
	},
	[2212014] = {
		2212014,
		0,
		Lang.get(37930),
		2212,
		14,
		107,
		{
			RTResTalkAction[11],
			RTResTalkAction[10]
		}
	},
	[2212015] = {
		2212015,
		3,
		Lang.get(37931),
		2212,
		15,
		107,
		{
			RTResTalkAction[12]
		},
		[19] = 255,
		[21] = 1
	},
	[2212016] = {
		2212016,
		0,
		Lang.get(37932),
		2212,
		16,
		219,
		{
			RTResTalkAction[89]
		}
	},
	[2212017] = {
		2212017,
		0,
		Lang.get(37933),
		2212,
		17,
		219,
		{
			RTResTalkAction[86]
		}
	},
	[2212018] = {
		2212018,
		0,
		Lang.get(37934),
		2212,
		18,
		110,
		{
			RTResTalkAction[87]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		2253,
		0.5,
		1,
		nil,
		nil,
		2253,
		-1
	},
	[2212019] = {
		2212019,
		0,
		Lang.get(37935),
		2212,
		19,
		110,
		{
			RTResTalkAction[66]
		},
		nil,
		nil,
		3
	},
	[2212020] = {
		2212020,
		0,
		Lang.get(37936),
		2212,
		20,
		300,
		{
			RTResTalkAction[66]
		}
	},
	[2212021] = {
		2212021,
		0,
		Lang.get(37937),
		2212,
		21,
		107,
		{
			RTResTalkAction[11],
			RTResTalkAction[69]
		}
	},
	[2213001] = {
		2213001,
		0,
		Lang.get(19342),
		2213,
		1,
		107,
		nil,
		1,
		5,
		nil,
		nil,
		14,
		2223,
		0.5,
		1,
		1,
		nil,
		2223
	},
	[2213002] = {
		2213002,
		0,
		Lang.get(19343),
		2213,
		2,
		141,
		nil,
		1,
		0
	},
	[2213003] = {
		2213003,
		0,
		Lang.get(19344),
		2213,
		3,
		107,
		nil,
		1
	},
	[2213004] = {
		2213004,
		0,
		Lang.get(19345),
		2213,
		4,
		123,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		2247,
		nil,
		1,
		nil,
		nil,
		2247
	},
	[2213005] = {
		2213005,
		0,
		Lang.get(19346),
		2213,
		5,
		123,
		nil,
		1
	},
	[2213006] = {
		2213006,
		0,
		Lang.get(19347),
		2213,
		6,
		123,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		2224,
		0.8,
		1,
		1,
		nil,
		2224
	},
	[2213007] = {
		2213007,
		0,
		Lang.get(19348),
		2213,
		7,
		123,
		nil,
		1
	},
	[2213008] = {
		2213008,
		0,
		Lang.get(19349),
		2213,
		8,
		104,
		{
			RTResTalkAction[51]
		},
		nil,
		nil,
		3
	},
	[2213009] = {
		2213009,
		0,
		Lang.get(19350),
		2213,
		9,
		123,
		{
			RTResTalkAction[54],
			RTResTalkAction[52]
		}
	},
	[2213010] = {
		2213010,
		0,
		Lang.get(19351),
		2213,
		10,
		104,
		{
			RTResTalkAction[51],
			RTResTalkAction[42]
		}
	},
	[2213011] = {
		2213011,
		0,
		Lang.get(19352),
		2213,
		11,
		123,
		{
			RTResTalkAction[54],
			RTResTalkAction[52]
		}
	},
	[2213012] = {
		2213012,
		0,
		Lang.get(19353),
		2213,
		12,
		147,
		{
			RTResTalkAction[22],
			RTResTalkAction[42]
		}
	},
	[2213013] = {
		2213013,
		0,
		Lang.get(19354),
		2213,
		13,
		123,
		{
			RTResTalkAction[54],
			RTResTalkAction[23]
		}
	},
	[2213014] = {
		2213014,
		0,
		Lang.get(46233),
		2213,
		14,
		147,
		{
			RTResTalkAction[22],
			RTResTalkAction[42]
		}
	},
	[2213015] = {
		2213015,
		0,
		Lang.get(19355),
		2213,
		15,
		104,
		{
			RTResTalkAction[51],
			RTResTalkAction[23]
		}
	},
	[2213016] = {
		2213016,
		0,
		Lang.get(19356),
		2213,
		16,
		104,
		{
			RTResTalkAction[51]
		}
	},
	[2213017] = {
		2213017,
		0,
		Lang.get(19357),
		2213,
		17,
		123,
		{
			RTResTalkAction[54],
			RTResTalkAction[52]
		}
	},
	[2213018] = {
		2213018,
		0,
		Lang.get(19358),
		2213,
		18,
		104,
		{
			RTResTalkAction[51],
			RTResTalkAction[42]
		}
	},
	[2213019] = {
		2213019,
		0,
		Lang.get(19359),
		2213,
		19,
		123,
		{
			RTResTalkAction[54],
			RTResTalkAction[52]
		}
	},
	[2213020] = {
		2213020,
		0,
		Lang.get(19360),
		2213,
		20,
		123,
		{
			RTResTalkAction[54]
		}
	},
	[2213021] = {
		2213021,
		0,
		Lang.get(19361),
		2213,
		21,
		107,
		{
			RTResTalkAction[11],
			RTResTalkAction[42]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		2235,
		nil,
		1,
		1,
		nil,
		2235
	},
	[2213022] = {
		2213022,
		0,
		Lang.get(19362),
		2213,
		22,
		141,
		{
			RTResTalkAction[8],
			RTResTalkAction[12]
		}
	},
	[2213023] = {
		2213023,
		0,
		Lang.get(19363),
		2213,
		23,
		104,
		{
			RTResTalkAction[51],
			RTResTalkAction[10]
		}
	},
	[2213024] = {
		2213024,
		0,
		Lang.get(19364),
		2213,
		24,
		107,
		{
			RTResTalkAction[11],
			RTResTalkAction[52]
		}
	},
	[2213025] = {
		2213025,
		0,
		Lang.get(19365),
		2213,
		25,
		104,
		{
			RTResTalkAction[51],
			RTResTalkAction[12]
		}
	},
	[2213026] = {
		2213026,
		0,
		Lang.get(19366),
		2213,
		26,
		107,
		{
			RTResTalkAction[11],
			RTResTalkAction[52]
		}
	},
	[2213027] = {
		2213027,
		0,
		Lang.get(19367),
		2213,
		27,
		147,
		{
			RTResTalkAction[22],
			RTResTalkAction[12]
		}
	},
	[2215001] = {
		2215001,
		0,
		Lang.get(19514),
		2215,
		1,
		107,
		nil,
		1,
		2,
		nil,
		nil,
		57,
		2225,
		0.8,
		1,
		1,
		nil,
		2225
	},
	[2215002] = {
		2215002,
		0,
		Lang.get(19515),
		2215,
		2,
		123,
		nil,
		1,
		0
	},
	[2215003] = {
		2215003,
		0,
		Lang.get(19516),
		2215,
		3,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		2236,
		nil,
		nil,
		1,
		nil,
		2236
	},
	[2215004] = {
		2215004,
		0,
		Lang.get(19517),
		2215,
		4,
		107,
		nil,
		1
	},
	[2215005] = {
		2215005,
		0,
		Lang.get(19271),
		2215,
		5,
		110,
		{
			RTResTalkAction[66]
		},
		nil,
		nil,
		3
	},
	[2215006] = {
		2215006,
		0,
		Lang.get(19518),
		2215,
		6,
		110,
		{
			RTResTalkAction[66]
		}
	},
	[2215007] = {
		2215007,
		0,
		Lang.get(19519),
		2215,
		7,
		147,
		{
			RTResTalkAction[22],
			RTResTalkAction[69]
		}
	},
	[2215008] = {
		2215008,
		0,
		Lang.get(19520),
		2215,
		8,
		110,
		{
			RTResTalkAction[66],
			RTResTalkAction[23]
		}
	},
	[2215009] = {
		2215009,
		0,
		Lang.get(19522),
		2215,
		9,
		107,
		{
			RTResTalkAction[11],
			RTResTalkAction[69]
		},
		nil,
		nil,
		nil,
		nil,
		60
	},
	[2215010] = {
		2215010,
		0,
		Lang.get(19523),
		2215,
		10,
		147,
		{
			RTResTalkAction[22],
			RTResTalkAction[12]
		}
	},
	[2215011] = {
		2215011,
		0,
		Lang.get(19524),
		2215,
		11,
		107,
		{
			RTResTalkAction[30],
			RTResTalkAction[35],
			RTResTalkAction[23]
		}
	},
	[2215012] = {
		2215012,
		0,
		Lang.get(19525),
		2215,
		12,
		141,
		{
			RTResTalkAction[30],
			RTResTalkAction[35]
		}
	},
	[2215013] = {
		2215013,
		0,
		Lang.get(19526),
		2215,
		13,
		147,
		{
			RTResTalkAction[22],
			RTResTalkAction[12],
			RTResTalkAction[10]
		}
	},
	[2215014] = {
		2215014,
		0,
		Lang.get(19527),
		2215,
		14,
		107,
		{
			RTResTalkAction[30],
			RTResTalkAction[35],
			RTResTalkAction[23]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		2256,
		nil,
		1,
		nil,
		nil,
		2256
	},
	[2215015] = {
		2215015,
		0,
		Lang.get(37951),
		2215,
		15,
		141,
		{
			RTResTalkAction[30],
			RTResTalkAction[35]
		},
		1
	},
	[2215016] = {
		2215016,
		0,
		Lang.get(19529),
		2215,
		16,
		107,
		{
			RTResTalkAction[30],
			RTResTalkAction[35]
		},
		[19] = 3
	},
	[2215017] = {
		2215017,
		0,
		Lang.get(19530),
		2215,
		17,
		147,
		{
			RTResTalkAction[22],
			RTResTalkAction[12],
			RTResTalkAction[10]
		}
	},
	[2215018] = {
		2215018,
		0,
		Lang.get(19531),
		2215,
		18,
		107,
		{
			RTResTalkAction[30],
			RTResTalkAction[35],
			RTResTalkAction[23]
		}
	},
	[2215019] = {
		2215019,
		0,
		Lang.get(46234),
		2215,
		19,
		141,
		{
			RTResTalkAction[30],
			RTResTalkAction[35]
		}
	},
	[2216001] = {
		2216001,
		0,
		Lang.get(19532),
		2216,
		1,
		107,
		nil,
		1,
		5,
		nil,
		nil,
		60,
		2226,
		0.5,
		1,
		1,
		nil,
		2226
	},
	[2216002] = {
		2216002,
		0,
		Lang.get(19533),
		2216,
		2,
		147,
		nil,
		1,
		0
	},
	[2216003] = {
		2216003,
		0,
		Lang.get(19534),
		2216,
		3,
		104,
		{
			RTResTalkAction[51]
		},
		nil,
		nil,
		3
	},
	[2216004] = {
		2216004,
		0,
		Lang.get(19535),
		2216,
		4,
		107,
		{
			RTResTalkAction[76],
			RTResTalkAction[52]
		}
	},
	[2216005] = {
		2216005,
		0,
		Lang.get(19536),
		2216,
		5,
		107,
		{
			RTResTalkAction[11]
		}
	},
	[2216006] = {
		2216006,
		0,
		Lang.get(19537),
		2216,
		6,
		141,
		{
			RTResTalkAction[8],
			RTResTalkAction[12]
		}
	},
	[2216007] = {
		2216007,
		0,
		Lang.get(19538),
		2216,
		7,
		107,
		{
			RTResTalkAction[17],
			RTResTalkAction[10]
		}
	},
	[2216008] = {
		2216008,
		0,
		Lang.get(19539),
		2216,
		8,
		107,
		{
			RTResTalkAction[11]
		}
	},
	[2216009] = {
		2216009,
		0,
		Lang.get(19540),
		2216,
		9,
		107,
		{
			RTResTalkAction[11]
		}
	},
	[2216010] = {
		2216010,
		0,
		Lang.get(19541),
		2216,
		10,
		141,
		{
			RTResTalkAction[90],
			RTResTalkAction[12]
		}
	},
	[2216011] = {
		2216011,
		0,
		Lang.get(19542),
		2216,
		11,
		107,
		{
			RTResTalkAction[32],
			RTResTalkAction[10]
		}
	},
	[2217001] = {
		2217001,
		0,
		Lang.get(19543),
		2217,
		1,
		12,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		2227,
		0.8,
		1,
		1,
		nil,
		2227
	},
	[2217002] = {
		2217002,
		0,
		Lang.get(19544),
		2217,
		2,
		16,
		nil,
		1
	},
	[2217003] = {
		2217003,
		0,
		Lang.get(19545),
		2217,
		3,
		12,
		nil,
		1
	},
	[2217004] = {
		2217004,
		0,
		Lang.get(19546),
		2217,
		4,
		12,
		{
			RTResTalkAction[91]
		},
		nil,
		nil,
		3
	},
	[2217005] = {
		2217005,
		0,
		Lang.get(19547),
		2217,
		5,
		16,
		{
			RTResTalkAction[92],
			RTResTalkAction[93]
		}
	},
	[2217006] = {
		2217006,
		0,
		Lang.get(19548),
		2217,
		6,
		12,
		{
			RTResTalkAction[92],
			RTResTalkAction[93]
		}
	},
	[2217007] = {
		2217007,
		0,
		Lang.get(19549),
		2217,
		7,
		16,
		{
			RTResTalkAction[92],
			RTResTalkAction[93]
		}
	},
	[2217008] = {
		2217008,
		0,
		Lang.get(19550),
		2217,
		8,
		16,
		{
			RTResTalkAction[92],
			RTResTalkAction[93]
		}
	},
	[2217009] = {
		2217009,
		0,
		Lang.get(19551),
		2217,
		9,
		12,
		{
			RTResTalkAction[92],
			RTResTalkAction[93]
		}
	},
	[2217010] = {
		2217010,
		0,
		Lang.get(19552),
		2217,
		10,
		16,
		{
			RTResTalkAction[92],
			RTResTalkAction[93]
		}
	},
	[2217011] = {
		2217011,
		0,
		Lang.get(19553),
		2217,
		11,
		16,
		{
			RTResTalkAction[92],
			RTResTalkAction[93]
		}
	},
	[2217012] = {
		2217012,
		0,
		Lang.get(19554),
		2217,
		12,
		12,
		{
			RTResTalkAction[92],
			RTResTalkAction[93]
		}
	},
	[2217013] = {
		2217013,
		0,
		Lang.get(19555),
		2217,
		13,
		123,
		{
			RTResTalkAction[94],
			RTResTalkAction[95],
			RTResTalkAction[96]
		}
	},
	[2218001] = {
		2218001,
		0,
		Lang.get(37974),
		2218,
		1,
		350,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		2246,
		0.5,
		1,
		1,
		nil,
		2246
	},
	[2218002] = {
		2218002,
		0,
		Lang.get(37975),
		2218,
		2,
		350,
		nil,
		1
	},
	[2218003] = {
		2218003,
		0,
		Lang.get(37976),
		2218,
		3,
		188,
		nil,
		1
	},
	[2218004] = {
		2218004,
		0,
		Lang.get(37977),
		2218,
		4,
		350,
		nil,
		1
	},
	[2218005] = {
		2218005,
		0,
		Lang.get(37978),
		2218,
		5,
		188,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		2229,
		[18] = 2229
	},
	[2218006] = {
		2218006,
		0,
		Lang.get(37979),
		2218,
		6,
		164,
		nil,
		1
	},
	[2218007] = {
		2218007,
		0,
		Lang.get(37980),
		2218,
		7,
		350,
		nil,
		1
	},
	[2218008] = {
		2218008,
		0,
		Lang.get(37981),
		2218,
		8,
		164,
		{
			RTResTalkAction[38]
		},
		nil,
		nil,
		3
	},
	[2218009] = {
		2218009,
		0,
		Lang.get(37982),
		2218,
		9,
		188,
		{
			RTResTalkAction[97],
			RTResTalkAction[45]
		}
	},
	[2218010] = {
		2218010,
		0,
		Lang.get(37983),
		2218,
		10,
		164,
		{
			RTResTalkAction[38],
			RTResTalkAction[98]
		}
	},
	[2218011] = {
		2218011,
		0,
		Lang.get(37984),
		2218,
		11,
		112,
		{
			RTResTalkAction[45]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		2230,
		0.5,
		1,
		1,
		nil,
		2230
	},
	[2218012] = {
		2218012,
		0,
		Lang.get(37985),
		2218,
		12,
		148,
		nil,
		1
	},
	[2218013] = {
		2218013,
		0,
		Lang.get(37986),
		2218,
		13,
		112,
		{
			RTResTalkAction[59]
		},
		nil,
		nil,
		3
	},
	[2218014] = {
		2218014,
		0,
		Lang.get(37987),
		2218,
		14,
		148,
		{
			RTResTalkAction[25],
			RTResTalkAction[27]
		}
	},
	[2218015] = {
		2218015,
		0,
		Lang.get(37988),
		2218,
		15,
		112,
		{
			RTResTalkAction[25],
			RTResTalkAction[27]
		}
	},
	[2218016] = {
		2218016,
		0,
		Lang.get(46235),
		2218,
		16,
		148,
		{
			RTResTalkAction[25],
			RTResTalkAction[27]
		}
	},
	[2218017] = {
		2218017,
		0,
		Lang.get(37989),
		2218,
		17,
		112,
		{
			RTResTalkAction[25],
			RTResTalkAction[27]
		}
	},
	[2218018] = {
		2218018,
		0,
		Lang.get(37990),
		2218,
		18,
		112,
		{
			RTResTalkAction[25],
			RTResTalkAction[27]
		}
	},
	[2218019] = {
		2218019,
		0,
		Lang.get(46236),
		2218,
		19,
		148,
		{
			RTResTalkAction[25],
			RTResTalkAction[27]
		}
	},
	[2218020] = {
		2218020,
		0,
		Lang.get(37991),
		2218,
		20,
		112,
		{
			RTResTalkAction[25],
			RTResTalkAction[27]
		}
	},
	[2218021] = {
		2218021,
		0,
		Lang.get(37992),
		2218,
		21,
		112,
		{
			RTResTalkAction[25],
			RTResTalkAction[27]
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
