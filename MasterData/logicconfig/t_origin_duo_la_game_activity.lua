-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_duo_la_game_activity.lua

module("logicconfig.config.t_origin_duo_la_game_activity", package.seeall)

local title = {
	redPointId = 3,
	jumpToStrs = 6,
	dailyPassLimit = 2,
	skinId = 4,
	activityId = 1,
	ruleKey = 5
}
local dataList = {
	{
		597001,
		5,
		777,
		11042,
		"origin_duo_la_game_rule",
		{
			"func#618#11042",
			"func#1119",
			"mibao#mengduiyangcheng"
		}
	}
}
local t_origin_duo_la_game_activity = {
	[597001] = dataList[1]
}

t_origin_duo_la_game_activity.dataList = dataList

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

return t_origin_duo_la_game_activity
