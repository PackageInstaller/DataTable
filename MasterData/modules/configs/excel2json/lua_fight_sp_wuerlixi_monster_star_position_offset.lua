-- chunkname: @modules/configs/excel2json/lua_fight_sp_wuerlixi_monster_star_position_offset.lua

module("modules.configs.excel2json.lua_fight_sp_wuerlixi_monster_star_position_offset", package.seeall)

local lua_fight_sp_wuerlixi_monster_star_position_offset = {}
local fields = {
	offsetY = 3,
	monsterId = 1,
	offsetX = 2
}
local primaryKey = {
	"monsterId"
}
local mlStringKey = {}

function lua_fight_sp_wuerlixi_monster_star_position_offset.onLoad(json)
	lua_fight_sp_wuerlixi_monster_star_position_offset.configList, lua_fight_sp_wuerlixi_monster_star_position_offset.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_sp_wuerlixi_monster_star_position_offset
