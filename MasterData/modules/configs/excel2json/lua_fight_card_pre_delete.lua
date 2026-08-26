-- chunkname: @modules/configs/excel2json/lua_fight_card_pre_delete.lua

module("modules.configs.excel2json.lua_fight_card_pre_delete", package.seeall)

local lua_fight_card_pre_delete = {}
local fields = {
	skillID = 1,
	left = 2,
	right = 3
}
local primaryKey = {
	"skillID"
}
local mlStringKey = {}

function lua_fight_card_pre_delete.onLoad(json)
	lua_fight_card_pre_delete.configList, lua_fight_card_pre_delete.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_card_pre_delete
