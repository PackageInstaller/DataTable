-- chunkname: @modules/configs/excel2json/lua_activity188_game.lua

module("modules.configs.excel2json.lua_activity188_game", package.seeall)

local lua_activity188_game = {}
local fields = {
	bossAbilityPool = 10,
	activityId = 1,
	count = 13,
	portrait = 19,
	abilityIds = 5,
	passRound = 18,
	bossCount = 14,
	bossAbilityIds = 6,
	bossHurt = 16,
	abilityPool = 9,
	bossHp = 12,
	rowColumn = 7,
	round = 3,
	hurt = 15,
	hp = 11,
	cardBuild = 8,
	id = 2,
	difficult = 17,
	readNum = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_activity188_game.onLoad(json)
	lua_activity188_game.configList, lua_activity188_game.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity188_game
