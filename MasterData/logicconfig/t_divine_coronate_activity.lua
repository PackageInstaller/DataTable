-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_coronate_activity.lua

module("logicconfig.config.t_divine_coronate_activity", package.seeall)

local title = {
	activityId = 1,
	redPointId = 3,
	dailyGameTimes = 2,
	gameId = 4
}
local dataList = {
	{
		410001,
		1,
		614,
		280004
	}
}
local t_divine_coronate_activity = {
	[410001] = dataList[1]
}

t_divine_coronate_activity.dataList = dataList

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

return t_divine_coronate_activity
