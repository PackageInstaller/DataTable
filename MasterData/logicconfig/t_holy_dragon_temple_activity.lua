-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_dragon_temple_activity.lua

module("logicconfig.config.t_holy_dragon_temple_activity", package.seeall)

local title = {
	redPointId = 2,
	formatComboTimes = 6,
	relevantFieldActivityId = 3,
	mainRuleKey = 5,
	comboBuffId = 4,
	activityId = 1,
	formatCircle = 7
}
local dataList = {
	{
		609001,
		783,
		611001,
		30000031,
		"holydragontemplemainview_rule",
		82057643,
		82057644
	}
}
local t_holy_dragon_temple_activity = {
	[609001] = dataList[1]
}

t_holy_dragon_temple_activity.dataList = dataList

local multiLanguageCells = {
	formatCircle = true,
	formatComboTimes = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_holy_dragon_temple_activity
