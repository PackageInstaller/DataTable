-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_water_dark_tower_cut_down.lua

module("logicconfig.config.t_water_dark_tower_cut_down", package.seeall)

local title = {
	personNum = 3,
	cutDownTime = 4,
	planId = 1,
	stall = 2
}
local dataList = {
	{
		1,
		1,
		10,
		7
	},
	{
		1,
		2,
		50,
		8
	},
	{
		1,
		3,
		150,
		10
	},
	{
		1,
		4,
		500,
		12
	},
	{
		2,
		1,
		100,
		7
	},
	{
		2,
		2,
		200,
		8
	},
	{
		2,
		3,
		500,
		10
	},
	{
		2,
		4,
		1000,
		12
	},
	{
		3,
		1,
		50,
		4
	},
	{
		3,
		2,
		150,
		5
	},
	{
		3,
		3,
		1000,
		6
	},
	{
		3,
		4,
		1500,
		7
	},
	{
		4,
		1,
		50,
		10
	},
	{
		4,
		2,
		150,
		15
	},
	{
		4,
		3,
		1000,
		20
	},
	{
		4,
		4,
		1500,
		25
	},
	{
		5,
		1,
		50,
		4
	},
	{
		5,
		2,
		150,
		5
	},
	{
		5,
		3,
		1000,
		6
	},
	{
		5,
		4,
		1500,
		7
	}
}
local t_water_dark_tower_cut_down = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	{
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	},
	{
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	},
	{
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20]
	}
}

t_water_dark_tower_cut_down.dataList = dataList

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

return t_water_dark_tower_cut_down
