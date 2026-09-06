-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_young_arena_king_s3_activity.lua

module("logicconfig.config.t_young_arena_king_s3_activity", package.seeall)

local title = {
	exchangeItem = 2,
	sysZdlWanPercent = 7,
	shopGotoStr = 6,
	dailyMatchPrizeTimes = 3,
	reportLimit = 4,
	activityId = 1,
	ruleKey = 5
}
local dataList = {
	{
		624001,
		"10:624001",
		10,
		5,
		"young_championS3_king_rule",
		"func#191#624#624001",
		10000
	}
}
local t_young_arena_king_s3_activity = {
	[624001] = dataList[1]
}

t_young_arena_king_s3_activity.dataList = dataList

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

return t_young_arena_king_s3_activity
