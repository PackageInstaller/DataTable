-- chunkname: @modules/configs/excel2json/lua_fight_sp_wuerlixi_monster_star_effect.lua

module("modules.configs.excel2json.lua_fight_sp_wuerlixi_monster_star_effect", package.seeall)

local lua_fight_sp_wuerlixi_monster_star_effect = {}
local fields = {
	bornEffectDuration = 5,
	effect = 2,
	buffId = 1,
	disAppearEffectDuration = 7,
	disAppearEffect = 6,
	bornEffect = 4,
	height = 3
}
local primaryKey = {
	"buffId"
}
local mlStringKey = {}

function lua_fight_sp_wuerlixi_monster_star_effect.onLoad(json)
	lua_fight_sp_wuerlixi_monster_star_effect.configList, lua_fight_sp_wuerlixi_monster_star_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_sp_wuerlixi_monster_star_effect
