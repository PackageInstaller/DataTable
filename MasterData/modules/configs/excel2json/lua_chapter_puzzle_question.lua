-- chunkname: @modules/configs/excel2json/lua_chapter_puzzle_question.lua

module("modules.configs.excel2json.lua_chapter_puzzle_question", package.seeall)

local lua_chapter_puzzle_question = {}
local fields = {
	descEn = 5,
	answer = 9,
	question = 8,
	questionTitle = 6,
	title = 2,
	questionTitleEn = 7,
	desc = 4,
	titleEn = 3,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	answer = 5,
	question = 4,
	questionTitle = 3,
	title = 1,
	desc = 2
}

function lua_chapter_puzzle_question.onLoad(json)
	lua_chapter_puzzle_question.configList, lua_chapter_puzzle_question.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_chapter_puzzle_question
