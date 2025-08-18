-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\CL_yure\\ResTalkScenery.lua

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
	69,
	0
}
RT[2] = {
	206.6,
	578.431,
	-46.71
}
RT[3] = {
	0,
	331,
	0
}
RT[4] = {
	209.74,
	578.431,
	-49.01
}
RT[5] = {
	0,
	242,
	0
}
RT[6] = {
	211.785,
	578.431,
	-42.688
}
RT[7] = {
	0,
	205,
	0
}
RT[8] = {
	210.418,
	578.431,
	-41.452
}
RT[9] = {
	0,
	282,
	0
}
RT[10] = {
	210.272,
	578.431,
	-44.584
}
RT[11] = {
	210.968,
	578.431,
	-44.519
}
RT[12] = {
	0,
	35,
	0
}
RT[13] = {
	210.07,
	578.431,
	-45.44
}
RT[14] = {
	209.197,
	578.431,
	-45.025
}

local Data = {
	[39300] = {
		[1] = 39300,
		[2] = {
			{
				move_duration = 0,
				npc_id = 40506,
				action = "rabbit",
				scale = 1,
				show = 0,
				rotation = RT[1],
				pos = RT[2]
			},
			{
				move_duration = 0,
				npc_id = 26538,
				action = "Idle",
				scale = 1,
				show = 0,
				rotation = RT[3],
				pos = RT[4]
			}
		}
	},
	[39301] = {
		[1] = 39301,
		[2] = {
			{
				move_duration = 0,
				npc_id = 40506,
				action = "rabbit",
				scale = 0.8,
				show = 0,
				rotation = RT[5],
				pos = RT[6]
			},
			{
				move_duration = 0,
				npc_id = 29088,
				scale = 1.1,
				show = 0,
				rotation = RT[7],
				pos = RT[8]
			},
			{
				move_duration = 0,
				npc_id = 26538,
				action = "Idle",
				scale = 1,
				show = 0,
				rotation = RT[9],
				pos = RT[10]
			}
		}
	},
	[39302] = {
		[1] = 39302,
		[2] = {
			{
				move_duration = 0,
				npc_id = 40506,
				action = "rabbit",
				scale = 0.8,
				show = 0,
				rotation = RT[5],
				pos = RT[6]
			},
			{
				move_duration = 0,
				npc_id = 29088,
				scale = 1.1,
				show = 0,
				rotation = RT[7],
				pos = RT[8]
			},
			{
				move_duration = 0,
				npc_id = 26538,
				action = "Idle",
				scale = 1,
				show = 0,
				rotation = RT[9],
				pos = RT[11]
			},
			{
				scale = 1,
				action = "Idle",
				npc_id = 24084,
				show = 0,
				rotation = RT[12],
				pos = RT[13]
			},
			{
				scale = 1,
				action = "Idle",
				npc_id = 24083,
				show = 0,
				rotation = RT[1],
				pos = RT[14]
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
