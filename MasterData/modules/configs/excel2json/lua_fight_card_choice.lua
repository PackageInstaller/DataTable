-- chunkname: @modules/configs/excel2json/lua_fight_card_choice.lua

module("modules.configs.excel2json.lua_fight_card_choice", package.seeall)

local lua_fight_card_choice = {}
local fields = {
	id = 1,
	choiceSkIlls = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_card_choice.onLoad(json)
	lua_fight_card_choice.configList, lua_fight_card_choice.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_card_choice
