-- chunkname: @modules/configs/excel2json/lua_party_ai.lua

module("modules.configs.excel2json.lua_party_ai", package.seeall)

local lua_party_ai = {}
local fields = {
	id = 1,
	name = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_party_ai.onLoad(json)
	lua_party_ai.configList, lua_party_ai.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_party_ai
