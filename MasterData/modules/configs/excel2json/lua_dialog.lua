-- chunkname: @modules/configs/excel2json/lua_dialog.lua

module("modules.configs.excel2json.lua_dialog", package.seeall)

local lua_dialog = {}
local fields = {
	id = 1,
	startGroup = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_dialog.onLoad(json)
	lua_dialog.configList, lua_dialog.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_dialog
