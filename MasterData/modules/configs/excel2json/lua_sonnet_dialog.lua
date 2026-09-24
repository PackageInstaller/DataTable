-- chunkname: @modules/configs/excel2json/lua_sonnet_dialog.lua

module("modules.configs.excel2json.lua_sonnet_dialog", package.seeall)

local lua_sonnet_dialog = {}
local fields = {
	index = 2,
	elementId = 1,
	desc = 3
}
local primaryKey = {
	"elementId",
	"index"
}
local mlStringKey = {
	desc = 1
}

function lua_sonnet_dialog.onLoad(json)
	lua_sonnet_dialog.configList, lua_sonnet_dialog.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sonnet_dialog
