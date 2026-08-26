-- chunkname: @modules/configs/excel2json/lua_v3a2_chapter_report.lua

module("modules.configs.excel2json.lua_v3a2_chapter_report", package.seeall)

local lua_v3a2_chapter_report = {}
local fields = {
	id = 1,
	res = 3,
	element = 2,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_v3a2_chapter_report.onLoad(json)
	lua_v3a2_chapter_report.configList, lua_v3a2_chapter_report.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_v3a2_chapter_report
