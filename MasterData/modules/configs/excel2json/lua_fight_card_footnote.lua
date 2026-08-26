-- chunkname: @modules/configs/excel2json/lua_fight_card_footnote.lua

module("modules.configs.excel2json.lua_fight_card_footnote", package.seeall)

local lua_fight_card_footnote = {}
local fields = {
	id = 1,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_fight_card_footnote.onLoad(json)
	lua_fight_card_footnote.configList, lua_fight_card_footnote.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_card_footnote
