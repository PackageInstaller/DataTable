-- chunkname: @modules/configs/excel2json/lua_scene_ui_reddot_new.lua

module("modules.configs.excel2json.lua_scene_ui_reddot_new", package.seeall)

local lua_scene_ui_reddot_new = {}
local fields = {
	id = 1,
	style = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_scene_ui_reddot_new.onLoad(json)
	lua_scene_ui_reddot_new.configList, lua_scene_ui_reddot_new.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_scene_ui_reddot_new
