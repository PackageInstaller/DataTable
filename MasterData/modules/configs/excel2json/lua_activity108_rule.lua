-- chunkname: @modules/configs/excel2json/lua_activity108_rule.lua

module("modules.configs.excel2json.lua_activity108_rule", package.seeall)

local lua_activity108_rule = {}
local fields = {
	rules = 2,
	id = 1,
	threat = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity108_rule.onLoad(json)
	lua_activity108_rule.configList, lua_activity108_rule.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity108_rule
