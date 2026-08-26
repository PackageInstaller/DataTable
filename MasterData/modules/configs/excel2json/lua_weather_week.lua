-- chunkname: @modules/configs/excel2json/lua_weather_week.lua

module("modules.configs.excel2json.lua_weather_week", package.seeall)

local lua_weather_week = {}
local fields = {
	id = 1,
	day6 = 7,
	day4 = 5,
	day5 = 6,
	day3 = 4,
	day1 = 2,
	day7 = 8,
	day2 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_weather_week.onLoad(json)
	lua_weather_week.configList, lua_weather_week.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_weather_week
