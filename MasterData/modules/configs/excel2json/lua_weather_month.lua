-- chunkname: @modules/configs/excel2json/lua_weather_month.lua

module("modules.configs.excel2json.lua_weather_month", package.seeall)

local lua_weather_month = {}
local fields = {
	id = 1,
	weekList = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_weather_month.onLoad(json)
	lua_weather_month.configList, lua_weather_month.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_weather_month
