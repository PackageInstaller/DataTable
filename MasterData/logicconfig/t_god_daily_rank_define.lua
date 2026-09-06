-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_god_daily_rank_define.lua

module("logicconfig.config.t_god_daily_rank_define", package.seeall)

local title = {
	activityType = 2,
	minScore2SubmitGodRank = 4,
	godRankLimit = 6,
	dailyRankStartTime = 9,
	dailyRankEndTime = 10,
	minScore2SubmitDailyRank = 5,
	txtTipsDaily = 13,
	txtTipsGod = 12,
	limitPlanId = 8,
	rankPrize = 11,
	challengeClosedTimeRange = 3,
	activityId = 1,
	specificGodRankId = 7
}
local dataList = {
	{
		568001,
		568,
		"02:00:00-09:00:00",
		2700,
		0,
		1000,
		0,
		1,
		"2026-03-13T05:00:00",
		"2026-03-27T05:00:00",
		"4:510722:100",
		"大神榜门槛：2700积分，上榜后即刻发放奖励",
		"每日榜上榜后次日发放奖励"
	},
	{
		578001,
		578,
		"02:00:00-09:00:00",
		4200000,
		0,
		1000,
		0,
		2,
		"2026-04-10T05:00:00",
		"2026-04-24T05:00:00",
		"100:17027:1:1",
		"大神榜门槛：4200000积分，上榜后即刻发放奖励",
		"每日榜上榜后次日发放奖励"
	},
	{
		573001,
		573,
		"02:00:00-09:00:00",
		75000,
		0,
		1000,
		362,
		3,
		"2025-04-10T05:00:00",
		"2025-04-24T05:00:00",
		"4:510747:100",
		"大神榜门槛：75000积分，上榜后即刻发放奖励\r\n2026.4.17-2026.4.30期间积分≥80000自动移到周年大神榜",
		"每日榜上榜后次日发放奖励"
	}
}
local t_god_daily_rank_define = {
	[568001] = dataList[1],
	[578001] = dataList[2],
	[573001] = dataList[3]
}

t_god_daily_rank_define.dataList = dataList

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

return t_god_daily_rank_define
