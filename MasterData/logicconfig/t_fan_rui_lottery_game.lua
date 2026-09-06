-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fan_rui_lottery_game.lua

module("logicconfig.config.t_fan_rui_lottery_game", package.seeall)

local title = {
	loseRate = 7,
	lowerLimit = 4,
	winTime = 10,
	waitTime = 11,
	highLimit = 5,
	winRate = 6,
	chipItem = 3,
	ruleId = 9,
	cheatCost = 2,
	actId = 1,
	chengeChip = 8
}
local dataList = {
	{
		299001,
		"10:299002:1",
		"10:299001",
		100,
		500,
		1.5,
		0.7,
		100,
		1,
		3,
		5
	}
}
local t_fan_rui_lottery_game = {
	[299001] = dataList[1]
}

t_fan_rui_lottery_game.dataList = dataList

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

return t_fan_rui_lottery_game
