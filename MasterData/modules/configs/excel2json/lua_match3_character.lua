-- chunkname: @modules/configs/excel2json/lua_match3_character.lua

module("modules.configs.excel2json.lua_match3_character", package.seeall)

local lua_match3_character = {}
local fields = {
	baseDef = 7,
	baseHeal = 8,
	baseHp = 6,
	baseAtk = 5,
	name = 2,
	image = 11,
	levelTplId = 4,
	costItemId = 13,
	elementId = 3,
	unlockType = 12,
	characterId = 1,
	icon = 10,
	activeSkillId = 9
}
local primaryKey = {
	"characterId"
}
local mlStringKey = {
	name = 1
}

function lua_match3_character.onLoad(json)
	lua_match3_character.configList, lua_match3_character.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_match3_character
