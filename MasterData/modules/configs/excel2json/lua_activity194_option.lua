-- chunkname: @modules/configs/excel2json/lua_activity194_option.lua

module("modules.configs.excel2json.lua_activity194_option", package.seeall)

local lua_activity194_option = {}
local fields = {
	optionResultId = 7,
	name = 2,
	effect = 6,
	optionRestriction = 5,
	conditionDesc = 3,
	optionDesc = 4,
	optionId = 1
}
local primaryKey = {
	"optionId"
}
local mlStringKey = {
	conditionDesc = 2,
	name = 1,
	optionDesc = 3
}

function lua_activity194_option.onLoad(json)
	lua_activity194_option.configList, lua_activity194_option.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity194_option
