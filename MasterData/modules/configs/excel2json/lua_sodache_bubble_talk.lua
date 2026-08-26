-- chunkname: @modules/configs/excel2json/lua_sodache_bubble_talk.lua

module("modules.configs.excel2json.lua_sodache_bubble_talk", package.seeall)

local lua_sodache_bubble_talk = {}
local fields = {
	id = 1,
	weight = 3,
	condition = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_sodache_bubble_talk.onLoad(json)
	lua_sodache_bubble_talk.configList, lua_sodache_bubble_talk.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sodache_bubble_talk
