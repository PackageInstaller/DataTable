-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_young_arena_king_s3_win_streak_score.lua

module("logicconfig.config.t_young_arena_king_s3_win_streak_score", package.seeall)

local title = {
	winStreak = 3,
	rankScorePlanId = 1,
	addRankScore = 4,
	rankScoreId = 2
}
local dataList = {
	{
		1,
		1,
		0,
		0
	}
}
local t_young_arena_king_s3_win_streak_score = {
	{
		dataList[1]
	}
}

t_young_arena_king_s3_win_streak_score.dataList = dataList

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

return t_young_arena_king_s3_win_streak_score
