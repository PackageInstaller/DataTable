-- chunkname: @modules/configs/excel2json/lua_fight_buff_layer_effect_enemy_skin.lua

module("modules.configs.excel2json.lua_fight_buff_layer_effect_enemy_skin", package.seeall)

local lua_fight_buff_layer_effect_enemy_skin = {}
local fields = {
	releaseCreateEffectTime = 15,
	addLayerEffectRoot = 10,
	hideWhenPlayTimeline = 6,
	delayTimeBeforeLoop = 16,
	releaseDestroyEffectTime = 20,
	skin = 2,
	addLayerAudio = 8,
	destroyEffect = 17,
	destroyEffectRoot = 18,
	addLayerEffect = 9,
	releaseAddLayerEffectTime = 11,
	destroyEffectAudio = 19,
	createEffect = 12,
	loopEffectAudio = 7,
	loopEffectRoot = 5,
	layer = 3,
	loopEffect = 4,
	id = 1,
	createAudio = 14,
	createEffectRoot = 13
}
local primaryKey = {
	"id",
	"skin",
	"layer"
}
local mlStringKey = {}

function lua_fight_buff_layer_effect_enemy_skin.onLoad(json)
	lua_fight_buff_layer_effect_enemy_skin.configList, lua_fight_buff_layer_effect_enemy_skin.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_buff_layer_effect_enemy_skin
