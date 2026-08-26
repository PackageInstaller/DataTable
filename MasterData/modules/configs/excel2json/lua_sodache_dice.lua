-- chunkname: @modules/configs/excel2json/lua_sodache_dice.lua

module("modules.configs.excel2json.lua_sodache_dice", package.seeall)

local lua_sodache_dice = {}
local fields = {
	id = 1,
	faceList = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_sodache_dice.onLoad(json)
	lua_sodache_dice.configList, lua_sodache_dice.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sodache_dice
