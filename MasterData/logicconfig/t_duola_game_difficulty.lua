-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_duola_game_difficulty.lua

module("logicconfig.config.t_duola_game_difficulty", package.seeall)

local title = {
	prize = 3,
	difficultyId = 2,
	activityId = 1,
	diffName = 4
}
local dataList = {
	{
		279001,
		1,
		"4:510183:20",
		"正常"
	},
	{
		279001,
		2,
		"4:510183:30",
		"精英"
	},
	{
		279001,
		3,
		"4:510183:50",
		"困难"
	},
	{
		279002,
		1,
		"10:251004:10",
		"正常"
	},
	{
		279002,
		2,
		"10:251004:16",
		"精英"
	},
	{
		279002,
		3,
		"10:251004:24",
		"困难"
	},
	{
		279003,
		1,
		"10:453001:400",
		"正常"
	},
	{
		279003,
		2,
		"10:453001:600",
		"精英"
	},
	{
		279003,
		3,
		"10:453001:800",
		"困难"
	}
}
local t_duola_game_difficulty = {
	[279001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[279002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[279003] = {
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_duola_game_difficulty.dataList = dataList

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

return t_duola_game_difficulty
