-- chunkname: @modules/configs/excel2json/lua_udimo_temperature.lua

module("modules.configs.excel2json.lua_udimo_temperature", package.seeall)

local lua_udimo_temperature = {}
local fields = {
	udimoWeatherId = 1,
	temperature = 2,
	description = 3
}
local primaryKey = {
	"udimoWeatherId",
	"temperature"
}
local mlStringKey = {
	description = 1
}

function lua_udimo_temperature.onLoad(json)
	lua_udimo_temperature.configList, lua_udimo_temperature.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_udimo_temperature
