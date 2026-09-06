-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_zdl_verify_activity.lua

module("logicconfig.config.t_zdl_verify_activity", package.seeall)

local title = {
	activityId = 1,
	redPointId = 2,
	ruleKey = 3
}
local dataList = {
	{
		614001,
		785,
		"zhanliyanzheng_rule"
	}
}
local t_zdl_verify_activity = {
	[614001] = dataList[1]
}

t_zdl_verify_activity.dataList = dataList

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

return t_zdl_verify_activity
