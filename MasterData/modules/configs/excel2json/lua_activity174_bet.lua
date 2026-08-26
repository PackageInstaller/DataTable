-- chunkname: @modules/configs/excel2json/lua_activity174_bet.lua

module("modules.configs.excel2json.lua_activity174_bet", package.seeall)

local lua_activity174_bet = {}
local fields = {
	ratio = 3,
	activityId = 1,
	level = 2
}
local primaryKey = {
	"activityId",
	"level"
}
local mlStringKey = {}

function lua_activity174_bet.onLoad(json)
	lua_activity174_bet.configList, lua_activity174_bet.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity174_bet
