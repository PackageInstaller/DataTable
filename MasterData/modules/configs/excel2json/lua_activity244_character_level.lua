-- chunkname: @modules/configs/excel2json/lua_activity244_character_level.lua

module("modules.configs.excel2json.lua_activity244_character_level", package.seeall)

local lua_activity244_character_level = {}
local fields = {
	needItem = 4,
	levelTplId = 2,
	hpAdd = 6,
	defAdd = 7,
	id = 1,
	atkAdd = 5,
	healAdd = 8,
	level = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity244_character_level.onLoad(json)
	lua_activity244_character_level.configList, lua_activity244_character_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity244_character_level
