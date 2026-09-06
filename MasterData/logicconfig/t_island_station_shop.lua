-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_island_station_shop.lua

module("logicconfig.config.t_island_station_shop", package.seeall)

local title = {
	shopLvPlanId = 5,
	maxProfit = 9,
	shopName = 3,
	shelfPosMaxFoodCount = 7,
	shopId = 2,
	sellPeriod = 8,
	shelfPosCount = 6,
	activityId = 1,
	startTime = 4
}
local dataList = {
	{
		487001,
		1,
		"饮品店",
		"2025-06-27T05:00:00",
		1,
		5,
		100,
		1,
		999999999
	},
	{
		487001,
		2,
		"小吃店",
		"2025-07-25T05:00:00",
		2,
		5,
		100,
		1,
		999999999
	}
}
local t_island_station_shop = {
	[487001] = {
		dataList[1],
		dataList[2]
	}
}

t_island_station_shop.dataList = dataList

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

return t_island_station_shop
