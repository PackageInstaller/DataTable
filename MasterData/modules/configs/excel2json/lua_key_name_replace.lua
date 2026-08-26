-- chunkname: @modules/configs/excel2json/lua_key_name_replace.lua

module("modules.configs.excel2json.lua_key_name_replace", package.seeall)

local lua_key_name_replace = {}
local fields = {
	replacedName = 2,
	name = 1
}
local primaryKey = {
	"name"
}
local mlStringKey = {}

function lua_key_name_replace.onLoad(json)
	lua_key_name_replace.configList, lua_key_name_replace.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_key_name_replace
