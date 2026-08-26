-- chunkname: @modules/configs/excel2json/lua_activity144_option_result.lua

module("modules.configs.excel2json.lua_activity144_option_result", package.seeall)

local lua_activity144_option_result = {}
local fields = {
	activityId = 1,
	name = 3,
	desc = 6,
	picture = 5,
	optionId = 2,
	bonus = 4
}
local primaryKey = {
	"activityId",
	"optionId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity144_option_result.onLoad(json)
	lua_activity144_option_result.configList, lua_activity144_option_result.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity144_option_result
