-- chunkname: @modules/configs/excel2json/lua_sodache_upgrade.lua

module("modules.configs.excel2json.lua_sodache_upgrade", package.seeall)

local lua_sodache_upgrade = {}
local fields = {
	cost = 3,
	id = 1,
	effect1 = 4,
	type = 6,
	effect2Desc = 9,
	globalAttri = 7,
	effectDesc = 5,
	effect2 = 8,
	level = 2
}
local primaryKey = {
	"id",
	"level"
}
local mlStringKey = {
	effectDesc = 1,
	effect2Desc = 2
}

function lua_sodache_upgrade.onLoad(json)
	lua_sodache_upgrade.configList, lua_sodache_upgrade.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sodache_upgrade
