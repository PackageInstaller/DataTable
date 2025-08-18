-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\wuhuang\\ResTalkScenery.lua

local indexMap = {
	timeline_clear = 8,
	model_stage_pos = 3,
	clear_all_npc = 4,
	timeline_path = 5,
	id = 1,
	timeline_config = 7,
	timeline_config_str = 6,
	action = 2
}
local RT = {}

RT[1] = {
	0,
	242,
	0
}
RT[2] = {
	211.46,
	578.48,
	-42.82
}
RT[3] = {
	0,
	205,
	0
}
RT[4] = {
	210.12,
	578.442,
	-41.64
}
RT[5] = {
	208.16,
	578.431,
	-51.12
}
RT[6] = {
	0,
	221,
	0
}
RT[7] = {
	212.19,
	578.431,
	-46.48
}
RT[8] = {
	210.3794,
	578.442,
	-45.51672
}
RT[9] = {
	0,
	7,
	0
}
RT[10] = {
	208.55,
	578.431,
	-50.73
}
RT[11] = {
	212.26,
	578.431,
	-46.251
}
RT[12] = {
	0,
	207,
	0
}
RT[13] = {
	210.512,
	578.442,
	-45.365
}
RT[14] = {
	0,
	357,
	0
}
RT[15] = {
	208.3994,
	578.431,
	-50.7751
}
RT[16] = {
	0,
	198,
	0
}
RT[17] = {
	211.984,
	578.431,
	-44.7
}
RT[18] = {
	0,
	167,
	0
}
RT[19] = {
	211.9876,
	578.431,
	-44.70113
}
RT[20] = {
	0,
	177,
	0
}
RT[21] = {
	210.37,
	578.442,
	-44.82
}
RT[22] = {
	0,
	319,
	0
}
RT[23] = {
	213.89,
	578.431,
	-50.1
}
RT[24] = {
	359,
	73,
	0
}
RT[25] = {
	210.63,
	578.41,
	-46.25
}
RT[26] = {
	210.68,
	578.431,
	-49.93
}
RT[27] = {
	0,
	341,
	0
}
RT[28] = {
	213.9295,
	578.431,
	-50.11332
}
RT[29] = {
	0,
	212,
	0
}
RT[30] = {
	214.69,
	578.431,
	-49.33
}
RT[31] = {
	358,
	179,
	359
}
RT[32] = {
	212.66,
	578.5289,
	-47.95
}
RT[33] = {
	0,
	152,
	0
}
RT[34] = {
	211.79,
	579.09,
	-51.07
}
RT[35] = {
	0,
	216,
	0
}
RT[36] = {
	213.31,
	578.431,
	-52.65
}

