-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_elizabeth_game_prize.lua

module("logicconfig.config.t_elizabeth_game_prize", package.seeall)

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
		"60:1:300"
	},
	{
		1,
		2,
		200,
		"8:1:750000"
	},
	{
		1,
		3,
		300,
		"4:31:2"
	},
	{
		1,
		4,
		400,
		"10:338002:25"
	},
	{
		1,
		5,
		500,
		"4:36:2"
	},
	{
		1,
		6,
		600,
		"60:1:300"
	},
	{
		1,
		7,
		700,
		"8:1:750000"
	},
	{
		1,
		8,
		800,
		"10:338002:25"
	},
	{
		1,
		9,
		900,
		"4:31:2"
	},
	{
		1,
		10,
		1000,
		"4:36:2"
	},
	{
		1,
		11,
		1100,
		"60:1:300"
	},
	{
		1,
		12,
		1200,
		"10:338002:25"
	},
	{
		1,
		13,
		1300,
		"4:31:3"
	},
	{
		1,
		14,
		1400,
		"8:1:750000"
	},
	{
		1,
		15,
		1500,
		"4:36:3"
	},
	{
		1,
		16,
		1600,
		"10:338002:25"
	},
	{
		1,
		17,
		1700,
		"8:1:750000"
	},
	{
		1,
		18,
		1800,
		"4:31:3"
	},
	{
		1,
		19,
		1900,
		"60:1:300"
	},
	{
		1,
		20,
		2000,
		"4:36:3"
	},
	{
		2,
		1,
		100,
		"10:416001:2"
	},
	{
		2,
		2,
		200,
		"10:416001:2"
	},
	{
		2,
		3,
		300,
		"10:416001:2"
	},
	{
		2,
		4,
		400,
		"10:416001:2"
	},
	{
		2,
		5,
		500,
		"10:416001:2"
	},
	{
		2,
		6,
		600,
		"10:416001:2"
	},
	{
		2,
		7,
		700,
		"10:416001:2"
	},
	{
		2,
		8,
		800,
		"10:416001:2"
	},
	{
		2,
		9,
		900,
		"10:416001:2"
	},
	{
		2,
		10,
		1000,
		"10:416001:2"
	}
}
local t_elizabeth_game_prize = {
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
		dataList[25],
		dataList[26],
		dataList[27],
		dataList[28],
		dataList[29],
		dataList[30]
	}
}

t_elizabeth_game_prize.dataList = dataList

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

return t_elizabeth_game_prize
