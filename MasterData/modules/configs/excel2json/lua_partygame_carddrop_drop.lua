-- chunkname: @modules/configs/excel2json/lua_partygame_carddrop_drop.lua

module("modules.configs.excel2json.lua_partygame_carddrop_drop", package.seeall)

local lua_partygame_carddrop_drop = {}
local fields = {
	chooseMode7 = 24,
	round = 3,
	chooseMode1 = 6,
	dropGroup6 = 20,
	maxHpUp1 = 7,
	dropGroup3 = 11,
	maxHpUp7 = 25,
	playerNum = 2,
	chooseMode3 = 12,
	maxHpUp6 = 22,
	chooseMode6 = 21,
	chooseMode8 = 27,
	chooseMode5 = 18,
	dropGroup7 = 23,
	dropGroup1 = 5,
	dropGroup4 = 14,
	maxHpUp4 = 16,
	chooseMode2 = 9,
	groupType = 4,
	maxHpUp2 = 10,
	chooseMode4 = 15,
	dropGroup8 = 26,
	dropGroup5 = 17,
	maxHpUp5 = 19,
	dropGroup2 = 8,
	id = 1,
	maxHpUp3 = 13,
	maxHpUp8 = 28
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_partygame_carddrop_drop.onLoad(json)
	lua_partygame_carddrop_drop.configList, lua_partygame_carddrop_drop.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_partygame_carddrop_drop
