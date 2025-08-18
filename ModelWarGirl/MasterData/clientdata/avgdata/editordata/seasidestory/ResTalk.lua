-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\seasidestory\\ResTalk.lua

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
	[2] = 796
}
RTResTalkAction[2] = {
	[1] = 1,
	[2] = 798,
	[3] = {
		1001
	}
}
RTResTalkAction[3] = {
	[1] = 0,
	[2] = 796
}
RTResTalkAction[4] = {
	[1] = 1,
	[2] = 798
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 798
}
RTResTalkAction[6] = {
	[1] = 1,
	[2] = 798,
	[3] = {
		2
	}
}
RTResTalkAction[7] = {
	[1] = 2,
	[2] = 797
}
RTResTalkAction[8] = {
	[1] = 3,
	[2] = 798
}
RTResTalkAction[9] = {
	[1] = 2,
	[2] = 797,
	[3] = {
		1
	}
}
RTResTalkAction[10] = {
	[1] = 3,
	[2] = 798,
	[3] = {
		2
	}
}
RTResTalkAction[11] = {
	[1] = 2,
	[2] = 797,
	[3] = {
		1006
	}
}
RTResTalkAction[12] = {
	[1] = 3,
	[2] = 798,
	[3] = {
		3
	}
}
RTResTalkAction[13] = {
	[1] = 0,
	[2] = 797
}

local Data = {
	[31701001] = {
		31701001,
		0,
		Lang.get(79241),
		31701,
		1,
		796,
		nil,
		1,
		nil,
		nil,
		nil,
		187,
		31701,
		nil,
		nil,
		nil,
		nil,
		nil,
		31701
	},
	[31701002] = {
		31701002,
		0,
		Lang.get(79242),
		31701,
		2,
		796,
		nil,
		1
	},
	[31701003] = {
		31701003,
		0,
		Lang.get(79243),
		31701,
		3,
		796,
		nil,
		1
	},
	[31701004] = {
		31701004,
		0,
		Lang.get(79244),
		31701,
		4,
		796,
		nil,
		1
	},
	[31701005] = {
		31701005,
		0,
		Lang.get(79245),
		31701,
		5,
		798,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		31702,
		1,
		1,
		nil,
		nil,
		nil,
		31702
	},
	[31701006] = {
		31701006,
		0,
		Lang.get(79246),
		31701,
		6,
		796,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[31701007] = {
		31701007,
		0,
		Lang.get(79247),
		31701,
		7,
		798,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[31701008] = {
		31701008,
		0,
		Lang.get(79248),
		31701,
		8,
		798,
		{
			RTResTalkAction[4]
		}
	},
	[31701009] = {
		31701009,
		0,
		Lang.get(19557),
		31701,
		9,
		798,
		{
			RTResTalkAction[4]
		}
	},
	[31701010] = {
		31701010,
		0,
		Lang.get(79249),
		31701,
		10,
		797,
		{
			RTResTalkAction[5]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		31703,
		1,
		1,
		nil,
		nil,
		nil,
		31703
	},
	[31701011] = {
		31701011,
		0,
		Lang.get(79250),
		31701,
		11,
		798,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		31704,
		1,
		1,
		nil,
		nil,
		nil,
		31704
	},
	[31701012] = {
		31701012,
		0,
		Lang.get(79251),
		31701,
		12,
		798,
		{
			RTResTalkAction[6]
		},
		nil,
		nil,
		3
	},
	[31701013] = {
		31701013,
		0,
		Lang.get(79252),
		31701,
		13,
		797,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[31701014] = {
		31701014,
		0,
		Lang.get(79253),
		31701,
		14,
		798,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[31701015] = {
		31701015,
		0,
		Lang.get(79254),
		31701,
		15,
		797,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[31701016] = {
		31701016,
		0,
		Lang.get(79255),
		31701,
		16,
		797,
		{
			RTResTalkAction[9],
			RTResTalkAction[8]
		}
	},
	[31701017] = {
		31701017,
		0,
		Lang.get(79256),
		31701,
		17,
		798,
		{
			RTResTalkAction[7],
			RTResTalkAction[10]
		}
	},
	[31701018] = {
		31701018,
		0,
		Lang.get(79257),
		31701,
		18,
		797,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[31701019] = {
		31701019,
		0,
		Lang.get(79258),
		31701,
		19,
		797,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[31701020] = {
		31701020,
		0,
		Lang.get(79259),
		31701,
		20,
		798,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[31701021] = {
		31701021,
		0,
		Lang.get(79260),
		31701,
		21,
		797,
		{
			RTResTalkAction[11],
			RTResTalkAction[8]
		}
	},
	[31701022] = {
		31701022,
		0,
		Lang.get(79261),
		31701,
		22,
		798,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[31701023] = {
		31701023,
		0,
		Lang.get(79262),
		31701,
		23,
		798,
		{
			RTResTalkAction[7],
			RTResTalkAction[10]
		}
	},
	[31701024] = {
		31701024,
		5,
		Lang.get(79263),
		31701,
		24,
		798,
		{
			RTResTalkAction[7],
			RTResTalkAction[12]
		}
	},
	[31701025] = {
		31701025,
		3,
		Lang.get(79264),
		31701,
		25,
		605,
		{
			RTResTalkAction[13],
			RTResTalkAction[5]
		},
		[22] = 1,
		[20] = 160
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
