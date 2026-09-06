-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_disorder_dragon_challenge_common.lua

module("logicconfig.config.t_disorder_dragon_challenge_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"JUMP_SHOP_KEY",
		"mibao#nvshentehui1"
	},
	{
		"JUMP_RANK_KEY",
		"func#618#16011"
	},
	{
		"JUMP_LOTTERY_KEY",
		"func#43#112"
	},
	{
		"PET_RANK_RED",
		"ID_PET_TOP_RANK_16011"
	},
	{
		"PET_SKINID",
		"16011"
	},
	{
		"MAIN_VIEW_RULE_KEY",
		"WuxuChallengemainview_rule"
	},
	{
		"UNIT_STORYID",
		"4450001"
	},
	{
		"BUBBLE_TIPS_DKEY",
		"dodragon_1"
	},
	{
		"BOSS_DEFAULT_SKIN_POS",
		"-275.2#-604.36#1"
	}
}
local t_disorder_dragon_challenge_common = {
	JUMP_SHOP_KEY = dataList[1],
	JUMP_RANK_KEY = dataList[2],
	JUMP_LOTTERY_KEY = dataList[3],
	PET_RANK_RED = dataList[4],
	PET_SKINID = dataList[5],
	MAIN_VIEW_RULE_KEY = dataList[6],
	UNIT_STORYID = dataList[7],
	BUBBLE_TIPS_DKEY = dataList[8],
	BOSS_DEFAULT_SKIN_POS = dataList[9]
}

t_disorder_dragon_challenge_common.dataList = dataList

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

return t_disorder_dragon_challenge_common
