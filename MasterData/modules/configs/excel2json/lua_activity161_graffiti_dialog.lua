-- chunkname: @modules/configs/excel2json/lua_activity161_graffiti_dialog.lua

module("modules.configs.excel2json.lua_activity161_graffiti_dialog", package.seeall)

local lua_activity161_graffiti_dialog = {}
local fields = {
	stepId = 2,
	dialogId = 1,
	chessId = 3,
	dialog = 4
}
local primaryKey = {
	"dialogId",
	"stepId"
}
local mlStringKey = {}

function lua_activity161_graffiti_dialog.onLoad(json)
	lua_activity161_graffiti_dialog.configList, lua_activity161_graffiti_dialog.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity161_graffiti_dialog
