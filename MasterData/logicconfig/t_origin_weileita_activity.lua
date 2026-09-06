-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_weileita_activity.lua

module("logicconfig.config.t_origin_weileita_activity", package.seeall)

local title = {
	extremePassPrize = 2,
	jumpList = 4,
	normalDailyCount = 3,
	raceId = 5,
	activityId = 1
}
local dataList = {
	{
		561001,
		"4:510698:100",
		3,
		{
			"func#618#12040",
			"func#618#12040",
			"ui#lottery",
			"ui#lottery",
			"func#43#144"
		},
		12040
	}
}
local t_origin_weileita_activity = {
	[561001] = dataList[1]
}

t_origin_weileita_activity.dataList = dataList

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

return t_origin_weileita_activity
