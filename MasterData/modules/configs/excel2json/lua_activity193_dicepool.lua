-- chunkname: @modules/configs/excel2json/lua_activity193_dicepool.lua

module("modules.configs.excel2json.lua_activity193_dicepool", package.seeall)

local lua_activity193_dicepool = {}
local fields = {
	dicePoints = 2,
	name = 4,
	winDice = 3,
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

function lua_activity193_dicepool.onLoad(json)
	lua_activity193_dicepool.configList, lua_activity193_dicepool.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity193_dicepool
