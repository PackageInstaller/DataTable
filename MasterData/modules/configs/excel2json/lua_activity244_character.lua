-- chunkname: @modules/configs/excel2json/lua_activity244_character.lua

module("modules.configs.excel2json.lua_activity244_character", package.seeall)

local lua_activity244_character = {}
local fields = {
	baseDef = 7,
	baseHeal = 8,
	baseHp = 6,
	baseAtk = 5,
	name = 2,
	image = 11,
	mesh = 12,
	levelTplId = 4,
	elementId = 3,
	unlockType = 13,
	isTrial = 14,
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

function lua_activity244_character.onLoad(json)
	lua_activity244_character.configList, lua_activity244_character.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity244_character
