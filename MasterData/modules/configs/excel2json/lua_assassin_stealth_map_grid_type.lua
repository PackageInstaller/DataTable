-- chunkname: @modules/configs/excel2json/lua_assassin_stealth_map_grid_type.lua

module("modules.configs.excel2json.lua_assassin_stealth_map_grid_type", package.seeall)

local lua_assassin_stealth_map_grid_type = {}
local fields = {
	id = 1,
	name = 2,
	icon = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_assassin_stealth_map_grid_type.onLoad(json)
	lua_assassin_stealth_map_grid_type.configList, lua_assassin_stealth_map_grid_type.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_assassin_stealth_map_grid_type
