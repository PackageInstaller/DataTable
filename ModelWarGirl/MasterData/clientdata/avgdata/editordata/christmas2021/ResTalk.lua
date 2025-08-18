-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\Christmas2021\\ResTalk.lua

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
	[2] = 107,
	[3] = {
		2
	}
}
RTResTalkAction[2] = {
	1,
	133,
	nil,
	nil,
	1
}
RTResTalkAction[3] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[4] = {
	[1] = 1,
	[2] = 265
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 133
}
RTResTalkAction[6] = {
	[1] = 2,
	[2] = 265
}
RTResTalkAction[7] = {
	[1] = 3,
	[2] = 107
}
RTResTalkAction[8] = {
	[1] = 0,
	[2] = 265
}
RTResTalkAction[9] = {
	1,
	133,
	nil,
	nil,
	0
}
RTResTalkAction[10] = {
	1,
	107,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[11] = {
	[1] = 1,
	[2] = 267
}
RTResTalkAction[12] = {
	[1] = 0,
	[2] = 267
}
RTResTalkAction[13] = {
	[1] = 1,
	[2] = 107,
	[3] = {
		2,
		1003
	}
}

local Data = {
	[25800001] = {
		25800001,
		11,
		"Videos/AVG_xmas_2021.mp4",
		25800,
		1
	},
	[25800002] = {
		25800002,
		0,
		Lang.get(59287),
		25800,
		2,
		265,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		25800,
		[19] = 25800
	},
	[25800003] = {
		25800003,
		0,
		Lang.get(59288),
		25800,
		3,
		266,
		nil,
		1
	},
	[25800004] = {
		25800004,
		0,
		Lang.get(59289),
		25800,
		4,
		107,
		nil,
		1
	},
	[25800005] = {
		25800005,
		0,
		Lang.get(59290),
		25800,
		5,
		133,
		nil,
		1
	},
	[25800006] = {
		25800006,
		0,
		Lang.get(59291),
		25800,
		6,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[25800007] = {
		25800007,
		2,
		Lang.get(59292),
		25800,
		7,
		133,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[25800008] = {
		25800008,
		0,
		Lang.get(59293),
		25800,
		8,
		265,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[25800009] = {
		25800009,
		5,
		Lang.get(59294),
		25800,
		9,
		107,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[25800010] = {
		25800010,
		0,
		Lang.get(59295),
		25800,
		10,
		265,
		{
			RTResTalkAction[4],
			RTResTalkAction[3]
		}
	},
	[25800011] = {
		25800011,
		0,
		Lang.get(59296),
		25800,
		11,
		107,
		{
			RTResTalkAction[8]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		25801,
		[19] = 25801
	},
	[25800012] = {
		25800012,
		2,
		Lang.get(59297),
		25800,
		12,
		133,
		{
			RTResTalkAction[9]
		}
	},
	[25800013] = {
		25800013,
		0,
		"Surprise——！",
		25800,
		13,
		267,
		{
			RTResTalkAction[5]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		25802
	},
	[25800014] = {
		25800014,
		5,
		Lang.get(59298),
		25800,
		14,
		107,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3
	},
	[25800015] = {
		25800015,
		0,
		Lang.get(59299),
		25800,
		15,
		267,
		{
			RTResTalkAction[11],
			RTResTalkAction[3]
		}
	},
	[25800016] = {
		25800016,
		0,
		Lang.get(59300),
		25800,
		16,
		267,
		{
			RTResTalkAction[12]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		25803,
		[19] = 25802
	},
	[25800017] = {
		25800017,
		0,
		Lang.get(59301),
		25800,
		17,
		107,
		nil,
		1,
		4
	},
	[25800018] = {
		25800018,
		0,
		Lang.get(59302),
		25800,
		18,
		267,
		nil,
		1,
		0
	},
	[25800019] = {
		25800019,
		0,
		Lang.get(59303),
		25800,
		19,
		267,
		nil,
		1
	},
	[25800020] = {
		25800020,
		0,
		Lang.get(59304),
		25800,
		20,
		265,
		{
			RTResTalkAction[4]
		}
	},
	[25800021] = {
		25800021,
		0,
		Lang.get(59305),
		25800,
		21,
		265,
		{
			RTResTalkAction[4]
		}
	},
	[25810001] = {
		25810001,
		11,
		"Videos/AVG_xmas_2021.mp4",
		25810,
		1,
		265
	},
	[25810002] = {
		25810002,
		0,
		Lang.get(59287),
		25810,
		2,
		265,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		25810,
		[19] = 25810
	},
	[25810003] = {
		25810003,
		0,
		Lang.get(59288),
		25810,
		3,
		266,
		nil,
		1
	},
	[25810004] = {
		25810004,
		0,
		Lang.get(59289),
		25810,
		4,
		107,
		nil,
		1
	},
	[25810005] = {
		25810005,
		0,
		Lang.get(59290),
		25810,
		5,
		133,
		nil,
		1
	},
	[25810006] = {
		25810006,
		0,
		Lang.get(59291),
		25810,
		6,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[25810007] = {
		25810007,
		2,
		Lang.get(59292),
		25810,
		7,
		133,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[25810008] = {
		25810008,
		0,
		Lang.get(59293),
		25810,
		8,
		265,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[25810009] = {
		25810009,
		5,
		Lang.get(59294),
		25810,
		9,
		107,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[25810010] = {
		25810010,
		0,
		Lang.get(59295),
		25810,
		10,
		265,
		{
			RTResTalkAction[4],
			RTResTalkAction[3]
		}
	},
	[25810011] = {
		25810011,
		0,
		Lang.get(59306),
		25810,
		11,
		107,
		{
			RTResTalkAction[13],
			RTResTalkAction[8]
		}
	},
	[25810012] = {
		25810012,
		2,
		Lang.get(59297),
		25810,
		12,
		133,
		{
			RTResTalkAction[9],
			RTResTalkAction[3]
		}
	},
	[25810013] = {
		25810013,
		0,
		Lang.get(59307),
		25810,
		13,
		265,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[25810014] = {
		25810014,
		0,
		Lang.get(59308),
		25810,
		14,
		107,
		{
			RTResTalkAction[8]
		},
		1,
		6,
		nil,
		nil,
		nil,
		25811,
		nil,
		nil,
		nil,
		nil,
		nil,
		25811
	},
	[25810015] = {
		25810015,
		0,
		Lang.get(59309),
		25810,
		15,
		133,
		nil,
		1,
		0
	},
	[25810016] = {
		25810016,
		0,
		Lang.get(59301),
		25810,
		16,
		107,
		nil,
		1,
		4
	},
	[25810017] = {
		25810017,
		0,
		Lang.get(59304),
		25810,
		17,
		265,
		{
			RTResTalkAction[4]
		}
	},
	[25810018] = {
		25810018,
		0,
		Lang.get(59305),
		25810,
		18,
		265,
		{
			RTResTalkAction[4]
		}
	},
	[25820001] = {
		25820001,
		0,
		Lang.get(66144),
		25820,
		1,
		265,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		25820,
		[19] = 25820
	},
	[25820002] = {
		25820002,
		0,
		Lang.get(59288),
		25820,
		2,
		266,
		nil,
		1
	},
	[25820003] = {
		25820003,
		0,
		Lang.get(59289),
		25820,
		3,
		107,
		nil,
		1
	},
	[25820004] = {
		25820004,
		0,
		Lang.get(59290),
		25820,
		4,
		133,
		nil,
		1
	},
	[25820005] = {
		25820005,
		0,
		Lang.get(59291),
		25820,
		5,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[25820006] = {
		25820006,
		2,
		Lang.get(59292),
		25820,
		6,
		133,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[25820007] = {
		25820007,
		0,
		Lang.get(59293),
		25820,
		7,
		265,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[25820008] = {
		25820008,
		5,
		Lang.get(59294),
		25820,
		8,
		107,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[25820009] = {
		25820009,
		0,
		Lang.get(59295),
		25820,
		9,
		265,
		{
			RTResTalkAction[4],
			RTResTalkAction[3]
		}
	},
	[25820010] = {
		25820010,
		0,
		Lang.get(59306),
		25820,
		10,
		107,
		{
			RTResTalkAction[13],
			RTResTalkAction[8]
		}
	},
	[25820011] = {
		25820011,
		2,
		Lang.get(59297),
		25820,
		11,
		133,
		{
			RTResTalkAction[9],
			RTResTalkAction[3]
		}
	},
	[25820012] = {
		25820012,
		0,
		Lang.get(59307),
		25820,
		12,
		265,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[25820013] = {
		25820013,
		0,
		Lang.get(59308),
		25820,
		13,
		107,
		{
			RTResTalkAction[8]
		},
		1,
		6,
		nil,
		nil,
		nil,
		25821,
		nil,
		nil,
		nil,
		nil,
		nil,
		25821
	},
	[25820014] = {
		25820014,
		0,
		Lang.get(59309),
		25820,
		14,
		133,
		nil,
		1,
		0
	},
	[25820015] = {
		25820015,
		0,
		Lang.get(59301),
		25820,
		15,
		107,
		nil,
		1,
		4
	},
	[25820016] = {
		25820016,
		0,
		Lang.get(59304),
		25820,
		16,
		265,
		{
			RTResTalkAction[4]
		}
	},
	[25820017] = {
		25820017,
		0,
		Lang.get(59305),
		25820,
		17,
		265,
		{
			RTResTalkAction[4]
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
