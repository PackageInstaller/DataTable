-- chunkname: @modules/configs/excel2json/lua_chapter_map_fragment.lua

module("modules.configs.excel2json.lua_chapter_map_fragment", package.seeall)

local lua_chapter_map_fragment = {}
local fields = {
	toastId = 6,
	res = 3,
	type = 4,
	id = 1,
	title = 2,
	content = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 2,
	title = 1
}

function lua_chapter_map_fragment.onLoad(json)
	lua_chapter_map_fragment.configList, lua_chapter_map_fragment.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_chapter_map_fragment
