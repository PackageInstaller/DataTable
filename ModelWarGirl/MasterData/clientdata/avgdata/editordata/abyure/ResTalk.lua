-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\abyure\\ResTalk.lua

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
	1240,
	nil,
	nil,
	2
}
RTResTalkAction[2] = {
	1,
	1240,
	nil,
	nil,
	3
}
RTResTalkAction[3] = {
	[1] = 1,
	[2] = 1240
}
RTResTalkAction[4] = {
	1,
	1240,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 1240
}
RTResTalkAction[6] = {
	[1] = 2,
	[2] = 1240
}
RTResTalkAction[7] = {
	3,
	1238,
	nil,
	nil,
	0
}
RTResTalkAction[8] = {
	[1] = 3,
	[2] = 1238,
	[3] = {
		2
	}
}
RTResTalkAction[9] = {
	2,
	1240,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[10] = {
	[1] = 3,
	[2] = 1238
}
RTResTalkAction[11] = {
	2,
	1240,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[12] = {
	2,
	1240,
	nil,
	nil,
	0
}
RTResTalkAction[13] = {
	[1] = 0,
	[2] = 1238
}
RTResTalkAction[14] = {
	1,
	1238,
	nil,
	nil,
	0
}
RTResTalkAction[15] = {
	2,
	1240,
	nil,
	nil,
	3
}
RTResTalkAction[16] = {
	1,
	1133,
	nil,
	nil,
	0
}
RTResTalkAction[17] = {
	[1] = 1,
	[2] = 1133
}
RTResTalkAction[18] = {
	[1] = 1,
	[2] = 1133,
	[3] = {
		2
	}
}
RTResTalkAction[19] = {
	1,
	1239,
	nil,
	nil,
	1
}
RTResTalkAction[20] = {
	[1] = 2,
	[2] = 1132
}
RTResTalkAction[21] = {
	[1] = 3,
	[2] = 1239
}

local Data = {
	[36901001] = {
		36901001,
		0,
		Lang.get(99296),
		36901,
		1,
		1240,
		nil,
		1,
		3,
		nil,
		nil,
		194,
		36901,
		1,
		nil,
		nil,
		nil,
		nil,
		36901
	},
	[36901002] = {
		36901002,
		0,
		Lang.get(99297),
		36901,
		2,
		1240,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		36902,
		2,
		nil,
		nil,
		0,
		nil,
		36902
	},
	[36901003] = {
		36901003,
		0,
		Lang.get(99298),
		36901,
		3,
		1240,
		nil,
		1,
		1
	},
	[36901004] = {
		36901004,
		0,
		Lang.get(99299),
		36901,
		4,
		1240,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		36903,
		nil,
		nil,
		nil,
		0,
		nil,
		36903
	},
	[36901005] = {
		36901005,
		2,
		Lang.get(99300),
		36901,
		5,
		1240,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[36901006] = {
		36901006,
		2,
		Lang.get(99301),
		36901,
		6,
		1240,
		{
			RTResTalkAction[2]
		}
	},
	[36901007] = {
		36901007,
		2,
		Lang.get(99302),
		36901,
		7,
		1240,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		nil,
		nil,
		62
	},
	[36901008] = {
		36901008,
		0,
		Lang.get(99303),
		36901,
		8,
		1240,
		{
			RTResTalkAction[3]
		}
	},
	[36901009] = {
		36901009,
		5,
		Lang.get(99304),
		36901,
		9,
		1240,
		{
			RTResTalkAction[4]
		}
	},
	[36901010] = {
		36901010,
		3,
		Lang.get(85710),
		36901,
		10,
		605,
		{
			RTResTalkAction[5]
		},
		[22] = 1,
		[20] = 255
	},
	[36901011] = {
		36901011,
		0,
		Lang.get(99305),
		36901,
		11,
		1240,
		nil,
		1,
		2,
		-1,
		nil,
		nil,
		36904,
		1,
		1,
		nil,
		1,
		nil,
		36904,
		0
	},
	[36901012] = {
		36901012,
		0,
		Lang.get(99306),
		36901,
		12,
		1240,
		nil,
		1
	},
	[36901013] = {
		36901013,
		2,
		Lang.get(99307),
		36901,
		13,
		1240,
		nil,
		1,
		3
	},
	[36901014] = {
		36901014,
		0,
		Lang.get(99308),
		36901,
		14,
		1240,
		nil,
		1,
		1,
		nil,
		nil,
		57,
		36905,
		1,
		nil,
		nil,
		nil,
		nil,
		36905
	},
	[36901015] = {
		36901015,
		0,
		Lang.get(99309),
		36901,
		15,
		1240,
		nil,
		1,
		2,
		nil,
		2748
	},
	[36901016] = {
		36901016,
		0,
		Lang.get(99310),
		36901,
		16,
		1238,
		nil,
		1,
		0
	},
	[36901017] = {
		36901017,
		0,
		Lang.get(99311),
		36901,
		17,
		1240,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		36906,
		nil,
		nil,
		nil,
		nil,
		nil,
		36906
	},
	[36901018] = {
		36901018,
		0,
		Lang.get(99312),
		36901,
		18,
		1238,
		nil,
		1,
		0
	},
	[36901019] = {
		36901019,
		0,
		Lang.get(99313),
		36901,
		19,
		1240,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[36901020] = {
		36901020,
		0,
		Lang.get(99314),
		36901,
		20,
		1240,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		nil,
		nil,
		62
	},
	[36901021] = {
		36901021,
		0,
		Lang.get(99315),
		36901,
		21,
		1238,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[36901022] = {
		36901022,
		0,
		Lang.get(99316),
		36901,
		22,
		1238,
		{
			RTResTalkAction[6],
			RTResTalkAction[8]
		}
	},
	[36901023] = {
		36901023,
		0,
		Lang.get(25821),
		36901,
		23,
		1240,
		{
			RTResTalkAction[9],
			RTResTalkAction[10]
		}
	},
	[36902001] = {
		36902001,
		0,
		Lang.get(99317),
		36902,
		1,
		1240,
		nil,
		1,
		0,
		nil,
		nil,
		62,
		36910,
		nil,
		nil,
		nil,
		nil,
		nil,
		36910
	},
	[36902002] = {
		36902002,
		0,
		Lang.get(99318),
		36902,
		2,
		1240,
		nil,
		1
	},
	[36902003] = {
		36902003,
		0,
		Lang.get(38282),
		36902,
		3,
		1238,
		nil,
		1
	},
	[36902004] = {
		36902004,
		0,
		Lang.get(99319),
		36902,
		4,
		1240,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[36902005] = {
		36902005,
		0,
		Lang.get(99320),
		36902,
		5,
		1240,
		{
			RTResTalkAction[3]
		}
	},
	[36902006] = {
		36902006,
		0,
		Lang.get(99321),
		36902,
		6,
		1238,
		{
			RTResTalkAction[6],
			RTResTalkAction[10]
		}
	},
	[36902007] = {
		36902007,
		0,
		Lang.get(99322),
		36902,
		7,
		1240,
		{
			RTResTalkAction[6],
			RTResTalkAction[10]
		}
	},
	[36902008] = {
		36902008,
		0,
		Lang.get(99323),
		36902,
		8,
		1238,
		{
			RTResTalkAction[6],
			RTResTalkAction[10]
		}
	},
	[36902009] = {
		36902009,
		0,
		Lang.get(99324),
		36902,
		9,
		1240,
		{
			RTResTalkAction[11],
			RTResTalkAction[10]
		}
	},
	[36902010] = {
		36902010,
		0,
		Lang.get(99325),
		36902,
		10,
		1240,
		{
			RTResTalkAction[12],
			RTResTalkAction[10]
		}
	},
	[36902011] = {
		36902011,
		0,
		Lang.get(99326),
		36902,
		11,
		1238,
		{
			RTResTalkAction[5],
			RTResTalkAction[13]
		},
		1,
		0,
		-1,
		nil,
		122,
		36911,
		1,
		1,
		nil,
		1,
		nil,
		36911
	},
	[36902012] = {
		36902012,
		0,
		Lang.get(99327),
		36902,
		12,
		1238,
		nil,
		1
	},
	[36902013] = {
		36902013,
		0,
		Lang.get(99328),
		36902,
		13,
		1240,
		nil,
		1,
		1
	},
	[36902014] = {
		36902014,
		0,
		Lang.get(99329),
		36902,
		14,
		1238,
		nil,
		1,
		0
	},
	[36902015] = {
		36902015,
		0,
		Lang.get(99330),
		36902,
		15,
		1240,
		nil,
		1,
		3
	},
	[36902016] = {
		36902016,
		0,
		Lang.get(19271),
		36902,
		16,
		1238,
		nil,
		1,
		0
	},
	[36902017] = {
		36902017,
		0,
		Lang.get(99331),
		36902,
		17,
		1238,
		nil,
		1,
		0,
		nil,
		2752,
		nil,
		36912,
		nil,
		nil,
		nil,
		1,
		nil,
		36912
	},
	[36902018] = {
		36902018,
		0,
		Lang.get(99332),
		36902,
		18,
		1240,
		nil,
		1,
		3,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[36902019] = {
		36902019,
		0,
		Lang.get(99333),
		36902,
		19,
		1238,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3,
		nil,
		63,
		36913,
		1,
		1,
		nil,
		1,
		nil,
		36913
	},
	[36902020] = {
		36902020,
		0,
		Lang.get(99334),
		36902,
		20,
		1240,
		{
			RTResTalkAction[15],
			RTResTalkAction[10]
		}
	},
	[36902021] = {
		36902021,
		0,
		Lang.get(99335),
		36902,
		21,
		1238,
		{
			RTResTalkAction[6],
			RTResTalkAction[10]
		}
	},
	[36902022] = {
		36902022,
		0,
		Lang.get(99336),
		36902,
		22,
		1238,
		{
			RTResTalkAction[6],
			RTResTalkAction[10]
		}
	},
	[36902023] = {
		36902023,
		0,
		Lang.get(99337),
		36902,
		23,
		1240,
		{
			RTResTalkAction[15],
			RTResTalkAction[10]
		}
	},
	[36902024] = {
		36902024,
		0,
		Lang.get(99338),
		36902,
		24,
		1238,
		{
			RTResTalkAction[6],
			RTResTalkAction[10]
		}
	},
	[36902025] = {
		36902025,
		0,
		Lang.get(99339),
		36902,
		25,
		1133,
		{
			RTResTalkAction[16],
			RTResTalkAction[5],
			RTResTalkAction[13]
		},
		nil,
		nil,
		3,
		2751,
		nil,
		36914,
		1,
		1,
		nil,
		nil,
		nil,
		36914
	},
	[36902026] = {
		36902026,
		0,
		Lang.get(99340),
		36902,
		26,
		1133,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[36902027] = {
		36902027,
		0,
		Lang.get(99341),
		36902,
		27,
		1133,
		{
			RTResTalkAction[18]
		}
	},
	[36903001] = {
		36903001,
		0,
		Lang.get(99342),
		36903,
		1,
		1132,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		36920,
		nil,
		nil,
		nil,
		nil,
		nil,
		36920
	},
	[36903002] = {
		36903002,
		0,
		Lang.get(99343),
		36903,
		2,
		1132,
		nil,
		1
	},
	[36903003] = {
		36903003,
		0,
		Lang.get(99344),
		36903,
		3,
		1132,
		nil,
		1
	},
	[36903004] = {
		36903004,
		0,
		Lang.get(99345),
		36903,
		4,
		1132,
		nil,
		1
	},
	[36903005] = {
		36903005,
		0,
		Lang.get(99346),
		36903,
		5,
		1132,
		nil,
		1
	},
	[36903006] = {
		36903006,
		0,
		Lang.get(99347),
		36903,
		6,
		1132,
		nil,
		1,
		1
	},
	[36903007] = {
		36903007,
		0,
		Lang.get(99348),
		36903,
		7,
		1132,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[36903008] = {
		36903008,
		0,
		Lang.get(99349),
		36903,
		8,
		1132,
		nil,
		1,
		0
	},
	[36903009] = {
		36903009,
		0,
		Lang.get(99350),
		36903,
		9,
		1132,
		nil,
		1,
		1,
		nil,
		nil,
		63,
		36921,
		nil,
		nil,
		nil,
		nil,
		nil,
		36921
	},
	[36903010] = {
		36903010,
		0,
		Lang.get(99351),
		36903,
		10,
		1132,
		nil,
		1,
		0
	},
	[36903011] = {
		36903011,
		0,
		Lang.get(99352),
		36903,
		11,
		1132,
		nil,
		1
	},
	[36903012] = {
		36903012,
		0,
		Lang.get(99353),
		36903,
		12,
		1132,
		nil,
		1
	},
	[36903013] = {
		36903013,
		0,
		Lang.get(99354),
		36903,
		13,
		1132,
		nil,
		1
	},
	[36903014] = {
		36903014,
		0,
		Lang.get(99355),
		36903,
		14,
		1132,
		nil,
		1,
		1
	},
	[36903015] = {
		36903015,
		0,
		Lang.get(99356),
		36903,
		15,
		1132,
		nil,
		1,
		0
	},
	[36903016] = {
		36903016,
		0,
		Lang.get(99357),
		36903,
		16,
		1132,
		nil,
		1
	},
	[36903017] = {
		36903017,
		0,
		Lang.get(99358),
		36903,
		17,
		1132,
		nil,
		1
	},
	[36903018] = {
		36903018,
		0,
		Lang.get(99359),
		36903,
		18,
		1132,
		nil,
		1
	},
	[36903019] = {
		36903019,
		0,
		Lang.get(99360),
		36903,
		19,
		1132,
		nil,
		1
	},
	[36903020] = {
		36903020,
		0,
		Lang.get(99361),
		36903,
		20,
		1132,
		nil,
		1,
		0
	},
	[36903021] = {
		36903021,
		0,
		Lang.get(99362),
		36903,
		21,
		1239,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		36922,
		nil,
		nil,
		nil,
		nil,
		nil,
		36922
	},
	[36903022] = {
		36903022,
		0,
		Lang.get(99363),
		36903,
		22,
		1239,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		3
	},
	[36903023] = {
		36903023,
		0,
		Lang.get(99364),
		36903,
		23,
		1132,
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
