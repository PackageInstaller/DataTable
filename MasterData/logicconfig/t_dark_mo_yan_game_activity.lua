-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dark_mo_yan_game_activity.lua

module("logicconfig.config.t_dark_mo_yan_game_activity", package.seeall)

local title = {
	maxScoreSingleGame = 3,
	activityId = 1,
	gamePlanId = 2,
	skinId = 7,
	redPointId = 5,
	buyTimePlanId = 8,
	dailyGameTime = 4,
	ruleKey = 6
}
local dataList = {
	{
		458001,
		1,
		30,
		3,
		679,
		"darkmoyangame_rule",
		15031,
		1
	}
}
local t_dark_mo_yan_game_activity = {
	[458001] = dataList[1]
}

t_dark_mo_yan_game_activity.dataList = dataList

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

return t_dark_mo_yan_game_activity
