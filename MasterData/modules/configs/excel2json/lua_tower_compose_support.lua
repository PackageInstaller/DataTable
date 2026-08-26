-- chunkname: @modules/configs/excel2json/lua_tower_compose_support.lua

module("modules.configs.excel2json.lua_tower_compose_support", package.seeall)

local lua_tower_compose_support = {}
local fields = {
	resMaxVal = 13,
	heroTag = 6,
	id = 1,
	activeSkills = 9,
	passiveSkills = 10,
	resInitVal = 12,
	extraRule = 11,
	desc = 7,
	activeType = 5,
	heroId = 2,
	themeId = 3,
	coldTime = 8,
	lv = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_tower_compose_support.onLoad(json)
	lua_tower_compose_support.configList, lua_tower_compose_support.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_compose_support
