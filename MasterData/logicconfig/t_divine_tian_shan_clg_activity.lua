-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_tian_shan_clg_activity.lua

module("logicconfig.config.t_divine_tian_shan_clg_activity", package.seeall)

local title = {
	jumpStr1 = 6,
	stagePlanId = 4,
	jumpStr2 = 7,
	skinId = 11,
	ruleKey = 10,
	prize = 2,
	jumpStr3 = 8,
	redPointId = 3,
	normalClgPlanId = 5,
	activityId = 1,
	jumpStr4 = 9
}
local dataList = {
	{
		482001,
		"4:286:100",
		700,
		1,
		1,
		"func#618#11029",
		"mibao#shengqiyangcheng",
		"ui#lottery",
		"func#43#134",
		"divinetianshanclgview_rule",
		11029
	}
}
local t_divine_tian_shan_clg_activity = {
	[482001] = dataList[1]
}

t_divine_tian_shan_clg_activity.dataList = dataList

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

return t_divine_tian_shan_clg_activity
