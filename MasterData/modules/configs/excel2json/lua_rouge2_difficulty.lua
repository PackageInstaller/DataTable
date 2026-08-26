-- chunkname: @modules/configs/excel2json/lua_rouge2_difficulty.lua

module("modules.configs.excel2json.lua_rouge2_difficulty", package.seeall)

local lua_rouge2_difficulty = {}
local fields = {
	title_en = 3,
	preDifficulty = 5,
	scoreReward = 7,
	startView = 8,
	title = 2,
	bg = 4,
	desc = 10,
	monsterDesc = 6,
	balanceLevel = 11,
	initCollections = 9,
	difficulty = 1
}
local primaryKey = {
	"difficulty"
}
local mlStringKey = {
	title_en = 2,
	title = 1,
	monsterDesc = 3,
	desc = 4
}

function lua_rouge2_difficulty.onLoad(json)
	lua_rouge2_difficulty.configList, lua_rouge2_difficulty.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_difficulty
