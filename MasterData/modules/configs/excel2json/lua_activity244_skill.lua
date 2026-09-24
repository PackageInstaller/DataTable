-- chunkname: @modules/configs/excel2json/lua_activity244_skill.lua

module("modules.configs.excel2json.lua_activity244_skill", package.seeall)

local lua_activity244_skill = {}
local fields = {
	effect1 = 9,
	name = 3,
	targrt1 = 8,
	condition3 = 13,
	effect3 = 15,
	effectType = 5,
	effect4 = 18,
	desc = 4,
	skillId = 1,
	condition2 = 10,
	effect2 = 12,
	targrt3 = 14,
	targrt4 = 17,
	skillType = 2,
	targrt2 = 11,
	energyCost = 6,
	condition4 = 16,
	condition1 = 7
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity244_skill.onLoad(json)
	lua_activity244_skill.configList, lua_activity244_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity244_skill
