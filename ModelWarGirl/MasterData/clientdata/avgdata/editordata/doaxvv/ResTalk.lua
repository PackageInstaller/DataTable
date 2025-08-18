-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\DOAXVV\\ResTalk.lua

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
	1048,
	{
		2
	},
	nil,
	4
}
RTResTalkAction[2] = {
	[1] = 1,
	[2] = 1048
}
RTResTalkAction[3] = {
	1,
	1048,
	nil,
	nil,
	0
}
RTResTalkAction[4] = {
	1,
	1048,
	nil,
	nil,
	3
}
RTResTalkAction[5] = {
	[1] = 1,
	[2] = 1048,
	[3] = {
		2
	}
}
RTResTalkAction[6] = {
	[1] = 0,
	[2] = 1048
}
RTResTalkAction[7] = {
	1,
	1145,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[8] = {
	[1] = 2,
	[2] = 1144
}
RTResTalkAction[9] = {
	[1] = 3,
	[2] = 1145
}
RTResTalkAction[10] = {
	[1] = 1,
	[2] = 1048,
	[3] = {
		1
	}
}
RTResTalkAction[11] = {
	[1] = 0,
	[2] = 1144
}
RTResTalkAction[12] = {
	[1] = 0,
	[2] = 1145
}
RTResTalkAction[13] = {
	[1] = 2,
	[2] = 1144,
	[3] = {
		2
	}
}
RTResTalkAction[14] = {
	1,
	1146,
	nil,
	nil,
	0
}
RTResTalkAction[15] = {
	[1] = 2,
	[2] = 1147
}
RTResTalkAction[16] = {
	3,
	1146,
	nil,
	nil,
	0
}
RTResTalkAction[17] = {
	[1] = 3,
	[2] = 1146
}
RTResTalkAction[18] = {
	1,
	1147,
	nil,
	nil,
	2
}
RTResTalkAction[19] = {
	[1] = 0,
	[2] = 1146
}
RTResTalkAction[20] = {
	1,
	1147,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[21] = {
	3,
	1146,
	nil,
	nil,
	1
}
RTResTalkAction[22] = {
	2,
	1147,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[23] = {
	3,
	1146,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[24] = {
	[1] = 1,
	[2] = 1165,
	[3] = {
		1
	}
}
RTResTalkAction[25] = {
	[1] = 0,
	[2] = 1147
}
RTResTalkAction[26] = {
	[1] = 0,
	[2] = 1165
}
RTResTalkAction[27] = {
	[1] = 1,
	[2] = 1165,
	[3] = {
		3
	}
}
RTResTalkAction[28] = {
	1,
	1147,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[29] = {
	[1] = 1,
	[2] = 1053
}
RTResTalkAction[30] = {
	[1] = 1,
	[2] = 1165
}
RTResTalkAction[31] = {
	[1] = 0,
	[2] = 1053
}
RTResTalkAction[32] = {
	[1] = 1,
	[2] = 1052
}
RTResTalkAction[33] = {
	[1] = 1,
	[2] = 1165,
	[3] = {
		2
	}
}
RTResTalkAction[34] = {
	[1] = 0,
	[2] = 1052
}
RTResTalkAction[35] = {
	[1] = 1,
	[2] = 1053,
	[3] = {
		2
	}
}
RTResTalkAction[36] = {
	[1] = 2,
	[2] = 1053
}
RTResTalkAction[37] = {
	3,
	1165,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[38] = {
	[1] = 1,
	[2] = 1163
}
RTResTalkAction[39] = {
	[1] = 0,
	[2] = 1163
}
RTResTalkAction[40] = {
	3,
	1146,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[41] = {
	1,
	1147,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[42] = {
	[1] = 1,
	[2] = 1146
}
RTResTalkAction[43] = {
	[1] = 1,
	[2] = 1053,
	[3] = {
		3
	}
}
RTResTalkAction[44] = {
	2,
	1146,
	nil,
	nil,
	2
}
RTResTalkAction[45] = {
	[1] = 3,
	[2] = 1147
}
RTResTalkAction[46] = {
	[1] = 2,
	[2] = 1146
}
RTResTalkAction[47] = {
	3,
	1147,
	nil,
	nil,
	2
}
RTResTalkAction[48] = {
	1,
	1163,
	nil,
	nil,
	0
}
RTResTalkAction[49] = {
	[1] = 1,
	[2] = 1052,
	[3] = {
		1
	}
}
RTResTalkAction[50] = {
	1,
	1147,
	nil,
	nil,
	1
}
RTResTalkAction[51] = {
	1,
	1147,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[52] = {
	1,
	1053,
	nil,
	nil,
	0
}
RTResTalkAction[53] = {
	[1] = 1,
	[2] = 1147
}
RTResTalkAction[54] = {
	[1] = 2,
	[2] = 1147,
	[3] = {
		1
	}
}
RTResTalkAction[55] = {
	[1] = 1,
	[2] = 1146,
	[3] = {
		3
	}
}
RTResTalkAction[56] = {
	[1] = 1,
	[2] = 1073
}
RTResTalkAction[57] = {
	[1] = 0,
	[2] = 1073
}
RTResTalkAction[58] = {
	1,
	1048,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[59] = {
	3,
	1146,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[60] = {
	1,
	1146,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[61] = {
	[1] = 1,
	[2] = 1163,
	[3] = {
		3
	}
}
RTResTalkAction[62] = {
	[1] = 1,
	[2] = 235
}
RTResTalkAction[63] = {
	1,
	1048,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[64] = {
	[1] = 0,
	[2] = 235
}
RTResTalkAction[65] = {
	[1] = 1,
	[2] = 235,
	[3] = {
		2
	}
}
RTResTalkAction[66] = {
	[1] = 2,
	[2] = 1054
}
RTResTalkAction[67] = {
	[1] = 3,
	[2] = 235
}
RTResTalkAction[68] = {
	[1] = 0,
	[2] = 1054
}
RTResTalkAction[69] = {
	[1] = 2,
	[2] = 1054,
	[3] = {
		2
	}
}
RTResTalkAction[70] = {
	[1] = 3,
	[2] = 235,
	[3] = {
		3
	}
}
RTResTalkAction[71] = {
	[1] = 1,
	[2] = 1147,
	[3] = {
		1
	}
}
RTResTalkAction[72] = {
	2,
	1147,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[73] = {
	3,
	1146,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[74] = {
	[1] = 1,
	[2] = 1050
}
RTResTalkAction[75] = {
	[1] = 0,
	[2] = 1050
}
RTResTalkAction[76] = {
	1,
	1147,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[77] = {
	1,
	1064,
	nil,
	nil,
	0
}
RTResTalkAction[78] = {
	[1] = 1,
	[2] = 1064
}
RTResTalkAction[79] = {
	[1] = 0,
	[2] = 1064
}
RTResTalkAction[80] = {
	[1] = 3,
	[2] = 1146,
	[3] = {
		2
	}
}
RTResTalkAction[81] = {
	1,
	1146,
	nil,
	nil,
	2
}
RTResTalkAction[82] = {
	1,
	1064,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[83] = {
	[1] = 2,
	[2] = 1064
}
RTResTalkAction[84] = {
	[1] = 3,
	[2] = 1050
}
RTResTalkAction[85] = {
	[1] = 1,
	[2] = 1050,
	[3] = {
		3
	}
}
RTResTalkAction[86] = {
	[1] = 1,
	[2] = 1163,
	[3] = {
		1
	}
}
RTResTalkAction[87] = {
	1,
	1048,
	nil,
	nil,
	4
}
RTResTalkAction[88] = {
	[1] = 2,
	[2] = 1050
}
RTResTalkAction[89] = {
	[1] = 3,
	[2] = 1064
}
RTResTalkAction[90] = {
	1,
	1146,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[91] = {
	[1] = 1,
	[2] = 1163,
	[3] = {
		2
	}
}
RTResTalkAction[92] = {
	[1] = 3,
	[2] = 1073
}
RTResTalkAction[93] = {
	3,
	1073,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[94] = {
	[1] = 2,
	[2] = 1050,
	[3] = {
		1
	}
}
RTResTalkAction[95] = {
	[1] = 3,
	[2] = 1073,
	[3] = {
		2
	}
}
RTResTalkAction[96] = {
	[1] = 2,
	[2] = 1050,
	[3] = {
		2
	}
}
RTResTalkAction[97] = {
	3,
	1073,
	nil,
	nil,
	0
}
RTResTalkAction[98] = {
	1,
	1073,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[99] = {
	1,
	1053,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[100] = {
	[1] = 1,
	[2] = 1049,
	[3] = {
		3
	}
}
RTResTalkAction[101] = {
	[1] = 0,
	[2] = 1049
}
RTResTalkAction[102] = {
	[1] = 1,
	[2] = 1049
}
RTResTalkAction[103] = {
	1,
	1146,
	nil,
	nil,
	1
}
RTResTalkAction[104] = {
	[1] = 1,
	[2] = 1051,
	[3] = {
		2
	}
}
RTResTalkAction[105] = {
	[1] = 1,
	[2] = 1051
}
RTResTalkAction[106] = {
	[1] = 1,
	[2] = 1051,
	[3] = {
		3
	}
}
RTResTalkAction[107] = {
	1,
	1147,
	nil,
	nil,
	0
}
RTResTalkAction[108] = {
	[1] = 0,
	[2] = 1051
}
RTResTalkAction[109] = {
	1,
	1146,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[110] = {
	3,
	1147,
	nil,
	nil,
	1
}
RTResTalkAction[111] = {
	1,
	1049,
	nil,
	nil,
	0
}
RTResTalkAction[112] = {
	1,
	1048,
	nil,
	nil,
	2
}
RTResTalkAction[113] = {
	[1] = 2,
	[2] = 235
}
RTResTalkAction[114] = {
	[1] = 3,
	[2] = 1054
}
RTResTalkAction[115] = {
	[1] = 2,
	[2] = 1051
}
RTResTalkAction[116] = {
	[1] = 3,
	[2] = 1049
}
RTResTalkAction[117] = {
	[1] = 1,
	[2] = 1049,
	[3] = {
		2
	}
}
RTResTalkAction[118] = {
	[1] = 1,
	[2] = 1146,
	[3] = {
		2
	}
}
RTResTalkAction[119] = {
	1,
	1073,
	nil,
	nil,
	1
}
RTResTalkAction[120] = {
	1,
	235,
	nil,
	nil,
	0
}
RTResTalkAction[121] = {
	[1] = 1,
	[2] = 1054
}
RTResTalkAction[122] = {
	[1] = 1,
	[2] = 1073,
	[3] = {
		2
	}
}
RTResTalkAction[123] = {
	[1] = 3,
	[2] = 1052,
	[3] = {
		2
	}
}
RTResTalkAction[124] = {
	[1] = 1,
	[2] = 1050,
	[3] = {
		2
	}
}
RTResTalkAction[125] = {
	[1] = 1,
	[2] = 1148,
	[3] = {
		1
	}
}
RTResTalkAction[126] = {
	[1] = 0,
	[2] = 1148
}
RTResTalkAction[127] = {
	[1] = 1,
	[2] = 1148
}
RTResTalkAction[128] = {
	[1] = 1,
	[2] = 1148,
	[3] = {
		3
	}
}
RTResTalkAction[129] = {
	[1] = 1,
	[2] = 1064,
	[3] = {
		3
	}
}
RTResTalkAction[130] = {
	[1] = 1,
	[2] = 1054,
	[3] = {
		2
	}
}
RTResTalkAction[131] = {
	[1] = 3,
	[2] = 1053
}
RTResTalkAction[132] = {
	1,
	1048,
	{
		3
	},
	nil,
	3
}
RTResTalkAction[133] = {
	1,
	1148,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[134] = {
	1,
	1146,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[135] = {
	3,
	1147,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[136] = {
	[1] = 2,
	[2] = 1073
}
RTResTalkAction[137] = {
	3,
	1048,
	nil,
	nil,
	0
}
RTResTalkAction[138] = {
	[1] = 2,
	[2] = 1073,
	[3] = {
		2
	}
}
RTResTalkAction[139] = {
	[1] = 3,
	[2] = 1048
}
RTResTalkAction[140] = {
	[1] = 3,
	[2] = 1048,
	[3] = {
		2
	}
}
RTResTalkAction[141] = {
	2,
	1073,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[142] = {
	1,
	1146,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[143] = {
	[1] = 3,
	[2] = 235,
	[3] = {
		2
	}
}
RTResTalkAction[144] = {
	2,
	1147,
	nil,
	nil,
	0
}
RTResTalkAction[145] = {
	2,
	1147,
	nil,
	nil,
	2
}
RTResTalkAction[146] = {
	1,
	1146,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[147] = {
	[1] = 1,
	[2] = 423
}
RTResTalkAction[148] = {
	[1] = 0,
	[2] = 423
}
RTResTalkAction[149] = {
	[1] = 3,
	[2] = 1163
}
RTResTalkAction[150] = {
	[1] = 2,
	[2] = 1048
}
RTResTalkAction[151] = {
	1,
	1146,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[152] = {
	1,
	1054,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[153] = {
	[1] = 1,
	[2] = 1051,
	[3] = {
		1
	}
}
RTResTalkAction[154] = {
	[1] = 2,
	[2] = 1052,
	[3] = {
		3
	}
}
RTResTalkAction[155] = {
	[1] = 1,
	[2] = 1145
}
RTResTalkAction[156] = {
	[1] = 2,
	[2] = 1145
}
RTResTalkAction[157] = {
	[1] = 3,
	[2] = 1144,
	[3] = {
		2
	}
}

local Data = {
	[34701001] = {
		34701001,
		9,
		Lang.get(89119),
		34701,
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		194,
		34701,
		nil,
		nil,
		nil,
		nil,
		nil,
		34701,
		255,
		nil,
		1
	},
	[34701002] = {
		34701002,
		0,
		Lang.get(89120),
		34701,
		2,
		300
	},
	[34701003] = {
		34701003,
		9,
		Lang.get(89121),
		34701,
		3,
		[22] = 1
	},
	[34701004] = {
		34701004,
		0,
		Lang.get(87828),
		34701,
		4,
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
	[34701005] = {
		34701005,
		0,
		"……",
		34701,
		5,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		34702,
		1,
		nil,
		nil,
		nil,
		nil,
		34702,
		-1
	},
	[34701006] = {
		34701006,
		0,
		Lang.get(89122),
		34701,
		6,
		1164,
		nil,
		1,
		nil,
		nil,
		nil,
		195
	},
	[34701007] = {
		34701007,
		0,
		Lang.get(89123),
		34701,
		7,
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
	[34701008] = {
		34701008,
		0,
		Lang.get(89124),
		34701,
		8,
		1164,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		34703,
		nil,
		nil,
		nil,
		nil,
		nil,
		34703
	},
	[34701009] = {
		34701009,
		4,
		nil,
		34701,
		9,
		300,
		[22] = 1,
		[29] = {
			{
				id = 34701010,
				branch_content = Lang.get(89125)
			},
			{
				id = 34701010,
				branch_content = Lang.get(89126)
			}
		}
	},
	[34701010] = {
		34701010,
		0,
		Lang.get(89127),
		34701,
		10,
		1164,
		nil,
		1,
		1
	},
	[34701011] = {
		34701011,
		0,
		Lang.get(89128),
		34701,
		11,
		300
	},
	[34701012] = {
		34701012,
		0,
		Lang.get(89129),
		34701,
		12,
		1048,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[34701013] = {
		34701013,
		0,
		Lang.get(89130),
		34701,
		13,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[34701014] = {
		34701014,
		0,
		Lang.get(89131),
		34701,
		14,
		1048,
		{
			RTResTalkAction[3]
		}
	},
	[34701015] = {
		34701015,
		0,
		Lang.get(89132),
		34701,
		15,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[34701016] = {
		34701016,
		0,
		Lang.get(89133),
		34701,
		16,
		1048,
		{
			RTResTalkAction[4]
		}
	},
	[34701017] = {
		34701017,
		0,
		Lang.get(89134),
		34701,
		17,
		1048,
		{
			RTResTalkAction[2]
		}
	},
	[34701018] = {
		34701018,
		0,
		Lang.get(89135),
		34701,
		18,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[34701019] = {
		34701019,
		0,
		Lang.get(89136),
		34701,
		19,
		1048,
		{
			RTResTalkAction[3]
		}
	},
	[34701020] = {
		34701020,
		0,
		Lang.get(89137),
		34701,
		20,
		1048,
		{
			RTResTalkAction[2]
		}
	},
	[34701021] = {
		34701021,
		4,
		nil,
		34701,
		21,
		300,
		{
			RTResTalkAction[2]
		},
		[29] = {
			{
				id = 34701022,
				branch_content = Lang.get(89138)
			},
			{
				id = 34701022,
				branch_content = Lang.get(89139)
			}
		}
	},
	[34701022] = {
		34701022,
		0,
		Lang.get(89140),
		34701,
		22,
		1048,
		{
			RTResTalkAction[5]
		}
	},
	[34701023] = {
		34701023,
		0,
		Lang.get(81830),
		34701,
		23,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[34701024] = {
		34701024,
		0,
		Lang.get(89141),
		34701,
		24,
		1048,
		{
			RTResTalkAction[6]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		34704,
		1,
		1,
		nil,
		1,
		nil,
		34704
	},
	[34701025] = {
		34701025,
		0,
		Lang.get(89142),
		34701,
		25,
		300,
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
	[34702001] = {
		34702001,
		0,
		Lang.get(89143),
		34702,
		1,
		1144,
		nil,
		1,
		0,
		nil,
		nil,
		62,
		34710,
		nil,
		nil,
		nil,
		nil,
		nil,
		34710
	},
	[34702002] = {
		34702002,
		7,
		"99",
		34702,
		2,
		1144
	},
	[34702003] = {
		34702003,
		0,
		Lang.get(89144),
		34702,
		3,
		1145,
		nil,
		1,
		0
	},
	[34702004] = {
		34702004,
		7,
		"100",
		34702,
		4,
		1145
	},
	[34702005] = {
		34702005,
		0,
		Lang.get(89145),
		34702,
		5,
		300
	},
	[34702006] = {
		34702006,
		0,
		Lang.get(89146),
		34702,
		6,
		1048,
		nil,
		1
	},
	[34702007] = {
		34702007,
		0,
		Lang.get(89147),
		34702,
		7,
		300
	},
	[34702008] = {
		34702008,
		0,
		Lang.get(89148),
		34702,
		8,
		1145,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3
	},
	[34702009] = {
		34702009,
		0,
		Lang.get(89149),
		34702,
		9,
		1144,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[34702010] = {
		34702010,
		0,
		Lang.get(89150),
		34702,
		10,
		1145,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[34702011] = {
		34702011,
		0,
		Lang.get(89151),
		34702,
		11,
		300,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[34702012] = {
		34702012,
		0,
		Lang.get(89152),
		34702,
		12,
		1048,
		{
			RTResTalkAction[10],
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[34702013] = {
		34702013,
		3,
		Lang.get(89153),
		34702,
		13,
		605,
		{
			RTResTalkAction[2]
		},
		[22] = 1
	},
	[34702014] = {
		34702014,
		0,
		Lang.get(89154),
		34702,
		14,
		300,
		{
			RTResTalkAction[8],
			RTResTalkAction[9],
			RTResTalkAction[6]
		}
	},
	[34702015] = {
		34702015,
		0,
		Lang.get(89155),
		34702,
		15,
		1145,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[34702016] = {
		34702016,
		0,
		Lang.get(89156),
		34702,
		16,
		1144,
		{
			RTResTalkAction[13],
			RTResTalkAction[9]
		}
	},
	[34702017] = {
		34702017,
		3,
		Lang.get(89157),
		34702,
		17,
		605,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
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
	[34702018] = {
		34702018,
		0,
		Lang.get(89158),
		34702,
		18,
		1147,
		nil,
		1,
		2,
		nil,
		nil,
		153,
		34711,
		1,
		nil,
		nil,
		nil,
		nil,
		34711,
		-1
	},
	[34702019] = {
		34702019,
		0,
		Lang.get(89159),
		34702,
		19,
		1146,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[34702020] = {
		34702020,
		4,
		nil,
		34702,
		20,
		300,
		[29] = {
			{
				id = 34702021,
				branch_content = Lang.get(89160)
			},
			{
				id = 34702021,
				branch_content = Lang.get(89161)
			}
		}
	},
	[34702021] = {
		34702021,
		0,
		Lang.get(89162),
		34702,
		21,
		1147,
		nil,
		1,
		0
	},
	[34702022] = {
		34702022,
		0,
		Lang.get(89163),
		34702,
		22,
		1146,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[34702023] = {
		34702023,
		0,
		Lang.get(89164),
		34702,
		23,
		1147,
		{
			RTResTalkAction[15],
			RTResTalkAction[16]
		}
	},
	[34702024] = {
		34702024,
		0,
		Lang.get(89165),
		34702,
		24,
		300,
		{
			RTResTalkAction[15],
			RTResTalkAction[17]
		}
	},
	[34702025] = {
		34702025,
		0,
		Lang.get(89166),
		34702,
		25,
		1048,
		{
			RTResTalkAction[15],
			RTResTalkAction[17]
		},
		1,
		0
	},
	[34702026] = {
		34702026,
		0,
		Lang.get(89167),
		34702,
		26,
		1146,
		{
			RTResTalkAction[15],
			RTResTalkAction[17]
		}
	},
	[34702027] = {
		34702027,
		0,
		Lang.get(89168),
		34702,
		27,
		300,
		{
			RTResTalkAction[15],
			RTResTalkAction[17]
		}
	},
	[34702028] = {
		34702028,
		0,
		Lang.get(89169),
		34702,
		28,
		1048,
		{
			RTResTalkAction[15],
			RTResTalkAction[17]
		},
		1,
		0
	},
	[34702029] = {
		34702029,
		0,
		Lang.get(89170),
		34702,
		29,
		1147,
		{
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[34703001] = {
		34703001,
		0,
		Lang.get(89171),
		34703,
		1,
		1147,
		nil,
		1,
		2,
		nil,
		nil,
		62,
		34720,
		nil,
		nil,
		nil,
		nil,
		nil,
		34720
	},
	[34703002] = {
		34703002,
		0,
		Lang.get(89172),
		34703,
		2,
		1146,
		nil,
		1,
		1
	},
	[34703003] = {
		34703003,
		0,
		Lang.get(89173),
		34703,
		3,
		1147,
		{
			RTResTalkAction[20]
		},
		nil,
		nil,
		3
	},
	[34703004] = {
		34703004,
		0,
		Lang.get(89174),
		34703,
		4,
		1146,
		{
			RTResTalkAction[15],
			RTResTalkAction[21]
		}
	},
	[34703005] = {
		34703005,
		0,
		Lang.get(89175),
		34703,
		5,
		1146,
		{
			RTResTalkAction[15],
			RTResTalkAction[17]
		}
	},
	[34703006] = {
		34703006,
		0,
		Lang.get(89176),
		34703,
		6,
		300,
		{
			RTResTalkAction[15],
			RTResTalkAction[17]
		}
	},
	[34703007] = {
		34703007,
		0,
		Lang.get(89177),
		34703,
		7,
		1048,
		{
			RTResTalkAction[15],
			RTResTalkAction[17]
		},
		1,
		0
	},
	[34703008] = {
		34703008,
		0,
		Lang.get(67682),
		34703,
		8,
		300,
		{
			RTResTalkAction[15],
			RTResTalkAction[17]
		}
	},
	[34703009] = {
		34703009,
		4,
		nil,
		34703,
		9,
		300,
		{
			RTResTalkAction[15],
			RTResTalkAction[17]
		},
		[29] = {
			{
				id = 34703010,
				branch_content = Lang.get(89178)
			},
			{
				id = 34703010,
				branch_content = Lang.get(89179)
			}
		}
	},
	[34703010] = {
		34703010,
		0,
		Lang.get(89180),
		34703,
		10,
		1147,
		{
			RTResTalkAction[22],
			RTResTalkAction[17]
		}
	},
	[34703011] = {
		34703011,
		0,
		Lang.get(89181),
		34703,
		11,
		1146,
		{
			RTResTalkAction[15],
			RTResTalkAction[23]
		}
	},
	[34703012] = {
		34703012,
		3,
		Lang.get(89182),
		34703,
		12,
		605,
		{
			RTResTalkAction[24],
			RTResTalkAction[25],
			RTResTalkAction[19]
		},
		[22] = 1
	},
	[34703013] = {
		34703013,
		0,
		Lang.get(89183),
		34703,
		13,
		1147,
		{
			RTResTalkAction[18],
			RTResTalkAction[26]
		}
	},
	[34703014] = {
		34703014,
		0,
		Lang.get(89184),
		34703,
		14,
		1053,
		{
			RTResTalkAction[25]
		},
		1,
		nil,
		-1,
		nil,
		60,
		34721,
		nil,
		1,
		nil,
		nil,
		nil,
		34721
	},
	[34703015] = {
		34703015,
		0,
		Lang.get(89185),
		34703,
		15,
		1052,
		nil,
		1
	},
	[34703016] = {
		34703016,
		0,
		Lang.get(89186),
		34703,
		16,
		1165,
		nil,
		1
	},
	[34703017] = {
		34703017,
		3,
		Lang.get(89187),
		34703,
		17,
		605,
		{
			RTResTalkAction[27]
		},
		nil,
		nil,
		3,
		[22] = 1
	},
	[34703018] = {
		34703018,
		0,
		Lang.get(89188),
		34703,
		18,
		1165,
		{
			RTResTalkAction[26]
		},
		1,
		nil,
		-1,
		nil,
		nil,
		34722,
		1,
		1,
		nil,
		1,
		nil,
		34722
	},
	[34703019] = {
		34703019,
		0,
		Lang.get(89189),
		34703,
		19,
		1147,
		{
			RTResTalkAction[28]
		},
		nil,
		nil,
		3
	},
	[34703020] = {
		34703020,
		0,
		Lang.get(89190),
		34703,
		20,
		1053,
		{
			RTResTalkAction[29],
			RTResTalkAction[25]
		}
	},
	[34703021] = {
		34703021,
		0,
		Lang.get(89191),
		34703,
		21,
		1165,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[34703022] = {
		34703022,
		0,
		Lang.get(89192),
		34703,
		22,
		1052,
		{
			RTResTalkAction[32],
			RTResTalkAction[26]
		}
	},
	[34703023] = {
		34703023,
		0,
		Lang.get(89193),
		34703,
		23,
		1165,
		{
			RTResTalkAction[33],
			RTResTalkAction[34]
		}
	},
	[34703024] = {
		34703024,
		0,
		Lang.get(89194),
		34703,
		24,
		1053,
		{
			RTResTalkAction[29],
			RTResTalkAction[26]
		}
	},
	[34703025] = {
		34703025,
		0,
		Lang.get(89195),
		34703,
		25,
		1165,
		{
			RTResTalkAction[27],
			RTResTalkAction[31]
		}
	},
	[34703026] = {
		34703026,
		0,
		Lang.get(89196),
		34703,
		26,
		300,
		{
			RTResTalkAction[30]
		}
	},
	[34703027] = {
		34703027,
		0,
		Lang.get(89197),
		34703,
		27,
		1048,
		{
			RTResTalkAction[30]
		},
		1,
		0
	},
	[34703028] = {
		34703028,
		0,
		Lang.get(89198),
		34703,
		28,
		300,
		{
			RTResTalkAction[30]
		}
	},
	[34703029] = {
		34703029,
		0,
		Lang.get(89199),
		34703,
		29,
		1053,
		{
			RTResTalkAction[35],
			RTResTalkAction[26]
		}
	},
	[34703030] = {
		34703030,
		5,
		Lang.get(89200),
		34703,
		30,
		1163,
		{
			RTResTalkAction[36],
			RTResTalkAction[37]
		},
		1
	},
	[34703031] = {
		34703031,
		0,
		Lang.get(89201),
		34703,
		31,
		300,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[34703032] = {
		34703032,
		0,
		Lang.get(89202),
		34703,
		32,
		1052,
		{
			RTResTalkAction[32],
			RTResTalkAction[26]
		}
	},
	[34703033] = {
		34703033,
		5,
		Lang.get(89203),
		34703,
		33,
		1163,
		{
			RTResTalkAction[38],
			RTResTalkAction[34]
		}
	},
	[34703034] = {
		34703034,
		0,
		Lang.get(89204),
		34703,
		34,
		1053,
		{
			RTResTalkAction[29],
			RTResTalkAction[39]
		}
	},
	[34703035] = {
		34703035,
		0,
		Lang.get(89205),
		34703,
		35,
		1147,
		{
			RTResTalkAction[20],
			RTResTalkAction[31]
		},
		nil,
		nil,
		nil,
		nil,
		158
	},
	[34703036] = {
		34703036,
		0,
		Lang.get(89206),
		34703,
		36,
		1146,
		{
			RTResTalkAction[15],
			RTResTalkAction[40]
		}
	},
	[34703037] = {
		34703037,
		0,
		Lang.get(21987),
		34703,
		37,
		300,
		{
			RTResTalkAction[15],
			RTResTalkAction[17]
		}
	},
	[34703038] = {
		34703038,
		0,
		Lang.get(89207),
		34703,
		38,
		1147,
		{
			RTResTalkAction[41],
			RTResTalkAction[19]
		}
	},
	[34704001] = {
		34704001,
		0,
		Lang.get(89208),
		34704,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		187,
		34730,
		[19] = 34730
	},
	[34704002] = {
		34704002,
		0,
		Lang.get(89209),
		34704,
		2,
		1053,
		nil,
		1
	},
	[34704003] = {
		34704003,
		0,
		Lang.get(89210),
		34704,
		3,
		1163,
		nil,
		1
	},
	[34704004] = {
		34704004,
		0,
		Lang.get(89211),
		34704,
		4,
		1052,
		nil,
		1
	},
	[34704005] = {
		34704005,
		0,
		Lang.get(89212),
		34704,
		5,
		1147,
		nil,
		1,
		0
	},
	[34704006] = {
		34704006,
		0,
		Lang.get(89213),
		34704,
		6,
		1146,
		{
			RTResTalkAction[42]
		},
		nil,
		nil,
		3
	},
	[34704007] = {
		34704007,
		0,
		Lang.get(89214),
		34704,
		7,
		1053,
		{
			RTResTalkAction[36],
			RTResTalkAction[17]
		}
	},
	[34704008] = {
		34704008,
		3,
		Lang.get(89215),
		34704,
		8,
		605,
		{
			RTResTalkAction[29],
			RTResTalkAction[19]
		},
		[22] = 1
	},
	[34704009] = {
		34704009,
		0,
		Lang.get(89216),
		34704,
		9,
		1053,
		{
			RTResTalkAction[43]
		}
	},
	[34704010] = {
		34704010,
		0,
		Lang.get(89217),
		34704,
		10,
		1163,
		{
			RTResTalkAction[38],
			RTResTalkAction[31]
		}
	},
	[34704011] = {
		34704011,
		0,
		Lang.get(89218),
		34704,
		11,
		1146,
		{
			RTResTalkAction[44],
			RTResTalkAction[45],
			RTResTalkAction[39]
		}
	},
	[34704012] = {
		34704012,
		0,
		Lang.get(89219),
		34704,
		12,
		1147,
		{
			RTResTalkAction[46],
			RTResTalkAction[47]
		}
	},
	[34704013] = {
		34704013,
		0,
		Lang.get(89220),
		34704,
		13,
		1163,
		{
			RTResTalkAction[48],
			RTResTalkAction[19],
			RTResTalkAction[25]
		}
	},
	[34704014] = {
		34704014,
		0,
		Lang.get(89221),
		34704,
		14,
		1052,
		{
			RTResTalkAction[32],
			RTResTalkAction[39]
		}
	},
	[34704015] = {
		34704015,
		3,
		Lang.get(89222),
		34704,
		15,
		605,
		{
			RTResTalkAction[32]
		},
		[22] = 1
	},
	[34704016] = {
		34704016,
		0,
		Lang.get(89223),
		34704,
		16,
		1052,
		{
			RTResTalkAction[49]
		}
	},
	[34704017] = {
		34704017,
		0,
		Lang.get(89224),
		34704,
		17,
		1163,
		{
			RTResTalkAction[38],
			RTResTalkAction[34]
		}
	},
	[34704018] = {
		34704018,
		0,
		Lang.get(89225),
		34704,
		18,
		1147,
		{
			RTResTalkAction[50],
			RTResTalkAction[39]
		}
	},
	[34704019] = {
		34704019,
		0,
		Lang.get(89226),
		34704,
		19,
		1146,
		{
			RTResTalkAction[14],
			RTResTalkAction[25]
		}
	},
	[34850001] = {
		34850001,
		0,
		Lang.get(89227),
		34850,
		1,
		1163,
		nil,
		1,
		0,
		nil,
		nil,
		195,
		34733,
		nil,
		nil,
		nil,
		nil,
		nil,
		34733
	},
	[34850002] = {
		34850002,
		0,
		Lang.get(89228),
		34850,
		2,
		1048,
		nil,
		1,
		2,
		[19] = 34737
	},
	[34850003] = {
		34850003,
		0,
		nil,
		34850,
		3,
		300,
		[29] = {
			{
				id = 34850004,
				branch_content = Lang.get(89887)
			},
			{
				id = 34850004,
				branch_content = Lang.get(89888)
			}
		}
	},
	[34850004] = {
		34850004,
		0,
		Lang.get(89230),
		34850,
		4,
		1147,
		{
			RTResTalkAction[51]
		},
		nil,
		nil,
		3
	},
	[34850005] = {
		34850005,
		5,
		Lang.get(89231),
		34850,
		5,
		1053,
		{
			RTResTalkAction[52],
			RTResTalkAction[25]
		}
	},
	[34850006] = {
		34850006,
		0,
		Lang.get(89232),
		34850,
		6,
		1163,
		{
			RTResTalkAction[31]
		},
		1,
		0,
		nil,
		nil,
		nil,
		34734,
		nil,
		1,
		nil,
		nil,
		nil,
		34734
	},
	[34850007] = {
		34850007,
		0,
		Lang.get(89233),
		34850,
		7,
		1052,
		nil,
		1,
		0
	},
	[34850008] = {
		34850008,
		0,
		Lang.get(89234),
		34850,
		8,
		1147,
		nil,
		1
	},
	[34850009] = {
		34850009,
		0,
		Lang.get(89235),
		34850,
		9,
		1146,
		nil,
		1,
		0,
		nil,
		nil,
		148
	},
	[34850010] = {
		34850010,
		0,
		Lang.get(89236),
		34850,
		10,
		1163,
		{
			RTResTalkAction[14]
		},
		1,
		nil,
		3,
		nil,
		nil,
		nil,
		1,
		1
	},
	[34850011] = {
		34850011,
		0,
		Lang.get(89237),
		34850,
		11,
		1163,
		{
			RTResTalkAction[42]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		1
	},
	[34850012] = {
		34850012,
		0,
		Lang.get(89238),
		34850,
		12,
		1163,
		{
			RTResTalkAction[53],
			RTResTalkAction[19]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		1
	},
	[34850013] = {
		34850013,
		0,
		Lang.get(89239),
		34850,
		13,
		1163,
		{
			RTResTalkAction[29],
			RTResTalkAction[25]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		1
	},
	[34850014] = {
		34850014,
		0,
		Lang.get(89240),
		34850,
		14,
		1163,
		{
			RTResTalkAction[35]
		},
		1,
		nil,
		3,
		nil,
		nil,
		34736,
		1,
		1,
		nil,
		1,
		nil,
		34736
	},
	[34850015] = {
		34850015,
		0,
		Lang.get(89241),
		34850,
		15,
		1147,
		{
			RTResTalkAction[54],
			RTResTalkAction[17],
			RTResTalkAction[31]
		}
	},
	[34850016] = {
		34850016,
		3,
		Lang.get(89242),
		34850,
		16,
		605,
		{
			RTResTalkAction[15],
			RTResTalkAction[17]
		},
		[22] = 1
	},
	[34850017] = {
		34850017,
		5,
		Lang.get(89243),
		34850,
		17,
		1146,
		{
			RTResTalkAction[55],
			RTResTalkAction[25]
		}
	},
	[34850018] = {
		34850018,
		0,
		Lang.get(89244),
		34850,
		18,
		1163,
		{
			RTResTalkAction[38],
			RTResTalkAction[19]
		}
	},
	[34850019] = {
		34850019,
		3,
		Lang.get(89245),
		34850,
		19,
		605,
		{
			RTResTalkAction[39]
		},
		nil,
		nil,
		-1,
		nil,
		63,
		34735,
		nil,
		1,
		nil,
		nil,
		nil,
		34735,
		nil,
		nil,
		1
	},
	[34850020] = {
		34850020,
		0,
		Lang.get(89246),
		34850,
		20,
		1050,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		nil,
		1,
		1
	},
	[34850021] = {
		34850021,
		0,
		Lang.get(89247),
		34850,
		21,
		1064,
		nil,
		1,
		0
	},
	[34850022] = {
		34850022,
		0,
		Lang.get(89248),
		34850,
		22,
		1050,
		nil,
		1,
		0
	},
	[34705001] = {
		34705001,
		0,
		Lang.get(89249),
		34705,
		1,
		1147,
		nil,
		1,
		2,
		nil,
		nil,
		197,
		34740,
		nil,
		nil,
		nil,
		nil,
		nil,
		34740
	},
	[34705002] = {
		34705002,
		0,
		Lang.get(89250),
		34705,
		2,
		1146,
		nil,
		1,
		0
	},
	[34705003] = {
		34705003,
		0,
		Lang.get(89251),
		34705,
		3,
		1147,
		nil,
		1,
		0
	},
	[34705004] = {
		34705004,
		0,
		Lang.get(89252),
		34705,
		4,
		1146,
		nil,
		1
	},
	[34705005] = {
		34705005,
		0,
		Lang.get(89253),
		34705,
		5,
		1163,
		nil,
		1
	},
	[34705006] = {
		34705006,
		0,
		Lang.get(89254),
		34705,
		6,
		1048,
		nil,
		1,
		2
	},
	[34705007] = {
		34705007,
		0,
		Lang.get(89255),
		34705,
		7,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		34741,
		[19] = 34741
	},
	[34705008] = {
		34705008,
		0,
		Lang.get(89256),
		34705,
		8,
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
	[34705009] = {
		34705009,
		9,
		Lang.get(89257),
		34705,
		9,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		190,
		[22] = 1
	},
	[34705010] = {
		34705010,
		9,
		Lang.get(89258),
		34705,
		10,
		nil,
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
	[34705011] = {
		34705011,
		9,
		Lang.get(89259),
		34705,
		11,
		[22] = 1
	},
	[34705012] = {
		34705012,
		0,
		Lang.get(89260),
		34705,
		12,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		34742,
		1,
		[19] = 34742
	},
	[34705013] = {
		34705013,
		9,
		Lang.get(89261),
		34705,
		13,
		nil,
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
	[34705014] = {
		34705014,
		9,
		Lang.get(89262),
		34705,
		14,
		nil,
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
	[34705015] = {
		34705015,
		0,
		Lang.get(89263),
		34705,
		15,
		1161,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		34743,
		nil,
		nil,
		nil,
		1,
		nil,
		34743
	},
	[34705016] = {
		34705016,
		0,
		Lang.get(89264),
		34705,
		16,
		300
	},
	[34705017] = {
		34705017,
		0,
		Lang.get(89265),
		34705,
		17,
		1161,
		nil,
		1
	},
	[34705018] = {
		34705018,
		4,
		nil,
		34705,
		18,
		300,
		[29] = {
			{
				id = 34705019,
				branch_content = "……"
			},
			{
				id = 34705019,
				branch_content = Lang.get(89266)
			}
		}
	},
	[34705019] = {
		34705019,
		0,
		Lang.get(89267),
		34705,
		19,
		1073,
		nil,
		1
	},
	[34705020] = {
		34705020,
		0,
		Lang.get(89268),
		34705,
		20,
		300
	},
	[34705021] = {
		34705021,
		0,
		Lang.get(89269),
		34705,
		21,
		1073,
		{
			RTResTalkAction[56]
		},
		nil,
		nil,
		3
	},
	[34705022] = {
		34705022,
		0,
		Lang.get(89270),
		34705,
		22,
		300,
		{
			RTResTalkAction[56]
		}
	},
	[34705023] = {
		34705023,
		0,
		Lang.get(89271),
		34705,
		23,
		1073,
		{
			RTResTalkAction[56]
		}
	},
	[34705024] = {
		34705024,
		0,
		Lang.get(89272),
		34705,
		24,
		1073,
		{
			RTResTalkAction[56]
		}
	},
	[34705025] = {
		34705025,
		0,
		Lang.get(89273),
		34705,
		25,
		1073,
		{
			RTResTalkAction[56]
		}
	},
	[34705026] = {
		34705026,
		0,
		Lang.get(89274),
		34705,
		26,
		300,
		{
			RTResTalkAction[56]
		}
	},
	[34705027] = {
		34705027,
		0,
		Lang.get(89275),
		34705,
		27,
		1073,
		{
			RTResTalkAction[56]
		}
	},
	[34705028] = {
		34705028,
		0,
		Lang.get(89276),
		34705,
		28,
		1073,
		{
			RTResTalkAction[56]
		}
	},
	[34705029] = {
		34705029,
		9,
		Lang.get(89277),
		34705,
		29,
		nil,
		{
			RTResTalkAction[57]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		34744,
		1,
		1,
		nil,
		1,
		nil,
		34744,
		nil,
		nil,
		1
	},
	[34705030] = {
		34705030,
		0,
		Lang.get(89278),
		34705,
		30,
		300
	},
	[34705031] = {
		34705031,
		0,
		Lang.get(89279),
		34705,
		31,
		1073,
		nil,
		1,
		0
	},
	[34705032] = {
		34705032,
		0,
		Lang.get(89280),
		34705,
		32,
		1073,
		nil,
		1,
		0
	},
	[34706001] = {
		34706001,
		0,
		Lang.get(89281),
		34706,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		194,
		34760,
		[19] = 34760
	},
	[34706002] = {
		34706002,
		0,
		Lang.get(89282),
		34706,
		2,
		1146,
		nil,
		1,
		nil,
		nil,
		nil,
		196
	},
	[34706003] = {
		34706003,
		0,
		Lang.get(89283),
		34706,
		3,
		1147,
		nil,
		1
	},
	[34706004] = {
		34706004,
		0,
		Lang.get(89284),
		34706,
		4,
		1146,
		nil,
		1
	},
	[34706005] = {
		34706005,
		0,
		Lang.get(89285),
		34706,
		5,
		1147,
		nil,
		1
	},
	[34706006] = {
		34706006,
		0,
		Lang.get(89286),
		34706,
		6,
		1166
	},
	[34706007] = {
		34706007,
		5,
		Lang.get(89287),
		34706,
		7,
		1163,
		nil,
		1
	},
	[34706008] = {
		34706008,
		0,
		Lang.get(89288),
		34706,
		8,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		34761,
		[19] = 34761
	},
	[34706009] = {
		34706009,
		0,
		Lang.get(89289),
		34706,
		9,
		1163
	},
	[34706010] = {
		34706010,
		0,
		Lang.get(89290),
		34706,
		10,
		300
	},
	[34706011] = {
		34706011,
		0,
		Lang.get(89291),
		34706,
		11,
		1048,
		{
			RTResTalkAction[58]
		},
		nil,
		nil,
		3
	},
	[34706012] = {
		34706012,
		0,
		Lang.get(89292),
		34706,
		12,
		1163,
		{
			RTResTalkAction[48],
			RTResTalkAction[6]
		}
	},
	[34706013] = {
		34706013,
		0,
		Lang.get(89293),
		34706,
		13,
		300,
		{
			RTResTalkAction[39]
		}
	},
	[34706014] = {
		34706014,
		0,
		Lang.get(89294),
		34706,
		14,
		1147,
		{
			RTResTalkAction[20]
		}
	},
	[34706015] = {
		34706015,
		0,
		Lang.get(89295),
		34706,
		15,
		1146,
		{
			RTResTalkAction[15],
			RTResTalkAction[59]
		}
	},
	[34706016] = {
		34706016,
		0,
		Lang.get(89296),
		34706,
		16,
		300,
		{
			RTResTalkAction[15],
			RTResTalkAction[17]
		}
	},
	[34706017] = {
		34706017,
		5,
		Lang.get(89297),
		34706,
		17,
		1146,
		{
			RTResTalkAction[60],
			RTResTalkAction[25]
		}
	},
	[34706018] = {
		34706018,
		3,
		Lang.get(89298),
		34706,
		18,
		605,
		{
			RTResTalkAction[19]
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
	[34706019] = {
		34706019,
		0,
		Lang.get(89299),
		34706,
		19,
		1147,
		nil,
		1,
		0,
		-1,
		nil,
		196,
		34762,
		1,
		nil,
		nil,
		nil,
		nil,
		34762,
		0
	},
	[34706020] = {
		34706020,
		0,
		Lang.get(89300),
		34706,
		20,
		1146,
		nil,
		1
	},
	[34706021] = {
		34706021,
		0,
		Lang.get(89286),
		34706,
		21,
		1166,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		34763,
		1,
		nil,
		nil,
		nil,
		nil,
		34763
	},
	[34706022] = {
		34706022,
		0,
		Lang.get(89301),
		34706,
		22,
		1163,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[34706023] = {
		34706023,
		0,
		Lang.get(89302),
		34706,
		23,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		[19] = 34765
	},
	[34706024] = {
		34706024,
		0,
		Lang.get(89303),
		34706,
		24,
		1163,
		{
			RTResTalkAction[38]
		},
		nil,
		nil,
		3
	},
	[34706025] = {
		34706025,
		0,
		Lang.get(89304),
		34706,
		25,
		300,
		{
			RTResTalkAction[38]
		}
	},
	[34706026] = {
		34706026,
		5,
		Lang.get(35133),
		34706,
		26,
		1163,
		{
			RTResTalkAction[61]
		}
	},
	[34706027] = {
		34706027,
		0,
		Lang.get(89305),
		34706,
		27,
		1147,
		{
			RTResTalkAction[41],
			RTResTalkAction[39]
		}
	},
	[34706028] = {
		34706028,
		0,
		Lang.get(89306),
		34706,
		28,
		300,
		{
			RTResTalkAction[25]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		34764,
		1,
		1,
		nil,
		nil,
		nil,
		34764
	},
	[34706029] = {
		34706029,
		0,
		Lang.get(89307),
		34706,
		29,
		300
	},
	[34706030] = {
		34706030,
		0,
		Lang.get(89308),
		34706,
		30,
		1048,
		nil,
		1,
		0
	},
	[34707001] = {
		34707001,
		0,
		Lang.get(89309),
		34707,
		1,
		1054,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		34770,
		nil,
		nil,
		nil,
		nil,
		nil,
		34770
	},
	[34707002] = {
		34707002,
		0,
		Lang.get(89310),
		34707,
		2,
		300
	},
	[34707003] = {
		34707003,
		0,
		Lang.get(89311),
		34707,
		3,
		300
	},
	[34707004] = {
		34707004,
		0,
		Lang.get(89312),
		34707,
		4,
		1054,
		nil,
		1
	},
	[34707005] = {
		34707005,
		0,
		Lang.get(89313),
		34707,
		5,
		1048,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		34771,
		nil,
		nil,
		nil,
		nil,
		nil,
		34771
	},
	[34707006] = {
		34707006,
		0,
		Lang.get(89314),
		34707,
		6,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		63
	},
	[34707007] = {
		34707007,
		0,
		Lang.get(89315),
		34707,
		7,
		1163,
		nil,
		1,
		0
	},
	[34707008] = {
		34707008,
		0,
		Lang.get(89316),
		34707,
		8,
		235,
		{
			RTResTalkAction[62]
		},
		nil,
		nil,
		3
	},
	[34707009] = {
		34707009,
		0,
		Lang.get(89317),
		34707,
		9,
		1048,
		{
			RTResTalkAction[63],
			RTResTalkAction[64]
		}
	},
	[34707010] = {
		34707010,
		0,
		Lang.get(89318),
		34707,
		10,
		235,
		{
			RTResTalkAction[62],
			RTResTalkAction[6]
		}
	},
	[34707011] = {
		34707011,
		0,
		Lang.get(89319),
		34707,
		11,
		300,
		{
			RTResTalkAction[62]
		}
	},
	[34707012] = {
		34707012,
		0,
		Lang.get(89320),
		34707,
		12,
		235,
		{
			RTResTalkAction[62]
		}
	},
	[34707013] = {
		34707013,
		0,
		Lang.get(89321),
		34707,
		13,
		235,
		{
			RTResTalkAction[65]
		}
	},
	[34707014] = {
		34707014,
		0,
		Lang.get(89322),
		34707,
		14,
		1163,
		{
			RTResTalkAction[61],
			RTResTalkAction[64]
		}
	},
	[34707015] = {
		34707015,
		0,
		Lang.get(89323),
		34707,
		15,
		300,
		{
			RTResTalkAction[39]
		}
	},
	[34707016] = {
		34707016,
		4,
		nil,
		34707,
		16,
		300,
		[29] = {
			{
				id = 34707017,
				branch_content = Lang.get(89324)
			},
			{
				id = 34707017,
				branch_content = Lang.get(89325)
			}
		}
	},
	[34707017] = {
		34707017,
		0,
		Lang.get(82617),
		34707,
		17,
		235,
		{
			RTResTalkAction[62]
		}
	},
	[34707018] = {
		34707018,
		0,
		Lang.get(89326),
		34707,
		18,
		1054,
		{
			RTResTalkAction[66],
			RTResTalkAction[67]
		}
	},
	[34707019] = {
		34707019,
		0,
		Lang.get(89327),
		34707,
		19,
		300,
		{
			RTResTalkAction[66],
			RTResTalkAction[67]
		}
	},
	[34707020] = {
		34707020,
		0,
		Lang.get(89328),
		34707,
		20,
		235,
		{
			RTResTalkAction[68],
			RTResTalkAction[64]
		},
		1,
		nil,
		-1,
		nil,
		60,
		34772,
		nil,
		1,
		nil,
		nil,
		nil,
		34772
	},
	[34707021] = {
		34707021,
		0,
		Lang.get(89329),
		34707,
		21,
		300
	},
	[34707022] = {
		34707022,
		0,
		Lang.get(89330),
		34707,
		22,
		1054,
		nil,
		1
	},
	[34707023] = {
		34707023,
		0,
		Lang.get(89331),
		34707,
		23,
		1163,
		nil,
		1
	},
	[34707024] = {
		34707024,
		0,
		Lang.get(89332),
		34707,
		24,
		235,
		{
			RTResTalkAction[65]
		},
		nil,
		nil,
		3
	},
	[34707025] = {
		34707025,
		3,
		Lang.get(89333),
		34707,
		25,
		605,
		{
			RTResTalkAction[62]
		},
		[22] = 1
	},
	[34707026] = {
		34707026,
		0,
		Lang.get(89334),
		34707,
		26,
		1054,
		{
			RTResTalkAction[69],
			RTResTalkAction[67]
		}
	},
	[34707027] = {
		34707027,
		0,
		Lang.get(89335),
		34707,
		27,
		235,
		{
			RTResTalkAction[66],
			RTResTalkAction[70]
		}
	},
	[34707028] = {
		34707028,
		0,
		Lang.get(89336),
		34707,
		28,
		300,
		{
			RTResTalkAction[66],
			RTResTalkAction[67]
		}
	},
	[34707029] = {
		34707029,
		0,
		Lang.get(89337),
		34707,
		29,
		1163,
		{
			RTResTalkAction[38],
			RTResTalkAction[68],
			RTResTalkAction[64]
		}
	},
	[34707030] = {
		34707030,
		0,
		Lang.get(89338),
		34707,
		30,
		1147,
		{
			RTResTalkAction[71],
			RTResTalkAction[39]
		}
	},
	[34707031] = {
		34707031,
		0,
		Lang.get(89339),
		34707,
		31,
		1146,
		{
			RTResTalkAction[15],
			RTResTalkAction[17]
		}
	},
	[34708001] = {
		34708001,
		0,
		Lang.get(89340),
		34708,
		1,
		1053,
		nil,
		1,
		nil,
		nil,
		nil,
		152,
		34780,
		nil,
		nil,
		nil,
		nil,
		nil,
		34780
	},
	[34708002] = {
		34708002,
		0,
		Lang.get(89341),
		34708,
		2,
		1048,
		nil,
		1,
		1
	},
	[34708003] = {
		34708003,
		0,
		Lang.get(89342),
		34708,
		3,
		1052,
		nil,
		1,
		0
	},
	[34708004] = {
		34708004,
		0,
		Lang.get(89343),
		34708,
		4,
		1054,
		nil,
		1
	},
	[34708005] = {
		34708005,
		0,
		Lang.get(89344),
		34708,
		5,
		235,
		nil,
		1
	},
	[34708006] = {
		34708006,
		0,
		Lang.get(89345),
		34708,
		6,
		1048,
		nil,
		1,
		2
	},
	[34708007] = {
		34708007,
		0,
		Lang.get(89346),
		34708,
		7,
		300
	},
	[34708008] = {
		34708008,
		0,
		Lang.get(89347),
		34708,
		8,
		1168,
		nil,
		1,
		0
	},
	[34708009] = {
		34708009,
		0,
		Lang.get(89348),
		34708,
		9,
		1163,
		nil,
		1
	},
	[34708010] = {
		34708010,
		0,
		Lang.get(89349),
		34708,
		10,
		1163,
		nil,
		1
	},
	[34708011] = {
		34708011,
		3,
		Lang.get(89333),
		34708,
		11,
		605,
		[22] = 1
	},
	[34708012] = {
		34708012,
		0,
		Lang.get(89350),
		34708,
		12,
		300
	},
	[34708013] = {
		34708013,
		0,
		Lang.get(89351),
		34708,
		13,
		1147,
		{
			RTResTalkAction[53]
		},
		nil,
		nil,
		3
	},
	[34708014] = {
		34708014,
		0,
		Lang.get(89352),
		34708,
		14,
		1146,
		{
			RTResTalkAction[15],
			RTResTalkAction[17]
		}
	},
	[34708015] = {
		34708015,
		0,
		Lang.get(89353),
		34708,
		15,
		1146,
		{
			RTResTalkAction[15],
			RTResTalkAction[17]
		}
	},
	[34708016] = {
		34708016,
		4,
		nil,
		34708,
		16,
		300,
		{
			RTResTalkAction[15],
			RTResTalkAction[17]
		},
		[29] = {
			{
				id = 34708017,
				branch_content = Lang.get(89354)
			},
			{
				id = 34708017,
				branch_content = Lang.get(89355)
			}
		}
	},
	[34708017] = {
		34708017,
		3,
		Lang.get(89356),
		34708,
		17,
		605,
		{
			RTResTalkAction[15],
			RTResTalkAction[17]
		},
		[22] = 1
	},
	[34708018] = {
		34708018,
		0,
		Lang.get(89357),
		34708,
		18,
		1147,
		{
			RTResTalkAction[72],
			RTResTalkAction[17]
		}
	},
	[34708019] = {
		34708019,
		0,
		Lang.get(89358),
		34708,
		19,
		1146,
		{
			RTResTalkAction[15],
			RTResTalkAction[73]
		}
	},
	[34708020] = {
		34708020,
		3,
		Lang.get(89356),
		34708,
		20,
		605,
		{
			RTResTalkAction[15],
			RTResTalkAction[17]
		},
		[22] = 1
	},
	[34708021] = {
		34708021,
		3,
		Lang.get(89359),
		34708,
		21,
		605,
		{
			RTResTalkAction[25],
			RTResTalkAction[19]
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
	[34708022] = {
		34708022,
		0,
		Lang.get(89360),
		34708,
		22,
		1147,
		nil,
		1,
		0,
		nil,
		nil,
		195,
		34781,
		nil,
		nil,
		nil,
		nil,
		nil,
		34781,
		-1
	},
	[34708023] = {
		34708023,
		0,
		Lang.get(89361),
		34708,
		23,
		1146,
		nil,
		1,
		0
	},
	[34708024] = {
		34708024,
		0,
		Lang.get(89362),
		34708,
		24,
		1147,
		nil,
		1,
		2
	},
	[34708025] = {
		34708025,
		3,
		Lang.get(89363),
		34708,
		25,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		34782,
		[19] = 34782,
		[22] = 1
	},
	[34708026] = {
		34708026,
		0,
		Lang.get(89364),
		34708,
		26,
		1064,
		nil,
		1,
		nil,
		nil,
		nil,
		57
	},
	[34708027] = {
		34708027,
		0,
		Lang.get(89365),
		34708,
		27,
		1050,
		{
			RTResTalkAction[74]
		},
		nil,
		nil,
		3
	},
	[34708028] = {
		34708028,
		0,
		Lang.get(89366),
		34708,
		28,
		1146,
		{
			RTResTalkAction[14],
			RTResTalkAction[75]
		}
	},
	[34708029] = {
		34708029,
		0,
		Lang.get(89367),
		34708,
		29,
		1147,
		{
			RTResTalkAction[76],
			RTResTalkAction[19]
		}
	},
	[34708030] = {
		34708030,
		0,
		Lang.get(89368),
		34708,
		30,
		1064,
		{
			RTResTalkAction[77],
			RTResTalkAction[25]
		}
	},
	[34709001] = {
		34709001,
		0,
		Lang.get(89369),
		34709,
		1,
		1163,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		34790,
		nil,
		nil,
		nil,
		nil,
		nil,
		34790
	},
	[34709002] = {
		34709002,
		0,
		Lang.get(89370),
		34709,
		2,
		1050,
		{
			RTResTalkAction[74]
		},
		nil,
		nil,
		3
	},
	[34709003] = {
		34709003,
		0,
		Lang.get(89371),
		34709,
		3,
		1064,
		{
			RTResTalkAction[78],
			RTResTalkAction[75]
		}
	},
	[34709004] = {
		34709004,
		0,
		Lang.get(89372),
		34709,
		4,
		1147,
		{
			RTResTalkAction[18],
			RTResTalkAction[79]
		}
	},
	[34709005] = {
		34709005,
		0,
		Lang.get(89373),
		34709,
		5,
		1146,
		{
			RTResTalkAction[15],
			RTResTalkAction[80]
		}
	},
	[34709006] = {
		34709006,
		0,
		Lang.get(89374),
		34709,
		6,
		1147,
		{
			RTResTalkAction[51],
			RTResTalkAction[19]
		}
	},
	[34709007] = {
		34709007,
		3,
		Lang.get(89375),
		34709,
		7,
		605,
		{
			RTResTalkAction[25]
		},
		[22] = 1
	},
	[34709008] = {
		34709008,
		0,
		Lang.get(89376),
		34709,
		8,
		1064,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		34791,
		nil,
		nil,
		nil,
		nil,
		nil,
		34791
	},
	[34709009] = {
		34709009,
		0,
		Lang.get(89377),
		34709,
		9,
		1146,
		{
			RTResTalkAction[81]
		},
		nil,
		nil,
		3
	},
	[34709010] = {
		34709010,
		0,
		Lang.get(89378),
		34709,
		10,
		1163,
		{
			RTResTalkAction[38],
			RTResTalkAction[19]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[34709011] = {
		34709011,
		3,
		Lang.get(89379),
		34709,
		11,
		605,
		{
			RTResTalkAction[42],
			RTResTalkAction[39]
		},
		[22] = 1
	},
	[34709012] = {
		34709012,
		0,
		Lang.get(89380),
		34709,
		12,
		1064,
		{
			RTResTalkAction[82],
			RTResTalkAction[19]
		}
	},
	[34709013] = {
		34709013,
		3,
		Lang.get(89381),
		34709,
		13,
		605,
		{
			RTResTalkAction[83],
			RTResTalkAction[84]
		},
		[22] = 1
	},
	[34709014] = {
		34709014,
		0,
		Lang.get(89382),
		34709,
		14,
		1050,
		{
			RTResTalkAction[85],
			RTResTalkAction[79]
		}
	},
	[34709015] = {
		34709015,
		0,
		Lang.get(89383),
		34709,
		15,
		1147,
		{
			RTResTalkAction[51],
			RTResTalkAction[75]
		}
	},
	[34709016] = {
		34709016,
		3,
		Lang.get(89384),
		34709,
		16,
		605,
		{
			RTResTalkAction[53]
		},
		[22] = 1
	},
	[34709017] = {
		34709017,
		0,
		Lang.get(89385),
		34709,
		17,
		1163,
		{
			RTResTalkAction[38],
			RTResTalkAction[25]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[17] = 1
	},
	[34709018] = {
		34709018,
		0,
		Lang.get(89386),
		34709,
		18,
		1163,
		{
			RTResTalkAction[86]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[17] = 1
	},
	[34709019] = {
		34709019,
		0,
		Lang.get(89387),
		34709,
		19,
		1048,
		{
			RTResTalkAction[87],
			RTResTalkAction[39]
		}
	},
	[34709020] = {
		34709020,
		0,
		Lang.get(89388),
		34709,
		20,
		1048,
		{
			RTResTalkAction[5]
		}
	},
	[34709021] = {
		34709021,
		0,
		Lang.get(89389),
		34709,
		21,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[34709022] = {
		34709022,
		0,
		Lang.get(89390),
		34709,
		22,
		1147,
		{
			RTResTalkAction[50],
			RTResTalkAction[6]
		}
	},
	[34709023] = {
		34709023,
		0,
		Lang.get(89391),
		34709,
		23,
		1146,
		{
			RTResTalkAction[15],
			RTResTalkAction[16]
		}
	},
	[34851001] = {
		34851001,
		0,
		Lang.get(89392),
		34851,
		1,
		1163,
		{
			RTResTalkAction[38]
		},
		nil,
		nil,
		3,
		nil,
		148,
		34795,
		nil,
		nil,
		nil,
		nil,
		nil,
		34795
	},
	[34851002] = {
		34851002,
		0,
		Lang.get(89393),
		34851,
		2,
		1050,
		{
			RTResTalkAction[74],
			RTResTalkAction[39]
		}
	},
	[34851003] = {
		34851003,
		0,
		Lang.get(89394),
		34851,
		3,
		1064,
		{
			RTResTalkAction[88],
			RTResTalkAction[89]
		}
	},
	[34851004] = {
		34851004,
		0,
		Lang.get(89395),
		34851,
		4,
		1050,
		{
			RTResTalkAction[74],
			RTResTalkAction[79]
		}
	},
	[34851005] = {
		34851005,
		0,
		Lang.get(32365),
		34851,
		5,
		1146,
		{
			RTResTalkAction[90],
			RTResTalkAction[75]
		}
	},
	[34851006] = {
		34851006,
		5,
		Lang.get(89396),
		34851,
		6,
		1064,
		{
			RTResTalkAction[78],
			RTResTalkAction[19]
		}
	},
	[34851007] = {
		34851007,
		0,
		Lang.get(89397),
		34851,
		7,
		1163,
		{
			RTResTalkAction[38],
			RTResTalkAction[79]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[34851008] = {
		34851008,
		0,
		Lang.get(89398),
		34851,
		8,
		1064,
		{
			RTResTalkAction[78],
			RTResTalkAction[39]
		}
	},
	[34851009] = {
		34851009,
		0,
		Lang.get(89399),
		34851,
		9,
		1050,
		{
			RTResTalkAction[74],
			RTResTalkAction[79]
		}
	},
	[34851010] = {
		34851010,
		0,
		Lang.get(89400),
		34851,
		10,
		1048,
		{
			RTResTalkAction[5],
			RTResTalkAction[75]
		}
	},
	[34851011] = {
		34851011,
		0,
		Lang.get(89401),
		34851,
		11,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[34851012] = {
		34851012,
		3,
		Lang.get(89402),
		34851,
		12,
		605,
		{
			RTResTalkAction[6]
		},
		[22] = 1
	},
	[34851013] = {
		34851013,
		0,
		Lang.get(89403),
		34851,
		13,
		1147,
		{
			RTResTalkAction[50]
		}
	},
	[34851014] = {
		34851014,
		0,
		Lang.get(89404),
		34851,
		14,
		1163,
		{
			RTResTalkAction[38],
			RTResTalkAction[25]
		}
	},
	[34851015] = {
		34851015,
		0,
		Lang.get(89405),
		34851,
		15,
		1147,
		{
			RTResTalkAction[50],
			RTResTalkAction[39]
		}
	},
	[34851016] = {
		34851016,
		0,
		Lang.get(89406),
		34851,
		16,
		1146,
		{
			RTResTalkAction[15],
			RTResTalkAction[59]
		}
	},
	[34851017] = {
		34851017,
		0,
		Lang.get(89407),
		34851,
		17,
		1163,
		{
			RTResTalkAction[38],
			RTResTalkAction[25],
			RTResTalkAction[19]
		},
		nil,
		nil,
		nil,
		nil,
		120
	},
	[34851018] = {
		34851018,
		0,
		Lang.get(89408),
		34851,
		18,
		1163,
		{
			RTResTalkAction[91]
		}
	},
	[34710001] = {
		34710001,
		0,
		Lang.get(89409),
		34710,
		1,
		1147,
		{
			RTResTalkAction[53]
		},
		nil,
		nil,
		3,
		nil,
		197,
		34800,
		1,
		nil,
		nil,
		nil,
		nil,
		34800
	},
	[34710002] = {
		34710002,
		0,
		Lang.get(89410),
		34710,
		2,
		1146,
		{
			RTResTalkAction[15],
			RTResTalkAction[59]
		}
	},
	[34710003] = {
		34710003,
		0,
		Lang.get(89411),
		34710,
		3,
		1147,
		{
			RTResTalkAction[22],
			RTResTalkAction[17]
		}
	},
	[34710004] = {
		34710004,
		0,
		Lang.get(89412),
		34710,
		4,
		1146,
		{
			RTResTalkAction[15],
			RTResTalkAction[16]
		}
	},
	[34710005] = {
		34710005,
		0,
		Lang.get(89413),
		34710,
		5,
		300,
		{
			RTResTalkAction[15],
			RTResTalkAction[17]
		}
	},
	[34710006] = {
		34710006,
		0,
		Lang.get(89414),
		34710,
		6,
		1163,
		{
			RTResTalkAction[38],
			RTResTalkAction[25],
			RTResTalkAction[19]
		}
	},
	[34710007] = {
		34710007,
		0,
		Lang.get(89415),
		34710,
		7,
		1048,
		{
			RTResTalkAction[5],
			RTResTalkAction[39]
		}
	},
	[34710008] = {
		34710008,
		0,
		Lang.get(89416),
		34710,
		8,
		1163,
		{
			RTResTalkAction[61],
			RTResTalkAction[6]
		}
	},
	[34710009] = {
		34710009,
		9,
		Lang.get(89417),
		34710,
		9,
		nil,
		{
			RTResTalkAction[39]
		},
		nil,
		nil,
		nil,
		nil,
		190,
		34801,
		nil,
		1,
		nil,
		nil,
		nil,
		34801,
		200,
		nil,
		1
	},
	[34710010] = {
		34710010,
		0,
		Lang.get(89418),
		34710,
		10,
		1050,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[20] = -1
	},
	[34710011] = {
		34710011,
		0,
		Lang.get(89419),
		34710,
		11,
		1073,
		nil,
		1
	},
	[34710012] = {
		34710012,
		0,
		Lang.get(89420),
		34710,
		12,
		1050,
		nil,
		1
	},
	[34710013] = {
		34710013,
		0,
		Lang.get(89421),
		34710,
		13,
		1073,
		{
			RTResTalkAction[56]
		},
		nil,
		nil,
		3
	},
	[34710014] = {
		34710014,
		0,
		Lang.get(89422),
		34710,
		14,
		1050,
		{
			RTResTalkAction[88],
			RTResTalkAction[92]
		}
	},
	[34710015] = {
		34710015,
		0,
		Lang.get(89423),
		34710,
		15,
		1073,
		{
			RTResTalkAction[88],
			RTResTalkAction[93]
		}
	},
	[34710016] = {
		34710016,
		0,
		Lang.get(89424),
		34710,
		16,
		1050,
		{
			RTResTalkAction[88],
			RTResTalkAction[92]
		}
	},
	[34710017] = {
		34710017,
		0,
		Lang.get(89425),
		34710,
		17,
		1073,
		{
			RTResTalkAction[88],
			RTResTalkAction[92]
		}
	},
	[34710018] = {
		34710018,
		0,
		Lang.get(89426),
		34710,
		18,
		1073,
		{
			RTResTalkAction[88],
			RTResTalkAction[92]
		}
	},
	[34710019] = {
		34710019,
		0,
		"……！",
		34710,
		19,
		1050,
		{
			RTResTalkAction[94],
			RTResTalkAction[92]
		},
		nil,
		nil,
		nil,
		nil,
		57
	},
	[34710020] = {
		34710020,
		0,
		Lang.get(89427),
		34710,
		20,
		1050,
		{
			RTResTalkAction[88],
			RTResTalkAction[92]
		}
	},
	[34710021] = {
		34710021,
		0,
		Lang.get(89428),
		34710,
		21,
		1073,
		{
			RTResTalkAction[88],
			RTResTalkAction[95]
		}
	},
	[34710022] = {
		34710022,
		0,
		Lang.get(89429),
		34710,
		22,
		1073,
		{
			RTResTalkAction[88],
			RTResTalkAction[92]
		}
	},
	[34710023] = {
		34710023,
		0,
		Lang.get(89430),
		34710,
		23,
		1073,
		{
			RTResTalkAction[88],
			RTResTalkAction[92]
		}
	},
	[34710024] = {
		34710024,
		0,
		Lang.get(89431),
		34710,
		24,
		1050,
		{
			RTResTalkAction[88],
			RTResTalkAction[92]
		}
	},
	[34710025] = {
		34710025,
		0,
		Lang.get(89432),
		34710,
		25,
		1050,
		{
			RTResTalkAction[96],
			RTResTalkAction[92]
		}
	},
	[34710026] = {
		34710026,
		0,
		Lang.get(89433),
		34710,
		26,
		1073,
		{
			RTResTalkAction[88],
			RTResTalkAction[97]
		}
	},
	[34710027] = {
		34710027,
		0,
		Lang.get(89434),
		34710,
		27,
		1073,
		{
			RTResTalkAction[88],
			RTResTalkAction[92]
		}
	},
	[34710028] = {
		34710028,
		0,
		Lang.get(89435),
		34710,
		28,
		1050,
		{
			RTResTalkAction[88],
			RTResTalkAction[92]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[34710029] = {
		34710029,
		0,
		Lang.get(89436),
		34710,
		29,
		1073,
		{
			RTResTalkAction[88],
			RTResTalkAction[92]
		}
	},
	[34710030] = {
		34710030,
		0,
		Lang.get(89437),
		34710,
		30,
		1073,
		{
			RTResTalkAction[98],
			RTResTalkAction[75]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[34711001] = {
		34711001,
		0,
		Lang.get(89438),
		34711,
		1,
		1052,
		nil,
		1,
		nil,
		nil,
		nil,
		153,
		34805,
		nil,
		nil,
		nil,
		nil,
		nil,
		34805
	},
	[34711002] = {
		34711002,
		0,
		Lang.get(89439),
		34711,
		2,
		1053,
		nil,
		1,
		1
	},
	[34711003] = {
		34711003,
		0,
		Lang.get(89440),
		34711,
		3,
		1052,
		nil,
		1,
		0
	},
	[34711004] = {
		34711004,
		5,
		Lang.get(89441),
		34711,
		4,
		1053,
		{
			RTResTalkAction[99]
		},
		nil,
		nil,
		3
	},
	[34711005] = {
		34711005,
		5,
		Lang.get(69024),
		34711,
		5,
		605,
		{
			RTResTalkAction[29]
		},
		[22] = 1
	},
	[34711006] = {
		34711006,
		0,
		Lang.get(89442),
		34711,
		6,
		1053,
		{
			RTResTalkAction[29]
		}
	},
	[34711007] = {
		34711007,
		0,
		Lang.get(89443),
		34711,
		7,
		300,
		{
			RTResTalkAction[31]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		34806,
		[19] = 34806
	},
	[34711008] = {
		34711008,
		0,
		Lang.get(89444),
		34711,
		8,
		1147,
		{
			RTResTalkAction[18]
		}
	},
	[34711009] = {
		34711009,
		0,
		Lang.get(89445),
		34711,
		9,
		1146,
		{
			RTResTalkAction[81],
			RTResTalkAction[25]
		}
	},
	[34711010] = {
		34711010,
		3,
		Lang.get(89446),
		34711,
		10,
		605,
		{
			RTResTalkAction[19]
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
	[34711011] = {
		34711011,
		0,
		Lang.get(89447),
		34711,
		11,
		1147,
		nil,
		1,
		nil,
		-1,
		nil,
		nil,
		34807,
		nil,
		nil,
		nil,
		nil,
		nil,
		34807,
		-1
	},
	[34711012] = {
		34711012,
		0,
		Lang.get(89448),
		34711,
		12,
		1146,
		nil,
		1
	},
	[34711013] = {
		34711013,
		0,
		Lang.get(89449),
		34711,
		13,
		300
	},
	[34711014] = {
		34711014,
		0,
		Lang.get(89450),
		34711,
		14,
		1048,
		nil,
		1
	},
	[34711015] = {
		34711015,
		0,
		Lang.get(89451),
		34711,
		15,
		1147,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		34808,
		[19] = 34808
	},
	[34711016] = {
		34711016,
		0,
		Lang.get(89452),
		34711,
		16,
		1146,
		nil,
		1
	},
	[34711017] = {
		34711017,
		0,
		Lang.get(89453),
		34711,
		17,
		300
	},
	[34711018] = {
		34711018,
		0,
		Lang.get(89454),
		34711,
		18,
		1147,
		{
			RTResTalkAction[18]
		},
		nil,
		nil,
		3
	},
	[34711019] = {
		34711019,
		0,
		Lang.get(89455),
		34711,
		19,
		1049,
		{
			RTResTalkAction[100],
			RTResTalkAction[25]
		},
		nil,
		nil,
		nil,
		nil,
		60
	},
	[34711020] = {
		34711020,
		0,
		Lang.get(89456),
		34711,
		20,
		1146,
		{
			RTResTalkAction[90],
			RTResTalkAction[101]
		}
	},
	[34711021] = {
		34711021,
		0,
		Lang.get(89457),
		34711,
		21,
		300,
		{
			RTResTalkAction[102],
			RTResTalkAction[19]
		}
	},
	[34711022] = {
		34711022,
		0,
		Lang.get(89458),
		34711,
		22,
		1049,
		{
			RTResTalkAction[102]
		}
	},
	[34711023] = {
		34711023,
		0,
		Lang.get(89459),
		34711,
		23,
		1146,
		{
			RTResTalkAction[81],
			RTResTalkAction[101]
		}
	},
	[34711024] = {
		34711024,
		0,
		Lang.get(89460),
		34711,
		24,
		1048,
		{
			RTResTalkAction[3],
			RTResTalkAction[19]
		}
	},
	[34711025] = {
		34711025,
		0,
		Lang.get(89461),
		34711,
		25,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[34711026] = {
		34711026,
		0,
		Lang.get(89462),
		34711,
		26,
		1146,
		{
			RTResTalkAction[103]
		}
	},
	[34711027] = {
		34711027,
		0,
		Lang.get(89463),
		34711,
		27,
		1146,
		{
			RTResTalkAction[42]
		}
	},
	[34711028] = {
		34711028,
		0,
		Lang.get(89464),
		34711,
		28,
		1051,
		{
			RTResTalkAction[104],
			RTResTalkAction[19]
		},
		nil,
		nil,
		nil,
		nil,
		122,
		nil,
		1
	},
	[34711029] = {
		34711029,
		0,
		Lang.get(89465),
		34711,
		29,
		1051,
		{
			RTResTalkAction[105]
		}
	},
	[34712001] = {
		34712001,
		0,
		Lang.get(89466),
		34712,
		1,
		1163,
		{
			RTResTalkAction[38]
		},
		nil,
		nil,
		3,
		nil,
		148,
		34810,
		1,
		nil,
		nil,
		nil,
		nil,
		34810
	},
	[34712002] = {
		34712002,
		5,
		Lang.get(89467),
		34712,
		2,
		1051,
		{
			RTResTalkAction[106],
			RTResTalkAction[39]
		}
	},
	[34712003] = {
		34712003,
		0,
		Lang.get(89468),
		34712,
		3,
		1147,
		{
			RTResTalkAction[107],
			RTResTalkAction[108]
		}
	},
	[34712004] = {
		34712004,
		0,
		Lang.get(89469),
		34712,
		4,
		1147,
		{
			RTResTalkAction[28]
		}
	},
	[34712005] = {
		34712005,
		0,
		Lang.get(89470),
		34712,
		5,
		1146,
		{
			RTResTalkAction[103],
			RTResTalkAction[25]
		}
	},
	[34712006] = {
		34712006,
		0,
		Lang.get(89471),
		34712,
		6,
		1163,
		{
			RTResTalkAction[48],
			RTResTalkAction[19]
		}
	},
	[34712007] = {
		34712007,
		0,
		Lang.get(89472),
		34712,
		7,
		1163,
		{
			RTResTalkAction[38]
		}
	},
	[34712008] = {
		34712008,
		0,
		Lang.get(89473),
		34712,
		8,
		1051,
		{
			RTResTalkAction[105],
			RTResTalkAction[39]
		}
	},
	[34712009] = {
		34712009,
		0,
		Lang.get(89474),
		34712,
		9,
		1049,
		{
			RTResTalkAction[102],
			RTResTalkAction[108]
		}
	},
	[34712010] = {
		34712010,
		0,
		Lang.get(89475),
		34712,
		10,
		1048,
		{
			RTResTalkAction[3],
			RTResTalkAction[101]
		}
	},
	[34712011] = {
		34712011,
		0,
		Lang.get(89476),
		34712,
		11,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[34712012] = {
		34712012,
		0,
		Lang.get(89477),
		34712,
		12,
		1147,
		{
			RTResTalkAction[50]
		}
	},
	[34712013] = {
		34712013,
		0,
		Lang.get(89478),
		34712,
		13,
		1146,
		{
			RTResTalkAction[15],
			RTResTalkAction[59]
		}
	},
	[34853001] = {
		34853001,
		0,
		Lang.get(89479),
		34853,
		1,
		1163,
		nil,
		1,
		0,
		nil,
		nil,
		148,
		34811,
		nil,
		nil,
		nil,
		nil,
		nil,
		34811
	},
	[34853002] = {
		34853002,
		0,
		Lang.get(89480),
		34853,
		2,
		1146,
		{
			RTResTalkAction[109]
		},
		nil,
		nil,
		3
	},
	[34853003] = {
		34853003,
		0,
		Lang.get(89481),
		34853,
		3,
		1147,
		{
			RTResTalkAction[46],
			RTResTalkAction[110]
		}
	},
	[34853004] = {
		34853004,
		0,
		Lang.get(89482),
		34853,
		4,
		1049,
		{
			RTResTalkAction[111],
			RTResTalkAction[19],
			RTResTalkAction[25]
		}
	},
	[34853005] = {
		34853005,
		0,
		Lang.get(89483),
		34853,
		5,
		1048,
		{
			RTResTalkAction[112],
			RTResTalkAction[101]
		}
	},
	[34853006] = {
		34853006,
		0,
		Lang.get(89484),
		34853,
		6,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[34853007] = {
		34853007,
		0,
		Lang.get(89485),
		34853,
		7,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[34853008] = {
		34853008,
		0,
		Lang.get(89486),
		34853,
		8,
		1048,
		{
			RTResTalkAction[2]
		}
	},
	[34853009] = {
		34853009,
		0,
		Lang.get(89487),
		34853,
		9,
		235,
		{
			RTResTalkAction[62],
			RTResTalkAction[6]
		},
		nil,
		nil,
		nil,
		nil,
		63
	},
	[34853010] = {
		34853010,
		0,
		Lang.get(89488),
		34853,
		10,
		1054,
		{
			RTResTalkAction[113],
			RTResTalkAction[114]
		}
	},
	[34853011] = {
		34853011,
		0,
		Lang.get(89489),
		34853,
		11,
		235,
		{
			RTResTalkAction[113],
			RTResTalkAction[114]
		}
	},
	[34853012] = {
		34853012,
		0,
		Lang.get(89490),
		34853,
		12,
		1050,
		{
			RTResTalkAction[64],
			RTResTalkAction[68]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		34812,
		1,
		1,
		nil,
		nil,
		nil,
		34812
	},
	[34853013] = {
		34853013,
		0,
		Lang.get(89491),
		34853,
		13,
		1064
	},
	[34853014] = {
		34853014,
		3,
		Lang.get(89492),
		34853,
		14,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		34813,
		[19] = 34813,
		[22] = 1
	},
	[34853015] = {
		34853015,
		0,
		Lang.get(89493),
		34853,
		15,
		1073,
		nil,
		1,
		nil,
		nil,
		nil,
		57,
		nil,
		1
	},
	[34853016] = {
		34853016,
		0,
		Lang.get(89494),
		34853,
		16,
		1073,
		{
			RTResTalkAction[56]
		},
		nil,
		nil,
		3
	},
	[34853017] = {
		34853017,
		0,
		Lang.get(89495),
		34853,
		17,
		1073,
		{
			RTResTalkAction[56]
		}
	},
	[34713001] = {
		34713001,
		3,
		Lang.get(89496),
		34713,
		1,
		605,
		nil,
		nil,
		nil,
		3,
		nil,
		194,
		34815,
		1,
		nil,
		nil,
		nil,
		nil,
		34815,
		nil,
		nil,
		1
	},
	[34713002] = {
		34713002,
		0,
		Lang.get(89497),
		34713,
		2,
		1147,
		{
			RTResTalkAction[20]
		},
		nil,
		nil,
		nil,
		nil,
		158
	},
	[34713003] = {
		34713003,
		0,
		Lang.get(89498),
		34713,
		3,
		1163,
		{
			RTResTalkAction[38],
			RTResTalkAction[25]
		}
	},
	[34713004] = {
		34713004,
		3,
		Lang.get(89499),
		34713,
		4,
		605,
		{
			RTResTalkAction[39]
		},
		[22] = 1
	},
	[34713005] = {
		34713005,
		0,
		"……！",
		34713,
		5,
		1051,
		{
			RTResTalkAction[105]
		}
	},
	[34713006] = {
		34713006,
		0,
		Lang.get(89500),
		34713,
		6,
		1049,
		{
			RTResTalkAction[102],
			RTResTalkAction[108]
		}
	},
	[34713007] = {
		34713007,
		0,
		Lang.get(89501),
		34713,
		7,
		1049,
		{
			RTResTalkAction[102]
		}
	},
	[34713008] = {
		34713008,
		3,
		Lang.get(89502),
		34713,
		8,
		605,
		{
			RTResTalkAction[101]
		},
		[22] = 1
	},
	[34713009] = {
		34713009,
		0,
		Lang.get(89503),
		34713,
		9,
		1163,
		{
			RTResTalkAction[38]
		}
	},
	[34713010] = {
		34713010,
		0,
		Lang.get(89504),
		34713,
		10,
		1147,
		{
			RTResTalkAction[53],
			RTResTalkAction[39]
		}
	},
	[34713011] = {
		34713011,
		0,
		Lang.get(89505),
		34713,
		11,
		1146,
		{
			RTResTalkAction[15],
			RTResTalkAction[16]
		}
	},
	[34713012] = {
		34713012,
		0,
		Lang.get(89506),
		34713,
		12,
		1051,
		{
			RTResTalkAction[105],
			RTResTalkAction[25],
			RTResTalkAction[19]
		}
	},
	[34713013] = {
		34713013,
		0,
		Lang.get(89507),
		34713,
		13,
		1048,
		{
			RTResTalkAction[2],
			RTResTalkAction[108]
		}
	},
	[34713014] = {
		34713014,
		0,
		Lang.get(89508),
		34713,
		14,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[34713015] = {
		34713015,
		0,
		Lang.get(89509),
		34713,
		15,
		1051,
		{
			RTResTalkAction[105]
		}
	},
	[34713016] = {
		34713016,
		0,
		Lang.get(89510),
		34713,
		16,
		1051,
		{
			RTResTalkAction[105]
		}
	},
	[34713017] = {
		34713017,
		0,
		Lang.get(89511),
		34713,
		17,
		1049,
		{
			RTResTalkAction[115],
			RTResTalkAction[116]
		}
	},
	[34713018] = {
		34713018,
		0,
		Lang.get(89512),
		34713,
		18,
		1048,
		{
			RTResTalkAction[2],
			RTResTalkAction[108],
			RTResTalkAction[101]
		}
	},
	[34713019] = {
		34713019,
		0,
		Lang.get(89513),
		34713,
		19,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[34713020] = {
		34713020,
		0,
		Lang.get(89514),
		34713,
		20,
		1049,
		{
			RTResTalkAction[117]
		},
		nil,
		nil,
		nil,
		nil,
		161,
		nil,
		1,
		1
	},
	[34713021] = {
		34713021,
		0,
		Lang.get(89515),
		34713,
		21,
		1163,
		{
			RTResTalkAction[38],
			RTResTalkAction[101]
		}
	},
	[34713022] = {
		34713022,
		0,
		Lang.get(89516),
		34713,
		22,
		1146,
		{
			RTResTalkAction[42],
			RTResTalkAction[39]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[34713023] = {
		34713023,
		0,
		Lang.get(89517),
		34713,
		23,
		1163,
		{
			RTResTalkAction[38],
			RTResTalkAction[19]
		}
	},
	[34713024] = {
		34713024,
		0,
		Lang.get(89518),
		34713,
		24,
		1147,
		{
			RTResTalkAction[51],
			RTResTalkAction[39]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[34713025] = {
		34713025,
		0,
		Lang.get(89519),
		34713,
		25,
		1163,
		{
			RTResTalkAction[48],
			RTResTalkAction[25]
		}
	},
	[34713026] = {
		34713026,
		0,
		Lang.get(89520),
		34713,
		26,
		1163,
		{
			RTResTalkAction[38]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		34818,
		1,
		1,
		nil,
		1,
		nil,
		34818
	},
	[34713027] = {
		34713027,
		0,
		Lang.get(89521),
		34713,
		27,
		1051,
		{
			RTResTalkAction[105],
			RTResTalkAction[39]
		}
	},
	[34713028] = {
		34713028,
		0,
		Lang.get(89522),
		34713,
		28,
		1147,
		{
			RTResTalkAction[107],
			RTResTalkAction[108]
		}
	},
	[34713029] = {
		34713029,
		0,
		Lang.get(89523),
		34713,
		29,
		1146,
		{
			RTResTalkAction[118],
			RTResTalkAction[25]
		}
	},
	[34713030] = {
		34713030,
		0,
		Lang.get(89524),
		34713,
		30,
		1051,
		{
			RTResTalkAction[105],
			RTResTalkAction[19]
		}
	},
	[34713031] = {
		34713031,
		3,
		Lang.get(23602),
		34713,
		31,
		605,
		{
			RTResTalkAction[108]
		},
		nil,
		nil,
		nil,
		nil,
		57,
		[22] = 1
	},
	[34713032] = {
		34713032,
		3,
		Lang.get(89525),
		34713,
		32,
		605,
		[22] = 1
	},
	[34713033] = {
		34713033,
		0,
		Lang.get(89526),
		34713,
		33,
		1146,
		nil,
		1,
		2,
		-1,
		nil,
		nil,
		34816,
		nil,
		nil,
		nil,
		nil,
		nil,
		34816
	},
	[34713034] = {
		34713034,
		0,
		Lang.get(89527),
		34713,
		34,
		1051,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[34713035] = {
		34713035,
		0,
		Lang.get(89528),
		34713,
		35,
		300
	},
	[34713036] = {
		34713036,
		5,
		Lang.get(89529),
		34713,
		36,
		1163,
		nil,
		1
	},
	[34713037] = {
		34713037,
		0,
		Lang.get(89530),
		34713,
		37,
		1048,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		34817,
		[19] = 34817
	},
	[34713038] = {
		34713038,
		9,
		Lang.get(89531),
		34713,
		38,
		[22] = 1
	},
	[34713039] = {
		34713039,
		0,
		Lang.get(89532),
		34713,
		39,
		1073,
		nil,
		1,
		1
	},
	[34713040] = {
		34713040,
		0,
		Lang.get(89266),
		34713,
		40,
		300
	},
	[34713041] = {
		34713041,
		0,
		Lang.get(89533),
		34713,
		41,
		1073,
		{
			RTResTalkAction[119]
		},
		nil,
		nil,
		3
	},
	[34714001] = {
		34714001,
		0,
		Lang.get(89534),
		34714,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		57,
		34820,
		[19] = 34820
	},
	[34714002] = {
		34714002,
		0,
		Lang.get(89535),
		34714,
		2,
		1073,
		nil,
		1,
		1
	},
	[34714003] = {
		34714003,
		0,
		Lang.get(89536),
		34714,
		3,
		1073,
		nil,
		1,
		1
	},
	[34714004] = {
		34714004,
		9,
		Lang.get(89537),
		34714,
		4,
		[22] = 1
	},
	[34714005] = {
		34714005,
		0,
		Lang.get(89538),
		34714,
		5,
		1049,
		{
			RTResTalkAction[102]
		},
		nil,
		nil,
		3
	},
	[34714006] = {
		34714006,
		0,
		Lang.get(89539),
		34714,
		6,
		1048,
		{
			RTResTalkAction[112],
			RTResTalkAction[101]
		}
	},
	[34714007] = {
		34714007,
		0,
		Lang.get(89540),
		34714,
		7,
		1146,
		{
			RTResTalkAction[103],
			RTResTalkAction[6]
		}
	},
	[34714008] = {
		34714008,
		0,
		Lang.get(89541),
		34714,
		8,
		1147,
		{
			RTResTalkAction[50],
			RTResTalkAction[19]
		}
	},
	[34714009] = {
		34714009,
		0,
		Lang.get(89542),
		34714,
		9,
		235,
		{
			RTResTalkAction[120],
			RTResTalkAction[25]
		}
	},
	[34714010] = {
		34714010,
		0,
		Lang.get(89543),
		34714,
		10,
		235,
		{
			RTResTalkAction[62]
		}
	},
	[34714011] = {
		34714011,
		0,
		Lang.get(89544),
		34714,
		11,
		1054,
		{
			RTResTalkAction[121],
			RTResTalkAction[64]
		}
	},
	[34714012] = {
		34714012,
		0,
		Lang.get(89545),
		34714,
		12,
		1054,
		{
			RTResTalkAction[121]
		}
	},
	[34714013] = {
		34714013,
		0,
		Lang.get(89546),
		34714,
		13,
		1163,
		{
			RTResTalkAction[61],
			RTResTalkAction[68]
		}
	},
	[34714014] = {
		34714014,
		0,
		Lang.get(89547),
		34714,
		14,
		300,
		{
			RTResTalkAction[39]
		}
	},
	[34714015] = {
		34714015,
		0,
		Lang.get(89548),
		34714,
		15,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		154
	},
	[34714016] = {
		34714016,
		0,
		Lang.get(89549),
		34714,
		16,
		1073,
		{
			RTResTalkAction[56]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[34714017] = {
		34714017,
		0,
		Lang.get(89550),
		34714,
		17,
		1073,
		{
			RTResTalkAction[122]
		}
	},
	[34714018] = {
		34714018,
		0,
		Lang.get(89551),
		34714,
		18,
		1050,
		{
			RTResTalkAction[57]
		},
		1,
		nil,
		-1,
		nil,
		nil,
		34821,
		nil,
		1,
		nil,
		nil,
		nil,
		34821
	},
	[34714019] = {
		34714019,
		0,
		Lang.get(89552),
		34714,
		19,
		1050,
		nil,
		1
	},
	[34714020] = {
		34714020,
		0,
		Lang.get(89553),
		34714,
		20,
		1073,
		{
			RTResTalkAction[56]
		},
		nil,
		nil,
		3
	},
	[34714021] = {
		34714021,
		0,
		Lang.get(89554),
		34714,
		21,
		1073,
		{
			RTResTalkAction[56]
		}
	},
	[34714022] = {
		34714022,
		4,
		nil,
		34714,
		22,
		300,
		{
			RTResTalkAction[56]
		},
		[29] = {
			{
				id = 34714023,
				branch_content = Lang.get(89555)
			},
			{
				id = 34714023,
				branch_content = Lang.get(89556)
			}
		}
	},
	[34714023] = {
		34714023,
		0,
		Lang.get(89557),
		34714,
		23,
		1050,
		{
			RTResTalkAction[74],
			RTResTalkAction[57]
		}
	},
	[34714024] = {
		34714024,
		0,
		Lang.get(89558),
		34714,
		24,
		1050,
		{
			RTResTalkAction[74]
		}
	},
	[34714025] = {
		34714025,
		0,
		Lang.get(89559),
		34714,
		25,
		1053,
		{
			RTResTalkAction[29],
			RTResTalkAction[75]
		}
	},
	[34714026] = {
		34714026,
		5,
		Lang.get(89560),
		34714,
		26,
		1052,
		{
			RTResTalkAction[36],
			RTResTalkAction[123]
		}
	},
	[34714027] = {
		34714027,
		0,
		Lang.get(89561),
		34714,
		27,
		1050,
		{
			RTResTalkAction[74],
			RTResTalkAction[31],
			RTResTalkAction[34]
		}
	},
	[34714028] = {
		34714028,
		0,
		Lang.get(89562),
		34714,
		28,
		1050,
		{
			RTResTalkAction[74]
		}
	},
	[34714029] = {
		34714029,
		4,
		nil,
		34714,
		29,
		300,
		{
			RTResTalkAction[74]
		},
		[29] = {
			{
				id = 34714030,
				branch_content = Lang.get(89563)
			},
			{
				id = 34714030,
				branch_content = Lang.get(89564)
			}
		}
	},
	[34714030] = {
		34714030,
		0,
		Lang.get(89565),
		34714,
		30,
		300,
		{
			RTResTalkAction[74]
		},
		nil,
		nil,
		nil,
		nil,
		163
	},
	[34714031] = {
		34714031,
		0,
		Lang.get(89566),
		34714,
		31,
		1050,
		{
			RTResTalkAction[74]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[34714032] = {
		34714032,
		0,
		Lang.get(89567),
		34714,
		32,
		1054,
		{
			RTResTalkAction[66],
			RTResTalkAction[84]
		}
	},
	[34715001] = {
		34715001,
		0,
		Lang.get(89568),
		34715,
		1,
		1054,
		nil,
		1,
		0,
		nil,
		nil,
		176,
		34825,
		nil,
		nil,
		nil,
		nil,
		nil,
		34825
	},
	[34715002] = {
		34715002,
		0,
		Lang.get(89569),
		34715,
		2,
		1052,
		{
			RTResTalkAction[32]
		},
		nil,
		nil,
		3
	},
	[34715003] = {
		34715003,
		0,
		Lang.get(89570),
		34715,
		3,
		1052,
		{
			RTResTalkAction[32]
		}
	},
	[34715004] = {
		34715004,
		9,
		Lang.get(89571),
		34715,
		4,
		[22] = 1,
		[7] = {
			RTResTalkAction[34]
		}
	},
	[34715005] = {
		34715005,
		9,
		Lang.get(69024),
		34715,
		5,
		nil,
		nil,
		nil,
		nil,
		3,
		nil,
		nil,
		34828,
		1,
		[19] = 34828,
		[22] = 1
	},
	[34715006] = {
		34715006,
		0,
		Lang.get(89572),
		34715,
		6,
		1052,
		{
			RTResTalkAction[32]
		},
		nil,
		nil,
		nil,
		1220,
		nil,
		nil,
		1
	},
	[34715007] = {
		34715007,
		0,
		Lang.get(89573),
		34715,
		7,
		1054,
		{
			RTResTalkAction[121],
			RTResTalkAction[34]
		}
	},
	[34715008] = {
		34715008,
		0,
		Lang.get(89574),
		34715,
		8,
		1052,
		{
			RTResTalkAction[32],
			RTResTalkAction[68]
		}
	},
	[34715009] = {
		34715009,
		0,
		Lang.get(89575),
		34715,
		9,
		1163,
		{
			RTResTalkAction[38],
			RTResTalkAction[34]
		}
	},
	[34715010] = {
		34715010,
		9,
		Lang.get(89576),
		34715,
		10,
		nil,
		{
			RTResTalkAction[39]
		},
		nil,
		nil,
		nil,
		1220,
		[22] = 1
	},
	[34715011] = {
		34715011,
		0,
		Lang.get(89577),
		34715,
		11,
		1050,
		{
			RTResTalkAction[74]
		},
		nil,
		nil,
		nil,
		1220
	},
	[34715012] = {
		34715012,
		0,
		Lang.get(89578),
		34715,
		12,
		1050,
		{
			RTResTalkAction[74]
		}
	},
	[34715013] = {
		34715013,
		9,
		Lang.get(89579),
		34715,
		13,
		nil,
		{
			RTResTalkAction[75]
		},
		nil,
		nil,
		nil,
		1220,
		[22] = 1
	},
	[34715014] = {
		34715014,
		0,
		Lang.get(89580),
		34715,
		14,
		1163,
		{
			RTResTalkAction[38]
		}
	},
	[34715015] = {
		34715015,
		9,
		Lang.get(89581),
		34715,
		15,
		nil,
		{
			RTResTalkAction[39]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		34826,
		nil,
		1,
		nil,
		1,
		nil,
		34826,
		nil,
		nil,
		1
	},
	[34715016] = {
		34715016,
		0,
		Lang.get(89582),
		34715,
		16,
		1052,
		nil,
		1
	},
	[34715017] = {
		34715017,
		0,
		Lang.get(89583),
		34715,
		17,
		1053,
		nil,
		1
	},
	[34715018] = {
		34715018,
		0,
		Lang.get(89584),
		34715,
		18,
		1048,
		nil,
		1,
		3
	},
	[34715019] = {
		34715019,
		9,
		Lang.get(89585),
		34715,
		19,
		nil,
		nil,
		nil,
		nil,
		3,
		[22] = 1
	},
	[34715020] = {
		34715020,
		0,
		Lang.get(89586),
		34715,
		20,
		1054,
		{
			RTResTalkAction[121]
		},
		nil,
		nil,
		nil,
		nil,
		57
	},
	[34715021] = {
		34715021,
		0,
		Lang.get(89587),
		34715,
		21,
		1051,
		{
			RTResTalkAction[105],
			RTResTalkAction[68]
		}
	},
	[34715022] = {
		34715022,
		0,
		Lang.get(89588),
		34715,
		22,
		1052,
		{
			RTResTalkAction[32],
			RTResTalkAction[108]
		}
	},
	[34715023] = {
		34715023,
		0,
		Lang.get(89589),
		34715,
		23,
		1050,
		{
			RTResTalkAction[124],
			RTResTalkAction[34]
		}
	},
	[34715024] = {
		34715024,
		0,
		Lang.get(89590),
		34715,
		24,
		1148,
		{
			RTResTalkAction[125],
			RTResTalkAction[75]
		}
	},
	[34715025] = {
		34715025,
		0,
		Lang.get(89591),
		34715,
		25,
		1053,
		{
			RTResTalkAction[29],
			RTResTalkAction[126]
		}
	},
	[34715026] = {
		34715026,
		0,
		Lang.get(89592),
		34715,
		26,
		1048,
		{
			RTResTalkAction[87],
			RTResTalkAction[31]
		}
	},
	[34715027] = {
		34715027,
		0,
		Lang.get(89593),
		34715,
		27,
		1163,
		{
			RTResTalkAction[38],
			RTResTalkAction[6]
		}
	},
	[34715028] = {
		34715028,
		0,
		Lang.get(89594),
		34715,
		28,
		300,
		{
			RTResTalkAction[39]
		}
	},
	[34715029] = {
		34715029,
		0,
		Lang.get(89595),
		34715,
		29,
		1146,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		nil,
		nil,
		158
	},
	[34715030] = {
		34715030,
		0,
		Lang.get(89596),
		34715,
		30,
		1147,
		{
			RTResTalkAction[76],
			RTResTalkAction[19]
		}
	},
	[34715031] = {
		34715031,
		0,
		Lang.get(89597),
		34715,
		31,
		1148,
		{
			RTResTalkAction[127],
			RTResTalkAction[25]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		34827,
		1,
		1,
		nil,
		1,
		nil,
		34827
	},
	[34715032] = {
		34715032,
		0,
		Lang.get(89598),
		34715,
		32,
		1163,
		{
			RTResTalkAction[86],
			RTResTalkAction[126]
		}
	},
	[34715033] = {
		34715033,
		0,
		Lang.get(89599),
		34715,
		33,
		1147,
		{
			RTResTalkAction[51],
			RTResTalkAction[39]
		}
	},
	[34715034] = {
		34715034,
		9,
		Lang.get(89600),
		34715,
		34,
		[22] = 1,
		[7] = {
			RTResTalkAction[53]
		}
	},
	[34715035] = {
		34715035,
		0,
		Lang.get(89601),
		34715,
		35,
		1148,
		{
			RTResTalkAction[128],
			RTResTalkAction[25]
		}
	},
	[34715036] = {
		34715036,
		0,
		Lang.get(89602),
		34715,
		36,
		1163,
		{
			RTResTalkAction[61],
			RTResTalkAction[126]
		}
	},
	[34715037] = {
		34715037,
		0,
		Lang.get(89603),
		34715,
		37,
		1146,
		{
			RTResTalkAction[90],
			RTResTalkAction[39]
		}
	},
	[34716001] = {
		34716001,
		0,
		Lang.get(89604),
		34716,
		1,
		1148,
		nil,
		1,
		0,
		nil,
		nil,
		63,
		34830,
		nil,
		nil,
		nil,
		nil,
		nil,
		34830
	},
	[34716002] = {
		34716002,
		0,
		Lang.get(89605),
		34716,
		2,
		1050,
		{
			RTResTalkAction[74]
		},
		nil,
		nil,
		3
	},
	[34716003] = {
		34716003,
		0,
		Lang.get(89606),
		34716,
		3,
		1064,
		{
			RTResTalkAction[78],
			RTResTalkAction[75]
		}
	},
	[34716004] = {
		34716004,
		0,
		Lang.get(89607),
		34716,
		4,
		1064,
		{
			RTResTalkAction[129]
		}
	},
	[34716005] = {
		34716005,
		0,
		Lang.get(89608),
		34716,
		5,
		1054,
		{
			RTResTalkAction[130],
			RTResTalkAction[79]
		}
	},
	[34716006] = {
		34716006,
		0,
		Lang.get(89609),
		34716,
		6,
		1053,
		{
			RTResTalkAction[66],
			RTResTalkAction[131]
		}
	},
	[34716007] = {
		34716007,
		5,
		Lang.get(89610),
		34716,
		7,
		1048,
		{
			RTResTalkAction[132],
			RTResTalkAction[68],
			RTResTalkAction[31]
		},
		nil,
		nil,
		nil,
		nil,
		148
	},
	[34716008] = {
		34716008,
		9,
		Lang.get(89611),
		34716,
		8,
		[22] = 1,
		[7] = {
			RTResTalkAction[2]
		}
	},
	[34716009] = {
		34716009,
		0,
		Lang.get(89612),
		34716,
		9,
		1148,
		{
			RTResTalkAction[133],
			RTResTalkAction[6]
		}
	},
	[34716010] = {
		34716010,
		0,
		Lang.get(89613),
		34716,
		10,
		1048,
		{
			RTResTalkAction[3],
			RTResTalkAction[126]
		}
	},
	[34716011] = {
		34716011,
		0,
		Lang.get(89614),
		34716,
		11,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[34716012] = {
		34716012,
		0,
		Lang.get(89615),
		34716,
		12,
		1146,
		{
			RTResTalkAction[134],
			RTResTalkAction[6]
		}
	},
	[34716013] = {
		34716013,
		0,
		Lang.get(89616),
		34716,
		13,
		1163,
		{
			RTResTalkAction[38],
			RTResTalkAction[19]
		}
	},
	[34716014] = {
		34716014,
		0,
		Lang.get(89617),
		34716,
		14,
		1163,
		{
			RTResTalkAction[61]
		}
	},
	[34716015] = {
		34716015,
		9,
		Lang.get(89618),
		34716,
		15,
		[22] = 1,
		[7] = {
			RTResTalkAction[39]
		}
	},
	[34716016] = {
		34716016,
		0,
		Lang.get(89619),
		34716,
		16,
		1051,
		{
			RTResTalkAction[105]
		}
	},
	[34716017] = {
		34716017,
		0,
		Lang.get(89620),
		34716,
		17,
		1053,
		{
			RTResTalkAction[115],
			RTResTalkAction[131]
		}
	},
	[34716018] = {
		34716018,
		0,
		Lang.get(89621),
		34716,
		18,
		1146,
		{
			RTResTalkAction[42],
			RTResTalkAction[108],
			RTResTalkAction[31]
		}
	},
	[34716019] = {
		34716019,
		0,
		Lang.get(89622),
		34716,
		19,
		1147,
		{
			RTResTalkAction[46],
			RTResTalkAction[135]
		}
	},
	[34716020] = {
		34716020,
		0,
		Lang.get(89623),
		34716,
		20,
		1148,
		{
			RTResTalkAction[128],
			RTResTalkAction[19],
			RTResTalkAction[25]
		}
	},
	[34716021] = {
		34716021,
		9,
		Lang.get(89624),
		34716,
		21,
		nil,
		{
			RTResTalkAction[126]
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
	[34716022] = {
		34716022,
		0,
		Lang.get(89625),
		34716,
		22,
		1048,
		nil,
		1,
		2,
		-1,
		nil,
		154,
		34831,
		nil,
		nil,
		nil,
		nil,
		nil,
		34831,
		-1
	},
	[34716023] = {
		34716023,
		0,
		Lang.get(89626),
		34716,
		23,
		1073,
		nil,
		1
	},
	[34716024] = {
		34716024,
		0,
		Lang.get(89627),
		34716,
		24,
		1048,
		nil,
		1,
		3
	},
	[34716025] = {
		34716025,
		0,
		Lang.get(89628),
		34716,
		25,
		1073,
		{
			RTResTalkAction[122]
		},
		nil,
		nil,
		3
	},
	[34716026] = {
		34716026,
		0,
		Lang.get(89629),
		34716,
		26,
		1048,
		{
			RTResTalkAction[136],
			RTResTalkAction[137]
		}
	},
	[34716027] = {
		34716027,
		0,
		Lang.get(89630),
		34716,
		27,
		1073,
		{
			RTResTalkAction[138],
			RTResTalkAction[139]
		}
	},
	[34716028] = {
		34716028,
		0,
		Lang.get(89631),
		34716,
		28,
		1073,
		{
			RTResTalkAction[136],
			RTResTalkAction[139]
		}
	},
	[34716029] = {
		34716029,
		0,
		Lang.get(89632),
		34716,
		29,
		1048,
		{
			RTResTalkAction[136],
			RTResTalkAction[139]
		}
	},
	[34716030] = {
		34716030,
		0,
		Lang.get(89633),
		34716,
		30,
		1048,
		{
			RTResTalkAction[136],
			RTResTalkAction[140]
		}
	},
	[34716031] = {
		34716031,
		0,
		Lang.get(89634),
		34716,
		31,
		1073,
		{
			RTResTalkAction[141],
			RTResTalkAction[139]
		}
	},
	[34717001] = {
		34717001,
		0,
		Lang.get(89635),
		34717,
		1,
		1147,
		nil,
		1,
		1,
		nil,
		nil,
		158,
		34835,
		nil,
		nil,
		nil,
		nil,
		nil,
		34835
	},
	[34717002] = {
		34717002,
		0,
		Lang.get(89636),
		34717,
		2,
		1146,
		nil,
		1,
		0
	},
	[34717003] = {
		34717003,
		0,
		Lang.get(89637),
		34717,
		3,
		1147,
		{
			RTResTalkAction[51]
		},
		nil,
		nil,
		3
	},
	[34717004] = {
		34717004,
		0,
		Lang.get(89638),
		34717,
		4,
		1146,
		{
			RTResTalkAction[142],
			RTResTalkAction[25]
		}
	},
	[34717005] = {
		34717005,
		9,
		Lang.get(89639),
		34717,
		5,
		[22] = 1,
		[7] = {
			RTResTalkAction[127],
			RTResTalkAction[19]
		}
	},
	[34717006] = {
		34717006,
		0,
		Lang.get(89640),
		34717,
		6,
		1054,
		{
			RTResTalkAction[121],
			RTResTalkAction[126]
		},
		nil,
		nil,
		nil,
		nil,
		58
	},
	[34717007] = {
		34717007,
		0,
		Lang.get(89641),
		34717,
		7,
		235,
		{
			RTResTalkAction[66],
			RTResTalkAction[143]
		}
	},
	[34717008] = {
		34717008,
		0,
		Lang.get(89642),
		34717,
		8,
		1051,
		{
			RTResTalkAction[105],
			RTResTalkAction[68],
			RTResTalkAction[64]
		}
	},
	[34717009] = {
		34717009,
		0,
		Lang.get(89643),
		34717,
		9,
		1053,
		{
			RTResTalkAction[29],
			RTResTalkAction[108]
		}
	},
	[34717010] = {
		34717010,
		0,
		Lang.get(89644),
		34717,
		10,
		1052,
		{
			RTResTalkAction[32],
			RTResTalkAction[31]
		}
	},
	[34717011] = {
		34717011,
		0,
		Lang.get(89645),
		34717,
		11,
		1049,
		{
			RTResTalkAction[117],
			RTResTalkAction[34]
		}
	},
	[34717012] = {
		34717012,
		0,
		Lang.get(89646),
		34717,
		12,
		1049,
		{
			RTResTalkAction[102]
		}
	},
	[34717013] = {
		34717013,
		5,
		Lang.get(89647),
		34717,
		13,
		1163,
		{
			RTResTalkAction[61],
			RTResTalkAction[101]
		}
	},
	[34717014] = {
		34717014,
		0,
		Lang.get(89648),
		34717,
		14,
		1050,
		{
			RTResTalkAction[74],
			RTResTalkAction[39]
		}
	},
	[34717015] = {
		34717015,
		0,
		Lang.get(89649),
		34717,
		15,
		1147,
		{
			RTResTalkAction[18],
			RTResTalkAction[75]
		}
	},
	[34717016] = {
		34717016,
		0,
		Lang.get(89650),
		34717,
		16,
		1146,
		{
			RTResTalkAction[144],
			RTResTalkAction[59]
		}
	},
	[34717017] = {
		34717017,
		0,
		Lang.get(89651),
		34717,
		17,
		1147,
		{
			RTResTalkAction[145],
			RTResTalkAction[17]
		}
	},
	[34717018] = {
		34717018,
		0,
		Lang.get(89652),
		34717,
		18,
		300,
		{
			RTResTalkAction[15],
			RTResTalkAction[17]
		}
	},
	[34717019] = {
		34717019,
		0,
		Lang.get(89653),
		34717,
		19,
		300,
		{
			RTResTalkAction[15],
			RTResTalkAction[17]
		}
	},
	[34717020] = {
		34717020,
		5,
		Lang.get(68061),
		34717,
		20,
		1146,
		{
			RTResTalkAction[146],
			RTResTalkAction[25]
		}
	},
	[34717021] = {
		34717021,
		9,
		Lang.get(89654),
		34717,
		21,
		nil,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		34836,
		1,
		1,
		nil,
		nil,
		nil,
		34836,
		nil,
		nil,
		1
	},
	[34717022] = {
		34717022,
		0,
		Lang.get(89655),
		34717,
		22,
		1073,
		nil,
		1,
		0,
		nil,
		nil,
		114
	},
	[34717023] = {
		34717023,
		0,
		Lang.get(89656),
		34717,
		23,
		1073,
		nil,
		1
	},
	[34717024] = {
		34717024,
		0,
		Lang.get(89657),
		34717,
		24,
		1048,
		nil,
		1,
		2
	},
	[34717025] = {
		34717025,
		0,
		Lang.get(89658),
		34717,
		25,
		1073,
		nil,
		1,
		0
	},
	[34717026] = {
		34717026,
		0,
		Lang.get(89659),
		34717,
		26,
		1073,
		nil,
		1
	},
	[34717027] = {
		34717027,
		0,
		Lang.get(89660),
		34717,
		27,
		1146,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		34837,
		nil,
		nil,
		nil,
		nil,
		nil,
		34837
	},
	[34717028] = {
		34717028,
		0,
		Lang.get(89661),
		34717,
		28,
		300
	},
	[34717029] = {
		34717029,
		0,
		Lang.get(89662),
		34717,
		29,
		1147,
		nil,
		1,
		2,
		nil,
		nil,
		59
	},
	[34717030] = {
		34717030,
		0,
		"！！！",
		34717,
		30,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		34838,
		[19] = 34838
	},
	[34717031] = {
		34717031,
		0,
		Lang.get(89663),
		34717,
		31,
		1163,
		nil,
		1,
		0
	},
	[34717032] = {
		34717032,
		0,
		Lang.get(89664),
		34717,
		32,
		1146,
		nil,
		1,
		1
	},
	[34718001] = {
		34718001,
		5,
		Lang.get(24404),
		34718,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		1233,
		196,
		34840,
		nil,
		nil,
		nil,
		nil,
		nil,
		34840,
		nil,
		nil,
		1
	},
	[34718002] = {
		34718002,
		0,
		Lang.get(89665),
		34718,
		2,
		1049,
		{
			RTResTalkAction[100]
		},
		nil,
		nil,
		3
	},
	[34718003] = {
		34718003,
		0,
		Lang.get(89666),
		34718,
		3,
		1052,
		{
			RTResTalkAction[32],
			RTResTalkAction[101]
		}
	},
	[34718004] = {
		34718004,
		0,
		Lang.get(89667),
		34718,
		4,
		1051,
		{
			RTResTalkAction[104],
			RTResTalkAction[34]
		}
	},
	[34718005] = {
		34718005,
		0,
		Lang.get(89668),
		34718,
		5,
		1050,
		{
			RTResTalkAction[74],
			RTResTalkAction[108]
		}
	},
	[34718006] = {
		34718006,
		5,
		Lang.get(89669),
		34718,
		6,
		605,
		{
			RTResTalkAction[75]
		},
		nil,
		nil,
		3,
		1222,
		nil,
		34841,
		1,
		1,
		nil,
		nil,
		nil,
		34841,
		nil,
		nil,
		1
	},
	[34718007] = {
		34718007,
		0,
		Lang.get(89670),
		34718,
		7,
		235,
		{
			RTResTalkAction[62]
		},
		nil,
		nil,
		nil,
		1222
	},
	[34718008] = {
		34718008,
		0,
		Lang.get(89671),
		34718,
		8,
		1049,
		{
			RTResTalkAction[102],
			RTResTalkAction[64]
		}
	},
	[34718009] = {
		34718009,
		0,
		Lang.get(89672),
		34718,
		9,
		1054,
		{
			RTResTalkAction[121],
			RTResTalkAction[101]
		}
	},
	[34718010] = {
		34718010,
		0,
		Lang.get(89673),
		34718,
		10,
		300,
		{
			RTResTalkAction[147],
			RTResTalkAction[68]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[21] = 423
	},
	[34718011] = {
		34718011,
		0,
		Lang.get(89674),
		34718,
		11,
		1163,
		{
			RTResTalkAction[147]
		},
		1,
		[21] = 423
	},
	[34718012] = {
		34718012,
		0,
		Lang.get(89675),
		34718,
		12,
		1052,
		{
			RTResTalkAction[147]
		},
		1,
		[21] = 423
	},
	[34718013] = {
		34718013,
		0,
		Lang.get(89676),
		34718,
		13,
		1048,
		{
			RTResTalkAction[148]
		},
		1,
		0,
		-1,
		nil,
		nil,
		34842,
		1,
		1,
		nil,
		1,
		nil,
		34842
	},
	[34718014] = {
		34718014,
		0,
		"……",
		34718,
		14,
		1073,
		nil,
		1,
		nil,
		nil,
		nil,
		59
	},
	[34718015] = {
		34718015,
		0,
		Lang.get(89677),
		34718,
		15,
		1073,
		{
			RTResTalkAction[56]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		nil,
		1
	},
	[34718016] = {
		34718016,
		0,
		Lang.get(89678),
		34718,
		16,
		1073,
		{
			RTResTalkAction[56]
		}
	},
	[34718017] = {
		34718017,
		0,
		Lang.get(89679),
		34718,
		17,
		1163,
		{
			RTResTalkAction[136],
			RTResTalkAction[149]
		}
	},
	[34718018] = {
		34718018,
		0,
		Lang.get(89680),
		34718,
		18,
		1146,
		{
			RTResTalkAction[103],
			RTResTalkAction[57],
			RTResTalkAction[39]
		}
	},
	[34718019] = {
		34718019,
		0,
		Lang.get(89681),
		34718,
		19,
		1147,
		{
			RTResTalkAction[46],
			RTResTalkAction[47]
		}
	},
	[34718020] = {
		34718020,
		0,
		Lang.get(89682),
		34718,
		20,
		300,
		{
			RTResTalkAction[19],
			RTResTalkAction[25]
		},
		nil,
		nil,
		nil,
		nil,
		196
	},
	[34718021] = {
		34718021,
		0,
		Lang.get(89683),
		34718,
		21,
		300
	},
	[34718022] = {
		34718022,
		0,
		Lang.get(89684),
		34718,
		22,
		1147,
		{
			RTResTalkAction[107]
		}
	},
	[34718023] = {
		34718023,
		0,
		Lang.get(89685),
		34718,
		23,
		1146,
		{
			RTResTalkAction[14],
			RTResTalkAction[25]
		}
	},
	[34718024] = {
		34718024,
		0,
		Lang.get(89686),
		34718,
		24,
		300,
		{
			RTResTalkAction[19]
		}
	},
	[34718025] = {
		34718025,
		0,
		Lang.get(89687),
		34718,
		25,
		1048,
		{
			RTResTalkAction[2]
		}
	},
	[34718026] = {
		34718026,
		0,
		Lang.get(89688),
		34718,
		26,
		1147,
		{
			RTResTalkAction[150],
			RTResTalkAction[45]
		}
	},
	[34718027] = {
		34718027,
		3,
		Lang.get(89689),
		34718,
		27,
		605,
		{
			RTResTalkAction[6],
			RTResTalkAction[25]
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
	[34718028] = {
		34718028,
		0,
		Lang.get(89690),
		34718,
		28,
		300,
		nil,
		nil,
		nil,
		-1,
		nil,
		nil,
		34843,
		nil,
		nil,
		nil,
		1,
		nil,
		34843,
		-1
	},
	[34718029] = {
		34718029,
		0,
		Lang.get(89691),
		34718,
		29,
		1073,
		nil,
		1,
		0
	},
	[34718030] = {
		34718030,
		0,
		nil,
		34718,
		30,
		300,
		[29] = {
			{
				id = 34718031,
				branch_content = Lang.get(90175)
			},
			{
				id = 34718031,
				branch_content = Lang.get(90176)
			}
		}
	},
	[34718031] = {
		34718031,
		0,
		Lang.get(89693),
		34718,
		31,
		1050,
		nil,
		1,
		0
	},
	[34718032] = {
		34718032,
		0,
		Lang.get(89694),
		34718,
		32,
		1050,
		nil,
		1
	},
	[34718033] = {
		34718033,
		3,
		Lang.get(89695),
		34718,
		33,
		605,
		[22] = 1
	},
	[34718034] = {
		34718034,
		0,
		Lang.get(89696),
		34718,
		34,
		1073,
		{
			RTResTalkAction[122]
		},
		nil,
		nil,
		3
	},
	[34718035] = {
		34718035,
		0,
		Lang.get(25821),
		34718,
		35,
		300,
		{
			RTResTalkAction[56]
		}
	},
	[34718036] = {
		34718036,
		0,
		Lang.get(89697),
		34718,
		36,
		1163,
		{
			RTResTalkAction[38],
			RTResTalkAction[57]
		}
	},
	[34719001] = {
		34719001,
		9,
		Lang.get(89669),
		34719,
		1,
		nil,
		nil,
		nil,
		nil,
		3,
		1222,
		195,
		34850,
		nil,
		nil,
		nil,
		nil,
		nil,
		34850,
		nil,
		nil,
		1
	},
	[34719002] = {
		34719002,
		0,
		Lang.get(89698),
		34719,
		2,
		1147,
		{
			RTResTalkAction[53]
		}
	},
	[34719003] = {
		34719003,
		0,
		Lang.get(89699),
		34719,
		3,
		1146,
		{
			RTResTalkAction[42],
			RTResTalkAction[25]
		}
	},
	[34719004] = {
		34719004,
		0,
		Lang.get(89700),
		34719,
		4,
		1064,
		{
			RTResTalkAction[78],
			RTResTalkAction[19]
		}
	},
	[34719005] = {
		34719005,
		0,
		Lang.get(89701),
		34719,
		5,
		1146,
		{
			RTResTalkAction[151],
			RTResTalkAction[79]
		}
	},
	[34719006] = {
		34719006,
		9,
		Lang.get(89702),
		34719,
		6,
		nil,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		nil,
		1222,
		[22] = 1,
		[20] = 200
	},
	[34719007] = {
		34719007,
		0,
		Lang.get(89703),
		34719,
		7,
		1054,
		{
			RTResTalkAction[152]
		},
		[20] = -1
	},
	[34719008] = {
		34719008,
		0,
		Lang.get(89704),
		34719,
		8,
		235,
		{
			RTResTalkAction[62],
			RTResTalkAction[68]
		}
	},
	[34719009] = {
		34719009,
		0,
		Lang.get(89705),
		34719,
		9,
		1051,
		{
			RTResTalkAction[153],
			RTResTalkAction[64]
		}
	},
	[34719010] = {
		34719010,
		0,
		Lang.get(89706),
		34719,
		10,
		1049,
		{
			RTResTalkAction[115],
			RTResTalkAction[116]
		}
	},
	[34719011] = {
		34719011,
		9,
		Lang.get(89707),
		34719,
		11,
		nil,
		{
			RTResTalkAction[108],
			RTResTalkAction[101]
		},
		nil,
		nil,
		nil,
		1222,
		[22] = 1,
		[20] = 200
	},
	[34719012] = {
		34719012,
		0,
		Lang.get(89708),
		34719,
		12,
		1053,
		{
			RTResTalkAction[43]
		},
		[20] = -1
	},
	[34719013] = {
		34719013,
		0,
		Lang.get(89709),
		34719,
		13,
		1052,
		{
			RTResTalkAction[154],
			RTResTalkAction[131]
		}
	},
	[34719014] = {
		34719014,
		5,
		Lang.get(21922),
		34719,
		14,
		nil,
		{
			RTResTalkAction[34],
			RTResTalkAction[31]
		},
		nil,
		nil,
		nil,
		1232,
		[22] = 1,
		[20] = 200
	},
	[34719015] = {
		34719015,
		0,
		Lang.get(89710),
		34719,
		15,
		1048,
		{
			RTResTalkAction[2]
		},
		[20] = -1
	},
	[34719016] = {
		34719016,
		0,
		Lang.get(89711),
		34719,
		16,
		1073,
		{
			RTResTalkAction[56],
			RTResTalkAction[6]
		}
	},
	[34719017] = {
		34719017,
		0,
		Lang.get(89712),
		34719,
		17,
		1050,
		{
			RTResTalkAction[136],
			RTResTalkAction[84]
		}
	},
	[34719018] = {
		34719018,
		0,
		Lang.get(89713),
		34719,
		18,
		1073,
		{
			RTResTalkAction[136],
			RTResTalkAction[84]
		}
	},
	[34719019] = {
		34719019,
		0,
		Lang.get(89714),
		34719,
		19,
		1050,
		{
			RTResTalkAction[136],
			RTResTalkAction[84]
		}
	},
	[34719020] = {
		34719020,
		0,
		Lang.get(89715),
		34719,
		20,
		1073,
		{
			RTResTalkAction[122],
			RTResTalkAction[75]
		}
	},
	[34719021] = {
		34719021,
		9,
		Lang.get(89716),
		34719,
		21,
		nil,
		{
			RTResTalkAction[57]
		},
		nil,
		nil,
		nil,
		1222,
		nil,
		34851,
		nil,
		1,
		nil,
		nil,
		nil,
		34851,
		255,
		nil,
		1
	},
	[34719022] = {
		34719022,
		0,
		Lang.get(89717),
		34719,
		22,
		300,
		nil,
		nil,
		nil,
		-1,
		[20] = -1
	},
	[34719023] = {
		34719023,
		0,
		Lang.get(89718),
		34719,
		23,
		1163,
		nil,
		1
	},
	[34719024] = {
		34719024,
		0,
		Lang.get(89719),
		34719,
		24,
		1048,
		nil,
		1,
		0
	},
	[34719025] = {
		34719025,
		0,
		Lang.get(89720),
		34719,
		25,
		1147,
		nil,
		1
	},
	[34719026] = {
		34719026,
		0,
		Lang.get(89721),
		34719,
		26,
		1146,
		nil,
		1
	},
	[34719027] = {
		34719027,
		0,
		"……|101|。",
		34719,
		27,
		1073,
		nil,
		1
	},
	[34719028] = {
		34719028,
		9,
		Lang.get(89722),
		34719,
		28,
		[22] = 1
	},
	[34719029] = {
		34719029,
		0,
		Lang.get(89723),
		34719,
		29,
		300
	},
	[34719030] = {
		34719030,
		9,
		"3，2，1……",
		34719,
		30,
		[22] = 1
	},
	[34719031] = {
		34719031,
		9,
		Lang.get(89724),
		34719,
		31,
		[22] = 1
	},
	[34719032] = {
		34719032,
		9,
		Lang.get(89725),
		34719,
		32,
		[22] = 1
	},
	[34720001] = {
		34720001,
		0,
		Lang.get(89119),
		34720,
		1,
		1167,
		nil,
		nil,
		nil,
		nil,
		nil,
		194,
		34855,
		[19] = 34855,
		[20] = 255
	},
	[34720002] = {
		34720002,
		0,
		Lang.get(89726),
		34720,
		2,
		300
	},
	[34720003] = {
		34720003,
		0,
		Lang.get(89727),
		34720,
		3,
		300
	},
	[34720004] = {
		34720004,
		0,
		Lang.get(89728),
		34720,
		4,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		34856,
		[19] = 34856,
		[20] = -1
	},
	[34720005] = {
		34720005,
		0,
		Lang.get(89729),
		34720,
		5,
		1167,
		nil,
		1,
		0,
		nil,
		nil,
		58
	},
	[34720006] = {
		34720006,
		0,
		Lang.get(89730),
		34720,
		6,
		300
	},
	[34720007] = {
		34720007,
		0,
		Lang.get(89124),
		34720,
		7,
		1167,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		34857,
		[19] = 34857
	},
	[34720008] = {
		34720008,
		4,
		nil,
		34720,
		8,
		300,
		[29] = {
			{
				id = 34720009,
				branch_content = Lang.get(89125)
			},
			{
				id = 34720009,
				branch_content = Lang.get(89126)
			}
		}
	},
	[34720009] = {
		34720009,
		0,
		Lang.get(89731),
		34720,
		9,
		1167,
		nil,
		1
	},
	[34720010] = {
		34720010,
		0,
		Lang.get(89732),
		34720,
		10,
		300
	},
	[34720011] = {
		34720011,
		0,
		Lang.get(89733),
		34720,
		11,
		1047,
		nil,
		1
	},
	[34720012] = {
		34720012,
		0,
		Lang.get(89734),
		34720,
		12,
		300
	},
	[34720013] = {
		34720013,
		0,
		Lang.get(89735),
		34720,
		13,
		1047,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		34858,
		[19] = 34858,
		[17] = 1
	},
	[34720014] = {
		34720014,
		0,
		Lang.get(89736),
		34720,
		14,
		300
	},
	[34720015] = {
		34720015,
		0,
		Lang.get(89737),
		34720,
		15,
		300
	},
	[34720016] = {
		34720016,
		0,
		Lang.get(89738),
		34720,
		16,
		1047,
		nil,
		1
	},
	[34720017] = {
		34720017,
		0,
		Lang.get(89739),
		34720,
		17,
		300
	},
	[34720018] = {
		34720018,
		0,
		Lang.get(89740),
		34720,
		18,
		1047,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		34859,
		[19] = 34859,
		[17] = 1
	},
	[34720019] = {
		34720019,
		0,
		"……",
		34720,
		19,
		1144,
		nil,
		1
	},
	[34720020] = {
		34720020,
		0,
		"……",
		34720,
		20,
		1145,
		nil,
		1
	},
	[34720021] = {
		34720021,
		0,
		Lang.get(89741),
		34720,
		21,
		300
	},
	[34720022] = {
		34720022,
		0,
		Lang.get(89742),
		34720,
		22,
		1047,
		nil,
		1,
		nil,
		nil,
		nil,
		196
	},
	[34720023] = {
		34720023,
		3,
		Lang.get(89743),
		34720,
		23,
		605,
		[22] = 1
	},
	[34720024] = {
		34720024,
		0,
		Lang.get(89744),
		34720,
		24,
		1145,
		{
			RTResTalkAction[155]
		},
		nil,
		nil,
		3
	},
	[34720025] = {
		34720025,
		0,
		Lang.get(89745),
		34720,
		25,
		1144,
		{
			RTResTalkAction[156],
			RTResTalkAction[157]
		}
	},
	[34720026] = {
		34720026,
		3,
		Lang.get(89746),
		34720,
		26,
		605,
		{
			RTResTalkAction[12],
			RTResTalkAction[11]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		34860,
		1,
		1,
		nil,
		nil,
		nil,
		34860,
		nil,
		nil,
		1
	},
	[34720027] = {
		34720027,
		3,
		Lang.get(89747),
		34720,
		27,
		605,
		[22] = 1
	},
	[34870001] = {
		34870001,
		3,
		nil,
		34870,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		34895,
		[19] = 34895,
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
