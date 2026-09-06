-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_sun_wu_kong_challenge_balloon_game.lua

module("logicconfig.config.t_sun_wu_kong_challenge_balloon_game", package.seeall)

local title = {
	planId = 1,
	scale = 2,
	flowerNum = 3
}
local dataList = {
	{
		1,
		15,
		1
	},
	{
		1,
		35,
		30
	},
	{
		1,
		50,
		50
	},
	{
		1,
		70,
		70
	},
	{
		1,
		96,
		90
	}
}
local t_sun_wu_kong_challenge_balloon_game = {
	{
		[15] = dataList[1],
		[35] = dataList[2],
		[50] = dataList[3],
		[70] = dataList[4],
		[96] = dataList[5]
	}
}

t_sun_wu_kong_challenge_balloon_game.dataList = dataList

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

return t_sun_wu_kong_challenge_balloon_game
