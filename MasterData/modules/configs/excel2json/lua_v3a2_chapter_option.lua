-- chunkname: @modules/configs/excel2json/lua_v3a2_chapter_option.lua

module("modules.configs.excel2json.lua_v3a2_chapter_option", package.seeall)

local lua_v3a2_chapter_option = {}
local fields = {
	optionA = 5,
	optionB = 7,
	feedbackC = 10,
	optionD = 11,
	feedbackD = 12,
	title = 2,
	feedbackA = 6,
	desc = 4,
	feedbackB = 8,
	res = 3,
	optionC = 9,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	optionA = 3,
	optionB = 5,
	feedbackC = 8,
	feedbackD = 10,
	title = 1,
	feedbackA = 4,
	desc = 2,
	feedbackB = 6,
	optionD = 9,
	optionC = 7
}

function lua_v3a2_chapter_option.onLoad(json)
	lua_v3a2_chapter_option.configList, lua_v3a2_chapter_option.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_v3a2_chapter_option
