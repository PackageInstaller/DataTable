-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_treasure_basin_consume.lua

module("logicconfig.config.t_treasure_basin_consume", package.seeall)

local title = {
	itemConsume = 4,
	consumeId = 1,
	lotteryTimes = 2,
	diamondConsume = 3
}
local dataList = {
	{
		1,
		1,
		"",
		"10:73001:3"
	},
	{
		1,
		2,
		"",
		"10:73001:3"
	},
	{
		1,
		3,
		"",
		"10:73001:3"
	},
	{
		1,
		4,
		"",
		"10:73001:3"
	},
	{
		1,
		5,
		"",
		"10:73001:4"
	},
	{
		1,
		6,
		"",
		"10:73001:4"
	},
	{
		1,
		7,
		"",
		"10:73001:4"
	},
	{
		1,
		8,
		"",
		"10:73001:4"
	},
	{
		1,
		9,
		"",
		"10:73001:4"
	},
	{
		1,
		10,
		"",
		"10:73001:5"
	},
	{
		1,
		11,
		"",
		"10:73001:5"
	},
	{
		1,
		12,
		"",
		"10:73001:5"
	},
	{
		1,
		13,
		"",
		"10:73001:6"
	},
	{
		1,
		14,
		"",
		"10:73001:6"
	},
	{
		1,
		15,
		"",
		"10:73001:6"
	},
	{
		1,
		16,
		"",
		"10:73001:7"
	},
	{
		1,
		17,
		"",
		"10:73001:7"
	},
	{
		1,
		18,
		"",
		"10:73001:7"
	},
	{
		1,
		19,
		"",
		"10:73001:8"
	},
	{
		1,
		20,
		"",
		"10:73001:8"
	},
	{
		1,
		21,
		"",
		"10:73001:9"
	},
	{
		1,
		22,
		"",
		"10:73001:9"
	},
	{
		1,
		23,
		"",
		"10:73001:10"
	},
	{
		1,
		24,
		"",
		"10:73001:10"
	}
}
local t_treasure_basin_consume = {
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
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24]
	}
}

t_treasure_basin_consume.dataList = dataList

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

return t_treasure_basin_consume
