-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tun_tian_challenge_client_common.lua

module("logicconfig.config.t_tun_tian_challenge_client_common", package.seeall)

local title = {
	value = 3,
	comPlanId = 1,
	key = 2
}
local dataList = {
	{
		1,
		"TUNTIAN_PET_SKINID",
		"11014"
	},
	{
		1,
		"TUNTIAN_MAIN_VIEW_BG_EFF",
		""
	},
	{
		1,
		"TUNTIAN_JUMP_PET_CULTIVATE",
		"mibao#nihaituntian4"
	},
	{
		1,
		"TUNTIAN_JUMP_PET_TOP_RANK",
		"func#618#11014"
	},
	{
		1,
		"TUNTIAN_PET_TOP_RANK_RED",
		"ID_PET_TOP_RANK_11014"
	},
	{
		1,
		"TUNTIAN_JUMP_SHOP_KEY",
		"func#43#108"
	},
	{
		1,
		"TUNTIAN_MAIN_RULE_KEY",
		"tuntianchallengemainview_rule"
	},
	{
		1,
		"TUNTIAN_NORMAL_RULE_KEY",
		""
	},
	{
		1,
		"TUNTIAN_EXTREME_RULE_KEY",
		""
	},
	{
		2,
		"TUNTIAN_PET_SKINID",
		"11014"
	},
	{
		2,
		"TUNTIAN_MAIN_VIEW_BG_EFF",
		""
	},
	{
		2,
		"TUNTIAN_JUMP_PET_CULTIVATE",
		"mibao#nihaituntian4"
	},
	{
		2,
		"TUNTIAN_JUMP_PET_TOP_RANK",
		"func#618#11014"
	},
	{
		2,
		"TUNTIAN_PET_TOP_RANK_RED",
		"ID_PET_TOP_RANK_11014"
	},
	{
		2,
		"TUNTIAN_JUMP_SHOP_KEY",
		"func#43#108"
	},
	{
		2,
		"TUNTIAN_MAIN_RULE_KEY",
		"tuntianchallengemainview_rule01"
	},
	{
		2,
		"TUNTIAN_NORMAL_RULE_KEY",
		""
	},
	{
		2,
		"TUNTIAN_EXTREME_RULE_KEY",
		""
	}
}
local t_tun_tian_challenge_client_common = {
	{
		TUNTIAN_PET_SKINID = dataList[1],
		TUNTIAN_MAIN_VIEW_BG_EFF = dataList[2],
		TUNTIAN_JUMP_PET_CULTIVATE = dataList[3],
		TUNTIAN_JUMP_PET_TOP_RANK = dataList[4],
		TUNTIAN_PET_TOP_RANK_RED = dataList[5],
		TUNTIAN_JUMP_SHOP_KEY = dataList[6],
		TUNTIAN_MAIN_RULE_KEY = dataList[7],
		TUNTIAN_NORMAL_RULE_KEY = dataList[8],
		TUNTIAN_EXTREME_RULE_KEY = dataList[9]
	},
	{
		TUNTIAN_PET_SKINID = dataList[10],
		TUNTIAN_MAIN_VIEW_BG_EFF = dataList[11],
		TUNTIAN_JUMP_PET_CULTIVATE = dataList[12],
		TUNTIAN_JUMP_PET_TOP_RANK = dataList[13],
		TUNTIAN_PET_TOP_RANK_RED = dataList[14],
		TUNTIAN_JUMP_SHOP_KEY = dataList[15],
		TUNTIAN_MAIN_RULE_KEY = dataList[16],
		TUNTIAN_NORMAL_RULE_KEY = dataList[17],
		TUNTIAN_EXTREME_RULE_KEY = dataList[18]
	}
}

t_tun_tian_challenge_client_common.dataList = dataList

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

return t_tun_tian_challenge_client_common
