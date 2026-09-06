-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_explore_under_game.lua

module("logicconfig.config.t_explore_under_game", package.seeall)

local title = {
	sucPrize = 4,
	failPrize = 3,
	playerStep = 7,
	iconId = 8,
	countDown = 5,
	petStep = 6,
	planId = 1,
	subId = 2
}
local dataList = {
	{
		1,
		1,
		"10:160001:10#8:1:25000",
		"10:160001:20#8:1:50000",
		20,
		{
			10,
			4,
			3,
			15,
			3,
			4,
			4,
			10,
			8,
			6
		},
		7,
		3
	},
	{
		2,
		1,
		"10:459001:2#10:459002:2#10:459003:2#10:459004:2#8:1:1000",
		"10:459001:4#10:459002:4#10:459003:4#10:459004:4#8:1:1000",
		20,
		{
			10,
			4,
			3,
			15,
			3,
			4,
			4,
			10,
			8,
			6
		},
		7,
		3
	}
}
local t_explore_under_game = {
	{
		dataList[1]
	},
	{
		dataList[2]
	}
}

t_explore_under_game.dataList = dataList

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

return t_explore_under_game
