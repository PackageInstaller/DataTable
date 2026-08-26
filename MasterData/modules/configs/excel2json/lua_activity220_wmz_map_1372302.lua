-- chunkname: @modules/configs/excel2json/lua_activity220_wmz_map_1372302.lua

module("modules.configs.excel2json.lua_activity220_wmz_map_1372302", package.seeall)

local lua_activity220_wmz_map_1372302 = {}
local fields = {
	fromX = 2,
	content = 6,
	toX = 4,
	id = 1,
	toY = 5,
	fromY = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity220_wmz_map_1372302.onLoad(json)
	lua_activity220_wmz_map_1372302.configList, lua_activity220_wmz_map_1372302.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_wmz_map_1372302
