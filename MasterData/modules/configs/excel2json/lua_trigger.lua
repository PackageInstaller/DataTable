-- chunkname: @modules/configs/excel2json/lua_trigger.lua

module("modules.configs.excel2json.lua_trigger", package.seeall)

local lua_trigger = {}
local fields = {
	id = 1,
	param2 = 8,
	param4 = 10,
	param1 = 7,
	param8 = 14,
	limitOneTurn = 6,
	limit = 5,
	param7 = 13,
	triggerType = 3,
	param6 = 12,
	param10 = 16,
	param5 = 11,
	battleId = 2,
	actionList = 4,
	param9 = 15,
	param3 = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_trigger.onLoad(json)
	lua_trigger.configList, lua_trigger.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_trigger
