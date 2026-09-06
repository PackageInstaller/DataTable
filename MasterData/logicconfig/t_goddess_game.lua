-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_game.lua

module("logicconfig.config.t_goddess_game", package.seeall)

local title = {
	feeling = 3,
	planId = 1,
	scale = 2,
	prize = 4
}
local dataList = {
	{
		1,
		0,
		10,
		"8:1:1000"
	},
	{
		1,
		30,
		15,
		"8:1:1000"
	},
	{
		1,
		50,
		20,
		"8:1:1000"
	},
	{
		1,
		70,
		25,
		"8:1:1000"
	},
	{
		1,
		90,
		30,
		"8:1:1000"
	}
}
local t_goddess_game = {
	{
		[0] = dataList[1],
		[30] = dataList[2],
		[50] = dataList[3],
		[70] = dataList[4],
		[90] = dataList[5]
	}
}

t_goddess_game.dataList = dataList

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

return t_goddess_game
