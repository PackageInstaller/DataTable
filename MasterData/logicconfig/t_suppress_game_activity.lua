-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_suppress_game_activity.lua

module("logicconfig.config.t_suppress_game_activity", package.seeall)

local title = {
	firstEnterStoryId = 4,
	redPointId = 3,
	dailyGameTime = 2,
	activityId = 1
}
local dataList = {
	{
		161001,
		5,
		282,
		4290001
	}
}
local t_suppress_game_activity = {
	[161001] = dataList[1]
}

t_suppress_game_activity.dataList = dataList

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

return t_suppress_game_activity
