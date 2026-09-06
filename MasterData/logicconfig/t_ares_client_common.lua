-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ares_client_common.lua

module("logicconfig.config.t_ares_client_common", package.seeall)

local title = {
	value = 3,
	comPlanId = 1,
	key = 2
}
local dataList = {
	{
		1,
		"ARES_JUMP_KEY_1",
		"func#618#13006"
	},
	{
		1,
		"ARES_JUMP_KEY_2",
		"func#43#201"
	},
	{
		1,
		"ARES_JUMP_KEY_3",
		"mibao#shenglongheyi1"
	},
	{
		1,
		"ARES_CHALLENGE_DAILY_RED",
		"c9"
	},
	{
		1,
		"ARES_CHALLENGE_RED",
		"342"
	},
	{
		1,
		"ARES_FIRST_STORY_ID",
		"4350001"
	},
	{
		1,
		"ARES_VIEW_NAME_MAIN",
		"aresmommainview"
	},
	{
		1,
		"ARES_VIEW_NAME_CHALLENGE",
		"aresmomchallengeview"
	},
	{
		1,
		"ARES_VIEW_NAME_TYPE",
		"aresmomtypeview"
	},
	{
		1,
		"ARES_VIEW_NAME_GAME",
		"aresmomgameview"
	},
	{
		1,
		"ARES_GAME_RULE_VIEW_IMG_PATHS",
		"board_shenyaotianmanwang_32#board_shenyaotianmanwang_33#board_shenyaotianmanwang_34"
	},
	{
		1,
		"ARES_GAME_DAILY_RED",
		"c9"
	},
	{
		1,
		"ARES_GAME_BG_PATH_LIST",
		"board_aruisimuqin_18#board_aruisimuqin_21#board_aruisimuqin_39"
	},
	{
		2,
		"ARES_JUMP_KEY_1",
		"func#618#13010"
	},
	{
		2,
		"ARES_JUMP_KEY_2",
		"func#545#3"
	},
	{
		2,
		"ARES_JUMP_KEY_3",
		"mibao#shenyaolibao"
	},
	{
		2,
		"ARES_CHALLENGE_DAILY_RED",
		"c9"
	},
	{
		2,
		"ARES_CHALLENGE_RED",
		"342"
	},
	{
		2,
		"ARES_FIRST_STORY_ID",
		""
	},
	{
		2,
		"ARES_VIEW_NAME_MAIN",
		"aresmommaintwoview"
	},
	{
		2,
		"ARES_VIEW_NAME_CHALLENGE",
		"aresmomchallengetwoview"
	},
	{
		2,
		"ARES_VIEW_NAME_TYPE",
		"aresmomtypetwoview"
	},
	{
		2,
		"ARES_VIEW_NAME_GAME",
		"aresmomgametwoview"
	},
	{
		2,
		"ARES_GAME_RULE_VIEW_IMG_PATHS",
		"board_aruisimuqin_44#board_aruisimuqin_45#board_aruisimuqin_46"
	},
	{
		2,
		"ARES_GAME_DAILY_RED",
		"c22"
	},
	{
		2,
		"ARES_GAME_BG_PATH_LIST",
		"board_shenyaotianmanwang_09#board_shenyaotianmanwang_10#board_shenyaotianmanwang_13"
	}
}
local t_ares_client_common = {
	{
		ARES_JUMP_KEY_1 = dataList[1],
		ARES_JUMP_KEY_2 = dataList[2],
		ARES_JUMP_KEY_3 = dataList[3],
		ARES_CHALLENGE_DAILY_RED = dataList[4],
		ARES_CHALLENGE_RED = dataList[5],
		ARES_FIRST_STORY_ID = dataList[6],
		ARES_VIEW_NAME_MAIN = dataList[7],
		ARES_VIEW_NAME_CHALLENGE = dataList[8],
		ARES_VIEW_NAME_TYPE = dataList[9],
		ARES_VIEW_NAME_GAME = dataList[10],
		ARES_GAME_RULE_VIEW_IMG_PATHS = dataList[11],
		ARES_GAME_DAILY_RED = dataList[12],
		ARES_GAME_BG_PATH_LIST = dataList[13]
	},
	{
		ARES_JUMP_KEY_1 = dataList[14],
		ARES_JUMP_KEY_2 = dataList[15],
		ARES_JUMP_KEY_3 = dataList[16],
		ARES_CHALLENGE_DAILY_RED = dataList[17],
		ARES_CHALLENGE_RED = dataList[18],
		ARES_FIRST_STORY_ID = dataList[19],
		ARES_VIEW_NAME_MAIN = dataList[20],
		ARES_VIEW_NAME_CHALLENGE = dataList[21],
		ARES_VIEW_NAME_TYPE = dataList[22],
		ARES_VIEW_NAME_GAME = dataList[23],
		ARES_GAME_RULE_VIEW_IMG_PATHS = dataList[24],
		ARES_GAME_DAILY_RED = dataList[25],
		ARES_GAME_BG_PATH_LIST = dataList[26]
	}
}

t_ares_client_common.dataList = dataList

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

return t_ares_client_common
