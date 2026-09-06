-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_peak_tower_activity.lua

module("logicconfig.config.t_peak_tower_activity", package.seeall)

local title = {
	legendPrizeItem = 5,
	basicPrizeItem = 4,
	redPointId = 2,
	legendOpenScore = 6,
	canNotGainPrizeRank = 3,
	activityId = 1
}
local dataList = {
	{
		567001,
		762,
		2000,
		"4:400004",
		"1004:1610",
		"5000"
	}
}
local t_peak_tower_activity = {
	[567001] = dataList[1]
}

t_peak_tower_activity.dataList = dataList

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

return t_peak_tower_activity
