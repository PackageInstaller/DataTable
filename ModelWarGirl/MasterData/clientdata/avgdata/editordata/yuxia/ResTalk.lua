-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\yuxia\\ResTalk.lua

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
	[2] = 288
}
RTResTalkAction[2] = {
	[1] = 1,
	[2] = 133
}
RTResTalkAction[3] = {
	[1] = 0,
	[2] = 133
}
RTResTalkAction[4] = {
	[1] = 1,
	[2] = 141
}
RTResTalkAction[5] = {
	1,
	107,
	nil,
	nil,
	10
}
RTResTalkAction[6] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[7] = {
	1,
	107,
	nil,
	nil,
	3
}
RTResTalkAction[8] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[9] = {
	[1] = 3,
	[2] = 141
}
RTResTalkAction[10] = {
	[1] = 4,
	[2] = 107
}
RTResTalkAction[11] = {
	5,
	133,
	nil,
	nil,
	1
}
RTResTalkAction[12] = {
	4,
	107,
	nil,
	nil,
	1
}
RTResTalkAction[13] = {
	[1] = 5,
	[2] = 133
}
RTResTalkAction[14] = {
	1,
	141,
	nil,
	nil,
	0
}
RTResTalkAction[15] = {
	1,
	133,
	nil,
	nil,
	0
}
RTResTalkAction[16] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[17] = {
	1,
	107,
	nil,
	nil,
	2
}
RTResTalkAction[18] = {
	[1] = 1,
	[2] = 415
}
RTResTalkAction[19] = {
	2,
	133,
	nil,
	nil,
	1
}
RTResTalkAction[20] = {
	[1] = 3,
	[2] = 107
}
RTResTalkAction[21] = {
	[1] = 0,
	[2] = 415
}
RTResTalkAction[22] = {
	[1] = 2,
	[2] = 133
}
RTResTalkAction[23] = {
	3,
	107,
	nil,
	nil,
	5
}
RTResTalkAction[24] = {
	2,
	133,
	nil,
	nil,
	2
}
RTResTalkAction[25] = {
	[1] = 1,
	[2] = 216
}
RTResTalkAction[26] = {
	[1] = 2,
	[2] = 216
}
RTResTalkAction[27] = {
	3,
	133,
	nil,
	nil,
	2
}
RTResTalkAction[28] = {
	3,
	133,
	nil,
	nil,
	0
}
RTResTalkAction[29] = {
	3,
	107,
	nil,
	6,
	0
}
RTResTalkAction[30] = {
	1,
	133,
	nil,
	nil,
	2
}
RTResTalkAction[31] = {
	2,
	133,
	nil,
	nil,
	0
}
RTResTalkAction[32] = {
	3,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[33] = {
	[1] = 4,
	[2] = 133
}
RTResTalkAction[34] = {
	1,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[35] = {
	[1] = 5,
	[2] = 141
}
RTResTalkAction[36] = {
	1,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[37] = {
	4,
	133,
	nil,
	nil,
	1
}
RTResTalkAction[38] = {
	4,
	133,
	nil,
	nil,
	0
}
RTResTalkAction[39] = {
	1,
	107,
	nil,
	nil,
	4
}
RTResTalkAction[40] = {
	1,
	107,
	nil,
	nil,
	0
}
RTResTalkAction[41] = {
	[1] = 1,
	[2] = 292
}
RTResTalkAction[42] = {
	1,
	292,
	nil,
	nil,
	1
}
RTResTalkAction[43] = {
	1,
	292,
	nil,
	nil,
	0
}
RTResTalkAction[44] = {
	[1] = 3,
	[2] = 198
}
RTResTalkAction[45] = {
	2,
	216,
	nil,
	nil,
	3
}
RTResTalkAction[46] = {
	3,
	198,
	nil,
	nil,
	2
}
RTResTalkAction[47] = {
	3,
	198,
	nil,
	nil,
	0
}
RTResTalkAction[48] = {
	[1] = 2,
	[2] = 292
}
RTResTalkAction[49] = {
	[1] = 0,
	[2] = 216
}
RTResTalkAction[50] = {
	2,
	292,
	nil,
	nil,
	2
}
RTResTalkAction[51] = {
	[1] = 0,
	[2] = 198
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
	[2] = 216
}
RTResTalkAction[54] = {
	1,
	292,
	nil,
	nil,
	2
}
RTResTalkAction[55] = {
	3,
	216,
	nil,
	nil,
	3
}
RTResTalkAction[56] = {
	1,
	198,
	nil,
	nil,
	1
}
RTResTalkAction[57] = {
	[1] = 0,
	[2] = 292
}
RTResTalkAction[58] = {
	2,
	198,
	nil,
	nil,
	1
}
RTResTalkAction[59] = {
	2,
	198,
	nil,
	nil,
	0
}
RTResTalkAction[60] = {
	4,
	292,
	nil,
	nil,
	2
}
RTResTalkAction[61] = {
	1,
	198,
	nil,
	nil,
	0
}
RTResTalkAction[62] = {
	[1] = 5,
	[2] = 216
}
RTResTalkAction[63] = {
	[1] = 4,
	[2] = 292
}
RTResTalkAction[64] = {
	5,
	216,
	nil,
	nil,
	0
}
RTResTalkAction[65] = {
	1,
	198,
	nil,
	nil,
	2
}
RTResTalkAction[66] = {
	1,
	216,
	nil,
	nil,
	3
}
RTResTalkAction[67] = {
	[1] = 1,
	[2] = 123
}
RTResTalkAction[68] = {
	[1] = 0,
	[2] = 123
}
RTResTalkAction[69] = {
	[1] = 2,
	[2] = 664
}
RTResTalkAction[70] = {
	[1] = 3,
	[2] = 296
}
RTResTalkAction[71] = {
	[1] = 0,
	[2] = 664
}
RTResTalkAction[72] = {
	[1] = 0,
	[2] = 296
}
RTResTalkAction[73] = {
	[1] = 2,
	[2] = 123
}
RTResTalkAction[74] = {
	[1] = 3,
	[2] = 292
}
RTResTalkAction[75] = {
	[1] = 3,
	[2] = 123
}
RTResTalkAction[76] = {
	[1] = 1,
	[2] = 198
}
RTResTalkAction[77] = {
	2,
	216,
	nil,
	nil,
	1
}
RTResTalkAction[78] = {
	1,
	123,
	nil,
	nil,
	1
}
RTResTalkAction[79] = {
	3,
	292,
	nil,
	nil,
	1
}
RTResTalkAction[80] = {
	[1] = 3,
	[2] = 664
}
RTResTalkAction[81] = {
	3,
	292,
	nil,
	nil,
	0
}
RTResTalkAction[82] = {
	[1] = 2,
	[2] = 198
}
RTResTalkAction[83] = {
	[1] = 4,
	[2] = 198
}
RTResTalkAction[84] = {
	1,
	216,
	nil,
	nil,
	0
}
RTResTalkAction[85] = {
	5,
	292,
	nil,
	nil,
	2
}
RTResTalkAction[86] = {
	1,
	123,
	nil,
	nil,
	0
}
RTResTalkAction[87] = {
	3,
	292,
	nil,
	nil,
	2
}
RTResTalkAction[88] = {
	[1] = 2,
	[2] = 295
}
RTResTalkAction[89] = {
	[1] = 0,
	[2] = 295
}
RTResTalkAction[90] = {
	[1] = 2,
	[2] = 294
}
RTResTalkAction[91] = {
	[1] = 1,
	[2] = 295
}
RTResTalkAction[92] = {
	[1] = 1,
	[2] = 294
}
RTResTalkAction[93] = {
	[1] = 0,
	[2] = 294
}
RTResTalkAction[94] = {
	[1] = 1,
	[2] = 293
}
RTResTalkAction[95] = {
	[1] = 0,
	[2] = 293
}
RTResTalkAction[96] = {
	[1] = 1,
	[2] = 296
}
RTResTalkAction[97] = {
	[1] = 1,
	[2] = 386
}
RTResTalkAction[98] = {
	[1] = 1,
	[2] = 158
}
RTResTalkAction[99] = {
	[1] = 0,
	[2] = 386
}
RTResTalkAction[100] = {
	[1] = 0,
	[2] = 158
}
RTResTalkAction[101] = {
	[1] = 3,
	[2] = 293
}
RTResTalkAction[102] = {
	[1] = 2,
	[2] = 141
}
RTResTalkAction[103] = {
	2,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[104] = {
	2,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[105] = {
	2,
	107,
	nil,
	nil,
	0
}
RTResTalkAction[106] = {
	3,
	198,
	nil,
	nil,
	3
}
RTResTalkAction[107] = {
	[1] = 1,
	[2] = 289
}
RTResTalkAction[108] = {
	[1] = 0,
	[2] = 289
}
RTResTalkAction[109] = {
	1,
	292,
	nil,
	nil,
	3
}

local Data = {
	[29500001] = {
		29500001,
		0,
		Lang.get(72531),
		29500,
		1,
		288,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		nil,
		nil,
		62,
		29500,
		[19] = 29500
	},
	[29500002] = {
		29500002,
		0,
		Lang.get(72532),
		29500,
		2,
		288,
		{
			RTResTalkAction[1]
		}
	},
	[29500003] = {
		29500003,
		0,
		Lang.get(72533),
		29500,
		3,
		288,
		{
			RTResTalkAction[1]
		}
	},
	[29500004] = {
		29500004,
		0,
		Lang.get(72534),
		29500,
		4,
		288,
		{
			RTResTalkAction[1]
		}
	},
	[29500005] = {
		29500005,
		0,
		Lang.get(72535),
		29500,
		5,
		288,
		{
			RTResTalkAction[1]
		}
	},
	[29501001] = {
		29501001,
		3,
		Lang.get(72536),
		29501,
		1,
		288,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		29501,
		[19] = 29501,
		[22] = 1
	},
	[29501002] = {
		29501002,
		0,
		Lang.get(72537),
		29501,
		2,
		107,
		nil,
		1
	},
	[29501003] = {
		29501003,
		0,
		Lang.get(72538),
		29501,
		3,
		300
	},
	[29501004] = {
		29501004,
		0,
		Lang.get(72539),
		29501,
		4,
		107,
		nil,
		1
	},
	[29501005] = {
		29501005,
		0,
		Lang.get(72540),
		29501,
		5,
		133,
		nil,
		1
	},
	[29501006] = {
		29501006,
		0,
		Lang.get(72541),
		29501,
		6,
		141,
		nil,
		1
	},
	[29501007] = {
		29501007,
		0,
		Lang.get(72542),
		29501,
		7,
		107,
		nil,
		1
	},
	[29501008] = {
		29501008,
		0,
		Lang.get(72543),
		29501,
		8,
		133,
		nil,
		1
	},
	[29501009] = {
		29501009,
		0,
		Lang.get(72544),
		29501,
		9,
		141,
		nil,
		1
	},
	[29501010] = {
		29501010,
		0,
		Lang.get(72545),
		29501,
		10,
		300
	},
	[29501011] = {
		29501011,
		2,
		Lang.get(72546),
		29501,
		11,
		300
	},
	[29501012] = {
		29501012,
		2,
		Lang.get(72547),
		29501,
		12,
		300
	},
	[29501013] = {
		29501013,
		0,
		Lang.get(73541),
		29501,
		13,
		133,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[29501014] = {
		29501014,
		0,
		Lang.get(72549),
		29501,
		14,
		300,
		{
			RTResTalkAction[3]
		}
	},
	[29501015] = {
		29501015,
		0,
		Lang.get(72550),
		29501,
		15,
		141,
		{
			RTResTalkAction[4]
		}
	},
	[29501016] = {
		29501016,
		0,
		Lang.get(72551),
		29501,
		16,
		107,
		{
			RTResTalkAction[5],
			RTResTalkAction[6]
		}
	},
	[29502001] = {
		29502001,
		0,
		Lang.get(73542),
		29502,
		1,
		141,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		29502,
		nil,
		nil,
		nil,
		nil,
		nil,
		29502
	},
	[29502002] = {
		29502002,
		0,
		Lang.get(72553),
		29502,
		2,
		133,
		nil,
		1
	},
	[29502003] = {
		29502003,
		0,
		Lang.get(72554),
		29502,
		3,
		141,
		nil,
		1
	},
	[29502004] = {
		29502004,
		0,
		Lang.get(72555),
		29502,
		4,
		107,
		nil,
		1,
		8
	},
	[29502005] = {
		29502005,
		0,
		Lang.get(72556),
		29502,
		5,
		141,
		nil,
		1,
		0
	},
	[29502006] = {
		29502006,
		0,
		Lang.get(72557),
		29502,
		6,
		107,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3
	},
	[29502007] = {
		29502007,
		0,
		Lang.get(72558),
		29502,
		7,
		141,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[29502008] = {
		29502008,
		0,
		Lang.get(72559),
		29502,
		8,
		133,
		{
			RTResTalkAction[10],
			RTResTalkAction[4],
			RTResTalkAction[11]
		}
	},
	[29502009] = {
		29502009,
		0,
		Lang.get(72560),
		29502,
		9,
		107,
		{
			RTResTalkAction[12],
			RTResTalkAction[4],
			RTResTalkAction[13]
		}
	},
	[29502010] = {
		29502010,
		0,
		Lang.get(72561),
		29502,
		10,
		141,
		{
			RTResTalkAction[10],
			RTResTalkAction[14],
			RTResTalkAction[13]
		}
	},
	[29502011] = {
		29502011,
		0,
		Lang.get(72562),
		29502,
		11,
		133,
		{
			RTResTalkAction[15],
			RTResTalkAction[16],
			RTResTalkAction[6]
		}
	},
	[29502012] = {
		29502012,
		0,
		Lang.get(72563),
		29502,
		12,
		133,
		{
			RTResTalkAction[2]
		}
	},
	[29502013] = {
		29502013,
		0,
		Lang.get(72564),
		29502,
		13,
		107,
		{
			RTResTalkAction[17],
			RTResTalkAction[3]
		}
	},
	[29502014] = {
		29502014,
		0,
		Lang.get(72565),
		29502,
		14,
		141,
		{
			RTResTalkAction[18],
			RTResTalkAction[16]
		},
		1,
		0,
		[21] = 415
	},
	[29502015] = {
		29502015,
		0,
		Lang.get(72566),
		29502,
		15,
		107,
		{
			RTResTalkAction[18]
		},
		1,
		8,
		[21] = 415
	},
	[29502016] = {
		29502016,
		0,
		Lang.get(72567),
		29502,
		16,
		107,
		{
			RTResTalkAction[18]
		},
		1,
		8,
		[21] = 415
	},
	[29502017] = {
		29502017,
		0,
		Lang.get(72568),
		29502,
		17,
		141,
		{
			RTResTalkAction[18]
		},
		1,
		0,
		[21] = 415
	},
	[29502018] = {
		29502018,
		0,
		Lang.get(72569),
		29502,
		18,
		107,
		{
			RTResTalkAction[18]
		},
		1,
		8,
		[21] = 415
	},
	[29502019] = {
		29502019,
		0,
		Lang.get(72570),
		29502,
		19,
		133,
		{
			RTResTalkAction[19],
			RTResTalkAction[20],
			RTResTalkAction[21]
		},
		nil,
		0
	},
	[29502020] = {
		29502020,
		0,
		Lang.get(72571),
		29502,
		20,
		107,
		{
			RTResTalkAction[22],
			RTResTalkAction[23]
		}
	},
	[29502021] = {
		29502021,
		0,
		Lang.get(72572),
		29502,
		21,
		133,
		{
			RTResTalkAction[19],
			RTResTalkAction[20]
		}
	},
	[29502022] = {
		29502022,
		0,
		Lang.get(72573),
		29502,
		22,
		133,
		{
			RTResTalkAction[24],
			RTResTalkAction[20]
		}
	},
	[29502023] = {
		29502023,
		5,
		Lang.get(72574),
		29502,
		23,
		605,
		{
			RTResTalkAction[3],
			RTResTalkAction[16]
		},
		[22] = 1
	},
	[29502024] = {
		29502024,
		0,
		Lang.get(72575),
		29502,
		24,
		141,
		{
			RTResTalkAction[4]
		}
	},
	[29502025] = {
		29502025,
		0,
		Lang.get(72576),
		29502,
		25,
		216,
		{
			RTResTalkAction[25],
			RTResTalkAction[6]
		}
	},
	[29502026] = {
		29502026,
		0,
		Lang.get(72577),
		29502,
		26,
		133,
		{
			RTResTalkAction[26],
			RTResTalkAction[27]
		}
	},
	[29502027] = {
		29502027,
		0,
		Lang.get(72578),
		29502,
		27,
		216,
		{
			RTResTalkAction[26],
			RTResTalkAction[28]
		}
	},
	[29502028] = {
		29502028,
		0,
		Lang.get(72579),
		29502,
		28,
		107,
		{
			RTResTalkAction[26],
			RTResTalkAction[29],
			RTResTalkAction[3]
		}
	},
	[29502029] = {
		29502029,
		0,
		Lang.get(72580),
		29502,
		29,
		216,
		{
			RTResTalkAction[25],
			RTResTalkAction[16]
		}
	},
	[29503001] = {
		29503001,
		0,
		Lang.get(72581),
		29503,
		1,
		107,
		nil,
		1,
		8,
		nil,
		nil,
		62,
		29503,
		nil,
		nil,
		nil,
		nil,
		nil,
		29503
	},
	[29503002] = {
		29503002,
		0,
		Lang.get(72582),
		29503,
		2,
		133,
		nil,
		1,
		1
	},
	[29503003] = {
		29503003,
		0,
		Lang.get(72583),
		29503,
		3,
		107,
		nil,
		1,
		8
	},
	[29503004] = {
		29503004,
		0,
		Lang.get(72584),
		29503,
		4,
		133,
		nil,
		1,
		1
	},
	[29503005] = {
		29503005,
		0,
		Lang.get(72585),
		29503,
		5,
		141,
		nil,
		1,
		0
	},
	[29503006] = {
		29503006,
		0,
		Lang.get(73543),
		29503,
		6,
		133,
		{
			RTResTalkAction[15]
		},
		nil,
		nil,
		3
	},
	[29503007] = {
		29503007,
		0,
		Lang.get(72587),
		29503,
		7,
		133,
		{
			RTResTalkAction[30]
		}
	},
	[29503008] = {
		29503008,
		0,
		Lang.get(72588),
		29503,
		8,
		107,
		{
			RTResTalkAction[31],
			RTResTalkAction[32]
		}
	},
	[29503009] = {
		29503009,
		0,
		Lang.get(72589),
		29503,
		9,
		141,
		{
			RTResTalkAction[33],
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[29503010] = {
		29503010,
		0,
		Lang.get(72590),
		29503,
		10,
		107,
		{
			RTResTalkAction[33],
			RTResTalkAction[36],
			RTResTalkAction[35]
		}
	},
	[29503011] = {
		29503011,
		0,
		Lang.get(72591),
		29503,
		11,
		133,
		{
			RTResTalkAction[37],
			RTResTalkAction[36],
			RTResTalkAction[35]
		}
	},
	[29503012] = {
		29503012,
		0,
		Lang.get(72592),
		29503,
		12,
		141,
		{
			RTResTalkAction[38],
			RTResTalkAction[36],
			RTResTalkAction[35]
		}
	},
	[29503013] = {
		29503013,
		0,
		Lang.get(72593),
		29503,
		13,
		107,
		{
			RTResTalkAction[33],
			RTResTalkAction[7],
			RTResTalkAction[35]
		}
	},
	[29503014] = {
		29503014,
		0,
		Lang.get(72594),
		29503,
		14,
		107,
		{
			RTResTalkAction[33],
			RTResTalkAction[39],
			RTResTalkAction[35]
		}
	},
	[29503015] = {
		29503015,
		0,
		Lang.get(72595),
		29503,
		15,
		133,
		{
			RTResTalkAction[33],
			RTResTalkAction[40],
			RTResTalkAction[35]
		}
	},
	[29504001] = {
		29504001,
		0,
		Lang.get(72596),
		29504,
		1,
		216,
		nil,
		1,
		3,
		nil,
		nil,
		62,
		29504,
		nil,
		nil,
		nil,
		nil,
		nil,
		29504
	},
	[29504002] = {
		29504002,
		0,
		Lang.get(72597),
		29504,
		2,
		292,
		nil,
		1,
		1
	},
	[29504003] = {
		29504003,
		7,
		"84",
		29504,
		3,
		292
	},
	[29504004] = {
		29504004,
		0,
		Lang.get(72598),
		29504,
		4,
		216,
		nil,
		1,
		0
	},
	[29504005] = {
		29504005,
		0,
		Lang.get(72599),
		29504,
		5,
		198,
		nil,
		1
	},
	[29504006] = {
		29504006,
		0,
		Lang.get(72600),
		29504,
		6,
		292,
		{
			RTResTalkAction[41]
		},
		nil,
		nil,
		3
	},
	[29504007] = {
		29504007,
		0,
		Lang.get(72601),
		29504,
		7,
		292,
		{
			RTResTalkAction[42]
		}
	},
	[29504008] = {
		29504008,
		0,
		Lang.get(72602),
		29504,
		8,
		292,
		{
			RTResTalkAction[43]
		}
	},
	[29505001] = {
		29505001,
		0,
		Lang.get(72603),
		29505,
		1,
		292,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		29505,
		nil,
		nil,
		nil,
		nil,
		nil,
		29505
	},
	[29505002] = {
		29505002,
		0,
		Lang.get(72604),
		29505,
		2,
		216,
		nil,
		1
	},
	[29505003] = {
		29505003,
		0,
		Lang.get(72605),
		29505,
		3,
		198,
		nil,
		1,
		2
	},
	[29505004] = {
		29505004,
		0,
		Lang.get(72606),
		29505,
		4,
		292,
		nil,
		1,
		2
	},
	[29505005] = {
		29505005,
		0,
		Lang.get(72607),
		29505,
		5,
		216,
		{
			RTResTalkAction[25]
		},
		nil,
		0,
		3
	},
	[29505006] = {
		29505006,
		0,
		Lang.get(72608),
		29505,
		6,
		198,
		{
			RTResTalkAction[26],
			RTResTalkAction[44]
		}
	},
	[29505007] = {
		29505007,
		0,
		Lang.get(72609),
		29505,
		7,
		216,
		{
			RTResTalkAction[45],
			RTResTalkAction[44]
		}
	},
	[29505008] = {
		29505008,
		0,
		Lang.get(72610),
		29505,
		8,
		198,
		{
			RTResTalkAction[45],
			RTResTalkAction[46]
		}
	},
	[29505009] = {
		29505009,
		0,
		Lang.get(72611),
		29505,
		9,
		216,
		{
			RTResTalkAction[45],
			RTResTalkAction[47]
		}
	},
	[29505010] = {
		29505010,
		0,
		Lang.get(72612),
		29505,
		10,
		198,
		{
			RTResTalkAction[45],
			RTResTalkAction[46]
		}
	},
	[29505011] = {
		29505011,
		0,
		Lang.get(72613),
		29505,
		11,
		216,
		{
			RTResTalkAction[45],
			RTResTalkAction[47]
		}
	},
	[29505012] = {
		29505012,
		0,
		Lang.get(72614),
		29505,
		12,
		292,
		{
			RTResTalkAction[48],
			RTResTalkAction[44],
			RTResTalkAction[49]
		}
	},
	[29505013] = {
		29505013,
		0,
		Lang.get(72615),
		29505,
		13,
		198,
		{
			RTResTalkAction[48],
			RTResTalkAction[44]
		}
	},
	[29505014] = {
		29505014,
		0,
		Lang.get(72616),
		29505,
		14,
		292,
		{
			RTResTalkAction[50],
			RTResTalkAction[44]
		}
	},
	[29505015] = {
		29505015,
		0,
		Lang.get(72617),
		29505,
		15,
		198,
		{
			RTResTalkAction[48],
			RTResTalkAction[44]
		}
	},
	[29505016] = {
		29505016,
		0,
		Lang.get(72618),
		29505,
		16,
		292,
		{
			RTResTalkAction[43],
			RTResTalkAction[51]
		}
	},
	[29505017] = {
		29505017,
		0,
		Lang.get(72619),
		29505,
		17,
		292,
		{
			RTResTalkAction[43]
		}
	},
	[29505018] = {
		29505018,
		0,
		Lang.get(72620),
		29505,
		18,
		216,
		{
			RTResTalkAction[52],
			RTResTalkAction[53]
		}
	},
	[29505019] = {
		29505019,
		0,
		Lang.get(72621),
		29505,
		19,
		292,
		{
			RTResTalkAction[54],
			RTResTalkAction[49]
		}
	},
	[29505020] = {
		29505020,
		0,
		Lang.get(72622),
		29505,
		20,
		216,
		{
			RTResTalkAction[50],
			RTResTalkAction[55]
		}
	},
	[29505021] = {
		29505021,
		0,
		Lang.get(72623),
		29505,
		21,
		292,
		{
			RTResTalkAction[43],
			RTResTalkAction[49]
		}
	},
	[29505022] = {
		29505022,
		0,
		Lang.get(72624),
		29505,
		22,
		292,
		{
			RTResTalkAction[43]
		}
	},
	[29505023] = {
		29505023,
		0,
		Lang.get(72625),
		29505,
		23,
		198,
		{
			RTResTalkAction[56],
			RTResTalkAction[57]
		}
	},
	[29505024] = {
		29505024,
		0,
		Lang.get(72626),
		29505,
		24,
		198,
		{
			RTResTalkAction[56]
		}
	},
	[29505025] = {
		29505025,
		0,
		Lang.get(72627),
		29505,
		25,
		216,
		{
			RTResTalkAction[58],
			RTResTalkAction[55]
		}
	},
	[29505026] = {
		29505026,
		0,
		Lang.get(72628),
		29505,
		26,
		198,
		{
			RTResTalkAction[59],
			RTResTalkAction[53]
		}
	},
	[29505027] = {
		29505027,
		0,
		Lang.get(72629),
		29505,
		27,
		292,
		{
			RTResTalkAction[60],
			RTResTalkAction[61],
			RTResTalkAction[62]
		}
	},
	[29505028] = {
		29505028,
		0,
		Lang.get(72630),
		29505,
		28,
		216,
		{
			RTResTalkAction[63],
			RTResTalkAction[61],
			RTResTalkAction[64]
		}
	},
	[29505029] = {
		29505029,
		0,
		Lang.get(72631),
		29505,
		29,
		292,
		{
			RTResTalkAction[60],
			RTResTalkAction[61],
			RTResTalkAction[62]
		}
	},
	[29505030] = {
		29505030,
		0,
		Lang.get(72632),
		29505,
		30,
		198,
		{
			RTResTalkAction[63],
			RTResTalkAction[65],
			RTResTalkAction[62]
		}
	},
	[29506001] = {
		29506001,
		0,
		Lang.get(72633),
		29506,
		1,
		216,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		29506,
		nil,
		nil,
		nil,
		nil,
		nil,
		29506
	},
	[29506002] = {
		29506002,
		0,
		Lang.get(72634),
		29506,
		2,
		216,
		nil,
		1
	},
	[29506003] = {
		29506003,
		4,
		nil,
		29506,
		3,
		216,
		nil,
		1,
		[29] = {
			{
				id = 29506004,
				branch_content = Lang.get(72635)
			},
			{
				id = 29506004,
				branch_content = Lang.get(72636)
			}
		}
	},
	[29506004] = {
		29506004,
		5,
		Lang.get(72637),
		29506,
		4,
		216,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		29536,
		[19] = 29536
	},
	[29506005] = {
		29506005,
		0,
		Lang.get(72638),
		29506,
		5,
		300
	},
	[29506006] = {
		29506006,
		0,
		Lang.get(72639),
		29506,
		6,
		300
	},
	[29506007] = {
		29506007,
		0,
		Lang.get(72640),
		29506,
		7,
		216,
		{
			RTResTalkAction[25]
		},
		nil,
		nil,
		3
	},
	[29506008] = {
		29506008,
		4,
		nil,
		29506,
		8,
		216,
		{
			RTResTalkAction[25]
		},
		[29] = {
			{
				id = 29506009,
				branch_content = Lang.get(72641)
			},
			{
				id = 29506009,
				branch_content = Lang.get(72642)
			}
		}
	},
	[29506009] = {
		29506009,
		0,
		Lang.get(72643),
		29506,
		9,
		216,
		{
			RTResTalkAction[25]
		}
	},
	[29506010] = {
		29506010,
		0,
		Lang.get(72644),
		29506,
		10,
		300,
		{
			RTResTalkAction[25]
		}
	},
	[29506011] = {
		29506011,
		0,
		Lang.get(72645),
		29506,
		11,
		216,
		{
			RTResTalkAction[25]
		}
	},
	[29506012] = {
		29506012,
		0,
		Lang.get(72646),
		29506,
		12,
		216,
		{
			RTResTalkAction[25]
		}
	},
	[29506013] = {
		29506013,
		0,
		Lang.get(72647),
		29506,
		13,
		300,
		{
			RTResTalkAction[25]
		}
	},
	[29506014] = {
		29506014,
		2,
		Lang.get(73544),
		29506,
		14,
		216,
		{
			RTResTalkAction[66]
		}
	},
	[29506015] = {
		29506015,
		2,
		Lang.get(72649),
		29506,
		15,
		216,
		{
			RTResTalkAction[66]
		}
	},
	[29506016] = {
		29506016,
		0,
		Lang.get(72650),
		29506,
		16,
		300,
		{
			RTResTalkAction[25]
		}
	},
	[29506017] = {
		29506017,
		0,
		Lang.get(72651),
		29506,
		17,
		216,
		{
			RTResTalkAction[66]
		}
	},
	[29507001] = {
		29507001,
		0,
		Lang.get(72652),
		29507,
		1,
		664,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		29507,
		nil,
		nil,
		nil,
		nil,
		nil,
		29507
	},
	[29507002] = {
		29507002,
		0,
		Lang.get(72653),
		29507,
		2,
		296,
		{
			RTResTalkAction[18]
		},
		1,
		[21] = 415
	},
	[29507003] = {
		29507003,
		0,
		Lang.get(72654),
		29507,
		3,
		664,
		{
			RTResTalkAction[18]
		},
		1,
		[21] = 415
	},
	[29507004] = {
		29507004,
		0,
		Lang.get(72655),
		29507,
		4,
		296,
		{
			RTResTalkAction[21]
		},
		1
	},
	[29508001] = {
		29508001,
		5,
		Lang.get(72656),
		29508,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		29508,
		[19] = 29508,
		[22] = 1
	},
	[29508002] = {
		29508002,
		0,
		Lang.get(72657),
		29508,
		2,
		123,
		nil,
		1
	},
	[29508003] = {
		29508003,
		0,
		Lang.get(72658),
		29508,
		3,
		664,
		nil,
		1
	},
	[29508004] = {
		29508004,
		0,
		Lang.get(72659),
		29508,
		4,
		296,
		nil,
		1
	},
	[29508005] = {
		29508005,
		0,
		Lang.get(72660),
		29508,
		5,
		123,
		{
			RTResTalkAction[67]
		},
		nil,
		nil,
		3
	},
	[29508006] = {
		29508006,
		0,
		Lang.get(72661),
		29508,
		6,
		292,
		{
			RTResTalkAction[41],
			RTResTalkAction[68]
		}
	},
	[29508007] = {
		29508007,
		0,
		Lang.get(72662),
		29508,
		7,
		664,
		{
			RTResTalkAction[69],
			RTResTalkAction[70],
			RTResTalkAction[57]
		}
	},
	[29508008] = {
		29508008,
		0,
		Lang.get(72663),
		29508,
		8,
		296,
		{
			RTResTalkAction[69],
			RTResTalkAction[70]
		}
	},
	[29508009] = {
		29508009,
		0,
		Lang.get(72664),
		29508,
		9,
		664,
		{
			RTResTalkAction[69],
			RTResTalkAction[70]
		}
	},
	[29508010] = {
		29508010,
		0,
		Lang.get(72665),
		29508,
		10,
		123,
		{
			RTResTalkAction[67],
			RTResTalkAction[71],
			RTResTalkAction[72]
		}
	},
	[29509001] = {
		29509001,
		0,
		Lang.get(72666),
		29509,
		1,
		292,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		29508,
		nil,
		nil,
		nil,
		nil,
		nil,
		29508
	},
	[29509002] = {
		29509002,
		0,
		Lang.get(72667),
		29509,
		2,
		292,
		nil,
		1
	},
	[29509003] = {
		29509003,
		0,
		Lang.get(72668),
		29509,
		3,
		123,
		nil,
		1
	},
	[29509004] = {
		29509004,
		0,
		Lang.get(72669),
		29509,
		4,
		292,
		nil,
		1
	},
	[29509005] = {
		29509005,
		0,
		Lang.get(72670),
		29509,
		5,
		123,
		{
			RTResTalkAction[73],
			RTResTalkAction[74]
		},
		nil,
		nil,
		3
	},
	[29509006] = {
		29509006,
		0,
		Lang.get(72671),
		29509,
		6,
		123,
		{
			RTResTalkAction[73],
			RTResTalkAction[74]
		}
	},
	[29509007] = {
		29509007,
		0,
		Lang.get(72672),
		29509,
		7,
		292,
		{
			RTResTalkAction[73],
			RTResTalkAction[74]
		}
	},
	[29509008] = {
		29509008,
		0,
		Lang.get(72673),
		29509,
		8,
		292,
		{
			RTResTalkAction[73],
			RTResTalkAction[74]
		}
	},
	[29509009] = {
		29509009,
		0,
		Lang.get(72674),
		29509,
		9,
		123,
		{
			RTResTalkAction[73],
			RTResTalkAction[74]
		}
	},
	[29509010] = {
		29509010,
		0,
		Lang.get(72675),
		29509,
		10,
		292,
		{
			RTResTalkAction[73],
			RTResTalkAction[74]
		}
	},
	[29509011] = {
		29509011,
		0,
		Lang.get(72676),
		29509,
		11,
		123,
		{
			RTResTalkAction[73],
			RTResTalkAction[74]
		}
	},
	[29509012] = {
		29509012,
		0,
		Lang.get(72677),
		29509,
		12,
		292,
		{
			RTResTalkAction[73],
			RTResTalkAction[74]
		}
	},
	[29509013] = {
		29509013,
		0,
		Lang.get(72678),
		29509,
		13,
		123,
		{
			RTResTalkAction[73],
			RTResTalkAction[74]
		}
	},
	[29509014] = {
		29509014,
		5,
		Lang.get(72679),
		29509,
		14,
		216,
		{
			RTResTalkAction[26],
			RTResTalkAction[44],
			RTResTalkAction[68],
			RTResTalkAction[57]
		}
	},
	[29509015] = {
		29509015,
		0,
		Lang.get(72680),
		29509,
		15,
		198,
		{
			RTResTalkAction[26],
			RTResTalkAction[44]
		}
	},
	[29509016] = {
		29509016,
		0,
		Lang.get(72681),
		29509,
		16,
		292,
		{
			RTResTalkAction[42],
			RTResTalkAction[49],
			RTResTalkAction[51]
		}
	},
	[29509017] = {
		29509017,
		5,
		Lang.get(72682),
		29509,
		17,
		292,
		{
			RTResTalkAction[42]
		}
	},
	[29510001] = {
		29510001,
		0,
		Lang.get(72683),
		29510,
		1,
		123,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		29511,
		nil,
		nil,
		nil,
		nil,
		nil,
		29511
	},
	[29510002] = {
		29510002,
		0,
		Lang.get(72684),
		29510,
		2,
		123,
		nil,
		1
	},
	[29511001] = {
		29511001,
		0,
		Lang.get(72685),
		29511,
		1,
		216,
		nil,
		1,
		3,
		nil,
		nil,
		62,
		29511,
		nil,
		nil,
		nil,
		nil,
		nil,
		29511
	},
	[29511002] = {
		29511002,
		0,
		Lang.get(72686),
		29511,
		2,
		198,
		nil,
		1,
		3
	},
	[29511003] = {
		29511003,
		0,
		Lang.get(72687),
		29511,
		3,
		123,
		nil,
		1,
		0
	},
	[29511004] = {
		29511004,
		0,
		Lang.get(72688),
		29511,
		4,
		292,
		nil,
		1,
		1
	},
	[29511005] = {
		29511005,
		0,
		Lang.get(72689),
		29511,
		5,
		292,
		{
			RTResTalkAction[48],
			RTResTalkAction[75]
		},
		nil,
		nil,
		3
	},
	[29511006] = {
		29511006,
		0,
		Lang.get(72690),
		29511,
		6,
		123,
		{
			RTResTalkAction[48],
			RTResTalkAction[75]
		}
	},
	[29511007] = {
		29511007,
		0,
		Lang.get(72691),
		29511,
		7,
		292,
		{
			RTResTalkAction[48],
			RTResTalkAction[75]
		}
	},
	[29511008] = {
		29511008,
		0,
		Lang.get(72692),
		29511,
		8,
		123,
		{
			RTResTalkAction[48],
			RTResTalkAction[75]
		}
	},
	[29511009] = {
		29511009,
		0,
		Lang.get(72693),
		29511,
		9,
		292,
		{
			RTResTalkAction[48],
			RTResTalkAction[75]
		}
	},
	[29511010] = {
		29511010,
		0,
		Lang.get(72694),
		29511,
		10,
		123,
		{
			RTResTalkAction[48],
			RTResTalkAction[75]
		}
	},
	[29511011] = {
		29511011,
		0,
		Lang.get(72695),
		29511,
		11,
		292,
		{
			RTResTalkAction[48],
			RTResTalkAction[75]
		}
	},
	[29511012] = {
		29511012,
		0,
		Lang.get(72696),
		29511,
		12,
		123,
		{
			RTResTalkAction[48],
			RTResTalkAction[75]
		}
	},
	[29511013] = {
		29511013,
		0,
		Lang.get(72697),
		29511,
		13,
		292,
		{
			RTResTalkAction[48],
			RTResTalkAction[75]
		}
	},
	[29511014] = {
		29511014,
		0,
		Lang.get(42599),
		29511,
		14,
		198,
		{
			RTResTalkAction[76],
			RTResTalkAction[57],
			RTResTalkAction[68]
		}
	},
	[29511015] = {
		29511015,
		3,
		Lang.get(72698),
		29511,
		15,
		605,
		{
			RTResTalkAction[51]
		},
		[22] = 1
	},
	[29511016] = {
		29511016,
		5,
		Lang.get(72699),
		29511,
		16,
		216,
		{
			RTResTalkAction[25]
		}
	},
	[29511017] = {
		29511017,
		0,
		Lang.get(72700),
		29511,
		17,
		292,
		{
			RTResTalkAction[77],
			RTResTalkAction[74]
		}
	},
	[29511018] = {
		29511018,
		0,
		Lang.get(72701),
		29511,
		18,
		123,
		{
			RTResTalkAction[78],
			RTResTalkAction[49],
			RTResTalkAction[57]
		}
	},
	[29511019] = {
		29511019,
		0,
		Lang.get(72702),
		29511,
		19,
		123,
		{
			RTResTalkAction[67]
		}
	},
	[29512001] = {
		29512001,
		0,
		Lang.get(72703),
		29512,
		1,
		216,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		29511,
		nil,
		nil,
		nil,
		nil,
		nil,
		29511
	},
	[29512002] = {
		29512002,
		0,
		Lang.get(72704),
		29512,
		2,
		292,
		nil,
		1
	},
	[29512003] = {
		29512003,
		0,
		Lang.get(72705),
		29512,
		3,
		198,
		nil,
		1
	},
	[29512004] = {
		29512004,
		0,
		Lang.get(72706),
		29512,
		4,
		198,
		nil,
		1
	},
	[29512005] = {
		29512005,
		0,
		Lang.get(72707),
		29512,
		5,
		123,
		{
			RTResTalkAction[67]
		},
		nil,
		nil,
		3
	},
	[29512006] = {
		29512006,
		0,
		Lang.get(72708),
		29512,
		6,
		292,
		{
			RTResTalkAction[73],
			RTResTalkAction[74]
		}
	},
	[29512007] = {
		29512007,
		0,
		Lang.get(72709),
		29512,
		7,
		123,
		{
			RTResTalkAction[73],
			RTResTalkAction[74]
		}
	},
	[29512008] = {
		29512008,
		0,
		Lang.get(72710),
		29512,
		8,
		292,
		{
			RTResTalkAction[73],
			RTResTalkAction[79]
		}
	},
	[29512009] = {
		29512009,
		0,
		Lang.get(72711),
		29512,
		9,
		123,
		{
			RTResTalkAction[67],
			RTResTalkAction[57]
		}
	},
	[29512010] = {
		29512010,
		0,
		Lang.get(72712),
		29512,
		10,
		198,
		{
			RTResTalkAction[76],
			RTResTalkAction[68]
		}
	},
	[29512011] = {
		29512011,
		0,
		Lang.get(72713),
		29512,
		11,
		123,
		{
			RTResTalkAction[67],
			RTResTalkAction[51]
		}
	},
	[29512012] = {
		29512012,
		0,
		Lang.get(72714),
		29512,
		12,
		123,
		{
			RTResTalkAction[67]
		}
	},
	[29512013] = {
		29512013,
		0,
		Lang.get(72715),
		29512,
		13,
		292,
		{
			RTResTalkAction[43],
			RTResTalkAction[68]
		}
	},
	[29512014] = {
		29512014,
		0,
		Lang.get(72716),
		29512,
		14,
		123,
		{
			RTResTalkAction[67],
			RTResTalkAction[57]
		}
	},
	[29512015] = {
		29512015,
		0,
		Lang.get(72717),
		29512,
		15,
		664,
		{
			RTResTalkAction[73],
			RTResTalkAction[80]
		}
	},
	[29513001] = {
		29513001,
		0,
		Lang.get(72718),
		29513,
		1,
		123,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		29511,
		nil,
		nil,
		nil,
		nil,
		nil,
		29511
	},
	[29513002] = {
		29513002,
		0,
		Lang.get(72719),
		29513,
		2,
		300
	},
	[29513003] = {
		29513003,
		0,
		Lang.get(72720),
		29513,
		3,
		216,
		nil,
		1
	},
	[29513004] = {
		29513004,
		0,
		Lang.get(72721),
		29513,
		4,
		292,
		nil,
		1
	},
	[29513005] = {
		29513005,
		0,
		Lang.get(72722),
		29513,
		5,
		292,
		{
			RTResTalkAction[41]
		},
		nil,
		nil,
		3
	},
	[29513006] = {
		29513006,
		0,
		Lang.get(72723),
		29513,
		6,
		292,
		{
			RTResTalkAction[41]
		}
	},
	[29513007] = {
		29513007,
		0,
		Lang.get(72724),
		29513,
		7,
		300,
		{
			RTResTalkAction[57]
		}
	},
	[29513008] = {
		29513008,
		0,
		Lang.get(72725),
		29513,
		8,
		300
	},
	[29513009] = {
		29513009,
		0,
		Lang.get(72726),
		29513,
		9,
		292,
		{
			RTResTalkAction[41]
		}
	},
	[29513010] = {
		29513010,
		0,
		Lang.get(72727),
		29513,
		10,
		292,
		{
			RTResTalkAction[41]
		}
	},
	[29513011] = {
		29513011,
		4,
		nil,
		29513,
		11,
		292,
		{
			RTResTalkAction[41]
		},
		[29] = {
			{
				id = 29513012,
				branch_content = Lang.get(72728)
			},
			{
				id = 29513018,
				branch_content = Lang.get(72729)
			}
		}
	},
	[29513012] = {
		29513012,
		0,
		Lang.get(72730),
		29513,
		12,
		300,
		{
			RTResTalkAction[57]
		}
	},
	[29513013] = {
		29513013,
		0,
		Lang.get(72731),
		29513,
		13,
		292,
		{
			RTResTalkAction[41]
		}
	},
	[29513014] = {
		29513014,
		0,
		Lang.get(72732),
		29513,
		14,
		198,
		{
			RTResTalkAction[76],
			RTResTalkAction[57]
		}
	},
	[29513015] = {
		29513015,
		0,
		Lang.get(72733),
		29513,
		15,
		292,
		{
			RTResTalkAction[41],
			RTResTalkAction[51]
		}
	},
	[29513016] = {
		29513016,
		0,
		Lang.get(72734),
		29513,
		16,
		292,
		{
			RTResTalkAction[41]
		}
	},
	[29513017] = {
		29513017,
		0,
		Lang.get(72735),
		29513,
		17,
		292,
		{
			RTResTalkAction[41]
		}
	},
	[29513018] = {
		29513018,
		0,
		Lang.get(72736),
		29513,
		18,
		300,
		{
			RTResTalkAction[41]
		}
	},
	[29513019] = {
		29513019,
		0,
		"......",
		29513,
		19,
		292,
		{
			RTResTalkAction[41]
		}
	},
	[29513020] = {
		29513020,
		5,
		Lang.get(72737),
		29513,
		20,
		292,
		{
			RTResTalkAction[54]
		}
	},
	[29513021] = {
		29513021,
		0,
		Lang.get(72738),
		29513,
		21,
		198,
		{
			RTResTalkAction[76],
			RTResTalkAction[57]
		}
	},
	[29514001] = {
		29514001,
		0,
		Lang.get(72739),
		29514,
		1,
		198,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		29514,
		nil,
		nil,
		nil,
		nil,
		nil,
		29514
	},
	[29514002] = {
		29514002,
		0,
		Lang.get(72740),
		29514,
		2,
		300
	},
	[29514003] = {
		29514003,
		0,
		Lang.get(72741),
		29514,
		3,
		300
	},
	[29514004] = {
		29514004,
		0,
		Lang.get(72742),
		29514,
		4,
		300
	},
	[29515001] = {
		29515001,
		0,
		Lang.get(72743),
		29515,
		1,
		123,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		29511,
		nil,
		nil,
		nil,
		nil,
		nil,
		29511
	},
	[29515002] = {
		29515002,
		0,
		Lang.get(72744),
		29515,
		2,
		292,
		nil,
		1
	},
	[29515003] = {
		29515003,
		0,
		Lang.get(72745),
		29515,
		3,
		123,
		nil,
		1
	},
	[29515004] = {
		29515004,
		0,
		Lang.get(72746),
		29515,
		4,
		292,
		nil,
		1
	},
	[29515005] = {
		29515005,
		0,
		Lang.get(72747),
		29515,
		5,
		123,
		{
			RTResTalkAction[67]
		},
		nil,
		nil,
		3
	},
	[29515006] = {
		29515006,
		0,
		Lang.get(72748),
		29515,
		6,
		123,
		{
			RTResTalkAction[67]
		}
	},
	[29515007] = {
		29515007,
		0,
		Lang.get(72749),
		29515,
		7,
		216,
		{
			RTResTalkAction[25],
			RTResTalkAction[68]
		}
	},
	[29515008] = {
		29515008,
		0,
		Lang.get(72750),
		29515,
		8,
		292,
		{
			RTResTalkAction[26],
			RTResTalkAction[79]
		}
	},
	[29515009] = {
		29515009,
		0,
		Lang.get(72751),
		29515,
		9,
		292,
		{
			RTResTalkAction[26],
			RTResTalkAction[81]
		}
	},
	[29515010] = {
		29515010,
		0,
		Lang.get(72752),
		29515,
		10,
		216,
		{
			RTResTalkAction[25],
			RTResTalkAction[57]
		}
	},
	[29515011] = {
		29515011,
		0,
		Lang.get(72753),
		29515,
		11,
		198,
		{
			RTResTalkAction[76],
			RTResTalkAction[49]
		}
	},
	[29515012] = {
		29515012,
		0,
		Lang.get(72754),
		29515,
		12,
		292,
		{
			RTResTalkAction[42],
			RTResTalkAction[51]
		}
	},
	[29515013] = {
		29515013,
		0,
		Lang.get(72755),
		29515,
		13,
		300,
		{
			RTResTalkAction[43]
		}
	},
	[29515014] = {
		29515014,
		0,
		"？！",
		29515,
		14,
		292,
		{
			RTResTalkAction[43]
		}
	},
	[29515015] = {
		29515015,
		0,
		Lang.get(72756),
		29515,
		15,
		300,
		{
			RTResTalkAction[41]
		}
	},
	[29515016] = {
		29515016,
		0,
		Lang.get(72757),
		29515,
		16,
		292,
		{
			RTResTalkAction[43]
		}
	},
	[29515017] = {
		29515017,
		0,
		Lang.get(72758),
		29515,
		17,
		198,
		{
			RTResTalkAction[76],
			RTResTalkAction[57]
		}
	},
	[29515018] = {
		29515018,
		0,
		Lang.get(72759),
		29515,
		18,
		216,
		{
			RTResTalkAction[82],
			RTResTalkAction[53]
		}
	},
	[29515019] = {
		29515019,
		0,
		Lang.get(72760),
		29515,
		19,
		292,
		{
			RTResTalkAction[83],
			RTResTalkAction[84],
			RTResTalkAction[85]
		}
	},
	[29515020] = {
		29515020,
		0,
		Lang.get(72761),
		29515,
		20,
		123,
		{
			RTResTalkAction[86],
			RTResTalkAction[51],
			RTResTalkAction[49],
			RTResTalkAction[57]
		}
	},
	[29515021] = {
		29515021,
		0,
		Lang.get(72762),
		29515,
		21,
		300,
		{
			RTResTalkAction[67]
		}
	},
	[29515022] = {
		29515022,
		0,
		Lang.get(72763),
		29515,
		22,
		123,
		{
			RTResTalkAction[67]
		}
	},
	[29515023] = {
		29515023,
		0,
		Lang.get(72764),
		29515,
		23,
		300,
		{
			RTResTalkAction[67]
		}
	},
	[29515024] = {
		29515024,
		0,
		Lang.get(72765),
		29515,
		24,
		292,
		{
			RTResTalkAction[73],
			RTResTalkAction[81]
		}
	},
	[29515025] = {
		29515025,
		0,
		Lang.get(72766),
		29515,
		25,
		123,
		{
			RTResTalkAction[73],
			RTResTalkAction[74]
		}
	},
	[29515026] = {
		29515026,
		0,
		Lang.get(72767),
		29515,
		26,
		292,
		{
			RTResTalkAction[73],
			RTResTalkAction[87]
		}
	},
	[29516001] = {
		29516001,
		0,
		Lang.get(72768),
		29516,
		1,
		292,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		29516,
		nil,
		nil,
		nil,
		nil,
		nil,
		29516
	},
	[29516002] = {
		29516002,
		0,
		Lang.get(72769),
		29516,
		2,
		295,
		nil,
		1
	},
	[29516003] = {
		29516003,
		0,
		Lang.get(72770),
		29516,
		3,
		292,
		nil,
		1
	},
	[29516004] = {
		29516004,
		0,
		Lang.get(72771),
		29516,
		4,
		292,
		nil,
		1
	},
	[29516005] = {
		29516005,
		0,
		Lang.get(72772),
		29516,
		5,
		216,
		{
			RTResTalkAction[25]
		},
		nil,
		nil,
		3
	},
	[29516006] = {
		29516006,
		0,
		Lang.get(72773),
		29516,
		6,
		292,
		{
			RTResTalkAction[26],
			RTResTalkAction[87]
		}
	},
	[29516007] = {
		29516007,
		0,
		Lang.get(72774),
		29516,
		7,
		295,
		{
			RTResTalkAction[88],
			RTResTalkAction[81],
			RTResTalkAction[49]
		}
	},
	[29516008] = {
		29516008,
		0,
		Lang.get(72775),
		29516,
		8,
		292,
		{
			RTResTalkAction[88],
			RTResTalkAction[81]
		}
	},
	[29516009] = {
		29516009,
		0,
		Lang.get(72776),
		29516,
		9,
		295,
		{
			RTResTalkAction[88],
			RTResTalkAction[81]
		}
	},
	[29516010] = {
		29516010,
		0,
		Lang.get(72777),
		29516,
		10,
		292,
		{
			RTResTalkAction[88],
			RTResTalkAction[81]
		}
	},
	[29516011] = {
		29516011,
		0,
		Lang.get(72778),
		29516,
		11,
		292,
		{
			RTResTalkAction[88],
			RTResTalkAction[87]
		}
	},
	[29516012] = {
		29516012,
		0,
		Lang.get(72779),
		29516,
		12,
		295,
		{
			RTResTalkAction[88],
			RTResTalkAction[81]
		}
	},
	[29516013] = {
		29516013,
		0,
		Lang.get(72780),
		29516,
		13,
		292,
		{
			RTResTalkAction[88],
			RTResTalkAction[81]
		}
	},
	[29516014] = {
		29516014,
		5,
		Lang.get(72781),
		29516,
		14,
		295,
		{
			RTResTalkAction[88],
			RTResTalkAction[81]
		}
	},
	[29516015] = {
		29516015,
		0,
		Lang.get(72782),
		29516,
		15,
		295,
		{
			RTResTalkAction[88],
			RTResTalkAction[81]
		}
	},
	[29516016] = {
		29516016,
		0,
		Lang.get(72783),
		29516,
		16,
		292,
		{
			RTResTalkAction[88],
			RTResTalkAction[87]
		}
	},
	[29516017] = {
		29516017,
		0,
		Lang.get(72784),
		29516,
		17,
		295,
		{
			RTResTalkAction[88],
			RTResTalkAction[81]
		}
	},
	[29516018] = {
		29516018,
		0,
		Lang.get(72785),
		29516,
		18,
		292,
		{
			RTResTalkAction[43],
			RTResTalkAction[89]
		}
	},
	[29516019] = {
		29516019,
		0,
		Lang.get(72786),
		29516,
		19,
		216,
		{
			RTResTalkAction[84],
			RTResTalkAction[57]
		}
	},
	[29516020] = {
		29516020,
		0,
		Lang.get(72787),
		29516,
		20,
		292,
		{
			RTResTalkAction[43],
			RTResTalkAction[49]
		}
	},
	[29516021] = {
		29516021,
		0,
		Lang.get(72788),
		29516,
		21,
		292,
		{
			RTResTalkAction[54]
		}
	},
	[29516022] = {
		29516022,
		0,
		Lang.get(72789),
		29516,
		22,
		216,
		{
			RTResTalkAction[52],
			RTResTalkAction[53]
		}
	},
	[29516023] = {
		29516023,
		0,
		Lang.get(72790),
		29516,
		23,
		292,
		{
			RTResTalkAction[52],
			RTResTalkAction[53]
		}
	},
	[29517001] = {
		29517001,
		0,
		Lang.get(72791),
		29517,
		1,
		294,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		29517,
		nil,
		nil,
		nil,
		nil,
		nil,
		29517
	},
	[29517002] = {
		29517002,
		0,
		Lang.get(72792),
		29517,
		2,
		292,
		nil,
		1
	},
	[29517003] = {
		29517003,
		0,
		Lang.get(72793),
		29517,
		3,
		292,
		nil,
		1
	},
	[29517004] = {
		29517004,
		0,
		Lang.get(72794),
		29517,
		4,
		294,
		nil,
		1
	},
	[29517005] = {
		29517005,
		0,
		Lang.get(72795),
		29517,
		5,
		292,
		{
			RTResTalkAction[90],
			RTResTalkAction[74]
		},
		nil,
		nil,
		3
	},
	[29517006] = {
		29517006,
		0,
		Lang.get(72796),
		29517,
		6,
		294,
		{
			RTResTalkAction[90],
			RTResTalkAction[74]
		}
	},
	[29517007] = {
		29517007,
		0,
		Lang.get(72797),
		29517,
		7,
		292,
		{
			RTResTalkAction[90],
			RTResTalkAction[74]
		}
	},
	[29517008] = {
		29517008,
		0,
		Lang.get(72798),
		29517,
		8,
		294,
		{
			RTResTalkAction[90],
			RTResTalkAction[74]
		}
	},
	[29517009] = {
		29517009,
		0,
		Lang.get(72799),
		29517,
		9,
		292,
		{
			RTResTalkAction[90],
			RTResTalkAction[74]
		}
	},
	[29517010] = {
		29517010,
		0,
		Lang.get(72800),
		29517,
		10,
		294,
		{
			RTResTalkAction[90],
			RTResTalkAction[74]
		}
	},
	[29517011] = {
		29517011,
		0,
		Lang.get(72801),
		29517,
		11,
		292,
		{
			RTResTalkAction[90],
			RTResTalkAction[74]
		}
	},
	[29517012] = {
		29517012,
		0,
		Lang.get(72802),
		29517,
		12,
		294,
		{
			RTResTalkAction[90],
			RTResTalkAction[74]
		}
	},
	[29517013] = {
		29517013,
		0,
		Lang.get(72803),
		29517,
		13,
		292,
		{
			RTResTalkAction[90],
			RTResTalkAction[74]
		}
	},
	[29517014] = {
		29517014,
		0,
		Lang.get(72804),
		29517,
		14,
		294,
		{
			RTResTalkAction[90],
			RTResTalkAction[74]
		}
	},
	[29517015] = {
		29517015,
		0,
		Lang.get(72805),
		29517,
		15,
		294,
		{
			RTResTalkAction[90],
			RTResTalkAction[74]
		}
	},
	[29517016] = {
		29517016,
		0,
		Lang.get(72806),
		29517,
		16,
		294,
		{
			RTResTalkAction[90],
			RTResTalkAction[74]
		}
	},
	[29517017] = {
		29517017,
		0,
		Lang.get(72807),
		29517,
		17,
		292,
		{
			RTResTalkAction[90],
			RTResTalkAction[74]
		}
	},
	[29517018] = {
		29517018,
		0,
		Lang.get(72808),
		29517,
		18,
		294,
		{
			RTResTalkAction[90],
			RTResTalkAction[74]
		}
	},
	[29517019] = {
		29517019,
		0,
		Lang.get(72809),
		29517,
		19,
		294,
		{
			RTResTalkAction[90],
			RTResTalkAction[74]
		}
	},
	[29517020] = {
		29517020,
		0,
		Lang.get(72810),
		29517,
		20,
		292,
		{
			RTResTalkAction[90],
			RTResTalkAction[87]
		}
	},
	[29517021] = {
		29517021,
		0,
		Lang.get(72811),
		29517,
		21,
		294,
		{
			RTResTalkAction[90],
			RTResTalkAction[81]
		}
	},
	[29517022] = {
		29517022,
		0,
		Lang.get(72812),
		29517,
		22,
		292,
		{
			RTResTalkAction[90],
			RTResTalkAction[81]
		}
	},
	[29517023] = {
		29517023,
		0,
		Lang.get(72813),
		29517,
		23,
		292,
		{
			RTResTalkAction[90],
			RTResTalkAction[81]
		}
	},
	[29517024] = {
		29517024,
		0,
		Lang.get(72814),
		29517,
		24,
		294,
		{
			RTResTalkAction[90],
			RTResTalkAction[81]
		}
	},
	[29517025] = {
		29517025,
		0,
		Lang.get(72815),
		29517,
		25,
		292,
		{
			RTResTalkAction[90],
			RTResTalkAction[79]
		}
	},
	[29518001] = {
		29518001,
		0,
		Lang.get(72816),
		29518,
		1,
		216,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		29518,
		nil,
		nil,
		nil,
		nil,
		nil,
		29518
	},
	[29518002] = {
		29518002,
		0,
		Lang.get(20458),
		29518,
		2,
		292,
		nil,
		1
	},
	[29518003] = {
		29518003,
		0,
		Lang.get(72817),
		29518,
		3,
		216,
		nil,
		1
	},
	[29518004] = {
		29518004,
		0,
		Lang.get(55133),
		29518,
		4,
		292,
		nil,
		1
	},
	[29518005] = {
		29518005,
		0,
		Lang.get(72818),
		29518,
		5,
		216,
		{
			RTResTalkAction[26],
			RTResTalkAction[74]
		},
		nil,
		nil,
		3
	},
	[29518006] = {
		29518006,
		0,
		Lang.get(72819),
		29518,
		6,
		292,
		{
			RTResTalkAction[26],
			RTResTalkAction[74]
		}
	},
	[29518007] = {
		29518007,
		0,
		Lang.get(72820),
		29518,
		7,
		216,
		{
			RTResTalkAction[26],
			RTResTalkAction[74]
		}
	},
	[29518008] = {
		29518008,
		0,
		"......",
		29518,
		8,
		292,
		{
			RTResTalkAction[26],
			RTResTalkAction[79]
		}
	},
	[29519001] = {
		29519001,
		0,
		Lang.get(72821),
		29519,
		1,
		295,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		29519,
		nil,
		nil,
		nil,
		nil,
		nil,
		29519
	},
	[29519002] = {
		29519002,
		0,
		Lang.get(72822),
		29519,
		2,
		295,
		nil,
		1
	},
	[29519003] = {
		29519003,
		0,
		Lang.get(72823),
		29519,
		3,
		150,
		nil,
		1
	},
	[29519004] = {
		29519004,
		2,
		Lang.get(72824),
		29519,
		4,
		295,
		{
			RTResTalkAction[91]
		},
		nil,
		nil,
		3
	},
	[29519005] = {
		29519005,
		0,
		Lang.get(72825),
		29519,
		5,
		295,
		{
			RTResTalkAction[91]
		}
	},
	[29520001] = {
		29520001,
		0,
		Lang.get(72826),
		29520,
		1,
		664,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		29520,
		nil,
		nil,
		nil,
		nil,
		nil,
		29520
	},
	[29520002] = {
		29520002,
		0,
		Lang.get(72827),
		29520,
		2,
		294,
		nil,
		1
	},
	[29520003] = {
		29520003,
		0,
		Lang.get(72828),
		29520,
		3,
		296,
		nil,
		1
	},
	[29520004] = {
		29520004,
		0,
		Lang.get(72829),
		29520,
		4,
		664,
		nil,
		1
	},
	[29520005] = {
		29520005,
		0,
		Lang.get(72830),
		29520,
		5,
		294,
		{
			RTResTalkAction[92]
		},
		nil,
		nil,
		3
	},
	[29520006] = {
		29520006,
		0,
		Lang.get(72831),
		29520,
		6,
		294,
		{
			RTResTalkAction[92]
		}
	},
	[29520007] = {
		29520007,
		0,
		Lang.get(72832),
		29520,
		7,
		664,
		{
			RTResTalkAction[69],
			RTResTalkAction[70],
			RTResTalkAction[93]
		}
	},
	[29520008] = {
		29520008,
		0,
		Lang.get(72833),
		29520,
		8,
		296,
		{
			RTResTalkAction[69],
			RTResTalkAction[70]
		}
	},
	[29520009] = {
		29520009,
		0,
		Lang.get(72834),
		29520,
		9,
		294,
		{
			RTResTalkAction[92],
			RTResTalkAction[71],
			RTResTalkAction[72]
		}
	},
	[29520010] = {
		29520010,
		0,
		Lang.get(72835),
		29520,
		10,
		216,
		{
			RTResTalkAction[25],
			RTResTalkAction[93]
		}
	},
	[29520011] = {
		29520011,
		0,
		Lang.get(72836),
		29520,
		11,
		294,
		{
			RTResTalkAction[92],
			RTResTalkAction[49]
		}
	},
	[29520012] = {
		29520012,
		0,
		Lang.get(72837),
		29520,
		12,
		293,
		{
			RTResTalkAction[94],
			RTResTalkAction[93]
		}
	},
	[29520013] = {
		29520013,
		0,
		Lang.get(72838),
		29520,
		13,
		216,
		{
			RTResTalkAction[25],
			RTResTalkAction[95]
		}
	},
	[29520014] = {
		29520014,
		0,
		Lang.get(72839),
		29520,
		14,
		295,
		{
			RTResTalkAction[91],
			RTResTalkAction[49]
		}
	},
	[29520015] = {
		29520015,
		0,
		Lang.get(72840),
		29520,
		15,
		294,
		{
			RTResTalkAction[92],
			RTResTalkAction[89]
		}
	},
	[29520016] = {
		29520016,
		0,
		Lang.get(72841),
		29520,
		16,
		293,
		{
			RTResTalkAction[94],
			RTResTalkAction[93]
		}
	},
	[29520017] = {
		29520017,
		5,
		Lang.get(72842),
		29520,
		17,
		293,
		{
			RTResTalkAction[94]
		}
	},
	[29520018] = {
		29520018,
		0,
		Lang.get(72843),
		29520,
		18,
		296,
		{
			RTResTalkAction[96],
			RTResTalkAction[95]
		}
	},
	[29520019] = {
		29520019,
		0,
		Lang.get(72844),
		29520,
		19,
		294,
		{
			RTResTalkAction[92],
			RTResTalkAction[72]
		}
	},
	[29520020] = {
		29520020,
		0,
		Lang.get(72845),
		29520,
		20,
		296,
		{
			RTResTalkAction[69],
			RTResTalkAction[70],
			RTResTalkAction[93]
		}
	},
	[29520021] = {
		29520021,
		0,
		Lang.get(72846),
		29520,
		21,
		664,
		{
			RTResTalkAction[69],
			RTResTalkAction[70]
		}
	},
	[29520022] = {
		29520022,
		0,
		Lang.get(72847),
		29520,
		22,
		296,
		{
			RTResTalkAction[69],
			RTResTalkAction[70]
		}
	},
	[29521001] = {
		29521001,
		0,
		Lang.get(72848),
		29521,
		1,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		29521,
		nil,
		nil,
		nil,
		nil,
		nil,
		29521
	},
	[29521002] = {
		29521002,
		0,
		Lang.get(72849),
		29521,
		2,
		386,
		nil,
		1
	},
	[29521003] = {
		29521003,
		0,
		Lang.get(72850),
		29521,
		3,
		158,
		nil,
		1
	},
	[29521004] = {
		29521004,
		0,
		Lang.get(72851),
		29521,
		4,
		386,
		{
			RTResTalkAction[97]
		},
		nil,
		nil,
		3
	},
	[29521005] = {
		29521005,
		0,
		Lang.get(72852),
		29521,
		5,
		386,
		{
			RTResTalkAction[97]
		}
	},
	[29521006] = {
		29521006,
		0,
		Lang.get(72853),
		29521,
		6,
		158,
		{
			RTResTalkAction[98],
			RTResTalkAction[99]
		}
	},
	[29522001] = {
		29522001,
		0,
		Lang.get(72854),
		29522,
		1,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		29521,
		nil,
		nil,
		nil,
		nil,
		nil,
		29521
	},
	[29522002] = {
		29522002,
		0,
		Lang.get(72855),
		29522,
		2,
		386,
		nil,
		1
	},
	[29522003] = {
		29522003,
		0,
		Lang.get(72856),
		29522,
		3,
		158,
		{
			RTResTalkAction[98]
		},
		nil,
		nil,
		3
	},
	[29522004] = {
		29522004,
		0,
		Lang.get(72857),
		29522,
		4,
		158,
		{
			RTResTalkAction[98]
		}
	},
	[29522005] = {
		29522005,
		0,
		Lang.get(72858),
		29522,
		5,
		293,
		{
			RTResTalkAction[94],
			RTResTalkAction[100]
		}
	},
	[29522006] = {
		29522006,
		0,
		Lang.get(72859),
		29522,
		6,
		158,
		{
			RTResTalkAction[98],
			RTResTalkAction[95]
		}
	},
	[29522007] = {
		29522007,
		0,
		Lang.get(72860),
		29522,
		7,
		293,
		{
			RTResTalkAction[94],
			RTResTalkAction[100]
		}
	},
	[29522008] = {
		29522008,
		0,
		Lang.get(72861),
		29522,
		8,
		386,
		{
			RTResTalkAction[97],
			RTResTalkAction[95]
		}
	},
	[29523001] = {
		29523001,
		3,
		Lang.get(72862),
		29523,
		1,
		386,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		29523,
		[19] = 29523,
		[22] = 1
	},
	[29523002] = {
		29523002,
		0,
		Lang.get(72863),
		29523,
		2,
		112,
		nil,
		1
	},
	[29523003] = {
		29523003,
		0,
		Lang.get(72864),
		29523,
		3,
		293,
		nil,
		1
	},
	[29524001] = {
		29524001,
		0,
		Lang.get(72865),
		29524,
		1,
		141,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		29524,
		nil,
		nil,
		nil,
		nil,
		nil,
		29524
	},
	[29524002] = {
		29524002,
		0,
		Lang.get(72866),
		29524,
		2,
		133,
		nil,
		1
	},
	[29524003] = {
		29524003,
		0,
		Lang.get(72867),
		29524,
		3,
		107,
		nil,
		1
	},
	[29524004] = {
		29524004,
		0,
		Lang.get(72868),
		29524,
		4,
		133,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[29524005] = {
		29524005,
		0,
		Lang.get(72869),
		29524,
		5,
		133,
		{
			RTResTalkAction[2]
		}
	},
	[29524006] = {
		29524006,
		0,
		Lang.get(72870),
		29524,
		6,
		293,
		{
			RTResTalkAction[22],
			RTResTalkAction[101]
		}
	},
	[29524007] = {
		29524007,
		0,
		Lang.get(72871),
		29524,
		7,
		133,
		{
			RTResTalkAction[22],
			RTResTalkAction[101]
		}
	},
	[29524008] = {
		29524008,
		0,
		Lang.get(72872),
		29524,
		8,
		141,
		{
			RTResTalkAction[102],
			RTResTalkAction[101],
			RTResTalkAction[3]
		}
	},
	[29524009] = {
		29524009,
		0,
		Lang.get(72873),
		29524,
		9,
		293,
		{
			RTResTalkAction[102],
			RTResTalkAction[101]
		}
	},
	[29524010] = {
		29524010,
		0,
		Lang.get(21485),
		29524,
		10,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[101],
			RTResTalkAction[6]
		}
	},
	[29524011] = {
		29524011,
		0,
		Lang.get(72874),
		29524,
		11,
		141,
		{
			RTResTalkAction[102],
			RTResTalkAction[101],
			RTResTalkAction[16]
		}
	},
	[29524012] = {
		29524012,
		0,
		Lang.get(72875),
		29524,
		12,
		293,
		{
			RTResTalkAction[102],
			RTResTalkAction[101]
		}
	},
	[29524013] = {
		29524013,
		0,
		Lang.get(72876),
		29524,
		13,
		216,
		{
			RTResTalkAction[25],
			RTResTalkAction[6],
			RTResTalkAction[95]
		}
	},
	[29525001] = {
		29525001,
		0,
		Lang.get(72877),
		29525,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		29524,
		nil,
		nil,
		nil,
		nil,
		nil,
		29524
	},
	[29525002] = {
		29525002,
		0,
		Lang.get(72878),
		29525,
		2,
		107,
		nil,
		1
	},
	[29525003] = {
		29525003,
		0,
		Lang.get(72879),
		29525,
		3,
		141,
		nil,
		1
	},
	[29525004] = {
		29525004,
		0,
		Lang.get(72880),
		29525,
		4,
		141,
		nil,
		1
	},
	[29525005] = {
		29525005,
		0,
		Lang.get(72881),
		29525,
		5,
		107,
		nil,
		1
	},
	[29525006] = {
		29525006,
		0,
		Lang.get(72882),
		29525,
		6,
		133,
		{
			RTResTalkAction[30]
		},
		nil,
		nil,
		3
	},
	[29525007] = {
		29525007,
		0,
		Lang.get(72883),
		29525,
		7,
		107,
		{
			RTResTalkAction[103],
			RTResTalkAction[27]
		}
	},
	[29525008] = {
		29525008,
		0,
		Lang.get(72884),
		29525,
		8,
		133,
		{
			RTResTalkAction[8],
			RTResTalkAction[28]
		}
	},
	[29525009] = {
		29525009,
		0,
		Lang.get(72885),
		29525,
		9,
		107,
		{
			RTResTalkAction[104],
			RTResTalkAction[28]
		}
	},
	[29525010] = {
		29525010,
		0,
		Lang.get(72886),
		29525,
		10,
		133,
		{
			RTResTalkAction[105],
			RTResTalkAction[28]
		}
	},
	[29525011] = {
		29525011,
		0,
		Lang.get(72887),
		29525,
		11,
		107,
		{
			RTResTalkAction[105],
			RTResTalkAction[28]
		}
	},
	[29525012] = {
		29525012,
		0,
		Lang.get(72888),
		29525,
		12,
		133,
		{
			RTResTalkAction[8],
			RTResTalkAction[27]
		}
	},
	[29525013] = {
		29525013,
		0,
		Lang.get(72889),
		29525,
		13,
		107,
		{
			RTResTalkAction[103],
			RTResTalkAction[28]
		}
	},
	[29526001] = {
		29526001,
		0,
		Lang.get(72890),
		29526,
		1,
		293,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		29535,
		nil,
		nil,
		nil,
		nil,
		nil,
		29535
	},
	[29526002] = {
		29526002,
		0,
		Lang.get(72891),
		29526,
		2,
		293,
		nil,
		1
	},
	[29526003] = {
		29526003,
		0,
		Lang.get(72892),
		29526,
		3,
		295,
		nil,
		1
	},
	[29526004] = {
		29526004,
		0,
		Lang.get(72893),
		29526,
		4,
		293,
		nil,
		1
	},
	[29526005] = {
		29526005,
		0,
		"？！！！",
		29526,
		5,
		295,
		nil,
		1
	},
	[29526006] = {
		29526006,
		0,
		Lang.get(72894),
		29526,
		6,
		216,
		{
			RTResTalkAction[25]
		},
		nil,
		nil,
		3
	},
	[29526007] = {
		29526007,
		0,
		Lang.get(72895),
		29526,
		7,
		294,
		{
			RTResTalkAction[92],
			RTResTalkAction[49]
		}
	},
	[29526008] = {
		29526008,
		0,
		Lang.get(72896),
		29526,
		8,
		216,
		{
			RTResTalkAction[25],
			RTResTalkAction[93]
		}
	},
	[29526009] = {
		29526009,
		0,
		Lang.get(72897),
		29526,
		9,
		294,
		{
			RTResTalkAction[92],
			RTResTalkAction[49]
		}
	},
	[29526010] = {
		29526010,
		0,
		Lang.get(72898),
		29526,
		10,
		216,
		{
			RTResTalkAction[25],
			RTResTalkAction[93]
		}
	},
	[29526011] = {
		29526011,
		0,
		Lang.get(72899),
		29526,
		11,
		293,
		{
			RTResTalkAction[94],
			RTResTalkAction[49]
		}
	},
	[29526012] = {
		29526012,
		0,
		Lang.get(72900),
		29526,
		12,
		294,
		{
			RTResTalkAction[92],
			RTResTalkAction[95]
		}
	},
	[29527001] = {
		29527001,
		0,
		Lang.get(72901),
		29527,
		1,
		216,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		29527,
		nil,
		nil,
		nil,
		nil,
		nil,
		29527
	},
	[29527002] = {
		29527002,
		0,
		Lang.get(72902),
		29527,
		2,
		295,
		nil,
		1
	},
	[29527003] = {
		29527003,
		0,
		Lang.get(72903),
		29527,
		3,
		293,
		nil,
		1
	},
	[29527004] = {
		29527004,
		0,
		Lang.get(72904),
		29527,
		4,
		216,
		nil,
		1
	},
	[29527005] = {
		29527005,
		0,
		Lang.get(72905),
		29527,
		5,
		295,
		nil,
		1
	},
	[29527006] = {
		29527006,
		0,
		Lang.get(72906),
		29527,
		6,
		293,
		{
			RTResTalkAction[94]
		},
		nil,
		nil,
		3
	},
	[29527007] = {
		29527007,
		0,
		Lang.get(72907),
		29527,
		7,
		295,
		{
			RTResTalkAction[88],
			RTResTalkAction[101]
		}
	},
	[29527008] = {
		29527008,
		0,
		Lang.get(72908),
		29527,
		8,
		293,
		{
			RTResTalkAction[88],
			RTResTalkAction[101]
		}
	},
	[29527009] = {
		29527009,
		5,
		Lang.get(72909),
		29527,
		9,
		295,
		{
			RTResTalkAction[88],
			RTResTalkAction[101]
		}
	},
	[29527010] = {
		29527010,
		0,
		Lang.get(72910),
		29527,
		10,
		293,
		{
			RTResTalkAction[88],
			RTResTalkAction[101]
		}
	},
	[29527011] = {
		29527011,
		0,
		Lang.get(72911),
		29527,
		11,
		216,
		{
			RTResTalkAction[26],
			RTResTalkAction[101],
			RTResTalkAction[89]
		}
	},
	[29527012] = {
		29527012,
		0,
		Lang.get(72912),
		29527,
		12,
		295,
		{
			RTResTalkAction[88],
			RTResTalkAction[101],
			RTResTalkAction[49]
		}
	},
	[29528001] = {
		29528001,
		0,
		Lang.get(72913),
		29528,
		1,
		292,
		nil,
		1,
		nil,
		nil,
		nil,
		58,
		29528,
		nil,
		nil,
		nil,
		nil,
		nil,
		29528
	},
	[29528002] = {
		29528002,
		0,
		Lang.get(72914),
		29528,
		2,
		292,
		nil,
		1
	},
	[29528003] = {
		29528003,
		0,
		Lang.get(72915),
		29528,
		3,
		292,
		nil,
		1
	},
	[29528004] = {
		29528004,
		0,
		Lang.get(72916),
		29528,
		4,
		292,
		nil,
		1,
		1
	},
	[29528005] = {
		29528005,
		0,
		Lang.get(72917),
		29528,
		5,
		292,
		nil,
		1,
		0
	},
	[29528006] = {
		29528006,
		0,
		Lang.get(72918),
		29528,
		6,
		300,
		{
			RTResTalkAction[41]
		}
	},
	[29528007] = {
		29528007,
		0,
		Lang.get(72919),
		29528,
		7,
		292,
		{
			RTResTalkAction[41]
		},
		nil,
		nil,
		3
	},
	[29528008] = {
		29528008,
		0,
		Lang.get(72920),
		29528,
		8,
		300,
		{
			RTResTalkAction[41]
		}
	},
	[29528009] = {
		29528009,
		0,
		Lang.get(72921),
		29528,
		9,
		292,
		{
			RTResTalkAction[54]
		}
	},
	[29528010] = {
		29528010,
		0,
		Lang.get(72922),
		29528,
		10,
		300,
		{
			RTResTalkAction[43]
		}
	},
	[29528011] = {
		29528011,
		0,
		Lang.get(72923),
		29528,
		11,
		292,
		{
			RTResTalkAction[43]
		}
	},
	[29528012] = {
		29528012,
		0,
		Lang.get(72924),
		29528,
		12,
		300,
		{
			RTResTalkAction[43]
		}
	},
	[29528013] = {
		29528013,
		0,
		Lang.get(72925),
		29528,
		13,
		292,
		{
			RTResTalkAction[54]
		}
	},
	[29528014] = {
		29528014,
		0,
		Lang.get(72926),
		29528,
		14,
		300,
		{
			RTResTalkAction[43]
		}
	},
	[29528015] = {
		29528015,
		0,
		Lang.get(72927),
		29528,
		15,
		292,
		{
			RTResTalkAction[43]
		}
	},
	[29528016] = {
		29528016,
		0,
		Lang.get(72928),
		29528,
		16,
		300,
		{
			RTResTalkAction[41]
		}
	},
	[29528017] = {
		29528017,
		0,
		Lang.get(72929),
		29528,
		17,
		292,
		{
			RTResTalkAction[41]
		}
	},
	[29528018] = {
		29528018,
		0,
		Lang.get(72930),
		29528,
		18,
		292,
		{
			RTResTalkAction[41]
		}
	},
	[29529001] = {
		29529001,
		0,
		Lang.get(72931),
		29529,
		1,
		292,
		nil,
		1,
		2,
		nil,
		nil,
		62,
		29529,
		nil,
		nil,
		nil,
		nil,
		nil,
		29529
	},
	[29529002] = {
		29529002,
		4,
		nil,
		29529,
		2,
		292,
		nil,
		1,
		2,
		[29] = {
			{
				id = 29529003,
				branch_content = Lang.get(72932)
			}
		}
	},
	[29529003] = {
		29529003,
		0,
		Lang.get(72933),
		29529,
		3,
		198,
		nil,
		1,
		0
	},
	[29529004] = {
		29529004,
		0,
		Lang.get(72934),
		29529,
		4,
		216,
		{
			RTResTalkAction[26],
			RTResTalkAction[44]
		},
		nil,
		nil,
		3
	},
	[29529005] = {
		29529005,
		0,
		Lang.get(72935),
		29529,
		5,
		198,
		{
			RTResTalkAction[45],
			RTResTalkAction[106]
		}
	},
	[29529006] = {
		29529006,
		0,
		Lang.get(72936),
		29529,
		6,
		216,
		{
			RTResTalkAction[45],
			RTResTalkAction[106]
		}
	},
	[29529007] = {
		29529007,
		0,
		Lang.get(72937),
		29529,
		7,
		300,
		{
			RTResTalkAction[45],
			RTResTalkAction[106]
		},
		nil,
		0
	},
	[29530001] = {
		29530001,
		0,
		Lang.get(72938),
		29530,
		1,
		292,
		nil,
		1,
		1,
		nil,
		nil,
		62,
		29530,
		nil,
		nil,
		nil,
		nil,
		nil,
		29530
	},
	[29530002] = {
		29530002,
		0,
		Lang.get(72939),
		29530,
		2,
		198,
		nil,
		1,
		1
	},
	[29530003] = {
		29530003,
		5,
		Lang.get(72940),
		29530,
		3,
		292,
		nil,
		1,
		1
	},
	[29530004] = {
		29530004,
		0,
		Lang.get(72941),
		29530,
		4,
		198,
		nil,
		1,
		3
	},
	[29530005] = {
		29530005,
		4,
		nil,
		29530,
		5,
		198,
		nil,
		1,
		3,
		[29] = {
			{
				id = 29530006,
				branch_content = Lang.get(72942)
			}
		}
	},
	[29530006] = {
		29530006,
		0,
		Lang.get(72943),
		29530,
		6,
		216,
		nil,
		1,
		0
	},
	[29530007] = {
		29530007,
		0,
		Lang.get(72944),
		29530,
		7,
		216,
		nil,
		1,
		3
	},
	[29530008] = {
		29530008,
		0,
		Lang.get(72945),
		29530,
		8,
		216,
		nil,
		1,
		0
	},
	[29531001] = {
		29531001,
		0,
		Lang.get(72946),
		29531,
		1,
		198,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		29529,
		nil,
		nil,
		nil,
		nil,
		nil,
		29529
	},
	[29531002] = {
		29531002,
		0,
		Lang.get(72947),
		29531,
		2,
		216,
		nil,
		1
	},
	[29531003] = {
		29531003,
		0,
		Lang.get(72948),
		29531,
		3,
		300
	},
	[29531004] = {
		29531004,
		3,
		Lang.get(72949),
		29531,
		4,
		605,
		[22] = 1
	},
	[29531005] = {
		29531005,
		3,
		Lang.get(72950),
		29531,
		5,
		605,
		[22] = 1
	},
	[29531006] = {
		29531006,
		3,
		Lang.get(72951),
		29531,
		6,
		605,
		[22] = 1
	},
	[29531007] = {
		29531007,
		0,
		Lang.get(72952),
		29531,
		7,
		292,
		nil,
		1
	},
	[29531008] = {
		29531008,
		0,
		Lang.get(72953),
		29531,
		8,
		289,
		{
			RTResTalkAction[107]
		},
		nil,
		nil,
		3
	},
	[29531009] = {
		29531009,
		0,
		"？！！！",
		29531,
		9,
		292,
		{
			RTResTalkAction[41],
			RTResTalkAction[108]
		}
	},
	[29532001] = {
		29532001,
		3,
		Lang.get(72954),
		29532,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		58,
		29532,
		[19] = 29532,
		[22] = 1
	},
	[29532002] = {
		29532002,
		0,
		Lang.get(72955),
		29532,
		2,
		351
	},
	[29532003] = {
		29532003,
		0,
		Lang.get(72956),
		29532,
		3,
		300
	},
	[29532004] = {
		29532004,
		0,
		Lang.get(72957),
		29532,
		4,
		289,
		{
			RTResTalkAction[107]
		}
	},
	[29532005] = {
		29532005,
		0,
		Lang.get(72958),
		29532,
		5,
		289,
		{
			RTResTalkAction[107]
		}
	},
	[29532006] = {
		29532006,
		0,
		Lang.get(72959),
		29532,
		6,
		289,
		{
			RTResTalkAction[107]
		}
	},
	[29532007] = {
		29532007,
		0,
		Lang.get(72960),
		29532,
		7,
		289,
		{
			RTResTalkAction[107]
		}
	},
	[29532008] = {
		29532008,
		0,
		Lang.get(72961),
		29532,
		8,
		289,
		{
			RTResTalkAction[107]
		}
	},
	[29533001] = {
		29533001,
		0,
		Lang.get(72962),
		29533,
		1,
		216,
		nil,
		1,
		nil,
		nil,
		nil,
		58,
		29529,
		nil,
		nil,
		nil,
		nil,
		nil,
		29529
	},
	[29533002] = {
		29533002,
		0,
		Lang.get(72963),
		29533,
		2,
		300
	},
	[29533003] = {
		29533003,
		0,
		Lang.get(72964),
		29533,
		3,
		300
	},
	[29533004] = {
		29533004,
		0,
		Lang.get(72965),
		29533,
		4,
		216,
		nil,
		1
	},
	[29533005] = {
		29533005,
		0,
		Lang.get(72966),
		29533,
		5,
		292,
		nil,
		1,
		3
	},
	[29533006] = {
		29533006,
		0,
		Lang.get(72967),
		29533,
		6,
		292,
		nil,
		1,
		3
	},
	[29533007] = {
		29533007,
		0,
		Lang.get(72968),
		29533,
		7,
		198,
		nil,
		1,
		0
	},
	[29533008] = {
		29533008,
		5,
		Lang.get(72969),
		29533,
		8,
		292,
		{
			RTResTalkAction[109]
		},
		nil,
		nil,
		3
	},
	[29533009] = {
		29533009,
		0,
		Lang.get(72970),
		29533,
		9,
		292,
		{
			RTResTalkAction[109]
		}
	},
	[29533010] = {
		29533010,
		0,
		Lang.get(72971),
		29533,
		10,
		292,
		{
			RTResTalkAction[109]
		}
	},
	[29533011] = {
		29533011,
		0,
		Lang.get(72972),
		29533,
		11,
		292,
		{
			RTResTalkAction[109]
		}
	},
	[29533012] = {
		29533012,
		0,
		Lang.get(72973),
		29533,
		12,
		292,
		{
			RTResTalkAction[109]
		}
	},
	[29533013] = {
		29533013,
		0,
		Lang.get(72974),
		29533,
		13,
		292,
		{
			RTResTalkAction[109]
		}
	},
	[29533014] = {
		29533014,
		5,
		Lang.get(72975),
		29533,
		14,
		292,
		{
			RTResTalkAction[109]
		}
	},
	[29533015] = {
		29533015,
		0,
		Lang.get(72976),
		29533,
		15,
		300,
		{
			RTResTalkAction[57]
		}
	},
	[29533016] = {
		29533016,
		0,
		Lang.get(72977),
		29533,
		16,
		292,
		{
			RTResTalkAction[109]
		}
	},
	[29533017] = {
		29533017,
		0,
		Lang.get(72978),
		29533,
		17,
		292,
		{
			RTResTalkAction[109]
		}
	},
	[29533018] = {
		29533018,
		0,
		Lang.get(72979),
		29533,
		18,
		292,
		{
			RTResTalkAction[109]
		}
	},
	[29533019] = {
		29533019,
		0,
		Lang.get(72980),
		29533,
		19,
		300,
		{
			RTResTalkAction[57]
		}
	},
	[29533020] = {
		29533020,
		0,
		Lang.get(72981),
		29533,
		20,
		216,
		{
			RTResTalkAction[25]
		}
	},
	[29533021] = {
		29533021,
		0,
		Lang.get(72982),
		29533,
		21,
		300,
		{
			RTResTalkAction[49]
		}
	},
	[29533022] = {
		29533022,
		0,
		Lang.get(72983),
		29533,
		22,
		198,
		{
			RTResTalkAction[76]
		}
	},
	[29533023] = {
		29533023,
		0,
		Lang.get(72984),
		29533,
		23,
		292,
		{
			RTResTalkAction[43],
			RTResTalkAction[51]
		}
	},
	[29533024] = {
		29533024,
		0,
		Lang.get(72985),
		29533,
		24,
		300,
		{
			RTResTalkAction[41]
		}
	},
	[29533025] = {
		29533025,
		0,
		Lang.get(72986),
		29533,
		25,
		292,
		{
			RTResTalkAction[41]
		}
	},
	[29533026] = {
		29533026,
		0,
		Lang.get(72987),
		29533,
		26,
		198,
		{
			RTResTalkAction[65],
			RTResTalkAction[57]
		}
	},
	[29533027] = {
		29533027,
		0,
		Lang.get(72988),
		29533,
		27,
		292,
		{
			RTResTalkAction[42],
			RTResTalkAction[51]
		}
	},
	[29533028] = {
		29533028,
		0,
		Lang.get(72989),
		29533,
		28,
		292,
		{
			RTResTalkAction[43]
		}
	},
	[29533029] = {
		29533029,
		0,
		Lang.get(72990),
		29533,
		29,
		292,
		{
			RTResTalkAction[41]
		}
	},
	[29533030] = {
		29533030,
		0,
		Lang.get(72991),
		29533,
		30,
		292,
		{
			RTResTalkAction[41]
		}
	},
	[29534001] = {
		29534001,
		0,
		Lang.get(72992),
		29534,
		1,
		292,
		nil,
		1,
		0,
		nil,
		nil,
		62,
		29534,
		nil,
		nil,
		nil,
		nil,
		nil,
		29534
	},
	[29534002] = {
		29534002,
		0,
		Lang.get(72993),
		29534,
		2,
		300
	},
	[29534003] = {
		29534003,
		0,
		Lang.get(72994),
		29534,
		3,
		292,
		nil,
		1,
		2
	},
	[29534004] = {
		29534004,
		4,
		nil,
		29534,
		4,
		292,
		nil,
		1,
		2,
		[29] = {
			{
				id = 29534005,
				branch_content = Lang.get(72995)
			},
			{
				id = 29534005,
				branch_content = Lang.get(72996)
			}
		}
	},
	[29534005] = {
		29534005,
		0,
		Lang.get(72997),
		29534,
		5,
		292,
		nil,
		1,
		0
	},
	[29534006] = {
		29534006,
		0,
		Lang.get(72998),
		29534,
		6,
		300,
		nil,
		nil,
		nil,
		3
	},
	[29534007] = {
		29534007,
		0,
		Lang.get(72999),
		29534,
		7,
		292,
		{
			RTResTalkAction[41]
		}
	},
	[29534008] = {
		29534008,
		4,
		nil,
		29534,
		8,
		292,
		{
			RTResTalkAction[41]
		},
		[29] = {
			{
				id = 29534009,
				branch_content = Lang.get(73000)
			},
			{
				id = 29534009,
				branch_content = Lang.get(73001)
			}
		}
	},
	[29534009] = {
		29534009,
		0,
		Lang.get(73002),
		29534,
		9,
		292,
		{
			RTResTalkAction[41]
		}
	},
	[29534010] = {
		29534010,
		0,
		Lang.get(73003),
		29534,
		10,
		292,
		{
			RTResTalkAction[41]
		}
	},
	[29534011] = {
		29534011,
		0,
		Lang.get(73004),
		29534,
		11,
		300,
		{
			RTResTalkAction[41]
		}
	},
	[29534012] = {
		29534012,
		0,
		Lang.get(73005),
		29534,
		12,
		292,
		{
			RTResTalkAction[41]
		}
	},
	[29534013] = {
		29534013,
		0,
		Lang.get(73006),
		29534,
		13,
		300,
		{
			RTResTalkAction[41]
		}
	},
	[29534014] = {
		29534014,
		0,
		Lang.get(73007),
		29534,
		14,
		292,
		{
			RTResTalkAction[41]
		}
	},
	[29534015] = {
		29534015,
		0,
		Lang.get(73008),
		29534,
		15,
		292,
		{
			RTResTalkAction[41]
		}
	},
	[29534016] = {
		29534016,
		0,
		Lang.get(73009),
		29534,
		16,
		300,
		{
			RTResTalkAction[41]
		}
	},
	[29534017] = {
		29534017,
		0,
		Lang.get(73010),
		29534,
		17,
		292,
		{
			RTResTalkAction[41]
		}
	},
	[29534018] = {
		29534018,
		0,
		Lang.get(73011),
		29534,
		18,
		292,
		{
			RTResTalkAction[54]
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
