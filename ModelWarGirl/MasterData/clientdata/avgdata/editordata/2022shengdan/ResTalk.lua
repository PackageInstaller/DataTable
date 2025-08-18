-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\2022shengdan\\ResTalk.lua

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
	[2] = 808
}
RTResTalkAction[2] = {
	[1] = 0,
	[2] = 808
}
RTResTalkAction[3] = {
	[1] = 2,
	[2] = 1159
}
RTResTalkAction[4] = {
	[1] = 3,
	[2] = 133
}
RTResTalkAction[5] = {
	3,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[6] = {
	[1] = 0,
	[2] = 133
}
RTResTalkAction[7] = {
	3,
	133,
	nil,
	nil,
	0
}
RTResTalkAction[8] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[9] = {
	[1] = 3,
	[2] = 141
}
RTResTalkAction[10] = {
	[1] = 1,
	[2] = 1159
}
RTResTalkAction[11] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[12] = {
	[1] = 0,
	[2] = 1159
}
RTResTalkAction[13] = {
	[1] = 1,
	[2] = 1160
}
RTResTalkAction[14] = {
	[1] = 2,
	[2] = 1160
}
RTResTalkAction[15] = {
	[1] = 0,
	[2] = 1160
}
RTResTalkAction[16] = {
	1,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[17] = {
	1,
	107,
	nil,
	nil,
	0
}

local Data = {
	[34601001] = {
		34601001,
		9,
		Lang.get(89094),
		34601,
		1,
		808,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		nil,
		nil,
		116,
		34601,
		[19] = 34601,
		[22] = 1
	},
	[34601002] = {
		34601002,
		0,
		Lang.get(89095),
		34601,
		2,
		107,
		{
			RTResTalkAction[2]
		},
		1
	},
	[34601003] = {
		34601003,
		0,
		Lang.get(89096),
		34601,
		3,
		107,
		nil,
		1,
		6
	},
	[34601004] = {
		34601004,
		0,
		Lang.get(89097),
		34601,
		4,
		133,
		nil,
		1,
		0
	},
	[34601005] = {
		34601005,
		0,
		Lang.get(89098),
		34601,
		5,
		107,
		nil,
		1
	},
	[34601006] = {
		34601006,
		0,
		Lang.get(89099),
		34601,
		6,
		133,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		34602,
		[19] = 34602
	},
	[34601007] = {
		34601007,
		0,
		Lang.get(89100),
		34601,
		7,
		107,
		nil,
		1
	},
	[34601008] = {
		34601008,
		0,
		Lang.get(89101),
		34601,
		8,
		133,
		{
			RTResTalkAction[3],
			RTResTalkAction[4]
		},
		nil,
		nil,
		3
	},
	[34601009] = {
		34601009,
		0,
		Lang.get(89102),
		34601,
		9,
		107,
		{
			RTResTalkAction[3],
			RTResTalkAction[5],
			RTResTalkAction[6]
		}
	},
	[34601010] = {
		34601010,
		0,
		Lang.get(89103),
		34601,
		10,
		133,
		{
			RTResTalkAction[3],
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[34601011] = {
		34601011,
		0,
		Lang.get(89104),
		34601,
		11,
		141,
		{
			RTResTalkAction[3],
			RTResTalkAction[9],
			RTResTalkAction[6]
		}
	},
	[34601012] = {
		34601012,
		0,
		Lang.get(89105),
		34601,
		12,
		1159,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[34601013] = {
		34601013,
		0,
		Lang.get(89106),
		34601,
		13,
		133,
		{
			RTResTalkAction[3],
			RTResTalkAction[4]
		}
	},
	[34601014] = {
		34601014,
		0,
		Lang.get(89107),
		34601,
		14,
		1159,
		{
			RTResTalkAction[12],
			RTResTalkAction[6]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		34603,
		[19] = 34603
	},
	[34601015] = {
		34601015,
		0,
		Lang.get(89108),
		34601,
		15,
		133,
		nil,
		1
	},
	[34601016] = {
		34601016,
		0,
		Lang.get(89109),
		34601,
		16,
		141,
		{
			RTResTalkAction[3],
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[34601017] = {
		34601017,
		0,
		Lang.get(89110),
		34601,
		17,
		107,
		{
			RTResTalkAction[3],
			RTResTalkAction[5],
			RTResTalkAction[11]
		}
	},
	[34601018] = {
		34601018,
		9,
		"——",
		34601,
		18,
		605,
		{
			RTResTalkAction[12],
			RTResTalkAction[8]
		},
		nil,
		nil,
		nil,
		nil,
		114,
		34604,
		nil,
		nil,
		nil,
		nil,
		nil,
		34604,
		nil,
		nil,
		1
	},
	[34601019] = {
		34601019,
		0,
		Lang.get(89111),
		34601,
		19,
		1160,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		3
	},
	[34601020] = {
		34601020,
		0,
		Lang.get(89112),
		34601,
		20,
		107,
		{
			RTResTalkAction[14],
			RTResTalkAction[5]
		}
	},
	[34601021] = {
		34601021,
		0,
		Lang.get(89113),
		34601,
		21,
		1159,
		{
			RTResTalkAction[10],
			RTResTalkAction[15],
			RTResTalkAction[8]
		}
	},
	[34601022] = {
		34601022,
		0,
		Lang.get(89114),
		34601,
		22,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[34601023] = {
		34601023,
		0,
		Lang.get(89115),
		34601,
		23,
		107,
		{
			RTResTalkAction[16],
			RTResTalkAction[12]
		}
	},
	[34601024] = {
		34601024,
		0,
		Lang.get(89116),
		34601,
		24,
		300,
		{
			RTResTalkAction[16]
		}
	},
	[34601025] = {
		34601025,
		9,
		Lang.get(89117),
		34601,
		25,
		605,
		{
			RTResTalkAction[17]
		},
		[22] = 1
	},
	[34601026] = {
		34601026,
		0,
		Lang.get(89118),
		34601,
		26,
		1159,
		{
			RTResTalkAction[10],
			RTResTalkAction[8]
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
