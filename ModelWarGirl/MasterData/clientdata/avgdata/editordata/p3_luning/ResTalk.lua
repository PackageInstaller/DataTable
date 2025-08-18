-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\P3_luning\\ResTalk.lua

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
	[2] = 282
}
RTResTalkAction[2] = {
	[1] = 1,
	[2] = 269
}
RTResTalkAction[3] = {
	[1] = 1,
	[2] = 270
}
RTResTalkAction[4] = {
	[1] = 0,
	[2] = 270
}
RTResTalkAction[5] = {
	[1] = 1,
	[2] = 284
}
RTResTalkAction[6] = {
	[1] = 0,
	[2] = 284
}
RTResTalkAction[7] = {
	[1] = 1,
	[2] = 220
}
RTResTalkAction[8] = {
	[1] = 0,
	[2] = 220
}
RTResTalkAction[9] = {
	[1] = 1,
	[2] = 215
}
RTResTalkAction[10] = {
	[1] = 0,
	[2] = 215
}
RTResTalkAction[11] = {
	[1] = 1,
	[2] = 286
}
RTResTalkAction[12] = {
	[1] = 0,
	[2] = 286
}
RTResTalkAction[13] = {
	[1] = 1,
	[2] = 719
}
RTResTalkAction[14] = {
	[1] = 0,
	[2] = 719
}
RTResTalkAction[15] = {
	[1] = 1,
	[2] = 750
}
RTResTalkAction[16] = {
	[1] = 0,
	[2] = 750
}
RTResTalkAction[17] = {
	[1] = 1,
	[2] = 752
}
RTResTalkAction[18] = {
	[1] = 0,
	[2] = 752
}
RTResTalkAction[19] = {
	[1] = 1,
	[2] = 196
}
RTResTalkAction[20] = {
	[1] = 0,
	[2] = 196
}
RTResTalkAction[21] = {
	[1] = 1,
	[2] = 147
}
RTResTalkAction[22] = {
	[1] = 0,
	[2] = 147
}
RTResTalkAction[23] = {
	[1] = 1,
	[2] = 287
}
RTResTalkAction[24] = {
	[1] = 0,
	[2] = 287
}
RTResTalkAction[25] = {
	[1] = 1,
	[2] = 740
}
RTResTalkAction[26] = {
	[1] = 0,
	[2] = 740
}
RTResTalkAction[27] = {
	[1] = 1,
	[2] = 188
}
RTResTalkAction[28] = {
	[1] = 1,
	[2] = 159
}
RTResTalkAction[29] = {
	[1] = 0,
	[2] = 159
}
RTResTalkAction[30] = {
	[1] = 1,
	[2] = 301
}
RTResTalkAction[31] = {
	[1] = 0,
	[2] = 301
}
RTResTalkAction[32] = {
	[1] = 1,
	[2] = 194
}
RTResTalkAction[33] = {
	[1] = 0,
	[2] = 194
}
RTResTalkAction[34] = {
	[1] = 1,
	[2] = 167
}
RTResTalkAction[35] = {
	[1] = 0,
	[2] = 167
}
RTResTalkAction[36] = {
	[1] = 1,
	[2] = 110
}
RTResTalkAction[37] = {
	[1] = 0,
	[2] = 110
}
RTResTalkAction[38] = {
	[1] = 1
}
RTResTalkAction[39] = {
	[1] = 0
}
RTResTalkAction[40] = {
	[1] = 1,
	[2] = 698
}
RTResTalkAction[41] = {
	[1] = 1,
	[2] = 224
}
RTResTalkAction[42] = {
	[1] = 0,
	[2] = 224
}
RTResTalkAction[43] = {
	[1] = 1,
	[2] = 226
}
RTResTalkAction[44] = {
	[1] = 0,
	[2] = 226
}
RTResTalkAction[45] = {
	[1] = 1,
	[2] = 257
}
RTResTalkAction[46] = {
	[1] = 0,
	[2] = 257
}
RTResTalkAction[47] = {
	[1] = 1,
	[2] = 290
}
RTResTalkAction[48] = {
	[1] = 0,
	[2] = 290
}
RTResTalkAction[49] = {
	[1] = 1,
	[2] = 1196
}
RTResTalkAction[50] = {
	[1] = 0,
	[2] = 1196
}
RTResTalkAction[51] = {
	[1] = 1,
	[2] = 1197
}
RTResTalkAction[52] = {
	[1] = 0,
	[2] = 1197
}
RTResTalkAction[53] = {
	[1] = 1,
	[2] = 1267
}
RTResTalkAction[54] = {
	1,
	1267,
	nil,
	nil,
	1
}
RTResTalkAction[55] = {
	1,
	1267,
	nil,
	nil,
	0
}
RTResTalkAction[56] = {
	[1] = 0,
	[2] = 1267
}
RTResTalkAction[57] = {
	1,
	1267,
	nil,
	nil,
	2
}
RTResTalkAction[58] = {
	[1] = 1,
	[2] = 1268
}
RTResTalkAction[59] = {
	1,
	1268,
	nil,
	nil,
	2
}
RTResTalkAction[60] = {
	1,
	1266,
	nil,
	nil,
	0
}
RTResTalkAction[61] = {
	[1] = 0,
	[2] = 1268
}
RTResTalkAction[62] = {
	[1] = 1,
	[2] = 1266
}
RTResTalkAction[63] = {
	[1] = 0,
	[2] = 1266
}
RTResTalkAction[64] = {
	1,
	1268,
	nil,
	nil,
	1
}
RTResTalkAction[65] = {
	1,
	1266,
	nil,
	nil,
	2
}
RTResTalkAction[66] = {
	1,
	1268,
	nil,
	nil,
	0
}
RTResTalkAction[67] = {
	[1] = 1,
	[2] = 1268,
	[3] = {
		1
	}
}
RTResTalkAction[68] = {
	[1] = 1,
	[2] = 1269
}
RTResTalkAction[69] = {
	[1] = 0,
	[2] = 1269
}
RTResTalkAction[70] = {
	[1] = 1,
	[2] = 1296
}
RTResTalkAction[71] = {
	[1] = 1,
	[2] = 1298
}
RTResTalkAction[72] = {
	[1] = 0,
	[2] = 1298
}
RTResTalkAction[73] = {
	[1] = 1,
	[2] = 1299
}
RTResTalkAction[74] = {
	[1] = 0,
	[2] = 1299
}
RTResTalkAction[75] = {
	[1] = 1,
	[2] = 1118
}
RTResTalkAction[76] = {
	[1] = 0,
	[2] = 1118
}
RTResTalkAction[77] = {
	[1] = 1,
	[2] = 1301
}
RTResTalkAction[78] = {
	[1] = 0,
	[2] = 1301
}
RTResTalkAction[79] = {
	[1] = 1,
	[2] = 1303
}
RTResTalkAction[80] = {
	[1] = 1,
	[2] = 1302
}
RTResTalkAction[81] = {
	[1] = 1,
	[2] = 1306
}

