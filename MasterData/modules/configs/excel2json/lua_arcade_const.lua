-- chunkname: @modules/configs/excel2json/lua_arcade_const.lua

module("modules.configs.excel2json.lua_arcade_const", package.seeall)

local lua_arcade_const = {}
local fields = {
	value = 2,
	id = 1,
	mlvalue = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	mlvalue = 1
}

function lua_arcade_const.onLoad(json)
	lua_arcade_const.configList, lua_arcade_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_const
