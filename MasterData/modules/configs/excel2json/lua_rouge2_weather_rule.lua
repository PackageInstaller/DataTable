-- chunkname: @modules/configs/excel2json/lua_rouge2_weather_rule.lua

module("modules.configs.excel2json.lua_rouge2_weather_rule", package.seeall)

local lua_rouge2_weather_rule = {}
local fields = {
	id = 1,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_rouge2_weather_rule.onLoad(json)
	lua_rouge2_weather_rule.configList, lua_rouge2_weather_rule.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_weather_rule
