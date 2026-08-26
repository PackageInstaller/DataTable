-- chunkname: @modules/configs/excel2json/lua_production_line_level.lua

module("modules.configs.excel2json.lua_production_line_level", package.seeall)

local lua_production_line_level = {}
local fields = {
	cost = 4,
	effect = 3,
	changeFormulaId = 5,
	id = 2,
	groupId = 1,
	icon = 7,
	needRoomLevel = 8,
	modulePart = 6
}
local primaryKey = {
	"groupId",
	"id"
}
local mlStringKey = {}

function lua_production_line_level.onLoad(json)
	lua_production_line_level.configList, lua_production_line_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_production_line_level
