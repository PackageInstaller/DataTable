-- chunkname: @modules/configs/excel2json/lua_chapter_puzzle_changecolor.lua

module("modules.configs.excel2json.lua_chapter_puzzle_changecolor", package.seeall)

local lua_chapter_puzzle_changecolor = {}
local fields = {
	interactbtns = 5,
	name = 2,
	colorsort = 6,
	id = 1,
	initColors = 3,
	finalColors = 4,
	bonus = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	initColors = 2,
	name = 1
}

function lua_chapter_puzzle_changecolor.onLoad(json)
	lua_chapter_puzzle_changecolor.configList, lua_chapter_puzzle_changecolor.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_chapter_puzzle_changecolor
