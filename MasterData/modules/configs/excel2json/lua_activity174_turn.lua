-- chunkname: @modules/configs/excel2json/lua_activity174_turn.lua

module("modules.configs.excel2json.lua_activity174_turn", package.seeall)

local lua_activity174_turn = {}
local fields = {
	groupNum = 7,
	name = 6,
	turn = 2,
	activityId = 1,
	endless = 9,
	shopLevel = 8,
	bag = 5,
	matchCoin = 11,
	point = 10,
	coin = 3,
	winCoin = 4
}
local primaryKey = {
	"activityId",
	"turn"
}
local mlStringKey = {
	name = 1
}

function lua_activity174_turn.onLoad(json)
	lua_activity174_turn.configList, lua_activity174_turn.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity174_turn
