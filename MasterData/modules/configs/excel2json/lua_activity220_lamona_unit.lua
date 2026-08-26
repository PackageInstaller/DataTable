-- chunkname: @modules/configs/excel2json/lua_activity220_lamona_unit.lua

module("modules.configs.excel2json.lua_activity220_lamona_unit", package.seeall)

local lua_activity220_lamona_unit = {}
local fields = {
	changeGhostTempAttrs = 7,
	effectRangeUnitId = 5,
	imgName = 9,
	type = 2,
	icon = 10,
	desc = 4,
	changeGhostAttrs = 6,
	id = 1,
	removeAfterEffect = 8,
	attributeList = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_activity220_lamona_unit.onLoad(json)
	lua_activity220_lamona_unit.configList, lua_activity220_lamona_unit.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_lamona_unit
