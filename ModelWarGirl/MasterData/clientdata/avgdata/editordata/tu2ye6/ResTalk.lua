-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\tu2ye6\\ResTalk.lua

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
	[1] = 1,
	[2] = 424
}
RTResTalkAction[3] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[4] = {
	[1] = 0,
	[2] = 424
}
RTResTalkAction[5] = {
	[1] = 1,
	[2] = 1071
}
RTResTalkAction[6] = {
	[1] = 0,
	[2] = 1071
}
RTResTalkAction[7] = {
	[1] = 1,
	[2] = 195
}
RTResTalkAction[8] = {
	[1] = 2,
	[2] = 195
}
RTResTalkAction[9] = {
	[1] = 3,
	[2] = 107
}
RTResTalkAction[10] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[11] = {
	[1] = 3,
	[2] = 143
}
RTResTalkAction[12] = {
	[1] = 1,
	[2] = 143
}
RTResTalkAction[13] = {
	[1] = 1,
	[2] = 1169
}
RTResTalkAction[14] = {
	[1] = 3,
	[2] = 1169
}
RTResTalkAction[15] = {
	[1] = 3,
	[2] = 1172
}
RTResTalkAction[16] = {
	[1] = 0,
	[2] = 1172
}
RTResTalkAction[17] = {
	[1] = 1,
	[2] = 1172
}

