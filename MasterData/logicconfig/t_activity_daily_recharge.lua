-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_activity_daily_recharge.lua

module("logicconfig.config.t_activity_daily_recharge", package.seeall)

local title = {
	activity = 1
}
local dataList = {
	{
		44001
	}
}
local t_activity_daily_recharge = {
	[44001] = dataList[1]
}

t_activity_daily_recharge.dataList = dataList

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

return t_activity_daily_recharge
