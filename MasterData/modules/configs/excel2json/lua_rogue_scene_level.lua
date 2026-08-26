-- chunkname: @modules/configs/excel2json/lua_rogue_scene_level.lua

module("modules.configs.excel2json.lua_rogue_scene_level", package.seeall)

local lua_rogue_scene_level = {}
local fields = {
	id = 1,
	sceneLevel = 3,
	layer = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rogue_scene_level.onLoad(json)
	lua_rogue_scene_level.configList, lua_rogue_scene_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rogue_scene_level
