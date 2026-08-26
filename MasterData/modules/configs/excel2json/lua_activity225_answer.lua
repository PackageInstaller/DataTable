-- chunkname: @modules/configs/excel2json/lua_activity225_answer.lua

module("modules.configs.excel2json.lua_activity225_answer", package.seeall)

local lua_activity225_answer = {}
local fields = {
	answerId = 1,
	answerTxt = 2,
	answerComment = 3
}
local primaryKey = {
	"answerId"
}
local mlStringKey = {
	answerComment = 2,
	answerTxt = 1
}

function lua_activity225_answer.onLoad(json)
	lua_activity225_answer.configList, lua_activity225_answer.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity225_answer
