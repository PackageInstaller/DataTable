-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\tu2ye_yure\\ResTalkScenery.lua

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
	216,
	0
}
RT[2] = {
	-177.2503,
	105.33,
	1576.032
}
RT[3] = {
	358,
	314,
	352
}
RT[4] = {
	-232.6185,
	141.7298,
	1527.355
}
RT[5] = {
	3,
	265,
	1
}
RT[6] = {
	-229.38,
	141.77,
	1527.44
}
RT[7] = {
	3,
	57,
	358
}
RT[8] = {
	-236.3273,
	141.6738,
	1527.571
}

local Data = {
	[35027] = {
		[1] = 35027,
		[2] = {
			{
				move_duration = 0,
				npc_id = 40005,
				scale = 1.8,
				show = 0,
				rotation = RT[1],
				pos = RT[2]
			}
		}
	},
	[35028] = {
		[1] = 35028,
		[2] = {
			{
				move_duration = 0,
				npc_id = 26531,
				action = "Idle",
				scale = 2,
				show = 0,
				rotation = RT[3],
				pos = RT[4]
			},
			{
				move_duration = 0,
				npc_id = 8021,
				action = "Idle",
				scale = 2,
				show = 0,
				rotation = RT[5],
				pos = RT[6]
			},
			{
				move_duration = 0,
				npc_id = 40505,
				scale = 1.9,
				show = 0,
				rotation = RT[7],
				pos = RT[8]
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
