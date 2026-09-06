-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_game_2048_extreme_rank_prize.lua

module("logicconfig.config.t_game_2048_extreme_rank_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 5,
	title = 4,
	activityId = 1,
	rankRange = 3
}
local dataList = {
	{
		320004,
		1,
		{
			1,
			3000
		},
		"1-3000名",
		"2:200:1"
	}
}
local t_game_2048_extreme_rank_prize = {
	[320004] = {
		dataList[1]
	}
}

t_game_2048_extreme_rank_prize.dataList = dataList

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

return t_game_2048_extreme_rank_prize
