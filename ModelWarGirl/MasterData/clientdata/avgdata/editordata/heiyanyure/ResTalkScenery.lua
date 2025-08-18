-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\heiyanyure\\ResTalkScenery.lua

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
	347,
	0
}
RT[2] = {
	249.58,
	179.3,
	-8.48
}
RT[3] = {
	0,
	325,
	0
}
RT[4] = {
	-65.01,
	285,
	139.94
}
RT[5] = {
	0,
	60,
	0
}
RT[6] = {
	-69.91,
	285,
	142.62
}
RT[7] = {
	0,
	285,
	0
}
RT[8] = {
	-60.38,
	284.9681,
	142.95
}
RT[9] = {
	0,
	0,
	0
}
RT[10] = {
	252.97,
	179.24,
	-9.71
}
RT[11] = {
	0,
	52,
	0
}
RT[12] = {
	250.21,
	179.27,
	-7.98
}

local Data = {
	[32000] = {
		[1] = 32000,
		[2] = {
			{
				move_duration = 0,
				npc_id = 20020,
				action = "Idle",
				scale = 2.7,
				show = 0,
				rotation = RT[1],
				pos = RT[2]
			}
		}
	},
	[32001] = {
		[1] = 32001,
		[2] = {
			{
				move_duration = 0,
				npc_id = 151,
				scale = 2.7,
				show = 0,
				rotation = RT[3],
				pos = RT[4]
			},
			{
				move_duration = 0,
				npc_id = 153,
				scale = 2.7,
				show = 0,
				rotation = RT[5],
				pos = RT[6]
			},
			{
				move_duration = 0,
				npc_id = 4001,
				scale = 2.7,
				show = 0,
				rotation = RT[7],
				pos = RT[8]
			}
		}
	},
	[32002] = {
		[1] = 32002,
		[2] = {
			{
				move_duration = 0,
				npc_id = 20020,
				action = "Idle",
				scale = 2.7,
				show = 0,
				rotation = RT[9],
				pos = RT[10]
			},
			{
				move_duration = 0,
				npc_id = 8053,
				action = "Idle",
				scale = 2.7,
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
