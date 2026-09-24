-- chunkname: @modules/configs/excel2json/lua_activity244_character_skill.lua

module("modules.configs.excel2json.lua_activity244_character_skill", package.seeall)

local lua_activity244_character_skill = {}
local fields = {
	effect1 = 16,
	name = 3,
	skillText = 5,
	target1 = 15,
	effectPos = 9,
	rangesize = 8,
	condition3 = 20,
	desc = 6,
	effect3 = 22,
	condition4 = 23,
	target4 = 24,
	skillId = 1,
	effect4 = 25,
	condition2 = 17,
	effect2 = 19,
	initialEnergy = 12,
	target2 = 18,
	rangeType = 7,
	skillType = 2,
	target3 = 21,
	energyCost = 13,
	effectType = 11,
	skillTag = 10,
	condition1 = 14,
	skillTextType = 4
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {
	skillText = 2,
	name = 1,
	skillTag = 4,
	desc = 3
}

function lua_activity244_character_skill.onLoad(json)
	lua_activity244_character_skill.configList, lua_activity244_character_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity244_character_skill
