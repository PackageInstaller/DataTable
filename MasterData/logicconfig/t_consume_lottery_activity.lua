-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_consume_lottery_activity.lua

module("logicconfig.config.t_consume_lottery_activity", package.seeall)

local title = {
	pledgeNum = 4,
	ticketPrice = 3,
	activityId = 1,
	prizePlanId = 2
}
local dataList = {
	{
		29001,
		1,
		1,
		100
	}
}
local t_consume_lottery_activity = {
	[29001] = dataList[1]
}

t_consume_lottery_activity.dataList = dataList

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

return t_consume_lottery_activity
