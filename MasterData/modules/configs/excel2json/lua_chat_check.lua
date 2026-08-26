-- chunkname: @modules/configs/excel2json/lua_chat_check.lua

module("modules.configs.excel2json.lua_chat_check", package.seeall)

local lua_chat_check = {}
local fields = {
	id = 1,
	value = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	value = 1
}

function lua_chat_check.onLoad(json)
	lua_chat_check.configList, lua_chat_check.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_chat_check
