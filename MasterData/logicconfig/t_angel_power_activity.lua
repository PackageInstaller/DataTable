-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_angel_power_activity.lua

module("logicconfig.config.t_angel_power_activity", package.seeall)

local title = {
	raceId = 3,
	jumpTo = 5,
	transferRoundCount = 4,
	activityId = 1,
	transferPlanId = 2
}
local dataList = {
	{
		384001,
		1,
		17016,
		2,
		{
			"func#618#17016",
			"func#1104",
			"mibao#zhigaoshenlin2"
		}
	},
	{
		384002,
		1,
		17016,
		2,
		{
			"func#618#17016",
			"func#1104",
			"mibao#zhigaoshenlin2"
		}
	}
}
local t_angel_power_activity = {
	[384001] = dataList[1],
	[384002] = dataList[2]
}

t_angel_power_activity.dataList = dataList

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

return t_angel_power_activity
