-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_the_outcast_challenge_game.lua

module("logicconfig.config.t_the_outcast_challenge_game", package.seeall)

local title = {
	planId = 3,
	prize = 2,
	gameId = 1
}
local dataList = {
	{
		1,
		"4:32:1",
		1
	},
	{
		2,
		"4:32:1",
		2
	},
	{
		3,
		"4:31:1",
		3
	},
	{
		4,
		"4:32:1",
		4
	},
	{
		5,
		"4:32:1",
		5
	},
	{
		6,
		"4:31:1",
		6
	},
	{
		7,
		"4:32:1",
		7
	},
	{
		8,
		"2:35:1",
		8
	}
}
local t_the_outcast_challenge_game = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8]
}

t_the_outcast_challenge_game.dataList = dataList

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

return t_the_outcast_challenge_game
