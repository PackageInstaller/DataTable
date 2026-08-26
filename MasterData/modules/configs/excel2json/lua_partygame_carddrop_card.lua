-- chunkname: @modules/configs/excel2json/lua_partygame_carddrop_card.lua

module("modules.configs.excel2json.lua_partygame_carddrop_card", package.seeall)

local lua_partygame_carddrop_card = {}
local fields = {
	variantType = 3,
	id = 1,
	timeline = 6,
	type = 2,
	power = 4,
	order = 7,
	desc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_partygame_carddrop_card.onLoad(json)
	lua_partygame_carddrop_card.configList, lua_partygame_carddrop_card.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_partygame_carddrop_card
