-- chunkname: @modules/configs/excel2json/lua_rogue_dialog.lua

module("modules.configs.excel2json.lua_rogue_dialog", package.seeall)

local lua_rogue_dialog = {}
local fields = {
	text = 3,
	id = 2,
	photo = 5,
	type = 4,
	group = 1
}
local primaryKey = {
	"group",
	"id"
}
local mlStringKey = {
	text = 1
}

function lua_rogue_dialog.onLoad(json)
	lua_rogue_dialog.configList, lua_rogue_dialog.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rogue_dialog
