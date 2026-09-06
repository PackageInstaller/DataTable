-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_jieshen_vs_jiu_activity.lua

module("logicconfig.config.t_jieshen_vs_jiu_activity", package.seeall)

local title = {
	activityId = 1,
	worldProgressPrizePlanId = 4,
	dailyGameTimes = 2,
	progressPlanId = 3
}
local dataList = {
	{
		390001,
		3,
		2,
		5
	}
}
local t_jieshen_vs_jiu_activity = {
	[390001] = dataList[1]
}

t_jieshen_vs_jiu_activity.dataList = dataList

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

return t_jieshen_vs_jiu_activity
