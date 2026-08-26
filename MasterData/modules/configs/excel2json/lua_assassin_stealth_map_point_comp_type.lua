-- chunkname: @modules/configs/excel2json/lua_assassin_stealth_map_point_comp_type.lua

module("modules.configs.excel2json.lua_assassin_stealth_map_point_comp_type", package.seeall)

local lua_assassin_stealth_map_point_comp_type = {}
local fields = {
	id = 1,
	name = 2,
	icon = 3,
	smallIcon = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_assassin_stealth_map_point_comp_type.onLoad(json)
	lua_assassin_stealth_map_point_comp_type.configList, lua_assassin_stealth_map_point_comp_type.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_assassin_stealth_map_point_comp_type
