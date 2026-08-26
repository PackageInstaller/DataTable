-- chunkname: @modules/configs/excel2json/lua_weather_report.lua

module("modules.configs.excel2json.lua_weather_report", package.seeall)

local lua_weather_report = {}
local fields = {
	audioLength = 6,
	effect = 4,
	roomMode = 5,
	id = 1,
	lightMode = 2,
	roleMode = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_weather_report.onLoad(json)
	lua_weather_report.configList, lua_weather_report.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_weather_report
