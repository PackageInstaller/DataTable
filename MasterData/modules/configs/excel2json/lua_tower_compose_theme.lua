-- chunkname: @modules/configs/excel2json/lua_tower_compose_theme.lua

module("modules.configs.excel2json.lua_tower_compose_theme", package.seeall)

local lua_tower_compose_theme = {}
local fields = {
	monsterGroupId = 3,
	name = 8,
	themeIcon = 10,
	nameEn = 9,
	modOffset = 5,
	spineOffset = 4,
	career = 14,
	isOnline = 13,
	orderLayer = 6,
	themeDesc = 11,
	modNum = 2,
	heroIds = 15,
	id = 1,
	pointIcon = 12,
	initEnv = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_tower_compose_theme.onLoad(json)
	lua_tower_compose_theme.configList, lua_tower_compose_theme.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_compose_theme
