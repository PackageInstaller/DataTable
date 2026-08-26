-- chunkname: @modules/configs/excel2json/lua_tower_compose_point.lua

module("modules.configs.excel2json.lua_tower_compose_point", package.seeall)

local lua_tower_compose_point = {}
local fields = {
	bossPointBase = 4,
	bossPointAdd = 5,
	id = 1,
	round = 3,
	level = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_tower_compose_point.onLoad(json)
	lua_tower_compose_point.configList, lua_tower_compose_point.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_compose_point
