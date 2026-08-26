-- chunkname: @modules/configs/excel2json/lua_scene_ui.lua

module("modules.configs.excel2json.lua_scene_ui", package.seeall)

local lua_scene_ui = {}
local fields = {
	itemId = 3,
	previewIcon = 5,
	id = 1,
	icon = 4,
	defaultUnlock = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_scene_ui.onLoad(json)
	lua_scene_ui.configList, lua_scene_ui.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_scene_ui
