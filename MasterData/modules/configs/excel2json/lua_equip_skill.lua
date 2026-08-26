-- chunkname: @modules/configs/excel2json/lua_equip_skill.lua

module("modules.configs.excel2json.lua_equip_skill", package.seeall)

local lua_equip_skill = {}
local fields = {
	skill = 3,
	skill2 = 4,
	skillHide = 5,
	dropDmg = 16,
	heal = 17,
	defenseIgnore = 19,
	career = 6,
	absorb = 20,
	addDmg = 15,
	normalSkillRate = 21,
	baseDesc = 7,
	criDmg = 13,
	attack = 9,
	criDef = 14,
	clutch = 22,
	skillLv = 2,
	baseDesc2 = 23,
	cri = 11,
	revive = 18,
	recri = 12,
	condition = 8,
	hp = 10,
	id = 1
}
local primaryKey = {
	"id",
	"skillLv"
}
local mlStringKey = {
	baseDesc = 1,
	baseDesc2 = 2
}

function lua_equip_skill.onLoad(json)
	lua_equip_skill.configList, lua_equip_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_equip_skill
