-- chunkname: @modules/configs/excel2json/lua_activity144_option.lua

module("modules.configs.excel2json.lua_activity144_option", package.seeall)

local lua_activity144_option = {}
local fields = {
	activityId = 1,
	name = 5,
	optionResults = 4,
	conditionDesc = 3,
	optionDesc = 6,
	optionId = 2
}
local primaryKey = {
	"activityId",
	"optionId"
}
local mlStringKey = {
	conditionDesc = 1,
	name = 2,
	optionDesc = 3
}

function lua_activity144_option.onLoad(json)
	lua_activity144_option.configList, lua_activity144_option.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity144_option
