-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\chunri_22\\ResTalk.lua

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
	10
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
	[2] = 297
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
	[1] = 0,
	[2] = 297
}
RTResTalkAction[8] = {
	1,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[9] = {
	[1] = 1,
	[2] = 298
}
RTResTalkAction[10] = {
	[1] = 0,
	[2] = 298
}
RTResTalkAction[11] = {
	[1] = 1,
	[2] = 299
}
RTResTalkAction[12] = {
	[1] = 0,
	[2] = 299
}
RTResTalkAction[13] = {
	1,
	107,
	nil,
	nil,
	5
}

local Data = {
	[30501001] = {
		30501001,
		0,
		Lang.get(73626),
		30501,
		1,
		297,
		nil,
		1,
		nil,
		nil,
		nil,
		134,
		30501,
		nil,
		1,
		nil,
		1,
		nil,
		30501
	},
	[30501002] = {
		30501002,
		0,
		Lang.get(73627),
		30501,
		2,
		297,
		nil,
		1
	},
	[30501003] = {
		30501003,
		0,
		Lang.get(73628),
		30501,
		3,
		107,
		nil,
		1
	},
	[30501004] = {
		30501004,
		0,
		Lang.get(73629),
		30501,
		4,
		133,
		nil,
		1
	},
	[30501005] = {
		30501005,
		0,
		Lang.get(73630),
		30501,
		5,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[30501006] = {
		30501006,
		2,
		Lang.get(73631),
		30501,
		6,
		133,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[30501007] = {
		30501007,
		5,
		Lang.get(73632),
		30501,
		7,
		297,
		{
			RTResTalkAction[4],
			RTResTalkAction[5],
			RTResTalkAction[6]
		}
	},
	[30501008] = {
		30501008,
		7,
		"86",
		30501,
		8,
		297,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		5,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[30501009] = {
		30501009,
		0,
		Lang.get(73633),
		30501,
		9,
		107,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3
	},
	[30501010] = {
		30501010,
		0,
		Lang.get(73634),
		30501,
		10,
		298,
		{
			RTResTalkAction[9],
			RTResTalkAction[5]
		}
	},
	[30501011] = {
		30501011,
		7,
		"85",
		30501,
		11,
		298,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		5,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[30501012] = {
		30501012,
		0,
		Lang.get(73635),
		30501,
		12,
		107,
		{
			RTResTalkAction[9]
		},
		1,
		5,
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
		298
	},
	[30501013] = {
		30501013,
		0,
		Lang.get(73636),
		30501,
		13,
		133,
		{
			RTResTalkAction[10]
		},
		1,
		0,
		nil,
		nil,
		nil,
		30502,
		nil,
		1,
		nil,
		1,
		nil,
		30502
	},
	[30501014] = {
		30501014,
		0,
		Lang.get(73637),
		30501,
		14,
		299,
		nil,
		1
	},
	[30501015] = {
		30501015,
		5,
		Lang.get(73638),
		30501,
		15,
		297,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		30503,
		nil,
		1,
		nil,
		1,
		nil,
		30503
	},
	[30501016] = {
		30501016,
		0,
		Lang.get(73639),
		30501,
		16,
		299,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3
	},
	[30501017] = {
		30501017,
		7,
		"87",
		30501,
		17,
		299,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		5,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[30501018] = {
		30501018,
		0,
		Lang.get(73640),
		30501,
		18,
		297,
		{
			RTResTalkAction[11]
		},
		1,
		nil,
		3,
		[21] = 299
	},
	[30501019] = {
		30501019,
		0,
		Lang.get(73641),
		30501,
		19,
		107,
		{
			RTResTalkAction[12]
		},
		1,
		7
	},
	[30501020] = {
		30501020,
		0,
		Lang.get(73642),
		30501,
		20,
		297,
		nil,
		1,
		0
	},
	[30501021] = {
		30501021,
		0,
		Lang.get(73643),
		30501,
		21,
		299,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		30505,
		nil,
		1,
		nil,
		1,
		nil,
		30504
	},
	[30501022] = {
		30501022,
		0,
		Lang.get(73644),
		30501,
		22,
		299,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3
	},
	[30501023] = {
		30501023,
		0,
		Lang.get(73645),
		30501,
		23,
		298,
		{
			RTResTalkAction[9],
			RTResTalkAction[12]
		}
	},
	[30501024] = {
		30501024,
		0,
		Lang.get(73646),
		30501,
		24,
		107,
		{
			RTResTalkAction[13],
			RTResTalkAction[10]
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
