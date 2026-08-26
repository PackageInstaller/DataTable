-- chunkname: @modules/configs/excel2json/lua_sodache_dialog.lua

module("modules.configs.excel2json.lua_sodache_dialog", package.seeall)

local lua_sodache_dialog = {}
local fields = {
	actor = 5,
	group = 2,
	head = 6,
	desc = 7,
	id = 1,
	position = 4,
	order = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	actor = 1,
	desc = 2
}

function lua_sodache_dialog.onLoad(json)
	lua_sodache_dialog.configList, lua_sodache_dialog.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sodache_dialog
