-- chunkname: @modules/configs/excel2json/lua_strong_hold_rule_effect.lua

module("modules.configs.excel2json.lua_strong_hold_rule_effect", package.seeall)

local lua_strong_hold_rule_effect = {}
local fields = {
	effectName = 2,
	effectParams = 3,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_strong_hold_rule_effect.onLoad(json)
	lua_strong_hold_rule_effect.configList, lua_strong_hold_rule_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_strong_hold_rule_effect
