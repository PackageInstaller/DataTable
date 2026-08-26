-- chunkname: @modules/configs/excel2json/lua_tower_compose_research.lua

module("modules.configs.excel2json.lua_tower_compose_research", package.seeall)

local lua_tower_compose_research = {}
local fields = {
	themeId = 2,
	name = 4,
	exLevel = 8,
	additionRule = 7,
	id = 1,
	req = 3,
	icon = 6,
	desc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	icon = 3,
	name = 1,
	desc = 2
}

function lua_tower_compose_research.onLoad(json)
	lua_tower_compose_research.configList, lua_tower_compose_research.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_compose_research
