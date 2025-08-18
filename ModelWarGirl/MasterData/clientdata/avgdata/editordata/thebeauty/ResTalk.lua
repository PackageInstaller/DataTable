-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\thebeauty\\ResTalk.lua

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
	[2] = 728
}
RTResTalkAction[2] = {
	[1] = 2,
	[2] = 728
}
RTResTalkAction[3] = {
	[1] = 3,
	[2] = 729
}
RTResTalkAction[4] = {
	[1] = 1,
	[2] = 727
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 728
}
RTResTalkAction[6] = {
	[1] = 0,
	[2] = 729
}
RTResTalkAction[7] = {
	[1] = 0,
	[2] = 727
}
RTResTalkAction[8] = {
	1,
	270,
	nil,
	nil,
	1
}
RTResTalkAction[9] = {
	[1] = 0,
	[2] = 270
}
RTResTalkAction[10] = {
	[1] = 3,
	[2] = 729,
	[3] = {
		1
	}
}
RTResTalkAction[11] = {
	[1] = 1,
	[2] = 730
}
RTResTalkAction[12] = {
	[1] = 1,
	[2] = 731
}
RTResTalkAction[13] = {
	[1] = 0,
	[2] = 730
}
RTResTalkAction[14] = {
	[1] = 2,
	[2] = 731
}
RTResTalkAction[15] = {
	[1] = 3,
	[2] = 732
}
RTResTalkAction[16] = {
	[1] = 0,
	[2] = 731
}
RTResTalkAction[17] = {
	[1] = 0,
	[2] = 732
}
RTResTalkAction[18] = {
	[1] = 1,
	[2] = 282
}
RTResTalkAction[19] = {
	[1] = 0,
	[2] = 282
}
RTResTalkAction[20] = {
	[1] = 1,
	[2] = 283
}
RTResTalkAction[21] = {
	[1] = 0,
	[2] = 283
}
RTResTalkAction[22] = {
	[1] = 1,
	[2] = 149
}
RTResTalkAction[23] = {
	[1] = 1,
	[2] = 167
}
RTResTalkAction[24] = {
	[1] = 0,
	[2] = 149
}
RTResTalkAction[25] = {
	1,
	269,
	nil,
	nil,
	1
}
RTResTalkAction[26] = {
	[1] = 0,
	[2] = 167
}
RTResTalkAction[27] = {
	[1] = 0,
	[2] = 269
}
RTResTalkAction[28] = {
	[1] = 1,
	[2] = 269
}
RTResTalkAction[29] = {
	[1] = 1,
	[2] = 176
}
RTResTalkAction[30] = {
	1,
	269,
	nil,
	nil,
	2
}
RTResTalkAction[31] = {
	[1] = 0,
	[2] = 176
}
RTResTalkAction[32] = {
	1,
	269,
	nil,
	nil,
	0
}
RTResTalkAction[33] = {
	1,
	269,
	nil,
	nil,
	3
}
RTResTalkAction[34] = {
	1,
	149,
	nil,
	nil,
	1
}
RTResTalkAction[35] = {
	[1] = 1,
	[2] = 739
}
RTResTalkAction[36] = {
	[1] = 1,
	[2] = 738
}
RTResTalkAction[37] = {
	[1] = 0,
	[2] = 739
}
RTResTalkAction[38] = {
	[1] = 0,
	[2] = 738
}
RTResTalkAction[39] = {
	1,
	107,
	nil,
	nil,
	7
}
RTResTalkAction[40] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[41] = {
	[1] = 3,
	[2] = 141
}
RTResTalkAction[42] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[43] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[44] = {
	1,
	107,
	nil,
	nil,
	5
}
RTResTalkAction[45] = {
	[1] = 1,
	[2] = 412
}
RTResTalkAction[46] = {
	[1] = 0,
	[2] = 412
}
RTResTalkAction[47] = {
	1,
	107,
	{
		1
	},
	nil,
	8
}
RTResTalkAction[48] = {
	1,
	107,
	nil,
	nil,
	11
}
RTResTalkAction[49] = {
	1,
	133,
	nil,
	nil,
	1
}
RTResTalkAction[50] = {
	[1] = 1,
	[2] = 741,
	[3] = {
		3
	}
}
RTResTalkAction[51] = {
	[1] = 0,
	[2] = 133
}
RTResTalkAction[52] = {
	1,
	107,
	nil,
	nil,
	10
}
RTResTalkAction[53] = {
	[1] = 0,
	[2] = 741
}
RTResTalkAction[54] = {
	1,
	141,
	nil,
	nil,
	3
}
RTResTalkAction[55] = {
	[1] = 1,
	[2] = 743,
	[3] = {
		2
	}
}
RTResTalkAction[56] = {
	[1] = 2,
	[2] = 743
}
RTResTalkAction[57] = {
	[1] = 3,
	[2] = 744,
	[3] = {
		3
	}
}
RTResTalkAction[58] = {
	[1] = 0,
	[2] = 743
}
RTResTalkAction[59] = {
	[1] = 0,
	[2] = 744
}
RTResTalkAction[60] = {
	1,
	141,
	nil,
	nil,
	2
}
RTResTalkAction[61] = {
	1,
	107,
	nil,
	nil,
	3
}
RTResTalkAction[62] = {
	[1] = 1,
	[2] = 742
}
RTResTalkAction[63] = {
	[1] = 2,
	[2] = 742
}
RTResTalkAction[64] = {
	[1] = 3,
	[2] = 744
}
RTResTalkAction[65] = {
	1,
	107,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[66] = {
	[1] = 0,
	[2] = 742
}
RTResTalkAction[67] = {
	1,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[68] = {
	1,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[69] = {
	1,
	269,
	{
		1
	},
	nil,
	3
}
RTResTalkAction[70] = {
	[1] = 1,
	[2] = 141
}
RTResTalkAction[71] = {
	[1] = 1,
	[2] = 729
}
RTResTalkAction[72] = {
	[1] = 1,
	[2] = 124
}
RTResTalkAction[73] = {
	[1] = 0,
	[2] = 124
}
RTResTalkAction[74] = {
	[1] = 1,
	[2] = 269,
	[3] = {
		1
	}
}
RTResTalkAction[75] = {
	[1] = 1,
	[2] = 746
}
RTResTalkAction[76] = {
	[1] = 1,
	[2] = 270
}
RTResTalkAction[77] = {
	[1] = 0,
	[2] = 746
}
RTResTalkAction[78] = {
	[1] = 1,
	[2] = 747
}
RTResTalkAction[79] = {
	[1] = 0,
	[2] = 747
}
RTResTalkAction[80] = {
	[1] = 1,
	[2] = 214
}
RTResTalkAction[81] = {
	[1] = 0,
	[2] = 214
}
RTResTalkAction[82] = {
	1,
	214,
	nil,
	nil,
	1
}
RTResTalkAction[83] = {
	[1] = 1,
	[2] = 746,
	[3] = {
		1
	}
}
RTResTalkAction[84] = {
	[1] = 2,
	[2] = 746
}
RTResTalkAction[85] = {
	[1] = 3,
	[2] = 748,
	[3] = {
		3
	}
}
RTResTalkAction[86] = {
	[1] = 0,
	[2] = 748
}
RTResTalkAction[87] = {
	1,
	107,
	{
		1
	},
	nil,
	6
}
RTResTalkAction[88] = {
	[1] = 1,
	[2] = 749,
	[3] = {
		3
	}
}
RTResTalkAction[89] = {
	[1] = 0,
	[2] = 749
}
RTResTalkAction[90] = {
	[1] = 1,
	[2] = 749
}
RTResTalkAction[91] = {
	[1] = 1,
	[2] = 749,
	[3] = {
		1
	}
}
RTResTalkAction[92] = {
	1,
	141,
	nil,
	nil,
	0
}
RTResTalkAction[93] = {
	[1] = 1,
	[2] = 748,
	[3] = {
		3
	}
}
RTResTalkAction[94] = {
	[1] = 1,
	[2] = 746,
	[3] = {
		3
	}
}
RTResTalkAction[95] = {
	[1] = 1,
	[2] = 133
}
RTResTalkAction[96] = {
	1,
	141,
	nil,
	nil,
	1
}
RTResTalkAction[97] = {
	[1] = 1,
	[2] = 300
}
RTResTalkAction[98] = {
	[1] = 0,
	[2] = 300
}
RTResTalkAction[99] = {
	[1] = 1,
	[2] = 284
}
RTResTalkAction[100] = {
	[1] = 1,
	[2] = 285
}
RTResTalkAction[101] = {
	[1] = 0,
	[2] = 284
}
RTResTalkAction[102] = {
	1,
	107,
	{
		1
	},
	nil,
	5
}
RTResTalkAction[103] = {
	[1] = 0,
	[2] = 285
}

local Data = {
	[25000001] = {
		25000001,
		0,
		Lang.get(63506),
		25000,
		1,
		727,
		nil,
		1,
		nil,
		nil,
		nil,
		31,
		25000,
		nil,
		1,
		nil,
		1,
		nil,
		25000
	},
	[25000002] = {
		25000002,
		0,
		Lang.get(63507),
		25000,
		2,
		728,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[25000003] = {
		25000003,
		0,
		Lang.get(63508),
		25000,
		3,
		729,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[25000004] = {
		25000004,
		0,
		Lang.get(63509),
		25000,
		4,
		727,
		{
			RTResTalkAction[4],
			RTResTalkAction[5],
			RTResTalkAction[6]
		}
	},
	[25000005] = {
		25000005,
		7,
		"75",
		25000,
		5,
		727,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		5,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[25000006] = {
		25000006,
		0,
		Lang.get(63510),
		25000,
		6,
		270,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3
	},
	[25000007] = {
		25000007,
		0,
		Lang.get(63511),
		25000,
		7,
		728,
		{
			RTResTalkAction[2],
			RTResTalkAction[3],
			RTResTalkAction[9]
		}
	},
	[25000008] = {
		25000008,
		5,
		Lang.get(63512),
		25000,
		8,
		729,
		{
			RTResTalkAction[2],
			RTResTalkAction[10]
		}
	},
	[25001001] = {
		25001001,
		0,
		Lang.get(63513),
		25001,
		1,
		730,
		nil,
		1,
		nil,
		nil,
		nil,
		171,
		25001,
		nil,
		1,
		nil,
		1,
		nil,
		25001
	},
	[25001002] = {
		25001002,
		0,
		Lang.get(63514),
		25001,
		2,
		730,
		nil,
		1
	},
	[25001003] = {
		25001003,
		0,
		Lang.get(63515),
		25001,
		3,
		730,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3
	},
	[25001004] = {
		25001004,
		0,
		Lang.get(63516),
		25001,
		4,
		731,
		{
			RTResTalkAction[12],
			RTResTalkAction[13]
		}
	},
	[25001005] = {
		25001005,
		0,
		Lang.get(63517),
		25001,
		5,
		732,
		{
			RTResTalkAction[14],
			RTResTalkAction[15]
		}
	},
	[25001006] = {
		25001006,
		0,
		Lang.get(63518),
		25001,
		6,
		282,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		25002,
		nil,
		1,
		nil,
		1,
		nil,
		25002
	},
	[25001007] = {
		25001007,
		7,
		"76",
		25001,
		7,
		282,
		nil,
		nil,
		nil,
		5
	},
	[25001008] = {
		25001008,
		0,
		Lang.get(63519),
		25001,
		8,
		730,
		nil,
		1,
		nil,
		-1
	},
	[25001009] = {
		25001009,
		0,
		Lang.get(63520),
		25001,
		9,
		282,
		{
			RTResTalkAction[18]
		},
		nil,
		nil,
		3
	},
	[25001010] = {
		25001010,
		0,
		Lang.get(63521),
		25001,
		10,
		730,
		{
			RTResTalkAction[11],
			RTResTalkAction[19]
		}
	},
	[25001011] = {
		25001011,
		9,
		Lang.get(63522),
		25001,
		11,
		605,
		{
			RTResTalkAction[13]
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
	[25001012] = {
		25001012,
		0,
		Lang.get(63523),
		25001,
		12,
		730,
		{
			RTResTalkAction[11]
		}
	},
	[25001013] = {
		25001013,
		0,
		Lang.get(63524),
		25001,
		13,
		282,
		{
			RTResTalkAction[18],
			RTResTalkAction[13]
		}
	},
	[25001014] = {
		25001014,
		0,
		Lang.get(63525),
		25001,
		14,
		282,
		{
			RTResTalkAction[19]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		25050,
		nil,
		1,
		nil,
		1,
		nil,
		25050
	},
	[25001015] = {
		25001015,
		0,
		Lang.get(63526),
		25001,
		15,
		283,
		{
			RTResTalkAction[20]
		},
		nil,
		nil,
		3
	},
	[25001016] = {
		25001016,
		7,
		"77",
		25001,
		16,
		283,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		5,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[25001017] = {
		25001017,
		0,
		Lang.get(63527),
		25001,
		17,
		283,
		{
			RTResTalkAction[20]
		},
		nil,
		nil,
		3
	},
	[25001018] = {
		25001018,
		0,
		Lang.get(63528),
		25001,
		18,
		282,
		{
			RTResTalkAction[18],
			RTResTalkAction[21]
		}
	},
	[25001019] = {
		25001019,
		0,
		Lang.get(63529),
		25001,
		19,
		283,
		{
			RTResTalkAction[20],
			RTResTalkAction[19]
		}
	},
	[25001020] = {
		25001020,
		9,
		Lang.get(63530),
		25001,
		20,
		605,
		{
			RTResTalkAction[21]
		},
		[22] = 1
	},
	[25001021] = {
		25001021,
		0,
		Lang.get(63531),
		25001,
		21,
		282,
		{
			RTResTalkAction[18]
		}
	},
	[25001022] = {
		25001022,
		0,
		Lang.get(63532),
		25001,
		22,
		282,
		{
			RTResTalkAction[18]
		}
	},
	[25001023] = {
		25001023,
		0,
		Lang.get(63533),
		25001,
		23,
		282,
		{
			RTResTalkAction[18]
		}
	},
	[25001024] = {
		25001024,
		0,
		Lang.get(63534),
		25001,
		24,
		283,
		{
			RTResTalkAction[20],
			RTResTalkAction[19]
		}
	},
	[25002001] = {
		25002001,
		0,
		Lang.get(63535),
		25002,
		1,
		733,
		nil,
		1,
		nil,
		nil,
		nil,
		31,
		25003,
		nil,
		1,
		nil,
		1,
		nil,
		25003
	},
	[25002002] = {
		25002002,
		0,
		Lang.get(63536),
		25002,
		2,
		734,
		nil,
		1
	},
	[25002003] = {
		25002003,
		0,
		Lang.get(63537),
		25002,
		3,
		733,
		nil,
		1
	},
	[25002004] = {
		25002004,
		0,
		Lang.get(63538),
		25002,
		4,
		734,
		nil,
		1
	},
	[25002005] = {
		25002005,
		0,
		Lang.get(63539),
		25002,
		5,
		734,
		nil,
		1
	},
	[25002006] = {
		25002006,
		0,
		Lang.get(63540),
		25002,
		6,
		733,
		nil,
		1
	},
	[25002007] = {
		25002007,
		0,
		Lang.get(63541),
		25002,
		7,
		734,
		nil,
		1
	},
	[25002008] = {
		25002008,
		0,
		Lang.get(63542),
		25002,
		8,
		733,
		nil,
		1
	},
	[25002009] = {
		25002009,
		9,
		Lang.get(63543),
		25002,
		9,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		25004,
		nil,
		1,
		nil,
		1,
		nil,
		25004,
		nil,
		nil,
		1
	},
	[25002010] = {
		25002010,
		0,
		Lang.get(63544),
		25002,
		10,
		149,
		{
			RTResTalkAction[22]
		},
		nil,
		nil,
		3
	},
	[25002011] = {
		25002011,
		0,
		Lang.get(63545),
		25002,
		11,
		167,
		{
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[25002012] = {
		25002012,
		0,
		Lang.get(63546),
		25002,
		12,
		269,
		{
			RTResTalkAction[25],
			RTResTalkAction[26]
		}
	},
	[25002013] = {
		25002013,
		7,
		"78",
		25002,
		13,
		269,
		{
			RTResTalkAction[27]
		},
		nil,
		nil,
		5,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[25002014] = {
		25002014,
		0,
		Lang.get(63547),
		25002,
		14,
		149,
		{
			RTResTalkAction[22]
		},
		nil,
		nil,
		3
	},
	[25002015] = {
		25002015,
		0,
		Lang.get(63548),
		25002,
		15,
		167,
		{
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[25002016] = {
		25002016,
		0,
		Lang.get(63549),
		25002,
		16,
		269,
		{
			RTResTalkAction[28],
			RTResTalkAction[26]
		}
	},
	[25002017] = {
		25002017,
		0,
		Lang.get(63550),
		25002,
		17,
		149,
		{
			RTResTalkAction[22],
			RTResTalkAction[27]
		}
	},
	[25002018] = {
		25002018,
		0,
		Lang.get(63551),
		25002,
		18,
		176,
		{
			RTResTalkAction[29],
			RTResTalkAction[24]
		}
	},
	[25002019] = {
		25002019,
		0,
		Lang.get(63552),
		25002,
		19,
		269,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[25002020] = {
		25002020,
		0,
		Lang.get(63553),
		25002,
		20,
		149,
		{
			RTResTalkAction[22],
			RTResTalkAction[27]
		}
	},
	[25002021] = {
		25002021,
		0,
		Lang.get(63554),
		25002,
		21,
		149,
		{
			RTResTalkAction[22]
		}
	},
	[25002022] = {
		25002022,
		0,
		Lang.get(63555),
		25002,
		22,
		149,
		{
			RTResTalkAction[22]
		}
	},
	[25002023] = {
		25002023,
		0,
		Lang.get(63556),
		25002,
		23,
		269,
		{
			RTResTalkAction[32],
			RTResTalkAction[24]
		}
	},
	[25002024] = {
		25002024,
		0,
		Lang.get(63557),
		25002,
		24,
		149,
		{
			RTResTalkAction[22],
			RTResTalkAction[27]
		}
	},
	[25002025] = {
		25002025,
		0,
		Lang.get(63558),
		25002,
		25,
		149,
		{
			RTResTalkAction[22]
		}
	},
	[25002026] = {
		25002026,
		0,
		Lang.get(63559),
		25002,
		26,
		149,
		{
			RTResTalkAction[22]
		}
	},
	[25002027] = {
		25002027,
		0,
		Lang.get(63560),
		25002,
		27,
		149,
		{
			RTResTalkAction[22]
		}
	},
	[25002028] = {
		25002028,
		0,
		Lang.get(63561),
		25002,
		28,
		149,
		{
			RTResTalkAction[22]
		}
	},
	[25003001] = {
		25003001,
		0,
		Lang.get(63562),
		25003,
		1,
		149,
		nil,
		1,
		nil,
		nil,
		nil,
		170,
		25005,
		nil,
		1,
		nil,
		1,
		nil,
		25005
	},
	[25003002] = {
		25003002,
		0,
		Lang.get(63563),
		25003,
		2,
		269,
		{
			RTResTalkAction[33]
		},
		nil,
		nil,
		3
	},
	[25003003] = {
		25003003,
		0,
		Lang.get(63564),
		25003,
		3,
		149,
		{
			RTResTalkAction[22],
			RTResTalkAction[27]
		}
	},
	[25003004] = {
		25003004,
		0,
		Lang.get(63565),
		25003,
		4,
		149,
		{
			RTResTalkAction[22]
		}
	},
	[25003005] = {
		25003005,
		0,
		Lang.get(63566),
		25003,
		5,
		176,
		{
			RTResTalkAction[29],
			RTResTalkAction[24]
		}
	},
	[25003006] = {
		25003006,
		0,
		Lang.get(63567),
		25003,
		6,
		269,
		{
			RTResTalkAction[32],
			RTResTalkAction[31]
		}
	},
	[25003007] = {
		25003007,
		0,
		Lang.get(63568),
		25003,
		7,
		149,
		{
			RTResTalkAction[22],
			RTResTalkAction[27]
		}
	},
	[25003008] = {
		25003008,
		9,
		Lang.get(63569),
		25003,
		8,
		605,
		{
			RTResTalkAction[24]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		25051,
		nil,
		1,
		nil,
		1,
		nil,
		25051,
		nil,
		nil,
		1
	},
	[25003009] = {
		25003009,
		0,
		Lang.get(63570),
		25003,
		9,
		149,
		{
			RTResTalkAction[22]
		},
		nil,
		nil,
		3
	},
	[25003010] = {
		25003010,
		0,
		Lang.get(63571),
		25003,
		10,
		176,
		{
			RTResTalkAction[29],
			RTResTalkAction[24]
		}
	},
	[25003011] = {
		25003011,
		0,
		Lang.get(63572),
		25003,
		11,
		269,
		{
			RTResTalkAction[28],
			RTResTalkAction[31]
		}
	},
	[25003012] = {
		25003012,
		0,
		Lang.get(63573),
		25003,
		12,
		149,
		{
			RTResTalkAction[34],
			RTResTalkAction[27]
		}
	},
	[25003013] = {
		25003013,
		0,
		Lang.get(63574),
		25003,
		13,
		149,
		{
			RTResTalkAction[22]
		}
	},
	[25004001] = {
		25004001,
		0,
		Lang.get(63575),
		25004,
		1,
		735,
		nil,
		1,
		nil,
		nil,
		nil,
		31,
		25006,
		nil,
		1,
		nil,
		1,
		nil,
		25006
	},
	[25004002] = {
		25004002,
		0,
		Lang.get(63576),
		25004,
		2,
		739,
		{
			RTResTalkAction[35]
		},
		nil,
		nil,
		3
	},
	[25004003] = {
		25004003,
		0,
		Lang.get(63577),
		25004,
		3,
		738,
		{
			RTResTalkAction[36],
			RTResTalkAction[37]
		}
	},
	[25004004] = {
		25004004,
		0,
		Lang.get(63578),
		25004,
		4,
		739,
		{
			RTResTalkAction[35],
			RTResTalkAction[38]
		}
	},
	[25004005] = {
		25004005,
		0,
		Lang.get(63579),
		25004,
		5,
		736,
		{
			RTResTalkAction[37]
		},
		1
	},
	[25004006] = {
		25004006,
		0,
		Lang.get(63580),
		25004,
		6,
		737,
		nil,
		1
	},
	[25004007] = {
		25004007,
		0,
		Lang.get(63581),
		25004,
		7,
		736,
		nil,
		1
	},
	[25004008] = {
		25004008,
		0,
		Lang.get(63582),
		25004,
		8,
		739,
		{
			RTResTalkAction[35]
		}
	},
	[25004009] = {
		25004009,
		0,
		Lang.get(63583),
		25004,
		9,
		738,
		{
			RTResTalkAction[36],
			RTResTalkAction[37]
		}
	},
	[25004010] = {
		25004010,
		0,
		Lang.get(63584),
		25004,
		10,
		739,
		{
			RTResTalkAction[38]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		25007,
		nil,
		1,
		nil,
		1,
		nil,
		25007
	},
	[25004011] = {
		25004011,
		0,
		Lang.get(63585),
		25004,
		11,
		738,
		{
			RTResTalkAction[36]
		},
		nil,
		nil,
		3
	},
	[25004012] = {
		25004012,
		0,
		Lang.get(63586),
		25004,
		12,
		736,
		{
			RTResTalkAction[38]
		},
		1
	},
	[25004013] = {
		25004013,
		0,
		Lang.get(63587),
		25004,
		13,
		735,
		nil,
		1
	},
	[25004014] = {
		25004014,
		0,
		Lang.get(63588),
		25004,
		14,
		739,
		{
			RTResTalkAction[35]
		}
	},
	[25005001] = {
		25005001,
		0,
		Lang.get(63589),
		25005,
		1,
		269,
		nil,
		1,
		1,
		nil,
		nil,
		31,
		25008,
		nil,
		1,
		nil,
		1,
		nil,
		25008
	},
	[25005002] = {
		25005002,
		0,
		Lang.get(63590),
		25005,
		2,
		739,
		{
			RTResTalkAction[35]
		},
		nil,
		0,
		3
	},
	[25005003] = {
		25005003,
		0,
		Lang.get(63591),
		25005,
		3,
		738,
		{
			RTResTalkAction[36],
			RTResTalkAction[37]
		}
	},
	[25005004] = {
		25005004,
		0,
		Lang.get(63592),
		25005,
		4,
		269,
		{
			RTResTalkAction[25],
			RTResTalkAction[38]
		}
	},
	[25005005] = {
		25005005,
		0,
		Lang.get(63593),
		25005,
		5,
		738,
		{
			RTResTalkAction[36],
			RTResTalkAction[27]
		}
	},
	[25005006] = {
		25005006,
		0,
		Lang.get(63594),
		25005,
		6,
		269,
		{
			RTResTalkAction[28],
			RTResTalkAction[38]
		}
	},
	[25005007] = {
		25005007,
		0,
		Lang.get(63595),
		25005,
		7,
		738,
		{
			RTResTalkAction[36],
			RTResTalkAction[27]
		}
	},
	[25005008] = {
		25005008,
		0,
		Lang.get(63596),
		25005,
		8,
		269,
		{
			RTResTalkAction[28],
			RTResTalkAction[38]
		}
	},
	[25005009] = {
		25005009,
		0,
		Lang.get(63597),
		25005,
		9,
		738,
		{
			RTResTalkAction[36],
			RTResTalkAction[27]
		}
	},
	[25005010] = {
		25005010,
		0,
		Lang.get(63598),
		25005,
		10,
		269,
		{
			RTResTalkAction[28],
			RTResTalkAction[38]
		}
	},
	[25005011] = {
		25005011,
		0,
		Lang.get(63599),
		25005,
		11,
		738,
		{
			RTResTalkAction[36],
			RTResTalkAction[27]
		}
	},
	[25005012] = {
		25005012,
		0,
		Lang.get(63600),
		25005,
		12,
		269,
		{
			RTResTalkAction[30],
			RTResTalkAction[38]
		}
	},
	[25005013] = {
		25005013,
		0,
		Lang.get(63601),
		25005,
		13,
		738,
		{
			RTResTalkAction[36],
			RTResTalkAction[27]
		}
	},
	[25005014] = {
		25005014,
		0,
		Lang.get(63602),
		25005,
		14,
		269,
		{
			RTResTalkAction[28],
			RTResTalkAction[38]
		}
	},
	[25005015] = {
		25005015,
		0,
		Lang.get(63603),
		25005,
		15,
		269,
		{
			RTResTalkAction[32]
		}
	},
	[25005016] = {
		25005016,
		0,
		Lang.get(63604),
		25005,
		16,
		736,
		{
			RTResTalkAction[27]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		25009,
		nil,
		1,
		nil,
		1,
		nil,
		25009
	},
	[25005017] = {
		25005017,
		0,
		Lang.get(63605),
		25005,
		17,
		738,
		{
			RTResTalkAction[36]
		},
		nil,
		nil,
		3
	},
	[25005018] = {
		25005018,
		0,
		Lang.get(63606),
		25005,
		18,
		739,
		{
			RTResTalkAction[35],
			RTResTalkAction[38]
		}
	},
	[25005019] = {
		25005019,
		0,
		Lang.get(63607),
		25005,
		19,
		738,
		{
			RTResTalkAction[36],
			RTResTalkAction[37]
		}
	},
	[25005020] = {
		25005020,
		0,
		Lang.get(63608),
		25005,
		20,
		738,
		{
			RTResTalkAction[36]
		}
	},
	[25005021] = {
		25005021,
		0,
		Lang.get(63609),
		25005,
		21,
		735,
		{
			RTResTalkAction[38]
		},
		1
	},
	[25005022] = {
		25005022,
		0,
		Lang.get(63610),
		25005,
		22,
		738,
		{
			RTResTalkAction[36]
		}
	},
	[25005023] = {
		25005023,
		0,
		Lang.get(63611),
		25005,
		23,
		739,
		{
			RTResTalkAction[35],
			RTResTalkAction[38]
		}
	},
	[25005024] = {
		25005024,
		0,
		Lang.get(63612),
		25005,
		24,
		738,
		{
			RTResTalkAction[36],
			RTResTalkAction[37]
		}
	},
	[25005025] = {
		25005025,
		0,
		Lang.get(63613),
		25005,
		25,
		738,
		{
			RTResTalkAction[36]
		}
	},
	[25005026] = {
		25005026,
		0,
		Lang.get(63614),
		25005,
		26,
		738,
		{
			RTResTalkAction[36]
		}
	},
	[25005027] = {
		25005027,
		0,
		Lang.get(63615),
		25005,
		27,
		739,
		{
			RTResTalkAction[35],
			RTResTalkAction[38]
		}
	},
	[25005028] = {
		25005028,
		0,
		Lang.get(63616),
		25005,
		28,
		738,
		{
			RTResTalkAction[36],
			RTResTalkAction[37]
		}
	},
	[25006001] = {
		25006001,
		0,
		Lang.get(63617),
		25006,
		1,
		176,
		nil,
		1,
		nil,
		nil,
		nil,
		31,
		25010,
		nil,
		1,
		nil,
		1,
		nil,
		25010
	},
	[25006002] = {
		25006002,
		0,
		Lang.get(63618),
		25006,
		2,
		176,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[25006003] = {
		25006003,
		0,
		Lang.get(63619),
		25006,
		3,
		176,
		{
			RTResTalkAction[29]
		}
	},
	[25006004] = {
		25006004,
		0,
		Lang.get(63620),
		25006,
		4,
		176,
		{
			RTResTalkAction[29]
		}
	},
	[25006005] = {
		25006005,
		0,
		Lang.get(63621),
		25006,
		5,
		739,
		{
			RTResTalkAction[35],
			RTResTalkAction[31]
		}
	},
	[25006006] = {
		25006006,
		0,
		Lang.get(63622),
		25006,
		6,
		176,
		{
			RTResTalkAction[37]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		25011,
		nil,
		1,
		nil,
		1,
		nil,
		25011
	},
	[25006007] = {
		25006007,
		0,
		Lang.get(63623),
		25006,
		7,
		176,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[25006008] = {
		25006008,
		0,
		Lang.get(63624),
		25006,
		8,
		176,
		{
			RTResTalkAction[29]
		}
	},
	[25006009] = {
		25006009,
		0,
		Lang.get(63625),
		25006,
		9,
		176,
		{
			RTResTalkAction[29]
		}
	},
	[25006010] = {
		25006010,
		0,
		Lang.get(63626),
		25006,
		10,
		739,
		{
			RTResTalkAction[35],
			RTResTalkAction[31]
		}
	},
	[25006011] = {
		25006011,
		9,
		Lang.get(63627),
		25006,
		11,
		605,
		{
			RTResTalkAction[37]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		25012,
		nil,
		1,
		nil,
		1,
		nil,
		25012,
		nil,
		nil,
		1
	},
	[25006012] = {
		25006012,
		0,
		Lang.get(63628),
		25006,
		12,
		739,
		{
			RTResTalkAction[35]
		},
		nil,
		nil,
		3
	},
	[25006013] = {
		25006013,
		0,
		Lang.get(63629),
		25006,
		13,
		739,
		{
			RTResTalkAction[35]
		}
	},
	[25007001] = {
		25007001,
		0,
		Lang.get(63630),
		25007,
		1,
		176,
		nil,
		1,
		nil,
		nil,
		nil,
		24,
		25013,
		nil,
		1,
		nil,
		1,
		nil,
		25013
	},
	[25007002] = {
		25007002,
		0,
		Lang.get(63631),
		25007,
		2,
		300
	},
	[25007003] = {
		25007003,
		0,
		Lang.get(63632),
		25007,
		3,
		176,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[25007004] = {
		25007004,
		0,
		Lang.get(63633),
		25007,
		4,
		107,
		{
			RTResTalkAction[39],
			RTResTalkAction[31]
		}
	},
	[25007005] = {
		25007005,
		0,
		Lang.get(63634),
		25007,
		5,
		141,
		{
			RTResTalkAction[40],
			RTResTalkAction[41]
		}
	},
	[25007006] = {
		25007006,
		0,
		Lang.get(63635),
		25007,
		6,
		176,
		{
			RTResTalkAction[29],
			RTResTalkAction[42],
			RTResTalkAction[43]
		}
	},
	[25007007] = {
		25007007,
		0,
		Lang.get(63636),
		25007,
		7,
		300,
		{
			RTResTalkAction[31]
		}
	},
	[25007008] = {
		25007008,
		0,
		Lang.get(63637),
		25007,
		8,
		107,
		{
			RTResTalkAction[44]
		}
	},
	[25007009] = {
		25007009,
		0,
		Lang.get(63638),
		25007,
		9,
		176,
		{
			RTResTalkAction[29],
			RTResTalkAction[42]
		}
	},
	[25007010] = {
		25007010,
		0,
		Lang.get(63639),
		25007,
		10,
		107,
		{
			RTResTalkAction[31]
		},
		1,
		6,
		nil,
		nil,
		nil,
		25014,
		nil,
		1,
		nil,
		1,
		nil,
		25014
	},
	[25007011] = {
		25007011,
		0,
		Lang.get(63640),
		25007,
		11,
		133,
		{
			RTResTalkAction[45]
		},
		1,
		1,
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
		412
	},
	[25007012] = {
		25007012,
		0,
		Lang.get(63641),
		25007,
		12,
		176,
		{
			RTResTalkAction[45]
		},
		1,
		0,
		[21] = 412
	},
	[25007013] = {
		25007013,
		0,
		Lang.get(63642),
		25007,
		13,
		300,
		{
			RTResTalkAction[45]
		},
		[21] = 412
	},
	[25007014] = {
		25007014,
		0,
		Lang.get(63643),
		25007,
		14,
		176,
		{
			RTResTalkAction[45]
		},
		1,
		0,
		[21] = 412
	},
	[25007015] = {
		25007015,
		0,
		Lang.get(63644),
		25007,
		15,
		176,
		{
			RTResTalkAction[29],
			RTResTalkAction[46]
		}
	},
	[25007016] = {
		25007016,
		0,
		Lang.get(63645),
		25007,
		16,
		176,
		{
			RTResTalkAction[29]
		}
	},
	[25007017] = {
		25007017,
		0,
		Lang.get(63646),
		25007,
		17,
		107,
		{
			RTResTalkAction[47],
			RTResTalkAction[31]
		}
	},
	[25007018] = {
		25007018,
		9,
		Lang.get(63647),
		25007,
		18,
		605,
		{
			RTResTalkAction[42]
		},
		[18] = 1070,
		[22] = 1
	},
	[25007019] = {
		25007019,
		5,
		Lang.get(63648),
		25007,
		19,
		740,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		25015,
		nil,
		1,
		nil,
		1,
		nil,
		25015
	},
	[25007020] = {
		25007020,
		0,
		Lang.get(63649),
		25007,
		20,
		176,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[25007021] = {
		25007021,
		0,
		Lang.get(63650),
		25007,
		21,
		176,
		{
			RTResTalkAction[29]
		}
	},
	[25007022] = {
		25007022,
		0,
		Lang.get(63651),
		25007,
		22,
		107,
		{
			RTResTalkAction[48],
			RTResTalkAction[31]
		}
	},
	[25007023] = {
		25007023,
		0,
		Lang.get(63652),
		25007,
		23,
		133,
		{
			RTResTalkAction[49],
			RTResTalkAction[42]
		}
	},
	[25007024] = {
		25007024,
		5,
		Lang.get(63653),
		25007,
		24,
		741,
		{
			RTResTalkAction[50],
			RTResTalkAction[51]
		},
		[18] = 1070
	},
	[25007025] = {
		25007025,
		0,
		Lang.get(63654),
		25007,
		25,
		107,
		{
			RTResTalkAction[52],
			RTResTalkAction[53]
		}
	},
	[25007026] = {
		25007026,
		0,
		Lang.get(63655),
		25007,
		26,
		141,
		{
			RTResTalkAction[54],
			RTResTalkAction[42]
		}
	},
	[25007027] = {
		25007027,
		0,
		Lang.get(63656),
		25007,
		27,
		739,
		{
			RTResTalkAction[43]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		25016,
		nil,
		1,
		nil,
		1,
		nil,
		25016
	},
	[25007028] = {
		25007028,
		0,
		Lang.get(63657),
		25007,
		28,
		739,
		{
			RTResTalkAction[35]
		},
		nil,
		nil,
		3
	},
	[25008001] = {
		25008001,
		5,
		Lang.get(63658),
		25008,
		1,
		742,
		nil,
		1,
		nil,
		nil,
		nil,
		31,
		25017,
		nil,
		1,
		nil,
		1,
		1070,
		25017
	},
	[25008002] = {
		25008002,
		5,
		Lang.get(63659),
		25008,
		2,
		743,
		{
			RTResTalkAction[55]
		},
		nil,
		nil,
		3
	},
	[25008003] = {
		25008003,
		5,
		Lang.get(63660),
		25008,
		3,
		744,
		{
			RTResTalkAction[56],
			RTResTalkAction[57]
		}
	},
	[25008004] = {
		25008004,
		0,
		Lang.get(63661),
		25008,
		4,
		739,
		{
			RTResTalkAction[35],
			RTResTalkAction[58],
			RTResTalkAction[59]
		}
	},
	[25008005] = {
		25008005,
		2,
		Lang.get(63662),
		25008,
		5,
		739,
		{
			RTResTalkAction[35]
		}
	},
	[25008006] = {
		25008006,
		0,
		Lang.get(63663),
		25008,
		6,
		107,
		{
			RTResTalkAction[37]
		},
		1,
		8,
		nil,
		nil,
		nil,
		25018,
		nil,
		1,
		nil,
		1,
		nil,
		25018
	},
	[25008007] = {
		25008007,
		0,
		Lang.get(63664),
		25008,
		7,
		141,
		{
			RTResTalkAction[60]
		},
		nil,
		0,
		3
	},
	[25008008] = {
		25008008,
		0,
		Lang.get(63665),
		25008,
		8,
		133,
		{
			RTResTalkAction[49],
			RTResTalkAction[43]
		}
	},
	[25008009] = {
		25008009,
		0,
		Lang.get(63666),
		25008,
		9,
		107,
		{
			RTResTalkAction[61],
			RTResTalkAction[51]
		}
	},
	[25008010] = {
		25008010,
		0,
		Lang.get(63667),
		25008,
		10,
		745,
		{
			RTResTalkAction[42]
		},
		1,
		2,
		nil,
		nil,
		nil,
		25019,
		nil,
		1,
		nil,
		nil,
		1070,
		25019
	},
	[25008011] = {
		25008011,
		0,
		Lang.get(63668),
		25008,
		11,
		742,
		{
			RTResTalkAction[62]
		},
		nil,
		0,
		3
	},
	[25008012] = {
		25008012,
		0,
		Lang.get(63669),
		25008,
		12,
		744,
		{
			RTResTalkAction[63],
			RTResTalkAction[64]
		}
	},
	[25008013] = {
		25008013,
		5,
		Lang.get(63670),
		25008,
		13,
		107,
		{
			RTResTalkAction[65],
			RTResTalkAction[66],
			RTResTalkAction[59]
		}
	},
	[25009001] = {
		25009001,
		0,
		Lang.get(63671),
		25009,
		1,
		269,
		nil,
		1,
		2,
		nil,
		nil,
		30,
		25020,
		nil,
		1,
		nil,
		1,
		nil,
		25020
	},
	[25009002] = {
		25009002,
		0,
		Lang.get(63672),
		25009,
		2,
		107,
		{
			RTResTalkAction[44]
		},
		nil,
		0,
		3
	},
	[25009003] = {
		25009003,
		0,
		Lang.get(63673),
		25009,
		3,
		269,
		{
			RTResTalkAction[30],
			RTResTalkAction[42]
		}
	},
	[25009004] = {
		25009004,
		0,
		Lang.get(63674),
		25009,
		4,
		300,
		{
			RTResTalkAction[27]
		}
	},
	[25009005] = {
		25009005,
		0,
		Lang.get(63675),
		25009,
		5,
		269,
		{
			RTResTalkAction[28]
		}
	},
	[25009006] = {
		25009006,
		0,
		Lang.get(63676),
		25009,
		6,
		269,
		{
			RTResTalkAction[28]
		}
	},
	[25009007] = {
		25009007,
		0,
		Lang.get(63677),
		25009,
		7,
		269,
		{
			RTResTalkAction[28]
		}
	},
	[25009008] = {
		25009008,
		0,
		Lang.get(63678),
		25009,
		8,
		269,
		{
			RTResTalkAction[28]
		}
	},
	[25009009] = {
		25009009,
		0,
		Lang.get(63679),
		25009,
		9,
		269,
		{
			RTResTalkAction[28]
		}
	},
	[25009010] = {
		25009010,
		0,
		Lang.get(63680),
		25009,
		10,
		300,
		{
			RTResTalkAction[27]
		}
	},
	[25009011] = {
		25009011,
		0,
		Lang.get(63681),
		25009,
		11,
		107,
		{
			RTResTalkAction[67]
		}
	},
	[25010001] = {
		25010001,
		0,
		Lang.get(63682),
		25010,
		1,
		739,
		nil,
		1,
		nil,
		nil,
		nil,
		31,
		25021,
		nil,
		1,
		nil,
		1,
		nil,
		25021
	},
	[25010002] = {
		25010002,
		0,
		Lang.get(63683),
		25010,
		2,
		739,
		{
			RTResTalkAction[35]
		},
		nil,
		nil,
		3
	},
	[25010003] = {
		25010003,
		0,
		Lang.get(63684),
		25010,
		3,
		739,
		{
			RTResTalkAction[35]
		}
	},
	[25010004] = {
		25010004,
		0,
		Lang.get(63685),
		25010,
		4,
		107,
		{
			RTResTalkAction[37]
		},
		1,
		8,
		nil,
		nil,
		nil,
		25022,
		nil,
		1,
		nil,
		1,
		nil,
		25022
	},
	[25010005] = {
		25010005,
		0,
		Lang.get(63686),
		25010,
		5,
		133,
		{
			RTResTalkAction[49]
		},
		nil,
		0,
		3
	},
	[25010006] = {
		25010006,
		0,
		Lang.get(63687),
		25010,
		6,
		141,
		{
			RTResTalkAction[60],
			RTResTalkAction[51]
		}
	},
	[25010007] = {
		25010007,
		0,
		Lang.get(63688),
		25010,
		7,
		107,
		{
			RTResTalkAction[68],
			RTResTalkAction[43]
		}
	},
	[25010008] = {
		25010008,
		0,
		Lang.get(63689),
		25010,
		8,
		300,
		{
			RTResTalkAction[42]
		}
	},
	[25010009] = {
		25010009,
		0,
		Lang.get(63690),
		25010,
		9,
		107,
		{
			RTResTalkAction[48]
		}
	},
	[25010010] = {
		25010010,
		0,
		Lang.get(63691),
		25010,
		10,
		300,
		{
			RTResTalkAction[42]
		}
	},
	[25010011] = {
		25010011,
		0,
		Lang.get(63692),
		25010,
		11,
		269,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		25023,
		nil,
		1,
		nil,
		1,
		nil,
		25023
	},
	[25010012] = {
		25010012,
		0,
		Lang.get(63693),
		25010,
		12,
		107,
		{
			RTResTalkAction[68]
		},
		nil,
		nil,
		3
	},
	[25010013] = {
		25010013,
		9,
		Lang.get(63694),
		25010,
		13,
		605,
		{
			RTResTalkAction[42]
		},
		[22] = 1
	},
	[25010014] = {
		25010014,
		0,
		Lang.get(63695),
		25010,
		14,
		269,
		{
			RTResTalkAction[25]
		}
	},
	[25010015] = {
		25010015,
		0,
		Lang.get(63696),
		25010,
		15,
		141,
		{
			RTResTalkAction[60],
			RTResTalkAction[27]
		}
	},
	[25010016] = {
		25010016,
		0,
		Lang.get(63697),
		25010,
		16,
		269,
		{
			RTResTalkAction[69],
			RTResTalkAction[43]
		}
	},
	[25010017] = {
		25010017,
		0,
		Lang.get(63698),
		25010,
		17,
		141,
		{
			RTResTalkAction[54],
			RTResTalkAction[27]
		}
	},
	[25010018] = {
		25010018,
		0,
		Lang.get(63699),
		25010,
		18,
		269,
		{
			RTResTalkAction[28],
			RTResTalkAction[43]
		}
	},
	[25010019] = {
		25010019,
		0,
		Lang.get(63700),
		25010,
		19,
		269,
		{
			RTResTalkAction[27]
		},
		1,
		2,
		nil,
		nil,
		169,
		25024,
		nil,
		1,
		nil,
		1,
		nil,
		25024
	},
	[25010020] = {
		25010020,
		0,
		Lang.get(63701),
		25010,
		20,
		141,
		{
			RTResTalkAction[70]
		},
		nil,
		nil,
		3
	},
	[25010021] = {
		25010021,
		0,
		Lang.get(63702),
		25010,
		21,
		269,
		{
			RTResTalkAction[30],
			RTResTalkAction[43]
		}
	},
	[25010022] = {
		25010022,
		0,
		Lang.get(63703),
		25010,
		22,
		269,
		{
			RTResTalkAction[28]
		}
	},
	[25010023] = {
		25010023,
		0,
		Lang.get(63704),
		25010,
		23,
		300,
		{
			RTResTalkAction[27]
		}
	},
	[25010024] = {
		25010024,
		0,
		Lang.get(63705),
		25010,
		24,
		269,
		{
			RTResTalkAction[32]
		}
	},
	[25010025] = {
		25010025,
		0,
		Lang.get(63706),
		25010,
		25,
		269,
		{
			RTResTalkAction[28]
		}
	},
	[25010026] = {
		25010026,
		9,
		Lang.get(63707),
		25010,
		26,
		605,
		{
			RTResTalkAction[27]
		},
		[22] = 1
	},
	[25010027] = {
		25010027,
		0,
		Lang.get(63708),
		25010,
		27,
		269,
		{
			RTResTalkAction[28]
		}
	},
	[25011001] = {
		25011001,
		0,
		Lang.get(63709),
		25011,
		1,
		739,
		nil,
		1,
		nil,
		nil,
		nil,
		31,
		25025,
		nil,
		1,
		nil,
		1,
		nil,
		25025
	},
	[25011002] = {
		25011002,
		0,
		Lang.get(63710),
		25011,
		2,
		739,
		{
			RTResTalkAction[35]
		},
		nil,
		nil,
		3
	},
	[25011003] = {
		25011003,
		0,
		Lang.get(63711),
		25011,
		3,
		739,
		{
			RTResTalkAction[35]
		}
	},
	[25011004] = {
		25011004,
		0,
		Lang.get(63712),
		25011,
		4,
		739,
		{
			RTResTalkAction[35]
		}
	},
	[25011005] = {
		25011005,
		0,
		Lang.get(63713),
		25011,
		5,
		739,
		{
			RTResTalkAction[35]
		}
	},
	[25011006] = {
		25011006,
		0,
		Lang.get(63714),
		25011,
		6,
		269,
		{
			RTResTalkAction[37]
		},
		1,
		3,
		nil,
		nil,
		nil,
		25026,
		nil,
		1,
		nil,
		1,
		nil,
		25026
	},
	[25011007] = {
		25011007,
		0,
		Lang.get(63715),
		25011,
		7,
		269,
		{
			RTResTalkAction[33]
		},
		nil,
		0,
		3
	},
	[25011008] = {
		25011008,
		0,
		Lang.get(63716),
		25011,
		8,
		729,
		{
			RTResTalkAction[71],
			RTResTalkAction[27]
		}
	},
	[25011009] = {
		25011009,
		0,
		Lang.get(63717),
		25011,
		9,
		728,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[25011010] = {
		25011010,
		0,
		Lang.get(63718),
		25011,
		10,
		729,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[25011011] = {
		25011011,
		0,
		Lang.get(63719),
		25011,
		11,
		269,
		{
			RTResTalkAction[28],
			RTResTalkAction[5],
			RTResTalkAction[6]
		}
	},
	[25012001] = {
		25012001,
		0,
		Lang.get(63720),
		25012,
		1,
		269,
		nil,
		1,
		3,
		nil,
		nil,
		31,
		25027,
		nil,
		1,
		nil,
		1,
		nil,
		25027
	},
	[25012002] = {
		25012002,
		0,
		Lang.get(63721),
		25012,
		2,
		269,
		{
			RTResTalkAction[33]
		},
		nil,
		0,
		3
	},
	[25012003] = {
		25012003,
		0,
		Lang.get(63722),
		25012,
		3,
		728,
		{
			RTResTalkAction[1],
			RTResTalkAction[27]
		}
	},
	[25012004] = {
		25012004,
		0,
		Lang.get(63723),
		25012,
		4,
		729,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[25012005] = {
		25012005,
		2,
		Lang.get(63724),
		25012,
		5,
		269,
		{
			RTResTalkAction[28],
			RTResTalkAction[5],
			RTResTalkAction[6]
		}
	},
	[25012006] = {
		25012006,
		2,
		Lang.get(63725),
		25012,
		6,
		269,
		{
			RTResTalkAction[32]
		}
	},
	[25012007] = {
		25012007,
		0,
		Lang.get(63726),
		25012,
		7,
		269,
		{
			RTResTalkAction[28]
		}
	},
	[25012008] = {
		25012008,
		0,
		Lang.get(63727),
		25012,
		8,
		269,
		{
			RTResTalkAction[28]
		}
	},
	[25013001] = {
		25013001,
		0,
		Lang.get(63728),
		25013,
		1,
		124,
		nil,
		1,
		nil,
		nil,
		nil,
		31,
		25028,
		nil,
		1,
		nil,
		1,
		nil,
		25028
	},
	[25013002] = {
		25013002,
		0,
		Lang.get(63729),
		25013,
		2,
		728,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[25013003] = {
		25013003,
		0,
		Lang.get(63730),
		25013,
		3,
		124,
		{
			RTResTalkAction[72],
			RTResTalkAction[5]
		}
	},
	[25013004] = {
		25013004,
		0,
		Lang.get(63731),
		25013,
		4,
		729,
		{
			RTResTalkAction[71],
			RTResTalkAction[73]
		}
	},
	[25013005] = {
		25013005,
		0,
		Lang.get(63732),
		25013,
		5,
		124,
		{
			RTResTalkAction[72],
			RTResTalkAction[6]
		}
	},
	[25013006] = {
		25013006,
		0,
		Lang.get(63733),
		25013,
		6,
		269,
		{
			RTResTalkAction[28],
			RTResTalkAction[73]
		}
	},
	[25013007] = {
		25013007,
		0,
		Lang.get(63734),
		25013,
		7,
		124,
		{
			RTResTalkAction[72],
			RTResTalkAction[27]
		}
	},
	[25013008] = {
		25013008,
		0,
		Lang.get(63735),
		25013,
		8,
		269,
		{
			RTResTalkAction[33],
			RTResTalkAction[73]
		}
	},
	[25013009] = {
		25013009,
		0,
		Lang.get(63736),
		25013,
		9,
		124,
		{
			RTResTalkAction[72],
			RTResTalkAction[27]
		}
	},
	[25013010] = {
		25013010,
		0,
		Lang.get(63737),
		25013,
		10,
		269,
		{
			RTResTalkAction[32],
			RTResTalkAction[73]
		}
	},
	[25013011] = {
		25013011,
		0,
		Lang.get(63738),
		25013,
		11,
		269,
		{
			RTResTalkAction[28]
		}
	},
	[25013012] = {
		25013012,
		0,
		Lang.get(63739),
		25013,
		12,
		124,
		{
			RTResTalkAction[72],
			RTResTalkAction[27]
		}
	},
	[25013013] = {
		25013013,
		0,
		Lang.get(63740),
		25013,
		13,
		269,
		{
			RTResTalkAction[28],
			RTResTalkAction[73]
		}
	},
	[25013014] = {
		25013014,
		0,
		Lang.get(63741),
		25013,
		14,
		124,
		{
			RTResTalkAction[72],
			RTResTalkAction[27]
		}
	},
	[25013015] = {
		25013015,
		0,
		Lang.get(63742),
		25013,
		15,
		269,
		{
			RTResTalkAction[28],
			RTResTalkAction[73]
		}
	},
	[25013016] = {
		25013016,
		0,
		Lang.get(63743),
		25013,
		16,
		269,
		{
			RTResTalkAction[28]
		}
	},
	[25013017] = {
		25013017,
		0,
		Lang.get(63744),
		25013,
		17,
		269,
		{
			RTResTalkAction[28]
		}
	},
	[25013018] = {
		25013018,
		0,
		Lang.get(63745),
		25013,
		18,
		124,
		{
			RTResTalkAction[72],
			RTResTalkAction[27]
		}
	},
	[25013019] = {
		25013019,
		0,
		Lang.get(63746),
		25013,
		19,
		269,
		{
			RTResTalkAction[28],
			RTResTalkAction[73]
		}
	},
	[25013020] = {
		25013020,
		0,
		Lang.get(63747),
		25013,
		20,
		124,
		{
			RTResTalkAction[72],
			RTResTalkAction[27]
		}
	},
	[25013021] = {
		25013021,
		0,
		Lang.get(63748),
		25013,
		21,
		269,
		{
			RTResTalkAction[28],
			RTResTalkAction[73]
		}
	},
	[25013022] = {
		25013022,
		0,
		Lang.get(63749),
		25013,
		22,
		124,
		{
			RTResTalkAction[72],
			RTResTalkAction[27]
		}
	},
	[25013023] = {
		25013023,
		0,
		Lang.get(63750),
		25013,
		23,
		739,
		{
			RTResTalkAction[73]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		25029,
		nil,
		1,
		nil,
		1,
		nil,
		25029
	},
	[25013024] = {
		25013024,
		0,
		Lang.get(63751),
		25013,
		24,
		739,
		{
			RTResTalkAction[35]
		},
		nil,
		nil,
		3
	},
	[25014001] = {
		25014001,
		0,
		Lang.get(63752),
		25014,
		1,
		739,
		nil,
		1,
		nil,
		nil,
		nil,
		28,
		25030,
		nil,
		1,
		nil,
		1,
		nil,
		25030
	},
	[25014002] = {
		25014002,
		0,
		Lang.get(63753),
		25014,
		2,
		739,
		{
			RTResTalkAction[35]
		},
		nil,
		nil,
		3
	},
	[25014003] = {
		25014003,
		0,
		Lang.get(63754),
		25014,
		3,
		739,
		{
			RTResTalkAction[35]
		}
	},
	[25014004] = {
		25014004,
		0,
		Lang.get(63755),
		25014,
		4,
		739,
		{
			RTResTalkAction[35]
		}
	},
	[25014005] = {
		25014005,
		0,
		Lang.get(63756),
		25014,
		5,
		739,
		{
			RTResTalkAction[35]
		}
	},
	[25014006] = {
		25014006,
		0,
		Lang.get(63757),
		25014,
		6,
		739,
		{
			RTResTalkAction[35]
		}
	},
	[25014007] = {
		25014007,
		0,
		Lang.get(63758),
		25014,
		7,
		739,
		{
			RTResTalkAction[35]
		}
	},
	[25014008] = {
		25014008,
		0,
		Lang.get(63759),
		25014,
		8,
		739,
		{
			RTResTalkAction[35]
		}
	},
	[25014009] = {
		25014009,
		0,
		Lang.get(63760),
		25014,
		9,
		739,
		{
			RTResTalkAction[35]
		}
	},
	[25014010] = {
		25014010,
		0,
		Lang.get(63761),
		25014,
		10,
		739,
		{
			RTResTalkAction[35]
		}
	},
	[25014011] = {
		25014011,
		0,
		Lang.get(63762),
		25014,
		11,
		739,
		{
			RTResTalkAction[35]
		}
	},
	[25014012] = {
		25014012,
		0,
		Lang.get(63763),
		25014,
		12,
		739,
		{
			RTResTalkAction[35]
		}
	},
	[25015001] = {
		25015001,
		0,
		Lang.get(63764),
		25015,
		1,
		728,
		nil,
		1,
		nil,
		nil,
		nil,
		31,
		25031,
		nil,
		1,
		nil,
		1,
		nil,
		25031
	},
	[25015002] = {
		25015002,
		0,
		Lang.get(63765),
		25015,
		2,
		729,
		{
			RTResTalkAction[71]
		},
		nil,
		nil,
		3
	},
	[25015003] = {
		25015003,
		0,
		Lang.get(63766),
		25015,
		3,
		269,
		{
			RTResTalkAction[28],
			RTResTalkAction[6]
		}
	},
	[25015004] = {
		25015004,
		0,
		Lang.get(63767),
		25015,
		4,
		729,
		{
			RTResTalkAction[71],
			RTResTalkAction[27]
		}
	},
	[25015005] = {
		25015005,
		0,
		Lang.get(63768),
		25015,
		5,
		269,
		{
			RTResTalkAction[30],
			RTResTalkAction[6]
		}
	},
	[25015006] = {
		25015006,
		0,
		Lang.get(63769),
		25015,
		6,
		729,
		{
			RTResTalkAction[71],
			RTResTalkAction[27]
		}
	},
	[25015007] = {
		25015007,
		0,
		Lang.get(63770),
		25015,
		7,
		269,
		{
			RTResTalkAction[33],
			RTResTalkAction[6]
		}
	},
	[25015008] = {
		25015008,
		0,
		Lang.get(63771),
		25015,
		8,
		269,
		{
			RTResTalkAction[28]
		}
	},
	[25015009] = {
		25015009,
		0,
		Lang.get(63772),
		25015,
		9,
		728,
		{
			RTResTalkAction[1],
			RTResTalkAction[27]
		}
	},
	[25015010] = {
		25015010,
		0,
		Lang.get(63773),
		25015,
		10,
		269,
		{
			RTResTalkAction[28],
			RTResTalkAction[5]
		}
	},
	[25015011] = {
		25015011,
		0,
		Lang.get(63774),
		25015,
		11,
		729,
		{
			RTResTalkAction[71],
			RTResTalkAction[27]
		}
	},
	[25015012] = {
		25015012,
		0,
		Lang.get(63775),
		25015,
		12,
		269,
		{
			RTResTalkAction[28],
			RTResTalkAction[6]
		}
	},
	[25015013] = {
		25015013,
		0,
		Lang.get(63776),
		25015,
		13,
		728,
		{
			RTResTalkAction[1],
			RTResTalkAction[27]
		}
	},
	[25015014] = {
		25015014,
		0,
		Lang.get(63777),
		25015,
		14,
		269,
		{
			RTResTalkAction[32],
			RTResTalkAction[5]
		}
	},
	[25015015] = {
		25015015,
		0,
		Lang.get(63778),
		25015,
		15,
		269,
		{
			RTResTalkAction[27]
		},
		1,
		1,
		nil,
		nil,
		nil,
		25032,
		nil,
		1,
		nil,
		1,
		nil,
		25032
	},
	[25015016] = {
		25015016,
		0,
		Lang.get(63779),
		25015,
		16,
		269,
		nil,
		1,
		1
	},
	[25015017] = {
		25015017,
		0,
		Lang.get(63780),
		25015,
		17,
		269,
		{
			RTResTalkAction[25]
		},
		nil,
		0,
		3
	},
	[25015018] = {
		25015018,
		0,
		Lang.get(63781),
		25015,
		18,
		269,
		{
			RTResTalkAction[28]
		}
	},
	[25015019] = {
		25015019,
		0,
		Lang.get(63782),
		25015,
		19,
		270,
		{
			RTResTalkAction[27]
		},
		1
	},
	[25015020] = {
		25015020,
		0,
		Lang.get(63783),
		25015,
		20,
		269,
		{
			RTResTalkAction[33]
		}
	},
	[25015021] = {
		25015021,
		0,
		Lang.get(63784),
		25015,
		21,
		270,
		{
			RTResTalkAction[27]
		},
		1,
		1
	},
	[25015022] = {
		25015022,
		0,
		Lang.get(63785),
		25015,
		22,
		269,
		{
			RTResTalkAction[25]
		},
		nil,
		0
	},
	[25015023] = {
		25015023,
		0,
		Lang.get(63786),
		25015,
		23,
		270,
		{
			RTResTalkAction[27]
		},
		1,
		1
	},
	[25015024] = {
		25015024,
		0,
		Lang.get(63787),
		25015,
		24,
		269,
		{
			RTResTalkAction[32]
		},
		nil,
		0
	},
	[25015025] = {
		25015025,
		0,
		Lang.get(63788),
		25015,
		25,
		269,
		{
			RTResTalkAction[28]
		}
	},
	[25016001] = {
		25016001,
		0,
		Lang.get(63789),
		25016,
		1,
		270,
		nil,
		1,
		nil,
		nil,
		nil,
		31,
		25033,
		nil,
		1,
		nil,
		1,
		nil,
		25033
	},
	[25016002] = {
		25016002,
		0,
		Lang.get(63790),
		25016,
		2,
		269,
		{
			RTResTalkAction[28]
		},
		nil,
		nil,
		3
	},
	[25016003] = {
		25016003,
		0,
		Lang.get(63791),
		25016,
		3,
		270,
		{
			RTResTalkAction[8],
			RTResTalkAction[27]
		}
	},
	[25016004] = {
		25016004,
		0,
		Lang.get(63792),
		25016,
		4,
		269,
		{
			RTResTalkAction[28],
			RTResTalkAction[9]
		}
	},
	[25016005] = {
		25016005,
		0,
		Lang.get(63793),
		25016,
		5,
		269,
		{
			RTResTalkAction[74]
		}
	},
	[25016006] = {
		25016006,
		0,
		Lang.get(63794),
		25016,
		6,
		728,
		{
			RTResTalkAction[27]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		25034,
		nil,
		1,
		nil,
		1,
		nil,
		25034
	},
	[25016007] = {
		25016007,
		0,
		Lang.get(63795),
		25016,
		7,
		729,
		{
			RTResTalkAction[71]
		},
		nil,
		nil,
		3
	},
	[25016008] = {
		25016008,
		0,
		Lang.get(63796),
		25016,
		8,
		746,
		{
			RTResTalkAction[75],
			RTResTalkAction[6]
		}
	},
	[25016009] = {
		25016009,
		0,
		Lang.get(63797),
		25016,
		9,
		270,
		{
			RTResTalkAction[76],
			RTResTalkAction[77]
		}
	},
	[25016010] = {
		25016010,
		0,
		Lang.get(63798),
		25016,
		10,
		269,
		{
			RTResTalkAction[33],
			RTResTalkAction[9]
		}
	},
	[25016011] = {
		25016011,
		0,
		Lang.get(63799),
		25016,
		11,
		270,
		{
			RTResTalkAction[8],
			RTResTalkAction[27]
		}
	},
	[25016012] = {
		25016012,
		0,
		Lang.get(63800),
		25016,
		12,
		269,
		{
			RTResTalkAction[32],
			RTResTalkAction[9]
		}
	},
	[25016013] = {
		25016013,
		0,
		Lang.get(63801),
		25016,
		13,
		269,
		{
			RTResTalkAction[28]
		}
	},
	[25016014] = {
		25016014,
		0,
		Lang.get(63802),
		25016,
		14,
		269,
		{
			RTResTalkAction[28]
		}
	},
	[25016015] = {
		25016015,
		0,
		Lang.get(63803),
		25016,
		15,
		747,
		{
			RTResTalkAction[78],
			RTResTalkAction[27]
		}
	},
	[25016016] = {
		25016016,
		0,
		Lang.get(63804),
		25016,
		16,
		747,
		{
			RTResTalkAction[79]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		25035,
		nil,
		1,
		nil,
		1,
		nil,
		25035
	},
	[25016017] = {
		25016017,
		0,
		Lang.get(63805),
		25016,
		17,
		269,
		{
			RTResTalkAction[28]
		},
		nil,
		nil,
		3
	},
	[25016018] = {
		25016018,
		0,
		Lang.get(63806),
		25016,
		18,
		747,
		{
			RTResTalkAction[78],
			RTResTalkAction[27]
		}
	},
	[25016019] = {
		25016019,
		0,
		Lang.get(63807),
		25016,
		19,
		747,
		{
			RTResTalkAction[78]
		}
	},
	[25016020] = {
		25016020,
		0,
		Lang.get(66389),
		25016,
		20,
		269,
		{
			RTResTalkAction[30],
			RTResTalkAction[79]
		}
	},
	[25016021] = {
		25016021,
		0,
		Lang.get(63809),
		25016,
		21,
		747,
		{
			RTResTalkAction[78],
			RTResTalkAction[27]
		}
	},
	[25016022] = {
		25016022,
		0,
		Lang.get(63810),
		25016,
		22,
		747,
		{
			RTResTalkAction[78]
		}
	},
	[25017001] = {
		25017001,
		0,
		Lang.get(63811),
		25017,
		1,
		269,
		nil,
		1,
		nil,
		nil,
		nil,
		170,
		25036,
		nil,
		1,
		nil,
		nil,
		nil,
		25036
	},
	[25017002] = {
		25017002,
		0,
		Lang.get(63812),
		25017,
		2,
		747,
		{
			RTResTalkAction[78]
		},
		nil,
		nil,
		3
	},
	[25017003] = {
		25017003,
		0,
		Lang.get(63813),
		25017,
		3,
		269,
		{
			RTResTalkAction[28],
			RTResTalkAction[79]
		}
	},
	[25017004] = {
		25017004,
		0,
		Lang.get(63814),
		25017,
		4,
		269,
		{
			RTResTalkAction[28]
		}
	},
	[25017005] = {
		25017005,
		0,
		Lang.get(63815),
		25017,
		5,
		269,
		{
			RTResTalkAction[28]
		}
	},
	[25017006] = {
		25017006,
		0,
		Lang.get(63816),
		25017,
		6,
		269,
		{
			RTResTalkAction[28]
		}
	},
	[25017007] = {
		25017007,
		0,
		Lang.get(63817),
		25017,
		7,
		269,
		{
			RTResTalkAction[28]
		}
	},
	[25017008] = {
		25017008,
		0,
		Lang.get(63818),
		25017,
		8,
		269,
		{
			RTResTalkAction[28]
		}
	},
	[25017009] = {
		25017009,
		0,
		Lang.get(63819),
		25017,
		9,
		269,
		{
			RTResTalkAction[30]
		}
	},
	[25017010] = {
		25017010,
		0,
		Lang.get(63820),
		25017,
		10,
		269,
		{
			RTResTalkAction[32]
		}
	},
	[25017011] = {
		25017011,
		0,
		Lang.get(63821),
		25017,
		11,
		214,
		{
			RTResTalkAction[80],
			RTResTalkAction[27]
		}
	},
	[25017012] = {
		25017012,
		0,
		Lang.get(63822),
		25017,
		12,
		269,
		{
			RTResTalkAction[25],
			RTResTalkAction[81]
		}
	},
	[25017013] = {
		25017013,
		0,
		Lang.get(63823),
		25017,
		13,
		214,
		{
			RTResTalkAction[82],
			RTResTalkAction[27]
		}
	},
	[25018001] = {
		25018001,
		0,
		Lang.get(63824),
		25018,
		1,
		214,
		nil,
		1,
		nil,
		nil,
		nil,
		28,
		25037,
		nil,
		1,
		nil,
		1,
		nil,
		25037
	},
	[25018002] = {
		25018002,
		0,
		Lang.get(63825),
		25018,
		2,
		746,
		{
			RTResTalkAction[75]
		},
		nil,
		nil,
		3
	},
	[25018003] = {
		25018003,
		0,
		Lang.get(63826),
		25018,
		3,
		269,
		{
			RTResTalkAction[25],
			RTResTalkAction[77]
		}
	},
	[25018004] = {
		25018004,
		0,
		Lang.get(63827),
		25018,
		4,
		214,
		{
			RTResTalkAction[80],
			RTResTalkAction[27]
		}
	},
	[25018005] = {
		25018005,
		0,
		Lang.get(63828),
		25018,
		5,
		269,
		{
			RTResTalkAction[32],
			RTResTalkAction[81]
		}
	},
	[25018006] = {
		25018006,
		0,
		Lang.get(63829),
		25018,
		6,
		269,
		{
			RTResTalkAction[28]
		}
	},
	[25018007] = {
		25018007,
		0,
		Lang.get(63830),
		25018,
		7,
		269,
		{
			RTResTalkAction[28]
		}
	},
	[25018008] = {
		25018008,
		0,
		Lang.get(63831),
		25018,
		8,
		214,
		{
			RTResTalkAction[80],
			RTResTalkAction[27]
		}
	},
	[25018009] = {
		25018009,
		0,
		Lang.get(66390),
		25018,
		9,
		214,
		{
			RTResTalkAction[80]
		}
	},
	[25018010] = {
		25018010,
		0,
		Lang.get(63833),
		25018,
		10,
		746,
		{
			RTResTalkAction[83],
			RTResTalkAction[81]
		}
	},
	[25018011] = {
		25018011,
		5,
		Lang.get(63834),
		25018,
		11,
		748,
		{
			RTResTalkAction[84],
			RTResTalkAction[85]
		}
	},
	[25018012] = {
		25018012,
		0,
		Lang.get(63835),
		25018,
		12,
		269,
		{
			RTResTalkAction[30],
			RTResTalkAction[77],
			RTResTalkAction[86]
		}
	},
	[25018013] = {
		25018013,
		0,
		Lang.get(63836),
		25018,
		13,
		270,
		{
			RTResTalkAction[76],
			RTResTalkAction[27]
		}
	},
	[25018014] = {
		25018014,
		0,
		Lang.get(63837),
		25018,
		14,
		270,
		{
			RTResTalkAction[8]
		}
	},
	[25019001] = {
		25019001,
		0,
		Lang.get(63838),
		25019,
		1,
		107,
		nil,
		1,
		10,
		nil,
		nil,
		31,
		25038,
		nil,
		1,
		nil,
		1,
		nil,
		25038
	},
	[25019002] = {
		25019002,
		0,
		Lang.get(63839),
		25019,
		2,
		141,
		{
			RTResTalkAction[60]
		},
		nil,
		0,
		3
	},
	[25019003] = {
		25019003,
		0,
		Lang.get(63840),
		25019,
		3,
		133,
		{
			RTResTalkAction[49],
			RTResTalkAction[43]
		}
	},
	[25019004] = {
		25019004,
		5,
		Lang.get(63841),
		25019,
		4,
		167,
		{
			RTResTalkAction[23],
			RTResTalkAction[51]
		}
	},
	[25019005] = {
		25019005,
		0,
		Lang.get(63842),
		25019,
		5,
		107,
		{
			RTResTalkAction[68],
			RTResTalkAction[26]
		}
	},
	[25019006] = {
		25019006,
		0,
		Lang.get(63843),
		25019,
		6,
		149,
		{
			RTResTalkAction[22],
			RTResTalkAction[42]
		}
	},
	[25019007] = {
		25019007,
		0,
		Lang.get(63844),
		25019,
		7,
		149,
		{
			RTResTalkAction[22]
		}
	},
	[25019008] = {
		25019008,
		0,
		Lang.get(63845),
		25019,
		8,
		107,
		{
			RTResTalkAction[87],
			RTResTalkAction[24]
		}
	},
	[25019009] = {
		25019009,
		0,
		Lang.get(63846),
		25019,
		9,
		107,
		{
			RTResTalkAction[42]
		},
		1,
		11,
		nil,
		nil,
		nil,
		25039,
		nil,
		1,
		nil,
		1,
		nil,
		25039
	},
	[25019010] = {
		25019010,
		0,
		Lang.get(63847),
		25019,
		10,
		133,
		{
			RTResTalkAction[49]
		},
		nil,
		0,
		3
	},
	[25019011] = {
		25019011,
		0,
		Lang.get(63848),
		25019,
		11,
		141,
		{
			RTResTalkAction[60],
			RTResTalkAction[51]
		}
	},
	[25019012] = {
		25019012,
		0,
		Lang.get(63849),
		25019,
		12,
		107,
		{
			RTResTalkAction[52],
			RTResTalkAction[43]
		}
	},
	[25019013] = {
		25019013,
		0,
		Lang.get(63850),
		25019,
		13,
		149,
		{
			RTResTalkAction[22],
			RTResTalkAction[42]
		}
	},
	[25019014] = {
		25019014,
		0,
		Lang.get(63851),
		25019,
		14,
		141,
		{
			RTResTalkAction[54],
			RTResTalkAction[24]
		}
	},
	[25019015] = {
		25019015,
		5,
		Lang.get(63852),
		25019,
		15,
		749,
		{
			RTResTalkAction[88],
			RTResTalkAction[43]
		},
		[18] = 1070
	},
	[25019016] = {
		25019016,
		0,
		Lang.get(63853),
		25019,
		16,
		149,
		{
			RTResTalkAction[22],
			RTResTalkAction[89]
		}
	},
	[25019017] = {
		25019017,
		5,
		Lang.get(63854),
		25019,
		17,
		107,
		{
			RTResTalkAction[48],
			RTResTalkAction[24]
		}
	},
	[25019018] = {
		25019018,
		0,
		Lang.get(63855),
		25019,
		18,
		107,
		{
			RTResTalkAction[42]
		},
		1,
		8,
		nil,
		nil,
		nil,
		25040,
		nil,
		1,
		nil,
		1,
		nil,
		25040
	},
	[25019019] = {
		25019019,
		0,
		Lang.get(63856),
		25019,
		19,
		141,
		{
			RTResTalkAction[60]
		},
		nil,
		0,
		3
	},
	[25019020] = {
		25019020,
		0,
		Lang.get(63857),
		25019,
		20,
		133,
		{
			RTResTalkAction[49],
			RTResTalkAction[43]
		}
	},
	[25019021] = {
		25019021,
		0,
		Lang.get(63858),
		25019,
		21,
		149,
		{
			RTResTalkAction[22],
			RTResTalkAction[51]
		}
	},
	[25019022] = {
		25019022,
		0,
		Lang.get(63859),
		25019,
		22,
		149,
		{
			RTResTalkAction[22]
		}
	},
	[25019023] = {
		25019023,
		0,
		Lang.get(63860),
		25019,
		23,
		141,
		{
			RTResTalkAction[54],
			RTResTalkAction[24]
		}
	},
	[25020001] = {
		25020001,
		0,
		Lang.get(63861),
		25020,
		1,
		107,
		nil,
		1,
		4,
		nil,
		nil,
		31,
		25041,
		nil,
		nil,
		nil,
		nil,
		nil,
		25041
	},
	[25020002] = {
		25020002,
		0,
		Lang.get(63862),
		25020,
		2,
		749,
		{
			RTResTalkAction[90]
		},
		nil,
		0,
		3,
		[18] = 1070
	},
	[25020003] = {
		25020003,
		0,
		Lang.get(63863),
		25020,
		3,
		141,
		{
			RTResTalkAction[60],
			RTResTalkAction[89]
		}
	},
	[25020004] = {
		25020004,
		0,
		Lang.get(63864),
		25020,
		4,
		133,
		{
			RTResTalkAction[49],
			RTResTalkAction[43]
		}
	},
	[25020005] = {
		25020005,
		0,
		Lang.get(63865),
		25020,
		5,
		149,
		{
			RTResTalkAction[22],
			RTResTalkAction[51]
		}
	},
	[25020006] = {
		25020006,
		0,
		Lang.get(63866),
		25020,
		6,
		149,
		{
			RTResTalkAction[22]
		}
	},
	[25020007] = {
		25020007,
		5,
		Lang.get(63867),
		25020,
		7,
		749,
		{
			RTResTalkAction[91],
			RTResTalkAction[24]
		},
		[18] = 1070
	},
	[25020008] = {
		25020008,
		0,
		Lang.get(63868),
		25020,
		8,
		107,
		{
			RTResTalkAction[52],
			RTResTalkAction[89]
		}
	},
	[25020009] = {
		25020009,
		0,
		Lang.get(63869),
		25020,
		9,
		149,
		{
			RTResTalkAction[22],
			RTResTalkAction[42]
		}
	},
	[25020010] = {
		25020010,
		0,
		Lang.get(63870),
		25020,
		10,
		141,
		{
			RTResTalkAction[92],
			RTResTalkAction[24]
		}
	},
	[25020011] = {
		25020011,
		0,
		Lang.get(63871),
		25020,
		11,
		167,
		{
			RTResTalkAction[23],
			RTResTalkAction[43]
		}
	},
	[25020012] = {
		25020012,
		0,
		Lang.get(63872),
		25020,
		12,
		107,
		{
			RTResTalkAction[44],
			RTResTalkAction[26]
		}
	},
	[25021001] = {
		25021001,
		0,
		Lang.get(63873),
		25021,
		1,
		269,
		nil,
		1,
		2,
		nil,
		nil,
		28,
		25042,
		nil,
		1,
		nil,
		1,
		nil,
		25042
	},
	[25021002] = {
		25021002,
		0,
		Lang.get(63874),
		25021,
		2,
		270,
		{
			RTResTalkAction[76]
		},
		nil,
		0,
		3
	},
	[25021003] = {
		25021003,
		0,
		Lang.get(63875),
		25021,
		3,
		269,
		{
			RTResTalkAction[32],
			RTResTalkAction[9]
		}
	},
	[25021004] = {
		25021004,
		0,
		Lang.get(63876),
		25021,
		4,
		270,
		{
			RTResTalkAction[76],
			RTResTalkAction[27]
		}
	},
	[25021005] = {
		25021005,
		0,
		Lang.get(63877),
		25021,
		5,
		214,
		{
			RTResTalkAction[80],
			RTResTalkAction[9]
		}
	},
	[25021006] = {
		25021006,
		0,
		Lang.get(63878),
		25021,
		6,
		746,
		{
			RTResTalkAction[75],
			RTResTalkAction[81]
		}
	},
	[25021007] = {
		25021007,
		5,
		Lang.get(63879),
		25021,
		7,
		748,
		{
			RTResTalkAction[93],
			RTResTalkAction[77]
		}
	},
	[25021008] = {
		25021008,
		0,
		Lang.get(63880),
		25021,
		8,
		149,
		{
			RTResTalkAction[86]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		25043,
		nil,
		1,
		nil,
		1,
		nil,
		25043
	},
	[25021009] = {
		25021009,
		0,
		Lang.get(63881),
		25021,
		9,
		214,
		{
			RTResTalkAction[80]
		},
		nil,
		nil,
		3
	},
	[25021010] = {
		25021010,
		0,
		Lang.get(63882),
		25021,
		10,
		149,
		{
			RTResTalkAction[22],
			RTResTalkAction[81]
		}
	},
	[25021011] = {
		25021011,
		0,
		Lang.get(63883),
		25021,
		11,
		214,
		{
			RTResTalkAction[80],
			RTResTalkAction[24]
		}
	},
	[25021012] = {
		25021012,
		0,
		Lang.get(63884),
		25021,
		12,
		214,
		{
			RTResTalkAction[82]
		}
	},
	[25021013] = {
		25021013,
		5,
		Lang.get(63885),
		25021,
		13,
		746,
		{
			RTResTalkAction[94],
			RTResTalkAction[81]
		}
	},
	[25022001] = {
		25022001,
		0,
		Lang.get(63886),
		25022,
		1,
		149,
		nil,
		1,
		nil,
		nil,
		nil,
		170,
		25044,
		nil,
		1,
		nil,
		1,
		nil,
		25044
	},
	[25022002] = {
		25022002,
		0,
		Lang.get(63887),
		25022,
		2,
		214,
		{
			RTResTalkAction[80]
		},
		nil,
		nil,
		3
	},
	[25022003] = {
		25022003,
		0,
		Lang.get(63888),
		25022,
		3,
		149,
		{
			RTResTalkAction[22],
			RTResTalkAction[81]
		}
	},
	[25022004] = {
		25022004,
		0,
		Lang.get(63889),
		25022,
		4,
		149,
		{
			RTResTalkAction[22]
		}
	},
	[25022005] = {
		25022005,
		0,
		Lang.get(66391),
		25022,
		5,
		149,
		{
			RTResTalkAction[22]
		}
	},
	[25022006] = {
		25022006,
		0,
		Lang.get(63891),
		25022,
		6,
		149,
		{
			RTResTalkAction[22]
		}
	},
	[25022007] = {
		25022007,
		0,
		Lang.get(63892),
		25022,
		7,
		149,
		{
			RTResTalkAction[22]
		}
	},
	[25022008] = {
		25022008,
		0,
		Lang.get(63893),
		25022,
		8,
		149,
		{
			RTResTalkAction[22]
		}
	},
	[25022009] = {
		25022009,
		0,
		Lang.get(63894),
		25022,
		9,
		214,
		{
			RTResTalkAction[80],
			RTResTalkAction[24]
		}
	},
	[25022010] = {
		25022010,
		0,
		Lang.get(63895),
		25022,
		10,
		149,
		{
			RTResTalkAction[22],
			RTResTalkAction[81]
		}
	},
	[25022011] = {
		25022011,
		0,
		Lang.get(63896),
		25022,
		11,
		214,
		{
			RTResTalkAction[80],
			RTResTalkAction[24]
		}
	},
	[25022012] = {
		25022012,
		0,
		Lang.get(63897),
		25022,
		12,
		149,
		{
			RTResTalkAction[22],
			RTResTalkAction[81]
		}
	},
	[25022013] = {
		25022013,
		0,
		Lang.get(63898),
		25022,
		13,
		149,
		{
			RTResTalkAction[22]
		}
	},
	[25022014] = {
		25022014,
		0,
		Lang.get(63899),
		25022,
		14,
		149,
		{
			RTResTalkAction[22]
		}
	},
	[25022015] = {
		25022015,
		0,
		Lang.get(63900),
		25022,
		15,
		149,
		{
			RTResTalkAction[34]
		}
	},
	[25022016] = {
		25022016,
		0,
		Lang.get(63901),
		25022,
		16,
		214,
		{
			RTResTalkAction[82],
			RTResTalkAction[24]
		}
	},
	[25023001] = {
		25023001,
		0,
		Lang.get(63902),
		25023,
		1,
		738,
		nil,
		1,
		nil,
		nil,
		nil,
		170,
		25045,
		nil,
		1,
		nil,
		1,
		nil,
		25045
	},
	[25023002] = {
		25023002,
		0,
		Lang.get(63903),
		25023,
		2,
		738,
		{
			RTResTalkAction[36]
		},
		nil,
		nil,
		3
	},
	[25023003] = {
		25023003,
		0,
		Lang.get(63904),
		25023,
		3,
		736,
		{
			RTResTalkAction[38]
		},
		1
	},
	[25023004] = {
		25023004,
		0,
		Lang.get(63905),
		25023,
		4,
		738,
		{
			RTResTalkAction[36]
		}
	},
	[25023005] = {
		25023005,
		0,
		Lang.get(63906),
		25023,
		5,
		737,
		{
			RTResTalkAction[38]
		},
		1
	},
	[25023006] = {
		25023006,
		0,
		Lang.get(63907),
		25023,
		6,
		738,
		{
			RTResTalkAction[36]
		}
	},
	[25023007] = {
		25023007,
		0,
		Lang.get(63908),
		25023,
		7,
		738,
		{
			RTResTalkAction[36]
		}
	},
	[25023008] = {
		25023008,
		0,
		Lang.get(63909),
		25023,
		8,
		269,
		{
			RTResTalkAction[25],
			RTResTalkAction[38]
		}
	},
	[25023009] = {
		25023009,
		0,
		Lang.get(63910),
		25023,
		9,
		738,
		{
			RTResTalkAction[36],
			RTResTalkAction[27]
		}
	},
	[25023010] = {
		25023010,
		0,
		Lang.get(63911),
		25023,
		10,
		269,
		{
			RTResTalkAction[32],
			RTResTalkAction[38]
		}
	},
	[25023011] = {
		25023011,
		0,
		Lang.get(63912),
		25023,
		11,
		738,
		{
			RTResTalkAction[36],
			RTResTalkAction[27]
		}
	},
	[25023012] = {
		25023012,
		0,
		Lang.get(63913),
		25023,
		12,
		107,
		{
			RTResTalkAction[38]
		},
		1,
		5,
		nil,
		nil,
		30,
		25046,
		nil,
		1,
		nil,
		1,
		nil,
		25046
	},
	[25023013] = {
		25023013,
		0,
		Lang.get(63914),
		25023,
		13,
		133,
		{
			RTResTalkAction[95]
		},
		nil,
		0,
		3
	},
	[25023014] = {
		25023014,
		0,
		Lang.get(63915),
		25023,
		14,
		107,
		{
			RTResTalkAction[67],
			RTResTalkAction[51]
		}
	},
	[25023015] = {
		25023015,
		0,
		Lang.get(63916),
		25023,
		15,
		141,
		{
			RTResTalkAction[96],
			RTResTalkAction[42]
		}
	},
	[25023016] = {
		25023016,
		0,
		Lang.get(63917),
		25023,
		16,
		107,
		{
			RTResTalkAction[43]
		},
		1,
		5,
		nil,
		nil,
		30,
		25047,
		nil,
		1,
		nil,
		1,
		nil,
		25047
	},
	[25023017] = {
		25023017,
		0,
		Lang.get(63918),
		25023,
		17,
		300,
		nil,
		nil,
		0
	},
	[25023018] = {
		25023018,
		0,
		Lang.get(63919),
		25023,
		18,
		730,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3
	},
	[25023019] = {
		25023019,
		0,
		Lang.get(23141),
		25023,
		19,
		300,
		{
			RTResTalkAction[97],
			RTResTalkAction[13]
		}
	},
	[25023020] = {
		25023020,
		0,
		Lang.get(63920),
		25023,
		20,
		730,
		{
			RTResTalkAction[11],
			RTResTalkAction[98]
		}
	},
	[25023021] = {
		25023021,
		0,
		Lang.get(63921),
		25023,
		21,
		300,
		{
			RTResTalkAction[13]
		}
	},
	[25023022] = {
		25023022,
		0,
		Lang.get(63922),
		25023,
		22,
		282,
		{
			RTResTalkAction[18]
		}
	},
	[25023023] = {
		25023023,
		0,
		Lang.get(63923),
		25023,
		23,
		283,
		{
			RTResTalkAction[20],
			RTResTalkAction[19]
		}
	},
	[25023024] = {
		25023024,
		0,
		Lang.get(63924),
		25023,
		24,
		284,
		{
			RTResTalkAction[99],
			RTResTalkAction[21]
		}
	},
	[25023025] = {
		25023025,
		0,
		Lang.get(63925),
		25023,
		25,
		285,
		{
			RTResTalkAction[100],
			RTResTalkAction[101]
		}
	},
	[25023026] = {
		25023026,
		0,
		Lang.get(63926),
		25023,
		26,
		107,
		{
			RTResTalkAction[102],
			RTResTalkAction[103]
		}
	},
	[25023027] = {
		25023027,
		0,
		Lang.get(63927),
		25023,
		27,
		269,
		{
			RTResTalkAction[42]
		},
		1,
		nil,
		nil,
		nil,
		30,
		25048,
		nil,
		1,
		nil,
		1,
		nil,
		25048
	},
	[25023028] = {
		25023028,
		0,
		Lang.get(63928),
		25023,
		28,
		300
	},
	[25023029] = {
		25023029,
		0,
		Lang.get(63929),
		25023,
		29,
		269,
		{
			RTResTalkAction[28]
		},
		nil,
		nil,
		3
	},
	[25023030] = {
		25023030,
		0,
		Lang.get(63930),
		25023,
		30,
		300,
		{
			RTResTalkAction[27]
		}
	},
	[25023031] = {
		25023031,
		0,
		Lang.get(63931),
		25023,
		31,
		269,
		{
			RTResTalkAction[28]
		}
	},
	[25023032] = {
		25023032,
		0,
		Lang.get(63932),
		25023,
		32,
		269,
		{
			RTResTalkAction[27]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[19] = 25049
	},
	[25023033] = {
		25023033,
		0,
		Lang.get(63933),
		25023,
		33,
		269,
		nil,
		1
	},
	[25023034] = {
		25023034,
		0,
		Lang.get(63934),
		25023,
		34,
		269,
		nil,
		1
	},
	[25023035] = {
		25023035,
		0,
		Lang.get(63935),
		25023,
		35,
		269,
		nil,
		1
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
