-- chunkname: @modules/configs/excel2json/lua_rule.lua

module("modules.configs.excel2json.lua_rule", package.seeall)

local lua_rule = {}
local fields = {
	effect = 7,
	name = 5,
	type = 2,
	id = 1,
	icon = 3,
	iconTag = 4,
	desc = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_rule.onLoad(json)
	lua_rule.configList, lua_rule.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rule
