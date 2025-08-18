-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\100days_J\\ResTalkScenery.lua

local indexMap = {
	id = 1,
	model_stage_pos = 3,
	action = 2
}
local RT = {}

RT[1] = {
	359,
	222,
	0
}
RT[2] = {
	257.73,
	179.5212,
	-5.4
}
RT[3] = {
	0,
	11,
	0
}
RT[4] = {
	253.6337,
	179.5212,
	0.491491
}
RT[5] = {
	0,
	351,
	0
}
RT[6] = {
	250.3448,
	179.5212,
	1.070796
}
RT[7] = {
	0,
	224,
	0
}
RT[8] = {
	181.9156,
	161.103,
	13.28845
}
RT[9] = {
	0,
	270,
	0
}
RT[10] = {
	1697,
	14,
	228
}
RT[11] = {
	0,
	245,
	0
}
RT[12] = {
	182.5974,
	161.103,
	11.69528
}
RT[13] = {
	0,
	256,
	0
}
RT[14] = {
	2.726809,
	0.42099,
	73.85074
}
RT[15] = {
	0,
	113,
	0
}
RT[16] = {
	2.179,
	0.42099,
	70.61
}
RT[17] = {
	0,
	18,
	0
}
RT[18] = {
	1030.924,
	1003.64,
	1032.695
}
RT[19] = {
	0,
	51,
	0
}
RT[20] = {
	1029.763,
	1003.65,
	1033.367
}
RT[21] = {
	0,
	23,
	0
}
RT[22] = {
	1030.106,
	1003.64,
	1035.334
}
RT[23] = {
	0,
	249,
	0
}
RT[24] = {
	4.29165,
	0.42099,
	75.52142
}
RT[25] = {
	0,
	287,
	0
}
RT[26] = {
	2.522994,
	0.42099,
	74.72839
}

local Data = {
	[22501] = {
		[1] = 22501,
		[2] = {
			{
				scale = 2.7,
				action = "Idle",
				npc_id = 20020,
				show = 0,
				rotation = RT[1],
				pos = RT[2]
			},
			{
				scale = 2.7,
				action = "Idle",
				npc_id = 20025,
				show = 0,
				rotation = RT[3],
				pos = RT[4]
			},
			{
				scale = 2.7,
				action = "Idle",
				npc_id = 20030,
				show = 0,
				rotation = RT[5],
				pos = RT[6]
			}
		}
	},
	[22502] = {
		[1] = 22502,
		[2] = {
			{
				scale = 1,
				action = "Special",
				npc_id = 4161,
				show = 0,
				rotation = RT[7],
				pos = RT[8]
			},
			{
				scale = 1,
				npc_id = 8072,
				show = 0,
				rotation = RT[9],
				pos = RT[10]
			},
			{
				scale = 1,
				action = "Show",
				npc_id = 4160,
				show = 0,
				rotation = RT[11],
				pos = RT[12]
			}
		}
	},
	[22503] = {
		[1] = 22503,
		[2] = {
			{
				scale = 1,
				npc_id = 68,
				show = 0,
				rotation = RT[13],
				pos = RT[14]
			},
			{
				scale = 3,
				npc_id = 28,
				show = 0,
				rotation = RT[15],
				pos = RT[16]
			}
		}
	},
	[22505] = {
		[1] = 22505,
		[2] = {
			{
				scale = 1.2,
				action = "Idle",
				npc_id = 20020,
				show = 0,
				rotation = RT[17],
				pos = RT[18]
			},
			{
				scale = 1.2,
				action = "Idle",
				npc_id = 20025,
				show = 0,
				rotation = RT[19],
				pos = RT[20]
			},
			{
				scale = 1.2,
				npc_id = 22040,
				show = 0,
				rotation = RT[21],
				pos = RT[22]
			}
		}
	},
	[22504] = {
		[1] = 22504,
		[2] = {
			{
				scale = 1,
				npc_id = 68,
				show = 0,
				rotation = RT[23],
				pos = RT[24]
			},
			{
				scale = 3,
				npc_id = 28,
				show = 0,
				rotation = RT[15],
				pos = RT[16]
			},
			{
				npc_id = 29083,
				action = "Idle",
				show = 0,
				rotation = RT[25],
				pos = RT[26]
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
