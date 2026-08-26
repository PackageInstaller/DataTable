-- chunkname: @modules/configs/excel2json/lua_monster.lua

module("modules.configs.excel2json.lua_monster", package.seeall)

local lua_monster = {}
local fields = {
	initial_uniqueSkill_point = 11,
	highPriorityName = 20,
	levelEasy = 24,
	uniqueSkillLevel = 12,
	skillTemplate = 3,
	skinId = 4,
	career = 6,
	level_true = 10,
	effectHangPoint = 19,
	heartVariantId = 8,
	hpSign = 16,
	highPriorityNameEng = 21,
	career_weak = 7,
	toughness = 25,
	templateEasy = 23,
	level = 9,
	label = 5,
	effect = 18,
	passiveSkillsEx = 14,
	energySign = 17,
	highPriorityDes = 22,
	uiFilterSkill = 15,
	toughnessSkill = 26,
	passiveSkillCount = 13,
	template = 2,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	highPriorityDes = 2,
	highPriorityName = 1
}

function lua_monster.onLoad(json)
	lua_monster.configList, lua_monster.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_monster
