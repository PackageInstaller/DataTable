-- chunkname: @modules/configs/excel2json/lua_udimo_const.lua

module("modules.configs.excel2json.lua_udimo_const", package.seeall)

local lua_udimo_const = {}
local fields = {
	value = 2,
	id = 1,
	value2 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_udimo_const.onLoad(json)
	lua_udimo_const.configList, lua_udimo_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_udimo_const
