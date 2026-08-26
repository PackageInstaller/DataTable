-- chunkname: @modules/configs/excel2json/lua_scene.lua

module("modules.configs.excel2json.lua_scene", package.seeall)

local lua_scene = {}
local fields = {
	id = 1,
	name = 2,
	levels = 4,
	nameen = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_scene.onLoad(json)
	lua_scene.configList, lua_scene.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_scene
