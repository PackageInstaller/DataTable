-- chunkname: @modules/configs/excel2json/lua_activity203_dialog.lua

module("modules.configs.excel2json.lua_activity203_dialog", package.seeall)

local lua_activity203_dialog = {}
local fields = {
	id = 1,
	dialogId = 3,
	dialogSeq = 2,
	trigger = 4
}
local primaryKey = {
	"id",
	"dialogSeq"
}
local mlStringKey = {}

function lua_activity203_dialog.onLoad(json)
	lua_activity203_dialog.configList, lua_activity203_dialog.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity203_dialog
