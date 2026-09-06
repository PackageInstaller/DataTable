-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_purchase_limit_activity.lua

module("logicconfig.config.t_purchase_limit_activity", package.seeall)

local title = {
	raceId = 2,
	activityId = 1,
	posAndScale = 3
}
local dataList = {
	{
		298001,
		13009,
		{
			-30,
			-121,
			1
		}
	}
}
local t_purchase_limit_activity = {
	[298001] = dataList[1]
}

t_purchase_limit_activity.dataList = dataList

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

return t_purchase_limit_activity
