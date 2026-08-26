-- chunkname: @modules/configs/excel2json/lua_boss_action.lua

module("modules.configs.excel2json.lua_boss_action", package.seeall)

local lua_boss_action = {}
local fields = {
	battleId = 1,
	monsterId = 2,
	monsterSpeed = 3,
	actionId = 4
}
local primaryKey = {
	"battleId",
	"monsterId"
}
local mlStringKey = {}

function lua_boss_action.onLoad(json)
	lua_boss_action.configList, lua_boss_action.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_boss_action
