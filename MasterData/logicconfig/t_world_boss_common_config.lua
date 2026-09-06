-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_world_boss_common_config.lua

module("logicconfig.config.t_world_boss_common_config", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"FIGHT_TIMES",
		"3"
	},
	{
		"BOSS_FIGHT_END_TIME",
		"900"
	},
	{
		"BOSS_RANK_TIME",
		"905"
	},
	{
		"BOSS_INTERFACE_DISPLAY_TIME",
		"910"
	},
	{
		"FUNCTION_OPEN_ID",
		"93"
	},
	{
		"BUY_TIMES_SWITCH",
		"FALSE"
	},
	{
		"CLEAR_UNLOCK_SWITCH",
		"FALSE"
	},
	{
		"UNLOCK_MEDICINE_ID",
		"4:801"
	},
	{
		"BATTLE_SCALE",
		"1"
	},
	{
		"BATTLE_RULE",
		"己方精灵开场气势全满"
	},
	{
		"SCHEEDULE",
		"104:2:1#8:1:1"
	},
	{
		"RANKING_REWARDS",
		"排行奖励"
	},
	{
		"DAMAGE_BONUS",
		"伤害奖励"
	},
	{
		"REWARDS_RULE",
		"每次Boss战达到以上条件均可领取相应奖励"
	},
	{
		"BUFF_TIME",
		"2026-03-13 5:00#2026-04-03 5:00"
	}
}
local t_world_boss_common_config = {
	FIGHT_TIMES = dataList[1],
	BOSS_FIGHT_END_TIME = dataList[2],
	BOSS_RANK_TIME = dataList[3],
	BOSS_INTERFACE_DISPLAY_TIME = dataList[4],
	FUNCTION_OPEN_ID = dataList[5],
	BUY_TIMES_SWITCH = dataList[6],
	CLEAR_UNLOCK_SWITCH = dataList[7],
	UNLOCK_MEDICINE_ID = dataList[8],
	BATTLE_SCALE = dataList[9],
	BATTLE_RULE = dataList[10],
	SCHEEDULE = dataList[11],
	RANKING_REWARDS = dataList[12],
	DAMAGE_BONUS = dataList[13],
	REWARDS_RULE = dataList[14],
	BUFF_TIME = dataList[15]
}

t_world_boss_common_config.dataList = dataList

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

return t_world_boss_common_config
