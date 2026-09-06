-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_annual_fee_preheat_game.lua

module("logicconfig.config.t_annual_fee_preheat_game", package.seeall)

local title = {
	stageId = 1,
	defaultTime = 3,
	iconNum5 = 9,
	iconNum2 = 6,
	cardNum = 4,
	prize = 10,
	stageName = 2,
	iconNum4 = 8,
	iconNum1 = 5,
	iconNum3 = 7
}
local dataList = {
	{
		1,
		"简单",
		45,
		{
			2,
			5
		},
		{
			4,
			10313
		},
		{
			4,
			10027
		},
		{
			2,
			10324
		},
		nil,
		nil,
		"4:2:10#4:901:500#4:902:2"
	},
	{
		2,
		"中等",
		60,
		{
			3,
			6
		},
		{
			4,
			10313
		},
		{
			4,
			10027
		},
		{
			4,
			10324
		},
		{
			6,
			10326
		},
		nil,
		"4:2:15#4:901:800#4:902:3"
	},
	{
		3,
		"困难",
		90,
		{
			4,
			7
		},
		{
			6,
			10313
		},
		{
			6,
			10027
		},
		{
			6,
			10324
		},
		{
			6,
			10326
		},
		{
			4,
			10127
		},
		"4:2:20#4:901:1100#4:902:4"
	}
}
local t_annual_fee_preheat_game = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_annual_fee_preheat_game.dataList = dataList

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

return t_annual_fee_preheat_game
