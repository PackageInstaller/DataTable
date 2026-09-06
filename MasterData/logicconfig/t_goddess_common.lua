-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_common.lua

module("logicconfig.config.t_goddess_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"TOUCH_TIMES",
		"3"
	},
	{
		"FLOWER_FEELING_LIMIT",
		"50"
	},
	{
		"FLOWER_PRIZE_NUMBER_LIMIT",
		"8:1:5000"
	},
	{
		"CHAT_TIMES",
		"3"
	},
	{
		"BALLOON_TIMES",
		"3"
	},
	{
		"TALK_CD",
		"30"
	},
	{
		"GAME_TIME",
		"15"
	},
	{
		"BALL_ADD_VOLUMN_PER_CLICK",
		"3.8:100"
	},
	{
		"BALL_MAX_VOLUMN",
		"100"
	},
	{
		"BALL_SUB_VOLUMN_PER_SEC",
		"2.5:100"
	},
	{
		"CLICK_DURATION",
		"0.3"
	},
	{
		"REVIVE_COST",
		"105:178:30"
	},
	{
		"BALL_DOTTED_LINE_VOLUMN",
		"92"
	},
	{
		"BALL_RESURRECTION_TIMES",
		"1"
	},
	{
		"RANK_TIP",
		"活动结束时，根据排行榜名次结算对应奖励。"
	},
	{
		"GAME_RULE_TIP",
		"点击开始后小游戏开始倒计时。快速点击吹气球，吹的越大获得<color=#eb4642>爱心越多</color>。吹太大，气球会爆炸！爱心将会为0哦！"
	}
}
local t_goddess_common = {
	TOUCH_TIMES = dataList[1],
	FLOWER_FEELING_LIMIT = dataList[2],
	FLOWER_PRIZE_NUMBER_LIMIT = dataList[3],
	CHAT_TIMES = dataList[4],
	BALLOON_TIMES = dataList[5],
	TALK_CD = dataList[6],
	GAME_TIME = dataList[7],
	BALL_ADD_VOLUMN_PER_CLICK = dataList[8],
	BALL_MAX_VOLUMN = dataList[9],
	BALL_SUB_VOLUMN_PER_SEC = dataList[10],
	CLICK_DURATION = dataList[11],
	REVIVE_COST = dataList[12],
	BALL_DOTTED_LINE_VOLUMN = dataList[13],
	BALL_RESURRECTION_TIMES = dataList[14],
	RANK_TIP = dataList[15],
	GAME_RULE_TIP = dataList[16]
}

t_goddess_common.dataList = dataList

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

return t_goddess_common
