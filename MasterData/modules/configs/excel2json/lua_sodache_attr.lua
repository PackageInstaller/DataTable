-- chunkname: @modules/configs/excel2json/lua_sodache_attr.lua

module("modules.configs.excel2json.lua_sodache_attr", package.seeall)

local lua_sodache_attr = {}
local fields = {
	retain = 4,
	name = 2,
	init = 5,
	min = 6,
	id = 1,
	icon = 3,
	percent = 8,
	max = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_sodache_attr.onLoad(json)
	lua_sodache_attr.configList, lua_sodache_attr.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sodache_attr
