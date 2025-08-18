-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResBusinessRandControl.lua

local RT = {}

RT[1] = {
	1
}
RT[2] = {
	1,
	2
}
RT[3] = {
	482,
	518
}

local Data = {
	{
		id = 1,
		material_quality = RT[1],
		material_weight = RT[1]
	},
	[10] = {
		window_get_size = 10,
		max_round_count = 5,
		id = 10,
		max_window_get_count = 2,
		material_quality = RT[2],
		material_weight = {
			99,
			1
		}
	},
	[11] = {
		window_get_size = 10,
		max_round_count = 5,
		id = 11,
		max_window_get_count = 4,
		material_quality = RT[2],
		material_weight = RT[3]
	},
	[12] = {
		id = 12,
		material_quality = {
			2
		},
		material_weight = RT[1]
	},
	[13] = {
		window_get_size = 20,
		max_round_count = 5,
		id = 13,
		max_window_get_count = 6,
		material_quality = {
			2,
			3
		},
		material_weight = RT[3]
	}
}

return Data
