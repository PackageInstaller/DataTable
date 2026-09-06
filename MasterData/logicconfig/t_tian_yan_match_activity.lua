-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tian_yan_match_activity.lua

module("logicconfig.config.t_tian_yan_match_activity", package.seeall)

local title = {
	maxMatchSec = 7,
	normalMatchPrize = 6,
	friendshipLimit = 2,
	jumpTo = 13,
	activityId = 1,
	scoreItem = 9,
	gameActivityId = 11,
	template = 12,
	oneValueCost = 4,
	redPointId = 10,
	normalMatchScore = 5,
	dailyToyCount = 3,
	matchOpenTime = 8
}
local dataList = {
	{
		503001,
		150,
		3,
		"10:479009:1",
		5,
		"10:503001:5",
		60,
		"08:00-23:59",
		"1004:1552:1",
		720,
		479002,
		87,
		"func#191#503#503001"
	}
}
local t_tian_yan_match_activity = {
	[503001] = dataList[1]
}

t_tian_yan_match_activity.dataList = dataList

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

return t_tian_yan_match_activity
