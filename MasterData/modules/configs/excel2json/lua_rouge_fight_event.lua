-- chunkname: @modules/configs/excel2json/lua_rouge_fight_event.lua

module("modules.configs.excel2json.lua_rouge_fight_event", package.seeall)

local lua_rouge_fight_event = {}
local fields = {
	interactive = 7,
	title = 2,
	versionInteractive = 9,
	type = 3,
	versionEvent = 10,
	advanceInteractive = 8,
	bossMask = 13,
	episodeId = 4,
	versionEpisode = 5,
	monsterMask = 12,
	id = 1,
	isChangeScene = 11,
	bossDesc = 14,
	episodeIdInstead = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	bossDesc = 1
}

function lua_rouge_fight_event.onLoad(json)
	lua_rouge_fight_event.configList, lua_rouge_fight_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_fight_event
