-- chunkname: @modules/configs/excel2json/lua_scene_click.lua

module("modules.configs.excel2json.lua_scene_click", package.seeall)

local lua_scene_click = {}
local fields = {
	itemId = 3,
	effect = 6,
	previewIcon = 5,
	id = 1,
	icon = 4,
	defaultUnlock = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_scene_click.onLoad(json)
	lua_scene_click.configList, lua_scene_click.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_scene_click
