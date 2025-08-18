-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\WhiteSnake_yure\\ResTalk.lua

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
	[2] = 292
}
RTResTalkAction[2] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[3] = {
	[1] = 3,
	[2] = 292
}
RTResTalkAction[4] = {
	3,
	292,
	nil,
	nil,
	2
}
RTResTalkAction[5] = {
	3,
	292,
	nil,
	nil,
	1
}
RTResTalkAction[6] = {
	3,
	292,
	nil,
	nil,
	0
}
RTResTalkAction[7] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[8] = {
	[1] = 2,
	[2] = 292
}
RTResTalkAction[9] = {
	[1] = 3,
	[2] = 133
}
RTResTalkAction[10] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[11] = {
	[1] = 0,
	[2] = 292
}
RTResTalkAction[12] = {
	[1] = 0,
	[2] = 133
}
RTResTalkAction[13] = {
	1,
	107,
	nil,
	nil,
	5
}
RTResTalkAction[14] = {
	1,
	107,
	nil,
	nil,
	1
}
RTResTalkAction[15] = {
	1,
	107,
	nil,
	nil,
	0
}
RTResTalkAction[16] = {
	[1] = 1,
	[2] = 1197
}
RTResTalkAction[17] = {
	[1] = 2,
	[2] = 1197
}
RTResTalkAction[18] = {
	[1] = 0,
	[2] = 1197
}
RTResTalkAction[19] = {
	[1] = 1,
	[2] = 1196
}
RTResTalkAction[20] = {
	[1] = 2,
	[2] = 1196
}
RTResTalkAction[21] = {
	[1] = 3,
	[2] = 1197
}
RTResTalkAction[22] = {
	[1] = 0,
	[2] = 1196
}

