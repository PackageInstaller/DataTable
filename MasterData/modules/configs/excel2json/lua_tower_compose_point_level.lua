-- chunkname: @modules/configs/excel2json/lua_tower_compose_point_level.lua

module("modules.configs.excel2json.lua_tower_compose_point_level", package.seeall)

local lua_tower_compose_point_level = {}
local fields = {
	bossPointBase = 2,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}

function lua_tower_compose_point_level.onLoad(json)
	lua_tower_compose_point_level.configList, lua_tower_compose_point_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_compose_point_level
