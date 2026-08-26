-- chunkname: @modules/configs/excel2json/lua_fight_sp_effect_alf_add_card.lua

module("modules.configs.excel2json.lua_fight_sp_effect_alf_add_card", package.seeall)

local lua_fight_sp_effect_alf_add_card = {}
local fields = {
	effect = 2,
	skinId = 1
}
local primaryKey = {
	"skinId"
}
local mlStringKey = {}

function lua_fight_sp_effect_alf_add_card.onLoad(json)
	lua_fight_sp_effect_alf_add_card.configList, lua_fight_sp_effect_alf_add_card.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_sp_effect_alf_add_card
