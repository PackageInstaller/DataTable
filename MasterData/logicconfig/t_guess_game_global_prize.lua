-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_guess_game_global_prize.lua

module("logicconfig.config.t_guess_game_global_prize", package.seeall)

local title = {
	id = 2,
	prize = 4,
	globalPrizePlanId = 1,
	progress = 3
}
local dataList = {
	{
		1,
		1,
		50000,
		"104:2:50"
	},
	{
		1,
		2,
		100000,
		"104:2:50"
	},
	{
		1,
		3,
		200000,
		"104:2:50"
	},
	{
		1,
		4,
		400000,
		"104:2:50"
	},
	{
		1,
		5,
		600000,
		"104:2:50"
	},
	{
		1,
		6,
		800000,
		"104:2:50"
	},
	{
		1,
		7,
		1000000,
		"104:2:100"
	},
	{
		1,
		8,
		1200000,
		"104:2:100"
	}
}
local t_guess_game_global_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_guess_game_global_prize.dataList = dataList

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

return t_guess_game_global_prize
