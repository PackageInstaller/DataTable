-- chunkname: @modules/configs/excel2json/lua_language_prefab.lua

module("modules.configs.excel2json.lua_language_prefab", package.seeall)

local lua_language_prefab = {}
local fields = {
	id = 1,
	lang = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	lang = 1
}

function lua_language_prefab.onLoad(json)
	lua_language_prefab.configList, lua_language_prefab.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_language_prefab
