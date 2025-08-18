-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\heiyanyure\\ResTalk.lua

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
	[2] = 107
}
RTResTalkAction[3] = {
	1,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[4] = {
	1,
	107,
	nil,
	nil,
	5
}
RTResTalkAction[5] = {
	[1] = 1,
	[2] = 103
}
RTResTalkAction[6] = {
	[1] = 2,
	[2] = 103
}
RTResTalkAction[7] = {
	[1] = 3,
	[2] = 135
}
RTResTalkAction[8] = {
	[1] = 0,
	[2] = 135
}
RTResTalkAction[9] = {
	[1] = 0,
	[2] = 103
}
RTResTalkAction[10] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[11] = {
	1,
	103,
	nil,
	nil,
	1
}
RTResTalkAction[12] = {
	2,
	103,
	nil,
	nil,
	0
}
RTResTalkAction[13] = {
	[1] = 1,
	[2] = 135
}
RTResTalkAction[14] = {
	[1] = 1,
	[2] = 196
}
RTResTalkAction[15] = {
	2,
	107,
	nil,
	nil,
	10
}
RTResTalkAction[16] = {
	[1] = 3,
	[2] = 196
}
RTResTalkAction[17] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[18] = {
	1,
	107,
	nil,
	nil,
	10
}
RTResTalkAction[19] = {
	[1] = 0,
	[2] = 196
}
RTResTalkAction[20] = {
	1,
	107,
	nil,
	nil,
	1
}

local Data = {
	[32000001] = {
		32000001,
		0,
		Lang.get(79190),
		32000,
		1,
		107,
		nil,
		1,
		7,
		nil,
		nil,
		60,
		32000,
		nil,
		nil,
		nil,
		nil,
		nil,
		32000
	},
	[32000002] = {
		32000002,
		4,
		nil,
		32000,
		2,
		107,
		nil,
		1,
		[29] = {
			{
				id = 32000003,
				branch_content = Lang.get(79191)
			},
			{
				id = 32000003,
				branch_content = Lang.get(79192)
			}
		}
	},
	[32000003] = {
		32000003,
		0,
		Lang.get(79193),
		32000,
		3,
		107,
		nil,
		1
	},
	[32000004] = {
		32000004,
		0,
		Lang.get(79194),
		32000,
		4,
		107,
		nil,
		1
	},
	[32000005] = {
		32000005,
		0,
		Lang.get(79195),
		32000,
		5,
		300
	},
	[32000006] = {
		32000006,
		0,
		Lang.get(79196),
		32000,
		6,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[32000007] = {
		32000007,
		4,
		nil,
		32000,
		7,
		107,
		{
			RTResTalkAction[2]
		},
		[29] = {
			{
				id = 32000008,
				branch_content = Lang.get(79197)
			}
		}
	},
	[32000008] = {
		32000008,
		0,
		Lang.get(79198),
		32000,
		8,
		107,
		{
			RTResTalkAction[2]
		}
	},
	[32000009] = {
		32000009,
		3,
		Lang.get(79199),
		32000,
		9,
		605,
		{
			RTResTalkAction[2]
		},
		[22] = 1
	},
	[32000010] = {
		32000010,
		0,
		Lang.get(79200),
		32000,
		10,
		107,
		{
			RTResTalkAction[3]
		}
	},
	[32000011] = {
		32000011,
		0,
		Lang.get(79201),
		32000,
		11,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[32000012] = {
		32000012,
		0,
		Lang.get(79202),
		32000,
		12,
		107,
		{
			RTResTalkAction[4]
		}
	},
	[32001001] = {
		32001001,
		0,
		Lang.get(79203),
		32001,
		1,
		103,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		32001,
		[19] = 32001
	},
	[32001002] = {
		32001002,
		0,
		Lang.get(79204),
		32001,
		2,
		107,
		nil,
		1,
		7
	},
	[32001003] = {
		32001003,
		0,
		Lang.get(79205),
		32001,
		3,
		135,
		nil,
		1,
		0
	},
	[32001004] = {
		32001004,
		0,
		Lang.get(79206),
		32001,
		4,
		103,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		3
	},
	[32001005] = {
		32001005,
		0,
		Lang.get(79207),
		32001,
		5,
		135,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[32001006] = {
		32001006,
		0,
		Lang.get(79208),
		32001,
		6,
		103,
		{
			RTResTalkAction[5],
			RTResTalkAction[8]
		}
	},
	[32001007] = {
		32001007,
		0,
		Lang.get(79209),
		32001,
		7,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[9]
		}
	},
	[32001008] = {
		32001008,
		0,
		Lang.get(79210),
		32001,
		8,
		103,
		{
			RTResTalkAction[5],
			RTResTalkAction[10]
		}
	},
	[32001009] = {
		32001009,
		0,
		Lang.get(79211),
		32001,
		9,
		135,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[32001010] = {
		32001010,
		0,
		Lang.get(79212),
		32001,
		10,
		103,
		{
			RTResTalkAction[11],
			RTResTalkAction[8]
		}
	},
	[32001011] = {
		32001011,
		4,
		nil,
		32001,
		11,
		103,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		nil,
		nil,
		60,
		[29] = {
			{
				id = 32001012,
				branch_content = Lang.get(79197)
			}
		}
	},
	[32001012] = {
		32001012,
		0,
		Lang.get(79213),
		32001,
		12,
		103,
		{
			RTResTalkAction[12],
			RTResTalkAction[7]
		}
	},
	[32001013] = {
		32001013,
		0,
		Lang.get(79214),
		32001,
		13,
		135,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[32001014] = {
		32001014,
		0,
		Lang.get(79215),
		32001,
		14,
		300,
		{
			RTResTalkAction[13],
			RTResTalkAction[9]
		}
	},
	[32001015] = {
		32001015,
		4,
		nil,
		32001,
		15,
		300,
		{
			RTResTalkAction[13]
		},
		[29] = {
			{
				id = 32001016,
				branch_content = Lang.get(79216)
			},
			{
				id = 32001016,
				branch_content = Lang.get(79217)
			}
		}
	},
	[32001016] = {
		32001016,
		0,
		Lang.get(79218),
		32001,
		16,
		103,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[32001017] = {
		32001017,
		0,
		Lang.get(79219),
		32001,
		17,
		135,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[32001018] = {
		32001018,
		0,
		Lang.get(79220),
		32001,
		18,
		300,
		{
			RTResTalkAction[13],
			RTResTalkAction[9]
		}
	},
	[32001019] = {
		32001019,
		0,
		Lang.get(79221),
		32001,
		19,
		135,
		{
			RTResTalkAction[13]
		}
	},
	[32001020] = {
		32001020,
		0,
		Lang.get(79222),
		32001,
		20,
		107,
		{
			RTResTalkAction[3],
			RTResTalkAction[8]
		}
	},
	[32002001] = {
		32002001,
		0,
		Lang.get(79223),
		32002,
		1,
		196,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		32002,
		nil,
		nil,
		nil,
		nil,
		nil,
		32002
	},
	[32002002] = {
		32002002,
		0,
		Lang.get(79224),
		32002,
		2,
		300
	},
	[32002003] = {
		32002003,
		0,
		Lang.get(79225),
		32002,
		3,
		196,
		nil,
		1,
		2
	},
	[32002004] = {
		32002004,
		0,
		Lang.get(79226),
		32002,
		4,
		300
	},
	[32002005] = {
		32002005,
		0,
		Lang.get(79227),
		32002,
		5,
		107,
		nil,
		1,
		7,
		nil,
		nil,
		60
	},
	[32002006] = {
		32002006,
		0,
		Lang.get(79228),
		32002,
		6,
		196,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[32002007] = {
		32002007,
		4,
		nil,
		32002,
		7,
		196,
		{
			RTResTalkAction[14]
		},
		[29] = {
			{
				id = 32002008,
				branch_content = Lang.get(79197)
			}
		}
	},
	[32002008] = {
		32002008,
		0,
		Lang.get(79229),
		32002,
		8,
		196,
		{
			RTResTalkAction[14]
		}
	},
	[32002009] = {
		32002009,
		0,
		Lang.get(79230),
		32002,
		9,
		196,
		{
			RTResTalkAction[14]
		}
	},
	[32002010] = {
		32002010,
		0,
		Lang.get(79231),
		32002,
		10,
		107,
		{
			RTResTalkAction[15],
			RTResTalkAction[16]
		}
	},
	[32002011] = {
		32002011,
		0,
		Lang.get(79232),
		32002,
		11,
		196,
		{
			RTResTalkAction[17],
			RTResTalkAction[16]
		}
	},
	[32002012] = {
		32002012,
		0,
		Lang.get(79233),
		32002,
		12,
		107,
		{
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[32002013] = {
		32002013,
		0,
		Lang.get(79234),
		32002,
		13,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[32002014] = {
		32002014,
		0,
		Lang.get(79235),
		32002,
		14,
		107,
		{
			RTResTalkAction[3]
		}
	},
	[32002015] = {
		32002015,
		0,
		Lang.get(79236),
		32002,
		15,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[32002016] = {
		32002016,
		0,
		Lang.get(79237),
		32002,
		16,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[32002017] = {
		32002017,
		0,
		Lang.get(79238),
		32002,
		17,
		107,
		{
			RTResTalkAction[20]
		}
	},
	[32002018] = {
		32002018,
		0,
		Lang.get(79239),
		32002,
		18,
		300,
		{
			RTResTalkAction[2]
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
