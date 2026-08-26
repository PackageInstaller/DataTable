-- chunkname: @modules/configs/excel2json/lua_arcade_active_skill.lua

module("modules.configs.excel2json.lua_arcade_active_skill", package.seeall)

local lua_arcade_active_skill = {}
local fields = {
	damage = 4,
	icon = 6,
	bulletEffect = 8,
	hitEffect = 9,
	target = 5,
	spellEffect = 7,
	id = 1,
	skillName = 2,
	skillDesc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	skillDesc = 2,
	skillName = 1
}

function lua_arcade_active_skill.onLoad(json)
	lua_arcade_active_skill.configList, lua_arcade_active_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_active_skill
