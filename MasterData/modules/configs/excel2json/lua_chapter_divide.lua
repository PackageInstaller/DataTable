-- chunkname: @modules/configs/excel2json/lua_chapter_divide.lua

module("modules.configs.excel2json.lua_chapter_divide", package.seeall)

local lua_chapter_divide = {}
local fields = {
	resPageClosed = 5,
	name = 2,
	nameEn = 3,
	resPage = 4,
	chapterId = 6,
	storyId = 7,
	sectionId = 1
}
local primaryKey = {
	"sectionId"
}
local mlStringKey = {
	name = 1
}

function lua_chapter_divide.onLoad(json)
	lua_chapter_divide.configList, lua_chapter_divide.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_chapter_divide
