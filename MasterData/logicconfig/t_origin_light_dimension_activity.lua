-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_light_dimension_activity.lua

module("logicconfig.config.t_origin_light_dimension_activity", package.seeall)

local title = {
	extremeClgPrize = 2,
	jumpToRank = 9,
	jumpToFirstRank = 8,
	normalClgPrize = 3,
	normalClgDailyCount = 5,
	normalClgCountStorage = 4,
	jumpToPrize = 10,
	jumpToPassport = 12,
	jumpToShop = 11,
	buffActivateCount = 6,
	raceId = 7,
	activityId = 1
}
local dataList = {
	{
		610001,
		"4:510826:100",
		"4:510826:100",
		3,
		1,
		3,
		14045,
		"event#gotofirstpassrankview#610001",
		"func#618#14045",
		"mibao#jinglingyangcheng",
		"ui#lottery",
		"func#545#25"
	}
}
local t_origin_light_dimension_activity = {
	[610001] = dataList[1]
}

t_origin_light_dimension_activity.dataList = dataList

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

return t_origin_light_dimension_activity
