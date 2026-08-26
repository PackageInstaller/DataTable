-- chunkname: @modules/configs/excel2json/lua_hero3124_skill_talent.lua

module("modules.configs.excel2json.lua_hero3124_skill_talent", package.seeall)

local lua_hero3124_skill_talent = {}
local fields = {
	fieldActivateDesc = 9,
	name = 4,
	additionalFieldDesc4 = 34,
	exchangeSkills1 = 18,
	additionalFieldDesc3 = 28,
	fieldDesc2 = 20,
	newSkills2 = 23,
	fieldDesc3 = 26,
	fieldActivateDesc1 = 15,
	desc2 = 19,
	exchangeSkills3 = 30,
	newSkills1 = 17,
	fieldDesc = 8,
	icon = 5,
	newSkills3 = 29,
	level = 3,
	exchangeSkills2 = 24,
	fieldActivateDesc3 = 27,
	newSkills4 = 35,
	additionalFieldDesc = 10,
	sub = 2,
	exchangeSkills4 = 36,
	desc5 = 37,
	fieldDesc5 = 38,
	additionalFieldDesc5 = 40,
	exchangeSkills5 = 42,
	talentId = 1,
	desc3 = 25,
	desc1 = 13,
	desc4 = 31,
	desc = 7,
	fieldDesc1 = 14,
	fieldActivateDesc2 = 21,
	newSkills0 = 11,
	newSkills5 = 41,
	fieldActivateDesc5 = 39,
	additionalFieldDesc2 = 22,
	additionalFieldDesc1 = 16,
	fieldActivateDesc4 = 33,
	fieldName = 6,
	exchangeSkills0 = 12,
	fieldDesc4 = 32
}
local primaryKey = {
	"talentId"
}
local mlStringKey = {
	fieldActivateDesc = 5,
	name = 1,
	additionalFieldDesc4 = 22,
	desc1 = 7,
	additionalFieldDesc3 = 18,
	desc = 3,
	fieldDesc = 4,
	fieldDesc3 = 16,
	fieldActivateDesc1 = 9,
	desc2 = 11,
	desc4 = 19,
	fieldDesc1 = 8,
	fieldActivateDesc2 = 13,
	fieldDesc2 = 12,
	desc5 = 23,
	fieldDesc5 = 24,
	additionalFieldDesc5 = 26,
	fieldActivateDesc5 = 25,
	additionalFieldDesc = 6,
	fieldActivateDesc3 = 17,
	additionalFieldDesc2 = 14,
	additionalFieldDesc1 = 10,
	fieldActivateDesc4 = 21,
	fieldName = 2,
	fieldDesc4 = 20,
	desc3 = 15
}

function lua_hero3124_skill_talent.onLoad(json)
	lua_hero3124_skill_talent.configList, lua_hero3124_skill_talent.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero3124_skill_talent
