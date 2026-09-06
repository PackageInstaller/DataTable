-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_disorder_dragon_activity.lua

module("logicconfig.config.t_divine_disorder_dragon_activity", package.seeall)

local title = {
	raceId = 2,
	activityId = 1,
	jumpTo = 3
}
local dataList = {
	{
		423001,
		16030,
		{
			"func#618#16030",
			"func#43",
			"mibao#xinqionglongming3"
		}
	},
	{
		423002,
		16030,
		{
			"func#618#16030",
			"func#43",
			"mibao#xinqionglongming3"
		}
	},
	{
		423003,
		16030,
		{
			"func#618#16030",
			"func#43",
			"mibao#xinqionglongming3"
		}
	}
}
local t_divine_disorder_dragon_activity = {
	[423001] = dataList[1],
	[423002] = dataList[2],
	[423003] = dataList[3]
}

t_divine_disorder_dragon_activity.dataList = dataList

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

return t_divine_disorder_dragon_activity
