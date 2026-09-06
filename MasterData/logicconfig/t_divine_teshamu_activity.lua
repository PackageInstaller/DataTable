-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_teshamu_activity.lua

module("logicconfig.config.t_divine_teshamu_activity", package.seeall)

local title = {
	functionId = 4,
	incSoldierPercent = 3,
	skinId = 6,
	paramStr = 5,
	activityId = 1,
	decBloodPercent = 2
}
local dataList = {
	{
		504001,
		20,
		20,
		5193,
		"{\"jumpStr1\":\"func#618#11032\",\"jumpStr2\":\"mibao#MibaoShop\",\"jumpStr3\":\"ui#lottery\",\"jumpStr4\":\"event#gotofirstpassrankview#504001\"}",
		11032
	}
}
local t_divine_teshamu_activity = {
	[504001] = dataList[1]
}

t_divine_teshamu_activity.dataList = dataList

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

return t_divine_teshamu_activity
