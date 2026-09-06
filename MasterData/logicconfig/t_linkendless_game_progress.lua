-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_linkendless_game_progress.lua

module("logicconfig.config.t_linkendless_game_progress", package.seeall)

local title = {
	prizeId = 2,
	score = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		394001,
		1,
		50,
		"8:1:1000"
	},
	{
		394001,
		2,
		100,
		"8:1:1001"
	},
	{
		394001,
		3,
		150,
		"8:1:1002"
	},
	{
		394001,
		4,
		200,
		"8:1:1003"
	},
	{
		394001,
		5,
		250,
		"8:1:1004"
	},
	{
		394001,
		6,
		300,
		"8:1:1005"
	},
	{
		394001,
		7,
		350,
		"8:1:1006"
	},
	{
		394002,
		1,
		25,
		"4:31:5"
	},
	{
		394002,
		2,
		50,
		"9:1300024:20"
	},
	{
		394002,
		3,
		75,
		"8:1:2500000"
	},
	{
		394002,
		4,
		100,
		"9:1300024:20"
	},
	{
		394002,
		5,
		125,
		"8:1:2500000"
	},
	{
		394002,
		6,
		150,
		"9:1300024:20"
	},
	{
		394002,
		7,
		175,
		"4:31:5"
	},
	{
		394002,
		8,
		200,
		"9:1300024:20"
	},
	{
		394002,
		9,
		225,
		"8:1:2500000"
	},
	{
		394002,
		10,
		250,
		"9:1300024:20"
	},
	{
		394002,
		11,
		275,
		"8:1:2500000"
	},
	{
		394002,
		12,
		300,
		"9:1300024:20"
	},
	{
		394003,
		1,
		50,
		"8:1:1000"
	},
	{
		394003,
		2,
		100,
		"8:1:1001"
	},
	{
		394003,
		3,
		150,
		"8:1:1002"
	},
	{
		394003,
		4,
		200,
		"8:1:1003"
	},
	{
		394003,
		5,
		250,
		"8:1:1004"
	},
	{
		394003,
		6,
		300,
		"8:1:1005"
	},
	{
		394003,
		7,
		350,
		"8:1:1006"
	}
}
local t_linkendless_game_progress = {
	[394001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	},
	[394002] = {
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
		dataList[19]
	},
	[394003] = {
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25],
		dataList[26]
	}
}

t_linkendless_game_progress.dataList = dataList

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

return t_linkendless_game_progress
