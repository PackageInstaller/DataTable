-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_chop_king_activity.lua

module("logicconfig.config.t_chop_king_activity", package.seeall)

local title = {
	circleOpenDateTime = 6,
	resetDropBuffCost = 3,
	creepsId = 2,
	jumpTo = 4,
	tenOpenDateTime = 7,
	loopOpenDateTime = 5,
	activityId = 1,
	showBar = 8
}
local dataList = {
	{
		470001,
		100000014,
		"105:6112:50",
		{
			"func#191#470#470001"
		},
		"2025-04-30T05:00:00",
		"2025-05-09T05:00:00",
		"2025-05-16T05:00:00",
		"10:470001"
	}
}
local t_chop_king_activity = {
	[470001] = dataList[1]
}

t_chop_king_activity.dataList = dataList

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

return t_chop_king_activity
