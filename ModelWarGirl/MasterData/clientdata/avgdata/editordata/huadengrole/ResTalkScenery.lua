-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\huadengrole\\ResTalkScenery.lua

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
	338,
	0
}
RT[2] = {
	51.386,
	9.01001,
	6.501
}
RT[3] = {
	0,
	0,
	0
}
RT[4] = {
	252.93,
	179.43,
	-10.92
}
RT[5] = {
	0,
	150,
	0
}
RT[6] = {
	7.432,
	9.714996,
	-43.734
}
RT[7] = {
	0,
	346,
	0
}
RT[8] = {
	30.07808,
	-6.001862,
	122.7489
}
RT[9] = {
	0,
	17,
	0
}
RT[10] = {
	14.47101,
	300.3927,
	13.41358
}
RT[11] = {
	0,
	356,
	0
}
RT[12] = {
	-62.76,
	-15.03186,
	140.67
}

local Data = {
	[25700] = {
		[1] = 25700,
		[2] = {
			{
				npc_id = 20020,
				action = "Special",
				show = 0,
				rotation = RT[1],
				pos = RT[2]
			}
		}
	},
	[25710] = {
		[1] = 25710,
		[2] = {
			{
				scale = 2.7,
				action = "Idle02",
				npc_id = 21040,
				show = 0,
				rotation = RT[3],
				pos = RT[4]
			}
		}
	},
	[25720] = {
		[1] = 25720,
		[2] = {
			{
				scale = 1,
				npc_id = 20030,
				show = 0,
				rotation = RT[5],
				pos = RT[6]
			}
		}
	},
	[25740] = {
		[1] = 25740,
		[2] = {
			{
				npc_id = 24063,
				show = 0,
				rotation = RT[7],
				pos = RT[8]
			}
		}
	},
	[25750] = {
		[1] = 25750,
		[2] = {
			{
				scale = 2.7,
				npc_id = 24066,
				show = 0,
				rotation = RT[9],
				pos = RT[10]
			}
		}
	},
	[25730] = {
		[1] = 25730,
		[2] = {
			{
				scale = 2.7,
				action = "Special",
				npc_id = 26070,
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
