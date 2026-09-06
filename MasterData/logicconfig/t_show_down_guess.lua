-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_show_down_guess.lua

module("logicconfig.config.t_show_down_guess", package.seeall)

local title = {
	maxGuessScore = 3,
	minGuessScore = 2,
	sameGroupLimit = 6,
	winRatio = 5,
	gussPlanId = 1,
	guessRoundLimit = 4
}
local dataList = {
	{
		1,
		10,
		1000,
		3000,
		0,
		4
	},
	{
		2,
		10,
		3000,
		9000,
		10,
		4
	},
	{
		3,
		10,
		5000,
		15000,
		10,
		4
	},
	{
		4,
		500,
		10000,
		30000,
		30,
		4
	}
}
local t_show_down_guess = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_show_down_guess.dataList = dataList

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

return t_show_down_guess
