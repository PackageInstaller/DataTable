-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_music_game_prize.lua

module("logicconfig.config.t_music_game_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		370001,
		1,
		50,
		"60:1:1000"
	},
	{
		370001,
		2,
		100,
		"8:1:1000000"
	},
	{
		370001,
		3,
		200,
		"60:1:2000"
	},
	{
		370001,
		4,
		300,
		"8:1:2000000"
	},
	{
		370001,
		5,
		500,
		"60:1:2000"
	},
	{
		370001,
		6,
		700,
		"8:1:2000000"
	},
	{
		370001,
		7,
		900,
		"4:400002:100"
	},
	{
		370002,
		1,
		80,
		"10:453001:1000"
	},
	{
		370002,
		2,
		150,
		"10:453001:1000"
	},
	{
		370002,
		3,
		250,
		"10:453001:1000"
	},
	{
		370002,
		4,
		400,
		"10:453001:1000"
	},
	{
		370002,
		5,
		550,
		"10:453001:1000"
	},
	{
		370002,
		6,
		700,
		"10:453001:1000"
	},
	{
		370002,
		7,
		800,
		"10:453001:1500"
	},
	{
		370003,
		1,
		50,
		"4:31:10"
	},
	{
		370003,
		2,
		100,
		"8:1:5000000"
	},
	{
		370003,
		3,
		150,
		"60:1:1000"
	},
	{
		370003,
		4,
		250,
		"8:1:5000000"
	},
	{
		370003,
		5,
		350,
		"60:1:2000"
	},
	{
		370003,
		6,
		450,
		"4:31:10"
	},
	{
		370003,
		7,
		550,
		"60:1:2000"
	},
	{
		370003,
		8,
		650,
		"4:400002:50"
	},
	{
		370003,
		9,
		750,
		"4:111:10"
	},
	{
		370003,
		10,
		900,
		"4:400002:50"
	}
}
local t_music_game_prize = {
	[370001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	},
	[370002] = {
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14]
	},
	[370003] = {
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

t_music_game_prize.dataList = dataList

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

return t_music_game_prize
