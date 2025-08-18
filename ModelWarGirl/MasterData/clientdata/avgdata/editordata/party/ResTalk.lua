-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\Party\\ResTalk.lua

local indexMap = {
	npc_id = 6,
	scenery_id = 13,
	bg_blur = 10,
	play_delay = 14,
	mask_alpha = 19,
	section = 4,
	clear_role = 15,
	bgm = 12,
	vocal = 11,
	bg_voice = 17,
	terminal_type = 26,
	hide_name = 21,
	terminal_effect = 24,
	talk_in_ani = 23,
	terminal_bg = 25,
	page = 5,
	talk_type = 2,
	head_emoji = 9,
	action = 7,
	switch_show = 16,
	font_size = 22,
	extra_npc = 20,
	bg_id = 18,
	talk = 3,
	branch_info = 27,
	id = 1,
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
	[2] = 217,
	[3] = {
		3
	}
}
RTResTalkAction[2] = {
	[1] = 1,
	[2] = 217
}
RTResTalkAction[3] = {
	[1] = 2,
	[2] = 217
}
RTResTalkAction[4] = {
	3,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[6] = {
	[1] = 1,
	[2] = 133
}
RTResTalkAction[7] = {
	[1] = 0,
	[2] = 217
}
RTResTalkAction[8] = {
	[1] = 0,
	[2] = 133
}
RTResTalkAction[9] = {
	1,
	107,
	nil,
	nil,
	1
}
RTResTalkAction[10] = {
	1,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[11] = {
	[1] = 1,
	[2] = 235
}
RTResTalkAction[12] = {
	[1] = 0,
	[2] = 235
}
RTResTalkAction[13] = {
	1,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[14] = {
	1,
	107,
	{
		1
	},
	nil,
	5
}
RTResTalkAction[15] = {
	[1] = 1,
	[2] = 107,
	[3] = {
		1
	}
}

local Data = {
	[192001] = {
		192001,
		0,
		Lang.get(50994),
		192,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		192,
		nil,
		nil,
		nil,
		nil,
		192
	},
	[192002] = {
		192002,
		0,
		Lang.get(50995),
		192,
		2,
		133,
		nil,
		1
	},
	[192003] = {
		192003,
		0,
		Lang.get(50996),
		192,
		3,
		217,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[192004] = {
		192004,
		0,
		Lang.get(50997),
		192,
		4,
		217,
		{
			RTResTalkAction[2]
		}
	},
	[192005] = {
		192005,
		0,
		Lang.get(50998),
		192,
		5,
		107,
		{
			RTResTalkAction[3],
			RTResTalkAction[4]
		}
	},
	[192006] = {
		192006,
		0,
		Lang.get(50999),
		192,
		6,
		217,
		{
			RTResTalkAction[1],
			RTResTalkAction[5]
		}
	},
	[192007] = {
		192007,
		0,
		Lang.get(51000),
		192,
		7,
		133,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[192008] = {
		192008,
		0,
		Lang.get(51001),
		192,
		8,
		217,
		{
			RTResTalkAction[2],
			RTResTalkAction[8]
		}
	},
	[192009] = {
		192009,
		4,
		nil,
		192,
		9,
		300,
		{
			RTResTalkAction[7]
		},
		[27] = {
			{
				id = 192010,
				branch_content = Lang.get(51002)
			}
		}
	},
	[192010] = {
		192010,
		0,
		Lang.get(51003),
		192,
		10,
		107,
		{
			RTResTalkAction[9]
		}
	},
	[192011] = {
		192011,
		0,
		Lang.get(51004),
		192,
		11,
		217,
		{
			RTResTalkAction[2],
			RTResTalkAction[5]
		}
	},
	[192012] = {
		192012,
		4,
		nil,
		192,
		12,
		300,
		{
			RTResTalkAction[7]
		},
		[27] = {
			{
				id = 192013,
				branch_content = Lang.get(51005)
			}
		}
	},
	[192013] = {
		192013,
		0,
		Lang.get(51006),
		192,
		13,
		133,
		{
			RTResTalkAction[6]
		}
	},
	[192014] = {
		192014,
		0,
		Lang.get(51007),
		192,
		14,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[8]
		}
	},
	[192015] = {
		192015,
		0,
		Lang.get(51008),
		192,
		15,
		235,
		{
			RTResTalkAction[11],
			RTResTalkAction[5]
		}
	},
	[192016] = {
		192016,
		5,
		Lang.get(51009),
		192,
		16,
		217,
		{
			RTResTalkAction[1],
			RTResTalkAction[12]
		}
	},
	[192017] = {
		192017,
		0,
		Lang.get(51010),
		192,
		17,
		107,
		{
			RTResTalkAction[9],
			RTResTalkAction[7]
		}
	},
	[192018] = {
		192018,
		0,
		Lang.get(51011),
		192,
		18,
		107,
		{
			RTResTalkAction[13]
		}
	},
	[192019] = {
		192019,
		0,
		Lang.get(51012),
		192,
		19,
		107,
		{
			RTResTalkAction[14]
		}
	},
	[192020] = {
		192020,
		0,
		Lang.get(51013),
		192,
		20,
		107,
		{
			RTResTalkAction[15]
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
