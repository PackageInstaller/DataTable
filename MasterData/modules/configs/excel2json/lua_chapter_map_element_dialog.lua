-- chunkname: @modules/configs/excel2json/lua_chapter_map_element_dialog.lua

module("modules.configs.excel2json.lua_chapter_map_element_dialog", package.seeall)

local lua_chapter_map_element_dialog = {}
local fields = {
	param = 4,
	res = 8,
	audio = 5,
	type = 3,
	id = 1,
	speaker = 6,
	content = 7,
	stepId = 2
}
local primaryKey = {
	"id",
	"stepId"
}
local mlStringKey = {
	speaker = 1,
	content = 2
}

function lua_chapter_map_element_dialog.onLoad(json)
	lua_chapter_map_element_dialog.configList, lua_chapter_map_element_dialog.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_chapter_map_element_dialog
