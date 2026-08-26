-- chunkname: @modules/configs/excel2json/lua_fight_sp_card_mask_ly.lua

module("modules.configs.excel2json.lua_fight_sp_card_mask_ly", package.seeall)

local lua_fight_sp_card_mask_ly = {}
local fields = {
	id = 1,
	path = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_sp_card_mask_ly.onLoad(json)
	lua_fight_sp_card_mask_ly.configList, lua_fight_sp_card_mask_ly.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_sp_card_mask_ly
