-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\sweethome_yure\\ResTalkScenery.lua

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
	0,
	0
}
RT[2] = {
	254.76,
	179.43,
	-4.6
}
RT[3] = {
	249.34,
	179.55,
	-6.2
}
RT[4] = {
	243.59,
	179.49,
	-6.4
}
RT[5] = {
	0,
	113,
	0
}
RT[6] = {
	2.72,
	0.42099,
	73.37
}
RT[7] = {
	2.179,
	0.42099,
	70.61
}

local Data = {
	[31501] = {
		[1] = 31501,
		[2] = {
			{
				move_duration = 0,
				npc_id = 20020,
				action = "Idle",
				scale = 2.7,
				show = 0,
				rotation = RT[1],
				pos = RT[2]
			},
			{
				move_duration = 0,
				npc_id = 20030,
				action = "Idle",
				scale = 2.7,
				show = 0,
				rotation = RT[1],
				pos = RT[3]
			},
			{
				move_duration = 0,
				npc_id = 22010,
				scale = 2.7,
				show = 0,
				rotation = RT[1],
				pos = RT[4]
			}
		}
	},
	[31502] = {
		[1] = 31502,
		[2] = {
			{
				move_duration = 0,
				npc_id = 20020,
				action = "Idle",
				scale = 2.7,
				show = 0,
				rotation = RT[1],
				pos = RT[2]
			},
			{
				move_duration = 0,
				npc_id = 20030,
				action = "Idle",
				scale = 2.7,
				show = 0,
				rotation = RT[1],
				pos = RT[3]
			},
			{
				move_duration = 0,
				npc_id = 22010,
				scale = 2.7,
				show = 0,
				rotation = RT[1],
				pos = RT[4]
			}
		}
	},
	[31503] = {
		[1] = 31503,
		[2] = {
			{
				npc_id = 20000,
				move_duration = 0,
				action = "Idle",
				show = 0,
				rotation = RT[5],
				pos = RT[6]
			},
			{
				npc_id = 22035,
				move_duration = 0,
				action = "Idle",
				show = 0,
				rotation = RT[5],
				pos = RT[7]
			}
		}
	},
	[31504] = {
		[1] = 31504,
		[2] = {
			{
				npc_id = 20000,
				move_duration = 0,
				action = "Idle",
				show = 0,
				rotation = RT[5],
				pos = RT[6]
			},
			{
				npc_id = 22035,
				move_duration = 0,
				action = "Idle",
				show = 0,
				rotation = RT[5],
				pos = RT[7]
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
