-- chunkname: @modules/configs/excel2json/lua_tower_compose_mod.lua

module("modules.configs.excel2json.lua_tower_compose_mod", package.seeall)

local lua_tower_compose_mod = {}
local fields = {
	monsterChange = 11,
	name = 6,
	slotPart = 10,
	skillChange = 12,
	isUnlock = 8,
	careerChange = 16,
	career = 7,
	desc = 9,
	type = 4,
	themeId = 2,
	icon = 17,
	level = 3,
	ruleAdd = 14,
	image = 18,
	ruleChange = 15,
	slot = 5,
	passiveSkillAdd = 13,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_tower_compose_mod.onLoad(json)
	lua_tower_compose_mod.configList, lua_tower_compose_mod.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_compose_mod
