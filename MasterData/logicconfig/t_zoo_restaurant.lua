-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_zoo_restaurant.lua

module("logicconfig.config.t_zoo_restaurant", package.seeall)

local title = {
	needMainBuildingLv = 5,
	workerNum = 2,
	upgradeCost = 6,
	rateFactor = 3,
	maxScore = 4,
	level = 1
}
local dataList = {
	{
		1,
		2,
		30000,
		100,
		0,
		""
	},
	{
		2,
		3,
		50000,
		300,
		2,
		"8:1:1"
	},
	{
		3,
		5,
		70000,
		500,
		3,
		"8:1:2"
	}
}
local t_zoo_restaurant = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_zoo_restaurant.dataList = dataList

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

return t_zoo_restaurant
