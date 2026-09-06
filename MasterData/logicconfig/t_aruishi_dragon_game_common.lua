-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_aruishi_dragon_game_common.lua

module("logicconfig.config.t_aruishi_dragon_game_common", package.seeall)

local title = {
	value = 3,
	comPlanId = 1,
	key = 2
}
local dataList = {
	{
		1,
		"ARES_GAME_RULE_VIEW_IMG_PATHS",
		"board_syars_12#board_syars_13#board_syars_14"
	},
	{
		1,
		"ARES_GAME_DAILY_RED",
		"c9"
	},
	{
		1,
		"ARES_GAME_BG_PATH_LIST",
		"board_syars_07#board_syars_08#board_syars_09"
	}
}
local t_aruishi_dragon_game_common = {
	{
		ARES_GAME_RULE_VIEW_IMG_PATHS = dataList[1],
		ARES_GAME_DAILY_RED = dataList[2],
		ARES_GAME_BG_PATH_LIST = dataList[3]
	}
}

t_aruishi_dragon_game_common.dataList = dataList

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

return t_aruishi_dragon_game_common
