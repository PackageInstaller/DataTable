-- chunkname: @modules/configs/excel2json/lua_assassin_stealth_mission.lua

module("modules.configs.excel2json.lua_assassin_stealth_mission", package.seeall)

local lua_assassin_stealth_mission = {}
local fields = {
	tips = 7,
	type = 3,
	param = 4,
	refresh1 = 8,
	random = 10,
	trigger = 6,
	desc = 5,
	next_mission = 2,
	id = 1,
	refresh2 = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	tips = 2,
	desc = 1
}

function lua_assassin_stealth_mission.onLoad(json)
	lua_assassin_stealth_mission.configList, lua_assassin_stealth_mission.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_assassin_stealth_mission
