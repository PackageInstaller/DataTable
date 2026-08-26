-- chunkname: @modules/configs/excel2json/lua_partygame_carddrop_cardtype.lua

module("modules.configs.excel2json.lua_partygame_carddrop_cardtype", package.seeall)

local lua_partygame_carddrop_cardtype = {}
local fields = {
	name = 2,
	loseIcon = 5,
	id = 1,
	icon = 3,
	selectedMask = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_partygame_carddrop_cardtype.onLoad(json)
	lua_partygame_carddrop_cardtype.configList, lua_partygame_carddrop_cardtype.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_partygame_carddrop_cardtype
