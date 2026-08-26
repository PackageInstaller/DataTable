-- chunkname: @modules/configs/excel2json/lua_activity194_option_result.lua

module("modules.configs.excel2json.lua_activity194_option_result", package.seeall)

local lua_activity194_option_result = {}
local fields = {
	picture = 2,
	name = 3,
	effect = 5,
	resultId = 1,
	desc = 4
}
local primaryKey = {
	"resultId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity194_option_result.onLoad(json)
	lua_activity194_option_result.configList, lua_activity194_option_result.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity194_option_result
