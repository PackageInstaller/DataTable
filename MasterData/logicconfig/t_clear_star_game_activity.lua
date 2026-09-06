-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_clear_star_game_activity.lua

module("logicconfig.config.t_clear_star_game_activity", package.seeall)

local title = {
	dailyTime = 3,
	scorePlanId = 5,
	redPointId = 2,
	mapPlanId = 4,
	activityId = 1
}
local dataList = {
	{
		479001,
		710,
		3,
		1,
		1
	},
	{
		479002,
		710,
		3,
		1,
		1
	},
	{
		479003,
		710,
		3,
		1,
		1
	}
}
local t_clear_star_game_activity = {
	[479001] = dataList[1],
	[479002] = dataList[2],
	[479003] = dataList[3]
}

t_clear_star_game_activity.dataList = dataList

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

return t_clear_star_game_activity
