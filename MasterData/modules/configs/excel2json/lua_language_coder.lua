-- chunkname: @modules/configs/excel2json/lua_language_coder.lua

module("modules.configs.excel2json.lua_language_coder", package.seeall)

local lua_language_coder = {}
local fields = {
	id = 1,
	lang = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	lang = 1
}

function lua_language_coder.onLoad(json)
	lua_language_coder.configList, lua_language_coder.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_language_coder
