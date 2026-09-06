-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_eternal_challenge_client_common.lua

module("logicconfig.config.t_eternal_challenge_client_common", package.seeall)

local title = {
	value = 3,
	comPlanId = 1,
	key = 2
}
local dataList = {
	{
		1,
		"ETERNALCHALLENGE_PET_SKINID",
		"13009"
	},
	{
		1,
		"ETERNALCHALLENGE_JUMP_KEY_1",
		"func#618#13009"
	},
	{
		1,
		"ETERNALCHALLENGE_JUMP_KEY_2",
		"ui#eternalchallengetaskframeview#297001"
	},
	{
		1,
		"ETERNALCHALLENGE_JUMP_KEY_3",
		"func#545#46"
	},
	{
		1,
		"ETERNALCHALLENGE_JUMP_RED_1",
		""
	},
	{
		1,
		"ETERNALCHALLENGE_JUMP_RED_2",
		"511"
	},
	{
		1,
		"ETERNALCHALLENGE_JUMP_RED_3",
		"o20"
	},
	{
		1,
		"ETERNALCHALLENGE_RULE_MAIN_KEY",
		"eternalchallenge_rule"
	},
	{
		1,
		"ETERNALCHALLENGE_RULE_TASK_KEY",
		"eternalchallenge_rule"
	},
	{
		1,
		"ETERNALCHALLENGE_BOSS_HP",
		"36000000"
	}
}
local t_eternal_challenge_client_common = {
	{
		ETERNALCHALLENGE_PET_SKINID = dataList[1],
		ETERNALCHALLENGE_JUMP_KEY_1 = dataList[2],
		ETERNALCHALLENGE_JUMP_KEY_2 = dataList[3],
		ETERNALCHALLENGE_JUMP_KEY_3 = dataList[4],
		ETERNALCHALLENGE_JUMP_RED_1 = dataList[5],
		ETERNALCHALLENGE_JUMP_RED_2 = dataList[6],
		ETERNALCHALLENGE_JUMP_RED_3 = dataList[7],
		ETERNALCHALLENGE_RULE_MAIN_KEY = dataList[8],
		ETERNALCHALLENGE_RULE_TASK_KEY = dataList[9],
		ETERNALCHALLENGE_BOSS_HP = dataList[10]
	}
}

t_eternal_challenge_client_common.dataList = dataList

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

return t_eternal_challenge_client_common
