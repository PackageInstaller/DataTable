-- chunkname: @modules/configs/excel2json/lua_tower_assist_boss_change.lua

module("modules.configs.excel2json.lua_tower_assist_boss_change", package.seeall)

local lua_tower_assist_boss_change = {}
local fields = {
	bossId = 1,
	activeSkills = 5,
	passiveSkills = 6,
	skinId = 3,
	form = 2,
	coldTime = 4,
	replacePassiveSkills = 7,
	resMaxVal = 8
}
local primaryKey = {
	"bossId",
	"form"
}
local mlStringKey = {}

function lua_tower_assist_boss_change.onLoad(json)
	lua_tower_assist_boss_change.configList, lua_tower_assist_boss_change.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_assist_boss_change
