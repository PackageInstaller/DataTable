-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_empress_activity.lua

module("logicconfig.config.t_divine_empress_activity", package.seeall)

local title = {
	extremeClgPrize = 4,
	dailyResetTimes = 3,
	redPointId = 2,
	jumpTo = 8,
	raceId = 7,
	normalClgGroupNumber = 5,
	activityId = 1,
	functionId = 6
}
local dataList = {
	{
		485001,
		704,
		3,
		"4:296:100",
		3,
		3,
		16035,
		{
			"func#618#16035",
			"ui#lottery",
			"func#43#136",
			"mibao#ZhounianShop1"
		}
	}
}
local t_divine_empress_activity = {
	[485001] = dataList[1]
}

t_divine_empress_activity.dataList = dataList

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

return t_divine_empress_activity
