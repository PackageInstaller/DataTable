-- chunkname: @modules/configs/excel2json/lua_arcade_effects.lua

module("modules.configs.excel2json.lua_arcade_effects", package.seeall)

local lua_arcade_effects = {}
local fields = {
	triggerAudio = 3,
	isNearestGrid = 6,
	triggerEffects = 4,
	isFromBorder = 9,
	effectsOffset = 11,
	effectsRotationType = 10,
	effectsScale = 12,
	triggerAnimation = 2,
	speed = 7,
	needShake = 13,
	direction = 8,
	uiEffect = 14,
	id = 1,
	isPlayOnGrid = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_arcade_effects.onLoad(json)
	lua_arcade_effects.configList, lua_arcade_effects.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_effects
