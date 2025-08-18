-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\37\\ResTalk.lua

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
	[1] = 2,
	[2] = 215
}
RTResTalkAction[2] = {
	[1] = 3,
	[2] = 112
}
RTResTalkAction[3] = {
	[1] = 3,
	[2] = 220
}
RTResTalkAction[4] = {
	[1] = 0,
	[2] = 112
}
RTResTalkAction[5] = {
	[1] = 1,
	[2] = 112
}
RTResTalkAction[6] = {
	[1] = 0,
	[2] = 215
}
RTResTalkAction[7] = {
	[1] = 0,
	[2] = 220
}
RTResTalkAction[8] = {
	2,
	215,
	nil,
	nil,
	1
}
RTResTalkAction[9] = {
	3,
	220,
	nil,
	nil,
	2
}
RTResTalkAction[10] = {
	[1] = 1,
	[2] = 220
}
RTResTalkAction[11] = {
	[1] = 2,
	[2] = 220
}
RTResTalkAction[12] = {
	1,
	215,
	nil,
	nil,
	1
}
RTResTalkAction[13] = {
	2,
	215,
	nil,
	nil,
	0
}
RTResTalkAction[14] = {
	3,
	112,
	nil,
	nil,
	4
}
RTResTalkAction[15] = {
	1,
	112,
	nil,
	nil,
	4
}
RTResTalkAction[16] = {
	[1] = 1,
	[2] = 151
}
RTResTalkAction[17] = {
	[1] = 1,
	[2] = 215
}
RTResTalkAction[18] = {
	[1] = 0,
	[2] = 151
}
RTResTalkAction[19] = {
	1,
	112,
	nil,
	nil,
	0
}
RTResTalkAction[20] = {
	[1] = 2,
	[2] = 112
}
RTResTalkAction[21] = {
	3,
	220,
	nil,
	nil,
	3
}
RTResTalkAction[22] = {
	[1] = 2,
	[2] = 151
}
RTResTalkAction[23] = {
	[1] = 3,
	[2] = 215
}
RTResTalkAction[24] = {
	1,
	220,
	nil,
	nil,
	3
}
RTResTalkAction[25] = {
	1,
	220,
	nil,
	nil,
	0
}
RTResTalkAction[26] = {
	[1] = 1,
	[2] = 288
}
RTResTalkAction[27] = {
	[1] = 4,
	[2] = 215
}
RTResTalkAction[28] = {
	[1] = 5,
	[2] = 220
}
RTResTalkAction[29] = {
	[1] = 0,
	[2] = 288
}
RTResTalkAction[30] = {
	5,
	220,
	nil,
	nil,
	1
}
RTResTalkAction[31] = {
	[1] = 1,
	[2] = 225
}
RTResTalkAction[32] = {
	[1] = 0,
	[2] = 225
}
RTResTalkAction[33] = {
	1,
	220,
	nil,
	nil,
	2
}
RTResTalkAction[34] = {
	[1] = 1,
	[2] = 287
}
RTResTalkAction[35] = {
	[1] = 0,
	[2] = 287
}
RTResTalkAction[36] = {
	1,
	215,
	nil,
	nil,
	2
}
RTResTalkAction[37] = {
	1,
	215,
	nil,
	nil,
	0
}
RTResTalkAction[38] = {
	[1] = 1,
	[2] = 160
}
RTResTalkAction[39] = {
	[1] = 0,
	[2] = 160
}
RTResTalkAction[40] = {
	[1] = 1,
	[2] = 1021
}
RTResTalkAction[41] = {
	[1] = 2,
	[2] = 160
}
RTResTalkAction[42] = {
	[1] = 3,
	[2] = 1021
}
RTResTalkAction[43] = {
	3,
	1020,
	nil,
	nil,
	1
}
RTResTalkAction[44] = {
	[1] = 0,
	[2] = 1021
}
RTResTalkAction[45] = {
	3,
	1020,
	nil,
	nil,
	0
}
RTResTalkAction[46] = {
	1,
	1020,
	nil,
	nil,
	1
}
RTResTalkAction[47] = {
	[1] = 0,
	[2] = 1020
}
RTResTalkAction[48] = {
	[1] = 1,
	[2] = 1020
}
RTResTalkAction[49] = {
	[1] = 1,
	[2] = 188
}
RTResTalkAction[50] = {
	[1] = 0,
	[2] = 188
}
RTResTalkAction[51] = {
	[1] = 1,
	[2] = 148
}
RTResTalkAction[52] = {
	[1] = 0,
	[2] = 148
}
RTResTalkAction[53] = {
	1,
	225,
	nil,
	nil,
	0
}
RTResTalkAction[54] = {
	[1] = 1,
	[2] = 376
}
RTResTalkAction[55] = {
	[1] = 1,
	[2] = 365
}
RTResTalkAction[56] = {
	[1] = 0,
	[2] = 376
}
RTResTalkAction[57] = {
	[1] = 0,
	[2] = 365
}
RTResTalkAction[58] = {
	1,
	365,
	nil,
	nil,
	2
}
RTResTalkAction[59] = {
	1,
	365,
	nil,
	nil,
	1
}
RTResTalkAction[60] = {
	1,
	365,
	nil,
	nil,
	0
}
RTResTalkAction[61] = {
	1,
	365,
	nil,
	nil,
	3
}

