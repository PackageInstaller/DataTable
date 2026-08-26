-- chunkname: @modules/configs/excel2json/lua_chapter_puzzle_changecolor_color.lua

module("modules.configs.excel2json.lua_chapter_puzzle_changecolor_color", package.seeall)

local lua_chapter_puzzle_changecolor_color = {}
local fields = {
	id = 1,
	name = 2,
	colorvalue = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_chapter_puzzle_changecolor_color.onLoad(json)
	lua_chapter_puzzle_changecolor_color.configList, lua_chapter_puzzle_changecolor_color.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_chapter_puzzle_changecolor_color
