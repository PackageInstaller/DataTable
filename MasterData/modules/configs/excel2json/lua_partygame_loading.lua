-- chunkname: @modules/configs/excel2json/lua_partygame_loading.lua

module("modules.configs.excel2json.lua_partygame_loading", package.seeall)

local lua_partygame_loading = {}
local fields = {
	id = 1,
	des = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	des = 1
}

function lua_partygame_loading.onLoad(json)
	lua_partygame_loading.configList, lua_partygame_loading.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_partygame_loading
