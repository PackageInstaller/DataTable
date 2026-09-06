-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_hex_lineup_game.lua

module("logicconfig.config.t_hex_lineup_game", package.seeall)

local title = {
	shuffleCount = 7,
	stepCount = 8,
	pieceCount = 3,
	rhythmPlanId = 9,
	boardRadius = 2,
	clearScore = 5,
	gamePlanId = 1,
	knockCount = 6,
	placeScore = 4
}
local dataList = {
	{
		1,
		5,
		3,
		1,
		1,
		3,
		3,
		30,
		1
	},
	{
		2,
		5,
		3,
		1,
		1,
		10,
		10,
		0,
		2
	}
}
local t_hex_lineup_game = {
	dataList[1],
	dataList[2]
}

t_hex_lineup_game.dataList = dataList

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

return t_hex_lineup_game
