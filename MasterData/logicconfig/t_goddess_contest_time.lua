-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_contest_time.lua

module("logicconfig.config.t_goddess_contest_time", package.seeall)

local title = {
	value = 3,
	timePlanId = 1,
	key = 2
}
local dataList = {
	{
		1,
		"GODDESS_VOTE_TIME",
		"2023-03-03 05:00:00#2023-03-26 19:00:00"
	},
	{
		1,
		"GODDESS_SHOW_TIME",
		"2023-03-26 19:00:00#2023-03-31 05:00:00"
	},
	{
		1,
		"MANUAL_JOIN_GROUP_TIME",
		"2023-03-03 05:00:00#2023-03-10 05:00:00"
	},
	{
		1,
		"RANDOM_JOIN_GROUP_TIME",
		"2023-03-10 05:00:00#2023-03-26 19:00:00"
	},
	{
		1,
		"CAMPAIGN_APPLY_TIME",
		"2023-03-03 05:00:00#2023-03-17 05:00:00"
	},
	{
		1,
		"CAMPAIGN_VOTE_TIME",
		"2023-03-10 05:00:00#2023-03-19 19:00:00"
	},
	{
		2,
		"GODDESS_VOTE_TIME",
		"2024-03-01 05:00:00#2024-03-24 19:00:00"
	},
	{
		2,
		"GODDESS_SHOW_TIME",
		"2024-03-24 19:00:00#2024-03-29 05:00:00"
	},
	{
		2,
		"MANUAL_JOIN_GROUP_TIME",
		"2024-03-01 05:00:00#2024-03-08 05:00:00"
	},
	{
		2,
		"RANDOM_JOIN_GROUP_TIME",
		"2024-03-08 05:00:00#2024-03-24 19:00:00"
	},
	{
		2,
		"CAMPAIGN_APPLY_TIME",
		"2024-03-01 05:00:00#2024-03-15 05:00:00"
	},
	{
		2,
		"CAMPAIGN_VOTE_TIME",
		"2024-03-08 05:00:00#2024-03-17 19:00:00"
	}
}
local t_goddess_contest_time = {
	{
		GODDESS_VOTE_TIME = dataList[1],
		GODDESS_SHOW_TIME = dataList[2],
		MANUAL_JOIN_GROUP_TIME = dataList[3],
		RANDOM_JOIN_GROUP_TIME = dataList[4],
		CAMPAIGN_APPLY_TIME = dataList[5],
		CAMPAIGN_VOTE_TIME = dataList[6]
	},
	{
		GODDESS_VOTE_TIME = dataList[7],
		GODDESS_SHOW_TIME = dataList[8],
		MANUAL_JOIN_GROUP_TIME = dataList[9],
		RANDOM_JOIN_GROUP_TIME = dataList[10],
		CAMPAIGN_APPLY_TIME = dataList[11],
		CAMPAIGN_VOTE_TIME = dataList[12]
	}
}

t_goddess_contest_time.dataList = dataList

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

return t_goddess_contest_time
