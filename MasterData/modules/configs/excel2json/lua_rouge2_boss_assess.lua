-- chunkname: @modules/configs/excel2json/lua_rouge2_boss_assess.lua

module("modules.configs.excel2json.lua_rouge2_boss_assess", package.seeall)

local lua_rouge2_boss_assess = {}
local fields = {
	spriteName = 4,
	needScore = 3,
	strLevel = 2,
	isHard = 6,
	bossIcon = 5,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}

function lua_rouge2_boss_assess.onLoad(json)
	lua_rouge2_boss_assess.configList, lua_rouge2_boss_assess.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_boss_assess
