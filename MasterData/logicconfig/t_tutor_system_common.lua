-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tutor_system_common.lua

module("logicconfig.config.t_tutor_system_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"TEACHER_ZDL_LIMIT",
		"800001"
	},
	{
		"STUDENT_ZDL_LIMIT",
		"800000"
	},
	{
		"STUDENT_RECOMMEND_OPEN_ID",
		"623"
	},
	{
		"TEACH_STUDENT_LIMIT",
		"2"
	},
	{
		"TEACHER_REQUEST_NUM",
		"5"
	},
	{
		"STUDENT_REQUEST_NUM",
		"5"
	},
	{
		"RELIEVE_CD",
		"12"
	},
	{
		"AUTO_RELIEVE_DAY",
		"90"
	},
	{
		"RECOMMEND_REFRESH_TIME",
		"2"
	},
	{
		"WEEKLY_GROWTH_TASK_NUM",
		"5"
	},
	{
		"WEEKLY_GROWTH_RANDOM_TASK_NUM",
		"9"
	},
	{
		"TEACHER_ACHIEVEMENT_TASK_ACTIVITY_TYPE",
		"169"
	},
	{
		"TEACHER_GRAD_AWARD_TASK_ACTIVITY_TYPE",
		"176"
	},
	{
		"PUZZLE_USER_ACTIVE_MAX_TIMES",
		"16"
	},
	{
		"PUZZLE_X",
		"4"
	},
	{
		"PUZZLE_Y",
		"4"
	},
	{
		"PUZZLE_MAX_ACTIVE_POS",
		"16"
	},
	{
		"PUZZLE_ACTIVE_PRIZE",
		"8:1:100000"
	},
	{
		"PUZZLE_DAILY_ADD_TIMES",
		"1"
	},
	{
		"TEACHER_HIRE_PET_MAX",
		"4"
	},
	{
		"HIRE_PET_USE_TIMES",
		"100"
	},
	{
		"SINGLE_PET_CAN_HIRE_TIMES",
		"1"
	},
	{
		"STUDENT_TOTAL_CAN_HIRE_TIMES",
		"15"
	},
	{
		"TEACHER_SET_HIRE_PET_PRIZE",
		"104:2:50"
	},
	{
		"FINISH_TUTOR_PRIZE",
		"8:1:1000000"
	},
	{
		"FINISH_TUTOR_TEXT_CONTENT",
		"三人行，必有我师焉\r\n  在奥奇大陆上，您的学生经过一段时间的学习，提升战力神速，已达成了规定的出师条件，并且成功出师！\r\n为了感谢您在这段时间内所付出的艰辛与汗水，您的学生特地送上了一份感谢礼物，希望您能笑纳~"
	},
	{
		"TUTOR_SYSTEM_RULE",
		"shitu_rule"
	},
	{
		"TUTOR_SYSTEM_GRAD_SCORE_ITEM",
		"1004:1213:0"
	},
	{
		"RED_GRAD_AWARD_TASK_AS_TEA",
		"296"
	},
	{
		"RED_ACHV_TASK_AS_TEA",
		"295"
	},
	{
		"RED_STU_BASE_TASK",
		"308"
	},
	{
		"RED_REQUEST_FROM_TEA",
		"310"
	},
	{
		"RED_REQUEST_FROM_STU",
		"309"
	},
	{
		"RED_PUZZLETIMES",
		"327"
	},
	{
		"RED_SUTDENT_ZDL_TASK",
		"661"
	},
	{
		"NEW_PUZZLE_X",
		"5"
	},
	{
		"NEW_PUZZLE_Y",
		"3"
	},
	{
		"NEW_PUZZLE_LOGIN_TIMES",
		"1"
	},
	{
		"NEW_PUZZLE_ACTIVE_ACTIVATION",
		"60"
	},
	{
		"NEW_PUZZLE_ACTIVE_PRIZE",
		"8:1:1000"
	},
	{
		"FAME_HALL_START_DAY",
		"2024#12"
	}
}
local t_tutor_system_common = {
	TEACHER_ZDL_LIMIT = dataList[1],
	STUDENT_ZDL_LIMIT = dataList[2],
	STUDENT_RECOMMEND_OPEN_ID = dataList[3],
	TEACH_STUDENT_LIMIT = dataList[4],
	TEACHER_REQUEST_NUM = dataList[5],
	STUDENT_REQUEST_NUM = dataList[6],
	RELIEVE_CD = dataList[7],
	AUTO_RELIEVE_DAY = dataList[8],
	RECOMMEND_REFRESH_TIME = dataList[9],
	WEEKLY_GROWTH_TASK_NUM = dataList[10],
	WEEKLY_GROWTH_RANDOM_TASK_NUM = dataList[11],
	TEACHER_ACHIEVEMENT_TASK_ACTIVITY_TYPE = dataList[12],
	TEACHER_GRAD_AWARD_TASK_ACTIVITY_TYPE = dataList[13],
	PUZZLE_USER_ACTIVE_MAX_TIMES = dataList[14],
	PUZZLE_X = dataList[15],
	PUZZLE_Y = dataList[16],
	PUZZLE_MAX_ACTIVE_POS = dataList[17],
	PUZZLE_ACTIVE_PRIZE = dataList[18],
	PUZZLE_DAILY_ADD_TIMES = dataList[19],
	TEACHER_HIRE_PET_MAX = dataList[20],
	HIRE_PET_USE_TIMES = dataList[21],
	SINGLE_PET_CAN_HIRE_TIMES = dataList[22],
	STUDENT_TOTAL_CAN_HIRE_TIMES = dataList[23],
	TEACHER_SET_HIRE_PET_PRIZE = dataList[24],
	FINISH_TUTOR_PRIZE = dataList[25],
	FINISH_TUTOR_TEXT_CONTENT = dataList[26],
	TUTOR_SYSTEM_RULE = dataList[27],
	TUTOR_SYSTEM_GRAD_SCORE_ITEM = dataList[28],
	RED_GRAD_AWARD_TASK_AS_TEA = dataList[29],
	RED_ACHV_TASK_AS_TEA = dataList[30],
	RED_STU_BASE_TASK = dataList[31],
	RED_REQUEST_FROM_TEA = dataList[32],
	RED_REQUEST_FROM_STU = dataList[33],
	RED_PUZZLETIMES = dataList[34],
	RED_SUTDENT_ZDL_TASK = dataList[35],
	NEW_PUZZLE_X = dataList[36],
	NEW_PUZZLE_Y = dataList[37],
	NEW_PUZZLE_LOGIN_TIMES = dataList[38],
	NEW_PUZZLE_ACTIVE_ACTIVATION = dataList[39],
	NEW_PUZZLE_ACTIVE_PRIZE = dataList[40],
	FAME_HALL_START_DAY = dataList[41]
}

t_tutor_system_common.dataList = dataList

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

return t_tutor_system_common
