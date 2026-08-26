-- chunkname: @modules/configs/excel2json/lua_activity221_map.lua

module("modules.configs.excel2json.lua_activity221_map", package.seeall)

local lua_activity221_map = {}
local fields = {
	mapId = 1,
	time = 2,
	targets = 3,
	type7Weight = 5,
	targetDesc = 4
}
local primaryKey = {
	"mapId"
}
local mlStringKey = {}

function lua_activity221_map.onLoad(json)
	lua_activity221_map.configList, lua_activity221_map.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity221_map
