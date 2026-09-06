-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_element_spark_common_vars.lua

module("logicconfig.config.t_element_spark_common_vars", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"COMMANDER_COUNT",
		"3"
	},
	{
		"ATTACK_TEAM_NUM",
		"2"
	},
	{
		"GUARD_TEAM_NUM",
		"1"
	},
	{
		"TEAM_STRENGTH_LIMIT",
		"120"
	},
	{
		"TEAM_STRENGTH_RECOVER_PERIOD",
		"12"
	},
	{
		"TEAM_STRENGTH_RECOVER_UNIT",
		"1"
	},
	{
		"ATTACK_SYS_COST",
		"4"
	},
	{
		"ATTACK_PLAYER_COST",
		"4"
	},
	{
		"ATTACK_BOSS_COST",
		"4"
	},
	{
		"GUARD_READY_MINUTE",
		"5"
	},
	{
		"DEFEAT_CD_MINUTE",
		"10"
	},
	{
		"OCCUPY_PROTECT_MINUTE",
		"10"
	},
	{
		"TAG_NUM",
		"10"
	},
	{
		"CHANGE_TAG_PROTECT_SEC",
		"1"
	},
	{
		"COMMAND_MAX_LENGTH",
		"20"
	},
	{
		"BOARD_MAX_LENGTH",
		"50"
	},
	{
		"COMMANDER_SIGN_IN_DAYS",
		"3"
	},
	{
		"COMMANDER_VIP_LV",
		"4"
	},
	{
		"CAMP_PERSON_RANK_SIZE",
		"500"
	},
	{
		"DEFAULT_DEFENSE_FORM_MIN_ZDL",
		"10000"
	},
	{
		"MODIFY_BOARD_CD_SEC",
		"10"
	},
	{
		"ADD_COMMAND_CD_SEC",
		"15"
	},
	{
		"MODIFY_MIN_ZDL_CD_SEC",
		"20"
	},
	{
		"DAMAGE_WAN_PERCENT_TO_PERSON_SCORE",
		"5"
	},
	{
		"BE_ATTACK_SIGN_SHOW_SEC",
		"120"
	},
	{
		"COMMANDER_PERSON_RANK_TO_RETAIN",
		"30"
	}
}
local t_element_spark_common_vars = {
	COMMANDER_COUNT = dataList[1],
	ATTACK_TEAM_NUM = dataList[2],
	GUARD_TEAM_NUM = dataList[3],
	TEAM_STRENGTH_LIMIT = dataList[4],
	TEAM_STRENGTH_RECOVER_PERIOD = dataList[5],
	TEAM_STRENGTH_RECOVER_UNIT = dataList[6],
	ATTACK_SYS_COST = dataList[7],
	ATTACK_PLAYER_COST = dataList[8],
	ATTACK_BOSS_COST = dataList[9],
	GUARD_READY_MINUTE = dataList[10],
	DEFEAT_CD_MINUTE = dataList[11],
	OCCUPY_PROTECT_MINUTE = dataList[12],
	TAG_NUM = dataList[13],
	CHANGE_TAG_PROTECT_SEC = dataList[14],
	COMMAND_MAX_LENGTH = dataList[15],
	BOARD_MAX_LENGTH = dataList[16],
	COMMANDER_SIGN_IN_DAYS = dataList[17],
	COMMANDER_VIP_LV = dataList[18],
	CAMP_PERSON_RANK_SIZE = dataList[19],
	DEFAULT_DEFENSE_FORM_MIN_ZDL = dataList[20],
	MODIFY_BOARD_CD_SEC = dataList[21],
	ADD_COMMAND_CD_SEC = dataList[22],
	MODIFY_MIN_ZDL_CD_SEC = dataList[23],
	DAMAGE_WAN_PERCENT_TO_PERSON_SCORE = dataList[24],
	BE_ATTACK_SIGN_SHOW_SEC = dataList[25],
	COMMANDER_PERSON_RANK_TO_RETAIN = dataList[26]
}

t_element_spark_common_vars.dataList = dataList

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

return t_element_spark_common_vars
