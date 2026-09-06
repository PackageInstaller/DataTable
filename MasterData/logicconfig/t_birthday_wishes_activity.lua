-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_birthday_wishes_activity.lua

module("logicconfig.config.t_birthday_wishes_activity", package.seeall)

local title = {
	wishlistPlanId = 8,
	dailyGiveReward = 7,
	timeShow = 12,
	dailyRewardNum = 6,
	tokenIds = 13,
	dailyPutOutTimes = 11,
	plotId = 2,
	wishListExpireTime = 10,
	wishesTextPlan = 3,
	wishListCD = 9,
	gotoStr = 14,
	costStr = 15,
	giftPlan = 4,
	activityId = 1,
	dailyGiveLimitNum = 5
}
local dataList = {
	{
		223001,
		4380002,
		1,
		1,
		10,
		1,
		"4:97012:1",
		0,
		0,
		0,
		0,
		"（大奖:时间王者·诺亚）第1期：11.25 5:00-12.02 5:00\r\n（大奖:造化之神·弥娅）第2期：12.09 5:00-12.16 5:00",
		{
			1,
			2,
			3
		},
		"",
		""
	},
	{
		223002,
		4380002,
		1,
		2,
		10,
		1,
		"4:97013:1",
		0,
		0,
		0,
		0,
		"（大奖:时间王者·诺亚）第1期：11.25 5:00-12.02 5:00\r\n（大奖:造化之神·弥娅）第2期：12.09 5:00-12.16 5:00",
		{
			4,
			5,
			6
		},
		"",
		""
	},
	{
		223003,
		4380002,
		2,
		3,
		5,
		1,
		"4:97013:1",
		1,
		60,
		1440,
		5,
		"活动时间：1月20日 5:00 - 2月10日 5:00",
		{
			7,
			8,
			9,
			10,
			11
		},
		"",
		""
	},
	{
		223004,
		4380002,
		2,
		4,
		10,
		1,
		"4:97013:1",
		2,
		1,
		1440,
		10,
		"活动时间：6月9日 5:00 - 6月23日 5:00",
		{
			12,
			13,
			14,
			15,
			16
		},
		"",
		""
	},
	{
		223005,
		4380002,
		2,
		5,
		10,
		1,
		"4:97013:1",
		3,
		1,
		1440,
		10,
		"活动时间：9月22日 5:00 - 9月28日 5:00",
		{
			17,
			18,
			19,
			20,
			21
		},
		"",
		""
	},
	{
		223006,
		4380002,
		2,
		6,
		10,
		1,
		"4:97013:1",
		4,
		1,
		1440,
		10,
		"活动时间：11月10日 5:00 - 11月24日 5:00",
		{
			22,
			23,
			24,
			25,
			26
		},
		"",
		""
	},
	{
		223007,
		4380002,
		3,
		7,
		10,
		1,
		"10:223027:1#10:223028:1#10:223029:1",
		0,
		0,
		0,
		0,
		"活动时间：5月17日 5:00 - 5月31日 5:00",
		{
			27,
			28,
			29
		},
		"",
		""
	},
	{
		223008,
		0,
		4,
		7,
		5,
		1,
		"10:223046:1",
		5,
		1,
		1440,
		3,
		"活动时间：5月17日 5:00 - 5月31日 5:00",
		{
			33,
			34,
			35,
			36,
			37,
			38,
			39,
			40,
			41,
			42,
			43,
			44,
			45,
			46,
			47,
			48
		},
		"func#1155",
		"10:223046:1"
	},
	{
		223009,
		4760005,
		2,
		8,
		10,
		1,
		"4:97013:1",
		6,
		1,
		1440,
		10,
		"活动时间：1月24日 5:00 - 2月28日 5:00",
		{
			49,
			50,
			51,
			52,
			53
		},
		"func#794",
		""
	},
	{
		223010,
		0,
		5,
		9,
		10,
		1,
		"4:97013:1",
		7,
		1,
		1440,
		10,
		"活动时间：8月29日 5:00 - 9月26日 5:00",
		{
			54,
			55,
			56,
			57,
			58
		},
		"func#794",
		""
	}
}
local t_birthday_wishes_activity = {
	[223001] = dataList[1],
	[223002] = dataList[2],
	[223003] = dataList[3],
	[223004] = dataList[4],
	[223005] = dataList[5],
	[223006] = dataList[6],
	[223007] = dataList[7],
	[223008] = dataList[8],
	[223009] = dataList[9],
	[223010] = dataList[10]
}

t_birthday_wishes_activity.dataList = dataList

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

return t_birthday_wishes_activity
