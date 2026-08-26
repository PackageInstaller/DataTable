-- chunkname: @modules/logic/language/lua_language.lua

module("modules.logic.language.lua_language", package.seeall)

local lua_language = {}
local fields = {
	content = 2,
	key = 1
}
local primaryKey = {
	"key"
}
local mlStringKey = {}

function lua_language.onLoad(json)
	lua_language.configList, lua_language.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_language
