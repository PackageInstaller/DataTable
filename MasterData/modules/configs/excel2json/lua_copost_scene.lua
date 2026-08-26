-- chunkname: @modules/configs/excel2json/lua_copost_scene.lua

module("modules.configs.excel2json.lua_copost_scene", package.seeall)

local lua_copost_scene = {}
local fields = {
	scene = 2,
	leftUpRange = 3,
	scene_ui = 5,
	scene_node = 6,
	id = 1,
	rightDownRange = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_copost_scene.onLoad(json)
	lua_copost_scene.configList, lua_copost_scene.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_copost_scene
