-- chunkname: @modules/configs/excel2json/lua_critter_hero_preference.lua

module("modules.configs.excel2json.lua_critter_hero_preference", package.seeall)

local lua_critter_hero_preference = {}
local fields = {
	preferenceValue = 3,
	attachEventId = 8,
	attachAttribute = 10,
	preferenceType = 2,
	attachStoryId = 11,
	addIncrRate = 6,
	desc = 7,
	attachOption = 9,
	heroId = 1,
	spEventId = 12,
	critterIcon = 4,
	effectAttribute = 5
}
local primaryKey = {
	"heroId"
}
local mlStringKey = {
	attachOption = 2,
	desc = 1
}

function lua_critter_hero_preference.onLoad(json)
	lua_critter_hero_preference.configList, lua_critter_hero_preference.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_critter_hero_preference
