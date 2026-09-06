-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_xiu_er_clg_activity.lua

module("logicconfig.config.t_divine_xiu_er_clg_activity", package.seeall)

local title = {
	extremeClgPrize = 4,
	normalClgPrize = 2,
	redPointId = 5,
	comPlanId = 6,
	normalClgMaxProgress = 3,
	activityId = 1
}
local dataList = {
	{
		329001,
		"4:217:100",
		100,
		"4:217:100",
		539,
		1
	}
}
local t_divine_xiu_er_clg_activity = {
	[329001] = dataList[1]
}

t_divine_xiu_er_clg_activity.dataList = dataList

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

return t_divine_xiu_er_clg_activity
