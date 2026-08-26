-- chunkname: @modules/configs/excel2json/lua_activity174_bot.lua

module("modules.configs.excel2json.lua_activity174_bot", package.seeall)

local lua_activity174_bot = {}
local fields = {
	role2 = 8,
	collection3 = 13,
	count = 6,
	collection1 = 11,
	season = 3,
	role3 = 9,
	enhance = 15,
	collection4 = 14,
	role1 = 7,
	collection2 = 12,
	role4 = 10,
	id = 1,
	robotId = 4,
	activityId = 2,
	level = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity174_bot.onLoad(json)
	lua_activity174_bot.configList, lua_activity174_bot.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity174_bot
