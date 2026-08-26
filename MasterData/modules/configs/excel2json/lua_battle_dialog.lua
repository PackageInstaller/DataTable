-- chunkname: @modules/configs/excel2json/lua_battle_dialog.lua

module("modules.configs.excel2json.lua_battle_dialog", package.seeall)

local lua_battle_dialog = {}
local fields = {
	param = 3,
	icon = 7,
	canRepeat = 4,
	random = 6,
	delay = 11,
	text = 9,
	type = 12,
	insideRepeat = 5,
	audioId = 8,
	id = 2,
	code = 1,
	tipsDir = 10
}
local primaryKey = {
	"code",
	"id"
}
local mlStringKey = {
	text = 1
}

function lua_battle_dialog.onLoad(json)
	lua_battle_dialog.configList, lua_battle_dialog.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_battle_dialog
