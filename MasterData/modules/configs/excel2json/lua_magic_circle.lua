-- chunkname: @modules/configs/excel2json/lua_magic_circle.lua

module("modules.configs.excel2json.lua_magic_circle", package.seeall)

local lua_magic_circle = {}
local fields = {
	consumeNum = 7,
	enemySkills = 13,
	selfSkills = 12,
	closeTime = 22,
	selfAttrs = 10,
	enterAudio = 19,
	endSkills = 16,
	desc = 3,
	circleType = 8,
	enterTime = 18,
	consumeType = 6,
	name = 2,
	complexEffect = 9,
	closeAudio = 24,
	enemyBuff = 15,
	enemyAttrs = 11,
	selfBuff = 14,
	closeEffect = 21,
	enterEffect = 17,
	posArr = 25,
	round = 5,
	loopEffect = 20,
	id = 1,
	uiType = 4,
	closeAniName = 23
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_magic_circle.onLoad(json)
	lua_magic_circle.configList, lua_magic_circle.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_magic_circle
