-- chunkname: @modules/configs/excel2json/lua_match3_character_level.lua

module("modules.configs.excel2json.lua_match3_character_level", package.seeall)

local lua_match3_character_level = {}
local fields = {
	id = 1,
	levelTplId = 2,
	hpAdd = 6,
	defAdd = 7,
	needExp = 4,
	atkAdd = 5,
	healAdd = 8,
	level = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_match3_character_level.onLoad(json)
	lua_match3_character_level.configList, lua_match3_character_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_match3_character_level
