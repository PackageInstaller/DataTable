-- chunkname: @modules/configs/excel2json/lua_character_destiny_facets.lua

module("modules.configs.excel2json.lua_character_destiny_facets", package.seeall)

local lua_character_destiny_facets = {}
local fields = {
	exchangeSkills = 7,
	facetsId = 1,
	uniqueSkill_point = 4,
	desc = 8,
	ex_level_exchange = 9,
	deviceAdd = 5,
	powerAdd = 3,
	qteAdd = 6,
	level = 2
}
local primaryKey = {
	"facetsId",
	"level"
}
local mlStringKey = {
	desc = 1
}

function lua_character_destiny_facets.onLoad(json)
	lua_character_destiny_facets.configList, lua_character_destiny_facets.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_character_destiny_facets
