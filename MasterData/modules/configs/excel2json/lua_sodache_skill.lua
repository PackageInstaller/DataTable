-- chunkname: @modules/configs/excel2json/lua_sodache_skill.lua

module("modules.configs.excel2json.lua_sodache_skill", package.seeall)

local lua_sodache_skill = {}
local fields = {
	id = 1,
	name = 2,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_sodache_skill.onLoad(json)
	lua_sodache_skill.configList, lua_sodache_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sodache_skill
