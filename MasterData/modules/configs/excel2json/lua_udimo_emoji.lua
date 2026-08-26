-- chunkname: @modules/configs/excel2json/lua_udimo_emoji.lua

module("modules.configs.excel2json.lua_udimo_emoji", package.seeall)

local lua_udimo_emoji = {}
local fields = {
	id = 1,
	resource = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_udimo_emoji.onLoad(json)
	lua_udimo_emoji.configList, lua_udimo_emoji.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_udimo_emoji
