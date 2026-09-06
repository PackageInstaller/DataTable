-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_pve_common.lua

module("logicconfig.config.t_season_mode_pve_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"TEAM_ADJUST_TIMES",
		"3"
	},
	{
		"DAILY_RESET_TEAM_TIMES",
		"1"
	},
	{
		"TEAM_PACKAGE_NUM",
		"8"
	},
	{
		"TEAM_PET_AWAKEN_LEVEL",
		"0"
	},
	{
		"TEAM_MOVE_MAX_GRID",
		"1"
	},
	{
		"CONTRACT_SKILL_ID",
		"520009"
	},
	{
		"INIT_STRENGTH",
		"120"
	},
	{
		"BOSS_SPEAK_TIME_DAY_LIMIT",
		"5"
	},
	{
		"BOSS_SPEAK_FIX_TIME",
		"120"
	},
	{
		"BOSS_SPEAK_RAND_TIME",
		"20"
	},
	{
		"BOSS_SPEAK_HOLD_TIME",
		"5"
	},
	{
		"ALL_MEDAL_STRENGTH_DISCOUNT",
		"0.8"
	},
	{
		"BOSS_GUIDE_SKINID",
		"17012"
	},
	{
		"HIGH_FIGHT_LOW_BUFF",
		"51:99"
	},
	{
		"LOW_FIGHT_HIGH_DEBUFF",
		"10238:99"
	},
	{
		"FINAL_BOSS_ID",
		"1"
	},
	{
		"FINAL_BOSS_SHOW_PHASEID",
		"3"
	},
	{
		"DEFEND_BOSS_SHOW_PHASEID",
		"3"
	},
	{
		"CUR_SEASONID",
		"3"
	}
}
local t_season_mode_pve_common = {
	TEAM_ADJUST_TIMES = dataList[1],
	DAILY_RESET_TEAM_TIMES = dataList[2],
	TEAM_PACKAGE_NUM = dataList[3],
	TEAM_PET_AWAKEN_LEVEL = dataList[4],
	TEAM_MOVE_MAX_GRID = dataList[5],
	CONTRACT_SKILL_ID = dataList[6],
	INIT_STRENGTH = dataList[7],
	BOSS_SPEAK_TIME_DAY_LIMIT = dataList[8],
	BOSS_SPEAK_FIX_TIME = dataList[9],
	BOSS_SPEAK_RAND_TIME = dataList[10],
	BOSS_SPEAK_HOLD_TIME = dataList[11],
	ALL_MEDAL_STRENGTH_DISCOUNT = dataList[12],
	BOSS_GUIDE_SKINID = dataList[13],
	HIGH_FIGHT_LOW_BUFF = dataList[14],
	LOW_FIGHT_HIGH_DEBUFF = dataList[15],
	FINAL_BOSS_ID = dataList[16],
	FINAL_BOSS_SHOW_PHASEID = dataList[17],
	DEFEND_BOSS_SHOW_PHASEID = dataList[18],
	CUR_SEASONID = dataList[19]
}

t_season_mode_pve_common.dataList = dataList

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

return t_season_mode_pve_common
