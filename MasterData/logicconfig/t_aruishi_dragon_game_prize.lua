-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_aruishi_dragon_game_prize.lua

module("logicconfig.config.t_aruishi_dragon_game_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		366001,
		1,
		180,
		"8:1:2000000"
	},
	{
		366001,
		2,
		360,
		"4:111:2"
	},
	{
		366001,
		3,
		540,
		"4:510022:1"
	},
	{
		366001,
		4,
		720,
		"8:1:2000000"
	},
	{
		366001,
		5,
		900,
		"4:111:2"
	},
	{
		366001,
		6,
		1080,
		"4:510022:1"
	},
	{
		366001,
		7,
		1260,
		"8:1:2000000"
	},
	{
		366001,
		8,
		1440,
		"4:111:2"
	},
	{
		366001,
		9,
		1620,
		"4:510022:1"
	},
	{
		366001,
		10,
		1800,
		"8:1:2000000"
	},
	{
		366001,
		11,
		1980,
		"4:111:2"
	},
	{
		366001,
		12,
		2160,
		"4:510022:1"
	},
	{
		366001,
		13,
		2340,
		"8:1:2000000"
	},
	{
		366001,
		14,
		2520,
		"4:111:2"
	},
	{
		366001,
		15,
		2700,
		"4:510022:1"
	}
}
local t_aruishi_dragon_game_prize = {
	[366001] = {
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

t_aruishi_dragon_game_prize.dataList = dataList

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

return t_aruishi_dragon_game_prize
