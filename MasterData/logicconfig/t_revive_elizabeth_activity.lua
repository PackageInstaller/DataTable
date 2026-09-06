-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_revive_elizabeth_activity.lua

module("logicconfig.config.t_revive_elizabeth_activity", package.seeall)

local title = {
	fieldWeedMaxTimes = 7,
	fieldWaterMaxTimes = 5,
	waterAddProgress = 6,
	flowerMaxProgress = 9,
	dailyWeedTimes = 11,
	prizeRedPointId = 12,
	seedingMp = 3,
	fieldCount = 2,
	seedRedPointId = 13,
	storyId = 14,
	weedAddProgress = 8,
	dailyWaterTimes = 10,
	activityId = 1,
	seedAddProgress = 4
}
local dataList = {
	{
		416001,
		9,
		"10:416001:5",
		100,
		2,
		200,
		2,
		300,
		30000,
		3,
		3,
		619,
		620,
		4720001
	}
}
local t_revive_elizabeth_activity = {
	[416001] = dataList[1]
}

t_revive_elizabeth_activity.dataList = dataList

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

return t_revive_elizabeth_activity
