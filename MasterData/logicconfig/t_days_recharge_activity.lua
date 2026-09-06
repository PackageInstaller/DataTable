-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_days_recharge_activity.lua

module("logicconfig.config.t_days_recharge_activity", package.seeall)

local title = {
	activityId = 1,
	redPointId = 2
}
local dataList = {
	{
		79001,
		158
	},
	{
		79002,
		158
	},
	{
		79003,
		158
	},
	{
		79004,
		158
	},
	{
		79005,
		488
	}
}
local t_days_recharge_activity = {
	[79001] = dataList[1],
	[79002] = dataList[2],
	[79003] = dataList[3],
	[79004] = dataList[4],
	[79005] = dataList[5]
}

t_days_recharge_activity.dataList = dataList

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

return t_days_recharge_activity
