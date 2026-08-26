-- chunkname: @modules/configs/excel2json/lua_activity131_dialog.lua

module("modules.configs.excel2json.lua_activity131_dialog", package.seeall)

local lua_activity131_dialog = {}
local fields = {
	param = 4,
	single = 6,
	option_param = 5,
	type = 3,
	id = 1,
	stepId = 2,
	content = 8,
	speaker = 7
}
local primaryKey = {
	"id",
	"stepId"
}
local mlStringKey = {
	speaker = 1,
	content = 2
}

function lua_activity131_dialog.onLoad(json)
	lua_activity131_dialog.configList, lua_activity131_dialog.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity131_dialog
