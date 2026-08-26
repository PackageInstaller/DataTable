-- chunkname: @modules/configs/excel2json/lua_fight_next_round_get_card.lua

module("modules.configs.excel2json.lua_fight_next_round_get_card", package.seeall)

local lua_fight_next_round_get_card = {}
local fields = {
	exclusion = 5,
	priority = 2,
	tempCard = 6,
	skillId = 4,
	id = 1,
	condition = 3
}
local primaryKey = {
	"id",
	"priority"
}
local mlStringKey = {}

function lua_fight_next_round_get_card.onLoad(json)
	lua_fight_next_round_get_card.configList, lua_fight_next_round_get_card.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_next_round_get_card
