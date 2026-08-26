-- chunkname: @modules/configs/excel2json/lua_auto_chess_episode.lua

module("modules.configs.excel2json.lua_auto_chess_episode", package.seeall)

local lua_auto_chess_episode = {}
local fields = {
	preEpisode = 6,
	name = 3,
	firstBounds = 14,
	type = 5,
	winCondition = 11,
	image = 4,
	lostCondition = 12,
	functionOn = 16,
	mallIds = 9,
	maxRound = 10,
	masterLibraryId = 15,
	enemyId = 7,
	id = 2,
	masterId = 13,
	activityId = 1,
	npcEnemyId = 8
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_auto_chess_episode.onLoad(json)
	lua_auto_chess_episode.configList, lua_auto_chess_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_chess_episode
