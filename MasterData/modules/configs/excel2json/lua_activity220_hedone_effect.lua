-- chunkname: @modules/configs/excel2json/lua_activity220_hedone_effect.lua

module("modules.configs.excel2json.lua_activity220_hedone_effect", package.seeall)

local lua_activity220_hedone_effect = {}
local fields = {
	hitAudio = 16,
	lifeRule = 8,
	lifeParam = 9,
	effectId = 1,
	entityRes = 5,
	triggerInterval = 10,
	range = 11,
	effectGroup = 2,
	valueMul = 12,
	effectType = 3,
	triggerEffect = 13,
	triggerEffectDuration = 14,
	isDetachedEff = 6,
	hitEffect = 15,
	effectParam = 4,
	ignoreSelf = 7
}
local primaryKey = {
	"effectId"
}
local mlStringKey = {}

function lua_activity220_hedone_effect.onLoad(json)
	lua_activity220_hedone_effect.configList, lua_activity220_hedone_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_hedone_effect
