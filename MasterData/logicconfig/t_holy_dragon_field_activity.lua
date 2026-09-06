-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_dragon_field_activity.lua

module("logicconfig.config.t_holy_dragon_field_activity", package.seeall)

local title = {
	jumpToShop = 5,
	activityId = 1,
	comboBuffId = 3,
	mainRuleKey = 6,
	killNumBuffId = 4,
	relevantActivityId = 2
}
local dataList = {
	{
		611001,
		609001,
		30000031,
		30000034,
		"func#191#605#605001",
		"holydragonfieldmainview_rule"
	}
}
local t_holy_dragon_field_activity = {
	[611001] = dataList[1]
}

t_holy_dragon_field_activity.dataList = dataList

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

return t_holy_dragon_field_activity
