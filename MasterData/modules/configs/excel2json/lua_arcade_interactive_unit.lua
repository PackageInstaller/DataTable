-- chunkname: @modules/configs/excel2json/lua_arcade_interactive_unit.lua

module("modules.configs.excel2json.lua_arcade_interactive_unit", package.seeall)

local lua_arcade_interactive_unit = {}
local fields = {
	optionID = 10,
	name = 2,
	effectAfter = 9,
	type = 3,
	grid = 12,
	nodePortalLimit = 5,
	pos = 13,
	desc = 4,
	sceneIcon = 19,
	effectActing = 8,
	icon = 18,
	resPath = 14,
	spbehaviorID = 11,
	limit = 6,
	posOffset = 16,
	category = 17,
	id = 1,
	scale = 15,
	effectBefore = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_arcade_interactive_unit.onLoad(json)
	lua_arcade_interactive_unit.configList, lua_arcade_interactive_unit.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_interactive_unit
