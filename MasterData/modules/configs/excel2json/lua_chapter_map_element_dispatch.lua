-- chunkname: @modules/configs/excel2json/lua_chapter_map_element_dispatch.lua

module("modules.configs.excel2json.lua_chapter_map_element_dispatch", package.seeall)

local lua_chapter_map_element_dispatch = {}
local fields = {
	desc = 8,
	id = 1,
	time = 4,
	image = 9,
	title = 7,
	unlockLineNumbers = 12,
	extraParam = 6,
	elementId = 10,
	shortType = 5,
	minCount = 2,
	maxCount = 3,
	activityId = 11
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}

function lua_chapter_map_element_dispatch.onLoad(json)
	lua_chapter_map_element_dispatch.configList, lua_chapter_map_element_dispatch.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_chapter_map_element_dispatch
