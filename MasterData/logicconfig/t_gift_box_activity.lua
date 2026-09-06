-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_gift_box_activity.lua

module("logicconfig.config.t_gift_box_activity", package.seeall)

local title = {
	msgTemplateId = 9,
	scoreMaxLimit = 2,
	shareCd = 4,
	skinId = 10,
	showNum = 6,
	shareNumLimit = 5,
	shareNeedCount = 8,
	dailyTimes = 3,
	activityId = 1,
	superBoxType = 7
}
local dataList = {
	{
		318001,
		100,
		3,
		60,
		10,
		100,
		1,
		1,
		68,
		1401805
	}
}
local t_gift_box_activity = {
	[318001] = dataList[1]
}

t_gift_box_activity.dataList = dataList

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

return t_gift_box_activity
