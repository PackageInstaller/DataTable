-- chunkname: @modules/configs/excel2json/lua_fight_buff_layer_effect.lua

module("modules.configs.excel2json.lua_fight_buff_layer_effect", package.seeall)

local lua_fight_buff_layer_effect = {}
local fields = {
	addLayerEffect = 8,
	lE = 21,
	skin = 2,
	delayTimeBeforeLoop = 15,
	releaseDestroyEffectTime = 19,
	addLayerEffectRoot = 9,
	addLayerAudio = 7,
	destroyEffectAudio = 18,
	destroyEffectRoot = 17,
	destroyEffect = 16,
	releaseAddLayerEffectTime = 10,
	loopEffectAudio = 6,
	createEffect = 11,
	releaseCreateEffectTime = 14,
	loopEffectRoot = 5,
	layer = 3,
	hideEffectWhenBigSkill = 22,
	hideEffectWhenPlaying = 20,
	loopEffect = 4,
	id = 1,
	createAudio = 13,
	createEffectRoot = 12
}
local primaryKey = {
	"id",
	"skin",
	"layer"
}
local mlStringKey = {}

function lua_fight_buff_layer_effect.onLoad(json)
	lua_fight_buff_layer_effect.configList, lua_fight_buff_layer_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_buff_layer_effect
