-- chunkname: @modules/configs/excel2json/lua_partygame_decision.lua

module("modules.configs.excel2json.lua_partygame_decision", package.seeall)

local lua_partygame_decision = {}
local fields = {
	pos3 = 4,
	pos1 = 3,
	pos7 = 6,
	pos5 = 5,
	id = 1,
	group = 2,
	pos9 = 7
}
local primaryKey = {
	"id",
	"group"
}
local mlStringKey = {}

function lua_partygame_decision.onLoad(json)
	lua_partygame_decision.configList, lua_partygame_decision.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_partygame_decision
