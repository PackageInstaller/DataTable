-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_gear_game_activity.lua

module("logicconfig.config.t_gear_game_activity", package.seeall)

local title = {
	activityId = 1,
	ruleId = 2
}
local dataList = {
	{
		604001,
		1
	}
}
local t_gear_game_activity = {
	[604001] = dataList[1]
}

t_gear_game_activity.dataList = dataList

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

return t_gear_game_activity
