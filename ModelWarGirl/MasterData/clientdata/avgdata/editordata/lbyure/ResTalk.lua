-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\LByure\\ResTalk.lua

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
	[2] = 1289
}
RTResTalkAction[2] = {
	[1] = 2,
	[2] = 1289
}
RTResTalkAction[3] = {
	[1] = 3,
	[2] = 1290
}
RTResTalkAction[4] = {
	2,
	1289,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[5] = {
	1,
	1290,
	nil,
	nil,
	1
}
RTResTalkAction[6] = {
	[1] = 0,
	[2] = 1289
}
RTResTalkAction[7] = {
	1,
	1290,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[8] = {
	[1] = 0,
	[2] = 1290
}
RTResTalkAction[9] = {
	[1] = 1,
	[2] = 1069,
	[3] = {
		1
	}
}
RTResTalkAction[10] = {
	[1] = 1,
	[2] = 1069
}
RTResTalkAction[11] = {
	[1] = 0,
	[2] = 1069
}
RTResTalkAction[12] = {
	1,
	1290,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[13] = {
	1,
	1290,
	nil,
	nil,
	0
}
RTResTalkAction[14] = {
	[1] = 2,
	[2] = 1069
}
RTResTalkAction[15] = {
	3,
	1290,
	nil,
	nil,
	0
}

local Data = {
	[41000001] = {
		41000001,
		3,
		Lang.get(109765),
		41000,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		41000,
		[19] = 41000,
		[22] = 1
	},
	[41000002] = {
		41000002,
		0,
		Lang.get(109766),
		41000,
		2,
		1290,
		nil,
		1
	},
	[41000003] = {
		41000003,
		0,
		Lang.get(109767),
		41000,
		3,
		1290,
		nil,
		1
	},
	[41000004] = {
		41000004,
		0,
		Lang.get(109768),
		41000,
		4,
		1289,
		nil,
		1
	},
	[41000005] = {
		41000005,
		0,
		Lang.get(109769),
		41000,
		5,
		1290,
		nil,
		1,
		2
	},
	[41000006] = {
		41000006,
		3,
		Lang.get(109770),
		41000,
		6,
		605,
		[22] = 1
	},
	[41000007] = {
		41000007,
		0,
		Lang.get(109771),
		41000,
		7,
		1289,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[41000008] = {
		41000008,
		0,
		Lang.get(109772),
		41000,
		8,
		1289,
		{
			RTResTalkAction[1]
		}
	},
	[41000009] = {
		41000009,
		0,
		Lang.get(109773),
		41000,
		9,
		1290,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[41000010] = {
		41000010,
		3,
		Lang.get(109774),
		41000,
		10,
		605,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		},
		[22] = 1
	},
	[41000011] = {
		41000011,
		0,
		Lang.get(109775),
		41000,
		11,
		1290,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[41000012] = {
		41000012,
		0,
		Lang.get(109776),
		41000,
		12,
		1289,
		{
			RTResTalkAction[4],
			RTResTalkAction[3]
		}
	},
	[41000013] = {
		41000013,
		0,
		Lang.get(109777),
		41000,
		13,
		1290,
		{
			RTResTalkAction[5],
			RTResTalkAction[6]
		}
	},
	[41000014] = {
		41000014,
		5,
		Lang.get(109778),
		41000,
		14,
		1290,
		{
			RTResTalkAction[7]
		}
	},
	[41000015] = {
		41000015,
		3,
		Lang.get(109779),
		41000,
		15,
		605,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[22] = 1
	},
	[41000016] = {
		41000016,
		3,
		Lang.get(109780),
		41000,
		16,
		605,
		[22] = 1
	},
	[41000017] = {
		41000017,
		0,
		Lang.get(109781),
		41000,
		17,
		1290,
		nil,
		1,
		1,
		3,
		nil,
		nil,
		41001,
		nil,
		nil,
		nil,
		nil,
		nil,
		41001
	},
	[41000018] = {
		41000018,
		0,
		Lang.get(109782),
		41000,
		18,
		1289,
		nil,
		1,
		2
	},
	[41000019] = {
		41000019,
		0,
		Lang.get(109783),
		41000,
		19,
		1289,
		nil,
		1,
		2
	},
	[41000020] = {
		41000020,
		0,
		Lang.get(109784),
		41000,
		20,
		1290,
		nil,
		1,
		1
	},
	[41000021] = {
		41000021,
		0,
		"……",
		41000,
		21,
		1289,
		nil,
		1,
		2
	},
	[41001001] = {
		41001001,
		3,
		Lang.get(109785),
		41001,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		41002,
		[19] = 41002,
		[22] = 1
	},
	[41001002] = {
		41001002,
		3,
		Lang.get(109786),
		41001,
		2,
		605,
		[22] = 1
	},
	[41001003] = {
		41001003,
		3,
		Lang.get(109787),
		41001,
		3,
		605,
		[22] = 1
	},
	[41001004] = {
		41001004,
		0,
		Lang.get(109788),
		41001,
		4,
		1069,
		nil,
		1
	},
	[41001005] = {
		41001005,
		0,
		Lang.get(109789),
		41001,
		5,
		1069,
		nil,
		1
	},
	[41001006] = {
		41001006,
		3,
		Lang.get(109779),
		41001,
		6,
		605,
		[22] = 1
	},
	[41001007] = {
		41001007,
		0,
		Lang.get(109790),
		41001,
		7,
		1069,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[41001008] = {
		41001008,
		0,
		Lang.get(109791),
		41001,
		8,
		1290,
		{
			RTResTalkAction[10]
		},
		1
	},
	[41001009] = {
		41001009,
		0,
		Lang.get(109792),
		41001,
		9,
		1069,
		{
			RTResTalkAction[10]
		}
	},
	[41001010] = {
		41001010,
		0,
		Lang.get(109793),
		41001,
		10,
		1069,
		{
			RTResTalkAction[10]
		}
	},
	[41001011] = {
		41001011,
		3,
		Lang.get(109794),
		41001,
		11,
		605,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		41003,
		nil,
		1,
		nil,
		nil,
		nil,
		41003,
		nil,
		nil,
		1
	},
	[41001012] = {
		41001012,
		0,
		Lang.get(109795),
		41001,
		12,
		1289,
		nil,
		1,
		2
	},
	[41001013] = {
		41001013,
		0,
		Lang.get(109796),
		41001,
		13,
		1290,
		nil,
		1,
		1
	},
	[41001014] = {
		41001014,
		0,
		Lang.get(109797),
		41001,
		14,
		1289,
		nil,
		1,
		3
	},
	[41001015] = {
		41001015,
		0,
		Lang.get(109798),
		41001,
		15,
		1289,
		nil,
		1,
		3
	},
	[41001016] = {
		41001016,
		0,
		Lang.get(109799),
		41001,
		16,
		1069,
		nil,
		1,
		1
	},
	[41001017] = {
		41001017,
		0,
		Lang.get(109800),
		41001,
		17,
		1290,
		nil,
		1,
		1
	},
	[41002001] = {
		41002001,
		0,
		Lang.get(109801),
		41002,
		1,
		1069,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		41004,
		nil,
		1,
		nil,
		nil,
		nil,
		41004
	},
	[41002002] = {
		41002002,
		0,
		Lang.get(109802),
		41002,
		2,
		1069,
		nil,
		1
	},
	[41002003] = {
		41002003,
		0,
		Lang.get(109803),
		41002,
		3,
		1289,
		nil,
		1
	},
	[41002004] = {
		41002004,
		0,
		Lang.get(109804),
		41002,
		4,
		1290,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		3
	},
	[41002005] = {
		41002005,
		0,
		Lang.get(109805),
		41002,
		5,
		1290,
		{
			RTResTalkAction[13]
		}
	},
	[41002006] = {
		41002006,
		0,
		Lang.get(109806),
		41002,
		6,
		1069,
		{
			RTResTalkAction[14],
			RTResTalkAction[15]
		}
	},
	[41002007] = {
		41002007,
		0,
		Lang.get(109807),
		41002,
		7,
		1069,
		{
			RTResTalkAction[14],
			RTResTalkAction[15]
		}
	},
	[41002008] = {
		41002008,
		0,
		Lang.get(109808),
		41002,
		8,
		1290,
		{
			RTResTalkAction[14],
			RTResTalkAction[15]
		}
	},
	[41002009] = {
		41002009,
		3,
		Lang.get(109809),
		41002,
		9,
		605,
		{
			RTResTalkAction[11],
			RTResTalkAction[8]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		41005,
		nil,
		1,
		nil,
		nil,
		nil,
		41005,
		nil,
		nil,
		1
	},
	[41002010] = {
		41002010,
		0,
		Lang.get(109810),
		41002,
		10,
		1069,
		nil,
		1
	},
	[41002011] = {
		41002011,
		0,
		Lang.get(109811),
		41002,
		11,
		1069,
		nil,
		1
	},
	[41002012] = {
		41002012,
		0,
		Lang.get(109812),
		41002,
		12,
		1069,
		nil,
		1
	},
	[41002013] = {
		41002013,
		0,
		Lang.get(109813),
		41002,
		13,
		1289,
		nil,
		1
	},
	[41002014] = {
		41002014,
		0,
		Lang.get(109814),
		41002,
		14,
		1290,
		nil,
		1
	},
	[41002015] = {
		41002015,
		0,
		Lang.get(109815),
		41002,
		15,
		1069,
		nil,
		1
	},
	[41002016] = {
		41002016,
		0,
		Lang.get(109816),
		41002,
		16,
		1290,
		nil,
		1
	},
	[41002017] = {
		41002017,
		0,
		Lang.get(109817),
		41002,
		17,
		1289,
		nil,
		1
	},
	[41002018] = {
		41002018,
		0,
		Lang.get(109818),
		41002,
		18,
		1289,
		nil,
		1
	},
	[41002019] = {
		41002019,
		0,
		Lang.get(109819),
		41002,
		19,
		1290,
		nil,
		1,
		2
	},
	[41002020] = {
		41002020,
		0,
		Lang.get(109820),
		41002,
		20,
		1290,
		nil,
		1,
		2
	},
	[41002021] = {
		41002021,
		0,
		Lang.get(109821),
		41002,
		21,
		1289,
		nil,
		1,
		1
	},
	[41002022] = {
		41002022,
		0,
		Lang.get(109822),
		41002,
		22,
		1069,
		nil,
		1,
		0
	},
	[41002023] = {
		41002023,
		0,
		Lang.get(109823),
		41002,
		23,
		1290,
		nil,
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
