-- chunkname: @modules/configs/excel2json/lua_sodache_shop.lua

module("modules.configs.excel2json.lua_sodache_shop", package.seeall)

local lua_sodache_shop = {}
local fields = {
	id = 1,
	name = 2,
	type = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_sodache_shop.onLoad(json)
	lua_sodache_shop.configList, lua_sodache_shop.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sodache_shop
