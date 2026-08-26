-- chunkname: @modules/configs/excel2json/lua_fight_sp_effect_ly.lua

module("modules.configs.excel2json.lua_fight_sp_effect_ly", package.seeall)

local lua_fight_sp_effect_ly = {}
local fields = {
	spine1EffectRes = 5,
	spine2Res = 6,
	fadeAudioId = 9,
	spine1Res = 4,
	pos = 3,
	path = 2,
	audioId = 8,
	spine2EffectRes = 7,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_sp_effect_ly.onLoad(json)
	lua_fight_sp_effect_ly.configList, lua_fight_sp_effect_ly.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_sp_effect_ly
