-- chunkname: @modules/configs/excel2json/lua_v3a2_chapter_result.lua

module("modules.configs.excel2json.lua_v3a2_chapter_result", package.seeall)

local lua_v3a2_chapter_result = {}
local fields = {
	res = 3,
	option = 5,
	id = 1,
	title = 2,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}

function lua_v3a2_chapter_result.onLoad(json)
	lua_v3a2_chapter_result.configList, lua_v3a2_chapter_result.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_v3a2_chapter_result
