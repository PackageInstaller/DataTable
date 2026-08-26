-- chunkname: @modules/configs/excel2json/lua_war_chess_episode.lua

module("modules.configs.excel2json.lua_war_chess_episode", package.seeall)

local lua_war_chess_episode = {}
local fields = {
	unlockSlotIds = 13,
	failCondition = 10,
	unlockChessSoldierIds = 12,
	presetSoldier = 18,
	extraWinConditionDesc = 7,
	presetCharacter = 17,
	preset = 16,
	winCondition = 6,
	strongHoldIds = 4,
	maxRound = 3,
	extraWinCondition = 8,
	unlockCharacterIds = 11,
	chessScene = 15,
	dialogueId = 19,
	eliminateScene = 14,
	failConditionDesc = 9,
	enemyId = 2,
	id = 1,
	winConditionDesc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	extraWinConditionDesc = 2,
	winConditionDesc = 1,
	failConditionDesc = 3
}

function lua_war_chess_episode.onLoad(json)
	lua_war_chess_episode.configList, lua_war_chess_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_war_chess_episode
