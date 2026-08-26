-- chunkname: @modules/configs/excel2json/lua_sodache_open.lua

module("modules.configs.excel2json.lua_sodache_open", package.seeall)

local lua_sodache_open = {}
local fields = {
	id = 1,
	condition = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_sodache_open.onLoad(json)
	lua_sodache_open.configList, lua_sodache_open.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sodache_open
