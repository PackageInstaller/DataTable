-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_common_config.lua

module("logicconfig.config.t_family_common_config", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"DISMISS_WHEN_DAYS_LOW_ACTIVE",
		"30,100"
	},
	{
		"NOTIFY_WHEN_DAYS_LOW_MAIL",
		"7:6,15:6,20:6"
	},
	{
		"CREATE_FAMILY_GOODS_ID",
		"16"
	},
	{
		"FAMILY_NAME_LENGTH_RANGE",
		"2,7"
	},
	{
		"JOIN_FAMILY_AGAIN_CD_HOUR",
		"24"
	},
	{
		"BE_KICK_JOIN_AGAIN_CD_HOUR",
		"2"
	},
	{
		"USER_APPLY_MAX_NUM",
		"10"
	},
	{
		"MAX_EVENT_LOG_NUM",
		"50"
	},
	{
		"SLOT_NUM",
		"8"
	},
	{
		"APPLY_MAX_NUM",
		"20"
	},
	{
		"MODIFY_FAMILY_NAME_GOODS_ID",
		"134"
	},
	{
		"MODIFY_ICON_ID_GOODS_ID",
		"135"
	},
	{
		"MODIFY_FAMILY_SETTINGS_CD_HOUR",
		"168"
	},
	{
		"DECLARATION_MAX_LENGTH",
		"30"
	},
	{
		"RECOMMEND_MIN_SCORE",
		"100"
	},
	{
		"CHIEF_NO_LOGIN_DAYS",
		"10"
	},
	{
		"PURPOSE_TITLE",
		"1:guild_title_1#2:guild_title_2#3:guild_title_3#4:guild_title_4#5:guild_title_5#6:guild_title_6"
	},
	{
		"MAX_ZDL_DEFAULT",
		"10000"
	},
	{
		"MAX_ZDL_MIN",
		"10000"
	},
	{
		"MAX_ZDL_MAX",
		"1000000"
	},
	{
		"MAX_ZDL_STEP",
		"10000"
	},
	{
		"PLAYER_LEVEL_DEFAULT",
		"1"
	},
	{
		"PLAYER_LEVEL_MIN",
		"1"
	},
	{
		"PLAYER_LEVEL_MAX",
		"100"
	},
	{
		"PLAYER_LEVEL_STEP",
		"1"
	},
	{
		"DEFAULT_DECLARATION",
		"欢迎加入我们的大家庭，希望这里能够成为您温暖的家。"
	},
	{
		"APPLY_EXPIRE_HOUR",
		"24"
	},
	{
		"CHANGE_ROLE_CD_HOUR",
		"1"
	},
	{
		"FAMILY_ICON_NUM",
		"9"
	},
	{
		"DAILY_JOIN_LIMIT",
		"40"
	},
	{
		"DAILY_KICK_LIMIT",
		"100"
	},
	{
		"ONE_KEY_KICK_DAYS",
		"7,14,28"
	},
	{
		"DONATE_RECORD_LIMIT",
		"20"
	},
	{
		"MEDAL_WALL_ID",
		"1"
	},
	{
		"KICK_DEFAULT_SELECTION",
		"1,3"
	},
	{
		"SEND_ENLIST_CD_SEC",
		"600"
	},
	{
		"ENLIST_MSG_TEMPLATE_IDS",
		"69,70,71,72,73"
	},
	{
		"SEND_ALL_MEMBER_CD_SEC",
		"14400"
	},
	{
		"SEND_ALL_MEMBER_WEEK_TIMES",
		"2"
	},
	{
		"ALL_MEMBER_MAIL_CONTENT_LENGTH_LIMIT",
		"30"
	},
	{
		"ALL_MEMBER_MAIL_TITLE_LENGTH_LIMIT",
		"8"
	},
	{
		"SEND_ALL_MEMBER_MAIL_COST",
		"1000"
	},
	{
		"SEND_ENLIST_MSG_COST",
		"1000"
	}
}
local t_family_common_config = {
	DISMISS_WHEN_DAYS_LOW_ACTIVE = dataList[1],
	NOTIFY_WHEN_DAYS_LOW_MAIL = dataList[2],
	CREATE_FAMILY_GOODS_ID = dataList[3],
	FAMILY_NAME_LENGTH_RANGE = dataList[4],
	JOIN_FAMILY_AGAIN_CD_HOUR = dataList[5],
	BE_KICK_JOIN_AGAIN_CD_HOUR = dataList[6],
	USER_APPLY_MAX_NUM = dataList[7],
	MAX_EVENT_LOG_NUM = dataList[8],
	SLOT_NUM = dataList[9],
	APPLY_MAX_NUM = dataList[10],
	MODIFY_FAMILY_NAME_GOODS_ID = dataList[11],
	MODIFY_ICON_ID_GOODS_ID = dataList[12],
	MODIFY_FAMILY_SETTINGS_CD_HOUR = dataList[13],
	DECLARATION_MAX_LENGTH = dataList[14],
	RECOMMEND_MIN_SCORE = dataList[15],
	CHIEF_NO_LOGIN_DAYS = dataList[16],
	PURPOSE_TITLE = dataList[17],
	MAX_ZDL_DEFAULT = dataList[18],
	MAX_ZDL_MIN = dataList[19],
	MAX_ZDL_MAX = dataList[20],
	MAX_ZDL_STEP = dataList[21],
	PLAYER_LEVEL_DEFAULT = dataList[22],
	PLAYER_LEVEL_MIN = dataList[23],
	PLAYER_LEVEL_MAX = dataList[24],
	PLAYER_LEVEL_STEP = dataList[25],
	DEFAULT_DECLARATION = dataList[26],
	APPLY_EXPIRE_HOUR = dataList[27],
	CHANGE_ROLE_CD_HOUR = dataList[28],
	FAMILY_ICON_NUM = dataList[29],
	DAILY_JOIN_LIMIT = dataList[30],
	DAILY_KICK_LIMIT = dataList[31],
	ONE_KEY_KICK_DAYS = dataList[32],
	DONATE_RECORD_LIMIT = dataList[33],
	MEDAL_WALL_ID = dataList[34],
	KICK_DEFAULT_SELECTION = dataList[35],
	SEND_ENLIST_CD_SEC = dataList[36],
	ENLIST_MSG_TEMPLATE_IDS = dataList[37],
	SEND_ALL_MEMBER_CD_SEC = dataList[38],
	SEND_ALL_MEMBER_WEEK_TIMES = dataList[39],
	ALL_MEMBER_MAIL_CONTENT_LENGTH_LIMIT = dataList[40],
	ALL_MEMBER_MAIL_TITLE_LENGTH_LIMIT = dataList[41],
	SEND_ALL_MEMBER_MAIL_COST = dataList[42],
	SEND_ENLIST_MSG_COST = dataList[43]
}

t_family_common_config.dataList = dataList

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

return t_family_common_config
