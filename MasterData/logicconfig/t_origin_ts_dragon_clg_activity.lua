-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_ts_dragon_clg_activity.lua

module("logicconfig.config.t_origin_ts_dragon_clg_activity", package.seeall)

local title = {
	activityId = 1,
	skinId = 5,
	jumpTo = 3,
	prize = 2,
	ruleKey = 4
}
local dataList = {
	{
		591001,
		"4:510779:100",
		{
			"event#gotofirstpassrankview#591001",
			"func#618#15045",
			"ui#lottery",
			"mibao#jinglingyangcheng"
		},
		"yqshikonglong_rule",
		15045
	}
}
local t_origin_ts_dragon_clg_activity = {
	[591001] = dataList[1]
}

t_origin_ts_dragon_clg_activity.dataList = dataList

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

return t_origin_ts_dragon_clg_activity
