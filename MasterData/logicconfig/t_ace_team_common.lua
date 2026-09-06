-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ace_team_common.lua

module("logicconfig.config.t_ace_team_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"DAILY_START_TIME",
		"09:00:00"
	},
	{
		"DAILY_END_TIME",
		"02:00:00"
	},
	{
		"MATCH_WIN_SCORE",
		"800"
	},
	{
		"MATCH_WIN_MEDAL_NUM",
		"50"
	},
	{
		"MATCH_TIE_SCORE",
		"600"
	},
	{
		"MATCH_TIE_MEDAL_NUM",
		"30"
	},
	{
		"MATCH_LOSE_SCORE",
		"400"
	},
	{
		"MATCH_LOSE_MEDAL_NUM",
		"20"
	},
	{
		"DAILY_PVP_FREE_TIMES",
		"10"
	},
	{
		"DAILY_CHANGE_TEAM_TIMES",
		"1"
	},
	{
		"CHANGE_TEAM_COST",
		"105:191:100"
	},
	{
		"DAILY_TRIGGER_BOSS_TIMES",
		"3"
	},
	{
		"BUY_SCORE_COST",
		"105:192:20"
	},
	{
		"SCORE_PER_BUY",
		"200"
	},
	{
		"DAILY_BUY_SCORE_TIMES",
		"5"
	},
	{
		"REPLACE_STAR_GOD_NEED_SCORE",
		"50"
	},
	{
		"MAX_MATCH_TIME",
		"30"
	},
	{
		"NORMAL_MATCH_PLAN",
		"1"
	},
	{
		"LOSING_STREAK_TRIGGER",
		"3"
	},
	{
		"LOSING_STREAK_MATCH_PLAN",
		"2"
	},
	{
		"PRIZE_RULE_TITLE",
		"获得战队积分和荣耀勋章"
	},
	{
		"PRIZE_RULE_DESC",
		"1.参与全服匹配对战\n胜利可获得<color=#C54949>800</color>战队积分、<color=#C54949>50</color>荣耀勋章\n平局可获得<color=#C54949>600</color>战队积分、<color=#C54949>30</color>荣耀勋章\n失败可获得<color=#C54949>400</color>战队积分、<color=#C54949>20</color>荣耀勋章\n2. BOSS遭遇战\n每次匹配对战完，概率触发BOSS挑战，每日触发上限<color=#C54949>3次</color>（免费匹配次数用完，必定可触发满BOSS挑战）\n胜利可获得<color=#C54949>1000</color>战队积分和<color=#C54949>400</color>荣耀勋章\n失败可获得<color=#C54949>500</color>战队积分和<color=#C54949>200</color>荣耀勋章\n3.钻石购买战队积分 \n<color=#C54949>20钻石=200战队积分</color>，每日最多购买<color=#C54949>1000</color>战队积分\n战队积分用于培养战队精灵"
	},
	{
		"SHOP_ACTIVITYTYPE",
		"71"
	},
	{
		"SHOP_ACTIVITYID",
		"71041"
	},
	{
		"OPEN_TIME_TIPS",
		"开放时间：09:00-24:00，00:00-02:00"
	},
	{
		"SHOP_EXPLICIT_ID",
		"4:510491:2"
	},
	{
		"STAR_GOD_LIST",
		"401#402#403#404#405#406#407#408#409#410"
	},
	{
		"MAIN_TOP_ITEM",
		"10:71041"
	},
	{
		"CHANGE_HOLY_STRIPE_SUIT_COST",
		"10"
	}
}
local t_ace_team_common = {
	DAILY_START_TIME = dataList[1],
	DAILY_END_TIME = dataList[2],
	MATCH_WIN_SCORE = dataList[3],
	MATCH_WIN_MEDAL_NUM = dataList[4],
	MATCH_TIE_SCORE = dataList[5],
	MATCH_TIE_MEDAL_NUM = dataList[6],
	MATCH_LOSE_SCORE = dataList[7],
	MATCH_LOSE_MEDAL_NUM = dataList[8],
	DAILY_PVP_FREE_TIMES = dataList[9],
	DAILY_CHANGE_TEAM_TIMES = dataList[10],
	CHANGE_TEAM_COST = dataList[11],
	DAILY_TRIGGER_BOSS_TIMES = dataList[12],
	BUY_SCORE_COST = dataList[13],
	SCORE_PER_BUY = dataList[14],
	DAILY_BUY_SCORE_TIMES = dataList[15],
	REPLACE_STAR_GOD_NEED_SCORE = dataList[16],
	MAX_MATCH_TIME = dataList[17],
	NORMAL_MATCH_PLAN = dataList[18],
	LOSING_STREAK_TRIGGER = dataList[19],
	LOSING_STREAK_MATCH_PLAN = dataList[20],
	PRIZE_RULE_TITLE = dataList[21],
	PRIZE_RULE_DESC = dataList[22],
	SHOP_ACTIVITYTYPE = dataList[23],
	SHOP_ACTIVITYID = dataList[24],
	OPEN_TIME_TIPS = dataList[25],
	SHOP_EXPLICIT_ID = dataList[26],
	STAR_GOD_LIST = dataList[27],
	MAIN_TOP_ITEM = dataList[28],
	CHANGE_HOLY_STRIPE_SUIT_COST = dataList[29]
}

t_ace_team_common.dataList = dataList

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

return t_ace_team_common
