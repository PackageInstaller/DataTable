-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\URplot\\ResTalkScenery.lua

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
	348,
	0
}
RT[2] = {
	-164.5,
	45.51999,
	120.7
}

local Data = {
	[43400] = {
		[1] = 43400
	},
	[43401] = {
		[1] = 43401
	},
	[43402] = {
		[1] = 43402
	},
	[43403] = {
		[1] = 43403
	},
	[43405] = {
		[1] = 43405
	},
	[43406] = {
		[1] = 43406,
		[2] = {
			{
				npc_id = 4177,
				move_duration = 0,
				show = 0,
				rotation = RT[1],
				pos = RT[2]
			}
		}
	},
	[43407] = {
		[1] = 43407
	},
	[43404] = {
		[1] = 43404
	},
	[43408] = {
		[1] = 43408
	},
	[43409] = {
		[1] = 43409
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
