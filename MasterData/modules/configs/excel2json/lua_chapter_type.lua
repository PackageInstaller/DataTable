-- chunkname: @modules/configs/excel2json/lua_chapter_type.lua

module("modules.configs.excel2json.lua_chapter_type", package.seeall)

local lua_chapter_type = {}
local fields = {
	name = 2,
	typeId = 1,
	nameEn = 3
}
local primaryKey = {
	"typeId"
}
local mlStringKey = {
	name = 1
}

function lua_chapter_type.onLoad(json)
	lua_chapter_type.configList, lua_chapter_type.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_chapter_type
