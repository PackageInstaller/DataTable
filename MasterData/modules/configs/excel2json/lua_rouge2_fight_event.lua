-- chunkname: @modules/configs/excel2json/lua_rouge2_fight_event.lua

module("modules.configs.excel2json.lua_rouge2_fight_event", package.seeall)

local lua_rouge2_fight_event = {}
local fields = {
	interactive = 3,
	failInteractive = 5,
	title = 2,
	fightDesc = 8,
	eliteFightDesc = 9,
	dieTwice = 4,
	achievement = 10,
	episodeId = 1,
	fightTaskId = 11,
	monsterMask = 7,
	isChangeScene = 6
}
local primaryKey = {
	"episodeId"
}
local mlStringKey = {
	eliteFightDesc = 2,
	fightDesc = 1
}

function lua_rouge2_fight_event.onLoad(json)
	lua_rouge2_fight_event.configList, lua_rouge2_fight_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_fight_event
