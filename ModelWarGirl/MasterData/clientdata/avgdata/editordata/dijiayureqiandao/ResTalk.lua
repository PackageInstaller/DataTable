-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\dijiayureqiandao\\ResTalk.lua

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
	107,
	nil,
	nil,
	6
}
RTResTalkAction[2] = {
	[1] = 1,
	[2] = 719
}
RTResTalkAction[3] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[4] = {
	1,
	107,
	nil,
	nil,
	5
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 719
}
RTResTalkAction[6] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[7] = {
	1,
	107,
	nil,
	nil,
	7
}

local Data = {
	[29001001] = {
		29001001,
		0,
		Lang.get(66145),
		29001,
		1,
		107,
		nil,
		1,
		5,
		nil,
		nil,
		62,
		29001,
		nil,
		nil,
		nil,
		nil,
		nil,
		29001
	},
	[29001002] = {
		29001002,
		0,
		Lang.get(66146),
		29001,
		2,
		719,
		nil,
		1,
		0
	},
	[29001003] = {
		29001003,
		0,
		Lang.get(66147),
		29001,
		3,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[29001004] = {
		29001004,
		0,
		Lang.get(66146),
		29001,
		4,
		719,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[29001005] = {
		29001005,
		0,
		Lang.get(66148),
		29001,
		5,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[29001006] = {
		29001006,
		0,
		Lang.get(66149),
		29001,
		6,
		107,
		{
			RTResTalkAction[6]
		}
	},
	[29001007] = {
		29001007,
		0,
		Lang.get(66150),
		29001,
		7,
		300,
		{
			RTResTalkAction[7]
		}
	},
	[29001008] = {
		29001008,
		0,
		Lang.get(66151),
		29001,
		8,
		107,
		{
			RTResTalkAction[1]
		}
	},
	[29001009] = {
		29001009,
		0,
		Lang.get(66152),
		29001,
		9,
		107,
		{
			RTResTalkAction[7]
		}
	},
	[29001010] = {
		29001010,
		0,
		"？？？？",
		29001,
		10,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[29001011] = {
		29001011,
		0,
		Lang.get(66153),
		29001,
		11,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[29001012] = {
		29001012,
		0,
		Lang.get(66154),
		29001,
		12,
		107,
		{
			RTResTalkAction[1]
		}
	},
	[29001013] = {
		29001013,
		0,
		Lang.get(66155),
		29001,
		13,
		107,
		{
			RTResTalkAction[7]
		}
	},
	[29002001] = {
		29002001,
		0,
		Lang.get(66156),
		29002,
		1,
		107,
		nil,
		1,
		5,
		nil,
		nil,
		62,
		29002,
		nil,
		nil,
		nil,
		nil,
		nil,
		29002
	},
	[29002002] = {
		29002002,
		0,
		Lang.get(66157),
		29002,
		2,
		107,
		{
			RTResTalkAction[6]
		},
		nil,
		nil,
		3
	},
	[29002003] = {
		29002003,
		0,
		Lang.get(66158),
		29002,
		3,
		107,
		{
			RTResTalkAction[4]
		}
	},
	[29002004] = {
		29002004,
		0,
		Lang.get(66159),
		29002,
		4,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[29002005] = {
		29002005,
		0,
		Lang.get(66160),
		29002,
		5,
		107,
		{
			RTResTalkAction[7]
		}
	},
	[29002006] = {
		29002006,
		0,
		Lang.get(66146),
		29002,
		6,
		719,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[29002007] = {
		29002007,
		0,
		Lang.get(66161),
		29002,
		7,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[29002008] = {
		29002008,
		0,
		Lang.get(66162),
		29002,
		8,
		107,
		{
			RTResTalkAction[6]
		}
	},
	[29002009] = {
		29002009,
		0,
		Lang.get(66163),
		29002,
		9,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[29002010] = {
		29002010,
		0,
		Lang.get(66164),
		29002,
		10,
		107,
		{
			RTResTalkAction[1]
		}
	},
	[29002011] = {
		29002011,
		0,
		Lang.get(66165),
		29002,
		11,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[29002012] = {
		29002012,
		0,
		Lang.get(66166),
		29002,
		12,
		107,
		{
			RTResTalkAction[6]
		}
	},
	[29003001] = {
		29003001,
		0,
		Lang.get(66167),
		29003,
		1,
		107,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		29003,
		[19] = 29003
	},
	[29003002] = {
		29003002,
		0,
		Lang.get(69591),
		29003,
		2,
		300,
		{
			RTResTalkAction[6]
		},
		nil,
		nil,
		3
	},
	[29003003] = {
		29003003,
		0,
		Lang.get(69592),
		29003,
		3,
		107,
		{
			RTResTalkAction[4]
		}
	},
	[29003004] = {
		29003004,
		0,
		Lang.get(69593),
		29003,
		4,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[29003005] = {
		29003005,
		0,
		Lang.get(66171),
		29003,
		5,
		107,
		{
			RTResTalkAction[4]
		}
	},
	[29003006] = {
		29003006,
		0,
		Lang.get(66146),
		29003,
		6,
		719,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[29003007] = {
		29003007,
		0,
		Lang.get(66172),
		29003,
		7,
		107,
		{
			RTResTalkAction[6],
			RTResTalkAction[5]
		}
	},
	[29003008] = {
		29003008,
		0,
		Lang.get(66173),
		29003,
		8,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[29003009] = {
		29003009,
		0,
		Lang.get(66174),
		29003,
		9,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[29003010] = {
		29003010,
		0,
		Lang.get(66175),
		29003,
		10,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		0
	},
	[29003011] = {
		29003011,
		0,
		"？？？？",
		29003,
		11,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[29003012] = {
		29003012,
		0,
		Lang.get(66176),
		29003,
		12,
		719,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
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
