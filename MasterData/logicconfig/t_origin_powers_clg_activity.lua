-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_powers_clg_activity.lua

module("logicconfig.config.t_origin_powers_clg_activity", package.seeall)

local title = {
	jumpToPrize = 6,
	jumpToRank = 5,
	jumpToFirstRank = 4,
	jumpToShop = 7,
	raceId = 3,
	activityId = 1,
	extremePrize = 2
}
local dataList = {
	{
		576001,
		"4:510746:100",
		17028,
		"event#gotofirstpassrankview#576001",
		"func#618#17028",
		"func#1181",
		"ui#lottery"
	}
}
local t_origin_powers_clg_activity = {
	[576001] = dataList[1]
}

t_origin_powers_clg_activity.dataList = dataList

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

return t_origin_powers_clg_activity
