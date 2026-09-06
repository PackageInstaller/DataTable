-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_draw_and_guess_prize.lua

module("logicconfig.config.t_draw_and_guess_prize", package.seeall)

local title = {
	prizeId = 2,
	score = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		536001,
		1,
		20,
		"8:1:10000000"
	},
	{
		536001,
		2,
		40,
		"4:36:10"
	},
	{
		536001,
		3,
		60,
		"4:510022:5"
	},
	{
		536001,
		4,
		100,
		"8:1:10000000"
	},
	{
		536001,
		5,
		150,
		"4:400002:100"
	},
	{
		536001,
		6,
		200,
		"8:1:10000000"
	},
	{
		536001,
		7,
		250,
		"8:1:20000000"
	},
	{
		536001,
		8,
		300,
		"4:400002:200"
	}
}
local t_draw_and_guess_prize = {
	[536001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_draw_and_guess_prize.dataList = dataList

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

return t_draw_and_guess_prize
