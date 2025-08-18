-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\Miku\\ResTalk.lua

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
	[2] = 300
}
RTResTalkAction[2] = {
	[1] = 0,
	[2] = 300
}
RTResTalkAction[3] = {
	1,
	158,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[4] = {
	[1] = 1,
	[2] = 158
}
RTResTalkAction[5] = {
	1,
	158,
	nil,
	nil,
	2
}
RTResTalkAction[6] = {
	1,
	158,
	nil,
	nil,
	6
}
RTResTalkAction[7] = {
	1,
	158,
	{
		100215
	},
	nil,
	1
}
RTResTalkAction[8] = {
	1,
	158,
	{
		3
	},
	nil,
	4
}
RTResTalkAction[9] = {
	[1] = 0,
	[2] = 158
}
RTResTalkAction[10] = {
	[1] = 2,
	[2] = 159
}
RTResTalkAction[11] = {
	[1] = 3,
	[2] = 158
}
RTResTalkAction[12] = {
	3,
	158,
	nil,
	nil,
	4
}
RTResTalkAction[13] = {
	3,
	158,
	{
		2,
		100515
	},
	nil,
	3
}
RTResTalkAction[14] = {
	[1] = 1,
	[2] = 576
}
RTResTalkAction[15] = {
	[1] = 1,
	[2] = 41
}
RTResTalkAction[16] = {
	[1] = 0,
	[2] = 576
}
RTResTalkAction[17] = {
	[1] = 2,
	[2] = 41
}
RTResTalkAction[18] = {
	[1] = 3,
	[2] = 575
}
RTResTalkAction[19] = {
	[1] = 2,
	[2] = 41,
	[3] = {
		3
	}
}
RTResTalkAction[20] = {
	[1] = 3,
	[2] = 575,
	[3] = {
		2
	}
}
RTResTalkAction[21] = {
	[1] = 1,
	[2] = 55
}
RTResTalkAction[22] = {
	[1] = 0,
	[2] = 41
}
RTResTalkAction[23] = {
	[1] = 0,
	[2] = 575
}
RTResTalkAction[24] = {
	[1] = 1,
	[2] = 55,
	[3] = {
		1
	}
}
RTResTalkAction[25] = {
	[1] = 0,
	[2] = 55
}
RTResTalkAction[26] = {
	[1] = 1,
	[2] = 576,
	[3] = {
		2
	}
}
RTResTalkAction[27] = {
	1,
	159,
	nil,
	nil,
	3
}
RTResTalkAction[28] = {
	3,
	158,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[29] = {
	3,
	158,
	nil,
	nil,
	6
}
RTResTalkAction[30] = {
	[1] = 3,
	[2] = 158,
	[3] = {
		3
	}
}
RTResTalkAction[31] = {
	[1] = 1,
	[2] = 160
}
RTResTalkAction[32] = {
	[1] = 2,
	[2] = 160
}
RTResTalkAction[33] = {
	[1] = 3,
	[2] = 213
}
RTResTalkAction[34] = {
	[1] = 1,
	[2] = 160,
	[3] = {
		1
	}
}
RTResTalkAction[35] = {
	[1] = 0,
	[2] = 213
}
RTResTalkAction[36] = {
	3,
	159,
	nil,
	nil,
	6
}
RTResTalkAction[37] = {
	[1] = 3,
	[2] = 159
}
RTResTalkAction[38] = {
	[1] = 2,
	[2] = 158
}
RTResTalkAction[39] = {
	[1] = 3,
	[2] = 575,
	[3] = {
		1
	}
}
RTResTalkAction[40] = {
	[1] = 0,
	[2] = 160
}
RTResTalkAction[41] = {
	[1] = 0,
	[2] = 159
}
RTResTalkAction[42] = {
	2,
	158,
	nil,
	nil,
	6
}
RTResTalkAction[43] = {
	[1] = 3,
	[2] = 55,
	[3] = {
		2
	}
}
RTResTalkAction[44] = {
	2,
	158,
	{
		3
	},
	nil,
	6
}
RTResTalkAction[45] = {
	[1] = 3,
	[2] = 55
}
RTResTalkAction[46] = {
	1,
	159,
	nil,
	nil,
	2
}
RTResTalkAction[47] = {
	[1] = 3,
	[2] = 160
}
RTResTalkAction[48] = {
	2,
	159,
	nil,
	nil,
	1
}
RTResTalkAction[49] = {
	2,
	159,
	nil,
	nil,
	4
}
RTResTalkAction[50] = {
	2,
	159,
	nil,
	nil,
	5
}
RTResTalkAction[51] = {
	[1] = 1,
	[2] = 159
}
RTResTalkAction[52] = {
	[1] = 1,
	[2] = 112
}
RTResTalkAction[53] = {
	[1] = 0,
	[2] = 112
}
RTResTalkAction[54] = {
	3,
	112,
	nil,
	nil,
	3
}
RTResTalkAction[55] = {
	[1] = 3,
	[2] = 112
}
RTResTalkAction[56] = {
	3,
	112,
	nil,
	nil,
	4
}
RTResTalkAction[57] = {
	[1] = 1,
	[2] = 3
}
RTResTalkAction[58] = {
	[1] = 1,
	[2] = 160,
	[3] = {
		3
	}
}
RTResTalkAction[59] = {
	[1] = 0,
	[2] = 3
}
RTResTalkAction[60] = {
	[1] = 2,
	[2] = 160,
	[3] = {
		2
	}
}
RTResTalkAction[61] = {
	3,
	112,
	nil,
	nil,
	1
}
RTResTalkAction[62] = {
	[1] = 1,
	[2] = 672
}
RTResTalkAction[63] = {
	[1] = 0,
	[2] = 672
}
RTResTalkAction[64] = {
	[1] = 1,
	[2] = 672,
	[3] = {
		3
	}
}
RTResTalkAction[65] = {
	[1] = 1,
	[2] = 41,
	[3] = {
		3
	}
}
RTResTalkAction[66] = {
	[1] = 1,
	[2] = 575,
	[3] = {
		2
	}
}
RTResTalkAction[67] = {
	1,
	158,
	{
		3
	},
	nil,
	6
}
RTResTalkAction[68] = {
	[1] = 2,
	[2] = 158,
	[3] = {
		1
	}
}
RTResTalkAction[69] = {
	[1] = 1,
	[2] = 158,
	[3] = {
		2
	}
}
RTResTalkAction[70] = {
	[1] = 1,
	[2] = 41,
	[3] = {
		1
	}
}
RTResTalkAction[71] = {
	[1] = 1,
	[2] = 158,
	[3] = {
		3
	}
}
RTResTalkAction[72] = {
	[1] = 2,
	[2] = 158,
	[3] = {
		3
	}
}
RTResTalkAction[73] = {
	[1] = 3,
	[2] = 576
}
RTResTalkAction[74] = {
	[1] = 1,
	[2] = 575
}
RTResTalkAction[75] = {
	1,
	158,
	{
		2
	},
	nil,
	5
}
RTResTalkAction[76] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[77] = {
	[1] = 1,
	[2] = 134,
	[3] = {
		1
	}
}
RTResTalkAction[78] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[79] = {
	[1] = 2,
	[2] = 134
}
RTResTalkAction[80] = {
	3,
	119,
	nil,
	nil,
	3
}
RTResTalkAction[81] = {
	2,
	134,
	nil,
	nil,
	2
}
RTResTalkAction[82] = {
	[1] = 3,
	[2] = 119
}
RTResTalkAction[83] = {
	[1] = 1,
	[2] = 133
}
RTResTalkAction[84] = {
	[1] = 0,
	[2] = 134
}
RTResTalkAction[85] = {
	[1] = 0,
	[2] = 119
}
RTResTalkAction[86] = {
	[1] = 2,
	[2] = 133
}
RTResTalkAction[87] = {
	3,
	107,
	{
		1
	},
	nil,
	5
}
RTResTalkAction[88] = {
	[1] = 3,
	[2] = 107
}
RTResTalkAction[89] = {
	[1] = 0,
	[2] = 133
}
RTResTalkAction[90] = {
	1,
	107,
	{
		1
	},
	nil,
	5
}
RTResTalkAction[91] = {
	[1] = 1,
	[2] = 107,
	[3] = {
		1
	}
}
RTResTalkAction[92] = {
	1,
	119,
	nil,
	nil,
	2
}
RTResTalkAction[93] = {
	[1] = 2,
	[2] = 119
}
RTResTalkAction[94] = {
	3,
	134,
	nil,
	nil,
	2
}
RTResTalkAction[95] = {
	[1] = 1,
	[2] = 107,
	[3] = {
		1,
		10021
	}
}
RTResTalkAction[96] = {
	[1] = 1,
	[2] = 204
}
RTResTalkAction[97] = {
	[1] = 1,
	[2] = 119,
	[3] = {
		1
	}
}
RTResTalkAction[98] = {
	[1] = 0,
	[2] = 204
}
RTResTalkAction[99] = {
	[1] = 1,
	[2] = 141
}
RTResTalkAction[100] = {
	1,
	134,
	nil,
	nil,
	2
}
RTResTalkAction[101] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[102] = {
	[1] = 3,
	[2] = 133
}
RTResTalkAction[103] = {
	1,
	107,
	{
		1
	},
	nil,
	6
}
RTResTalkAction[104] = {
	2,
	159,
	nil,
	nil,
	6
}
RTResTalkAction[105] = {
	3,
	158,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[106] = {
	2,
	159,
	nil,
	nil,
	0
}
RTResTalkAction[107] = {
	1,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[108] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[109] = {
	3,
	158,
	nil,
	nil,
	1
}
RTResTalkAction[110] = {
	1,
	158,
	nil,
	nil,
	1
}
RTResTalkAction[111] = {
	1,
	204,
	nil,
	nil,
	1
}
RTResTalkAction[112] = {
	[1] = 1,
	[2] = 158,
	[3] = {
		100215
	}
}
RTResTalkAction[113] = {
	[1] = 1,
	[2] = 107,
	[3] = {
		100215
	}
}
RTResTalkAction[114] = {
	1,
	158,
	nil,
	nil,
	4
}
RTResTalkAction[115] = {
	[1] = 3,
	[2] = 134
}
RTResTalkAction[116] = {
	1,
	107,
	nil,
	nil,
	5
}
RTResTalkAction[117] = {
	1,
	204,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[118] = {
	2,
	158,
	{
		1
	},
	nil,
	4
}
RTResTalkAction[119] = {
	3,
	159,
	nil,
	nil,
	3
}
RTResTalkAction[120] = {
	3,
	159,
	nil,
	nil,
	2
}
RTResTalkAction[121] = {
	1,
	134,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[122] = {
	1,
	119,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[123] = {
	3,
	150,
	nil,
	nil,
	0
}
RTResTalkAction[124] = {
	1,
	107,
	nil,
	nil,
	7
}
RTResTalkAction[125] = {
	[1] = 0,
	[2] = 150
}
RTResTalkAction[126] = {
	1,
	150,
	nil,
	nil,
	0
}
RTResTalkAction[127] = {
	[1] = 3,
	[2] = 39,
	[3] = {
		3
	}
}
RTResTalkAction[128] = {
	[1] = 0,
	[2] = 39
}
RTResTalkAction[129] = {
	[1] = 3,
	[2] = 141
}
RTResTalkAction[130] = {
	1,
	134,
	nil,
	nil,
	0
}
RTResTalkAction[131] = {
	[1] = 3,
	[2] = 39
}
RTResTalkAction[132] = {
	[1] = 1
}
RTResTalkAction[133] = {
	[1] = 1,
	[2] = 148,
	[3] = {
		2
	}
}
RTResTalkAction[134] = {
	[1] = 0
}
RTResTalkAction[135] = {
	[1] = 2,
	[2] = 148
}
RTResTalkAction[136] = {
	3,
	119,
	{
		3
	},
	nil,
	7
}
RTResTalkAction[137] = {
	[1] = 0,
	[2] = 148
}
RTResTalkAction[138] = {
	[1] = 1,
	[2] = 148
}
RTResTalkAction[139] = {
	[1] = 1,
	[2] = 559,
	[3] = {
		3
	}
}
RTResTalkAction[140] = {
	[1] = 2,
	[2] = 559
}
RTResTalkAction[141] = {
	[1] = 3,
	[2] = 560,
	[3] = {
		3
	}
}
RTResTalkAction[142] = {
	[1] = 1,
	[2] = 141,
	[3] = {
		2
	}
}
RTResTalkAction[143] = {
	[1] = 0,
	[2] = 559
}
RTResTalkAction[144] = {
	[1] = 0,
	[2] = 560
}
RTResTalkAction[145] = {
	[1] = 1,
	[2] = 143
}
RTResTalkAction[146] = {
	[1] = 0,
	[2] = 143
}
RTResTalkAction[147] = {
	[1] = 1,
	[2] = 207
}
RTResTalkAction[148] = {
	1,
	123,
	nil,
	nil,
	1
}
RTResTalkAction[149] = {
	[1] = 0,
	[2] = 207
}
RTResTalkAction[150] = {
	[1] = 1,
	[2] = 187
}
RTResTalkAction[151] = {
	[1] = 0,
	[2] = 123
}
RTResTalkAction[152] = {
	1,
	123,
	nil,
	nil,
	0
}
RTResTalkAction[153] = {
	[1] = 0,
	[2] = 187
}
RTResTalkAction[154] = {
	[1] = 1,
	[2] = 123
}
RTResTalkAction[155] = {
	[1] = 1,
	[2] = 167
}
RTResTalkAction[156] = {
	1,
	107,
	{
		10011
	},
	nil,
	3
}
RTResTalkAction[157] = {
	[1] = 0,
	[2] = 167
}
RTResTalkAction[158] = {
	1,
	107,
	{
		1
	},
	nil,
	3
}
RTResTalkAction[159] = {
	1,
	187,
	nil,
	nil,
	1
}
RTResTalkAction[160] = {
	2,
	187,
	nil,
	nil,
	0
}
RTResTalkAction[161] = {
	[1] = 3,
	[2] = 123
}
RTResTalkAction[162] = {
	1,
	107,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[163] = {
	[1] = 2,
	[2] = 187
}
RTResTalkAction[164] = {
	2,
	187,
	nil,
	nil,
	1
}
RTResTalkAction[165] = {
	1,
	119,
	{
		3
	},
	nil,
	7
}
RTResTalkAction[166] = {
	1,
	134,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[167] = {
	[1] = 3,
	[2] = 140
}
RTResTalkAction[168] = {
	[1] = 0,
	[2] = 140
}
RTResTalkAction[169] = {
	[1] = 2,
	[2] = 167
}
RTResTalkAction[170] = {
	[1] = 3,
	[2] = 149
}
RTResTalkAction[171] = {
	[1] = 1,
	[2] = 140
}
RTResTalkAction[172] = {
	[1] = 0,
	[2] = 149
}
RTResTalkAction[173] = {
	[1] = 2,
	[2] = 140
}
RTResTalkAction[174] = {
	[1] = 3,
	[2] = 128
}
RTResTalkAction[175] = {
	[1] = 0,
	[2] = 128
}
RTResTalkAction[176] = {
	1,
	107,
	{
		2
	},
	nil,
	6
}
RTResTalkAction[177] = {
	[1] = 1,
	[2] = 179
}
RTResTalkAction[178] = {
	[1] = 2,
	[2] = 179
}
RTResTalkAction[179] = {
	[1] = 0,
	[2] = 179
}
RTResTalkAction[180] = {
	[1] = 3,
	[2] = 179
}
RTResTalkAction[181] = {
	[1] = 1,
	[2] = 150
}
RTResTalkAction[182] = {
	2,
	150,
	nil,
	nil,
	0
}
RTResTalkAction[183] = {
	3,
	179,
	nil,
	nil,
	1
}
RTResTalkAction[184] = {
	[1] = 2,
	[2] = 123
}
RTResTalkAction[185] = {
	1,
	133,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[186] = {
	1,
	133,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[187] = {
	[1] = 1,
	[2] = 187,
	[3] = {
		2
	}
}
RTResTalkAction[188] = {
	[1] = 3,
	[2] = 187
}
RTResTalkAction[189] = {
	1,
	150,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[190] = {
	[1] = 1,
	[2] = 119
}
RTResTalkAction[191] = {
	1,
	179,
	nil,
	nil,
	1
}
RTResTalkAction[192] = {
	[1] = 3,
	[2] = 150
}
RTResTalkAction[193] = {
	2,
	119,
	nil,
	nil,
	2
}
RTResTalkAction[194] = {
	1,
	150,
	nil,
	nil,
	3
}
RTResTalkAction[195] = {
	1,
	107,
	{
		1
	},
	nil,
	7
}
RTResTalkAction[196] = {
	[1] = 1,
	[2] = 150,
	[3] = {
		3
	}
}
RTResTalkAction[197] = {
	1,
	107,
	nil,
	nil,
	0
}
RTResTalkAction[198] = {
	[1] = 1,
	[2] = 150,
	[3] = {
		2
	}
}
RTResTalkAction[199] = {
	1,
	150,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[200] = {
	1,
	107,
	{
		1
	},
	nil,
	8
}
RTResTalkAction[201] = {
	1,
	187,
	{
		3
	},
	nil,
	3
}
RTResTalkAction[202] = {
	2,
	123,
	nil,
	nil,
	0
}
RTResTalkAction[203] = {
	1,
	107,
	{
		10021
	},
	nil,
	3
}
RTResTalkAction[204] = {
	[1] = 3,
	[2] = 148
}
RTResTalkAction[205] = {
	1,
	150,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[206] = {
	1,
	107,
	{
		1,
		10021
	},
	nil,
	3
}
RTResTalkAction[207] = {
	1,
	150,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[208] = {
	1,
	107,
	{
		2
	},
	nil,
	5
}
RTResTalkAction[209] = {
	1,
	158,
	nil,
	nil,
	0
}
RTResTalkAction[210] = {
	1,
	107,
	{
		10021
	},
	nil,
	0
}
RTResTalkAction[211] = {
	1,
	158,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[212] = {
	[1] = 1,
	[2] = 500,
	[3] = {
		2
	}
}
RTResTalkAction[213] = {
	[1] = 0,
	[2] = 500
}
RTResTalkAction[214] = {
	1,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[215] = {
	2,
	107,
	nil,
	nil,
	3
}
RTResTalkAction[216] = {
	1,
	150,
	nil,
	nil,
	2
}
RTResTalkAction[217] = {
	1,
	500,
	nil,
	nil,
	1
}
RTResTalkAction[218] = {
	1,
	500,
	nil,
	nil,
	2
}
RTResTalkAction[219] = {
	[1] = 2,
	[2] = 500
}
RTResTalkAction[220] = {
	3,
	150,
	nil,
	nil,
	2
}
RTResTalkAction[221] = {
	2,
	500,
	nil,
	nil,
	3
}
RTResTalkAction[222] = {
	2,
	500,
	nil,
	nil,
	2
}
RTResTalkAction[223] = {
	[1] = 1,
	[2] = 500
}
RTResTalkAction[224] = {
	1,
	500,
	nil,
	nil,
	0
}
RTResTalkAction[225] = {
	1,
	107,
	{
		2
	},
	nil,
	7
}
RTResTalkAction[226] = {
	1,
	107,
	{
		10021
	},
	nil,
	8
}
RTResTalkAction[227] = {
	1,
	187,
	nil,
	nil,
	3
}
RTResTalkAction[228] = {
	1,
	500,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[229] = {
	[1] = 1,
	[2] = 123,
	[3] = {
		1
	}
}
RTResTalkAction[230] = {
	1,
	107,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[231] = {
	1,
	187,
	nil,
	nil,
	2
}
RTResTalkAction[232] = {
	1,
	500,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[233] = {
	1,
	107,
	{
		3
	},
	nil,
	8
}
RTResTalkAction[234] = {
	1,
	107,
	{
		2
	},
	nil,
	8
}
RTResTalkAction[235] = {
	1,
	134,
	nil,
	nil,
	3
}
RTResTalkAction[236] = {
	1,
	107,
	nil,
	nil,
	1
}
RTResTalkAction[237] = {
	1,
	150,
	nil,
	nil,
	1
}
RTResTalkAction[238] = {
	[1] = 2,
	[2] = 150
}
RTResTalkAction[239] = {
	[1] = 3,
	[2] = 204
}
RTResTalkAction[240] = {
	3,
	204,
	nil,
	nil,
	3
}
RTResTalkAction[241] = {
	2,
	150,
	nil,
	nil,
	1
}
RTResTalkAction[242] = {
	3,
	204,
	nil,
	nil,
	0
}
RTResTalkAction[243] = {
	2,
	150,
	nil,
	nil,
	3
}
RTResTalkAction[244] = {
	2,
	150,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[245] = {
	1,
	500,
	nil,
	nil,
	5
}
RTResTalkAction[246] = {
	1,
	500,
	{
		3
	},
	nil,
	5
}
RTResTalkAction[247] = {
	1,
	107,
	nil,
	nil,
	3
}
RTResTalkAction[248] = {
	1,
	112,
	nil,
	nil,
	0
}
RTResTalkAction[249] = {
	3,
	500,
	nil,
	nil,
	5
}
RTResTalkAction[250] = {
	1,
	158,
	nil,
	nil,
	5
}
RTResTalkAction[251] = {
	1,
	107,
	{
		1,
		10021
	},
	nil,
	0
}
RTResTalkAction[252] = {
	1,
	148,
	nil,
	nil,
	0
}
RTResTalkAction[253] = {
	1,
	107,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[254] = {
	1,
	158,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[255] = {
	1,
	150,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[256] = {
	1,
	158,
	{
		100215
	},
	nil,
	2
}
RTResTalkAction[257] = {
	2,
	158,
	nil,
	nil,
	2
}
RTResTalkAction[258] = {
	1,
	181,
	{
		1
	},
	nil,
	4
}
RTResTalkAction[259] = {
	[1] = 2,
	[2] = 181
}
RTResTalkAction[260] = {
	[1] = 3,
	[2] = 183
}
RTResTalkAction[261] = {
	2,
	181,
	nil,
	nil,
	0
}
RTResTalkAction[262] = {
	[1] = 0,
	[2] = 181
}
RTResTalkAction[263] = {
	[1] = 0,
	[2] = 183
}
RTResTalkAction[264] = {
	[1] = 1,
	[2] = 579,
	[3] = {
		2
	}
}
RTResTalkAction[265] = {
	[1] = 1,
	[2] = 581,
	[3] = {
		2
	}
}
RTResTalkAction[266] = {
	[1] = 0,
	[2] = 579
}
RTResTalkAction[267] = {
	[1] = 1,
	[2] = 302
}
RTResTalkAction[268] = {
	[1] = 0,
	[2] = 581
}
RTResTalkAction[269] = {
	[1] = 1,
	[2] = 579
}
RTResTalkAction[270] = {
	[1] = 0,
	[2] = 302
}
RTResTalkAction[271] = {
	[1] = 1,
	[2] = 196
}
RTResTalkAction[272] = {
	[1] = 2,
	[2] = 196
}
RTResTalkAction[273] = {
	3,
	194,
	nil,
	nil,
	1
}
RTResTalkAction[274] = {
	[1] = 3,
	[2] = 194
}
RTResTalkAction[275] = {
	3,
	194,
	nil,
	nil,
	0
}
RTResTalkAction[276] = {
	[1] = 1,
	[2] = 579,
	[3] = {
		3
	}
}
RTResTalkAction[277] = {
	[1] = 0,
	[2] = 196
}
RTResTalkAction[278] = {
	[1] = 0,
	[2] = 194
}
RTResTalkAction[279] = {
	[1] = 1,
	[2] = 107,
	[3] = {
		2
	}
}
RTResTalkAction[280] = {
	[1] = 2,
	[2] = 579
}
RTResTalkAction[281] = {
	[1] = 3,
	[2] = 581,
	[3] = {
		3
	}
}
RTResTalkAction[282] = {
	1,
	158,
	{
		1
	},
	nil,
	5
}
RTResTalkAction[283] = {
	[1] = 1,
	[2] = 107,
	[3] = {
		10021
	}
}
RTResTalkAction[284] = {
	1,
	141,
	nil,
	nil,
	1
}
RTResTalkAction[285] = {
	[1] = 1,
	[2] = 149
}
RTResTalkAction[286] = {
	[1] = 2,
	[2] = 149
}
RTResTalkAction[287] = {
	[1] = 1,
	[2] = 55,
	[3] = {
		2
	}
}
RTResTalkAction[288] = {
	1,
	211,
	nil,
	nil,
	1
}
RTResTalkAction[289] = {
	[1] = 0,
	[2] = 211
}
RTResTalkAction[290] = {
	1,
	119,
	nil,
	nil,
	3
}
RTResTalkAction[291] = {
	[1] = 1,
	[2] = 134
}
RTResTalkAction[292] = {
	[1] = 3,
	[2] = 559,
	[3] = {
		3
	}
}
RTResTalkAction[293] = {
	1,
	211,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[294] = {
	[1] = 1,
	[2] = 206
}
RTResTalkAction[295] = {
	[1] = 2,
	[2] = 206
}
RTResTalkAction[296] = {
	[1] = 0,
	[2] = 206
}
RTResTalkAction[297] = {
	[1] = 1,
	[2] = 119,
	[3] = {
		3
	}
}
RTResTalkAction[298] = {
	3,
	150,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[299] = {
	1,
	119,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[300] = {
	1,
	134,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[301] = {
	[1] = 1,
	[2] = 55,
	[3] = {
		3
	}
}
RTResTalkAction[302] = {
	1,
	119,
	nil,
	nil,
	7
}
RTResTalkAction[303] = {
	3,
	107,
	nil,
	nil,
	5
}
RTResTalkAction[304] = {
	3,
	134,
	nil,
	nil,
	1
}
RTResTalkAction[305] = {
	2,
	179,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[306] = {
	2,
	179,
	nil,
	nil,
	0
}
RTResTalkAction[307] = {
	2,
	179,
	nil,
	nil,
	2
}
RTResTalkAction[308] = {
	1,
	119,
	nil,
	nil,
	1
}
RTResTalkAction[309] = {
	2,
	119,
	{
		3
	},
	nil,
	3
}
RTResTalkAction[310] = {
	2,
	119,
	nil,
	nil,
	3
}
RTResTalkAction[311] = {
	1,
	107,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[312] = {
	[1] = 3,
	[2] = 207
}
RTResTalkAction[313] = {
	1,
	119,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[314] = {
	1,
	141,
	nil,
	nil,
	0
}
RTResTalkAction[315] = {
	[1] = 1,
	[2] = 194
}
RTResTalkAction[316] = {
	[1] = 1,
	[2] = 167,
	[3] = {
		3
	}
}
RTResTalkAction[317] = {
	[1] = 1,
	[2] = 41,
	[3] = {
		2
	}
}
RTResTalkAction[318] = {
	3,
	196,
	nil,
	nil,
	3
}
RTResTalkAction[319] = {
	2,
	107,
	nil,
	nil,
	2
}
RTResTalkAction[320] = {
	[1] = 3,
	[2] = 196
}
RTResTalkAction[321] = {
	3,
	196,
	nil,
	nil,
	1
}
RTResTalkAction[322] = {
	3,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[323] = {
	1,
	196,
	nil,
	nil,
	0
}
RTResTalkAction[324] = {
	2,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[325] = {
	3,
	196,
	nil,
	nil,
	0
}
RTResTalkAction[326] = {
	3,
	196,
	nil,
	nil,
	2
}
RTResTalkAction[327] = {
	2,
	107,
	{
		3
	},
	nil,
	5
}
RTResTalkAction[328] = {
	1,
	196,
	nil,
	nil,
	4
}
RTResTalkAction[329] = {
	1,
	107,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[330] = {
	[1] = 1,
	[2] = 128
}
RTResTalkAction[331] = {
	[1] = 1,
	[2] = 301,
	[3] = {
		2
	}
}
RTResTalkAction[332] = {
	[1] = 1,
	[2] = 301
}
RTResTalkAction[333] = {
	[1] = 0,
	[2] = 301
}
RTResTalkAction[334] = {
	[1] = 2,
	[2] = 167,
	[3] = {
		3
	}
}
RTResTalkAction[335] = {
	1,
	179,
	nil,
	nil,
	0
}
RTResTalkAction[336] = {
	[1] = 1,
	[2] = 581,
	[3] = {
		3
	}
}
RTResTalkAction[337] = {
	3,
	107,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[338] = {
	[1] = 1,
	[2] = 149,
	[3] = {
		2
	}
}
RTResTalkAction[339] = {
	1,
	107,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[340] = {
	1,
	107,
	{
		1,
		10021
	},
	nil,
	6
}
RTResTalkAction[341] = {
	[1] = 1,
	[2] = 149,
	[3] = {
		3
	}
}
RTResTalkAction[342] = {
	[1] = 3,
	[2] = 119,
	[3] = {
		3
	}
}
RTResTalkAction[343] = {
	3,
	158,
	nil,
	nil,
	5
}
RTResTalkAction[344] = {
	2,
	107,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[345] = {
	[1] = 2,
	[2] = 207
}
RTResTalkAction[346] = {
	[1] = 3,
	[2] = 143
}
RTResTalkAction[347] = {
	[1] = 2,
	[2] = 141
}
RTResTalkAction[348] = {
	[1] = 4,
	[2] = 141
}
RTResTalkAction[349] = {
	[1] = 5,
	[2] = 133
}
RTResTalkAction[350] = {
	2,
	107,
	{
		10021
	},
	nil,
	7
}
RTResTalkAction[351] = {
	3,
	141,
	nil,
	nil,
	1
}
RTResTalkAction[352] = {
	2,
	107,
	{
		10031
	},
	nil,
	6
}
RTResTalkAction[353] = {
	2,
	107,
	nil,
	nil,
	5
}
RTResTalkAction[354] = {
	2,
	107,
	nil,
	nil,
	7
}
RTResTalkAction[355] = {
	3,
	141,
	{
		10012
	},
	nil,
	0
}
RTResTalkAction[356] = {
	2,
	107,
	{
		1
	},
	nil,
	5
}
RTResTalkAction[357] = {
	1,
	107,
	{
		10031
	},
	nil,
	6
}
RTResTalkAction[358] = {
	1,
	107,
	{
		10011
	},
	nil,
	4
}
RTResTalkAction[359] = {
	2,
	107,
	{
		10031
	},
	nil,
	7
}
RTResTalkAction[360] = {
	2,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[361] = {
	2,
	107,
	{
		10031
	},
	nil,
	5
}
RTResTalkAction[362] = {
	1,
	107,
	{
		10031
	},
	nil,
	5
}
RTResTalkAction[363] = {
	3,
	141,
	nil,
	nil,
	0
}
RTResTalkAction[364] = {
	2,
	107,
	{
		10011
	},
	nil,
	4
}
RTResTalkAction[365] = {
	2,
	107,
	{
		1
	},
	nil,
	7
}
RTResTalkAction[366] = {
	1,
	107,
	{
		10011
	},
	nil,
	6
}
RTResTalkAction[367] = {
	1,
	163,
	nil,
	nil,
	1
}
RTResTalkAction[368] = {
	1,
	163,
	nil,
	nil,
	4
}
RTResTalkAction[369] = {
	[1] = 0,
	[2] = 163
}
RTResTalkAction[370] = {
	[1] = 1,
	[2] = 204,
	[3] = {
		1
	}
}

local Data = {
	[16300001] = {
		16300001,
		3,
		Lang.get(26027),
		16300,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		67,
		16300,
		0.5,
		nil,
		1,
		nil,
		16300,
		nil,
		nil,
		1
	},
	[16300002] = {
		16300002,
		3,
		Lang.get(26028),
		16300,
		2,
		605,
		[21] = 1,
		[17] = 1225
	},
	[16300003] = {
		16300003,
		0,
		Lang.get(26029),
		16300,
		3,
		212,
		nil,
		nil,
		nil,
		3
	},
	[16300004] = {
		16300004,
		0,
		Lang.get(26030),
		16300,
		4,
		212
	},
	[16300005] = {
		16300005,
		4,
		nil,
		16300,
		5,
		212,
		[27] = {
			{
				id = 16300006,
				branch_content = Lang.get(42538)
			}
		}
	},
	[16300006] = {
		16300006,
		0,
		Lang.get(26032),
		16300,
		6,
		212
	},
	[16300007] = {
		16300007,
		4,
		nil,
		16300,
		7,
		212,
		[27] = {
			{
				id = 16300008,
				branch_content = Lang.get(42539)
			},
			{
				id = 16300010,
				branch_content = Lang.get(42540)
			}
		}
	},
	[16300008] = {
		16300008,
		0,
		Lang.get(26034),
		16300,
		8,
		212
	},
	[16300009] = {
		16300009,
		4,
		nil,
		16300,
		9,
		300,
		{
			RTResTalkAction[1]
		},
		[27] = {
			{
				id = 16300012,
				branch_content = Lang.get(42541)
			}
		}
	},
	[16300010] = {
		16300010,
		0,
		"……",
		16300,
		10,
		212,
		{
			RTResTalkAction[2]
		}
	},
	[16300011] = {
		16300011,
		4,
		nil,
		16300,
		11,
		300,
		{
			RTResTalkAction[1]
		},
		[27] = {
			{
				id = 16300012,
				branch_content = Lang.get(42542)
			}
		}
	},
	[16300012] = {
		16300012,
		0,
		Lang.get(26037),
		16300,
		12,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[2]
		}
	},
	[16300013] = {
		16300013,
		4,
		nil,
		16300,
		13,
		158,
		{
			RTResTalkAction[4]
		},
		[27] = {
			{
				id = 16300014,
				branch_content = Lang.get(42543)
			}
		}
	},
	[16300014] = {
		16300014,
		0,
		Lang.get(26039),
		16300,
		14,
		158,
		{
			RTResTalkAction[5]
		}
	},
	[16300015] = {
		16300015,
		4,
		nil,
		16300,
		15,
		158,
		{
			RTResTalkAction[4]
		},
		[27] = {
			{
				id = 16300016,
				branch_content = Lang.get(42544)
			},
			{
				id = 16300016,
				branch_content = Lang.get(42545)
			}
		}
	},
	[16300016] = {
		16300016,
		0,
		Lang.get(26041),
		16300,
		16,
		158,
		{
			RTResTalkAction[4]
		}
	},
	[16300017] = {
		16300017,
		0,
		Lang.get(26042),
		16300,
		17,
		300,
		{
			RTResTalkAction[4]
		}
	},
	[16300018] = {
		16300018,
		0,
		Lang.get(31858),
		16300,
		18,
		158,
		{
			RTResTalkAction[6]
		}
	},
	[16300019] = {
		16300019,
		0,
		Lang.get(26044),
		16300,
		19,
		158,
		{
			RTResTalkAction[4]
		}
	},
	[16300020] = {
		16300020,
		0,
		Lang.get(26045),
		16300,
		20,
		300,
		{
			RTResTalkAction[4]
		}
	},
	[16300021] = {
		16300021,
		0,
		Lang.get(26046),
		16300,
		21,
		158,
		{
			RTResTalkAction[7]
		}
	},
	[16300022] = {
		16300022,
		0,
		Lang.get(26047),
		16300,
		22,
		300,
		{
			RTResTalkAction[4]
		}
	},
	[16300023] = {
		16300023,
		0,
		Lang.get(26048),
		16300,
		23,
		158,
		{
			RTResTalkAction[4]
		}
	},
	[16300024] = {
		16300024,
		5,
		Lang.get(31859),
		16300,
		24,
		159,
		{
			RTResTalkAction[8]
		},
		1
	},
	[16300025] = {
		16300025,
		0,
		Lang.get(31860),
		16300,
		25,
		158,
		{
			RTResTalkAction[4]
		}
	},
	[16300026] = {
		16300026,
		3,
		Lang.get(26051),
		16300,
		26,
		605,
		{
			RTResTalkAction[9]
		},
		[21] = 1,
		[17] = 1226
	},
	[16300027] = {
		16300027,
		0,
		Lang.get(26052),
		16300,
		27,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[16300028] = {
		16300028,
		0,
		Lang.get(32946),
		16300,
		28,
		159,
		{
			RTResTalkAction[10],
			RTResTalkAction[11],
			RTResTalkAction[2]
		},
		nil,
		nil,
		3,
		nil,
		67,
		16301,
		2,
		nil,
		1,
		nil,
		16301
	},
	[16300029] = {
		16300029,
		0,
		Lang.get(31861),
		16300,
		29,
		158,
		{
			RTResTalkAction[10],
			RTResTalkAction[12]
		}
	},
	[16300030] = {
		16300030,
		0,
		Lang.get(26055),
		16300,
		30,
		159,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[16300031] = {
		16300031,
		0,
		Lang.get(26056),
		16300,
		31,
		159,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[16300032] = {
		16300032,
		0,
		Lang.get(26057),
		16300,
		32,
		158,
		{
			RTResTalkAction[10],
			RTResTalkAction[13]
		}
	},
	[16301001] = {
		16301001,
		0,
		Lang.get(26058),
		16301,
		1,
		576,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3,
		nil,
		62,
		16302,
		2,
		nil,
		1,
		nil,
		16302
	},
	[16301002] = {
		16301002,
		0,
		Lang.get(31862),
		16301,
		2,
		576,
		{
			RTResTalkAction[14]
		}
	},
	[16301003] = {
		16301003,
		0,
		Lang.get(31863),
		16301,
		3,
		41,
		{
			RTResTalkAction[15],
			RTResTalkAction[16]
		}
	},
	[16301004] = {
		16301004,
		0,
		Lang.get(31864),
		16301,
		4,
		575,
		{
			RTResTalkAction[17],
			RTResTalkAction[18]
		}
	},
	[16301005] = {
		16301005,
		0,
		Lang.get(31865),
		16301,
		5,
		41,
		{
			RTResTalkAction[19],
			RTResTalkAction[18]
		}
	},
	[16301006] = {
		16301006,
		0,
		Lang.get(31866),
		16301,
		6,
		575,
		{
			RTResTalkAction[17],
			RTResTalkAction[20]
		}
	},
	[16301007] = {
		16301007,
		0,
		Lang.get(31867),
		16301,
		7,
		55,
		{
			RTResTalkAction[21],
			RTResTalkAction[22],
			RTResTalkAction[23]
		}
	},
	[16301008] = {
		16301008,
		0,
		Lang.get(32947),
		16301,
		8,
		55,
		{
			RTResTalkAction[24]
		}
	},
	[16301009] = {
		16301009,
		0,
		Lang.get(31869),
		16301,
		9,
		576,
		{
			RTResTalkAction[14],
			RTResTalkAction[25]
		}
	},
	[16301010] = {
		16301010,
		2,
		Lang.get(26067),
		16301,
		10,
		158,
		{
			RTResTalkAction[14]
		},
		1,
		6
	},
	[16301011] = {
		16301011,
		0,
		Lang.get(31870),
		16301,
		11,
		576,
		{
			RTResTalkAction[26]
		}
	},
	[16302001] = {
		16302001,
		0,
		Lang.get(31871),
		16302,
		1,
		159,
		{
			RTResTalkAction[27]
		},
		nil,
		nil,
		3,
		nil,
		62,
		16303,
		0.5,
		nil,
		1,
		nil,
		16303
	},
	[16302002] = {
		16302002,
		0,
		Lang.get(31872),
		16302,
		2,
		158,
		{
			RTResTalkAction[10],
			RTResTalkAction[28]
		}
	},
	[16302003] = {
		16302003,
		0,
		Lang.get(31873),
		16302,
		3,
		158,
		{
			RTResTalkAction[10],
			RTResTalkAction[29]
		}
	},
	[16302004] = {
		16302004,
		0,
		Lang.get(31874),
		16302,
		4,
		158,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[16302005] = {
		16302005,
		5,
		Lang.get(31875),
		16302,
		5,
		158,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[16310001] = {
		16310001,
		0,
		Lang.get(26074),
		16310,
		1,
		160,
		{
			RTResTalkAction[31]
		},
		nil,
		nil,
		3,
		nil,
		60,
		16310,
		1.5,
		2,
		1,
		nil,
		16310
	},
	[16310002] = {
		16310002,
		2,
		Lang.get(26075),
		16310,
		2,
		213,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[16310003] = {
		16310003,
		0,
		Lang.get(26076),
		16310,
		3,
		160,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[16310004] = {
		16310004,
		2,
		Lang.get(31876),
		16310,
		4,
		213,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[16310005] = {
		16310005,
		0,
		Lang.get(26078),
		16310,
		5,
		160,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[16310006] = {
		16310006,
		2,
		Lang.get(26079),
		16310,
		6,
		213,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[16310007] = {
		16310007,
		2,
		Lang.get(26080),
		16310,
		7,
		213,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[16310008] = {
		16310008,
		2,
		Lang.get(26081),
		16310,
		8,
		213,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[16310009] = {
		16310009,
		0,
		Lang.get(26082),
		16310,
		9,
		160,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[16310010] = {
		16310010,
		0,
		Lang.get(26083),
		16310,
		10,
		160,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		16311,
		nil,
		1,
		1,
		nil,
		16311
	},
	[16310011] = {
		16310011,
		0,
		Lang.get(26084),
		16310,
		11,
		159,
		{
			RTResTalkAction[32],
			RTResTalkAction[36]
		}
	},
	[16310012] = {
		16310012,
		0,
		Lang.get(26085),
		16310,
		12,
		160,
		{
			RTResTalkAction[32],
			RTResTalkAction[37]
		}
	},
	[16310013] = {
		16310013,
		2,
		Lang.get(26086),
		16310,
		13,
		213,
		{
			RTResTalkAction[32],
			RTResTalkAction[37]
		},
		1
	},
	[16310014] = {
		16310014,
		0,
		Lang.get(31877),
		16310,
		14,
		575,
		{
			RTResTalkAction[38],
			RTResTalkAction[39],
			RTResTalkAction[40],
			RTResTalkAction[41]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		16312,
		1.2,
		1,
		1,
		nil,
		16312
	},
	[16310015] = {
		16310015,
		0,
		Lang.get(31878),
		16310,
		15,
		158,
		{
			RTResTalkAction[42],
			RTResTalkAction[18]
		}
	},
	[16310016] = {
		16310016,
		0,
		Lang.get(31879),
		16310,
		16,
		55,
		{
			RTResTalkAction[38],
			RTResTalkAction[43],
			RTResTalkAction[23]
		}
	},
	[16310017] = {
		16310017,
		5,
		Lang.get(26090),
		16310,
		17,
		158,
		{
			RTResTalkAction[44],
			RTResTalkAction[45]
		}
	},
	[16310018] = {
		16310018,
		0,
		Lang.get(26091),
		16310,
		18,
		159,
		{
			RTResTalkAction[46],
			RTResTalkAction[9],
			RTResTalkAction[25]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		16311,
		nil,
		1,
		1,
		nil,
		16311
	},
	[16310019] = {
		16310019,
		0,
		Lang.get(26092),
		16310,
		19,
		160,
		{
			RTResTalkAction[10],
			RTResTalkAction[47]
		}
	},
	[16310020] = {
		16310020,
		0,
		Lang.get(26093),
		16310,
		20,
		159,
		{
			RTResTalkAction[48],
			RTResTalkAction[47]
		}
	},
	[16310021] = {
		16310021,
		0,
		Lang.get(26094),
		16310,
		21,
		160,
		{
			RTResTalkAction[10],
			RTResTalkAction[47]
		}
	},
	[16310022] = {
		16310022,
		0,
		Lang.get(32948),
		16310,
		22,
		159,
		{
			RTResTalkAction[49],
			RTResTalkAction[47]
		}
	},
	[16310023] = {
		16310023,
		0,
		Lang.get(26096),
		16310,
		23,
		160,
		{
			RTResTalkAction[10],
			RTResTalkAction[47]
		}
	},
	[16310024] = {
		16310024,
		0,
		Lang.get(31880),
		16310,
		24,
		159,
		{
			RTResTalkAction[50],
			RTResTalkAction[47]
		}
	},
	[16310025] = {
		16310025,
		0,
		Lang.get(31208),
		16310,
		25,
		160,
		{
			RTResTalkAction[10],
			RTResTalkAction[47]
		}
	},
	[16310026] = {
		16310026,
		0,
		Lang.get(31881),
		16310,
		26,
		159,
		{
			RTResTalkAction[51],
			RTResTalkAction[40]
		}
	},
	[16311001] = {
		16311001,
		0,
		Lang.get(31882),
		16311,
		1,
		160,
		{
			RTResTalkAction[31]
		},
		nil,
		nil,
		3,
		nil,
		60,
		16313,
		nil,
		nil,
		1,
		nil,
		16313
	},
	[16311002] = {
		16311002,
		2,
		Lang.get(31883),
		16311,
		2,
		213,
		{
			RTResTalkAction[31]
		},
		1
	},
	[16311003] = {
		16311003,
		2,
		Lang.get(31884),
		16311,
		3,
		213,
		{
			RTResTalkAction[31]
		},
		1
	},
	[16311004] = {
		16311004,
		0,
		Lang.get(26103),
		16311,
		4,
		112,
		{
			RTResTalkAction[52],
			RTResTalkAction[40]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		16314,
		1,
		1,
		1,
		nil,
		16314
	},
	[16311005] = {
		16311005,
		0,
		Lang.get(26104),
		16311,
		5,
		160,
		{
			RTResTalkAction[31],
			RTResTalkAction[53]
		}
	},
	[16311006] = {
		16311006,
		0,
		Lang.get(26105),
		16311,
		6,
		112,
		{
			RTResTalkAction[52],
			RTResTalkAction[40]
		}
	},
	[16311007] = {
		16311007,
		2,
		Lang.get(26106),
		16311,
		7,
		213,
		{
			RTResTalkAction[52]
		},
		1
	},
	[16311008] = {
		16311008,
		0,
		Lang.get(31885),
		16311,
		8,
		160,
		{
			RTResTalkAction[34],
			RTResTalkAction[53]
		}
	},
	[16311009] = {
		16311009,
		0,
		Lang.get(31886),
		16311,
		9,
		112,
		{
			RTResTalkAction[32],
			RTResTalkAction[54]
		}
	},
	[16311010] = {
		16311010,
		0,
		Lang.get(26109),
		16311,
		10,
		160,
		{
			RTResTalkAction[32],
			RTResTalkAction[55]
		}
	},
	[16311011] = {
		16311011,
		0,
		Lang.get(31887),
		16311,
		11,
		112,
		{
			RTResTalkAction[32],
			RTResTalkAction[56]
		}
	},
	[16311012] = {
		16311012,
		0,
		Lang.get(31213),
		16311,
		12,
		160,
		{
			RTResTalkAction[32],
			RTResTalkAction[55]
		}
	},
	[16311013] = {
		16311013,
		0,
		Lang.get(26112),
		16311,
		13,
		112,
		{
			RTResTalkAction[52],
			RTResTalkAction[40]
		}
	},
	[16311014] = {
		16311014,
		5,
		Lang.get(22255),
		16311,
		14,
		3,
		{
			RTResTalkAction[57],
			RTResTalkAction[53]
		}
	},
	[16311015] = {
		16311015,
		0,
		Lang.get(31888),
		16311,
		15,
		160,
		{
			RTResTalkAction[58],
			RTResTalkAction[59]
		}
	},
	[16311016] = {
		16311016,
		0,
		Lang.get(31889),
		16311,
		16,
		112,
		{
			RTResTalkAction[32],
			RTResTalkAction[55]
		}
	},
	[16311017] = {
		16311017,
		0,
		Lang.get(31890),
		16311,
		17,
		160,
		{
			RTResTalkAction[32],
			RTResTalkAction[55]
		}
	},
	[16311018] = {
		16311018,
		0,
		Lang.get(31891),
		16311,
		18,
		112,
		{
			RTResTalkAction[32],
			RTResTalkAction[55]
		}
	},
	[16311019] = {
		16311019,
		0,
		Lang.get(26117),
		16311,
		19,
		160,
		{
			RTResTalkAction[60],
			RTResTalkAction[55]
		}
	},
	[16311020] = {
		16311020,
		0,
		Lang.get(31892),
		16311,
		20,
		112,
		{
			RTResTalkAction[32],
			RTResTalkAction[61]
		}
	},
	[16311021] = {
		16311021,
		2,
		Lang.get(26119),
		16311,
		21,
		213,
		{
			RTResTalkAction[31],
			RTResTalkAction[53]
		},
		1
	},
	[16311022] = {
		16311022,
		0,
		Lang.get(31893),
		16311,
		22,
		160,
		{
			RTResTalkAction[31]
		}
	},
	[16312001] = {
		16312001,
		0,
		Lang.get(26121),
		16312,
		1,
		160,
		nil,
		1,
		nil,
		nil,
		nil,
		8,
		[19] = 255
	},
	[16312002] = {
		16312002,
		2,
		Lang.get(31894),
		16312,
		2,
		213,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		16316,
		[18] = 16316,
		[19] = -1
	},
	[16312003] = {
		16312003,
		0,
		Lang.get(31895),
		16312,
		3,
		160,
		{
			RTResTalkAction[31]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		nil,
		nil,
		1,
		1
	},
	[16312004] = {
		16312004,
		0,
		Lang.get(26126),
		16312,
		4,
		112,
		{
			RTResTalkAction[52],
			RTResTalkAction[40]
		}
	},
	[16312005] = {
		16312005,
		0,
		Lang.get(31896),
		16312,
		5,
		112,
		{
			RTResTalkAction[52]
		}
	},
	[16312006] = {
		16312006,
		5,
		Lang.get(31897),
		16312,
		6,
		672,
		{
			RTResTalkAction[62],
			RTResTalkAction[53]
		}
	},
	[16312007] = {
		16312007,
		0,
		Lang.get(31898),
		16312,
		7,
		112,
		{
			RTResTalkAction[52],
			RTResTalkAction[63]
		}
	},
	[16312008] = {
		16312008,
		5,
		Lang.get(31899),
		16312,
		8,
		672,
		{
			RTResTalkAction[62],
			RTResTalkAction[53]
		}
	},
	[16312009] = {
		16312009,
		0,
		Lang.get(26129),
		16312,
		9,
		160,
		{
			RTResTalkAction[31],
			RTResTalkAction[63]
		}
	},
	[16312010] = {
		16312010,
		0,
		Lang.get(31900),
		16312,
		10,
		112,
		{
			RTResTalkAction[52],
			RTResTalkAction[40]
		}
	},
	[16312011] = {
		16312011,
		5,
		Lang.get(31901),
		16312,
		11,
		672,
		{
			RTResTalkAction[64],
			RTResTalkAction[53]
		}
	},
	[16320001] = {
		16320001,
		3,
		Lang.get(26132),
		16320,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		16320,
		1.5,
		nil,
		1,
		nil,
		16320,
		nil,
		nil,
		1
	},
	[16320002] = {
		16320002,
		5,
		Lang.get(26133),
		16320,
		2,
		41,
		{
			RTResTalkAction[65]
		},
		nil,
		nil,
		3
	},
	[16320003] = {
		16320003,
		5,
		Lang.get(31902),
		16320,
		3,
		575,
		{
			RTResTalkAction[66],
			RTResTalkAction[22]
		}
	},
	[16320004] = {
		16320004,
		5,
		Lang.get(26135),
		16320,
		4,
		55,
		{
			RTResTalkAction[21],
			RTResTalkAction[23]
		}
	},
	[16320005] = {
		16320005,
		0,
		Lang.get(26136),
		16320,
		5,
		112,
		{
			RTResTalkAction[21]
		},
		1,
		3
	},
	[16320006] = {
		16320006,
		5,
		Lang.get(31903),
		16320,
		6,
		576,
		{
			RTResTalkAction[14],
			RTResTalkAction[25]
		}
	},
	[16320007] = {
		16320007,
		5,
		Lang.get(31904),
		16320,
		7,
		158,
		{
			RTResTalkAction[67],
			RTResTalkAction[16]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		16321,
		1.5,
		1,
		1,
		nil,
		16321
	},
	[16320008] = {
		16320008,
		0,
		Lang.get(31905),
		16320,
		8,
		112,
		{
			RTResTalkAction[38],
			RTResTalkAction[54]
		}
	},
	[16320009] = {
		16320009,
		5,
		Lang.get(31906),
		16320,
		9,
		158,
		{
			RTResTalkAction[68],
			RTResTalkAction[55]
		}
	},
	[16320010] = {
		16320010,
		0,
		Lang.get(31907),
		16320,
		10,
		112,
		{
			RTResTalkAction[38],
			RTResTalkAction[61]
		}
	},
	[16320011] = {
		16320011,
		5,
		Lang.get(26142),
		16320,
		11,
		41,
		{
			RTResTalkAction[65],
			RTResTalkAction[9],
			RTResTalkAction[53]
		}
	},
	[16320012] = {
		16320012,
		5,
		Lang.get(23178),
		16320,
		12,
		158,
		{
			RTResTalkAction[69],
			RTResTalkAction[22]
		}
	},
	[16320013] = {
		16320013,
		0,
		Lang.get(31908),
		16320,
		13,
		41,
		{
			RTResTalkAction[70],
			RTResTalkAction[9]
		}
	},
	[16320014] = {
		16320014,
		0,
		Lang.get(32949),
		16320,
		14,
		160,
		{
			RTResTalkAction[31],
			RTResTalkAction[22]
		}
	},
	[16320015] = {
		16320015,
		0,
		Lang.get(31910),
		16320,
		15,
		159,
		{
			RTResTalkAction[32],
			RTResTalkAction[37]
		}
	},
	[16320016] = {
		16320016,
		0,
		Lang.get(26146),
		16320,
		16,
		160,
		{
			RTResTalkAction[32],
			RTResTalkAction[37]
		}
	},
	[16320017] = {
		16320017,
		0,
		Lang.get(26147),
		16320,
		17,
		159,
		{
			RTResTalkAction[51],
			RTResTalkAction[40]
		}
	},
	[16320018] = {
		16320018,
		0,
		Lang.get(26148),
		16320,
		18,
		158,
		{
			RTResTalkAction[41]
		},
		1,
		6,
		nil,
		nil,
		nil,
		16322,
		1.5,
		1,
		1,
		nil,
		16322
	},
	[16320019] = {
		16320019,
		0,
		Lang.get(31911),
		16320,
		19,
		112,
		nil,
		1,
		0
	},
	[16320020] = {
		16320020,
		5,
		Lang.get(26150),
		16320,
		20,
		158,
		{
			RTResTalkAction[71]
		},
		nil,
		nil,
		3
	},
	[16320021] = {
		16320021,
		0,
		Lang.get(31912),
		16320,
		21,
		112,
		{
			RTResTalkAction[38],
			RTResTalkAction[54]
		}
	},
	[16320022] = {
		16320022,
		0,
		Lang.get(31216),
		16320,
		22,
		158,
		{
			RTResTalkAction[38],
			RTResTalkAction[55]
		}
	},
	[16320023] = {
		16320023,
		0,
		Lang.get(31913),
		16320,
		23,
		112,
		{
			RTResTalkAction[38],
			RTResTalkAction[55]
		}
	},
	[16320024] = {
		16320024,
		5,
		Lang.get(31914),
		16320,
		24,
		158,
		{
			RTResTalkAction[72],
			RTResTalkAction[55]
		}
	},
	[16320025] = {
		16320025,
		0,
		Lang.get(31915),
		16320,
		25,
		112,
		{
			RTResTalkAction[38],
			RTResTalkAction[61]
		}
	},
	[16320026] = {
		16320026,
		5,
		Lang.get(31916),
		16320,
		26,
		158,
		{
			RTResTalkAction[72],
			RTResTalkAction[55]
		}
	},
	[16320027] = {
		16320027,
		0,
		Lang.get(31917),
		16320,
		27,
		159,
		{
			RTResTalkAction[51],
			RTResTalkAction[9],
			RTResTalkAction[53]
		}
	},
	[16320028] = {
		16320028,
		0,
		Lang.get(26159),
		16320,
		28,
		158,
		{
			RTResTalkAction[41]
		},
		1,
		4,
		nil,
		nil,
		62,
		16323,
		nil,
		1,
		1,
		nil,
		16323
	},
	[16320029] = {
		16320029,
		5,
		Lang.get(31918),
		16320,
		29,
		158,
		nil,
		1,
		4
	},
	[16320030] = {
		16320030,
		0,
		Lang.get(31919),
		16320,
		30,
		41,
		{
			RTResTalkAction[15]
		},
		nil,
		nil,
		3
	},
	[16320031] = {
		16320031,
		0,
		Lang.get(31920),
		16320,
		31,
		576,
		{
			RTResTalkAction[17],
			RTResTalkAction[73]
		}
	},
	[16320032] = {
		16320032,
		0,
		Lang.get(26170),
		16320,
		32,
		576,
		{
			RTResTalkAction[14],
			RTResTalkAction[22]
		}
	},
	[16320033] = {
		16320033,
		0,
		Lang.get(31921),
		16320,
		33,
		55,
		{
			RTResTalkAction[21],
			RTResTalkAction[16]
		}
	},
	[16320034] = {
		16320034,
		0,
		Lang.get(31922),
		16320,
		34,
		55,
		{
			RTResTalkAction[21]
		}
	},
	[16320035] = {
		16320035,
		0,
		Lang.get(31923),
		16320,
		35,
		575,
		{
			RTResTalkAction[74],
			RTResTalkAction[25]
		}
	},
	[16320036] = {
		16320036,
		0,
		Lang.get(31924),
		16320,
		36,
		41,
		{
			RTResTalkAction[15],
			RTResTalkAction[23]
		}
	},
	[16320037] = {
		16320037,
		0,
		Lang.get(26172),
		16320,
		37,
		158,
		{
			RTResTalkAction[75],
			RTResTalkAction[22]
		}
	},
	[16320038] = {
		16320038,
		0,
		Lang.get(26173),
		16320,
		38,
		159,
		{
			RTResTalkAction[27],
			RTResTalkAction[9]
		}
	},
	[16320039] = {
		16320039,
		0,
		Lang.get(26174),
		16320,
		39,
		158,
		{
			RTResTalkAction[6],
			RTResTalkAction[41]
		}
	},
	[16320040] = {
		16320040,
		0,
		Lang.get(26175),
		16320,
		40,
		55,
		{
			RTResTalkAction[21],
			RTResTalkAction[9]
		}
	},
	[16320041] = {
		16320041,
		0,
		Lang.get(31925),
		16320,
		41,
		158,
		{
			RTResTalkAction[75],
			RTResTalkAction[25]
		}
	},
	[16330001] = {
		16330001,
		0,
		Lang.get(26177),
		16330,
		1,
		107,
		{
			RTResTalkAction[76]
		},
		nil,
		nil,
		3,
		nil,
		23,
		16330,
		1.5,
		nil,
		1,
		nil,
		16330
	},
	[16330002] = {
		16330002,
		5,
		Lang.get(26178),
		16330,
		2,
		134,
		{
			RTResTalkAction[77],
			RTResTalkAction[78]
		}
	},
	[16330003] = {
		16330003,
		0,
		Lang.get(26179),
		16330,
		3,
		119,
		{
			RTResTalkAction[79],
			RTResTalkAction[80]
		}
	},
	[16330004] = {
		16330004,
		5,
		Lang.get(26180),
		16330,
		4,
		134,
		{
			RTResTalkAction[81],
			RTResTalkAction[82]
		}
	},
	[16330005] = {
		16330005,
		0,
		Lang.get(26181),
		16330,
		5,
		133,
		{
			RTResTalkAction[83],
			RTResTalkAction[84],
			RTResTalkAction[85]
		}
	},
	[16330006] = {
		16330006,
		0,
		Lang.get(26182),
		16330,
		6,
		107,
		{
			RTResTalkAction[86],
			RTResTalkAction[87]
		}
	},
	[16330007] = {
		16330007,
		4,
		nil,
		16330,
		7,
		107,
		{
			RTResTalkAction[86],
			RTResTalkAction[88]
		},
		[27] = {
			{
				id = 16330008,
				branch_content = Lang.get(42546)
			}
		}
	},
	[16330008] = {
		16330008,
		0,
		Lang.get(26184),
		16330,
		8,
		107,
		{
			RTResTalkAction[89],
			RTResTalkAction[78]
		},
		1,
		6,
		-1,
		nil,
		nil,
		16338,
		nil,
		1,
		1,
		nil,
		16338
	},
	[16330009] = {
		16330009,
		5,
		Lang.get(26185),
		16330,
		9,
		119,
		nil,
		1,
		7
	},
	[16330010] = {
		16330010,
		0,
		Lang.get(26186),
		16330,
		10,
		141,
		nil,
		1,
		0
	},
	[16330011] = {
		16330011,
		0,
		Lang.get(26187),
		16330,
		11,
		107,
		nil,
		1,
		7
	},
	[16330012] = {
		16330012,
		4,
		nil,
		16330,
		12,
		107,
		nil,
		1,
		6,
		3,
		[27] = {
			{
				id = 16330013,
				branch_content = Lang.get(42547)
			},
			{
				id = 16330013,
				branch_content = Lang.get(42548)
			}
		}
	},
	[16330013] = {
		16330013,
		0,
		Lang.get(26189),
		16330,
		13,
		107,
		{
			RTResTalkAction[90]
		}
	},
	[16330014] = {
		16330014,
		0,
		Lang.get(26190),
		16330,
		14,
		134,
		{
			RTResTalkAction[78]
		},
		1,
		2,
		nil,
		nil,
		nil,
		nil,
		1,
		1,
		1,
		nil,
		16333
	},
	[16330015] = {
		16330015,
		0,
		Lang.get(26191),
		16330,
		15,
		133,
		nil,
		1,
		0
	},
	[16330016] = {
		16330016,
		0,
		Lang.get(26192),
		16330,
		16,
		107,
		nil,
		1,
		5
	},
	[16330017] = {
		16330017,
		0,
		Lang.get(31926),
		16330,
		17,
		119,
		nil,
		1,
		3
	},
	[16330018] = {
		16330018,
		0,
		Lang.get(26194),
		16330,
		18,
		107,
		nil,
		1,
		8
	},
	[16330019] = {
		16330019,
		0,
		Lang.get(31927),
		16330,
		19,
		119,
		nil,
		1,
		7
	},
	[16330020] = {
		16330020,
		0,
		Lang.get(26196),
		16330,
		20,
		107,
		nil,
		1,
		0
	},
	[16330021] = {
		16330021,
		0,
		Lang.get(26197),
		16330,
		21,
		559,
		nil,
		1
	},
	[16330022] = {
		16330022,
		0,
		Lang.get(26198),
		16330,
		22,
		107,
		nil,
		1
	},
	[16330023] = {
		16330023,
		0,
		Lang.get(26199),
		16330,
		23,
		133,
		nil,
		1
	},
	[16330024] = {
		16330024,
		0,
		Lang.get(31928),
		16330,
		24,
		559,
		nil,
		1
	},
	[16330025] = {
		16330025,
		0,
		Lang.get(26201),
		16330,
		25,
		107,
		nil,
		1,
		1
	},
	[16330026] = {
		16330026,
		0,
		Lang.get(31929),
		16330,
		26,
		133,
		nil,
		1,
		0
	},
	[16330027] = {
		16330027,
		0,
		Lang.get(31930),
		16330,
		27,
		119,
		nil,
		1,
		5
	},
	[16331001] = {
		16331001,
		3,
		Lang.get(26204),
		16331,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		23,
		16334,
		nil,
		nil,
		1,
		nil,
		16334,
		nil,
		nil,
		1
	},
	[16331002] = {
		16331002,
		5,
		Lang.get(26205),
		16331,
		2,
		107,
		{
			RTResTalkAction[91]
		},
		nil,
		nil,
		3
	},
	[16331003] = {
		16331003,
		0,
		Lang.get(26206),
		16331,
		3,
		119,
		{
			RTResTalkAction[92],
			RTResTalkAction[78]
		}
	},
	[16331004] = {
		16331004,
		0,
		Lang.get(26207),
		16331,
		4,
		134,
		{
			RTResTalkAction[93],
			RTResTalkAction[94]
		}
	},
	[16331005] = {
		16331005,
		5,
		Lang.get(26208),
		16331,
		5,
		119,
		{
			RTResTalkAction[85],
			RTResTalkAction[84]
		},
		1,
		7,
		nil,
		nil,
		nil,
		16335,
		nil,
		1,
		1,
		nil,
		16335
	},
	[16331006] = {
		16331006,
		0,
		Lang.get(26209),
		16331,
		6,
		134,
		nil,
		1,
		2
	},
	[16331007] = {
		16331007,
		0,
		Lang.get(26210),
		16331,
		7,
		107,
		nil,
		1
	},
	[16331008] = {
		16331008,
		0,
		Lang.get(26211),
		16331,
		8,
		133,
		nil,
		1
	},
	[16331009] = {
		16331009,
		4,
		nil,
		16331,
		9,
		133,
		nil,
		1,
		[27] = {
			{
				id = 16331010,
				branch_content = Lang.get(42549)
			}
		}
	},
	[16331010] = {
		16331010,
		0,
		Lang.get(31931),
		16331,
		10,
		134,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		16336,
		1,
		1,
		1,
		nil,
		16336
	},
	[16331011] = {
		16331011,
		0,
		Lang.get(31932),
		16331,
		11,
		119,
		nil,
		1,
		7,
		nil,
		nil,
		nil,
		16337
	},
	[16331012] = {
		16331012,
		0,
		Lang.get(26215),
		16331,
		12,
		204,
		nil,
		1,
		0
	},
	[16331013] = {
		16331013,
		0,
		Lang.get(31933),
		16331,
		13,
		107,
		{
			RTResTalkAction[95]
		},
		nil,
		nil,
		3
	},
	[16331014] = {
		16331014,
		0,
		Lang.get(31934),
		16331,
		14,
		300,
		{
			RTResTalkAction[78]
		},
		nil,
		nil,
		-1
	},
	[16331015] = {
		16331015,
		0,
		Lang.get(31935),
		16331,
		15,
		204,
		{
			RTResTalkAction[96]
		},
		nil,
		nil,
		3
	},
	[16331016] = {
		16331016,
		0,
		Lang.get(31936),
		16331,
		16,
		119,
		{
			RTResTalkAction[97],
			RTResTalkAction[98]
		}
	},
	[16331017] = {
		16331017,
		0,
		Lang.get(26220),
		16331,
		17,
		300,
		{
			RTResTalkAction[85]
		},
		nil,
		nil,
		-1
	},
	[16331018] = {
		16331018,
		0,
		Lang.get(21768),
		16331,
		18,
		141,
		{
			RTResTalkAction[99]
		},
		nil,
		nil,
		3
	},
	[16331019] = {
		16331019,
		0,
		Lang.get(31937),
		16331,
		19,
		134,
		{
			RTResTalkAction[100],
			RTResTalkAction[101]
		}
	},
	[16331020] = {
		16331020,
		0,
		Lang.get(31938),
		16331,
		20,
		133,
		{
			RTResTalkAction[79],
			RTResTalkAction[102]
		}
	},
	[16331021] = {
		16331021,
		0,
		Lang.get(26224),
		16331,
		21,
		204,
		{
			RTResTalkAction[96],
			RTResTalkAction[84],
			RTResTalkAction[89]
		}
	},
	[16331022] = {
		16331022,
		0,
		Lang.get(26225),
		16331,
		22,
		107,
		{
			RTResTalkAction[103],
			RTResTalkAction[98]
		}
	},
	[16340001] = {
		16340001,
		0,
		Lang.get(26226),
		16340,
		1,
		159,
		{
			RTResTalkAction[51]
		},
		nil,
		nil,
		3,
		nil,
		62,
		16344,
		1.5,
		1,
		1,
		nil,
		16344
	},
	[16340002] = {
		16340002,
		0,
		Lang.get(31939),
		16340,
		2,
		158,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[16340003] = {
		16340003,
		0,
		Lang.get(32950),
		16340,
		3,
		159,
		{
			RTResTalkAction[104],
			RTResTalkAction[11]
		}
	},
	[16340004] = {
		16340004,
		0,
		Lang.get(26229),
		16340,
		4,
		158,
		{
			RTResTalkAction[10],
			RTResTalkAction[105]
		}
	},
	[16340005] = {
		16340005,
		0,
		Lang.get(26230),
		16340,
		5,
		159,
		{
			RTResTalkAction[106],
			RTResTalkAction[11]
		}
	},
	[16340006] = {
		16340006,
		0,
		Lang.get(26231),
		16340,
		6,
		158,
		{
			RTResTalkAction[4],
			RTResTalkAction[41]
		}
	},
	[16340007] = {
		16340007,
		3,
		Lang.get(23446),
		16340,
		7,
		605,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		nil,
		nil,
		23,
		16340,
		nil,
		1,
		1,
		nil,
		16340,
		nil,
		nil,
		1
	},
	[16340008] = {
		16340008,
		0,
		Lang.get(26232),
		16340,
		8,
		107,
		{
			RTResTalkAction[95]
		},
		nil,
		nil,
		3
	},
	[16340009] = {
		16340009,
		0,
		Lang.get(31940),
		16340,
		9,
		300,
		{
			RTResTalkAction[76]
		}
	},
	[16340010] = {
		16340010,
		0,
		Lang.get(31941),
		16340,
		10,
		300,
		{
			RTResTalkAction[1],
			RTResTalkAction[78]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		16341,
		nil,
		1,
		1,
		nil,
		16341
	},
	[16340011] = {
		16340011,
		0,
		Lang.get(31942),
		16340,
		11,
		107,
		{
			RTResTalkAction[107],
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[16340012] = {
		16340012,
		0,
		"……",
		16340,
		12,
		158,
		{
			RTResTalkAction[108],
			RTResTalkAction[29]
		}
	},
	[16340013] = {
		16340013,
		0,
		Lang.get(26236),
		16340,
		13,
		158,
		{
			RTResTalkAction[108],
			RTResTalkAction[11]
		}
	},
	[16340014] = {
		16340014,
		0,
		Lang.get(26237),
		16340,
		14,
		300,
		{
			RTResTalkAction[108],
			RTResTalkAction[109]
		}
	},
	[16340015] = {
		16340015,
		0,
		Lang.get(31943),
		16340,
		15,
		158,
		{
			RTResTalkAction[110],
			RTResTalkAction[78]
		}
	},
	[16340016] = {
		16340016,
		0,
		Lang.get(31944),
		16340,
		16,
		204,
		{
			RTResTalkAction[111],
			RTResTalkAction[9]
		}
	},
	[16340017] = {
		16340017,
		0,
		Lang.get(31945),
		16340,
		17,
		300,
		{
			RTResTalkAction[96]
		}
	},
	[16340018] = {
		16340018,
		0,
		Lang.get(26241),
		16340,
		18,
		158,
		{
			RTResTalkAction[112],
			RTResTalkAction[98]
		}
	},
	[16340019] = {
		16340019,
		0,
		Lang.get(26242),
		16340,
		19,
		159,
		{
			RTResTalkAction[38],
			RTResTalkAction[37]
		}
	},
	[16340020] = {
		16340020,
		0,
		Lang.get(31946),
		16340,
		20,
		158,
		{
			RTResTalkAction[38],
			RTResTalkAction[37]
		}
	},
	[16340021] = {
		16340021,
		0,
		Lang.get(26243),
		16340,
		21,
		158,
		{
			RTResTalkAction[38],
			RTResTalkAction[37]
		}
	},
	[16340022] = {
		16340022,
		0,
		Lang.get(31947),
		16340,
		22,
		158,
		{
			RTResTalkAction[38],
			RTResTalkAction[37]
		}
	},
	[16340023] = {
		16340023,
		0,
		Lang.get(26245),
		16340,
		23,
		204,
		{
			RTResTalkAction[111],
			RTResTalkAction[9],
			RTResTalkAction[41]
		}
	},
	[16340024] = {
		16340024,
		0,
		Lang.get(31948),
		16340,
		24,
		159,
		{
			RTResTalkAction[51],
			RTResTalkAction[98]
		}
	},
	[16340025] = {
		16340025,
		0,
		Lang.get(31949),
		16340,
		25,
		107,
		{
			RTResTalkAction[113],
			RTResTalkAction[41]
		},
		nil,
		nil,
		3,
		nil,
		23,
		16342,
		nil,
		1,
		3,
		nil,
		16342
	},
	[16340026] = {
		16340026,
		0,
		Lang.get(31950),
		16340,
		26,
		158,
		{
			RTResTalkAction[4],
			RTResTalkAction[78]
		}
	},
	[16340027] = {
		16340027,
		0,
		Lang.get(31951),
		16340,
		27,
		158,
		{
			RTResTalkAction[114]
		}
	},
	[16340028] = {
		16340028,
		0,
		Lang.get(26250),
		16340,
		28,
		300,
		{
			RTResTalkAction[4]
		}
	},
	[16340029] = {
		16340029,
		0,
		Lang.get(26251),
		16340,
		29,
		158,
		{
			RTResTalkAction[110]
		}
	},
	[16340030] = {
		16340030,
		0,
		Lang.get(26252),
		16340,
		30,
		158,
		{
			RTResTalkAction[4]
		}
	},
	[16340031] = {
		16340031,
		0,
		Lang.get(31952),
		16340,
		31,
		300,
		{
			RTResTalkAction[4]
		}
	},
	[16340032] = {
		16340032,
		0,
		Lang.get(26255),
		16340,
		32,
		133,
		{
			RTResTalkAction[83],
			RTResTalkAction[9]
		}
	},
	[16340033] = {
		16340033,
		0,
		Lang.get(31953),
		16340,
		33,
		134,
		{
			RTResTalkAction[86],
			RTResTalkAction[115]
		}
	},
	[16340034] = {
		16340034,
		0,
		Lang.get(31954),
		16340,
		34,
		107,
		{
			RTResTalkAction[116],
			RTResTalkAction[89],
			RTResTalkAction[84]
		}
	},
	[16340035] = {
		16340035,
		0,
		Lang.get(31955),
		16340,
		35,
		158,
		{
			RTResTalkAction[110],
			RTResTalkAction[78]
		}
	},
	[16340036] = {
		16340036,
		4,
		nil,
		16340,
		36,
		158,
		{
			RTResTalkAction[4]
		},
		[27] = {
			{
				id = 16340037,
				branch_content = Lang.get(42550)
			}
		}
	},
	[16340037] = {
		16340037,
		0,
		Lang.get(31957),
		16340,
		37,
		158,
		{
			RTResTalkAction[4]
		}
	},
	[16340038] = {
		16340038,
		0,
		Lang.get(31958),
		16340,
		38,
		204,
		{
			RTResTalkAction[117],
			RTResTalkAction[9]
		}
	},
	[16340039] = {
		16340039,
		0,
		Lang.get(32951),
		16340,
		39,
		158,
		{
			RTResTalkAction[110],
			RTResTalkAction[98]
		}
	},
	[16340040] = {
		16340040,
		0,
		Lang.get(26264),
		16340,
		40,
		159,
		{
			RTResTalkAction[38],
			RTResTalkAction[37]
		}
	},
	[16340041] = {
		16340041,
		0,
		Lang.get(31960),
		16340,
		41,
		158,
		{
			RTResTalkAction[118],
			RTResTalkAction[37]
		}
	},
	[16340042] = {
		16340042,
		0,
		Lang.get(31961),
		16340,
		42,
		159,
		{
			RTResTalkAction[38],
			RTResTalkAction[119]
		}
	},
	[16340043] = {
		16340043,
		5,
		Lang.get(31962),
		16340,
		43,
		158,
		{
			RTResTalkAction[72],
			RTResTalkAction[37]
		}
	},
	[16340044] = {
		16340044,
		0,
		Lang.get(31963),
		16340,
		44,
		159,
		{
			RTResTalkAction[38],
			RTResTalkAction[120]
		}
	},
	[16340045] = {
		16340045,
		0,
		Lang.get(31964),
		16340,
		45,
		158,
		{
			RTResTalkAction[110],
			RTResTalkAction[41]
		}
	},
	[16340046] = {
		16340046,
		4,
		nil,
		16340,
		46,
		158,
		{
			RTResTalkAction[4]
		},
		[27] = {
			{
				id = 16340047,
				branch_content = Lang.get(26604)
			},
			{
				id = 16340047,
				branch_content = Lang.get(42551)
			}
		}
	},
	[16340047] = {
		16340047,
		0,
		Lang.get(26271),
		16340,
		47,
		134,
		{
			RTResTalkAction[121],
			RTResTalkAction[9]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		16343,
		1,
		1,
		1,
		nil,
		16343
	},
	[16340048] = {
		16340048,
		0,
		Lang.get(26272),
		16340,
		48,
		107,
		{
			RTResTalkAction[79],
			RTResTalkAction[88]
		}
	},
	[16340049] = {
		16340049,
		0,
		Lang.get(26273),
		16340,
		49,
		300,
		{
			RTResTalkAction[79],
			RTResTalkAction[88]
		}
	},
	[16340050] = {
		16340050,
		0,
		Lang.get(26274),
		16340,
		50,
		107,
		{
			RTResTalkAction[76],
			RTResTalkAction[84]
		}
	},
	[16350001] = {
		16350001,
		5,
		Lang.get(26275),
		16350,
		1,
		119,
		nil,
		1,
		7,
		nil,
		nil,
		62,
		16350,
		1.5,
		1,
		1,
		nil,
		16350
	},
	[16350002] = {
		16350002,
		0,
		Lang.get(26276),
		16350,
		2,
		107,
		nil,
		1,
		6
	},
	[16350003] = {
		16350003,
		0,
		Lang.get(26277),
		16350,
		3,
		134,
		nil,
		1,
		2
	},
	[16350004] = {
		16350004,
		0,
		Lang.get(26278),
		16350,
		4,
		107,
		nil,
		1,
		0
	},
	[16350005] = {
		16350005,
		0,
		Lang.get(19271),
		16350,
		5,
		141,
		nil,
		1,
		0
	},
	[16350006] = {
		16350006,
		0,
		Lang.get(26279),
		16350,
		6,
		133,
		nil,
		1,
		0
	},
	[16351001] = {
		16351001,
		0,
		Lang.get(26280),
		16351,
		1,
		119,
		nil,
		1,
		2,
		nil,
		nil,
		62,
		16351,
		1.2,
		1,
		1,
		nil,
		16351
	},
	[16351002] = {
		16351002,
		0,
		Lang.get(26281),
		16351,
		2,
		107,
		nil,
		1,
		0
	},
	[16351003] = {
		16351003,
		0,
		Lang.get(26282),
		16351,
		3,
		119,
		nil,
		1,
		0
	},
	[16351004] = {
		16351004,
		0,
		Lang.get(26283),
		16351,
		4,
		107,
		nil,
		1,
		0
	},
	[16351005] = {
		16351005,
		0,
		Lang.get(48558),
		16351,
		5,
		119,
		nil,
		1,
		1
	},
	[16351006] = {
		16351006,
		0,
		Lang.get(26285),
		16351,
		6,
		107,
		nil,
		1,
		0
	},
	[16351007] = {
		16351007,
		0,
		Lang.get(26286),
		16351,
		7,
		119,
		nil,
		1,
		0
	},
	[16352001] = {
		16352001,
		3,
		Lang.get(26287),
		16352,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		3,
		16352,
		2.5,
		1,
		1,
		nil,
		16352,
		nil,
		nil,
		1
	},
	[16352002] = {
		16352002,
		0,
		Lang.get(45997),
		16352,
		2,
		119,
		{
			RTResTalkAction[122]
		},
		nil,
		nil,
		3
	},
	[16352003] = {
		16352003,
		0,
		Lang.get(31968),
		16352,
		3,
		150,
		{
			RTResTalkAction[93],
			RTResTalkAction[123]
		}
	},
	[16352004] = {
		16352004,
		0,
		Lang.get(26290),
		16352,
		4,
		107,
		{
			RTResTalkAction[124],
			RTResTalkAction[85],
			RTResTalkAction[125]
		}
	},
	[16352005] = {
		16352005,
		0,
		Lang.get(26291),
		16352,
		5,
		150,
		{
			RTResTalkAction[126],
			RTResTalkAction[78]
		}
	},
	[16352006] = {
		16352006,
		3,
		Lang.get(31969),
		16352,
		6,
		605,
		{
			RTResTalkAction[125]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		16353,
		1,
		1,
		nil,
		nil,
		16353,
		nil,
		nil,
		1
	},
	[16352007] = {
		16352007,
		0,
		Lang.get(26292),
		16352,
		7,
		134,
		{
			RTResTalkAction[100]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		1
	},
	[16352008] = {
		16352008,
		0,
		Lang.get(26293),
		16352,
		8,
		39,
		{
			RTResTalkAction[79],
			RTResTalkAction[127]
		}
	},
	[16352009] = {
		16352009,
		0,
		Lang.get(26294),
		16352,
		9,
		133,
		{
			RTResTalkAction[83],
			RTResTalkAction[84],
			RTResTalkAction[128]
		}
	},
	[16352010] = {
		16352010,
		0,
		Lang.get(19271),
		16352,
		10,
		141,
		{
			RTResTalkAction[86],
			RTResTalkAction[129]
		}
	},
	[16352011] = {
		16352011,
		0,
		Lang.get(26295),
		16352,
		11,
		134,
		{
			RTResTalkAction[130],
			RTResTalkAction[89],
			RTResTalkAction[101]
		}
	},
	[16352012] = {
		16352012,
		0,
		Lang.get(26296),
		16352,
		12,
		39,
		{
			RTResTalkAction[79],
			RTResTalkAction[131]
		}
	},
	[16353001] = {
		16353001,
		3,
		Lang.get(26297),
		16353,
		1,
		nil,
		{
			RTResTalkAction[132]
		},
		nil,
		nil,
		nil,
		nil,
		3,
		16354,
		nil,
		nil,
		1,
		[18] = 16354,
		[21] = 1
	},
	[16353002] = {
		16353002,
		0,
		Lang.get(26298),
		16353,
		2,
		148,
		{
			RTResTalkAction[133],
			RTResTalkAction[134]
		},
		nil,
		nil,
		3
	},
	[16353003] = {
		16353003,
		0,
		Lang.get(26299),
		16353,
		3,
		119,
		{
			RTResTalkAction[135],
			RTResTalkAction[136]
		}
	},
	[16353004] = {
		16353004,
		3,
		Lang.get(26300),
		16353,
		4,
		[21] = 1,
		[7] = {
			RTResTalkAction[132],
			RTResTalkAction[137],
			RTResTalkAction[85]
		}
	},
	[16353005] = {
		16353005,
		0,
		Lang.get(26301),
		16353,
		5,
		148,
		{
			RTResTalkAction[138],
			RTResTalkAction[134]
		}
	},
	[16353006] = {
		16353006,
		0,
		Lang.get(26302),
		16353,
		6,
		133,
		{
			RTResTalkAction[83],
			RTResTalkAction[137]
		},
		nil,
		nil,
		3,
		nil,
		3,
		16355,
		1.5,
		1,
		1,
		nil,
		16355
	},
	[16353007] = {
		16353007,
		0,
		Lang.get(26303),
		16353,
		7,
		134,
		{
			RTResTalkAction[100],
			RTResTalkAction[89]
		}
	},
	[16353008] = {
		16353008,
		0,
		Lang.get(26304),
		16353,
		8,
		141,
		{
			RTResTalkAction[79],
			RTResTalkAction[129]
		}
	},
	[16353009] = {
		16353009,
		0,
		Lang.get(26305),
		16353,
		9,
		559,
		{
			RTResTalkAction[139],
			RTResTalkAction[84],
			RTResTalkAction[101]
		}
	},
	[16353010] = {
		16353010,
		0,
		Lang.get(26306),
		16353,
		10,
		560,
		{
			RTResTalkAction[140],
			RTResTalkAction[141]
		}
	},
	[16353011] = {
		16353011,
		0,
		Lang.get(26307),
		16353,
		11,
		141,
		{
			RTResTalkAction[142],
			RTResTalkAction[143],
			RTResTalkAction[144]
		}
	},
	[16353012] = {
		16353012,
		0,
		Lang.get(26308),
		16353,
		12,
		559,
		{
			RTResTalkAction[139],
			RTResTalkAction[101]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		16358,
		2.5,
		1,
		1
	},
	[16353013] = {
		16353013,
		0,
		Lang.get(26309),
		16353,
		13,
		143,
		{
			RTResTalkAction[145],
			RTResTalkAction[143]
		}
	},
	[16353014] = {
		16353014,
		0,
		Lang.get(26310),
		16353,
		14,
		134,
		{
			RTResTalkAction[100],
			RTResTalkAction[146]
		}
	},
	[16353015] = {
		16353015,
		0,
		Lang.get(26311),
		16353,
		15,
		207,
		{
			RTResTalkAction[147],
			RTResTalkAction[84]
		}
	},
	[16353016] = {
		16353016,
		0,
		Lang.get(26312),
		16353,
		16,
		123,
		{
			RTResTalkAction[148],
			RTResTalkAction[149]
		},
		nil,
		nil,
		3,
		nil,
		62,
		16357,
		1.2,
		1,
		1,
		nil,
		16357
	},
	[16353017] = {
		16353017,
		0,
		Lang.get(26313),
		16353,
		17,
		187,
		{
			RTResTalkAction[150],
			RTResTalkAction[151]
		}
	},
	[16353018] = {
		16353018,
		0,
		Lang.get(26314),
		16353,
		18,
		123,
		{
			RTResTalkAction[152],
			RTResTalkAction[153]
		}
	},
	[16353019] = {
		16353019,
		0,
		Lang.get(26315),
		16353,
		19,
		187,
		{
			RTResTalkAction[150],
			RTResTalkAction[151]
		}
	},
	[16353020] = {
		16353020,
		0,
		Lang.get(26316),
		16353,
		20,
		123,
		{
			RTResTalkAction[154],
			RTResTalkAction[153]
		}
	},
	[16353021] = {
		16353021,
		0,
		Lang.get(26317),
		16353,
		21,
		167,
		{
			RTResTalkAction[155],
			RTResTalkAction[151]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		16356,
		1.5,
		1,
		nil,
		nil,
		16356
	},
	[16353022] = {
		16353022,
		0,
		Lang.get(26318),
		16353,
		22,
		107,
		{
			RTResTalkAction[156],
			RTResTalkAction[157]
		}
	},
	[16353023] = {
		16353023,
		0,
		Lang.get(26319),
		16353,
		23,
		167,
		{
			RTResTalkAction[155],
			RTResTalkAction[78]
		}
	},
	[16353024] = {
		16353024,
		0,
		Lang.get(26320),
		16353,
		24,
		107,
		{
			RTResTalkAction[158],
			RTResTalkAction[157]
		}
	},
	[16353025] = {
		16353025,
		0,
		Lang.get(26321),
		16353,
		25,
		187,
		{
			RTResTalkAction[159],
			RTResTalkAction[78]
		}
	},
	[16353026] = {
		16353026,
		0,
		Lang.get(26322),
		16353,
		26,
		123,
		{
			RTResTalkAction[160],
			RTResTalkAction[161]
		}
	},
	[16353027] = {
		16353027,
		0,
		Lang.get(26323),
		16353,
		27,
		187,
		{
			RTResTalkAction[160],
			RTResTalkAction[161]
		}
	},
	[16353028] = {
		16353028,
		0,
		Lang.get(26324),
		16353,
		28,
		107,
		{
			RTResTalkAction[162],
			RTResTalkAction[153],
			RTResTalkAction[151]
		}
	},
	[16353029] = {
		16353029,
		0,
		Lang.get(26325),
		16353,
		29,
		167,
		{
			RTResTalkAction[155],
			RTResTalkAction[78]
		}
	},
	[16353030] = {
		16353030,
		0,
		Lang.get(26326),
		16353,
		30,
		123,
		{
			RTResTalkAction[163],
			RTResTalkAction[161],
			RTResTalkAction[157]
		}
	},
	[16353031] = {
		16353031,
		0,
		Lang.get(26327),
		16353,
		31,
		187,
		{
			RTResTalkAction[163],
			RTResTalkAction[161]
		}
	},
	[16353032] = {
		16353032,
		0,
		Lang.get(26328),
		16353,
		32,
		123,
		{
			RTResTalkAction[163],
			RTResTalkAction[161]
		}
	},
	[16353033] = {
		16353033,
		0,
		Lang.get(26329),
		16353,
		33,
		187,
		{
			RTResTalkAction[164],
			RTResTalkAction[161]
		}
	},
	[16353034] = {
		16353034,
		0,
		Lang.get(26330),
		16353,
		34,
		119,
		{
			RTResTalkAction[165],
			RTResTalkAction[153],
			RTResTalkAction[151]
		}
	},
	[16360001] = {
		16360001,
		0,
		Lang.get(26331),
		16360,
		1,
		140,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		16360,
		nil,
		1,
		1,
		nil,
		16360
	},
	[16360002] = {
		16360002,
		0,
		Lang.get(26332),
		16360,
		2,
		134,
		{
			RTResTalkAction[166]
		},
		nil,
		nil,
		3
	},
	[16360003] = {
		16360003,
		0,
		Lang.get(26333),
		16360,
		3,
		140,
		{
			RTResTalkAction[79],
			RTResTalkAction[167]
		}
	},
	[16360004] = {
		16360004,
		0,
		Lang.get(45480),
		16360,
		4,
		134,
		{
			RTResTalkAction[79],
			RTResTalkAction[167]
		}
	},
	[16360005] = {
		16360005,
		0,
		Lang.get(26335),
		16360,
		5,
		559,
		{
			RTResTalkAction[139],
			RTResTalkAction[84],
			RTResTalkAction[168]
		}
	},
	[16360006] = {
		16360006,
		0,
		Lang.get(26336),
		16360,
		6,
		167,
		{
			RTResTalkAction[155],
			RTResTalkAction[143]
		}
	},
	[16360007] = {
		16360007,
		0,
		Lang.get(26337),
		16360,
		7,
		149,
		{
			RTResTalkAction[169],
			RTResTalkAction[170]
		}
	},
	[16360008] = {
		16360008,
		0,
		Lang.get(26338),
		16360,
		8,
		140,
		{
			RTResTalkAction[171],
			RTResTalkAction[157],
			RTResTalkAction[172]
		}
	},
	[16360009] = {
		16360009,
		0,
		Lang.get(26339),
		16360,
		9,
		128,
		{
			RTResTalkAction[173],
			RTResTalkAction[174]
		}
	},
	[16360010] = {
		16360010,
		5,
		Lang.get(26340),
		16360,
		10,
		119,
		{
			RTResTalkAction[165],
			RTResTalkAction[168],
			RTResTalkAction[175]
		}
	},
	[16360011] = {
		16360011,
		0,
		Lang.get(26341),
		16360,
		11,
		107,
		{
			RTResTalkAction[176],
			RTResTalkAction[85]
		}
	},
	[16360012] = {
		16360012,
		0,
		Lang.get(45481),
		16360,
		12,
		107,
		{
			RTResTalkAction[116]
		}
	},
	[16360013] = {
		16360013,
		0,
		Lang.get(31971),
		16360,
		13,
		107,
		{
			RTResTalkAction[116]
		}
	},
	[16361001] = {
		16361001,
		0,
		Lang.get(26343),
		16361,
		1,
		179,
		{
			RTResTalkAction[177]
		},
		nil,
		nil,
		3,
		nil,
		62,
		16362,
		1.5,
		nil,
		1,
		nil,
		16362
	},
	[16361002] = {
		16361002,
		0,
		Lang.get(26344),
		16361,
		2,
		140,
		{
			RTResTalkAction[178],
			RTResTalkAction[167]
		}
	},
	[16361003] = {
		16361003,
		0,
		Lang.get(26345),
		16361,
		3,
		123,
		{
			RTResTalkAction[154],
			RTResTalkAction[179],
			RTResTalkAction[168]
		}
	},
	[16361004] = {
		16361004,
		0,
		Lang.get(26346),
		16361,
		4,
		140,
		{
			RTResTalkAction[171],
			RTResTalkAction[151]
		}
	},
	[16361005] = {
		16361005,
		0,
		Lang.get(26347),
		16361,
		5,
		179,
		{
			RTResTalkAction[173],
			RTResTalkAction[180]
		}
	},
	[16361006] = {
		16361006,
		0,
		Lang.get(26348),
		16361,
		6,
		150,
		{
			RTResTalkAction[181],
			RTResTalkAction[168],
			RTResTalkAction[179]
		}
	},
	[16361007] = {
		16361007,
		0,
		Lang.get(26349),
		16361,
		7,
		179,
		{
			RTResTalkAction[182],
			RTResTalkAction[183]
		}
	},
	[16361008] = {
		16361008,
		0,
		Lang.get(26350),
		16361,
		8,
		123,
		{
			RTResTalkAction[154],
			RTResTalkAction[125],
			RTResTalkAction[179]
		}
	},
	[16361009] = {
		16361009,
		0,
		Lang.get(26351),
		16361,
		9,
		149,
		{
			RTResTalkAction[184],
			RTResTalkAction[170]
		}
	},
	[16361010] = {
		16361010,
		0,
		Lang.get(26352),
		16361,
		10,
		133,
		{
			RTResTalkAction[185],
			RTResTalkAction[151],
			RTResTalkAction[172]
		}
	},
	[16361011] = {
		16361011,
		0,
		"……",
		16361,
		11,
		123,
		{
			RTResTalkAction[86],
			RTResTalkAction[161]
		}
	},
	[16361012] = {
		16361012,
		0,
		Lang.get(26353),
		16361,
		12,
		207,
		{
			RTResTalkAction[147],
			RTResTalkAction[89],
			RTResTalkAction[151]
		}
	},
	[16361013] = {
		16361013,
		0,
		Lang.get(26354),
		16361,
		13,
		133,
		{
			RTResTalkAction[186],
			RTResTalkAction[149]
		}
	},
	[16361014] = {
		16361014,
		0,
		"……",
		16361,
		14,
		123,
		{
			RTResTalkAction[154],
			RTResTalkAction[89]
		}
	},
	[16361015] = {
		16361015,
		0,
		Lang.get(26355),
		16361,
		15,
		187,
		{
			RTResTalkAction[159],
			RTResTalkAction[151]
		}
	},
	[16362001] = {
		16362001,
		5,
		Lang.get(26356),
		16362,
		1,
		559,
		nil,
		1,
		nil,
		nil,
		nil,
		32,
		nil,
		nil,
		nil,
		1,
		nil,
		16363
	},
	[16362002] = {
		16362002,
		0,
		Lang.get(26357),
		16362,
		2,
		560,
		nil,
		1
	},
	[16362003] = {
		16362003,
		0,
		Lang.get(26358),
		16362,
		3,
		119,
		nil,
		1,
		2
	},
	[16362004] = {
		16362004,
		0,
		Lang.get(26359),
		16362,
		4,
		107,
		nil,
		1,
		7
	},
	[16362005] = {
		16362005,
		0,
		Lang.get(26360),
		16362,
		5,
		207,
		nil,
		1,
		0
	},
	[16362006] = {
		16362006,
		0,
		Lang.get(26361),
		16362,
		6,
		179,
		nil,
		1,
		1
	},
	[16362007] = {
		16362007,
		0,
		Lang.get(26362),
		16362,
		7,
		149,
		nil,
		1,
		0
	},
	[16362008] = {
		16362008,
		0,
		Lang.get(26363),
		16362,
		8,
		141,
		nil,
		1,
		0
	},
	[16362009] = {
		16362009,
		0,
		Lang.get(26364),
		16362,
		9,
		133,
		nil,
		1,
		0
	},
	[16362010] = {
		16362010,
		0,
		Lang.get(26365),
		16362,
		10,
		187,
		{
			RTResTalkAction[187]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		16364,
		1.5,
		1,
		1,
		nil,
		16364
	},
	[16362011] = {
		16362011,
		0,
		Lang.get(26366),
		16362,
		11,
		123,
		{
			RTResTalkAction[163],
			RTResTalkAction[161]
		}
	},
	[16362012] = {
		16362012,
		0,
		Lang.get(26367),
		16362,
		12,
		207,
		{
			RTResTalkAction[147],
			RTResTalkAction[153],
			RTResTalkAction[151]
		}
	},
	[16362013] = {
		16362013,
		0,
		Lang.get(26368),
		16362,
		13,
		123,
		{
			RTResTalkAction[154],
			RTResTalkAction[149]
		}
	},
	[16362014] = {
		16362014,
		0,
		Lang.get(26369),
		16362,
		14,
		187,
		{
			RTResTalkAction[184],
			RTResTalkAction[188]
		}
	},
	[16362015] = {
		16362015,
		0,
		Lang.get(26370),
		16362,
		15,
		150,
		{
			RTResTalkAction[189],
			RTResTalkAction[151],
			RTResTalkAction[153]
		}
	},
	[16362016] = {
		16362016,
		0,
		Lang.get(26371),
		16362,
		16,
		119,
		{
			RTResTalkAction[190],
			RTResTalkAction[125]
		}
	},
	[16362017] = {
		16362017,
		0,
		Lang.get(26372),
		16362,
		17,
		187,
		{
			RTResTalkAction[150],
			RTResTalkAction[85]
		}
	},
	[16362018] = {
		16362018,
		0,
		Lang.get(26373),
		16362,
		18,
		167,
		{
			RTResTalkAction[155],
			RTResTalkAction[153]
		}
	},
	[16362019] = {
		16362019,
		0,
		Lang.get(26374),
		16362,
		19,
		179,
		{
			RTResTalkAction[191],
			RTResTalkAction[157]
		}
	},
	[16362020] = {
		16362020,
		0,
		Lang.get(26375),
		16362,
		20,
		149,
		{
			RTResTalkAction[178],
			RTResTalkAction[170]
		}
	},
	[16370001] = {
		16370001,
		0,
		Lang.get(26376),
		16370,
		1,
		119,
		nil,
		1,
		nil,
		nil,
		nil,
		48,
		16370,
		1,
		nil,
		1,
		nil,
		16370
	},
	[16370002] = {
		16370002,
		0,
		Lang.get(26377),
		16370,
		2,
		150,
		nil,
		1
	},
	[16370003] = {
		16370003,
		0,
		Lang.get(26378),
		16370,
		3,
		119,
		{
			RTResTalkAction[93],
			RTResTalkAction[192]
		},
		nil,
		nil,
		3
	},
	[16370004] = {
		16370004,
		0,
		Lang.get(31972),
		16370,
		4,
		150,
		{
			RTResTalkAction[93],
			RTResTalkAction[192]
		}
	},
	[16370005] = {
		16370005,
		0,
		Lang.get(26380),
		16370,
		5,
		119,
		{
			RTResTalkAction[193],
			RTResTalkAction[192]
		}
	},
	[16370006] = {
		16370006,
		0,
		Lang.get(31973),
		16370,
		6,
		107,
		{
			RTResTalkAction[176],
			RTResTalkAction[85],
			RTResTalkAction[125]
		}
	},
	[16370007] = {
		16370007,
		0,
		Lang.get(31974),
		16370,
		7,
		150,
		{
			RTResTalkAction[194],
			RTResTalkAction[78]
		}
	},
	[16370008] = {
		16370008,
		0,
		Lang.get(31975),
		16370,
		8,
		150,
		{
			RTResTalkAction[181]
		}
	},
	[16370009] = {
		16370009,
		0,
		Lang.get(31976),
		16370,
		9,
		150,
		{
			RTResTalkAction[126]
		}
	},
	[16370010] = {
		16370010,
		0,
		Lang.get(31977),
		16370,
		10,
		150,
		{
			RTResTalkAction[181]
		}
	},
	[16370011] = {
		16370011,
		0,
		Lang.get(26386),
		16370,
		11,
		119,
		{
			RTResTalkAction[190],
			RTResTalkAction[125]
		}
	},
	[16370012] = {
		16370012,
		0,
		Lang.get(26387),
		16370,
		12,
		107,
		{
			RTResTalkAction[124],
			RTResTalkAction[85]
		}
	},
	[16371001] = {
		16371001,
		0,
		Lang.get(26388),
		16371,
		1,
		207,
		nil,
		1,
		nil,
		nil,
		nil,
		48,
		16371,
		nil,
		1,
		1,
		nil,
		16371
	},
	[16371002] = {
		16371002,
		0,
		Lang.get(26389),
		16371,
		2,
		179,
		{
			RTResTalkAction[177]
		},
		nil,
		nil,
		3
	},
	[16371003] = {
		16371003,
		0,
		Lang.get(26390),
		16371,
		3,
		149,
		{
			RTResTalkAction[178],
			RTResTalkAction[170]
		}
	},
	[16371004] = {
		16371004,
		0,
		Lang.get(26391),
		16371,
		4,
		179,
		{
			RTResTalkAction[178],
			RTResTalkAction[170]
		}
	},
	[16371005] = {
		16371005,
		0,
		Lang.get(26392),
		16371,
		5,
		149,
		{
			RTResTalkAction[178],
			RTResTalkAction[170]
		}
	},
	[16371006] = {
		16371006,
		0,
		Lang.get(26393),
		16371,
		6,
		107,
		{
			RTResTalkAction[195],
			RTResTalkAction[179],
			RTResTalkAction[172]
		}
	},
	[16371007] = {
		16371007,
		5,
		Lang.get(26394),
		16371,
		7,
		150,
		{
			RTResTalkAction[196],
			RTResTalkAction[78]
		}
	},
	[16371008] = {
		16371008,
		0,
		Lang.get(26395),
		16371,
		8,
		123,
		{
			RTResTalkAction[148],
			RTResTalkAction[125]
		}
	},
	[16371009] = {
		16371009,
		0,
		Lang.get(26396),
		16371,
		9,
		150,
		{
			RTResTalkAction[181],
			RTResTalkAction[151]
		}
	},
	[16371010] = {
		16371010,
		0,
		Lang.get(26397),
		16371,
		10,
		150,
		{
			RTResTalkAction[181]
		}
	},
	[16371011] = {
		16371011,
		0,
		Lang.get(26398),
		16371,
		11,
		207,
		{
			RTResTalkAction[147],
			RTResTalkAction[125]
		}
	},
	[16371012] = {
		16371012,
		0,
		Lang.get(26399),
		16371,
		12,
		119,
		{
			RTResTalkAction[92],
			RTResTalkAction[149]
		}
	},
	[16371013] = {
		16371013,
		5,
		Lang.get(26400),
		16371,
		13,
		559,
		{
			RTResTalkAction[139],
			RTResTalkAction[85]
		}
	},
	[16371014] = {
		16371014,
		0,
		Lang.get(26401),
		16371,
		14,
		134,
		{
			RTResTalkAction[100],
			RTResTalkAction[143]
		}
	},
	[16371015] = {
		16371015,
		0,
		Lang.get(26402),
		16371,
		15,
		141,
		{
			RTResTalkAction[99],
			RTResTalkAction[84]
		}
	},
	[16372001] = {
		16372001,
		0,
		Lang.get(26403),
		16372,
		1,
		150,
		{
			RTResTalkAction[181]
		},
		nil,
		nil,
		3,
		nil,
		67,
		16372,
		1.5,
		1,
		1,
		nil,
		16372
	},
	[16372002] = {
		16372002,
		0,
		Lang.get(26404),
		16372,
		2,
		107,
		{
			RTResTalkAction[197],
			RTResTalkAction[125]
		}
	},
	[16372003] = {
		16372003,
		0,
		Lang.get(26405),
		16372,
		3,
		150,
		{
			RTResTalkAction[198],
			RTResTalkAction[78]
		}
	},
	[16372004] = {
		16372004,
		0,
		Lang.get(26406),
		16372,
		4,
		148,
		{
			RTResTalkAction[138],
			RTResTalkAction[125]
		}
	},
	[16372005] = {
		16372005,
		0,
		Lang.get(26407),
		16372,
		5,
		123,
		{
			RTResTalkAction[148],
			RTResTalkAction[137]
		}
	},
	[16372006] = {
		16372006,
		5,
		Lang.get(26408),
		16372,
		6,
		150,
		{
			RTResTalkAction[199],
			RTResTalkAction[151]
		}
	},
	[16380001] = {
		16380001,
		0,
		Lang.get(26410),
		16380,
		1,
		107,
		{
			RTResTalkAction[200]
		},
		nil,
		nil,
		3,
		nil,
		108,
		16380,
		2,
		1,
		1,
		nil,
		16380
	},
	[16380002] = {
		16380002,
		0,
		Lang.get(26411),
		16380,
		2,
		150,
		{
			RTResTalkAction[181],
			RTResTalkAction[78]
		}
	},
	[16380003] = {
		16380003,
		0,
		Lang.get(26412),
		16380,
		3,
		187,
		{
			RTResTalkAction[201],
			RTResTalkAction[125]
		}
	},
	[16380004] = {
		16380004,
		0,
		Lang.get(26413),
		16380,
		4,
		123,
		{
			RTResTalkAction[163],
			RTResTalkAction[161]
		}
	},
	[16380005] = {
		16380005,
		0,
		Lang.get(26414),
		16380,
		5,
		150,
		{
			RTResTalkAction[198],
			RTResTalkAction[153],
			RTResTalkAction[151]
		}
	},
	[16381001] = {
		16381001,
		3,
		Lang.get(26415),
		16381,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		108,
		16381,
		2,
		1,
		1,
		nil,
		16381,
		nil,
		nil,
		1
	},
	[16381002] = {
		16381002,
		0,
		Lang.get(26416),
		16381,
		2,
		148,
		{
			RTResTalkAction[138]
		},
		nil,
		nil,
		3
	},
	[16381003] = {
		16381003,
		0,
		Lang.get(26417),
		16381,
		3,
		150,
		{
			RTResTalkAction[181],
			RTResTalkAction[137]
		}
	},
	[16381004] = {
		16381004,
		0,
		Lang.get(26418),
		16381,
		4,
		107,
		{
			RTResTalkAction[90],
			RTResTalkAction[125]
		}
	},
	[16381005] = {
		16381005,
		0,
		Lang.get(26419),
		16381,
		5,
		123,
		{
			RTResTalkAction[148],
			RTResTalkAction[78]
		}
	},
	[16381006] = {
		16381006,
		0,
		Lang.get(26420),
		16381,
		6,
		187,
		{
			RTResTalkAction[184],
			RTResTalkAction[188]
		}
	},
	[16381007] = {
		16381007,
		0,
		Lang.get(26421),
		16381,
		7,
		123,
		{
			RTResTalkAction[202],
			RTResTalkAction[188]
		}
	},
	[16381008] = {
		16381008,
		0,
		Lang.get(26422),
		16381,
		8,
		107,
		{
			RTResTalkAction[203],
			RTResTalkAction[151],
			RTResTalkAction[153]
		}
	},
	[16381009] = {
		16381009,
		0,
		Lang.get(26423),
		16381,
		9,
		148,
		{
			RTResTalkAction[108],
			RTResTalkAction[204]
		}
	},
	[16382001] = {
		16382001,
		3,
		Lang.get(26424),
		16382,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		16382,
		1,
		nil,
		1,
		nil,
		16382,
		nil,
		nil,
		1
	},
	[16382002] = {
		16382002,
		0,
		Lang.get(26425),
		16382,
		2,
		148,
		{
			RTResTalkAction[138]
		},
		nil,
		nil,
		3
	},
	[16382003] = {
		16382003,
		0,
		Lang.get(26426),
		16382,
		3,
		559,
		{
			RTResTalkAction[139],
			RTResTalkAction[137]
		}
	},
	[16382004] = {
		16382004,
		5,
		Lang.get(26427),
		16382,
		4,
		150,
		{
			RTResTalkAction[205],
			RTResTalkAction[143]
		}
	},
	[16382005] = {
		16382005,
		0,
		Lang.get(26428),
		16382,
		5,
		107,
		{
			RTResTalkAction[206],
			RTResTalkAction[125]
		}
	},
	[16382006] = {
		16382006,
		5,
		Lang.get(26429),
		16382,
		6,
		150,
		{
			RTResTalkAction[181],
			RTResTalkAction[78]
		}
	},
	[16382007] = {
		16382007,
		0,
		Lang.get(26430),
		16382,
		7,
		123,
		{
			RTResTalkAction[152],
			RTResTalkAction[125]
		}
	},
	[16382008] = {
		16382008,
		0,
		Lang.get(26431),
		16382,
		8,
		148,
		{
			RTResTalkAction[138],
			RTResTalkAction[151]
		}
	},
	[16382009] = {
		16382009,
		5,
		Lang.get(26432),
		16382,
		9,
		150,
		{
			RTResTalkAction[207],
			RTResTalkAction[137]
		}
	},
	[16390001] = {
		16390001,
		0,
		Lang.get(26433),
		16390,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		16390,
		1,
		1,
		1,
		nil,
		16390
	},
	[16390002] = {
		16390002,
		0,
		Lang.get(26434),
		16390,
		2,
		576,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[16390003] = {
		16390003,
		0,
		Lang.get(26435),
		16390,
		3,
		158,
		{
			RTResTalkAction[4],
			RTResTalkAction[16]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		16391,
		1.5,
		1,
		1,
		nil,
		16391
	},
	[16390004] = {
		16390004,
		0,
		Lang.get(26436),
		16390,
		4,
		107,
		{
			RTResTalkAction[208],
			RTResTalkAction[9]
		}
	},
	[16390005] = {
		16390005,
		0,
		Lang.get(26437),
		16390,
		5,
		107,
		{
			RTResTalkAction[197]
		}
	},
	[16390006] = {
		16390006,
		0,
		Lang.get(26438),
		16390,
		6,
		158,
		{
			RTResTalkAction[4],
			RTResTalkAction[78]
		}
	},
	[16390007] = {
		16390007,
		0,
		Lang.get(26439),
		16390,
		7,
		158,
		{
			RTResTalkAction[9]
		},
		1,
		6,
		nil,
		nil,
		nil,
		16392,
		nil,
		2,
		1,
		nil,
		16392
	},
	[16390008] = {
		16390008,
		0,
		Lang.get(26440),
		16390,
		8,
		158,
		{
			RTResTalkAction[6]
		},
		nil,
		nil,
		3
	},
	[16390009] = {
		16390009,
		0,
		Lang.get(26441),
		16390,
		9,
		150,
		{
			RTResTalkAction[181],
			RTResTalkAction[9]
		}
	},
	[16390010] = {
		16390010,
		0,
		Lang.get(26442),
		16390,
		10,
		158,
		{
			RTResTalkAction[4],
			RTResTalkAction[125]
		}
	},
	[16390011] = {
		16390011,
		0,
		Lang.get(31978),
		16390,
		11,
		107,
		{
			RTResTalkAction[103],
			RTResTalkAction[9]
		}
	},
	[16390012] = {
		16390012,
		0,
		Lang.get(31979),
		16390,
		12,
		158,
		{
			RTResTalkAction[209],
			RTResTalkAction[78]
		}
	},
	[16391001] = {
		16391001,
		0,
		Lang.get(26449),
		16391,
		1,
		107,
		{
			RTResTalkAction[90]
		},
		nil,
		nil,
		3,
		nil,
		62,
		16393,
		1,
		1,
		1,
		nil,
		16393
	},
	[16391002] = {
		16391002,
		0,
		Lang.get(31980),
		16391,
		2,
		148,
		{
			RTResTalkAction[138],
			RTResTalkAction[78]
		}
	},
	[16391003] = {
		16391003,
		0,
		Lang.get(26451),
		16391,
		3,
		150,
		{
			RTResTalkAction[126],
			RTResTalkAction[137]
		}
	},
	[16391004] = {
		16391004,
		0,
		Lang.get(26452),
		16391,
		4,
		150,
		{
			RTResTalkAction[181]
		}
	},
	[16391005] = {
		16391005,
		0,
		Lang.get(26453),
		16391,
		5,
		187,
		{
			RTResTalkAction[159],
			RTResTalkAction[125]
		}
	},
	[16391006] = {
		16391006,
		0,
		Lang.get(26454),
		16391,
		6,
		576,
		{
			RTResTalkAction[26],
			RTResTalkAction[153]
		}
	},
	[16392001] = {
		16392001,
		0,
		Lang.get(26446),
		16392,
		1,
		123,
		{
			RTResTalkAction[154]
		},
		nil,
		nil,
		3,
		nil,
		62,
		16394,
		1,
		1,
		1,
		nil,
		16394
	},
	[16392002] = {
		16392002,
		0,
		Lang.get(26447),
		16392,
		2,
		107,
		{
			RTResTalkAction[210],
			RTResTalkAction[151]
		}
	},
	[16392003] = {
		16392003,
		0,
		Lang.get(26448),
		16392,
		3,
		158,
		{
			RTResTalkAction[211],
			RTResTalkAction[78]
		}
	},
	[16400001] = {
		16400001,
		0,
		Lang.get(26455),
		16400,
		1,
		500,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		16400,
		nil,
		nil,
		1,
		nil,
		16400
	},
	[16400002] = {
		16400002,
		0,
		Lang.get(26456),
		16400,
		2,
		123,
		{
			RTResTalkAction[154]
		},
		nil,
		nil,
		3
	},
	[16400003] = {
		16400003,
		0,
		Lang.get(26457),
		16400,
		3,
		187,
		{
			RTResTalkAction[184],
			RTResTalkAction[188]
		}
	},
	[16400004] = {
		16400004,
		0,
		Lang.get(26458),
		16400,
		4,
		500,
		{
			RTResTalkAction[212],
			RTResTalkAction[151],
			RTResTalkAction[153]
		}
	},
	[16400005] = {
		16400005,
		3,
		Lang.get(26459),
		16400,
		5,
		605,
		{
			RTResTalkAction[213]
		},
		[21] = 1
	},
	[16400006] = {
		16400006,
		0,
		Lang.get(26460),
		16400,
		6,
		107,
		{
			RTResTalkAction[214]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		16401,
		1,
		1,
		1,
		nil,
		16401
	},
	[16400007] = {
		16400007,
		0,
		Lang.get(26461),
		16400,
		7,
		148,
		{
			RTResTalkAction[108],
			RTResTalkAction[204]
		}
	},
	[16400008] = {
		16400008,
		0,
		Lang.get(26462),
		16400,
		8,
		107,
		{
			RTResTalkAction[215],
			RTResTalkAction[204]
		}
	},
	[16400009] = {
		16400009,
		0,
		Lang.get(26463),
		16400,
		9,
		107,
		{
			RTResTalkAction[108],
			RTResTalkAction[204]
		}
	},
	[16400010] = {
		16400010,
		0,
		Lang.get(26464),
		16400,
		10,
		150,
		{
			RTResTalkAction[216],
			RTResTalkAction[78],
			RTResTalkAction[137]
		}
	},
	[16401001] = {
		16401001,
		0,
		Lang.get(26465),
		16401,
		1,
		107,
		nil,
		1,
		8,
		nil,
		nil,
		62,
		16402,
		1,
		1,
		1,
		nil,
		16402
	},
	[16401002] = {
		16401002,
		0,
		Lang.get(26466),
		16401,
		2,
		500,
		{
			RTResTalkAction[217]
		},
		nil,
		nil,
		3
	},
	[16401003] = {
		16401003,
		0,
		Lang.get(26467),
		16401,
		3,
		148,
		{
			RTResTalkAction[138],
			RTResTalkAction[213]
		}
	},
	[16401004] = {
		16401004,
		0,
		Lang.get(26468),
		16401,
		4,
		500,
		{
			RTResTalkAction[218],
			RTResTalkAction[137]
		}
	},
	[16401005] = {
		16401005,
		0,
		Lang.get(26469),
		16401,
		5,
		150,
		{
			RTResTalkAction[219],
			RTResTalkAction[220]
		}
	},
	[16401006] = {
		16401006,
		0,
		Lang.get(26470),
		16401,
		6,
		500,
		{
			RTResTalkAction[221],
			RTResTalkAction[192]
		}
	},
	[16401007] = {
		16401007,
		0,
		Lang.get(26471),
		16401,
		7,
		150,
		{
			RTResTalkAction[222],
			RTResTalkAction[192]
		}
	},
	[16401008] = {
		16401008,
		0,
		Lang.get(26472),
		16401,
		8,
		500,
		{
			RTResTalkAction[217],
			RTResTalkAction[125]
		}
	},
	[16401009] = {
		16401009,
		0,
		Lang.get(26473),
		16401,
		9,
		148,
		{
			RTResTalkAction[138],
			RTResTalkAction[213]
		}
	},
	[16401010] = {
		16401010,
		0,
		Lang.get(26474),
		16401,
		10,
		500,
		{
			RTResTalkAction[223],
			RTResTalkAction[137]
		}
	},
	[16401011] = {
		16401011,
		0,
		Lang.get(26475),
		16401,
		11,
		150,
		{
			RTResTalkAction[219],
			RTResTalkAction[192]
		}
	},
	[16401012] = {
		16401012,
		0,
		Lang.get(26476),
		16401,
		12,
		500,
		{
			RTResTalkAction[219],
			RTResTalkAction[192]
		}
	},
	[16401013] = {
		16401013,
		0,
		Lang.get(26477),
		16401,
		13,
		107,
		{
			RTResTalkAction[214],
			RTResTalkAction[213],
			RTResTalkAction[125]
		}
	},
	[16401014] = {
		16401014,
		0,
		Lang.get(26478),
		16401,
		14,
		500,
		{
			RTResTalkAction[224],
			RTResTalkAction[78]
		}
	},
	[16401015] = {
		16401015,
		0,
		Lang.get(26479),
		16401,
		15,
		500,
		{
			RTResTalkAction[223]
		}
	},
	[16401016] = {
		16401016,
		0,
		Lang.get(26480),
		16401,
		16,
		107,
		{
			RTResTalkAction[91],
			RTResTalkAction[213]
		}
	},
	[16401017] = {
		16401017,
		0,
		Lang.get(26481),
		16401,
		17,
		123,
		{
			RTResTalkAction[154],
			RTResTalkAction[78]
		}
	},
	[16401018] = {
		16401018,
		0,
		Lang.get(26482),
		16401,
		18,
		150,
		{
			RTResTalkAction[181],
			RTResTalkAction[151]
		}
	},
	[16401019] = {
		16401019,
		0,
		Lang.get(26483),
		16401,
		19,
		500,
		{
			RTResTalkAction[223],
			RTResTalkAction[125]
		}
	},
	[16401020] = {
		16401020,
		0,
		Lang.get(26484),
		16401,
		20,
		150,
		{
			RTResTalkAction[219],
			RTResTalkAction[220]
		}
	},
	[16401021] = {
		16401021,
		0,
		Lang.get(26485),
		16401,
		21,
		107,
		{
			RTResTalkAction[225],
			RTResTalkAction[213],
			RTResTalkAction[125]
		}
	},
	[16401022] = {
		16401022,
		5,
		Lang.get(26486),
		16401,
		22,
		500,
		{
			RTResTalkAction[217],
			RTResTalkAction[78]
		}
	},
	[16401023] = {
		16401023,
		0,
		Lang.get(26487),
		16401,
		23,
		107,
		{
			RTResTalkAction[226],
			RTResTalkAction[213]
		}
	},
	[16401024] = {
		16401024,
		0,
		Lang.get(26488),
		16401,
		24,
		500,
		{
			RTResTalkAction[224],
			RTResTalkAction[78]
		}
	},
	[16401025] = {
		16401025,
		0,
		Lang.get(26489),
		16401,
		25,
		187,
		{
			RTResTalkAction[227],
			RTResTalkAction[213]
		},
		nil,
		nil,
		nil,
		nil,
		108
	},
	[16401026] = {
		16401026,
		0,
		Lang.get(26490),
		16401,
		26,
		500,
		{
			RTResTalkAction[217],
			RTResTalkAction[153]
		}
	},
	[16401027] = {
		16401027,
		5,
		Lang.get(26491),
		16401,
		27,
		500,
		{
			RTResTalkAction[223]
		}
	},
	[16401028] = {
		16401028,
		5,
		Lang.get(26492),
		16401,
		28,
		500,
		{
			RTResTalkAction[228]
		}
	},
	[16401029] = {
		16401029,
		0,
		Lang.get(26493),
		16401,
		29,
		123,
		{
			RTResTalkAction[229],
			RTResTalkAction[213]
		}
	},
	[16401030] = {
		16401030,
		0,
		Lang.get(26494),
		16401,
		30,
		148,
		{
			RTResTalkAction[138],
			RTResTalkAction[151]
		}
	},
	[16401031] = {
		16401031,
		5,
		Lang.get(26495),
		16401,
		31,
		107,
		{
			RTResTalkAction[230],
			RTResTalkAction[137]
		}
	},
	[16401032] = {
		16401032,
		0,
		Lang.get(31981),
		16401,
		32,
		150,
		{
			RTResTalkAction[93],
			RTResTalkAction[220],
			RTResTalkAction[78]
		}
	},
	[16401033] = {
		16401033,
		2,
		Lang.get(45998),
		16401,
		33,
		150,
		{
			RTResTalkAction[93],
			RTResTalkAction[123]
		}
	},
	[16401034] = {
		16401034,
		0,
		Lang.get(31983),
		16401,
		34,
		107,
		{
			RTResTalkAction[76],
			RTResTalkAction[85],
			RTResTalkAction[125]
		}
	},
	[16401035] = {
		16401035,
		0,
		Lang.get(26500),
		16401,
		35,
		500,
		{
			RTResTalkAction[224],
			RTResTalkAction[78]
		}
	},
	[16402001] = {
		16402001,
		0,
		Lang.get(26501),
		16402,
		1,
		150,
		nil,
		1,
		nil,
		nil,
		nil,
		108,
		16403,
		nil,
		1,
		1,
		nil,
		16403
	},
	[16402002] = {
		16402002,
		0,
		Lang.get(26492),
		16402,
		2,
		500,
		{
			RTResTalkAction[217]
		},
		nil,
		nil,
		3
	},
	[16402003] = {
		16402003,
		0,
		Lang.get(26489),
		16402,
		3,
		187,
		{
			RTResTalkAction[231],
			RTResTalkAction[213]
		}
	},
	[16402004] = {
		16402004,
		0,
		Lang.get(26490),
		16402,
		4,
		500,
		{
			RTResTalkAction[232],
			RTResTalkAction[153]
		}
	},
	[16402005] = {
		16402005,
		5,
		Lang.get(26491),
		16402,
		5,
		500,
		{
			RTResTalkAction[223]
		}
	},
	[16402006] = {
		16402006,
		5,
		Lang.get(26492),
		16402,
		6,
		500,
		{
			RTResTalkAction[228]
		}
	},
	[16402007] = {
		16402007,
		0,
		Lang.get(26502),
		16402,
		7,
		500,
		{
			RTResTalkAction[223]
		}
	},
	[16402008] = {
		16402008,
		2,
		Lang.get(31984),
		16402,
		8,
		150,
		{
			RTResTalkAction[207],
			RTResTalkAction[213]
		}
	},
	[16402009] = {
		16402009,
		0,
		Lang.get(26504),
		16402,
		9,
		123,
		{
			RTResTalkAction[154],
			RTResTalkAction[125]
		}
	},
	[16402010] = {
		16402010,
		0,
		Lang.get(26505),
		16402,
		10,
		107,
		{
			RTResTalkAction[233],
			RTResTalkAction[151]
		}
	},
	[16402011] = {
		16402011,
		0,
		Lang.get(26506),
		16402,
		11,
		148,
		{
			RTResTalkAction[138],
			RTResTalkAction[78]
		}
	},
	[16410001] = {
		16410001,
		3,
		Lang.get(26507),
		16410,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		32,
		16410,
		1,
		1,
		1,
		nil,
		16410,
		nil,
		nil,
		1
	},
	[16410002] = {
		16410002,
		0,
		Lang.get(26508),
		16410,
		2,
		107,
		{
			RTResTalkAction[214]
		},
		nil,
		nil,
		3
	},
	[16410003] = {
		16410003,
		4,
		nil,
		16410,
		3,
		107,
		{
			RTResTalkAction[76]
		},
		[27] = {
			{
				id = 16410004,
				branch_content = Lang.get(42552)
			},
			{
				id = 16410004,
				branch_content = Lang.get(42553)
			}
		}
	},
	[16410004] = {
		16410004,
		0,
		Lang.get(26510),
		16410,
		4,
		107,
		{
			RTResTalkAction[91]
		}
	},
	[16410005] = {
		16410005,
		4,
		nil,
		16410,
		5,
		107,
		{
			RTResTalkAction[76]
		},
		[27] = {
			{
				id = 16410006,
				branch_content = Lang.get(42554)
			},
			{
				id = 16410006,
				branch_content = Lang.get(42555)
			}
		}
	},
	[16410006] = {
		16410006,
		0,
		Lang.get(31985),
		16410,
		6,
		107,
		{
			RTResTalkAction[234]
		}
	},
	[16410007] = {
		16410007,
		0,
		Lang.get(31986),
		16410,
		7,
		134,
		{
			RTResTalkAction[235],
			RTResTalkAction[78]
		}
	},
	[16410008] = {
		16410008,
		0,
		Lang.get(31987),
		16410,
		8,
		133,
		{
			RTResTalkAction[83],
			RTResTalkAction[84]
		}
	},
	[16410009] = {
		16410009,
		0,
		Lang.get(31988),
		16410,
		9,
		107,
		{
			RTResTalkAction[214],
			RTResTalkAction[89]
		}
	},
	[16410010] = {
		16410010,
		0,
		Lang.get(31989),
		16410,
		10,
		107,
		{
			RTResTalkAction[236]
		}
	},
	[16410011] = {
		16410011,
		4,
		nil,
		16410,
		11,
		107,
		{
			RTResTalkAction[76]
		},
		[27] = {
			{
				id = 16410012,
				branch_content = Lang.get(42556)
			},
			{
				id = 16410012,
				branch_content = Lang.get(42557)
			}
		}
	},
	[16410012] = {
		16410012,
		0,
		Lang.get(26519),
		16410,
		12,
		107,
		{
			RTResTalkAction[214]
		}
	},
	[16410013] = {
		16410013,
		0,
		Lang.get(26520),
		16410,
		13,
		133,
		{
			RTResTalkAction[83],
			RTResTalkAction[78]
		}
	},
	[16410014] = {
		16410014,
		4,
		nil,
		16410,
		14,
		133,
		{
			RTResTalkAction[83]
		},
		[27] = {
			{
				id = 16410015,
				branch_content = Lang.get(42558)
			}
		}
	},
	[16410015] = {
		16410015,
		0,
		Lang.get(26522),
		16410,
		15,
		300,
		{
			RTResTalkAction[1],
			RTResTalkAction[89]
		}
	},
	[16411001] = {
		16411001,
		3,
		Lang.get(26523),
		16411,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		44,
		16411,
		1,
		nil,
		nil,
		nil,
		16411,
		nil,
		nil,
		1
	},
	[16411002] = {
		16411002,
		0,
		Lang.get(26524),
		16411,
		2,
		150,
		{
			RTResTalkAction[237]
		},
		nil,
		nil,
		3
	},
	[16411003] = {
		16411003,
		0,
		Lang.get(26525),
		16411,
		3,
		150,
		{
			RTResTalkAction[216]
		}
	},
	[16411004] = {
		16411004,
		0,
		Lang.get(26526),
		16411,
		4,
		150,
		{
			RTResTalkAction[199]
		}
	},
	[16411005] = {
		16411005,
		0,
		Lang.get(31225),
		16411,
		5,
		150,
		{
			RTResTalkAction[181]
		},
		nil,
		nil,
		3,
		nil,
		60,
		16412,
		1.5,
		1,
		1,
		nil,
		16412
	},
	[16411006] = {
		16411006,
		0,
		Lang.get(26528),
		16411,
		6,
		204,
		{
			RTResTalkAction[238],
			RTResTalkAction[239]
		}
	},
	[16411007] = {
		16411007,
		0,
		Lang.get(26529),
		16411,
		7,
		150,
		{
			RTResTalkAction[238],
			RTResTalkAction[239]
		}
	},
	[16411008] = {
		16411008,
		0,
		Lang.get(31226),
		16411,
		8,
		150,
		{
			RTResTalkAction[238],
			RTResTalkAction[239]
		}
	},
	[16411009] = {
		16411009,
		0,
		Lang.get(26531),
		16411,
		9,
		204,
		{
			RTResTalkAction[238],
			RTResTalkAction[240]
		}
	},
	[16411010] = {
		16411010,
		0,
		Lang.get(31227),
		16411,
		10,
		150,
		{
			RTResTalkAction[238],
			RTResTalkAction[239]
		}
	},
	[16412001] = {
		16412001,
		0,
		Lang.get(26533),
		16412,
		1,
		204,
		nil,
		1,
		4,
		nil,
		nil,
		60,
		16412,
		nil,
		1,
		1,
		nil,
		16412
	},
	[16412002] = {
		16412002,
		0,
		Lang.get(26534),
		16412,
		2,
		150,
		{
			RTResTalkAction[241],
			RTResTalkAction[239]
		},
		nil,
		nil,
		3
	},
	[16412003] = {
		16412003,
		0,
		Lang.get(26535),
		16412,
		3,
		150,
		{
			RTResTalkAction[238],
			RTResTalkAction[239]
		}
	},
	[16412004] = {
		16412004,
		0,
		Lang.get(26536),
		16412,
		4,
		150,
		{
			RTResTalkAction[238],
			RTResTalkAction[239]
		}
	},
	[16412005] = {
		16412005,
		0,
		Lang.get(26537),
		16412,
		5,
		204,
		{
			RTResTalkAction[238],
			RTResTalkAction[242]
		}
	},
	[16412006] = {
		16412006,
		0,
		Lang.get(32953),
		16412,
		6,
		150,
		{
			RTResTalkAction[243],
			RTResTalkAction[239]
		}
	},
	[16412007] = {
		16412007,
		0,
		Lang.get(26539),
		16412,
		7,
		150,
		{
			RTResTalkAction[238],
			RTResTalkAction[239]
		}
	},
	[16412008] = {
		16412008,
		0,
		Lang.get(26540),
		16412,
		8,
		150,
		{
			RTResTalkAction[238],
			RTResTalkAction[239]
		}
	},
	[16412009] = {
		16412009,
		0,
		Lang.get(26541),
		16412,
		9,
		150,
		{
			RTResTalkAction[238],
			RTResTalkAction[239]
		}
	},
	[16412010] = {
		16412010,
		0,
		Lang.get(26542),
		16412,
		10,
		204,
		{
			RTResTalkAction[238],
			RTResTalkAction[242]
		}
	},
	[16412011] = {
		16412011,
		0,
		Lang.get(56964),
		16412,
		11,
		150,
		{
			RTResTalkAction[238],
			RTResTalkAction[239]
		}
	},
	[16412012] = {
		16412012,
		0,
		Lang.get(26543),
		16412,
		12,
		204,
		{
			RTResTalkAction[238],
			RTResTalkAction[240]
		}
	},
	[16412013] = {
		16412013,
		2,
		Lang.get(26544),
		16412,
		13,
		150,
		{
			RTResTalkAction[182],
			RTResTalkAction[239]
		}
	},
	[16412014] = {
		16412014,
		2,
		Lang.get(26545),
		16412,
		14,
		150,
		{
			RTResTalkAction[238],
			RTResTalkAction[239]
		}
	},
	[16412015] = {
		16412015,
		0,
		Lang.get(26546),
		16412,
		15,
		204,
		{
			RTResTalkAction[238],
			RTResTalkAction[242]
		}
	},
	[16412016] = {
		16412016,
		0,
		Lang.get(20129),
		16412,
		16,
		150,
		{
			RTResTalkAction[244],
			RTResTalkAction[239]
		}
	},
	[16413001] = {
		16413001,
		0,
		Lang.get(26547),
		16413,
		1,
		187,
		{
			RTResTalkAction[150]
		},
		nil,
		nil,
		3,
		nil,
		60,
		16413,
		1,
		1,
		1,
		nil,
		16413
	},
	[16413002] = {
		16413002,
		0,
		Lang.get(26548),
		16413,
		2,
		107,
		{
			RTResTalkAction[107],
			RTResTalkAction[153]
		}
	},
	[16413003] = {
		16413003,
		0,
		Lang.get(26549),
		16413,
		3,
		148,
		{
			RTResTalkAction[108],
			RTResTalkAction[204]
		}
	},
	[16413004] = {
		16413004,
		0,
		Lang.get(26550),
		16413,
		4,
		123,
		{
			RTResTalkAction[154],
			RTResTalkAction[78],
			RTResTalkAction[137]
		}
	},
	[16413005] = {
		16413005,
		0,
		Lang.get(31992),
		16413,
		5,
		107,
		{
			RTResTalkAction[124],
			RTResTalkAction[151]
		}
	},
	[16413006] = {
		16413006,
		0,
		Lang.get(26552),
		16413,
		6,
		150,
		{
			RTResTalkAction[108],
			RTResTalkAction[192]
		}
	},
	[16413007] = {
		16413007,
		3,
		Lang.get(26553),
		16413,
		7,
		605,
		{
			RTResTalkAction[78],
			RTResTalkAction[125]
		},
		[21] = 1
	},
	[16420001] = {
		16420001,
		0,
		Lang.get(26554),
		16420,
		1,
		500,
		nil,
		1,
		1,
		nil,
		nil,
		108,
		16420,
		1,
		1,
		1,
		nil,
		16420
	},
	[16420002] = {
		16420002,
		5,
		Lang.get(26555),
		16420,
		2,
		500,
		{
			RTResTalkAction[245]
		},
		nil,
		nil,
		3
	},
	[16420003] = {
		16420003,
		5,
		Lang.get(26556),
		16420,
		3,
		500,
		{
			RTResTalkAction[246]
		}
	},
	[16420004] = {
		16420004,
		0,
		Lang.get(26557),
		16420,
		4,
		107,
		{
			RTResTalkAction[247],
			RTResTalkAction[213]
		}
	},
	[16420005] = {
		16420005,
		5,
		Lang.get(26558),
		16420,
		5,
		500,
		{
			RTResTalkAction[245],
			RTResTalkAction[78]
		}
	},
	[16420006] = {
		16420006,
		5,
		Lang.get(26492),
		16420,
		6,
		500,
		{
			RTResTalkAction[245]
		}
	},
	[16420007] = {
		16420007,
		3,
		Lang.get(26562),
		16420,
		7,
		605,
		{
			RTResTalkAction[213]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		16421,
		1,
		1,
		1,
		nil,
		16421,
		nil,
		nil,
		1
	},
	[16420008] = {
		16420008,
		0,
		Lang.get(26561),
		16420,
		8,
		150,
		{
			RTResTalkAction[181]
		}
	},
	[16420009] = {
		16420009,
		2,
		Lang.get(31993),
		16420,
		9,
		112,
		{
			RTResTalkAction[248],
			RTResTalkAction[125]
		},
		nil,
		nil,
		3
	},
	[16420010] = {
		16420010,
		0,
		Lang.get(31994),
		16420,
		10,
		150,
		{
			RTResTalkAction[181],
			RTResTalkAction[53]
		}
	},
	[16421001] = {
		16421001,
		0,
		Lang.get(26567),
		16421,
		1,
		158,
		{
			RTResTalkAction[110]
		},
		nil,
		nil,
		3,
		nil,
		62,
		16422,
		1.5,
		1,
		1,
		nil,
		16422
	},
	[16421002] = {
		16421002,
		0,
		Lang.get(31995),
		16421,
		2,
		158,
		{
			RTResTalkAction[112]
		}
	},
	[16421003] = {
		16421003,
		0,
		Lang.get(31996),
		16421,
		3,
		158,
		{
			RTResTalkAction[69]
		}
	},
	[16421004] = {
		16421004,
		0,
		Lang.get(31997),
		16421,
		4,
		500,
		{
			RTResTalkAction[38],
			RTResTalkAction[249]
		}
	},
	[16421005] = {
		16421005,
		0,
		Lang.get(26572),
		16421,
		5,
		158,
		{
			RTResTalkAction[250],
			RTResTalkAction[213]
		}
	},
	[16421006] = {
		16421006,
		5,
		Lang.get(26573),
		16421,
		6,
		107,
		{
			RTResTalkAction[90],
			RTResTalkAction[9]
		}
	},
	[16421007] = {
		16421007,
		0,
		Lang.get(26574),
		16421,
		7,
		150,
		{
			RTResTalkAction[108],
			RTResTalkAction[192]
		}
	},
	[16421008] = {
		16421008,
		0,
		Lang.get(26575),
		16421,
		8,
		158,
		{
			RTResTalkAction[209],
			RTResTalkAction[78],
			RTResTalkAction[125]
		}
	},
	[16421009] = {
		16421009,
		0,
		Lang.get(26576),
		16421,
		9,
		158,
		{
			RTResTalkAction[211]
		}
	},
	[16421010] = {
		16421010,
		0,
		Lang.get(26577),
		16421,
		10,
		500,
		{
			RTResTalkAction[245],
			RTResTalkAction[9]
		}
	},
	[16422001] = {
		16422001,
		0,
		Lang.get(26578),
		16422,
		1,
		500,
		{
			RTResTalkAction[245]
		},
		nil,
		nil,
		3,
		nil,
		62,
		16423,
		1,
		1,
		1,
		nil,
		16423
	},
	[16422002] = {
		16422002,
		0,
		Lang.get(26579),
		16422,
		2,
		150,
		{
			RTResTalkAction[181],
			RTResTalkAction[213]
		}
	},
	[16422003] = {
		16422003,
		0,
		Lang.get(26580),
		16422,
		3,
		148,
		{
			RTResTalkAction[138],
			RTResTalkAction[125]
		}
	},
	[16422004] = {
		16422004,
		0,
		Lang.get(26581),
		16422,
		4,
		107,
		{
			RTResTalkAction[234],
			RTResTalkAction[137]
		}
	},
	[16422005] = {
		16422005,
		0,
		Lang.get(26582),
		16422,
		5,
		158,
		{
			RTResTalkAction[4],
			RTResTalkAction[78]
		}
	},
	[16422006] = {
		16422006,
		0,
		Lang.get(26583),
		16422,
		6,
		123,
		{
			RTResTalkAction[154],
			RTResTalkAction[9]
		}
	},
	[16430001] = {
		16430001,
		3,
		Lang.get(26507),
		16430,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		16430,
		nil,
		1,
		1,
		nil,
		16430,
		nil,
		nil,
		1
	},
	[16430002] = {
		16430002,
		0,
		Lang.get(31998),
		16430,
		2,
		500,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		16431,
		nil,
		nil,
		1,
		nil,
		16431
	},
	[16430003] = {
		16430003,
		0,
		Lang.get(31228),
		16430,
		3,
		500,
		{
			RTResTalkAction[245]
		},
		nil,
		nil,
		3
	},
	[16430004] = {
		16430004,
		0,
		Lang.get(31999),
		16430,
		4,
		107,
		{
			RTResTalkAction[76],
			RTResTalkAction[213]
		}
	},
	[16430005] = {
		16430005,
		0,
		Lang.get(32000),
		16430,
		5,
		187,
		{
			RTResTalkAction[227],
			RTResTalkAction[78]
		}
	},
	[16430006] = {
		16430006,
		0,
		Lang.get(32001),
		16430,
		6,
		123,
		{
			RTResTalkAction[154],
			RTResTalkAction[153]
		}
	},
	[16430007] = {
		16430007,
		0,
		Lang.get(32002),
		16430,
		7,
		500,
		{
			RTResTalkAction[245],
			RTResTalkAction[151]
		}
	},
	[16430008] = {
		16430008,
		0,
		Lang.get(32003),
		16430,
		8,
		107,
		{
			RTResTalkAction[76],
			RTResTalkAction[213]
		}
	},
	[16430009] = {
		16430009,
		0,
		Lang.get(32004),
		16430,
		9,
		148,
		{
			RTResTalkAction[138],
			RTResTalkAction[78]
		}
	},
	[16430010] = {
		16430010,
		0,
		Lang.get(32005),
		16430,
		10,
		158,
		{
			RTResTalkAction[4],
			RTResTalkAction[137]
		}
	},
	[16430011] = {
		16430011,
		0,
		Lang.get(32006),
		16430,
		11,
		107,
		{
			RTResTalkAction[76],
			RTResTalkAction[9]
		}
	},
	[16431001] = {
		16431001,
		3,
		Lang.get(26589),
		16431,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		5,
		16432,
		nil,
		nil,
		1,
		nil,
		16432,
		nil,
		nil,
		1
	},
	[16431002] = {
		16431002,
		0,
		Lang.get(32007),
		16431,
		2,
		107,
		{
			RTResTalkAction[90]
		},
		nil,
		nil,
		3
	},
	[16431003] = {
		16431003,
		4,
		nil,
		16431,
		3,
		107,
		{
			RTResTalkAction[76]
		},
		[27] = {
			{
				id = 16431004,
				branch_content = Lang.get(42559)
			}
		}
	},
	[16431004] = {
		16431004,
		0,
		Lang.get(26598),
		16431,
		4,
		123,
		{
			RTResTalkAction[154],
			RTResTalkAction[78]
		}
	},
	[16431005] = {
		16431005,
		0,
		Lang.get(32009),
		16431,
		5,
		107,
		{
			RTResTalkAction[251],
			RTResTalkAction[151]
		}
	},
	[16431006] = {
		16431006,
		4,
		nil,
		16431,
		6,
		107,
		{
			RTResTalkAction[76]
		},
		[27] = {
			{
				id = 16431007,
				branch_content = Lang.get(20312)
			}
		}
	},
	[16431007] = {
		16431007,
		0,
		Lang.get(32011),
		16431,
		7,
		107,
		{
			RTResTalkAction[90]
		}
	},
	[16431008] = {
		16431008,
		4,
		nil,
		16431,
		8,
		107,
		{
			RTResTalkAction[76]
		},
		[27] = {
			{
				id = 16431009,
				branch_content = Lang.get(26604)
			}
		}
	},
	[16431009] = {
		16431009,
		0,
		Lang.get(32013),
		16431,
		9,
		107,
		{
			RTResTalkAction[78]
		},
		1,
		nil,
		-1,
		nil,
		nil,
		nil,
		nil,
		1,
		1,
		nil,
		16433
	},
	[16431010] = {
		16431010,
		0,
		Lang.get(32014),
		16431,
		10,
		119,
		nil,
		1
	},
	[16431011] = {
		16431011,
		0,
		Lang.get(32015),
		16431,
		11,
		150,
		nil,
		1
	},
	[16431012] = {
		16431012,
		5,
		Lang.get(26606),
		16431,
		12,
		559,
		nil,
		1
	},
	[16431013] = {
		16431013,
		0,
		Lang.get(26607),
		16431,
		13,
		107,
		nil,
		1
	},
	[16431014] = {
		16431014,
		0,
		Lang.get(26608),
		16431,
		14,
		134,
		nil,
		1,
		2
	},
	[16431015] = {
		16431015,
		0,
		Lang.get(26609),
		16431,
		15,
		141,
		nil,
		1,
		0
	},
	[16431016] = {
		16431016,
		0,
		Lang.get(26610),
		16431,
		16,
		107,
		nil,
		1,
		6
	},
	[16433001] = {
		16433001,
		3,
		Lang.get(26615),
		16433,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		16434,
		nil,
		nil,
		1,
		nil,
		16420,
		nil,
		nil,
		1
	},
	[16433002] = {
		16433002,
		0,
		Lang.get(26616),
		16433,
		2,
		500,
		{
			RTResTalkAction[245]
		},
		nil,
		nil,
		3
	},
	[16433003] = {
		16433003,
		5,
		Lang.get(26617),
		16433,
		3,
		107,
		{
			RTResTalkAction[103],
			RTResTalkAction[213]
		}
	},
	[16433004] = {
		16433004,
		0,
		Lang.get(26618),
		16433,
		4,
		158,
		{
			RTResTalkAction[108],
			RTResTalkAction[109]
		}
	},
	[16433005] = {
		16433005,
		0,
		Lang.get(26619),
		16433,
		5,
		148,
		{
			RTResTalkAction[252],
			RTResTalkAction[78],
			RTResTalkAction[9]
		}
	},
	[16433006] = {
		16433006,
		5,
		Lang.get(26620),
		16433,
		6,
		158,
		{
			RTResTalkAction[6],
			RTResTalkAction[137]
		}
	},
	[16433007] = {
		16433007,
		0,
		Lang.get(26621),
		16433,
		7,
		112,
		{
			RTResTalkAction[38],
			RTResTalkAction[54]
		}
	},
	[16433008] = {
		16433008,
		0,
		Lang.get(22701),
		16433,
		8,
		158,
		{
			RTResTalkAction[72],
			RTResTalkAction[55]
		}
	},
	[16433009] = {
		16433009,
		5,
		Lang.get(26622),
		16433,
		9,
		107,
		{
			RTResTalkAction[253],
			RTResTalkAction[9],
			RTResTalkAction[53]
		}
	},
	[16433010] = {
		16433010,
		0,
		Lang.get(26623),
		16433,
		10,
		107,
		{
			RTResTalkAction[214]
		}
	},
	[16434001] = {
		16434001,
		0,
		Lang.get(26624),
		16434,
		1,
		158,
		{
			RTResTalkAction[6]
		},
		nil,
		nil,
		3,
		nil,
		62,
		16435,
		1,
		1,
		nil,
		nil,
		16435
	},
	[16434002] = {
		16434002,
		0,
		Lang.get(26625),
		16434,
		2,
		112,
		{
			RTResTalkAction[38],
			RTResTalkAction[55]
		}
	},
	[16434003] = {
		16434003,
		0,
		Lang.get(26626),
		16434,
		3,
		148,
		{
			RTResTalkAction[138],
			RTResTalkAction[9],
			RTResTalkAction[53]
		}
	},
	[16434004] = {
		16434004,
		0,
		Lang.get(26627),
		16434,
		4,
		112,
		{
			RTResTalkAction[52],
			RTResTalkAction[137]
		}
	},
	[16434005] = {
		16434005,
		0,
		Lang.get(26628),
		16434,
		5,
		112,
		{
			RTResTalkAction[52]
		}
	},
	[16434006] = {
		16434006,
		0,
		Lang.get(26629),
		16434,
		6,
		112,
		{
			RTResTalkAction[52]
		}
	},
	[16434007] = {
		16434007,
		5,
		Lang.get(26630),
		16434,
		7,
		158,
		{
			RTResTalkAction[254],
			RTResTalkAction[53]
		}
	},
	[16434008] = {
		16434008,
		5,
		Lang.get(26631),
		16434,
		8,
		150,
		{
			RTResTalkAction[255],
			RTResTalkAction[9]
		}
	},
	[16434009] = {
		16434009,
		0,
		Lang.get(26632),
		16434,
		9,
		150,
		{
			RTResTalkAction[181]
		}
	},
	[16434010] = {
		16434010,
		0,
		Lang.get(26633),
		16434,
		10,
		150,
		{
			RTResTalkAction[181]
		}
	},
	[16434011] = {
		16434011,
		0,
		Lang.get(26634),
		16434,
		11,
		148,
		{
			RTResTalkAction[138],
			RTResTalkAction[125]
		}
	},
	[16434012] = {
		16434012,
		0,
		Lang.get(26635),
		16434,
		12,
		107,
		{
			RTResTalkAction[135],
			RTResTalkAction[88]
		}
	},
	[16434013] = {
		16434013,
		0,
		Lang.get(26636),
		16434,
		13,
		158,
		{
			RTResTalkAction[256],
			RTResTalkAction[137],
			RTResTalkAction[78]
		}
	},
	[16434014] = {
		16434014,
		0,
		Lang.get(26637),
		16434,
		14,
		150,
		{
			RTResTalkAction[181],
			RTResTalkAction[9]
		}
	},
	[16434015] = {
		16434015,
		0,
		Lang.get(26638),
		16434,
		15,
		158,
		{
			RTResTalkAction[4],
			RTResTalkAction[125]
		}
	},
	[16434016] = {
		16434016,
		0,
		Lang.get(26639),
		16434,
		16,
		112,
		{
			RTResTalkAction[38],
			RTResTalkAction[55]
		}
	},
	[16434017] = {
		16434017,
		0,
		Lang.get(26640),
		16434,
		17,
		158,
		{
			RTResTalkAction[257],
			RTResTalkAction[55]
		}
	},
	[16434018] = {
		16434018,
		0,
		Lang.get(26641),
		16434,
		18,
		112,
		{
			RTResTalkAction[38],
			RTResTalkAction[55]
		}
	},
	[16434019] = {
		16434019,
		0,
		Lang.get(26642),
		16434,
		19,
		112,
		{
			RTResTalkAction[38],
			RTResTalkAction[55]
		}
	},
	[16440001] = {
		16440001,
		3,
		Lang.get(26643),
		16440,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		16440,
		nil,
		nil,
		1,
		nil,
		16440,
		nil,
		nil,
		1
	},
	[16440002] = {
		16440002,
		3,
		Lang.get(26644),
		16440,
		2,
		605,
		[21] = 1
	},
	[16440003] = {
		16440003,
		0,
		Lang.get(26645),
		16440,
		3,
		158,
		nil,
		1,
		1
	},
	[16440004] = {
		16440004,
		0,
		Lang.get(26646),
		16440,
		4,
		158,
		nil,
		1,
		1
	},
	[16441001] = {
		16441001,
		0,
		Lang.get(24227),
		16441,
		1,
		181,
		{
			RTResTalkAction[258]
		},
		nil,
		nil,
		3,
		nil,
		127,
		16441,
		0.5,
		nil,
		1,
		nil,
		16441
	},
	[16441002] = {
		16441002,
		0,
		Lang.get(26647),
		16441,
		2,
		183,
		{
			RTResTalkAction[259],
			RTResTalkAction[260]
		}
	},
	[16441003] = {
		16441003,
		0,
		Lang.get(26648),
		16441,
		3,
		181,
		{
			RTResTalkAction[261],
			RTResTalkAction[260]
		}
	},
	[16441004] = {
		16441004,
		0,
		Lang.get(26649),
		16441,
		4,
		179,
		{
			RTResTalkAction[177],
			RTResTalkAction[262],
			RTResTalkAction[263]
		}
	},
	[16441005] = {
		16441005,
		0,
		Lang.get(26650),
		16441,
		5,
		149,
		{
			RTResTalkAction[178],
			RTResTalkAction[170]
		}
	},
	[16441006] = {
		16441006,
		0,
		Lang.get(26651),
		16441,
		6,
		179,
		{
			RTResTalkAction[178],
			RTResTalkAction[170]
		}
	},
	[16441007] = {
		16441007,
		5,
		Lang.get(26652),
		16441,
		7,
		579,
		{
			RTResTalkAction[264],
			RTResTalkAction[179],
			RTResTalkAction[172]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		16442,
		0.5,
		1,
		1,
		nil,
		16442
	},
	[16441008] = {
		16441008,
		5,
		Lang.get(26653),
		16441,
		8,
		581,
		{
			RTResTalkAction[265],
			RTResTalkAction[266]
		}
	},
	[16441009] = {
		16441009,
		0,
		Lang.get(26654),
		16441,
		9,
		302,
		{
			RTResTalkAction[267],
			RTResTalkAction[268]
		}
	},
	[16441010] = {
		16441010,
		0,
		"……",
		16441,
		10,
		579,
		{
			RTResTalkAction[269],
			RTResTalkAction[270]
		}
	},
	[16441011] = {
		16441011,
		0,
		Lang.get(26655),
		16441,
		11,
		196,
		{
			RTResTalkAction[271],
			RTResTalkAction[266]
		}
	},
	[16441012] = {
		16441012,
		0,
		Lang.get(26656),
		16441,
		12,
		194,
		{
			RTResTalkAction[272],
			RTResTalkAction[273]
		}
	},
	[16441013] = {
		16441013,
		0,
		Lang.get(26657),
		16441,
		13,
		196,
		{
			RTResTalkAction[272],
			RTResTalkAction[274]
		}
	},
	[16441014] = {
		16441014,
		0,
		Lang.get(26658),
		16441,
		14,
		194,
		{
			RTResTalkAction[272],
			RTResTalkAction[275]
		}
	},
	[16441015] = {
		16441015,
		5,
		Lang.get(26659),
		16441,
		15,
		579,
		{
			RTResTalkAction[276],
			RTResTalkAction[277],
			RTResTalkAction[278]
		}
	},
	[16441016] = {
		16441016,
		0,
		Lang.get(26660),
		16441,
		16,
		143,
		{
			RTResTalkAction[145],
			RTResTalkAction[266]
		}
	},
	[16441017] = {
		16441017,
		5,
		Lang.get(26661),
		16441,
		17,
		107,
		{
			RTResTalkAction[279],
			RTResTalkAction[146]
		}
	},
	[16441018] = {
		16441018,
		5,
		Lang.get(56963),
		16441,
		18,
		579,
		{
			RTResTalkAction[276],
			RTResTalkAction[78]
		}
	},
	[16441019] = {
		16441019,
		11,
		"Videos/AVG_miku_dance.mp4",
		16441,
		19,
		579,
		{
			RTResTalkAction[266]
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
	[16441020] = {
		16441020,
		5,
		Lang.get(26662),
		16441,
		20,
		581,
		{
			RTResTalkAction[280],
			RTResTalkAction[281]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		16443,
		0.5,
		nil,
		1,
		nil,
		16443
	},
	[16441021] = {
		16441021,
		5,
		Lang.get(26663),
		16441,
		21,
		107,
		{
			RTResTalkAction[103],
			RTResTalkAction[266],
			RTResTalkAction[268]
		}
	},
	[16441022] = {
		16441022,
		0,
		Lang.get(26664),
		16441,
		22,
		148,
		{
			RTResTalkAction[138],
			RTResTalkAction[78]
		}
	},
	[16441023] = {
		16441023,
		0,
		Lang.get(26665),
		16441,
		23,
		150,
		{
			RTResTalkAction[135],
			RTResTalkAction[192]
		}
	},
	[16441024] = {
		16441024,
		0,
		Lang.get(26666),
		16441,
		24,
		107,
		{
			RTResTalkAction[137],
			RTResTalkAction[125]
		},
		1,
		5,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		1,
		nil,
		16444
	},
	[16441025] = {
		16441025,
		0,
		Lang.get(26667),
		16441,
		25,
		107,
		nil,
		1,
		6
	},
	[16441026] = {
		16441026,
		0,
		Lang.get(26668),
		16441,
		26,
		187,
		nil,
		1,
		0
	},
	[16441027] = {
		16441027,
		0,
		Lang.get(26669),
		16441,
		27,
		123,
		nil,
		1,
		1
	},
	[16441028] = {
		16441028,
		0,
		Lang.get(26670),
		16441,
		28,
		158,
		nil,
		1,
		4
	},
	[16441029] = {
		16441029,
		0,
		Lang.get(26671),
		16441,
		29,
		148,
		nil,
		1,
		0
	},
	[16441030] = {
		16441030,
		0,
		Lang.get(26672),
		16441,
		30,
		187,
		nil,
		1
	},
	[16441031] = {
		16441031,
		0,
		Lang.get(26673),
		16441,
		31,
		123,
		nil,
		1
	},
	[16441032] = {
		16441032,
		0,
		Lang.get(26674),
		16441,
		32,
		579,
		nil,
		1
	},
	[16441033] = {
		16441033,
		0,
		Lang.get(26675),
		16441,
		33,
		581,
		nil,
		1
	},
	[16441034] = {
		16441034,
		0,
		Lang.get(26676),
		16441,
		34,
		187,
		nil,
		1
	},
	[16441035] = {
		16441035,
		0,
		Lang.get(26677),
		16441,
		35,
		123,
		nil,
		1
	},
	[16441036] = {
		16441036,
		0,
		Lang.get(26678),
		16441,
		36,
		158,
		nil,
		1,
		1
	},
	[16441037] = {
		16441037,
		0,
		Lang.get(26679),
		16441,
		37,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[16443001] = {
		16443001,
		5,
		Lang.get(32016),
		16443,
		1,
		158,
		nil,
		1,
		5,
		nil,
		nil,
		127,
		16445,
		1,
		nil,
		1,
		nil,
		16445
	},
	[16443002] = {
		16443002,
		0,
		Lang.get(32017),
		16443,
		2,
		158,
		{
			RTResTalkAction[110]
		},
		nil,
		nil,
		3
	},
	[16443003] = {
		16443003,
		0,
		Lang.get(32018),
		16443,
		3,
		158,
		{
			RTResTalkAction[282]
		}
	},
	[16443004] = {
		16443004,
		3,
		Lang.get(26683),
		16443,
		4,
		158,
		{
			RTResTalkAction[132],
			RTResTalkAction[9]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[21] = 1
	},
	[16450001] = {
		16450001,
		0,
		Lang.get(26684),
		16450,
		1,
		107,
		{
			RTResTalkAction[283]
		},
		nil,
		nil,
		3,
		nil,
		48,
		16452,
		1.2,
		nil,
		1,
		nil,
		16452
	},
	[16450002] = {
		16450002,
		0,
		Lang.get(22391),
		16450,
		2,
		141,
		{
			RTResTalkAction[284],
			RTResTalkAction[78]
		}
	},
	[16450003] = {
		16450003,
		0,
		Lang.get(36137),
		16450,
		3,
		119,
		{
			RTResTalkAction[92],
			RTResTalkAction[101]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		16450,
		0.5,
		1,
		1,
		nil,
		16450
	},
	[16450004] = {
		16450004,
		0,
		Lang.get(26686),
		16450,
		4,
		133,
		{
			RTResTalkAction[93],
			RTResTalkAction[102]
		}
	},
	[16450005] = {
		16450005,
		0,
		Lang.get(26687),
		16450,
		5,
		150,
		{
			RTResTalkAction[181],
			RTResTalkAction[85],
			RTResTalkAction[89]
		}
	},
	[16450006] = {
		16450006,
		2,
		Lang.get(36138),
		16450,
		6,
		150,
		{
			RTResTalkAction[181]
		}
	},
	[16450007] = {
		16450007,
		0,
		Lang.get(36139),
		16450,
		7,
		133,
		{
			RTResTalkAction[83],
			RTResTalkAction[125]
		}
	},
	[16450008] = {
		16450008,
		0,
		Lang.get(26690),
		16450,
		8,
		149,
		{
			RTResTalkAction[285],
			RTResTalkAction[89]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		16451,
		0.5,
		1,
		1,
		nil,
		16451
	},
	[16450009] = {
		16450009,
		0,
		Lang.get(26691),
		16450,
		9,
		179,
		{
			RTResTalkAction[286],
			RTResTalkAction[180]
		}
	},
	[16450010] = {
		16450010,
		0,
		Lang.get(26692),
		16450,
		10,
		55,
		{
			RTResTalkAction[24],
			RTResTalkAction[172],
			RTResTalkAction[179]
		}
	},
	[16450011] = {
		16450011,
		0,
		Lang.get(26693),
		16450,
		11,
		55,
		{
			RTResTalkAction[21]
		}
	},
	[16450012] = {
		16450012,
		0,
		Lang.get(26694),
		16450,
		12,
		55,
		{
			RTResTalkAction[287]
		}
	},
	[16450013] = {
		16450013,
		0,
		Lang.get(26695),
		16450,
		13,
		179,
		{
			RTResTalkAction[177],
			RTResTalkAction[25]
		}
	},
	[16450014] = {
		16450014,
		0,
		Lang.get(36140),
		16450,
		14,
		179,
		{
			RTResTalkAction[177]
		}
	},
	[16450015] = {
		16450015,
		0,
		Lang.get(26696),
		16450,
		15,
		211,
		{
			RTResTalkAction[288],
			RTResTalkAction[179]
		}
	},
	[16450016] = {
		16450016,
		0,
		"……",
		16450,
		16,
		150,
		{
			RTResTalkAction[181],
			RTResTalkAction[289]
		}
	},
	[16450017] = {
		16450017,
		0,
		Lang.get(26697),
		16450,
		17,
		133,
		{
			RTResTalkAction[238],
			RTResTalkAction[102]
		}
	},
	[16450018] = {
		16450018,
		0,
		Lang.get(31231),
		16450,
		18,
		579,
		{
			RTResTalkAction[269],
			RTResTalkAction[125],
			RTResTalkAction[89]
		}
	},
	[16450019] = {
		16450019,
		0,
		Lang.get(26699),
		16450,
		19,
		55,
		{
			RTResTalkAction[287],
			RTResTalkAction[266]
		}
	},
	[16450020] = {
		16450020,
		0,
		Lang.get(26695),
		16450,
		20,
		179,
		{
			RTResTalkAction[177],
			RTResTalkAction[25]
		}
	},
	[16450021] = {
		16450021,
		0,
		Lang.get(36140),
		16450,
		21,
		179,
		{
			RTResTalkAction[177]
		}
	},
	[16450022] = {
		16450022,
		0,
		Lang.get(26700),
		16450,
		22,
		107,
		{
			RTResTalkAction[178],
			RTResTalkAction[88]
		}
	},
	[16450023] = {
		16450023,
		0,
		Lang.get(26696),
		16450,
		23,
		211,
		{
			RTResTalkAction[288],
			RTResTalkAction[179],
			RTResTalkAction[78]
		}
	},
	[16450024] = {
		16450024,
		0,
		Lang.get(26701),
		16450,
		24,
		55,
		{
			RTResTalkAction[287],
			RTResTalkAction[289]
		}
	},
	[16450025] = {
		16450025,
		0,
		Lang.get(26695),
		16450,
		25,
		179,
		{
			RTResTalkAction[177],
			RTResTalkAction[25]
		}
	},
	[16450026] = {
		16450026,
		0,
		Lang.get(26702),
		16450,
		26,
		119,
		{
			RTResTalkAction[178],
			RTResTalkAction[82]
		}
	},
	[16450027] = {
		16450027,
		0,
		Lang.get(36140),
		16450,
		27,
		179,
		{
			RTResTalkAction[177],
			RTResTalkAction[85]
		}
	},
	[16450028] = {
		16450028,
		0,
		Lang.get(26696),
		16450,
		28,
		211,
		{
			RTResTalkAction[288],
			RTResTalkAction[179]
		}
	},
	[16450029] = {
		16450029,
		0,
		"……",
		16450,
		29,
		119,
		{
			RTResTalkAction[290],
			RTResTalkAction[289]
		}
	},
	[16450030] = {
		16450030,
		0,
		Lang.get(26703),
		16450,
		30,
		55,
		{
			RTResTalkAction[287],
			RTResTalkAction[85]
		}
	},
	[16450031] = {
		16450031,
		0,
		Lang.get(26704),
		16450,
		31,
		179,
		{
			RTResTalkAction[177],
			RTResTalkAction[25]
		}
	},
	[16450032] = {
		16450032,
		0,
		Lang.get(26695),
		16450,
		32,
		134,
		{
			RTResTalkAction[291],
			RTResTalkAction[179]
		}
	},
	[16450033] = {
		16450033,
		5,
		Lang.get(26705),
		16450,
		33,
		134,
		{
			RTResTalkAction[100]
		}
	},
	[16450034] = {
		16450034,
		5,
		Lang.get(26706),
		16450,
		34,
		559,
		{
			RTResTalkAction[79],
			RTResTalkAction[292]
		}
	},
	[16450035] = {
		16450035,
		0,
		Lang.get(26707),
		16450,
		35,
		55,
		{
			RTResTalkAction[287],
			RTResTalkAction[84],
			RTResTalkAction[143]
		}
	},
	[16450036] = {
		16450036,
		0,
		Lang.get(26708),
		16450,
		36,
		134,
		{
			RTResTalkAction[235],
			RTResTalkAction[25]
		}
	},
	[16450037] = {
		16450037,
		0,
		Lang.get(26709),
		16450,
		37,
		179,
		{
			RTResTalkAction[191],
			RTResTalkAction[84]
		}
	},
	[16450038] = {
		16450038,
		0,
		Lang.get(26710),
		16450,
		38,
		211,
		{
			RTResTalkAction[293],
			RTResTalkAction[179]
		}
	},
	[16451001] = {
		16451001,
		0,
		Lang.get(26711),
		16451,
		1,
		159,
		{
			RTResTalkAction[51]
		},
		nil,
		nil,
		3,
		nil,
		48,
		16453,
		0.5,
		nil,
		1,
		nil,
		16453
	},
	[16451002] = {
		16451002,
		0,
		Lang.get(36141),
		16451,
		2,
		55,
		{
			RTResTalkAction[10],
			RTResTalkAction[45]
		}
	},
	[16451003] = {
		16451003,
		0,
		Lang.get(26713),
		16451,
		3,
		159,
		{
			RTResTalkAction[10],
			RTResTalkAction[45]
		}
	},
	[16451004] = {
		16451004,
		0,
		Lang.get(36142),
		16451,
		4,
		150,
		{
			RTResTalkAction[181],
			RTResTalkAction[41],
			RTResTalkAction[25]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		16450,
		0.5,
		1,
		1,
		nil,
		16450
	},
	[16451005] = {
		16451005,
		0,
		Lang.get(26715),
		16451,
		5,
		159,
		{
			RTResTalkAction[46],
			RTResTalkAction[125]
		}
	},
	[16451006] = {
		16451006,
		0,
		Lang.get(26695),
		16451,
		6,
		150,
		{
			RTResTalkAction[198],
			RTResTalkAction[41]
		}
	},
	[16451007] = {
		16451007,
		0,
		Lang.get(26727),
		16451,
		7,
		150,
		{
			RTResTalkAction[181]
		}
	},
	[16451008] = {
		16451008,
		0,
		Lang.get(26717),
		16451,
		8,
		206,
		{
			RTResTalkAction[294],
			RTResTalkAction[125]
		}
	},
	[16451009] = {
		16451009,
		0,
		Lang.get(19725),
		16451,
		9,
		159,
		{
			RTResTalkAction[295],
			RTResTalkAction[119]
		}
	},
	[16451010] = {
		16451010,
		0,
		Lang.get(26718),
		16451,
		10,
		211,
		{
			RTResTalkAction[288],
			RTResTalkAction[296],
			RTResTalkAction[41]
		}
	},
	[16451011] = {
		16451011,
		0,
		Lang.get(26719),
		16451,
		11,
		159,
		{
			RTResTalkAction[46],
			RTResTalkAction[289]
		}
	},
	[16451012] = {
		16451012,
		5,
		Lang.get(36143),
		16451,
		12,
		119,
		{
			RTResTalkAction[297],
			RTResTalkAction[41]
		}
	},
	[16451013] = {
		16451013,
		0,
		Lang.get(26721),
		16451,
		13,
		150,
		{
			RTResTalkAction[93],
			RTResTalkAction[192]
		}
	},
	[16451014] = {
		16451014,
		5,
		Lang.get(36144),
		16451,
		14,
		150,
		{
			RTResTalkAction[93],
			RTResTalkAction[298]
		}
	},
	[16451015] = {
		16451015,
		0,
		Lang.get(36145),
		16451,
		15,
		119,
		{
			RTResTalkAction[193],
			RTResTalkAction[192]
		}
	},
	[16451016] = {
		16451016,
		0,
		Lang.get(36146),
		16451,
		16,
		55,
		{
			RTResTalkAction[21],
			RTResTalkAction[85],
			RTResTalkAction[125]
		}
	},
	[16451017] = {
		16451017,
		0,
		Lang.get(26725),
		16451,
		17,
		55,
		{
			RTResTalkAction[21]
		}
	},
	[16451018] = {
		16451018,
		0,
		Lang.get(26726),
		16451,
		18,
		159,
		{
			RTResTalkAction[51],
			RTResTalkAction[25]
		}
	},
	[16451019] = {
		16451019,
		5,
		Lang.get(26727),
		16451,
		19,
		119,
		{
			RTResTalkAction[299],
			RTResTalkAction[41]
		}
	},
	[16451020] = {
		16451020,
		5,
		Lang.get(26727),
		16451,
		20,
		150,
		{
			RTResTalkAction[198],
			RTResTalkAction[85]
		}
	},
	[16451021] = {
		16451021,
		5,
		Lang.get(26727),
		16451,
		21,
		134,
		{
			RTResTalkAction[300],
			RTResTalkAction[125]
		}
	},
	[16451022] = {
		16451022,
		0,
		Lang.get(26727),
		16451,
		22,
		123,
		{
			RTResTalkAction[148],
			RTResTalkAction[84]
		}
	},
	[16451023] = {
		16451023,
		0,
		Lang.get(26718),
		16451,
		23,
		211,
		{
			RTResTalkAction[288],
			RTResTalkAction[151]
		}
	},
	[16451024] = {
		16451024,
		5,
		Lang.get(26728),
		16451,
		24,
		158,
		{
			RTResTalkAction[67],
			RTResTalkAction[289]
		}
	},
	[16452001] = {
		16452001,
		0,
		Lang.get(26729),
		16452,
		1,
		55,
		{
			RTResTalkAction[287]
		},
		nil,
		nil,
		3,
		nil,
		48,
		16452,
		1,
		nil,
		1,
		nil,
		16452
	},
	[16452002] = {
		16452002,
		2,
		Lang.get(26730),
		16452,
		2,
		55,
		{
			RTResTalkAction[301]
		}
	},
	[16460001] = {
		16460001,
		0,
		Lang.get(36147),
		16460,
		1,
		55,
		{
			RTResTalkAction[287]
		},
		nil,
		nil,
		3,
		nil,
		48,
		16460,
		1,
		nil,
		1,
		nil,
		16460
	},
	[16460002] = {
		16460002,
		0,
		Lang.get(26732),
		16460,
		2,
		55,
		{
			RTResTalkAction[21]
		}
	},
	[16460003] = {
		16460003,
		0,
		Lang.get(26733),
		16460,
		3,
		179,
		{
			RTResTalkAction[177],
			RTResTalkAction[25]
		}
	},
	[16460004] = {
		16460004,
		0,
		Lang.get(26734),
		16460,
		4,
		150,
		{
			RTResTalkAction[181],
			RTResTalkAction[179]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		16461,
		0.5,
		1,
		1,
		nil,
		16461
	},
	[16460005] = {
		16460005,
		0,
		Lang.get(36148),
		16460,
		5,
		119,
		{
			RTResTalkAction[302],
			RTResTalkAction[125]
		}
	},
	[16460006] = {
		16460006,
		0,
		Lang.get(36149),
		16460,
		6,
		107,
		{
			RTResTalkAction[93],
			RTResTalkAction[303]
		}
	},
	[16460007] = {
		16460007,
		0,
		Lang.get(36150),
		16460,
		7,
		133,
		{
			RTResTalkAction[83],
			RTResTalkAction[85],
			RTResTalkAction[78]
		}
	},
	[16460008] = {
		16460008,
		5,
		Lang.get(26738),
		16460,
		8,
		559,
		{
			RTResTalkAction[139],
			RTResTalkAction[89]
		}
	},
	[16460009] = {
		16460009,
		0,
		Lang.get(26739),
		16460,
		9,
		134,
		{
			RTResTalkAction[140],
			RTResTalkAction[304]
		}
	},
	[16460010] = {
		16460010,
		5,
		Lang.get(26740),
		16460,
		10,
		119,
		{
			RTResTalkAction[165],
			RTResTalkAction[143],
			RTResTalkAction[84]
		}
	},
	[16460011] = {
		16460011,
		0,
		Lang.get(36151),
		16460,
		11,
		107,
		{
			RTResTalkAction[107],
			RTResTalkAction[85]
		}
	},
	[16460012] = {
		16460012,
		0,
		Lang.get(26742),
		16460,
		12,
		179,
		{
			RTResTalkAction[177],
			RTResTalkAction[78]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		16462,
		1,
		1,
		1,
		nil,
		16462
	},
	[16460013] = {
		16460013,
		0,
		Lang.get(26743),
		16460,
		13,
		149,
		{
			RTResTalkAction[178],
			RTResTalkAction[170]
		}
	},
	[16460014] = {
		16460014,
		0,
		Lang.get(26744),
		16460,
		14,
		179,
		{
			RTResTalkAction[305],
			RTResTalkAction[170]
		}
	},
	[16460015] = {
		16460015,
		0,
		Lang.get(26745),
		16460,
		15,
		149,
		{
			RTResTalkAction[178],
			RTResTalkAction[170]
		}
	},
	[16460016] = {
		16460016,
		0,
		Lang.get(26746),
		16460,
		16,
		179,
		{
			RTResTalkAction[306],
			RTResTalkAction[170]
		}
	},
	[16460017] = {
		16460017,
		0,
		Lang.get(26747),
		16460,
		17,
		179,
		{
			RTResTalkAction[307],
			RTResTalkAction[170]
		}
	},
	[16470001] = {
		16470001,
		3,
		Lang.get(26748),
		16470,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		48,
		16470,
		1,
		1,
		nil,
		nil,
		16470,
		nil,
		nil,
		1
	},
	[16470002] = {
		16470002,
		0,
		Lang.get(26749),
		16470,
		2,
		575,
		{
			RTResTalkAction[66]
		},
		nil,
		nil,
		4
	},
	[16470003] = {
		16470003,
		0,
		Lang.get(26750),
		16470,
		3,
		107,
		{
			RTResTalkAction[76],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		16471,
		0.5,
		1,
		1,
		nil,
		16471
	},
	[16470004] = {
		16470004,
		0,
		Lang.get(26751),
		16470,
		4,
		119,
		{
			RTResTalkAction[308],
			RTResTalkAction[78]
		}
	},
	[16470005] = {
		16470005,
		0,
		Lang.get(26752),
		16470,
		5,
		128,
		{
			RTResTalkAction[93],
			RTResTalkAction[174]
		}
	},
	[16470006] = {
		16470006,
		5,
		Lang.get(26753),
		16470,
		6,
		119,
		{
			RTResTalkAction[309],
			RTResTalkAction[174]
		}
	},
	[16470007] = {
		16470007,
		0,
		Lang.get(26754),
		16470,
		7,
		128,
		{
			RTResTalkAction[93],
			RTResTalkAction[174]
		}
	},
	[16470008] = {
		16470008,
		0,
		Lang.get(26755),
		16470,
		8,
		119,
		{
			RTResTalkAction[310],
			RTResTalkAction[174]
		}
	},
	[16470009] = {
		16470009,
		0,
		Lang.get(26756),
		16470,
		9,
		575,
		{
			RTResTalkAction[66],
			RTResTalkAction[85],
			RTResTalkAction[175]
		}
	},
	[16470010] = {
		16470010,
		0,
		Lang.get(26757),
		16470,
		10,
		143,
		{
			RTResTalkAction[145],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		16472,
		0.5,
		1,
		1,
		nil,
		16472
	},
	[16470011] = {
		16470011,
		0,
		Lang.get(26758),
		16470,
		11,
		107,
		{
			RTResTalkAction[311],
			RTResTalkAction[146]
		}
	},
	[16470012] = {
		16470012,
		0,
		Lang.get(26759),
		16470,
		12,
		207,
		{
			RTResTalkAction[108],
			RTResTalkAction[312]
		}
	},
	[16470013] = {
		16470013,
		0,
		Lang.get(26760),
		16470,
		13,
		575,
		{
			RTResTalkAction[78],
			RTResTalkAction[149]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		1,
		nil,
		16473
	},
	[16470014] = {
		16470014,
		0,
		Lang.get(26761),
		16470,
		14,
		107,
		nil,
		1
	},
	[16470015] = {
		16470015,
		0,
		Lang.get(26762),
		16470,
		15,
		148,
		nil,
		1
	},
	[16470016] = {
		16470016,
		0,
		Lang.get(26763),
		16470,
		16,
		119,
		nil,
		1,
		2
	},
	[16470017] = {
		16470017,
		0,
		Lang.get(26764),
		16470,
		17,
		150,
		nil,
		1,
		0
	},
	[16470018] = {
		16470018,
		5,
		Lang.get(26765),
		16470,
		18,
		134,
		nil,
		1
	},
	[16470019] = {
		16470019,
		3,
		Lang.get(21734),
		16470,
		19,
		605,
		[21] = 1
	},
	[16470020] = {
		16470020,
		5,
		Lang.get(26766),
		16470,
		20,
		107,
		nil,
		1,
		1
	},
	[16470021] = {
		16470021,
		0,
		Lang.get(26614),
		16470,
		21,
		204,
		nil,
		1,
		0
	},
	[16470022] = {
		16470022,
		0,
		Lang.get(26767),
		16470,
		22,
		575,
		nil,
		1
	},
	[16470023] = {
		16470023,
		0,
		Lang.get(26768),
		16470,
		23,
		143,
		nil,
		1
	},
	[16470024] = {
		16470024,
		0,
		Lang.get(26769),
		16470,
		24,
		207,
		nil,
		1
	},
	[16470025] = {
		16470025,
		0,
		Lang.get(26770),
		16470,
		25,
		143,
		nil,
		1
	},
	[16470026] = {
		16470026,
		3,
		Lang.get(21734),
		16470,
		26,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		16474,
		0.5,
		1,
		1,
		nil,
		16474,
		nil,
		nil,
		1
	},
	[16470027] = {
		16470027,
		0,
		Lang.get(26771),
		16470,
		27,
		575,
		{
			RTResTalkAction[66]
		},
		nil,
		nil,
		3
	},
	[16470028] = {
		16470028,
		0,
		Lang.get(26772),
		16470,
		28,
		575,
		{
			RTResTalkAction[66]
		}
	},
	[16470029] = {
		16470029,
		0,
		Lang.get(26773),
		16470,
		29,
		575,
		{
			RTResTalkAction[66]
		}
	},
	[16470030] = {
		16470030,
		3,
		Lang.get(26774),
		16470,
		30,
		605,
		{
			RTResTalkAction[23]
		},
		[21] = 1
	},
	[16470031] = {
		16470031,
		0,
		Lang.get(26768),
		16470,
		31,
		143,
		{
			RTResTalkAction[145]
		}
	},
	[16470032] = {
		16470032,
		0,
		Lang.get(26775),
		16470,
		32,
		107,
		{
			RTResTalkAction[76],
			RTResTalkAction[146]
		}
	},
	[16470033] = {
		16470033,
		5,
		Lang.get(26776),
		16470,
		33,
		119,
		{
			RTResTalkAction[297],
			RTResTalkAction[78]
		}
	},
	[16470034] = {
		16470034,
		0,
		Lang.get(26777),
		16470,
		34,
		150,
		{
			RTResTalkAction[93],
			RTResTalkAction[192]
		}
	},
	[16470035] = {
		16470035,
		0,
		Lang.get(26778),
		16470,
		35,
		119,
		{
			RTResTalkAction[93],
			RTResTalkAction[192]
		}
	},
	[16470036] = {
		16470036,
		0,
		Lang.get(26779),
		16470,
		36,
		107,
		{
			RTResTalkAction[76],
			RTResTalkAction[85],
			RTResTalkAction[125]
		}
	},
	[16470037] = {
		16470037,
		0,
		Lang.get(26780),
		16470,
		37,
		119,
		{
			RTResTalkAction[313],
			RTResTalkAction[78]
		}
	},
	[16470038] = {
		16470038,
		3,
		Lang.get(21734),
		16470,
		38,
		605,
		{
			RTResTalkAction[85]
		},
		[21] = 1
	},
	[16470039] = {
		16470039,
		0,
		Lang.get(26781),
		16470,
		39,
		575,
		{
			RTResTalkAction[66]
		}
	},
	[16470040] = {
		16470040,
		5,
		Lang.get(26782),
		16470,
		40,
		575,
		{
			RTResTalkAction[66]
		}
	},
	[16480001] = {
		16480001,
		3,
		Lang.get(26783),
		16480,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		48,
		16480,
		0.2,
		nil,
		1,
		nil,
		16480,
		nil,
		nil,
		1
	},
	[16480002] = {
		16480002,
		0,
		Lang.get(26784),
		16480,
		2,
		150,
		{
			RTResTalkAction[181]
		},
		nil,
		nil,
		3
	},
	[16480003] = {
		16480003,
		0,
		Lang.get(26785),
		16480,
		3,
		107,
		{
			RTResTalkAction[283],
			RTResTalkAction[125]
		}
	},
	[16480004] = {
		16480004,
		0,
		Lang.get(26786),
		16480,
		4,
		150,
		{
			RTResTalkAction[181],
			RTResTalkAction[78]
		}
	},
	[16480005] = {
		16480005,
		0,
		Lang.get(26787),
		16480,
		5,
		187,
		{
			RTResTalkAction[150],
			RTResTalkAction[125]
		}
	},
	[16480006] = {
		16480006,
		0,
		Lang.get(26788),
		16480,
		6,
		107,
		{
			RTResTalkAction[90],
			RTResTalkAction[153]
		}
	},
	[16480007] = {
		16480007,
		0,
		Lang.get(26789),
		16480,
		7,
		133,
		{
			RTResTalkAction[83],
			RTResTalkAction[78]
		}
	},
	[16480008] = {
		16480008,
		0,
		Lang.get(26790),
		16480,
		8,
		107,
		{
			RTResTalkAction[107],
			RTResTalkAction[89]
		}
	},
	[16480009] = {
		16480009,
		0,
		"……",
		16480,
		9,
		141,
		{
			RTResTalkAction[314],
			RTResTalkAction[78]
		}
	},
	[16480010] = {
		16480010,
		0,
		Lang.get(26791),
		16480,
		10,
		187,
		{
			RTResTalkAction[150],
			RTResTalkAction[101]
		}
	},
	[16480011] = {
		16480011,
		0,
		Lang.get(26792),
		16480,
		11,
		196,
		{
			RTResTalkAction[153]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		1,
		nil,
		16481
	},
	[16480012] = {
		16480012,
		0,
		Lang.get(26793),
		16480,
		12,
		107,
		nil,
		1
	},
	[16480013] = {
		16480013,
		0,
		Lang.get(26794),
		16480,
		13,
		196,
		nil,
		1,
		3
	},
	[16480014] = {
		16480014,
		0,
		Lang.get(26795),
		16480,
		14,
		107,
		nil,
		1,
		7
	},
	[16480015] = {
		16480015,
		0,
		Lang.get(26796),
		16480,
		15,
		133,
		nil,
		1,
		0
	},
	[16480016] = {
		16480016,
		0,
		Lang.get(26797),
		16480,
		16,
		196,
		nil,
		1,
		3
	},
	[16480017] = {
		16480017,
		0,
		Lang.get(26798),
		16480,
		17,
		196,
		nil,
		1,
		0
	},
	[16480018] = {
		16480018,
		0,
		Lang.get(26799),
		16480,
		18,
		107,
		nil,
		1,
		8
	},
	[16480019] = {
		16480019,
		0,
		Lang.get(26800),
		16480,
		19,
		196,
		nil,
		1,
		0
	},
	[16480020] = {
		16480020,
		0,
		Lang.get(26801),
		16480,
		20,
		150,
		nil,
		1,
		0
	},
	[16480021] = {
		16480021,
		0,
		Lang.get(26802),
		16480,
		21,
		107,
		nil,
		1,
		0
	},
	[16480022] = {
		16480022,
		0,
		Lang.get(26803),
		16480,
		22,
		196,
		nil,
		1
	},
	[16481001] = {
		16481001,
		0,
		Lang.get(26804),
		16481,
		1,
		133,
		nil,
		1,
		nil,
		nil,
		nil,
		48,
		16482,
		nil,
		nil,
		nil,
		nil,
		16482
	},
	[16481002] = {
		16481002,
		5,
		Lang.get(26805),
		16481,
		2,
		167,
		{
			RTResTalkAction[155]
		},
		nil,
		nil,
		3
	},
	[16481003] = {
		16481003,
		0,
		Lang.get(26806),
		16481,
		3,
		194,
		{
			RTResTalkAction[315],
			RTResTalkAction[157]
		}
	},
	[16481004] = {
		16481004,
		5,
		Lang.get(26807),
		16481,
		4,
		167,
		{
			RTResTalkAction[316],
			RTResTalkAction[278]
		}
	},
	[16490001] = {
		16490001,
		0,
		Lang.get(26808),
		16490,
		1,
		41,
		{
			RTResTalkAction[317]
		},
		nil,
		nil,
		3,
		nil,
		62,
		16490,
		1.5,
		nil,
		1,
		nil,
		16490
	},
	[16490002] = {
		16490002,
		0,
		Lang.get(26809),
		16490,
		2,
		107,
		{
			RTResTalkAction[116],
			RTResTalkAction[22]
		}
	},
	[16490003] = {
		16490003,
		0,
		Lang.get(26810),
		16490,
		3,
		196,
		{
			RTResTalkAction[108],
			RTResTalkAction[318]
		}
	},
	[16490004] = {
		16490004,
		0,
		Lang.get(26811),
		16490,
		4,
		107,
		{
			RTResTalkAction[319],
			RTResTalkAction[320]
		}
	},
	[16490005] = {
		16490005,
		0,
		Lang.get(26812),
		16490,
		5,
		196,
		{
			RTResTalkAction[108],
			RTResTalkAction[321]
		}
	},
	[16490006] = {
		16490006,
		0,
		Lang.get(26813),
		16490,
		6,
		187,
		{
			RTResTalkAction[150],
			RTResTalkAction[78],
			RTResTalkAction[277]
		}
	},
	[16490007] = {
		16490007,
		0,
		Lang.get(26814),
		16490,
		7,
		150,
		{
			RTResTalkAction[163],
			RTResTalkAction[192]
		}
	},
	[16490008] = {
		16490008,
		0,
		Lang.get(26815),
		16490,
		8,
		133,
		{
			RTResTalkAction[83],
			RTResTalkAction[153],
			RTResTalkAction[125]
		}
	},
	[16490009] = {
		16490009,
		0,
		Lang.get(26816),
		16490,
		9,
		107,
		{
			RTResTalkAction[86],
			RTResTalkAction[322]
		}
	},
	[16490010] = {
		16490010,
		0,
		Lang.get(26817),
		16490,
		10,
		196,
		{
			RTResTalkAction[323],
			RTResTalkAction[89],
			RTResTalkAction[78]
		}
	},
	[16490011] = {
		16490011,
		0,
		Lang.get(26818),
		16490,
		11,
		107,
		{
			RTResTalkAction[76],
			RTResTalkAction[277]
		}
	},
	[16490012] = {
		16490012,
		0,
		Lang.get(26819),
		16490,
		12,
		41,
		{
			RTResTalkAction[317],
			RTResTalkAction[78]
		},
		nil,
		nil,
		3,
		nil,
		62,
		16491,
		1,
		1,
		1,
		nil,
		16491
	},
	[16490013] = {
		16490013,
		0,
		Lang.get(36152),
		16490,
		13,
		107,
		{
			RTResTalkAction[214],
			RTResTalkAction[22]
		}
	},
	[16490014] = {
		16490014,
		0,
		Lang.get(26821),
		16490,
		14,
		133,
		{
			RTResTalkAction[83],
			RTResTalkAction[78]
		}
	},
	[16490015] = {
		16490015,
		0,
		Lang.get(19271),
		16490,
		15,
		141,
		{
			RTResTalkAction[86],
			RTResTalkAction[129]
		}
	},
	[16490016] = {
		16490016,
		0,
		Lang.get(26822),
		16490,
		16,
		107,
		{
			RTResTalkAction[158],
			RTResTalkAction[89],
			RTResTalkAction[101]
		}
	},
	[16490017] = {
		16490017,
		0,
		Lang.get(26823),
		16490,
		17,
		196,
		{
			RTResTalkAction[271],
			RTResTalkAction[78]
		}
	},
	[16490018] = {
		16490018,
		0,
		Lang.get(26824),
		16490,
		18,
		133,
		{
			RTResTalkAction[83],
			RTResTalkAction[277]
		}
	},
	[16490019] = {
		16490019,
		0,
		Lang.get(26825),
		16490,
		19,
		196,
		{
			RTResTalkAction[271],
			RTResTalkAction[89]
		}
	},
	[16490020] = {
		16490020,
		0,
		Lang.get(26826),
		16490,
		20,
		107,
		{
			RTResTalkAction[324],
			RTResTalkAction[320]
		}
	},
	[16490021] = {
		16490021,
		0,
		Lang.get(26827),
		16490,
		21,
		196,
		{
			RTResTalkAction[108],
			RTResTalkAction[318]
		}
	},
	[16490022] = {
		16490022,
		0,
		Lang.get(26828),
		16490,
		22,
		107,
		{
			RTResTalkAction[215],
			RTResTalkAction[320]
		}
	},
	[16490023] = {
		16490023,
		0,
		Lang.get(26829),
		16490,
		23,
		196,
		{
			RTResTalkAction[108],
			RTResTalkAction[325]
		}
	},
	[16490024] = {
		16490024,
		3,
		Lang.get(26415),
		16490,
		24,
		196,
		{
			RTResTalkAction[78],
			RTResTalkAction[277]
		},
		nil,
		nil,
		3,
		nil,
		62,
		16492,
		0.5,
		1,
		1,
		nil,
		16492,
		nil,
		nil,
		1
	},
	[16490025] = {
		16490025,
		0,
		Lang.get(26830),
		16490,
		25,
		41,
		{
			RTResTalkAction[317]
		}
	},
	[16490026] = {
		16490026,
		5,
		Lang.get(26831),
		16490,
		26,
		41,
		{
			RTResTalkAction[65]
		}
	},
	[16490027] = {
		16490027,
		5,
		Lang.get(26832),
		16490,
		27,
		167,
		{
			RTResTalkAction[155],
			RTResTalkAction[22]
		},
		nil,
		nil,
		3,
		nil,
		62,
		16493,
		0.5,
		1,
		1,
		nil,
		16493
	},
	[16490028] = {
		16490028,
		0,
		Lang.get(26833),
		16490,
		28,
		179,
		{
			RTResTalkAction[177],
			RTResTalkAction[157]
		}
	},
	[16490029] = {
		16490029,
		0,
		Lang.get(26834),
		16490,
		29,
		149,
		{
			RTResTalkAction[178],
			RTResTalkAction[170]
		}
	},
	[16490030] = {
		16490030,
		0,
		Lang.get(26835),
		16490,
		30,
		107,
		{
			RTResTalkAction[214],
			RTResTalkAction[179],
			RTResTalkAction[172]
		}
	},
	[16490031] = {
		16490031,
		0,
		Lang.get(26836),
		16490,
		31,
		196,
		{
			RTResTalkAction[108],
			RTResTalkAction[326]
		}
	},
	[16490032] = {
		16490032,
		5,
		Lang.get(26837),
		16490,
		32,
		107,
		{
			RTResTalkAction[215],
			RTResTalkAction[320]
		}
	},
	[16490033] = {
		16490033,
		5,
		Lang.get(26838),
		16490,
		33,
		107,
		{
			RTResTalkAction[327],
			RTResTalkAction[320]
		}
	},
	[16490034] = {
		16490034,
		0,
		Lang.get(26839),
		16490,
		34,
		196,
		{
			RTResTalkAction[108],
			RTResTalkAction[325]
		}
	},
	[16490035] = {
		16490035,
		5,
		Lang.get(26840),
		16490,
		35,
		167,
		{
			RTResTalkAction[316],
			RTResTalkAction[78],
			RTResTalkAction[277]
		}
	},
	[16490036] = {
		16490036,
		0,
		Lang.get(26841),
		16490,
		36,
		179,
		{
			RTResTalkAction[169],
			RTResTalkAction[180]
		}
	},
	[16490037] = {
		16490037,
		0,
		Lang.get(26842),
		16490,
		37,
		150,
		{
			RTResTalkAction[181],
			RTResTalkAction[157],
			RTResTalkAction[179]
		}
	},
	[16490038] = {
		16490038,
		0,
		Lang.get(26843),
		16490,
		38,
		206,
		{
			RTResTalkAction[294],
			RTResTalkAction[125]
		},
		nil,
		nil,
		3,
		nil,
		62,
		16494,
		1,
		1,
		1,
		nil,
		16494
	},
	[16490039] = {
		16490039,
		5,
		Lang.get(26844),
		16490,
		39,
		41,
		{
			RTResTalkAction[65],
			RTResTalkAction[296]
		}
	},
	[16490040] = {
		16490040,
		0,
		Lang.get(26845),
		16490,
		40,
		150,
		{
			RTResTalkAction[181],
			RTResTalkAction[22]
		}
	},
	[16490041] = {
		16490041,
		0,
		"……",
		16490,
		41,
		196,
		{
			RTResTalkAction[328],
			RTResTalkAction[125]
		}
	},
	[16490042] = {
		16490042,
		5,
		Lang.get(26846),
		16490,
		42,
		107,
		{
			RTResTalkAction[329],
			RTResTalkAction[277]
		}
	},
	[16500001] = {
		16500001,
		3,
		Lang.get(26847),
		16500,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		16500,
		0.5,
		nil,
		1,
		nil,
		16500,
		nil,
		nil,
		1
	},
	[16500002] = {
		16500002,
		0,
		Lang.get(26848),
		16500,
		2,
		576,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[16500003] = {
		16500003,
		0,
		Lang.get(26849),
		16500,
		3,
		119,
		{
			RTResTalkAction[290],
			RTResTalkAction[16]
		}
	},
	[16500004] = {
		16500004,
		0,
		Lang.get(26850),
		16500,
		4,
		107,
		{
			RTResTalkAction[124],
			RTResTalkAction[85]
		}
	},
	[16500005] = {
		16500005,
		0,
		Lang.get(26851),
		16500,
		5,
		576,
		{
			RTResTalkAction[14],
			RTResTalkAction[78]
		}
	},
	[16500006] = {
		16500006,
		0,
		Lang.get(26852),
		16500,
		6,
		179,
		{
			RTResTalkAction[177],
			RTResTalkAction[16]
		}
	},
	[16500007] = {
		16500007,
		0,
		Lang.get(26853),
		16500,
		7,
		149,
		{
			RTResTalkAction[178],
			RTResTalkAction[170]
		}
	},
	[16500008] = {
		16500008,
		0,
		Lang.get(26854),
		16500,
		8,
		576,
		{
			RTResTalkAction[14],
			RTResTalkAction[179],
			RTResTalkAction[172]
		}
	},
	[16500009] = {
		16500009,
		0,
		Lang.get(26855),
		16500,
		9,
		158,
		{
			RTResTalkAction[16]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		6502,
		0.5,
		1,
		1,
		nil,
		6502
	},
	[16500010] = {
		16500010,
		0,
		Lang.get(26856),
		16500,
		10,
		128,
		{
			RTResTalkAction[330]
		},
		nil,
		nil,
		3
	},
	[16500011] = {
		16500011,
		0,
		Lang.get(26857),
		16500,
		11,
		107,
		{
			RTResTalkAction[197],
			RTResTalkAction[175]
		}
	},
	[16500012] = {
		16500012,
		0,
		Lang.get(26858),
		16500,
		12,
		107,
		{
			RTResTalkAction[116]
		}
	},
	[16500013] = {
		16500013,
		0,
		Lang.get(26859),
		16500,
		13,
		576,
		{
			RTResTalkAction[14],
			RTResTalkAction[78]
		}
	},
	[16500014] = {
		16500014,
		5,
		Lang.get(26860),
		16500,
		14,
		107,
		{
			RTResTalkAction[233],
			RTResTalkAction[16]
		}
	},
	[16500015] = {
		16500015,
		0,
		Lang.get(26861),
		16500,
		15,
		179,
		{
			RTResTalkAction[177],
			RTResTalkAction[78]
		}
	},
	[16501001] = {
		16501001,
		0,
		Lang.get(26862),
		16501,
		1,
		158,
		nil,
		1,
		2,
		nil,
		nil,
		60,
		16503,
		0.5,
		1,
		1,
		nil,
		16503
	},
	[16501002] = {
		16501002,
		0,
		Lang.get(26863),
		16501,
		2,
		301,
		{
			RTResTalkAction[331]
		},
		nil,
		nil,
		3
	},
	[16501003] = {
		16501003,
		0,
		Lang.get(26864),
		16501,
		3,
		301,
		{
			RTResTalkAction[332]
		}
	},
	[16501004] = {
		16501004,
		0,
		Lang.get(26865),
		16501,
		4,
		576,
		{
			RTResTalkAction[26],
			RTResTalkAction[333]
		}
	},
	[16501005] = {
		16501005,
		0,
		Lang.get(26866),
		16501,
		5,
		179,
		{
			RTResTalkAction[16]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		16501,
		0.5,
		1,
		1,
		nil,
		16501
	},
	[16501006] = {
		16501006,
		0,
		Lang.get(26867),
		16501,
		6,
		167,
		{
			RTResTalkAction[155]
		},
		nil,
		nil,
		3
	},
	[16501007] = {
		16501007,
		0,
		Lang.get(26868),
		16501,
		7,
		179,
		{
			RTResTalkAction[169],
			RTResTalkAction[183]
		}
	},
	[16501008] = {
		16501008,
		5,
		Lang.get(26869),
		16501,
		8,
		167,
		{
			RTResTalkAction[334],
			RTResTalkAction[180]
		}
	},
	[16501009] = {
		16501009,
		0,
		Lang.get(26870),
		16501,
		9,
		576,
		{
			RTResTalkAction[26],
			RTResTalkAction[157],
			RTResTalkAction[179]
		}
	},
	[16501010] = {
		16501010,
		0,
		Lang.get(26871),
		16501,
		10,
		179,
		{
			RTResTalkAction[335],
			RTResTalkAction[16]
		}
	},
	[16501011] = {
		16501011,
		0,
		Lang.get(26872),
		16501,
		11,
		149,
		{
			RTResTalkAction[178],
			RTResTalkAction[170]
		}
	},
	[16501012] = {
		16501012,
		0,
		Lang.get(26873),
		16501,
		12,
		158,
		{
			RTResTalkAction[211],
			RTResTalkAction[179],
			RTResTalkAction[172]
		}
	},
	[16501013] = {
		16501013,
		0,
		Lang.get(26874),
		16501,
		13,
		159,
		{
			RTResTalkAction[9]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		16504,
		nil,
		1,
		1,
		nil,
		16504
	},
	[16501014] = {
		16501014,
		0,
		Lang.get(26875),
		16501,
		14,
		576,
		{
			RTResTalkAction[26]
		},
		nil,
		nil,
		3
	},
	[16501015] = {
		16501015,
		0,
		Lang.get(36153),
		16501,
		15,
		179,
		{
			RTResTalkAction[177],
			RTResTalkAction[16]
		}
	},
	[16501016] = {
		16501016,
		0,
		Lang.get(26877),
		16501,
		16,
		123,
		{
			RTResTalkAction[154],
			RTResTalkAction[179]
		}
	},
	[16501017] = {
		16501017,
		0,
		Lang.get(26878),
		16501,
		17,
		302,
		{
			RTResTalkAction[267],
			RTResTalkAction[151]
		}
	},
	[16501018] = {
		16501018,
		5,
		Lang.get(26879),
		16501,
		18,
		579,
		{
			RTResTalkAction[276],
			RTResTalkAction[270]
		}
	},
	[16501019] = {
		16501019,
		5,
		Lang.get(26880),
		16501,
		19,
		581,
		{
			RTResTalkAction[336],
			RTResTalkAction[266]
		}
	},
	[16501020] = {
		16501020,
		0,
		Lang.get(26881),
		16501,
		20,
		179,
		{
			RTResTalkAction[177],
			RTResTalkAction[268]
		}
	},
	[16501021] = {
		16501021,
		0,
		Lang.get(26882),
		16501,
		21,
		149,
		{
			RTResTalkAction[178],
			RTResTalkAction[170]
		}
	},
	[16510001] = {
		16510001,
		0,
		Lang.get(26883),
		16510,
		1,
		119,
		{
			RTResTalkAction[290]
		},
		nil,
		nil,
		3,
		nil,
		60,
		16510,
		2,
		1,
		1,
		nil,
		16510
	},
	[16510002] = {
		16510002,
		0,
		Lang.get(26884),
		16510,
		2,
		150,
		{
			RTResTalkAction[93],
			RTResTalkAction[192]
		}
	},
	[16510003] = {
		16510003,
		0,
		Lang.get(26885),
		16510,
		3,
		133,
		{
			RTResTalkAction[83],
			RTResTalkAction[85],
			RTResTalkAction[125]
		}
	},
	[16510004] = {
		16510004,
		0,
		Lang.get(26886),
		16510,
		4,
		107,
		{
			RTResTalkAction[86],
			RTResTalkAction[337]
		}
	},
	[16510005] = {
		16510005,
		5,
		Lang.get(26887),
		16510,
		5,
		119,
		{
			RTResTalkAction[165],
			RTResTalkAction[89],
			RTResTalkAction[78]
		}
	},
	[16511001] = {
		16511001,
		0,
		Lang.get(26888),
		16511,
		1,
		576,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		16511,
		nil,
		1,
		1,
		nil,
		16511
	},
	[16511002] = {
		16511002,
		0,
		Lang.get(26889),
		16511,
		2,
		134,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		16512,
		nil,
		nil,
		1,
		nil,
		16512
	},
	[16511003] = {
		16511003,
		0,
		Lang.get(26890),
		16511,
		3,
		158,
		{
			RTResTalkAction[211]
		},
		nil,
		nil,
		3
	},
	[16511004] = {
		16511004,
		0,
		Lang.get(26891),
		16511,
		4,
		179,
		{
			RTResTalkAction[38],
			RTResTalkAction[180]
		}
	},
	[16511005] = {
		16511005,
		0,
		Lang.get(26892),
		16511,
		5,
		158,
		{
			RTResTalkAction[38],
			RTResTalkAction[180]
		}
	},
	[16511006] = {
		16511006,
		0,
		Lang.get(26893),
		16511,
		6,
		149,
		{
			RTResTalkAction[338],
			RTResTalkAction[9],
			RTResTalkAction[179]
		}
	},
	[16511007] = {
		16511007,
		5,
		Lang.get(26894),
		16511,
		7,
		119,
		{
			RTResTalkAction[165],
			RTResTalkAction[172]
		}
	},
	[16511008] = {
		16511008,
		0,
		Lang.get(32020),
		16511,
		8,
		576,
		{
			RTResTalkAction[14],
			RTResTalkAction[85]
		}
	},
	[16511009] = {
		16511009,
		3,
		Lang.get(26896),
		16511,
		9,
		605,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		16513,
		nil,
		1,
		1,
		nil,
		16513,
		nil,
		nil,
		1
	},
	[16511010] = {
		16511010,
		0,
		Lang.get(26897),
		16511,
		10,
		134,
		{
			RTResTalkAction[121]
		},
		nil,
		nil,
		3
	},
	[16511011] = {
		16511011,
		0,
		Lang.get(26898),
		16511,
		11,
		140,
		{
			RTResTalkAction[79],
			RTResTalkAction[167]
		}
	},
	[16511012] = {
		16511012,
		0,
		Lang.get(32021),
		16511,
		12,
		576,
		{
			RTResTalkAction[26],
			RTResTalkAction[84],
			RTResTalkAction[168]
		}
	},
	[16511013] = {
		16511013,
		0,
		Lang.get(26900),
		16511,
		13,
		179,
		{
			RTResTalkAction[177],
			RTResTalkAction[16]
		}
	},
	[16511014] = {
		16511014,
		0,
		Lang.get(26901),
		16511,
		14,
		133,
		{
			RTResTalkAction[83],
			RTResTalkAction[179]
		}
	},
	[16511015] = {
		16511015,
		0,
		Lang.get(26902),
		16511,
		15,
		141,
		{
			RTResTalkAction[99],
			RTResTalkAction[89]
		}
	},
	[16511016] = {
		16511016,
		0,
		Lang.get(26903),
		16511,
		16,
		107,
		{
			RTResTalkAction[124],
			RTResTalkAction[101]
		}
	},
	[16511017] = {
		16511017,
		0,
		Lang.get(26904),
		16511,
		17,
		576,
		{
			RTResTalkAction[14],
			RTResTalkAction[78]
		}
	},
	[16512001] = {
		16512001,
		0,
		Lang.get(26905),
		16512,
		1,
		149,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		16514,
		nil,
		1,
		1,
		nil,
		16514
	},
	[16512002] = {
		16512002,
		0,
		Lang.get(26906),
		16512,
		2,
		128,
		{
			RTResTalkAction[330]
		},
		nil,
		nil,
		3
	},
	[16512003] = {
		16512003,
		0,
		Lang.get(26907),
		16512,
		3,
		158,
		{
			RTResTalkAction[5],
			RTResTalkAction[175]
		}
	},
	[16512004] = {
		16512004,
		0,
		Lang.get(26908),
		16512,
		4,
		107,
		{
			RTResTalkAction[197],
			RTResTalkAction[9]
		}
	},
	[16512005] = {
		16512005,
		0,
		Lang.get(26909),
		16512,
		5,
		119,
		{
			RTResTalkAction[313],
			RTResTalkAction[78]
		}
	},
	[16512006] = {
		16512006,
		0,
		Lang.get(26910),
		16512,
		6,
		128,
		{
			RTResTalkAction[330],
			RTResTalkAction[85]
		}
	},
	[16512007] = {
		16512007,
		0,
		Lang.get(26911),
		16512,
		7,
		576,
		{
			RTResTalkAction[26],
			RTResTalkAction[175]
		}
	},
	[16512008] = {
		16512008,
		0,
		Lang.get(26912),
		16512,
		8,
		150,
		{
			RTResTalkAction[181],
			RTResTalkAction[16]
		}
	},
	[16512009] = {
		16512009,
		0,
		Lang.get(26913),
		16512,
		9,
		179,
		{
			RTResTalkAction[177],
			RTResTalkAction[125]
		}
	},
	[16512010] = {
		16512010,
		0,
		Lang.get(26914),
		16512,
		10,
		107,
		{
			RTResTalkAction[339],
			RTResTalkAction[179]
		}
	},
	[16512011] = {
		16512011,
		0,
		Lang.get(26915),
		16512,
		11,
		107,
		{
			RTResTalkAction[76]
		}
	},
	[16513001] = {
		16513001,
		0,
		Lang.get(26916),
		16513,
		1,
		576,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		16515,
		nil,
		nil,
		1,
		nil,
		16515
	},
	[16513002] = {
		16513002,
		0,
		Lang.get(26917),
		16513,
		2,
		576,
		nil,
		1
	},
	[16513003] = {
		16513003,
		0,
		Lang.get(26918),
		16513,
		3,
		107,
		{
			RTResTalkAction[340]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[16513004] = {
		16513004,
		0,
		Lang.get(26919),
		16513,
		4,
		133,
		{
			RTResTalkAction[83],
			RTResTalkAction[78]
		}
	},
	[16513005] = {
		16513005,
		0,
		Lang.get(26920),
		16513,
		5,
		141,
		{
			RTResTalkAction[99],
			RTResTalkAction[89]
		}
	},
	[16513006] = {
		16513006,
		5,
		Lang.get(26921),
		16513,
		6,
		107,
		{
			RTResTalkAction[329],
			RTResTalkAction[101]
		}
	},
	[16520001] = {
		16520001,
		0,
		Lang.get(26922),
		16520,
		1,
		576,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		16520,
		1,
		1,
		1,
		nil,
		16520
	},
	[16520002] = {
		16520002,
		0,
		Lang.get(26923),
		16520,
		2,
		158,
		{
			RTResTalkAction[75]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		16521,
		1.5,
		1,
		1,
		nil,
		16521
	},
	[16520003] = {
		16520003,
		0,
		Lang.get(26924),
		16520,
		3,
		179,
		{
			RTResTalkAction[38],
			RTResTalkAction[180]
		}
	},
	[16520004] = {
		16520004,
		0,
		Lang.get(26925),
		16520,
		4,
		158,
		{
			RTResTalkAction[257],
			RTResTalkAction[180]
		}
	},
	[16520005] = {
		16520005,
		0,
		Lang.get(26926),
		16520,
		5,
		179,
		{
			RTResTalkAction[38],
			RTResTalkAction[180]
		}
	},
	[16520006] = {
		16520006,
		0,
		Lang.get(26927),
		16520,
		6,
		158,
		{
			RTResTalkAction[38],
			RTResTalkAction[180]
		}
	},
	[16520007] = {
		16520007,
		0,
		Lang.get(26928),
		16520,
		7,
		149,
		{
			RTResTalkAction[38],
			RTResTalkAction[170],
			RTResTalkAction[179]
		}
	},
	[16520008] = {
		16520008,
		0,
		Lang.get(26929),
		16520,
		8,
		158,
		{
			RTResTalkAction[38],
			RTResTalkAction[170]
		}
	},
	[16520009] = {
		16520009,
		0,
		Lang.get(26930),
		16520,
		9,
		149,
		{
			RTResTalkAction[38],
			RTResTalkAction[170]
		}
	},
	[16520010] = {
		16520010,
		0,
		Lang.get(26931),
		16520,
		10,
		158,
		{
			RTResTalkAction[38],
			RTResTalkAction[170]
		}
	},
	[16520011] = {
		16520011,
		3,
		Lang.get(26932),
		16520,
		11,
		605,
		{
			RTResTalkAction[9],
			RTResTalkAction[172]
		},
		[21] = 1
	},
	[16520012] = {
		16520012,
		0,
		Lang.get(26933),
		16520,
		12,
		149,
		{
			RTResTalkAction[341]
		}
	},
	[16520013] = {
		16520013,
		0,
		Lang.get(26934),
		16520,
		13,
		179,
		{
			RTResTalkAction[286],
			RTResTalkAction[180]
		}
	},
	[16520014] = {
		16520014,
		5,
		Lang.get(26935),
		16520,
		14,
		559,
		{
			RTResTalkAction[139],
			RTResTalkAction[172],
			RTResTalkAction[179]
		}
	},
	[16520015] = {
		16520015,
		5,
		Lang.get(26936),
		16520,
		15,
		119,
		{
			RTResTalkAction[165],
			RTResTalkAction[143]
		}
	},
	[16520016] = {
		16520016,
		0,
		Lang.get(26937),
		16520,
		16,
		134,
		{
			RTResTalkAction[93],
			RTResTalkAction[94]
		}
	},
	[16520017] = {
		16520017,
		0,
		Lang.get(26938),
		16520,
		17,
		158,
		{
			RTResTalkAction[110],
			RTResTalkAction[85],
			RTResTalkAction[84]
		}
	},
	[16520018] = {
		16520018,
		0,
		Lang.get(26939),
		16520,
		18,
		576,
		{
			RTResTalkAction[9]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		16522,
		2,
		1,
		1,
		nil,
		16522
	},
	[16520019] = {
		16520019,
		0,
		Lang.get(26940),
		16520,
		19,
		211,
		{
			RTResTalkAction[288]
		},
		nil,
		nil,
		3
	},
	[16520020] = {
		16520020,
		0,
		Lang.get(26941),
		16520,
		20,
		149,
		{
			RTResTalkAction[285],
			RTResTalkAction[289]
		}
	},
	[16520021] = {
		16520021,
		0,
		Lang.get(26942),
		16520,
		21,
		179,
		{
			RTResTalkAction[286],
			RTResTalkAction[180]
		}
	},
	[16520022] = {
		16520022,
		5,
		Lang.get(26943),
		16520,
		22,
		107,
		{
			RTResTalkAction[76],
			RTResTalkAction[172],
			RTResTalkAction[179]
		}
	},
	[16520023] = {
		16520023,
		0,
		Lang.get(26944),
		16520,
		23,
		196,
		{
			RTResTalkAction[271],
			RTResTalkAction[78]
		}
	},
	[16520024] = {
		16520024,
		0,
		Lang.get(26945),
		16520,
		24,
		123,
		{
			RTResTalkAction[272],
			RTResTalkAction[161]
		}
	},
	[16520025] = {
		16520025,
		0,
		Lang.get(26946),
		16520,
		25,
		150,
		{
			RTResTalkAction[181],
			RTResTalkAction[277],
			RTResTalkAction[151]
		}
	},
	[16520026] = {
		16520026,
		5,
		Lang.get(26947),
		16520,
		26,
		119,
		{
			RTResTalkAction[243],
			RTResTalkAction[342]
		}
	},
	[16520027] = {
		16520027,
		0,
		Lang.get(26948),
		16520,
		27,
		133,
		{
			RTResTalkAction[83],
			RTResTalkAction[125],
			RTResTalkAction[85]
		}
	},
	[16530001] = {
		16530001,
		0,
		Lang.get(32954),
		16530,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		16530,
		1,
		1,
		1,
		nil,
		16530,
		nil,
		nil,
		1
	},
	[16530002] = {
		16530002,
		0,
		Lang.get(26950),
		16530,
		2,
		158,
		{
			RTResTalkAction[110]
		},
		nil,
		nil,
		3
	},
	[16530003] = {
		16530003,
		0,
		Lang.get(26951),
		16530,
		3,
		107,
		{
			RTResTalkAction[124],
			RTResTalkAction[9]
		}
	},
	[16530004] = {
		16530004,
		0,
		Lang.get(26952),
		16530,
		4,
		134,
		{
			RTResTalkAction[108],
			RTResTalkAction[94]
		}
	},
	[16530005] = {
		16530005,
		0,
		Lang.get(26953),
		16530,
		5,
		133,
		{
			RTResTalkAction[83],
			RTResTalkAction[78],
			RTResTalkAction[84]
		}
	},
	[16530006] = {
		16530006,
		0,
		Lang.get(26954),
		16530,
		6,
		576,
		{
			RTResTalkAction[86],
			RTResTalkAction[73]
		}
	},
	[16530007] = {
		16530007,
		0,
		Lang.get(26955),
		16530,
		7,
		107,
		{
			RTResTalkAction[103],
			RTResTalkAction[89],
			RTResTalkAction[16]
		}
	},
	[16530008] = {
		16530008,
		4,
		nil,
		16530,
		8,
		300,
		{
			RTResTalkAction[76]
		},
		[27] = {
			{
				id = 16530009,
				branch_content = Lang.get(42560)
			},
			{
				id = 16530009,
				branch_content = Lang.get(42561)
			}
		}
	},
	[16530009] = {
		16530009,
		3,
		Lang.get(26957),
		16530,
		9,
		605,
		{
			RTResTalkAction[78]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		1,
		1227,
		16531,
		nil,
		nil,
		1
	},
	[16530010] = {
		16530010,
		0,
		Lang.get(26958),
		16530,
		10,
		119,
		{
			RTResTalkAction[190]
		},
		nil,
		nil,
		3
	},
	[16530011] = {
		16530011,
		0,
		Lang.get(26959),
		16530,
		11,
		107,
		{
			RTResTalkAction[90],
			RTResTalkAction[85]
		}
	},
	[16530012] = {
		16530012,
		0,
		Lang.get(26960),
		16530,
		12,
		158,
		{
			RTResTalkAction[108],
			RTResTalkAction[343]
		}
	},
	[16530013] = {
		16530013,
		0,
		Lang.get(26961),
		16530,
		13,
		107,
		{
			RTResTalkAction[344],
			RTResTalkAction[11]
		}
	},
	[16530014] = {
		16530014,
		0,
		Lang.get(26962),
		16530,
		14,
		150,
		{
			RTResTalkAction[181],
			RTResTalkAction[78],
			RTResTalkAction[9]
		}
	},
	[16530015] = {
		16530015,
		0,
		Lang.get(26963),
		16530,
		15,
		133,
		{
			RTResTalkAction[238],
			RTResTalkAction[102]
		}
	},
	[16530016] = {
		16530016,
		0,
		Lang.get(26964),
		16530,
		16,
		107,
		{
			RTResTalkAction[91],
			RTResTalkAction[125],
			RTResTalkAction[89]
		}
	},
	[16530017] = {
		16530017,
		4,
		nil,
		16530,
		17,
		107,
		{
			RTResTalkAction[76]
		},
		[27] = {
			{
				id = 16530018,
				branch_content = Lang.get(42562)
			},
			{
				id = 16530018,
				branch_content = Lang.get(19557)
			}
		}
	},
	[16530018] = {
		16530018,
		0,
		Lang.get(26966),
		16530,
		18,
		107,
		{
			RTResTalkAction[103]
		}
	},
	[16530019] = {
		16530019,
		4,
		nil,
		16530,
		19,
		107,
		{
			RTResTalkAction[76]
		},
		[27] = {
			{
				id = 16530020,
				branch_content = Lang.get(19725)
			}
		}
	},
	[16530020] = {
		16530020,
		0,
		Lang.get(26968),
		16530,
		20,
		300,
		{
			RTResTalkAction[1],
			RTResTalkAction[78]
		},
		nil,
		nil,
		nil,
		nil,
		49,
		nil,
		nil,
		1,
		[18] = 16532
	},
	[16530021] = {
		16530021,
		3,
		Lang.get(26969),
		16530,
		21,
		300,
		{
			RTResTalkAction[2]
		},
		[21] = 1
	},
	[16530022] = {
		16530022,
		0,
		Lang.get(26970),
		16530,
		22,
		207,
		nil,
		1
	},
	[16530023] = {
		16530023,
		0,
		Lang.get(26971),
		16530,
		23,
		143,
		nil,
		1
	},
	[16530024] = {
		16530024,
		0,
		Lang.get(26972),
		16530,
		24,
		149,
		nil,
		1
	},
	[16530025] = {
		16530025,
		0,
		Lang.get(26973),
		16530,
		25,
		179,
		nil,
		1
	},
	[16530026] = {
		16530026,
		0,
		Lang.get(26974),
		16530,
		26,
		149,
		nil,
		1
	},
	[16530027] = {
		16530027,
		0,
		Lang.get(26975),
		16530,
		27,
		179,
		nil,
		1
	},
	[16530028] = {
		16530028,
		0,
		Lang.get(45482),
		16530,
		28,
		149,
		nil,
		1
	},
	[16530029] = {
		16530029,
		0,
		Lang.get(36154),
		16530,
		29,
		149,
		nil,
		1
	},
	[16530030] = {
		16530030,
		0,
		Lang.get(26978),
		16530,
		30,
		196,
		nil,
		1,
		2
	},
	[16530031] = {
		16530031,
		0,
		Lang.get(26979),
		16530,
		31,
		194,
		nil,
		1,
		2
	},
	[16530032] = {
		16530032,
		0,
		Lang.get(26980),
		16530,
		32,
		133,
		nil,
		1,
		0
	},
	[16530033] = {
		16530033,
		0,
		Lang.get(26981),
		16530,
		33,
		150,
		nil,
		1,
		0
	},
	[16530034] = {
		16530034,
		5,
		Lang.get(26982),
		16530,
		34,
		119,
		nil,
		1,
		7
	},
	[16530035] = {
		16530035,
		0,
		Lang.get(26983),
		16530,
		35,
		150,
		nil,
		1,
		0
	},
	[16530036] = {
		16530036,
		0,
		Lang.get(26984),
		16530,
		36,
		134,
		nil,
		1,
		2
	},
	[16530037] = {
		16530037,
		0,
		Lang.get(45483),
		16530,
		37,
		107,
		nil,
		1,
		8
	},
	[16530038] = {
		16530038,
		5,
		Lang.get(26986),
		16530,
		38,
		133,
		nil,
		1,
		1
	},
	[16540001] = {
		16540001,
		3,
		Lang.get(26987),
		16540,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		49,
		16540,
		1,
		nil,
		1,
		1227,
		16540,
		nil,
		nil,
		1
	},
	[16540002] = {
		16540002,
		0,
		Lang.get(26988),
		16540,
		2,
		107,
		{
			RTResTalkAction[103]
		},
		nil,
		nil,
		3
	},
	[16540003] = {
		16540003,
		0,
		Lang.get(26989),
		16540,
		3,
		141,
		{
			RTResTalkAction[108],
			RTResTalkAction[129]
		}
	},
	[16540004] = {
		16540004,
		0,
		Lang.get(26990),
		16540,
		4,
		119,
		{
			RTResTalkAction[92],
			RTResTalkAction[78],
			RTResTalkAction[101]
		}
	},
	[16540005] = {
		16540005,
		0,
		Lang.get(26991),
		16540,
		5,
		179,
		{
			RTResTalkAction[177],
			RTResTalkAction[85]
		},
		[17] = 1227
	},
	[16540006] = {
		16540006,
		0,
		Lang.get(26992),
		16540,
		6,
		149,
		{
			RTResTalkAction[178],
			RTResTalkAction[170]
		}
	},
	[16540007] = {
		16540007,
		0,
		Lang.get(26993),
		16540,
		7,
		158,
		{
			RTResTalkAction[282],
			RTResTalkAction[179],
			RTResTalkAction[172]
		}
	},
	[16540008] = {
		16540008,
		5,
		Lang.get(26994),
		16540,
		8,
		107,
		{
			RTResTalkAction[90],
			RTResTalkAction[9]
		}
	},
	[16540009] = {
		16540009,
		0,
		Lang.get(26995),
		16540,
		9,
		134,
		{
			RTResTalkAction[108],
			RTResTalkAction[94]
		}
	},
	[16540010] = {
		16540010,
		5,
		Lang.get(26996),
		16540,
		10,
		559,
		{
			RTResTalkAction[139],
			RTResTalkAction[78],
			RTResTalkAction[84]
		}
	},
	[16540011] = {
		16540011,
		0,
		Lang.get(26997),
		16540,
		11,
		119,
		{
			RTResTalkAction[290],
			RTResTalkAction[143]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		16541,
		0.5,
		1,
		nil,
		nil,
		16541
	},
	[16540012] = {
		16540012,
		0,
		Lang.get(26998),
		16540,
		12,
		150,
		{
			RTResTalkAction[93],
			RTResTalkAction[192]
		}
	},
	[16540013] = {
		16540013,
		0,
		Lang.get(26999),
		16540,
		13,
		128,
		{
			RTResTalkAction[330],
			RTResTalkAction[85],
			RTResTalkAction[125]
		}
	},
	[16540014] = {
		16540014,
		0,
		Lang.get(27000),
		16540,
		14,
		140,
		{
			RTResTalkAction[171],
			RTResTalkAction[175]
		}
	},
	[16540015] = {
		16540015,
		5,
		Lang.get(27001),
		16540,
		15,
		579,
		{
			RTResTalkAction[276],
			RTResTalkAction[168]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		16542,
		0.5,
		1,
		1,
		nil,
		16542
	},
	[16540016] = {
		16540016,
		5,
		Lang.get(27002),
		16540,
		16,
		581,
		{
			RTResTalkAction[280],
			RTResTalkAction[281]
		},
		nil,
		nil,
		3
	},
	[16540017] = {
		16540017,
		0,
		Lang.get(27003),
		16540,
		17,
		123,
		{
			RTResTalkAction[154],
			RTResTalkAction[266],
			RTResTalkAction[268]
		}
	},
	[16540018] = {
		16540018,
		0,
		Lang.get(32955),
		16540,
		18,
		187,
		{
			RTResTalkAction[184],
			RTResTalkAction[188]
		}
	},
	[16540019] = {
		16540019,
		0,
		Lang.get(27005),
		16540,
		19,
		207,
		{
			RTResTalkAction[147],
			RTResTalkAction[151],
			RTResTalkAction[153]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		16543,
		1,
		1,
		1,
		nil,
		16543
	},
	[16540020] = {
		16540020,
		0,
		Lang.get(27006),
		16540,
		20,
		143,
		{
			RTResTalkAction[345],
			RTResTalkAction[346]
		},
		nil,
		nil,
		3
	},
	[16540021] = {
		16540021,
		0,
		Lang.get(27007),
		16540,
		21,
		141,
		{
			RTResTalkAction[284],
			RTResTalkAction[149],
			RTResTalkAction[146]
		}
	},
	[16540022] = {
		16540022,
		0,
		Lang.get(27008),
		16540,
		22,
		133,
		{
			RTResTalkAction[347],
			RTResTalkAction[102]
		}
	},
	[16540023] = {
		16540023,
		0,
		Lang.get(27009),
		16540,
		23,
		107,
		{
			RTResTalkAction[348],
			RTResTalkAction[176],
			RTResTalkAction[349]
		}
	},
	[16540024] = {
		16540024,
		3,
		Lang.get(27010),
		16540,
		24,
		107,
		{
			RTResTalkAction[101],
			RTResTalkAction[78],
			RTResTalkAction[89]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		nil,
		nil,
		1,
		1,
		1227,
		16531,
		nil,
		nil,
		1
	},
	[16540025] = {
		16540025,
		3,
		Lang.get(27011),
		16540,
		25,
		107,
		[21] = 1
	},
	[16590001] = {
		16590001,
		10,
		"22",
		16590,
		1,
		107,
		nil,
		nil,
		nil,
		3,
		nil,
		62,
		16950,
		nil,
		nil,
		1,
		nil,
		16950
	},
	[16590002] = {
		16590002,
		0,
		Lang.get(32022),
		16590,
		2,
		107,
		nil,
		1,
		nil,
		-1
	},
	[16590003] = {
		16590003,
		0,
		Lang.get(32023),
		16590,
		3,
		141,
		{
			RTResTalkAction[99]
		},
		nil,
		nil,
		3
	},
	[16590004] = {
		16590004,
		0,
		Lang.get(32024),
		16590,
		4,
		107,
		{
			RTResTalkAction[350],
			RTResTalkAction[129]
		}
	},
	[16590005] = {
		16590005,
		0,
		Lang.get(32025),
		16590,
		5,
		141,
		{
			RTResTalkAction[108],
			RTResTalkAction[129]
		}
	},
	[16590006] = {
		16590006,
		0,
		Lang.get(32026),
		16590,
		6,
		141,
		{
			RTResTalkAction[108],
			RTResTalkAction[351]
		}
	},
	[16590007] = {
		16590007,
		0,
		Lang.get(32027),
		16590,
		7,
		107,
		{
			RTResTalkAction[352],
			RTResTalkAction[129]
		}
	},
	[16590008] = {
		16590008,
		0,
		Lang.get(32028),
		16590,
		8,
		107,
		{
			RTResTalkAction[353],
			RTResTalkAction[129]
		}
	},
	[16590009] = {
		16590009,
		0,
		Lang.get(32029),
		16590,
		9,
		107,
		{
			RTResTalkAction[354],
			RTResTalkAction[129]
		}
	},
	[16590010] = {
		16590010,
		0,
		Lang.get(32030),
		16590,
		10,
		141,
		{
			RTResTalkAction[108],
			RTResTalkAction[355]
		}
	},
	[16590011] = {
		16590011,
		0,
		Lang.get(32031),
		16590,
		11,
		141,
		{
			RTResTalkAction[108],
			RTResTalkAction[129]
		}
	},
	[16590012] = {
		16590012,
		0,
		Lang.get(32032),
		16590,
		12,
		107,
		{
			RTResTalkAction[356],
			RTResTalkAction[129]
		}
	},
	[16590013] = {
		16590013,
		0,
		Lang.get(32033),
		16590,
		13,
		141,
		{
			RTResTalkAction[108],
			RTResTalkAction[351]
		}
	},
	[16590014] = {
		16590014,
		0,
		Lang.get(32034),
		16590,
		14,
		141,
		{
			RTResTalkAction[108],
			RTResTalkAction[129]
		}
	},
	[16590015] = {
		16590015,
		0,
		Lang.get(32035),
		16590,
		15,
		107,
		{
			RTResTalkAction[357],
			RTResTalkAction[101]
		}
	},
	[16590016] = {
		16590016,
		9,
		Lang.get(32036),
		16590,
		16,
		605,
		{
			RTResTalkAction[78]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		1,
		1227,
		16951,
		nil,
		nil,
		1
	},
	[16590017] = {
		16590017,
		0,
		Lang.get(32037),
		16590,
		17,
		107,
		nil,
		1,
		7
	},
	[16590018] = {
		16590018,
		0,
		Lang.get(32038),
		16590,
		18,
		141,
		nil,
		1,
		1
	},
	[16590019] = {
		16590019,
		0,
		Lang.get(32039),
		16590,
		19,
		107,
		nil,
		1,
		6
	},
	[16590020] = {
		16590020,
		0,
		Lang.get(32040),
		16590,
		20,
		107,
		nil,
		1,
		0
	},
	[16590021] = {
		16590021,
		0,
		Lang.get(23797),
		16590,
		21,
		141,
		nil,
		1,
		0
	},
	[16590022] = {
		16590022,
		0,
		Lang.get(32041),
		16590,
		22,
		141,
		nil,
		1
	},
	[16590023] = {
		16590023,
		0,
		Lang.get(32042),
		16590,
		23,
		107,
		nil,
		1,
		7
	},
	[16590024] = {
		16590024,
		0,
		Lang.get(32043),
		16590,
		24,
		107,
		nil,
		1
	},
	[16590025] = {
		16590025,
		0,
		Lang.get(32044),
		16590,
		25,
		107,
		nil,
		1,
		6
	},
	[16590026] = {
		16590026,
		0,
		"……",
		16590,
		26,
		141,
		nil,
		1,
		0
	},
	[16590027] = {
		16590027,
		0,
		Lang.get(32045),
		16590,
		27,
		141,
		nil,
		1
	},
	[16590028] = {
		16590028,
		0,
		Lang.get(32046),
		16590,
		28,
		141,
		nil,
		1
	},
	[16590029] = {
		16590029,
		0,
		Lang.get(32047),
		16590,
		29,
		107,
		nil,
		1,
		5
	},
	[16591001] = {
		16591001,
		10,
		"23",
		16591,
		1,
		107,
		nil,
		nil,
		nil,
		3,
		nil,
		62,
		16952,
		nil,
		nil,
		1,
		nil,
		16952
	},
	[16591002] = {
		16591002,
		0,
		Lang.get(32048),
		16591,
		2,
		107,
		nil,
		1,
		4,
		-1
	},
	[16591003] = {
		16591003,
		0,
		Lang.get(32049),
		16591,
		3,
		107,
		{
			RTResTalkAction[358]
		},
		nil,
		0,
		3
	},
	[16591004] = {
		16591004,
		0,
		Lang.get(32050),
		16591,
		4,
		141,
		{
			RTResTalkAction[108],
			RTResTalkAction[129]
		}
	},
	[16591005] = {
		16591005,
		0,
		Lang.get(32051),
		16591,
		5,
		107,
		{
			RTResTalkAction[353],
			RTResTalkAction[129]
		}
	},
	[16591006] = {
		16591006,
		0,
		Lang.get(32052),
		16591,
		6,
		107,
		{
			RTResTalkAction[359],
			RTResTalkAction[129]
		}
	},
	[16591007] = {
		16591007,
		0,
		Lang.get(32053),
		16591,
		7,
		107,
		{
			RTResTalkAction[360],
			RTResTalkAction[129]
		}
	},
	[16591008] = {
		16591008,
		0,
		Lang.get(32054),
		16591,
		8,
		107,
		{
			RTResTalkAction[108],
			RTResTalkAction[129]
		}
	},
	[16591009] = {
		16591009,
		0,
		Lang.get(32055),
		16591,
		9,
		107,
		{
			RTResTalkAction[353],
			RTResTalkAction[129]
		}
	},
	[16591010] = {
		16591010,
		0,
		Lang.get(32056),
		16591,
		10,
		107,
		{
			RTResTalkAction[360],
			RTResTalkAction[129]
		}
	},
	[16591011] = {
		16591011,
		0,
		Lang.get(32057),
		16591,
		11,
		107,
		{
			RTResTalkAction[354],
			RTResTalkAction[129]
		}
	},
	[16591012] = {
		16591012,
		9,
		Lang.get(32058),
		16591,
		12,
		605,
		{
			RTResTalkAction[78],
			RTResTalkAction[101]
		},
		nil,
		nil,
		nil,
		nil,
		128,
		nil,
		3,
		1,
		1,
		nil,
		16953,
		nil,
		nil,
		1
	},
	[16591013] = {
		16591013,
		9,
		"Say High♫",
		16591,
		13,
		605,
		[21] = 1
	},
	[16591014] = {
		16591014,
		9,
		Lang.get(32059),
		16591,
		14,
		605,
		[21] = 1
	},
	[16591015] = {
		16591015,
		9,
		Lang.get(32060),
		16591,
		15,
		605,
		[21] = 1
	},
	[16591016] = {
		16591016,
		9,
		Lang.get(32061),
		16591,
		16,
		605,
		[21] = 1
	},
	[16591017] = {
		16591017,
		0,
		Lang.get(32062),
		16591,
		17,
		107,
		nil,
		1,
		7,
		nil,
		nil,
		nil,
		16952,
		nil,
		nil,
		1,
		nil,
		16952
	},
	[16591018] = {
		16591018,
		0,
		Lang.get(32063),
		16591,
		18,
		141,
		{
			RTResTalkAction[284]
		},
		nil,
		nil,
		3
	},
	[16591019] = {
		16591019,
		0,
		Lang.get(32064),
		16591,
		19,
		141,
		{
			RTResTalkAction[108],
			RTResTalkAction[129]
		}
	},
	[16591020] = {
		16591020,
		0,
		Lang.get(32065),
		16591,
		20,
		107,
		{
			RTResTalkAction[361],
			RTResTalkAction[129]
		}
	},
	[16591021] = {
		16591021,
		0,
		Lang.get(32066),
		16591,
		21,
		107,
		{
			RTResTalkAction[360],
			RTResTalkAction[129]
		}
	},
	[16591022] = {
		16591022,
		0,
		Lang.get(32067),
		16591,
		22,
		107,
		{
			RTResTalkAction[108],
			RTResTalkAction[129]
		}
	},
	[16591023] = {
		16591023,
		0,
		Lang.get(18341),
		16591,
		23,
		107,
		{
			RTResTalkAction[354],
			RTResTalkAction[129]
		}
	},
	[16591024] = {
		16591024,
		0,
		Lang.get(32068),
		16591,
		24,
		141,
		{
			RTResTalkAction[108],
			RTResTalkAction[129]
		}
	},
	[16591025] = {
		16591025,
		0,
		Lang.get(32069),
		16591,
		25,
		107,
		{
			RTResTalkAction[353],
			RTResTalkAction[129]
		}
	},
	[16591026] = {
		16591026,
		9,
		Lang.get(32070),
		16591,
		26,
		605,
		{
			RTResTalkAction[78],
			RTResTalkAction[101]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		16954,
		nil,
		1,
		1,
		nil,
		16954,
		nil,
		nil,
		1
	},
	[16591027] = {
		16591027,
		0,
		Lang.get(31415),
		16591,
		27,
		204,
		{
			RTResTalkAction[96]
		},
		nil,
		nil,
		3
	},
	[16591028] = {
		16591028,
		0,
		Lang.get(32071),
		16591,
		28,
		107,
		{
			RTResTalkAction[362],
			RTResTalkAction[98]
		}
	},
	[16591029] = {
		16591029,
		0,
		Lang.get(32072),
		16591,
		29,
		107,
		{
			RTResTalkAction[107]
		},
		nil,
		1
	},
	[16591030] = {
		16591030,
		0,
		Lang.get(32073),
		16591,
		30,
		141,
		{
			RTResTalkAction[108],
			RTResTalkAction[363]
		},
		nil,
		0
	},
	[16591031] = {
		16591031,
		0,
		Lang.get(32074),
		16591,
		31,
		107,
		{
			RTResTalkAction[350],
			RTResTalkAction[129]
		}
	},
	[16591032] = {
		16591032,
		0,
		Lang.get(32075),
		16591,
		32,
		141,
		{
			RTResTalkAction[108],
			RTResTalkAction[129]
		}
	},
	[16591033] = {
		16591033,
		0,
		Lang.get(32076),
		16591,
		33,
		141,
		{
			RTResTalkAction[108],
			RTResTalkAction[351]
		}
	},
	[16591034] = {
		16591034,
		0,
		Lang.get(32077),
		16591,
		34,
		107,
		{
			RTResTalkAction[364],
			RTResTalkAction[129]
		}
	},
	[16591035] = {
		16591035,
		0,
		Lang.get(32078),
		16591,
		35,
		204,
		{
			RTResTalkAction[96],
			RTResTalkAction[78],
			RTResTalkAction[101]
		}
	},
	[16591036] = {
		16591036,
		0,
		Lang.get(32079),
		16591,
		36,
		107,
		{
			RTResTalkAction[365],
			RTResTalkAction[129],
			RTResTalkAction[98]
		}
	},
	[16592001] = {
		16592001,
		10,
		"24",
		16592,
		1,
		107,
		nil,
		nil,
		nil,
		nil,
		nil,
		127,
		[19] = 255
	},
	[16592002] = {
		16592002,
		9,
		Lang.get(32080),
		16592,
		2,
		605,
		[21] = 1
	},
	[16592003] = {
		16592003,
		9,
		Lang.get(32081),
		16592,
		3,
		605,
		[21] = 1
	},
	[16592004] = {
		16592004,
		9,
		Lang.get(32082),
		16592,
		4,
		605,
		[21] = 1
	},
	[16592005] = {
		16592005,
		9,
		"…………",
		16592,
		5,
		605,
		[21] = 1
	},
	[16592006] = {
		16592006,
		0,
		Lang.get(32083),
		16592,
		6,
		107,
		{
			RTResTalkAction[366]
		}
	},
	[16592007] = {
		16592007,
		0,
		Lang.get(32084),
		16592,
		7,
		107,
		{
			RTResTalkAction[124]
		}
	},
	[16592008] = {
		16592008,
		0,
		Lang.get(32085),
		16592,
		8,
		163,
		{
			RTResTalkAction[367],
			RTResTalkAction[78]
		}
	},
	[16592009] = {
		16592009,
		0,
		Lang.get(32086),
		16592,
		9,
		163,
		{
			RTResTalkAction[368]
		}
	},
	[16592010] = {
		16592010,
		0,
		Lang.get(32087),
		16592,
		10,
		107,
		{
			RTResTalkAction[197],
			RTResTalkAction[369]
		}
	},
	[16592011] = {
		16592011,
		0,
		Lang.get(32088),
		16592,
		11,
		107,
		{
			RTResTalkAction[116]
		}
	},
	[16592012] = {
		16592012,
		0,
		"3",
		16592,
		12,
		107,
		{
			RTResTalkAction[107]
		}
	},
	[16592013] = {
		16592013,
		0,
		"2",
		16592,
		13,
		107,
		{
			RTResTalkAction[76]
		}
	},
	[16592014] = {
		16592014,
		0,
		"1——",
		16592,
		14,
		107,
		{
			RTResTalkAction[124]
		}
	},
	[16592015] = {
		16592015,
		0,
		Lang.get(31396),
		16592,
		15,
		204,
		{
			RTResTalkAction[78]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		1,
		nil,
		16955,
		-1
	},
	[16592016] = {
		16592016,
		0,
		Lang.get(32089),
		16592,
		16,
		107,
		nil,
		1,
		5
	},
	[16592017] = {
		16592017,
		0,
		Lang.get(32090),
		16592,
		17,
		163,
		nil,
		1,
		1
	},
	[16592018] = {
		16592018,
		0,
		Lang.get(32091),
		16592,
		18,
		148,
		nil,
		1
	},
	[16592019] = {
		16592019,
		0,
		Lang.get(32092),
		16592,
		19,
		204,
		{
			RTResTalkAction[96]
		},
		nil,
		nil,
		15,
		nil,
		nil,
		nil,
		nil,
		1,
		[19] = 50
	},
	[16592020] = {
		16592020,
		0,
		Lang.get(32093),
		16592,
		20,
		204,
		{
			RTResTalkAction[96]
		}
	},
	[16592021] = {
		16592021,
		0,
		Lang.get(32094),
		16592,
		21,
		204,
		{
			RTResTalkAction[370]
		}
	},
	[16592022] = {
		16592022,
		9,
		Lang.get(32095),
		16592,
		22,
		605,
		{
			RTResTalkAction[98]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		nil,
		nil,
		1,
		[19] = -1,
		[21] = 1
	},
	[16592023] = {
		16592023,
		9,
		Lang.get(32096),
		16592,
		23,
		605,
		[21] = 1
	},
	[16592024] = {
		16592024,
		9,
		Lang.get(32097),
		16592,
		24,
		605,
		[21] = 1
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
