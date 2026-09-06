-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_waken_activity.lua

module("logicconfig.config.t_goddess_waken_activity", package.seeall)

local title = {
	cost = 5,
	activityId = 1,
	petPlanId = 2,
	taskPlanId = 3,
	refund = 6,
	injectItemType = 4
}
local dataList = {
	{
		130001,
		1,
		1,
		"10:129001",
		"10:129001:25",
		"9:1033:1"
	}
}
local t_goddess_waken_activity = {
	[130001] = dataList[1]
}

t_goddess_waken_activity.dataList = dataList

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

return t_goddess_waken_activity
