-- chunkname: @modules/configs/excel2json/lua_rogue_difficulty.lua

module("modules.configs.excel2json.lua_rogue_difficulty", package.seeall)

local lua_rogue_difficulty = {}
local fields = {
	effect1 = 15,
	initRoom = 5,
	effectDesc1 = 14,
	scoreAdd = 11,
	effect3 = 19,
	title = 2,
	initHeroCount = 12,
	effect2 = 17,
	effectDesc3 = 18,
	initCurrency = 6,
	initHeart = 7,
	difficulty = 1,
	preDifficulty = 3,
	attrAdd = 10,
	rule = 8,
	effectDesc2 = 16,
	showDifficulty = 9,
	retries = 13,
	initLevel = 4
}
local primaryKey = {
	"difficulty"
}
local mlStringKey = {
	effectDesc1 = 2,
	title = 1,
	effectDesc3 = 4,
	effectDesc2 = 3
}

function lua_rogue_difficulty.onLoad(json)
	lua_rogue_difficulty.configList, lua_rogue_difficulty.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rogue_difficulty
