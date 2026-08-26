-- chunkname: @modules/configs/excel2json/lua_activity205_dicegoal.lua

module("modules.configs.excel2json.lua_activity205_dicegoal", package.seeall)

local lua_activity205_dicegoal = {}
local fields = {
	winRewardId = 3,
	goaldesc = 8,
	hardType = 2,
	goalname = 7,
	iconRes = 9,
	weight = 10,
	goalRange = 6,
	failRewardId = 4,
	id = 1,
	bindingDice = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	goalname = 1,
	goaldesc = 2
}

function lua_activity205_dicegoal.onLoad(json)
	lua_activity205_dicegoal.configList, lua_activity205_dicegoal.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity205_dicegoal
