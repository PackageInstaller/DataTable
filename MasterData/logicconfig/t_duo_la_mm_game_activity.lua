-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_duo_la_mm_game_activity.lua

module("logicconfig.config.t_duo_la_mm_game_activity", package.seeall)

local title = {
	maxPieceOnceGame = 3,
	gamePlanId = 5,
	redPointId = 4,
	dailyFreeGameTimes = 2,
	dropPlanId = 6,
	activityId = 1
}
local dataList = {
	{
		375001,
		3,
		30,
		581,
		2,
		6
	}
}
local t_duo_la_mm_game_activity = {
	[375001] = dataList[1]
}

t_duo_la_mm_game_activity.dataList = dataList

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

return t_duo_la_mm_game_activity
