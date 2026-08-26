-- chunkname: @modules/configs/excel2json/lua_stress_rule.lua

module("modules.configs.excel2json.lua_stress_rule", package.seeall)

local lua_stress_rule = {}
local fields = {
	param = 5,
	targetLimit = 4,
	type = 2,
	id = 1,
	isNoShow = 6,
	target = 3,
	desc = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_stress_rule.onLoad(json)
	lua_stress_rule.configList, lua_stress_rule.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_stress_rule
