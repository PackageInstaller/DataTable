-- chunkname: @modules/configs/excel2json/lua_activity191_bot.lua

module("modules.configs.excel2json.lua_activity191_bot", package.seeall)

local lua_activity191_bot = {}
local fields = {
	enhance = 15,
	role3 = 5,
	collection3 = 13,
	prepareRole3 = 9,
	prepareRole1 = 7,
	rank = 17,
	powerInitial = 16,
	role1 = 3,
	prepareRole2 = 8,
	activityId = 2,
	role2 = 4,
	prepareRole4 = 10,
	collection1 = 11,
	collection4 = 14,
	collection2 = 12,
	role4 = 6,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity191_bot.onLoad(json)
	lua_activity191_bot.configList, lua_activity191_bot.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity191_bot
