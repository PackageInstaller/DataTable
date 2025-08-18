-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\P3_simei\\ResTalkScenery.lua

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
	270,
	0
}
RT[2] = {
	10.58,
	0.680023,
	23.52999
}
RT[3] = {
	357,
	0,
	357
}
RT[4] = {
	248.7,
	179.39,
	-8.5
}
RT[5] = {
	0,
	0,
	0
}
RT[6] = {
	-64.66,
	284.99,
	139.6
}
RT[7] = {
	0,
	246,
	0
}

local Data = {
	[38801] = {
		[1] = 38801,
		[2] = {
			{
				scale = 1.5,
				action = "idle01",
				npc_id = 25084,
				show = 0,
				rotation = RT[1],
				pos = RT[2]
			}
		}
	},
	[38802] = {
		[1] = 38802,
		[2] = {
			{
				move_duration = 0,
				npc_id = 25083,
				action = "idle01",
				scale = 2.7,
				show = 0,
				rotation = RT[3],
				pos = RT[4]
			}
		}
	},
	[38803] = {
		[1] = 38803,
		[2] = {
			{
				move_duration = 0,
				npc_id = 25083,
				action = "idle01",
				scale = 2.7,
				show = 0,
				rotation = RT[5],
				pos = RT[6]
			}
		}
	},
	[38804] = {
		[1] = 38804,
		[2] = {
			{
				scale = 1.5,
				action = "idle01",
				npc_id = 25093,
				show = 0,
				rotation = RT[7],
				pos = RT[2]
			}
		}
	},
	[38805] = {
		[1] = 38805,
		[2] = {
			{
				scale = 1.5,
				action = "idle01",
				npc_id = 25093,
				show = 0,
				rotation = RT[7],
				pos = RT[2]
			}
		}
	},
	[38806] = {
		[1] = 38806,
		[2] = {
			{
				scale = 1.5,
				action = "idle01",
				npc_id = 25093,
				show = 0,
				rotation = RT[7],
				pos = RT[2]
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
