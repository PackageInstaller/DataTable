-- chunkname: @modules/configs/excel2json/lua_sodache_const.lua

module("modules.configs.excel2json.lua_sodache_const", package.seeall)

local lua_sodache_const = {}
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

function lua_sodache_const.onLoad(json)
	lua_sodache_const.configList, lua_sodache_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sodache_const
