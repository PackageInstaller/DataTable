-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ranking_match_common.lua

module("logicconfig.config.t_ranking_match_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"SEASON_START_TIME",
		"2021-4-1"
	},
	{
		"CLASSIC_OPEN_TIME",
		"1:2:3:4:5:6:7"
	},
	{
		"EXTREME_OPEN_TIME",
		"1:2:3:4:5:6:7"
	},
	{
		"OPEN_TIME",
		"1:23"
	},
	{
		"DOUBLE_TIME",
		"18:20"
	},
	{
		"CHALLENGE_REWARD_CEILING",
		"300"
	},
	{
		"WIN_REWARD",
		"8:3:50"
	},
	{
		"LOSE_REWARD",
		"8:3:10"
	},
	{
		"DRAW_REWARD",
		"8:3:20"
	},
	{
		"INIT_SCORE",
		"1200"
	},
	{
		"INIT_SCORE_K",
		"32"
	},
	{
		"WIN_ADD_STAR",
		"1"
	},
	{
		"LOSE_DECR_STAR",
		"1"
	},
	{
		"WINS_N_TO_ADD_STAR",
		"3"
	},
	{
		"WINS_N_ADD_STAR_COUNT",
		"2"
	},
	{
		"BATTLE_RECORD_SAVE_COUNT",
		"10"
	},
	{
		"RESET_SEASON_DEC_STAR",
		"24"
	},
	{
		"RESET_SEASON_MIN_STAR",
		"13"
	},
	{
		"DEFAULT_STAR",
		"13"
	},
	{
		"READY_TIME",
		"90"
	},
	{
		"MATCH_TIME",
		"30"
	},
	{
		"MATCH_BOT_TIME",
		"3:7"
	},
	{
		"ROBOT_RECOMMEND_ZDL",
		"1000,2000,3000,4000,5000"
	},
	{
		"BB_MATCH_BOT_PERCENT",
		"20"
	},
	{
		"INIT_LEGEND_RANK_SCORE",
		"1000"
	},
	{
		"BAN_RACE_COUNT",
		"5"
	},
	{
		"ADVANCE_VOTE_END_HOURS",
		"5"
	},
	{
		"BAN_PET_RULE_KEY",
		"RULEKEY_BANPETTIPS"
	},
	{
		"CAN_BAN_VOTE_LEVEL",
		"29"
	},
	{
		"OFTEN_MATCH_THRESHOLD",
		"10"
	},
	{
		"EXTREME_BUFF",
		"30000095:99"
	}
}
local t_ranking_match_common = {
	SEASON_START_TIME = dataList[1],
	CLASSIC_OPEN_TIME = dataList[2],
	EXTREME_OPEN_TIME = dataList[3],
	OPEN_TIME = dataList[4],
	DOUBLE_TIME = dataList[5],
	CHALLENGE_REWARD_CEILING = dataList[6],
	WIN_REWARD = dataList[7],
	LOSE_REWARD = dataList[8],
	DRAW_REWARD = dataList[9],
	INIT_SCORE = dataList[10],
	INIT_SCORE_K = dataList[11],
	WIN_ADD_STAR = dataList[12],
	LOSE_DECR_STAR = dataList[13],
	WINS_N_TO_ADD_STAR = dataList[14],
	WINS_N_ADD_STAR_COUNT = dataList[15],
	BATTLE_RECORD_SAVE_COUNT = dataList[16],
	RESET_SEASON_DEC_STAR = dataList[17],
	RESET_SEASON_MIN_STAR = dataList[18],
	DEFAULT_STAR = dataList[19],
	READY_TIME = dataList[20],
	MATCH_TIME = dataList[21],
	MATCH_BOT_TIME = dataList[22],
	ROBOT_RECOMMEND_ZDL = dataList[23],
	BB_MATCH_BOT_PERCENT = dataList[24],
	INIT_LEGEND_RANK_SCORE = dataList[25],
	BAN_RACE_COUNT = dataList[26],
	ADVANCE_VOTE_END_HOURS = dataList[27],
	BAN_PET_RULE_KEY = dataList[28],
	CAN_BAN_VOTE_LEVEL = dataList[29],
	OFTEN_MATCH_THRESHOLD = dataList[30],
	EXTREME_BUFF = dataList[31]
}

t_ranking_match_common.dataList = dataList

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

return t_ranking_match_common
