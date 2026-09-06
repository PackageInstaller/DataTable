-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_summon_pet_obtain_common.lua

module("logicconfig.config.t_new_summon_pet_obtain_common", package.seeall)

local title = {
	value = 3,
	comPlanId = 1,
	key = 2
}
local dataList = {
	{
		1,
		"NSOP_MUSIC_CAN_PLAY",
		"-298"
	},
	{
		1,
		"NSOP_MUSIC_PRIZE",
		"-300"
	},
	{
		1,
		"NSOP_PROGRESS_PRIZE",
		"361"
	},
	{
		1,
		"NSOP_PET_SKINID",
		"17005"
	},
	{
		1,
		"NSOP_JUMP_PET_TOP_RANK",
		"func#618#17005"
	},
	{
		1,
		"NSOP_PET_TOP_RANK_RED",
		"ID_PET_TOP_RANK_17005"
	},
	{
		1,
		"NSOP_JUMP_SHOP_KEY",
		"ui#publicdragontabview#1#2"
	},
	{
		1,
		"NSOP_MAIN_RULE_KEY",
		"newsummonpetobtainmainview_rule"
	},
	{
		1,
		"NSOP_CHALLENGE_RULE_KEY",
		"balancemagicview_rule"
	},
	{
		2,
		"NSOP_PROGRESS_PRIZE",
		"361"
	},
	{
		2,
		"NSOP_PET_SKINID",
		"12013"
	},
	{
		2,
		"NSOP_JUMP_PET_TOP_RANK",
		"func#618#12013"
	},
	{
		2,
		"NSOP_PET_TOP_RANK_RED",
		"ID_PET_TOP_RANK_12013"
	},
	{
		2,
		"NSOP_JUMP_SHOP_KEY",
		"func#191#206#206002"
	},
	{
		2,
		"NSOP_MAIN_RULE_KEY",
		"nsopillusoryemperormainview_rule"
	},
	{
		2,
		"NSOP_JUMP_MIBAOSHOP_KEY",
		"mibao#honglianyaoshi5"
	},
	{
		2,
		"NSOP_JUMP_FullRebate_KEY",
		"func#545#3"
	},
	{
		2,
		"NSOP_CHALLENGE_RULE_KEY",
		"nsopillusoryemperorchallengeview_rule"
	}
}
local t_new_summon_pet_obtain_common = {
	{
		NSOP_MUSIC_CAN_PLAY = dataList[1],
		NSOP_MUSIC_PRIZE = dataList[2],
		NSOP_PROGRESS_PRIZE = dataList[3],
		NSOP_PET_SKINID = dataList[4],
		NSOP_JUMP_PET_TOP_RANK = dataList[5],
		NSOP_PET_TOP_RANK_RED = dataList[6],
		NSOP_JUMP_SHOP_KEY = dataList[7],
		NSOP_MAIN_RULE_KEY = dataList[8],
		NSOP_CHALLENGE_RULE_KEY = dataList[9]
	},
	{
		NSOP_PROGRESS_PRIZE = dataList[10],
		NSOP_PET_SKINID = dataList[11],
		NSOP_JUMP_PET_TOP_RANK = dataList[12],
		NSOP_PET_TOP_RANK_RED = dataList[13],
		NSOP_JUMP_SHOP_KEY = dataList[14],
		NSOP_MAIN_RULE_KEY = dataList[15],
		NSOP_JUMP_MIBAOSHOP_KEY = dataList[16],
		NSOP_JUMP_FullRebate_KEY = dataList[17],
		NSOP_CHALLENGE_RULE_KEY = dataList[18]
	}
}

t_new_summon_pet_obtain_common.dataList = dataList

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

return t_new_summon_pet_obtain_common
