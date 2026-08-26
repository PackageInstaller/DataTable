-- chunkname: @modules/configs/excel2json/lua_stress_const.lua

module("modules.configs.excel2json.lua_stress_const", package.seeall)

local lua_stress_const = {}
local fields = {
	value = 2,
	id = 1,
	value2 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	value2 = 1
}

function lua_stress_const.onLoad(json)
	lua_stress_const.configList, lua_stress_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_stress_const
