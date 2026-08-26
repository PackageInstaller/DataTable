-- chunkname: @modules/configs/excel2json/lua_survival_rain.lua

module("modules.configs.excel2json.lua_survival_rain", package.seeall)

local lua_survival_rain = {}
local fields = {
	id = 1,
	name = 3,
	rainDesc = 4,
	type = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	rainDesc = 2,
	name = 1
}

function lua_survival_rain.onLoad(json)
	lua_survival_rain.configList, lua_survival_rain.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_rain
