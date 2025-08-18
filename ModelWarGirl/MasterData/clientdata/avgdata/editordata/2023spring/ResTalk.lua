-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\2023spring\\ResTalk.lua

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
	[2] = 1024
}
RTResTalkAction[2] = {
	[1] = 1,
	[2] = 1014
}
RTResTalkAction[3] = {
	[1] = 0,
	[2] = 1024
}
RTResTalkAction[4] = {
	[1] = 0,
	[2] = 1014
}
RTResTalkAction[5] = {
	1,
	107,
	nil,
	nil,
	5
}
RTResTalkAction[6] = {
	1,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[7] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[8] = {
	1,
	107,
	nil,
	nil,
	1
}
RTResTalkAction[9] = {
	[1] = 1,
	[2] = 1213
}
RTResTalkAction[10] = {
	[1] = 1,
	[2] = 559
}
RTResTalkAction[11] = {
	[1] = 0,
	[2] = 1213
}
RTResTalkAction[12] = {
	[1] = 1,
	[2] = 1213,
	[3] = {
		3
	}
}
RTResTalkAction[13] = {
	[1] = 0,
	[2] = 559
}
RTResTalkAction[14] = {
	[1] = 1,
	[2] = 107,
	[3] = {
		3
	}
}
RTResTalkAction[15] = {
	[1] = 1,
	[2] = 1193
}
RTResTalkAction[16] = {
	[1] = 0,
	[2] = 1193
}
RTResTalkAction[17] = {
	1,
	107,
	nil,
	nil,
	4
}
RTResTalkAction[18] = {
	1,
	107,
	nil,
	nil,
	7
}
RTResTalkAction[19] = {
	[1] = 1,
	[2] = 133
}
RTResTalkAction[20] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[21] = {
	[1] = 0,
	[2] = 133
}

local Data = {
	[36391001] = {
		36391001,
		0,
		Lang.get(96950),
		36391,
		1,
		1014,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		36391,
		nil,
		1,
		nil,
		1,
		nil,
		36391
	},
	[36391002] = {
		36391002,
		5,
		Lang.get(96951),
		36391,
		2,
		1213,
		nil,
		1
	},
	[36391003] = {
		36391003,
		7,
		"107",
		36391,
		3,
		1213
	},
	[36391004] = {
		36391004,
		0,
		Lang.get(96952),
		36391,
		4,
		1024,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[36391005] = {
		36391005,
		0,
		Lang.get(96953),
		36391,
		5,
		1014,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[36391006] = {
		36391006,
		0,
		Lang.get(96954),
		36391,
		6,
		107,
		{
			RTResTalkAction[4]
		},
		1,
		5,
		-1,
		nil,
		nil,
		36392,
		nil,
		1,
		nil,
		nil,
		nil,
		36392
	},
	[36391007] = {
		36391007,
		0,
		Lang.get(96955),
		36391,
		7,
		107,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		3
	},
	[36391008] = {
		36391008,
		0,
		Lang.get(96956),
		36391,
		8,
		107,
		{
			RTResTalkAction[6]
		}
	},
	[36391009] = {
		36391009,
		0,
		Lang.get(96957),
		36391,
		9,
		107,
		{
			RTResTalkAction[7]
		},
		1,
		5,
		-1,
		nil,
		nil,
		36393,
		nil,
		1,
		nil,
		nil,
		nil,
		36393
	},
	[36391010] = {
		36391010,
		0,
		Lang.get(96958),
		36391,
		10,
		1213,
		nil,
		1
	},
	[36391011] = {
		36391011,
		0,
		Lang.get(96959),
		36391,
		11,
		107,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3
	},
	[36391012] = {
		36391012,
		0,
		Lang.get(96960),
		36391,
		12,
		605,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[22] = 1,
		[20] = 255
	},
	[36391013] = {
		36391013,
		0,
		Lang.get(96961),
		36391,
		13,
		107,
		nil,
		1,
		7,
		-1,
		nil,
		nil,
		36394,
		nil,
		nil,
		nil,
		4,
		nil,
		36394,
		-1
	},
	[36391014] = {
		36391014,
		0,
		Lang.get(96962),
		36391,
		14,
		1213,
		nil,
		1
	},
	[36391015] = {
		36391015,
		0,
		Lang.get(96963),
		36391,
		15,
		107,
		{
			RTResTalkAction[6]
		},
		nil,
		nil,
		3
	},
	[36391016] = {
		36391016,
		0,
		Lang.get(96964),
		36391,
		16,
		1213,
		{
			RTResTalkAction[9],
			RTResTalkAction[7]
		}
	},
	[36391017] = {
		36391017,
		0,
		Lang.get(96965),
		36391,
		17,
		559,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[36391018] = {
		36391018,
		0,
		Lang.get(96966),
		36391,
		18,
		1213,
		{
			RTResTalkAction[12],
			RTResTalkAction[13]
		}
	},
	[36391019] = {
		36391019,
		5,
		Lang.get(96967),
		36391,
		19,
		605,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		nil,
		nil,
		1,
		[20] = 255
	},
	[36391020] = {
		36391020,
		0,
		Lang.get(96968),
		36391,
		20,
		107,
		nil,
		1,
		1,
		[20] = 255
	},
	[36391021] = {
		36391021,
		0,
		Lang.get(96969),
		36391,
		21,
		107,
		nil,
		1,
		8,
		nil,
		nil,
		nil,
		36395,
		nil,
		nil,
		nil,
		4,
		nil,
		36395,
		-1
	},
	[36391022] = {
		36391022,
		0,
		Lang.get(96970),
		36391,
		22,
		1180,
		nil,
		1
	},
	[36391023] = {
		36391023,
		0,
		Lang.get(96971),
		36391,
		23,
		1193,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		36396,
		[19] = 36396
	},
	[36391024] = {
		36391024,
		7,
		"106",
		36391,
		24,
		1193
	},
	[36391025] = {
		36391025,
		0,
		Lang.get(96972),
		36391,
		25,
		107,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[36391026] = {
		36391026,
		0,
		Lang.get(96973),
		36391,
		26,
		1193,
		{
			RTResTalkAction[15],
			RTResTalkAction[7]
		}
	},
	[36391027] = {
		36391027,
		0,
		Lang.get(96974),
		36391,
		27,
		107,
		{
			RTResTalkAction[5],
			RTResTalkAction[16]
		}
	},
	[36391028] = {
		36391028,
		0,
		Lang.get(96975),
		36391,
		28,
		1193,
		{
			RTResTalkAction[15],
			RTResTalkAction[7]
		}
	},
	[36391029] = {
		36391029,
		0,
		Lang.get(96976),
		36391,
		29,
		107,
		{
			RTResTalkAction[17],
			RTResTalkAction[16]
		}
	},
	[36391030] = {
		36391030,
		0,
		Lang.get(96977),
		36391,
		30,
		107,
		{
			RTResTalkAction[18]
		}
	},
	[36391031] = {
		36391031,
		0,
		Lang.get(96978),
		36391,
		31,
		1193,
		{
			RTResTalkAction[15],
			RTResTalkAction[7]
		}
	},
	[36391032] = {
		36391032,
		0,
		Lang.get(96979),
		36391,
		32,
		107,
		{
			RTResTalkAction[14],
			RTResTalkAction[16]
		}
	},
	[36391033] = {
		36391033,
		5,
		Lang.get(96980),
		36391,
		33,
		633,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		36397,
		nil,
		1,
		nil,
		nil,
		nil,
		36397
	},
	[36391034] = {
		36391034,
		0,
		Lang.get(96981),
		36391,
		34,
		1193,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		36398,
		[19] = 36398
	},
	[36391035] = {
		36391035,
		0,
		Lang.get(96982),
		36391,
		35,
		107,
		nil,
		1,
		1
	},
	[36391036] = {
		36391036,
		0,
		Lang.get(96983),
		36391,
		36,
		107,
		nil,
		1,
		4,
		nil,
		nil,
		nil,
		36399,
		nil,
		nil,
		nil,
		nil,
		nil,
		36399
	},
	[36391037] = {
		36391037,
		0,
		Lang.get(96984),
		36391,
		37,
		107,
		nil,
		1,
		5
	},
	[36391038] = {
		36391038,
		0,
		Lang.get(96985),
		36391,
		38,
		133,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		3
	},
	[36391039] = {
		36391039,
		0,
		Lang.get(96986),
		36391,
		39,
		107,
		{
			RTResTalkAction[20],
			RTResTalkAction[21]
		}
	},
	[36391040] = {
		36391040,
		0,
		Lang.get(96987),
		36391,
		40,
		107,
		{
			RTResTalkAction[5]
		}
	},
	[36391041] = {
		36391041,
		3,
		Lang.get(96988),
		36391,
		41,
		605,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		nil,
		nil,
		1,
		[22] = 1,
		[20] = 255
	},
	[36391042] = {
		36391042,
		3,
		Lang.get(96989),
		36391,
		42,
		605,
		[22] = 1,
		[20] = 255
	},
	[36391043] = {
		36391043,
		0,
		Lang.get(96990),
		36391,
		43,
		292,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		36400,
		[19] = 36400,
		[20] = -1
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
