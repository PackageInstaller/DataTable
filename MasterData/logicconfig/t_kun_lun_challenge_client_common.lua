-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_kun_lun_challenge_client_common.lua

module("logicconfig.config.t_kun_lun_challenge_client_common", package.seeall)

local title = {
	value = 3,
	comPlanId = 1,
	key = 2
}
local dataList = {
	{
		1,
		"KUNLUNCHALLENGE_PET_SKINID",
		"13013"
	},
	{
		1,
		"KUNLUNCHALLENGE_JUMP_KEY_1",
		"func#618#13013"
	},
	{
		1,
		"KUNLUNCHALLENGE_JUMP_KEY_2",
		"mibao#shuangjiekuanghuan3"
	},
	{
		1,
		"KUNLUNCHALLENGE_JUMP_KEY_3",
		"func#43#119"
	},
	{
		1,
		"KUNLUNCHALLENGE_JUMP_RED_1",
		""
	},
	{
		1,
		"KUNLUNCHALLENGE_JUMP_RED_2",
		""
	},
	{
		1,
		"KUNLUNCHALLENGE_JUMP_RED_3",
		""
	},
	{
		1,
		"KUNLUNCHALLENGE_RULE_MAIN_KEY",
		"kunlunchallenge_rule_main"
	},
	{
		1,
		"KUNLUNCHALLENGE_RULE_NORMAL_KEY",
		"kunlunchallenge_rule_normal"
	},
	{
		1,
		"KUNLUNCHALLENGE_RULE_EXTREME_KEY",
		"kunlunchallenge_rule_extreme"
	},
	{
		2,
		"KUNLUNCHALLENGE_PET_SKINID",
		"13013"
	},
	{
		2,
		"KUNLUNCHALLENGE_JUMP_KEY_1",
		"func#618#13013"
	},
	{
		2,
		"KUNLUNCHALLENGE_JUMP_KEY_2",
		"mibao#shuangjiekuanghuan3"
	},
	{
		2,
		"KUNLUNCHALLENGE_JUMP_KEY_3",
		"func#43#119"
	},
	{
		2,
		"KUNLUNCHALLENGE_JUMP_RED_1",
		""
	},
	{
		2,
		"KUNLUNCHALLENGE_JUMP_RED_2",
		""
	},
	{
		2,
		"KUNLUNCHALLENGE_JUMP_RED_3",
		""
	},
	{
		2,
		"KUNLUNCHALLENGE_RULE_MAIN_KEY",
		"kunlunchallenge_rule_extreme"
	},
	{
		2,
		"KUNLUNCHALLENGE_RULE_NORMAL_KEY",
		"kunlunchallenge_rule_normal"
	},
	{
		2,
		"KUNLUNCHALLENGE_RULE_EXTREME_KEY",
		"kunlunchallenge_rule_extreme"
	}
}
local t_kun_lun_challenge_client_common = {
	{
		KUNLUNCHALLENGE_PET_SKINID = dataList[1],
		KUNLUNCHALLENGE_JUMP_KEY_1 = dataList[2],
		KUNLUNCHALLENGE_JUMP_KEY_2 = dataList[3],
		KUNLUNCHALLENGE_JUMP_KEY_3 = dataList[4],
		KUNLUNCHALLENGE_JUMP_RED_1 = dataList[5],
		KUNLUNCHALLENGE_JUMP_RED_2 = dataList[6],
		KUNLUNCHALLENGE_JUMP_RED_3 = dataList[7],
		KUNLUNCHALLENGE_RULE_MAIN_KEY = dataList[8],
		KUNLUNCHALLENGE_RULE_NORMAL_KEY = dataList[9],
		KUNLUNCHALLENGE_RULE_EXTREME_KEY = dataList[10]
	},
	{
		KUNLUNCHALLENGE_PET_SKINID = dataList[11],
		KUNLUNCHALLENGE_JUMP_KEY_1 = dataList[12],
		KUNLUNCHALLENGE_JUMP_KEY_2 = dataList[13],
		KUNLUNCHALLENGE_JUMP_KEY_3 = dataList[14],
		KUNLUNCHALLENGE_JUMP_RED_1 = dataList[15],
		KUNLUNCHALLENGE_JUMP_RED_2 = dataList[16],
		KUNLUNCHALLENGE_JUMP_RED_3 = dataList[17],
		KUNLUNCHALLENGE_RULE_MAIN_KEY = dataList[18],
		KUNLUNCHALLENGE_RULE_NORMAL_KEY = dataList[19],
		KUNLUNCHALLENGE_RULE_EXTREME_KEY = dataList[20]
	}
}

t_kun_lun_challenge_client_common.dataList = dataList

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

return t_kun_lun_challenge_client_common
