-- chunkname: @modules/configs/excel2json/lua_sodache_unlock.lua

module("modules.configs.excel2json.lua_sodache_unlock", package.seeall)

local lua_sodache_unlock = {}
local fields = {
	id = 1,
	condition = 2,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_sodache_unlock.onLoad(json)
	lua_sodache_unlock.configList, lua_sodache_unlock.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sodache_unlock
