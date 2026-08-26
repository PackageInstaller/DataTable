-- chunkname: @modules/configs/excel2json/lua_ai_monster_card_tag.lua

module("modules.configs.excel2json.lua_ai_monster_card_tag", package.seeall)

local lua_ai_monster_card_tag = {}
local fields = {
	id = 1,
	lineColor = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_ai_monster_card_tag.onLoad(json)
	lua_ai_monster_card_tag.configList, lua_ai_monster_card_tag.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_ai_monster_card_tag
