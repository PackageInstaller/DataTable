-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_kaya_activity.lua

module("logicconfig.config.t_origin_kaya_activity", package.seeall)

local title = {
	jumpToPrize = 6,
	jumpToRank = 5,
	jumpToFirstRank = 4,
	jumpToShop = 7,
	raceId = 3,
	activityId = 1,
	stageMaxUseSeed = 2
}
local dataList = {
	{
		548001,
		2,
		13029,
		"event#gotofirstpassrankview#548001",
		"func#618#13029",
		"mibao#jinglingyangcheng",
		"ui#lottery"
	}
}
local t_origin_kaya_activity = {
	[548001] = dataList[1]
}

t_origin_kaya_activity.dataList = dataList

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

return t_origin_kaya_activity