local Data = {
	[28500001] = {
		28500001,
		0,
		Lang.get(65084),
		28500,
		1,
		282,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		28500,
		nil,
		nil,
		nil,
		nil,
		nil,
		28500
	},
	[28500002] = {
		28500002,
		4,
		nil,
		28500,
		2,
		282,
		nil,
		1,
		[29] = {
			{
				id = 28500003,
				branch_content = Lang.get(65085)
			}
		}
	},
	[28500003] = {
		28500003,
		0,
		Lang.get(65086),
		28500,
		3,
		282,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[28500004] = {
		28500004,
		0,
		Lang.get(65087),
		28500,
		4,
		282,
		{
			RTResTalkAction[1]
		}
	},
	[28500005] = {
		28500005,
		0,
		Lang.get(65088),
		28500,
		5,
		282,
		{
			RTResTalkAction[1]
		}
	},
	[28500006] = {
		28500006,
		4,
		nil,
		28500,
		6,
		282,
		{
			RTResTalkAction[1]
		},
		[29] = {
			{
				id = 28500007,
				branch_content = Lang.get(65089)
			}
		}
	},
	[28500007] = {
		28500007,
		0,
		Lang.get(65090),
		28500,
		7,
		282,
		{
			RTResTalkAction[1]
		}
	},
	[28500008] = {
		28500008,
		0,
		Lang.get(65091),
		28500,
		8,
		282,
		{
			RTResTalkAction[1]
		}
	},
	[28500009] = {
		28500009,
		4,
		nil,
		28500,
		9,
		282,
		{
			RTResTalkAction[1]
		},
		[29] = {
			{
				id = 28500010,
				branch_content = Lang.get(65092)
			}
		}
	},
	[28500010] = {
		28500010,
		0,
		Lang.get(65093),
		28500,
		10,
		282,
		{
			RTResTalkAction[1]
		}
	},
	[28500011] = {
		28500011,
		0,
		Lang.get(65094),
		28500,
		11,
		282,
		{
			RTResTalkAction[1]
		}
	},
	[28500012] = {
		28500012,
		0,
		Lang.get(65095),
		28500,
		12,
		282,
		{
			RTResTalkAction[1]
		}
	},
	[28500013] = {
		28500013,
		0,
		Lang.get(65096),
		28500,
		13,
		282,
		{
			RTResTalkAction[1]
		}
	},
	[28500014] = {
		28500014,
		4,
		nil,
		28500,
		14,
		282,
		{
			RTResTalkAction[1]
		},
		[29] = {
			{
				id = 28500015,
				branch_content = Lang.get(65097)
			}
		}
	},
	[28500015] = {
		28500015,
		0,
		Lang.get(65098),
		28500,
		15,
		282,
		{
			RTResTalkAction[1]
		}
	},
	[28501001] = {
		28501001,
		0,
		Lang.get(65099),
		28501,
		1,
		269,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		28501,
		nil,
		nil,
		nil,
		nil,
		nil,
		28501
	},
	[28501002] = {
		28501002,
		4,
		nil,
		28501,
		2,
		269,
		nil,
		1,
		[29] = {
			{
				id = 28501003,
				branch_content = Lang.get(65100)
			}
		}
	},
	[28501003] = {
		28501003,
		0,
		Lang.get(65101),
		28501,
		3,
		269,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[28501004] = {
		28501004,
		0,
		Lang.get(65102),
		28501,
		4,
		269,
		{
			RTResTalkAction[2]
		}
	},
	[28501005] = {
		28501005,
		0,
		Lang.get(65103),
		28501,
		5,
		269,
		{
			RTResTalkAction[2]
		}
	},
	[28501006] = {
		28501006,
		4,
		nil,
		28501,
		6,
		269,
		{
			RTResTalkAction[2]
		},
		[29] = {
			{
				id = 28501007,
				branch_content = Lang.get(65104)
			}
		}
	},
	[28501007] = {
		28501007,
		0,
		Lang.get(65105),
		28501,
		7,
		269,
		{
			RTResTalkAction[2]
		}
	},
	[28501008] = {
		28501008,
		0,
		Lang.get(65106),
		28501,
		8,
		269,
		{
			RTResTalkAction[2]
		}
	},
	[28501009] = {
		28501009,
		0,
		Lang.get(65107),
		28501,
		9,
		269,
		{
			RTResTalkAction[2]
		}
	},
	[28501010] = {
		28501010,
		0,
		Lang.get(65108),
		28501,
		10,
		269,
		{
			RTResTalkAction[2]
		}
	},
	[28501011] = {
		28501011,
		4,
		nil,
		28501,
		11,
		269,
		{
			RTResTalkAction[2]
		},
		[29] = {
			{
				id = 28501012,
				branch_content = Lang.get(65109)
			}
		}
	},
	[28501012] = {
		28501012,
		0,
		Lang.get(65110),
		28501,
		12,
		269,
		{
			RTResTalkAction[2]
		}
	},
	[28501013] = {
		28501013,
		0,
		Lang.get(65111),
		28501,
		13,
		269,
		{
			RTResTalkAction[2]
		}
	},
	[28501014] = {
		28501014,
		0,
		Lang.get(65112),
		28501,
		14,
		269,
		{
			RTResTalkAction[2]
		}
	},
	[28501015] = {
		28501015,
		4,
		nil,
		28501,
		15,
		269,
		{
			RTResTalkAction[2]
		},
		[29] = {
			{
				id = 28501016,
				branch_content = Lang.get(65113)
			}
		}
	},
	[28501016] = {
		28501016,
		0,
		Lang.get(65114),
		28501,
		16,
		269,
		{
			RTResTalkAction[2]
		}
	},
	[28502001] = {
		28502001,
		0,
		Lang.get(65115),
		28502,
		1,
		269,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		28502,
		nil,
		nil,
		nil,
		nil,
		nil,
		28502
	},
	[28502002] = {
		28502002,
		0,
		Lang.get(65116),
		28502,
		2,
		269,
		nil,
		1
	},
	[28502003] = {
		28502003,
		0,
		Lang.get(65117),
		28502,
		3,
		269,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[28502004] = {
		28502004,
		4,
		nil,
		28502,
		4,
		269,
		{
			RTResTalkAction[2]
		},
		[29] = {
			{
				id = 28502005,
				branch_content = Lang.get(65118)
			}
		}
	},
	[28502005] = {
		28502005,
		0,
		Lang.get(65119),
		28502,
		5,
		269,
		{
			RTResTalkAction[2]
		}
	},
	[28502006] = {
		28502006,
		0,
		Lang.get(65120),
		28502,
		6,
		269,
		{
			RTResTalkAction[2]
		}
	},
	[28502007] = {
		28502007,
		0,
		Lang.get(65121),
		28502,
		7,
		269,
		{
			RTResTalkAction[2]
		}
	},
	[28502008] = {
		28502008,
		0,
		Lang.get(65122),
		28502,
		8,
		269,
		{
			RTResTalkAction[2]
		}
	},
	[28502009] = {
		28502009,
		4,
		nil,
		28502,
		9,
		269,
		{
			RTResTalkAction[2]
		},
		[29] = {
			{
				id = 28502010,
				branch_content = Lang.get(65123)
			}
		}
	},
	[28502010] = {
		28502010,
		0,
		Lang.get(65124),
		28502,
		10,
		269,
		{
			RTResTalkAction[2]
		}
	},
	[28502011] = {
		28502011,
		0,
		Lang.get(65125),
		28502,
		11,
		269,
		{
			RTResTalkAction[2]
		}
	},
	[28502012] = {
		28502012,
		0,
		Lang.get(65126),
		28502,
		12,
		269,
		{
			RTResTalkAction[2]
		}
	},
	[28502013] = {
		28502013,
		4,
		nil,
		28502,
		13,
		269,
		{
			RTResTalkAction[2]
		},
		[29] = {
			{
				id = 28502014,
				branch_content = Lang.get(64732)
			}
		}
	},
	[28502014] = {
		28502014,
		0,
		Lang.get(65127),
		28502,
		14,
		269,
		{
			RTResTalkAction[2]
		}
	},
	[28502015] = {
		28502015,
		0,
		Lang.get(65128),
		28502,
		15,
		269,
		{
			RTResTalkAction[2]
		}
	},
	[28503001] = {
		28503001,
		0,
		Lang.get(65129),
		28503,
		1,
		270,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		28503,
		nil,
		nil,
		nil,
		nil,
		nil,
		28503
	},
	[28503002] = {
		28503002,
		4,
		nil,
		28503,
		2,
		270,
		nil,
		1,
		[29] = {
			{
				id = 28503003,
				branch_content = Lang.get(18979)
			}
		}
	},
	[28503003] = {
		28503003,
		0,
		Lang.get(65130),
		28503,
		3,
		270,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[28503004] = {
		28503004,
		0,
		Lang.get(65131),
		28503,
		4,
		270,
		{
			RTResTalkAction[3]
		}
	},
	[28503005] = {
		28503005,
		0,
		Lang.get(65132),
		28503,
		5,
		270,
		{
			RTResTalkAction[3]
		}
	},
	[28503006] = {
		28503006,
		4,
		nil,
		28503,
		6,
		270,
		{
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 28503007,
				branch_content = Lang.get(65133)
			}
		}
	},
	[28503007] = {
		28503007,
		0,
		Lang.get(65134),
		28503,
		7,
		270,
		{
			RTResTalkAction[3]
		}
	},
	[28503008] = {
		28503008,
		0,
		Lang.get(65135),
		28503,
		8,
		270,
		{
			RTResTalkAction[3]
		}
	},
	[28503009] = {
		28503009,
		0,
		Lang.get(65136),
		28503,
		9,
		270,
		{
			RTResTalkAction[3]
		}
	},
	[28503010] = {
		28503010,
		5,
		Lang.get(65137),
		28503,
		10,
		300,
		{
			RTResTalkAction[4]
		}
	},
	[28503011] = {
		28503011,
		0,
		Lang.get(65138),
		28503,
		11,
		270,
		{
			RTResTalkAction[3]
		}
	},
	[28503012] = {
		28503012,
		0,
		Lang.get(65139),
		28503,
		12,
		270,
		{
			RTResTalkAction[3]
		}
	},
	[28503013] = {
		28503013,
		4,
		nil,
		28503,
		13,
		270,
		{
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 28503014,
				branch_content = Lang.get(65140)
			}
		}
	},
	[28503014] = {
		28503014,
		0,
		Lang.get(65141),
		28503,
		14,
		270,
		{
			RTResTalkAction[3]
		}
	},
	[28503015] = {
		28503015,
		0,
		Lang.get(65142),
		28503,
		15,
		270,
		{
			RTResTalkAction[3]
		}
	},
	[28504001] = {
		28504001,
		0,
		Lang.get(65143),
		28504,
		1,
		270,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		28504,
		nil,
		nil,
		nil,
		nil,
		nil,
		28504
	},
	[28504002] = {
		28504002,
		0,
		Lang.get(65144),
		28504,
		2,
		270,
		nil,
		1
	},
	[28504003] = {
		28504003,
		0,
		Lang.get(65145),
		28504,
		3,
		270,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[28504004] = {
		28504004,
		0,
		Lang.get(65146),
		28504,
		4,
		270,
		{
			RTResTalkAction[3]
		}
	},
	[28504005] = {
		28504005,
		4,
		nil,
		28504,
		5,
		270,
		{
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 28504006,
				branch_content = Lang.get(65147)
			}
		}
	},
	[28504006] = {
		28504006,
		0,
		Lang.get(65148),
		28504,
		6,
		270,
		{
			RTResTalkAction[3]
		}
	},
	[28504007] = {
		28504007,
		0,
		Lang.get(65149),
		28504,
		7,
		270,
		{
			RTResTalkAction[3]
		}
	},
	[28504008] = {
		28504008,
		0,
		Lang.get(65150),
		28504,
		8,
		270,
		{
			RTResTalkAction[3]
		}
	},
	[28504009] = {
		28504009,
		4,
		nil,
		28504,
		9,
		270,
		{
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 28504010,
				branch_content = Lang.get(65151)
			}
		}
	},
	[28504010] = {
		28504010,
		0,
		Lang.get(65152),
		28504,
		10,
		270,
		{
			RTResTalkAction[3]
		}
	},
	[28504011] = {
		28504011,
		0,
		Lang.get(65153),
		28504,
		11,
		270,
		{
			RTResTalkAction[3]
		}
	},
	[28504012] = {
		28504012,
		0,
		Lang.get(65154),
		28504,
		12,
		270,
		{
			RTResTalkAction[3]
		}
	},
	[28504013] = {
		28504013,
		4,
		nil,
		28504,
		13,
		270,
		{
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 28504014,
				branch_content = Lang.get(65155)
			}
		}
	},
	[28504014] = {
		28504014,
		0,
		Lang.get(65156),
		28504,
		14,
		270,
		{
			RTResTalkAction[3]
		}
	},
	[28504015] = {
		28504015,
		0,
		Lang.get(65157),
		28504,
		15,
		270,
		{
			RTResTalkAction[3]
		}
	},
	[28504016] = {
		28504016,
		0,
		Lang.get(65158),
		28504,
		16,
		270,
		{
			RTResTalkAction[3]
		}
	},
	[28504017] = {
		28504017,
		0,
		Lang.get(65159),
		28504,
		17,
		300,
		{
			RTResTalkAction[4]
		}
	},
	[28505001] = {
		28505001,
		0,
		Lang.get(65160),
		28505,
		1,
		284,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		28505,
		nil,
		nil,
		nil,
		nil,
		nil,
		28505
	},
	[28505002] = {
		28505002,
		4,
		nil,
		28505,
		2,
		284,
		nil,
		1,
		[29] = {
			{
				id = 28505003,
				branch_content = Lang.get(65161)
			}
		}
	},
	[28505003] = {
		28505003,
		0,
		Lang.get(65162),
		28505,
		3,
		284,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		3
	},
	[28505004] = {
		28505004,
		0,
		Lang.get(65163),
		28505,
		4,
		284,
		{
			RTResTalkAction[5]
		}
	},
	[28505005] = {
		28505005,
		4,
		nil,
		28505,
		5,
		284,
		{
			RTResTalkAction[5]
		},
		[29] = {
			{
				id = 28505006,
				branch_content = Lang.get(65164)
			}
		}
	},
	[28505006] = {
		28505006,
		0,
		Lang.get(65165),
		28505,
		6,
		284,
		{
			RTResTalkAction[5]
		}
	},
	[28505007] = {
		28505007,
		0,
		Lang.get(65166),
		28505,
		7,
		284,
		{
			RTResTalkAction[5]
		}
	},
	[28505008] = {
		28505008,
		4,
		nil,
		28505,
		8,
		284,
		{
			RTResTalkAction[5]
		},
		[29] = {
			{
				id = 28505009,
				branch_content = Lang.get(65167)
			}
		}
	},
	[28505009] = {
		28505009,
		0,
		Lang.get(65168),
		28505,
		9,
		284,
		{
			RTResTalkAction[5]
		}
	},
	[28505010] = {
		28505010,
		0,
		Lang.get(65169),
		28505,
		10,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[28505011] = {
		28505011,
		0,
		Lang.get(65170),
		28505,
		11,
		284,
		{
			RTResTalkAction[5]
		}
	},
	[28505012] = {
		28505012,
		4,
		nil,
		28505,
		12,
		284,
		{
			RTResTalkAction[5]
		},
		[29] = {
			{
				id = 28505013,
				branch_content = Lang.get(65171)
			},
			{
				id = 28505013,
				branch_content = Lang.get(65172)
			}
		}
	},
	[28505013] = {
		28505013,
		0,
		Lang.get(65173),
		28505,
		13,
		284,
		{
			RTResTalkAction[5]
		}
	},
	[28505014] = {
		28505014,
		0,
		Lang.get(65174),
		28505,
		14,
		284,
		{
			RTResTalkAction[5]
		}
	},
	[28506001] = {
		28506001,
		0,
		Lang.get(65175),
		28506,
		1,
		220,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		28506,
		nil,
		nil,
		nil,
		nil,
		nil,
		28506
	},
	[28506002] = {
		28506002,
		0,
		Lang.get(65176),
		28506,
		2,
		300
	},
	[28506003] = {
		28506003,
		0,
		Lang.get(65177),
		28506,
		3,
		220,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3
	},
	[28506004] = {
		28506004,
		4,
		nil,
		28506,
		4,
		220,
		{
			RTResTalkAction[7]
		},
		[29] = {
			{
				id = 28506005,
				branch_content = Lang.get(65178)
			}
		}
	},
	[28506005] = {
		28506005,
		0,
		Lang.get(65179),
		28506,
		5,
		220,
		{
			RTResTalkAction[7]
		}
	},
	[28506006] = {
		28506006,
		0,
		Lang.get(65180),
		28506,
		6,
		300,
		{
			RTResTalkAction[8]
		}
	},
	[28506007] = {
		28506007,
		0,
		Lang.get(65181),
		28506,
		7,
		220,
		{
			RTResTalkAction[7]
		}
	},
	[28506008] = {
		28506008,
		0,
		Lang.get(65182),
		28506,
		8,
		220,
		{
			RTResTalkAction[7]
		}
	},
	[28506009] = {
		28506009,
		0,
		Lang.get(65183),
		28506,
		9,
		220,
		{
			RTResTalkAction[7]
		}
	},
	[28506010] = {
		28506010,
		4,
		nil,
		28506,
		10,
		220,
		{
			RTResTalkAction[7]
		},
		[29] = {
			{
				id = 28506011,
				branch_content = Lang.get(65184)
			}
		}
	},
	[28506011] = {
		28506011,
		0,
		Lang.get(65185),
		28506,
		11,
		220,
		{
			RTResTalkAction[7]
		}
	},
	[28506012] = {
		28506012,
		0,
		Lang.get(65186),
		28506,
		12,
		220,
		{
			RTResTalkAction[7]
		}
	},
	[28506013] = {
		28506013,
		0,
		Lang.get(65187),
		28506,
		13,
		220,
		{
			RTResTalkAction[7]
		}
	},
	[28506014] = {
		28506014,
		0,
		Lang.get(65188),
		28506,
		14,
		220,
		{
			RTResTalkAction[7]
		}
	},
	[28506015] = {
		28506015,
		0,
		Lang.get(65189),
		28506,
		15,
		220,
		{
			RTResTalkAction[7]
		}
	},
	[28507001] = {
		28507001,
		0,
		Lang.get(65190),
		28507,
		1,
		220,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		28507,
		nil,
		nil,
		nil,
		nil,
		nil,
		28507
	},
	[28507002] = {
		28507002,
		0,
		Lang.get(65191),
		28507,
		2,
		300
	},
	[28507003] = {
		28507003,
		0,
		Lang.get(65192),
		28507,
		3,
		220,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3
	},
	[28507004] = {
		28507004,
		0,
		Lang.get(65193),
		28507,
		4,
		220,
		{
			RTResTalkAction[7]
		}
	},
	[28507005] = {
		28507005,
		0,
		Lang.get(65194),
		28507,
		5,
		220,
		{
			RTResTalkAction[7]
		}
	},
	[28507006] = {
		28507006,
		0,
		Lang.get(65195),
		28507,
		6,
		220,
		{
			RTResTalkAction[7]
		}
	},
	[28507007] = {
		28507007,
		4,
		nil,
		28507,
		7,
		220,
		{
			RTResTalkAction[7]
		},
		[29] = {
			{
				id = 28507008,
				branch_content = Lang.get(65196)
			},
			{
				id = 28507008,
				branch_content = Lang.get(65197)
			}
		}
	},
	[28507008] = {
		28507008,
		0,
		Lang.get(65198),
		28507,
		8,
		220,
		{
			RTResTalkAction[7]
		}
	},
	[28507009] = {
		28507009,
		0,
		Lang.get(65199),
		28507,
		9,
		220,
		{
			RTResTalkAction[7]
		}
	},
	[28507010] = {
		28507010,
		0,
		Lang.get(65200),
		28507,
		10,
		300,
		{
			RTResTalkAction[8]
		}
	},
	[28507011] = {
		28507011,
		0,
		Lang.get(65201),
		28507,
		11,
		220,
		{
			RTResTalkAction[7]
		}
	},
	[28507012] = {
		28507012,
		0,
		Lang.get(65202),
		28507,
		12,
		220,
		{
			RTResTalkAction[7]
		}
	},
	[28507013] = {
		28507013,
		0,
		Lang.get(65203),
		28507,
		13,
		220,
		{
			RTResTalkAction[7]
		}
	},
	[28507014] = {
		28507014,
		0,
		Lang.get(65204),
		28507,
		14,
		220,
		{
			RTResTalkAction[7]
		}
	},
	[28507015] = {
		28507015,
		0,
		Lang.get(65205),
		28507,
		15,
		220,
		{
			RTResTalkAction[7]
		}
	},
	[28508001] = {
		28508001,
		0,
		Lang.get(65206),
		28508,
		1,
		220,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		28508,
		nil,
		nil,
		nil,
		nil,
		nil,
		28508
	},
	[28508002] = {
		28508002,
		4,
		nil,
		28508,
		2,
		220,
		nil,
		1,
		[29] = {
			{
				id = 28508003,
				branch_content = Lang.get(65207)
			}
		}
	},
	[28508003] = {
		28508003,
		0,
		Lang.get(65208),
		28508,
		3,
		220,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3
	},
	[28508004] = {
		28508004,
		0,
		Lang.get(65209),
		28508,
		4,
		300,
		{
			RTResTalkAction[8]
		}
	},
	[28508005] = {
		28508005,
		0,
		Lang.get(65210),
		28508,
		5,
		220,
		{
			RTResTalkAction[7]
		}
	},
	[28508006] = {
		28508006,
		4,
		nil,
		28508,
		6,
		220,
		{
			RTResTalkAction[7]
		},
		[29] = {
			{
				id = 28508007,
				branch_content = Lang.get(65211)
			}
		}
	},
	[28508007] = {
		28508007,
		0,
		Lang.get(65212),
		28508,
		7,
		220,
		{
			RTResTalkAction[7]
		}
	},
	[28508008] = {
		28508008,
		4,
		nil,
		28508,
		8,
		220,
		{
			RTResTalkAction[7]
		},
		[29] = {
			{
				id = 28508009,
				branch_content = Lang.get(65213)
			}
		}
	},
	[28508009] = {
		28508009,
		0,
		Lang.get(65214),
		28508,
		9,
		220,
		{
			RTResTalkAction[7]
		}
	},
	[28508010] = {
		28508010,
		0,
		Lang.get(65215),
		28508,
		10,
		220,
		{
			RTResTalkAction[7]
		}
	},
	[28508011] = {
		28508011,
		0,
		Lang.get(65216),
		28508,
		11,
		220,
		{
			RTResTalkAction[7]
		}
	},
	[28508012] = {
		28508012,
		4,
		nil,
		28508,
		12,
		220,
		{
			RTResTalkAction[7]
		},
		[29] = {
			{
				id = 28508013,
				branch_content = Lang.get(65217)
			}
		}
	},
	[28508013] = {
		28508013,
		0,
		Lang.get(65218),
		28508,
		13,
		220,
		{
			RTResTalkAction[7]
		}
	},
	[28508014] = {
		28508014,
		0,
		Lang.get(65219),
		28508,
		14,
		220,
		{
			RTResTalkAction[7]
		}
	},
	[28508015] = {
		28508015,
		0,
		Lang.get(65220),
		28508,
		15,
		220,
		{
			RTResTalkAction[7]
		}
	},
	[28509001] = {
		28509001,
		0,
		Lang.get(65221),
		28509,
		1,
		215,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		28509,
		nil,
		nil,
		nil,
		nil,
		nil,
		28509
	},
	[28509002] = {
		28509002,
		0,
		Lang.get(65222),
		28509,
		2,
		300
	},
	[28509003] = {
		28509003,
		0,
		Lang.get(65223),
		28509,
		3,
		215,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[28509004] = {
		28509004,
		0,
		Lang.get(65224),
		28509,
		4,
		215,
		{
			RTResTalkAction[9]
		}
	},
	[28509005] = {
		28509005,
		0,
		Lang.get(65225),
		28509,
		5,
		215,
		{
			RTResTalkAction[9]
		}
	},
	[28509006] = {
		28509006,
		0,
		Lang.get(65226),
		28509,
		6,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[28509007] = {
		28509007,
		0,
		Lang.get(65227),
		28509,
		7,
		300
	},
	[28509008] = {
		28509008,
		0,
		Lang.get(65228),
		28509,
		8,
		215,
		{
			RTResTalkAction[9]
		}
	},
	[28509009] = {
		28509009,
		0,
		Lang.get(65229),
		28509,
		9,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[28509010] = {
		28509010,
		0,
		Lang.get(65230),
		28509,
		10,
		215,
		{
			RTResTalkAction[9]
		}
	},
	[28509011] = {
		28509011,
		0,
		Lang.get(65231),
		28509,
		11,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[28509012] = {
		28509012,
		0,
		Lang.get(65232),
		28509,
		12,
		300
	},
	[28509013] = {
		28509013,
		0,
		Lang.get(65233),
		28509,
		13,
		215,
		{
			RTResTalkAction[9]
		}
	},
	[28509014] = {
		28509014,
		0,
		Lang.get(65234),
		28509,
		14,
		215,
		{
			RTResTalkAction[9]
		}
	},
	[28509015] = {
		28509015,
		0,
		Lang.get(65235),
		28509,
		15,
		215,
		{
			RTResTalkAction[9]
		}
	},
	[28510001] = {
		28510001,
		0,
		Lang.get(65236),
		28510,
		1,
		215,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		28510,
		nil,
		nil,
		nil,
		nil,
		nil,
		28510
	},
	[28510002] = {
		28510002,
		0,
		Lang.get(65237),
		28510,
		2,
		215,
		nil,
		1
	},
	[28510003] = {
		28510003,
		0,
		Lang.get(65238),
		28510,
		3,
		215,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[28510004] = {
		28510004,
		0,
		Lang.get(65239),
		28510,
		4,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[28510005] = {
		28510005,
		0,
		Lang.get(65240),
		28510,
		5,
		300
	},
	[28510006] = {
		28510006,
		0,
		Lang.get(65241),
		28510,
		6,
		215,
		{
			RTResTalkAction[9]
		}
	},
	[28510007] = {
		28510007,
		0,
		Lang.get(65242),
		28510,
		7,
		215,
		{
			RTResTalkAction[9]
		}
	},
	[28510008] = {
		28510008,
		0,
		Lang.get(65243),
		28510,
		8,
		215,
		{
			RTResTalkAction[9]
		}
	},
	[28510009] = {
		28510009,
		0,
		Lang.get(65244),
		28510,
		9,
		215,
		{
			RTResTalkAction[9]
		}
	},
	[28510010] = {
		28510010,
		0,
		Lang.get(65245),
		28510,
		10,
		215,
		{
			RTResTalkAction[9]
		}
	},
	[28510011] = {
		28510011,
		0,
		Lang.get(65246),
		28510,
		11,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[28510012] = {
		28510012,
		0,
		Lang.get(65247),
		28510,
		12,
		300
	},
	[28510013] = {
		28510013,
		0,
		Lang.get(65248),
		28510,
		13,
		215,
		{
			RTResTalkAction[9]
		}
	},
	[28510014] = {
		28510014,
		0,
		Lang.get(65249),
		28510,
		14,
		215,
		{
			RTResTalkAction[9]
		}
	},
	[28510015] = {
		28510015,
		0,
		Lang.get(65250),
		28510,
		15,
		215,
		{
			RTResTalkAction[9]
		}
	},
	[28511001] = {
		28511001,
		0,
		Lang.get(65251),
		28511,
		1,
		215,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		28511,
		nil,
		nil,
		nil,
		nil,
		nil,
		28511
	},
	[28511002] = {
		28511002,
		0,
		Lang.get(65252),
		28511,
		2,
		300
	},
	[28511003] = {
		28511003,
		0,
		Lang.get(65253),
		28511,
		3,
		215,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[28511004] = {
		28511004,
		0,
		Lang.get(65254),
		28511,
		4,
		215,
		{
			RTResTalkAction[9]
		}
	},
	[28511005] = {
		28511005,
		0,
		Lang.get(65255),
		28511,
		5,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[28511006] = {
		28511006,
		0,
		Lang.get(65256),
		28511,
		6,
		215,
		{
			RTResTalkAction[9]
		}
	},
	[28511007] = {
		28511007,
		0,
		Lang.get(65257),
		28511,
		7,
		215,
		{
			RTResTalkAction[9]
		}
	},
	[28511008] = {
		28511008,
		0,
		Lang.get(65258),
		28511,
		8,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[28511009] = {
		28511009,
		0,
		Lang.get(65259),
		28511,
		9,
		215,
		{
			RTResTalkAction[9]
		}
	},
	[28511010] = {
		28511010,
		0,
		Lang.get(65260),
		28511,
		10,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[28511011] = {
		28511011,
		0,
		Lang.get(65261),
		28511,
		11,
		215,
		{
			RTResTalkAction[9]
		}
	},
	[28511012] = {
		28511012,
		0,
		Lang.get(65262),
		28511,
		12,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[28511013] = {
		28511013,
		0,
		Lang.get(65263),
		28511,
		13,
		300
	},
	[28511014] = {
		28511014,
		0,
		Lang.get(65264),
		28511,
		14,
		215,
		{
			RTResTalkAction[9]
		}
	},
	[28511015] = {
		28511015,
		0,
		Lang.get(65265),
		28511,
		15,
		215,
		{
			RTResTalkAction[9]
		}
	},
	[28512001] = {
		28512001,
		0,
		"……",
		28512,
		1,
		286,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		28512,
		nil,
		nil,
		nil,
		nil,
		nil,
		28512
	},
	[28512002] = {
		28512002,
		0,
		Lang.get(65266),
		28512,
		2,
		286,
		nil,
		1
	},
	[28512003] = {
		28512003,
		4,
		nil,
		28512,
		3,
		286,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3,
		[29] = {
			{
				id = 28512004,
				branch_content = Lang.get(65267)
			},
			{
				id = 28512004,
				branch_content = Lang.get(65268)
			}
		}
	},
	[28512004] = {
		28512004,
		0,
		Lang.get(21533),
		28512,
		4,
		286,
		{
			RTResTalkAction[11]
		}
	},
	[28512005] = {
		28512005,
		4,
		nil,
		28512,
		5,
		286,
		{
			RTResTalkAction[11]
		},
		[29] = {
			{
				id = 28512006,
				branch_content = Lang.get(65269)
			},
			{
				id = 28512006,
				branch_content = Lang.get(65270)
			}
		}
	},
	[28512006] = {
		28512006,
		0,
		Lang.get(65271),
		28512,
		6,
		286,
		{
			RTResTalkAction[11]
		}
	},
	[28512007] = {
		28512007,
		4,
		nil,
		28512,
		7,
		286,
		{
			RTResTalkAction[11]
		},
		[29] = {
			{
				id = 28512008,
				branch_content = Lang.get(65272)
			}
		}
	},
	[28512008] = {
		28512008,
		0,
		Lang.get(65273),
		28512,
		8,
		286,
		{
			RTResTalkAction[11]
		}
	},
	[28512009] = {
		28512009,
		4,
		nil,
		28512,
		9,
		286,
		{
			RTResTalkAction[11]
		},
		[29] = {
			{
				id = 28512010,
				branch_content = Lang.get(65274)
			},
			{
				id = 28512010,
				branch_content = Lang.get(65275)
			}
		}
	},
	[28512010] = {
		28512010,
		0,
		Lang.get(65276),
		28512,
		10,
		286,
		{
			RTResTalkAction[11]
		}
	},
	[28512011] = {
		28512011,
		0,
		Lang.get(65277),
		28512,
		11,
		300,
		{
			RTResTalkAction[12]
		}
	},
	[28512012] = {
		28512012,
		0,
		Lang.get(65278),
		28512,
		12,
		286,
		{
			RTResTalkAction[11]
		}
	},
	[28513001] = {
		28513001,
		0,
		Lang.get(65279),
		28513,
		1,
		286,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		28513,
		nil,
		nil,
		nil,
		nil,
		nil,
		28513
	},
	[28513002] = {
		28513002,
		4,
		nil,
		28513,
		2,
		286,
		[29] = {
			{
				id = 28513003,
				branch_content = Lang.get(65280)
			},
			{
				id = 28513003,
				branch_content = Lang.get(65281)
			}
		}
	},
	[28513003] = {
		28513003,
		0,
		Lang.get(65282),
		28513,
		3,
		286,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3
	},
	[28513004] = {
		28513004,
		4,
		nil,
		28513,
		4,
		286,
		{
			RTResTalkAction[11]
		},
		[29] = {
			{
				id = 28513005,
				branch_content = Lang.get(65283)
			},
			{
				id = 28513005,
				branch_content = Lang.get(65284)
			}
		}
	},
	[28513005] = {
		28513005,
		0,
		Lang.get(65285),
		28513,
		5,
		286,
		{
			RTResTalkAction[11]
		}
	},
	[28513006] = {
		28513006,
		0,
		Lang.get(65286),
		28513,
		6,
		300,
		{
			RTResTalkAction[12]
		}
	},
	[28513007] = {
		28513007,
		0,
		Lang.get(65287),
		28513,
		7,
		300
	},
	[28513008] = {
		28513008,
		0,
		Lang.get(65288),
		28513,
		8,
		286,
		{
			RTResTalkAction[11]
		}
	},
	[28513009] = {
		28513009,
		4,
		nil,
		28513,
		9,
		286,
		{
			RTResTalkAction[11]
		},
		[29] = {
			{
				id = 28513010,
				branch_content = Lang.get(65289)
			},
			{
				id = 28513010,
				branch_content = Lang.get(65290)
			}
		}
	},
	[28513010] = {
		28513010,
		0,
		Lang.get(65291),
		28513,
		10,
		286,
		{
			RTResTalkAction[11]
		}
	},
	[28513011] = {
		28513011,
		0,
		Lang.get(65292),
		28513,
		11,
		300,
		{
			RTResTalkAction[12]
		}
	},
	[28513012] = {
		28513012,
		0,
		Lang.get(65293),
		28513,
		12,
		286,
		{
			RTResTalkAction[11]
		}
	},
	[28514001] = {
		28514001,
		0,
		Lang.get(65294),
		28514,
		1,
		286,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		28514,
		nil,
		nil,
		nil,
		nil,
		nil,
		28514
	},
	[28514002] = {
		28514002,
		4,
		nil,
		28514,
		2,
		286,
		nil,
		1,
		[29] = {
			{
				id = 28514003,
				branch_content = Lang.get(65295)
			},
			{
				id = 28514003,
				branch_content = Lang.get(65296)
			}
		}
	},
	[28514003] = {
		28514003,
		0,
		Lang.get(65297),
		28514,
		3,
		286,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3
	},
	[28514004] = {
		28514004,
		0,
		Lang.get(65298),
		28514,
		4,
		286,
		{
			RTResTalkAction[11]
		}
	},
	[28514005] = {
		28514005,
		0,
		Lang.get(65299),
		28514,
		5,
		300,
		{
			RTResTalkAction[12]
		}
	},
	[28514006] = {
		28514006,
		0,
		Lang.get(18191),
		28514,
		6,
		286,
		{
			RTResTalkAction[11]
		}
	},
	[28514007] = {
		28514007,
		0,
		Lang.get(65300),
		28514,
		7,
		300,
		{
			RTResTalkAction[12]
		}
	},
	[28514008] = {
		28514008,
		0,
		Lang.get(65301),
		28514,
		8,
		300
	},
	[28514009] = {
		28514009,
		0,
		Lang.get(65302),
		28514,
		9,
		286,
		{
			RTResTalkAction[11]
		}
	},
	[28514010] = {
		28514010,
		4,
		nil,
		28514,
		10,
		286,
		{
			RTResTalkAction[11]
		},
		[29] = {
			{
				id = 28514011,
				branch_content = Lang.get(65303)
			}
		}
	},
	[28514011] = {
		28514011,
		0,
		Lang.get(65304),
		28514,
		11,
		286,
		{
			RTResTalkAction[11]
		}
	},
	[28514012] = {
		28514012,
		0,
		Lang.get(65305),
		28514,
		12,
		300,
		{
			RTResTalkAction[12]
		}
	},
	[28514013] = {
		28514013,
		0,
		Lang.get(65306),
		28514,
		13,
		286,
		{
			RTResTalkAction[11]
		}
	},
	[28514014] = {
		28514014,
		0,
		Lang.get(65307),
		28514,
		14,
		300,
		{
			RTResTalkAction[12]
		}
	},
	[28514015] = {
		28514015,
		0,
		Lang.get(65308),
		28514,
		15,
		286,
		{
			RTResTalkAction[11]
		}
	},
	[28514016] = {
		28514016,
		4,
		nil,
		28514,
		16,
		286,
		{
			RTResTalkAction[11]
		},
		[29] = {
			{
				id = 28514017,
				branch_content = Lang.get(19557)
			}
		}
	},
	[28514017] = {
		28514017,
		0,
		Lang.get(65309),
		28514,
		17,
		286,
		{
			RTResTalkAction[11]
		}
	},
	[28514018] = {
		28514018,
		0,
		Lang.get(65310),
		28514,
		18,
		286,
		{
			RTResTalkAction[11]
		}
	},
	[28515001] = {
		28515001,
		0,
		Lang.get(67765),
		28515,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		28515,
		nil,
		1,
		[19] = 28515,
		[17] = 1
	},
	[28515002] = {
		28515002,
		0,
		Lang.get(67766),
		28515,
		2,
		300
	},
	[28515003] = {
		28515003,
		0,
		Lang.get(67228),
		28515,
		3,
		719,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		3,
		nil,
		62
	},
	[28515004] = {
		28515004,
		0,
		Lang.get(67767),
		28515,
		4,
		300,
		{
			RTResTalkAction[14]
		}
	},
	[28515005] = {
		28515005,
		0,
		Lang.get(67768),
		28515,
		5,
		300
	},
	[28515006] = {
		28515006,
		0,
		Lang.get(67769),
		28515,
		6,
		300
	},
	[28515007] = {
		28515007,
		0,
		Lang.get(66176),
		28515,
		7,
		719,
		{
			RTResTalkAction[13]
		}
	},
	[28515008] = {
		28515008,
		0,
		Lang.get(67770),
		28515,
		8,
		300,
		{
			RTResTalkAction[14]
		}
	},
	[28515009] = {
		28515009,
		0,
		Lang.get(66146),
		28515,
		9,
		719,
		{
			RTResTalkAction[13]
		}
	},
	[28515010] = {
		28515010,
		0,
		Lang.get(67771),
		28515,
		10,
		300,
		{
			RTResTalkAction[14]
		}
	},
	[28515011] = {
		28515011,
		0,
		Lang.get(67772),
		28515,
		11,
		719,
		{
			RTResTalkAction[13]
		}
	},
	[28515012] = {
		28515012,
		0,
		Lang.get(67773),
		28515,
		12,
		300,
		{
			RTResTalkAction[14]
		}
	},
	[28515013] = {
		28515013,
		0,
		Lang.get(67774),
		28515,
		13,
		300
	},
	[28515014] = {
		28515014,
		0,
		Lang.get(67775),
		28515,
		14,
		300
	},
	[28515015] = {
		28515015,
		0,
		Lang.get(66176),
		28515,
		15,
		719,
		{
			RTResTalkAction[13]
		}
	},
	[28516001] = {
		28516001,
		0,
		Lang.get(70258),
		28516,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		28516,
		nil,
		1,
		nil,
		1,
		nil,
		28516
	},
	[28516002] = {
		28516002,
		0,
		Lang.get(67241),
		28516,
		2,
		719,
		{
			RTResTalkAction[13]
		}
	},
	[28516003] = {
		28516003,
		0,
		Lang.get(70259),
		28516,
		3,
		300,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[28516004] = {
		28516004,
		0,
		Lang.get(70260),
		28516,
		4,
		300
	},
	[28516005] = {
		28516005,
		0,
		Lang.get(70261),
		28516,
		5,
		300
	},
	[28516006] = {
		28516006,
		0,
		Lang.get(70262),
		28516,
		6,
		300
	},
	[28516007] = {
		28516007,
		0,
		Lang.get(66146),
		28516,
		7,
		719,
		{
			RTResTalkAction[13]
		}
	},
	[28516008] = {
		28516008,
		0,
		Lang.get(70263),
		28516,
		8,
		300,
		{
			RTResTalkAction[14]
		}
	},
	[28516009] = {
		28516009,
		0,
		Lang.get(67772),
		28516,
		9,
		719,
		{
			RTResTalkAction[13]
		}
	},
	[28516010] = {
		28516010,
		0,
		Lang.get(70264),
		28516,
		10,
		300,
		{
			RTResTalkAction[14]
		}
	},
	[28516011] = {
		28516011,
		0,
		Lang.get(70265),
		28516,
		11,
		300
	},
	[28516012] = {
		28516012,
		0,
		Lang.get(70266),
		28516,
		12,
		300
	},
	[28517001] = {
		28517001,
		0,
		Lang.get(67228),
		28517,
		1,
		719,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28517,
		nil,
		1,
		nil,
		1,
		nil,
		28517
	},
	[28517002] = {
		28517002,
		0,
		Lang.get(67786),
		28517,
		2,
		300
	},
	[28517003] = {
		28517003,
		0,
		Lang.get(67787),
		28517,
		3,
		300
	},
	[28517004] = {
		28517004,
		0,
		Lang.get(67788),
		28517,
		4,
		300
	},
	[28517005] = {
		28517005,
		0,
		Lang.get(67789),
		28517,
		5,
		300
	},
	[28517006] = {
		28517006,
		0,
		Lang.get(67790),
		28517,
		6,
		300
	},
	[28517007] = {
		28517007,
		0,
		Lang.get(67791),
		28517,
		7,
		300
	},
	[28517008] = {
		28517008,
		0,
		Lang.get(67792),
		28517,
		8,
		300
	},
	[28517009] = {
		28517009,
		0,
		Lang.get(67793),
		28517,
		9,
		300
	},
	[28517010] = {
		28517010,
		0,
		Lang.get(66176),
		28517,
		10,
		719,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		3
	},
	[28518001] = {
		28518001,
		9,
		Lang.get(67794),
		28518,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		28518,
		nil,
		1,
		nil,
		1,
		nil,
		28518,
		nil,
		nil,
		1
	},
	[28518002] = {
		28518002,
		0,
		Lang.get(22522),
		28518,
		2,
		750,
		{
			RTResTalkAction[15]
		},
		nil,
		nil,
		3
	},
	[28518003] = {
		28518003,
		0,
		Lang.get(67795),
		28518,
		3,
		300,
		{
			RTResTalkAction[16]
		}
	},
	[28518004] = {
		28518004,
		0,
		Lang.get(67796),
		28518,
		4,
		750,
		{
			RTResTalkAction[15]
		}
	},
	[28518005] = {
		28518005,
		0,
		Lang.get(67797),
		28518,
		5,
		300,
		{
			RTResTalkAction[16]
		}
	},
	[28518006] = {
		28518006,
		0,
		Lang.get(67798),
		28518,
		6,
		750,
		{
			RTResTalkAction[15]
		}
	},
	[28518007] = {
		28518007,
		0,
		Lang.get(67799),
		28518,
		7,
		300,
		{
			RTResTalkAction[16]
		}
	},
	[28518008] = {
		28518008,
		0,
		Lang.get(67800),
		28518,
		8,
		750,
		{
			RTResTalkAction[15]
		}
	},
	[28518009] = {
		28518009,
		0,
		Lang.get(67801),
		28518,
		9,
		300,
		{
			RTResTalkAction[16]
		}
	},
	[28518010] = {
		28518010,
		0,
		Lang.get(67802),
		28518,
		10,
		750,
		{
			RTResTalkAction[15]
		}
	},
	[28518011] = {
		28518011,
		0,
		Lang.get(67803),
		28518,
		11,
		300,
		{
			RTResTalkAction[16]
		}
	},
	[28518012] = {
		28518012,
		0,
		Lang.get(67804),
		28518,
		12,
		750,
		{
			RTResTalkAction[15]
		}
	},
	[28518013] = {
		28518013,
		0,
		Lang.get(67805),
		28518,
		13,
		300,
		{
			RTResTalkAction[16]
		}
	},
	[28518014] = {
		28518014,
		0,
		Lang.get(67806),
		28518,
		14,
		750,
		{
			RTResTalkAction[15]
		}
	},
	[28519001] = {
		28519001,
		0,
		Lang.get(70267),
		28519,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		28519,
		nil,
		1,
		[19] = 28519,
		[17] = 1
	},
	[28519002] = {
		28519002,
		0,
		Lang.get(67808),
		28519,
		2,
		750,
		{
			RTResTalkAction[15]
		},
		nil,
		nil,
		3
	},
	[28519003] = {
		28519003,
		0,
		Lang.get(67809),
		28519,
		3,
		300,
		{
			RTResTalkAction[16]
		}
	},
	[28519004] = {
		28519004,
		0,
		Lang.get(67810),
		28519,
		4,
		750,
		{
			RTResTalkAction[15]
		}
	},
	[28519005] = {
		28519005,
		0,
		Lang.get(67811),
		28519,
		5,
		750,
		{
			RTResTalkAction[15]
		}
	},
	[28519006] = {
		28519006,
		0,
		Lang.get(67812),
		28519,
		6,
		300,
		{
			RTResTalkAction[16]
		}
	},
	[28519007] = {
		28519007,
		0,
		Lang.get(67813),
		28519,
		7,
		300
	},
	[28519008] = {
		28519008,
		0,
		Lang.get(67814),
		28519,
		8,
		750,
		{
			RTResTalkAction[15]
		}
	},
	[28519009] = {
		28519009,
		0,
		Lang.get(67815),
		28519,
		9,
		300,
		{
			RTResTalkAction[16]
		}
	},
	[28519010] = {
		28519010,
		0,
		Lang.get(67816),
		28519,
		10,
		750,
		{
			RTResTalkAction[15]
		}
	},
	[28519011] = {
		28519011,
		0,
		Lang.get(67817),
		28519,
		11,
		750,
		{
			RTResTalkAction[15]
		}
	},
	[28520001] = {
		28520001,
		0,
		Lang.get(67818),
		28520,
		1,
		750,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		28520,
		nil,
		1,
		nil,
		1,
		nil,
		28520
	},
	[28520002] = {
		28520002,
		0,
		Lang.get(67819),
		28520,
		2,
		300
	},
	[28520003] = {
		28520003,
		0,
		Lang.get(67820),
		28520,
		3,
		750,
		{
			RTResTalkAction[15]
		},
		nil,
		nil,
		3
	},
	[28520004] = {
		28520004,
		0,
		Lang.get(67821),
		28520,
		4,
		300,
		{
			RTResTalkAction[16]
		}
	},
	[28520005] = {
		28520005,
		0,
		Lang.get(67822),
		28520,
		5,
		750,
		{
			RTResTalkAction[15]
		}
	},
	[28520006] = {
		28520006,
		0,
		Lang.get(67823),
		28520,
		6,
		750,
		{
			RTResTalkAction[15]
		}
	},
	[28520007] = {
		28520007,
		0,
		Lang.get(67824),
		28520,
		7,
		750,
		{
			RTResTalkAction[15]
		}
	},
	[28520008] = {
		28520008,
		0,
		Lang.get(67825),
		28520,
		8,
		750,
		{
			RTResTalkAction[15]
		}
	},
	[28520009] = {
		28520009,
		0,
		Lang.get(67826),
		28520,
		9,
		300,
		{
			RTResTalkAction[16]
		}
	},
	[28520010] = {
		28520010,
		0,
		Lang.get(67827),
		28520,
		10,
		750,
		{
			RTResTalkAction[15]
		}
	},
	[28521001] = {
		28521001,
		0,
		Lang.get(67828),
		28521,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		28521,
		nil,
		1,
		[19] = 28521,
		[17] = 1
	},
	[28521002] = {
		28521002,
		0,
		Lang.get(67829),
		28521,
		2,
		752,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[28521003] = {
		28521003,
		0,
		Lang.get(67830),
		28521,
		3,
		752,
		{
			RTResTalkAction[17]
		}
	},
	[28521004] = {
		28521004,
		0,
		Lang.get(67831),
		28521,
		4,
		605,
		{
			RTResTalkAction[18]
		}
	},
	[28521005] = {
		28521005,
		0,
		Lang.get(67832),
		28521,
		5,
		300
	},
	[28521006] = {
		28521006,
		0,
		Lang.get(67833),
		28521,
		6,
		752,
		{
			RTResTalkAction[17]
		}
	},
	[28521007] = {
		28521007,
		0,
		Lang.get(67834),
		28521,
		7,
		300,
		{
			RTResTalkAction[18]
		}
	},
	[28521008] = {
		28521008,
		0,
		Lang.get(67835),
		28521,
		8,
		300
	},
	[28521009] = {
		28521009,
		0,
		Lang.get(67836),
		28521,
		9,
		752,
		{
			RTResTalkAction[17]
		}
	},
	[28521010] = {
		28521010,
		0,
		Lang.get(67837),
		28521,
		10,
		300,
		{
			RTResTalkAction[18]
		}
	},
	[28521011] = {
		28521011,
		0,
		Lang.get(67838),
		28521,
		11,
		752,
		{
			RTResTalkAction[17]
		}
	},
	[28521012] = {
		28521012,
		0,
		Lang.get(67839),
		28521,
		12,
		752,
		{
			RTResTalkAction[17]
		}
	},
	[28522001] = {
		28522001,
		0,
		Lang.get(67840),
		28522,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		28522,
		nil,
		1,
		[19] = 28522,
		[17] = 1
	},
	[28522002] = {
		28522002,
		0,
		Lang.get(67841),
		28522,
		2,
		300
	},
	[28522003] = {
		28522003,
		0,
		Lang.get(67842),
		28522,
		3,
		752,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[28522004] = {
		28522004,
		0,
		Lang.get(67843),
		28522,
		4,
		752,
		{
			RTResTalkAction[17]
		}
	},
	[28522005] = {
		28522005,
		0,
		Lang.get(67844),
		28522,
		5,
		752,
		{
			RTResTalkAction[17]
		}
	},
	[28522006] = {
		28522006,
		0,
		Lang.get(67845),
		28522,
		6,
		300,
		{
			RTResTalkAction[18]
		}
	},
	[28522007] = {
		28522007,
		0,
		Lang.get(67846),
		28522,
		7,
		752,
		{
			RTResTalkAction[17]
		}
	},
	[28522008] = {
		28522008,
		0,
		Lang.get(67847),
		28522,
		8,
		300,
		{
			RTResTalkAction[18]
		}
	},
	[28522009] = {
		28522009,
		0,
		Lang.get(67848),
		28522,
		9,
		752,
		{
			RTResTalkAction[17]
		}
	},
	[28522010] = {
		28522010,
		0,
		Lang.get(67849),
		28522,
		10,
		752,
		{
			RTResTalkAction[17]
		}
	},
	[28523001] = {
		28523001,
		0,
		Lang.get(67850),
		28523,
		1,
		752,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		28523,
		nil,
		1,
		nil,
		1,
		nil,
		28523
	},
	[28523002] = {
		28523002,
		0,
		Lang.get(67851),
		28523,
		2,
		300
	},
	[28523003] = {
		28523003,
		0,
		Lang.get(67852),
		28523,
		3,
		752,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[28523004] = {
		28523004,
		0,
		Lang.get(67853),
		28523,
		4,
		752,
		{
			RTResTalkAction[17]
		}
	},
	[28523005] = {
		28523005,
		0,
		Lang.get(67854),
		28523,
		5,
		300,
		{
			RTResTalkAction[18]
		}
	},
	[28523006] = {
		28523006,
		0,
		Lang.get(67855),
		28523,
		6,
		752,
		{
			RTResTalkAction[17]
		}
	},
	[28523007] = {
		28523007,
		0,
		Lang.get(67856),
		28523,
		7,
		300,
		{
			RTResTalkAction[18]
		}
	},
	[28523008] = {
		28523008,
		0,
		Lang.get(67857),
		28523,
		8,
		752,
		{
			RTResTalkAction[17]
		}
	},
	[28523009] = {
		28523009,
		0,
		Lang.get(67858),
		28523,
		9,
		752,
		{
			RTResTalkAction[17]
		}
	},
	[28524001] = {
		28524001,
		0,
		Lang.get(67859),
		28524,
		1,
		196,
		nil,
		1,
		nil,
		nil,
		nil,
		122,
		28524,
		nil,
		1,
		nil,
		1,
		nil,
		28524
	},
	[28524002] = {
		28524002,
		0,
		Lang.get(67860),
		28524,
		2,
		300
	},
	[28524003] = {
		28524003,
		0,
		Lang.get(67861),
		28524,
		3,
		196,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		3
	},
	[28524004] = {
		28524004,
		0,
		Lang.get(67862),
		28524,
		4,
		300,
		{
			RTResTalkAction[20]
		}
	},
	[28524005] = {
		28524005,
		0,
		Lang.get(67863),
		28524,
		5,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28524006] = {
		28524006,
		0,
		Lang.get(67864),
		28524,
		6,
		300,
		{
			RTResTalkAction[20]
		}
	},
	[28524007] = {
		28524007,
		0,
		Lang.get(67865),
		28524,
		7,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28524008] = {
		28524008,
		0,
		Lang.get(67866),
		28524,
		8,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28524009] = {
		28524009,
		0,
		Lang.get(67867),
		28524,
		9,
		300,
		{
			RTResTalkAction[20]
		}
	},
	[28524010] = {
		28524010,
		0,
		Lang.get(67868),
		28524,
		10,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28524011] = {
		28524011,
		0,
		Lang.get(67869),
		28524,
		11,
		300,
		{
			RTResTalkAction[20]
		}
	},
	[28524012] = {
		28524012,
		0,
		Lang.get(67870),
		28524,
		12,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28524013] = {
		28524013,
		0,
		Lang.get(67871),
		28524,
		13,
		300,
		{
			RTResTalkAction[20]
		}
	},
	[28524014] = {
		28524014,
		0,
		Lang.get(67872),
		28524,
		14,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28524015] = {
		28524015,
		0,
		Lang.get(67873),
		28524,
		15,
		300,
		{
			RTResTalkAction[20]
		}
	},
	[28524016] = {
		28524016,
		0,
		Lang.get(67874),
		28524,
		16,
		300
	},
	[28524017] = {
		28524017,
		0,
		Lang.get(67875),
		28524,
		17,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28524018] = {
		28524018,
		0,
		Lang.get(67876),
		28524,
		18,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28524019] = {
		28524019,
		0,
		Lang.get(67877),
		28524,
		19,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28524020] = {
		28524020,
		0,
		Lang.get(67878),
		28524,
		20,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28524021] = {
		28524021,
		0,
		Lang.get(71075),
		28524,
		21,
		300,
		{
			RTResTalkAction[20]
		}
	},
	[28524022] = {
		28524022,
		0,
		Lang.get(67880),
		28524,
		22,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28524023] = {
		28524023,
		0,
		Lang.get(67881),
		28524,
		23,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28525001] = {
		28525001,
		0,
		Lang.get(67882),
		28525,
		1,
		196,
		nil,
		1,
		nil,
		nil,
		nil,
		122,
		28525,
		nil,
		1,
		nil,
		1,
		nil,
		28525
	},
	[28525002] = {
		28525002,
		0,
		Lang.get(67883),
		28525,
		2,
		196,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		3
	},
	[28525003] = {
		28525003,
		0,
		Lang.get(67884),
		28525,
		3,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28525004] = {
		28525004,
		0,
		Lang.get(67885),
		28525,
		4,
		300,
		{
			RTResTalkAction[20]
		}
	},
	[28525005] = {
		28525005,
		0,
		Lang.get(67886),
		28525,
		5,
		300
	},
	[28525006] = {
		28525006,
		0,
		Lang.get(67887),
		28525,
		6,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28525007] = {
		28525007,
		0,
		Lang.get(67888),
		28525,
		7,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28525008] = {
		28525008,
		0,
		Lang.get(67889),
		28525,
		8,
		300,
		{
			RTResTalkAction[20]
		}
	},
	[28525009] = {
		28525009,
		0,
		Lang.get(67890),
		28525,
		9,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28525010] = {
		28525010,
		0,
		Lang.get(67891),
		28525,
		10,
		300,
		{
			RTResTalkAction[20]
		}
	},
	[28525011] = {
		28525011,
		0,
		Lang.get(67892),
		28525,
		11,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28525012] = {
		28525012,
		0,
		Lang.get(67893),
		28525,
		12,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28525013] = {
		28525013,
		0,
		Lang.get(67894),
		28525,
		13,
		300,
		{
			RTResTalkAction[20]
		}
	},
	[28525014] = {
		28525014,
		0,
		Lang.get(67895),
		28525,
		14,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28525015] = {
		28525015,
		0,
		Lang.get(70268),
		28525,
		15,
		300,
		{
			RTResTalkAction[20]
		}
	},
	[28525016] = {
		28525016,
		0,
		Lang.get(67897),
		28525,
		16,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28525017] = {
		28525017,
		0,
		Lang.get(67898),
		28525,
		17,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28525018] = {
		28525018,
		0,
		Lang.get(67899),
		28525,
		18,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28525019] = {
		28525019,
		0,
		Lang.get(67900),
		28525,
		19,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28526001] = {
		28526001,
		9,
		Lang.get(67901),
		28526,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		122,
		28526,
		nil,
		1,
		nil,
		1,
		nil,
		28526,
		nil,
		nil,
		1
	},
	[28526002] = {
		28526002,
		0,
		Lang.get(67902),
		28526,
		2,
		196,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		3
	},
	[28526003] = {
		28526003,
		0,
		Lang.get(67903),
		28526,
		3,
		300,
		{
			RTResTalkAction[20]
		}
	},
	[28526004] = {
		28526004,
		0,
		Lang.get(67904),
		28526,
		4,
		300
	},
	[28526005] = {
		28526005,
		0,
		Lang.get(67905),
		28526,
		5,
		300
	},
	[28526006] = {
		28526006,
		0,
		Lang.get(67906),
		28526,
		6,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28526007] = {
		28526007,
		0,
		Lang.get(67907),
		28526,
		7,
		300,
		{
			RTResTalkAction[20]
		}
	},
	[28526008] = {
		28526008,
		0,
		Lang.get(67908),
		28526,
		8,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28526009] = {
		28526009,
		0,
		Lang.get(67909),
		28526,
		9,
		300,
		{
			RTResTalkAction[20]
		}
	},
	[28526010] = {
		28526010,
		0,
		Lang.get(67910),
		28526,
		10,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28526011] = {
		28526011,
		0,
		Lang.get(67911),
		28526,
		11,
		300,
		{
			RTResTalkAction[20]
		}
	},
	[28526012] = {
		28526012,
		0,
		Lang.get(67912),
		28526,
		12,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28526013] = {
		28526013,
		0,
		Lang.get(67913),
		28526,
		13,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28526014] = {
		28526014,
		0,
		Lang.get(67914),
		28526,
		14,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28526015] = {
		28526015,
		0,
		Lang.get(67915),
		28526,
		15,
		300,
		{
			RTResTalkAction[20]
		}
	},
	[28526016] = {
		28526016,
		0,
		Lang.get(67916),
		28526,
		16,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28526017] = {
		28526017,
		0,
		Lang.get(67917),
		28526,
		17,
		300,
		{
			RTResTalkAction[20]
		}
	},
	[28526018] = {
		28526018,
		0,
		Lang.get(67918),
		28526,
		18,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28526019] = {
		28526019,
		0,
		Lang.get(67919),
		28526,
		19,
		300,
		{
			RTResTalkAction[20]
		}
	},
	[28526020] = {
		28526020,
		0,
		Lang.get(67920),
		28526,
		20,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28526021] = {
		28526021,
		0,
		Lang.get(67921),
		28526,
		21,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28526022] = {
		28526022,
		0,
		Lang.get(67922),
		28526,
		22,
		196,
		{
			RTResTalkAction[19]
		}
	},
	[28527001] = {
		28527001,
		9,
		Lang.get(67923),
		28527,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		5,
		28527,
		nil,
		1,
		nil,
		1,
		nil,
		28527,
		nil,
		nil,
		1
	},
	[28527002] = {
		28527002,
		4,
		nil,
		28527,
		2,
		605,
		[29] = {
			{
				id = 28527003,
				branch_content = Lang.get(67924)
			},
			{
				id = 28527003,
				branch_content = Lang.get(67467)
			}
		}
	},
	[28527003] = {
		28527003,
		0,
		Lang.get(67925),
		28527,
		3,
		147,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3
	},
	[28527004] = {
		28527004,
		0,
		Lang.get(67926),
		28527,
		4,
		300,
		{
			RTResTalkAction[22]
		}
	},
	[28527005] = {
		28527005,
		0,
		Lang.get(67927),
		28527,
		5,
		147,
		{
			RTResTalkAction[21]
		}
	},
	[28527006] = {
		28527006,
		0,
		Lang.get(67928),
		28527,
		6,
		300,
		{
			RTResTalkAction[22]
		}
	},
	[28527007] = {
		28527007,
		0,
		Lang.get(71076),
		28527,
		7,
		300
	},
	[28527008] = {
		28527008,
		0,
		Lang.get(67930),
		28527,
		8,
		147,
		{
			RTResTalkAction[21]
		}
	},
	[28527009] = {
		28527009,
		0,
		Lang.get(67931),
		28527,
		9,
		300,
		{
			RTResTalkAction[22]
		}
	},
	[28527010] = {
		28527010,
		0,
		Lang.get(67932),
		28527,
		10,
		147,
		{
			RTResTalkAction[21]
		}
	},
	[28527011] = {
		28527011,
		4,
		nil,
		28527,
		11,
		147,
		{
			RTResTalkAction[21]
		},
		[29] = {
			{
				id = 28527012,
				branch_content = Lang.get(67933)
			}
		}
	},
	[28527012] = {
		28527012,
		0,
		Lang.get(67934),
		28527,
		12,
		147,
		{
			RTResTalkAction[21]
		}
	},
	[28527013] = {
		28527013,
		0,
		Lang.get(67935),
		28527,
		13,
		300,
		{
			RTResTalkAction[22]
		}
	},
	[28527014] = {
		28527014,
		0,
		Lang.get(67936),
		28527,
		14,
		300
	},
	[28527015] = {
		28527015,
		0,
		Lang.get(67937),
		28527,
		15,
		147,
		{
			RTResTalkAction[21]
		}
	},
	[28528001] = {
		28528001,
		0,
		Lang.get(71077),
		28528,
		1,
		147,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28528,
		nil,
		1,
		nil,
		1,
		nil,
		28528
	},
	[28528002] = {
		28528002,
		0,
		Lang.get(67939),
		28528,
		2,
		147,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3
	},
	[28528003] = {
		28528003,
		0,
		Lang.get(67940),
		28528,
		3,
		147,
		{
			RTResTalkAction[21]
		}
	},
	[28528004] = {
		28528004,
		0,
		Lang.get(67941),
		28528,
		4,
		147,
		{
			RTResTalkAction[21]
		}
	},
	[28528005] = {
		28528005,
		0,
		Lang.get(67942),
		28528,
		5,
		147,
		{
			RTResTalkAction[21]
		}
	},
	[28528006] = {
		28528006,
		4,
		nil,
		28528,
		6,
		147,
		{
			RTResTalkAction[21]
		},
		[29] = {
			{
				id = 28528007,
				branch_content = Lang.get(54830)
			}
		}
	},
	[28528007] = {
		28528007,
		0,
		Lang.get(67943),
		28528,
		7,
		147,
		{
			RTResTalkAction[21]
		}
	},
	[28528008] = {
		28528008,
		0,
		Lang.get(67944),
		28528,
		8,
		300,
		{
			RTResTalkAction[22]
		}
	},
	[28528009] = {
		28528009,
		0,
		Lang.get(67945),
		28528,
		9,
		300
	},
	[28528010] = {
		28528010,
		0,
		Lang.get(67946),
		28528,
		10,
		147,
		{
			RTResTalkAction[21]
		}
	},
	[28528011] = {
		28528011,
		0,
		Lang.get(67947),
		28528,
		11,
		147,
		{
			RTResTalkAction[21]
		}
	},
	[28528012] = {
		28528012,
		4,
		nil,
		28528,
		12,
		147,
		{
			RTResTalkAction[21]
		},
		[29] = {
			{
				id = 28528013,
				branch_content = Lang.get(67948)
			},
			{
				id = 28528013,
				branch_content = Lang.get(67949)
			}
		}
	},
	[28528013] = {
		28528013,
		0,
		Lang.get(67950),
		28528,
		13,
		147,
		{
			RTResTalkAction[21]
		}
	},
	[28528014] = {
		28528014,
		0,
		Lang.get(67951),
		28528,
		14,
		147,
		{
			RTResTalkAction[21]
		}
	},
	[28528015] = {
		28528015,
		0,
		Lang.get(67952),
		28528,
		15,
		300,
		{
			RTResTalkAction[22]
		}
	},
	[28528016] = {
		28528016,
		0,
		Lang.get(67953),
		28528,
		16,
		300
	},
	[28528017] = {
		28528017,
		0,
		Lang.get(67954),
		28528,
		17,
		147,
		{
			RTResTalkAction[21]
		}
	},
	[28529001] = {
		28529001,
		0,
		Lang.get(67955),
		28529,
		1,
		147,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28529,
		nil,
		1,
		nil,
		1,
		nil,
		28529
	},
	[28529002] = {
		28529002,
		0,
		Lang.get(67956),
		28529,
		2,
		300
	},
	[28529003] = {
		28529003,
		0,
		Lang.get(67957),
		28529,
		3,
		147,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3
	},
	[28529004] = {
		28529004,
		4,
		nil,
		28529,
		4,
		147,
		{
			RTResTalkAction[21]
		},
		[29] = {
			{
				id = 28529005,
				branch_content = Lang.get(67958)
			}
		}
	},
	[28529005] = {
		28529005,
		0,
		Lang.get(67959),
		28529,
		5,
		147,
		{
			RTResTalkAction[21]
		}
	},
	[28529006] = {
		28529006,
		0,
		Lang.get(67960),
		28529,
		6,
		147,
		{
			RTResTalkAction[21]
		}
	},
	[28529007] = {
		28529007,
		0,
		Lang.get(67961),
		28529,
		7,
		300,
		{
			RTResTalkAction[22]
		}
	},
	[28529008] = {
		28529008,
		0,
		Lang.get(67962),
		28529,
		8,
		147,
		{
			RTResTalkAction[21]
		}
	},
	[28529009] = {
		28529009,
		0,
		Lang.get(67963),
		28529,
		9,
		300,
		{
			RTResTalkAction[22]
		}
	},
	[28529010] = {
		28529010,
		0,
		Lang.get(67964),
		28529,
		10,
		300
	},
	[28529011] = {
		28529011,
		0,
		Lang.get(67965),
		28529,
		11,
		147,
		{
			RTResTalkAction[21]
		}
	},
	[28529012] = {
		28529012,
		4,
		nil,
		28529,
		12,
		147,
		{
			RTResTalkAction[21]
		},
		[29] = {
			{
				id = 28529013,
				branch_content = Lang.get(67966)
			}
		}
	},
	[28529013] = {
		28529013,
		0,
		Lang.get(67967),
		28529,
		13,
		147,
		{
			RTResTalkAction[21]
		}
	},
	[28529014] = {
		28529014,
		0,
		Lang.get(67968),
		28529,
		14,
		147,
		{
			RTResTalkAction[21]
		}
	},
	[28529015] = {
		28529015,
		0,
		Lang.get(67969),
		28529,
		15,
		300,
		{
			RTResTalkAction[22]
		}
	},
	[28529016] = {
		28529016,
		0,
		Lang.get(67970),
		28529,
		16,
		147,
		{
			RTResTalkAction[21]
		}
	},
	[28530001] = {
		28530001,
		0,
		Lang.get(16653),
		28530,
		1,
		287,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28530,
		nil,
		1,
		nil,
		1,
		nil,
		28530
	},
	[28530002] = {
		28530002,
		4,
		nil,
		28530,
		2,
		287,
		[29] = {
			{
				id = 28530003,
				branch_content = Lang.get(67971)
			},
			{
				id = 28530003,
				branch_content = Lang.get(67972)
			}
		}
	},
	[28530003] = {
		28530003,
		0,
		Lang.get(67973),
		28530,
		3,
		287,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[28530004] = {
		28530004,
		4,
		nil,
		28530,
		4,
		287,
		{
			RTResTalkAction[23]
		},
		[29] = {
			{
				id = 28530005,
				branch_content = Lang.get(67974)
			}
		}
	},
	[28530005] = {
		28530005,
		0,
		Lang.get(67975),
		28530,
		5,
		287,
		{
			RTResTalkAction[23]
		}
	},
	[28530006] = {
		28530006,
		0,
		Lang.get(67976),
		28530,
		6,
		287,
		{
			RTResTalkAction[23]
		}
	},
	[28530007] = {
		28530007,
		0,
		Lang.get(67977),
		28530,
		7,
		300,
		{
			RTResTalkAction[24]
		}
	},
	[28530008] = {
		28530008,
		0,
		Lang.get(67978),
		28530,
		8,
		287,
		{
			RTResTalkAction[23]
		}
	},
	[28530009] = {
		28530009,
		0,
		Lang.get(67979),
		28530,
		9,
		300,
		{
			RTResTalkAction[24]
		}
	},
	[28530010] = {
		28530010,
		0,
		"……",
		28530,
		10,
		287,
		{
			RTResTalkAction[23]
		}
	},
	[28530011] = {
		28530011,
		0,
		Lang.get(67980),
		28530,
		11,
		287,
		{
			RTResTalkAction[23]
		}
	},
	[28530012] = {
		28530012,
		0,
		Lang.get(54135),
		28530,
		12,
		287,
		{
			RTResTalkAction[23]
		}
	},
	[28530013] = {
		28530013,
		4,
		nil,
		28530,
		13,
		287,
		{
			RTResTalkAction[23]
		},
		[29] = {
			{
				id = 28530014,
				branch_content = Lang.get(67981)
			}
		}
	},
	[28530014] = {
		28530014,
		0,
		Lang.get(67982),
		28530,
		14,
		287,
		{
			RTResTalkAction[23]
		}
	},
	[28530015] = {
		28530015,
		0,
		Lang.get(67983),
		28530,
		15,
		300,
		{
			RTResTalkAction[24]
		}
	},
	[28530016] = {
		28530016,
		0,
		Lang.get(67984),
		28530,
		16,
		287,
		{
			RTResTalkAction[23]
		}
	},
	[28531001] = {
		28531001,
		0,
		Lang.get(67985),
		28531,
		1,
		287,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28531,
		nil,
		1,
		nil,
		1,
		nil,
		28531
	},
	[28531002] = {
		28531002,
		4,
		nil,
		28531,
		2,
		287,
		nil,
		1,
		[29] = {
			{
				id = 28531003,
				branch_content = Lang.get(67986)
			}
		}
	},
	[28531003] = {
		28531003,
		0,
		Lang.get(67987),
		28531,
		3,
		287,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[28531004] = {
		28531004,
		4,
		nil,
		28531,
		4,
		287,
		{
			RTResTalkAction[23]
		},
		[29] = {
			{
				id = 28531005,
				branch_content = Lang.get(24009)
			},
			{
				id = 28531005,
				branch_content = Lang.get(67988)
			}
		}
	},
	[28531005] = {
		28531005,
		0,
		Lang.get(67989),
		28531,
		5,
		287,
		{
			RTResTalkAction[23]
		}
	},
	[28531006] = {
		28531006,
		0,
		Lang.get(67990),
		28531,
		6,
		300,
		{
			RTResTalkAction[24]
		}
	},
	[28531007] = {
		28531007,
		0,
		Lang.get(67991),
		28531,
		7,
		300
	},
	[28531008] = {
		28531008,
		0,
		Lang.get(16653),
		28531,
		8,
		287,
		{
			RTResTalkAction[23]
		}
	},
	[28531009] = {
		28531009,
		0,
		Lang.get(67992),
		28531,
		9,
		740,
		{
			RTResTalkAction[25],
			RTResTalkAction[24]
		}
	},
	[28531010] = {
		28531010,
		0,
		Lang.get(67993),
		28531,
		10,
		287,
		{
			RTResTalkAction[23],
			RTResTalkAction[26]
		}
	},
	[28531011] = {
		28531011,
		4,
		nil,
		28531,
		11,
		287,
		{
			RTResTalkAction[23]
		},
		[29] = {
			{
				id = 28531012,
				branch_content = Lang.get(67994)
			},
			{
				id = 28531012,
				branch_content = Lang.get(67995)
			}
		}
	},
	[28531012] = {
		28531012,
		0,
		Lang.get(67996),
		28531,
		12,
		287,
		{
			RTResTalkAction[23]
		}
	},
	[28531013] = {
		28531013,
		0,
		Lang.get(67997),
		28531,
		13,
		300,
		{
			RTResTalkAction[24]
		}
	},
	[28531014] = {
		28531014,
		0,
		Lang.get(67998),
		28531,
		14,
		287,
		{
			RTResTalkAction[23]
		}
	},
	[28531015] = {
		28531015,
		0,
		Lang.get(67999),
		28531,
		15,
		287,
		{
			RTResTalkAction[23]
		}
	},
	[28531016] = {
		28531016,
		0,
		Lang.get(68000),
		28531,
		16,
		300,
		{
			RTResTalkAction[24]
		}
	},
	[28531017] = {
		28531017,
		0,
		Lang.get(68001),
		28531,
		17,
		287,
		{
			RTResTalkAction[23]
		}
	},
	[28532001] = {
		28532001,
		0,
		Lang.get(68002),
		28532,
		1,
		287,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28532,
		nil,
		1,
		nil,
		1,
		nil,
		28532
	},
	[28532002] = {
		28532002,
		4,
		nil,
		28532,
		2,
		287,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		3,
		[29] = {
			{
				id = 28532003,
				branch_content = "……"
			}
		}
	},
	[28532003] = {
		28532003,
		0,
		Lang.get(68003),
		28532,
		3,
		287,
		{
			RTResTalkAction[23]
		}
	},
	[28532004] = {
		28532004,
		4,
		nil,
		28532,
		4,
		287,
		{
			RTResTalkAction[23]
		},
		[29] = {
			{
				id = 28532005,
				branch_content = Lang.get(68004)
			}
		}
	},
	[28532005] = {
		28532005,
		0,
		Lang.get(68005),
		28532,
		5,
		287,
		{
			RTResTalkAction[23]
		}
	},
	[28532006] = {
		28532006,
		0,
		Lang.get(68006),
		28532,
		6,
		300,
		{
			RTResTalkAction[24]
		}
	},
	[28532007] = {
		28532007,
		0,
		Lang.get(68007),
		28532,
		7,
		287,
		{
			RTResTalkAction[23]
		}
	},
	[28532008] = {
		28532008,
		4,
		nil,
		28532,
		8,
		287,
		{
			RTResTalkAction[23]
		},
		[29] = {
			{
				id = 28532009,
				branch_content = "……"
			}
		}
	},
	[28532009] = {
		28532009,
		0,
		Lang.get(68008),
		28532,
		9,
		287,
		{
			RTResTalkAction[23]
		}
	},
	[28532010] = {
		28532010,
		4,
		nil,
		28532,
		10,
		287,
		{
			RTResTalkAction[23]
		},
		[29] = {
			{
				id = 28532011,
				branch_content = Lang.get(68009)
			},
			{
				id = 28532011,
				branch_content = Lang.get(68010)
			}
		}
	},
	[28532011] = {
		28532011,
		0,
		Lang.get(68011),
		28532,
		11,
		287,
		{
			RTResTalkAction[23]
		}
	},
	[28532012] = {
		28532012,
		0,
		Lang.get(68012),
		28532,
		12,
		287,
		{
			RTResTalkAction[23]
		}
	},
	[28532013] = {
		28532013,
		0,
		Lang.get(68013),
		28532,
		13,
		287,
		{
			RTResTalkAction[23]
		}
	},
	[28532014] = {
		28532014,
		4,
		nil,
		28532,
		14,
		287,
		{
			RTResTalkAction[23]
		},
		[29] = {
			{
				id = 28532015,
				branch_content = Lang.get(68014)
			},
			{
				id = 28532015,
				branch_content = Lang.get(68015)
			}
		}
	},
	[28532015] = {
		28532015,
		0,
		Lang.get(68016),
		28532,
		15,
		287,
		{
			RTResTalkAction[23]
		}
	},
	[28533001] = {
		28533001,
		0,
		Lang.get(37720),
		28533,
		1,
		188,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28533,
		nil,
		1,
		nil,
		1,
		nil,
		28533
	},
	[28533002] = {
		28533002,
		4,
		nil,
		28533,
		2,
		188,
		{
			RTResTalkAction[27]
		},
		nil,
		nil,
		3,
		[29] = {
			{
				id = 28533004,
				branch_content = Lang.get(69765)
			},
			{
				id = 28533003,
				branch_content = Lang.get(69766)
			}
		}
	},
	[28533003] = {
		28533003,
		0,
		Lang.get(69767),
		28533,
		3,
		188,
		{
			RTResTalkAction[27]
		}
	},
	[28533004] = {
		28533004,
		0,
		Lang.get(69768),
		28533,
		4,
		188,
		{
			RTResTalkAction[27]
		}
	},
	[28533005] = {
		28533005,
		0,
		Lang.get(69769),
		28533,
		5,
		188,
		{
			RTResTalkAction[27]
		}
	},
	[28533006] = {
		28533006,
		4,
		nil,
		28533,
		6,
		188,
		{
			RTResTalkAction[27]
		},
		[29] = {
			{
				id = 28533007,
				branch_content = Lang.get(69770)
			}
		}
	},
	[28533007] = {
		28533007,
		0,
		Lang.get(69771),
		28533,
		7,
		188,
		{
			RTResTalkAction[27]
		}
	},
	[28533008] = {
		28533008,
		0,
		Lang.get(69772),
		28533,
		8,
		188,
		{
			RTResTalkAction[27]
		}
	},
	[28533009] = {
		28533009,
		4,
		nil,
		28533,
		9,
		188,
		{
			RTResTalkAction[27]
		},
		[29] = {
			{
				id = 28533010,
				branch_content = Lang.get(69773)
			}
		}
	},
	[28533010] = {
		28533010,
		0,
		Lang.get(69774),
		28533,
		10,
		188,
		{
			RTResTalkAction[27]
		}
	},
	[28533011] = {
		28533011,
		4,
		nil,
		28533,
		11,
		188,
		{
			RTResTalkAction[27]
		},
		[29] = {
			{
				id = 28533012,
				branch_content = Lang.get(69775)
			},
			{
				id = 28533012,
				branch_content = Lang.get(69776)
			}
		}
	},
	[28533012] = {
		28533012,
		0,
		Lang.get(69777),
		28533,
		12,
		188,
		{
			RTResTalkAction[27]
		}
	},
	[28533013] = {
		28533013,
		0,
		Lang.get(69778),
		28533,
		13,
		188,
		{
			RTResTalkAction[27]
		}
	},
	[28534001] = {
		28534001,
		0,
		Lang.get(69779),
		28534,
		1,
		188,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28534,
		nil,
		1,
		nil,
		1,
		nil,
		28534
	},
	[28534002] = {
		28534002,
		4,
		nil,
		28534,
		2,
		188,
		{
			RTResTalkAction[27]
		},
		nil,
		nil,
		3,
		[29] = {
			{
				id = 28534003,
				branch_content = Lang.get(69780)
			}
		}
	},
	[28534003] = {
		28534003,
		0,
		Lang.get(69781),
		28534,
		3,
		188,
		{
			RTResTalkAction[27]
		}
	},
	[28534004] = {
		28534004,
		0,
		Lang.get(69782),
		28534,
		4,
		188,
		{
			RTResTalkAction[27]
		}
	},
	[28534005] = {
		28534005,
		4,
		nil,
		28534,
		5,
		188,
		{
			RTResTalkAction[27]
		},
		[29] = {
			{
				id = 28534006,
				branch_content = Lang.get(69783)
			}
		}
	},
	[28534006] = {
		28534006,
		0,
		Lang.get(69784),
		28534,
		6,
		188,
		{
			RTResTalkAction[27]
		}
	},
	[28534007] = {
		28534007,
		4,
		nil,
		28534,
		7,
		188,
		{
			RTResTalkAction[27]
		},
		[29] = {
			{
				id = 28534008,
				branch_content = Lang.get(69785)
			}
		}
	},
	[28534008] = {
		28534008,
		0,
		Lang.get(69786),
		28534,
		8,
		188,
		{
			RTResTalkAction[27]
		}
	},
	[28534009] = {
		28534009,
		4,
		nil,
		28534,
		9,
		188,
		{
			RTResTalkAction[27]
		},
		[29] = {
			{
				id = 28534010,
				branch_content = Lang.get(69787)
			}
		}
	},
	[28534010] = {
		28534010,
		0,
		Lang.get(69788),
		28534,
		10,
		188,
		{
			RTResTalkAction[27]
		}
	},
	[28534011] = {
		28534011,
		4,
		nil,
		28534,
		11,
		188,
		{
			RTResTalkAction[27]
		},
		[29] = {
			{
				id = 28534012,
				branch_content = Lang.get(69789)
			}
		}
	},
	[28534012] = {
		28534012,
		0,
		Lang.get(69790),
		28534,
		12,
		188,
		{
			RTResTalkAction[27]
		}
	},
	[28534013] = {
		28534013,
		4,
		nil,
		28534,
		13,
		188,
		{
			RTResTalkAction[27]
		},
		[29] = {
			{
				id = 28534014,
				branch_content = Lang.get(69791)
			},
			{
				id = 28534014,
				branch_content = Lang.get(69792)
			}
		}
	},
	[28534014] = {
		28534014,
		0,
		Lang.get(69793),
		28534,
		14,
		188,
		{
			RTResTalkAction[27]
		}
	},
	[28535001] = {
		28535001,
		0,
		Lang.get(69794),
		28535,
		1,
		188,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28535,
		nil,
		1,
		nil,
		1,
		nil,
		28535
	},
	[28535002] = {
		28535002,
		4,
		nil,
		28535,
		2,
		188,
		{
			RTResTalkAction[27]
		},
		nil,
		nil,
		3,
		[29] = {
			{
				id = 28535003,
				branch_content = Lang.get(69795)
			}
		}
	},
	[28535003] = {
		28535003,
		0,
		Lang.get(69796),
		28535,
		3,
		188,
		{
			RTResTalkAction[27]
		}
	},
	[28535004] = {
		28535004,
		0,
		Lang.get(69797),
		28535,
		4,
		188,
		{
			RTResTalkAction[27]
		}
	},
	[28535005] = {
		28535005,
		4,
		nil,
		28535,
		5,
		188,
		{
			RTResTalkAction[27]
		},
		[29] = {
			{
				id = 28535006,
				branch_content = Lang.get(69798)
			},
			{
				id = 28535006,
				branch_content = Lang.get(69799)
			}
		}
	},
	[28535006] = {
		28535006,
		0,
		Lang.get(69800),
		28535,
		6,
		188,
		{
			RTResTalkAction[27]
		}
	},
	[28535007] = {
		28535007,
		4,
		nil,
		28535,
		7,
		188,
		{
			RTResTalkAction[27]
		},
		[29] = {
			{
				id = 28535008,
				branch_content = Lang.get(69801)
			}
		}
	},
	[28535008] = {
		28535008,
		0,
		Lang.get(69802),
		28535,
		8,
		188,
		{
			RTResTalkAction[27]
		}
	},
	[28535009] = {
		28535009,
		0,
		Lang.get(69803),
		28535,
		9,
		188,
		{
			RTResTalkAction[27]
		}
	},
	[28535010] = {
		28535010,
		4,
		nil,
		28535,
		10,
		188,
		{
			RTResTalkAction[27]
		},
		[29] = {
			{
				id = 28535011,
				branch_content = "……"
			},
			{
				id = 28535011,
				branch_content = Lang.get(69804)
			}
		}
	},
	[28535011] = {
		28535011,
		0,
		Lang.get(69805),
		28535,
		11,
		188,
		{
			RTResTalkAction[27]
		}
	},
	[28535012] = {
		28535012,
		0,
		Lang.get(69806),
		28535,
		12,
		188,
		{
			RTResTalkAction[27]
		}
	},
	[28535013] = {
		28535013,
		0,
		Lang.get(69807),
		28535,
		13,
		188,
		{
			RTResTalkAction[27]
		}
	},
	[28535014] = {
		28535014,
		4,
		nil,
		28535,
		14,
		188,
		{
			RTResTalkAction[27]
		},
		[29] = {
			{
				id = 28535015,
				branch_content = Lang.get(19725)
			}
		}
	},
	[28535015] = {
		28535015,
		0,
		Lang.get(69808),
		28535,
		15,
		188,
		{
			RTResTalkAction[27]
		}
	},
	[28536001] = {
		28536001,
		0,
		Lang.get(69809),
		28536,
		1,
		159,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28536,
		nil,
		1,
		nil,
		1,
		nil,
		28536
	},
	[28536002] = {
		28536002,
		0,
		Lang.get(69810),
		28536,
		2,
		159,
		{
			RTResTalkAction[28]
		},
		nil,
		nil,
		3
	},
	[28536003] = {
		28536003,
		0,
		Lang.get(69811),
		28536,
		3,
		159,
		{
			RTResTalkAction[28]
		}
	},
	[28536004] = {
		28536004,
		0,
		Lang.get(69812),
		28536,
		4,
		300,
		{
			RTResTalkAction[29]
		}
	},
	[28536005] = {
		28536005,
		0,
		Lang.get(69813),
		28536,
		5,
		159,
		{
			RTResTalkAction[28]
		}
	},
	[28536006] = {
		28536006,
		0,
		Lang.get(69814),
		28536,
		6,
		159,
		{
			RTResTalkAction[28]
		}
	},
	[28536007] = {
		28536007,
		0,
		Lang.get(69815),
		28536,
		7,
		300,
		{
			RTResTalkAction[29]
		}
	},
	[28536008] = {
		28536008,
		0,
		Lang.get(69816),
		28536,
		8,
		159,
		{
			RTResTalkAction[28]
		}
	},
	[28536009] = {
		28536009,
		0,
		Lang.get(69817),
		28536,
		9,
		300,
		{
			RTResTalkAction[29]
		}
	},
	[28536010] = {
		28536010,
		0,
		Lang.get(69818),
		28536,
		10,
		159,
		{
			RTResTalkAction[28]
		}
	},
	[28536011] = {
		28536011,
		0,
		Lang.get(69819),
		28536,
		11,
		159,
		{
			RTResTalkAction[28]
		}
	},
	[28536012] = {
		28536012,
		0,
		Lang.get(69820),
		28536,
		12,
		300,
		{
			RTResTalkAction[29]
		}
	},
	[28536013] = {
		28536013,
		0,
		Lang.get(69821),
		28536,
		13,
		159,
		{
			RTResTalkAction[28]
		}
	},
	[28537001] = {
		28537001,
		0,
		Lang.get(69822),
		28537,
		1,
		159,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28537,
		nil,
		1,
		nil,
		1,
		nil,
		28537
	},
	[28537002] = {
		28537002,
		0,
		Lang.get(69823),
		28537,
		2,
		300,
		nil,
		nil,
		nil,
		3
	},
	[28537003] = {
		28537003,
		0,
		Lang.get(69824),
		28537,
		3,
		300
	},
	[28537004] = {
		28537004,
		0,
		Lang.get(69825),
		28537,
		4,
		159,
		{
			RTResTalkAction[28]
		}
	},
	[28537005] = {
		28537005,
		0,
		Lang.get(69826),
		28537,
		5,
		159,
		{
			RTResTalkAction[28]
		}
	},
	[28537006] = {
		28537006,
		0,
		Lang.get(69827),
		28537,
		6,
		300,
		{
			RTResTalkAction[29]
		}
	},
	[28537007] = {
		28537007,
		0,
		Lang.get(69828),
		28537,
		7,
		159,
		{
			RTResTalkAction[28]
		}
	},
	[28537008] = {
		28537008,
		0,
		Lang.get(69829),
		28537,
		8,
		159,
		{
			RTResTalkAction[28]
		}
	},
	[28537009] = {
		28537009,
		0,
		Lang.get(69830),
		28537,
		9,
		159,
		{
			RTResTalkAction[28]
		}
	},
	[28537010] = {
		28537010,
		0,
		Lang.get(69831),
		28537,
		10,
		300,
		{
			RTResTalkAction[29]
		}
	},
	[28537011] = {
		28537011,
		0,
		Lang.get(69832),
		28537,
		11,
		159,
		{
			RTResTalkAction[28]
		}
	},
	[28537012] = {
		28537012,
		0,
		Lang.get(69833),
		28537,
		12,
		300,
		{
			RTResTalkAction[29]
		}
	},
	[28537013] = {
		28537013,
		0,
		Lang.get(69834),
		28537,
		13,
		159,
		{
			RTResTalkAction[28]
		}
	},
	[28537014] = {
		28537014,
		0,
		Lang.get(69835),
		28537,
		14,
		159,
		{
			RTResTalkAction[28]
		}
	},
	[28538001] = {
		28538001,
		0,
		Lang.get(69836),
		28538,
		1,
		159,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28538,
		nil,
		1,
		nil,
		1,
		nil,
		28538
	},
	[28538002] = {
		28538002,
		0,
		Lang.get(69837),
		28538,
		2,
		300,
		nil,
		nil,
		nil,
		3
	},
	[28538003] = {
		28538003,
		0,
		Lang.get(34833),
		28538,
		3,
		159,
		{
			RTResTalkAction[28]
		}
	},
	[28538004] = {
		28538004,
		0,
		Lang.get(69838),
		28538,
		4,
		159,
		{
			RTResTalkAction[28]
		}
	},
	[28538005] = {
		28538005,
		0,
		Lang.get(69839),
		28538,
		5,
		159,
		{
			RTResTalkAction[28]
		}
	},
	[28538006] = {
		28538006,
		0,
		Lang.get(69840),
		28538,
		6,
		300,
		{
			RTResTalkAction[29]
		}
	},
	[28538007] = {
		28538007,
		0,
		Lang.get(69841),
		28538,
		7,
		300
	},
	[28538008] = {
		28538008,
		0,
		Lang.get(69842),
		28538,
		8,
		159,
		{
			RTResTalkAction[28]
		}
	},
	[28538009] = {
		28538009,
		0,
		Lang.get(69843),
		28538,
		9,
		159,
		{
			RTResTalkAction[28]
		}
	},
	[28538010] = {
		28538010,
		0,
		Lang.get(69844),
		28538,
		10,
		159,
		{
			RTResTalkAction[28]
		}
	},
	[28538011] = {
		28538011,
		0,
		Lang.get(69845),
		28538,
		11,
		300,
		{
			RTResTalkAction[29]
		}
	},
	[28538012] = {
		28538012,
		0,
		Lang.get(69846),
		28538,
		12,
		159,
		{
			RTResTalkAction[28]
		}
	},
	[28538013] = {
		28538013,
		0,
		Lang.get(69847),
		28538,
		13,
		159,
		{
			RTResTalkAction[28]
		}
	},
	[28539001] = {
		28539001,
		0,
		Lang.get(69848),
		28539,
		1,
		301,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28539,
		nil,
		1,
		nil,
		1,
		nil,
		28539
	},
	[28539002] = {
		28539002,
		4,
		nil,
		28539,
		2,
		301,
		nil,
		nil,
		nil,
		3,
		[29] = {
			{
				id = 28539003,
				branch_content = Lang.get(69849)
			}
		}
	},
	[28539003] = {
		28539003,
		0,
		Lang.get(46921),
		28539,
		3,
		301,
		{
			RTResTalkAction[30]
		}
	},
	[28539004] = {
		28539004,
		0,
		Lang.get(69850),
		28539,
		4,
		300,
		{
			RTResTalkAction[31]
		}
	},
	[28539005] = {
		28539005,
		0,
		Lang.get(75722),
		28539,
		5,
		301,
		{
			RTResTalkAction[30]
		}
	},
	[28539006] = {
		28539006,
		0,
		Lang.get(69852),
		28539,
		6,
		301,
		{
			RTResTalkAction[30]
		}
	},
	[28539007] = {
		28539007,
		4,
		nil,
		28539,
		7,
		301,
		{
			RTResTalkAction[31]
		},
		[29] = {
			{
				id = 28539008,
				branch_content = Lang.get(69853)
			}
		}
	},
	[28539008] = {
		28539008,
		0,
		Lang.get(75723),
		28539,
		8,
		301,
		{
			RTResTalkAction[30]
		}
	},
	[28539009] = {
		28539009,
		0,
		Lang.get(69855),
		28539,
		9,
		301,
		{
			RTResTalkAction[30]
		}
	},
	[28539010] = {
		28539010,
		4,
		nil,
		28539,
		10,
		301,
		{
			RTResTalkAction[31]
		},
		[29] = {
			{
				id = 28539011,
				branch_content = Lang.get(69856)
			},
			{
				id = 28539011,
				branch_content = Lang.get(69857)
			}
		}
	},
	[28539011] = {
		28539011,
		0,
		Lang.get(69858),
		28539,
		11,
		301,
		{
			RTResTalkAction[30]
		}
	},
	[28539012] = {
		28539012,
		4,
		nil,
		28539,
		12,
		301,
		{
			RTResTalkAction[31]
		},
		[29] = {
			{
				id = 28539013,
				branch_content = Lang.get(69859)
			}
		}
	},
	[28539013] = {
		28539013,
		0,
		"Certainly.",
		28539,
		13,
		301,
		{
			RTResTalkAction[30]
		}
	},
	[28540001] = {
		28540001,
		0,
		Lang.get(75724),
		28540,
		1,
		301,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28540,
		nil,
		1,
		nil,
		1,
		nil,
		28540
	},
	[28540002] = {
		28540002,
		4,
		nil,
		28540,
		2,
		301,
		{
			RTResTalkAction[30]
		},
		nil,
		nil,
		3,
		[29] = {
			{
				id = 28540003,
				branch_content = Lang.get(69861)
			}
		}
	},
	[28540003] = {
		28540003,
		0,
		Lang.get(69862),
		28540,
		3,
		301,
		{
			RTResTalkAction[30]
		}
	},
	[28540004] = {
		28540004,
		4,
		nil,
		28540,
		4,
		301,
		{
			RTResTalkAction[30]
		},
		[29] = {
			{
				id = 28540005,
				branch_content = Lang.get(69863)
			}
		}
	},
	[28540005] = {
		28540005,
		0,
		Lang.get(75725),
		28540,
		5,
		301,
		{
			RTResTalkAction[30]
		}
	},
	[28540006] = {
		28540006,
		0,
		Lang.get(69865),
		28540,
		6,
		301,
		{
			RTResTalkAction[30]
		}
	},
	[28540007] = {
		28540007,
		0,
		Lang.get(69866),
		28540,
		7,
		301,
		{
			RTResTalkAction[30]
		}
	},
	[28540008] = {
		28540008,
		4,
		nil,
		28540,
		8,
		301,
		{
			RTResTalkAction[30]
		},
		[29] = {
			{
				id = 28540009,
				branch_content = Lang.get(69867)
			}
		}
	},
	[28540009] = {
		28540009,
		0,
		Lang.get(69868),
		28540,
		9,
		301,
		{
			RTResTalkAction[30]
		}
	},
	[28540010] = {
		28540010,
		0,
		Lang.get(69869),
		28540,
		10,
		301,
		{
			RTResTalkAction[30]
		}
	},
	[28540011] = {
		28540011,
		4,
		nil,
		28540,
		11,
		301,
		{
			RTResTalkAction[30]
		},
		[29] = {
			{
				id = 28540012,
				branch_content = Lang.get(69870)
			},
			{
				id = 28540012,
				branch_content = Lang.get(69871)
			}
		}
	},
	[28540012] = {
		28540012,
		0,
		Lang.get(75726),
		28540,
		12,
		301,
		{
			RTResTalkAction[30]
		}
	},
	[28540013] = {
		28540013,
		0,
		Lang.get(75727),
		28540,
		13,
		301,
		{
			RTResTalkAction[30]
		}
	},
	[28540014] = {
		28540014,
		0,
		Lang.get(46934),
		28540,
		14,
		300,
		{
			RTResTalkAction[31]
		}
	},
	[28540015] = {
		28540015,
		0,
		Lang.get(75728),
		28540,
		15,
		301,
		{
			RTResTalkAction[30]
		}
	},
	[28541001] = {
		28541001,
		0,
		"What？",
		28541,
		1,
		301,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28541,
		nil,
		1,
		nil,
		1,
		nil,
		28541
	},
	[28541002] = {
		28541002,
		4,
		nil,
		28541,
		2,
		301,
		{
			RTResTalkAction[30]
		},
		nil,
		nil,
		3,
		[29] = {
			{
				id = 28541003,
				branch_content = Lang.get(69875)
			}
		}
	},
	[28541003] = {
		28541003,
		0,
		Lang.get(69876),
		28541,
		3,
		301,
		{
			RTResTalkAction[30]
		}
	},
	[28541004] = {
		28541004,
		0,
		Lang.get(69877),
		28541,
		4,
		301,
		{
			RTResTalkAction[30]
		}
	},
	[28541005] = {
		28541005,
		4,
		nil,
		28541,
		5,
		301,
		{
			RTResTalkAction[30]
		},
		[29] = {
			{
				id = 28541006,
				branch_content = Lang.get(69878)
			}
		}
	},
	[28541006] = {
		28541006,
		0,
		Lang.get(75729),
		28541,
		6,
		301,
		{
			RTResTalkAction[30]
		}
	},
	[28541007] = {
		28541007,
		0,
		Lang.get(69880),
		28541,
		7,
		301,
		{
			RTResTalkAction[30]
		}
	},
	[28541008] = {
		28541008,
		0,
		Lang.get(75730),
		28541,
		8,
		301,
		{
			RTResTalkAction[30]
		}
	},
	[28541009] = {
		28541009,
		4,
		nil,
		28541,
		9,
		301,
		{
			RTResTalkAction[30]
		},
		[29] = {
			{
				id = 28541010,
				branch_content = Lang.get(69882)
			}
		}
	},
	[28541010] = {
		28541010,
		0,
		Lang.get(75731),
		28541,
		10,
		301,
		{
			RTResTalkAction[30]
		}
	},
	[28541011] = {
		28541011,
		0,
		Lang.get(69884),
		28541,
		11,
		301,
		{
			RTResTalkAction[30]
		}
	},
	[28541012] = {
		28541012,
		4,
		nil,
		28541,
		12,
		301,
		{
			RTResTalkAction[30]
		},
		[29] = {
			{
				id = 28541013,
				branch_content = Lang.get(69885)
			}
		}
	},
	[28541013] = {
		28541013,
		0,
		Lang.get(75732),
		28541,
		13,
		301,
		{
			RTResTalkAction[30]
		}
	},
	[28541014] = {
		28541014,
		0,
		Lang.get(75733),
		28541,
		14,
		301,
		{
			RTResTalkAction[30]
		}
	},
	[28542001] = {
		28542001,
		0,
		Lang.get(69887),
		28542,
		1,
		194,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28542,
		nil,
		1,
		nil,
		1,
		nil,
		28542
	},
	[28542002] = {
		28542002,
		0,
		Lang.get(69888),
		28542,
		2,
		300,
		nil,
		nil,
		nil,
		3
	},
	[28542003] = {
		28542003,
		0,
		Lang.get(69889),
		28542,
		3,
		194,
		{
			RTResTalkAction[32]
		}
	},
	[28542004] = {
		28542004,
		0,
		Lang.get(69890),
		28542,
		4,
		300,
		{
			RTResTalkAction[33]
		}
	},
	[28542005] = {
		28542005,
		0,
		Lang.get(69891),
		28542,
		5,
		194,
		{
			RTResTalkAction[32]
		}
	},
	[28542006] = {
		28542006,
		0,
		Lang.get(69892),
		28542,
		6,
		300,
		{
			RTResTalkAction[33]
		}
	},
	[28542007] = {
		28542007,
		0,
		Lang.get(69893),
		28542,
		7,
		300
	},
	[28542008] = {
		28542008,
		0,
		Lang.get(69894),
		28542,
		8,
		194,
		{
			RTResTalkAction[32]
		}
	},
	[28542009] = {
		28542009,
		0,
		Lang.get(69895),
		28542,
		9,
		300,
		{
			RTResTalkAction[33]
		}
	},
	[28542010] = {
		28542010,
		0,
		"……",
		28542,
		10,
		194,
		{
			RTResTalkAction[32]
		}
	},
	[28542011] = {
		28542011,
		0,
		Lang.get(69896),
		28542,
		11,
		194,
		{
			RTResTalkAction[32]
		}
	},
	[28542012] = {
		28542012,
		0,
		Lang.get(69897),
		28542,
		12,
		300,
		{
			RTResTalkAction[33]
		}
	},
	[28542013] = {
		28542013,
		0,
		Lang.get(69898),
		28542,
		13,
		300
	},
	[28542014] = {
		28542014,
		0,
		Lang.get(69899),
		28542,
		14,
		194,
		{
			RTResTalkAction[32]
		}
	},
	[28542015] = {
		28542015,
		0,
		Lang.get(69900),
		28542,
		15,
		194,
		{
			RTResTalkAction[32]
		}
	},
	[28542016] = {
		28542016,
		0,
		Lang.get(69901),
		28542,
		16,
		194,
		{
			RTResTalkAction[32]
		}
	},
	[28542017] = {
		28542017,
		0,
		Lang.get(69902),
		28542,
		17,
		300,
		{
			RTResTalkAction[33]
		}
	},
	[28542018] = {
		28542018,
		0,
		Lang.get(69903),
		28542,
		18,
		194,
		{
			RTResTalkAction[32]
		}
	},
	[28542019] = {
		28542019,
		0,
		Lang.get(69904),
		28542,
		19,
		194,
		{
			RTResTalkAction[32]
		}
	},
	[28543001] = {
		28543001,
		0,
		Lang.get(69905),
		28543,
		1,
		194,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28543,
		nil,
		1,
		nil,
		1,
		nil,
		28543
	},
	[28543002] = {
		28543002,
		0,
		Lang.get(69906),
		28543,
		2,
		300,
		nil,
		nil,
		nil,
		3
	},
	[28543003] = {
		28543003,
		0,
		Lang.get(69907),
		28543,
		3,
		194,
		{
			RTResTalkAction[32]
		}
	},
	[28543004] = {
		28543004,
		0,
		Lang.get(69908),
		28543,
		4,
		300,
		{
			RTResTalkAction[33]
		}
	},
	[28543005] = {
		28543005,
		0,
		Lang.get(69909),
		28543,
		5,
		194,
		{
			RTResTalkAction[32]
		}
	},
	[28543006] = {
		28543006,
		0,
		Lang.get(69910),
		28543,
		6,
		194,
		{
			RTResTalkAction[32]
		}
	},
	[28543007] = {
		28543007,
		0,
		Lang.get(69911),
		28543,
		7,
		194,
		{
			RTResTalkAction[32]
		}
	},
	[28543008] = {
		28543008,
		0,
		Lang.get(69912),
		28543,
		8,
		194,
		{
			RTResTalkAction[32]
		}
	},
	[28543009] = {
		28543009,
		0,
		Lang.get(69913),
		28543,
		9,
		194,
		{
			RTResTalkAction[32]
		}
	},
	[28543010] = {
		28543010,
		0,
		Lang.get(69914),
		28543,
		10,
		194,
		{
			RTResTalkAction[32]
		}
	},
	[28543011] = {
		28543011,
		0,
		Lang.get(69915),
		28543,
		11,
		194,
		{
			RTResTalkAction[32]
		}
	},
	[28543012] = {
		28543012,
		0,
		Lang.get(69916),
		28543,
		12,
		300,
		{
			RTResTalkAction[33]
		}
	},
	[28543013] = {
		28543013,
		0,
		Lang.get(69917),
		28543,
		13,
		194,
		{
			RTResTalkAction[32]
		}
	},
	[28543014] = {
		28543014,
		0,
		Lang.get(69918),
		28543,
		14,
		300,
		{
			RTResTalkAction[33]
		}
	},
	[28543015] = {
		28543015,
		0,
		Lang.get(69919),
		28543,
		15,
		300
	},
	[28543016] = {
		28543016,
		0,
		Lang.get(69920),
		28543,
		16,
		194,
		{
			RTResTalkAction[32]
		}
	},
	[28543017] = {
		28543017,
		0,
		Lang.get(69921),
		28543,
		17,
		194,
		{
			RTResTalkAction[32]
		}
	},
	[28544001] = {
		28544001,
		0,
		Lang.get(69922),
		28544,
		1,
		194,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28544,
		nil,
		1,
		nil,
		1,
		nil,
		28544
	},
	[28544002] = {
		28544002,
		0,
		Lang.get(69923),
		28544,
		2,
		300,
		nil,
		nil,
		nil,
		3
	},
	[28544003] = {
		28544003,
		0,
		"……",
		28544,
		3,
		194,
		{
			RTResTalkAction[32]
		}
	},
	[28544004] = {
		28544004,
		0,
		Lang.get(69924),
		28544,
		4,
		300,
		{
			RTResTalkAction[33]
		}
	},
	[28544005] = {
		28544005,
		0,
		Lang.get(19533),
		28544,
		5,
		194,
		{
			RTResTalkAction[32]
		}
	},
	[28544006] = {
		28544006,
		0,
		Lang.get(69925),
		28544,
		6,
		194,
		{
			RTResTalkAction[32]
		}
	},
	[28544007] = {
		28544007,
		0,
		Lang.get(69926),
		28544,
		7,
		300,
		{
			RTResTalkAction[33]
		}
	},
	[28544008] = {
		28544008,
		0,
		Lang.get(69927),
		28544,
		8,
		194,
		{
			RTResTalkAction[32]
		}
	},
	[28544009] = {
		28544009,
		0,
		Lang.get(69928),
		28544,
		9,
		300,
		{
			RTResTalkAction[33]
		}
	},
	[28544010] = {
		28544010,
		0,
		Lang.get(69929),
		28544,
		10,
		300
	},
	[28544011] = {
		28544011,
		0,
		Lang.get(69930),
		28544,
		11,
		194,
		{
			RTResTalkAction[32]
		}
	},
	[28544012] = {
		28544012,
		0,
		Lang.get(69931),
		28544,
		12,
		300,
		{
			RTResTalkAction[33]
		}
	},
	[28544013] = {
		28544013,
		0,
		Lang.get(69932),
		28544,
		13,
		300
	},
	[28544014] = {
		28544014,
		0,
		Lang.get(69933),
		28544,
		14,
		194,
		{
			RTResTalkAction[32]
		}
	},
	[28544015] = {
		28544015,
		0,
		Lang.get(69934),
		28544,
		15,
		300,
		{
			RTResTalkAction[33]
		}
	},
	[28544016] = {
		28544016,
		0,
		Lang.get(69935),
		28544,
		16,
		194,
		{
			RTResTalkAction[32]
		}
	},
	[28544017] = {
		28544017,
		0,
		Lang.get(69936),
		28544,
		17,
		300,
		{
			RTResTalkAction[33]
		}
	},
	[28544018] = {
		28544018,
		0,
		Lang.get(69937),
		28544,
		18,
		194,
		{
			RTResTalkAction[32]
		}
	},
	[28544019] = {
		28544019,
		0,
		Lang.get(69938),
		28544,
		19,
		194,
		{
			RTResTalkAction[32]
		}
	},
	[28545001] = {
		28545001,
		9,
		Lang.get(70281),
		28545,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		28545,
		nil,
		1,
		nil,
		1,
		nil,
		28545,
		nil,
		nil,
		1
	},
	[28545002] = {
		28545002,
		0,
		Lang.get(70282),
		28545,
		2,
		167,
		{
			RTResTalkAction[34]
		},
		nil,
		nil,
		3
	},
	[28545003] = {
		28545003,
		0,
		Lang.get(70283),
		28545,
		3,
		167,
		{
			RTResTalkAction[34]
		}
	},
	[28545004] = {
		28545004,
		5,
		Lang.get(70284),
		28545,
		4,
		167,
		{
			RTResTalkAction[34]
		}
	},
	[28545005] = {
		28545005,
		0,
		Lang.get(70285),
		28545,
		5,
		167,
		{
			RTResTalkAction[34]
		}
	},
	[28545006] = {
		28545006,
		0,
		Lang.get(70286),
		28545,
		6,
		300,
		{
			RTResTalkAction[35]
		}
	},
	[28545007] = {
		28545007,
		0,
		Lang.get(70287),
		28545,
		7,
		167,
		{
			RTResTalkAction[34]
		}
	},
	[28545008] = {
		28545008,
		0,
		Lang.get(70288),
		28545,
		8,
		300,
		{
			RTResTalkAction[35]
		}
	},
	[28545009] = {
		28545009,
		0,
		Lang.get(70289),
		28545,
		9,
		167,
		{
			RTResTalkAction[34]
		}
	},
	[28545010] = {
		28545010,
		0,
		Lang.get(70290),
		28545,
		10,
		167,
		{
			RTResTalkAction[34]
		}
	},
	[28545011] = {
		28545011,
		0,
		Lang.get(70291),
		28545,
		11,
		167,
		{
			RTResTalkAction[34]
		}
	},
	[28545012] = {
		28545012,
		0,
		Lang.get(70292),
		28545,
		12,
		167,
		{
			RTResTalkAction[34]
		}
	},
	[28545013] = {
		28545013,
		0,
		Lang.get(70293),
		28545,
		13,
		167,
		{
			RTResTalkAction[34]
		}
	},
	[28545014] = {
		28545014,
		0,
		Lang.get(70294),
		28545,
		14,
		167,
		{
			RTResTalkAction[34]
		}
	},
	[28545015] = {
		28545015,
		0,
		Lang.get(70295),
		28545,
		15,
		167,
		{
			RTResTalkAction[34]
		}
	},
	[28545016] = {
		28545016,
		0,
		Lang.get(70296),
		28545,
		16,
		300,
		{
			RTResTalkAction[35]
		}
	},
	[28545017] = {
		28545017,
		0,
		Lang.get(70297),
		28545,
		17,
		167,
		{
			RTResTalkAction[34]
		}
	},
	[28546001] = {
		28546001,
		0,
		Lang.get(70298),
		28546,
		1,
		167,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28546,
		nil,
		1,
		nil,
		1,
		nil,
		28546
	},
	[28546002] = {
		28546002,
		0,
		"……",
		28546,
		2,
		300,
		nil,
		nil,
		nil,
		3
	},
	[28546003] = {
		28546003,
		0,
		Lang.get(70299),
		28546,
		3,
		167,
		{
			RTResTalkAction[34]
		}
	},
	[28546004] = {
		28546004,
		0,
		Lang.get(70300),
		28546,
		4,
		300,
		{
			RTResTalkAction[35]
		}
	},
	[28546005] = {
		28546005,
		0,
		Lang.get(70301),
		28546,
		5,
		167,
		{
			RTResTalkAction[34]
		}
	},
	[28546006] = {
		28546006,
		0,
		Lang.get(70302),
		28546,
		6,
		167,
		{
			RTResTalkAction[34]
		}
	},
	[28546007] = {
		28546007,
		0,
		Lang.get(70303),
		28546,
		7,
		300,
		{
			RTResTalkAction[35]
		}
	},
	[28546008] = {
		28546008,
		0,
		Lang.get(70304),
		28546,
		8,
		167,
		{
			RTResTalkAction[34]
		}
	},
	[28546009] = {
		28546009,
		0,
		Lang.get(70305),
		28546,
		9,
		300,
		{
			RTResTalkAction[35]
		}
	},
	[28546010] = {
		28546010,
		0,
		Lang.get(70306),
		28546,
		10,
		167,
		{
			RTResTalkAction[34]
		}
	},
	[28546011] = {
		28546011,
		0,
		Lang.get(70307),
		28546,
		11,
		167,
		{
			RTResTalkAction[34]
		}
	},
	[28546012] = {
		28546012,
		0,
		Lang.get(70308),
		28546,
		12,
		300,
		{
			RTResTalkAction[35]
		}
	},
	[28546013] = {
		28546013,
		0,
		Lang.get(70309),
		28546,
		13,
		167,
		{
			RTResTalkAction[34]
		}
	},
	[28546014] = {
		28546014,
		0,
		Lang.get(70310),
		28546,
		14,
		300,
		{
			RTResTalkAction[35]
		}
	},
	[28546015] = {
		28546015,
		0,
		Lang.get(70311),
		28546,
		15,
		167,
		{
			RTResTalkAction[34]
		}
	},
	[28547001] = {
		28547001,
		0,
		Lang.get(70312),
		28547,
		1,
		167,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28547,
		nil,
		1,
		nil,
		1,
		nil,
		28547
	},
	[28547002] = {
		28547002,
		0,
		Lang.get(70313),
		28547,
		2,
		300,
		nil,
		nil,
		nil,
		3
	},
	[28547003] = {
		28547003,
		0,
		Lang.get(70314),
		28547,
		3,
		167,
		{
			RTResTalkAction[34]
		}
	},
	[28547004] = {
		28547004,
		0,
		Lang.get(70315),
		28547,
		4,
		167,
		{
			RTResTalkAction[34]
		}
	},
	[28547005] = {
		28547005,
		0,
		"……",
		28547,
		5,
		300,
		{
			RTResTalkAction[35]
		}
	},
	[28547006] = {
		28547006,
		0,
		Lang.get(70316),
		28547,
		6,
		167,
		{
			RTResTalkAction[34]
		}
	},
	[28547007] = {
		28547007,
		2,
		Lang.get(70317),
		28547,
		7,
		300,
		{
			RTResTalkAction[35]
		}
	},
	[28547008] = {
		28547008,
		2,
		Lang.get(70318),
		28547,
		8,
		300
	},
	[28547009] = {
		28547009,
		0,
		Lang.get(70319),
		28547,
		9,
		167,
		{
			RTResTalkAction[34]
		}
	},
	[28547010] = {
		28547010,
		0,
		Lang.get(70320),
		28547,
		10,
		300,
		{
			RTResTalkAction[35]
		}
	},
	[28547011] = {
		28547011,
		0,
		Lang.get(70321),
		28547,
		11,
		167,
		{
			RTResTalkAction[34]
		}
	},
	[28547012] = {
		28547012,
		0,
		Lang.get(70322),
		28547,
		12,
		300,
		{
			RTResTalkAction[35]
		}
	},
	[28547013] = {
		28547013,
		0,
		Lang.get(70323),
		28547,
		13,
		167,
		{
			RTResTalkAction[34]
		}
	},
	[28547014] = {
		28547014,
		0,
		Lang.get(70324),
		28547,
		14,
		167,
		{
			RTResTalkAction[34]
		}
	},
	[28547015] = {
		28547015,
		0,
		Lang.get(70325),
		28547,
		15,
		300,
		{
			RTResTalkAction[35]
		}
	},
	[28547016] = {
		28547016,
		5,
		Lang.get(70326),
		28547,
		16,
		167,
		{
			RTResTalkAction[34]
		}
	},
	[28548001] = {
		28548001,
		0,
		Lang.get(70327),
		28548,
		1,
		110,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28548,
		nil,
		1,
		nil,
		1,
		nil,
		28548
	},
	[28548002] = {
		28548002,
		0,
		Lang.get(70328),
		28548,
		2,
		300,
		nil,
		nil,
		nil,
		3
	},
	[28548003] = {
		28548003,
		0,
		Lang.get(70329),
		28548,
		3,
		110,
		{
			RTResTalkAction[36]
		}
	},
	[28548004] = {
		28548004,
		0,
		Lang.get(70330),
		28548,
		4,
		300,
		{
			RTResTalkAction[37]
		}
	},
	[28548005] = {
		28548005,
		0,
		Lang.get(70331),
		28548,
		5,
		300
	},
	[28548006] = {
		28548006,
		0,
		Lang.get(70332),
		28548,
		6,
		110,
		{
			RTResTalkAction[36]
		}
	},
	[28548007] = {
		28548007,
		0,
		Lang.get(70333),
		28548,
		7,
		110,
		{
			RTResTalkAction[36]
		}
	},
	[28548008] = {
		28548008,
		0,
		Lang.get(70334),
		28548,
		8,
		110,
		{
			RTResTalkAction[36]
		}
	},
	[28548009] = {
		28548009,
		0,
		Lang.get(70335),
		28548,
		9,
		300,
		{
			RTResTalkAction[37]
		}
	},
	[28548010] = {
		28548010,
		0,
		Lang.get(70336),
		28548,
		10,
		110,
		{
			RTResTalkAction[36]
		}
	},
	[28548011] = {
		28548011,
		0,
		Lang.get(70337),
		28548,
		11,
		300,
		{
			RTResTalkAction[37]
		}
	},
	[28548012] = {
		28548012,
		0,
		Lang.get(70338),
		28548,
		12,
		300
	},
	[28548013] = {
		28548013,
		0,
		Lang.get(70339),
		28548,
		13,
		110,
		{
			RTResTalkAction[36]
		}
	},
	[28549001] = {
		28549001,
		0,
		Lang.get(70340),
		28549,
		1,
		110,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28549,
		nil,
		1,
		nil,
		1,
		nil,
		28549
	},
	[28549002] = {
		28549002,
		0,
		Lang.get(70341),
		28549,
		2,
		110,
		{
			RTResTalkAction[36]
		},
		nil,
		nil,
		3
	},
	[28549003] = {
		28549003,
		0,
		Lang.get(70342),
		28549,
		3,
		110,
		{
			RTResTalkAction[36]
		}
	},
	[28549004] = {
		28549004,
		0,
		Lang.get(70343),
		28549,
		4,
		110,
		{
			RTResTalkAction[36]
		}
	},
	[28549005] = {
		28549005,
		0,
		Lang.get(70344),
		28549,
		5,
		300,
		{
			RTResTalkAction[37]
		}
	},
	[28549006] = {
		28549006,
		0,
		Lang.get(70345),
		28549,
		6,
		[7] = {
			RTResTalkAction[38]
		}
	},
	[28549007] = {
		28549007,
		0,
		Lang.get(70346),
		28549,
		7,
		[7] = {
			RTResTalkAction[38]
		}
	},
	[28549008] = {
		28549008,
		0,
		Lang.get(70347),
		28549,
		8,
		300,
		{
			RTResTalkAction[39]
		}
	},
	[28549009] = {
		28549009,
		0,
		Lang.get(70348),
		28549,
		9,
		300
	},
	[28549010] = {
		28549010,
		0,
		Lang.get(70349),
		28549,
		10,
		300
	},
	[28549011] = {
		28549011,
		0,
		Lang.get(70350),
		28549,
		11,
		110,
		{
			RTResTalkAction[36]
		}
	},
	[28549012] = {
		28549012,
		0,
		Lang.get(70351),
		28549,
		12,
		110,
		{
			RTResTalkAction[36]
		}
	},
	[28549013] = {
		28549013,
		0,
		Lang.get(70352),
		28549,
		13,
		110,
		{
			RTResTalkAction[36]
		}
	},
	[28550001] = {
		28550001,
		0,
		Lang.get(70353),
		28550,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		28550,
		nil,
		1,
		nil,
		1,
		nil,
		28550
	},
	[28550002] = {
		28550002,
		0,
		Lang.get(70354),
		28550,
		2,
		300,
		nil,
		nil,
		nil,
		3
	},
	[28550003] = {
		28550003,
		0,
		Lang.get(34583),
		28550,
		3,
		110,
		{
			RTResTalkAction[36]
		}
	},
	[28550004] = {
		28550004,
		0,
		Lang.get(70355),
		28550,
		4,
		300,
		{
			RTResTalkAction[37]
		}
	},
	[28550005] = {
		28550005,
		0,
		Lang.get(70356),
		28550,
		5,
		300
	},
	[28550006] = {
		28550006,
		0,
		Lang.get(70357),
		28550,
		6,
		300
	},
	[28550007] = {
		28550007,
		0,
		Lang.get(70358),
		28550,
		7,
		300
	},
	[28550008] = {
		28550008,
		0,
		Lang.get(70359),
		28550,
		8,
		300
	},
	[28550009] = {
		28550009,
		0,
		Lang.get(70360),
		28550,
		9,
		110,
		{
			RTResTalkAction[36]
		}
	},
	[28550010] = {
		28550010,
		0,
		Lang.get(70361),
		28550,
		10,
		300,
		{
			RTResTalkAction[37]
		}
	},
	[28550011] = {
		28550011,
		0,
		Lang.get(70362),
		28550,
		11,
		300
	},
	[28550012] = {
		28550012,
		0,
		Lang.get(70363),
		28550,
		12,
		110,
		{
			RTResTalkAction[36]
		}
	},
	[28551001] = {
		28551001,
		15,
		Lang.get(45683),
		28551,
		1,
		698,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28551,
		nil,
		1,
		nil,
		1,
		nil,
		28551
	},
	[28551002] = {
		28551002,
		15,
		Lang.get(43016),
		28551,
		2,
		698,
		{
			RTResTalkAction[40]
		},
		nil,
		nil,
		3
	},
	[28551003] = {
		28551003,
		15,
		Lang.get(45684),
		28551,
		3,
		698,
		{
			RTResTalkAction[40]
		}
	},
	[28551004] = {
		28551004,
		15,
		Lang.get(46172),
		28551,
		4,
		698,
		{
			RTResTalkAction[40]
		}
	},
	[28551005] = {
		28551005,
		15,
		Lang.get(45686),
		28551,
		5,
		698,
		{
			RTResTalkAction[40]
		}
	},
	[28551006] = {
		28551006,
		15,
		Lang.get(45687),
		28551,
		6,
		698,
		{
			RTResTalkAction[40]
		}
	},
	[28551007] = {
		28551007,
		15,
		Lang.get(45688),
		28551,
		7,
		698,
		{
			RTResTalkAction[40]
		}
	},
	[28551008] = {
		28551008,
		15,
		Lang.get(45689),
		28551,
		8,
		698,
		{
			RTResTalkAction[40]
		}
	},
	[28551009] = {
		28551009,
		15,
		Lang.get(45690),
		28551,
		9,
		698,
		{
			RTResTalkAction[40]
		}
	},
	[28551010] = {
		28551010,
		15,
		Lang.get(45691),
		28551,
		10,
		698,
		{
			RTResTalkAction[40]
		}
	},
	[28552001] = {
		28552001,
		15,
		Lang.get(42994),
		28552,
		1,
		698,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28552,
		nil,
		1,
		nil,
		1,
		nil,
		28552
	},
	[28552002] = {
		28552002,
		15,
		Lang.get(45670),
		28552,
		2,
		698,
		{
			RTResTalkAction[40]
		},
		nil,
		nil,
		3
	},
	[28552003] = {
		28552003,
		15,
		Lang.get(45671),
		28552,
		3,
		698,
		{
			RTResTalkAction[40]
		}
	},
	[28552004] = {
		28552004,
		15,
		Lang.get(45672),
		28552,
		4,
		698,
		{
			RTResTalkAction[40]
		}
	},
	[28552005] = {
		28552005,
		15,
		Lang.get(45966),
		28552,
		5,
		698,
		{
			RTResTalkAction[40]
		}
	},
	[28552006] = {
		28552006,
		15,
		Lang.get(45967),
		28552,
		6,
		698,
		{
			RTResTalkAction[40]
		}
	},
	[28552007] = {
		28552007,
		15,
		Lang.get(45674),
		28552,
		7,
		698,
		{
			RTResTalkAction[40]
		}
	},
	[28552008] = {
		28552008,
		15,
		Lang.get(45675),
		28552,
		8,
		698,
		{
			RTResTalkAction[40]
		}
	},
	[28552009] = {
		28552009,
		15,
		Lang.get(45677),
		28552,
		9,
		698,
		{
			RTResTalkAction[40]
		}
	},
	[28553001] = {
		28553001,
		0,
		Lang.get(43160),
		28553,
		1,
		224,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28553,
		nil,
		1,
		nil,
		1,
		nil,
		28553
	},
	[28553002] = {
		28553002,
		0,
		Lang.get(70364),
		28553,
		2,
		224,
		{
			RTResTalkAction[41]
		},
		nil,
		nil,
		3
	},
	[28553003] = {
		28553003,
		0,
		Lang.get(70365),
		28553,
		3,
		224,
		{
			RTResTalkAction[41]
		}
	},
	[28553004] = {
		28553004,
		0,
		Lang.get(70366),
		28553,
		4,
		300,
		{
			RTResTalkAction[42]
		}
	},
	[28553005] = {
		28553005,
		0,
		Lang.get(43164),
		28553,
		5,
		224,
		{
			RTResTalkAction[41]
		}
	},
	[28553006] = {
		28553006,
		4,
		nil,
		28553,
		6,
		224,
		{
			RTResTalkAction[42]
		},
		[29] = {
			{
				id = 28553007,
				branch_content = Lang.get(70752)
			},
			{
				id = 28553007,
				branch_content = Lang.get(70753)
			}
		}
	},
	[28553007] = {
		28553007,
		0,
		Lang.get(70367),
		28553,
		7,
		224,
		{
			RTResTalkAction[41]
		}
	},
	[28553008] = {
		28553008,
		0,
		Lang.get(70368),
		28553,
		8,
		224,
		{
			RTResTalkAction[41]
		}
	},
	[28553009] = {
		28553009,
		0,
		Lang.get(70369),
		28553,
		9,
		300,
		{
			RTResTalkAction[42]
		}
	},
	[28553010] = {
		28553010,
		0,
		Lang.get(70370),
		28553,
		10,
		224,
		{
			RTResTalkAction[41]
		}
	},
	[28553011] = {
		28553011,
		0,
		Lang.get(70371),
		28553,
		11,
		224,
		{
			RTResTalkAction[41]
		}
	},
	[28553012] = {
		28553012,
		0,
		Lang.get(70372),
		28553,
		12,
		224,
		{
			RTResTalkAction[41]
		}
	},
	[28554001] = {
		28554001,
		0,
		Lang.get(70373),
		28554,
		1,
		226,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28554,
		nil,
		1,
		nil,
		1,
		nil,
		28554
	},
	[28554002] = {
		28554002,
		4,
		nil,
		28554,
		2,
		226,
		{
			RTResTalkAction[43]
		},
		nil,
		nil,
		3,
		[29] = {
			{
				id = 28554003,
				branch_content = Lang.get(70374)
			},
			{
				id = 28554003,
				branch_content = Lang.get(70375)
			}
		}
	},
	[28554003] = {
		28554003,
		0,
		Lang.get(70376),
		28554,
		3,
		226,
		{
			RTResTalkAction[43]
		}
	},
	[28554004] = {
		28554004,
		3,
		Lang.get(70377),
		28554,
		4,
		605,
		{
			RTResTalkAction[44]
		},
		[22] = 1
	},
	[28554005] = {
		28554005,
		0,
		Lang.get(70378),
		28554,
		5,
		226,
		{
			RTResTalkAction[43]
		}
	},
	[28554006] = {
		28554006,
		0,
		Lang.get(70379),
		28554,
		6,
		300,
		{
			RTResTalkAction[44]
		}
	},
	[28554007] = {
		28554007,
		0,
		Lang.get(70380),
		28554,
		7,
		226,
		{
			RTResTalkAction[43]
		}
	},
	[28554008] = {
		28554008,
		0,
		"！",
		28554,
		8,
		300,
		{
			RTResTalkAction[44]
		}
	},
	[28554009] = {
		28554009,
		0,
		Lang.get(70381),
		28554,
		9,
		226,
		{
			RTResTalkAction[43]
		}
	},
	[28554010] = {
		28554010,
		4,
		nil,
		28554,
		10,
		226,
		{
			RTResTalkAction[43]
		},
		[29] = {
			{
				id = 28554011,
				branch_content = Lang.get(64757)
			},
			{
				id = 28554012,
				branch_content = Lang.get(70382)
			}
		}
	},
	[28554011] = {
		28554011,
		0,
		Lang.get(70383),
		28554,
		11,
		226,
		{
			RTResTalkAction[43]
		}
	},
	[28554012] = {
		28554012,
		0,
		Lang.get(70384),
		28554,
		12,
		226,
		{
			RTResTalkAction[43]
		}
	},
	[28554013] = {
		28554013,
		0,
		Lang.get(70385),
		28554,
		13,
		226,
		{
			RTResTalkAction[43]
		}
	},
	[28554014] = {
		28554014,
		0,
		Lang.get(70386),
		28554,
		14,
		226,
		{
			RTResTalkAction[43]
		}
	},
	[28555001] = {
		28555001,
		0,
		Lang.get(70387),
		28555,
		1,
		226,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28555,
		nil,
		1,
		nil,
		1,
		nil,
		28555
	},
	[28555002] = {
		28555002,
		0,
		Lang.get(70388),
		28555,
		2,
		300,
		nil,
		nil,
		nil,
		3
	},
	[28555003] = {
		28555003,
		0,
		Lang.get(70389),
		28555,
		3,
		226,
		{
			RTResTalkAction[43]
		}
	},
	[28555004] = {
		28555004,
		0,
		Lang.get(70390),
		28555,
		4,
		226,
		{
			RTResTalkAction[43]
		}
	},
	[28555005] = {
		28555005,
		0,
		Lang.get(70391),
		28555,
		5,
		226,
		{
			RTResTalkAction[43]
		}
	},
	[28555006] = {
		28555006,
		0,
		Lang.get(70392),
		28555,
		6,
		300,
		{
			RTResTalkAction[44]
		}
	},
	[28555007] = {
		28555007,
		0,
		Lang.get(70393),
		28555,
		7,
		226,
		{
			RTResTalkAction[43]
		}
	},
	[28555008] = {
		28555008,
		4,
		nil,
		28555,
		8,
		226,
		{
			RTResTalkAction[44]
		},
		[29] = {
			{
				id = 28555009,
				branch_content = Lang.get(70394)
			},
			{
				id = 28555009,
				branch_content = Lang.get(70395)
			}
		}
	},
	[28555009] = {
		28555009,
		0,
		Lang.get(70396),
		28555,
		9,
		226,
		{
			RTResTalkAction[43]
		}
	},
	[28555010] = {
		28555010,
		0,
		Lang.get(70397),
		28555,
		10,
		605,
		{
			RTResTalkAction[44]
		}
	},
	[28555011] = {
		28555011,
		0,
		Lang.get(70398),
		28555,
		11,
		226,
		{
			RTResTalkAction[43]
		}
	},
	[28555012] = {
		28555012,
		0,
		Lang.get(70399),
		28555,
		12,
		226,
		{
			RTResTalkAction[43]
		}
	},
	[28555013] = {
		28555013,
		0,
		Lang.get(70400),
		28555,
		13,
		300,
		{
			RTResTalkAction[44]
		}
	},
	[28555014] = {
		28555014,
		0,
		Lang.get(70401),
		28555,
		14,
		226,
		{
			RTResTalkAction[43]
		}
	},
	[28555015] = {
		28555015,
		0,
		Lang.get(70402),
		28555,
		15,
		226,
		{
			RTResTalkAction[43]
		}
	},
	[28556001] = {
		28556001,
		0,
		Lang.get(70403),
		28556,
		1,
		226,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28556,
		nil,
		1,
		nil,
		1,
		nil,
		28556
	},
	[28556002] = {
		28556002,
		0,
		Lang.get(70404),
		28556,
		2,
		226,
		{
			RTResTalkAction[43]
		},
		nil,
		nil,
		3
	},
	[28556003] = {
		28556003,
		4,
		nil,
		28556,
		3,
		226,
		{
			RTResTalkAction[44]
		},
		[29] = {
			{
				id = 28556004,
				branch_content = Lang.get(64732)
			},
			{
				id = 28556004,
				branch_content = Lang.get(70405)
			}
		}
	},
	[28556004] = {
		28556004,
		0,
		Lang.get(70406),
		28556,
		4,
		226,
		{
			RTResTalkAction[43]
		}
	},
	[28556005] = {
		28556005,
		0,
		Lang.get(70407),
		28556,
		5,
		226,
		{
			RTResTalkAction[43]
		}
	},
	[28556006] = {
		28556006,
		4,
		nil,
		28556,
		6,
		226,
		{
			RTResTalkAction[44]
		},
		[29] = {
			{
				id = 28556007,
				branch_content = Lang.get(70408)
			},
			{
				id = 28556007,
				branch_content = "……"
			}
		}
	},
	[28556007] = {
		28556007,
		0,
		Lang.get(70409),
		28556,
		7,
		226,
		{
			RTResTalkAction[43]
		}
	},
	[28556008] = {
		28556008,
		0,
		Lang.get(70410),
		28556,
		8,
		226,
		{
			RTResTalkAction[43]
		}
	},
	[28556009] = {
		28556009,
		0,
		Lang.get(70411),
		28556,
		9,
		226,
		{
			RTResTalkAction[43]
		}
	},
	[28556010] = {
		28556010,
		0,
		Lang.get(70412),
		28556,
		10,
		226,
		{
			RTResTalkAction[43]
		}
	},
	[28556011] = {
		28556011,
		0,
		Lang.get(70413),
		28556,
		11,
		300,
		{
			RTResTalkAction[44]
		}
	},
	[28556012] = {
		28556012,
		0,
		Lang.get(70414),
		28556,
		12,
		226,
		{
			RTResTalkAction[43]
		}
	},
	[28556013] = {
		28556013,
		0,
		Lang.get(70415),
		28556,
		13,
		226,
		{
			RTResTalkAction[43]
		}
	},
	[28557001] = {
		28557001,
		0,
		Lang.get(70416),
		28557,
		1,
		257,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28557,
		nil,
		1,
		nil,
		1,
		nil,
		28557
	},
	[28557002] = {
		28557002,
		2,
		Lang.get(70417),
		28557,
		2,
		300,
		nil,
		nil,
		nil,
		3
	},
	[28557003] = {
		28557003,
		0,
		Lang.get(70418),
		28557,
		3,
		300
	},
	[28557004] = {
		28557004,
		0,
		Lang.get(70419),
		28557,
		4,
		257,
		{
			RTResTalkAction[45]
		}
	},
	[28557005] = {
		28557005,
		0,
		Lang.get(70420),
		28557,
		5,
		300,
		{
			RTResTalkAction[46]
		}
	},
	[28557006] = {
		28557006,
		0,
		Lang.get(70421),
		28557,
		6,
		257,
		{
			RTResTalkAction[45]
		}
	},
	[28557007] = {
		28557007,
		0,
		Lang.get(70422),
		28557,
		7,
		257,
		{
			RTResTalkAction[45]
		}
	},
	[28557008] = {
		28557008,
		0,
		Lang.get(70423),
		28557,
		8,
		300,
		{
			RTResTalkAction[46]
		}
	},
	[28557009] = {
		28557009,
		0,
		Lang.get(70424),
		28557,
		9,
		257,
		{
			RTResTalkAction[45]
		}
	},
	[28557010] = {
		28557010,
		0,
		Lang.get(70425),
		28557,
		10,
		257,
		{
			RTResTalkAction[45]
		}
	},
	[28557011] = {
		28557011,
		0,
		Lang.get(70426),
		28557,
		11,
		300,
		{
			RTResTalkAction[46]
		}
	},
	[28557012] = {
		28557012,
		0,
		Lang.get(70427),
		28557,
		12,
		257,
		{
			RTResTalkAction[45]
		}
	},
	[28557013] = {
		28557013,
		0,
		Lang.get(70428),
		28557,
		13,
		300,
		{
			RTResTalkAction[46]
		}
	},
	[28557014] = {
		28557014,
		0,
		Lang.get(70429),
		28557,
		14,
		257,
		{
			RTResTalkAction[45]
		}
	},
	[28557015] = {
		28557015,
		0,
		Lang.get(70430),
		28557,
		15,
		257,
		{
			RTResTalkAction[45]
		}
	},
	[28558001] = {
		28558001,
		0,
		Lang.get(70431),
		28558,
		1,
		257,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28558,
		nil,
		1,
		nil,
		1,
		nil,
		28558
	},
	[28558002] = {
		28558002,
		0,
		Lang.get(70432),
		28558,
		2,
		300,
		nil,
		nil,
		nil,
		3
	},
	[28558003] = {
		28558003,
		0,
		Lang.get(70433),
		28558,
		3,
		257,
		{
			RTResTalkAction[45]
		}
	},
	[28558004] = {
		28558004,
		0,
		"？",
		28558,
		4,
		300,
		{
			RTResTalkAction[46]
		}
	},
	[28558005] = {
		28558005,
		0,
		Lang.get(70434),
		28558,
		5,
		257,
		{
			RTResTalkAction[45]
		}
	},
	[28558006] = {
		28558006,
		0,
		Lang.get(70435),
		28558,
		6,
		605,
		{
			RTResTalkAction[46]
		}
	},
	[28558007] = {
		28558007,
		0,
		Lang.get(70436),
		28558,
		7,
		257,
		{
			RTResTalkAction[45]
		}
	},
	[28558008] = {
		28558008,
		4,
		nil,
		28558,
		8,
		257,
		{
			RTResTalkAction[45]
		},
		[29] = {
			{
				id = 28558009,
				branch_content = Lang.get(70437)
			},
			{
				id = 28558009,
				branch_content = Lang.get(70438)
			}
		}
	},
	[28558009] = {
		28558009,
		0,
		Lang.get(70439),
		28558,
		9,
		257,
		{
			RTResTalkAction[45]
		}
	},
	[28558010] = {
		28558010,
		0,
		Lang.get(70440),
		28558,
		10,
		300,
		{
			RTResTalkAction[46]
		}
	},
	[28558011] = {
		28558011,
		0,
		Lang.get(70441),
		28558,
		11,
		257,
		{
			RTResTalkAction[45]
		}
	},
	[28558012] = {
		28558012,
		0,
		Lang.get(70442),
		28558,
		12,
		257,
		{
			RTResTalkAction[45]
		}
	},
	[28558013] = {
		28558013,
		0,
		Lang.get(70443),
		28558,
		13,
		300,
		{
			RTResTalkAction[46]
		}
	},
	[28558014] = {
		28558014,
		0,
		Lang.get(70444),
		28558,
		14,
		257,
		{
			RTResTalkAction[45]
		}
	},
	[28558015] = {
		28558015,
		0,
		Lang.get(70445),
		28558,
		15,
		257,
		{
			RTResTalkAction[45]
		}
	},
	[28559001] = {
		28559001,
		0,
		Lang.get(70446),
		28559,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		28559,
		nil,
		1,
		nil,
		1,
		nil,
		28559
	},
	[28559002] = {
		28559002,
		0,
		Lang.get(70447),
		28559,
		2,
		300,
		nil,
		nil,
		nil,
		3
	},
	[28559003] = {
		28559003,
		0,
		Lang.get(70448),
		28559,
		3,
		257,
		{
			RTResTalkAction[45]
		}
	},
	[28559004] = {
		28559004,
		0,
		Lang.get(70449),
		28559,
		4,
		300,
		{
			RTResTalkAction[46]
		}
	},
	[28559005] = {
		28559005,
		0,
		Lang.get(70450),
		28559,
		5,
		257,
		{
			RTResTalkAction[45]
		}
	},
	[28559006] = {
		28559006,
		0,
		Lang.get(70451),
		28559,
		6,
		605,
		{
			RTResTalkAction[46]
		}
	},
	[28559007] = {
		28559007,
		0,
		"！",
		28559,
		7,
		300
	},
	[28559008] = {
		28559008,
		0,
		Lang.get(70452),
		28559,
		8,
		257,
		{
			RTResTalkAction[45]
		}
	},
	[28559009] = {
		28559009,
		0,
		Lang.get(70400),
		28559,
		9,
		300,
		{
			RTResTalkAction[46]
		}
	},
	[28559010] = {
		28559010,
		0,
		Lang.get(70453),
		28559,
		10,
		257,
		{
			RTResTalkAction[45]
		}
	},
	[28559011] = {
		28559011,
		0,
		Lang.get(70454),
		28559,
		11,
		300,
		{
			RTResTalkAction[46]
		}
	},
	[28559012] = {
		28559012,
		0,
		Lang.get(70455),
		28559,
		12,
		257,
		{
			RTResTalkAction[45]
		}
	},
	[28559013] = {
		28559013,
		0,
		Lang.get(70456),
		28559,
		13,
		257,
		{
			RTResTalkAction[45]
		}
	},
	[28559014] = {
		28559014,
		0,
		Lang.get(70457),
		28559,
		14,
		605,
		{
			RTResTalkAction[46]
		}
	},
	[28559015] = {
		28559015,
		0,
		Lang.get(70458),
		28559,
		15,
		257,
		{
			RTResTalkAction[45]
		}
	},
	[28559016] = {
		28559016,
		0,
		Lang.get(70459),
		28559,
		16,
		257,
		{
			RTResTalkAction[45]
		}
	},
	[28560001] = {
		28560001,
		0,
		Lang.get(71567),
		28560,
		1,
		290,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28560,
		nil,
		1,
		nil,
		1,
		nil,
		28560
	},
	[28560002] = {
		28560002,
		4,
		nil,
		28560,
		2,
		290,
		{
			RTResTalkAction[47]
		},
		nil,
		nil,
		3,
		[29] = {
			{
				id = 28560003,
				branch_content = Lang.get(23797)
			}
		}
	},
	[28560003] = {
		28560003,
		0,
		Lang.get(71568),
		28560,
		3,
		290,
		{
			RTResTalkAction[47]
		}
	},
	[28560004] = {
		28560004,
		4,
		nil,
		28560,
		4,
		290,
		{
			RTResTalkAction[47]
		},
		[29] = {
			{
				id = 28560005,
				branch_content = Lang.get(71569)
			},
			{
				id = 28560005,
				branch_content = Lang.get(71570)
			}
		}
	},
	[28560005] = {
		28560005,
		0,
		Lang.get(71571),
		28560,
		5,
		290,
		{
			RTResTalkAction[47]
		}
	},
	[28560006] = {
		28560006,
		4,
		nil,
		28560,
		6,
		290,
		{
			RTResTalkAction[47]
		},
		[29] = {
			{
				id = 28560007,
				branch_content = Lang.get(71572)
			}
		}
	},
	[28560007] = {
		28560007,
		0,
		Lang.get(71573),
		28560,
		7,
		290,
		{
			RTResTalkAction[47]
		}
	},
	[28561001] = {
		28561001,
		0,
		Lang.get(71574),
		28561,
		1,
		290,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28561,
		nil,
		1,
		nil,
		1,
		nil,
		28561
	},
	[28561002] = {
		28561002,
		0,
		Lang.get(71575),
		28561,
		2,
		300,
		nil,
		nil,
		nil,
		3
	},
	[28561003] = {
		28561003,
		0,
		Lang.get(71576),
		28561,
		3,
		290,
		{
			RTResTalkAction[47]
		}
	},
	[28561004] = {
		28561004,
		4,
		nil,
		28561,
		4,
		290,
		{
			RTResTalkAction[47]
		},
		[29] = {
			{
				id = 28561005,
				branch_content = Lang.get(71577)
			}
		}
	},
	[28561005] = {
		28561005,
		0,
		Lang.get(71578),
		28561,
		5,
		290,
		{
			RTResTalkAction[47]
		}
	},
	[28561006] = {
		28561006,
		4,
		nil,
		28561,
		6,
		290,
		{
			RTResTalkAction[47]
		},
		[29] = {
			{
				id = 28561007,
				branch_content = Lang.get(71579)
			}
		}
	},
	[28561007] = {
		28561007,
		0,
		Lang.get(71580),
		28561,
		7,
		290,
		{
			RTResTalkAction[47]
		}
	},
	[28561008] = {
		28561008,
		0,
		Lang.get(71581),
		28561,
		8,
		300,
		{
			RTResTalkAction[48]
		}
	},
	[28561009] = {
		28561009,
		0,
		Lang.get(71582),
		28561,
		9,
		300
	},
	[28561010] = {
		28561010,
		0,
		Lang.get(71583),
		28561,
		10,
		300
	},
	[28561011] = {
		28561011,
		0,
		Lang.get(32735),
		28561,
		11,
		290,
		{
			RTResTalkAction[47]
		}
	},
	[28562001] = {
		28562001,
		0,
		Lang.get(71584),
		28562,
		1,
		300,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28562,
		nil,
		1,
		nil,
		1,
		nil,
		28562
	},
	[28562002] = {
		28562002,
		0,
		Lang.get(71585),
		28562,
		2,
		290,
		{
			RTResTalkAction[47]
		},
		nil,
		nil,
		3
	},
	[28562003] = {
		28562003,
		0,
		Lang.get(71586),
		28562,
		3,
		290,
		{
			RTResTalkAction[47]
		}
	},
	[28562004] = {
		28562004,
		0,
		Lang.get(71587),
		28562,
		4,
		290,
		{
			RTResTalkAction[47]
		}
	},
	[28562005] = {
		28562005,
		0,
		Lang.get(71588),
		28562,
		5,
		300,
		{
			RTResTalkAction[48]
		}
	},
	[28562006] = {
		28562006,
		0,
		Lang.get(71589),
		28562,
		6,
		290,
		{
			RTResTalkAction[47]
		}
	},
	[28562007] = {
		28562007,
		0,
		Lang.get(75734),
		28562,
		7,
		300,
		{
			RTResTalkAction[48]
		}
	},
	[28563001] = {
		28563001,
		0,
		Lang.get(96361),
		28563,
		1,
		1196,
		nil,
		1,
		nil,
		nil,
		nil,
		199,
		28563,
		nil,
		1,
		nil,
		1,
		nil,
		28563
	},
	[28563002] = {
		28563002,
		4,
		nil,
		28563,
		2,
		1196,
		{
			RTResTalkAction[49]
		},
		nil,
		nil,
		3,
		[29] = {
			{
				id = 28563003,
				branch_content = Lang.get(96362)
			},
			{
				id = 28563003,
				branch_content = Lang.get(96363)
			}
		}
	},
	[28563003] = {
		28563003,
		0,
		Lang.get(96364),
		28563,
		3,
		1196,
		{
			RTResTalkAction[49]
		}
	},
	[28563004] = {
		28563004,
		0,
		Lang.get(96365),
		28563,
		4,
		1196,
		{
			RTResTalkAction[49]
		}
	},
	[28563005] = {
		28563005,
		0,
		Lang.get(38114),
		28563,
		5,
		300,
		{
			RTResTalkAction[50]
		}
	},
	[28563006] = {
		28563006,
		0,
		Lang.get(96366),
		28563,
		6,
		1196,
		{
			RTResTalkAction[49]
		}
	},
	[28563007] = {
		28563007,
		0,
		Lang.get(96367),
		28563,
		7,
		300,
		{
			RTResTalkAction[50]
		}
	},
	[28563008] = {
		28563008,
		0,
		Lang.get(96368),
		28563,
		8,
		1196,
		{
			RTResTalkAction[49]
		}
	},
	[28563009] = {
		28563009,
		3,
		Lang.get(96369),
		28563,
		9,
		605,
		{
			RTResTalkAction[50]
		},
		[22] = 1
	},
	[28563010] = {
		28563010,
		0,
		Lang.get(96370),
		28563,
		10,
		300
	},
	[28563011] = {
		28563011,
		0,
		Lang.get(96371),
		28563,
		11,
		1196,
		{
			RTResTalkAction[49]
		}
	},
	[28564001] = {
		28564001,
		0,
		Lang.get(96372),
		28564,
		1,
		1196,
		nil,
		1,
		nil,
		nil,
		nil,
		199,
		28564,
		nil,
		1,
		nil,
		1,
		nil,
		28564
	},
	[28564002] = {
		28564002,
		0,
		Lang.get(96373),
		28564,
		2,
		300,
		nil,
		nil,
		nil,
		3
	},
	[28564003] = {
		28564003,
		0,
		Lang.get(96374),
		28564,
		3,
		1196,
		{
			RTResTalkAction[49]
		}
	},
	[28564004] = {
		28564004,
		0,
		Lang.get(96375),
		28564,
		4,
		300,
		{
			RTResTalkAction[50]
		}
	},
	[28564005] = {
		28564005,
		0,
		Lang.get(96376),
		28564,
		5,
		1196,
		{
			RTResTalkAction[49]
		}
	},
	[28564006] = {
		28564006,
		0,
		Lang.get(96377),
		28564,
		6,
		300,
		{
			RTResTalkAction[50]
		}
	},
	[28564007] = {
		28564007,
		2,
		Lang.get(96378),
		28564,
		7,
		1196,
		{
			RTResTalkAction[49]
		}
	},
	[28564008] = {
		28564008,
		0,
		Lang.get(96379),
		28564,
		8,
		1196,
		{
			RTResTalkAction[49]
		}
	},
	[28564009] = {
		28564009,
		0,
		Lang.get(96380),
		28564,
		9,
		1196,
		{
			RTResTalkAction[49]
		}
	},
	[28564010] = {
		28564010,
		0,
		Lang.get(96381),
		28564,
		10,
		1196,
		{
			RTResTalkAction[49]
		}
	},
	[28564011] = {
		28564011,
		0,
		Lang.get(96382),
		28564,
		11,
		300,
		{
			RTResTalkAction[50]
		}
	},
	[28564012] = {
		28564012,
		0,
		Lang.get(96383),
		28564,
		12,
		1196,
		{
			RTResTalkAction[49]
		}
	},
	[28565001] = {
		28565001,
		0,
		Lang.get(96384),
		28565,
		1,
		1196,
		nil,
		1,
		nil,
		nil,
		nil,
		199,
		28565,
		nil,
		1,
		nil,
		1,
		nil,
		28565
	},
	[28565002] = {
		28565002,
		0,
		Lang.get(96385),
		28565,
		2,
		1196,
		{
			RTResTalkAction[49]
		},
		nil,
		nil,
		3
	},
	[28565003] = {
		28565003,
		0,
		Lang.get(96386),
		28565,
		3,
		300,
		{
			RTResTalkAction[50]
		}
	},
	[28565004] = {
		28565004,
		0,
		Lang.get(96387),
		28565,
		4,
		1196,
		{
			RTResTalkAction[49]
		}
	},
	[28565005] = {
		28565005,
		0,
		Lang.get(96388),
		28565,
		5,
		1196,
		{
			RTResTalkAction[49]
		}
	},
	[28565006] = {
		28565006,
		0,
		Lang.get(96389),
		28565,
		6,
		1196,
		{
			RTResTalkAction[49]
		}
	},
	[28565007] = {
		28565007,
		0,
		Lang.get(96390),
		28565,
		7,
		300,
		{
			RTResTalkAction[50]
		}
	},
	[28565008] = {
		28565008,
		0,
		Lang.get(96391),
		28565,
		8,
		1196,
		{
			RTResTalkAction[49]
		}
	},
	[28565009] = {
		28565009,
		0,
		Lang.get(96392),
		28565,
		9,
		300,
		{
			RTResTalkAction[50]
		}
	},
	[28565010] = {
		28565010,
		0,
		Lang.get(93802),
		28565,
		10,
		1196,
		{
			RTResTalkAction[49]
		}
	},
	[28565011] = {
		28565011,
		0,
		Lang.get(95467),
		28565,
		11,
		1196,
		{
			RTResTalkAction[49]
		}
	},
	[28565012] = {
		28565012,
		0,
		Lang.get(96393),
		28565,
		12,
		1196,
		{
			RTResTalkAction[49]
		}
	},
	[28565013] = {
		28565013,
		0,
		Lang.get(96394),
		28565,
		13,
		1196,
		{
			RTResTalkAction[49]
		}
	},
	[28566001] = {
		28566001,
		0,
		Lang.get(96395),
		28566,
		1,
		1197,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28566,
		nil,
		1,
		nil,
		1,
		nil,
		28566
	},
	[28566002] = {
		28566002,
		4,
		nil,
		28566,
		2,
		1197,
		{
			RTResTalkAction[51]
		},
		nil,
		nil,
		3,
		[29] = {
			{
				id = 28566003,
				branch_content = Lang.get(96396)
			},
			{
				id = 28566003,
				branch_content = Lang.get(96397)
			}
		}
	},
	[28566003] = {
		28566003,
		0,
		Lang.get(96398),
		28566,
		3,
		1197,
		{
			RTResTalkAction[51]
		}
	},
	[28566004] = {
		28566004,
		0,
		Lang.get(96399),
		28566,
		4,
		300,
		{
			RTResTalkAction[52]
		}
	},
	[28566005] = {
		28566005,
		0,
		Lang.get(96400),
		28566,
		5,
		1197,
		{
			RTResTalkAction[51]
		}
	},
	[28566006] = {
		28566006,
		0,
		Lang.get(96401),
		28566,
		6,
		300,
		{
			RTResTalkAction[52]
		}
	},
	[28566007] = {
		28566007,
		0,
		Lang.get(96402),
		28566,
		7,
		1197,
		{
			RTResTalkAction[51]
		}
	},
	[28566008] = {
		28566008,
		0,
		Lang.get(96403),
		28566,
		8,
		1197,
		{
			RTResTalkAction[51]
		}
	},
	[28566009] = {
		28566009,
		0,
		Lang.get(96404),
		28566,
		9,
		300,
		{
			RTResTalkAction[52]
		}
	},
	[28566010] = {
		28566010,
		0,
		Lang.get(96405),
		28566,
		10,
		1197,
		{
			RTResTalkAction[51]
		}
	},
	[28566011] = {
		28566011,
		0,
		Lang.get(96406),
		28566,
		11,
		1197,
		{
			RTResTalkAction[51]
		}
	},
	[28566012] = {
		28566012,
		0,
		Lang.get(96407),
		28566,
		12,
		1197,
		{
			RTResTalkAction[51]
		}
	},
	[28566013] = {
		28566013,
		0,
		Lang.get(96408),
		28566,
		13,
		300,
		{
			RTResTalkAction[52]
		}
	},
	[28566014] = {
		28566014,
		0,
		Lang.get(96409),
		28566,
		14,
		1197,
		{
			RTResTalkAction[51]
		}
	},
	[28566015] = {
		28566015,
		0,
		Lang.get(96410),
		28566,
		15,
		300,
		{
			RTResTalkAction[52]
		}
	},
	[28567001] = {
		28567001,
		0,
		Lang.get(96411),
		28567,
		1,
		1197,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28567,
		nil,
		1,
		nil,
		1,
		nil,
		28567
	},
	[28567002] = {
		28567002,
		0,
		Lang.get(96412),
		28567,
		2,
		1197,
		{
			RTResTalkAction[51]
		},
		nil,
		nil,
		3
	},
	[28567003] = {
		28567003,
		0,
		Lang.get(96413),
		28567,
		3,
		300,
		{
			RTResTalkAction[52]
		}
	},
	[28567004] = {
		28567004,
		0,
		Lang.get(96414),
		28567,
		4,
		1197,
		{
			RTResTalkAction[51]
		}
	},
	[28567005] = {
		28567005,
		0,
		Lang.get(96415),
		28567,
		5,
		1197,
		{
			RTResTalkAction[51]
		}
	},
	[28567006] = {
		28567006,
		4,
		nil,
		28567,
		6,
		1197,
		{
			RTResTalkAction[52]
		},
		[29] = {
			{
				id = 28567007,
				branch_content = Lang.get(96416)
			},
			{
				id = 28567007,
				branch_content = Lang.get(96417)
			}
		}
	},
	[28567007] = {
		28567007,
		0,
		Lang.get(96418),
		28567,
		7,
		1197,
		{
			RTResTalkAction[51]
		}
	},
	[28567008] = {
		28567008,
		0,
		Lang.get(96419),
		28567,
		8,
		1197,
		{
			RTResTalkAction[51]
		}
	},
	[28567009] = {
		28567009,
		0,
		Lang.get(96420),
		28567,
		9,
		1197,
		{
			RTResTalkAction[51]
		}
	},
	[28567010] = {
		28567010,
		0,
		Lang.get(96421),
		28567,
		10,
		300,
		{
			RTResTalkAction[52]
		}
	},
	[28567011] = {
		28567011,
		0,
		Lang.get(96422),
		28567,
		11,
		1197,
		{
			RTResTalkAction[51]
		}
	},
	[28567012] = {
		28567012,
		0,
		Lang.get(96423),
		28567,
		12,
		1197,
		{
			RTResTalkAction[51]
		}
	},
	[28567013] = {
		28567013,
		0,
		Lang.get(96424),
		28567,
		13,
		300,
		{
			RTResTalkAction[52]
		}
	},
	[28568001] = {
		28568001,
		0,
		Lang.get(96425),
		28568,
		1,
		1197,
		nil,
		1,
		nil,
		nil,
		nil,
		199,
		28568,
		nil,
		1,
		nil,
		1,
		nil,
		28568
	},
	[28568002] = {
		28568002,
		0,
		Lang.get(96426),
		28568,
		2,
		300,
		nil,
		nil,
		nil,
		3
	},
	[28568003] = {
		28568003,
		0,
		Lang.get(96427),
		28568,
		3,
		1197,
		{
			RTResTalkAction[51]
		}
	},
	[28568004] = {
		28568004,
		0,
		Lang.get(96428),
		28568,
		4,
		1197,
		{
			RTResTalkAction[51]
		}
	},
	[28568005] = {
		28568005,
		0,
		Lang.get(96429),
		28568,
		5,
		300,
		{
			RTResTalkAction[52]
		}
	},
	[28568006] = {
		28568006,
		0,
		Lang.get(96430),
		28568,
		6,
		1197,
		{
			RTResTalkAction[51]
		}
	},
	[28568007] = {
		28568007,
		0,
		Lang.get(96431),
		28568,
		7,
		1197,
		{
			RTResTalkAction[51]
		}
	},
	[28568008] = {
		28568008,
		0,
		Lang.get(96432),
		28568,
		8,
		300,
		{
			RTResTalkAction[52]
		}
	},
	[28568009] = {
		28568009,
		0,
		Lang.get(96433),
		28568,
		9,
		1197,
		{
			RTResTalkAction[51]
		}
	},
	[28568010] = {
		28568010,
		0,
		Lang.get(96434),
		28568,
		10,
		1197,
		{
			RTResTalkAction[51]
		}
	},
	[28568011] = {
		28568011,
		0,
		Lang.get(96435),
		28568,
		11,
		300,
		{
			RTResTalkAction[52]
		}
	},
	[28568012] = {
		28568012,
		0,
		Lang.get(96436),
		28568,
		12,
		1197,
		{
			RTResTalkAction[51]
		}
	},
	[28568013] = {
		28568013,
		0,
		Lang.get(96437),
		28568,
		13,
		1197,
		{
			RTResTalkAction[51]
		}
	},
	[28569001] = {
		28569001,
		0,
		Lang.get(103721),
		28569,
		1,
		1267,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28569,
		nil,
		1,
		nil,
		1,
		nil,
		28569
	},
	[28569002] = {
		28569002,
		4,
		nil,
		28569,
		2,
		1267,
		{
			RTResTalkAction[53]
		},
		nil,
		nil,
		3,
		[29] = {
			{
				id = 28569003,
				branch_content = Lang.get(103722)
			}
		}
	},
	[28569003] = {
		28569003,
		0,
		Lang.get(103723),
		28569,
		3,
		1267,
		{
			RTResTalkAction[53]
		}
	},
	[28569004] = {
		28569004,
		0,
		Lang.get(103724),
		28569,
		4,
		1267,
		{
			RTResTalkAction[54]
		}
	},
	[28569005] = {
		28569005,
		0,
		Lang.get(103725),
		28569,
		5,
		1267,
		{
			RTResTalkAction[53]
		}
	},
	[28569006] = {
		28569006,
		4,
		nil,
		28569,
		6,
		1267,
		{
			RTResTalkAction[53]
		},
		[29] = {
			{
				id = 28569007,
				branch_content = Lang.get(103726)
			}
		}
	},
	[28569007] = {
		28569007,
		0,
		Lang.get(103727),
		28569,
		7,
		1267,
		{
			RTResTalkAction[55]
		}
	},
	[28569008] = {
		28569008,
		0,
		Lang.get(103728),
		28569,
		8,
		1267,
		{
			RTResTalkAction[53]
		}
	},
	[28569009] = {
		28569009,
		0,
		Lang.get(103729),
		28569,
		9,
		1267,
		{
			RTResTalkAction[53]
		}
	},
	[28569010] = {
		28569010,
		0,
		Lang.get(103730),
		28569,
		10,
		300,
		{
			RTResTalkAction[56]
		}
	},
	[28569011] = {
		28569011,
		0,
		Lang.get(103731),
		28569,
		11,
		300
	},
	[28569012] = {
		28569012,
		0,
		Lang.get(103732),
		28569,
		12,
		1267,
		{
			RTResTalkAction[57]
		}
	},
	[28569013] = {
		28569013,
		0,
		Lang.get(103733),
		28569,
		13,
		1267,
		{
			RTResTalkAction[53]
		}
	},
	[28570001] = {
		28570001,
		0,
		Lang.get(103734),
		28570,
		1,
		1267,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28570,
		nil,
		1,
		nil,
		1,
		nil,
		28570
	},
	[28570002] = {
		28570002,
		0,
		Lang.get(103735),
		28570,
		2,
		1267,
		{
			RTResTalkAction[54]
		},
		nil,
		nil,
		3
	},
	[28570003] = {
		28570003,
		4,
		nil,
		28570,
		3,
		1267,
		{
			RTResTalkAction[53]
		},
		[29] = {
			{
				id = 28570004,
				branch_content = Lang.get(103736)
			}
		}
	},
	[28570004] = {
		28570004,
		0,
		Lang.get(103737),
		28570,
		4,
		1267,
		{
			RTResTalkAction[55]
		}
	},
	[28570005] = {
		28570005,
		0,
		Lang.get(103738),
		28570,
		5,
		1267,
		{
			RTResTalkAction[53]
		}
	},
	[28570006] = {
		28570006,
		0,
		Lang.get(103739),
		28570,
		6,
		1267,
		{
			RTResTalkAction[53]
		}
	},
	[28570007] = {
		28570007,
		4,
		nil,
		28570,
		7,
		1267,
		{
			RTResTalkAction[53]
		},
		[29] = {
			{
				id = 28570008,
				branch_content = Lang.get(103740)
			}
		}
	},
	[28570008] = {
		28570008,
		0,
		Lang.get(103741),
		28570,
		8,
		1267,
		{
			RTResTalkAction[57]
		}
	},
	[28570009] = {
		28570009,
		4,
		nil,
		28570,
		9,
		1267,
		{
			RTResTalkAction[53]
		},
		[29] = {
			{
				id = 28570010,
				branch_content = Lang.get(103742)
			}
		}
	},
	[28570010] = {
		28570010,
		0,
		Lang.get(103743),
		28570,
		10,
		1267,
		{
			RTResTalkAction[53]
		}
	},
	[28571001] = {
		28571001,
		0,
		Lang.get(103744),
		28571,
		1,
		1267,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28571,
		nil,
		1,
		nil,
		1,
		nil,
		28571
	},
	[28571002] = {
		28571002,
		4,
		nil,
		28571,
		2,
		1267,
		{
			RTResTalkAction[53]
		},
		nil,
		nil,
		3,
		[29] = {
			{
				id = 28571003,
				branch_content = Lang.get(103745)
			}
		}
	},
	[28571003] = {
		28571003,
		0,
		Lang.get(103746),
		28571,
		3,
		1267,
		{
			RTResTalkAction[54]
		}
	},
	[28571004] = {
		28571004,
		4,
		nil,
		28571,
		4,
		1267,
		{
			RTResTalkAction[53]
		},
		[29] = {
			{
				id = 28571005,
				branch_content = Lang.get(103747)
			}
		}
	},
	[28571005] = {
		28571005,
		0,
		Lang.get(103748),
		28571,
		5,
		1267,
		{
			RTResTalkAction[55]
		}
	},
	[28571006] = {
		28571006,
		0,
		Lang.get(103749),
		28571,
		6,
		1267,
		{
			RTResTalkAction[54]
		}
	},
	[28571007] = {
		28571007,
		4,
		nil,
		28571,
		7,
		1267,
		{
			RTResTalkAction[53]
		},
		[29] = {
			{
				id = 28571008,
				branch_content = Lang.get(103750)
			}
		}
	},
	[28571008] = {
		28571008,
		0,
		Lang.get(103751),
		28571,
		8,
		1267,
		{
			RTResTalkAction[55]
		}
	},
	[28571009] = {
		28571009,
		0,
		Lang.get(103752),
		28571,
		9,
		1267,
		{
			RTResTalkAction[57]
		}
	},
	[28571010] = {
		28571010,
		0,
		Lang.get(103753),
		28571,
		10,
		300,
		{
			RTResTalkAction[56]
		}
	},
	[28571011] = {
		28571011,
		0,
		Lang.get(103754),
		28571,
		11,
		1267,
		{
			RTResTalkAction[57]
		}
	},
	[28571012] = {
		28571012,
		0,
		Lang.get(103755),
		28571,
		12,
		1267,
		{
			RTResTalkAction[57]
		}
	},
	[28572001] = {
		28572001,
		0,
		Lang.get(103756),
		28572,
		1,
		1268,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28572,
		nil,
		1,
		nil,
		1,
		nil,
		28572
	},
	[28572002] = {
		28572002,
		0,
		Lang.get(103757),
		28572,
		2,
		1268,
		{
			RTResTalkAction[58]
		},
		nil,
		nil,
		3
	},
	[28572003] = {
		28572003,
		4,
		nil,
		28572,
		3,
		1268,
		{
			RTResTalkAction[58]
		},
		[29] = {
			{
				id = 28572004,
				branch_content = Lang.get(103758)
			}
		}
	},
	[28572004] = {
		28572004,
		0,
		Lang.get(103759),
		28572,
		4,
		1268,
		{
			RTResTalkAction[59]
		}
	},
	[28572005] = {
		28572005,
		0,
		Lang.get(103760),
		28572,
		5,
		1266,
		{
			RTResTalkAction[60],
			RTResTalkAction[61]
		}
	},
	[28572006] = {
		28572006,
		4,
		nil,
		28572,
		6,
		1266,
		{
			RTResTalkAction[62]
		},
		[29] = {
			{
				id = 28572007,
				branch_content = Lang.get(103761)
			}
		}
	},
	[28572007] = {
		28572007,
		0,
		Lang.get(103762),
		28572,
		7,
		1268,
		{
			RTResTalkAction[59],
			RTResTalkAction[63]
		}
	},
	[28572008] = {
		28572008,
		0,
		Lang.get(103763),
		28572,
		8,
		1268,
		{
			RTResTalkAction[64]
		}
	},
	[28572009] = {
		28572009,
		4,
		nil,
		28572,
		9,
		1268,
		{
			RTResTalkAction[58]
		},
		[29] = {
			{
				id = 28572010,
				branch_content = Lang.get(103764)
			}
		}
	},
	[28572010] = {
		28572010,
		0,
		Lang.get(103765),
		28572,
		10,
		1268,
		{
			RTResTalkAction[58]
		}
	},
	[28572011] = {
		28572011,
		0,
		Lang.get(103766),
		28572,
		11,
		1268,
		{
			RTResTalkAction[59]
		}
	},
	[28572012] = {
		28572012,
		0,
		Lang.get(103767),
		28572,
		12,
		1266,
		{
			RTResTalkAction[65],
			RTResTalkAction[61]
		}
	},
	[28573001] = {
		28573001,
		0,
		Lang.get(103768),
		28573,
		1,
		1268,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28573,
		nil,
		1,
		nil,
		1,
		nil,
		28573
	},
	[28573002] = {
		28573002,
		0,
		Lang.get(103769),
		28573,
		2,
		1268,
		{
			RTResTalkAction[58]
		},
		nil,
		nil,
		3
	},
	[28573003] = {
		28573003,
		0,
		Lang.get(103770),
		28573,
		3,
		1268,
		{
			RTResTalkAction[58]
		}
	},
	[28573004] = {
		28573004,
		4,
		nil,
		28573,
		4,
		1268,
		{
			RTResTalkAction[58]
		},
		[29] = {
			{
				id = 28573005,
				branch_content = Lang.get(103771)
			},
			{
				id = 28573005,
				branch_content = Lang.get(103772)
			}
		}
	},
	[28573005] = {
		28573005,
		0,
		Lang.get(103773),
		28573,
		5,
		1268,
		{
			RTResTalkAction[59]
		}
	},
	[28573006] = {
		28573006,
		4,
		nil,
		28573,
		6,
		1268,
		{
			RTResTalkAction[58]
		},
		[29] = {
			{
				id = 28573007,
				branch_content = Lang.get(103774)
			}
		}
	},
	[28573007] = {
		28573007,
		0,
		Lang.get(103775),
		28573,
		7,
		1268,
		{
			RTResTalkAction[66]
		}
	},
	[28573008] = {
		28573008,
		4,
		nil,
		28573,
		8,
		1268,
		{
			RTResTalkAction[58]
		},
		[29] = {
			{
				id = 28573009,
				branch_content = Lang.get(103776)
			}
		}
	},
	[28573009] = {
		28573009,
		0,
		Lang.get(103777),
		28573,
		9,
		1268,
		{
			RTResTalkAction[59]
		}
	},
	[28573010] = {
		28573010,
		0,
		Lang.get(103778),
		28573,
		10,
		1268,
		{
			RTResTalkAction[58]
		}
	},
	[28573011] = {
		28573011,
		0,
		Lang.get(103779),
		28573,
		11,
		1268,
		{
			RTResTalkAction[66]
		}
	},
	[28573012] = {
		28573012,
		4,
		nil,
		28573,
		12,
		1268,
		{
			RTResTalkAction[58]
		},
		[29] = {
			{
				id = 28573013,
				branch_content = "？？？"
			},
			{
				id = 28573013,
				branch_content = Lang.get(103780)
			}
		}
	},
	[28573013] = {
		28573013,
		0,
		Lang.get(103781),
		28573,
		13,
		1268,
		{
			RTResTalkAction[64]
		}
	},
	[28574001] = {
		28574001,
		0,
		Lang.get(103782),
		28574,
		1,
		1268,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28574,
		nil,
		1,
		nil,
		1,
		nil,
		28574
	},
	[28574002] = {
		28574002,
		0,
		Lang.get(103783),
		28574,
		2,
		1268,
		{
			RTResTalkAction[58]
		},
		nil,
		nil,
		3
	},
	[28574003] = {
		28574003,
		4,
		nil,
		28574,
		3,
		1268,
		{
			RTResTalkAction[58]
		},
		[29] = {
			{
				id = 28574004,
				branch_content = Lang.get(103784)
			}
		}
	},
	[28574004] = {
		28574004,
		0,
		Lang.get(103785),
		28574,
		4,
		1268,
		{
			RTResTalkAction[58]
		}
	},
	[28574005] = {
		28574005,
		0,
		Lang.get(103786),
		28574,
		5,
		1268,
		{
			RTResTalkAction[58]
		}
	},
	[28574006] = {
		28574006,
		0,
		Lang.get(103787),
		28574,
		6,
		1268,
		{
			RTResTalkAction[59]
		}
	},
	[28574007] = {
		28574007,
		4,
		nil,
		28574,
		7,
		1268,
		{
			RTResTalkAction[58]
		},
		[29] = {
			{
				id = 28574008,
				branch_content = Lang.get(103788)
			}
		}
	},
	[28574008] = {
		28574008,
		0,
		Lang.get(103789),
		28574,
		8,
		1268,
		{
			RTResTalkAction[58]
		}
	},
	[28574009] = {
		28574009,
		0,
		Lang.get(103790),
		28574,
		9,
		1268,
		{
			RTResTalkAction[66]
		}
	},
	[28574010] = {
		28574010,
		0,
		Lang.get(103791),
		28574,
		10,
		1268,
		{
			RTResTalkAction[58]
		}
	},
	[28574011] = {
		28574011,
		4,
		nil,
		28574,
		11,
		1268,
		{
			RTResTalkAction[58]
		},
		[29] = {
			{
				id = 28574012,
				branch_content = Lang.get(25050)
			}
		}
	},
	[28574012] = {
		28574012,
		0,
		Lang.get(103792),
		28574,
		12,
		1268,
		{
			RTResTalkAction[58]
		}
	},
	[28574013] = {
		28574013,
		0,
		Lang.get(103793),
		28574,
		13,
		1268,
		{
			RTResTalkAction[67]
		}
	},
	[28575001] = {
		28575001,
		0,
		Lang.get(104291),
		28575,
		1,
		1269,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28575,
		nil,
		1,
		nil,
		1,
		nil,
		28575
	},
	[28575002] = {
		28575002,
		4,
		nil,
		28575,
		2,
		1269,
		{
			RTResTalkAction[68]
		},
		nil,
		nil,
		3,
		[29] = {
			{
				id = 28575003,
				branch_content = Lang.get(104292)
			},
			{
				id = 28575003,
				branch_content = Lang.get(104293)
			}
		}
	},
	[28575003] = {
		28575003,
		0,
		Lang.get(104294),
		28575,
		3,
		1269,
		{
			RTResTalkAction[68]
		}
	},
	[28575004] = {
		28575004,
		0,
		Lang.get(104295),
		28575,
		4,
		1269,
		{
			RTResTalkAction[68]
		}
	},
	[28575005] = {
		28575005,
		0,
		Lang.get(104296),
		28575,
		5,
		1269,
		{
			RTResTalkAction[68]
		}
	},
	[28575006] = {
		28575006,
		0,
		Lang.get(104297),
		28575,
		6,
		1269,
		{
			RTResTalkAction[68]
		}
	},
	[28575007] = {
		28575007,
		4,
		nil,
		28575,
		7,
		1269,
		{
			RTResTalkAction[68]
		},
		[29] = {
			{
				id = 28575008,
				branch_content = Lang.get(104298)
			},
			{
				id = 28575008,
				branch_content = Lang.get(104299)
			}
		}
	},
	[28575008] = {
		28575008,
		0,
		Lang.get(104300),
		28575,
		8,
		1269,
		{
			RTResTalkAction[68]
		}
	},
	[28575009] = {
		28575009,
		4,
		nil,
		28575,
		9,
		1269,
		{
			RTResTalkAction[68]
		},
		[29] = {
			{
				id = 28575010,
				branch_content = Lang.get(104301)
			}
		}
	},
	[28575010] = {
		28575010,
		0,
		Lang.get(104302),
		28575,
		10,
		1269,
		{
			RTResTalkAction[68]
		}
	},
	[28575011] = {
		28575011,
		0,
		Lang.get(104303),
		28575,
		11,
		1269,
		{
			RTResTalkAction[68]
		}
	},
	[28575012] = {
		28575012,
		0,
		Lang.get(104304),
		28575,
		12,
		300,
		{
			RTResTalkAction[69]
		}
	},
	[28575013] = {
		28575013,
		0,
		Lang.get(104305),
		28575,
		13,
		1269,
		{
			RTResTalkAction[68]
		}
	},
	[28575014] = {
		28575014,
		0,
		Lang.get(104306),
		28575,
		14,
		300,
		{
			RTResTalkAction[69]
		}
	},
	[28576001] = {
		28576001,
		0,
		Lang.get(104307),
		28576,
		1,
		1269,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28576,
		nil,
		1,
		nil,
		1,
		nil,
		28576
	},
	[28576002] = {
		28576002,
		0,
		Lang.get(104308),
		28576,
		2,
		300,
		nil,
		nil,
		nil,
		3
	},
	[28576003] = {
		28576003,
		0,
		Lang.get(104309),
		28576,
		3,
		1269,
		{
			RTResTalkAction[68]
		}
	},
	[28576004] = {
		28576004,
		0,
		Lang.get(104310),
		28576,
		4,
		1269,
		{
			RTResTalkAction[68]
		}
	},
	[28576005] = {
		28576005,
		4,
		nil,
		28576,
		5,
		1269,
		{
			RTResTalkAction[68]
		},
		[29] = {
			{
				id = 28576006,
				branch_content = Lang.get(104311)
			}
		}
	},
	[28576006] = {
		28576006,
		0,
		Lang.get(104312),
		28576,
		6,
		1269,
		{
			RTResTalkAction[68]
		}
	},
	[28576007] = {
		28576007,
		0,
		Lang.get(104313),
		28576,
		7,
		1269,
		{
			RTResTalkAction[68]
		}
	},
	[28576008] = {
		28576008,
		4,
		nil,
		28576,
		8,
		1269,
		{
			RTResTalkAction[68]
		},
		[29] = {
			{
				id = 28576009,
				branch_content = Lang.get(104314)
			}
		}
	},
	[28576009] = {
		28576009,
		0,
		Lang.get(104315),
		28576,
		9,
		1269,
		{
			RTResTalkAction[68]
		}
	},
	[28576010] = {
		28576010,
		0,
		Lang.get(104316),
		28576,
		10,
		1269,
		{
			RTResTalkAction[68]
		}
	},
	[28576011] = {
		28576011,
		0,
		Lang.get(104317),
		28576,
		11,
		1269,
		{
			RTResTalkAction[68]
		}
	},
	[28576012] = {
		28576012,
		0,
		Lang.get(104318),
		28576,
		12,
		300,
		{
			RTResTalkAction[69]
		}
	},
	[28577001] = {
		28577001,
		0,
		Lang.get(104319),
		28577,
		1,
		1269,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28577,
		nil,
		1,
		nil,
		1,
		nil,
		28577
	},
	[28577002] = {
		28577002,
		4,
		nil,
		28577,
		2,
		1269,
		{
			RTResTalkAction[68]
		},
		nil,
		nil,
		3,
		[29] = {
			{
				id = 28577003,
				branch_content = Lang.get(104320)
			}
		}
	},
	[28577003] = {
		28577003,
		0,
		Lang.get(104321),
		28577,
		3,
		1269,
		{
			RTResTalkAction[68]
		}
	},
	[28577004] = {
		28577004,
		0,
		Lang.get(104322),
		28577,
		4,
		1269,
		{
			RTResTalkAction[68]
		}
	},
	[28577005] = {
		28577005,
		0,
		Lang.get(104323),
		28577,
		5,
		1269,
		{
			RTResTalkAction[68]
		}
	},
	[28577006] = {
		28577006,
		4,
		nil,
		28577,
		6,
		1269,
		{
			RTResTalkAction[68]
		},
		[29] = {
			{
				id = 28577007,
				branch_content = Lang.get(104324)
			}
		}
	},
	[28577007] = {
		28577007,
		0,
		Lang.get(104325),
		28577,
		7,
		1269,
		{
			RTResTalkAction[68]
		}
	},
	[28577008] = {
		28577008,
		0,
		Lang.get(104326),
		28577,
		8,
		1269,
		{
			RTResTalkAction[68]
		}
	},
	[28577009] = {
		28577009,
		0,
		Lang.get(104327),
		28577,
		9,
		1269,
		{
			RTResTalkAction[68]
		}
	},
	[28577010] = {
		28577010,
		0,
		Lang.get(104328),
		28577,
		10,
		1269,
		{
			RTResTalkAction[68]
		}
	},
	[28577011] = {
		28577011,
		0,
		Lang.get(104329),
		28577,
		11,
		300,
		{
			RTResTalkAction[69]
		}
	},
	[28577012] = {
		28577012,
		0,
		Lang.get(104330),
		28577,
		12,
		1269,
		{
			RTResTalkAction[68]
		}
	},
	[28577013] = {
		28577013,
		0,
		Lang.get(104331),
		28577,
		13,
		1269,
		{
			RTResTalkAction[68]
		}
	},
	[28578001] = {
		28578001,
		0,
		Lang.get(111484),
		28578,
		1,
		1296,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28578,
		nil,
		1,
		nil,
		1,
		nil,
		28578
	},
	[28578002] = {
		28578002,
		4,
		nil,
		28578,
		2,
		1296,
		{
			RTResTalkAction[70]
		},
		nil,
		nil,
		3,
		[29] = {
			{
				id = 28578003,
				branch_content = Lang.get(111485)
			}
		}
	},
	[28578003] = {
		28578003,
		0,
		Lang.get(111486),
		28578,
		3,
		1296,
		{
			RTResTalkAction[70]
		}
	},
	[28578004] = {
		28578004,
		0,
		Lang.get(111487),
		28578,
		4,
		1296,
		{
			RTResTalkAction[70]
		}
	},
	[28578005] = {
		28578005,
		4,
		nil,
		28578,
		5,
		1296,
		{
			RTResTalkAction[70]
		},
		[29] = {
			{
				id = 28578006,
				branch_content = Lang.get(111488)
			},
			{
				id = 28578006,
				branch_content = Lang.get(111489)
			}
		}
	},
	[28578006] = {
		28578006,
		0,
		Lang.get(111490),
		28578,
		6,
		1296,
		{
			RTResTalkAction[70]
		}
	},
	[28578007] = {
		28578007,
		0,
		Lang.get(111491),
		28578,
		7,
		1296,
		{
			RTResTalkAction[70]
		}
	},
	[28578008] = {
		28578008,
		4,
		nil,
		28578,
		8,
		1296,
		{
			RTResTalkAction[70]
		},
		[29] = {
			{
				id = 28578009,
				branch_content = Lang.get(111492)
			}
		}
	},
	[28578009] = {
		28578009,
		0,
		Lang.get(111493),
		28578,
		9,
		1296,
		{
			RTResTalkAction[70]
		}
	},
	[28578010] = {
		28578010,
		0,
		Lang.get(111494),
		28578,
		10,
		1296,
		{
			RTResTalkAction[70]
		}
	},
	[28578011] = {
		28578011,
		0,
		Lang.get(111495),
		28578,
		11,
		1296,
		{
			RTResTalkAction[70]
		}
	},
	[28579001] = {
		28579001,
		0,
		Lang.get(111496),
		28579,
		1,
		1296,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28579,
		nil,
		1,
		nil,
		1,
		nil,
		28579
	},
	[28579002] = {
		28579002,
		0,
		Lang.get(111497),
		28579,
		2,
		1296,
		{
			RTResTalkAction[70]
		},
		nil,
		nil,
		3
	},
	[28579003] = {
		28579003,
		4,
		nil,
		28579,
		3,
		1296,
		{
			RTResTalkAction[70]
		},
		[29] = {
			{
				id = 28579004,
				branch_content = Lang.get(111498)
			},
			{
				id = 28579004,
				branch_content = Lang.get(111499)
			}
		}
	},
	[28579004] = {
		28579004,
		0,
		Lang.get(111500),
		28579,
		4,
		1296,
		{
			RTResTalkAction[70]
		}
	},
	[28579005] = {
		28579005,
		0,
		Lang.get(111501),
		28579,
		5,
		1296,
		{
			RTResTalkAction[70]
		}
	},
	[28579006] = {
		28579006,
		4,
		nil,
		28579,
		6,
		1296,
		{
			RTResTalkAction[70]
		},
		[29] = {
			{
				id = 28579007,
				branch_content = Lang.get(111502)
			}
		}
	},
	[28579007] = {
		28579007,
		0,
		Lang.get(111503),
		28579,
		7,
		1296,
		{
			RTResTalkAction[70]
		}
	},
	[28579008] = {
		28579008,
		0,
		Lang.get(111504),
		28579,
		8,
		1296,
		{
			RTResTalkAction[70]
		}
	},
	[28579009] = {
		28579009,
		4,
		nil,
		28579,
		9,
		1296,
		{
			RTResTalkAction[70]
		},
		[29] = {
			{
				id = 28579010,
				branch_content = Lang.get(111505)
			}
		}
	},
	[28579010] = {
		28579010,
		0,
		Lang.get(111506),
		28579,
		10,
		1296,
		{
			RTResTalkAction[70]
		}
	},
	[28579011] = {
		28579011,
		0,
		Lang.get(111507),
		28579,
		11,
		1296,
		{
			RTResTalkAction[70]
		}
	},
	[28579012] = {
		28579012,
		4,
		nil,
		28579,
		12,
		1296,
		{
			RTResTalkAction[70]
		},
		[29] = {
			{
				id = 28579013,
				branch_content = Lang.get(111508)
			},
			{
				id = 28579013,
				branch_content = Lang.get(111509)
			}
		}
	},
	[28579013] = {
		28579013,
		0,
		Lang.get(111510),
		28579,
		13,
		1296,
		{
			RTResTalkAction[70]
		}
	},
	[28579014] = {
		28579014,
		0,
		Lang.get(111511),
		28579,
		14,
		1296,
		{
			RTResTalkAction[70]
		}
	},
	[28579015] = {
		28579015,
		0,
		Lang.get(111512),
		28579,
		15,
		1296,
		{
			RTResTalkAction[70]
		}
	},
	[28580001] = {
		28580001,
		0,
		Lang.get(111513),
		28580,
		1,
		1296,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28580,
		nil,
		1,
		nil,
		1,
		nil,
		28580
	},
	[28580002] = {
		28580002,
		0,
		Lang.get(111514),
		28580,
		2,
		1296,
		{
			RTResTalkAction[70]
		},
		nil,
		nil,
		3
	},
	[28580003] = {
		28580003,
		4,
		nil,
		28580,
		3,
		1296,
		{
			RTResTalkAction[70]
		},
		[29] = {
			{
				id = 28580004,
				branch_content = Lang.get(111515)
			}
		}
	},
	[28580004] = {
		28580004,
		0,
		Lang.get(111516),
		28580,
		4,
		1296,
		{
			RTResTalkAction[70]
		}
	},
	[28580005] = {
		28580005,
		0,
		Lang.get(111517),
		28580,
		5,
		1296,
		{
			RTResTalkAction[70]
		}
	},
	[28580006] = {
		28580006,
		4,
		nil,
		28580,
		6,
		1296,
		{
			RTResTalkAction[70]
		},
		[29] = {
			{
				id = 28580007,
				branch_content = Lang.get(111518)
			},
			{
				id = 28580007,
				branch_content = Lang.get(111519)
			}
		}
	},
	[28580007] = {
		28580007,
		0,
		Lang.get(111517),
		28580,
		7,
		1296,
		{
			RTResTalkAction[70]
		}
	},
	[28580008] = {
		28580008,
		0,
		Lang.get(111520),
		28580,
		8,
		1296,
		{
			RTResTalkAction[70]
		}
	},
	[28580009] = {
		28580009,
		0,
		Lang.get(111521),
		28580,
		9,
		1296,
		{
			RTResTalkAction[70]
		}
	},
	[28580010] = {
		28580010,
		4,
		nil,
		28580,
		10,
		1296,
		{
			RTResTalkAction[70]
		},
		[29] = {
			{
				id = 28580011,
				branch_content = Lang.get(111522)
			}
		}
	},
	[28580011] = {
		28580011,
		0,
		Lang.get(111523),
		28580,
		11,
		1296,
		{
			RTResTalkAction[70]
		}
	},
	[28580012] = {
		28580012,
		0,
		Lang.get(111524),
		28580,
		12,
		1296,
		{
			RTResTalkAction[70]
		}
	},
	[28580013] = {
		28580013,
		0,
		Lang.get(111525),
		28580,
		13,
		1296,
		{
			RTResTalkAction[70]
		}
	},
	[28581001] = {
		28581001,
		0,
		Lang.get(114081),
		28581,
		1,
		1298,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28581,
		nil,
		1,
		nil,
		1,
		nil,
		28581
	},
	[28581002] = {
		28581002,
		0,
		Lang.get(114082),
		28581,
		2,
		1298,
		{
			RTResTalkAction[71]
		},
		nil,
		nil,
		3
	},
	[28581003] = {
		28581003,
		0,
		Lang.get(114083),
		28581,
		3,
		1298,
		{
			RTResTalkAction[71]
		}
	},
	[28581004] = {
		28581004,
		4,
		nil,
		28581,
		4,
		1298,
		{
			RTResTalkAction[72]
		},
		[29] = {
			{
				id = 28581005,
				branch_content = Lang.get(114084)
			},
			{
				id = 28581005,
				branch_content = Lang.get(114085)
			}
		}
	},
	[28581005] = {
		28581005,
		0,
		Lang.get(114086),
		28581,
		5,
		1298,
		{
			RTResTalkAction[71]
		}
	},
	[28581006] = {
		28581006,
		0,
		Lang.get(114087),
		28581,
		6,
		1298,
		{
			RTResTalkAction[71]
		}
	},
	[28581007] = {
		28581007,
		0,
		Lang.get(114088),
		28581,
		7,
		1298,
		{
			RTResTalkAction[71]
		}
	},
	[28581008] = {
		28581008,
		0,
		Lang.get(114089),
		28581,
		8,
		1298,
		{
			RTResTalkAction[71]
		}
	},
	[28581009] = {
		28581009,
		4,
		nil,
		28581,
		9,
		1298,
		{
			RTResTalkAction[72]
		},
		[29] = {
			{
				id = 28581010,
				branch_content = Lang.get(114090)
			}
		}
	},
	[28581010] = {
		28581010,
		0,
		Lang.get(114091),
		28581,
		10,
		1298,
		{
			RTResTalkAction[71]
		}
	},
	[28581011] = {
		28581011,
		0,
		Lang.get(114092),
		28581,
		11,
		1298,
		{
			RTResTalkAction[71]
		}
	},
	[28581012] = {
		28581012,
		3,
		Lang.get(100843),
		28581,
		12,
		605,
		{
			RTResTalkAction[72]
		},
		[22] = 1
	},
	[28581013] = {
		28581013,
		0,
		Lang.get(114093),
		28581,
		13,
		1298,
		{
			RTResTalkAction[71]
		}
	},
	[28581014] = {
		28581014,
		0,
		Lang.get(114094),
		28581,
		14,
		1298,
		{
			RTResTalkAction[71]
		}
	},
	[28582001] = {
		28582001,
		0,
		Lang.get(114095),
		28582,
		1,
		1298,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28582,
		nil,
		1,
		nil,
		1,
		nil,
		28582
	},
	[28582002] = {
		28582002,
		0,
		Lang.get(114096),
		28582,
		2,
		1298,
		{
			RTResTalkAction[71]
		},
		nil,
		nil,
		3
	},
	[28582003] = {
		28582003,
		4,
		nil,
		28582,
		3,
		1298,
		{
			RTResTalkAction[72]
		},
		[29] = {
			{
				id = 28582004,
				branch_content = Lang.get(114097)
			}
		}
	},
	[28582004] = {
		28582004,
		0,
		Lang.get(114098),
		28582,
		4,
		1298,
		{
			RTResTalkAction[71]
		}
	},
	[28582005] = {
		28582005,
		0,
		Lang.get(114099),
		28582,
		5,
		1298,
		{
			RTResTalkAction[71]
		}
	},
	[28582006] = {
		28582006,
		0,
		Lang.get(114100),
		28582,
		6,
		1298,
		{
			RTResTalkAction[71]
		}
	},
	[28582007] = {
		28582007,
		4,
		nil,
		28582,
		7,
		1298,
		{
			RTResTalkAction[72]
		},
		[29] = {
			{
				id = 28582008,
				branch_content = Lang.get(114101)
			}
		}
	},
	[28582008] = {
		28582008,
		0,
		Lang.get(114102),
		28582,
		8,
		1298,
		{
			RTResTalkAction[71]
		}
	},
	[28582009] = {
		28582009,
		0,
		Lang.get(114103),
		28582,
		9,
		1298,
		{
			RTResTalkAction[71]
		}
	},
	[28582010] = {
		28582010,
		4,
		nil,
		28582,
		10,
		1298,
		{
			RTResTalkAction[72]
		},
		[29] = {
			{
				id = 28582011,
				branch_content = Lang.get(114104)
			},
			{
				id = 28582011,
				branch_content = Lang.get(114105)
			}
		}
	},
	[28582011] = {
		28582011,
		0,
		Lang.get(114106),
		28582,
		11,
		1298,
		{
			RTResTalkAction[71]
		}
	},
	[28582012] = {
		28582012,
		0,
		Lang.get(114107),
		28582,
		12,
		1298,
		{
			RTResTalkAction[71]
		}
	},
	[28583001] = {
		28583001,
		0,
		Lang.get(114108),
		28583,
		1,
		1298,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28583,
		nil,
		1,
		nil,
		1,
		nil,
		28583
	},
	[28583002] = {
		28583002,
		0,
		Lang.get(114109),
		28583,
		2,
		1298,
		{
			RTResTalkAction[71]
		},
		nil,
		nil,
		3
	},
	[28583003] = {
		28583003,
		4,
		nil,
		28583,
		3,
		1298,
		{
			RTResTalkAction[38],
			RTResTalkAction[72]
		},
		[29] = {
			{
				id = 28583004,
				branch_content = Lang.get(114110)
			},
			{
				id = 28583004,
				branch_content = Lang.get(114111)
			}
		}
	},
	[28583004] = {
		28583004,
		0,
		Lang.get(114112),
		28583,
		4,
		1298,
		{
			RTResTalkAction[71],
			RTResTalkAction[39]
		}
	},
	[28583005] = {
		28583005,
		0,
		Lang.get(114113),
		28583,
		5,
		1298,
		{
			RTResTalkAction[71]
		}
	},
	[28583006] = {
		28583006,
		0,
		Lang.get(114114),
		28583,
		6,
		1298,
		{
			RTResTalkAction[71]
		}
	},
	[28583007] = {
		28583007,
		0,
		Lang.get(114115),
		28583,
		7,
		300,
		{
			RTResTalkAction[38],
			RTResTalkAction[72]
		}
	},
	[28583008] = {
		28583008,
		0,
		Lang.get(114116),
		28583,
		8,
		1298,
		{
			RTResTalkAction[71],
			RTResTalkAction[39]
		}
	},
	[28583009] = {
		28583009,
		0,
		Lang.get(114117),
		28583,
		9,
		1298,
		{
			RTResTalkAction[71]
		}
	},
	[28583010] = {
		28583010,
		4,
		nil,
		28583,
		10,
		1298,
		{
			RTResTalkAction[38],
			RTResTalkAction[72]
		},
		[29] = {
			{
				id = 28583011,
				branch_content = Lang.get(114118)
			},
			{
				id = 28583011,
				branch_content = Lang.get(114119)
			}
		}
	},
	[28583011] = {
		28583011,
		0,
		Lang.get(114120),
		28583,
		11,
		1298,
		{
			RTResTalkAction[71],
			RTResTalkAction[39]
		}
	},
	[28584001] = {
		28584001,
		0,
		"……",
		28584,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		28584,
		nil,
		1,
		nil,
		1,
		nil,
		28584
	},
	[28584002] = {
		28584002,
		0,
		Lang.get(18191),
		28584,
		2,
		1299,
		{
			RTResTalkAction[73]
		},
		nil,
		nil,
		3
	},
	[28584003] = {
		28584003,
		4,
		nil,
		28584,
		3,
		1299,
		{
			RTResTalkAction[73]
		},
		[29] = {
			{
				id = 28584004,
				branch_content = "……"
			}
		}
	},
	[28584004] = {
		28584004,
		0,
		Lang.get(114121),
		28584,
		4,
		1299,
		{
			RTResTalkAction[73]
		}
	},
	[28584005] = {
		28584005,
		4,
		nil,
		28584,
		5,
		1299,
		{
			RTResTalkAction[73]
		},
		[29] = {
			{
				id = 28584006,
				branch_content = Lang.get(114122)
			},
			{
				id = 28584006,
				branch_content = Lang.get(114123)
			}
		}
	},
	[28584006] = {
		28584006,
		0,
		Lang.get(114124),
		28584,
		6,
		1299,
		{
			RTResTalkAction[73]
		}
	},
	[28584007] = {
		28584007,
		0,
		Lang.get(114125),
		28584,
		7,
		1299,
		{
			RTResTalkAction[73]
		}
	},
	[28584008] = {
		28584008,
		0,
		Lang.get(114126),
		28584,
		8,
		300,
		{
			RTResTalkAction[74]
		}
	},
	[28584009] = {
		28584009,
		0,
		Lang.get(114127),
		28584,
		9,
		1299,
		{
			RTResTalkAction[73]
		}
	},
	[28584010] = {
		28584010,
		0,
		Lang.get(114128),
		28584,
		10,
		300,
		{
			RTResTalkAction[74]
		}
	},
	[28584011] = {
		28584011,
		0,
		Lang.get(114129),
		28584,
		11,
		1299,
		{
			RTResTalkAction[73]
		}
	},
	[28584012] = {
		28584012,
		0,
		Lang.get(114130),
		28584,
		12,
		300,
		{
			RTResTalkAction[74]
		}
	},
	[28584013] = {
		28584013,
		0,
		Lang.get(114131),
		28584,
		13,
		1299,
		{
			RTResTalkAction[73]
		}
	},
	[28584014] = {
		28584014,
		4,
		nil,
		28584,
		14,
		1299,
		{
			RTResTalkAction[73]
		},
		[29] = {
			{
				id = 28584015,
				branch_content = Lang.get(114132)
			},
			{
				id = 28584015,
				branch_content = Lang.get(114133)
			}
		}
	},
	[28584015] = {
		28584015,
		0,
		Lang.get(114134),
		28584,
		15,
		1299,
		{
			RTResTalkAction[73]
		}
	},
	[28584016] = {
		28584016,
		0,
		"……",
		28584,
		16,
		1118,
		{
			RTResTalkAction[75],
			RTResTalkAction[74]
		}
	},
	[28584017] = {
		28584017,
		0,
		Lang.get(114135),
		28584,
		17,
		1299,
		{
			RTResTalkAction[73],
			RTResTalkAction[76]
		}
	},
	[28584018] = {
		28584018,
		0,
		Lang.get(114136),
		28584,
		18,
		1299,
		{
			RTResTalkAction[73]
		}
	},
	[28585001] = {
		28585001,
		0,
		"……",
		28585,
		1,
		1299,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28585,
		nil,
		1,
		nil,
		1,
		nil,
		28585
	},
	[28585002] = {
		28585002,
		4,
		nil,
		28585,
		2,
		1299,
		nil,
		nil,
		nil,
		3,
		[29] = {
			{
				id = 28585003,
				branch_content = "……"
			},
			{
				id = 28585003,
				branch_content = Lang.get(114137)
			}
		}
	},
	[28585003] = {
		28585003,
		0,
		Lang.get(114138),
		28585,
		3,
		1299,
		{
			RTResTalkAction[73]
		}
	},
	[28585004] = {
		28585004,
		0,
		Lang.get(114139),
		28585,
		4,
		300,
		{
			RTResTalkAction[74]
		}
	},
	[28585005] = {
		28585005,
		0,
		Lang.get(114140),
		28585,
		5,
		1299,
		{
			RTResTalkAction[73]
		}
	},
	[28585006] = {
		28585006,
		0,
		Lang.get(114141),
		28585,
		6,
		1299,
		{
			RTResTalkAction[73]
		}
	},
	[28585007] = {
		28585007,
		0,
		Lang.get(114142),
		28585,
		7,
		1299,
		{
			RTResTalkAction[73]
		}
	},
	[28585008] = {
		28585008,
		4,
		nil,
		28585,
		8,
		1299,
		{
			RTResTalkAction[74]
		},
		[29] = {
			{
				id = 28585009,
				branch_content = Lang.get(114143)
			},
			{
				id = 28585009,
				branch_content = Lang.get(114144)
			}
		}
	},
	[28585009] = {
		28585009,
		0,
		Lang.get(114145),
		28585,
		9,
		1299,
		{
			RTResTalkAction[73]
		}
	},
	[28585010] = {
		28585010,
		0,
		Lang.get(114146),
		28585,
		10,
		300,
		{
			RTResTalkAction[74]
		}
	},
	[28585011] = {
		28585011,
		4,
		nil,
		28585,
		11,
		300,
		[29] = {
			{
				id = 28585012,
				branch_content = Lang.get(114147)
			}
		}
	},
	[28585012] = {
		28585012,
		0,
		Lang.get(114148),
		28585,
		12,
		1299,
		{
			RTResTalkAction[73]
		}
	},
	[28585013] = {
		28585013,
		0,
		Lang.get(114149),
		28585,
		13,
		1299,
		{
			RTResTalkAction[73]
		}
	},
	[28585014] = {
		28585014,
		4,
		nil,
		28585,
		14,
		1299,
		{
			RTResTalkAction[74]
		},
		[29] = {
			{
				id = 28585015,
				branch_content = Lang.get(20458)
			}
		}
	},
	[28585015] = {
		28585015,
		0,
		Lang.get(114150),
		28585,
		15,
		1299,
		{
			RTResTalkAction[73]
		}
	},
	[28585016] = {
		28585016,
		0,
		Lang.get(114151),
		28585,
		16,
		1299,
		{
			RTResTalkAction[73]
		}
	},
	[28585017] = {
		28585017,
		0,
		Lang.get(114152),
		28585,
		17,
		300,
		{
			RTResTalkAction[74]
		}
	},
	[28586001] = {
		28586001,
		0,
		Lang.get(114153),
		28586,
		1,
		1299,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		28586,
		nil,
		1,
		nil,
		1,
		nil,
		28586
	},
	[28586002] = {
		28586002,
		0,
		Lang.get(114154),
		28586,
		2,
		1299,
		{
			RTResTalkAction[73]
		},
		nil,
		nil,
		3
	},
	[28586003] = {
		28586003,
		0,
		Lang.get(27515),
		28586,
		3,
		300,
		{
			RTResTalkAction[74]
		}
	},
	[28586004] = {
		28586004,
		0,
		Lang.get(114155),
		28586,
		4,
		1299,
		{
			RTResTalkAction[73]
		}
	},
	[28586005] = {
		28586005,
		0,
		Lang.get(114156),
		28586,
		5,
		300,
		{
			RTResTalkAction[74]
		}
	},
	[28586006] = {
		28586006,
		0,
		Lang.get(114157),
		28586,
		6,
		1299,
		{
			RTResTalkAction[73]
		}
	},
	[28586007] = {
		28586007,
		0,
		Lang.get(114158),
		28586,
		7,
		300,
		{
			RTResTalkAction[74]
		}
	},
	[28586008] = {
		28586008,
		0,
		Lang.get(114159),
		28586,
		8,
		1299,
		{
			RTResTalkAction[73]
		}
	},
	[28586009] = {
		28586009,
		0,
		Lang.get(114160),
		28586,
		9,
		300,
		{
			RTResTalkAction[74]
		}
	},
	[28586010] = {
		28586010,
		0,
		Lang.get(114161),
		28586,
		10,
		1299,
		{
			RTResTalkAction[73]
		}
	},
	[28586011] = {
		28586011,
		0,
		Lang.get(114162),
		28586,
		11,
		1299,
		{
			RTResTalkAction[73]
		}
	},
	[28586012] = {
		28586012,
		4,
		nil,
		28586,
		12,
		1299,
		{
			RTResTalkAction[74]
		},
		[29] = {
			{
				id = 28586013,
				branch_content = Lang.get(114163)
			}
		}
	},
	[28586013] = {
		28586013,
		3,
		Lang.get(114164),
		28586,
		13,
		605,
		[22] = 1
	},
	[28586014] = {
		28586014,
		0,
		Lang.get(114165),
		28586,
		14,
		1299,
		{
			RTResTalkAction[73]
		}
	},
	[28586015] = {
		28586015,
		0,
		Lang.get(114166),
		28586,
		15,
		1299,
		{
			RTResTalkAction[73]
		}
	},
	[28586016] = {
		28586016,
		0,
		Lang.get(114167),
		28586,
		16,
		1299,
		{
			RTResTalkAction[73]
		}
	},
	[28586017] = {
		28586017,
		0,
		Lang.get(114168),
		28586,
		17,
		1299,
		{
			RTResTalkAction[73]
		}
	},
	[28587001] = {
		28587001,
		0,
		Lang.get(28533),
		28587,
		1,
		1301,
		{
			RTResTalkAction[77]
		},
		nil,
		nil,
		3,
		nil,
		62,
		28587,
		nil,
		nil,
		nil,
		nil,
		nil,
		28587
	},
	[28587002] = {
		28587002,
		4,
		nil,
		28587,
		2,
		1301,
		{
			RTResTalkAction[77]
		},
		[29] = {
			{
				id = 28587003,
				branch_content = Lang.get(115352)
			}
		}
	},
	[28587003] = {
		28587003,
		0,
		Lang.get(115353),
		28587,
		3,
		1301,
		{
			RTResTalkAction[77]
		}
	},
	[28587004] = {
		28587004,
		4,
		nil,
		28587,
		4,
		1301,
		{
			RTResTalkAction[78]
		},
		[29] = {
			{
				id = 28587005,
				branch_content = Lang.get(115354)
			}
		}
	},
	[28587005] = {
		28587005,
		0,
		Lang.get(115355),
		28587,
		5,
		1301,
		{
			RTResTalkAction[77]
		}
	},
	[28587006] = {
		28587006,
		0,
		Lang.get(115356),
		28587,
		6,
		1301,
		{
			RTResTalkAction[77]
		}
	},
	[28587007] = {
		28587007,
		3,
		Lang.get(115357),
		28587,
		7,
		605,
		{
			RTResTalkAction[78]
		},
		[22] = 1
	},
	[28587008] = {
		28587008,
		0,
		Lang.get(115358),
		28587,
		8,
		1301,
		{
			RTResTalkAction[77]
		}
	},
	[28587009] = {
		28587009,
		0,
		Lang.get(115359),
		28587,
		9,
		1301,
		{
			RTResTalkAction[77]
		}
	},
	[28587010] = {
		28587010,
		4,
		nil,
		28587,
		10,
		1301,
		{
			RTResTalkAction[78]
		},
		[29] = {
			{
				id = 28587011,
				branch_content = Lang.get(115360)
			},
			{
				id = 28587011,
				branch_content = Lang.get(115361)
			}
		}
	},
	[28587011] = {
		28587011,
		0,
		Lang.get(115362),
		28587,
		11,
		1301,
		{
			RTResTalkAction[77]
		}
	},
	[28587012] = {
		28587012,
		4,
		nil,
		28587,
		12,
		1301,
		{
			RTResTalkAction[78]
		},
		[29] = {
			{
				id = 28587013,
				branch_content = Lang.get(115363)
			}
		}
	},
	[28587013] = {
		28587013,
		0,
		Lang.get(115364),
		28587,
		13,
		1301,
		{
			RTResTalkAction[77]
		}
	},
	[28588001] = {
		28588001,
		0,
		Lang.get(115365),
		28588,
		1,
		1301,
		{
			RTResTalkAction[77]
		},
		nil,
		nil,
		3,
		nil,
		62,
		28588,
		nil,
		nil,
		nil,
		nil,
		nil,
		28588
	},
	[28588002] = {
		28588002,
		4,
		nil,
		28588,
		2,
		1301,
		{
			RTResTalkAction[78]
		},
		[29] = {
			{
				id = 28588003,
				branch_content = Lang.get(115366)
			}
		}
	},
	[28588003] = {
		28588003,
		0,
		Lang.get(115367),
		28588,
		3,
		1301,
		{
			RTResTalkAction[77]
		}
	},
	[28588004] = {
		28588004,
		0,
		Lang.get(115368),
		28588,
		4,
		1301,
		{
			RTResTalkAction[77]
		}
	},
	[28588005] = {
		28588005,
		0,
		Lang.get(115369),
		28588,
		5,
		1301,
		{
			RTResTalkAction[77]
		}
	},
	[28588006] = {
		28588006,
		0,
		Lang.get(115370),
		28588,
		6,
		300,
		{
			RTResTalkAction[78]
		}
	},
	[28588007] = {
		28588007,
		0,
		Lang.get(115371),
		28588,
		7,
		1301,
		{
			RTResTalkAction[77]
		}
	},
	[28588008] = {
		28588008,
		0,
		Lang.get(115372),
		28588,
		8,
		300,
		{
			RTResTalkAction[78]
		}
	},
	[28588009] = {
		28588009,
		0,
		Lang.get(115373),
		28588,
		9,
		1301,
		{
			RTResTalkAction[77]
		}
	},
	[28588010] = {
		28588010,
		0,
		Lang.get(115374),
		28588,
		10,
		1301,
		{
			RTResTalkAction[77]
		}
	},
	[28588011] = {
		28588011,
		4,
		nil,
		28588,
		11,
		1301,
		{
			RTResTalkAction[77]
		},
		[29] = {
			{
				id = 28588012,
				branch_content = Lang.get(115375)
			}
		}
	},
	[28588012] = {
		28588012,
		0,
		Lang.get(115376),
		28588,
		12,
		1301,
		{
			RTResTalkAction[77]
		}
	},
	[28589001] = {
		28589001,
		0,
		Lang.get(115377),
		28589,
		1,
		1301,
		{
			RTResTalkAction[77]
		},
		nil,
		nil,
		3,
		nil,
		62,
		28589,
		nil,
		nil,
		nil,
		nil,
		nil,
		28589
	},
	[28589002] = {
		28589002,
		0,
		Lang.get(115378),
		28589,
		2,
		1301,
		{
			RTResTalkAction[77]
		}
	},
	[28589003] = {
		28589003,
		4,
		nil,
		28589,
		3,
		1301,
		{
			RTResTalkAction[78]
		},
		[29] = {
			{
				id = 28589004,
				branch_content = Lang.get(115379)
			}
		}
	},
	[28589004] = {
		28589004,
		0,
		Lang.get(115380),
		28589,
		4,
		1301,
		{
			RTResTalkAction[77]
		}
	},
	[28589005] = {
		28589005,
		0,
		Lang.get(115381),
		28589,
		5,
		1301,
		{
			RTResTalkAction[77]
		}
	},
	[28589006] = {
		28589006,
		4,
		nil,
		28589,
		6,
		1301,
		{
			RTResTalkAction[78]
		},
		[29] = {
			{
				id = 28589007,
				branch_content = Lang.get(115382)
			}
		}
	},
	[28589007] = {
		28589007,
		0,
		Lang.get(115383),
		28589,
		7,
		300
	},
	[28589008] = {
		28589008,
		0,
		Lang.get(115384),
		28589,
		8,
		1301,
		{
			RTResTalkAction[77]
		}
	},
	[28589009] = {
		28589009,
		0,
		Lang.get(115385),
		28589,
		9,
		1301,
		{
			RTResTalkAction[77]
		}
	},
	[28590001] = {
		28590001,
		0,
		Lang.get(116265),
		28590,
		1,
		1303,
		{
			RTResTalkAction[79]
		},
		nil,
		nil,
		3,
		nil,
		62,
		28590,
		nil,
		nil,
		nil,
		nil,
		nil,
		28590
	},
	[28590002] = {
		28590002,
		0,
		Lang.get(116266),
		28590,
		2,
		300,
		{
			RTResTalkAction[79]
		}
	},
	[28590003] = {
		28590003,
		0,
		Lang.get(116267),
		28590,
		3,
		1303,
		{
			RTResTalkAction[79]
		}
	},
	[28590004] = {
		28590004,
		0,
		Lang.get(116268),
		28590,
		4,
		300,
		{
			RTResTalkAction[79]
		}
	},
	[28590005] = {
		28590005,
		0,
		Lang.get(116269),
		28590,
		5,
		1303,
		{
			RTResTalkAction[79]
		}
	},
	[28590006] = {
		28590006,
		0,
		Lang.get(116270),
		28590,
		6,
		300,
		{
			RTResTalkAction[79]
		}
	},
	[28590007] = {
		28590007,
		0,
		Lang.get(116271),
		28590,
		7,
		1303,
		{
			RTResTalkAction[79]
		}
	},
	[28590008] = {
		28590008,
		4,
		nil,
		28590,
		8,
		1303,
		{
			RTResTalkAction[79]
		},
		[29] = {
			{
				id = 28590009,
				branch_content = Lang.get(116272)
			},
			{
				id = 28590009,
				branch_content = Lang.get(116273)
			}
		}
	},
	[28590009] = {
		28590009,
		0,
		Lang.get(116274),
		28590,
		9,
		1303,
		{
			RTResTalkAction[79]
		}
	},
	[28590010] = {
		28590010,
		0,
		Lang.get(116275),
		28590,
		10,
		300,
		{
			RTResTalkAction[79]
		}
	},
	[28590011] = {
		28590011,
		0,
		Lang.get(116276),
		28590,
		11,
		1303,
		{
			RTResTalkAction[79]
		}
	},
	[28590012] = {
		28590012,
		0,
		Lang.get(116277),
		28590,
		12,
		300,
		{
			RTResTalkAction[79]
		}
	},
	[28590013] = {
		28590013,
		0,
		Lang.get(116278),
		28590,
		13,
		1303,
		{
			RTResTalkAction[79]
		}
	},
	[28590014] = {
		28590014,
		0,
		Lang.get(116279),
		28590,
		14,
		300,
		{
			RTResTalkAction[79]
		}
	},
	[28590015] = {
		28590015,
		0,
		Lang.get(116280),
		28590,
		15,
		1303,
		{
			RTResTalkAction[79]
		}
	},
	[28590016] = {
		28590016,
		0,
		Lang.get(116281),
		28590,
		16,
		300,
		{
			RTResTalkAction[79]
		}
	},
	[28590017] = {
		28590017,
		0,
		Lang.get(116282),
		28590,
		17,
		1303,
		{
			RTResTalkAction[79]
		}
	},
	[28590018] = {
		28590018,
		0,
		Lang.get(116283),
		28590,
		18,
		300,
		{
			RTResTalkAction[79]
		}
	},
	[28591001] = {
		28591001,
		0,
		Lang.get(116284),
		28591,
		1,
		1303,
		{
			RTResTalkAction[79]
		},
		nil,
		nil,
		3,
		nil,
		62,
		28590,
		nil,
		nil,
		nil,
		nil,
		nil,
		28590
	},
	[28591002] = {
		28591002,
		0,
		Lang.get(116285),
		28591,
		2,
		1303,
		{
			RTResTalkAction[79]
		}
	},
	[28591003] = {
		28591003,
		0,
		Lang.get(116286),
		28591,
		3,
		300,
		{
			RTResTalkAction[79]
		}
	},
	[28591004] = {
		28591004,
		0,
		Lang.get(116287),
		28591,
		4,
		1303,
		{
			RTResTalkAction[79]
		}
	},
	[28591005] = {
		28591005,
		0,
		Lang.get(116288),
		28591,
		5,
		300,
		{
			RTResTalkAction[79]
		}
	},
	[28591006] = {
		28591006,
		0,
		Lang.get(116289),
		28591,
		6,
		1303,
		{
			RTResTalkAction[79]
		}
	},
	[28591007] = {
		28591007,
		4,
		nil,
		28591,
		7,
		1303,
		{
			RTResTalkAction[79]
		},
		[29] = {
			{
				id = 28591008,
				branch_content = Lang.get(116290)
			},
			{
				id = 28591008,
				branch_content = Lang.get(116291)
			}
		}
	},
	[28591008] = {
		28591008,
		0,
		Lang.get(116292),
		28591,
		8,
		1303,
		{
			RTResTalkAction[79]
		}
	},
	[28591009] = {
		28591009,
		0,
		Lang.get(116293),
		28591,
		9,
		1303,
		{
			RTResTalkAction[79]
		}
	},
	[28591010] = {
		28591010,
		3,
		Lang.get(116294),
		28591,
		10,
		605,
		{
			RTResTalkAction[79]
		},
		[22] = 1
	},
	[28591011] = {
		28591011,
		0,
		Lang.get(116295),
		28591,
		11,
		1303,
		{
			RTResTalkAction[79]
		}
	},
	[28591012] = {
		28591012,
		4,
		nil,
		28591,
		12,
		1303,
		{
			RTResTalkAction[79]
		},
		[29] = {
			{
				id = 28591013,
				branch_content = Lang.get(116296)
			},
			{
				id = 28591013,
				branch_content = Lang.get(116297)
			}
		}
	},
	[28591013] = {
		28591013,
		0,
		Lang.get(116298),
		28591,
		13,
		1303,
		{
			RTResTalkAction[79]
		}
	},
	[28591014] = {
		28591014,
		0,
		Lang.get(116299),
		28591,
		14,
		300,
		{
			RTResTalkAction[79]
		}
	},
	[28591015] = {
		28591015,
		0,
		Lang.get(116300),
		28591,
		15,
		1303,
		{
			RTResTalkAction[79]
		}
	},
	[28591016] = {
		28591016,
		0,
		Lang.get(113452),
		28591,
		16,
		300,
		{
			RTResTalkAction[79]
		}
	},
	[28592001] = {
		28592001,
		0,
		Lang.get(116301),
		28592,
		1,
		1303,
		{
			RTResTalkAction[79]
		},
		nil,
		nil,
		3,
		nil,
		62,
		28590,
		nil,
		nil,
		nil,
		nil,
		nil,
		28590
	},
	[28592002] = {
		28592002,
		4,
		nil,
		28592,
		2,
		1303,
		{
			RTResTalkAction[79]
		},
		[29] = {
			{
				id = 28592003,
				branch_content = Lang.get(116302)
			},
			{
				id = 28592003,
				branch_content = Lang.get(116303)
			}
		}
	},
	[28592003] = {
		28592003,
		0,
		Lang.get(116304),
		28592,
		3,
		1303,
		{
			RTResTalkAction[79]
		}
	},
	[28592004] = {
		28592004,
		3,
		Lang.get(110441),
		28592,
		4,
		605,
		{
			RTResTalkAction[79]
		},
		[22] = 1
	},
	[28592005] = {
		28592005,
		0,
		Lang.get(116305),
		28592,
		5,
		1303,
		{
			RTResTalkAction[79]
		}
	},
	[28592006] = {
		28592006,
		0,
		Lang.get(116306),
		28592,
		6,
		300,
		{
			RTResTalkAction[79]
		}
	},
	[28592007] = {
		28592007,
		0,
		Lang.get(116307),
		28592,
		7,
		300,
		{
			RTResTalkAction[79]
		}
	},
	[28592008] = {
		28592008,
		0,
		Lang.get(116308),
		28592,
		8,
		1303,
		{
			RTResTalkAction[79]
		}
	},
	[28592009] = {
		28592009,
		4,
		nil,
		28592,
		9,
		1303,
		{
			RTResTalkAction[79]
		},
		[29] = {
			{
				id = 28592010,
				branch_content = Lang.get(62777)
			},
			{
				id = 28592010,
				branch_content = Lang.get(76341)
			}
		}
	},
	[28592010] = {
		28592010,
		0,
		Lang.get(116309),
		28592,
		10,
		1303,
		{
			RTResTalkAction[79]
		}
	},
	[28592011] = {
		28592011,
		0,
		Lang.get(116310),
		28592,
		11,
		300,
		{
			RTResTalkAction[79]
		}
	},
	[28592012] = {
		28592012,
		0,
		Lang.get(116311),
		28592,
		12,
		1303,
		{
			RTResTalkAction[79]
		}
	},
	[28592013] = {
		28592013,
		0,
		Lang.get(113241),
		28592,
		13,
		300,
		{
			RTResTalkAction[79]
		}
	},
	[28592014] = {
		28592014,
		0,
		Lang.get(116312),
		28592,
		14,
		1303,
		{
			RTResTalkAction[79]
		}
	},
	[28592015] = {
		28592015,
		0,
		Lang.get(116313),
		28592,
		15,
		300,
		{
			RTResTalkAction[79]
		}
	},
	[28592016] = {
		28592016,
		0,
		Lang.get(116314),
		28592,
		16,
		1303,
		{
			RTResTalkAction[79]
		}
	},
	[28592017] = {
		28592017,
		0,
		Lang.get(116315),
		28592,
		17,
		300,
		{
			RTResTalkAction[79]
		}
	},
	[28592018] = {
		28592018,
		3,
		Lang.get(110441),
		28592,
		18,
		605,
		{
			RTResTalkAction[79]
		},
		[22] = 1
	},
	[28592019] = {
		28592019,
		0,
		Lang.get(116316),
		28592,
		19,
		1303,
		{
			RTResTalkAction[79]
		}
	},
	[28593001] = {
		28593001,
		0,
		Lang.get(116317),
		28593,
		1,
		1302,
		{
			RTResTalkAction[80]
		},
		nil,
		nil,
		3,
		nil,
		62,
		28590,
		nil,
		nil,
		nil,
		nil,
		nil,
		28590
	},
	[28593002] = {
		28593002,
		4,
		nil,
		28593,
		2,
		1302,
		{
			RTResTalkAction[80]
		},
		[29] = {
			{
				id = 28593003,
				branch_content = Lang.get(116318)
			}
		}
	},
	[28593003] = {
		28593003,
		0,
		Lang.get(116319),
		28593,
		3,
		1302,
		{
			RTResTalkAction[80]
		}
	},
	[28593004] = {
		28593004,
		4,
		nil,
		28593,
		4,
		1302,
		{
			RTResTalkAction[80]
		},
		[29] = {
			{
				id = 28593005,
				branch_content = Lang.get(116320)
			}
		}
	},
	[28593005] = {
		28593005,
		0,
		Lang.get(116321),
		28593,
		5,
		1302,
		{
			RTResTalkAction[80]
		}
	},
	[28593006] = {
		28593006,
		0,
		Lang.get(116322),
		28593,
		6,
		1302,
		{
			RTResTalkAction[80]
		}
	},
	[28593007] = {
		28593007,
		0,
		Lang.get(116323),
		28593,
		7,
		1302,
		{
			RTResTalkAction[80]
		}
	},
	[28593008] = {
		28593008,
		4,
		nil,
		28593,
		8,
		1302,
		{
			RTResTalkAction[80]
		},
		[29] = {
			{
				id = 28593009,
				branch_content = Lang.get(116324)
			},
			{
				id = 28593009,
				branch_content = Lang.get(116325)
			}
		}
	},
	[28593009] = {
		28593009,
		0,
		"……",
		28593,
		9,
		1302,
		{
			RTResTalkAction[80]
		}
	},
	[28593010] = {
		28593010,
		0,
		Lang.get(116326),
		28593,
		10,
		1302,
		{
			RTResTalkAction[80]
		}
	},
	[28594001] = {
		28594001,
		0,
		Lang.get(116327),
		28594,
		1,
		1302,
		{
			RTResTalkAction[80]
		},
		nil,
		nil,
		3,
		nil,
		62,
		28590,
		nil,
		nil,
		nil,
		nil,
		nil,
		28590
	},
	[28594002] = {
		28594002,
		0,
		Lang.get(116328),
		28594,
		2,
		1302,
		{
			RTResTalkAction[80]
		}
	},
	[28594003] = {
		28594003,
		4,
		nil,
		28594,
		3,
		1302,
		{
			RTResTalkAction[80]
		},
		[29] = {
			{
				id = 28594004,
				branch_content = Lang.get(116329)
			}
		}
	},
	[28594004] = {
		28594004,
		0,
		Lang.get(116330),
		28594,
		4,
		1302,
		{
			RTResTalkAction[80]
		}
	},
	[28594005] = {
		28594005,
		0,
		Lang.get(116331),
		28594,
		5,
		1302,
		{
			RTResTalkAction[80]
		}
	},
	[28594006] = {
		28594006,
		4,
		nil,
		28594,
		6,
		1302,
		{
			RTResTalkAction[80]
		},
		[29] = {
			{
				id = 28594007,
				branch_content = Lang.get(116332)
			}
		}
	},
	[28594007] = {
		28594007,
		0,
		Lang.get(116333),
		28594,
		7,
		1302,
		{
			RTResTalkAction[80]
		}
	},
	[28594008] = {
		28594008,
		4,
		nil,
		28594,
		8,
		1302,
		{
			RTResTalkAction[80]
		},
		[29] = {
			{
				id = 28594009,
				branch_content = Lang.get(116334)
			}
		}
	},
	[28594009] = {
		28594009,
		0,
		Lang.get(116335),
		28594,
		9,
		1302,
		{
			RTResTalkAction[80]
		}
	},
	[28594010] = {
		28594010,
		0,
		Lang.get(116336),
		28594,
		10,
		1302,
		{
			RTResTalkAction[80]
		}
	},
	[28594011] = {
		28594011,
		0,
		Lang.get(116337),
		28594,
		11,
		1302,
		{
			RTResTalkAction[80]
		}
	},
	[28595001] = {
		28595001,
		0,
		Lang.get(116338),
		28595,
		1,
		1302,
		{
			RTResTalkAction[80]
		},
		nil,
		nil,
		3,
		nil,
		62,
		28590,
		nil,
		nil,
		nil,
		nil,
		nil,
		28590
	},
	[28595002] = {
		28595002,
		4,
		nil,
		28595,
		2,
		1302,
		{
			RTResTalkAction[80]
		},
		[29] = {
			{
				id = 28595003,
				branch_content = Lang.get(116339)
			}
		}
	},
	[28595003] = {
		28595003,
		0,
		Lang.get(116340),
		28595,
		3,
		1302,
		{
			RTResTalkAction[80]
		}
	},
	[28595004] = {
		28595004,
		0,
		Lang.get(116341),
		28595,
		4,
		1302,
		{
			RTResTalkAction[80]
		}
	},
	[28595005] = {
		28595005,
		4,
		nil,
		28595,
		5,
		1302,
		{
			RTResTalkAction[80]
		},
		[29] = {
			{
				id = 28595006,
				branch_content = Lang.get(116342)
			}
		}
	},
	[28595006] = {
		28595006,
		0,
		Lang.get(116343),
		28595,
		6,
		1302,
		{
			RTResTalkAction[80]
		}
	},
	[28595007] = {
		28595007,
		0,
		Lang.get(116344),
		28595,
		7,
		1302,
		{
			RTResTalkAction[80]
		}
	},
	[28595008] = {
		28595008,
		4,
		nil,
		28595,
		8,
		1302,
		{
			RTResTalkAction[80]
		},
		[29] = {
			{
				id = 28595009,
				branch_content = Lang.get(116345)
			}
		}
	},
	[28595009] = {
		28595009,
		0,
		Lang.get(116346),
		28595,
		9,
		1302,
		{
			RTResTalkAction[80]
		}
	},
	[28595010] = {
		28595010,
		0,
		Lang.get(116347),
		28595,
		10,
		1302,
		{
			RTResTalkAction[80]
		}
	},
	[28596001] = {
		28596001,
		0,
		Lang.get(117135),
		28596,
		1,
		1306,
		{
			RTResTalkAction[81]
		},
		nil,
		nil,
		3,
		nil,
		62,
		28590,
		nil,
		nil,
		nil,
		nil,
		nil,
		28590
	},
	[28596002] = {
		28596002,
		4,
		nil,
		28596,
		2,
		1306,
		{
			RTResTalkAction[81]
		},
		[29] = {
			{
				id = 28596003,
				branch_content = Lang.get(117136)
			},
			{
				id = 28596003,
				branch_content = Lang.get(117137)
			}
		}
	},
	[28596003] = {
		28596003,
		0,
		Lang.get(117138),
		28596,
		3,
		1306,
		{
			RTResTalkAction[81]
		}
	},
	[28596004] = {
		28596004,
		0,
		Lang.get(117139),
		28596,
		4,
		1306,
		{
			RTResTalkAction[81]
		}
	},
	[28596005] = {
		28596005,
		4,
		nil,
		28596,
		5,
		1306,
		{
			RTResTalkAction[81]
		},
		[29] = {
			{
				id = 28596006,
				branch_content = Lang.get(117140)
			}
		}
	},
	[28596006] = {
		28596006,
		0,
		Lang.get(117141),
		28596,
		6,
		1306,
		{
			RTResTalkAction[81]
		}
	},
	[28596007] = {
		28596007,
		0,
		Lang.get(117142),
		28596,
		7,
		1306,
		{
			RTResTalkAction[81]
		}
	},
	[28596008] = {
		28596008,
		0,
		Lang.get(117143),
		28596,
		8,
		1306,
		{
			RTResTalkAction[81]
		}
	},
	[28596009] = {
		28596009,
		4,
		nil,
		28596,
		9,
		1306,
		{
			RTResTalkAction[81]
		},
		[29] = {
			{
				id = 28596010,
				branch_content = Lang.get(117144)
			}
		}
	},
	[28596010] = {
		28596010,
		0,
		Lang.get(117145),
		28596,
		10,
		1306,
		{
			RTResTalkAction[81]
		}
	},
	[28597001] = {
		28597001,
		0,
		Lang.get(117146),
		28597,
		1,
		1306,
		{
			RTResTalkAction[81]
		},
		nil,
		nil,
		3,
		nil,
		62,
		28590,
		nil,
		nil,
		nil,
		nil,
		nil,
		28590
	},
	[28597002] = {
		28597002,
		0,
		Lang.get(117147),
		28597,
		2,
		1306,
		{
			RTResTalkAction[81]
		}
	},
	[28597003] = {
		28597003,
		4,
		nil,
		28597,
		3,
		1306,
		{
			RTResTalkAction[81]
		},
		[29] = {
			{
				id = 28597004,
				branch_content = Lang.get(117148)
			}
		}
	},
	[28597004] = {
		28597004,
		0,
		Lang.get(117149),
		28597,
		4,
		1306,
		{
			RTResTalkAction[81]
		}
	},
	[28597005] = {
		28597005,
		0,
		Lang.get(117150),
		28597,
		5,
		1306,
		{
			RTResTalkAction[81]
		}
	},
	[28597006] = {
		28597006,
		0,
		Lang.get(117151),
		28597,
		6,
		1306,
		{
			RTResTalkAction[81]
		}
	},
	[28597007] = {
		28597007,
		4,
		nil,
		28597,
		7,
		1306,
		{
			RTResTalkAction[81]
		},
		[29] = {
			{
				id = 28597008,
				branch_content = Lang.get(117152)
			}
		}
	},
	[28597008] = {
		28597008,
		0,
		Lang.get(117153),
		28597,
		8,
		1306,
		{
			RTResTalkAction[81]
		}
	},
	[28597009] = {
		28597009,
		4,
		nil,
		28597,
		9,
		1306,
		{
			RTResTalkAction[81]
		},
		[29] = {
			{
				id = 28597010,
				branch_content = Lang.get(117154)
			},
			{
				id = 28597010,
				branch_content = Lang.get(117155)
			}
		}
	},
	[28597010] = {
		28597010,
		0,
		Lang.get(117156),
		28597,
		10,
		1306,
		{
			RTResTalkAction[81]
		}
	},
	[28597011] = {
		28597011,
		0,
		Lang.get(117157),
		28597,
		11,
		1306,
		{
			RTResTalkAction[81]
		}
	},
	[28598001] = {
		28598001,
		0,
		Lang.get(117158),
		28598,
		1,
		1306,
		{
			RTResTalkAction[81]
		},
		nil,
		nil,
		3,
		nil,
		62,
		28590,
		nil,
		nil,
		nil,
		nil,
		nil,
		28590
	},
	[28598002] = {
		28598002,
		0,
		Lang.get(117159),
		28598,
		2,
		1306,
		{
			RTResTalkAction[81]
		}
	},
	[28598003] = {
		28598003,
		4,
		nil,
		28598,
		3,
		1306,
		{
			RTResTalkAction[81]
		},
		[29] = {
			{
				id = 28598004,
				branch_content = Lang.get(117160)
			},
			{
				id = 28598004,
				branch_content = Lang.get(117161)
			}
		}
	},
	[28598004] = {
		28598004,
		0,
		Lang.get(117162),
		28598,
		4,
		1306,
		{
			RTResTalkAction[81]
		}
	},
	[28598005] = {
		28598005,
		0,
		Lang.get(117163),
		28598,
		5,
		1306,
		{
			RTResTalkAction[81]
		}
	},
	[28598006] = {
		28598006,
		4,
		nil,
		28598,
		6,
		1306,
		{
			RTResTalkAction[81]
		},
		[29] = {
			{
				id = 28598007,
				branch_content = Lang.get(117164)
			}
		}
	},
	[28598007] = {
		28598007,
		0,
		Lang.get(117165),
		28598,
		7,
		1306,
		{
			RTResTalkAction[81]
		}
	},
	[28598008] = {
		28598008,
		0,
		Lang.get(117166),
		28598,
		8,
		1306,
		{
			RTResTalkAction[81]
		}
	},
	[28598009] = {
		28598009,
		4,
		nil,
		28598,
		9,
		1306,
		{
			RTResTalkAction[81]
		},
		[29] = {
			{
				id = 28598010,
				branch_content = Lang.get(117167)
			}
		}
	},
	[28598010] = {
		28598010,
		0,
		Lang.get(117168),
		28598,
		10,
		1306,
		{
			RTResTalkAction[81]
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
