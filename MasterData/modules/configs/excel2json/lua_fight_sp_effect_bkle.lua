-- chunkname: @modules/configs/excel2json/lua_fight_sp_effect_bkle.lua

module("modules.configs.excel2json.lua_fight_sp_effect_bkle", package.seeall)

local lua_fight_sp_effect_bkle = {}
local fields = {
	audio = 5,
	buffId = 2,
	hangPoint = 4,
	id = 1,
	path = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_sp_effect_bkle.onLoad(json)
	lua_fight_sp_effect_bkle.configList, lua_fight_sp_effect_bkle.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_sp_effect_bkle
