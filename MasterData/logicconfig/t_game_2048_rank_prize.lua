-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_game_2048_rank_prize.lua

module("logicconfig.config.t_game_2048_rank_prize", package.seeall)

local title = {
	prize = 5,
	index = 2,
	title = 4,
	activityId = 1,
	rankRange = 3
}
local dataList = {
	{
		320001,
		1,
		{
			1,
			3000
		},
		"第1-3000名",
		"2:133:1"
	},
	{
		320003,
		1,
		{
			1,
			3000
		},
		"第1-3000名",
		"2:133:1"
	}
}
local t_game_2048_rank_prize = {
	[320001] = {
		dataList[1]
	},
	[320003] = {
		dataList[2]
	}
}

t_game_2048_rank_prize.dataList = dataList

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

return t_game_2048_rank_prize
