-- chunkname: @modules/configs/excel2json/lua_version_activity_puzzle_question.lua

module("modules.configs.excel2json.lua_version_activity_puzzle_question", package.seeall)

local lua_version_activity_puzzle_question = {}
local fields = {
	id = 1,
	text = 3,
	answer = 4,
	tittle = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	text = 2,
	answer = 3,
	tittle = 1
}

function lua_version_activity_puzzle_question.onLoad(json)
	lua_version_activity_puzzle_question.configList, lua_version_activity_puzzle_question.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_version_activity_puzzle_question
