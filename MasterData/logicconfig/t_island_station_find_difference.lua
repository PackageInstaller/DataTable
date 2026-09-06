-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_island_station_find_difference.lua

module("logicconfig.config.t_island_station_find_difference", package.seeall)

local title = {
	weight = 4,
	passNeedNum = 6,
	pictureId = 1,
	pictureIdNew = 3,
	gameTime = 5,
	difficulty = 2
}
local dataList = {
	{
		1,
		1,
		11,
		25,
		60,
		3
	},
	{
		2,
		1,
		12,
		25,
		60,
		3
	},
	{
		3,
		1,
		13,
		25,
		60,
		3
	},
	{
		4,
		1,
		14,
		25,
		60,
		3
	},
	{
		5,
		2,
		11,
		25,
		60,
		3
	},
	{
		6,
		2,
		12,
		25,
		60,
		3
	},
	{
		7,
		2,
		13,
		25,
		60,
		3
	},
	{
		8,
		2,
		14,
		25,
		60,
		3
	},
	{
		9,
		2,
		15,
		25,
		60,
		3
	},
	{
		10,
		3,
		11,
		25,
		60,
		4
	},
	{
		11,
		3,
		12,
		25,
		60,
		4
	},
	{
		12,
		3,
		13,
		25,
		60,
		4
	},
	{
		13,
		3,
		14,
		25,
		60,
		4
	},
	{
		14,
		3,
		15,
		25,
		60,
		4
	},
	{
		15,
		4,
		11,
		25,
		60,
		5
	},
	{
		16,
		4,
		12,
		25,
		60,
		5
	},
	{
		17,
		4,
		13,
		25,
		60,
		5
	},
	{
		18,
		4,
		14,
		25,
		60,
		5
	},
	{
		19,
		4,
		15,
		25,
		60,
		5
	}
}
local t_island_station_find_difference = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11],
	dataList[12],
	dataList[13],
	dataList[14],
	dataList[15],
	dataList[16],
	dataList[17],
	dataList[18],
	dataList[19]
}

t_island_station_find_difference.dataList = dataList

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

return t_island_station_find_difference
