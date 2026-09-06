-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_bounty_pk_common.lua

module("logicconfig.config.t_bounty_pk_common", package.seeall)

local title = {
	value = 2,
	key = 1,
	value2 = 3
}
local dataList = {
	{
		"OPEN_TIME",
		"09:00:00#23:30:00",
		0
	},
	{
		"BEFORE_MATCH_TIME",
		"2",
		0
	},
	{
		"MATCH_TIME",
		"30",
		0
	},
	{
		"READY_TIME",
		"5",
		0
	},
	{
		"LOSE_STREAK_TRIGGER",
		"3",
		0
	},
	{
		"SHOP_ACTIVITYTYPE",
		"204",
		0
	},
	{
		"SHOP_ACTIVITYID",
		"204013",
		0
	},
	{
		"OPEN_TIME_TIPS",
		"开放时间：每天 09:00-23:30",
		82053988
	},
	{
		"DAILY_TIME_LIMIT",
		"0",
		0
	},
	{
		"DAILY_LOGIN_PRIZE",
		"1500",
		0
	},
	{
		"DAILY_LOGIN_PRIZE_DESC",
		"每日登录可领取1500赏金",
		82053989
	},
	{
		"SET_FORM_ALL_READY_QUICK_END",
		"TRUE",
		0
	},
	{
		"CARD_POOL_CIRT_ID",
		"3",
		0
	},
	{
		"INIT_SCORE",
		"3000",
		0
	},
	{
		"BOUNTY_ITEM_ID",
		"1215",
		0
	},
	{
		"POST_RACEID",
		"10354",
		0
	},
	{
		"RANK_TIPS",
		"1、以活动时间内历史最高赏金进行排名\r\n2、活动结束后，将根据排行发放对应奖励",
		82053990
	},
	{
		"SHOW_ITEM",
		"10:204013",
		0
	}
}
local t_bounty_pk_common = {
	OPEN_TIME = dataList[1],
	BEFORE_MATCH_TIME = dataList[2],
	MATCH_TIME = dataList[3],
	READY_TIME = dataList[4],
	LOSE_STREAK_TRIGGER = dataList[5],
	SHOP_ACTIVITYTYPE = dataList[6],
	SHOP_ACTIVITYID = dataList[7],
	OPEN_TIME_TIPS = dataList[8],
	DAILY_TIME_LIMIT = dataList[9],
	DAILY_LOGIN_PRIZE = dataList[10],
	DAILY_LOGIN_PRIZE_DESC = dataList[11],
	SET_FORM_ALL_READY_QUICK_END = dataList[12],
	CARD_POOL_CIRT_ID = dataList[13],
	INIT_SCORE = dataList[14],
	BOUNTY_ITEM_ID = dataList[15],
	POST_RACEID = dataList[16],
	RANK_TIPS = dataList[17],
	SHOW_ITEM = dataList[18]
}

t_bounty_pk_common.dataList = dataList

local multiLanguageCells = {
	value2 = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_bounty_pk_common
