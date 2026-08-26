-- chunkname: @modules/configs/excel2json/lua_task_season_fight.lua

module("modules.configs.excel2json.lua_task_season_fight", package.seeall)

local lua_task_season_fight = {}
local fields = {
	fightId = 3,
	seasonId = 2,
	params = 5,
	id = 1,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_task_season_fight.onLoad(json)
	lua_task_season_fight.configList, lua_task_season_fight.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_task_season_fight
