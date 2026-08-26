-- chunkname: @modules/configs/excel2json/lua_activity174_test_bot.lua

module("modules.configs.excel2json.lua_activity174_test_bot", package.seeall)

local lua_activity174_test_bot = {}
local fields = {
	collection3 = 9,
	collection4 = 10,
	count = 2,
	collection1 = 7,
	costCoin = 12,
	role3 = 5,
	enhance = 11,
	role1 = 3,
	collection2 = 8,
	role4 = 6,
	robotId = 1,
	role2 = 4
}
local primaryKey = {
	"robotId"
}
local mlStringKey = {}

function lua_activity174_test_bot.onLoad(json)
	lua_activity174_test_bot.configList, lua_activity174_test_bot.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity174_test_bot
