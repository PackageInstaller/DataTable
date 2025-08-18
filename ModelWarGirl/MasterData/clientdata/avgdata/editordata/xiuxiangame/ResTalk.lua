-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\xiuxiangame\\ResTalk.lua

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
	[2] = 300
}
RTResTalkAction[2] = {
	[1] = 1,
	[2] = 151
}
RTResTalkAction[3] = {
	[1] = 1,
	[2] = 29
}
RTResTalkAction[4] = {
	[1] = 0,
	[2] = 151
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 29
}
RTResTalkAction[6] = {
	[1] = 2,
	[2] = 151
}
RTResTalkAction[7] = {
	[1] = 3,
	[2] = 20
}
RTResTalkAction[8] = {
	[1] = 0,
	[2] = 20
}
RTResTalkAction[9] = {
	[1] = 1,
	[2] = 742
}
RTResTalkAction[10] = {
	[1] = 0,
	[2] = 742
}
RTResTalkAction[11] = {
	[1] = 2,
	[2] = 141
}
RTResTalkAction[12] = {
	3,
	107,
	nil,
	nil,
	3
}
RTResTalkAction[13] = {
	[1] = 1,
	[2] = 1169
}
RTResTalkAction[14] = {
	[1] = 1,
	[2] = 141
}
RTResTalkAction[15] = {
	[1] = 0,
	[2] = 1169
}
RTResTalkAction[16] = {
	1,
	107,
	nil,
	nil,
	4
}
RTResTalkAction[17] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[18] = {
	1,
	1169,
	nil,
	nil,
	0
}
RTResTalkAction[19] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[20] = {
	[1] = 1,
	[2] = 152
}

