-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_activity_tab.lua

module("logic.config.t_activity_tab", package.seeall)

local title = {
	tabIcon = 8,
	priority = 5,
	name = 3,
	type = 2,
	preform = 14,
	keepTime = 10,
	bgRes = 7,
	isDisappear = 11,
	tipsId = 9,
	isTaskActivity = 12,
	program = 13,
	systemId = 6,
	id = 1,
	planIds = 4,
	rewards = 15
}
local dataList = {
	{
		0,
		0,
		"日常签到",
		{
			1
		},
		999,
		23001,
		"bg2_dl",
		"",
		0,
		0,
		false,
		false,
		"DailySigninFragmentView",
		"ui/views/wekfare/daily_signin/daily_signin_panel1.prefab"
	},
	{
		20001,
		2,
		"时分交汇",
		{
			20001
		},
		20,
		23002,
		"bg2_dl",
		"hd_icon_0004",
		0,
		0,
		true,
		false,
		"SevenSigninFragmentView",
		"ui/views/wekfare/seven_day_signin/seven_signin_panel1.prefab"
	},
	{
		70001,
		7,
		"时讯积分",
		{
			70001
		},
		24,
		0,
		"bg2_dl",
		"hd_icon_0001",
		7002,
		0,
		true,
		false,
		"ActivityIntegralDropView",
		"ui/views/wekfare/integral_drop/activity_integral_drop_panel.prefab"
	},
	{
		60000,
		6,
		"试用期特派",
		{
			60057,
			60051
		},
		19,
		0,
		"bg2_dl",
		"hd_icon_0002",
		7117,
		0,
		false,
		false,
		"RoleExperienceView",
		"ui/views/wekfare/role_experience/activity_role_experience_panel.prefab"
	},
	{
		80001,
		8,
		"300-SC99",
		{
			80001
		},
		25,
		0,
		"bg2_dl",
		"hd_icon_0003",
		7003,
		0,
		false,
		false,
		"ClawDollActivityView",
		"ui/views/wekfare/prize_claw/activity_prize_claw_panel.prefab"
	},
	{
		100001,
		10,
		"星之问候",
		{
			100001
		},
		21,
		23004,
		"bg2_dl",
		"hd_icon_xzwh",
		0,
		0,
		true,
		true,
		"ChapterRewardView",
		"ui/views/wekfare/chapter_rewards/chapter_rewards_view.prefab"
	},
	{
		100002,
		10,
		"职级奖励",
		{
			100002
		},
		21,
		23004,
		"bg2_dl",
		"hd_icon_zzjl",
		0,
		0,
		true,
		true,
		"LevelRewardView",
		"ui/views/wekfare/level_rewards/level_rewards_view.prefab"
	},
	{
		110001,
		11,
		"安妮薇的赠礼",
		{
			110001
		},
		22,
		23005,
		"bg2_dl",
		"hd_icon_anwdzl",
		7115,
		0,
		false,
		false,
		"WeekendSupplyView",
		"ui/views/wekfare/weekend_supply/weekend_supply_panel.prefab"
	},
	{
		120001,
		12,
		"异能挑战",
		{
			120001
		},
		23,
		23006,
		"bg2_dl",
		"hd_icon_yntz",
		1006,
		0,
		false,
		false,
		"PowerChallengePanel",
		"ui/views/wekfare/power_challenge/power_challenge_panel.prefab",
		{
			1100002,
			1003004,
			1100003
		}
	},
	{
		90000,
		9,
		"掉落提升",
		{
			90001,
			90002,
			90003,
			90004
		},
		23,
		23003,
		"bg2_dl",
		"hd_icon_dlts",
		7004,
		0,
		false,
		false,
		"MultipleDropView",
		"ui/views/wekfare/replica_rewards/replica_rewards_panel.prefab"
	},
	{
		130001,
		13,
		"关注有礼",
		{
			130001
		},
		24,
		0,
		"bg2_dl",
		"hd_icon_gzyl",
		0,
		0,
		false,
		false,
		"SubscribleGiftsView",
		"ui/views/wekfare/attention_gift/attention_gift_panel.prefab"
	}
}
local t_activity_tab = {}

t_activity_tab.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_activity_tab[v[1]] = v

	setmetatable(v, mt)
end

return t_activity_tab
