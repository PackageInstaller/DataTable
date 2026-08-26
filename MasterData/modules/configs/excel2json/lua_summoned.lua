-- chunkname: @modules/configs/excel2json/lua_summoned.lua

module("modules.configs.excel2json.lua_summoned", package.seeall)

local lua_summoned = {}
local fields = {
	group = 4,
	enterTime = 14,
	includeTypes = 5,
	closeTime = 15,
	enterAudio = 16,
	aniEffect = 10,
	maxLevel = 3,
	skills = 6,
	uniqueSkills = 7,
	closeAudio = 17,
	level = 2,
	stanceId = 9,
	closeEffect = 13,
	enterEffect = 11,
	additionRule = 8,
	loopEffect = 12,
	id = 1
}
local primaryKey = {
	"id",
	"level"
}
local mlStringKey = {}

function lua_summoned.onLoad(json)
	lua_summoned.configList, lua_summoned.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_summoned
