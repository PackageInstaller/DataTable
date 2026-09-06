-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xiao_xiao_le_game_prize.lua

module("logicconfig.config.t_xiao_xiao_le_game_prize", package.seeall)

local title = {
	prizeId = 2,
	score = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		454001,
		1,
		100,
		"4:36:2"
	},
	{
		454001,
		2,
		200,
		"8:1:5000000"
	},
	{
		454001,
		3,
		300,
		"4:510022:2"
	},
	{
		454001,
		4,
		400,
		"4:111:5"
	},
	{
		454001,
		5,
		500,
		"4:36:2"
	},
	{
		454001,
		6,
		600,
		"8:1:5000000"
	},
	{
		454001,
		7,
		700,
		"4:36:3"
	},
	{
		454001,
		8,
		800,
		"4:111:5"
	},
	{
		454001,
		9,
		900,
		"4:36:3"
	},
	{
		454001,
		10,
		1000,
		"4:510022:3"
	},
	{
		454002,
		1,
		100,
		"10:453003:200"
	},
	{
		454002,
		2,
		200,
		"10:453003:200"
	},
	{
		454002,
		3,
		300,
		"10:453003:400"
	},
	{
		454002,
		4,
		400,
		"10:453003:400"
	},
	{
		454002,
		5,
		500,
		"10:453003:400"
	},
	{
		454002,
		6,
		600,
		"10:453003:600"
	},
	{
		454002,
		7,
		700,
		"10:453003:600"
	},
	{
		454002,
		8,
		800,
		"10:453003:600"
	},
	{
		454002,
		9,
		900,
		"10:453003:800"
	},
	{
		454002,
		10,
		1000,
		"10:453003:800"
	}
}
local t_xiao_xiao_le_game_prize = {
	[454001] = {
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
	[454002] = {
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

t_xiao_xiao_le_game_prize.dataList = dataList

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

return t_xiao_xiao_le_game_prize
