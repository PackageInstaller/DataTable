-- chunkname: @modules/configs/excel2json/lua_tower_compose_extra.lua

module("modules.configs.excel2json.lua_tower_compose_extra", package.seeall)

local lua_tower_compose_extra = {}
local fields = {
	themeId = 2,
	id = 1,
	bossPointBase = 3
}
local primaryKey = {
	"id",
	"themeId"
}
local mlStringKey = {}

function lua_tower_compose_extra.onLoad(json)
	lua_tower_compose_extra.configList, lua_tower_compose_extra.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_compose_extra
