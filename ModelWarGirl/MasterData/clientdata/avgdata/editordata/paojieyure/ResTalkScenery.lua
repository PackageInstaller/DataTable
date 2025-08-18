-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\paojieyure\\ResTalkScenery.lua

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
	2,
	281,
	0
}
RT[2] = {
	366.87,
	4219.432,
	119.97
}
RT[3] = {
	0,
	320,
	0
}
RT[4] = {
	366.1,
	4219.432,
	117.16
}
RT[5] = {
	2,
	233,
	0
}
RT[6] = {
	366.87,
	4219.4,
	119.97
}
RT[7] = {
	0,
	3,
	0
}
RT[8] = {
	365.7,
	4219.4,
	117.16
}
RT[9] = {
	5,
	353,
	3
}
RT[10] = {
	366.4,
	4219.4,
	117.4
}
RT[11] = {
	2,
	286,
	0
}
RT[12] = {
	362.69,
	4219.4,
	117.16
}
RT[13] = {
	362.2,
	4219.4,
	117.4
}
RT[14] = {
	0,
	319,
	0
}
RT[15] = {
	364.4,
	4219.4,
	118.5
}

local Data = {
	[29101] = {
		[1] = 29101,
		[2] = {
			{
				npc_id = 20020,
				move_duration = 0,
				action = "Idle",
				show = 0,
				rotation = RT[1],
				pos = RT[2]
			},
			{
				npc_id = 23056,
				show = 0,
				rotation = RT[3],
				pos = RT[4]
			}
		}
	},
	[29104] = {
		[1] = 29104,
		[2] = {
			{
				npc_id = 20020,
				move_duration = 0,
				action = "Idle",
				show = 0,
				rotation = RT[5],
				pos = RT[6]
			},
			{
				npc_id = 23056,
				show = 0,
				rotation = RT[7],
				pos = RT[8]
			},
			{
				npc_id = 23058,
				show = 0,
				rotation = RT[9],
				pos = RT[10]
			}
		}
	},
	[29102] = {
		[1] = 29102,
		[2] = {
			{
				npc_id = 20020,
				move_duration = 0,
				action = "Idle",
				show = 0,
				rotation = RT[5],
				pos = RT[6]
			},
			{
				npc_id = 23056,
				show = 0,
				rotation = RT[7],
				pos = RT[8]
			},
			{
				npc_id = 23058,
				show = 0,
				rotation = RT[9],
				pos = RT[10]
			}
		}
	},
	[29105] = {
		[1] = 29105,
		[2] = {
			{
				npc_id = 20020,
				move_duration = 0,
				action = "Idle",
				show = 0,
				rotation = RT[11],
				pos = RT[6]
			},
			{
				npc_id = 23056,
				show = 0,
				rotation = RT[7],
				pos = RT[12]
			},
			{
				npc_id = 23058,
				show = 0,
				rotation = RT[9],
				pos = RT[13]
			}
		}
	},
	[29103] = {
		[1] = 29103,
		[2] = {
			{
				npc_id = 20020,
				move_duration = 0,
				action = "Idle",
				show = 0,
				rotation = RT[5],
				pos = RT[6]
			},
			{
				npc_id = 23056,
				show = 0,
				rotation = RT[7],
				pos = RT[8]
			},
			{
				npc_id = 23058,
				show = 0,
				rotation = RT[9],
				pos = RT[10]
			}
		}
	},
	[29106] = {
		[1] = 29106,
		[2] = {
			{
				npc_id = 20020,
				move_duration = 0,
				action = "Idle",
				show = 0,
				rotation = RT[5],
				pos = RT[6]
			},
			{
				npc_id = 23056,
				show = 0,
				rotation = RT[14],
				pos = RT[15]
			},
			{
				npc_id = 23058,
				show = 0,
				rotation = RT[9],
				pos = RT[10]
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
