-- chunkname: @modules/configs/excel2json/lua_fight_dian_ji_shi_buff_effect.lua

module("modules.configs.excel2json.lua_fight_dian_ji_shi_buff_effect", package.seeall)

local lua_fight_dian_ji_shi_buff_effect = {}
local fields = {
	initEffectHang = 8,
	priority = 3,
	effectHang = 5,
	effect = 4,
	chargeEffect = 10,
	initEffectDuration = 9,
	buffTypeId = 2,
	chargeEffectDuration = 12,
	audioId = 6,
	initEffect = 7,
	chargeAudioId = 13,
	id = 1,
	chargeEffectHang = 11
}
local primaryKey = {
	"id",
	"buffTypeId"
}
local mlStringKey = {}

function lua_fight_dian_ji_shi_buff_effect.onLoad(json)
	lua_fight_dian_ji_shi_buff_effect.configList, lua_fight_dian_ji_shi_buff_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_dian_ji_shi_buff_effect
