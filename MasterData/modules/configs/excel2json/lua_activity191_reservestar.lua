-- chunkname: @modules/configs/excel2json/lua_activity191_reservestar.lua

module("modules.configs.excel2json.lua_activity191_reservestar", package.seeall)

local lua_activity191_reservestar = {}
local fields = {
	id = 1,
	attribute = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity191_reservestar.onLoad(json)
	lua_activity191_reservestar.configList, lua_activity191_reservestar.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity191_reservestar
