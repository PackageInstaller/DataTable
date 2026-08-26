-- chunkname: @modules/configs/excel2json/lua_skill_talent.lua

module("modules.configs.excel2json.lua_skill_talent", package.seeall)

local lua_skill_talent = {}
local fields = {
	newSkills0 = 6,
	newSkills5 = 16,
	newSkills2 = 10,
	exchangeSkills4 = 13,
	sub = 2,
	newSkills3 = 12,
	exchangeSkills1 = 7,
	desc = 4,
	exchangeSkills3 = 11,
	newSkills4 = 14,
	newSkills1 = 8,
	exchangeSkills2 = 9,
	exchangeSkills0 = 5,
	exchangeSkills5 = 15,
	talentId = 1,
	level = 3
}
local primaryKey = {
	"talentId",
	"sub"
}
local mlStringKey = {
	desc = 1
}

function lua_skill_talent.onLoad(json)
	lua_skill_talent.configList, lua_skill_talent.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_skill_talent
