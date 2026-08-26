-- chunkname: @modules/configs/excel2json/lua_fight_buff_type_id_2_scene_effect.lua

module("modules.configs.excel2json.lua_fight_buff_type_id_2_scene_effect", package.seeall)

local lua_fight_buff_type_id_2_scene_effect = {}
local fields = {
	reverseX = 4,
	effect = 2,
	delEffect = 5,
	audio = 7,
	id = 1,
	delAudio = 8,
	pos = 3,
	delTime = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_buff_type_id_2_scene_effect.onLoad(json)
	lua_fight_buff_type_id_2_scene_effect.configList, lua_fight_buff_type_id_2_scene_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_buff_type_id_2_scene_effect
