-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_martial_contest_qualifier_active_rank_score.lua

module("logicconfig.config.t_martial_contest_qualifier_active_rank_score", package.seeall)

local title = {
	rankScoreId = 2,
	addRankScore = 4,
	activeNum = 3,
	quaActiveScorePlanId = 1
}
local dataList = {
	{
		1,
		1,
		0,
		0
	},
	{
		1,
		2,
		3,
		10
	},
	{
		1,
		3,
		6,
		30
	}
}
local t_martial_contest_qualifier_active_rank_score = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_martial_contest_qualifier_active_rank_score.dataList = dataList

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

return t_martial_contest_qualifier_active_rank_score
