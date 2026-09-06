-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_sun_wu_kong_challenge_flip_game.lua

module("logicconfig.config.t_sun_wu_kong_challenge_flip_game", package.seeall)

local title = {
	cardNum = 5,
	defaultTime = 4,
	stageId = 2,
	iconNum2 = 7,
	planId = 1,
	iconNum4 = 9,
	iconNum1 = 6,
	touchNum = 3,
	iconNum3 = 8
}
local dataList = {
	{
		1,
		1,
		1,
		45,
		{
			2,
			5
		},
		4,
		4,
		2,
		0
	},
	{
		2,
		1,
		1,
		90,
		{
			3,
			8
		},
		6,
		6,
		6,
		6
	},
	{
		3,
		1,
		1,
		30,
		{
			4,
			4
		},
		4,
		4,
		4,
		4
	}
}
local t_sun_wu_kong_challenge_flip_game = {
	{
		dataList[1]
	},
	{
		dataList[2]
	},
	{
		dataList[3]
	}
}

t_sun_wu_kong_challenge_flip_game.dataList = dataList

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

return t_sun_wu_kong_challenge_flip_game
