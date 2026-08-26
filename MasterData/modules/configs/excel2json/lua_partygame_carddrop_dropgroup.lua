-- chunkname: @modules/configs/excel2json/lua_partygame_carddrop_dropgroup.lua

module("modules.configs.excel2json.lua_partygame_carddrop_dropgroup", package.seeall)

local lua_partygame_carddrop_dropgroup = {}
local fields = {
	dropGroup = 2,
	id = 1,
	weight = 4,
	cardId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_partygame_carddrop_dropgroup.onLoad(json)
	lua_partygame_carddrop_dropgroup.configList, lua_partygame_carddrop_dropgroup.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_partygame_carddrop_dropgroup
