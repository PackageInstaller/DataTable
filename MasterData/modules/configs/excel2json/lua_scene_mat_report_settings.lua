-- chunkname: @modules/configs/excel2json/lua_scene_mat_report_settings.lua

module("modules.configs.excel2json.lua_scene_mat_report_settings", package.seeall)

local lua_scene_mat_report_settings = {}
local fields = {
	id = 2,
	sceneId = 1,
	lightmap = 4,
	mat = 3
}
local primaryKey = {
	"sceneId",
	"id"
}
local mlStringKey = {}

function lua_scene_mat_report_settings.onLoad(json)
	lua_scene_mat_report_settings.configList, lua_scene_mat_report_settings.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_scene_mat_report_settings
