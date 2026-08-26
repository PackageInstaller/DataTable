-- chunkname: @modules/configs/excel2json/lua_skill_buff.lua

module("modules.configs.excel2json.lua_skill_buff", package.seeall)

local lua_skill_buff = {}
local fields = {
	triggerAudio = 20,
	name = 2,
	desc = 3,
	duringTime = 6,
	effectCount = 7,
	isNoShow = 4,
	animationName = 14,
	mat = 15,
	bloommat = 16,
	delEffect = 22,
	triggerEffect = 18,
	delEffectHangPoint = 23,
	effectHangPoint = 13,
	features = 8,
	triggerAnimationName = 21,
	delAudio = 24,
	delAnimator = 25,
	effect = 11,
	audio = 17,
	typeId = 9,
	effectloop = 12,
	iconId = 10,
	triggerEffectHangPoint = 19,
	isGoodBuff = 5,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_skill_buff.onLoad(json)
	lua_skill_buff.configList, lua_skill_buff.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_skill_buff
