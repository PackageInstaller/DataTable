-- chunkname: @modules/configs/excel2json/lua_strong_hold_rule.lua

module("modules.configs.excel2json.lua_strong_hold_rule", package.seeall)

local lua_strong_hold_rule = {}
local fields = {
	skillIds = 6,
	id = 1,
	fixValue = 4,
	desc = 2,
	prohibitSkillTags = 5,
	fixType = 3,
	addSkillIds = 7,
	effectIds = 8,
	putLimit = 9,
	startEffectRound = 10,
	endEffectRound = 11
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_strong_hold_rule.onLoad(json)
	lua_strong_hold_rule.configList, lua_strong_hold_rule.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_strong_hold_rule
