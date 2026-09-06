-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_chuang_kong_union_activity.lua

module("logicconfig.config.t_chuang_kong_union_activity", package.seeall)

local title = {
	breachFormPlan = 2,
	scoreItemKey = 4,
	activityId = 1,
	dailyTaskPlan = 3
}
local dataList = {
	{
		102001,
		1,
		1,
		"4:128"
	}
}
local t_chuang_kong_union_activity = {
	[102001] = dataList[1]
}

t_chuang_kong_union_activity.dataList = dataList

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

return t_chuang_kong_union_activity
