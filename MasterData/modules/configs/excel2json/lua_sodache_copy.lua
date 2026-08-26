-- chunkname: @modules/configs/excel2json/lua_sodache_copy.lua

module("modules.configs.excel2json.lua_sodache_copy", package.seeall)

local lua_sodache_copy = {}
local fields = {
	faith = 12,
	name = 3,
	time = 11,
	type = 2,
	group = 4,
	image = 10,
	careerNum = 13,
	desc = 5,
	functionId = 7,
	mapId = 6,
	adoLv = 14,
	id = 1,
	icon = 9,
	price = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_sodache_copy.onLoad(json)
	lua_sodache_copy.configList, lua_sodache_copy.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sodache_copy
