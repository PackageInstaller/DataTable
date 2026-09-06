-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_zhong_fei_clg_activity.lua

module("logicconfig.config.t_divine_zhong_fei_clg_activity", package.seeall)

local title = {
	jumpToPrize = 10,
	jumpToRank = 9,
	jumpToFirstRank = 8,
	extremeBuffId = 4,
	raceId = 6,
	jumpToCard = 12,
	jumpToShop = 11,
	showRaceId = 7,
	redPointId = 2,
	creepsMasterId = 5,
	activityId = 1,
	extremePrize = 3
}
local dataList = {
	{
		515001,
		728,
		"4:510580:100",
		20066431,
		1007,
		12038,
		12020,
		"event#gotofirstpassrankview#515001",
		"func#618#12038",
		"mibao#MibaoShop",
		"ui#lottery",
		"func#43#139"
	}
}
local t_divine_zhong_fei_clg_activity = {
	[515001] = dataList[1]
}

t_divine_zhong_fei_clg_activity.dataList = dataList

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

return t_divine_zhong_fei_clg_activity
