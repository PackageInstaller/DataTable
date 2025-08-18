-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\blackrock\\ResTalk.lua

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
	[2] = 103
}
RTResTalkAction[2] = {
	[1] = 0,
	[2] = 103
}
RTResTalkAction[3] = {
	[1] = 2,
	[2] = 135
}
RTResTalkAction[4] = {
	[1] = 3,
	[2] = 103
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 135
}
RTResTalkAction[6] = {
	[1] = 1,
	[2] = 135
}
RTResTalkAction[7] = {
	[1] = 1,
	[2] = 1038
}
RTResTalkAction[8] = {
	1,
	103,
	nil,
	nil,
	1
}
RTResTalkAction[9] = {
	[1] = 0,
	[2] = 1038
}
RTResTalkAction[10] = {
	[1] = 2,
	[2] = 1038
}
RTResTalkAction[11] = {
	3,
	103,
	nil,
	nil,
	0
}
RTResTalkAction[12] = {
	1,
	1029,
	nil,
	nil,
	1
}
RTResTalkAction[13] = {
	[1] = 2,
	[2] = 1031
}
RTResTalkAction[14] = {
	3,
	1029,
	nil,
	nil,
	1
}
RTResTalkAction[15] = {
	[1] = 3,
	[2] = 1029
}
RTResTalkAction[16] = {
	[1] = 2,
	[2] = 103
}
RTResTalkAction[17] = {
	[1] = 0,
	[2] = 1031
}
RTResTalkAction[18] = {
	[1] = 3,
	[2] = 1031
}
RTResTalkAction[19] = {
	[1] = 0,
	[2] = 1029
}
RTResTalkAction[20] = {
	[1] = 1,
	[2] = 1031
}
RTResTalkAction[21] = {
	3,
	1029,
	nil,
	nil,
	2
}
RTResTalkAction[22] = {
	1,
	1031,
	nil,
	nil,
	0
}
RTResTalkAction[23] = {
	[1] = 1,
	[2] = 664
}
RTResTalkAction[24] = {
	[1] = 2,
	[2] = 664
}
RTResTalkAction[25] = {
	[1] = 3,
	[2] = 296
}
RTResTalkAction[26] = {
	[1] = 1,
	[2] = 1029
}
RTResTalkAction[27] = {
	[1] = 0,
	[2] = 664
}
RTResTalkAction[28] = {
	[1] = 0,
	[2] = 296
}
RTResTalkAction[29] = {
	[1] = 1,
	[2] = 123
}
RTResTalkAction[30] = {
	[1] = 2,
	[2] = 123
}
RTResTalkAction[31] = {
	[1] = 1,
	[2] = 220
}
RTResTalkAction[32] = {
	[1] = 0,
	[2] = 123
}
RTResTalkAction[33] = {
	[1] = 0,
	[2] = 220
}
RTResTalkAction[34] = {
	[1] = 2,
	[2] = 220
}
RTResTalkAction[35] = {
	[1] = 3,
	[2] = 664
}
RTResTalkAction[36] = {
	[1] = 3,
	[2] = 123
}
RTResTalkAction[37] = {
	[1] = 1,
	[2] = 1035
}
RTResTalkAction[38] = {
	[1] = 2,
	[2] = 1035
}
RTResTalkAction[39] = {
	[1] = 0,
	[2] = 1035
}
RTResTalkAction[40] = {
	[1] = 1,
	[2] = 1034
}
RTResTalkAction[41] = {
	2,
	220,
	nil,
	nil,
	0
}
RTResTalkAction[42] = {
	[1] = 1,
	[2] = 296
}
RTResTalkAction[43] = {
	3,
	103,
	nil,
	nil,
	1
}
RTResTalkAction[44] = {
	2,
	103,
	nil,
	nil,
	1
}
RTResTalkAction[45] = {
	[1] = 3,
	[2] = 135
}
RTResTalkAction[46] = {
	[1] = 1,
	[2] = 1040
}
RTResTalkAction[47] = {
	[1] = 0,
	[2] = 1040
}
RTResTalkAction[48] = {
	[1] = 3,
	[2] = 220
}
RTResTalkAction[49] = {
	[1] = 3,
	[2] = 1040
}
RTResTalkAction[50] = {
	[1] = 2,
	[2] = 1032
}
RTResTalkAction[51] = {
	[1] = 3,
	[2] = 1030
}
RTResTalkAction[52] = {
	[1] = 0,
	[2] = 1032
}
RTResTalkAction[53] = {
	[1] = 0,
	[2] = 1030
}
RTResTalkAction[54] = {
	[1] = 3,
	[2] = 1032
}
RTResTalkAction[55] = {
	[1] = 2,
	[2] = 1030
}
RTResTalkAction[56] = {
	[1] = 1,
	[2] = 1030
}
RTResTalkAction[57] = {
	[1] = 1,
	[2] = 1032
}
RTResTalkAction[58] = {
	[1] = 1,
	[2] = 1033
}
RTResTalkAction[59] = {
	[1] = 0,
	[2] = 1033
}
RTResTalkAction[60] = {
	[1] = 2,
	[2] = 1039
}

