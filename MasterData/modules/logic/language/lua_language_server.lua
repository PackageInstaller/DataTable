-- chunkname: @modules/logic/language/lua_language_server.lua

module("modules.logic.language.lua_language_server", package.seeall)

local lua_language_server = {}
local fields = {
	content = 2,
	key = 1
}
local primaryKey = {
	"key"
}
local mlStringKey = {}

function lua_language_server.onLoad(json)
	lua_language_server.configList, lua_language_server.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_language_server
