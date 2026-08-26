-- chunkname: @modules/configs/excel2json/lua_eliminate_dialog.lua

module("modules.configs.excel2json.lua_eliminate_dialog", package.seeall)

local lua_eliminate_dialog = {}
local fields = {
	auto = 5,
	dialogSeq = 2,
	id = 1,
	dialogId = 3,
	trigger = 4
}
local primaryKey = {
	"id",
	"dialogSeq"
}
local mlStringKey = {}

function lua_eliminate_dialog.onLoad(json)
	lua_eliminate_dialog.configList, lua_eliminate_dialog.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_eliminate_dialog
