-- chunkname: @modules/configs/excel2json/lua_explore_unit.lua

module("modules.configs.excel2json.lua_explore_unit", package.seeall)

local lua_explore_unit = {}
local fields = {
	mapIcon2 = 6,
	asset = 9,
	type = 1,
	mapIconShow = 8,
	mapIcon = 5,
	icon2 = 4,
	icon = 3,
	mapActiveIcon = 7,
	isShow = 2
}
local primaryKey = {
	"type"
}
local mlStringKey = {}

function lua_explore_unit.onLoad(json)
	lua_explore_unit.configList, lua_explore_unit.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_explore_unit
