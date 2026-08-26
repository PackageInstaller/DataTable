-- chunkname: @modules/configs/excel2json/lua_sodache_difficulty.lua

module("modules.configs.excel2json.lua_sodache_difficulty", package.seeall)

local lua_sodache_difficulty = {}
local fields = {
	stepAttr = 3,
	evil = 2,
	difficulty = 1
}
local primaryKey = {
	"difficulty",
	"evil"
}
local mlStringKey = {}

function lua_sodache_difficulty.onLoad(json)
	lua_sodache_difficulty.configList, lua_sodache_difficulty.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sodache_difficulty
