-- chunkname: @modules/configs/excel2json/lua_weekwalk_rule.lua

module("modules.configs.excel2json.lua_weekwalk_rule", package.seeall)

local lua_weekwalk_rule = {}
local fields = {
	id = 1,
	icon = 2,
	isCn = 4,
	additionRule = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_weekwalk_rule.onLoad(json)
	lua_weekwalk_rule.configList, lua_weekwalk_rule.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_weekwalk_rule
