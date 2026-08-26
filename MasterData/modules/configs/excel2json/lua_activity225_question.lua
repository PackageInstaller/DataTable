-- chunkname: @modules/configs/excel2json/lua_activity225_question.lua

module("modules.configs.excel2json.lua_activity225_question", package.seeall)

local lua_activity225_question = {}
local fields = {
	npcId = 3,
	question = 4,
	id = 2,
	answerIds = 5,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	question = 1
}

function lua_activity225_question.onLoad(json)
	lua_activity225_question.configList, lua_activity225_question.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity225_question