local Data = {
	[31512001] = {
		31512001,
		0,
		Lang.get(75210),
		31512,
		1,
		112,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		31512,
		nil,
		nil,
		nil,
		nil,
		nil,
		31512
	},
	[31512002] = {
		31512002,
		0,
		Lang.get(75211),
		31512,
		2,
		300
	},
	[31512003] = {
		31512003,
		0,
		Lang.get(75212),
		31512,
		3,
		112,
		nil,
		1
	},
	[31512004] = {
		31512004,
		0,
		Lang.get(75213),
		31512,
		4,
		215,
		{
			RTResTalkAction[1],
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[31512005] = {
		31512005,
		0,
		Lang.get(75214),
		31512,
		5,
		112,
		{
			RTResTalkAction[1],
			RTResTalkAction[2]
		}
	},
	[31512006] = {
		31512006,
		0,
		Lang.get(75215),
		31512,
		6,
		220,
		{
			RTResTalkAction[1],
			RTResTalkAction[3],
			RTResTalkAction[4]
		}
	},
	[31512007] = {
		31512007,
		3,
		Lang.get(75216),
		31512,
		7,
		220,
		{
			RTResTalkAction[5],
			RTResTalkAction[6],
			RTResTalkAction[7]
		},
		[22] = 1
	},
	[31513001] = {
		31513001,
		0,
		Lang.get(75217),
		31513,
		1,
		112,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		31513,
		nil,
		nil,
		nil,
		nil,
		nil,
		31513
	},
	[31513002] = {
		31513002,
		0,
		Lang.get(75218),
		31513,
		2,
		220,
		nil,
		1,
		3
	},
	[31513003] = {
		31513003,
		0,
		Lang.get(75219),
		31513,
		3,
		215,
		nil,
		1,
		1
	},
	[31513004] = {
		31513004,
		0,
		Lang.get(75220),
		31513,
		4,
		112,
		nil,
		1,
		1
	},
	[31513005] = {
		31513005,
		0,
		Lang.get(75221),
		31513,
		5,
		112,
		nil,
		1,
		0
	},
	[31513006] = {
		31513006,
		0,
		Lang.get(75222),
		31513,
		6,
		215,
		{
			RTResTalkAction[8],
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[31513007] = {
		31513007,
		0,
		Lang.get(75223),
		31513,
		7,
		220,
		{
			RTResTalkAction[1],
			RTResTalkAction[9]
		}
	},
	[31513008] = {
		31513008,
		0,
		Lang.get(75224),
		31513,
		8,
		300,
		{
			RTResTalkAction[1],
			RTResTalkAction[3]
		}
	},
	[31513009] = {
		31513009,
		0,
		Lang.get(75225),
		31513,
		9,
		112,
		{
			RTResTalkAction[5],
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[31513010] = {
		31513010,
		0,
		Lang.get(75226),
		31513,
		10,
		300,
		{
			RTResTalkAction[5]
		}
	},
	[31513011] = {
		31513011,
		0,
		Lang.get(75227),
		31513,
		11,
		220,
		{
			RTResTalkAction[10],
			RTResTalkAction[4]
		}
	},
	[31513012] = {
		31513012,
		0,
		Lang.get(75228),
		31513,
		12,
		112,
		{
			RTResTalkAction[11],
			RTResTalkAction[2]
		}
	},
	[31513013] = {
		31513013,
		0,
		Lang.get(75229),
		31513,
		13,
		215,
		{
			RTResTalkAction[12],
			RTResTalkAction[7],
			RTResTalkAction[4]
		}
	},
	[31513014] = {
		31513014,
		0,
		Lang.get(75230),
		31513,
		14,
		112,
		{
			RTResTalkAction[1],
			RTResTalkAction[2]
		}
	},
	[31513015] = {
		31513015,
		0,
		Lang.get(75231),
		31513,
		15,
		215,
		{
			RTResTalkAction[13],
			RTResTalkAction[2]
		}
	},
	[31513016] = {
		31513016,
		0,
		Lang.get(75232),
		31513,
		16,
		112,
		{
			RTResTalkAction[1],
			RTResTalkAction[14]
		}
	},
	[31514001] = {
		31514001,
		0,
		Lang.get(75233),
		31514,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		31513,
		[19] = 31513
	},
	[31514002] = {
		31514002,
		0,
		Lang.get(75234),
		31514,
		2,
		300
	},
	[31514003] = {
		31514003,
		0,
		Lang.get(75235),
		31514,
		3,
		215,
		nil,
		1,
		2
	},
	[31514004] = {
		31514004,
		0,
		Lang.get(75236),
		31514,
		4,
		300
	},
	[31514005] = {
		31514005,
		0,
		Lang.get(75237),
		31514,
		5,
		215,
		nil,
		1,
		3
	},
	[31514006] = {
		31514006,
		0,
		Lang.get(75238),
		31514,
		6,
		300
	},
	[31514007] = {
		31514007,
		0,
		Lang.get(75239),
		31514,
		7,
		112,
		nil,
		1,
		1
	},
	[31514008] = {
		31514008,
		0,
		Lang.get(75240),
		31514,
		8,
		215,
		nil,
		1,
		0
	},
	[31514009] = {
		31514009,
		0,
		Lang.get(75241),
		31514,
		9,
		112,
		{
			RTResTalkAction[15]
		},
		nil,
		nil,
		3
	},
	[31514010] = {
		31514010,
		0,
		Lang.get(75242),
		31514,
		10,
		151,
		{
			RTResTalkAction[16],
			RTResTalkAction[4]
		}
	},
	[31514011] = {
		31514011,
		0,
		Lang.get(75243),
		31514,
		11,
		151,
		{
			RTResTalkAction[16]
		}
	},
	[31514012] = {
		31514012,
		0,
		Lang.get(75244),
		31514,
		12,
		215,
		{
			RTResTalkAction[17],
			RTResTalkAction[18]
		}
	},
	[31514013] = {
		31514013,
		0,
		Lang.get(75245),
		31514,
		13,
		112,
		{
			RTResTalkAction[19],
			RTResTalkAction[6]
		}
	},
	[31514014] = {
		31514014,
		0,
		Lang.get(75246),
		31514,
		14,
		220,
		{
			RTResTalkAction[20],
			RTResTalkAction[21]
		}
	},
	[31514015] = {
		31514015,
		0,
		Lang.get(75247),
		31514,
		15,
		112,
		{
			RTResTalkAction[20],
			RTResTalkAction[3]
		}
	},
	[31514016] = {
		31514016,
		0,
		Lang.get(75248),
		31514,
		16,
		151,
		{
			RTResTalkAction[16],
			RTResTalkAction[4],
			RTResTalkAction[7]
		}
	},
	[31515001] = {
		31515001,
		0,
		Lang.get(75249),
		31515,
		1,
		215,
		nil,
		1,
		1,
		nil,
		nil,
		63,
		31515,
		nil,
		nil,
		nil,
		nil,
		nil,
		31515
	},
	[31515002] = {
		31515002,
		0,
		Lang.get(75250),
		31515,
		2,
		151,
		nil,
		1,
		0
	},
	[31515003] = {
		31515003,
		0,
		Lang.get(75251),
		31515,
		3,
		220,
		nil,
		1,
		3
	},
	[31515004] = {
		31515004,
		0,
		Lang.get(75252),
		31515,
		4,
		220,
		nil,
		1,
		0
	},
	[31515005] = {
		31515005,
		0,
		Lang.get(75253),
		31515,
		5,
		151,
		{
			RTResTalkAction[22],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[31515006] = {
		31515006,
		0,
		Lang.get(75254),
		31515,
		6,
		215,
		{
			RTResTalkAction[22],
			RTResTalkAction[23]
		}
	},
	[31515007] = {
		31515007,
		0,
		Lang.get(75255),
		31515,
		7,
		151,
		{
			RTResTalkAction[22],
			RTResTalkAction[23]
		}
	},
	[31515008] = {
		31515008,
		0,
		Lang.get(75256),
		31515,
		8,
		151,
		{
			RTResTalkAction[22],
			RTResTalkAction[23]
		}
	},
	[31515009] = {
		31515009,
		0,
		Lang.get(75257),
		31515,
		9,
		220,
		{
			RTResTalkAction[10],
			RTResTalkAction[18],
			RTResTalkAction[6]
		}
	},
	[31515010] = {
		31515010,
		0,
		Lang.get(75258),
		31515,
		10,
		220,
		{
			RTResTalkAction[24]
		}
	},
	[31515011] = {
		31515011,
		0,
		Lang.get(75259),
		31515,
		11,
		151,
		{
			RTResTalkAction[22],
			RTResTalkAction[23],
			RTResTalkAction[7]
		}
	},
	[31515012] = {
		31515012,
		0,
		Lang.get(75260),
		31515,
		12,
		220,
		{
			RTResTalkAction[25],
			RTResTalkAction[18],
			RTResTalkAction[6]
		}
	},
	[31515013] = {
		31515013,
		0,
		Lang.get(75261),
		31515,
		13,
		215,
		{
			RTResTalkAction[17],
			RTResTalkAction[7]
		}
	},
	[31516001] = {
		31516001,
		0,
		Lang.get(75262),
		31516,
		1,
		220,
		nil,
		1,
		2,
		nil,
		nil,
		63,
		31516,
		nil,
		nil,
		nil,
		nil,
		nil,
		31516
	},
	[31516002] = {
		31516002,
		0,
		Lang.get(75263),
		31516,
		2,
		151,
		nil,
		1,
		0
	},
	[31516003] = {
		31516003,
		0,
		Lang.get(75264),
		31516,
		3,
		288,
		{
			RTResTalkAction[26]
		},
		nil,
		nil,
		3
	},
	[31516004] = {
		31516004,
		0,
		Lang.get(75265),
		31516,
		4,
		151,
		{
			RTResTalkAction[27],
			RTResTalkAction[16],
			RTResTalkAction[28],
			RTResTalkAction[29]
		}
	},
	[31516005] = {
		31516005,
		0,
		Lang.get(75266),
		31516,
		5,
		215,
		{
			RTResTalkAction[27],
			RTResTalkAction[16],
			RTResTalkAction[28]
		}
	},
	[31516006] = {
		31516006,
		0,
		Lang.get(75267),
		31516,
		6,
		220,
		{
			RTResTalkAction[27],
			RTResTalkAction[16],
			RTResTalkAction[30]
		}
	},
	[31517001] = {
		31517001,
		0,
		Lang.get(75268),
		31517,
		1,
		287,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		31517,
		nil,
		nil,
		nil,
		nil,
		nil,
		31517
	},
	[31517002] = {
		31517002,
		0,
		Lang.get(75269),
		31517,
		2,
		151,
		nil,
		1
	},
	[31517003] = {
		31517003,
		0,
		Lang.get(75270),
		31517,
		3,
		215,
		nil,
		1
	},
	[31517004] = {
		31517004,
		0,
		Lang.get(75271),
		31517,
		4,
		225,
		{
			RTResTalkAction[31]
		},
		nil,
		nil,
		3
	},
	[31517005] = {
		31517005,
		0,
		Lang.get(75272),
		31517,
		5,
		220,
		{
			RTResTalkAction[10],
			RTResTalkAction[32]
		}
	},
	[31517006] = {
		31517006,
		0,
		Lang.get(75273),
		31517,
		6,
		215,
		{
			RTResTalkAction[17],
			RTResTalkAction[7]
		}
	},
	[31517007] = {
		31517007,
		0,
		Lang.get(75274),
		31517,
		7,
		225,
		{
			RTResTalkAction[31],
			RTResTalkAction[6]
		}
	},
	[31517008] = {
		31517008,
		0,
		Lang.get(75275),
		31517,
		8,
		225,
		{
			RTResTalkAction[31]
		}
	},
	[31517009] = {
		31517009,
		0,
		Lang.get(75276),
		31517,
		9,
		220,
		{
			RTResTalkAction[33],
			RTResTalkAction[32]
		}
	},
	[31517010] = {
		31517010,
		0,
		Lang.get(75277),
		31517,
		10,
		287,
		{
			RTResTalkAction[34],
			RTResTalkAction[7]
		}
	},
	[31517011] = {
		31517011,
		0,
		Lang.get(75278),
		31517,
		11,
		151,
		{
			RTResTalkAction[16],
			RTResTalkAction[35]
		}
	},
	[31517012] = {
		31517012,
		0,
		"......",
		31517,
		12,
		287,
		{
			RTResTalkAction[34],
			RTResTalkAction[18]
		}
	},
	[31517013] = {
		31517013,
		0,
		Lang.get(75279),
		31517,
		13,
		215,
		{
			RTResTalkAction[36],
			RTResTalkAction[35]
		}
	},
	[31517014] = {
		31517014,
		0,
		Lang.get(75280),
		31517,
		14,
		215,
		{
			RTResTalkAction[37]
		}
	},
	[31517015] = {
		31517015,
		0,
		Lang.get(75281),
		31517,
		15,
		220,
		{
			RTResTalkAction[25],
			RTResTalkAction[6]
		}
	},
	[31518001] = {
		31518001,
		0,
		Lang.get(75282),
		31518,
		1,
		160,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		31518,
		nil,
		nil,
		nil,
		nil,
		nil,
		31518
	},
	[31518002] = {
		31518002,
		0,
		Lang.get(75283),
		31518,
		2,
		160,
		nil,
		1
	},
	[31518003] = {
		31518003,
		0,
		Lang.get(75284),
		31518,
		3,
		160,
		nil,
		1
	},
	[31518004] = {
		31518004,
		0,
		Lang.get(75285),
		31518,
		4,
		160,
		nil,
		1
	},
	[31518005] = {
		31518005,
		5,
		Lang.get(75286),
		31518,
		5,
		160,
		[22] = 1
	},
	[31518006] = {
		31518006,
		0,
		Lang.get(75287),
		31518,
		6,
		160,
		{
			RTResTalkAction[38]
		},
		nil,
		nil,
		3
	},
	[31518007] = {
		31518007,
		3,
		Lang.get(75288),
		31518,
		7,
		160,
		{
			RTResTalkAction[39]
		},
		[22] = 1
	},
	[31518008] = {
		31518008,
		0,
		Lang.get(75289),
		31518,
		8,
		1021,
		{
			RTResTalkAction[40]
		}
	},
	[31518009] = {
		31518009,
		0,
		Lang.get(75290),
		31518,
		9,
		160,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[31518010] = {
		31518010,
		0,
		Lang.get(75291),
		31518,
		10,
		1021,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		},
		[22] = 2
	},
	[31518011] = {
		31518011,
		0,
		Lang.get(75292),
		31518,
		11,
		160,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[31518012] = {
		31518012,
		0,
		Lang.get(75293),
		31518,
		12,
		160,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[31518013] = {
		31518013,
		0,
		Lang.get(75294),
		31518,
		13,
		1020,
		{
			RTResTalkAction[41],
			RTResTalkAction[43],
			RTResTalkAction[44]
		}
	},
	[31518014] = {
		31518014,
		0,
		Lang.get(75295),
		31518,
		14,
		1020,
		{
			RTResTalkAction[41],
			RTResTalkAction[45]
		}
	},
	[31519001] = {
		31519001,
		0,
		Lang.get(75296),
		31519,
		1,
		215,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		31519,
		nil,
		nil,
		nil,
		nil,
		nil,
		31519,
		nil,
		nil,
		3
	},
	[31519002] = {
		31519002,
		0,
		Lang.get(75297),
		31519,
		2,
		225,
		nil,
		1
	},
	[31519003] = {
		31519003,
		0,
		Lang.get(75298),
		31519,
		3,
		151,
		nil,
		1
	},
	[31519004] = {
		31519004,
		0,
		Lang.get(75299),
		31519,
		4,
		287,
		nil,
		1
	},
	[31519005] = {
		31519005,
		0,
		Lang.get(75300),
		31519,
		5,
		160,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		31520,
		nil,
		nil,
		nil,
		nil,
		nil,
		31520,
		nil,
		nil,
		4
	},
	[31519006] = {
		31519006,
		0,
		Lang.get(75301),
		31519,
		6,
		1020,
		nil,
		1,
		1
	},
	[31519007] = {
		31519007,
		0,
		Lang.get(75302),
		31519,
		7,
		225,
		{
			RTResTalkAction[31]
		},
		nil,
		0,
		3
	},
	[31519008] = {
		31519008,
		0,
		Lang.get(75303),
		31519,
		8,
		1020,
		{
			RTResTalkAction[46],
			RTResTalkAction[32]
		}
	},
	[31519009] = {
		31519009,
		0,
		Lang.get(75304),
		31519,
		9,
		215,
		{
			RTResTalkAction[12],
			RTResTalkAction[47]
		},
		[22] = 5
	},
	[31521001] = {
		31521001,
		0,
		Lang.get(75305),
		31521,
		1,
		151,
		nil,
		1,
		0,
		nil,
		nil,
		63,
		31521,
		nil,
		nil,
		nil,
		nil,
		nil,
		31521
	},
	[31521002] = {
		31521002,
		5,
		Lang.get(75306),
		31521,
		2,
		215,
		nil,
		1,
		1
	},
	[31521003] = {
		31521003,
		0,
		Lang.get(75307),
		31521,
		3,
		151,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		3
	},
	[31522001] = {
		31522001,
		0,
		Lang.get(75308),
		31522,
		1,
		1020,
		nil,
		1,
		0,
		nil,
		nil,
		63,
		31522,
		nil,
		nil,
		nil,
		nil,
		nil,
		31522
	},
	[31522002] = {
		31522002,
		0,
		Lang.get(75309),
		31522,
		2,
		188,
		nil,
		1
	},
	[31522003] = {
		31522003,
		0,
		Lang.get(75310),
		31522,
		3,
		1020,
		{
			RTResTalkAction[48]
		}
	},
	[31522004] = {
		31522004,
		0,
		Lang.get(75311),
		31522,
		4,
		188,
		{
			RTResTalkAction[49],
			RTResTalkAction[47]
		}
	},
	[31522005] = {
		31522005,
		0,
		Lang.get(75312),
		31522,
		5,
		1020,
		{
			RTResTalkAction[46],
			RTResTalkAction[50]
		}
	},
	[31522006] = {
		31522006,
		0,
		Lang.get(75313),
		31522,
		6,
		220,
		{
			RTResTalkAction[47]
		},
		1,
		nil,
		nil,
		nil,
		63,
		31523,
		nil,
		nil,
		nil,
		nil,
		nil,
		31523
	},
	[31522007] = {
		31522007,
		0,
		Lang.get(75314),
		31522,
		7,
		215,
		nil,
		1,
		1
	},
	[31522008] = {
		31522008,
		0,
		Lang.get(75315),
		31522,
		8,
		225,
		nil,
		1,
		0
	},
	[31522009] = {
		31522009,
		0,
		Lang.get(75316),
		31522,
		9,
		287,
		nil,
		1
	},
	[31522010] = {
		31522010,
		5,
		Lang.get(75317),
		31522,
		10,
		1020,
		{
			RTResTalkAction[48]
		},
		nil,
		nil,
		3
	},
	[31522011] = {
		31522011,
		0,
		Lang.get(75318),
		31522,
		11,
		215,
		{
			RTResTalkAction[17],
			RTResTalkAction[47]
		}
	},
	[31522012] = {
		31522012,
		5,
		Lang.get(75319),
		31522,
		12,
		215,
		{
			RTResTalkAction[6]
		},
		[22] = 1
	},
	[31522013] = {
		31522013,
		0,
		Lang.get(75320),
		31522,
		13,
		220,
		{
			RTResTalkAction[10]
		}
	},
	[31522014] = {
		31522014,
		0,
		Lang.get(75321),
		31522,
		14,
		188,
		{
			RTResTalkAction[49],
			RTResTalkAction[7]
		}
	},
	[31522015] = {
		31522015,
		0,
		Lang.get(75322),
		31522,
		15,
		225,
		{
			RTResTalkAction[31],
			RTResTalkAction[50]
		}
	},
	[31522016] = {
		31522016,
		0,
		Lang.get(75323),
		31522,
		16,
		188,
		{
			RTResTalkAction[49],
			RTResTalkAction[32]
		}
	},
	[31522017] = {
		31522017,
		0,
		Lang.get(75324),
		31522,
		17,
		225,
		{
			RTResTalkAction[31],
			RTResTalkAction[50]
		}
	},
	[31522018] = {
		31522018,
		0,
		Lang.get(75325),
		31522,
		18,
		225,
		{
			RTResTalkAction[31]
		}
	},
	[31522019] = {
		31522019,
		5,
		Lang.get(75326),
		31522,
		19,
		287,
		{
			RTResTalkAction[34],
			RTResTalkAction[32]
		}
	},
	[31522020] = {
		31522020,
		0,
		Lang.get(75327),
		31522,
		20,
		215,
		{
			RTResTalkAction[17],
			RTResTalkAction[35]
		}
	},
	[31522021] = {
		31522021,
		0,
		Lang.get(75328),
		31522,
		21,
		1020,
		{
			RTResTalkAction[48],
			RTResTalkAction[6]
		}
	},
	[31522022] = {
		31522022,
		0,
		Lang.get(75329),
		31522,
		22,
		215,
		{
			RTResTalkAction[12],
			RTResTalkAction[47]
		}
	},
	[31524001] = {
		31524001,
		0,
		Lang.get(75330),
		31524,
		1,
		1020,
		nil,
		1,
		1,
		nil,
		nil,
		63,
		31524,
		nil,
		nil,
		nil,
		nil,
		nil,
		31524
	},
	[31524002] = {
		31524002,
		0,
		Lang.get(75331),
		31524,
		2,
		215,
		nil,
		1,
		2
	},
	[31524003] = {
		31524003,
		0,
		Lang.get(75332),
		31524,
		3,
		188,
		nil,
		1,
		0
	},
	[31524004] = {
		31524004,
		0,
		Lang.get(75333),
		31524,
		4,
		1020,
		nil,
		1
	},
	[31524005] = {
		31524005,
		5,
		Lang.get(75334),
		31524,
		5,
		1020,
		[22] = 1
	},
	[31524006] = {
		31524006,
		0,
		Lang.get(75335),
		31524,
		6,
		215,
		{
			RTResTalkAction[36]
		},
		nil,
		nil,
		3
	},
	[31524007] = {
		31524007,
		0,
		Lang.get(75336),
		31524,
		7,
		215,
		{
			RTResTalkAction[37]
		}
	},
	[31524008] = {
		31524008,
		0,
		Lang.get(75337),
		31524,
		8,
		215,
		{
			RTResTalkAction[36]
		}
	},
	[31524009] = {
		31524009,
		0,
		Lang.get(75338),
		31524,
		9,
		215,
		{
			RTResTalkAction[37]
		}
	},
	[31524010] = {
		31524010,
		0,
		Lang.get(75339),
		31524,
		10,
		215,
		{
			RTResTalkAction[12]
		}
	},
	[31525001] = {
		31525001,
		0,
		Lang.get(75340),
		31525,
		1,
		148,
		nil,
		1,
		0,
		nil,
		nil,
		63,
		31525,
		nil,
		nil,
		nil,
		nil,
		nil,
		31525
	},
	[31525002] = {
		31525002,
		0,
		Lang.get(75341),
		31525,
		2,
		112,
		nil,
		1,
		0
	},
	[31525003] = {
		31525003,
		0,
		Lang.get(75342),
		31525,
		3,
		112,
		nil,
		1,
		1
	},
	[31525004] = {
		31525004,
		0,
		Lang.get(75343),
		31525,
		4,
		148,
		{
			RTResTalkAction[51]
		},
		nil,
		0,
		3
	},
	[31525005] = {
		31525005,
		0,
		Lang.get(75344),
		31525,
		5,
		148,
		{
			RTResTalkAction[51]
		}
	},
	[31525006] = {
		31525006,
		0,
		Lang.get(75345),
		31525,
		6,
		148,
		{
			RTResTalkAction[51]
		}
	},
	[31525007] = {
		31525007,
		0,
		Lang.get(75346),
		31525,
		7,
		112,
		{
			RTResTalkAction[5],
			RTResTalkAction[52]
		}
	},
	[31525008] = {
		31525008,
		0,
		Lang.get(75347),
		31525,
		8,
		148,
		{
			RTResTalkAction[51],
			RTResTalkAction[4]
		}
	},
	[31526001] = {
		31526001,
		0,
		Lang.get(75348),
		31526,
		1,
		220,
		nil,
		1,
		2,
		nil,
		nil,
		63,
		31526,
		nil,
		nil,
		nil,
		nil,
		nil,
		31526
	},
	[31526002] = {
		31526002,
		0,
		Lang.get(75349),
		31526,
		2,
		300
	},
	[31526003] = {
		31526003,
		0,
		Lang.get(75350),
		31526,
		3,
		300
	},
	[31526004] = {
		31526004,
		0,
		Lang.get(75351),
		31526,
		4,
		215,
		nil,
		1,
		2
	},
	[31526005] = {
		31526005,
		0,
		Lang.get(75352),
		31526,
		5,
		220,
		nil,
		1,
		2
	},
	[31526006] = {
		31526006,
		0,
		Lang.get(75353),
		31526,
		6,
		225,
		nil,
		1,
		0
	},
	[31526007] = {
		31526007,
		0,
		Lang.get(75354),
		31526,
		7,
		287,
		nil,
		1
	},
	[31526008] = {
		31526008,
		0,
		Lang.get(75355),
		31526,
		8,
		220,
		{
			RTResTalkAction[33]
		},
		nil,
		nil,
		3
	},
	[31526009] = {
		31526009,
		0,
		Lang.get(75356),
		31526,
		9,
		220,
		{
			RTResTalkAction[33]
		}
	},
	[31526010] = {
		31526010,
		0,
		Lang.get(75357),
		31526,
		10,
		225,
		{
			RTResTalkAction[53],
			RTResTalkAction[7]
		}
	},
	[31526011] = {
		31526011,
		0,
		Lang.get(75358),
		31526,
		11,
		215,
		{
			RTResTalkAction[12],
			RTResTalkAction[32]
		}
	},
	[31526012] = {
		31526012,
		0,
		Lang.get(75359),
		31526,
		12,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[31526013] = {
		31526013,
		0,
		Lang.get(75360),
		31526,
		13,
		215,
		{
			RTResTalkAction[12]
		}
	},
	[31526014] = {
		31526014,
		0,
		Lang.get(75361),
		31526,
		14,
		225,
		{
			RTResTalkAction[31],
			RTResTalkAction[6]
		}
	},
	[31526015] = {
		31526015,
		0,
		Lang.get(75362),
		31526,
		15,
		300,
		{
			RTResTalkAction[32]
		}
	},
	[31527001] = {
		31527001,
		0,
		Lang.get(75363),
		31527,
		1,
		300,
		{
			RTResTalkAction[54]
		},
		nil,
		nil,
		nil,
		nil,
		63,
		31526,
		nil,
		nil,
		nil,
		nil,
		nil,
		31526,
		nil,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		2
	},
	[31527002] = {
		31527002,
		13,
		Lang.get(75364),
		31527,
		2,
		365,
		{
			RTResTalkAction[55],
			RTResTalkAction[56]
		},
		[27] = 3
	},
	[31527003] = {
		31527003,
		0,
		".......",
		31527,
		3,
		220,
		{
			RTResTalkAction[57]
		},
		1,
		2
	},
	[31527004] = {
		31527004,
		0,
		".......",
		31527,
		4,
		215,
		nil,
		1,
		2
	},
	[31527005] = {
		31527005,
		13,
		Lang.get(75365),
		31527,
		5,
		365,
		{
			RTResTalkAction[55]
		},
		[27] = 3
	},
	[31527006] = {
		31527006,
		0,
		Lang.get(75366),
		31527,
		6,
		225,
		{
			RTResTalkAction[31],
			RTResTalkAction[57]
		},
		nil,
		nil,
		3
	},
	[31527007] = {
		31527007,
		13,
		Lang.get(75367),
		31527,
		7,
		365,
		{
			RTResTalkAction[58],
			RTResTalkAction[32]
		},
		[27] = 3
	},
	[31527008] = {
		31527008,
		0,
		Lang.get(75368),
		31527,
		8,
		225,
		{
			RTResTalkAction[31],
			RTResTalkAction[57]
		}
	},
	[31527009] = {
		31527009,
		0,
		Lang.get(75369),
		31527,
		9,
		220,
		{
			RTResTalkAction[33],
			RTResTalkAction[32]
		}
	},
	[31527010] = {
		31527010,
		0,
		Lang.get(75370),
		31527,
		10,
		225,
		{
			RTResTalkAction[53],
			RTResTalkAction[7]
		}
	},
	[31527011] = {
		31527011,
		13,
		Lang.get(75371),
		31527,
		11,
		365,
		{
			RTResTalkAction[59],
			RTResTalkAction[32]
		},
		[27] = 3
	},
	[31527012] = {
		31527012,
		4,
		nil,
		31527,
		12,
		300,
		{
			RTResTalkAction[57]
		},
		[29] = {
			{
				id = 31527013,
				branch_content = Lang.get(13442)
			},
			{
				id = 31527013,
				branch_content = Lang.get(75372)
			}
		}
	},
	[31527013] = {
		31527013,
		13,
		Lang.get(75373),
		31527,
		13,
		365,
		{
			RTResTalkAction[60]
		},
		[27] = 3
	},
	[31527014] = {
		31527014,
		13,
		Lang.get(75374),
		31527,
		14,
		365,
		{
			RTResTalkAction[55]
		},
		[27] = 3
	},
	[31527015] = {
		31527015,
		13,
		Lang.get(75375),
		31527,
		15,
		365,
		{
			RTResTalkAction[55]
		},
		[27] = 3
	},
	[31528001] = {
		31528001,
		0,
		Lang.get(75376),
		31528,
		1,
		225,
		nil,
		1,
		0,
		nil,
		nil,
		63,
		31528,
		nil,
		nil,
		nil,
		nil,
		nil,
		31528
	},
	[31528002] = {
		31528002,
		13,
		Lang.get(75377),
		31528,
		2,
		365,
		{
			RTResTalkAction[55]
		},
		[27] = 3
	},
	[31528003] = {
		31528003,
		13,
		Lang.get(75378),
		31528,
		3,
		365,
		{
			RTResTalkAction[55]
		},
		[27] = 3
	},
	[31528004] = {
		31528004,
		0,
		Lang.get(75379),
		31528,
		4,
		215,
		{
			RTResTalkAction[8],
			RTResTalkAction[3],
			RTResTalkAction[57]
		},
		nil,
		nil,
		3
	},
	[31528005] = {
		31528005,
		0,
		Lang.get(75380),
		31528,
		5,
		220,
		{
			RTResTalkAction[1],
			RTResTalkAction[9]
		}
	},
	[31528006] = {
		31528006,
		0,
		Lang.get(75381),
		31528,
		6,
		220,
		{
			RTResTalkAction[1],
			RTResTalkAction[9]
		}
	},
	[31528007] = {
		31528007,
		0,
		Lang.get(75382),
		31528,
		7,
		220,
		{
			RTResTalkAction[1],
			RTResTalkAction[9]
		}
	},
	[31528008] = {
		31528008,
		0,
		Lang.get(75383),
		31528,
		8,
		215,
		{
			RTResTalkAction[13],
			RTResTalkAction[3]
		}
	},
	[31528009] = {
		31528009,
		13,
		Lang.get(75384),
		31528,
		9,
		365,
		{
			RTResTalkAction[61],
			RTResTalkAction[6],
			RTResTalkAction[7]
		},
		[27] = 3
	},
	[31528010] = {
		31528010,
		0,
		Lang.get(75385),
		31528,
		10,
		215,
		{
			RTResTalkAction[36],
			RTResTalkAction[57]
		}
	},
	[31528011] = {
		31528011,
		0,
		Lang.get(18700),
		31528,
		11,
		300,
		{
			RTResTalkAction[17]
		}
	},
	[31528012] = {
		31528012,
		0,
		Lang.get(75386),
		31528,
		12,
		215,
		{
			RTResTalkAction[37]
		}
	},
	[31528013] = {
		31528013,
		0,
		Lang.get(75387),
		31528,
		13,
		300,
		{
			RTResTalkAction[17]
		}
	},
	[31528014] = {
		31528014,
		0,
		Lang.get(75388),
		31528,
		14,
		215,
		{
			RTResTalkAction[17]
		}
	},
	[31528015] = {
		31528015,
		5,
		Lang.get(75389),
		31528,
		15,
		300,
		{
			RTResTalkAction[17]
		}
	},
	[31528016] = {
		31528016,
		13,
		Lang.get(75390),
		31528,
		16,
		365,
		{
			RTResTalkAction[60],
			RTResTalkAction[6]
		},
		[27] = 3
	},
	[31528017] = {
		31528017,
		13,
		Lang.get(75391),
		31528,
		17,
		365,
		{
			RTResTalkAction[60]
		},
		[27] = 3
	},
	[31528018] = {
		31528018,
		0,
		Lang.get(75392),
		31528,
		18,
		300,
		{
			RTResTalkAction[55]
		},
		[27] = 3
	},
	[31529001] = {
		31529001,
		0,
		Lang.get(75393),
		31529,
		1,
		215,
		nil,
		1,
		1,
		nil,
		nil,
		63,
		31529,
		nil,
		nil,
		nil,
		nil,
		nil,
		31529
	},
	[31529002] = {
		31529002,
		0,
		Lang.get(75394),
		31529,
		2,
		215,
		nil,
		1,
		1
	},
	[31529003] = {
		31529003,
		13,
		Lang.get(75395),
		31529,
		3,
		365,
		{
			RTResTalkAction[55]
		},
		[27] = 3
	},
	[31529004] = {
		31529004,
		13,
		Lang.get(75396),
		31529,
		4,
		365,
		{
			RTResTalkAction[55]
		},
		[27] = 3
	},
	[31529005] = {
		31529005,
		0,
		Lang.get(75397),
		31529,
		5,
		220,
		{
			RTResTalkAction[57]
		},
		1,
		0
	},
	[31529006] = {
		31529006,
		0,
		Lang.get(75398),
		31529,
		6,
		160,
		{
			RTResTalkAction[38]
		},
		nil,
		nil,
		3
	},
	[31529007] = {
		31529007,
		0,
		Lang.get(75399),
		31529,
		7,
		220,
		{
			RTResTalkAction[41],
			RTResTalkAction[3]
		}
	},
	[31529008] = {
		31529008,
		0,
		Lang.get(75400),
		31529,
		8,
		215,
		{
			RTResTalkAction[36],
			RTResTalkAction[39],
			RTResTalkAction[7]
		}
	},
	[31529009] = {
		31529009,
		13,
		Lang.get(75401),
		31529,
		9,
		365,
		{
			RTResTalkAction[60],
			RTResTalkAction[6]
		},
		[27] = 3
	},
	[31529010] = {
		31529010,
		0,
		Lang.get(75402),
		31529,
		10,
		215,
		{
			RTResTalkAction[17],
			RTResTalkAction[57]
		}
	},
	[31529011] = {
		31529011,
		13,
		Lang.get(75403),
		31529,
		11,
		365,
		{
			RTResTalkAction[59],
			RTResTalkAction[6]
		},
		[27] = 3
	},
	[31529012] = {
		31529012,
		0,
		Lang.get(75404),
		31529,
		12,
		215,
		{
			RTResTalkAction[36],
			RTResTalkAction[57]
		}
	},
	[31529013] = {
		31529013,
		0,
		Lang.get(75405),
		31529,
		13,
		215,
		{
			RTResTalkAction[37]
		}
	},
	[31529014] = {
		31529014,
		0,
		Lang.get(75406),
		31529,
		14,
		160,
		{
			RTResTalkAction[38],
			RTResTalkAction[6]
		}
	},
	[31529015] = {
		31529015,
		0,
		Lang.get(75407),
		31529,
		15,
		160,
		{
			RTResTalkAction[38]
		}
	},
	[31529016] = {
		31529016,
		0,
		Lang.get(75408),
		31529,
		16,
		160,
		{
			RTResTalkAction[38]
		}
	},
	[31529017] = {
		31529017,
		5,
		Lang.get(75409),
		31529,
		17,
		160,
		{
			RTResTalkAction[38]
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
