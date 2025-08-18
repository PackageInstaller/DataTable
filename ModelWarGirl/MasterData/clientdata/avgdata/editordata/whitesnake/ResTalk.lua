-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\WhiteSnake\\ResTalk.lua

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
	292,
	nil,
	nil,
	2
}
RTResTalkAction[2] = {
	[1] = 1,
	[2] = 292
}
RTResTalkAction[3] = {
	[1] = 0,
	[2] = 292
}
RTResTalkAction[4] = {
	2,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[5] = {
	[1] = 3,
	[2] = 292
}
RTResTalkAction[6] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[7] = {
	3,
	292,
	nil,
	nil,
	0
}
RTResTalkAction[8] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[9] = {
	[1] = 1,
	[2] = 1196
}
RTResTalkAction[10] = {
	[1] = 2,
	[2] = 1196
}
RTResTalkAction[11] = {
	[1] = 3,
	[2] = 815
}
RTResTalkAction[12] = {
	[1] = 2,
	[2] = 1197
}
RTResTalkAction[13] = {
	[1] = 0,
	[2] = 1196
}
RTResTalkAction[14] = {
	[1] = 1,
	[2] = 815
}
RTResTalkAction[15] = {
	[1] = 0,
	[2] = 1197
}
RTResTalkAction[16] = {
	[1] = 0,
	[2] = 815
}
RTResTalkAction[17] = {
	[1] = 1,
	[2] = 1197
}
RTResTalkAction[18] = {
	[1] = 3,
	[2] = 1197
}
RTResTalkAction[19] = {
	[1] = 1,
	[2] = 817
}
RTResTalkAction[20] = {
	[1] = 3,
	[2] = 817
}
RTResTalkAction[21] = {
	[1] = 0,
	[2] = 817
}
RTResTalkAction[22] = {
	[1] = 1,
	[2] = 818
}
RTResTalkAction[23] = {
	[1] = 3,
	[2] = 818
}
RTResTalkAction[24] = {
	[1] = 0,
	[2] = 818
}
RTResTalkAction[25] = {
	[1] = 1,
	[2] = 819
}
RTResTalkAction[26] = {
	[1] = 2,
	[2] = 819
}
RTResTalkAction[27] = {
	[1] = 0,
	[2] = 819
}
RTResTalkAction[28] = {
	1,
	195,
	nil,
	nil,
	2
}
RTResTalkAction[29] = {
	1,
	195,
	nil,
	nil,
	3
}
RTResTalkAction[30] = {
	[1] = 0,
	[2] = 195
}
RTResTalkAction[31] = {
	1,
	292,
	nil,
	nil,
	1
}
RTResTalkAction[32] = {
	2,
	107,
	nil,
	nil,
	5
}
RTResTalkAction[33] = {
	2,
	107,
	nil,
	nil,
	7
}
RTResTalkAction[34] = {
	3,
	292,
	nil,
	nil,
	1
}
RTResTalkAction[35] = {
	2,
	107,
	nil,
	nil,
	10
}
RTResTalkAction[36] = {
	1,
	292,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[37] = {
	1,
	292,
	nil,
	nil,
	0
}
RTResTalkAction[38] = {
	1,
	1197,
	nil,
	nil,
	0
}
RTResTalkAction[39] = {
	1,
	196,
	nil,
	nil,
	4
}
RTResTalkAction[40] = {
	1,
	1196,
	nil,
	nil,
	0
}
RTResTalkAction[41] = {
	[1] = 0,
	[2] = 196
}
RTResTalkAction[42] = {
	1,
	196,
	nil,
	nil,
	1
}
RTResTalkAction[43] = {
	1,
	196,
	nil,
	nil,
	2
}
RTResTalkAction[44] = {
	1,
	196,
	nil,
	nil,
	3
}
RTResTalkAction[45] = {
	[1] = 2,
	[2] = 196
}
RTResTalkAction[46] = {
	[1] = 3,
	[2] = 1196
}
RTResTalkAction[47] = {
	2,
	196,
	nil,
	nil,
	2
}
RTResTalkAction[48] = {
	2,
	1196,
	nil,
	nil,
	0
}
RTResTalkAction[49] = {
	2,
	196,
	nil,
	nil,
	3
}
RTResTalkAction[50] = {
	2,
	196,
	nil,
	nil,
	1
}
RTResTalkAction[51] = {
	[1] = 2,
	[2] = 820
}
RTResTalkAction[52] = {
	[1] = 3,
	[2] = 821
}
RTResTalkAction[53] = {
	[1] = 0,
	[2] = 820
}
RTResTalkAction[54] = {
	[1] = 0,
	[2] = 821
}
RTResTalkAction[55] = {
	[1] = 2,
	[2] = 107,
	[3] = {
		1
	}
}
RTResTalkAction[56] = {
	2,
	196,
	nil,
	nil,
	4
}
RTResTalkAction[57] = {
	3,
	1196,
	nil,
	nil,
	0
}
RTResTalkAction[58] = {
	[1] = 1,
	[2] = 1196,
	[3] = {
		1
	}
}
RTResTalkAction[59] = {
	2,
	292,
	nil,
	nil,
	1
}
RTResTalkAction[60] = {
	2,
	292,
	nil,
	nil,
	0
}
RTResTalkAction[61] = {
	2,
	292,
	nil,
	nil,
	2
}
RTResTalkAction[62] = {
	[1] = 2,
	[2] = 292
}
RTResTalkAction[63] = {
	3,
	292,
	nil,
	nil,
	2
}
RTResTalkAction[64] = {
	2,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[65] = {
	2,
	107,
	nil,
	nil,
	4
}
RTResTalkAction[66] = {
	[1] = 3,
	[2] = 196
}
RTResTalkAction[67] = {
	3,
	196,
	nil,
	nil,
	2
}
RTResTalkAction[68] = {
	3,
	196,
	nil,
	nil,
	3
}
RTResTalkAction[69] = {
	3,
	196,
	nil,
	nil,
	4
}
RTResTalkAction[70] = {
	1,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[71] = {
	1,
	107,
	nil,
	nil,
	10
}
RTResTalkAction[72] = {
	3,
	292,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[73] = {
	[1] = 1,
	[2] = 823
}
RTResTalkAction[74] = {
	[1] = 0,
	[2] = 823
}
RTResTalkAction[75] = {
	[1] = 2,
	[2] = 823
}
RTResTalkAction[76] = {
	[1] = 3,
	[2] = 824
}
RTResTalkAction[77] = {
	[1] = 0,
	[2] = 824
}
RTResTalkAction[78] = {
	[1] = 1,
	[2] = 824
}
RTResTalkAction[79] = {
	[1] = 2,
	[2] = 824
}
RTResTalkAction[80] = {
	1,
	107,
	nil,
	nil,
	5
}
RTResTalkAction[81] = {
	[1] = 3,
	[2] = 107
}
RTResTalkAction[82] = {
	[1] = 1,
	[2] = 825
}
RTResTalkAction[83] = {
	[1] = 1,
	[2] = 826
}
RTResTalkAction[84] = {
	[1] = 0,
	[2] = 825
}
RTResTalkAction[85] = {
	[1] = 0,
	[2] = 826
}
RTResTalkAction[86] = {
	[1] = 1,
	[2] = 425
}
RTResTalkAction[87] = {
	[1] = 0,
	[2] = 425
}

local Data = {
	[36301001] = {
		36301001,
		10,
		"84",
		36301,
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		nil,
		nil,
		1,
		[20] = 255
	},
	[36301002] = {
		36301002,
		0,
		Lang.get(95372),
		36301,
		2,
		196,
		nil,
		1,
		3
	},
	[36301003] = {
		36301003,
		0,
		Lang.get(95373),
		36301,
		3,
		196,
		nil,
		1,
		4
	},
	[36301004] = {
		36301004,
		0,
		Lang.get(95374),
		36301,
		4,
		292,
		{
			RTResTalkAction[1]
		},
		nil,
		0,
		3,
		nil,
		62,
		36301,
		nil,
		1,
		nil,
		1,
		nil,
		36301,
		-1
	},
	[36301005] = {
		36301005,
		0,
		Lang.get(95375),
		36301,
		5,
		292,
		{
			RTResTalkAction[2]
		}
	},
	[36301006] = {
		36301006,
		0,
		Lang.get(95376),
		36301,
		6,
		300,
		{
			RTResTalkAction[3]
		}
	},
	[36301007] = {
		36301007,
		0,
		Lang.get(95377),
		36301,
		7,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[36301008] = {
		36301008,
		0,
		Lang.get(95378),
		36301,
		8,
		292,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[36301009] = {
		36301009,
		0,
		Lang.get(95379),
		36301,
		9,
		292,
		{
			RTResTalkAction[1],
			RTResTalkAction[8]
		}
	},
	[36301010] = {
		36301010,
		0,
		Lang.get(95380),
		36301,
		10,
		300,
		{
			RTResTalkAction[3]
		}
	},
	[36301011] = {
		36301011,
		0,
		Lang.get(95381),
		36301,
		11,
		196,
		nil,
		1,
		0
	},
	[36301012] = {
		36301012,
		0,
		Lang.get(95382),
		36301,
		12,
		813,
		nil,
		1,
		0,
		nil,
		nil,
		199,
		nil,
		nil,
		1,
		nil,
		1,
		nil,
		36302
	},
	[36301013] = {
		36301013,
		0,
		Lang.get(95383),
		36301,
		13,
		814,
		nil,
		1
	},
	[36301014] = {
		36301014,
		0,
		Lang.get(95384),
		36301,
		14,
		813,
		nil,
		1
	},
	[36301015] = {
		36301015,
		0,
		Lang.get(95385),
		36301,
		15,
		1197,
		nil,
		1
	},
	[36301016] = {
		36301016,
		0,
		Lang.get(95386),
		36301,
		16,
		1196,
		nil,
		1
	},
	[36301017] = {
		36301017,
		7,
		"104",
		36301,
		17,
		1196,
		nil,
		1,
		nil,
		5,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[36301018] = {
		36301018,
		0,
		Lang.get(95387),
		36301,
		18,
		1196,
		nil,
		1,
		nil,
		-1
	},
	[36301019] = {
		36301019,
		0,
		Lang.get(95388),
		36301,
		19,
		1197,
		nil,
		1
	},
	[36301020] = {
		36301020,
		7,
		"105",
		36301,
		20,
		1197,
		nil,
		1,
		nil,
		5,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[36301021] = {
		36301021,
		0,
		Lang.get(95389),
		36301,
		21,
		816,
		nil,
		1,
		nil,
		-1
	},
	[36301022] = {
		36301022,
		0,
		Lang.get(95390),
		36301,
		22,
		1196,
		nil,
		1
	},
	[36301023] = {
		36301023,
		0,
		Lang.get(95391),
		36301,
		23,
		815,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		36303,
		nil,
		1,
		nil,
		1,
		nil,
		36303
	},
	[36301024] = {
		36301024,
		0,
		Lang.get(95392),
		36301,
		24,
		1196,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[36301025] = {
		36301025,
		0,
		Lang.get(95393),
		36301,
		25,
		815,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[36301026] = {
		36301026,
		0,
		Lang.get(95394),
		36301,
		26,
		1197,
		{
			RTResTalkAction[12],
			RTResTalkAction[11],
			RTResTalkAction[13]
		}
	},
	[36301027] = {
		36301027,
		0,
		Lang.get(95395),
		36301,
		27,
		815,
		{
			RTResTalkAction[14],
			RTResTalkAction[15]
		}
	},
	[36301028] = {
		36301028,
		3,
		Lang.get(95396),
		36301,
		28,
		605,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		36304,
		nil,
		1,
		nil,
		1,
		nil,
		36304,
		nil,
		nil,
		1
	},
	[36301029] = {
		36301029,
		0,
		Lang.get(95397),
		36301,
		29,
		1197,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[36301030] = {
		36301030,
		0,
		Lang.get(95398),
		36301,
		30,
		1196,
		{
			RTResTalkAction[10],
			RTResTalkAction[18]
		}
	},
	[36302001] = {
		36302001,
		0,
		Lang.get(95399),
		36302,
		1,
		1196,
		nil,
		1,
		nil,
		nil,
		nil,
		191,
		36305,
		nil,
		1,
		nil,
		1,
		nil,
		36305
	},
	[36302002] = {
		36302002,
		0,
		Lang.get(95400),
		36302,
		2,
		1197,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[36302003] = {
		36302003,
		0,
		Lang.get(95401),
		36302,
		3,
		1196,
		{
			RTResTalkAction[10],
			RTResTalkAction[18]
		}
	},
	[36302004] = {
		36302004,
		0,
		Lang.get(95402),
		36302,
		4,
		1197,
		{
			RTResTalkAction[10],
			RTResTalkAction[18]
		}
	},
	[36302005] = {
		36302005,
		0,
		Lang.get(95403),
		36302,
		5,
		817,
		{
			RTResTalkAction[19],
			RTResTalkAction[13],
			RTResTalkAction[15]
		}
	},
	[36302006] = {
		36302006,
		0,
		Lang.get(95404),
		36302,
		6,
		1196,
		{
			RTResTalkAction[10],
			RTResTalkAction[20]
		}
	},
	[36302007] = {
		36302007,
		0,
		Lang.get(95405),
		36302,
		7,
		1197,
		{
			RTResTalkAction[17],
			RTResTalkAction[13],
			RTResTalkAction[21]
		}
	},
	[36302008] = {
		36302008,
		0,
		Lang.get(95406),
		36302,
		8,
		817,
		{
			RTResTalkAction[12],
			RTResTalkAction[20]
		}
	},
	[36302009] = {
		36302009,
		0,
		Lang.get(95407),
		36302,
		9,
		1197,
		{
			RTResTalkAction[12],
			RTResTalkAction[20]
		}
	},
	[36302010] = {
		36302010,
		3,
		Lang.get(95408),
		36302,
		10,
		605,
		{
			RTResTalkAction[15],
			RTResTalkAction[21]
		},
		[22] = 1
	},
	[36302011] = {
		36302011,
		0,
		Lang.get(95409),
		36302,
		11,
		817,
		{
			RTResTalkAction[12],
			RTResTalkAction[20]
		}
	},
	[36302012] = {
		36302012,
		0,
		Lang.get(95410),
		36302,
		12,
		1197,
		{
			RTResTalkAction[12],
			RTResTalkAction[20]
		}
	},
	[36302013] = {
		36302013,
		5,
		Lang.get(95411),
		36302,
		13,
		818,
		{
			RTResTalkAction[22],
			RTResTalkAction[15],
			RTResTalkAction[21]
		}
	},
	[36303001] = {
		36303001,
		0,
		Lang.get(95412),
		36303,
		1,
		1197,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		36306,
		nil,
		1,
		nil,
		1,
		nil,
		36306
	},
	[36303002] = {
		36303002,
		0,
		Lang.get(95413),
		36303,
		2,
		818,
		{
			RTResTalkAction[22]
		},
		nil,
		nil,
		3
	},
	[36303003] = {
		36303003,
		0,
		Lang.get(95414),
		36303,
		3,
		1197,
		{
			RTResTalkAction[12],
			RTResTalkAction[23]
		}
	},
	[36303004] = {
		36303004,
		0,
		Lang.get(95415),
		36303,
		4,
		1196,
		{
			RTResTalkAction[9],
			RTResTalkAction[15],
			RTResTalkAction[24]
		}
	},
	[36303005] = {
		36303005,
		0,
		Lang.get(95416),
		36303,
		5,
		1196,
		{
			RTResTalkAction[9]
		}
	},
	[36303006] = {
		36303006,
		0,
		Lang.get(95417),
		36303,
		6,
		1196,
		{
			RTResTalkAction[9]
		}
	},
	[36303007] = {
		36303007,
		0,
		Lang.get(95418),
		36303,
		7,
		818,
		{
			RTResTalkAction[10],
			RTResTalkAction[23]
		}
	},
	[36303008] = {
		36303008,
		0,
		Lang.get(95419),
		36303,
		8,
		1196,
		{
			RTResTalkAction[10],
			RTResTalkAction[23]
		}
	},
	[36303009] = {
		36303009,
		0,
		Lang.get(95420),
		36303,
		9,
		818,
		{
			RTResTalkAction[10],
			RTResTalkAction[23]
		}
	},
	[36303010] = {
		36303010,
		0,
		Lang.get(95421),
		36303,
		10,
		1197,
		{
			RTResTalkAction[17],
			RTResTalkAction[13],
			RTResTalkAction[24]
		}
	},
	[36303011] = {
		36303011,
		0,
		Lang.get(95422),
		36303,
		11,
		1196,
		{
			RTResTalkAction[10],
			RTResTalkAction[18]
		}
	},
	[36303012] = {
		36303012,
		0,
		Lang.get(95423),
		36303,
		12,
		817,
		{
			RTResTalkAction[19],
			RTResTalkAction[13],
			RTResTalkAction[15]
		}
	},
	[36303013] = {
		36303013,
		0,
		Lang.get(95424),
		36303,
		13,
		196,
		{
			RTResTalkAction[21]
		},
		1,
		2,
		nil,
		nil,
		nil,
		36307,
		nil,
		1,
		nil,
		1,
		nil,
		36307
	},
	[36304001] = {
		36304001,
		0,
		Lang.get(95425),
		36304,
		1,
		1197,
		nil,
		1,
		0,
		nil,
		nil,
		60,
		36308,
		nil,
		1,
		nil,
		1,
		nil,
		36308
	},
	[36304002] = {
		36304002,
		0,
		Lang.get(95426),
		36304,
		2,
		1196,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[36304003] = {
		36304003,
		0,
		Lang.get(95427),
		36304,
		3,
		1196,
		{
			RTResTalkAction[9]
		}
	},
	[36304004] = {
		36304004,
		0,
		Lang.get(95428),
		36304,
		4,
		1197,
		{
			RTResTalkAction[10],
			RTResTalkAction[18]
		}
	},
	[36304005] = {
		36304005,
		0,
		Lang.get(95429),
		36304,
		5,
		818,
		{
			RTResTalkAction[22],
			RTResTalkAction[13],
			RTResTalkAction[15]
		}
	},
	[36304006] = {
		36304006,
		0,
		Lang.get(95430),
		36304,
		6,
		1196,
		{
			RTResTalkAction[10],
			RTResTalkAction[23]
		}
	},
	[36304007] = {
		36304007,
		0,
		Lang.get(95431),
		36304,
		7,
		818,
		{
			RTResTalkAction[10],
			RTResTalkAction[23]
		}
	},
	[36304008] = {
		36304008,
		0,
		Lang.get(95432),
		36304,
		8,
		818,
		{
			RTResTalkAction[22],
			RTResTalkAction[13]
		}
	},
	[36304009] = {
		36304009,
		0,
		Lang.get(95433),
		36304,
		9,
		1197,
		{
			RTResTalkAction[12],
			RTResTalkAction[23]
		}
	},
	[36304010] = {
		36304010,
		0,
		Lang.get(95434),
		36304,
		10,
		818,
		{
			RTResTalkAction[15],
			RTResTalkAction[24]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		36309,
		nil,
		1,
		nil,
		1,
		nil,
		36309
	},
	[36304011] = {
		36304011,
		0,
		Lang.get(95435),
		36304,
		11,
		818,
		{
			RTResTalkAction[22]
		},
		nil,
		nil,
		3
	},
	[36304012] = {
		36304012,
		0,
		Lang.get(95436),
		36304,
		12,
		818,
		{
			RTResTalkAction[22]
		}
	},
	[36304013] = {
		36304013,
		0,
		Lang.get(95437),
		36304,
		13,
		1196,
		{
			RTResTalkAction[10],
			RTResTalkAction[23]
		}
	},
	[36304014] = {
		36304014,
		0,
		Lang.get(95438),
		36304,
		14,
		818,
		{
			RTResTalkAction[10],
			RTResTalkAction[23]
		}
	},
	[36304015] = {
		36304015,
		0,
		Lang.get(95439),
		36304,
		15,
		818,
		{
			RTResTalkAction[10],
			RTResTalkAction[23]
		}
	},
	[36304016] = {
		36304016,
		0,
		Lang.get(95440),
		36304,
		16,
		1196,
		{
			RTResTalkAction[10],
			RTResTalkAction[23]
		}
	},
	[36304017] = {
		36304017,
		0,
		Lang.get(95441),
		36304,
		17,
		818,
		{
			RTResTalkAction[10],
			RTResTalkAction[23]
		}
	},
	[36304018] = {
		36304018,
		0,
		Lang.get(95442),
		36304,
		18,
		817,
		{
			RTResTalkAction[19],
			RTResTalkAction[13],
			RTResTalkAction[24]
		}
	},
	[36305001] = {
		36305001,
		0,
		Lang.get(95443),
		36305,
		1,
		817,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		36310,
		nil,
		1,
		nil,
		1,
		nil,
		36310
	},
	[36305002] = {
		36305002,
		0,
		Lang.get(95444),
		36305,
		2,
		819,
		{
			RTResTalkAction[25]
		},
		nil,
		nil,
		3
	},
	[36305003] = {
		36305003,
		0,
		Lang.get(95445),
		36305,
		3,
		815,
		{
			RTResTalkAction[26],
			RTResTalkAction[11]
		}
	},
	[36305004] = {
		36305004,
		0,
		Lang.get(95446),
		36305,
		4,
		818,
		{
			RTResTalkAction[22],
			RTResTalkAction[27],
			RTResTalkAction[16]
		}
	},
	[36305005] = {
		36305005,
		0,
		Lang.get(95447),
		36305,
		5,
		818,
		{
			RTResTalkAction[22]
		}
	},
	[36305006] = {
		36305006,
		0,
		Lang.get(95448),
		36305,
		6,
		1197,
		{
			RTResTalkAction[12],
			RTResTalkAction[23]
		}
	},
	[36305007] = {
		36305007,
		0,
		Lang.get(95449),
		36305,
		7,
		818,
		{
			RTResTalkAction[22],
			RTResTalkAction[15]
		}
	},
	[36305008] = {
		36305008,
		0,
		Lang.get(95450),
		36305,
		8,
		1196,
		{
			RTResTalkAction[10],
			RTResTalkAction[23]
		}
	},
	[36305009] = {
		36305009,
		0,
		Lang.get(95451),
		36305,
		9,
		818,
		{
			RTResTalkAction[22],
			RTResTalkAction[13]
		}
	},
	[36305010] = {
		36305010,
		0,
		Lang.get(95452),
		36305,
		10,
		817,
		{
			RTResTalkAction[24]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		36311,
		nil,
		1,
		nil,
		1,
		nil,
		36311
	},
	[36305011] = {
		36305011,
		0,
		Lang.get(95453),
		36305,
		11,
		815,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[36305012] = {
		36305012,
		0,
		Lang.get(95454),
		36305,
		12,
		1196,
		{
			RTResTalkAction[9],
			RTResTalkAction[16]
		}
	},
	[36305013] = {
		36305013,
		0,
		Lang.get(95455),
		36305,
		13,
		1197,
		{
			RTResTalkAction[10],
			RTResTalkAction[18]
		}
	},
	[36305014] = {
		36305014,
		2,
		Lang.get(95456),
		36305,
		14,
		1197,
		{
			RTResTalkAction[17],
			RTResTalkAction[13]
		}
	},
	[36305015] = {
		36305015,
		3,
		Lang.get(95457),
		36305,
		15,
		605,
		{
			RTResTalkAction[15]
		},
		[22] = 1,
		[20] = 255
	},
	[36305016] = {
		36305016,
		0,
		Lang.get(95458),
		36305,
		16,
		1197,
		{
			RTResTalkAction[17]
		}
	},
	[36305017] = {
		36305017,
		0,
		Lang.get(95459),
		36305,
		17,
		1196,
		{
			RTResTalkAction[10],
			RTResTalkAction[18]
		}
	},
	[36306001] = {
		36306001,
		0,
		Lang.get(95460),
		36306,
		1,
		817,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		nil,
		nil,
		1,
		nil,
		1,
		nil,
		nil,
		255
	},
	[36306002] = {
		36306002,
		0,
		Lang.get(95461),
		36306,
		2,
		817,
		{
			RTResTalkAction[19]
		}
	},
	[36306003] = {
		36306003,
		0,
		Lang.get(95462),
		36306,
		3,
		819,
		{
			RTResTalkAction[26],
			RTResTalkAction[20]
		}
	},
	[36306004] = {
		36306004,
		0,
		Lang.get(95463),
		36306,
		4,
		818,
		{
			RTResTalkAction[22],
			RTResTalkAction[27],
			RTResTalkAction[21]
		}
	},
	[36306005] = {
		36306005,
		0,
		Lang.get(95464),
		36306,
		5,
		818,
		{
			RTResTalkAction[22]
		}
	},
	[36306006] = {
		36306006,
		0,
		Lang.get(95465),
		36306,
		6,
		1197,
		{
			RTResTalkAction[17],
			RTResTalkAction[24]
		}
	},
	[36306007] = {
		36306007,
		0,
		Lang.get(95466),
		36306,
		7,
		1196,
		{
			RTResTalkAction[10],
			RTResTalkAction[18]
		}
	},
	[36306008] = {
		36306008,
		0,
		Lang.get(93802),
		36306,
		8,
		1196,
		{
			RTResTalkAction[13],
			RTResTalkAction[15]
		},
		1,
		nil,
		nil,
		nil,
		199,
		36313,
		nil,
		1,
		nil,
		1,
		nil,
		36313,
		-1
	},
	[36306009] = {
		36306009,
		0,
		Lang.get(95467),
		36306,
		9,
		1196,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3,
		[20] = 100
	},
	[36306010] = {
		36306010,
		0,
		Lang.get(93787),
		36306,
		10,
		1196,
		{
			RTResTalkAction[9]
		}
	},
	[36306011] = {
		36306011,
		2,
		Lang.get(95468),
		36306,
		11,
		1197,
		{
			RTResTalkAction[10],
			RTResTalkAction[18]
		}
	},
	[36306012] = {
		36306012,
		0,
		Lang.get(93803),
		36306,
		12,
		1196,
		{
			RTResTalkAction[9],
			RTResTalkAction[15]
		}
	},
	[36306013] = {
		36306013,
		0,
		Lang.get(94171),
		36306,
		13,
		1196,
		{
			RTResTalkAction[9]
		}
	},
	[36306014] = {
		36306014,
		2,
		Lang.get(95469),
		36306,
		14,
		1197,
		{
			RTResTalkAction[10],
			RTResTalkAction[18]
		}
	},
	[36306015] = {
		36306015,
		0,
		Lang.get(95470),
		36306,
		15,
		817,
		{
			RTResTalkAction[19],
			RTResTalkAction[13],
			RTResTalkAction[15]
		}
	},
	[36306016] = {
		36306016,
		0,
		Lang.get(95471),
		36306,
		16,
		819,
		{
			RTResTalkAction[26],
			RTResTalkAction[20]
		}
	},
	[36306017] = {
		36306017,
		0,
		Lang.get(95472),
		36306,
		17,
		815,
		{
			RTResTalkAction[14],
			RTResTalkAction[27],
			RTResTalkAction[21]
		}
	},
	[36306018] = {
		36306018,
		0,
		Lang.get(95473),
		36306,
		18,
		815,
		{
			RTResTalkAction[14]
		}
	},
	[36306019] = {
		36306019,
		3,
		Lang.get(95474),
		36306,
		19,
		605,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		nil,
		nil,
		63,
		36314,
		nil,
		1,
		nil,
		1,
		nil,
		36314,
		-1,
		nil,
		1
	},
	[36306020] = {
		36306020,
		0,
		Lang.get(95475),
		36306,
		20,
		819,
		{
			RTResTalkAction[25]
		},
		nil,
		nil,
		3
	},
	[36306021] = {
		36306021,
		0,
		Lang.get(95476),
		36306,
		21,
		817,
		{
			RTResTalkAction[26],
			RTResTalkAction[20]
		}
	},
	[36306022] = {
		36306022,
		0,
		Lang.get(95477),
		36306,
		22,
		818,
		{
			RTResTalkAction[22],
			RTResTalkAction[27],
			RTResTalkAction[21]
		}
	},
	[36306023] = {
		36306023,
		3,
		Lang.get(95478),
		36306,
		23,
		605,
		{
			RTResTalkAction[24]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		36315,
		nil,
		1,
		nil,
		1,
		nil,
		36315,
		nil,
		nil,
		1
	},
	[36306024] = {
		36306024,
		0,
		Lang.get(95479),
		36306,
		24,
		195,
		{
			RTResTalkAction[28]
		},
		nil,
		nil,
		3
	},
	[36306025] = {
		36306025,
		0,
		Lang.get(95480),
		36306,
		25,
		195,
		{
			RTResTalkAction[29]
		}
	},
	[36306026] = {
		36306026,
		0,
		Lang.get(95481),
		36306,
		26,
		818,
		{
			RTResTalkAction[22],
			RTResTalkAction[30]
		}
	},
	[36307001] = {
		36307001,
		10,
		"85",
		36307,
		1,
		818,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		36316,
		nil,
		1,
		nil,
		1,
		nil,
		36316
	},
	[36307002] = {
		36307002,
		0,
		Lang.get(95482),
		36307,
		2,
		292,
		nil,
		1,
		1
	},
	[36307003] = {
		36307003,
		0,
		Lang.get(95483),
		36307,
		3,
		292,
		{
			RTResTalkAction[31]
		},
		nil,
		0,
		3
	},
	[36307004] = {
		36307004,
		0,
		Lang.get(95484),
		36307,
		4,
		107,
		{
			RTResTalkAction[32],
			RTResTalkAction[5]
		}
	},
	[36307005] = {
		36307005,
		0,
		Lang.get(95485),
		36307,
		5,
		292,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[36307006] = {
		36307006,
		0,
		Lang.get(95486),
		36307,
		6,
		107,
		{
			RTResTalkAction[33],
			RTResTalkAction[5]
		}
	},
	[36307007] = {
		36307007,
		4,
		nil,
		36307,
		7,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 36307008,
				branch_content = Lang.get(95487)
			}
		}
	},
	[36307008] = {
		36307008,
		0,
		Lang.get(95488),
		36307,
		8,
		292,
		{
			RTResTalkAction[6],
			RTResTalkAction[34]
		}
	},
	[36307009] = {
		36307009,
		0,
		Lang.get(95489),
		36307,
		9,
		107,
		{
			RTResTalkAction[35],
			RTResTalkAction[5]
		}
	},
	[36307010] = {
		36307010,
		0,
		Lang.get(95490),
		36307,
		10,
		292,
		{
			RTResTalkAction[36],
			RTResTalkAction[8]
		}
	},
	[36307011] = {
		36307011,
		0,
		Lang.get(95491),
		36307,
		11,
		292,
		{
			RTResTalkAction[31]
		}
	},
	[36307012] = {
		36307012,
		4,
		nil,
		36307,
		12,
		292,
		{
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 36307013,
				branch_content = Lang.get(95492)
			}
		}
	},
	[36307013] = {
		36307013,
		0,
		Lang.get(95493),
		36307,
		13,
		292,
		{
			RTResTalkAction[37]
		}
	},
	[36307014] = {
		36307014,
		0,
		Lang.get(95494),
		36307,
		14,
		107,
		{
			RTResTalkAction[32],
			RTResTalkAction[5]
		}
	},
	[36308001] = {
		36308001,
		0,
		Lang.get(95495),
		36308,
		1,
		196,
		nil,
		1,
		2,
		nil,
		nil,
		63,
		36317,
		nil,
		1,
		nil,
		1,
		nil,
		36317
	},
	[36308002] = {
		36308002,
		0,
		Lang.get(95496),
		36308,
		2,
		1197,
		{
			RTResTalkAction[38]
		},
		nil,
		0,
		3
	},
	[36308003] = {
		36308003,
		0,
		Lang.get(95497),
		36308,
		3,
		196,
		{
			RTResTalkAction[39],
			RTResTalkAction[15]
		}
	},
	[36308004] = {
		36308004,
		0,
		Lang.get(95498),
		36308,
		4,
		1196,
		{
			RTResTalkAction[40],
			RTResTalkAction[41]
		}
	},
	[36308005] = {
		36308005,
		0,
		Lang.get(95499),
		36308,
		5,
		196,
		{
			RTResTalkAction[42],
			RTResTalkAction[13]
		}
	},
	[36308006] = {
		36308006,
		0,
		Lang.get(95500),
		36308,
		6,
		196,
		{
			RTResTalkAction[43]
		}
	},
	[36308007] = {
		36308007,
		0,
		Lang.get(95501),
		36308,
		7,
		196,
		{
			RTResTalkAction[44]
		}
	},
	[36308008] = {
		36308008,
		0,
		Lang.get(95502),
		36308,
		8,
		196,
		{
			RTResTalkAction[39]
		}
	},
	[36308009] = {
		36308009,
		0,
		Lang.get(95503),
		36308,
		9,
		196,
		{
			RTResTalkAction[44]
		}
	},
	[36308010] = {
		36308010,
		0,
		Lang.get(95504),
		36308,
		10,
		196,
		{
			RTResTalkAction[43]
		}
	},
	[36308011] = {
		36308011,
		0,
		Lang.get(95505),
		36308,
		11,
		196,
		{
			RTResTalkAction[42]
		}
	},
	[36308012] = {
		36308012,
		0,
		Lang.get(95506),
		36308,
		12,
		1197,
		{
			RTResTalkAction[38],
			RTResTalkAction[41]
		}
	},
	[36308013] = {
		36308013,
		0,
		Lang.get(95507),
		36308,
		13,
		196,
		{
			RTResTalkAction[43],
			RTResTalkAction[15]
		}
	},
	[36308014] = {
		36308014,
		0,
		Lang.get(95508),
		36308,
		14,
		196,
		{
			RTResTalkAction[44]
		}
	},
	[36308015] = {
		36308015,
		0,
		Lang.get(95509),
		36308,
		15,
		1197,
		{
			RTResTalkAction[38],
			RTResTalkAction[41]
		}
	},
	[36308016] = {
		36308016,
		0,
		Lang.get(95510),
		36308,
		16,
		196,
		{
			RTResTalkAction[43],
			RTResTalkAction[15]
		}
	},
	[36308017] = {
		36308017,
		0,
		Lang.get(95511),
		36308,
		17,
		1196,
		{
			RTResTalkAction[9],
			RTResTalkAction[41]
		}
	},
	[36308018] = {
		36308018,
		0,
		Lang.get(95512),
		36308,
		18,
		1196,
		{
			RTResTalkAction[9]
		}
	},
	[36309001] = {
		36309001,
		0,
		Lang.get(95513),
		36309,
		1,
		196,
		nil,
		1,
		3,
		nil,
		nil,
		62,
		36318,
		nil,
		1,
		nil,
		1,
		nil,
		36318
	},
	[36309002] = {
		36309002,
		0,
		Lang.get(95514),
		36309,
		2,
		196,
		{
			RTResTalkAction[43]
		},
		nil,
		0,
		3
	},
	[36309003] = {
		36309003,
		0,
		Lang.get(95515),
		36309,
		3,
		1196,
		{
			RTResTalkAction[45],
			RTResTalkAction[46]
		}
	},
	[36309004] = {
		36309004,
		0,
		Lang.get(95516),
		36309,
		4,
		1196,
		{
			RTResTalkAction[45],
			RTResTalkAction[46]
		}
	},
	[36309005] = {
		36309005,
		0,
		Lang.get(95517),
		36309,
		5,
		1197,
		{
			RTResTalkAction[10],
			RTResTalkAction[18],
			RTResTalkAction[41]
		}
	},
	[36309006] = {
		36309006,
		0,
		Lang.get(95518),
		36309,
		6,
		196,
		{
			RTResTalkAction[43],
			RTResTalkAction[13],
			RTResTalkAction[15]
		}
	},
	[36309007] = {
		36309007,
		0,
		Lang.get(95519),
		36309,
		7,
		196,
		{
			RTResTalkAction[42]
		}
	},
	[36309008] = {
		36309008,
		0,
		Lang.get(95520),
		36309,
		8,
		1196,
		{
			RTResTalkAction[45],
			RTResTalkAction[46]
		}
	},
	[36309009] = {
		36309009,
		0,
		Lang.get(95521),
		36309,
		9,
		1197,
		{
			RTResTalkAction[10],
			RTResTalkAction[18],
			RTResTalkAction[41]
		}
	},
	[36309010] = {
		36309010,
		0,
		Lang.get(95522),
		36309,
		10,
		1196,
		{
			RTResTalkAction[13],
			RTResTalkAction[15]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		36319,
		nil,
		1,
		nil,
		1,
		nil,
		36319
	},
	[36309011] = {
		36309011,
		0,
		Lang.get(95523),
		36309,
		11,
		1196,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[36309012] = {
		36309012,
		0,
		Lang.get(95524),
		36309,
		12,
		196,
		{
			RTResTalkAction[47],
			RTResTalkAction[46]
		}
	},
	[36309013] = {
		36309013,
		0,
		Lang.get(95525),
		36309,
		13,
		1196,
		{
			RTResTalkAction[45],
			RTResTalkAction[46]
		}
	},
	[36309014] = {
		36309014,
		0,
		Lang.get(95526),
		36309,
		14,
		1197,
		{
			RTResTalkAction[48],
			RTResTalkAction[18],
			RTResTalkAction[41]
		}
	},
	[36309015] = {
		36309015,
		0,
		Lang.get(95527),
		36309,
		15,
		1196,
		{
			RTResTalkAction[10],
			RTResTalkAction[18]
		}
	},
	[36309016] = {
		36309016,
		0,
		Lang.get(95528),
		36309,
		16,
		1196,
		{
			RTResTalkAction[10],
			RTResTalkAction[18]
		}
	},
	[36309017] = {
		36309017,
		0,
		Lang.get(95529),
		36309,
		17,
		1197,
		{
			RTResTalkAction[10],
			RTResTalkAction[18]
		}
	},
	[36309018] = {
		36309018,
		0,
		Lang.get(95530),
		36309,
		18,
		1196,
		{
			RTResTalkAction[10],
			RTResTalkAction[18]
		}
	},
	[36309019] = {
		36309019,
		0,
		Lang.get(95531),
		36309,
		19,
		196,
		{
			RTResTalkAction[49],
			RTResTalkAction[46],
			RTResTalkAction[15]
		}
	},
	[36309020] = {
		36309020,
		0,
		Lang.get(95532),
		36309,
		20,
		1197,
		{
			RTResTalkAction[17],
			RTResTalkAction[41],
			RTResTalkAction[13]
		}
	},
	[36310001] = {
		36310001,
		0,
		Lang.get(95533),
		36310,
		1,
		1197,
		nil,
		1,
		nil,
		nil,
		nil,
		169,
		36320,
		nil,
		1,
		nil,
		1,
		nil,
		36320
	},
	[36310002] = {
		36310002,
		0,
		Lang.get(95534),
		36310,
		2,
		1197,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[36310003] = {
		36310003,
		0,
		Lang.get(95535),
		36310,
		3,
		1196,
		{
			RTResTalkAction[10],
			RTResTalkAction[18]
		}
	},
	[36310004] = {
		36310004,
		0,
		Lang.get(95536),
		36310,
		4,
		1196,
		{
			RTResTalkAction[9],
			RTResTalkAction[15]
		}
	},
	[36310005] = {
		36310005,
		0,
		Lang.get(95537),
		36310,
		5,
		196,
		{
			RTResTalkAction[49],
			RTResTalkAction[46]
		}
	},
	[36310006] = {
		36310006,
		0,
		Lang.get(95538),
		36310,
		6,
		1196,
		{
			RTResTalkAction[45],
			RTResTalkAction[46]
		}
	},
	[36310007] = {
		36310007,
		0,
		Lang.get(95539),
		36310,
		7,
		1196,
		{
			RTResTalkAction[45],
			RTResTalkAction[46]
		}
	},
	[36310008] = {
		36310008,
		0,
		Lang.get(95540),
		36310,
		8,
		196,
		{
			RTResTalkAction[50],
			RTResTalkAction[46]
		}
	},
	[36310009] = {
		36310009,
		0,
		Lang.get(95541),
		36310,
		9,
		1197,
		{
			RTResTalkAction[17],
			RTResTalkAction[41],
			RTResTalkAction[13]
		}
	},
	[36310010] = {
		36310010,
		0,
		Lang.get(95542),
		36310,
		10,
		1196,
		{
			RTResTalkAction[10],
			RTResTalkAction[18]
		}
	},
	[36310011] = {
		36310011,
		0,
		Lang.get(95543),
		36310,
		11,
		1197,
		{
			RTResTalkAction[17],
			RTResTalkAction[13]
		}
	},
	[36310012] = {
		36310012,
		0,
		Lang.get(95544),
		36310,
		12,
		1197,
		{
			RTResTalkAction[17]
		}
	},
	[36310013] = {
		36310013,
		2,
		Lang.get(95545),
		36310,
		13,
		1197,
		{
			RTResTalkAction[15]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		36321,
		nil,
		1,
		nil,
		1,
		nil,
		36321
	},
	[36310014] = {
		36310014,
		2,
		Lang.get(95546),
		36310,
		14,
		1197,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[36310015] = {
		36310015,
		2,
		Lang.get(95547),
		36310,
		15,
		1197,
		{
			RTResTalkAction[17]
		}
	},
	[36310016] = {
		36310016,
		0,
		Lang.get(95548),
		36310,
		16,
		196,
		{
			RTResTalkAction[39],
			RTResTalkAction[15]
		}
	},
	[36310017] = {
		36310017,
		0,
		Lang.get(95549),
		36310,
		17,
		1196,
		{
			RTResTalkAction[45],
			RTResTalkAction[46]
		}
	},
	[36310018] = {
		36310018,
		0,
		Lang.get(95550),
		36310,
		18,
		196,
		{
			RTResTalkAction[49],
			RTResTalkAction[46]
		}
	},
	[36310019] = {
		36310019,
		0,
		Lang.get(95551),
		36310,
		19,
		1196,
		{
			RTResTalkAction[45],
			RTResTalkAction[46]
		}
	},
	[36310020] = {
		36310020,
		0,
		Lang.get(95552),
		36310,
		20,
		1196,
		{
			RTResTalkAction[9],
			RTResTalkAction[41]
		}
	},
	[36310021] = {
		36310021,
		0,
		Lang.get(95553),
		36310,
		21,
		1196,
		{
			RTResTalkAction[9]
		}
	},
	[36310022] = {
		36310022,
		0,
		Lang.get(95554),
		36310,
		22,
		1196,
		{
			RTResTalkAction[9]
		}
	},
	[36310023] = {
		36310023,
		2,
		Lang.get(95555),
		36310,
		23,
		1197,
		{
			RTResTalkAction[17],
			RTResTalkAction[13]
		}
	},
	[36310024] = {
		36310024,
		2,
		Lang.get(95556),
		36310,
		24,
		1197,
		{
			RTResTalkAction[17]
		}
	},
	[36310025] = {
		36310025,
		2,
		Lang.get(95557),
		36310,
		25,
		1197,
		{
			RTResTalkAction[17]
		}
	},
	[36311001] = {
		36311001,
		0,
		Lang.get(95558),
		36311,
		1,
		1197,
		nil,
		1,
		nil,
		nil,
		nil,
		113,
		36322,
		nil,
		1,
		nil,
		1,
		nil,
		36322
	},
	[36311002] = {
		36311002,
		0,
		Lang.get(95559),
		36311,
		2,
		1197,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[36311003] = {
		36311003,
		0,
		Lang.get(95560),
		36311,
		3,
		1197,
		{
			RTResTalkAction[17]
		}
	},
	[36311004] = {
		36311004,
		0,
		Lang.get(95561),
		36311,
		4,
		820,
		{
			RTResTalkAction[51],
			RTResTalkAction[52],
			RTResTalkAction[15]
		}
	},
	[36311005] = {
		36311005,
		0,
		Lang.get(95562),
		36311,
		5,
		821,
		{
			RTResTalkAction[51],
			RTResTalkAction[52]
		}
	},
	[36311006] = {
		36311006,
		0,
		Lang.get(95563),
		36311,
		6,
		1197,
		{
			RTResTalkAction[17],
			RTResTalkAction[53],
			RTResTalkAction[54]
		}
	},
	[36311007] = {
		36311007,
		0,
		Lang.get(95564),
		36311,
		7,
		1197,
		{
			RTResTalkAction[17]
		}
	},
	[36311008] = {
		36311008,
		0,
		Lang.get(95565),
		36311,
		8,
		820,
		{
			RTResTalkAction[51],
			RTResTalkAction[52],
			RTResTalkAction[15]
		}
	},
	[36311009] = {
		36311009,
		0,
		Lang.get(95566),
		36311,
		9,
		821,
		{
			RTResTalkAction[51],
			RTResTalkAction[52]
		}
	},
	[36311010] = {
		36311010,
		0,
		Lang.get(95567),
		36311,
		10,
		1197,
		{
			RTResTalkAction[17],
			RTResTalkAction[53],
			RTResTalkAction[54]
		}
	},
	[36311011] = {
		36311011,
		0,
		Lang.get(95568),
		36311,
		11,
		107,
		{
			RTResTalkAction[15]
		},
		1,
		4,
		nil,
		nil,
		nil,
		36323,
		nil,
		1,
		nil,
		1,
		nil,
		36323
	},
	[36311012] = {
		36311012,
		0,
		Lang.get(95569),
		36311,
		12,
		292,
		{
			RTResTalkAction[37]
		},
		nil,
		0,
		3
	},
	[36311013] = {
		36311013,
		0,
		Lang.get(95570),
		36311,
		13,
		107,
		{
			RTResTalkAction[35],
			RTResTalkAction[5]
		}
	},
	[36311014] = {
		36311014,
		0,
		Lang.get(95571),
		36311,
		14,
		107,
		{
			RTResTalkAction[55],
			RTResTalkAction[5]
		}
	},
	[36311015] = {
		36311015,
		0,
		Lang.get(95572),
		36311,
		15,
		820,
		{
			RTResTalkAction[8],
			RTResTalkAction[3]
		},
		1
	},
	[36311016] = {
		36311016,
		0,
		Lang.get(95573),
		36311,
		16,
		821,
		nil,
		1
	},
	[36311017] = {
		36311017,
		0,
		Lang.get(95574),
		36311,
		17,
		1197,
		nil,
		1
	},
	[36311018] = {
		36311018,
		0,
		Lang.get(95575),
		36311,
		18,
		292,
		{
			RTResTalkAction[31]
		},
		nil,
		0
	},
	[36312001] = {
		36312001,
		10,
		"86",
		36312,
		1,
		292,
		nil,
		nil,
		nil,
		nil,
		nil,
		169,
		36324,
		nil,
		1,
		nil,
		1,
		nil,
		36324
	},
	[36312002] = {
		36312002,
		0,
		Lang.get(95576),
		36312,
		2,
		1196,
		nil,
		1
	},
	[36312003] = {
		36312003,
		0,
		Lang.get(95577),
		36312,
		3,
		1196,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[36312004] = {
		36312004,
		0,
		Lang.get(95578),
		36312,
		4,
		196,
		{
			RTResTalkAction[49],
			RTResTalkAction[46]
		}
	},
	[36312005] = {
		36312005,
		0,
		Lang.get(95579),
		36312,
		5,
		1196,
		{
			RTResTalkAction[45],
			RTResTalkAction[46]
		}
	},
	[36312006] = {
		36312006,
		0,
		Lang.get(95580),
		36312,
		6,
		196,
		{
			RTResTalkAction[47],
			RTResTalkAction[46]
		}
	},
	[36312007] = {
		36312007,
		0,
		Lang.get(95581),
		36312,
		7,
		1196,
		{
			RTResTalkAction[45],
			RTResTalkAction[46]
		}
	},
	[36312008] = {
		36312008,
		0,
		Lang.get(95582),
		36312,
		8,
		1196,
		{
			RTResTalkAction[41],
			RTResTalkAction[13]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		36325,
		nil,
		1,
		nil,
		1,
		nil,
		36325
	},
	[36312009] = {
		36312009,
		0,
		Lang.get(95583),
		36312,
		9,
		196,
		{
			RTResTalkAction[44]
		},
		nil,
		nil,
		3
	},
	[36312010] = {
		36312010,
		0,
		Lang.get(95584),
		36312,
		10,
		1196,
		{
			RTResTalkAction[45],
			RTResTalkAction[46]
		}
	},
	[36312011] = {
		36312011,
		0,
		Lang.get(95585),
		36312,
		11,
		1196,
		{
			RTResTalkAction[45],
			RTResTalkAction[46]
		}
	},
	[36312012] = {
		36312012,
		0,
		Lang.get(95586),
		36312,
		12,
		1196,
		{
			RTResTalkAction[45],
			RTResTalkAction[46]
		}
	},
	[36312013] = {
		36312013,
		0,
		Lang.get(95587),
		36312,
		13,
		1196,
		{
			RTResTalkAction[45],
			RTResTalkAction[46]
		}
	},
	[36312014] = {
		36312014,
		0,
		Lang.get(95588),
		36312,
		14,
		196,
		{
			RTResTalkAction[56],
			RTResTalkAction[46]
		}
	},
	[36312015] = {
		36312015,
		0,
		Lang.get(95589),
		36312,
		15,
		196,
		{
			RTResTalkAction[50],
			RTResTalkAction[46]
		}
	},
	[36312016] = {
		36312016,
		0,
		Lang.get(95590),
		36312,
		16,
		1196,
		{
			RTResTalkAction[45],
			RTResTalkAction[57]
		}
	},
	[36312017] = {
		36312017,
		2,
		Lang.get(95591),
		36312,
		17,
		1196,
		{
			RTResTalkAction[9],
			RTResTalkAction[41]
		}
	},
	[36313001] = {
		36313001,
		0,
		Lang.get(95592),
		36313,
		1,
		1196,
		nil,
		1,
		nil,
		nil,
		nil,
		199,
		36326,
		nil,
		1,
		nil,
		1,
		nil,
		36326
	},
	[36313002] = {
		36313002,
		0,
		Lang.get(95593),
		36313,
		2,
		196,
		{
			RTResTalkAction[44]
		},
		nil,
		nil,
		3
	},
	[36313003] = {
		36313003,
		0,
		Lang.get(95594),
		36313,
		3,
		196,
		{
			RTResTalkAction[43]
		}
	},
	[36313004] = {
		36313004,
		0,
		Lang.get(95595),
		36313,
		4,
		1196,
		{
			RTResTalkAction[45],
			RTResTalkAction[46]
		}
	},
	[36313005] = {
		36313005,
		0,
		Lang.get(95596),
		36313,
		5,
		196,
		{
			RTResTalkAction[47],
			RTResTalkAction[46]
		}
	},
	[36313006] = {
		36313006,
		3,
		Lang.get(95597),
		36313,
		6,
		605,
		{
			RTResTalkAction[41],
			RTResTalkAction[13]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		36327,
		nil,
		1,
		nil,
		1,
		nil,
		36327,
		nil,
		nil,
		1
	},
	[36313007] = {
		36313007,
		0,
		Lang.get(93787),
		36313,
		7,
		1196,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[36313008] = {
		36313008,
		0,
		Lang.get(94171),
		36313,
		8,
		1196,
		{
			RTResTalkAction[9]
		}
	},
	[36313009] = {
		36313009,
		0,
		Lang.get(95598),
		36313,
		9,
		196,
		{
			RTResTalkAction[47],
			RTResTalkAction[46]
		}
	},
	[36313010] = {
		36313010,
		0,
		Lang.get(95599),
		36313,
		10,
		196,
		{
			RTResTalkAction[49],
			RTResTalkAction[46]
		}
	},
	[36313011] = {
		36313011,
		0,
		Lang.get(95600),
		36313,
		11,
		1196,
		{
			RTResTalkAction[45],
			RTResTalkAction[46]
		}
	},
	[36313012] = {
		36313012,
		0,
		Lang.get(95601),
		36313,
		12,
		1196,
		{
			RTResTalkAction[45],
			RTResTalkAction[46]
		}
	},
	[36313013] = {
		36313013,
		0,
		Lang.get(95602),
		36313,
		13,
		1196,
		{
			RTResTalkAction[45],
			RTResTalkAction[46]
		}
	},
	[36313014] = {
		36313014,
		0,
		Lang.get(95603),
		36313,
		14,
		196,
		{
			RTResTalkAction[56],
			RTResTalkAction[46]
		}
	},
	[36313015] = {
		36313015,
		0,
		Lang.get(95604),
		36313,
		15,
		1196,
		{
			RTResTalkAction[45],
			RTResTalkAction[46]
		}
	},
	[36313016] = {
		36313016,
		0,
		Lang.get(95605),
		36313,
		16,
		196,
		{
			RTResTalkAction[49],
			RTResTalkAction[46]
		}
	},
	[36313017] = {
		36313017,
		0,
		Lang.get(95606),
		36313,
		17,
		1196,
		{
			RTResTalkAction[45],
			RTResTalkAction[46]
		}
	},
	[36313018] = {
		36313018,
		0,
		Lang.get(95607),
		36313,
		18,
		196,
		{
			RTResTalkAction[47],
			RTResTalkAction[46]
		}
	},
	[36313019] = {
		36313019,
		0,
		Lang.get(95608),
		36313,
		19,
		196,
		{
			RTResTalkAction[56],
			RTResTalkAction[46]
		}
	},
	[36313020] = {
		36313020,
		0,
		Lang.get(95609),
		36313,
		20,
		196,
		{
			RTResTalkAction[49],
			RTResTalkAction[46]
		}
	},
	[36313021] = {
		36313021,
		0,
		Lang.get(95610),
		36313,
		21,
		1196,
		{
			RTResTalkAction[45],
			RTResTalkAction[46]
		}
	},
	[36313022] = {
		36313022,
		0,
		Lang.get(95611),
		36313,
		22,
		196,
		{
			RTResTalkAction[47],
			RTResTalkAction[46]
		}
	},
	[36313023] = {
		36313023,
		0,
		Lang.get(95612),
		36313,
		23,
		196,
		{
			RTResTalkAction[49],
			RTResTalkAction[46]
		},
		nil,
		nil,
		nil,
		nil,
		63
	},
	[36313024] = {
		36313024,
		0,
		Lang.get(95613),
		36313,
		24,
		822,
		{
			RTResTalkAction[41],
			RTResTalkAction[13]
		},
		1
	},
	[36313025] = {
		36313025,
		0,
		Lang.get(95614),
		36313,
		25,
		1196,
		{
			RTResTalkAction[58]
		}
	},
	[36314001] = {
		36314001,
		0,
		Lang.get(95615),
		36314,
		1,
		292,
		nil,
		1,
		nil,
		nil,
		nil,
		113,
		36328,
		nil,
		1,
		nil,
		1,
		nil,
		36328
	},
	[36314002] = {
		36314002,
		0,
		Lang.get(95616),
		36314,
		2,
		1197,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[36314003] = {
		36314003,
		0,
		Lang.get(95617),
		36314,
		3,
		292,
		{
			RTResTalkAction[59],
			RTResTalkAction[18]
		}
	},
	[36314004] = {
		36314004,
		0,
		Lang.get(95618),
		36314,
		4,
		292,
		{
			RTResTalkAction[60],
			RTResTalkAction[18]
		}
	},
	[36314005] = {
		36314005,
		0,
		Lang.get(95619),
		36314,
		5,
		292,
		{
			RTResTalkAction[61],
			RTResTalkAction[18]
		}
	},
	[36314006] = {
		36314006,
		0,
		Lang.get(95620),
		36314,
		6,
		1197,
		{
			RTResTalkAction[62],
			RTResTalkAction[18]
		}
	},
	[36314007] = {
		36314007,
		0,
		Lang.get(95621),
		36314,
		7,
		292,
		{
			RTResTalkAction[1],
			RTResTalkAction[15]
		}
	},
	[36314008] = {
		36314008,
		0,
		Lang.get(95622),
		36314,
		8,
		107,
		{
			RTResTalkAction[32],
			RTResTalkAction[5]
		}
	},
	[36314009] = {
		36314009,
		0,
		Lang.get(95623),
		36314,
		9,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[36314010] = {
		36314010,
		0,
		Lang.get(95624),
		36314,
		10,
		292,
		{
			RTResTalkAction[6],
			RTResTalkAction[63]
		}
	},
	[36314011] = {
		36314011,
		0,
		Lang.get(95625),
		36314,
		11,
		292,
		{
			RTResTalkAction[6],
			RTResTalkAction[5]
		}
	},
	[36314012] = {
		36314012,
		0,
		Lang.get(95626),
		36314,
		12,
		1197,
		{
			RTResTalkAction[17],
			RTResTalkAction[8],
			RTResTalkAction[3]
		}
	},
	[36314013] = {
		36314013,
		0,
		Lang.get(95627),
		36314,
		13,
		1197,
		{
			RTResTalkAction[15]
		},
		1,
		nil,
		nil,
		nil,
		63,
		36329,
		nil,
		1,
		nil,
		1,
		nil,
		36329
	},
	[36314014] = {
		36314014,
		0,
		Lang.get(95628),
		36314,
		14,
		1197,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[36314015] = {
		36314015,
		0,
		Lang.get(95629),
		36314,
		15,
		292,
		{
			RTResTalkAction[62],
			RTResTalkAction[18]
		}
	},
	[36314016] = {
		36314016,
		0,
		Lang.get(95630),
		36314,
		16,
		107,
		{
			RTResTalkAction[64],
			RTResTalkAction[5],
			RTResTalkAction[15]
		}
	},
	[36314017] = {
		36314017,
		0,
		Lang.get(95631),
		36314,
		17,
		1197,
		{
			RTResTalkAction[17],
			RTResTalkAction[8],
			RTResTalkAction[3]
		}
	},
	[36314018] = {
		36314018,
		0,
		Lang.get(95632),
		36314,
		18,
		1197,
		{
			RTResTalkAction[17]
		}
	},
	[36314019] = {
		36314019,
		0,
		Lang.get(95633),
		36314,
		19,
		1197,
		{
			RTResTalkAction[17]
		}
	},
	[36314020] = {
		36314020,
		0,
		Lang.get(95634),
		36314,
		20,
		107,
		{
			RTResTalkAction[35],
			RTResTalkAction[18]
		}
	},
	[36314021] = {
		36314021,
		0,
		Lang.get(95635),
		36314,
		21,
		1197,
		{
			RTResTalkAction[6],
			RTResTalkAction[18]
		}
	},
	[36314022] = {
		36314022,
		0,
		Lang.get(95636),
		36314,
		22,
		1197,
		{
			RTResTalkAction[6],
			RTResTalkAction[18]
		}
	},
	[36314023] = {
		36314023,
		0,
		Lang.get(95637),
		36314,
		23,
		292,
		{
			RTResTalkAction[31],
			RTResTalkAction[8],
			RTResTalkAction[15]
		}
	},
	[36315001] = {
		36315001,
		0,
		Lang.get(95638),
		36315,
		1,
		292,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		36330,
		nil,
		1,
		nil,
		1,
		nil,
		36330
	},
	[36315002] = {
		36315002,
		0,
		Lang.get(95639),
		36315,
		2,
		292,
		{
			RTResTalkAction[31]
		},
		nil,
		nil,
		3
	},
	[36315003] = {
		36315003,
		0,
		Lang.get(95640),
		36315,
		3,
		1197,
		{
			RTResTalkAction[62],
			RTResTalkAction[18]
		}
	},
	[36315004] = {
		36315004,
		0,
		Lang.get(95641),
		36315,
		4,
		292,
		{
			RTResTalkAction[60],
			RTResTalkAction[18]
		}
	},
	[36323001] = {
		36323001,
		3,
		Lang.get(95642),
		36323,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		36331,
		nil,
		1,
		nil,
		1,
		nil,
		36331,
		nil,
		nil,
		1
	},
	[36323002] = {
		36323002,
		0,
		Lang.get(95643),
		36323,
		2,
		292,
		{
			RTResTalkAction[37]
		},
		nil,
		nil,
		3
	},
	[36323003] = {
		36323003,
		0,
		Lang.get(95644),
		36323,
		3,
		107,
		{
			RTResTalkAction[65],
			RTResTalkAction[5]
		}
	},
	[36323004] = {
		36323004,
		0,
		Lang.get(95645),
		36323,
		4,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[36323005] = {
		36323005,
		0,
		Lang.get(95646),
		36323,
		5,
		1197,
		{
			RTResTalkAction[17],
			RTResTalkAction[8],
			RTResTalkAction[3]
		}
	},
	[36323006] = {
		36323006,
		0,
		Lang.get(95647),
		36323,
		6,
		818,
		{
			RTResTalkAction[15]
		},
		1
	},
	[36323007] = {
		36323007,
		0,
		Lang.get(95648),
		36323,
		7,
		1197,
		{
			RTResTalkAction[17]
		}
	},
	[36323008] = {
		36323008,
		0,
		Lang.get(95649),
		36323,
		8,
		818,
		{
			RTResTalkAction[12],
			RTResTalkAction[23]
		}
	},
	[36323009] = {
		36323009,
		0,
		Lang.get(95650),
		36323,
		9,
		292,
		{
			RTResTalkAction[60],
			RTResTalkAction[23],
			RTResTalkAction[15]
		}
	},
	[36323010] = {
		36323010,
		0,
		Lang.get(95651),
		36323,
		10,
		818,
		{
			RTResTalkAction[62],
			RTResTalkAction[23]
		}
	},
	[36323011] = {
		36323011,
		0,
		Lang.get(95652),
		36323,
		11,
		818,
		{
			RTResTalkAction[22],
			RTResTalkAction[3]
		}
	},
	[36323012] = {
		36323012,
		0,
		Lang.get(95653),
		36323,
		12,
		1197,
		{
			RTResTalkAction[12],
			RTResTalkAction[23]
		}
	},
	[36323013] = {
		36323013,
		0,
		Lang.get(95654),
		36323,
		13,
		818,
		{
			RTResTalkAction[12],
			RTResTalkAction[23]
		}
	},
	[36323014] = {
		36323014,
		0,
		Lang.get(95655),
		36323,
		14,
		818,
		{
			RTResTalkAction[12],
			RTResTalkAction[23]
		}
	},
	[36323015] = {
		36323015,
		0,
		Lang.get(95656),
		36323,
		15,
		818,
		{
			RTResTalkAction[22],
			RTResTalkAction[15]
		}
	},
	[36323016] = {
		36323016,
		0,
		Lang.get(95657),
		36323,
		16,
		292,
		{
			RTResTalkAction[59],
			RTResTalkAction[23]
		}
	},
	[36323017] = {
		36323017,
		0,
		Lang.get(95658),
		36323,
		17,
		818,
		{
			RTResTalkAction[62],
			RTResTalkAction[23]
		}
	},
	[36323018] = {
		36323018,
		0,
		Lang.get(95659),
		36323,
		18,
		1197,
		{
			RTResTalkAction[17],
			RTResTalkAction[3],
			RTResTalkAction[24]
		}
	},
	[36316001] = {
		36316001,
		0,
		Lang.get(95660),
		36316,
		1,
		196,
		nil,
		1,
		2,
		nil,
		nil,
		63,
		36332,
		nil,
		1,
		nil,
		1,
		nil,
		36332
	},
	[36316002] = {
		36316002,
		0,
		Lang.get(95661),
		36316,
		2,
		196,
		{
			RTResTalkAction[43]
		},
		nil,
		0,
		3
	},
	[36316003] = {
		36316003,
		0,
		Lang.get(95662),
		36316,
		3,
		196,
		{
			RTResTalkAction[44]
		}
	},
	[36316004] = {
		36316004,
		0,
		Lang.get(95663),
		36316,
		4,
		1196,
		{
			RTResTalkAction[10],
			RTResTalkAction[66]
		}
	},
	[36316005] = {
		36316005,
		0,
		Lang.get(95664),
		36316,
		5,
		196,
		{
			RTResTalkAction[10],
			RTResTalkAction[67]
		}
	},
	[36316006] = {
		36316006,
		0,
		Lang.get(95665),
		36316,
		6,
		196,
		{
			RTResTalkAction[10],
			RTResTalkAction[68]
		}
	},
	[36316007] = {
		36316007,
		0,
		Lang.get(95666),
		36316,
		7,
		196,
		{
			RTResTalkAction[10],
			RTResTalkAction[69]
		}
	},
	[36316008] = {
		36316008,
		0,
		Lang.get(95667),
		36316,
		8,
		1196,
		{
			RTResTalkAction[9],
			RTResTalkAction[41]
		}
	},
	[36316009] = {
		36316009,
		0,
		Lang.get(95668),
		36316,
		9,
		107,
		{
			RTResTalkAction[13]
		},
		1,
		4,
		nil,
		nil,
		nil,
		36333,
		nil,
		1,
		nil,
		1,
		nil,
		36333
	},
	[36316010] = {
		36316010,
		0,
		Lang.get(95669),
		36316,
		10,
		1197,
		{
			RTResTalkAction[17]
		},
		nil,
		0,
		3
	},
	[36316011] = {
		36316011,
		0,
		Lang.get(95670),
		36316,
		11,
		196,
		{
			RTResTalkAction[15]
		},
		1,
		3
	},
	[36316012] = {
		36316012,
		0,
		Lang.get(95671),
		36316,
		12,
		196,
		{
			RTResTalkAction[44]
		}
	},
	[36316013] = {
		36316013,
		0,
		Lang.get(95672),
		36316,
		13,
		196,
		{
			RTResTalkAction[43]
		}
	},
	[36316014] = {
		36316014,
		0,
		Lang.get(95673),
		36316,
		14,
		1197,
		{
			RTResTalkAction[45],
			RTResTalkAction[18]
		}
	},
	[36316015] = {
		36316015,
		0,
		Lang.get(95674),
		36316,
		15,
		1197,
		{
			RTResTalkAction[45],
			RTResTalkAction[18]
		}
	},
	[36316016] = {
		36316016,
		0,
		Lang.get(95675),
		36316,
		16,
		1196,
		{
			RTResTalkAction[41],
			RTResTalkAction[15]
		},
		1
	},
	[36316017] = {
		36316017,
		0,
		Lang.get(95676),
		36316,
		17,
		1197,
		{
			RTResTalkAction[17]
		}
	},
	[36316018] = {
		36316018,
		0,
		Lang.get(95677),
		36316,
		18,
		1196,
		{
			RTResTalkAction[10],
			RTResTalkAction[18]
		}
	},
	[36316019] = {
		36316019,
		0,
		Lang.get(95678),
		36316,
		19,
		196,
		{
			RTResTalkAction[39],
			RTResTalkAction[13],
			RTResTalkAction[15]
		}
	},
	[36316020] = {
		36316020,
		0,
		Lang.get(95679),
		36316,
		20,
		1196,
		{
			RTResTalkAction[10],
			RTResTalkAction[66]
		}
	},
	[36316021] = {
		36316021,
		0,
		Lang.get(95680),
		36316,
		21,
		196,
		{
			RTResTalkAction[44],
			RTResTalkAction[13]
		}
	},
	[36316022] = {
		36316022,
		5,
		Lang.get(95681),
		36316,
		22,
		1197,
		{
			RTResTalkAction[45],
			RTResTalkAction[18]
		}
	},
	[36317001] = {
		36317001,
		0,
		Lang.get(95682),
		36317,
		1,
		196,
		nil,
		1,
		2,
		nil,
		nil,
		113,
		36334,
		nil,
		1,
		nil,
		1,
		nil,
		36334
	},
	[36317002] = {
		36317002,
		0,
		Lang.get(95683),
		36317,
		2,
		196,
		{
			RTResTalkAction[42]
		},
		nil,
		0,
		3
	},
	[36317003] = {
		36317003,
		0,
		Lang.get(95684),
		36317,
		3,
		196,
		{
			RTResTalkAction[43]
		}
	},
	[36317004] = {
		36317004,
		0,
		Lang.get(95685),
		36317,
		4,
		1197,
		{
			RTResTalkAction[17],
			RTResTalkAction[41]
		}
	},
	[36317005] = {
		36317005,
		0,
		Lang.get(95686),
		36317,
		5,
		1196,
		{
			RTResTalkAction[10],
			RTResTalkAction[18]
		}
	},
	[36317006] = {
		36317006,
		0,
		Lang.get(95687),
		36317,
		6,
		292,
		{
			RTResTalkAction[1],
			RTResTalkAction[13],
			RTResTalkAction[15]
		}
	},
	[36317007] = {
		36317007,
		0,
		Lang.get(95688),
		36317,
		7,
		107,
		{
			RTResTalkAction[32],
			RTResTalkAction[5]
		}
	},
	[36317008] = {
		36317008,
		0,
		Lang.get(95689),
		36317,
		8,
		1196,
		{
			RTResTalkAction[9],
			RTResTalkAction[8],
			RTResTalkAction[3]
		}
	},
	[36318001] = {
		36318001,
		10,
		"87",
		36318,
		1,
		1196
	},
	[36318002] = {
		36318002,
		0,
		Lang.get(95690),
		36318,
		2,
		107,
		nil,
		1,
		5,
		nil,
		nil,
		62,
		36335,
		nil,
		1,
		nil,
		1,
		nil,
		36335
	},
	[36318003] = {
		36318003,
		4,
		nil,
		36318,
		3,
		107,
		nil,
		nil,
		0,
		3,
		[29] = {
			{
				id = 36318004,
				branch_content = Lang.get(95691)
			}
		}
	},
	[36318004] = {
		36318004,
		0,
		Lang.get(95692),
		36318,
		4,
		1196,
		{
			RTResTalkAction[9]
		}
	},
	[36318005] = {
		36318005,
		0,
		Lang.get(95693),
		36318,
		5,
		1197,
		{
			RTResTalkAction[10],
			RTResTalkAction[18]
		}
	},
	[36318006] = {
		36318006,
		4,
		nil,
		36318,
		6,
		1197,
		{
			RTResTalkAction[13],
			RTResTalkAction[15]
		},
		[29] = {
			{
				id = 36318007,
				branch_content = Lang.get(95694)
			}
		}
	},
	[36318007] = {
		36318007,
		0,
		Lang.get(95695),
		36318,
		7,
		107,
		{
			RTResTalkAction[70]
		}
	},
	[36318008] = {
		36318008,
		0,
		Lang.get(95696),
		36318,
		8,
		292,
		{
			RTResTalkAction[6],
			RTResTalkAction[5]
		}
	},
	[36318009] = {
		36318009,
		0,
		Lang.get(95697),
		36318,
		9,
		292,
		{
			RTResTalkAction[6],
			RTResTalkAction[34]
		}
	},
	[36318010] = {
		36318010,
		3,
		Lang.get(95698),
		36318,
		10,
		605,
		{
			RTResTalkAction[8],
			RTResTalkAction[3]
		},
		[22] = 1
	},
	[36318011] = {
		36318011,
		0,
		Lang.get(95699),
		36318,
		11,
		107,
		{
			RTResTalkAction[71]
		}
	},
	[36318012] = {
		36318012,
		0,
		Lang.get(95700),
		36318,
		12,
		292,
		{
			RTResTalkAction[6],
			RTResTalkAction[72]
		}
	},
	[36318013] = {
		36318013,
		4,
		nil,
		36318,
		13,
		292,
		{
			RTResTalkAction[8],
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 36318014,
				branch_content = Lang.get(95701)
			}
		}
	},
	[36318014] = {
		36318014,
		0,
		Lang.get(95702),
		36318,
		14,
		1196,
		{
			RTResTalkAction[10],
			RTResTalkAction[18]
		}
	},
	[36318015] = {
		36318015,
		0,
		Lang.get(95703),
		36318,
		15,
		1197,
		{
			RTResTalkAction[10],
			RTResTalkAction[18]
		}
	},
	[36319001] = {
		36319001,
		3,
		Lang.get(95704),
		36319,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		36336,
		nil,
		1,
		nil,
		1,
		nil,
		36336,
		nil,
		nil,
		1
	},
	[36319002] = {
		36319002,
		0,
		Lang.get(95705),
		36319,
		2,
		823,
		{
			RTResTalkAction[73]
		},
		nil,
		nil,
		3
	},
	[36319003] = {
		36319003,
		0,
		Lang.get(95706),
		36319,
		3,
		1197,
		{
			RTResTalkAction[17],
			RTResTalkAction[74]
		}
	},
	[36319004] = {
		36319004,
		0,
		Lang.get(95707),
		36319,
		4,
		1196,
		{
			RTResTalkAction[10],
			RTResTalkAction[18]
		}
	},
	[36319005] = {
		36319005,
		0,
		Lang.get(95708),
		36319,
		5,
		823,
		{
			RTResTalkAction[73],
			RTResTalkAction[13],
			RTResTalkAction[15]
		}
	},
	[36319006] = {
		36319006,
		0,
		Lang.get(95709),
		36319,
		6,
		824,
		{
			RTResTalkAction[75],
			RTResTalkAction[76]
		}
	},
	[36319007] = {
		36319007,
		0,
		Lang.get(95710),
		36319,
		7,
		823,
		{
			RTResTalkAction[75],
			RTResTalkAction[76]
		}
	},
	[36319008] = {
		36319008,
		0,
		Lang.get(95711),
		36319,
		8,
		824,
		{
			RTResTalkAction[75],
			RTResTalkAction[76]
		}
	},
	[36319009] = {
		36319009,
		0,
		Lang.get(95712),
		36319,
		9,
		823,
		{
			RTResTalkAction[75],
			RTResTalkAction[76]
		}
	},
	[36319010] = {
		36319010,
		0,
		Lang.get(95713),
		36319,
		10,
		823,
		{
			RTResTalkAction[75],
			RTResTalkAction[76]
		}
	},
	[36319011] = {
		36319011,
		0,
		Lang.get(95714),
		36319,
		11,
		1196,
		{
			RTResTalkAction[9],
			RTResTalkAction[74],
			RTResTalkAction[77]
		}
	},
	[36319012] = {
		36319012,
		0,
		Lang.get(95715),
		36319,
		12,
		1197,
		{
			RTResTalkAction[10],
			RTResTalkAction[18]
		}
	},
	[36319013] = {
		36319013,
		0,
		Lang.get(95716),
		36319,
		13,
		824,
		{
			RTResTalkAction[78],
			RTResTalkAction[13],
			RTResTalkAction[15]
		}
	},
	[36319014] = {
		36319014,
		0,
		Lang.get(95717),
		36319,
		14,
		605,
		{
			RTResTalkAction[77]
		}
	},
	[36319015] = {
		36319015,
		0,
		Lang.get(95718),
		36319,
		15,
		824,
		{
			RTResTalkAction[78]
		}
	},
	[36319016] = {
		36319016,
		0,
		Lang.get(95719),
		36319,
		16,
		823,
		{
			RTResTalkAction[75],
			RTResTalkAction[76]
		}
	},
	[36319017] = {
		36319017,
		0,
		Lang.get(95720),
		36319,
		17,
		823,
		{
			RTResTalkAction[75],
			RTResTalkAction[76]
		}
	},
	[36319018] = {
		36319018,
		0,
		Lang.get(95721),
		36319,
		18,
		1197,
		{
			RTResTalkAction[17],
			RTResTalkAction[74],
			RTResTalkAction[77]
		}
	},
	[36319019] = {
		36319019,
		0,
		Lang.get(95722),
		36319,
		19,
		824,
		{
			RTResTalkAction[79],
			RTResTalkAction[18]
		}
	},
	[36319020] = {
		36319020,
		0,
		Lang.get(95723),
		36319,
		20,
		1196,
		{
			RTResTalkAction[9],
			RTResTalkAction[77],
			RTResTalkAction[15]
		}
	},
	[36319021] = {
		36319021,
		0,
		Lang.get(95724),
		36319,
		21,
		1197,
		{
			RTResTalkAction[10],
			RTResTalkAction[18]
		}
	},
	[36319022] = {
		36319022,
		0,
		Lang.get(95725),
		36319,
		22,
		824,
		{
			RTResTalkAction[78],
			RTResTalkAction[13],
			RTResTalkAction[15]
		}
	},
	[36319023] = {
		36319023,
		3,
		Lang.get(95726),
		36319,
		23,
		605,
		{
			RTResTalkAction[77]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		36337,
		nil,
		1,
		nil,
		1,
		nil,
		36337,
		nil,
		nil,
		1
	},
	[36319024] = {
		36319024,
		0,
		Lang.get(95727),
		36319,
		24,
		107,
		{
			RTResTalkAction[80]
		},
		nil,
		nil,
		3
	},
	[36319025] = {
		36319025,
		0,
		Lang.get(95728),
		36319,
		25,
		292,
		{
			RTResTalkAction[6],
			RTResTalkAction[34]
		}
	},
	[36319026] = {
		36319026,
		0,
		Lang.get(95729),
		36319,
		26,
		292,
		{
			RTResTalkAction[6],
			RTResTalkAction[63]
		}
	},
	[36319027] = {
		36319027,
		0,
		Lang.get(95730),
		36319,
		27,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[36319028] = {
		36319028,
		0,
		Lang.get(95731),
		36319,
		28,
		292,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[36319029] = {
		36319029,
		0,
		Lang.get(95732),
		36319,
		29,
		1196,
		{
			RTResTalkAction[9],
			RTResTalkAction[8],
			RTResTalkAction[3]
		}
	},
	[36319030] = {
		36319030,
		0,
		Lang.get(95733),
		36319,
		30,
		1196,
		{
			RTResTalkAction[9]
		}
	},
	[36320001] = {
		36320001,
		0,
		Lang.get(95734),
		36320,
		1,
		107,
		nil,
		1,
		5,
		nil,
		nil,
		60,
		36338,
		nil,
		1,
		nil,
		1,
		nil,
		36338
	},
	[36320002] = {
		36320002,
		0,
		Lang.get(95735),
		36320,
		2,
		292,
		{
			RTResTalkAction[1]
		},
		nil,
		0,
		3
	},
	[36320003] = {
		36320003,
		0,
		Lang.get(95736),
		36320,
		3,
		292,
		{
			RTResTalkAction[37]
		}
	},
	[36320004] = {
		36320004,
		0,
		Lang.get(95737),
		36320,
		4,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[36320005] = {
		36320005,
		0,
		Lang.get(95738),
		36320,
		5,
		300,
		{
			RTResTalkAction[8],
			RTResTalkAction[3]
		}
	},
	[36320006] = {
		36320006,
		0,
		Lang.get(95739),
		36320,
		6,
		1196,
		{
			RTResTalkAction[9]
		}
	},
	[36320007] = {
		36320007,
		0,
		Lang.get(95740),
		36320,
		7,
		292,
		{
			RTResTalkAction[10],
			RTResTalkAction[5]
		}
	},
	[36320008] = {
		36320008,
		0,
		Lang.get(95741),
		36320,
		8,
		107,
		{
			RTResTalkAction[70],
			RTResTalkAction[13],
			RTResTalkAction[3]
		}
	},
	[36324001] = {
		36324001,
		0,
		Lang.get(95742),
		36324,
		1,
		664,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		36339,
		nil,
		1,
		nil,
		1,
		nil,
		36339
	},
	[36324002] = {
		36324002,
		0,
		Lang.get(95743),
		36324,
		2,
		581,
		nil,
		1,
		nil,
		3
	},
	[36324003] = {
		36324003,
		0,
		Lang.get(95744),
		36324,
		3,
		664,
		nil,
		1
	},
	[36324004] = {
		36324004,
		0,
		Lang.get(95745),
		36324,
		4,
		107,
		{
			RTResTalkAction[70]
		}
	},
	[36324005] = {
		36324005,
		0,
		Lang.get(95746),
		36324,
		5,
		1196,
		{
			RTResTalkAction[10],
			RTResTalkAction[81]
		}
	},
	[36321001] = {
		36321001,
		0,
		Lang.get(95747),
		36321,
		1,
		825,
		nil,
		1,
		nil,
		nil,
		nil,
		169,
		36340,
		nil,
		1,
		nil,
		1,
		nil,
		36340
	},
	[36321002] = {
		36321002,
		0,
		Lang.get(95748),
		36321,
		2,
		825,
		{
			RTResTalkAction[82]
		},
		nil,
		nil,
		3
	},
	[36321003] = {
		36321003,
		0,
		Lang.get(95749),
		36321,
		3,
		826,
		{
			RTResTalkAction[83],
			RTResTalkAction[84]
		}
	},
	[36321004] = {
		36321004,
		0,
		Lang.get(95750),
		36321,
		4,
		825,
		{
			RTResTalkAction[82],
			RTResTalkAction[85]
		}
	},
	[36321005] = {
		36321005,
		0,
		Lang.get(95751),
		36321,
		5,
		107,
		{
			RTResTalkAction[80],
			RTResTalkAction[84]
		}
	},
	[36321006] = {
		36321006,
		0,
		Lang.get(95752),
		36321,
		6,
		107,
		{
			RTResTalkAction[70]
		}
	},
	[36321007] = {
		36321007,
		0,
		Lang.get(95753),
		36321,
		7,
		300,
		{
			RTResTalkAction[8]
		}
	},
	[36321008] = {
		36321008,
		0,
		Lang.get(95754),
		36321,
		8,
		292,
		{
			RTResTalkAction[2]
		}
	},
	[36321009] = {
		36321009,
		0,
		Lang.get(95755),
		36321,
		9,
		292,
		{
			RTResTalkAction[2]
		}
	},
	[36321010] = {
		36321010,
		0,
		Lang.get(95756),
		36321,
		10,
		107,
		{
			RTResTalkAction[86],
			RTResTalkAction[3]
		},
		1,
		5,
		nil,
		nil,
		nil,
		36369,
		nil,
		1,
		nil,
		1,
		nil,
		36369,
		nil,
		425
	},
	[36321011] = {
		36321011,
		0,
		Lang.get(95757),
		36321,
		11,
		107,
		{
			RTResTalkAction[86]
		},
		1,
		7,
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
		425
	},
	[36321012] = {
		36321012,
		0,
		Lang.get(95758),
		36321,
		12,
		292,
		{
			RTResTalkAction[86]
		},
		1,
		0,
		[21] = 425
	},
	[36321013] = {
		36321013,
		0,
		Lang.get(95759),
		36321,
		13,
		826,
		{
			RTResTalkAction[83],
			RTResTalkAction[87]
		}
	},
	[36321014] = {
		36321014,
		0,
		Lang.get(95760),
		36321,
		14,
		826,
		{
			RTResTalkAction[83]
		}
	},
	[36321015] = {
		36321015,
		0,
		Lang.get(95761),
		36321,
		15,
		825,
		{
			RTResTalkAction[82],
			RTResTalkAction[85]
		}
	},
	[36322001] = {
		36322001,
		0,
		Lang.get(95762),
		36322,
		1,
		1196,
		nil,
		1,
		nil,
		nil,
		nil,
		199,
		36370,
		nil,
		1,
		nil,
		1,
		nil,
		36370
	},
	[36322002] = {
		36322002,
		4,
		nil,
		36322,
		2,
		1196,
		nil,
		nil,
		nil,
		3,
		[29] = {
			{
				id = 36322003,
				branch_content = Lang.get(95763)
			}
		}
	},
	[36322003] = {
		36322003,
		0,
		Lang.get(95764),
		36322,
		3,
		1196,
		{
			RTResTalkAction[9]
		}
	},
	[36322004] = {
		36322004,
		0,
		Lang.get(95765),
		36322,
		4,
		300,
		{
			RTResTalkAction[13]
		}
	},
	[36322005] = {
		36322005,
		0,
		Lang.get(95766),
		36322,
		5,
		1196,
		{
			RTResTalkAction[9]
		}
	},
	[36322006] = {
		36322006,
		0,
		Lang.get(95767),
		36322,
		6,
		300,
		{
			RTResTalkAction[13]
		}
	},
	[36322007] = {
		36322007,
		0,
		Lang.get(95768),
		36322,
		7,
		196,
		nil,
		1,
		3,
		nil,
		nil,
		nil,
		36371,
		nil,
		1,
		nil,
		1,
		nil,
		36371
	},
	[36322008] = {
		36322008,
		0,
		Lang.get(95769),
		36322,
		8,
		196,
		{
			RTResTalkAction[39]
		},
		nil,
		0,
		3
	},
	[36322009] = {
		36322009,
		0,
		Lang.get(95770),
		36322,
		9,
		1196,
		{
			RTResTalkAction[10],
			RTResTalkAction[66]
		}
	},
	[36322010] = {
		36322010,
		0,
		Lang.get(95771),
		36322,
		10,
		300,
		{
			RTResTalkAction[13],
			RTResTalkAction[41]
		}
	},
	[36322011] = {
		36322011,
		0,
		Lang.get(95772),
		36322,
		11,
		196,
		{
			RTResTalkAction[44]
		}
	},
	[36322012] = {
		36322012,
		0,
		Lang.get(95773),
		36322,
		12,
		196,
		{
			RTResTalkAction[43]
		}
	},
	[36322013] = {
		36322013,
		0,
		Lang.get(95774),
		36322,
		13,
		300,
		{
			RTResTalkAction[41]
		}
	},
	[36322014] = {
		36322014,
		0,
		Lang.get(95775),
		36322,
		14,
		1196,
		{
			RTResTalkAction[9]
		}
	},
	[36322015] = {
		36322015,
		0,
		Lang.get(95776),
		36322,
		15,
		196,
		{
			RTResTalkAction[10],
			RTResTalkAction[67]
		}
	},
	[36322016] = {
		36322016,
		0,
		Lang.get(95777),
		36322,
		16,
		196,
		{
			RTResTalkAction[44],
			RTResTalkAction[13]
		}
	},
	[36322017] = {
		36322017,
		0,
		Lang.get(95778),
		36322,
		17,
		1196,
		{
			RTResTalkAction[41]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		36372,
		nil,
		1,
		nil,
		1,
		nil,
		36372
	},
	[36322018] = {
		36322018,
		0,
		Lang.get(95779),
		36322,
		18,
		300,
		nil,
		nil,
		nil,
		3
	},
	[36322019] = {
		36322019,
		0,
		Lang.get(95780),
		36322,
		19,
		1196,
		{
			RTResTalkAction[9]
		}
	},
	[36322020] = {
		36322020,
		0,
		Lang.get(95781),
		36322,
		20,
		1197,
		{
			RTResTalkAction[13]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		36373,
		nil,
		1,
		nil,
		1,
		nil,
		36373
	},
	[36322021] = {
		36322021,
		0,
		Lang.get(95782),
		36322,
		21,
		1196,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[36322022] = {
		36322022,
		0,
		Lang.get(95783),
		36322,
		22,
		1197,
		{
			RTResTalkAction[10],
			RTResTalkAction[18]
		}
	},
	[36322023] = {
		36322023,
		0,
		Lang.get(95784),
		36322,
		23,
		300,
		{
			RTResTalkAction[13],
			RTResTalkAction[15]
		}
	},
	[36322024] = {
		36322024,
		0,
		Lang.get(95785),
		36322,
		24,
		1196,
		{
			RTResTalkAction[10],
			RTResTalkAction[18]
		}
	},
	[36322025] = {
		36322025,
		0,
		Lang.get(95786),
		36322,
		25,
		1197,
		{
			RTResTalkAction[10],
			RTResTalkAction[18]
		}
	},
	[36322026] = {
		36322026,
		0,
		Lang.get(95787),
		36322,
		26,
		1196,
		{
			RTResTalkAction[10],
			RTResTalkAction[18]
		}
	},
	[36322027] = {
		36322027,
		0,
		Lang.get(95788),
		36322,
		27,
		1196,
		{
			RTResTalkAction[10],
			RTResTalkAction[18]
		}
	},
	[36322028] = {
		36322028,
		0,
		Lang.get(95789),
		36322,
		28,
		300,
		{
			RTResTalkAction[13],
			RTResTalkAction[15]
		}
	},
	[36322029] = {
		36322029,
		0,
		Lang.get(95790),
		36322,
		29,
		1196,
		{
			RTResTalkAction[9]
		}
	},
	[36322030] = {
		36322030,
		3,
		Lang.get(95791),
		36322,
		30,
		605,
		{
			RTResTalkAction[13]
		},
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
