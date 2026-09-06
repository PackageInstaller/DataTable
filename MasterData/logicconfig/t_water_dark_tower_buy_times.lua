-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_water_dark_tower_buy_times.lua

module("logicconfig.config.t_water_dark_tower_buy_times", package.seeall)

local title = {
	cost = 3,
	planId = 1,
	times = 2
}
local dataList = {
	{
		1,
		1,
		"105:180:20"
	},
	{
		1,
		2,
		"105:180:20"
	},
	{
		1,
		3,
		"105:180:20"
	},
	{
		1,
		4,
		"105:180:20"
	},
	{
		1,
		5,
		"105:180:20"
	},
	{
		1,
		6,
		"105:180:20"
	},
	{
		1,
		7,
		"105:180:20"
	},
	{
		1,
		8,
		"105:180:20"
	},
	{
		1,
		9,
		"105:180:20"
	},
	{
		1,
		10,
		"105:180:20"
	},
	{
		1,
		11,
		"105:180:20"
	},
	{
		1,
		12,
		"105:180:20"
	},
	{
		1,
		13,
		"105:180:20"
	},
	{
		1,
		14,
		"105:180:20"
	},
	{
		1,
		15,
		"105:180:20"
	},
	{
		1,
		16,
		"105:180:20"
	},
	{
		1,
		17,
		"105:180:20"
	},
	{
		1,
		18,
		"105:180:20"
	},
	{
		1,
		19,
		"105:180:20"
	},
	{
		1,
		20,
		"105:180:20"
	},
	{
		2,
		1,
		"105:180:20"
	},
	{
		2,
		2,
		"105:180:20"
	},
	{
		2,
		3,
		"105:180:20"
	},
	{
		2,
		4,
		"105:180:20"
	},
	{
		2,
		5,
		"105:180:20"
	},
	{
		3,
		1,
		"105:180:100"
	},
	{
		3,
		2,
		"105:180:100"
	},
	{
		3,
		3,
		"105:180:100"
	},
	{
		3,
		4,
		"105:180:100"
	},
	{
		3,
		5,
		"105:180:100"
	},
	{
		3,
		6,
		"105:180:100"
	},
	{
		3,
		7,
		"105:180:100"
	},
	{
		3,
		8,
		"105:180:100"
	},
	{
		3,
		9,
		"105:180:100"
	},
	{
		3,
		10,
		"105:180:100"
	}
}
local t_water_dark_tower_buy_times = {
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
		dataList[10],
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
	},
	{
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25]
	},
	{
		dataList[26],
		dataList[27],
		dataList[28],
		dataList[29],
		dataList[30],
		dataList[31],
		dataList[32],
		dataList[33],
		dataList[34],
		dataList[35]
	}
}

t_water_dark_tower_buy_times.dataList = dataList

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

return t_water_dark_tower_buy_times
