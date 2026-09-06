-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_big_cast_challenge_win_streak_prize.lua

module("logicconfig.config.t_big_cast_challenge_win_streak_prize", package.seeall)

local title = {
	winStreakTimes = 2,
	prize = 3,
	planId = 1
}
local dataList = {
	{
		1,
		2,
		"4:10:30"
	},
	{
		1,
		4,
		"4:10:60"
	},
	{
		1,
		6,
		"4:10:90"
	},
	{
		1,
		8,
		"4:10:120"
	},
	{
		2,
		2,
		"4:10:30"
	},
	{
		2,
		4,
		"4:10:60"
	},
	{
		2,
		6,
		"4:10:90"
	}
}
local t_big_cast_challenge_win_streak_prize = {
	{
		[2] = dataList[1],
		[4] = dataList[2],
		[6] = dataList[3],
		[8] = dataList[4]
	},
	{
		[2] = dataList[5],
		[4] = dataList[6],
		[6] = dataList[7]
	}
}

t_big_cast_challenge_win_streak_prize.dataList = dataList

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

return t_big_cast_challenge_win_streak_prize
