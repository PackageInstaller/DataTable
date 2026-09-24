-- chunkname: @modules/configs/excel2json/lua_activity244_chapter.lua

module("modules.configs.excel2json.lua_activity244_chapter", package.seeall)

local lua_activity244_chapter = {}
local fields = {
	levelType = 3,
	chapterImage = 6,
	sortIndex = 4,
	id = 1,
	chapterName = 2,
	unlock = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	chapterName = 1
}

function lua_activity244_chapter.onLoad(json)
	lua_activity244_chapter.configList, lua_activity244_chapter.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity244_chapter
