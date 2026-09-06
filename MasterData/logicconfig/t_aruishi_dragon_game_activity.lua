-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_aruishi_dragon_game_activity.lua

module("logicconfig.config.t_aruishi_dragon_game_activity", package.seeall)

local title = {
	itemId = 4,
	comPlanId = 5,
	redPointId = 2,
	challengeId = 6,
	dailyTimes = 3,
	activityId = 1
}
local dataList = {
	{
		366001,
		576,
		3,
		"10:366001",
		1,
		51
	}
}
local t_aruishi_dragon_game_activity = {
	[366001] = dataList[1]
}

t_aruishi_dragon_game_activity.dataList = dataList

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

return t_aruishi_dragon_game_activity
