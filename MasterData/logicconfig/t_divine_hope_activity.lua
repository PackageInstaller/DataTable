-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_hope_activity.lua

module("logicconfig.config.t_divine_hope_activity", package.seeall)

local title = {
	paramStr = 3,
	activityId = 1,
	clgOpenTime = 2,
	skinId = 4
}
local dataList = {
	{
		518001,
		"2025-10-01T09:00:00",
		"{\"jumpStr1\":\"func#618#14038\",\"jumpStr2\":\"mibao#MibaoShop\",\"jumpStr3\":\"ui#lottery\",\"jumpStr4\":\"event#gotofirstpassrankview#518001\"}",
		14038
	}
}
local t_divine_hope_activity = {
	[518001] = dataList[1]
}

t_divine_hope_activity.dataList = dataList

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

return t_divine_hope_activity
