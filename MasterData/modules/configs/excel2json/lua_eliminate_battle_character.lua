-- chunkname: @modules/configs/excel2json/lua_eliminate_battle_character.lua

module("modules.configs.excel2json.lua_eliminate_battle_character", package.seeall)

local lua_eliminate_battle_character = {}
local fields = {
	skill = 5,
	name = 2,
	hp = 4,
	specialAttr1 = 6,
	id = 1,
	icon = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_eliminate_battle_character.onLoad(json)
	lua_eliminate_battle_character.configList, lua_eliminate_battle_character.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_eliminate_battle_character
