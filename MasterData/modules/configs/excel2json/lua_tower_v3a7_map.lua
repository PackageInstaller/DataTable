-- chunkname: @modules/configs/excel2json/lua_tower_v3a7_map.lua

module("modules.configs.excel2json.lua_tower_v3a7_map", package.seeall)

local lua_tower_v3a7_map = {}
local fields = {
	map = 8,
	desc2 = 4,
	time = 7,
	desc1 = 3,
	title = 2,
	story = 9,
	quest = 6,
	id = 1,
	desc3 = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc2 = 3,
	title = 1,
	desc3 = 4,
	desc1 = 2
}

function lua_tower_v3a7_map.onLoad(json)
	lua_tower_v3a7_map.configList, lua_tower_v3a7_map.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_v3a7_map
