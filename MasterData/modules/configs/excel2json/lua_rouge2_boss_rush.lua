-- chunkname: @modules/configs/excel2json/lua_rouge2_boss_rush.lua

module("modules.configs.excel2json.lua_rouge2_boss_rush", package.seeall)

local lua_rouge2_boss_rush = {}
local fields = {
	reward = 7,
	tag = 5,
	bossIcon = 3,
	tabIcon = 4,
	levelId = 2,
	resultBossIcon = 8,
	id = 1,
	battleInfo = 6,
	resultTitleIcon = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	tag = 1,
	battleInfo = 2
}

function lua_rouge2_boss_rush.onLoad(json)
	lua_rouge2_boss_rush.configList, lua_rouge2_boss_rush.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_boss_rush
