-- chunkname: @modules/configs/excel2json/lua_handbook_story_chapter.lua

module("modules.configs.excel2json.lua_handbook_story_chapter", package.seeall)

local lua_handbook_story_chapter = {}
local fields = {
	nameEn = 5,
	name = 4,
	year = 6,
	type = 2,
	id = 1,
	order = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_handbook_story_chapter.onLoad(json)
	lua_handbook_story_chapter.configList, lua_handbook_story_chapter.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_handbook_story_chapter
