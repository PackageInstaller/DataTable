-- chunkname: @modules/configs/excel2json/lua_scene_eggs.lua

module("modules.configs.excel2json.lua_scene_eggs", package.seeall)

local lua_scene_eggs = {}
local fields = {
	parallel = 5,
	actionClass = 3,
	id = 1,
	actionParams = 4,
	path = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_scene_eggs.onLoad(json)
	lua_scene_eggs.configList, lua_scene_eggs.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_scene_eggs
