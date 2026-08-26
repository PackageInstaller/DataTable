-- chunkname: @modules/configs/excel2json/lua_hero_trial_attr.lua

module("modules.configs.excel2json.lua_hero_trial_attr", package.seeall)

local lua_hero_trial_attr = {}
local fields = {
	defense = 9,
	name = 2,
	technic = 11,
	dropDmg = 17,
	uniqueSkill = 5,
	activeSkill = 3,
	addDmg = 16,
	criDmg = 14,
	attack = 8,
	criDef = 15,
	passiveSkill = 4,
	cri = 12,
	mdefense = 10,
	recri = 13,
	noShowExSkill = 6,
	life = 7,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_hero_trial_attr.onLoad(json)
	lua_hero_trial_attr.configList, lua_hero_trial_attr.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_trial_attr
