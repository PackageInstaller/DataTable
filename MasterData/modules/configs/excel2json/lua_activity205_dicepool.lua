-- chunkname: @modules/configs/excel2json/lua_activity205_dicepool.lua

module("modules.configs.excel2json.lua_activity205_dicepool", package.seeall)

local lua_activity205_dicepool = {}
local fields = {
	iconRes = 7,
	name = 4,
	winDice = 3,
	dicePoints = 2,
	id = 1,
	weight = 6,
	desc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity205_dicepool.onLoad(json)
	lua_activity205_dicepool.configList, lua_activity205_dicepool.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity205_dicepool
