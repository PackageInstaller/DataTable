-- chunkname: @modules/configs/excel2json/lua_sodache_level.lua

module("modules.configs.excel2json.lua_sodache_level", package.seeall)

local lua_sodache_level = {}
local fields = {
	desc = 3,
	effect = 4,
	globalAttri = 6,
	cosume = 2,
	effectDesc = 5,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {
	effectDesc = 2,
	desc = 1
}

function lua_sodache_level.onLoad(json)
	lua_sodache_level.configList, lua_sodache_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sodache_level
