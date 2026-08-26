-- chunkname: @modules/configs/excel2json/lua_party_emoji.lua

module("modules.configs.excel2json.lua_party_emoji", package.seeall)

local lua_party_emoji = {}
local fields = {
	id = 1,
	icon = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_party_emoji.onLoad(json)
	lua_party_emoji.configList, lua_party_emoji.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_party_emoji
