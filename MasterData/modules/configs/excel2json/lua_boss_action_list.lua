-- chunkname: @modules/configs/excel2json/lua_boss_action_list.lua

module("modules.configs.excel2json.lua_boss_action_list", package.seeall)

local lua_boss_action_list = {}
local fields = {
	actionId = 1,
	actionId3 = 5,
	actionId7 = 9,
	actionId4 = 6,
	actionId10 = 12,
	actionId5 = 7,
	actionId6 = 8,
	circle = 2,
	actionId8 = 10,
	actionId1 = 3,
	actionId9 = 11,
	actionId2 = 4
}
local primaryKey = {
	"actionId"
}
local mlStringKey = {}

function lua_boss_action_list.onLoad(json)
	lua_boss_action_list.configList, lua_boss_action_list.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_boss_action_list
