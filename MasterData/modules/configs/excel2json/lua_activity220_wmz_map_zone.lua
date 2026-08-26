-- chunkname: @modules/configs/excel2json/lua_activity220_wmz_map_zone.lua

module("modules.configs.excel2json.lua_activity220_wmz_map_zone", package.seeall)

local lua_activity220_wmz_map_zone = {}
local fields = {
	frameFocusX = 7,
	frameBgResName = 6,
	frameFocusY = 8,
	focusY = 10,
	titleDesc = 3,
	titlePosX = 4,
	bgResName = 2,
	id = 1,
	titlePosY = 5,
	focusX = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	titleDesc = 1
}

function lua_activity220_wmz_map_zone.onLoad(json)
	lua_activity220_wmz_map_zone.configList, lua_activity220_wmz_map_zone.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_wmz_map_zone
