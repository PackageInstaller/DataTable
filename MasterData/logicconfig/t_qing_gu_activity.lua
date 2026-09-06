-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_qing_gu_activity.lua

module("logicconfig.config.t_qing_gu_activity", package.seeall)

local title = {
	packName = 2,
	fakeCost = 4,
	costItem = 3,
	basePrize = 6,
	passSaleAwardTime = 5,
	activityId = 1
}
local dataList = {
	{
		202001,
		"青骨特惠四重礼",
		"204:114:960",
		"204:114:1920",
		"2022-10-21T05:00:00",
		"4:149:160"
	}
}
local t_qing_gu_activity = {
	[202001] = dataList[1]
}

t_qing_gu_activity.dataList = dataList

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

return t_qing_gu_activity
