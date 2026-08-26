-- chunkname: @modules/configs/excel2json/lua_monster_group.lua

module("modules.configs.excel2json.lua_monster_group", package.seeall)

local lua_monster_group = {}
local fields = {
	bossId = 8,
	stanceId = 7,
	bgm = 10,
	appearMonsterId = 11,
	sp2Monster = 5,
	appearTimeline = 12,
	sp2Supporter = 6,
	spMonster = 3,
	appearCameraPos = 13,
	aiId = 9,
	spSupporter = 4,
	id = 1,
	monster = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_monster_group.onLoad(json)
	lua_monster_group.configList, lua_monster_group.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_monster_group
