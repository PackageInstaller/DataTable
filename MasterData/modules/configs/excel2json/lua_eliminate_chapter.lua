-- chunkname: @modules/configs/excel2json/lua_eliminate_chapter.lua

module("modules.configs.excel2json.lua_eliminate_chapter", package.seeall)

local lua_eliminate_chapter = {}
local fields = {
	id = 1,
	name = 2,
	activityId = 3,
	map = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_eliminate_chapter.onLoad(json)
	lua_eliminate_chapter.configList, lua_eliminate_chapter.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_eliminate_chapter
