-- chunkname: @modules/configs/excel2json/lua_fight_buff_layer_effect_nana.lua

module("modules.configs.excel2json.lua_fight_buff_layer_effect_nana", package.seeall)

local lua_fight_buff_layer_effect_nana = {}
local fields = {
	effectRoot = 5,
	effect = 4,
	effectAudio = 6,
	skinId = 2,
	id = 1,
	duration = 7,
	layer = 3
}
local primaryKey = {
	"id",
	"skinId",
	"layer"
}
local mlStringKey = {}

function lua_fight_buff_layer_effect_nana.onLoad(json)
	lua_fight_buff_layer_effect_nana.configList, lua_fight_buff_layer_effect_nana.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_buff_layer_effect_nana
