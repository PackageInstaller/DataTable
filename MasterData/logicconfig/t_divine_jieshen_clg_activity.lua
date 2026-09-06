-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_jieshen_clg_activity.lua

module("logicconfig.config.t_divine_jieshen_clg_activity", package.seeall)

local title = {
	normalPassPrize = 5,
	comPlanId = 9,
	normalClgLoginAddTimes = 7,
	normalClgMaxTimes = 6,
	extremePassPrize = 2,
	trialRandomPlanId = 3,
	redrawPlanId = 4,
	normalBossId = 8,
	activityId = 1
}
local dataList = {
	{
		387001,
		"4:510318:100",
		1,
		1,
		"4:510318:100",
		3,
		2,
		3001,
		1
	}
}
local t_divine_jieshen_clg_activity = {
	[387001] = dataList[1]
}

t_divine_jieshen_clg_activity.dataList = dataList

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

return t_divine_jieshen_clg_activity
