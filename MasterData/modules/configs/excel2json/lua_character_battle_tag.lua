-- chunkname: @modules/configs/excel2json/lua_character_battle_tag.lua

module("modules.configs.excel2json.lua_character_battle_tag", package.seeall)

local lua_character_battle_tag = {}
local fields = {
	id = 1,
	typeid = 3,
	tagName = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	tagName = 1
}

function lua_character_battle_tag.onLoad(json)
	lua_character_battle_tag.configList, lua_character_battle_tag.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_character_battle_tag
