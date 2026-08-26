-- chunkname: @modules/configs/excel2json/lua_activity108_dialog.lua

module("modules.configs.excel2json.lua_activity108_dialog", package.seeall)

local lua_activity108_dialog = {}
local fields = {
	param = 4,
	stepId = 2,
	option_param = 5,
	type = 3,
	id = 1,
	result = 6,
	content = 7
}
local primaryKey = {
	"id",
	"stepId"
}
local mlStringKey = {
	content = 1
}

function lua_activity108_dialog.onLoad(json)
	lua_activity108_dialog.configList, lua_activity108_dialog.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity108_dialog
