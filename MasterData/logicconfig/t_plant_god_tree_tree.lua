-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_plant_god_tree_tree.lua

module("logicconfig.config.t_plant_god_tree_tree", package.seeall)

local title = {
	needSeedItemCount = 3,
	treeId = 2,
	activityId = 1
}
local dataList = {
	{
		556001,
		1,
		20
	},
	{
		556001,
		2,
		50
	},
	{
		556001,
		3,
		80
	},
	{
		556001,
		4,
		110
	},
	{
		556001,
		5,
		150
	}
}
local t_plant_god_tree_tree = {
	[556001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_plant_god_tree_tree.dataList = dataList

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

return t_plant_god_tree_tree
