-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_elves_revealed_activity.lua

module("logicconfig.config.t_elves_revealed_activity", package.seeall)

local title = {
	activityId = 1,
	redPointId = 2,
	ruleKey = 3
}
local dataList = {
	{
		406001,
		0,
		"elvesrevealedmainview_rule"
	},
	{
		406002,
		0,
		"elvesrevealedmainview_rule"
	},
	{
		406003,
		0,
		"elvesrevealedmainview_rule"
	},
	{
		406004,
		0,
		"elvesrevealedmainview_rule"
	},
	{
		406005,
		0,
		"elvesrevealedmainview_rule"
	},
	{
		406006,
		0,
		"elvesrevealedmainview_rule"
	}
}
local t_elves_revealed_activity = {
	[406001] = dataList[1],
	[406002] = dataList[2],
	[406003] = dataList[3],
	[406004] = dataList[4],
	[406005] = dataList[5],
	[406006] = dataList[6]
}

t_elves_revealed_activity.dataList = dataList

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

return t_elves_revealed_activity
