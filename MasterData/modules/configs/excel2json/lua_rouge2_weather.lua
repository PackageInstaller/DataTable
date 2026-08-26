-- chunkname: @modules/configs/excel2json/lua_rouge2_weather.lua

module("modules.configs.excel2json.lua_rouge2_weather", package.seeall)

local lua_rouge2_weather = {}
local fields = {
	id = 1,
	title = 2,
	icon = 3,
	pathSelectWeatherUrl = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	title = 1
}

function lua_rouge2_weather.onLoad(json)
	lua_rouge2_weather.configList, lua_rouge2_weather.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_weather
