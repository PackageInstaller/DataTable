-- chunkname: @modules/configs/excel2json/lua_tip_dialog.lua

module("modules.configs.excel2json.lua_tip_dialog", package.seeall)

local lua_tip_dialog = {}
local fields = {
	stepId = 2,
	content = 6,
	audio = 7,
	type = 3,
	id = 1,
	icon = 5,
	pos = 4
}
local primaryKey = {
	"id",
	"stepId"
}
local mlStringKey = {
	content = 1
}

function lua_tip_dialog.onLoad(json)
	lua_tip_dialog.configList, lua_tip_dialog.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tip_dialog
