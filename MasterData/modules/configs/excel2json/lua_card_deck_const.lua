-- chunkname: @modules/configs/excel2json/lua_card_deck_const.lua

module("modules.configs.excel2json.lua_card_deck_const", package.seeall)

local lua_card_deck_const = {}
local fields = {
	id = 1,
	value = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_card_deck_const.onLoad(json)
	lua_card_deck_const.configList, lua_card_deck_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_card_deck_const
