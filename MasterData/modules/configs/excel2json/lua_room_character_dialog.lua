-- chunkname: @modules/configs/excel2json/lua_room_character_dialog.lua

module("modules.configs.excel2json.lua_room_character_dialog", package.seeall)

local lua_room_character_dialog = {}
local fields = {
	selectIds = 7,
	relateContent = 6,
	speaker = 3,
	stepId = 2,
	content = 4,
	critteremoji = 5,
	speakerType = 8,
	dialogId = 1,
	nextStepId = 9
}
local primaryKey = {
	"dialogId",
	"stepId"
}
local mlStringKey = {
	speaker = 1,
	relateContent = 3,
	content = 2
}

function lua_room_character_dialog.onLoad(json)
	lua_room_character_dialog.configList, lua_room_character_dialog.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_room_character_dialog
