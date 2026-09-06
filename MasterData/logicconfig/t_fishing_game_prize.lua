-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fishing_game_prize.lua

module("logicconfig.config.t_fishing_game_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	needScore = 3
}
local dataList = {
	{
		607001,
		1,
		100,
		"60:1:3000"
	},
	{
		607001,
		2,
		200,
		"4:400002:100"
	},
	{
		607001,
		3,
		300,
		"4:36:10"
	},
	{
		607001,
		4,
		400,
		"60:1:3000"
	},
	{
		607001,
		5,
		500,
		"4:510022:5"
	},
	{
		607001,
		6,
		600,
		"4:400002:100"
	},
	{
		607001,
		7,
		700,
		"60:1:4000"
	},
	{
		607001,
		8,
		800,
		"4:510824:5"
	},
	{
		607001,
		9,
		900,
		"8:1:10000000"
	},
	{
		607001,
		10,
		1000,
		"4:400004:20"
	}
}
local t_fishing_game_prize = {
	[607001] = {
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
	}
}

t_fishing_game_prize.dataList = dataList

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

return t_fishing_game_prize
