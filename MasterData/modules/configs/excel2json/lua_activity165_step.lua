-- chunkname: @modules/configs/excel2json/lua_activity165_step.lua

module("modules.configs.excel2json.lua_activity165_step", package.seeall)

local lua_activity165_step = {}
local fields = {
	text = 6,
	stepId = 1,
	answersKeywordIds = 4,
	nextStepConditionIds = 5,
	optionalKeywordIds = 3,
	pic = 7,
	belongStoryId = 2
}
local primaryKey = {
	"stepId"
}
local mlStringKey = {
	text = 1
}

function lua_activity165_step.onLoad(json)
	lua_activity165_step.configList, lua_activity165_step.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity165_step