local Data = {
	[35901001] = {
		35901001,
		0,
		Lang.get(93752),
		35901,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		35901,
		nil,
		1,
		nil,
		1,
		nil,
		35901
	},
	[35901002] = {
		35901002,
		0,
		Lang.get(93753),
		35901,
		2,
		292,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[35901003] = {
		35901003,
		0,
		Lang.get(93754),
		35901,
		3,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[35901004] = {
		35901004,
		0,
		Lang.get(93755),
		35901,
		4,
		292,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[35901005] = {
		35901005,
		0,
		Lang.get(93756),
		35901,
		5,
		292,
		{
			RTResTalkAction[2],
			RTResTalkAction[4]
		}
	},
	[35901006] = {
		35901006,
		0,
		Lang.get(93757),
		35901,
		6,
		292,
		{
			RTResTalkAction[2],
			RTResTalkAction[5]
		}
	},
	[35901007] = {
		35901007,
		0,
		Lang.get(93758),
		35901,
		7,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[35901008] = {
		35901008,
		0,
		Lang.get(93759),
		35901,
		8,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[35901009] = {
		35901009,
		0,
		Lang.get(93760),
		35901,
		9,
		292,
		{
			RTResTalkAction[2],
			RTResTalkAction[6]
		}
	},
	[35901010] = {
		35901010,
		0,
		Lang.get(93761),
		35901,
		10,
		292,
		{
			RTResTalkAction[1],
			RTResTalkAction[7]
		}
	},
	[35901011] = {
		35901011,
		0,
		Lang.get(93762),
		35901,
		11,
		133,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[35901012] = {
		35901012,
		0,
		Lang.get(93763),
		35901,
		12,
		133,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[35901013] = {
		35901013,
		0,
		Lang.get(93764),
		35901,
		13,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[35901014] = {
		35901014,
		0,
		Lang.get(93765),
		35901,
		14,
		292,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[35901015] = {
		35901015,
		0,
		Lang.get(93766),
		35901,
		15,
		292,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[35901016] = {
		35901016,
		0,
		Lang.get(93767),
		35901,
		16,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[35901017] = {
		35901017,
		0,
		Lang.get(93768),
		35901,
		17,
		107,
		{
			RTResTalkAction[13],
			RTResTalkAction[11]
		}
	},
	[35902001] = {
		35902001,
		0,
		Lang.get(93769),
		35902,
		1,
		1197,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		35902,
		nil,
		1,
		nil,
		1,
		nil,
		35902
	},
	[35902002] = {
		35902002,
		0,
		Lang.get(93770),
		35902,
		2,
		107,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[35902003] = {
		35902003,
		0,
		Lang.get(93771),
		35902,
		3,
		107,
		{
			RTResTalkAction[15]
		}
	},
	[35902004] = {
		35902004,
		0,
		Lang.get(93772),
		35902,
		4,
		1197,
		{
			RTResTalkAction[16],
			RTResTalkAction[7]
		}
	},
	[35902005] = {
		35902005,
		0,
		Lang.get(93773),
		35902,
		5,
		292,
		{
			RTResTalkAction[17],
			RTResTalkAction[4]
		}
	},
	[35902006] = {
		35902006,
		0,
		Lang.get(93774),
		35902,
		6,
		292,
		{
			RTResTalkAction[17],
			RTResTalkAction[6]
		}
	},
	[35902007] = {
		35902007,
		0,
		Lang.get(93775),
		35902,
		7,
		292,
		{
			RTResTalkAction[1],
			RTResTalkAction[18]
		}
	},
	[35902008] = {
		35902008,
		0,
		Lang.get(93776),
		35902,
		8,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[35902009] = {
		35902009,
		0,
		Lang.get(93777),
		35902,
		9,
		292,
		{
			RTResTalkAction[2],
			RTResTalkAction[5]
		}
	},
	[35902010] = {
		35902010,
		0,
		Lang.get(93778),
		35902,
		10,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[35902011] = {
		35902011,
		0,
		Lang.get(93779),
		35902,
		11,
		1197,
		{
			RTResTalkAction[16],
			RTResTalkAction[7],
			RTResTalkAction[11]
		}
	},
	[35902012] = {
		35902012,
		0,
		Lang.get(93780),
		35902,
		12,
		292,
		{
			RTResTalkAction[17],
			RTResTalkAction[6]
		}
	},
	[35902013] = {
		35902013,
		0,
		Lang.get(93781),
		35902,
		13,
		292,
		{
			RTResTalkAction[17],
			RTResTalkAction[3]
		}
	},
	[35902014] = {
		35902014,
		0,
		Lang.get(93782),
		35902,
		14,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[18],
			RTResTalkAction[11]
		}
	},
	[35902015] = {
		35902015,
		0,
		Lang.get(93783),
		35902,
		15,
		292,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[35902016] = {
		35902016,
		0,
		Lang.get(93784),
		35902,
		16,
		292,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[35902017] = {
		35902017,
		0,
		Lang.get(93785),
		35902,
		17,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[35902018] = {
		35902018,
		0,
		Lang.get(93786),
		35902,
		18,
		292,
		{
			RTResTalkAction[1],
			RTResTalkAction[7]
		}
	},
	[35903001] = {
		35903001,
		0,
		Lang.get(93787),
		35903,
		1,
		1196,
		nil,
		1,
		nil,
		nil,
		nil,
		199,
		35903,
		nil,
		1,
		nil,
		1,
		nil,
		35903
	},
	[35903002] = {
		35903002,
		0,
		Lang.get(93788),
		35903,
		2,
		1197,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		3
	},
	[35903003] = {
		35903003,
		0,
		Lang.get(93789),
		35903,
		3,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[18]
		}
	},
	[35903004] = {
		35903004,
		0,
		Lang.get(93790),
		35903,
		4,
		107,
		{
			RTResTalkAction[10]
		}
	},
	[35903005] = {
		35903005,
		0,
		Lang.get(93791),
		35903,
		5,
		292,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[35903006] = {
		35903006,
		0,
		Lang.get(93792),
		35903,
		6,
		292,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[35903007] = {
		35903007,
		0,
		Lang.get(93793),
		35903,
		7,
		1197,
		{
			RTResTalkAction[7],
			RTResTalkAction[11]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		35904,
		nil,
		1,
		nil,
		1,
		nil,
		35904
	},
	[35903008] = {
		35903008,
		0,
		Lang.get(93794),
		35903,
		8,
		1196,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[35903009] = {
		35903009,
		0,
		Lang.get(93795),
		35903,
		9,
		1197,
		{
			RTResTalkAction[20],
			RTResTalkAction[21]
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
	[35903010] = {
		35903010,
		0,
		Lang.get(93796),
		35903,
		10,
		1196,
		{
			RTResTalkAction[20],
			RTResTalkAction[21]
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
	[35903011] = {
		35903011,
		0,
		Lang.get(93797),
		35903,
		11,
		1197,
		{
			RTResTalkAction[20],
			RTResTalkAction[21]
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
	[35903012] = {
		35903012,
		0,
		Lang.get(93798),
		35903,
		12,
		1197,
		{
			RTResTalkAction[20],
			RTResTalkAction[21]
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
	[35903013] = {
		35903013,
		0,
		Lang.get(93799),
		35903,
		13,
		1197,
		{
			RTResTalkAction[20],
			RTResTalkAction[21]
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
	[35903014] = {
		35903014,
		0,
		Lang.get(93800),
		35903,
		14,
		1196,
		{
			RTResTalkAction[19],
			RTResTalkAction[18]
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
	[35903015] = {
		35903015,
		0,
		Lang.get(93801),
		35903,
		15,
		810,
		{
			RTResTalkAction[22]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[35903016] = {
		35903016,
		0,
		Lang.get(93802),
		35903,
		16,
		1196,
		{
			RTResTalkAction[19]
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
	[35903017] = {
		35903017,
		0,
		Lang.get(93803),
		35903,
		17,
		1196,
		{
			RTResTalkAction[19]
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
	[35903018] = {
		35903018,
		0,
		Lang.get(93804),
		35903,
		18,
		810,
		{
			RTResTalkAction[22]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[35903019] = {
		35903019,
		0,
		Lang.get(93805),
		35903,
		19,
		292,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		35905,
		nil,
		1,
		nil,
		1,
		nil,
		35905
	},
	[35903020] = {
		35903020,
		0,
		Lang.get(93806),
		35903,
		20,
		1197,
		{
			RTResTalkAction[16]
		},
		nil,
		0,
		3
	},
	[35903021] = {
		35903021,
		0,
		Lang.get(93807),
		35903,
		21,
		1196,
		{
			RTResTalkAction[20],
			RTResTalkAction[21]
		}
	},
	[35903022] = {
		35903022,
		0,
		Lang.get(93808),
		35903,
		22,
		1196,
		{
			RTResTalkAction[20],
			RTResTalkAction[21]
		}
	},
	[35903023] = {
		35903023,
		0,
		Lang.get(93809),
		35903,
		23,
		1197,
		{
			RTResTalkAction[20],
			RTResTalkAction[21]
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
