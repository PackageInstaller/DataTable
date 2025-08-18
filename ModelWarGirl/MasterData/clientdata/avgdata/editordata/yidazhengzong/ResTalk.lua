-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\yidazhengzong\\ResTalk.lua

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
	[2] = 702
}
RTResTalkAction[2] = {
	[1] = 2,
	[2] = 702
}
RTResTalkAction[3] = {
	[1] = 3,
	[2] = 703
}
RTResTalkAction[4] = {
	[1] = 3,
	[2] = 703,
	[3] = {
		1
	}
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 702
}
RTResTalkAction[6] = {
	[1] = 0,
	[2] = 703
}
RTResTalkAction[7] = {
	[1] = 1,
	[2] = 301
}
RTResTalkAction[8] = {
	[1] = 2,
	[2] = 301
}
RTResTalkAction[9] = {
	[1] = 3,
	[2] = 702
}
RTResTalkAction[10] = {
	[1] = 0,
	[2] = 301
}
RTResTalkAction[11] = {
	1,
	301,
	nil,
	nil,
	1
}
RTResTalkAction[12] = {
	[1] = 2,
	[2] = 708
}
RTResTalkAction[13] = {
	[1] = 3,
	[2] = 710
}
RTResTalkAction[14] = {
	[1] = 0,
	[2] = 708
}
RTResTalkAction[15] = {
	[1] = 0,
	[2] = 710
}
RTResTalkAction[16] = {
	[1] = 2,
	[2] = 706
}
RTResTalkAction[17] = {
	[1] = 3,
	[2] = 707
}
RTResTalkAction[18] = {
	[1] = 0,
	[2] = 706
}
RTResTalkAction[19] = {
	[1] = 0,
	[2] = 707
}
RTResTalkAction[20] = {
	[1] = 1,
	[2] = 709
}
RTResTalkAction[21] = {
	[1] = 2,
	[2] = 709
}
RTResTalkAction[22] = {
	[1] = 3,
	[2] = 708
}
RTResTalkAction[23] = {
	[1] = 0,
	[2] = 709
}
RTResTalkAction[24] = {
	1,
	301,
	nil,
	nil,
	0
}
RTResTalkAction[25] = {
	[1] = 1,
	[2] = 710
}
RTResTalkAction[26] = {
	[1] = 2,
	[2] = 710
}
RTResTalkAction[27] = {
	[1] = 1,
	[2] = 703
}
RTResTalkAction[28] = {
	3,
	127,
	nil,
	nil,
	1
}
RTResTalkAction[29] = {
	[1] = 0,
	[2] = 127
}
RTResTalkAction[30] = {
	[1] = 3,
	[2] = 127
}
RTResTalkAction[31] = {
	[1] = 3,
	[2] = 709
}
RTResTalkAction[32] = {
	[1] = 1,
	[2] = 112
}
RTResTalkAction[33] = {
	[1] = 0,
	[2] = 112
}
RTResTalkAction[34] = {
	[1] = 1,
	[2] = 708
}
RTResTalkAction[35] = {
	2,
	301,
	nil,
	nil,
	0
}
RTResTalkAction[36] = {
	[1] = 2,
	[2] = 703
}
RTResTalkAction[37] = {
	[1] = 3,
	[2] = 576
}
RTResTalkAction[38] = {
	[1] = 0,
	[2] = 576
}
RTResTalkAction[39] = {
	3,
	127,
	nil,
	nil,
	0
}
RTResTalkAction[40] = {
	[1] = 1,
	[2] = 127
}
RTResTalkAction[41] = {
	1,
	705,
	nil,
	nil,
	1
}
RTResTalkAction[42] = {
	[1] = 2,
	[2] = 705
}
RTResTalkAction[43] = {
	[1] = 3,
	[2] = 229
}
RTResTalkAction[44] = {
	1,
	705,
	nil,
	nil,
	0
}
RTResTalkAction[45] = {
	[1] = 0,
	[2] = 229
}
RTResTalkAction[46] = {
	[1] = 1,
	[2] = 705
}
RTResTalkAction[47] = {
	3,
	119,
	nil,
	nil,
	7
}
RTResTalkAction[48] = {
	[1] = 3,
	[2] = 119
}
RTResTalkAction[49] = {
	3,
	119,
	nil,
	nil,
	3
}
RTResTalkAction[50] = {
	3,
	119,
	nil,
	nil,
	4
}
RTResTalkAction[51] = {
	3,
	119,
	nil,
	nil,
	5
}
RTResTalkAction[52] = {
	3,
	119,
	nil,
	nil,
	10
}
RTResTalkAction[53] = {
	2,
	705,
	nil,
	nil,
	2
}
RTResTalkAction[54] = {
	3,
	119,
	nil,
	nil,
	2
}
RTResTalkAction[55] = {
	1,
	705,
	nil,
	nil,
	2
}
RTResTalkAction[56] = {
	3,
	119,
	nil,
	nil,
	0
}
RTResTalkAction[57] = {
	3,
	119,
	nil,
	nil,
	9
}
RTResTalkAction[58] = {
	3,
	119,
	nil,
	nil,
	6
}
RTResTalkAction[59] = {
	3,
	119,
	nil,
	nil,
	1
}
RTResTalkAction[60] = {
	2,
	705,
	nil,
	nil,
	1
}
RTResTalkAction[61] = {
	2,
	705,
	nil,
	nil,
	0
}
RTResTalkAction[62] = {
	[1] = 0,
	[2] = 119
}
RTResTalkAction[63] = {
	[1] = 0,
	[2] = 705
}
RTResTalkAction[64] = {
	[1] = 3,
	[2] = 713
}
RTResTalkAction[65] = {
	[1] = 0,
	[2] = 713
}
RTResTalkAction[66] = {
	[1] = 3,
	[2] = 714
}
RTResTalkAction[67] = {
	[1] = 0,
	[2] = 714
}
RTResTalkAction[68] = {
	[1] = 3,
	[2] = 715
}
RTResTalkAction[69] = {
	[1] = 0,
	[2] = 715
}
RTResTalkAction[70] = {
	[1] = 1,
	[2] = 119
}
RTResTalkAction[71] = {
	[1] = 2,
	[2] = 119
}
RTResTalkAction[72] = {
	[1] = 1,
	[2] = 714
}
RTResTalkAction[73] = {
	[1] = 2,
	[2] = 714
}
RTResTalkAction[74] = {
	[1] = 1,
	[2] = 713
}
RTResTalkAction[75] = {
	[1] = 1,
	[2] = 715
}
RTResTalkAction[76] = {
	[1] = 2,
	[2] = 713
}
RTResTalkAction[77] = {
	[1] = 1,
	[2] = 706
}
RTResTalkAction[78] = {
	[1] = 3,
	[2] = 706
}
RTResTalkAction[79] = {
	[1] = 1,
	[2] = 707
}
RTResTalkAction[80] = {
	1,
	127,
	nil,
	nil,
	1
}
RTResTalkAction[81] = {
	1,
	127,
	nil,
	nil,
	0
}
RTResTalkAction[82] = {
	[1] = 2,
	[2] = 112
}
RTResTalkAction[83] = {
	[1] = 2,
	[2] = 127
}
RTResTalkAction[84] = {
	[1] = 3,
	[2] = 302
}
RTResTalkAction[85] = {
	[1] = 1,
	[2] = 302
}
RTResTalkAction[86] = {
	[1] = 1,
	[2] = 141
}
RTResTalkAction[87] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[88] = {
	[1] = 3,
	[2] = 141
}
RTResTalkAction[89] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[90] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[91] = {
	[1] = 0,
	[2] = 302
}

