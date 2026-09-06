-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_game_2048_hanging_prize.lua

module("logicconfig.config.t_game_2048_hanging_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	needScore = 3
}
local dataList = {
	{
		320004,
		1,
		500,
		"8:1:1000000"
	},
	{
		320004,
		2,
		1000,
		"60:1:1000"
	},
	{
		320004,
		3,
		3000,
		"4:36:5"
	},
	{
		320004,
		4,
		5000,
		"60:1:1000"
	},
	{
		320004,
		5,
		10000,
		"4:112:5"
	},
	{
		320004,
		6,
		15000,
		"60:1:1000"
	},
	{
		320004,
		7,
		20000,
		"4:36:5"
	},
	{
		320004,
		8,
		30000,
		"4:112:5"
	},
	{
		320005,
		1,
		500,
		"8:1:100000"
	},
	{
		320005,
		2,
		1000,
		"8:1:100000"
	},
	{
		320005,
		3,
		3000,
		"8:1:100000"
	},
	{
		320005,
		4,
		5000,
		"8:1:100000"
	},
	{
		320005,
		5,
		10000,
		"8:1:100000"
	},
	{
		320005,
		6,
		15000,
		"8:1:100000"
	},
	{
		320005,
		7,
		20000,
		"8:1:100000"
	},
	{
		320005,
		8,
		30000,
		"10:540001:1"
	}
}
local t_game_2048_hanging_prize = {
	[320004] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	[320005] = {
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	}
}

t_game_2048_hanging_prize.dataList = dataList

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

return t_game_2048_hanging_prize
