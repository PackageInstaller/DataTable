-- chunkname: @modules/configs/excel2json/lua_match3_skill_effect.lua

module("modules.configs.excel2json.lua_match3_skill_effect", package.seeall)

local lua_match3_skill_effect = {}
local fields = {
	effectId = 1,
	param2 = 7,
	targetType = 4,
	param1 = 6,
	rangeType = 5,
	desc = 10,
	effectGroupId = 2,
	effectType = 3,
	countChain = 8,
	countFever = 9
}
local primaryKey = {
	"effectId"
}
local mlStringKey = {
	desc = 1
}

function lua_match3_skill_effect.onLoad(json)
	lua_match3_skill_effect.configList, lua_match3_skill_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_match3_skill_effect
