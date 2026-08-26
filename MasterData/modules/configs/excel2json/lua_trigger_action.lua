-- chunkname: @modules/configs/excel2json/lua_trigger_action.lua

module("modules.configs.excel2json.lua_trigger_action", package.seeall)

local lua_trigger_action = {}
local fields = {
	param15 = 17,
	param1 = 3,
	actionType = 2,
	param12 = 14,
	param8 = 10,
	param6 = 8,
	param5 = 7,
	param2 = 4,
	param14 = 16,
	param13 = 15,
	param9 = 11,
	param7 = 9,
	param11 = 13,
	param10 = 12,
	id = 1,
	param4 = 6,
	param3 = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_trigger_action.onLoad(json)
	lua_trigger_action.configList, lua_trigger_action.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_trigger_action
