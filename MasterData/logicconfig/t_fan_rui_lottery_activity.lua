-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fan_rui_lottery_activity.lua

module("logicconfig.config.t_fan_rui_lottery_activity", package.seeall)

local title = {
	chapterId = 4,
	lotteryCost = 2,
	exchangeCost = 5,
	storyId = 8,
	jumpTo = 9,
	buyCd = 7,
	redPointId = 3,
	exchangePrize = 6,
	actId = 1
}
local dataList = {
	{
		299001,
		"10:299001:300",
		508,
		4530001,
		"10:299001:50",
		"10:299002:1",
		360,
		4530001,
		{
			"func#931",
			"ui#passporttaskcommonview#245002#1"
		}
	}
}
local t_fan_rui_lottery_activity = {
	[299001] = dataList[1]
}

t_fan_rui_lottery_activity.dataList = dataList

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

return t_fan_rui_lottery_activity
