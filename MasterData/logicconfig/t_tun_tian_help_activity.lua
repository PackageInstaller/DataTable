-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tun_tian_help_activity.lua

module("logicconfig.config.t_tun_tian_help_activity", package.seeall)

local title = {
	jumpPlanId = 4,
	redPointId = 3,
	activityId = 1,
	dailyTimesLimit = 2
}
local dataList = {
	{
		290001,
		3,
		503,
		1
	},
	{
		290002,
		1,
		503,
		2
	}
}
local t_tun_tian_help_activity = {
	[290001] = dataList[1],
	[290002] = dataList[2]
}

t_tun_tian_help_activity.dataList = dataList

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

return t_tun_tian_help_activity
