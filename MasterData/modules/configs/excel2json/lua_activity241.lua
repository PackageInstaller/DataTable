-- chunkname: @modules/configs/excel2json/lua_activity241.lua

module("modules.configs.excel2json.lua_activity241", package.seeall)

local lua_activity241 = {}
local fields = {
	ticketCurrencyId = 4,
	ticketLimit = 5,
	voteId = 6,
	dailyTicket = 3,
	openDays = 2,
	activityId = 1
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}

function lua_activity241.onLoad(json)
	lua_activity241.configList, lua_activity241.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity241
