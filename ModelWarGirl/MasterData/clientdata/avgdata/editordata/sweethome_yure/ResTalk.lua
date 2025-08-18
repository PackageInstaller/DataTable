-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\sweethome_yure\\ResTalk.lua

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
	[2] = 134
}
RTResTalkAction[2] = {
	[1] = 2,
	[2] = 134
}
RTResTalkAction[3] = {
	[1] = 3,
	[2] = 133
}
RTResTalkAction[4] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 134
}
RTResTalkAction[6] = {
	[1] = 0,
	[2] = 133
}
RTResTalkAction[7] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[8] = {
	[1] = 3,
	[2] = 134
}
RTResTalkAction[9] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[10] = {
	[1] = 3,
	[2] = 107
}

local Data = {
	[31501001] = {
		31501001,
		0,
		Lang.get(72235),
		31501,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		31501,
		nil,
		nil,
		nil,
		1,
		nil,
		31501
	},
	[31501002] = {
		31501002,
		0,
		Lang.get(72236),
		31501,
		2,
		133,
		nil,
		1
	},
	[31501003] = {
		31501003,
		0,
		Lang.get(72237),
		31501,
		3,
		134,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[31501004] = {
		31501004,
		0,
		Lang.get(72238),
		31501,
		4,
		133,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[31501005] = {
		31501005,
		0,
		Lang.get(72239),
		31501,
		5,
		134,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[31501006] = {
		31501006,
		0,
		Lang.get(72240),
		31501,
		6,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[5],
			RTResTalkAction[6]
		}
	},
	[31501007] = {
		31501007,
		0,
		Lang.get(72241),
		31501,
		7,
		107,
		{
			RTResTalkAction[4]
		}
	},
	[31501008] = {
		31501008,
		0,
		Lang.get(72242),
		31501,
		8,
		107,
		{
			RTResTalkAction[4]
		}
	},
	[31501009] = {
		31501009,
		0,
		Lang.get(72243),
		31501,
		9,
		134,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[31501010] = {
		31501010,
		0,
		Lang.get(72244),
		31501,
		10,
		134,
		{
			RTResTalkAction[1],
			RTResTalkAction[9]
		}
	},
	[31501011] = {
		31501011,
		4,
		nil,
		31501,
		11,
		134,
		{
			RTResTalkAction[1]
		},
		[29] = {
			{
				id = 31501012,
				branch_content = Lang.get(72245)
			}
		}
	},
	[31501012] = {
		31501012,
		0,
		Lang.get(72246),
		31501,
		12,
		300,
		{
			RTResTalkAction[5]
		}
	},
	[31501013] = {
		31501013,
		0,
		Lang.get(72247),
		31501,
		13,
		107,
		{
			RTResTalkAction[4]
		}
	},
	[31501014] = {
		31501014,
		0,
		Lang.get(72248),
		31501,
		14,
		134,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[31502001] = {
		31502001,
		0,
		Lang.get(72249),
		31502,
		1,
		134,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		31502,
		nil,
		nil,
		nil,
		1,
		nil,
		31502
	},
	[31502002] = {
		31502002,
		0,
		Lang.get(72250),
		31502,
		2,
		107,
		nil,
		1
	},
	[31502003] = {
		31502003,
		0,
		Lang.get(72251),
		31502,
		3,
		134,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[31502004] = {
		31502004,
		0,
		Lang.get(72252),
		31502,
		4,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[10]
		}
	},
	[31502005] = {
		31502005,
		0,
		Lang.get(72253),
		31502,
		5,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[31502006] = {
		31502006,
		0,
		Lang.get(72254),
		31502,
		6,
		107,
		{
			RTResTalkAction[4]
		}
	},
	[31502007] = {
		31502007,
		0,
		Lang.get(72255),
		31502,
		7,
		134,
		{
			RTResTalkAction[2],
			RTResTalkAction[10]
		}
	},
	[31502008] = {
		31502008,
		0,
		Lang.get(72256),
		31502,
		8,
		300,
		{
			RTResTalkAction[5],
			RTResTalkAction[9]
		}
	},
	[31502009] = {
		31502009,
		0,
		Lang.get(72257),
		31502,
		9,
		107,
		{
			RTResTalkAction[4]
		}
	},
	[31502010] = {
		31502010,
		0,
		Lang.get(72258),
		31502,
		10,
		300,
		{
			RTResTalkAction[9]
		}
	},
	[31502011] = {
		31502011,
		0,
		Lang.get(72259),
		31502,
		11,
		107,
		{
			RTResTalkAction[4]
		}
	},
	[31502012] = {
		31502012,
		0,
		Lang.get(72260),
		31502,
		12,
		107,
		{
			RTResTalkAction[4]
		}
	},
	[31502013] = {
		31502013,
		0,
		Lang.get(72261),
		31502,
		13,
		134,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[31502014] = {
		31502014,
		5,
		Lang.get(72262),
		31502,
		14,
		134,
		{
			RTResTalkAction[1],
			RTResTalkAction[9]
		}
	},
	[31502015] = {
		31502015,
		2,
		Lang.get(72263),
		31502,
		15,
		300,
		{
			RTResTalkAction[5]
		}
	},
	[31503001] = {
		31503001,
		0,
		Lang.get(72264),
		31503,
		1,
		134,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		31503,
		nil,
		nil,
		nil,
		nil,
		nil,
		31503
	},
	[31503002] = {
		31503002,
		0,
		Lang.get(72265),
		31503,
		2,
		107,
		nil,
		1
	},
	[31503003] = {
		31503003,
		0,
		Lang.get(72266),
		31503,
		3,
		134,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[31503004] = {
		31503004,
		0,
		Lang.get(72267),
		31503,
		4,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[10]
		}
	},
	[31503005] = {
		31503005,
		0,
		Lang.get(72268),
		31503,
		5,
		134,
		{
			RTResTalkAction[2],
			RTResTalkAction[10]
		}
	},
	[31503006] = {
		31503006,
		0,
		Lang.get(72269),
		31503,
		6,
		134,
		{
			RTResTalkAction[2],
			RTResTalkAction[10]
		}
	},
	[31503007] = {
		31503007,
		0,
		Lang.get(72270),
		31503,
		7,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[10]
		}
	},
	[31503008] = {
		31503008,
		0,
		Lang.get(72271),
		31503,
		8,
		134,
		{
			RTResTalkAction[2],
			RTResTalkAction[10]
		}
	},
	[31503009] = {
		31503009,
		9,
		Lang.get(72272),
		31503,
		9,
		605,
		{
			RTResTalkAction[5],
			RTResTalkAction[9]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		31504,
		nil,
		1,
		nil,
		1,
		nil,
		31504,
		nil,
		nil,
		1
	},
	[31503010] = {
		31503010,
		0,
		Lang.get(72273),
		31503,
		10,
		134,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[31503011] = {
		31503011,
		4,
		nil,
		31503,
		11,
		134,
		{
			RTResTalkAction[2],
			RTResTalkAction[10]
		},
		[29] = {
			{
				id = 31503012,
				branch_content = Lang.get(72274)
			}
		}
	},
	[31503012] = {
		31503012,
		0,
		Lang.get(72275),
		31503,
		12,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[10]
		}
	},
	[31503013] = {
		31503013,
		0,
		Lang.get(72276),
		31503,
		13,
		134,
		{
			RTResTalkAction[2],
			RTResTalkAction[10]
		}
	},
	[31503014] = {
		31503014,
		0,
		Lang.get(72277),
		31503,
		14,
		300,
		{
			RTResTalkAction[5],
			RTResTalkAction[9]
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
