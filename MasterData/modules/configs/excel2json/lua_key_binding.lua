-- chunkname: @modules/configs/excel2json/lua_key_binding.lua

module("modules.configs.excel2json.lua_key_binding", package.seeall)

local lua_key_binding = {}
local fields = {
	description = 3,
	key = 4,
	hud = 1,
	editable = 5,
	id = 2
}
local primaryKey = {
	"hud",
	"id"
}
local mlStringKey = {}

function lua_key_binding.onLoad(json)
	lua_key_binding.configList, lua_key_binding.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_key_binding
