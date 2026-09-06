-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_elizabeth_clg_prize.lua

module("logicconfig.config.t_elizabeth_clg_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	planId = 1,
	flowerNum = 3
}
local dataList = {
	{
		1,
		1,
		100,
		"4:10:120"
	},
	{
		1,
		2,
		200,
		"4:11:120"
	},
	{
		1,
		3,
		400,
		"4:30002:20"
	},
	{
		1,
		4,
		600,
		"4:36:5"
	},
	{
		1,
		5,
		800,
		"4:503:5"
	},
	{
		1,
		6,
		1000,
		"4:41004:1"
	},
	{
		1,
		7,
		1200,
		"4:602:2"
	},
	{
		1,
		8,
		1400,
		"100:10322:1:1#62:17:1"
	},
	{
		1,
		9,
		2000,
		"100:10322:1:1"
	},
	{
		2,
		1,
		100,
		"8:1:300000"
	},
	{
		2,
		2,
		200,
		"8:1:300000"
	},
	{
		2,
		3,
		300,
		"4:502:100"
	},
	{
		2,
		4,
		400,
		"8:1:300000"
	},
	{
		2,
		5,
		500,
		"8:1:300000"
	},
	{
		2,
		6,
		600,
		"4:502:100"
	},
	{
		2,
		7,
		700,
		"8:1:300000"
	},
	{
		2,
		8,
		800,
		"8:1:300000"
	},
	{
		2,
		9,
		1000,
		"4:502:100"
	}
}
local t_elizabeth_clg_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	},
	{
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18]
	}
}

t_elizabeth_clg_prize.dataList = dataList

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

return t_elizabeth_clg_prize