local Data = {
	[37401001] = {
		37401001,
		0,
		Lang.get(99405),
		37401,
		1,
		300,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		nil,
		nil,
		62,
		37401,
		[19] = 37401
	},
	[37401002] = {
		37401002,
		0,
		Lang.get(99406),
		37401,
		2,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[37402001] = {
		37402001,
		0,
		Lang.get(99407),
		37402,
		1,
		151,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		37402,
		nil,
		nil,
		nil,
		nil,
		nil,
		37402
	},
	[37402002] = {
		37402002,
		0,
		Lang.get(99408),
		37402,
		2,
		300
	},
	[37402003] = {
		37402003,
		0,
		Lang.get(99409),
		37402,
		3,
		20,
		nil,
		1
	},
	[37402004] = {
		37402004,
		0,
		Lang.get(99410),
		37402,
		4,
		151,
		{
			RTResTalkAction[2]
		}
	},
	[37402005] = {
		37402005,
		0,
		Lang.get(99411),
		37402,
		5,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[37402006] = {
		37402006,
		0,
		Lang.get(99412),
		37402,
		6,
		151,
		{
			RTResTalkAction[2]
		}
	},
	[37402007] = {
		37402007,
		0,
		Lang.get(99413),
		37402,
		7,
		29,
		{
			RTResTalkAction[3],
			RTResTalkAction[4]
		}
	},
	[37402008] = {
		37402008,
		0,
		Lang.get(99414),
		37402,
		8,
		300,
		{
			RTResTalkAction[1],
			RTResTalkAction[5]
		}
	},
	[37403001] = {
		37403001,
		0,
		Lang.get(99415),
		37403,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		37403,
		[19] = 37403
	},
	[37403002] = {
		37403002,
		0,
		Lang.get(99416),
		37403,
		2,
		151,
		nil,
		1
	},
	[37403003] = {
		37403003,
		0,
		Lang.get(99417),
		37403,
		3,
		300
	},
	[37403004] = {
		37403004,
		0,
		Lang.get(99418),
		37403,
		4,
		151,
		{
			RTResTalkAction[2]
		}
	},
	[37403005] = {
		37403005,
		4,
		nil,
		37403,
		5,
		151,
		{
			RTResTalkAction[2]
		},
		[29] = {
			{
				id = 37403006,
				branch_content = Lang.get(99419)
			},
			{
				id = 37403006,
				branch_content = Lang.get(99420)
			}
		}
	},
	[37403006] = {
		37403006,
		0,
		Lang.get(99421),
		37403,
		6,
		151,
		{
			RTResTalkAction[2]
		}
	},
	[37404001] = {
		37404001,
		0,
		Lang.get(99422),
		37404,
		1,
		151,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		37403,
		nil,
		nil,
		nil,
		nil,
		nil,
		37403
	},
	[37404002] = {
		37404002,
		0,
		Lang.get(99423),
		37404,
		2,
		300
	},
	[37404003] = {
		37404003,
		0,
		Lang.get(99424),
		37404,
		3,
		151,
		nil,
		1
	},
	[37404004] = {
		37404004,
		0,
		Lang.get(99425),
		37404,
		4,
		300
	},
	[37404005] = {
		37404005,
		0,
		Lang.get(100339),
		37404,
		5,
		151,
		{
			RTResTalkAction[2]
		}
	},
	[37404006] = {
		37404006,
		0,
		Lang.get(99427),
		37404,
		6,
		151,
		{
			RTResTalkAction[2]
		}
	},
	[37404007] = {
		37404007,
		0,
		Lang.get(99428),
		37404,
		7,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[37405001] = {
		37405001,
		0,
		Lang.get(99429),
		37405,
		1,
		151,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		37405,
		nil,
		nil,
		nil,
		nil,
		nil,
		37405
	},
	[37405002] = {
		37405002,
		0,
		Lang.get(99430),
		37405,
		2,
		20,
		nil,
		1
	},
	[37405003] = {
		37405003,
		0,
		Lang.get(99431),
		37405,
		3,
		29,
		{
			RTResTalkAction[3]
		}
	},
	[37405004] = {
		37405004,
		0,
		Lang.get(99432),
		37405,
		4,
		151,
		{
			RTResTalkAction[2],
			RTResTalkAction[5]
		}
	},
	[37405005] = {
		37405005,
		0,
		Lang.get(99433),
		37405,
		5,
		20,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[37405006] = {
		37405006,
		0,
		Lang.get(99434),
		37405,
		6,
		151,
		{
			RTResTalkAction[2],
			RTResTalkAction[8]
		}
	},
	[37406001] = {
		37406001,
		0,
		Lang.get(99435),
		37406,
		1,
		151,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		37406,
		nil,
		nil,
		nil,
		nil,
		nil,
		37406
	},
	[37406002] = {
		37406002,
		0,
		Lang.get(99436),
		37406,
		2,
		300
	},
	[37406003] = {
		37406003,
		0,
		Lang.get(99437),
		37406,
		3,
		300
	},
	[37406004] = {
		37406004,
		0,
		Lang.get(99438),
		37406,
		4,
		151,
		{
			RTResTalkAction[2]
		}
	},
	[37406005] = {
		37406005,
		0,
		Lang.get(99439),
		37406,
		5,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[37406006] = {
		37406006,
		0,
		Lang.get(99440),
		37406,
		6,
		151,
		{
			RTResTalkAction[2]
		}
	},
	[37406007] = {
		37406007,
		0,
		Lang.get(99441),
		37406,
		7,
		151,
		{
			RTResTalkAction[2]
		}
	},
	[37406008] = {
		37406008,
		0,
		Lang.get(99442),
		37406,
		8,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[37406009] = {
		37406009,
		0,
		Lang.get(99443),
		37406,
		9,
		151,
		{
			RTResTalkAction[2]
		}
	},
	[37407001] = {
		37407001,
		11,
		"Videos/xinshou_2.mp4",
		37407,
		1,
		151,
		nil,
		nil,
		nil,
		nil,
		nil,
		62
	},
	[37407002] = {
		37407002,
		5,
		Lang.get(99445),
		37407,
		2,
		107,
		nil,
		1,
		3
	},
	[37407003] = {
		37407003,
		0,
		Lang.get(99446),
		37407,
		3,
		107,
		nil,
		1,
		3
	},
	[37407004] = {
		37407004,
		0,
		Lang.get(100340),
		37407,
		4,
		107,
		nil,
		1,
		3
	},
	[37408001] = {
		37408001,
		5,
		Lang.get(99447),
		37408,
		1,
		742,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		nil,
		nil,
		62,
		37408,
		[19] = 37408
	},
	[37408002] = {
		37408002,
		0,
		Lang.get(99448),
		37408,
		2,
		141,
		{
			RTResTalkAction[10]
		},
		1,
		1
	},
	[37408003] = {
		37408003,
		0,
		Lang.get(99449),
		37408,
		3,
		107,
		nil,
		1,
		3
	},
	[37408004] = {
		37408004,
		0,
		Lang.get(99450),
		37408,
		4,
		141,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[37408005] = {
		37408005,
		0,
		Lang.get(99451),
		37408,
		5,
		107,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[37408006] = {
		37408006,
		0,
		Lang.get(99452),
		37408,
		6,
		141,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[37409001] = {
		37409001,
		0,
		Lang.get(99453),
		37409,
		1,
		107,
		nil,
		1,
		3,
		nil,
		nil,
		62,
		37409,
		nil,
		nil,
		nil,
		nil,
		nil,
		37409
	},
	[37409002] = {
		37409002,
		0,
		Lang.get(99454),
		37409,
		2,
		1169,
		nil,
		1,
		0
	},
	[37409003] = {
		37409003,
		0,
		Lang.get(99455),
		37409,
		3,
		107,
		nil,
		1,
		2
	},
	[37409004] = {
		37409004,
		0,
		Lang.get(99456),
		37409,
		4,
		1169,
		{
			RTResTalkAction[13]
		}
	},
	[37409005] = {
		37409005,
		0,
		Lang.get(99457),
		37409,
		5,
		1169,
		{
			RTResTalkAction[13]
		}
	},
	[37409006] = {
		37409006,
		0,
		Lang.get(99458),
		37409,
		6,
		141,
		{
			RTResTalkAction[14],
			RTResTalkAction[15]
		}
	},
	[37409007] = {
		37409007,
		0,
		Lang.get(99459),
		37409,
		7,
		107,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[37409008] = {
		37409008,
		0,
		Lang.get(99460),
		37409,
		8,
		1169,
		{
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[37409009] = {
		37409009,
		0,
		Lang.get(99461),
		37409,
		9,
		1169,
		{
			RTResTalkAction[13]
		}
	},
	[37409010] = {
		37409010,
		0,
		Lang.get(99462),
		37409,
		10,
		1169,
		{
			RTResTalkAction[13]
		}
	},
	[37409011] = {
		37409011,
		0,
		Lang.get(99463),
		37409,
		11,
		742,
		{
			RTResTalkAction[15]
		},
		1,
		nil,
		nil,
		nil,
		63,
		37410,
		nil,
		nil,
		nil,
		nil,
		nil,
		37410
	},
	[37409012] = {
		37409012,
		0,
		Lang.get(99464),
		37409,
		12,
		152,
		nil,
		1
	},
	[37409013] = {
		37409013,
		0,
		Lang.get(99465),
		37409,
		13,
		152,
		{
			RTResTalkAction[20]
		}
	},
	[37410001] = {
		37410001,
		0,
		Lang.get(100341),
		37410,
		1,
		711,
		nil,
		1,
		0
	},
	[37410002] = {
		37410002,
		0,
		Lang.get(100342),
		37410,
		2,
		711,
		nil,
		1,
		0
	},
	[37411001] = {
		37411001,
		0,
		Lang.get(100343),
		37411,
		1,
		711,
		nil,
		1,
		0
	},
	[37412001] = {
		37412001,
		0,
		Lang.get(100344),
		37412,
		1,
		711,
		nil,
		1,
		0
	},
	[37413001] = {
		37413001,
		0,
		Lang.get(100345),
		37413,
		1,
		107,
		nil,
		1,
		0
	},
	[37414001] = {
		37414001,
		0,
		Lang.get(100346),
		37414,
		1,
		107,
		nil,
		1,
		3
	},
	[37415001] = {
		37415001,
		0,
		Lang.get(100347),
		37415,
		1,
		107,
		nil,
		1,
		3
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
