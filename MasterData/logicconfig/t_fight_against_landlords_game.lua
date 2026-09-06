-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fight_against_landlords_game.lua

module("logicconfig.config.t_fight_against_landlords_game", package.seeall)

local title = {
	initialScore = 5,
	gameName = 3,
	gamePlanId = 1,
	rate = 6,
	minScoreLimit = 4,
	gameId = 2
}
local dataList = {
	{
		1,
		1,
		"初级",
		640,
		80,
		2
	},
	{
		1,
		2,
		"中级",
		1440,
		180,
		2
	},
	{
		1,
		3,
		"高级",
		2400,
		300,
		2
	}
}
local t_fight_against_landlords_game = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_fight_against_landlords_game.dataList = dataList

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

return t_fight_against_landlords_game
