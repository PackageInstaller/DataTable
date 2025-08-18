-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\zhuxian43\\ResTalk.lua

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
	1132,
	nil,
	nil,
	0
}
RTResTalkAction[2] = {
	2,
	1132,
	nil,
	nil,
	0
}
RTResTalkAction[3] = {
	3,
	188,
	nil,
	nil,
	4
}
RTResTalkAction[4] = {
	1,
	194,
	nil,
	nil,
	0
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 1132
}
RTResTalkAction[6] = {
	[1] = 0,
	[2] = 188
}
RTResTalkAction[7] = {
	[1] = 0,
	[2] = 194
}
RTResTalkAction[8] = {
	[1] = 2,
	[2] = 1132
}
RTResTalkAction[9] = {
	3,
	188,
	nil,
	nil,
	3
}
RTResTalkAction[10] = {
	2,
	1132,
	nil,
	nil,
	1
}
RTResTalkAction[11] = {
	3,
	194,
	nil,
	nil,
	0
}
RTResTalkAction[12] = {
	1,
	188,
	nil,
	nil,
	3
}
RTResTalkAction[13] = {
	1,
	194,
	nil,
	nil,
	1
}
RTResTalkAction[14] = {
	1,
	1132,
	nil,
	nil,
	2
}
RTResTalkAction[15] = {
	[1] = 1,
	[2] = 194,
	[3] = {
		2
	}
}
RTResTalkAction[16] = {
	[1] = 1,
	[2] = 194,
	[3] = {
		3
	}
}
RTResTalkAction[17] = {
	1,
	207,
	nil,
	nil,
	0
}
RTResTalkAction[18] = {
	1,
	158,
	nil,
	nil,
	6
}
RTResTalkAction[19] = {
	[1] = 0,
	[2] = 207
}
RTResTalkAction[20] = {
	1,
	119,
	nil,
	nil,
	2
}
RTResTalkAction[21] = {
	[1] = 0,
	[2] = 158
}
RTResTalkAction[22] = {
	1,
	151,
	nil,
	nil,
	0
}
RTResTalkAction[23] = {
	[1] = 0,
	[2] = 119
}
RTResTalkAction[24] = {
	1,
	771,
	nil,
	nil,
	4
}
RTResTalkAction[25] = {
	[1] = 0,
	[2] = 151
}
RTResTalkAction[26] = {
	[1] = 0,
	[2] = 771
}
RTResTalkAction[27] = {
	1,
	301,
	nil,
	nil,
	0
}
RTResTalkAction[28] = {
	1,
	215,
	nil,
	nil,
	0
}
RTResTalkAction[29] = {
	[1] = 0,
	[2] = 301
}
RTResTalkAction[30] = {
	1,
	112,
	nil,
	nil,
	3
}
RTResTalkAction[31] = {
	[1] = 0,
	[2] = 215
}
RTResTalkAction[32] = {
	1,
	112,
	nil,
	nil,
	1
}
RTResTalkAction[33] = {
	[1] = 0,
	[2] = 112
}
RTResTalkAction[34] = {
	1,
	148,
	nil,
	nil,
	0
}
RTResTalkAction[35] = {
	1,
	148,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[36] = {
	[1] = 4,
	[2] = 688
}
RTResTalkAction[37] = {
	[1] = 1,
	[2] = 672,
	[3] = {
		3
	}
}
RTResTalkAction[38] = {
	[1] = 5,
	[2] = 657
}
RTResTalkAction[39] = {
	1,
	215,
	nil,
	nil,
	3
}
RTResTalkAction[40] = {
	[1] = 0,
	[2] = 688
}
RTResTalkAction[41] = {
	[1] = 0,
	[2] = 672
}
RTResTalkAction[42] = {
	[1] = 0,
	[2] = 657
}
RTResTalkAction[43] = {
	1,
	220,
	nil,
	nil,
	3
}
RTResTalkAction[44] = {
	1,
	225,
	nil,
	nil,
	0
}
RTResTalkAction[45] = {
	[1] = 0,
	[2] = 220
}
RTResTalkAction[46] = {
	1,
	140,
	nil,
	nil,
	0
}
RTResTalkAction[47] = {
	[1] = 0,
	[2] = 225
}
RTResTalkAction[48] = {
	2,
	140,
	nil,
	nil,
	0
}
RTResTalkAction[49] = {
	3,
	128,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[50] = {
	[1] = 3,
	[2] = 128
}
RTResTalkAction[51] = {
	[1] = 0,
	[2] = 140
}
RTResTalkAction[52] = {
	[1] = 0,
	[2] = 128
}
RTResTalkAction[53] = {
	1,
	109,
	nil,
	nil,
	0
}
RTResTalkAction[54] = {
	1,
	772,
	nil,
	nil,
	0
}
RTResTalkAction[55] = {
	[1] = 0,
	[2] = 109
}
RTResTalkAction[56] = {
	2,
	101,
	nil,
	nil,
	0
}
RTResTalkAction[57] = {
	[1] = 3,
	[2] = 772
}
RTResTalkAction[58] = {
	[1] = 0,
	[2] = 101
}
RTResTalkAction[59] = {
	[1] = 0,
	[2] = 772
}
RTResTalkAction[60] = {
	1,
	117,
	nil,
	nil,
	0
}
RTResTalkAction[61] = {
	[1] = 2,
	[2] = 117
}
RTResTalkAction[62] = {
	3,
	127,
	nil,
	nil,
	0
}
RTResTalkAction[63] = {
	[1] = 3,
	[2] = 127
}
RTResTalkAction[64] = {
	[1] = 3,
	[2] = 127,
	[3] = {
		2
	}
}
RTResTalkAction[65] = {
	[1] = 0,
	[2] = 117
}
RTResTalkAction[66] = {
	[1] = 0,
	[2] = 127
}
RTResTalkAction[67] = {
	1,
	117,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[68] = {
	[1] = 1,
	[2] = 117
}
RTResTalkAction[69] = {
	1,
	767,
	nil,
	nil,
	0
}
RTResTalkAction[70] = {
	[1] = 1,
	[2] = 767
}
RTResTalkAction[71] = {
	1,
	767,
	nil,
	nil,
	4
}
RTResTalkAction[72] = {
	1,
	767,
	nil,
	nil,
	1
}
RTResTalkAction[73] = {
	[1] = 1,
	[2] = 148
}
RTResTalkAction[74] = {
	[1] = 2,
	[2] = 148
}
RTResTalkAction[75] = {
	3,
	112,
	nil,
	nil,
	1
}
RTResTalkAction[76] = {
	[1] = 3,
	[2] = 112
}
RTResTalkAction[77] = {
	3,
	112,
	nil,
	nil,
	2
}
RTResTalkAction[78] = {
	[1] = 2,
	[2] = 148,
	[3] = {
		1
	}
}
RTResTalkAction[79] = {
	[1] = 3,
	[2] = 112,
	[3] = {
		2
	}
}
RTResTalkAction[80] = {
	3,
	112,
	nil,
	nil,
	3
}
RTResTalkAction[81] = {
	[1] = 0,
	[2] = 148
}
RTResTalkAction[82] = {
	[1] = 1,
	[2] = 207
}
RTResTalkAction[83] = {
	[1] = 2,
	[2] = 207
}
RTResTalkAction[84] = {
	3,
	632,
	{
		3
	},
	nil,
	3
}
RTResTalkAction[85] = {
	1,
	143,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[86] = {
	[1] = 0,
	[2] = 632
}
RTResTalkAction[87] = {
	1,
	207,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[88] = {
	[1] = 0,
	[2] = 143
}
RTResTalkAction[89] = {
	[1] = 1,
	[2] = 122,
	[3] = {
		3
	}
}
RTResTalkAction[90] = {
	[1] = 1,
	[2] = 175
}
RTResTalkAction[91] = {
	[1] = 0,
	[2] = 122
}
RTResTalkAction[92] = {
	1,
	175,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[93] = {
	[1] = 1,
	[2] = 175,
	[3] = {
		3
	}
}
RTResTalkAction[94] = {
	[1] = 1,
	[2] = 207,
	[3] = {
		2
	}
}
RTResTalkAction[95] = {
	[1] = 0,
	[2] = 175
}
RTResTalkAction[96] = {
	1,
	1272,
	nil,
	nil,
	0
}
RTResTalkAction[97] = {
	[1] = 0,
	[2] = 1272
}
RTResTalkAction[98] = {
	[1] = 1,
	[2] = 1272
}
RTResTalkAction[99] = {
	[1] = 1,
	[2] = 1272,
	[3] = {
		2
	}
}
RTResTalkAction[100] = {
	[1] = 2,
	[2] = 1272
}
RTResTalkAction[101] = {
	3,
	1273,
	nil,
	nil,
	0
}
RTResTalkAction[102] = {
	[1] = 3,
	[2] = 1273
}
RTResTalkAction[103] = {
	[1] = 0,
	[2] = 1273
}
RTResTalkAction[104] = {
	1,
	632,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[105] = {
	1,
	122,
	nil,
	nil,
	1
}
RTResTalkAction[106] = {
	1,
	122,
	nil,
	nil,
	2
}
RTResTalkAction[107] = {
	1,
	143,
	{
		1
	},
	nil,
	4
}
RTResTalkAction[108] = {
	3,
	632,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[109] = {
	2,
	207,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[110] = {
	[1] = 3,
	[2] = 632
}
RTResTalkAction[111] = {
	[1] = 2,
	[2] = 148,
	[3] = {
		2
	}
}
RTResTalkAction[112] = {
	1,
	767,
	nil,
	nil,
	2
}
RTResTalkAction[113] = {
	2,
	257,
	nil,
	nil,
	0
}
RTResTalkAction[114] = {
	[1] = 3,
	[2] = 1269
}
RTResTalkAction[115] = {
	[1] = 0,
	[2] = 767
}
RTResTalkAction[116] = {
	[1] = 2,
	[2] = 257
}
RTResTalkAction[117] = {
	[1] = 0,
	[2] = 257
}
RTResTalkAction[118] = {
	[1] = 0,
	[2] = 1269
}
RTResTalkAction[119] = {
	[1] = 3,
	[2] = 767
}
RTResTalkAction[120] = {
	[1] = 1,
	[2] = 257
}
RTResTalkAction[121] = {
	[1] = 1,
	[2] = 1269
}
RTResTalkAction[122] = {
	1,
	1269,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[123] = {
	1,
	767,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[124] = {
	3,
	767,
	nil,
	nil,
	4
}
RTResTalkAction[125] = {
	3,
	767,
	nil,
	nil,
	1
}
RTResTalkAction[126] = {
	[1] = 1,
	[2] = 1271
}
RTResTalkAction[127] = {
	[1] = 0,
	[2] = 1271
}
RTResTalkAction[128] = {
	1,
	1269,
	nil,
	nil,
	0
}
RTResTalkAction[129] = {
	1,
	215,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[130] = {
	[1] = 2,
	[2] = 215
}
RTResTalkAction[131] = {
	3,
	220,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[132] = {
	[1] = 1,
	[2] = 215
}
RTResTalkAction[133] = {
	1,
	215,
	nil,
	nil,
	1
}
RTResTalkAction[134] = {
	[1] = 1,
	[2] = 112
}
RTResTalkAction[135] = {
	1,
	112,
	nil,
	nil,
	2
}
RTResTalkAction[136] = {
	1,
	257,
	nil,
	nil,
	0
}
RTResTalkAction[137] = {
	[1] = 1,
	[2] = 257,
	[3] = {
		1
	}
}
RTResTalkAction[138] = {
	1,
	257,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[139] = {
	[1] = 1,
	[2] = 236
}
RTResTalkAction[140] = {
	[1] = 0,
	[2] = 236
}
RTResTalkAction[141] = {
	[1] = 1,
	[2] = 241
}
RTResTalkAction[142] = {
	[1] = 0,
	[2] = 241
}
RTResTalkAction[143] = {
	1,
	767,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[144] = {
	1,
	767,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[145] = {
	[1] = 1,
	[2] = 767,
	[3] = {
		3
	}
}
RTResTalkAction[146] = {
	1,
	767,
	{
		3
	},
	nil,
	3
}
RTResTalkAction[147] = {
	1,
	767,
	nil,
	nil,
	3
}
RTResTalkAction[148] = {
	1,
	241,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[149] = {
	1,
	244,
	nil,
	nil,
	3
}
RTResTalkAction[150] = {
	[1] = 0,
	[2] = 244
}
RTResTalkAction[151] = {
	[1] = 1,
	[2] = 220
}
RTResTalkAction[152] = {
	1,
	215,
	{
		1
	},
	nil,
	3
}
RTResTalkAction[153] = {
	2,
	244,
	nil,
	nil,
	3
}
RTResTalkAction[154] = {
	[1] = 3,
	[2] = 215
}
RTResTalkAction[155] = {
	[1] = 2,
	[2] = 244
}
RTResTalkAction[156] = {
	3,
	215,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[157] = {
	[1] = 1,
	[2] = 244
}
RTResTalkAction[158] = {
	3,
	767,
	nil,
	nil,
	0
}
RTResTalkAction[159] = {
	1,
	767,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[160] = {
	[1] = 2,
	[2] = 257,
	[3] = {
		3
	}
}
RTResTalkAction[161] = {
	[1] = 1,
	[2] = 257,
	[3] = {
		2
	}
}
RTResTalkAction[162] = {
	1,
	187,
	nil,
	nil,
	0
}
RTResTalkAction[163] = {
	1,
	187,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[164] = {
	[1] = 0,
	[2] = 187
}
RTResTalkAction[165] = {
	1,
	244,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[166] = {
	[1] = 1,
	[2] = 219
}
RTResTalkAction[167] = {
	[1] = 2,
	[2] = 219
}
RTResTalkAction[168] = {
	[1] = 3,
	[2] = 152
}
RTResTalkAction[169] = {
	[1] = 0,
	[2] = 219
}
RTResTalkAction[170] = {
	[1] = 0,
	[2] = 152
}
RTResTalkAction[171] = {
	1,
	332,
	nil,
	nil,
	0
}
RTResTalkAction[172] = {
	[1] = 1,
	[2] = 332
}

local Data = {
	[40351001] = {
		40351001,
		3,
		Lang.get(107104),
		40351,
		1,
		605,
		nil,
		nil,
		nil,
		3,
		nil,
		122,
		40351,
		nil,
		nil,
		nil,
		nil,
		nil,
		40351,
		nil,
		nil,
		1
	},
	[40351002] = {
		40351002,
		0,
		Lang.get(107105),
		40351,
		2,
		1132,
		{
			RTResTalkAction[1]
		}
	},
	[40351003] = {
		40351003,
		0,
		Lang.get(107106),
		40351,
		3,
		188,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[40351004] = {
		40351004,
		3,
		Lang.get(107107),
		40351,
		4,
		605,
		{
			RTResTalkAction[4],
			RTResTalkAction[5],
			RTResTalkAction[6]
		},
		[22] = 1
	},
	[40351005] = {
		40351005,
		0,
		Lang.get(107108),
		40351,
		5,
		1132,
		{
			RTResTalkAction[2],
			RTResTalkAction[3],
			RTResTalkAction[7]
		}
	},
	[40351006] = {
		40351006,
		0,
		Lang.get(107109),
		40351,
		6,
		188,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[40351007] = {
		40351007,
		0,
		Lang.get(107110),
		40351,
		7,
		194,
		{
			RTResTalkAction[4],
			RTResTalkAction[5],
			RTResTalkAction[6]
		}
	},
	[40351008] = {
		40351008,
		0,
		Lang.get(107111),
		40351,
		8,
		1132,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[40351009] = {
		40351009,
		0,
		Lang.get(107112),
		40351,
		9,
		194,
		{
			RTResTalkAction[8],
			RTResTalkAction[11]
		}
	},
	[40351010] = {
		40351010,
		0,
		Lang.get(107113),
		40351,
		10,
		1132,
		{
			RTResTalkAction[2],
			RTResTalkAction[11]
		}
	},
	[40351011] = {
		40351011,
		0,
		Lang.get(107114),
		40351,
		11,
		188,
		{
			RTResTalkAction[12],
			RTResTalkAction[5],
			RTResTalkAction[7]
		}
	},
	[40351012] = {
		40351012,
		0,
		Lang.get(107115),
		40351,
		12,
		194,
		{
			RTResTalkAction[13],
			RTResTalkAction[6]
		}
	},
	[40351013] = {
		40351013,
		0,
		Lang.get(22477),
		40351,
		13,
		1132,
		{
			RTResTalkAction[14],
			RTResTalkAction[7]
		}
	},
	[40351014] = {
		40351014,
		0,
		Lang.get(107116),
		40351,
		14,
		194,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[40351015] = {
		40351015,
		0,
		Lang.get(107117),
		40351,
		15,
		1132,
		{
			RTResTalkAction[1],
			RTResTalkAction[7]
		}
	},
	[40351016] = {
		40351016,
		0,
		Lang.get(107118),
		40351,
		16,
		194,
		{
			RTResTalkAction[15],
			RTResTalkAction[5]
		}
	},
	[40351017] = {
		40351017,
		3,
		Lang.get(107119),
		40351,
		17,
		605,
		{
			RTResTalkAction[16]
		},
		[22] = 1
	},
	[40351018] = {
		40351018,
		3,
		Lang.get(107120),
		40351,
		18,
		605,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3,
		nil,
		161,
		40352,
		1,
		1,
		nil,
		1,
		nil,
		40352,
		nil,
		nil,
		1
	},
	[40351019] = {
		40351019,
		13,
		Lang.get(107121),
		40351,
		19,
		207,
		{
			RTResTalkAction[17]
		},
		[27] = 3
	},
	[40351020] = {
		40351020,
		13,
		Lang.get(107122),
		40351,
		20,
		158,
		{
			RTResTalkAction[18],
			RTResTalkAction[19]
		},
		[27] = 3
	},
	[40351021] = {
		40351021,
		13,
		Lang.get(107123),
		40351,
		21,
		119,
		{
			RTResTalkAction[20],
			RTResTalkAction[21]
		},
		[27] = 3
	},
	[40351022] = {
		40351022,
		13,
		Lang.get(107124),
		40351,
		22,
		151,
		{
			RTResTalkAction[22],
			RTResTalkAction[23]
		},
		[27] = 3
	},
	[40351023] = {
		40351023,
		13,
		Lang.get(107125),
		40351,
		23,
		771,
		{
			RTResTalkAction[24],
			RTResTalkAction[25]
		},
		[27] = 3
	},
	[40351024] = {
		40351024,
		3,
		Lang.get(21922),
		40351,
		24,
		605,
		{
			RTResTalkAction[26]
		},
		nil,
		nil,
		nil,
		2745,
		[22] = 1
	},
	[40351025] = {
		40351025,
		13,
		Lang.get(107126),
		40351,
		25,
		301,
		{
			RTResTalkAction[27]
		},
		[27] = 3
	},
	[40351026] = {
		40351026,
		0,
		Lang.get(107127),
		40351,
		26,
		215,
		{
			RTResTalkAction[28],
			RTResTalkAction[29]
		}
	},
	[40351027] = {
		40351027,
		0,
		Lang.get(107128),
		40351,
		27,
		112,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[40351028] = {
		40351028,
		0,
		Lang.get(107129),
		40351,
		28,
		112,
		{
			RTResTalkAction[32]
		}
	},
	[40351029] = {
		40351029,
		3,
		Lang.get(107130),
		40351,
		29,
		605,
		{
			RTResTalkAction[33]
		},
		nil,
		nil,
		nil,
		nil,
		163,
		[22] = 1
	},
	[40351030] = {
		40351030,
		0,
		Lang.get(107131),
		40351,
		30,
		148,
		{
			RTResTalkAction[34]
		}
	},
	[40351031] = {
		40351031,
		0,
		Lang.get(107132),
		40351,
		31,
		148,
		{
			RTResTalkAction[34]
		}
	},
	[40351032] = {
		40351032,
		0,
		Lang.get(107133),
		40351,
		32,
		148,
		{
			RTResTalkAction[34]
		}
	},
	[40351033] = {
		40351033,
		0,
		Lang.get(107134),
		40351,
		33,
		148,
		{
			RTResTalkAction[34]
		}
	},
	[40351034] = {
		40351034,
		0,
		Lang.get(107135),
		40351,
		34,
		148,
		{
			RTResTalkAction[34]
		}
	},
	[40351035] = {
		40351035,
		5,
		Lang.get(107136),
		40351,
		35,
		148,
		{
			RTResTalkAction[34]
		}
	},
	[40351036] = {
		40351036,
		5,
		Lang.get(107137),
		40351,
		36,
		148,
		{
			RTResTalkAction[35]
		}
	},
	[40352001] = {
		40352001,
		3,
		Lang.get(107138),
		40352,
		1,
		605,
		nil,
		nil,
		nil,
		3,
		nil,
		148,
		40355,
		nil,
		nil,
		nil,
		nil,
		nil,
		40355,
		nil,
		nil,
		1
	},
	[40352002] = {
		40352002,
		0,
		Lang.get(107139),
		40352,
		2,
		672,
		{
			RTResTalkAction[36],
			RTResTalkAction[37],
			RTResTalkAction[38]
		}
	},
	[40352003] = {
		40352003,
		0,
		Lang.get(107140),
		40352,
		3,
		215,
		{
			RTResTalkAction[39],
			RTResTalkAction[40],
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[40352004] = {
		40352004,
		0,
		Lang.get(107141),
		40352,
		4,
		220,
		{
			RTResTalkAction[43],
			RTResTalkAction[31]
		}
	},
	[40352005] = {
		40352005,
		0,
		Lang.get(107142),
		40352,
		5,
		225,
		{
			RTResTalkAction[44],
			RTResTalkAction[45]
		}
	},
	[40352006] = {
		40352006,
		0,
		Lang.get(107143),
		40352,
		6,
		140,
		{
			RTResTalkAction[46],
			RTResTalkAction[47]
		}
	},
	[40352007] = {
		40352007,
		5,
		Lang.get(107144),
		40352,
		7,
		128,
		{
			RTResTalkAction[48],
			RTResTalkAction[49]
		}
	},
	[40352008] = {
		40352008,
		3,
		Lang.get(107145),
		40352,
		8,
		605,
		{
			RTResTalkAction[48],
			RTResTalkAction[50]
		},
		[22] = 1
	},
	[40352009] = {
		40352009,
		0,
		Lang.get(107146),
		40352,
		9,
		128,
		{
			RTResTalkAction[48],
			RTResTalkAction[50]
		}
	},
	[40352010] = {
		40352010,
		0,
		Lang.get(107147),
		40352,
		10,
		140,
		{
			RTResTalkAction[48],
			RTResTalkAction[50]
		}
	},
	[40352011] = {
		40352011,
		3,
		Lang.get(107148),
		40352,
		11,
		605,
		{
			RTResTalkAction[51],
			RTResTalkAction[52]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		40356,
		1,
		1,
		nil,
		1,
		nil,
		40356,
		nil,
		nil,
		1
	},
	[40352012] = {
		40352012,
		0,
		Lang.get(107149),
		40352,
		12,
		109,
		{
			RTResTalkAction[53]
		}
	},
	[40352013] = {
		40352013,
		5,
		Lang.get(107150),
		40352,
		13,
		772,
		{
			RTResTalkAction[54],
			RTResTalkAction[55]
		}
	},
	[40352014] = {
		40352014,
		5,
		Lang.get(107151),
		40352,
		14,
		101,
		{
			RTResTalkAction[56],
			RTResTalkAction[57]
		}
	},
	[40352015] = {
		40352015,
		3,
		Lang.get(107152),
		40352,
		15,
		605,
		{
			RTResTalkAction[58],
			RTResTalkAction[59]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		40357,
		1,
		1,
		nil,
		1,
		nil,
		40357,
		nil,
		nil,
		1
	},
	[40352016] = {
		40352016,
		0,
		Lang.get(107153),
		40352,
		16,
		117,
		{
			RTResTalkAction[60]
		}
	},
	[40352017] = {
		40352017,
		0,
		Lang.get(107154),
		40352,
		17,
		127,
		{
			RTResTalkAction[61],
			RTResTalkAction[62]
		}
	},
	[40352018] = {
		40352018,
		0,
		Lang.get(107155),
		40352,
		18,
		117,
		{
			RTResTalkAction[61],
			RTResTalkAction[63]
		}
	},
	[40352019] = {
		40352019,
		3,
		Lang.get(107156),
		40352,
		19,
		605,
		{
			RTResTalkAction[61],
			RTResTalkAction[63]
		},
		[22] = 1
	},
	[40352020] = {
		40352020,
		0,
		Lang.get(107157),
		40352,
		20,
		117,
		{
			RTResTalkAction[61],
			RTResTalkAction[63]
		}
	},
	[40352021] = {
		40352021,
		0,
		Lang.get(107158),
		40352,
		21,
		127,
		{
			RTResTalkAction[61],
			RTResTalkAction[64]
		}
	},
	[40352022] = {
		40352022,
		3,
		Lang.get(107159),
		40352,
		22,
		605,
		{
			RTResTalkAction[65],
			RTResTalkAction[66]
		},
		[22] = 1
	},
	[40352023] = {
		40352023,
		0,
		Lang.get(107160),
		40352,
		23,
		117,
		{
			RTResTalkAction[67]
		}
	},
	[40352024] = {
		40352024,
		3,
		Lang.get(107161),
		40352,
		24,
		605,
		{
			RTResTalkAction[68]
		},
		[22] = 1
	},
	[40352025] = {
		40352025,
		3,
		Lang.get(107162),
		40352,
		25,
		605,
		{
			RTResTalkAction[65]
		},
		nil,
		nil,
		3,
		nil,
		63,
		40358,
		1,
		1,
		nil,
		1,
		nil,
		40358,
		nil,
		nil,
		1
	},
	[40352026] = {
		40352026,
		0,
		Lang.get(107163),
		40352,
		26,
		767,
		{
			RTResTalkAction[69]
		}
	},
	[40352027] = {
		40352027,
		4,
		nil,
		40352,
		27,
		300,
		{
			RTResTalkAction[70]
		},
		[29] = {
			{
				id = 40352028,
				branch_content = Lang.get(107164)
			},
			{
				id = 40352028,
				branch_content = Lang.get(107165)
			}
		}
	},
	[40352028] = {
		40352028,
		0,
		Lang.get(107166),
		40352,
		28,
		767,
		{
			RTResTalkAction[71]
		}
	},
	[40352029] = {
		40352029,
		3,
		Lang.get(107167),
		40352,
		29,
		605,
		{
			RTResTalkAction[70]
		},
		[22] = 1
	},
	[40352030] = {
		40352030,
		0,
		Lang.get(107168),
		40352,
		30,
		767,
		{
			RTResTalkAction[72]
		}
	},
	[40352031] = {
		40352031,
		3,
		Lang.get(107169),
		40352,
		31,
		605,
		{
			RTResTalkAction[70]
		},
		nil,
		nil,
		3,
		[19] = 40359,
		[22] = 1
	},
	[40352032] = {
		40352032,
		3,
		Lang.get(107170),
		40352,
		32,
		605,
		{
			RTResTalkAction[70]
		},
		[22] = 1
	},
	[40352033] = {
		40352033,
		3,
		Lang.get(107171),
		40352,
		33,
		605,
		{
			RTResTalkAction[70]
		},
		[22] = 1
	},
	[40352034] = {
		40352034,
		0,
		Lang.get(25449),
		40352,
		34,
		300,
		{
			RTResTalkAction[70]
		}
	},
	[40352035] = {
		40352035,
		3,
		Lang.get(107172),
		40352,
		35,
		605,
		{
			RTResTalkAction[70]
		},
		[22] = 1
	},
	[40353001] = {
		40353001,
		3,
		Lang.get(107173),
		40353,
		1,
		605,
		nil,
		nil,
		nil,
		3,
		nil,
		122,
		40360,
		nil,
		nil,
		nil,
		nil,
		nil,
		40360,
		nil,
		nil,
		1
	},
	[40353002] = {
		40353002,
		0,
		Lang.get(107174),
		40353,
		2,
		148,
		{
			RTResTalkAction[34]
		}
	},
	[40353003] = {
		40353003,
		0,
		Lang.get(107175),
		40353,
		3,
		148,
		{
			RTResTalkAction[73]
		}
	},
	[40353004] = {
		40353004,
		0,
		Lang.get(107176),
		40353,
		4,
		112,
		{
			RTResTalkAction[74],
			RTResTalkAction[75]
		}
	},
	[40353005] = {
		40353005,
		0,
		Lang.get(107177),
		40353,
		5,
		112,
		{
			RTResTalkAction[74],
			RTResTalkAction[76]
		}
	},
	[40353006] = {
		40353006,
		0,
		Lang.get(107178),
		40353,
		6,
		112,
		{
			RTResTalkAction[74],
			RTResTalkAction[76]
		}
	},
	[40353007] = {
		40353007,
		0,
		Lang.get(107179),
		40353,
		7,
		148,
		{
			RTResTalkAction[74],
			RTResTalkAction[76]
		}
	},
	[40353008] = {
		40353008,
		0,
		Lang.get(107180),
		40353,
		8,
		112,
		{
			RTResTalkAction[74],
			RTResTalkAction[77]
		}
	},
	[40353009] = {
		40353009,
		0,
		Lang.get(107181),
		40353,
		9,
		148,
		{
			RTResTalkAction[74],
			RTResTalkAction[76]
		}
	},
	[40353010] = {
		40353010,
		0,
		Lang.get(107182),
		40353,
		10,
		112,
		{
			RTResTalkAction[74],
			RTResTalkAction[75]
		}
	},
	[40353011] = {
		40353011,
		0,
		Lang.get(107183),
		40353,
		11,
		148,
		{
			RTResTalkAction[74],
			RTResTalkAction[76]
		}
	},
	[40353012] = {
		40353012,
		0,
		Lang.get(107184),
		40353,
		12,
		112,
		{
			RTResTalkAction[74],
			RTResTalkAction[76]
		}
	},
	[40353013] = {
		40353013,
		0,
		Lang.get(21821),
		40353,
		13,
		148,
		{
			RTResTalkAction[78],
			RTResTalkAction[76]
		}
	},
	[40353014] = {
		40353014,
		0,
		Lang.get(107185),
		40353,
		14,
		112,
		{
			RTResTalkAction[74],
			RTResTalkAction[76]
		}
	},
	[40353015] = {
		40353015,
		0,
		Lang.get(107186),
		40353,
		15,
		148,
		{
			RTResTalkAction[74],
			RTResTalkAction[76]
		}
	},
	[40353016] = {
		40353016,
		0,
		Lang.get(107187),
		40353,
		16,
		112,
		{
			RTResTalkAction[74],
			RTResTalkAction[79]
		}
	},
	[40353017] = {
		40353017,
		0,
		Lang.get(107188),
		40353,
		17,
		148,
		{
			RTResTalkAction[74],
			RTResTalkAction[76]
		}
	},
	[40353018] = {
		40353018,
		0,
		Lang.get(107189),
		40353,
		18,
		112,
		{
			RTResTalkAction[74],
			RTResTalkAction[80]
		}
	},
	[40353019] = {
		40353019,
		3,
		Lang.get(107190),
		40353,
		19,
		605,
		{
			RTResTalkAction[81],
			RTResTalkAction[33]
		},
		nil,
		nil,
		3,
		nil,
		189,
		40361,
		1,
		1,
		nil,
		1,
		nil,
		40361,
		nil,
		nil,
		1
	},
	[40353020] = {
		40353020,
		0,
		Lang.get(107191),
		40353,
		20,
		207,
		{
			RTResTalkAction[82]
		}
	},
	[40353021] = {
		40353021,
		0,
		Lang.get(107192),
		40353,
		21,
		632,
		{
			RTResTalkAction[83],
			RTResTalkAction[84]
		},
		nil,
		nil,
		nil,
		2756
	},
	[40353022] = {
		40353022,
		0,
		Lang.get(107193),
		40353,
		22,
		143,
		{
			RTResTalkAction[85],
			RTResTalkAction[19],
			RTResTalkAction[86]
		}
	},
	[40353023] = {
		40353023,
		5,
		Lang.get(107194),
		40353,
		23,
		207,
		{
			RTResTalkAction[87],
			RTResTalkAction[88]
		}
	},
	[40353024] = {
		40353024,
		5,
		Lang.get(107195),
		40353,
		24,
		122,
		{
			RTResTalkAction[89],
			RTResTalkAction[19]
		}
	},
	[40353025] = {
		40353025,
		3,
		Lang.get(107196),
		40353,
		25,
		605,
		{
			RTResTalkAction[90],
			RTResTalkAction[91]
		},
		[22] = 1
	},
	[40353026] = {
		40353026,
		0,
		Lang.get(107197),
		40353,
		26,
		175,
		{
			RTResTalkAction[90]
		}
	},
	[40353027] = {
		40353027,
		0,
		Lang.get(107198),
		40353,
		27,
		207,
		{
			RTResTalkAction[90]
		},
		1,
		0
	},
	[40353028] = {
		40353028,
		0,
		Lang.get(107199),
		40353,
		28,
		632,
		{
			RTResTalkAction[90]
		},
		1,
		2
	},
	[40353029] = {
		40353029,
		0,
		Lang.get(107200),
		40353,
		29,
		122,
		{
			RTResTalkAction[90]
		},
		1,
		0
	},
	[40353030] = {
		40353030,
		0,
		Lang.get(107201),
		40353,
		30,
		175,
		{
			RTResTalkAction[92]
		}
	},
	[40353031] = {
		40353031,
		3,
		Lang.get(107202),
		40353,
		31,
		605,
		{
			RTResTalkAction[93]
		},
		[22] = 1
	},
	[40353032] = {
		40353032,
		0,
		Lang.get(107203),
		40353,
		32,
		207,
		{
			RTResTalkAction[94],
			RTResTalkAction[95]
		}
	},
	[40354001] = {
		40354001,
		9,
		Lang.get(107204),
		40354,
		1,
		605,
		nil,
		nil,
		nil,
		3,
		nil,
		194,
		40365,
		nil,
		nil,
		nil,
		nil,
		nil,
		40365,
		255,
		nil,
		1
	},
	[40354002] = {
		40354002,
		9,
		Lang.get(107205),
		40354,
		2,
		605,
		[22] = 1
	},
	[40354003] = {
		40354003,
		9,
		Lang.get(107206),
		40354,
		3,
		605,
		[22] = 1
	},
	[40354004] = {
		40354004,
		0,
		Lang.get(107207),
		40354,
		4,
		1274,
		nil,
		1,
		0,
		[20] = 255
	},
	[40354005] = {
		40354005,
		9,
		Lang.get(107208),
		40354,
		5,
		605,
		[22] = 1,
		[20] = 199
	},
	[40354006] = {
		40354006,
		9,
		Lang.get(107209),
		40354,
		6,
		605,
		[22] = 1,
		[20] = 175
	},
	[40354007] = {
		40354007,
		0,
		Lang.get(107210),
		40354,
		7,
		767,
		nil,
		nil,
		nil,
		nil,
		nil,
		164
	},
	[40354008] = {
		40354008,
		0,
		Lang.get(107211),
		40354,
		8,
		1272,
		{
			RTResTalkAction[96]
		}
	},
	[40354009] = {
		40354009,
		0,
		Lang.get(107212),
		40354,
		9,
		767,
		{
			RTResTalkAction[97]
		}
	},
	[40354010] = {
		40354010,
		0,
		Lang.get(107213),
		40354,
		10,
		1272,
		{
			RTResTalkAction[98]
		}
	},
	[40354011] = {
		40354011,
		9,
		Lang.get(107214),
		40354,
		11,
		605,
		{
			RTResTalkAction[98]
		},
		[22] = 1
	},
	[40354012] = {
		40354012,
		0,
		Lang.get(107215),
		40354,
		12,
		1272,
		{
			RTResTalkAction[99]
		}
	},
	[40354013] = {
		40354013,
		9,
		Lang.get(107216),
		40354,
		13,
		605,
		{
			RTResTalkAction[97]
		},
		[22] = 1
	},
	[40354014] = {
		40354014,
		0,
		Lang.get(107217),
		40354,
		14,
		767
	},
	[40354015] = {
		40354015,
		9,
		Lang.get(107218),
		40354,
		15,
		605,
		{
			RTResTalkAction[98]
		},
		[22] = 1
	},
	[40354016] = {
		40354016,
		0,
		Lang.get(107219),
		40354,
		16,
		1272,
		{
			RTResTalkAction[98]
		}
	},
	[40354017] = {
		40354017,
		0,
		Lang.get(107220),
		40354,
		17,
		1272,
		{
			RTResTalkAction[98]
		}
	},
	[40354018] = {
		40354018,
		0,
		Lang.get(67826),
		40354,
		18,
		767,
		{
			RTResTalkAction[97]
		}
	},
	[40354019] = {
		40354019,
		0,
		Lang.get(107221),
		40354,
		19,
		1272,
		{
			RTResTalkAction[98]
		}
	},
	[40354020] = {
		40354020,
		0,
		Lang.get(107222),
		40354,
		20,
		767,
		{
			RTResTalkAction[97]
		}
	},
	[40354021] = {
		40354021,
		9,
		Lang.get(107223),
		40354,
		21,
		605,
		[22] = 1
	},
	[40354022] = {
		40354022,
		0,
		Lang.get(107224),
		40354,
		22,
		1272,
		{
			RTResTalkAction[98]
		}
	},
	[40354023] = {
		40354023,
		9,
		Lang.get(107225),
		40354,
		23,
		605,
		{
			RTResTalkAction[97]
		},
		[22] = 1
	},
	[40354024] = {
		40354024,
		0,
		Lang.get(107226),
		40354,
		24,
		1272,
		{
			RTResTalkAction[98]
		}
	},
	[40354025] = {
		40354025,
		0,
		Lang.get(107227),
		40354,
		25,
		1273,
		{
			RTResTalkAction[100],
			RTResTalkAction[101]
		}
	},
	[40354026] = {
		40354026,
		0,
		Lang.get(107228),
		40354,
		26,
		1272,
		{
			RTResTalkAction[100],
			RTResTalkAction[102]
		}
	},
	[40354027] = {
		40354027,
		0,
		Lang.get(107229),
		40354,
		27,
		1273,
		{
			RTResTalkAction[100],
			RTResTalkAction[102]
		}
	},
	[40354028] = {
		40354028,
		0,
		Lang.get(107230),
		40354,
		28,
		767,
		{
			RTResTalkAction[97],
			RTResTalkAction[103]
		}
	},
	[40354029] = {
		40354029,
		0,
		Lang.get(107231),
		40354,
		29,
		1272,
		{
			RTResTalkAction[99]
		}
	},
	[40354030] = {
		40354030,
		0,
		Lang.get(107232),
		40354,
		30,
		767,
		{
			RTResTalkAction[97]
		}
	},
	[40354031] = {
		40354031,
		0,
		Lang.get(107233),
		40354,
		31,
		1272,
		{
			RTResTalkAction[98]
		}
	},
	[40354032] = {
		40354032,
		9,
		Lang.get(107234),
		40354,
		32,
		605,
		{
			RTResTalkAction[97]
		},
		[22] = 1,
		[20] = 100
	},
	[40354033] = {
		40354033,
		0,
		"……",
		40354,
		33,
		300,
		[20] = 199
	},
	[40354034] = {
		40354034,
		9,
		Lang.get(107235),
		40354,
		34,
		605,
		[22] = 1,
		[20] = 255
	},
	[40354035] = {
		40354035,
		0,
		Lang.get(107236),
		40354,
		35,
		300,
		[20] = 255
	},
	[40354036] = {
		40354036,
		9,
		Lang.get(107237),
		40354,
		36,
		605,
		[22] = 1
	},
	[40355001] = {
		40355001,
		3,
		Lang.get(107190),
		40355,
		1,
		605,
		nil,
		nil,
		nil,
		3,
		nil,
		185,
		40370,
		nil,
		nil,
		nil,
		nil,
		nil,
		40370,
		nil,
		nil,
		1
	},
	[40355002] = {
		40355002,
		3,
		Lang.get(107238),
		40355,
		2,
		605,
		[22] = 1
	},
	[40355003] = {
		40355003,
		5,
		Lang.get(107239),
		40355,
		3,
		207,
		{
			RTResTalkAction[17]
		}
	},
	[40355004] = {
		40355004,
		5,
		Lang.get(107240),
		40355,
		4,
		632,
		{
			RTResTalkAction[104],
			RTResTalkAction[19]
		}
	},
	[40355005] = {
		40355005,
		3,
		Lang.get(107241),
		40355,
		5,
		605,
		{
			RTResTalkAction[86]
		},
		nil,
		nil,
		3,
		2745,
		[19] = 40371,
		[22] = 1
	},
	[40355006] = {
		40355006,
		0,
		Lang.get(107242),
		40355,
		6,
		122,
		{
			RTResTalkAction[105]
		}
	},
	[40355007] = {
		40355007,
		0,
		Lang.get(107243),
		40355,
		7,
		207,
		{
			RTResTalkAction[17],
			RTResTalkAction[91]
		}
	},
	[40355008] = {
		40355008,
		3,
		Lang.get(107244),
		40355,
		8,
		605,
		{
			RTResTalkAction[93],
			RTResTalkAction[19]
		},
		[21] = 175,
		[22] = 1
	},
	[40355009] = {
		40355009,
		0,
		Lang.get(107245),
		40355,
		9,
		122,
		{
			RTResTalkAction[106],
			RTResTalkAction[95]
		}
	},
	[40355010] = {
		40355010,
		0,
		Lang.get(107246),
		40355,
		10,
		143,
		{
			RTResTalkAction[107],
			RTResTalkAction[91]
		}
	},
	[40355011] = {
		40355011,
		0,
		Lang.get(107247),
		40355,
		11,
		207,
		{
			RTResTalkAction[17],
			RTResTalkAction[88]
		}
	},
	[40355012] = {
		40355012,
		0,
		Lang.get(107248),
		40355,
		12,
		632,
		{
			RTResTalkAction[83],
			RTResTalkAction[108]
		}
	},
	[40355013] = {
		40355013,
		0,
		Lang.get(107249),
		40355,
		13,
		207,
		{
			RTResTalkAction[109],
			RTResTalkAction[110]
		}
	},
	[40355014] = {
		40355014,
		0,
		Lang.get(107250),
		40355,
		14,
		122,
		{
			RTResTalkAction[105],
			RTResTalkAction[19],
			RTResTalkAction[86]
		}
	},
	[40355015] = {
		40355015,
		3,
		Lang.get(107251),
		40355,
		15,
		605,
		{
			RTResTalkAction[91]
		},
		nil,
		nil,
		3,
		nil,
		240,
		40372,
		1,
		1,
		nil,
		1,
		nil,
		40372,
		nil,
		nil,
		1
	},
	[40355016] = {
		40355016,
		0,
		Lang.get(107252),
		40355,
		16,
		148,
		{
			RTResTalkAction[34]
		}
	},
	[40355017] = {
		40355017,
		0,
		Lang.get(107253),
		40355,
		17,
		112,
		{
			RTResTalkAction[74],
			RTResTalkAction[80]
		}
	},
	[40355018] = {
		40355018,
		0,
		Lang.get(21987),
		40355,
		18,
		148,
		{
			RTResTalkAction[74],
			RTResTalkAction[76]
		}
	},
	[40355019] = {
		40355019,
		0,
		Lang.get(107254),
		40355,
		19,
		112,
		{
			RTResTalkAction[74],
			RTResTalkAction[75]
		}
	},
	[40355020] = {
		40355020,
		0,
		Lang.get(107255),
		40355,
		20,
		148,
		{
			RTResTalkAction[111],
			RTResTalkAction[76]
		}
	},
	[40355021] = {
		40355021,
		3,
		Lang.get(107256),
		40355,
		21,
		605,
		{
			RTResTalkAction[81],
			RTResTalkAction[33]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		40373,
		1,
		1,
		nil,
		1,
		nil,
		40373,
		nil,
		nil,
		1
	},
	[40355022] = {
		40355022,
		3,
		Lang.get(107257),
		40355,
		22,
		605,
		[22] = 1
	},
	[40355023] = {
		40355023,
		0,
		Lang.get(107258),
		40355,
		23,
		767,
		{
			RTResTalkAction[112]
		}
	},
	[40355024] = {
		40355024,
		3,
		Lang.get(107259),
		40355,
		24,
		605,
		{
			RTResTalkAction[70]
		},
		[22] = 1
	},
	[40355025] = {
		40355025,
		5,
		Lang.get(107260),
		40355,
		25,
		767,
		{
			RTResTalkAction[72]
		}
	},
	[40355026] = {
		40355026,
		3,
		Lang.get(107261),
		40355,
		26,
		605,
		{
			RTResTalkAction[113],
			RTResTalkAction[114],
			RTResTalkAction[115]
		},
		[22] = 1
	},
	[40355027] = {
		40355027,
		0,
		Lang.get(107262),
		40355,
		27,
		257,
		{
			RTResTalkAction[116],
			RTResTalkAction[114]
		}
	},
	[40355028] = {
		40355028,
		0,
		Lang.get(107263),
		40355,
		28,
		767,
		{
			RTResTalkAction[71],
			RTResTalkAction[117],
			RTResTalkAction[118]
		}
	},
	[40355029] = {
		40355029,
		0,
		Lang.get(107264),
		40355,
		29,
		257,
		{
			RTResTalkAction[116],
			RTResTalkAction[119]
		}
	},
	[40355030] = {
		40355030,
		0,
		Lang.get(107265),
		40355,
		30,
		767,
		{
			RTResTalkAction[120],
			RTResTalkAction[115]
		}
	},
	[40355031] = {
		40355031,
		0,
		Lang.get(107266),
		40355,
		31,
		257,
		{
			RTResTalkAction[120]
		}
	},
	[40355032] = {
		40355032,
		0,
		Lang.get(107267),
		40355,
		32,
		257,
		{
			RTResTalkAction[120]
		}
	},
	[40355033] = {
		40355033,
		3,
		Lang.get(107268),
		40355,
		33,
		605,
		{
			RTResTalkAction[121],
			RTResTalkAction[117]
		},
		nil,
		nil,
		nil,
		nil,
		57,
		[22] = 1
	},
	[40355034] = {
		40355034,
		0,
		Lang.get(107269),
		40355,
		34,
		1269,
		{
			RTResTalkAction[122]
		}
	},
	[40355035] = {
		40355035,
		0,
		Lang.get(107270),
		40355,
		35,
		767,
		{
			RTResTalkAction[123],
			RTResTalkAction[118]
		}
	},
	[40355036] = {
		40355036,
		0,
		Lang.get(107271),
		40355,
		36,
		767,
		{
			RTResTalkAction[70]
		}
	},
	[40355037] = {
		40355037,
		0,
		Lang.get(107272),
		40355,
		37,
		257,
		{
			RTResTalkAction[113],
			RTResTalkAction[119]
		}
	},
	[40355038] = {
		40355038,
		0,
		Lang.get(107273),
		40355,
		38,
		767,
		{
			RTResTalkAction[116],
			RTResTalkAction[124]
		}
	},
	[40355039] = {
		40355039,
		0,
		Lang.get(107274),
		40355,
		39,
		767,
		{
			RTResTalkAction[116],
			RTResTalkAction[119]
		}
	},
	[40355040] = {
		40355040,
		0,
		Lang.get(107275),
		40355,
		40,
		257,
		{
			RTResTalkAction[116],
			RTResTalkAction[119]
		}
	},
	[40355041] = {
		40355041,
		0,
		Lang.get(107276),
		40355,
		41,
		767,
		{
			RTResTalkAction[116],
			RTResTalkAction[125]
		}
	},
	[40355042] = {
		40355042,
		0,
		Lang.get(107277),
		40355,
		42,
		767,
		{
			RTResTalkAction[116],
			RTResTalkAction[125]
		}
	},
	[40355043] = {
		40355043,
		0,
		"……",
		40355,
		43,
		257,
		{
			RTResTalkAction[120],
			RTResTalkAction[115]
		}
	},
	[40355044] = {
		40355044,
		3,
		Lang.get(107278),
		40355,
		44,
		605,
		{
			RTResTalkAction[117]
		},
		[22] = 1,
		[20] = 100
	},
	[40355045] = {
		40355045,
		3,
		Lang.get(107279),
		40355,
		45,
		605,
		[22] = 1,
		[20] = 235
	},
	[40356001] = {
		40356001,
		0,
		Lang.get(107280),
		40356,
		1,
		878,
		nil,
		nil,
		nil,
		3,
		nil,
		206,
		40375,
		nil,
		nil,
		nil,
		nil,
		nil,
		40375,
		235
	},
	[40356002] = {
		40356002,
		0,
		Lang.get(107281),
		40356,
		2,
		879
	},
	[40356003] = {
		40356003,
		0,
		Lang.get(107282),
		40356,
		3,
		880
	},
	[40356004] = {
		40356004,
		0,
		Lang.get(107283),
		40356,
		4,
		880
	},
	[40356005] = {
		40356005,
		9,
		Lang.get(107284),
		40356,
		5,
		605,
		[22] = 1,
		[20] = 255
	},
	[40356006] = {
		40356006,
		9,
		Lang.get(107285),
		40356,
		6,
		605,
		[22] = 1,
		[20] = 255
	},
	[40356007] = {
		40356007,
		0,
		Lang.get(107286),
		40356,
		7,
		881,
		[20] = 235
	},
	[40356008] = {
		40356008,
		0,
		Lang.get(107287),
		40356,
		8,
		1271,
		{
			RTResTalkAction[126]
		}
	},
	[40356009] = {
		40356009,
		0,
		Lang.get(107288),
		40356,
		9,
		881,
		{
			RTResTalkAction[127]
		}
	},
	[40356010] = {
		40356010,
		9,
		Lang.get(107289),
		40356,
		10,
		605,
		[22] = 1,
		[20] = 255
	},
	[40356011] = {
		40356011,
		9,
		Lang.get(107290),
		40356,
		11,
		605,
		[22] = 1
	},
	[40356012] = {
		40356012,
		5,
		Lang.get(107291),
		40356,
		12,
		1271,
		{
			RTResTalkAction[126]
		},
		[20] = 235
	},
	[40356013] = {
		40356013,
		0,
		Lang.get(107292),
		40356,
		13,
		877,
		{
			RTResTalkAction[127]
		}
	},
	[40356014] = {
		40356014,
		0,
		Lang.get(107293),
		40356,
		14,
		1271,
		{
			RTResTalkAction[126]
		}
	},
	[40356015] = {
		40356015,
		0,
		Lang.get(107294),
		40356,
		15,
		877,
		{
			RTResTalkAction[127]
		}
	},
	[40356016] = {
		40356016,
		9,
		Lang.get(107295),
		40356,
		16,
		605,
		[22] = 1
	},
	[40356017] = {
		40356017,
		0,
		Lang.get(107296),
		40356,
		17,
		877
	},
	[40356018] = {
		40356018,
		0,
		Lang.get(107297),
		40356,
		18,
		877
	},
	[40356019] = {
		40356019,
		0,
		Lang.get(107298),
		40356,
		19,
		1271,
		{
			RTResTalkAction[126]
		}
	},
	[40356020] = {
		40356020,
		0,
		Lang.get(107299),
		40356,
		20,
		877,
		{
			RTResTalkAction[127]
		}
	},
	[40356021] = {
		40356021,
		0,
		Lang.get(107300),
		40356,
		21,
		1271,
		{
			RTResTalkAction[126]
		}
	},
	[40356022] = {
		40356022,
		0,
		Lang.get(107301),
		40356,
		22,
		877,
		{
			RTResTalkAction[127]
		}
	},
	[40356023] = {
		40356023,
		9,
		Lang.get(107302),
		40356,
		23,
		605,
		[22] = 1,
		[20] = 255
	},
	[40356024] = {
		40356024,
		9,
		Lang.get(107303),
		40356,
		24,
		605,
		[22] = 1,
		[20] = 255
	},
	[40356025] = {
		40356025,
		0,
		Lang.get(107304),
		40356,
		25,
		767,
		nil,
		1,
		0,
		[20] = 235
	},
	[40356026] = {
		40356026,
		0,
		Lang.get(107305),
		40356,
		26,
		1269,
		{
			RTResTalkAction[128]
		}
	},
	[40356027] = {
		40356027,
		0,
		Lang.get(107306),
		40356,
		27,
		767,
		{
			RTResTalkAction[121]
		},
		1,
		0
	},
	[40356028] = {
		40356028,
		0,
		Lang.get(107307),
		40356,
		28,
		1269,
		{
			RTResTalkAction[121]
		}
	},
	[40356029] = {
		40356029,
		0,
		Lang.get(107308),
		40356,
		29,
		767,
		{
			RTResTalkAction[121]
		},
		1,
		2
	},
	[40356030] = {
		40356030,
		0,
		Lang.get(107309),
		40356,
		30,
		1269,
		{
			RTResTalkAction[121]
		}
	},
	[40356031] = {
		40356031,
		0,
		Lang.get(107310),
		40356,
		31,
		767,
		{
			RTResTalkAction[121]
		},
		1,
		4,
		nil,
		nil,
		63
	},
	[40356032] = {
		40356032,
		0,
		Lang.get(107311),
		40356,
		32,
		1269,
		{
			RTResTalkAction[121]
		}
	},
	[40356033] = {
		40356033,
		0,
		Lang.get(107312),
		40356,
		33,
		767,
		{
			RTResTalkAction[121]
		},
		1,
		4
	},
	[40356034] = {
		40356034,
		0,
		"……！",
		40356,
		34,
		1269,
		{
			RTResTalkAction[122]
		}
	},
	[40356035] = {
		40356035,
		0,
		Lang.get(107313),
		40356,
		35,
		767,
		{
			RTResTalkAction[121]
		},
		1,
		4
	},
	[40356036] = {
		40356036,
		9,
		Lang.get(107314),
		40356,
		36,
		605,
		{
			RTResTalkAction[121]
		},
		[22] = 1,
		[20] = 255
	},
	[40356037] = {
		40356037,
		9,
		Lang.get(107315),
		40356,
		37,
		605,
		{
			RTResTalkAction[118]
		},
		[22] = 1
	},
	[40356038] = {
		40356038,
		0,
		"……",
		40356,
		38,
		300
	},
	[40356039] = {
		40356039,
		9,
		Lang.get(107316),
		40356,
		39,
		605,
		[22] = 1
	},
	[40356040] = {
		40356040,
		9,
		Lang.get(107317),
		40356,
		40,
		605,
		[22] = 1
	},
	[40356041] = {
		40356041,
		0,
		Lang.get(107318),
		40356,
		41,
		300
	},
	[40357001] = {
		40357001,
		3,
		Lang.get(107319),
		40357,
		1,
		605,
		nil,
		nil,
		nil,
		3,
		nil,
		57,
		40380,
		nil,
		nil,
		nil,
		nil,
		nil,
		40380,
		nil,
		nil,
		1
	},
	[40357002] = {
		40357002,
		5,
		Lang.get(107320),
		40357,
		2,
		215,
		{
			RTResTalkAction[129]
		}
	},
	[40357003] = {
		40357003,
		0,
		Lang.get(107321),
		40357,
		3,
		220,
		{
			RTResTalkAction[130],
			RTResTalkAction[131]
		}
	},
	[40357004] = {
		40357004,
		3,
		Lang.get(107322),
		40357,
		4,
		605,
		{
			RTResTalkAction[132],
			RTResTalkAction[45]
		},
		[22] = 1
	},
	[40357005] = {
		40357005,
		0,
		Lang.get(107323),
		40357,
		5,
		215,
		{
			RTResTalkAction[133]
		}
	},
	[40357006] = {
		40357006,
		3,
		Lang.get(97620),
		40357,
		6,
		605,
		{
			RTResTalkAction[132]
		},
		nil,
		nil,
		nil,
		5000,
		[22] = 1
	},
	[40357007] = {
		40357007,
		13,
		Lang.get(107324),
		40357,
		7,
		112,
		{
			RTResTalkAction[32],
			RTResTalkAction[31]
		},
		[27] = 3
	},
	[40357008] = {
		40357008,
		0,
		Lang.get(107325),
		40357,
		8,
		215,
		{
			RTResTalkAction[134]
		},
		1,
		2,
		[27] = 3
	},
	[40357009] = {
		40357009,
		13,
		Lang.get(107326),
		40357,
		9,
		112,
		{
			RTResTalkAction[134]
		},
		[27] = 3
	},
	[40357010] = {
		40357010,
		13,
		Lang.get(107327),
		40357,
		10,
		112,
		{
			RTResTalkAction[135]
		},
		[27] = 3
	},
	[40357011] = {
		40357011,
		9,
		"…………",
		40357,
		11,
		605,
		{
			RTResTalkAction[33]
		},
		[22] = 1,
		[20] = 199
	},
	[40357012] = {
		40357012,
		9,
		"……",
		40357,
		12,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		59,
		[22] = 1,
		[20] = 255
	},
	[40357013] = {
		40357013,
		9,
		Lang.get(107328),
		40357,
		13,
		605,
		[22] = 1,
		[20] = 255
	},
	[40357014] = {
		40357014,
		9,
		Lang.get(107329),
		40357,
		14,
		605,
		[22] = 1,
		[20] = 255
	},
	[40357015] = {
		40357015,
		9,
		Lang.get(107330),
		40357,
		15,
		605,
		[22] = 1,
		[20] = 255
	},
	[40357016] = {
		40357016,
		9,
		Lang.get(107331),
		40357,
		16,
		605,
		[22] = 1,
		[20] = 255
	},
	[40357017] = {
		40357017,
		9,
		Lang.get(107332),
		40357,
		17,
		605,
		[22] = 1,
		[20] = 255
	},
	[40357018] = {
		40357018,
		9,
		Lang.get(107333),
		40357,
		18,
		605,
		[22] = 1,
		[20] = 255
	},
	[40357019] = {
		40357019,
		0,
		Lang.get(107334),
		40357,
		19,
		257,
		{
			RTResTalkAction[136]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		40381,
		[19] = 40381,
		[20] = 235
	},
	[40357020] = {
		40357020,
		0,
		Lang.get(107335),
		40357,
		20,
		767,
		{
			RTResTalkAction[120]
		},
		1,
		2
	},
	[40357021] = {
		40357021,
		0,
		Lang.get(107336),
		40357,
		21,
		767,
		{
			RTResTalkAction[120]
		},
		1,
		0
	},
	[40357022] = {
		40357022,
		0,
		Lang.get(107337),
		40357,
		22,
		257,
		{
			RTResTalkAction[120]
		}
	},
	[40357023] = {
		40357023,
		0,
		Lang.get(107338),
		40357,
		23,
		767,
		{
			RTResTalkAction[120]
		},
		1,
		0
	},
	[40357024] = {
		40357024,
		0,
		"……",
		40357,
		24,
		257,
		{
			RTResTalkAction[120]
		}
	},
	[40357025] = {
		40357025,
		0,
		Lang.get(107339),
		40357,
		25,
		767,
		{
			RTResTalkAction[120]
		},
		1,
		0
	},
	[40357026] = {
		40357026,
		0,
		Lang.get(107340),
		40357,
		26,
		257,
		{
			RTResTalkAction[137]
		}
	},
	[40357027] = {
		40357027,
		9,
		Lang.get(107341),
		40357,
		27,
		605,
		{
			RTResTalkAction[120]
		},
		[22] = 1
	},
	[40357028] = {
		40357028,
		0,
		Lang.get(107342),
		40357,
		28,
		767,
		{
			RTResTalkAction[120]
		},
		1,
		0
	},
	[40357029] = {
		40357029,
		0,
		Lang.get(107343),
		40357,
		29,
		257,
		{
			RTResTalkAction[138]
		}
	},
	[40357030] = {
		40357030,
		0,
		Lang.get(107344),
		40357,
		30,
		767,
		{
			RTResTalkAction[117]
		},
		1,
		4
	},
	[40357031] = {
		40357031,
		9,
		Lang.get(107345),
		40357,
		31,
		605,
		[22] = 1,
		[20] = 255
	},
	[40357032] = {
		40357032,
		0,
		Lang.get(107346),
		40357,
		32,
		767,
		nil,
		1,
		4
	},
	[40357033] = {
		40357033,
		0,
		Lang.get(107347),
		40357,
		33,
		767,
		nil,
		1,
		1
	},
	[40357034] = {
		40357034,
		9,
		Lang.get(107348),
		40357,
		34,
		605,
		[22] = 1
	},
	[40357035] = {
		40357035,
		9,
		Lang.get(107349),
		40357,
		35,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[22] = 1
	},
	[40358001] = {
		40358001,
		9,
		Lang.get(107350),
		40358,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		113,
		40385,
		nil,
		nil,
		nil,
		nil,
		nil,
		40385,
		255,
		nil,
		1
	},
	[40358002] = {
		40358002,
		0,
		Lang.get(107351),
		40358,
		2,
		767,
		nil,
		1,
		0
	},
	[40358003] = {
		40358003,
		9,
		Lang.get(107352),
		40358,
		3,
		605,
		[22] = 1
	},
	[40358004] = {
		40358004,
		0,
		Lang.get(107353),
		40358,
		4,
		767,
		nil,
		1,
		0
	},
	[40358005] = {
		40358005,
		9,
		Lang.get(107354),
		40358,
		5,
		605,
		[22] = 1
	},
	[40358006] = {
		40358006,
		9,
		Lang.get(107355),
		40358,
		6,
		605,
		[22] = 1
	},
	[40358007] = {
		40358007,
		0,
		Lang.get(107356),
		40358,
		7,
		767,
		nil,
		1,
		0
	},
	[40358008] = {
		40358008,
		0,
		Lang.get(107357),
		40358,
		8,
		767,
		nil,
		1,
		0
	},
	[40358009] = {
		40358009,
		9,
		Lang.get(107358),
		40358,
		9,
		605,
		[22] = 1
	},
	[40358010] = {
		40358010,
		9,
		Lang.get(107359),
		40358,
		10,
		605,
		[22] = 1
	},
	[40358011] = {
		40358011,
		9,
		Lang.get(107360),
		40358,
		11,
		605,
		[22] = 1
	},
	[40358012] = {
		40358012,
		0,
		Lang.get(107361),
		40358,
		12,
		767,
		nil,
		1,
		4
	},
	[40358013] = {
		40358013,
		9,
		Lang.get(107362),
		40358,
		13,
		605,
		[22] = 1
	},
	[40358014] = {
		40358014,
		0,
		Lang.get(107363),
		40358,
		14,
		767,
		nil,
		1,
		4
	},
	[40358015] = {
		40358015,
		9,
		Lang.get(107364),
		40358,
		15,
		605,
		[22] = 1
	},
	[40358016] = {
		40358016,
		9,
		Lang.get(107365),
		40358,
		16,
		605,
		[22] = 1
	},
	[40358017] = {
		40358017,
		0,
		Lang.get(20681),
		40358,
		17,
		767,
		nil,
		1,
		3,
		nil,
		nil,
		59
	},
	[40358018] = {
		40358018,
		0,
		Lang.get(107366),
		40358,
		18,
		767,
		nil,
		1,
		3
	},
	[40358019] = {
		40358019,
		9,
		Lang.get(107367),
		40358,
		19,
		605,
		[22] = 1
	},
	[40358020] = {
		40358020,
		9,
		Lang.get(107368),
		40358,
		20,
		605,
		[22] = 1
	},
	[40358021] = {
		40358021,
		9,
		Lang.get(107369),
		40358,
		21,
		605,
		[22] = 1
	},
	[40358022] = {
		40358022,
		0,
		Lang.get(107370),
		40358,
		22,
		767,
		nil,
		1,
		1
	},
	[40358023] = {
		40358023,
		0,
		Lang.get(107371),
		40358,
		23,
		767,
		nil,
		1,
		1
	},
	[40358024] = {
		40358024,
		9,
		Lang.get(107372),
		40358,
		24,
		605,
		[22] = 1
	},
	[40358025] = {
		40358025,
		9,
		Lang.get(107373),
		40358,
		25,
		605,
		[22] = 1
	},
	[40358026] = {
		40358026,
		9,
		Lang.get(107374),
		40358,
		26,
		605,
		[22] = 1
	},
	[40358027] = {
		40358027,
		0,
		Lang.get(107375),
		40358,
		27,
		236,
		{
			RTResTalkAction[139]
		}
	},
	[40358028] = {
		40358028,
		9,
		Lang.get(107376),
		40358,
		28,
		605,
		{
			RTResTalkAction[140]
		},
		[22] = 1
	},
	[40358029] = {
		40358029,
		0,
		Lang.get(107377),
		40358,
		29,
		236,
		{
			RTResTalkAction[139]
		}
	},
	[40358030] = {
		40358030,
		9,
		Lang.get(107378),
		40358,
		30,
		605,
		{
			RTResTalkAction[140]
		},
		[22] = 1
	},
	[40358031] = {
		40358031,
		0,
		Lang.get(65363),
		40358,
		31,
		1275,
		nil,
		1,
		2
	},
	[40358032] = {
		40358032,
		0,
		Lang.get(107379),
		40358,
		32,
		300
	},
	[40359001] = {
		40359001,
		3,
		Lang.get(107380),
		40359,
		1,
		605,
		nil,
		nil,
		nil,
		3,
		nil,
		173,
		40390,
		nil,
		nil,
		nil,
		nil,
		nil,
		40390,
		150,
		nil,
		1
	},
	[40359002] = {
		40359002,
		0,
		Lang.get(107381),
		40359,
		2,
		767,
		{
			RTResTalkAction[112]
		}
	},
	[40359003] = {
		40359003,
		0,
		Lang.get(107382),
		40359,
		3,
		241,
		{
			RTResTalkAction[141],
			RTResTalkAction[115]
		}
	},
	[40359004] = {
		40359004,
		0,
		Lang.get(107383),
		40359,
		4,
		241,
		{
			RTResTalkAction[141]
		}
	},
	[40359005] = {
		40359005,
		0,
		Lang.get(107384),
		40359,
		5,
		767,
		{
			RTResTalkAction[112],
			RTResTalkAction[142]
		}
	},
	[40359006] = {
		40359006,
		0,
		Lang.get(107385),
		40359,
		6,
		241,
		{
			RTResTalkAction[141],
			RTResTalkAction[115]
		}
	},
	[40359007] = {
		40359007,
		0,
		Lang.get(107386),
		40359,
		7,
		241,
		{
			RTResTalkAction[141]
		}
	},
	[40359008] = {
		40359008,
		0,
		Lang.get(107387),
		40359,
		8,
		241,
		{
			RTResTalkAction[141]
		}
	},
	[40359009] = {
		40359009,
		5,
		Lang.get(107388),
		40359,
		9,
		767,
		{
			RTResTalkAction[143],
			RTResTalkAction[142]
		}
	},
	[40359010] = {
		40359010,
		0,
		Lang.get(107389),
		40359,
		10,
		241,
		{
			RTResTalkAction[141],
			RTResTalkAction[115]
		}
	},
	[40359011] = {
		40359011,
		0,
		Lang.get(107390),
		40359,
		11,
		241,
		{
			RTResTalkAction[141]
		}
	},
	[40359012] = {
		40359012,
		0,
		Lang.get(107391),
		40359,
		12,
		767,
		{
			RTResTalkAction[69],
			RTResTalkAction[142]
		}
	},
	[40359013] = {
		40359013,
		0,
		Lang.get(107392),
		40359,
		13,
		767,
		{
			RTResTalkAction[144]
		}
	},
	[40359014] = {
		40359014,
		5,
		Lang.get(107393),
		40359,
		14,
		767,
		{
			RTResTalkAction[145]
		}
	},
	[40359015] = {
		40359015,
		0,
		Lang.get(107394),
		40359,
		15,
		241,
		{
			RTResTalkAction[141],
			RTResTalkAction[115]
		},
		nil,
		nil,
		nil,
		nil,
		158
	},
	[40359016] = {
		40359016,
		3,
		Lang.get(107395),
		40359,
		16,
		605,
		{
			RTResTalkAction[141]
		},
		[22] = 1
	},
	[40359017] = {
		40359017,
		0,
		Lang.get(107396),
		40359,
		17,
		767,
		{
			RTResTalkAction[69],
			RTResTalkAction[142]
		}
	},
	[40359018] = {
		40359018,
		3,
		Lang.get(107397),
		40359,
		18,
		605,
		{
			RTResTalkAction[115]
		},
		[22] = 1
	},
	[40359019] = {
		40359019,
		3,
		Lang.get(107398),
		40359,
		19,
		605,
		[22] = 1
	},
	[40359020] = {
		40359020,
		3,
		Lang.get(107399),
		40359,
		20,
		605,
		nil,
		nil,
		nil,
		nil,
		1220,
		[19] = 40391,
		[22] = 1
	},
	[40359021] = {
		40359021,
		0,
		Lang.get(107400),
		40359,
		21,
		767,
		{
			RTResTalkAction[146]
		}
	},
	[40359022] = {
		40359022,
		0,
		Lang.get(107401),
		40359,
		22,
		767,
		{
			RTResTalkAction[147]
		}
	},
	[40359023] = {
		40359023,
		3,
		"……",
		40359,
		23,
		605,
		{
			RTResTalkAction[115]
		},
		[22] = 1
	},
	[40359024] = {
		40359024,
		3,
		Lang.get(107402),
		40359,
		24,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		114,
		[22] = 1,
		[20] = 0
	},
	[40359025] = {
		40359025,
		3,
		Lang.get(107403),
		40359,
		25,
		605,
		[22] = 1
	},
	[40359026] = {
		40359026,
		0,
		Lang.get(107404),
		40359,
		26,
		300
	},
	[40359027] = {
		40359027,
		0,
		"……|101|。",
		40359,
		27,
		241,
		{
			RTResTalkAction[148]
		}
	},
	[40359028] = {
		40359028,
		3,
		Lang.get(107405),
		40359,
		28,
		605,
		{
			RTResTalkAction[142]
		},
		[22] = 1
	},
	[40359029] = {
		40359029,
		0,
		Lang.get(107406),
		40359,
		29,
		300
	},
	[40359030] = {
		40359030,
		0,
		Lang.get(103090),
		40359,
		30,
		244,
		{
			RTResTalkAction[149]
		}
	},
	[40359031] = {
		40359031,
		0,
		Lang.get(107407),
		40359,
		31,
		244,
		{
			RTResTalkAction[149]
		}
	},
	[40359032] = {
		40359032,
		3,
		Lang.get(107408),
		40359,
		32,
		605,
		{
			RTResTalkAction[150]
		},
		[22] = 1
	},
	[40359033] = {
		40359033,
		3,
		Lang.get(107409),
		40359,
		33,
		605,
		[22] = 1
	},
	[40360001] = {
		40360001,
		3,
		Lang.get(107410),
		40360,
		1,
		605,
		nil,
		nil,
		nil,
		3,
		nil,
		114,
		40395,
		nil,
		nil,
		nil,
		nil,
		nil,
		40395,
		100,
		nil,
		1
	},
	[40360002] = {
		40360002,
		0,
		Lang.get(107411),
		40360,
		2,
		225,
		{
			RTResTalkAction[44]
		}
	},
	[40360003] = {
		40360003,
		0,
		Lang.get(107412),
		40360,
		3,
		220,
		{
			RTResTalkAction[151],
			RTResTalkAction[47]
		}
	},
	[40360004] = {
		40360004,
		0,
		Lang.get(107413),
		40360,
		4,
		215,
		{
			RTResTalkAction[152],
			RTResTalkAction[45]
		}
	},
	[40360005] = {
		40360005,
		0,
		Lang.get(107414),
		40360,
		5,
		244,
		{
			RTResTalkAction[153],
			RTResTalkAction[154]
		}
	},
	[40360006] = {
		40360006,
		0,
		Lang.get(107415),
		40360,
		6,
		215,
		{
			RTResTalkAction[155],
			RTResTalkAction[156]
		}
	},
	[40360007] = {
		40360007,
		0,
		Lang.get(107416),
		40360,
		7,
		244,
		{
			RTResTalkAction[157],
			RTResTalkAction[31]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[40360008] = {
		40360008,
		3,
		Lang.get(100964),
		40360,
		8,
		605,
		{
			RTResTalkAction[150]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		40396,
		nil,
		1,
		nil,
		1,
		nil,
		40396,
		100,
		nil,
		1
	},
	[40360009] = {
		40360009,
		3,
		Lang.get(107417),
		40360,
		9,
		605,
		[22] = 1
	},
	[40360010] = {
		40360010,
		0,
		Lang.get(107418),
		40360,
		10,
		257,
		{
			RTResTalkAction[136]
		}
	},
	[40360011] = {
		40360011,
		0,
		Lang.get(107419),
		40360,
		11,
		767,
		{
			RTResTalkAction[116],
			RTResTalkAction[158]
		}
	},
	[40360012] = {
		40360012,
		0,
		Lang.get(107420),
		40360,
		12,
		257,
		{
			RTResTalkAction[116],
			RTResTalkAction[119]
		}
	},
	[40360013] = {
		40360013,
		0,
		Lang.get(107421),
		40360,
		13,
		767,
		{
			RTResTalkAction[116],
			RTResTalkAction[119]
		}
	},
	[40360014] = {
		40360014,
		3,
		Lang.get(107422),
		40360,
		14,
		605,
		{
			RTResTalkAction[70],
			RTResTalkAction[117]
		},
		[22] = 1
	},
	[40360015] = {
		40360015,
		4,
		nil,
		40360,
		15,
		300,
		{
			RTResTalkAction[70]
		},
		[29] = {
			{
				id = 40360016,
				branch_content = Lang.get(107423)
			},
			{
				id = 40360016,
				branch_content = Lang.get(107424)
			}
		}
	},
	[40360016] = {
		40360016,
		3,
		Lang.get(107425),
		40360,
		16,
		605,
		{
			RTResTalkAction[70]
		},
		nil,
		nil,
		nil,
		nil,
		154,
		[22] = 1
	},
	[40360017] = {
		40360017,
		5,
		Lang.get(88094),
		40360,
		17,
		767,
		{
			RTResTalkAction[159]
		}
	},
	[40360018] = {
		40360018,
		0,
		"！",
		40360,
		18,
		300,
		{
			RTResTalkAction[115]
		}
	},
	[40360019] = {
		40360019,
		0,
		Lang.get(32377),
		40360,
		19,
		257,
		{
			RTResTalkAction[137]
		}
	},
	[40360020] = {
		40360020,
		0,
		Lang.get(107426),
		40360,
		20,
		767,
		{
			RTResTalkAction[143],
			RTResTalkAction[117]
		}
	},
	[40360021] = {
		40360021,
		3,
		Lang.get(107427),
		40360,
		21,
		605,
		{
			RTResTalkAction[115]
		},
		[22] = 1
	},
	[40360022] = {
		40360022,
		3,
		Lang.get(107428),
		40360,
		22,
		605,
		[22] = 1
	},
	[40360023] = {
		40360023,
		0,
		Lang.get(107429),
		40360,
		23,
		767,
		{
			RTResTalkAction[71]
		}
	},
	[40360024] = {
		40360024,
		5,
		Lang.get(107430),
		40360,
		24,
		257,
		{
			RTResTalkAction[116],
			RTResTalkAction[119]
		}
	},
	[40360025] = {
		40360025,
		5,
		Lang.get(107431),
		40360,
		25,
		257,
		{
			RTResTalkAction[160],
			RTResTalkAction[119]
		}
	},
	[40360026] = {
		40360026,
		0,
		Lang.get(107432),
		40360,
		26,
		767,
		{
			RTResTalkAction[116],
			RTResTalkAction[119]
		}
	},
	[40360027] = {
		40360027,
		0,
		Lang.get(107433),
		40360,
		27,
		257,
		{
			RTResTalkAction[116],
			RTResTalkAction[119]
		}
	},
	[40360028] = {
		40360028,
		0,
		Lang.get(107434),
		40360,
		28,
		767,
		{
			RTResTalkAction[116],
			RTResTalkAction[119]
		}
	},
	[40360029] = {
		40360029,
		0,
		"……",
		40360,
		29,
		257,
		{
			RTResTalkAction[161],
			RTResTalkAction[115]
		}
	},
	[40360030] = {
		40360030,
		3,
		Lang.get(107435),
		40360,
		30,
		605,
		{
			RTResTalkAction[117]
		},
		[22] = 1
	},
	[40360031] = {
		40360031,
		0,
		Lang.get(107436),
		40360,
		31,
		767,
		{
			RTResTalkAction[71]
		}
	},
	[40360032] = {
		40360032,
		0,
		Lang.get(107437),
		40360,
		32,
		767,
		{
			RTResTalkAction[70]
		}
	},
	[40360033] = {
		40360033,
		0,
		Lang.get(107438),
		40360,
		33,
		300,
		{
			RTResTalkAction[115]
		}
	},
	[40360034] = {
		40360034,
		0,
		Lang.get(107439),
		40360,
		34,
		767,
		{
			RTResTalkAction[147]
		}
	},
	[40360035] = {
		40360035,
		0,
		Lang.get(107440),
		40360,
		35,
		767,
		{
			RTResTalkAction[71]
		}
	},
	[40360036] = {
		40360036,
		3,
		Lang.get(107441),
		40360,
		36,
		605,
		{
			RTResTalkAction[115]
		},
		[22] = 1,
		[20] = 199
	},
	[40360037] = {
		40360037,
		3,
		Lang.get(107442),
		40360,
		37,
		605,
		[22] = 1
	},
	[40361001] = {
		40361001,
		0,
		Lang.get(107443),
		40361,
		1,
		1223,
		nil,
		1,
		0,
		3,
		nil,
		113,
		40400,
		nil,
		nil,
		nil,
		nil,
		nil,
		40400,
		100
	},
	[40361002] = {
		40361002,
		3,
		Lang.get(107444),
		40361,
		2,
		605,
		[22] = 1
	},
	[40361003] = {
		40361003,
		0,
		Lang.get(107445),
		40361,
		3,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[40361004] = {
		40361004,
		0,
		Lang.get(107446),
		40361,
		4,
		187,
		nil,
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
		40401,
		-1
	},
	[40361005] = {
		40361005,
		4,
		nil,
		40361,
		5,
		300,
		[29] = {
			{
				id = 40361006,
				branch_content = Lang.get(107447)
			},
			{
				id = 40361006,
				branch_content = Lang.get(107448)
			}
		}
	},
	[40361006] = {
		40361006,
		0,
		Lang.get(107449),
		40361,
		6,
		187,
		nil,
		1,
		0,
		3,
		nil,
		nil,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		40402,
		100
	},
	[40361007] = {
		40361007,
		0,
		Lang.get(107450),
		40361,
		7,
		257,
		{
			RTResTalkAction[120]
		}
	},
	[40361008] = {
		40361008,
		0,
		Lang.get(107451),
		40361,
		8,
		187,
		{
			RTResTalkAction[120]
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
		40403,
		-1
	},
	[40361009] = {
		40361009,
		3,
		Lang.get(107452),
		40361,
		9,
		605,
		{
			RTResTalkAction[117]
		},
		nil,
		nil,
		nil,
		nil,
		114,
		[22] = 1
	},
	[40361010] = {
		40361010,
		0,
		Lang.get(107453),
		40361,
		10,
		187,
		{
			RTResTalkAction[162]
		}
	},
	[40361011] = {
		40361011,
		0,
		Lang.get(107454),
		40361,
		11,
		187,
		{
			RTResTalkAction[162]
		}
	},
	[40361012] = {
		40361012,
		0,
		Lang.get(107455),
		40361,
		12,
		187,
		{
			RTResTalkAction[163]
		}
	},
	[40361013] = {
		40361013,
		3,
		Lang.get(107456),
		40361,
		13,
		605,
		{
			RTResTalkAction[164]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		nil,
		1,
		1,
		nil,
		0,
		nil,
		40404,
		100,
		nil,
		1
	},
	[40361014] = {
		40361014,
		3,
		Lang.get(107457),
		40361,
		14,
		605,
		[22] = 1
	},
	[40361015] = {
		40361015,
		0,
		Lang.get(107458),
		40361,
		15,
		257,
		{
			RTResTalkAction[120]
		}
	},
	[40361016] = {
		40361016,
		0,
		Lang.get(107459),
		40361,
		16,
		300,
		{
			RTResTalkAction[120]
		}
	},
	[40361017] = {
		40361017,
		0,
		Lang.get(107460),
		40361,
		17,
		257,
		{
			RTResTalkAction[120]
		}
	},
	[40361018] = {
		40361018,
		3,
		Lang.get(107461),
		40361,
		18,
		605,
		{
			RTResTalkAction[117]
		},
		[22] = 1
	},
	[40361019] = {
		40361019,
		3,
		Lang.get(107462),
		40361,
		19,
		605,
		[22] = 1
	},
	[40361020] = {
		40361020,
		3,
		Lang.get(107463),
		40361,
		20,
		605,
		[22] = 1
	},
	[40361021] = {
		40361021,
		3,
		Lang.get(107464),
		40361,
		21,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		58,
		[22] = 1
	},
	[40361022] = {
		40361022,
		3,
		Lang.get(107465),
		40361,
		22,
		605,
		[22] = 1
	},
	[40361023] = {
		40361023,
		9,
		Lang.get(107466),
		40361,
		23,
		605,
		[22] = 1,
		[20] = 255
	},
	[40361024] = {
		40361024,
		9,
		Lang.get(107467),
		40361,
		24,
		605,
		[22] = 1
	},
	[40361025] = {
		40361025,
		9,
		Lang.get(107468),
		40361,
		25,
		605,
		[22] = 1
	},
	[40361026] = {
		40361026,
		9,
		Lang.get(107469),
		40361,
		26,
		605,
		[22] = 1
	},
	[40361027] = {
		40361027,
		9,
		Lang.get(107470),
		40361,
		27,
		605,
		[22] = 1
	},
	[40361028] = {
		40361028,
		0,
		Lang.get(107471),
		40361,
		28,
		244,
		{
			RTResTalkAction[149]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		40405,
		1,
		nil,
		nil,
		nil,
		nil,
		40405,
		-1
	},
	[40361029] = {
		40361029,
		0,
		"……！！！",
		40361,
		29,
		300,
		{
			RTResTalkAction[157]
		}
	},
	[40361030] = {
		40361030,
		0,
		Lang.get(107472),
		40361,
		30,
		300,
		{
			RTResTalkAction[157]
		}
	},
	[40361031] = {
		40361031,
		0,
		Lang.get(107473),
		40361,
		31,
		244,
		{
			RTResTalkAction[157]
		}
	},
	[40361032] = {
		40361032,
		3,
		Lang.get(107474),
		40361,
		32,
		605,
		{
			RTResTalkAction[157]
		},
		[22] = 1
	},
	[40361033] = {
		40361033,
		0,
		Lang.get(107475),
		40361,
		33,
		244,
		{
			RTResTalkAction[157]
		}
	},
	[40361034] = {
		40361034,
		0,
		Lang.get(107476),
		40361,
		34,
		244,
		{
			RTResTalkAction[165]
		},
		1,
		0
	},
	[40361035] = {
		40361035,
		3,
		Lang.get(107477),
		40361,
		35,
		605,
		{
			RTResTalkAction[166],
			RTResTalkAction[150]
		},
		[22] = 1
	},
	[40361036] = {
		40361036,
		3,
		Lang.get(107478),
		40361,
		36,
		605,
		{
			RTResTalkAction[167],
			RTResTalkAction[168]
		},
		[22] = 1
	},
	[40361037] = {
		40361037,
		0,
		Lang.get(107479),
		40361,
		37,
		244,
		{
			RTResTalkAction[167],
			RTResTalkAction[168]
		},
		1,
		0
	},
	[40361038] = {
		40361038,
		0,
		Lang.get(107480),
		40361,
		38,
		244,
		{
			RTResTalkAction[149],
			RTResTalkAction[169],
			RTResTalkAction[170]
		}
	},
	[40361039] = {
		40361039,
		3,
		Lang.get(107481),
		40361,
		39,
		605,
		{
			RTResTalkAction[150]
		},
		[22] = 1
	},
	[40361040] = {
		40361040,
		3,
		Lang.get(107482),
		40361,
		40,
		605,
		[22] = 1
	},
	[40361041] = {
		40361041,
		3,
		Lang.get(107483),
		40361,
		41,
		605,
		nil,
		nil,
		nil,
		nil,
		2762,
		[22] = 1
	},
	[40361042] = {
		40361042,
		0,
		Lang.get(107484),
		40361,
		42,
		332,
		{
			RTResTalkAction[171]
		},
		nil,
		nil,
		3,
		nil,
		207,
		40406,
		nil,
		nil,
		nil,
		0,
		nil,
		40406
	},
	[40361043] = {
		40361043,
		0,
		Lang.get(107485),
		40361,
		43,
		332,
		{
			RTResTalkAction[172]
		}
	},
	[40361044] = {
		40361044,
		0,
		Lang.get(107486),
		40361,
		44,
		332,
		{
			RTResTalkAction[172]
		}
	},
	[40361045] = {
		40361045,
		0,
		Lang.get(107487),
		40361,
		45,
		332,
		{
			RTResTalkAction[172]
		}
	},
	[40361046] = {
		40361046,
		0,
		Lang.get(107488),
		40361,
		46,
		332,
		{
			RTResTalkAction[172]
		}
	},
	[40361047] = {
		40361047,
		0,
		Lang.get(107489),
		40361,
		47,
		332,
		{
			RTResTalkAction[172]
		}
	},
	[40361048] = {
		40361048,
		0,
		Lang.get(107490),
		40361,
		48,
		332,
		{
			RTResTalkAction[172]
		}
	},
	[40361049] = {
		40361049,
		0,
		Lang.get(107491),
		40361,
		49,
		332,
		{
			RTResTalkAction[172]
		}
	},
	[40361050] = {
		40361050,
		0,
		Lang.get(107492),
		40361,
		50,
		332,
		{
			RTResTalkAction[172]
		}
	},
	[40361051] = {
		40361051,
		0,
		Lang.get(107493),
		40361,
		51,
		332,
		{
			RTResTalkAction[172]
		}
	},
	[40361052] = {
		40361052,
		0,
		Lang.get(107494),
		40361,
		52,
		332,
		{
			RTResTalkAction[172]
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
