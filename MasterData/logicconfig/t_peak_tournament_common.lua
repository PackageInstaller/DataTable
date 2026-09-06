-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_peak_tournament_common.lua

module("logicconfig.config.t_peak_tournament_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"ORIGINAL_RANK_SCORE",
		"0"
	},
	{
		"INIT_MATCH_SCORE",
		"5"
	},
	{
		"QUALIFIER_RANK_SHOW_COUNT",
		"150"
	},
	{
		"QUALIFIER_RANK_REGISTER_COUNT",
		"500"
	},
	{
		"VOTE_MAT",
		"10:217096"
	},
	{
		"VOTE_WIN_RATIO",
		"3"
	},
	{
		"VOTE_LOSE_RATIO",
		"0.5"
	},
	{
		"PUSH_MATCHING_COUNT_IN_VOTE_PLATE",
		"4"
	},
	{
		"REWARD_DESCRIPTION_FRAMEID",
		"1"
	},
	{
		"ELIMINATOR_BASE_FRAMEID",
		"2"
	},
	{
		"PT_JUMP_SHOP_KEY",
		"func#191#217#217048"
	},
	{
		"PT_JUMP_REDPACKET_KEY",
		"func#594#1"
	},
	{
		"PT_QUA_RULE",
		"tournamentqualifier_rule"
	},
	{
		"PT_ELIMINATOR_RULE",
		"tournamenteliminato_rule"
	},
	{
		"PT_SHOW_RULE",
		"tournamentshow_rule"
	},
	{
		"PT_QUA_RANK_RULE",
		"tournamentqualifier_rank_rule"
	},
	{
		"LKEY_TABPTELIMYSCHEDULEVIEW_1",
		"TabPTEliMyScheduleView_1"
	},
	{
		"LKEY_TABPTELIVOTEPLATEMAINVIEW_1",
		"tabptelivoteplatemainview_1"
	},
	{
		"RULEKEY_BANPETTIPS",
		"tournamentraceban_rule"
	},
	{
		"PT_RED_REMAIN_TIMES",
		"406"
	},
	{
		"PT_RED_TASK_PRIZE",
		"407"
	},
	{
		"PT_RED_VOTE_GAIN",
		"378"
	},
	{
		"PT_RED_TOP_FIRST",
		"-306"
	},
	{
		"PT_RED_QUA_REWARD_ONCE",
		"-308"
	},
	{
		"PT_RED_DAILY_OPEN",
		"-313"
	},
	{
		"PT_FUNCID",
		"729"
	},
	{
		"PT_RED_DAILY_OPEN_TIME",
		"0-0-0 18:00:00#0-0-0 20:30:00"
	},
	{
		"BASE_SCORE",
		"100"
	},
	{
		"ONE_TIME_DECREASE_SCORE",
		"50"
	},
	{
		"DAILY_KUDOS_COUNT",
		"1"
	},
	{
		"TOTAL_KUDOS_COUNT",
		"1"
	},
	{
		"DAILY_GLOBAL_KUDOS_COUNT",
		"1"
	},
	{
		"TOTAL_GLOBAL_KUDOS_COUNT",
		"1"
	},
	{
		"BATTLE_CD",
		"5"
	},
	{
		"QUALIFIER_RANK_SHOW_TIME",
		"预选赛：7.24-7.31\n战区赛：7.31-8.2\n王者赛：8.8-8.9"
	}
}
local t_peak_tournament_common = {
	ORIGINAL_RANK_SCORE = dataList[1],
	INIT_MATCH_SCORE = dataList[2],
	QUALIFIER_RANK_SHOW_COUNT = dataList[3],
	QUALIFIER_RANK_REGISTER_COUNT = dataList[4],
	VOTE_MAT = dataList[5],
	VOTE_WIN_RATIO = dataList[6],
	VOTE_LOSE_RATIO = dataList[7],
	PUSH_MATCHING_COUNT_IN_VOTE_PLATE = dataList[8],
	REWARD_DESCRIPTION_FRAMEID = dataList[9],
	ELIMINATOR_BASE_FRAMEID = dataList[10],
	PT_JUMP_SHOP_KEY = dataList[11],
	PT_JUMP_REDPACKET_KEY = dataList[12],
	PT_QUA_RULE = dataList[13],
	PT_ELIMINATOR_RULE = dataList[14],
	PT_SHOW_RULE = dataList[15],
	PT_QUA_RANK_RULE = dataList[16],
	LKEY_TABPTELIMYSCHEDULEVIEW_1 = dataList[17],
	LKEY_TABPTELIVOTEPLATEMAINVIEW_1 = dataList[18],
	RULEKEY_BANPETTIPS = dataList[19],
	PT_RED_REMAIN_TIMES = dataList[20],
	PT_RED_TASK_PRIZE = dataList[21],
	PT_RED_VOTE_GAIN = dataList[22],
	PT_RED_TOP_FIRST = dataList[23],
	PT_RED_QUA_REWARD_ONCE = dataList[24],
	PT_RED_DAILY_OPEN = dataList[25],
	PT_FUNCID = dataList[26],
	PT_RED_DAILY_OPEN_TIME = dataList[27],
	BASE_SCORE = dataList[28],
	ONE_TIME_DECREASE_SCORE = dataList[29],
	DAILY_KUDOS_COUNT = dataList[30],
	TOTAL_KUDOS_COUNT = dataList[31],
	DAILY_GLOBAL_KUDOS_COUNT = dataList[32],
	TOTAL_GLOBAL_KUDOS_COUNT = dataList[33],
	BATTLE_CD = dataList[34],
	QUALIFIER_RANK_SHOW_TIME = dataList[35]
}

t_peak_tournament_common.dataList = dataList

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

return t_peak_tournament_common
