-- chunkname: @modules/configs/excel2json/lua_chapter_puzzle_changecolor_interact.lua

module("modules.configs.excel2json.lua_chapter_puzzle_changecolor_interact", package.seeall)

local lua_chapter_puzzle_changecolor_interact = {}
local fields = {
	id = 1,
	interactvalue = 3,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_chapter_puzzle_changecolor_interact.onLoad(json)
	lua_chapter_puzzle_changecolor_interact.configList, lua_chapter_puzzle_changecolor_interact.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_chapter_puzzle_changecolor_interact
