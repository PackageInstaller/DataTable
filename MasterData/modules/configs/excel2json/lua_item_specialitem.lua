-- chunkname: @modules/configs/excel2json/lua_item_specialitem.lua

module("modules.configs.excel2json.lua_item_specialitem", package.seeall)

local lua_item_specialitem = {}
local fields = {
	name = 2,
	id = 1,
	icon = 3,
	rare = 5,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_item_specialitem.onLoad(json)
	lua_item_specialitem.configList, lua_item_specialitem.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_item_specialitem
