-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\abjiban\\ResTalkScenery.lua

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
	3,
	0
}
RT[2] = {
	250.67,
	179.23,
	-2.96
}
RT[3] = {
	0,
	142,
	0
}
RT[4] = {
	-10048.78,
	-10021.6,
	-10064.08
}
RT[5] = {
	0,
	116,
	0
}
RT[6] = {
	48.41,
	609.06,
	7.01
}
RT[7] = {
	0,
	144,
	0
}
RT[8] = {
	22.21,
	-5.869995,
	124.65
}
RT[9] = {
	357,
	0,
	0
}
RT[10] = {
	-64.87,
	285,
	139.64
}
RT[11] = {
	0,
	219,
	0
}
RT[12] = {
	253.66,
	179.23,
	-8.4
}

local Data = {
	[37901] = {
		[1] = 37901
	},
	[37902] = {
		[1] = 37902,
		[2] = {
			{
				scale = 2.7,
				action = "idle01",
				npc_id = 23101,
				show = 0,
				rotation = RT[1],
				pos = RT[2]
			}
		}
	},
	[37903] = {
		[1] = 37903,
		[2] = {
			{
				move_duration = 0,
				npc_id = 23101,
				action = "idle01",
				scale = 4,
				show = 0,
				rotation = RT[3],
				pos = RT[4]
			}
		}
	},
	[37904] = {
		[1] = 37904,
		[2] = {
			{
				scale = 2.7,
				action = "idle01",
				npc_id = 23102,
				show = 0,
				rotation = RT[1],
				pos = RT[2]
			}
		}
	},
	[37905] = {
		[1] = 37905,
		[2] = {
			{
				move_duration = 0,
				npc_id = 23102,
				action = "idle01",
				scale = 1.5,
				show = 0,
				rotation = RT[5],
				pos = RT[6]
			}
		}
	},
	[37906] = {
		[1] = 37906,
		[2] = {
			{
				move_duration = 0,
				npc_id = 23102,
				action = "idle01",
				scale = 1,
				show = 0,
				rotation = RT[7],
				pos = RT[8]
			}
		}
	},
	[37907] = {
		[1] = 37907,
		[2] = {
			{
				move_duration = 0,
				npc_id = 23102,
				action = "idle01",
				scale = 2.7,
				show = 0,
				rotation = RT[9],
				pos = RT[10]
			}
		}
	},
	[37908] = {
		[1] = 37908
	},
	[37911] = {
		[1] = 37911,
		[2] = {
			{
				scale = 2.7,
				action = "idle01",
				npc_id = 23102,
				show = 0,
				rotation = RT[11],
				pos = RT[12]
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
