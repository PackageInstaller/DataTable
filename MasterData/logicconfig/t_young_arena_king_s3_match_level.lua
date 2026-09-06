-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_young_arena_king_s3_match_level.lua

module("logicconfig.config.t_young_arena_king_s3_match_level", package.seeall)

local title = {
	quaLevelId = 2,
	quaLevelPlanId = 1,
	rankScoreLimit = 3
}
local dataList = {
	{
		1,
		1,
		0
	}
}
local t_young_arena_king_s3_match_level = {
	{
		dataList[1]
	}
}

t_young_arena_king_s3_match_level.dataList = dataList

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

return t_young_arena_king_s3_match_level
