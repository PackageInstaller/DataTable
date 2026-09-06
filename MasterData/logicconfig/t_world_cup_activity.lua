-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_world_cup_activity.lua

module("logicconfig.config.t_world_cup_activity", package.seeall)

local title = {
	jumpToShop = 4,
	betItemKey = 3,
	redPointId = 2,
	guessTopGainPrizeTime = 7,
	guessTopEndTime = 6,
	activityId = 1,
	betFailPercent = 5
}
local dataList = {
	{
		602001,
		790,
		"10:602001",
		"func#191#602#602001",
		50,
		"2026-06-29T03:00:00",
		"2026-07-20T09:00:00"
	}
}
local t_world_cup_activity = {
	[602001] = dataList[1]
}

t_world_cup_activity.dataList = dataList

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

return t_world_cup_activity
