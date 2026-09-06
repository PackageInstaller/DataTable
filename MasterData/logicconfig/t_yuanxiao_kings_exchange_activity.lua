-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_yuanxiao_kings_exchange_activity.lua

module("logicconfig.config.t_yuanxiao_kings_exchange_activity", package.seeall)

local title = {
	activityId = 1,
	taskPlanId = 3,
	exchangePlan = 2,
	timeDesc = 4
}
local dataList = {
	{
		240001,
		1,
		1,
		"活动时间：2月3日-2月10日"
	},
	{
		240002,
		2,
		1,
		"活动时间：6月22日5:00-6月30日5:00"
	},
	{
		240003,
		3,
		2,
		"活动时间：2月23日5:00-3月1日5:00"
	},
	{
		240004,
		4,
		3,
		"活动时间：6月14日5:00-6月28日5:00"
	}
}
local t_yuanxiao_kings_exchange_activity = {
	[240001] = dataList[1],
	[240002] = dataList[2],
	[240003] = dataList[3],
	[240004] = dataList[4]
}

t_yuanxiao_kings_exchange_activity.dataList = dataList

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

return t_yuanxiao_kings_exchange_activity
