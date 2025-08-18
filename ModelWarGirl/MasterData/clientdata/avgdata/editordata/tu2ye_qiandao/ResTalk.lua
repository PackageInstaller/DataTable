-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\tu2ye_qiandao\\ResTalk.lua

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
	[2] = 107
}
RTResTalkAction[2] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[3] = {
	[1] = 3,
	[2] = 133
}
RTResTalkAction[4] = {
	[1] = 1,
	[2] = 141
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[6] = {
	[1] = 0,
	[2] = 133
}
RTResTalkAction[7] = {
	[1] = 3,
	[2] = 141
}
RTResTalkAction[8] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[9] = {
	[1] = 1,
	[2] = 133
}
RTResTalkAction[10] = {
	[1] = 1,
	[2] = 424
}
RTResTalkAction[11] = {
	[1] = 0,
	[2] = 424
}
RTResTalkAction[12] = {
	[1] = 1,
	[2] = 143
}
RTResTalkAction[13] = {
	[1] = 0,
	[2] = 143
}
RTResTalkAction[14] = {
	[1] = 3,
	[2] = 143
}
RTResTalkAction[15] = {
	[1] = 1,
	[2] = 195
}
RTResTalkAction[16] = {
	[1] = 3,
	[2] = 195
}
RTResTalkAction[17] = {
	[1] = 0,
	[2] = 195
}
RTResTalkAction[18] = {
	1,
	195,
	nil,
	nil,
	2
}
RTResTalkAction[19] = {
	[1] = 1,
	[2] = 1071
}
RTResTalkAction[20] = {
	[1] = 3,
	[2] = 1071
}
RTResTalkAction[21] = {
	[1] = 0,
	[2] = 1071
}
RTResTalkAction[22] = {
	[1] = 1,
	[2] = 1171
}
RTResTalkAction[23] = {
	[1] = 1,
	[2] = 1170
}
RTResTalkAction[24] = {
	[1] = 0,
	[2] = 1171
}
RTResTalkAction[25] = {
	[1] = 2,
	[2] = 1170
}
RTResTalkAction[26] = {
	[1] = 3,
	[2] = 1073
}
RTResTalkAction[27] = {
	[1] = 0,
	[2] = 1170
}
RTResTalkAction[28] = {
	[1] = 0,
	[2] = 1073
}
RTResTalkAction[29] = {
	[1] = 1,
	[2] = 1073
}

local Data = {
	[35021001] = {
		35021001,
		3,
		Lang.get(91088),
		35021,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		35021,
		nil,
		1,
		nil,
		1,
		nil,
		35021,
		nil,
		nil,
		1
	},
	[35021002] = {
		35021002,
		0,
		Lang.get(91089),
		35021,
		2,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[35021003] = {
		35021003,
		0,
		Lang.get(91090),
		35021,
		3,
		133,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[35021004] = {
		35021004,
		0,
		Lang.get(91091),
		35021,
		4,
		141,
		{
			RTResTalkAction[4],
			RTResTalkAction[5],
			RTResTalkAction[6]
		}
	},
	[35021005] = {
		35021005,
		0,
		Lang.get(91092),
		35021,
		5,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[7]
		}
	},
	[35021006] = {
		35021006,
		0,
		Lang.get(91093),
		35021,
		6,
		424,
		{
			RTResTalkAction[5],
			RTResTalkAction[8]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		35022,
		nil,
		1,
		nil,
		1,
		nil,
		35022
	},
	[35021007] = {
		35021007,
		0,
		Lang.get(91094),
		35021,
		7,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[35021008] = {
		35021008,
		0,
		Lang.get(91095),
		35021,
		8,
		133,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[35021009] = {
		35021009,
		0,
		Lang.get(91096),
		35021,
		9,
		133,
		{
			RTResTalkAction[9],
			RTResTalkAction[5]
		}
	},
	[35021010] = {
		35021010,
		0,
		Lang.get(91097),
		35021,
		10,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[35021011] = {
		35021011,
		0,
		Lang.get(91098),
		35021,
		11,
		107,
		{
			RTResTalkAction[1]
		}
	},
	[35021012] = {
		35021012,
		0,
		Lang.get(91099),
		35021,
		12,
		107,
		{
			RTResTalkAction[1]
		}
	},
	[35021013] = {
		35021013,
		0,
		Lang.get(91100),
		35021,
		13,
		424,
		{
			RTResTalkAction[10],
			RTResTalkAction[5]
		}
	},
	[35021014] = {
		35021014,
		0,
		Lang.get(91101),
		35021,
		14,
		133,
		{
			RTResTalkAction[9],
			RTResTalkAction[11]
		}
	},
	[35021015] = {
		35021015,
		0,
		Lang.get(91102),
		35021,
		15,
		424,
		{
			RTResTalkAction[10],
			RTResTalkAction[6]
		}
	},
	[35021016] = {
		35021016,
		0,
		Lang.get(91103),
		35021,
		16,
		107,
		{
			RTResTalkAction[1],
			RTResTalkAction[11]
		}
	},
	[35021017] = {
		35021017,
		0,
		Lang.get(91104),
		35021,
		17,
		300,
		{
			RTResTalkAction[5]
		}
	},
	[35021018] = {
		35021018,
		0,
		Lang.get(91105),
		35021,
		18,
		107,
		{
			RTResTalkAction[1]
		}
	},
	[35021019] = {
		35021019,
		0,
		Lang.get(91106),
		35021,
		19,
		300,
		{
			RTResTalkAction[5]
		}
	},
	[35021020] = {
		35021020,
		0,
		Lang.get(91107),
		35021,
		20,
		424,
		{
			RTResTalkAction[10]
		}
	},
	[35022001] = {
		35022001,
		0,
		Lang.get(91108),
		35022,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		35023,
		nil,
		1,
		nil,
		1,
		nil,
		35023
	},
	[35022002] = {
		35022002,
		0,
		Lang.get(91109),
		35022,
		2,
		143,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		3
	},
	[35022003] = {
		35022003,
		0,
		Lang.get(91110),
		35022,
		3,
		300,
		{
			RTResTalkAction[13]
		}
	},
	[35022004] = {
		35022004,
		0,
		Lang.get(91111),
		35022,
		4,
		143,
		{
			RTResTalkAction[12]
		}
	},
	[35022005] = {
		35022005,
		0,
		Lang.get(91112),
		35022,
		5,
		300,
		{
			RTResTalkAction[13]
		}
	},
	[35022006] = {
		35022006,
		0,
		Lang.get(91113),
		35022,
		6,
		143,
		{
			RTResTalkAction[12]
		}
	},
	[35022007] = {
		35022007,
		0,
		Lang.get(91114),
		35022,
		7,
		143,
		{
			RTResTalkAction[12]
		}
	},
	[35022008] = {
		35022008,
		0,
		Lang.get(91115),
		35022,
		8,
		300,
		{
			RTResTalkAction[13]
		}
	},
	[35022009] = {
		35022009,
		0,
		Lang.get(91116),
		35022,
		9,
		424,
		{
			RTResTalkAction[10]
		}
	},
	[35022010] = {
		35022010,
		0,
		Lang.get(91117),
		35022,
		10,
		143,
		{
			RTResTalkAction[12],
			RTResTalkAction[11]
		}
	},
	[35022011] = {
		35022011,
		0,
		Lang.get(91118),
		35022,
		11,
		143,
		{
			RTResTalkAction[12]
		}
	},
	[35022012] = {
		35022012,
		0,
		Lang.get(91119),
		35022,
		12,
		143,
		{
			RTResTalkAction[12]
		}
	},
	[35022013] = {
		35022013,
		0,
		Lang.get(91120),
		35022,
		13,
		143,
		{
			RTResTalkAction[12]
		}
	},
	[35022014] = {
		35022014,
		0,
		Lang.get(91121),
		35022,
		14,
		300,
		{
			RTResTalkAction[13]
		}
	},
	[35022015] = {
		35022015,
		0,
		Lang.get(91122),
		35022,
		15,
		143,
		{
			RTResTalkAction[12]
		}
	},
	[35022016] = {
		35022016,
		0,
		Lang.get(91123),
		35022,
		16,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[14]
		}
	},
	[35022017] = {
		35022017,
		0,
		Lang.get(91124),
		35022,
		17,
		143,
		{
			RTResTalkAction[2],
			RTResTalkAction[14]
		}
	},
	[35022018] = {
		35022018,
		0,
		Lang.get(91125),
		35022,
		18,
		143,
		{
			RTResTalkAction[12],
			RTResTalkAction[5]
		}
	},
	[35023001] = {
		35023001,
		3,
		Lang.get(91126),
		35023,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		35024,
		nil,
		1,
		nil,
		1,
		nil,
		35024,
		nil,
		nil,
		1
	},
	[35023002] = {
		35023002,
		0,
		Lang.get(67902),
		35023,
		2,
		195,
		{
			RTResTalkAction[15]
		},
		nil,
		nil,
		3
	},
	[35023003] = {
		35023003,
		0,
		Lang.get(91127),
		35023,
		3,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[16]
		}
	},
	[35023004] = {
		35023004,
		0,
		Lang.get(91128),
		35023,
		4,
		300,
		{
			RTResTalkAction[5],
			RTResTalkAction[17]
		}
	},
	[35023005] = {
		35023005,
		0,
		Lang.get(91129),
		35023,
		5,
		195,
		{
			RTResTalkAction[15]
		}
	},
	[35023006] = {
		35023006,
		0,
		Lang.get(91130),
		35023,
		6,
		195,
		{
			RTResTalkAction[15]
		}
	},
	[35023007] = {
		35023007,
		0,
		Lang.get(91131),
		35023,
		7,
		300,
		{
			RTResTalkAction[17]
		}
	},
	[35023008] = {
		35023008,
		0,
		Lang.get(91132),
		35023,
		8,
		195,
		{
			RTResTalkAction[15]
		}
	},
	[35023009] = {
		35023009,
		0,
		Lang.get(91133),
		35023,
		9,
		300,
		{
			RTResTalkAction[17]
		}
	},
	[35023010] = {
		35023010,
		0,
		Lang.get(91134),
		35023,
		10,
		424,
		{
			RTResTalkAction[10]
		}
	},
	[35023011] = {
		35023011,
		0,
		Lang.get(91135),
		35023,
		11,
		195,
		{
			RTResTalkAction[15],
			RTResTalkAction[11]
		}
	},
	[35023012] = {
		35023012,
		0,
		Lang.get(91136),
		35023,
		12,
		300,
		{
			RTResTalkAction[17]
		}
	},
	[35023013] = {
		35023013,
		0,
		Lang.get(91137),
		35023,
		13,
		195,
		{
			RTResTalkAction[15]
		}
	},
	[35023014] = {
		35023014,
		0,
		Lang.get(91138),
		35023,
		14,
		195,
		{
			RTResTalkAction[18]
		}
	},
	[35023015] = {
		35023015,
		0,
		Lang.get(91139),
		35023,
		15,
		195,
		{
			RTResTalkAction[15]
		}
	},
	[35023016] = {
		35023016,
		0,
		Lang.get(91140),
		35023,
		16,
		300,
		{
			RTResTalkAction[17]
		}
	},
	[35023017] = {
		35023017,
		0,
		Lang.get(91141),
		35023,
		17,
		195,
		{
			RTResTalkAction[15]
		}
	},
	[35023018] = {
		35023018,
		0,
		Lang.get(91142),
		35023,
		18,
		300,
		{
			RTResTalkAction[17]
		}
	},
	[35023019] = {
		35023019,
		0,
		Lang.get(91143),
		35023,
		19,
		195,
		{
			RTResTalkAction[15]
		}
	},
	[35023020] = {
		35023020,
		0,
		Lang.get(91144),
		35023,
		20,
		300,
		{
			RTResTalkAction[17]
		}
	},
	[35023021] = {
		35023021,
		0,
		Lang.get(91145),
		35023,
		21,
		195,
		{
			RTResTalkAction[15]
		}
	},
	[35023022] = {
		35023022,
		0,
		Lang.get(91146),
		35023,
		22,
		195,
		{
			RTResTalkAction[15]
		}
	},
	[35024001] = {
		35024001,
		3,
		Lang.get(91147),
		35024,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		190,
		35025,
		nil,
		1,
		nil,
		1,
		nil,
		35025,
		nil,
		nil,
		1
	},
	[35024002] = {
		35024002,
		0,
		Lang.get(91148),
		35024,
		2,
		1071,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		3
	},
	[35024003] = {
		35024003,
		0,
		Lang.get(91149),
		35024,
		3,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[20]
		}
	},
	[35024004] = {
		35024004,
		0,
		Lang.get(91150),
		35024,
		4,
		300,
		{
			RTResTalkAction[5],
			RTResTalkAction[21]
		}
	},
	[35024005] = {
		35024005,
		0,
		Lang.get(91151),
		35024,
		5,
		1071,
		{
			RTResTalkAction[2],
			RTResTalkAction[20]
		}
	},
	[35024006] = {
		35024006,
		0,
		Lang.get(91152),
		35024,
		6,
		300,
		{
			RTResTalkAction[5],
			RTResTalkAction[21]
		}
	},
	[35024007] = {
		35024007,
		0,
		Lang.get(91153),
		35024,
		7,
		1071,
		{
			RTResTalkAction[2],
			RTResTalkAction[20]
		}
	},
	[35024008] = {
		35024008,
		0,
		Lang.get(91154),
		35024,
		8,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[20]
		}
	},
	[35024009] = {
		35024009,
		0,
		Lang.get(91155),
		35024,
		9,
		1071,
		{
			RTResTalkAction[19],
			RTResTalkAction[5]
		}
	},
	[35024010] = {
		35024010,
		0,
		Lang.get(91156),
		35024,
		10,
		424,
		{
			RTResTalkAction[10],
			RTResTalkAction[21]
		}
	},
	[35024011] = {
		35024011,
		0,
		Lang.get(91157),
		35024,
		11,
		1071,
		{
			RTResTalkAction[19],
			RTResTalkAction[11]
		}
	},
	[35024012] = {
		35024012,
		0,
		Lang.get(91158),
		35024,
		12,
		300,
		{
			RTResTalkAction[21]
		}
	},
	[35024013] = {
		35024013,
		0,
		Lang.get(85400),
		35024,
		13,
		1071,
		{
			RTResTalkAction[19]
		}
	},
	[35024014] = {
		35024014,
		0,
		Lang.get(85401),
		35024,
		14,
		300,
		{
			RTResTalkAction[21]
		}
	},
	[35024015] = {
		35024015,
		0,
		Lang.get(85402),
		35024,
		15,
		1071,
		{
			RTResTalkAction[19]
		}
	},
	[35024016] = {
		35024016,
		0,
		Lang.get(91159),
		35024,
		16,
		1071,
		{
			RTResTalkAction[19]
		}
	},
	[35025001] = {
		35025001,
		3,
		Lang.get(91160),
		35025,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		191,
		35026,
		nil,
		1,
		nil,
		1,
		nil,
		35026,
		nil,
		nil,
		1
	},
	[35025002] = {
		35025002,
		0,
		Lang.get(91161),
		35025,
		2,
		1171,
		{
			RTResTalkAction[22]
		},
		nil,
		nil,
		3
	},
	[35025003] = {
		35025003,
		0,
		Lang.get(91162),
		35025,
		3,
		1170,
		{
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[35025004] = {
		35025004,
		0,
		Lang.get(91163),
		35025,
		4,
		1073,
		{
			RTResTalkAction[25],
			RTResTalkAction[26]
		}
	},
	[35025005] = {
		35025005,
		0,
		Lang.get(91164),
		35025,
		5,
		107,
		{
			RTResTalkAction[1],
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[35025006] = {
		35025006,
		0,
		Lang.get(91165),
		35025,
		6,
		300,
		{
			RTResTalkAction[5]
		}
	},
	[35025007] = {
		35025007,
		0,
		Lang.get(91166),
		35025,
		7,
		424,
		{
			RTResTalkAction[10]
		}
	},
	[35025008] = {
		35025008,
		0,
		Lang.get(91167),
		35025,
		8,
		1171,
		{
			RTResTalkAction[22],
			RTResTalkAction[11]
		}
	},
	[35025009] = {
		35025009,
		0,
		Lang.get(91168),
		35025,
		9,
		1170,
		{
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[35025010] = {
		35025010,
		0,
		Lang.get(91169),
		35025,
		10,
		1073,
		{
			RTResTalkAction[25],
			RTResTalkAction[26]
		}
	},
	[35025011] = {
		35025011,
		0,
		Lang.get(91170),
		35025,
		11,
		1171,
		{
			RTResTalkAction[22],
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[35025012] = {
		35025012,
		0,
		Lang.get(91171),
		35025,
		12,
		1171,
		{
			RTResTalkAction[22]
		}
	},
	[35025013] = {
		35025013,
		0,
		Lang.get(91172),
		35025,
		13,
		1171,
		{
			RTResTalkAction[22]
		}
	},
	[35025014] = {
		35025014,
		0,
		Lang.get(91173),
		35025,
		14,
		1170,
		{
			RTResTalkAction[25],
			RTResTalkAction[26],
			RTResTalkAction[24]
		}
	},
	[35025015] = {
		35025015,
		0,
		Lang.get(91174),
		35025,
		15,
		1170,
		{
			RTResTalkAction[25],
			RTResTalkAction[26]
		}
	},
	[35025016] = {
		35025016,
		0,
		Lang.get(91175),
		35025,
		16,
		1073,
		{
			RTResTalkAction[25],
			RTResTalkAction[26]
		}
	},
	[35025017] = {
		35025017,
		0,
		Lang.get(85403),
		35025,
		17,
		1073,
		{
			RTResTalkAction[29],
			RTResTalkAction[27]
		}
	},
	[35025018] = {
		35025018,
		0,
		Lang.get(91176),
		35025,
		18,
		1073,
		{
			RTResTalkAction[29]
		}
	},
	[35025019] = {
		35025019,
		3,
		Lang.get(91177),
		35025,
		19,
		605,
		{
			RTResTalkAction[28]
		},
		[22] = 1
	},
	[35025020] = {
		35025020,
		3,
		Lang.get(91178),
		35025,
		20,
		605,
		[22] = 1
	},
	[35025021] = {
		35025021,
		11,
		"Videos/_lazy_/AVG_tu2ye.mp4",
		35025,
		21,
		605
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
