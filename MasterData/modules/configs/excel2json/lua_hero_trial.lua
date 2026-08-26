-- chunkname: @modules/configs/excel2json/lua_hero_trial.lua

module("modules.configs.excel2json.lua_hero_trial", package.seeall)

local lua_hero_trial = {}
local fields = {
	equipRefine = 11,
	act104EquipId2 = 13,
	facetsId = 15,
	skin = 4,
	equipId = 9,
	heroId = 3,
	act104EquipId1 = 12,
	exSkillLv = 7,
	level = 6,
	attrId = 14,
	facetslevel = 16,
	trialTemplate = 2,
	trialType = 5,
	talent = 8,
	special = 17,
	id = 1,
	equipLv = 10
}
local primaryKey = {
	"id",
	"trialTemplate"
}
local mlStringKey = {}

function lua_hero_trial.onLoad(json)
	lua_hero_trial.configList, lua_hero_trial.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_trial
