-- chunkname: @modules/configs/excel2json/lua_activity149_const.lua

module("modules.configs.excel2json.lua_activity149_const", package.seeall)

local lua_activity149_const = {}
local fields = {
	id = 1,
	value = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity149_const.onLoad(json)
	lua_activity149_const.configList, lua_activity149_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity149_const
