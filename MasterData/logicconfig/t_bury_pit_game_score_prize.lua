-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_bury_pit_game_score_prize.lua

module("logicconfig.config.t_bury_pit_game_score_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	planId = 1,
	needScore = 3
}
local dataList = {
	{
		1,
		1,
		500,
		"8:1:500000"
	},
	{
		1,
		2,
		1000,
		"4:90015:10"
	},
	{
		1,
		3,
		1500,
		"4:14:120"
	},
	{
		1,
		4,
		2000,
		"4:71:2"
	},
	{
		1,
		5,
		3000,
		"4:90045:10"
	},
	{
		1,
		6,
		4000,
		"4:12:240"
	},
	{
		1,
		7,
		5000,
		"13:27:1"
	},
	{
		1,
		8,
		6000,
		"104:2:300"
	},
	{
		1,
		9,
		7000,
		"4:41004:1"
	},
	{
		1,
		10,
		8000,
		"4:31:5"
	},
	{
		1,
		11,
		9000,
		"4:31:5"
	},
	{
		1,
		12,
		10000,
		"4:90031:1"
	}
}
local t_bury_pit_game_score_prize = {
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
		dataList[12]
	}
}

t_bury_pit_game_score_prize.dataList = dataList

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

return t_bury_pit_game_score_prize
