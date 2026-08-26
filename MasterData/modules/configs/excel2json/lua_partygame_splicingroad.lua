-- chunkname: @modules/configs/excel2json/lua_partygame_splicingroad.lua

module("modules.configs.excel2json.lua_partygame_splicingroad", package.seeall)

local lua_partygame_splicingroad = {}
local fields = {
	id = 1,
	map = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_partygame_splicingroad.onLoad(json)
	lua_partygame_splicingroad.configList, lua_partygame_splicingroad.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_partygame_splicingroad
