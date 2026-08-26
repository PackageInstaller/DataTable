-- chunkname: @modules/configs/excel2json/lua_tower_compose_base.lua

module("modules.configs.excel2json.lua_tower_compose_base", package.seeall)

local lua_tower_compose_base = {}
local fields = {
	bossId = 3,
	isOnline = 7,
	themeIcon = 6,
	name = 4,
	supportHeroIds = 11,
	partIds = 9,
	extraHeroIds = 12,
	researchIds = 13,
	tagIds = 10,
	researchTaskGroupId = 2,
	auraIds = 8,
	themeId = 1,
	nameEn = 5
}
local primaryKey = {
	"themeId"
}
local mlStringKey = {
	name = 1
}

function lua_tower_compose_base.onLoad(json)
	lua_tower_compose_base.configList, lua_tower_compose_base.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_compose_base
