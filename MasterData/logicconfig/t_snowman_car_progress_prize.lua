-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_snowman_car_progress_prize.lua

module("logicconfig.config.t_snowman_car_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		432001,
		1,
		50,
		"4:36:10"
	},
	{
		432001,
		2,
		100,
		"4:11002:2500"
	},
	{
		432001,
		3,
		150,
		"4:12102:5"
	},
	{
		432001,
		4,
		200,
		"4:11002:2500"
	},
	{
		432001,
		5,
		250,
		"4:400002:15"
	},
	{
		432001,
		6,
		300,
		"4:11002:5000"
	},
	{
		432001,
		7,
		350,
		"4:400002:20"
	},
	{
		432001,
		8,
		400,
		"4:11002:5000"
	},
	{
		432001,
		9,
		450,
		"4:12102:5"
	},
	{
		432001,
		10,
		500,
		"4:11002:5000"
	},
	{
		432001,
		11,
		550,
		"4:400002:20"
	},
	{
		432001,
		12,
		600,
		"4:11002:5000"
	},
	{
		432001,
		13,
		700,
		"4:400002:20"
	},
	{
		432001,
		14,
		800,
		"4:11002:5000"
	},
	{
		432001,
		15,
		900,
		"4:400002:25"
	}
}
local t_snowman_car_progress_prize = {
	[432001] = {
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
		dataList[15]
	}
}

t_snowman_car_progress_prize.dataList = dataList

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

return t_snowman_car_progress_prize
