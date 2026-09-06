-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_water_dark_tower_special_prize.lua

module("logicconfig.config.t_water_dark_tower_special_prize", package.seeall)

local title = {
	tier = 3,
	towerType = 2,
	specialPrize = 4,
	maxGainNum = 5,
	planId = 1
}
local dataList = {
	{
		1,
		1,
		1,
		"4:90062:120",
		5000
	},
	{
		1,
		1,
		2,
		"4:31:10",
		3000
	},
	{
		1,
		1,
		3,
		"4:25:10",
		1000
	},
	{
		1,
		1,
		4,
		"15:4007:1",
		500
	},
	{
		1,
		1,
		5,
		"4:30003:10",
		100
	},
	{
		1,
		1,
		6,
		"4:503:10",
		50
	},
	{
		1,
		1,
		7,
		"4:7002:1",
		10
	},
	{
		1,
		2,
		1,
		"4:90062:120",
		5000
	},
	{
		1,
		2,
		2,
		"4:36:10",
		3000
	},
	{
		1,
		2,
		3,
		"4:25:10",
		1000
	},
	{
		1,
		2,
		4,
		"15:4008:1",
		500
	},
	{
		1,
		2,
		5,
		"4:30003:10",
		100
	},
	{
		1,
		2,
		6,
		"4:503:10",
		50
	},
	{
		1,
		2,
		7,
		"4:7005:1",
		10
	},
	{
		2,
		1,
		1,
		"8:1:500000",
		5000
	},
	{
		2,
		1,
		2,
		"4:111:3",
		3000
	},
	{
		2,
		1,
		3,
		"104:2:500",
		1000
	},
	{
		3,
		1,
		1,
		"8:1:1000000",
		100
	},
	{
		3,
		1,
		2,
		"8:1:1000000",
		100
	},
	{
		3,
		1,
		3,
		"8:1:1000000",
		100
	},
	{
		4,
		1,
		1,
		"8:1:1000000",
		10
	},
	{
		4,
		1,
		2,
		"8:1:1000000",
		10
	},
	{
		4,
		1,
		3,
		"8:1:1000000",
		10
	},
	{
		4,
		1,
		4,
		"8:1:1000000",
		10
	},
	{
		4,
		1,
		5,
		"8:1:1000000",
		10
	}
}
local t_water_dark_tower_special_prize = {
	{
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5],
			dataList[6],
			dataList[7]
		},
		{
			dataList[8],
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12],
			dataList[13],
			dataList[14]
		}
	},
	{
		{
			dataList[15],
			dataList[16],
			dataList[17]
		}
	},
	{
		{
			dataList[18],
			dataList[19],
			dataList[20]
		}
	},
	{
		{
			dataList[21],
			dataList[22],
			dataList[23],
			dataList[24],
			dataList[25]
		}
	}
}

t_water_dark_tower_special_prize.dataList = dataList

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

return t_water_dark_tower_special_prize
