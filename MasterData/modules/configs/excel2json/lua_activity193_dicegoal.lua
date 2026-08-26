-- chunkname: @modules/configs/excel2json/lua_activity193_dicegoal.lua

module("modules.configs.excel2json.lua_activity193_dicegoal", package.seeall)

local lua_activity193_dicegoal = {}
local fields = {
	goalname = 7,
	goaldesc = 8,
	lossrewards = 4,
	hardType = 2,
	mattername = 9,
	victoryrewards = 3,
	weight = 10,
	goalRange = 6,
	id = 1,
	bindingDice = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	mattername = 3,
	goaldesc = 2,
	goalname = 1
}

function lua_activity193_dicegoal.onLoad(json)
	lua_activity193_dicegoal.configList, lua_activity193_dicegoal.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity193_dicegoal
