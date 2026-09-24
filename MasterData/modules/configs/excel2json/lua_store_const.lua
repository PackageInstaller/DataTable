-- chunkname: @modules/configs/excel2json/lua_store_const.lua

module("modules.configs.excel2json.lua_store_const", package.seeall)

local lua_store_const = {}
local fields = {
	id = 1,
	strValue = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_store_const.onLoad(json)
	lua_store_const.configList, lua_store_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_store_const