local Data = {
	[35000001] = {
		35000001,
		10,
		"63",
		35000,
		1,
		nil,
		nil,
		nil,
		nil,
		5,
		nil,
		171
	},
	[35000002] = {
		35000002,
		0,
		Lang.get(91032),
		35000,
		2,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		35000,
		nil,
		1,
		nil,
		1,
		nil,
		35000
	},
	[35000003] = {
		35000003,
		0,
		Lang.get(91033),
		35000,
		3,
		424,
		nil,
		1
	},
	[35000004] = {
		35000004,
		0,
		Lang.get(91034),
		35000,
		4,
		107,
		nil,
		1
	},
	[35000005] = {
		35000005,
		0,
		Lang.get(91035),
		35000,
		5,
		424,
		nil,
		1
	},
	[35000006] = {
		35000006,
		0,
		Lang.get(91036),
		35000,
		6,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[35000007] = {
		35000007,
		0,
		Lang.get(91037),
		35000,
		7,
		107,
		{
			RTResTalkAction[1]
		}
	},
	[35000008] = {
		35000008,
		0,
		Lang.get(91038),
		35000,
		8,
		424,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[35000009] = {
		35000009,
		0,
		Lang.get(91039),
		35000,
		9,
		107,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[35000010] = {
		35000010,
		0,
		Lang.get(91040),
		35000,
		10,
		300,
		{
			RTResTalkAction[3]
		}
	},
	[35000011] = {
		35000011,
		0,
		Lang.get(91041),
		35000,
		11,
		107,
		{
			RTResTalkAction[1]
		}
	},
	[35001001] = {
		35001001,
		10,
		"64",
		35001,
		1,
		107,
		nil,
		nil,
		nil,
		5,
		nil,
		171
	},
	[35001002] = {
		35001002,
		0,
		Lang.get(91042),
		35001,
		2,
		1071,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		35001,
		nil,
		1,
		nil,
		1,
		nil,
		35001
	},
	[35001003] = {
		35001003,
		0,
		Lang.get(91043),
		35001,
		3,
		1071,
		nil,
		1
	},
	[35001004] = {
		35001004,
		0,
		Lang.get(91044),
		35001,
		4,
		107,
		nil,
		1
	},
	[35001005] = {
		35001005,
		0,
		Lang.get(91045),
		35001,
		5,
		424,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[35001006] = {
		35001006,
		0,
		Lang.get(91046),
		35001,
		6,
		107,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[35001007] = {
		35001007,
		3,
		Lang.get(91047),
		35001,
		7,
		605,
		{
			RTResTalkAction[3]
		},
		[22] = 1
	},
	[35001008] = {
		35001008,
		0,
		Lang.get(91048),
		35001,
		8,
		1071,
		{
			RTResTalkAction[5]
		}
	},
	[35001009] = {
		35001009,
		0,
		Lang.get(91049),
		35001,
		9,
		1071,
		{
			RTResTalkAction[5]
		}
	},
	[35001010] = {
		35001010,
		0,
		Lang.get(91050),
		35001,
		10,
		1071,
		{
			RTResTalkAction[5]
		}
	},
	[35001011] = {
		35001011,
		0,
		Lang.get(91051),
		35001,
		11,
		424,
		{
			RTResTalkAction[2],
			RTResTalkAction[6]
		}
	},
	[35001012] = {
		35001012,
		0,
		Lang.get(91052),
		35001,
		12,
		107,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[35001013] = {
		35001013,
		0,
		Lang.get(91053),
		35001,
		13,
		1071,
		{
			RTResTalkAction[5],
			RTResTalkAction[3]
		}
	},
	[35002001] = {
		35002001,
		10,
		"65",
		35002,
		1,
		1071,
		nil,
		nil,
		nil,
		5,
		nil,
		171
	},
	[35002002] = {
		35002002,
		0,
		Lang.get(91054),
		35002,
		2,
		195,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		35002,
		nil,
		1,
		nil,
		1,
		nil,
		35002
	},
	[35002003] = {
		35002003,
		0,
		Lang.get(91055),
		35002,
		3,
		195,
		nil,
		1
	},
	[35002004] = {
		35002004,
		0,
		Lang.get(91056),
		35002,
		4,
		424,
		nil,
		1
	},
	[35002005] = {
		35002005,
		0,
		Lang.get(91057),
		35002,
		5,
		107,
		nil,
		1
	},
	[35002006] = {
		35002006,
		0,
		Lang.get(91058),
		35002,
		6,
		195,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3
	},
	[35002007] = {
		35002007,
		0,
		Lang.get(91059),
		35002,
		7,
		195,
		{
			RTResTalkAction[7]
		}
	},
	[35002008] = {
		35002008,
		0,
		Lang.get(91060),
		35002,
		8,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[35002009] = {
		35002009,
		0,
		Lang.get(91061),
		35002,
		9,
		195,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[35003001] = {
		35003001,
		10,
		"66",
		35003,
		1,
		195,
		nil,
		nil,
		nil,
		5,
		nil,
		171
	},
	[35003002] = {
		35003002,
		0,
		Lang.get(91062),
		35003,
		2,
		143,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		35003,
		nil,
		1,
		nil,
		1,
		nil,
		35003
	},
	[35003003] = {
		35003003,
		0,
		Lang.get(91063),
		35003,
		3,
		107,
		nil,
		1
	},
	[35003004] = {
		35003004,
		0,
		Lang.get(91064),
		35003,
		4,
		143,
		nil,
		1
	},
	[35003005] = {
		35003005,
		0,
		Lang.get(91065),
		35003,
		5,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[35003006] = {
		35003006,
		0,
		Lang.get(91066),
		35003,
		6,
		143,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[35003007] = {
		35003007,
		0,
		Lang.get(91067),
		35003,
		7,
		143,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[35003008] = {
		35003008,
		0,
		Lang.get(91068),
		35003,
		8,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[35003009] = {
		35003009,
		0,
		Lang.get(91069),
		35003,
		9,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[35003010] = {
		35003010,
		0,
		Lang.get(91070),
		35003,
		10,
		143,
		{
			RTResTalkAction[12],
			RTResTalkAction[3]
		}
	},
	[35004001] = {
		35004001,
		10,
		"67",
		35004,
		1,
		143,
		nil,
		nil,
		nil,
		5,
		nil,
		171
	},
	[35004002] = {
		35004002,
		0,
		Lang.get(91071),
		35004,
		2,
		1169,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		35004,
		nil,
		1,
		nil,
		1,
		nil,
		35004
	},
	[35004003] = {
		35004003,
		0,
		Lang.get(91072),
		35004,
		3,
		1169,
		nil,
		1
	},
	[35004004] = {
		35004004,
		0,
		Lang.get(91073),
		35004,
		4,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[35004005] = {
		35004005,
		0,
		Lang.get(91074),
		35004,
		5,
		424,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[35004006] = {
		35004006,
		0,
		Lang.get(91075),
		35004,
		6,
		1169,
		{
			RTResTalkAction[13],
			RTResTalkAction[4]
		}
	},
	[35004007] = {
		35004007,
		0,
		Lang.get(91076),
		35004,
		7,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[14]
		}
	},
	[35004008] = {
		35004008,
		0,
		Lang.get(91077),
		35004,
		8,
		1169,
		{
			RTResTalkAction[10],
			RTResTalkAction[14]
		}
	},
	[35005001] = {
		35005001,
		10,
		"68",
		35005,
		1,
		1169,
		nil,
		nil,
		nil,
		5,
		nil,
		171
	},
	[35005002] = {
		35005002,
		2,
		Lang.get(91078),
		35005,
		2,
		1172,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		35005,
		nil,
		1,
		nil,
		1,
		nil,
		35005
	},
	[35005003] = {
		35005003,
		2,
		Lang.get(91079),
		35005,
		3,
		1172,
		nil,
		1
	},
	[35005004] = {
		35005004,
		0,
		Lang.get(91080),
		35005,
		4,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[35005005] = {
		35005005,
		0,
		Lang.get(91081),
		35005,
		5,
		1172,
		{
			RTResTalkAction[10],
			RTResTalkAction[15]
		}
	},
	[35005006] = {
		35005006,
		0,
		Lang.get(91082),
		35005,
		6,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[15]
		}
	},
	[35005007] = {
		35005007,
		0,
		Lang.get(91083),
		35005,
		7,
		1172,
		{
			RTResTalkAction[10],
			RTResTalkAction[15]
		}
	},
	[35005008] = {
		35005008,
		0,
		Lang.get(91084),
		35005,
		8,
		424,
		{
			RTResTalkAction[2],
			RTResTalkAction[3],
			RTResTalkAction[16]
		}
	},
	[35005009] = {
		35005009,
		0,
		Lang.get(91085),
		35005,
		9,
		107,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[35005010] = {
		35005010,
		0,
		Lang.get(91086),
		35005,
		10,
		1172,
		{
			RTResTalkAction[17],
			RTResTalkAction[3]
		}
	},
	[35005011] = {
		35005011,
		0,
		Lang.get(91087),
		35005,
		11,
		1172,
		{
			RTResTalkAction[17]
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
