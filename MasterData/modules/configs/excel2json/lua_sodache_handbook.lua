-- chunkname: @modules/configs/excel2json/lua_sodache_handbook.lua

module("modules.configs.excel2json.lua_sodache_handbook", package.seeall)

local lua_sodache_handbook = {}
local fields = {
	id = 1,
	eleId = 2,
	tab2 = 4,
	tab1 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_sodache_handbook.onLoad(json)
	lua_sodache_handbook.configList, lua_sodache_handbook.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sodache_handbook
