-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_respect_challenge_fusion_common.lua

module("logicconfig.config.t_dragon_respect_challenge_fusion_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"EXTREME_PASS_REFRESH",
		"10:00:00"
	},
	{
		"EXTREME_PASS_LIMIT",
		"500"
	},
	{
		"FUSION_BIG_PRIZE_LIMIT",
		"3"
	},
	{
		"EXTREME_CHALLENGE_OPEN_TIME",
		"2025-03-17 05:00:00#2038-12-31 05:00:00"
	},
	{
		"UNIVERSAL_CHALLENGE_OPEN_TIME",
		"2025-03-17 05:00:00#2038-12-31 05:00:01"
	},
	{
		"EXTREME_CHALLENGE_BUFF",
		""
	},
	{
		"UNIVERSAL_CHALLENGE_BUFF",
		""
	},
	{
		"SHOW_RANK_NUM",
		"100"
	},
	{
		"FUSION_DAILY_TIMES",
		"1"
	},
	{
		"SHOW_PET_ID",
		"17002"
	},
	{
		"OPEN_ANIMATION",
		""
	},
	{
		"LIMIT_TIPS_TEXT",
		"极限挑战今日已达到数量上限了，请明天再来吧"
	},
	{
		"LIMIT_NUM_TEXT",
		"今日获得:%s/%s"
	},
	{
		"FIGHT_FAIL_TEXT",
		"本次挑战失败，是否重新选择难度挑战或者直接进行结算"
	},
	{
		"EXTREME_CHALLENGE",
		"挑战获得龙尊"
	},
	{
		"UNIVERSAL_CHALLENGE",
		"概率获得龙尊"
	},
	{
		"EXTREME_CHALLENGE_TEXT",
		"每日前500名通关极限挑战的玩家可直接获得神爵·龙尊圣主"
	},
	{
		"EXTREME_CHALLENGE_BUFF_TEXT",
		"在极限挑战中，上阵生命女神·盖西瑞，全阵生命上限+20%"
	},
	{
		"UNIVERSAL_CHALLENGE_BUFF_TEXT",
		"在全民挑战中，上阵生命女神·盖西瑞，全阵生命上限+20%"
	},
	{
		"EXTREME_CHALLENGE_PET_ID",
		"13006"
	},
	{
		"UNIVERSAL_CHALLENGE_PET_ID",
		"13006"
	},
	{
		"CHALLENGE_SCORE_ID",
		"194001"
	},
	{
		"ONCLICK_GROW_SPEED",
		"1.2"
	},
	{
		"ONCLICK_MAX_NUM",
		"8"
	},
	{
		"BALLVIEW_WAIT_TIME",
		"8"
	},
	{
		"ONCLICK_BALL_TPIS_TEXT",
		"点击屏幕使光球膨胀变大"
	},
	{
		"SHOW_BUFF_NUM",
		"3"
	},
	{
		"RANK_FUNC",
		"func#618#17002"
	},
	{
		"SHOP_FUNC",
		"mibao#Skin"
	}
}
local t_dragon_respect_challenge_fusion_common = {
	EXTREME_PASS_REFRESH = dataList[1],
	EXTREME_PASS_LIMIT = dataList[2],
	FUSION_BIG_PRIZE_LIMIT = dataList[3],
	EXTREME_CHALLENGE_OPEN_TIME = dataList[4],
	UNIVERSAL_CHALLENGE_OPEN_TIME = dataList[5],
	EXTREME_CHALLENGE_BUFF = dataList[6],
	UNIVERSAL_CHALLENGE_BUFF = dataList[7],
	SHOW_RANK_NUM = dataList[8],
	FUSION_DAILY_TIMES = dataList[9],
	SHOW_PET_ID = dataList[10],
	OPEN_ANIMATION = dataList[11],
	LIMIT_TIPS_TEXT = dataList[12],
	LIMIT_NUM_TEXT = dataList[13],
	FIGHT_FAIL_TEXT = dataList[14],
	EXTREME_CHALLENGE = dataList[15],
	UNIVERSAL_CHALLENGE = dataList[16],
	EXTREME_CHALLENGE_TEXT = dataList[17],
	EXTREME_CHALLENGE_BUFF_TEXT = dataList[18],
	UNIVERSAL_CHALLENGE_BUFF_TEXT = dataList[19],
	EXTREME_CHALLENGE_PET_ID = dataList[20],
	UNIVERSAL_CHALLENGE_PET_ID = dataList[21],
	CHALLENGE_SCORE_ID = dataList[22],
	ONCLICK_GROW_SPEED = dataList[23],
	ONCLICK_MAX_NUM = dataList[24],
	BALLVIEW_WAIT_TIME = dataList[25],
	ONCLICK_BALL_TPIS_TEXT = dataList[26],
	SHOW_BUFF_NUM = dataList[27],
	RANK_FUNC = dataList[28],
	SHOP_FUNC = dataList[29]
}

t_dragon_respect_challenge_fusion_common.dataList = dataList

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

return t_dragon_respect_challenge_fusion_common
