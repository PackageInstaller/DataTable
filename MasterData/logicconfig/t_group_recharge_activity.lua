-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_group_recharge_activity.lua

module("logicconfig.config.t_group_recharge_activity", package.seeall)

local title = {
	teamPrizeNeedRecharge = 4,
	activityId = 1,
	teamPrizePlanId = 3,
	personalBroadcast = 6,
	matchNeedRecharge = 5,
	maxMatchSec = 8,
	personalPrizePlanId = 2,
	teamBroadcast = 7
}
local dataList = {
	{
		180001,
		1,
		1,
		6,
		0,
		648,
		1888,
		60
	}
}
local t_group_recharge_activity = {
	[180001] = dataList[1]
}

t_group_recharge_activity.dataList = dataList

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

return t_group_recharge_activity
