-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\CL_yure\\ResTalk.lua

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
	1195,
	nil,
	nil,
	2
}
RTResTalkAction[2] = {
	[1] = 0,
	[2] = 1195
}
RTResTalkAction[3] = {
	1,
	1266,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[4] = {
	1,
	1195,
	nil,
	nil,
	1
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 1266
}
RTResTalkAction[6] = {
	1,
	1266,
	nil,
	nil,
	1
}
RTResTalkAction[7] = {
	1,
	1266,
	nil,
	nil,
	2
}
RTResTalkAction[8] = {
	1,
	1266,
	{
		3
	},
	nil,
	3
}
RTResTalkAction[9] = {
	1,
	1268,
	nil,
	nil,
	2
}
RTResTalkAction[10] = {
	1,
	1268,
	nil,
	nil,
	1
}
RTResTalkAction[11] = {
	2,
	1267,
	nil,
	nil,
	1
}
RTResTalkAction[12] = {
	[1] = 3,
	[2] = 1268
}
RTResTalkAction[13] = {
	1,
	1195,
	nil,
	nil,
	0
}
RTResTalkAction[14] = {
	1,
	1195,
	nil,
	nil,
	3
}
RTResTalkAction[15] = {
	1,
	1266,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[16] = {
	[1] = 0,
	[2] = 1268
}
RTResTalkAction[17] = {
	1,
	1195,
	{
		1
	},
	nil,
	3
}
RTResTalkAction[18] = {
	1,
	1268,
	nil,
	nil,
	0
}
RTResTalkAction[19] = {
	1,
	1267,
	nil,
	nil,
	0
}
RTResTalkAction[20] = {
	[1] = 0,
	[2] = 1267
}
RTResTalkAction[21] = {
	[1] = 2,
	[2] = 1195
}
RTResTalkAction[22] = {
	3,
	1268,
	nil,
	nil,
	1
}
RTResTalkAction[23] = {
	1,
	107,
	{
		1
	},
	nil,
	10
}
RTResTalkAction[24] = {
	1,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[25] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[26] = {
	3,
	1195,
	nil,
	nil,
	2
}
RTResTalkAction[27] = {
	1,
	1267,
	nil,
	nil,
	1
}
RTResTalkAction[28] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[29] = {
	1,
	141,
	nil,
	nil,
	2
}
RTResTalkAction[30] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[31] = {
	2,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[32] = {
	[1] = 3,
	[2] = 1195
}
RTResTalkAction[33] = {
	3,
	1195,
	nil,
	nil,
	1
}
RTResTalkAction[34] = {
	2,
	107,
	nil,
	nil,
	5
}
RTResTalkAction[35] = {
	2,
	1267,
	nil,
	nil,
	2
}
RTResTalkAction[36] = {
	1,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[37] = {
	1,
	107,
	nil,
	nil,
	5
}

local Data = {
	[39300001] = {
		39300001,
		0,
		Lang.get(103659),
		39300,
		1,
		1195,
		nil,
		1,
		2,
		nil,
		nil,
		62,
		39300,
		nil,
		nil,
		nil,
		1,
		nil,
		39300
	},
	[39300002] = {
		39300002,
		0,
		Lang.get(103660),
		39300,
		2,
		1195,
		{
			RTResTalkAction[1]
		},
		nil,
		0,
		3
	},
	[39300003] = {
		39300003,
		0,
		Lang.get(103661),
		39300,
		3,
		1195,
		{
			RTResTalkAction[1]
		}
	},
	[39300004] = {
		39300004,
		3,
		Lang.get(103662),
		39300,
		4,
		605,
		{
			RTResTalkAction[2]
		},
		[22] = 1
	},
	[39300005] = {
		39300005,
		3,
		Lang.get(103663),
		39300,
		5,
		605,
		[22] = 1
	},
	[39300006] = {
		39300006,
		0,
		Lang.get(103664),
		39300,
		6,
		1266,
		{
			RTResTalkAction[3]
		}
	},
	[39300007] = {
		39300007,
		0,
		Lang.get(103665),
		39300,
		7,
		1195,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[39300008] = {
		39300008,
		0,
		Lang.get(103666),
		39300,
		8,
		1195,
		{
			RTResTalkAction[4]
		}
	},
	[39300009] = {
		39300009,
		3,
		Lang.get(103667),
		39300,
		9,
		605,
		{
			RTResTalkAction[2]
		},
		[22] = 1
	},
	[39300010] = {
		39300010,
		3,
		Lang.get(103668),
		39300,
		10,
		605,
		[22] = 1
	},
	[39300011] = {
		39300011,
		0,
		Lang.get(103669),
		39300,
		11,
		1266,
		{
			RTResTalkAction[6]
		}
	},
	[39300012] = {
		39300012,
		0,
		Lang.get(103670),
		39300,
		12,
		1195,
		{
			RTResTalkAction[1],
			RTResTalkAction[5]
		}
	},
	[39300013] = {
		39300013,
		0,
		Lang.get(103671),
		39300,
		13,
		1195,
		{
			RTResTalkAction[1]
		}
	},
	[39300014] = {
		39300014,
		0,
		Lang.get(103672),
		39300,
		14,
		1266,
		{
			RTResTalkAction[7],
			RTResTalkAction[2]
		}
	},
	[39300015] = {
		39300015,
		0,
		Lang.get(103673),
		39300,
		15,
		1195,
		{
			RTResTalkAction[1],
			RTResTalkAction[5]
		}
	},
	[39300016] = {
		39300016,
		0,
		Lang.get(103674),
		39300,
		16,
		1195,
		{
			RTResTalkAction[4]
		}
	},
	[39300017] = {
		39300017,
		0,
		Lang.get(103675),
		39300,
		17,
		1266,
		{
			RTResTalkAction[8],
			RTResTalkAction[2]
		}
	},
	[39300018] = {
		39300018,
		0,
		Lang.get(103676),
		39300,
		18,
		1268,
		{
			RTResTalkAction[9],
			RTResTalkAction[5]
		}
	},
	[39300019] = {
		39300019,
		0,
		Lang.get(103677),
		39300,
		19,
		1268,
		{
			RTResTalkAction[10]
		}
	},
	[39300020] = {
		39300020,
		0,
		Lang.get(103678),
		39300,
		20,
		1267,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[39301001] = {
		39301001,
		0,
		Lang.get(94321),
		39301,
		1,
		1195,
		nil,
		1,
		1,
		nil,
		nil,
		62,
		39301,
		nil,
		nil,
		nil,
		1,
		nil,
		39301
	},
	[39301002] = {
		39301002,
		0,
		Lang.get(103679),
		39301,
		2,
		1195,
		{
			RTResTalkAction[4]
		},
		nil,
		0,
		3
	},
	[39301003] = {
		39301003,
		0,
		Lang.get(103680),
		39301,
		3,
		1195,
		{
			RTResTalkAction[13]
		}
	},
	[39301004] = {
		39301004,
		0,
		Lang.get(103681),
		39301,
		4,
		1266,
		{
			RTResTalkAction[8],
			RTResTalkAction[2]
		}
	},
	[39301005] = {
		39301005,
		0,
		Lang.get(103682),
		39301,
		5,
		1195,
		{
			RTResTalkAction[1],
			RTResTalkAction[5]
		}
	},
	[39301006] = {
		39301006,
		0,
		Lang.get(103683),
		39301,
		6,
		1195,
		{
			RTResTalkAction[1]
		}
	},
	[39301007] = {
		39301007,
		0,
		Lang.get(103684),
		39301,
		7,
		1195,
		{
			RTResTalkAction[4]
		}
	},
	[39301008] = {
		39301008,
		3,
		Lang.get(103685),
		39301,
		8,
		605,
		{
			RTResTalkAction[2]
		},
		[22] = 1
	},
	[39301009] = {
		39301009,
		0,
		Lang.get(103686),
		39301,
		9,
		1266,
		{
			RTResTalkAction[3]
		}
	},
	[39301010] = {
		39301010,
		0,
		Lang.get(103687),
		39301,
		10,
		1195,
		{
			RTResTalkAction[1],
			RTResTalkAction[5]
		}
	},
	[39301011] = {
		39301011,
		0,
		Lang.get(103688),
		39301,
		11,
		1195,
		{
			RTResTalkAction[4]
		}
	},
	[39301012] = {
		39301012,
		0,
		Lang.get(103689),
		39301,
		12,
		1266,
		{
			RTResTalkAction[8],
			RTResTalkAction[2]
		}
	},
	[39301013] = {
		39301013,
		0,
		Lang.get(103690),
		39301,
		13,
		1195,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[39301014] = {
		39301014,
		0,
		Lang.get(103691),
		39301,
		14,
		1195,
		{
			RTResTalkAction[1]
		}
	},
	[39301015] = {
		39301015,
		3,
		Lang.get(103692),
		39301,
		15,
		605,
		{
			RTResTalkAction[2]
		},
		[22] = 1
	},
	[39301016] = {
		39301016,
		0,
		Lang.get(103693),
		39301,
		16,
		1195,
		{
			RTResTalkAction[14]
		}
	},
	[39301017] = {
		39301017,
		0,
		Lang.get(103694),
		39301,
		17,
		1268,
		{
			RTResTalkAction[10],
			RTResTalkAction[2]
		}
	},
	[39301018] = {
		39301018,
		0,
		Lang.get(103695),
		39301,
		18,
		1266,
		{
			RTResTalkAction[15],
			RTResTalkAction[16]
		}
	},
	[39302001] = {
		39302001,
		0,
		Lang.get(103696),
		39302,
		1,
		1195,
		nil,
		1,
		3,
		nil,
		nil,
		62,
		39302,
		nil,
		nil,
		nil,
		1,
		nil,
		39302
	},
	[39302002] = {
		39302002,
		0,
		Lang.get(103697),
		39302,
		2,
		1195,
		{
			RTResTalkAction[17]
		},
		nil,
		0,
		3
	},
	[39302003] = {
		39302003,
		0,
		Lang.get(103698),
		39302,
		3,
		1268,
		{
			RTResTalkAction[9],
			RTResTalkAction[2]
		}
	},
	[39302004] = {
		39302004,
		0,
		Lang.get(103699),
		39302,
		4,
		1268,
		{
			RTResTalkAction[10]
		}
	},
	[39302005] = {
		39302005,
		0,
		Lang.get(103700),
		39302,
		5,
		1268,
		{
			RTResTalkAction[18]
		}
	},
	[39302006] = {
		39302006,
		0,
		Lang.get(103701),
		39302,
		6,
		1267,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[39302007] = {
		39302007,
		0,
		Lang.get(103702),
		39302,
		7,
		1267,
		{
			RTResTalkAction[19],
			RTResTalkAction[16]
		}
	},
	[39302008] = {
		39302008,
		0,
		Lang.get(103703),
		39302,
		8,
		1195,
		{
			RTResTalkAction[14],
			RTResTalkAction[20]
		}
	},
	[39302009] = {
		39302009,
		0,
		Lang.get(103704),
		39302,
		9,
		1268,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[39302010] = {
		39302010,
		0,
		Lang.get(103705),
		39302,
		10,
		107,
		{
			RTResTalkAction[23],
			RTResTalkAction[2],
			RTResTalkAction[16]
		}
	},
	[39302011] = {
		39302011,
		0,
		Lang.get(103706),
		39302,
		11,
		107,
		{
			RTResTalkAction[24]
		}
	},
	[39302012] = {
		39302012,
		0,
		Lang.get(103707),
		39302,
		12,
		1195,
		{
			RTResTalkAction[25],
			RTResTalkAction[26]
		}
	},
	[39302013] = {
		39302013,
		0,
		Lang.get(103708),
		39302,
		13,
		1267,
		{
			RTResTalkAction[27],
			RTResTalkAction[28],
			RTResTalkAction[2]
		}
	},
	[39302014] = {
		39302014,
		0,
		Lang.get(103709),
		39302,
		14,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[20]
		}
	},
	[39302015] = {
		39302015,
		0,
		Lang.get(103710),
		39302,
		15,
		1195,
		{
			RTResTalkAction[1],
			RTResTalkAction[30]
		}
	},
	[39302016] = {
		39302016,
		0,
		Lang.get(103711),
		39302,
		16,
		107,
		{
			RTResTalkAction[31],
			RTResTalkAction[32]
		}
	},
	[39302017] = {
		39302017,
		0,
		Lang.get(103712),
		39302,
		17,
		1195,
		{
			RTResTalkAction[25],
			RTResTalkAction[26]
		}
	},
	[39302018] = {
		39302018,
		0,
		Lang.get(103713),
		39302,
		18,
		1195,
		{
			RTResTalkAction[25],
			RTResTalkAction[33]
		}
	},
	[39302019] = {
		39302019,
		0,
		Lang.get(103714),
		39302,
		19,
		107,
		{
			RTResTalkAction[34],
			RTResTalkAction[32]
		}
	},
	[39302020] = {
		39302020,
		0,
		Lang.get(103715),
		39302,
		20,
		1195,
		{
			RTResTalkAction[1],
			RTResTalkAction[28]
		}
	},
	[39302021] = {
		39302021,
		0,
		Lang.get(103716),
		39302,
		21,
		1266,
		{
			RTResTalkAction[15],
			RTResTalkAction[2]
		}
	},
	[39302022] = {
		39302022,
		0,
		Lang.get(103717),
		39302,
		22,
		1268,
		{
			RTResTalkAction[9],
			RTResTalkAction[5]
		}
	},
	[39302023] = {
		39302023,
		0,
		Lang.get(103718),
		39302,
		23,
		1267,
		{
			RTResTalkAction[35],
			RTResTalkAction[12]
		}
	},
	[39302024] = {
		39302024,
		0,
		Lang.get(103719),
		39302,
		24,
		107,
		{
			RTResTalkAction[36],
			RTResTalkAction[20],
			RTResTalkAction[16]
		}
	},
	[39302025] = {
		39302025,
		0,
		Lang.get(103720),
		39302,
		25,
		107,
		{
			RTResTalkAction[37]
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
