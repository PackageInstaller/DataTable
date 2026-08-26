-- chunkname: @modules/configs/excel2json/lua_weekwalk_scene.lua

module("modules.configs.excel2json.lua_weekwalk_scene", package.seeall)

local lua_weekwalk_scene = {}
local fields = {
	map = 2,
	name = 6,
	buffId = 4,
	mapId = 3,
	name_en = 9,
	battleName = 8,
	typeName = 5,
	id = 1,
	icon = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	typeName = 1,
	name_en = 4,
	battleName = 3
}

function lua_weekwalk_scene.onLoad(json)
	lua_weekwalk_scene.configList, lua_weekwalk_scene.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_weekwalk_scene
