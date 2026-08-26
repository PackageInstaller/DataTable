-- chunkname: @modules/configs/excel2json/lua_chapter_puzzle_square.lua

module("modules.configs.excel2json.lua_chapter_puzzle_square", package.seeall)

local lua_chapter_puzzle_square = {}
local fields = {
	id = 1,
	shape = 2,
	count = 3,
	group = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_chapter_puzzle_square.onLoad(json)
	lua_chapter_puzzle_square.configList, lua_chapter_puzzle_square.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_chapter_puzzle_square
