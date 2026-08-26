-- chunkname: @modules/configs/excel2json/lua_assassin_career_skill_mapping.lua

module("modules.configs.excel2json.lua_assassin_career_skill_mapping", package.seeall)

local lua_assassin_career_skill_mapping = {}
local fields = {
	targetCheck = 11,
	name = 4,
	prerequisite = 14,
	type = 8,
	addSkill = 7,
	targetEff = 13,
	id = 1,
	desc = 6,
	range = 10,
	icon = 5,
	cost = 9,
	effect = 16,
	timesLimit = 18,
	roundLimit = 17,
	target = 12,
	assassinHeroId = 3,
	careerId = 2,
	triggerNode = 15
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_assassin_career_skill_mapping.onLoad(json)
	lua_assassin_career_skill_mapping.configList, lua_assassin_career_skill_mapping.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_assassin_career_skill_mapping
