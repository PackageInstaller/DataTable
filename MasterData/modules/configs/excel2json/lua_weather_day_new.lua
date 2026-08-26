-- chunkname: @modules/configs/excel2json/lua_weather_day_new.lua

module("modules.configs.excel2json.lua_weather_day_new", package.seeall)

local lua_weather_day_new = {}
local fields = {
	id = 2,
	sceneId = 1,
	reportList = 3
}
local primaryKey = {
	"sceneId",
	"id"
}
local mlStringKey = {}

function lua_weather_day_new.onLoad(json)
	lua_weather_day_new.configList, lua_weather_day_new.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_weather_day_new