local Data = {
	[32010001] = {
		32010001,
		0,
		Lang.get(79451),
		32010,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		32010,
		[19] = 32010
	},
	[32010002] = {
		32010002,
		0,
		Lang.get(79452),
		32010,
		2,
		135,
		nil,
		1
	},
	[32010003] = {
		32010003,
		0,
		Lang.get(79453),
		32010,
		3,
		135,
		nil,
		1
	},
	[32010004] = {
		32010004,
		3,
		Lang.get(79454),
		32010,
		4,
		605,
		nil,
		nil,
		nil,
		3,
		[22] = 1
	},
	[32010005] = {
		32010005,
		0,
		Lang.get(79455),
		32010,
		5,
		103,
		{
			RTResTalkAction[1]
		}
	},
	[32010006] = {
		32010006,
		4,
		nil,
		32010,
		6,
		103,
		{
			RTResTalkAction[1]
		},
		[29] = {
			{
				id = 32010007,
				branch_content = Lang.get(79456)
			}
		}
	},
	[32010007] = {
		32010007,
		0,
		Lang.get(79457),
		32010,
		7,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[32010008] = {
		32010008,
		0,
		Lang.get(79458),
		32010,
		8,
		103,
		{
			RTResTalkAction[1]
		}
	},
	[32010009] = {
		32010009,
		0,
		Lang.get(79459),
		32010,
		9,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[32010010] = {
		32010010,
		0,
		Lang.get(79460),
		32010,
		10,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[32010011] = {
		32010011,
		0,
		Lang.get(79461),
		32010,
		11,
		103,
		{
			RTResTalkAction[1]
		}
	},
	[32010012] = {
		32010012,
		0,
		Lang.get(79462),
		32010,
		12,
		135,
		{
			RTResTalkAction[3],
			RTResTalkAction[4]
		}
	},
	[32010013] = {
		32010013,
		0,
		Lang.get(79463),
		32010,
		13,
		300,
		{
			RTResTalkAction[3],
			RTResTalkAction[4]
		}
	},
	[32010014] = {
		32010014,
		0,
		Lang.get(79464),
		32010,
		14,
		103,
		{
			RTResTalkAction[1],
			RTResTalkAction[5]
		}
	},
	[32010015] = {
		32010015,
		0,
		Lang.get(79465),
		32010,
		15,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[32010016] = {
		32010016,
		4,
		nil,
		32010,
		16,
		300,
		{
			RTResTalkAction[1]
		},
		[29] = {
			{
				id = 32010017,
				branch_content = Lang.get(79466)
			},
			{
				id = 32010017,
				branch_content = Lang.get(79467)
			}
		}
	},
	[32010017] = {
		32010017,
		0,
		Lang.get(79468),
		32010,
		17,
		103,
		{
			RTResTalkAction[1]
		}
	},
	[32010018] = {
		32010018,
		0,
		Lang.get(79469),
		32010,
		18,
		1036,
		{
			RTResTalkAction[2]
		}
	},
	[32010019] = {
		32010019,
		0,
		Lang.get(79470),
		32010,
		19,
		1036
	},
	[32010020] = {
		32010020,
		0,
		Lang.get(79471),
		32010,
		20,
		300
	},
	[32010021] = {
		32010021,
		0,
		Lang.get(79472),
		32010,
		21,
		300
	},
	[32010022] = {
		32010022,
		4,
		nil,
		32010,
		22,
		300,
		[29] = {
			{
				id = 32010023,
				branch_content = Lang.get(79473)
			},
			{
				id = 32010023,
				branch_content = Lang.get(79474)
			}
		}
	},
	[32010023] = {
		32010023,
		0,
		Lang.get(79475),
		32010,
		23,
		103,
		{
			RTResTalkAction[1]
		}
	},
	[32010024] = {
		32010024,
		0,
		Lang.get(79476),
		32010,
		24,
		1036,
		{
			RTResTalkAction[1]
		}
	},
	[32010025] = {
		32010025,
		0,
		Lang.get(79477),
		32010,
		25,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[32010026] = {
		32010026,
		4,
		nil,
		32010,
		26,
		300,
		{
			RTResTalkAction[1]
		},
		[29] = {
			{
				id = 32010027,
				branch_content = Lang.get(79478)
			},
			{
				id = 32010027,
				branch_content = Lang.get(79479)
			}
		}
	},
	[32010027] = {
		32010027,
		0,
		Lang.get(79480),
		32010,
		27,
		135,
		{
			RTResTalkAction[6],
			RTResTalkAction[2]
		}
	},
	[32011001] = {
		32011001,
		0,
		Lang.get(79481),
		32011,
		1,
		1038,
		nil,
		1,
		nil,
		nil,
		nil,
		59,
		32011,
		nil,
		nil,
		nil,
		nil,
		nil,
		32011
	},
	[32011002] = {
		32011002,
		0,
		Lang.get(79482),
		32011,
		2,
		103,
		nil,
		1,
		1
	},
	[32011003] = {
		32011003,
		0,
		Lang.get(79483),
		32011,
		3,
		300
	},
	[32011004] = {
		32011004,
		0,
		Lang.get(79484),
		32011,
		4,
		103,
		nil,
		1,
		1
	},
	[32011005] = {
		32011005,
		0,
		Lang.get(79485),
		32011,
		5,
		1038,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3
	},
	[32011006] = {
		32011006,
		0,
		Lang.get(79486),
		32011,
		6,
		1038,
		{
			RTResTalkAction[7]
		}
	},
	[32011007] = {
		32011007,
		0,
		Lang.get(79487),
		32011,
		7,
		300,
		{
			RTResTalkAction[7]
		}
	},
	[32011008] = {
		32011008,
		0,
		Lang.get(79488),
		32011,
		8,
		103,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[32011009] = {
		32011009,
		0,
		Lang.get(79489),
		32011,
		9,
		103,
		{
			RTResTalkAction[8]
		}
	},
	[32011010] = {
		32011010,
		0,
		Lang.get(79490),
		32011,
		10,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[32011011] = {
		32011011,
		0,
		Lang.get(79491),
		32011,
		11,
		103,
		{
			RTResTalkAction[8]
		}
	},
	[32011012] = {
		32011012,
		0,
		Lang.get(79492),
		32011,
		12,
		1038,
		{
			RTResTalkAction[10],
			RTResTalkAction[4]
		}
	},
	[32011013] = {
		32011013,
		0,
		Lang.get(79493),
		32011,
		13,
		103,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		},
		nil,
		nil,
		nil,
		nil,
		60
	},
	[32011014] = {
		32011014,
		0,
		Lang.get(79494),
		32011,
		14,
		300,
		{
			RTResTalkAction[10],
			RTResTalkAction[4]
		}
	},
	[32011015] = {
		32011015,
		0,
		Lang.get(79495),
		32011,
		15,
		103,
		{
			RTResTalkAction[1],
			RTResTalkAction[9]
		}
	},
	[32011016] = {
		32011016,
		0,
		Lang.get(79496),
		32011,
		16,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[32011017] = {
		32011017,
		0,
		Lang.get(79497),
		32011,
		17,
		103,
		nil,
		1,
		0,
		0
	},
	[32011018] = {
		32011018,
		0,
		Lang.get(79498),
		32011,
		18,
		1038,
		{
			RTResTalkAction[10],
			RTResTalkAction[4]
		},
		nil,
		nil,
		3
	},
	[32011019] = {
		32011019,
		0,
		Lang.get(79499),
		32011,
		19,
		1038,
		{
			RTResTalkAction[10],
			RTResTalkAction[4]
		}
	},
	[32011020] = {
		32011020,
		0,
		Lang.get(80758),
		32011,
		20,
		1038,
		{
			RTResTalkAction[10],
			RTResTalkAction[4]
		}
	},
	[32011021] = {
		32011021,
		0,
		Lang.get(79501),
		32011,
		21,
		103,
		{
			RTResTalkAction[10],
			RTResTalkAction[4]
		}
	},
	[32011022] = {
		32011022,
		0,
		Lang.get(79502),
		32011,
		22,
		1038,
		{
			RTResTalkAction[10],
			RTResTalkAction[4]
		}
	},
	[32011023] = {
		32011023,
		0,
		Lang.get(79503),
		32011,
		23,
		1038,
		{
			RTResTalkAction[10],
			RTResTalkAction[4]
		}
	},
	[32011024] = {
		32011024,
		0,
		Lang.get(79504),
		32011,
		24,
		1038,
		{
			RTResTalkAction[10],
			RTResTalkAction[4]
		}
	},
	[32011025] = {
		32011025,
		0,
		Lang.get(79505),
		32011,
		25,
		103,
		{
			RTResTalkAction[9],
			RTResTalkAction[2]
		},
		1
	},
	[32011026] = {
		32011026,
		0,
		Lang.get(79506),
		32011,
		26,
		1029,
		nil,
		1,
		1,
		nil,
		nil,
		63,
		32030,
		nil,
		nil,
		nil,
		1,
		nil,
		32030
	},
	[32011027] = {
		32011027,
		7,
		"92",
		32011,
		27,
		1029
	},
	[32011028] = {
		32011028,
		0,
		Lang.get(79507),
		32011,
		28,
		1031,
		nil,
		1
	},
	[32011029] = {
		32011029,
		7,
		"93",
		32011,
		29,
		1031
	},
	[32011030] = {
		32011030,
		0,
		Lang.get(79508),
		32011,
		30,
		1029,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		3
	},
	[32012001] = {
		32012001,
		0,
		Lang.get(79509),
		32012,
		1,
		103,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		32012,
		nil,
		nil,
		nil,
		nil,
		nil,
		32012
	},
	[32012002] = {
		32012002,
		0,
		Lang.get(79510),
		32012,
		2,
		135,
		nil,
		1
	},
	[32012003] = {
		32012003,
		0,
		Lang.get(79511),
		32012,
		3,
		1038,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3
	},
	[32012004] = {
		32012004,
		0,
		Lang.get(79512),
		32012,
		4,
		135,
		{
			RTResTalkAction[6],
			RTResTalkAction[9]
		}
	},
	[32012005] = {
		32012005,
		0,
		Lang.get(79513),
		32012,
		5,
		103,
		{
			RTResTalkAction[3],
			RTResTalkAction[4]
		}
	},
	[32012006] = {
		32012006,
		0,
		Lang.get(79514),
		32012,
		6,
		135,
		{
			RTResTalkAction[3],
			RTResTalkAction[4]
		}
	},
	[32012007] = {
		32012007,
		0,
		Lang.get(79515),
		32012,
		7,
		103,
		{
			RTResTalkAction[3],
			RTResTalkAction[4]
		}
	},
	[32012008] = {
		32012008,
		0,
		Lang.get(79516),
		32012,
		8,
		300,
		{
			RTResTalkAction[1],
			RTResTalkAction[5]
		}
	},
	[32012009] = {
		32012009,
		0,
		Lang.get(79517),
		32012,
		9,
		103,
		{
			RTResTalkAction[1]
		}
	},
	[32012010] = {
		32012010,
		0,
		Lang.get(79518),
		32012,
		10,
		103,
		{
			RTResTalkAction[1]
		}
	},
	[32012011] = {
		32012011,
		0,
		Lang.get(79519),
		32012,
		11,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[32012012] = {
		32012012,
		0,
		Lang.get(79520),
		32012,
		12,
		1038,
		{
			RTResTalkAction[7]
		}
	},
	[32012013] = {
		32012013,
		0,
		Lang.get(79521),
		32012,
		13,
		135,
		{
			RTResTalkAction[6],
			RTResTalkAction[9]
		}
	},
	[32012014] = {
		32012014,
		0,
		Lang.get(79522),
		32012,
		14,
		1038,
		{
			RTResTalkAction[7],
			RTResTalkAction[5]
		}
	},
	[32012015] = {
		32012015,
		0,
		Lang.get(79523),
		32012,
		15,
		1038,
		{
			RTResTalkAction[7]
		}
	},
	[32012016] = {
		32012016,
		0,
		Lang.get(79524),
		32012,
		16,
		300,
		{
			RTResTalkAction[7]
		}
	},
	[32012017] = {
		32012017,
		0,
		Lang.get(79525),
		32012,
		17,
		1038,
		{
			RTResTalkAction[7]
		}
	},
	[32012018] = {
		32012018,
		0,
		Lang.get(79526),
		32012,
		18,
		103,
		{
			RTResTalkAction[10],
			RTResTalkAction[4]
		}
	},
	[32012019] = {
		32012019,
		0,
		Lang.get(79527),
		32012,
		19,
		1036,
		{
			RTResTalkAction[9],
			RTResTalkAction[2]
		}
	},
	[32012020] = {
		32012020,
		0,
		Lang.get(79528),
		32012,
		20,
		1038,
		{
			RTResTalkAction[7]
		}
	},
	[32012021] = {
		32012021,
		5,
		Lang.get(79529),
		32012,
		21,
		605,
		{
			RTResTalkAction[9]
		},
		[22] = 1
	},
	[32012022] = {
		32012022,
		0,
		Lang.get(79530),
		32012,
		22,
		1036
	},
	[32013001] = {
		32013001,
		0,
		Lang.get(79531),
		32013,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		32013,
		[19] = 32013
	},
	[32013002] = {
		32013002,
		0,
		Lang.get(79532),
		32013,
		2,
		1031,
		nil,
		1
	},
	[32013003] = {
		32013003,
		0,
		Lang.get(79533),
		32013,
		3,
		300
	},
	[32013004] = {
		32013004,
		0,
		Lang.get(79534),
		32013,
		4,
		103,
		nil,
		1,
		1
	},
	[32013005] = {
		32013005,
		0,
		Lang.get(79535),
		32013,
		5,
		1029,
		{
			RTResTalkAction[13],
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[32013006] = {
		32013006,
		0,
		Lang.get(79536),
		32013,
		6,
		1031,
		{
			RTResTalkAction[13],
			RTResTalkAction[15]
		}
	},
	[32013007] = {
		32013007,
		0,
		Lang.get(79537),
		32013,
		7,
		300,
		{
			RTResTalkAction[13],
			RTResTalkAction[15]
		}
	},
	[32013008] = {
		32013008,
		0,
		Lang.get(79538),
		32013,
		8,
		1029,
		{
			RTResTalkAction[13],
			RTResTalkAction[15]
		}
	},
	[32013009] = {
		32013009,
		0,
		Lang.get(79539),
		32013,
		9,
		1031,
		{
			RTResTalkAction[13],
			RTResTalkAction[15]
		}
	},
	[32013010] = {
		32013010,
		4,
		nil,
		32013,
		10,
		1031,
		{
			RTResTalkAction[13],
			RTResTalkAction[15]
		},
		[29] = {
			{
				id = 32013011,
				branch_content = Lang.get(79540)
			},
			{
				id = 32013011,
				branch_content = Lang.get(79541)
			}
		}
	},
	[32013011] = {
		32013011,
		0,
		Lang.get(79542),
		32013,
		11,
		1031,
		{
			RTResTalkAction[13],
			RTResTalkAction[15]
		}
	},
	[32013012] = {
		32013012,
		0,
		Lang.get(79543),
		32013,
		12,
		1029,
		{
			RTResTalkAction[13],
			RTResTalkAction[15]
		}
	},
	[32013013] = {
		32013013,
		0,
		Lang.get(79544),
		32013,
		13,
		103,
		{
			RTResTalkAction[16],
			RTResTalkAction[15],
			RTResTalkAction[17]
		}
	},
	[32013014] = {
		32013014,
		0,
		Lang.get(79545),
		32013,
		14,
		1029,
		{
			RTResTalkAction[16],
			RTResTalkAction[15]
		}
	},
	[32013015] = {
		32013015,
		0,
		Lang.get(79546),
		32013,
		15,
		103,
		{
			RTResTalkAction[16],
			RTResTalkAction[15]
		}
	},
	[32013016] = {
		32013016,
		0,
		Lang.get(79547),
		32013,
		16,
		1031,
		{
			RTResTalkAction[16],
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[32013017] = {
		32013017,
		0,
		Lang.get(79548),
		32013,
		17,
		103,
		{
			RTResTalkAction[1],
			RTResTalkAction[17]
		}
	},
	[32014001] = {
		32014001,
		0,
		Lang.get(79549),
		32014,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		32013,
		[19] = 32013
	},
	[32014002] = {
		32014002,
		0,
		Lang.get(79550),
		32014,
		2,
		1031,
		nil,
		1
	},
	[32014003] = {
		32014003,
		0,
		Lang.get(79551),
		32014,
		3,
		300
	},
	[32014004] = {
		32014004,
		0,
		Lang.get(79552),
		32014,
		4,
		1031,
		nil,
		1
	},
	[32014005] = {
		32014005,
		0,
		Lang.get(79553),
		32014,
		5,
		103,
		nil,
		1
	},
	[32014006] = {
		32014006,
		0,
		Lang.get(79554),
		32014,
		6,
		1038,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3
	},
	[32014007] = {
		32014007,
		0,
		Lang.get(79555),
		32014,
		7,
		1031,
		{
			RTResTalkAction[20],
			RTResTalkAction[9]
		}
	},
	[32014008] = {
		32014008,
		0,
		Lang.get(79556),
		32014,
		8,
		1029,
		{
			RTResTalkAction[17]
		},
		1,
		1
	},
	[32014009] = {
		32014009,
		0,
		Lang.get(79557),
		32014,
		9,
		1029,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		32030,
		nil,
		nil,
		nil,
		1,
		nil,
		32030
	},
	[32014010] = {
		32014010,
		0,
		Lang.get(79558),
		32014,
		10,
		1031,
		nil,
		1
	},
	[32014011] = {
		32014011,
		0,
		Lang.get(79559),
		32014,
		11,
		1029,
		nil,
		1
	},
	[32014012] = {
		32014012,
		0,
		Lang.get(79560),
		32014,
		12,
		1029,
		nil,
		1
	},
	[32014013] = {
		32014013,
		0,
		Lang.get(79561),
		32014,
		13,
		1031,
		{
			RTResTalkAction[13],
			RTResTalkAction[15]
		},
		nil,
		nil,
		3
	},
	[32014014] = {
		32014014,
		0,
		Lang.get(79562),
		32014,
		14,
		1031,
		{
			RTResTalkAction[13],
			RTResTalkAction[15]
		}
	},
	[32014015] = {
		32014015,
		0,
		Lang.get(79563),
		32014,
		15,
		1029,
		{
			RTResTalkAction[13],
			RTResTalkAction[15]
		}
	},
	[32014016] = {
		32014016,
		0,
		Lang.get(79564),
		32014,
		16,
		1029,
		{
			RTResTalkAction[13],
			RTResTalkAction[15]
		}
	},
	[32014017] = {
		32014017,
		0,
		Lang.get(79565),
		32014,
		17,
		1029,
		{
			RTResTalkAction[13],
			RTResTalkAction[21]
		}
	},
	[32014018] = {
		32014018,
		0,
		Lang.get(79566),
		32014,
		18,
		1031,
		{
			RTResTalkAction[22],
			RTResTalkAction[19]
		}
	},
	[32015001] = {
		32015001,
		0,
		Lang.get(79567),
		32015,
		1,
		1031,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		32015,
		nil,
		nil,
		nil,
		nil,
		nil,
		32015
	},
	[32015002] = {
		32015002,
		0,
		Lang.get(79568),
		32015,
		2,
		1029,
		nil,
		1,
		1
	},
	[32015003] = {
		32015003,
		0,
		Lang.get(79569),
		32015,
		3,
		1031,
		nil,
		1
	},
	[32015004] = {
		32015004,
		0,
		Lang.get(79570),
		32015,
		4,
		1029,
		nil,
		1,
		1
	},
	[32015005] = {
		32015005,
		0,
		Lang.get(79571),
		32015,
		5,
		1031,
		nil,
		1
	},
	[32015006] = {
		32015006,
		0,
		Lang.get(79572),
		32015,
		6,
		1029,
		{
			RTResTalkAction[13],
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[32015007] = {
		32015007,
		0,
		Lang.get(79573),
		32015,
		7,
		1031,
		{
			RTResTalkAction[13],
			RTResTalkAction[15]
		}
	},
	[32015008] = {
		32015008,
		0,
		Lang.get(79574),
		32015,
		8,
		1029,
		{
			RTResTalkAction[17],
			RTResTalkAction[19]
		},
		1
	},
	[32015009] = {
		32015009,
		0,
		Lang.get(79575),
		32015,
		9,
		664,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		32033,
		[19] = 32033,
		[17] = 1
	},
	[32015010] = {
		32015010,
		0,
		Lang.get(79576),
		32015,
		10,
		296,
		{
			RTResTalkAction[24],
			RTResTalkAction[25]
		}
	},
	[32015011] = {
		32015011,
		0,
		Lang.get(79577),
		32015,
		11,
		1029,
		{
			RTResTalkAction[26],
			RTResTalkAction[27],
			RTResTalkAction[28]
		},
		nil,
		nil,
		3
	},
	[32015012] = {
		32015012,
		0,
		Lang.get(79578),
		32015,
		12,
		664,
		{
			RTResTalkAction[24],
			RTResTalkAction[25],
			RTResTalkAction[19]
		}
	},
	[32015013] = {
		32015013,
		0,
		Lang.get(79579),
		32015,
		13,
		296,
		{
			RTResTalkAction[24],
			RTResTalkAction[25]
		}
	},
	[32015014] = {
		32015014,
		0,
		Lang.get(79580),
		32015,
		14,
		1029,
		{
			RTResTalkAction[26],
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[32015015] = {
		32015015,
		0,
		Lang.get(79581),
		32015,
		15,
		1031,
		{
			RTResTalkAction[13],
			RTResTalkAction[14]
		}
	},
	[32015016] = {
		32015016,
		0,
		Lang.get(79582),
		32015,
		16,
		1029,
		{
			RTResTalkAction[13],
			RTResTalkAction[15]
		}
	},
	[32015017] = {
		32015017,
		0,
		Lang.get(79583),
		32015,
		17,
		123,
		{
			RTResTalkAction[29],
			RTResTalkAction[17],
			RTResTalkAction[19]
		}
	},
	[32016001] = {
		32016001,
		0,
		Lang.get(79584),
		32016,
		1,
		123,
		nil,
		1,
		nil,
		nil,
		nil,
		57,
		32016,
		nil,
		nil,
		nil,
		nil,
		nil,
		32016
	},
	[32016002] = {
		32016002,
		5,
		Lang.get(79585),
		32016,
		2,
		605,
		[22] = 1
	},
	[32016003] = {
		32016003,
		0,
		Lang.get(79586),
		32016,
		3,
		1029,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		3
	},
	[32016004] = {
		32016004,
		0,
		Lang.get(79587),
		32016,
		4,
		664,
		{
			RTResTalkAction[24],
			RTResTalkAction[25],
			RTResTalkAction[19]
		}
	},
	[32016005] = {
		32016005,
		0,
		Lang.get(79588),
		32016,
		5,
		296,
		{
			RTResTalkAction[24],
			RTResTalkAction[25]
		}
	},
	[32030001] = {
		32030001,
		0,
		Lang.get(79589),
		32030,
		1,
		1031,
		nil,
		1,
		nil,
		nil,
		nil,
		57,
		32016,
		nil,
		nil,
		nil,
		nil,
		nil,
		32016
	},
	[32030002] = {
		32030002,
		5,
		Lang.get(79590),
		32030,
		2,
		605,
		[22] = 1
	},
	[32030003] = {
		32030003,
		0,
		Lang.get(79591),
		32030,
		3,
		1029,
		nil,
		1,
		1
	},
	[32030004] = {
		32030004,
		0,
		Lang.get(79592),
		32030,
		4,
		123,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[32030005] = {
		32030005,
		0,
		Lang.get(79593),
		32030,
		5,
		1029,
		{
			RTResTalkAction[30],
			RTResTalkAction[15]
		}
	},
	[32030006] = {
		32030006,
		0,
		Lang.get(79594),
		32030,
		6,
		123,
		{
			RTResTalkAction[30],
			RTResTalkAction[15]
		}
	},
	[32030007] = {
		32030007,
		0,
		Lang.get(79595),
		32030,
		7,
		1029,
		{
			RTResTalkAction[30],
			RTResTalkAction[15]
		}
	},
	[32030008] = {
		32030008,
		0,
		Lang.get(79596),
		32030,
		8,
		220,
		{
			RTResTalkAction[31],
			RTResTalkAction[32],
			RTResTalkAction[19]
		}
	},
	[32030009] = {
		32030009,
		0,
		Lang.get(79597),
		32030,
		9,
		123,
		{
			RTResTalkAction[29],
			RTResTalkAction[33]
		}
	},
	[32030010] = {
		32030010,
		0,
		Lang.get(79598),
		32030,
		10,
		220,
		{
			RTResTalkAction[34],
			RTResTalkAction[15],
			RTResTalkAction[32]
		}
	},
	[32030011] = {
		32030011,
		0,
		Lang.get(79599),
		32030,
		11,
		1029,
		{
			RTResTalkAction[34],
			RTResTalkAction[15]
		}
	},
	[32030012] = {
		32030012,
		0,
		Lang.get(79600),
		32030,
		12,
		220,
		{
			RTResTalkAction[33],
			RTResTalkAction[19]
		},
		1
	},
	[32030013] = {
		32030013,
		0,
		Lang.get(79601),
		32030,
		13,
		1031,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		32017,
		nil,
		nil,
		nil,
		1,
		nil,
		32017
	},
	[32030014] = {
		32030014,
		0,
		Lang.get(79602),
		32030,
		14,
		123,
		nil,
		1
	},
	[32030015] = {
		32030015,
		0,
		Lang.get(79603),
		32030,
		15,
		1031,
		nil,
		1
	},
	[32030016] = {
		32030016,
		0,
		Lang.get(79604),
		32030,
		16,
		664,
		nil,
		1
	},
	[32030017] = {
		32030017,
		0,
		Lang.get(79605),
		32030,
		17,
		1031,
		{
			RTResTalkAction[20]
		},
		nil,
		nil,
		3
	},
	[32030018] = {
		32030018,
		0,
		Lang.get(79606),
		32030,
		18,
		664,
		{
			RTResTalkAction[13],
			RTResTalkAction[35]
		}
	},
	[32030019] = {
		32030019,
		0,
		Lang.get(79607),
		32030,
		19,
		123,
		{
			RTResTalkAction[29],
			RTResTalkAction[17],
			RTResTalkAction[27]
		}
	},
	[32030020] = {
		32030020,
		0,
		Lang.get(79608),
		32030,
		20,
		1031,
		{
			RTResTalkAction[13],
			RTResTalkAction[36]
		}
	},
	[32030021] = {
		32030021,
		0,
		Lang.get(79609),
		32030,
		21,
		1031,
		{
			RTResTalkAction[13],
			RTResTalkAction[36]
		}
	},
	[32017001] = {
		32017001,
		0,
		Lang.get(79610),
		32017,
		1,
		123,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		32017,
		nil,
		nil,
		nil,
		nil,
		nil,
		32017
	},
	[32017002] = {
		32017002,
		0,
		Lang.get(79611),
		32017,
		2,
		1031,
		nil,
		1
	},
	[32017003] = {
		32017003,
		0,
		Lang.get(79612),
		32017,
		3,
		123,
		nil,
		1
	},
	[32017004] = {
		32017004,
		0,
		Lang.get(79613),
		32017,
		4,
		1031,
		nil,
		1
	},
	[32017005] = {
		32017005,
		0,
		Lang.get(79614),
		32017,
		5,
		123,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[32017006] = {
		32017006,
		0,
		Lang.get(79615),
		32017,
		6,
		123,
		{
			RTResTalkAction[32]
		},
		1
	},
	[32017007] = {
		32017007,
		0,
		Lang.get(79616),
		32017,
		7,
		123,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		32043,
		[19] = 32043,
		[17] = 1
	},
	[32017008] = {
		32017008,
		0,
		Lang.get(79617),
		32017,
		8,
		1035,
		{
			RTResTalkAction[37]
		},
		nil,
		nil,
		3
	},
	[32017009] = {
		32017009,
		0,
		Lang.get(79618),
		32017,
		9,
		123,
		{
			RTResTalkAction[38],
			RTResTalkAction[36]
		}
	},
	[32017010] = {
		32017010,
		0,
		Lang.get(79619),
		32017,
		10,
		1035,
		{
			RTResTalkAction[38],
			RTResTalkAction[36]
		}
	},
	[32017011] = {
		32017011,
		0,
		Lang.get(79620),
		32017,
		11,
		123,
		{
			RTResTalkAction[38],
			RTResTalkAction[36]
		}
	},
	[32017012] = {
		32017012,
		0,
		Lang.get(79621),
		32017,
		12,
		123,
		{
			RTResTalkAction[38],
			RTResTalkAction[36]
		}
	},
	[32017013] = {
		32017013,
		0,
		Lang.get(79622),
		32017,
		13,
		1035,
		{
			RTResTalkAction[38],
			RTResTalkAction[36]
		}
	},
	[32017014] = {
		32017014,
		3,
		Lang.get(79623),
		32017,
		14,
		605,
		{
			RTResTalkAction[38],
			RTResTalkAction[36]
		},
		[22] = 1
	},
	[32017015] = {
		32017015,
		0,
		Lang.get(79624),
		32017,
		15,
		123,
		{
			RTResTalkAction[29],
			RTResTalkAction[39]
		}
	},
	[32017016] = {
		32017016,
		3,
		Lang.get(79625),
		32017,
		16,
		605,
		{
			RTResTalkAction[32]
		},
		[22] = 1
	},
	[32017017] = {
		32017017,
		0,
		Lang.get(79626),
		32017,
		17,
		1034,
		{
			RTResTalkAction[40]
		}
	},
	[32017018] = {
		32017018,
		0,
		Lang.get(79627),
		32017,
		18,
		1034,
		{
			RTResTalkAction[40]
		}
	},
	[32018001] = {
		32018001,
		0,
		Lang.get(79628),
		32018,
		1,
		1031,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		32017,
		nil,
		nil,
		nil,
		nil,
		nil,
		32017
	},
	[32018002] = {
		32018002,
		0,
		Lang.get(79629),
		32018,
		2,
		123,
		nil,
		1
	},
	[32018003] = {
		32018003,
		0,
		Lang.get(79630),
		32018,
		3,
		123,
		nil,
		1
	},
	[32018004] = {
		32018004,
		0,
		Lang.get(79631),
		32018,
		4,
		1031,
		nil,
		1
	},
	[32018005] = {
		32018005,
		0,
		Lang.get(79632),
		32018,
		5,
		220,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		32018,
		nil,
		nil,
		nil,
		1,
		nil,
		32018
	},
	[32018006] = {
		32018006,
		0,
		Lang.get(79633),
		32018,
		6,
		296,
		nil,
		1
	},
	[32018007] = {
		32018007,
		0,
		Lang.get(79634),
		32018,
		7,
		220,
		nil,
		1,
		2
	},
	[32018008] = {
		32018008,
		0,
		Lang.get(79635),
		32018,
		8,
		1029,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		3
	},
	[32018009] = {
		32018009,
		0,
		Lang.get(79636),
		32018,
		9,
		220,
		{
			RTResTalkAction[41],
			RTResTalkAction[15]
		}
	},
	[32018010] = {
		32018010,
		0,
		Lang.get(79637),
		32018,
		10,
		220,
		{
			RTResTalkAction[34],
			RTResTalkAction[15]
		}
	},
	[32018011] = {
		32018011,
		0,
		Lang.get(79638),
		32018,
		11,
		1029,
		{
			RTResTalkAction[34],
			RTResTalkAction[14]
		}
	},
	[32018012] = {
		32018012,
		0,
		Lang.get(79639),
		32018,
		12,
		220,
		{
			RTResTalkAction[34],
			RTResTalkAction[15]
		}
	},
	[32018013] = {
		32018013,
		0,
		Lang.get(79640),
		32018,
		13,
		1029,
		{
			RTResTalkAction[34],
			RTResTalkAction[15]
		}
	},
	[32018014] = {
		32018014,
		0,
		Lang.get(79641),
		32018,
		14,
		220,
		{
			RTResTalkAction[34],
			RTResTalkAction[15]
		}
	},
	[32018015] = {
		32018015,
		0,
		Lang.get(79642),
		32018,
		15,
		220,
		{
			RTResTalkAction[34],
			RTResTalkAction[15]
		}
	},
	[32018016] = {
		32018016,
		0,
		Lang.get(79643),
		32018,
		16,
		220,
		{
			RTResTalkAction[34],
			RTResTalkAction[15]
		}
	},
	[32018017] = {
		32018017,
		0,
		Lang.get(21987),
		32018,
		17,
		1029,
		{
			RTResTalkAction[34],
			RTResTalkAction[15]
		}
	},
	[32018018] = {
		32018018,
		0,
		Lang.get(79644),
		32018,
		18,
		220,
		{
			RTResTalkAction[34],
			RTResTalkAction[15]
		}
	},
	[32018019] = {
		32018019,
		0,
		Lang.get(79645),
		32018,
		19,
		220,
		{
			RTResTalkAction[34],
			RTResTalkAction[15]
		}
	},
	[32018020] = {
		32018020,
		0,
		Lang.get(79646),
		32018,
		20,
		296,
		{
			RTResTalkAction[42],
			RTResTalkAction[33],
			RTResTalkAction[19]
		}
	},
	[32019001] = {
		32019001,
		0,
		Lang.get(79647),
		32019,
		1,
		103,
		nil,
		1,
		nil,
		nil,
		nil,
		59,
		32019,
		nil,
		nil,
		nil,
		nil,
		nil,
		32019
	},
	[32019002] = {
		32019002,
		0,
		Lang.get(79648),
		32019,
		2,
		103,
		nil,
		1
	},
	[32019003] = {
		32019003,
		0,
		Lang.get(79649),
		32019,
		3,
		135,
		nil,
		1
	},
	[32019004] = {
		32019004,
		0,
		Lang.get(79650),
		32019,
		4,
		1038,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3
	},
	[32019005] = {
		32019005,
		0,
		Lang.get(79651),
		32019,
		5,
		135,
		{
			RTResTalkAction[6],
			RTResTalkAction[9]
		}
	},
	[32019006] = {
		32019006,
		0,
		Lang.get(79652),
		32019,
		6,
		103,
		{
			RTResTalkAction[3],
			RTResTalkAction[43]
		}
	},
	[32019007] = {
		32019007,
		0,
		Lang.get(79653),
		32019,
		7,
		135,
		{
			RTResTalkAction[3],
			RTResTalkAction[43]
		}
	},
	[32019008] = {
		32019008,
		0,
		Lang.get(79654),
		32019,
		8,
		103,
		{
			RTResTalkAction[3],
			RTResTalkAction[43]
		}
	},
	[32019009] = {
		32019009,
		0,
		Lang.get(80349),
		32019,
		9,
		135,
		{
			RTResTalkAction[3],
			RTResTalkAction[43]
		}
	},
	[32019010] = {
		32019010,
		0,
		Lang.get(79656),
		32019,
		10,
		103,
		{
			RTResTalkAction[3],
			RTResTalkAction[43]
		}
	},
	[32019011] = {
		32019011,
		0,
		Lang.get(79657),
		32019,
		11,
		103,
		{
			RTResTalkAction[3],
			RTResTalkAction[43]
		}
	},
	[32019012] = {
		32019012,
		0,
		Lang.get(79658),
		32019,
		12,
		135,
		{
			RTResTalkAction[3],
			RTResTalkAction[43]
		}
	},
	[32019013] = {
		32019013,
		0,
		Lang.get(79659),
		32019,
		13,
		103,
		{
			RTResTalkAction[3],
			RTResTalkAction[43]
		}
	},
	[32019014] = {
		32019014,
		0,
		Lang.get(79660),
		32019,
		14,
		135,
		{
			RTResTalkAction[6],
			RTResTalkAction[2]
		}
	},
	[32019015] = {
		32019015,
		0,
		Lang.get(79661),
		32019,
		15,
		300,
		{
			RTResTalkAction[5]
		}
	},
	[32019016] = {
		32019016,
		0,
		Lang.get(79662),
		32019,
		16,
		135,
		{
			RTResTalkAction[6]
		}
	},
	[32019017] = {
		32019017,
		0,
		Lang.get(79663),
		32019,
		17,
		103,
		{
			RTResTalkAction[1],
			RTResTalkAction[5]
		}
	},
	[32019018] = {
		32019018,
		5,
		Lang.get(79664),
		32019,
		18,
		605,
		{
			RTResTalkAction[1]
		},
		[22] = 1
	},
	[32019019] = {
		32019019,
		0,
		Lang.get(79665),
		32019,
		19,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[32019020] = {
		32019020,
		0,
		Lang.get(79666),
		32019,
		20,
		103,
		{
			RTResTalkAction[1]
		}
	},
	[32019021] = {
		32019021,
		0,
		Lang.get(79667),
		32019,
		21,
		103,
		{
			RTResTalkAction[1]
		}
	},
	[32019022] = {
		32019022,
		0,
		Lang.get(79668),
		32019,
		22,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[32020001] = {
		32020001,
		0,
		Lang.get(79669),
		32020,
		1,
		123,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		32020,
		nil,
		nil,
		nil,
		nil,
		nil,
		32020
	},
	[32020002] = {
		32020002,
		0,
		Lang.get(80350),
		32020,
		2,
		1031,
		nil,
		1
	},
	[32020003] = {
		32020003,
		0,
		Lang.get(79671),
		32020,
		3,
		123,
		nil,
		1
	},
	[32020004] = {
		32020004,
		0,
		Lang.get(79672),
		32020,
		4,
		1029,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		3
	},
	[32020005] = {
		32020005,
		0,
		Lang.get(79673),
		32020,
		5,
		220,
		{
			RTResTalkAction[41],
			RTResTalkAction[15]
		}
	},
	[32031001] = {
		32031001,
		0,
		Lang.get(79674),
		32031,
		1,
		1029,
		nil,
		1,
		1,
		nil,
		nil,
		63,
		32020,
		nil,
		nil,
		nil,
		nil,
		nil,
		32020
	},
	[32031002] = {
		32031002,
		0,
		Lang.get(79675),
		32031,
		2,
		123,
		nil,
		1
	},
	[32031003] = {
		32031003,
		0,
		Lang.get(79676),
		32031,
		3,
		1029,
		nil,
		1,
		1
	},
	[32031004] = {
		32031004,
		0,
		Lang.get(79677),
		32031,
		4,
		123,
		nil,
		1
	},
	[32031005] = {
		32031005,
		0,
		Lang.get(79678),
		32031,
		5,
		220,
		{
			RTResTalkAction[31]
		},
		nil,
		nil,
		3
	},
	[32031006] = {
		32031006,
		0,
		Lang.get(79679),
		32031,
		6,
		123,
		{
			RTResTalkAction[33]
		},
		1
	},
	[32031007] = {
		32031007,
		0,
		Lang.get(79680),
		32031,
		7,
		135,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		32034,
		[19] = 32034,
		[17] = 0
	},
	[32031008] = {
		32031008,
		0,
		Lang.get(79681),
		32031,
		8,
		123,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[32031009] = {
		32031009,
		0,
		Lang.get(79682),
		32031,
		9,
		135,
		{
			RTResTalkAction[3],
			RTResTalkAction[36]
		}
	},
	[32031010] = {
		32031010,
		0,
		Lang.get(79683),
		32031,
		10,
		123,
		{
			RTResTalkAction[3],
			RTResTalkAction[36]
		}
	},
	[32031011] = {
		32031011,
		0,
		Lang.get(79684),
		32031,
		11,
		220,
		{
			RTResTalkAction[5],
			RTResTalkAction[32]
		},
		1,
		nil,
		0,
		nil,
		nil,
		nil,
		1
	},
	[32031012] = {
		32031012,
		0,
		Lang.get(79685),
		32031,
		12,
		1031,
		nil,
		1
	},
	[32031013] = {
		32031013,
		0,
		Lang.get(79686),
		32031,
		13,
		123,
		nil,
		1
	},
	[32031014] = {
		32031014,
		0,
		Lang.get(79687),
		32031,
		14,
		1029,
		nil,
		1,
		1
	},
	[32031015] = {
		32031015,
		0,
		Lang.get(79688),
		32031,
		15,
		135,
		{
			RTResTalkAction[6]
		},
		nil,
		nil,
		3
	},
	[32031016] = {
		32031016,
		0,
		Lang.get(79689),
		32031,
		16,
		123,
		{
			RTResTalkAction[29],
			RTResTalkAction[5]
		}
	},
	[32031017] = {
		32031017,
		0,
		Lang.get(79690),
		32031,
		17,
		135,
		{
			RTResTalkAction[6],
			RTResTalkAction[32]
		}
	},
	[32021001] = {
		32021001,
		0,
		Lang.get(79691),
		32021,
		1,
		135,
		nil,
		1,
		nil,
		nil,
		nil,
		58,
		32021,
		nil,
		nil,
		nil,
		nil,
		nil,
		32021
	},
	[32021002] = {
		32021002,
		0,
		Lang.get(79692),
		32021,
		2,
		135,
		nil,
		1
	},
	[32021003] = {
		32021003,
		0,
		Lang.get(79693),
		32021,
		3,
		123,
		nil,
		1
	},
	[32021004] = {
		32021004,
		0,
		Lang.get(79694),
		32021,
		4,
		1029,
		nil,
		1,
		1
	},
	[32021005] = {
		32021005,
		0,
		Lang.get(79695),
		32021,
		5,
		123,
		nil,
		1
	},
	[32021006] = {
		32021006,
		0,
		Lang.get(79696),
		32021,
		6,
		296,
		{
			RTResTalkAction[42]
		},
		nil,
		nil,
		3
	},
	[32021007] = {
		32021007,
		0,
		Lang.get(79697),
		32021,
		7,
		123,
		{
			RTResTalkAction[29],
			RTResTalkAction[28]
		}
	},
	[32021008] = {
		32021008,
		0,
		Lang.get(79698),
		32021,
		8,
		220,
		{
			RTResTalkAction[31],
			RTResTalkAction[32]
		}
	},
	[32021009] = {
		32021009,
		0,
		Lang.get(79699),
		32021,
		9,
		220,
		{
			RTResTalkAction[31]
		}
	},
	[32021010] = {
		32021010,
		0,
		Lang.get(79700),
		32021,
		10,
		1031,
		{
			RTResTalkAction[20],
			RTResTalkAction[33]
		}
	},
	[32021011] = {
		32021011,
		0,
		Lang.get(79701),
		32021,
		11,
		300,
		{
			RTResTalkAction[17]
		}
	},
	[32021012] = {
		32021012,
		0,
		Lang.get(79702),
		32021,
		12,
		300
	},
	[32021013] = {
		32021013,
		0,
		Lang.get(79703),
		32021,
		13,
		135,
		{
			RTResTalkAction[6]
		}
	},
	[32021014] = {
		32021014,
		0,
		Lang.get(79704),
		32021,
		14,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[32021015] = {
		32021015,
		0,
		Lang.get(79705),
		32021,
		15,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[32021016] = {
		32021016,
		0,
		Lang.get(79706),
		32021,
		16,
		1031,
		{
			RTResTalkAction[3],
			RTResTalkAction[18]
		}
	},
	[32021017] = {
		32021017,
		0,
		Lang.get(79707),
		32021,
		17,
		123,
		{
			RTResTalkAction[30],
			RTResTalkAction[18],
			RTResTalkAction[5]
		}
	},
	[32021018] = {
		32021018,
		0,
		Lang.get(79708),
		32021,
		18,
		135,
		{
			RTResTalkAction[6],
			RTResTalkAction[32],
			RTResTalkAction[17]
		}
	},
	[32021019] = {
		32021019,
		0,
		Lang.get(79709),
		32021,
		19,
		220,
		{
			RTResTalkAction[31],
			RTResTalkAction[5]
		}
	},
	[32021020] = {
		32021020,
		0,
		Lang.get(24430),
		32021,
		20,
		300,
		{
			RTResTalkAction[31]
		}
	},
	[32021021] = {
		32021021,
		0,
		Lang.get(79710),
		32021,
		21,
		1029,
		{
			RTResTalkAction[12],
			RTResTalkAction[33]
		}
	},
	[32021022] = {
		32021022,
		0,
		Lang.get(79711),
		32021,
		22,
		220,
		{
			RTResTalkAction[31],
			RTResTalkAction[19]
		}
	},
	[32022001] = {
		32022001,
		0,
		Lang.get(79712),
		32022,
		1,
		220,
		nil,
		1,
		nil,
		nil,
		nil,
		61,
		32022,
		nil,
		nil,
		nil,
		nil,
		nil,
		32022
	},
	[32022002] = {
		32022002,
		0,
		Lang.get(79713),
		32022,
		2,
		1029,
		nil,
		1,
		1
	},
	[32022003] = {
		32022003,
		0,
		Lang.get(79714),
		32022,
		3,
		220,
		nil,
		1
	},
	[32022004] = {
		32022004,
		0,
		Lang.get(79715),
		32022,
		4,
		135,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		32035,
		[19] = 32035,
		[17] = 1
	},
	[32022005] = {
		32022005,
		0,
		Lang.get(79716),
		32022,
		5,
		103,
		nil,
		1,
		1
	},
	[32022006] = {
		32022006,
		0,
		Lang.get(79717),
		32022,
		6,
		103,
		nil,
		1,
		1
	},
	[32022007] = {
		32022007,
		0,
		Lang.get(79718),
		32022,
		7,
		220,
		{
			RTResTalkAction[31]
		},
		nil,
		nil,
		3
	},
	[32022008] = {
		32022008,
		0,
		Lang.get(79719),
		32022,
		8,
		123,
		{
			RTResTalkAction[34],
			RTResTalkAction[36]
		}
	},
	[32022009] = {
		32022009,
		0,
		Lang.get(79720),
		32022,
		9,
		220,
		{
			RTResTalkAction[31],
			RTResTalkAction[32]
		}
	},
	[32022010] = {
		32022010,
		0,
		Lang.get(79721),
		32022,
		10,
		103,
		{
			RTResTalkAction[8],
			RTResTalkAction[33]
		}
	},
	[32022011] = {
		32022011,
		0,
		Lang.get(79722),
		32022,
		11,
		103,
		{
			RTResTalkAction[8]
		}
	},
	[32022012] = {
		32022012,
		0,
		Lang.get(79723),
		32022,
		12,
		123,
		{
			RTResTalkAction[29],
			RTResTalkAction[2]
		}
	},
	[32022013] = {
		32022013,
		0,
		Lang.get(79724),
		32022,
		13,
		135,
		{
			RTResTalkAction[6],
			RTResTalkAction[32]
		}
	},
	[32022014] = {
		32022014,
		0,
		Lang.get(79725),
		32022,
		14,
		1029,
		{
			RTResTalkAction[12],
			RTResTalkAction[5]
		}
	},
	[32022015] = {
		32022015,
		0,
		Lang.get(79726),
		32022,
		15,
		103,
		{
			RTResTalkAction[44],
			RTResTalkAction[14]
		}
	},
	[32022016] = {
		32022016,
		0,
		Lang.get(79727),
		32022,
		16,
		1029,
		{
			RTResTalkAction[44],
			RTResTalkAction[14]
		}
	},
	[32022017] = {
		32022017,
		0,
		Lang.get(79728),
		32022,
		17,
		1031,
		{
			RTResTalkAction[13],
			RTResTalkAction[14],
			RTResTalkAction[2]
		}
	},
	[32022018] = {
		32022018,
		0,
		Lang.get(79729),
		32022,
		18,
		1029,
		{
			RTResTalkAction[13],
			RTResTalkAction[14]
		}
	},
	[32022019] = {
		32022019,
		0,
		Lang.get(79730),
		32022,
		19,
		103,
		{
			RTResTalkAction[44],
			RTResTalkAction[14],
			RTResTalkAction[17]
		}
	},
	[32022020] = {
		32022020,
		0,
		Lang.get(79731),
		32022,
		20,
		1038,
		{
			RTResTalkAction[7],
			RTResTalkAction[2],
			RTResTalkAction[19]
		}
	},
	[32022021] = {
		32022021,
		0,
		Lang.get(79732),
		32022,
		21,
		1038,
		{
			RTResTalkAction[7]
		}
	},
	[32022022] = {
		32022022,
		0,
		Lang.get(79733),
		32022,
		22,
		103,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[32022023] = {
		32022023,
		0,
		Lang.get(79734),
		32022,
		23,
		103,
		{
			RTResTalkAction[1],
			RTResTalkAction[9]
		}
	},
	[32023001] = {
		32023001,
		0,
		Lang.get(79735),
		32023,
		1,
		1038,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		32023,
		nil,
		nil,
		nil,
		nil,
		nil,
		32023
	},
	[32023002] = {
		32023002,
		0,
		Lang.get(79736),
		32023,
		2,
		1029,
		nil,
		1
	},
	[32023003] = {
		32023003,
		0,
		Lang.get(79737),
		32023,
		3,
		1038,
		nil,
		1
	},
	[32023004] = {
		32023004,
		0,
		Lang.get(79738),
		32023,
		4,
		1031,
		nil,
		1
	},
	[32023005] = {
		32023005,
		0,
		Lang.get(79739),
		32023,
		5,
		1038,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3
	},
	[32023006] = {
		32023006,
		0,
		Lang.get(79740),
		32023,
		6,
		123,
		{
			RTResTalkAction[10],
			RTResTalkAction[36]
		}
	},
	[32023007] = {
		32023007,
		0,
		Lang.get(79741),
		32023,
		7,
		1038,
		{
			RTResTalkAction[10],
			RTResTalkAction[36]
		}
	},
	[32023008] = {
		32023008,
		0,
		Lang.get(79742),
		32023,
		8,
		1031,
		{
			RTResTalkAction[10],
			RTResTalkAction[18],
			RTResTalkAction[32]
		}
	},
	[32023009] = {
		32023009,
		0,
		Lang.get(79743),
		32023,
		9,
		1038,
		{
			RTResTalkAction[10],
			RTResTalkAction[18]
		}
	},
	[32023010] = {
		32023010,
		0,
		Lang.get(79744),
		32023,
		10,
		1038,
		{
			RTResTalkAction[10],
			RTResTalkAction[18]
		}
	},
	[32023011] = {
		32023011,
		0,
		Lang.get(79745),
		32023,
		11,
		135,
		{
			RTResTalkAction[6],
			RTResTalkAction[9],
			RTResTalkAction[17]
		}
	},
	[32023012] = {
		32023012,
		0,
		Lang.get(79746),
		32023,
		12,
		123,
		{
			RTResTalkAction[29],
			RTResTalkAction[5]
		}
	},
	[32023013] = {
		32023013,
		0,
		Lang.get(79747),
		32023,
		13,
		135,
		{
			RTResTalkAction[30],
			RTResTalkAction[45]
		}
	},
	[32023014] = {
		32023014,
		0,
		Lang.get(79748),
		32023,
		14,
		103,
		{
			RTResTalkAction[1],
			RTResTalkAction[32],
			RTResTalkAction[5]
		}
	},
	[32023015] = {
		32023015,
		0,
		Lang.get(79749),
		32023,
		15,
		220,
		{
			RTResTalkAction[31],
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[32023016] = {
		32023016,
		0,
		Lang.get(79750),
		32023,
		16,
		103,
		{
			RTResTalkAction[1],
			RTResTalkAction[33]
		}
	},
	[32023017] = {
		32023017,
		0,
		Lang.get(79751),
		32023,
		17,
		123,
		{
			RTResTalkAction[16],
			RTResTalkAction[36]
		}
	},
	[32023018] = {
		32023018,
		0,
		Lang.get(79752),
		32023,
		18,
		220,
		{
			RTResTalkAction[31],
			RTResTalkAction[2],
			RTResTalkAction[32]
		}
	},
	[32023019] = {
		32023019,
		0,
		Lang.get(79753),
		32023,
		19,
		135,
		{
			RTResTalkAction[34],
			RTResTalkAction[45]
		}
	},
	[32023020] = {
		32023020,
		0,
		Lang.get(79754),
		32023,
		20,
		1029,
		{
			RTResTalkAction[12],
			RTResTalkAction[33],
			RTResTalkAction[5]
		}
	},
	[32023021] = {
		32023021,
		0,
		Lang.get(79755),
		32023,
		21,
		1031,
		{
			RTResTalkAction[20],
			RTResTalkAction[19]
		}
	},
	[32024001] = {
		32024001,
		0,
		Lang.get(79756),
		32024,
		1,
		220,
		nil,
		1,
		nil,
		nil,
		nil,
		57,
		32024,
		nil,
		nil,
		nil,
		nil,
		nil,
		32024
	},
	[32024002] = {
		32024002,
		0,
		Lang.get(79757),
		32024,
		2,
		1038,
		nil,
		1
	},
	[32024003] = {
		32024003,
		0,
		Lang.get(79758),
		32024,
		3,
		1040,
		nil,
		1
	},
	[32024004] = {
		32024004,
		0,
		Lang.get(79759),
		32024,
		4,
		1031,
		nil,
		1
	},
	[32024005] = {
		32024005,
		0,
		Lang.get(79760),
		32024,
		5,
		123,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[32024006] = {
		32024006,
		0,
		Lang.get(79761),
		32024,
		6,
		123,
		{
			RTResTalkAction[29]
		}
	},
	[32024007] = {
		32024007,
		0,
		Lang.get(79762),
		32024,
		7,
		1038,
		{
			RTResTalkAction[7],
			RTResTalkAction[32]
		}
	},
	[32024008] = {
		32024008,
		0,
		Lang.get(79763),
		32024,
		8,
		1038,
		{
			RTResTalkAction[7]
		}
	},
	[32024009] = {
		32024009,
		0,
		Lang.get(79764),
		32024,
		9,
		1029,
		{
			RTResTalkAction[10],
			RTResTalkAction[14]
		}
	},
	[32024010] = {
		32024010,
		0,
		Lang.get(22381),
		32024,
		10,
		1038,
		{
			RTResTalkAction[10],
			RTResTalkAction[14]
		}
	},
	[32024011] = {
		32024011,
		0,
		Lang.get(79765),
		32024,
		11,
		1029,
		{
			RTResTalkAction[10],
			RTResTalkAction[14]
		}
	},
	[32024012] = {
		32024012,
		0,
		Lang.get(79766),
		32024,
		12,
		1038,
		{
			RTResTalkAction[10],
			RTResTalkAction[14]
		}
	},
	[32024013] = {
		32024013,
		0,
		Lang.get(79767),
		32024,
		13,
		1029,
		{
			RTResTalkAction[26],
			RTResTalkAction[9]
		}
	},
	[32024014] = {
		32024014,
		0,
		Lang.get(79768),
		32024,
		14,
		1040,
		{
			RTResTalkAction[46],
			RTResTalkAction[19]
		}
	},
	[32024015] = {
		32024015,
		0,
		Lang.get(79769),
		32024,
		15,
		123,
		{
			RTResTalkAction[29],
			RTResTalkAction[47]
		}
	},
	[32024016] = {
		32024016,
		0,
		Lang.get(79770),
		32024,
		16,
		220,
		{
			RTResTalkAction[30],
			RTResTalkAction[48]
		}
	},
	[32024017] = {
		32024017,
		0,
		Lang.get(79771),
		32024,
		17,
		1031,
		{
			RTResTalkAction[20],
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[32024018] = {
		32024018,
		0,
		Lang.get(79772),
		32024,
		18,
		103,
		{
			RTResTalkAction[1],
			RTResTalkAction[17]
		}
	},
	[32032001] = {
		32032001,
		5,
		Lang.get(79773),
		32032,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		57,
		32046,
		[19] = 32046,
		[22] = 1
	},
	[32032002] = {
		32032002,
		5,
		Lang.get(79774),
		32032,
		2,
		605,
		[22] = 1
	},
	[32032003] = {
		32032003,
		0,
		Lang.get(79775),
		32032,
		3,
		103,
		nil,
		1
	},
	[32032004] = {
		32032004,
		0,
		Lang.get(79776),
		32032,
		4,
		1031,
		nil,
		1
	},
	[32032005] = {
		32032005,
		0,
		Lang.get(79777),
		32032,
		5,
		1038,
		{
			RTResTalkAction[7]
		},
		1
	},
	[32032006] = {
		32032006,
		0,
		Lang.get(79778),
		32032,
		6,
		1038,
		{
			RTResTalkAction[7]
		},
		1
	},
	[32032007] = {
		32032007,
		0,
		Lang.get(79779),
		32032,
		7,
		1040,
		{
			RTResTalkAction[46],
			RTResTalkAction[9]
		},
		1
	},
	[32032008] = {
		32032008,
		0,
		Lang.get(79780),
		32032,
		8,
		1031,
		{
			RTResTalkAction[13],
			RTResTalkAction[49]
		},
		1
	},
	[32032009] = {
		32032009,
		0,
		Lang.get(79781),
		32032,
		9,
		220,
		{
			RTResTalkAction[34],
			RTResTalkAction[49],
			RTResTalkAction[17]
		},
		1
	},
	[32032010] = {
		32032010,
		0,
		Lang.get(79782),
		32032,
		10,
		1040,
		{
			RTResTalkAction[46],
			RTResTalkAction[33]
		},
		1
	},
	[32025001] = {
		32025001,
		0,
		Lang.get(79783),
		32025,
		1,
		1030,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		32025,
		nil,
		nil,
		nil,
		nil,
		nil,
		32025
	},
	[32025002] = {
		32025002,
		0,
		Lang.get(79784),
		32025,
		2,
		1030,
		nil,
		1
	},
	[32025003] = {
		32025003,
		0,
		Lang.get(79785),
		32025,
		3,
		1030,
		nil,
		1
	},
	[32025004] = {
		32025004,
		0,
		Lang.get(79786),
		32025,
		4,
		1037,
		nil,
		1
	},
	[32025005] = {
		32025005,
		0,
		Lang.get(79787),
		32025,
		5,
		1030,
		nil,
		1
	},
	[32025006] = {
		32025006,
		0,
		Lang.get(79788),
		32025,
		6,
		1037,
		nil,
		1
	},
	[32025007] = {
		32025007,
		0,
		Lang.get(79789),
		32025,
		7,
		1030,
		nil,
		1
	},
	[32025008] = {
		32025008,
		0,
		Lang.get(79790),
		32025,
		8,
		1032,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		32026,
		[19] = 32026
	},
	[32025009] = {
		32025009,
		0,
		Lang.get(79791),
		32025,
		9,
		1030,
		nil,
		1
	},
	[32025010] = {
		32025010,
		0,
		Lang.get(79792),
		32025,
		10,
		1032,
		nil,
		1
	},
	[32025011] = {
		32025011,
		0,
		Lang.get(79793),
		32025,
		11,
		1032,
		nil,
		1
	},
	[32025012] = {
		32025012,
		0,
		Lang.get(79794),
		32025,
		12,
		1030,
		{
			RTResTalkAction[50],
			RTResTalkAction[51]
		},
		nil,
		nil,
		3
	},
	[32025013] = {
		32025013,
		0,
		Lang.get(79795),
		32025,
		13,
		1032,
		{
			RTResTalkAction[50],
			RTResTalkAction[51]
		}
	},
	[32025014] = {
		32025014,
		0,
		Lang.get(79796),
		32025,
		14,
		103,
		{
			RTResTalkAction[1],
			RTResTalkAction[52],
			RTResTalkAction[53]
		}
	},
	[32025015] = {
		32025015,
		0,
		Lang.get(79797),
		32025,
		15,
		1032,
		{
			RTResTalkAction[16],
			RTResTalkAction[54]
		}
	},
	[32025016] = {
		32025016,
		0,
		Lang.get(79798),
		32025,
		16,
		135,
		{
			RTResTalkAction[3],
			RTResTalkAction[4],
			RTResTalkAction[52]
		}
	},
	[32025017] = {
		32025017,
		0,
		Lang.get(79799),
		32025,
		17,
		103,
		{
			RTResTalkAction[8],
			RTResTalkAction[5]
		}
	},
	[32025018] = {
		32025018,
		0,
		Lang.get(79800),
		32025,
		18,
		1030,
		{
			RTResTalkAction[55],
			RTResTalkAction[4]
		}
	},
	[32025019] = {
		32025019,
		0,
		Lang.get(81433),
		32025,
		19,
		1032,
		{
			RTResTalkAction[50],
			RTResTalkAction[51],
			RTResTalkAction[2]
		}
	},
	[32025020] = {
		32025020,
		0,
		Lang.get(79802),
		32025,
		20,
		1030,
		{
			RTResTalkAction[50],
			RTResTalkAction[51]
		}
	},
	[32025021] = {
		32025021,
		0,
		Lang.get(79803),
		32025,
		21,
		103,
		{
			RTResTalkAction[55],
			RTResTalkAction[43],
			RTResTalkAction[52]
		}
	},
	[32025022] = {
		32025022,
		0,
		Lang.get(79804),
		32025,
		22,
		135,
		{
			RTResTalkAction[3],
			RTResTalkAction[43],
			RTResTalkAction[53]
		}
	},
	[32025023] = {
		32025023,
		0,
		Lang.get(79805),
		32025,
		23,
		103,
		{
			RTResTalkAction[3],
			RTResTalkAction[43]
		}
	},
	[32025024] = {
		32025024,
		0,
		Lang.get(79806),
		32025,
		24,
		1032,
		{
			RTResTalkAction[50],
			RTResTalkAction[51],
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[32025025] = {
		32025025,
		0,
		Lang.get(79807),
		32025,
		25,
		1030,
		{
			RTResTalkAction[50],
			RTResTalkAction[51]
		}
	},
	[32026001] = {
		32026001,
		0,
		Lang.get(79808),
		32026,
		1,
		103,
		nil,
		1,
		nil,
		nil,
		nil,
		61,
		32026,
		nil,
		nil,
		nil,
		nil,
		nil,
		32026
	},
	[32026002] = {
		32026002,
		0,
		Lang.get(79809),
		32026,
		2,
		1032,
		nil,
		1
	},
	[32026003] = {
		32026003,
		0,
		Lang.get(79810),
		32026,
		3,
		103,
		nil,
		1
	},
	[32026004] = {
		32026004,
		0,
		Lang.get(79811),
		32026,
		4,
		103,
		nil,
		1
	},
	[32026005] = {
		32026005,
		0,
		Lang.get(79812),
		32026,
		5,
		1030,
		{
			RTResTalkAction[56]
		},
		nil,
		nil,
		3
	},
	[32026006] = {
		32026006,
		0,
		Lang.get(79813),
		32026,
		6,
		103,
		{
			RTResTalkAction[55],
			RTResTalkAction[4]
		}
	},
	[32026007] = {
		32026007,
		0,
		Lang.get(79814),
		32026,
		7,
		103,
		{
			RTResTalkAction[55],
			RTResTalkAction[4]
		}
	},
	[32026008] = {
		32026008,
		0,
		Lang.get(79815),
		32026,
		8,
		135,
		{
			RTResTalkAction[3],
			RTResTalkAction[4],
			RTResTalkAction[53]
		}
	},
	[32026009] = {
		32026009,
		0,
		Lang.get(79816),
		32026,
		9,
		103,
		{
			RTResTalkAction[3],
			RTResTalkAction[4]
		}
	},
	[32026010] = {
		32026010,
		0,
		Lang.get(79817),
		32026,
		10,
		1030,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		32036,
		1,
		1,
		nil,
		1,
		nil,
		32036
	},
	[32026011] = {
		32026011,
		0,
		Lang.get(79818),
		32026,
		11,
		1030,
		nil,
		1
	},
	[32026012] = {
		32026012,
		0,
		Lang.get(79819),
		32026,
		12,
		1037,
		nil,
		1
	},
	[32026013] = {
		32026013,
		0,
		Lang.get(79820),
		32026,
		13,
		1030,
		{
			RTResTalkAction[56]
		},
		nil,
		nil,
		3
	},
	[32026014] = {
		32026014,
		3,
		Lang.get(79821),
		32026,
		14,
		605,
		{
			RTResTalkAction[56]
		},
		[22] = 1
	},
	[32026015] = {
		32026015,
		0,
		Lang.get(79822),
		32026,
		15,
		1030,
		{
			RTResTalkAction[56]
		}
	},
	[32026016] = {
		32026016,
		0,
		Lang.get(79823),
		32026,
		16,
		135,
		{
			RTResTalkAction[6],
			RTResTalkAction[53]
		}
	},
	[32026017] = {
		32026017,
		0,
		Lang.get(79824),
		32026,
		17,
		1030,
		{
			RTResTalkAction[56],
			RTResTalkAction[5]
		}
	},
	[32026018] = {
		32026018,
		0,
		Lang.get(79825),
		32026,
		18,
		1030,
		{
			RTResTalkAction[53]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		32037,
		1,
		1,
		nil,
		1,
		nil,
		32037
	},
	[32026019] = {
		32026019,
		0,
		Lang.get(79826),
		32026,
		19,
		1030,
		nil,
		1
	},
	[32026020] = {
		32026020,
		3,
		Lang.get(79827),
		32026,
		20,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		32038,
		nil,
		nil,
		nil,
		1,
		nil,
		32038,
		nil,
		nil,
		1
	},
	[32026021] = {
		32026021,
		0,
		Lang.get(79828),
		32026,
		21,
		1030,
		nil,
		1
	},
	[32026022] = {
		32026022,
		0,
		Lang.get(79829),
		32026,
		22,
		1030,
		nil,
		1
	},
	[32026023] = {
		32026023,
		3,
		Lang.get(79830),
		32026,
		23,
		605,
		nil,
		nil,
		nil,
		3,
		[22] = 1
	},
	[32026024] = {
		32026024,
		3,
		Lang.get(79831),
		32026,
		24,
		605,
		[22] = 1
	},
	[32026025] = {
		32026025,
		0,
		Lang.get(79832),
		32026,
		25,
		103,
		{
			RTResTalkAction[1]
		}
	},
	[32026026] = {
		32026026,
		0,
		Lang.get(79833),
		32026,
		26,
		1030,
		{
			RTResTalkAction[55],
			RTResTalkAction[4]
		}
	},
	[32026027] = {
		32026027,
		0,
		Lang.get(79834),
		32026,
		27,
		135,
		{
			RTResTalkAction[3],
			RTResTalkAction[4],
			RTResTalkAction[53]
		}
	},
	[32026028] = {
		32026028,
		0,
		Lang.get(79835),
		32026,
		28,
		103,
		{
			RTResTalkAction[3],
			RTResTalkAction[4]
		}
	},
	[32026029] = {
		32026029,
		3,
		Lang.get(79836),
		32026,
		29,
		605,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		},
		nil,
		nil,
		3,
		[22] = 1
	},
	[32026030] = {
		32026030,
		0,
		Lang.get(79837),
		32026,
		30,
		1032,
		{
			RTResTalkAction[50],
			RTResTalkAction[51]
		}
	},
	[32026031] = {
		32026031,
		0,
		Lang.get(79838),
		32026,
		31,
		1030,
		{
			RTResTalkAction[50],
			RTResTalkAction[51]
		}
	},
	[32026032] = {
		32026032,
		0,
		Lang.get(79839),
		32026,
		32,
		1032,
		{
			RTResTalkAction[50],
			RTResTalkAction[51]
		}
	},
	[32026033] = {
		32026033,
		0,
		Lang.get(79840),
		32026,
		33,
		1030,
		{
			RTResTalkAction[50],
			RTResTalkAction[51]
		}
	},
	[32026034] = {
		32026034,
		3,
		Lang.get(79841),
		32026,
		34,
		605,
		{
			RTResTalkAction[52],
			RTResTalkAction[53]
		},
		[22] = 1
	},
	[32026035] = {
		32026035,
		5,
		Lang.get(79585),
		32026,
		35,
		605,
		[22] = 1
	},
	[32027001] = {
		32027001,
		0,
		Lang.get(79842),
		32027,
		1,
		1037,
		nil,
		1,
		nil,
		nil,
		nil,
		61,
		32027,
		nil,
		nil,
		nil,
		nil,
		nil,
		32027
	},
	[32027002] = {
		32027002,
		0,
		Lang.get(79843),
		32027,
		2,
		1032,
		nil,
		1
	},
	[32027003] = {
		32027003,
		0,
		Lang.get(79844),
		32027,
		3,
		1037,
		nil,
		1
	},
	[32027004] = {
		32027004,
		0,
		Lang.get(79845),
		32027,
		4,
		1032,
		{
			RTResTalkAction[57]
		},
		nil,
		nil,
		3
	},
	[32027005] = {
		32027005,
		0,
		Lang.get(79846),
		32027,
		5,
		1030,
		{
			RTResTalkAction[56],
			RTResTalkAction[52]
		}
	},
	[32027006] = {
		32027006,
		0,
		Lang.get(79847),
		32027,
		6,
		1030,
		{
			RTResTalkAction[56]
		}
	},
	[32033001] = {
		32033001,
		0,
		Lang.get(79848),
		32033,
		1,
		1037,
		nil,
		1,
		nil,
		nil,
		nil,
		61,
		32027,
		nil,
		nil,
		nil,
		nil,
		nil,
		32027
	},
	[32033002] = {
		32033002,
		0,
		Lang.get(79849),
		32033,
		2,
		1032,
		nil,
		1
	},
	[32033003] = {
		32033003,
		0,
		Lang.get(79850),
		32033,
		3,
		1030,
		nil,
		1
	},
	[32033004] = {
		32033004,
		0,
		Lang.get(79851),
		32033,
		4,
		1037,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		32039,
		[19] = 32039,
		[17] = 1
	},
	[32033005] = {
		32033005,
		0,
		Lang.get(79852),
		32033,
		5,
		103,
		nil,
		1
	},
	[32033006] = {
		32033006,
		0,
		Lang.get(79853),
		32033,
		6,
		1037,
		nil,
		1
	},
	[32033007] = {
		32033007,
		0,
		Lang.get(79854),
		32033,
		7,
		135,
		{
			RTResTalkAction[6]
		},
		nil,
		nil,
		3
	},
	[32033008] = {
		32033008,
		0,
		Lang.get(79855),
		32033,
		8,
		103,
		{
			RTResTalkAction[1],
			RTResTalkAction[5]
		}
	},
	[32033009] = {
		32033009,
		0,
		Lang.get(79856),
		32033,
		9,
		1030,
		{
			RTResTalkAction[16],
			RTResTalkAction[51]
		}
	},
	[32033010] = {
		32033010,
		0,
		Lang.get(79857),
		32033,
		10,
		1032,
		{
			RTResTalkAction[57],
			RTResTalkAction[2],
			RTResTalkAction[53]
		}
	},
	[32033011] = {
		32033011,
		0,
		Lang.get(79858),
		32033,
		11,
		103,
		{
			RTResTalkAction[16],
			RTResTalkAction[54]
		}
	},
	[32033012] = {
		32033012,
		0,
		Lang.get(79859),
		32033,
		12,
		1032,
		{
			RTResTalkAction[57],
			RTResTalkAction[2]
		}
	},
	[32033013] = {
		32033013,
		0,
		Lang.get(79860),
		32033,
		13,
		1030,
		{
			RTResTalkAction[56],
			RTResTalkAction[52]
		}
	},
	[32033014] = {
		32033014,
		0,
		Lang.get(79861),
		32033,
		14,
		1030,
		{
			RTResTalkAction[56]
		}
	},
	[32028001] = {
		32028001,
		0,
		Lang.get(72569),
		32028,
		1,
		1029,
		nil,
		1,
		1,
		nil,
		nil,
		57,
		32035,
		nil,
		nil,
		nil,
		nil,
		nil,
		32035
	},
	[32028002] = {
		32028002,
		0,
		Lang.get(79862),
		32028,
		2,
		1038,
		nil,
		1
	},
	[32028003] = {
		32028003,
		0,
		Lang.get(79863),
		32028,
		3,
		1038,
		nil,
		1
	},
	[32028004] = {
		32028004,
		0,
		Lang.get(79864),
		32028,
		4,
		220,
		{
			RTResTalkAction[31]
		},
		nil,
		nil,
		3
	},
	[32028005] = {
		32028005,
		0,
		Lang.get(79865),
		32028,
		5,
		1031,
		{
			RTResTalkAction[20],
			RTResTalkAction[33]
		}
	},
	[32028006] = {
		32028006,
		5,
		Lang.get(77581),
		32028,
		6,
		605,
		{
			RTResTalkAction[17]
		},
		[22] = 1
	},
	[32028007] = {
		32028007,
		0,
		Lang.get(79866),
		32028,
		7,
		103,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		32040,
		[19] = 32040,
		[17] = 0
	},
	[32028008] = {
		32028008,
		0,
		Lang.get(79867),
		32028,
		8,
		1038,
		nil,
		1
	},
	[32028009] = {
		32028009,
		0,
		Lang.get(79868),
		32028,
		9,
		103,
		nil,
		1
	},
	[32028010] = {
		32028010,
		0,
		Lang.get(79869),
		32028,
		10,
		1038,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3
	},
	[32028011] = {
		32028011,
		0,
		Lang.get(79870),
		32028,
		11,
		1038,
		{
			RTResTalkAction[7]
		}
	},
	[32028012] = {
		32028012,
		0,
		Lang.get(79871),
		32028,
		12,
		1038,
		{
			RTResTalkAction[7]
		}
	},
	[32028013] = {
		32028013,
		0,
		Lang.get(21992),
		32028,
		13,
		1038,
		{
			RTResTalkAction[9]
		},
		1
	},
	[32028014] = {
		32028014,
		0,
		Lang.get(79872),
		32028,
		14,
		135,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		32044,
		[19] = 32044,
		[17] = 1
	},
	[32028015] = {
		32028015,
		3,
		Lang.get(79873),
		32028,
		15,
		605,
		[22] = 1
	},
	[32028016] = {
		32028016,
		0,
		Lang.get(79874),
		32028,
		16,
		1029,
		nil,
		1
	},
	[32028017] = {
		32028017,
		0,
		Lang.get(79875),
		32028,
		17,
		123,
		nil,
		1
	},
	[32028018] = {
		32028018,
		0,
		Lang.get(79876),
		32028,
		18,
		103,
		nil,
		1
	},
	[32028019] = {
		32028019,
		0,
		Lang.get(79877),
		32028,
		19,
		135,
		nil,
		1
	},
	[32028020] = {
		32028020,
		0,
		Lang.get(79878),
		32028,
		20,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		32041,
		[19] = 32041,
		[17] = 1
	},
	[32028021] = {
		32028021,
		0,
		Lang.get(79879),
		32028,
		21,
		1029,
		nil,
		1,
		1
	},
	[32028022] = {
		32028022,
		0,
		Lang.get(79880),
		32028,
		22,
		1029,
		nil,
		1,
		1
	},
	[32028023] = {
		32028023,
		0,
		Lang.get(79881),
		32028,
		23,
		123,
		nil,
		1
	},
	[32028024] = {
		32028024,
		0,
		Lang.get(79882),
		32028,
		24,
		1029,
		nil,
		1,
		1
	},
	[32028025] = {
		32028025,
		0,
		Lang.get(79883),
		32028,
		25,
		300,
		nil,
		nil,
		nil,
		3
	},
	[32028026] = {
		32028026,
		0,
		Lang.get(79884),
		32028,
		26,
		1031,
		{
			RTResTalkAction[13],
			RTResTalkAction[15]
		}
	},
	[32028027] = {
		32028027,
		0,
		Lang.get(79885),
		32028,
		27,
		220,
		{
			RTResTalkAction[31],
			RTResTalkAction[17],
			RTResTalkAction[19]
		}
	},
	[32028028] = {
		32028028,
		0,
		Lang.get(79886),
		32028,
		28,
		300,
		{
			RTResTalkAction[33]
		}
	},
	[32028029] = {
		32028029,
		0,
		Lang.get(79887),
		32028,
		29,
		1029,
		{
			RTResTalkAction[26]
		}
	},
	[32028030] = {
		32028030,
		0,
		Lang.get(79888),
		32028,
		30,
		1031,
		{
			RTResTalkAction[13],
			RTResTalkAction[15]
		}
	},
	[32029001] = {
		32029001,
		0,
		Lang.get(79889),
		32029,
		1,
		1031,
		nil,
		1,
		nil,
		nil,
		nil,
		58,
		32029,
		nil,
		nil,
		nil,
		nil,
		nil,
		32029
	},
	[32029002] = {
		32029002,
		0,
		Lang.get(79890),
		32029,
		2,
		1029,
		nil,
		1,
		1
	},
	[32029003] = {
		32029003,
		0,
		Lang.get(79891),
		32029,
		3,
		1031,
		nil,
		1
	},
	[32029004] = {
		32029004,
		0,
		Lang.get(79892),
		32029,
		4,
		1029,
		{
			RTResTalkAction[26]
		},
		nil,
		nil,
		3
	},
	[32029005] = {
		32029005,
		0,
		Lang.get(79893),
		32029,
		5,
		1029,
		{
			RTResTalkAction[26]
		}
	},
	[32029006] = {
		32029006,
		0,
		Lang.get(79894),
		32029,
		6,
		1031,
		{
			RTResTalkAction[13],
			RTResTalkAction[15]
		}
	},
	[32029007] = {
		32029007,
		0,
		Lang.get(79895),
		32029,
		7,
		1029,
		{
			RTResTalkAction[26],
			RTResTalkAction[17]
		}
	},
	[32029008] = {
		32029008,
		0,
		Lang.get(79896),
		32029,
		8,
		1031,
		{
			RTResTalkAction[19]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		32042,
		1,
		1,
		nil,
		1,
		nil,
		32042
	},
	[32029009] = {
		32029009,
		3,
		Lang.get(79897),
		32029,
		9,
		605,
		[22] = 1
	},
	[32029010] = {
		32029010,
		0,
		Lang.get(79898),
		32029,
		10,
		1031,
		nil,
		1,
		nil,
		nil,
		nil,
		63
	},
	[32029011] = {
		32029011,
		0,
		Lang.get(79899),
		32029,
		11,
		1015
	},
	[32029012] = {
		32029012,
		0,
		Lang.get(79469),
		32029,
		12,
		1015
	},
	[32029013] = {
		32029013,
		0,
		Lang.get(79900),
		32029,
		13,
		1033,
		{
			RTResTalkAction[58]
		},
		nil,
		nil,
		3
	},
	[32029014] = {
		32029014,
		0,
		Lang.get(79901),
		32029,
		14,
		1031,
		{
			RTResTalkAction[20],
			RTResTalkAction[59]
		}
	},
	[32029015] = {
		32029015,
		0,
		Lang.get(79902),
		32029,
		15,
		1039,
		{
			RTResTalkAction[60],
			RTResTalkAction[18]
		}
	},
	[32029016] = {
		32029016,
		0,
		Lang.get(79903),
		32029,
		16,
		1031,
		{
			RTResTalkAction[60],
			RTResTalkAction[18]
		}
	},
	[32029017] = {
		32029017,
		0,
		Lang.get(79904),
		32029,
		17,
		1039,
		{
			RTResTalkAction[60],
			RTResTalkAction[18]
		}
	},
	[32029018] = {
		32029018,
		0,
		Lang.get(79905),
		32029,
		18,
		1039,
		{
			RTResTalkAction[60],
			RTResTalkAction[18]
		}
	},
	[32029019] = {
		32029019,
		0,
		Lang.get(79906),
		32029,
		19,
		1031,
		{
			RTResTalkAction[60],
			RTResTalkAction[18]
		}
	},
	[32029020] = {
		32029020,
		0,
		Lang.get(79907),
		32029,
		20,
		1039,
		{
			RTResTalkAction[60],
			RTResTalkAction[18]
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
