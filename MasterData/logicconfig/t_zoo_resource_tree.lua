-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_zoo_resource_tree.lua

module("logicconfig.config.t_zoo_resource_tree", package.seeall)

local title = {
	intervalPerNum = 2,
	needMainBuildingLv = 4,
	maxNum = 3,
	upgradeCost = 5,
	level = 1
}
local dataList = {
	{
		1,
		55,
		55,
		0,
		""
	},
	{
		2,
		50,
		110,
		2,
		"8:1:55"
	},
	{
		3,
		45,
		165,
		3,
		"8:1:400"
	}
}
local t_zoo_resource_tree = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_zoo_resource_tree.dataList = dataList

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

return t_zoo_resource_tree
