-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\paojieyure\\ResTalk.lua

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
	[1] = 0,
	[2] = 107
}
RTResTalkAction[3] = {
	[1] = 1,
	[2] = 750
}
RTResTalkAction[4] = {
	[1] = 0,
	[2] = 750
}
RTResTalkAction[5] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[6] = {
	[1] = 3,
	[2] = 750
}
RTResTalkAction[7] = {
	[1] = 1,
	[2] = 752
}
RTResTalkAction[8] = {
	[1] = 0,
	[2] = 752
}
RTResTalkAction[9] = {
	[1] = 2,
	[2] = 750
}
RTResTalkAction[10] = {
	[1] = 3,
	[2] = 752
}

local Data = {
	[29101001] = {
		29101001,
		0,
		Lang.get(69949),
		29101,
		1,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		29101,
		[19] = 29101
	},
	[29101002] = {
		29101002,
		0,
		Lang.get(69950),
		29101,
		2,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[29101003] = {
		29101003,
		0,
		Lang.get(69951),
		29101,
		3,
		107,
		nil,
		1,
		5
	},
	[29101004] = {
		29101004,
		0,
		Lang.get(69952),
		29101,
		4,
		750,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		5
	},
	[29101005] = {
		29101005,
		0,
		Lang.get(69953),
		29101,
		5,
		107,
		{
			RTResTalkAction[4]
		},
		1,
		nil,
		-1
	},
	[29101006] = {
		29101006,
		0,
		Lang.get(69954),
		29101,
		6,
		107,
		nil,
		1
	},
	[29101007] = {
		29101007,
		0,
		Lang.get(69955),
		29101,
		7,
		107,
		{
			RTResTalkAction[5],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[29101008] = {
		29101008,
		0,
		Lang.get(69956),
		29101,
		8,
		750,
		{
			RTResTalkAction[5],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[29101009] = {
		29101009,
		0,
		Lang.get(69957),
		29101,
		9,
		107,
		{
			RTResTalkAction[5],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[29101010] = {
		29101010,
		0,
		Lang.get(69958),
		29101,
		10,
		107,
		{
			RTResTalkAction[5],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[29101011] = {
		29101011,
		0,
		Lang.get(69959),
		29101,
		11,
		750,
		{
			RTResTalkAction[5],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[29101012] = {
		29101012,
		0,
		Lang.get(69960),
		29101,
		12,
		107,
		{
			RTResTalkAction[5],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[29101013] = {
		29101013,
		0,
		Lang.get(69961),
		29101,
		13,
		752,
		{
			RTResTalkAction[7],
			RTResTalkAction[2],
			RTResTalkAction[4]
		},
		nil,
		nil,
		5,
		nil,
		nil,
		29104,
		[19] = 29104
	},
	[29101014] = {
		29101014,
		0,
		Lang.get(69962),
		29101,
		14,
		752,
		{
			RTResTalkAction[8]
		},
		1,
		nil,
		-1
	},
	[29101015] = {
		29101015,
		0,
		Lang.get(69963),
		29101,
		15,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		5
	},
	[29101016] = {
		29101016,
		0,
		Lang.get(69964),
		29101,
		16,
		300,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		-1
	},
	[29101017] = {
		29101017,
		5,
		Lang.get(69965),
		29101,
		17,
		750,
		{
			RTResTalkAction[9],
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[29101018] = {
		29101018,
		0,
		Lang.get(69966),
		29101,
		18,
		750,
		{
			RTResTalkAction[9],
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[29101019] = {
		29101019,
		0,
		Lang.get(69967),
		29101,
		19,
		752,
		{
			RTResTalkAction[9],
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[29101020] = {
		29101020,
		0,
		Lang.get(69968),
		29101,
		20,
		750,
		{
			RTResTalkAction[9],
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[29101021] = {
		29101021,
		0,
		Lang.get(69969),
		29101,
		21,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[8]
		},
		1,
		nil,
		-1
	},
	[29101022] = {
		29101022,
		0,
		Lang.get(69970),
		29101,
		22,
		300
	},
	[29102001] = {
		29102001,
		0,
		Lang.get(69971),
		29102,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		29102,
		[19] = 29102
	},
	[29102002] = {
		29102002,
		0,
		Lang.get(69972),
		29102,
		2,
		300
	},
	[29102003] = {
		29102003,
		0,
		Lang.get(69973),
		29102,
		3,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		5
	},
	[29102004] = {
		29102004,
		0,
		Lang.get(69974),
		29102,
		4,
		752,
		{
			RTResTalkAction[5],
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[29102005] = {
		29102005,
		5,
		Lang.get(69975),
		29102,
		5,
		107,
		{
			RTResTalkAction[5],
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[29102006] = {
		29102006,
		0,
		Lang.get(69976),
		29102,
		6,
		300,
		{
			RTResTalkAction[2],
			RTResTalkAction[8]
		},
		nil,
		nil,
		-1
	},
	[29102007] = {
		29102007,
		0,
		Lang.get(69977),
		29102,
		7,
		752,
		{
			RTResTalkAction[5],
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[29102008] = {
		29102008,
		0,
		Lang.get(69978),
		29102,
		8,
		107,
		{
			RTResTalkAction[5],
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[29102009] = {
		29102009,
		0,
		Lang.get(69979),
		29102,
		9,
		300,
		{
			RTResTalkAction[2],
			RTResTalkAction[8]
		},
		nil,
		nil,
		-1
	},
	[29102010] = {
		29102010,
		0,
		Lang.get(69980),
		29102,
		10,
		107,
		{
			RTResTalkAction[5],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[29102011] = {
		29102011,
		0,
		Lang.get(69981),
		29102,
		11,
		750,
		{
			RTResTalkAction[5],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[29102012] = {
		29102012,
		5,
		Lang.get(69982),
		29102,
		12,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[4]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		29105,
		[19] = 29105
	},
	[29102013] = {
		29102013,
		0,
		Lang.get(69983),
		29102,
		13,
		300
	},
	[29102014] = {
		29102014,
		0,
		Lang.get(69984),
		29102,
		14,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		5
	},
	[29103001] = {
		29103001,
		0,
		Lang.get(69985),
		29103,
		1,
		752,
		{
			RTResTalkAction[9],
			RTResTalkAction[10]
		},
		nil,
		nil,
		5,
		nil,
		nil,
		29103,
		[19] = 29103
	},
	[29103002] = {
		29103002,
		0,
		Lang.get(69986),
		29103,
		2,
		750,
		{
			RTResTalkAction[9],
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[29103003] = {
		29103003,
		0,
		Lang.get(69987),
		29103,
		3,
		752,
		{
			RTResTalkAction[9],
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[29103004] = {
		29103004,
		0,
		Lang.get(69988),
		29103,
		4,
		752,
		{
			RTResTalkAction[9],
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[29103005] = {
		29103005,
		0,
		Lang.get(69989),
		29103,
		5,
		107,
		{
			RTResTalkAction[5],
			RTResTalkAction[6],
			RTResTalkAction[8]
		},
		nil,
		nil,
		5
	},
	[29103006] = {
		29103006,
		0,
		Lang.get(69990),
		29103,
		6,
		750,
		{
			RTResTalkAction[5],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[29103007] = {
		29103007,
		0,
		Lang.get(69960),
		29103,
		7,
		107,
		{
			RTResTalkAction[5],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[29103008] = {
		29103008,
		0,
		"……",
		29103,
		8,
		750,
		{
			RTResTalkAction[5],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[29103009] = {
		29103009,
		0,
		Lang.get(69991),
		29103,
		9,
		107,
		{
			RTResTalkAction[5],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[29103010] = {
		29103010,
		0,
		Lang.get(69992),
		29103,
		10,
		750,
		{
			RTResTalkAction[5],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[29103011] = {
		29103011,
		0,
		Lang.get(69993),
		29103,
		11,
		300,
		{
			RTResTalkAction[2],
			RTResTalkAction[4]
		},
		nil,
		nil,
		-1
	},
	[29103012] = {
		29103012,
		0,
		Lang.get(69994),
		29103,
		12,
		107,
		{
			RTResTalkAction[5],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[29103013] = {
		29103013,
		0,
		"……",
		29103,
		13,
		750,
		{
			RTResTalkAction[5],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[29103014] = {
		29103014,
		5,
		Lang.get(69995),
		29103,
		14,
		750,
		{
			RTResTalkAction[5],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5,
		nil,
		nil,
		29106,
		[19] = 29106
	},
	[29103015] = {
		29103015,
		0,
		Lang.get(69996),
		29103,
		15,
		300,
		{
			RTResTalkAction[2],
			RTResTalkAction[4]
		},
		nil,
		nil,
		-1
	},
	[29103016] = {
		29103016,
		5,
		Lang.get(16919),
		29103,
		16,
		300
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
