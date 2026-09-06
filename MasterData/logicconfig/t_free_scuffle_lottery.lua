-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_free_scuffle_lottery.lua

module("logicconfig.config.t_free_scuffle_lottery", package.seeall)

local title = {
	prizeId = 2,
	lotteryPlanId = 1,
	wight = 3,
	increaseCoin = 4,
	prize = 5
}
local dataList = {
	{
		1,
		1,
		800,
		"8000",
		"10:489002:1"
	},
	{
		1,
		2,
		500,
		"40000",
		"10:489002:2"
	},
	{
		1,
		3,
		200,
		"64000",
		"10:489002:3"
	},
	{
		2,
		1,
		800,
		"96000",
		"10:489002:5"
	},
	{
		2,
		2,
		500,
		"128000",
		"10:489002:10"
	},
	{
		2,
		3,
		200,
		"160000",
		"10:489002:20"
	},
	{
		3,
		1,
		800,
		"240000",
		"10:489002:30"
	},
	{
		3,
		2,
		500,
		"400000",
		"10:489002:50"
	},
	{
		3,
		3,
		200,
		"800000",
		"10:489002:100"
	},
	{
		4,
		1,
		800,
		"8000",
		"10:489004:1"
	},
	{
		4,
		2,
		500,
		"40000",
		"10:489004:2"
	},
	{
		4,
		3,
		200,
		"64000",
		"10:489004:3"
	},
	{
		5,
		1,
		800,
		"96000",
		"10:489004:5"
	},
	{
		5,
		2,
		500,
		"128000",
		"10:489004:10"
	},
	{
		5,
		3,
		200,
		"160000",
		"10:489004:20"
	},
	{
		6,
		1,
		800,
		"240000",
		"10:489004:30"
	},
	{
		6,
		2,
		500,
		"400000",
		"10:489004:50"
	},
	{
		6,
		3,
		200,
		"800000",
		"10:489004:100"
	},
	{
		7,
		1,
		800,
		"8000",
		"10:489006:1"
	},
	{
		7,
		2,
		500,
		"40000",
		"10:489006:2"
	},
	{
		7,
		3,
		200,
		"64000",
		"10:489006:3"
	},
	{
		8,
		1,
		800,
		"96000",
		"10:489006:5"
	},
	{
		8,
		2,
		500,
		"128000",
		"10:489006:10"
	},
	{
		8,
		3,
		200,
		"160000",
		"10:489006:20"
	},
	{
		9,
		1,
		800,
		"240000",
		"10:489006:30"
	},
	{
		9,
		2,
		500,
		"400000",
		"10:489006:50"
	},
	{
		9,
		3,
		200,
		"800000",
		"10:489006:100"
	}
}
local t_free_scuffle_lottery = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9]
	},
	{
		dataList[10],
		dataList[11],
		dataList[12]
	},
	{
		dataList[13],
		dataList[14],
		dataList[15]
	},
	{
		dataList[16],
		dataList[17],
		dataList[18]
	},
	{
		dataList[19],
		dataList[20],
		dataList[21]
	},
	{
		dataList[22],
		dataList[23],
		dataList[24]
	},
	{
		dataList[25],
		dataList[26],
		dataList[27]
	}
}

t_free_scuffle_lottery.dataList = dataList

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

return t_free_scuffle_lottery
