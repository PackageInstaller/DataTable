-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_companion_mall_activity.lua

module("logicconfig.config.t_companion_mall_activity", package.seeall)

local title = {
	vedioName = 4,
	redPointId = 2,
	gainRedPointId = 3,
	activityId = 1,
	ruleKey = 5
}
local dataList = {
	{
		492001,
		708,
		718,
		"act_20250627_51",
		"companion_mall_rule"
	},
	{
		492002,
		708,
		718,
		"act_20250627_51",
		"companion_mall_rule"
	},
	{
		492003,
		708,
		718,
		"",
		"companionmallmainview_rule"
	}
}
local t_companion_mall_activity = {
	[492001] = dataList[1],
	[492002] = dataList[2],
	[492003] = dataList[3]
}

t_companion_mall_activity.dataList = dataList

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

return t_companion_mall_activity
