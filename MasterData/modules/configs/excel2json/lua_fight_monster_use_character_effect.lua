-- chunkname: @modules/configs/excel2json/lua_fight_monster_use_character_effect.lua

module("modules.configs.excel2json.lua_fight_monster_use_character_effect", package.seeall)

local lua_fight_monster_use_character_effect = {}
local fields = {
	id = 1,
	characterId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_monster_use_character_effect.onLoad(json)
	lua_fight_monster_use_character_effect.configList, lua_fight_monster_use_character_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_monster_use_character_effect