local Data = {
	[21400001] = {
		21400001,
		9,
		Lang.get(55464),
		21400,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		150,
		[22] = 1,
		[20] = 255
	},
	[21400002] = {
		21400002,
		0,
		Lang.get(46910),
		21400,
		2,
		702,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		21400,
		0.5,
		nil,
		nil,
		nil,
		nil,
		21400,
		-1
	},
	[21400003] = {
		21400003,
		0,
		Lang.get(46911),
		21400,
		3,
		703,
		nil,
		1
	},
	[21400004] = {
		21400004,
		0,
		Lang.get(46912),
		21400,
		4,
		702,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[21400005] = {
		21400005,
		0,
		Lang.get(46913),
		21400,
		5,
		703,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[21400006] = {
		21400006,
		0,
		Lang.get(46914),
		21400,
		6,
		703,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[21400007] = {
		21400007,
		0,
		Lang.get(46915),
		21400,
		7,
		702,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[21400008] = {
		21400008,
		0,
		Lang.get(46916),
		21400,
		8,
		703,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[21400009] = {
		21400009,
		0,
		Lang.get(46917),
		21400,
		9,
		703,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[21400010] = {
		21400010,
		0,
		Lang.get(46918),
		21400,
		10,
		703,
		{
			RTResTalkAction[2],
			RTResTalkAction[4]
		}
	},
	[21400011] = {
		21400011,
		0,
		Lang.get(46919),
		21400,
		11,
		301,
		{
			RTResTalkAction[5],
			RTResTalkAction[6]
		},
		1,
		nil,
		nil,
		nil,
		60,
		21401,
		nil,
		1,
		nil,
		1,
		nil,
		21401
	},
	[21400012] = {
		21400012,
		7,
		"63",
		21400,
		12,
		301,
		nil,
		nil,
		nil,
		5,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[21400013] = {
		21400013,
		0,
		Lang.get(46920),
		21400,
		13,
		703,
		nil,
		1,
		nil,
		-1
	},
	[21400014] = {
		21400014,
		0,
		Lang.get(46921),
		21400,
		14,
		301,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3
	},
	[21400015] = {
		21400015,
		0,
		Lang.get(46922),
		21400,
		15,
		702,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[21400016] = {
		21400016,
		0,
		Lang.get(46923),
		21400,
		16,
		703,
		{
			RTResTalkAction[2],
			RTResTalkAction[3],
			RTResTalkAction[10]
		}
	},
	[21400017] = {
		21400017,
		0,
		Lang.get(46924),
		21400,
		17,
		301,
		{
			RTResTalkAction[7],
			RTResTalkAction[5],
			RTResTalkAction[6]
		}
	},
	[21400018] = {
		21400018,
		0,
		Lang.get(46925),
		21400,
		18,
		301,
		{
			RTResTalkAction[7]
		}
	},
	[21400019] = {
		21400019,
		0,
		Lang.get(46926),
		21400,
		19,
		702,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[21400020] = {
		21400020,
		0,
		Lang.get(46927),
		21400,
		20,
		301,
		{
			RTResTalkAction[7],
			RTResTalkAction[5]
		}
	},
	[21400021] = {
		21400021,
		0,
		Lang.get(46928),
		21400,
		21,
		710,
		{
			RTResTalkAction[10]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		21402,
		nil,
		1,
		nil,
		1,
		nil,
		21402
	},
	[21400022] = {
		21400022,
		0,
		Lang.get(46929),
		21400,
		22,
		709,
		nil,
		1
	},
	[21400023] = {
		21400023,
		0,
		Lang.get(46930),
		21400,
		23,
		708,
		nil,
		1
	},
	[21400024] = {
		21400024,
		0,
		Lang.get(46931),
		21400,
		24,
		710,
		nil,
		1
	},
	[21400025] = {
		21400025,
		0,
		Lang.get(46932),
		21400,
		25,
		708,
		nil,
		1
	},
	[21400026] = {
		21400026,
		0,
		Lang.get(46933),
		21400,
		26,
		709,
		nil,
		1
	},
	[21400027] = {
		21400027,
		0,
		Lang.get(46934),
		21400,
		27,
		702,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[21400028] = {
		21400028,
		0,
		Lang.get(46935),
		21400,
		28,
		703,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[21400029] = {
		21400029,
		0,
		Lang.get(46936),
		21400,
		29,
		301,
		{
			RTResTalkAction[11],
			RTResTalkAction[5],
			RTResTalkAction[6]
		}
	},
	[21400030] = {
		21400030,
		0,
		Lang.get(46937),
		21400,
		30,
		301,
		{
			RTResTalkAction[7]
		}
	},
	[21401001] = {
		21401001,
		0,
		Lang.get(46938),
		21401,
		1,
		709,
		nil,
		1,
		nil,
		nil,
		nil,
		57,
		21403,
		nil,
		nil,
		nil,
		1,
		nil,
		21403
	},
	[21401002] = {
		21401002,
		0,
		Lang.get(46939),
		21401,
		2,
		301,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3
	},
	[21401003] = {
		21401003,
		0,
		Lang.get(46940),
		21401,
		3,
		708,
		{
			RTResTalkAction[12],
			RTResTalkAction[13],
			RTResTalkAction[10]
		}
	},
	[21401004] = {
		21401004,
		0,
		Lang.get(46941),
		21401,
		4,
		710,
		{
			RTResTalkAction[12],
			RTResTalkAction[13]
		}
	},
	[21401005] = {
		21401005,
		0,
		Lang.get(46942),
		21401,
		5,
		706,
		{
			RTResTalkAction[14],
			RTResTalkAction[15]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		21404,
		[19] = 21404
	},
	[21401006] = {
		21401006,
		0,
		Lang.get(46943),
		21401,
		6,
		707,
		nil,
		1
	},
	[21401007] = {
		21401007,
		0,
		Lang.get(46944),
		21401,
		7,
		706,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[21401008] = {
		21401008,
		0,
		Lang.get(46945),
		21401,
		8,
		707,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[21401009] = {
		21401009,
		0,
		Lang.get(46946),
		21401,
		9,
		301,
		{
			RTResTalkAction[7],
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[21401010] = {
		21401010,
		0,
		Lang.get(46947),
		21401,
		10,
		702,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[21401011] = {
		21401011,
		0,
		Lang.get(46948),
		21401,
		11,
		301,
		{
			RTResTalkAction[7],
			RTResTalkAction[5]
		}
	},
	[21401012] = {
		21401012,
		0,
		Lang.get(46949),
		21401,
		12,
		301,
		{
			RTResTalkAction[7]
		}
	},
	[21401013] = {
		21401013,
		0,
		Lang.get(46950),
		21401,
		13,
		703,
		{
			RTResTalkAction[8],
			RTResTalkAction[3]
		}
	},
	[21401014] = {
		21401014,
		0,
		Lang.get(46914),
		21401,
		14,
		301,
		{
			RTResTalkAction[7],
			RTResTalkAction[6]
		}
	},
	[21401015] = {
		21401015,
		0,
		Lang.get(46915),
		21401,
		15,
		703,
		{
			RTResTalkAction[10]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		21405,
		nil,
		1,
		nil,
		1,
		nil,
		21405
	},
	[21401016] = {
		21401016,
		0,
		Lang.get(46951),
		21401,
		16,
		709,
		nil,
		1
	},
	[21401017] = {
		21401017,
		0,
		Lang.get(46952),
		21401,
		17,
		708,
		nil,
		1
	},
	[21401018] = {
		21401018,
		0,
		Lang.get(46953),
		21401,
		18,
		710,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		21406,
		[19] = 21406,
		[17] = 1
	},
	[21401019] = {
		21401019,
		0,
		Lang.get(46954),
		21401,
		19,
		706,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[21401020] = {
		21401020,
		0,
		Lang.get(46955),
		21401,
		20,
		707,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[21401021] = {
		21401021,
		0,
		Lang.get(46956),
		21401,
		21,
		301,
		{
			RTResTalkAction[11],
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[21401022] = {
		21401022,
		0,
		Lang.get(46957),
		21401,
		22,
		706,
		{
			RTResTalkAction[16],
			RTResTalkAction[17],
			RTResTalkAction[10]
		}
	},
	[21401023] = {
		21401023,
		0,
		Lang.get(46958),
		21401,
		23,
		707,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[21402001] = {
		21402001,
		0,
		Lang.get(46959),
		21402,
		1,
		706,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		21407,
		nil,
		nil,
		nil,
		1,
		nil,
		21407
	},
	[21402002] = {
		21402002,
		0,
		Lang.get(46960),
		21402,
		2,
		707,
		nil,
		1
	},
	[21402003] = {
		21402003,
		0,
		Lang.get(46961),
		21402,
		3,
		301,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3
	},
	[21402004] = {
		21402004,
		0,
		Lang.get(46962),
		21402,
		4,
		706,
		{
			RTResTalkAction[16],
			RTResTalkAction[17],
			RTResTalkAction[10]
		}
	},
	[21402005] = {
		21402005,
		0,
		Lang.get(46963),
		21402,
		5,
		707,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[21402006] = {
		21402006,
		0,
		Lang.get(46964),
		21402,
		6,
		709,
		{
			RTResTalkAction[20],
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[21402007] = {
		21402007,
		0,
		Lang.get(46965),
		21402,
		7,
		708,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[21402008] = {
		21402008,
		0,
		Lang.get(46966),
		21402,
		8,
		706,
		{
			RTResTalkAction[16],
			RTResTalkAction[17],
			RTResTalkAction[23],
			RTResTalkAction[14]
		}
	},
	[21402009] = {
		21402009,
		0,
		Lang.get(46967),
		21402,
		9,
		707,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[21402010] = {
		21402010,
		0,
		Lang.get(46968),
		21402,
		10,
		703,
		{
			RTResTalkAction[18],
			RTResTalkAction[19]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		21501,
		nil,
		1,
		nil,
		1,
		nil,
		21501
	},
	[21402011] = {
		21402011,
		0,
		Lang.get(46969),
		21402,
		11,
		706,
		nil,
		1
	},
	[21402012] = {
		21402012,
		0,
		Lang.get(46970),
		21402,
		12,
		707,
		nil,
		1
	},
	[21402013] = {
		21402013,
		0,
		Lang.get(46971),
		21402,
		13,
		702,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		21408,
		[19] = 21408,
		[17] = 1
	},
	[21402014] = {
		21402014,
		0,
		Lang.get(46972),
		21402,
		14,
		301,
		{
			RTResTalkAction[24]
		},
		nil,
		nil,
		3
	},
	[21402015] = {
		21402015,
		0,
		Lang.get(47942),
		21402,
		15,
		710,
		{
			RTResTalkAction[25],
			RTResTalkAction[10]
		}
	},
	[21402016] = {
		21402016,
		0,
		Lang.get(46974),
		21402,
		16,
		708,
		{
			RTResTalkAction[26],
			RTResTalkAction[22]
		}
	},
	[21402017] = {
		21402017,
		0,
		Lang.get(46975),
		21402,
		17,
		703,
		{
			RTResTalkAction[27],
			RTResTalkAction[15],
			RTResTalkAction[14]
		}
	},
	[21402018] = {
		21402018,
		0,
		Lang.get(46976),
		21402,
		18,
		301,
		{
			RTResTalkAction[7],
			RTResTalkAction[6]
		}
	},
	[21402019] = {
		21402019,
		0,
		Lang.get(46977),
		21402,
		19,
		710,
		{
			RTResTalkAction[25],
			RTResTalkAction[10]
		}
	},
	[21402020] = {
		21402020,
		0,
		Lang.get(46978),
		21402,
		20,
		703,
		{
			RTResTalkAction[26],
			RTResTalkAction[3]
		}
	},
	[21402021] = {
		21402021,
		0,
		Lang.get(46979),
		21402,
		21,
		301,
		{
			RTResTalkAction[11],
			RTResTalkAction[15],
			RTResTalkAction[6]
		}
	},
	[21402022] = {
		21402022,
		0,
		Lang.get(46980),
		21402,
		22,
		127,
		{
			RTResTalkAction[10]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		21409,
		nil,
		1,
		nil,
		1,
		nil,
		21409
	},
	[21402023] = {
		21402023,
		0,
		Lang.get(46981),
		21402,
		23,
		301,
		{
			RTResTalkAction[24]
		},
		nil,
		nil,
		3
	},
	[21402024] = {
		21402024,
		0,
		Lang.get(46982),
		21402,
		24,
		127,
		{
			RTResTalkAction[8],
			RTResTalkAction[28]
		}
	},
	[21402025] = {
		21402025,
		0,
		Lang.get(47943),
		21402,
		25,
		710,
		{
			RTResTalkAction[25],
			RTResTalkAction[10],
			RTResTalkAction[29]
		}
	},
	[21402026] = {
		21402026,
		0,
		Lang.get(46984),
		21402,
		26,
		127,
		{
			RTResTalkAction[26],
			RTResTalkAction[30]
		}
	},
	[21402027] = {
		21402027,
		0,
		Lang.get(46985),
		21402,
		27,
		710,
		{
			RTResTalkAction[26],
			RTResTalkAction[30]
		}
	},
	[21403001] = {
		21403001,
		0,
		Lang.get(46986),
		21403,
		1,
		127,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		21410,
		nil,
		nil,
		nil,
		1,
		nil,
		21410
	},
	[21403002] = {
		21403002,
		0,
		Lang.get(46987),
		21403,
		2,
		112,
		nil,
		1
	},
	[21403003] = {
		21403003,
		0,
		Lang.get(46988),
		21403,
		3,
		708,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		21411,
		[19] = 21411,
		[17] = 1
	},
	[21403004] = {
		21403004,
		0,
		Lang.get(46989),
		21403,
		4,
		710,
		{
			RTResTalkAction[25]
		},
		nil,
		nil,
		3
	},
	[21403005] = {
		21403005,
		0,
		Lang.get(46990),
		21403,
		5,
		709,
		{
			RTResTalkAction[26],
			RTResTalkAction[31]
		}
	},
	[21403006] = {
		21403006,
		0,
		Lang.get(46991),
		21403,
		6,
		112,
		{
			RTResTalkAction[32],
			RTResTalkAction[15],
			RTResTalkAction[23]
		}
	},
	[21403007] = {
		21403007,
		0,
		Lang.get(46992),
		21403,
		7,
		710,
		{
			RTResTalkAction[25],
			RTResTalkAction[33]
		}
	},
	[21403008] = {
		21403008,
		0,
		Lang.get(46993),
		21403,
		8,
		708,
		{
			RTResTalkAction[34],
			RTResTalkAction[15]
		}
	},
	[21403009] = {
		21403009,
		0,
		Lang.get(46994),
		21403,
		9,
		709,
		{
			RTResTalkAction[20],
			RTResTalkAction[14]
		}
	},
	[21403010] = {
		21403010,
		0,
		Lang.get(46995),
		21403,
		10,
		112,
		{
			RTResTalkAction[32],
			RTResTalkAction[23]
		}
	},
	[21403011] = {
		21403011,
		0,
		Lang.get(46996),
		21403,
		11,
		301,
		{
			RTResTalkAction[7],
			RTResTalkAction[33]
		}
	},
	[21403012] = {
		21403012,
		0,
		Lang.get(46997),
		21403,
		12,
		703,
		{
			RTResTalkAction[8],
			RTResTalkAction[3]
		}
	},
	[21403013] = {
		21403013,
		0,
		Lang.get(46998),
		21403,
		13,
		301,
		{
			RTResTalkAction[8],
			RTResTalkAction[3]
		}
	},
	[21403014] = {
		21403014,
		0,
		Lang.get(46999),
		21403,
		14,
		702,
		{
			RTResTalkAction[1],
			RTResTalkAction[10],
			RTResTalkAction[6]
		}
	},
	[21403015] = {
		21403015,
		0,
		Lang.get(47000),
		21403,
		15,
		710,
		{
			RTResTalkAction[25],
			RTResTalkAction[5]
		}
	},
	[21403016] = {
		21403016,
		0,
		Lang.get(47001),
		21403,
		16,
		708,
		{
			RTResTalkAction[26],
			RTResTalkAction[22]
		}
	},
	[21403017] = {
		21403017,
		0,
		Lang.get(47002),
		21403,
		17,
		301,
		{
			RTResTalkAction[15],
			RTResTalkAction[14]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		21412,
		nil,
		1,
		nil,
		1,
		nil,
		21412
	},
	[21403018] = {
		21403018,
		0,
		Lang.get(47003),
		21403,
		18,
		702,
		nil,
		1
	},
	[21403019] = {
		21403019,
		0,
		Lang.get(47004),
		21403,
		19,
		301,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3
	},
	[21403020] = {
		21403020,
		0,
		Lang.get(47005),
		21403,
		20,
		703,
		{
			RTResTalkAction[8],
			RTResTalkAction[3]
		}
	},
	[21403021] = {
		21403021,
		0,
		Lang.get(47006),
		21403,
		21,
		301,
		{
			RTResTalkAction[35],
			RTResTalkAction[3]
		}
	},
	[21403022] = {
		21403022,
		0,
		Lang.get(47007),
		21403,
		22,
		703,
		{
			RTResTalkAction[8],
			RTResTalkAction[3]
		}
	},
	[21403023] = {
		21403023,
		0,
		Lang.get(47008),
		21403,
		23,
		702,
		{
			RTResTalkAction[1],
			RTResTalkAction[10],
			RTResTalkAction[6]
		}
	},
	[21403024] = {
		21403024,
		0,
		Lang.get(47009),
		21403,
		24,
		301,
		{
			RTResTalkAction[7],
			RTResTalkAction[5]
		}
	},
	[21403025] = {
		21403025,
		0,
		Lang.get(47010),
		21403,
		25,
		703,
		{
			RTResTalkAction[27],
			RTResTalkAction[10]
		}
	},
	[21403026] = {
		21403026,
		0,
		Lang.get(47011),
		21403,
		26,
		702,
		{
			RTResTalkAction[36],
			RTResTalkAction[9]
		}
	},
	[21404001] = {
		21404001,
		0,
		Lang.get(47012),
		21404,
		1,
		703,
		nil,
		1,
		nil,
		nil,
		nil,
		59,
		21413,
		nil,
		nil,
		nil,
		1,
		nil,
		21413
	},
	[21404002] = {
		21404002,
		0,
		Lang.get(47013),
		21404,
		2,
		301,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3
	},
	[21404003] = {
		21404003,
		0,
		Lang.get(47014),
		21404,
		3,
		702,
		{
			RTResTalkAction[1],
			RTResTalkAction[10]
		}
	},
	[21404004] = {
		21404004,
		0,
		Lang.get(47015),
		21404,
		4,
		301,
		{
			RTResTalkAction[7],
			RTResTalkAction[5]
		}
	},
	[21404005] = {
		21404005,
		0,
		Lang.get(47016),
		21404,
		5,
		702,
		{
			RTResTalkAction[1],
			RTResTalkAction[10]
		}
	},
	[21404006] = {
		21404006,
		0,
		Lang.get(47017),
		21404,
		6,
		703,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[21404007] = {
		21404007,
		0,
		Lang.get(47018),
		21404,
		7,
		703,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[21404008] = {
		21404008,
		0,
		Lang.get(47019),
		21404,
		8,
		703,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[21404009] = {
		21404009,
		0,
		Lang.get(47020),
		21404,
		9,
		301,
		{
			RTResTalkAction[7],
			RTResTalkAction[5],
			RTResTalkAction[6]
		}
	},
	[21404010] = {
		21404010,
		0,
		Lang.get(47021),
		21404,
		10,
		703,
		{
			RTResTalkAction[2],
			RTResTalkAction[3],
			RTResTalkAction[10]
		}
	},
	[21404011] = {
		21404011,
		0,
		Lang.get(47022),
		21404,
		11,
		702,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[21404012] = {
		21404012,
		0,
		Lang.get(47023),
		21404,
		12,
		301,
		{
			RTResTalkAction[7],
			RTResTalkAction[5],
			RTResTalkAction[6]
		}
	},
	[21404013] = {
		21404013,
		0,
		Lang.get(47024),
		21404,
		13,
		703,
		{
			RTResTalkAction[2],
			RTResTalkAction[3],
			RTResTalkAction[10]
		}
	},
	[21404014] = {
		21404014,
		0,
		Lang.get(47025),
		21404,
		14,
		702,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[21404015] = {
		21404015,
		0,
		Lang.get(47026),
		21404,
		15,
		301,
		{
			RTResTalkAction[5],
			RTResTalkAction[6]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[19] = 21506,
		[17] = 1
	},
	[21404016] = {
		21404016,
		0,
		Lang.get(47027),
		21404,
		16,
		301,
		nil,
		1,
		1
	},
	[21405001] = {
		21405001,
		9,
		Lang.get(47028),
		21405,
		1,
		301,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		21414,
		nil,
		nil,
		nil,
		1,
		nil,
		21414,
		nil,
		nil,
		1
	},
	[21405002] = {
		21405002,
		0,
		Lang.get(47029),
		21405,
		2,
		576,
		nil,
		1
	},
	[21405003] = {
		21405003,
		0,
		Lang.get(47030),
		21405,
		3,
		301,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3
	},
	[21405004] = {
		21405004,
		0,
		Lang.get(47031),
		21405,
		4,
		576,
		{
			RTResTalkAction[8],
			RTResTalkAction[37]
		}
	},
	[21405005] = {
		21405005,
		0,
		Lang.get(47032),
		21405,
		5,
		301,
		{
			RTResTalkAction[8],
			RTResTalkAction[37]
		}
	},
	[21405006] = {
		21405006,
		0,
		Lang.get(47033),
		21405,
		6,
		576,
		{
			RTResTalkAction[8],
			RTResTalkAction[37]
		}
	},
	[21405007] = {
		21405007,
		0,
		Lang.get(47034),
		21405,
		7,
		301,
		{
			RTResTalkAction[10],
			RTResTalkAction[38]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		21415,
		nil,
		1,
		nil,
		1,
		nil,
		21415
	},
	[21405008] = {
		21405008,
		0,
		Lang.get(47035),
		21405,
		8,
		711,
		nil,
		1
	},
	[21405009] = {
		21405009,
		0,
		Lang.get(47036),
		21405,
		9,
		301,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3
	},
	[21405010] = {
		21405010,
		0,
		Lang.get(47037),
		21405,
		10,
		711,
		{
			RTResTalkAction[10]
		},
		1
	},
	[21405011] = {
		21405011,
		0,
		Lang.get(47038),
		21405,
		11,
		301,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		21416,
		nil,
		1,
		nil,
		1,
		nil,
		21416
	},
	[21405012] = {
		21405012,
		0,
		Lang.get(47039),
		21405,
		12,
		712,
		nil,
		1
	},
	[21405013] = {
		21405013,
		0,
		Lang.get(47040),
		21405,
		13,
		301,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3
	},
	[21405014] = {
		21405014,
		0,
		Lang.get(47041),
		21405,
		14,
		712,
		{
			RTResTalkAction[10]
		},
		1
	},
	[21405015] = {
		21405015,
		0,
		Lang.get(47042),
		21405,
		15,
		301,
		{
			RTResTalkAction[7]
		}
	},
	[21405016] = {
		21405016,
		0,
		Lang.get(47043),
		21405,
		16,
		301,
		{
			RTResTalkAction[7]
		}
	},
	[21405017] = {
		21405017,
		0,
		Lang.get(47044),
		21405,
		17,
		301,
		{
			RTResTalkAction[7]
		}
	},
	[21405018] = {
		21405018,
		0,
		Lang.get(47045),
		21405,
		18,
		712,
		{
			RTResTalkAction[10]
		},
		1
	},
	[21405019] = {
		21405019,
		0,
		Lang.get(47046),
		21405,
		19,
		301,
		{
			RTResTalkAction[7]
		}
	},
	[21405020] = {
		21405020,
		0,
		Lang.get(47047),
		21405,
		20,
		712,
		{
			RTResTalkAction[10]
		},
		1
	},
	[21406001] = {
		21406001,
		0,
		Lang.get(47048),
		21406,
		1,
		710,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		21502,
		nil,
		nil,
		nil,
		1,
		nil,
		21502
	},
	[21406002] = {
		21406002,
		0,
		Lang.get(47049),
		21406,
		2,
		708,
		nil,
		1
	},
	[21406003] = {
		21406003,
		9,
		Lang.get(47050),
		21406,
		3,
		605,
		[22] = 1
	},
	[21406004] = {
		21406004,
		0,
		Lang.get(47051),
		21406,
		4,
		709,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		21417,
		[19] = 21417,
		[17] = 1
	},
	[21406005] = {
		21406005,
		0,
		Lang.get(47052),
		21406,
		5,
		301,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3
	},
	[21406006] = {
		21406006,
		0,
		Lang.get(47053),
		21406,
		6,
		127,
		{
			RTResTalkAction[8],
			RTResTalkAction[28]
		}
	},
	[21406007] = {
		21406007,
		0,
		Lang.get(47054),
		21406,
		7,
		301,
		{
			RTResTalkAction[35],
			RTResTalkAction[30]
		}
	},
	[21406008] = {
		21406008,
		0,
		Lang.get(47055),
		21406,
		8,
		127,
		{
			RTResTalkAction[8],
			RTResTalkAction[39]
		}
	},
	[21406009] = {
		21406009,
		0,
		Lang.get(47056),
		21406,
		9,
		710,
		{
			RTResTalkAction[25],
			RTResTalkAction[10],
			RTResTalkAction[29]
		}
	},
	[21406010] = {
		21406010,
		0,
		Lang.get(47057),
		21406,
		10,
		127,
		{
			RTResTalkAction[40],
			RTResTalkAction[15]
		}
	},
	[21406011] = {
		21406011,
		0,
		Lang.get(47058),
		21406,
		11,
		127,
		{
			RTResTalkAction[29]
		},
		1,
		0,
		nil,
		nil,
		nil,
		21418,
		nil,
		1,
		nil,
		1,
		nil,
		21418
	},
	[21406012] = {
		21406012,
		0,
		Lang.get(47059),
		21406,
		12,
		301,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3
	},
	[21406013] = {
		21406013,
		0,
		Lang.get(47944),
		21406,
		13,
		127,
		{
			RTResTalkAction[8],
			RTResTalkAction[30]
		}
	},
	[21406014] = {
		21406014,
		0,
		Lang.get(47061),
		21406,
		14,
		127,
		{
			RTResTalkAction[8],
			RTResTalkAction[28]
		}
	},
	[21406015] = {
		21406015,
		0,
		Lang.get(47062),
		21406,
		15,
		301,
		{
			RTResTalkAction[35],
			RTResTalkAction[30]
		}
	},
	[21406016] = {
		21406016,
		0,
		Lang.get(47063),
		21406,
		16,
		127,
		{
			RTResTalkAction[8],
			RTResTalkAction[30]
		}
	},
	[21406017] = {
		21406017,
		0,
		Lang.get(47064),
		21406,
		17,
		229,
		{
			RTResTalkAction[10],
			RTResTalkAction[29]
		},
		1,
		0,
		nil,
		nil,
		nil,
		21419,
		nil,
		1,
		nil,
		1,
		nil,
		21419
	},
	[21406018] = {
		21406018,
		0,
		Lang.get(47065),
		21406,
		18,
		705,
		nil,
		1
	},
	[21406019] = {
		21406019,
		7,
		"64",
		21406,
		19,
		705,
		nil,
		nil,
		nil,
		5
	},
	[21406020] = {
		21406020,
		9,
		Lang.get(47066),
		21406,
		20,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		21420,
		nil,
		nil,
		nil,
		1,
		nil,
		21420,
		nil,
		nil,
		1
	},
	[21406021] = {
		21406021,
		0,
		Lang.get(47067),
		21406,
		21,
		229,
		nil,
		1
	},
	[21406022] = {
		21406022,
		0,
		Lang.get(47068),
		21406,
		22,
		705,
		{
			RTResTalkAction[41]
		},
		nil,
		nil,
		3
	},
	[21406023] = {
		21406023,
		0,
		Lang.get(47069),
		21406,
		23,
		229,
		{
			RTResTalkAction[42],
			RTResTalkAction[43]
		}
	},
	[21406024] = {
		21406024,
		0,
		Lang.get(47070),
		21406,
		24,
		705,
		{
			RTResTalkAction[42],
			RTResTalkAction[43]
		}
	},
	[21406025] = {
		21406025,
		0,
		Lang.get(47071),
		21406,
		25,
		705,
		{
			RTResTalkAction[42],
			RTResTalkAction[43]
		}
	},
	[21406026] = {
		21406026,
		0,
		Lang.get(47072),
		21406,
		26,
		229,
		{
			RTResTalkAction[42],
			RTResTalkAction[43]
		}
	},
	[21406027] = {
		21406027,
		0,
		Lang.get(47073),
		21406,
		27,
		705,
		{
			RTResTalkAction[44],
			RTResTalkAction[45]
		}
	},
	[21407001] = {
		21407001,
		0,
		Lang.get(47074),
		21407,
		1,
		705,
		nil,
		1,
		nil,
		nil,
		nil,
		59,
		21421,
		nil,
		nil,
		nil,
		1,
		nil,
		21421
	},
	[21407002] = {
		21407002,
		0,
		Lang.get(47075),
		21407,
		2,
		705,
		{
			RTResTalkAction[46]
		},
		nil,
		nil,
		3
	},
	[21407003] = {
		21407003,
		0,
		Lang.get(47076),
		21407,
		3,
		705,
		{
			RTResTalkAction[46]
		}
	},
	[21407004] = {
		21407004,
		0,
		Lang.get(47077),
		21407,
		4,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[47]
		}
	},
	[21407005] = {
		21407005,
		0,
		Lang.get(47078),
		21407,
		5,
		705,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21407006] = {
		21407006,
		0,
		Lang.get(47079),
		21407,
		6,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[49]
		}
	},
	[21407007] = {
		21407007,
		0,
		Lang.get(47080),
		21407,
		7,
		705,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21407008] = {
		21407008,
		0,
		Lang.get(47081),
		21407,
		8,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[50]
		}
	},
	[21407009] = {
		21407009,
		0,
		Lang.get(47082),
		21407,
		9,
		705,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21407010] = {
		21407010,
		0,
		Lang.get(47083),
		21407,
		10,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[49]
		}
	},
	[21407011] = {
		21407011,
		0,
		Lang.get(47084),
		21407,
		11,
		705,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21407012] = {
		21407012,
		0,
		Lang.get(47085),
		21407,
		12,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[51]
		}
	},
	[21407013] = {
		21407013,
		0,
		Lang.get(47086),
		21407,
		13,
		705,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21407014] = {
		21407014,
		0,
		Lang.get(47087),
		21407,
		14,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[52]
		}
	},
	[21407015] = {
		21407015,
		0,
		Lang.get(47088),
		21407,
		15,
		705,
		{
			RTResTalkAction[53],
			RTResTalkAction[48]
		}
	},
	[21407016] = {
		21407016,
		0,
		Lang.get(47089),
		21407,
		16,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[54]
		}
	},
	[21407017] = {
		21407017,
		0,
		Lang.get(47090),
		21407,
		17,
		705,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21407018] = {
		21407018,
		0,
		Lang.get(47091),
		21407,
		18,
		705,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21407019] = {
		21407019,
		0,
		Lang.get(47092),
		21407,
		19,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[49]
		}
	},
	[21407020] = {
		21407020,
		0,
		Lang.get(47093),
		21407,
		20,
		705,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21407021] = {
		21407021,
		0,
		Lang.get(47094),
		21407,
		21,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[51]
		}
	},
	[21408001] = {
		21408001,
		0,
		Lang.get(47095),
		21408,
		1,
		705,
		nil,
		1,
		2,
		nil,
		nil,
		60,
		21422,
		nil,
		nil,
		nil,
		1,
		nil,
		21422
	},
	[21408002] = {
		21408002,
		0,
		Lang.get(47096),
		21408,
		2,
		119,
		nil,
		1,
		6
	},
	[21408003] = {
		21408003,
		0,
		Lang.get(47097),
		21408,
		3,
		705,
		{
			RTResTalkAction[55]
		},
		nil,
		0,
		3
	},
	[21408004] = {
		21408004,
		0,
		Lang.get(47098),
		21408,
		4,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[49]
		}
	},
	[21408005] = {
		21408005,
		0,
		Lang.get(47099),
		21408,
		5,
		705,
		{
			RTResTalkAction[42],
			RTResTalkAction[56]
		}
	},
	[21408006] = {
		21408006,
		0,
		Lang.get(47100),
		21408,
		6,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[57]
		}
	},
	[21408007] = {
		21408007,
		0,
		Lang.get(47101),
		21408,
		7,
		705,
		{
			RTResTalkAction[42],
			RTResTalkAction[56]
		}
	},
	[21408008] = {
		21408008,
		0,
		Lang.get(47102),
		21408,
		8,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[54]
		}
	},
	[21408009] = {
		21408009,
		0,
		Lang.get(47103),
		21408,
		9,
		705,
		{
			RTResTalkAction[42],
			RTResTalkAction[56]
		}
	},
	[21408010] = {
		21408010,
		0,
		Lang.get(47104),
		21408,
		10,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[58]
		}
	},
	[21408011] = {
		21408011,
		0,
		Lang.get(47105),
		21408,
		11,
		705,
		{
			RTResTalkAction[42],
			RTResTalkAction[56]
		}
	},
	[21408012] = {
		21408012,
		0,
		Lang.get(47106),
		21408,
		12,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[49]
		}
	},
	[21408013] = {
		21408013,
		0,
		Lang.get(47107),
		21408,
		13,
		705,
		{
			RTResTalkAction[42],
			RTResTalkAction[56]
		}
	},
	[21408014] = {
		21408014,
		0,
		Lang.get(47108),
		21408,
		14,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[59]
		}
	},
	[21408015] = {
		21408015,
		0,
		Lang.get(47109),
		21408,
		15,
		705,
		{
			RTResTalkAction[42],
			RTResTalkAction[56]
		}
	},
	[21408016] = {
		21408016,
		0,
		Lang.get(47110),
		21408,
		16,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[54]
		}
	},
	[21409001] = {
		21409001,
		0,
		Lang.get(47111),
		21409,
		1,
		119,
		nil,
		1,
		2,
		nil,
		nil,
		63,
		21423,
		nil,
		nil,
		nil,
		1,
		nil,
		21423
	},
	[21409002] = {
		21409002,
		0,
		Lang.get(47112),
		21409,
		2,
		119,
		nil,
		1,
		9
	},
	[21409003] = {
		21409003,
		0,
		Lang.get(47113),
		21409,
		3,
		119,
		nil,
		1,
		6
	},
	[21409004] = {
		21409004,
		0,
		Lang.get(47114),
		21409,
		4,
		119,
		nil,
		1,
		7
	},
	[21409005] = {
		21409005,
		0,
		Lang.get(47115),
		21409,
		5,
		705,
		nil,
		1,
		0
	},
	[21409006] = {
		21409006,
		0,
		Lang.get(47116),
		21409,
		6,
		119,
		nil,
		1,
		4,
		nil,
		nil,
		nil,
		21424,
		nil,
		nil,
		nil,
		1,
		nil,
		21424
	},
	[21409007] = {
		21409007,
		0,
		Lang.get(47536),
		21409,
		7,
		705,
		{
			RTResTalkAction[46]
		},
		nil,
		nil,
		3
	},
	[21409008] = {
		21409008,
		0,
		Lang.get(47118),
		21409,
		8,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[49]
		}
	},
	[21409009] = {
		21409009,
		0,
		Lang.get(47537),
		21409,
		9,
		705,
		{
			RTResTalkAction[42],
			RTResTalkAction[56]
		}
	},
	[21409010] = {
		21409010,
		0,
		Lang.get(47120),
		21409,
		10,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[51]
		}
	},
	[21409011] = {
		21409011,
		0,
		Lang.get(47121),
		21409,
		11,
		705,
		{
			RTResTalkAction[42],
			RTResTalkAction[56]
		}
	},
	[21409012] = {
		21409012,
		0,
		Lang.get(47122),
		21409,
		12,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[49]
		}
	},
	[21409013] = {
		21409013,
		0,
		Lang.get(47123),
		21409,
		13,
		705,
		{
			RTResTalkAction[42],
			RTResTalkAction[56]
		}
	},
	[21409014] = {
		21409014,
		0,
		Lang.get(47124),
		21409,
		14,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[49]
		}
	},
	[21409015] = {
		21409015,
		0,
		Lang.get(47125),
		21409,
		15,
		705,
		{
			RTResTalkAction[42],
			RTResTalkAction[56]
		}
	},
	[21409016] = {
		21409016,
		0,
		Lang.get(47126),
		21409,
		16,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[49]
		}
	},
	[21409017] = {
		21409017,
		0,
		Lang.get(47538),
		21409,
		17,
		705,
		{
			RTResTalkAction[42],
			RTResTalkAction[56]
		}
	},
	[21409018] = {
		21409018,
		0,
		Lang.get(47128),
		21409,
		18,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[54]
		}
	},
	[21410001] = {
		21410001,
		0,
		Lang.get(47129),
		21410,
		1,
		705,
		nil,
		1,
		0,
		nil,
		nil,
		60,
		21425,
		nil,
		nil,
		nil,
		1,
		nil,
		21425
	},
	[21410002] = {
		21410002,
		0,
		Lang.get(47130),
		21410,
		2,
		119,
		nil,
		1
	},
	[21410003] = {
		21410003,
		0,
		Lang.get(47131),
		21410,
		3,
		705,
		{
			RTResTalkAction[41]
		},
		nil,
		nil,
		3
	},
	[21410004] = {
		21410004,
		0,
		Lang.get(47132),
		21410,
		4,
		705,
		{
			RTResTalkAction[44]
		}
	},
	[21410005] = {
		21410005,
		0,
		Lang.get(47133),
		21410,
		5,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21410006] = {
		21410006,
		0,
		Lang.get(47134),
		21410,
		6,
		705,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21410007] = {
		21410007,
		0,
		Lang.get(47135),
		21410,
		7,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21410008] = {
		21410008,
		0,
		Lang.get(47136),
		21410,
		8,
		705,
		{
			RTResTalkAction[60],
			RTResTalkAction[48]
		}
	},
	[21410009] = {
		21410009,
		0,
		Lang.get(47137),
		21410,
		9,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21410010] = {
		21410010,
		0,
		Lang.get(47138),
		21410,
		10,
		705,
		{
			RTResTalkAction[61],
			RTResTalkAction[48]
		}
	},
	[21410011] = {
		21410011,
		0,
		Lang.get(55465),
		21410,
		11,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21410012] = {
		21410012,
		0,
		Lang.get(55466),
		21410,
		12,
		705,
		{
			RTResTalkAction[46],
			RTResTalkAction[62]
		}
	},
	[21410013] = {
		21410013,
		0,
		Lang.get(47140),
		21410,
		13,
		705,
		{
			RTResTalkAction[63]
		},
		1,
		2,
		nil,
		nil,
		nil,
		21503,
		nil,
		1,
		nil,
		1,
		nil,
		21503
	},
	[21410014] = {
		21410014,
		0,
		Lang.get(47141),
		21410,
		14,
		705,
		nil,
		1,
		1
	},
	[21410015] = {
		21410015,
		9,
		Lang.get(47142),
		21410,
		15,
		605,
		[22] = 1
	},
	[21410016] = {
		21410016,
		0,
		Lang.get(47143),
		21410,
		16,
		705,
		{
			RTResTalkAction[41]
		},
		nil,
		0,
		3
	},
	[21410017] = {
		21410017,
		0,
		Lang.get(47144),
		21410,
		17,
		713,
		{
			RTResTalkAction[42],
			RTResTalkAction[64]
		}
	},
	[21410018] = {
		21410018,
		0,
		Lang.get(47145),
		21410,
		18,
		705,
		{
			RTResTalkAction[44],
			RTResTalkAction[65]
		}
	},
	[21410019] = {
		21410019,
		0,
		Lang.get(47146),
		21410,
		19,
		714,
		{
			RTResTalkAction[42],
			RTResTalkAction[66]
		}
	},
	[21410020] = {
		21410020,
		0,
		Lang.get(47147),
		21410,
		20,
		705,
		{
			RTResTalkAction[46],
			RTResTalkAction[67]
		}
	},
	[21410021] = {
		21410021,
		0,
		Lang.get(47148),
		21410,
		21,
		715,
		{
			RTResTalkAction[42],
			RTResTalkAction[68]
		}
	},
	[21410022] = {
		21410022,
		0,
		Lang.get(47945),
		21410,
		22,
		705,
		{
			RTResTalkAction[46],
			RTResTalkAction[69]
		}
	},
	[21410023] = {
		21410023,
		0,
		Lang.get(47150),
		21410,
		23,
		713,
		{
			RTResTalkAction[42],
			RTResTalkAction[64]
		}
	},
	[21410024] = {
		21410024,
		0,
		Lang.get(47151),
		21410,
		24,
		705,
		{
			RTResTalkAction[41],
			RTResTalkAction[65]
		}
	},
	[21411001] = {
		21411001,
		0,
		Lang.get(47152),
		21411,
		1,
		119,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		21426,
		nil,
		nil,
		nil,
		1,
		nil,
		21426
	},
	[21411002] = {
		21411002,
		0,
		Lang.get(47946),
		21411,
		2,
		119,
		nil,
		1
	},
	[21411003] = {
		21411003,
		0,
		Lang.get(47540),
		21411,
		3,
		705,
		{
			RTResTalkAction[46]
		},
		nil,
		nil,
		3
	},
	[21411004] = {
		21411004,
		0,
		Lang.get(47155),
		21411,
		4,
		119,
		{
			RTResTalkAction[70],
			RTResTalkAction[63]
		}
	},
	[21411005] = {
		21411005,
		0,
		Lang.get(47156),
		21411,
		5,
		119,
		{
			RTResTalkAction[70]
		}
	},
	[21411006] = {
		21411006,
		0,
		Lang.get(47157),
		21411,
		6,
		713,
		{
			RTResTalkAction[71],
			RTResTalkAction[64]
		}
	},
	[21411007] = {
		21411007,
		0,
		Lang.get(47158),
		21411,
		7,
		714,
		{
			RTResTalkAction[72],
			RTResTalkAction[62],
			RTResTalkAction[65]
		}
	},
	[21411008] = {
		21411008,
		0,
		Lang.get(47159),
		21411,
		8,
		715,
		{
			RTResTalkAction[73],
			RTResTalkAction[68]
		}
	},
	[21411009] = {
		21411009,
		0,
		Lang.get(47160),
		21411,
		9,
		119,
		{
			RTResTalkAction[70],
			RTResTalkAction[67],
			RTResTalkAction[69]
		}
	},
	[21411010] = {
		21411010,
		0,
		"……",
		21411,
		10,
		713,
		{
			RTResTalkAction[71],
			RTResTalkAction[64]
		}
	},
	[21411011] = {
		21411011,
		0,
		Lang.get(47161),
		21411,
		11,
		119,
		{
			RTResTalkAction[70],
			RTResTalkAction[65]
		}
	},
	[21411012] = {
		21411012,
		0,
		Lang.get(47162),
		21411,
		12,
		713,
		{
			RTResTalkAction[71],
			RTResTalkAction[64]
		}
	},
	[21411013] = {
		21411013,
		0,
		Lang.get(47163),
		21411,
		13,
		705,
		{
			RTResTalkAction[46],
			RTResTalkAction[62],
			RTResTalkAction[65]
		}
	},
	[21411014] = {
		21411014,
		0,
		Lang.get(47164),
		21411,
		14,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21412001] = {
		21412001,
		0,
		Lang.get(47165),
		21412,
		1,
		705,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		21427,
		nil,
		nil,
		nil,
		1,
		nil,
		21427
	},
	[21412002] = {
		21412002,
		0,
		Lang.get(47166),
		21412,
		2,
		119,
		nil,
		1
	},
	[21412003] = {
		21412003,
		0,
		Lang.get(47167),
		21412,
		3,
		713,
		nil,
		1
	},
	[21412004] = {
		21412004,
		0,
		Lang.get(55467),
		21412,
		4,
		705,
		{
			RTResTalkAction[41]
		},
		nil,
		nil,
		3
	},
	[21412005] = {
		21412005,
		0,
		Lang.get(47169),
		21412,
		5,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21412006] = {
		21412006,
		0,
		Lang.get(55468),
		21412,
		6,
		705,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21412007] = {
		21412007,
		0,
		Lang.get(55469),
		21412,
		7,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21412008] = {
		21412008,
		0,
		Lang.get(47172),
		21412,
		8,
		705,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21412009] = {
		21412009,
		0,
		Lang.get(47173),
		21412,
		9,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21412010] = {
		21412010,
		0,
		Lang.get(55470),
		21412,
		10,
		713,
		{
			RTResTalkAction[74],
			RTResTalkAction[63],
			RTResTalkAction[62]
		}
	},
	[21412011] = {
		21412011,
		0,
		Lang.get(55471),
		21412,
		11,
		714,
		{
			RTResTalkAction[72],
			RTResTalkAction[65]
		}
	},
	[21412012] = {
		21412012,
		0,
		Lang.get(55472),
		21412,
		12,
		715,
		{
			RTResTalkAction[75],
			RTResTalkAction[67]
		}
	},
	[21412013] = {
		21412013,
		0,
		Lang.get(47177),
		21412,
		13,
		705,
		{
			RTResTalkAction[44],
			RTResTalkAction[69]
		}
	},
	[21412014] = {
		21412014,
		0,
		Lang.get(47178),
		21412,
		14,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21412015] = {
		21412015,
		0,
		Lang.get(55473),
		21412,
		15,
		713,
		{
			RTResTalkAction[74],
			RTResTalkAction[63],
			RTResTalkAction[62]
		}
	},
	[21412016] = {
		21412016,
		0,
		Lang.get(55474),
		21412,
		16,
		714,
		{
			RTResTalkAction[72],
			RTResTalkAction[65]
		}
	},
	[21412017] = {
		21412017,
		0,
		Lang.get(55475),
		21412,
		17,
		715,
		{
			RTResTalkAction[75],
			RTResTalkAction[67]
		}
	},
	[21412018] = {
		21412018,
		0,
		Lang.get(55476),
		21412,
		18,
		119,
		{
			RTResTalkAction[70],
			RTResTalkAction[69]
		}
	},
	[21412019] = {
		21412019,
		0,
		Lang.get(55477),
		21412,
		19,
		119,
		{
			RTResTalkAction[70]
		}
	},
	[21412020] = {
		21412020,
		0,
		Lang.get(47541),
		21412,
		20,
		705,
		{
			RTResTalkAction[60],
			RTResTalkAction[48]
		}
	},
	[21412021] = {
		21412021,
		0,
		Lang.get(55478),
		21412,
		21,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21412022] = {
		21412022,
		0,
		Lang.get(55479),
		21412,
		22,
		705,
		{
			RTResTalkAction[61],
			RTResTalkAction[48]
		}
	},
	[21412023] = {
		21412023,
		0,
		Lang.get(55480),
		21412,
		23,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21412024] = {
		21412024,
		0,
		Lang.get(55481),
		21412,
		24,
		705,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21412025] = {
		21412025,
		0,
		Lang.get(55482),
		21412,
		25,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21412026] = {
		21412026,
		5,
		Lang.get(47189),
		21412,
		26,
		119,
		{
			RTResTalkAction[70],
			RTResTalkAction[63]
		}
	},
	[21412027] = {
		21412027,
		0,
		Lang.get(55483),
		21412,
		27,
		714,
		{
			RTResTalkAction[72],
			RTResTalkAction[62]
		}
	},
	[21412028] = {
		21412028,
		0,
		Lang.get(55484),
		21412,
		28,
		705,
		{
			RTResTalkAction[41],
			RTResTalkAction[67]
		}
	},
	[21412029] = {
		21412029,
		0,
		Lang.get(47947),
		21412,
		29,
		713,
		{
			RTResTalkAction[74],
			RTResTalkAction[63]
		}
	},
	[21412030] = {
		21412030,
		0,
		Lang.get(55485),
		21412,
		30,
		714,
		{
			RTResTalkAction[76],
			RTResTalkAction[66]
		}
	},
	[21412031] = {
		21412031,
		5,
		Lang.get(55486),
		21412,
		31,
		119,
		{
			RTResTalkAction[70],
			RTResTalkAction[65],
			RTResTalkAction[67]
		}
	},
	[21413001] = {
		21413001,
		0,
		Lang.get(47195),
		21413,
		1,
		713,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		21428,
		nil,
		nil,
		nil,
		1,
		nil,
		21428
	},
	[21413002] = {
		21413002,
		0,
		Lang.get(55487),
		21413,
		2,
		714,
		nil,
		1
	},
	[21413003] = {
		21413003,
		0,
		Lang.get(55488),
		21413,
		3,
		715,
		nil,
		1
	},
	[21413004] = {
		21413004,
		0,
		Lang.get(47198),
		21413,
		4,
		119,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		21429,
		[19] = 21429,
		[17] = 1
	},
	[21413005] = {
		21413005,
		0,
		Lang.get(47199),
		21413,
		5,
		713,
		nil,
		1
	},
	[21413006] = {
		21413006,
		0,
		Lang.get(55489),
		21413,
		6,
		714,
		nil,
		1
	},
	[21413007] = {
		21413007,
		0,
		Lang.get(47201),
		21413,
		7,
		119,
		nil,
		1
	},
	[21413008] = {
		21413008,
		0,
		Lang.get(55490),
		21413,
		8,
		714,
		nil,
		1
	},
	[21413009] = {
		21413009,
		0,
		Lang.get(55491),
		21413,
		9,
		715,
		nil,
		1
	},
	[21413010] = {
		21413010,
		0,
		Lang.get(55492),
		21413,
		10,
		119,
		nil,
		1
	},
	[21413011] = {
		21413011,
		0,
		Lang.get(55493),
		21413,
		11,
		714,
		nil,
		1
	},
	[21413012] = {
		21413012,
		0,
		Lang.get(47206),
		21413,
		12,
		705,
		{
			RTResTalkAction[41]
		},
		nil,
		nil,
		3
	},
	[21413013] = {
		21413013,
		0,
		Lang.get(47207),
		21413,
		13,
		713,
		{
			RTResTalkAction[42],
			RTResTalkAction[64]
		}
	},
	[21413014] = {
		21413014,
		0,
		Lang.get(47208),
		21413,
		14,
		119,
		{
			RTResTalkAction[70],
			RTResTalkAction[63],
			RTResTalkAction[65]
		}
	},
	[21413015] = {
		21413015,
		0,
		Lang.get(55494),
		21413,
		15,
		705,
		{
			RTResTalkAction[53],
			RTResTalkAction[48]
		}
	},
	[21413016] = {
		21413016,
		0,
		Lang.get(55495),
		21413,
		16,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21413017] = {
		21413017,
		0,
		Lang.get(55496),
		21413,
		17,
		713,
		{
			RTResTalkAction[74],
			RTResTalkAction[63],
			RTResTalkAction[62]
		}
	},
	[21413018] = {
		21413018,
		0,
		Lang.get(55497),
		21413,
		18,
		714,
		{
			RTResTalkAction[72],
			RTResTalkAction[65]
		}
	},
	[21413019] = {
		21413019,
		0,
		Lang.get(55498),
		21413,
		19,
		715,
		{
			RTResTalkAction[75],
			RTResTalkAction[67]
		}
	},
	[21413020] = {
		21413020,
		0,
		Lang.get(55499),
		21413,
		20,
		705,
		{
			RTResTalkAction[44],
			RTResTalkAction[69]
		}
	},
	[21413021] = {
		21413021,
		0,
		Lang.get(47215),
		21413,
		21,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21413022] = {
		21413022,
		0,
		Lang.get(47216),
		21413,
		22,
		713,
		{
			RTResTalkAction[74],
			RTResTalkAction[63],
			RTResTalkAction[62]
		}
	},
	[21413023] = {
		21413023,
		0,
		Lang.get(55500),
		21413,
		23,
		705,
		{
			RTResTalkAction[41],
			RTResTalkAction[65]
		}
	},
	[21413024] = {
		21413024,
		0,
		Lang.get(47218),
		21413,
		24,
		713,
		{
			RTResTalkAction[74],
			RTResTalkAction[63]
		}
	},
	[21413025] = {
		21413025,
		0,
		Lang.get(47219),
		21413,
		25,
		119,
		{
			RTResTalkAction[70],
			RTResTalkAction[65]
		}
	},
	[21414001] = {
		21414001,
		0,
		Lang.get(55501),
		21414,
		1,
		705,
		nil,
		1,
		nil,
		nil,
		nil,
		66,
		21431,
		nil,
		nil,
		nil,
		1,
		nil,
		21431
	},
	[21414002] = {
		21414002,
		0,
		Lang.get(55502),
		21414,
		2,
		119,
		nil,
		1
	},
	[21414003] = {
		21414003,
		0,
		Lang.get(47222),
		21414,
		3,
		705,
		{
			RTResTalkAction[41]
		},
		nil,
		nil,
		3
	},
	[21414004] = {
		21414004,
		0,
		Lang.get(55503),
		21414,
		4,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21414005] = {
		21414005,
		0,
		Lang.get(55504),
		21414,
		5,
		705,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21414006] = {
		21414006,
		0,
		Lang.get(47225),
		21414,
		6,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21414007] = {
		21414007,
		0,
		Lang.get(55505),
		21414,
		7,
		705,
		{
			RTResTalkAction[61],
			RTResTalkAction[48]
		}
	},
	[21414008] = {
		21414008,
		0,
		Lang.get(47227),
		21414,
		8,
		713,
		{
			RTResTalkAction[74],
			RTResTalkAction[63],
			RTResTalkAction[62]
		}
	},
	[21414009] = {
		21414009,
		0,
		Lang.get(55506),
		21414,
		9,
		714,
		{
			RTResTalkAction[72],
			RTResTalkAction[65]
		}
	},
	[21414010] = {
		21414010,
		0,
		Lang.get(55507),
		21414,
		10,
		119,
		{
			RTResTalkAction[70],
			RTResTalkAction[67]
		}
	},
	[21414011] = {
		21414011,
		0,
		Lang.get(55508),
		21414,
		11,
		705,
		{
			RTResTalkAction[53],
			RTResTalkAction[48]
		}
	},
	[21414012] = {
		21414012,
		0,
		Lang.get(55509),
		21414,
		12,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21414013] = {
		21414013,
		0,
		Lang.get(55510),
		21414,
		13,
		705,
		{
			RTResTalkAction[61],
			RTResTalkAction[48]
		}
	},
	[21414014] = {
		21414014,
		0,
		Lang.get(55511),
		21414,
		14,
		713,
		{
			RTResTalkAction[74],
			RTResTalkAction[63],
			RTResTalkAction[62]
		}
	},
	[21414015] = {
		21414015,
		0,
		Lang.get(55512),
		21414,
		15,
		714,
		{
			RTResTalkAction[72],
			RTResTalkAction[65]
		}
	},
	[21414016] = {
		21414016,
		0,
		Lang.get(47235),
		21414,
		16,
		119,
		{
			RTResTalkAction[70],
			RTResTalkAction[67]
		}
	},
	[21414017] = {
		21414017,
		0,
		Lang.get(47236),
		21414,
		17,
		705,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21414018] = {
		21414018,
		0,
		Lang.get(47544),
		21414,
		18,
		705,
		{
			RTResTalkAction[44],
			RTResTalkAction[62]
		}
	},
	[21414019] = {
		21414019,
		0,
		Lang.get(47238),
		21414,
		19,
		715,
		{
			RTResTalkAction[75],
			RTResTalkAction[63]
		}
	},
	[21414020] = {
		21414020,
		0,
		Lang.get(47239),
		21414,
		20,
		705,
		{
			RTResTalkAction[41],
			RTResTalkAction[69]
		}
	},
	[21415001] = {
		21415001,
		0,
		Lang.get(47240),
		21415,
		1,
		713,
		nil,
		1,
		nil,
		nil,
		nil,
		150,
		21430,
		nil,
		nil,
		nil,
		1,
		nil,
		21430
	},
	[21415002] = {
		21415002,
		0,
		Lang.get(55513),
		21415,
		2,
		714,
		nil,
		1
	},
	[21415003] = {
		21415003,
		0,
		Lang.get(47242),
		21415,
		3,
		715,
		nil,
		1
	},
	[21415004] = {
		21415004,
		0,
		Lang.get(47243),
		21415,
		4,
		705,
		{
			RTResTalkAction[41]
		},
		nil,
		nil,
		3
	},
	[21415005] = {
		21415005,
		0,
		Lang.get(47244),
		21415,
		5,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21415006] = {
		21415006,
		0,
		Lang.get(47245),
		21415,
		6,
		705,
		{
			RTResTalkAction[46],
			RTResTalkAction[62]
		}
	},
	[21415007] = {
		21415007,
		0,
		Lang.get(47246),
		21415,
		7,
		713,
		{
			RTResTalkAction[74],
			RTResTalkAction[63]
		}
	},
	[21415008] = {
		21415008,
		0,
		Lang.get(47247),
		21415,
		8,
		119,
		{
			RTResTalkAction[70],
			RTResTalkAction[65]
		}
	},
	[21415009] = {
		21415009,
		0,
		Lang.get(47248),
		21415,
		9,
		119,
		{
			RTResTalkAction[70]
		}
	},
	[21415010] = {
		21415010,
		0,
		Lang.get(55514),
		21415,
		10,
		705,
		{
			RTResTalkAction[61],
			RTResTalkAction[48]
		}
	},
	[21415011] = {
		21415011,
		0,
		Lang.get(47250),
		21415,
		11,
		713,
		{
			RTResTalkAction[74],
			RTResTalkAction[63],
			RTResTalkAction[62]
		}
	},
	[21415012] = {
		21415012,
		0,
		Lang.get(55515),
		21415,
		12,
		705,
		{
			RTResTalkAction[46],
			RTResTalkAction[65]
		}
	},
	[21415013] = {
		21415013,
		0,
		Lang.get(47252),
		21415,
		13,
		705,
		{
			RTResTalkAction[46]
		}
	},
	[21415014] = {
		21415014,
		0,
		Lang.get(55516),
		21415,
		14,
		705,
		{
			RTResTalkAction[63]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		21504,
		nil,
		1,
		nil,
		1,
		nil,
		21504
	},
	[21415015] = {
		21415015,
		0,
		Lang.get(55517),
		21415,
		15,
		705,
		nil,
		1
	},
	[21415016] = {
		21415016,
		0,
		Lang.get(55518),
		21415,
		16,
		705,
		{
			RTResTalkAction[41]
		},
		nil,
		nil,
		3
	},
	[21415017] = {
		21415017,
		0,
		Lang.get(55519),
		21415,
		17,
		705,
		{
			RTResTalkAction[46]
		}
	},
	[21415018] = {
		21415018,
		0,
		Lang.get(55520),
		21415,
		18,
		713,
		{
			RTResTalkAction[74],
			RTResTalkAction[63]
		}
	},
	[21415019] = {
		21415019,
		0,
		Lang.get(55521),
		21415,
		19,
		119,
		{
			RTResTalkAction[76],
			RTResTalkAction[48]
		}
	},
	[21415020] = {
		21415020,
		0,
		Lang.get(55522),
		21415,
		20,
		713,
		{
			RTResTalkAction[74],
			RTResTalkAction[62]
		}
	},
	[21415021] = {
		21415021,
		0,
		Lang.get(55523),
		21415,
		21,
		705,
		{
			RTResTalkAction[46],
			RTResTalkAction[65]
		}
	},
	[21415022] = {
		21415022,
		0,
		Lang.get(47261),
		21415,
		22,
		713,
		{
			RTResTalkAction[42],
			RTResTalkAction[64]
		}
	},
	[21415023] = {
		21415023,
		0,
		Lang.get(55524),
		21415,
		23,
		705,
		{
			RTResTalkAction[42],
			RTResTalkAction[64]
		}
	},
	[21415024] = {
		21415024,
		0,
		Lang.get(47263),
		21415,
		24,
		705,
		{
			RTResTalkAction[42],
			RTResTalkAction[64]
		}
	},
	[21415025] = {
		21415025,
		0,
		Lang.get(55525),
		21415,
		25,
		713,
		{
			RTResTalkAction[42],
			RTResTalkAction[64]
		}
	},
	[21415026] = {
		21415026,
		0,
		Lang.get(47265),
		21415,
		26,
		705,
		{
			RTResTalkAction[46],
			RTResTalkAction[65]
		}
	},
	[21415027] = {
		21415027,
		9,
		Lang.get(47266),
		21415,
		27,
		605,
		{
			RTResTalkAction[63]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		21505,
		nil,
		1,
		nil,
		1,
		nil,
		21505,
		nil,
		nil,
		1
	},
	[21415028] = {
		21415028,
		0,
		Lang.get(47267),
		21415,
		28,
		705,
		{
			RTResTalkAction[44]
		},
		nil,
		nil,
		3
	},
	[21415029] = {
		21415029,
		0,
		Lang.get(47268),
		21415,
		29,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21415030] = {
		21415030,
		0,
		Lang.get(55526),
		21415,
		30,
		705,
		{
			RTResTalkAction[55],
			RTResTalkAction[62]
		}
	},
	[21415031] = {
		21415031,
		0,
		Lang.get(55527),
		21415,
		31,
		713,
		{
			RTResTalkAction[74],
			RTResTalkAction[63]
		}
	},
	[21416001] = {
		21416001,
		0,
		Lang.get(47271),
		21416,
		1,
		119,
		nil,
		1,
		nil,
		nil,
		nil,
		150,
		21432,
		nil,
		nil,
		nil,
		1,
		nil,
		21432
	},
	[21416002] = {
		21416002,
		0,
		Lang.get(47272),
		21416,
		2,
		705,
		nil,
		1
	},
	[21416003] = {
		21416003,
		0,
		Lang.get(55528),
		21416,
		3,
		713,
		nil,
		1
	},
	[21416004] = {
		21416004,
		0,
		Lang.get(55529),
		21416,
		4,
		714,
		nil,
		1
	},
	[21416005] = {
		21416005,
		0,
		Lang.get(55530),
		21416,
		5,
		715,
		nil,
		1
	},
	[21416006] = {
		21416006,
		0,
		Lang.get(47276),
		21416,
		6,
		705,
		{
			RTResTalkAction[41]
		},
		nil,
		nil,
		3
	},
	[21416007] = {
		21416007,
		0,
		Lang.get(47277),
		21416,
		7,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21416008] = {
		21416008,
		0,
		Lang.get(55531),
		21416,
		8,
		705,
		{
			RTResTalkAction[61],
			RTResTalkAction[48]
		}
	},
	[21416009] = {
		21416009,
		0,
		Lang.get(55532),
		21416,
		9,
		705,
		{
			RTResTalkAction[60],
			RTResTalkAction[48]
		}
	},
	[21416010] = {
		21416010,
		0,
		Lang.get(47280),
		21416,
		10,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21416011] = {
		21416011,
		0,
		Lang.get(47546),
		21416,
		11,
		705,
		{
			RTResTalkAction[46],
			RTResTalkAction[62]
		}
	},
	[21416012] = {
		21416012,
		0,
		Lang.get(47282),
		21416,
		12,
		705,
		{
			RTResTalkAction[46]
		}
	},
	[21416013] = {
		21416013,
		0,
		"Yeah，let's party~",
		21416,
		13,
		713,
		{
			RTResTalkAction[42],
			RTResTalkAction[64]
		}
	},
	[21416014] = {
		21416014,
		0,
		Lang.get(55533),
		21416,
		14,
		703,
		{
			RTResTalkAction[63],
			RTResTalkAction[65]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		21433,
		nil,
		1,
		nil,
		1,
		nil,
		21433
	},
	[21416015] = {
		21416015,
		0,
		Lang.get(55534),
		21416,
		15,
		702,
		nil,
		1
	},
	[21416016] = {
		21416016,
		0,
		Lang.get(47285),
		21416,
		16,
		705,
		{
			RTResTalkAction[44]
		},
		nil,
		nil,
		3
	},
	[21416017] = {
		21416017,
		0,
		Lang.get(55535),
		21416,
		17,
		703,
		{
			RTResTalkAction[42],
			RTResTalkAction[3]
		}
	},
	[21416018] = {
		21416018,
		0,
		Lang.get(47287),
		21416,
		18,
		702,
		{
			RTResTalkAction[42],
			RTResTalkAction[9],
			RTResTalkAction[6]
		}
	},
	[21416019] = {
		21416019,
		0,
		Lang.get(47288),
		21416,
		19,
		705,
		{
			RTResTalkAction[41],
			RTResTalkAction[5]
		}
	},
	[21416020] = {
		21416020,
		0,
		Lang.get(55536),
		21416,
		20,
		703,
		{
			RTResTalkAction[42],
			RTResTalkAction[3]
		}
	},
	[21416021] = {
		21416021,
		0,
		Lang.get(55537),
		21416,
		21,
		705,
		{
			RTResTalkAction[42],
			RTResTalkAction[3]
		}
	},
	[21416022] = {
		21416022,
		0,
		Lang.get(55538),
		21416,
		22,
		702,
		{
			RTResTalkAction[42],
			RTResTalkAction[9],
			RTResTalkAction[6]
		}
	},
	[21416023] = {
		21416023,
		0,
		Lang.get(55539),
		21416,
		23,
		703,
		{
			RTResTalkAction[2],
			RTResTalkAction[3],
			RTResTalkAction[63]
		}
	},
	[21416024] = {
		21416024,
		0,
		Lang.get(47290),
		21416,
		24,
		119,
		{
			RTResTalkAction[70],
			RTResTalkAction[5],
			RTResTalkAction[6]
		}
	},
	[21416025] = {
		21416025,
		0,
		Lang.get(55540),
		21416,
		25,
		703,
		{
			RTResTalkAction[27],
			RTResTalkAction[62]
		}
	},
	[21416026] = {
		21416026,
		0,
		Lang.get(55541),
		21416,
		26,
		705,
		{
			RTResTalkAction[46],
			RTResTalkAction[6]
		}
	},
	[21416027] = {
		21416027,
		0,
		"Yeah！Yeah！Yeah！",
		21416,
		27,
		713,
		{
			RTResTalkAction[42],
			RTResTalkAction[64]
		}
	},
	[21417001] = {
		21417001,
		0,
		Lang.get(47293),
		21417,
		1,
		705,
		nil,
		1,
		nil,
		nil,
		nil,
		150,
		21434,
		nil,
		nil,
		nil,
		1,
		nil,
		21434
	},
	[21417002] = {
		21417002,
		0,
		Lang.get(47294),
		21417,
		2,
		703,
		nil,
		1
	},
	[21417003] = {
		21417003,
		0,
		Lang.get(47295),
		21417,
		3,
		705,
		{
			RTResTalkAction[46]
		},
		nil,
		nil,
		3
	},
	[21417004] = {
		21417004,
		0,
		Lang.get(47296),
		21417,
		4,
		702,
		{
			RTResTalkAction[42],
			RTResTalkAction[9]
		}
	},
	[21417005] = {
		21417005,
		0,
		Lang.get(47297),
		21417,
		5,
		705,
		{
			RTResTalkAction[41],
			RTResTalkAction[5]
		}
	},
	[21417006] = {
		21417006,
		0,
		Lang.get(55542),
		21417,
		6,
		703,
		{
			RTResTalkAction[42],
			RTResTalkAction[3]
		}
	},
	[21417007] = {
		21417007,
		0,
		Lang.get(47547),
		21417,
		7,
		705,
		{
			RTResTalkAction[44],
			RTResTalkAction[6]
		}
	},
	[21417008] = {
		21417008,
		0,
		Lang.get(55543),
		21417,
		8,
		702,
		{
			RTResTalkAction[42],
			RTResTalkAction[9]
		}
	},
	[21417009] = {
		21417009,
		0,
		Lang.get(55544),
		21417,
		9,
		705,
		{
			RTResTalkAction[46],
			RTResTalkAction[5]
		}
	},
	[21417010] = {
		21417010,
		0,
		Lang.get(55545),
		21417,
		10,
		702,
		{
			RTResTalkAction[42],
			RTResTalkAction[9]
		}
	},
	[21417011] = {
		21417011,
		0,
		Lang.get(55546),
		21417,
		11,
		703,
		{
			RTResTalkAction[2],
			RTResTalkAction[3],
			RTResTalkAction[63]
		}
	},
	[21417012] = {
		21417012,
		0,
		Lang.get(55547),
		21417,
		12,
		714,
		{
			RTResTalkAction[72],
			RTResTalkAction[5],
			RTResTalkAction[6]
		}
	},
	[21417013] = {
		21417013,
		0,
		Lang.get(55548),
		21417,
		13,
		703,
		{
			RTResTalkAction[73],
			RTResTalkAction[3]
		}
	},
	[21417014] = {
		21417014,
		0,
		Lang.get(55549),
		21417,
		14,
		119,
		{
			RTResTalkAction[70],
			RTResTalkAction[67],
			RTResTalkAction[6]
		}
	},
	[21417015] = {
		21417015,
		0,
		Lang.get(55550),
		21417,
		15,
		705,
		{
			RTResTalkAction[62]
		},
		1,
		nil,
		nil,
		nil,
		149,
		21435,
		nil,
		1,
		nil,
		1,
		nil,
		21435
	},
	[21417016] = {
		21417016,
		0,
		Lang.get(55551),
		21417,
		16,
		703,
		{
			RTResTalkAction[27]
		},
		nil,
		nil,
		3
	},
	[21417017] = {
		21417017,
		2,
		Lang.get(55552),
		21417,
		17,
		703,
		{
			RTResTalkAction[27]
		}
	},
	[21417018] = {
		21417018,
		0,
		Lang.get(47305),
		21417,
		18,
		713,
		{
			RTResTalkAction[36],
			RTResTalkAction[64]
		}
	},
	[21417019] = {
		21417019,
		0,
		Lang.get(55553),
		21417,
		19,
		705,
		{
			RTResTalkAction[46],
			RTResTalkAction[6],
			RTResTalkAction[65]
		}
	},
	[21417020] = {
		21417020,
		0,
		Lang.get(55554),
		21417,
		20,
		713,
		{
			RTResTalkAction[42],
			RTResTalkAction[64]
		}
	},
	[21417021] = {
		21417021,
		0,
		Lang.get(47548),
		21417,
		21,
		705,
		{
			RTResTalkAction[46],
			RTResTalkAction[65]
		}
	},
	[21417022] = {
		21417022,
		0,
		Lang.get(47309),
		21417,
		22,
		702,
		{
			RTResTalkAction[1],
			RTResTalkAction[63]
		}
	},
	[21417023] = {
		21417023,
		0,
		Lang.get(55555),
		21417,
		23,
		703,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[21417024] = {
		21417024,
		0,
		Lang.get(55556),
		21417,
		24,
		705,
		{
			RTResTalkAction[46],
			RTResTalkAction[5],
			RTResTalkAction[6]
		}
	},
	[21417025] = {
		21417025,
		2,
		Lang.get(55557),
		21417,
		25,
		703,
		{
			RTResTalkAction[27],
			RTResTalkAction[63]
		}
	},
	[21417026] = {
		21417026,
		2,
		Lang.get(55558),
		21417,
		26,
		703,
		{
			RTResTalkAction[27]
		}
	},
	[21417027] = {
		21417027,
		0,
		Lang.get(55559),
		21417,
		27,
		702,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[21417028] = {
		21417028,
		0,
		Lang.get(55560),
		21417,
		28,
		703,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[21417029] = {
		21417029,
		0,
		Lang.get(47312),
		21417,
		29,
		714,
		{
			RTResTalkAction[36],
			RTResTalkAction[66],
			RTResTalkAction[5]
		}
	},
	[21417030] = {
		21417030,
		5,
		Lang.get(55561),
		21417,
		30,
		703,
		{
			RTResTalkAction[36],
			RTResTalkAction[66]
		}
	},
	[21417031] = {
		21417031,
		0,
		Lang.get(47313),
		21417,
		31,
		705,
		{
			RTResTalkAction[46],
			RTResTalkAction[6],
			RTResTalkAction[67]
		}
	},
	[21417032] = {
		21417032,
		0,
		Lang.get(55562),
		21417,
		32,
		714,
		{
			RTResTalkAction[42],
			RTResTalkAction[66]
		}
	},
	[21417033] = {
		21417033,
		0,
		Lang.get(55563),
		21417,
		33,
		703,
		{
			RTResTalkAction[73],
			RTResTalkAction[3],
			RTResTalkAction[63]
		}
	},
	[21417034] = {
		21417034,
		0,
		Lang.get(55564),
		21417,
		34,
		119,
		{
			RTResTalkAction[70],
			RTResTalkAction[67],
			RTResTalkAction[6]
		}
	},
	[21417035] = {
		21417035,
		0,
		Lang.get(55565),
		21417,
		35,
		714,
		{
			RTResTalkAction[71],
			RTResTalkAction[66]
		}
	},
	[21417036] = {
		21417036,
		0,
		Lang.get(55566),
		21417,
		36,
		714,
		{
			RTResTalkAction[72],
			RTResTalkAction[62]
		}
	},
	[21417037] = {
		21417037,
		0,
		Lang.get(55567),
		21417,
		37,
		713,
		{
			RTResTalkAction[76],
			RTResTalkAction[66]
		}
	},
	[21417038] = {
		21417038,
		0,
		Lang.get(55568),
		21417,
		38,
		714,
		{
			RTResTalkAction[72],
			RTResTalkAction[65]
		}
	},
	[21417039] = {
		21417039,
		0,
		Lang.get(55569),
		21417,
		39,
		119,
		{
			RTResTalkAction[71],
			RTResTalkAction[66]
		}
	},
	[21417040] = {
		21417040,
		0,
		Lang.get(47315),
		21417,
		40,
		705,
		{
			RTResTalkAction[55],
			RTResTalkAction[62],
			RTResTalkAction[67]
		}
	},
	[21417041] = {
		21417041,
		0,
		Lang.get(47316),
		21417,
		41,
		702,
		{
			RTResTalkAction[1],
			RTResTalkAction[63]
		}
	},
	[21417042] = {
		21417042,
		0,
		Lang.get(47317),
		21417,
		42,
		703,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[21417043] = {
		21417043,
		0,
		Lang.get(47318),
		21417,
		43,
		705,
		{
			RTResTalkAction[5],
			RTResTalkAction[6]
		},
		1,
		2,
		nil,
		nil,
		nil,
		21436,
		nil,
		1,
		nil,
		1,
		nil,
		21436
	},
	[21417044] = {
		21417044,
		0,
		Lang.get(47319),
		21417,
		44,
		119,
		{
			RTResTalkAction[70]
		},
		nil,
		0,
		3
	},
	[21417045] = {
		21417045,
		0,
		Lang.get(47320),
		21417,
		45,
		713,
		{
			RTResTalkAction[71],
			RTResTalkAction[64]
		}
	},
	[21417046] = {
		21417046,
		0,
		Lang.get(47321),
		21417,
		46,
		706,
		{
			RTResTalkAction[62],
			RTResTalkAction[65]
		},
		1,
		0
	},
	[21417047] = {
		21417047,
		0,
		Lang.get(55570),
		21417,
		47,
		707,
		nil,
		1,
		0
	},
	[21417048] = {
		21417048,
		0,
		Lang.get(47322),
		21417,
		48,
		119,
		{
			RTResTalkAction[70]
		}
	},
	[21417049] = {
		21417049,
		0,
		Lang.get(55571),
		21417,
		49,
		703,
		{
			RTResTalkAction[27],
			RTResTalkAction[62]
		}
	},
	[21417050] = {
		21417050,
		0,
		Lang.get(47324),
		21417,
		50,
		705,
		{
			RTResTalkAction[41],
			RTResTalkAction[6]
		}
	},
	[21418001] = {
		21418001,
		0,
		Lang.get(47325),
		21418,
		1,
		119,
		nil,
		1,
		nil,
		nil,
		nil,
		47,
		21437,
		nil,
		nil,
		nil,
		1,
		nil,
		21437
	},
	[21418002] = {
		21418002,
		0,
		Lang.get(47326),
		21418,
		2,
		706,
		{
			RTResTalkAction[77]
		},
		nil,
		nil,
		3
	},
	[21418003] = {
		21418003,
		0,
		Lang.get(55572),
		21418,
		3,
		707,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[21418004] = {
		21418004,
		0,
		Lang.get(55573),
		21418,
		4,
		706,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[21418005] = {
		21418005,
		0,
		Lang.get(55574),
		21418,
		5,
		707,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[21418006] = {
		21418006,
		0,
		Lang.get(47328),
		21418,
		6,
		713,
		{
			RTResTalkAction[74],
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[21418007] = {
		21418007,
		0,
		Lang.get(55575),
		21418,
		7,
		706,
		{
			RTResTalkAction[77],
			RTResTalkAction[65]
		}
	},
	[21418008] = {
		21418008,
		0,
		Lang.get(47330),
		21418,
		8,
		706,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[21418009] = {
		21418009,
		0,
		Lang.get(55576),
		21418,
		9,
		707,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[21418010] = {
		21418010,
		0,
		Lang.get(55577),
		21418,
		10,
		706,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[21418011] = {
		21418011,
		5,
		Lang.get(55578),
		21418,
		11,
		707,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[21418012] = {
		21418012,
		0,
		Lang.get(55579),
		21418,
		12,
		705,
		{
			RTResTalkAction[46],
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[21418013] = {
		21418013,
		0,
		Lang.get(47333),
		21418,
		13,
		706,
		{
			RTResTalkAction[42],
			RTResTalkAction[78]
		}
	},
	[21418014] = {
		21418014,
		0,
		Lang.get(55580),
		21418,
		14,
		707,
		{
			RTResTalkAction[16],
			RTResTalkAction[17],
			RTResTalkAction[63]
		}
	},
	[21418015] = {
		21418015,
		0,
		Lang.get(55581),
		21418,
		15,
		705,
		{
			RTResTalkAction[42],
			RTResTalkAction[78],
			RTResTalkAction[19]
		}
	},
	[21418016] = {
		21418016,
		0,
		Lang.get(55582),
		21418,
		16,
		706,
		{
			RTResTalkAction[42],
			RTResTalkAction[78]
		}
	},
	[21418017] = {
		21418017,
		0,
		Lang.get(55583),
		21418,
		17,
		707,
		{
			RTResTalkAction[16],
			RTResTalkAction[17],
			RTResTalkAction[63]
		}
	},
	[21418018] = {
		21418018,
		0,
		Lang.get(47549),
		21418,
		18,
		705,
		{
			RTResTalkAction[46],
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[21419001] = {
		21419001,
		0,
		Lang.get(55584),
		21419,
		1,
		706,
		nil,
		1,
		nil,
		nil,
		nil,
		66,
		21438,
		nil,
		nil,
		nil,
		1,
		nil,
		21438
	},
	[21419002] = {
		21419002,
		0,
		Lang.get(55585),
		21419,
		2,
		707,
		{
			RTResTalkAction[79]
		},
		nil,
		nil,
		3
	},
	[21419003] = {
		21419003,
		0,
		Lang.get(55586),
		21419,
		3,
		706,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[21419004] = {
		21419004,
		0,
		Lang.get(55587),
		21419,
		4,
		707,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[21419005] = {
		21419005,
		0,
		Lang.get(55588),
		21419,
		5,
		705,
		{
			RTResTalkAction[41],
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[21419006] = {
		21419006,
		0,
		Lang.get(55589),
		21419,
		6,
		706,
		{
			RTResTalkAction[77],
			RTResTalkAction[63]
		}
	},
	[21419007] = {
		21419007,
		0,
		Lang.get(55590),
		21419,
		7,
		707,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[21419008] = {
		21419008,
		0,
		Lang.get(55591),
		21419,
		8,
		705,
		{
			RTResTalkAction[46],
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[21419009] = {
		21419009,
		0,
		Lang.get(47341),
		21419,
		9,
		706,
		{
			RTResTalkAction[77],
			RTResTalkAction[63]
		}
	},
	[21419010] = {
		21419010,
		0,
		Lang.get(55592),
		21419,
		10,
		707,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[21419011] = {
		21419011,
		0,
		Lang.get(47342),
		21419,
		11,
		705,
		{
			RTResTalkAction[46],
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[21419012] = {
		21419012,
		0,
		Lang.get(47343),
		21419,
		12,
		119,
		{
			RTResTalkAction[70],
			RTResTalkAction[63]
		}
	},
	[21419013] = {
		21419013,
		0,
		Lang.get(47344),
		21419,
		13,
		713,
		{
			RTResTalkAction[74],
			RTResTalkAction[62]
		}
	},
	[21419014] = {
		21419014,
		0,
		Lang.get(55593),
		21419,
		14,
		705,
		{
			RTResTalkAction[55],
			RTResTalkAction[65]
		}
	},
	[21419015] = {
		21419015,
		0,
		Lang.get(47346),
		21419,
		15,
		705,
		{
			RTResTalkAction[46]
		}
	},
	[21419016] = {
		21419016,
		5,
		"Party！Party！Party！Let's party！",
		21419,
		16,
		714,
		{
			RTResTalkAction[72],
			RTResTalkAction[63]
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
	[21419017] = {
		21419017,
		0,
		Lang.get(47347),
		21419,
		17,
		713,
		{
			RTResTalkAction[67]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		21439,
		nil,
		1,
		nil,
		1,
		nil,
		21439
	},
	[21419018] = {
		21419018,
		0,
		Lang.get(47348),
		21419,
		18,
		714,
		nil,
		1
	},
	[21419019] = {
		21419019,
		0,
		Lang.get(47349),
		21419,
		19,
		119,
		nil,
		1
	},
	[21419020] = {
		21419020,
		0,
		Lang.get(55594),
		21419,
		20,
		705,
		{
			RTResTalkAction[41]
		},
		nil,
		nil,
		3
	},
	[21419021] = {
		21419021,
		0,
		Lang.get(55595),
		21419,
		21,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21419022] = {
		21419022,
		0,
		Lang.get(47351),
		21419,
		22,
		127,
		{
			RTResTalkAction[80],
			RTResTalkAction[63],
			RTResTalkAction[62]
		}
	},
	[21419023] = {
		21419023,
		0,
		Lang.get(47352),
		21419,
		23,
		705,
		{
			RTResTalkAction[53],
			RTResTalkAction[30]
		}
	},
	[21419024] = {
		21419024,
		0,
		Lang.get(47353),
		21419,
		24,
		706,
		{
			RTResTalkAction[77],
			RTResTalkAction[63],
			RTResTalkAction[29]
		}
	},
	[21419025] = {
		21419025,
		0,
		Lang.get(55596),
		21419,
		25,
		707,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[21419026] = {
		21419026,
		0,
		Lang.get(55597),
		21419,
		26,
		706,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[21419027] = {
		21419027,
		0,
		Lang.get(55598),
		21419,
		27,
		707,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[21419028] = {
		21419028,
		0,
		Lang.get(47355),
		21419,
		28,
		127,
		{
			RTResTalkAction[81],
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[21419029] = {
		21419029,
		0,
		Lang.get(47356),
		21419,
		29,
		705,
		{
			RTResTalkAction[53],
			RTResTalkAction[30]
		}
	},
	[21419030] = {
		21419030,
		0,
		Lang.get(47357),
		21419,
		30,
		127,
		{
			RTResTalkAction[42],
			RTResTalkAction[28]
		}
	},
	[21420001] = {
		21420001,
		0,
		Lang.get(47358),
		21420,
		1,
		706,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		21440,
		nil,
		nil,
		nil,
		1,
		nil,
		21440
	},
	[21420002] = {
		21420002,
		0,
		Lang.get(55599),
		21420,
		2,
		707,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[21420003] = {
		21420003,
		0,
		Lang.get(47359),
		21420,
		3,
		112,
		{
			RTResTalkAction[32],
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[21420004] = {
		21420004,
		0,
		Lang.get(47360),
		21420,
		4,
		706,
		{
			RTResTalkAction[82],
			RTResTalkAction[78]
		}
	},
	[21420005] = {
		21420005,
		0,
		Lang.get(55600),
		21420,
		5,
		707,
		{
			RTResTalkAction[16],
			RTResTalkAction[17],
			RTResTalkAction[33]
		}
	},
	[21420006] = {
		21420006,
		0,
		Lang.get(47361),
		21420,
		6,
		127,
		{
			RTResTalkAction[81],
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[21420007] = {
		21420007,
		0,
		Lang.get(47362),
		21420,
		7,
		706,
		{
			RTResTalkAction[83],
			RTResTalkAction[78]
		}
	},
	[21420008] = {
		21420008,
		0,
		Lang.get(55601),
		21420,
		8,
		707,
		{
			RTResTalkAction[16],
			RTResTalkAction[17],
			RTResTalkAction[29]
		}
	},
	[21420009] = {
		21420009,
		0,
		Lang.get(47363),
		21420,
		9,
		119,
		{
			RTResTalkAction[70],
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[21420010] = {
		21420010,
		0,
		Lang.get(55602),
		21420,
		10,
		707,
		{
			RTResTalkAction[71],
			RTResTalkAction[17]
		}
	},
	[21420011] = {
		21420011,
		0,
		Lang.get(47364),
		21420,
		11,
		119,
		{
			RTResTalkAction[70],
			RTResTalkAction[19]
		}
	},
	[21420012] = {
		21420012,
		0,
		Lang.get(47365),
		21420,
		12,
		127,
		{
			RTResTalkAction[80],
			RTResTalkAction[62]
		}
	},
	[21420013] = {
		21420013,
		0,
		Lang.get(47366),
		21420,
		13,
		112,
		{
			RTResTalkAction[82],
			RTResTalkAction[30]
		}
	},
	[21420014] = {
		21420014,
		0,
		Lang.get(47367),
		21420,
		14,
		705,
		{
			RTResTalkAction[46],
			RTResTalkAction[33],
			RTResTalkAction[29]
		}
	},
	[21420015] = {
		21420015,
		0,
		Lang.get(55603),
		21420,
		15,
		713,
		{
			RTResTalkAction[74],
			RTResTalkAction[63]
		}
	},
	[21420016] = {
		21420016,
		0,
		Lang.get(55604),
		21420,
		16,
		714,
		{
			RTResTalkAction[72],
			RTResTalkAction[65]
		}
	},
	[21420017] = {
		21420017,
		0,
		Lang.get(55605),
		21420,
		17,
		715,
		{
			RTResTalkAction[75],
			RTResTalkAction[67]
		}
	},
	[21420018] = {
		21420018,
		0,
		Lang.get(47550),
		21420,
		18,
		705,
		{
			RTResTalkAction[55],
			RTResTalkAction[69]
		}
	},
	[21420019] = {
		21420019,
		0,
		Lang.get(47372),
		21420,
		19,
		714,
		{
			RTResTalkAction[72],
			RTResTalkAction[63]
		}
	},
	[21420020] = {
		21420020,
		0,
		Lang.get(55606),
		21420,
		20,
		703,
		{
			RTResTalkAction[67]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		21441,
		nil,
		1,
		nil,
		1,
		nil,
		21441
	},
	[21420021] = {
		21420021,
		0,
		Lang.get(55607),
		21420,
		21,
		702,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[21420022] = {
		21420022,
		0,
		Lang.get(55608),
		21420,
		22,
		703,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[21420023] = {
		21420023,
		0,
		Lang.get(55609),
		21420,
		23,
		702,
		{
			RTResTalkAction[1],
			RTResTalkAction[6]
		}
	},
	[21420024] = {
		21420024,
		0,
		Lang.get(47377),
		21420,
		24,
		705,
		{
			RTResTalkAction[41],
			RTResTalkAction[5]
		}
	},
	[21420025] = {
		21420025,
		0,
		Lang.get(55610),
		21420,
		25,
		703,
		{
			RTResTalkAction[42],
			RTResTalkAction[3]
		}
	},
	[21420026] = {
		21420026,
		0,
		Lang.get(47379),
		21420,
		26,
		705,
		{
			RTResTalkAction[61],
			RTResTalkAction[3]
		}
	},
	[21420027] = {
		21420027,
		0,
		Lang.get(55611),
		21420,
		27,
		703,
		{
			RTResTalkAction[42],
			RTResTalkAction[3]
		}
	},
	[21420028] = {
		21420028,
		0,
		Lang.get(55612),
		21420,
		28,
		702,
		{
			RTResTalkAction[42],
			RTResTalkAction[9],
			RTResTalkAction[6]
		}
	},
	[21420029] = {
		21420029,
		0,
		Lang.get(47551),
		21420,
		29,
		705,
		{
			RTResTalkAction[46],
			RTResTalkAction[5]
		}
	},
	[21420030] = {
		21420030,
		0,
		Lang.get(47383),
		21420,
		30,
		705,
		{
			RTResTalkAction[41]
		}
	},
	[21420031] = {
		21420031,
		0,
		Lang.get(55613),
		21420,
		31,
		702,
		{
			RTResTalkAction[1],
			RTResTalkAction[63]
		}
	},
	[21421001] = {
		21421001,
		0,
		Lang.get(47385),
		21421,
		1,
		127,
		nil,
		1,
		1,
		nil,
		nil,
		62,
		21442,
		nil,
		nil,
		nil,
		nil,
		nil,
		21442
	},
	[21421002] = {
		21421002,
		0,
		Lang.get(55614),
		21421,
		2,
		705,
		{
			RTResTalkAction[55]
		},
		nil,
		0,
		3
	},
	[21421003] = {
		21421003,
		0,
		Lang.get(55615),
		21421,
		3,
		705,
		{
			RTResTalkAction[46]
		}
	},
	[21421004] = {
		21421004,
		0,
		Lang.get(55616),
		21421,
		4,
		703,
		{
			RTResTalkAction[42],
			RTResTalkAction[3]
		}
	},
	[21421005] = {
		21421005,
		0,
		Lang.get(55617),
		21421,
		5,
		705,
		{
			RTResTalkAction[42],
			RTResTalkAction[3]
		}
	},
	[21421006] = {
		21421006,
		0,
		Lang.get(55618),
		21421,
		6,
		703,
		{
			RTResTalkAction[42],
			RTResTalkAction[3]
		}
	},
	[21421007] = {
		21421007,
		0,
		Lang.get(55619),
		21421,
		7,
		702,
		{
			RTResTalkAction[1],
			RTResTalkAction[63],
			RTResTalkAction[6]
		}
	},
	[21421008] = {
		21421008,
		0,
		Lang.get(55620),
		21421,
		8,
		705,
		{
			RTResTalkAction[42],
			RTResTalkAction[9]
		}
	},
	[21421009] = {
		21421009,
		0,
		Lang.get(47392),
		21421,
		9,
		702,
		{
			RTResTalkAction[42],
			RTResTalkAction[9]
		}
	},
	[21421010] = {
		21421010,
		0,
		Lang.get(47393),
		21421,
		10,
		127,
		{
			RTResTalkAction[42],
			RTResTalkAction[30],
			RTResTalkAction[5]
		}
	},
	[21421011] = {
		21421011,
		0,
		Lang.get(47394),
		21421,
		11,
		705,
		{
			RTResTalkAction[61],
			RTResTalkAction[30]
		}
	},
	[21421012] = {
		21421012,
		0,
		Lang.get(47395),
		21421,
		12,
		127,
		{
			RTResTalkAction[42],
			RTResTalkAction[28]
		}
	},
	[21421013] = {
		21421013,
		0,
		Lang.get(55621),
		21421,
		13,
		705,
		{
			RTResTalkAction[53],
			RTResTalkAction[30]
		}
	},
	[21421014] = {
		21421014,
		0,
		Lang.get(47397),
		21421,
		14,
		127,
		{
			RTResTalkAction[42],
			RTResTalkAction[30]
		}
	},
	[21421015] = {
		21421015,
		0,
		Lang.get(47398),
		21421,
		15,
		119,
		{
			RTResTalkAction[63],
			RTResTalkAction[29]
		},
		1,
		0,
		nil,
		nil,
		nil,
		21443,
		nil,
		1,
		nil,
		nil,
		nil,
		21443
	},
	[21421016] = {
		21421016,
		0,
		Lang.get(47399),
		21421,
		16,
		705,
		{
			RTResTalkAction[44]
		},
		nil,
		nil,
		3
	},
	[21421017] = {
		21421017,
		0,
		Lang.get(47400),
		21421,
		17,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[48]
		}
	},
	[21421018] = {
		21421018,
		0,
		Lang.get(47401),
		21421,
		18,
		713,
		{
			RTResTalkAction[42],
			RTResTalkAction[64],
			RTResTalkAction[62]
		}
	},
	[21421019] = {
		21421019,
		0,
		Lang.get(47402),
		21421,
		19,
		119,
		{
			RTResTalkAction[71],
			RTResTalkAction[64],
			RTResTalkAction[63]
		}
	},
	[21421020] = {
		21421020,
		0,
		Lang.get(47403),
		21421,
		20,
		713,
		{
			RTResTalkAction[71],
			RTResTalkAction[64]
		}
	},
	[21421021] = {
		21421021,
		0,
		Lang.get(47404),
		21421,
		21,
		705,
		{
			RTResTalkAction[55],
			RTResTalkAction[62],
			RTResTalkAction[65]
		}
	},
	[21421022] = {
		21421022,
		9,
		Lang.get(55622),
		21421,
		22,
		605,
		{
			RTResTalkAction[63]
		},
		nil,
		nil,
		nil,
		nil,
		57,
		21455,
		nil,
		nil,
		nil,
		1,
		nil,
		21455,
		nil,
		nil,
		1
	},
	[21421023] = {
		21421023,
		0,
		Lang.get(55623),
		21421,
		23,
		112,
		{
			RTResTalkAction[32]
		},
		nil,
		nil,
		3
	},
	[21421024] = {
		21421024,
		0,
		Lang.get(55624),
		21421,
		24,
		706,
		{
			RTResTalkAction[16],
			RTResTalkAction[17],
			RTResTalkAction[33]
		}
	},
	[21421025] = {
		21421025,
		0,
		Lang.get(55625),
		21421,
		25,
		707,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[21421026] = {
		21421026,
		0,
		Lang.get(55626),
		21421,
		26,
		112,
		{
			RTResTalkAction[32],
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[21421027] = {
		21421027,
		0,
		Lang.get(55627),
		21421,
		27,
		706,
		{
			RTResTalkAction[16],
			RTResTalkAction[17],
			RTResTalkAction[33]
		}
	},
	[21421028] = {
		21421028,
		0,
		Lang.get(55628),
		21421,
		28,
		707,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[21421029] = {
		21421029,
		0,
		Lang.get(55629),
		21421,
		29,
		112,
		{
			RTResTalkAction[32],
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[21421030] = {
		21421030,
		0,
		Lang.get(55630),
		21421,
		30,
		302,
		{
			RTResTalkAction[82],
			RTResTalkAction[84]
		}
	},
	[21421031] = {
		21421031,
		0,
		Lang.get(55631),
		21421,
		31,
		112,
		{
			RTResTalkAction[82],
			RTResTalkAction[84]
		}
	},
	[21421032] = {
		21421032,
		0,
		Lang.get(55632),
		21421,
		32,
		302,
		{
			RTResTalkAction[85],
			RTResTalkAction[33]
		}
	},
	[21422001] = {
		21422001,
		0,
		Lang.get(47405),
		21422,
		1,
		708,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		21444,
		nil,
		nil,
		nil,
		nil,
		nil,
		21444
	},
	[21422002] = {
		21422002,
		0,
		Lang.get(47406),
		21422,
		2,
		710,
		nil,
		1
	},
	[21422003] = {
		21422003,
		0,
		Lang.get(47407),
		21422,
		3,
		709,
		nil,
		1
	},
	[21422004] = {
		21422004,
		0,
		Lang.get(47408),
		21422,
		4,
		708,
		nil,
		1
	},
	[21422005] = {
		21422005,
		0,
		Lang.get(47409),
		21422,
		5,
		709,
		nil,
		1
	},
	[21422006] = {
		21422006,
		0,
		Lang.get(47410),
		21422,
		6,
		710,
		nil,
		1
	},
	[21422007] = {
		21422007,
		0,
		Lang.get(47411),
		21422,
		7,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		21445,
		[19] = 21445
	},
	[21422008] = {
		21422008,
		0,
		Lang.get(47412),
		21422,
		8,
		141,
		{
			RTResTalkAction[86]
		},
		nil,
		nil,
		3
	},
	[21422009] = {
		21422009,
		0,
		Lang.get(47413),
		21422,
		9,
		107,
		{
			RTResTalkAction[87],
			RTResTalkAction[88]
		}
	},
	[21422010] = {
		21422010,
		0,
		Lang.get(47414),
		21422,
		10,
		141,
		{
			RTResTalkAction[87],
			RTResTalkAction[88]
		}
	},
	[21422011] = {
		21422011,
		0,
		Lang.get(47415),
		21422,
		11,
		107,
		{
			RTResTalkAction[87],
			RTResTalkAction[88]
		}
	},
	[21422012] = {
		21422012,
		0,
		Lang.get(47416),
		21422,
		12,
		141,
		{
			RTResTalkAction[87],
			RTResTalkAction[88]
		}
	},
	[21422013] = {
		21422013,
		0,
		Lang.get(47417),
		21422,
		13,
		107,
		{
			RTResTalkAction[87],
			RTResTalkAction[88]
		}
	},
	[21422014] = {
		21422014,
		0,
		Lang.get(47951),
		21422,
		14,
		141,
		{
			RTResTalkAction[87],
			RTResTalkAction[88]
		}
	},
	[21422015] = {
		21422015,
		0,
		Lang.get(47419),
		21422,
		15,
		107,
		{
			RTResTalkAction[87],
			RTResTalkAction[88]
		}
	},
	[21422016] = {
		21422016,
		9,
		Lang.get(55633),
		21422,
		16,
		605,
		{
			RTResTalkAction[89],
			RTResTalkAction[90]
		},
		nil,
		nil,
		nil,
		nil,
		57,
		21456,
		nil,
		nil,
		nil,
		1,
		nil,
		21456,
		nil,
		nil,
		1
	},
	[21422017] = {
		21422017,
		0,
		Lang.get(55634),
		21422,
		17,
		347,
		nil,
		1,
		0
	},
	[21422018] = {
		21422018,
		0,
		Lang.get(55635),
		21422,
		18,
		302,
		{
			RTResTalkAction[85]
		},
		nil,
		nil,
		3
	},
	[21422019] = {
		21422019,
		0,
		Lang.get(55636),
		21422,
		19,
		347,
		{
			RTResTalkAction[91]
		},
		1,
		0
	},
	[21422020] = {
		21422020,
		0,
		Lang.get(55637),
		21422,
		20,
		302,
		{
			RTResTalkAction[85]
		}
	},
	[21422021] = {
		21422021,
		0,
		Lang.get(55638),
		21422,
		21,
		347,
		{
			RTResTalkAction[91]
		},
		1,
		0
	},
	[21422022] = {
		21422022,
		0,
		Lang.get(55639),
		21422,
		22,
		347,
		nil,
		1,
		0
	},
	[21422023] = {
		21422023,
		0,
		Lang.get(55640),
		21422,
		23,
		302,
		{
			RTResTalkAction[85]
		}
	},
	[21422024] = {
		21422024,
		0,
		Lang.get(55641),
		21422,
		24,
		347,
		{
			RTResTalkAction[91]
		},
		1,
		0
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
