-- chunkname: @modules/configs/excel2json/lua_udimo_weather.lua

module("modules.configs.excel2json.lua_udimo_weather", package.seeall)

local lua_udimo_weather = {}
local fields = {
	color = 6,
	effect = 7,
	name = 4,
	minTemperature = 10,
	weatherIds = 2,
	maxTemperature = 11,
	windLevel = 3,
	audioId = 8,
	stopAudioId = 9,
	id = 1,
	icon = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_udimo_weather.onLoad(json)
	lua_udimo_weather.configList, lua_udimo_weather.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_udimo_weather
