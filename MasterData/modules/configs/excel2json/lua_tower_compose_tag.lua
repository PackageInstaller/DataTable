-- chunkname: @modules/configs/excel2json/lua_tower_compose_tag.lua

module("modules.configs.excel2json.lua_tower_compose_tag", package.seeall)

local lua_tower_compose_tag = {}
local fields = {
	effects = 6,
	name = 3,
	themeId = 2,
	id = 1,
	icon = 4,
	desc = 5
}
local primaryKey = {
	"id",
	"themeId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_tower_compose_tag.onLoad(json)
	lua_tower_compose_tag.configList, lua_tower_compose_tag.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_compose_tag
