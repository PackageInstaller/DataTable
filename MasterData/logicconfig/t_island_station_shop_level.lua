-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_island_station_shop_level.lua

module("logicconfig.config.t_island_station_shop_level", package.seeall)

local title = {
	level = 2,
	progress = 3,
	unlockPosCount = 4,
	shopLvPlanId = 1
}
local dataList = {
	{
		1,
		1,
		0,
		1
	},
	{
		1,
		2,
		5,
		1
	},
	{
		1,
		3,
		10,
		2
	},
	{
		1,
		4,
		100,
		2
	},
	{
		1,
		5,
		500,
		3
	},
	{
		1,
		6,
		1000,
		3
	},
	{
		1,
		7,
		3000,
		4
	},
	{
		1,
		8,
		5000,
		4
	},
	{
		1,
		9,
		10000,
		5
	},
	{
		1,
		10,
		15000,
		5
	},
	{
		2,
		1,
		0,
		1
	},
	{
		2,
		2,
		5,
		1
	},
	{
		2,
		3,
		10,
		2
	},
	{
		2,
		4,
		100,
		2
	},
	{
		2,
		5,
		500,
		3
	},
	{
		2,
		6,
		1000,
		3
	},
	{
		2,
		7,
		3000,
		4
	},
	{
		2,
		8,
		5000,
		4
	},
	{
		2,
		9,
		10000,
		5
	},
	{
		2,
		10,
		15000,
		5
	}
}
local t_island_station_shop_level = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	{
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20]
	}
}

t_island_station_shop_level.dataList = dataList

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

return t_island_station_shop_level
