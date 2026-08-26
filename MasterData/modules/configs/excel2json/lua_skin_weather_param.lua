-- chunkname: @modules/configs/excel2json/lua_skin_weather_param.lua

module("modules.configs.excel2json.lua_skin_weather_param", package.seeall)

local lua_skin_weather_param = {}
local fields = {
	emissionColor3 = 12,
	bloomColor3 = 4,
	mainColor1 = 6,
	mainColor2 = 7,
	emissionColor1 = 10,
	bloomColor1 = 2,
	emissionColor4 = 13,
	bloomColor4 = 5,
	mainColor3 = 8,
	emissionColor2 = 11,
	bloomColor2 = 3,
	id = 1,
	mainColor4 = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_skin_weather_param.onLoad(json)
	lua_skin_weather_param.configList, lua_skin_weather_param.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_skin_weather_param
