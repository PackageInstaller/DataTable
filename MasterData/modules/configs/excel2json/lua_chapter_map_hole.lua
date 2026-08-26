-- chunkname: @modules/configs/excel2json/lua_chapter_map_hole.lua

module("modules.configs.excel2json.lua_chapter_map_hole", package.seeall)

local lua_chapter_map_hole = {}
local fields = {
	param = 3,
	mapId = 1,
	sort = 2
}
local primaryKey = {
	"mapId",
	"sort"
}
local mlStringKey = {}

function lua_chapter_map_hole.onLoad(json)
	lua_chapter_map_hole.configList, lua_chapter_map_hole.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_chapter_map_hole
