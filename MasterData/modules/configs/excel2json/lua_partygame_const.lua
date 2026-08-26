-- chunkname: @modules/configs/excel2json/lua_partygame_const.lua

module("modules.configs.excel2json.lua_partygame_const", package.seeall)

local lua_partygame_const = {}
local fields = {
	id = 1,
	value = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_partygame_const.onLoad(json)
	lua_partygame_const.configList, lua_partygame_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_partygame_const
