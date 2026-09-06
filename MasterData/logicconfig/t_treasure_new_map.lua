-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_treasure_new_map.lua

module("logicconfig.config.t_treasure_new_map", package.seeall)

local title = {
	name = 2,
	mapId = 1,
	directGainLevel = 4,
	materialId = 3
}
local dataList = {
	{
		1,
		"藏宝图",
		601,
		30
	},
	{
		2,
		"高级藏宝图",
		602,
		30
	},
	{
		3,
		"战场藏宝图",
		605,
		999
	}
}
local t_treasure_new_map = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_treasure_new_map.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_treasure_new_map
