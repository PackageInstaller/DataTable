-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\Party\\ResTalkScenery.lua

local indexMap = {
	id = 1,
	model_stage_pos = 3,
	action = 2
}
local RT = {}

RT[1] = {
	359,
	324,
	359
}
RT[2] = {
	-74.35,
	-15.89999,
	124.82
}
RT[3] = {
	359,
	46,
	359
}
RT[4] = {
	-75.63556,
	-15.89999,
	125.311
}

local Data = {
	[192] = {
		[1] = 192,
		[2] = {
			{
				npc_id = 20020,
				show = 0,
				rotation = RT[1],
				pos = RT[2]
			},
			{
				scale = 1.4,
				npc_id = 20030,
				show = 0,
				rotation = RT[3],
				pos = RT[4]
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
