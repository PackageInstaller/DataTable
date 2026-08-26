-- chunkname: @modules/configs/excel2json/lua_activity220_lamona_map.lua

module("modules.configs.excel2json.lua_activity220_lamona_map", package.seeall)

local lua_activity220_lamona_map = {}
local fields = {
	mapId = 1,
	startPos = 3,
	bg = 2,
	size = 4,
	content = 5
}
local primaryKey = {
	"mapId"
}
local mlStringKey = {}

function lua_activity220_lamona_map.onLoad(json)
	lua_activity220_lamona_map.configList, lua_activity220_lamona_map.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_lamona_map
