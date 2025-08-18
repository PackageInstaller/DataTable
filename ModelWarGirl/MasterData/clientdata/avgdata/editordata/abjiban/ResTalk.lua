-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\abjiban\\ResTalk.lua

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
	1238,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[2] = {
	[1] = 1,
	[2] = 1238
}
RTResTalkAction[3] = {
	[1] = 1,
	[2] = 1238,
	[3] = {
		1
	}
}
RTResTalkAction[4] = {
	[1] = 0,
	[2] = 1238
}
RTResTalkAction[5] = {
	1,
	1238,
	nil,
	nil,
	0
}
RTResTalkAction[6] = {
	1,
	1238,
	nil,
	nil,
	3
}
RTResTalkAction[7] = {
	1,
	1238,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[8] = {
	1,
	1238,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[9] = {
	1,
	1240,
	nil,
	nil,
	0
}
RTResTalkAction[10] = {
	[1] = 1,
	[2] = 1240
}
RTResTalkAction[11] = {
	1,
	1240,
	nil,
	nil,
	3
}
RTResTalkAction[12] = {
	1,
	1240,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[13] = {
	[1] = 0,
	[2] = 1240
}
RTResTalkAction[14] = {
	1,
	1240,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[15] = {
	1,
	1240,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[16] = {
	1,
	1240,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[17] = {
	1,
	1240,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[18] = {
	1,
	1240,
	nil,
	nil,
	1
}
RTResTalkAction[19] = {
	1,
	1240,
	nil,
	nil,
	2
}
RTResTalkAction[20] = {
	[1] = 1,
	[2] = 1240,
	[3] = {
		2
	}
}

local Data = {
	[37901001] = {
		37901001,
		0,
		"……",
		37901,
		1,
		1238,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3,
		nil,
		8,
		37901,
		nil,
		nil,
		nil,
		nil,
		nil,
		37901
	},
	[37901002] = {
		37901002,
		0,
		Lang.get(100657),
		37901,
		2,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[37901003] = {
		37901003,
		0,
		Lang.get(100658),
		37901,
		3,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[37901004] = {
		37901004,
		0,
		"……",
		37901,
		4,
		1238,
		{
			RTResTalkAction[3]
		}
	},
	[37901005] = {
		37901005,
		0,
		Lang.get(100659),
		37901,
		5,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[37901006] = {
		37901006,
		0,
		Lang.get(100660),
		37901,
		6,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[37901007] = {
		37901007,
		0,
		Lang.get(100661),
		37901,
		7,
		1238,
		{
			RTResTalkAction[3]
		}
	},
	[37901008] = {
		37901008,
		0,
		"？",
		37901,
		8,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[37901009] = {
		37901009,
		3,
		Lang.get(85710),
		37901,
		9,
		605,
		{
			RTResTalkAction[4]
		},
		[22] = 1,
		[20] = 255
	},
	[37901010] = {
		37901010,
		0,
		Lang.get(100662),
		37901,
		10,
		1238,
		{
			RTResTalkAction[5]
		},
		[20] = -1
	},
	[37901011] = {
		37901011,
		0,
		Lang.get(100663),
		37901,
		11,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[37901012] = {
		37901012,
		0,
		Lang.get(100664),
		37901,
		12,
		1238,
		{
			RTResTalkAction[2]
		}
	},
	[37901013] = {
		37901013,
		4,
		nil,
		37901,
		13,
		300,
		{
			RTResTalkAction[2]
		},
		[29] = {
			{
				id = 37901014,
				branch_content = Lang.get(100665)
			},
			{
				id = 37901014,
				branch_content = Lang.get(100666)
			}
		}
	},
	[37901014] = {
		37901014,
		0,
		Lang.get(100667),
		37901,
		14,
		1238,
		{
			RTResTalkAction[2]
		}
	},
	[37901015] = {
		37901015,
		0,
		Lang.get(100668),
		37901,
		15,
		1238,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		nil,
		nil,
		60
	},
	[37901016] = {
		37901016,
		0,
		Lang.get(100669),
		37901,
		16,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[37901017] = {
		37901017,
		0,
		Lang.get(100670),
		37901,
		17,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[37901018] = {
		37901018,
		0,
		Lang.get(100671),
		37901,
		18,
		1238,
		{
			RTResTalkAction[2]
		}
	},
	[37901019] = {
		37901019,
		4,
		nil,
		37901,
		19,
		300,
		{
			RTResTalkAction[2]
		},
		[29] = {
			{
				id = 37901020,
				branch_content = Lang.get(100672)
			},
			{
				id = 37901020,
				branch_content = Lang.get(100673)
			}
		}
	},
	[37901020] = {
		37901020,
		0,
		Lang.get(100674),
		37901,
		20,
		1238,
		{
			RTResTalkAction[6]
		}
	},
	[37901021] = {
		37901021,
		0,
		Lang.get(100675),
		37901,
		21,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[37902001] = {
		37902001,
		0,
		Lang.get(100676),
		37902,
		1,
		1238,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3,
		nil,
		62,
		37902,
		nil,
		nil,
		nil,
		nil,
		nil,
		37902
	},
	[37902002] = {
		37902002,
		0,
		Lang.get(65381),
		37902,
		2,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[37902003] = {
		37902003,
		0,
		Lang.get(100677),
		37902,
		3,
		1238,
		{
			RTResTalkAction[2]
		}
	},
	[37902004] = {
		37902004,
		0,
		Lang.get(100678),
		37902,
		4,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[37902005] = {
		37902005,
		0,
		Lang.get(100679),
		37902,
		5,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[37902006] = {
		37902006,
		0,
		Lang.get(100680),
		37902,
		6,
		1238,
		{
			RTResTalkAction[2]
		}
	},
	[37902007] = {
		37902007,
		0,
		Lang.get(100681),
		37902,
		7,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[37902008] = {
		37902008,
		0,
		"……",
		37902,
		8,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[37902009] = {
		37902009,
		0,
		Lang.get(100682),
		37902,
		9,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[37902010] = {
		37902010,
		0,
		Lang.get(100683),
		37902,
		10,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[37902011] = {
		37902011,
		0,
		Lang.get(100684),
		37902,
		11,
		1238,
		{
			RTResTalkAction[2]
		}
	},
	[37902012] = {
		37902012,
		0,
		Lang.get(100685),
		37902,
		12,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[37902013] = {
		37902013,
		0,
		Lang.get(19271),
		37902,
		13,
		1238,
		{
			RTResTalkAction[2]
		}
	},
	[37902014] = {
		37902014,
		0,
		Lang.get(100686),
		37902,
		14,
		1238,
		{
			RTResTalkAction[6]
		}
	},
	[37902015] = {
		37902015,
		4,
		nil,
		37902,
		15,
		300,
		{
			RTResTalkAction[2]
		},
		[29] = {
			{
				id = 37902016,
				branch_content = Lang.get(100687)
			},
			{
				id = 37902016,
				branch_content = Lang.get(100688)
			}
		}
	},
	[37902016] = {
		37902016,
		0,
		Lang.get(100689),
		37902,
		16,
		1238,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		nil,
		nil,
		60,
		nil,
		1
	},
	[37902017] = {
		37902017,
		0,
		Lang.get(100690),
		37902,
		17,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[37903001] = {
		37903001,
		0,
		Lang.get(100691),
		37903,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		203,
		37903,
		[19] = 37903
	},
	[37903002] = {
		37903002,
		0,
		Lang.get(100692),
		37903,
		2,
		1238,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		3
	},
	[37903003] = {
		37903003,
		0,
		Lang.get(100693),
		37903,
		3,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[37903004] = {
		37903004,
		0,
		Lang.get(100694),
		37903,
		4,
		1238,
		{
			RTResTalkAction[2]
		}
	},
	[37903005] = {
		37903005,
		0,
		Lang.get(100695),
		37903,
		5,
		1238,
		{
			RTResTalkAction[3]
		}
	},
	[37903006] = {
		37903006,
		0,
		Lang.get(100696),
		37903,
		6,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[37903007] = {
		37903007,
		0,
		Lang.get(100697),
		37903,
		7,
		1238,
		{
			RTResTalkAction[2]
		}
	},
	[37903008] = {
		37903008,
		0,
		Lang.get(100698),
		37903,
		8,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[37903009] = {
		37903009,
		0,
		Lang.get(100699),
		37903,
		9,
		1238,
		{
			RTResTalkAction[2]
		}
	},
	[37903010] = {
		37903010,
		0,
		Lang.get(100700),
		37903,
		10,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[37903011] = {
		37903011,
		0,
		"……",
		37903,
		11,
		1238,
		{
			RTResTalkAction[2]
		}
	},
	[37903012] = {
		37903012,
		0,
		Lang.get(21987),
		37903,
		12,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[37903013] = {
		37903013,
		0,
		Lang.get(100701),
		37903,
		13,
		1238,
		{
			RTResTalkAction[8]
		}
	},
	[37903014] = {
		37903014,
		0,
		Lang.get(100702),
		37903,
		14,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[37903015] = {
		37903015,
		0,
		Lang.get(100703),
		37903,
		15,
		1238,
		{
			RTResTalkAction[6]
		}
	},
	[37904001] = {
		37904001,
		0,
		Lang.get(100704),
		37904,
		1,
		1240,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3,
		nil,
		8,
		37904,
		nil,
		nil,
		nil,
		nil,
		nil,
		37904
	},
	[37904002] = {
		37904002,
		0,
		Lang.get(100705),
		37904,
		2,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[37904003] = {
		37904003,
		0,
		Lang.get(100706),
		37904,
		3,
		1240,
		{
			RTResTalkAction[11]
		}
	},
	[37904004] = {
		37904004,
		4,
		nil,
		37904,
		4,
		300,
		{
			RTResTalkAction[10]
		},
		[29] = {
			{
				id = 37904005,
				branch_content = Lang.get(100705)
			},
			{
				id = 37904005,
				branch_content = Lang.get(35133)
			}
		}
	},
	[37904005] = {
		37904005,
		0,
		Lang.get(100707),
		37904,
		5,
		1240,
		{
			RTResTalkAction[12]
		}
	},
	[37904006] = {
		37904006,
		0,
		Lang.get(100708),
		37904,
		6,
		1240,
		{
			RTResTalkAction[10]
		}
	},
	[37904007] = {
		37904007,
		0,
		Lang.get(100709),
		37904,
		7,
		300,
		{
			RTResTalkAction[13]
		}
	},
	[37904008] = {
		37904008,
		0,
		Lang.get(100710),
		37904,
		8,
		1240,
		{
			RTResTalkAction[10]
		}
	},
	[37904009] = {
		37904009,
		0,
		Lang.get(100711),
		37904,
		9,
		300,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		37905,
		1,
		1,
		nil,
		1,
		nil,
		37905
	},
	[37904010] = {
		37904010,
		0,
		Lang.get(100712),
		37904,
		10,
		1240,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[37904011] = {
		37904011,
		0,
		Lang.get(100713),
		37904,
		11,
		300,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		37906,
		1,
		1,
		nil,
		1,
		nil,
		37906
	},
	[37904012] = {
		37904012,
		0,
		Lang.get(100714),
		37904,
		12,
		1240,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[37904013] = {
		37904013,
		0,
		Lang.get(100715),
		37904,
		13,
		300,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		37907,
		1,
		1,
		nil,
		1,
		nil,
		37907
	},
	[37904014] = {
		37904014,
		0,
		Lang.get(100716),
		37904,
		14,
		1240,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3
	},
	[37904015] = {
		37904015,
		0,
		Lang.get(100717),
		37904,
		15,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[37904016] = {
		37904016,
		0,
		Lang.get(100718),
		37904,
		16,
		1240,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		nil,
		nil,
		158,
		nil,
		1
	},
	[37904017] = {
		37904017,
		0,
		Lang.get(100719),
		37904,
		17,
		1240,
		{
			RTResTalkAction[15]
		}
	},
	[37904018] = {
		37904018,
		0,
		Lang.get(100720),
		37904,
		18,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[37904019] = {
		37904019,
		5,
		Lang.get(100721),
		37904,
		19,
		1240,
		{
			RTResTalkAction[16]
		}
	},
	[37905001] = {
		37905001,
		0,
		Lang.get(100722),
		37905,
		1,
		1240,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3,
		nil,
		62,
		37908,
		nil,
		nil,
		nil,
		nil,
		nil,
		37908
	},
	[37905002] = {
		37905002,
		0,
		Lang.get(100723),
		37905,
		2,
		1240,
		{
			RTResTalkAction[10]
		}
	},
	[37905003] = {
		37905003,
		4,
		nil,
		37905,
		3,
		300,
		{
			RTResTalkAction[10]
		},
		[29] = {
			{
				id = 37905004,
				branch_content = Lang.get(24055)
			},
			{
				id = 37905004,
				branch_content = Lang.get(100724)
			}
		}
	},
	[37905004] = {
		37905004,
		0,
		Lang.get(100725),
		37905,
		4,
		1240,
		{
			RTResTalkAction[15]
		},
		nil,
		nil,
		nil,
		nil,
		148
	},
	[37905005] = {
		37905005,
		0,
		Lang.get(100726),
		37905,
		5,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[37905006] = {
		37905006,
		3,
		Lang.get(85710),
		37905,
		6,
		605,
		{
			RTResTalkAction[10]
		},
		[22] = 1,
		[20] = 255
	},
	[37905007] = {
		37905007,
		0,
		Lang.get(100727),
		37905,
		7,
		1240,
		{
			RTResTalkAction[10]
		},
		[20] = -1
	},
	[37905008] = {
		37905008,
		0,
		Lang.get(100728),
		37905,
		8,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[37905009] = {
		37905009,
		5,
		Lang.get(100729),
		37905,
		9,
		1240,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		nil,
		1,
		1,
		nil,
		1,
		nil,
		37909
	},
	[37905010] = {
		37905010,
		0,
		Lang.get(100730),
		37905,
		10,
		300,
		{
			RTResTalkAction[18]
		}
	},
	[37905011] = {
		37905011,
		5,
		Lang.get(100731),
		37905,
		11,
		1240,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		nil,
		1,
		1,
		nil,
		1,
		nil,
		37910
	},
	[37905012] = {
		37905012,
		0,
		Lang.get(100732),
		37905,
		12,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[37905013] = {
		37905013,
		0,
		Lang.get(100733),
		37905,
		13,
		1240,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		nil,
		2748
	},
	[37905014] = {
		37905014,
		4,
		nil,
		37905,
		14,
		300,
		{
			RTResTalkAction[10]
		},
		[29] = {
			{
				id = 37905015,
				branch_content = Lang.get(100734)
			},
			{
				id = 37905015,
				branch_content = Lang.get(100735)
			}
		}
	},
	[37905015] = {
		37905015,
		0,
		Lang.get(100736),
		37905,
		15,
		1240,
		{
			RTResTalkAction[11]
		}
	},
	[37905016] = {
		37905016,
		0,
		Lang.get(100737),
		37905,
		16,
		1240,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		nil,
		nil,
		60
	},
	[37905017] = {
		37905017,
		0,
		Lang.get(100738),
		37905,
		17,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[37905018] = {
		37905018,
		0,
		Lang.get(100739),
		37905,
		18,
		1240,
		{
			RTResTalkAction[12]
		}
	},
	[37905019] = {
		37905019,
		0,
		Lang.get(100740),
		37905,
		19,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[37906001] = {
		37906001,
		0,
		Lang.get(100042),
		37906,
		1,
		1240,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3,
		nil,
		203,
		37911,
		nil,
		nil,
		nil,
		nil,
		nil,
		37911
	},
	[37906002] = {
		37906002,
		0,
		Lang.get(100741),
		37906,
		2,
		300,
		{
			RTResTalkAction[11]
		}
	},
	[37906003] = {
		37906003,
		0,
		Lang.get(100742),
		37906,
		3,
		1240,
		{
			RTResTalkAction[11]
		}
	},
	[37906004] = {
		37906004,
		0,
		Lang.get(100743),
		37906,
		4,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[37906005] = {
		37906005,
		0,
		Lang.get(100744),
		37906,
		5,
		1240,
		{
			RTResTalkAction[9]
		}
	},
	[37906006] = {
		37906006,
		0,
		Lang.get(24458),
		37906,
		6,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[37906007] = {
		37906007,
		0,
		Lang.get(100745),
		37906,
		7,
		1240,
		{
			RTResTalkAction[11]
		}
	},
	[37906008] = {
		37906008,
		4,
		nil,
		37906,
		8,
		300,
		{
			RTResTalkAction[10]
		},
		[29] = {
			{
				id = 37906009,
				branch_content = Lang.get(100746)
			},
			{
				id = 37906009,
				branch_content = Lang.get(100747)
			}
		}
	},
	[37906009] = {
		37906009,
		0,
		Lang.get(100748),
		37906,
		9,
		1240,
		{
			RTResTalkAction[18]
		}
	},
	[37906010] = {
		37906010,
		0,
		Lang.get(100749),
		37906,
		10,
		1240,
		{
			RTResTalkAction[11]
		}
	},
	[37906011] = {
		37906011,
		4,
		nil,
		37906,
		11,
		300,
		{
			RTResTalkAction[10]
		},
		[29] = {
			{
				id = 37906012,
				branch_content = Lang.get(100750)
			},
			{
				id = 37906012,
				branch_content = Lang.get(100751)
			}
		}
	},
	[37906012] = {
		37906012,
		0,
		Lang.get(100752),
		37906,
		12,
		1240,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[37906013] = {
		37906013,
		0,
		Lang.get(100753),
		37906,
		13,
		1240,
		{
			RTResTalkAction[15]
		}
	},
	[37906014] = {
		37906014,
		0,
		Lang.get(100754),
		37906,
		14,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[37906015] = {
		37906015,
		0,
		Lang.get(100755),
		37906,
		15,
		1240,
		{
			RTResTalkAction[9]
		}
	},
	[37906016] = {
		37906016,
		0,
		Lang.get(100756),
		37906,
		16,
		1240,
		{
			RTResTalkAction[20]
		}
	},
	[37906017] = {
		37906017,
		0,
		Lang.get(100726),
		37906,
		17,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[37906018] = {
		37906018,
		0,
		Lang.get(100757),
		37906,
		18,
		1240,
		{
			RTResTalkAction[19]
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
