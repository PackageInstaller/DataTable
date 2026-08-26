-- chunkname: @modules/configs/excel2json/lua_sodache_item.lua

module("modules.configs.excel2json.lua_sodache_item", package.seeall)

local lua_sodache_item = {}
local fields = {
	dropWeight = 7,
	name = 2,
	dropPrice = 6,
	type = 3,
	id = 1,
	icon = 4,
	maxStack = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_sodache_item.onLoad(json)
	lua_sodache_item.configList, lua_sodache_item.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sodache_item
