-- chunkname: @modules/configs/excel2json/lua_activity220_dianjishi_map.lua

module("modules.configs.excel2json.lua_activity220_dianjishi_map", package.seeall)

local lua_activity220_dianjishi_map = {}
local fields = {
	id = 2,
	mapId = 1,
	direction = 6,
	icon = 5,
	value = 3,
	position = 4,
	offset = 7
}
local primaryKey = {
	"mapId",
	"id"
}
local mlStringKey = {}

function lua_activity220_dianjishi_map.onLoad(json)
	lua_activity220_dianjishi_map.configList, lua_activity220_dianjishi_map.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_dianjishi_map
