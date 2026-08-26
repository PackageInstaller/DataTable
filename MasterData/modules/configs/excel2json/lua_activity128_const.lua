-- chunkname: @modules/configs/excel2json/lua_activity128_const.lua

module("modules.configs.excel2json.lua_activity128_const", package.seeall)

local lua_activity128_const = {}
local fields = {
	id = 1,
	value1 = 2,
	value2 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity128_const.onLoad(json)
	lua_activity128_const.configList, lua_activity128_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity128_const
