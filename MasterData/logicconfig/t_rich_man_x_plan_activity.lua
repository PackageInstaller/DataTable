-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_rich_man_x_plan_activity.lua

module("logicconfig.config.t_rich_man_x_plan_activity", package.seeall)

local title = {
	mainviewRule = 11,
	dagongRule = 10,
	initGrid = 3,
	geziTypeRule = 9,
	levelUpUseNumber = 6,
	boyiRule = 13,
	initZone = 2,
	hasTudiRule = 8,
	yaojiangRule = 12,
	workStorage = 5,
	petLimit = 4,
	activityId = 1,
	initScore = 7
}
local dataList = {
	{
		373001,
		1,
		3,
		50,
		500000,
		2,
		200000,
		"xplanownland_rule",
		"xplanroadtype_rule",
		"xplanworking_rule",
		"xplanmainview_rule",
		"xplanyaojiang_rule",
		"xplanboyi_rule"
	}
}
local t_rich_man_x_plan_activity = {
	[373001] = dataList[1]
}

t_rich_man_x_plan_activity.dataList = dataList

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

return t_rich_man_x_plan_activity
