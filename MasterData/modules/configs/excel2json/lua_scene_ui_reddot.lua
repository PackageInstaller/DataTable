-- chunkname: @modules/configs/excel2json/lua_scene_ui_reddot.lua

module("modules.configs.excel2json.lua_scene_ui_reddot", package.seeall)

local lua_scene_ui_reddot = {}
local fields = {
	id = 1,
	reddotId = 2,
	style = 3
}
local primaryKey = {
	"id",
	"reddotId"
}
local mlStringKey = {}

function lua_scene_ui_reddot.onLoad(json)
	lua_scene_ui_reddot.configList, lua_scene_ui_reddot.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_scene_ui_reddot
