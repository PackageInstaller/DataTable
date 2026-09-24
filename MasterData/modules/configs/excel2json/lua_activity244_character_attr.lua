-- chunkname: @modules/configs/excel2json/lua_activity244_character_attr.lua

module("modules.configs.excel2json.lua_activity244_character_attr", package.seeall)

local lua_activity244_character_attr = {}
local fields = {
	baseFieldName = 4,
	name = 2,
	addFieldName = 5,
	id = 1,
	icon = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_activity244_character_attr.onLoad(json)
	lua_activity244_character_attr.configList, lua_activity244_character_attr.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity244_character_attr
