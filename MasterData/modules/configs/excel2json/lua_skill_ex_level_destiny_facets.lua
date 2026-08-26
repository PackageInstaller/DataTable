-- chunkname: @modules/configs/excel2json/lua_skill_ex_level_destiny_facets.lua

module("modules.configs.excel2json.lua_skill_ex_level_destiny_facets", package.seeall)

local lua_skill_ex_level_destiny_facets = {}
local fields = {
	skillEx = 6,
	passiveSkill = 7,
	desc = 3,
	facetsId = 1,
	skillLevel = 2,
	skillGroup2 = 5,
	skillGroup1 = 4
}
local primaryKey = {
	"facetsId",
	"skillLevel"
}
local mlStringKey = {
	desc = 1
}

function lua_skill_ex_level_destiny_facets.onLoad(json)
	lua_skill_ex_level_destiny_facets.configList, lua_skill_ex_level_destiny_facets.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_skill_ex_level_destiny_facets
