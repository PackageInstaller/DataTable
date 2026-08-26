-- chunkname: @modules/configs/excel2json/lua_monster_skill_template.lua

module("modules.configs.excel2json.lua_monster_skill_template", package.seeall)

local lua_monster_skill_template = {}
local fields = {
	uniqueSkill_point = 14,
	name = 2,
	gender = 7,
	career = 8,
	uniqueSkill = 13,
	skin = 15,
	nameEng = 3,
	baseStress = 20,
	race = 23,
	camp = 19,
	dmgType = 10,
	identity = 22,
	career_weak = 9,
	activeSkill = 12,
	powerMax = 17,
	des = 4,
	passiveSkill = 11,
	instance = 6,
	property = 18,
	resistance = 16,
	template = 5,
	id = 1,
	maxStress = 21
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	property = 3,
	name = 1,
	des = 2
}

function lua_monster_skill_template.onLoad(json)
	lua_monster_skill_template.configList, lua_monster_skill_template.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_monster_skill_template
