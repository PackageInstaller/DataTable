-- chunkname: @modules/configs/excel2json/lua_resistances_const.lua

module("modules.configs.excel2json.lua_resistances_const", package.seeall)

local lua_resistances_const = {}
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

function lua_resistances_const.onLoad(json)
	lua_resistances_const.configList, lua_resistances_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_resistances_const
