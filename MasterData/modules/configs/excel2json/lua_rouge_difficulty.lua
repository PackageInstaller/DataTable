-- chunkname: @modules/configs/excel2json/lua_rouge_difficulty.lua

module("modules.configs.excel2json.lua_rouge_difficulty", package.seeall)

local lua_rouge_difficulty = {}
local fields = {
	title_en = 5,
	preDifficulty = 6,
	scoreReward = 8,
	startView = 9,
	season = 1,
	title = 4,
	initEffects = 11,
	desc = 12,
	monsterDesc = 7,
	balanceLevel = 13,
	initCollections = 10,
	version = 3,
	difficulty = 2
}
local primaryKey = {
	"season",
	"difficulty"
}
local mlStringKey = {
	title_en = 2,
	title = 1,
	monsterDesc = 3,
	desc = 4
}

function lua_rouge_difficulty.onLoad(json)
	lua_rouge_difficulty.configList, lua_rouge_difficulty.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_difficulty
