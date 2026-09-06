-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_magic_school_pvp_activity.lua

module("logicconfig.config.t_magic_school_pvp_activity", package.seeall)

local title = {
	dailyTimes = 2,
	jumpStrThree = 7,
	jumpRedIdThree = 11,
	jumpStrOne = 5,
	jumpStrTwo = 6,
	jumpRedIdTwo = 10,
	actItem = 3,
	jumpRedIdFour = 12,
	jumpRedIdOne = 9,
	jumpStrFour = 8,
	ruleKeyMain = 4,
	activityId = 1
}
local dataList = {
	{
		514001,
		12,
		"10:17168",
		"heibaiduiyi_rule_main",
		"func#191#17#17168",
		"ui#commongrouptaskmainview#514001",
		"",
		"",
		"",
		"735",
		"",
		""
	}
}
local t_magic_school_pvp_activity = {
	[514001] = dataList[1]
}

t_magic_school_pvp_activity.dataList = dataList

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

return t_magic_school_pvp_activity
