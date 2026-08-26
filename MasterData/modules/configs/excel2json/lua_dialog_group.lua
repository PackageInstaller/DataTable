-- chunkname: @modules/configs/excel2json/lua_dialog_group.lua

module("modules.configs.excel2json.lua_dialog_group", package.seeall)

local lua_dialog_group = {}
local fields = {
	dialogue_id = 1,
	id = 2
}
local primaryKey = {
	"dialogue_id",
	"id"
}
local mlStringKey = {}

function lua_dialog_group.onLoad(json)
	lua_dialog_group.configList, lua_dialog_group.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_dialog_group
