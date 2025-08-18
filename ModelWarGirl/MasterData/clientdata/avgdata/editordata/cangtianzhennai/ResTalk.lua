-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\cangtianzhennai\\ResTalk.lua

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
	[2] = 1059,
	[3] = {
		1
	}
}
RTResTalkAction[2] = {
	2,
	119,
	nil,
	nil,
	5
}
RTResTalkAction[3] = {
	[1] = 3,
	[2] = 1059
}
RTResTalkAction[4] = {
	2,
	119,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[5] = {
	[1] = 1,
	[2] = 1058
}
RTResTalkAction[6] = {
	[1] = 0,
	[2] = 119
}
RTResTalkAction[7] = {
	[1] = 0,
	[2] = 1059
}
RTResTalkAction[8] = {
	[1] = 1,
	[2] = 1056,
	[3] = {
		2
	}
}
RTResTalkAction[9] = {
	[1] = 0,
	[2] = 1058
}
RTResTalkAction[10] = {
	[1] = 1,
	[2] = 119
}
RTResTalkAction[11] = {
	1,
	119,
	{
		3
	},
	nil,
	7
}
RTResTalkAction[12] = {
	[1] = 2,
	[2] = 119
}
RTResTalkAction[13] = {
	[1] = 3,
	[2] = 1047
}
RTResTalkAction[14] = {
	2,
	119,
	{
		2
	},
	nil,
	5
}
RTResTalkAction[15] = {
	2,
	119,
	{
		2
	},
	nil,
	7
}
RTResTalkAction[16] = {
	2,
	119,
	{
		3
	},
	nil,
	7
}
RTResTalkAction[17] = {
	1,
	1047,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[18] = {
	1,
	1047,
	nil,
	nil,
	0
}
RTResTalkAction[19] = {
	[1] = 1,
	[2] = 1047
}
RTResTalkAction[20] = {
	2,
	119,
	nil,
	nil,
	0
}
RTResTalkAction[21] = {
	1,
	119,
	nil,
	nil,
	5
}
RTResTalkAction[22] = {
	[1] = 0,
	[2] = 1047
}
RTResTalkAction[23] = {
	[1] = 3,
	[2] = 1047,
	[3] = {
		2
	}
}
RTResTalkAction[24] = {
	[1] = 2,
	[2] = 119,
	[3] = {
		2
	}
}
RTResTalkAction[25] = {
	2,
	119,
	{
		2
	},
	nil,
	6
}
RTResTalkAction[26] = {
	2,
	119,
	{
		3
	},
	nil,
	5
}
RTResTalkAction[27] = {
	[1] = 3,
	[2] = 1047,
	[3] = {
		1
	}
}
RTResTalkAction[28] = {
	2,
	119,
	nil,
	nil,
	2
}
RTResTalkAction[29] = {
	1,
	119,
	nil,
	nil,
	0
}
RTResTalkAction[30] = {
	[1] = 1,
	[2] = 119,
	[3] = {
		2
	}
}
RTResTalkAction[31] = {
	[1] = 1,
	[2] = 1047,
	[3] = {
		2
	}
}
RTResTalkAction[32] = {
	1,
	119,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[33] = {
	[1] = 1,
	[2] = 376
}
RTResTalkAction[34] = {
	[1] = 0,
	[2] = 376
}
RTResTalkAction[35] = {
	[1] = 1,
	[2] = 1067
}
RTResTalkAction[36] = {
	[1] = 0,
	[2] = 1067
}
RTResTalkAction[37] = {
	1,
	119,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[38] = {
	[1] = 1,
	[2] = 1061
}
RTResTalkAction[39] = {
	[1] = 2,
	[2] = 1061
}
RTResTalkAction[40] = {
	[1] = 3,
	[2] = 1062
}
RTResTalkAction[41] = {
	[1] = 0,
	[2] = 1061
}
RTResTalkAction[42] = {
	[1] = 0,
	[2] = 1062
}
RTResTalkAction[43] = {
	[1] = 1,
	[2] = 421
}
RTResTalkAction[44] = {
	[1] = 1,
	[2] = 1060,
	[3] = {
		2
	}
}
RTResTalkAction[45] = {
	[1] = 0,
	[2] = 421
}
RTResTalkAction[46] = {
	[1] = 0,
	[2] = 1060
}
RTResTalkAction[47] = {
	[1] = 1,
	[2] = 1060
}
RTResTalkAction[48] = {
	1,
	119,
	nil,
	nil,
	1
}
RTResTalkAction[49] = {
	[1] = 1,
	[2] = 1060,
	[3] = {
		3
	}
}
RTResTalkAction[50] = {
	1,
	119,
	{
		3
	},
	nil,
	4
}
RTResTalkAction[51] = {
	[1] = 2,
	[2] = 1060
}
RTResTalkAction[52] = {
	[1] = 3,
	[2] = 119
}
RTResTalkAction[53] = {
	[1] = 1,
	[2] = 1052
}
RTResTalkAction[54] = {
	[1] = 1,
	[2] = 1052,
	[3] = {
		2
	}
}
RTResTalkAction[55] = {
	[1] = 2,
	[2] = 1047
}
RTResTalkAction[56] = {
	[1] = 3,
	[2] = 1052
}
RTResTalkAction[57] = {
	[1] = 3,
	[2] = 1052,
	[3] = {
		2
	}
}
RTResTalkAction[58] = {
	[1] = 2,
	[2] = 1047,
	[3] = {
		2
	}
}
RTResTalkAction[59] = {
	[1] = 0,
	[2] = 1052
}
RTResTalkAction[60] = {
	[1] = 1,
	[2] = 1066
}
RTResTalkAction[61] = {
	[1] = 0,
	[2] = 1066
}
RTResTalkAction[62] = {
	1,
	119,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[63] = {
	1,
	1065,
	nil,
	nil,
	0
}
RTResTalkAction[64] = {
	1,
	1065,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[65] = {
	[1] = 0,
	[2] = 1065
}
RTResTalkAction[66] = {
	1,
	1047,
	nil,
	nil,
	1
}
RTResTalkAction[67] = {
	[1] = 1,
	[2] = 1065
}
RTResTalkAction[68] = {
	[1] = 1,
	[2] = 1065,
	[3] = {
		2
	}
}
RTResTalkAction[69] = {
	1,
	1065,
	nil,
	nil,
	1
}
RTResTalkAction[70] = {
	[1] = 2,
	[2] = 1065
}
RTResTalkAction[71] = {
	3,
	1047,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[72] = {
	2,
	1065,
	nil,
	nil,
	0
}
RTResTalkAction[73] = {
	3,
	1047,
	nil,
	nil,
	0
}
RTResTalkAction[74] = {
	[1] = 2,
	[2] = 1065,
	[3] = {
		1001
	}
}
RTResTalkAction[75] = {
	2,
	1065,
	nil,
	nil,
	1
}
RTResTalkAction[76] = {
	2,
	1065,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[77] = {
	[1] = 3,
	[2] = 1047,
	[3] = {
		3
	}
}
RTResTalkAction[78] = {
	1,
	1048,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[79] = {
	[1] = 1,
	[2] = 46,
	[3] = {
		3
	}
}
RTResTalkAction[80] = {
	[1] = 0,
	[2] = 1048
}
RTResTalkAction[81] = {
	[1] = 1,
	[2] = 46
}
RTResTalkAction[82] = {
	1,
	119,
	{
		2
	},
	nil,
	5
}
RTResTalkAction[83] = {
	[1] = 0,
	[2] = 46
}
RTResTalkAction[84] = {
	1,
	1048,
	nil,
	nil,
	3
}
RTResTalkAction[85] = {
	[1] = 1,
	[2] = 1052,
	[3] = {
		3
	}
}
RTResTalkAction[86] = {
	[1] = 1,
	[2] = 46,
	[3] = {
		2
	}
}
RTResTalkAction[87] = {
	1,
	1048,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[88] = {
	[1] = 1,
	[2] = 1048
}
RTResTalkAction[89] = {
	[1] = 3,
	[2] = 1048
}
RTResTalkAction[90] = {
	1,
	119,
	nil,
	nil,
	2
}
RTResTalkAction[91] = {
	[1] = 1,
	[2] = 798
}
RTResTalkAction[92] = {
	[1] = 1,
	[2] = 1054
}
RTResTalkAction[93] = {
	[1] = 0,
	[2] = 798
}
RTResTalkAction[94] = {
	[1] = 2,
	[2] = 1054
}
RTResTalkAction[95] = {
	[1] = 3,
	[2] = 235
}
RTResTalkAction[96] = {
	[1] = 1,
	[2] = 798,
	[3] = {
		2
	}
}
RTResTalkAction[97] = {
	[1] = 0,
	[2] = 1054
}
RTResTalkAction[98] = {
	[1] = 0,
	[2] = 235
}
RTResTalkAction[99] = {
	[1] = 2,
	[2] = 798
}
RTResTalkAction[100] = {
	3,
	1048,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[101] = {
	3,
	1048,
	nil,
	nil,
	2
}
RTResTalkAction[102] = {
	3,
	1048,
	nil,
	nil,
	1
}
RTResTalkAction[103] = {
	1,
	632,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[104] = {
	[1] = 2,
	[2] = 632
}
RTResTalkAction[105] = {
	[1] = 3,
	[2] = 42,
	[3] = {
		3
	}
}
RTResTalkAction[106] = {
	[1] = 1,
	[2] = 1049
}
RTResTalkAction[107] = {
	[1] = 0,
	[2] = 632
}
RTResTalkAction[108] = {
	[1] = 0,
	[2] = 42
}
RTResTalkAction[109] = {
	[1] = 0,
	[2] = 1049
}
RTResTalkAction[110] = {
	1,
	119,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[111] = {
	1,
	1048,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[112] = {
	[1] = 2,
	[2] = 1048
}
RTResTalkAction[113] = {
	[1] = 3,
	[2] = 1049
}
RTResTalkAction[114] = {
	[1] = 1,
	[2] = 122,
	[3] = {
		2
	}
}
RTResTalkAction[115] = {
	1,
	632,
	nil,
	nil,
	1
}
RTResTalkAction[116] = {
	[1] = 0,
	[2] = 122
}
RTResTalkAction[117] = {
	[1] = 1,
	[2] = 46,
	[3] = {
		1
	}
}
RTResTalkAction[118] = {
	1,
	1048,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[119] = {
	[1] = 1,
	[2] = 1049,
	[3] = {
		2
	}
}
RTResTalkAction[120] = {
	1,
	632,
	nil,
	nil,
	4
}
RTResTalkAction[121] = {
	[1] = 3,
	[2] = 122
}
RTResTalkAction[122] = {
	1,
	119,
	{
		2
	},
	nil,
	7
}
RTResTalkAction[123] = {
	[1] = 1,
	[2] = 1064,
	[3] = {
		1004
	}
}
RTResTalkAction[124] = {
	[1] = 0,
	[2] = 1064
}
RTResTalkAction[125] = {
	[1] = 1,
	[2] = 1064
}
RTResTalkAction[126] = {
	2,
	1048,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[127] = {
	[1] = 3,
	[2] = 1064
}
RTResTalkAction[128] = {
	[1] = 1,
	[2] = 1064,
	[3] = {
		3
	}
}
RTResTalkAction[129] = {
	[1] = 2,
	[2] = 1064
}
RTResTalkAction[130] = {
	3,
	1048,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[131] = {
	[1] = 1,
	[2] = 1064,
	[3] = {
		1002
	}
}
RTResTalkAction[132] = {
	3,
	1048,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[133] = {
	2,
	1048,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[134] = {
	[1] = 3,
	[2] = 1064,
	[3] = {
		3
	}
}
RTResTalkAction[135] = {
	[1] = 1,
	[2] = 1063
}
RTResTalkAction[136] = {
	[1] = 1,
	[2] = 1063,
	[3] = {
		1
	}
}
RTResTalkAction[137] = {
	[1] = 1,
	[2] = 1055
}
RTResTalkAction[138] = {
	[1] = 0,
	[2] = 1063
}
RTResTalkAction[139] = {
	[1] = 2,
	[2] = 1055,
	[3] = {
		2
	}
}
RTResTalkAction[140] = {
	[1] = 3,
	[2] = 1063
}
RTResTalkAction[141] = {
	[1] = 0,
	[2] = 1055
}
RTResTalkAction[142] = {
	[1] = 1,
	[2] = 1050
}
RTResTalkAction[143] = {
	[1] = 0,
	[2] = 1050
}
RTResTalkAction[144] = {
	1,
	119,
	{
		1
	},
	nil,
	5
}
RTResTalkAction[145] = {
	[1] = 1,
	[2] = 1050,
	[3] = {
		1
	}
}
RTResTalkAction[146] = {
	2,
	1048,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[147] = {
	[1] = 3,
	[2] = 1050
}
RTResTalkAction[148] = {
	[1] = 2,
	[2] = 1050
}
RTResTalkAction[149] = {
	[1] = 3,
	[2] = 46,
	[3] = {
		3
	}
}
RTResTalkAction[150] = {
	[1] = 1,
	[2] = 119,
	[3] = {
		1
	}
}
RTResTalkAction[151] = {
	1,
	1048,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[152] = {
	[1] = 1,
	[2] = 1048,
	[3] = {
		3
	}
}
RTResTalkAction[153] = {
	[1] = 3,
	[2] = 1054
}
RTResTalkAction[154] = {
	[1] = 1,
	[2] = 1050,
	[3] = {
		3
	}
}
RTResTalkAction[155] = {
	2,
	1048,
	{
		3
	},
	nil,
	3
}
RTResTalkAction[156] = {
	[1] = 3,
	[2] = 1050,
	[3] = {
		3
	}
}
RTResTalkAction[157] = {
	[1] = 1,
	[2] = 1050,
	[3] = {
		1004
	}
}
RTResTalkAction[158] = {
	3,
	1048,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[159] = {
	[1] = 1,
	[2] = 1048,
	[3] = {
		2
	}
}
RTResTalkAction[160] = {
	1,
	1048,
	nil,
	nil,
	0
}
RTResTalkAction[161] = {
	2,
	119,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[162] = {
	3,
	1048,
	nil,
	nil,
	4
}
RTResTalkAction[163] = {
	1,
	119,
	nil,
	nil,
	6
}
RTResTalkAction[164] = {
	1,
	1048,
	{
		1001
	},
	nil,
	1
}
RTResTalkAction[165] = {
	[1] = 1,
	[2] = 1048,
	[3] = {
		1001
	}
}
RTResTalkAction[166] = {
	1,
	1048,
	nil,
	nil,
	1
}
RTResTalkAction[167] = {
	[1] = 1,
	[2] = 1048,
	[3] = {
		1
	}
}
RTResTalkAction[168] = {
	1,
	1048,
	{
		3
	},
	nil,
	3
}
RTResTalkAction[169] = {
	[1] = 1,
	[2] = 257
}
RTResTalkAction[170] = {
	[1] = 2,
	[2] = 257
}
RTResTalkAction[171] = {
	[1] = 3,
	[2] = 1066,
	[3] = {
		3
	}
}
RTResTalkAction[172] = {
	[1] = 3,
	[2] = 1066
}
RTResTalkAction[173] = {
	[1] = 1,
	[2] = 257,
	[3] = {
		2
	}
}
RTResTalkAction[174] = {
	[1] = 0,
	[2] = 257
}
RTResTalkAction[175] = {
	[1] = 3,
	[2] = 1055,
	[3] = {
		2
	}
}
RTResTalkAction[176] = {
	[1] = 2,
	[2] = 1052
}
RTResTalkAction[177] = {
	3,
	119,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[178] = {
	[1] = 2,
	[2] = 1052,
	[3] = {
		2
	}
}
RTResTalkAction[179] = {
	3,
	119,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[180] = {
	3,
	119,
	nil,
	nil,
	5
}
RTResTalkAction[181] = {
	1,
	119,
	{
		1
	},
	nil,
	7
}
RTResTalkAction[182] = {
	1,
	1048,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[183] = {
	[1] = 1,
	[2] = 1051
}
RTResTalkAction[184] = {
	[1] = 1,
	[2] = 1051,
	[3] = {
		2
	}
}
RTResTalkAction[185] = {
	[1] = 0,
	[2] = 1051
}
RTResTalkAction[186] = {
	1,
	1048,
	nil,
	nil,
	2
}
RTResTalkAction[187] = {
	2,
	1048,
	nil,
	nil,
	0
}
RTResTalkAction[188] = {
	[1] = 3,
	[2] = 1055
}
RTResTalkAction[189] = {
	[1] = 1,
	[2] = 1055,
	[3] = {
		2
	}
}
RTResTalkAction[190] = {
	1,
	1048,
	{
		1
	},
	nil,
	3
}
RTResTalkAction[191] = {
	[1] = 1,
	[2] = 1055,
	[3] = {
		1
	}
}
RTResTalkAction[192] = {
	[1] = 1,
	[2] = 1052,
	[3] = {
		1
	}
}
RTResTalkAction[193] = {
	1,
	119,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[194] = {
	1,
	1048,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[195] = {
	[1] = 1,
	[2] = 140,
	[3] = {
		1
	}
}
RTResTalkAction[196] = {
	[1] = 1,
	[2] = 140
}
RTResTalkAction[197] = {
	[1] = 2,
	[2] = 140
}
RTResTalkAction[198] = {
	[1] = 1,
	[2] = 140,
	[3] = {
		2
	}
}
RTResTalkAction[199] = {
	[1] = 1,
	[2] = 1053,
	[3] = {
		2
	}
}
RTResTalkAction[200] = {
	[1] = 0,
	[2] = 140
}
RTResTalkAction[201] = {
	[1] = 1,
	[2] = 1053
}
RTResTalkAction[202] = {
	[1] = 0,
	[2] = 1053
}

local Data = {
	[32501001] = {
		32501001,
		0,
		Lang.get(82106),
		32501,
		1,
		116,
		nil,
		1,
		nil,
		nil,
		nil,
		163,
		32501,
		nil,
		nil,
		nil,
		nil,
		nil,
		32501,
		255
	},
	[32501002] = {
		32501002,
		0,
		Lang.get(82107),
		32501,
		2,
		116,
		nil,
		1
	},
	[32501003] = {
		32501003,
		0,
		Lang.get(82108),
		32501,
		3,
		116,
		nil,
		1
	},
	[32501004] = {
		32501004,
		0,
		Lang.get(82109),
		32501,
		4,
		116,
		nil,
		1
	},
	[32501005] = {
		32501005,
		0,
		Lang.get(82110),
		32501,
		5,
		116,
		nil,
		1,
		[20] = 100
	},
	[32501006] = {
		32501006,
		0,
		Lang.get(82111),
		32501,
		6,
		116,
		nil,
		1,
		[20] = 255
	},
	[32502001] = {
		32502001,
		3,
		Lang.get(82112),
		32502,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		32502,
		nil,
		nil,
		nil,
		1,
		nil,
		32502,
		200,
		nil,
		1
	},
	[32502002] = {
		32502002,
		0,
		Lang.get(82113),
		32502,
		2,
		1056,
		nil,
		1,
		[20] = 0
	},
	[32502003] = {
		32502003,
		0,
		Lang.get(82114),
		32502,
		3,
		1057,
		nil,
		1
	},
	[32502004] = {
		32502004,
		0,
		Lang.get(82115),
		32502,
		4,
		119,
		nil,
		1,
		1
	},
	[32502005] = {
		32502005,
		0,
		Lang.get(82116),
		32502,
		5,
		1058,
		nil,
		1
	},
	[32502006] = {
		32502006,
		0,
		Lang.get(82117),
		32502,
		6,
		119,
		nil,
		1,
		5
	},
	[32502007] = {
		32502007,
		0,
		Lang.get(82118),
		32502,
		7,
		119,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		32508
	},
	[32502008] = {
		32502008,
		0,
		Lang.get(82119),
		32502,
		8,
		1056,
		nil,
		1
	},
	[32502009] = {
		32502009,
		0,
		Lang.get(82120),
		32502,
		9,
		1056,
		nil,
		1
	},
	[32502010] = {
		32502010,
		0,
		Lang.get(82121),
		32502,
		10,
		1059,
		nil,
		1,
		nil,
		nil,
		nil,
		187
	},
	[32502011] = {
		32502011,
		0,
		Lang.get(22477),
		32502,
		11,
		1056,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		32503,
		[19] = 32503
	},
	[32502012] = {
		32502012,
		0,
		Lang.get(82122),
		32502,
		12,
		1057,
		nil,
		1
	},
	[32502013] = {
		32502013,
		0,
		Lang.get(82123),
		32502,
		13,
		1058,
		nil,
		1
	},
	[32502014] = {
		32502014,
		0,
		Lang.get(82124),
		32502,
		14,
		1059,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[32502015] = {
		32502015,
		0,
		Lang.get(82125),
		32502,
		15,
		119,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[32502016] = {
		32502016,
		0,
		Lang.get(82126),
		32502,
		16,
		119,
		{
			RTResTalkAction[4],
			RTResTalkAction[3]
		}
	},
	[32502017] = {
		32502017,
		0,
		Lang.get(82127),
		32502,
		17,
		1058,
		{
			RTResTalkAction[5],
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[32502018] = {
		32502018,
		0,
		Lang.get(82128),
		32502,
		18,
		1056,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[32503001] = {
		32503001,
		0,
		Lang.get(82129),
		32503,
		1,
		119,
		nil,
		1,
		5,
		nil,
		nil,
		62,
		32505,
		nil,
		nil,
		nil,
		nil,
		nil,
		32505
	},
	[32503002] = {
		32503002,
		0,
		Lang.get(82130),
		32503,
		2,
		1057,
		nil,
		1
	},
	[32503003] = {
		32503003,
		0,
		Lang.get(82131),
		32503,
		3,
		1056,
		nil,
		1
	},
	[32503004] = {
		32503004,
		0,
		Lang.get(82132),
		32503,
		4,
		1058,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		32506,
		[19] = 32506,
		[17] = 1
	},
	[32503005] = {
		32503005,
		0,
		Lang.get(82133),
		32503,
		5,
		119,
		nil,
		1,
		1
	},
	[32503006] = {
		32503006,
		0,
		Lang.get(82134),
		32503,
		6,
		119,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		32507,
		1,
		nil,
		nil,
		1,
		nil,
		32507
	},
	[32503007] = {
		32503007,
		0,
		Lang.get(82135),
		32503,
		7,
		1059,
		nil,
		1
	},
	[32503008] = {
		32503008,
		0,
		Lang.get(82136),
		32503,
		8,
		1059,
		nil,
		1
	},
	[32503009] = {
		32503009,
		7,
		"94",
		32503,
		9,
		1059
	},
	[32503010] = {
		32503010,
		0,
		Lang.get(82137),
		32503,
		10,
		119,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3
	},
	[32503011] = {
		32503011,
		5,
		Lang.get(82138),
		32503,
		11,
		119,
		{
			RTResTalkAction[11]
		}
	},
	[32504001] = {
		32504001,
		0,
		Lang.get(82139),
		32504,
		1,
		119,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3,
		nil,
		62,
		32510,
		1,
		nil,
		nil,
		nil,
		nil,
		32510
	},
	[32504002] = {
		32504002,
		0,
		Lang.get(82140),
		32504,
		2,
		1047,
		{
			RTResTalkAction[12],
			RTResTalkAction[13]
		}
	},
	[32504003] = {
		32504003,
		0,
		Lang.get(82141),
		32504,
		3,
		119,
		{
			RTResTalkAction[14],
			RTResTalkAction[13]
		}
	},
	[32504004] = {
		32504004,
		0,
		Lang.get(82142),
		32504,
		4,
		1047,
		{
			RTResTalkAction[12],
			RTResTalkAction[13]
		}
	},
	[32504005] = {
		32504005,
		0,
		Lang.get(82143),
		32504,
		5,
		119,
		{
			RTResTalkAction[15],
			RTResTalkAction[13]
		}
	},
	[32504006] = {
		32504006,
		0,
		Lang.get(82144),
		32504,
		6,
		119,
		{
			RTResTalkAction[16],
			RTResTalkAction[13]
		}
	},
	[32504007] = {
		32504007,
		0,
		Lang.get(82145),
		32504,
		7,
		1047,
		{
			RTResTalkAction[17],
			RTResTalkAction[6]
		}
	},
	[32504008] = {
		32504008,
		0,
		Lang.get(82146),
		32504,
		8,
		1047,
		{
			RTResTalkAction[18]
		}
	},
	[32504009] = {
		32504009,
		0,
		Lang.get(82147),
		32504,
		9,
		1047,
		{
			RTResTalkAction[19]
		}
	},
	[32504010] = {
		32504010,
		0,
		Lang.get(82148),
		32504,
		10,
		119,
		{
			RTResTalkAction[20],
			RTResTalkAction[13]
		}
	},
	[32504011] = {
		32504011,
		0,
		Lang.get(82149),
		32504,
		11,
		119,
		{
			RTResTalkAction[12],
			RTResTalkAction[13]
		}
	},
	[32504012] = {
		32504012,
		0,
		Lang.get(82150),
		32504,
		12,
		1047,
		{
			RTResTalkAction[12],
			RTResTalkAction[13]
		}
	},
	[32504013] = {
		32504013,
		0,
		Lang.get(82151),
		32504,
		13,
		119,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		32511,
		1,
		1,
		nil,
		nil,
		nil,
		32511
	},
	[32504014] = {
		32504014,
		0,
		Lang.get(82152),
		32504,
		14,
		1047,
		{
			RTResTalkAction[12],
			RTResTalkAction[23]
		}
	},
	[32504015] = {
		32504015,
		0,
		Lang.get(82153),
		32504,
		15,
		119,
		{
			RTResTalkAction[24],
			RTResTalkAction[13]
		}
	},
	[32504016] = {
		32504016,
		0,
		Lang.get(82154),
		32504,
		16,
		119,
		{
			RTResTalkAction[12],
			RTResTalkAction[13]
		}
	},
	[32504017] = {
		32504017,
		0,
		Lang.get(18794),
		32504,
		17,
		1047,
		{
			RTResTalkAction[12],
			RTResTalkAction[13]
		}
	},
	[32504018] = {
		32504018,
		0,
		Lang.get(82155),
		32504,
		18,
		119,
		{
			RTResTalkAction[12],
			RTResTalkAction[13]
		},
		nil,
		nil,
		nil,
		nil,
		63
	},
	[32504019] = {
		32504019,
		0,
		Lang.get(82156),
		32504,
		19,
		119,
		{
			RTResTalkAction[25],
			RTResTalkAction[13]
		}
	},
	[32504020] = {
		32504020,
		0,
		Lang.get(82157),
		32504,
		20,
		1047,
		{
			RTResTalkAction[12],
			RTResTalkAction[13]
		}
	},
	[32504021] = {
		32504021,
		0,
		Lang.get(82158),
		32504,
		21,
		119,
		{
			RTResTalkAction[26],
			RTResTalkAction[13]
		}
	},
	[32504022] = {
		32504022,
		0,
		Lang.get(82159),
		32504,
		22,
		1047,
		{
			RTResTalkAction[12],
			RTResTalkAction[27]
		}
	},
	[32504023] = {
		32504023,
		0,
		Lang.get(82160),
		32504,
		23,
		119,
		{
			RTResTalkAction[28],
			RTResTalkAction[13]
		},
		nil,
		nil,
		nil,
		nil,
		62
	},
	[32504024] = {
		32504024,
		0,
		Lang.get(82161),
		32504,
		24,
		1047,
		{
			RTResTalkAction[12],
			RTResTalkAction[23]
		}
	},
	[32504025] = {
		32504025,
		0,
		Lang.get(82162),
		32504,
		25,
		119,
		{
			RTResTalkAction[29],
			RTResTalkAction[22]
		}
	},
	[32504026] = {
		32504026,
		0,
		"|101|。",
		32504,
		26,
		119,
		{
			RTResTalkAction[30]
		}
	},
	[32505001] = {
		32505001,
		0,
		Lang.get(82163),
		32505,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		32515,
		[19] = 32515
	},
	[32505002] = {
		32505002,
		0,
		Lang.get(82164),
		32505,
		2,
		1047,
		{
			RTResTalkAction[31]
		},
		nil,
		nil,
		3
	},
	[32505003] = {
		32505003,
		0,
		Lang.get(82165),
		32505,
		3,
		300,
		{
			RTResTalkAction[19]
		}
	},
	[32505004] = {
		32505004,
		0,
		Lang.get(82166),
		32505,
		4,
		1047,
		{
			RTResTalkAction[19]
		}
	},
	[32505005] = {
		32505005,
		0,
		Lang.get(82167),
		32505,
		5,
		1047,
		{
			RTResTalkAction[19]
		}
	},
	[32505006] = {
		32505006,
		0,
		Lang.get(82168),
		32505,
		6,
		300,
		{
			RTResTalkAction[19]
		}
	},
	[32505007] = {
		32505007,
		0,
		Lang.get(82169),
		32505,
		7,
		119,
		{
			RTResTalkAction[10],
			RTResTalkAction[22]
		}
	},
	[32505008] = {
		32505008,
		3,
		Lang.get(82170),
		32505,
		8,
		605,
		{
			RTResTalkAction[10]
		},
		[22] = 1,
		[20] = 200
	},
	[32505009] = {
		32505009,
		0,
		Lang.get(82171),
		32505,
		9,
		300,
		{
			RTResTalkAction[10]
		},
		[20] = 0
	},
	[32505010] = {
		32505010,
		0,
		Lang.get(82172),
		32505,
		10,
		119,
		{
			RTResTalkAction[21]
		}
	},
	[32505011] = {
		32505011,
		0,
		Lang.get(82173),
		32505,
		11,
		119,
		{
			RTResTalkAction[32]
		}
	},
	[32505012] = {
		32505012,
		0,
		Lang.get(82174),
		32505,
		12,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[32505013] = {
		32505013,
		0,
		Lang.get(82175),
		32505,
		13,
		119,
		{
			RTResTalkAction[10]
		}
	},
	[32505014] = {
		32505014,
		4,
		nil,
		32505,
		14,
		300,
		{
			RTResTalkAction[10]
		},
		[29] = {
			{
				id = 32505015,
				branch_content = Lang.get(82176)
			},
			{
				id = 32505015,
				branch_content = Lang.get(82177)
			}
		}
	},
	[32505015] = {
		32505015,
		0,
		Lang.get(82178),
		32505,
		15,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[32505016] = {
		32505016,
		0,
		Lang.get(82179),
		32505,
		16,
		1047,
		{
			RTResTalkAction[19],
			RTResTalkAction[6]
		}
	},
	[32505017] = {
		32505017,
		0,
		Lang.get(82180),
		32505,
		17,
		119,
		{
			RTResTalkAction[30],
			RTResTalkAction[22]
		}
	},
	[32505018] = {
		32505018,
		0,
		Lang.get(82181),
		32505,
		18,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[32505019] = {
		32505019,
		0,
		nil,
		32505,
		19,
		376,
		{
			RTResTalkAction[33],
			RTResTalkAction[6]
		},
		nil,
		nil,
		nil,
		1225,
		[27] = 3
	},
	[32505020] = {
		32505020,
		0,
		Lang.get(82182),
		32505,
		20,
		119,
		{
			RTResTalkAction[10],
			RTResTalkAction[34]
		}
	},
	[32505021] = {
		32505021,
		0,
		Lang.get(82183),
		32505,
		21,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[32505022] = {
		32505022,
		13,
		Lang.get(82184),
		32505,
		22,
		1067,
		{
			RTResTalkAction[35]
		},
		[27] = 3
	},
	[32505023] = {
		32505023,
		0,
		Lang.get(82185),
		32505,
		23,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[32506001] = {
		32506001,
		13,
		Lang.get(82186),
		32506,
		1,
		1067,
		{
			RTResTalkAction[35]
		},
		nil,
		nil,
		3,
		nil,
		62,
		32520,
		nil,
		nil,
		nil,
		nil,
		nil,
		32520,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		3
	},
	[32506002] = {
		32506002,
		13,
		Lang.get(82187),
		32506,
		2,
		1067,
		{
			RTResTalkAction[35]
		},
		[27] = 3
	},
	[32506003] = {
		32506003,
		0,
		Lang.get(82188),
		32506,
		3,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[32506004] = {
		32506004,
		13,
		Lang.get(82189),
		32506,
		4,
		1067,
		{
			RTResTalkAction[35]
		},
		[27] = 3
	},
	[32506005] = {
		32506005,
		13,
		Lang.get(82190),
		32506,
		5,
		1067,
		{
			RTResTalkAction[35]
		},
		[27] = 3
	},
	[32506006] = {
		32506006,
		0,
		Lang.get(19646),
		32506,
		6,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[32506007] = {
		32506007,
		13,
		Lang.get(82191),
		32506,
		7,
		1067,
		{
			RTResTalkAction[35]
		},
		[27] = 3
	},
	[32506008] = {
		32506008,
		13,
		Lang.get(82192),
		32506,
		8,
		1067,
		{
			RTResTalkAction[35]
		},
		[27] = 3
	},
	[32506009] = {
		32506009,
		13,
		Lang.get(82193),
		32506,
		9,
		1067,
		{
			RTResTalkAction[35]
		},
		[27] = 3
	},
	[32506010] = {
		32506010,
		0,
		nil,
		32506,
		10,
		300,
		{
			RTResTalkAction[36]
		},
		[29] = {
			{
				id = 32506011,
				branch_content = Lang.get(82194)
			},
			{
				id = 32506011,
				branch_content = Lang.get(82195)
			}
		}
	},
	[32506011] = {
		32506011,
		13,
		Lang.get(82196),
		32506,
		11,
		1067,
		{
			RTResTalkAction[35]
		},
		[27] = 3
	},
	[32506012] = {
		32506012,
		0,
		Lang.get(82197),
		32506,
		12,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[32506013] = {
		32506013,
		13,
		Lang.get(82198),
		32506,
		13,
		1067,
		{
			RTResTalkAction[35]
		},
		[27] = 3
	},
	[32506014] = {
		32506014,
		0,
		Lang.get(82199),
		32506,
		14,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[32506015] = {
		32506015,
		0,
		Lang.get(82200),
		32506,
		15,
		119,
		{
			RTResTalkAction[10]
		}
	},
	[32506016] = {
		32506016,
		0,
		Lang.get(82201),
		32506,
		16,
		1047,
		{
			RTResTalkAction[12],
			RTResTalkAction[13]
		}
	},
	[32506017] = {
		32506017,
		0,
		Lang.get(82202),
		32506,
		17,
		300,
		{
			RTResTalkAction[6],
			RTResTalkAction[22]
		}
	},
	[32506018] = {
		32506018,
		13,
		Lang.get(82203),
		32506,
		18,
		1067,
		{
			RTResTalkAction[35]
		},
		[27] = 3
	},
	[32506019] = {
		32506019,
		13,
		Lang.get(82204),
		32506,
		19,
		1067,
		{
			RTResTalkAction[35]
		},
		[27] = 3
	},
	[32506020] = {
		32506020,
		0,
		Lang.get(25175),
		32506,
		20,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[32506021] = {
		32506021,
		13,
		Lang.get(82205),
		32506,
		21,
		1067,
		{
			RTResTalkAction[35]
		},
		[27] = 3
	},
	[32506022] = {
		32506022,
		0,
		Lang.get(82206),
		32506,
		22,
		119,
		{
			RTResTalkAction[10],
			RTResTalkAction[36]
		}
	},
	[32506023] = {
		32506023,
		13,
		Lang.get(82207),
		32506,
		23,
		1067,
		{
			RTResTalkAction[35],
			RTResTalkAction[6]
		},
		[27] = 3
	},
	[32506024] = {
		32506024,
		0,
		Lang.get(82208),
		32506,
		24,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[32506025] = {
		32506025,
		13,
		Lang.get(82209),
		32506,
		25,
		1067,
		{
			RTResTalkAction[35]
		},
		[27] = 3
	},
	[32506026] = {
		32506026,
		0,
		Lang.get(82210),
		32506,
		26,
		300,
		{
			RTResTalkAction[36]
		},
		nil,
		nil,
		nil,
		1226
	},
	[32506027] = {
		32506027,
		0,
		Lang.get(82211),
		32506,
		27,
		119,
		{
			RTResTalkAction[37]
		}
	},
	[32506028] = {
		32506028,
		0,
		Lang.get(82212),
		32506,
		28,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[32506029] = {
		32506029,
		0,
		Lang.get(82213),
		32506,
		29,
		1047,
		{
			RTResTalkAction[31]
		}
	},
	[32507001] = {
		32507001,
		0,
		Lang.get(82214),
		32507,
		1,
		1047,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		32525,
		1,
		nil,
		nil,
		nil,
		nil,
		32525
	},
	[32507002] = {
		32507002,
		0,
		Lang.get(82215),
		32507,
		2,
		119,
		nil,
		1
	},
	[32507003] = {
		32507003,
		0,
		Lang.get(82216),
		32507,
		3,
		1061,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		32526,
		1,
		nil,
		nil,
		1,
		nil,
		32526
	},
	[32507004] = {
		32507004,
		0,
		Lang.get(82217),
		32507,
		4,
		1062,
		nil,
		1
	},
	[32507005] = {
		32507005,
		0,
		Lang.get(82218),
		32507,
		5,
		1061,
		{
			RTResTalkAction[38]
		},
		nil,
		nil,
		3
	},
	[32507006] = {
		32507006,
		0,
		Lang.get(82219),
		32507,
		6,
		1062,
		{
			RTResTalkAction[39],
			RTResTalkAction[40]
		}
	},
	[32507007] = {
		32507007,
		0,
		Lang.get(82220),
		32507,
		7,
		1061,
		{
			RTResTalkAction[39],
			RTResTalkAction[40]
		}
	},
	[32507008] = {
		32507008,
		0,
		Lang.get(82221),
		32507,
		8,
		1061,
		{
			RTResTalkAction[39],
			RTResTalkAction[40]
		}
	},
	[32507009] = {
		32507009,
		0,
		Lang.get(82222),
		32507,
		9,
		1062,
		{
			RTResTalkAction[39],
			RTResTalkAction[40]
		}
	},
	[32507010] = {
		32507010,
		0,
		Lang.get(82223),
		32507,
		10,
		119,
		{
			RTResTalkAction[10],
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[32507011] = {
		32507011,
		0,
		Lang.get(82224),
		32507,
		11,
		1047,
		{
			RTResTalkAction[12],
			RTResTalkAction[13]
		}
	},
	[32507012] = {
		32507012,
		0,
		Lang.get(82225),
		32507,
		12,
		300,
		{
			RTResTalkAction[12],
			RTResTalkAction[13]
		}
	},
	[32507013] = {
		32507013,
		0,
		Lang.get(82226),
		32507,
		13,
		119,
		{
			RTResTalkAction[43],
			RTResTalkAction[6],
			RTResTalkAction[22]
		},
		1,
		5,
		3,
		nil,
		62,
		32527,
		1,
		1,
		nil,
		nil,
		nil,
		32527,
		nil,
		421
	},
	[32507014] = {
		32507014,
		0,
		Lang.get(82227),
		32507,
		14,
		1047,
		{
			RTResTalkAction[43]
		},
		1,
		[21] = 421
	},
	[32507015] = {
		32507015,
		0,
		Lang.get(82228),
		32507,
		15,
		119,
		{
			RTResTalkAction[43]
		},
		1,
		1,
		[21] = 421
	},
	[32507016] = {
		32507016,
		0,
		Lang.get(82229),
		32507,
		16,
		119,
		{
			RTResTalkAction[43]
		},
		1,
		0,
		[21] = 421
	},
	[32507017] = {
		32507017,
		0,
		Lang.get(82230),
		32507,
		17,
		1047,
		{
			RTResTalkAction[43]
		},
		1,
		[21] = 421
	},
	[32507018] = {
		32507018,
		0,
		Lang.get(82231),
		32507,
		18,
		119,
		{
			RTResTalkAction[43]
		},
		1,
		2,
		[21] = 421
	},
	[32507019] = {
		32507019,
		0,
		Lang.get(82232),
		32507,
		19,
		1060,
		{
			RTResTalkAction[44],
			RTResTalkAction[45]
		}
	},
	[32507020] = {
		32507020,
		0,
		Lang.get(82233),
		32507,
		20,
		1047,
		{
			RTResTalkAction[19],
			RTResTalkAction[46]
		}
	},
	[32507021] = {
		32507021,
		0,
		Lang.get(82234),
		32507,
		21,
		119,
		{
			RTResTalkAction[37],
			RTResTalkAction[22]
		}
	},
	[32507022] = {
		32507022,
		0,
		Lang.get(82235),
		32507,
		22,
		1060,
		{
			RTResTalkAction[47],
			RTResTalkAction[6]
		},
		nil,
		nil,
		nil,
		nil,
		60
	},
	[32507023] = {
		32507023,
		0,
		Lang.get(82236),
		32507,
		23,
		119,
		{
			RTResTalkAction[48],
			RTResTalkAction[46]
		}
	},
	[32507024] = {
		32507024,
		5,
		Lang.get(82237),
		32507,
		24,
		1060,
		{
			RTResTalkAction[49],
			RTResTalkAction[6]
		}
	},
	[32507025] = {
		32507025,
		0,
		Lang.get(17874),
		32507,
		25,
		119,
		{
			RTResTalkAction[11],
			RTResTalkAction[46]
		}
	},
	[32507026] = {
		32507026,
		0,
		Lang.get(82238),
		32507,
		26,
		1047,
		{
			RTResTalkAction[31],
			RTResTalkAction[6]
		}
	},
	[32507027] = {
		32507027,
		0,
		Lang.get(82239),
		32507,
		27,
		300,
		{
			RTResTalkAction[22]
		}
	},
	[32507028] = {
		32507028,
		0,
		Lang.get(82240),
		32507,
		28,
		1060,
		{
			RTResTalkAction[47]
		}
	},
	[32507029] = {
		32507029,
		0,
		Lang.get(82241),
		32507,
		29,
		119,
		{
			RTResTalkAction[50],
			RTResTalkAction[46]
		}
	},
	[32507030] = {
		32507030,
		0,
		Lang.get(82242),
		32507,
		30,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[32507031] = {
		32507031,
		0,
		Lang.get(82243),
		32507,
		31,
		1060,
		{
			RTResTalkAction[47]
		}
	},
	[32507032] = {
		32507032,
		0,
		Lang.get(82244),
		32507,
		32,
		119,
		{
			RTResTalkAction[51],
			RTResTalkAction[52]
		}
	},
	[32507033] = {
		32507033,
		0,
		Lang.get(82245),
		32507,
		33,
		1060,
		{
			RTResTalkAction[51],
			RTResTalkAction[52]
		}
	},
	[32507034] = {
		32507034,
		3,
		Lang.get(82246),
		32507,
		34,
		605,
		{
			RTResTalkAction[46],
			RTResTalkAction[6]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		32528,
		nil,
		nil,
		nil,
		nil,
		nil,
		32528,
		-1,
		nil,
		1
	},
	[32507035] = {
		32507035,
		0,
		Lang.get(82247),
		32507,
		35,
		1052,
		nil,
		1,
		nil,
		nil,
		nil,
		124
	},
	[32507036] = {
		32507036,
		0,
		Lang.get(82248),
		32507,
		36,
		1047,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		32529,
		[19] = 32529,
		[17] = 1
	},
	[32507037] = {
		32507037,
		0,
		Lang.get(82249),
		32507,
		37,
		1052,
		{
			RTResTalkAction[53]
		},
		nil,
		nil,
		3
	},
	[32507038] = {
		32507038,
		0,
		Lang.get(82250),
		32507,
		38,
		1052,
		{
			RTResTalkAction[54]
		}
	},
	[32508001] = {
		32508001,
		0,
		Lang.get(82251),
		32508,
		1,
		1052,
		nil,
		1,
		nil,
		nil,
		nil,
		124,
		32530,
		nil,
		nil,
		nil,
		nil,
		nil,
		32530
	},
	[32508002] = {
		32508002,
		0,
		Lang.get(82252),
		32508,
		2,
		1052,
		nil,
		1
	},
	[32508003] = {
		32508003,
		0,
		Lang.get(82253),
		32508,
		3,
		1047,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		3
	},
	[32508004] = {
		32508004,
		0,
		Lang.get(82254),
		32508,
		4,
		1052,
		{
			RTResTalkAction[55],
			RTResTalkAction[56]
		}
	},
	[32508005] = {
		32508005,
		0,
		Lang.get(82255),
		32508,
		5,
		1052,
		{
			RTResTalkAction[55],
			RTResTalkAction[57]
		}
	},
	[32508006] = {
		32508006,
		0,
		Lang.get(82256),
		32508,
		6,
		1047,
		{
			RTResTalkAction[55],
			RTResTalkAction[56]
		}
	},
	[32508007] = {
		32508007,
		0,
		Lang.get(82257),
		32508,
		7,
		1052,
		{
			RTResTalkAction[55],
			RTResTalkAction[57]
		}
	},
	[32508008] = {
		32508008,
		0,
		Lang.get(82258),
		32508,
		8,
		1047,
		{
			RTResTalkAction[58],
			RTResTalkAction[56]
		}
	},
	[32508009] = {
		32508009,
		0,
		Lang.get(82259),
		32508,
		9,
		1052,
		{
			RTResTalkAction[55],
			RTResTalkAction[56]
		}
	},
	[32508010] = {
		32508010,
		0,
		Lang.get(82260),
		32508,
		10,
		300,
		{
			RTResTalkAction[55],
			RTResTalkAction[56]
		}
	},
	[32508011] = {
		32508011,
		0,
		Lang.get(82261),
		32508,
		11,
		1047,
		{
			RTResTalkAction[19],
			RTResTalkAction[59]
		}
	},
	[32508012] = {
		32508012,
		0,
		Lang.get(82262),
		32508,
		12,
		119,
		{
			RTResTalkAction[37],
			RTResTalkAction[22]
		}
	},
	[32508013] = {
		32508013,
		0,
		Lang.get(82263),
		32508,
		13,
		1047,
		{
			RTResTalkAction[19],
			RTResTalkAction[6]
		}
	},
	[32508014] = {
		32508014,
		0,
		Lang.get(82264),
		32508,
		14,
		1047,
		{
			RTResTalkAction[31]
		}
	},
	[32508015] = {
		32508015,
		5,
		Lang.get(72746),
		32508,
		15,
		119,
		{
			RTResTalkAction[11],
			RTResTalkAction[22]
		}
	},
	[32509001] = {
		32509001,
		0,
		Lang.get(82265),
		32509,
		1,
		1066,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		32531,
		nil,
		nil,
		nil,
		nil,
		nil,
		32531
	},
	[32509002] = {
		32509002,
		0,
		Lang.get(82266),
		32509,
		2,
		300
	},
	[32509003] = {
		32509003,
		3,
		Lang.get(82267),
		32509,
		3,
		605,
		[22] = 1,
		[20] = 200
	},
	[32509004] = {
		32509004,
		0,
		Lang.get(82268),
		32509,
		4,
		1066,
		nil,
		1,
		[20] = 0
	},
	[32509005] = {
		32509005,
		0,
		Lang.get(82269),
		32509,
		5,
		300
	},
	[32509006] = {
		32509006,
		0,
		Lang.get(82270),
		32509,
		6,
		1066,
		{
			RTResTalkAction[60]
		},
		nil,
		nil,
		3
	},
	[32509007] = {
		32509007,
		0,
		Lang.get(82271),
		32509,
		7,
		300,
		{
			RTResTalkAction[60]
		}
	},
	[32509008] = {
		32509008,
		0,
		Lang.get(82272),
		32509,
		8,
		1066,
		{
			RTResTalkAction[60]
		}
	},
	[32509009] = {
		32509009,
		0,
		Lang.get(82273),
		32509,
		9,
		1066,
		{
			RTResTalkAction[60]
		}
	},
	[32509010] = {
		32509010,
		0,
		Lang.get(82274),
		32509,
		10,
		1066,
		{
			RTResTalkAction[60]
		}
	},
	[32509011] = {
		32509011,
		0,
		Lang.get(81780),
		32509,
		11,
		1047,
		{
			RTResTalkAction[19],
			RTResTalkAction[61]
		}
	},
	[32509012] = {
		32509012,
		0,
		Lang.get(82275),
		32509,
		12,
		1066,
		{
			RTResTalkAction[60],
			RTResTalkAction[22]
		}
	},
	[32509013] = {
		32509013,
		0,
		Lang.get(82276),
		32509,
		13,
		300,
		{
			RTResTalkAction[60]
		}
	},
	[32509014] = {
		32509014,
		0,
		Lang.get(20681),
		32509,
		14,
		1047,
		{
			RTResTalkAction[19],
			RTResTalkAction[61]
		}
	},
	[32509015] = {
		32509015,
		0,
		Lang.get(82277),
		32509,
		15,
		119,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[32509016] = {
		32509016,
		4,
		nil,
		32509,
		16,
		300,
		{
			RTResTalkAction[10]
		},
		[29] = {
			{
				id = 32509018,
				branch_content = Lang.get(82278)
			},
			{
				id = 32509017,
				branch_content = Lang.get(82279)
			}
		}
	},
	[32509017] = {
		32509017,
		0,
		Lang.get(82280),
		32509,
		17,
		119,
		{
			RTResTalkAction[62]
		}
	},
	[32509018] = {
		32509018,
		0,
		Lang.get(82281),
		32509,
		18,
		1047,
		{
			RTResTalkAction[31],
			RTResTalkAction[6]
		}
	},
	[32510001] = {
		32510001,
		0,
		Lang.get(82282),
		32510,
		1,
		1047,
		nil,
		1,
		nil,
		nil,
		nil,
		117,
		32535,
		nil,
		nil,
		nil,
		nil,
		nil,
		32535
	},
	[32510002] = {
		32510002,
		0,
		Lang.get(82283),
		32510,
		2,
		300,
		nil,
		1
	},
	[32510003] = {
		32510003,
		0,
		Lang.get(82284),
		32510,
		3,
		1065,
		nil,
		1
	},
	[32510004] = {
		32510004,
		0,
		Lang.get(82285),
		32510,
		4,
		300,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		32538,
		[19] = 32538,
		[17] = 1
	},
	[32510005] = {
		32510005,
		0,
		Lang.get(82286),
		32510,
		5,
		1065,
		nil,
		1,
		1
	},
	[32510006] = {
		32510006,
		0,
		Lang.get(82287),
		32510,
		6,
		300,
		nil,
		1
	},
	[32510007] = {
		32510007,
		0,
		Lang.get(82288),
		32510,
		7,
		1065,
		nil,
		1,
		1
	},
	[32510008] = {
		32510008,
		0,
		Lang.get(82289),
		32510,
		8,
		1065,
		nil,
		1,
		1
	},
	[32510009] = {
		32510009,
		2,
		Lang.get(82290),
		32510,
		9,
		1047,
		{
			RTResTalkAction[31]
		},
		nil,
		nil,
		3
	},
	[32510010] = {
		32510010,
		0,
		Lang.get(82291),
		32510,
		10,
		1065,
		{
			RTResTalkAction[63],
			RTResTalkAction[22]
		}
	},
	[32510011] = {
		32510011,
		0,
		Lang.get(82292),
		32510,
		11,
		1065,
		{
			RTResTalkAction[64]
		}
	},
	[32510012] = {
		32510012,
		0,
		Lang.get(82293),
		32510,
		12,
		300,
		{
			RTResTalkAction[65]
		}
	},
	[32510013] = {
		32510013,
		0,
		Lang.get(82294),
		32510,
		13,
		1065,
		nil,
		1,
		0,
		nil,
		nil,
		60,
		32536,
		1,
		1,
		nil,
		1,
		nil,
		32536
	},
	[32510014] = {
		32510014,
		2,
		Lang.get(82295),
		32510,
		14,
		1047,
		nil,
		1
	},
	[32510015] = {
		32510015,
		0,
		Lang.get(82296),
		32510,
		15,
		1065,
		nil,
		1,
		1
	},
	[32510016] = {
		32510016,
		2,
		Lang.get(82297),
		32510,
		16,
		1047,
		{
			RTResTalkAction[66]
		},
		nil,
		nil,
		3
	},
	[32510017] = {
		32510017,
		0,
		Lang.get(82298),
		32510,
		17,
		300,
		{
			RTResTalkAction[22]
		}
	},
	[32510018] = {
		32510018,
		0,
		Lang.get(82299),
		32510,
		18,
		1065,
		{
			RTResTalkAction[67]
		}
	},
	[32510019] = {
		32510019,
		0,
		Lang.get(82300),
		32510,
		19,
		1065,
		{
			RTResTalkAction[68]
		}
	},
	[32510020] = {
		32510020,
		0,
		Lang.get(82301),
		32510,
		20,
		1065,
		{
			RTResTalkAction[69]
		}
	},
	[32510021] = {
		32510021,
		0,
		Lang.get(82302),
		32510,
		21,
		1047,
		{
			RTResTalkAction[70],
			RTResTalkAction[71]
		}
	},
	[32510022] = {
		32510022,
		0,
		Lang.get(82303),
		32510,
		22,
		1065,
		{
			RTResTalkAction[72],
			RTResTalkAction[13]
		}
	},
	[32510023] = {
		32510023,
		0,
		Lang.get(82304),
		32510,
		23,
		1065,
		{
			RTResTalkAction[70],
			RTResTalkAction[13]
		}
	},
	[32510024] = {
		32510024,
		0,
		Lang.get(82305),
		32510,
		24,
		1047,
		{
			RTResTalkAction[70],
			RTResTalkAction[13]
		}
	},
	[32510025] = {
		32510025,
		0,
		Lang.get(82306),
		32510,
		25,
		300,
		{
			RTResTalkAction[65],
			RTResTalkAction[22]
		}
	},
	[32510026] = {
		32510026,
		0,
		Lang.get(82307),
		32510,
		26,
		1065,
		{
			RTResTalkAction[67]
		}
	},
	[32510027] = {
		32510027,
		0,
		Lang.get(82308),
		32510,
		27,
		1047,
		{
			RTResTalkAction[70],
			RTResTalkAction[73]
		}
	},
	[32510028] = {
		32510028,
		0,
		Lang.get(82309),
		32510,
		28,
		300,
		{
			RTResTalkAction[70],
			RTResTalkAction[13]
		}
	},
	[32510029] = {
		32510029,
		0,
		Lang.get(82310),
		32510,
		29,
		1065,
		{
			RTResTalkAction[74],
			RTResTalkAction[13]
		}
	},
	[32510030] = {
		32510030,
		2,
		Lang.get(82311),
		32510,
		30,
		1047,
		{
			RTResTalkAction[70],
			RTResTalkAction[13]
		}
	},
	[32510031] = {
		32510031,
		0,
		Lang.get(19557),
		32510,
		31,
		1047,
		{
			RTResTalkAction[70],
			RTResTalkAction[23]
		}
	},
	[32510032] = {
		32510032,
		0,
		Lang.get(82312),
		32510,
		32,
		1047,
		{
			RTResTalkAction[70],
			RTResTalkAction[13]
		}
	},
	[32510033] = {
		32510033,
		0,
		Lang.get(82313),
		32510,
		33,
		1065,
		{
			RTResTalkAction[75],
			RTResTalkAction[13]
		}
	},
	[32510034] = {
		32510034,
		0,
		Lang.get(82314),
		32510,
		34,
		1065,
		{
			RTResTalkAction[72],
			RTResTalkAction[13]
		}
	},
	[32510035] = {
		32510035,
		0,
		Lang.get(82315),
		32510,
		35,
		300,
		{
			RTResTalkAction[70],
			RTResTalkAction[13]
		}
	},
	[32510036] = {
		32510036,
		0,
		Lang.get(82316),
		32510,
		36,
		1065,
		{
			RTResTalkAction[76],
			RTResTalkAction[13]
		}
	},
	[32510037] = {
		32510037,
		5,
		Lang.get(82317),
		32510,
		37,
		1047,
		{
			RTResTalkAction[70],
			RTResTalkAction[77]
		}
	},
	[32510038] = {
		32510038,
		3,
		Lang.get(82318),
		32510,
		38,
		605,
		{
			RTResTalkAction[65],
			RTResTalkAction[22]
		},
		nil,
		nil,
		nil,
		nil,
		162,
		32537,
		1,
		1,
		nil,
		nil,
		nil,
		32537,
		200,
		nil,
		1
	},
	[32510039] = {
		32510039,
		0,
		Lang.get(82319),
		32510,
		39,
		1048,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		nil,
		0
	},
	[32510040] = {
		32510040,
		4,
		nil,
		32510,
		40,
		300,
		[29] = {
			{
				id = 32510041,
				branch_content = Lang.get(82320)
			},
			{
				id = 32510041,
				branch_content = Lang.get(82321)
			}
		}
	},
	[32510041] = {
		32510041,
		0,
		Lang.get(19533),
		32510,
		41,
		1048,
		nil,
		1
	},
	[32511001] = {
		32511001,
		0,
		Lang.get(82322),
		32511,
		1,
		46,
		nil,
		1,
		nil,
		nil,
		nil,
		147,
		32540,
		nil,
		nil,
		nil,
		nil,
		nil,
		32540
	},
	[32511002] = {
		32511002,
		0,
		Lang.get(82323),
		32511,
		2,
		46,
		nil,
		1
	},
	[32511003] = {
		32511003,
		0,
		Lang.get(82324),
		32511,
		3,
		46,
		nil,
		1
	},
	[32511004] = {
		32511004,
		0,
		Lang.get(82325),
		32511,
		4,
		46,
		nil,
		1
	},
	[32511005] = {
		32511005,
		0,
		Lang.get(82326),
		32511,
		5,
		46,
		nil,
		1
	},
	[32511006] = {
		32511006,
		0,
		Lang.get(82327),
		32511,
		6,
		46,
		nil,
		1
	},
	[32511007] = {
		32511007,
		0,
		Lang.get(82328),
		32511,
		7,
		46,
		nil,
		1
	},
	[32511008] = {
		32511008,
		0,
		Lang.get(82329),
		32511,
		8,
		119,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		32541,
		nil,
		nil,
		nil,
		nil,
		nil,
		32541
	},
	[32511009] = {
		32511009,
		0,
		Lang.get(82330),
		32511,
		9,
		1052,
		nil,
		1
	},
	[32511010] = {
		32511010,
		0,
		Lang.get(82331),
		32511,
		10,
		1048,
		nil,
		1
	},
	[32511011] = {
		32511011,
		0,
		Lang.get(82332),
		32511,
		11,
		1052,
		nil,
		1
	},
	[32511012] = {
		32511012,
		0,
		Lang.get(82333),
		32511,
		12,
		1048,
		nil,
		1
	},
	[32511013] = {
		32511013,
		0,
		Lang.get(82334),
		32511,
		13,
		119,
		nil,
		1,
		5
	},
	[32511014] = {
		32511014,
		0,
		Lang.get(82335),
		32511,
		14,
		300
	},
	[32511015] = {
		32511015,
		0,
		Lang.get(82336),
		32511,
		15,
		46,
		nil,
		1
	},
	[32511016] = {
		32511016,
		0,
		Lang.get(82337),
		32511,
		16,
		46,
		nil,
		1
	},
	[32511017] = {
		32511017,
		0,
		Lang.get(82338),
		32511,
		17,
		46,
		nil,
		1
	},
	[32511018] = {
		32511018,
		0,
		Lang.get(82339),
		32511,
		18,
		1052,
		{
			RTResTalkAction[54]
		},
		nil,
		nil,
		3,
		nil,
		148
	},
	[32511019] = {
		32511019,
		0,
		Lang.get(82340),
		32511,
		19,
		1048,
		{
			RTResTalkAction[78],
			RTResTalkAction[59]
		}
	},
	[32511020] = {
		32511020,
		0,
		Lang.get(82341),
		32511,
		20,
		46,
		{
			RTResTalkAction[79],
			RTResTalkAction[80]
		}
	},
	[32512001] = {
		32512001,
		5,
		Lang.get(82342),
		32512,
		1,
		46,
		{
			RTResTalkAction[81]
		},
		nil,
		nil,
		3,
		1220,
		148,
		32545,
		1,
		nil,
		nil,
		nil,
		nil,
		32545
	},
	[32512002] = {
		32512002,
		0,
		Lang.get(82343),
		32512,
		2,
		119,
		{
			RTResTalkAction[82],
			RTResTalkAction[83]
		}
	},
	[32512003] = {
		32512003,
		0,
		Lang.get(82344),
		32512,
		3,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[32512004] = {
		32512004,
		0,
		Lang.get(82345),
		32512,
		4,
		1052,
		{
			RTResTalkAction[54]
		},
		nil,
		nil,
		nil,
		1220
	},
	[32512005] = {
		32512005,
		0,
		Lang.get(82346),
		32512,
		5,
		1048,
		{
			RTResTalkAction[84],
			RTResTalkAction[59]
		}
	},
	[32512006] = {
		32512006,
		0,
		Lang.get(82347),
		32512,
		6,
		46,
		{
			RTResTalkAction[81],
			RTResTalkAction[80]
		}
	},
	[32512007] = {
		32512007,
		0,
		Lang.get(82348),
		32512,
		7,
		46,
		{
			RTResTalkAction[81]
		}
	},
	[32512008] = {
		32512008,
		0,
		Lang.get(82349),
		32512,
		8,
		1052,
		{
			RTResTalkAction[53],
			RTResTalkAction[83]
		},
		nil,
		nil,
		nil,
		1220
	},
	[32512009] = {
		32512009,
		0,
		Lang.get(82350),
		32512,
		9,
		1052,
		{
			RTResTalkAction[59]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		32546,
		1,
		1,
		nil,
		1,
		nil,
		32546
	},
	[32512010] = {
		32512010,
		0,
		Lang.get(82351),
		32512,
		10,
		46,
		nil,
		1
	},
	[32512011] = {
		32512011,
		0,
		Lang.get(82352),
		32512,
		11,
		1052,
		{
			RTResTalkAction[85]
		},
		nil,
		nil,
		3
	},
	[32512012] = {
		32512012,
		0,
		Lang.get(82353),
		32512,
		12,
		300,
		{
			RTResTalkAction[59]
		}
	},
	[32512013] = {
		32512013,
		0,
		Lang.get(82354),
		32512,
		13,
		119,
		{
			RTResTalkAction[29]
		}
	},
	[32512014] = {
		32512014,
		0,
		Lang.get(82355),
		32512,
		14,
		46,
		{
			RTResTalkAction[86],
			RTResTalkAction[6]
		}
	},
	[32512015] = {
		32512015,
		0,
		Lang.get(82356),
		32512,
		15,
		1052,
		{
			RTResTalkAction[85],
			RTResTalkAction[83]
		}
	},
	[32512016] = {
		32512016,
		0,
		Lang.get(82357),
		32512,
		16,
		1052,
		{
			RTResTalkAction[53]
		}
	},
	[32512017] = {
		32512017,
		0,
		Lang.get(82358),
		32512,
		17,
		1052,
		{
			RTResTalkAction[53]
		}
	},
	[32512018] = {
		32512018,
		0,
		Lang.get(82359),
		32512,
		18,
		46,
		{
			RTResTalkAction[81],
			RTResTalkAction[59]
		},
		nil,
		nil,
		nil,
		nil,
		142
	},
	[32512019] = {
		32512019,
		0,
		Lang.get(82360),
		32512,
		19,
		1048,
		{
			RTResTalkAction[87],
			RTResTalkAction[83]
		}
	},
	[32512020] = {
		32512020,
		3,
		Lang.get(82361),
		32512,
		20,
		605,
		{
			RTResTalkAction[80]
		},
		[22] = 1,
		[20] = 200
	},
	[32512021] = {
		32512021,
		0,
		Lang.get(82362),
		32512,
		21,
		1052,
		{
			RTResTalkAction[54]
		},
		[20] = 0
	},
	[32512022] = {
		32512022,
		0,
		Lang.get(82363),
		32512,
		22,
		1052,
		{
			RTResTalkAction[53]
		}
	},
	[32512023] = {
		32512023,
		0,
		Lang.get(82364),
		32512,
		23,
		1048,
		{
			RTResTalkAction[88],
			RTResTalkAction[59]
		}
	},
	[32512024] = {
		32512024,
		0,
		Lang.get(82365),
		32512,
		24,
		46,
		{
			RTResTalkAction[79],
			RTResTalkAction[80]
		}
	},
	[32512025] = {
		32512025,
		0,
		Lang.get(82366),
		32512,
		25,
		46,
		{
			RTResTalkAction[81]
		}
	},
	[32513001] = {
		32513001,
		0,
		Lang.get(82367),
		32513,
		1,
		119,
		nil,
		1,
		0,
		nil,
		nil,
		62,
		32550,
		nil,
		nil,
		nil,
		nil,
		nil,
		32550
	},
	[32513002] = {
		32513002,
		0,
		Lang.get(82368),
		32513,
		2,
		1048,
		nil,
		1
	},
	[32513003] = {
		32513003,
		0,
		Lang.get(82369),
		32513,
		3,
		119,
		{
			RTResTalkAction[10]
		}
	},
	[32513004] = {
		32513004,
		0,
		Lang.get(82370),
		32513,
		4,
		1048,
		{
			RTResTalkAction[12],
			RTResTalkAction[89]
		}
	},
	[32513005] = {
		32513005,
		2,
		Lang.get(82371),
		32513,
		5,
		119,
		{
			RTResTalkAction[12],
			RTResTalkAction[89]
		}
	},
	[32513006] = {
		32513006,
		0,
		Lang.get(82372),
		32513,
		6,
		119,
		{
			RTResTalkAction[30],
			RTResTalkAction[80]
		}
	},
	[32513007] = {
		32513007,
		0,
		Lang.get(82373),
		32513,
		7,
		119,
		{
			RTResTalkAction[10]
		}
	},
	[32513008] = {
		32513008,
		0,
		Lang.get(82374),
		32513,
		8,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[32513009] = {
		32513009,
		0,
		Lang.get(82375),
		32513,
		9,
		119,
		{
			RTResTalkAction[90]
		}
	},
	[32513010] = {
		32513010,
		0,
		Lang.get(82376),
		32513,
		10,
		119,
		{
			RTResTalkAction[90]
		}
	},
	[32513011] = {
		32513011,
		0,
		Lang.get(82377),
		32513,
		11,
		1048,
		{
			RTResTalkAction[20],
			RTResTalkAction[89]
		}
	},
	[32513012] = {
		32513012,
		0,
		Lang.get(82378),
		32513,
		12,
		119,
		{
			RTResTalkAction[62],
			RTResTalkAction[80]
		}
	},
	[32513013] = {
		32513013,
		3,
		Lang.get(82379),
		32513,
		13,
		605,
		{
			RTResTalkAction[6]
		},
		nil,
		nil,
		nil,
		nil,
		152,
		nil,
		nil,
		1,
		[22] = 1,
		[20] = 255
	},
	[32513014] = {
		32513014,
		0,
		Lang.get(82380),
		32513,
		14,
		798,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		32551,
		1,
		nil,
		nil,
		nil,
		nil,
		32551,
		0
	},
	[32513015] = {
		32513015,
		0,
		Lang.get(82381),
		32513,
		15,
		300
	},
	[32513016] = {
		32513016,
		0,
		Lang.get(82382),
		32513,
		16,
		798,
		nil,
		1
	},
	[32513017] = {
		32513017,
		0,
		Lang.get(82383),
		32513,
		17,
		798,
		{
			RTResTalkAction[91]
		},
		nil,
		nil,
		3
	},
	[32513018] = {
		32513018,
		0,
		Lang.get(82384),
		32513,
		18,
		1054,
		{
			RTResTalkAction[92],
			RTResTalkAction[93]
		}
	},
	[32513019] = {
		32513019,
		0,
		Lang.get(82385),
		32513,
		19,
		235,
		{
			RTResTalkAction[94],
			RTResTalkAction[95]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[32513020] = {
		32513020,
		0,
		Lang.get(82386),
		32513,
		20,
		798,
		{
			RTResTalkAction[96],
			RTResTalkAction[97],
			RTResTalkAction[98]
		}
	},
	[32513021] = {
		32513021,
		0,
		Lang.get(82387),
		32513,
		21,
		300,
		{
			RTResTalkAction[93]
		}
	},
	[32513022] = {
		32513022,
		0,
		Lang.get(82388),
		32513,
		22,
		798,
		{
			RTResTalkAction[91]
		}
	},
	[32513023] = {
		32513023,
		0,
		Lang.get(82389),
		32513,
		23,
		798,
		{
			RTResTalkAction[96]
		},
		nil,
		nil,
		nil,
		nil,
		122
	},
	[32513024] = {
		32513024,
		0,
		Lang.get(82390),
		32513,
		24,
		1048,
		{
			RTResTalkAction[99],
			RTResTalkAction[100]
		}
	},
	[32513025] = {
		32513025,
		0,
		Lang.get(82391),
		32513,
		25,
		798,
		{
			RTResTalkAction[99],
			RTResTalkAction[89]
		}
	},
	[32513026] = {
		32513026,
		0,
		Lang.get(18514),
		32513,
		26,
		1048,
		{
			RTResTalkAction[99],
			RTResTalkAction[101]
		}
	},
	[32513027] = {
		32513027,
		0,
		Lang.get(82392),
		32513,
		27,
		798,
		{
			RTResTalkAction[99],
			RTResTalkAction[89]
		}
	},
	[32513028] = {
		32513028,
		0,
		"……",
		32513,
		28,
		1048,
		{
			RTResTalkAction[99],
			RTResTalkAction[102]
		}
	},
	[32513029] = {
		32513029,
		0,
		Lang.get(82393),
		32513,
		29,
		798,
		{
			RTResTalkAction[96],
			RTResTalkAction[80]
		}
	},
	[32513030] = {
		32513030,
		0,
		Lang.get(82394),
		32513,
		30,
		798,
		{
			RTResTalkAction[91]
		}
	},
	[32513031] = {
		32513031,
		0,
		Lang.get(82395),
		32513,
		31,
		300,
		{
			RTResTalkAction[93]
		}
	},
	[32513032] = {
		32513032,
		0,
		Lang.get(82396),
		32513,
		32,
		798,
		{
			RTResTalkAction[96]
		}
	},
	[32513033] = {
		32513033,
		3,
		Lang.get(82397),
		32513,
		33,
		605,
		{
			RTResTalkAction[93]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		32552,
		1,
		1,
		nil,
		1,
		nil,
		32552,
		200,
		nil,
		1
	},
	[32513034] = {
		32513034,
		0,
		Lang.get(82398),
		32513,
		34,
		1066,
		{
			RTResTalkAction[60]
		},
		nil,
		nil,
		3,
		nil,
		147,
		[20] = 0
	},
	[32513035] = {
		32513035,
		0,
		Lang.get(82399),
		32513,
		35,
		1066,
		{
			RTResTalkAction[60]
		}
	},
	[32513036] = {
		32513036,
		5,
		Lang.get(82400),
		32513,
		36,
		1066,
		{
			RTResTalkAction[60]
		}
	},
	[32513037] = {
		32513037,
		0,
		Lang.get(82401),
		32513,
		37,
		300,
		{
			RTResTalkAction[61]
		}
	},
	[32513038] = {
		32513038,
		0,
		Lang.get(82402),
		32513,
		38,
		119,
		{
			RTResTalkAction[10]
		}
	},
	[32513039] = {
		32513039,
		3,
		Lang.get(82403),
		32513,
		39,
		605,
		{
			RTResTalkAction[6]
		},
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
	[32513040] = {
		32513040,
		0,
		Lang.get(82404),
		32513,
		40,
		1049,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		32553,
		1,
		nil,
		nil,
		nil,
		nil,
		32553
	},
	[32513041] = {
		32513041,
		0,
		Lang.get(82405),
		32513,
		41,
		46,
		nil,
		1
	},
	[32513042] = {
		32513042,
		2,
		Lang.get(82406),
		32513,
		42,
		1048,
		nil,
		1
	},
	[32514001] = {
		32514001,
		0,
		Lang.get(82407),
		32514,
		1,
		632,
		nil,
		1,
		1,
		nil,
		nil,
		148,
		32555,
		nil,
		nil,
		nil,
		nil,
		nil,
		32555
	},
	[32514002] = {
		32514002,
		0,
		Lang.get(82408),
		32514,
		2,
		122,
		nil,
		1
	},
	[32514003] = {
		32514003,
		0,
		Lang.get(82409),
		32514,
		3,
		632,
		{
			RTResTalkAction[103]
		},
		nil,
		nil,
		3
	},
	[32514004] = {
		32514004,
		0,
		Lang.get(82410),
		32514,
		4,
		42,
		{
			RTResTalkAction[104],
			RTResTalkAction[105]
		}
	},
	[32514005] = {
		32514005,
		0,
		Lang.get(82411),
		32514,
		5,
		1049,
		{
			RTResTalkAction[106],
			RTResTalkAction[107],
			RTResTalkAction[108]
		}
	},
	[32514006] = {
		32514006,
		0,
		Lang.get(82412),
		32514,
		6,
		119,
		{
			RTResTalkAction[48],
			RTResTalkAction[109]
		}
	},
	[32514007] = {
		32514007,
		0,
		Lang.get(82413),
		32514,
		7,
		119,
		{
			RTResTalkAction[110]
		}
	},
	[32514008] = {
		32514008,
		0,
		Lang.get(82414),
		32514,
		8,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[32514009] = {
		32514009,
		2,
		Lang.get(82415),
		32514,
		9,
		1048,
		{
			RTResTalkAction[84]
		}
	},
	[32514010] = {
		32514010,
		0,
		Lang.get(82416),
		32514,
		10,
		46,
		{
			RTResTalkAction[81],
			RTResTalkAction[80]
		}
	},
	[32514011] = {
		32514011,
		5,
		Lang.get(82417),
		32514,
		11,
		1048,
		{
			RTResTalkAction[111],
			RTResTalkAction[83]
		}
	},
	[32514012] = {
		32514012,
		0,
		Lang.get(82418),
		32514,
		12,
		1049,
		{
			RTResTalkAction[112],
			RTResTalkAction[113]
		}
	},
	[32514013] = {
		32514013,
		0,
		Lang.get(82419),
		32514,
		13,
		1048,
		{
			RTResTalkAction[111],
			RTResTalkAction[109]
		}
	},
	[32514014] = {
		32514014,
		0,
		Lang.get(82420),
		32514,
		14,
		122,
		{
			RTResTalkAction[114],
			RTResTalkAction[80]
		}
	},
	[32514015] = {
		32514015,
		0,
		Lang.get(82421),
		32514,
		15,
		632,
		{
			RTResTalkAction[115],
			RTResTalkAction[116]
		}
	},
	[32514016] = {
		32514016,
		0,
		Lang.get(82422),
		32514,
		16,
		46,
		{
			RTResTalkAction[81],
			RTResTalkAction[107]
		}
	},
	[32514017] = {
		32514017,
		0,
		Lang.get(82423),
		32514,
		17,
		1049,
		{
			RTResTalkAction[106],
			RTResTalkAction[83]
		}
	},
	[32514018] = {
		32514018,
		0,
		Lang.get(22381),
		32514,
		18,
		1049,
		{
			RTResTalkAction[106]
		}
	},
	[32514019] = {
		32514019,
		5,
		Lang.get(82424),
		32514,
		19,
		46,
		{
			RTResTalkAction[117],
			RTResTalkAction[109]
		}
	},
	[32515001] = {
		32515001,
		0,
		Lang.get(82425),
		32515,
		1,
		1048,
		{
			RTResTalkAction[118]
		},
		nil,
		nil,
		3,
		nil,
		119,
		32560,
		1,
		nil,
		nil,
		nil,
		nil,
		32560
	},
	[32515002] = {
		32515002,
		0,
		Lang.get(82426),
		32515,
		2,
		1048,
		{
			RTResTalkAction[88]
		}
	},
	[32515003] = {
		32515003,
		0,
		Lang.get(82427),
		32515,
		3,
		1049,
		{
			RTResTalkAction[119],
			RTResTalkAction[80]
		}
	},
	[32515004] = {
		32515004,
		2,
		Lang.get(82428),
		32515,
		4,
		1049,
		{
			RTResTalkAction[106]
		}
	},
	[32515005] = {
		32515005,
		0,
		Lang.get(82429),
		32515,
		5,
		119,
		{
			RTResTalkAction[10],
			RTResTalkAction[109]
		}
	},
	[32515006] = {
		32515006,
		0,
		Lang.get(24009),
		32515,
		6,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[32515007] = {
		32515007,
		0,
		Lang.get(82430),
		32515,
		7,
		119,
		{
			RTResTalkAction[30]
		}
	},
	[32515008] = {
		32515008,
		0,
		Lang.get(82431),
		32515,
		8,
		119,
		{
			RTResTalkAction[90]
		}
	},
	[32515009] = {
		32515009,
		0,
		Lang.get(82432),
		32515,
		9,
		1048,
		{
			RTResTalkAction[111],
			RTResTalkAction[6]
		},
		nil,
		nil,
		nil,
		nil,
		60
	},
	[32515010] = {
		32515010,
		5,
		Lang.get(82433),
		32515,
		10,
		46,
		{
			RTResTalkAction[81],
			RTResTalkAction[80]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[32515011] = {
		32515011,
		5,
		Lang.get(82434),
		32515,
		11,
		46,
		{
			RTResTalkAction[79]
		}
	},
	[32515012] = {
		32515012,
		0,
		Lang.get(82435),
		32515,
		12,
		632,
		{
			RTResTalkAction[120],
			RTResTalkAction[83]
		}
	},
	[32515013] = {
		32515013,
		0,
		Lang.get(82436),
		32515,
		13,
		122,
		{
			RTResTalkAction[104],
			RTResTalkAction[121]
		}
	},
	[32515014] = {
		32515014,
		0,
		Lang.get(82437),
		32515,
		14,
		46,
		{
			RTResTalkAction[81],
			RTResTalkAction[107],
			RTResTalkAction[116]
		}
	},
	[32515015] = {
		32515015,
		5,
		Lang.get(82438),
		32515,
		15,
		46,
		{
			RTResTalkAction[86]
		},
		nil,
		nil,
		nil,
		nil,
		142
	},
	[32515016] = {
		32515016,
		3,
		Lang.get(82439),
		32515,
		16,
		605,
		{
			RTResTalkAction[83]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[22] = 1,
		[20] = 255
	},
	[32515017] = {
		32515017,
		0,
		Lang.get(82440),
		32515,
		17,
		1064,
		nil,
		1,
		nil,
		nil,
		nil,
		147,
		32561,
		1,
		nil,
		nil,
		nil,
		nil,
		32561,
		0
	},
	[32515018] = {
		32515018,
		0,
		Lang.get(82441),
		32515,
		18,
		46,
		nil,
		1
	},
	[32515019] = {
		32515019,
		0,
		Lang.get(82442),
		32515,
		19,
		1064,
		nil,
		1
	},
	[32515020] = {
		32515020,
		0,
		Lang.get(82443),
		32515,
		20,
		46,
		nil,
		1
	},
	[32515021] = {
		32515021,
		0,
		Lang.get(82444),
		32515,
		21,
		1048,
		nil,
		1,
		2
	},
	[32516001] = {
		32516001,
		2,
		Lang.get(82445),
		32516,
		1,
		1048,
		nil,
		1,
		2,
		nil,
		nil,
		184,
		32565,
		nil,
		nil,
		nil,
		nil,
		nil,
		32565
	},
	[32516002] = {
		32516002,
		0,
		Lang.get(82446),
		32516,
		2,
		1064,
		nil,
		1
	},
	[32516003] = {
		32516003,
		0,
		Lang.get(82447),
		32516,
		3,
		46,
		nil,
		1
	},
	[32516004] = {
		32516004,
		0,
		Lang.get(82448),
		32516,
		4,
		46,
		nil,
		1
	},
	[32516005] = {
		32516005,
		0,
		Lang.get(82449),
		32516,
		5,
		119,
		{
			RTResTalkAction[21]
		},
		[20] = 3
	},
	[32516006] = {
		32516006,
		0,
		Lang.get(82450),
		32516,
		6,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[32516007] = {
		32516007,
		0,
		Lang.get(82451),
		32516,
		7,
		119,
		{
			RTResTalkAction[10]
		}
	},
	[32516008] = {
		32516008,
		5,
		Lang.get(82452),
		32516,
		8,
		119,
		{
			RTResTalkAction[122]
		}
	},
	[32516009] = {
		32516009,
		0,
		Lang.get(82453),
		32516,
		9,
		1048,
		{
			RTResTalkAction[6]
		},
		1,
		1,
		nil,
		nil,
		nil,
		32566,
		1,
		1,
		nil,
		nil,
		nil,
		32566
	},
	[32516010] = {
		32516010,
		0,
		Lang.get(82454),
		32516,
		10,
		1048,
		nil,
		1,
		3
	},
	[32516011] = {
		32516011,
		0,
		Lang.get(82455),
		32516,
		11,
		1064,
		{
			RTResTalkAction[123]
		},
		[20] = 3
	},
	[32516012] = {
		32516012,
		0,
		Lang.get(82456),
		32516,
		12,
		46,
		{
			RTResTalkAction[81],
			RTResTalkAction[124]
		}
	},
	[32516013] = {
		32516013,
		0,
		Lang.get(82457),
		32516,
		13,
		1064,
		{
			RTResTalkAction[125],
			RTResTalkAction[83]
		}
	},
	[32516014] = {
		32516014,
		0,
		Lang.get(82458),
		32516,
		14,
		1064,
		{
			RTResTalkAction[125]
		}
	},
	[32516015] = {
		32516015,
		0,
		Lang.get(82459),
		32516,
		15,
		1048,
		{
			RTResTalkAction[126],
			RTResTalkAction[127]
		}
	},
	[32516016] = {
		32516016,
		0,
		Lang.get(82460),
		32516,
		16,
		46,
		{
			RTResTalkAction[81],
			RTResTalkAction[80],
			RTResTalkAction[124]
		}
	},
	[32516017] = {
		32516017,
		0,
		Lang.get(82461),
		32516,
		17,
		46,
		{
			RTResTalkAction[79]
		}
	},
	[32517001] = {
		32517001,
		0,
		Lang.get(82462),
		32517,
		1,
		46,
		nil,
		1,
		nil,
		nil,
		nil,
		148,
		32570,
		nil,
		nil,
		nil,
		nil,
		nil,
		32570
	},
	[32517002] = {
		32517002,
		0,
		Lang.get(82463),
		32517,
		2,
		1064,
		nil,
		1
	},
	[32517003] = {
		32517003,
		0,
		Lang.get(82464),
		32517,
		3,
		1048,
		nil,
		1,
		3,
		nil,
		nil,
		nil,
		32571,
		1,
		nil,
		nil,
		0,
		nil,
		32571
	},
	[32517004] = {
		32517004,
		5,
		Lang.get(17874),
		32517,
		4,
		1064,
		{
			RTResTalkAction[128]
		},
		nil,
		nil,
		3
	},
	[32517005] = {
		32517005,
		0,
		Lang.get(82465),
		32517,
		5,
		46,
		{
			RTResTalkAction[81],
			RTResTalkAction[124]
		}
	},
	[32517006] = {
		32517006,
		0,
		Lang.get(82466),
		32517,
		6,
		119,
		{
			RTResTalkAction[10],
			RTResTalkAction[83]
		}
	},
	[32517007] = {
		32517007,
		0,
		Lang.get(82467),
		32517,
		7,
		1064,
		{
			RTResTalkAction[125],
			RTResTalkAction[6]
		}
	},
	[32517008] = {
		32517008,
		0,
		Lang.get(82468),
		32517,
		8,
		1048,
		{
			RTResTalkAction[129],
			RTResTalkAction[130]
		}
	},
	[32517009] = {
		32517009,
		0,
		Lang.get(82469),
		32517,
		9,
		46,
		{
			RTResTalkAction[117],
			RTResTalkAction[124],
			RTResTalkAction[80]
		}
	},
	[32517010] = {
		32517010,
		0,
		Lang.get(82470),
		32517,
		10,
		1064,
		{
			RTResTalkAction[123],
			RTResTalkAction[83]
		}
	},
	[32517011] = {
		32517011,
		0,
		Lang.get(82471),
		32517,
		11,
		1064,
		{
			RTResTalkAction[125]
		}
	},
	[32517012] = {
		32517012,
		0,
		Lang.get(82472),
		32517,
		12,
		1048,
		{
			RTResTalkAction[78],
			RTResTalkAction[124]
		}
	},
	[32517013] = {
		32517013,
		3,
		Lang.get(82473),
		32517,
		13,
		605,
		{
			RTResTalkAction[80]
		},
		nil,
		nil,
		nil,
		1217,
		[22] = 1
	},
	[32517014] = {
		32517014,
		0,
		Lang.get(82474),
		32517,
		14,
		1064,
		{
			RTResTalkAction[131]
		},
		1,
		nil,
		nil,
		1217
	},
	[32517015] = {
		32517015,
		5,
		Lang.get(82475),
		32517,
		15,
		1048,
		{
			RTResTalkAction[129],
			RTResTalkAction[132]
		}
	},
	[32517016] = {
		32517016,
		3,
		Lang.get(82476),
		32517,
		16,
		605,
		{
			RTResTalkAction[124],
			RTResTalkAction[80]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		32572,
		nil,
		nil,
		nil,
		nil,
		nil,
		32572,
		255,
		nil,
		1
	},
	[32517017] = {
		32517017,
		0,
		Lang.get(82477),
		32517,
		17,
		46,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		32573,
		[19] = 32573,
		[20] = -1
	},
	[32517018] = {
		32517018,
		0,
		Lang.get(82478),
		32517,
		18,
		1064,
		{
			RTResTalkAction[125]
		},
		nil,
		nil,
		3,
		nil,
		60
	},
	[32517019] = {
		32517019,
		0,
		Lang.get(82479),
		32517,
		19,
		1048,
		{
			RTResTalkAction[133],
			RTResTalkAction[127]
		}
	},
	[32517020] = {
		32517020,
		0,
		Lang.get(82480),
		32517,
		20,
		1064,
		{
			RTResTalkAction[112],
			RTResTalkAction[134]
		}
	},
	[32517021] = {
		32517021,
		3,
		Lang.get(82481),
		32517,
		21,
		605,
		{
			RTResTalkAction[80],
			RTResTalkAction[124]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		32574,
		1,
		1,
		nil,
		1,
		nil,
		32574,
		200,
		nil,
		1
	},
	[32517022] = {
		32517022,
		0,
		Lang.get(82482),
		32517,
		22,
		46,
		nil,
		1,
		[20] = 0
	},
	[32517023] = {
		32517023,
		0,
		Lang.get(82483),
		32517,
		23,
		46,
		nil,
		1
	},
	[32517024] = {
		32517024,
		0,
		Lang.get(82484),
		32517,
		24,
		46,
		{
			RTResTalkAction[81]
		},
		nil,
		nil,
		3,
		nil,
		142
	},
	[32517025] = {
		32517025,
		0,
		Lang.get(82485),
		32517,
		25,
		46,
		{
			RTResTalkAction[81]
		}
	},
	[32517026] = {
		32517026,
		0,
		Lang.get(82486),
		32517,
		26,
		119,
		{
			RTResTalkAction[30],
			RTResTalkAction[83]
		}
	},
	[32518001] = {
		32518001,
		3,
		Lang.get(82487),
		32518,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		32575,
		[19] = 32575,
		[22] = 1
	},
	[32518002] = {
		32518002,
		0,
		Lang.get(82488),
		32518,
		2,
		1063,
		nil,
		1,
		nil,
		nil,
		nil,
		103
	},
	[32518003] = {
		32518003,
		0,
		Lang.get(82489),
		32518,
		3,
		1055,
		nil,
		1
	},
	[32518004] = {
		32518004,
		0,
		Lang.get(82490),
		32518,
		4,
		1055,
		nil,
		1
	},
	[32518005] = {
		32518005,
		0,
		Lang.get(82491),
		32518,
		5,
		1063,
		{
			RTResTalkAction[135]
		}
	},
	[32518006] = {
		32518006,
		0,
		Lang.get(82492),
		32518,
		6,
		1063,
		{
			RTResTalkAction[136]
		}
	},
	[32518007] = {
		32518007,
		0,
		Lang.get(82493),
		32518,
		7,
		1055,
		{
			RTResTalkAction[137],
			RTResTalkAction[138]
		}
	},
	[32518008] = {
		32518008,
		0,
		Lang.get(82494),
		32518,
		8,
		1063,
		{
			RTResTalkAction[139],
			RTResTalkAction[140]
		}
	},
	[32518009] = {
		32518009,
		0,
		Lang.get(82495),
		32518,
		9,
		1055,
		{
			RTResTalkAction[141],
			RTResTalkAction[138]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		32576,
		1,
		1,
		nil,
		nil,
		nil,
		32576
	},
	[32518010] = {
		32518010,
		0,
		Lang.get(82496),
		32518,
		10,
		1063,
		nil,
		1
	},
	[32518011] = {
		32518011,
		0,
		Lang.get(82497),
		32518,
		11,
		1055,
		{
			RTResTalkAction[137]
		},
		nil,
		nil,
		3
	},
	[32518012] = {
		32518012,
		0,
		Lang.get(82498),
		32518,
		12,
		46,
		{
			RTResTalkAction[141]
		},
		1,
		nil,
		nil,
		nil,
		147,
		32577,
		1,
		1,
		nil,
		2,
		nil,
		32577
	},
	[32518013] = {
		32518013,
		0,
		Lang.get(82499),
		32518,
		13,
		46,
		nil,
		1
	},
	[32518014] = {
		32518014,
		0,
		Lang.get(82500),
		32518,
		14,
		46,
		nil,
		1
	},
	[32518015] = {
		32518015,
		0,
		Lang.get(82501),
		32518,
		15,
		1050,
		{
			RTResTalkAction[142]
		}
	},
	[32518016] = {
		32518016,
		0,
		Lang.get(82502),
		32518,
		16,
		46,
		{
			RTResTalkAction[81],
			RTResTalkAction[143]
		}
	},
	[32518017] = {
		32518017,
		0,
		Lang.get(82503),
		32518,
		17,
		46,
		{
			RTResTalkAction[81]
		}
	},
	[32518018] = {
		32518018,
		0,
		Lang.get(82504),
		32518,
		18,
		119,
		{
			RTResTalkAction[144],
			RTResTalkAction[83]
		}
	},
	[32518019] = {
		32518019,
		0,
		Lang.get(82505),
		32518,
		19,
		119,
		{
			RTResTalkAction[10]
		}
	},
	[32518020] = {
		32518020,
		0,
		Lang.get(82506),
		32518,
		20,
		119,
		{
			RTResTalkAction[10]
		}
	},
	[32518021] = {
		32518021,
		0,
		Lang.get(82507),
		32518,
		21,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[32518022] = {
		32518022,
		0,
		Lang.get(82508),
		32518,
		22,
		1050,
		{
			RTResTalkAction[145],
			RTResTalkAction[6]
		}
	},
	[32518023] = {
		32518023,
		0,
		Lang.get(82509),
		32518,
		23,
		1048,
		{
			RTResTalkAction[146],
			RTResTalkAction[147]
		}
	},
	[32518024] = {
		32518024,
		0,
		Lang.get(82510),
		32518,
		24,
		1050,
		{
			RTResTalkAction[112],
			RTResTalkAction[147]
		}
	},
	[32518025] = {
		32518025,
		0,
		Lang.get(82511),
		32518,
		25,
		1050,
		{
			RTResTalkAction[112],
			RTResTalkAction[147]
		}
	},
	[32518026] = {
		32518026,
		0,
		Lang.get(82512),
		32518,
		26,
		46,
		{
			RTResTalkAction[81],
			RTResTalkAction[80],
			RTResTalkAction[143]
		}
	},
	[32518027] = {
		32518027,
		0,
		Lang.get(82513),
		32518,
		27,
		1048,
		{
			RTResTalkAction[126],
			RTResTalkAction[147],
			RTResTalkAction[83]
		}
	},
	[32518028] = {
		32518028,
		0,
		Lang.get(82514),
		32518,
		28,
		1050,
		{
			RTResTalkAction[112],
			RTResTalkAction[147]
		}
	},
	[32519001] = {
		32519001,
		0,
		Lang.get(82515),
		32519,
		1,
		1050,
		nil,
		1,
		nil,
		nil,
		nil,
		148,
		32580,
		nil,
		nil,
		nil,
		nil,
		nil,
		32580
	},
	[32519002] = {
		32519002,
		0,
		Lang.get(34640),
		32519,
		2,
		1048,
		nil,
		1
	},
	[32519003] = {
		32519003,
		0,
		Lang.get(82516),
		32519,
		3,
		1050,
		nil,
		1
	},
	[32519004] = {
		32519004,
		0,
		Lang.get(82517),
		32519,
		4,
		1048,
		{
			RTResTalkAction[111]
		},
		nil,
		nil,
		3
	},
	[32519005] = {
		32519005,
		0,
		Lang.get(82518),
		32519,
		5,
		46,
		{
			RTResTalkAction[81],
			RTResTalkAction[80]
		}
	},
	[32519006] = {
		32519006,
		0,
		Lang.get(19561),
		32519,
		6,
		1050,
		{
			RTResTalkAction[142],
			RTResTalkAction[83]
		}
	},
	[32519007] = {
		32519007,
		0,
		Lang.get(16581),
		32519,
		7,
		46,
		{
			RTResTalkAction[148],
			RTResTalkAction[149]
		}
	},
	[32519008] = {
		32519008,
		0,
		Lang.get(82519),
		32519,
		8,
		119,
		{
			RTResTalkAction[150],
			RTResTalkAction[143],
			RTResTalkAction[83]
		}
	},
	[32519009] = {
		32519009,
		0,
		Lang.get(82520),
		32519,
		9,
		119,
		{
			RTResTalkAction[10]
		}
	},
	[32519010] = {
		32519010,
		0,
		"……",
		32519,
		10,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[32519011] = {
		32519011,
		0,
		Lang.get(82521),
		32519,
		11,
		1054,
		{
			RTResTalkAction[92],
			RTResTalkAction[6]
		},
		nil,
		nil,
		nil,
		nil,
		57
	},
	[32519012] = {
		32519012,
		0,
		Lang.get(82522),
		32519,
		12,
		300,
		{
			RTResTalkAction[92]
		}
	},
	[32519013] = {
		32519013,
		0,
		Lang.get(82523),
		32519,
		13,
		1054,
		{
			RTResTalkAction[92]
		}
	},
	[32519014] = {
		32519014,
		0,
		Lang.get(82524),
		32519,
		14,
		1050,
		{
			RTResTalkAction[97]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		32581,
		1,
		1,
		nil,
		nil,
		nil,
		32581
	},
	[32519015] = {
		32519015,
		0,
		Lang.get(82525),
		32519,
		15,
		1050,
		nil,
		1
	},
	[32519016] = {
		32519016,
		0,
		Lang.get(82526),
		32519,
		16,
		1050,
		{
			RTResTalkAction[142]
		},
		nil,
		nil,
		3
	},
	[32519017] = {
		32519017,
		2,
		Lang.get(82527),
		32519,
		17,
		1048,
		{
			RTResTalkAction[118],
			RTResTalkAction[143]
		}
	},
	[32519018] = {
		32519018,
		2,
		Lang.get(82528),
		32519,
		18,
		1048,
		{
			RTResTalkAction[88]
		}
	},
	[32519019] = {
		32519019,
		2,
		Lang.get(82529),
		32519,
		19,
		1048,
		{
			RTResTalkAction[151]
		}
	},
	[32520001] = {
		32520001,
		2,
		Lang.get(82530),
		32520,
		1,
		1048,
		nil,
		1,
		2,
		nil,
		nil,
		57,
		32585,
		nil,
		nil,
		nil,
		nil,
		nil,
		32585
	},
	[32520002] = {
		32520002,
		0,
		Lang.get(82531),
		32520,
		2,
		46,
		nil,
		1
	},
	[32520003] = {
		32520003,
		2,
		Lang.get(82532),
		32520,
		3,
		1048,
		{
			RTResTalkAction[152]
		},
		nil,
		nil,
		3
	},
	[32520004] = {
		32520004,
		0,
		Lang.get(82533),
		32520,
		4,
		1050,
		{
			RTResTalkAction[142],
			RTResTalkAction[80]
		}
	},
	[32520005] = {
		32520005,
		0,
		Lang.get(82534),
		32520,
		5,
		119,
		{
			RTResTalkAction[12],
			RTResTalkAction[153],
			RTResTalkAction[143]
		}
	},
	[32520006] = {
		32520006,
		0,
		Lang.get(82535),
		32520,
		6,
		1054,
		{
			RTResTalkAction[12],
			RTResTalkAction[153]
		}
	},
	[32520007] = {
		32520007,
		0,
		Lang.get(82536),
		32520,
		7,
		1050,
		{
			RTResTalkAction[142],
			RTResTalkAction[6],
			RTResTalkAction[97]
		}
	},
	[32520008] = {
		32520008,
		3,
		Lang.get(82537),
		32520,
		8,
		605,
		{
			RTResTalkAction[143]
		},
		nil,
		nil,
		nil,
		nil,
		148,
		32586,
		1,
		1,
		nil,
		nil,
		nil,
		32586,
		nil,
		nil,
		1
	},
	[32520009] = {
		32520009,
		0,
		"！",
		32520,
		9,
		1050,
		nil,
		1
	},
	[32520010] = {
		32520010,
		2,
		Lang.get(82538),
		32520,
		10,
		1050,
		{
			RTResTalkAction[154]
		},
		nil,
		nil,
		3
	},
	[32520011] = {
		32520011,
		0,
		Lang.get(32377),
		32520,
		11,
		46,
		{
			RTResTalkAction[81],
			RTResTalkAction[143]
		}
	},
	[32520012] = {
		32520012,
		5,
		Lang.get(82539),
		32520,
		12,
		1048,
		{
			RTResTalkAction[155],
			RTResTalkAction[147],
			RTResTalkAction[83]
		}
	},
	[32520013] = {
		32520013,
		0,
		Lang.get(34640),
		32520,
		13,
		1050,
		{
			RTResTalkAction[112],
			RTResTalkAction[156]
		}
	},
	[32520014] = {
		32520014,
		5,
		Lang.get(82540),
		32520,
		14,
		46,
		{
			RTResTalkAction[81],
			RTResTalkAction[80],
			RTResTalkAction[143]
		}
	},
	[32520015] = {
		32520015,
		5,
		Lang.get(82541),
		32520,
		15,
		46,
		{
			RTResTalkAction[81]
		}
	},
	[32520016] = {
		32520016,
		0,
		Lang.get(82542),
		32520,
		16,
		119,
		{
			RTResTalkAction[83]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		32587,
		1,
		1,
		nil,
		nil,
		nil,
		32587
	},
	[32520017] = {
		32520017,
		0,
		Lang.get(20006),
		32520,
		17,
		300
	},
	[32520018] = {
		32520018,
		0,
		Lang.get(82543),
		32520,
		18,
		119,
		{
			RTResTalkAction[150]
		},
		nil,
		nil,
		3
	},
	[32520019] = {
		32520019,
		0,
		Lang.get(82544),
		32520,
		19,
		46,
		{
			RTResTalkAction[81],
			RTResTalkAction[6]
		},
		nil,
		nil,
		nil,
		nil,
		142
	},
	[32520020] = {
		32520020,
		5,
		Lang.get(82545),
		32520,
		20,
		46,
		{
			RTResTalkAction[79]
		}
	},
	[32520021] = {
		32520021,
		0,
		Lang.get(82546),
		32520,
		21,
		46,
		{
			RTResTalkAction[81]
		}
	},
	[32520022] = {
		32520022,
		0,
		Lang.get(82547),
		32520,
		22,
		1050,
		{
			RTResTalkAction[157],
			RTResTalkAction[83]
		},
		nil,
		nil,
		nil,
		nil,
		62
	},
	[32520023] = {
		32520023,
		2,
		Lang.get(82548),
		32520,
		23,
		46,
		{
			RTResTalkAction[79],
			RTResTalkAction[143]
		}
	},
	[32520024] = {
		32520024,
		0,
		Lang.get(82549),
		32520,
		24,
		1050,
		{
			RTResTalkAction[142],
			RTResTalkAction[83]
		}
	},
	[32520025] = {
		32520025,
		0,
		Lang.get(82550),
		32520,
		25,
		1048,
		{
			RTResTalkAction[148],
			RTResTalkAction[158]
		}
	},
	[32520026] = {
		32520026,
		0,
		Lang.get(82551),
		32520,
		26,
		1048,
		{
			RTResTalkAction[88],
			RTResTalkAction[143]
		}
	},
	[32520027] = {
		32520027,
		3,
		Lang.get(82552),
		32520,
		27,
		605,
		{
			RTResTalkAction[80]
		},
		[22] = 1
	},
	[32521001] = {
		32521001,
		0,
		Lang.get(82553),
		32521,
		1,
		119,
		nil,
		1,
		2,
		nil,
		nil,
		8,
		32590,
		nil,
		nil,
		nil,
		nil,
		nil,
		32590
	},
	[32521002] = {
		32521002,
		0,
		Lang.get(82554),
		32521,
		2,
		1048,
		nil,
		1
	},
	[32521003] = {
		32521003,
		0,
		Lang.get(82555),
		32521,
		3,
		300
	},
	[32521004] = {
		32521004,
		0,
		Lang.get(82556),
		32521,
		4,
		1048,
		nil,
		1
	},
	[32521005] = {
		32521005,
		0,
		Lang.get(82557),
		32521,
		5,
		119,
		{
			RTResTalkAction[37]
		},
		nil,
		nil,
		3
	},
	[32521006] = {
		32521006,
		0,
		Lang.get(82558),
		32521,
		6,
		1048,
		{
			RTResTalkAction[12],
			RTResTalkAction[89]
		}
	},
	[32521007] = {
		32521007,
		0,
		Lang.get(82559),
		32521,
		7,
		119,
		{
			RTResTalkAction[20],
			RTResTalkAction[89]
		}
	},
	[32521008] = {
		32521008,
		0,
		Lang.get(67797),
		32521,
		8,
		1048,
		{
			RTResTalkAction[12],
			RTResTalkAction[130]
		}
	},
	[32521009] = {
		32521009,
		0,
		Lang.get(82560),
		32521,
		9,
		119,
		{
			RTResTalkAction[21],
			RTResTalkAction[80]
		}
	},
	[32521010] = {
		32521010,
		0,
		Lang.get(82561),
		32521,
		10,
		119,
		{
			RTResTalkAction[90]
		}
	},
	[32521011] = {
		32521011,
		0,
		Lang.get(82562),
		32521,
		11,
		119,
		{
			RTResTalkAction[10]
		}
	},
	[32521012] = {
		32521012,
		0,
		Lang.get(82563),
		32521,
		12,
		1048,
		{
			RTResTalkAction[159],
			RTResTalkAction[6]
		}
	},
	[32521013] = {
		32521013,
		0,
		Lang.get(82564),
		32521,
		13,
		1048,
		{
			RTResTalkAction[160]
		}
	},
	[32521014] = {
		32521014,
		0,
		Lang.get(82565),
		32521,
		14,
		119,
		{
			RTResTalkAction[161],
			RTResTalkAction[89]
		}
	},
	[32521015] = {
		32521015,
		0,
		Lang.get(82566),
		32521,
		15,
		1048,
		{
			RTResTalkAction[20],
			RTResTalkAction[102]
		}
	},
	[32521016] = {
		32521016,
		0,
		Lang.get(82567),
		32521,
		16,
		119,
		{
			RTResTalkAction[28],
			RTResTalkAction[89]
		}
	},
	[32521017] = {
		32521017,
		0,
		Lang.get(82568),
		32521,
		17,
		119,
		{
			RTResTalkAction[12],
			RTResTalkAction[89]
		}
	},
	[32521018] = {
		32521018,
		0,
		Lang.get(82569),
		32521,
		18,
		119,
		{
			RTResTalkAction[12],
			RTResTalkAction[89]
		}
	},
	[32521019] = {
		32521019,
		0,
		Lang.get(82570),
		32521,
		19,
		1048,
		{
			RTResTalkAction[20],
			RTResTalkAction[102]
		},
		nil,
		nil,
		nil,
		nil,
		26
	},
	[32521020] = {
		32521020,
		0,
		Lang.get(82571),
		32521,
		20,
		1048,
		{
			RTResTalkAction[12],
			RTResTalkAction[162]
		}
	},
	[32521021] = {
		32521021,
		0,
		Lang.get(82572),
		32521,
		21,
		1048,
		{
			RTResTalkAction[12],
			RTResTalkAction[102]
		}
	},
	[32521022] = {
		32521022,
		0,
		Lang.get(66037),
		32521,
		22,
		119,
		{
			RTResTalkAction[6],
			RTResTalkAction[80]
		},
		1,
		6,
		nil,
		nil,
		nil,
		32591,
		1,
		1,
		nil,
		1,
		nil,
		32591
	},
	[32521023] = {
		32521023,
		0,
		Lang.get(82573),
		32521,
		23,
		119,
		nil,
		1
	},
	[32521024] = {
		32521024,
		0,
		Lang.get(82574),
		32521,
		24,
		119,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3
	},
	[32521025] = {
		32521025,
		0,
		Lang.get(82575),
		32521,
		25,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[32521026] = {
		32521026,
		0,
		Lang.get(82576),
		32521,
		26,
		119,
		{
			RTResTalkAction[10]
		}
	},
	[32521027] = {
		32521027,
		0,
		Lang.get(82577),
		32521,
		27,
		119,
		{
			RTResTalkAction[163]
		}
	},
	[32521028] = {
		32521028,
		0,
		Lang.get(82578),
		32521,
		28,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[32521029] = {
		32521029,
		0,
		Lang.get(82579),
		32521,
		29,
		119,
		{
			RTResTalkAction[21]
		}
	},
	[32521030] = {
		32521030,
		0,
		Lang.get(82580),
		32521,
		30,
		119,
		{
			RTResTalkAction[10]
		}
	},
	[32521031] = {
		32521031,
		4,
		nil,
		32521,
		31,
		300,
		{
			RTResTalkAction[10]
		},
		[29] = {
			{
				id = 32521032,
				branch_content = Lang.get(82581)
			},
			{
				id = 32521032,
				branch_content = Lang.get(82582)
			}
		}
	},
	[32521032] = {
		32521032,
		0,
		Lang.get(82583),
		32521,
		32,
		119,
		{
			RTResTalkAction[82]
		}
	},
	[32522001] = {
		32522001,
		0,
		Lang.get(82584),
		32522,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		154,
		32595,
		[19] = 32595
	},
	[32522002] = {
		32522002,
		0,
		Lang.get(82585),
		32522,
		2,
		1048,
		nil,
		1,
		1
	},
	[32522003] = {
		32522003,
		0,
		Lang.get(82586),
		32522,
		3,
		300,
		nil,
		1
	},
	[32522004] = {
		32522004,
		0,
		Lang.get(82587),
		32522,
		4,
		1048,
		nil,
		1,
		4
	},
	[32522005] = {
		32522005,
		0,
		Lang.get(82588),
		32522,
		5,
		300,
		nil,
		1
	},
	[32522006] = {
		32522006,
		0,
		"……",
		32522,
		6,
		1048,
		{
			RTResTalkAction[164]
		}
	},
	[32522007] = {
		32522007,
		0,
		Lang.get(82589),
		32522,
		7,
		1048,
		{
			RTResTalkAction[87]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[32522008] = {
		32522008,
		0,
		Lang.get(82590),
		32522,
		8,
		300,
		{
			RTResTalkAction[88]
		}
	},
	[32522009] = {
		32522009,
		0,
		Lang.get(82591),
		32522,
		9,
		1048,
		{
			RTResTalkAction[88]
		}
	},
	[32522010] = {
		32522010,
		0,
		Lang.get(82592),
		32522,
		10,
		1048,
		{
			RTResTalkAction[88]
		}
	},
	[32522011] = {
		32522011,
		0,
		Lang.get(82593),
		32522,
		11,
		1048,
		{
			RTResTalkAction[88]
		}
	},
	[32522012] = {
		32522012,
		0,
		Lang.get(82594),
		32522,
		12,
		1048,
		{
			RTResTalkAction[88]
		}
	},
	[32522013] = {
		32522013,
		0,
		Lang.get(25175),
		32522,
		13,
		300,
		{
			RTResTalkAction[88]
		}
	},
	[32522014] = {
		32522014,
		0,
		Lang.get(82595),
		32522,
		14,
		1048,
		{
			RTResTalkAction[165]
		}
	},
	[32522015] = {
		32522015,
		0,
		Lang.get(82596),
		32522,
		15,
		1048,
		{
			RTResTalkAction[88]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[32522016] = {
		32522016,
		0,
		Lang.get(82597),
		32522,
		16,
		1048,
		{
			RTResTalkAction[159]
		}
	},
	[32522017] = {
		32522017,
		0,
		Lang.get(82598),
		32522,
		17,
		300,
		{
			RTResTalkAction[88]
		}
	},
	[32522018] = {
		32522018,
		0,
		Lang.get(82599),
		32522,
		18,
		1048,
		{
			RTResTalkAction[159]
		}
	},
	[32522019] = {
		32522019,
		0,
		Lang.get(82600),
		32522,
		19,
		1048,
		{
			RTResTalkAction[88]
		}
	},
	[32522020] = {
		32522020,
		0,
		Lang.get(82601),
		32522,
		20,
		1048,
		{
			RTResTalkAction[88]
		}
	},
	[32522021] = {
		32522021,
		0,
		Lang.get(82602),
		32522,
		21,
		300,
		{
			RTResTalkAction[88]
		}
	},
	[32522022] = {
		32522022,
		0,
		Lang.get(82603),
		32522,
		22,
		1048,
		{
			RTResTalkAction[88]
		}
	},
	[32522023] = {
		32522023,
		0,
		Lang.get(82604),
		32522,
		23,
		1048,
		{
			RTResTalkAction[88]
		}
	},
	[32522024] = {
		32522024,
		0,
		Lang.get(82605),
		32522,
		24,
		1048,
		{
			RTResTalkAction[159]
		}
	},
	[32522025] = {
		32522025,
		0,
		Lang.get(82606),
		32522,
		25,
		300,
		{
			RTResTalkAction[88]
		}
	},
	[32522026] = {
		32522026,
		0,
		Lang.get(82607),
		32522,
		26,
		1048,
		{
			RTResTalkAction[165]
		}
	},
	[32522027] = {
		32522027,
		0,
		Lang.get(82608),
		32522,
		27,
		1048,
		{
			RTResTalkAction[88]
		}
	},
	[32522028] = {
		32522028,
		0,
		Lang.get(82609),
		32522,
		28,
		1048,
		{
			RTResTalkAction[88]
		}
	},
	[32522029] = {
		32522029,
		0,
		Lang.get(82610),
		32522,
		29,
		1048,
		{
			RTResTalkAction[166]
		}
	},
	[32522030] = {
		32522030,
		0,
		Lang.get(82611),
		32522,
		30,
		300,
		{
			RTResTalkAction[88]
		}
	},
	[32522031] = {
		32522031,
		0,
		Lang.get(82612),
		32522,
		31,
		300,
		{
			RTResTalkAction[88]
		}
	},
	[32522032] = {
		32522032,
		0,
		Lang.get(82613),
		32522,
		32,
		1048,
		{
			RTResTalkAction[160]
		}
	},
	[32522033] = {
		32522033,
		0,
		Lang.get(82614),
		32522,
		33,
		300,
		{
			RTResTalkAction[88]
		}
	},
	[32522034] = {
		32522034,
		4,
		nil,
		32522,
		34,
		300,
		{
			RTResTalkAction[88]
		},
		[29] = {
			{
				id = 32522035,
				branch_content = Lang.get(82615)
			},
			{
				id = 32522035,
				branch_content = Lang.get(82616)
			}
		}
	},
	[32522035] = {
		32522035,
		0,
		Lang.get(82617),
		32522,
		35,
		1048,
		{
			RTResTalkAction[167]
		}
	},
	[32522036] = {
		32522036,
		0,
		Lang.get(82618),
		32522,
		36,
		1048,
		{
			RTResTalkAction[88]
		}
	},
	[32522037] = {
		32522037,
		0,
		Lang.get(82619),
		32522,
		37,
		1048,
		{
			RTResTalkAction[88]
		},
		nil,
		nil,
		nil,
		nil,
		62
	},
	[32522038] = {
		32522038,
		0,
		Lang.get(82620),
		32522,
		38,
		1048,
		{
			RTResTalkAction[80]
		},
		1,
		0,
		nil,
		nil,
		nil,
		32596,
		1,
		1,
		nil,
		nil,
		nil,
		32596
	},
	[32522039] = {
		32522039,
		0,
		Lang.get(82621),
		32522,
		39,
		300
	},
	[32522040] = {
		32522040,
		0,
		Lang.get(82622),
		32522,
		40,
		1048,
		{
			RTResTalkAction[168]
		},
		nil,
		nil,
		3
	},
	[32522041] = {
		32522041,
		0,
		Lang.get(82623),
		32522,
		41,
		300,
		{
			RTResTalkAction[88]
		}
	},
	[32523001] = {
		32523001,
		3,
		Lang.get(82624),
		32523,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		1222,
		nil,
		nil,
		nil,
		1,
		[22] = 1,
		[20] = 255
	},
	[32523002] = {
		32523002,
		0,
		Lang.get(82625),
		32523,
		2,
		46,
		nil,
		1,
		nil,
		nil,
		1222,
		147,
		32599,
		1,
		nil,
		nil,
		nil,
		nil,
		32599,
		0
	},
	[32523003] = {
		32523003,
		0,
		Lang.get(82626),
		32523,
		3,
		46,
		nil,
		1
	},
	[32523004] = {
		32523004,
		0,
		Lang.get(82627),
		32523,
		4,
		46,
		nil,
		1,
		nil,
		nil,
		1222
	},
	[32523005] = {
		32523005,
		0,
		Lang.get(82628),
		32523,
		5,
		46,
		nil,
		1
	},
	[32524001] = {
		32524001,
		0,
		Lang.get(82629),
		32524,
		1,
		257,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		32605,
		nil,
		nil,
		nil,
		nil,
		nil,
		32605
	},
	[32524002] = {
		32524002,
		0,
		Lang.get(82630),
		32524,
		2,
		257,
		nil,
		1
	},
	[32524003] = {
		32524003,
		0,
		Lang.get(82631),
		32524,
		3,
		257,
		nil,
		1
	},
	[32524004] = {
		32524004,
		0,
		Lang.get(82632),
		32524,
		4,
		1066,
		nil,
		1
	},
	[32524005] = {
		32524005,
		0,
		Lang.get(82633),
		32524,
		5,
		257,
		{
			RTResTalkAction[169]
		},
		nil,
		nil,
		3
	},
	[32524006] = {
		32524006,
		0,
		Lang.get(82634),
		32524,
		6,
		257,
		{
			RTResTalkAction[169]
		}
	},
	[32524007] = {
		32524007,
		0,
		Lang.get(82635),
		32524,
		7,
		1066,
		{
			RTResTalkAction[170],
			RTResTalkAction[171]
		}
	},
	[32524008] = {
		32524008,
		0,
		Lang.get(82636),
		32524,
		8,
		257,
		{
			RTResTalkAction[170],
			RTResTalkAction[172]
		}
	},
	[32524009] = {
		32524009,
		0,
		Lang.get(82637),
		32524,
		9,
		257,
		{
			RTResTalkAction[170],
			RTResTalkAction[172]
		}
	},
	[32524010] = {
		32524010,
		0,
		Lang.get(82638),
		32524,
		10,
		257,
		{
			RTResTalkAction[170],
			RTResTalkAction[172]
		}
	},
	[32524011] = {
		32524011,
		0,
		Lang.get(82639),
		32524,
		11,
		1066,
		{
			RTResTalkAction[170],
			RTResTalkAction[172]
		}
	},
	[32524012] = {
		32524012,
		0,
		Lang.get(82640),
		32524,
		12,
		257,
		{
			RTResTalkAction[170],
			RTResTalkAction[172]
		}
	},
	[32524013] = {
		32524013,
		0,
		Lang.get(82641),
		32524,
		13,
		1066,
		{
			RTResTalkAction[170],
			RTResTalkAction[172]
		}
	},
	[32524014] = {
		32524014,
		0,
		Lang.get(82642),
		32524,
		14,
		257,
		{
			RTResTalkAction[170],
			RTResTalkAction[172]
		}
	},
	[32524015] = {
		32524015,
		0,
		Lang.get(82643),
		32524,
		15,
		1066,
		{
			RTResTalkAction[170],
			RTResTalkAction[172]
		}
	},
	[32524016] = {
		32524016,
		0,
		Lang.get(82644),
		32524,
		16,
		1066,
		{
			RTResTalkAction[170],
			RTResTalkAction[172]
		}
	},
	[32524017] = {
		32524017,
		0,
		Lang.get(82645),
		32524,
		17,
		257,
		{
			RTResTalkAction[169],
			RTResTalkAction[61]
		}
	},
	[32524018] = {
		32524018,
		0,
		Lang.get(82646),
		32524,
		18,
		257,
		{
			RTResTalkAction[173]
		}
	},
	[32524019] = {
		32524019,
		3,
		Lang.get(82647),
		32524,
		19,
		605,
		{
			RTResTalkAction[174]
		},
		nil,
		nil,
		nil,
		nil,
		147,
		32607,
		nil,
		1,
		nil,
		nil,
		nil,
		32607,
		nil,
		nil,
		1
	},
	[32524020] = {
		32524020,
		0,
		Lang.get(82648),
		32524,
		20,
		119,
		nil,
		1,
		2
	},
	[32524021] = {
		32524021,
		2,
		Lang.get(82649),
		32524,
		21,
		1048,
		nil,
		1,
		0
	},
	[32524022] = {
		32524022,
		2,
		Lang.get(82650),
		32524,
		22,
		1048,
		nil,
		1
	},
	[32524023] = {
		32524023,
		2,
		Lang.get(82651),
		32524,
		23,
		1048,
		nil,
		1,
		3
	},
	[32524024] = {
		32524024,
		0,
		Lang.get(82652),
		32524,
		24,
		1055,
		nil,
		1
	},
	[32524025] = {
		32524025,
		0,
		Lang.get(82653),
		32524,
		25,
		1055,
		nil,
		1
	},
	[32524026] = {
		32524026,
		0,
		Lang.get(82654),
		32524,
		26,
		1048,
		{
			RTResTalkAction[88]
		}
	},
	[32524027] = {
		32524027,
		0,
		Lang.get(82655),
		32524,
		27,
		46,
		{
			RTResTalkAction[81],
			RTResTalkAction[80]
		},
		nil,
		nil,
		3
	},
	[32524028] = {
		32524028,
		0,
		Lang.get(82656),
		32524,
		28,
		1048,
		{
			RTResTalkAction[118],
			RTResTalkAction[83]
		}
	},
	[32524029] = {
		32524029,
		0,
		Lang.get(82657),
		32524,
		29,
		1055,
		{
			RTResTalkAction[112],
			RTResTalkAction[175]
		}
	},
	[32524030] = {
		32524030,
		0,
		Lang.get(82658),
		32524,
		30,
		46,
		{
			RTResTalkAction[81],
			RTResTalkAction[80],
			RTResTalkAction[141]
		}
	},
	[32525001] = {
		32525001,
		0,
		Lang.get(18794),
		32525,
		1,
		46,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		32610,
		nil,
		nil,
		nil,
		nil,
		nil,
		32610
	},
	[32525002] = {
		32525002,
		0,
		Lang.get(82659),
		32525,
		2,
		46,
		nil,
		1
	},
	[32525003] = {
		32525003,
		0,
		Lang.get(82660),
		32525,
		3,
		1052,
		{
			RTResTalkAction[53]
		},
		nil,
		nil,
		3
	},
	[32525004] = {
		32525004,
		0,
		Lang.get(82661),
		32525,
		4,
		119,
		{
			RTResTalkAction[176],
			RTResTalkAction[177]
		}
	},
	[32525005] = {
		32525005,
		0,
		Lang.get(82662),
		32525,
		5,
		1052,
		{
			RTResTalkAction[178],
			RTResTalkAction[52]
		}
	},
	[32525006] = {
		32525006,
		0,
		Lang.get(82663),
		32525,
		6,
		46,
		{
			RTResTalkAction[81],
			RTResTalkAction[59],
			RTResTalkAction[6]
		}
	},
	[32525007] = {
		32525007,
		0,
		Lang.get(82664),
		32525,
		7,
		46,
		{
			RTResTalkAction[81]
		}
	},
	[32525008] = {
		32525008,
		0,
		Lang.get(82665),
		32525,
		8,
		119,
		{
			RTResTalkAction[21],
			RTResTalkAction[83]
		}
	},
	[32525009] = {
		32525009,
		0,
		Lang.get(82666),
		32525,
		9,
		119,
		{
			RTResTalkAction[10]
		}
	},
	[32525010] = {
		32525010,
		0,
		Lang.get(82667),
		32525,
		10,
		119,
		{
			RTResTalkAction[10]
		}
	},
	[32525011] = {
		32525011,
		0,
		Lang.get(82668),
		32525,
		11,
		119,
		{
			RTResTalkAction[48]
		}
	},
	[32525012] = {
		32525012,
		0,
		Lang.get(82669),
		32525,
		12,
		1052,
		{
			RTResTalkAction[54],
			RTResTalkAction[6]
		}
	},
	[32525013] = {
		32525013,
		0,
		Lang.get(82670),
		32525,
		13,
		1052,
		{
			RTResTalkAction[53]
		}
	},
	[32525014] = {
		32525014,
		0,
		Lang.get(82671),
		32525,
		14,
		119,
		{
			RTResTalkAction[176],
			RTResTalkAction[179]
		}
	},
	[32525015] = {
		32525015,
		0,
		Lang.get(82672),
		32525,
		15,
		119,
		{
			RTResTalkAction[176],
			RTResTalkAction[180]
		}
	},
	[32525016] = {
		32525016,
		0,
		Lang.get(82673),
		32525,
		16,
		1048,
		{
			RTResTalkAction[59],
			RTResTalkAction[6]
		},
		1,
		2,
		nil,
		nil,
		nil,
		32611,
		nil,
		nil,
		nil,
		nil,
		nil,
		32611
	},
	[32525017] = {
		32525017,
		0,
		Lang.get(82674),
		32525,
		17,
		46,
		{
			RTResTalkAction[81]
		},
		nil,
		nil,
		3
	},
	[32525018] = {
		32525018,
		0,
		Lang.get(82675),
		32525,
		18,
		119,
		{
			RTResTalkAction[181],
			RTResTalkAction[83]
		},
		nil,
		nil,
		nil,
		nil,
		57
	},
	[32525019] = {
		32525019,
		5,
		Lang.get(82676),
		32525,
		19,
		46,
		{
			RTResTalkAction[81],
			RTResTalkAction[6]
		}
	},
	[32525020] = {
		32525020,
		0,
		Lang.get(82677),
		32525,
		20,
		1048,
		{
			RTResTalkAction[84],
			RTResTalkAction[83]
		}
	},
	[32525021] = {
		32525021,
		0,
		"！",
		32525,
		21,
		1048,
		{
			RTResTalkAction[111]
		}
	},
	[32525022] = {
		32525022,
		0,
		Lang.get(82678),
		32525,
		22,
		46,
		{
			RTResTalkAction[81],
			RTResTalkAction[80]
		}
	},
	[32525023] = {
		32525023,
		5,
		Lang.get(82679),
		32525,
		23,
		119,
		{
			RTResTalkAction[11],
			RTResTalkAction[83]
		}
	},
	[32525024] = {
		32525024,
		0,
		Lang.get(32735),
		32525,
		24,
		1048,
		{
			RTResTalkAction[182],
			RTResTalkAction[6]
		}
	},
	[32525025] = {
		32525025,
		5,
		Lang.get(82680),
		32525,
		25,
		46,
		{
			RTResTalkAction[81],
			RTResTalkAction[80]
		}
	},
	[32525026] = {
		32525026,
		3,
		Lang.get(82681),
		32525,
		26,
		605,
		{
			RTResTalkAction[83]
		},
		[22] = 1
	},
	[32525027] = {
		32525027,
		0,
		Lang.get(82682),
		32525,
		27,
		1052,
		{
			RTResTalkAction[85]
		}
	},
	[32525028] = {
		32525028,
		0,
		Lang.get(82683),
		32525,
		28,
		119,
		{
			RTResTalkAction[122],
			RTResTalkAction[59]
		}
	},
	[32525029] = {
		32525029,
		0,
		Lang.get(82684),
		32525,
		29,
		119,
		{
			RTResTalkAction[21]
		}
	},
	[32525030] = {
		32525030,
		0,
		Lang.get(82685),
		32525,
		30,
		1052,
		{
			RTResTalkAction[53],
			RTResTalkAction[6]
		}
	},
	[32526001] = {
		32526001,
		0,
		Lang.get(82686),
		32526,
		1,
		1051,
		nil,
		1,
		nil,
		nil,
		nil,
		57,
		32615,
		nil,
		nil,
		nil,
		nil,
		nil,
		32615
	},
	[32526002] = {
		32526002,
		0,
		Lang.get(82687),
		32526,
		2,
		1051,
		nil,
		1
	},
	[32526003] = {
		32526003,
		0,
		Lang.get(82688),
		32526,
		3,
		300
	},
	[32526004] = {
		32526004,
		0,
		Lang.get(82689),
		32526,
		4,
		1051,
		{
			RTResTalkAction[183]
		},
		nil,
		nil,
		3
	},
	[32526005] = {
		32526005,
		0,
		Lang.get(82690),
		32526,
		5,
		1051,
		{
			RTResTalkAction[183]
		}
	},
	[32526006] = {
		32526006,
		0,
		Lang.get(82691),
		32526,
		6,
		1051,
		{
			RTResTalkAction[184]
		}
	},
	[32526007] = {
		32526007,
		4,
		nil,
		32526,
		7,
		300,
		{
			RTResTalkAction[183]
		},
		[29] = {
			{
				id = 32526008,
				branch_content = Lang.get(82692)
			},
			{
				id = 32526008,
				branch_content = Lang.get(82693)
			}
		}
	},
	[32526008] = {
		32526008,
		0,
		Lang.get(82694),
		32526,
		8,
		1051,
		{
			RTResTalkAction[183]
		}
	},
	[32526009] = {
		32526009,
		0,
		Lang.get(82695),
		32526,
		9,
		300,
		{
			RTResTalkAction[183]
		}
	},
	[32526010] = {
		32526010,
		0,
		Lang.get(82696),
		32526,
		10,
		1051,
		{
			RTResTalkAction[183]
		}
	},
	[32526011] = {
		32526011,
		0,
		Lang.get(82697),
		32526,
		11,
		1051,
		{
			RTResTalkAction[183]
		}
	},
	[32526012] = {
		32526012,
		0,
		Lang.get(82698),
		32526,
		12,
		300,
		{
			RTResTalkAction[183]
		}
	},
	[32526013] = {
		32526013,
		0,
		Lang.get(82699),
		32526,
		13,
		1051,
		{
			RTResTalkAction[183]
		}
	},
	[32526014] = {
		32526014,
		0,
		Lang.get(82700),
		32526,
		14,
		1051,
		{
			RTResTalkAction[183]
		}
	},
	[32526015] = {
		32526015,
		0,
		Lang.get(82701),
		32526,
		15,
		300,
		{
			RTResTalkAction[183]
		}
	},
	[32526016] = {
		32526016,
		0,
		Lang.get(82702),
		32526,
		16,
		1051,
		{
			RTResTalkAction[184]
		}
	},
	[32526017] = {
		32526017,
		3,
		Lang.get(82703),
		32526,
		17,
		605,
		{
			RTResTalkAction[185]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		1,
		[22] = 1,
		[20] = 255
	},
	[32526018] = {
		32526018,
		0,
		Lang.get(82704),
		32526,
		18,
		1048,
		nil,
		1,
		4,
		nil,
		nil,
		158,
		32616,
		nil,
		nil,
		nil,
		nil,
		nil,
		32616,
		0
	},
	[32526019] = {
		32526019,
		0,
		Lang.get(82705),
		32526,
		19,
		46,
		nil,
		1,
		0
	},
	[32526020] = {
		32526020,
		3,
		Lang.get(82706),
		32526,
		20,
		605,
		[22] = 1
	},
	[32526021] = {
		32526021,
		0,
		Lang.get(82707),
		32526,
		21,
		1052,
		{
			RTResTalkAction[53]
		},
		nil,
		nil,
		3
	},
	[32526022] = {
		32526022,
		0,
		Lang.get(82708),
		32526,
		22,
		119,
		{
			RTResTalkAction[90],
			RTResTalkAction[59]
		}
	},
	[32526023] = {
		32526023,
		0,
		Lang.get(82709),
		32526,
		23,
		1048,
		{
			RTResTalkAction[186],
			RTResTalkAction[6]
		}
	},
	[32526024] = {
		32526024,
		0,
		Lang.get(82710),
		32526,
		24,
		1055,
		{
			RTResTalkAction[187],
			RTResTalkAction[188]
		}
	},
	[32526025] = {
		32526025,
		0,
		Lang.get(82711),
		32526,
		25,
		1055,
		{
			RTResTalkAction[112],
			RTResTalkAction[188]
		}
	},
	[32526026] = {
		32526026,
		0,
		Lang.get(82712),
		32526,
		26,
		1048,
		{
			RTResTalkAction[112],
			RTResTalkAction[188]
		}
	},
	[32526027] = {
		32526027,
		0,
		Lang.get(82713),
		32526,
		27,
		1048,
		{
			RTResTalkAction[112],
			RTResTalkAction[188]
		}
	},
	[32526028] = {
		32526028,
		0,
		Lang.get(82714),
		32526,
		28,
		1048,
		{
			RTResTalkAction[112],
			RTResTalkAction[188]
		}
	},
	[32526029] = {
		32526029,
		0,
		Lang.get(82715),
		32526,
		29,
		1055,
		{
			RTResTalkAction[112],
			RTResTalkAction[188]
		}
	},
	[32526030] = {
		32526030,
		0,
		Lang.get(82716),
		32526,
		30,
		1055,
		{
			RTResTalkAction[189],
			RTResTalkAction[80]
		}
	},
	[32526031] = {
		32526031,
		0,
		Lang.get(82717),
		32526,
		31,
		1048,
		{
			RTResTalkAction[190],
			RTResTalkAction[141]
		}
	},
	[32526032] = {
		32526032,
		0,
		Lang.get(82718),
		32526,
		32,
		46,
		{
			RTResTalkAction[81],
			RTResTalkAction[80]
		}
	},
	[32527001] = {
		32527001,
		0,
		Lang.get(82719),
		32527,
		1,
		46,
		nil,
		1,
		nil,
		nil,
		nil,
		148,
		32620,
		nil,
		nil,
		nil,
		nil,
		nil,
		32620
	},
	[32527002] = {
		32527002,
		0,
		Lang.get(82720),
		32527,
		2,
		46,
		nil,
		1
	},
	[32527003] = {
		32527003,
		0,
		Lang.get(82721),
		32527,
		3,
		46,
		nil,
		1
	},
	[32527004] = {
		32527004,
		0,
		Lang.get(82722),
		32527,
		4,
		1052,
		{
			RTResTalkAction[53]
		},
		nil,
		nil,
		3
	},
	[32527005] = {
		32527005,
		0,
		Lang.get(82723),
		32527,
		5,
		119,
		{
			RTResTalkAction[176],
			RTResTalkAction[52]
		}
	},
	[32527006] = {
		32527006,
		0,
		Lang.get(82724),
		32527,
		6,
		1052,
		{
			RTResTalkAction[176],
			RTResTalkAction[52]
		}
	},
	[32527007] = {
		32527007,
		0,
		Lang.get(82725),
		32527,
		7,
		1048,
		{
			RTResTalkAction[78],
			RTResTalkAction[59],
			RTResTalkAction[6]
		}
	},
	[32527008] = {
		32527008,
		0,
		Lang.get(82726),
		32527,
		8,
		1055,
		{
			RTResTalkAction[112],
			RTResTalkAction[188]
		}
	},
	[32527009] = {
		32527009,
		3,
		Lang.get(82727),
		32527,
		9,
		605,
		{
			RTResTalkAction[160],
			RTResTalkAction[141]
		},
		[22] = 1
	},
	[32527010] = {
		32527010,
		0,
		Lang.get(82728),
		32527,
		10,
		1048,
		{
			RTResTalkAction[88]
		}
	},
	[32527011] = {
		32527011,
		0,
		Lang.get(82729),
		32527,
		11,
		1048,
		{
			RTResTalkAction[88]
		}
	},
	[32527012] = {
		32527012,
		0,
		Lang.get(82730),
		32527,
		12,
		1048,
		{
			RTResTalkAction[159]
		}
	},
	[32527013] = {
		32527013,
		0,
		Lang.get(82731),
		32527,
		13,
		1055,
		{
			RTResTalkAction[137],
			RTResTalkAction[80]
		}
	},
	[32527014] = {
		32527014,
		0,
		Lang.get(82732),
		32527,
		14,
		1055,
		{
			RTResTalkAction[137]
		}
	},
	[32527015] = {
		32527015,
		0,
		Lang.get(82733),
		32527,
		15,
		1055,
		{
			RTResTalkAction[191]
		}
	},
	[32527016] = {
		32527016,
		0,
		Lang.get(82734),
		32527,
		16,
		1048,
		{
			RTResTalkAction[88],
			RTResTalkAction[141]
		}
	},
	[32527017] = {
		32527017,
		2,
		Lang.get(82735),
		32527,
		17,
		1048,
		{
			RTResTalkAction[88]
		}
	},
	[32527018] = {
		32527018,
		2,
		Lang.get(82736),
		32527,
		18,
		1048,
		{
			RTResTalkAction[84]
		}
	},
	[32527019] = {
		32527019,
		0,
		Lang.get(22389),
		32527,
		19,
		1055,
		{
			RTResTalkAction[137],
			RTResTalkAction[80]
		}
	},
	[32527020] = {
		32527020,
		3,
		Lang.get(82737),
		32527,
		20,
		605,
		{
			RTResTalkAction[141]
		},
		[22] = 1
	},
	[32527021] = {
		32527021,
		3,
		Lang.get(82738),
		32527,
		21,
		605,
		[22] = 1
	},
	[32527022] = {
		32527022,
		0,
		Lang.get(82739),
		32527,
		22,
		1048,
		{
			RTResTalkAction[160]
		},
		nil,
		nil,
		nil,
		nil,
		163,
		nil,
		1
	},
	[32527023] = {
		32527023,
		0,
		Lang.get(82740),
		32527,
		23,
		1048,
		{
			RTResTalkAction[159]
		}
	},
	[32527024] = {
		32527024,
		5,
		Lang.get(82741),
		32527,
		24,
		46,
		{
			RTResTalkAction[81],
			RTResTalkAction[80]
		}
	},
	[32527025] = {
		32527025,
		0,
		Lang.get(82742),
		32527,
		25,
		1055,
		{
			RTResTalkAction[191],
			RTResTalkAction[83]
		}
	},
	[32528001] = {
		32528001,
		0,
		Lang.get(82743),
		32528,
		1,
		46,
		{
			RTResTalkAction[81]
		},
		nil,
		nil,
		3,
		nil,
		163,
		32625,
		1,
		nil,
		nil,
		nil,
		nil,
		32625
	},
	[32528002] = {
		32528002,
		0,
		Lang.get(82744),
		32528,
		2,
		119,
		{
			RTResTalkAction[37],
			RTResTalkAction[83]
		}
	},
	[32528003] = {
		32528003,
		0,
		Lang.get(82745),
		32528,
		3,
		1052,
		{
			RTResTalkAction[192],
			RTResTalkAction[6]
		}
	},
	[32528004] = {
		32528004,
		3,
		Lang.get(82746),
		32528,
		4,
		605,
		{
			RTResTalkAction[59]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		nil,
		nil,
		1,
		[22] = 1,
		[20] = 255
	},
	[32528005] = {
		32528005,
		0,
		Lang.get(82747),
		32528,
		5,
		257,
		{
			RTResTalkAction[169]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		32626,
		1,
		[19] = 32626,
		[20] = 0
	},
	[32528006] = {
		32528006,
		0,
		Lang.get(82748),
		32528,
		6,
		257,
		{
			RTResTalkAction[173]
		}
	},
	[32528007] = {
		32528007,
		0,
		Lang.get(82749),
		32528,
		7,
		1066,
		{
			RTResTalkAction[170],
			RTResTalkAction[172]
		}
	},
	[32528008] = {
		32528008,
		0,
		Lang.get(82750),
		32528,
		8,
		1066,
		{
			RTResTalkAction[170],
			RTResTalkAction[172]
		}
	},
	[32528009] = {
		32528009,
		0,
		Lang.get(82751),
		32528,
		9,
		257,
		{
			RTResTalkAction[169],
			RTResTalkAction[61]
		}
	},
	[32528010] = {
		32528010,
		3,
		Lang.get(82752),
		32528,
		10,
		605,
		{
			RTResTalkAction[174]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[22] = 1,
		[20] = 255
	},
	[32528011] = {
		32528011,
		0,
		Lang.get(82753),
		32528,
		11,
		46,
		nil,
		nil,
		nil,
		3,
		nil,
		nil,
		32627,
		1,
		nil,
		nil,
		nil,
		nil,
		32627,
		0
	},
	[32528012] = {
		32528012,
		0,
		"……！",
		32528,
		12,
		1048,
		{
			RTResTalkAction[111]
		}
	},
	[32528013] = {
		32528013,
		0,
		"……",
		32528,
		13,
		1055,
		{
			RTResTalkAction[137],
			RTResTalkAction[80]
		}
	},
	[32528014] = {
		32528014,
		0,
		Lang.get(82754),
		32528,
		14,
		46,
		{
			RTResTalkAction[81],
			RTResTalkAction[141]
		}
	},
	[32528015] = {
		32528015,
		0,
		Lang.get(82755),
		32528,
		15,
		46,
		{
			RTResTalkAction[81]
		}
	},
	[32528016] = {
		32528016,
		0,
		Lang.get(82756),
		32528,
		16,
		1055,
		{
			RTResTalkAction[137],
			RTResTalkAction[83]
		}
	},
	[32528017] = {
		32528017,
		0,
		Lang.get(18219),
		32528,
		17,
		1048,
		{
			RTResTalkAction[78],
			RTResTalkAction[141]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[32528018] = {
		32528018,
		0,
		Lang.get(82757),
		32528,
		18,
		1055,
		{
			RTResTalkAction[137],
			RTResTalkAction[80]
		}
	},
	[32528019] = {
		32528019,
		0,
		Lang.get(82758),
		32528,
		19,
		1055,
		{
			RTResTalkAction[137]
		}
	},
	[32528020] = {
		32528020,
		5,
		Lang.get(82759),
		32528,
		20,
		46,
		{
			RTResTalkAction[81],
			RTResTalkAction[141]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[32528021] = {
		32528021,
		5,
		Lang.get(82760),
		32528,
		21,
		46,
		{
			RTResTalkAction[81]
		},
		nil,
		nil,
		nil,
		1222,
		120
	},
	[32528022] = {
		32528022,
		5,
		Lang.get(82761),
		32528,
		22,
		119,
		{
			RTResTalkAction[193],
			RTResTalkAction[83]
		}
	},
	[32528023] = {
		32528023,
		3,
		Lang.get(82762),
		32528,
		23,
		605,
		{
			RTResTalkAction[6]
		},
		nil,
		nil,
		nil,
		1222,
		[22] = 1
	},
	[32528024] = {
		32528024,
		0,
		Lang.get(82763),
		32528,
		24,
		1048,
		{
			RTResTalkAction[194]
		}
	},
	[32528025] = {
		32528025,
		0,
		Lang.get(82764),
		32528,
		25,
		300,
		{
			RTResTalkAction[88]
		}
	},
	[32528026] = {
		32528026,
		0,
		Lang.get(34907),
		32528,
		26,
		1048,
		{
			RTResTalkAction[87]
		}
	},
	[32528027] = {
		32528027,
		3,
		Lang.get(82765),
		32528,
		27,
		605,
		{
			RTResTalkAction[80]
		},
		[22] = 1
	},
	[32529001] = {
		32529001,
		0,
		Lang.get(54135),
		32529,
		1,
		140,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		32630,
		nil,
		nil,
		nil,
		nil,
		nil,
		32630
	},
	[32529002] = {
		32529002,
		0,
		Lang.get(82766),
		32529,
		2,
		140,
		nil,
		1
	},
	[32529003] = {
		32529003,
		0,
		Lang.get(82767),
		32529,
		3,
		1055,
		nil,
		1
	},
	[32529004] = {
		32529004,
		0,
		Lang.get(82768),
		32529,
		4,
		1055,
		nil,
		1
	},
	[32529005] = {
		32529005,
		0,
		Lang.get(82769),
		32529,
		5,
		1055,
		nil,
		1
	},
	[32529006] = {
		32529006,
		0,
		Lang.get(82770),
		32529,
		6,
		140,
		{
			RTResTalkAction[195]
		},
		nil,
		nil,
		3
	},
	[32529007] = {
		32529007,
		0,
		Lang.get(82771),
		32529,
		7,
		140,
		{
			RTResTalkAction[196]
		}
	},
	[32529008] = {
		32529008,
		0,
		Lang.get(82772),
		32529,
		8,
		1055,
		{
			RTResTalkAction[197],
			RTResTalkAction[188]
		}
	},
	[32529009] = {
		32529009,
		0,
		Lang.get(82773),
		32529,
		9,
		140,
		{
			RTResTalkAction[198],
			RTResTalkAction[141]
		}
	},
	[32529010] = {
		32529010,
		0,
		Lang.get(82774),
		32529,
		10,
		1053,
		{
			RTResTalkAction[199],
			RTResTalkAction[200]
		}
	},
	[32529011] = {
		32529011,
		0,
		Lang.get(82775),
		32529,
		11,
		1053,
		{
			RTResTalkAction[201]
		}
	},
	[32529012] = {
		32529012,
		3,
		Lang.get(82776),
		32529,
		12,
		605,
		{
			RTResTalkAction[202]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[22] = 1,
		[20] = 255
	},
	[32529013] = {
		32529013,
		0,
		Lang.get(82777),
		32529,
		13,
		1048,
		nil,
		1,
		0,
		nil,
		nil,
		153,
		32631,
		1,
		nil,
		nil,
		nil,
		nil,
		32631,
		0
	},
	[32529014] = {
		32529014,
		0,
		Lang.get(19533),
		32529,
		14,
		300
	},
	[32529015] = {
		32529015,
		0,
		Lang.get(82778),
		32529,
		15,
		300
	},
	[32529016] = {
		32529016,
		0,
		Lang.get(82779),
		32529,
		16,
		1048,
		{
			RTResTalkAction[88]
		},
		nil,
		nil,
		3
	},
	[32529017] = {
		32529017,
		0,
		Lang.get(82780),
		32529,
		17,
		1048,
		{
			RTResTalkAction[88]
		}
	},
	[32529018] = {
		32529018,
		0,
		Lang.get(82781),
		32529,
		18,
		300,
		{
			RTResTalkAction[80]
		}
	},
	[32529019] = {
		32529019,
		0,
		Lang.get(82782),
		32529,
		19,
		119,
		{
			RTResTalkAction[10]
		}
	},
	[32529020] = {
		32529020,
		0,
		Lang.get(82783),
		32529,
		20,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[32529021] = {
		32529021,
		0,
		Lang.get(82784),
		32529,
		21,
		1048,
		{
			RTResTalkAction[88]
		}
	},
	[32529022] = {
		32529022,
		0,
		Lang.get(82785),
		32529,
		22,
		300,
		{
			RTResTalkAction[88]
		}
	},
	[32529023] = {
		32529023,
		0,
		Lang.get(82786),
		32529,
		23,
		1048,
		{
			RTResTalkAction[88]
		}
	},
	[32529024] = {
		32529024,
		0,
		Lang.get(82787),
		32529,
		24,
		1048,
		{
			RTResTalkAction[88]
		}
	},
	[32529025] = {
		32529025,
		0,
		Lang.get(82788),
		32529,
		25,
		300,
		{
			RTResTalkAction[88]
		}
	},
	[32529026] = {
		32529026,
		0,
		Lang.get(82789),
		32529,
		26,
		1048,
		{
			RTResTalkAction[88]
		}
	},
	[32529027] = {
		32529027,
		0,
		Lang.get(82790),
		32529,
		27,
		1048,
		{
			RTResTalkAction[159]
		}
	},
	[32529028] = {
		32529028,
		0,
		Lang.get(82791),
		32529,
		28,
		300,
		{
			RTResTalkAction[80]
		}
	},
	[32529029] = {
		32529029,
		0,
		Lang.get(82792),
		32529,
		29,
		1051,
		nil,
		1,
		nil,
		nil,
		nil,
		187,
		32633,
		nil,
		nil,
		nil,
		nil,
		nil,
		32632
	},
	[32529030] = {
		32529030,
		0,
		Lang.get(82793),
		32529,
		30,
		1050,
		nil,
		1
	},
	[32529031] = {
		32529031,
		0,
		Lang.get(34640),
		32529,
		31,
		1049,
		nil,
		1
	},
	[32529032] = {
		32529032,
		0,
		Lang.get(82794),
		32529,
		32,
		1049,
		nil,
		1
	},
	[32529033] = {
		32529033,
		0,
		Lang.get(82795),
		32529,
		33,
		1051,
		nil,
		1
	},
	[32529034] = {
		32529034,
		0,
		Lang.get(82796),
		32529,
		34,
		1048,
		{
			RTResTalkAction[88]
		},
		nil,
		nil,
		3
	},
	[32529035] = {
		32529035,
		0,
		Lang.get(82797),
		32529,
		35,
		1048,
		{
			RTResTalkAction[88]
		}
	},
	[32529036] = {
		32529036,
		0,
		Lang.get(71573),
		32529,
		36,
		1050,
		{
			RTResTalkAction[142],
			RTResTalkAction[80]
		}
	},
	[32529037] = {
		32529037,
		0,
		Lang.get(82798),
		32529,
		37,
		1051,
		{
			RTResTalkAction[183],
			RTResTalkAction[143]
		}
	},
	[32529038] = {
		32529038,
		0,
		Lang.get(23241),
		32529,
		38,
		1050,
		{
			RTResTalkAction[142],
			RTResTalkAction[185]
		}
	},
	[32529039] = {
		32529039,
		0,
		Lang.get(82799),
		32529,
		39,
		1048,
		{
			RTResTalkAction[88],
			RTResTalkAction[143]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[32529040] = {
		32529040,
		0,
		Lang.get(34473),
		32529,
		40,
		300,
		{
			RTResTalkAction[88]
		}
	},
	[32529041] = {
		32529041,
		0,
		Lang.get(82800),
		32529,
		41,
		1048,
		{
			RTResTalkAction[88]
		}
	},
	[32529042] = {
		32529042,
		0,
		Lang.get(82801),
		32529,
		42,
		300,
		{
			RTResTalkAction[88]
		}
	},
	[32529043] = {
		32529043,
		0,
		Lang.get(20129),
		32529,
		43,
		1048,
		{
			RTResTalkAction[159]
		}
	},
	[32529044] = {
		32529044,
		3,
		Lang.get(82802),
		32529,
		44,
		605,
		{
			RTResTalkAction[80]
		},
		[22] = 1
	},
	[32529045] = {
		32529045,
		3,
		Lang.get(82803),
		32529,
		45,
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
