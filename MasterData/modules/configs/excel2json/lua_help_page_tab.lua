-- chunkname: @modules/configs/excel2json/lua_help_page_tab.lua

module("modules.configs.excel2json.lua_help_page_tab", package.seeall)

local lua_help_page_tab = {}
local fields = {
	parentId = 2,
	title_en = 5,
	sortIdx = 3,
	showType = 6,
	id = 1,
	title = 4,
	helpId = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	title_en = 2,
	title = 1
}

function lua_help_page_tab.onLoad(json)
	lua_help_page_tab.configList, lua_help_page_tab.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_help_page_tab
