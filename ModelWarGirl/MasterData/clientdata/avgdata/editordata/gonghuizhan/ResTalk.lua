-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\gonghuizhan\\ResTalk.lua

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
	[2] = 357
}
RTResTalkAction[2] = {
	[1] = 2,
	[2] = 357
}
RTResTalkAction[3] = {
	[1] = 3,
	[2] = 225
}
RTResTalkAction[4] = {
	[1] = 1,
	[2] = 225
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 357
}
RTResTalkAction[6] = {
	[1] = 2,
	[2] = 225
}
RTResTalkAction[7] = {
	[1] = 3,
	[2] = 119
}
RTResTalkAction[8] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[9] = {
	[1] = 0,
	[2] = 225
}
RTResTalkAction[10] = {
	[1] = 0,
	[2] = 119
}
RTResTalkAction[11] = {
	[1] = 1,
	[2] = 133
}
RTResTalkAction[12] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[13] = {
	[1] = 2,
	[2] = 133
}
RTResTalkAction[14] = {
	[1] = 1,
	[2] = 119
}
RTResTalkAction[15] = {
	[1] = 0,
	[2] = 133
}
RTResTalkAction[16] = {
	[1] = 2,
	[2] = 119
}
RTResTalkAction[17] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[18] = {
	[1] = 1,
	[2] = 358
}
RTResTalkAction[19] = {
	[1] = 0,
	[2] = 358
}

local Data = {
	[21300001] = {
		21300001,
		0,
		Lang.get(42521),
		21300,
		1,
		357,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		nil,
		nil,
		62,
		[19] = 150
	},
	[21300002] = {
		21300002,
		0,
		Lang.get(42522),
		21300,
		2,
		225,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[21300003] = {
		21300003,
		0,
		Lang.get(42523),
		21300,
		3,
		357,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[21300004] = {
		21300004,
		0,
		Lang.get(42524),
		21300,
		4,
		225,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[21300005] = {
		21300005,
		0,
		Lang.get(42525),
		21300,
		5,
		119,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[21300006] = {
		21300006,
		0,
		Lang.get(42526),
		21300,
		6,
		225,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[21300007] = {
		21300007,
		0,
		Lang.get(42527),
		21300,
		7,
		119,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[21300008] = {
		21300008,
		0,
		Lang.get(42528),
		21300,
		8,
		225,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[21300009] = {
		21300009,
		0,
		Lang.get(42529),
		21300,
		9,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[9],
			RTResTalkAction[10]
		}
	},
	[21300010] = {
		21300010,
		0,
		Lang.get(42530),
		21300,
		10,
		133,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[21300011] = {
		21300011,
		0,
		Lang.get(42531),
		21300,
		11,
		225,
		{
			RTResTalkAction[13],
			RTResTalkAction[3]
		}
	},
	[21300012] = {
		21300012,
		0,
		Lang.get(42532),
		21300,
		12,
		119,
		{
			RTResTalkAction[14],
			RTResTalkAction[15],
			RTResTalkAction[9]
		}
	},
	[21300013] = {
		21300013,
		0,
		Lang.get(42533),
		21300,
		13,
		225,
		{
			RTResTalkAction[16],
			RTResTalkAction[3]
		}
	},
	[21300014] = {
		21300014,
		0,
		Lang.get(42534),
		21300,
		14,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[10],
			RTResTalkAction[9]
		}
	},
	[21300015] = {
		21300015,
		0,
		Lang.get(42535),
		21300,
		15,
		119,
		{
			RTResTalkAction[17],
			RTResTalkAction[7]
		}
	},
	[21300016] = {
		21300016,
		0,
		Lang.get(42536),
		21300,
		16,
		358,
		{
			RTResTalkAction[18],
			RTResTalkAction[12],
			RTResTalkAction[10]
		}
	},
	[21300017] = {
		21300017,
		0,
		Lang.get(42537),
		21300,
		17,
		225,
		{
			RTResTalkAction[4],
			RTResTalkAction[19]
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