local Data = {
	[32301] = {
		[1] = 32301,
		[2] = {
			{
				move_duration = 0,
				npc_id = 40500,
				action = "cat",
				scale = 1.5,
				show = 0,
				rotation = RT[1],
				pos = RT[2]
			},
			{
				move_duration = 0,
				npc_id = 40501,
				action = "dog",
				scale = 1.5,
				show = 0,
				rotation = RT[3],
				pos = RT[4]
			},
			{
				npc_id = 26076,
				action = "sleep",
				show = 0,
				rotation = RT[3],
				pos = RT[5]
			}
		}
	},
	[32302] = {
		[1] = 32302,
		[2] = {
			{
				move_duration = 0,
				npc_id = 40500,
				action = "cat",
				scale = 1.5,
				show = 0,
				rotation = RT[6],
				pos = RT[7]
			},
			{
				move_duration = 0,
				npc_id = 40501,
				action = "dog",
				scale = 1.5,
				show = 0,
				rotation = RT[3],
				pos = RT[8]
			},
			{
				npc_id = 26076,
				action = "sleep",
				show = 0,
				rotation = RT[9],
				pos = RT[10]
			}
		}
	},
	[32303] = {
		[1] = 32303,
		[2] = {
			{
				move_duration = 0,
				npc_id = 40500,
				action = "cat",
				scale = 1.5,
				show = 0,
				rotation = RT[6],
				pos = RT[11]
			},
			{
				move_duration = 0,
				npc_id = 40501,
				action = "dog",
				scale = 1.5,
				show = 0,
				rotation = RT[12],
				pos = RT[13]
			},
			{
				npc_id = 26076,
				action = "sleep",
				show = 0,
				rotation = RT[14],
				pos = RT[15]
			}
		}
	},
	[32304] = {
		[1] = 32304,
		[2] = {
			{
				move_duration = 0,
				npc_id = 40500,
				action = "cat",
				scale = 1.5,
				show = 0,
				rotation = RT[6],
				pos = RT[11]
			},
			{
				move_duration = 0,
				npc_id = 40501,
				action = "dog",
				scale = 1.5,
				show = 0,
				rotation = RT[12],
				pos = RT[13]
			},
			{
				npc_id = 26076,
				action = "sleep->idle",
				show = 0,
				rotation = RT[14],
				pos = RT[15]
			}
		}
	},
	[32305] = {
		[1] = 32305,
		[2] = {
			{
				move_duration = 0,
				npc_id = 40500,
				action = "cat",
				scale = 1.5,
				show = 0,
				rotation = RT[16],
				pos = RT[17]
			},
			{
				move_duration = 0,
				npc_id = 40501,
				action = "dog",
				scale = 1.5,
				show = 0,
				rotation = RT[12],
				pos = RT[13]
			},
			{
				npc_id = 26076,
				action = "Idle",
				show = 0,
				rotation = RT[14],
				pos = RT[15]
			}
		}
	},
	[32306] = {
		[1] = 32306,
		[2] = {
			{
				move_duration = 0,
				npc_id = 40500,
				action = "cat",
				scale = 1.5,
				show = 0,
				rotation = RT[18],
				pos = RT[19]
			},
			{
				move_duration = 0,
				npc_id = 40501,
				action = "dog",
				scale = 1.5,
				show = 0,
				rotation = RT[20],
				pos = RT[21]
			},
			{
				npc_id = 26076,
				action = "Idle",
				show = 0,
				rotation = RT[14],
				pos = RT[15]
			},
			{
				npc_id = 20020,
				action = "Idle",
				show = 0,
				rotation = RT[22],
				pos = RT[23]
			}
		}
	},
	[32307] = {
		[1] = 32307,
		[2] = {
			{
				move_duration = 0,
				npc_id = 40500,
				action = "cat",
				scale = 1.5,
				show = 0,
				rotation = RT[18],
				pos = RT[19]
			},
			{
				move_duration = 0,
				npc_id = 40501,
				action = "dog",
				scale = 1.5,
				show = 0,
				rotation = RT[24],
				pos = RT[25]
			},
			{
				npc_id = 26076,
				action = "Idle",
				show = 0,
				rotation = RT[14],
				pos = RT[26]
			},
			{
				npc_id = 20020,
				action = "Idle",
				show = 0,
				rotation = RT[27],
				pos = RT[28]
			}
		}
	},
	[32308] = {
		[1] = 32308,
		[2] = {
			{
				move_duration = 0,
				npc_id = 40500,
				action = "cat",
				scale = 1.5,
				show = 0,
				rotation = RT[29],
				pos = RT[30]
			},
			{
				move_duration = 0,
				npc_id = 40501,
				action = "dog",
				scale = 1.5,
				show = 0,
				rotation = RT[31],
				pos = RT[32]
			},
			{
				npc_id = 26076,
				action = "Idle",
				show = 0,
				rotation = RT[33],
				pos = RT[34]
			},
			{
				npc_id = 20020,
				action = "Idle",
				show = 0,
				rotation = RT[35],
				pos = RT[36]
			}
		}
	}
}
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
