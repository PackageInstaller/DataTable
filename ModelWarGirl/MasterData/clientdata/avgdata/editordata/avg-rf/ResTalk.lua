-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\AVG-RF\\ResTalk.lua

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
	[2] = 109
}
RTResTalkAction[2] = {
	[1] = 1,
	[2] = 109,
	[3] = {
		1002
	}
}
RTResTalkAction[3] = {
	[1] = 1,
	[2] = 109,
	[3] = {
		1003
	}
}
RTResTalkAction[4] = {
	[1] = 1,
	[2] = 109,
	[3] = {
		1004
	}
}
RTResTalkAction[5] = {
	[1] = 1,
	[2] = 207
}
RTResTalkAction[6] = {
	[1] = 1,
	[2] = 207,
	[3] = {
		1003
	}
}
RTResTalkAction[7] = {
	[1] = 1,
	[2] = 207,
	[3] = {
		1002
	}
}
RTResTalkAction[8] = {
	1,
	123,
	nil,
	nil,
	2
}
RTResTalkAction[9] = {
	1,
	123,
	{
		1003
	},
	nil,
	1
}
RTResTalkAction[10] = {
	1,
	123,
	nil,
	nil,
	1
}
RTResTalkAction[11] = {
	[1] = 1,
	[2] = 123
}
RTResTalkAction[12] = {
	[1] = 1,
	[2] = 105
}
RTResTalkAction[13] = {
	[1] = 1,
	[2] = 105,
	[3] = {
		1002
	}
}
RTResTalkAction[14] = {
	[1] = 1,
	[2] = 105,
	[3] = {
		1004
	}
}
RTResTalkAction[15] = {
	[1] = 1,
	[2] = 150
}
RTResTalkAction[16] = {
	1,
	150,
	nil,
	nil,
	5
}
RTResTalkAction[17] = {
	1,
	150,
	nil,
	nil,
	3
}
RTResTalkAction[18] = {
	1,
	150,
	nil,
	nil,
	1
}
RTResTalkAction[19] = {
	1,
	150,
	nil,
	nil,
	2
}
RTResTalkAction[20] = {
	1,
	150,
	nil,
	nil,
	4
}
RTResTalkAction[21] = {
	1,
	150,
	nil,
	nil,
	6
}
RTResTalkAction[22] = {
	1,
	150,
	{
		1002
	},
	nil,
	6
}
RTResTalkAction[23] = {
	[1] = 1,
	[2] = 148
}
RTResTalkAction[24] = {
	[1] = 1,
	[2] = 148,
	[3] = {
		1003
	}
}
RTResTalkAction[25] = {
	[1] = 1,
	[2] = 278
}
RTResTalkAction[26] = {
	[1] = 1,
	[2] = 278,
	[3] = {
		1003
	}
}
RTResTalkAction[27] = {
	[1] = 1,
	[2] = 158
}
RTResTalkAction[28] = {
	1,
	158,
	{
		1002
	},
	nil,
	4
}
RTResTalkAction[29] = {
	1,
	158,
	nil,
	nil,
	3
}
RTResTalkAction[30] = {
	1,
	158,
	nil,
	nil,
	1
}
RTResTalkAction[31] = {
	1,
	158,
	nil,
	nil,
	4
}
RTResTalkAction[32] = {
	1,
	158,
	{
		1004
	},
	nil,
	2
}
RTResTalkAction[33] = {
	1,
	158,
	nil,
	nil,
	6
}
RTResTalkAction[34] = {
	1,
	158,
	nil,
	nil,
	2
}
RTResTalkAction[35] = {
	1,
	158,
	{
		1004
	},
	nil,
	6
}
RTResTalkAction[36] = {
	1,
	158,
	nil,
	nil,
	5
}
RTResTalkAction[37] = {
	1,
	158,
	{
		1003
	},
	nil,
	5
}
RTResTalkAction[38] = {
	1,
	158,
	{
		1007
	},
	nil,
	5
}
RTResTalkAction[39] = {
	1,
	239,
	nil,
	nil,
	1
}
RTResTalkAction[40] = {
	1,
	239,
	{
		1003
	},
	nil,
	1
}
RTResTalkAction[41] = {
	[1] = 1,
	[2] = 302
}
RTResTalkAction[42] = {
	[1] = 1,
	[2] = 302,
	[3] = {
		1003
	}
}
RTResTalkAction[43] = {
	[1] = 1,
	[2] = 314
}
RTResTalkAction[44] = {
	[1] = 0,
	[2] = 302
}
RTResTalkAction[45] = {
	[1] = 0,
	[2] = 314
}
RTResTalkAction[46] = {
	1,
	338,
	nil,
	nil,
	3
}
RTResTalkAction[47] = {
	[1] = 1,
	[2] = 338
}
RTResTalkAction[48] = {
	1,
	338,
	{
		1004
	},
	nil,
	3
}
RTResTalkAction[49] = {
	1,
	338,
	nil,
	nil,
	4
}
RTResTalkAction[50] = {
	1,
	338,
	nil,
	nil,
	1
}
RTResTalkAction[51] = {
	1,
	338,
	{
		1003
	},
	nil,
	1
}
RTResTalkAction[52] = {
	1,
	338,
	nil,
	nil,
	2
}
RTResTalkAction[53] = {
	1,
	338,
	{
		1003
	},
	nil,
	4
}
RTResTalkAction[54] = {
	[1] = 1,
	[2] = 637
}
RTResTalkAction[55] = {
	[1] = 1,
	[2] = 637,
	[3] = {
		2
	}
}
RTResTalkAction[56] = {
	[1] = 1,
	[2] = 637,
	[3] = {
		1003
	}
}
RTResTalkAction[57] = {
	[1] = 1,
	[2] = 637,
	[3] = {
		1002
	}
}
RTResTalkAction[58] = {
	[1] = 1,
	[2] = 117
}
RTResTalkAction[59] = {
	[1] = 1,
	[2] = 117,
	[3] = {
		1006
	}
}
RTResTalkAction[60] = {
	[1] = 1,
	[2] = 117,
	[3] = {
		1002
	}
}
RTResTalkAction[61] = {
	[1] = 1,
	[2] = 117,
	[3] = {
		3
	}
}
RTResTalkAction[62] = {
	[1] = 1,
	[2] = 122
}
RTResTalkAction[63] = {
	1,
	122,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[64] = {
	[1] = 1,
	[2] = 122,
	[3] = {
		1005
	}
}
RTResTalkAction[65] = {
	1,
	122,
	nil,
	nil,
	2
}
RTResTalkAction[66] = {
	1,
	122,
	nil,
	nil,
	1
}
RTResTalkAction[67] = {
	1,
	122,
	nil,
	nil,
	0
}
RTResTalkAction[68] = {
	1,
	122,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[69] = {
	1,
	143,
	{
		1006
	},
	nil,
	1
}
RTResTalkAction[70] = {
	1,
	143,
	nil,
	nil,
	2
}
RTResTalkAction[71] = {
	[1] = 1,
	[2] = 143
}
RTResTalkAction[72] = {
	1,
	143,
	nil,
	nil,
	4
}
RTResTalkAction[73] = {
	1,
	143,
	{
		1003
	},
	nil,
	2
}
RTResTalkAction[74] = {
	1,
	143,
	nil,
	nil,
	5
}
RTResTalkAction[75] = {
	1,
	143,
	nil,
	nil,
	3
}
RTResTalkAction[76] = {
	1,
	143,
	{
		1002
	},
	nil,
	5
}
RTResTalkAction[77] = {
	[1] = 1,
	[2] = 143,
	[3] = {
		1003
	}
}
RTResTalkAction[78] = {
	[1] = 1,
	[2] = 1009
}
RTResTalkAction[79] = {
	[1] = 1,
	[2] = 1010
}

local Data = {
	[27500001] = {
		27500001,
		0,
		Lang.get(64701),
		27500,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		27500,
		[19] = 27500
	},
	[27500002] = {
		27500002,
		0,
		Lang.get(64702),
		27500,
		2,
		109,
		nil,
		1
	},
	[27500003] = {
		27500003,
		0,
		Lang.get(64703),
		27500,
		3,
		300
	},
	[27500004] = {
		27500004,
		0,
		Lang.get(64704),
		27500,
		4,
		109,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[27500005] = {
		27500005,
		0,
		Lang.get(64705),
		27500,
		5,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[27500006] = {
		27500006,
		0,
		Lang.get(64706),
		27500,
		6,
		109,
		{
			RTResTalkAction[2]
		}
	},
	[27500007] = {
		27500007,
		4,
		nil,
		27500,
		7,
		109,
		{
			RTResTalkAction[1]
		},
		[29] = {
			{
				id = 27500008,
				branch_content = Lang.get(64707)
			},
			{
				id = 27500008,
				branch_content = Lang.get(64708)
			}
		}
	},
	[27500008] = {
		27500008,
		0,
		Lang.get(64709),
		27500,
		8,
		109,
		{
			RTResTalkAction[1]
		}
	},
	[27500009] = {
		27500009,
		0,
		Lang.get(64710),
		27500,
		9,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[27500010] = {
		27500010,
		0,
		Lang.get(64711),
		27500,
		10,
		109,
		{
			RTResTalkAction[1]
		}
	},
	[27500011] = {
		27500011,
		0,
		Lang.get(64712),
		27500,
		11,
		109,
		{
			RTResTalkAction[1]
		}
	},
	[27500012] = {
		27500012,
		0,
		Lang.get(64713),
		27500,
		12,
		109,
		{
			RTResTalkAction[1]
		}
	},
	[27500013] = {
		27500013,
		0,
		Lang.get(64714),
		27500,
		13,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[27500014] = {
		27500014,
		0,
		Lang.get(64715),
		27500,
		14,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[27500015] = {
		27500015,
		0,
		Lang.get(64716),
		27500,
		15,
		109,
		{
			RTResTalkAction[3]
		}
	},
	[27501001] = {
		27501001,
		0,
		Lang.get(64717),
		27501,
		1,
		109,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27501,
		[19] = 27501
	},
	[27501002] = {
		27501002,
		0,
		Lang.get(64718),
		27501,
		2,
		300
	},
	[27501003] = {
		27501003,
		0,
		Lang.get(64719),
		27501,
		3,
		109
	},
	[27501004] = {
		27501004,
		0,
		Lang.get(64720),
		27501,
		4,
		300,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[27501005] = {
		27501005,
		0,
		Lang.get(64721),
		27501,
		5,
		109,
		{
			RTResTalkAction[2]
		}
	},
	[27501006] = {
		27501006,
		0,
		Lang.get(64722),
		27501,
		6,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[27501007] = {
		27501007,
		0,
		Lang.get(64723),
		27501,
		7,
		109,
		{
			RTResTalkAction[1]
		}
	},
	[27501008] = {
		27501008,
		0,
		Lang.get(64724),
		27501,
		8,
		109,
		{
			RTResTalkAction[1]
		}
	},
	[27501009] = {
		27501009,
		0,
		Lang.get(64725),
		27501,
		9,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[27501010] = {
		27501010,
		0,
		Lang.get(64726),
		27501,
		10,
		109,
		{
			RTResTalkAction[2]
		}
	},
	[27501011] = {
		27501011,
		0,
		Lang.get(64727),
		27501,
		11,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[27501012] = {
		27501012,
		0,
		Lang.get(64728),
		27501,
		12,
		109,
		{
			RTResTalkAction[4]
		}
	},
	[27502001] = {
		27502001,
		0,
		Lang.get(64729),
		27502,
		1,
		109,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27502,
		[19] = 27502
	},
	[27502002] = {
		27502002,
		0,
		Lang.get(64730),
		27502,
		2,
		300
	},
	[27502003] = {
		27502003,
		0,
		Lang.get(64731),
		27502,
		3,
		109,
		nil,
		1,
		nil,
		3
	},
	[27502004] = {
		27502004,
		0,
		Lang.get(64732),
		27502,
		4,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[27502005] = {
		27502005,
		0,
		Lang.get(64733),
		27502,
		5,
		109,
		{
			RTResTalkAction[1]
		}
	},
	[27502006] = {
		27502006,
		0,
		Lang.get(64734),
		27502,
		6,
		109,
		{
			RTResTalkAction[3]
		}
	},
	[27502007] = {
		27502007,
		0,
		Lang.get(64735),
		27502,
		7,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[27502008] = {
		27502008,
		0,
		Lang.get(64736),
		27502,
		8,
		109,
		{
			RTResTalkAction[1]
		}
	},
	[27502009] = {
		27502009,
		0,
		Lang.get(64737),
		27502,
		9,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[27502010] = {
		27502010,
		0,
		Lang.get(64738),
		27502,
		10,
		109,
		{
			RTResTalkAction[1]
		}
	},
	[27502011] = {
		27502011,
		0,
		Lang.get(64739),
		27502,
		11,
		109,
		{
			RTResTalkAction[2]
		}
	},
	[27502012] = {
		27502012,
		0,
		Lang.get(64740),
		27502,
		12,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[27502013] = {
		27502013,
		0,
		Lang.get(64741),
		27502,
		13,
		109,
		{
			RTResTalkAction[1]
		}
	},
	[27503001] = {
		27503001,
		0,
		Lang.get(64742),
		27503,
		1,
		207,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27503,
		[19] = 27503
	},
	[27503002] = {
		27503002,
		0,
		Lang.get(64743),
		27503,
		2,
		300
	},
	[27503003] = {
		27503003,
		0,
		Lang.get(64744),
		27503,
		3,
		207,
		nil,
		1,
		nil,
		3
	},
	[27503004] = {
		27503004,
		0,
		Lang.get(64745),
		27503,
		4,
		207,
		{
			RTResTalkAction[5]
		}
	},
	[27503005] = {
		27503005,
		0,
		Lang.get(64746),
		27503,
		5,
		300,
		{
			RTResTalkAction[5]
		}
	},
	[27503006] = {
		27503006,
		0,
		Lang.get(64747),
		27503,
		6,
		207,
		{
			RTResTalkAction[5]
		}
	},
	[27503007] = {
		27503007,
		0,
		Lang.get(64748),
		27503,
		7,
		300,
		{
			RTResTalkAction[5]
		}
	},
	[27503008] = {
		27503008,
		0,
		Lang.get(64749),
		27503,
		8,
		207,
		{
			RTResTalkAction[5]
		}
	},
	[27503009] = {
		27503009,
		0,
		Lang.get(64750),
		27503,
		9,
		207,
		{
			RTResTalkAction[5]
		}
	},
	[27503010] = {
		27503010,
		0,
		Lang.get(64751),
		27503,
		10,
		300,
		{
			RTResTalkAction[5]
		}
	},
	[27503011] = {
		27503011,
		0,
		Lang.get(64752),
		27503,
		11,
		207,
		{
			RTResTalkAction[5]
		}
	},
	[27503012] = {
		27503012,
		0,
		Lang.get(64753),
		27503,
		12,
		300,
		{
			RTResTalkAction[5]
		}
	},
	[27503013] = {
		27503013,
		0,
		Lang.get(64754),
		27503,
		13,
		207,
		{
			RTResTalkAction[6]
		}
	},
	[27503014] = {
		27503014,
		0,
		Lang.get(64755),
		27503,
		14,
		207,
		{
			RTResTalkAction[5]
		}
	},
	[27504001] = {
		27504001,
		0,
		Lang.get(19439),
		27504,
		1,
		207,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27504,
		[19] = 27504
	},
	[27504002] = {
		27504002,
		0,
		Lang.get(42743),
		27504,
		2,
		300
	},
	[27504003] = {
		27504003,
		0,
		Lang.get(64756),
		27504,
		3,
		207,
		nil,
		1,
		nil,
		3
	},
	[27504004] = {
		27504004,
		4,
		nil,
		27504,
		4,
		207,
		{
			RTResTalkAction[5]
		},
		[29] = {
			{
				id = 27504005,
				branch_content = Lang.get(64757)
			},
			{
				id = 27504006,
				branch_content = Lang.get(64758)
			}
		}
	},
	[27504005] = {
		27504005,
		0,
		Lang.get(64759),
		27504,
		5,
		207,
		{
			RTResTalkAction[5]
		}
	},
	[27504006] = {
		27504006,
		0,
		Lang.get(64760),
		27504,
		6,
		207,
		{
			RTResTalkAction[5]
		}
	},
	[27504007] = {
		27504007,
		0,
		Lang.get(64761),
		27504,
		7,
		300,
		{
			RTResTalkAction[5]
		}
	},
	[27504008] = {
		27504008,
		0,
		Lang.get(64762),
		27504,
		8,
		207,
		{
			RTResTalkAction[5]
		}
	},
	[27504009] = {
		27504009,
		0,
		Lang.get(64763),
		27504,
		9,
		207,
		{
			RTResTalkAction[5]
		}
	},
	[27504010] = {
		27504010,
		0,
		Lang.get(64764),
		27504,
		10,
		300,
		{
			RTResTalkAction[5]
		}
	},
	[27504011] = {
		27504011,
		0,
		Lang.get(64765),
		27504,
		11,
		207,
		{
			RTResTalkAction[5]
		}
	},
	[27504012] = {
		27504012,
		0,
		Lang.get(64766),
		27504,
		12,
		300,
		{
			RTResTalkAction[5]
		}
	},
	[27504013] = {
		27504013,
		0,
		Lang.get(64767),
		27504,
		13,
		207,
		{
			RTResTalkAction[5]
		}
	},
	[27504014] = {
		27504014,
		0,
		Lang.get(64768),
		27504,
		14,
		207,
		{
			RTResTalkAction[5]
		}
	},
	[27504015] = {
		27504015,
		0,
		Lang.get(64769),
		27504,
		15,
		207,
		{
			RTResTalkAction[5]
		}
	},
	[27504016] = {
		27504016,
		0,
		Lang.get(64770),
		27504,
		16,
		300,
		{
			RTResTalkAction[5]
		}
	},
	[27504017] = {
		27504017,
		0,
		Lang.get(64771),
		27504,
		17,
		207,
		{
			RTResTalkAction[5]
		}
	},
	[27504018] = {
		27504018,
		0,
		Lang.get(64772),
		27504,
		18,
		207,
		{
			RTResTalkAction[5]
		}
	},
	[27505001] = {
		27505001,
		0,
		Lang.get(64773),
		27505,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		27505,
		[19] = 27505
	},
	[27505002] = {
		27505002,
		0,
		Lang.get(64774),
		27505,
		2,
		207,
		nil,
		1
	},
	[27505003] = {
		27505003,
		0,
		Lang.get(64775),
		27505,
		3,
		300,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		3
	},
	[27505004] = {
		27505004,
		0,
		Lang.get(64776),
		27505,
		4,
		207,
		{
			RTResTalkAction[7]
		}
	},
	[27505005] = {
		27505005,
		0,
		Lang.get(64777),
		27505,
		5,
		300,
		{
			RTResTalkAction[5]
		}
	},
	[27505006] = {
		27505006,
		0,
		Lang.get(64778),
		27505,
		6,
		207,
		{
			RTResTalkAction[5]
		}
	},
	[27505007] = {
		27505007,
		0,
		Lang.get(64779),
		27505,
		7,
		300,
		{
			RTResTalkAction[5]
		}
	},
	[27505008] = {
		27505008,
		0,
		Lang.get(64780),
		27505,
		8,
		207,
		{
			RTResTalkAction[5]
		}
	},
	[27505009] = {
		27505009,
		0,
		Lang.get(64781),
		27505,
		9,
		207,
		{
			RTResTalkAction[5]
		}
	},
	[27506001] = {
		27506001,
		0,
		Lang.get(64782),
		27506,
		1,
		123,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27506,
		[19] = 27506
	},
	[27506002] = {
		27506002,
		0,
		Lang.get(64783),
		27506,
		2,
		300
	},
	[27506003] = {
		27506003,
		0,
		Lang.get(64784),
		27506,
		3,
		123,
		nil,
		1,
		nil,
		3
	},
	[27506004] = {
		27506004,
		0,
		Lang.get(64785),
		27506,
		4,
		300,
		{
			RTResTalkAction[8]
		}
	},
	[27506005] = {
		27506005,
		0,
		Lang.get(64786),
		27506,
		5,
		123,
		{
			RTResTalkAction[9]
		}
	},
	[27506006] = {
		27506006,
		0,
		Lang.get(64787),
		27506,
		6,
		123,
		{
			RTResTalkAction[10]
		}
	},
	[27506007] = {
		27506007,
		0,
		Lang.get(64788),
		27506,
		7,
		123,
		{
			RTResTalkAction[10]
		}
	},
	[27506008] = {
		27506008,
		0,
		Lang.get(64789),
		27506,
		8,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[27506009] = {
		27506009,
		0,
		Lang.get(64790),
		27506,
		9,
		123,
		{
			RTResTalkAction[10]
		}
	},
	[27506010] = {
		27506010,
		0,
		Lang.get(64791),
		27506,
		10,
		123,
		{
			RTResTalkAction[10]
		}
	},
	[27506011] = {
		27506011,
		0,
		Lang.get(64792),
		27506,
		11,
		123,
		{
			RTResTalkAction[10]
		}
	},
	[27506012] = {
		27506012,
		0,
		Lang.get(64793),
		27506,
		12,
		123,
		{
			RTResTalkAction[9]
		}
	},
	[27506013] = {
		27506013,
		0,
		Lang.get(64794),
		27506,
		13,
		123,
		{
			RTResTalkAction[10]
		}
	},
	[27507001] = {
		27507001,
		0,
		Lang.get(64795),
		27507,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		27507,
		[19] = 27507
	},
	[27507002] = {
		27507002,
		0,
		Lang.get(64796),
		27507,
		2,
		123,
		nil,
		1
	},
	[27507003] = {
		27507003,
		0,
		Lang.get(64797),
		27507,
		3,
		300,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3
	},
	[27507004] = {
		27507004,
		0,
		Lang.get(64798),
		27507,
		4,
		123,
		{
			RTResTalkAction[10]
		}
	},
	[27507005] = {
		27507005,
		0,
		Lang.get(64799),
		27507,
		5,
		123,
		{
			RTResTalkAction[10]
		}
	},
	[27507006] = {
		27507006,
		0,
		Lang.get(64800),
		27507,
		6,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[27507007] = {
		27507007,
		0,
		Lang.get(64801),
		27507,
		7,
		123,
		{
			RTResTalkAction[10]
		}
	},
	[27507008] = {
		27507008,
		0,
		Lang.get(64802),
		27507,
		8,
		123,
		{
			RTResTalkAction[10]
		}
	},
	[27507009] = {
		27507009,
		0,
		Lang.get(64803),
		27507,
		9,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[27507010] = {
		27507010,
		0,
		Lang.get(64804),
		27507,
		10,
		123,
		{
			RTResTalkAction[9]
		}
	},
	[27507011] = {
		27507011,
		0,
		Lang.get(64805),
		27507,
		11,
		123,
		{
			RTResTalkAction[10]
		}
	},
	[27507012] = {
		27507012,
		0,
		Lang.get(64806),
		27507,
		12,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[27507013] = {
		27507013,
		0,
		Lang.get(64807),
		27507,
		13,
		123,
		{
			RTResTalkAction[10]
		}
	},
	[27508001] = {
		27508001,
		0,
		Lang.get(64808),
		27508,
		1,
		123,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27508,
		[19] = 27508
	},
	[27508002] = {
		27508002,
		0,
		Lang.get(64809),
		27508,
		2,
		123,
		nil,
		1
	},
	[27508003] = {
		27508003,
		0,
		Lang.get(64810),
		27508,
		3,
		300,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3
	},
	[27508004] = {
		27508004,
		0,
		Lang.get(64811),
		27508,
		4,
		123,
		{
			RTResTalkAction[11]
		}
	},
	[27508005] = {
		27508005,
		0,
		Lang.get(64812),
		27508,
		5,
		123,
		{
			RTResTalkAction[11]
		}
	},
	[27508006] = {
		27508006,
		0,
		Lang.get(64813),
		27508,
		6,
		300,
		{
			RTResTalkAction[11]
		}
	},
	[27508007] = {
		27508007,
		0,
		Lang.get(64814),
		27508,
		7,
		123,
		{
			RTResTalkAction[11]
		}
	},
	[27508008] = {
		27508008,
		0,
		Lang.get(64815),
		27508,
		8,
		123,
		{
			RTResTalkAction[11]
		}
	},
	[27508009] = {
		27508009,
		0,
		Lang.get(64816),
		27508,
		9,
		300,
		{
			RTResTalkAction[11]
		}
	},
	[27508010] = {
		27508010,
		0,
		Lang.get(64817),
		27508,
		10,
		123,
		{
			RTResTalkAction[11]
		}
	},
	[27508011] = {
		27508011,
		0,
		Lang.get(64818),
		27508,
		11,
		123,
		{
			RTResTalkAction[10]
		}
	},
	[27508012] = {
		27508012,
		0,
		Lang.get(64819),
		27508,
		12,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[27508013] = {
		27508013,
		0,
		Lang.get(64820),
		27508,
		13,
		123,
		{
			RTResTalkAction[10]
		}
	},
	[27509001] = {
		27509001,
		0,
		Lang.get(64821),
		27509,
		1,
		105,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27509,
		[19] = 27509
	},
	[27509002] = {
		27509002,
		0,
		Lang.get(64822),
		27509,
		2,
		300
	},
	[27509003] = {
		27509003,
		0,
		Lang.get(64823),
		27509,
		3,
		105,
		nil,
		1,
		nil,
		3
	},
	[27509004] = {
		27509004,
		0,
		Lang.get(64824),
		27509,
		4,
		105,
		{
			RTResTalkAction[12]
		}
	},
	[27509005] = {
		27509005,
		0,
		Lang.get(64825),
		27509,
		5,
		300,
		{
			RTResTalkAction[12]
		}
	},
	[27509006] = {
		27509006,
		0,
		Lang.get(64826),
		27509,
		6,
		105,
		{
			RTResTalkAction[12]
		}
	},
	[27509007] = {
		27509007,
		5,
		Lang.get(64827),
		27509,
		7,
		605,
		{
			RTResTalkAction[12]
		}
	},
	[27509008] = {
		27509008,
		0,
		Lang.get(32735),
		27509,
		8,
		105,
		{
			RTResTalkAction[12]
		}
	},
	[27509009] = {
		27509009,
		0,
		Lang.get(64828),
		27509,
		9,
		300,
		{
			RTResTalkAction[12]
		}
	},
	[27509010] = {
		27509010,
		0,
		Lang.get(64829),
		27509,
		10,
		105,
		{
			RTResTalkAction[12]
		}
	},
	[27509011] = {
		27509011,
		0,
		Lang.get(64830),
		27509,
		11,
		105,
		{
			RTResTalkAction[13]
		}
	},
	[27509012] = {
		27509012,
		0,
		Lang.get(64831),
		27509,
		12,
		300,
		{
			RTResTalkAction[12]
		}
	},
	[27509013] = {
		27509013,
		0,
		Lang.get(64832),
		27509,
		13,
		105,
		{
			RTResTalkAction[14]
		}
	},
	[27509014] = {
		27509014,
		0,
		Lang.get(64833),
		27509,
		14,
		105,
		{
			RTResTalkAction[14]
		}
	},
	[27509015] = {
		27509015,
		0,
		Lang.get(64834),
		27509,
		15,
		105,
		{
			RTResTalkAction[12]
		}
	},
	[27510001] = {
		27510001,
		0,
		Lang.get(64835),
		27510,
		1,
		105,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27510,
		[19] = 27510
	},
	[27510002] = {
		27510002,
		0,
		Lang.get(64836),
		27510,
		2,
		300
	},
	[27510003] = {
		27510003,
		0,
		Lang.get(64837),
		27510,
		3,
		105,
		nil,
		1,
		nil,
		3
	},
	[27510004] = {
		27510004,
		0,
		Lang.get(64838),
		27510,
		4,
		105,
		{
			RTResTalkAction[12]
		}
	},
	[27510005] = {
		27510005,
		0,
		Lang.get(64839),
		27510,
		5,
		300,
		{
			RTResTalkAction[12]
		}
	},
	[27510006] = {
		27510006,
		0,
		Lang.get(64840),
		27510,
		6,
		105,
		{
			RTResTalkAction[12]
		}
	},
	[27510007] = {
		27510007,
		0,
		Lang.get(64841),
		27510,
		7,
		300,
		{
			RTResTalkAction[12]
		}
	},
	[27510008] = {
		27510008,
		0,
		Lang.get(64842),
		27510,
		8,
		105,
		{
			RTResTalkAction[12]
		}
	},
	[27510009] = {
		27510009,
		0,
		Lang.get(64843),
		27510,
		9,
		105,
		{
			RTResTalkAction[12]
		}
	},
	[27510010] = {
		27510010,
		0,
		Lang.get(64844),
		27510,
		10,
		300,
		{
			RTResTalkAction[12]
		}
	},
	[27510011] = {
		27510011,
		0,
		Lang.get(64845),
		27510,
		11,
		300,
		{
			RTResTalkAction[12]
		}
	},
	[27510012] = {
		27510012,
		0,
		Lang.get(64846),
		27510,
		12,
		105,
		{
			RTResTalkAction[12]
		}
	},
	[27510013] = {
		27510013,
		0,
		Lang.get(64847),
		27510,
		13,
		105,
		{
			RTResTalkAction[12]
		}
	},
	[27511001] = {
		27511001,
		0,
		Lang.get(64848),
		27511,
		1,
		105,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27511,
		[19] = 27511
	},
	[27511002] = {
		27511002,
		0,
		Lang.get(64849),
		27511,
		2,
		300
	},
	[27511003] = {
		27511003,
		0,
		Lang.get(64850),
		27511,
		3,
		105,
		nil,
		1,
		nil,
		3
	},
	[27511004] = {
		27511004,
		0,
		Lang.get(64851),
		27511,
		4,
		300,
		{
			RTResTalkAction[12]
		}
	},
	[27511005] = {
		27511005,
		0,
		Lang.get(66386),
		27511,
		5,
		105,
		{
			RTResTalkAction[12]
		}
	},
	[27511006] = {
		27511006,
		0,
		Lang.get(64853),
		27511,
		6,
		300,
		{
			RTResTalkAction[12]
		}
	},
	[27511007] = {
		27511007,
		0,
		Lang.get(64854),
		27511,
		7,
		105,
		{
			RTResTalkAction[12]
		}
	},
	[27511008] = {
		27511008,
		0,
		Lang.get(64855),
		27511,
		8,
		105,
		{
			RTResTalkAction[12]
		}
	},
	[27511009] = {
		27511009,
		0,
		Lang.get(64856),
		27511,
		9,
		105,
		{
			RTResTalkAction[12]
		}
	},
	[27511010] = {
		27511010,
		0,
		Lang.get(64857),
		27511,
		10,
		300,
		{
			RTResTalkAction[12]
		}
	},
	[27511011] = {
		27511011,
		0,
		Lang.get(64858),
		27511,
		11,
		105,
		{
			RTResTalkAction[12]
		}
	},
	[27511012] = {
		27511012,
		0,
		Lang.get(64859),
		27511,
		12,
		105,
		{
			RTResTalkAction[12]
		}
	},
	[27511013] = {
		27511013,
		0,
		Lang.get(64860),
		27511,
		13,
		105,
		{
			RTResTalkAction[12]
		}
	},
	[27512001] = {
		27512001,
		0,
		Lang.get(64861),
		27512,
		1,
		150,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27512,
		[19] = 27512
	},
	[27512002] = {
		27512002,
		0,
		Lang.get(64862),
		27512,
		2,
		150,
		nil,
		1
	},
	[27512003] = {
		27512003,
		0,
		Lang.get(64863),
		27512,
		3,
		300,
		{
			RTResTalkAction[15]
		},
		nil,
		nil,
		3
	},
	[27512004] = {
		27512004,
		0,
		Lang.get(64864),
		27512,
		4,
		150,
		{
			RTResTalkAction[16]
		}
	},
	[27512005] = {
		27512005,
		0,
		Lang.get(64865),
		27512,
		5,
		300,
		{
			RTResTalkAction[15]
		}
	},
	[27512006] = {
		27512006,
		0,
		Lang.get(64866),
		27512,
		6,
		150,
		{
			RTResTalkAction[17]
		}
	},
	[27512007] = {
		27512007,
		0,
		Lang.get(64867),
		27512,
		7,
		300,
		{
			RTResTalkAction[15]
		}
	},
	[27512008] = {
		27512008,
		0,
		Lang.get(64868),
		27512,
		8,
		150,
		{
			RTResTalkAction[18]
		}
	},
	[27512009] = {
		27512009,
		0,
		Lang.get(64869),
		27512,
		9,
		150,
		{
			RTResTalkAction[19]
		}
	},
	[27512010] = {
		27512010,
		0,
		Lang.get(64870),
		27512,
		10,
		300,
		{
			RTResTalkAction[15]
		}
	},
	[27512011] = {
		27512011,
		0,
		Lang.get(64871),
		27512,
		11,
		150,
		{
			RTResTalkAction[20]
		}
	},
	[27512012] = {
		27512012,
		0,
		Lang.get(64872),
		27512,
		12,
		300,
		{
			RTResTalkAction[15]
		}
	},
	[27512013] = {
		27512013,
		0,
		Lang.get(64873),
		27512,
		13,
		150,
		{
			RTResTalkAction[17]
		}
	},
	[27512014] = {
		27512014,
		0,
		Lang.get(64874),
		27512,
		14,
		300,
		{
			RTResTalkAction[15]
		}
	},
	[27512015] = {
		27512015,
		0,
		Lang.get(64875),
		27512,
		15,
		150,
		{
			RTResTalkAction[20]
		}
	},
	[27513001] = {
		27513001,
		0,
		Lang.get(64876),
		27513,
		1,
		150,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27513,
		[19] = 27513
	},
	[27513002] = {
		27513002,
		0,
		Lang.get(64877),
		27513,
		2,
		150,
		nil,
		1
	},
	[27513003] = {
		27513003,
		0,
		Lang.get(64878),
		27513,
		3,
		300,
		{
			RTResTalkAction[15]
		},
		nil,
		nil,
		3
	},
	[27513004] = {
		27513004,
		0,
		Lang.get(64879),
		27513,
		4,
		150,
		{
			RTResTalkAction[19]
		}
	},
	[27513005] = {
		27513005,
		0,
		Lang.get(64880),
		27513,
		5,
		300,
		{
			RTResTalkAction[15]
		}
	},
	[27513006] = {
		27513006,
		0,
		Lang.get(64881),
		27513,
		6,
		150,
		{
			RTResTalkAction[20]
		}
	},
	[27513007] = {
		27513007,
		0,
		Lang.get(64882),
		27513,
		7,
		300,
		{
			RTResTalkAction[15]
		}
	},
	[27513008] = {
		27513008,
		0,
		Lang.get(64883),
		27513,
		8,
		150,
		{
			RTResTalkAction[16]
		}
	},
	[27513009] = {
		27513009,
		0,
		Lang.get(64884),
		27513,
		9,
		300,
		{
			RTResTalkAction[15]
		}
	},
	[27513010] = {
		27513010,
		0,
		Lang.get(64885),
		27513,
		10,
		150,
		{
			RTResTalkAction[20]
		}
	},
	[27513011] = {
		27513011,
		0,
		Lang.get(64886),
		27513,
		11,
		150,
		{
			RTResTalkAction[19]
		}
	},
	[27513012] = {
		27513012,
		0,
		Lang.get(64887),
		27513,
		12,
		150,
		{
			RTResTalkAction[21]
		}
	},
	[27513013] = {
		27513013,
		0,
		Lang.get(28278),
		27513,
		13,
		300,
		{
			RTResTalkAction[15]
		}
	},
	[27513014] = {
		27513014,
		0,
		Lang.get(64888),
		27513,
		14,
		150,
		{
			RTResTalkAction[20]
		}
	},
	[27514001] = {
		27514001,
		0,
		Lang.get(64889),
		27514,
		1,
		150,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27514,
		[19] = 27514
	},
	[27514002] = {
		27514002,
		0,
		Lang.get(64890),
		27514,
		2,
		300
	},
	[27514003] = {
		27514003,
		0,
		Lang.get(64891),
		27514,
		3,
		150,
		nil,
		1,
		nil,
		3
	},
	[27514004] = {
		27514004,
		0,
		Lang.get(64892),
		27514,
		4,
		300,
		{
			RTResTalkAction[15]
		}
	},
	[27514005] = {
		27514005,
		0,
		Lang.get(64893),
		27514,
		5,
		150,
		{
			RTResTalkAction[18]
		}
	},
	[27514006] = {
		27514006,
		0,
		Lang.get(64894),
		27514,
		6,
		150,
		{
			RTResTalkAction[21]
		}
	},
	[27514007] = {
		27514007,
		0,
		Lang.get(64895),
		27514,
		7,
		300,
		{
			RTResTalkAction[15]
		}
	},
	[27514008] = {
		27514008,
		0,
		Lang.get(64896),
		27514,
		8,
		150,
		{
			RTResTalkAction[19]
		}
	},
	[27514009] = {
		27514009,
		0,
		Lang.get(64897),
		27514,
		9,
		300,
		{
			RTResTalkAction[15]
		}
	},
	[27514010] = {
		27514010,
		0,
		Lang.get(64898),
		27514,
		10,
		150,
		{
			RTResTalkAction[22]
		}
	},
	[27514011] = {
		27514011,
		4,
		nil,
		27514,
		11,
		150,
		{
			RTResTalkAction[21]
		},
		[29] = {
			{
				id = 27514012,
				branch_content = Lang.get(64899)
			},
			{
				id = 27514012,
				branch_content = Lang.get(64900)
			}
		}
	},
	[27514012] = {
		27514012,
		0,
		Lang.get(64901),
		27514,
		12,
		150,
		{
			RTResTalkAction[17]
		}
	},
	[27514013] = {
		27514013,
		0,
		Lang.get(64902),
		27514,
		13,
		150,
		{
			RTResTalkAction[16]
		}
	},
	[27515001] = {
		27515001,
		0,
		Lang.get(65935),
		27515,
		1,
		148,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27515,
		[19] = 27515
	},
	[27515002] = {
		27515002,
		4,
		nil,
		27515,
		2,
		148,
		nil,
		1,
		[29] = {
			{
				id = 27515003,
				branch_content = Lang.get(65936)
			}
		}
	},
	[27515003] = {
		27515003,
		0,
		Lang.get(65937),
		27515,
		3,
		148,
		nil,
		1,
		nil,
		3
	},
	[27515004] = {
		27515004,
		0,
		Lang.get(65938),
		27515,
		4,
		300,
		{
			RTResTalkAction[23]
		}
	},
	[27515005] = {
		27515005,
		0,
		Lang.get(65939),
		27515,
		5,
		148,
		{
			RTResTalkAction[23]
		}
	},
	[27515006] = {
		27515006,
		4,
		nil,
		27515,
		6,
		148,
		{
			RTResTalkAction[23]
		},
		[29] = {
			{
				id = 27515007,
				branch_content = Lang.get(65940)
			}
		}
	},
	[27515007] = {
		27515007,
		0,
		Lang.get(65941),
		27515,
		7,
		148,
		{
			RTResTalkAction[24]
		}
	},
	[27515008] = {
		27515008,
		4,
		nil,
		27515,
		8,
		148,
		{
			RTResTalkAction[23]
		},
		[29] = {
			{
				id = 27515009,
				branch_content = Lang.get(65942)
			}
		}
	},
	[27515009] = {
		27515009,
		0,
		Lang.get(65943),
		27515,
		9,
		148,
		{
			RTResTalkAction[23]
		}
	},
	[27515010] = {
		27515010,
		0,
		Lang.get(65944),
		27515,
		10,
		148,
		{
			RTResTalkAction[23]
		}
	},
	[27515011] = {
		27515011,
		0,
		Lang.get(65945),
		27515,
		11,
		148,
		{
			RTResTalkAction[23]
		}
	},
	[27515012] = {
		27515012,
		4,
		nil,
		27515,
		12,
		148,
		{
			RTResTalkAction[23]
		},
		[29] = {
			{
				id = 27515013,
				branch_content = Lang.get(65946)
			}
		}
	},
	[27515013] = {
		27515013,
		0,
		Lang.get(65947),
		27515,
		13,
		148,
		{
			RTResTalkAction[23]
		}
	},
	[27516001] = {
		27516001,
		0,
		Lang.get(65948),
		27516,
		1,
		148,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27516,
		[19] = 27516
	},
	[27516002] = {
		27516002,
		0,
		Lang.get(65949),
		27516,
		2,
		300
	},
	[27516003] = {
		27516003,
		0,
		Lang.get(65950),
		27516,
		3,
		148,
		nil,
		1,
		nil,
		3
	},
	[27516004] = {
		27516004,
		0,
		Lang.get(65951),
		27516,
		4,
		148,
		{
			RTResTalkAction[23]
		}
	},
	[27516005] = {
		27516005,
		0,
		Lang.get(65952),
		27516,
		5,
		148,
		{
			RTResTalkAction[23]
		}
	},
	[27516006] = {
		27516006,
		0,
		Lang.get(65953),
		27516,
		6,
		148,
		{
			RTResTalkAction[23]
		}
	},
	[27516007] = {
		27516007,
		4,
		nil,
		27516,
		7,
		148,
		{
			RTResTalkAction[23]
		},
		[29] = {
			{
				id = 27516008,
				branch_content = Lang.get(65954)
			},
			{
				id = 27516008,
				branch_content = Lang.get(65955)
			}
		}
	},
	[27516008] = {
		27516008,
		0,
		Lang.get(65956),
		27516,
		8,
		148,
		{
			RTResTalkAction[23]
		}
	},
	[27516009] = {
		27516009,
		4,
		nil,
		27516,
		9,
		148,
		{
			RTResTalkAction[23]
		},
		[29] = {
			{
				id = 27516010,
				branch_content = Lang.get(65957)
			}
		}
	},
	[27516010] = {
		27516010,
		0,
		Lang.get(65958),
		27516,
		10,
		148,
		{
			RTResTalkAction[23]
		}
	},
	[27516011] = {
		27516011,
		0,
		Lang.get(65959),
		27516,
		11,
		148,
		{
			RTResTalkAction[24]
		}
	},
	[27516012] = {
		27516012,
		0,
		Lang.get(65960),
		27516,
		12,
		148,
		{
			RTResTalkAction[23]
		}
	},
	[27516013] = {
		27516013,
		0,
		Lang.get(65961),
		27516,
		13,
		148,
		{
			RTResTalkAction[23]
		}
	},
	[27516014] = {
		27516014,
		4,
		nil,
		27516,
		14,
		148,
		{
			RTResTalkAction[23]
		},
		[29] = {
			{
				id = 27516015,
				branch_content = Lang.get(65962)
			}
		}
	},
	[27516015] = {
		27516015,
		0,
		Lang.get(65963),
		27516,
		15,
		148,
		{
			RTResTalkAction[23]
		}
	},
	[27517001] = {
		27517001,
		0,
		Lang.get(65964),
		27517,
		1,
		148,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27517,
		[19] = 27517
	},
	[27517002] = {
		27517002,
		4,
		nil,
		27517,
		2,
		148,
		nil,
		1,
		[29] = {
			{
				id = 27517003,
				branch_content = Lang.get(65965)
			}
		}
	},
	[27517003] = {
		27517003,
		0,
		Lang.get(65966),
		27517,
		3,
		148,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[27517004] = {
		27517004,
		4,
		nil,
		27517,
		4,
		148,
		{
			RTResTalkAction[23]
		},
		[29] = {
			{
				id = 27517005,
				branch_content = Lang.get(65967)
			}
		}
	},
	[27517005] = {
		27517005,
		0,
		Lang.get(65968),
		27517,
		5,
		148,
		{
			RTResTalkAction[23]
		}
	},
	[27517006] = {
		27517006,
		4,
		nil,
		27517,
		6,
		148,
		{
			RTResTalkAction[23]
		},
		[29] = {
			{
				id = 27517007,
				branch_content = Lang.get(65969)
			},
			{
				id = 27517007,
				branch_content = Lang.get(65970)
			}
		}
	},
	[27517007] = {
		27517007,
		0,
		Lang.get(65971),
		27517,
		7,
		148,
		{
			RTResTalkAction[23]
		}
	},
	[27517008] = {
		27517008,
		4,
		nil,
		27517,
		8,
		148,
		{
			RTResTalkAction[23]
		},
		[29] = {
			{
				id = 27517009,
				branch_content = Lang.get(65972)
			}
		}
	},
	[27517009] = {
		27517009,
		0,
		Lang.get(65973),
		27517,
		9,
		148,
		{
			RTResTalkAction[23]
		}
	},
	[27517010] = {
		27517010,
		4,
		nil,
		27517,
		10,
		148,
		{
			RTResTalkAction[23]
		},
		[29] = {
			{
				id = 27517011,
				branch_content = Lang.get(65974)
			}
		}
	},
	[27517011] = {
		27517011,
		0,
		Lang.get(65975),
		27517,
		11,
		148,
		{
			RTResTalkAction[23]
		}
	},
	[27517012] = {
		27517012,
		0,
		Lang.get(65976),
		27517,
		12,
		148,
		{
			RTResTalkAction[23]
		}
	},
	[27517013] = {
		27517013,
		0,
		Lang.get(65977),
		27517,
		13,
		148,
		{
			RTResTalkAction[24]
		}
	},
	[27517014] = {
		27517014,
		0,
		Lang.get(65978),
		27517,
		14,
		148,
		{
			RTResTalkAction[23]
		}
	},
	[27518001] = {
		27518001,
		0,
		Lang.get(65979),
		27518,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		27518,
		[19] = 27518
	},
	[27518002] = {
		27518002,
		0,
		Lang.get(65980),
		27518,
		2,
		278,
		nil,
		1
	},
	[27518003] = {
		27518003,
		0,
		Lang.get(65981),
		27518,
		3,
		278,
		nil,
		1
	},
	[27518004] = {
		27518004,
		0,
		Lang.get(65982),
		27518,
		4,
		300
	},
	[27518005] = {
		27518005,
		0,
		Lang.get(65983),
		27518,
		5,
		300
	},
	[27518006] = {
		27518006,
		0,
		Lang.get(65984),
		27518,
		6,
		278,
		{
			RTResTalkAction[25]
		},
		nil,
		nil,
		3
	},
	[27518007] = {
		27518007,
		0,
		Lang.get(77403),
		27518,
		7,
		278,
		{
			RTResTalkAction[25]
		}
	},
	[27518008] = {
		27518008,
		0,
		Lang.get(65986),
		27518,
		8,
		300,
		{
			RTResTalkAction[25]
		}
	},
	[27518009] = {
		27518009,
		0,
		Lang.get(65987),
		27518,
		9,
		278,
		{
			RTResTalkAction[26]
		}
	},
	[27518010] = {
		27518010,
		0,
		Lang.get(65988),
		27518,
		10,
		300,
		{
			RTResTalkAction[25]
		}
	},
	[27518011] = {
		27518011,
		0,
		Lang.get(65989),
		27518,
		11,
		278,
		{
			RTResTalkAction[25]
		}
	},
	[27518012] = {
		27518012,
		0,
		Lang.get(65990),
		27518,
		12,
		300,
		{
			RTResTalkAction[25]
		}
	},
	[27518013] = {
		27518013,
		0,
		"？？？",
		27518,
		13,
		300,
		{
			RTResTalkAction[25]
		}
	},
	[27519001] = {
		27519001,
		0,
		Lang.get(65991),
		27519,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		27519,
		[19] = 27519
	},
	[27519002] = {
		27519002,
		0,
		Lang.get(65992),
		27519,
		2,
		278,
		nil,
		1
	},
	[27519003] = {
		27519003,
		0,
		Lang.get(65229),
		27519,
		3,
		300
	},
	[27519004] = {
		27519004,
		0,
		Lang.get(65993),
		27519,
		4,
		278,
		nil,
		1
	},
	[27519005] = {
		27519005,
		0,
		Lang.get(65994),
		27519,
		5,
		278,
		{
			RTResTalkAction[25]
		},
		nil,
		nil,
		3
	},
	[27519006] = {
		27519006,
		0,
		Lang.get(65995),
		27519,
		6,
		278,
		{
			RTResTalkAction[25]
		}
	},
	[27519007] = {
		27519007,
		0,
		Lang.get(65996),
		27519,
		7,
		278,
		{
			RTResTalkAction[25]
		}
	},
	[27519008] = {
		27519008,
		0,
		Lang.get(65997),
		27519,
		8,
		278,
		{
			RTResTalkAction[25]
		}
	},
	[27519009] = {
		27519009,
		0,
		Lang.get(65998),
		27519,
		9,
		300,
		{
			RTResTalkAction[25]
		}
	},
	[27519010] = {
		27519010,
		0,
		Lang.get(65999),
		27519,
		10,
		278,
		{
			RTResTalkAction[25]
		}
	},
	[27519011] = {
		27519011,
		0,
		Lang.get(66000),
		27519,
		11,
		300,
		{
			RTResTalkAction[25]
		}
	},
	[27519012] = {
		27519012,
		0,
		Lang.get(66001),
		27519,
		12,
		278,
		{
			RTResTalkAction[26]
		}
	},
	[27519013] = {
		27519013,
		0,
		Lang.get(66002),
		27519,
		13,
		278,
		{
			RTResTalkAction[25]
		}
	},
	[27519014] = {
		27519014,
		0,
		Lang.get(66003),
		27519,
		14,
		300,
		{
			RTResTalkAction[25]
		}
	},
	[27519015] = {
		27519015,
		0,
		Lang.get(66004),
		27519,
		15,
		278,
		{
			RTResTalkAction[25]
		}
	},
	[27519016] = {
		27519016,
		0,
		Lang.get(66005),
		27519,
		16,
		300,
		{
			RTResTalkAction[25]
		}
	},
	[27519017] = {
		27519017,
		0,
		Lang.get(66006),
		27519,
		17,
		278,
		{
			RTResTalkAction[26]
		}
	},
	[27519018] = {
		27519018,
		0,
		Lang.get(66007),
		27519,
		18,
		300,
		{
			RTResTalkAction[25]
		}
	},
	[27520001] = {
		27520001,
		0,
		Lang.get(66008),
		27520,
		1,
		278,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27520,
		[19] = 27520
	},
	[27520002] = {
		27520002,
		0,
		Lang.get(38282),
		27520,
		2,
		300
	},
	[27520003] = {
		27520003,
		0,
		Lang.get(66009),
		27520,
		3,
		278,
		nil,
		1
	},
	[27520004] = {
		27520004,
		0,
		Lang.get(66010),
		27520,
		4,
		300,
		{
			RTResTalkAction[25]
		},
		nil,
		nil,
		3
	},
	[27520005] = {
		27520005,
		0,
		Lang.get(66011),
		27520,
		5,
		278,
		{
			RTResTalkAction[25]
		}
	},
	[27520006] = {
		27520006,
		0,
		Lang.get(66012),
		27520,
		6,
		300,
		{
			RTResTalkAction[25]
		}
	},
	[27520007] = {
		27520007,
		0,
		Lang.get(66013),
		27520,
		7,
		278,
		{
			RTResTalkAction[26]
		}
	},
	[27520008] = {
		27520008,
		0,
		Lang.get(66014),
		27520,
		8,
		278,
		{
			RTResTalkAction[25]
		}
	},
	[27520009] = {
		27520009,
		0,
		Lang.get(66015),
		27520,
		9,
		300,
		{
			RTResTalkAction[25]
		}
	},
	[27520010] = {
		27520010,
		0,
		Lang.get(66016),
		27520,
		10,
		278,
		{
			RTResTalkAction[25]
		}
	},
	[27520011] = {
		27520011,
		0,
		Lang.get(66017),
		27520,
		11,
		300,
		{
			RTResTalkAction[25]
		}
	},
	[27520012] = {
		27520012,
		0,
		Lang.get(66018),
		27520,
		12,
		278,
		{
			RTResTalkAction[25]
		}
	},
	[27520013] = {
		27520013,
		0,
		Lang.get(66019),
		27520,
		13,
		278,
		{
			RTResTalkAction[26]
		}
	},
	[27520014] = {
		27520014,
		0,
		Lang.get(66020),
		27520,
		14,
		278,
		{
			RTResTalkAction[25]
		}
	},
	[27520015] = {
		27520015,
		0,
		Lang.get(66021),
		27520,
		15,
		300,
		{
			RTResTalkAction[25]
		}
	},
	[27521001] = {
		27521001,
		0,
		Lang.get(66022),
		27521,
		1,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27521,
		[19] = 27521
	},
	[27521002] = {
		27521002,
		0,
		Lang.get(66023),
		27521,
		2,
		300
	},
	[27521003] = {
		27521003,
		0,
		Lang.get(66024),
		27521,
		3,
		158,
		nil,
		1,
		nil,
		3
	},
	[27521004] = {
		27521004,
		0,
		Lang.get(26933),
		27521,
		4,
		300,
		{
			RTResTalkAction[27]
		}
	},
	[27521005] = {
		27521005,
		0,
		Lang.get(66025),
		27521,
		5,
		158,
		{
			RTResTalkAction[27]
		}
	},
	[27521006] = {
		27521006,
		0,
		Lang.get(66026),
		27521,
		6,
		158,
		{
			RTResTalkAction[28]
		}
	},
	[27521007] = {
		27521007,
		0,
		Lang.get(66027),
		27521,
		7,
		300,
		{
			RTResTalkAction[27]
		}
	},
	[27521008] = {
		27521008,
		0,
		Lang.get(66028),
		27521,
		8,
		158,
		{
			RTResTalkAction[29]
		}
	},
	[27521009] = {
		27521009,
		0,
		Lang.get(66029),
		27521,
		9,
		300,
		{
			RTResTalkAction[27]
		}
	},
	[27521010] = {
		27521010,
		0,
		Lang.get(66030),
		27521,
		10,
		158,
		{
			RTResTalkAction[30]
		}
	},
	[27521011] = {
		27521011,
		0,
		Lang.get(66031),
		27521,
		11,
		300,
		{
			RTResTalkAction[27]
		}
	},
	[27521012] = {
		27521012,
		0,
		Lang.get(66032),
		27521,
		12,
		158,
		{
			RTResTalkAction[31]
		}
	},
	[27521013] = {
		27521013,
		0,
		Lang.get(66033),
		27521,
		13,
		300,
		{
			RTResTalkAction[27]
		}
	},
	[27521014] = {
		27521014,
		0,
		Lang.get(66034),
		27521,
		14,
		158,
		{
			RTResTalkAction[31]
		}
	},
	[27521015] = {
		27521015,
		0,
		Lang.get(66035),
		27521,
		15,
		158,
		{
			RTResTalkAction[28]
		}
	},
	[27522001] = {
		27522001,
		0,
		Lang.get(66036),
		27522,
		1,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27522,
		[19] = 27522
	},
	[27522002] = {
		27522002,
		0,
		Lang.get(66037),
		27522,
		2,
		300
	},
	[27522003] = {
		27522003,
		0,
		Lang.get(66038),
		27522,
		3,
		158,
		nil,
		1,
		nil,
		3
	},
	[27522004] = {
		27522004,
		0,
		Lang.get(66039),
		27522,
		4,
		300,
		{
			RTResTalkAction[27]
		}
	},
	[27522005] = {
		27522005,
		0,
		Lang.get(66040),
		27522,
		5,
		158,
		{
			RTResTalkAction[32]
		}
	},
	[27522006] = {
		27522006,
		0,
		Lang.get(66041),
		27522,
		6,
		300,
		{
			RTResTalkAction[27]
		}
	},
	[27522007] = {
		27522007,
		0,
		Lang.get(66042),
		27522,
		7,
		158,
		{
			RTResTalkAction[33]
		}
	},
	[27522008] = {
		27522008,
		0,
		Lang.get(66043),
		27522,
		8,
		158,
		{
			RTResTalkAction[33]
		}
	},
	[27522009] = {
		27522009,
		0,
		Lang.get(66044),
		27522,
		9,
		158,
		{
			RTResTalkAction[34]
		}
	},
	[27522010] = {
		27522010,
		0,
		Lang.get(66045),
		27522,
		10,
		300,
		{
			RTResTalkAction[27]
		}
	},
	[27522011] = {
		27522011,
		0,
		Lang.get(66046),
		27522,
		11,
		158,
		{
			RTResTalkAction[35]
		}
	},
	[27522012] = {
		27522012,
		0,
		Lang.get(66047),
		27522,
		12,
		300,
		{
			RTResTalkAction[27]
		}
	},
	[27522013] = {
		27522013,
		0,
		Lang.get(66048),
		27522,
		13,
		158,
		{
			RTResTalkAction[36]
		}
	},
	[27522014] = {
		27522014,
		0,
		Lang.get(66049),
		27522,
		14,
		158,
		{
			RTResTalkAction[37]
		}
	},
	[27522015] = {
		27522015,
		0,
		Lang.get(66050),
		27522,
		15,
		300,
		{
			RTResTalkAction[27]
		}
	},
	[27523001] = {
		27523001,
		0,
		Lang.get(66051),
		27523,
		1,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27523,
		[19] = 27523
	},
	[27523002] = {
		27523002,
		0,
		Lang.get(19902),
		27523,
		2,
		300
	},
	[27523003] = {
		27523003,
		0,
		Lang.get(66052),
		27523,
		3,
		158,
		nil,
		1,
		nil,
		3
	},
	[27523004] = {
		27523004,
		0,
		Lang.get(66053),
		27523,
		4,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[27523005] = {
		27523005,
		0,
		Lang.get(66054),
		27523,
		5,
		158,
		{
			RTResTalkAction[36]
		}
	},
	[27523006] = {
		27523006,
		0,
		Lang.get(66055),
		27523,
		6,
		158,
		{
			RTResTalkAction[36]
		}
	},
	[27523007] = {
		27523007,
		0,
		Lang.get(66056),
		27523,
		7,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[27523008] = {
		27523008,
		0,
		Lang.get(66057),
		27523,
		8,
		158,
		{
			RTResTalkAction[36]
		}
	},
	[27523009] = {
		27523009,
		0,
		Lang.get(66058),
		27523,
		9,
		158,
		{
			RTResTalkAction[36]
		}
	},
	[27523010] = {
		27523010,
		4,
		nil,
		27523,
		10,
		158,
		{
			RTResTalkAction[36]
		},
		[29] = {
			{
				id = 27523011,
				branch_content = Lang.get(66059)
			},
			{
				id = 27523012,
				branch_content = Lang.get(66060)
			}
		}
	},
	[27523011] = {
		27523011,
		0,
		Lang.get(66061),
		27523,
		11,
		158,
		{
			RTResTalkAction[36]
		}
	},
	[27523012] = {
		27523012,
		0,
		Lang.get(66062),
		27523,
		12,
		158,
		{
			RTResTalkAction[36]
		}
	},
	[27523013] = {
		27523013,
		0,
		Lang.get(66063),
		27523,
		13,
		158,
		{
			RTResTalkAction[37]
		}
	},
	[27523014] = {
		27523014,
		0,
		Lang.get(66064),
		27523,
		14,
		158,
		{
			RTResTalkAction[38]
		}
	},
	[27524001] = {
		27524001,
		0,
		Lang.get(52052),
		27524,
		1,
		239,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27524,
		[19] = 27524
	},
	[27524002] = {
		27524002,
		0,
		Lang.get(52053),
		27524,
		2,
		239,
		nil,
		1
	},
	[27524003] = {
		27524003,
		0,
		Lang.get(52054),
		27524,
		3,
		239,
		nil,
		1,
		nil,
		3
	},
	[27524004] = {
		27524004,
		4,
		nil,
		27524,
		4,
		239,
		{
			RTResTalkAction[39]
		},
		[29] = {
			{
				id = 27524005,
				branch_content = Lang.get(66065)
			}
		}
	},
	[27524005] = {
		27524005,
		0,
		Lang.get(52055),
		27524,
		5,
		239,
		{
			RTResTalkAction[39]
		}
	},
	[27524006] = {
		27524006,
		4,
		nil,
		27524,
		6,
		239,
		{
			RTResTalkAction[39]
		},
		[29] = {
			{
				id = 27524007,
				branch_content = Lang.get(66066)
			},
			{
				id = 27524007,
				branch_content = Lang.get(66067)
			}
		}
	},
	[27524007] = {
		27524007,
		0,
		Lang.get(52056),
		27524,
		7,
		239,
		{
			RTResTalkAction[39]
		}
	},
	[27524008] = {
		27524008,
		0,
		Lang.get(52057),
		27524,
		8,
		239,
		{
			RTResTalkAction[40]
		}
	},
	[27524009] = {
		27524009,
		4,
		nil,
		27524,
		9,
		239,
		{
			RTResTalkAction[39]
		},
		[29] = {
			{
				id = 27524010,
				branch_content = Lang.get(66068)
			},
			{
				id = 27524010,
				branch_content = Lang.get(66069)
			}
		}
	},
	[27524010] = {
		27524010,
		0,
		Lang.get(27595),
		27524,
		10,
		239,
		{
			RTResTalkAction[39]
		}
	},
	[27524011] = {
		27524011,
		0,
		Lang.get(66070),
		27524,
		11,
		239,
		{
			RTResTalkAction[39]
		}
	},
	[27524012] = {
		27524012,
		4,
		nil,
		27524,
		12,
		239,
		{
			RTResTalkAction[39]
		},
		[29] = {
			{
				id = 27524013,
				branch_content = Lang.get(22568)
			}
		}
	},
	[27524013] = {
		27524013,
		0,
		Lang.get(66071),
		27524,
		13,
		239,
		{
			RTResTalkAction[39]
		}
	},
	[27524014] = {
		27524014,
		0,
		Lang.get(66072),
		27524,
		14,
		239,
		{
			RTResTalkAction[40]
		}
	},
	[27525001] = {
		27525001,
		0,
		Lang.get(66073),
		27525,
		1,
		239,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27525,
		[19] = 27525
	},
	[27525002] = {
		27525002,
		4,
		nil,
		27525,
		2,
		239,
		nil,
		1,
		[29] = {
			{
				id = 27525003,
				branch_content = Lang.get(66074)
			},
			{
				id = 27525003,
				branch_content = Lang.get(66075)
			}
		}
	},
	[27525003] = {
		27525003,
		0,
		Lang.get(66076),
		27525,
		3,
		239,
		nil,
		1,
		nil,
		3
	},
	[27525004] = {
		27525004,
		4,
		nil,
		27525,
		4,
		239,
		{
			RTResTalkAction[39]
		},
		[29] = {
			{
				id = 27525005,
				branch_content = Lang.get(66077)
			}
		}
	},
	[27525005] = {
		27525005,
		0,
		Lang.get(66078),
		27525,
		5,
		239,
		{
			RTResTalkAction[39]
		}
	},
	[27525006] = {
		27525006,
		0,
		Lang.get(66079),
		27525,
		6,
		300,
		{
			RTResTalkAction[39]
		}
	},
	[27525007] = {
		27525007,
		0,
		Lang.get(66080),
		27525,
		7,
		239,
		{
			RTResTalkAction[39]
		}
	},
	[27525008] = {
		27525008,
		4,
		nil,
		27525,
		8,
		239,
		{
			RTResTalkAction[39]
		},
		[29] = {
			{
				id = 27525009,
				branch_content = Lang.get(66081)
			},
			{
				id = 27525009,
				branch_content = Lang.get(66082)
			}
		}
	},
	[27525009] = {
		27525009,
		0,
		Lang.get(66083),
		27525,
		9,
		239,
		{
			RTResTalkAction[39]
		}
	},
	[27525010] = {
		27525010,
		4,
		nil,
		27525,
		10,
		239,
		{
			RTResTalkAction[39]
		},
		[29] = {
			{
				id = 27525011,
				branch_content = Lang.get(66084)
			},
			{
				id = 27525011,
				branch_content = Lang.get(66085)
			}
		}
	},
	[27525011] = {
		27525011,
		0,
		Lang.get(66086),
		27525,
		11,
		239,
		{
			RTResTalkAction[40]
		}
	},
	[27525012] = {
		27525012,
		0,
		Lang.get(66087),
		27525,
		12,
		239,
		{
			RTResTalkAction[39]
		}
	},
	[27526001] = {
		27526001,
		0,
		Lang.get(66088),
		27526,
		1,
		239,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27526,
		[19] = 27526
	},
	[27526002] = {
		27526002,
		0,
		Lang.get(66089),
		27526,
		2,
		239,
		nil,
		1
	},
	[27526003] = {
		27526003,
		4,
		nil,
		27526,
		3,
		239,
		nil,
		1,
		nil,
		3,
		[29] = {
			{
				id = 27526004,
				branch_content = Lang.get(66090)
			},
			{
				id = 27526004,
				branch_content = Lang.get(66091)
			}
		}
	},
	[27526004] = {
		27526004,
		0,
		Lang.get(66092),
		27526,
		4,
		239,
		{
			RTResTalkAction[39]
		}
	},
	[27526005] = {
		27526005,
		4,
		nil,
		27526,
		5,
		239,
		{
			RTResTalkAction[39]
		},
		[29] = {
			{
				id = 27526006,
				branch_content = Lang.get(66093)
			},
			{
				id = 27526006,
				branch_content = Lang.get(66094)
			}
		}
	},
	[27526006] = {
		27526006,
		0,
		Lang.get(66095),
		27526,
		6,
		239,
		{
			RTResTalkAction[39]
		}
	},
	[27526007] = {
		27526007,
		0,
		Lang.get(66096),
		27526,
		7,
		239,
		{
			RTResTalkAction[39]
		}
	},
	[27526008] = {
		27526008,
		0,
		Lang.get(66097),
		27526,
		8,
		239,
		{
			RTResTalkAction[39]
		}
	},
	[27526009] = {
		27526009,
		4,
		nil,
		27526,
		9,
		239,
		{
			RTResTalkAction[39]
		},
		[29] = {
			{
				id = 27526010,
				branch_content = Lang.get(66098)
			},
			{
				id = 27526010,
				branch_content = Lang.get(66099)
			}
		}
	},
	[27526010] = {
		27526010,
		0,
		Lang.get(66100),
		27526,
		10,
		239,
		{
			RTResTalkAction[39]
		}
	},
	[27526011] = {
		27526011,
		0,
		Lang.get(66101),
		27526,
		11,
		239,
		{
			RTResTalkAction[40]
		}
	},
	[27526012] = {
		27526012,
		0,
		Lang.get(66102),
		27526,
		12,
		239,
		{
			RTResTalkAction[39]
		}
	},
	[27527001] = {
		27527001,
		0,
		Lang.get(66103),
		27527,
		1,
		302,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27527,
		[19] = 27527
	},
	[27527002] = {
		27527002,
		0,
		Lang.get(66104),
		27527,
		2,
		300
	},
	[27527003] = {
		27527003,
		0,
		Lang.get(66105),
		27527,
		3,
		302,
		nil,
		1,
		nil,
		3
	},
	[27527004] = {
		27527004,
		0,
		Lang.get(66106),
		27527,
		4,
		300,
		{
			RTResTalkAction[41]
		}
	},
	[27527005] = {
		27527005,
		0,
		Lang.get(66107),
		27527,
		5,
		302,
		{
			RTResTalkAction[41]
		}
	},
	[27527006] = {
		27527006,
		0,
		Lang.get(66108),
		27527,
		6,
		300,
		{
			RTResTalkAction[41]
		}
	},
	[27527007] = {
		27527007,
		0,
		Lang.get(66109),
		27527,
		7,
		300,
		{
			RTResTalkAction[41]
		}
	},
	[27527008] = {
		27527008,
		0,
		Lang.get(66110),
		27527,
		8,
		302,
		{
			RTResTalkAction[41]
		}
	},
	[27527009] = {
		27527009,
		0,
		Lang.get(66111),
		27527,
		9,
		300,
		{
			RTResTalkAction[41]
		}
	},
	[27527010] = {
		27527010,
		0,
		Lang.get(66112),
		27527,
		10,
		302,
		{
			RTResTalkAction[42]
		}
	},
	[27527011] = {
		27527011,
		0,
		Lang.get(66113),
		27527,
		11,
		300,
		{
			RTResTalkAction[41]
		}
	},
	[27527012] = {
		27527012,
		0,
		Lang.get(66114),
		27527,
		12,
		300,
		{
			RTResTalkAction[41]
		}
	},
	[27527013] = {
		27527013,
		0,
		Lang.get(66115),
		27527,
		13,
		300,
		{
			RTResTalkAction[41]
		}
	},
	[27527014] = {
		27527014,
		0,
		Lang.get(66116),
		27527,
		14,
		314,
		{
			RTResTalkAction[43],
			RTResTalkAction[44]
		}
	},
	[27527015] = {
		27527015,
		0,
		"……？？",
		27527,
		15,
		300,
		{
			RTResTalkAction[41],
			RTResTalkAction[45]
		}
	},
	[27528001] = {
		27528001,
		0,
		Lang.get(66117),
		27528,
		1,
		302,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27528,
		[19] = 27528
	},
	[27528002] = {
		27528002,
		0,
		Lang.get(66118),
		27528,
		2,
		300
	},
	[27528003] = {
		27528003,
		0,
		Lang.get(66119),
		27528,
		3,
		302,
		nil,
		1,
		nil,
		3
	},
	[27528004] = {
		27528004,
		0,
		Lang.get(66120),
		27528,
		4,
		300,
		{
			RTResTalkAction[41]
		}
	},
	[27528005] = {
		27528005,
		0,
		Lang.get(66121),
		27528,
		5,
		300,
		{
			RTResTalkAction[41]
		}
	},
	[27528006] = {
		27528006,
		0,
		Lang.get(66122),
		27528,
		6,
		300,
		{
			RTResTalkAction[41]
		}
	},
	[27528007] = {
		27528007,
		0,
		Lang.get(66123),
		27528,
		7,
		314,
		{
			RTResTalkAction[43],
			RTResTalkAction[44]
		}
	},
	[27528008] = {
		27528008,
		0,
		Lang.get(66124),
		27528,
		8,
		300,
		{
			RTResTalkAction[41],
			RTResTalkAction[45]
		}
	},
	[27528009] = {
		27528009,
		0,
		Lang.get(66125),
		27528,
		9,
		302,
		{
			RTResTalkAction[41]
		}
	},
	[27528010] = {
		27528010,
		0,
		Lang.get(66126),
		27528,
		10,
		302,
		{
			RTResTalkAction[42]
		}
	},
	[27528011] = {
		27528011,
		0,
		Lang.get(66127),
		27528,
		11,
		302,
		{
			RTResTalkAction[41]
		}
	},
	[27528012] = {
		27528012,
		0,
		Lang.get(66128),
		27528,
		12,
		300,
		{
			RTResTalkAction[41]
		}
	},
	[27528013] = {
		27528013,
		0,
		Lang.get(66129),
		27528,
		13,
		302,
		{
			RTResTalkAction[41]
		}
	},
	[27528014] = {
		27528014,
		0,
		Lang.get(66130),
		27528,
		14,
		300,
		{
			RTResTalkAction[41]
		}
	},
	[27528015] = {
		27528015,
		0,
		Lang.get(66131),
		27528,
		15,
		302,
		{
			RTResTalkAction[41]
		}
	},
	[27529001] = {
		27529001,
		0,
		Lang.get(66132),
		27529,
		1,
		302,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27529,
		[19] = 27529
	},
	[27529002] = {
		27529002,
		0,
		Lang.get(66133),
		27529,
		2,
		300
	},
	[27529003] = {
		27529003,
		0,
		Lang.get(19557),
		27529,
		3,
		302,
		nil,
		1,
		nil,
		3
	},
	[27529004] = {
		27529004,
		0,
		Lang.get(66134),
		27529,
		4,
		300,
		{
			RTResTalkAction[41]
		}
	},
	[27529005] = {
		27529005,
		0,
		Lang.get(66135),
		27529,
		5,
		302,
		{
			RTResTalkAction[41]
		}
	},
	[27529006] = {
		27529006,
		0,
		Lang.get(66136),
		27529,
		6,
		300,
		{
			RTResTalkAction[41]
		}
	},
	[27529007] = {
		27529007,
		0,
		Lang.get(66137),
		27529,
		7,
		300,
		{
			RTResTalkAction[41]
		}
	},
	[27529008] = {
		27529008,
		0,
		"……",
		27529,
		8,
		302,
		{
			RTResTalkAction[41]
		}
	},
	[27529009] = {
		27529009,
		0,
		Lang.get(66138),
		27529,
		9,
		302,
		{
			RTResTalkAction[42]
		}
	},
	[27529010] = {
		27529010,
		0,
		Lang.get(66139),
		27529,
		10,
		300,
		{
			RTResTalkAction[41]
		}
	},
	[27529011] = {
		27529011,
		0,
		Lang.get(66140),
		27529,
		11,
		300,
		{
			RTResTalkAction[41]
		}
	},
	[27529012] = {
		27529012,
		0,
		Lang.get(66141),
		27529,
		12,
		302,
		{
			RTResTalkAction[41]
		}
	},
	[27529013] = {
		27529013,
		0,
		Lang.get(66142),
		27529,
		13,
		302,
		{
			RTResTalkAction[41]
		}
	},
	[27529014] = {
		27529014,
		0,
		Lang.get(66143),
		27529,
		14,
		302,
		{
			RTResTalkAction[42]
		}
	},
	[27530001] = {
		27530001,
		0,
		Lang.get(67551),
		27530,
		1,
		338,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27530,
		[19] = 27530
	},
	[27530002] = {
		27530002,
		0,
		Lang.get(67552),
		27530,
		2,
		300
	},
	[27530003] = {
		27530003,
		0,
		Lang.get(67553),
		27530,
		3,
		338,
		nil,
		1,
		nil,
		3
	},
	[27530004] = {
		27530004,
		0,
		Lang.get(67554),
		27530,
		4,
		338,
		{
			RTResTalkAction[46]
		}
	},
	[27530005] = {
		27530005,
		0,
		Lang.get(67555),
		27530,
		5,
		300,
		{
			RTResTalkAction[47]
		}
	},
	[27530006] = {
		27530006,
		0,
		Lang.get(67556),
		27530,
		6,
		338,
		{
			RTResTalkAction[48]
		}
	},
	[27530007] = {
		27530007,
		0,
		Lang.get(67557),
		27530,
		7,
		338,
		{
			RTResTalkAction[49]
		}
	},
	[27530008] = {
		27530008,
		0,
		Lang.get(67558),
		27530,
		8,
		300,
		{
			RTResTalkAction[47]
		}
	},
	[27530009] = {
		27530009,
		0,
		Lang.get(67559),
		27530,
		9,
		338,
		{
			RTResTalkAction[50]
		}
	},
	[27530010] = {
		27530010,
		0,
		Lang.get(67560),
		27530,
		10,
		338,
		{
			RTResTalkAction[50]
		}
	},
	[27530011] = {
		27530011,
		0,
		Lang.get(67561),
		27530,
		11,
		300,
		{
			RTResTalkAction[47]
		}
	},
	[27530012] = {
		27530012,
		0,
		Lang.get(67562),
		27530,
		12,
		338,
		{
			RTResTalkAction[49]
		}
	},
	[27530013] = {
		27530013,
		0,
		Lang.get(67563),
		27530,
		13,
		338,
		{
			RTResTalkAction[50]
		}
	},
	[27530014] = {
		27530014,
		0,
		Lang.get(67564),
		27530,
		14,
		300,
		{
			RTResTalkAction[47]
		}
	},
	[27530015] = {
		27530015,
		0,
		Lang.get(67565),
		27530,
		15,
		338,
		{
			RTResTalkAction[51]
		}
	},
	[27531001] = {
		27531001,
		0,
		Lang.get(67566),
		27531,
		1,
		338,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27531,
		[19] = 27531
	},
	[27531002] = {
		27531002,
		0,
		Lang.get(67567),
		27531,
		2,
		300
	},
	[27531003] = {
		27531003,
		0,
		Lang.get(67568),
		27531,
		3,
		338,
		nil,
		1,
		nil,
		3
	},
	[27531004] = {
		27531004,
		0,
		Lang.get(67569),
		27531,
		4,
		338,
		{
			RTResTalkAction[49]
		}
	},
	[27531005] = {
		27531005,
		0,
		Lang.get(67570),
		27531,
		5,
		300,
		{
			RTResTalkAction[47]
		}
	},
	[27531006] = {
		27531006,
		0,
		Lang.get(67571),
		27531,
		6,
		338,
		{
			RTResTalkAction[52]
		}
	},
	[27531007] = {
		27531007,
		0,
		Lang.get(67572),
		27531,
		7,
		338,
		{
			RTResTalkAction[50]
		}
	},
	[27531008] = {
		27531008,
		0,
		Lang.get(67573),
		27531,
		8,
		338,
		{
			RTResTalkAction[50]
		}
	},
	[27531009] = {
		27531009,
		0,
		Lang.get(67574),
		27531,
		9,
		300,
		{
			RTResTalkAction[47]
		}
	},
	[27531010] = {
		27531010,
		0,
		Lang.get(67575),
		27531,
		10,
		300,
		{
			RTResTalkAction[47]
		}
	},
	[27531011] = {
		27531011,
		0,
		Lang.get(67576),
		27531,
		11,
		338,
		{
			RTResTalkAction[50]
		}
	},
	[27531012] = {
		27531012,
		0,
		Lang.get(67577),
		27531,
		12,
		338,
		{
			RTResTalkAction[50]
		}
	},
	[27531013] = {
		27531013,
		0,
		Lang.get(67578),
		27531,
		13,
		338,
		{
			RTResTalkAction[50]
		}
	},
	[27531014] = {
		27531014,
		0,
		Lang.get(67579),
		27531,
		14,
		338,
		{
			RTResTalkAction[49]
		}
	},
	[27531015] = {
		27531015,
		0,
		Lang.get(67580),
		27531,
		15,
		338,
		{
			RTResTalkAction[53]
		}
	},
	[27532001] = {
		27532001,
		0,
		Lang.get(67581),
		27532,
		1,
		338,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27532,
		[19] = 27532
	},
	[27532002] = {
		27532002,
		0,
		Lang.get(67582),
		27532,
		2,
		338,
		nil,
		1
	},
	[27532003] = {
		27532003,
		0,
		Lang.get(67583),
		27532,
		3,
		338,
		{
			RTResTalkAction[50]
		},
		nil,
		nil,
		3
	},
	[27532004] = {
		27532004,
		0,
		Lang.get(67584),
		27532,
		4,
		338,
		{
			RTResTalkAction[50]
		}
	},
	[27532005] = {
		27532005,
		0,
		Lang.get(67585),
		27532,
		5,
		338,
		{
			RTResTalkAction[50]
		}
	},
	[27532006] = {
		27532006,
		0,
		Lang.get(67586),
		27532,
		6,
		338,
		{
			RTResTalkAction[49]
		}
	},
	[27532007] = {
		27532007,
		0,
		Lang.get(67587),
		27532,
		7,
		300,
		{
			RTResTalkAction[47]
		}
	},
	[27532008] = {
		27532008,
		0,
		Lang.get(67588),
		27532,
		8,
		338,
		{
			RTResTalkAction[51]
		}
	},
	[27532009] = {
		27532009,
		0,
		Lang.get(67589),
		27532,
		9,
		338,
		{
			RTResTalkAction[50]
		}
	},
	[27532010] = {
		27532010,
		0,
		Lang.get(67590),
		27532,
		10,
		338,
		{
			RTResTalkAction[50]
		}
	},
	[27532011] = {
		27532011,
		0,
		Lang.get(67591),
		27532,
		11,
		300,
		{
			RTResTalkAction[47]
		}
	},
	[27532012] = {
		27532012,
		0,
		Lang.get(67592),
		27532,
		12,
		300,
		{
			RTResTalkAction[47]
		}
	},
	[27532013] = {
		27532013,
		0,
		Lang.get(67593),
		27532,
		13,
		338,
		{
			RTResTalkAction[49]
		}
	},
	[27532014] = {
		27532014,
		0,
		Lang.get(67594),
		27532,
		14,
		338,
		{
			RTResTalkAction[50]
		}
	},
	[27532015] = {
		27532015,
		0,
		Lang.get(67595),
		27532,
		15,
		338,
		{
			RTResTalkAction[50]
		}
	},
	[27533001] = {
		27533001,
		0,
		Lang.get(67596),
		27533,
		1,
		637,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27533,
		[19] = 27533
	},
	[27533002] = {
		27533002,
		0,
		Lang.get(67597),
		27533,
		2,
		637,
		nil,
		1
	},
	[27533003] = {
		27533003,
		0,
		Lang.get(67598),
		27533,
		3,
		637,
		{
			RTResTalkAction[54]
		},
		nil,
		nil,
		3
	},
	[27533004] = {
		27533004,
		0,
		Lang.get(67599),
		27533,
		4,
		637,
		{
			RTResTalkAction[54]
		}
	},
	[27533005] = {
		27533005,
		0,
		Lang.get(67600),
		27533,
		5,
		300,
		{
			RTResTalkAction[54]
		}
	},
	[27533006] = {
		27533006,
		0,
		Lang.get(67601),
		27533,
		6,
		300,
		{
			RTResTalkAction[54]
		}
	},
	[27533007] = {
		27533007,
		0,
		Lang.get(67602),
		27533,
		7,
		637,
		{
			RTResTalkAction[54]
		}
	},
	[27533008] = {
		27533008,
		4,
		nil,
		27533,
		8,
		637,
		{
			RTResTalkAction[54]
		},
		[29] = {
			{
				id = 27533009,
				branch_content = Lang.get(67603)
			},
			{
				id = 27533009,
				branch_content = Lang.get(67604)
			}
		}
	},
	[27533009] = {
		27533009,
		0,
		Lang.get(67605),
		27533,
		9,
		637,
		{
			RTResTalkAction[54]
		}
	},
	[27533010] = {
		27533010,
		0,
		Lang.get(18514),
		27533,
		10,
		637,
		{
			RTResTalkAction[54]
		}
	},
	[27533011] = {
		27533011,
		0,
		Lang.get(67606),
		27533,
		11,
		300,
		{
			RTResTalkAction[54]
		}
	},
	[27533012] = {
		27533012,
		0,
		Lang.get(67607),
		27533,
		12,
		637,
		{
			RTResTalkAction[55]
		}
	},
	[27533013] = {
		27533013,
		4,
		nil,
		27533,
		13,
		637,
		{
			RTResTalkAction[54]
		},
		[29] = {
			{
				id = 27533014,
				branch_content = Lang.get(67608)
			}
		}
	},
	[27533014] = {
		27533014,
		0,
		Lang.get(67609),
		27533,
		14,
		637,
		{
			RTResTalkAction[54]
		}
	},
	[27534001] = {
		27534001,
		0,
		Lang.get(67610),
		27534,
		1,
		637,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27534,
		[19] = 27534
	},
	[27534002] = {
		27534002,
		4,
		nil,
		27534,
		2,
		637,
		nil,
		1,
		[29] = {
			{
				id = 27534003,
				branch_content = Lang.get(67611)
			}
		}
	},
	[27534003] = {
		27534003,
		0,
		Lang.get(67612),
		27534,
		3,
		300,
		{
			RTResTalkAction[54]
		},
		nil,
		nil,
		3
	},
	[27534004] = {
		27534004,
		0,
		Lang.get(67613),
		27534,
		4,
		637,
		{
			RTResTalkAction[54]
		}
	},
	[27534005] = {
		27534005,
		0,
		Lang.get(67614),
		27534,
		5,
		637,
		{
			RTResTalkAction[54]
		}
	},
	[27534006] = {
		27534006,
		0,
		Lang.get(67615),
		27534,
		6,
		637,
		{
			RTResTalkAction[54]
		}
	},
	[27534007] = {
		27534007,
		4,
		nil,
		27534,
		7,
		637,
		{
			RTResTalkAction[54]
		},
		[29] = {
			{
				id = 27534008,
				branch_content = Lang.get(67616)
			}
		}
	},
	[27534008] = {
		27534008,
		0,
		Lang.get(67617),
		27534,
		8,
		300,
		{
			RTResTalkAction[54]
		}
	},
	[27534009] = {
		27534009,
		0,
		Lang.get(67618),
		27534,
		9,
		637,
		{
			RTResTalkAction[54]
		}
	},
	[27534010] = {
		27534010,
		0,
		Lang.get(67619),
		27534,
		10,
		637,
		{
			RTResTalkAction[54]
		}
	},
	[27534011] = {
		27534011,
		0,
		Lang.get(67620),
		27534,
		11,
		300,
		{
			RTResTalkAction[54]
		}
	},
	[27534012] = {
		27534012,
		0,
		Lang.get(67621),
		27534,
		12,
		300,
		{
			RTResTalkAction[54]
		}
	},
	[27534013] = {
		27534013,
		0,
		Lang.get(67622),
		27534,
		13,
		637,
		{
			RTResTalkAction[56]
		}
	},
	[27534014] = {
		27534014,
		0,
		Lang.get(67623),
		27534,
		14,
		637,
		{
			RTResTalkAction[54]
		}
	},
	[27534015] = {
		27534015,
		0,
		Lang.get(75410),
		27534,
		15,
		637,
		{
			RTResTalkAction[54]
		}
	},
	[27535001] = {
		27535001,
		0,
		Lang.get(67625),
		27535,
		1,
		637,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27535,
		[19] = 27535
	},
	[27535002] = {
		27535002,
		0,
		Lang.get(67626),
		27535,
		2,
		637,
		nil,
		1
	},
	[27535003] = {
		27535003,
		0,
		Lang.get(67627),
		27535,
		3,
		300,
		{
			RTResTalkAction[54]
		},
		nil,
		nil,
		3
	},
	[27535004] = {
		27535004,
		0,
		Lang.get(67628),
		27535,
		4,
		300,
		{
			RTResTalkAction[54]
		}
	},
	[27535005] = {
		27535005,
		0,
		Lang.get(67629),
		27535,
		5,
		300,
		{
			RTResTalkAction[54]
		}
	},
	[27535006] = {
		27535006,
		0,
		Lang.get(67630),
		27535,
		6,
		637,
		{
			RTResTalkAction[57]
		}
	},
	[27535007] = {
		27535007,
		0,
		Lang.get(27515),
		27535,
		7,
		300,
		{
			RTResTalkAction[54]
		}
	},
	[27535008] = {
		27535008,
		0,
		"……",
		27535,
		8,
		637,
		{
			RTResTalkAction[54]
		}
	},
	[27535009] = {
		27535009,
		0,
		Lang.get(67631),
		27535,
		9,
		300,
		{
			RTResTalkAction[54]
		}
	},
	[27535010] = {
		27535010,
		0,
		Lang.get(67632),
		27535,
		10,
		637,
		{
			RTResTalkAction[54]
		}
	},
	[27535011] = {
		27535011,
		0,
		Lang.get(67633),
		27535,
		11,
		300,
		{
			RTResTalkAction[54]
		}
	},
	[27535012] = {
		27535012,
		0,
		Lang.get(67634),
		27535,
		12,
		300,
		{
			RTResTalkAction[54]
		}
	},
	[27535013] = {
		27535013,
		0,
		Lang.get(67635),
		27535,
		13,
		637,
		{
			RTResTalkAction[54]
		}
	},
	[27535014] = {
		27535014,
		0,
		Lang.get(67636),
		27535,
		14,
		300,
		{
			RTResTalkAction[54]
		}
	},
	[27535015] = {
		27535015,
		0,
		Lang.get(67637),
		27535,
		15,
		637,
		{
			RTResTalkAction[54]
		}
	},
	[27536001] = {
		27536001,
		0,
		Lang.get(67638),
		27536,
		1,
		117,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27536,
		[19] = 27536
	},
	[27536002] = {
		27536002,
		0,
		Lang.get(21987),
		27536,
		2,
		300
	},
	[27536003] = {
		27536003,
		0,
		Lang.get(67639),
		27536,
		3,
		117,
		nil,
		1,
		nil,
		3
	},
	[27536004] = {
		27536004,
		3,
		Lang.get(67640),
		27536,
		4,
		605,
		{
			RTResTalkAction[58]
		},
		[22] = 1
	},
	[27536005] = {
		27536005,
		0,
		Lang.get(67641),
		27536,
		5,
		300,
		{
			RTResTalkAction[58]
		}
	},
	[27536006] = {
		27536006,
		0,
		Lang.get(67642),
		27536,
		6,
		117,
		{
			RTResTalkAction[58]
		}
	},
	[27536007] = {
		27536007,
		0,
		Lang.get(67643),
		27536,
		7,
		117,
		{
			RTResTalkAction[59]
		}
	},
	[27536008] = {
		27536008,
		0,
		Lang.get(67644),
		27536,
		8,
		300,
		{
			RTResTalkAction[58]
		}
	},
	[27536009] = {
		27536009,
		0,
		Lang.get(67645),
		27536,
		9,
		300,
		{
			RTResTalkAction[58]
		}
	},
	[27536010] = {
		27536010,
		0,
		Lang.get(67646),
		27536,
		10,
		117,
		{
			RTResTalkAction[58]
		}
	},
	[27536011] = {
		27536011,
		0,
		Lang.get(67647),
		27536,
		11,
		300,
		{
			RTResTalkAction[58]
		}
	},
	[27536012] = {
		27536012,
		0,
		Lang.get(67648),
		27536,
		12,
		117,
		{
			RTResTalkAction[58]
		}
	},
	[27536013] = {
		27536013,
		0,
		Lang.get(67649),
		27536,
		13,
		117,
		{
			RTResTalkAction[58]
		}
	},
	[27536014] = {
		27536014,
		0,
		Lang.get(67650),
		27536,
		14,
		300,
		{
			RTResTalkAction[58]
		}
	},
	[27537001] = {
		27537001,
		0,
		Lang.get(67651),
		27537,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		27537,
		[19] = 27537
	},
	[27537002] = {
		27537002,
		0,
		Lang.get(67652),
		27537,
		2,
		300
	},
	[27537003] = {
		27537003,
		0,
		Lang.get(67653),
		27537,
		3,
		117,
		{
			RTResTalkAction[58]
		},
		nil,
		nil,
		3
	},
	[27537004] = {
		27537004,
		0,
		Lang.get(67654),
		27537,
		4,
		117,
		{
			RTResTalkAction[58]
		}
	},
	[27537005] = {
		27537005,
		0,
		Lang.get(67655),
		27537,
		5,
		300,
		{
			RTResTalkAction[58]
		}
	},
	[27537006] = {
		27537006,
		0,
		Lang.get(67656),
		27537,
		6,
		117,
		{
			RTResTalkAction[60]
		}
	},
	[27537007] = {
		27537007,
		0,
		Lang.get(66037),
		27537,
		7,
		300,
		{
			RTResTalkAction[58]
		}
	},
	[27537008] = {
		27537008,
		0,
		Lang.get(67657),
		27537,
		8,
		117,
		{
			RTResTalkAction[58]
		}
	},
	[27537009] = {
		27537009,
		0,
		Lang.get(67658),
		27537,
		9,
		300,
		{
			RTResTalkAction[58]
		}
	},
	[27537010] = {
		27537010,
		0,
		Lang.get(67659),
		27537,
		10,
		117,
		{
			RTResTalkAction[58]
		}
	},
	[27537011] = {
		27537011,
		0,
		Lang.get(67660),
		27537,
		11,
		117,
		{
			RTResTalkAction[58]
		}
	},
	[27537012] = {
		27537012,
		0,
		Lang.get(67661),
		27537,
		12,
		300,
		{
			RTResTalkAction[58]
		}
	},
	[27537013] = {
		27537013,
		0,
		Lang.get(67662),
		27537,
		13,
		117,
		{
			RTResTalkAction[58]
		}
	},
	[27537014] = {
		27537014,
		0,
		Lang.get(67663),
		27537,
		14,
		300,
		{
			RTResTalkAction[58]
		}
	},
	[27538001] = {
		27538001,
		0,
		Lang.get(67664),
		27538,
		1,
		117,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27538,
		[19] = 27538
	},
	[27538002] = {
		27538002,
		0,
		Lang.get(67665),
		27538,
		2,
		300
	},
	[27538003] = {
		27538003,
		0,
		Lang.get(67666),
		27538,
		3,
		117,
		nil,
		1,
		nil,
		3
	},
	[27538004] = {
		27538004,
		0,
		Lang.get(67667),
		27538,
		4,
		300,
		{
			RTResTalkAction[58]
		}
	},
	[27538005] = {
		27538005,
		0,
		Lang.get(67668),
		27538,
		5,
		117,
		{
			RTResTalkAction[58]
		}
	},
	[27538006] = {
		27538006,
		0,
		Lang.get(67669),
		27538,
		6,
		117,
		{
			RTResTalkAction[61]
		}
	},
	[27538007] = {
		27538007,
		0,
		Lang.get(67670),
		27538,
		7,
		117,
		{
			RTResTalkAction[58]
		}
	},
	[27538008] = {
		27538008,
		0,
		Lang.get(67671),
		27538,
		8,
		300,
		{
			RTResTalkAction[58]
		}
	},
	[27538009] = {
		27538009,
		0,
		Lang.get(67672),
		27538,
		9,
		300,
		{
			RTResTalkAction[58]
		}
	},
	[27538010] = {
		27538010,
		0,
		Lang.get(19967),
		27538,
		10,
		117,
		{
			RTResTalkAction[58]
		}
	},
	[27538011] = {
		27538011,
		0,
		Lang.get(67167),
		27538,
		11,
		117,
		{
			RTResTalkAction[58]
		}
	},
	[27538012] = {
		27538012,
		0,
		Lang.get(67673),
		27538,
		12,
		300,
		{
			RTResTalkAction[58]
		}
	},
	[27539001] = {
		27539001,
		0,
		Lang.get(69549),
		27539,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		27539,
		[19] = 27539
	},
	[27539002] = {
		27539002,
		0,
		Lang.get(69550),
		27539,
		2,
		122,
		nil,
		1
	},
	[27539003] = {
		27539003,
		0,
		Lang.get(69551),
		27539,
		3,
		300,
		{
			RTResTalkAction[62]
		},
		nil,
		nil,
		3
	},
	[27539004] = {
		27539004,
		0,
		Lang.get(69552),
		27539,
		4,
		122,
		{
			RTResTalkAction[63]
		}
	},
	[27539005] = {
		27539005,
		4,
		nil,
		27539,
		5,
		122,
		{
			RTResTalkAction[62]
		},
		[29] = {
			{
				id = 27539006,
				branch_content = Lang.get(69553)
			},
			{
				id = 27539006,
				branch_content = Lang.get(69554)
			}
		}
	},
	[27539006] = {
		27539006,
		0,
		Lang.get(69555),
		27539,
		6,
		122,
		{
			RTResTalkAction[62]
		}
	},
	[27539007] = {
		27539007,
		0,
		Lang.get(69556),
		27539,
		7,
		122,
		{
			RTResTalkAction[64]
		}
	},
	[27539008] = {
		27539008,
		0,
		Lang.get(69557),
		27539,
		8,
		300,
		{
			RTResTalkAction[62]
		}
	},
	[27539009] = {
		27539009,
		0,
		Lang.get(69558),
		27539,
		9,
		300,
		{
			RTResTalkAction[62]
		}
	},
	[27539010] = {
		27539010,
		0,
		Lang.get(69559),
		27539,
		10,
		122,
		{
			RTResTalkAction[65]
		}
	},
	[27539011] = {
		27539011,
		0,
		Lang.get(69560),
		27539,
		11,
		122,
		{
			RTResTalkAction[62]
		}
	},
	[27539012] = {
		27539012,
		0,
		Lang.get(69561),
		27539,
		12,
		122,
		{
			RTResTalkAction[66]
		}
	},
	[27539013] = {
		27539013,
		0,
		Lang.get(69562),
		27539,
		13,
		300,
		{
			RTResTalkAction[62]
		}
	},
	[27539014] = {
		27539014,
		0,
		Lang.get(69563),
		27539,
		14,
		122,
		{
			RTResTalkAction[62]
		}
	},
	[27540001] = {
		27540001,
		0,
		"……",
		27540,
		1,
		122,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27540,
		nil,
		nil,
		nil,
		nil,
		nil,
		27540
	},
	[27540002] = {
		27540002,
		0,
		Lang.get(69564),
		27540,
		2,
		300
	},
	[27540003] = {
		27540003,
		0,
		Lang.get(69565),
		27540,
		3,
		122,
		nil,
		1,
		nil,
		3
	},
	[27540004] = {
		27540004,
		0,
		Lang.get(69566),
		27540,
		4,
		122,
		{
			RTResTalkAction[62]
		}
	},
	[27540005] = {
		27540005,
		0,
		Lang.get(69567),
		27540,
		5,
		122,
		{
			RTResTalkAction[62]
		}
	},
	[27540006] = {
		27540006,
		0,
		Lang.get(69568),
		27540,
		6,
		300,
		{
			RTResTalkAction[62]
		}
	},
	[27540007] = {
		27540007,
		0,
		Lang.get(69569),
		27540,
		7,
		300,
		{
			RTResTalkAction[62]
		}
	},
	[27540008] = {
		27540008,
		0,
		Lang.get(69570),
		27540,
		8,
		122,
		{
			RTResTalkAction[62]
		}
	},
	[27540009] = {
		27540009,
		0,
		Lang.get(66037),
		27540,
		9,
		300,
		{
			RTResTalkAction[62]
		}
	},
	[27540010] = {
		27540010,
		0,
		Lang.get(69571),
		27540,
		10,
		122,
		{
			RTResTalkAction[62]
		}
	},
	[27540011] = {
		27540011,
		0,
		Lang.get(69572),
		27540,
		11,
		122,
		{
			RTResTalkAction[65]
		}
	},
	[27540012] = {
		27540012,
		0,
		Lang.get(69573),
		27540,
		12,
		300,
		{
			RTResTalkAction[67]
		}
	},
	[27540013] = {
		27540013,
		0,
		Lang.get(69574),
		27540,
		13,
		300,
		{
			RTResTalkAction[62]
		}
	},
	[27540014] = {
		27540014,
		0,
		Lang.get(69575),
		27540,
		14,
		122,
		{
			RTResTalkAction[62]
		}
	},
	[27541001] = {
		27541001,
		5,
		Lang.get(69576),
		27541,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		27541,
		[19] = 27541
	},
	[27541002] = {
		27541002,
		0,
		Lang.get(69577),
		27541,
		2,
		122,
		nil,
		1
	},
	[27541003] = {
		27541003,
		0,
		Lang.get(69578),
		27541,
		3,
		300,
		{
			RTResTalkAction[62]
		},
		nil,
		nil,
		3
	},
	[27541004] = {
		27541004,
		0,
		Lang.get(69579),
		27541,
		4,
		122,
		{
			RTResTalkAction[68]
		}
	},
	[27541005] = {
		27541005,
		0,
		Lang.get(69580),
		27541,
		5,
		300,
		{
			RTResTalkAction[62]
		}
	},
	[27541006] = {
		27541006,
		0,
		Lang.get(69581),
		27541,
		6,
		122,
		{
			RTResTalkAction[66]
		}
	},
	[27541007] = {
		27541007,
		0,
		Lang.get(69582),
		27541,
		7,
		122,
		{
			RTResTalkAction[62]
		}
	},
	[27541008] = {
		27541008,
		0,
		Lang.get(69583),
		27541,
		8,
		300,
		{
			RTResTalkAction[62]
		}
	},
	[27541009] = {
		27541009,
		0,
		Lang.get(69584),
		27541,
		9,
		300,
		{
			RTResTalkAction[62]
		}
	},
	[27541010] = {
		27541010,
		0,
		Lang.get(69585),
		27541,
		10,
		122,
		{
			RTResTalkAction[65]
		}
	},
	[27541011] = {
		27541011,
		4,
		nil,
		27541,
		11,
		122,
		{
			RTResTalkAction[62]
		},
		[29] = {
			{
				id = 27541012,
				branch_content = Lang.get(69586)
			},
			{
				id = 27541013,
				branch_content = Lang.get(69587)
			}
		}
	},
	[27541012] = {
		27541012,
		0,
		Lang.get(69588),
		27541,
		12,
		122,
		{
			RTResTalkAction[64]
		}
	},
	[27541013] = {
		27541013,
		0,
		Lang.get(69589),
		27541,
		13,
		122,
		{
			RTResTalkAction[64]
		}
	},
	[27541014] = {
		27541014,
		0,
		Lang.get(69590),
		27541,
		14,
		300,
		{
			RTResTalkAction[62]
		}
	},
	[27542001] = {
		27542001,
		0,
		Lang.get(67717),
		27542,
		1,
		143,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27542,
		[19] = 27542
	},
	[27542002] = {
		27542002,
		0,
		Lang.get(67718),
		27542,
		2,
		143,
		nil,
		1
	},
	[27542003] = {
		27542003,
		4,
		nil,
		27542,
		3,
		143,
		nil,
		1,
		nil,
		3,
		[29] = {
			{
				id = 27542004,
				branch_content = Lang.get(67719)
			}
		}
	},
	[27542004] = {
		27542004,
		0,
		Lang.get(67720),
		27542,
		4,
		143,
		{
			RTResTalkAction[69]
		}
	},
	[27542005] = {
		27542005,
		0,
		Lang.get(67721),
		27542,
		5,
		143,
		{
			RTResTalkAction[70]
		}
	},
	[27542006] = {
		27542006,
		0,
		Lang.get(67722),
		27542,
		6,
		300,
		{
			RTResTalkAction[71]
		}
	},
	[27542007] = {
		27542007,
		0,
		Lang.get(67723),
		27542,
		7,
		143,
		{
			RTResTalkAction[72]
		}
	},
	[27542008] = {
		27542008,
		0,
		Lang.get(67724),
		27542,
		8,
		300,
		{
			RTResTalkAction[71]
		}
	},
	[27542009] = {
		27542009,
		0,
		Lang.get(67725),
		27542,
		9,
		143,
		{
			RTResTalkAction[73]
		}
	},
	[27542010] = {
		27542010,
		0,
		Lang.get(67726),
		27542,
		10,
		143,
		{
			RTResTalkAction[70]
		}
	},
	[27542011] = {
		27542011,
		0,
		Lang.get(67727),
		27542,
		11,
		300,
		{
			RTResTalkAction[71]
		}
	},
	[27542012] = {
		27542012,
		0,
		Lang.get(67728),
		27542,
		12,
		300,
		{
			RTResTalkAction[71]
		}
	},
	[27542013] = {
		27542013,
		0,
		Lang.get(67729),
		27542,
		13,
		300,
		{
			RTResTalkAction[71]
		}
	},
	[27542014] = {
		27542014,
		0,
		Lang.get(67730),
		27542,
		14,
		143,
		{
			RTResTalkAction[74]
		}
	},
	[27542015] = {
		27542015,
		0,
		Lang.get(67731),
		27542,
		15,
		300,
		{
			RTResTalkAction[71]
		}
	},
	[27543001] = {
		27543001,
		0,
		Lang.get(67732),
		27543,
		1,
		143,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27543,
		[19] = 27543
	},
	[27543002] = {
		27543002,
		0,
		Lang.get(67733),
		27543,
		2,
		300
	},
	[27543003] = {
		27543003,
		0,
		Lang.get(67734),
		27543,
		3,
		143,
		nil,
		1,
		nil,
		3
	},
	[27543004] = {
		27543004,
		0,
		Lang.get(67735),
		27543,
		4,
		143,
		{
			RTResTalkAction[70]
		}
	},
	[27543005] = {
		27543005,
		0,
		Lang.get(67736),
		27543,
		5,
		300,
		{
			RTResTalkAction[71]
		}
	},
	[27543006] = {
		27543006,
		0,
		Lang.get(67737),
		27543,
		6,
		143,
		{
			RTResTalkAction[74]
		}
	},
	[27543007] = {
		27543007,
		4,
		nil,
		27543,
		7,
		300,
		{
			RTResTalkAction[71]
		},
		[29] = {
			{
				id = 27543008,
				branch_content = Lang.get(67738)
			},
			{
				id = 27543008,
				branch_content = Lang.get(67739)
			}
		}
	},
	[27543008] = {
		27543008,
		0,
		Lang.get(67740),
		27543,
		8,
		143,
		{
			RTResTalkAction[70]
		}
	},
	[27543009] = {
		27543009,
		0,
		Lang.get(67741),
		27543,
		9,
		143,
		{
			RTResTalkAction[73]
		}
	},
	[27543010] = {
		27543010,
		0,
		Lang.get(67742),
		27543,
		10,
		300,
		{
			RTResTalkAction[71]
		}
	},
	[27543011] = {
		27543011,
		0,
		Lang.get(67743),
		27543,
		11,
		143,
		{
			RTResTalkAction[74]
		}
	},
	[27543012] = {
		27543012,
		0,
		Lang.get(67744),
		27543,
		12,
		300,
		{
			RTResTalkAction[71]
		}
	},
	[27543013] = {
		27543013,
		0,
		Lang.get(67745),
		27543,
		13,
		143,
		{
			RTResTalkAction[72]
		}
	},
	[27543014] = {
		27543014,
		0,
		Lang.get(67746),
		27543,
		14,
		300,
		{
			RTResTalkAction[71]
		}
	},
	[27544001] = {
		27544001,
		0,
		Lang.get(67747),
		27544,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		27544,
		[19] = 27544
	},
	[27544002] = {
		27544002,
		0,
		Lang.get(67748),
		27544,
		2,
		300
	},
	[27544003] = {
		27544003,
		0,
		Lang.get(67749),
		27544,
		3,
		143,
		nil,
		1,
		nil,
		3
	},
	[27544004] = {
		27544004,
		0,
		Lang.get(67750),
		27544,
		4,
		300,
		{
			RTResTalkAction[71]
		}
	},
	[27544005] = {
		27544005,
		0,
		Lang.get(67751),
		27544,
		5,
		143,
		{
			RTResTalkAction[75]
		}
	},
	[27544006] = {
		27544006,
		0,
		Lang.get(67752),
		27544,
		6,
		300,
		{
			RTResTalkAction[71]
		}
	},
	[27544007] = {
		27544007,
		0,
		Lang.get(67753),
		27544,
		7,
		300,
		{
			RTResTalkAction[71]
		}
	},
	[27544008] = {
		27544008,
		0,
		Lang.get(67754),
		27544,
		8,
		143,
		{
			RTResTalkAction[76]
		}
	},
	[27544009] = {
		27544009,
		0,
		Lang.get(67755),
		27544,
		9,
		300,
		{
			RTResTalkAction[71]
		}
	},
	[27544010] = {
		27544010,
		0,
		Lang.get(67756),
		27544,
		10,
		143,
		{
			RTResTalkAction[72]
		}
	},
	[27544011] = {
		27544011,
		0,
		Lang.get(67757),
		27544,
		11,
		143,
		{
			RTResTalkAction[72]
		}
	},
	[27544012] = {
		27544012,
		0,
		Lang.get(67758),
		27544,
		12,
		143,
		{
			RTResTalkAction[72]
		}
	},
	[27544013] = {
		27544013,
		0,
		Lang.get(67759),
		27544,
		13,
		143,
		{
			RTResTalkAction[72]
		}
	},
	[27544014] = {
		27544014,
		0,
		Lang.get(67760),
		27544,
		14,
		300,
		{
			RTResTalkAction[71]
		}
	},
	[27544015] = {
		27544015,
		0,
		Lang.get(67761),
		27544,
		15,
		143,
		{
			RTResTalkAction[77]
		}
	},
	[27545001] = {
		27545001,
		0,
		Lang.get(75411),
		27545,
		1,
		1009,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27545,
		[19] = 27545
	},
	[27545002] = {
		27545002,
		0,
		Lang.get(75412),
		27545,
		2,
		300
	},
	[27545003] = {
		27545003,
		0,
		Lang.get(75413),
		27545,
		3,
		1009,
		nil,
		1,
		nil,
		3
	},
	[27545004] = {
		27545004,
		0,
		Lang.get(75414),
		27545,
		4,
		300,
		{
			RTResTalkAction[78]
		}
	},
	[27545005] = {
		27545005,
		0,
		Lang.get(75415),
		27545,
		5,
		1009,
		{
			RTResTalkAction[78]
		}
	},
	[27545006] = {
		27545006,
		0,
		Lang.get(75416),
		27545,
		6,
		1009,
		{
			RTResTalkAction[78]
		}
	},
	[27545007] = {
		27545007,
		4,
		nil,
		27545,
		7,
		1009,
		{
			RTResTalkAction[78]
		},
		[29] = {
			{
				id = 27545008,
				branch_content = Lang.get(75417)
			},
			{
				id = 27545009,
				branch_content = Lang.get(75418)
			}
		}
	},
	[27545008] = {
		27545008,
		0,
		Lang.get(75419),
		27545,
		8,
		1009,
		{
			RTResTalkAction[78]
		}
	},
	[27545009] = {
		27545009,
		0,
		Lang.get(75420),
		27545,
		9,
		1009,
		{
			RTResTalkAction[78]
		}
	},
	[27545010] = {
		27545010,
		0,
		"……",
		27545,
		10,
		300,
		{
			RTResTalkAction[78]
		}
	},
	[27545011] = {
		27545011,
		0,
		Lang.get(75421),
		27545,
		11,
		300,
		{
			RTResTalkAction[78]
		}
	},
	[27545012] = {
		27545012,
		0,
		Lang.get(75422),
		27545,
		12,
		1009,
		{
			RTResTalkAction[78]
		}
	},
	[27545013] = {
		27545013,
		0,
		Lang.get(19725),
		27545,
		13,
		300,
		{
			RTResTalkAction[78]
		}
	},
	[27545014] = {
		27545014,
		0,
		Lang.get(75423),
		27545,
		14,
		1009,
		{
			RTResTalkAction[78]
		}
	},
	[27546001] = {
		27546001,
		0,
		Lang.get(75424),
		27546,
		1,
		1009,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27546,
		[19] = 27546
	},
	[27546002] = {
		27546002,
		0,
		Lang.get(75425),
		27546,
		2,
		1009,
		nil,
		1
	},
	[27546003] = {
		27546003,
		0,
		Lang.get(75426),
		27546,
		3,
		300,
		{
			RTResTalkAction[78]
		},
		nil,
		nil,
		3
	},
	[27546004] = {
		27546004,
		0,
		Lang.get(75427),
		27546,
		4,
		1009,
		{
			RTResTalkAction[78]
		}
	},
	[27546005] = {
		27546005,
		4,
		nil,
		27546,
		5,
		1009,
		{
			RTResTalkAction[78]
		},
		[29] = {
			{
				id = 27546006,
				branch_content = Lang.get(75428)
			}
		}
	},
	[27546006] = {
		27546006,
		0,
		Lang.get(75429),
		27546,
		6,
		1009,
		{
			RTResTalkAction[78]
		}
	},
	[27546007] = {
		27546007,
		0,
		Lang.get(75430),
		27546,
		7,
		300,
		{
			RTResTalkAction[78]
		}
	},
	[27546008] = {
		27546008,
		0,
		"......",
		27546,
		8,
		1009,
		{
			RTResTalkAction[78]
		}
	},
	[27546009] = {
		27546009,
		0,
		Lang.get(75431),
		27546,
		9,
		300,
		{
			RTResTalkAction[78]
		}
	},
	[27546010] = {
		27546010,
		0,
		Lang.get(75432),
		27546,
		10,
		1009,
		{
			RTResTalkAction[78]
		}
	},
	[27546011] = {
		27546011,
		0,
		Lang.get(75433),
		27546,
		11,
		1009,
		{
			RTResTalkAction[78]
		}
	},
	[27547001] = {
		27547001,
		0,
		Lang.get(75434),
		27547,
		1,
		1009,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27547,
		[19] = 27547
	},
	[27547002] = {
		27547002,
		0,
		Lang.get(75435),
		27547,
		2,
		300
	},
	[27547003] = {
		27547003,
		0,
		Lang.get(75436),
		27547,
		3,
		1009,
		nil,
		1,
		nil,
		3
	},
	[27547004] = {
		27547004,
		4,
		nil,
		27547,
		4,
		1009,
		{
			RTResTalkAction[78]
		},
		[29] = {
			{
				id = 27547005,
				branch_content = Lang.get(75437)
			}
		}
	},
	[27547005] = {
		27547005,
		0,
		Lang.get(75438),
		27547,
		5,
		1009,
		{
			RTResTalkAction[78]
		}
	},
	[27547006] = {
		27547006,
		0,
		Lang.get(75439),
		27547,
		6,
		1009,
		{
			RTResTalkAction[78]
		}
	},
	[27547007] = {
		27547007,
		0,
		Lang.get(75440),
		27547,
		7,
		300,
		{
			RTResTalkAction[78]
		}
	},
	[27547008] = {
		27547008,
		0,
		Lang.get(75441),
		27547,
		8,
		1009,
		{
			RTResTalkAction[78]
		}
	},
	[27547009] = {
		27547009,
		0,
		Lang.get(75442),
		27547,
		9,
		300,
		{
			RTResTalkAction[78]
		}
	},
	[27547010] = {
		27547010,
		0,
		Lang.get(75443),
		27547,
		10,
		1009,
		{
			RTResTalkAction[78]
		}
	},
	[27547011] = {
		27547011,
		4,
		nil,
		27547,
		11,
		1009,
		{
			RTResTalkAction[78]
		},
		[29] = {
			{
				id = 27547012,
				branch_content = Lang.get(75444)
			},
			{
				id = 27547012,
				branch_content = Lang.get(75445)
			}
		}
	},
	[27547012] = {
		27547012,
		0,
		Lang.get(75446),
		27547,
		12,
		1009,
		{
			RTResTalkAction[78]
		}
	},
	[27547013] = {
		27547013,
		0,
		Lang.get(75447),
		27547,
		13,
		300,
		{
			RTResTalkAction[78]
		}
	},
	[27547014] = {
		27547014,
		0,
		Lang.get(75448),
		27547,
		14,
		1009,
		{
			RTResTalkAction[78]
		}
	},
	[27548001] = {
		27548001,
		0,
		Lang.get(75449),
		27548,
		1,
		1010,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27548,
		[19] = 27548
	},
	[27548002] = {
		27548002,
		0,
		Lang.get(75450),
		27548,
		2,
		1010,
		nil,
		1
	},
	[27548003] = {
		27548003,
		0,
		Lang.get(75451),
		27548,
		3,
		300,
		{
			RTResTalkAction[79]
		},
		nil,
		nil,
		3
	},
	[27548004] = {
		27548004,
		0,
		Lang.get(75452),
		27548,
		4,
		605,
		{
			RTResTalkAction[79]
		}
	},
	[27548005] = {
		27548005,
		0,
		Lang.get(75453),
		27548,
		5,
		300,
		{
			RTResTalkAction[79]
		}
	},
	[27548006] = {
		27548006,
		0,
		"……",
		27548,
		6,
		1010,
		{
			RTResTalkAction[79]
		}
	},
	[27548007] = {
		27548007,
		0,
		Lang.get(75454),
		27548,
		7,
		300,
		{
			RTResTalkAction[79]
		}
	},
	[27548008] = {
		27548008,
		0,
		Lang.get(75455),
		27548,
		8,
		300,
		{
			RTResTalkAction[79]
		}
	},
	[27548009] = {
		27548009,
		0,
		Lang.get(75456),
		27548,
		9,
		1010,
		{
			RTResTalkAction[79]
		}
	},
	[27548010] = {
		27548010,
		0,
		Lang.get(75457),
		27548,
		10,
		1010,
		{
			RTResTalkAction[79]
		}
	},
	[27548011] = {
		27548011,
		0,
		Lang.get(75458),
		27548,
		11,
		300,
		{
			RTResTalkAction[79]
		}
	},
	[27548012] = {
		27548012,
		0,
		Lang.get(75459),
		27548,
		12,
		300,
		{
			RTResTalkAction[79]
		}
	},
	[27548013] = {
		27548013,
		0,
		Lang.get(75460),
		27548,
		13,
		1010,
		{
			RTResTalkAction[79]
		}
	},
	[27548014] = {
		27548014,
		0,
		Lang.get(75461),
		27548,
		14,
		300,
		{
			RTResTalkAction[79]
		}
	},
	[27548015] = {
		27548015,
		0,
		Lang.get(75462),
		27548,
		15,
		1010,
		{
			RTResTalkAction[79]
		}
	},
	[27549001] = {
		27549001,
		0,
		Lang.get(75463),
		27549,
		1,
		1010,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27549,
		[19] = 27549
	},
	[27549002] = {
		27549002,
		0,
		Lang.get(75464),
		27549,
		2,
		300
	},
	[27549003] = {
		27549003,
		0,
		Lang.get(75465),
		27549,
		3,
		1010,
		nil,
		1,
		nil,
		3
	},
	[27549004] = {
		27549004,
		0,
		Lang.get(75466),
		27549,
		4,
		300,
		{
			RTResTalkAction[79]
		}
	},
	[27549005] = {
		27549005,
		0,
		Lang.get(75467),
		27549,
		5,
		1010,
		{
			RTResTalkAction[79]
		}
	},
	[27549006] = {
		27549006,
		0,
		Lang.get(75468),
		27549,
		6,
		1010,
		{
			RTResTalkAction[79]
		}
	},
	[27549007] = {
		27549007,
		0,
		Lang.get(75469),
		27549,
		7,
		1010,
		{
			RTResTalkAction[79]
		}
	},
	[27549008] = {
		27549008,
		0,
		Lang.get(75470),
		27549,
		8,
		300,
		{
			RTResTalkAction[79]
		}
	},
	[27549009] = {
		27549009,
		0,
		Lang.get(75471),
		27549,
		9,
		1010,
		{
			RTResTalkAction[79]
		}
	},
	[27549010] = {
		27549010,
		0,
		Lang.get(75472),
		27549,
		10,
		1010,
		{
			RTResTalkAction[79]
		}
	},
	[27549011] = {
		27549011,
		0,
		Lang.get(75473),
		27549,
		11,
		1010,
		{
			RTResTalkAction[79]
		}
	},
	[27549012] = {
		27549012,
		0,
		Lang.get(75474),
		27549,
		12,
		1010,
		{
			RTResTalkAction[79]
		}
	},
	[27549013] = {
		27549013,
		0,
		Lang.get(75475),
		27549,
		13,
		300,
		{
			RTResTalkAction[79]
		}
	},
	[27549014] = {
		27549014,
		0,
		Lang.get(75476),
		27549,
		14,
		1010,
		{
			RTResTalkAction[79]
		}
	},
	[27549015] = {
		27549015,
		0,
		Lang.get(75477),
		27549,
		15,
		1010,
		{
			RTResTalkAction[79]
		}
	},
	[27550001] = {
		27550001,
		0,
		Lang.get(75478),
		27550,
		1,
		1010,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27550,
		[19] = 27550
	},
	[27550002] = {
		27550002,
		0,
		Lang.get(75479),
		27550,
		2,
		1010,
		nil,
		1
	},
	[27550003] = {
		27550003,
		0,
		Lang.get(75480),
		27550,
		3,
		300,
		{
			RTResTalkAction[79]
		},
		nil,
		nil,
		3
	},
	[27550004] = {
		27550004,
		0,
		Lang.get(75481),
		27550,
		4,
		1010,
		{
			RTResTalkAction[79]
		}
	},
	[27550005] = {
		27550005,
		0,
		Lang.get(75482),
		27550,
		5,
		1010,
		{
			RTResTalkAction[79]
		}
	},
	[27550006] = {
		27550006,
		0,
		Lang.get(75483),
		27550,
		6,
		300,
		{
			RTResTalkAction[79]
		}
	},
	[27550007] = {
		27550007,
		0,
		Lang.get(75484),
		27550,
		7,
		1010,
		{
			RTResTalkAction[79]
		}
	},
	[27550008] = {
		27550008,
		0,
		Lang.get(75485),
		27550,
		8,
		1010,
		{
			RTResTalkAction[79]
		}
	},
	[27550009] = {
		27550009,
		0,
		Lang.get(75486),
		27550,
		9,
		300,
		{
			RTResTalkAction[79]
		}
	},
	[27550010] = {
		27550010,
		0,
		Lang.get(75487),
		27550,
		10,
		300,
		{
			RTResTalkAction[79]
		}
	},
	[27550011] = {
		27550011,
		0,
		Lang.get(75488),
		27550,
		11,
		1010,
		{
			RTResTalkAction[79]
		}
	},
	[27550012] = {
		27550012,
		0,
		Lang.get(75489),
		27550,
		12,
		1010,
		{
			RTResTalkAction[79]
		}
	},
	[27550013] = {
		27550013,
		0,
		Lang.get(75490),
		27550,
		13,
		1010,
		{
			RTResTalkAction[79]
		}
	},
	[27550014] = {
		27550014,
		0,
		Lang.get(75491),
		27550,
		14,
		300,
		{
			RTResTalkAction[79]
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
