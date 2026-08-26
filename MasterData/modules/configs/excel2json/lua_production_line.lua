-- chunkname: @modules/configs/excel2json/lua_production_line.lua

module("modules.configs.excel2json.lua_production_line", package.seeall)

local lua_production_line = {}
local fields = {
	reserve = 5,
	name = 2,
	logic = 4,
	type = 3,
	id = 1,
	initFormula = 6,
	needRoomLevel = 8,
	levelGroup = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_production_line.onLoad(json)
	lua_production_line.configList, lua_production_line.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_production_line
