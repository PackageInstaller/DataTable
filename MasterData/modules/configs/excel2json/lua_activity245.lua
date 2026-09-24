-- chunkname: @modules/configs/excel2json/lua_activity245.lua

module("modules.configs.excel2json.lua_activity245", package.seeall)

local lua_activity245 = {}
local fields = {
	cost = 6,
	ticketLimit = 5,
	ticketId = 2,
	loginActivityId = 7,
	dailyTicket = 4,
	firstTicket = 3,
	activityId = 1
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}

function lua_activity245.onLoad(json)
	lua_activity245.configList, lua_activity245.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity245
