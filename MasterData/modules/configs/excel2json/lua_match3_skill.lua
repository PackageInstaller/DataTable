-- chunkname: @modules/configs/excel2json/lua_match3_skill.lua

module("modules.configs.excel2json.lua_match3_skill", package.seeall)

local lua_match3_skill = {}
local fields = {
	energyCost = 4,
	name = 3,
	triggerType = 5,
	skillId = 1,
	desc = 7,
	skillType = 2,
	effectGroupId = 6
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_match3_skill.onLoad(json)
	lua_match3_skill.configList, lua_match3_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_match3_skill
