-- chunkname: @modules/configs/excel2json/lua_tower_compose_aura.lua

module("modules.configs.excel2json.lua_tower_compose_aura", package.seeall)

local lua_tower_compose_aura = {}
local fields = {
	effects = 5,
	name = 4,
	themeId = 2,
	type = 8,
	id = 1,
	image = 3,
	icon = 6,
	desc = 7
}
local primaryKey = {
	"id",
	"themeId"
}
local mlStringKey = {
	type = 3,
	name = 1,
	desc = 2
}

function lua_tower_compose_aura.onLoad(json)
	lua_tower_compose_aura.configList, lua_tower_compose_aura.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_compose_aura
