-- chunkname: @modules/configs/excel2json/lua_room_character_dialog_select.lua

module("modules.configs.excel2json.lua_room_character_dialog_select", package.seeall)

local lua_room_character_dialog_select = {}
local fields = {
	id = 1,
	dialogId = 2,
	content = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 1
}

function lua_room_character_dialog_select.onLoad(json)
	lua_room_character_dialog_select.configList, lua_room_character_dialog_select.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_room_character_dialog_select
