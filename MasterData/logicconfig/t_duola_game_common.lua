-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_duola_game_common.lua

module("logicconfig.config.t_duola_game_common", package.seeall)

local title = {
	value = 3,
	comPlanId = 1,
	key = 2
}
local dataList = {
	{
		1,
		"DL_PET_SKINID",
		"11009"
	},
	{
		1,
		"DL_JUMP_PET_RANK",
		"func#618#11009"
	},
	{
		1,
		"DL_PET_TOP_RANK_RED",
		"ID_PET_TOP_RANK_11009"
	},
	{
		1,
		"DL_JUMP_SHOP",
		"mibao#shenyaolibao"
	},
	{
		1,
		"DL_JUMP_H5",
		"ui#shareqrcodeview#share_01"
	},
	{
		1,
		"DL_MAIN_RULE_KEY",
		"duola_game_rule"
	},
	{
		1,
		"DL_GAME_RULE_KEY",
		"duola_game_rule"
	},
	{
		1,
		"DL_RED_ID_TIMES",
		"501"
	},
	{
		2,
		"DL_PET_SKINID",
		"16032"
	},
	{
		2,
		"DL_JUMP_PET_RANK",
		""
	},
	{
		2,
		"DL_PET_TOP_RANK_RED",
		""
	},
	{
		2,
		"DL_JUMP_SHOP",
		""
	},
	{
		2,
		"DL_JUMP_H5",
		""
	},
	{
		2,
		"DL_MAIN_RULE_KEY",
		"duola_game_rule2"
	},
	{
		2,
		"DL_GAME_RULE_KEY",
		"duola_game_rule2"
	},
	{
		2,
		"DL_RED_ID_TIMES",
		"561"
	}
}
local t_duola_game_common = {
	{
		DL_PET_SKINID = dataList[1],
		DL_JUMP_PET_RANK = dataList[2],
		DL_PET_TOP_RANK_RED = dataList[3],
		DL_JUMP_SHOP = dataList[4],
		DL_JUMP_H5 = dataList[5],
		DL_MAIN_RULE_KEY = dataList[6],
		DL_GAME_RULE_KEY = dataList[7],
		DL_RED_ID_TIMES = dataList[8]
	},
	{
		DL_PET_SKINID = dataList[9],
		DL_JUMP_PET_RANK = dataList[10],
		DL_PET_TOP_RANK_RED = dataList[11],
		DL_JUMP_SHOP = dataList[12],
		DL_JUMP_H5 = dataList[13],
		DL_MAIN_RULE_KEY = dataList[14],
		DL_GAME_RULE_KEY = dataList[15],
		DL_RED_ID_TIMES = dataList[16]
	}
}

t_duola_game_common.dataList = dataList

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

return t_duola_game_common
