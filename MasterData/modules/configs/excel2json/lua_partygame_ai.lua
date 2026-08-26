-- chunkname: @modules/configs/excel2json/lua_partygame_ai.lua

module("modules.configs.excel2json.lua_partygame_ai", package.seeall)

local lua_partygame_ai = {}
local fields = {
	id = 1,
	name = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_partygame_ai.onLoad(json)
	lua_partygame_ai.configList, lua_partygame_ai.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_partygame_ai
