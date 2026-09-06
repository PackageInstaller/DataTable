-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_draw_and_guess_activity.lua

module("logicconfig.config.t_draw_and_guess_activity", package.seeall)

local title = {
	activityId = 1,
	dailyTimes = 2
}
local dataList = {
	{
		536001,
		3
	}
}
local t_draw_and_guess_activity = {
	[536001] = dataList[1]
}

t_draw_and_guess_activity.dataList = dataList

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

return t_draw_and_guess_activity
