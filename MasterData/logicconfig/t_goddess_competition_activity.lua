-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_competition_activity.lua

module("logicconfig.config.t_goddess_competition_activity", package.seeall)

local title = {
	singleGoddessRankCount = 8,
	normalFanPopularityRate = 5,
	stepPopularityRank = 10,
	gainRedPackNeedPopularity = 11,
	redPointId = 13,
	exchangeItem = 4,
	voteItem = 3,
	superFanCount = 7,
	jumpShopStr = 12,
	activityPopularityRank = 9,
	superFanPopularityRate = 6,
	saveRecordCount = 2,
	activityId = 1
}
local dataList = {
	{
		453001,
		20,
		"10:453001",
		"10:453002:1",
		1,
		100,
		5,
		1000,
		5000,
		2000,
		1000,
		"func#191#453#453001",
		769
	},
	{
		453002,
		20,
		"10:453003",
		"10:453004:1",
		1,
		1,
		0,
		0,
		5000,
		2000,
		1000,
		"func#191#453#453002",
		769
	}
}
local t_goddess_competition_activity = {
	[453001] = dataList[1],
	[453002] = dataList[2]
}

t_goddess_competition_activity.dataList = dataList

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

return t_goddess_competition_activity
