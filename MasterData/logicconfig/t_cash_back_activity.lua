-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_cash_back_activity.lua

module("logicconfig.config.t_cash_back_activity", package.seeall)

local title = {
	activityId = 1,
	drawEndDays = 5,
	gotoStr = 3,
	weightRatio = 2,
	drawHourRanges = 4
}
local dataList = {
	{
		193001,
		1,
		"mibao#Zhuoyanmixin",
		{
			{
				21,
				21
			}
		},
		7
	}
}
local t_cash_back_activity = {
	[193001] = dataList[1]
}

t_cash_back_activity.dataList = dataList

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

return t_cash_back_activity
