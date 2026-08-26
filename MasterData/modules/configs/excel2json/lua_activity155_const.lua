-- chunkname: @modules/configs/excel2json/lua_activity155_const.lua

module("modules.configs.excel2json.lua_activity155_const", package.seeall)

local lua_activity155_const = {}
local fields = {
	id = 1,
	value1 = 2,
	value2 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity155_const.onLoad(json)
	lua_activity155_const.configList, lua_activity155_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity155_const
