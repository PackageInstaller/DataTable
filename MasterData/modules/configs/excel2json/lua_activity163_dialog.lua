-- chunkname: @modules/configs/excel2json/lua_activity163_dialog.lua

module("modules.configs.excel2json.lua_activity163_dialog", package.seeall)

local lua_activity163_dialog = {}
local fields = {
	expression = 9,
	content = 7,
	nextStep = 3,
	pos = 5,
	stepId = 2,
	condition = 8,
	speaker = 4,
	speakerIcon = 6,
	id = 1
}
local primaryKey = {
	"id",
	"stepId"
}
local mlStringKey = {
	speaker = 1,
	content = 2
}

function lua_activity163_dialog.onLoad(json)
	lua_activity163_dialog.configList, lua_activity163_dialog.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity163_dialog
